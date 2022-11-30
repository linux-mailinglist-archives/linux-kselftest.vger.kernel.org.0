Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A985263E0CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 20:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiK3Tcu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 14:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK3Tct (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 14:32:49 -0500
X-Greylist: delayed 116956 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Nov 2022 11:32:47 PST
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6995D1F9FB
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 11:32:45 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NMq9S1yfrzMqM90;
        Wed, 30 Nov 2022 20:32:44 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4NMq9Q3pMbzxf;
        Wed, 30 Nov 2022 20:32:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1669836764;
        bh=cubmng6cm1zv4ZAZR8kkO4CZXUOrwBMha88pqHrbkDw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dNqxO5+V4oCjH4Adng9IcbS6WnrqsgiXA6YYyvIjnMbc99EDzNWH2qPTPaA927r6g
         28B7s94c6rVD39WGJz8aF3va22V6f1/RyKDV87A5BKgydJOikcBVTlrCG6o4dpXBGP
         uGKtwaciwx6iOTKfy3ndDdk3Md6EAsEQuwxlRDTQ=
Message-ID: <ed1f6874-0f24-8145-63d4-efe28545381b@digikod.net>
Date:   Wed, 30 Nov 2022 20:32:41 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH -next] selftests/landlock: Fix selftest ptrace_test run
 fail
Content-Language: en-US
To:     limin <limin100@huawei.com>, Jeff Xu <jeffxu@google.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, songmuchun@bytedance.com, tj@kernel.org,
        lizefan.x@bytedance.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>
References: <20221128020409.1545717-1-limin100@huawei.com>
 <1232e4f3-e4b8-ff23-61e8-5465c8406f6e@digikod.net>
 <7379a5fd-5593-c6ce-40fd-c543dcf70d2b@huawei.com>
 <e62a539b-614c-c008-873a-f9c57c7ecb33@digikod.net>
 <2bc18685-f975-497f-9c20-da99dbc296c0@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <2bc18685-f975-497f-9c20-da99dbc296c0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I checked and the Landlock ptrace test failed because Yama is enabled, 
which is expected. You can check that with 
/proc/sys/kernel/yama/ptrace_scope

Jeff Xu sent a patch to fix this case but it is not ready yet: 
https://lore.kernel.org/r/20220628222941.2642917-1-jeffxu@google.com

Could you please send a new patch Jeff, and add Limin in Cc?


On 29/11/2022 12:26, limin wrote:
> cat /proc/cmdline
> BOOT_IMAGE=/vmlinuz-6.1.0-next-20221116
> root=UUID=a65b3a79-dc02-4728-8a0c-5cf24f4ae08b ro
> systemd.unified_cgroup_hierarchy=1 cgroup_no_v1=all
> 
> 
> config
> 
> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86 6.1.0-rc6 Kernel Configuration
> #

[...]

> CONFIG_SECURITY_YAMA=y

[...]

> CONFIG_LSM="landlock,lockdown,yama,integrity,apparmor"
[...]
> 
> On 2022/11/29 19:03, Mickaël Salaün wrote:
>> I tested with next-20221116 and all tests are OK. Could you share your
>> kernel configuration with a link? What is the content of /proc/cmdline?
>>
>> On 29/11/2022 02:42, limin wrote:
>>> I run test on Linux ubuntu2204 6.1.0-next-20221116
>>>
>>> I did't use yama.
>>>
>>> you can reproduce by this step:
>>>
>>> cd kernel_src
>>>
>>> cd tools/testing/selftests/landlock/
>>> make
>>> ./ptrace_test
>>>
>>>
>>>
>>>
>>> On 2022/11/29 3:44, Mickaël Salaün wrote:
>>>> This patch changes the test semantic and then cannot work on my test
>>>> environment. On which kernel did you run test? Do you use Yama or
>>>> something similar?
>>>>
>>>> On 28/11/2022 03:04, limin wrote:
>>>>> Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent,
>>>>> trace parent return -1 when child== 0
>>>>> How to reproduce warning:
>>>>> $ make -C tools/testing/selftests TARGETS=landlock run_tests
>>>>>
>>>>> Signed-off-by: limin <limin100@huawei.com>
>>>>> ---
>>>>>     tools/testing/selftests/landlock/ptrace_test.c | 5 ++---
>>>>>     1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/landlock/ptrace_test.c
>>>>> b/tools/testing/selftests/landlock/ptrace_test.c
>>>>> index c28ef98ff3ac..88c4dc63eea0 100644
>>>>> --- a/tools/testing/selftests/landlock/ptrace_test.c
>>>>> +++ b/tools/testing/selftests/landlock/ptrace_test.c
>>>>> @@ -267,12 +267,11 @@ TEST_F(hierarchy, trace)
>>>>>             /* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the
>>>>> parent. */
>>>>>             err_proc_read = test_ptrace_read(parent);
>>>>>             ret = ptrace(PTRACE_ATTACH, parent, NULL, 0);
>>>>> +        EXPECT_EQ(-1, ret);
>>>>> +        EXPECT_EQ(EPERM, errno);
>>>>>             if (variant->domain_child) {
>>>>> -            EXPECT_EQ(-1, ret);
>>>>> -            EXPECT_EQ(EPERM, errno);
>>>>>                 EXPECT_EQ(EACCES, err_proc_read);
>>>>>             } else {
>>>>> -            EXPECT_EQ(0, ret);
>>>>>                 EXPECT_EQ(0, err_proc_read);
>>>>>             }
>>>>>             if (ret == 0) {
