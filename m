Return-Path: <linux-kselftest+bounces-48721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED23BD11769
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 10:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC4E830056C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 09:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361C93469F8;
	Mon, 12 Jan 2026 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zvTYDn6G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49C030E0C8;
	Mon, 12 Jan 2026 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209567; cv=none; b=pTQZRpjr3XNlZvgADm2UFcFMhcQfWdeSujLXBRN+dJeLwK9GEqR6//IIrg9+P8RdsDJzHGJHBJuUB4Cm2L2l8X2RK8xanbkSt78z3NouBsMj9zqzqBWCyOdHJQ9egFbIRQX6ktRgJtWacIjsVjYSUesILOLLOVShzh19e7RRt84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209567; c=relaxed/simple;
	bh=w6Ho0zVRX3UM79QWnb5JKquXMZxm6WlhNs26nhsrtJo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hl454xuRYPoG3rdmmllN7NUJGckuzvJYAaCovsMKMlXz1CRhUEsalcqI84+DyCkJPVOX71qiYn3upixq1y59p+YjsJagjBLJL0IHRNB1MIlad59mwjJPzB43bIArfSrOQQ4GMVRKy5cEgcOMh2lv93GkC+2epomQXaUHfSCCfQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zvTYDn6G; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+f+PPW3lUn7oQSpmMK6gvixamR5iuakOW3YyIZVCEaQ=;
	b=zvTYDn6GnM52YzjJ527bxhZVEvlaQZfrR3lFkfPNtYOyDS7vJ6legPbDwsEha+ErDQhuJZ+C+
	beYA3Cnr1OkkF9rzBrysSsX0bszyP8kKKr7T+tijAmkPHaTKH5HTeEoXyxykBkv1Kbf6MtDEKOa
	9WOg7ZBO2okJf5isaB5vjhs=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dqRYb0Q6Bz1T4J2;
	Mon, 12 Jan 2026 17:15:31 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 18B114036C;
	Mon, 12 Jan 2026 17:19:21 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 Jan 2026 17:19:20 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 Jan 2026 17:19:19 +0800
Subject: Re: [PATCH 0/3] selftests/mm: add memory failure selftests
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
CC: <lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<nao.horiguchi@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<akpm@linux-foundation.org>, <shuah@kernel.org>
References: <20260107093710.3928374-1-linmiaohe@huawei.com>
 <9413a995-9182-493e-a28a-6d2d3a17236b@kernel.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2ae04380-fd60-a8a1-6217-386454fec610@huawei.com>
Date: Mon, 12 Jan 2026 17:19:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9413a995-9182-493e-a28a-6d2d3a17236b@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/1/9 21:45, David Hildenbrand (Red Hat) wrote:
> On 1/7/26 10:37, Miaohe Lin wrote:
>> Introduce selftests to validate the functionality of memory failure.
>> These tests help ensure that memory failure handling for anonymous
>> pages, pagecaches pages works correctly, including proper SIGBUS
>> delivery to user processes, page isolation, and recovery paths.
>>
>> Currently madvise syscall is used to inject memory failures. And only
>> anonymous pages and pagecaches are tested. More test scenarios, e.g.
>> hugetlb, shmem, thp, will be added. Also more memory failure injecting
>> methods will be supported, e.g. APEI Error INJection, if required.
> 

Thanks for test and report. :)

> 0day reports that these tests fail:
> 
> # # ------------------------
> # # running ./memory-failure
> # # ------------------------
> # # TAP version 13
> # # 1..6
> # # # Starting 6 tests from 2 test cases.
> # # #  RUN           memory_failure.madv_hard.anon ...
> # # #            OK  memory_failure.madv_hard.anon
> # # ok 1 memory_failure.madv_hard.anon
> # # #  RUN           memory_failure.madv_hard.clean_pagecache ...
> # # # memory-failure.c:166:clean_pagecache:Expected setjmp (1) == 0 (0)
> # # # clean_pagecache: Test terminated by assertion
> # # #          FAIL  memory_failure.madv_hard.clean_pagecache
> # # not ok 2 memory_failure.madv_hard.clean_pagecache
> # # #  RUN           memory_failure.madv_hard.dirty_pagecache ...
> # # # memory-failure.c:207:dirty_pagecache:Expected unpoison_memory(self->pfn) (-16) == 0 (0)
> # # # dirty_pagecache: Test terminated by assertion
> # # #          FAIL  memory_failure.madv_hard.dirty_pagecache
> # # not ok 3 memory_failure.madv_hard.dirty_pagecache
> # # #  RUN           memory_failure.madv_soft.anon ...
> # # #            OK  memory_failure.madv_soft.anon
> # # ok 4 memory_failure.madv_soft.anon
> # # #  RUN           memory_failure.madv_soft.clean_pagecache ...
> # # # memory-failure.c:282:clean_pagecache:Expected variant->inject(self, addr) (-1) == 0 (0)
> # # # clean_pagecache: Test terminated by assertion
> # # #          FAIL  memory_failure.madv_soft.clean_pagecache
> # # not ok 5 memory_failure.madv_soft.clean_pagecache
> # # #  RUN           memory_failure.madv_soft.dirty_pagecache ...
> # # # memory-failure.c:319:dirty_pagecache:Expected variant->inject(self, addr) (-1) == 0 (0)
> # # # dirty_pagecache: Test terminated by assertion
> # # #          FAIL  memory_failure.madv_soft.dirty_pagecache
> # # not ok 6 memory_failure.madv_soft.dirty_pagecache
> # # # FAILED: 2 / 6 tests passed.
> # # # Totals: pass:2 fail:4 xfail:0 xpass:0 skip:0 error:0
> # # [FAIL]
> # not ok 71 memory-failure # exit=1
> 
> 
> Can the test maybe not deal with running in certain environments (config options etc)?

To run the test, I think there should be:
  1.CONFIG_MEMORY_FAILURE and CONFIG_HWPOISON_INJECT should be enabled.
  2.Root privilege is required.
  3.For dirty/clean pagecache testcases, the test file "./clean-page-cache-test-file" and
    "./dirty-page-cache-test-file" are assumed to be created on non-memory file systems
    such as xfs, ext4, etc.

Does your test environment break any of the above rules? Am I expected to add some code to
guard against this?

Thanks.
.


