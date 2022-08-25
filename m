Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FB65A0CA9
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Aug 2022 11:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239962AbiHYJbd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Aug 2022 05:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbiHYJba (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Aug 2022 05:31:30 -0400
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0CB74DC0;
        Thu, 25 Aug 2022 02:31:26 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MCyQP1P46zMqDVD;
        Thu, 25 Aug 2022 11:31:25 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MCyQN3ghkzlh8TL;
        Thu, 25 Aug 2022 11:31:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1661419885;
        bh=CkxqIj5ppbkjqi2GIhMLEArRVaHpESPBLrlgJrYmOqs=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=jh+9OLvqNwAbhISkiftw4MmTNT4pHs+fZpj4FpkmLFc/cc5INadRj05vaTMzHp0TH
         MvRiVzPfi6dOPgpD+tkdN3pFsU85X2TTYnFfpbStn8bH6D1OhxGceky3/XxV8wRXBv
         lZX5WzTRP7ylhT5IzCo7lcWDuYKM2LnNYyFQLImA=
Message-ID: <eeb34913-5930-3e82-3d8f-a00e20798e4a@digikod.net>
Date:   Thu, 25 Aug 2022 11:31:23 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Guillaume <guillaume.tucker@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <a459363217b1847c0f206a5dbdf181cb21cf3d0c.1659557290.git.guillaume.tucker@collabora.com>
 <CADYN=9JM1nnjC9LypHqrz7JJjbZLpm8rArDUy4zgYYrajErBnA@mail.gmail.com>
 <e4843a98-0bde-829c-f77a-56d45ba324d7@digikod.net>
 <CADYN=9+CFEV9QpNbhi6gKqJr1V5Jc8Q5hGhCD_ESkRXP2X3gbQ@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH] selftests/landlock: fix broken include of
 linux/landlock.h
In-Reply-To: <CADYN=9+CFEV9QpNbhi6gKqJr1V5Jc8Q5hGhCD_ESkRXP2X3gbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 22/08/2022 16:00, Anders Roxell wrote:
> On Sat, 13 Aug 2022 at 14:31, Mickaël Salaün <mic@digikod.net> wrote:
>>
>>
>> On 13/08/2022 12:01, Anders Roxell wrote:
>>> On Wed, 3 Aug 2022 at 22:14, Guillaume Tucker
>>> <guillaume.tucker@collabora.com> wrote:
>>>>
>>>> Revert part of the earlier changes to fix the kselftest build when
>>>> using a sub-directory from the top of the tree as this broke the
>>>> landlock test build as a side-effect when building with "make -C
>>>> tools/testing/selftests/landlock".
>>>>
>>>> Reported-by: Mickaël Salaün <mic@digikod.net>
>>>> Fixes: a917dd94b832 ("selftests/landlock: drop deprecated headers dependency")
>>>> Fixes: f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")
>>>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
>>>
>>> Building with this patch doesn't work, it gives this output:
>>> make[3]: Entering directory
>>> '/home/anders/src/kernel/next/tools/testing/selftests/landlock'
>>> make[3]: Leaving directory
>>> '/home/anders/src/kernel/next/tools/testing/selftests/landlock'
>>> make[3]: *** No rule to make target
>>> '/home/anders/.cache/tuxmake/builds/78/build/kselftest/landlock/base_test',
>>> needed by 'all'.  Stop.
>>>
>>> I'm building like this:
>>> tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-12
>>> --kconfig defconfig kselftest
>>>
>>> which translates into this make command:
>>> make --silent --keep-going --jobs=32
>>> O=/home/anders/.cache/tuxmake/builds/78/build
>>> INSTALL_PATH=/home/anders/.cache/tuxmake/builds/78/build/kselftest_install
>>> ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- kselftest-install
>>
>> This works well for me.
> 
> Interesting

I used this command (inspired by yours):

make --silent --keep-going --jobs=32 "O=${HOME}/build" 
"INSTALL_PATH=${HOME}/build/kselftest_install" ARCH=x86_64 
CROSS_COMPILE=x86_64-linux-gnu- kselftest-install

Can you run this command without using tuxmake?


> 
>> Which commit is checkout?
> 
> I used the latest next tag, I tried to on todays tag as well
> next-20220822 and I see
> the same issue.
> building without 'O=...' I can build the landlock tests...

Can you test it with Linux v5.19 and v6.0-rc2 and see if there is a 
difference?

Is your workspace clean?
What is the version of your make?

Can you replace this line from the Makefile with static names?
"src_test := $(wildcard *_test.c)"



> 
>>
>>
>>>
>>> building without this patch works, see below:
>>>
>>> make[3]: Entering directory
>>> '/home/anders/src/kernel/next/tools/testing/selftests/landlock'
>>> x86_64-linux-gnu-gcc -Wall -O2 -isystem
>>> /home/anders/.cache/tuxmake/builds/77/build/usr/include    base_test.c
>>>    -o /home/anders/.cache/tuxmake/builds/77/build/kselftest/landlock/base_test
>>> -lcap
>>> x86_64-linux-gnu-gcc -Wall -O2 -isystem
>>> /home/anders/.cache/tuxmake/builds/77/build/usr/include    fs_test.c
>>> -o /home/anders/.cache/tuxmake/builds/77/build/kselftest/landlock/fs_test
>>> -lcap
>>> x86_64-linux-gnu-gcc -Wall -O2 -isystem
>>> /home/anders/.cache/tuxmake/builds/77/build/usr/include
>>> ptrace_test.c  -o
>>> /home/anders/.cache/tuxmake/builds/77/build/kselftest/landlock/ptrace_test
>>> -lcap
>>> x86_64-linux-gnu-gcc -Wall -O2 -isystem
>>> /home/anders/.cache/tuxmake/builds/77/build/usr/include    true.c  -o
>>> /home/anders/.cache/tuxmake/builds/77/build/kselftest/landlock/true
>>> -static
>>> make[3]: Leaving directory
>>> '/home/anders/src/kernel/next/tools/testing/selftests/landlock'
>> Does this work if you revert this patch, commit a917dd94b832
>> ("selftests/landlock: drop deprecated headers dependency") and commit
>> f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")?
>>
>> This patch mainly revert commit a917dd94b832, so I don't see the issue.
>>
>>
>>>
>>> Cheers,
>>> Anders
>>>
>>>> ---
>>>>    tools/testing/selftests/landlock/Makefile | 7 +++++--
>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
>>>> index a6959df28eb0..02868ac3bc71 100644
>>>> --- a/tools/testing/selftests/landlock/Makefile
>>>> +++ b/tools/testing/selftests/landlock/Makefile
>>>> @@ -9,10 +9,13 @@ TEST_GEN_PROGS := $(src_test:.c=)
>>>>    TEST_GEN_PROGS_EXTENDED := true
>>>>
>>>>    OVERRIDE_TARGETS := 1
>>>> +top_srcdir := ../../../..
>>>>    include ../lib.mk
>>>>
>>>> +khdr_dir = $(top_srcdir)/usr/include
>>>> +
>>>>    $(OUTPUT)/true: true.c
>>>>           $(LINK.c) $< $(LDLIBS) -o $@ -static
>>>>
>>>> -$(OUTPUT)/%_test: %_test.c ../kselftest_harness.h common.h
>>>> -       $(LINK.c) $< $(LDLIBS) -o $@ -lcap
>>>> +$(OUTPUT)/%_test: %_test.c $(khdr_dir)/linux/landlock.h ../kselftest_harness.h common.h
>>>> +       $(LINK.c) $< $(LDLIBS) -o $@ -lcap -I$(khdr_dir)
>>>> --
>>>> 2.30.2
>>>>
