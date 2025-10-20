Return-Path: <linux-kselftest+bounces-43548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF0DBF1425
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 14:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4508818A5F36
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 12:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F4930595A;
	Mon, 20 Oct 2025 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1npdZRF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210FF2FDC20
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963859; cv=none; b=gJGzQAB7Nv8hdJQVxrBMTmPve0McM4+Szih70ZcwBa9wQDu6aOgpsocX4C1puy8yuYZbVDJxZK3y0aVbVKI8I5NhqfatAS/ciacGkiBIj2GFV8oiwozMbsLW4QLf4wMKQ9yrtfHVhqrFr+Q1DUA+2soaKdukSZcymNkrqVcSSqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963859; c=relaxed/simple;
	bh=BTFDwTBAdtJjfKZNownb+OFKnK2y5hO+biG1xBtNyyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGemBC+I29IXVZtPfzfZw3diDzoHHfctd0qTHOEfOZY9mxAXhKdT4IUZ/nuqBIOTxcYnvJO0D9pUuijIlADTs4dYWohy323BKD7ldfIo2O6ZHR/dffOV8cjkYCmclC15nJVInRTOgiSaFNODNVygT5//691R9RNhnQW3XJ5t9HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1npdZRF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760963856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tzznurqx8GJgltwtpurg4k5zkXdNLWNROXLORXJz3Nc=;
	b=d1npdZRFEEfyXa34BcPpbVS7aWt6gBdIk4TG/y6nCvWM5d0JEwlfFZFLmiUNFI3tIYCDgm
	AchVUJfEXJpd+6P3rC2hD8j0n8kWGDojXu0wg2uPwj/RbkiF52gdCPJ+scQcnZknBmHrQj
	qdzYWFv6iQYwko6oexrYK/J1ivvHdqQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-_zKhQ8C1MA-2hEyFqb517w-1; Mon, 20 Oct 2025 08:37:34 -0400
X-MC-Unique: _zKhQ8C1MA-2hEyFqb517w-1
X-Mimecast-MFC-AGG-ID: _zKhQ8C1MA-2hEyFqb517w_1760963854
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4711899ab0aso33160615e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 05:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760963854; x=1761568654;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzznurqx8GJgltwtpurg4k5zkXdNLWNROXLORXJz3Nc=;
        b=aDm5yh4+sM/oGbBKertcSEG8fSzY3IwRJsPRuVpkLnete8hrIxWvRnxHqmLcPzFlYB
         KCJcFg2Z7GsbuQIv6wlLqDQdJ0X6LWOA6PwhoKEvK94z1f2DE2MyWuOMEFTUDXepLYTo
         4qJnDuM7b7jObE7KjReyiVYUCpRVLif7SIzcK0BC9DnaygX/sZuhCSPVwS1ovD8qTDAg
         4ISG9j4SHaq+9FhhQMyKzSE5xLQOBwIlDrRQwMOmFzgHy50xrHFuXNF0ipWpvtXFJBsg
         02Ho/dKTrhNfmC2IIGB8yWK93PKX0qFPnEOxZSF8jUK1WToIKV8H4NAbHRw9vXtDuTNA
         YmLg==
X-Forwarded-Encrypted: i=1; AJvYcCU5k0PGWO2K7bd+qoROeFsxRRZKC4Ff7Agifkz9Ztos4GaYxMO4A6Ax+VcXADyGQRPrjWdeQepGQVHvhEoU8AM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1hyKjWbv1mLOpSJG80ZazO9EdG/ah/OgCZ+qFOlJS7kOeaoNl
	IyINyNuoY28OkwWlIG1uWohz6vG2FPu3YcVrmcvkxjdq/AquCtSaVMr28tDyGdopMSwL2Rj5jlq
	6Pz2OCWDiIW/tyMPUJevYIEh1bHmF1HCjLBWrWo8e2MXQF5IWfyqzbfbtMyOxYg2MGCNEeA==
X-Gm-Gg: ASbGncuzQ4kRlcAWW7X58Vbmh/cVvmIyPcAbl95qyGBiHtedLwfGF5PRe6GKoj7iyTv
	OhgjuEiUT/x8HfpK3TkoORKsK9pqP+J6uaQGhV4Fg/MzJqQMgmE3p4M226q9KeipzllflvdU9wc
	1PiD0fXwMR6+lnpNOLRF8WOZ4IlHfsKEQ5qwX4sW0YPh8sxiyV82SMCOL1fviip1c8GR1B4j8ga
	WLVk+VOHmkgdRPn1Viaq4PB59hohzspviuTNEZs1/usZmMw/V2ltuEerIWMK22xSJo0X9pAHYOh
	MCucgBrKfLMQC7JmM46Suhrz6ygpNiflTscv6CR2lXoqOfoK6zinzeCwF6KfBdVwBlx3OplfTTc
	qrVyF9/kh56/HKsA4zfVU5zTW6rVwmjf5J6li87FzYKnrmPQENRn61XsV0gGsU4UuOj7s0HhlUZ
	T5Hd0IvUEP1femcxjaZtZVCLohwlg=
X-Received: by 2002:a05:600c:1f93:b0:46f:b42e:e367 with SMTP id 5b1f17b1804b1-4711792a527mr88896165e9.41.1760963853728;
        Mon, 20 Oct 2025 05:37:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQEUVrP5ywE2htPBOZIvhFEciVwEdQZ4U4H8zs/D2D8uFWsnOx+7qYC1vDVJTNM7Dv5yngwA==
X-Received: by 2002:a05:600c:1f93:b0:46f:b42e:e367 with SMTP id 5b1f17b1804b1-4711792a527mr88895945e9.41.1760963853238;
        Mon, 20 Oct 2025 05:37:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4714fb1b668sm164496295e9.0.2025.10.20.05.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 05:37:32 -0700 (PDT)
Message-ID: <150c0d14-326b-4abf-8d95-26e47507a22f@redhat.com>
Date: Mon, 20 Oct 2025 14:37:31 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 1/3] mm: memory_failure: Fix MF_DELAYED
 handling on truncation during failure
To: Lisa Wang <wyihan@google.com>, linmiaohe@huawei.com,
 nao.horiguchi@gmail.com, akpm@linux-foundation.org, pbonzini@redhat.com,
 shuah@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: rientjes@google.com, seanjc@google.com, ackerleytng@google.com,
 vannapurve@google.com, michael.roth@amd.com, jiaqiyan@google.com,
 tabba@google.com, dave.hansen@linux.intel.com
References: <cover.1760551864.git.wyihan@google.com>
 <57ed0bcbcfcec6fda89d60727467d7bd621c95ab.1760551864.git.wyihan@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <57ed0bcbcfcec6fda89d60727467d7bd621c95ab.1760551864.git.wyihan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Lisa accidentally dropped all Tos/CCs, so here is her mail with my reply forwarded:


-------- Forwarded Message --------
Subject: Re: [RFC PATCH RESEND 1/3] mm: memory_failure: Fix MF_DELAYED handling on truncation during failure
Date: Mon, 20 Oct 2025 14:35:45 +0200
From: David Hildenbrand <david@redhat.com>
To: Lisa Wang <wyihan@google.com>

On 17.10.25 17:31, Lisa Wang wrote:
> On Thu, Oct 16, 2025 at 10:18:17PM +0200, David Hildenbrand wrote:
>> On 15.10.25 20:58, Lisa Wang wrote:
>>> The .error_remove_folio a_ops is used by different filesystems to handle
>>> folio truncation upon discovery of a memory failure in the memory
>>> associated with the given folio.
>>>
>>> Currently, MF_DELAYED is treated as an error, causing "Failed to punch
>>> page" to be written to the console. MF_DELAYED is then relayed to the
>>> caller of truncat_error_folio() as MF_FAILED. This further causes
>>> memory_failure() to return -EBUSY, which then always causes a SIGBUS.
>>>
>>> This is also implies that regardless of whether the thread's memory
>>> corruption kill policy is PR_MCE_KILL_EARLY or PR_MCE_KILL_LATE, a
>>> memory failure within guest_memfd memory will always cause a SIGBUS.
>>>
>>> Update truncate_error_folio() to return MF_DELAYED to the caller if the
>>> .error_remove_folio() callback reports MF_DELAYED.
>>>
>>> Generalize the comment: MF_DELAYED means memory failure was handled and
>>> some other part of memory failure will be handled later (e.g. a next
>>> access will result in the process being killed). Specifically for
>>> guest_memfd, a next access by the guest will result in an error returned
>>> to the userspace VMM.
>>>
>>> With delayed handling, the filemap continues to hold refcounts on the
>>> folio. Hence, take that into account when checking for extra refcounts
>>> in me_pagecache_clean(). This is aligned with the implementation in
>>> me_swapcache_dirty(), where, if a folio is still in the swap cache,
>>> extra_pins is set to true.
>>>
>>> Signed-off-by: Lisa Wang <wyihan@google.com>
>>> ---
>>>    mm/memory-failure.c | 24 +++++++++++++++---------
>>>    1 file changed, 15 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index df6ee59527dd..77f665c16a73 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -922,9 +922,11 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
>>>     * by the m-f() handler immediately.
>>>     *
>>>     * MF_DELAYED - The m-f() handler marks the page as PG_hwpoisoned'ed.
>>> - * The page is unmapped, and is removed from the LRU or file mapping.
>>> - * An attempt to access the page again will trigger page fault and the
>>> - * PF handler will kill the process.
>>> + * It means memory_failure was handled (e.g. removed from file mapping or the
>>> + * LRU) and some other part of memory failure will be handled later (e.g. a
>>> + * next access will result in the process being killed). Specifically for
>>> + * guest_memfd, a next access by the guest will result in an error returned to
>>> + * the userspace VMM.
>>>     *
>>>     * MF_RECOVERED - The m-f() handler marks the page as PG_hwpoisoned'ed.
>>>     * The page has been completely isolated, that is, unmapped, taken out of
>>> @@ -999,6 +1001,9 @@ static int truncate_error_folio(struct folio *folio, unsigned long pfn,
>>>    	if (mapping->a_ops->error_remove_folio) {
>>>    		int err = mapping->a_ops->error_remove_folio(mapping, folio);
>>> +		if (err == MF_DELAYED)
>>> +			return err;
>>> +
>>>    		if (err != 0)
>>>    			pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
>>>    		else if (!filemap_release_folio(folio, GFP_NOIO))
>>> @@ -1108,18 +1113,19 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
>>>    		goto out;
>>>    	}
>>> -	/*
>>> -	 * The shmem page is kept in page cache instead of truncating
>>> -	 * so is expected to have an extra refcount after error-handling.
>>> -	 */
>>> -	extra_pins = shmem_mapping(mapping);
>>> -
>>>    	/*
>>>    	 * Truncation is a bit tricky. Enable it per file system for now.
>>>    	 *
>>>    	 * Open: to take i_rwsem or not for this? Right now we don't.
>>>    	 */
>>>    	ret = truncate_error_folio(folio, page_to_pfn(p), mapping);
>>> +
>>> +	/*
>>> +	 * The shmem page, or any page with MF_DELAYED error handling, is kept in
>>> +	 * page cache instead of truncating, so is expected to have an extra
>>> +	 * refcount after error-handling.
>>> +	 */
>>> +	extra_pins = shmem_mapping(mapping) || ret == MF_DELAYED;
> 
> Hello David,
> 
> Thank you for reviewing these patches!
> 
>> Well, to do it cleanly shouldn't we let shmem_error_remove_folio() also
>> return MF_DELAYED and remove this shmem special case?
>>
> 
> I agree shmem_error_remove_folio() should probably also return MF_DELAYED.
> MF_DELAYED sounds right because shmem does not truncate, and hence it
> should not call filemap_release_folio() to release fs-specific metadata on
> a folio.

Just to clarify for others, this is the code we are talking about in filemap_release_folio():

if (mapping->a_ops->error_remove_folio) {
	int err = mapping->a_ops->error_remove_folio(mapping, folio);

	if (err != 0)
		pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
	else if (!filemap_release_folio(folio, GFP_NOIO))
		pr_info("%#lx: failed to release buffers\n", pfn);
	else
		ret = MF_RECOVERED;
} ...

> 
> There's no bug now in memory failure handling for shmem calling
> filemap_release_folio(), because

Right, because shmem error_remove_folio() will currently return 0.

> 
> shmem does not have folio->private
> => filemap_release_folio() is a no-op anyway
> => filemap_release_folio() returns true
> => truncate_error_folio() returns MF_RECOVERED

Agreed.

> => truncate_error_folio()'s caller cleans MF_RECOVERED up to eventually
> return 0.

Yes.

> 
>> Or is there a good reason shmem_mapping() wants to return 0 -- and maybe
>> guest_memfd would also wan to do that?
>>
> 
> The tradeoff is if I change shmem_error_remove_folio()'s return, mf_stats
> will be changed.

But it actually sounds like the right thing to do, no? Who cares about
the stats being delayed vs. recovered?

> I'd be happy to update shmem_error_remove_folio() to
> return MF_DELAYED as well, but is it okay that the userspace-visible
> behavior in the form of statistics will change?

They never really were "recovered", but always "delayed", correct?
In that case, it almost sounds like a fix.

> 
>> Just reading the code here the inconsistency is unclear.
> 
> Another option is to add kvm_gmem_mapping() like shmem_mapping().

Oh no.

As an alternative we could introduce a new MF_* to handle this case.

But it almost sounds like MF_DELAYED does exactly what we want, so I
would suggest to try that first to see if there is any pushback/good
reason to let shmem result in "recovered" when it's really "delayed".


BTW, the behavior from truncate (recovered) -> keep (delayed) was added in

commit a7605426666196c5a460dd3de6f8dac1d3c21f00
Author: Yang Shi <shy828301@gmail.com>
Date:   Fri Jan 14 14:05:19 2022 -0800

      mm: shmem: don't truncate page if memory failure happens
           The current behavior of memory failure is to truncate the page cache
      regardless of dirty or clean.  If the page is dirty the later access
      will get the obsolete data from disk without any notification to the
      users.  This may cause silent data loss.  It is even worse for shmem
      since shmem is in-memory filesystem, truncating page cache means
      discarding data blocks.  The later read would return all zero.
           The right approach is to keep the corrupted page in page cache, any
      later access would return error for syscalls or SIGBUS for page fault,
      until the file is truncated, hole punched or removed.  The regular
      storage backed filesystems would be more complicated so this patch is
      focused on shmem.  This also unblock the support for soft offlining
      shmem THP.
      

-- 
Cheers

David / dhildenb


