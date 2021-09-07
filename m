Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2DA40273D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Sep 2021 12:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242593AbhIGKfJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Sep 2021 06:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbhIGKfJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Sep 2021 06:35:09 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67C4C061575
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Sep 2021 03:34:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id l10so18602053lfg.4
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Sep 2021 03:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=I2FM/c/lyq+wiSWHr+eS3OSV6CCy3Zk/GIi/tQYaLjs=;
        b=O1RFMMbMhn5YYxRMFo/pU2yOk04ScgxFz8l4AdlEXpMeb6o0Vk2Crlko9JxzLSHOh8
         NprCfsymTaeJp1u6klmUl+/Ti6OqYbhYLCoSAzUmHZV6agDCO2yQ6oACWyHkM2zXd5sS
         ixgb/JpJfGkmI2zj33ROGhP1Z/BZiO6qBoXkB9bPaZIfJQF/lODEUPbURrE1ZHACim3Q
         DsCTMWfG6uiBoDrHsCN9+AMx3dmuVFS8Vp5WSEBo8CeYfAVqVdNgAtzQMTMimH4n7q4D
         efMflpQF7r3wXkqWVDLEkQdBs9RyyiHdYkfjLlmoczRGdOPdqTjQKQUZRgoy3AAcJ9h6
         Rcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=I2FM/c/lyq+wiSWHr+eS3OSV6CCy3Zk/GIi/tQYaLjs=;
        b=YfghlaXUd4jPIHTl7emoJyIGu+4T3/Myi/DQvOvD+17s2Znd7kaNbJgFRjeX0NfI9r
         EgX0N52f7tKQQYY5VaDSqvBXQCOP4bLLEAXOib+83GYJPn1LT5r+xSiQrRPwtXbFqQ3s
         C9xTGQ1/g4uMyro/RKCRXUgbpLye9ietLYA6nBto9dPxKyLcQHB7or7qr3ev7VhqPaKQ
         wydiS4OWEwk6penI+WEWB9c1/yD8W4IdcJFsD/9guG24Ew6T7vuvZr/RPYqZAJzr+yQO
         tqGU2FfwGwdlKKCGBVtd1/6wahrJxN/iBAdmr+Lgdv+PCIeAR4dQGzica3NF4eTK34Tc
         PNaQ==
X-Gm-Message-State: AOAM533E7GGj5CyXX2xoR+CtrvmB+bAeNRB3inup8tvgoj3FdMA1+6Ht
        0wjqbt4RDw6SdzqODZYU0vihsaxR+NqWB8jm+l8=
X-Google-Smtp-Source: ABdhPJx/GZ4eWjJh7CK4GmDTCAQYdn+1S1auvINGPbwOq33U/1Lu3oXlM+/1kHNe0QWgM2RhmdqBPlQ7dQdmBkAxu44=
X-Received: by 2002:a05:6512:3190:: with SMTP id i16mr11217714lfe.64.1631010839824;
 Tue, 07 Sep 2021 03:33:59 -0700 (PDT)
MIME-Version: 1.0
Reply-To: godwinppter@gmail.com
Sender: mrszoungranamonica@gmail.com
Received: by 2002:a05:6512:4013:0:0:0:0 with HTTP; Tue, 7 Sep 2021 03:33:59
 -0700 (PDT)
From:   Godwin Pete <godwinnpeter@gmail.com>
Date:   Tue, 7 Sep 2021 12:33:59 +0200
X-Google-Sender-Auth: 6iYJvM5QAYMDZ5gV-lTxzxgN3yU
Message-ID: <CAAB_Engc2Uz92cqKhGuCPpRbPkEs=ErddEjskf_nFsZKZwEVtw@mail.gmail.com>
Subject: =?UTF-8?Q?Responder_com_Urg=C3=AAncia?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Meu bom amigo,

S=C3=B3 quero saber se voc=C3=AA pode me ajudar a transferir o valor de (US=
 $ 3
milh=C3=B5es). Ap=C3=B3s a transfer=C3=AAncia, temos que compartilhar, 50% =
para mim e
50% para voc=C3=AA. Informe-me se voc=C3=AA puder me ajudar para que eu pos=
sa
fornecer mais informa=C3=A7=C3=B5es sobre a transfer=C3=AAncia. Espero que =
voc=C3=AA possa
trabalhar comigo honestamente?

obrigado
