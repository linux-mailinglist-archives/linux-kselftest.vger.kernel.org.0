Return-Path: <linux-kselftest+bounces-12324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FCE910579
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 15:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7A5286A19
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 13:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5DF8175E;
	Thu, 20 Jun 2024 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jye64+iQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0151AAE34
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888890; cv=none; b=b+nnSGMrsu0h8uEaseaVe9fA081TBZD8dMbbN0PWRULaOv/fo9O4C8Fn6AGC15LLKnNzTURIRvuKwB60N2U50lTStkcj+6tbGTcHHcm0SxESRsS5yp8BFyuZdP8GtCOVxgZUDeEpCWQJoN62kpdAI6xOwEWv5/9r2FEnzilN/aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888890; c=relaxed/simple;
	bh=Nd5/hPdaVzyaCPja9J9QJBucAO/XJpZ+1uhijZYQ7fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYK+f6S7G+wcJtspOOoT4SqErCYUBWZPaHqcSqqjOQKLkhCqyduEFWi5tqCLBQmxZIYMvMBsQe6p9qtphaS0AqKzxWkyiCURyWmxboE3gLQBzP6usGZFtXMFcT579ETZQ2arq1GG4FEQmCRB9zr1xl8Y3onlXsB+Ct9g1CJ5aYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jye64+iQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-423b89f9042so136075e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 06:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718888887; x=1719493687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sokuciGEMqDWfb/GyCKAbwKFQZy9XN+HQFh0M9GkJEc=;
        b=jye64+iQUf5Q22WYI1bW2qakhtko/K6W5NB1dXd/wdVeLgH5b8VP9R3SJjkU5Xg/Qg
         NTkGml8A1f3UfF3IVPp/XroIcpCVV0ed2h8JV7hMFZH+bWmNt7flwiPFB4zNJcOjsrfk
         MU58yhn0vKKAJJVzwmsmdqMZLBsK0k45PsUlWtXm5MpJ2ga/UFy5m/UUfJ3iDdCkuj04
         lAJDLk9uDGhOoiOVzhYu1UXWSQX9ok6rsgLhdh8ATjEzHBSwhkcNtqmEWEZcsot9IOAu
         yJL4xmekP5Tt+qPD5Nmx645PRWhY6Tc+43L2Zv0dRr+gmjWnRGS2AuKsUjhCG0jv/X1y
         cQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718888887; x=1719493687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sokuciGEMqDWfb/GyCKAbwKFQZy9XN+HQFh0M9GkJEc=;
        b=rVAC6nUeCfDQLCcDQSnUjVUzCYaF4JMVY748HqCyYSbiFCFEGo5oqQ5h+w4T79Leyh
         0oHAGVabEiAKsR/VX73UIOz7DioR7DMBKA/sNyVhq0GC23XqJIW4wo/6DbBBeG9og/5u
         PIQTE0XxX16uGzYW8ZlYvhoPRUB032bI9h5AVWuoOderf7ij8I1AUd0AepsqXJSAkL6X
         FNgWnCJyzfc1VzHLHuFiXRs+5xsUtOfVHSCTlrCp8eqFcyjVSYYTskb80+TVlYApjiqy
         w7xiHm8EGnyjAGb0pi86eQogFJKGsBF5++AqqeTYZjcEZOZn4M2m94IFtOA9JCkfbmz0
         9HTw==
X-Forwarded-Encrypted: i=1; AJvYcCXmcSybbVLEOmvMQLb2xzq5C3unlldbTbZIZaco9lDwrjBMeXcav/R+IIdQjSgrvP5jkCHr+aF1tTGEmEu9pIiR9LbO2OFpZwFxdiJ0AaD1
X-Gm-Message-State: AOJu0YxGj6kOI6krKsI8nzleesVWQApqbH6+eBlnWuGSLekCCC1c62QJ
	VDM80fuOL13O/wLYYFLGIp2/r8oKxiqzJLy+zgkTYthlzrAhO3upXKlsY+pt6g==
X-Google-Smtp-Source: AGHT+IHp9bazFhbmExqFkMfkC/8CdeFqGQa/Ablhwe0BqRz1q3OFlFoqlZtJH067QyRn9E0j/SDL1Q==
X-Received: by 2002:a05:600c:4e0c:b0:41b:8715:1158 with SMTP id 5b1f17b1804b1-424758fd22bmr3600115e9.6.1718888887221;
        Thu, 20 Jun 2024 06:08:07 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075c6fa4esm19579496f8f.67.2024.06.20.06.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 06:08:06 -0700 (PDT)
Date: Thu, 20 Jun 2024 13:08:02 +0000
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
Message-ID: <ZnQpslcah7dcSS8z@google.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>

Hi David,

On Wed, Jun 19, 2024 at 09:37:58AM +0200, David Hildenbrand wrote:
> Hi,
> 
> On 19.06.24 04:44, John Hubbard wrote:
> > On 6/18/24 5:05 PM, Elliot Berman wrote:
> > > In arm64 pKVM and QuIC's Gunyah protected VM model, we want to support
> > > grabbing shmem user pages instead of using KVM's guestmemfd. These
> > > hypervisors provide a different isolation model than the CoCo
> > > implementations from x86. KVM's guest_memfd is focused on providing
> > > memory that is more isolated than AVF requires. Some specific examples
> > > include ability to pre-load data onto guest-private pages, dynamically
> > > sharing/isolating guest pages without copy, and (future) migrating
> > > guest-private pages.  In sum of those differences after a discussion in
> > > [1] and at PUCK, we want to try to stick with existing shmem and extend
> > > GUP to support the isolation needs for arm64 pKVM and Gunyah.
> 
> The main question really is, into which direction we want and can develop
> guest_memfd. At this point (after talking to Jason at LSF/MM), I wonder if
> guest_memfd should be our new target for guest memory, both shared and
> private. There are a bunch of issues to be sorted out though ...
> 
> As there is interest from Red Hat into supporting hugetlb-style huge pages
> in confidential VMs for real-time workloads, and wasting memory is not
> really desired, I'm going to think some more about some of the challenges
> (shared+private in guest_memfd, mmap support, migration of !shared folios,
> hugetlb-like support, in-place shared<->private conversion, interaction with
> page pinning). Tricky.
> 
> Ideally, we'd have one way to back guest memory for confidential VMs in the
> future.
> 
> 
> Can you comment on the bigger design goal here? In particular:
> 
> 1) Who would get the exclusive PIN and for which reason? When would we
>    pin, when would we unpin?
> 
> 2) What would happen if there is already another PIN? Can we deal with
>    speculative short-term PINs from GUP-fast that could introduce
>    errors?
> 
> 3) How can we be sure we don't need other long-term pins (IOMMUs?) in
>    the future?

Can you please clarify more about the IOMMU case?

pKVM has no merged upstream IOMMU support at the moment, although
there was an RFC a while a go [1], also there would be a v2 soon.

In the patches KVM (running in EL2) will manage the IOMMUs including
the page tables and all pages used in that are allocated from the
kernel.

These patches don't support IOMMUs for guests. However, I don't see
why would that be different from the CPU? as once the page is pinned
it can be owned by a guest and that would be reflected in the
hypervisor tracking, the CPU stage-2 and IOMMU page tables as well.

[1] https://lore.kernel.org/kvmarm/20230201125328.2186498-1-jean-philippe@linaro.org/

Thanks,
Mostafa

> 
> 4) Why are GUP pins special? How one would deal with other folio
>    references (e.g., simply mmap the shmem file into a different
>    process).
> 
> 5) Why you have to bother about anonymous pages at all (skimming over s
>    some patches), when you really want to handle shmem differently only?
> 
> > > To that
> > > end, we introduce the concept of "exclusive GUP pinning", which enforces
> > > that only one pin of any kind is allowed when using the FOLL_EXCLUSIVE
> > > flag is set. This behavior doesn't affect FOLL_GET or any other folio
> > > refcount operations that don't go through the FOLL_PIN path.
> 
> So, FOLL_EXCLUSIVE would fail if there already is a PIN, but !FOLL_EXCLUSIVE
> would succeed even if there is a single PIN via FOLL_EXCLUSIVE? Or would the
> single FOLL_EXCLUSIVE pin make other pins that don't have FOLL_EXCLUSIVE set
> fail as well?
> 
> > > 
> > > [1]: https://lore.kernel.org/all/20240319143119.GA2736@willie-the-truck/
> > > 
> > 
> > Hi!
> > 
> > Looking through this, I feel that some intangible threshold of "this is
> > too much overloading of page->_refcount" has been crossed. This is a very
> > specific feature, and it is using approximately one more bit than is
> > really actually "available"...
> 
> Agreed.
> 
> > 
> > If we need a bit in struct page/folio, is this really the only way? Willy
> > is working towards getting us an entirely separate folio->pincount, I
> > suppose that might take too long? Or not?
> 
> Before talking about how to implement it, I think we first have to learn
> whether that approach is what we want at all, and how it fits into the
> bigger picture of that use case.
> 
> > 
> > This feels like force-fitting a very specific feature (KVM/CoCo handling
> > of shmem pages) into a more general mechanism that is running low on
> > bits (gup/pup).
> 
> Agreed.
> 
> > 
> > Maybe a good topic for LPC!
> 
> The KVM track has plenty of guest_memfd topics, might be a good fit there.
> (or in the MM track, of course)
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

