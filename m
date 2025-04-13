Return-Path: <linux-kselftest+bounces-30642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DC4A87076
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Apr 2025 05:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EE7178F3D
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Apr 2025 03:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6798139CF2;
	Sun, 13 Apr 2025 03:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMUAkrpw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84228249F
	for <linux-kselftest@vger.kernel.org>; Sun, 13 Apr 2025 03:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744514108; cv=none; b=fUISMNeVPzdh7wDAZjJWYBcs8d1wsx54GniIlGuugU/oU02LLrBSq5Hu68xI8eEddb9nbbHqkQ6o6MS9H3x4aImrB9UU7qmNkF5myn8jXEqDQMFuicCD2U11h/MoR+Ee98+SJ4JUavnxdUmJ1FAh3bgRGCgZBhDDRFSE/hbeg9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744514108; c=relaxed/simple;
	bh=GXoItoIHVQGxDk0GZCjHQsM8qdSgDcBsL2mFmkWaNc8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FZBhF5/8IWahVeEIgjIQFTzOZ8JiW2mWUAeGbMoOdwnf2ZV6cdQHqG2QeCcOeXrbArQO7HCTVYtTFgOHwa8ylI78UHfIE6704aVg5ODzGtt/NpFe+yp3VWOV0aNMLLMGEYPiT9Yt7KUXUTHvKlBQXLnsRdzz9RJgrJSio9c9Y4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WMUAkrpw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744514105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZ2AIgXN2yGPN7Sxu2wl5jNXWejeTiuda2OwXuQQY0I=;
	b=WMUAkrpwkpKSbdggmy+HjO0VBj17OE1AcLqqaDOTl4l2yQ8cHfhUX3mtI3g2MCS6sWvX6c
	X89j+PrcOOug+6G9i1hfEh/8DXCPFrnWEpSH8/d/PFwFqxiRxnWQv/1gqBC2b03Lq3vmdx
	WwYe1bbz4g5Y2c6qGCXuFWyvT00RfDk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-_qS4DinhOQqCG43VzTrMdQ-1; Sat, 12 Apr 2025 23:15:04 -0400
X-MC-Unique: _qS4DinhOQqCG43VzTrMdQ-1
X-Mimecast-MFC-AGG-ID: _qS4DinhOQqCG43VzTrMdQ_1744514103
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5e28d0cc0so575134785a.3
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Apr 2025 20:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744514103; x=1745118903;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZ2AIgXN2yGPN7Sxu2wl5jNXWejeTiuda2OwXuQQY0I=;
        b=UHWbFaA8SWvl6Xes3GGeebjMubClvtRU+/1o9/Z2PUbT4ZMbdvyHHrCj6avegHY5gt
         JOTLpXZlN9N/hISzQ6F8iY502NWYAXAvnYD6udcofpKLjyQK8uI4JkkyMB6esDdxuO7Q
         u1K0uVdkldJAvFFvbLtHaEucpcVt9+FdsyD6Fk0caw0dDXWQSSdaDNcwXegMTB4nhKUi
         yFwucgVNZi7Avlm3Cgs2dVGef62w1w/EC3o8Rj2fU4bNbrTok+L8ivKVV9nWBlNLw+dw
         NvzpcboLNxFJtJPlXvqHCwVlyml3m/WlGtBb7XO8jQAIntKqOZDn7FV/9uwVjdcUDFVW
         DS0g==
X-Forwarded-Encrypted: i=1; AJvYcCVBhJzEEXSb8PqrcBtHyvO4vEj8HZEr5adq5mlbAqVMLx4K22EXWQRvOx2LkslQ8OLs4TQWOB5IcCMl5jo5J7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb3jMWFXQwSR4WGoYOxMNLPGKC6ODRl8XCiv0oeJxJbC1kSb+R
	JZ96aKMZogn9M99GyuSagLl7aflFw7Z4nO12VZELRQLFUdDGWRQIth5bpw6Q81OIG9nr27aItj0
	1xag13ffyZHqEKOp8y40KdYnPItVet6tCjDMF7dUlvZ6US8VyuSub4SD1+ufoWZAG4JKky+mCpA
	==
X-Gm-Gg: ASbGncslQ5kbtLw7t62p6Q5FPBj4omyhcPTzoU/O84+p6FPcLM9hhZtGmnlOeXdLbfY
	gRE7IsnBZvIOn4EYeHU2tQiB1574kiq3ct16HFrSHlHhLlh1fvaf51sm2ctWDwdNURts+hNj0eT
	Fm0NceM1mGiidF2JUoef7a2ceak3gpGU5mym8jQcr3Mlz0OfzIF3uu9JnceLTsE0ei9FoYbBJR7
	iUvWiGQWGdEaeklebE7qbT3SA6zp/WmB49JVRgXYNg4ublFnpnKWh14PdRiJPyvM+ScpcUSQ8TF
	z2H1o6A0e4oqlCI/trTQaTzFjEYXhVT5THrFCcugfPndqVh+KsajMA==
X-Received: by 2002:a05:620a:f0c:b0:7c5:50ab:de07 with SMTP id af79cd13be357-7c7af0d4854mr1206658285a.21.1744514103027;
        Sat, 12 Apr 2025 20:15:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEgZdkNpb8M2sLPV1/LXGt3hDMHfPduIrP6ippNwIGXHw9JexKgaMOOMOlNxn4UhxXHLuaKg==
X-Received: by 2002:a05:620a:f0c:b0:7c5:50ab:de07 with SMTP id af79cd13be357-7c7af0d4854mr1206655885a.21.1744514102577;
        Sat, 12 Apr 2025 20:15:02 -0700 (PDT)
Received: from [172.20.3.175] (syn-108-176-116-062.biz.spectrum.com. [108.176.116.62])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8a0f1fasm495773985a.112.2025.04.12.20.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Apr 2025 20:15:01 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <bbc48f40-274c-44ec-9a98-7c18b64628c0@redhat.com>
Date: Sat, 12 Apr 2025 23:15:00 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] selftests: memcg: Increase error tolerance of
 child memory.current check in test_memcg_protection()
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250406024010.1177927-1-longman@redhat.com>
 <20250406024010.1177927-3-longman@redhat.com> <Z_Wht7kyWyk62IBU@google.com>
Content-Language: en-US
In-Reply-To: <Z_Wht7kyWyk62IBU@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/8/25 6:22 PM, Roman Gushchin wrote:
> On Sat, Apr 05, 2025 at 10:40:10PM -0400, Waiman Long wrote:
>> The test_memcg_protection() function is used for the test_memcg_min and
>> test_memcg_low sub-tests. This function generates a set of parent/child
>> cgroups like:
>>
>>    parent:  memory.min/low = 50M
>>    child 0: memory.min/low = 75M,  memory.current = 50M
>>    child 1: memory.min/low = 25M,  memory.current = 50M
>>    child 2: memory.min/low = 0,    memory.current = 50M
>>
>> After applying memory pressure, the function expects the following
>> actual memory usages.
>>
>>    parent:  memory.current ~= 50M
>>    child 0: memory.current ~= 29M
>>    child 1: memory.current ~= 21M
>>    child 2: memory.current ~= 0
>>
>> In reality, the actual memory usages can differ quite a bit from the
>> expected values. It uses an error tolerance of 10% with the values_close()
>> helper.
>>
>> Both the test_memcg_min and test_memcg_low sub-tests can fail
>> sporadically because the actual memory usage exceeds the 10% error
>> tolerance. Below are a sample of the usage data of the tests runs
>> that fail.
>>
>>    Child   Actual usage    Expected usage    %err
>>    -----   ------------    --------------    ----
>>      1       16990208         22020096      -12.9%
>>      1       17252352         22020096      -12.1%
>>      0       37699584         30408704      +10.7%
>>      1       14368768         22020096      -21.0%
>>      1       16871424         22020096      -13.2%
>>
>> The current 10% error tolerenace might be right at the time
>> test_memcontrol.c was first introduced in v4.18 kernel, but memory
>> reclaim have certainly evolved quite a bit since then which may result
>> in a bit more run-to-run variation than previously expected.
>>
>> Increase the error tolerance to 15% for child 0 and 20% for child 1 to
>> minimize the chance of this type of failure. The tolerance is bigger
>> for child 1 because an upswing in child 0 corresponds to a smaller
>> %err than a similar downswing in child 1 due to the way %err is used
>> in values_close().
>>
>> Before this patch, a 100 test runs of test_memcontrol produced the
>> following results:
>>
>>       17 not ok 1 test_memcg_min
>>       22 not ok 2 test_memcg_low
>>
>> After applying this patch, there were no test failure for test_memcg_min
>> and test_memcg_low in 100 test runs.
> Ideally we want to calculate these values dynamically based on the machine
> size (number of cpus and total memory size).
>
> We can calculate the memcg error margin and scale memcg sizes if necessarily.
> It's the only way to make it pass both on a 2-CPU's vm and 512-CPU's physical
> server.
>
> Not a blocker for this patch, just an idea for the future.

Thanks for the suggestion.

As I said in a previous mail, the way the test works is by waiting until 
the the memory.current of the parent is close to 50M, then it checks the 
memory.current's of its children to see how much usage each of them 
have. I am not sure if nr of CPUs or total memory size is really a 
factor here. We will probably need to run some experiments to find out. 
Anyway, it will be a future patch if they are really a factor here.

Cheers,
Longman

>
> Thanks!
>


