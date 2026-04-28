# 1. Imagen base (Python ya instalado)
FROM python:3.14.4

# 2. Evita que Python genere archivos innecesarios
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# 3. Directorio de trabajo dentro del contenedor
WORKDIR /app

# 4. Copiar dependencias
COPY requirements.txt /app/

# 5. Instalar dependencias
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# 6. Copiar todo el código del proyecto
COPY . /app/

# 7. Exponer puerto de Django
EXPOSE 8000

# 8. Comando de arranque
CMD ["gunicorn", "core.wsgi:application", "--bind", "0.0.0.0:8000"]