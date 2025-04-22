Return-Path: <linux-kselftest+bounces-31293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9549FA966FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 13:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B81B3AA971
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 11:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8FE2777FD;
	Tue, 22 Apr 2025 11:11:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D05C2AF1E;
	Tue, 22 Apr 2025 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320275; cv=none; b=R2QOxBrkQT+NPx+0mDXBYweSM5w3f+fSxdoy93hkUhhuEjuNI+aKWdunekrSRF2ucRHP5frZY90RjpJwNJcP7Z1Aim2J64zBHHbVBitJO192dr3KdhEP5iw62IvMliXhRiVBilPQIjZidh7DYVI8jxpkyNO2tM50T2IiQ3SMFDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320275; c=relaxed/simple;
	bh=xTdWpLzUwae6fRDlksDYyKa7G4SjJ7tiGPGTMyQWSS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5AZuVZT2/+yJv2fSfBWoXMcf2FHSLB1R785Aq+KKRsidnsrkzkrYWfYr9ouiTMEHAgwmlSF6YhTuL47yaD9amyTob2tRddIEKfq7YcKck5Ez+Ue9WYQGr39pcu6HsqbPc+bMxxAiwJYbXK1O8F/2qgLCXMOH0Q3yI2sC3JEFW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53A8D152B;
	Tue, 22 Apr 2025 04:11:08 -0700 (PDT)
Received: from [10.57.90.106] (unknown [10.57.90.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E38F83F5A1;
	Tue, 22 Apr 2025 04:11:09 -0700 (PDT)
Message-ID: <7d9f87cc-c891-4845-a917-c1d9b606bea9@arm.com>
Date: Tue, 22 Apr 2025 12:11:08 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tools/selftests: expand all guard region tests to
 file-backed
Content-Language: en-GB
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>,
 Kalesh Singh <kaleshsingh@google.com>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <ab42228d2bd9b8aa18e9faebcd5c88732a7e5820.1739469950.git.lorenzo.stoakes@oracle.com>
 <a2d2766b-0ab4-437b-951a-8595a7506fe9@arm.com>
 <7d5e0f61-66d9-471c-b6ef-bf68dbffa614@lucifer.local>
 <c76429c3-2689-4722-99c5-f577af679aa4@arm.com>
 <f0344770-fd17-4f7d-b802-ba2f3570ac57@lucifer.local>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <f0344770-fd17-4f7d-b802-ba2f3570ac57@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/04/2025 12:07, Lorenzo Stoakes wrote:
> On Tue, Apr 22, 2025 at 12:03:08PM +0100, Ryan Roberts wrote:
>> On 22/04/2025 11:47, Lorenzo Stoakes wrote:
>>> On Tue, Apr 22, 2025 at 11:37:57AM +0100, Ryan Roberts wrote:
> 
> [snip]
> 
>>>>
>>>> Hi Lorenzo,
>>>>
>>>> I'm getting a test failure in v6.15-rc3 on arm64:
>>>>
>>>> ----8<----
>>>> #  RUN           guard_regions.shmem.uffd ...
>>>> # guard-regions.c:1467:uffd:Expected ioctl(uffd, UFFDIO_REGISTER, &reg) (-1) ==
>>>> 0 (0)
>>>> # uffd: Test terminated by assertion
>>>> #          FAIL  guard_regions.shmem.uffd
>>>> not ok 45 guard_regions.shmem.uffd
>>>> ----8<----
>>>>
>>>> The ioctl is returning EINVAL.
>>>
>>> Hm strange, that works fine <resists urge to say 'on my machine'> on x86-64. Is
>>> userfaultfd enabled in your config, to ask a silly question?
>>
>> Yep, and the anon version of the test is passing, as are all the uffd tests.
>>
>>>
>>> It'd be odd for this to vary depending upon arch.
>>>
>>> So a factor here is a _stupidity_ in the testing - does your system mount /tmp
>>> as tmpfs or an actual file system? As the test code unconditionally assumes /tmp
>>> is indeed going to get you a shmem file.
>>
>> Ahh that's probably it. I'm on Ubuntu and it looks like /tmp is just a dir on
>> the rootfs (XFS in my case).
>>
>> Forcing a tmpfs to /tmp solved it.
>>
>> Looks like uffd-unit-tests (see shmem_allocate_area()) is just using memfd.
>> Would it be reasonable to take that approach? Or just use anon+shared via mmap?
> 
> Yeah could be either memfd or MAP_ANON | MAP_SHARED. I think I did it this
> way to make the code a little easier given all the variant stuff.
> 
> Unless you felt especially keen, I can add fixing this to my todos :)

I'm not keen, but if it lingers I might have a crack. Otherwise it's just more
noise to ignore when I'm running tests...

> 
> Sorry about this! Entirely my fault, knew it wasn't ideal when I wrote it,
> but with test code sometimes you (perhaps incorrectly) tolerate things you
> wouldn't elsewhere...

No problem; I would have done the same thing. Given we know the root cause is a
test issue, this is not a high priority issue from my perspective.

> 
> Cheers, Lorenzo
> 
>>
>> Thanks,
>> Ryan
>>
> 
> [snip]


