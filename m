Return-Path: <linux-kselftest+bounces-20154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C049A43BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 18:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678DC1F24AE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 16:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB15F2038AF;
	Fri, 18 Oct 2024 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NEHd19DV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F332022F5
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268671; cv=none; b=VxtZTb+tJmI4kwKmCZs/11X45f6SJU4jdf46QOcw/9wFj+IRKG/QdA1s/2lzcqLht28/spu6MEO7i/CwrgRp+i5Vn3x88dDG9UIy9eK7MxxhK1XEmgj9HOWh81EBLr3BffIlO8lY9bPOSIBjmpq9KIPMX12Nc25QdoSog1/HB7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268671; c=relaxed/simple;
	bh=iWxiwdG2p0Ia/g/Q7KCJatv1Xb46S2nFuXqxm0WqkKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JohGuB8xGIuu4Rpge8hJ8iL8ISmBhNQ4TR5PTxrVfQmNy8LX7qulM5L6cRJjU+JuKCUZ1VJqx+KwewRNX2eT3KTEEwIJy5cCSiGxWzVGFq/LuR454SO7e36LgY0+K9pksJdU0AoeaabRFm14GOJ+pAESH1eQLNgcDxQJZghWbuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NEHd19DV; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71811c7eb8dso781299a34.0
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 09:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729268668; x=1729873468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F3v+T7PjpPKYcorK84vLoRIziLno8dgMRinbwlPayfE=;
        b=NEHd19DVCC+91om/KDc6/DtsOHXxxhSn2fZUUeH4mtp4BCX4WlrGa0fdoKvmR0gUW7
         aSLR0TIFOqdRGcylJv0/qr3YYxWNil/j8sG1rVxH+H9vynocQoQDJxeF+gK1hrxCmFzC
         S9t3h3q0Z9gdBcYw4A2xEzyQdVgMx9ea8+WBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729268668; x=1729873468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3v+T7PjpPKYcorK84vLoRIziLno8dgMRinbwlPayfE=;
        b=PPZ2jZIsvDfLgmdZ0k7QASoxBh4oDjMWu6H0PGxrZPwAPMcK9ByTCG7eX0cObjEKsL
         qWR3Zg4fCdGr/RUQwIXQedNUs5QoPHQWDr2iwSuD+XVD0OJsskav1IyvXwQ1Cq9yUehJ
         OAo5Ah+IHQCWjF4prr/wcrvgm+XYpK/IUg1t1AipeZdpQYDaZ+dZ1RFYvBIM5bEa7thE
         ynVq5bvjelJNcFolRhyJuehuoIJM+r/hkR9HOfHR7BOqpzD8qCJoGgcxsO6wWsrGF2bP
         fy0QKj4aJYgsc3KB1UnfSwJ7Q/u2bLWHVoGVUNGN8Hp/pm20T4qhRXH6eSZmVCK9y/Wa
         CExg==
X-Forwarded-Encrypted: i=1; AJvYcCWKj8fmqGBuAyUL+Q/bSJREw0I4JCsJtKSAcyj+vvo7o4xOTLdBaFI82CQczhywF5gV8JKv42kf+4gh+0XBLlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJuWhUVSzRERG58plgXpZ5l1h401evF4iDxSJ/f1Fh0U1P6IPX
	X2Dy5leiFo5YR4v17grRtSx0jrwRqpFn5YJBcViCuaKgJwD3AjQVoHr9QfrCvd4=
X-Google-Smtp-Source: AGHT+IFIMl2GQFcOD4CAePzrCdIz3Ij+s6w3yxltIlvjQyisZktPRrklsesyLhvGbRcpIU0+2bu3ig==
X-Received: by 2002:a05:6830:348a:b0:717:fb12:2c2 with SMTP id 46e09a7af769-7181a5c6046mr2826059a34.3.1729268667921;
        Fri, 18 Oct 2024 09:24:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-718195da4d0sm376406a34.56.2024.10.18.09.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 09:24:27 -0700 (PDT)
Message-ID: <40ca64d7-c8c9-47b1-ac17-95524bd76aa6@linuxfoundation.org>
Date: Fri, 18 Oct 2024 10:24:25 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests/mm: add self tests for guard page feature
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-kselftest@vger.kernel.org, Sidhartha Kumar
 <sidhartha.kumar@oracle.com>, Jeff Xu <jeffxu@chromium.org>,
 Christoph Hellwig <hch@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1729196871.git.lorenzo.stoakes@oracle.com>
 <8b1add3c511effb62d68183cae8a954d8339286c.1729196871.git.lorenzo.stoakes@oracle.com>
 <1d0bbc60-fda7-4c14-bf02-948bdbf8f029@linuxfoundation.org>
 <dfbf9ccb-6834-4181-a382-35c9c9af8064@lucifer.local>
 <22d386cd-e62f-43f9-905e-2d0881781abe@linuxfoundation.org>
 <7bbfc635-8d42-4c3d-8808-cb060cd9f658@lucifer.local>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <7bbfc635-8d42-4c3d-8808-cb060cd9f658@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/18/24 10:07, Lorenzo Stoakes wrote:
> On Fri, Oct 18, 2024 at 09:32:17AM -0600, Shuah Khan wrote:
>> On 10/18/24 01:12, Lorenzo Stoakes wrote:
>>> On Thu, Oct 17, 2024 at 03:24:49PM -0600, Shuah Khan wrote:
>>>> On 10/17/24 14:42, Lorenzo Stoakes wrote:
>>>>> Utilise the kselftest harmness to implement tests for the guard page
>>>>
>>>> Splleing NIT - harmness -> harness
>>>>
>>>>> implementation.
>>>>>
>>>>> We start by implement basic tests asserting that guard pages can be
>>>>
>>>> implmenting? By the way checkpatch will catch spelling stuuf.
>>>> Please see comments about warnings below.
>>>
>>> Thanks. The majority of the checkpatch warnings are invalid so I missed
>>> this. Will fix on respin.
>>>
>>>>
>>>>> established (poisoned), cleared (remedied) and that touching poisoned pages
>>>>> result in SIGSEGV. We also assert that, in remedying a range, non-poison
>>>>> pages remain intact.
>>>>>
>>>>> We then examine different operations on regions containing poison markers
>>>>> behave to ensure correct behaviour:
>>>>>
>>>>> * Operations over multiple VMAs operate as expected.
>>>>> * Invoking MADV_GUARD_POISION / MADV_GUARD_REMEDY via process_madvise() in
>>>>>      batches works correctly.
>>>>> * Ensuring that munmap() correctly tears down poison markers.
>>>>> * Using mprotect() to adjust protection bits does not in any way override
>>>>>      or cause issues with poison markers.
>>>>> * Ensuring that splitting and merging VMAs around poison markers causes no
>>>>>      issue - i.e. that a marker which 'belongs' to one VMA can function just
>>>>>      as well 'belonging' to another.
>>>>> * Ensuring that madvise(..., MADV_DONTNEED) does not remove poison markers.
>>>>> * Ensuring that mlock()'ing a range containing poison markers does not
>>>>>      cause issues.
>>>>> * Ensuring that mremap() can move a poisoned range and retain poison
>>>>>      markers.
>>>>> * Ensuring that mremap() can expand a poisoned range and retain poison
>>>>>      markers (perhaps moving the range).
>>>>> * Ensuring that mremap() can shrink a poisoned range and retain poison
>>>>>      markers.
>>>>> * Ensuring that forking a process correctly retains poison markers.
>>>>> * Ensuring that forking a VMA with VM_WIPEONFORK set behaves sanely.
>>>>> * Ensuring that lazyfree simply clears poison markers.
>>>>> * Ensuring that userfaultfd can co-exist with guard pages.
>>>>> * Ensuring that madvise(..., MADV_POPULATE_READ) and
>>>>>      madvise(..., MADV_POPULATE_WRITE) error out when encountering
>>>>>      poison markers.
>>>>> * Ensuring that madvise(..., MADV_COLD) and madvise(..., MADV_PAGEOUT) do
>>>>>      not remove poison markers.
>>>>
>>>> Good summary of test. Does the test require root access?
>>>> If so does it check and skip appropriately?
>>>
>>> Thanks and some do, in those cases we skip.
>>>
>>>>
>>>>>
>>>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>>> ---
>>>>>     tools/testing/selftests/mm/.gitignore    |    1 +
>>>>>     tools/testing/selftests/mm/Makefile      |    1 +
>>>>>     tools/testing/selftests/mm/guard-pages.c | 1168 ++++++++++++++++++++++
>>>>>     3 files changed, 1170 insertions(+)
>>>>>     create mode 100644 tools/testing/selftests/mm/guard-pages.c
>>>>>
>>>>> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
>>>>> index 689bbd520296..8f01f4da1c0d 100644
>>>>> --- a/tools/testing/selftests/mm/.gitignore
>>>>> +++ b/tools/testing/selftests/mm/.gitignore
>>>>> @@ -54,3 +54,4 @@ droppable
>>>>>     hugetlb_dio
>>>>>     pkey_sighandler_tests_32
>>>>>     pkey_sighandler_tests_64
>>>>> +guard-pages
>>>>> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
>>>>> index 02e1204971b0..15c734d6cfec 100644
>>>>> --- a/tools/testing/selftests/mm/Makefile
>>>>> +++ b/tools/testing/selftests/mm/Makefile
>>>>> @@ -79,6 +79,7 @@ TEST_GEN_FILES += hugetlb_fault_after_madv
>>>>>     TEST_GEN_FILES += hugetlb_madv_vs_map
>>>>>     TEST_GEN_FILES += hugetlb_dio
>>>>>     TEST_GEN_FILES += droppable
>>>>> +TEST_GEN_FILES += guard-pages
>>>>>     ifneq ($(ARCH),arm64)
>>>>>     TEST_GEN_FILES += soft-dirty
>>>>> diff --git a/tools/testing/selftests/mm/guard-pages.c b/tools/testing/selftests/mm/guard-pages.c
>>>>> new file mode 100644
>>>>> index 000000000000..2ab0ff3ba5a0
>>>>> --- /dev/null
>>>>> +++ b/tools/testing/selftests/mm/guard-pages.c
>>>>> @@ -0,0 +1,1168 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>>> +
>>>>> +#define _GNU_SOURCE
>>>>> +#include "../kselftest_harness.h"
>>>>> +#include <assert.h>
>>>>> +#include <fcntl.h>
>>>>> +#include <setjmp.h>
>>>>> +#include <errno.h>
>>>>> +#include <linux/userfaultfd.h>
>>>>> +#include <signal.h>
>>>>> +#include <stdbool.h>
>>>>> +#include <stdio.h>
>>>>> +#include <stdlib.h>
>>>>> +#include <string.h>
>>>>> +#include <sys/ioctl.h>
>>>>> +#include <sys/mman.h>
>>>>> +#include <sys/syscall.h>
>>>>> +#include <sys/uio.h>
>>>>> +#include <unistd.h>
>>>>> +
>>>>> +/* These may not yet be available in the uAPI so define if not. */
>>>>> +
>>>>> +#ifndef MADV_GUARD_POISON
>>>>> +#define MADV_GUARD_POISON	102
>>>>> +#endif
>>>>> +
>>>>> +#ifndef MADV_GUARD_UNPOISON
>>>>> +#define MADV_GUARD_UNPOISON	103
>>>>> +#endif
>>>>> +
>>>>> +volatile bool signal_jump_set;
>>>>
>>>> Can you add a comment about why volatile is needed.
>>>
>>> I'm not sure it's really necessary, it's completely standard to do this
>>> with signal handling and is one of the exceptions to the 'volatile
>>> considered harmful' rule.
>>>
>>>> By the way did you happen to run checkpatck on this. There are
>>>> several instances where single statement blocks with braces {}
>>>>
>>>> I noticed a few and ran checkpatch on your patch. There are
>>>> 45 warnings regarding codeing style.
>>>>
>>>> Please run checkpatch and clean them up so we can avoid followup
>>>> checkpatch cleanup patches.
>>>
>>> No sorry I won't, checkpatch isn't infallible and series trying to 'clean
>>> up' things that aren't issues will be a waste of everybody's time.
>>>
>>
>> Sorry - this violates the coding styles and makes it hard to read.
>>
>> See process/coding-style.rst:
>>
>> Do not unnecessarily use braces where a single statement will do.
>>
>> .. code-block:: c
>>
>>          if (condition)
>>                  action();
>>
>> and
>>
>> .. code-block:: c
>>
>>          if (condition)
>>                  do_this();
>>          else
>>                  do_that();
>>
>> This does not apply if only one branch of a conditional statement is a single
>> statement; in the latter case use braces in both branches:
>>
>> .. code-block:: c
>>
>>          if (condition) {
>>                  do_this();
>>                  do_that();
>>          } else {
>>                  otherwise();
>>          }
>>
>> Also, use braces when a loop contains more than a single simple statement:
>>
>> .. code-block:: c
>>
>>          while (condition) {
>>                  if (test)
>>                          do_something();
>>          }
>>
>> thanks,
>> -- Shuah
> 
> Shuah, quoting coding standards to an experienced kernel developer
> (maintainer now) is maybe not the best way to engage here + it may have
> been more productive for you to first engage on why it is I'm deviating
> here.
> 
> Firstly, as I said, the code _does not compile_ if I do not use braces in
> many cases. This is probably an issue with the macros, but it is out of
> scope for this series for me to fix that.

I am not trying to throw the book at you. When I see 45 of
them I have to ask the reasons why.

> 
> 'Fixing' these cases results in:
> 
>    CC       guard-pages
> guard-pages.c: In function ‘guard_pages_split_merge’:
> guard-pages.c:566:17: error: ‘else’ without a previous ‘if’
>    566 |                 else
>        |                 ^~~~
> guard-pages.c: In function ‘guard_pages_dontneed’:
> guard-pages.c:666:17: error: ‘else’ without a previous ‘if’
>    666 |                 else
>        |                 ^~~~
> guard-pages.c: In function ‘guard_pages_fork’:
> guard-pages.c:957:17: error: ‘else’ without a previous ‘if’
>    957 |                 else
>        |                 ^~~~
> guard-pages.c: In function ‘guard_pages_fork_wipeonfork’:
> guard-pages.c:1010:17: error: ‘else’ without a previous ‘if’
>   1010 |                 else
>        |                 ^~~~
> 
> In other cases I am simply not a fan of single line loops where there is a
> lot of compound stuff going on:
> 
> 	for (i = 0; i < 10; i++) {
> 		ASSERT_FALSE(try_read_write_buf(&ptr1[i * page_size]));
> 	}
> 
> vs.
> 
> 	for (i = 0; i < 10; i++)
> 		ASSERT_FALSE(try_read_write_buf(&ptr1[i * page_size]));
> 
> When there are very many loops like this. This is kind of a test-specific
> thing, you'd maybe put more effort into splitting this up + have less
> repetition in non-test code.
> 
> I'm not going to die on the hill of single-line-for-loops though, so if you
> insist I'll change those.
> 
> However I simply _cannot_ change the if/else blocks that cause compilation
> errors.
> 
> This is what I mean about checkpatch being fallible. It's also fallible in
> other cases, like variable declarations via macro (understandably).
> 
> Expecting checkpatch to give zero warnings is simply unattainable,
> unfortunately.
> 
> As you seem adamant about strict adherence to checkpatch, and I always try
> to be accommodating where I can be, I suggest I fix everything _except
> where it breaks the compilation_ does that work for you?

Yes Please. If you leave these in here as soon as the patch hits
next, we start seeing a flood of patches. It becomes harder to fix
these later due to merge conflicts.

It becomes a patch overload issue. Yes I would like to see the ones
that don't result in compile errors fixed.

thanks,
-- Shuah

> 
> Thanks.


