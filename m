Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39D729A8B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 11:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896262AbgJ0Jwo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 05:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896059AbgJ0Jvo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 05:51:44 -0400
Received: from mail.kernel.org (ip5f5ad5af.dynamic.kabel-deutschland.de [95.90.213.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E00724679;
        Tue, 27 Oct 2020 09:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603792302;
        bh=b5/4x56iBejmXLUUqhNaiUaWyC3ayX676A0Vu+/Ivjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sP0eiRjvSMgIXYRfkjGb0M8t0fkxuG0pMj6J5Z3kUItZD1kiO3DEb2/EKoZl3er5Q
         4ZWixBToVFHvzndJlmvWzy1akWtnMDF+Pv2aMVaStwJhb5Wj82u2h8DrqOFkM8cnAQ
         nnMm4cpQHHXZI4dsyEEFcHtXnxf/dKRqis3Jlgy0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXLdj-003FFl-UW; Tue, 27 Oct 2020 10:51:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, Will Drewry <wad@chromium.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 29/32] selftests: kselftest_harness.h: fix kernel-doc markups
Date:   Tue, 27 Oct 2020 10:51:33 +0100
Message-Id: <697640045663f1366beb15e76e78b420dac5f5a2.1603791716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603791716.git.mchehab+huawei@kernel.org>
References: <cover.1603791716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kernel-doc markups there is violating the expected
syntax, causing it to not parse the name of the
markup identifier properly, preventing it to check
if the kernel-doc matches the #define below each
markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 44 ++++++++++-----------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index f19804df244c..d747d6b1da1a 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -432,7 +432,7 @@
  */
 
 /**
- * ASSERT_EQ(expected, seen)
+ * ASSERT_EQ()
  *
  * @expected: expected value
  * @seen: measured value
@@ -443,7 +443,7 @@
 	__EXPECT(expected, #expected, seen, #seen, ==, 1)
 
 /**
- * ASSERT_NE(expected, seen)
+ * ASSERT_NE()
  *
  * @expected: expected value
  * @seen: measured value
@@ -454,7 +454,7 @@
 	__EXPECT(expected, #expected, seen, #seen, !=, 1)
 
 /**
- * ASSERT_LT(expected, seen)
+ * ASSERT_LT()
  *
  * @expected: expected value
  * @seen: measured value
@@ -465,7 +465,7 @@
 	__EXPECT(expected, #expected, seen, #seen, <, 1)
 
 /**
- * ASSERT_LE(expected, seen)
+ * ASSERT_LE()
  *
  * @expected: expected value
  * @seen: measured value
@@ -476,7 +476,7 @@
 	__EXPECT(expected, #expected, seen, #seen, <=, 1)
 
 /**
- * ASSERT_GT(expected, seen)
+ * ASSERT_GT()
  *
  * @expected: expected value
  * @seen: measured value
@@ -487,7 +487,7 @@
 	__EXPECT(expected, #expected, seen, #seen, >, 1)
 
 /**
- * ASSERT_GE(expected, seen)
+ * ASSERT_GE()
  *
  * @expected: expected value
  * @seen: measured value
@@ -498,7 +498,7 @@
 	__EXPECT(expected, #expected, seen, #seen, >=, 1)
 
 /**
- * ASSERT_NULL(seen)
+ * ASSERT_NULL()
  *
  * @seen: measured value
  *
@@ -508,7 +508,7 @@
 	__EXPECT(NULL, "NULL", seen, #seen, ==, 1)
 
 /**
- * ASSERT_TRUE(seen)
+ * ASSERT_TRUE()
  *
  * @seen: measured value
  *
@@ -518,7 +518,7 @@
 	__EXPECT(0, "0", seen, #seen, !=, 1)
 
 /**
- * ASSERT_FALSE(seen)
+ * ASSERT_FALSE()
  *
  * @seen: measured value
  *
@@ -528,7 +528,7 @@
 	__EXPECT(0, "0", seen, #seen, ==, 1)
 
 /**
- * ASSERT_STREQ(expected, seen)
+ * ASSERT_STREQ()
  *
  * @expected: expected value
  * @seen: measured value
@@ -539,7 +539,7 @@
 	__EXPECT_STR(expected, seen, ==, 1)
 
 /**
- * ASSERT_STRNE(expected, seen)
+ * ASSERT_STRNE()
  *
  * @expected: expected value
  * @seen: measured value
@@ -550,7 +550,7 @@
 	__EXPECT_STR(expected, seen, !=, 1)
 
 /**
- * EXPECT_EQ(expected, seen)
+ * EXPECT_EQ()
  *
  * @expected: expected value
  * @seen: measured value
@@ -561,7 +561,7 @@
 	__EXPECT(expected, #expected, seen, #seen, ==, 0)
 
 /**
- * EXPECT_NE(expected, seen)
+ * EXPECT_NE()
  *
  * @expected: expected value
  * @seen: measured value
@@ -572,7 +572,7 @@
 	__EXPECT(expected, #expected, seen, #seen, !=, 0)
 
 /**
- * EXPECT_LT(expected, seen)
+ * EXPECT_LT()
  *
  * @expected: expected value
  * @seen: measured value
@@ -583,7 +583,7 @@
 	__EXPECT(expected, #expected, seen, #seen, <, 0)
 
 /**
- * EXPECT_LE(expected, seen)
+ * EXPECT_LE()
  *
  * @expected: expected value
  * @seen: measured value
@@ -594,7 +594,7 @@
 	__EXPECT(expected, #expected, seen, #seen, <=, 0)
 
 /**
- * EXPECT_GT(expected, seen)
+ * EXPECT_GT()
  *
  * @expected: expected value
  * @seen: measured value
@@ -605,7 +605,7 @@
 	__EXPECT(expected, #expected, seen, #seen, >, 0)
 
 /**
- * EXPECT_GE(expected, seen)
+ * EXPECT_GE()
  *
  * @expected: expected value
  * @seen: measured value
@@ -616,7 +616,7 @@
 	__EXPECT(expected, #expected, seen, #seen, >=, 0)
 
 /**
- * EXPECT_NULL(seen)
+ * EXPECT_NULL()
  *
  * @seen: measured value
  *
@@ -626,7 +626,7 @@
 	__EXPECT(NULL, "NULL", seen, #seen, ==, 0)
 
 /**
- * EXPECT_TRUE(seen)
+ * EXPECT_TRUE()
  *
  * @seen: measured value
  *
@@ -636,7 +636,7 @@
 	__EXPECT(0, "0", seen, #seen, !=, 0)
 
 /**
- * EXPECT_FALSE(seen)
+ * EXPECT_FALSE()
  *
  * @seen: measured value
  *
@@ -646,7 +646,7 @@
 	__EXPECT(0, "0", seen, #seen, ==, 0)
 
 /**
- * EXPECT_STREQ(expected, seen)
+ * EXPECT_STREQ()
  *
  * @expected: expected value
  * @seen: measured value
@@ -657,7 +657,7 @@
 	__EXPECT_STR(expected, seen, ==, 0)
 
 /**
- * EXPECT_STRNE(expected, seen)
+ * EXPECT_STRNE()
  *
  * @expected: expected value
  * @seen: measured value
-- 
2.26.2

