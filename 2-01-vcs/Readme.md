first line

В первом файле .gitignore мы не добавили ничего, поэтому он ни на что не повлияет
В файле .gitignore в каталоге terraform мы добавили:
**/.terraform/* - игнорируем все каталоги .terraform со всем содержимым внутри каталога terraform, включая вложенные
*.tfstate - все файлы с расширением .tfstate  в каталоге terraform 
*.tfstate.* - все файлы с расширением .tfstate.<любое количестов любых символов>  в каталоге terraform, например .tfstate.1
crash.log - файл crash.log в каталоге .terraform
crash.*.log - файлы crash.<любое количестов любых символов>.log, например crash.1.log в каталоге .terraform
и т.д.
