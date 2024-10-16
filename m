Return-Path: <linux-kselftest+bounces-19869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428229A13A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 22:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015BF2823EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 20:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8BA215026;
	Wed, 16 Oct 2024 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YH/mx44f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7515321E3C2
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109789; cv=none; b=IFr2nxr0rQwjRypz86w3qcrCaTD2voaKJPeqDTjwLyZYdG002mp7TuLnYcKUOyBw6iG+MxVShcAaSC/nzuUbi26OsosQ5YUccKSVkW2osOAfbKZXBhHlPbUfh6gpjP2IMdoogntsn/sDOPr9IPsCPvikGTq1JI3fy4WVKG2gLMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109789; c=relaxed/simple;
	bh=bZzSv4DegGa8Xd2G/fxdzrNAynowRSr1YBY6ag2UhBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pukRCNvNq2450NdNhnFhLbzoSY3X2+n7JGurbbLZEbaXdWon5nPwy9Ov4+NEmgD3YVVGWfEs03UWkEpUj2xwJ7SxUXbCjjZEKAqHZOJ6J67+GsLEII7Z9Wwktf143LV0dir3DY9Slz4czVCDcF06ra/oTHN2SHIU9oKgKgo+Odk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YH/mx44f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729109786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PuKyXIpwbMkMae+8UA8H2r+y4HqlTOe6EDodUx/P+3c=;
	b=YH/mx44fm/m4M9Q/VrkQ4qtK/fnE87VooAnsr25Je1oXHnS0or72vbJlltiADyrGl4CSNK
	cOjMsrtvbehWiRAFNEyGKXwODNxFem0KlD+gwB1PKviZoAycPc85onivuKvbcZocpYgGhu
	9aoacr7d+1NTK9jQs7jglXyjDPgK4AY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-Z7Nsy7NfOmqqZOhWfimpvA-1; Wed, 16 Oct 2024 16:16:23 -0400
X-MC-Unique: Z7Nsy7NfOmqqZOhWfimpvA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbe6ad0154so3679326d6.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 13:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729109782; x=1729714582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuKyXIpwbMkMae+8UA8H2r+y4HqlTOe6EDodUx/P+3c=;
        b=JiSluJKzlff9ppuuvnI7dhkzgpKphh3ocnIOeJwtx6bJu+5I+7lFU/4JRlj9EGBcbE
         /GZZ0eRwWoOdWzDfxwprCyXfvzik/+DQnIUROKehzYZCGw+4Kjl9lWD+uzdI1BFkEDRx
         w6o8AGhbGotZFSUMurc216PMRw09KPsFMv9Ltot0dLm1X/ktq9fL6ASxUC3o14RICk4X
         X2B+UF3pMKnGzP5J6+Ekoue0BU4sws19m23PpJr2H97ruunLaQFOA/DqTIw78R+TpeHy
         D3S7+PzS+JwOEt/AAUtVl55tzo1y6wWd/RlNyTTYhLdyVgvvN7cDpgLDLgssLirEa3Ar
         3X0w==
X-Forwarded-Encrypted: i=1; AJvYcCXgV5N7VaGRp37MPJxPEd2KsoLk8lxljMEscMJojmsAJWKggUrJm5zLICinlZc4iTuw2TgSuQPIqxsAKNkNrm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Y/mXgcioI1obgS4nsZFSd6Of590++s5f2RV5CHO+mMubQ+ot
	ibIHbiP0VklOMPXZcp+K+UvFNu1V+ZWHDKZjqs9i2vZsY6Xy9imHPNNw8KftrTMsPPe8V6nojLT
	N059O8DjGO+scjHpsuq5JHkoJrq+zE2g5M/5PSNgmNbPsF9duE9bUfId6wplNXYL+5Q==
X-Received: by 2002:a05:6214:5a02:b0:6cb:4b65:950f with SMTP id 6a1803df08f44-6cbf9e9683cmr199834286d6.50.1729109782460;
        Wed, 16 Oct 2024 13:16:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqNPWbjKBjatrXrr1J0gBbmpb2nr0vAKajL1whHjOqzoKvPk6RplkcmqwgplY800VhhFSBLw==
X-Received: by 2002:a05:6214:5a02:b0:6cb:4b65:950f with SMTP id 6a1803df08f44-6cbf9e9683cmr199833916d6.50.1729109782061;
        Wed, 16 Oct 2024 13:16:22 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2292f076sm21192606d6.65.2024.10.16.13.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:16:21 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:16:17 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ackerley Tng <ackerleytng@google.com>, tabba@google.com,
	quic_eberman@quicinc.com, roypat@amazon.co.uk, jgg@nvidia.com,
	rientjes@google.com, fvdl@google.com, jthoughton@google.com,
	seanjc@google.com, pbonzini@redhat.com, zhiquan1.li@intel.com,
	fan.du@intel.com, jun.miao@intel.com, isaku.yamahata@intel.com,
	muchun.song@linux.dev, erdemaktas@google.com, vannapurve@google.com,
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org,
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com,
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org,
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com,
	ajones@ventanamicro.com, vkuznets@redhat.com,
	maciej.wieczor-retman@intel.com, pgonda@google.com,
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
Message-ID: <ZxAfET87vwVwuUfJ@x1n>
References: <cover.1726009989.git.ackerleytng@google.com>
 <bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com>
 <Zwf7k1wmPqEEaRxz@x1n>
 <diqz8quunrlw.fsf@ackerleytng-ctop.c.googlers.com>
 <Zw7f3YrzqnH-iWwf@x1n>
 <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com>
 <1d243dde-2ddf-4875-890d-e6bb47931e40@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d243dde-2ddf-4875-890d-e6bb47931e40@redhat.com>

On Wed, Oct 16, 2024 at 10:45:43AM +0200, David Hildenbrand wrote:
> On 16.10.24 01:42, Ackerley Tng wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > On Fri, Oct 11, 2024 at 11:32:11PM +0000, Ackerley Tng wrote:
> > > > Peter Xu <peterx@redhat.com> writes:
> > > > 
> > > > > On Tue, Sep 10, 2024 at 11:43:57PM +0000, Ackerley Tng wrote:
> > > > > > The faultability xarray is stored on the inode since faultability is a
> > > > > > property of the guest_memfd's memory contents.
> > > > > > 
> > > > > > In this RFC, presence of an entry in the xarray indicates faultable,
> > > > > > but this could be flipped so that presence indicates unfaultable. For
> > > > > > flexibility, a special value "FAULT" is used instead of a simple
> > > > > > boolean.
> > > > > > 
> > > > > > However, at some stages of a VM's lifecycle there could be more
> > > > > > private pages, and at other stages there could be more shared pages.
> > > > > > 
> > > > > > This is likely to be replaced by a better data structure in a future
> > > > > > revision to better support ranges.
> > > > > > 
> > > > > > Also store struct kvm_gmem_hugetlb in struct kvm_gmem_hugetlb as a
> > > > > > pointer. inode->i_mapping->i_private_data.
> > > > > 
> > > > > Could you help explain the difference between faultability v.s. the
> > > > > existing KVM_MEMORY_ATTRIBUTE_PRIVATE?  Not sure if I'm the only one who's
> > > > > confused, otherwise might be good to enrich the commit message.
> > > > 
> > > > Thank you for this question, I'll add this to the commit message to the
> > > > next revision if Fuad's patch set [1] doesn't make it first.
> > > > 
> > > > Reason (a): To elaborate on the explanation in [1],
> > > > KVM_MEMORY_ATTRIBUTE_PRIVATE is whether userspace wants this page to be
> > > > private or shared, and faultability is whether the page is allowed to be
> > > > faulted in by userspace.
> > > > 
> > > > These two are similar but may not be the same thing. In pKVM, pKVM
> > > > cannot trust userspace's configuration of private/shared, and other
> > > > information will go into determining the private/shared setting in
> > > > faultability.
> > > 
> > > It makes sense to me that the kernel has the right to decide which page is
> > > shared / private.  No matter if it's for pKVM or CoCo, I believe the normal
> > > case is most / all pages are private, until some requests to share them for
> > > special purposes (like DMA).  But that'll need to be initiated as a request
> > > from the guest not the userspace hypervisor.
> > 
> > For TDX, the plan is that the guest will request the page to be remapped
> > as shared or private, and the handler for that request will exit to
> > the userspace VMM.
> > 
> > The userspace VMM will then do any necessary coordination (e.g. for a
> > shared to private conversion it may need to unpin pages from DMA), and
> > then use the KVM_SET_MEMORY_ATTRIBUTES ioctl to indicate agreement with
> > the guest's requested conversion. This is where
> > KVM_MEMORY_ATTRIBUTE_PRIVATE will be provided.
> > 
> > Patch 38 [1] updates
> > tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c to
> > demonstrate the usage flow for x86.
> > 
> > Fuad will be in a better position to explain the flow for pKVM.
> > 
> > > I must confess I totally have no idea how KVM_MEMORY_ATTRIBUTE_PRIVATE is
> > > planned to be used in the future. Currently it's always set at least in
> > > QEMU if gmemfd is enabled, so it doesn't yet tell me anything..
> > > 
> > > If it's driven by the userspace side of the hypervisor, I wonder when
> > > should the user app request some different value it already was, if the
> > > kernel already has an answer in this case.  It made me even more confused,
> > > as we have this in the API doc:
> > > 
> > >          Note, there is no "get" API.  Userspace is responsible for
> > >          explicitly tracking the state of a gfn/page as needed.
> > > 
> > > And I do wonder whether we will still need some API just to query whether
> > > the kernel allows the page to be mapped or not (aka, the "real" shared /
> > > private status of a guest page).  I guess that's not directly relevant to
> > > the faultability to be introduced here, but if you or anyone know please
> > > kindly share, I'd love to learn about it.
> > 
> > The userspace VMM will track the initial shared/private state, in the
> > sense that when the VM is created, the mem_attr_array is initialized
> > such that the guest pages are all shared.
> > 
> > Then when the userspace VMM calls the KVM_SET_MEMORY_ATTRIBUTES ioctl,
> > it should record all changes so it knows what the state is in the
> > kernel.
> > 
> > Even if userspace VMM doesn't record the state properly, if the
> > KVM_SET_MEMORY_ATTRIBUTES ioctl is used to request no change
> > (e.g. setting an already private page to private), it will just be a
> > no-op in the kernel.
> > 
> > > > 
> > > > Perhaps Fuad can elaborate more here.
> > > > 
> > > > Reason (b): In this patch series (mostly focus on x86 first), we're
> > > > using faultability to prevent any future faults before checking that
> > > > there are no mappings.
> > > > 
> > > > Having a different xarray from mem_attr_array allows us to disable
> > > > faulting before committing to changing mem_attr_array. Please see
> > > > `kvm_gmem_should_set_attributes_private()` in this patch [2].
> > > > 
> > > > We're not completely sure about the effectiveness of using faultability
> > > > to block off future faults here, in future revisions we may be using a
> > > > different approach. The folio_lock() is probably important if we need to
> > > > check mapcount. Please let me know if you have any ideas!
> > > > 
> > > > The starting point of having a different xarray was pKVM's requirement
> > > > of having separate xarrays, and we later realized that the xarray could
> > > > be used for reason (b). For x86 we could perhaps eventually remove the
> > > > second xarray? Not sure as of now.
> > > 
> > > Just had a quick look at patch 27:
> > > 
> > > https://lore.kernel.org/all/5a05eb947cf7aa21f00b94171ca818cc3d5bdfee.1726009989.git.ackerleytng@google.com/
> > > 
> > > I'm not yet sure what's protecting from faultability being modified against
> > > a concurrent fault().
> > > 
> > > I wonder whether one can use the folio lock to serialize that, so that one
> > > needs to take the folio lock to modify/lookup the folio's faultability,
> > > then it may naturally match with the fault() handler design, where
> > > kvm_gmem_get_folio() needs to lock the page first.
> > > 
> > > But then kvm_gmem_is_faultable() will need to also be called only after the
> > > folio is locked to avoid races.
> > 
> > My bad. In our rush to get this series out before LPC, the patch series
> > was not organized very well. Patch 39 [2] adds the
> > lock. filemap_invalidate_lock_shared() should make sure that faulting
> > doesn't race with faultability updates.
> > 
> > > > > The latter is per-slot, so one level higher, however I don't think it's a
> > > > > common use case for mapping the same gmemfd in multiple slots anyway for
> > > > > KVM (besides corner cases like live upgrade).  So perhaps this is not about
> > > > > layering but something else?  For example, any use case where PRIVATE and
> > > > > FAULTABLE can be reported with different values.
> > > > > 
> > > > > Another higher level question is, is there any plan to support non-CoCo
> > > > > context for 1G?
> > > > 
> > > > I believe guest_memfd users are generally in favor of eventually using
> > > > guest_memfd for non-CoCo use cases, which means we do want 1G (shared,
> > > > in the case of CoCo) page support.
> > > > 
> > > > However, core-mm's fault path does not support mapping at anything
> > > > higher than the PMD level (other than hugetlb_fault(), which the
> > > > community wants to move away from), so core-mm wouldn't be able to map
> > > > 1G pages taken from HugeTLB.
> > > 
> > > Have you looked at vm_operations_struct.huge_fault()?  Or maybe you're
> > > referring to some other challenges?
> > > 
> > 
> > IIUC vm_operations_struct.huge_fault() is used when creating a PMD, but
> > PUD mappings will be needed for 1G pages, so 1G pages can't be mapped by
> > core-mm using vm_operations_struct.huge_fault().
> 
> 
> Just to clarify a bit for Peter: as has been discussed previously, there are
> rather big difference between CoCo and non-CoCo VMs.
> 
> In CoCo VMs, the primary portion of all pages are private, and they are not
> mapped into user space. Only a handful of pages are commonly shared and
> mapped into user space.
> 
> In non-CoCo VMs, all pages are shared and (for the time being) all pages are
> mapped into user space from where KVM will consume them.
> 
> 
> Installing pmd/pud mappings into user space (recall: shared memory only) is
> currently not really a requirement for CoCo VMs, and therefore not the focus
> of this work.
> 
> Further, it's currently considered to be incompatible with getting in-place
> private<->share conversion on *page* granularity right, as we will be
> exposing huge/gigantic folios via individual small folios to core-MM.
> Mapping a PMD/PUD into core-mm, that is composed of multiple folios is not
> going to fly, unless using a PFNMAP, which has been briefly discussed as
> well, bu disregarded so far (no page pinning support).
> 
> So in the context of this work here, huge faults and PUD/PMD *user space
> page tables* do not apply.
> 
> For non-CoCo VMs there is no in-place conversion problem. One could use the
> same CoCo implementation, but without user space pud/pmd mappings. KVM and
> VFIO would have to consume this memory via the guest_memfd in memslots
> instead of via the user space mappings to more easily get PMD/PUD mappings
> into the secondary MMU. And the downsides would be sacrificing the vmemmap

Is there chance that when !CoCo will be supported, then external modules
(e.g. VFIO) can reuse the old user mappings, just like before gmemfd?

To support CoCo, I understand gmem+offset is required all over the places.
However in a non-CoCo context, I wonder whether the other modules are
required to stick with gmem+offset, or they can reuse the old VA ways,
because how it works can fundamentally be the same as before, except that
the folios now will be managed by gmemfd.

I think the good thing with such approach is when developing CoCo support
for all these modules, there's less constraints / concerns to be compatible
with non-CoCo use case, also it'll make it even easier to be used in
production before all CoCo facilities ready, as most infrastructures are
already around and being used for years if VA can be mapped and GUPed like
before.

Thanks,

> optimization and PMD/PUD user space mappings, while at the same time
> benefiting from being able to easily map only parts of a huge/gigantic page
> into user space.
> 
> 
> So I consider pmd/pud user space mappings for non-CoCo an independent work
> item, not something that is part of the current effort of huge/gigantic
> pages with in-place conversion at page granularity for CoCo VMs.
> 
> 
> More information is available in the bi-weekly upstream MM meeting (that was
> recorded) and the LPC talks, where most of that has been discussed.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Peter Xu


