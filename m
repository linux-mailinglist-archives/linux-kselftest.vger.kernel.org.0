Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529F3255C6B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Aug 2020 16:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgH1O2t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Aug 2020 10:28:49 -0400
Received: from foss.arm.com ([217.140.110.172]:50684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgH1O2s (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Aug 2020 10:28:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32F8D1FB;
        Fri, 28 Aug 2020 07:28:47 -0700 (PDT)
Received: from [192.168.1.190] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE1133F71F;
        Fri, 28 Aug 2020 07:28:45 -0700 (PDT)
Subject: Re: [PATCH 2/4] kselftests/arm64: add nop checks for PAuth tests
To:     Boyan Karatotev <boyan.karatotev@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     amit.kachhap@arm.com, boian4o1@gmail.com,
        Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20200828131606.7946-1-boyan.karatotev@arm.com>
 <20200828131606.7946-3-boyan.karatotev@arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <96f6009c-9f61-ebd2-9a2f-7d54486e85eb@arm.com>
Date:   Fri, 28 Aug 2020 15:30:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828131606.7946-3-boyan.karatotev@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/28/20 2:16 PM, Boyan Karatotev wrote:
> PAuth adds sign/verify controls to enable and disable groups of
> instructions in hardware for compatibility with libraries that do not
> implement PAuth. The kernel always enables them if it detects PAuth.
> 
> Add a test that checks that each group of instructions is enabled, if the
> kernel reports PAuth as detected.
> 
> Note: For groups, for the purpose of this patch, we intend instructions
> that use a certain key.
>

Reviewed-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>

> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>
> ---
>  .../testing/selftests/arm64/pauth/.gitignore  |  1 +
>  tools/testing/selftests/arm64/pauth/Makefile  |  7 ++-
>  tools/testing/selftests/arm64/pauth/helper.c  | 41 +++++++++++++++
>  tools/testing/selftests/arm64/pauth/helper.h  | 10 ++++
>  tools/testing/selftests/arm64/pauth/pac.c     | 51 +++++++++++++++++++
>  5 files changed, 108 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/arm64/pauth/helper.c
> 
> diff --git a/tools/testing/selftests/arm64/pauth/.gitignore b/tools/testing/selftests/arm64/pauth/.gitignore
> index b557c916720a..155137d92722 100644
> --- a/tools/testing/selftests/arm64/pauth/.gitignore
> +++ b/tools/testing/selftests/arm64/pauth/.gitignore
> @@ -1 +1,2 @@
> +exec_target
>  pac
> diff --git a/tools/testing/selftests/arm64/pauth/Makefile b/tools/testing/selftests/arm64/pauth/Makefile
> index 785c775e5e41..a017d1c8dd58 100644
> --- a/tools/testing/selftests/arm64/pauth/Makefile
> +++ b/tools/testing/selftests/arm64/pauth/Makefile
> @@ -4,7 +4,7 @@
>  CFLAGS += -mbranch-protection=pac-ret
>  
>  TEST_GEN_PROGS := pac
> -TEST_GEN_FILES := pac_corruptor.o
> +TEST_GEN_FILES := pac_corruptor.o helper.o
>  
>  include ../../lib.mk
>  
> @@ -13,10 +13,13 @@ include ../../lib.mk
>  $(OUTPUT)/pac_corruptor.o: pac_corruptor.S
>  	$(CC) -c $^ -o $@ $(CFLAGS) -march=armv8.3-a
>  
> +$(OUTPUT)/helper.o: helper.c
> +	$(CC) -c $^ -o $@ $(CFLAGS) -march=armv8.3-a
> +
>  # when -mbranch-protection is enabled and the target architecture is ARMv8.3 or
>  # greater, gcc emits pac* instructions which are not in HINT NOP space,
>  # preventing the tests from occurring at all. Compile for ARMv8.2 so tests can
>  # run on earlier targets and print a meaningful error messages
> -$(OUTPUT)/pac: pac.c $(OUTPUT)/pac_corruptor.o
> +$(OUTPUT)/pac: pac.c $(OUTPUT)/pac_corruptor.o $(OUTPUT)/helper.o
>  	$(CC) $^ -o $@ $(CFLAGS) -march=armv8.2-a
>  
> diff --git a/tools/testing/selftests/arm64/pauth/helper.c b/tools/testing/selftests/arm64/pauth/helper.c
> new file mode 100644
> index 000000000000..8619afb16124
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/pauth/helper.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2020 ARM Limited
> +
> +#include "helper.h"
> +
> +
> +size_t keyia_sign(size_t ptr)
> +{
> +	asm volatile("paciza %0" : "+r" (ptr));
> +	return ptr;
> +}
> +
> +size_t keyib_sign(size_t ptr)
> +{
> +	asm volatile("pacizb %0" : "+r" (ptr));
> +	return ptr;
> +}
> +
> +size_t keyda_sign(size_t ptr)
> +{
> +	asm volatile("pacdza %0" : "+r" (ptr));
> +	return ptr;
> +}
> +
> +size_t keydb_sign(size_t ptr)
> +{
> +	asm volatile("pacdzb %0" : "+r" (ptr));
> +	return ptr;
> +}
> +
> +size_t keyg_sign(size_t ptr)
> +{
> +	/* output is encoded in the upper 32 bits */
> +	size_t dest = 0;
> +	size_t modifier = 0;
> +
> +	asm volatile("pacga %0, %1, %2" : "=r" (dest) : "r" (ptr), "r" (modifier));
> +
> +	return dest;
> +}
> +
> diff --git a/tools/testing/selftests/arm64/pauth/helper.h b/tools/testing/selftests/arm64/pauth/helper.h
> index f777f88acf0a..b3cf709e249d 100644
> --- a/tools/testing/selftests/arm64/pauth/helper.h
> +++ b/tools/testing/selftests/arm64/pauth/helper.h
> @@ -4,7 +4,17 @@
>  #ifndef _HELPER_H_
>  #define _HELPER_H_
>  
> +#include <stdlib.h>
> +
> +
>  void pac_corruptor(void);
>  
> +/* PAuth sign a value with key ia and modifier value 0 */
> +size_t keyia_sign(size_t val);
> +size_t keyib_sign(size_t val);
> +size_t keyda_sign(size_t val);
> +size_t keydb_sign(size_t val);
> +size_t keyg_sign(size_t val);
> +
>  #endif
>  
> diff --git a/tools/testing/selftests/arm64/pauth/pac.c b/tools/testing/selftests/arm64/pauth/pac.c
> index ed445050f621..cdbffa8bf61e 100644
> --- a/tools/testing/selftests/arm64/pauth/pac.c
> +++ b/tools/testing/selftests/arm64/pauth/pac.c
> @@ -12,12 +12,25 @@
>   * future version of the arm architecture
>   */
>  
> +#define PAC_COLLISION_ATTEMPTS 10
> +/*
> + * The kernel sets TBID by default. So bits 55 and above should remain
> + * untouched no matter what.
> + * The VA space size is 48 bits. Bigger is opt-in.
> + */
> +#define PAC_MASK (~0xff80ffffffffffff)
>  #define ASSERT_PAUTH_ENABLED() \
>  do { \
>  	unsigned long hwcaps = getauxval(AT_HWCAP); \
>  	/* data key instructions are not in NOP space. This prevents a SIGILL */ \
>  	ASSERT_NE(0, hwcaps & HWCAP_PACA) TH_LOG("PAUTH not enabled"); \
>  } while (0)
> +#define ASSERT_GENERIC_PAUTH_ENABLED() \
> +do { \
> +	unsigned long hwcaps = getauxval(AT_HWCAP); \
> +	/* generic key instructions are not in NOP space. This prevents a SIGILL */ \
> +	ASSERT_NE(0, hwcaps & HWCAP_PACG) TH_LOG("Generic PAUTH not enabled"); \
> +} while (0)
>  
>  
>  /* check that a corrupted PAC results in SIGSEGV */
> @@ -28,5 +41,43 @@ TEST_SIGNAL(corrupt_pac, SIGSEGV)
>  	pac_corruptor();
>  }
>  
> +/*
> + * There are no separate pac* and aut* controls so checking only the pac*
> + * instructions is sufficient
> + */
> +TEST(pac_instructions_not_nop)
> +{
> +	size_t keyia = 0;
> +	size_t keyib = 0;
> +	size_t keyda = 0;
> +	size_t keydb = 0;
> +
> +	ASSERT_PAUTH_ENABLED();
> +
> +	for (int i = 0; i < PAC_COLLISION_ATTEMPTS; i++) {
> +		keyia |= keyia_sign(i) & PAC_MASK;
> +		keyib |= keyib_sign(i) & PAC_MASK;
> +		keyda |= keyda_sign(i) & PAC_MASK;
> +		keydb |= keydb_sign(i) & PAC_MASK;
> +	}
> +
> +	ASSERT_NE(0, keyia) TH_LOG("keyia instructions did nothing");
> +	ASSERT_NE(0, keyib) TH_LOG("keyib instructions did nothing");
> +	ASSERT_NE(0, keyda) TH_LOG("keyda instructions did nothing");
> +	ASSERT_NE(0, keydb) TH_LOG("keydb instructions did nothing");
> +}
> +
> +TEST(pac_instructions_not_nop_generic)
> +{
> +	size_t keyg = 0;
> +
> +	ASSERT_GENERIC_PAUTH_ENABLED();
> +
> +	for (int i = 0; i < PAC_COLLISION_ATTEMPTS; i++)
> +		keyg |= keyg_sign(i) & PAC_MASK;
> +
> +	ASSERT_NE(0, keyg)  TH_LOG("keyg instructions did nothing");
> +}
> +
>  TEST_HARNESS_MAIN
>  
> 

-- 
Regards,
Vincenzo
