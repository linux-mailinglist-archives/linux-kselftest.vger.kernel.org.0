Return-Path: <linux-kselftest+bounces-8671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF708AE057
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153821C218BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 08:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C152C55C2A;
	Tue, 23 Apr 2024 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="24aP48Ua"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2494335D3;
	Tue, 23 Apr 2024 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862638; cv=none; b=sSk+ECRFT2j93XXfuVofxt/38OJ7N9cbsC+V8T7Qvc525yji5nrM/lZyDrUo9bVZ2FNEC+20es7Vj3hz/hksEmcjYcWjkcHS8ubeaKA9fShxIsFa5fF1IfMVQDa3dxglUE1e/gGFOxMpZ6Bgap/R4VAF14s1l8IkpfmEpX6zdus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862638; c=relaxed/simple;
	bh=3J/YEuFRs0KYJ9Z+iIiF4XhmgOCD3BSs6Mi2sdMmrWw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lHjWY57prInJkGa4aYEIujW43MQeRU9G1czYZ6RSMPRiCsY5tk9CkPGTtdSSDZPdJ4TIzm9Qz+KUsiMk7RI2EciSNRLjQsxb9wOa2kD9+fv4nLvAWBgdfMPKlfWnGwxraS3PEE3XIvz9c9zvX8c+bOjVLG+3Uax97Cjp0jDAo6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=24aP48Ua; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713862634;
	bh=3J/YEuFRs0KYJ9Z+iIiF4XhmgOCD3BSs6Mi2sdMmrWw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=24aP48UaQ5ZFS9vzTH7YzFs79ns51eJD//2DTq22QWlxPtYO7kU0V9rZizGCPGVxL
	 BCVo3XIQHbxs5KWXfuJq+UtAGgkpcLXGK7xEUDIhIRPeIv3cuk1EsR58Ylt+5AaW02
	 AkNHkHfH0sbHQDsEG68ktiMZP4u1UvolowzOWXpM8v9zWmfXhoUpJNuC1A/t9SK7vF
	 BK4Jgnza4FAeSHHvmAn3WC8hERurdLZiKE8sekWDdplh3R6BS+JiJ6htlYA/FBPQCu
	 uGT91i06KaZgvzk8j9AwQCpu1RGUAdv37nadtNhJ/c3RjyyB4IdBhOqmSK/s7J3LZZ
	 SLSZmZB9D5mFw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 819843781183;
	Tue, 23 Apr 2024 08:57:08 +0000 (UTC)
Message-ID: <eba0baca-1aea-4e8b-a68b-16cfdbc45403@collabora.com>
Date: Tue, 23 Apr 2024 13:57:35 +0500
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
Subject: Re: [PATCH v8 17/24] KVM: riscv: selftests: Move sbi definitions to
 its own header file
To: Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org
References: <20240420151741.962500-1-atishp@rivosinc.com>
 <20240420151741.962500-18-atishp@rivosinc.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240420151741.962500-18-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/20/24 8:17 PM, Atish Patra wrote:
> The SBI definitions will continue to grow. Move the sbi related
> definitions to its own header file from processor.h
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
LGTM

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  .../selftests/kvm/include/riscv/processor.h   | 39 ---------------
>  .../testing/selftests/kvm/include/riscv/sbi.h | 50 +++++++++++++++++++
>  .../selftests/kvm/include/riscv/ucall.h       |  1 +
>  tools/testing/selftests/kvm/steal_time.c      |  4 +-
>  4 files changed, 54 insertions(+), 40 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/riscv/sbi.h
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> index ce473fe251dd..3b9cb39327ff 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -154,45 +154,6 @@ void vm_install_interrupt_handler(struct kvm_vm *vm, exception_handler_fn handle
>  #define PGTBL_PAGE_SIZE				PGTBL_L0_BLOCK_SIZE
>  #define PGTBL_PAGE_SIZE_SHIFT			PGTBL_L0_BLOCK_SHIFT
>  
> -/* SBI return error codes */
> -#define SBI_SUCCESS				0
> -#define SBI_ERR_FAILURE				-1
> -#define SBI_ERR_NOT_SUPPORTED			-2
> -#define SBI_ERR_INVALID_PARAM			-3
> -#define SBI_ERR_DENIED				-4
> -#define SBI_ERR_INVALID_ADDRESS			-5
> -#define SBI_ERR_ALREADY_AVAILABLE		-6
> -#define SBI_ERR_ALREADY_STARTED			-7
> -#define SBI_ERR_ALREADY_STOPPED			-8
> -
> -#define SBI_EXT_EXPERIMENTAL_START		0x08000000
> -#define SBI_EXT_EXPERIMENTAL_END		0x08FFFFFF
> -
> -#define KVM_RISCV_SELFTESTS_SBI_EXT		SBI_EXT_EXPERIMENTAL_END
> -#define KVM_RISCV_SELFTESTS_SBI_UCALL		0
> -#define KVM_RISCV_SELFTESTS_SBI_UNEXP		1
> -
> -enum sbi_ext_id {
> -	SBI_EXT_BASE = 0x10,
> -	SBI_EXT_STA = 0x535441,
> -};
> -
> -enum sbi_ext_base_fid {
> -	SBI_EXT_BASE_PROBE_EXT = 3,
> -};
> -
> -struct sbiret {
> -	long error;
> -	long value;
> -};
> -
> -struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> -			unsigned long arg1, unsigned long arg2,
> -			unsigned long arg3, unsigned long arg4,
> -			unsigned long arg5);
> -
> -bool guest_sbi_probe_extension(int extid, long *out_val);
> -
>  static inline void local_irq_enable(void)
>  {
>  	csr_set(CSR_SSTATUS, SR_SIE);
> diff --git a/tools/testing/selftests/kvm/include/riscv/sbi.h b/tools/testing/selftests/kvm/include/riscv/sbi.h
> new file mode 100644
> index 000000000000..ba04f2dec7b5
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/riscv/sbi.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * RISC-V SBI specific definitions
> + *
> + * Copyright (C) 2024 Rivos Inc.
> + */
> +
> +#ifndef SELFTEST_KVM_SBI_H
> +#define SELFTEST_KVM_SBI_H
> +
> +/* SBI return error codes */
> +#define SBI_SUCCESS				 0
> +#define SBI_ERR_FAILURE				-1
> +#define SBI_ERR_NOT_SUPPORTED			-2
> +#define SBI_ERR_INVALID_PARAM			-3
> +#define SBI_ERR_DENIED				-4
> +#define SBI_ERR_INVALID_ADDRESS			-5
> +#define SBI_ERR_ALREADY_AVAILABLE		-6
> +#define SBI_ERR_ALREADY_STARTED			-7
> +#define SBI_ERR_ALREADY_STOPPED			-8
> +
> +#define SBI_EXT_EXPERIMENTAL_START		0x08000000
> +#define SBI_EXT_EXPERIMENTAL_END		0x08FFFFFF
> +
> +#define KVM_RISCV_SELFTESTS_SBI_EXT		SBI_EXT_EXPERIMENTAL_END
> +#define KVM_RISCV_SELFTESTS_SBI_UCALL		0
> +#define KVM_RISCV_SELFTESTS_SBI_UNEXP		1
> +
> +enum sbi_ext_id {
> +	SBI_EXT_BASE = 0x10,
> +	SBI_EXT_STA = 0x535441,
> +};
> +
> +enum sbi_ext_base_fid {
> +	SBI_EXT_BASE_PROBE_EXT = 3,
> +};
> +
> +struct sbiret {
> +	long error;
> +	long value;
> +};
> +
> +struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> +			unsigned long arg1, unsigned long arg2,
> +			unsigned long arg3, unsigned long arg4,
> +			unsigned long arg5);
> +
> +bool guest_sbi_probe_extension(int extid, long *out_val);
> +
> +#endif /* SELFTEST_KVM_SBI_H */
> diff --git a/tools/testing/selftests/kvm/include/riscv/ucall.h b/tools/testing/selftests/kvm/include/riscv/ucall.h
> index be46eb32ec27..a695ae36f3e0 100644
> --- a/tools/testing/selftests/kvm/include/riscv/ucall.h
> +++ b/tools/testing/selftests/kvm/include/riscv/ucall.h
> @@ -3,6 +3,7 @@
>  #define SELFTEST_KVM_UCALL_H
>  
>  #include "processor.h"
> +#include "sbi.h"
>  
>  #define UCALL_EXIT_REASON       KVM_EXIT_RISCV_SBI
>  
> diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
> index bae0c5026f82..2ff82c7fd926 100644
> --- a/tools/testing/selftests/kvm/steal_time.c
> +++ b/tools/testing/selftests/kvm/steal_time.c
> @@ -11,7 +11,9 @@
>  #include <pthread.h>
>  #include <linux/kernel.h>
>  #include <asm/kvm.h>
> -#ifndef __riscv
> +#ifdef __riscv
> +#include "sbi.h"
> +#else
>  #include <asm/kvm_para.h>
>  #endif
>  

-- 
BR,
Muhammad Usama Anjum

