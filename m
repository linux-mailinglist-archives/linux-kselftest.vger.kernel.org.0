Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7968663B759
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 02:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbiK2Bmk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 20:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiK2Bmj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 20:42:39 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320D9DF2;
        Mon, 28 Nov 2022 17:42:35 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NLlSC132dzHwGb;
        Tue, 29 Nov 2022 09:41:47 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 09:42:28 +0800
Received: from [10.67.111.113] (10.67.111.113) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 09:42:27 +0800
Message-ID: <7379a5fd-5593-c6ce-40fd-c543dcf70d2b@huawei.com>
Date:   Tue, 29 Nov 2022 09:42:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH -next] selftests/landlock: Fix selftest ptrace_test run
 fail
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        <songmuchun@bytedance.com>, <tj@kernel.org>,
        <lizefan.x@bytedance.com>
References: <20221128020409.1545717-1-limin100@huawei.com>
 <1232e4f3-e4b8-ff23-61e8-5465c8406f6e@digikod.net>
From:   limin <limin100@huawei.com>
In-Reply-To: <1232e4f3-e4b8-ff23-61e8-5465c8406f6e@digikod.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.113]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I run test on Linux ubuntu2204 6.1.0-next-20221116

I did't use yama.

you can reproduce by this step:

cd kernel_src

cd tools/testing/selftests/landlock/
make
./ptrace_test




On 2022/11/29 3:44, Mickaël Salaün wrote:
> This patch changes the test semantic and then cannot work on my test 
> environment. On which kernel did you run test? Do you use Yama or 
> something similar?
>
> On 28/11/2022 03:04, limin wrote:
>> Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent,
>> trace parent return -1 when child== 0
>> How to reproduce warning:
>> $ make -C tools/testing/selftests TARGETS=landlock run_tests
>>
>> Signed-off-by: limin <limin100@huawei.com>
>> ---
>>   tools/testing/selftests/landlock/ptrace_test.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/landlock/ptrace_test.c 
>> b/tools/testing/selftests/landlock/ptrace_test.c
>> index c28ef98ff3ac..88c4dc63eea0 100644
>> --- a/tools/testing/selftests/landlock/ptrace_test.c
>> +++ b/tools/testing/selftests/landlock/ptrace_test.c
>> @@ -267,12 +267,11 @@ TEST_F(hierarchy, trace)
>>           /* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent. */
>>           err_proc_read = test_ptrace_read(parent);
>>           ret = ptrace(PTRACE_ATTACH, parent, NULL, 0);
>> +        EXPECT_EQ(-1, ret);
>> +        EXPECT_EQ(EPERM, errno);
>>           if (variant->domain_child) {
>> -            EXPECT_EQ(-1, ret);
>> -            EXPECT_EQ(EPERM, errno);
>>               EXPECT_EQ(EACCES, err_proc_read);
>>           } else {
>> -            EXPECT_EQ(0, ret);
>>               EXPECT_EQ(0, err_proc_read);
>>           }
>>           if (ret == 0) {
