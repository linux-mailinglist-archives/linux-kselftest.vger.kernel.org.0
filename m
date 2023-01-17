Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD22566E561
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jan 2023 18:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjAQR4S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 12:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjAQRyG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 12:54:06 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3132D15E;
        Tue, 17 Jan 2023 09:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1673977424;
        bh=xrIKUGe8CLyHmxRLx6Hzuh76lN+rhMVKog4Uv42rN2E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uuIqdW2IztROMrEGf76dPtwjtPK93hfn5wdWqx/JY1IKD2sizRAy/7d0QmgL8acEv
         BWncGuYLk3893+3jhTzRtovo3saiow8uyjb0eEvBy5V8uvEUmqvIWNQMgTmlVfo7X7
         LDy3aMWEzd6Z2+S90+04UDNDOlpvromkQcT/hpLUfAATf8Hu0UEEmiDUxq4pVP/egN
         kWLchRTb1H28OHnnON+3Yd//fFptnkFPOyTkbZEQGHw0j1/ca3c11GwPQkCRc/Nku6
         zCfxVWZ/hCsObtpBlMQUUoxq7iGeRXui5kDth31ycMMpSncc5B/nPG2cWjWQ6dgh77
         9EP1PJcvdCLOQ==
Received: from [172.16.0.101] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NxGTW5bYbzgh4;
        Tue, 17 Jan 2023 12:43:43 -0500 (EST)
Message-ID: <37625f31-6ac2-1f90-d864-e4644820bba3@efficios.com>
Date:   Tue, 17 Jan 2023 12:44:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [tip:sched/core 7/28] rseq.c:139:37: error: 'AT_RSEQ_ALIGN'
 undeclared; did you mean 'R_SH_ALIGN'?
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kernel test robot <lkp@intel.com>, Shuah Khan <shuah@kernel.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        linux-kselftest@vger.kernel.org
References: <202301170348.7WLKH1pl-lkp@intel.com>
 <bfa719c3-bd1f-5fc4-40ab-6dc6822b7628@efficios.com>
 <4449d8b5-b7a5-0f09-5b42-7b70ba00f8f6@linuxfoundation.org>
 <Y8ZlKOsN1wGk9tTc@gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <Y8ZlKOsN1wGk9tTc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-01-17 04:06, Ingo Molnar wrote:
> 
> * Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 1/16/23 13:18, Mathieu Desnoyers wrote:
>>> On 2023-01-16 14:40, kernel test robot wrote:
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
>>>> head:   79ba1e607d68178db7d3fe4f6a4aa38f06805e7b
>>>> commit: 03f5c0272d1b59343144e199becc911dae52c37e [7/28] selftests/rseq: Use ELF auxiliary vector for extensible rseq
>>>> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
>>>> reproduce:
>>>>           # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=03f5c0272d1b59343144e199becc911dae52c37e
>>>>           git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>>>>           git fetch --no-tags tip sched/core
>>>>           git checkout 03f5c0272d1b59343144e199becc911dae52c37e
>>>>           make O=/tmp/kselftest headers
>>>>           make O=/tmp/kselftest -C tools/testing/selftests
>>>>
>>>> If you fix the issue, kindly add following tag where applicable
>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> In order to fix this, I need to change -I../../../../usr/include/ for $(KHDR_INCLUDES) in tools/testing/selftests/rseq/Makefile
>>>
>>> I can find 25 odd uses of the same pattern in the kernel selftests. Should I fix them all in one go ?
>>
>> kselftest build depends on headers installed in the root directory.

By "root directory", do you mean kernel sources root directory or build 
output root directory ?

>> The main makefile enforces this dependency.

How ? I figure that tools/testing/selftests/lib.mk overrides 
KHDR_INCLUDES if it is not defined yet:

ifeq ($(KHDR_INCLUDES),)
KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
endif

and selftests makefiles include ../lib.mk.

This KHDR_INCLUDES can be modified by O=... when built from the kernel 
top level, thus using tools/testing/selftests/Makefile:

ifneq ($(KBUILD_OUTPUT),)
[...]
   KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
else
[...]
   KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
endif

But it's up to the individual selftests to actually use 
$(KHDR_INCLUDES). In many cases, they hardcode 
-I../../../../usr/include/ which is bogus when the build root (O=...) 
differs from the source root.

  If this test is being
>> built without installing headers by itself, I think the scripts that
>> build individual tests have to makes sure headers are installed first.

The headers were previously built by "make O=/tmp/kselftest headers", as 
it should, it's just that the selftest makefile uses a hardcoded path 
that is relative to the source directory, and it appears that this 
pattern is repeated all across the selftests.

> 
> Why isn't the Makefile saying anything about it & enforcing it? self-tests
> are usually self-sufficient to build in the individual directories.

In an ideal world, we'd have a way to _remove_ the build environment 
kernel headers from the include search paths, because this is a problem 
for reproducibility of the tests.

Thanks,

Mathieu

> 
> Thanks,
> 
> 	Ingo

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

