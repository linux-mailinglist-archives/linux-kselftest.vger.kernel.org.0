Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E3279FF77
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 11:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbjINJFW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 05:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbjINJFV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 05:05:21 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABC0CC7
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 02:05:17 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40473f1fe9fso2070925e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 02:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694682315; x=1695287115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/mRrBnh8S4j8WTa2+bV8lSaUBhWpdN931kOj5VJSEI8=;
        b=UOl8Qzy11vgi3rOc9gqjGmspZmIl8dqJBmzSdR9xllQC9RfcRK9KLqZrQlquTOj/BK
         nOvJVMGO4npz3FSEuXm9+JUHBQ+tPVg/cg6LZlwigL1dDZtstYVpgwUup+4Gk8kpYFtP
         /knFoHf7hkrSf9PC9keILr94tV9MwNQqWB/KNKpwgce/t4R/f8Zm+UQO9uLACDzdPIEJ
         wPH6hQE6MdXgy1fJSp4x+XG3KWe+MVA6blipJNpLcvupwmGtI0YBj7Y2HIihfdbY69VM
         ywjS7fW3MxAnnIoKmhH/Y8zW6wj8DYxuTmosOESxqTXv7D/Ys83/SmfBUqaxJoJCsLL0
         ASzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694682315; x=1695287115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mRrBnh8S4j8WTa2+bV8lSaUBhWpdN931kOj5VJSEI8=;
        b=WH0qZ01ZFuYj8oLDm5s8bBr21VdWF+9pGvaY40IrsbMjzSel4mVafIlGXPyZ8f31s3
         MEIq6TbXbHwsZ2LsysaDIXfjNfMC7acgPiycmqV/IcOFrrn5LKfad1BSMBR+3Dli4HsI
         3cA+O+u/yilKSRsNY8+qNkFYzRSo37sFLLU6cY3q8lgdUVFeRfPd1nMVVe6CGoZcT8rX
         CKtJcC8Mqk8yPYZG1A/RGyMIzcNPAUg1SgZ1BQ8hqw92ol2LClk3YAQwpwzGppTgrNG2
         5YdEyXcyUoWGMSLiMeRZZ+5JcP9gNComwogj1OQlujdAP1LRkFrqdHwCRFzw3DhzRFnk
         b6+A==
X-Gm-Message-State: AOJu0YyJBA9yirnFSZ2z0NvIS0zTeo8x0f9cYaanqWr0o42JiNPgJzVq
        qcoOtFJ75gL7+v2BVZGW4XodSg==
X-Google-Smtp-Source: AGHT+IFy8TjeoZnzEKVRF6ve15/1ZtfpBeOza9n+OW8rYx1ZUEatSJ80NefZ30RlKJWhr7ppOLul1g==
X-Received: by 2002:a05:600c:6d7:b0:404:74e3:27a4 with SMTP id b23-20020a05600c06d700b0040474e327a4mr285671wmn.40.1694682315033;
        Thu, 14 Sep 2023 02:05:15 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id m10-20020a7bce0a000000b003fee53feab5sm1391448wmc.10.2023.09.14.02.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 02:05:14 -0700 (PDT)
Date:   Thu, 14 Sep 2023 11:05:13 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
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
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Thomas Huth <thuth@redhat.com>,
        Colton Lewis <coltonlewis@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v3 8/9] KVM: riscv: selftests: Change vcpu_has_ext to a
 common function
Message-ID: <20230914-d6645bbc5ac80999674e9685@orel>
References: <cover.1694421911.git.haibo1.xu@intel.com>
 <dd81ef2b87e4cc160cb0ee782010dcf3543e065a.1694421911.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd81ef2b87e4cc160cb0ee782010dcf3543e065a.1694421911.git.haibo1.xu@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 14, 2023 at 09:37:02AM +0800, Haibo Xu wrote:
> Move vcpu_has_ext to the processor.c and rename it to __vcpu_has_ext
> so that other test cases can use it for vCPU extension check.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  .../selftests/kvm/include/riscv/processor.h      |  2 ++
>  .../testing/selftests/kvm/lib/riscv/processor.c  |  9 +++++++++
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 16 +---------------
>  3 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> index 2c975d9cead2..7d5517648ea7 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -42,6 +42,8 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
>  #define RISCV_ISA_EXT_REG(idx)	__kvm_reg_id(KVM_REG_RISCV_ISA_EXT, \
>  					     idx, KVM_REG_SIZE_ULONG)
>  
> +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext);
> +
>  struct ex_regs {
>  	unsigned long ra;
>  	unsigned long sp;
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
> index 39a1e9902dec..e527ad0abc30 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -15,6 +15,15 @@
>  
>  static vm_vaddr_t exception_handlers;
>  
> +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> +{
> +	unsigned long value = 0;
> +
> +	__vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> +
> +	return !!value;

I'd rather not assume that value will remain zero across a system call
which fails. Let's write this as

     unsigned long value = 0;
     int ret;

     ret = __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);

     return !ret && !!value;

> +}
> +
>  static uint64_t page_align(struct kvm_vm *vm, uint64_t v)
>  {
>  	return (v + vm->page_size) & ~(vm->page_size - 1);
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index d8ecacd03ecf..0dcff823f287 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -44,20 +44,6 @@ bool check_reject_set(int err)
>  	return err == EINVAL;
>  }
>  
> -static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> -{
> -	int ret;
> -	unsigned long value;
> -
> -	ret = __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> -	if (ret) {
> -		printf("Failed to get ext %d", ext);
> -		return false;
> -	}
> -
> -	return !!value;
> -}
> -
>  void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
>  {
>  	struct vcpu_reg_sublist *s;
> @@ -77,7 +63,7 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
>  		__vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(s->feature), 1);
>  
>  		/* Double check whether the desired extension was enabled */
> -		__TEST_REQUIRE(vcpu_has_ext(vcpu, s->feature),
> +		__TEST_REQUIRE(__vcpu_has_ext(vcpu, s->feature),
>  			       "%s not available, skipping tests\n", s->name);
>  	}
>  }
> -- 
> 2.34.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
