Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D627125B2B3
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Sep 2020 19:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIBRI7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Sep 2020 13:08:59 -0400
Received: from foss.arm.com ([217.140.110.172]:43028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgIBRI6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Sep 2020 13:08:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D1BE1045;
        Wed,  2 Sep 2020 10:08:58 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0CDB3F66F;
        Wed,  2 Sep 2020 10:08:56 -0700 (PDT)
Date:   Wed, 2 Sep 2020 18:08:54 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Boyan Karatotev <boyan.karatotev@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, boian4o1@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        amit.kachhap@arm.com, vincenzo.frascino@arm.com,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2 3/4] kselftests/arm64: add PAuth test for whether
 exec() changes keys
Message-ID: <20200902170854.GK6642@arm.com>
References: <20200831110450.30188-1-boyan.karatotev@arm.com>
 <20200831110450.30188-4-boyan.karatotev@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831110450.30188-4-boyan.karatotev@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 31, 2020 at 12:04:49PM +0100, Boyan Karatotev wrote:
> Kernel documentation states that it will change PAuth keys on exec() calls.
> 
> Verify that all keys are correctly switched to new ones.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
> Reviewed-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>
> ---
>  tools/testing/selftests/arm64/pauth/Makefile  |   4 +
>  .../selftests/arm64/pauth/exec_target.c       |  35 +++++
>  tools/testing/selftests/arm64/pauth/helper.h  |  10 ++
>  tools/testing/selftests/arm64/pauth/pac.c     | 148 ++++++++++++++++++
>  4 files changed, 197 insertions(+)
>  create mode 100644 tools/testing/selftests/arm64/pauth/exec_target.c
> 
> diff --git a/tools/testing/selftests/arm64/pauth/Makefile b/tools/testing/selftests/arm64/pauth/Makefile
> index 5c0dd129562f..72e290b0b10c 100644
> --- a/tools/testing/selftests/arm64/pauth/Makefile
> +++ b/tools/testing/selftests/arm64/pauth/Makefile
> @@ -13,6 +13,7 @@ pauth_cc_support := $(shell if ($(CC) $(CFLAGS) -march=armv8.3-a -E -x c /dev/nu
>  ifeq ($(pauth_cc_support),1)
>  TEST_GEN_PROGS := pac
>  TEST_GEN_FILES := pac_corruptor.o helper.o
> +TEST_GEN_PROGS_EXTENDED := exec_target
>  endif
>  
>  include ../../lib.mk
> @@ -30,6 +31,9 @@ $(OUTPUT)/helper.o: helper.c
>  # greater, gcc emits pac* instructions which are not in HINT NOP space,
>  # preventing the tests from occurring at all. Compile for ARMv8.2 so tests can
>  # run on earlier targets and print a meaningful error messages
> +$(OUTPUT)/exec_target: exec_target.c $(OUTPUT)/helper.o
> +	$(CC) $^ -o $@ $(CFLAGS) -march=armv8.2-a
> +
>  $(OUTPUT)/pac: pac.c $(OUTPUT)/pac_corruptor.o $(OUTPUT)/helper.o
>  	$(CC) $^ -o $@ $(CFLAGS) -march=armv8.2-a
>  endif
> diff --git a/tools/testing/selftests/arm64/pauth/exec_target.c b/tools/testing/selftests/arm64/pauth/exec_target.c
> new file mode 100644
> index 000000000000..07addef5a1d7
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/pauth/exec_target.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2020 ARM Limited
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/auxv.h>
> +
> +#include "helper.h"
> +
> +
> +int main(void)
> +{
> +	struct signatures signed_vals;
> +	unsigned long hwcaps;
> +	size_t val;
> +
> +	fread(&val, sizeof(size_t), 1, stdin);
> +
> +	/* don't try to execute illegal (unimplemented) instructions) caller
> +	 * should have checked this and keep worker simple
> +	 */
> +	hwcaps = getauxval(AT_HWCAP);
> +
> +	if (hwcaps & HWCAP_PACA) {
> +		signed_vals.keyia = keyia_sign(val);
> +		signed_vals.keyib = keyib_sign(val);
> +		signed_vals.keyda = keyda_sign(val);
> +		signed_vals.keydb = keydb_sign(val);
> +	}
> +	signed_vals.keyg = (hwcaps & HWCAP_PACG) ?  keyg_sign(val) : 0;
> +
> +	fwrite(&signed_vals, sizeof(struct signatures), 1, stdout);
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/arm64/pauth/helper.h b/tools/testing/selftests/arm64/pauth/helper.h
> index e2ed910c9863..da6457177727 100644
> --- a/tools/testing/selftests/arm64/pauth/helper.h
> +++ b/tools/testing/selftests/arm64/pauth/helper.h
> @@ -6,6 +6,16 @@
>  
>  #include <stdlib.h>
>  
> +#define NKEYS 5
> +
> +
> +struct signatures {
> +	size_t keyia;
> +	size_t keyib;
> +	size_t keyda;
> +	size_t keydb;
> +	size_t keyg;
> +};
>  
>  void pac_corruptor(void);
>  
> diff --git a/tools/testing/selftests/arm64/pauth/pac.c b/tools/testing/selftests/arm64/pauth/pac.c
> index 035fdd6aae9b..1b9e3acfeb61 100644
> --- a/tools/testing/selftests/arm64/pauth/pac.c
> +++ b/tools/testing/selftests/arm64/pauth/pac.c
> @@ -2,6 +2,8 @@
>  // Copyright (C) 2020 ARM Limited
>  
>  #include <sys/auxv.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
>  #include <signal.h>
>  
>  #include "../../kselftest_harness.h"
> @@ -33,6 +35,117 @@ do { \
>  } while (0)
>  
>  
> +void sign_specific(struct signatures *sign, size_t val)
> +{
> +	sign->keyia = keyia_sign(val);
> +	sign->keyib = keyib_sign(val);
> +	sign->keyda = keyda_sign(val);
> +	sign->keydb = keydb_sign(val);
> +}
> +
> +void sign_all(struct signatures *sign, size_t val)
> +{
> +	sign->keyia = keyia_sign(val);
> +	sign->keyib = keyib_sign(val);
> +	sign->keyda = keyda_sign(val);
> +	sign->keydb = keydb_sign(val);
> +	sign->keyg  = keyg_sign(val);
> +}
> +
> +int are_same(struct signatures *old, struct signatures *new, int nkeys)
> +{
> +	int res = 0;
> +
> +	res |= old->keyia == new->keyia;
> +	res |= old->keyib == new->keyib;
> +	res |= old->keyda == new->keyda;
> +	res |= old->keydb == new->keydb;
> +	if (nkeys == NKEYS)
> +		res |= old->keyg  == new->keyg;
> +
> +	return res;
> +}
> +
> +int exec_sign_all(struct signatures *signed_vals, size_t val)
> +{
> +	int new_stdin[2];
> +	int new_stdout[2];
> +	int status;
> +	ssize_t ret;
> +	pid_t pid;

Can we simplify this with popen(3)?  Fork-and-exec is notoriously
fiddly...

[...]

> +/*
> + * fork() does not change keys. Only exec() does so call a worker program.
> + * Its only job is to sign a value and report back the resutls
> + */
> +TEST(exec_unique_keys)
> +{

The kernel doesn't guarantee that keys are unique.

Can we present all the "unique keys" wording differently, say

	exec_key_collision_likely()

Otherwise people might infer from this test code that the keys are
supposed to be truly unique and start reporting bugs on the kernel.

I can't see an obvious security argument for unique keys (rather, the
keys just need to be "unique enough".  That's the job of
get_random_bytes().)

[...]

Cheers
---Dave
