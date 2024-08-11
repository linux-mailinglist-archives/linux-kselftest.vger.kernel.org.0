Return-Path: <linux-kselftest+bounces-15121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D905794E09B
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2024 11:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F751281705
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2024 09:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E64383AB;
	Sun, 11 Aug 2024 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqtufsPq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA411CAB3
	for <linux-kselftest@vger.kernel.org>; Sun, 11 Aug 2024 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723367314; cv=none; b=DlXS9H2GAuqk8FAfdDBvCMJ3eMUuKikDHLSJ/lBp7lG+lXq2be4g3Yer6wEQmoCeKUy5WBy0moUHS12GXkwXqqmkzwMvTs4ObYDk4NcWZ/JOffz9fRPIrdiUuz2U9Q32ZXo6NTBTWiTdlxbshuIFkJXzI4kfpLhOu3T60NB3Of8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723367314; c=relaxed/simple;
	bh=DIWvYcVZCOrilRm31WxNep4hll+iGFTbXGqY/U3TSmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQCXkBqhbuIdfYdohmi+1bKkIkgm+GrK5A9cDw+NKHfQUJGWj3UuOt2CHXPNA8M+uGx97rvjOCj369qJTNAxqi3YRZ7Mlkis2RSGTNGubnYV9rkaQ5exO1XPgBDG+SNrkP5uZbELaZQtggXuUNj6BcwxkUDvvRtfdLjHRvHpDas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqtufsPq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723367310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/BO4276c7I58BMeDMcO4G1/nD1xrRDfJkSrBVd0aYeE=;
	b=iqtufsPq5A002RZY6iQGBg9JR28LLffN8xvrcbCiHbVoCuy+c24UKSmSDS8yK5KYg20J8Y
	7+p/IetbYGyOWsU4EyBoz1QrHP9gz5fa37NzkzIvKUhQtwmIyX58yy6Pl+dzCmMAobhFdv
	tppsPf7MMkOx3ciBj6+U+t3iGdMdaTI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-lNpHbSfYNUq0Cc9o4i1yGg-1; Sun, 11 Aug 2024 05:08:29 -0400
X-MC-Unique: lNpHbSfYNUq0Cc9o4i1yGg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3687f4f9fecso2345603f8f.1
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Aug 2024 02:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723367308; x=1723972108;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/BO4276c7I58BMeDMcO4G1/nD1xrRDfJkSrBVd0aYeE=;
        b=U5qKMA+w0K3juf3IxaQwMnGbYkW3CaAiiMw9+4cZlqKFhRmAWRKz+QIV0aqPSUnuCW
         J6JdOOK1ebB0u2VLd8ZKxRCcjWzJ3XyEWCqrjZNvr4+bXtUH9VhOLKGW6IxjJsJjiuxS
         HfJyY0oUhKeicz3gAQYZ7aqKuN8Kk4N5JwwRRE3NNe80XCXUxQoCUxOs3gDel5ozoiRS
         Ym8GW31XVI0SJt596vhPq1lmPZVjny6lx6NRjL7lsVb8H3LA1DkoEN0qICfV+dLJLj+6
         OyG6kQsPoEo615ejEIzDXY1F3GC4Tn6woFTU7bWlO6AavYRahCoxeBucMWCsmpvQYpqe
         M/jg==
X-Forwarded-Encrypted: i=1; AJvYcCVJJO3ONIvUEWNyemBufuL59rkR7fNtPBI+5U7yaMC4OdcCa93OcXPgiPaoG6+7nNJ1lI37aWKtb2lAsOL4n49WAPIcgefmMG/eBae04Cvt
X-Gm-Message-State: AOJu0YzSvLWGsjShEMw5cHjKZ4wbDcjcqeWHWUoOcdpcPxb4BNS0cgM+
	3H2CM0snqKUCIomDVfLJDSelG5bv2QnKXJG7OtPuZP97uGcWEIKtzdu9Yj+yIggzxpgqUUMXdob
	fdTcsRgC5TjEvbpXENgrAXL06XzqbLyjKlbt2i9qtl2IjOaJ5JZkDGvByM/sBwrgeAQ==
X-Received: by 2002:adf:f451:0:b0:36c:ee8c:a323 with SMTP id ffacd0b85a97d-36d5fd7e9a3mr5063626f8f.44.1723367308040;
        Sun, 11 Aug 2024 02:08:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZX0gPPxgnWHSBD3WY4CAFgzeaOC+op4r/wizklP6aMT7VVQuXXIW35LfWV8ZYiJyzmb1ADw==
X-Received: by 2002:adf:f451:0:b0:36c:ee8c:a323 with SMTP id ffacd0b85a97d-36d5fd7e9a3mr5063599f8f.44.1723367307492;
        Sun, 11 Aug 2024 02:08:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36bc92sm4365353f8f.15.2024.08.11.02.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 02:08:27 -0700 (PDT)
Message-ID: <04e12698-8f83-4033-91b2-3a402c59c17a@redhat.com>
Date: Sun, 11 Aug 2024 11:08:24 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: Retry migration earlier upon refcount mismatch
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, shuah@kernel.org,
 willy@infradead.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 osalvador@suse.de, baolin.wang@linux.alibaba.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 ioworker0@gmail.com, gshan@redhat.com, mark.rutland@arm.com,
 kirill.shutemov@linux.intel.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, broonie@kernel.org,
 mgorman@techsingularity.net, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, ying.huang@intel.com
References: <20240809103129.365029-1-dev.jain@arm.com>
 <20240809103129.365029-2-dev.jain@arm.com>
 <761ba58e-9d6f-4a14-a513-dcc098c2aa94@redhat.com>
 <5a4ae1d3-d753-4261-97a8-926e44d4217a@arm.com>
 <367b0403-7477-4857-9e7c-5a749c723432@redhat.com>
 <ee1b9177-fb12-4bcb-a644-8d5d3d9f16fa@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ee1b9177-fb12-4bcb-a644-8d5d3d9f16fa@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.08.24 08:06, Dev Jain wrote:
> 
> On 8/11/24 00:22, David Hildenbrand wrote:
>> On 10.08.24 20:42, Dev Jain wrote:
>>>
>>> On 8/9/24 19:17, David Hildenbrand wrote:
>>>> On 09.08.24 12:31, Dev Jain wrote:
>>>>> As already being done in __migrate_folio(), wherein we backoff if the
>>>>> folio refcount is wrong, make this check during the unmapping phase,
>>>>> upon
>>>>> the failure of which, the original state of the PTEs will be restored
>>>>> and
>>>>> the folio lock will be dropped via migrate_folio_undo_src(), any
>>>>> racing
>>>>> thread will make progress and migration will be retried.
>>>>>
>>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>>> ---
>>>>>     mm/migrate.c | 9 +++++++++
>>>>>     1 file changed, 9 insertions(+)
>>>>>
>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>> index e7296c0fb5d5..477acf996951 100644
>>>>> --- a/mm/migrate.c
>>>>> +++ b/mm/migrate.c
>>>>> @@ -1250,6 +1250,15 @@ static int migrate_folio_unmap(new_folio_t
>>>>> get_new_folio,
>>>>>         }
>>>>>           if (!folio_mapped(src)) {
>>>>> +        /*
>>>>> +         * Someone may have changed the refcount and maybe sleeping
>>>>> +         * on the folio lock. In case of refcount mismatch, bail out,
>>>>> +         * let the system make progress and retry.
>>>>> +         */
>>>>> +        struct address_space *mapping = folio_mapping(src);
>>>>> +
>>>>> +        if (folio_ref_count(src) != folio_expected_refs(mapping,
>>>>> src))
>>>>> +            goto out;
>>>>
>>>> This really seems to be the latest point where we can "easily" back
>>>> off and unlock the source folio -- in this function :)
>>>>
>>>> I wonder if we should be smarter in the migrate_pages_batch() loop
>>>> when we start the actual migrations via migrate_folio_move(): if we
>>>> detect that a folio has unexpected references *and* it has waiters
>>>> (PG_waiters), back off then and retry the folio later. If it only has
>>>> unexpected references, just keep retrying: no waiters -> nobody is
>>>> waiting for the lock to make progress.
>>>
>>>
>>> The patch currently retries migration irrespective of the reason of
>>> refcount change.
>>>
>>> If you are suggesting that, break the retrying according to two
>>> conditions:
>>
>> That's not what I am suggesting ...
>>
>>>
>>>
>>>> This really seems to be the latest point where we can "easily" back
>>>> off and unlock the source folio -- in this function :)
>>>> For example, when migrate_folio_move() fails with -EAGAIN, check if
>>>> there are waiters (PG_waiter?) and undo+unlock to try again later.
>>>
>>>
>>> Currently, on -EAGAIN, migrate_folio_move() returns without undoing src
>>> and dst; even if we were to fall
>>
>> ...
>>
>> I am wondering if we should detect here if there are waiters and undo
>> src+dst.
> 
> After undoing src+dst, which restores the PTEs, how are you going to set the
> 
> PTEs to migration again? That is being done through migrate_folio_unmap(),
> 
> and the loops of _unmap() and _move() are different. Or am I missing
> something...

Again, no expert on the code, but it would mean that if we detect that 
there are waiters, we would undo src+dst and add them to ret_folios, 
similar to what we do in "Cleanup remaining folios" at the end of 
migrate_pages_batch()?

So instead of retrying migration of that folio, just give it up 
immediately and retry again later.

Of course, this means that (without further modifications to that 
function), we would leave retrying these folios to the caller, such as 
in migrate_pages_sync(), where we move ret_folios to the tail of 
"folios" and retry migration.

Maybe one would want to optimize that retry logic with such "temporarily 
failed because someone else has to make progress for us to make progress 
and free up a page reference" case. These are different to the typical 
"speculative" references that we try to handle via the existing retry magic.

Please let me know if I am missing something fundamental.

-- 
Cheers,

David / dhildenb


