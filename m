Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46EE4AD7D8
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 12:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358299AbiBHLvA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 06:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346010AbiBHLu2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 06:50:28 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C59C0048E2
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 03:45:45 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id p15so51449098ejc.7
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 03:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fk7CgUzK9iGLnQH4r+eaSpgT+/fVBEfFahsh5Ie73gs=;
        b=Lf2vtVviddksWb4tJXSBba2AqudfN5D1/BP9WIxopYAkAWP2kTFA78MM5/+Go3FRdr
         QxmQZzt2u05hwpJS1gaopxODghLDb5IdzI9/Bfw3xO6hSN1u0Y8kKu4jiapQoG32/KeI
         VvEHPV5XkS/tazO2Od/gWPGrIxdo7jnd455Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fk7CgUzK9iGLnQH4r+eaSpgT+/fVBEfFahsh5Ie73gs=;
        b=Ws+SKiVoivPSEIgYX6A3dW+WMYcmJ2hSlaJDuYou3XacI/UkY2VukaSFTOLX90kpBk
         cZ6DTnlps8q4l/fgQDVp3Et50M8KGU6HnPLGVdc6zEfRLTPfJBQIbXwFPpxfPt/bS/ak
         nWQqoCvHuYR8iqsHHUbJitbrLM6LJ2PgpO63F8LznA28SihGxpebBFGxIlUELCBd09Y9
         B41pjL8PyEtOj8kzksK1ssotR+QTp2lUkCN3k3qXiIKBRaJl34nH/CMXHOyHH/fgGBcW
         AGQ8xvREgoDoPsc/bwtSBpQIgBcSE6zeKnijxLTAx87i9PP+/jqDqQA9Rn7h57Rolc0C
         +ZKw==
X-Gm-Message-State: AOAM532tUnUjGlWfukZ7LDWEU7rFFL1vzFMSaeUmxoLdY19c49hoO1an
        b12qgmSyYC9BjfST0s4QrmlWqA==
X-Google-Smtp-Source: ABdhPJz1dxqviSzrwGV3a9oijELN/j4sX+6Zf7SfWmn3uXkhjtZyq9e7+4Kzb+g/5gKvC3e/Ipo8ng==
X-Received: by 2002:a17:907:6088:: with SMTP id ht8mr3165020ejc.619.1644320744531;
        Tue, 08 Feb 2022 03:45:44 -0800 (PST)
Received: from alco.corp.google.com ([2620:0:1059:10:5d0f:d242:ddbf:a8a6])
        by smtp.gmail.com with ESMTPSA id y2sm4151902edt.54.2022.02.08.03.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 03:45:44 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 1/6] kunit: Introduce _NULL and _NOT_NULL macros
Date:   Tue,  8 Feb 2022 12:45:36 +0100
Message-Id: <20220208114541.2046909-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Today, when we want to check if a pointer is NULL and not ERR we have
two options:

KUNIT_EXPECT_TRUE(test, ptr == NULL);

or

KUNIT_EXPECT_PTR_NE(test, ptr, (struct mystruct *)NULL);

Create a new set of macros that take care of NULL checks.

Reviewed-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/kunit/test.h | 84 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 00b9ff7783ab..e6c18b609b47 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1218,6 +1218,48 @@ do {									       \
 				   fmt,					       \
 				   ##__VA_ARGS__)
 
+/**
+ * KUNIT_EXPECT_NULL() - Expects that @ptr is null.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an expectation that the value that @ptr evaluates to is null. This is
+ * semantically equivalent to KUNIT_EXPECT_PTR_EQ(@test, ptr, NULL).
+ * See KUNIT_EXPECT_TRUE() for more information.
+ */
+#define KUNIT_EXPECT_NULL(test, ptr)				               \
+	KUNIT_EXPECT_NULL_MSG(test,					       \
+			      ptr,					       \
+			      NULL)
+
+#define KUNIT_EXPECT_NULL_MSG(test, ptr, fmt, ...)	                       \
+	KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   ptr, ==, NULL,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_NOT_NULL() - Expects that @ptr is not null.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an expectation that the value that @ptr evaluates to is not null. This
+ * is semantically equivalent to KUNIT_EXPECT_PTR_NE(@test, ptr, NULL).
+ * See KUNIT_EXPECT_TRUE() for more information.
+ */
+#define KUNIT_EXPECT_NOT_NULL(test, ptr)			               \
+	KUNIT_EXPECT_NOT_NULL_MSG(test,					       \
+				  ptr,					       \
+				  NULL)
+
+#define KUNIT_EXPECT_NOT_NULL_MSG(test, ptr, fmt, ...)	                       \
+	KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   ptr, !=, NULL,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
+
 /**
  * KUNIT_EXPECT_NOT_ERR_OR_NULL() - Expects that @ptr is not null and not err.
  * @test: The test context object.
@@ -1485,6 +1527,48 @@ do {									       \
 				   fmt,					       \
 				   ##__VA_ARGS__)
 
+/**
+ * KUNIT_ASSERT_NULL() - Asserts that pointers @ptr is null.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an assertion that the values that @ptr evaluates to is null. This is
+ * the same as KUNIT_EXPECT_NULL(), except it causes an assertion
+ * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_NULL(test, ptr) \
+	KUNIT_ASSERT_NULL_MSG(test,					       \
+			      ptr,					       \
+			      NULL)
+
+#define KUNIT_ASSERT_NULL_MSG(test, ptr, fmt, ...) \
+	KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   ptr, ==, NULL,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_NOT_NULL() - Asserts that pointers @ptr is not null.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an assertion that the values that @ptr evaluates to is not null. This
+ * is the same as KUNIT_EXPECT_NOT_NULL(), except it causes an assertion
+ * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_NOT_NULL(test, ptr) \
+	KUNIT_ASSERT_NOT_NULL_MSG(test,					       \
+				  ptr,					       \
+				  NULL)
+
+#define KUNIT_ASSERT_NOT_NULL_MSG(test, ptr, fmt, ...) \
+	KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   ptr, !=, NULL,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
+
 /**
  * KUNIT_ASSERT_NOT_ERR_OR_NULL() - Assertion that @ptr is not null and not err.
  * @test: The test context object.
-- 
2.35.0.263.gb82422642f-goog

