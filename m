Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAD07A71FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 07:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjITF0F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 01:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjITFZr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 01:25:47 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110361BC6
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 22:24:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-404314388ceso68539995e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 22:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695187457; x=1695792257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FdkiLvHF9gidro/3KgiAkGZtbptKxwZzl5vmZkiG0XI=;
        b=pfbgTOqTiO1vDHPOs14bnMfDFcq6ArOs6YkseWn6RGBFn0eE6NZjx5HcAh8TAfXe2V
         wCvqU9QLrSFUAQp84GDbt4XIfn9aB2JQMhBeOvwBV9g8ZccaL8x1WSF74tlIpNwAVyY9
         e9ba5lO8edqd27wyab4D89ytr6QK5yq5PkVDAWv8SHphWvOAMJbo68VLjSCM4QcY/5Ri
         e1waB+96Cqq7pApLH8MBrQT7pRvgm0qnfiK4YsnQY6HkgxBw+Li5viidv7084f9slMUt
         OB1xAarbWxe5TJn/Jv25Ybq0K/MGUNie78mLQM2P6qJQMgErftOPgbIOQNLGSY57OgcO
         7VSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695187457; x=1695792257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdkiLvHF9gidro/3KgiAkGZtbptKxwZzl5vmZkiG0XI=;
        b=iFRDpkiwlMZkwbA2ylaWpFHWBTkufNHmqUJof+iB7dXvB8JOrVeIfLanhgQL7EVsrG
         AD8sdQdF00L1lGClO885Irpjh0sNFyCetyQEkdVFcbknxfH2R91bd8RLHBdyK8/BP9/3
         Vd2Xlk1r6We8thJR4Uy/JScfkfbL/E5S8T1YD8ykevhF6nXTr751dvR90vCposg22XN2
         VEPt9MtlR9G4v6cy4TbKSYnBfW1RsOnqfIzss1Rdf4SDm7RM7qBYoNMGrLiUC9p+15XN
         6qW5V91oeYeC9Hn/DnKfKdb9Q9ELN1lYawtQK7shTfpoebUzCT7ZEqryLToHu1VNr8yd
         w8qw==
X-Gm-Message-State: AOJu0Yx3pIGagIreTwcmToWs4QdhXCOZSW1pRrTzVi7LOyRuUG5IZofT
        XQ23FeiGFLSVEBX7d8fCra1erQ==
X-Google-Smtp-Source: AGHT+IHQdxfJ+WR4PPpqSYssTciQLBDW93+4eJ8/sDeDDHyZEJdTgHQCz4eKTxKGB5HuEUnCpOx01Q==
X-Received: by 2002:a1c:f702:0:b0:402:f5c4:2e5a with SMTP id v2-20020a1cf702000000b00402f5c42e5amr1429426wmh.37.1695187457228;
        Tue, 19 Sep 2023 22:24:17 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id p5-20020a7bcc85000000b003fe407ca05bsm874397wma.37.2023.09.19.22.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 22:24:16 -0700 (PDT)
Date:   Wed, 20 Sep 2023 07:24:16 +0200
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
Message-ID: <20230920-d524c40b616536d0ad8213c3@orel>
References: <20230918180646.1398384-1-apatel@ventanamicro.com>
 <20230918180646.1398384-5-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918180646.1398384-5-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 18, 2023 at 11:36:46PM +0530, Anup Patel wrote:
> Currently the AIA ONE_REG registers are reported by get-reg-list
> as new registers for various vcpu_reg_list configs whenever Ssaia
> is available on the host because Ssaia extension can only be
> disabled by Smstateen extension which is not always available.
> 
> To tackle this, we should filter-out AIA ONE_REG registers only
> when Ssaia can't be disabled for a VCPU.
> 
> Fixes: 477069398ed6 ("KVM: riscv: selftests: Add get-reg-list test")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../selftests/kvm/riscv/get-reg-list.c        | 23 +++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index 76c0ad11e423..85907c86b835 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -12,6 +12,8 @@
>  
>  #define REG_MASK (KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK)
>  
> +static bool isa_ext_cant_disable[KVM_RISCV_ISA_EXT_MAX];
> +
>  bool filter_reg(__u64 reg)
>  {
>  	switch (reg & ~REG_MASK) {
> @@ -48,6 +50,15 @@ bool filter_reg(__u64 reg)
>  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIFENCEI:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHPM:
>  		return true;
> +	/* AIA registers are always available when Ssaia can't be disabled */
> +	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siselect):
> +	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1):
> +	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio2):
> +	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(sieh):
> +	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siph):
> +	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1h):
> +	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio2h):
> +		return isa_ext_cant_disable[KVM_RISCV_ISA_EXT_SSAIA] ? true : false;

No need for the '? true : false'

>  	default:
>  		break;
>  	}
> @@ -71,14 +82,22 @@ static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
>  
>  void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
>  {
> +	int rc;
>  	struct vcpu_reg_sublist *s;
> +	unsigned long isa_ext_state[KVM_RISCV_ISA_EXT_MAX] = { 0 };

nit: I think we prefer reverse xmas tree in kselftests, but whatever.

> +
> +	for (int i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++)
> +		__vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(i), &isa_ext_state[i]);
>  
>  	/*
>  	 * Disable all extensions which were enabled by default
>  	 * if they were available in the risc-v host.
>  	 */
> -	for (int i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++)
> -		__vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(i), 0);
> +	for (int i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++) {
> +		rc = __vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(i), 0);
> +		if (rc && isa_ext_state[i])

How helpful is it to check that isa_ext_state[i] isn't zero? The value of
the register could be zero, right? Shouldn't we instead capture the return
values from __vcpu_get_reg and if the return value is zero for a get,
but nonzero for a set, then we know we have it, but can't disable it.

> +			isa_ext_cant_disable[i] = true;
> +	}
>  
>  	for_each_sublist(c, s) {
>  		if (!s->feature)
> -- 
> 2.34.1
>

Thanks,
drew
