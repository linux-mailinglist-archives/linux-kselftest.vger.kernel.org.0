Return-Path: <linux-kselftest+bounces-17174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E93E96C806
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 21:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163852824F4
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 19:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4711E6DF9;
	Wed,  4 Sep 2024 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfD/evz6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809141E00A3;
	Wed,  4 Sep 2024 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479798; cv=none; b=fHrapaOAPPpMhdMY/qWPnJyLXdusiRsZxxhCjj44yNBMlbYesjHRKNBgYi9xpEVy5qqPnv/pHbvDfofKuMoLcgYScRGZs+ZKiB5UaMl8aVn7yAbIKJAxctDMeesBIUB89WKYoint7qr3nq3sLhWW/4fGrDm8W5wjxOK9disX0O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479798; c=relaxed/simple;
	bh=CmqK9+vTkOMpYW7nHEUEo+VDtwDBAFd1ta4JGBxPy8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qzRU5CjwGoNe2uuVFFQr7f+4JDMgkBH0+bhYjpWg/Hgj8OeR5zuW2wVKbfwiq+oCUfcf+PFPfoCyHrWQVs5iUBpjeV0eRy/fSHTBPYNgzZe36g+OW3RacmtF3uLKovp3ssKhIV0xxJT63HbftIcSaJCwgSwnIQ2WhdRoNMwUHV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfD/evz6; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d8a744aa9bso3032588a91.3;
        Wed, 04 Sep 2024 12:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725479796; x=1726084596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SXKm5OoeNAj97zv6xdsq0+8Sntxl3zYdIrsZpJIIln4=;
        b=QfD/evz6cIv+IMCC4Fh2CM3RoWoRJZ4Q8vACr7kc2d1EgAZf1+Q8yKHiOGDFG9QHq+
         D8ooun+F4FLokXzWDx/BFSAU7FEenyavYRsbx799GjZWaUVNx4XqsQEeT+jEkYjVZBHj
         TdKpM77JuYwxaZ7KYtERc3D2ttSImv8NV0Rv/ujWSvjp/pWB6BXMCrXzzVAaBdNwqhfO
         2G2Bd1PZ8rJ0EXmGr3lHRvVctsL8KLEN4znCFQm1wIElq+cy6DDRo2rk9kBZvRN6QLE5
         gesQOpxcQwAhH77VKd+RVCabRCI+F8M+Rv2w9YDqgwljQqdzjad9ztX2u+pjZeJpuSJl
         kNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725479796; x=1726084596;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXKm5OoeNAj97zv6xdsq0+8Sntxl3zYdIrsZpJIIln4=;
        b=L4uSedQWiBXHyoFN4BdRazt6XjjCXODJQC78fh7TAyrRSSMfga3HxcANRNkzaSJ9EQ
         5GNcVVsgqiwsEiuA9bNnKb+p5AKAKrsVPk+hwycV85k5ZQ/28BqqqVwGQVXrMHUxgn8W
         +KYBBobcvRsvss2cptrL/plIyI7p52+wCttkp8JREe6NE+bUxTN8sb6vO/QuZC8kJRlW
         Wub7NskgHuU4QNv5trPIfp1BpsSYcJPEBc4Zv/tPxAy6RHjnceCb5SwiavpemLZiBJTs
         UVrJ81iN6NHjVWQldbRg5JvmkQGA5dHu8JkFeP2wU5Vn9buP2BMVU0B3lB7/UTQegSbe
         xDvw==
X-Forwarded-Encrypted: i=1; AJvYcCVr1bx5x89OL5PEpmXFQVQISbEO0C2IwijmyrLee+AILHYgQpSKygFzgSMV2ZrbGDMJl+bPYHpRkkRLLxpys9II@vger.kernel.org, AJvYcCWKgYT0OB6zM06qYLn+oAvv33Ap4P1oD3om1btUmMJzgdRF+IrPdvjd5zsNC0sAJB17ktZzkuqOsnLfKqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAyCh4lrHBGFUtU26pv69lMVKT6/lwsG9hYBpsMeQnr+4CE+lT
	W/+eyiuzSukApVh4jGMmf7HC+w6Dne3wlG0E5oTaOWVjgwuC2310
X-Google-Smtp-Source: AGHT+IGINGeaim4TRvhIQEM6ykwPKxm1evYG+kcEU10qSCo5XXM0SNJkXOvufjI9dUiZdkGv7hyW3A==
X-Received: by 2002:a17:90a:1109:b0:2cf:eaec:d74c with SMTP id 98e67ed59e1d1-2d89728e55amr13615483a91.16.1725479795574;
        Wed, 04 Sep 2024 12:56:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2da788d1db1sm3145888a91.44.2024.09.04.12.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 12:56:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <274f253a-e44e-431b-9dd3-a499843be96f@roeck-us.net>
Date: Wed, 4 Sep 2024 12:56:33 -0700
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
 <e83dedb2-89a3-4327-9a2f-610d3199f0e1@roeck-us.net>
 <54zu64vxrhdxr4wtmwbewga44shu4f7lz4ffx2hxhag46b56hn@qgrgfrb6mhbv>
 <b83651a0-5b24-4206-b860-cb54ffdf209b@roeck-us.net>
 <gaouhgel2kmzkm7pofpkjkt5ya3a44rwsal74zsgzh76xzh4qo@ne6sqvzj5qor>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <gaouhgel2kmzkm7pofpkjkt5ya3a44rwsal74zsgzh76xzh4qo@ne6sqvzj5qor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 12:26, Liam R. Howlett wrote:
> * Guenter Roeck <linux@roeck-us.net> [240904 00:27]:
>> On 9/3/24 20:36, Liam R. Howlett wrote:
>>> * Guenter Roeck <linux@roeck-us.net> [240903 22:38]:
>>>> On 9/3/24 19:31, Liam R. Howlett wrote:
>>>>> * SeongJae Park <sj@kernel.org> [240903 21:18]:
>>>>>> On Tue,  3 Sep 2024 17:58:15 -0700 SeongJae Park <sj@kernel.org> wrote:
>>>>>>
>>>>>>> On Tue, 3 Sep 2024 20:48:53 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
>>>>>>>
>>>>>>>> * SeongJae Park <sj@kernel.org> [240903 20:45]:
>>>>>>>>> damon_test_three_regions_in_vmas() initializes a maple tree with
>>>>>>>>> MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
>>>>>>>>> mt_lock of the maple tree will not be used.  And therefore the maple
>>>>>>>>> tree initialization code skips initialization of the mt_lock.  However,
>>>>>>>>> __link_vmas(), which adds vmas for test to the maple tree, uses the
>>>>>>>>> mt_lock.  In other words, the uninitialized spinlock is used.  The
>>>>>>>>> problem becomes celar when spinlock debugging is turned on, since it
>>>>>>>>> reports spinlock bad magic bug.  Fix the issue by not using the mt_lock
>>>>>>>>> as promised.
>>>>>>>>
>>>>>>>> You can't do this, lockdep will tell you this is wrong.
>>>>>>>
>>>>>>> Hmm, but lockdep was silence on my setup?
>>>>>>>
>>>>>>>> We need a lock and to use the lock for writes.
>>>>>>>
>>>>>>> This code is executed by a single-thread test code.  Do we still need the lock?
>>>>>>>
>>>>>>>>
>>>>>>>> I'd suggest using different flags so the spinlock is used.
>>>>>>>
>>>>>>> The reporter mentioned simply dropping MT_FLAGS_LOCK_EXTERN from the flags
>>>>>>> causes suspicious RCU usage message.  May I ask if you have a suggestion of
>>>>>>> better flags?
>>>>>
>>>>> That would be the lockdep complaining, so that's good.
>>>>>
>>>>>>
>>>>>> I was actually thinking replacing the mt_init_flags() with mt_init(), which
>>>>>> same to mt_init_flags() with zero flag, like below.
>>>>>
>>>>> Yes.  This will use the spinlock which should fix your issue, but it
>>>>> will use a different style of maple tree.
>>>>>
>>>>> Perhaps use MT_FLAGS_ALLOC_RANGE to use the same type of maple tree, if
>>>>> you ever add threading you will want the rcu flag as well
>>>>> (MT_FLAGS_USE_RCU).
>>>>>
>>>>> I would recommend those two and just use the spinlock.
>>>>>
>>>>
>>>> I tried that (MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU). it also triggers
>>>> the suspicious RCU usage message.
>>>>
>>>
>>> I am running ./tools/testing/kunit/kunit.py run '*damon*' --arch x86_64 --raw
>>> with:
>>> CONFIG_LOCKDEP=y
>>> CONFIG_DEBUG_SPINLOCK=y
>>>
>>> and I don't have any issue with locking in the existing code.  How do I
>>> recreate this issue?
>>>
>>
>> I tested again, and I still see
>>
>>
>> [    6.233483] ok 4 damon
>> [    6.234190]     KTAP version 1
>> [    6.234263]     # Subtest: damon-operations
>> [    6.234335]     # module: vaddr
>> [    6.234384]     1..6
>> [    6.235726]
>> [    6.235931] =============================
>> [    6.236018] WARNING: suspicious RCU usage
>> [    6.236280] 6.11.0-rc6-00029-gda66250b210f-dirty #1 Tainted: G                 N
>> [    6.236398] -----------------------------
>> [    6.236474] lib/maple_tree.c:832 suspicious rcu_dereference_check() usage!
>> [    6.236579]
>> [    6.236579] other info that might help us debug this:
>> [    6.236579]
>> [    6.236738]
>> [    6.236738] rcu_scheduler_active = 2, debug_locks = 1
>> [    6.237039] no locks held by kunit_try_catch/208.
>> [    6.237166]
>> [    6.237166] stack backtrace:
>> [    6.237385] CPU: 0 UID: 0 PID: 208 Comm: kunit_try_catch Tainted: G                 N 6.11.0-rc6-00029-gda66250b210f-dirty #1
>> [    6.237629] Tainted: [N]=TEST
>> [    6.237714] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>> [    6.238065] Call Trace:
>> [    6.238233]  <TASK>
>> [    6.238547]  dump_stack_lvl+0x9e/0xe0
>> [    6.239473]  lockdep_rcu_suspicious+0x145/0x1b0
>> [    6.239621]  mas_walk+0x19f/0x1d0
>> [    6.239765]  mas_find+0xb5/0x150
>> [    6.239873]  __damon_va_three_regions+0x7e/0x130
> 
> This function isn't taking the rcu read lock while iterating the tree.
> 
> Try this:
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index b0e8b361891d..08cfd22b5249 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -126,6 +126,7 @@ static int __damon_va_three_regions(struct mm_struct *mm,
>           * If this is too slow, it can be optimised to examine the maple
>           * tree gaps.
>           */
> +       rcu_read_lock();
>          for_each_vma(vmi, vma) {
>                  unsigned long gap;
>   
> @@ -146,6 +147,7 @@ static int __damon_va_three_regions(struct mm_struct *mm,
>   next:
>                  prev = vma;
>          }
> +       rcu_read_unlock();
>   
>          if (!sz_range(&second_gap) || !sz_range(&first_gap))
>                  return -EINVAL;
> 


Yes, that fixes the problem for me.

Thanks,
Guenter


