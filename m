Return-Path: <linux-kselftest+bounces-48743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 189FDD12957
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 13:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E53130574CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 12:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A2B357A49;
	Mon, 12 Jan 2026 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Gn9sgPDM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816DE357A39;
	Mon, 12 Jan 2026 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768221863; cv=none; b=H2OcAeqOTKfgem20sFGokUQXdrCvWUs9KDqoOTTS6Rb8xl66VjpT07q4C0yhhO8H2ucaEArsQHHDdUlnp6k4QQxBoTdsHWYTnetwoSKI2xh5qrpP5ldEPIv/MACR1Ao7UxZ6fy3mUl6b61DBTXjWCzKIG9swply5W9FrQXuCPPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768221863; c=relaxed/simple;
	bh=s0iQagkhLJMFUg2Zx/Y6QCc3ESwUoeWsGJCdZDpKQHA=;
	h=Subject:From:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=euz9AfJapmzCMGc9iY+LgjVAbJT4enjrCeKK/kqGSTPKQm7hZFO+HEra+7g+PQWNN17BfzX2nn3qfCj4k2yb26H7KH8nQqVyPaKIgNkDlgnLloeN2kRigUk8wUsLcVAUIAaT7GGuG8IR90HJ69JsD5KuDq4iRmnsmnq7uJsfX2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Gn9sgPDM; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=s0iQagkhLJMFUg2Zx/Y6QCc3ESwUoeWsGJCdZDpKQHA=;
	b=Gn9sgPDMy5jrw6VYcQISMYC0dpUMKp7RohF0dA7k3ltqZORpqFIRxvmw4GMnbm2kYZwpa5KHs
	ViQG3ZuFrFpsNXOJbZRb5RRlDDeFyBg7NX2u8to/SzZTeBpoiCCE9Zbp0UwDKY/H70m2JxKX+hG
	82dHj449yocmt8K8yaHUucA=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dqX6h3Qr6z1cyPY;
	Mon, 12 Jan 2026 20:41:00 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 7137040363;
	Mon, 12 Jan 2026 20:44:18 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 Jan 2026 20:44:18 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 Jan 2026 20:44:17 +0800
Subject: Re: [PATCH 0/3] selftests/mm: add memory failure selftests
From: Miaohe Lin <linmiaohe@huawei.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
CC: <lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<nao.horiguchi@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<akpm@linux-foundation.org>, <shuah@kernel.org>
References: <20260107093710.3928374-1-linmiaohe@huawei.com>
 <9413a995-9182-493e-a28a-6d2d3a17236b@kernel.org>
 <2ae04380-fd60-a8a1-6217-386454fec610@huawei.com>
 <693dc9aa-cf86-48c7-be9c-ec554f9da855@kernel.org>
 <d958d80a-8412-6107-e144-975b8d545568@huawei.com>
Message-ID: <b258b6c0-7af1-4443-bd81-2722dec610f7@huawei.com>
Date: Mon, 12 Jan 2026 20:44:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d958d80a-8412-6107-e144-975b8d545568@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/1/12 19:33, Miaohe Lin wrote:
> On 2026/1/12 17:40, David Hildenbrand (Red Hat) wrote:
>> On 1/12/26 10:19, Miaohe Lin wrote:
>>> On 2026/1/9 21:45, David Hildenbrand (Red Hat) wrote:
>>>> On 1/7/26 10:37, Miaohe Lin wrote:
>>>>> Introduce selftests to validate the functionality of memory failure.
>>>>> These tests help ensure that memory failure handling for anonymous
>>>>> pages, pagecaches pages works correctly, including proper SIGBUS
>>>>> delivery to user processes, page isolation, and recovery paths.
>>>>>
>>>>> Currently madvise syscall is used to inject memory failures. And only
>>>>> anonymous pages and pagecaches are tested. More test scenarios, e.g.
>>>>> hugetlb, shmem, thp, will be added. Also more memory failure injecting
>>>>> methods will be supported, e.g. APEI Error INJection, if required.
>>>>
>>>
>>> Thanks for test and report. :)
>>>
>>>> 0day reports that these tests fail:
>>>>
>>>> # # ------------------------
>>>> # # running ./memory-failure
>>>> # # ------------------------
>>>> # # TAP version 13
>>>> # # 1..6
>>>> # # # Starting 6 tests from 2 test cases.
>>>> # # #  RUN           memory_failure.madv_hard.anon ...
>>>> # # #            OK  memory_failure.madv_hard.anon
>>>> # # ok 1 memory_failure.madv_hard.anon
>>>> # # #  RUN           memory_failure.madv_hard.clean_pagecache ...
>>>> # # # memory-failure.c:166:clean_pagecache:Expected setjmp (1) == 0 (0)
>>>> # # # clean_pagecache: Test terminated by assertion
>>>> # # #          FAIL  memory_failure.madv_hard.clean_pagecache
>>>> # # not ok 2 memory_failure.madv_hard.clean_pagecache
>>>> # # #  RUN           memory_failure.madv_hard.dirty_pagecache ...
>>>> # # # memory-failure.c:207:dirty_pagecache:Expected unpoison_memory(self->pfn) (-16) == 0 (0)
>>>> # # # dirty_pagecache: Test terminated by assertion
>>>> # # #          FAIL  memory_failure.madv_hard.dirty_pagecache
>>>> # # not ok 3 memory_failure.madv_hard.dirty_pagecache
>>>> # # #  RUN           memory_failure.madv_soft.anon ...
>>>> # # #            OK  memory_failure.madv_soft.anon
>>>> # # ok 4 memory_failure.madv_soft.anon
>>>> # # #  RUN           memory_failure.madv_soft.clean_pagecache ...
>>>> # # # memory-failure.c:282:clean_pagecache:Expected variant->inject(self, addr) (-1) == 0 (0)
>>>> # # # clean_pagecache: Test terminated by assertion
>>>> # # #          FAIL  memory_failure.madv_soft.clean_pagecache
>>>> # # not ok 5 memory_failure.madv_soft.clean_pagecache
>>>> # # #  RUN           memory_failure.madv_soft.dirty_pagecache ...
>>>> # # # memory-failure.c:319:dirty_pagecache:Expected variant->inject(self, addr) (-1) == 0 (0)
>>>> # # # dirty_pagecache: Test terminated by assertion
>>>> # # #          FAIL  memory_failure.madv_soft.dirty_pagecache
>>>> # # not ok 6 memory_failure.madv_soft.dirty_pagecache
>>>> # # # FAILED: 2 / 6 tests passed.
>>>> # # # Totals: pass:2 fail:4 xfail:0 xpass:0 skip:0 error:0
>>>> # # [FAIL]
>>>> # not ok 71 memory-failure # exit=1
>>>>
>>>>
>>>> Can the test maybe not deal with running in certain environments (config options etc)?
>>>
>>> To run the test, I think there should be:
>>>    1.CONFIG_MEMORY_FAILURE and CONFIG_HWPOISON_INJECT should be enabled.
>>>    2.Root privilege is required.
>>>    3.For dirty/clean pagecache testcases, the test file "./clean-page-cache-test-file" and
>>>      "./dirty-page-cache-test-file" are assumed to be created on non-memory file systems
>>>      such as xfs, ext4, etc.
>>>
>>> Does your test environment break any of the above rules?
>>
>> It is 0day environment, so very likely yes. I suspect 1).

Hi David,

After taking a more close look, I think CONFIG_MEMORY_FAILURE and CONFIG_HWPOISON_INJECT should have been
enabled in 0day environment or testcase memory_failure.madv_hard.anon should fail. memory_failure.madv_hard.anon
will inject memory failure and expects seeing a SIGBUG signal.

>>
>>> Am I expected to add some code to
>>> guard against this?
>>
>> Yes, at least some.
>>
>> Checking for root privileges is not required. The tests are commonly run from non-memory file systems, but, in theory, could be run from nfs etc.
>>
>> If you require special file systems, take a look at gup_longterm.o where we test for some fileystsem types.

And I think the cause of failures of testcases memory_failure.madv_hard.clean_pagecache and memory_failure.madv_hard.dirty_pagecache
is they running on memory filesystems. The error pages are kept in page cache in that case while memory_failure.madv_hard.clean_pagecache
expects to see the error page truncated.

But I have no idea why memory_failure.madv_soft.dirty_pagecache and memory_failure.madv_soft.clean_pagecache return -1(-EPERM?) when try
to inject memory error through madvise syscall. It could be really helpful if more information can be provided.

Thanks!
.

