Return-Path: <linux-kselftest+bounces-19965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676DD9A25CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 16:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5C6284539
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 14:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6EF1DE8A1;
	Thu, 17 Oct 2024 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hN/YOjN3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E621DE8B5
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177121; cv=none; b=NzXvZrO5fS4ea25Q/sE45/Y2A7+OSSpKQA7i5jNyA5ZVDaSl5dYhitsUIiGYOfhPZLoRahlIVTaWze+F89rIFGefsASAcQfK7SXojMbWNLx/S2ZQIp8Li6/Kpv5GNmCmSzS1eWP8xrSl7zBNMuqH25VsLz0XRN13tu5v9uU/iYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177121; c=relaxed/simple;
	bh=cTfpSWPvtLN/e0p/+/g3EwaPmnW8/HF+Jz7l/jqvOO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FO2Xug0P6Hi8hXj1MC8YZVRMuKJ5PY+iNSEWxkAbJdVaqzXroBuHPLMKO90VVVaPTEi+k05PEmljSpE161C8tMx7rUJ8x5ut9dV8PxLG2RQ5ZSdS39siNOZBUHFR4e8db2bycEQKZGpU1R8nZkre8UzV3DT5yfjZX4sehAkTKJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hN/YOjN3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729177118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YeuRkHE7ropmdcbR4Cq1Ya+ydc0Cmu/su/zFW+YnyjY=;
	b=hN/YOjN32rCn+3EqtOzY4sn5dOGn7PhhAN/g3fUJRzWx5y/Do0gsJIk6TvGdOaD6Tp+lqu
	mSw8n5IMtE/mjkPMIdji1Xk82XTYPKA03kqg8nHl/RWmxyeeLqCXLT3rZRb300o8oDcuNX
	0d0vmlFibFpHCNRBoY6omfKKQsHTBP0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-4nX20oHxN_a5tYsMCAyRKw-1; Thu, 17 Oct 2024 10:58:36 -0400
X-MC-Unique: 4nX20oHxN_a5tYsMCAyRKw-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5eb6ac40c56so911321eaf.2
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 07:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729177114; x=1729781914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeuRkHE7ropmdcbR4Cq1Ya+ydc0Cmu/su/zFW+YnyjY=;
        b=fiS7ZtR34s1HKiIwOPbljvkQAthhGPZzsdC+QqR6b56iINX3GYneuNNnA3gN+Ryv/s
         NPnSFPJFI/Oxr0eE4Dxrn9EK4mJBC2G91SMpitiEf8g/sEzu0h4QCzy7gyA9krHVGRwd
         oY9mOI7OMTxdEumK5DXes9jF2W57oZL/QsB8jq9z81Mk+iIgOUI/BBG/Y+7B76JV5BTm
         D1DiihBxqNFG18iuGAEYMmMOlS83rSYZh9txT8nub+BAsxWYxdejrVNcL3ypgNyTqK0E
         UmJNDyG1o/KuTFZ5BIF0yvhF9NUhoDhWH4cPQwSWofxYxZcYlZidJhujfeZkdb+DMDfl
         5TLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2JWT9e4G87RFeGYqh/Qe1SLO2dOZHGS9uN40i3nMsQj45XAA2rVvVcqb3ZbWX1TrWRVrXFsCOrIkr8ROQgvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzauX1fZ+w0NFp3zEs2sXIWY32I4qb90AJFV/x2KRgWE7HdMvv8
	JiKOr1O75SOe77D8DBW5lVBZh6JPnU1fTQCG3TKj1h4ISxePVlL3NheOaaNJmuojQIDTmAQZ6pg
	UWK9hWD3xgw6Mj1lxJ1kSE3RGlFfbokTLow/qZ8kRfz7FZ/tE8h81+ohD2bISdFyuow==
X-Received: by 2002:a05:6359:8004:b0:1c3:8643:7f05 with SMTP id e5c5f4694b2df-1c386438253mr210464355d.28.1729177114343;
        Thu, 17 Oct 2024 07:58:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuZSic+RIPKM1fxR2iF8bnthSep4CnGMyoY4sLA5CNzt7oJ7XBOHxPnKDiMbmM7UyruxT0DA==
X-Received: by 2002:a05:6359:8004:b0:1c3:8643:7f05 with SMTP id e5c5f4694b2df-1c386438253mr210461955d.28.1729177113968;
        Thu, 17 Oct 2024 07:58:33 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22911c5bsm28610376d6.28.2024.10.17.07.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 07:58:33 -0700 (PDT)
Date: Thu, 17 Oct 2024 10:58:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
	Ackerley Tng <ackerleytng@google.com>, tabba@google.com,
	quic_eberman@quicinc.com, roypat@amazon.co.uk, rientjes@google.com,
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
Message-ID: <ZxEmFY1FcrRtylJW@x1n>
References: <bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com>
 <Zwf7k1wmPqEEaRxz@x1n>
 <diqz8quunrlw.fsf@ackerleytng-ctop.c.googlers.com>
 <Zw7f3YrzqnH-iWwf@x1n>
 <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com>
 <1d243dde-2ddf-4875-890d-e6bb47931e40@redhat.com>
 <ZxAfET87vwVwuUfJ@x1n>
 <20241016225157.GQ3559746@nvidia.com>
 <ZxBRC-v9w7xS0xgk@x1n>
 <20241016235424.GU3559746@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241016235424.GU3559746@nvidia.com>

On Wed, Oct 16, 2024 at 08:54:24PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 16, 2024 at 07:49:31PM -0400, Peter Xu wrote:
> > On Wed, Oct 16, 2024 at 07:51:57PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Oct 16, 2024 at 04:16:17PM -0400, Peter Xu wrote:
> > > > 
> > > > Is there chance that when !CoCo will be supported, then external modules
> > > > (e.g. VFIO) can reuse the old user mappings, just like before gmemfd?
> > > > 
> > > > To support CoCo, I understand gmem+offset is required all over the places.
> > > > However in a non-CoCo context, I wonder whether the other modules are
> > > > required to stick with gmem+offset, or they can reuse the old VA ways,
> > > > because how it works can fundamentally be the same as before, except that
> > > > the folios now will be managed by gmemfd.
> > > 
> > > My intention with iommufd was to see fd + offest as the "new" way
> > > to refer to all guest memory and discourage people from using VMA
> > > handles.
> > 
> > Does it mean anonymous memory guests will not be supported at all for
> > iommufd?
> 
> No, they can use the "old" way with normal VMA's still, or they can
> use an anonymous memfd with the new way..
> 
> I just don't expect to have new complex stuff built on the VMA
> interface - I don't expect guestmemfd VMAs to work.

Yes, if with guestmemfd already we probably don't need to bother on the VA
interface.

It's the same when guestmemfd supports KVM_SET_USER_MEMORY_REGION2 already,
then it's not a problem at all to use fd+offset for this KVM API.

My question was more torwards whether gmemfd could still expose the
possibility to be used in VA forms to other modules that may not support
fd+offsets yet.  And I assume your reference on the word "VMA" means "VA
ranges", while "gmemfd VMA" on its own is probably OK?  Which is proposed
in this series with the fault handler.

It may not be a problem to many cloud providers, but if QEMU is involved,
it's still pretty flexible and QEMU will need to add fd+offset support for
many of the existing interfaces that is mostly based on VA or VA ranges.  I
believe that includes QEMU itself, aka, the user hypervisor (which is about
how user app should access shared pages that KVM is fault-allowed),
vhost-kernel (more GUP oriented), vhost-user (similar to userapp side),
etc.

I think as long as we can provide gmemfd VMAs like what this series
provides, it sounds possible to reuse the old VA interfaces before the CoCo
interfaces are ready, so that people can already start leveraging gmemfd
backing pages.

The idea is in general nice to me - QEMU used to have a requirement where
we want to have strict vIOMMU semantics between QEMU and another process
that runs the device emulation (aka, vhost-user).  We didn't want to map
all guest RAM all the time because OVS bug can corrupt QEMU memory until
now even if vIOMMU is present (which should be able to prevent this, only
logically..).  We used to have the idea that we can have one fd sent to
vhost-user process that we can have control of what is mapped and what can
be zapped.

In this case of gmemfd that is mostly what we used to persue already
before, that:

  - It allows mmap() of a guest memory region (without yet the capability
    to access all of them... otherwise it can bypass protection, no matter
    it's for CoCo or a vIOMMU in this case)

  - It allows the main process (in this case, it can be QEMU/KVM or
    anything/KVM) to control how to fault in the pages, in this case gmemfd
    lazily faults in the pages only if they're falutable / shared

  - It allows remote tearing down of pages that were not faultable / shared
    anymore, which guarantees the safety measure that the other process
    cannot access any page that was not authorized

I wonder if it's good enough even for CoCo's use case, where if anyone
wants to illegally access some page, it'll simply crash.

Besides that, we definitely can also have good use of non-CoCo 1G pages on
either postcopy solution (that James used to work on for HGM), or
hwpoisoning (where currently at least the latter one is, I believe, still a
common issue for all of us, to make hwpoison work for hugetlbfs with
PAGE_SIZE granule [1]).  The former issue will be still required at least
for QEMU to leverage the split-abliity of gmemfd huge folios.

Then even if both KVM ioctls + iommufd ioctls will only support fd+offsets,
as long as it's allowed to be faultable and gupped on the shared portion of
the gmemfd folios, they can start to be considered using to replace hugetlb
to overcome those difficulties even before CoCo is supported all over the
places.  There's also a question on whether all the known modules would
finally support fd+offsets, which I'm not sure.  If some module won't
support it, maybe it can still work with gmemfd in VA ranges so that it can
still benefit from what gmemfd can provide.

So in short, not sure if the use case can use a combination of (fd, offset)
interfacing on some modules like KVM/iommufd, but VA ranges like before on
some others.

Thanks,

[1] https://lore.kernel.org/all/20240924043924.3562257-1-jiaqiyan@google.com/

-- 
Peter Xu


