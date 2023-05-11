Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3336FF013
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 12:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbjEKKo6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 06:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237879AbjEKKou (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 06:44:50 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FDBAD22
        for <linux-kselftest@vger.kernel.org>; Thu, 11 May 2023 03:44:45 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f315735514so279244095e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 May 2023 03:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683801883; x=1686393883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P7Umlt0HzFSClqRwf3YI2Twu1K26jeRmJZFN/RWjcoM=;
        b=X/RL8VYyhIZrC4PRL+sEKoia8SgSpPPqHt4QBmvchTjTwBCVbqVe+9ixoBscAjOgKI
         +c/OvN0f+b+foIcSLcNb7vQrVar+bJxWpapaEKgfmx5JHulNXC+F45wuX0GvFCLd13Q2
         A8Xj+2RtDYY+OZpzPBuww9hxPuyI8tYPpO5p2yQaPCfV1N7RotoAJgwDFn0DMKh2Or73
         DKJMokSefadPm2XMFkd75bl2sXPBgmv358l0XOwxUhDrOMl/fqSH7sYGwYVmi9H+w0LJ
         l9lyBrxKYEwSwkLu2fIqpVG7TM1eyK+fIdMaggFwGhfOzKFCmb3AIRRSOcS4AOmFw2Jq
         mCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683801883; x=1686393883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7Umlt0HzFSClqRwf3YI2Twu1K26jeRmJZFN/RWjcoM=;
        b=Z8Xy8Tf7xRaQ/PUJSQBSP1yjeZcGX8pRYfOyLTv/WzLb1byRq/pUdFj0RsNTPZQO9Z
         FPTJjzp5euuI8Gc5jbxl/QCTXfqEgp94onjic5mYUBRfxMg6tdRcx+YVKCsd+4PyInYi
         MCxRbdDjBSN9j8nrzNkNNMWuluUtZ2IisCCKwcNEYoDbT8ITWmosjqfMN2qLv2zwNhGo
         hMiUGIXWjVEuzaxYx+RTkCTnK3VOVogvRlkzzabXo+IzWixf3sQ8ad3EK7kbxhpWdGHY
         69aTuhNweiWfYyrxdOAMZ+zQgTKpUr52IQx/aDVQsR4bfYDJQCMrgpVMaoBToZtkh/UQ
         L1BA==
X-Gm-Message-State: AC+VfDzSEpx5fvrYtAx/7t7P2unJFC1Oy7pFrQnbbdxB+EZuD3UTa8/L
        zLFXvmiCdk7UIErwFOxRtckKNw==
X-Google-Smtp-Source: ACHHUZ6CScK1XIiX1j+9SIiexcwc0hNJLrd39EK/QefUYCN0gSs2wB98akb5RGZ0mp02hDFUSazkjQ==
X-Received: by 2002:a1c:f719:0:b0:3f1:70d5:1be8 with SMTP id v25-20020a1cf719000000b003f170d51be8mr16222257wmh.15.1683801883657;
        Thu, 11 May 2023 03:44:43 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id s7-20020a1cf207000000b003e91b9a92c9sm25273509wmc.24.2023.05.11.03.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 03:44:43 -0700 (PDT)
Date:   Thu, 11 May 2023 12:44:41 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: kvm: Add KVM_GET_REG_LIST API support
Message-ID: <20230511-5e8b478be55881a754cc2002@orel>
References: <cover.1683791148.git.haibo1.xu@intel.com>
 <921fc2e1a91887170e277acb1b52df57480a5736.1683791148.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <921fc2e1a91887170e277acb1b52df57480a5736.1683791148.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 11, 2023 at 05:22:48PM +0800, Haibo Xu wrote:
> KVM_GET_REG_LIST API will return all registers that are available to
> KVM_GET/SET_ONE_REG APIs. It's very useful to identify some platform
> regression issue during VM migration.
> 
> Since this API was already supported on arm64, it'd be straightforward

s/it'd be/it is/

> to enable it on riscv with similar code structure.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  Documentation/virt/kvm/api.rst |   2 +-
>  arch/riscv/kvm/vcpu.c          | 346 +++++++++++++++++++++++++++++++++
>  2 files changed, 347 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index add067793b90..280e89abd004 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -3499,7 +3499,7 @@ VCPU matching underlying host.
>  ---------------------
>  
>  :Capability: basic
> -:Architectures: arm64, mips
> +:Architectures: arm64, mips, riscv
>  :Type: vcpu ioctl
>  :Parameters: struct kvm_reg_list (in/out)
>  :Returns: 0 on success; -1 on error
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 8bd9f2a8a0b9..fb8834e4fa15 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -657,6 +657,334 @@ static int kvm_riscv_vcpu_set_reg_isa_ext(struct kvm_vcpu *vcpu,
>  	return 0;
>  }
>  
> +static inline unsigned long num_config_regs(void)
> +{
> +	return sizeof(struct kvm_riscv_config) / sizeof(unsigned long);
> +}
> +
> +static int copy_config_reg_indices(u64 __user *uindices)
> +{
> +	unsigned int i;
> +	int n = num_config_regs();
> +
> +	for (i = 0; i < n; i++) {
> +		u64 reg = KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CONFIG | i;
                                          ^ this should be
					  size-ulong

  u64 size = IS_ENABLED(CONFIG_32BIT) ? KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64;
  u64 reg = KVM_REG_RISCV | size | KVM_REG_RISCV_CONFIG | i;

> +
> +		if (uindices) {
> +			if (put_user(reg, uindices))
> +				return -EFAULT;
> +			uindices++;
> +		}
> +	}
> +
> +	return n;
> +}
> +
> +static inline unsigned long num_core_regs(void)
> +{
> +	return sizeof(struct kvm_riscv_core) / sizeof(unsigned long);
> +}
> +
> +static int copy_core_reg_indices(u64 __user *uindices)
> +{
> +	unsigned int i;
> +	int n = num_core_regs();
> +
> +	for (i = 0; i < n; i++) {
> +		u64 reg = KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | i;
                                          ^ size-ulong

> +
> +		if (uindices) {
> +			if (put_user(reg, uindices))
> +				return -EFAULT;
> +			uindices++;
> +		}
> +	}
> +
> +	return n;
> +}
> +
> +static inline unsigned long num_csr_regs(void)
> +{
> +	unsigned long n = sizeof(struct kvm_riscv_csr) / sizeof(unsigned long);
> +
> +	if (kvm_riscv_aia_available())
> +		n += sizeof(struct kvm_riscv_aia_csr) / sizeof(unsigned long);
> +
> +	return n;
> +}
> +
> +static int copy_csr_reg_indices(u64 __user *uindices)
> +{
> +	unsigned int i;
> +	int n1 = sizeof(struct kvm_riscv_csr) / sizeof(unsigned long);
> +	int n2 = 0;
> +
> +	/* copy general csr regs */
> +	for (i = 0; i < n1; i++) {
> +		u64 reg = KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR |
                                          ^ size-ulong

> +				  KVM_REG_RISCV_CSR_GENERAL | i;
> +
> +		if (uindices) {
> +			if (put_user(reg, uindices))
> +				return -EFAULT;
> +			uindices++;
> +		}
> +	}
> +
> +	/* copy AIA csr regs */
> +	if (kvm_riscv_aia_available()) {
> +		n2 = sizeof(struct kvm_riscv_aia_csr) / sizeof(unsigned long);
> +
> +		for (i = 0; i < n2; i++) {
> +			u64 reg = KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR |
                                                  ^ size-ulong

> +					  KVM_REG_RISCV_CSR_AIA | i;
> +
> +			if (uindices) {
> +				if (put_user(reg, uindices))
> +					return -EFAULT;
> +				uindices++;
> +			}
> +		}
> +	}
> +
> +	return n1 + n2;
> +}
> +
> +static inline unsigned long num_timer_regs(void)
> +{
> +	return sizeof(struct kvm_riscv_timer) / sizeof(unsigned long);
> +}
> +
> +static int copy_timer_reg_indices(u64 __user *uindices)
> +{
> +	unsigned int i;
> +	int n = num_timer_regs();
> +
> +	for (i = 0; i < n; i++) {
> +		u64 reg = KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | i;
> +
> +		if (uindices) {
> +			if (put_user(reg, uindices))
> +				return -EFAULT;
> +			uindices++;
> +		}
> +	}
> +
> +	return n;
> +}
> +
> +static inline unsigned long num_fp_f_regs(const struct kvm_vcpu *vcpu)
> +{
> +	const struct kvm_cpu_context *cntx = &vcpu->arch.guest_context;
> +
> +	if (riscv_isa_extension_available(vcpu->arch.isa, f))
> +		return sizeof(cntx->fp.f) / sizeof(u32);
> +	else
> +		return 0;
> +}
> +
> +static int copy_fp_f_reg_indices(const struct kvm_vcpu *vcpu,
> +					u64 __user *uindices)
> +{
> +	unsigned int i;
> +	int n = num_fp_f_regs(vcpu);
> +
> +	for (i = 0; i < n; i++) {
> +		u64 reg = KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | i;
> +
> +		if (uindices) {
> +			if (put_user(reg, uindices))
> +				return -EFAULT;
> +			uindices++;
> +		}
> +	}
> +
> +	return n;
> +}
> +
> +static inline unsigned long num_fp_d_regs(const struct kvm_vcpu *vcpu)
> +{
> +	const struct kvm_cpu_context *cntx = &vcpu->arch.guest_context;
> +
> +	if (riscv_isa_extension_available(vcpu->arch.isa, d))
> +		return sizeof(cntx->fp.d.f) / sizeof(u64) + 1;
> +	else
> +		return 0;
> +}
> +
> +static int copy_fp_d_reg_indices(const struct kvm_vcpu *vcpu,
> +					u64 __user *uindices)
> +{
> +	unsigned int i;
> +	int n = num_fp_d_regs(vcpu);
> +	u64 reg;
> +
> +	/* copy fp.d.f indeices */

indices

> +	for (i = 0; i < n-1; i++) {
> +		reg = KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | i;
> +
> +		if (uindices) {
> +			if (put_user(reg, uindices))
> +				return -EFAULT;
> +			uindices++;
> +		}
> +	}
> +
> +	/* copy fp.d.fcsr indeices */

indices

> +	reg = KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_D | i;
> +	if (uindices) {
> +		if (put_user(reg, uindices))
> +			return -EFAULT;
> +	}
> +
> +	return n;
> +}
> +
> +static inline unsigned long num_isa_ext_regs(void)
> +{
> +	return KVM_RISCV_ISA_EXT_MAX;
> +}
> +
> +static int copy_isa_ext_reg_indices(u64 __user *uindices)
> +{
> +	unsigned int i;
> +	int n = num_isa_ext_regs();
> +
> +	for (i = 0; i < n; i++) {
> +		u64 reg = KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | i;
                                          ^ size-ulong

> +
> +		if (uindices) {
> +			if (put_user(reg, uindices))
> +				return -EFAULT;
> +			uindices++;
> +		}
> +	}
> +
> +	return n;
> +}
> +
> +static inline unsigned long num_sbi_ext_regs(void)
> +{
> +	/* number of KVM_REG_RISCV_SBI_SINGLE +
> +	 *  2x(number of KVM_REG_RISCV_SBI_MULTI)
> +	 */

Please use an opening wing '/*' on comments.

> +	return KVM_RISCV_SBI_EXT_MAX + 2*(KVM_REG_RISCV_SBI_MULTI_REG_LAST+1);
> +}
> +
> +static int copy_sbi_ext_reg_indices(u64 __user *uindices)
> +{
> +	unsigned int i;
> +	int n;
> +
> +	/* copy KVM_REG_RISCV_SBI_SINGLE */
> +	n = KVM_RISCV_SBI_EXT_MAX;
> +	for (i = 0; i < n; i++) {
> +		u64 reg = KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_SBI_EXT |
                                          ^ size-ulong

> +				  KVM_REG_RISCV_SBI_SINGLE | i;
> +
> +		if (uindices) {
> +			if (put_user(reg, uindices))
> +				return -EFAULT;
> +			uindices++;
> +		}
> +	}
> +
> +	/* copy KVM_REG_RISCV_SBI_MULTI */
> +	n = KVM_REG_RISCV_SBI_MULTI_REG_LAST + 1;
> +	for (i = 0; i < n; i++) {
> +		u64 reg = KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_SBI_EXT |
                                          ^ size-ulong

> +				  KVM_REG_RISCV_SBI_MULTI_EN | i;
> +
> +		if (uindices) {
> +			if (put_user(reg, uindices))
> +				return -EFAULT;
> +			uindices++;
> +		}
> +
> +		reg = KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_SBI_EXT |
> +			  KVM_REG_RISCV_SBI_MULTI_DIS | i;
> +
> +		if (uindices) {
> +			if (put_user(reg, uindices))
> +				return -EFAULT;
> +			uindices++;
> +		}
> +	}
> +
> +	return num_sbi_ext_regs();
> +}
> +
> +/**
> + * kvm_riscv_vcpu_num_regs - how many registers do we present via KVM_GET/SET_ONE_REG
> + *
> + * This is for all registers.
> + */
> +static unsigned long kvm_riscv_vcpu_num_regs(struct kvm_vcpu *vcpu)
> +{
> +	unsigned long res = 0;
> +
> +	res += num_config_regs();
> +	res += num_core_regs();
> +	res += num_csr_regs();
> +	res += num_timer_regs();
> +	res += num_fp_f_regs(vcpu);
> +	res += num_fp_d_regs(vcpu);
> +	res += num_isa_ext_regs();
> +	res += num_sbi_ext_regs();
> +
> +	return res;
> +}
> +
> +/**
> + * kvm_riscv_vcpu_copy_reg_indices - get indices of all registers.
> + */
> +static int kvm_riscv_vcpu_copy_reg_indices(struct kvm_vcpu *vcpu,
> +				u64 __user *uindices)
> +{
> +	int ret;
> +
> +	ret = copy_config_reg_indices(uindices);
> +	if (ret < 0)
> +		return ret;
> +	uindices += ret;
> +
> +	ret = copy_core_reg_indices(uindices);
> +	if (ret < 0)
> +		return ret;
> +	uindices += ret;
> +
> +	ret = copy_csr_reg_indices(uindices);
> +	if (ret < 0)
> +		return ret;
> +	uindices += ret;
> +
> +	ret = copy_timer_reg_indices(uindices);
> +	if (ret < 0)
> +		return ret;
> +	uindices += ret;
> +
> +	ret = copy_fp_f_reg_indices(vcpu, uindices);
> +	if (ret < 0)
> +		return ret;
> +	uindices += ret;
> +
> +	ret = copy_fp_d_reg_indices(vcpu, uindices);
> +	if (ret < 0)
> +		return ret;
> +	uindices += ret;
> +
> +	ret = copy_isa_ext_reg_indices(uindices);
> +	if (ret < 0)
> +		return ret;
> +	uindices += ret;
> +
> +	ret = copy_sbi_ext_reg_indices(uindices);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static int kvm_riscv_vcpu_set_reg(struct kvm_vcpu *vcpu,
>  				  const struct kvm_one_reg *reg)
>  {
> @@ -758,6 +1086,24 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  			r = kvm_riscv_vcpu_get_reg(vcpu, &reg);
>  		break;
>  	}
> +	case KVM_GET_REG_LIST: {
> +		struct kvm_reg_list __user *user_list = argp;
> +		struct kvm_reg_list reg_list;
> +		unsigned int n;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&reg_list, user_list, sizeof(reg_list)))
> +			break;
> +		n = reg_list.n;
> +		reg_list.n = kvm_riscv_vcpu_num_regs(vcpu);
> +		if (copy_to_user(user_list, &reg_list, sizeof(reg_list)))
> +			break;
> +		r = -E2BIG;
> +		if (n < reg_list.n)
> +			break;
> +		r = kvm_riscv_vcpu_copy_reg_indices(vcpu, user_list->reg);
> +		break;
> +	}
>  	default:
>  		break;
>  	}
> -- 
> 2.34.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
