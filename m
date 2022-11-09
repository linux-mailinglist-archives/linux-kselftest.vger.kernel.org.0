Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C50B6220DC
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Nov 2022 01:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKIAg1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 19:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiKIAg1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 19:36:27 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDA263153
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Nov 2022 16:36:26 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id h16-20020a170902f55000b001871b770a83so12174555plf.9
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Nov 2022 16:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CZKNxZ4ut/Q7ACsrFTYtA5PMiQEhI2gWEXdAM+wb9gg=;
        b=cYSLYVLkoMHuam5SuetiF8cgGiYoAYiOA1FDE0de+JVwbInSf58Fn7Nuqba7t29Tlm
         kAEkRJI243IEl56URLz4GqhHzc5kNIoyBU5dolJ68qRmCHxVduAFhPFH9sXXHt7fsP2m
         wmOYn67OQtdmCCrHj+8T+iKeAM2KzgvXbTWuWou/qcNVuehaO2UQIl6x966q4q7Z8zpd
         Ngq+YURUPwM23Bk/LkbCwHiBmOToe4IyoOidBtQN8lPzxQ470F5rRAwMWnq3T1F7EKp0
         isviHND/AkHcHu1qZfF96e0YUSkLT9d59G44rU/vjx0VWjDPLr9E1T9TmfaZIhC402Jc
         UqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZKNxZ4ut/Q7ACsrFTYtA5PMiQEhI2gWEXdAM+wb9gg=;
        b=xkLVeHZG0LTiLEZ3rY+t+I8gA0FWItd0vKf4x4+CTw0ACLG1/XRqtbXUhSptsCm6g9
         mGQLV9s0apLLd3BWh/Z267EbbXggww60VEU3rKwixH4o9vLempstBpYHxEOlCEOeJTrS
         LPygh/vJFpOOLDhKlrb1tna0x13Ex0Xzz/xw3edd6l4o3+ojFl53EKISMit9TfADbsGJ
         aJr8MD+GEFRpuPneddnGBgear1Gw5HkDi5QaICWfr3vVuBqVESaAdbvTylGD8O0MPbpl
         C2acS1qeSnaX31l8iY2xrgOqeyFqR3fgyNgtzncL84ba3pc1pRPQLqcMVKMTjOPIesbm
         j8nQ==
X-Gm-Message-State: ACrzQf2xMCFIhP7gvJCcmV0Bq7x9MUjKtJsE7yJO2QsMJ+CIHoLrJtVd
        RVzgYdko8jUl9tFdrTKn/viHBQoUsaSSsA==
X-Google-Smtp-Source: AMsMyM5l1InG0bHkfyqtHlCsU7XWX0gLXIAXXCROhFBi9h+H8VfW0HVhDGCUeTz7B6sT1CNJ/zoHWriib5mDQw==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:90a:f3d4:b0:213:959f:5a90 with SMTP
 id ha20-20020a17090af3d400b00213959f5a90mr63952761pjb.54.1667954185985; Tue,
 08 Nov 2022 16:36:25 -0800 (PST)
Date:   Tue,  8 Nov 2022 16:36:16 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221109003618.3784591-1-dlatypov@google.com>
Subject: [PATCH v2 1/3] Documentation: KUnit: make usage.rst a superset of
 tips.rst, remove duplication
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

usage.rst had most of the content of the tips.rst page copied over.
But it's missing https://www.kernel.org/doc/html/v6.0/dev-tools/kunit/tips.html#customizing-error-messages
Copy it over so we can retire tips.rst w/o losing content.

And in that process, it also gained a duplicate section about how
KUNIT_ASSERT_*() exit the test case early. Remove that.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/usage.rst | 49 ++++++++++++++++---------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 2737863ef365..b0a6c3bc0eeb 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -118,6 +118,37 @@ expectation could crash the test case. `ASSERT_NOT_ERR_OR_NULL(...)` allows us
 to bail out of the test case if the appropriate conditions are not satisfied to
 complete the test.
 
+Customizing error messages
+--------------------------
+
+Each of the ``KUNIT_EXPECT`` and ``KUNIT_ASSERT`` macros have a ``_MSG``
+variant.  These take a format string and arguments to provide additional
+context to the automatically generated error messages.
+
+.. code-block:: c
+
+	char some_str[41];
+	generate_sha1_hex_string(some_str);
+
+	/* Before. Not easy to tell why the test failed. */
+	KUNIT_EXPECT_EQ(test, strlen(some_str), 40);
+
+	/* After. Now we see the offending string. */
+	KUNIT_EXPECT_EQ_MSG(test, strlen(some_str), 40, "some_str='%s'", some_str);
+
+Alternatively, one can take full control over the error message by using
+``KUNIT_FAIL()``, e.g.
+
+.. code-block:: c
+
+	/* Before */
+	KUNIT_EXPECT_EQ(test, some_setup_function(), 0);
+
+	/* After: full control over the failure message. */
+	if (some_setup_function())
+		KUNIT_FAIL(test, "Failed to setup thing for testing");
+
+
 Test Suites
 ~~~~~~~~~~~
 
@@ -546,24 +577,6 @@ By reusing the same ``cases`` array from above, we can write the test as a
 		{}
 	};
 
-Exiting Early on Failed Expectations
-------------------------------------
-
-We can use ``KUNIT_EXPECT_EQ`` to mark the test as failed and continue
-execution.  In some cases, it is unsafe to continue. We can use the
-``KUNIT_ASSERT`` variant to exit on failure.
-
-.. code-block:: c
-
-	void example_test_user_alloc_function(struct kunit *test)
-	{
-		void *object = alloc_some_object_for_me();
-
-		/* Make sure we got a valid pointer back. */
-		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, object);
-		do_something_with_object(object);
-	}
-
 Allocating Memory
 -----------------
 

base-commit: 6fe1ad4a156095859721fef85073df3ed43081d4
-- 
2.38.1.431.g37b22c650d-goog

