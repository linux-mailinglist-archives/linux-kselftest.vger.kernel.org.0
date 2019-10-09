Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7472D0E14
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 13:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfJIL5L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Oct 2019 07:57:11 -0400
Received: from foss.arm.com ([217.140.110.172]:60778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfJIL5L (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Oct 2019 07:57:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47D0B28;
        Wed,  9 Oct 2019 04:57:10 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72CF23F703;
        Wed,  9 Oct 2019 04:57:09 -0700 (PDT)
Subject: Re: [PATCH v8 05/12] kselftest: arm64: extend test_init
 functionalities
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
References: <20191009082611.9441-1-cristian.marussi@arm.com>
 <20191009082611.9441-6-cristian.marussi@arm.com>
 <20191009113240.GC27757@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <a9b4ae53-1b69-60d2-2f83-60ee674e2b9e@arm.com>
Date:   Wed, 9 Oct 2019 12:57:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009113240.GC27757@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 09/10/2019 12:32, Dave Martin wrote:
> On Wed, Oct 09, 2019 at 09:26:04AM +0100, Cristian Marussi wrote:
>> Extend signal testing framework to allow the definition of a custom per
>> test initialization function to be run at the end of the common test_init
>> after test setup phase has completed and before test-run routine.
>>
>> This custom per-test initialization function also enables the test writer
>> to decide on its own when forcibly skip the test itself using standard KSFT
>> mechanism.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> 

Thanks

Cristian
>> ---
>> v7 --> v8
>> - per test .init() helper added new in v8 (splitted out of v7 05/11)
>> ---
>>  .../selftests/arm64/signal/test_signals.c     |  6 ++--
>>  .../selftests/arm64/signal/test_signals.h     |  7 ++--
>>  .../arm64/signal/test_signals_utils.c         | 32 +++++++++++++------
>>  .../arm64/signal/test_signals_utils.h         |  1 +
>>  4 files changed, 31 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/testing/selftests/arm64/signal/test_signals.c b/tools/testing/selftests/arm64/signal/test_signals.c
>> index cb970346b280..416b1ff43199 100644
>> --- a/tools/testing/selftests/arm64/signal/test_signals.c
>> +++ b/tools/testing/selftests/arm64/signal/test_signals.c
>> @@ -19,11 +19,11 @@ int main(int argc, char *argv[])
>>  	current = &tde;
>>  
>>  	ksft_print_msg("%s :: %s\n", current->name, current->descr);
>> -	if (test_setup(current)) {
>> +	if (test_setup(current) && test_init(current)) {
>>  		test_run(current);
>> -		test_result(current);
>>  		test_cleanup(current);
>>  	}
>> +	test_result(current);
>>  
>> -	return current->pass ? KSFT_PASS : KSFT_FAIL;
>> +	return current->result;
>>  }
>> diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
>> index 3fd4499f00bf..901521188202 100644
>> --- a/tools/testing/selftests/arm64/signal/test_signals.h
>> +++ b/tools/testing/selftests/arm64/signal/test_signals.h
>> @@ -84,17 +84,20 @@ struct tdescr {
>>  	unsigned int		timeout;
>>  	bool			triggered;
>>  	bool			pass;
>> +	unsigned int		result;
>>  	/* optional sa_flags for the installed handler */
>>  	int			sa_flags;
>>  	ucontext_t		saved_uc;
>>  	/* optional test private data */
>>  	void                    *priv;
>>  
>> -	/* a custom setup function to be called before test starts */
>> +	/* a custom setup: called alternatively to default_setup */
>>  	int (*setup)(struct tdescr *td);
>> +	/* a custom init: called by default test init after test_setup */
>> +	bool (*init)(struct tdescr *td);
>>  	/* a custom cleanup function called before test exits */
>>  	void (*cleanup)(struct tdescr *td);
>> -	/* an optional function to be used as a trigger for test starting */
>> +	/* an optional function to be used as a trigger for starting test */
>>  	int (*trigger)(struct tdescr *td);
>>  	/*
>>  	 * the actual test-core: invoked differently depending on the
>> diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
>> index ff24db6f9d06..e8bbe36c2660 100644
>> --- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
>> +++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
>> @@ -11,6 +11,8 @@
>>  #include <linux/auxvec.h>
>>  #include <ucontext.h>
>>  
>> +#include <kselftest.h>
>> +
>>  #include "test_signals.h"
>>  #include "test_signals_utils.h"
>>  #include "testcases/testcases.h"
>> @@ -54,12 +56,18 @@ static void unblock_signal(int signum)
>>  
>>  static void default_result(struct tdescr *td, bool force_exit)
>>  {
>> -	if (td->pass)
>> +	if (td->result == KSFT_SKIP) {
>> +		fprintf(stderr, "==>> completed. SKIP.\n");
>> +	} else if (td->pass) {
>>  		fprintf(stderr, "==>> completed. PASS(1)\n");
>> -	else
>> +		td->result = KSFT_PASS;
>> +	} else {
>>  		fprintf(stdout, "==>> completed. FAIL(0)\n");
>> +		td->result = KSFT_FAIL;
>> +	}
>> +
>>  	if (force_exit)
>> -		exit(td->pass ? EXIT_SUCCESS : EXIT_FAILURE);
>> +		exit(td->result);
>>  }
>>  
>>  /*
>> @@ -211,7 +219,7 @@ static inline int default_trigger(struct tdescr *td)
>>  	return !raise(td->sig_trig);
>>  }
>>  
>> -static int test_init(struct tdescr *td)
>> +int test_init(struct tdescr *td)
>>  {
>>  	td->minsigstksz = getauxval(AT_MINSIGSTKSZ);
>>  	if (!td->minsigstksz)
>> @@ -224,8 +232,6 @@ static int test_init(struct tdescr *td)
>>  		 * Checking for CPU required features using both the
>>  		 * auxval and the arm64 MRS Emulation to read sysregs.
>>  		 */
>> -		if (getauxval(AT_HWCAP) & HWCAP_SSBS)
>> -			td->feats_supported |= FEAT_SSBS;
>>  		if (getauxval(AT_HWCAP) & HWCAP_CPUID) {
>>  			uint64_t val = 0;
>>  
>> @@ -250,7 +256,14 @@ static int test_init(struct tdescr *td)
>>  						~td->feats_supported));
>>  	}
>>  
>> +	/* Perform test specific additional initialization */
>> +	if (td->init && !td->init(td)) {
>> +		fprintf(stderr, "FAILED Testcase initialization.\n");
>> +		return 0;
>> +	}
>>  	td->initialized = 1;
>> +	fprintf(stderr, "Testcase initialized.\n");
>> +
>>  	return 1;
>>  }
>>  
>> @@ -262,9 +275,8 @@ int test_setup(struct tdescr *td)
>>  	assert(td->name);
>>  	assert(td->run);
>>  
>> -	if (!test_init(td))
>> -		return 0;
>> -
>> +	/* Default result is FAIL if test setup fails */
>> +	td->result = KSFT_FAIL;
>>  	if (td->setup)
>>  		return td->setup(td);
>>  	else
>> @@ -285,7 +297,7 @@ int test_run(struct tdescr *td)
>>  
>>  void test_result(struct tdescr *td)
>>  {
>> -	if (td->check_result)
>> +	if (td->initialized && td->result != KSFT_SKIP && td->check_result)
>>  		td->check_result(td);
>>  	default_result(td, 0);
>>  }
>> diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
>> index 47a7592b7c53..5e3a2b7aaa8b 100644
>> --- a/tools/testing/selftests/arm64/signal/test_signals_utils.h
>> +++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
>> @@ -6,6 +6,7 @@
>>  
>>  #include "test_signals.h"
>>  
>> +int test_init(struct tdescr *td);
>>  int test_setup(struct tdescr *td);
>>  void test_cleanup(struct tdescr *td);
>>  int test_run(struct tdescr *td);
>> -- 
>> 2.17.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

