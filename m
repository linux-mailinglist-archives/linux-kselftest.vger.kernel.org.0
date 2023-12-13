Return-Path: <linux-kselftest+bounces-1836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5509811441
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 15:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B7F28257D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 14:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00C32E82E;
	Wed, 13 Dec 2023 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YWJTIUaA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907C0E8
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 06:08:51 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c3984f0cdso55189545e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 06:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702476530; x=1703081330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w4lrG4sG6YQ4BIE8GkwyCjrSGGxi/UC5oCrLRkXbQKg=;
        b=YWJTIUaA6PxrUZacHC4Q0Oabi42NNKX04+vFLddIkUrNETTT+Z7dyOGhba9U2RWHb5
         u5dJ7SDK6Sw8NIIorta1XjowuGg1EBaUjKZ30VyhW9Rx/NaHqaBEYnX/oq2GvuXDCu7l
         xeYQlxCCv1bZRCEG2Ur+f0dTNNnYQsfn8M7ah51MtsBOEhLczLGmpb1creprqmy5yZi/
         wJsElLcFrbRTF/6HwR7VnS1t1mBhbXHhoH2cMS/K+bD0R2PFKvFc7y6axym75B6WbrJM
         aOwRfZ0c26RbUhPOsRydI7dtoevF14nUaTaCpbv8zt9ukf8RclqHs91U59aLh185FC3h
         yZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702476530; x=1703081330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4lrG4sG6YQ4BIE8GkwyCjrSGGxi/UC5oCrLRkXbQKg=;
        b=nvMuVmQhWZIlu8OH49WI3sRJAL+Rh+3e7SgzMGwRcVKqLcUVkiwDPQuej0kxsDoI1q
         WY90UX0SocnAPieYtFY99a0O5Rcp8cLXEb+vEsHWTcFXHetv8qZ+T92eqAJTokFFtwjS
         G53h4dCiBXpC1BSrKZpLGWMrJVD/lBmkIGOCUgjRtY0HHJM14yaVTej6AZ6YDKvt5y/x
         uyH2AnijAGYVPoxgHBxdMhshH7N+d4syySqwK/47hhFP/tv8c4AxioMXD0HNIEPbkicJ
         DZonQNE05udvoz9IENSqOb1aKYUB1q2sffI5ec/2ofniuD4EyWGh+j7n9zTVg0IAeK1I
         6OhA==
X-Gm-Message-State: AOJu0YwaqcHweWL/1aCOXKZN17fICcoRXNijcW8cXKU6kEZ+6RGetra1
	Er0izKvHpziprwGB9pcmXJStGQ==
X-Google-Smtp-Source: AGHT+IFgauWd5JriwtlECloTEhDNQTP3+kD2+Khl56+oF2aQ1LGAnudW9SV+lT5Ks1LMkyomAMD58w==
X-Received: by 2002:a05:600c:1d19:b0:40b:5e1d:83a0 with SMTP id l25-20020a05600c1d1900b0040b5e1d83a0mr4191978wms.52.1702476529934;
        Wed, 13 Dec 2023 06:08:49 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b0040c46ba7b66sm11736461wmn.48.2023.12.13.06.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:08:49 -0800 (PST)
Date: Wed, 13 Dec 2023 15:08:48 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: xiaobo55x@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	Greentime Hu <greentime.hu@sifive.com>, wchen <waylingii@gmail.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Minda Chen <minda.chen@starfivetech.com>, Samuel Holland <samuel@sholland.org>, 
	Sean Christopherson <seanjc@google.com>, Like Xu <likexu@tencent.com>, Peter Xu <peterx@redhat.com>, 
	Vipin Sharma <vipinsh@google.com>, Aaron Lewis <aaronlewis@google.com>, 
	Thomas Huth <thuth@redhat.com>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v4 08/11] KVM: riscv: selftests: Add guest helper to get
 vcpu id
Message-ID: <20231213-b02db86aaf7957be22b200f1@orel>
References: <cover.1702371136.git.haibo1.xu@intel.com>
 <02f6c9ccaaeb4ceb67137863e0317f62cef62496.1702371136.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02f6c9ccaaeb4ceb67137863e0317f62cef62496.1702371136.git.haibo1.xu@intel.com>

On Tue, Dec 12, 2023 at 05:31:17PM +0800, Haibo Xu wrote:
> Add guest_get_vcpuid() helper to simplify accessing to per-cpu
> private data. The sscratch CSR was used to store the vcpu id.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  tools/testing/selftests/kvm/include/aarch64/processor.h | 4 ----
>  tools/testing/selftests/kvm/include/kvm_util_base.h     | 9 +++++++++
>  tools/testing/selftests/kvm/lib/riscv/processor.c       | 8 ++++++++
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
> index c42d683102c7..16ae0ac01879 100644
> --- a/tools/testing/selftests/kvm/include/aarch64/processor.h
> +++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
> @@ -226,8 +226,4 @@ void smccc_smc(uint32_t function_id, uint64_t arg0, uint64_t arg1,
>  	       uint64_t arg2, uint64_t arg3, uint64_t arg4, uint64_t arg5,
>  	       uint64_t arg6, struct arm_smccc_res *res);
>  
> -
> -
> -uint32_t guest_get_vcpuid(void);
> -
>  #endif /* SELFTEST_KVM_PROCESSOR_H */
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index a18db6a7b3cf..666438113d22 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -932,4 +932,13 @@ void kvm_selftest_arch_init(void);
>  
>  void kvm_arch_vm_post_create(struct kvm_vm *vm);
>  
> +void vm_init_vector_tables(struct kvm_vm *vm);
> +void vcpu_init_vector_tables(struct kvm_vcpu *vcpu);
> +
> +struct ex_regs;
> +typedef void(*exception_handler_fn)(struct ex_regs *);
> +void vm_install_exception_handler(struct kvm_vm *vm, int vector, exception_handler_fn handler);

I think something happend on rebase since the above should be in a
different patch (and were for v3). I suggest checking your previous
and current version branches with git-range-diff after rebasing in
order to catch stuff like this.

Thanks,
drew

> +
> +uint32_t guest_get_vcpuid(void);
> +
>  #endif /* SELFTEST_KVM_UTIL_BASE_H */
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
> index efd9ac4b0198..39a1e9902dec 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -316,6 +316,9 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
>  	vcpu_set_reg(vcpu, RISCV_CORE_REG(regs.sp), stack_vaddr + stack_size);
>  	vcpu_set_reg(vcpu, RISCV_CORE_REG(regs.pc), (unsigned long)guest_code);
>  
> +	/* Setup sscratch for guest_get_vcpuid() */
> +	vcpu_set_reg(vcpu, RISCV_CSR_REG(sscratch), vcpu_id);
> +
>  	/* Setup default exception vector of guest */
>  	vcpu_set_reg(vcpu, RISCV_CSR_REG(stvec), (unsigned long)guest_unexp_trap);
>  
> @@ -436,3 +439,8 @@ void vm_install_interrupt_handler(struct kvm_vm *vm, exception_handler_fn handle
>  
>  	handlers->exception_handlers[1][0] = handler;
>  }
> +
> +uint32_t guest_get_vcpuid(void)
> +{
> +	return csr_read(CSR_SSCRATCH);
> +}
> -- 
> 2.34.1
> 

