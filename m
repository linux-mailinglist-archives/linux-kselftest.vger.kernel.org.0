Return-Path: <linux-kselftest+bounces-32011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D742AA4386
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 09:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0461BC634D
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 07:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906731EFF81;
	Wed, 30 Apr 2025 07:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lYgjDgTP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E40F1EEA49
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 07:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745996736; cv=none; b=q6oDyzM7uDw7wpEFXdYa/UbFKQHyZ82KFqxhrK5T/jEbCa+noienEYrQQEQO5m0wpQUIBD63LRykx6cVdAKnNp/MHgMkjQmhhwBxOrr6l0T4Z9gO1gSZAkdwswVfv2FjX8XeMk4FC9wTrMgZZWg16dfcEvg8i0JpZfC2amNt+HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745996736; c=relaxed/simple;
	bh=mXAUzo8UDCkMwKAGpVSG2c9D+0tPPhPL3/Z4Wd5YpEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hp1PnDbDuzVrvuFk/TOZCt3RwFperKMGM7LM+dfHxrfsHs3Z6I1yfRs4GgE6gU/vNU9JaGGmn1hhw2aZ8DQTnNk4Kr7R9KSlsS113bhPHLMBS801/J8vaB4sRP+oGBprDPC08WrrFUl3i1zHQY6anmkEKj/zcnYAr5ZxJHPXWMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lYgjDgTP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso43496755e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 00:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1745996731; x=1746601531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SVvfYimiPZS6cg4U084sfnLSo48so/ncOUQmetF/XDo=;
        b=lYgjDgTPfXb6gCG8RSnO0U3k1JDBoO9vhtg1stGmi/tfVxlyx38T3Z0YBksOTlopDy
         1wEfZUpi5Oc5uT1WkEM6L3aZNCpSs7fEjbhPt+ROz2SZKpahYLud9WXuuj9nmEjvoGbN
         IRE3hMS8ezxgTi6Ogn7Hepv25bSctKCg78OMczSpfJ7JIv1ZlHjpxub3RbwMD1KMvkEX
         tYvSFvpjo2XaYvaOZRSy3hUvJX1Rbj1kT4O+gtyyvFIyn9UTQH3juYqghg2RwNabFDuz
         3XyUokQ7tpPRg65vpmoRQqzdKXy0g2YjmVQUQoegztEGr3bFo5gE7J7cHUDwj2UmcNWr
         KloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745996731; x=1746601531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVvfYimiPZS6cg4U084sfnLSo48so/ncOUQmetF/XDo=;
        b=TCZr5RBS0XtTzrCzbji3c87Z6g4kR0I6dUuo+jRwbp1yjQpoemjnMskI5ldMXn1qwW
         Q1q1L2WZI7rA7OGjJLAUUkSFFFnoHbcELXoqpQ5GIPec5dAIaNkp/QogyYgxgHhKuGvb
         aWksdUwaFC76yjPyiFwR4LLNAI+zljXljqbWwN0pufatc5LNj7byDWEgvTbJaD6xd+FJ
         6kMr/1fHv+9q5ZSSYVs+J/8O6nOIAISN6aa4ODa9SJ0LgApzkALI7/UiHcVJ27fD2fo8
         3I/o8ZbTzD0G+NCHHcql7ZEzCuTw1Xk3MdyZFLKQiEN+kzCAoxbQC+hYScxNwOxphbYC
         Nxfg==
X-Forwarded-Encrypted: i=1; AJvYcCWNeuFT2507bUs58x7kWgw5Z+Q79lRvaTiWAw6+2/wb8Gsv1vzuS4KVvNxQZsFnRuC8qBCTZX5r93cQCGWJLbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6iosILIO/QUar4vldbKYJBrHW9RHmPXaFkf7rPFCWm3Gqqa/7
	Wk0nKYhc2ojN+FicbkWJYQIeHK0u40QDtJIfJNDft7oid6ANdWwAcf1yHV9E0jE=
X-Gm-Gg: ASbGncuKqrfqxBbyXVMoqpv4OI6mCotEA6OPsV/DTwj16cwEjtC0EJN7QbJ9G5+XMZ+
	6E0fKCrTy0PvX9c/DoST8OLGpBFQgLWea/WTvLIRtRLBoYlydeeiKVl1pX69NAc3MSF2YsqI7GO
	G0BXmouAFwh7ZE5MAwn5qsnmW86PZer6521RJkbUmdtRJLKE1n0R3FhrLZggRsLMj4uE634FdHW
	ZsGcfgVVPSBpMYwjpOPa8VrMUhEIJiKfg3UZGk35vn+m8oEvViaE5YIRdATrr0kyl6KIXAbGal1
	sN2YiAWeAnzo5kl0idDQ8+xYfmAL
X-Google-Smtp-Source: AGHT+IEdF7Ranbsc/bcaoboCh6IHK4P6VnQG9MxQM+0axTJmPOKs4W5R61X+N8DpwJd52q+rA2++PA==
X-Received: by 2002:a05:600c:1d91:b0:43c:f44c:72b7 with SMTP id 5b1f17b1804b1-441b1f35e37mr18239195e9.14.1745996731411;
        Wed, 30 Apr 2025 00:05:31 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2bbc0a2sm13050305e9.30.2025.04.30.00.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 00:05:30 -0700 (PDT)
Date: Wed, 30 Apr 2025 09:05:30 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] KVM: riscv: selftests: Align the trap information
 wiht pt_regs
Message-ID: <20250430-92907020fba3f6ee328e821d@orel>
References: <20250429-kvm_selftest_improve-v2-0-51713f91e04a@rivosinc.com>
 <20250429-kvm_selftest_improve-v2-1-51713f91e04a@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429-kvm_selftest_improve-v2-1-51713f91e04a@rivosinc.com>

On Tue, Apr 29, 2025 at 05:18:45PM -0700, Atish Patra wrote:
> The current exeception register structure in selftests are missing
> few registers (e.g stval). Instead of adding it manually, change
> the ex_regs to align with pt_regs to make it future proof.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  .../selftests/kvm/include/riscv/processor.h        |  10 +-
>  tools/testing/selftests/kvm/lib/riscv/handlers.S   | 164 ++++++++++++---------
>  tools/testing/selftests/kvm/lib/riscv/processor.c  |   2 +-
>  tools/testing/selftests/kvm/riscv/arch_timer.c     |   2 +-
>  tools/testing/selftests/kvm/riscv/ebreak_test.c    |   2 +-
>  tools/testing/selftests/kvm/riscv/sbi_pmu_test.c   |   4 +-
>  6 files changed, 104 insertions(+), 80 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> index 5f389166338c..1b5aef87de0f 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -60,7 +60,8 @@ static inline bool __vcpu_has_sbi_ext(struct kvm_vcpu *vcpu, uint64_t sbi_ext)
>  	return __vcpu_has_ext(vcpu, RISCV_SBI_EXT_REG(sbi_ext));
>  }
>  
> -struct ex_regs {
> +struct pt_regs {
> +	unsigned long epc;
>  	unsigned long ra;
>  	unsigned long sp;
>  	unsigned long gp;
> @@ -92,16 +93,19 @@ struct ex_regs {
>  	unsigned long t4;
>  	unsigned long t5;
>  	unsigned long t6;
> -	unsigned long epc;
> +	/* Supervisor/Machine CSRs */
>  	unsigned long status;
> +	unsigned long badaddr;
>  	unsigned long cause;
> +	/* a0 value before the syscall */
> +	unsigned long orig_a0;
>  };
>  
>  #define NR_VECTORS  2
>  #define NR_EXCEPTIONS  32
>  #define EC_MASK  (NR_EXCEPTIONS - 1)
>  
> -typedef void(*exception_handler_fn)(struct ex_regs *);
> +typedef void(*exception_handler_fn)(struct pt_regs *);
>  
>  void vm_init_vector_tables(struct kvm_vm *vm);
>  void vcpu_init_vector_tables(struct kvm_vcpu *vcpu);
> diff --git a/tools/testing/selftests/kvm/lib/riscv/handlers.S b/tools/testing/selftests/kvm/lib/riscv/handlers.S
> index aa0abd3f35bb..9c99b258cae7 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/handlers.S
> +++ b/tools/testing/selftests/kvm/lib/riscv/handlers.S
> @@ -9,86 +9,106 @@
>  
>  #include <asm/csr.h>
>  
> +#ifdef __ASSEMBLY__
> +#define __ASM_STR(x)	x
> +#else
> +#define __ASM_STR(x)	#x
> +#endif

We should always have __ASSEMBLY__ (or actually __ASSMEBLER__) defined
when compiling this .S file.

> +
> +#if __riscv_xlen == 64
> +#define __REG_SEL(a, b)	__ASM_STR(a)
> +#elif __riscv_xlen == 32
> +#define __REG_SEL(a, b)	__ASM_STR(b)
> +#else
> +#error "Unexpected __riscv_xlen"
> +#endif
> +
> +#define REG_L		__REG_SEL(ld, lw)
> +#define REG_S		__REG_SEL(sd, sw)

We don't need these macros since we only support 64-bit. We always
have -DCONFIG_64BIT appended to CFLAGS. But it doesn't hurt to
have them either...

> +
>  .macro save_context
> -	addi  sp, sp, (-8*34)
> -	sd    x1, 0(sp)
> -	sd    x2, 8(sp)
> -	sd    x3, 16(sp)
> -	sd    x4, 24(sp)
> -	sd    x5, 32(sp)
> -	sd    x6, 40(sp)
> -	sd    x7, 48(sp)
> -	sd    x8, 56(sp)
> -	sd    x9, 64(sp)
> -	sd    x10, 72(sp)
> -	sd    x11, 80(sp)
> -	sd    x12, 88(sp)
> -	sd    x13, 96(sp)
> -	sd    x14, 104(sp)
> -	sd    x15, 112(sp)
> -	sd    x16, 120(sp)
> -	sd    x17, 128(sp)
> -	sd    x18, 136(sp)
> -	sd    x19, 144(sp)
> -	sd    x20, 152(sp)
> -	sd    x21, 160(sp)
> -	sd    x22, 168(sp)
> -	sd    x23, 176(sp)
> -	sd    x24, 184(sp)
> -	sd    x25, 192(sp)
> -	sd    x26, 200(sp)
> -	sd    x27, 208(sp)
> -	sd    x28, 216(sp)
> -	sd    x29, 224(sp)
> -	sd    x30, 232(sp)
> -	sd    x31, 240(sp)
> +	addi  sp, sp, (-8*36)
> +	REG_S    x1, 8(sp)
> +	REG_S    x2, 16(sp)
> +	REG_S    x3, 24(sp)
> +	REG_S    x4, 32(sp)
> +	REG_S    x5, 40(sp)
> +	REG_S    x6, 48(sp)
> +	REG_S    x7, 56(sp)
> +	REG_S    x8, 64(sp)
> +	REG_S    x9, 72(sp)
> +	REG_S    x10, 80(sp)
> +	REG_S    x11, 88(sp)
> +	REG_S    x12, 96(sp)
> +	REG_S    x13, 104(sp)
> +	REG_S    x14, 112(sp)
> +	REG_S    x15, 120(sp)
> +	REG_S    x16, 128(sp)
> +	REG_S    x17, 136(sp)
> +	REG_S    x18, 144(sp)
> +	REG_S    x19, 152(sp)
> +	REG_S    x20, 160(sp)
> +	REG_S    x21, 168(sp)
> +	REG_S    x22, 176(sp)
> +	REG_S    x23, 184(sp)
> +	REG_S    x24, 192(sp)
> +	REG_S    x25, 200(sp)
> +	REG_S    x26, 208(sp)
> +	REG_S    x27, 216(sp)
> +	REG_S    x28, 224(sp)
> +	REG_S    x29, 232(sp)
> +	REG_S    x30, 240(sp)
> +	REG_S    x31, 248(sp)
>  	csrr  s0, CSR_SEPC
>  	csrr  s1, CSR_SSTATUS
> -	csrr  s2, CSR_SCAUSE
> -	sd    s0, 248(sp)
> -	sd    s1, 256(sp)
> -	sd    s2, 264(sp)
> +	csrr  s2, CSR_STVAL
> +	csrr  s3, CSR_SCAUSE
> +	REG_S    s0, 0(sp)
> +	REG_S    s1, 256(sp)
> +	REG_S    s2, 264(sp)
> +	REG_S    s3, 272(sp)
>  .endm
>  
>  .macro restore_context
> -	ld    s2, 264(sp)
> -	ld    s1, 256(sp)
> -	ld    s0, 248(sp)
> -	csrw  CSR_SCAUSE, s2
> +	REG_L    s3, 272(sp)
> +	REG_L    s2, 264(sp)
> +	REG_L    s1, 256(sp)
> +	REG_L    s0, 0(sp)
> +	csrw  CSR_SCAUSE, s3
>  	csrw  CSR_SSTATUS, s1
>  	csrw  CSR_SEPC, s0
> -	ld    x31, 240(sp)
> -	ld    x30, 232(sp)
> -	ld    x29, 224(sp)
> -	ld    x28, 216(sp)
> -	ld    x27, 208(sp)
> -	ld    x26, 200(sp)
> -	ld    x25, 192(sp)
> -	ld    x24, 184(sp)
> -	ld    x23, 176(sp)
> -	ld    x22, 168(sp)
> -	ld    x21, 160(sp)
> -	ld    x20, 152(sp)
> -	ld    x19, 144(sp)
> -	ld    x18, 136(sp)
> -	ld    x17, 128(sp)
> -	ld    x16, 120(sp)
> -	ld    x15, 112(sp)
> -	ld    x14, 104(sp)
> -	ld    x13, 96(sp)
> -	ld    x12, 88(sp)
> -	ld    x11, 80(sp)
> -	ld    x10, 72(sp)
> -	ld    x9, 64(sp)
> -	ld    x8, 56(sp)
> -	ld    x7, 48(sp)
> -	ld    x6, 40(sp)
> -	ld    x5, 32(sp)
> -	ld    x4, 24(sp)
> -	ld    x3, 16(sp)
> -	ld    x2, 8(sp)
> -	ld    x1, 0(sp)
> -	addi  sp, sp, (8*34)
> +	REG_L    x31, 248(sp)
> +	REG_L    x30, 240(sp)
> +	REG_L    x29, 232(sp)
> +	REG_L    x28, 224(sp)
> +	REG_L    x27, 216(sp)
> +	REG_L    x26, 208(sp)
> +	REG_L    x25, 200(sp)
> +	REG_L    x24, 192(sp)
> +	REG_L    x23, 184(sp)
> +	REG_L    x22, 176(sp)
> +	REG_L    x21, 168(sp)
> +	REG_L    x20, 160(sp)
> +	REG_L    x19, 152(sp)
> +	REG_L    x18, 144(sp)
> +	REG_L    x17, 136(sp)
> +	REG_L    x16, 128(sp)
> +	REG_L    x15, 120(sp)
> +	REG_L    x14, 112(sp)
> +	REG_L    x13, 104(sp)
> +	REG_L    x12, 96(sp)
> +	REG_L    x11, 88(sp)
> +	REG_L    x10, 80(sp)
> +	REG_L    x9, 72(sp)
> +	REG_L    x8, 64(sp)
> +	REG_L    x7, 56(sp)
> +	REG_L    x6, 48(sp)
> +	REG_L    x5, 40(sp)
> +	REG_L    x4, 32(sp)
> +	REG_L    x3, 24(sp)
> +	REG_L    x2, 16(sp)
> +	REG_L    x1, 8(sp)
> +	addi  sp, sp, (8*36)
>  .endm
>  
>  .balign 4
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
> index dd663bcf0cc0..2eac7d4b59e9 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -402,7 +402,7 @@ struct handlers {
>  	exception_handler_fn exception_handlers[NR_VECTORS][NR_EXCEPTIONS];
>  };
>  
> -void route_exception(struct ex_regs *regs)
> +void route_exception(struct pt_regs *regs)
>  {
>  	struct handlers *handlers = (struct handlers *)exception_handlers;
>  	int vector = 0, ec;
> diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testing/selftests/kvm/riscv/arch_timer.c
> index 9e370800a6a2..f962fefc48fa 100644
> --- a/tools/testing/selftests/kvm/riscv/arch_timer.c
> +++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
> @@ -15,7 +15,7 @@
>  
>  static int timer_irq = IRQ_S_TIMER;
>  
> -static void guest_irq_handler(struct ex_regs *regs)
> +static void guest_irq_handler(struct pt_regs *regs)
>  {
>  	uint64_t xcnt, xcnt_diff_us, cmp;
>  	unsigned int intid = regs->cause & ~CAUSE_IRQ_FLAG;
> diff --git a/tools/testing/selftests/kvm/riscv/ebreak_test.c b/tools/testing/selftests/kvm/riscv/ebreak_test.c
> index cfed6c727bfc..739d17befb5a 100644
> --- a/tools/testing/selftests/kvm/riscv/ebreak_test.c
> +++ b/tools/testing/selftests/kvm/riscv/ebreak_test.c
> @@ -27,7 +27,7 @@ static void guest_code(void)
>  	GUEST_DONE();
>  }
>  
> -static void guest_breakpoint_handler(struct ex_regs *regs)
> +static void guest_breakpoint_handler(struct pt_regs *regs)
>  {
>  	WRITE_ONCE(sw_bp_addr, regs->epc);
>  	regs->epc += 4;
> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> index 03406de4989d..6e66833e5941 100644
> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> @@ -128,7 +128,7 @@ static void stop_counter(unsigned long counter, unsigned long stop_flags)
>  		       "Unable to stop counter %ld error %ld\n", counter, ret.error);
>  }
>  
> -static void guest_illegal_exception_handler(struct ex_regs *regs)
> +static void guest_illegal_exception_handler(struct pt_regs *regs)
>  {
>  	__GUEST_ASSERT(regs->cause == EXC_INST_ILLEGAL,
>  		       "Unexpected exception handler %lx\n", regs->cause);
> @@ -138,7 +138,7 @@ static void guest_illegal_exception_handler(struct ex_regs *regs)
>  	regs->epc += 4;
>  }
>  
> -static void guest_irq_handler(struct ex_regs *regs)
> +static void guest_irq_handler(struct pt_regs *regs)
>  {
>  	unsigned int irq_num = regs->cause & ~CAUSE_IRQ_FLAG;
>  	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
> 
> -- 
> 2.43.0
>

Other than the macro comments,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

