Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06667A71CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 07:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjITFOB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 01:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjITFOB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 01:14:01 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97C29F
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 22:13:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-313e742a787so292852f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 22:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695186833; x=1695791633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nA7XftN55Rzt443xAle+6ZlQo/LHZ8P1ArIv8UK8Is8=;
        b=fU3GI35xj4gIYlDA3e/SMKhU/TvT+tXvgDBJgWDGhrBrk6looZWCFtbi3bMa/cRf2D
         q6354kv8kQ6h3yibaETrhqqvBFYpf+q1CyyfwafIsMzc1XS4zhV7yhFLuQ3VlcR1smPs
         TMIoh2Krr/h2605PuoogUFjAfHRyESTL/s6WSApIHYE7thAOrzmcg4UcHtqzmqEmGhi0
         CDqGom2IrMxEmY6oAuCw6R+nEhjl9fCuUsTUQwAC2yydUMwDiaxhgVBFkCiT4CCCnBxr
         vbeMRZO0CeEkOS6vr/SC1hXol0P0yFOCvZQr0TzTcReUkLry1KcIPQ3d8M/6Fr5TH96Y
         XrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695186833; x=1695791633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nA7XftN55Rzt443xAle+6ZlQo/LHZ8P1ArIv8UK8Is8=;
        b=NwG54vL5zbviRoh9mWDAP68EtFg3CpXlMfTIxIRWLVBQYhmgrJ4FeRpfC5hGey1ciw
         CFMIuK2JUH2xR4WNh3NUQwHl7PHzTXZB3NnMrNw4tqmEXfpC6C1oKwkh/TTG/3cMoxxr
         DAxwLIh/W5dlJEeuVVhZs6o8MIKTF1AX4uiISKas2H/KjuK8fQqxssj3/Mcp6B1PSoum
         yyqDnB7uLictRwj1V1tE6k9kUeoVwdyVhj81EQZhtskobgR4JIdp6CgWBD480CBOFpw2
         /UmcxXKMQwRt4YtTrx5+9mpcGtQqKoBujPjVCkfWYnqCXrpGkZk5iO92V8QCGc06MG8b
         GS/w==
X-Gm-Message-State: AOJu0YxW5NbgC4zHDfu3rsdj8QVxS3F8KwdoUo0rbf/+FzJfd/sci/ts
        BNIB4DifLlhMSzYEQfLMaQoqho/A3tOD9Rc0t5s=
X-Google-Smtp-Source: AGHT+IFZ2CL+IU2qwUWM9cnEzbB80cRIpZX4g3i3VlY2xsCXTMrHZNyExNRtNkpOkCGAttCle3BkPg==
X-Received: by 2002:adf:f9c5:0:b0:31f:f9e8:3fce with SMTP id w5-20020adff9c5000000b0031ff9e83fcemr3545885wrr.16.1695186833161;
        Tue, 19 Sep 2023 22:13:53 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id l21-20020a7bc455000000b003fee8502999sm863420wmi.18.2023.09.19.22.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 22:13:52 -0700 (PDT)
Date:   Wed, 20 Sep 2023 07:13:52 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Shuah Khan <shuah@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/4] KVM: riscv: selftests: Fix ISA_EXT register handling
 in get-reg-list
Message-ID: <20230920-c166b288c4c1c17144dc3709@orel>
References: <20230918180646.1398384-1-apatel@ventanamicro.com>
 <20230918180646.1398384-4-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918180646.1398384-4-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 18, 2023 at 11:36:45PM +0530, Anup Patel wrote:
> Same set of ISA_EXT registers are not present on all host because
> ISA_EXT registers are visible to the KVM user space based on the
> ISA extensions available on the host. Also, disabling an ISA
> extension using corresponding ISA_EXT register does not affect
> the visibility of the ISA_EXT register itself.
> 
> Based on the above, we should filter-out all ISA_EXT registers.
> 
> Fixes: 477069398ed6 ("KVM: riscv: selftests: Add get-reg-list test")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../selftests/kvm/riscv/get-reg-list.c        | 35 +++++++++++--------
>  1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index d8ecacd03ecf..76c0ad11e423 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -14,17 +14,33 @@
>  
>  bool filter_reg(__u64 reg)
>  {
> +	switch (reg & ~REG_MASK) {
>  	/*
> -	 * Some ISA extensions are optional and not present on all host,
> -	 * but they can't be disabled through ISA_EXT registers when present.
> -	 * So, to make life easy, just filtering out these kind of registers.
> +	 * Same set of ISA_EXT registers are not present on all host because
> +	 * ISA_EXT registers are visible to the KVM user space based on the
> +	 * ISA extensions available on the host. Also, disabling an ISA
> +	 * extension using corresponding ISA_EXT register does not affect
> +	 * the visibility of the ISA_EXT register itself.
> +	 *
> +	 * Based on above, we should filter-out all ISA_EXT registers.
>  	 */
> -	switch (reg & ~REG_MASK) {
> +	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_A:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_C:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_D:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_F:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_H:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_I:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_M:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVPBMT:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SSTC:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVINVAL:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOM:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOZ:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBB:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SSAIA:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_V:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVNAPOT:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBA:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBS:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICNTR:
> @@ -50,12 +66,7 @@ static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
>  	unsigned long value;
>  
>  	ret = __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> -	if (ret) {
> -		printf("Failed to get ext %d", ext);
> -		return false;
> -	}
> -
> -	return !!value;
> +	return (ret) ? false : !!value;

This is an unrelated change, but OK. It's consistent with the plan[1] we
have on the timer test series

[1] https://lore.kernel.org/all/20230914-d6645bbc5ac80999674e9685@orel/

>  }
>  
>  void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
> @@ -506,10 +517,6 @@ static __u64 base_regs[] = {
>  	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(time),
>  	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(compare),
>  	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(state),
> -	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_A,
> -	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_C,
> -	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_I,
> -	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_M,
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_V01,
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_TIME,
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_IPI,
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
