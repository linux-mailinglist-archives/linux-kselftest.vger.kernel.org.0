Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72992446D6F
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Nov 2021 11:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhKFKiU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 6 Nov 2021 06:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhKFKiT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 6 Nov 2021 06:38:19 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48F4C061570
        for <linux-kselftest@vger.kernel.org>; Sat,  6 Nov 2021 03:35:38 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 1so19315317ljv.2
        for <linux-kselftest@vger.kernel.org>; Sat, 06 Nov 2021 03:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EFS/qJJq2u3i9HcnYLVF3IVNVvcjNp8ZLU4zo+G1R0U=;
        b=jPI5Y2ovKgnvpIxZxxNhhsQQvUHqwJky/69iEs+fioUsyBRrHiZBc5Hl9ejmq1kfEO
         WhYiJYSL6hdQkpKcRaA5op63eOyy5+Doml5L53dNBUie/9YmqxgVMkROMnds54xvPBcO
         8CAKgQLQO1+GjCdLNFzmGSlQpGGCc+6woocTPTJOyoamTjCp/VTOX/YORiC/OCmPzELU
         oAkIqhu0hNditpZ149xmjuUqeZblnXh0aGTjLw2vc0f60wvYZ27x99SUCnFTB/gpUzd0
         iPiV5SbaNWjNr5B49TOiFgLv8qNaj4hNBnB0iLHERkxQTt34cxbc7XC0qa4rgtjXCsGw
         tpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=EFS/qJJq2u3i9HcnYLVF3IVNVvcjNp8ZLU4zo+G1R0U=;
        b=IrSEaO/f6Ad14j0lQ/1iEeSO2slCUPARG49k1KJxR/hq6xzyMX1B1HS6g9KUIDCMMZ
         IrRwxn1PMTg/2oE8XJVhZG53seCE7Bh91V/TuLp02zosbt7AgFKBE0mtpxpqeY614Rt5
         vltGcilS294h3a/E3EV2NRiGAiD6oxmsvbFSQY+vnAQhZXroGDXrEJjUbsY03WtwmLlF
         v6LqQqETSHPqS3zVdhIMhsrzNWw0gJ9BhNa5xpUB9U/w5VfBxgZ8xpZdWTOSR8b4Dr3m
         rT3NtqmnkwugHmvq7QQTisbuu6lvFzR0IVgeJHiKWWf3bwc8j6ipeI4rkIh/AM7Unjvw
         VRVw==
X-Gm-Message-State: AOAM532PPfhMkCjvpVZuNTAMraD6pU3LVYVSZg2WQhV0aF5SqMrOTHka
        TxXGY6myqH9M69CWlBLWw7oKIQQxurvhIdVgmbU=
X-Google-Smtp-Source: ABdhPJyGHyFjB+3Yf5J1YqtUVcrfxCD93OevnpRqorNoaU6pto71SkVCnLd/F0/ohv+wBQ/LZdt8bNCrq/5I2vaEKes=
X-Received: by 2002:a2e:a791:: with SMTP id c17mr40614498ljf.304.1636194936725;
 Sat, 06 Nov 2021 03:35:36 -0700 (PDT)
MIME-Version: 1.0
Reply-To: godwinppter@gmail.com
Sender: mrs.salimanikie@gmail.com
Received: by 2002:a05:6512:1321:0:0:0:0 with HTTP; Sat, 6 Nov 2021 03:35:33
 -0700 (PDT)
From:   Godwin Pete <godwinnpeter@gmail.com>
Date:   Sat, 6 Nov 2021 11:35:33 +0100
X-Google-Sender-Auth: hDxXecFbbzd7CRcGgWMglnKifq8
Message-ID: <CAF+Yd-1EfNoJ3-FCUBT-+BODXqnG5vtLS9Jo=caBtHRpLAycdQ@mail.gmail.com>
Subject: =?UTF-8?B?w4kgdW0gcHJhemVyIGluZm9ybcOhLWxv?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Oi,

Como voc=C3=AA est=C3=A1? Estou muito feliz em inform=C3=A1-lo sobre meu su=
cesso. No
momento, estou fora do pa=C3=ADs para fazer um investimento com parte da
minha parte, ap=C3=B3s concluir a transfer=C3=AAncia com um empres=C3=A1rio=
 indiano.
Mas irei visitar o seu pa=C3=ADs, no pr=C3=B3ximo ano, ap=C3=B3s a conclus=
=C3=A3o do meu
projeto. Por favor, contacte a minha secret=C3=A1ria para enviar-lhe o
cart=C3=A3o (multibanco) que j=C3=A1 creditei no valor de ($ 300.000,00). B=
asta
entrar em contato com ela para ajud=C3=A1-lo a receber o cart=C3=A3o (ATM).=
 J=C3=A1
expliquei tudo para ela antes da minha viagem. Isso =C3=A9 o que posso
fazer por voc=C3=AA porque voc=C3=AA n=C3=A3o p=C3=B4de ajudar na transfer=
=C3=AAncia, mas pelo
fato de ser a pessoa com quem entrei em contato inicialmente para a
transfer=C3=AAncia. Decidi dar este ($ 300.000,00) como compensa=C3=A7=C3=
=A3o por ter
sido contatado inicialmente para a transfer=C3=AAncia. Sempre procuro fazer
a diferen=C3=A7a, no trato com as pessoas sempre que entro em contato com
elas. Tamb=C3=A9m estou tentando mostrar que sou uma pessoa bem diferente
das outras que podem ter um prop=C3=B3sito diferente dentro delas. Acredito
que voc=C3=AA me prestar=C3=A1 alguma ajuda quando eu, visitar seu pa=C3=AD=
s, para
outro investimento l=C3=A1. Portanto, entre em contato com minha secret=C3=
=A1ria
para obter o cart=C3=A3o. Os contatos dela s=C3=A3o os seguintes,

Nome completo: Sra., Jovita Dumuije,
Pa=C3=ADs: Burkina Faso
Email: jovitadumuije@gmail.com

Obrigado e espero por uma boa empresa com voc=C3=AA no futuro.

Godwin Peter,
