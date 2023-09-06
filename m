Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D35793DFF
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 15:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbjIFNsC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 09:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239101AbjIFNsB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 09:48:01 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DA319A5
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Sep 2023 06:47:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-402c46c49f4so35687465e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Sep 2023 06:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694008057; x=1694612857; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y8t/IGzui+H5qdVxzJl2s3G8bPpmqSY5irt+QEZLU50=;
        b=OofAM8NeGmrFU3yGzg+/P7Vi6tB2qIPvpWpmICWgqwMx20jyom6ml5Ng5Ar890N4BG
         6KsqlU2Mx2p+weJYfZPKPSV9KQOrXLkBqUQZGfYnAheHXYCKl81WYnWnQhuSQ9qslTfT
         kfRF7bcgIDzgACn0ZzuymwJ/uq1wIXDMADLlYl5dM3kjJClPwEKTOknupMx4wD5FZ9pD
         Z/5ejbirjOqhT6lP5ZxocyiMlTuzwequstg3n+ROEq884yVitExhw5g8EQDCp0TYajch
         Yd+WAm8pw7lB08bOpoPLnrqyYlMS+znn3lJA+ZbzqKgnQFLpu3Dw+GAYt65c30PZNosJ
         6hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694008057; x=1694612857;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8t/IGzui+H5qdVxzJl2s3G8bPpmqSY5irt+QEZLU50=;
        b=XjgjSCS6l5W9QDREix+bS14GKI9aWm97K3fspKhJr5G9iicNIsppLM9hcyPQawdGYs
         7X+tJxXYaGK7HCoyIWjX9M7Imc/rhnX4pRH6y/YePxJn3MJgBmegxgFPdIOtObQzk9uS
         +itcmkEJ2atw1Fq+C78YBzGZ4zhK5pV1ESPPaJr7elQD/AxVYZ7P5p4scSsILMzn3SDN
         dXW5Ss5Wi9MUhVUORl+/sbRjcvfU0SQ/lYdn5PCF3sBRTDEZKtlNee+NB24L5Nbam5OZ
         edRDFnqbS/Tliia69xv3Llhk6BPRjgt2NnuMP9gPG56sa73j/Sm+R38BXQEFf8j1Bm3d
         dLsw==
X-Gm-Message-State: AOJu0Yxch4I1W658C1Hna4PTbdrs/5q/QhtdEPF1MzfeLV/0/YHrwYVG
        VndSgPp78ui5qLgXdhqBJJ5kGA==
X-Google-Smtp-Source: AGHT+IH2baeDANzYLEU+6JGXtK6JPZZwhj4Y9FCTJIRzFumqNrzyHLa/aBqci+k9LlX/9np1HUfmTQ==
X-Received: by 2002:a5d:5087:0:b0:317:ef76:b773 with SMTP id a7-20020a5d5087000000b00317ef76b773mr2318629wrt.45.1694008056476;
        Wed, 06 Sep 2023 06:47:36 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id x12-20020a05600c21cc00b003fed78b03b4sm19716726wmj.20.2023.09.06.06.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:47:34 -0700 (PDT)
Date:   Wed, 6 Sep 2023 15:47:31 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <xiaobo55x@gmail.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        wchen <waylingii@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Lei Wang <lei4.wang@intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Thomas Huth <thuth@redhat.com>, Like Xu <likexu@tencent.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>,
        zhang songyi <zhang.songyi@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/8] tools: riscv: Add header file csr.h
Message-ID: <20230906-11348d34e52289c8f52be8f9@orel>
References: <cover.1693659382.git.haibo1.xu@intel.com>
 <8173daae52720dbdabbd88a5d412f653e6706de1.1693659382.git.haibo1.xu@intel.com>
 <20230904-06f09083d5190fd50e53b1ea@orel>
 <CAJve8on7Yi7cDuXOVznuRdTvfUhig2hZy8g72nvnHkM7omoVAw@mail.gmail.com>
 <20230906-c35fdc0e07d2cc0f9cb93203@orel>
 <CAJve8ok-Z6VCziFj5t0=BoouZ-VLyGaqEng-dYGTFnP-CR36kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJve8ok-Z6VCziFj5t0=BoouZ-VLyGaqEng-dYGTFnP-CR36kw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 06, 2023 at 05:09:20PM +0800, Haibo Xu wrote:
> On Wed, Sep 6, 2023 at 3:13 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Wed, Sep 06, 2023 at 02:35:42PM +0800, Haibo Xu wrote:
> > > On Mon, Sep 4, 2023 at 9:33 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> > > >
> > > > On Sat, Sep 02, 2023 at 08:59:25PM +0800, Haibo Xu wrote:
> > > > > Borrow the csr definitions and operations from kernel's
> > > > > arch/riscv/include/asm/csr.h to tools/ for riscv.
> > > > >
> > > > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > > > ---
> > > > >  tools/arch/riscv/include/asm/csr.h | 521 +++++++++++++++++++++++++++++
> > > > >  1 file changed, 521 insertions(+)
> > > > >  create mode 100644 tools/arch/riscv/include/asm/csr.h
> > > > >
> > > > > diff --git a/tools/arch/riscv/include/asm/csr.h b/tools/arch/riscv/include/asm/csr.h
> > > > > new file mode 100644
> > > > > index 000000000000..4e86c82aacbd
> > > > > --- /dev/null
> > > > > +++ b/tools/arch/riscv/include/asm/csr.h
> > > > > @@ -0,0 +1,521 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > > > +/*
> > > > > + * Copyright (C) 2015 Regents of the University of California
> > > > > + */
> > > > > +
> > > > > +#ifndef _ASM_RISCV_CSR_H
> > > > > +#define _ASM_RISCV_CSR_H
> > > > > +
> > > > > +#include <linux/bits.h>
> > > > > +
> > > > > +/* Status register flags */
> > > > > +#define SR_SIE               _AC(0x00000002, UL) /* Supervisor Interrupt Enable */
> > > > > +#define SR_MIE               _AC(0x00000008, UL) /* Machine Interrupt Enable */
> > > > > +#define SR_SPIE              _AC(0x00000020, UL) /* Previous Supervisor IE */
> > > > > +#define SR_MPIE              _AC(0x00000080, UL) /* Previous Machine IE */
> > > > > +#define SR_SPP               _AC(0x00000100, UL) /* Previously Supervisor */
> > > > > +#define SR_MPP               _AC(0x00001800, UL) /* Previously Machine */
> > > > > +#define SR_SUM               _AC(0x00040000, UL) /* Supervisor User Memory Access */
> > > > > +
> > > > > +#define SR_FS                _AC(0x00006000, UL) /* Floating-point Status */
> > > > > +#define SR_FS_OFF    _AC(0x00000000, UL)
> > > > > +#define SR_FS_INITIAL        _AC(0x00002000, UL)
> > > > > +#define SR_FS_CLEAN  _AC(0x00004000, UL)
> > > > > +#define SR_FS_DIRTY  _AC(0x00006000, UL)
> > > > > +
> > > > > +#define SR_VS                _AC(0x00000600, UL) /* Vector Status */
> > > > > +#define SR_VS_OFF    _AC(0x00000000, UL)
> > > > > +#define SR_VS_INITIAL        _AC(0x00000200, UL)
> > > > > +#define SR_VS_CLEAN  _AC(0x00000400, UL)
> > > > > +#define SR_VS_DIRTY  _AC(0x00000600, UL)
> > > > > +
> > > > > +#define SR_XS                _AC(0x00018000, UL) /* Extension Status */
> > > > > +#define SR_XS_OFF    _AC(0x00000000, UL)
> > > > > +#define SR_XS_INITIAL        _AC(0x00008000, UL)
> > > > > +#define SR_XS_CLEAN  _AC(0x00010000, UL)
> > > > > +#define SR_XS_DIRTY  _AC(0x00018000, UL)
> > > > > +
> > > > > +#define SR_FS_VS     (SR_FS | SR_VS) /* Vector and Floating-Point Unit */
> > > > > +
> > > > > +#ifndef CONFIG_64BIT
> > > >
> > > > How do we ensure CONFIG_64BIT is set?
> > > >
> > >
> > > Currently, no explicit checking for this.
> > > Shall we add a gatekeeper in this file to ensure it is set?
> >
> > Not in this file, since this file is shared by all the tools and...
> >
> > >
> > > #ifndef CONFIG_64BIT
> > > #error "CONFIG_64BIT was not set"
> > > #endif
> >
> > ...we'll surely hit this error right now since nothing is setting
> > CONFIG_64BIT when compiling KVM selftests.
> >
> > We need to define CONFIG_64BIT in the build somewhere prior to any
> > headers which depend on it being included. Maybe we can simply
> > add -DCONFIG_64BIT to CFLAGS, since all KVM selftests supported
> > architectures are 64-bit.
> >
> 
> Make sense! Another option can be just add "#define CONFIG_64BIT" at
> the begin of csr.h

Nope, other tools/tests may want to include csr.h someday and they may or
may not be targeting 64-bit. They'll need to appropriately set
CONFIG_64BIT themselves. We could require

#define CONFIG_64BIT
#include <asm/csr.h>

everywhere we include it, but that's error prone since it'll get forgotten
and nothing will complain unless a define which isn't also present in
!CONFIG_64BIT is used.

Thanks,
drew
