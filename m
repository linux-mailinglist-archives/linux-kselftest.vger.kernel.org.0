Return-Path: <linux-kselftest+bounces-39098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F981B27E6C
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 12:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5943AEF0F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 10:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ABF30102D;
	Fri, 15 Aug 2025 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BpbvAaW6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71D430100B
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254186; cv=none; b=CdEiihJf1B1lWv4F0dnvLQJu984907XnfkG36Hyw1Mli6A4Xy8GD1d8cb7gEtZiVK+rIUwH+Iy8l8hbYOg3S0EggocpOU08sTmLESacUMld1Sk6fqolsHvvqa1LccAX8U2R7BS2NHyNYGxy16e2V2XuDwE9d2+vDsoav1/R5TLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254186; c=relaxed/simple;
	bh=y/T3DmcVT74O6iwGf31QFTMGNpni6MOPhIo+k/vGZkg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MOJg86UZ/OT4s+LiUmQ10v1bClWjU4R+0Rtv93B4EvoLsehE36BGV9P4bucq32gdkJJkKZSoslroUy4dlj7U0ZAfpx5uZ0R/aZABB+4myWduFd/V0LX4mxUbibuvQ7NVOqFNSSftOaDqjcyRpV+WJajfZPeI4ORR8xN7l5SXK78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BpbvAaW6; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-70a9f534976so56538616d6.2
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 03:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755254184; x=1755858984; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N5BvlszSrzL55yCb3EusIjjVMhIlB9YqkU/uZs3QISs=;
        b=BpbvAaW6Of0aNAJygv2xM+4PEqR6A71UC2EwecnYwfiP8O6cS/cXMPrZM80VtFwBY1
         y90hESSlkF+AePaWDEDcUtD9HqV8PigIZti9Va5ncjblAOzIegEu5wpzzxj/IdoV/74A
         MYucU/vRZhD7GRN3DHKpc384/YQgnKEZLi+6uSnuWftjkIJuQnKKmQLxMyhBQBy2NYzH
         k44D/6T9w5mT1lrB0moqjWeuPeLw8+5SY3Q1HkSIH/8UV4+AYnHo/HodsJY4MAn7UFrE
         wQVavskV/5F4Vj+11C+LAz2IwxMW2RoW8UqBASu1NamW/snB8kV+QYYQHNo/TeaMVbs7
         xfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755254184; x=1755858984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N5BvlszSrzL55yCb3EusIjjVMhIlB9YqkU/uZs3QISs=;
        b=by5sqB7qJNFixpx+ljWQqR20/5QhN/ooerHlYSyCnPRmLOikPkp6lIR5iie4z/WhRT
         Jrm8A+ue7eg1uRLP2MrWOu820HWBJkuT7IbSxrCkIuAmRgkdzMv72hpZuvnOsO2LW9YF
         QWxkQwAcK0t2R5dmHwkTZYFSjQoQU/8McuArwwijbihvC1vW+MvIV4zSNW1gWDq3O8mk
         QlNOS2zWU+WFpjzkjLxjRPQ1PeJ5mIu8MHbcstyJdbt5z0QqV+yO0IFF0ZPvgtPXwUmw
         yr+hCxmjQ8GZ+W1ywGb2N6nFhV96O7gfYvM5J5u/OJrWbeP7UzsGmRm0yFNyelm5+p3F
         9mzA==
X-Forwarded-Encrypted: i=1; AJvYcCUeSI3orWeEXkwlYZzWJD+HX01QVZvLm1rj771VLSiybZIfsG7BMrKIF1d75FUW3P1D6R2QbzaY2WZAgz+hJCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkLMILNz89Cdqqx1+enONnGKT6F8OfdyqZxbjw08+H3Y0wHayt
	tM3GBk++fxfVu0wWAapQ9+GbhCkUw4NZpu7EnyS82BmOT4kfmzzg+E5/LwklqrVcdcEv5y50nqF
	kF8lLQxJfjkobcQ==
X-Google-Smtp-Source: AGHT+IGnnHUHbdjLOOep4HUpewOyAiINeFc8kVXHQi8CqQJ4jl62kvVZarAxkLdpSI1LuPZggZfoYq5jLJl6Ew==
X-Received: from qvbfo14.prod.google.com ([2002:ad4:5f0e:0:b0:709:b8bf:588f])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:1c85:b0:709:e492:e0da with SMTP id 6a1803df08f44-70ba7cb68c6mr14801986d6.49.1755254183707;
 Fri, 15 Aug 2025 03:36:23 -0700 (PDT)
Date: Fri, 15 Aug 2025 10:36:03 +0000
In-Reply-To: <20250815103604.3857930-1-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815103604.3857930-1-marievic@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250815103604.3857930-7-marievic@google.com>
Subject: [PATCH v3 6/7] kunit: Add example parameterized test with direct
 dynamic parameter array setup
From: Marie Zhussupova <marievic@google.com>
To: rmoar@google.com, davidgow@google.com, shuah@kernel.org, 
	brendan.higgins@linux.dev
Cc: mark.rutland@arm.com, elver@google.com, dvyukov@google.com, 
	lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com, 
	rodrigo.vivi@intel.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, kasan-dev@googlegroups.com, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Marie Zhussupova <marievic@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce example_params_test_with_init_dynamic_arr(). This new
KUnit test demonstrates directly assigning a dynamic parameter
array, using the kunit_register_params_array() macro, to a
parameterized test context.

It highlights the use of param_init() and param_exit() for
initialization and exit of a parameterized test, and their
registration to the test case with KUNIT_CASE_PARAM_WITH_INIT().

Reviewed-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Marie Zhussupova <marievic@google.com>
---
Changes in v3:
v2: https://lore.kernel.org/all/20250811221739.2694336-7-marievic@google.com/
- No changes.

Changes in v2:
v1: https://lore.kernel.org/all/20250729193647.3410634-9-marievic@google.com/
- kunit_array_gen_params() is now explicitly passed to
  KUNIT_CASE_PARAM_WITH_INIT() to be consistent with the parameterized test
  being defined by the existence of the generate_params() function.
- param_init() was changed to output a log at the start of a parameterized
  test.
- The parameter array was changed to be allocated using kunit_kmalloc_array(),
  a KUnit memory allocation API, as that would be the preferred/easier method.
  To still demonstrate a use of param_exit(), it now outputs a log at the end
  of the parameterized test.
- The comments and the commit message were changed to reflect the
  parameterized testing terminology. See the patch series cover letter
  change log for the definitions.

---
 lib/kunit/kunit-example-test.c | 104 +++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 3e858367be01..9452b163956f 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -388,6 +388,107 @@ static void example_params_test_with_init(struct kunit *test)
 	kunit_put_resource(res);
 }
 
+/*
+ * Helper function to create a parameter array of Fibonacci numbers. This example
+ * highlights a parameter generation scenario that is:
+ * 1. Not feasible to fully pre-generate at compile time.
+ * 2. Challenging to implement with a standard generate_params() function,
+ * as it only provides the previous parameter, while Fibonacci requires
+ * access to two preceding values for calculation.
+ */
+static void *make_fibonacci_params(struct kunit *test, size_t seq_size)
+{
+	int *seq;
+
+	if (seq_size <= 0)
+		return NULL;
+	/*
+	 * Using kunit_kmalloc_array here ties the lifetime of the array to
+	 * the parameterized test i.e. it will get automatically cleaned up
+	 * by KUnit after the parameterized test finishes.
+	 */
+	seq = kunit_kmalloc_array(test, seq_size, sizeof(int), GFP_KERNEL);
+
+	if (!seq)
+		return NULL;
+	if (seq_size >= 1)
+		seq[0] = 0;
+	if (seq_size >= 2)
+		seq[1] = 1;
+	for (int i = 2; i < seq_size; i++)
+		seq[i] = seq[i - 1] + seq[i - 2];
+	return seq;
+}
+
+/*
+ * This is an example of a function that provides a description for each of the
+ * parameters.
+ */
+static void example_param_dynamic_arr_get_desc(struct kunit *test, const void *p, char *desc)
+{
+	const int *fib_num = p;
+
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "fibonacci param: %d", *fib_num);
+}
+
+/*
+ * Example of a parameterized test param_init() function that registers a dynamic
+ * array of parameters.
+ */
+static int example_param_init_dynamic_arr(struct kunit *test)
+{
+	size_t seq_size;
+	int *fibonacci_params;
+
+	kunit_info(test, "initializing parameterized test\n");
+
+	seq_size = 6;
+	fibonacci_params = make_fibonacci_params(test, seq_size);
+
+	if (!fibonacci_params)
+		return -ENOMEM;
+
+	/*
+	 * Passes the dynamic parameter array information to the parameterized test
+	 * context struct kunit. The array and its metadata will be stored in
+	 * test->parent->params_array. The array itself will be located in
+	 * params_data.params.
+	 *
+	 * Note that you will need to pass kunit_array_gen_params() as the
+	 * generator function to KUNIT_CASE_PARAM_WITH_INIT() when registering
+	 * a parameter array this route.
+	 */
+	kunit_register_params_array(test, fibonacci_params, seq_size,
+				    example_param_dynamic_arr_get_desc);
+	return 0;
+}
+
+/*
+ * Example of a parameterized test param_exit() function that outputs a log
+ * at the end of the parameterized test. It could also be used for any other
+ * teardown logic.
+ */
+static void example_param_exit_dynamic_arr(struct kunit *test)
+{
+	kunit_info(test, "exiting parameterized test\n");
+}
+
+/*
+ * Example of test that uses the registered dynamic array to perform assertions
+ * and expectations.
+ */
+static void example_params_test_with_init_dynamic_arr(struct kunit *test)
+{
+	const int *param = test->param_value;
+	int param_val;
+
+	/* By design, param pointer will not be NULL. */
+	KUNIT_ASSERT_NOT_NULL(test, param);
+
+	param_val = *param;
+	KUNIT_EXPECT_EQ(test, param_val - param_val, 0);
+}
+
 /*
  * Here we make a list of all the test cases we want to add to the test suite
  * below.
@@ -409,6 +510,9 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE_PARAM(example_params_test, example_gen_params),
 	KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init, kunit_array_gen_params,
 				   example_param_init, NULL),
+	KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init_dynamic_arr,
+				   kunit_array_gen_params, example_param_init_dynamic_arr,
+				   example_param_exit_dynamic_arr),
 	KUNIT_CASE_SLOW(example_slow_test),
 	{}
 };
-- 
2.51.0.rc1.167.g924127e9c0-goog


