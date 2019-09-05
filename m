Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 170DDAAA6B
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2019 19:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbfIER5I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Sep 2019 13:57:08 -0400
Received: from foss.arm.com ([217.140.110.172]:48170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729101AbfIER5I (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Sep 2019 13:57:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FB77337;
        Thu,  5 Sep 2019 10:57:07 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B7483F718;
        Thu,  5 Sep 2019 10:57:06 -0700 (PDT)
Subject: Re: [PATCH v5 01/11] kselftest: arm64: add skeleton Makefile
To:     Amit Kachhap <Amit.Kachhap@arm.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shuah@kernel.org" <shuah@kernel.org>
Cc:     "andreyknvl@google.com" <andreyknvl@google.com>,
        Dave P Martin <Dave.Martin@arm.com>
References: <20190902112932.36129-1-cristian.marussi@arm.com>
 <20190902112932.36129-2-cristian.marussi@arm.com>
 <cce97298-7a27-c470-6fc5-873b4447ecc9@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <e7b7b3fe-aba8-a4f2-400b-7cdeebd080e8@arm.com>
Date:   Thu, 5 Sep 2019 18:57:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cce97298-7a27-c470-6fc5-873b4447ecc9@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Amit

On 03/09/2019 10:26, Amit Kachhap wrote:
> 
> Hi Cristian,
> 
> On 9/2/19 4:59 PM, Cristian Marussi wrote:
>> Add a new arm64-specific empty subsystem amongst TARGETS of KSFT build
>> framework; keep these new arm64 KSFT testcases separated into distinct
>> subdirs inside tools/testing/selftests/arm64/ depending on the specific
>> subsystem targeted.
>>
>> Add into toplevel arm64 KSFT Makefile a mechanism to guess the effective
>> location of Kernel headers as installed by KSFT framework.
>>
>> Merge with
>>
>> commit 9ce1263033cd ("selftests, arm64: add a selftest for passing
>> 		     tagged pointers to kernel")
>>
>> while moving such KSFT tags tests inside their own subdirectory
>> (arm64/tags).
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>> v4 --> v5
>> - rebased on arm64/for-next/core
>> - merged this patch with KSFT arm64 tags patch, while moving the latter
>>    into its own subdir
>> - moved kernel header includes search mechanism from KSFT arm64
>>    SIGNAL Makefile
> This approach breaks the compilation of individual test cases which need 
> to export includes individually.
> 
> make -C tools/testing/selftests/arm64/signal
> 
> ../../lib.mk:25: ../../../../scripts/subarch.include: No such file or 
> directory
> Makefile:25: warning: overriding recipe for target 'clean'
> ../../lib.mk:123: warning: ignoring old recipe for target 'clean'
> make: *** No rule to make target '../../../../scripts/subarch.include'. 
> Stop.
> 
> However tags test works well,
> make -C tools/testing/selftests/arm64/tags
> 
> aarch64-none-linux-gnu-gcc     tags_test.c  -o 
> /home/amikac01/work/MTE_WORK/linux-server/linux/tools/testing/selftests/arm64/tags/tags_test
> 
> 
> Thanks,
> Amit Daniel
> 

So at the end I think I'll opt for the following in V6 regarding the issue of being able to build specific
KSFT arm64 subsystems while properly searching kernel headers (and keeping compatible with the KSFT
framework completely):

- only arm64 toplevel KSFT Makefile searches for the kernel headers location for all and propagates down the info

- you can also now optionally specify which arm64 subsystem to build (to avoid have to build, say, all of signal/
  if you are not interested into....a sort of standalone mode without all the burden of the old standalone mode)

So you can issue:

$ make TARGETS=arm64 kselftest

or similarly:

$ make -C tools/testing/selftests TARGETS=arm64 \
                INSTALL_PATH=<your-installation-path> install

or select subsystems:

$ make -C tools/testing/selftests TARGETS=arm64 SUBTARGETS="tags signal" \
                INSTALL_PATH=<your-installation-path> install

with all of the above looking for the K headers in the proper place and without
duplicating the search code in multiple places. (bugs apart :D)

Thanks

Cristian

>> - export proper top_srcdir ENV for lib.mk
>> v3 --> v4
>> - comment reword
>> - simplified documentation in README
>> - dropped README about standalone
>> ---
>>   tools/testing/selftests/Makefile              |  1 +
>>   tools/testing/selftests/arm64/Makefile        | 70 +++++++++++++++++--
>>   tools/testing/selftests/arm64/README          | 20 ++++++
>>   tools/testing/selftests/arm64/tags/Makefile   | 10 +++
>>   .../arm64/{ => tags}/run_tags_test.sh         |  0
>>   .../selftests/arm64/{ => tags}/tags_test.c    |  0
>>   6 files changed, 95 insertions(+), 6 deletions(-)
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
>> index a61b2e743e99..5dbb0ffdfc9a 100644
>> --- a/tools/testing/selftests/arm64/Makefile
>> +++ b/tools/testing/selftests/arm64/Makefile
>> @@ -1,11 +1,69 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2019 ARM Limited
>>   
>> -# ARCH can be overridden by the user for cross compiling
>> -ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>> +# When ARCH not overridden for crosscompiling, lookup machine
>> +ARCH ?= $(shell uname -m)
>> +ARCH := $(shell echo $(ARCH) | sed -e s/aarch64/arm64/)
>>   
>> -ifneq (,$(filter $(ARCH),aarch64 arm64))
>> -TEST_GEN_PROGS := tags_test
>> -TEST_PROGS := run_tags_test.sh
>> +ifeq ("x$(ARCH)", "xarm64")
>> +SUBDIRS := tags
>> +else
>> +SUBDIRS :=
>>   endif
>>   
>> -include ../lib.mk
>> +CFLAGS := -Wall -O2 -g
>> +
>> +# A proper top_srcdir is needed by KSFT(lib.mk)
>> +top_srcdir = ../../../../..
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
>> +
>> +CFLAGS += -I$(khdr_dir)
>> +
>> +export CC
>> +export CFLAGS
>> +export top_srcdir
>> +
>> +all:
>> +	@for DIR in $(SUBDIRS); do				\
>> +		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
>> +		mkdir -p $$BUILD_TARGET;			\
>> +		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
>> +	done
>> +
>> +install: all
>> +	@for DIR in $(SUBDIRS); do				\
>> +		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
>> +		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
>> +	done
>> +
>> +run_tests: all
>> +	@for DIR in $(SUBDIRS); do				\
>> +		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
>> +		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
>> +	done
>> +
>> +# Avoid any output on non arm64 on emit_tests
>> +emit_tests: all
>> +	@for DIR in $(SUBDIRS); do				\
>> +		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
>> +		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
>> +	done
>> +
>> +clean:
>> +	@for DIR in $(SUBDIRS); do				\
>> +		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
>> +		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
>> +	done
>> +
>> +.PHONY: all clean install run_tests emit_tests
>> diff --git a/tools/testing/selftests/arm64/README b/tools/testing/selftests/arm64/README
>> new file mode 100644
>> index 000000000000..aca892e62a6c
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/README
>> @@ -0,0 +1,20 @@
>> +KSelfTest ARM64
>> +===============
>> +
>> +- These tests are arm64 specific and so not built or run but just skipped
>> +  completely when env-variable ARCH is found to be different than 'arm64'
>> +  and `uname -m` reports other than 'aarch64'.
>> +
>> +- Holding true the above, ARM64 KSFT tests can be run within the KSelfTest
>> +  framework using standard Linux top-level-makefile targets:
>> +
>> +      $ make TARGETS=arm64 kselftest-clean
>> +      $ make TARGETS=arm64 kselftest
>> +
>> +      or
>> +
>> +      $ make -C tools/testing/selftests TARGETS=arm64 \
>> +		INSTALL_PATH=<your-installation-path> install
>> +
>> +   Further details on building and running KFST can be found in:
>> +     Documentation/dev-tools/kselftest.rst
>> diff --git a/tools/testing/selftests/arm64/tags/Makefile b/tools/testing/selftests/arm64/tags/Makefile
>> new file mode 100644
>> index 000000000000..76205533135b
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/tags/Makefile
>> @@ -0,0 +1,10 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# ARCH can be overridden by the user for cross compiling
>> +ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>> +
>> +ifneq (,$(filter $(ARCH),aarch64 arm64))
>> +TEST_GEN_PROGS := tags_test
>> +TEST_PROGS := run_tags_test.sh
>> +endif
>> +
>> +include ../../lib.mk
>> diff --git a/tools/testing/selftests/arm64/run_tags_test.sh b/tools/testing/selftests/arm64/tags/run_tags_test.sh
>> similarity index 100%
>> rename from tools/testing/selftests/arm64/run_tags_test.sh
>> rename to tools/testing/selftests/arm64/tags/run_tags_test.sh
>> diff --git a/tools/testing/selftests/arm64/tags_test.c b/tools/testing/selftests/arm64/tags/tags_test.c
>> similarity index 100%
>> rename from tools/testing/selftests/arm64/tags_test.c
>> rename to tools/testing/selftests/arm64/tags/tags_test.c
>>

