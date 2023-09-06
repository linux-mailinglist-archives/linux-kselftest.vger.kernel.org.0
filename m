Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6047935FF
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 09:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjIFHNr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 03:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjIFHNq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 03:13:46 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DEDE5C
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Sep 2023 00:13:35 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b962535808so52996821fa.0
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Sep 2023 00:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1693984414; x=1694589214; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aTsez1MtzhhlmQ/mCF+KXbnv+lrjtNHxtrQ8tWacSro=;
        b=XgR5KbP8Z9ANBsYHz0mmqisWhDFYtmyh2NRc0lXzhXWmuH5kplq6j+GO1JewPY+uLq
         2gTaqMt1rBCIM3Wx0dTOhmchlxY4kb4wlfdZyfEOl92FX3DYtUSceJa6ckO+6kE+XjxH
         vhMcLu0aGqrlhPfpvYJSMjU/3wz1ZdjovcLkCx7xyt3sYWB2rXqP5eAOqlzKxEBG/8IQ
         NByG3jAHpT/c6rQEN+oZ8SVLgrBlpkO+ir0GVweWfwwjP/giFDb9mNvBj0tbGEV0ck0M
         wnq5fpD6n63xHBaauUiHCgqATzjEOyVz68IOucj2YGwjphLUBmjRr1+dMmNjhn77todl
         F7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693984414; x=1694589214;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTsez1MtzhhlmQ/mCF+KXbnv+lrjtNHxtrQ8tWacSro=;
        b=Z2mpRHyXP6X53mrUX8iWFjPR4Yl+360BWtABf0XFhgnHG+2bsLkWJoLg9HNkNxJmXc
         DzLoXU+mFeVp+rl7IhyT5k4zdCl2n5y+K9ygGmuAW/bJrhQnTKofhYpjo/1U5wZbHy1F
         JEy3HqhmSlZIuzsDH0twOOuQucaPd8GKXBbNDQiQH0SbY+3NsD0X3C+o/VBz1wnRa3Hf
         s27Wuzy3oIPNhcZB/4/7e+YuHJCSANo/HfWMblqKQt6CsXkw33I+ITHGzYMKmepf02N0
         vJqrKdizOiIcSM+Crgxam9QPuNRmr04rZSP5lktJ/59+gF/NNDwHRgNqY4YvZ0VAH1kC
         vkoQ==
X-Gm-Message-State: AOJu0YxBM2iX/Qo3GjyIAGvuQdYGxWCP7ZhAcLCDVrEbtih2xuEJLuXB
        6KhX+639o/te/jAKNyQ7j6syPw==
X-Google-Smtp-Source: AGHT+IFUfuCxBleSioCsaDTw5kdKiT/iGJ6erAaiBayaHgVuc5Zh2EjkSrt7wvrXGoCM5I5C4sZAoA==
X-Received: by 2002:a2e:9254:0:b0:2b9:55c9:c228 with SMTP id v20-20020a2e9254000000b002b955c9c228mr1549101ljg.27.1693984413992;
        Wed, 06 Sep 2023 00:13:33 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id e2-20020a05600c218200b003fef5402d2dsm22237218wme.8.2023.09.06.00.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 00:13:33 -0700 (PDT)
Date:   Wed, 6 Sep 2023 09:13:32 +0200
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
Message-ID: <20230906-c35fdc0e07d2cc0f9cb93203@orel>
References: <cover.1693659382.git.haibo1.xu@intel.com>
 <8173daae52720dbdabbd88a5d412f653e6706de1.1693659382.git.haibo1.xu@intel.com>
 <20230904-06f09083d5190fd50e53b1ea@orel>
 <CAJve8on7Yi7cDuXOVznuRdTvfUhig2hZy8g72nvnHkM7omoVAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJve8on7Yi7cDuXOVznuRdTvfUhig2hZy8g72nvnHkM7omoVAw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 06, 2023 at 02:35:42PM +0800, Haibo Xu wrote:
> On Mon, Sep 4, 2023 at 9:33 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Sat, Sep 02, 2023 at 08:59:25PM +0800, Haibo Xu wrote:
> > > Borrow the csr definitions and operations from kernel's
> > > arch/riscv/include/asm/csr.h to tools/ for riscv.
> > >
> > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > ---
> > >  tools/arch/riscv/include/asm/csr.h | 521 +++++++++++++++++++++++++++++
> > >  1 file changed, 521 insertions(+)
> > >  create mode 100644 tools/arch/riscv/include/asm/csr.h
> > >
> > > diff --git a/tools/arch/riscv/include/asm/csr.h b/tools/arch/riscv/include/asm/csr.h
> > > new file mode 100644
> > > index 000000000000..4e86c82aacbd
> > > --- /dev/null
> > > +++ b/tools/arch/riscv/include/asm/csr.h
> > > @@ -0,0 +1,521 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Copyright (C) 2015 Regents of the University of California
> > > + */
> > > +
> > > +#ifndef _ASM_RISCV_CSR_H
> > > +#define _ASM_RISCV_CSR_H
> > > +
> > > +#include <linux/bits.h>
> > > +
> > > +/* Status register flags */
> > > +#define SR_SIE               _AC(0x00000002, UL) /* Supervisor Interrupt Enable */
> > > +#define SR_MIE               _AC(0x00000008, UL) /* Machine Interrupt Enable */
> > > +#define SR_SPIE              _AC(0x00000020, UL) /* Previous Supervisor IE */
> > > +#define SR_MPIE              _AC(0x00000080, UL) /* Previous Machine IE */
> > > +#define SR_SPP               _AC(0x00000100, UL) /* Previously Supervisor */
> > > +#define SR_MPP               _AC(0x00001800, UL) /* Previously Machine */
> > > +#define SR_SUM               _AC(0x00040000, UL) /* Supervisor User Memory Access */
> > > +
> > > +#define SR_FS                _AC(0x00006000, UL) /* Floating-point Status */
> > > +#define SR_FS_OFF    _AC(0x00000000, UL)
> > > +#define SR_FS_INITIAL        _AC(0x00002000, UL)
> > > +#define SR_FS_CLEAN  _AC(0x00004000, UL)
> > > +#define SR_FS_DIRTY  _AC(0x00006000, UL)
> > > +
> > > +#define SR_VS                _AC(0x00000600, UL) /* Vector Status */
> > > +#define SR_VS_OFF    _AC(0x00000000, UL)
> > > +#define SR_VS_INITIAL        _AC(0x00000200, UL)
> > > +#define SR_VS_CLEAN  _AC(0x00000400, UL)
> > > +#define SR_VS_DIRTY  _AC(0x00000600, UL)
> > > +
> > > +#define SR_XS                _AC(0x00018000, UL) /* Extension Status */
> > > +#define SR_XS_OFF    _AC(0x00000000, UL)
> > > +#define SR_XS_INITIAL        _AC(0x00008000, UL)
> > > +#define SR_XS_CLEAN  _AC(0x00010000, UL)
> > > +#define SR_XS_DIRTY  _AC(0x00018000, UL)
> > > +
> > > +#define SR_FS_VS     (SR_FS | SR_VS) /* Vector and Floating-Point Unit */
> > > +
> > > +#ifndef CONFIG_64BIT
> >
> > How do we ensure CONFIG_64BIT is set?
> >
> 
> Currently, no explicit checking for this.
> Shall we add a gatekeeper in this file to ensure it is set?

Not in this file, since this file is shared by all the tools and...

> 
> #ifndef CONFIG_64BIT
> #error "CONFIG_64BIT was not set"
> #endif

...we'll surely hit this error right now since nothing is setting
CONFIG_64BIT when compiling KVM selftests.

We need to define CONFIG_64BIT in the build somewhere prior to any
headers which depend on it being included. Maybe we can simply
add -DCONFIG_64BIT to CFLAGS, since all KVM selftests supported
architectures are 64-bit.

(Please trim emails, as I've been doing, when discussing specific parts.)

Thanks,
drew
