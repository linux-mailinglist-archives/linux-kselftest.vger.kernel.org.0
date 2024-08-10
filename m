Return-Path: <linux-kselftest+bounces-15117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1259894DE2C
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 20:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99251283366
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 18:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BBF13BC0B;
	Sat, 10 Aug 2024 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqNNiJZm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA55812F
	for <linux-kselftest@vger.kernel.org>; Sat, 10 Aug 2024 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723315976; cv=none; b=YTW1rMS2P8OXqEgT4ol1gJ0Xby+Fyz6aNZ7nINKZyYmb7dXYsTqJtKubexIVF7udqStFkA/tym3trdsZoWKzohi9sL2wiUPsXoopSGOnlkwOqlv3sIlstNMrfxwL/xiHJdmyqb54LZIUW3uMKWCjnYX4KLvjJrlMCxpqe8Cjplg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723315976; c=relaxed/simple;
	bh=HuvOjzj4M0v/4VIs+YjWRqwxLTRmD74OI6BSf9wpuT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQF+gLL+263d/+M48tXXLGB2yBjVGGOIShGwL9lOrwLsZl+Z/EIWVw8r88i1S5oqFuSwz/WmsJ0qmPRfgL30QFMGXh7O7Anm/w9DFm3IMuZ+AFmzd1ufXFRLGdeXQKN9HnyM0QosUdn3mjuv0qMBY5OxFLY9MyL4YkXDwcLRde0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqNNiJZm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723315973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GiY4Ptbx93Q4ZMaxX4AuvjWNIDTQVcJ7tTpeIk/YoQc=;
	b=iqNNiJZmaTPCjILqqiqBDfICgZradztSGG/FMH6CvWrnVFKvxo53W/EaUECstVQG6gJYIP
	bOObeMD89rgkjuTeBJTkVitBiLJVvtTkbzwuFL3VlUt9NlvdsB2j8im6yIHj7F0dVmU18S
	5lqWa+ePSkoRAKGaP3UY2rdQmnbo5jg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-t4kFKZelNbCLs2rH9HygdA-1; Sat, 10 Aug 2024 14:52:49 -0400
X-MC-Unique: t4kFKZelNbCLs2rH9HygdA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428ea5b1479so21706345e9.0
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Aug 2024 11:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723315968; x=1723920768;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GiY4Ptbx93Q4ZMaxX4AuvjWNIDTQVcJ7tTpeIk/YoQc=;
        b=AVbHtIZccPjvSbwwhozqz4vd5WDu7QLN0JXtUrRNo0jTe5F9AwHfKmew8Qjx7yDSaA
         LNysUP9w75M8OsjWJEaDh1zEtcfoLkRLsf24Wf5oChZyrP6A7cyBoOMrJlTYdBrN8lNQ
         F52wj5OgxMreDXnlgEXa4qYfIvsdJ6UBu79iqpfJxq1i4aHOGCcCH05P2wXk1Teyhqcg
         zwXjIWA/Mwhd/SQa5nlbaYKS+VQ84A/k3rlT6gxv+eZC3q7YHArRtrVHRWqXcaWd5Lp2
         Ix2tK6WLT8o8XrsYYR3ItpNi6KHA70Q/qewTk/14lecXtGttxUftU9iZMkxlg0GuVGLr
         ulag==
X-Forwarded-Encrypted: i=1; AJvYcCVO2yQgFVhv/kDq8LUEHztoyx+0Dm6EuSTOt5PthlAknssFeTLX67GW1yLTCO/RqfyXyrO6qckgylVe4FIsCxuvvoKOhTOUxRobM7VHB4hJ
X-Gm-Message-State: AOJu0Yx4m6C709S2sYyj1Rw+lo7vj4MM1WoUc6W39onLJDpIIwoZKdd9
	6A2cE9YS8/CvuY2LiZnqqzl2cKFWNPWpQ19yIpM4pEqx71jenIvKGKX/V+lNdNLBWsZcHXFXXZD
	o3MJ/rk0fa7YIVxmaglI8PuAnAAwjwzXpwuAWnPo1vPqjgVdA23Ng4vzytbkK4x923g==
X-Received: by 2002:a05:600c:198a:b0:426:6e95:78d6 with SMTP id 5b1f17b1804b1-429c3a19090mr34632215e9.4.1723315968585;
        Sat, 10 Aug 2024 11:52:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaf6qLn2siA5GFoQ2VSPHv8IsNhJK3LW/FvEvssbsyLHKpa6yYw2DZ7pGIVpXmy3MKfn9LrQ==
X-Received: by 2002:a05:600c:198a:b0:426:6e95:78d6 with SMTP id 5b1f17b1804b1-429c3a19090mr34632085e9.4.1723315968027;
        Sat, 10 Aug 2024 11:52:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c751b021sm40350645e9.21.2024.08.10.11.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Aug 2024 11:52:47 -0700 (PDT)
Message-ID: <367b0403-7477-4857-9e7c-5a749c723432@redhat.com>
Date: Sat, 10 Aug 2024 20:52:44 +0200
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
 linux-kselftest@vger.kernel.org
References: <20240809103129.365029-1-dev.jain@arm.com>
 <20240809103129.365029-2-dev.jain@arm.com>
 <761ba58e-9d6f-4a14-a513-dcc098c2aa94@redhat.com>
 <5a4ae1d3-d753-4261-97a8-926e44d4217a@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5a4ae1d3-d753-4261-97a8-926e44d4217a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.08.24 20:42, Dev Jain wrote:
> 
> On 8/9/24 19:17, David Hildenbrand wrote:
>> On 09.08.24 12:31, Dev Jain wrote:
>>> As already being done in __migrate_folio(), wherein we backoff if the
>>> folio refcount is wrong, make this check during the unmapping phase,
>>> upon
>>> the failure of which, the original state of the PTEs will be restored
>>> and
>>> the folio lock will be dropped via migrate_folio_undo_src(), any racing
>>> thread will make progress and migration will be retried.
>>>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>>    mm/migrate.c | 9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index e7296c0fb5d5..477acf996951 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1250,6 +1250,15 @@ static int migrate_folio_unmap(new_folio_t
>>> get_new_folio,
>>>        }
>>>          if (!folio_mapped(src)) {
>>> +        /*
>>> +         * Someone may have changed the refcount and maybe sleeping
>>> +         * on the folio lock. In case of refcount mismatch, bail out,
>>> +         * let the system make progress and retry.
>>> +         */
>>> +        struct address_space *mapping = folio_mapping(src);
>>> +
>>> +        if (folio_ref_count(src) != folio_expected_refs(mapping, src))
>>> +            goto out;
>>
>> This really seems to be the latest point where we can "easily" back
>> off and unlock the source folio -- in this function :)
>>
>> I wonder if we should be smarter in the migrate_pages_batch() loop
>> when we start the actual migrations via migrate_folio_move(): if we
>> detect that a folio has unexpected references *and* it has waiters
>> (PG_waiters), back off then and retry the folio later. If it only has
>> unexpected references, just keep retrying: no waiters -> nobody is
>> waiting for the lock to make progress.
> 
> 
> The patch currently retries migration irrespective of the reason of
> refcount change.
> 
> If you are suggesting that, break the retrying according to two conditions:

That's not what I am suggesting ...

> 
> 
>> This really seems to be the latest point where we can "easily" back
>> off and unlock the source folio -- in this function :)
>> For example, when migrate_folio_move() fails with -EAGAIN, check if
>> there are waiters (PG_waiter?) and undo+unlock to try again later.
> 
> 
> Currently, on -EAGAIN, migrate_folio_move() returns without undoing src
> and dst; even if we were to fall

...

I am wondering if we should detect here if there are waiters and undo 
src+dst.

Does that make sense?

-- 
Cheers,

David / dhildenb


