Return-Path: <linux-kselftest+bounces-19315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AF2995E63
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 05:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942041C218EF
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 03:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954681428E0;
	Wed,  9 Oct 2024 03:59:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B416A1C68F;
	Wed,  9 Oct 2024 03:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728446395; cv=none; b=rylzwrzFNgxSABbv+Cix1OC10bDWKjJV53VZsDHpwYuwyvEzR+7Z+l75PdqrR5jCM5HTvmhhoVVb8TkgYvE4ipxtRuNi6Fh/kUGqAn8eIZ6YMG4UGby3ZKQT8kCQ9rv0fjOGLZnW74cEQtIzxW8jgm+OE1/zYmudtQ08oC3XlOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728446395; c=relaxed/simple;
	bh=/seqak0kFCEuSVoIFRP4lQfKnpQfxUueO61Fo5+XCUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mu9Y05ap354WX5RK4ZbTuLdjoAjo4YzAF7BdSkIZJ3eWZhcWMevvuoWxYV44rx8Ja7CL6NqFyI1yjdk7erxTbDSmYqyDL/pb4a5o5CCKcZn2eC8Fh7QhMt+3j0mbHYXy5GP0qpWZtHrzIE8K6dgVRSRUQek5hAuC2p0G6MWfeMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XNfDv1jVTz1HKh7;
	Wed,  9 Oct 2024 11:55:43 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A47E9140134;
	Wed,  9 Oct 2024 11:59:48 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Oct 2024 11:59:48 +0800
Message-ID: <f3f882bf-4120-4daa-b35f-8b1b4e0deb2d@huawei.com>
Date: Wed, 9 Oct 2024 11:59:47 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 01/14] mm: page_frag: add a test module for
 page_frag
To: Shuah Khan <skhan@linuxfoundation.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexander Duyck
	<alexander.duyck@gmail.com>, Alexander Duyck <alexanderduyck@fb.com>, Andrew
 Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
	<linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>
References: <20241008112049.2279307-1-linyunsheng@huawei.com>
 <20241008112049.2279307-2-linyunsheng@huawei.com>
 <cb1acab0-a4c9-4e31-b6f6-70b8049f1663@linuxfoundation.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <cb1acab0-a4c9-4e31-b6f6-70b8049f1663@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/9 3:56, Shuah Khan wrote:
> On 10/8/24 05:20, Yunsheng Lin wrote:
>> The testing is done by ensuring that the fragment allocated
>> from a frag_frag_cache instance is pushed into a ptr_ring
>> instance in a kthread binded to a specified cpu, and a kthread
>> binded to a specified cpu will pop the fragment from the
>> ptr_ring and free the fragment.
>>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> 
> Signed-off-by should be last. Same comment on all the other

Hi, Shuah

I used 'git am' to collect those tag, it seems that is the order
the tool applied, and I checking other applied commit, it seems
only Signed-off-by from the committer is the last, like the below
recent mm commit:
6901cf55de22
ff7f5ad7bce4

> patches in this series. When you have 4 patches, it is a good
> practice to add cover-letter.

I guess the cover-letter meant below?
https://lore.kernel.org/all/20241008112049.2279307-1-linyunsheng@huawei.com/

> 
>> ---
>>   tools/testing/selftests/mm/Makefile           |   3 +
>>   tools/testing/selftests/mm/page_frag/Makefile |  18 ++
>>   .../selftests/mm/page_frag/page_frag_test.c   | 173 ++++++++++++++++++
>>   tools/testing/selftests/mm/run_vmtests.sh     |   8 +
>>   tools/testing/selftests/mm/test_page_frag.sh  | 171 +++++++++++++++++
>>   5 files changed, 373 insertions(+)
>>   create mode 100644 tools/testing/selftests/mm/page_frag/Makefile
>>   create mode 100644 tools/testing/selftests/mm/page_frag/page_frag_test.c
>>   create mode 100755 tools/testing/selftests/mm/test_page_frag.sh
>>
>> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
>> index 02e1204971b0..acec529baaca 100644
>> --- a/tools/testing/selftests/mm/Makefile
>> +++ b/tools/testing/selftests/mm/Makefile
>> @@ -36,6 +36,8 @@ MAKEFLAGS += --no-builtin-rules
>>   CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
>>   LDLIBS = -lrt -lpthread -lm
>>   +TEST_GEN_MODS_DIR := page_frag
>> +
>>   TEST_GEN_FILES = cow
>>   TEST_GEN_FILES += compaction_test
>>   TEST_GEN_FILES += gup_longterm
>> @@ -126,6 +128,7 @@ TEST_FILES += test_hmm.sh
>>   TEST_FILES += va_high_addr_switch.sh
>>   TEST_FILES += charge_reserved_hugetlb.sh
>>   TEST_FILES += hugetlb_reparenting_test.sh
>> +TEST_FILES += test_page_frag.sh
>>     # required by charge_reserved_hugetlb.sh
>>   TEST_FILES += write_hugetlb_memory.sh
>> diff --git a/tools/testing/selftests/mm/page_frag/Makefile b/tools/testing/selftests/mm/page_frag/Makefile
>> new file mode 100644
>> index 000000000000..58dda74d50a3
>> --- /dev/null
>> +++ b/tools/testing/selftests/mm/page_frag/Makefile
>> @@ -0,0 +1,18 @@
>> +PAGE_FRAG_TEST_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
>> +KDIR ?= $(abspath $(PAGE_FRAG_TEST_DIR)/../../../../..)
>> +
>> +ifeq ($(V),1)
>> +Q =
>> +else
>> +Q = @
>> +endif
>> +
>> +MODULES = page_frag_test.ko
>> +
>> +obj-m += page_frag_test.o
>> +
>> +all:
>> +    +$(Q)make -C $(KDIR) M=$(PAGE_FRAG_TEST_DIR) modules
>> +
>> +clean:
>> +    +$(Q)make -C $(KDIR) M=$(PAGE_FRAG_TEST_DIR) clean
>> diff --git a/tools/testing/selftests/mm/page_frag/page_frag_test.c b/tools/testing/selftests/mm/page_frag/page_frag_test.c
>> new file mode 100644
>> index 000000000000..eeb2b6bc681a
>> --- /dev/null
>> +++ b/tools/testing/selftests/mm/page_frag/page_frag_test.c
>> @@ -0,0 +1,173 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> I think this would throw a checkpatch warning about
> comment should be "/*" and not "//"

using "git grep 'SPDX-License' mm",  "//" seems like a more common
case.
And I did using './scripts/checkpatch.pl --strict --codespell', and
it does not throw a checkpatch warning.

>> +
>> +/*
>> + * Test module for page_frag cache
>> + *

...

>> +function run_manual_check()
>> +{
>> +    #
>> +    # Validate passed parameters. If there is wrong one,
>> +    # the script exists and does not execute further.
>> +    #
>> +    validate_passed_args $@
>> +
>> +    echo "Run the test with following parameters: $@"
> 
> Is this marker good enough to isolate the test results in the
> dmesg? Include the test name in the message.
> 
> 
>> +    insmod $DRIVER $@ > /dev/null 2>&1
>> +    echo "Done."
> 
> Is this marker good enough to isolate the test results in the
> dmesg? Include the test name in the message.
> 
>> +    echo "Check the kernel ring buffer to see the summary."
> 
> Usually the test would run dmesg and filter out the test results
> from the dmesg and include them in the test script output.
> 
> You can refer to other tests that do that: powerpc/scripts/hmi.sh
> is one example.

Thanks, will check that.

