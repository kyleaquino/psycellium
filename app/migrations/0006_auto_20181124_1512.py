# Generated by Django 2.1.2 on 2018-11-24 07:12

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0005_auto_20181124_1452'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='cooperative',
            name='user',
        ),
        migrations.AddField(
            model_name='profile',
            name='coop',
            field=models.OneToOneField(null=True, on_delete=django.db.models.deletion.CASCADE, to='app.Cooperative'),
        ),
    ]
