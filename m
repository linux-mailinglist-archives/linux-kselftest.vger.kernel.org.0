Return-Path: <linux-kselftest+bounces-38539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7FFB1E0C1
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 04:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFD117B1F19
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 02:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F071F1862BB;
	Fri,  8 Aug 2025 02:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD6OD3f2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03510AD5A;
	Fri,  8 Aug 2025 02:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754621889; cv=none; b=NHR2Vi0XGnsgAGR0KiUd47E8xmEjuQQJsmQG0h7SFK7N/ysRu/34HtttfRNGnRhwPk0L+13lCzG5nhar06v+yQ8ot4twhTO+/q485NFJE/llmF3BM4gaJ6NQxmVl9B6SHiGQwYMzuYBuQY5/Y13J71MYi51UYfQ/01WQh1N4apY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754621889; c=relaxed/simple;
	bh=1lMWAj6KJL4kWGPO92xUuoc17e21mm2z5FWY2p33n84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6sGxrJzG0de0FOiNZwN2AMArrLOOjoBRs5FVa+VUmUes/cQGcB2ViCTR0IJTm/OL6xeXUUK6CJyDDc2hC8clVUICFC3pu7zvJ+FWfxQRK/0+t+zmd12ZVJIXQrY5qNRRBfpnHKgDBjUg/3/oe8XYjUtrrKMLz8sgua05lf12WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gD6OD3f2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-615d0b11621so4557522a12.1;
        Thu, 07 Aug 2025 19:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754621886; x=1755226686; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=InFnfUjyzfpsp+W5R8piC/DqY1LG1vw1ztQP90OY3GA=;
        b=gD6OD3f2PvocIfHC1PRo0XKzSkiRMA80j38/0yhjfuRtXKNNGCasG6zbpo4J3VEzYp
         HZ21FxjBMd6+JcuAqbHpgu2dbiC2RrBqOvkoxUSg6Q00HSYSLnp88mMQu60d2uEA4mY6
         JJajRei0Yu15twjG9II9Vjyon9vTsZR48WagbYE+cYL/r/XmZqJ76auFyPm7njDajun9
         9CJkdnu6jGTtygAtBAUKdBgswATL4ENL0IqrmkBq2I/C4RnuTeDhdXre2an1IAQjrgFn
         l/UI8hps4BCUC4SgLuXdRCcgutSdfr7W/y6YdlsCiJMWDQr8lFTh7tAQK6KHPsVheVy6
         O88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754621886; x=1755226686;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InFnfUjyzfpsp+W5R8piC/DqY1LG1vw1ztQP90OY3GA=;
        b=SkXvAGpkja96y1/WvIxVnaKCGMw83WCDaRCYq6ixdCjlMoDpnQBSx6mkvfprZVXZ1Z
         ZLUXrxRVBNBbHncTCfP7MGAGcV7y9ZimkZ9EFFmgoGxaGNdEE4v3CqD+P3gHAB+cO5UB
         N1c7rj6/tKeuWujC9MRnkPgQc+RHqFDylfhyjJZbyunXC00W2SisU23iS/M6OyuYyyvW
         RIJQdXR1mhGIkbQp7LhHOUz6XVIyS84Tt7DkXioIIYHd9HcjScxFVSA4/EoOFabyRar7
         7s7nWPKNRanv0Q2dZCfshKlNi+YGh3Qwwmk+sLF3a8MX/njcEkdn2D8t0/ajrSTvW8dh
         y1fg==
X-Forwarded-Encrypted: i=1; AJvYcCVFZnTz7/k5JeBtOXPIpX8i5tVGE+sLprb3tBWGpIksowRVxodr7L4ESlKwQyW3fe5Q1+FZIVaGF5v/Yok=@vger.kernel.org, AJvYcCX41D76vMlM4krmDpHDEW5JJGhIkIQKaNu/WwdvphSlEeIDv98+TrxMlfrof35spLc6lYK9VVRnOZEQcD6LLcLA@vger.kernel.org
X-Gm-Message-State: AOJu0YzBJ3vKKCS1v5L4XMtpxjQTutJGcuRdOUUgeECXpFjnMP4BnBZb
	awcAMPcPUhNVIINO1PsS0PsBMqcRAYNdO16pXVeICbSoWhrfYbTwEDfQ
X-Gm-Gg: ASbGncvL5yWMButPWq83uc6rk6tUr0pXGBVkvBQc+ydXiiPb+n5YCTFKA0gqvLTxqAE
	1zccxYtSEtyIbvXHgNMc35lYdXaIMhx0xgR/FpqFcfANli2fwOL2uI16PSMBioOSBWeeky7k9Kc
	AbljhaJVZZPYxcOauVh0by6oQnezyXZDaxqYjp/6aYr7C4XalXyoDJWjwn32w5GLOaTbwlVStsA
	MP2qOs7bIlogEaGkZtLfG92lhbZpvgn5SO0Q+D1uhrQJt6zJYSJ+YAboLthG0qCI2rtip5hu0mt
	JPDKODMtlHpejj4Ns/EpDJM/suTBg4/2+54QCaIn+GGwx1HNGIZhxVksjFP36uAACG08ABhkErg
	ZDFtBbRSFOA0Bgx7QW0/bSw==
X-Google-Smtp-Source: AGHT+IEvl6ZdfxAsRS1F4iXaUsO8JqUXfeEwT1NP8Lupi7iF8ZO/CuT92uX1OKdhIEIS8t0JwYzAlg==
X-Received: by 2002:a17:907:d0b:b0:af9:3f99:1422 with SMTP id a640c23a62f3a-af9a3c59269mr590769066b.5.1754621886013;
        Thu, 07 Aug 2025 19:58:06 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af9215cdc53sm1365718666b.78.2025.08.07.19.58.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Aug 2025 19:58:05 -0700 (PDT)
Date: Fri, 8 Aug 2025 02:58:04 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	akpm@linux-foundation.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ritesh.list@gmail.com
Subject: Re: [PATCH v3 3/7] selftest/mm: Fix ksm_funtional_test failures
Message-ID: <20250808025804.b7cv47gcq2yscka7@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250729053403.1071807-1-aboorvad@linux.ibm.com>
 <20250729053403.1071807-4-aboorvad@linux.ibm.com>
 <20250804091141.ifwryfmgjepwrog4@master>
 <20fb853c-7d79-4d26-9c8a-f6ce9367d424@linux.ibm.com>
 <20250805170353.6vlbyg6qn5hv4yzz@master>
 <e9079694-1e30-46b6-97e7-b79be01c65a6@linux.ibm.com>
 <20250806145432.nygrslkiyvzulujn@master>
 <111d2351-3fb7-4011-af07-78b40874d956@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <111d2351-3fb7-4011-af07-78b40874d956@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Aug 07, 2025 at 02:56:28PM +0530, Donet Tom wrote:
>
>On 8/6/25 8:24 PM, Wei Yang wrote:
>> On Wed, Aug 06, 2025 at 06:30:37PM +0530, Donet Tom wrote:
>> [...]
>> > > Child process inherit the ksm_merging_pages from parent, which is reasonable
>> > > to me. But I am confused why ksm_unmerge() would just reset ksm_merging_pages
>> > > for parent and leave ksm_merging_pages in child process unchanged.
>> > > 
>> > > ksm_unmerge() writes to /sys/kernel/mm/ksm/run, which is a system wide sysfs
>> > > interface. I expect it applies to both parent and child.
>> > I am not very familiar with the KSM code, but from what I understand:
>> > 
>> > The ksm_merging_pages counter is maintained per mm_struct. When
>> > we write to /sys/kernel/mm/ksm/run, unmerging is triggered, and the
>> > counters are updated for all mm_structs present in the ksm_mm_slot list.
>> > 
>> > A mm_struct gets added to this list  when MADV_MERGEABLE is called.
>> > In the case of the child process, since MADV_MERGEABLE has not been
>> > invoked yet, its mm_struct is not part of the list. As a result,
>> > its ksm_merging_pages counter is not reset.
>> > 
>> Would this flag be inherited during fork? VM_MERGEABLE is saved in related vma
>> I don't see it would be dropped during fork. Maybe missed.
>> 
>> > > > value remained unchanged. That’s why get_my_merging_page() in the child was
>> > > > returning a non-zero value.
>> > > > 
>> > > I guess you mean the get_my_merging_page() in __mmap_and_merge_range() return
>> > > a non-zero value. But there is ksm_unmerge() before it. Why this ksm_unmerge()
>> > > couldn't reset the value, but a ksm_unmerge() in parent could.
>> > > 
>> > > > Initially, I fixed the issue by calling ksm_unmerge() before the fork(), and
>> > > > that
>> > > > resolved the problem. Later, I decided it would be cleaner to move the
>> > > > ksm_unmerge() call to the test cleanup phase.
>> > > > 
>> > > Also all the tests before test_prctl_fork(), except test_prctl(), calls
>> > > 
>> > >     ksft_test_result(!range_maps_duplicates());
>> > > 
>> > > If the previous tests succeed, it means there is no duplicate pages. This
>> > > means ksm_merging_pages should be 0 before test_prctl_fork() if other tests
>> > > pass. And the child process would inherit a 0 ksm_merging_pages. (A quick test
>> > > proves it.)
>> > 
>> > If I understand correctly, all the tests are calling MADV_UNMERGEABLE,
>> > which internally calls break_ksm() in the kernel. This function replaces the
>> > KSM page with an exclusive anonymous page. However, the
>> > ksm_merging_pages counters are not updated at this point.
>> > 
>> > The function range_maps_duplicates(map, size) checks whether the pages
>> > have been unmerged. Since break_ksm() does perform the unmerge, this
>> > function returns false, and the test passes.
>> > 
>> > The ksm_merging_pages update happens later via the ksm_scan_thread().
>> > That’s why we observe that ksm_merging_pages values are not reset
>> > immediately after the test finishes.
>> > 
>> Not familiar with ksm internal. But the ksm_merging_pages counter still has
>> non-zero value when all merged pages are unmerged makes me feel odd.
>> 
>> > If we add a sleep(1) after the MADV_UNMERGEABLE call, we can see that
>> > the ksm_merging_pages values are reset after the sleep.
>> > 
>> > Once the test completes successfully, we can call ksm_unmerge(), which
>> > will immediately reset the ksm_merging_pages value. This way, in the fork
>> > test, the child process will also see the correct value.
>> > > So which part of the story I missed?
>> > > 
>> > So, during the cleanup phase after a successful test, we can call
>> > ksm_unmerge() to reset the counter. Do you see any issue with
>> > this approach?
>> > 
>> It looks there is no issue with an extra ksm_unmerge().
>> 
>> But one more question. Why an extra ksm_unmerge() could help.
>> 
>> Here is what we have during test:
>> 
>> 
>>    test_prot_none()
>>        !range_maps_duplicates()
>>        ksm_unmerge()                  1) <--- newly add
>>    test_prctl_fork()
>>        >--- in child
>>        __mmap_and_merge_range()
>>            ksm_unmerge()              2) <--- already have
>> 
>> As you mentioned above ksm_unmerge() would immediately reset
>> ksm_merging_pages, why ksm_unmerge() at 2) still leave ksm_merging_pages
>> non-zero? And the one at 1) could help.
>
>
>From the debugging, what I understood is:
>
>When we perform fork(), MADV_MERGEABLE, or PR_SET_MEMORY_MERGE, the
>mm_struct of the process gets added to the ksm_mm_slot list. As a
>result, both the parent and child processes’ mm_struct structures
>will be present in ksm_mm_slot.
>
>When KSM merges the pages, it creates a ksm_rmap_item for each page,
>and the ksm_merging_pages counter is incremented accordingly.
>
>Since the parent process did the merge, its mm_struct is present in
>ksm_mm_slot, and ksm_rmap_item entries are created for all the merged
>pages.
>
>When a process is forked, the child’s mm_struct is also added to
>ksm_mm_slot, and it inherits the ksm_merging_pages count. However,
>no ksm_rmap_item entries are created for the child process because it
>did not do any merge.
>
>When ksm_unmerge() is called, it iterates over all processes in
>ksm_mm_slot. In our case, both the parent and child are present. It
>first processes the parent, which has ksm_rmap_item entries, so it
>unmerges the pages and resets the ksm_merging_pages counter.
>
>For the child, since it did not perform any actual merging, it does not
>have any ksm_rmap_item entries. Therefore, there are no pages to unmerge,
>and the counter remains unchanged.
>

Thanks for the detailed analysis.

So the key is child has no ksm_rmap_item which will not clear ksm_merging_page
on ksm_unmerge().

>So, only processes that performed KSM merging will have their counters
>updated during ksm_unmerge(). The child process, having not initiated any
>merging, retains the inherited counter value without any update.
>
>So from a testing point of view, I think it is better to reset the
>counters as part of the cleanup code to ensure that the next tests do
>not get incorrect values.
>

Hmm... I agree from the test point of view based on current situation.

While maybe this is also a check point for later version.

>The question I have is: is it correct to keep the inherited
>|ksm_merging_page|
>value in the child or Should we reset it to 0 during |ksm_fork()|?
>

Very good question. There looks to be something wrong, but I am not sure this
is the correct way.

>> 
>> Or there is still some timing issue like sleep(1) you did?
>> 

-- 
Wei Yang
Help you, Help me

