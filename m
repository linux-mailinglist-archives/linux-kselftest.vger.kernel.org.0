Return-Path: <linux-kselftest+bounces-19786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB43899FC8D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 01:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376A91F25C78
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 23:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863961DBB24;
	Tue, 15 Oct 2024 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zL9IBy7C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BD71D63EF
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729035749; cv=none; b=ag6vAs4jEAcK+gqR0THq/K5HpZsvhgydOaJ+NkiHZaLYKF7C3DJFqwPrZlXkPtgsVXO+9tiGzaXsZRqavm2JxXw797QlXbj05TZVY52ZJA3bpDANftEWqbRrd6Tm/jMUSJQk0GKGMR05tC30vZa/HR44B4J9fl7SFn+W1nWM5jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729035749; c=relaxed/simple;
	bh=2XwO7NtXHdTNIRAjK6n/Kih6Ae/LV0gRdwLSe5f/pE4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gPtZ1SvxNbeggJQFM1Q1QoX1e0YZMAAfSvKwN1K7rRHkzFPcvfKdrhCxZ51JmiiIRxpAY0DBz4KZ10uRXD0iFtCdt0w2SV1LbttpjKUpP1HDYd2+DOGqvu6e/P/XHEZl1araC065uF1kMNZJkEkc2CArPFpDUYX142crLJoomIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zL9IBy7C; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-207510f3242so75681485ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 16:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729035747; x=1729640547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7eUDxM17tb+gqPu2r+ZqLDYFDJ5HMZg5l07N5DJoNIg=;
        b=zL9IBy7CeDXYNbLnKgAVS0PwzUbSss3eNkl8MhRpcR8Vlli7xjfY/nRdKnGDKXXek7
         BmwB5FzTUJiM26M4YzxwGBRbxslh+cNZ6wSFFHkLhlmQovYsr7u/rd5Toz1D/dNCdLP4
         wZ4C/c079pQBBC0+1dzgjxMlyEAW7MVzdlbp+2/fXJc4zhWbUY6XN6n8g5ACyDsTjYRm
         tyfptUZnnB828PN+GrdTRrHWK9mMkL+nnQkBRYBe9pWUTllHhsLkclVKfkJnYV52OvTl
         ENK8GCCEP41LJdgeh36oehWgcfIrV3FavZcSP5rseRi634O74v1wJ67BAyxqQOOakE07
         zE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729035747; x=1729640547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eUDxM17tb+gqPu2r+ZqLDYFDJ5HMZg5l07N5DJoNIg=;
        b=rMDJ7e3Es+ZCW19lx336O+csClrkQSRa4vluLiixuHlnFuz1pz5+P9nHq5XWW2CyZl
         FP2q+hOptSeDGGn/VsrgaWeCDGpd9mwHIuLI6JeMIeCbLNRrlJUjlxPtWE5OId8tHSY4
         ws2Clnet9rLDCJxjWflFWQ8H05/HzAki6J37qSHH/cUDy7wu/cnxZ0c1xZDavwxo4ocl
         rOPsM64a96bW10+RJUsmkMJddkufkNhGqqqY3HHHLflMBTjN2MiQBnSDdUVc3qVdQTtg
         wJ+v6mq10i76JBHZgbY44o/hkLRm8cLSd50tXV/4R2jwFAIGmdrd8FbgKTNajFwrPjOa
         lQ9w==
X-Forwarded-Encrypted: i=1; AJvYcCXeitJx+VQWdXORqC47rgVQbLBeWU5bV+ot9qbsOHQLUaLL2iWFXl0VfTWmO4N8N8Uh5+rTXX4abdAl30oVRSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw9DDI9/Hg5q/4SEadjW7vknpZOyTzIkDZ7Kp3yTPMwxws02xB
	mh36OYhqnsJMJj4VTPk0HUf3OAHv/vGNfTE79vGAkyaAEXUIcLD2yvt5uDS3lKrEhGSn7VYrgPE
	oGwRl3oijwv93gu26KGKU4w==
X-Google-Smtp-Source: AGHT+IE4mmzougQm0PKiTlXBNiDor7G2xyOqdwtI6YCJEdFKXPWyVCN0dZyEelT/YGDmAzLpZFlN3mHqYCPBjI6hZg==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:146:b875:ac13:a9fc])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:e892:b0:20c:62e1:635d with
 SMTP id d9443c01a7336-20d27f09861mr79095ad.7.1729035746339; Tue, 15 Oct 2024
 16:42:26 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:42:24 +0000
In-Reply-To: <Zw7f3YrzqnH-iWwf@x1n>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com> <bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com>
 <Zwf7k1wmPqEEaRxz@x1n> <diqz8quunrlw.fsf@ackerleytng-ctop.c.googlers.com> <Zw7f3YrzqnH-iWwf@x1n>
Message-ID: <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
From: Ackerley Tng <ackerleytng@google.com>
To: Peter Xu <peterx@redhat.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, david@redhat.com, rientjes@google.com, fvdl@google.com, 
	jthoughton@google.com, seanjc@google.com, pbonzini@redhat.com, 
	zhiquan1.li@intel.com, fan.du@intel.com, jun.miao@intel.com, 
	isaku.yamahata@intel.com, muchun.song@linux.dev, erdemaktas@google.com, 
	vannapurve@google.com, qperret@google.com, jhubbard@nvidia.com, 
	willy@infradead.org, shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Peter Xu <peterx@redhat.com> writes:

> On Fri, Oct 11, 2024 at 11:32:11PM +0000, Ackerley Tng wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Tue, Sep 10, 2024 at 11:43:57PM +0000, Ackerley Tng wrote:
>> >> The faultability xarray is stored on the inode since faultability is a
>> >> property of the guest_memfd's memory contents.
>> >> 
>> >> In this RFC, presence of an entry in the xarray indicates faultable,
>> >> but this could be flipped so that presence indicates unfaultable. For
>> >> flexibility, a special value "FAULT" is used instead of a simple
>> >> boolean.
>> >> 
>> >> However, at some stages of a VM's lifecycle there could be more
>> >> private pages, and at other stages there could be more shared pages.
>> >> 
>> >> This is likely to be replaced by a better data structure in a future
>> >> revision to better support ranges.
>> >> 
>> >> Also store struct kvm_gmem_hugetlb in struct kvm_gmem_hugetlb as a
>> >> pointer. inode->i_mapping->i_private_data.
>> >
>> > Could you help explain the difference between faultability v.s. the
>> > existing KVM_MEMORY_ATTRIBUTE_PRIVATE?  Not sure if I'm the only one who's
>> > confused, otherwise might be good to enrich the commit message.
>> 
>> Thank you for this question, I'll add this to the commit message to the
>> next revision if Fuad's patch set [1] doesn't make it first.
>> 
>> Reason (a): To elaborate on the explanation in [1],
>> KVM_MEMORY_ATTRIBUTE_PRIVATE is whether userspace wants this page to be
>> private or shared, and faultability is whether the page is allowed to be
>> faulted in by userspace.
>> 
>> These two are similar but may not be the same thing. In pKVM, pKVM
>> cannot trust userspace's configuration of private/shared, and other
>> information will go into determining the private/shared setting in
>> faultability.
>
> It makes sense to me that the kernel has the right to decide which page is
> shared / private.  No matter if it's for pKVM or CoCo, I believe the normal
> case is most / all pages are private, until some requests to share them for
> special purposes (like DMA).  But that'll need to be initiated as a request
> from the guest not the userspace hypervisor.

For TDX, the plan is that the guest will request the page to be remapped
as shared or private, and the handler for that request will exit to
the userspace VMM.

The userspace VMM will then do any necessary coordination (e.g. for a
shared to private conversion it may need to unpin pages from DMA), and
then use the KVM_SET_MEMORY_ATTRIBUTES ioctl to indicate agreement with
the guest's requested conversion. This is where
KVM_MEMORY_ATTRIBUTE_PRIVATE will be provided.

Patch 38 [1] updates
tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c to
demonstrate the usage flow for x86.

Fuad will be in a better position to explain the flow for pKVM. 

> I must confess I totally have no idea how KVM_MEMORY_ATTRIBUTE_PRIVATE is
> planned to be used in the future. Currently it's always set at least in
> QEMU if gmemfd is enabled, so it doesn't yet tell me anything..
>
> If it's driven by the userspace side of the hypervisor, I wonder when
> should the user app request some different value it already was, if the
> kernel already has an answer in this case.  It made me even more confused,
> as we have this in the API doc:
>
>         Note, there is no "get" API.  Userspace is responsible for
>         explicitly tracking the state of a gfn/page as needed.
>
> And I do wonder whether we will still need some API just to query whether
> the kernel allows the page to be mapped or not (aka, the "real" shared /
> private status of a guest page).  I guess that's not directly relevant to
> the faultability to be introduced here, but if you or anyone know please
> kindly share, I'd love to learn about it.

The userspace VMM will track the initial shared/private state, in the
sense that when the VM is created, the mem_attr_array is initialized
such that the guest pages are all shared.

Then when the userspace VMM calls the KVM_SET_MEMORY_ATTRIBUTES ioctl,
it should record all changes so it knows what the state is in the
kernel.

Even if userspace VMM doesn't record the state properly, if the
KVM_SET_MEMORY_ATTRIBUTES ioctl is used to request no change
(e.g. setting an already private page to private), it will just be a
no-op in the kernel.

>> 
>> Perhaps Fuad can elaborate more here.
>> 
>> Reason (b): In this patch series (mostly focus on x86 first), we're
>> using faultability to prevent any future faults before checking that
>> there are no mappings.
>> 
>> Having a different xarray from mem_attr_array allows us to disable
>> faulting before committing to changing mem_attr_array. Please see
>> `kvm_gmem_should_set_attributes_private()` in this patch [2].
>> 
>> We're not completely sure about the effectiveness of using faultability
>> to block off future faults here, in future revisions we may be using a
>> different approach. The folio_lock() is probably important if we need to
>> check mapcount. Please let me know if you have any ideas!
>> 
>> The starting point of having a different xarray was pKVM's requirement
>> of having separate xarrays, and we later realized that the xarray could
>> be used for reason (b). For x86 we could perhaps eventually remove the
>> second xarray? Not sure as of now.
>
> Just had a quick look at patch 27:
>
> https://lore.kernel.org/all/5a05eb947cf7aa21f00b94171ca818cc3d5bdfee.1726009989.git.ackerleytng@google.com/
>
> I'm not yet sure what's protecting from faultability being modified against
> a concurrent fault().
>
> I wonder whether one can use the folio lock to serialize that, so that one
> needs to take the folio lock to modify/lookup the folio's faultability,
> then it may naturally match with the fault() handler design, where
> kvm_gmem_get_folio() needs to lock the page first.
>
> But then kvm_gmem_is_faultable() will need to also be called only after the
> folio is locked to avoid races.

My bad. In our rush to get this series out before LPC, the patch series
was not organized very well. Patch 39 [2] adds the
lock. filemap_invalidate_lock_shared() should make sure that faulting
doesn't race with faultability updates.

>> > The latter is per-slot, so one level higher, however I don't think it's a
>> > common use case for mapping the same gmemfd in multiple slots anyway for
>> > KVM (besides corner cases like live upgrade).  So perhaps this is not about
>> > layering but something else?  For example, any use case where PRIVATE and
>> > FAULTABLE can be reported with different values.
>> >
>> > Another higher level question is, is there any plan to support non-CoCo
>> > context for 1G?
>> 
>> I believe guest_memfd users are generally in favor of eventually using
>> guest_memfd for non-CoCo use cases, which means we do want 1G (shared,
>> in the case of CoCo) page support.
>> 
>> However, core-mm's fault path does not support mapping at anything
>> higher than the PMD level (other than hugetlb_fault(), which the
>> community wants to move away from), so core-mm wouldn't be able to map
>> 1G pages taken from HugeTLB.
>
> Have you looked at vm_operations_struct.huge_fault()?  Or maybe you're
> referring to some other challenges?
>

IIUC vm_operations_struct.huge_fault() is used when creating a PMD, but
PUD mappings will be needed for 1G pages, so 1G pages can't be mapped by
core-mm using vm_operations_struct.huge_fault().

>> 
>> In this patch series, we always split pages before mapping them to
>> userspace and that's how this series still works with core-mm.
>> 
>> Having 1G page support for shared memory or for non-CoCo use cases would
>> probably depend on better HugeTLB integration with core-mm, which you'd
>> be most familiar with.
>
> My understanding is the mm community wants to avoid adding major new things
> on top of current hugetlbfs alone, I'm not sure whether this will also be
> accounted as part of that.  IMHO it could depend on how much this series
> will reuse hugetlbfs.  If it's only about allocations it might be ok,
> however I still feel risky having the name "hugetlbfs" here, the allocator
> (if refactored out of hugetlb, but to contain more functions than CMA)
> could be named in a more generic way.  No rush on changing anything, you
> may always want to talk with more mm people on this I guess.
>

Thanks for your feedback! We do intend to only use the allocator part of
HugeTLB for guest_memfd, which will need some refactoring on the HugeTLB
side. The refactoring is not expected to require any functional changes.

What do you think of refactoring out the allocator part of HugeTLB in
terms of whether it helps with HugeTLB unification?

If the refactoring out of the allocator part of HugeTLB needs a name
change, that could work too.

> I also don't know how you treat things like folio_test_hugetlb() on
> possible assumptions that the VMA must be a hugetlb vma.  I'd confess I
> didn't yet check the rest of the patchset yet - reading a large series
> without a git tree is sometimes challenging to me.
>

I'm thinking to basically never involve folio_test_hugetlb(), and the
VMAs used by guest_memfd will also never be a HugeTLB VMA. That's
because only the HugeTLB allocator is used, but by the time the folio is
mapped to userspace, it would have already have been split. After the
page is split, the folio loses its HugeTLB status. guest_memfd folios
will never be mapped to userspace while they still have a HugeTLB
status.

(When 1G pages can be mapped to userspace, we will have to rethink the
above. But possibly by then HugeTLB would have been more unified with
core-mm and hence perhaps things will fall in place?)

The current uses of folio_test_hugetlb() in this patch series are

1. In alloc_migration_target_by_mpol(), which is okay because that's
   during allocation of the HugeTLB folio, before it gets split up and
   loses its status. When the folio is freed, before it is returned to
   HugeTLB, the HugeTLB status will be reinstated.

2. In kvm_gmem_prepare_folio(). If the folio hasn't been split yet, then
   we use folio_zero_user() to zero the folio, and if it has been split,
   then we use a more primitive loop to zero the folio. These two
   methods of zeroing are actually kind of the same thing and can be
   combined. This correctly uses folio_test_hugetlb().

3. In kvm_gmem_fault(), I check if folio_test_hugetlb() when doing the
   same zeroing described in (2), but this is not actually necessary and
   will be removed in a future revision, since HugeTLB folios should
   never get faulted to userspace.

>> 
>> Thank you for looking through our patches, we need your experience and
>> help! I've also just sent out the first 3 patches separately, which I
>> think is useful in improving understandability of the
>> resv_map/subpool/hstate reservation system in HugeTLB and can be
>> considered separately. Hope you can also review/comment on [4].
>
> I'll read and think about it.  Before that, I'll probably need to read more
> backgrounds you need from hugetlb allocators (e.g. I remember you mentioned
> pool management somewhere).  I tried to watch your LPC talk but the
> recording has some issue on audio so I can mostly hear nothing in most of
> the discussions..  I'll try to join the bi-weekly meeting two days later,
> though.
>

Thank you!

>> 
>> > I saw that you also mentioned you have working QEMU prototypes ready in
>> > another email.  It'll be great if you can push your kernel/QEMU's latest
>> > tree (including all dependency patches) somewhere so anyone can have a
>> > closer look, or play with it.
>> 
>> Vishal's reply [3] might have been a bit confusing. To clarify, my team
>> doesn't work with Qemu at all (we use a custom userspace VMM internally)
>> so the patches in this series are tested purely with selftests.
>> 
>> The selftests have fewer dependencies than full Qemu and I'd be happy to
>> help with running them or explain anything that I might have missed out.
>> 
>> We don't have any Qemu prototypes and are not likely to be building any
>> prototypes in the foreseeable future.
>
> I see, that's totally not a problem.  If there can be, especially !CoCo
> support at some point, we're happy to test it on QEMU side.  I'll see what
> I can do to help !CoCo kernel side getting there.
>
> Besides, it'll still be great if you can push a latest kernel tree
> somewhere (or provide the base commit ID, but that needs to be on a public
> tree I can fetch).

I should have added the base commit ID.

The base commit hash for this series is
1c4246294c9841c50805cec0627030c083e019c6.

>
> Thanks,
>
>> 
>> >
>> > Thanks,
>> >
>> > -- 
>> > Peter Xu
>> 
>> [1] https://lore.kernel.org/all/20241010085930.1546800-3-tabba@google.com/
>> [2] https://lore.kernel.org/all/f4ca1711a477a3b56406c05d125dce3d7403b936.1726009989.git.ackerleytng@google.com/
>> [3] https://lore.kernel.org/all/CAGtprH-GczOb64XrLpdW4ObRG7Gsv8tHWNhiW7=2dE=OAF7-Rw@mail.gmail.com/
>> [4] https://lore.kernel.org/all/cover.1728684491.git.ackerleytng@google.com/T/
>> 
>
> -- 
> Peter Xu

[1] https://lore.kernel.org/all/3ef4b32d32dca6e1b506e967c950dc2d4c3bc7ae.1726009989.git.ackerleytng@google.com/
[2] https://lore.kernel.org/all/38723c5d5e9b530e52f28b9f9f4a6d862ed69bcd.1726009989.git.ackerleytng@google.com/

