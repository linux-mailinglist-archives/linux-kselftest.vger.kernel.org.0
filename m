Return-Path: <linux-kselftest+bounces-17099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E147696AFC7
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 06:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3761C22FB3
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 04:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372B38121B;
	Wed,  4 Sep 2024 04:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+5TCSv7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A1B8063C;
	Wed,  4 Sep 2024 04:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725424048; cv=none; b=q1IfFlEnDIDyJahtuGYjdiFZ/iifgBRNyFNveEuN5WDMME/h3GlC0o4QAzqdpSvJAIHCOOAw21LR1i+JAnSnRcxFJZuTM+mTpqVWb0m0UULnwYgZdXvFKdoE78Lb0fm7q27Fzbo1ViSPP7yQrMWsBmKHkf+s//lB7ant382tGMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725424048; c=relaxed/simple;
	bh=qR9oGFQRB424fWSF9MV9wyUOeQr2omNeiSnzmDW3Cyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fq/o6P2YS4KNqqSKjQwd1x/2ZJB3acnuFazyxWDPbYkKtCRKAb3wnZN47rYDT4GaOFvM6RfuL83ByOfHshnZkhR2AZSL69NgPysr7HNTCEj5zJF6AaIZdZFWh8wFmlvsog9yJGA9JhmaXZ0Si18fbfZt7Ni0ROCqU52KOJ+Wdp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+5TCSv7; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d889207d1aso3038955a91.3;
        Tue, 03 Sep 2024 21:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725424046; x=1726028846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VeECqBgljIaFzBqVZOaZS1qp1kp+xe6RJCJ5Xa6Fxk4=;
        b=c+5TCSv7hsR3fcd9iMZCkUGLF6QvJR+L/6DN5cfM7dYp4ng7CkuYL3qkA2/XZwWzay
         GcVqZaZY0JSmF9Sg00hS9KXrm+SjPjM7braMdx0VI2k0FeB7sN/8pyXBFiKS3gZ9kYZg
         xj5Swun7rwlzbuQYktg6fl4RP+LMuJDmKL8Q3gH19YWkK4sTEvDm7wAIGaalSwBqjtmS
         9b5kpz9sLc2pq9ar6Vh5ucr0ojwEffBszYIbUIvdu4Xy0AFdTxHEMMIcas5aFtCQRQh5
         HwTk2PW+1hPd1r0htueqr89CuxVudv7ciTMUIe35vL0lDwsVE2ww4Vwdvr6eQSNhQuRM
         RTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725424046; x=1726028846;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeECqBgljIaFzBqVZOaZS1qp1kp+xe6RJCJ5Xa6Fxk4=;
        b=IjnDE/W1gjhM7Ym0M5PxiFLz65dl4Zk2twqnDdKuCUwpbYYNH3f3pY4Yi3boliZuWn
         RxhMe87i1PxzMOtC2UM5rK54NZO+H/HYYQmWrVKFd6TkCuXeLYNKvR8e/MSI9ZSy5eMU
         NonG/XhKcaKxgyZbSe2A7IOi16/+0IGajG3Ukrsru3Voz3mKjHvFt72U87oHCc+ETLhY
         u60HpzFOzHVMrgnVjCA+guAKaWSa4WsSzMR+a9GUFpN0//ut2jFWvwjn9lDfSsAyE/C7
         1dZGg5B3KbaO/UH1ZwPHI69tS0DFOPRZFWPuU/0s8jQ1BFqpESRNe8cZqIHmQFDaxGwI
         qFTw==
X-Forwarded-Encrypted: i=1; AJvYcCUD9TgsUOrdkeQQQE0PIZjn+ktBXe5UIMoN+THxU80WKGuTzoqM5YgE5NI9CWEzezE4OzeFgLTvILiG0X5Jfeeg@vger.kernel.org, AJvYcCVA5Ir3cSlYsMZolXHsUc9bgMCA6OHTgLsAmkzY9hlF2yYtGy5BGXOWpU+PqPBP2F1PVI7eLQTF+N9LPTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVKuCKjkhTdcosBLKWAYEYiHOhKJzKf/CS6zSyNcqAuHpzVnaf
	wGd/JxrINyESRa4LX7Fvwe6E5rustAWJkQKWW1fmarWairI67dFA
X-Google-Smtp-Source: AGHT+IG2jdQF312Ixt7guXL5uHCtJ9KmhjBnwxSu1MjlGaBSMDPTepH+DUYUSGG6QaluU2eJQGEjnA==
X-Received: by 2002:a17:903:32c8:b0:205:79b4:c5b1 with SMTP id d9443c01a7336-20579b4c7e1mr87665825ad.16.1725424045436;
        Tue, 03 Sep 2024 21:27:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae912facsm5545075ad.45.2024.09.03.21.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 21:27:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b83651a0-5b24-4206-b860-cb54ffdf209b@roeck-us.net>
Date: Tue, 3 Sep 2024 21:27:22 -0700
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
In-Reply-To: <54zu64vxrhdxr4wtmwbewga44shu4f7lz4ffx2hxhag46b56hn@qgrgfrb6mhbv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 20:36, Liam R. Howlett wrote:
> * Guenter Roeck <linux@roeck-us.net> [240903 22:38]:
>> On 9/3/24 19:31, Liam R. Howlett wrote:
>>> * SeongJae Park <sj@kernel.org> [240903 21:18]:
>>>> On Tue,  3 Sep 2024 17:58:15 -0700 SeongJae Park <sj@kernel.org> wrote:
>>>>
>>>>> On Tue, 3 Sep 2024 20:48:53 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
>>>>>
>>>>>> * SeongJae Park <sj@kernel.org> [240903 20:45]:
>>>>>>> damon_test_three_regions_in_vmas() initializes a maple tree with
>>>>>>> MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
>>>>>>> mt_lock of the maple tree will not be used.  And therefore the maple
>>>>>>> tree initialization code skips initialization of the mt_lock.  However,
>>>>>>> __link_vmas(), which adds vmas for test to the maple tree, uses the
>>>>>>> mt_lock.  In other words, the uninitialized spinlock is used.  The
>>>>>>> problem becomes celar when spinlock debugging is turned on, since it
>>>>>>> reports spinlock bad magic bug.  Fix the issue by not using the mt_lock
>>>>>>> as promised.
>>>>>>
>>>>>> You can't do this, lockdep will tell you this is wrong.
>>>>>
>>>>> Hmm, but lockdep was silence on my setup?
>>>>>
>>>>>> We need a lock and to use the lock for writes.
>>>>>
>>>>> This code is executed by a single-thread test code.  Do we still need the lock?
>>>>>
>>>>>>
>>>>>> I'd suggest using different flags so the spinlock is used.
>>>>>
>>>>> The reporter mentioned simply dropping MT_FLAGS_LOCK_EXTERN from the flags
>>>>> causes suspicious RCU usage message.  May I ask if you have a suggestion of
>>>>> better flags?
>>>
>>> That would be the lockdep complaining, so that's good.
>>>
>>>>
>>>> I was actually thinking replacing the mt_init_flags() with mt_init(), which
>>>> same to mt_init_flags() with zero flag, like below.
>>>
>>> Yes.  This will use the spinlock which should fix your issue, but it
>>> will use a different style of maple tree.
>>>
>>> Perhaps use MT_FLAGS_ALLOC_RANGE to use the same type of maple tree, if
>>> you ever add threading you will want the rcu flag as well
>>> (MT_FLAGS_USE_RCU).
>>>
>>> I would recommend those two and just use the spinlock.
>>>
>>
>> I tried that (MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU). it also triggers
>> the suspicious RCU usage message.
>>
> 
> I am running ./tools/testing/kunit/kunit.py run '*damon*' --arch x86_64 --raw
> with:
> CONFIG_LOCKDEP=y
> CONFIG_DEBUG_SPINLOCK=y
> 
> and I don't have any issue with locking in the existing code.  How do I
> recreate this issue?
> 

I tested again, and I still see


[    6.233483] ok 4 damon
[    6.234190]     KTAP version 1
[    6.234263]     # Subtest: damon-operations
[    6.234335]     # module: vaddr
[    6.234384]     1..6
[    6.235726]
[    6.235931] =============================
[    6.236018] WARNING: suspicious RCU usage
[    6.236280] 6.11.0-rc6-00029-gda66250b210f-dirty #1 Tainted: G                 N
[    6.236398] -----------------------------
[    6.236474] lib/maple_tree.c:832 suspicious rcu_dereference_check() usage!
[    6.236579]
[    6.236579] other info that might help us debug this:
[    6.236579]
[    6.236738]
[    6.236738] rcu_scheduler_active = 2, debug_locks = 1
[    6.237039] no locks held by kunit_try_catch/208.
[    6.237166]
[    6.237166] stack backtrace:
[    6.237385] CPU: 0 UID: 0 PID: 208 Comm: kunit_try_catch Tainted: G                 N 6.11.0-rc6-00029-gda66250b210f-dirty #1
[    6.237629] Tainted: [N]=TEST
[    6.237714] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    6.238065] Call Trace:
[    6.238233]  <TASK>
[    6.238547]  dump_stack_lvl+0x9e/0xe0
[    6.239473]  lockdep_rcu_suspicious+0x145/0x1b0
[    6.239621]  mas_walk+0x19f/0x1d0
[    6.239765]  mas_find+0xb5/0x150
[    6.239873]  __damon_va_three_regions+0x7e/0x130
[    6.240039]  damon_test_three_regions_in_vmas+0x1ea/0x480
[    6.240551]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
[    6.240712]  kunit_try_run_case+0x93/0x190
[    6.240850]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
[    6.240990]  kunit_generic_run_threadfn_adapter+0x1c/0x40
[    6.241124]  kthread+0xdd/0x110
[    6.241256]  ? __pfx_kthread+0x10/0x10
[    6.241368]  ret_from_fork+0x2f/0x50
[    6.241468]  ? __pfx_kthread+0x10/0x10
[    6.241573]  ret_from_fork_asm+0x1a/0x30
[    6.241765]  </TASK>
[    6.242180]
[    6.242270] =============================
[    6.242375] WARNING: suspicious RCU usage
[    6.242478] 6.11.0-rc6-00029-gda66250b210f-dirty #1 Tainted: G                 N
[    6.242634] -----------------------------
[    6.242734] lib/maple_tree.c:788 suspicious rcu_dereference_check() usage!
[    6.242955]
[    6.242955] other info that might help us debug this:
[    6.242955]
[    6.243098]
[    6.243098] rcu_scheduler_active = 2, debug_locks = 1
[    6.243215] no locks held by kunit_try_catch/208.
[    6.243331]
[    6.243331] stack backtrace:
[    6.243420] CPU: 0 UID: 0 PID: 208 Comm: kunit_try_catch Tainted: G                 N 6.11.0-rc6-00029-gda66250b210f-dirty #1
[    6.243599] Tainted: [N]=TEST
[    6.243665] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    6.243844] Call Trace:
[    6.243907]  <TASK>
[    6.243961]  dump_stack_lvl+0x9e/0xe0
[    6.244032]  lockdep_rcu_suspicious+0x145/0x1b0
[    6.244121]  mtree_range_walk+0x2b9/0x350
[    6.244211]  mas_walk+0x107/0x1d0
[    6.244278]  mas_find+0xb5/0x150
[    6.244341]  __damon_va_three_regions+0x7e/0x130
[    6.244445]  damon_test_three_regions_in_vmas+0x1ea/0x480
[    6.244770]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
[    6.244865]  kunit_try_run_case+0x93/0x190
[    6.244952]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
[    6.245044]  kunit_generic_run_threadfn_adapter+0x1c/0x40
[    6.245130]  kthread+0xdd/0x110
[    6.245191]  ? __pfx_kthread+0x10/0x10
[    6.245262]  ret_from_fork+0x2f/0x50
[    6.245326]  ? __pfx_kthread+0x10/0x10
[    6.245394]  ret_from_fork_asm+0x1a/0x30
[    6.245497]  </TASK>
[    6.246605]     # damon_test_three_regions_in_vmas: pass:1 fail:0 skip:0 total:1
[    6.246668]     ok 1 damon_test_three_regions_in_vmas

This is with

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index 83626483f82b..a339d117150f 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -77,7 +77,7 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
                 (struct vm_area_struct) {.vm_start = 307, .vm_end = 330},
         };

-       mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
+       mt_init_flags(&mm.mm_mt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU);
         if (__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)))
                 kunit_skip(test, "Failed to create VMA tree");

I'll put it all together and make it available, but that will have to wait until
tomorrow.

Thanks,
Guenter



