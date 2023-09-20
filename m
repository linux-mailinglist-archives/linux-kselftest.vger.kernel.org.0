Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50BB7A73BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 09:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjITHKg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 03:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbjITHKe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 03:10:34 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B11AD
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 00:10:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40476ce8b2fso60220355e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 00:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695193826; x=1695798626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rYSL2OliA8I9jFK5tlBwpRh/J6O5TRCGMrfD6pOu/aU=;
        b=iD1jgcRc8xCdA7s+NsBn5xmXKATx6nOYpYpdeAAJs6MczuyjPfD7Lly3Och/0lXudu
         WYlZW5eiCvag2EQ1YmHEFEB/oQ6kmWugKX8qggvb7gbJcp/++N+gstzzVPaTiJp5bXUl
         V0aUovDNxlZY+DkWm6jYuMrVAL0qeKS0yxcln9VhzH1DrJX9XRM3KN+0s21UVQF29yxh
         c7Ozw55cMrOaJl4z9a0FbAUkUfgYmt+YY/bbUoYSG1nrfBFKL7DAMGGWUwDHZIx4MQV3
         ursECcvO/Ia9ovGCznmQytfmJ740XzJiCut9i3IAaIJVKr2nFIofztHfegmbzjOeisxN
         sAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695193826; x=1695798626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYSL2OliA8I9jFK5tlBwpRh/J6O5TRCGMrfD6pOu/aU=;
        b=W1jePX68OGBXA2sFtJ9U/XD/jD5GrFjVRqcL9GqVqGVAayER/5WNzrSS9HeP5blyBX
         sFj0ObXIaAy6Vb93O/N2rY7FG0S0cdNrxaBji5blCPO3V8sZ2RK36kslzK5wRu/6fyWN
         J8n5diMCEJmMqhQRy5pd4jAmTA/QCJYdxtcxkoYYqu0mHpMtGeAtJDJouPwA/pMmJhid
         Zyod27LFBUH3AuqNME/ZoBMvzvd1ytU9JNjFERij/+XtiSmFj/7/48ZpafPU+4f0l+AE
         e6zAC01Y395aJ1EsRS0Si6G3c5J3tNRfTy1UJZoIVQvWjm0dlsHc088gZBdU1xSESGbF
         7Ggg==
X-Gm-Message-State: AOJu0Yy/jv4ZainR129sGDdZc1NxKofyXkOm6gs5gY8sLbLWKhy+wr7H
        HHDGHXRQ4c8ANFN7yFWXfaJ/jw==
X-Google-Smtp-Source: AGHT+IHn/mG9ufEsy9VzVESTw3Tyfbt+fkSxQsO9JP93/JoeonJvg8wA6zOSeLnF0Tu99ye6+NcfXQ==
X-Received: by 2002:adf:e990:0:b0:317:5f04:bc00 with SMTP id h16-20020adfe990000000b003175f04bc00mr1683384wrm.27.1695193826024;
        Wed, 20 Sep 2023 00:10:26 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id e17-20020adffc51000000b0031435731dfasm17486584wrs.35.2023.09.20.00.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:10:25 -0700 (PDT)
Date:   Wed, 20 Sep 2023 09:10:19 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Shuah Khan <shuah@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/4] KVM: riscv: selftests: Selectively filter-out AIA
 registers
Message-ID: <20230920-c1362aebecf7ef8e36489efa@orel>
References: <20230918180646.1398384-1-apatel@ventanamicro.com>
 <20230918180646.1398384-5-apatel@ventanamicro.com>
 <20230920-d524c40b616536d0ad8213c3@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920-d524c40b616536d0ad8213c3@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 20, 2023 at 07:24:16AM +0200, Andrew Jones wrote:
> On Mon, Sep 18, 2023 at 11:36:46PM +0530, Anup Patel wrote:
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
> >  	switch (reg & ~REG_MASK) {
> > @@ -48,6 +50,15 @@ bool filter_reg(__u64 reg)
> >  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIFENCEI:
> >  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHPM:
> >  		return true;
> > +	/* AIA registers are always available when Ssaia can't be disabled */
> > +	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siselect):
> > +	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1):
> > +	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio2):
> > +	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(sieh):
> > +	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siph):
> > +	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1h):
> > +	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio2h):
> > +		return isa_ext_cant_disable[KVM_RISCV_ISA_EXT_SSAIA] ? true : false;
> 
> No need for the '? true : false'
> 
> >  	default:
> >  		break;
> >  	}
> > @@ -71,14 +82,22 @@ static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> >  
> >  void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
> >  {
> > +	int rc;
> >  	struct vcpu_reg_sublist *s;
> > +	unsigned long isa_ext_state[KVM_RISCV_ISA_EXT_MAX] = { 0 };
> 
> nit: I think we prefer reverse xmas tree in kselftests, but whatever.
> 
> > +
> > +	for (int i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++)
> > +		__vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(i), &isa_ext_state[i]);
> >  
> >  	/*
> >  	 * Disable all extensions which were enabled by default
> >  	 * if they were available in the risc-v host.
> >  	 */
> > -	for (int i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++)
> > -		__vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(i), 0);
> > +	for (int i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++) {
> > +		rc = __vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(i), 0);
> > +		if (rc && isa_ext_state[i])
> 
> How helpful is it to check that isa_ext_state[i] isn't zero? The value of
> the register could be zero, right? Shouldn't we instead capture the return
> values from __vcpu_get_reg and if the return value is zero for a get,
> but nonzero for a set, then we know we have it, but can't disable it.

Eh, never mind. After sending this, I felt like there was something fishy
about my interpretation of how this works, so I took a second look. The
patch is correct as is, since we're checking for when the ISA extension
is present, but we can't disable it (just like it says it's doing :-) I
was thinking too much about AIA registers and not ISA extension registers.

> 
> > +			isa_ext_cant_disable[i] = true;
> > +	}
> >  
> >  	for_each_sublist(c, s) {
> >  		if (!s->feature)
> > -- 
> > 2.34.1
> >
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
