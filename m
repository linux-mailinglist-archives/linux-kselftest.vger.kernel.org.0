Return-Path: <linux-kselftest+bounces-19838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF8F9A07BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 12:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FCB21C2122A
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 10:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B05206967;
	Wed, 16 Oct 2024 10:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hY8tXSo5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833D720514B
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075757; cv=none; b=JXe8RLxsnw5SrXHaIjwKcnDQgS2GK8kxb2dfoUcvqX5of/nNVpoPC4/cym1rg3hIlkC5l5Lxj9eGPFo2Tif+S9q3QNVJ6iF8C2f/frkCNtymd1j9QHAeCOI5a8hQe9qjuAOCy31BYAI9xrd27cFBqthFW+WF2rzJ7boPKxAdsbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075757; c=relaxed/simple;
	bh=p3Uy6zh8Ol2qbVeWD/3mGVLL+TASPb0miaj+Lh6GDmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddY4/WfqCdUyepJZuvarqo8Jd6TykUDV5ya2/L4zHGBmKs0VkcCJOgSGZkuPpzVxA8GrLxUboHV7yZ2wSAvs14CxW3KOlbgl/bmCgD4hEbiOUe+Qei3ca23ihEzD43dkNLxuFPzl17sj4PE+rQhPP9TzzfG2ks4zxnUyEs/b5oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hY8tXSo5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so14636a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 03:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729075754; x=1729680554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqRqGRF1VySphqdyBOb5GNHPJs16AcbMlWU0XE/fB+o=;
        b=hY8tXSo5B2hNXHbPz0kMTx7PcuhgBP6B998zlRKZvuJPkLhb8AoEMfSDlMFYKlLA0U
         boEK6IymXrc9SM2hnwrRDorc8RJ+cztCA/pdKn7OmqgojXpW3m+kIUQUJTbOiabprlAX
         oqDYSGyWWl13GVddXNCiqUeSdTm9OGlD9gmGHIJ0kLMBtJzfJL81sm2MW4sXEK0rcjkt
         UuxP4UixGVPjS0a4WSmoTDOMEhJhAVRMv51SdcqNWIv6huxOM01iRPkKfVVZnBK5kF5U
         OLVQyzkVMwlFZvijofBXJzD4L1q60U8zbJTfV3z8e7UkXUyk85H0/fgek1LtCLM4NDRr
         q3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729075754; x=1729680554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqRqGRF1VySphqdyBOb5GNHPJs16AcbMlWU0XE/fB+o=;
        b=cGNsuSSAVo36OUfrX1NL5FxScUyoWUxcSSkM7qQCxNU5XC7SLac33hTM6wgUPKL1tC
         KGqjlTRncLy6nDRZUciSwYG2yi2FkFHtNoOCd1ke30jPS+N9Ia9ivrpuG6/wc9oI8tDt
         Zc1kXVdxu/5agNe18UcoImHyw9bUct/tPg0mcicX3ZhXlbqrGppfgIXcMOQY1PgjbNoG
         O1ReGSOu3Pt4RRcNRMQ33bQBBcXSkNtrqCChj4480YrVuYgwDy2SHM7tL2kGzuQuZfGP
         dpWjb+LGzgGlCWgY2aMGLTNJS4F/pPQKIQsmxLfsmRRSdX7c05hYoV80eEiLHM1Lu+Y7
         U2ng==
X-Forwarded-Encrypted: i=1; AJvYcCUUgVkFOtlH7y3Z6L3h0+kK7rXFngkP09Q2iK0jEwKvnMFnH905iBrU94fSCEw7tFcgG2xxABsFN9sECL5IEBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzArzvkZhPtzFfNNjRxfA79dnu1jMiB69omH5cuoTch9izjTT1D
	Mg9rcgY3Tb0N+dC3RsIxzSrWByGXhPdmUOMUfU7nF4OiNwMq9Ex5+qyv5KmeBywLi0VbE/Vj4Im
	FWQ4kvQ0lnRjsDxbQ9egWdnZWsqo061umgs6t
X-Google-Smtp-Source: AGHT+IEOaQ4cgkPExzBkgZGD4dOtgPfim6YoQJY1ySC/ykGcUlK7ML3iO3mQ0h89zzZPsHTX3ghBdYyNrM7ENxR9XDk=
X-Received: by 2002:a05:6402:34c6:b0:5c8:84b5:7e78 with SMTP id
 4fb4d7f45d1cf-5c997a90d4bmr449217a12.4.1729075742925; Wed, 16 Oct 2024
 03:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com> <bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com>
 <Zwf7k1wmPqEEaRxz@x1n> <diqz8quunrlw.fsf@ackerleytng-ctop.c.googlers.com>
 <Zw7f3YrzqnH-iWwf@x1n> <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com> <9abab5ad-98c0-48bb-b6be-59f2b3d3924a@redhat.com>
In-Reply-To: <9abab5ad-98c0-48bb-b6be-59f2b3d3924a@redhat.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 16 Oct 2024 16:18:49 +0530
Message-ID: <CAGtprH_AiVJAd4rxKZBC9372swf2hW8kFfWG2y7zBdzCmpLRUw@mail.gmail.com>
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
To: David Hildenbrand <david@redhat.com>
Cc: Ackerley Tng <ackerleytng@google.com>, Peter Xu <peterx@redhat.com>, tabba@google.com, 
	quic_eberman@quicinc.com, roypat@amazon.co.uk, jgg@nvidia.com, 
	rientjes@google.com, fvdl@google.com, jthoughton@google.com, 
	seanjc@google.com, pbonzini@redhat.com, zhiquan1.li@intel.com, 
	fan.du@intel.com, jun.miao@intel.com, isaku.yamahata@intel.com, 
	muchun.song@linux.dev, erdemaktas@google.com, qperret@google.com, 
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org, 
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev, 
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com, 
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com, 
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com, pgonda@google.com, 
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 2:20=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> >> I also don't know how you treat things like folio_test_hugetlb() on
> >> possible assumptions that the VMA must be a hugetlb vma.  I'd confess =
I
> >> didn't yet check the rest of the patchset yet - reading a large series
> >> without a git tree is sometimes challenging to me.
> >>
> >
> > I'm thinking to basically never involve folio_test_hugetlb(), and the
> > VMAs used by guest_memfd will also never be a HugeTLB VMA. That's
> > because only the HugeTLB allocator is used, but by the time the folio i=
s
> > mapped to userspace, it would have already have been split. After the
> > page is split, the folio loses its HugeTLB status. guest_memfd folios
> > will never be mapped to userspace while they still have a HugeTLB
> > status.
>
> We absolutely must convert these hugetlb folios to non-hugetlb folios.
>
> That is one of the reasons why I raised at LPC that we should focus on
> leaving hugetlb out of the picture and rather have a global pool, and
> the option to move folios from the global pool back and forth to hugetlb
> or to guest_memfd.
>
> How exactly that would look like is TBD.
>
> For the time being, I think we could add a "hack" to take hugetlb folios
> from hugetlb for our purposes, but we would absolutely have to convert
> them to non-hugetlb folios, especially when we split them to small
> folios and start using the mapcount. But it doesn't feel quite clean.

As hugepage folios need to be split up in order to support backing
CoCo VMs with hugepages, I would assume any folio based hugepage
memory allocation will need to go through split/merge cycles through
the guest memfd lifetime.

Plan through next RFC series is to abstract out the hugetlb folio
management within guest_memfd so that any hugetlb specific logic is
cleanly separated out and allows guest memfd to allocate memory from
other hugepage allocators in the future.

>
> Simply starting with a separate global pool (e.g., boot-time allocation
> similar to as done by hugetlb, or CMA) might be cleaner, and a lot of
> stuff could be factored out from hugetlb code to achieve that.

I am not sure if a separate global pool necessarily solves all the
issues here unless we come up with more concrete implementation
details. One of the concerns was the ability of implementing/retaining
HVO while transferring memory between the separate global pool and
hugetlb pool i.e. whether it can seamlessly serve all hugepage users
on the host. Another question could be whether the separate
pool/allocator simplifies the split/merge operations at runtime.

>
> --
> Cheers,
>
> David / dhildenb
>

