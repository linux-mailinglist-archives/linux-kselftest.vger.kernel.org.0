Return-Path: <linux-kselftest+bounces-18269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31140983D0F
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 08:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5401F211A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 06:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A253EA83;
	Tue, 24 Sep 2024 06:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="QSZTgU8h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D51B946C;
	Tue, 24 Sep 2024 06:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158930; cv=pass; b=suvMf1VWt/oyI0UdRGhQcDRCmt0Nd+53mxbI+P/330ZPjed2L6xk76U9Y2hcQaoe+0sMV+Qz2xJOvPqI+TUnkSxu7tfKLb9E7eR2BRAgD+TwDuX3DDP4waPuz8f+QqfVys2kdsuMCwQoGbJbMx4/ln8qfAuwrehPtrzxIOeEoUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158930; c=relaxed/simple;
	bh=HdtYSrtecSW6KcdZdLfXETvs3V785rqJeMBKuUs9Go4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eVwisnT3mA2w5JeetKzMVt6u2rLd9mY1APEsYb8ppvjUNceIzAvPwTfXaggmlVoB4EObxd2kEYI9qjQekKUckMVOz95lN2HD+Q7r2OeuxFvdfoOl5MHl8YgzTSsTh2xtxx1iI+EXOSn6zjy1RlnAVQ/scCNlDubHeczV8z4zUZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=QSZTgU8h; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1727158908; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ms0eqkyEWOBHewpsfYfTY75zXNRc5wM0z0j1NfgcfRiimacYkJVy0G/nnkBaRAvD5pRxFnaEnkadrrqojvwDc7MIHEuWxWwyVoLtYgY8DP4aR+KIfAduCW5fkDkxaosbmBUo37T6OcJzed+V3xiUvTBDYBHSuXV+cIRuYYu0oHw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1727158908; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Tfl66UbwblneQLJx/PLKt9dtwJSSzUeO9HMjAGRY/J8=; 
	b=lqfdub1aXAPz5Bf8LWhO99JTjQzeGpXF3pzqWKqNa1qyckTBvhiXtuV2ugMIBAmNavP0g8y0a2GK2JYl/OD8BoWNbCTLL1yMAk3A/mNx7k3lkVm8hvn2Q18R1C75VRws671zDmUIvvpviKUP7VALUiRRSucxFTPc5Xi3V5ROhOI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1727158908;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Tfl66UbwblneQLJx/PLKt9dtwJSSzUeO9HMjAGRY/J8=;
	b=QSZTgU8hAMqypSLnxhJ1EqHzmOV5CuK4zKjeRWcaVtYD2UTTdinP5Q7w9gnoaJwC
	iNmdiCgSGEVqCeZpeXzEYa2XAZOlj2Yoj5ZkUk39lkCIBUpFOIW3JGQLgXpA5Tq5zfQ
	3mO5NWp6hGLWCNVnDct4iSCTSz9Wc/twbmyvj9ps=
Received: by mx.zohomail.com with SMTPS id 1727158906014225.6532248094286;
	Mon, 23 Sep 2024 23:21:46 -0700 (PDT)
Message-ID: <109a9f01-0c5c-49f3-b956-91bc789a1c44@collabora.com>
Date: Tue, 24 Sep 2024 11:21:36 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 1/2] kselftests: mm: Fix wrong __NR_userfaultfd value
To: Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Kim Phillips <kim.phillips@arm.com>
References: <20240912103151.1520254-1-usama.anjum@collabora.com>
 <a9ae7dc4-275d-43c3-bf4c-b0090cb6bb12@linuxfoundation.org>
 <3cb9d266-4d4b-4031-8603-da7fd9e3ad47@collabora.com>
 <b3caeb96-2f48-4efd-a56c-e91dae891b48@linuxfoundation.org>
 <0b847784-a95f-4ed5-a0fb-1b7b4023df13@collabora.com>
 <e2a4d2b4-ca3f-4d21-82d5-b87bc9de9358@linuxfoundation.org>
 <e4e2095e-3280-4bfc-8129-80b8d00d146d@collabora.com>
 <db8b758e-9051-4ee0-b0e7-3b54eda0c71b@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <db8b758e-9051-4ee0-b0e7-3b54eda0c71b@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 9/23/24 9:02 PM, Shuah Khan wrote:
> On 9/22/24 23:35, Muhammad Usama Anjum wrote:
>> ...
>>
>>>> grep -rnIF "#define __NR_userfaultfd"
>>>> tools/include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd
>>>> 282
>>>> arch/x86/include/generated/uapi/asm/unistd_32.h:374:#define
>>>> __NR_userfaultfd 374
>>>> arch/x86/include/generated/uapi/asm/unistd_64.h:327:#define
>>>> __NR_userfaultfd 323
>>>> arch/x86/include/generated/uapi/asm/unistd_x32.h:282:#define
>>>> __NR_userfaultfd (__X32_SYSCALL_BIT + 323)
>>>> arch/arm/include/generated/uapi/asm/unistd-eabi.h:347:#define
>>>> __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
>>>> arch/arm/include/generated/uapi/asm/unistd-oabi.h:359:#define
>>>> __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
>>>> include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
>>>>
>>>> The number is dependent on the architecture. The above data shows that:
>>>> x86    374
>>>> x86_64    323
>>>
>>> Correct and the generated header files do the right thing and it is
>>> good to
>>> include them as this patch does.
>>>
>>> This is a good find and fix. I wish you explained this in your
>>> changelog.
>>> Please add more details when you send v2.
>> I'm sending v2
>>
>>>
>>> There could be other issues lurking based on what I found.
>>>
>>> The other two files are the problem where they hard code it to 282
>>> without
>>> taking the __NR_SYSCALL_BASE for the arch into consideration:
>>>
>>> tools/include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
>>> include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
>>>
>>>>
>>>> I'm unable to find the history of why it is set to 282 in unistd.h and
>>>> when this problem happened.
>>>
>>> According to git history it is added in the following commit to
>>> include/uapi/asm-generic/unistd.h:
>>>
>>> 09f7298100ea9767324298ab0c7979f6d7463183
>>> Subject: [PATCH] userfaultfd: register uapi generic syscall (aarch64)
>>>
>>> and it is added in the following commit to
>>> tools/include/uapi/asm-generic/unistd.h
>>> 34b009cfde2b8ce20a69c7bfd6bad4ce0e7cd970
>>> Subject: [PATCH] tools include: Grab copies of arm64 dependent unistd.h
>>> files
>>>
>>> I think, the above defines from include/uapi/asm-generic/unistd.h and
>>> tools/include/uapi/asm-generic/unistd.h should be removed.
>>>
>>> Maybe others familiar with userfaultfd can determine the best course of
>>> action.
>>> We might have other NR_ defines in these two files that are causing
>>> problems
>>> for tests and tools that we haven't uncovered yet.
>> Added authors of these patches.
>>
> 
> Thank you. Would you be able top follow up on this and send patches
> to remove these defines if it deemed to be the correct solution?
Yeah, sure. I'll follow up and fix the issue.

> 
> thanks,
> -- Shuah
> 
> 

-- 
BR,
Muhammad Usama Anjum


