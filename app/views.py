from django.shortcuts import render,redirect,get_object_or_404

from django.contrib import admin

from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django.contrib.auth import authenticate
from django.contrib.auth import login as auth_login
from django.contrib.auth import logout as auth_logout

# Form Import
from .forms import LoginForm, RegisterForm, CreateCoopForm, ProfileForm, JoinCoopForm
from .models import Cooperative, Profile

# Login, Register Routes
def index(request):
    # Coop = Cooperative.objects.all()
    profile = Profile.objects.all()
    args = {'profile' : profile}
    if request.user.is_authenticated:
        return redirect('/profile')
    return render(request, 'index.html', args)

def logout(request):
    if not request.user.is_authenticated:
        return index(request)
    auth_logout(request)
    return redirect('/home')

def profile(request):
    info = Profile.objects.get(user=request.user)
    members = Profile.objects.filter(coop=info.coop)
    print(members)
    args = {'user' : request.user, 'info' : info, 'members' : members}
    return render(request, 'profile.html', args)

def CreateCoop(request):
    form = CreateCoopForm()
    david = {'id' : '1111', 'address' : 'Address to'}
    if request.method == 'POST':
        form = CreateCoopForm(request.POST)
        if form.is_valid():
            instance = form.save(commit=False)
            instance.save(parameters = david)
            return redirect('/profile')
        else:
            form = CreateCoopForm()
    args = {'form' : form}
    return render(request, 'createcoop.html', args)

def JoinCoop(request):
    user = get_object_or_404(Profile,user=request.user)
    form = JoinCoopForm(instance=user)
    if request.method == 'POST':
        form = JoinCoopForm(request.POST,instance=user)
        if form.is_valid():
            profile = form.save(commit=False)
            print(profile.user)
            profile.save()
            return redirect('/profile')
        else:
            form = JoinCoopForm()
    args = {'form' : form}
    return render(request, 'joincoop.html', args)


def login(request):
    form = LoginForm()
    args = {'form' : form}
    if request.method == "POST":
        form = LoginForm(request.POST)
        if form.is_valid():
            username = form.cleaned_data['username']
            password = form.cleaned_data['password']
            user = authenticate(username=username, password=password)
            if user is not None:
                auth_login(request,user)
                error= None
                print('login')
                return redirect('/home')
        return render(request, 'login.html',args)
    elif request.user.is_authenticated:
        return redirect('home')
    return render(request, 'login.html',args)

def register(request):
    form = UserCreationForm()
    profileform = ProfileForm()
    args = {'form': form, 'profile' : profileform}
    if request.method == 'POST':
        form = UserCreationForm(request.POST)
        profileform = ProfileForm(request.POST)
        if form.is_valid() and profileform.is_valid():
            profile = profileform.save(commit=False)
            parameters = {'id': '1111', 'address': 'This is the address'}
            user = form.save()
            profile.user = user
            profile.save(parameters)
            username = form.cleaned_data.get('username')
            raw_password = form.cleaned_data.get('password1')
            user = authenticate(username=username, password=raw_password)
            auth_login(request, user)
            return redirect('/profile')
        else:
            print("errors : {}".format(profileform.errors.as_data()))
            print("errors : {}".format(form.errors.as_data()))
            form = UserCreationForm()
            return render(request, 'register.html', args)
    return render(request, 'register.html', args)

def Quit(request):
    Profile.objects.filter(user=request.user).update(coop=None)
    return redirect('/profile')
