Return-Path: <linux-kselftest+bounces-32016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE244AA43C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 09:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB2D4C519B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 07:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E36B7E107;
	Wed, 30 Apr 2025 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qpBXWR6r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2421DDC33
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745997740; cv=none; b=jx23AHI87moLQ3gjtE0hDdxWmZh1Xg1+kImu/tep9+zzg3g8Pjs5h9vJWrpe68lMwt2SjG4BX/OddgWLKlK6FRpo8rMqV5WvGnyogdOBCvQa4IA9joeesH2UCA6OW++0Kl3OTWLBWAxFaNciI65dWYR1CzFs+7eA5ZMDDqUfK2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745997740; c=relaxed/simple;
	bh=mzM4vtbuISg4Wb+EOHKPhCgdn+dAEtJGu6Dqv5z7Bo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJEpQxsWaDUvHSh9ARAxU8zoLwdSSGpqB+z016imUQmdPFP2fgRRaEmyQbq7AM48hYX8NpGojX7RUEUHQwXqa/ve2pO98lqIUTWw0eb9PMf/FFFvEzN9xMMuwjZ6D8MnFCYV+o7kpMwn2YJhgbg/uYhnUy6ayB2LG0yJxczJRSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qpBXWR6r; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f1a917d9-b225-4453-899b-4c8aa531d3a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745997736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GnwDRkFSU3cnku32BLVBhrZjOy1GqIkDBCu3BBxR2u8=;
	b=qpBXWR6rpXVjzMOmhaNdn0QDVX38Jlyd5/IFVdjFZMlbV0amPuPZExqqvWUeon6Vax62VV
	H3L9WXFE/CYJ894jiwT84kY47YDADwTVo7d2ceSsLmf8+t93UBT8BMstlmzPztP4NnW0wt
	06zqNFSLPryhkWkPnlkyp5MQUYQIpFE=
Date: Wed, 30 Apr 2025 00:22:11 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] KVM: riscv: selftests: Add vector extension tests
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250429-kvm_selftest_improve-v2-0-51713f91e04a@rivosinc.com>
 <20250429-kvm_selftest_improve-v2-3-51713f91e04a@rivosinc.com>
 <20250430-4790c7c3ea3623243f2d22ac@orel>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20250430-4790c7c3ea3623243f2d22ac@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/30/25 12:17 AM, Andrew Jones wrote:
> On Tue, Apr 29, 2025 at 05:18:47PM -0700, Atish Patra wrote:
>> Add vector related tests with the ISA extension standard template.
>> However, the vector registers are bit tricky as the register length is
>> variable based on vlenb value of the system. That's why the macros are
>> defined with a default and overidden with actual value at runtime.
>>
>> Reviewed-by: Anup Patel <anup@brainfault.org>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   tools/testing/selftests/kvm/riscv/get-reg-list.c | 133 +++++++++++++++++++++++
>>   1 file changed, 133 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
>> index 569f2d67c9b8..814dd981ce0b 100644
>> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
>> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
>> @@ -17,6 +17,15 @@ enum {
>>   	VCPU_FEATURE_SBI_EXT,
>>   };
>>   
>> +enum {
>> +	KVM_RISC_V_REG_OFFSET_VSTART = 0,
>> +	KVM_RISC_V_REG_OFFSET_VL,
>> +	KVM_RISC_V_REG_OFFSET_VTYPE,
>> +	KVM_RISC_V_REG_OFFSET_VCSR,
>> +	KVM_RISC_V_REG_OFFSET_VLENB,
>> +	KVM_RISC_V_REG_OFFSET_MAX,
>> +};
>> +
>>   static bool isa_ext_cant_disable[KVM_RISCV_ISA_EXT_MAX];
>>   
>>   bool filter_reg(__u64 reg)
>> @@ -143,6 +152,39 @@ bool check_reject_set(int err)
>>   	return err == EINVAL;
>>   }
>>   
>> +static int override_vector_reg_size(struct kvm_vcpu *vcpu, struct vcpu_reg_sublist *s,
>> +				    uint64_t feature)
>> +{
>> +	unsigned long vlenb_reg = 0;
>> +	int rc;
>> +	u64 reg, size;
>> +
>> +	/* Enable V extension so that we can get the vlenb register */
>> +	rc = __vcpu_set_reg(vcpu, feature, 1);
>> +	if (rc)
>> +		return rc;
>> +
>> +	__vcpu_get_reg(vcpu, s->regs[KVM_RISC_V_REG_OFFSET_VLENB], &vlenb_reg);
> We can remove the underscores from this call since it shouldn't fail, as
> we know we've successfully enabled the V extension at this point.
good point. I will remove it.
>> +
>> +	if (!vlenb_reg) {
>> +		TEST_FAIL("Can't compute vector register size from zero vlenb\n");
>> +		return -EPERM;
>> +	}
>> +
>> +	size = __builtin_ctzl(vlenb_reg);
>> +	size <<= KVM_REG_SIZE_SHIFT;
>> +
>> +	for (int i = 0; i < 32; i++) {
>> +		reg = KVM_REG_RISCV | KVM_REG_RISCV_VECTOR | size | KVM_REG_RISCV_VECTOR_REG(i);
>> +		s->regs[KVM_RISC_V_REG_OFFSET_MAX + i] = reg;
>> +	}
>> +
>> +	/* We should assert if disabling failed here while enabling succeeded before */
>> +	vcpu_set_reg(vcpu, feature, 0);
>> +
>> +	return 0;
>> +}
>> +
>>   void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
>>   {
>>   	unsigned long isa_ext_state[KVM_RISCV_ISA_EXT_MAX] = { 0 };
>> @@ -172,6 +214,13 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
>>   		if (!s->feature)
>>   			continue;
>>   
>> +		if (s->feature == KVM_RISCV_ISA_EXT_V) {
>> +			feature = RISCV_ISA_EXT_REG(s->feature);
>> +			rc = override_vector_reg_size(vcpu, s, feature);
>> +			if (rc)
>> +				goto skip;
>> +		}
>> +
>>   		switch (s->feature_type) {
>>   		case VCPU_FEATURE_ISA_EXT:
>>   			feature = RISCV_ISA_EXT_REG(s->feature);
>> @@ -186,6 +235,7 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
>>   		/* Try to enable the desired extension */
>>   		__vcpu_set_reg(vcpu, feature, 1);
>>   
>> +skip:
>>   		/* Double check whether the desired extension was enabled */
>>   		__TEST_REQUIRE(__vcpu_has_ext(vcpu, feature),
>>   			       "%s not available, skipping tests", s->name);
>> @@ -410,6 +460,35 @@ static const char *fp_d_id_to_str(const char *prefix, __u64 id)
>>   	return strdup_printf("%lld /* UNKNOWN */", reg_off);
>>   }
>>   
>> +static const char *vector_id_to_str(const char *prefix, __u64 id)
>> +{
>> +	/* reg_off is the offset into struct __riscv_v_ext_state */
>> +	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_VECTOR);
>> +	int reg_index = 0;
>> +
>> +	assert((id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_VECTOR);
>> +
>> +	if (reg_off >= KVM_REG_RISCV_VECTOR_REG(0))
>> +		reg_index = reg_off -  KVM_REG_RISCV_VECTOR_REG(0);
>> +	switch (reg_off) {
>> +	case KVM_REG_RISCV_VECTOR_REG(0) ...
>> +	     KVM_REG_RISCV_VECTOR_REG(31):
>> +		return strdup_printf("KVM_REG_RISCV_VECTOR_REG(%d)", reg_index);
>> +	case KVM_REG_RISCV_VECTOR_CSR_REG(vstart):
>> +		return "KVM_REG_RISCV_VECTOR_CSR_REG(vstart)";
>> +	case KVM_REG_RISCV_VECTOR_CSR_REG(vl):
>> +		return "KVM_REG_RISCV_VECTOR_CSR_REG(vl)";
>> +	case KVM_REG_RISCV_VECTOR_CSR_REG(vtype):
>> +		return "KVM_REG_RISCV_VECTOR_CSR_REG(vtype)";
>> +	case KVM_REG_RISCV_VECTOR_CSR_REG(vcsr):
>> +		return "KVM_REG_RISCV_VECTOR_CSR_REG(vcsr)";
>> +	case KVM_REG_RISCV_VECTOR_CSR_REG(vlenb):
>> +		return "KVM_REG_RISCV_VECTOR_CSR_REG(vlenb)";
>> +	}
>> +
>> +	return strdup_printf("%lld /* UNKNOWN */", reg_off);
>> +}
>> +
>>   #define KVM_ISA_EXT_ARR(ext)		\
>>   [KVM_RISCV_ISA_EXT_##ext] = "KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_" #ext
>>   
>> @@ -639,6 +718,9 @@ void print_reg(const char *prefix, __u64 id)
>>   	case KVM_REG_SIZE_U128:
>>   		reg_size = "KVM_REG_SIZE_U128";
>>   		break;
>> +	case KVM_REG_SIZE_U256:
>> +		reg_size = "KVM_REG_SIZE_U256";
>> +		break;
>>   	default:
>>   		printf("\tKVM_REG_RISCV | (%lld << KVM_REG_SIZE_SHIFT) | 0x%llx /* UNKNOWN */,\n",
>>   		       (id & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT, id & ~REG_MASK);
>> @@ -670,6 +752,10 @@ void print_reg(const char *prefix, __u64 id)
>>   		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_FP_D | %s,\n",
>>   				reg_size, fp_d_id_to_str(prefix, id));
>>   		break;
>> +	case KVM_REG_RISCV_VECTOR:
>> +		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_VECTOR | %s,\n",
>> +		       reg_size, vector_id_to_str(prefix, id));
>> +		break;
>>   	case KVM_REG_RISCV_ISA_EXT:
>>   		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_ISA_EXT | %s,\n",
>>   				reg_size, isa_ext_id_to_str(prefix, id));
>> @@ -874,6 +960,48 @@ static __u64 fp_d_regs[] = {
>>   	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_D,
>>   };
>>   
>> +/* Define a default vector registers with length. This will be overwritten at runtime */
>> +static __u64 vector_regs[] = {
>> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_CSR_REG(vstart),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_CSR_REG(vl),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_CSR_REG(vtype),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_CSR_REG(vcsr),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_CSR_REG(vlenb),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(0),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(1),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(2),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(3),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(4),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(5),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(6),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(7),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(8),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(9),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(10),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(11),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(12),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(13),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(14),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(15),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(16),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(17),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(18),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(19),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(20),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(21),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(22),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(23),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(24),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(25),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(26),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(27),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(28),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(29),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(30),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(31),
>> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_V,
>> +};
>> +
>>   #define SUBLIST_BASE \
>>   	{"base", .regs = base_regs, .regs_n = ARRAY_SIZE(base_regs), \
>>   	 .skips_set = base_skips_set, .skips_set_n = ARRAY_SIZE(base_skips_set),}
>> @@ -898,6 +1026,9 @@ static __u64 fp_d_regs[] = {
>>   	{"fp_d", .feature = KVM_RISCV_ISA_EXT_D, .regs = fp_d_regs, \
>>   		.regs_n = ARRAY_SIZE(fp_d_regs),}
>>   
>> +#define SUBLIST_V \
>> +	{"v", .feature = KVM_RISCV_ISA_EXT_V, .regs = vector_regs, .regs_n = ARRAY_SIZE(vector_regs),}
>> +
>>   #define KVM_ISA_EXT_SIMPLE_CONFIG(ext, extu)			\
>>   static __u64 regs_##ext[] = {					\
>>   	KVM_REG_RISCV | KVM_REG_SIZE_ULONG |			\
>> @@ -966,6 +1097,7 @@ KVM_SBI_EXT_SIMPLE_CONFIG(susp, SUSP);
>>   KVM_ISA_EXT_SUBLIST_CONFIG(aia, AIA);
>>   KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
>>   KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
>> +KVM_ISA_EXT_SUBLIST_CONFIG(v, V);
>>   KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
>>   KVM_ISA_EXT_SIMPLE_CONFIG(smnpm, SMNPM);
>>   KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
>> @@ -1040,6 +1172,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
>>   	&config_fp_f,
>>   	&config_fp_d,
>>   	&config_h,
>> +	&config_v,
>>   	&config_smnpm,
>>   	&config_smstateen,
>>   	&config_sscofpmf,
>>
>> -- 
>> 2.43.0
>>
> Otherwise,
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

