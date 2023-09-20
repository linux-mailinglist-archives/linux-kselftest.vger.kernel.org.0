Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F8B7A7194
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 06:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjITEsX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 00:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjITEsW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 00:48:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B1BB0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 21:48:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-404732a0700so65748275e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 21:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695185293; x=1695790093; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m1zNdUzVc6Pr4pcVKMskltzftfT89TOksGte9XFhwTk=;
        b=NNPGHjV53xANPWwuwjnbRMVW11TDIyX6tRzO2So/mXhIYKDkn8IPbQkLNlLe7CUGPR
         2Dg5tYoH33JqtyKSPzztxF11jy3y+rR3RwAXA12dck7wlzlD5EthXdnHM/e0lp69VDyy
         L7wldaV8/Y5vX+Bf8SciY7BTDPlBYmvX9WV6BLpB6Vo4BkbZkQuahtxOzSrYTKJ3yS9l
         dJ0HQdmKQZrIVj6D0BBdnkBHzWEMGAotkoH9okLmzWnStK2bsmT/fSoIIvWaEmeMjBN3
         ywegrRZYL7yRHCAR4ofb6n5vdWjIXby6b8ArjfriVqIdY4ak1yUqs7i8f2AdNvOh84Cz
         J+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695185293; x=1695790093;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1zNdUzVc6Pr4pcVKMskltzftfT89TOksGte9XFhwTk=;
        b=a7Ep8XtpUdAVz27rTnfLeJkEFqoepU5yTPkeOrAlKJFdUoK+iCSunhU/q/AjvK6U60
         4Y+S+cQwCwuXH+9wxfpnwybT1DOG3mhprqVNhFQuGBluLDN1/722X0/CIY4/p+FBbC9j
         lyNbhsGk1dAgliseJryFgQspyVp2l4kheVoLspAgW82zOvV3IxYIkXf7WlK2ul/ocTye
         lH8HjiUfzq2rdygGWfiz2W0UtP2a0+BFj8G3iqgYb4SF3xFhTaU+CKVuf9gjyF1KqN/k
         4GxopHPrIQsjboZQGJsABTEpREQ7bhHtt1HSooBw+q/HXkXxxvQvcMEy+uQ+Usgzbn/T
         H2kQ==
X-Gm-Message-State: AOJu0YxmJXi735zYsnpQH9xIrb0xzvJUT9CWKlHQ4Ma8RvIn9HM/M7Ek
        qhtrns0lqL3d72e6Rf29H3Wsgg==
X-Google-Smtp-Source: AGHT+IHNTj0/2lmbfWYjEmf3kCedBQ4IVwJ4KHiViE5ekRfu5L22Fq6enMo4axMx60gYT7DGOhz9tg==
X-Received: by 2002:a7b:cd8c:0:b0:401:d2cb:e6f3 with SMTP id y12-20020a7bcd8c000000b00401d2cbe6f3mr1247667wmj.1.1695185293390;
        Tue, 19 Sep 2023 21:48:13 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c020f00b00401d8810c8bsm805326wmi.15.2023.09.19.21.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 21:48:12 -0700 (PDT)
Date:   Wed, 20 Sep 2023 06:48:11 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/4] KVM: riscv: selftests: Selectively filter-out AIA
 registers
Message-ID: <20230920-bc0e3956d144be651727e252@orel>
References: <20230918180646.1398384-1-apatel@ventanamicro.com>
 <20230918180646.1398384-5-apatel@ventanamicro.com>
 <CAOnJCU+h-Y_i=HkCf194SLWp-7bqzMhRLC31q0xxQDMuLppapA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOnJCU+h-Y_i=HkCf194SLWp-7bqzMhRLC31q0xxQDMuLppapA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 19, 2023 at 01:12:47PM -0700, Atish Patra wrote:
> On Mon, Sep 18, 2023 at 11:07 AM Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > Currently the AIA ONE_REG registers are reported by get-reg-list
> > as new registers for various vcpu_reg_list configs whenever Ssaia
> > is available on the host because Ssaia extension can only be
> > disabled by Smstateen extension which is not always available.
> >
> > To tackle this, we should filter-out AIA ONE_REG registers only
> > when Ssaia can't be disabled for a VCPU.
> >
> > Fixes: 477069398ed6 ("KVM: riscv: selftests: Add get-reg-list test")
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  .../selftests/kvm/riscv/get-reg-list.c        | 23 +++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > index 76c0ad11e423..85907c86b835 100644
> > --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > @@ -12,6 +12,8 @@
> >
> >  #define REG_MASK (KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK)
> >
> > +static bool isa_ext_cant_disable[KVM_RISCV_ISA_EXT_MAX];
> > +
> >  bool filter_reg(__u64 reg)
> >  {
> >         switch (reg & ~REG_MASK) {
> > @@ -48,6 +50,15 @@ bool filter_reg(__u64 reg)
> >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIFENCEI:
> >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHPM:
> >                 return true;
> > +       /* AIA registers are always available when Ssaia can't be disabled */
> > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siselect):
> > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1):
> > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio2):
> > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(sieh):
> > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siph):
> > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1h):
> > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio2h):
> > +               return isa_ext_cant_disable[KVM_RISCV_ISA_EXT_SSAIA] ? true : false;
> 
> Ahh I guess. you do need the switch case for AIA CSRs but for ISA
> extensions can be avoided as it is contiguous.

I guess we could so something like

case KVM_REG_RISCV_ISA_EXT ... KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_MAX:

for the ISA extensions.

Thanks,
drew
