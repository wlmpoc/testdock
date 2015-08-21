int module3fun()
{
	FILE *fptr=NULL;
	char buff[200];
        fptr=fopen("/etc/os-release","r");
	fread(buff,sizeof(buff),1,fptr);
	printf("Release Details:\n%s",buff);
	fclose(fptr);
}
	
