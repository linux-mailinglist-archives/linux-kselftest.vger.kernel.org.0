Return-Path: <linux-kselftest+bounces-19784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2DC99FA23
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 23:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800A11F234DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 21:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1083B1B0F37;
	Tue, 15 Oct 2024 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUa+RzE8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC711B0F35
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028072; cv=none; b=I9PYCHVYNJjD5/44PGGtwXezDpkRCBYdNJfRofJqE6eJZHA9OlHXKEjiBLV3ZOzXhUJwLmWrHwjvh27Z3Km2HmCqMHd+hGMKISQNjK3dmQLL9jcfdsXpIUcpH9tbzxrUXcN369O6c8xggrFh8USF09EtOJL2gMU3BV9H1vdtq0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028072; c=relaxed/simple;
	bh=/ZW2xEDKt0GanW5UBYvRqYCkdZF99tftr2SM7xbXSJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pn6UAAtcXmZxbRCAb8ihZKsC1D1gRCe3cdEijLzUPCAHNBKhiuMqDhvDlaMhz0XPM1mTrVnYiJyAXd2JJq2ii5+iIqi9DL2NbIGw1Vzl9Je8fQz3yNLrBNrJ+1t3ZgMClt/4PPmNKWQzuq5tRfQQurBsWdQuLICLV1wNuL4Hmu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUa+RzE8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729028069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yq0av3bGyebgc1yVU0KIcUx1tbCF3JSfuIpR+BT7lwY=;
	b=UUa+RzE8omain8SY9JZn/+VuWWrbjwVS/Vk/+BzyxGjLrMB1HYpglUSKewoHChC+hjxPXT
	UVHn6bcz78ZduJpJ0UEcQL7r4jCw0dEbnbiGfKeAh8smpQcERK4lqxD0mWw/oS2Vj/apuL
	Vk5mAXmOt6ZIhD74FDNqcZiB4z+fDrk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-Xdia-VYPNcyRRgQodFC47Q-1; Tue, 15 Oct 2024 17:34:27 -0400
X-MC-Unique: Xdia-VYPNcyRRgQodFC47Q-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbe3ff272bso115915026d6.3
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 14:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729028067; x=1729632867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yq0av3bGyebgc1yVU0KIcUx1tbCF3JSfuIpR+BT7lwY=;
        b=dq5PKV2wv+eTWE6erppPfN9rkNeMD5Ub/J7VJIBJxmnOSQyH2OfOfQD8HiKeua1dyI
         CuXJpnYKV4inlc8F5OsDbhnqxAaThnhVnQwU12RiB63L6gKaW7DxsTNuXoa3FN7UQnyp
         FzDD05DAY5Sw2D9MCbW5v+GehdU9xxGSkrxgfgB9EdPhzHGWV2qnUsHo307iuEdxxi8S
         lpXHA+GjNEtVX7TowKKk09RlepMd9XKLPBRlKbxw8qWOJW5TCv2mWyonR8Q701F7lord
         uQ2vXjvHZ6MNLxwsSnVawGFy3KNNa/DfxJMOVRjgimbEt8ddL2djtFJ+TVwmMVjrU/6d
         tngQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa+W/txxl9iirC+vTviZWswH99VXeVKpH4IxOswjAlMoeoL7bJKtCNKcFFA0zXlB4lf1/I43Kv52ackXFDH2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7jHpJPSowGP2Dn2CBjLQOwJvtuIx/xor/27WvBfjORmXgpHwx
	6dzxmhD+ki0Q0o+6G+fJN6TTrcZvI4zr8LwQU0WU529UM/kBEgL3SDtgQCIIdZdDeuvLMKaaiAW
	O1luuUkpkZbefIbrE6dJZ2RRfnZpIKWX54St6Lufv8Z9w3hqebnGGl+rJ4yUC+0t/6Q==
X-Received: by 2002:a05:6214:3a09:b0:6cc:1322:21d9 with SMTP id 6a1803df08f44-6cc2b8bc7f2mr24038496d6.1.1729028067066;
        Tue, 15 Oct 2024 14:34:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFyBvM4orc/Q0IuB6eR9rP8v23e8IQslLR8DUFc0wIvIPEYh1gB3MAhDTKXriDvcrHsTOX9w==
X-Received: by 2002:a05:6214:3a09:b0:6cc:1322:21d9 with SMTP id 6a1803df08f44-6cc2b8bc7f2mr24037916d6.1.1729028066578;
        Tue, 15 Oct 2024 14:34:26 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22990493sm10882306d6.140.2024.10.15.14.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 14:34:25 -0700 (PDT)
Date: Tue, 15 Oct 2024 17:34:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk,
	jgg@nvidia.com, david@redhat.com, rientjes@google.com,
	fvdl@google.com, jthoughton@google.com, seanjc@google.com,
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com,
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev,
	erdemaktas@google.com, vannapurve@google.com, qperret@google.com,
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org,
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev,
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com,
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com,
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com,
	pgonda@google.com, oliver.upton@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
Message-ID: <Zw7f3YrzqnH-iWwf@x1n>
References: <cover.1726009989.git.ackerleytng@google.com>
 <bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com>
 <Zwf7k1wmPqEEaRxz@x1n>
 <diqz8quunrlw.fsf@ackerleytng-ctop.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <diqz8quunrlw.fsf@ackerleytng-ctop.c.googlers.com>

On Fri, Oct 11, 2024 at 11:32:11PM +0000, Ackerley Tng wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Sep 10, 2024 at 11:43:57PM +0000, Ackerley Tng wrote:
> >> The faultability xarray is stored on the inode since faultability is a
> >> property of the guest_memfd's memory contents.
> >> 
> >> In this RFC, presence of an entry in the xarray indicates faultable,
> >> but this could be flipped so that presence indicates unfaultable. For
> >> flexibility, a special value "FAULT" is used instead of a simple
> >> boolean.
> >> 
> >> However, at some stages of a VM's lifecycle there could be more
> >> private pages, and at other stages there could be more shared pages.
> >> 
> >> This is likely to be replaced by a better data structure in a future
> >> revision to better support ranges.
> >> 
> >> Also store struct kvm_gmem_hugetlb in struct kvm_gmem_hugetlb as a
> >> pointer. inode->i_mapping->i_private_data.
> >
> > Could you help explain the difference between faultability v.s. the
> > existing KVM_MEMORY_ATTRIBUTE_PRIVATE?  Not sure if I'm the only one who's
> > confused, otherwise might be good to enrich the commit message.
> 
> Thank you for this question, I'll add this to the commit message to the
> next revision if Fuad's patch set [1] doesn't make it first.
> 
> Reason (a): To elaborate on the explanation in [1],
> KVM_MEMORY_ATTRIBUTE_PRIVATE is whether userspace wants this page to be
> private or shared, and faultability is whether the page is allowed to be
> faulted in by userspace.
> 
> These two are similar but may not be the same thing. In pKVM, pKVM
> cannot trust userspace's configuration of private/shared, and other
> information will go into determining the private/shared setting in
> faultability.

It makes sense to me that the kernel has the right to decide which page is
shared / private.  No matter if it's for pKVM or CoCo, I believe the normal
case is most / all pages are private, until some requests to share them for
special purposes (like DMA).  But that'll need to be initiated as a request
from the guest not the userspace hypervisor.

I must confess I totally have no idea how KVM_MEMORY_ATTRIBUTE_PRIVATE is
planned to be used in the future. Currently it's always set at least in
QEMU if gmemfd is enabled, so it doesn't yet tell me anything..

If it's driven by the userspace side of the hypervisor, I wonder when
should the user app request some different value it already was, if the
kernel already has an answer in this case.  It made me even more confused,
as we have this in the API doc:

        Note, there is no "get" API.  Userspace is responsible for
        explicitly tracking the state of a gfn/page as needed.

And I do wonder whether we will still need some API just to query whether
the kernel allows the page to be mapped or not (aka, the "real" shared /
private status of a guest page).  I guess that's not directly relevant to
the faultability to be introduced here, but if you or anyone know please
kindly share, I'd love to learn about it.

> 
> Perhaps Fuad can elaborate more here.
> 
> Reason (b): In this patch series (mostly focus on x86 first), we're
> using faultability to prevent any future faults before checking that
> there are no mappings.
> 
> Having a different xarray from mem_attr_array allows us to disable
> faulting before committing to changing mem_attr_array. Please see
> `kvm_gmem_should_set_attributes_private()` in this patch [2].
> 
> We're not completely sure about the effectiveness of using faultability
> to block off future faults here, in future revisions we may be using a
> different approach. The folio_lock() is probably important if we need to
> check mapcount. Please let me know if you have any ideas!
> 
> The starting point of having a different xarray was pKVM's requirement
> of having separate xarrays, and we later realized that the xarray could
> be used for reason (b). For x86 we could perhaps eventually remove the
> second xarray? Not sure as of now.

Just had a quick look at patch 27:

https://lore.kernel.org/all/5a05eb947cf7aa21f00b94171ca818cc3d5bdfee.1726009989.git.ackerleytng@google.com/

I'm not yet sure what's protecting from faultability being modified against
a concurrent fault().

I wonder whether one can use the folio lock to serialize that, so that one
needs to take the folio lock to modify/lookup the folio's faultability,
then it may naturally match with the fault() handler design, where
kvm_gmem_get_folio() needs to lock the page first.

But then kvm_gmem_is_faultable() will need to also be called only after the
folio is locked to avoid races.

> 
> >
> > The latter is per-slot, so one level higher, however I don't think it's a
> > common use case for mapping the same gmemfd in multiple slots anyway for
> > KVM (besides corner cases like live upgrade).  So perhaps this is not about
> > layering but something else?  For example, any use case where PRIVATE and
> > FAULTABLE can be reported with different values.
> >
> > Another higher level question is, is there any plan to support non-CoCo
> > context for 1G?
> 
> I believe guest_memfd users are generally in favor of eventually using
> guest_memfd for non-CoCo use cases, which means we do want 1G (shared,
> in the case of CoCo) page support.
> 
> However, core-mm's fault path does not support mapping at anything
> higher than the PMD level (other than hugetlb_fault(), which the
> community wants to move away from), so core-mm wouldn't be able to map
> 1G pages taken from HugeTLB.

Have you looked at vm_operations_struct.huge_fault()?  Or maybe you're
referring to some other challenges?

> 
> In this patch series, we always split pages before mapping them to
> userspace and that's how this series still works with core-mm.
> 
> Having 1G page support for shared memory or for non-CoCo use cases would
> probably depend on better HugeTLB integration with core-mm, which you'd
> be most familiar with.

My understanding is the mm community wants to avoid adding major new things
on top of current hugetlbfs alone, I'm not sure whether this will also be
accounted as part of that.  IMHO it could depend on how much this series
will reuse hugetlbfs.  If it's only about allocations it might be ok,
however I still feel risky having the name "hugetlbfs" here, the allocator
(if refactored out of hugetlb, but to contain more functions than CMA)
could be named in a more generic way.  No rush on changing anything, you
may always want to talk with more mm people on this I guess.

I also don't know how you treat things like folio_test_hugetlb() on
possible assumptions that the VMA must be a hugetlb vma.  I'd confess I
didn't yet check the rest of the patchset yet - reading a large series
without a git tree is sometimes challenging to me.

> 
> Thank you for looking through our patches, we need your experience and
> help! I've also just sent out the first 3 patches separately, which I
> think is useful in improving understandability of the
> resv_map/subpool/hstate reservation system in HugeTLB and can be
> considered separately. Hope you can also review/comment on [4].

I'll read and think about it.  Before that, I'll probably need to read more
backgrounds you need from hugetlb allocators (e.g. I remember you mentioned
pool management somewhere).  I tried to watch your LPC talk but the
recording has some issue on audio so I can mostly hear nothing in most of
the discussions..  I'll try to join the bi-weekly meeting two days later,
though.

> 
> > I saw that you also mentioned you have working QEMU prototypes ready in
> > another email.  It'll be great if you can push your kernel/QEMU's latest
> > tree (including all dependency patches) somewhere so anyone can have a
> > closer look, or play with it.
> 
> Vishal's reply [3] might have been a bit confusing. To clarify, my team
> doesn't work with Qemu at all (we use a custom userspace VMM internally)
> so the patches in this series are tested purely with selftests.
> 
> The selftests have fewer dependencies than full Qemu and I'd be happy to
> help with running them or explain anything that I might have missed out.
> 
> We don't have any Qemu prototypes and are not likely to be building any
> prototypes in the foreseeable future.

I see, that's totally not a problem.  If there can be, especially !CoCo
support at some point, we're happy to test it on QEMU side.  I'll see what
I can do to help !CoCo kernel side getting there.

Besides, it'll still be great if you can push a latest kernel tree
somewhere (or provide the base commit ID, but that needs to be on a public
tree I can fetch).

Thanks,

> 
> >
> > Thanks,
> >
> > -- 
> > Peter Xu
> 
> [1] https://lore.kernel.org/all/20241010085930.1546800-3-tabba@google.com/
> [2] https://lore.kernel.org/all/f4ca1711a477a3b56406c05d125dce3d7403b936.1726009989.git.ackerleytng@google.com/
> [3] https://lore.kernel.org/all/CAGtprH-GczOb64XrLpdW4ObRG7Gsv8tHWNhiW7=2dE=OAF7-Rw@mail.gmail.com/
> [4] https://lore.kernel.org/all/cover.1728684491.git.ackerleytng@google.com/T/
> 

-- 
Peter Xu


