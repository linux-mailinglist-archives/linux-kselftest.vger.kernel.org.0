Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2627A63BE95
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 12:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiK2LGx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 06:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiK2LGW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 06:06:22 -0500
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF836204A
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 03:03:32 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NLzwH54j7zMpnsN;
        Tue, 29 Nov 2022 12:03:27 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4NLzwG46yQzMppBm;
        Tue, 29 Nov 2022 12:03:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1669719807;
        bh=TLB1uJhOAIdI/EElBwqY+knrjdOQVyTAQPueqObbA9U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YJe3KcaBhpyR2dws3y80DgSUVZlwx7uKAL8ICdepm5y/JD/cXo3UmTENPWpcoWjdX
         iGaj99GSJui7kLNVwPx15f58zrG9FynRunm/RKwKzAhDZD9LMb+K24HWd8yBvw5Dsf
         +FVn3WoG66jczn2bHYe5O1IrpBBzEjGq4PnjBsFA=
Message-ID: <e62a539b-614c-c008-873a-f9c57c7ecb33@digikod.net>
Date:   Tue, 29 Nov 2022 12:03:25 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH -next] selftests/landlock: Fix selftest ptrace_test run
 fail
Content-Language: en-US
To:     limin <limin100@huawei.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, songmuchun@bytedance.com, tj@kernel.org,
        lizefan.x@bytedance.com
References: <20221128020409.1545717-1-limin100@huawei.com>
 <1232e4f3-e4b8-ff23-61e8-5465c8406f6e@digikod.net>
 <7379a5fd-5593-c6ce-40fd-c543dcf70d2b@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <7379a5fd-5593-c6ce-40fd-c543dcf70d2b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I tested with next-20221116 and all tests are OK. Could you share your 
kernel configuration with a link? What is the content of /proc/cmdline?

On 29/11/2022 02:42, limin wrote:
> I run test on Linux ubuntu2204 6.1.0-next-20221116
> 
> I did't use yama.
> 
> you can reproduce by this step:
> 
> cd kernel_src
> 
> cd tools/testing/selftests/landlock/
> make
> ./ptrace_test
> 
> 
> 
> 
> On 2022/11/29 3:44, Mickaël Salaün wrote:
>> This patch changes the test semantic and then cannot work on my test
>> environment. On which kernel did you run test? Do you use Yama or
>> something similar?
>>
>> On 28/11/2022 03:04, limin wrote:
>>> Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent,
>>> trace parent return -1 when child== 0
>>> How to reproduce warning:
>>> $ make -C tools/testing/selftests TARGETS=landlock run_tests
>>>
>>> Signed-off-by: limin <limin100@huawei.com>
>>> ---
>>>    tools/testing/selftests/landlock/ptrace_test.c | 5 ++---
>>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/landlock/ptrace_test.c
>>> b/tools/testing/selftests/landlock/ptrace_test.c
>>> index c28ef98ff3ac..88c4dc63eea0 100644
>>> --- a/tools/testing/selftests/landlock/ptrace_test.c
>>> +++ b/tools/testing/selftests/landlock/ptrace_test.c
>>> @@ -267,12 +267,11 @@ TEST_F(hierarchy, trace)
>>>            /* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent. */
>>>            err_proc_read = test_ptrace_read(parent);
>>>            ret = ptrace(PTRACE_ATTACH, parent, NULL, 0);
>>> +        EXPECT_EQ(-1, ret);
>>> +        EXPECT_EQ(EPERM, errno);
>>>            if (variant->domain_child) {
>>> -            EXPECT_EQ(-1, ret);
>>> -            EXPECT_EQ(EPERM, errno);
>>>                EXPECT_EQ(EACCES, err_proc_read);
>>>            } else {
>>> -            EXPECT_EQ(0, ret);
>>>                EXPECT_EQ(0, err_proc_read);
>>>            }
>>>            if (ret == 0) {
