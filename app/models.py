from django.db import models
from django.contrib.auth.models import User as auth_user

class Cooperative(models.Model):
    name = models.CharField(max_length=25,)

    def __str__(self):
        return str(self.name)

class Profile(models.Model):
    user = models.OneToOneField(auth_user, on_delete=models.CASCADE,);
    eth_address = models.CharField(max_length=255,)
    coop = models.ForeignKey(Cooperative, null=True, on_delete=models.CASCADE)
    private_key = models.CharField(max_length=255, null=True)

    def __str__(self):
        return str(self.user)
