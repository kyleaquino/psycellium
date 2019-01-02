from django.db import models
from django.contrib.auth.models import User as auth_user

import datetime

class Grantee(models.Model):
    grant = models.CharField(max_length=255)
    amount = models.IntegerField(null=False)
    issue_date = models.DateField(null=True)

    def __str__(self):
        return str(self.grant)

class Cooperative(models.Model):
    name = models.CharField(max_length=25,)
    block_id = models.IntegerField(null=False)
    block_address = models.CharField(max_length=255, null=False)
    description = models.CharField(max_length=50, null=True)
    issueDate = models.DateField(null=False)
    investment_grantee = models.ForeignKey(Grantee, models.SET_NULL,blank=True,null=True,)

    def save(self, parameters=False, *args, **kwargs):
        date = datetime.date.today()
        print(parameters)
        self.block_id = parameters['id']
        self.block_address = parameters['address']
        self.issueDate = date

        super(Cooperative, self).save(*args, **kwargs)

    def __str__(self):
        return str(self.name)

class Ledger(models.Model):
    description = models.CharField(max_length=50, null=True)
    date = models.DateField(null=True)
    balance = models.IntegerField(null=False)

    def __str__(self):
        return str(self.description)


class Bank(models.Model):
    coop_id = models.ForeignKey(Cooperative, on_delete=models.CASCADE)
    ledger = models.ManyToManyField(Ledger)

    def __str__(self):
        return str(self.coop_id)

class Profile(models.Model):
    # ROLE_TYPES = (
    #     ('Member'),
    #     ('Staff'),
    #     ('Director'),
    #     ('Staff'),
    #     ('President'),
    #     ('Manager'),
    #     ('Secretary'),
    #     ('Auditor'),
    #     ('Treasurer')
    # )
    user = models.OneToOneField(auth_user, on_delete=models.CASCADE,)
    first_name = models.CharField(max_length=30, null=True)
    last_name = models.CharField(max_length=30,null=True)
    eth_address = models.CharField(max_length=255,)
    block_id = models.IntegerField(null=False)
    block_address = models.CharField(max_length=255, null=False)
    coop = models.ForeignKey(Cooperative, models.SET_NULL,blank=True,null=True,)
    private_key = models.CharField(max_length=255, null=True)
    # role = models.CharField(max_length=15,choices=ROLE_TYPES, default='Member')
    bank = models.ForeignKey(Bank, models.SET_NULL,blank=True,null=True,)

    def save(self, parameters=False, *args, **kwargs):
        print(parameters)
        self.block_id = parameters['id']
        self.block_address = parameters['address']

        super(Profile, self).save(*args, **kwargs)

    def __str__(self):
        return str(self.user)

class Loan(models.Model):
    STATUS_TYPES = (
        ('a','APPROVED'),
        ('p','PENDING'),
        ('r','REJECTED'),
    )
    user = models.ForeignKey(Profile, on_delete=models.CASCADE)
    coop_ID = models.ForeignKey(Cooperative, on_delete=models.CASCADE)
    state =  models.CharField(max_length=1,choices=STATUS_TYPES, default='PENDING')
    amount = models.IntegerField(null=False)
    repaid = models.IntegerField(null=True)
    interest = models.IntegerField(null=False)
    issue_date = models.DateField(max_length=20,)
    due_date = models.DateField(max_length=20,)

    def __str__(self):
        return str("%s Loaned %d" % (user,amount))
