Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096357898AF
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Aug 2023 20:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjHZSad (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 26 Aug 2023 14:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjHZSaN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 26 Aug 2023 14:30:13 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB1BBD;
        Sat, 26 Aug 2023 11:30:07 -0700 (PDT)
X-QQ-mid: bizesmtpipv602t1693074596txh9
Received: from [IPV6:2001:da8:c000:3005:c026:8 ( [255.193.153.7])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 27 Aug 2023 02:29:54 +0800 (CST)
X-QQ-SSF: 01200000000000907000000A0000000
X-QQ-FEAT: fj/jKqveG5F37E2q+TLQp06oyzV8uk1tUboC9VYcnxaGoe+e4Hz5P2zI6fdDN
        mhg/fyeruMJUt0N9AnR8rTJ2x70msQAaNrgiac2VQ7/6mTtSAQ1dlFpdR6TVkFMZNF/BmzI
        RCtrNcZ1y6e89VgtLt1kvvLslWFVDtRewVIoHORpoXFJwk6bI0TmXFtpG+POPmE6SZ6u+vG
        YnBTIr3Uv/OX6dM1sYlbvHeRttVvZsECzV4kHNBjkzAwYLxATHSrcvc8EE97ErHfcxzh0jy
        VnXdMYyfKYp0Z+qTgXrff53HZbnoikT7UDy3cIKv6nqWaq3Zaaroj2LaKB9wmVFEPKeL8at
        grnJuDetShCApaM8HmbQR/f8spR6myIEf43ayW8
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9143129729124953103
Message-ID: <B0DD4BA059591F13+4c61dc98-4d70-4ab2-b4ca-81c0e6596482@tinylab.org>
Date:   Sun, 27 Aug 2023 02:29:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] selftests/nolibc: fix up O= option support
Content-Language: en-GB
To:     Zhangjin Wu <falcon@tinylab.org>, w@1wt.eu
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux@weissschuh.net,
        thomas@t-8ch.de, Yuan Tan <tanyuan@tinylab.org>
References: <20230806121721.30774-1-falcon@tinylab.org>
 <20230826043046.53692-1-falcon@tinylab.org>
From:   Yuan Tan <tanyuan@tinylab.org>
In-Reply-To: <20230826043046.53692-1-falcon@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        RCVD_ILLEGAL_IP,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin and Willy,

On 8/26/2023 12:30 PM, Zhangjin Wu wrote:
> Hi, Willy
>
>>> On Sat, Aug 05, 2023 at 02:13:11PM +0800, Zhangjin Wu wrote:
>>>> To avoid pollute the source code tree and avoid mrproper for every
>>>> architecture switch, the O= argument must be supported.
>>>>
>>>> Both IMAGE and .config are from the building directory, let's use
>>>> objtree instead of srctree for them.
>>>>
>>>> If no O= option specified, means building kernel in source code tree,
>>>> objtree should be srctree in such case.
>>>>
>>>> To support relative path, as suggested by Thomas, $(COMMAND_O) is used
>>>> to pass the O=$(ABSOLUTE_O) to the $(MAKE) commands.
>>> Zhangjin, I cannot get this one to work, regardless of what I try:
>>>
>>>     $ make -j8 O=$PWD/output-i386 nolibc-test XARCH=i386 CROSS_COMPILE=/f/tc/nolibc/gcc-12.3.0-nolibc/i386-linux/bin/i386-linux- CC=/f/tc/nolibc/gcc-12.3.0-nolibc/i386-linux/bin/i386-linux-gcc
>>>     (...)
>>>     CC      nolibc-test
>>>     In file included from sysroot/i386/include/stdio.h:14,
>>>                      from nolibc-test.c:13:
>>>     sysroot/i386/include/errno.h:10:10: fatal error: asm/errno.h: No such file or directory
>>>        10 | #include <asm/errno.h>
>>>           |          ^~~~~~~~~~~~~
>>>     compilation terminated.
>>>
>> Willy, I also just reproduced the issue, seems only i386 sysroot has no
>> asm/errno.h, will check why it is no rightly installed later.
>>
>>      $ find sysroot/ -name "errno.h"
>>      sysroot/arm/include/errno.h
>>      sysroot/arm/include/asm-generic/errno.h
>>      sysroot/arm/include/asm/errno.h
>>      sysroot/arm/include/linux/errno.h
>>      sysroot/riscv/include/errno.h
>>      sysroot/riscv/include/asm-generic/errno.h
>>      sysroot/riscv/include/asm/errno.h
>>      sysroot/riscv/include/linux/errno.h
>>      sysroot/s390/include/errno.h
>>      sysroot/s390/include/asm-generic/errno.h
>>      sysroot/s390/include/asm/errno.h
>>      sysroot/s390/include/linux/errno.h
>>      sysroot/arm64/include/errno.h
>>      sysroot/arm64/include/asm-generic/errno.h
>>      sysroot/arm64/include/asm/errno.h
>>      sysroot/arm64/include/linux/errno.h
>>      sysroot/mips/include/errno.h
>>      sysroot/mips/include/asm-generic/errno.h
>>      sysroot/mips/include/asm/errno.h
>>      sysroot/mips/include/linux/errno.h
>>      sysroot/x86_64/include/errno.h
>>      sysroot/x86_64/include/asm-generic/errno.h
>>      sysroot/x86_64/include/asm/errno.h
>>      sysroot/x86_64/include/linux/errno.h
>>      sysroot/i386/include/errno.h
>>      sysroot/i386/include/asm-generic/errno.h
>>      sysroot/i386/include/linux/errno.h
>>      sysroot/powerpc/include/errno.h
>>      sysroot/powerpc/include/asm-generic/errno.h
>>      sysroot/powerpc/include/asm/errno.h
>>      sysroot/powerpc/include/linux/errno.h
>>
>>> I'll leave it aside for now as I've spent way longer than I hoped on
>>> these series. I could take the previous two patches however.
>>>
>> Ok, let's ignore this one, I will find why sysroot not install well for i386.
>>
> Thanks to Yuan, he have done some testing and have found the root cause, that
> is mrproper on top-level source code tree is required before installing
> sysroot, otherwise, the 'generated' headers will not be installed (removed by
> scripts/Makefile.asm-generic).

More specifically, building kernel will generate 
'linux/arch/x86/include/generated/uapi/asm/errno.h', which prevents 
nolibc-test with O= generate 
'output-x86/arch/x86/include/generated/asm/errno.h'.

>
> After mrproper (not with O=out, must on top-level source code tree), the
> asm/errno.h will be there:
>
>      ubuntu@linux-lab:/labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc$ find sysroot/ -name "errno.h"
>      sysroot/i386/include/errno.h
>      sysroot/i386/include/asm-generic/errno.h
>      sysroot/i386/include/asm/errno.h             --> here it is
>      sysroot/i386/include/linux/errno.h
>      sysroot/x86/include/errno.h
>      sysroot/x86/include/asm-generic/errno.h
>      sysroot/x86/include/asm/errno.h              --> here it is
>      sysroot/x86/include/linux/errno.h
>
> That also means, to use O=out for run-user, we also need to use O=out for
> defconfig (and kernel ...) too, otherwise, the top-level source code tree will
> be polluated.
>
> Seems a manual mrproper on top-level source code tree is always required for a
> new iteration, so, it may be ok to pick this patch with a note on the potential
> error.

There are two potential solutions for addressing this issue.

The first option involves copying 
'linux/arch/x86/include/generated/uapi/asm/' to 'sysroot/x86/include/' 
during the make of target headers_standalone.

The second approach entails displaying an error message when the code 
tree is not clean and prompting users to manually execute 'make 
mrproper'. In this case, we can utilize the target 'outputmakefile' from 
the root makefile directly.

Willy, which method do you prefer? Do you have any alternative 
suggestions? :)


Besides. using x86_64-linux-gnu- won't reproduce this issue. It searched 
and found 'asm/errno.h' in '/usr/include/x86_64-linux-gnu', whereas 
'x86_64-linux' lacks these libraries.

>
> Best Regards,
> Zhangjin
>
>> Thanks,
>> Zhangjin
>>
>>> Thanks,
>>> Willy

