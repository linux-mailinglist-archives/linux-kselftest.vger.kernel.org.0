Return-Path: <linux-kselftest+bounces-33937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4630CAC6ADA
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 15:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8181BA2D19
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 13:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B008288514;
	Wed, 28 May 2025 13:44:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CE43D561;
	Wed, 28 May 2025 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748439856; cv=none; b=h3tXLAJWVfW1P03+dhUb0QmIZO/7T9xy3U7eWyXWhqu2vzNZg3lK0fy847c8IeRx5AOLYpnc553xr5w/C5bBdNXyc+J23L4JXBt96vmIbg4SZlhDgJH4aUUhFRlWfT6H2VqZeJJwM9G1zByoJOXrp25D2L0UwqxhLA/lvrnHr50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748439856; c=relaxed/simple;
	bh=ssEvzcF1KEh4FgwJ6vegA4MuX2MBgaNAln+EWkDI8pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7NS4LsgOEljA8YO08fVjFCu1F5E/zNSpkQ4HyUragobsx7dJeNAWZLmtqeN4daiVj4J8vCAJoOVyzLRAT+dNuDF5OM9QBvTdZnfH0xH78kWM8/HxXb4xIZ6Um/xKrrQ6MkznsI8WJtqJ2uRHk7ixrwHMEw9Fw2rmW99acgA4k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 112811A2D;
	Wed, 28 May 2025 06:43:57 -0700 (PDT)
Received: from [10.57.94.142] (unknown [10.57.94.142])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 071D93F5A1;
	Wed, 28 May 2025 06:44:11 -0700 (PDT)
Message-ID: <7df6ecb7-0aa8-4f18-ba8a-ce6d095cbd42@arm.com>
Date: Wed, 28 May 2025 14:44:10 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mm: add simple VM_PFNMAP tests based on
 mmap'ing /dev/mem
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Xu <peterx@redhat.com>, Dev Jain
 <dev.jain@arm.com>, Aishwarya TCV <Aishwarya.TCV@arm.com>
References: <20250509153033.952746-1-david@redhat.com>
 <232960c2-81db-47ca-a337-38c4bce5f997@arm.com>
 <7cb7f23a-ce9e-4664-8083-deb73ed23da3@redhat.com>
 <3c15a093-7c19-4c2a-a571-56a5ed4b445f@redhat.com>
 <ee8db861-3632-48a1-977d-b05670d9637a@arm.com>
 <2de2bbdb-f719-4faf-822c-d855f1eb653a@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <2de2bbdb-f719-4faf-822c-d855f1eb653a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/05/2025 13:40, David Hildenbrand wrote:
> On 28.05.25 12:53, Ryan Roberts wrote:
>> On 28/05/2025 11:48, David Hildenbrand wrote:
>>> On 28.05.25 12:44, David Hildenbrand wrote:
>>>> On 28.05.25 12:34, Ryan Roberts wrote:
>>>>> Hi David,
>>>>>
>>>>>
>>>>> On 09/05/2025 16:30, David Hildenbrand wrote:
>>>>>> Let's test some basic functionality using /dev/mem. These tests will
>>>>>> implicitly cover some PAT (Page Attribute Handling) handling on x86.
>>>>>>
>>>>>> These tests will only run when /dev/mem access to the first two pages
>>>>>> in physical address space is possible and allowed; otherwise, the tests
>>>>>> are skipped.
>>>>>
>>>>> We are seeing really horrible RAS errors with this test when run on arm64 tx2
>>>>> machine. Based solely on reviewing the code, I think the problem is that tx2
>>>>> doesn't have anything at phys address 0, so test_read_access() is trying to
>>>>> put
>>>>> trasactions out to a bad address on the bus.
>>>>>
>>>>> tx2 /proc/iomem:
>>>>>
>>>>> $ sudo cat /proc/iomem
>>>>> 30000000-37ffffff : PCI ECAM
>>>>> 38000000-3fffffff : PCI ECAM
>>>>> 40000000-5fffffff : PCI Bus 0000:00
>>>>> ...
>>>>>
>>>>> Whereas my x86 box has some reserved memory:
>>>>>
>>>>> $ sudo cat /proc/iomem
>>>>> 00000000-00000fff : Reserved
>>>>> 00001000-0003dfff : System RAM
>>>>> ...
>>>>>
>>>>
>>>> A quick fix would be to make this test specific to x86 (the only one I
>>>> tested on). We should always have the lower two pages IIRC (BIOS stuff etc).
>>
>> I'm not sure how far along this patch is? I'm guessing mm-stable? Perhaps you
>> can do the quick fix, then I'd be happy to make this more robust for arm64 later?
> 
> Can you give the following a quick test on that machine? Then, I can send it as a
> proper patch later.

The machine in question is part of our CI infra, so not easy for me to run an
ad-hoc test. I've asked Aishwarya if it's possible to queue up a CI job with the
patch, but that will involve running the whole test run I think, so probably
will take a couple of days to turn around.

FWIW, the change looks good to me:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> 
> 
> From 40fea063f2fcf1474fb47cb9aebdb04fd825032b Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Wed, 28 May 2025 14:35:23 +0200
> Subject: [PATCH] selftests/mm: two fixes for the pfnmap test
> 
> When unregistering the signal handler, we have to pass SIG_DFL, and
> blindly reading from PFN 0 and PFN 1 seems to be problematic on !x86
> systems. In particularly, on arm64 tx2 machines where noting resides
> at these physical memory locations, we can generate RAS errors.
> 
> Let's fix it by scanning /proc/iomem for actual "System RAM".
> 
> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
> Closes: https://lore.kernel.org/all/232960c2-81db-47ca-
> a337-38c4bce5f997@arm.com/T/#u
> Fixes: 2616b370323a ("selftests/mm: add simple VM_PFNMAP tests based on
> mmap'ing /dev/mem")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  tools/testing/selftests/mm/pfnmap.c | 61 +++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/
> pfnmap.c
> index 8a9d19b6020c7..4943927a7d1ea 100644
> --- a/tools/testing/selftests/mm/pfnmap.c
> +++ b/tools/testing/selftests/mm/pfnmap.c
> @@ -12,6 +12,8 @@
>  #include <stdint.h>
>  #include <unistd.h>
>  #include <errno.h>
> +#include <stdio.h>
> +#include <ctype.h>
>  #include <fcntl.h>
>  #include <signal.h>
>  #include <setjmp.h>
> @@ -43,14 +45,62 @@ static int test_read_access(char *addr, size_t size, size_t
> pagesize)
>              /* Force a read that the compiler cannot optimize out. */
>              *((volatile char *)(addr + offs));
>      }
> -    if (signal(SIGSEGV, signal_handler) == SIG_ERR)
> +    if (signal(SIGSEGV, SIG_DFL) == SIG_ERR)
>          return -EINVAL;
>  
>      return ret;
>  }
>  
> +static int find_ram_target(off_t *phys_addr,
> +        unsigned long pagesize)
> +{
> +    unsigned long long start, end;
> +    char line[80], *end_ptr;
> +    FILE *file;
> +
> +    /* Search /proc/iomem for the first suitable "System RAM" range. */
> +    file = fopen("/proc/iomem", "r");
> +    if (!file)
> +        return -errno;
> +
> +    while (fgets(line, sizeof(line), file)) {
> +        /* Ignore any child nodes. */
> +        if (!isalnum(line[0]))
> +            continue;
> +
> +        if (!strstr(line, "System RAM\n"))
> +            continue;
> +
> +        start = strtoull(line, &end_ptr, 16);
> +        /* Skip over the "-" */
> +        end_ptr++;
> +        /* Make end "exclusive". */
> +        end = strtoull(end_ptr, NULL, 16) + 1;
> +
> +        /* Actual addresses are not exported */
> +        if (!start && !end)
> +            break;
> +
> +        /* We need full pages. */
> +        start = (start + pagesize - 1) & ~(pagesize - 1);
> +        end &= ~(pagesize - 1);
> +
> +        if (start != (off_t)start)
> +            break;
> +
> +        /* We need two pages. */
> +        if (end > start + 2 * pagesize) {
> +            fclose(file);
> +            *phys_addr = start;
> +            return 0;
> +        }
> +    }
> +    return -ENOENT;
> +}
> +
>  FIXTURE(pfnmap)
>  {
> +    off_t phys_addr;
>      size_t pagesize;
>      int dev_mem_fd;
>      char *addr1;
> @@ -63,14 +113,17 @@ FIXTURE_SETUP(pfnmap)
>  {
>      self->pagesize = getpagesize();
>  
> +    /* We'll require two physical pages throughout our tests ... */
> +    if (find_ram_target(&self->phys_addr, self->pagesize))
> +        SKIP(return, "Cannot find ram target in '/dev/iomem'\n");
> +
>      self->dev_mem_fd = open("/dev/mem", O_RDONLY);
>      if (self->dev_mem_fd < 0)
>          SKIP(return, "Cannot open '/dev/mem'\n");
>  
> -    /* We'll require the first two pages throughout our tests ... */
>      self->size1 = self->pagesize * 2;
>      self->addr1 = mmap(NULL, self->size1, PROT_READ, MAP_SHARED,
> -               self->dev_mem_fd, 0);
> +               self->dev_mem_fd, self->phys_addr);
>      if (self->addr1 == MAP_FAILED)
>          SKIP(return, "Cannot mmap '/dev/mem'\n");
>  
> @@ -129,7 +182,7 @@ TEST_F(pfnmap, munmap_split)
>       */
>      self->size2 = self->pagesize;
>      self->addr2 = mmap(NULL, self->pagesize, PROT_READ, MAP_SHARED,
> -               self->dev_mem_fd, 0);
> +               self->dev_mem_fd, self->phys_addr);
>      ASSERT_NE(self->addr2, MAP_FAILED);
>  }
>  


