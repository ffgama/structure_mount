#!/bin/bash

cat "./bem_vindo.txt"

engineering_folder="engenharia_dados"
data_analytics_folder="data_analytics"

list_options_general=("Criar estrutura para este repositorio" "Utilizar estrutura existente" "Sair")
list_options_team=("Engenharia" "Data Analytics" "Sair")
list_options_paths_eng=("Projetos" "Automatizacoes" "Sair")
list_options_paths_da=("Projetos" "Experimentos" "Sair")

pattern_folder()
{
    echo -e "\nCriando uma padronizacao de diretorios para o time de $team_option"

    if [ "$team_option" == "Engenharia" ]
    then
        echo "Selecione uma das opcoes:"
        select team_eng_option in "${list_options_paths_eng[@]}"
        do 
            case $team_eng_option in 
            "Projetos")
            echo -e "Qual o nome para o diretorio do seu projeto: \n"
            read nome_projeto
            mkdir -p $engineering_folder/projetos/$nome_projeto/{etl,queries,docs}
            find ./$engineering_folder/projetos/$nome_projeto/ -type d -print | sed -e 's;[^/]*/; /;g;s;/ ;    ;g;s;^ /$;.;;s; /;|-- ;g'
            break
            ;;
            "Automatizacoes")
            echo -e "Informe um nome para a nova feature implantada: \n"
            read nome_automatizacao
            mkdir -p $engineering_folder/automatizacoes/$nome_automatizacao/{etl,queries,docs}
            find ./$engineering_folder/automatizacoes/$nome_automatizacao/ -type d -print | sed -e 's;[^/]*/; /;g;s;/ ;    ;g;s;^ /$;.;;s; /;|-- ;g'
            break
            ;;
            "Sair")
            echo "Saindo..."
            break
            ;;
            esac
        done
        elif [ "$team_option" == "Data Analytics" ]
        then
            echo "Selecione uma das opcoes:"
            select team_da_option in "${list_options_paths_da[@]}"
            do 
                case $team_da_option in 
                "Projetos")
                echo -e "Qual o nome para o diretorio do seu projeto: \n"
                read nome_projeto
                mkdir -p $data_analytics_folder/projetos/$nome_projeto/{etl,queries,qa,prod,eda,docs,data}
                find ./$data_analytics_folder/projetos/$nome_projeto/ -type d -print | sed -e 's;[^/]*/; /;g;s;/ ;    ;g;s;^ /$;.;;s; /;|-- ;g'
                break
                ;;
                "Experimentos")
                echo -e "Informe um nome para o experimento: \n"
                read nome_experimento
                mkdir -p $data_analytics_folder/experimentos/$nome_experimento/{etl,queries,eda,docs,data}
                find ./$data_analytics_folder/experimentos/$nome_experimento/ -type d -print | sed -e 's;[^/]*/; /;g;s;/ ;    ;g;s;^ /$;.;;s; /;|-- ;g'
                break
                ;;
                "Sair")
                echo "Saindo..."
                break
                ;;
                esac
            done
    else 
        exit 0
    fi

}

echo -e "\n==================================="
echo -e "O que voce deseja fazer?\n"
select gen_option in "${list_options_general[@]}"
do 
    case $gen_option in 
    "Criar estrutura para este repositorio")
        mkdir -p $engineering_folder/utils
        mkdir -p $engineering_folder/projetos/
        mkdir -p $engineering_folder/automatizacoes/
        mkdir -p $engineering_folder/tools/{big_query,aws,netsuite,utils}
        mkdir -p $data_analytics_folder/projetos/
        mkdir -p $data_analytics_folder/experimentos/
        mkdir -p $data_analytics_folder/ad_hocs/{etl,dashboards}

        echo "Arvore de diretorios criada com sucesso!"
        exit 0
        ;;
    "Utilizar estrutura existente")
    echo -e "\n==================================="
    echo -e "Qual seu time?\n"
    select team_option in "${list_options_team[@]}"
    do 
        case $team_option in 
        "Engenharia")
        pattern_folder $team_option
        break
        ;;
        "Data Analytics")
        pattern_folder $team_option
        break
        ;;
        "Sair")
        echo "Saindo..."
        exit 0
        ;;
        esac
    done
    break
    ;;
    "Sair")
    echo "Saindo..."
    exit 0
    ;;
    esac
done