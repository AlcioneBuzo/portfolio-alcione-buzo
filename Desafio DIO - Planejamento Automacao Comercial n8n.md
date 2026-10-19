# Desafio DIO — Planejamento de Automação Comercial com n8n

## Prompt final

Atue como especialista em n8n e ajude a planejar uma automação simples e modular de **prospecção comercial** para uma empresa de representação de alimentos.

**Objetivo:** organizar a descoberta de novos estabelecimentos e a preparação de cotações de produtos para conquistar novos clientes, mantendo a aprovação humana antes de qualquer contato.

**Público:** Alcione, responsável pela operação comercial e pela aprovação das cotações e mensagens.

**Ferramentas:** n8n Community Edition (Docker), Google Maps ou fonte comercial autorizada para localizar empresas, Google Sheets/Drive para organizar dados e WhatsApp Business para comunicação.

**Fluxo desejado:**
1. Criar uma base inicial de **500 potenciais clientes**, principalmente pizzarias e padarias, na região de São Paulo (até 100 km da Lapa), incluindo Santos, Guarujá e Bertioga.
2. Registrar nome do estabelecimento, categoria, endereço, telefone comercial e outras informações públicas relevantes, quando o uso for permitido. Evitar cadastros duplicados.
3. Selecionar até **30 novos estabelecimentos por dia útil**, de segunda a sexta-feira, para qualificação e possível contato.
4. Preparar uma cotação breve com **4 a 7 produtos**, como muçarela, calabresa e farinha de trigo, com preços previamente conferidos e autorizados. Não inventar preços ou condições comerciais.
5. Apresentar a Alcione a lista de destinatários e a cotação para **aprovação obrigatória**.
6. Após a aprovação, organizar o contato pelo **WhatsApp Business**, respeitando permissões, políticas da plataforma e limites aplicáveis. Como o WhatsApp Business comum no celular não oferece, por si só, disparo automático pelo n8n, prever **envio manual assistido** até que exista uma integração oficial autorizada.
7. Registrar no Google Sheets os contatos realizados, respostas e interessados, para evitar duplicidade e facilitar o acompanhamento comercial. Interromper contatos quando houver recusa ou pedido para não receber mensagens.

**Regras:** priorizar ferramentas gratuitas quando viável; não contatar a mesma empresa duas vezes no mesmo dia; não enviar mensagens sem aprovação; não presumir que dados públicos autorizam mensagens comerciais; proteger dados pessoais e comerciais; manter o projeto simples e possível de ampliar no futuro.

**O que preciso da sua resposta:** explique a sequência do fluxo, sugira os nós do n8n adequados (por exemplo, Schedule Trigger, Google Sheets, IF e Wait) e a função de cada um. Identifique separadamente as integrações que exigem permissão, configuração ou custo adicional. Nesta etapa, apresente somente o **planejamento**, sem executar envios reais.
