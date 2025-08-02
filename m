Return-Path: <linux-kselftest+bounces-38217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2351FB18DCD
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 11:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E5C176A21
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 09:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65B72459F2;
	Sat,  2 Aug 2025 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mkvmXhu6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538202459EA
	for <linux-kselftest@vger.kernel.org>; Sat,  2 Aug 2025 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754127920; cv=none; b=H7Lix8qbbkcG3Vfb1hBY05IzykNPKn0k3IKm0aT5zflqXvbZicqrdjU1X+8n1w+XhCtuAJPhV1AaKH1K2m7njago630Fk+hlnWOXutajNi5E3lI1ePNAZPt0YjplpsYiyzlteKpkTtNUwIWb7iRj2N9+OhEKvyoZmSc2xu1KfNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754127920; c=relaxed/simple;
	bh=MW69kZt8kfBdU4JV8RQEluMjhhMK5MbgKXnnztMTCf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wi2lK6xk9HPTJoOaoIitKegkiSL1XfKEgcR/e1O/jXqR/DtA5InhhTtwUMJpsvjtbkPDW5Ama/4aJcwm3XcW1ZAqUeD/Q0AVxWiboBmBjqXVzL+Jf4Z+2LckcZRDoHCxWUcbXgx07MBTsr5o6CPpaakF4fBmvpYNmKqPn3Mvlmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mkvmXhu6; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70748a0e13dso25316506d6.1
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Aug 2025 02:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754127916; x=1754732716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I0zesJPKKOqOqafkYIS9zu/pVVtnqPrwT2UWa2YaCog=;
        b=mkvmXhu6k+bxmzCpX9HeE+Q5EZPE0/wjhxVqP80ADfwUSOlxy0/OoUe+eT0G2ZALQi
         tMywlGxUWASuFVAjmHGivlvUq5Lv3cQNfVv+Ykp5atHitLH7HFuK9cHEpo25dQnfJmhj
         5SRmC5xbnATUFT410rvNiVXxR8sSwRRKnMTgWdb6kKcZmr7vEpGg/f2QMOz6YYYpGhqi
         KczEG/BlWsjuomojMKdtJqSMwgfsDddVpM9F6hsTgkUyPjkxruAncX6aNSD7oAUvrpP3
         YMlrtSd6q2j8xCBbqdB4GW5a7eclaguuZCmi84aiZ5Md1yiSOF98qrRC//BDT0IcRaiq
         8SOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754127916; x=1754732716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0zesJPKKOqOqafkYIS9zu/pVVtnqPrwT2UWa2YaCog=;
        b=SSXtj5LI8UVtsMG0nuko/GBsqCvEL5ul10lrubD3LiUj+P5aycTbcpb8gct71PQAjc
         TOZ8o6bxBhHjWzhIiwgKo3aCwF3B34ihUJJWc8ftK6uQiFRPaMO74jlS6SFjtoDOQ2Kf
         /1JblbSPN4wuC0G/6BJeSNj5N9/ZKuq0nJc17JSJcyp2M2Hg9c74r0lm7kpG/1hhLUHE
         y0+4E1mMfKOtfuDxKrFB+9gip0tDxqOVc/gYWsjlggAuQDyv3462YujSdHHZL/124dWX
         5wu5E+QoUN8jIEd9T8hZam2LujlpoigDmRVIyIawzGlgUo2jxBs8ZK7GqGYJPLXWrujB
         Ifig==
X-Forwarded-Encrypted: i=1; AJvYcCUGwbYwc4DAiXMpCCHDqEJ+8WgMbHAnTVwW/a2gPNcndrnNcPPscDRVHKnXSFqMLnSoN4D6hagQ5TaUyWnF1bw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9xgAM1YbpczSZgUcLSxJ1fazGzEq2g1uxOWo4ovnrC6Kc84uV
	vsvbnVqj0DKvap0IoQ9ivq5I4t1tJ2qEvUzvSpQZ7jMnS+LT+0MTbX0h+sjntGJCUeku7qqV5l2
	B7tpEeJ4ig2CzeJf53U8+WxKdIypgYmTEEenbLzJ3
X-Gm-Gg: ASbGnctJRTmZizNwsvRTsQ1e0sUobWH1bca/hA/qfks8K9iWhgGNjies8nQlter73/r
	jwuo2M9ZVVg9ZXBB3yWb/V5+qNeeBbTNQaOkV1E72yHZf2sOGFUrPGY+uCodEVxB3sSywQ2D/AG
	0BMd7AJYWXHSBUpbLMVXJCGWMCBE5Z8bAEo4AQvlhbnVOfqD7JX/20/YNP25xQHiSHOX9fsvGaF
	R7wiWoR
X-Google-Smtp-Source: AGHT+IG5KrIx3Vln0wHRyMbEn9wfXa3nzst/J0KJwSmMdshEKTwJHOoSUPWhXO2HXuHzcba+9H0b0q+gxvwMpFhdxEY=
X-Received: by 2002:ad4:5747:0:b0:6fb:25f:ac8c with SMTP id
 6a1803df08f44-7093626cec8mr41067216d6.31.1754127915668; Sat, 02 Aug 2025
 02:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com> <20250729193647.3410634-10-marievic@google.com>
In-Reply-To: <20250729193647.3410634-10-marievic@google.com>
From: David Gow <davidgow@google.com>
Date: Sat, 2 Aug 2025 17:45:02 +0800
X-Gm-Features: Ac12FXztqWwaOCI5qNeFoZ80YlZQbPxDxxsBqBADT-CQI0GZH_gqfj5Bz6a0BDc
Message-ID: <CABVgOSnWF=xnfSJjCJ4KYAPhnY7OyeU7w1e2MXi5U25nwaT+MQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] Documentation: kunit: Document new parameterized test features
To: Marie Zhussupova <marievic@google.com>
Cc: rmoar@google.com, shuah@kernel.org, brendan.higgins@linux.dev, 
	elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005b4deb063b5ebb59"

--0000000000005b4deb063b5ebb59
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 03:37, Marie Zhussupova <marievic@google.com> wrote:
>
> -Update the KUnit documentation to explain the concept
> of a parent parameterized test.
> -Add examples demonstrating different ways of passing
> parameters to parameterized tests and how to manage
> shared resources between them.
>

Nit: We don't need the dot points ('-') here. Just make them paragraphs.

> Signed-off-by: Marie Zhussupova <marievic@google.com>
> ---

Thanks very, very much for including such detailed documentation.

I do think some of the examples could be trimmed / left in the
kunit-example-test.c file and referenced, as they're long enough that
it's difficult to focus on the essentials. But otherwise, this looks
great.

A few small notes below, but otherwise:

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  Documentation/dev-tools/kunit/usage.rst | 455 +++++++++++++++++++++++-
>  1 file changed, 449 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 066ecda1dd98..be1d656053cf 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -542,11 +542,21 @@ There is more boilerplate code involved, but it can:
>  Parameterized Testing
>  ~~~~~~~~~~~~~~~~~~~~~
>
> -The table-driven testing pattern is common enough that KUnit has special
> -support for it.
> -
> -By reusing the same ``cases`` array from above, we can write the test as a
> -"parameterized test" with the following.
> +To efficiently and elegantly validate a test case against a variety of inputs,
> +KUnit also provides a parameterized testing framework. This feature formalizes
> +and extends the concept of table-driven tests discussed previously, offering
> +a more integrated and flexible way to handle multiple test scenarios with
> +minimal code duplication.

Nit: maybe we can tone down the adjectives slightly here. I do like
parameterised testing a lot, but it probably doesn't need to be
"efficient", "elegant", "integrated", and "flexible".

> +
> +Passing Parameters to the Test Cases
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +There are three main ways to provide the parameters to a test case:
> +
> +Array Parameter Macros (``KUNIT_ARRAY_PARAM`` or ``KUNIT_ARRAY_PARAM_DESC``):
> +   KUnit provides special support for the common table-driven testing pattern.
> +   By applying either ``KUNIT_ARRAY_PARAM`` or ``KUNIT_ARRAY_PARAM_DESC`` to the
> +   ``cases`` array from the previous section, we can create a parameterized test
> +   as shown below:
>
>  .. code-block:: c
>
> @@ -555,7 +565,7 @@ By reusing the same ``cases`` array from above, we can write the test as a
>                 const char *str;
>                 const char *sha1;
>         };
> -       const struct sha1_test_case cases[] = {
> +       static const struct sha1_test_case cases[] = {
>                 {
>                         .str = "hello world",
>                         .sha1 = "2aae6c35c94fcfb415dbe95f408b9ce91ee846ed",
> @@ -590,6 +600,439 @@ By reusing the same ``cases`` array from above, we can write the test as a
>                 {}
>         };
>
> +Custom Parameter Generator (``generate_params``):
> +   You can pass your own ``generate_params`` function to the ``KUNIT_CASE_PARAM``
> +   or ``KUNIT_CASE_PARAM_WITH_INIT`` macros. This function is responsible for
> +   generating parameters one by one. It receives the previously generated parameter
> +   as the ``prev`` argument (which is ``NULL`` on the first call) and can also
> +   access any context available from the parent ``struct kunit`` passed as the
> +   ``test`` argument. KUnit calls this function repeatedly until it returns
> +   ``NULL``. Below is an example of how it works:
> +
> +.. code-block:: c
> +
> +       #define MAX_TEST_BUFFER_SIZE 8
> +
> +       // Example generator function. It produces a sequence of buffer sizes that
> +       // are powers of two, starting at 1 (e.g., 1, 2, 4, 8).
> +       static const void *buffer_size_gen_params(struct kunit *test, const void *prev, char *desc)
> +       {
> +               long prev_buffer_size = (long)prev;
> +               long next_buffer_size = 1; // Start with an initial size of 1.
> +
> +               // Stop generating parameters if the limit is reached or exceeded.
> +               if (prev_buffer_size >= MAX_TEST_BUFFER_SIZE)
> +                       return NULL;
> +
> +               // For subsequent calls, calculate the next size by doubling the previous one.
> +               if (prev)
> +                       next_buffer_size = prev_buffer_size << 1;
> +
> +               return (void *)next_buffer_size;
> +       }
> +
> +       // Simple test to validate that kunit_kzalloc provides zeroed memory.
> +       static void buffer_zero_test(struct kunit *test)
> +       {
> +               long buffer_size = (long)test->param_value;
> +               // Use kunit_kzalloc to allocate a zero-initialized buffer. This makes the
> +               // memory "parameter managed," meaning it's automatically cleaned up at
> +               // the end of each parameter execution.
> +               int *buf = kunit_kzalloc(test, buffer_size * sizeof(int), GFP_KERNEL);
> +
> +               // Ensure the allocation was successful.
> +               KUNIT_ASSERT_NOT_NULL(test, buf);
> +
> +               // Loop through the buffer and confirm every element is zero.
> +               for (int i = 0; i < buffer_size; i++)
> +                       KUNIT_EXPECT_EQ(test, buf[i], 0);
> +       }
> +
> +       static struct kunit_case buffer_test_cases[] = {
> +               KUNIT_CASE_PARAM(buffer_zero_test, buffer_size_gen_params),
> +               {}
> +       };
> +
> +Direct Registration in Parameter Init Function (using ``kunit_register_params_array``):

Maybe we should highlight this as being array-based more explicitly.
"Runtime Array Registration in the Init function" or similar?

> +   For more complex scenarios, you can directly register a parameter array with
> +   a test case instead of using a ``generate_params`` function. This is done by
> +   passing the array to the ``kunit_register_params_array`` macro within an
> +   initialization function for the parameterized test series
> +   (i.e., a function named ``param_init``). To better understand this mechanism
> +   please refer to the "Adding Shared Resources" section below.
> +
> +   This method supports both dynamically built and static arrays.
> +
> +   As the following code shows, the ``example_param_init_dynamic_arr`` function
> +   utilizes ``make_fibonacci_params`` to create a dynamic array, which is then
> +   registered using ``kunit_register_params_array``. The corresponding exit
> +   function, ``example_param_exit``, is responsible for freeing this dynamically
> +   allocated params array after the parameterized test series ends.
> +
> +.. code-block:: c
> +
> +       /*
> +        * Helper function to create a parameter array of Fibonacci numbers. This example
> +        * highlights a parameter generation scenario that is:
> +        * 1. Not feasible to fully pre-generate at compile time.
> +        * 2. Challenging to implement with a standard 'generate_params' function,
> +        * as it typically only provides the immediately 'prev' parameter, while
> +        * Fibonacci requires access to two preceding values for calculation.
> +        */
> +       static void *make_fibonacci_params(int seq_size)
> +       {
> +               int *seq;
> +
> +               if (seq_size <= 0)
> +                       return NULL;
> +
> +               seq = kmalloc_array(seq_size, sizeof(int), GFP_KERNEL);
> +
> +               if (!seq)
> +                       return NULL;
> +
> +               if (seq_size >= 1)
> +                       seq[0] = 0;
> +               if (seq_size >= 2)
> +                       seq[1] = 1;
> +               for (int i = 2; i < seq_size; i++)
> +                       seq[i] = seq[i - 1] + seq[i - 2];
> +               return seq;
> +       }
> +
> +       // This is an example of a function that provides a description for each of the
> +       // parameters.
> +       static void example_param_dynamic_arr_get_desc(const void *p, char *desc)
> +       {
> +               const int *fib_num = p;
> +
> +               snprintf(desc, KUNIT_PARAM_DESC_SIZE, "fibonacci param: %d", *fib_num);
> +       }
> +
> +       // Example of a parameterized test init function that registers a dynamic array.
> +       static int example_param_init_dynamic_arr(struct kunit *test)
> +       {
> +               int seq_size = 6;
> +               int *fibonacci_params = make_fibonacci_params(seq_size);
> +
> +               if (!fibonacci_params)
> +                       return -ENOMEM;
> +
> +               /*
> +                * Passes the dynamic parameter array information to the parent struct kunit.
> +                * The array and its metadata will be stored in test->parent->params_data.
> +                * The array itself will be located in params_data.params.
> +                */
> +               kunit_register_params_array(test, fibonacci_params, seq_size,
> +                                           example_param_dynamic_arr_get_desc);
> +               return 0;
> +       }
> +
> +       // Function to clean up the parameterized test's parent kunit struct if
> +       // there were custom allocations.
> +       static void example_param_exit_dynamic_arr(struct kunit *test)
> +       {
> +               /*
> +                * We allocated this array, so we need to free it.
> +                * Since the parent parameter instance is passed here,
> +                * we can directly access the array via `test->params_data.params`
> +                * instead of `test->parent->params_data.params`.
> +                */
> +               kfree(test->params_data.params);
> +       }
> +
> +       /*
> +        * Example of test that uses the registered dynamic array to perform assertions
> +        * and expectations.
> +        */
> +       static void example_params_test_with_init_dynamic_arr(struct kunit *test)
> +       {
> +               const int *param = test->param_value;
> +               int param_val;
> +
> +               /* By design, param pointer will not be NULL. */
> +               KUNIT_ASSERT_NOT_NULL(test, param);
> +
> +               param_val = *param;
> +               KUNIT_EXPECT_EQ(test, param_val - param_val, 0);
> +       }
> +
> +       static struct kunit_case example_tests[] = {
> +               // The NULL here stands in for the generate_params function
> +               KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init_dynamic_arr, NULL,
> +                                          example_param_init_dynamic_arr,
> +                                          example_param_exit_dynamic_arr),
> +               {}
> +       };
> +

This is a long example, which already exists in the source code
(kunit-example-test.c). Could we just include some highlights (e.g.,
the init function and the KUNIT_CASE_PARAM_WITH_INIT call), and link
to the source code for the rest?

> +Adding Shared Resources
> +^^^^^^^^^^^^^^^^^^^^^^^
> +All parameterized test executions in this framework have a parent test of type
> +``struct kunit``. This parent is not used to execute any test logic itself;
> +instead, it serves as a container for shared context that can be accessed by
> +all its individual test executions (or parameters). Therefore, each individual
> +test execution holds a pointer to this parent, accessible via a field named
> +``parent``.
> +
> +It's possible to add resources to share between the individual test executions
> +within a parameterized test series by using the ``KUNIT_CASE_PARAM_WITH_INIT``
> +macro, to which you pass custom ``param_init`` and ``param_exit`` functions.
> +These functions run once before and once after the entire parameterized test
> +series, respectively. The ``param_init`` function can be used for adding any
> +resources to the resources field of a parent test and also provide an additional
> +way of setting the parameter array. The ``param_exit`` function can be used
> +release any resources that were not test managed i.e. not automatically cleaned
> +up after the test ends.
> +
> +.. note::
> +   If both a ``generate_params`` function is passed to ``KUNIT_CASE_PARAM_WITH_INIT``
> +   and an array is registered via ``kunit_register_params_array`` in
> +   ``param_init``, the ``generate_params`` function will be used to get
> +   the parameters.

Maybe note that the ``generate_params`` function can use the array
passed, though?

> +
> +Both ``param_init`` and ``param_exit`` are passed the parent instance of a test
> +(parent ``struct kunit``) behind the scenes. However, the test case function
> +receives the individual instance of a test for each parameter. Therefore, to
> +manage and access shared resources from within a test case function, you must use
> +``test->parent``.
> +
> +.. note::
> +   The ``suite->init()`` function, which runs before each parameter execution,
> +   receives the individual instance of a test for each parameter. Therefore,
> +   resources set up in ``suite->init()`` are reset for each individual
> +   parameterized test execution and are only visible within that specific test.
> +
> +For instance, finding a shared resource allocated by the Resource API requires
> +passing ``test->parent`` to ``kunit_find_resource()``. This principle extends to
> +all other APIs that might be used in the test case function, including
> +``kunit_kzalloc()``, ``kunit_kmalloc_array()``, and others (see
> +Documentation/dev-tools/kunit/api/test.rst and the
> +Documentation/dev-tools/kunit/api/resource.rst).
> +
> +The code below shows how you can add the shared resources. Note that this code
> +utilizes the Resource API, which you can read more about here:
> +Documentation/dev-tools/kunit/api/resource.rst.
> +
> +.. code-block:: c
> +
> +       /* An example parameter array. */
> +       static const struct example_param {
> +               int value;
> +       } example_params_array[] = {
> +               { .value = 3, },
> +               { .value = 2, },
> +               { .value = 1, },
> +               { .value = 0, },
> +       };
> +
> +       /*
> +        * This custom function allocates memory for the kunit_resource data field.
> +        * The function is passed to kunit_alloc_resource() and executed once
> +        * by the internal helper __kunit_add_resource().
> +        */
> +       static int example_resource_init(struct kunit_resource *res, void *context)
> +       {
> +               int *info = kmalloc(sizeof(*info), GFP_KERNEL);
> +
> +               if (!info)
> +                       return -ENOMEM;
> +               *info = *(int *)context;
> +               res->data = info;
> +               return 0;
> +       }
> +
> +       /*
> +        * This function deallocates memory for the 'kunit_resource' data field.
> +        * The function is passed to kunit_alloc_resource() and automatically
> +        * executes within kunit_release_resource() when the resource's reference
> +        * count, via kunit_put_resource(), drops to zero. KUnit uses reference
> +        * counting to ensure that resources are not freed prematurely.
> +        */
> +       static void example_resource_free(struct kunit_resource *res)
> +       {
> +               kfree(res->data);
> +       }
> +
> +       /*
> +        * This match function is invoked by kunit_find_resource() to locate
> +        * a test resource based on defined criteria. The current example
> +        * uniquely identifies the resource by its free function; however,
> +        * alternative custom criteria can be implemented. Refer to
> +        * lib/kunit/platform.c and lib/kunit/static_stub.c for further examples.
> +        */
> +       static bool example_resource_alloc_match(struct kunit *test,
> +                                                struct kunit_resource *res,
> +                                                void *match_data)
> +       {
> +               return res->data && res->free == example_resource_free;
> +       }
> +
> +       /*
> +        * This is an example of a function that provides a description for each of the
> +        * parameters.
> +       */
> +       static void example_param_array_get_desc(const void *p, char *desc)
> +       {
> +               const struct example_param *param = p;
> +
> +               snprintf(desc, KUNIT_PARAM_DESC_SIZE,
> +                       "example check if %d is less than or equal to 3", param->value);
> +       }
> +
> +       /*
> +        * Initializes the parent kunit struct for parameterized KUnit tests.
> +        * This function enables sharing resources across all parameterized
> +        * tests by adding them to the `parent` kunit test struct. It also supports
> +        * registering either static or dynamic arrays of test parameters.
> +        */
> +       static int example_param_init(struct kunit *test)
> +       {
> +               int ctx = 3; /* Data to be stored. */
> +               int arr_size = ARRAY_SIZE(example_params_array);
> +
> +               /*
> +                * This allocates a struct kunit_resource, sets its data field to
> +                * ctx, and adds it to the kunit struct's resources list. Note that
> +                * this is test managed so we don't need to have a custom exit function
> +                * to free it.
> +                */
> +               void *data = kunit_alloc_resource(test, example_resource_init, example_resource_free,
> +                                                 GFP_KERNEL, &ctx);
> +
> +               if (!data)
> +                       return -ENOMEM;
> +               /* Pass the static param array information to the parent struct kunit. */
> +               kunit_register_params_array(test, example_params_array, arr_size,
> +                                           example_param_array_get_desc);
> +               return 0;
> +       }
> +
> +       /*
> +       * This is an example of a parameterized test that uses shared resources
> +       * available from the struct kunit parent field of the kunit struct.
> +       */
> +       static void example_params_test_with_init(struct kunit *test)
> +       {
> +               int threshold;
> +               struct kunit_resource *res;
> +               const struct example_param *param = test->param_value;
> +
> +               /* By design, param pointer will not be NULL. */
> +               KUNIT_ASSERT_NOT_NULL(test, param);
> +
> +               /* Here we need to access the parent pointer of the test to find the shared resource. */
> +               res = kunit_find_resource(test->parent, example_resource_alloc_match, NULL);
> +
> +               KUNIT_ASSERT_NOT_NULL(test, res);
> +
> +               /* Since the data field in kunit_resource is a void pointer we need to typecast it. */
> +               threshold = *((int *)res->data);
> +
> +               /* Assert that the parameter is less than or equal to a certain threshold. */
> +               KUNIT_ASSERT_LE(test, param->value, threshold);
> +
> +               /* This decreases the reference count after calling kunit_find_resource(). */
> +               kunit_put_resource(res);
> +       }
> +
> +
> +       static struct kunit_case example_tests[] = {
> +               KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init, NULL,
> +                                          example_param_init, NULL),
> +               {}
> +       };
> +

This is a really long example, which already exists in
kunit-example-test.c. Can we either link to it there (and just include
the most critical lines here), or have a smaller, less-complete
example inline here?


> +As an alternative to using the KUnit Resource API for shared resources, you can
> +place them in ``test->parent->priv``. It can store data that needs to persist
> +and be accessible across all executions within a parameterized test series.
> +
> +As stated previously ``param_init`` and ``param_exit`` receive the parent
> +``struct kunit`` instance. So, you can directly use ``test->priv`` within them
> +to manage shared resources. However, from within the test case function, you must
> +navigate up to the parent i.e. use ``test->parent->priv`` to access those same
> +resources.
> +
> +The resources placed in ``test->parent-priv`` will also need to be allocated in
> +memory to persist across the parameterized tests executions. If memory is

Nit: 'parameterized test executions' singular?

> +allocated using the memory allocation APIs provided by KUnit (described more in
> +the section below), you will not need to worry about deallocating them as they
> +will be managed by the parent parameterized test that gets automatically cleaned
> +up upon the end of the parameterized test series.
> +
> +The code below demonstrates example usage of the ``priv`` field for shared
> +resources:
> +
> +.. code-block:: c
> +
> +       /* An example parameter array. */
> +       static const struct example_param {
> +               int value;
> +       } example_params_array[] = {
> +               { .value = 3, },
> +               { .value = 2, },
> +               { .value = 1, },
> +               { .value = 0, },
> +       };
> +
> +       /*
> +        * Initializes the parent kunit struct for parameterized KUnit tests.
> +        * This function enables sharing resources across all parameterized
> +        * tests.
> +        */
> +       static int example_param_init_priv(struct kunit *test)
> +       {
> +               int ctx = 3; /* Data to be stored. */
> +               int arr_size = ARRAY_SIZE(example_params_array);
> +
> +               /*
> +                * Allocate memory using kunit_kzalloc(). Since the `param_init`
> +                * function receives the parent instance of test, this memory
> +                * allocation will be scoped to the lifetime of the whole
> +                * parameterized test series.
> +                */
> +               test->priv = kunit_kzalloc(test, sizeof(int), GFP_KERNEL);
> +
> +               /* Assign the context value to test->priv.*/
> +               *((int *)test->priv) = ctx;
> +
> +               /* Pass the static param array information to the parent struct kunit. */
> +               kunit_register_params_array(test, example_params_array, arr_size, NULL);
> +               return 0;
> +       }
> +
> +       /*
> +       * This is an example of a parameterized test that uses shared resources
> +       * available from the struct kunit parent field of the kunit struct.
> +       */
> +       static void example_params_test_with_init_priv(struct kunit *test)
> +       {
> +               int threshold;
> +               const struct example_param *param = test->param_value;
> +
> +               /* By design, param pointer will not be NULL. */
> +               KUNIT_ASSERT_NOT_NULL(test, param);
> +
> +               /* By design, test->parent will also not be NULL. */
> +               KUNIT_ASSERT_NOT_NULL(test, test->parent);
> +
> +               /* Assert that test->parent->priv has data. */
> +               KUNIT_ASSERT_NOT_NULL(test, test->parent->priv);
> +
> +               /* Here we need to use test->parent->priv to access the shared resource. */
> +               threshold = *(int *)test->parent->priv;
> +
> +               /* Assert that the parameter is less than or equal to a certain threshold. */
> +               KUNIT_ASSERT_LE(test, param->value, threshold);
> +       }
> +
> +
> +       static struct kunit_case example_tests[] = {
> +               KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init_priv, NULL,
> +                                          example_param_init_priv, NULL),
> +               {}
> +       };
> +

Again, this is a little long, but it's not as bad as the others, and
isn't in the example tests, so I'm okay with leaving it. Though maybe
we could get rid of some of the asserts for the purpose of keeping the
documentation focused and readable.


>  Allocating Memory
>  -----------------
>
> --
> 2.50.1.552.g942d659e1b-goog
>

--0000000000005b4deb063b5ebb59
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
jmkLAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFBp5bTxrTm/d
WMmRETO8lNkA4c7fMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBF
tO3/N2l9hTaij/K0xCpLwIlrqpNo0nMAvvG5LPQQjSeHnTh06tWTgsPCOJ65GX+bqWRDwGTu8WTq
c5ihCNOikBs25j82yeLkfdbeN/tzRGUb2RD+8n9I3CnyMSG49U2s0ZdncsrIVFh47KW2TpHTF7R8
N1dri01wPg8hw4u0+XoczR2TiBrBOISKmAlkAi+P9ivT31gSHdbopoL4x0V2Ow9IOp0chrQQUZtP
KBytLhzUzd9wIsE0QMNDbw6jeG8+a4sd17zpXSbBywIGw7sEvPtnBjMaf5ib3kznlOne6tuDVx4y
QFExTCSrP3OTMUkNbpIdgzg2CHQ2aB8i8YsTZ8Q8Q8ztPJ+xDNsqBUeYxILLjTjxQQovToqipB3f
6IMyk+lWCdDS+iCLYZULV1BTHSdwp1NM3t4jZ8TMlV+JzAyRqz4lzSl8ptkFhKBJ7w2tDrZ3BEXB
8ASUByRxeh+pC1Z5/HhqfiWMVPjaWmlRRJVlRk+ObKIv2CblwxMYlo2Mn8rrbEDyfum1RTMW55Z6
Vumvw5QTHe29TYxSiusovM6OD5y0I+4zaIaYDx/AtF0mMOFXb1MDyynf1CDxhtkgnrBUseHSOU2e
MYs7IqzRap5xsgpJS+t7cp/P8fdlCNvsXss9zZa279tKwaxR0U2IzGxRGsWKGxDysn1HT6pqMDGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAUXA7LnOuRz2DvkWTeMc
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgMlPxF0+izsK8o7kKHV/l72mZXhae
ld6iIER2m5x23JswGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
ODAyMDk0NTE2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAKJB0ew8D2koWJTeZP10lr6jNuFBETUTmjJ/w70FaxwA0+iAMgZXg8DrrQ4H7Mhsy
ZqZj+Kt+ztKhImSC/YiHgxVN96KaiDWo04arNHo13K5biQkJALrB+sMWRsKcRsQ6aYaCeIMB3M9N
EfQ8yZpeJFX0KEzOePiQVt2oTduz30fAQuXpB66yIcYC790qDtppQoyLqQpKDvZNo1k0ZTEkCHAy
6wFvOgYYQY1lW7fvloByUTEflbv8GwXvgieTBBxrWhL/tkBhs3r/YjazPKcrhrkXTALDtauiG3nx
TBdIuQurQJUlXEiFSw0SzUm3YGZo78D1dtAey5I8RaTiIqfeow==
--0000000000005b4deb063b5ebb59--

