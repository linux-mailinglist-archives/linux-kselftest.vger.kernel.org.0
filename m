Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8B07AE475
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 06:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjIZEO6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 00:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjIZEO5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 00:14:57 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682B4EC
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 21:14:50 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-564b6276941so5635564a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 21:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695701690; x=1696306490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0Uz9m0Lpyj2Up3M7ljAj872e7YEcYxbkjr4aA3fxoM=;
        b=BIA5itrFYbRSfcwBtv6qT97Aph65YufArhdmkwRx98crNms3XpdOn4VlcnQ9vMxVE3
         f1NlRmv8u3zDOn0J/amHvwmiNQFK9OxpzV+WNg6spVsUXTeoUQ2nkXWg/pR1Tw94Jg4h
         CZHBBySlEsHnuai08b8HsQFGS+j8KLnECC4l6DoJ/2RLnNYzjpCT5N5vukhHO4x/XLjW
         L/XGI9xdY5AUo3NeKr2gh2FcGjJIhMbb/jb0yCYog1xYuAX0ZOBgcocozO/8eT183NKj
         TLYHSf6IAkgFRbrhozKuFaaGG5iAR3KEmBuhlZwNwdPpuCVpity/ZOMIY5gFKu83KY2y
         mWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695701690; x=1696306490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0Uz9m0Lpyj2Up3M7ljAj872e7YEcYxbkjr4aA3fxoM=;
        b=DJNP7jmFzli7/f8sAlEvTZMdDGGfensX0/f5SGOTkw30BSLAQ+sVTSeXjQ3EKFhaeC
         k43X4qw/2aFFELasct1El/154KEU05LWsInAzPawKteLHO2ndM+SsLhasN/D0KiCD85W
         hUJP5nVweXOlgFf8d1UvjrcMYc0ucn3QwYUHJOs16+5CIPQmw67u2D4asRIEPSFZf2Os
         QL21FS99bPgy3a0loT7M286mB23ZQ/YgQl7NSEuDVeIzWBPrCpmHju6Q5g2UvhBcD++M
         w0nsT+5SLavgry7mrHyfnJYQA5kQcgOKELPKlRjWE8Zo+XP6RxReZLN25XBxXnWKRF4z
         N8rQ==
X-Gm-Message-State: AOJu0YyVx7bKEZS62KSyoJXusEJ3DPCzKgzvR1VTKFPSgRvWOD6qbJin
        60HYh3AVHgPxnAh7P/DGdPUUt8O263d2yKQSotdjPg==
X-Google-Smtp-Source: AGHT+IGlrqzBQynTQ2ZOIqd8C6kbA5Z3vGoWbVXr0mUzMrb0AxrCfYzkhQU9qD+Ac1FboN94cMy4dyuKkXku+Op/CWc=
X-Received: by 2002:a05:6a20:a11e:b0:153:5832:b31b with SMTP id
 q30-20020a056a20a11e00b001535832b31bmr9309947pzk.53.1695701689540; Mon, 25
 Sep 2023 21:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230925133859.1735879-1-apatel@ventanamicro.com>
 <20230925133859.1735879-3-apatel@ventanamicro.com> <ZRHH25IyJJLWSolC@ghost> <CAK9=C2UoKxM+wknB4n8=okyXCCE6t0Vvz4jU_tBW6DMm6Vb3DA@mail.gmail.com>
In-Reply-To: <CAK9=C2UoKxM+wknB4n8=okyXCCE6t0Vvz4jU_tBW6DMm6Vb3DA@mail.gmail.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 26 Sep 2023 09:44:38 +0530
Message-ID: <CAK9=C2X9FpLTW4mDTNUWkoRLAXZonPzhrsOD5xrCfrqKSbaLhg@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] RISC-V: Detect XVentanaCondOps from ISA string
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 26, 2023 at 9:38=E2=80=AFAM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> On Mon, Sep 25, 2023 at 11:18=E2=80=AFPM Charlie Jenkins <charlie@rivosin=
c.com> wrote:
> >
> > On Mon, Sep 25, 2023 at 07:08:52PM +0530, Anup Patel wrote:
> > > The Veyron-V1 CPU supports custom conditional arithmetic and
> > > conditional-select/move operations referred to as XVentanaCondOps
> > > extension. In fact, QEMU RISC-V also has support for emulating
> > > XVentanaCondOps extension.
> > >
> > > Let us detect XVentanaCondOps extension from ISA string available
> > > through DT or ACPI.
> > >
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > ---
> > >  arch/riscv/include/asm/hwcap.h | 1 +
> > >  arch/riscv/kernel/cpufeature.c | 1 +
> > >  2 files changed, 2 insertions(+)
> > >
> > > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/=
hwcap.h
> > > index 0f520f7d058a..b7efe9e2fa89 100644
> > > --- a/arch/riscv/include/asm/hwcap.h
> > > +++ b/arch/riscv/include/asm/hwcap.h
> > > @@ -59,6 +59,7 @@
> > >  #define RISCV_ISA_EXT_ZIFENCEI               41
> > >  #define RISCV_ISA_EXT_ZIHPM          42
> > >  #define RISCV_ISA_EXT_SMSTATEEN              43
> > > +#define RISCV_ISA_EXT_XVENTANACONDOPS        44
> > >
> > >  #define RISCV_ISA_EXT_MAX            64
> > >
> > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufe=
ature.c
> > > index 3755a8c2a9de..3a31d34fe709 100644
> > > --- a/arch/riscv/kernel/cpufeature.c
> > > +++ b/arch/riscv/kernel/cpufeature.c
> > > @@ -182,6 +182,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =
=3D {
> > >       __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> > >       __RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
> > >       __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> > > +     __RISCV_ISA_EXT_DATA(xventanacondops, RISCV_ISA_EXT_XVENTANACON=
DOPS),
> > >  };
> > >
> > >  const size_t riscv_isa_ext_count =3D ARRAY_SIZE(riscv_isa_ext);
> > > --
> > > 2.34.1
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> > I worry about storing vendor extensions in this file. Because vendor
> > extensions are not standardized, they can only be expected to have the
> > desired behavior on hardware with the appropriate vendor id. A couple
>
> Assuming that a vendor extension is only available on hardware with
> appropriate vendor id is not correct because:
> 1) vendor A can allow vendor B to implement a custom extension
>     defined by vendor B

Typo correction: "vendor A can allow vendor B to implement a custom
extension defined by vendor A"

> 2) vendor A and vendor B can jointly develop a RISC-V CPU where
>     both vendors integrate their custom extensions.
>
> It is best to identify a vendor extension independently with a
> "X<vendor_name><extension_name>" string to keep it simple
> and scalable.
>
> Along these lines, each T-Head custom extension should have a
> "XThead<xyz>" name associated with it.
>
> > months ago I sent a patch to address this by handling vector extensions
> > independently for each vendor [1]. I dropped the patch because it
> > relied upon Heiko's T-Head vector extension support that he stopped
> > working on. However, I can revive this patch so you can build off of it=
.
>
> At least, the conditional operations don't need a hwprobe interface
> because an application is either compiled with or without conditional
> operations. In other words, effective use of conditional operation is
> only possible if compiler generates these instructions based on
> code patterns.
>
> >
> > This scheme has the added benefit that vendors do not have to worry
> > about conficting extensions, and the kernel does not have to act as a
> > key registry for vendors.
>
> How can vendor extensions conflict if they all follow the
> "X<vendor_name><extension_name>" naming scheme ?
>
> >
> > What are your thoughts?
> >
> > - Charlie
> >
> > [1] https://lore.kernel.org/lkml/20230705-thead_vendor_extensions-v1-2-=
ad6915349c4d@rivosinc.com/
> >
>
> Regards,
> Anup

Regards,
Anup
