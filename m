Return-Path: <linux-kselftest+bounces-18093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEED97B781
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 07:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B5A1F21EEA
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 05:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F8A136327;
	Wed, 18 Sep 2024 05:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="NLbIB6CO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF691339A4;
	Wed, 18 Sep 2024 05:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726638397; cv=pass; b=lFfCKQKnuPDo/7MNNCS8kLNu4klfEbcSsoVw1lykQYqKmCCPNO3C8PJifX3dXLgJbV3NkKMClLZMxdHrMHloWKm2/Osv7dqVJrVeY3eSZKpxo5urjZ1HHvM28wbmpSY6BbRc/eKkJ7nHbpjAPyh+smW+HfhfnUKEIsc9GLWS2zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726638397; c=relaxed/simple;
	bh=LT6K0WPKGVgwRRVo8p6lU+eEzGJzGV0VLG5k2HtD1As=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ils+fNH0k2xw/Cb/1HFFykPD8i46RuGLbYNnZ18Y7vvCtG2NVM7sVi7QChmXOZ8yGxAkqP4oVGLQ1VIeioqHblfy3JkcRS5S5oqw6bItmySBswvl6ZP8j+AeIMRdkVxB0sRWZ1erLhtS1XJrjWM83Aecdn3ODGQZkLX2hEqctZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=NLbIB6CO; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726638375; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SMU5Ji6YY7IaC0jHm0l+cFblMXz4OkLyQ2t+4lB/zQFRqKtv5xHq+h+fpVDWn1mXD5wyZpzQ6U2byH2lNiFT6Gd4RD//4/X5b5CRQc1XJj5IgG8fDoQX7WnYxMjamhPEA+y2Qso6WV4CgZbdron84fic1xLCBOXcjshzb0apBbU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726638375; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+T7DsFUS0IX9KOF0oXx+kzfEg5O8+v17rnwkmfflrAg=; 
	b=Y4Pfl8dbAkBgk3OqWIXcgIcaTYPS+0kGU1XZHrxqPbEM16Iyy5xBIW+MTAw383cPJq6JD1EldOS3uehQyoh+8TBn7iFfOQ6gi677nkVjC1HTsqB7w2Qm31jMGSfUPd8Rl99nnUoPriSt5XEBJnYDS2ofgDrUZJMcTcyUqyvWc7g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726638375;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+T7DsFUS0IX9KOF0oXx+kzfEg5O8+v17rnwkmfflrAg=;
	b=NLbIB6COo8X+/MWgt8//wCwYehdzZE9WHG+LpQFJCKeJGq14GlAIUePFepJulTlG
	bO+2WV6ofbUYXNvG0EuVQF5jYCKfTuD4WGojbkAfBf2UWpJaGxvW5Flm9AlMS9U6SC3
	uprPEXzLldZD+gcnM+i89ubVM+OHmlcm6bGEvnnI=
Received: by mx.zohomail.com with SMTPS id 1726638372856538.8419138041938;
	Tue, 17 Sep 2024 22:46:12 -0700 (PDT)
Message-ID: <0b847784-a95f-4ed5-a0fb-1b7b4023df13@collabora.com>
Date: Wed, 18 Sep 2024 10:46:05 +0500
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
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20240912103151.1520254-1-usama.anjum@collabora.com>
 <a9ae7dc4-275d-43c3-bf4c-b0090cb6bb12@linuxfoundation.org>
 <3cb9d266-4d4b-4031-8603-da7fd9e3ad47@collabora.com>
 <b3caeb96-2f48-4efd-a56c-e91dae891b48@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <b3caeb96-2f48-4efd-a56c-e91dae891b48@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 9/17/24 6:56 AM, Shuah Khan wrote:
> On 9/16/24 00:32, Muhammad Usama Anjum wrote:
>> On 9/12/24 8:44 PM, Shuah Khan wrote:
>>> On 9/12/24 04:31, Muhammad Usama Anjum wrote:
>>>> The value of __NR_userfaultfd was changed to 282 when
>>>> asm-generic/unistd.h was included. It makes the test to fail every time
>>>> as the correct number of this syscall on x86_64 is 323. Fix the header
>>>> to asm/unistd.h.
>>>>
>>>
>>> "please elaborate every time" - I just built on my x86_64 and built
>>> just fine.
>> The build isn't broken.
>>
>>> I am not saying this isn't a problem, it is good to
>>> understand why and how it is failing before making the change.
>> I mean to say that the test is failing at run time because the correct
>> userfaultfd syscall isn't being found with __NR_userfaultfd = 282.
>> _NR_userfaultfd's value depends on the header. When asm-generic/unistd.h
>> is included, its value (282) is wrong. I've tested on x86_64.
>>
> 
> Okay - how do you know this is wrong? can you provide more details.
> 
> git grep _NR_userfaultfd
> include/uapi/asm-generic/unistd.h:#define __NR_userfaultfd 282
> include/uapi/asm-generic/unistd.h:__SYSCALL(__NR_userfaultfd,
> sys_userfaultfd)
> tools/include/uapi/asm-generic/unistd.h:#define __NR_userfaultfd 282
> 
>> The fix is simple. Add the correct header which has _NR_userfaultfd =
>> 323.

grep -rnIF "#define __NR_userfaultfd"
tools/include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
arch/x86/include/generated/uapi/asm/unistd_32.h:374:#define
__NR_userfaultfd 374
arch/x86/include/generated/uapi/asm/unistd_64.h:327:#define
__NR_userfaultfd 323
arch/x86/include/generated/uapi/asm/unistd_x32.h:282:#define
__NR_userfaultfd (__X32_SYSCALL_BIT + 323)
arch/arm/include/generated/uapi/asm/unistd-eabi.h:347:#define
__NR_userfaultfd (__NR_SYSCALL_BASE + 388)
arch/arm/include/generated/uapi/asm/unistd-oabi.h:359:#define
__NR_userfaultfd (__NR_SYSCALL_BASE + 388)
include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282

The number is dependent on the architecture. The above data shows that:
x86	374
x86_64	323

I'm unable to find the history of why it is set to 282 in unistd.h and
when this problem happened.

> 
> I need more details on this number.
> 
> thanks,
> -- Shuah

-- 
BR,
Muhammad Usama Anjum


