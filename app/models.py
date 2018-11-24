from django.db import models
from django.contrib.auth.models import User as auth_user

class Cooperative(models.Model):
    name = models.CharField(max_length=25,)
    block_id = models.IntegerField(max_lenght=25, null=False)
    block_address = model.CharField(max_lenght=255, null=False)
    description = model.CharField(max_lenght=50, null=True)
    issueDate = model.DateField(null=False)

    def __str__(self):
        return str(self.name)

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
    eth_address = models.CharField(max_length=255,)
    block_id = models.IntegerField(max_lenght=25, null=False)
    block_address = model.CharField(max_lenght=255, null=False)
    coop = models.ForeignKey(Cooperative, null=True, on_delete=models.CASCADE)
    private_key = models.CharField(max_length=255, null=True)
    # role = models.CharField(max_length=15,choices=ROLE_TYPES, default='Member')

    def __str__(self):
        return str(self.user)

class Ledger(models.Model):
    description = models.CharField(max_length=50, null=True)
    date = models.DateField(null=True)
    balance = models.IntegerField(null=False)

class Bank(models.Model):
    ledger = ManytoManyField(Ledger, on_delete=models.CASCADE,)

class HealthRecord(models.Model):
    patient = models.OneToOneField(auth_user,on_delete=models.CASCADE,)
    record = models.CharField(max_length=100,null=True)
    last_updated = models.DateField(null=True)

class Investment(models.Model):
    user = models.OneToOneField(auth_user,on_delete=models.CASCADE)
    amount = models.IntegerField(max_length=100,null=False)
    issue_date = models.DateField(null=True)
