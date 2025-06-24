Return-Path: <linux-kselftest+bounces-35684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EC4AE63B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 13:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7586B404FBC
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 11:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B2B283FF4;
	Tue, 24 Jun 2025 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Us4UPVMx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3130A1F3B9E
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750765159; cv=none; b=rIqnV5jmHtpyFjnUPEhv+wu0TcY55RCaCk4tjAB0B86kuzCtKUdTZpWx76D7LS9bXD0UKpsY4zwIOoK09fjqguzhqbtUAs3XsGOF3mBjGx8Npc8x65Ud1VxXDeKnOjLkYe0mP1rjpePGOXioLWQZ88kTUWbIKyppfzEa4OAmfKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750765159; c=relaxed/simple;
	bh=3IYqA6zz18wVwbxDcdlFAV35wjek5Niz57+vKGJeRT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cksvUOcshHeqRJePmPazzft+e3gQ/L5XQ5FhHHG1m6AFaFieb/JESckGD0/QgSD9d1fUHJ40Q4k/kHiV5MR6f/gdXvQFpfzPix8jd5luKEXJBMfO/CwAsvzds6s/BvSWcjgWh+9U2A2HNNgmxBVsVp5nO6xkeX96g4rvT3pVePQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Us4UPVMx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750765155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AXIga1bkzrBMFrY8HFgs7axgfA9Z09Pf3kfYJmY6hOo=;
	b=Us4UPVMxA5NpQGLLAlgQmQBe1IarLddIDZOl9lRKANih6/FMxAwbrUw+EXu11FzINICIMD
	AkVKh0c7gYDFCipKqptn9QbY/MBwgj/3Zreh32nykj7XAiYNN4J8v+D6OvCVdAKurWDKYk
	3lNNpeyZJEmAYH63KjDwL8xqBEdtd1U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-qCQuImKNP7qLNJjLE1FfeA-1; Tue, 24 Jun 2025 07:39:13 -0400
X-MC-Unique: qCQuImKNP7qLNJjLE1FfeA-1
X-Mimecast-MFC-AGG-ID: qCQuImKNP7qLNJjLE1FfeA_1750765152
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so2494305e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 04:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750765152; x=1751369952;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AXIga1bkzrBMFrY8HFgs7axgfA9Z09Pf3kfYJmY6hOo=;
        b=URcZnB3vbyXnSwlbgIkQbVJQTAIrNvrbIR4Ciyk0f/EYc2aYx5odm8vDsrQxetYmT/
         fhZr1360ufkCvJQ+kjrlhIaRSRjRtqKtfkyaXpQW3dNz+eyBSh3raYeAxKjKoFqDKSX/
         BCHqWvmIA3bOWfp+n2DGjjBAqI4c88dtkSBNW3kzCMqVCAEeYp+szcPxY9/NzPkHAFae
         3Q95H3voRn9cXBvikYTHOT+aOGWX27azq66/5t8EKTYN/n05DkHrgPt0cedTD0iLZvUH
         9JPoCUBgRoITGliqStkVrZGySzrmfKldsedeLQsREWsyTJ/z6xXSpZCjnc0Z3irf+gUZ
         QuCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRZxdC99puEocMz7K8H5KNbVFarRgPBfl+dS9o1ZpCgie0pbphB/QqKsWHBVlL49rMfO4kuLdFrhD8L680DZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz98gxlfST267kXmPoBLj3/VYlTWBkd9VFUnOl6l62gR/3/o5DS
	Or4hoYvrwe4KLG+FaAIUmis740fWFKcaYQUzA14gyfp1uNpbee7v4fpjdjx+NyoDoIqgN6pSGOo
	ZsSLzl1Tp3i0ZYr7B5PFh+SFNxjS3GVsvpGZQTuvrBvMon7DWN4PgrH+OX4eqU/NIxK3QDA==
X-Gm-Gg: ASbGncuuNsgYk2kGF/ziSnRXZBMFYIL7rZ6C+x/64yI3viAsKsCk38YEheoG6Szh7vi
	ctDH0M8CXF3YwFi/QTpbHvEcOWvEk2Jryj6+Jr8pVFPnkyDwhU1R1mI3aOzW8w8trZVJ3Zo1dEZ
	VVZu8fI3T75MM4Tbg1Ebs1LyRv7Oy2X4rNP3AhvOuaVIvTLBDydjSaRvKgbp3G0ijjNSBeS4Db+
	Kb0aq+T8dpx1WcXwQJgtxMk0+wqjyJQkYJwm4bT7WuauIFvFk7IsXgNOXZvj10ZMUr7HhI1Y8Z5
	wSZvQ5Y0nnxmXAWOfM5wc4k4Sc+ItePmfW0sQjjqp6BKoZ8TsYu8Ja0=
X-Received: by 2002:a05:600c:1f14:b0:453:5d8d:d1b8 with SMTP id 5b1f17b1804b1-453659c4169mr165567225e9.30.1750765152078;
        Tue, 24 Jun 2025 04:39:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErMOyF7WaU24rVgpkQqumxg1Yg3KftcabGR+eBnLPstGAHmjKS0ym0uqBvGrttUZVbn2hA9w==
X-Received: by 2002:a05:600c:1f14:b0:453:5d8d:d1b8 with SMTP id 5b1f17b1804b1-453659c4169mr165566765e9.30.1750765151613;
        Tue, 24 Jun 2025 04:39:11 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e98b48asm174446585e9.16.2025.06.24.04.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 04:39:10 -0700 (PDT)
Message-ID: <239f75e4-1868-4ac9-882f-664a8863b781@redhat.com>
Date: Tue, 24 Jun 2025 13:39:09 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mm: Fix UFFDIO_API usage with proper
 two-step feature negotiation
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Li Wang <liwang@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kselftest@vger.kernel.org,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Peter Xu <peterx@redhat.com>,
 Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Joey Gouly <joey.gouly@arm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Keith Lucas <keith.lucas@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>
References: <20250622081035.378164-1-liwang@redhat.com>
 <20250624042411.395285-1-liwang@redhat.com>
 <dfd7650d-1154-467d-ae70-c126610413f6@redhat.com>
 <4fd18a1c-aba2-468a-881f-0507953f2904@redhat.com>
 <611F9598-A1A4-47B6-B37E-09BF7B4D17D0@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <611F9598-A1A4-47B6-B37E-09BF7B4D17D0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.06.25 13:29, Nadav Amit wrote:
> 
> 
>> On 24 Jun 2025, at 11:22, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 24.06.25 10:07, David Hildenbrand wrote:
>>>>
>>> Is that actually required?
>>> The man page explicitly documents:
>>> "       EINVAL A  previous  UFFDIO_API  call already enabled one or more
>>> features for this userfaultfd.  Calling UFF‐
>>>                 DIO_API twice, the first time with no features set, is
>>> explicitly allowed as per the two-step  feature
>>>                 detection handshake.
>>> "
>>> So if that doesn't work, something might be broken.
>>
>> CCing Nadav and Peter:
>>
>> Could it be that
>>
>> commit 22e5fe2a2a279d9a6fcbdfb4dffe73821bef1c90
>> Author: Nadav Amit <nadav.amit@gmail.com>
>> Date:   Thu Sep 2 14:58:59 2021 -0700
>>
>>     userfaultfd: prevent concurrent API initialization
>>         userfaultfd assumes that the enabled features are set once and never
>>     changed after UFFDIO_API ioctl succeeded.
>>         However, currently, UFFDIO_API can be called concurrently from two
>>     different threads, succeed on both threads and leave userfaultfd's
>>     features in non-deterministic state.  Theoretically, other uffd operations
>>     (ioctl's and page-faults) can be dispatched while adversely affected by
>>     such changes of features.
>>         Moreover, the writes to ctx->state and ctx->features are not ordered,
>>     which can - theoretically, again - let userfaultfd_ioctl() think that
>>     userfaultfd API completed, while the features are still not initialized.
>>         To avoid races, it is arguably best to get rid of ctx->state.  Since there
>>     are only 2 states, record the API initialization in ctx->features as the
>>     uppermost bit and remove ctx->state.
>>
>> Accidentally broke the documented two-step handshake in the man page where we
>> can avoid closing + reopening the fd?
> 
> I agree the code is not correct (and my patch didn’t address this issue),
> but I don’t see it broke it either.
> 
> Unless I’m missing something the code before my patch, when
> uffdio_api.features == 0, also set ctx->state to UFFD_STATE_RUNNING, which
> meant another invocation would see (ctx->state != UFFD_STATE_WAIT_API) and
> fail.

You might be right, I only checked the cmpxchg, assuming it was working 
before that.

... but staring at the history of the "ctx->state = 
UFFD_STATE_RUNNING;", I am not sure if it ever behaved that way.

Do maybe, the man page is simply wrong (although I wonder why that case 
was described that detailed)

> 
>>
>> Without testing, the following might fix it if I am right:
>>
>> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
>> index 22f4bf956ba1c..f03e7c980e1c5 100644
>> --- a/fs/userfaultfd.c
>> +++ b/fs/userfaultfd.c
>> @@ -1944,9 +1944,9 @@ static int userfaultfd_move(struct userfaultfd_ctx *ctx,
>> static int userfaultfd_api(struct userfaultfd_ctx *ctx,
>>                            unsigned long arg)
>> {
>> +       unsigned int new_features, old_features = 0;
>>         struct uffdio_api uffdio_api;
>>         void __user *buf = (void __user *)arg;
>> -       unsigned int ctx_features;
>>         int ret;
>>         __u64 features;
>> @@ -1990,9 +1990,12 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
>>                 goto out;
>>          /* only enable the requested features for this uffd context */
>> -       ctx_features = uffd_ctx_features(features);
>> +       new_features = uffd_ctx_features(features);
>> +       /* allow two-step handshake */
>> +       if (userfaultfd_is_initialized(ctx))
>> +               old_features = UFFD_FEATURE_INITIALIZED;
>>         ret = -EINVAL;
>> -       if (cmpxchg(&ctx->features, 0, ctx_features) != 0)
>> +       if (cmpxchg(&ctx->features, old_features, new_features) != old_features)
>>                 goto err_out;
>>          ret = 0;
> 
> I am not sure it is right since you would return EINVAL in this case.
> It also looks a bit overly complicated - are you concerned about a race?

Yes.

> My whole concern about race was that somebody would exploit it to
> overcome non-cooperative UFFD (IIRC).
> 
> So perhaps just add a check for the case features if 0 and be done with
> it? Something like adding:
> 
> 	ret = 0;
> 	if (ctx->features == 0 && features == 0)
> 		goto err_out; 		/* no error but copying of uffdio_api required */

Probably would also work. But let's find out first if we even want to 
fix this, given that it never seemed to have behaved that way from a 
quick glimpse.

-- 
Cheers,

David / dhildenb


