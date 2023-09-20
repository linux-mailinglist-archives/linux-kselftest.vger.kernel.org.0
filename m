Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E7E7A720B
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 07:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjITF1c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 01:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbjITF1K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 01:27:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E5B10CB
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 22:26:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31f7638be6eso6007540f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 22:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695187575; x=1695792375; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I/hPQ2aul6l5anqC2DYg1b33GU8acR4UMMOAz4f8qXg=;
        b=o0Gf+tWRogb+SbLM1tSG1E8qc0qcYjOA6p/GnF194s6vGNv8UA9uXqiz1L4XqoErLR
         Qmm4dH5FYiCgGfeU/uzFZBiV4GBiafgRl3NrFLUrWW4NLjg4/eawNYnUuvuyT0fqSJlL
         Ho16+LKwJeUzgLpaffIYtLy8MmbpX219KDE5v86W3sBfnKot5IR+CAWixAQWzDGrpbQ1
         Li7balcTrfkTVOtWc3YSm07MDipAVMNYivuQQQqFEAzX4iOAuZ49zqj7YT0mktWPeYCr
         J6I6f9VKFQ6k3urr/MOiUSftPzLhV5OSHw/8nq9W/v07wpyj73xI+6V92/PTkOUWTVzL
         +AEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695187575; x=1695792375;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/hPQ2aul6l5anqC2DYg1b33GU8acR4UMMOAz4f8qXg=;
        b=ovr22xYochLTJ3/PiXA7aMIcUAviTDMFN0G8ZUfdIaykJa3xTQJiLnGijGp4cVHDRH
         0XfdQ5gPOGYRcLtgzfMHxxeU5ah0GBvHU+aiwO5+TT1sjVouwQVsk9TeuoeD8PDh8cx2
         hv194qBR9+cf8LtoiAro+Q65RNVtWmj1s6po73PvwI1Eamjw8paBzVeSfL5weZeiCgZI
         FlOL5qpA9dtK8QpD2u0XH8vOkRc49pC0rbf3HpeF2nIAM6YDWd/Q2CeePN2cSIGgVwOc
         OC1XzQtSSzhVN3PfZ4BP6g6H9dCu96bPgnMn2e7y1QPXYOZCZ7uECQCu50QAaZ0VTxwP
         HOJA==
X-Gm-Message-State: AOJu0Yw4/N/bqp6bcZDE6hKMJIbheFfXjNdAAk3xxiV8MfoCSjJ3O4W4
        CGEZzlgHTKgnkyO++YQWY+lBSA==
X-Google-Smtp-Source: AGHT+IFzgI1qI3qqkSIQbqlVAElk88cX+8fv0gUH+cKvN29I57hXEltVb4ZmH0gDcWJ0gA+gzE05kg==
X-Received: by 2002:adf:dc8f:0:b0:321:5d9f:2d9f with SMTP id r15-20020adfdc8f000000b003215d9f2d9fmr1348682wrj.47.1695187574848;
        Tue, 19 Sep 2023 22:26:14 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id g10-20020adff3ca000000b003200c918c81sm9574162wrp.112.2023.09.19.22.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 22:26:14 -0700 (PDT)
Date:   Wed, 20 Sep 2023 07:26:13 +0200
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
Message-ID: <20230920-d9e483ee61b25b834af160bb@orel>
References: <20230918180646.1398384-1-apatel@ventanamicro.com>
 <20230918180646.1398384-5-apatel@ventanamicro.com>
 <CAOnJCU+h-Y_i=HkCf194SLWp-7bqzMhRLC31q0xxQDMuLppapA@mail.gmail.com>
 <20230920-bc0e3956d144be651727e252@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230920-bc0e3956d144be651727e252@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 20, 2023 at 06:48:11AM +0200, Andrew Jones wrote:
> On Tue, Sep 19, 2023 at 01:12:47PM -0700, Atish Patra wrote:
> > On Mon, Sep 18, 2023 at 11:07 AM Anup Patel <apatel@ventanamicro.com> wrote:
> > >
> > > Currently the AIA ONE_REG registers are reported by get-reg-list
> > > as new registers for various vcpu_reg_list configs whenever Ssaia
> > > is available on the host because Ssaia extension can only be
> > > disabled by Smstateen extension which is not always available.
> > >
> > > To tackle this, we should filter-out AIA ONE_REG registers only
> > > when Ssaia can't be disabled for a VCPU.
> > >
> > > Fixes: 477069398ed6 ("KVM: riscv: selftests: Add get-reg-list test")
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > ---
> > >  .../selftests/kvm/riscv/get-reg-list.c        | 23 +++++++++++++++++--
> > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > > index 76c0ad11e423..85907c86b835 100644
> > > --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > > +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > > @@ -12,6 +12,8 @@
> > >
> > >  #define REG_MASK (KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK)
> > >
> > > +static bool isa_ext_cant_disable[KVM_RISCV_ISA_EXT_MAX];
> > > +
> > >  bool filter_reg(__u64 reg)
> > >  {
> > >         switch (reg & ~REG_MASK) {
> > > @@ -48,6 +50,15 @@ bool filter_reg(__u64 reg)
> > >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIFENCEI:
> > >         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHPM:
> > >                 return true;
> > > +       /* AIA registers are always available when Ssaia can't be disabled */
> > > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siselect):
> > > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1):
> > > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio2):
> > > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(sieh):
> > > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siph):
> > > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1h):
> > > +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio2h):
> > > +               return isa_ext_cant_disable[KVM_RISCV_ISA_EXT_SSAIA] ? true : false;
> > 
> > Ahh I guess. you do need the switch case for AIA CSRs but for ISA
> > extensions can be avoided as it is contiguous.
> 
> I guess we could so something like
> 
> case KVM_REG_RISCV_ISA_EXT ... KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_MAX:
> 
> for the ISA extensions.
>

On second thought, I think I like them each listed explicitly. When we add
a new extension it will show up in the new register list, which will not
only remind us that it needs to be filtered, but also that we should
probably also create a specific config for it.

Thanks,
drew
