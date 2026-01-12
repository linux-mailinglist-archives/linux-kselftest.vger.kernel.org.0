Return-Path: <linux-kselftest+bounces-48741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC16D1252E
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 12:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3259F301C56A
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 11:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6C53563DA;
	Mon, 12 Jan 2026 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZxjG6U0R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3693559DD;
	Mon, 12 Jan 2026 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768217623; cv=none; b=FdOKbsg//cu3YyLUfKnjZfstUvk5VSoJqv6KGnE+oc3Q12MFYHjb91faOJQfgyztMOgJroZFTn8PCIDCBrL1evNheTaaJnNs0r8ndiIWe0LIDzGFc5SDoyIrjpZUvmmW28q7QZw6QTyq1ngePNDrriLCVPbiAsg7E35N9iqiDCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768217623; c=relaxed/simple;
	bh=iCUfZmAg5Y4e/wSzVBwVYRArHm2NR/TxND8/bBdDCJQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dy5NT53ldOQdX2YVsyIEwloujBZIw15Q4u0OMfbfMbFiFl05Uz8YxtS5gwUsyc6P//gd9JF2ibaw2/0xkNw5svJWTtC22/uaxIOYgdQuvfoH59gHeWzN2bhweu7M0LRDh5Fun2XfJY9Nz64RUv6B+VmGEsKyDb2932T9Wt9CXwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZxjG6U0R; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lMoZuLVDlUswErnQyq4SdMbwKsA1mCI8UQu4w6SIK9Y=;
	b=ZxjG6U0Rgcu8X90qsdNGKi7uM5r/vviLbNGLXee2cNHITy3nqdnH+XojBw93eDN8YuOWASgDf
	d7pUsr4zuC3nOFdOu3ck8EIOyQ3cnljv6oz9sJc+ddMI3IPVwhsyfGjtgtaZVft8NBdyRuaEKnu
	jxlpgse25iCar+3JEejQGm8=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dqVYP6zxkz12LJ9;
	Mon, 12 Jan 2026 19:30:33 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 50F834056B;
	Mon, 12 Jan 2026 19:33:35 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 Jan 2026 19:33:35 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 Jan 2026 19:33:34 +0800
Subject: Re: [PATCH 0/3] selftests/mm: add memory failure selftests
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
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d958d80a-8412-6107-e144-975b8d545568@huawei.com>
Date: Mon, 12 Jan 2026 19:33:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <693dc9aa-cf86-48c7-be9c-ec554f9da855@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/1/12 17:40, David Hildenbrand (Red Hat) wrote:
> On 1/12/26 10:19, Miaohe Lin wrote:
>> On 2026/1/9 21:45, David Hildenbrand (Red Hat) wrote:
>>> On 1/7/26 10:37, Miaohe Lin wrote:
>>>> Introduce selftests to validate the functionality of memory failure.
>>>> These tests help ensure that memory failure handling for anonymous
>>>> pages, pagecaches pages works correctly, including proper SIGBUS
>>>> delivery to user processes, page isolation, and recovery paths.
>>>>
>>>> Currently madvise syscall is used to inject memory failures. And only
>>>> anonymous pages and pagecaches are tested. More test scenarios, e.g.
>>>> hugetlb, shmem, thp, will be added. Also more memory failure injecting
>>>> methods will be supported, e.g. APEI Error INJection, if required.
>>>
>>
>> Thanks for test and report. :)
>>
>>> 0day reports that these tests fail:
>>>
>>> # # ------------------------
>>> # # running ./memory-failure
>>> # # ------------------------
>>> # # TAP version 13
>>> # # 1..6
>>> # # # Starting 6 tests from 2 test cases.
>>> # # #  RUN           memory_failure.madv_hard.anon ...
>>> # # #            OK  memory_failure.madv_hard.anon
>>> # # ok 1 memory_failure.madv_hard.anon
>>> # # #  RUN           memory_failure.madv_hard.clean_pagecache ...
>>> # # # memory-failure.c:166:clean_pagecache:Expected setjmp (1) == 0 (0)
>>> # # # clean_pagecache: Test terminated by assertion
>>> # # #          FAIL  memory_failure.madv_hard.clean_pagecache
>>> # # not ok 2 memory_failure.madv_hard.clean_pagecache
>>> # # #  RUN           memory_failure.madv_hard.dirty_pagecache ...
>>> # # # memory-failure.c:207:dirty_pagecache:Expected unpoison_memory(self->pfn) (-16) == 0 (0)
>>> # # # dirty_pagecache: Test terminated by assertion
>>> # # #          FAIL  memory_failure.madv_hard.dirty_pagecache
>>> # # not ok 3 memory_failure.madv_hard.dirty_pagecache
>>> # # #  RUN           memory_failure.madv_soft.anon ...
>>> # # #            OK  memory_failure.madv_soft.anon
>>> # # ok 4 memory_failure.madv_soft.anon
>>> # # #  RUN           memory_failure.madv_soft.clean_pagecache ...
>>> # # # memory-failure.c:282:clean_pagecache:Expected variant->inject(self, addr) (-1) == 0 (0)
>>> # # # clean_pagecache: Test terminated by assertion
>>> # # #          FAIL  memory_failure.madv_soft.clean_pagecache
>>> # # not ok 5 memory_failure.madv_soft.clean_pagecache
>>> # # #  RUN           memory_failure.madv_soft.dirty_pagecache ...
>>> # # # memory-failure.c:319:dirty_pagecache:Expected variant->inject(self, addr) (-1) == 0 (0)
>>> # # # dirty_pagecache: Test terminated by assertion
>>> # # #          FAIL  memory_failure.madv_soft.dirty_pagecache
>>> # # not ok 6 memory_failure.madv_soft.dirty_pagecache
>>> # # # FAILED: 2 / 6 tests passed.
>>> # # # Totals: pass:2 fail:4 xfail:0 xpass:0 skip:0 error:0
>>> # # [FAIL]
>>> # not ok 71 memory-failure # exit=1
>>>
>>>
>>> Can the test maybe not deal with running in certain environments (config options etc)?
>>
>> To run the test, I think there should be:
>>    1.CONFIG_MEMORY_FAILURE and CONFIG_HWPOISON_INJECT should be enabled.
>>    2.Root privilege is required.
>>    3.For dirty/clean pagecache testcases, the test file "./clean-page-cache-test-file" and
>>      "./dirty-page-cache-test-file" are assumed to be created on non-memory file systems
>>      such as xfs, ext4, etc.
>>
>> Does your test environment break any of the above rules?
> 
> It is 0day environment, so very likely yes. I suspect 1).
> 
>> Am I expected to add some code to
>> guard against this?
> 
> Yes, at least some.
> 
> Checking for root privileges is not required. The tests are commonly run from non-memory file systems, but, in theory, could be run from nfs etc.
> 
> If you require special file systems, take a look at gup_longterm.o where we test for some fileystsem types.
> 
> Regarding 1): tools/testing/selftests/mm/config includes the config options we expect to be set for running MM tests. Extending that might take a while until environments like 0day would pick up such changes. If you require something else, make your test SKIP tests if the relevant kernel support is not there (e.g., sense support and conditionally skip).

Thanks for your valuable suggestion. I will take a close look.

Thanks!
.

