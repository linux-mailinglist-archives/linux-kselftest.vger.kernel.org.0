Return-Path: <linux-kselftest+bounces-18977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1F698F805
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 22:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37882829E6
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 20:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F391AE850;
	Thu,  3 Oct 2024 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZK2WmAb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21391AAE05
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727987021; cv=none; b=uOb+bY5NwqJPdLS0epmqQkPgQQABcLRlSedJW5kz6ccU0RneRL6KFcX847M8RveXQ5bWavr/wm0FIMLE3EHQnKFCIIW77ey/QlhRZUFbiBL5ivt5e4FuJS6WlTB8MKCGuWWhONu24QVQu+5Z3Ywyz/rwpsQobq08cE5iO1Ri0xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727987021; c=relaxed/simple;
	bh=9VA3PqYMSXMSKGPh4htGFi/0/3JHfkNHId5Y+qOLBsQ=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=IXip1jCrwMpRVX/hRbWRZUWArsOAYwo4Cvrk1D5MOnYE7kYa4aJMK+B7Uw1ihssuVEvFIaPiWf8V6FMbB5vRm/dCfiRhHkMHyoNCGGAQFhj5TokZwTdatemtyt6xWNPWgXop94bqUBQ21T3XmfR5LQdKgtaTnT9DnmJ9gOupT28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZK2WmAb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20b333a1871so15924535ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Oct 2024 13:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727987018; x=1728591818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bsrxlfd04OhEv+n0CPbWpU82YP7zkM1b/vn5t74+eZQ=;
        b=wZK2WmAbTB9D61/WhdMyO4Kagh/+tP8+qhn2RSuZr2yGHruC4QBdPmR+da6d89x7MA
         0FBAF9VTQmNJTsln7tZpvHfrLiri0PXSy+u2Znfl44RGXUs6+1EHJa4BzIQuMB5CIsbC
         F1GqWpN356u7rmhos5Pd3yEEIpoWd8gHpFXf81nj9TM7omQZQJYM2bAX3MSo3ODDChtj
         s7WJozxAwiOjSA2L/07k5uPV3ZS6MvZtZIyW6VAT8Hfxjk4BoAYU8cA1O0iZQtXS2s/h
         iplxi8Azh4n2TH/irNoC2C9dphUd+ZvAt90hbDyZFkhASa7RKvJ+Hz1fV7RWVzx3VtX+
         UkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727987018; x=1728591818;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsrxlfd04OhEv+n0CPbWpU82YP7zkM1b/vn5t74+eZQ=;
        b=nNbOrvoQiJWEqZZ0TDokQr5D7qlbBXyFQYrERHCoMKpNUtM5Oiei/zjsT0zNIou4eE
         NenkFjKjXJJjWo38e32KSMOPvt9VYa0c8hKtPmTeb8Nchv4U9oUo979u7hc+jNTq9SMG
         DgDxN8AuwCKaW0lsYWCronESH0Gk1W/V9NIAbzNxVANOdhT9p65FxhECNNyUdb73/CPM
         FdVq5NHxs/OadJ7ELwV5SR1+4XN0hf4PXL8J/nTrgXy9ukfQZa8DX/ZlELtldLpyBkFS
         LCxlj5cZHvaKNHHnEgQo1WtGQDeXXQvT1RFoHI+Ge95kE0W5MTj9jJh2e2CZKMswP6rC
         KRTg==
X-Forwarded-Encrypted: i=1; AJvYcCXu8accvSyo2IHSZ/VmWDJO9Pih+WphVdoy//DmxZxOh402W942dUQ1KLUthK7wcGBseEMjFkj3nKFvXfNqEFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOxn3XX9LVt+UmCNSwzFrgY5vygCj1bqpqkgQiaTZO/BNrF1vz
	g3P7Zw/uesG33GNSu2iyhzyEh8+Jj1rZgFe1Kdn9lJQiHW81mIdbf8wlKcfv/YU4yrGCbjjsYTa
	aonVN3jmA33eFk5tc8vtj7Q==
X-Google-Smtp-Source: AGHT+IFpD6BWHM5h+33v0jB6Q6n9bSyUbGf9Hz29V0yy4Czzzteo1cbIqPdjyXE3Ss97ow9Hj9/CtpXBjfv/MY3knw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:146:b875:ac13:a9fc])
 (user=ackerleytng job=sendgmr) by 2002:a17:903:187:b0:20b:bd8d:427a with SMTP
 id d9443c01a7336-20bfe17d820mr65455ad.5.1727987017910; Thu, 03 Oct 2024
 13:23:37 -0700 (PDT)
Date: Thu, 03 Oct 2024 20:23:36 +0000
In-Reply-To: <20240913151802822-0700.eberman@hu-eberman-lv.qualcomm.com>
 (message from Elliot Berman on Fri, 13 Sep 2024 15:26:30 -0700)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqz34ldszp3.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 15/39] KVM: guest_memfd: hugetlb: allocate and
 truncate from hugetlb
From: Ackerley Tng <ackerleytng@google.com>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: tabba@google.com, roypat@amazon.co.uk, jgg@nvidia.com, peterx@redhat.com, 
	david@redhat.com, rientjes@google.com, fvdl@google.com, jthoughton@google.com, 
	seanjc@google.com, pbonzini@redhat.com, zhiquan1.li@intel.com, 
	fan.du@intel.com, jun.miao@intel.com, isaku.yamahata@intel.com, 
	muchun.song@linux.dev, mike.kravetz@oracle.com, erdemaktas@google.com, 
	vannapurve@google.com, qperret@google.com, jhubbard@nvidia.com, 
	willy@infradead.org, shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

Elliot Berman <quic_eberman@quicinc.com> writes:

> On Tue, Sep 10, 2024 at 11:43:46PM +0000, Ackerley Tng wrote:
>> If HugeTLB is requested at guest_memfd creation time, HugeTLB pages
>> will be used to back guest_memfd.
>> 
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>>
>> <snip>
>>
>> +/**
>> + * Use the uptodate flag to indicate that the folio is prepared for KVM's usage.
>> + */
>>  static inline void kvm_gmem_mark_prepared(struct folio *folio)
>>  {
>>  	folio_mark_uptodate(folio);
>> @@ -72,13 +84,18 @@ static inline void kvm_gmem_mark_prepared(struct folio *folio)
>>  static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>>  				  gfn_t gfn, struct folio *folio)
>>  {
>> -	unsigned long nr_pages, i;
>>  	pgoff_t index;
>>  	int r;
>>  
>> -	nr_pages = folio_nr_pages(folio);
>> -	for (i = 0; i < nr_pages; i++)
>> -		clear_highpage(folio_page(folio, i));
>> +	if (folio_test_hugetlb(folio)) {
>> +		folio_zero_user(folio, folio->index << PAGE_SHIFT);
>
> Is (folio->index << PAGE_SHIFT) the right address hint to provide?
> I don't think we can say the folio will be mapped at this address since
> this value is an offset into the file.  In most cases, I believe it
> won't be mapped anywhere since we just allocated it.


vaddr in folio_zero_user(folio, vaddr) is eventually passed to
clear_user_page(). clear_user_page() uses vaddr to clean up dcaches on
some architectures, according to Documentation/core-api/cachetlb.rst.

In this patch series, folio_zero_user() is used in 2 places:

+ kvm_gmem_prepare_folio()
+ kvm_gmem_fault()

folio->index is valid by the time folio_zero_user() is called in
kvm_gmem_prepare_folio(), because when kvm_gmem_prepare_folio() is called, the
folio is already in the filemap, and folio->index is set when the folios is
added to the filemap.

In kvm_gmem_fault(), kvm_gmem_get_folio() also returns a folio in the filemap
and so folio->index is valid by the tiem folio_zero_user() is called.

Hence in both cases where folio_zero_user() is called, folio->index <<
PAGE_SHIFT returns the offset in the file.

In hugetlb's fallocate, the offset within the file is passed in the call to
folio_zero_user(), which is why the offset within the file was used here.

In the next revision I will refactor this to something like
kvm_gmem_prepare_folio_shared() and kvm_gmem_prepare_folio_private().

In kvm_gmem_prepare_folio_private(), folio->index << PAGE_SHIFT can still be
passed as addr_hint to align with HugeTLB. When being prepared as a private
folio, the folio will be mapped by KVM: addr_hint won't matter since this folio
isn't going to be mapped into userspace. If the folio was previously used as a
shared page, unmapping would have flushed the dcache.

In kvm_gmem_prepare_folio_shared(), the folio will subsequently be mapped and
vmf->real_address should be passed as addr_hint.

Thanks for this question!

