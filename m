Return-Path: <linux-kselftest+bounces-38062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE82B153AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 21:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E284E48CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 19:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD4A29AAEF;
	Tue, 29 Jul 2025 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ajeWjeON"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CEB29A333
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817860; cv=none; b=pZqTlJ9rJJYdNGyN46oYYlJ/wxqoKbnI6w5wITUisnJNtJL7Jr92Zd8vgeVKGeV4G1ZgPvKpq6CiV08H6UdpxXKCJ/sPjYACcCTB7FJUXWmytwwhIhyS9jmqOWKdfn9NBV03phoZT/5dVcfCCPFjY/Hr2+ivQJKHxczjEGT4L90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817860; c=relaxed/simple;
	bh=LXJOlvb6igzycuspSO7SZz7odY5+L0/pVSqsKpemU4E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V4SJuCtrXqHO3/cLHOCBSyK5EENHrPiryi9hl0mTPFVEyZR41V1hrP2wMNXASoxeEI7irkA84XkAqIWTizLETIwyI/INCGdrHnP8ib/6kKkqQC6HAR4D0aelaE56njMwQoqYOUk37cEY9TNnhmr5l4bsQN+ACtFlGen1uExc67w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ajeWjeON; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7e347b1a6c7so1605852885a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 12:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753817857; x=1754422657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FE6RrLniApVoy+rkPyhu2vo0lMS/eDyyytX43V/mIbA=;
        b=ajeWjeONmf5rldtx9j1dLGvejP1aJ33gZvCdmpbnc6GRrsGCoF01oPkfS1aBZMq70l
         nArAG8f06CN6mi+EzV3NGqZJ4d/DilSUx41ZniHRH3NFIpaZCXYHoeQNqyawZJSEVR/n
         C5n+x4bGXNhj+GuCvEQqxfad5gAlNUzvbpPdd0F2jbuxsKhv/9F4onqQ0DEdgbc8bQFH
         tf5S63THR8E58x1kr/UrokexU1BTX+08nTbZq2SxZ5X9OjUpif8umqbGIFb6lmf7/E13
         NJUtz/Cm8W9/wWCmuZ90iMMs/BCUqihItAtiWat51UBTR3ntIX8KFoGMJq+eRdg5tesm
         3m5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753817857; x=1754422657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FE6RrLniApVoy+rkPyhu2vo0lMS/eDyyytX43V/mIbA=;
        b=vvee/U7y/42NR8gmpm/BLaku5JczMenhbe9jGT9NG98MavJhiA60mI10OCltv4pA+e
         KbeDuwqOGnBN/gBJ/Y+Wcvfw+/73qzlZGCly4yPS1FfzBwd9NVZ+zNA++LBPpDn/xZlE
         Zh/PMLSrCJ36un1CoWnIcXjjtFJ6Wmu9uxEet+ToWkziue6OWSVqQp41HLoBuTklrn0t
         QH//OWAsOgwWMk8ejYb/lwd2pQ5w+ymXIMJgEBnLzN4zZEPNPG8ZtlDVBBsXZ1zDEC+D
         HXmw6XyjCYYoMp7xiRimnhfH71OaYYpgFvkFyKpvyZneqCfkaZrE4Y29wHqZMYzCiuAj
         w0FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKzUjJofeXb6tgta3bUWJCo7zbk0xzz/ejqU0R/y4fcDWZO71T+afzR0SE/mnK69ISaT6Sm8HcVD0hmVM65hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0CI7OIrsONhBQBXsryLTlp7cAZQeDhndt4bQ7V4RNNtWRHRHs
	DwoQNoRNsADE5Et87+bD06TvxK4ZA8KJ19gVl4zPM1NhQwUlGe5xD9ct4fnXyGmW5D+LtwOZ8Ej
	MiMy7Npu9tzLvPA==
X-Google-Smtp-Source: AGHT+IHB6L31bYPvSDyOuUS6Al2JnpqlQO4bq0MnGQnEM5DWajE1kJzMUOLB0840H1GvnZCA2Qw3bfQMvheaCA==
X-Received: from qktt8.prod.google.com ([2002:a05:620a:48:b0:7e3:512b:f2b4])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3951:b0:7e0:c0a0:c68b with SMTP id af79cd13be357-7e66ef716bamr109499885a.10.1753817857244;
 Tue, 29 Jul 2025 12:37:37 -0700 (PDT)
Date: Tue, 29 Jul 2025 19:36:47 +0000
In-Reply-To: <20250729193647.3410634-1-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729193647.3410634-10-marievic@google.com>
Subject: [PATCH 9/9] Documentation: kunit: Document new parameterized test features
From: Marie Zhussupova <marievic@google.com>
To: rmoar@google.com, davidgow@google.com, shuah@kernel.org, 
	brendan.higgins@linux.dev
Cc: elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Marie Zhussupova <marievic@google.com>
Content-Type: text/plain; charset="UTF-8"

-Update the KUnit documentation to explain the concept
of a parent parameterized test.
-Add examples demonstrating different ways of passing
parameters to parameterized tests and how to manage
shared resources between them.

Signed-off-by: Marie Zhussupova <marievic@google.com>
---
 Documentation/dev-tools/kunit/usage.rst | 455 +++++++++++++++++++++++-
 1 file changed, 449 insertions(+), 6 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 066ecda1dd98..be1d656053cf 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -542,11 +542,21 @@ There is more boilerplate code involved, but it can:
 Parameterized Testing
 ~~~~~~~~~~~~~~~~~~~~~
 
-The table-driven testing pattern is common enough that KUnit has special
-support for it.
-
-By reusing the same ``cases`` array from above, we can write the test as a
-"parameterized test" with the following.
+To efficiently and elegantly validate a test case against a variety of inputs,
+KUnit also provides a parameterized testing framework. This feature formalizes
+and extends the concept of table-driven tests discussed previously, offering
+a more integrated and flexible way to handle multiple test scenarios with
+minimal code duplication.
+
+Passing Parameters to the Test Cases
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+There are three main ways to provide the parameters to a test case:
+
+Array Parameter Macros (``KUNIT_ARRAY_PARAM`` or ``KUNIT_ARRAY_PARAM_DESC``):
+   KUnit provides special support for the common table-driven testing pattern.
+   By applying either ``KUNIT_ARRAY_PARAM`` or ``KUNIT_ARRAY_PARAM_DESC`` to the
+   ``cases`` array from the previous section, we can create a parameterized test
+   as shown below:
 
 .. code-block:: c
 
@@ -555,7 +565,7 @@ By reusing the same ``cases`` array from above, we can write the test as a
 		const char *str;
 		const char *sha1;
 	};
-	const struct sha1_test_case cases[] = {
+	static const struct sha1_test_case cases[] = {
 		{
 			.str = "hello world",
 			.sha1 = "2aae6c35c94fcfb415dbe95f408b9ce91ee846ed",
@@ -590,6 +600,439 @@ By reusing the same ``cases`` array from above, we can write the test as a
 		{}
 	};
 
+Custom Parameter Generator (``generate_params``):
+   You can pass your own ``generate_params`` function to the ``KUNIT_CASE_PARAM``
+   or ``KUNIT_CASE_PARAM_WITH_INIT`` macros. This function is responsible for
+   generating parameters one by one. It receives the previously generated parameter
+   as the ``prev`` argument (which is ``NULL`` on the first call) and can also
+   access any context available from the parent ``struct kunit`` passed as the
+   ``test`` argument. KUnit calls this function repeatedly until it returns
+   ``NULL``. Below is an example of how it works:
+
+.. code-block:: c
+
+	#define MAX_TEST_BUFFER_SIZE 8
+
+	// Example generator function. It produces a sequence of buffer sizes that
+	// are powers of two, starting at 1 (e.g., 1, 2, 4, 8).
+	static const void *buffer_size_gen_params(struct kunit *test, const void *prev, char *desc)
+	{
+		long prev_buffer_size = (long)prev;
+		long next_buffer_size = 1; // Start with an initial size of 1.
+
+		// Stop generating parameters if the limit is reached or exceeded.
+		if (prev_buffer_size >= MAX_TEST_BUFFER_SIZE)
+			return NULL;
+
+		// For subsequent calls, calculate the next size by doubling the previous one.
+		if (prev)
+			next_buffer_size = prev_buffer_size << 1;
+
+		return (void *)next_buffer_size;
+	}
+
+	// Simple test to validate that kunit_kzalloc provides zeroed memory.
+	static void buffer_zero_test(struct kunit *test)
+	{
+		long buffer_size = (long)test->param_value;
+		// Use kunit_kzalloc to allocate a zero-initialized buffer. This makes the
+		// memory "parameter managed," meaning it's automatically cleaned up at
+		// the end of each parameter execution.
+		int *buf = kunit_kzalloc(test, buffer_size * sizeof(int), GFP_KERNEL);
+
+		// Ensure the allocation was successful.
+		KUNIT_ASSERT_NOT_NULL(test, buf);
+
+		// Loop through the buffer and confirm every element is zero.
+		for (int i = 0; i < buffer_size; i++)
+			KUNIT_EXPECT_EQ(test, buf[i], 0);
+	}
+
+	static struct kunit_case buffer_test_cases[] = {
+		KUNIT_CASE_PARAM(buffer_zero_test, buffer_size_gen_params),
+		{}
+	};
+
+Direct Registration in Parameter Init Function (using ``kunit_register_params_array``):
+   For more complex scenarios, you can directly register a parameter array with
+   a test case instead of using a ``generate_params`` function. This is done by
+   passing the array to the ``kunit_register_params_array`` macro within an
+   initialization function for the parameterized test series
+   (i.e., a function named ``param_init``). To better understand this mechanism
+   please refer to the "Adding Shared Resources" section below.
+
+   This method supports both dynamically built and static arrays.
+
+   As the following code shows, the ``example_param_init_dynamic_arr`` function
+   utilizes ``make_fibonacci_params`` to create a dynamic array, which is then
+   registered using ``kunit_register_params_array``. The corresponding exit
+   function, ``example_param_exit``, is responsible for freeing this dynamically
+   allocated params array after the parameterized test series ends.
+
+.. code-block:: c
+
+	/*
+	 * Helper function to create a parameter array of Fibonacci numbers. This example
+	 * highlights a parameter generation scenario that is:
+	 * 1. Not feasible to fully pre-generate at compile time.
+	 * 2. Challenging to implement with a standard 'generate_params' function,
+	 * as it typically only provides the immediately 'prev' parameter, while
+	 * Fibonacci requires access to two preceding values for calculation.
+	 */
+	static void *make_fibonacci_params(int seq_size)
+	{
+		int *seq;
+
+		if (seq_size <= 0)
+			return NULL;
+
+		seq = kmalloc_array(seq_size, sizeof(int), GFP_KERNEL);
+
+		if (!seq)
+			return NULL;
+
+		if (seq_size >= 1)
+			seq[0] = 0;
+		if (seq_size >= 2)
+			seq[1] = 1;
+		for (int i = 2; i < seq_size; i++)
+			seq[i] = seq[i - 1] + seq[i - 2];
+		return seq;
+	}
+
+	// This is an example of a function that provides a description for each of the
+	// parameters.
+	static void example_param_dynamic_arr_get_desc(const void *p, char *desc)
+	{
+		const int *fib_num = p;
+
+		snprintf(desc, KUNIT_PARAM_DESC_SIZE, "fibonacci param: %d", *fib_num);
+	}
+
+	// Example of a parameterized test init function that registers a dynamic array.
+	static int example_param_init_dynamic_arr(struct kunit *test)
+	{
+		int seq_size = 6;
+		int *fibonacci_params = make_fibonacci_params(seq_size);
+
+		if (!fibonacci_params)
+			return -ENOMEM;
+
+		/*
+		 * Passes the dynamic parameter array information to the parent struct kunit.
+		 * The array and its metadata will be stored in test->parent->params_data.
+		 * The array itself will be located in params_data.params.
+		 */
+		kunit_register_params_array(test, fibonacci_params, seq_size,
+					    example_param_dynamic_arr_get_desc);
+		return 0;
+	}
+
+	// Function to clean up the parameterized test's parent kunit struct if
+	// there were custom allocations.
+	static void example_param_exit_dynamic_arr(struct kunit *test)
+	{
+		/*
+		 * We allocated this array, so we need to free it.
+		 * Since the parent parameter instance is passed here,
+		 * we can directly access the array via `test->params_data.params`
+		 * instead of `test->parent->params_data.params`.
+		 */
+		kfree(test->params_data.params);
+	}
+
+	/*
+	 * Example of test that uses the registered dynamic array to perform assertions
+	 * and expectations.
+	 */
+	static void example_params_test_with_init_dynamic_arr(struct kunit *test)
+	{
+		const int *param = test->param_value;
+		int param_val;
+
+		/* By design, param pointer will not be NULL. */
+		KUNIT_ASSERT_NOT_NULL(test, param);
+
+		param_val = *param;
+		KUNIT_EXPECT_EQ(test, param_val - param_val, 0);
+	}
+
+	static struct kunit_case example_tests[] = {
+		// The NULL here stands in for the generate_params function
+		KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init_dynamic_arr, NULL,
+					   example_param_init_dynamic_arr,
+					   example_param_exit_dynamic_arr),
+		{}
+	};
+
+
+Adding Shared Resources
+^^^^^^^^^^^^^^^^^^^^^^^
+All parameterized test executions in this framework have a parent test of type
+``struct kunit``. This parent is not used to execute any test logic itself;
+instead, it serves as a container for shared context that can be accessed by
+all its individual test executions (or parameters). Therefore, each individual
+test execution holds a pointer to this parent, accessible via a field named
+``parent``.
+
+It's possible to add resources to share between the individual test executions
+within a parameterized test series by using the ``KUNIT_CASE_PARAM_WITH_INIT``
+macro, to which you pass custom ``param_init`` and ``param_exit`` functions.
+These functions run once before and once after the entire parameterized test
+series, respectively. The ``param_init`` function can be used for adding any
+resources to the resources field of a parent test and also provide an additional
+way of setting the parameter array. The ``param_exit`` function can be used
+release any resources that were not test managed i.e. not automatically cleaned
+up after the test ends.
+
+.. note::
+   If both a ``generate_params`` function is passed to ``KUNIT_CASE_PARAM_WITH_INIT``
+   and an array is registered via ``kunit_register_params_array`` in
+   ``param_init``, the ``generate_params`` function will be used to get
+   the parameters.
+
+Both ``param_init`` and ``param_exit`` are passed the parent instance of a test
+(parent ``struct kunit``) behind the scenes. However, the test case function
+receives the individual instance of a test for each parameter. Therefore, to
+manage and access shared resources from within a test case function, you must use
+``test->parent``.
+
+.. note::
+   The ``suite->init()`` function, which runs before each parameter execution,
+   receives the individual instance of a test for each parameter. Therefore,
+   resources set up in ``suite->init()`` are reset for each individual
+   parameterized test execution and are only visible within that specific test.
+
+For instance, finding a shared resource allocated by the Resource API requires
+passing ``test->parent`` to ``kunit_find_resource()``. This principle extends to
+all other APIs that might be used in the test case function, including
+``kunit_kzalloc()``, ``kunit_kmalloc_array()``, and others (see
+Documentation/dev-tools/kunit/api/test.rst and the
+Documentation/dev-tools/kunit/api/resource.rst).
+
+The code below shows how you can add the shared resources. Note that this code
+utilizes the Resource API, which you can read more about here:
+Documentation/dev-tools/kunit/api/resource.rst.
+
+.. code-block:: c
+
+	/* An example parameter array. */
+	static const struct example_param {
+		int value;
+	} example_params_array[] = {
+		{ .value = 3, },
+		{ .value = 2, },
+		{ .value = 1, },
+		{ .value = 0, },
+	};
+
+	/*
+	 * This custom function allocates memory for the kunit_resource data field.
+	 * The function is passed to kunit_alloc_resource() and executed once
+	 * by the internal helper __kunit_add_resource().
+	 */
+	static int example_resource_init(struct kunit_resource *res, void *context)
+	{
+		int *info = kmalloc(sizeof(*info), GFP_KERNEL);
+
+		if (!info)
+			return -ENOMEM;
+		*info = *(int *)context;
+		res->data = info;
+		return 0;
+	}
+
+	/*
+	 * This function deallocates memory for the 'kunit_resource' data field.
+	 * The function is passed to kunit_alloc_resource() and automatically
+	 * executes within kunit_release_resource() when the resource's reference
+	 * count, via kunit_put_resource(), drops to zero. KUnit uses reference
+	 * counting to ensure that resources are not freed prematurely.
+	 */
+	static void example_resource_free(struct kunit_resource *res)
+	{
+		kfree(res->data);
+	}
+
+	/*
+	 * This match function is invoked by kunit_find_resource() to locate
+	 * a test resource based on defined criteria. The current example
+	 * uniquely identifies the resource by its free function; however,
+	 * alternative custom criteria can be implemented. Refer to
+	 * lib/kunit/platform.c and lib/kunit/static_stub.c for further examples.
+	 */
+	static bool example_resource_alloc_match(struct kunit *test,
+						 struct kunit_resource *res,
+						 void *match_data)
+	{
+		return res->data && res->free == example_resource_free;
+	}
+
+	/*
+	 * This is an example of a function that provides a description for each of the
+	 * parameters.
+	*/
+	static void example_param_array_get_desc(const void *p, char *desc)
+	{
+		const struct example_param *param = p;
+
+		snprintf(desc, KUNIT_PARAM_DESC_SIZE,
+			"example check if %d is less than or equal to 3", param->value);
+	}
+
+	/*
+	 * Initializes the parent kunit struct for parameterized KUnit tests.
+	 * This function enables sharing resources across all parameterized
+	 * tests by adding them to the `parent` kunit test struct. It also supports
+	 * registering either static or dynamic arrays of test parameters.
+	 */
+	static int example_param_init(struct kunit *test)
+	{
+		int ctx = 3; /* Data to be stored. */
+		int arr_size = ARRAY_SIZE(example_params_array);
+
+		/*
+		 * This allocates a struct kunit_resource, sets its data field to
+		 * ctx, and adds it to the kunit struct's resources list. Note that
+		 * this is test managed so we don't need to have a custom exit function
+		 * to free it.
+		 */
+		void *data = kunit_alloc_resource(test, example_resource_init, example_resource_free,
+						  GFP_KERNEL, &ctx);
+
+		if (!data)
+			return -ENOMEM;
+		/* Pass the static param array information to the parent struct kunit. */
+		kunit_register_params_array(test, example_params_array, arr_size,
+					    example_param_array_get_desc);
+		return 0;
+	}
+
+	/*
+	* This is an example of a parameterized test that uses shared resources
+	* available from the struct kunit parent field of the kunit struct.
+	*/
+	static void example_params_test_with_init(struct kunit *test)
+	{
+		int threshold;
+		struct kunit_resource *res;
+		const struct example_param *param = test->param_value;
+
+		/* By design, param pointer will not be NULL. */
+		KUNIT_ASSERT_NOT_NULL(test, param);
+
+		/* Here we need to access the parent pointer of the test to find the shared resource. */
+		res = kunit_find_resource(test->parent, example_resource_alloc_match, NULL);
+
+		KUNIT_ASSERT_NOT_NULL(test, res);
+
+		/* Since the data field in kunit_resource is a void pointer we need to typecast it. */
+		threshold = *((int *)res->data);
+
+		/* Assert that the parameter is less than or equal to a certain threshold. */
+		KUNIT_ASSERT_LE(test, param->value, threshold);
+
+		/* This decreases the reference count after calling kunit_find_resource(). */
+		kunit_put_resource(res);
+	}
+
+
+	static struct kunit_case example_tests[] = {
+		KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init, NULL,
+					   example_param_init, NULL),
+		{}
+	};
+
+As an alternative to using the KUnit Resource API for shared resources, you can
+place them in ``test->parent->priv``. It can store data that needs to persist
+and be accessible across all executions within a parameterized test series.
+
+As stated previously ``param_init`` and ``param_exit`` receive the parent
+``struct kunit`` instance. So, you can directly use ``test->priv`` within them
+to manage shared resources. However, from within the test case function, you must
+navigate up to the parent i.e. use ``test->parent->priv`` to access those same
+resources.
+
+The resources placed in ``test->parent-priv`` will also need to be allocated in
+memory to persist across the parameterized tests executions. If memory is
+allocated using the memory allocation APIs provided by KUnit (described more in
+the section below), you will not need to worry about deallocating them as they
+will be managed by the parent parameterized test that gets automatically cleaned
+up upon the end of the parameterized test series.
+
+The code below demonstrates example usage of the ``priv`` field for shared
+resources:
+
+.. code-block:: c
+
+	/* An example parameter array. */
+	static const struct example_param {
+		int value;
+	} example_params_array[] = {
+		{ .value = 3, },
+		{ .value = 2, },
+		{ .value = 1, },
+		{ .value = 0, },
+	};
+
+	/*
+	 * Initializes the parent kunit struct for parameterized KUnit tests.
+	 * This function enables sharing resources across all parameterized
+	 * tests.
+	 */
+	static int example_param_init_priv(struct kunit *test)
+	{
+		int ctx = 3; /* Data to be stored. */
+		int arr_size = ARRAY_SIZE(example_params_array);
+
+		/*
+		 * Allocate memory using kunit_kzalloc(). Since the `param_init`
+		 * function receives the parent instance of test, this memory
+		 * allocation will be scoped to the lifetime of the whole
+		 * parameterized test series.
+		 */
+		test->priv = kunit_kzalloc(test, sizeof(int), GFP_KERNEL);
+
+		/* Assign the context value to test->priv.*/
+		*((int *)test->priv) = ctx;
+
+		/* Pass the static param array information to the parent struct kunit. */
+		kunit_register_params_array(test, example_params_array, arr_size, NULL);
+		return 0;
+	}
+
+	/*
+	* This is an example of a parameterized test that uses shared resources
+	* available from the struct kunit parent field of the kunit struct.
+	*/
+	static void example_params_test_with_init_priv(struct kunit *test)
+	{
+		int threshold;
+		const struct example_param *param = test->param_value;
+
+		/* By design, param pointer will not be NULL. */
+		KUNIT_ASSERT_NOT_NULL(test, param);
+
+		/* By design, test->parent will also not be NULL. */
+		KUNIT_ASSERT_NOT_NULL(test, test->parent);
+
+		/* Assert that test->parent->priv has data. */
+		KUNIT_ASSERT_NOT_NULL(test, test->parent->priv);
+
+		/* Here we need to use test->parent->priv to access the shared resource. */
+		threshold = *(int *)test->parent->priv;
+
+		/* Assert that the parameter is less than or equal to a certain threshold. */
+		KUNIT_ASSERT_LE(test, param->value, threshold);
+	}
+
+
+	static struct kunit_case example_tests[] = {
+		KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init_priv, NULL,
+					   example_param_init_priv, NULL),
+		{}
+	};
+
 Allocating Memory
 -----------------
 
-- 
2.50.1.552.g942d659e1b-goog


