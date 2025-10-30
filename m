Return-Path: <linux-kselftest+bounces-44463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB706C22B5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 00:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12E8A4E1B39
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 23:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12087337B9C;
	Thu, 30 Oct 2025 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FgqyeCU4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE5834D3B7
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 23:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761867118; cv=none; b=g48bEaIObFKTMYDgVHXG5G0mqqReiqx+G/O5dR43/Bp2f0+2+4iW0mRRIF6O6SC4B67GpKdGRJ2FGaPy0lzdhBZ3Dz5HNc6WewFbgxT/QawXJZrsWmCA+M9qBR5zPlhPU0of3mb78mLvVCyWfayfpeMXg4+muGDQH0XspH3q8Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761867118; c=relaxed/simple;
	bh=wZGUEpuERP9jo2ib1CCeVZd5fHSDqJlokC1xt033SO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMsejiZxegN1bKDUhoIPzx/LwDMpivrj8rlzJCWGQvfOtYQI7dx0TUhhc9UOYNC9zUHjwURq3B5TC/rnAl9VPcb2sdQa6GCQdS1FiUTJ5/E9p8Yok/JSO7s3rpNx2W3U9hywuqvtsqyZj8gMLYKaH2PRbP++pNVuD8aVcm7JLjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FgqyeCU4; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 30 Oct 2025 23:31:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761867103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BExVFUIUpRdWKD7+fEUnEF0cjVXk1DLPAhBHJri0zLw=;
	b=FgqyeCU4g0l+CXIy4Mv1bibfHWBCB6Nue42CqQYiypR1hVB7S3JK03MGIfqUWNuXyaK2J3
	EO7OYtnIj8BgbO6aDGTopZeJKub00Jy59PIFEoCuP4gPK8bNO2RXBeIBAqW+JvP0HkaGlT
	Fu8ZCazmuasJMtvefgtjbCnhHPvg7Os=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, "Pratik R. Sampat" <prsampat@amd.com>, 
	James Houghton <jthoughton@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v2 1/4] KVM: selftests: Use a loop to create guest page
 tables
Message-ID: <47efy3puookj6nl44p3wiajw3pfsj6nwaff7pokdirxhuensv3@bfoqm6cetjav>
References: <20251028225827.2269128-1-jmattson@google.com>
 <20251028225827.2269128-2-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028225827.2269128-2-jmattson@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 28, 2025 at 03:30:39PM -0700, Jim Mattson wrote:
> Walk the guest page tables via a loop when creating new mappings,
> instead of using unique variables for each level of the page tables.
> 
> This simplifies the code and makes it easier to support 5-level paging
> in the future.
> 
> Signed-off-by: Jim Mattson <jmattson@google.com>

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

> ---
>  .../testing/selftests/kvm/lib/x86/processor.c | 25 ++++++++-----------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index b418502c5ecc..738f2a44083f 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -218,8 +218,8 @@ static uint64_t *virt_create_upper_pte(struct kvm_vm *vm,
>  void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
>  {
>  	const uint64_t pg_size = PG_LEVEL_SIZE(level);
> -	uint64_t *pml4e, *pdpe, *pde;
> -	uint64_t *pte;
> +	uint64_t *pte = &vm->pgd;
> +	int current_level;
>  
>  	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K,
>  		    "Unknown or unsupported guest mode, mode: 0x%x", vm->mode);
> @@ -243,20 +243,17 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
>  	 * Allocate upper level page tables, if not already present.  Return
>  	 * early if a hugepage was created.
>  	 */
> -	pml4e = virt_create_upper_pte(vm, &vm->pgd, vaddr, paddr, PG_LEVEL_512G, level);
> -	if (*pml4e & PTE_LARGE_MASK)
> -		return;
> -
> -	pdpe = virt_create_upper_pte(vm, pml4e, vaddr, paddr, PG_LEVEL_1G, level);
> -	if (*pdpe & PTE_LARGE_MASK)
> -		return;
> -
> -	pde = virt_create_upper_pte(vm, pdpe, vaddr, paddr, PG_LEVEL_2M, level);
> -	if (*pde & PTE_LARGE_MASK)
> -		return;
> +	for (current_level = vm->pgtable_levels;
> +	     current_level > PG_LEVEL_4K;
> +	     current_level--) {
> +		pte = virt_create_upper_pte(vm, pte, vaddr, paddr,
> +					    current_level, level);
> +		if (*pte & PTE_LARGE_MASK)
> +			return;
> +	}
>  
>  	/* Fill in page table entry. */
> -	pte = virt_get_pte(vm, pde, vaddr, PG_LEVEL_4K);
> +	pte = virt_get_pte(vm, pte, vaddr, PG_LEVEL_4K);
>  	TEST_ASSERT(!(*pte & PTE_PRESENT_MASK),
>  		    "PTE already present for 4k page at vaddr: 0x%lx", vaddr);
>  	*pte = PTE_PRESENT_MASK | PTE_WRITABLE_MASK | (paddr & PHYSICAL_PAGE_MASK);
> -- 
> 2.51.1.851.g4ebd6896fd-goog
> 

