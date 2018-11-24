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
