Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EC525752F
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Aug 2020 10:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgHaIUZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Aug 2020 04:20:25 -0400
Received: from foss.arm.com ([217.140.110.172]:55036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728147AbgHaIUX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Aug 2020 04:20:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76AB831B;
        Mon, 31 Aug 2020 01:20:22 -0700 (PDT)
Received: from [10.57.6.112] (unknown [10.57.6.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D51DA3F68F;
        Mon, 31 Aug 2020 01:20:19 -0700 (PDT)
Subject: Re: [PATCH 4/4] kselftests/arm64: add PAuth tests for single threaded
 consistency and key uniqueness
To:     Boyan Karatotev <boyan.karatotev@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     vincenzo.frascino@arm.com, boian4o1@gmail.com,
        Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20200828131606.7946-1-boyan.karatotev@arm.com>
 <20200828131606.7946-5-boyan.karatotev@arm.com>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <6ea1f31f-dda3-5e7d-126e-88590614b86f@arm.com>
Date:   Mon, 31 Aug 2020 13:50:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200828131606.7946-5-boyan.karatotev@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 8/28/20 6:46 PM, Boyan Karatotev wrote:
> PAuth adds 5 different keys that can be used to sign addresses.
> 
> Add a test that verifies that the kernel initializes them uniquely and
> preserves them across context switches.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>


> ---
>   tools/testing/selftests/arm64/pauth/pac.c | 116 ++++++++++++++++++++++
>   1 file changed, 116 insertions(+)
> 
> diff --git a/tools/testing/selftests/arm64/pauth/pac.c b/tools/testing/selftests/arm64/pauth/pac.c
> index 16dea47b11c7..718f49adc275 100644
> --- a/tools/testing/selftests/arm64/pauth/pac.c
> +++ b/tools/testing/selftests/arm64/pauth/pac.c
> @@ -1,10 +1,13 @@
>   // SPDX-License-Identifier: GPL-2.0
>   // Copyright (C) 2020 ARM Limited
>   
> +#define _GNU_SOURCE
> +
>   #include <sys/auxv.h>
>   #include <sys/types.h>
>   #include <sys/wait.h>
>   #include <signal.h>
> +#include <sched.h>
>   
>   #include "../../kselftest_harness.h"
>   #include "helper.h"
> @@ -21,6 +24,7 @@
>    * The VA space size is 48 bits. Bigger is opt-in.
>    */
>   #define PAC_MASK (~0xff80ffffffffffff)
> +#define ARBITRARY_VALUE (0x1234)
>   #define ASSERT_PAUTH_ENABLED() \
>   do { \
>   	unsigned long hwcaps = getauxval(AT_HWCAP); \
> @@ -66,13 +70,36 @@ int are_same(struct signatures *old, struct signatures *new, int nkeys)
>   	return res;
>   }
>   
> +int are_unique(struct signatures *sign, int nkeys)
> +{
> +	size_t vals[nkeys];
> +
> +	vals[0] = sign->keyia & PAC_MASK;
> +	vals[1] = sign->keyib & PAC_MASK;
> +	vals[2] = sign->keyda & PAC_MASK;
> +	vals[3] = sign->keydb & PAC_MASK;
> +
> +	if (nkeys >= 4)
> +		vals[4] = sign->keyg & PAC_MASK;
> +
> +	for (int i = 0; i < nkeys - 1; i++) {
> +		for (int j = i + 1; j < nkeys; j++) {
> +			if (vals[i] == vals[j])
> +				return 0;
> +		}
> +	}
> +	return 1;
> +}
> +
>   int exec_sign_all(struct signatures *signed_vals, size_t val)
>   {
>   	int new_stdin[2];
>   	int new_stdout[2];
>   	int status;
> +	int i;
>   	ssize_t ret;
>   	pid_t pid;
> +	cpu_set_t mask;
>   
>   	ret = pipe(new_stdin);
>   	if (ret == -1) {
> @@ -86,6 +113,20 @@ int exec_sign_all(struct signatures *signed_vals, size_t val)
>   		return -1;
>   	}
>   
> +	/*
> +	 * pin this process and all its children to a single CPU, so it can also
> +	 * guarantee a context switch with its child
> +	 */
> +	sched_getaffinity(0, sizeof(mask), &mask);
> +
> +	for (i = 0; i < sizeof(cpu_set_t); i++)
> +		if (CPU_ISSET(i, &mask))
> +			break;
> +
> +	CPU_ZERO(&mask);
> +	CPU_SET(i, &mask);
> +	sched_setaffinity(0, sizeof(mask), &mask);
> +
>   	pid = fork();
>   	// child
>   	if (pid == 0) {
> @@ -192,6 +233,38 @@ TEST(pac_instructions_not_nop_generic)
>   	ASSERT_NE(0, keyg)  TH_LOG("keyg instructions did nothing");
>   }
>   
> +TEST(single_thread_unique_keys)
> +{
> +	int unique = 0;
> +	int nkeys = NKEYS;
> +	struct signatures signed_vals;
> +	unsigned long hwcaps = getauxval(AT_HWCAP);
> +
> +	/* generic and data key instructions are not in NOP space. This prevents a SIGILL */
> +	ASSERT_NE(0, hwcaps & HWCAP_PACA) TH_LOG("PAUTH not enabled");
> +	if (!(hwcaps & HWCAP_PACG)) {
> +		TH_LOG("WARNING: Generic PAUTH not enabled. Skipping generic key checks");
> +		nkeys = NKEYS - 1;
> +	}
> +
> +	/*
> +	 * The PAC field is up to 7 bits. Even with unique keys there is about
> +	 * 5% chance for a collision.  This chance rapidly increases the fewer
> +	 * bits there are, a comparison of the keys directly will be more

Can you please reframe the above sentence as it is not clear.
The other changes look fine to me so please free to add,
Reviewed-by: Amit Daniel Kachhap <amit.kachhap@arm.com>

//Amit


> +	 * reliable All signed values need to be unique at least once out of n
> +	 * attempts to be certain that the keys are unique
> +	 */
> +	for (int i = 0; i < PAC_COLLISION_ATTEMPTS; i++) {
> +		if (nkeys == NKEYS)
> +			sign_all(&signed_vals, i);
> +		else
> +			sign_specific(&signed_vals, i);
> +		unique |= are_unique(&signed_vals, nkeys);
> +	}
> +
> +	ASSERT_EQ(1, unique) TH_LOG("keys clashed every time");
> +}
> +
>   /*
>    * fork() does not change keys. Only exec() does so call a worker program.
>    * Its only job is to sign a value and report back the resutls
> @@ -227,5 +300,48 @@ TEST(exec_unique_keys)
>   	ASSERT_EQ(1, different) TH_LOG("exec() did not change keys");
>   }
>   
> +TEST(context_switch_keep_keys)
> +{
> +	int ret;
> +	struct signatures trash;
> +	struct signatures before;
> +	struct signatures after;
> +
> +	ASSERT_PAUTH_ENABLED();
> +
> +	sign_specific(&before, ARBITRARY_VALUE);
> +
> +	/* will context switch with a process with different keys at least once */
> +	ret = exec_sign_all(&trash, ARBITRARY_VALUE);
> +	ASSERT_EQ(0, ret) TH_LOG("failed to run worker");
> +
> +	sign_specific(&after, ARBITRARY_VALUE);
> +
> +	ASSERT_EQ(before.keyia, after.keyia) TH_LOG("keyia changed after context switching");
> +	ASSERT_EQ(before.keyib, after.keyib) TH_LOG("keyib changed after context switching");
> +	ASSERT_EQ(before.keyda, after.keyda) TH_LOG("keyda changed after context switching");
> +	ASSERT_EQ(before.keydb, after.keydb) TH_LOG("keydb changed after context switching");
> +}
> +
> +TEST(context_switch_keep_keys_generic)
> +{
> +	int ret;
> +	struct signatures trash;
> +	size_t before;
> +	size_t after;
> +
> +	ASSERT_GENERIC_PAUTH_ENABLED();
> +
> +	before = keyg_sign(ARBITRARY_VALUE);
> +
> +	/* will context switch with a process with different keys at least once */
> +	ret = exec_sign_all(&trash, ARBITRARY_VALUE);
> +	ASSERT_EQ(0, ret) TH_LOG("failed to run worker");
> +
> +	after = keyg_sign(ARBITRARY_VALUE);
> +
> +	ASSERT_EQ(before, after) TH_LOG("keyg changed after context switching");
> +}
> +
>   TEST_HARNESS_MAIN
>   
> 
