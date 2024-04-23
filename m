Return-Path: <linux-kselftest+bounces-8672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B41F98AE05A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63391C216D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 08:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166E956443;
	Tue, 23 Apr 2024 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VTpMz9Ww"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753E9535DB;
	Tue, 23 Apr 2024 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862648; cv=none; b=AbYaEA01pBatqr79AdEivNL8uibO1mCjnKpGIz+iU6E+H9Wo+b7uKObC++VGrP/kgZE8PNcNf8QjNkop/FcH62lTvzIz17Ap3xMJ3NNuQW7cy07D6tg85FVetaETijZtFZ/JxCsP0fjF2wdToNImO+5Xv6ZRraaR5kpw0grV0cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862648; c=relaxed/simple;
	bh=/J+7/5pAnCJZgG8yc+8aQ74lR6C159dQHgBY5X6f8kg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kQUquRZB3gt40yD+Ah3OXpyXlIfJ4etSsj0mJosTNkK9GY/EA8vqpdHh2PhftC9tw5dULuv5v9WEsa/egIy+a/1HQQbFy4AmiEUdt0i/ugezxQlNfxBaRZFjlzV4iM1X8bWxlNLS7NG2LP1Cge5FqCqaETVE/Nv6NPJPIT87iVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VTpMz9Ww; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713862644;
	bh=/J+7/5pAnCJZgG8yc+8aQ74lR6C159dQHgBY5X6f8kg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=VTpMz9Ww/4VuZMsdOJX43BEwWNryUhv5YdN2Ongq6S9TqMmeTR4PgAcCf6Xwjs+IE
	 TpKXLEAXfLF5/NNCkJ+WpieeKCDE+DXJtqqXsDbNmYWI+zua72bTtuIJJ1FDvMaPvO
	 vhjjJSwYoMWDA4KHfwklQc/SFa0VXT9lvVxr0F2MDumB0X4BPy3Fxk9XHF7bgm3tZw
	 Yg8ybMyoM/fSzcU0HwA/i9RhmMdY/M1wSpEfEd5r6+ahKCiCAcjncH/Is1Tw7vf7V9
	 TBopoZapaAKMkSB2Qy/EFDLeCMQWHMtL5+Xl+pYwTVCADt/vlxi02ynGPJKFVnFCUT
	 lb57pBE0/bn3A==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 67ABB37820AB;
	Tue, 23 Apr 2024 08:57:16 +0000 (UTC)
Message-ID: <bc284bf8-c74d-4601-ab64-79b5cc12f829@collabora.com>
Date: Tue, 23 Apr 2024 13:57:50 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Anup Patel <anup@brainfault.org>,
 samuel.holland@sifive.com, Conor Dooley <conor.dooley@microchip.com>,
 Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v8 18/24] KVM: riscv: selftests: Add helper functions for
 extension checks
To: Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org
References: <20240420151741.962500-1-atishp@rivosinc.com>
 <20240420151741.962500-19-atishp@rivosinc.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240420151741.962500-19-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/20/24 8:17 PM, Atish Patra wrote:
> __vcpu_has_ext can check both SBI and ISA extensions when the first
> argument is properly converted to SBI/ISA extension IDs. Introduce
> two helper functions to make life easier for developers so they
> don't have to worry about the conversions.
> 
> Replace the current usages as well with new helpers.
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
LGTM

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/kvm/include/riscv/processor.h | 10 ++++++++++
>  tools/testing/selftests/kvm/riscv/arch_timer.c        |  2 +-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> index 3b9cb39327ff..5f389166338c 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -50,6 +50,16 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t subtype,
>  
>  bool __vcpu_has_ext(struct kvm_vcpu *vcpu, uint64_t ext);
>  
> +static inline bool __vcpu_has_isa_ext(struct kvm_vcpu *vcpu, uint64_t isa_ext)
> +{
> +	return __vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(isa_ext));
> +}
> +
> +static inline bool __vcpu_has_sbi_ext(struct kvm_vcpu *vcpu, uint64_t sbi_ext)
> +{
> +	return __vcpu_has_ext(vcpu, RISCV_SBI_EXT_REG(sbi_ext));
> +}
> +
>  struct ex_regs {
>  	unsigned long ra;
>  	unsigned long sp;
> diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testing/selftests/kvm/riscv/arch_timer.c
> index 0f9cabd99fd4..735b78569021 100644
> --- a/tools/testing/selftests/kvm/riscv/arch_timer.c
> +++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
> @@ -85,7 +85,7 @@ struct kvm_vm *test_vm_create(void)
>  	int nr_vcpus = test_args.nr_vcpus;
>  
>  	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
> -	__TEST_REQUIRE(__vcpu_has_ext(vcpus[0], RISCV_ISA_EXT_REG(KVM_RISCV_ISA_EXT_SSTC)),
> +	__TEST_REQUIRE(__vcpu_has_isa_ext(vcpus[0], KVM_RISCV_ISA_EXT_SSTC),
>  				   "SSTC not available, skipping test\n");
>  
>  	vm_init_vector_tables(vm);

-- 
BR,
Muhammad Usama Anjum

