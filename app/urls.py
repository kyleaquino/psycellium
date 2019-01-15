from django.urls import path
from django.contrib import admin
from django.conf import settings
from django.conf.urls.static import static
from django.contrib.auth import views as auth_views

from . import views

urlpatterns = [
    path('',views.index),
    path('home/',views.home),
    path('login/',views.login),
    path('register/',views.register),
    path('profile/',views.profile),
    path('wallet/',views.wallet),
    path('cooperatives/',views.cooperative),
    path('exchange/',views.exchange),
    path('settings/',views.settings),
    path('faq/',views.faq),
    path('logout/',views.logout),
]
