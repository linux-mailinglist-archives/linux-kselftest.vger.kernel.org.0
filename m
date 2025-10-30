Return-Path: <linux-kselftest+bounces-44464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D72C22B64
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 00:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC97189FCA6
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 23:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA1F33BBB5;
	Thu, 30 Oct 2025 23:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rQ6PPSjh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D7834D3B7
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 23:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761867157; cv=none; b=kg+FxjeBWpKRyTAbMZWiDimFaYW34/SDTIz44yumYGyHE/51ztsPimxVwSqIXpVjHpJ8cygwWtwR8KqNChfqx+uzxghXjEXMI5Is8gzCKPPKSbXq+nh1yX/DTA6+szMDhQUwMuwrinvIOLcUEs0bwcN2srVTd+fCypOj13Z065c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761867157; c=relaxed/simple;
	bh=N66E8WvZbIxl8GlqKaNOQVKQ95sFYhZSLa57vzmvMHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQQpkBo7i2G1sJgKjcwun7oEZo+cAkRowks65Gpy5fGq5ZWX8/fGctzZRvoZRrjUr6FNOc4F4VH2wmJJrTlQ/HmT+6+hkKA+wMFvmZrGu+VEYke9Vj1xJfoYXZkvDoJllYoNL3Pi9A2Z92fJ+ZdKkORR1jof0fmGFKxcNxGSJ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rQ6PPSjh; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 30 Oct 2025 23:32:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761867142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EPvbQ1EtJTgqqcXXxrcD3sjibKtkouuLrt2fwvBKuCo=;
	b=rQ6PPSjhqmg2IdFK5aV+HVTbe4voW0+TLPTF2k0+kL9UXz0NxzSOMtaLbhOcnZo0DErK5+
	WMp28hIY8amm9bTPluU0f78HJKiNnMG39vPrpA9pNO+BHu0lfFFWQjPqSP+fPUULlpVtLM
	KoCThdhoN7HfUwOodX7i2BEaD6MCinI=
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
Subject: Re: [PATCH v2 2/4] KVM: selftests: Use a loop to walk guest page
 tables
Message-ID: <6ya5ya2bzl5mvpc25fj5o62hvmubi4egs246pbj6z2oocff3tv@b3pkl6ckflpt>
References: <20251028225827.2269128-1-jmattson@google.com>
 <20251028225827.2269128-3-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028225827.2269128-3-jmattson@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 28, 2025 at 03:30:40PM -0700, Jim Mattson wrote:
> Walk the guest page tables via a loop when searching for a PTE,
> instead of using unique variables for each level of the page tables.
> 
> This simplifies the code and makes it easier to support 5-level paging
> in the future.
> 
> Signed-off-by: Jim Mattson <jmattson@google.com>

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

> ---
>  .../testing/selftests/kvm/lib/x86/processor.c | 23 ++++++++-----------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index 738f2a44083f..720c678187b5 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -307,7 +307,8 @@ static bool vm_is_target_pte(uint64_t *pte, int *level, int current_level)
>  uint64_t *__vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr,
>  				    int *level)
>  {
> -	uint64_t *pml4e, *pdpe, *pde;
> +	uint64_t *pte = &vm->pgd;
> +	int current_level;
>  
>  	TEST_ASSERT(!vm->arch.is_pt_protected,
>  		    "Walking page tables of protected guests is impossible");
> @@ -328,19 +329,15 @@ uint64_t *__vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr,
>  	TEST_ASSERT(vaddr == (((int64_t)vaddr << 16) >> 16),
>  		"Canonical check failed.  The virtual address is invalid.");
>  
> -	pml4e = virt_get_pte(vm, &vm->pgd, vaddr, PG_LEVEL_512G);
> -	if (vm_is_target_pte(pml4e, level, PG_LEVEL_512G))
> -		return pml4e;
> -
> -	pdpe = virt_get_pte(vm, pml4e, vaddr, PG_LEVEL_1G);
> -	if (vm_is_target_pte(pdpe, level, PG_LEVEL_1G))
> -		return pdpe;
> -
> -	pde = virt_get_pte(vm, pdpe, vaddr, PG_LEVEL_2M);
> -	if (vm_is_target_pte(pde, level, PG_LEVEL_2M))
> -		return pde;
> +	for (current_level = vm->pgtable_levels;
> +	     current_level > PG_LEVEL_4K;
> +	     current_level--) {
> +		pte = virt_get_pte(vm, pte, vaddr, current_level);
> +		if (vm_is_target_pte(pte, level, current_level))
> +			return pte;
> +	}
>  
> -	return virt_get_pte(vm, pde, vaddr, PG_LEVEL_4K);
> +	return virt_get_pte(vm, pte, vaddr, PG_LEVEL_4K);
>  }
>  
>  uint64_t *vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr)
> -- 
> 2.51.1.851.g4ebd6896fd-goog
> 

