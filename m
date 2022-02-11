Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494324B2AB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 17:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239487AbiBKQmw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 11:42:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiBKQmw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 11:42:52 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A83D4B
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 08:42:50 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id bx2so17313785edb.11
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 08:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vsf2QgtdatJ2wExDY4gvcboSixkFghVOFaraVlgt+kM=;
        b=IuNoXsuKuLx9Go7T1AUl+TlgxLY5HcQtoU/BmcZQG8etPFFcIv2WATpIJM99eWsnVu
         G8k1QoDaKXsX8Ym3SQXc2ry2fEteera0sP60Ker8mc/N8RPmvX+UZ53A/5CnBuT9yk1s
         NQqGmuFdbEmnyZ6PX8DwG8CxmnDt7WGhDaYeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vsf2QgtdatJ2wExDY4gvcboSixkFghVOFaraVlgt+kM=;
        b=JsIKSk+TqnUwCmgycmrOq0h2l+y3zCkt6UyFxWnRnxsqHtvuGCdIDfNaHh4/y7vj/m
         WPEBZkdjE2p6cyfiIM/tgvIVipcPdwywZFJ+UVgDJ+6pMzWZChYDHwAaklbrf97jyh+K
         6Lbgv/I1HbnIH0iQoKuRzOEbyE6Ki/fbXHyUVHTV/zqqjShLr5yrL8uQeIW6Z7cdVslm
         +bJE8Z5sb8aoBRzajDVOAN/ffbjqfXL7N4OBPwHvkf8DFP2FmwX12bGhXFnz0hVn4TPP
         gVnFd9axhqKkzkjlXro+1Atrh4ad+V/gGGz+IbNWS2qLxYWPxx8tE3jP1kNstniUYZzp
         s4uA==
X-Gm-Message-State: AOAM532s2GJNblSRChr1ga3i7o0MhF5Y7epYfgMMp25sclfqdh+Lz7qb
        d93lCv7QnhrHacFWkqNszeEQyQ==
X-Google-Smtp-Source: ABdhPJyTmStlxOsX6f+36mZG/NIl9+NRGvVff6pOo8ngLlNAgbMvBk4gc3jzU7voGCy3NzYEPUC3Ag==
X-Received: by 2002:a05:6402:3608:: with SMTP id el8mr2759937edb.193.1644597768422;
        Fri, 11 Feb 2022 08:42:48 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id i24sm4981233edt.86.2022.02.11.08.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:42:48 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v6 1/6] kunit: Introduce _NULL and _NOT_NULL macros
Date:   Fri, 11 Feb 2022 17:42:41 +0100
Message-Id: <20220211164246.410079-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
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

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
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
2.35.1.265.g69c8d7142f-goog

