Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0867767476
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2019 19:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfGLRnP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jul 2019 13:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfGLRnP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jul 2019 13:43:15 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5156A204FD;
        Fri, 12 Jul 2019 17:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562953394;
        bh=fQSIe0GDJ1Esx5HpoVZILdLeb+GmoI11koAACMjA4l8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YIG25xQwRkz5KwNLsvGBvAicjY1gl0PmlVhSbePyJNVNWW0meQeU0cSjfaXyKx23P
         TJGHTwxIjj027UK95GnPEybdwXtkH0wL9lgDo5aB1WnbKp7H8w5wt3lG66jc2/JWUs
         1C/amjKybId6hSaD94C2TYVFmQaj476c/lenQ99A=
Subject: Re: [RFC PATCH] selftests/livepatch: only consider supported arches
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190712171402.15930-1-joe.lawrence@redhat.com>
 <20190712172517.GA15872@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <eec9376b-8c0d-8f09-59cb-e38839b13368@kernel.org>
Date:   Fri, 12 Jul 2019 11:43:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712172517.GA15872@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Joe,

On 7/12/19 11:25 AM, Joe Lawrence wrote:
> On Fri, Jul 12, 2019 at 01:14:02PM -0400, Joe Lawrence wrote:
>> Only run the livepatching self-tests on x86_64 and ppc64le arches.
>>
>> Reported-by: Jiri Benc <jbenc@redhat.com>
>> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
>> ---
>>   tools/testing/selftests/livepatch/Makefile | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
>> index fd405402c3ff..9842fb473d42 100644
>> --- a/tools/testing/selftests/livepatch/Makefile
>> +++ b/tools/testing/selftests/livepatch/Makefile
>> @@ -1,5 +1,16 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   
>> +ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>> +
>> +ifeq ($(ARCH),x86_64)
>> +livepatch_supported := 1
>> +endif
>> +ifeq ($(ARCH),ppc64le)
>> +livepatch_supported := 1
>> +endif
>> +
>> +ifdef livepatch_supported
>> +
>>   TEST_PROGS_EXTENDED := functions.sh
>>   TEST_PROGS := \
>>   	test-livepatch.sh \
>> @@ -7,3 +18,5 @@ TEST_PROGS := \
>>   	test-shadow-vars.sh
>>   
>>   include ../lib.mk
>> +
>> +endif
>> -- 
>> 2.21.0
>>
> 
> Hi Shuah,
> 
> This was change was a quick and dirty fix to avoid inadvertent errors
> reported by run_kselftest.sh on arches unsupported by livepatch.
> 
> Ideally we would check CONFIG_TEST_LIVEPATCH instead of the arches
> directly:  This would allow distros to "turn off" this particular set of
> selftests through the kernel configuration.  Also, setting
> CONFIG_TEST_LIVEPATCH=m determines whether supporting livepatch
> self-test modules (in lib/livepatch) will be built.  Without it, these
> self-test scripts are useless.
> 

I was just about to send you email about looking into using config
fragments.

Looks like there is a tools/testing/selftests/livepatch/config

CONFIG_TEST_LIVEPATCH=m

> However, I didn't see that $(CONFIG_TEST_LIVEPATCH) was set when
> invoking tools/testing/selftests/livepatch/Makefile.  I don't know how
> tools/testing/selftests/vDSO/Makefile is using $(CONFIG_X86_32) but
> perhaps that isn't working either.
> 
> Any suggestions?  Should we modify the test scripts themselves to deal
> with a !CONFIG_TEST_LIVEPATCH environment?
> 

Looks livepatch tests are shell scripts and there is nothing to build.
So the build time check of having a config fragment won't work for this
case.

test-livepatch.sh loads test_klp_livepatch and test_klp_atomic_replace
functions.sh has the handling for modprobing livepatch module.

The one thing I am not seeing is Skip handling. Without that users will
complain livepatch test is failing as opposed to that the test can't
run due to unmet dependencies and skipped.

Maybe that is all you need? I would recommend going in that direction
instead of Arch check.

thanks,
-- Shuah

