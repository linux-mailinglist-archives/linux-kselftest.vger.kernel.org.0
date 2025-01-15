Return-Path: <linux-kselftest+bounces-24596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAC4A12B8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 20:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FBE1618AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 19:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176FD1D63EF;
	Wed, 15 Jan 2025 19:12:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DB71D63C7;
	Wed, 15 Jan 2025 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736968322; cv=none; b=u+7alXbfyVvFNpTkhnxnEZFOscsaVQnnTTPd/Wos7PxS1d6XUYSA+TCSFs3P3YlyibXUjYE8+KprW4/qVhUTQwrRQDaxHWrpYtCPwFoZJp293Z9vkT5UYoY5GjWxngusMSICyYzqIZiDspWMscnkW/k41XnHmT9zh/k0QLGUbM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736968322; c=relaxed/simple;
	bh=CIatos4FkQQtIF7lDU7Jla3LXObPXvCeTJPQrW7JJKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8JlqlCAh/uQw9Ehj9OwOwUFwoOtGhk9GE3deuodDiDGThzx+XTIVDym4Jh7UKNlf3DrOb2+aDEd3uxGjZ6iPZf9qfWnrhGnZBshgYg+e4a/gbNnkt+nb7sI9r+UZaM3xyH+u1mTTIfltilBGMOYGpXDek3FZ8KfiF7O2xI1+Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 586BD12FC;
	Wed, 15 Jan 2025 11:12:27 -0800 (PST)
Received: from [10.57.93.175] (unknown [10.57.93.175])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7DD33F73F;
	Wed, 15 Jan 2025 11:11:56 -0800 (PST)
Message-ID: <6ac6f8ed-1595-4f17-b415-3beb819746a1@arm.com>
Date: Wed, 15 Jan 2025 19:11:55 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm: Clear uffd-wp PTE/PMD state on mremap()
Content-Language: en-GB
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Peter Xu <peterx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Shuah Khan
 <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20250107144755.1871363-1-ryan.roberts@arm.com>
 <20250107144755.1871363-2-ryan.roberts@arm.com>
 <26ee9ae0-405f-4085-a864-48d1ee6371f1@arm.com> <Z4fui1wQ97Hlmbqd@x1n>
 <9221000a-161b-46ea-a065-ee339837aacb@lucifer.local>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <9221000a-161b-46ea-a065-ee339837aacb@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/01/2025 17:30, Lorenzo Stoakes wrote:
> On Wed, Jan 15, 2025 at 12:21:15PM -0500, Peter Xu wrote:
>> On Wed, Jan 15, 2025 at 04:58:06PM +0000, Ryan Roberts wrote:
>>> Hi Peter, David,
>>
>> Hey, Ryan,
>>
>>>
>>> On 07/01/2025 14:47, Ryan Roberts wrote:
>>>> When mremap()ing a memory region previously registered with userfaultfd
>>>> as write-protected but without UFFD_FEATURE_EVENT_REMAP, an
>>>> inconsistency in flag clearing leads to a mismatch between the vma flags
>>>> (which have uffd-wp cleared) and the pte/pmd flags (which do not have
>>>> uffd-wp cleared). This mismatch causes a subsequent mprotect(PROT_WRITE)
>>>> to trigger a warning in page_table_check_pte_flags() due to setting the
>>>> pte to writable while uffd-wp is still set.
>>>>
>>>> Fix this by always explicitly clearing the uffd-wp pte/pmd flags on any
>>>> such mremap() so that the values are consistent with the existing
>>>> clearing of VM_UFFD_WP. Be careful to clear the logical flag regardless
>>>> of its physical form; a PTE bit, a swap PTE bit, or a PTE marker. Cover
>>>> PTE, huge PMD and hugetlb paths.
>>>
>>> I just noticed that Andrew sent this to Linus and it's now in his tree; I'm
>>> suddenly very nervous that it doesn't have any acks. I don't suppose you would
>>> be able to do a quick review to calm the nerves??
>>
>> Heh, I fully trusted you, and I appreciated your help too. I'll need to run
>> for 1-2 hours, but I'll read it this afternoon.

Thanks - appreciate it! I was just conscious that in the original thread there
was some disagreement between you and David about whether we should clear the
PTE state or set the VMA state. I think we converged on the former (and that's
what's implemented) but would be good to get an explicit ack.

>>
>> Side note: no review is as good as tests on reliability POV if that was the
>> concern, but I'll try my best.
> 
> Things go all inception though when part of the review _are_ the tests ;)
> Though of course there are also all existing uffd tests and the bots that
> add a bit of weight.
> 
> This isn't really my area so will defer to Peter on the review side.
> 
> I sort of favour putting hotfixes in quick, but this one has gone in
> quicker than some reviewed hotfixes which we left in unstable... however
> towards the end of a cycle I think Andrew is stuck between a rock and a
> hard place in deciding how to handle these.
> 
> So I'm guessing the heuristic is 'allow to simmer in unstable if time
> permits in cycle', if known 'good egg' + no objection + towards end of
> cycle + hotfix - send.
> 
> I do wonder whether we should require review on hotfixes generally. But
> then of course that creates rock + hard place decision for Andrew as to
> whether it gets deferred to the next cycle + stable backports...

I have no issue with the process in general. I agree it's better to go quickly -
that's the best way to find the bugs. I'm really just highlighting that in this
case, I don't feel sufficiently expert with the subject matter and would
appreciate another set of eyes.

Thanks,
Ryan

> 
> Maybe one to discuss at LSF?
> 
>>
>> Thanks,
>>
>> --
>> Peter Xu
>>


