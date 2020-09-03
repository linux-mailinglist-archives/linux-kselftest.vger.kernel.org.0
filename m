Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59ACD25BEFB
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Sep 2020 12:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgICKUa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Sep 2020 06:20:30 -0400
Received: from foss.arm.com ([217.140.110.172]:58354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgICKU3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Sep 2020 06:20:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25D27101E;
        Thu,  3 Sep 2020 03:20:29 -0700 (PDT)
Received: from [10.57.7.89] (unknown [10.57.7.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2191B3F68F;
        Thu,  3 Sep 2020 03:20:26 -0700 (PDT)
Subject: Re: [PATCH 3/4] kselftests/arm64: add PAuth test for whether exec()
 changes keys
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, boian4o1@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        amit.kachhap@arm.com, vincenzo.frascino@arm.com,
        Shuah Khan <shuah@kernel.org>
References: <20200828131606.7946-1-boyan.karatotev@arm.com>
 <20200828131606.7946-4-boyan.karatotev@arm.com>
 <20200902170052.GJ6642@arm.com>
From:   Boyan Karatotev <boyan.karatotev@arm.com>
Message-ID: <70e207ea-f7c2-2c9d-e868-3ba3b6451c6f@arm.com>
Date:   Thu, 3 Sep 2020 11:20:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902170052.GJ6642@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02/09/2020 18:00, Dave Martin wrote:
> On Fri, Aug 28, 2020 at 02:16:05PM +0100, Boyan Karatotev wrote:
>> Kernel documentation states that it will change PAuth keys on exec() calls.
>>
>> Verify that all keys are correctly switched to new ones.
>>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>
>> ---
>>  tools/testing/selftests/arm64/pauth/Makefile  |   4 +
>>  .../selftests/arm64/pauth/exec_target.c       |  35 +++++
>>  tools/testing/selftests/arm64/pauth/helper.h  |  10 ++
>>  tools/testing/selftests/arm64/pauth/pac.c     | 148 ++++++++++++++++++
>>  4 files changed, 197 insertions(+)
>>  create mode 100644 tools/testing/selftests/arm64/pauth/exec_target.c
>>
>> diff --git a/tools/testing/selftests/arm64/pauth/Makefile b/tools/testing/selftests/arm64/pauth/Makefile
>> index a017d1c8dd58..2e237b21ccf6 100644
>> --- a/tools/testing/selftests/arm64/pauth/Makefile
>> +++ b/tools/testing/selftests/arm64/pauth/Makefile
>> @@ -5,6 +5,7 @@ CFLAGS += -mbranch-protection=pac-ret
>>  
>>  TEST_GEN_PROGS := pac
>>  TEST_GEN_FILES := pac_corruptor.o helper.o
>> +TEST_GEN_PROGS_EXTENDED := exec_target
>>  
>>  include ../../lib.mk
>>  
>> @@ -20,6 +21,9 @@ $(OUTPUT)/helper.o: helper.c
>>  # greater, gcc emits pac* instructions which are not in HINT NOP space,
>>  # preventing the tests from occurring at all. Compile for ARMv8.2 so tests can
>>  # run on earlier targets and print a meaningful error messages
>> +$(OUTPUT)/exec_target: exec_target.c $(OUTPUT)/helper.o
>> +	$(CC) $^ -o $@ $(CFLAGS) -march=armv8.2-a
>> +
>>  $(OUTPUT)/pac: pac.c $(OUTPUT)/pac_corruptor.o $(OUTPUT)/helper.o
>>  	$(CC) $^ -o $@ $(CFLAGS) -march=armv8.2-a
>>  
>> diff --git a/tools/testing/selftests/arm64/pauth/exec_target.c b/tools/testing/selftests/arm64/pauth/exec_target.c
>> new file mode 100644
>> index 000000000000..07addef5a1d7
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/pauth/exec_target.c
>> @@ -0,0 +1,35 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (C) 2020 ARM Limited
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <sys/auxv.h>
>> +
>> +#include "helper.h"
>> +
>> +
>> +int main(void)
>> +{
>> +	struct signatures signed_vals;
>> +	unsigned long hwcaps;
>> +	size_t val;
>> +
>> +	fread(&val, sizeof(size_t), 1, stdin);
>> +
>> +	/* don't try to execute illegal (unimplemented) instructions) caller
>> +	 * should have checked this and keep worker simple
>> +	 */
>> +	hwcaps = getauxval(AT_HWCAP);
>> +
>> +	if (hwcaps & HWCAP_PACA) {
>> +		signed_vals.keyia = keyia_sign(val);
>> +		signed_vals.keyib = keyib_sign(val);
>> +		signed_vals.keyda = keyda_sign(val);
>> +		signed_vals.keydb = keydb_sign(val);
>> +	}
>> +	signed_vals.keyg = (hwcaps & HWCAP_PACG) ?  keyg_sign(val) : 0;
>> +
>> +	fwrite(&signed_vals, sizeof(struct signatures), 1, stdout);
>> +
>> +	return 0;
>> +}
>> diff --git a/tools/testing/selftests/arm64/pauth/helper.h b/tools/testing/selftests/arm64/pauth/helper.h
>> index b3cf709e249d..fceaa1e4824a 100644
>> --- a/tools/testing/selftests/arm64/pauth/helper.h
>> +++ b/tools/testing/selftests/arm64/pauth/helper.h
>> @@ -6,6 +6,16 @@
>>  
>>  #include <stdlib.h>
>>  
>> +#define NKEYS 5
>> +
>> +
>> +struct signatures {
>> +	size_t keyia;
>> +	size_t keyib;
>> +	size_t keyda;
>> +	size_t keydb;
>> +	size_t keyg;
>> +};
>>  
>>  void pac_corruptor(void);
>>  
>> diff --git a/tools/testing/selftests/arm64/pauth/pac.c b/tools/testing/selftests/arm64/pauth/pac.c
>> index cdbffa8bf61e..16dea47b11c7 100644
>> --- a/tools/testing/selftests/arm64/pauth/pac.c
>> +++ b/tools/testing/selftests/arm64/pauth/pac.c
>> @@ -2,6 +2,8 @@
>>  // Copyright (C) 2020 ARM Limited
>>  
>>  #include <sys/auxv.h>
>> +#include <sys/types.h>
>> +#include <sys/wait.h>
>>  #include <signal.h>
>>  
>>  #include "../../kselftest_harness.h"
>> @@ -33,6 +35,117 @@ do { \
>>  } while (0)
>>  
>>  
>> +void sign_specific(struct signatures *sign, size_t val)
>> +{
>> +	sign->keyia = keyia_sign(val);
>> +	sign->keyib = keyib_sign(val);
>> +	sign->keyda = keyda_sign(val);
>> +	sign->keydb = keydb_sign(val);
>> +}
>> +
>> +void sign_all(struct signatures *sign, size_t val)
>> +{
>> +	sign->keyia = keyia_sign(val);
>> +	sign->keyib = keyib_sign(val);
>> +	sign->keyda = keyda_sign(val);
>> +	sign->keydb = keydb_sign(val);
>> +	sign->keyg  = keyg_sign(val);
>> +}
>> +
>> +int are_same(struct signatures *old, struct signatures *new, int nkeys)
>> +{
>> +	int res = 0;
>> +
>> +	res |= old->keyia == new->keyia;
>> +	res |= old->keyib == new->keyib;
>> +	res |= old->keyda == new->keyda;
>> +	res |= old->keydb == new->keydb;
>> +	if (nkeys == NKEYS)
>> +		res |= old->keyg  == new->keyg;
>> +
>> +	return res;
>> +}
>> +
>> +int exec_sign_all(struct signatures *signed_vals, size_t val)
>> +{
> 
> Could popen(3) be used here?
> 
> Fork-and-exec is notoriously fiddly, so it's preferable to use a library
> function to do it where applicable.I would love to, but the worker needs a bidirectional channel and popen
only gives a unidirectional stream.
> 
> [...]
> 
> Cheers
> ---Dave
> 


-- 
Regards,
Boyan
