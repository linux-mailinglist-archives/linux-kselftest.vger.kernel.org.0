Return-Path: <linux-kselftest+bounces-12343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF69910D1F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 18:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DC81C23EA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 16:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDC91B29C5;
	Thu, 20 Jun 2024 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKBNCDef"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3671B29B9
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901201; cv=none; b=R9ooh82kB5yo/IbDaI2KjRVFbX6nxVJ3dPhrbOh57UGI7GBFOMy6JnWXSOQgj005etLkirk5TlHouv9X8c/dwQaxUUsxKEKuIhFymFK0IDkGAC03wRdTo0OQmSRvbIzfzlHElXi+r1VWy2MqCNtjvvIdy9crMrtDO49feQBWL4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901201; c=relaxed/simple;
	bh=UxbdEJzEfTFGGdJutifmUiiqZYkHXI3z/2GfVjcxnU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mL+IYlccqFziEWVNSMI58IKrhHlXPmjpB4P00txNB2dJO3nZNy1Ji+0uUARSe3WpC8bYEx1SXQlHdlBUTGlGDOQd9m+uLRAItuF/VYWNHs/hxJD2sHGJbDUuhBHg7uc+BpaQOgVhAun1dhAHTvDsBLADWqm8DauHBlCVfBENqKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aKBNCDef; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-422954bbe29so147525e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 09:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718901198; x=1719505998; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4B53UjI6PoAGWaCsloRkiHZtuTpGHM2ZWrCUhiNKWNY=;
        b=aKBNCDefQ8eWTyPfXJ9RtovKFKfxPq8D8X4PC1xQ3oQe3+eZTogbm4dH8debKbJiR7
         X04ZlMc4OFNOvjKqqu4ElN/5/dspZOY1gICTkF/Ugizm4KoQADbw6w0S65PSPEjZoenY
         CZks5w7KxyTKhPMzue6BQuDPLUI0idYbmFi5fgzYIwiTrz9hFxVOENEAGO/+AJMv+vqa
         6gPJgNXiw1ZeY25o9d/p4w9xb7rvF1JJwP55WmkcSw5h6THtWMS7KbCfxMQ8bXmOepZr
         WGVKZ7RKEi3pi0I2oPVLCMh6H+P54JJp7sO8FH6oapLtmOzTm3PYMr3N4SpmTKbp/kgq
         +2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718901198; x=1719505998;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4B53UjI6PoAGWaCsloRkiHZtuTpGHM2ZWrCUhiNKWNY=;
        b=tSSn7cZ+UPN2mZyFZ870GziaYVYam3tDTUA6SI3wBug/ddfXDgbi92h/b0RJLb3dxK
         OwPjLOUmMjG9rqkybwl9OItgKW5OylqvvzbXCPmYhcyCNimU/icvzz3afJce/9mSSVfr
         SM7yxlnMjSLmyGbBEaP0+/HSP5jiaCbsk/o5UvcWNHoRdfaeVV/oyof5GVGxkY55S4co
         Ivhaqa4cyZuqqxgdwg0EfZA2t48LUdg6xL5/3qXX0UpcMO+LuVfd2t6sHdXs2bluD207
         qFsktceBeNAX/J6Em8rDlOLPOOKf929uSOWLES38fBjrpzmXzbpoT6REMFKADoNoRhYU
         e0Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWpa/tpctJjqdy66u/we3QHD6JXg/7h5ApkhscTsKNaRT+tcJRThPDajvuMa6XKfS+5RjzhOhDEPPQ+KUIIVK5UPha18GnCEFAYjnot4Pd+
X-Gm-Message-State: AOJu0YzpzSoAZG5kiFgNpZShEzPsaUXSzzZsEjOty5hSBX+/0mI1BZja
	T3B9oP+pjR2IdQoHKfN1kJ8mLLJHuEZtkxt1MSohPhKjk4m5k8ZRLCvuZDlkKg==
X-Google-Smtp-Source: AGHT+IEz2SgAboLf42+BQNW/d36kQQhVc7F1UusAvGsQvMHx+tzIbLyscYR5TmIlxga6H6/BKgdcwQ==
X-Received: by 2002:a05:600c:34d6:b0:424:7ac9:4d9a with SMTP id 5b1f17b1804b1-4247ac95619mr2095555e9.1.1718901197463;
        Thu, 20 Jun 2024 09:33:17 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c9e27sm30767025e9.23.2024.06.20.09.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 09:33:16 -0700 (PDT)
Date: Thu, 20 Jun 2024 16:33:12 +0000
From: Mostafa Saleh <smostafa@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	maz@kernel.org, kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
	Fuad Tabba <tabba@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <ZnRZyBy_uxtjQHsz@google.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <ZnQpslcah7dcSS8z@google.com>
 <1ab73f42-9397-4fc7-8e62-2627b945f729@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ab73f42-9397-4fc7-8e62-2627b945f729@redhat.com>

Hi David,

On Thu, Jun 20, 2024 at 04:14:23PM +0200, David Hildenbrand wrote:
> On 20.06.24 15:08, Mostafa Saleh wrote:
> > Hi David,
> > 
> > On Wed, Jun 19, 2024 at 09:37:58AM +0200, David Hildenbrand wrote:
> > > Hi,
> > > 
> > > On 19.06.24 04:44, John Hubbard wrote:
> > > > On 6/18/24 5:05 PM, Elliot Berman wrote:
> > > > > In arm64 pKVM and QuIC's Gunyah protected VM model, we want to support
> > > > > grabbing shmem user pages instead of using KVM's guestmemfd. These
> > > > > hypervisors provide a different isolation model than the CoCo
> > > > > implementations from x86. KVM's guest_memfd is focused on providing
> > > > > memory that is more isolated than AVF requires. Some specific examples
> > > > > include ability to pre-load data onto guest-private pages, dynamically
> > > > > sharing/isolating guest pages without copy, and (future) migrating
> > > > > guest-private pages.  In sum of those differences after a discussion in
> > > > > [1] and at PUCK, we want to try to stick with existing shmem and extend
> > > > > GUP to support the isolation needs for arm64 pKVM and Gunyah.
> > > 
> > > The main question really is, into which direction we want and can develop
> > > guest_memfd. At this point (after talking to Jason at LSF/MM), I wonder if
> > > guest_memfd should be our new target for guest memory, both shared and
> > > private. There are a bunch of issues to be sorted out though ...
> > > 
> > > As there is interest from Red Hat into supporting hugetlb-style huge pages
> > > in confidential VMs for real-time workloads, and wasting memory is not
> > > really desired, I'm going to think some more about some of the challenges
> > > (shared+private in guest_memfd, mmap support, migration of !shared folios,
> > > hugetlb-like support, in-place shared<->private conversion, interaction with
> > > page pinning). Tricky.
> > > 
> > > Ideally, we'd have one way to back guest memory for confidential VMs in the
> > > future.
> > > 
> > > 
> > > Can you comment on the bigger design goal here? In particular:
> > > 
> > > 1) Who would get the exclusive PIN and for which reason? When would we
> > >     pin, when would we unpin?
> > > 
> > > 2) What would happen if there is already another PIN? Can we deal with
> > >     speculative short-term PINs from GUP-fast that could introduce
> > >     errors?
> > > 
> > > 3) How can we be sure we don't need other long-term pins (IOMMUs?) in
> > >     the future?
> > 
> > Can you please clarify more about the IOMMU case?
> > 
> > pKVM has no merged upstream IOMMU support at the moment, although
> > there was an RFC a while a go [1], also there would be a v2 soon.
> > 
> > In the patches KVM (running in EL2) will manage the IOMMUs including
> > the page tables and all pages used in that are allocated from the
> > kernel.
> > 
> > These patches don't support IOMMUs for guests. However, I don't see
> > why would that be different from the CPU? as once the page is pinned
> > it can be owned by a guest and that would be reflected in the
> > hypervisor tracking, the CPU stage-2 and IOMMU page tables as well.
> 
> So this is my thinking, it might be flawed:
> 
> In the "normal" world (e.g., vfio), we FOLL_PIN|FOLL_LONGTERM the pages to
> be accessible by a dedicated device. We look them up in the page tables to
> pin them, then we can map them into the IOMMU.
> 
> Devices that cannot speak "private memory" should only access shared memory.
> So we must not have "private memory" mapped into their IOMMU.
> 
> Devices that can speak "private memory" may either access shared or private
> memory. So we may have"private memory" mapped into their IOMMU.
> 

Private pages must not be accessible to devices owned by the
host, and for that we have the same rules as the CPU:
A) The hypervisor doesn’t trust the host, and must enforce that using the CPU
   stage-2 MMU.
B) It’s preferable that userspace doesn’t, and hence these patches (or guest_memfd...)

We need the same rules for DMA, otherwise it is "simple" to instrument a DMA attack,
so we need a protection by the IOMMU. pKVM at the moment provides 2 ways of
establishing that (each has their own trade-off which are not relevant here):

1) pKVM manages the IOMMUs and provides a hypercall interface to map/unmap in
   the IOMMU, looking at the rules

   For A), pKVM has its own per-page metadata which tracks page state, which can
   prevent mapping private pages in the IOMMU and transitioning pages to private
   if they are mapped in the IOMMU.

   For B), userspace won’t be able to map private pages(through VFIO/IOMMUFD), as
   the hypercall interface would fail if the pages are private.

   This proposal is the one on the list.

2) pKVM manages a second stage of the IOMMU (as SMMUv3), and let the kernel map what
   it wants in stage-1 and pKVM would use a mirrored page table of the CPU MMU stage-2.

   For A) Similar to the CPU, stage-2 IOMMU will protect the private pages.

   For B) userspace can map private pages in the first stage IOMMU, and that would
   result in stage-2 fault, AFAIK, SMMUv3 is the only Arm implementation that
   supports nesting in Linux, for that the driver would only print a page fault,
   and ideally the kernel wouldn’t crash, although that is really hardware
   dependant how it handle faults, and I guess assigning a device through VFIO
   to userspace comes with similar risks already (bogus MMIO access can
   crash the system).

   This proposal only exists in Android at the moment(However I am working on
   getting an SMMUv3 compliant implementation that can be posted upstream).

> 
> What I see (again, I might be just wrong):
> 
> 1) How would the device be able to grab/access "private memory", if not
>    via the user page tables?

I hope the above answers the question, but just to confirmn, a device owned by
the host shouldn’t access the memory as the host kernel is not trusted and
can instrument DMA attacks. Device assignment (passthrough) is another story.

> 2) How would we be able to convert shared -> private, if there is a
>    longterm pin from that IOMMU? We must dynamically unmap it from the
>    IOMMU.

Depending on which solution from the above, for
1) The transition from shared -> private would fail
2) The private page would be unmapped from the stage-2 IOMMU (similar to the
   stage-2 CPU MMU)

> 
> I assume when you're saying "In the patches KVM (running in EL2) will manage
> the IOMMUs  including the page tables", this is easily solved by not relying
> on pinning: KVM just knows what to update and where. (which is a very
> different model than what VFIO does)
> 

Yes, that's is not required to protect private memory.

Thanks,
Mostafa

> Thanks!
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

