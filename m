Return-Path: <linux-kselftest+bounces-31291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B53A966CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 13:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB25F7A436F
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 11:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6ED27510A;
	Tue, 22 Apr 2025 11:03:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F41253F1F;
	Tue, 22 Apr 2025 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745319796; cv=none; b=EtQy372drUIxjNDDpgVEMx82RH678nVehfc0WJymjiJ6Md2L394nr5WFDLHYIicq6ObgDcHw5s96j/0VUp5c2zOzvtQcSptU86XgTGx0B4gyfe+cU/AQwNAQC2EaRpFHJMzNwCqP7OAt2+iHd38FsQGDSnMdBbww1DFPauwfGN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745319796; c=relaxed/simple;
	bh=Res5o+I2s0cBGcmb4XegB9h0I86JS9fOAJAA3IFhAEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMH7bd56JogEEt4rEAEuZ+Lje1SfIg+8tIKixjiXQ5Vk69sASXtKiqerwWtSdVGIFyWKUP5KjaYc8cKDuGdxFkjBSOflyR8CCWZx6CxPsTLf4JpKjOZHeAgpVH+Ez3cQNUfTCHH9794PmQKIOgEFWxBO8hEfnxCWgMB8RmlWUDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2B54152B;
	Tue, 22 Apr 2025 04:03:09 -0700 (PDT)
Received: from [10.57.90.106] (unknown [10.57.90.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAC0C3F5A1;
	Tue, 22 Apr 2025 04:03:10 -0700 (PDT)
Message-ID: <c76429c3-2689-4722-99c5-f577af679aa4@arm.com>
Date: Tue, 22 Apr 2025 12:03:08 +0100
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <7d5e0f61-66d9-471c-b6ef-bf68dbffa614@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/04/2025 11:47, Lorenzo Stoakes wrote:
> On Tue, Apr 22, 2025 at 11:37:57AM +0100, Ryan Roberts wrote:
>> On 13/02/2025 18:17, Lorenzo Stoakes wrote:
>>> Extend the guard region tests to allow for test fixture variants for anon,
>>> shmem, and local file files.
>>>
>>> This allows us to assert that each of the expected behaviours of anonymous
>>> memory also applies correctly to file-backed (both shmem and an a file
>>> created locally in the current working directory) and thus asserts the same
>>> correctness guarantees as all the remaining tests do.
>>>
>>> The fixture teardown is now performed in the parent process rather than
>>> child forked ones, meaning cleanup is always performed, including unlinking
>>> any generated temporary files.
>>>
>>> Additionally the variant fixture data type now contains an enum value
>>> indicating the type of backing store and the mmap() invocation is
>>> abstracted to allow for the mapping of whichever backing store the variant
>>> is testing.
>>>
>>> We adjust tests as necessary to account for the fact they may now reference
>>> files rather than anonymous memory.
>>
>> Hi Lorenzo,
>>
>> I'm getting a test failure in v6.15-rc3 on arm64:
>>
>> ----8<----
>> #  RUN           guard_regions.shmem.uffd ...
>> # guard-regions.c:1467:uffd:Expected ioctl(uffd, UFFDIO_REGISTER, &reg) (-1) ==
>> 0 (0)
>> # uffd: Test terminated by assertion
>> #          FAIL  guard_regions.shmem.uffd
>> not ok 45 guard_regions.shmem.uffd
>> ----8<----
>>
>> The ioctl is returning EINVAL.
> 
> Hm strange, that works fine <resists urge to say 'on my machine'> on x86-64. Is
> userfaultfd enabled in your config, to ask a silly question?

Yep, and the anon version of the test is passing, as are all the uffd tests.

> 
> It'd be odd for this to vary depending upon arch.
> 
> So a factor here is a _stupidity_ in the testing - does your system mount /tmp
> as tmpfs or an actual file system? As the test code unconditionally assumes /tmp
> is indeed going to get you a shmem file.

Ahh that's probably it. I'm on Ubuntu and it looks like /tmp is just a dir on
the rootfs (XFS in my case).

Forcing a tmpfs to /tmp solved it.

Looks like uffd-unit-tests (see shmem_allocate_area()) is just using memfd.
Would it be reasonable to take that approach? Or just use anon+shared via mmap?

Thanks,
Ryan

> 
> It's shameful to be honest. But actually I suspect this more than anything
> else...
> 
>>
>> [...]
>>
>>> @@ -1281,6 +1398,9 @@ TEST_F(guard_regions, uffd)
>>>  	struct uffdio_register reg;
>>>  	struct uffdio_range range;
>>>
>>> +	if (!is_anon_backed(variant))
>>
>> Perhaps this should be filtering out shmem too? Although the manual for
>> userfaultfd implies that shmem is supported:
> 
> Yeah it should work with it fine.
> 
>>
>> """
>> Up to Linux 4.11, userfaultfd can be used only with anonymous private memory
>> mappings.  Since Linux 4.11, userfaultfd can be also used with hugetlbfs and
>> shared memory mappings.
>> """
>>
>> But I'm not sure if that's referring specifically to UFFDIO_REGISTER_MODE_MISSING?
>>
>> Any ideas before I start debugging further?
>>
>> Thanks,
>> Ryan
>>
>>> +		SKIP(return, "uffd only works on anon backing");
>>> +
>>>  	/* Set up uffd. */
>>>  	uffd = userfaultfd(0);
>>>  	if (uffd == -1 && errno == EPERM)
>>> @@ -1290,8 +1410,8 @@ TEST_F(guard_regions, uffd)
>>>  	ASSERT_EQ(ioctl(uffd, UFFDIO_API, &api), 0);
>>>
>>>  	/* Map 10 pages. */
>>> -	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
>>> -		   MAP_ANON | MAP_PRIVATE, -1, 0);
>>> +	ptr = mmap_(self, variant, NULL, 10 * page_size,
>>> +		    PROT_READ | PROT_WRITE, 0, 0);
>>>  	ASSERT_NE(ptr, MAP_FAILED);
>>>
>>>  	/* Register the range with uffd. */
>>


