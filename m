Return-Path: <linux-kselftest+bounces-41263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C97D2B53BBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 20:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF99587634
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 18:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638A12DC773;
	Thu, 11 Sep 2025 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XXxdyqbW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2C52DC765
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 18:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616192; cv=none; b=RpWkoZ9cXYG57U7skCgaMk24o/4vrMH3VogdrCl9v42U6olcLpq9X2ulpA/VA/MCoWTl9+gKVtCpFHreWij9YU1mEI4FxgTuTMDGDGu2Os67u/jhMDkV/n12OjU3Ec9K3DD+nNZ7lGdAAwhD1Ps5sM2NqrWDB5TwuS9f+ZTiHYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616192; c=relaxed/simple;
	bh=EcEcABLK/dcKQ9JWVUCiNd/eISIFCjI2vQDwfd4qgsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EojRvUYomJEfnsktZd2AaDtuQVJ8zHtaxURIok/rFUgZJu/jgoY3BJQErzKcjVhmO8D4bImHNei96QWbAmMDoX+i6yVEjUTqxYu5qpEs1lM45RnXVc7C8URjqxkbZHjebg7whpY3k68+LEYeFuCNNrQcF8gSKNNYOXf79nsSu3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XXxdyqbW; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Sep 2025 11:42:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757616177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JKfsBIjjBs8pCarTDYZ380mGeD1i48PO8H8V6haIuBY=;
	b=XXxdyqbW2SGskkdgZ/rJMJue/1nScUY19rrTLrPPz4OVLJMvxhMn67kkpt+DVXOfnxcXwP
	rUi/hBVVpalMpFcdyXaIbMKbPeSzQCr05n2lwybhV8Vz3naZLTMdx2HAubQSlBd6dF78Ti
	0kjk/i9g408ssx6NGLP8uPpZ436EaWs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Jack Thomson <jackabt.amazon@gmail.com>
Cc: maz@kernel.org, pbonzini@redhat.com, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	isaku.yamahata@intel.com, roypat@amazon.co.uk,
	kalyazin@amazon.co.uk, jackabt@amazon.com
Subject: Re: [PATCH 3/6] KVM: arm64: Add pre_fault_memory implementation
Message-ID: <aMMYKqWsAZ4y0WI7@linux.dev>
References: <20250911134648.58945-1-jackabt.amazon@gmail.com>
 <20250911134648.58945-4-jackabt.amazon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911134648.58945-4-jackabt.amazon@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 11, 2025 at 02:46:45PM +0100, Jack Thomson wrote:
> @@ -1607,7 +1611,7 @@ static int __user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  			    struct kvm_s2_trans *nested,
>  			    struct kvm_memory_slot *memslot,
>  			    long *page_size, unsigned long hva,
> -			    bool fault_is_perm)
> +			    bool fault_is_perm, bool pre_fault)
>  {
>  	int ret = 0;
>  	bool topup_memcache;
> @@ -1631,10 +1635,13 @@ static int __user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	vm_flags_t vm_flags;
>  	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_MEMABORT_FLAGS;
>  
> +	if (pre_fault)
> +		flags |= KVM_PGTABLE_WALK_PRE_FAULT;
> +
>  	if (fault_is_perm)
>  		fault_granule = kvm_vcpu_trap_get_perm_fault_granule(vcpu);
> -	write_fault = kvm_is_write_fault(vcpu);
> -	exec_fault = kvm_vcpu_trap_is_exec_fault(vcpu);
> +	write_fault = !pre_fault && kvm_is_write_fault(vcpu);
> +	exec_fault = !pre_fault && kvm_vcpu_trap_is_exec_fault(vcpu);

I'm not a fan of this. While user_mem_abort() is already a sloppy mess,
one thing we could reliably assume is the presence of a valid fault
context. Now we need to remember to special-case our interpretation of a
fault on whether or not we're getting invoked for a pre-fault.

I'd rather see the pre-fault infrastructure compose a synthetic fault
context (HPFAR_EL2, ESR_EL2, etc.). It places the complexity where it
belongs and the rest of the abort handling code should 'just work'.

> +long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
> +				    struct kvm_pre_fault_memory *range)
> +{
> +	int r;
> +	hva_t hva;
> +	phys_addr_t end;
> +	long page_size;
> +	struct kvm_memory_slot *memslot;
> +	phys_addr_t ipa = range->gpa;
> +	gfn_t gfn = gpa_to_gfn(range->gpa);
> +
> +	while (true) {
> +		page_size = PAGE_SIZE;
> +		memslot = gfn_to_memslot(vcpu->kvm, gfn);
> +		if (!memslot)
> +			return -ENOENT;
> +
> +		if (kvm_slot_has_gmem(memslot)) {
> +			r = __gmem_abort(vcpu, ipa, NULL, memslot, false, true);
> +		} else {
> +			hva = gfn_to_hva_memslot_prot(memslot, gfn, NULL);
> +			if (kvm_is_error_hva(hva))
> +				return -EFAULT;
> +			r = __user_mem_abort(vcpu, ipa, NULL, memslot, &page_size, hva, false,
> +					     true);
> +		}
> +
> +		if (r != -EAGAIN)
> +			break;
> +
> +		if (signal_pending(current))
> +			return -EINTR;
> +
> +		if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu))
> +			return -EIO;
> +
> +		cond_resched();
> +	};

Why do we need another retry loop? Looks like we've already got one in
the arch-generic code.

Thanks,
Oliver

