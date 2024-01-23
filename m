Return-Path: <linux-kselftest+bounces-3391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F5F838843
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 08:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54291C2316E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 07:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1703556472;
	Tue, 23 Jan 2024 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BYQQiZeT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961EE56452;
	Tue, 23 Jan 2024 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705996270; cv=none; b=cLNGMnvlmqf/Ams8aOxBDtd6zONYdqi4WCzvlUf1wBFKux1vmaKZLcEyLcqHb1DJSAeOgwopsZ4TpGa1ySv2ti9PKH4zyJ9bXRNPnWABJKAxCXcdhmoz99DK4O0A/YH4+DkbJgmFiRjJ6AfxLfnoxxDlDJNHf3WXrXGvCga1/Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705996270; c=relaxed/simple;
	bh=zd/j1EL0RWNL3nB5t24QcTLBe0LEMe9+ptv3ScUHGE4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eWxo3QBpkmimgdvGKTwOB5+9zqrlBiH0f7bZ3CxcYR8JdIlYgcgrltLYl3XCQpRlVyInscY8lWw9QrioccT34SUr1SWU4lnnvhJhsyn0mqM7tGzUssXfqHmjsXxcXaKm1ywnEMbX7nhyEUeklim20ndzJf3BSxDzBs3szP0v5HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BYQQiZeT; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705996266;
	bh=zd/j1EL0RWNL3nB5t24QcTLBe0LEMe9+ptv3ScUHGE4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=BYQQiZeTl9d9jUYXQwlAq2xsSGjXnSj08xc6WQbbiRU8zvqnXznPnH515XlrKNKJ5
	 RPj1JkvVs/el14sZ6hRHEMdVHmWQx3Rqp9ZbPjy7ljb2chw07kmVACCQD91sm8eNmK
	 1IMQnBtQbKrCrn8Ck1W1mUL7uFe8Etoe8TgLTam6G6fBUpYobBJNEKxaxmUxQUn5Ko
	 vp8E5RS4wXCM4IOGDJBjnMsgq59tBA3HsS+78PMxzLUGHg9xMwrUxMRANI+SthenVc
	 78Li0WbGQVS59l4O/5jUCv5jq5WBYoo6XGWkMhwxDfEfwFJruGyCnN8jQYyrnTygpr
	 uexNwtqT7ANDg==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 779F83782066;
	Tue, 23 Jan 2024 07:51:03 +0000 (UTC)
Message-ID: <de0e9e64-9833-4c60-8234-30b709b135db@collabora.com>
Date: Tue, 23 Jan 2024 12:51:16 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests/mm: run_vmtests.sh: add missing tests
To: Ryan Roberts <ryan.roberts@arm.com>
References: <20240116090641.3411660-1-usama.anjum@collabora.com>
 <ffdba8c4-f1a2-4141-a3d4-0c85dfea6fef@arm.com>
 <e3b2c142-aaae-481d-8206-5e8f374fd37e@collabora.com>
 <06d796a1-1ae2-4f97-8fd6-0e3529ae2799@arm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <06d796a1-1ae2-4f97-8fd6-0e3529ae2799@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/22/24 2:59 PM, Ryan Roberts wrote:
>>>> +CATEGORY="hugetlb" run_test ./hugetlb-read-hwpoison
>>>
>>> The addition of this test causes 2 later tests to fail with ENOMEM. I suspect
>>> its a side-effect of marking the hugetlbs as hwpoisoned? (just a guess based on
>>> the test name!). Once a page is marked poisoned, is there a way to un-poison it?
>>> If not, I suspect that's why it wasn't part of the standard test script in the
>>> first place.
>> hugetlb-read-hwpoison failed as probably the fix in the kernel for the test
>> hasn't been merged in the kernel. The other tests (uffd-stress) aren't
>> failing on my end and on CI [1][2]
> 
> To be clear, hugetlb-read-hwpoison isn't failing for me, its just causing the
> subsequent tests uffd-stress tests to fail. Both of those subsequent tests are
> allocating hugetlbs so my guess is that since this test is marking some hugetlbs
> as poisoned, there are no longer enough for the subsequent tests.
> 
>>
>> [1] https://lava.collabora.dev/scheduler/job/12577207#L3677
>> [2] https://lava.collabora.dev/scheduler/job/12577229#L4027
>>
>> Maybe its configurations issue which is exposed now. Not sure. Maybe
>> hugetlb-read-hwpoison is changing some configuration and not restoring it.
> 
> Well yes - its marking some hugetlb pages as HWPOISONED.
> 
>> Maybe your system has less number of hugetlb pages.
> 
> YEs probably; What is hugetlb-read-hwpoison's requirement for size and number of
> hugetlb pages? the run_vmtests.sh script allocates the required number of
> default-sized hugetlb pages before running any tests (I guess this value should
> be increased for hugetlb-read-hwpoison's requirements?).
> 
> Additionally, our CI preallocates non-default sizes from the kernel command line
> at boot. Happy to increase these if you can tell me what the new requirement is:
I'm not sure about the exact requirement of the number of hugetlb for these
tests. But I specify hugepages=1000 and tests work for me.

I've sent v2 [1]. Would it be possible to run your CI on that and share
results before we merge that one?

[1]
https://lore.kernel.org/all/20240123073615.920324-1-usama.anjum@collabora.com

> 
> hugepagesz=1G hugepages=0:2,1:2 hugepagesz=32M hugepages=0:2,1:2
> default_hugepagesz=2M hugepages=0:64,1:64 hugepagesz=64K hugepages=0:2,1:2
> 
> Thanks,
> Ryan
> 

-- 
BR,
Muhammad Usama Anjum

