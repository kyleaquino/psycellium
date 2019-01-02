from django.contrib import admin
from .models import Profile, Cooperative, Grantee, Ledger, Bank, Loan

# Register your models here.
admin.site.register(Profile)
admin.site.register(Cooperative)
admin.site.register(Grantee)
admin.site.register(Ledger)
admin.site.register(Bank)
admin.site.register(Loan)
