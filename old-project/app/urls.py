from django.urls import path
from django.contrib import admin
from django.conf import settings
from django.conf.urls.static import static
from django.contrib.auth import views as auth_views

from . import views

urlpatterns = [
    path('',views.index, name='index'),
    path('home',views.home, name='index'),
    path('login',views.login, name='login'),
    path('register',views.register, name='register'),
    path('logout',views.logout, name='logout'),
    path('profile',views.profile, name='profile'),
    path('createCoop',views.CreateCoop, name='createCoop'),
    path('joincoop',views.JoinCoop, name='joincoop'),
    path('quit',views.Quit, name='Quit'),
]
