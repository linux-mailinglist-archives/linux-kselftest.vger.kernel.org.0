Return-Path: <linux-kselftest+bounces-49474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8D4D3C315
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 10:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A9B04C858E
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4D13BF31C;
	Tue, 20 Jan 2026 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="sxtVUNrq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB83B95FE;
	Tue, 20 Jan 2026 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768899919; cv=none; b=Tq925BQwSDsKiL9dNq5mp5dz8txnkStPcf1ZRWaMRSWh7ouFhBo0FIFPFLffyDq0plHrnsWJMWspCMRCeI8mAzhCVYeEvPGcjXyllCaomnOcwJDuH/DBkwDttcOjV7XLdHFab6FYxkaqmbpDmWS98X3mlWZVj6Vsy7UYcLX3Xjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768899919; c=relaxed/simple;
	bh=Ind/HtZMtA5ymQUg/EkRykwDfqtfiaRI1l8e960Yg34=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=owuhvzurhqorsJXYbSG2sgOmH0nCgU5NxNB/Fdyy19it3ppD7mJtGevzunXK//kGER2vBUHl0ly0a+F4odkF7U6nGL8MkbrRZgdXf8tPrfxClWxMUExC67FZ+8EFOM6qDg8Q0q5fgL2QxGfgvWZdfylt8D3H3EkWgXLhP5RHtns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=sxtVUNrq; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3fjzOR9RQDpRiigeCgSn0QNalR2ltrBLZFD1Hj4R1Fk=;
	b=sxtVUNrq0zhGG055Ry9BCVeQiu8OoMVeRVLgQM6NpMHmkGaEMVJhWmDQ7DfyjNgvvBADcj6mg
	kzD2Ly7cmCvK3UkGy04HojRrnGGjsrJJmuiN7jRG7xMXf2ykiZ370meWOjRZs/tqg/5I9w0iUEj
	4OBM4vwH9jQMhIlUBQkMaxY=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dwLt00KTPzRhSH;
	Tue, 20 Jan 2026 17:01:44 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A3F2405A9;
	Tue, 20 Jan 2026 17:05:07 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Jan 2026 17:05:07 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Jan 2026 17:05:06 +0800
Subject: Re: [PATCH 0/3] selftests/mm: add memory failure selftests
To: Philip Li <philip.li@intel.com>, "David Hildenbrand (Red Hat)"
	<david@kernel.org>
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
 <b258b6c0-7af1-4443-bd81-2722dec610f7@huawei.com>
 <d6a544a5-9d22-4c89-bd53-92330f4a9f51@kernel.org>
 <aWZRKk92pYvwBLj6@rli9-mobl>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e62bda7d-4584-3f5d-f1f8-7685ca4d92df@huawei.com>
Date: Tue, 20 Jan 2026 17:05:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aWZRKk92pYvwBLj6@rli9-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/1/13 22:05, Philip Li wrote:
> On Mon, Jan 12, 2026 at 08:38:58PM +0100, David Hildenbrand (Red Hat) wrote:
>> On 1/12/26 13:44, Miaohe Lin wrote:
>>> On 2026/1/12 19:33, Miaohe Lin wrote:
> 
> ...
> 
>>>>>>> # # # Starting 6 tests from 2 test cases.
>>>>>>> # # #  RUN           memory_failure.madv_hard.anon ...
>>>>>>> # # #            OK  memory_failure.madv_hard.anon
>>>>>>> # not ok 71 memory-failure # exit=1
>>>>>>>
>>>>>>>
>>>>>>> Can the test maybe not deal with running in certain environments (config options etc)?
>>>>>>
>>>>>> To run the test, I think there should be:
>>>>>>     1.CONFIG_MEMORY_FAILURE and CONFIG_HWPOISON_INJECT should be enabled.
> 
> in 0day env, the configs are below
> 
> CONFIG_MEMORY_FAILURE=y
> CONFIG_HWPOISON_INJECT=m
> 
>>>>>>     2.Root privilege is required.
> 
> yes, use root to run
> 
>>>>>>     3.For dirty/clean pagecache testcases, the test file "./clean-page-cache-test-file" and
>>>>>>       "./dirty-page-cache-test-file" are assumed to be created on non-memory file systems
>>>>>>       such as xfs, ext4, etc.
> 
> this is a problem in 0day, the test is running in tmpfs. Let me further check
> to correct this.
> 
>>>>>>
>>>>>> Does your test environment break any of the above rules?
>>>>>
>>>>> It is 0day environment, so very likely yes. I suspect 1).
>>>
>>> Hi David,
>>>
>>> After taking a more close look, I think CONFIG_MEMORY_FAILURE and CONFIG_HWPOISON_INJECT should have been
>>> enabled in 0day environment or testcase memory_failure.madv_hard.anon should fail. memory_failure.madv_hard.anon
>>> will inject memory failure and expects seeing a SIGBUG signal.
>>
>> Good point.
>>
>>>
>>>>>
>>>>>> Am I expected to add some code to
>>>>>> guard against this?
>>>>>
>>>>> Yes, at least some.
>>>>>
>>>>> Checking for root privileges is not required. The tests are commonly run from non-memory file systems, but, in theory, could be run from nfs etc.
>>>>>
>>>>> If you require special file systems, take a look at gup_longterm.o where we test for some fileystsem types.
>>>
>>> And I think the cause of failures of testcases memory_failure.madv_hard.clean_pagecache and memory_failure.madv_hard.dirty_pagecache
>>> is they running on memory filesystems. The error pages are kept in page cache in that case while memory_failure.madv_hard.clean_pagecache
>>> expects to see the error page truncated.
>>
>> Maybe they are run on shmem? Good question. (@Phil?)
> 
> yes, it runs on tmpfs, let me further check to resolve it.

Thanks both. This information is really helpful. I will add some codes to handle this.

Thanks.
.

