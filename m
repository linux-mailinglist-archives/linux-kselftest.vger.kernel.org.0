Return-Path: <linux-kselftest+bounces-39935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45BFB35899
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 11:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFE93A43C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C283112AD;
	Tue, 26 Aug 2025 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ztZKiFdZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7AC30E0CD
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199636; cv=none; b=k2GcTMlsOPYRIbXj/GMka6Oc+TNkzdXkMvS9WR6vxw3FiCkJh71hbkng3IHy8GRHWApEZkNDbckSS6xgVmNqFvJU3EubQgkTA1EZkzyTcs93Ozj8AIxgCOn3/ow6TdhTwFoLz7d8QeCE4gLq9atBnWaks6WeNeb9Y1X9EatIDwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199636; c=relaxed/simple;
	bh=3aFRb/9IcKHZ+M6T9pjKhjrVD03MzY2Xmw+S7EN4W2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SED9ibrLOGJSfAzOw82GiC8qw+NavGBvlZCkI/KXm/0D35oG91g9Sg/r01SKoajyrp1GlX6sHnsTGsQqfOdgpsiDyKIIDl1vZ+xemD+PTrSF56kUEgSgIFQc2HMytmjCAdGAJFzFky+OF6Alq4zuR/pYmjvyCL/wYqPv7cMIEOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ztZKiFdZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581c62faso66816045ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 02:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756199633; x=1756804433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/DdI8QKaF0QvnOvsbrRP9RRgtoSroBxXesHs3tNY3s=;
        b=ztZKiFdZMJN4rUrWKMJzleotJY622iBy8j7e46ZVKKLa/Jgjd6otQYZwYMfWyvH0NM
         Gk7y9MRPBdUKnqDQuNNbuuIyJUskKJjS1yn//D8bCP+AyOvUr1j5Qsj/tFinKjAdDRgI
         eMz4poDUQ8J7JfksA9xZZ/t/NBv6lsjZFqa91gQ5z0Zn1xuK9zYArSAu3ddO6nbNdrlJ
         vBlzcTW5jCxkhStAL+xxy2NCJoTXRugMEq6Tt5y6lFYz2Kg1NN10Xf0yMdP2bIVZRCDx
         jp1U5nAMGYZloOVPxq0pxqek6bAD19QoC4I2ApzG/mZfofKXzZpixmkV9KhTr5n1AF0/
         1dUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756199633; x=1756804433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/DdI8QKaF0QvnOvsbrRP9RRgtoSroBxXesHs3tNY3s=;
        b=Smf8OI4Kh37aF5xnKQvL0dTYyUI09t9UstFNwCfWsBR6v3kosBI4detnnvdsOqQOoQ
         aKoAK4Si8pA6cQUAa+ASOdBWtYGqj8Ufi0O62xqqCyVXzttIkVTj+miWxmlE+P1tEO3w
         K/qYAb4jmSZlJR32wFu0b1RQ23teoAPEvr49f+0n5FebaMyfP/zHZMrU4ygIxH9rN5u1
         2/FTW6CEYFriO03SgVITtnXSLhfXitnkyuewYf8bw5yJsZcfU3x489xnjK732RSCqUhJ
         wsKkw18ktp6yYjw+99OIfRPuqsOYkO9RQxeWV1vYkekVsLXMcoipKCN44tAKkVXYDWjA
         J3iA==
X-Forwarded-Encrypted: i=1; AJvYcCVd/iqV9yIvRSFNoTFjqXnuk/nHfC+I4oscbgBjiD8KfXxmBZCaCVoJzBWErnF1T9pzV98m5un8m9CCLbrhZis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyufi8h7Ydc0RI9MoPoQQjE1jlpYfRTXFSftSuhyhqERj0SrCcM
	ZLHtkQDcPwKN6AGQUemgys/MDs6uKueTxROgyFp5q6nDqDCPLABSURPqnY7x3jsYtUECI3eN9mx
	2UM1PZymxgbyrQw==
X-Google-Smtp-Source: AGHT+IFm2ccebIdeBPqgsg0k7MRJFE97IlpYmQ10sZM4xPEDskf6ORLyTRQTD8U2eP7B+NNUOmHZ2XIMml/jXw==
X-Received: from pldp2.prod.google.com ([2002:a17:902:eac2:b0:237:cedc:1467])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ec87:b0:246:6a8b:8473 with SMTP id d9443c01a7336-2466a8b8672mr147539915ad.45.1756199632691;
 Tue, 26 Aug 2025 02:13:52 -0700 (PDT)
Date: Tue, 26 Aug 2025 17:13:35 +0800
In-Reply-To: <20250826091341.1427123-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250826091341.1427123-1-davidgow@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826091341.1427123-6-davidgow@google.com>
Subject: [PATCH v4 5/7] kunit: Add example parameterized test with shared
 resource management using the Resource API
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

Add example_params_test_with_init() to illustrate how to manage
shared resources across a parameterized KUnit test. This example
showcases the use of the new param_init() function and its registration
to a test using the KUNIT_CASE_PARAM_WITH_INIT() macro.

Additionally, the test demonstrates how to directly pass a parameter array
to the parameterized test context via kunit_register_params_array()
and leveraging the Resource API for shared resource management.

Reviewed-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Marie Zhussupova <marievic@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

No changes in v4:
v3: https://lore.kernel.org/linux-kselftest/20250815103604.3857930-6-marievic@google.com/

Changes in v3:
v2: https://lore.kernel.org/all/20250811221739.2694336-6-marievic@google.com/
- Code comment edits.

Changes in v2:
v1: https://lore.kernel.org/all/20250729193647.3410634-8-marievic@google.com/
- kunit_array_gen_params() is now explicitly passed to
  KUNIT_CASE_PARAM_WITH_INIT() to be consistent with a parameterized test
  being defined by the existence of the generate_params() function.
- The comments were edited to be more concise.
- The patch header was changed to reflect that this example test's intent
  is more aligned with showcasing using the Resource API for shared
  resource management.
- The comments and the commit message were changed to reflect the
  parameterized testing terminology. See the patch series cover letter
  change log for the definitions.

---
 lib/kunit/kunit-example-test.c | 113 +++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 3056d6bc705d..3e858367be01 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -277,6 +277,117 @@ static void example_slow_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 1 + 1, 2);
 }
 
+/*
+ * This custom function allocates memory and sets the information we want
+ * stored in the kunit_resource->data field.
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
+ * This function deallocates memory for the kunit_resource->data field.
+ */
+static void example_resource_free(struct kunit_resource *res)
+{
+	kfree(res->data);
+}
+
+/*
+ * This match function is invoked by kunit_find_resource() to locate
+ * a test resource based on certain criteria.
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
+ * parameters in a parameterized test.
+ */
+static void example_param_array_get_desc(struct kunit *test, const void *p, char *desc)
+{
+	const struct example_param *param = p;
+
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE,
+		 "example check if %d is less than or equal to 3", param->value);
+}
+
+/*
+ * This function gets passed in the parameterized test context i.e. the
+ * struct kunit belonging to the parameterized test. You can use this function
+ * to add resources you want shared across the whole parameterized test or
+ * for additional setup.
+ */
+static int example_param_init(struct kunit *test)
+{
+	int ctx = 3; /* Data to be stored. */
+	size_t arr_size = ARRAY_SIZE(example_params_array);
+
+	/*
+	 * This allocates a struct kunit_resource, sets its data field to
+	 * ctx, and adds it to the struct kunit's resources list. Note that
+	 * this is parameterized test managed. So, it doesn't need to have
+	 * a custom exit function to deallocation as it will get cleaned up at
+	 * the end of the parameterized test.
+	 */
+	void *data = kunit_alloc_resource(test, example_resource_init, example_resource_free,
+					  GFP_KERNEL, &ctx);
+
+	if (!data)
+		return -ENOMEM;
+	/*
+	 * Pass the parameter array information to the parameterized test context
+	 * struct kunit. Note that you will need to provide kunit_array_gen_params()
+	 * as the generator function to KUNIT_CASE_PARAM_WITH_INIT() when registering
+	 * a parameter array this route.
+	 */
+	kunit_register_params_array(test, example_params_array, arr_size,
+				    example_param_array_get_desc);
+	return 0;
+}
+
+/*
+ * This is an example of a test that uses shared resources available in the
+ * parameterized test context.
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
+	/*
+	 * Here we pass test->parent to search for shared resources in the
+	 * parameterized test context.
+	 */
+	res = kunit_find_resource(test->parent, example_resource_alloc_match, NULL);
+
+	KUNIT_ASSERT_NOT_NULL(test, res);
+
+	/* Since kunit_resource->data is a void pointer we need to typecast it. */
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
@@ -296,6 +407,8 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_static_stub_using_fn_ptr_test),
 	KUNIT_CASE(example_priv_test),
 	KUNIT_CASE_PARAM(example_params_test, example_gen_params),
+	KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init, kunit_array_gen_params,
+				   example_param_init, NULL),
 	KUNIT_CASE_SLOW(example_slow_test),
 	{}
 };
-- 
2.51.0.261.g7ce5a0a67e-goog


