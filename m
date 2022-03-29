Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE914EB5E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Mar 2022 00:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbiC2WbS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Mar 2022 18:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbiC2WbS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Mar 2022 18:31:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF27A674EB;
        Tue, 29 Mar 2022 15:29:34 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i4so7955249wrb.5;
        Tue, 29 Mar 2022 15:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=HLiEC/wdnJKiJCMk1+3iYAaKgLSSPoAXeNjRxe/kiWveTFgb1IJOkyip1rRHwrq0dA
         UddIT91sb0UQkcr2KUewPqDjQo/rSZUAf+xrd/ltyzcMO0pT4U9B4oCUPprbKxs1UKOj
         /lonI2jS46+HsISMSL8ENCK+Ssjg6uVA6y9k3VtjY2EWIoRNEi9zdAczU18BUU9uchDS
         HTemADeXupacycDiUkuyWx0kUE2hwx0TaZpdld9MO7xCeKV+uF1+VrBsIEgNIlqh/jdO
         OswDxYTOcWdissg5oi/I14WLEXWu8RuoP2vzYlNyeGZ+lfM9ckc0JWySVPC0TLmgiAiq
         n4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=uoFGw1nSTdbPSPxLly2hdO7uu0wXPaRDNj/Fi9zxh6RhGzLCZGIgd4ZCWzUfMLj0Al
         u/VwxQSDAHC8S8fZ66OoPV0Z31umZgTZl3hQ6L+1ARcK6zoTyPs/vZ1ZuSBKbWhOYLY4
         uKTbsYA4rrlpUakpgA/8w6D8fBEkt/kcCbCSZnzF5PZwR1ZNehj2ZkgKMMjLCQmgljDY
         R5YIzQ7C4EPRTCRRuqECNx/21wWde16GvVH0z2OH8iMq4vy9qr6hsmFmWeXfcOhjOU/I
         uvg+3ka+3xAKA0tMCU1Io6lNhB2qSf5R0qzVCiZswrpVXzx585venf742kFlPymfd9uV
         mH3A==
X-Gm-Message-State: AOAM531R6/H8CVvUIi7yh7KXdXuhTg1NEJFBnP9my6xg5MioIZcEfO9i
        9CNz0y9AeTH38I/qu2jnVzaBcUUjWECabaoYKg8=
X-Google-Smtp-Source: ABdhPJxxekEfw+bWlQudxDCXTEqRGIEA4vxzUx0Q+AeXqElDZ+1+fuzJogxEmdAZ6TrZMSE05JiHHQ==
X-Received: by 2002:a5d:47cf:0:b0:203:ee1e:caf9 with SMTP id o15-20020a5d47cf000000b00203ee1ecaf9mr33513150wrc.563.1648592973506;
        Tue, 29 Mar 2022 15:29:33 -0700 (PDT)
Received: from [172.20.10.4] ([102.91.4.187])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d48d0000000b00205cf199abcsm2851970wrs.46.2022.03.29.15.29.26
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2022 15:29:32 -0700 (PDT)
Message-ID: <6243884c.1c69fb81.a7286.bccb@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Gefeliciteerd, er is geld aan je gedoneerd
To:     Recipients <adeboyejofolashade55@gmail.com>
From:   adeboyejofolashade55@gmail.com
Date:   Tue, 29 Mar 2022 23:29:18 +0100
Reply-To: mike.weirsky.foundation003@gmail.com
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_US_DOLLARS_3 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Beste begunstigde,

 Je hebt een liefdadigheidsdonatie van ($ 10.000.000,00) van Mr. Mike Weirs=
ky, een winnaar van een powerball-jackpotloterij van $ 273 miljoen.  Ik don=
eer aan 5 willekeurige personen als je deze e-mail ontvangt, dan is je e-ma=
il geselecteerd na een spin-ball. Ik heb vrijwillig besloten om het bedrag =
van $ 10 miljoen USD aan jou te doneren als een van de geselecteerde 5, om =
mijn winst te verifi=EBren
 =

  Vriendelijk antwoord op: mike.weirsky.foundation003@gmail.com
 Voor uw claim.
