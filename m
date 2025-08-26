Return-Path: <linux-kselftest+bounces-39936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C39CB35898
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 11:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65223A445F
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09523019A2;
	Tue, 26 Aug 2025 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GxLzhGbw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BBE30F7EF
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199636; cv=none; b=X0jR4vVLgLWwNZKcJo2EHwqAGAS5X+smJE91uffFi4HbSdLus00nrxW/MMeALKQrTkFfboOVLhi/k0ffBqfjpRnoRBpUcVu+fa/L0cIbYkNO7NzXkLkItKhkjZLy9ikicuSQaw4Ezc9ROcGwTIQ0UpIlpm0GOAz61H0vCxf3Xp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199636; c=relaxed/simple;
	bh=YYAqQOrOM9pO/vDtcPG9o4KAmJKgdt7NSEdpwQyFils=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=loiIKbYqHD8DFdxFddjA00W4blmJji0KV+Glco61q3h3UrHN+sS2yKX/P96GkSpgjPDNwZtUTDctWUeOnkhc1vw5mAiUF5Rp+IgfBiUy4lhzQgvNOlZQP/H1kM3rDsjk9nFCZxBfJJEoZXsRzmcV9PqOQ5x2h4LP1H/Pp5Uqy4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GxLzhGbw; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b471758845dso4455673a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 02:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756199634; x=1756804434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6YJBLokWG2Gb5OXsNbbrh9Xzkxl6kNwLj7uGaP0ytI=;
        b=GxLzhGbwnoXUIoD2LCD5GErKeZVHWnQ6UYKyvIJw1f6fawtHHu49nhEPY4EwKjIIod
         6E3UJkna842bG7Zc3vLOScDfqRdqn6DOukKfenFaOJsKTr5dLLh6kuX9wMZIoPP0asUZ
         2OaAKfJzDinjJTRhQGe2k7Estyd5gMRihIt6uOItGxBCfSEndZsQCAWMQQCoCXf17A6K
         SP7E8ypvOtudysiI+Cb2NPhvAnZSa+Z7U79TCop19n7j687h2xz9LGk9PdAM4F3668K1
         rssnpAtC99Hnx/QlBcAT14oVeffxp7Jj8+DQFQ1+ZiRmq3/IcBJwxJnvrdoylZcf/q/E
         PoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756199634; x=1756804434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6YJBLokWG2Gb5OXsNbbrh9Xzkxl6kNwLj7uGaP0ytI=;
        b=EVRfGCMUWI7W5WWzUOTnX4AFnhDtfMzRHfTedTY5lhOt/j0DnCokpScwgRdzebcu72
         lfw+VDGL/ATjr3QbyYmVaAvOu6InOpq4iPSpCuB8pD0RuqbLCDWipa8zTtut2SHcNuEV
         wjqDgZ19+bvx5Z/ROwoW+wm9kSGuR9fkaTi6ZWYlbu4lCxh/Bk2jTqJuXRE4+IdutZZ0
         CHoC4/oz8mV5E+jLQZAA8xmrrcIxMDRLbectwcyR37W5LL32YsgYk0lHZ7cusiJBDuge
         W5UMSelzXl1emXsKwoW4OcXCdu4rx0bUGcZHjKklYL7VJE5j8yw9GedZNMqA7JBCeuPe
         ICEg==
X-Forwarded-Encrypted: i=1; AJvYcCVly3QDFXhicyq4ArucgtsWViHpzv3Wl5cuuVlippZ5/tvzJxyP4TKrmI/rdYi1uwdfyboC0cFKfKycEcAqMYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIi62ZSDv6fO9PVG746CaDhfgZqc70gAr1YBrrdtwBq7E/RACX
	gB4E24PeU2C+HrDof9W7isFIeB/CYGdA716LeKJbkhRPc8paXwpM9MOII4jpx1Oq2b8uOktHwio
	/Sx8K0QHHtVSK6w==
X-Google-Smtp-Source: AGHT+IFaxfaFtDgDXFqhlggWIN6qGO50AHV0jzc2236uvg1CHDn3C9T5tAHUO2oFudu0A5MM9qc/raG7mN2Efw==
X-Received: from pjbpm5.prod.google.com ([2002:a17:90b:3c45:b0:31f:6ddd:ef5])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:c202:b0:243:6f08:86b4 with SMTP id adf61e73a8af0-2436f088fe5mr8170082637.39.1756199634209;
 Tue, 26 Aug 2025 02:13:54 -0700 (PDT)
Date: Tue, 26 Aug 2025 17:13:36 +0800
In-Reply-To: <20250826091341.1427123-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250826091341.1427123-1-davidgow@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826091341.1427123-7-davidgow@google.com>
Subject: [PATCH v4 6/7] kunit: Add example parameterized test with direct
 dynamic parameter array setup
From: David Gow <davidgow@google.com>
To: Marie Zhussupova <marievic@google.com>, marievictoria875@gmail.com, rmoar@google.com, 
	shuah@kernel.org, brendan.higgins@linux.dev
Cc: mark.rutland@arm.com, elver@google.com, dvyukov@google.com, 
	lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com, 
	rodrigo.vivi@intel.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, kasan-dev@googlegroups.com, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Marie Zhussupova <marievic@google.com>

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
Signed-off-by: David Gow <davidgow@google.com>
---
Changes in v4:
v3: https://lore.kernel.org/linux-kselftest/20250815103604.3857930-7-marievic@google.com/
- No changes.

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
2.51.0.261.g7ce5a0a67e-goog


