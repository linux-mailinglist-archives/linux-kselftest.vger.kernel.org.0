Return-Path: <linux-kselftest+bounces-33934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E53DFAC6992
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 14:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90787188365A
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 12:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40596214211;
	Wed, 28 May 2025 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ca3jUPPR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D01E3DC8
	for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748436035; cv=none; b=qkP2j2JDU5/Hxk0mukEifu9jwvjltG6/7tY1M1wWyoIQ5h5hKt8Ykf4/Jio5UTJCalHVMbTvN9yI5OO9cM9W0krkaGRUd9Vc6QVvBRiy+926ZrhtYkbqrR/eXKKdTki57PZKk0mIbHXgMrSnpVwktjaMYWEP3L0fsTqz3dV8fP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748436035; c=relaxed/simple;
	bh=R6Q8bbxmM7XeAH6r84bFYbAvGosNvBYeYx6f/gZDfh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZRpm0GxZNKiuw8T6PWVw9/q8Wd1eh6EHGHumBx0YylIOCIgxS4yrD5AqSKL0L3YDv8n1K+SnMc/GwHhmvZXx9VVgtxgf73mArBntrUepNWohS1ZiGrSqeb6DXLsW5cVLBAczQ9k0wSk/Q67ydCY6jBHcUxSppbQHhzeI3k33+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ca3jUPPR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748436032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sj6YN8uQzocnSprVDMhDTbOENg95MZi206LQScKOeos=;
	b=Ca3jUPPR0Jj6c2Y+sU6gu4v6adKPZVxHyIF05ZWSbRhkGQYHje8Y2rGvSLs047uNUeZP/j
	XGmm9C5A19hYWo7XUcvbCiY5Z9SScXPUZ00LPsAohA79LoicaRAwxa429JFSPEB0yDbSGA
	lT0CEFXXmho14vHlE8nJCbDm08rZR1k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-a60RRXmEO8GIdJ9xwR8AgQ-1; Wed, 28 May 2025 08:40:31 -0400
X-MC-Unique: a60RRXmEO8GIdJ9xwR8AgQ-1
X-Mimecast-MFC-AGG-ID: a60RRXmEO8GIdJ9xwR8AgQ_1748436030
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450cb8f8b1bso1598425e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 05:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748436030; x=1749040830;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sj6YN8uQzocnSprVDMhDTbOENg95MZi206LQScKOeos=;
        b=El57zfnFcqJcFhDAvT4DqZGtCTP60JJAR+NRrOpy7OwY9vLN4/dQorJMmlxrwFX+d/
         jh8kCX5/tkUtK5WFw4crobQUwMXOOSRBlsKfF1hjY159Ltr0VF5d+8xwx3SkRGBH7qSp
         tiSs5VnT32QBgKbsz36E3y8kNwFqOP2ewe60DfbBYfPfKWGVzUIu0A3k6UqGilkkPgVs
         woumBHO7Y1ts7yCzJma9fv3KHwq3HyGG29XJD93NtUYd1sxb9onEvFYZsFgtEmumjgfG
         m9vfrqmZ1O9Y5Mvj9VpCLmSJhrMpom5IEAlm0uing/QEFVR4PIOvXhJhj7+w4IISEU5f
         q4ww==
X-Forwarded-Encrypted: i=1; AJvYcCWCsuok346A1nQ5roifhxwvMEPFxDFWPA1sUgCbMuvKeqWT8flFGIM7rL0FL313Zbf/Hc+fRQlrVXAxLpslIeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqMTD/vpCI+4TClp04iyqeFE87k3a8YJCQPBHMkDCMyrPV+iHI
	IZCCRmg+8uqC2f1AzbixABdcWi4NwsSZMjiUhmqY5XmcA2TpQ/Ug1pOLluwZO7AR2QxRwSzFV1T
	338oiIMqYjqJfovSEh9ux39EZHfDqG6wKICmcfJ9vrXizFqSHUr8Rc6S5Y5SMtb07exOlSw==
X-Gm-Gg: ASbGncvQ2NwtZfNDewWqg890pmIiVR25BDOqXbnp499Q/Pl1v0RK1TZeqtQJSXx8o/7
	OArMiXOyuYsgPzucgZFeyQyC44l2WAKlSKHNX6dlikpJiNI/7zivMA4Fsn+kk2OMpyQwv57N212
	7ybvgwq+3NE3zfixpUY9RBPMsJ3kYMA35Hjq6CE2Xa5+CxyqXCoYUMmQBtUfigEO0EQkw+bkgFM
	bvQJMUpiO2pkCDDPDlBEJSSar6IpyDpkezKe0QxMbGFHLzMfZq3g6meULE/OBhjK3AsaVFyeYDT
	0ZlxM2pUhjs2OCGIgFsn+TWOZTUwde+cY93WP5U1e5Ceh+/1nWjmLFv5cbogJxlsswoNrptn2aI
	sywLAvlm/8EFinmxt7Z7L4GMnH1mFsgy8bjfzWic=
X-Received: by 2002:a05:6000:24c8:b0:3a4:e8c5:63a4 with SMTP id ffacd0b85a97d-3a4e8c563edmr2094649f8f.2.1748436029817;
        Wed, 28 May 2025 05:40:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgm9H75SMMwaoX1AG88zdRIO06bzIS23ohM35kMIoSFCm+CMBY4+ge1+xI0xZrIQCAijGB3A==
X-Received: by 2002:a05:6000:24c8:b0:3a4:e8c5:63a4 with SMTP id ffacd0b85a97d-3a4e8c563edmr2094614f8f.2.1748436029321;
        Wed, 28 May 2025 05:40:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36? (p200300d82f30ec008f7e58a4ebf06a36.dip0.t-ipconnect.de. [2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eac8ad8csm1401860f8f.55.2025.05.28.05.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 05:40:28 -0700 (PDT)
Message-ID: <2de2bbdb-f719-4faf-822c-d855f1eb653a@redhat.com>
Date: Wed, 28 May 2025 14:40:27 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mm: add simple VM_PFNMAP tests based on
 mmap'ing /dev/mem
To: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ee8db861-3632-48a1-977d-b05670d9637a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.05.25 12:53, Ryan Roberts wrote:
> On 28/05/2025 11:48, David Hildenbrand wrote:
>> On 28.05.25 12:44, David Hildenbrand wrote:
>>> On 28.05.25 12:34, Ryan Roberts wrote:
>>>> Hi David,
>>>>
>>>>
>>>> On 09/05/2025 16:30, David Hildenbrand wrote:
>>>>> Let's test some basic functionality using /dev/mem. These tests will
>>>>> implicitly cover some PAT (Page Attribute Handling) handling on x86.
>>>>>
>>>>> These tests will only run when /dev/mem access to the first two pages
>>>>> in physical address space is possible and allowed; otherwise, the tests
>>>>> are skipped.
>>>>
>>>> We are seeing really horrible RAS errors with this test when run on arm64 tx2
>>>> machine. Based solely on reviewing the code, I think the problem is that tx2
>>>> doesn't have anything at phys address 0, so test_read_access() is trying to put
>>>> trasactions out to a bad address on the bus.
>>>>
>>>> tx2 /proc/iomem:
>>>>
>>>> $ sudo cat /proc/iomem
>>>> 30000000-37ffffff : PCI ECAM
>>>> 38000000-3fffffff : PCI ECAM
>>>> 40000000-5fffffff : PCI Bus 0000:00
>>>> ...
>>>>
>>>> Whereas my x86 box has some reserved memory:
>>>>
>>>> $ sudo cat /proc/iomem
>>>> 00000000-00000fff : Reserved
>>>> 00001000-0003dfff : System RAM
>>>> ...
>>>>
>>>
>>> A quick fix would be to make this test specific to x86 (the only one I
>>> tested on). We should always have the lower two pages IIRC (BIOS stuff etc).
> 
> I'm not sure how far along this patch is? I'm guessing mm-stable? Perhaps you
> can do the quick fix, then I'd be happy to make this more robust for arm64 later?

Can you give the following a quick test on that machine? Then, I can send it as a
proper patch later.


 From 40fea063f2fcf1474fb47cb9aebdb04fd825032b Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 28 May 2025 14:35:23 +0200
Subject: [PATCH] selftests/mm: two fixes for the pfnmap test

When unregistering the signal handler, we have to pass SIG_DFL, and
blindly reading from PFN 0 and PFN 1 seems to be problematic on !x86
systems. In particularly, on arm64 tx2 machines where noting resides
at these physical memory locations, we can generate RAS errors.

Let's fix it by scanning /proc/iomem for actual "System RAM".

Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Closes: https://lore.kernel.org/all/232960c2-81db-47ca-a337-38c4bce5f997@arm.com/T/#u
Fixes: 2616b370323a ("selftests/mm: add simple VM_PFNMAP tests based on mmap'ing /dev/mem")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  tools/testing/selftests/mm/pfnmap.c | 61 +++++++++++++++++++++++++++--
  1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/pfnmap.c
index 8a9d19b6020c7..4943927a7d1ea 100644
--- a/tools/testing/selftests/mm/pfnmap.c
+++ b/tools/testing/selftests/mm/pfnmap.c
@@ -12,6 +12,8 @@
  #include <stdint.h>
  #include <unistd.h>
  #include <errno.h>
+#include <stdio.h>
+#include <ctype.h>
  #include <fcntl.h>
  #include <signal.h>
  #include <setjmp.h>
@@ -43,14 +45,62 @@ static int test_read_access(char *addr, size_t size, size_t pagesize)
  			/* Force a read that the compiler cannot optimize out. */
  			*((volatile char *)(addr + offs));
  	}
-	if (signal(SIGSEGV, signal_handler) == SIG_ERR)
+	if (signal(SIGSEGV, SIG_DFL) == SIG_ERR)
  		return -EINVAL;
  
  	return ret;
  }
  
+static int find_ram_target(off_t *phys_addr,
+		unsigned long pagesize)
+{
+	unsigned long long start, end;
+	char line[80], *end_ptr;
+	FILE *file;
+
+	/* Search /proc/iomem for the first suitable "System RAM" range. */
+	file = fopen("/proc/iomem", "r");
+	if (!file)
+		return -errno;
+
+	while (fgets(line, sizeof(line), file)) {
+		/* Ignore any child nodes. */
+		if (!isalnum(line[0]))
+			continue;
+
+		if (!strstr(line, "System RAM\n"))
+			continue;
+
+		start = strtoull(line, &end_ptr, 16);
+		/* Skip over the "-" */
+		end_ptr++;
+		/* Make end "exclusive". */
+		end = strtoull(end_ptr, NULL, 16) + 1;
+
+		/* Actual addresses are not exported */
+		if (!start && !end)
+			break;
+
+		/* We need full pages. */
+		start = (start + pagesize - 1) & ~(pagesize - 1);
+		end &= ~(pagesize - 1);
+
+		if (start != (off_t)start)
+			break;
+
+		/* We need two pages. */
+		if (end > start + 2 * pagesize) {
+			fclose(file);
+			*phys_addr = start;
+			return 0;
+		}
+	}
+	return -ENOENT;
+}
+
  FIXTURE(pfnmap)
  {
+	off_t phys_addr;
  	size_t pagesize;
  	int dev_mem_fd;
  	char *addr1;
@@ -63,14 +113,17 @@ FIXTURE_SETUP(pfnmap)
  {
  	self->pagesize = getpagesize();
  
+	/* We'll require two physical pages throughout our tests ... */
+	if (find_ram_target(&self->phys_addr, self->pagesize))
+		SKIP(return, "Cannot find ram target in '/dev/iomem'\n");
+
  	self->dev_mem_fd = open("/dev/mem", O_RDONLY);
  	if (self->dev_mem_fd < 0)
  		SKIP(return, "Cannot open '/dev/mem'\n");
  
-	/* We'll require the first two pages throughout our tests ... */
  	self->size1 = self->pagesize * 2;
  	self->addr1 = mmap(NULL, self->size1, PROT_READ, MAP_SHARED,
-			   self->dev_mem_fd, 0);
+			   self->dev_mem_fd, self->phys_addr);
  	if (self->addr1 == MAP_FAILED)
  		SKIP(return, "Cannot mmap '/dev/mem'\n");
  
@@ -129,7 +182,7 @@ TEST_F(pfnmap, munmap_split)
  	 */
  	self->size2 = self->pagesize;
  	self->addr2 = mmap(NULL, self->pagesize, PROT_READ, MAP_SHARED,
-			   self->dev_mem_fd, 0);
+			   self->dev_mem_fd, self->phys_addr);
  	ASSERT_NE(self->addr2, MAP_FAILED);
  }
  
-- 
2.49.0


-- 
Cheers,

David / dhildenb


