Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6142574EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Aug 2020 10:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHaIFq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Aug 2020 04:05:46 -0400
Received: from foss.arm.com ([217.140.110.172]:54798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgHaIFp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Aug 2020 04:05:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA1AE31B;
        Mon, 31 Aug 2020 01:05:44 -0700 (PDT)
Received: from [10.57.6.112] (unknown [10.57.6.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4557B3F68F;
        Mon, 31 Aug 2020 01:05:42 -0700 (PDT)
Subject: Re: [PATCH 1/4] kselftests/arm64: add a basic Pointer Authentication
 test
To:     Boyan Karatotev <boyan.karatotev@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     vincenzo.frascino@arm.com, boian4o1@gmail.com,
        Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20200828131606.7946-1-boyan.karatotev@arm.com>
 <20200828131606.7946-2-boyan.karatotev@arm.com>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <ec48c4c2-7034-ddfe-2120-85e7856dc062@arm.com>
Date:   Mon, 31 Aug 2020 13:35:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200828131606.7946-2-boyan.karatotev@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Boyan,

On 8/28/20 6:46 PM, Boyan Karatotev wrote:
> PAuth signs and verifies return addresses on the stack. It does so by
> inserting a Pointer Authentication code (PAC) into some of the unused top
> bits of an address. This is achieved by adding paciasp/autiasp instructions
> at the beginning and end of a function.
> 
> This feature is partially backwards compatible with earlier versions of the
> ARM architecture. To coerce the compiler into emitting fully backwards
> compatible code the main file is compiled to target an earlier ARM version.
> This allows the tests to check for the feature and print meaningful error
> messages instead of crashing.
> 
> Add a test to verify that corrupting the return address results in a
> SIGSEGV on return.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>
> ---
>   tools/testing/selftests/arm64/Makefile        |  2 +-
>   .../testing/selftests/arm64/pauth/.gitignore  |  1 +
>   tools/testing/selftests/arm64/pauth/Makefile  | 22 ++++++++++++
>   tools/testing/selftests/arm64/pauth/helper.h  | 10 ++++++
>   tools/testing/selftests/arm64/pauth/pac.c     | 32 +++++++++++++++++
>   .../selftests/arm64/pauth/pac_corruptor.S     | 36 +++++++++++++++++++
>   6 files changed, 102 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/arm64/pauth/.gitignore
>   create mode 100644 tools/testing/selftests/arm64/pauth/Makefile
>   create mode 100644 tools/testing/selftests/arm64/pauth/helper.h
>   create mode 100644 tools/testing/selftests/arm64/pauth/pac.c
>   create mode 100644 tools/testing/selftests/arm64/pauth/pac_corruptor.S
> 
> diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
> index 93b567d23c8b..525506fd97b9 100644
> --- a/tools/testing/selftests/arm64/Makefile
> +++ b/tools/testing/selftests/arm64/Makefile
> @@ -4,7 +4,7 @@
>   ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>   
>   ifneq (,$(filter $(ARCH),aarch64 arm64))
> -ARM64_SUBTARGETS ?= tags signal
> +ARM64_SUBTARGETS ?= tags signal pauth
>   else
>   ARM64_SUBTARGETS :=
>   endif
> diff --git a/tools/testing/selftests/arm64/pauth/.gitignore b/tools/testing/selftests/arm64/pauth/.gitignore
> new file mode 100644
> index 000000000000..b557c916720a
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/pauth/.gitignore
> @@ -0,0 +1 @@
> +pac
> diff --git a/tools/testing/selftests/arm64/pauth/Makefile b/tools/testing/selftests/arm64/pauth/Makefile
> new file mode 100644
> index 000000000000..785c775e5e41
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/pauth/Makefile
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 ARM Limited
> +
> +CFLAGS += -mbranch-protection=pac-ret

There is no CFLAGS validation present which may give error with non 
supported compiler.

Can you add a check something like,

+#check if the compiler works well
+pauth_cc_support := $(shell if ($(CC) $(CFLAGS) -march=armv8.3-a -E -x 
c /dev/null -o /dev/null 2>&1) then echo "1"; fi)
+
+ifeq ($(pauth_cc_support),1)
  TEST_GEN_PROGS := pac
  TEST_GEN_FILES := pac_corruptor.o
+endif

  include ../../lib.mk

+ifeq ($(pauth_cc_support),1)
  # pac* and aut* instructions are not available on architectures berfore
  # ARMv8.3. Therefore target ARMv8.3 wherever they are used directly
  $(OUTPUT)/pac_corruptor.o: pac_corruptor.S
@@ -19,4 +25,4 @@ $(OUTPUT)/pac_corruptor.o: pac_corruptor.S
  # run on earlier targets and print a meaningful error messages
  $(OUTPUT)/pac: pac.c $(OUTPUT)/pac_corruptor.o
         $(CC) $^ -o $@ $(CFLAGS) -march=armv8.2-a
-
+endif

> +
> +TEST_GEN_PROGS := pac
> +TEST_GEN_FILES := pac_corruptor.o
> +
> +include ../../lib.mk
> +
> +# pac* and aut* instructions are not available on architectures berfore
> +# ARMv8.3. Therefore target ARMv8.3 wherever they are used directly
> +$(OUTPUT)/pac_corruptor.o: pac_corruptor.S
> +	$(CC) -c $^ -o $@ $(CFLAGS) -march=armv8.3-a
> +
> +# when -mbranch-protection is enabled and the target architecture is ARMv8.3 or
> +# greater, gcc emits pac* instructions which are not in HINT NOP space,
> +# preventing the tests from occurring at all. Compile for ARMv8.2 so tests can
> +# run on earlier targets and print a meaningful error messages
> +$(OUTPUT)/pac: pac.c $(OUTPUT)/pac_corruptor.o
> +	$(CC) $^ -o $@ $(CFLAGS) -march=armv8.2-a
> +
> diff --git a/tools/testing/selftests/arm64/pauth/helper.h b/tools/testing/selftests/arm64/pauth/helper.h
> new file mode 100644
> index 000000000000..f777f88acf0a
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/pauth/helper.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2020 ARM Limited */
> +
> +#ifndef _HELPER_H_
> +#define _HELPER_H_
> +
> +void pac_corruptor(void);
> +
> +#endif
> +

Please delete extra line at end of file here and other places too.

Other changes look fine for me. After the suggested changes please free 
to add,
Reviewed-by: Amit Daniel Kachhap <amit.kachhap@arm.com>

Thanks,
Amit Daniel


> diff --git a/tools/testing/selftests/arm64/pauth/pac.c b/tools/testing/selftests/arm64/pauth/pac.c
> new file mode 100644
> index 000000000000..ed445050f621
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/pauth/pac.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2020 ARM Limited
> +
> +#include <sys/auxv.h>
> +#include <signal.h>
> +
>
