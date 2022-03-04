Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFC14CD1A8
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 10:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiCDJzG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 04:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiCDJzG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 04:55:06 -0500
X-Greylist: delayed 479 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Mar 2022 01:54:18 PST
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc09])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B8C3B034
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Mar 2022 01:54:17 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4K92zr0nkKzMr6ZF;
        Fri,  4 Mar 2022 10:46:16 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4K92zq2Pb6zljTg6;
        Fri,  4 Mar 2022 10:46:15 +0100 (CET)
Message-ID: <605d7e16-d5ee-9d6e-36c4-02bf1d071e99@digikod.net>
Date:   Fri, 4 Mar 2022 10:46:21 +0100
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220303110629.2072927-1-usama.anjum@collabora.com>
 <b97fe611-0a2d-6907-b924-a9132e2d427f@linuxfoundation.org>
 <660ad768-2437-92bb-d5ef-0ca8561499d4@collabora.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH] selftests/interpreter: fix separate directory build
In-Reply-To: <660ad768-2437-92bb-d5ef-0ca8561499d4@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 04/03/2022 08:34, Muhammad Usama Anjum wrote:
> On 3/4/22 2:39 AM, Shuah Khan wrote:
>> On 3/3/22 4:06 AM, Muhammad Usama Anjum wrote:
>>> Separate directory build fails of this test as headers include path isn't
>>> set correctly in that case. Fix it by including KHDR_INCLUDES.
>>>
>>> make -C tools/testing/selftests O=build1
>>> gcc -Wall -O2 -I../../../../usr/include    trust_policy_test.c -lcap
>>> -o /linux_mainline/build1/kselftest/interpreter/trust_policy_test
>>> trust_policy_test.c:14:10: fatal error: linux/trusted-for.h: No such
>>> file or directory
>>>      14 | #include <linux/trusted-for.h>
>>>         |          ^~~~~~~~~~~~~~~~~~~~~
>>> compilation terminated.
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: Mickaël Salaün <mic@linux.microsoft.com>

>>> ---
>>>    tools/testing/selftests/interpreter/Makefile | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/interpreter/Makefile
>>> b/tools/testing/selftests/interpreter/Makefile
>>> index 7402fdb6533f..51dde8e01e32 100644
>>> --- a/tools/testing/selftests/interpreter/Makefile
>>> +++ b/tools/testing/selftests/interpreter/Makefile
>>> @@ -1,6 +1,6 @@
>>>    # SPDX-License-Identifier: GPL-2.0
>>>    -CFLAGS += -Wall -O2 -I$(khdr_dir)
>>> +CFLAGS += -Wall -O2 -I$(khdr_dir) $(KHDR_INCLUDES)
>>>    LDLIBS += -lcap
>>>    
>>
>> Change looks fine to me.
>>
>>>    src_test := $(wildcard *_test.c)
>>>
>>
>> I am not seeing this test in linux-kselftest next for sure. Which tree is
>> this patch based on? Please  add the repo info to the patch subject line
>> in the future.
>>
> This patch is in linux-next and its build is failing from quite some time:
> https://storage.staging.kernelci.org/kernelci/staging-next/staging-next-20220301.0/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/logs/kselftest.log
> 
> I'm not sure in which tree selftests/interpreter is present. It was sent
> here:
> https://lore.kernel.org/lkml/20220104155024.48023-5-mic@digikod.net/
> 
> How can I find the tree from which this patch is coming?

As explained in the cover letter, it is now in my tree. To get the list 
of people to contact (and Cc) you should use ./script/get_maintainer.pl
The KHDR_INCLUDES series [1] was merged after the selftests/interpreter 
commits, hence the confusion with these two forks. Because make doesn't 
care about unknown variables, and to get a consistent series, I'll apply 
this patch just after the selftests/interpreter one. Thanks!

[1] 
https://lore.kernel.org/all/20220119101531.2850400-1-usama.anjum@collabora.com/


> 
>> Either way I don't have the patch that added in liunx-kselftest repo:
>>
>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>>
>> thanks,
>> -- Shuah
> 
> I forgot to add the tag:
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> 
> --
> Muhammad Usama Anjum
