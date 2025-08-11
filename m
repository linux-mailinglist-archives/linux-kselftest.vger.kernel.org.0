Return-Path: <linux-kselftest+bounces-38723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7C4B2183D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 00:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E624018826B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 22:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4A92E5B32;
	Mon, 11 Aug 2025 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1IbGkWf0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10DD2E541D
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 22:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950698; cv=none; b=gcfxC96f8b02Spt7Y6uKGg6/54qNSfdlZ+T6RYbmjdk/yrevwA5nof1usCcttr6K8fi5Fv0EKABskOjy3vxcgYv4n1/dl39Mp1PcgfK+bCiCyL8HjkA9k+3Ej5oqX7/lQrRrIsoMPJoIUOW5LsT74d1AOeJl9hIN/pc5Mte0Z+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950698; c=relaxed/simple;
	bh=xotFazglW4QKAllikP7NgT4h2bFNJrvliBZUW+G3o6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eRcTSyFMX9eCLI1Z8HUtlex0d4/j1ST0/teDlTshDGhQBl4g/iBFEFDv2yfvYrMMlmUvOTGjeqeMGdYlK/yoimpW5ATfwqVx6vguv/krZQEFkh2/KktDNZT1qgBKUlnV7qyBmS/uxF2fFoWwxvm0Nk8R40CkGr7k98vuXhFBbtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1IbGkWf0; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7e82b4ed799so824437285a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 15:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754950694; x=1755555494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fiy0G3ZehM6qHvT1KaF1SbtcEnbY2+UsDdYSolHQCqU=;
        b=1IbGkWf0yexJHRr8mCbGGdxpaicNeCS5Lx3d9XvA5ce65aZk7tAEhNJ84MXNK+DVqc
         ymi9CWAxzf/6fY53glUXUK5G6B18WaqkpaTbqkOEOXuR6hEipKN5a0NIq3lr4mm/1VvH
         Kdob2XYx4xl8HoqDUYkfImhuO+oaleyW28qgabVp44pdJE5ok7Ad7pa02L7t59wPvlCc
         mCMXqCw9fLpRHwtZE9ifQsbO4W2Qg7ySXXv8SZQ3oiCniRJ8Vj6eNgfBAM5NUtAJItJy
         NqEXYjuLVOU2tLZh5bkkH8121zANBntPqKm0nWRVv8ls/sTr4/1rNFar5PtLt8nCZrgK
         mCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950694; x=1755555494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fiy0G3ZehM6qHvT1KaF1SbtcEnbY2+UsDdYSolHQCqU=;
        b=sxtyGoAUcL0JzLl4r5zVRbGLoGH5YYoxb05DSPoh3fTOKM+HQqiJrwbZ8f/dtCRfnB
         95zy/t0wK0su2zKwMGeOpt5Kl6a6rouHwLpcbyI0OwB9pCf+Cz8Nr4Dhm2uGxqOVSRw1
         0QfVUqJ8J3m3vC68uSvWE8E8V286eKs0HFBKKy1puezvCl22XAtAbIfgYjB3/87WCgUV
         ODyCqFlHJkX/PmlfULL0ASP5RovIHkEUGv3j51eAe5V4ymoB0XDb42LEzFUhJipqpSUU
         uwnoZfh/UI2bfb6EVQMSYMSNpfMxVIp6wPVCW/kYx9bL8ek7KVXufVsNidn0CNITmQBG
         x/sg==
X-Forwarded-Encrypted: i=1; AJvYcCURAopl0sTYbR7hkqOsyouneOCI6U1lf4GFa6OjkmqazbfxYMyq64puG3qRnWwrM5xe8vNOSRBdSLpjnNXzm2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOvVQPglg6xRd3XuJfqWcboailI9NW/+OyrFnzYnc6YLVLFkoJ
	dnQN6HzjBKI0qjnMwVoqqIMYb0w8RnHRU+Awk4Zrnq4maR6y6/Pzqy+bYJfDwRXnyRgYml9qnri
	9mbUntjmiVmbiYA==
X-Google-Smtp-Source: AGHT+IHiNfk6fX5vRQ6hJy5J/5HwxIhWCyztR6zBKRqfQIjnxBt+D4xN40wqn6DYxZVe/XPYIWNPVGfdUOAjOQ==
X-Received: from qknwc5.prod.google.com ([2002:a05:620a:7205:b0:7e8:51a1:6a28])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4843:b0:7e8:1718:daf4 with SMTP id af79cd13be357-7e82c65c638mr1611302285a.16.1754950694498;
 Mon, 11 Aug 2025 15:18:14 -0700 (PDT)
Date: Mon, 11 Aug 2025 22:17:38 +0000
In-Reply-To: <20250811221739.2694336-1-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811221739.2694336-1-marievic@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250811221739.2694336-7-marievic@google.com>
Subject: [PATCH v2 6/7] kunit: Add example parameterized test with direct
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

Signed-off-by: Marie Zhussupova <marievic@google.com>
---

Changes in v2:

- kunit_array_gen_params() is now explicitly passed to
  KUNIT_CASE_PARAM_WITH_INIT() to be consistent with
  the parameterized test being defined by the existence
  of the generate_params() function.
- param_init() was changed to output a log at the start
  of a parameterized test.
- The parameter array was changed to be allocated
  using kunit_kmalloc_array(), a KUnit memory allocation
  API, as that would be the preferred/easier method. To
  still demonstrate a use of param_exit(), it now outputs
  a log at the end of the parameterized test.
- The comments and the commit message were changed to
  reflect the parameterized testing terminology. See
  the patch series cover letter change log for the
  definitions.

---
 lib/kunit/kunit-example-test.c | 104 +++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index f2819ee58965..ff21511889a4 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -393,6 +393,107 @@ static void example_params_test_with_init(struct kunit *test)
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
@@ -414,6 +515,9 @@ static struct kunit_case example_test_cases[] = {
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
2.51.0.rc0.205.g4a044479a3-goog


