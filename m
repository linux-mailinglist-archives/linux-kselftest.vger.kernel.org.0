Return-Path: <linux-kselftest+bounces-48074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D308CEECC0
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 15:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 360A63000DD4
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 14:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B638B227EB9;
	Fri,  2 Jan 2026 14:50:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CD220299B;
	Fri,  2 Jan 2026 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767365413; cv=none; b=Gpxw97nwGzaesYvT1PfFQ4jj/OMF4m69+kd3HPXa7yiZOJDzYcDps5Eo5psgP/DlNVPmKNcK35Nnkvt9QY3dWgUMik9EMIEEve0ocF86EgFKaM6k9zqIgxIToQiuMj06cSxttuxf/zhMfHlPm7lVBqCMP5fUb7oRborAkT/v9TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767365413; c=relaxed/simple;
	bh=rEerITH9W56cbZ/rSKnhy6DYtiu7aXbYS3uPNNJAtQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQtmxRyPagYX9eLYiuUvUKyHbHpT2jusABALDR8fXgDRn2EO92csRrizQAO6lI+D+WFZ7XQ1XuEJUai9zlwmCUDSIuUdi+4nULWvDtkO2fLkvNMg5ghp6oxdlg3oDwR37h5IDX44btmVfs0x7pOgwp+rFWMRrlM/zlbUzAijAbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B156497;
	Fri,  2 Jan 2026 06:50:04 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6735F3F63F;
	Fri,  2 Jan 2026 06:50:09 -0800 (PST)
Message-ID: <363e440d-4e29-4286-ade4-b4be2f856859@arm.com>
Date: Fri, 2 Jan 2026 14:50:07 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] KVM: selftests: arm64: Skip all 32 bit IDs when
 set_id_regs is aarch64 only
To: Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Oliver Upton <oupton@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251219-kvm-arm64-set-id-regs-aarch64-v3-0-bfa474ec3218@kernel.org>
 <20251219-kvm-arm64-set-id-regs-aarch64-v3-4-bfa474ec3218@kernel.org>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251219-kvm-arm64-set-id-regs-aarch64-v3-4-bfa474ec3218@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark,

On 12/19/25 19:28, Mark Brown wrote:
> On an aarch64 only system the 32 bit ID registers have UNDEFINED values.
> As a result set_id_regs skips tests for setting fields in these registers
> when testing an aarch64 only guest. This has the side effect of meaning
> that we don't record an expected value for these registers, meaning that
> when the subsequent tests for values being visible in guests and preserved
> over reset check the value they can spuriously fail. This can be seen by
> running on an emulated system with both NV and 32 bit enabled, NV will
> result in the guests created by the test program being 64 bit only but
> the 32 bit ID registers will have values.
> 
> Also skip those tests that use the values set in the field setting tests
> for aarch64 only guests in order to avoid these spurious failures.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/kvm/arm64/set_id_regs.c | 42 +++++++++++++++++--------
>  1 file changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
> index 5837da63e9b9..f19ba949aa18 100644
> --- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
> +++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
> @@ -675,7 +675,7 @@ static void test_user_set_mte_reg(struct kvm_vcpu *vcpu)
>  		ksft_test_result_pass("ID_AA64PFR1_EL1.MTE_frac no longer 0xF\n");
>  }
>  
> -static void test_guest_reg_read(struct kvm_vcpu *vcpu)
> +static void test_guest_reg_read(struct kvm_vcpu *vcpu, bool aarch64_only)
>  {
>  	bool done = false;
>  	struct ucall uc;
> @@ -694,6 +694,13 @@ static void test_guest_reg_read(struct kvm_vcpu *vcpu)
>  			reg_id = uc.args[2];
>  			guest_val = uc.args[3];
>  			expected_val = test_reg_vals[encoding_to_range_idx(reg_id)];
> +
> +			if (aarch64_only && sys_reg_CRm(reg_id) < 4) {
> +				ksft_test_result_skip("%s value seen in guest\n",
> +						      get_reg_name(reg_id));
> +				break;
> +			}
> +

Unnecessary? The decision for which regs are testing is made in
guest_code().

>  			match = expected_val == guest_val;
>  			if (!match)
>  				ksft_print_msg("%lx != %lx\n",
> @@ -785,12 +792,19 @@ static void test_vcpu_non_ftr_id_regs(struct kvm_vcpu *vcpu)
>  	ksft_test_result_pass("%s\n", __func__);
>  }
>  
> -static void test_assert_id_reg_unchanged(struct kvm_vcpu *vcpu, uint32_t encoding)
> +static void test_assert_id_reg_unchanged(struct kvm_vcpu *vcpu, uint32_t encoding,
> +					 bool aarch64_only)
>  {
>  	size_t idx = encoding_to_range_idx(encoding);
>  	uint64_t observed;
>  	bool pass;
>  
> +	if (aarch64_only && sys_reg_CRm(encoding) < 4) {

Doesn't this exclude more registers than needed? E.g. MIDR?

> +		ksft_test_result_skip("%s unchanged by reset\n",
> +				      get_reg_name(encoding));
> +		return;
> +	}
> +
>  	observed = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(encoding));
>  	pass = test_reg_vals[idx] == observed;
>  	if (!pass)
> @@ -801,7 +815,8 @@ static void test_assert_id_reg_unchanged(struct kvm_vcpu *vcpu, uint32_t encodin
>  
>  #define ID_REG_RESET_UNCHANGED_TEST (ARRAY_SIZE(test_regs) + 6)
>  
> -static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu)
> +static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu,
> +					 bool aarch64_only)
>  {
>  	/*
>  	 * Calls KVM_ARM_VCPU_INIT behind the scenes, which will do an
> @@ -810,14 +825,15 @@ static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu)
>  	aarch64_vcpu_setup(vcpu, NULL);
>  
>  	for (int i = 0; i < ARRAY_SIZE(test_regs); i++)
> -		test_assert_id_reg_unchanged(vcpu, test_regs[i].reg);
> -
> -	test_assert_id_reg_unchanged(vcpu, SYS_MPIDR_EL1);
> -	test_assert_id_reg_unchanged(vcpu, SYS_CLIDR_EL1);
> -	test_assert_id_reg_unchanged(vcpu, SYS_CTR_EL0);
> -	test_assert_id_reg_unchanged(vcpu, SYS_MIDR_EL1);
> -	test_assert_id_reg_unchanged(vcpu, SYS_REVIDR_EL1);
> -	test_assert_id_reg_unchanged(vcpu, SYS_AIDR_EL1);
> +		test_assert_id_reg_unchanged(vcpu, test_regs[i].reg,
> +					     aarch64_only);
> +
> +	test_assert_id_reg_unchanged(vcpu, SYS_MPIDR_EL1, aarch64_only);
> +	test_assert_id_reg_unchanged(vcpu, SYS_CLIDR_EL1, aarch64_only);
> +	test_assert_id_reg_unchanged(vcpu, SYS_CTR_EL0, aarch64_only);
> +	test_assert_id_reg_unchanged(vcpu, SYS_MIDR_EL1, aarch64_only);
> +	test_assert_id_reg_unchanged(vcpu, SYS_REVIDR_EL1, aarch64_only);
> +	test_assert_id_reg_unchanged(vcpu, SYS_AIDR_EL1, aarch64_only);
>  }
>  
>  int main(void)
> @@ -859,9 +875,9 @@ int main(void)
>  	test_user_set_mpam_reg(vcpu);
>  	test_user_set_mte_reg(vcpu);
>  
> -	test_guest_reg_read(vcpu);
> +	test_guest_reg_read(vcpu, aarch64_only);
>  
> -	test_reset_preserves_id_regs(vcpu);
> +	test_reset_preserves_id_regs(vcpu, aarch64_only);
>  
>  	kvm_vm_free(vm);
>  
> 

Thanks,

Ben


