Return-Path: <linux-kselftest+bounces-18991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1304D98FAC2
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 01:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6960BB218D9
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 23:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0DF1CF5CE;
	Thu,  3 Oct 2024 23:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6sGEK0S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544061CB308
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999018; cv=none; b=QsjjeUzXfHkVJqMo6W3RTAKmr0IdiSy2GyhxgRTJtpuY06dtW5p3fBQOJloM53FcJWsCnCHYlPmH3tbLLAAHQoEYaTVQO7sxItjsGtX/uEcevr5arxhl6BIIZvM4OFkXIEd38PS2H9aI/m3Sy/sz3h7oYSXT3crV52TdQnXi6FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999018; c=relaxed/simple;
	bh=5U29iZZFBxQGptPoLMifIvs/bpbj5DZBwz1fHxqdbD8=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=r8dSYRyOqWlxyp2MhgbPBXjp1PAt+PW5pdVl4CXxHqeno/bAk9CzRySNowF+lVUKLILiQlTzD+IDmwMKUl3f/8wyzbU4clyKr2VKuPlKNKd7QQyiBxsJAljm+ftqRzmAQImpobNwkDIy6Fx4hM53cy4m9q/9l3r2iHsNUzSiETw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R6sGEK0S; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2e18b6cd304so1579906a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Oct 2024 16:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727999017; x=1728603817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SN3dVjC5fB1CQSshX6WwUlOM21L2K4T7gTVUDpU5VO4=;
        b=R6sGEK0SG4OOmzKed1UA7F7lPzL4KmkbrArDZb192L9hwUxy2xew76wDcibZdyIdow
         bKKkP9r3jV82sI7qBZg8p3jBaFRgdsfm76/YTe/MYa27Di5bO8HcVKifYDDnz3tQm6uY
         GzvO2/GuBaTRJMUCaGJr7BWP8B+07lLTeqbroj3coeQpqfvBxhZa56jaTqJXOcST2fzj
         xLtkuidp+n0FWreMRXKGvLWheBGSYotgygi1cdvt91E6LzHdcDLt4Ag6aIJEqTt7BM6n
         LaPPZDQWkAtW25g7mLgo9oiB6ogJpulukrd8DzBJl39EUTrK3nXh8aKUHfNt29/GGvRE
         KCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727999017; x=1728603817;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SN3dVjC5fB1CQSshX6WwUlOM21L2K4T7gTVUDpU5VO4=;
        b=W8YziBw59hnLKsXFjru17w/VLZNUduZcU9v1snwXzyummx1TmXWQEOotHZ6GWRpAdp
         Pclm/wsr945IRJ2sv6oJCVXJCr8t11jp1oNYB3ycSzb0iLMMesQ9hcKM72+GRXxNQmZH
         u0UBTTaT243lsPSXiZ7BuHOmEJJDaxgqXSaH18m35eElAw37u70vZWJFWDHuXTj/Nhp5
         o5Uf5Ch5VnhJMUd1Uy3HZmdegLlxC5WlW3nxE8ZSOd/MrpJlxqL8gAE32duyKufUu+2V
         L3N/ggKPcBXhdGM1USwIQsfnPS25OJfHePcVtTzD/RvqJQnBfKMVP9yZ6tKvGByKaOCH
         uPpA==
X-Forwarded-Encrypted: i=1; AJvYcCWB4SFlkB0cMUaodArGT4qaRDZ6VynHZdVNEdE4CL9sWiPtn9lkVpeM0WIB/6tfvqbys9oxx0A0B6PTJ95nOC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjhfkcEVSTv6xcsFcdkAwkL6p3sxVvNG2YKmnEcV2KrjGx5Us4
	VJxPcLmHpsgq2RZry0ZG/XmqOWh66OqwAiDadBhpEFA7xP1ZTQ6KtuY1sCY+0m+HamKg/nnc8zd
	P1p5DkHVI6CBLIoakbRFRuQ==
X-Google-Smtp-Source: AGHT+IHBOIxM9r0ehPl4c3IhMwECnflPechWmOVBJu0WiGbLsRHWGkU66D8A48Rkw+4e+C8ZFyGr8wE06O6tn38x1g==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:146:b875:ac13:a9fc])
 (user=ackerleytng job=sendgmr) by 2002:a17:90a:51c7:b0:2e0:72ab:98e9 with
 SMTP id 98e67ed59e1d1-2e1e5dc5fcemr2279a91.0.1727999016517; Thu, 03 Oct 2024
 16:43:36 -0700 (PDT)
Date: Thu, 03 Oct 2024 23:43:35 +0000
In-Reply-To: <diqzzfnkswiv.fsf@ackerleytng-ctop.c.googlers.com> (message from
 Ackerley Tng on Thu, 03 Oct 2024 21:32:08 +0000)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqzwmiosqfs.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 30/39] KVM: guest_memfd: Handle folio preparation for
 guest_memfd mmap
From: Ackerley Tng <ackerleytng@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: quic_eberman@quicinc.com, tabba@google.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com, erdemaktas@google.com, vannapurve@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> Elliot Berman <quic_eberman@quicinc.com> writes:
>
>> On Tue, Sep 10, 2024 at 11:44:01PM +0000, Ackerley Tng wrote:
>>> Since guest_memfd now supports mmap(), folios have to be prepared
>>> before they are faulted into userspace.
>>>
>>> When memory attributes are switched between shared and private, the
>>> up-to-date flags will be cleared.
>>>
>>> Use the folio's up-to-date flag to indicate being ready for the guest
>>> usage and can be used to mark whether the folio is ready for shared OR
>>> private use.
>>
>> Clearing the up-to-date flag also means that the page gets zero'd out
>> whenever it transitions between shared and private (either direction).
>> pKVM (Android) hypervisor policy can allow in-place conversion between
>> shared/private.
>>
>> I believe the important thing is that sev_gmem_prepare() needs to be
>> called prior to giving page to guest. In my series, I had made a
>> ->prepare_inaccessible() callback where KVM would only do this part.
>> When transitioning to inaccessible, only that callback would be made,
>> besides the bookkeeping. The folio zeroing happens once when allocating
>> the folio if the folio is initially accessible (faultable).
>>
>> From x86 CoCo perspective, I think it also makes sense to not zero
>> the folio when changing faultiblity from private to shared:
>>  - If guest is sharing some data with host, you've wiped the data and
>>    guest has to copy again.
>>  - Or, if SEV/TDX enforces that page is zero'd between transitions,
>>    Linux has duplicated the work that trusted entity has already done.
>>
>> Fuad and I can help add some details for the conversion. Hopefully we
>> can figure out some of the plan at plumbers this week.
>
> Zeroing the page prevents leaking host data (see function docstring for
> kvm_gmem_prepare_folio() introduced in [1]), so we definitely don't want
> to introduce a kernel data leak bug here.

Actually it seems like filemap_grab_folio() already gets a zeroed page.

filemap_grab_folio() eventually calls __alloc_pages_noprof()
-> get_page_from_freelist()
   -> prep_new_page()
      -> post_alloc_hook()

and post_alloc_hook() calls kernel_init_pages(), which zeroes the page,
depending on kernel config.

Paolo, was calling clear_highpage() in kvm_gmem_prepare_folio() zeroing an
already empty page returned from filemap_grab_folio()?

> In-place conversion does require preservation of data, so for
> conversions, shall we zero depending on VM type?
>
> + Gunyah: don't zero since ->prepare_inaccessible() is a no-op
> + pKVM: don't zero
> + TDX: don't zero
> + SEV: AMD Architecture Programmers Manual 7.10.6 says there is no
>   automatic encryption and implies no zeroing, hence perform zeroing
> + KVM_X86_SW_PROTECTED_VM: Doesn't have a formal definition so I guess
>   we could require zeroing on transition?
>
> This way, the uptodate flag means that it has been prepared (as in
> sev_gmem_prepare()), and zeroed if required by VM type.
>
> Regarding flushing the dcache/tlb in your other question [2], if we
> don't use folio_zero_user(), can we relying on unmapping within core-mm
> to flush after shared use, and unmapping within KVM To flush after
> private use?
>
> Or should flush_dcache_folio() be explicitly called on kvm_gmem_fault()?
>
> clear_highpage(), used in the non-hugetlb (original) path, doesn't flush
> the dcache. Was that intended?
>
>> Thanks,
>> Elliot
>>
>>>
>>> <snip>
>
> [1] https://lore.kernel.org/all/20240726185157.72821-8-pbonzini@redhat.com/
> [2] https://lore.kernel.org/all/diqz34ldszp3.fsf@ackerleytng-ctop.c.googlers.com/

