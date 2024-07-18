#!/usr/bin/env python3
import re
import random
import string

# Função para gerar nomes aleatórios
def generate_random_name(length=8):
    letters = string.ascii_letters
    return ''.join(random.choice(letters) for _ in range(length))

# Função para encontrar todas as variáveis e funções no código
def find_identifiers(code):
    identifiers = set(re.findall(r'\b[a-zA-Z_][a-zA-Z0-9_]*\b', code))
    keywords = set(['int', 'float', 'return', 'void', 'if', 'else', 'for', 'while', 'do', 'switch', 'case', 'break', 'continue', 'typedef', 'struct', 'union', 'enum', 'const', 'volatile', 'static', 'extern', 'auto', 'register', 'goto', 'sizeof', 'signed', 'unsigned', 'long', 'short', 'double', 'char', 'bool', 'inline', 'restrict', 'default', 'sizeof'])
    identifiers -= keywords
    return identifiers

# Função para substituir identificadores no código por nomes aleatórios
def obfuscate_identifiers(code):
    identifiers = find_identifiers(code)
    obfuscation_map = {id: generate_random_name() for id in identifiers}
    obfuscated_code = code
    for id, obf_id in obfuscation_map.items():
        obfuscated_code = re.sub(r'\b' + id + r'\b', obfuscated_code)
    return obfuscated_code

# Função para inserir código morto
def insert_dead_code(code):
    dead_code = "\n".join([
        "if (false) {",
        "    int dummy = 0;",
        "    dummy++;",
        "}"
    ])
    return code + "\n" + dead_code

# Função para substituir literais
def obfuscate_literals(code):
    # Substituir números inteiros
    code = re.sub(r'\b\d+\b', lambda x: str(eval(x.group())), code)
    # Substituir strings
    code = re.sub(r'"[^"]*"', lambda x: '"' + ''.join(random.choice(string.printable) for _ in x.group()) + '"', code)
    return code

# Função para inserir comentários aleatórios
def insert_random_comments(code):
    comments = [
        "// This is a random comment",
        "// Another random comment",
        "// Yet another comment"
    ]
    lines = code.split('\n')
    for i in range(len(lines)):
        if random.random() < 0.1:  # 10% chance de inserir um comentário
            lines[i] += " " + random.choice(comments)
    return "\n".join(lines)

# Função para renomear arquivos de inclusão
def obfuscate_includes(code):
    includes = re.findall(r'#include\s+["<][^">]+[">]', code)
    obfuscation_map = {inc: f'#include "obf_{i}.h"' for i, inc in enumerate(includes)}
    for inc, obf_inc in obfuscation_map.items():
        code = code.replace(inc, obf_inc)
    return code

# Função para modificar o fluxo de controle
def obfuscate_control_flow(code):
    code = code.replace("if (", "if (true && ")
    code = code.replace("while (", "while (true && ")
    return code

# Função principal para ler o arquivo, ofuscar e salvar o resultado
def main(input_file, output_file):
    with open(input_file, 'r') as file:
        code = file.read()

    code = obfuscate_identifiers(code)
    code = insert_dead_code(code)
    code = obfuscate_literals(code)
    code = insert_random_comments(code)
    code = obfuscate_includes(code)
    code = obfuscate_control_flow(code)
    
    with open(output_file, 'w') as file:
        file.write(code)
    
    print(f"Code obfuscated and saved to {output_file}")

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description='Advanced C/C++ Code Obfuscator')
    parser.add_argument('input_file', help='The input C/C++ file to obfuscate')
    parser.add_argument('output_file', help='The output file to save the obfuscated code')
    args = parser.parse_args()
    
    main(args.input_file, args.output_file)
