Return-Path: <linux-kselftest+bounces-42608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E211BAAD50
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 02:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2093C7D15
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 00:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068D219CC02;
	Tue, 30 Sep 2025 00:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hr3jsrtQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E572A198E91
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 00:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759193655; cv=none; b=NPWIMhdGlOXNy/Km8duEBbTwBFvsoG6QT9AhKhgytsFbA1KUmBI7GKZVrAFn4bCnzbq5PVdN+47XUbZzJ0XNrc3wmVzRAUdQVfZKbD3ppeQWiaSM2SPc1ntlQ+D25f4Ij+m21RfQCUx8SCEwz0PNY3EUlN2RNUgsH5CPLXGEbO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759193655; c=relaxed/simple;
	bh=AcijATm3N75Ov0nMjiQqledSjmaSWMbDCp6rF3qzFUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcypDO7Jr/oBA2Wydx5wHaYJ97cel1N25QBMEKuwiyxF8cGXibl3uKPn6R75TBqVUnKbt7MzJ1zCEzblP5//cdmX+mrdyeOmQFHaipxs0a60JilLOIrSbJv1OM6s126R8XvuWqqf1xtu3ajSq5RGzLfuscsBvgVUBfB7jjuM5wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hr3jsrtQ; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 29 Sep 2025 17:53:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759193641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=toyaVjkpPinuAEIPOarMwJdLvd9BQ2PV4RPd1E3oP4E=;
	b=hr3jsrtQsxW72gNjOEPsv4iQ9v/0A7cW0vmawVGdX45ydnDFq1yMF5QgeZ9N/xChHdvNoK
	Q2AZGZuaDA9FmsTsSVXcIfSWlxrVeJ5PHu9hSCZTH96pzMRGRi9tqXCCqeZI7AM9YipJjr
	qqFqGtGAkzNNTPCMu9EbjZd7HufUbP4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: "Thomson, Jack" <jackabt.amazon@gmail.com>
Cc: maz@kernel.org, pbonzini@redhat.com, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	isaku.yamahata@intel.com, roypat@amazon.co.uk,
	kalyazin@amazon.co.uk, jackabt@amazon.com
Subject: Re: [PATCH 3/6] KVM: arm64: Add pre_fault_memory implementation
Message-ID: <aNsqIsbYyROCjShQ@linux.dev>
References: <20250911134648.58945-1-jackabt.amazon@gmail.com>
 <20250911134648.58945-4-jackabt.amazon@gmail.com>
 <aMMYKqWsAZ4y0WI7@linux.dev>
 <7d109638-3d26-443a-b24d-eb7a0059b80f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d109638-3d26-443a-b24d-eb7a0059b80f@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 29, 2025 at 02:59:35PM +0100, Thomson, Jack wrote:
> Hi Oliver,
> 
> Thanks for reviewing!
> 
> On 11/09/2025 7:42 pm, Oliver Upton wrote:
> > On Thu, Sep 11, 2025 at 02:46:45PM +0100, Jack Thomson wrote:
> > > @@ -1607,7 +1611,7 @@ static int __user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> > >   			    struct kvm_s2_trans *nested,
> > >   			    struct kvm_memory_slot *memslot,
> > >   			    long *page_size, unsigned long hva,
> > > -			    bool fault_is_perm)
> > > +			    bool fault_is_perm, bool pre_fault)
> > >   {
> > >   	int ret = 0;
> > >   	bool topup_memcache;
> > > @@ -1631,10 +1635,13 @@ static int __user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> > >   	vm_flags_t vm_flags;
> > >   	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_MEMABORT_FLAGS;
> > > +	if (pre_fault)
> > > +		flags |= KVM_PGTABLE_WALK_PRE_FAULT;
> > > +
> > >   	if (fault_is_perm)
> > >   		fault_granule = kvm_vcpu_trap_get_perm_fault_granule(vcpu);
> > > -	write_fault = kvm_is_write_fault(vcpu);
> > > -	exec_fault = kvm_vcpu_trap_is_exec_fault(vcpu);
> > > +	write_fault = !pre_fault && kvm_is_write_fault(vcpu);
> > > +	exec_fault = !pre_fault && kvm_vcpu_trap_is_exec_fault(vcpu);
> > 
> > I'm not a fan of this. While user_mem_abort() is already a sloppy mess,
> > one thing we could reliably assume is the presence of a valid fault
> > context. Now we need to remember to special-case our interpretation of a
> > fault on whether or not we're getting invoked for a pre-fault.
> > 
> > I'd rather see the pre-fault infrastructure compose a synthetic fault
> > context (HPFAR_EL2, ESR_EL2, etc.). It places the complexity where it
> > belongs and the rest of the abort handling code should 'just work'.
> > 
> 
> Agreed, it looks much better with the synthetic abort. Is this the
> approach you had in mind?

Pretty much. Thanks for taking a moment to fiddle with it.

> +long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
> +				    struct kvm_pre_fault_memory *range)
> +{
> +	int ret, idx;
> +	hva_t hva;
> +	phys_addr_t end;
> +	u64 esr, hpfar;
> +	struct kvm_memory_slot *memslot;
> +	struct kvm_vcpu_fault_info *fault_info;
> +
> +	long page_size = PAGE_SIZE;
> +	phys_addr_t ipa = range->gpa;
> +	gfn_t gfn = gpa_to_gfn(range->gpa);
> +
> +	idx = srcu_read_lock(&vcpu->kvm->srcu);
> +
> +	if (ipa >= kvm_phys_size(vcpu->arch.hw_mmu)) {
> +		ret = -ENOENT;
> +		goto out_unlock;
> +	}
> +
> +	memslot = gfn_to_memslot(vcpu->kvm, gfn);
> +	if (!memslot) {
> +		ret = -ENOENT;
> +		goto out_unlock;
> +	}
> +
> +	fault_info = &vcpu->arch.fault;
> +
> +	esr = fault_info->esr_el2;
> +	hpfar = fault_info->hpfar_el2;

nit: Just snapshot the entire struct, makes this forward-compatible with
new fields showing up.

> +
> +	fault_info->esr_el2 = ESR_ELx_FSC_ACCESS_L(KVM_PGTABLE_LAST_LEVEL);

A translation fault would be a more accurate representation what you're
trying to do Access flag faults aren't expected in user_mem_abort() and
instead handled in handle_access_fault().

You're also missing the rest of the ESR fields that are relevant here,
such as ESR_ELx.EC which would actually indicate a data abort. I think
you'd also want to communicate this as a nISV fault (i.e.
ESR_ELx.ISV=0).

> +	fault_info->hpfar_el2 = HPFAR_EL2_NS |
> +		((ipa >> (12 - HPFAR_EL2_FIPA_SHIFT)) & HPFAR_EL2_FIPA_MASK);

FIELD_PREP()?

> +
> +	if (kvm_slot_has_gmem(memslot)) {
> +		ret = gmem_abort(vcpu, ipa, NULL, memslot, false);
> +	} else {
> +		hva = gfn_to_hva_memslot_prot(memslot, gfn, NULL);
> +		if (kvm_is_error_hva(hva)) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +		ret = user_mem_abort(vcpu, ipa, NULL, memslot, &page_size, hva,
> +				     false);
> +	}
> +
> +	if (ret < 0)
> +		goto out;
> +
> +	end = (range->gpa & ~(page_size - 1)) + page_size;
> +	ret = min(range->size, end - range->gpa);
> +
> +out:
> +	fault_info->esr_el2 = esr;
> +	fault_info->hpfar_el2 = hpfar;
> +out_unlock:
> +	srcu_read_unlock(&vcpu->kvm->srcu, idx);
> +	return ret;
> +}

Thanks,
Oliver

