Return-Path: <linux-kselftest+bounces-3906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4175E844C2F
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 00:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADDD28493E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 23:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16A913EFE4;
	Wed, 31 Jan 2024 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iYQ97gUz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFB013E219
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 23:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742233; cv=none; b=WAS90vHfep4FkuwrahqqPxcM+umyfCNLd3F3IrdDj8rVexprCYShk9tcGXGR/WJgUtsC3PUVEDBwUcSG3NjvoXgwdlpRtfdbfvr5G4qmEdjdsfdrYFXxEzLdptmvxeGW7Vnju850+9ljfZpjM7O9WuKDKW5fYTvL7pWTsclwHik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742233; c=relaxed/simple;
	bh=r+gw0hlTKtdohBZj+zXKIzyuXhBHBMj2XAt/CW5yWgQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ArMiohcQ0DJ8XAoGUScIqHZnqoA+IBEtmSOrC6qgzGfOvof3PSRKnd9O0JuYZ7Yu72o5dMl6gX3oUyJvwv3zEWB4DbFuoQEbspppzB3PhrJN31IsnWmtbNmep8yR+4zvz9YGrRUUZnATSdB6xC+NLTIiFEnzpOLaXN6/kbs/aj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iYQ97gUz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5eba564eb3fso6146057b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 15:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706742230; x=1707347030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DZwweSSUYQvO/z20yvIqcaNFaLAc1RqILCFOCkMXbPM=;
        b=iYQ97gUzmWVVoNJtEuLbFJ4S5h8HpYVi1CxUgL2jom/QXujR1tOaXR8gTv9gHboxAR
         +FuFGe0gP4YF672OsN7lKVxUI/2T/5+iW66Cghp6vtM1NUKqh0Nlp2QEkoaG/LVY5T7P
         AZvb8pdjnyLugW27KRV2Ib5aeQH0rH+qEwjLl4V0pA4PbeIQ4C+6SPUUzBL90uzeQiuW
         SFOkw18jDq5BHsH5qIQgbhsN3I/T+94bo3Y0Ff8pMvFNJ8tYq3nmkra04+XHVmzxk5NP
         ZnXJNQylACQYwDfg7QqpS0Xhgy3EsRvlR6SH55HRTCOa8VtmjY62KWUJepxsnBV/EzLe
         Fc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706742230; x=1707347030;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZwweSSUYQvO/z20yvIqcaNFaLAc1RqILCFOCkMXbPM=;
        b=Gwib5KJbBIVEMgGIGc0Wl56sKNh6Yg5k0ZIj9QIInuW3+wYHSd0mBQtz4BUjCTODEI
         5zFcQCcsjjWZBMP7KOkATIoaDdceCfg4VHIhnibFDSI+pB6r/j22SD2PRuj23gHMlAts
         b0LZdKdbPjuCojXLn3letUbywPMYI4A2NxQWpEHNEN+VSPVl4PIbd6odD/Nsr/KodOxy
         zv5Hj26uJtBQP93jTRX9B+Sr9B6xA+GQdBKoMR3zNl91XTrtGyF28QTfiVvTGEtPxKB5
         gfbVmeYHm1gzDKWp+QFyUnebONLJ4mS+jJYXQfeeCs7VtvWpYX8DyZdRvs7mahz7IWD5
         e7Zg==
X-Gm-Message-State: AOJu0YzEMrUogxzrpcn9sfwxLxPaJJ7NnwJ8IcAPeJQSVX7HC6LgwtaK
	lDtrotNbrGTiwwW7uACLERmLz4p3zb1kz26db2Xv52k8vwBHLsMNc6UfXY9CQso96p3hL5mzphy
	uqA==
X-Google-Smtp-Source: AGHT+IFJbItnQs4Y8jmKkE5kxYlZxxDLejMwZjXJSJ/Pnb1uodzlMpEbl5+L7dgh/lCtAx5a7aAZSZtZzuc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:dd6:b0:5fc:43cb:cb1e with SMTP id
 db22-20020a05690c0dd600b005fc43cbcb1emr691136ywb.10.1706742230591; Wed, 31
 Jan 2024 15:03:50 -0800 (PST)
Date: Wed, 31 Jan 2024 15:03:48 -0800
In-Reply-To: <20231102155111.28821-3-guang.zeng@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102155111.28821-1-guang.zeng@intel.com> <20231102155111.28821-3-guang.zeng@intel.com>
Message-ID: <ZbrR1BJROP4O9eGx@google.com>
Subject: Re: [RFC PATCH v1 2/8] KVM: selftests: x86: Support guest running on
 canonical linear-address organization
From: Sean Christopherson <seanjc@google.com>
To: Zeng Guang <guang.zeng@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 02, 2023, Zeng Guang wrote:
> Setup execution environment running on 64-bit linear addresses for
> user and supervisor mode.
> 
> Define the linear address based on 48-bit canonical format in which
> bits 63:47 of the address are identical. All addresses to system data
> structure are shifted to supervisor-mode address space.
> 
> Extend page table mapping for supervisor mode to same guest physical
> address. This allows guest in supervisor mode can run in the
> corresponding canonical linear address space.
> 
> Signed-off-by: Zeng Guang <guang.zeng@intel.com>
> ---
>  .../selftests/kvm/include/x86_64/processor.h  |  6 ++++
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  6 ++--
>  .../selftests/kvm/lib/x86_64/processor.c      | 28 ++++++++++++-------
>  3 files changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index 25bc61dac5fb..00f7337a520a 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -1256,4 +1256,10 @@ void virt_map_level(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
>  #define PFERR_GUEST_PAGE_MASK	BIT_ULL(PFERR_GUEST_PAGE_BIT)
>  #define PFERR_IMPLICIT_ACCESS	BIT_ULL(PFERR_IMPLICIT_ACCESS_BIT)
>  
> +/*
> + * X86 kernel linear address defines
> + */
> +#define KERNEL_LNA_OFFSET 0xffff800000000000

Please don't make up acronyms, I can more or less glean what LNA is from the
context _here_, but in other usage I would truly have no idea.

> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 9f4b8c47edce..6f4295a13d00 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -227,6 +227,13 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
>  void virt_arch_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
>  {
>  	__virt_pg_map(vm, vaddr, paddr, PG_LEVEL_4K);
> +
> +	/*
> +	 * Map same paddr to kernel linear address space. Make execution
> +	 * environment supporting running both in user and kernel mode.
> +	 */
> +	if (!(vaddr & BIT_ULL(63)))
> +		__virt_pg_map(vm, (uint64_t)KERNEL_ADDR(vaddr), paddr, PG_LEVEL_4K);

I really don't like the idea of piling hacks on top of selftests' misguided
infrastructure.  Letting tests control virtual addresses is all kinds of stupid.
Except for ARM's ucall_arch_init(), I don't think there's a single user of
virt_map() that _needs_ a specific address, e.g. most tests just identity map
the GPA.

So rather than fudge things by stuffing two mappings, which is wasteful for 99%
of mappings and will likely be a maintenance nightmare, I think we should go
straight to getting x86's kernel mappings setup correctly from time zero.

From KUT experience, using USER mappings for kernel accesses is explosions waiting
to happen due to SMAP and SMEP.  And expecting developers to remember to sprinkle
KERNEL_ADDR() everywhere is not remotely maintainable.

In other words, give virt_arch_pg_map() (or ideally, the common virt_map()) over
picking the virtual address, and then plumb in information as to whether the
allocation is USER vs. SUPERVISOR.

