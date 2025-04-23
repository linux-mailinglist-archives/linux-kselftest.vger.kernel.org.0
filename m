Return-Path: <linux-kselftest+bounces-31458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED58A99B2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 00:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA0657A7B4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 22:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518961EDA2F;
	Wed, 23 Apr 2025 22:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4UL2HtJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0921EA7CD
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 22:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745445727; cv=none; b=joIF/fo6QCajDkp/t8NVZ4ISFSTd6NC2L+ylNPCZysqHK0E/rTeNcajC7kc0TsqmUbSpT1HuGkUITUCmdOHYayl7VXC32xPOIIdWEgy1PJcpJEMeF8zjU2HA90lr83HXq/tQk+4GYsNJDIR6T4mt67vk/yw/340orr2keHRwKDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745445727; c=relaxed/simple;
	bh=/kYvkbcWE+9uoIdgKSwT0wqIwZi66c9Fis9jhsJOymo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=irzF7fIxpIczJY/cIya+Crsnyp0TJqzt2/sEsHcJnoSTuWVCo++Vp+kP1H1nWiLHFFDn6kvocZtuRTIxlZcW2twJKkA5c8tjGcmhyEXVAlHMNuZCKMs2Prf2IRGC5086jI2pCeJ4NKWyWczPCozFWsIgeqhFOO0jtwqn6B6vpN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y4UL2HtJ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b0e0c573531so145832a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 15:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745445725; x=1746050525; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZshVHDiSVI1msI3W+ro+KzMPJMPZ2JcnJbSD4cGabVM=;
        b=Y4UL2HtJZoyj77BivhexhY40IsHjEKRM507qbJBkBhlXUJB5yKC4L7X6WCqFPK4wdP
         cwqf3xxOgOIlAV8sLcZqycUOI/YVz3n/WZ06IljU2Wu95oO0dwsJXBViT5Fajy3Yyyr3
         ktW/8b+uRmCWxT/d4rmtw1f+2eOZdg3yWAnZ2V6BrxsJIK83OrAZPvIDmcYmWJhXiuHv
         JHY891pK1FhMQJMy9GecNLzESLQ7qH4HsIntSKOPrpcUR0clmFj/eN2DfR1OwWCzcfL0
         /XxBilLdSgpqyp/9uZOxg/yDe4LDUoGqocUHb+ayqbbRZ1ROqDsMeC08PPZXPgTT9aRh
         wefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745445725; x=1746050525;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZshVHDiSVI1msI3W+ro+KzMPJMPZ2JcnJbSD4cGabVM=;
        b=CXbZn9hHzau8luXH6k2Q5EUhZcD7wnHKefsao5MRiNGfkbtjMf/oF6Ak0bLtcjig7E
         rdeJ9gCcqYQ7rRIL73YkhpYuvSnryFc61yhHnb7gM/paJMyZFAxW78wDmLF5JNBJ7/j7
         zQvqKuarpYhElmSMVTHF6fH8Ns28pTQ9YComQKgxoi3OplGpg4RFA7GxVv9jvJG2tJoq
         PfWPoPb6vQ2GnJG9A57d4tOyRnirsKYwyN4/2wZ6TqoO7NMYKEHWO5RqbXmBIQ2vFmHm
         FA4cIT8NBLIByaiQWEoQkMSx53DBlsiGA9ZzJse71IOJ5uon3I97vNczkBdX/MH3TDCr
         8Q8g==
X-Forwarded-Encrypted: i=1; AJvYcCURQywEAhlFoj2m855xOArkqQGdoEH3mJLCdSaXPPvcQqNF4Sqc09SebKx8YB4bbFUyyN6rlqQYMlj6Rdiwyy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBLrJLKw6jQnhc57ektdroRwI/MWCx9gNsKbzhAs4McWqpIW9O
	6EcCwEpmSpC8prCEqY6AdV6QTnF/X59+aBgk3OtvcnlQc8ekFKlq96dmqsAgBgGQzBK3U8MtEZY
	aq8jL4mIKbjim3dfhcZ+WrA==
X-Google-Smtp-Source: AGHT+IG47bYyoQqSmgswCKOYeGTrnVac079gXJUVu/1TXbrM7dvGQWThFMm4vyGtqs9cP9ZCw5DfCSc3oxRjiC395w==
X-Received: from plcx19.prod.google.com ([2002:a17:903:d3:b0:229:1de5:3212])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e551:b0:220:ea90:191e with SMTP id d9443c01a7336-22db3baf262mr2268985ad.4.1745445724608;
 Wed, 23 Apr 2025 15:02:04 -0700 (PDT)
Date: Wed, 23 Apr 2025 15:02:02 -0700
In-Reply-To: <Z+6AGxEvBRFkN5mN@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com> <38723c5d5e9b530e52f28b9f9f4a6d862ed69bcd.1726009989.git.ackerleytng@google.com>
 <Z+6AGxEvBRFkN5mN@yzhao56-desk.sh.intel.com>
Message-ID: <diqzh62ezgdh.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 39/39] KVM: guest_memfd: Dynamically split/reconstruct
 HugeTLB page
From: Ackerley Tng <ackerleytng@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	erdemaktas@google.com, vannapurve@google.com, qperret@google.com, 
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org, 
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev, 
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com, 
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com, 
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com, pgonda@google.com, 
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

> On Tue, Sep 10, 2024 at 11:44:10PM +0000, Ackerley Tng wrote:
>> +/*
>> + * Allocates and then caches a folio in the filemap. Returns a folio with
>> + * refcount of 2: 1 after allocation, and 1 taken by the filemap.
>> + */
>> +static struct folio *kvm_gmem_hugetlb_alloc_and_cache_folio(struct inode *inode,
>> +							    pgoff_t index)
>> +{
>> +	struct kvm_gmem_hugetlb *hgmem;
>> +	pgoff_t aligned_index;
>> +	struct folio *folio;
>> +	int nr_pages;
>> +	int ret;
>> +
>> +	hgmem = kvm_gmem_hgmem(inode);
>> +	folio = kvm_gmem_hugetlb_alloc_folio(hgmem->h, hgmem->spool);
>> +	if (IS_ERR(folio))
>> +		return folio;
>> +
>> +	nr_pages = 1UL << huge_page_order(hgmem->h);
>> +	aligned_index = round_down(index, nr_pages);
> Maybe a gap here.
>
> When a guest_memfd is bound to a slot where slot->base_gfn is not aligned to
> 2M/1G and slot->gmem.pgoff is 0, even if an index is 2M/1G aligned, the
> corresponding GFN is not 2M/1G aligned.

Thanks for looking into this.

In 1G page support for guest_memfd, the offset and size are always
hugepage aligned to the hugepage size requested at guest_memfd creation
time, and it is true that when binding to a memslot, slot->base_gfn and
slot->npages may not be hugepage aligned.

>
> However, TDX requires that private huge pages be 2M aligned in GFN.
>

IIUC other factors also contribute to determining the mapping level in
the guest page tables, like lpage_info and .private_max_mapping_level()
in kvm_x86_ops.

If slot->base_gfn and slot->npages are not hugepage aligned, lpage_info
will track that and not allow faulting into guest page tables at higher
granularity.

Hence I think it is okay to leave it to KVM to fault pages into the
guest correctly. For guest_memfd will just maintain the invariant that
offset and size are hugepage aligned, but not require that
slot->base_gfn and slot->npages are hugepage aligned. This behavior will
be consistent with other backing memory for guests like regular shmem or
HugeTLB.

>> +	ret = kvm_gmem_hugetlb_filemap_add_folio(inode->i_mapping, folio,
>> +						 aligned_index,
>> +						 htlb_alloc_mask(hgmem->h));
>> +	WARN_ON(ret);
>> +
>>  	spin_lock(&inode->i_lock);
>>  	inode->i_blocks += blocks_per_huge_page(hgmem->h);
>>  	spin_unlock(&inode->i_lock);
>>  
>> -	return page_folio(requested_page);
>> +	return folio;
>> +}

