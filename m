Return-Path: <linux-kselftest+bounces-12339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA8E910B01
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 18:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821871F224F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 16:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AFC1B142B;
	Thu, 20 Jun 2024 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H5PjkJ7x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6921B0109
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899473; cv=none; b=jqEbs56OFkhwH1h5yHx5A39F7okWW1X7eG+8DuV2cNH7HT+kFiHhKb6Y/pElTtwTFNLuJfph1vTWM8ztO26q4Yd+Pd82+dush9pouOyQtQ2gJYacYBED9Me75bZKkTgMgUxDT4FKSNxlKZTvcleBNn71JrYv53SJZTlXtK8WPv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899473; c=relaxed/simple;
	bh=L+sRaUROFLiedBrG2sWDIkuJ5o3pE63VZuzrZpIf2Fc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=smtovBT55Hfmnpq6xuvhgEwmqPiMshSk2+LeGfZ0C4St2Oux017To6Mrfg5dC8ups3MJ8LjhI0HkuG/MKyG7FqaFuvpc6byH1wFMWB90PyMCglkGD3vlyj9HuNBdIJQkZyHuYjwF+j1PnBVEp+74sDcWLMpf2RHlLy9q4bj8w2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H5PjkJ7x; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6ea972a3547so1274806a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 09:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718899471; x=1719504271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GM34BWwCNXiLOvG2mLkdqlEK4NIZT0q6djBzomdsWyE=;
        b=H5PjkJ7xfs83q10hkyTRCTnHarYxN6jsat87cynb3dCvPgi97F1+2vVjd+mGIZCJ+/
         3vbj6W/DaEKbIvMf3gz5vWKIMC5pHHEcOPDq3JfrUtsW1mUEGxD4P5LFLpTmdVQ430jA
         ipeL2Y5xYBNg67xC5Y08wZufdFWCPJL5Yy3fQNCCellnWrU20Cvu5aYoI9KYeQ/16YhW
         DbmvY9D0LUs4ano+MrVwYvKYfXKdvs2e+hAN2WvwKsYF4cXcdEeUDE/m34dLYkQ/HzVw
         UsINpLhKM6cNRPgntd0qVsDFXrrlw04ULYcx3k74Z1JWPtlwGY/T9csxZmLAFXaRMIVi
         B68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718899471; x=1719504271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GM34BWwCNXiLOvG2mLkdqlEK4NIZT0q6djBzomdsWyE=;
        b=TGQBiwDZtx71BO79TvEV1bja9m4a21fOoIsJbiYj3N+ZssJuSQPI4+XUStQXVfg0/+
         0sBhZXICvh9QCX+5kYCvxml8ma0uK0GlNXgnyAcdbH/c2KHgoF+gvmajMfwD5PmVrn7r
         et8AMK0TIc7GT2HMvsWABdlCoyvgyePhlSCPWWipe3c9dUIk7HvmIonEEyM0wOGnAhJ1
         XO0oetv1fErGjpl16kBN5IWPkMzsZzkmEkMNM19RwWEb8c79EdP+CPXkj4jD2RysUeCJ
         Sam1MCAz1twEwwvk9Vu/oQjBTVdffyOt1LJRB6+qryJvKRgz5HI3r7dLyv/5b1G8w1l+
         61gw==
X-Forwarded-Encrypted: i=1; AJvYcCUb1tfpNshedSdXKv2zZq8tBJGowWZZJG4fHgBB/ISKRqw9m/jJeRqkE7BOEGNxF/5RDsIPOPeQLWJjqhr2NB49ozMfGqHsEU1GmYk7AdTG
X-Gm-Message-State: AOJu0YwnlBHpPDtG42d50eWKJzVWyQ8uobFnBFySpOBtS92Sie8MXZ1d
	60+FRVW8dwAoSu6mVLWpa1jiQSYvzp2KAgv1UNc/YMFi63trFhbjhr0rAw3NT53oMUTNG/6jFhM
	Xog==
X-Google-Smtp-Source: AGHT+IEQboNcvlNMXMXTQphakoihDkY0lsVfoV/sk/4m49kyvfsdiCALpaLxGs2jQVK54zSq5Uy3vdD10AI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:fa8d:b0:2c2:ff46:312a with SMTP id
 98e67ed59e1d1-2c7b5d647d3mr16281a91.4.1718899470904; Thu, 20 Jun 2024
 09:04:30 -0700 (PDT)
Date: Thu, 20 Jun 2024 09:04:29 -0700
In-Reply-To: <385a5692-ffc8-455e-b371-0449b828b637@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com> <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com> <ZnOsAEV3GycCcqSX@infradead.org>
 <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
 <20240620135540.GG2494510@nvidia.com> <6d7b180a-9f80-43a4-a4cc-fd79a45d7571@redhat.com>
 <20240620142956.GI2494510@nvidia.com> <385a5692-ffc8-455e-b371-0449b828b637@redhat.com>
Message-ID: <ZnRTDUqLQ4XBRykl@google.com>
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Fuad Tabba <tabba@google.com>, 
	Christoph Hellwig <hch@infradead.org>, John Hubbard <jhubbard@nvidia.com>, 
	Elliot Berman <quic_eberman@quicinc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>, maz@kernel.org, 
	kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 20, 2024, David Hildenbrand wrote:
> On 20.06.24 16:29, Jason Gunthorpe wrote:
> > On Thu, Jun 20, 2024 at 04:01:08PM +0200, David Hildenbrand wrote:
> > > On 20.06.24 15:55, Jason Gunthorpe wrote:
> > > > On Thu, Jun 20, 2024 at 09:32:11AM +0100, Fuad Tabba wrote:
> > > Regarding huge pages: assume the huge page (e.g., 1 GiB hugetlb) is shared,
> > > now the VM requests to make one subpage private.
> > 
> > I think the general CC model has the shared/private setup earlier on
> > the VM lifecycle with large runs of contiguous pages. It would only
> > become a problem if you intend to to high rate fine granual
> > shared/private switching. Which is why I am asking what the actual
> > "why" is here.
> 
> I am not an expert on that, but I remember that the way memory
> shared<->private conversion happens can heavily depend on the VM use case,

Yeah, I forget the details, but there are scenarios where the guest will share
(and unshare) memory at 4KiB (give or take) granularity, at runtime.  There's an
RFC[*] for making SWIOTLB operate at 2MiB is driven by the same underlying problems.

But even if Linux-as-a-guest were better behaved, we (the host) can't prevent the
guest from doing suboptimal conversions.  In practice, killing the guest or
refusing to convert memory isn't an option, i.e. we can't completely push the
problem into the guest

https://lore.kernel.org/all/20240112055251.36101-1-vannapurve@google.com

> and that under pKVM we might see more frequent conversion, without even
> going to user space.
> 
> > 
> > > How to handle that without eventually running into a double
> > > memory-allocation? (in the worst case, allocating a 1GiB huge page
> > > for shared and for private memory).
> > 
> > I expect you'd take the linear range of 1G of PFNs and fragment it
> > into three ranges private/shared/private that span the same 1G.
> > 
> > When you construct a page table (ie a S2) that holds these three
> > ranges and has permission to access all the memory you want the page
> > table to automatically join them back together into 1GB entry.
> > 
> > When you construct a page table that has only access to the shared,
> > then you'd only install the shared hole at its natural best size.
> > 
> > So, I think there are two challenges - how to build an allocator and
> > uAPI to manage this sort of stuff so you can keep track of any
> > fractured pfns and ensure things remain in physical order.
> > 
> > Then how to re-consolidate this for the KVM side of the world.
> 
> Exactly!
> 
> > 
> > guest_memfd, or something like it, is just really a good answer. You
> > have it obtain the huge folio, and keep track on its own which sub
> > pages can be mapped to a VMA because they are shared. KVM will obtain
> > the PFNs directly from the fd and KVM will not see the shared
> > holes. This means your S2's can be trivially constructed correctly.
> > 
> > No need to double allocate..
> 
> Yes, that's why my thinking so far was:
> 
> Let guest_memfd (or something like that) consume huge pages (somehow, let it
> access the hugetlb reserves). Preallocate that memory once, as the VM starts
> up: just like we do with hugetlb in VMs.
> 
> Let KVM track which parts are shared/private, and if required, let it map
> only the shared parts to user space. KVM has all information to make these
> decisions.
> 
> If we could disallow pinning any shared pages, that would make life a lot
> easier, but I think there were reasons for why we might require it. To
> convert shared->private, simply unmap that folio (only the shared parts
> could possibly be mapped) from all user page tables.
> 
> Of course, there might be alternatives, and I'll be happy to learn about
> them. The allcoator part would be fairly easy, and the uAPI part would
> similarly be comparably easy. So far the theory :)
> 
> > 
> > I'm kind of surprised the CC folks don't want the same thing for
> > exactly the same reason. It is much easier to recover the huge
> > mappings for the S2 in the presence of shared holes if you track it
> > this way. Even CC will have this problem, to some degree, too.
>
> Precisely! RH (and therefore, me) is primarily interested in existing
> guest_memfd users at this point ("CC"), and I don't see an easy way to get
> that running with huge pages in the existing model reasonably well ...

This is the general direction guest_memfd is headed, but getting there is easier
said than done.  E.g. as alluded to above, "simply unmap that folio" is quite
difficult, bordering on infeasible if the kernel is allowed to gup() shared
guest_memfd memory.

