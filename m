Return-Path: <linux-kselftest+bounces-26871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C618DA3A2C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 17:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC421160D90
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 16:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE2C26E15C;
	Tue, 18 Feb 2025 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAlvo340"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1942526B0BA
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896052; cv=none; b=p9hFtPySWfaRjFKV7RWkUxX1VP0LHGkNEy1guubdMQOQCBnRG6rBBtPKNedGBovy/HLJQzSafy50n/tnEesGCgZFP+k3nPh7SFEvjFbFY2cW45hCnw5K5bsFRWgwR8hFQnt01J8iG6LI8QXENVmQLKmDpuUtrDOA4kEFtkoE4to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896052; c=relaxed/simple;
	bh=/jU31DtCytRRTp6zaLprSJtOULAvqUl/Lje4qJMxnMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EN14p4145l/1otUjlbjaJaL3VzwngYJdWntRUiVveH6CEq7RgyOSpO83imObQk9GsGEvaIbTHp0M2kPycOxhCXZexE/XBaE2y9nu6WXwm6IQYwWU7nYy1RnnDPUSqWpwqasHS3G0RMKaG1i131e91Km06c5oOyTySNEO5+euA9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WAlvo340; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739896050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2Le/GjfbQb/Bg50q8zSBIdAfpesXpd+s3lbhLe5ipyo=;
	b=WAlvo340TVGEWfAPrWyE+yGpWP/4QxdJnJ+NfmD7ZIoeLIg2stRYmc3WEjxJ7NwUHjDWeZ
	8I2jwe8OsBE3NmDlQymwngoT6ale8gT3/uG0A53iDfRxt++DxSFfvCqmn6lCXpusmd7Q9t
	kdp9cRj3JmeblgVidEMFKewPxPVrIn4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-LtaoP5QdMteky9NhjHgl1A-1; Tue, 18 Feb 2025 11:27:28 -0500
X-MC-Unique: LtaoP5QdMteky9NhjHgl1A-1
X-Mimecast-MFC-AGG-ID: LtaoP5QdMteky9NhjHgl1A_1739896047
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f32ac838cso2923828f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 08:27:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739896047; x=1740500847;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Le/GjfbQb/Bg50q8zSBIdAfpesXpd+s3lbhLe5ipyo=;
        b=wnNtf7OKBr2yByystVL5jzimb5YA3pimKRg9vRnSn9faxVUPmx/0Chg7RcegOroQPu
         3ARB4c6XNYh+r2VPshKT+N5p8UK6zDyqKp21r1uH1nMTHZGbK+sbgx9HDyvuJQuTS6XQ
         7zjjNFLqsacvXLll3m7bGE91S15yirq9TeBI0/a8sXjHMIXhDVgM0H+tywtxrYvHCIiO
         zxG32ik6DyJDzR++lMgPvR04EevXHxjqtocuH4NZW0qfgE3UNXuEr0M84kEKxURnMWmc
         8/gmAlIbwQXVWOqTknm0MnaROLzxMEeAkgmO3Fs3vH1TlD9PMXC64PqM32GKt2KZPkrN
         MW0A==
X-Forwarded-Encrypted: i=1; AJvYcCXoxW5V8I0cm7VOZyg0xtIqD92d3TK2vbMxvBSjxd9p8ugWRhyd2Ee+jxrHf4zUvZGQid3DyzS9K1bGZFgZFU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzrgd8CNhBFrh1Y+3W7sFHhpMHjZbTMO/1ryqx1PM828HFSNA9
	ogKKxvIplaKnolKOOkUAE9jsgjdSNClPKqSnsVJfeJaTUMH8dL6Cu1B7StlGxbr8Vg6jrahTMEG
	pHf2VLa1UkKZKG1rRIp6LMTf5LJVxzNsRJPNCZtYcgeJHyZSgC+6BbL/S7Gzv7PR9hg==
X-Gm-Gg: ASbGncvJlYSV6NbCGLlDu9KVh/sUTzqlYG1ycOrRS5FKEtfvL9Dxb21Tgpr93ufyxIP
	x7cMsQc0qJbCbI1LHVFzwL94RaGiKyZ89wOXX2vtMedwmW4jd294rTRmeSrp+JvyLQ1PHTAQI8z
	G9k/O5RH1Owy39pqR2NjSNEigOG8XGDBdbMU78pDpB9uY9v+jpko1ZWC9AGFXKEu5RdfdusEAiD
	JbsxDUFJZ5aHo2zYRcr1lRcUTNuNyA9cI00T5HnXeIpwFh1+F5xfZry6LoyoNIqUWPjaCEMaEuK
	QtTqeSY0rxZphjrafKg2fnYlsg+xOeeMzhUfPOTYHh8eP5AXnFqyrGeETgXKx2ll9DjE4ZIS5ik
	bvEK4BJU4xd+oJLZE1YPwrOt9i1zPcZ/D
X-Received: by 2002:a05:6000:1889:b0:38f:37f3:5c9a with SMTP id ffacd0b85a97d-38f587ab020mr79399f8f.31.1739896047016;
        Tue, 18 Feb 2025 08:27:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfHfg1RACW5H3CDpNnngSB9JV7sLGUTWrwnxM4KQU8Cb5+NBdJjm4ujHFhZAj4GR3Voj9uzg==
X-Received: by 2002:a05:6000:1889:b0:38f:37f3:5c9a with SMTP id ffacd0b85a97d-38f587ab020mr79370f8f.31.1739896046595;
        Tue, 18 Feb 2025 08:27:26 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b439dsm15274522f8f.8.2025.02.18.08.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 08:27:26 -0800 (PST)
Message-ID: <de79890e-86b5-4f43-8a25-1e50c3b1daea@redhat.com>
Date: Tue, 18 Feb 2025 17:27:24 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm: allow guard regions in file-backed and read-only
 mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
 Juan Yescas <jyescas@google.com>, Kalesh Singh <kaleshsingh@google.com>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <d885cb259174736c2830a5dfe07f81b214ef3faa.1739469950.git.lorenzo.stoakes@oracle.com>
 <6500a93f-aad1-4b21-a94e-feb493c344a3@redhat.com>
 <4d6d2942-10a1-46e8-93a6-7ce52b6af3ad@lucifer.local>
 <90a00957-02b5-440a-9168-de93c760fea7@redhat.com>
 <d219ab1b-9fb1-45de-aa65-b6071d049dd1@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d219ab1b-9fb1-45de-aa65-b6071d049dd1@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.02.25 17:21, Lorenzo Stoakes wrote:
> On Tue, Feb 18, 2025 at 05:17:20PM +0100, David Hildenbrand wrote:
>> On 18.02.25 17:12, Lorenzo Stoakes wrote:
>>> On Tue, Feb 18, 2025 at 05:01:16PM +0100, David Hildenbrand wrote:
>>>> On 13.02.25 19:17, Lorenzo Stoakes wrote:
>>>>> There is no reason to disallow guard regions in file-backed mappings -
>>>>> readahead and fault-around both function correctly in the presence of PTE
>>>>> markers, equally other operations relating to memory-mapped files function
>>>>> correctly.
>>>>>
>>>>> Additionally, read-only mappings if introducing guard-regions, only
>>>>> restrict the mapping further, which means there is no violation of any
>>>>> access rights by permitting this to be so.
>>>>>
>>>>> Removing this restriction allows for read-only mapped files (such as
>>>>> executable files) correctly which would otherwise not be permitted.
>>>>>
>>>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>>> ---
>>>>>     mm/madvise.c | 8 +-------
>>>>>     1 file changed, 1 insertion(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/mm/madvise.c b/mm/madvise.c
>>>>> index 6ecead476a80..e01e93e179a8 100644
>>>>> --- a/mm/madvise.c
>>>>> +++ b/mm/madvise.c
>>>>> @@ -1051,13 +1051,7 @@ static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
>>>>>     	if (!allow_locked)
>>>>>     		disallowed |= VM_LOCKED;
>>>>> -	if (!vma_is_anonymous(vma))
>>>>> -		return false;
>>>>> -
>>>>> -	if ((vma->vm_flags & (VM_MAYWRITE | disallowed)) != VM_MAYWRITE)
>>>>> -		return false;
>>>>> -
>>>>> -	return true;
>>>>> +	return !(vma->vm_flags & disallowed);
>>>>>     }
>>>>>     static bool is_guard_pte_marker(pte_t ptent)
>>>>
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>
>>> Thanks!
>>>
>>>>
>>>> I assume these markers cannot completely prevent us from allocating
>>>> pages/folios for these underlying file/pageache ranges of these markers in
>>>> case of shmem during page faults, right?
>>>
>>> If the markers are in place, then page faulting will result in a
>>> segfault. If we faulted in a shmem page then installed markers (which would
>>> zap the range), then the page cache will be populated, but obviously
>>> subject to standard reclaim.
>>
>> Well, yes, (a) if there is swap and (b), if the noswap option was not
>> specified for tmpfs.
>>
> 
> Right, yeah if you don't have it set up such that dropping a reference to the
> folio doesn't drop the page altogether.
> 
> I think this matches expectation though in that you'd get the same results from
> an MADV_DONTNEED followed by faulting the page again.

It might make sense to document that: installing a guard behaves just 
like MADV_DONTNEED; in case of a file, that means that the pagecache is 
left untouched.

> 
>> Okay, so installing a guard entry might require punshing a hole to get rid
>> of any already-existing memory. But readahead (below) might mess it up.
> 
> Only if you are so concerned about avoiding the page cache being populated there
> that you want to do this :)
> 
> Readahead I think will not readahead into a holepunched region as the hole
> punching extends to the fs layer _I believe_ I have not checked the code for
> this, but I believe it actually changes the underlying file too right to say
> 'this part of the file is empty'?

Well, we are talking about shmem here ... not your ordinary fs backed by 
an actual file :)

-- 
Cheers,

David / dhildenb


