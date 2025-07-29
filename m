Return-Path: <linux-kselftest+bounces-38060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F50B153A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 21:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82B318A8238
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 19:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDE6299A90;
	Tue, 29 Jul 2025 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VsylBIt3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866D42550C2
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 19:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817855; cv=none; b=sk8kn9SHcLqqqvyGlSNmVXpYzc6jkxv1b7qUwvnvaFDf8qDJ2TdoPG9OC+4GEDHQiHr/IPYfA5blMSDbvVOW6GAjoD4oOY05WCsqFe28oaIrRs7yCJyzpV0HJtxDfdCbHsfkRngYnH7aVN4wBVgrb1WtmwvUw3z1aB4stbnGM44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817855; c=relaxed/simple;
	bh=o2IuSA30m5aXpuHiItxY2zkETFOrCBdEkL1BuKvaO+M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tg3cK71zW71563G6cnUZL0KqQSlASf3AKe8Q+fI+hJOijvK93nJe7hMWAaTGU47Co1AX+JbqZ09rflDSoGXdwUJtA6Ol5//PezsJ1Kt0aXJf/vJ6wtNWp30js6sOZwe8IYjXuOmilNVByvLyUgO6Ovr2BLew8PVFtGo+G9iEtrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VsylBIt3; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4ab5d8797ecso118786331cf.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 12:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753817852; x=1754422652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lH0YiEtTpPisQaiDPehvjIr4QLjg99NBvWegBL35AWY=;
        b=VsylBIt3PqSCk3MoMe5Tr8JFs9ak4MNCh/WjJ1i4FEbGr/ZtI6Mxk+qW7qiYKGSvs2
         B4bo9jlQe0pJDX7VhzpgnACxupd4nyx9Q7dUnzxobDELHNw9Ag2zb+6hBxQ9A7Q0JzMG
         vv4pcOQe/Mt/C0ejYSqZWPfDb8LVCepIBPdvdLDGVBCTAdsRWbR2L0KixKiPiLawC5Fz
         Z9Uq444UVp33Qb4hZFvlIe0qwPzrVWxmWnN610UcShRyogX0Wlo5tJzI9bo3g0J+89M+
         SjMlOtxvpCC3Qt/7oYSJedHJBj29+AX41NKW1ws+4iAPm7Ddmf3+nn1KrqaZu5rlzFdC
         tl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753817852; x=1754422652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lH0YiEtTpPisQaiDPehvjIr4QLjg99NBvWegBL35AWY=;
        b=GdQJ6wzBj3Ay92NB97Z/UF1tFOkay1y2FhK7ZxlRgqVKDrh5RYqAfAKDjw0fVuiH5A
         QIisJNSGDvhvlQbTDaihWDDL9+OZjxdDNGD7YsPcHM8TVyAYbXAAJWOWi136UwOmm4U3
         TY0gdgzzf+irl2Tpe+HEzxADbVKHtvth0WWV6MbtLw/mpgv3X7spNdJwIqxzIUvgkpTV
         6dViIy0oxy/MMXqgjel77o7Ysdn27nbMxNGQbL9VI0G0qUI5af4mPVSVd7G62JYgJhQQ
         w7UKKqVdgdDeIWVFFm1Nsu7h6SADpywBFo6QVuCXxe/iErQbpNlGoEE0hKtyG7NvkE/h
         G6cQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/Iqjx3BzogKfH0M6wNap0B5fxfQwdp+tsG+JX9Ha4xY2JkljcmYcYWoyQnNUgNRiyCIdsGem1SPFu0F7nuhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXiDAFMYjB4jR9Nom0kJEpy/0TlY76iuMUh4CCqIaqYQu8Jua3
	UPJxslDpdqCY7sYcLtQ3tt3MHxdfaYih3EcHfNzIYNJUmn65k1SF0jkNECwgMSSustTJmk8jXP/
	hnYNuRhzrMoK1aQ==
X-Google-Smtp-Source: AGHT+IF4rZx5R4hothbrtSYCg1oepGJR2HnKEYC/ASTsC2vpdZgeCHzZM3+vnOquEKeKMB2hzjmZc5YXv+XUvg==
X-Received: from qtbbr10.prod.google.com ([2002:a05:622a:1e0a:b0:4ae:713e:cb10])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:302:b0:4ab:5813:e8d with SMTP id d75a77b69052e-4aedbc739acmr14482571cf.32.1753817852434;
 Tue, 29 Jul 2025 12:37:32 -0700 (PDT)
Date: Tue, 29 Jul 2025 19:36:45 +0000
In-Reply-To: <20250729193647.3410634-1-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729193647.3410634-8-marievic@google.com>
Subject: [PATCH 7/9] kunit: Add example parameterized test with shared
 resources and direct static parameter array setup
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

Add `example_params_test_with_init` to illustrate how to manage
shared resources across parameterized KUnit tests. This example
showcases the use of the new `param_init` function and its registration
to a test using the `KUNIT_CASE_PARAM_WITH_INIT` macro.

Additionally, the test demonstrates:
- How to directly assign a static parameter array to a test via
  `kunit_register_params_array`.
- Leveraging the Resource API for test resource management.

Signed-off-by: Marie Zhussupova <marievic@google.com>
---
 lib/kunit/kunit-example-test.c | 112 +++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 3056d6bc705d..5bf559e243f6 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -277,6 +277,116 @@ static void example_slow_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 1 + 1, 2);
 }
 
+/*
+ * This custom function allocates memory for the kunit_resource data field.
+ * The function is passed to kunit_alloc_resource() and executed once
+ * by the internal helper __kunit_add_resource().
+ */
+static int example_resource_init(struct kunit_resource *res, void *context)
+{
+	int *info = kmalloc(sizeof(*info), GFP_KERNEL);
+
+	if (!info)
+		return -ENOMEM;
+	*info = *(int *)context;
+	res->data = info;
+	return 0;
+}
+
+/*
+ * This function deallocates memory for the 'kunit_resource' data field.
+ * The function is passed to kunit_alloc_resource() and automatically
+ * executes within kunit_release_resource() when the resource's reference
+ * count, via kunit_put_resource(), drops to zero. KUnit uses reference
+ * counting to ensure that resources are not freed prematurely.
+ */
+static void example_resource_free(struct kunit_resource *res)
+{
+	kfree(res->data);
+}
+
+/*
+ * This match function is invoked by kunit_find_resource() to locate
+ * a test resource based on defined criteria. The current example
+ * uniquely identifies the resource by its free function; however,
+ * alternative custom criteria can be implemented. Refer to
+ * lib/kunit/platform.c and lib/kunit/static_stub.c for further examples.
+ */
+static bool example_resource_alloc_match(struct kunit *test,
+					 struct kunit_resource *res,
+					 void *match_data)
+{
+	return res->data && res->free == example_resource_free;
+}
+
+/*
+ * This is an example of a function that provides a description for each of the
+ * parameters.
+ */
+static void example_param_array_get_desc(const void *p, char *desc)
+{
+	const struct example_param *param = p;
+
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE,
+		 "example check if %d is less than or equal to 3", param->value);
+}
+
+/*
+ * Initializes the parent kunit struct for parameterized KUnit tests.
+ * This function enables sharing resources across all parameterized
+ * tests by adding them to the `parent` kunit test struct. It also supports
+ * registering either static or dynamic arrays of test parameters.
+ */
+static int example_param_init(struct kunit *test)
+{
+	int ctx = 3; /* Data to be stored. */
+	int arr_size = ARRAY_SIZE(example_params_array);
+
+	/*
+	 * This allocates a struct kunit_resource, sets its data field to
+	 * ctx, and adds it to the kunit struct's resources list. Note that
+	 * this is test managed so we don't need to have a custom exit function
+	 * to free it.
+	 */
+	void *data = kunit_alloc_resource(test, example_resource_init, example_resource_free,
+					  GFP_KERNEL, &ctx);
+
+	if (!data)
+		return -ENOMEM;
+	/* Pass the static param array information to the parent struct kunit. */
+	kunit_register_params_array(test, example_params_array, arr_size,
+				    example_param_array_get_desc);
+	return 0;
+}
+
+/*
+ * This is an example of a parameterized test that uses shared resources
+ * available from the struct kunit parent field of the kunit struct.
+ */
+static void example_params_test_with_init(struct kunit *test)
+{
+	int threshold;
+	struct kunit_resource *res;
+	const struct example_param *param = test->param_value;
+
+	/* By design, param pointer will not be NULL. */
+	KUNIT_ASSERT_NOT_NULL(test, param);
+
+	/* Here we access the parent pointer of the test to find the shared resource. */
+	res = kunit_find_resource(test->parent, example_resource_alloc_match, NULL);
+
+	KUNIT_ASSERT_NOT_NULL(test, res);
+
+	/* Since the data field in kunit_resource is a void pointer we need to typecast it. */
+	threshold = *((int *)res->data);
+
+	/* Assert that the parameter is less than or equal to a certain threshold. */
+	KUNIT_ASSERT_LE(test, param->value, threshold);
+
+	/* This decreases the reference count after calling kunit_find_resource(). */
+	kunit_put_resource(res);
+}
+
 /*
  * Here we make a list of all the test cases we want to add to the test suite
  * below.
@@ -296,6 +406,8 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_static_stub_using_fn_ptr_test),
 	KUNIT_CASE(example_priv_test),
 	KUNIT_CASE_PARAM(example_params_test, example_gen_params),
+	KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init, NULL,
+				   example_param_init, NULL),
 	KUNIT_CASE_SLOW(example_slow_test),
 	{}
 };
-- 
2.50.1.552.g942d659e1b-goog


