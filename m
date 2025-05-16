Return-Path: <linux-kselftest+bounces-33235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC840ABA6CF
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 01:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07A94A889F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 23:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FB0281505;
	Fri, 16 May 2025 23:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pX95yTsD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C4E280A3B
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747439908; cv=none; b=oT2c7Hgt9jNL0MyKefF+bYn9RTt/lKi8evxcZB702MGTMnecpTCNoleR0wyy+Xd8aCB4aoH4FpVAd1QWuEyy3c78NswP41oe84CwmwlqOtsNo8h3J7aAmQ6H6DHCLtPQP6YHn5iJUAoY0xWXzZ2zOsfvQpgfHHh6DQnKuOoudwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747439908; c=relaxed/simple;
	bh=pwVKSSy58H8/xVINe4a7dwbXnm8QeMVTsphrYZUu1Zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MiExSsUe3UyMa5moTphqcSMqbqaGUJ5WBdxmUHdT3neu3uNnYXG1EY/jLK6OIRi9+qEwyeFX8kmSvuh6WJZsC3Y62w5gFeYdF0isEdBk2K7y81aiE6Gmuu6Smy/yYkGqsGCn9Q8TWZrdoFSTVyXZSlBArr0CkRzuDCRXW+z2+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pX95yTsD; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8b11ba85-0c95-4b7a-9206-ead8099bc013@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747439893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EPRT6tmwQEpVbRbwRNdU0oFUqb9qQTxFeTyAspVLMs8=;
	b=pX95yTsDC3Ric+OnlCcVjjaBGP/p5qYQc46Vf3I4fAWFDb9NCt2l1vd9/H9mIMO1VrYswD
	6r3aU+1unjr5BQbqbkiPagtLp0NahXy+wMkgs4QbcfWls7AGoRy3phBMvUGtzMllVJvgx/
	/jv5Z0DY7BE2UvE65VhP7vtvmFGu6b4=
Date: Fri, 16 May 2025 16:57:47 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 14/14] RISC-V: KVM: add support for
 SBI_FWFT_MISALIGNED_DELEG
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>, Deepak Gupta <debug@rivosinc.com>
References: <20250515082217.433227-1-cleger@rivosinc.com>
 <20250515082217.433227-15-cleger@rivosinc.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20250515082217.433227-15-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/15/25 1:22 AM, ClÃ©ment LÃ©ger wrote:
> SBI_FWFT_MISALIGNED_DELEG needs hedeleg to be modified to delegate
> misaligned load/store exceptions. Save and restore it during CPU
> load/put.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   arch/riscv/kvm/vcpu_sbi_fwft.c | 41 ++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> 
> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
> index b0f66c7bf010..6770c043bbcb 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -14,6 +14,8 @@
>   #include <asm/kvm_vcpu_sbi.h>
>   #include <asm/kvm_vcpu_sbi_fwft.h>
>   
> +#define MIS_DELEG (BIT_ULL(EXC_LOAD_MISALIGNED) | BIT_ULL(EXC_STORE_MISALIGNED))
> +
>   struct kvm_sbi_fwft_feature {
>   	/**
>   	 * @id: Feature ID
> @@ -68,7 +70,46 @@ static bool kvm_fwft_is_defined_feature(enum sbi_fwft_feature_t feature)
>   	return false;
>   }
>   
> +static bool kvm_sbi_fwft_misaligned_delegation_supported(struct kvm_vcpu *vcpu)
> +{
> +	return misaligned_traps_can_delegate();
> +}
> +
> +static long kvm_sbi_fwft_set_misaligned_delegation(struct kvm_vcpu *vcpu,
> +					struct kvm_sbi_fwft_config *conf,
> +					unsigned long value)
> +{
> +	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
> +
> +	if (value == 1) {
> +		cfg->hedeleg |= MIS_DELEG;
> +		csr_set(CSR_HEDELEG, MIS_DELEG);
> +	} else if (value == 0) {
> +		cfg->hedeleg &= ~MIS_DELEG;
> +		csr_clear(CSR_HEDELEG, MIS_DELEG);
> +	} else {
> +		return SBI_ERR_INVALID_PARAM;
> +	}
> +
> +	return SBI_SUCCESS;
> +}
> +
> +static long kvm_sbi_fwft_get_misaligned_delegation(struct kvm_vcpu *vcpu,
> +					struct kvm_sbi_fwft_config *conf,
> +					unsigned long *value)
> +{
> +	*value = (csr_read(CSR_HEDELEG) & MIS_DELEG) == MIS_DELEG;
> +
> +	return SBI_SUCCESS;
> +}
> +
>   static const struct kvm_sbi_fwft_feature features[] = {
> +	{
> +		.id = SBI_FWFT_MISALIGNED_EXC_DELEG,
> +		.supported = kvm_sbi_fwft_misaligned_delegation_supported,
> +		.set = kvm_sbi_fwft_set_misaligned_delegation,
> +		.get = kvm_sbi_fwft_get_misaligned_delegation,
> +	},
>   };
>   
>   static struct kvm_sbi_fwft_config *

LGTM.
Reviewed-by: Atish Patra <atishp@rivosinc.com>

