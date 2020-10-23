Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EE129773B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 20:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462467AbgJWSsM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Oct 2020 14:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465815AbgJWSsL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Oct 2020 14:48:11 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1B0C0613D2
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Oct 2020 11:48:11 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v5so2722606wmh.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Oct 2020 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a0PzLeTg3yakVCFG7qD5Xig1rmXRsgD+wVT4ZvpvDgc=;
        b=MYXkJzrFf+sXRkOO2oFypfPDGTu4Ljs/eaRLz3UGkWRrODXeXSCJGpHCko/QrL0+0a
         cAfkTtvK76NKERxdaNv/Wzb86wFgiUpNk11FllfJuD4SegIhJ3XqAwsR/+opIGm8UfnJ
         A7yWeYdxf7n2bzxqTGOl7QCksS4y4+hWL94yrJW35pzOyawWxC+6JSD5CGqH1TIfHAla
         cmNAhUsmuLdEpry4hZUh2/sNKhbhLEHNrMJC6hkNxWoDAuFWkytb3jnR1SbmhLER4Ui/
         uw20cq0vLlodd8a4r0++6HuMZxF+hyOHRzO2FcUnKaXV/qjYGQUJXT04EjHdvyZZw7Is
         B27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a0PzLeTg3yakVCFG7qD5Xig1rmXRsgD+wVT4ZvpvDgc=;
        b=dvHDVY1hLTzVlW12HTbgZF98sdjwsi/+Vh6vj9bv74t8QRBme3MV6GGAaS23USVzgY
         +/7H4mfDf9NpUV56Rahy20vFGBpS8GpL6+AtemcD44GhbpZ0W9H/5bHkFPM7YMW3qwUt
         YexkBrkElKBPwsu1TbJCaqDIcfe31MzwPIpLWR2RZRZSomOxuy9Jksx9kVBNYgO+eTj4
         CQrmMNx2irIBPZzL+9r3D0WUwzOfNSg4ph0Ew58zUDOj6YAWEUAeSMHbjRbUBOytkEue
         8aSqVHpLbI1Ei4bUO0C3Jl/QwIGmaMuvfZms5TWL2qeSNG7xaVlAhiq8XRvHKkCEKp2u
         G0Gw==
X-Gm-Message-State: AOAM532oeuMjcSNFI1U78X8bWuisA9Y95rDjpik3Lve3AzCVRg6NkjwB
        kdvejBNMBhuXXzWs2fXXGfKtVg==
X-Google-Smtp-Source: ABdhPJzJ9MrdBDYGIxOFyAs3TuHSCjPE/x6kmNr1dP9zBCFjQ8F0sC1WS1pL9q0L0vRzPXAbs9HxdA==
X-Received: by 2002:a1c:59c3:: with SMTP id n186mr3671406wmb.32.1603478889733;
        Fri, 23 Oct 2020 11:48:09 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id 1sm5314861wre.61.2020.10.23.11.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 11:48:08 -0700 (PDT)
Date:   Fri, 23 Oct 2020 20:48:03 +0200
From:   Marco Elver <elver@google.com>
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        yzaikin@google.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 1/2] kunit: Support for Parameterized Testing
Message-ID: <20201023184803.GA3922681@elver.google.com>
References: <20201023150536.282568-1-98.arpi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023150536.282568-1-98.arpi@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 23, 2020 at 08:35PM +0530, Arpitha Raghunandan wrote:
> Implementation of support for parameterized testing in KUnit.

Already looks much cleaner, thanks for using this approach!

I think the commit message needs a brief summary of the approach.

> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> ---
> Changes v1->v2:
> - Use of a generator method to access test case parameters
> 
>  include/kunit/test.h | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  lib/kunit/test.c     | 20 +++++++++++++++++++-
>  2 files changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index a423fffefea0..c417ac140326 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -141,6 +141,7 @@ struct kunit;
>  struct kunit_case {
>  	void (*run_case)(struct kunit *test);
>  	const char *name;
> +	void* (*generate_params)(struct kunit *test, void *prev);

Would adding documentation above this field be the right place, or
somewhere else? In any case, some explanation of the protocol would be
good.

>  	/* private: internal use only. */
>  	bool success;
> @@ -162,6 +163,9 @@ static inline char *kunit_status_to_string(bool status)
>   * &struct kunit_case for an example on how to use it.
>   */
>  #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
> +#define KUNIT_CASE_PARAM(test_name, gen_params)			\
> +		{ .run_case = test_name, .name = #test_name,	\
> +		  .generate_params = gen_params }
>  
>  /**
>   * struct kunit_suite - describes a related collection of &struct kunit_case
> @@ -208,6 +212,15 @@ struct kunit {
>  	const char *name; /* Read only after initialization! */
>  	char *log; /* Points at case log after initialization */
>  	struct kunit_try_catch try_catch;
> +	/* param_values points to test case parameters in parameterized tests */
> +	void *param_values;
> +	/*
> +	 * current_param stores the index of the parameter in
> +	 * the array of parameters in parameterized tests.
> +	 * current_param + 1 is printed to indicate the parameter
> +	 * that causes the test to fail in case of test failure.
> +	 */
> +	int current_param;
>  	/*
>  	 * success starts as true, and may only be set to false during a
>  	 * test case; thus, it is safe to update this across multiple
> @@ -1742,4 +1755,36 @@ do {									       \
>  						fmt,			       \
>  						##__VA_ARGS__)
>  
> +/**
> + * kunit_param_generator_helper() - Helper method for test parameter generators
> + * 				    required in parameterized tests.
> + * @test: The test context object.
> + * @prev_param: a pointer to the previous test parameter, NULL for first parameter.
> + * @param_array: a user-supplied pointer to an array of test parameters.
> + * @array_size: number of test parameters in the array.
> + * @type_size: size of one test parameter.
> + */
> +static inline void *kunit_param_generator_helper(struct kunit *test,

I don't think this needs to be inline, but see my other suggestion
below, which might make this function obsolete.

> +					void *prev_param,
> +					void *param_array,
> +					size_t array_size,
> +					size_t type_size)
> +{
> +	KUNIT_ASSERT_EQ(test, (prev_param - param_array) % type_size, 0);
> +
> +	if (!prev_param)
> +		return param_array;
> +
> +	KUNIT_ASSERT_GE(test, prev_param, param_array);
> +
> +	if (prev_param + type_size < param_array + (array_size * type_size))
> +		return prev_param + type_size;
> +	else
> +		return NULL;
> +}
> +
> +#define KUNIT_PARAM_GENERATOR_HELPER(test, prev_param, param_array, param_type) \
> +	kunit_param_generator_helper(test, prev_param, param_array,		\
> +				ARRAY_SIZE(param_array), sizeof(param_type))

You do not need param_type, you can use the same trick that ARRAY_SIZE
uses:

	#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))

So you could use sizeof((param_aray)[0]) instead of sizeof(param_type).
ARRAY_SIZE already checks for you that it's a real array via
__must_be_array().


The other question is, will kunit_param_generator_helper() find much use
without the KUNIT_PARAM_GENERATOR_HELPER() macro? If I have some
complicated generator protocol to generate params, then I'd just
directly write the generator function. If your intent is to simplify the
common-case array based generators, why not just have a macro generate
the generator function?

More specifically, have this macro here:

+#define KUNIT_ARRAY_PARAM(name, array)								\
+	static void *name##_gen_params(struct kunit *test, void *prev)				\
+	{											\
+		typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
+		return __next - (array) < ARRAY_SIZE((array)) ? __next : NULL;			\
+	}

[ It is entirely untested, but if it works verbatim you'll probably need my

	Co-developed-by: Marco Elver <elver@google.com>
	Signed-off-by: Marco Elver <elver@google.com>
 
 just in case... ]

Then, it can be used as follows:

	static int num_cpus[] = {1, 2, 3, 4, 5};
	KUNIT_ARRAY_PARAM(num_cpus, num_cpus);

Then somewhere else:

	KUNIT_CASE_PARAM(some_test, num_cpus_gen_params);

>  #endif /* _KUNIT_TEST_H */
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 750704abe89a..0e6ffe6384a7 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -127,6 +127,11 @@ unsigned int kunit_test_case_num(struct kunit_suite *suite,
>  }
>  EXPORT_SYMBOL_GPL(kunit_test_case_num);
>  
> +static void kunit_print_failed_param(struct kunit *test)
> +{
> +	kunit_err(test, "\n\tTest failed at parameter: %d\n", test->current_param + 1);
> +}
> +
>  static void kunit_print_string_stream(struct kunit *test,
>  				      struct string_stream *stream)
>  {
> @@ -168,6 +173,8 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
>  	assert->format(assert, stream);
>  
>  	kunit_print_string_stream(test, stream);
> +	if (test->param_values)
> +		kunit_print_failed_param(test);
>  
>  	WARN_ON(string_stream_destroy(stream));
>  }
> @@ -239,7 +246,18 @@ static void kunit_run_case_internal(struct kunit *test,
>  		}
>  	}
>  
> -	test_case->run_case(test);
> +	if (!test_case->generate_params) {
> +		test_case->run_case(test);
> +	} else {
> +		test->param_values = test_case->generate_params(test, NULL);
> +		test->current_param = 0;
> +
> +		while (test->param_values) {
> +			test_case->run_case(test);
> +			test->param_values = test_case->generate_params(test, test->param_values);
> +			test->current_param++;
> +		}
> +	}
>  }
>  
>  static void kunit_case_internal_cleanup(struct kunit *test)

Otherwise looks fine.

Thanks,
-- Marco
