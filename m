Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DA57AF9AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 06:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjI0Esd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 00:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjI0Err (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 00:47:47 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A5610CE
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 19:13:29 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-691c05bc5aaso8758539b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 19:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695780808; x=1696385608; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZV6WWLW/um6fjmDxBYmHw3kQW73zJt+fvsBsocXSqds=;
        b=DC8d5SUKAatSiQdlBhnd5VF3uy902y7PBvuSVQVWE7DHAzwMT2LVJdtRVQKWIMIT2j
         53Gp/cgLv3p7Wy7pJK4vGLZMV250o5YFrhnIRvhrk3IbkkDWHR3D/D2kiWdb5m8EvJrM
         gnrAAvM+y5lROMtXpstp4RevSM1+m2eGiY4M8r9kUUMjrsyGhLGcxTczj1eIPsLuNreu
         8AnUspd8OgN9AqkNB/vK7runY7jNlC7xbXjJUOta1iQ4yFBrKlJyB8Ez6bavloQJQj7I
         RAqd3wPrUpioJiNsIqcOvgE6HxwfLHcI1KIwXQCc5pBJq6uUx0t7/SZerQOCGSM4rrA+
         UrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695780808; x=1696385608;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZV6WWLW/um6fjmDxBYmHw3kQW73zJt+fvsBsocXSqds=;
        b=wNTY9u3CkVIq4sWsNaEbju5WumDunIdZ3TC9eKdk6vZ23QtiJ47qy1V4HxUmWqrQb2
         CjEpUpOFwtpK58hi8l+8EfoVaJbFCWpCABBInAESjzPkOsumT1yXta3E0ZuO730WTsJm
         yTbpLNwA6I2IaH+E4YEVxEHOtS2EFHVHc4jLfUpzWA9bsNvLV9woNKOwwo8haabmkXxk
         aL2jJFj/Q6lG5cky1A9wQfWFF8iV7QHTMKH9oW5yPAiEJcCFDGNA9LA50Su043IqFweV
         Qqy6muB8fE/e4Wxr42BfUFI7UhXfxmc7Gxx8PHdW+vWYeZFYzkNXc13w4UAD2U1+4WQn
         +W9w==
X-Gm-Message-State: AOJu0YxaGXG4U4OSIK8gA4oRn942+pyiuzVr6RMO+myiLt5EoM1ny6Fk
        dBXiLZl4JHIuoEUCoyGuu/SghA==
X-Google-Smtp-Source: AGHT+IE1uy7Z2/RTHVKKBhrojjBrMYzG+W9qZc3apbDrbDB/vlS2HSZCgLb+7NFBKhVe0YuAu/kyOA==
X-Received: by 2002:a05:6a00:cd5:b0:68c:49e4:bd71 with SMTP id b21-20020a056a000cd500b0068c49e4bd71mr709094pfv.34.1695780808529;
        Tue, 26 Sep 2023 19:13:28 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:6eef:9e73:7774:1855])
        by smtp.gmail.com with ESMTPSA id k12-20020aa7820c000000b0068fda1db80bsm10616571pfi.75.2023.09.26.19.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 19:13:28 -0700 (PDT)
Date:   Tue, 26 Sep 2023 19:13:24 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Anup Patel <apatel@ventanamicro.com>
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
Subject: Re: [PATCH v2 2/9] RISC-V: Detect XVentanaCondOps from ISA string
Message-ID: <ZROPxDPYGDcGm2J/@ghost>
References: <20230925133859.1735879-1-apatel@ventanamicro.com>
 <20230925133859.1735879-3-apatel@ventanamicro.com>
 <ZRHH25IyJJLWSolC@ghost>
 <CAK9=C2UoKxM+wknB4n8=okyXCCE6t0Vvz4jU_tBW6DMm6Vb3DA@mail.gmail.com>
 <CAK9=C2X9FpLTW4mDTNUWkoRLAXZonPzhrsOD5xrCfrqKSbaLhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9=C2X9FpLTW4mDTNUWkoRLAXZonPzhrsOD5xrCfrqKSbaLhg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 26, 2023 at 09:44:38AM +0530, Anup Patel wrote:
> On Tue, Sep 26, 2023 at 9:38 AM Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > On Mon, Sep 25, 2023 at 11:18 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > >
> > > On Mon, Sep 25, 2023 at 07:08:52PM +0530, Anup Patel wrote:
> > > > The Veyron-V1 CPU supports custom conditional arithmetic and
> > > > conditional-select/move operations referred to as XVentanaCondOps
> > > > extension. In fact, QEMU RISC-V also has support for emulating
> > > > XVentanaCondOps extension.
> > > >
> > > > Let us detect XVentanaCondOps extension from ISA string available
> > > > through DT or ACPI.
> > > >
> > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > > ---
> > > >  arch/riscv/include/asm/hwcap.h | 1 +
> > > >  arch/riscv/kernel/cpufeature.c | 1 +
> > > >  2 files changed, 2 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > > > index 0f520f7d058a..b7efe9e2fa89 100644
> > > > --- a/arch/riscv/include/asm/hwcap.h
> > > > +++ b/arch/riscv/include/asm/hwcap.h
> > > > @@ -59,6 +59,7 @@
> > > >  #define RISCV_ISA_EXT_ZIFENCEI               41
> > > >  #define RISCV_ISA_EXT_ZIHPM          42
> > > >  #define RISCV_ISA_EXT_SMSTATEEN              43
> > > > +#define RISCV_ISA_EXT_XVENTANACONDOPS        44
> > > >
> > > >  #define RISCV_ISA_EXT_MAX            64
> > > >
> > > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > > > index 3755a8c2a9de..3a31d34fe709 100644
> > > > --- a/arch/riscv/kernel/cpufeature.c
> > > > +++ b/arch/riscv/kernel/cpufeature.c
> > > > @@ -182,6 +182,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
> > > >       __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> > > >       __RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
> > > >       __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> > > > +     __RISCV_ISA_EXT_DATA(xventanacondops, RISCV_ISA_EXT_XVENTANACONDOPS),
> > > >  };
> > > >
> > > >  const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
> > > > --
> > > > 2.34.1
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >
> > > I worry about storing vendor extensions in this file. Because vendor
> > > extensions are not standardized, they can only be expected to have the
> > > desired behavior on hardware with the appropriate vendor id. A couple
> >
> > Assuming that a vendor extension is only available on hardware with
> > appropriate vendor id is not correct because:
> > 1) vendor A can allow vendor B to implement a custom extension
> >     defined by vendor B
> 
> Typo correction: "vendor A can allow vendor B to implement a custom
> extension defined by vendor A"
> 
> > 2) vendor A and vendor B can jointly develop a RISC-V CPU where
> >     both vendors integrate their custom extensions.
> >
> > It is best to identify a vendor extension independently with a
> > "X<vendor_name><extension_name>" string to keep it simple
> > and scalable.
> >
> > Along these lines, each T-Head custom extension should have a
> > "XThead<xyz>" name associated with it.
> >
> > > months ago I sent a patch to address this by handling vector extensions
> > > independently for each vendor [1]. I dropped the patch because it
> > > relied upon Heiko's T-Head vector extension support that he stopped
> > > working on. However, I can revive this patch so you can build off of it.
> >
> > At least, the conditional operations don't need a hwprobe interface
> > because an application is either compiled with or without conditional
> > operations. In other words, effective use of conditional operation is
> > only possible if compiler generates these instructions based on
> > code patterns.
> >

I was conflating hwprobe with hwcap when I was thinking about this.
However, I think it might still be beneficial to split out the vendor
extensions. It is possible for vendors to implement each other's
extensions but I don't expect that to be the average case. Because I do
not expect this to be the average case, riscv_isa_ext becomes needlessly
large as it has to contain the extensions of every vendor.

> > >
> > > This scheme has the added benefit that vendors do not have to worry
> > > about conficting extensions, and the kernel does not have to act as a
> > > key registry for vendors.
> >
> > How can vendor extensions conflict if they all follow the
> > "X<vendor_name><extension_name>" naming scheme ?
> >
> > >
> > > What are your thoughts?
> > >
> > > - Charlie
> > >
> > > [1] https://lore.kernel.org/lkml/20230705-thead_vendor_extensions-v1-2-ad6915349c4d@rivosinc.com/
> > >
> >
> > Regards,
> > Anup
> 
> Regards,
> Anup

- Charlie
