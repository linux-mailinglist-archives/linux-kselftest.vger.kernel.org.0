Return-Path: <linux-kselftest+bounces-20155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E419A43CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 18:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE87282D3B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 16:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAC82022F5;
	Fri, 18 Oct 2024 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H+/zmRRV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABDA2036F2
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268762; cv=none; b=bqCWenwsOSnxH+kXC4930KXkFCh7fUhj3Y9eWyZ7KCG+ngX0kO+0HEbTLNugzyObu8dgLrZZXp0ymAcVOGFhSI9n/poDS1RiYrQlaQX7uWa+hbVTh21HEl2mZ1qpwTza7XOjxbfvpEbz55zA8BhqfUWVf35bSDEgmtnVZKrD8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268762; c=relaxed/simple;
	bh=5jbP6qgUgoq1McrR3RLDeRE04owyYxOG4RL62eRi/S0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0qNe5sDVMMnw14gnfhpwJt81MdmSjSgLpKqLloCXrjDII64LJfNsG37HvqBbl5MMJCRKssNN/B2nxjcojkPqULM4z4wMasrf4Ugv/wJUKlSavtUV9LVTNFMTUln55UdTZPu+0AyqBtEJrcIsiQnsDLr5pHFh++Ada/RxDRtx8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H+/zmRRV; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-286f0dcead5so1980452fac.0
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 09:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729268758; x=1729873558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P4qNWvLVpxYbIRtwTadaIjM03ETyiiYE+F1EJeQJjHY=;
        b=H+/zmRRV8q4r4+UlnQN+A0sP2z3gWgJIB1zMRgg6lSVwQDwtf4E85CCQQQpAg5ByQZ
         syk1Lhzseqd9xZSU4/I/HS2vk/XrXimgUu6t+n555D68Yz7svJcvHY1nTQOyg+tYj36k
         YsPJaR6eYmdifwgngf3DaWrxI6vYfn+aABy5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729268758; x=1729873558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4qNWvLVpxYbIRtwTadaIjM03ETyiiYE+F1EJeQJjHY=;
        b=rK9cbCBuTnn0IOt85+OYen1ZKIBtsT9NuQu2hHyoOwacDbYlql5/n30B9BoBKDHgV6
         Kb1clDkZWbGyJu2/un0miPO7VgaOCI0giWhViQs31/rhCsAEwBRU06zs8xj32r4LoJ4/
         SXbL8obsVwiQgmjatEsGUqKfiTus6lK/+rN+rZXK+5ztf9fwukX8E5qBFJtXSc14C/v+
         b5RaCNtnKJg0vD1s0z3afQNBnT+3ZFO+I0+jdk/2bNoso0CcLFirnNCleJqfveIGslC5
         dKvlqknlcsVsOrnZKvi1+Xruwk+XJJxWCdEO5fuNzlwUvTBZkYVVeoDtCImFI5R6c1Ji
         fL8w==
X-Forwarded-Encrypted: i=1; AJvYcCWaTsr5UqPMTYqzCrVtREUfaFeTz1m3QGbvQdeDNPXTp+E7Q9q/VopPyFZv50Bj3HJOhLVVuHGNsrU5vhUUj6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymb69MvChywdEfLHWtGt4k1xhwaeldBfEBUoVrEfupyLMdZnDG
	+Cr7IlbMxkhOvB5qMv5Zzu3YAneyCvT98YBo6IG61sPKqgwsE4XdHB+mkker5yI=
X-Google-Smtp-Source: AGHT+IGaroc9U1gTQH8oIv9XintQoQrlC7c5FvJNC3/Om1CneZ+0NGXExK3IjmCzNnhwYO6jdZ3JsA==
X-Received: by 2002:a05:6870:d60e:b0:288:aed8:c43d with SMTP id 586e51a60fabf-2890cf88610mr4183890fac.15.1729268758143;
        Fri, 18 Oct 2024 09:25:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-718195da5f0sm377033a34.60.2024.10.18.09.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 09:25:57 -0700 (PDT)
Message-ID: <3a41a1b5-e9a7-43db-b50e-84d6cc275d10@linuxfoundation.org>
Date: Fri, 18 Oct 2024 10:25:55 -0600
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
Content-Transfer-Encoding: 7bit

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

This is not the only comment I gave you in this patch and your
other patches.

thanks,
-- Shuah


