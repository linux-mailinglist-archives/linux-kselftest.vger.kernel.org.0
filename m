Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519271A8539
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Apr 2020 18:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391841AbgDNQjA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 12:39:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391830AbgDNQi6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 12:38:58 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C23D20678;
        Tue, 14 Apr 2020 16:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882337;
        bh=fh0CwTg9fVCUTMCmRwDo30VJ7gsfT2UR0AmvRtpphIQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eeFdZnCdLKvn1k846cWdOhUR8u4BkQgLABxQymSIwfnjsTJahYe3UzAO6QMUQ/OEf
         DXiVWQriEBloZXhonjlKOLh/+e2VMDpmwzTRWchYvhcuLPYQqBTKvC6eGHgBNvSyOh
         ya7cvVU35j0clIOn1S4K4ZmSrFBdISAQwpOZiDUY=
Subject: Re: [PATCH] selftest: add a script to perform selftest compile tests
To:     "Bird, Tim" <Tim.Bird@sony.com>, Tim Bird <tim@bird.org>
Cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tbird20d@gmail.com" <tbird20d@gmail.com>, shuah <shuah@kernel.org>
References: <86508e9d-4aff-d9a0-3783-971a4686ccd1@bird.org>
 <9c2a8679-eb90-8dd1-43f6-40ce0a842c87@kernel.org>
 <CY4PR13MB1527E216D153ADDFE747F485FDDA0@CY4PR13MB1527.namprd13.prod.outlook.com>
From:   shuah <shuah@kernel.org>
Message-ID: <56a085c6-96fa-d5ad-086f-359dd3008fed@kernel.org>
Date:   Tue, 14 Apr 2020 10:38:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CY4PR13MB1527E216D153ADDFE747F485FDDA0@CY4PR13MB1527.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/14/20 10:06 AM, Bird, Tim wrote:
>> -----Original Message-----
>> From: shuah <shuah@kernel.org>
>>
>> On 4/13/20 4:15 PM, Tim Bird wrote:
>>> From: Tim Bird <tim.bird@sony.com>
>>>
>>> Add ksft-compile-test.sh.  This is a program used to test
>>> cross-compilation and installation of selftest tests.
>>>
>>> See the test usage for help
>>>
>>> This program currently tests 3 scenarios out of a larger matrix
>>> of possibly interesting scenarios.  For each scenario, it conducts
>>> multiple tests for correctness.  This version tests:
>>>    1) does the test compile
>>
>> Is it necessary to write this long a script? Could we just parse
>> the "kselftest
> ???
> 

Sorry for the dangling sentence. :) Can we parse the make kselftest-all
output instead?

>>>    2) is the kernel source directory clean after the compile
>>
>> Can you use make mrproper and see if anything needs cleaning?
> I'll check into this.  Does 'make mrproper' return an error code if
> it found something that needed cleaning?  Or do I have to parse
> stuff.  The actual code to check if the directory is clean is pretty
> short.
> 
>>
>>>    3) does the test install operation succeed
>>>    4) does the test run script reference the test
>>>
>>
>> I like the idea of being able to test, however I am not convinced
>> you would need a whole new script for it.
> 
> The current build system is broken in a few different ways.
> I have only enabled a few test cases out of the test matrix, to
> be able to isolate some of the obvious problems from individual
> target areas.  One of the reasons I wrote a full script was to more easily
> enable additional tests, once functionality in the current build
> system was fixed, to notify us of regressions going forward.
> 
>>

I still want to see a way to use output from build and install
steps and parse it, instead of a whole new script.

>>
>>> Signed-off-by: Tim Bird <tim.bird@sony.com>
>>> ---
>>>    MAINTAINERS                                  |   6 +
>>>    tools/testing/selftests/ksft-compile-test.sh | 567 +++++++++++++++++++++++++++
>>>    2 files changed, 573 insertions(+)
>>>    create mode 100755 tools/testing/selftests/ksft-compile-test.sh
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index cc1d18c..a6289c7 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -9127,6 +9127,12 @@ S:	Maintained
>>>    F:	tools/testing/selftests/
>>>    F:	Documentation/dev-tools/kselftest*
>>>
>>> +KERNEL SELFTEST SELFTEST
>>> +M:	Tim Bird <tim.bird@sony.com>
>>> +L:	linux-kselftest@vger.kernel.org
>>> +S:	Maintained
>>> +F:	tools/testing/selftests/ksft-compile-test.sh
>>> +
>>
>> Please don't add another entry to the MAINTAINERS file just
>> for a shell script under tools/testing/selftests
>>
>> This doesn't make sense.
> OK. I only added this to eliminate a checkpatch.pl warning.
> It seems like overkill to me also, but I was trying to obey the tools.
> :-)
> 
> Maybe that warning from checkpatch is too aggressive?
> 

Yeah. checkpatch warn in this case is reminder in case a new entry
is needed. A new entry isn't necessary in most cases.

>>
>>>    KERNEL UNIT TESTING FRAMEWORK (KUnit)
>>>    M:	Brendan Higgins <brendanhiggins@google.com>
>>>    L:	linux-kselftest@vger.kernel.org
>>> diff --git a/tools/testing/selftests/ksft-compile-test.sh b/tools/testing/selftests/ksft-compile-test.sh
>>> new file mode 100755
>>> index 0000000..e36e858
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/ksft-compile-test.sh
>>> @@ -0,0 +1,567 @@
>>> +#!/bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0-only OR MIT
>>> +#
>>> +# ksft-compile-test.sh - test compiling Linux kernel selftests under lots of
>>> +#   different configurations.  This is used to check that cross-compilation
>>> +#   and install works properly for a newly submitted test target, and
>>> +#   also that changes to existing test Makefiles don't regress with regard to
>>> +#   this functionality.
>>> +#
>>> +# Copyright 2020 Sony Corporation
>>> +#
>>> +# Here are the things that Shuah Kahn asked for on 3/6/2020
>>> +# 1. Cross-compilation & relocatable build support
>>> +# 2. Generates objects in objdir/kselftest without cluttering main objdir
>>> +# 3. Leave source directory clean
>>> +# 4. Installs correctly in objdir/kselftest/kselftest_install and adds
>>> +#        itself to run_kselftest.sh script generated during install.
>>> +#
>>
>> I was asking for fixes to individual tests.
> Well, I used this to find some things to fix.  I have some patches queued,
> but I thought the tool might be useful for others.  I'll send the patches
> instead of posting the tool.
> 
>>
>>> +# Would be nice to make sure other features also work:
>>> +# 5. can use absolute, relative, or current directory for output directory
>>> +# 6. can use ~ in output directory path
>>> +#
>>
>> I do think this can be achieved with a simpler script wrapper around
>> existing commands and kselftest_install.sh instead of writing a whole
>> new shell script.
> 
> Well, my pain point is the build system itself, not kselftest_install.sh.
> There are still some bugs in the build system, and it appears that people
> still sometimes submit new tests with subtle problems compiling under
> different build configurations.
> 

Agreed. I think it is still a better idea to parse to find error and
display them.

> My goal was to be able to test a whole matrix of build configurations,
> to detect these problems.  But making a generic system to test a matrix
> of configurations requires more than just putting together a few wrapper
> scripts.  However, I'm not as familiar with the existing commands as you
> are, so maybe I missed some functionality I could reuse.
> 

Right. Hence the reason why I am asking if you explored using exiting
parsing build and install output. Approaching this as a parsing also
reduces maintenance overhead for this script. I am not questioning the
value of the script, I am asking about the approach.

> One of the significant problems here, IMO, is that since most kernel developers
> don't cross-compile, it introduces a whole range of potential
> errors in the build system that they can't really test for.
>

We have efforts such as lkft and soon kernelci do cross-compiles.
powerpc tests have good coverage and so do arm. The problem is tests
that can run on multiple architectures at times come in without good
support.

>I'm happy to leave this outside the kernel tree, and provide 'testing as a service'
>  >by Fuego!) to find bugs in the kselftest build system.  In that case, 
I'll just report
>bugs that this finds (along with fixes where possible).
Testing as service by Fuego and fixes to problems you find is great.

thanks,
-- Shuah

