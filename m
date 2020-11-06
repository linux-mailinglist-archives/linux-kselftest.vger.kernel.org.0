Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC4B2A9942
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 17:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgKFQRD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 11:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFQRD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 11:17:03 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC01CC0613CF;
        Fri,  6 Nov 2020 08:17:02 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id o129so1778593pfb.1;
        Fri, 06 Nov 2020 08:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GIiDRjfD+D9uuVj6LC2gBpgfKRl2JqMK7UQ+scSN+nE=;
        b=df6DsYAKyP6d8eWOUovc3KP4fzxm+1NNPjbIVftPl+DPowkas92qhj4BxQFjPbAvTY
         lpG+I4pjxdcxOgA/AGQZTRtt1yPfTpjv8cHKDwf/w2/WkvTzn7XmSd0xoOFUn485hxW4
         MBrmVYymAFvadAOoIxiUWlGYfOLamaYuF1oaSDIkcDwsVR5XIt5eQMN0pQ6c0y8HK1uL
         Gtd+6awOUXDEeo3AGlVtpubTX8rpj0ZYUV9bSFmytZJl3OBUGZimGC9Z1KVgylgvREOs
         CkwKKC8L3YQz/w8J/wlCYhUqQuiw55hnHgSgI+ij4OSIM4FrQ2CJIHzB6/QPfKh9945g
         GTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GIiDRjfD+D9uuVj6LC2gBpgfKRl2JqMK7UQ+scSN+nE=;
        b=n4XitF5EOr4voHn5umABzlfodsJuI9m+CL14AS/zcbf6gcIzHYoLzhCOUWrmKwrQ4B
         zbT1+RPbf8wiAlqNoL0K1fbnUJTj3Lr+0uS0MSP3kZWcluukcMYY5fw2Wzng4VNwv7dg
         jS0U9RIpzIgphabs+1IbAYo48A+R7E7GczygpJQLi2CpXfIvzkwqe1URKzyB6/qP+Ipb
         UYpaNnz4/BLOIMEb/9Ap5Mwn2HUKI2Cu3O35+aqr6mmOUnU9JLMfP5GgKVMhHuOFeNgj
         q940QWYhDsHRY+MbPyKD/8/8Owr6KJtTOTpgaE/84BcvVKxWIGHgjoo9KYWTpRxxuBFD
         xTmg==
X-Gm-Message-State: AOAM530VC9fyUpUtLuPRQdyUqP7nDMnq9ockE5zRX9jC1leUshOogsu3
        IY0yOM+GZ3xARpscr9V9YI2ldkzEq+GkDqeY
X-Google-Smtp-Source: ABdhPJwnDoJrtL5aeI5DbCndonv+glzjC8eGV+DYNASrK1vdEtIuxC6TMYU169jX0Ikvy346xo983A==
X-Received: by 2002:a62:55c6:0:b029:160:1c33:a0f7 with SMTP id j189-20020a6255c60000b02901601c33a0f7mr2682150pfb.35.1604679421913;
        Fri, 06 Nov 2020 08:17:01 -0800 (PST)
Received: from [192.168.86.81] ([106.51.243.217])
        by smtp.gmail.com with ESMTPSA id v6sm2553461pff.83.2020.11.06.08.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 08:17:01 -0800 (PST)
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
 <f7e04221-607c-dd05-24a6-27c26d86919d@gmail.com>
 <CANpmjNMH9v3RE9xCh9nS=ZmBboxAsMvhfgby+QEO=Q3-oEyiNA@mail.gmail.com>
 <20201106123433.GA3563235@elver.google.com>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <33ef990d-000e-657c-07bb-1896fdb86b9d@gmail.com>
Date:   Fri, 6 Nov 2020 21:46:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201106123433.GA3563235@elver.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06/11/20 6:04 pm, Marco Elver wrote:
> On Fri, Nov 06, 2020 at 09:11AM +0100, Marco Elver wrote:
>> On Fri, 6 Nov 2020 at 06:54, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> [...]
>>> I think this format of output should be fine for parameterized tests.
>>> But, this patch has the same issue as earlier. While, the tests run and
>>> this is the output that can be seen using dmesg, it still causes an issue on
>>> using the kunit tool. It gives a similar error:
>>>
>>> [11:07:38] [ERROR]  expected 7 test suites, but got -1
>>> [11:07:38] [ERROR] expected_suite_index -1, but got 2
>>> [11:07:38] [ERROR] got unexpected test suite: kunit-try-catch-test
>>> [ERROR] no tests run!
>>> [11:07:38] ============================================================
>>> [11:07:38] Testing complete. 0 tests run. 0 failed. 0 crashed.
>>>
>>
>> I'd suggest testing without these patches and diffing the output.
>> AFAIK we're not adding any new non-# output, so it might be a
>> pre-existing bug in some parsing code. Either that, or the parsing
>> code does not respect the # correctly?
> 
> Hmm, tools/testing/kunit/kunit_parser.py has
> 
> 	SUBTEST_DIAGNOSTIC = re.compile(r'^[\s]+# .*?: (.*)$')
> 
> , which seems to expect a ': ' in there. Not sure if this is required by
> TAP, but let's leave this alone for now.
> 

Oh okay.

> We can change the output to not trip this up, which might also be more a
> consistent diagnostic format vs. other diagnostics. See the revised
> patch below. With it the output is as follows:
> 
> | TAP version 14
> | 1..6
> |     # Subtest: ext4_inode_test
> |     1..1
> |     # inode_test_xtimestamp_decoding: param-0 ok
> |     # inode_test_xtimestamp_decoding: param-1 ok
> |     # inode_test_xtimestamp_decoding: param-2 ok
> |     # inode_test_xtimestamp_decoding: param-3 ok
> |     # inode_test_xtimestamp_decoding: param-4 ok
> |     # inode_test_xtimestamp_decoding: param-5 ok
> |     # inode_test_xtimestamp_decoding: param-6 ok
> |     # inode_test_xtimestamp_decoding: param-7 ok
> |     # inode_test_xtimestamp_decoding: param-8 ok
> |     # inode_test_xtimestamp_decoding: param-9 ok
> |     # inode_test_xtimestamp_decoding: param-10 ok
> |     # inode_test_xtimestamp_decoding: param-11 ok
> |     # inode_test_xtimestamp_decoding: param-12 ok
> |     # inode_test_xtimestamp_decoding: param-13 ok
> |     # inode_test_xtimestamp_decoding: param-14 ok
> |     # inode_test_xtimestamp_decoding: param-15 ok
> |     ok 1 - inode_test_xtimestamp_decoding
> | ok 1 - ext4_inode_test
> 
> And kunit-tool seems to be happy as well.
> 

Yes this works as expected. Thank you!
I will send this patch as v5.

> Thanks,
> -- Marco
> 
> ------ >8 ------
> 
> From 13a94d75d6b1b430e89fcff2cd76629b56b9d636 Mon Sep 17 00:00:00 2001
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
> index 750704abe89a..329fee9e0634 100644
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
> +					  "# %s: param-%d %s",
> +					  test_case->name, test.param_index,
> +					  kunit_status_to_string(test.success));
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

