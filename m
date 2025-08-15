Return-Path: <linux-kselftest+bounces-39097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF29B27E68
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 12:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763531B68696
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 10:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F3C301012;
	Fri, 15 Aug 2025 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QK22E6bD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE83009E8
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254185; cv=none; b=JO6TyP2YnjamyGeZiOAjgcwNiRKmXWkw1aFkFVPbMA15IGsDTJ3Vy6IuWFStldV++cDBLSpN+AVEh0BHNuzAIHoXOkv7CiDlf3crVs4zzZQK3xlsFP9fjCP12SZnR1H+vco8p+Xkfn5J5h+ryXq9qbBZsDfteNQDg0KJcZWW91o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254185; c=relaxed/simple;
	bh=rk+rv+DubkiOdslbaKlZTWR/6LAnBWqdq0f9LEpQipU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C7Dhd1cGOPE9woi9Zmznaea07Ibcf2yB7NL4Tbkq2TX6Ks1U3/E1zOGSUKzi6uah+lfQpvymQ7j9vj0rlJNEK0IL0dJwf3Lknsop/UcIhQiLmV2vFqD7do7rqnUqQz/UH1iAXpXRsZL3weoh2hfW5pCcd3gsY+A9vvVJXVfl7ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QK22E6bD; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-70a9f562165so55872446d6.2
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 03:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755254181; x=1755858981; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RNyqlzYzn7jh+8CRt3OEjX2dauCV97Pxa7UQdJrgoqo=;
        b=QK22E6bD9dWS3MUFM1hkEvXeczPuyvsjYUPVMlVFPCAlLPEVgt+oteLFHvu22feJ+S
         YBaJfcPhz4wp8in4dS1LEsn0dU1luWGYtZvxw4DKbgyTtzjhSJXxGpXF1I/+hXVugQ1B
         wFnc+4VTHRng91N9y6bkIZA4cOCk+Oqoot89cyM+FeSg3jMIyaTpxzo1e7sGg6Rgm0Z0
         qI2Qk51OKN7EieHlbuI0Vpdfm91ggTtkxAs7gmsINqW9RrTlG5UejcVFwFL+yHsjmUNb
         p0m/TNTEaZeJN4F7croBw3+/Z9AbefFWeq2m2pV9nfTRiGal3jfgZTH1e+SifDi1Ncx9
         yGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755254181; x=1755858981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNyqlzYzn7jh+8CRt3OEjX2dauCV97Pxa7UQdJrgoqo=;
        b=IDM4zKYxp/Utt2L8BErDTukYvQJ4+GXWAeXJP7cXek5avMc4MiPxUFkTzlE++0cGIm
         GwNWvLtMX2TwCAR7xxsd20DWDjka67j3HQekgoo5aCHS9ZGgbAt9drOzzFujv1JPqiVR
         lPWBBz4eKqUNbnVFMgcyQ4q56cK+h81upVHMG6MMqmDI3h4NfFTMbbHCwFjQMoEjwvDF
         KJ2QxAcoM7iWiv42HOjwWv3mJ8Z5s97zmrBq3rNBfqAXI/dXfyJwT7A9+punouopXwCs
         ksrgp9QAtpVSiQYeVAirgEequSX7+IqwjIa1EUMcr00sneT+x7DHRI7VHo090KdCaKRl
         uzpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTLdia/oa41nu2AUMJ6OKVhy5TAEpvcrx8OrW3rfnVDJBCDSEMomOdDqkhAfLhR7se+w6uJFiq4IlE17Gu/sU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy4xlbMl4C9M896NYLk+80ytPaLM9wNrusFoH3ah1mUAn2OI7b
	tZF6mbyOepC+uODY3aSSZEJGJt7f22TJtrkAjppHIBVyfhcT8XSayp/CwO+fIMQqTQA0zdiWIyy
	bZ9Ve0ddZwINyDg==
X-Google-Smtp-Source: AGHT+IE4pytpja7qv/dmXwoEtBCdtldEAT6l81LHSN6OYwd1hu8zWD0dEYjSqzYdvp2zQ1dRCnAG8StquQ7H/Q==
X-Received: from qvbqh9.prod.google.com ([2002:a05:6214:4c09:b0:709:2a7e:b05])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:27ef:b0:707:6977:aa77 with SMTP id 6a1803df08f44-70ba7c1d3bfmr12153106d6.33.1755254181483;
 Fri, 15 Aug 2025 03:36:21 -0700 (PDT)
Date: Fri, 15 Aug 2025 10:36:02 +0000
In-Reply-To: <20250815103604.3857930-1-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815103604.3857930-1-marievic@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250815103604.3857930-6-marievic@google.com>
Subject: [PATCH v3 5/7] kunit: Add example parameterized test with shared
 resource management using the Resource API
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
---

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
2.51.0.rc1.167.g924127e9c0-goog


