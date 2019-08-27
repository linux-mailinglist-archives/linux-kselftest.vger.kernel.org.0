Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7C0F9E777
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2019 14:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfH0MOc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Aug 2019 08:14:32 -0400
Received: from foss.arm.com ([217.140.110.172]:43630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbfH0MOb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Aug 2019 08:14:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF1ED28;
        Tue, 27 Aug 2019 05:14:30 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 067B43F718;
        Tue, 27 Aug 2019 05:14:29 -0700 (PDT)
Subject: Re: [PATCH v3 01/11] kselftest: arm64: introduce new boilerplate code
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
References: <20190802170300.20662-1-cristian.marussi@arm.com>
 <20190802170300.20662-2-cristian.marussi@arm.com>
 <20190813162337.GY10425@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <c6fdb61f-10c9-8c5f-112b-e2072b578c6e@arm.com>
Date:   Tue, 27 Aug 2019 13:14:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813162337.GY10425@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi

On 13/08/2019 17:23, Dave Martin wrote:
> ^ Regarding the subject line, "boilerplate code" sounds a bit vague.
> Could we say something like "Add skeleton Makefile"?
> 

Yes of course.

> On Fri, Aug 02, 2019 at 06:02:50PM +0100, Cristian Marussi wrote:
>> Added a new arm64-specific empty subsystem amongst TARGETS of KSFT build
>> framework; once populated with testcases, it will be possible to build
>> and invoke the new KSFT TARGETS=arm64 related tests from the toplevel
>> Makefile in the usual ways.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>> Reviewed the build instructions reported in the README, to be more
>> agnostic regarding user/device etc..
>> ---
>>  tools/testing/selftests/Makefile       |  1 +
>>  tools/testing/selftests/arm64/Makefile | 51 ++++++++++++++++++++++++++
>>  tools/testing/selftests/arm64/README   | 43 ++++++++++++++++++++++
>>  3 files changed, 95 insertions(+)
>>  create mode 100644 tools/testing/selftests/arm64/Makefile
>>  create mode 100644 tools/testing/selftests/arm64/README
>>
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> index 25b43a8c2b15..1722dae9381a 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -1,5 +1,6 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  TARGETS = android
>> +TARGETS += arm64
>>  TARGETS += bpf
>>  TARGETS += breakpoints
>>  TARGETS += capabilities
>> diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
>> new file mode 100644
>> index 000000000000..03a0d4f71218
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/Makefile
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2019 ARM Limited
>> +
>> +# When ARCH not overridden for crosscompiling, lookup machine
>> +ARCH ?= $(shell uname -m)
>> +ARCH := $(shell echo $(ARCH) | sed -e s/aarch64/arm64/)
>> +
>> +ifeq ("x$(ARCH)", "xarm64")
>> +SUBDIRS :=
>> +else
>> +SUBDIRS :=
>> +endif
>> +
>> +CFLAGS := -Wall -O2 -g
>> +
>> +export CC
>> +export CFLAGS
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
>> index 000000000000..dee3306071cc
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/README
>> @@ -0,0 +1,43 @@
>> +KSelfTest ARM64
>> +===============
>> +
>> +- These tests are arm64 specific and so not built or run but just skipped
>> +  completely when env-variable ARCH is found to be different than 'arm64'
>> +  and `uname -m` reports other than 'aarch64'.
>> +
>> +- Holding true the above, ARM64 KSFT tests can be run:
>> +
>> +   + as standalone (example for signal tests)
>> +
>> +      $ make -C tools/testing/selftest/arm64/signal \
>> +		INSTALL_PATH=<your-installation-path> install
>> +
>> +      and then launching on the target device inside the installed path:
>> +
>> +      $ <your-installed-path>/test_arm64_signals.sh [-k | -v]
>> +
>> +   + within the KSelfTest framework using standard Linux top-level-makefile
>> +     targets:
>> +
>> +      $ make TARGETS=arm64 kselftest-clean
>> +      $ make TARGETS=arm64 kselftest
>> +
>> +   Further details on building and running KFST can be found in:
>> +     Documentation/dev-tools/kselftest.rst
> 
> The next two paragraphs aren't relevant yet.  Can we split them out of
> this patch and add them alongside the relevant code / Makefile changes?
> 

Sure. I'm going to remove also standalone mode in V4 as elsewhere advised,
so I'll drop part of this README too.

>> +
>> +- Tests can depend on some arch-specific definitions which can be found in a
>> +  standard Kernel Headers installation in $(top_srcdir)/usr/include.
>> +  Such Kernel Headers are automatically installed (via make headers_install)
>> +  by KSFT framework itself in a dedicated directory when tests are launched
>> +  via KSFT itself; when running standalone, instead, a Warning is issued
>> +  if such headers cannot be found somewhere (we try to guess a few standard
>> +  locations anyway)
>> +
>> +- Some of these tests may be related to possibly not implemented ARMv8
>> +  features: depending on their implementation status on the effective HW
>> +  we'll expect different results. The tests' harness will take care to check
>> +  at run-time if the required features are supported and will act accordingly.
>> +  Moreover, in order to avoid any kind of compile-time dependency on the
>> +  toolchain (possibly due to the above mentioned not-implemented features),
>> +  we make strictly use of direct 'S3_ sysreg' raw-encoding while checking for
>> +  those features and/or lookin up sysregs.
> 
> This last paragraph is only relevant for people adding new tests.  It
> probably makes sense to start "When adding new tests, try to avoid
> unnecessary toolchain dependencies where possible. [...]"
> 
> Cheers
> ---Dave
> 

Cheers

Cristian

