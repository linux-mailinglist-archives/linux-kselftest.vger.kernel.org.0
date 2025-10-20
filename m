Return-Path: <linux-kselftest+bounces-43569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F40BBF2ADF
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 19:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3753F4075DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 17:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6E1330B15;
	Mon, 20 Oct 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mZHjO5wm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C46B2BF01D
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980890; cv=none; b=WdM+CPtNiwbXHFFHdQNXM+LcFsEAPaYDG0yJFST0SjDoJ9y/NGKJHZtWXwqAY5f90rOoZ2QE2ZYCMpCW0KEuQU7mVTe70jioQ0fAvzpSD7O2CqPA8ll4qmrSujZWB5D5l6h7C0pukto0++2pqkuMX3PpJmWuUKgqPJEvHYHBAl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980890; c=relaxed/simple;
	bh=jgCIDLHDF2FxW6HOC2oML2lemJ7LkLMOOYvNT+P7MUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHcsz/qLIIQolN9IFFSF4eQKuccuAr0/Cw40NUTwaBAeHzQVYFHv5jVsUd64h7sjn/da9COg3ELO5qI1TWcd8M5Ztv8fDlTZ69gEnESJ5LomIFW6TTqdn5ROXmuuSDK+PzvLCUVGoZGM6znYL5lJ10JGveL7u1tZUNpAjrlqD2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mZHjO5wm; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 20 Oct 2025 17:21:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760980876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3ejfuKsDgjhzfc8v7FNil97T0bqLDegWdlpF40XmO4=;
	b=mZHjO5wm0pXaQkpPR4/uYlVPKQ9GPObNdpJ4D3IpEMJXASduz87EuWDH8AtOMiy+boRPnw
	W6wE1xjTN4CrCc25D2mpYofVhXYX9Rynd0rRz9efedxneSndpZ9vBoPc8zBL2zXkFcXBCw
	AHJMGGLJvAneKa2Iq0Z1Co5oS/XaUf8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Eric Auger <eric.auger@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] KVM: selftests: Use a loop to walk guest page tables
Message-ID: <o7m5gh76crbgzlfvq4lbp6ymuzbgze25qphlhsezl2ox5rfjuv@3xh7gqh5dmlt>
References: <20250917215031.2567566-1-jmattson@google.com>
 <20250917215031.2567566-3-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917215031.2567566-3-jmattson@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 17, 2025 at 02:48:38PM -0700, Jim Mattson wrote:
> Walk the guest page tables via a loop when searching for a PTE,
> instead of using unique variables for each level of the page tables.
> 
> This simplifies the code and makes it easier to support 5-level paging
> in the future.
> 
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  .../testing/selftests/kvm/lib/x86/processor.c | 21 +++++++------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index 0238e674709d..433365c8196d 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -270,7 +270,8 @@ static bool vm_is_target_pte(uint64_t *pte, int *level, int current_level)
>  uint64_t *__vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr,
>  				    int *level)
>  {
> -	uint64_t *pml4e, *pdpe, *pde;
> +	uint64_t *pte = &vm->pgd;
> +	int current_level;
>  
>  	TEST_ASSERT(!vm->arch.is_pt_protected,
>  		    "Walking page tables of protected guests is impossible");
> @@ -291,19 +292,13 @@ uint64_t *__vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr,
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
> +	for (current_level = vm->pgtable_levels; current_level > 0; current_level--) {

This should be current_level >= PG_LEVEL_4K. It's the same, but easier
to read.

> +		pte = virt_get_pte(vm, pte, vaddr, current_level);
> +		if (vm_is_target_pte(pte, level, current_level))

Seems like vm_is_target_pte() is written with the assumption that it
operates on an upper-level PTE, but I think it works on 4K PTEs as well.

> +			return pte;
> +	}
>  
> -	return virt_get_pte(vm, pde, vaddr, PG_LEVEL_4K);
> +	return pte;
>  }
>  
>  uint64_t *vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr)
> -- 
> 2.51.0.470.ga7dc726c21-goog
> 

