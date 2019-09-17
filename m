Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0717DB52CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2019 18:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfIQQS6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Sep 2019 12:18:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfIQQS6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Sep 2019 12:18:58 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC94720665;
        Tue, 17 Sep 2019 16:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568737137;
        bh=Jhfok+KlsSFZtyo9A8SLf3rtjgaNyjEHNBclkCtKnvY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=H1w9E3KnLMoMQ8CCBOx5fcOomIW8c5TFTpnlNb9K06bqQrpRYxIkD6Np1n6qmF3CR
         jH+qpL0/DHNwm6Nxxs6gVdL5DfM5r7lIkh2B9VyWlIVHJ21g5Vf0hy3hkJOjkaO8wr
         S/qRt9pCe/JRPNfYt74SR2RpiAeFmRyL8CIscA1E=
Subject: Re: [PATCH v6 01/11] kselftest: arm64: extend toplevel skeleton
 Makefile
To:     Dave Martin <Dave.Martin@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, amit.kachhap@arm.com,
        andreyknvl@google.com, shuah <shuah@kernel.org>
References: <20190910123111.33478-1-cristian.marussi@arm.com>
 <20190910123111.33478-2-cristian.marussi@arm.com>
 <20190917160534.GK27757@arm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <119aaea7-10b5-0fdf-269d-e86df07b4831@kernel.org>
Date:   Tue, 17 Sep 2019 10:18:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917160534.GK27757@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/17/19 10:05 AM, Dave Martin wrote:
> On Tue, Sep 10, 2019 at 01:31:01pm +0100, Cristian Marussi wrote:
>> Modify KSFT arm64 toplevel Makefile to maintain arm64 kselftests organized
>> by subsystem, keeping them into distinct subdirectories under arm64 custom
>> KSFT directory: tools/testing/selftests/arm64/
>>
>> Add to such toplevel Makefile a mechanism to guess the effective location
>> of Kernel headers as installed by KSFT framework.
>>
>> Fit existing arm64 tags kselftest into this new schema moving them into
>> their own subdirectory (arm64/tags).
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>> Based on:
>> commit 9ce1263033cd ("selftests, arm64: add a selftest for passing
>> 		     tagged pointers to kernel")
>> ---
>> v5 --> v6
>> - using realpath to avoid passing down relative paths
>> - fix commit msg & Copyright
>> - removed unneded Makefile export
>> - added SUBTARGETS specification, to allow building specific only some
>>    arm64 test subsystems
>> v4 --> v5
>> - rebased on arm64/for-next/core
>> - merged this patch with KSFT arm64 tags patch, while moving the latter
>>    into its own subdir
>> - moved kernel header includes search mechanism from KSFT arm64
>>    SIGNAL Makefile
>> - export proper top_srcdir ENV for lib.mk
>> v3 --> v4
>> - comment reword
>> - simplified documentation in README
>> - dropped README about standalone
>> ---
>>   tools/testing/selftests/Makefile              |  1 +
>>   tools/testing/selftests/arm64/Makefile        | 63 +++++++++++++++++--
>>   tools/testing/selftests/arm64/README          | 25 ++++++++
>>   tools/testing/selftests/arm64/tags/Makefile   |  6 ++
>>   .../arm64/{ => tags}/run_tags_test.sh         |  0
>>   .../selftests/arm64/{ => tags}/tags_test.c    |  0
>>   6 files changed, 91 insertions(+), 4 deletions(-)
>>   create mode 100644 tools/testing/selftests/arm64/README
>>   create mode 100644 tools/testing/selftests/arm64/tags/Makefile
>>   rename tools/testing/selftests/arm64/{ => tags}/run_tags_test.sh (100%)
>>   rename tools/testing/selftests/arm64/{ => tags}/tags_test.c (100%)
>>
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> index 25b43a8c2b15..1722dae9381a 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -1,5 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   TARGETS = android
>> +TARGETS += arm64
>>   TARGETS += bpf
>>   TARGETS += breakpoints
>>   TARGETS += capabilities
>> diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
>> index a61b2e743e99..cbb2a5a9e3fc 100644
>> --- a/tools/testing/selftests/arm64/Makefile
>> +++ b/tools/testing/selftests/arm64/Makefile
>> @@ -1,11 +1,66 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   
>> -# ARCH can be overridden by the user for cross compiling
>> +# When ARCH not overridden for crosscompiling, lookup machine
>>   ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>>   
>>   ifneq (,$(filter $(ARCH),aarch64 arm64))
>> -TEST_GEN_PROGS := tags_test
>> -TEST_PROGS := run_tags_test.sh
>> +SUBTARGETS ?= tags
>> +else
>> +SUBTARGETS :=
>>   endif
>>   
>> -include ../lib.mk
>> +CFLAGS := -Wall -O2 -g
>> +
>> +# A proper top_srcdir is needed by KSFT(lib.mk)
>> +top_srcdir = $(realpath ../../../../)
>> +
>> +# Additional include paths needed by kselftest.h and local headers
>> +CFLAGS += -I$(top_srcdir)/tools/testing/selftests/
>> +
>> +# Guessing where the Kernel headers could have been installed
>> +# depending on ENV config
>> +ifeq ($(KBUILD_OUTPUT),)
>> +khdr_dir = $(top_srcdir)/usr/include
>> +else
>> +# the KSFT preferred location when KBUILD_OUTPUT is set
>> +khdr_dir = $(KBUILD_OUTPUT)/kselftest/usr/include
>> +endif
> 
> I still tend to think that for now we should just do what all the other
> tests do.
> 
> Most tests use
> 
> 	CFLAGS += -I../../../../usr/include/
> 
> in their Makefiles.
> 
> For us, the test Makefiles are nested one level deeper, so I guess
> we would put
> 
> 	CFLAGS += -I../../../../../usr/include/
> 
> in each.
> 
> 
> This will break in some cases, but only in the same cases where
> kselftest is already broken.
> 
> Ideally we would fix this globally, but can that instead be done
> independently of this series?
> 
> Fixing only arm64, by pasting some arbitrary logic from
> selftests/Makefile doesn't seem like a future-proof approach.
> 
> 
> Or did I miss something?
> 
>> +
>> +CFLAGS += -I$(khdr_dir)
>> +
>> +export CFLAGS
>> +export top_srcdir
>> +
>> +all:
>> +	@for DIR in $(SUBTARGETS); do				\
>> +		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
>> +		mkdir -p $$BUILD_TARGET;			\
>> +		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
>> +	done
>> +
>> +install: all
>> +	@for DIR in $(SUBTARGETS); do				\
>> +		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
>> +		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
>> +	done
>> +
>> +run_tests: all
>> +	@for DIR in $(SUBTARGETS); do				\
>> +		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
>> +		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
>> +	done
>> +
>> +# Avoid any output on non arm64 on emit_tests
> 
> This comment can be dropped: the whole file does nothing for
> non-arm64, and it achieves it in the same way as other arch-specific
> Makefiles, so it's odd to have the comment here specifically (?)
> 
> 
> With or without the above changes, I'm happy to give
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> 
> (but Shuah or someone will need to give a view on how this integrates
> with kselftest overall).
> 

I am reviewing the series this week. I will provide comments in a
day or two.

thanks,
-- Shuah
