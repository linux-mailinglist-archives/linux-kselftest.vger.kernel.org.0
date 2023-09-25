Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7187ADE61
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 20:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjIYSM4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 14:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIYSMz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 14:12:55 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823EC10F
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 11:12:46 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-578d0dcd4e1so4170377a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 11:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695665566; x=1696270366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KsRIBM7dOdcj87tvwe4EQo8GqJ5cXnTOsGKKYnAPAk4=;
        b=p+wkVPXVac2IdmsmXQNOMTyp2QGxdpZV3v/ms7JJKanYUFUYLKgISa5R1YS+SEeIIS
         18CeoB5wYm/sXkounIH9X9nPLVJnJ//R6FcgQTUUZAz81tTZF4aJWTqRaOO4yBhLJNo4
         VR8FNMHCD1A7CH4kYo7DDFXZMYwjcOosINnUgCrFlHY3CFqe1ROXIQ+0gjBdZ3er4D49
         eAw29SCzpnniBEQ9JSC5ykrydO+XY9ouTjHyVakOPsB5IQGH1Nio39p9sBHNlv12qwtg
         ef13lc71Tba9GoFQuOkwgHMcJ3MqjnfOx6CiGbhufL/4XMuXqc9EhOpw0uvzfrXKs/WS
         qeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695665566; x=1696270366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsRIBM7dOdcj87tvwe4EQo8GqJ5cXnTOsGKKYnAPAk4=;
        b=tLocskQn6ju8xL4ooZiO+CKYGdH2jnEFxPLTZYG9QTuTDc5h7YtipENWPh7G6/UlbV
         sMEkI7oSLeTVXtsm9Sfs6l9PVuclaNwRwHzblVu8NG95CWily5I4l51C8EROEc6HMhqe
         4XwkKtyKI3+voNssHdPSy21OuIqpPMpnKvOKKf5RbDnxtYnh8q1tEuQPDSnRwmkNVM9D
         XO23R2BlDJMonizFV43/b3jUIfXkaLkrnPMLwR6HDbqbz3uqgE54zyrkXV151hn0hsMB
         TqTFii1RCQGJ1jGRp6MHv73gpmna32MNl6o08Rt5E92PwBNsP3TfUUHwClhLtxV9L62z
         F7bw==
X-Gm-Message-State: AOJu0Yx6+phK+9RHxpGtWki/XU4duB8yJhX3wopE1DoeAfMJgZtzoVRA
        Hj749DUg7rAgHvuG+FB+XJTc9g==
X-Google-Smtp-Source: AGHT+IEITTnOWUqqZd2QQfvnjuWHs46rWx0fKoZhZxeSiyP6OtQJWAzOWXHuNzwpn4hPs7lDCludXw==
X-Received: by 2002:a17:90b:2386:b0:267:faba:705 with SMTP id mr6-20020a17090b238600b00267faba0705mr3779807pjb.10.1695665565853;
        Mon, 25 Sep 2023 11:12:45 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id az14-20020a17090b028e00b002777001ee76sm949619pjb.18.2023.09.25.11.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:12:45 -0700 (PDT)
Date:   Mon, 25 Sep 2023 11:12:42 -0700
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
Message-ID: <ZRHNmuv8KzUU7u0r@ghost>
References: <20230925133859.1735879-1-apatel@ventanamicro.com>
 <20230925133859.1735879-3-apatel@ventanamicro.com>
 <ZRHH25IyJJLWSolC@ghost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRHH25IyJJLWSolC@ghost>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 25, 2023 at 10:48:11AM -0700, Charlie Jenkins wrote:
> On Mon, Sep 25, 2023 at 07:08:52PM +0530, Anup Patel wrote:
> > The Veyron-V1 CPU supports custom conditional arithmetic and
> > conditional-select/move operations referred to as XVentanaCondOps
> > extension. In fact, QEMU RISC-V also has support for emulating
> > XVentanaCondOps extension.
> > 
> > Let us detect XVentanaCondOps extension from ISA string available
> > through DT or ACPI.
> > 
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/hwcap.h | 1 +
> >  arch/riscv/kernel/cpufeature.c | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > index 0f520f7d058a..b7efe9e2fa89 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -59,6 +59,7 @@
> >  #define RISCV_ISA_EXT_ZIFENCEI		41
> >  #define RISCV_ISA_EXT_ZIHPM		42
> >  #define RISCV_ISA_EXT_SMSTATEEN		43
> > +#define RISCV_ISA_EXT_XVENTANACONDOPS	44
> >  
> >  #define RISCV_ISA_EXT_MAX		64
> >  
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 3755a8c2a9de..3a31d34fe709 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -182,6 +182,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
> >  	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> >  	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
> >  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> > +	__RISCV_ISA_EXT_DATA(xventanacondops, RISCV_ISA_EXT_XVENTANACONDOPS),
> >  };
> >  
> >  const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
> > -- 
> > 2.34.1
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> I worry about storing vendor extensions in this file. Because vendor
> extensions are not standardized, they can only be expected to have the
> desired behavior on hardware with the appropriate vendor id. A couple
> months ago I sent a patch to address this by handling vector extensions
> independently for each vendor [1]. I dropped the patch because it
> relied upon Heiko's T-Head vector extension support that he stopped
> working on. However, I can revive this patch so you can build off of it.
> 
> This scheme has the added benefit that vendors do not have to worry
> about conficting extensions, and the kernel does not have to act as a
> key registry for vendors.
> 
> What are your thoughts?
> 
> - Charlie
> 
> [1] https://lore.kernel.org/lkml/20230705-thead_vendor_extensions-v1-2-ad6915349c4d@rivosinc.com/
> 

I guess I don't need to revive the patch, you could just take the code
and update it for xventanacondops.

- Charlie
