Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A60B2A8F0D
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 06:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgKFFyW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 00:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKFFyW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 00:54:22 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92100C0613CF;
        Thu,  5 Nov 2020 21:54:22 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 62so75492pgg.12;
        Thu, 05 Nov 2020 21:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nq5CFM2iwN1eLIgSQD0rdPsBmq4v/im+POuO6iBKUQk=;
        b=sLT0bcky7yfsVhao1qS4JTlp+epYSHPffxnzghzUjakaB/qHgfA98sYEGEVc0zzQwe
         J4wdoewK+/LJt7kvJiYuuMBnBRb9wjBwsj6mr5G1UFtdSKpgso3u3YTD0fqD4e9cK4Xt
         8TORTrQqVJTw/XgUHGvZ+r/H1HA7M59rWWFEXe9agQPUIvaHoZxa71wjiMyIWODwIUBk
         t98RieM5RVBv+ERoWh0OMBu92ztyj0NGQY5zfMLFKA57uanucGbhNTASd4wxR2K+VusB
         hpPgEQvDRgPYHW66IeScSFgrkgbD2rNiOlycs1PpIDmY77eAWYcipV8+9sP0+RhRZPnT
         GJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nq5CFM2iwN1eLIgSQD0rdPsBmq4v/im+POuO6iBKUQk=;
        b=YU2/j7ZYRuKtqDNL3d+6aEbQLKgrWfP6qrZAEfuyoLuXtOH9P5Dth/znLvKKKNACvq
         cPhPcD5cXOUEkq4Eemk2wQpth+fmEASZqiIVL3EOeiA6ARK4akXdBE6K69TMa2w9wAin
         6HsT3K6jvCELFc0HQJrhhnItf2/bUznv1mY9+ScT6VT7EKV7SDT/1WhbLBrVzfXYlH+4
         0M0K9GWhxyaNNRXCNaWcTRXaLIwak3wXKg9PdFNuPCZAoxkj1x5HuSU0jaoB7HDtAmqO
         +jNSwl5UZqX4uv0n1anV0LxnxMgHoqwMcNg4f7e/XFVfgeFvHjtsZI8QtoP5AAB+61/t
         iZ3A==
X-Gm-Message-State: AOAM531dsEv72Mb3b9V5VogbKAUd2+U/HJ9TTFoqmBMoCgcdKjX6ZdGT
        RgqOngZEzguaI2SRXNSn/5XengiAbEvyylU0
X-Google-Smtp-Source: ABdhPJykQHMBFsWv2so7Tyk82KDxnV1lySkZ35Kw9NzmU2PcshI7SV93xXeSJvOohnrMtfCQKFWigw==
X-Received: by 2002:a17:90a:43c6:: with SMTP id r64mr727013pjg.128.1604642061681;
        Thu, 05 Nov 2020 21:54:21 -0800 (PST)
Received: from [192.168.86.81] ([106.51.243.217])
        by smtp.gmail.com with ESMTPSA id 26sm251695pgu.83.2020.11.05.21.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 21:54:20 -0800 (PST)
Subject: Re: [PATCH v4 1/2] kunit: Support for Parameterized Testing
To:     Marco Elver <elver@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        skhan@linuxfoundation.org, Iurii Zaikin <yzaikin@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
References: <20201027174630.85213-1-98.arpi@gmail.com>
 <CANpmjNOpbXHs4gs9Ro-u7hyN_zZ7s3AqDcdDy1Nqxq4ckThugA@mail.gmail.com>
 <73c4e46c-10f1-9362-b4fb-94ea9d74e9b2@gmail.com>
 <CANpmjNPxqQM0_f14ZwV3rHZzwhCtqx2fbOhHmXmiJawou6=z6Q@mail.gmail.com>
 <77d6dc66-1086-a9ae-ccbc-bb062ff81437@gmail.com>
 <CANpmjNORLJ4b_uwBB8v2h5cxoZF2SMTaz5K6QP37PxdUJDZUDA@mail.gmail.com>
 <20201105195503.GA2399621@elver.google.com>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <f7e04221-607c-dd05-24a6-27c26d86919d@gmail.com>
Date:   Fri, 6 Nov 2020 11:24:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105195503.GA2399621@elver.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06/11/20 1:25 am, Marco Elver wrote:
> On Thu, Nov 05, 2020 at 04:02PM +0100, Marco Elver wrote:
>> On Thu, 5 Nov 2020 at 15:30, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> [...]
>>>>> I tried adding support to run each parameter as a distinct test case by
>>>>> making changes to kunit_run_case_catch_errors(). The issue here is that
>>>>> since the results are displayed in KTAP format, this change will result in
>>>>> each parameter being considered a subtest of another subtest (test case
>>>>> in KUnit).
>>>>
>>>> Do you have example output? That might help understand what's going on.
>>>>
>>>
>>> The change that I tried can be seen here (based on the v4 patch):
>>> https://gist.github.com/arpi-r/4822899087ca4cc34572ed9e45cc5fee.
>>>
>>> Using the kunit tool, I get this error:
>>>
>>> [19:20:41] [ERROR]  expected 7 test suites, but got -1
>>> [ERROR] no tests run!
>>> [19:20:41] ============================================================
>>> [19:20:41] Testing complete. 0 tests run. 0 failed. 0 crashed.
>>>
>>> But this error is only because of how the tool displays the results.
>>> The test actually does run, as can be seen in the dmesg output:
>>>
>>> TAP version 14
>>> 1..7
>>>     # Subtest: ext4_inode_test
>>>     1..1
>>>     ok 1 - inode_test_xtimestamp_decoding 1
>>>     ok 1 - inode_test_xtimestamp_decoding 2
>>>     ok 1 - inode_test_xtimestamp_decoding 3
>>>     ok 1 - inode_test_xtimestamp_decoding 4
>>>     ok 1 - inode_test_xtimestamp_decoding 5
>>>     ok 1 - inode_test_xtimestamp_decoding 6
>>>     ok 1 - inode_test_xtimestamp_decoding 7
>>>     ok 1 - inode_test_xtimestamp_decoding 8
>>>     ok 1 - inode_test_xtimestamp_decoding 9
>>>     ok 1 - inode_test_xtimestamp_decoding 10
>>>     ok 1 - inode_test_xtimestamp_decoding 11
>>>     ok 1 - inode_test_xtimestamp_decoding 12
>>>     ok 1 - inode_test_xtimestamp_decoding 13
>>>     ok 1 - inode_test_xtimestamp_decoding 14
>>>     ok 1 - inode_test_xtimestamp_decoding 15
>>>     ok 1 - inode_test_xtimestamp_decoding 16
>>> ok 1 - ext4_inode_test
>>> (followed by other kunit test outputs)
>>
>> Hmm, interesting. Let me play with your patch a bit.
>>
>> One option is to just have the test case number increment as well,
>> i.e. have this:
>> |    ok 1 - inode_test_xtimestamp_decoding#1
>> |    ok 2 - inode_test_xtimestamp_decoding#2
>> |    ok 3 - inode_test_xtimestamp_decoding#3
>> |    ok 4 - inode_test_xtimestamp_decoding#4
>> |    ok 5 - inode_test_xtimestamp_decoding#5
>> ...
>>
>> Or is there something else I missed?
> 
> Right, so TAP wants the exact number of tests it will run ahead of time.
> In which case we can still put the results of each parameterized test in
> a diagnostic. Please see my proposed patch below, which still does
> proper initialization/destruction of each parameter case as if it was
> its own test case.
> 
> With it the output looks as follows:
> 
> | TAP version 14
> | 1..6
> |     # Subtest: ext4_inode_test
> |     1..1
> |     # ok param#0 - inode_test_xtimestamp_decoding
> |     # ok param#1 - inode_test_xtimestamp_decoding
> |     # ok param#2 - inode_test_xtimestamp_decoding
> |     # ok param#3 - inode_test_xtimestamp_decoding
> |     # ok param#4 - inode_test_xtimestamp_decoding
> |     # ok param#5 - inode_test_xtimestamp_decoding
> |     # ok param#6 - inode_test_xtimestamp_decoding
> |     # ok param#7 - inode_test_xtimestamp_decoding
> |     # ok param#8 - inode_test_xtimestamp_decoding
> |     # ok param#9 - inode_test_xtimestamp_decoding
> |     # ok param#10 - inode_test_xtimestamp_decoding
> |     # ok param#11 - inode_test_xtimestamp_decoding
> |     # ok param#12 - inode_test_xtimestamp_decoding
> |     # ok param#13 - inode_test_xtimestamp_decoding
> |     # ok param#14 - inode_test_xtimestamp_decoding
> |     # ok param#15 - inode_test_xtimestamp_decoding
> |     ok 1 - inode_test_xtimestamp_decoding
> | ok 1 - ext4_inode_test
> 
> Would that be reasonable? If so, feel free to take the patch and
> test/adjust as required.
> 
> I'm not sure on the best format -- is there is a recommended format for
> parameterized test result output? If not, I suppose we can put anything
> we like into the diagnostic.
> 

I think this format of output should be fine for parameterized tests.
But, this patch has the same issue as earlier. While, the tests run and
this is the output that can be seen using dmesg, it still causes an issue on
using the kunit tool. It gives a similar error:

[11:07:38] [ERROR]  expected 7 test suites, but got -1
[11:07:38] [ERROR] expected_suite_index -1, but got 2
[11:07:38] [ERROR] got unexpected test suite: kunit-try-catch-test
[ERROR] no tests run!
[11:07:38] ============================================================
[11:07:38] Testing complete. 0 tests run. 0 failed. 0 crashed.

Thanks!

> Thanks,
> -- Marco
> 
> ------ >8 ------
> 
> From ccbf4e2e190a2d7c6a94a51c9b1fb3b9a940e578 Mon Sep 17 00:00:00 2001
> From: Arpitha Raghunandan <98.arpi@gmail.com>
> Date: Tue, 27 Oct 2020 23:16:30 +0530
> Subject: [PATCH] kunit: Support for Parameterized Testing
> 
> Implementation of support for parameterized testing in KUnit.
> This approach requires the creation of a test case using the
> KUNIT_CASE_PARAM macro that accepts a generator function as input.
> This generator function should return the next parameter given the
> previous parameter in parameterized tests. It also provides
> a macro to generate common-case generators.
> 
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> Changes v4->v5:
> - Update kernel-doc comments.
> - Use const void* for generator return and prev value types.
> - Add kernel-doc comment for KUNIT_ARRAY_PARAM.
> - Rework parameterized test case execution strategy: each parameter is executed
>   as if it was its own test case, with its own test initialization and cleanup
>   (init and exit are called, etc.). However, we cannot add new test cases per TAP
>   protocol once we have already started execution. Instead, log the result of
>   each parameter run as a diagnostic comment.
> Changes v3->v4:
> - Rename kunit variables
> - Rename generator function helper macro
> - Add documentation for generator approach
> - Display test case name in case of failure along with param index
> Changes v2->v3:
> - Modifictaion of generator macro and method
> Changes v1->v2:
> - Use of a generator method to access test case parameters
> ---
>  include/kunit/test.h | 36 ++++++++++++++++++++++++++++++++++
>  lib/kunit/test.c     | 46 +++++++++++++++++++++++++++++++-------------
>  2 files changed, 69 insertions(+), 13 deletions(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 9197da792336..ae5488a37e48 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -107,6 +107,7 @@ struct kunit;
>   *
>   * @run_case: the function representing the actual test case.
>   * @name:     the name of the test case.
> + * @generate_params: the generator function for parameterized tests.
>   *
>   * A test case is a function with the signature,
>   * ``void (*)(struct kunit *)``
> @@ -141,6 +142,7 @@ struct kunit;
>  struct kunit_case {
>  	void (*run_case)(struct kunit *test);
>  	const char *name;
> +	const void* (*generate_params)(const void *prev);
>  
>  	/* private: internal use only. */
>  	bool success;
> @@ -163,6 +165,22 @@ static inline char *kunit_status_to_string(bool status)
>   */
>  #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
>  
> +/**
> + * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct kunit_case
> + *
> + * @test_name: a reference to a test case function.
> + * @gen_params: a reference to a parameter generator function.
> + *
> + * The generator function ``const void* gen_params(const void *prev)`` is used
> + * to lazily generate a series of arbitrarily typed values that fit into a
> + * void*. The argument @prev is the previously returned value, which should be
> + * used to derive the next value; @prev is set to NULL on the initial generator
> + * call.  When no more values are available, the generator must return NULL.
> + */
> +#define KUNIT_CASE_PARAM(test_name, gen_params)			\
> +		{ .run_case = test_name, .name = #test_name,	\
> +		  .generate_params = gen_params }
> +
>  /**
>   * struct kunit_suite - describes a related collection of &struct kunit_case
>   *
> @@ -208,6 +226,10 @@ struct kunit {
>  	const char *name; /* Read only after initialization! */
>  	char *log; /* Points at case log after initialization */
>  	struct kunit_try_catch try_catch;
> +	/* param_value is the current parameter value for a test case. */
> +	const void *param_value;
> +	/* param_index stores the index of the parameter in parameterized tests. */
> +	int param_index;
>  	/*
>  	 * success starts as true, and may only be set to false during a
>  	 * test case; thus, it is safe to update this across multiple
> @@ -1742,4 +1764,18 @@ do {									       \
>  						fmt,			       \
>  						##__VA_ARGS__)
>  
> +/**
> + * KUNIT_ARRAY_PARAM() - Define test parameter generator from an array.
> + * @name:  prefix for the test parameter generator function.
> + * @array: array of test parameters.
> + *
> + * Define function @name_gen_params which uses @array to generate parameters.
> + */
> +#define KUNIT_ARRAY_PARAM(name, array)								\
> +	static const void *name##_gen_params(const void *prev)					\
> +	{											\
> +		typeof((array)[0]) * __next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
> +		return __next - (array) < ARRAY_SIZE((array)) ? __next : NULL;			\
> +	}
> +
>  #endif /* _KUNIT_TEST_H */
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 750704abe89a..453ebe4da77d 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -325,29 +325,25 @@ static void kunit_catch_run_case(void *data)
>   * occur in a test case and reports them as failures.
>   */
>  static void kunit_run_case_catch_errors(struct kunit_suite *suite,
> -					struct kunit_case *test_case)
> +					struct kunit_case *test_case,
> +					struct kunit *test)
>  {
>  	struct kunit_try_catch_context context;
>  	struct kunit_try_catch *try_catch;
> -	struct kunit test;
>  
> -	kunit_init_test(&test, test_case->name, test_case->log);
> -	try_catch = &test.try_catch;
> +	kunit_init_test(test, test_case->name, test_case->log);
> +	try_catch = &test->try_catch;
>  
>  	kunit_try_catch_init(try_catch,
> -			     &test,
> +			     test,
>  			     kunit_try_run_case,
>  			     kunit_catch_run_case);
> -	context.test = &test;
> +	context.test = test;
>  	context.suite = suite;
>  	context.test_case = test_case;
>  	kunit_try_catch_run(try_catch, &context);
>  
> -	test_case->success = test.success;
> -
> -	kunit_print_ok_not_ok(&test, true, test_case->success,
> -			      kunit_test_case_num(suite, test_case),
> -			      test_case->name);
> +	test_case->success = test->success;
>  }
>  
>  int kunit_run_tests(struct kunit_suite *suite)
> @@ -356,8 +352,32 @@ int kunit_run_tests(struct kunit_suite *suite)
>  
>  	kunit_print_subtest_start(suite);
>  
> -	kunit_suite_for_each_test_case(suite, test_case)
> -		kunit_run_case_catch_errors(suite, test_case);
> +	kunit_suite_for_each_test_case(suite, test_case) {
> +		struct kunit test = { .param_value = NULL, .param_index = 0 };
> +		bool test_success = true;
> +
> +		if (test_case->generate_params)
> +			test.param_value = test_case->generate_params(NULL);
> +
> +		do {
> +			kunit_run_case_catch_errors(suite, test_case, &test);
> +			test_success &= test_case->success;
> +
> +			if (test_case->generate_params) {
> +				kunit_log(KERN_INFO, &test,
> +					  KUNIT_SUBTEST_INDENT
> +					  "# %s param#%d - %s",
> +					  kunit_status_to_string(test.success),
> +					  test.param_index, test_case->name);
> +				test.param_value = test_case->generate_params(test.param_value);
> +				test.param_index++;
> +			}
> +		} while (test.param_value);
> +
> +		kunit_print_ok_not_ok(&test, true, test_success,
> +				      kunit_test_case_num(suite, test_case),
> +				      test_case->name);
> +	}
>  
>  	kunit_print_subtest_end(suite);
>  
> 

