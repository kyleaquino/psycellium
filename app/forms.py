from django import forms
from datetime import date
from django.contrib.auth.forms import UserCreationForm, UserChangeForm
from django.contrib.auth.models import User

from .models import Cooperative, Profile

class LoginForm(forms.Form):
    username = forms.CharField(label='username',)
    password = forms.CharField(label='password', widget=forms.PasswordInput())

class RegisterForm(UserCreationForm):
    first_name=forms.CharField(max_length=30,)
    last_name=forms.CharField(max_length=30)
    email=forms.CharField(max_length=254)

    class Meta:
        model = User
        fields=('username','first_name','last_name','email','password1','password2')

class CreateCoopForm(forms.ModelForm):
    class Meta:
        model = Cooperative
        fields = ('name','description')

        widgets = {
            'name': forms.TextInput(attrs={'class' : 'form-control', 'placeholder': 'Name'}),
            'description': forms.TextInput(attrs={'class' : 'form-control', 'placeholder': 'Description'}),
        }

class ProfileForm(forms.ModelForm):
    class Meta:
        model = Profile
        fields = ('first_name','last_name')

        widgets ={
            'first_name': forms.TextInput(attrs={'class' : 'form-control'}),
            'last_name': forms.TextInput(attrs={'class' : 'form-control'}),
        }

class JoinCoopForm(forms.ModelForm):
    class Meta:
        model = Profile
        fields = ('coop',)

        widgets = {
            'coop': forms.Select(attrs={'class' : 'form-control'}),
        }
