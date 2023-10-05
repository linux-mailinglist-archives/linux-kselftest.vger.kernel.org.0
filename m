Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003C27B9F77
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 16:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjJEOYv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 10:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbjJEOXZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 10:23:25 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6DE59FE
        for <linux-kselftest@vger.kernel.org>; Wed,  4 Oct 2023 22:51:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-279013f9875so424241a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Oct 2023 22:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1696485060; x=1697089860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAn7kTF76MX4baCsjz/DD87LgbEJOFPnszS1gD87MLo=;
        b=ZXubW7/QRu9lfTWrHyJPGHvyKFEbmAjEGsA43lpb7Aa1B5q0XjQmR8aY6/JMLTFW6d
         LPSWr2Ds4/22GFtcQ/9KzR28OoFbFkzZuaf/Cr1iE7cPrQre79m0GookUWiIvChHBIyD
         nwi6+MkCNAcKtTcb18oWw9GtyZ4cxW2Or03HqHrNSE3OY4b777U/GoD/PFu5kxxK0VQi
         bFuyj6U47r4kUsPOlP4MYPFSubLZEb0fCnFgIByCYMoXS79N9lpdNH5AftJZuOuRPM3l
         bpY9o14EBhXWKmB5o1ri0uEmRyy+3BYQPNVsmgKJoz2UgwcKGHU96ndyPlbaFh5YHpaU
         ge2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696485060; x=1697089860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAn7kTF76MX4baCsjz/DD87LgbEJOFPnszS1gD87MLo=;
        b=DfLbolYpA7vFvJRAkDfmIG1rPzGTCAUBLpyr6yVYq8daj45SOZIgsUmNAVsutIKBUp
         qKau6B7mI1tf/FVkDC7t40acwWYF+u2ET3ks8TlKPuS10afsDOQMgLytv4HFzpiFYbDI
         oeJAk8gmYAmy7QFk3mH/J9l2+g5cJRaSixtdl3+LSDoBiJjiP4W6mzAt5MgdlU01sAMo
         VAiSafivql1AU2fQFStjDGfCIMsXyS+Bu4n44jGTU04y/W3k6cLj/u6/rCCDJJQ6zzlc
         fgkZId8h53jugsROheA2X6jorXq1BVTklzNU/EixbbQ4ZSpvBZdnPREpkmgEekOdVxR2
         KrYg==
X-Gm-Message-State: AOJu0YyuGhf73kIa31W9kzLexhe5OiMtBTzzRAor8aSZZvt/pgvML/c/
        b9HukCbBncZ9REXdDK54keJ6KwLNwljYDolV6DozMQ==
X-Google-Smtp-Source: AGHT+IEtGbIHdTfL2yZTTDLPgQj3me/hsvVuKvB4XaXv1nNxUCov3SGcpN7sdI1I388p/AKgKTr/0lfdATge9YktJw8=
X-Received: by 2002:a17:90b:a04:b0:26d:416a:b027 with SMTP id
 gg4-20020a17090b0a0400b0026d416ab027mr4208863pjb.31.1696485059836; Wed, 04
 Oct 2023 22:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231003035226.1945725-3-apatel@ventanamicro.com> <mhng-4ec1093a-4542-429e-a9f0-8a976cff9ac4@palmer-ri-x1c9>
In-Reply-To: <mhng-4ec1093a-4542-429e-a9f0-8a976cff9ac4@palmer-ri-x1c9>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 5 Oct 2023 11:20:48 +0530
Message-ID: <CAAhSdy2CxWw9ny7vdBoEzsXkm_J882NGKTDQ7BfykrjuB1QR+w@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] RISC-V: Detect Zicond from ISA string
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     apatel@ventanamicro.com, pbonzini@redhat.com,
        atishp@atishpatra.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shuah@kernel.org,
        ajones@ventanamicro.com, mchitale@ventanamicro.com,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 4, 2023 at 7:37=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com> =
wrote:
>
> On Mon, 02 Oct 2023 20:52:22 PDT (-0700), apatel@ventanamicro.com wrote:
> > The RISC-V integer conditional (Zicond) operation extension defines
> > standard conditional arithmetic and conditional-select/move operations
> > which are inspired from the XVentanaCondOps extension. In fact, QEMU
> > RISC-V also has support for emulating Zicond extension.
> >
> > Let us detect Zicond extension from ISA string available through
> > DT or ACPI.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  arch/riscv/include/asm/hwcap.h | 1 +
> >  arch/riscv/kernel/cpufeature.c | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index 0f520f7d058a..6fc51c1b34cf 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -59,6 +59,7 @@
> >  #define RISCV_ISA_EXT_ZIFENCEI               41
> >  #define RISCV_ISA_EXT_ZIHPM          42
> >  #define RISCV_ISA_EXT_SMSTATEEN              43
> > +#define RISCV_ISA_EXT_ZICOND         44
> >
> >  #define RISCV_ISA_EXT_MAX            64
> >
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index 3755a8c2a9de..e3803822ab5a 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -167,6 +167,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D=
 {
> >       __RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> >       __RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
> >       __RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
> > +     __RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
> >       __RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
> >       __RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
> >       __RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> Can we do a shared tag, though?  These will conflict.

Thanks Palmer.

I will provide a shared tag based on 6.6-rc5 sometime
next week. I hope this is okay for you.

Regards,
Anup

>
> --
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv
