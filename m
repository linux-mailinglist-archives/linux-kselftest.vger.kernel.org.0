Return-Path: <linux-kselftest+bounces-9350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECBB8BA8CA
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 10:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FE09B21BEF
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 08:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72CF149E03;
	Fri,  3 May 2024 08:30:31 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6405314F62;
	Fri,  3 May 2024 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725031; cv=none; b=NaG1gvC4ydnjmvHtUVvTrrhzdWQmLxe4S6s8fDX1UrgROrh7rBy7Ecu3hA9DEg+KQGvLcI4NspMp/fIwdv/qH8VjlOY/DdvpmN8n47UzkLsEJjD/rVuQszHPDjSUTraQe8++WGP9aDxz0H//p+MvOUA5Poi9dq+HX180l4ZUMW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725031; c=relaxed/simple;
	bh=gqwc2k3oZA5+RsTN0PhOwFlxF0pioPcwT29bhC8+fC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZzGbGNAlUrhjdymPyHMcw/kyigjzy043RZEcu02QHVQm+wXq39DC8FSXgscMeNVQZmQpzH86Mu/Qf9+FjeyEp5J088guVe4GiXAdCyyjN/fWLjkGVtlarWzpGg5b2JJQ2XvKCAcfmBSzhuJFcpaLv9TSfUfo+v5liL2FY2w7Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8118A2F4;
	Fri,  3 May 2024 01:30:53 -0700 (PDT)
Received: from [10.57.67.51] (unknown [10.57.67.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 047DF3F73F;
	Fri,  3 May 2024 01:30:24 -0700 (PDT)
Message-ID: <0afb3887-f72b-42d3-8809-e97353fae031@arm.com>
Date: Fri, 3 May 2024 09:30:23 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/5] selftest mm/mseal memory sealing
Content-Language: en-GB
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
 sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org,
 torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net,
 Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com,
 rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
 groeck@chromium.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 pedro.falcato@gmail.com, dave.hansen@intel.com,
 linux-hardening@vger.kernel.org, deraadt@openbsd.org
References: <20240415163527.626541-1-jeffxu@chromium.org>
 <20240415163527.626541-4-jeffxu@chromium.org>
 <f797fbde-ffb7-44b0-8af6-4ed2ec47eac1@arm.com>
 <CABi2SkXmGR41o8LwM=oD-PCZWvcc5zOie65wvuk5zsAQPymmRA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CABi2SkXmGR41o8LwM=oD-PCZWvcc5zOie65wvuk5zsAQPymmRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/05/2024 23:39, Jeff Xu wrote:
> On Thu, May 2, 2024 at 4:24 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 15/04/2024 17:35, jeffxu@chromium.org wrote:
>>> From: Jeff Xu <jeffxu@chromium.org>
>>>
>>> selftest for memory sealing change in mmap() and mseal().
>>>
>>> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
>>> ---
>>>  tools/testing/selftests/mm/.gitignore   |    1 +
>>>  tools/testing/selftests/mm/Makefile     |    1 +
>>>  tools/testing/selftests/mm/mseal_test.c | 1836 +++++++++++++++++++++++
>>>  3 files changed, 1838 insertions(+)
>>>  create mode 100644 tools/testing/selftests/mm/mseal_test.c
>>>
>>> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
>>> index d26e962f2ac4..98eaa4590f11 100644
>>> --- a/tools/testing/selftests/mm/.gitignore
>>> +++ b/tools/testing/selftests/mm/.gitignore
>>> @@ -47,3 +47,4 @@ mkdirty
>>>  va_high_addr_switch
>>>  hugetlb_fault_after_madv
>>>  hugetlb_madv_vs_map
>>> +mseal_test
>>> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
>>> index eb5f39a2668b..95d10fe1b3c1 100644
>>> --- a/tools/testing/selftests/mm/Makefile
>>> +++ b/tools/testing/selftests/mm/Makefile
>>> @@ -59,6 +59,7 @@ TEST_GEN_FILES += mlock2-tests
>>>  TEST_GEN_FILES += mrelease_test
>>>  TEST_GEN_FILES += mremap_dontunmap
>>>  TEST_GEN_FILES += mremap_test
>>> +TEST_GEN_FILES += mseal_test
>>>  TEST_GEN_FILES += on-fault-limit
>>>  TEST_GEN_FILES += pagemap_ioctl
>>>  TEST_GEN_FILES += thuge-gen
>>> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
>>> new file mode 100644
>>> index 000000000000..06c780d1d8e5
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/mm/mseal_test.c
>>> @@ -0,0 +1,1836 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +#define _GNU_SOURCE
>>> +#include <sys/mman.h>
>>
>> I'm afraid this is causing a build error on our CI, and as a result we are not
>> running any mm selftests currently.
>>
>> The error is here:
>>
>>   CC       mseal_test
>> mseal_test.c: In function ‘test_seal_mremap_move_dontunmap’:
>> mseal_test.c:1469:50: error: ‘MREMAP_DONTUNMAP’ undeclared (first use in this
>> function)
>>  1469 |  ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP, 0);
>>       |                                                  ^~~~~~~~~~~~~~~~
>> mseal_test.c:1469:50: note: each undeclared identifier is reported only once for
>> each function it appears in
>> mseal_test.c: In function ‘test_seal_mremap_move_dontunmap_anyaddr’:
>> mseal_test.c:1501:50: error: ‘MREMAP_DONTUNMAP’ undeclared (first use in this
>> function)
>>  1501 |  ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
>>       |                                                  ^~~~~~~~~~~~~~~~
>>
>>
>> And I think the reason is due to our CI's toolchain's sys/mman.h not including
>> linux/mman.h where MREMAP_DONTUNMAP is defined.
>>
>> I think the fix is to explicitly #include <linux/mman.h>, as a number of other
>> mm selftests do.
>>
> When I tried to build with aarch64-linux-gnu-gcc, this passed.
> 
> aarch64-linux-gnu-gcc -I ../../../../usr/include   -DDEBUG -O3
> -DDEBUG -O3 mseal_test.c -o  mseal_test -lm -Wall

Its the same on my local system; I'm told our CI is using GCC 10, which I
suspect makes the difference.

> 
> I don't have the exact environment to repro the issue and verify the fix.
> I will send a patch with  the linux/mman.h.
> 
> I will probably need some help to verify the fix on arm build, Ryan,
> could you help with this ?

I'll pass this on to our CI folks, and hopefully get confirmation shortly.

> 
> Thanks
> -Jeff


