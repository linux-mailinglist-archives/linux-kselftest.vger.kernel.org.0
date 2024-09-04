Return-Path: <linux-kselftest+bounces-17094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D553796AEB3
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 04:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A9CAB23E31
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 02:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6633B78D;
	Wed,  4 Sep 2024 02:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VO61wFm+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1369015E88;
	Wed,  4 Sep 2024 02:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725417523; cv=none; b=HHJV3kFSmQOdMZPZ8c1nXfULaDD5xqu4ZGCy4bkn99m8WwYD0jt34ziMRrtfJxq8VAOocW9EkJO7JtYnCKE6y7JiNbBDqAEyhGB+nGj9oLu9GzmXwpmzoDlInXq5MCr15RKZ7FTweaZFD73iJ271VlQa2UFMrg9JPqo3rkt+gW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725417523; c=relaxed/simple;
	bh=zl3BkmW6YC2mPyY17Hf+PRNNJtx+IJhy4rqXZQ1Bnx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P0ZcbRwr3/5NgpRI4q3YJ3wtfbbZBEJwSKgaQVWaKg1yW6el0XAMCkA39zQkccaKB4xLFErFRXdonf1i+W8d/eRXHJ8aN7wgiSREtsJSIB5C9CVEyrFJtQKTjDfG0Q/IHdSZf8h+bGbVWVUNv+fXXvIxX5eAX2Ai2C73PLK+a+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VO61wFm+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2053a0bd0a6so38495825ad.3;
        Tue, 03 Sep 2024 19:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725417521; x=1726022321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=D4I03fyGlmk3cixUupUWC3QC5sKjSEve+03JZ21Gev8=;
        b=VO61wFm+P1oV8MWkLd4iVVbihsgYFQ2dVNWruRi634ZkcGpo4A8O5ISDoqTcoxTrzp
         uAeOf+mBEclCEg+L3cwlpsYkDO44hH73esNFfw9l78F79z5Y/xPh5VvDUqOYBjzFH/++
         rwXBF+Bsyo/D4MJlXMoBpCZh7Sg1ICrQUXbd+qXkAMaWvV9YABOk6qgRn6dtq99E7g8v
         5wpwtV+Hg2aXdexnU7m4eFrelZFL0yMBeGs+Dwedb7tDEzeyntysnaM8pXk9NP4NkdKr
         hD4vwjrIwt6+jb+uIiTn1WEodouNC7FQFDbDyBgr9Ao+QS2Rgtp0c8S/pqLswt1paxEN
         sCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725417521; x=1726022321;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4I03fyGlmk3cixUupUWC3QC5sKjSEve+03JZ21Gev8=;
        b=M3A5NVpnTZVfetvFw+iuFCkj7JbQJiom624bEpmUFw6jQ1hwFWhsHikfvAqFOD4PmH
         Hj3UGKqo7lt4Ve5NKKUrL2BtDKR2aDPEqcOL25OO1OgS3Y6LdPR1Bro4YPjQlxAC9GZ9
         8RO0QNVNjrxdaoUvWk7pAoz0HL4w0lgq97MCqPUD3fnRtVQchGAyuTBYU5CZRUhiBuaK
         APzr4QNuF7Wao0vZU3Txr/tVM6JDM27wdAG410ScHeTuV4PWLO8smWlveHsYlBztrATG
         8OmlrMj/U/n/LO6F7Dts503xfNyVy7D7qXG79XbS1pKhABA0QiYmdLvDpYJ+2/glbwsh
         RQzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPpOZg2UqpbF4j+0dbn7dTq4ENVRWHtmuEeuZFBi2qoQ/L8T54Y5bFxr7Fh2Kxjg8B5T/WHBUHut6h228OMjrr@vger.kernel.org, AJvYcCXBx2z8/4Kb+gNhWObRqYa42cIiyci5aN6tbK0Js6n+GaG35xxtfveWzSIcmtZfUFwS0TBfqwaNNhjtYws=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv8jCN3EsSoc3iEqn0zV9M4srmHkuI+sIoOHvWrA2PXrIy7jBp
	wNiLVfR0ciJpCZMMiiobaO8ag4v10rXrHk6DKMz9+/QktJlu0uDF
X-Google-Smtp-Source: AGHT+IFcxJ/+caNbvE+AiqI160i9TbenZ81pFsIx6nLjz0m4i4izuh4djjVF5b3At8hNzu//OUjimg==
X-Received: by 2002:a17:903:41cd:b0:202:330f:1512 with SMTP id d9443c01a7336-20699b21b08mr47674905ad.44.1725417521207;
        Tue, 03 Sep 2024 19:38:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea52a21sm4365605ad.196.2024.09.03.19.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 19:38:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e83dedb2-89a3-4327-9a2f-610d3199f0e1@roeck-us.net>
Date: Tue, 3 Sep 2024 19:38:39 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon/tests/vaddr-kunit: don't use mas_lock for
 MM_MT_FLAGS-initialized maple tree
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, SeongJae Park
 <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 Brendan Higgins <brendanhiggins@google.com>, David Gow
 <davidgow@google.com>, damon@lists.linux.dev, linux-mm@kvack.org,
 kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240904005815.1388-1-sj@kernel.org>
 <20240904011840.973-1-sj@kernel.org>
 <whdjeq6qpccj6ms4wgiyjcnizht4nl5qbt7rbaeqfwzt67smxt@vvduwpqcuizl>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <whdjeq6qpccj6ms4wgiyjcnizht4nl5qbt7rbaeqfwzt67smxt@vvduwpqcuizl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 19:31, Liam R. Howlett wrote:
> * SeongJae Park <sj@kernel.org> [240903 21:18]:
>> On Tue,  3 Sep 2024 17:58:15 -0700 SeongJae Park <sj@kernel.org> wrote:
>>
>>> On Tue, 3 Sep 2024 20:48:53 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
>>>
>>>> * SeongJae Park <sj@kernel.org> [240903 20:45]:
>>>>> damon_test_three_regions_in_vmas() initializes a maple tree with
>>>>> MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
>>>>> mt_lock of the maple tree will not be used.  And therefore the maple
>>>>> tree initialization code skips initialization of the mt_lock.  However,
>>>>> __link_vmas(), which adds vmas for test to the maple tree, uses the
>>>>> mt_lock.  In other words, the uninitialized spinlock is used.  The
>>>>> problem becomes celar when spinlock debugging is turned on, since it
>>>>> reports spinlock bad magic bug.  Fix the issue by not using the mt_lock
>>>>> as promised.
>>>>
>>>> You can't do this, lockdep will tell you this is wrong.
>>>
>>> Hmm, but lockdep was silence on my setup?
>>>
>>>> We need a lock and to use the lock for writes.
>>>
>>> This code is executed by a single-thread test code.  Do we still need the lock?
>>>
>>>>
>>>> I'd suggest using different flags so the spinlock is used.
>>>
>>> The reporter mentioned simply dropping MT_FLAGS_LOCK_EXTERN from the flags
>>> causes suspicious RCU usage message.  May I ask if you have a suggestion of
>>> better flags?
> 
> That would be the lockdep complaining, so that's good.
> 
>>
>> I was actually thinking replacing the mt_init_flags() with mt_init(), which
>> same to mt_init_flags() with zero flag, like below.
> 
> Yes.  This will use the spinlock which should fix your issue, but it
> will use a different style of maple tree.
> 
> Perhaps use MT_FLAGS_ALLOC_RANGE to use the same type of maple tree, if
> you ever add threading you will want the rcu flag as well
> (MT_FLAGS_USE_RCU).
> 
> I would recommend those two and just use the spinlock.
> 

I tried that (MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU). it also triggers
the suspicious RCU usage message.

Guenter

>>
>> ```
>> --- a/mm/damon/tests/vaddr-kunit.h
>> +++ b/mm/damon/tests/vaddr-kunit.h
>> @@ -77,7 +77,7 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
>>                  (struct vm_area_struct) {.vm_start = 307, .vm_end = 330},
>>          };
>>
>> -       mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
>> +       mt_init(&mm.mm_mt);
>>          if (__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)))
>>                  kunit_skip(test, "Failed to create VMA tree");
>> ```
>>
>> And just confirmed it also convinces the reproducer.  But because I'm obviously
>> not familiar with maple tree, would like to hear some comments from Liam or
>> others first.
>>
>> FYI, I ended up writing v1 to simply remove lock usage based on my humble
>> understanding of the documetnation.
>>
>>      The maple tree uses a spinlock by default, but external locks can be used for
>>      tree updates as well.  To use an external lock, the tree must be initialized
>>      with the ``MT_FLAGS_LOCK_EXTERN flag``, this is usually done with the
>>      MTREE_INIT_EXT() #define, which takes an external lock as an argument.
>>
>> (from Documentation/core-api/maple_tree.rst)
>>
>> I was thinking the fact that the test code is executed in single thread is same
>> to use of external lock.  I will be happy to learn if I missed something.
>>
>>
>> Thanks,
>> SJ
>>
>>>
>>>
>>> Thanks,
>>> SJ
>>>
>>>>
>>>>>
>>>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>>>> Closes: https://lore.kernel.org/1453b2b2-6119-4082-ad9e-f3c5239bf87e@roeck-us.net
>>>>> Fixes: d0cf3dd47f0d ("damon: convert __damon_va_three_regions to use the VMA iterator")
>>>>> Signed-off-by: SeongJae Park <sj@kernel.org>
>>>>> ---
>>>>>   mm/damon/tests/vaddr-kunit.h | 10 +++-------
>>>>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
>>>>> index 83626483f82b..c6c7e0e0ab07 100644
>>>>> --- a/mm/damon/tests/vaddr-kunit.h
>>>>> +++ b/mm/damon/tests/vaddr-kunit.h
>>>>> @@ -17,23 +17,19 @@
>>>>>   static int __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
>>>>>   			ssize_t nr_vmas)
>>>>>   {
>>>>> -	int i, ret = -ENOMEM;
>>>>> +	int i;
>>>>>   	MA_STATE(mas, mt, 0, 0);
>>>>>   
>>>>>   	if (!nr_vmas)
>>>>>   		return 0;
>>>>>   
>>>>> -	mas_lock(&mas);
>>>>>   	for (i = 0; i < nr_vmas; i++) {
>>>>>   		mas_set_range(&mas, vmas[i].vm_start, vmas[i].vm_end - 1);
>>>>>   		if (mas_store_gfp(&mas, &vmas[i], GFP_KERNEL))
>>>>> -			goto failed;
>>>>> +			return -ENOMEM;
>>>>>   	}
>>>>>   
>>>>> -	ret = 0;
>>>>> -failed:
>>>>> -	mas_unlock(&mas);
>>>>> -	return ret;
>>>>> +	return 0;
>>>>>   }
>>>>>   
>>>>>   /*
>>>>> -- 
>>>>> 2.39.2
>>>>>


