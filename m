Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9682297423
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 18:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbgJWQdw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Oct 2020 12:33:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751873AbgJWQdv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:51 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E67B02465D;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470829;
        bh=EYMl2u5G3tlfoX5HXXlEe/QfwoVAS1SQndK7owUVadA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xwa0v9hqZvQ1dEBdD3N04U75jYRrJ8PA2P4GzyYLZplUlSdSee1SJVijgy8iAwCkR
         4S4Y3HbJ2CV7eCgotlXiMgo4FG8c9c0mfC7WLXEpGz5gK+/ByxvFKo8Cuq1htkiit+
         8Ys/Kr7ZUwBjIixyHl0kKi+V14S29uSIbodv8b0o=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002Axv-RP; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, Will Drewry <wad@chromium.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 55/56] selftests: kselftest_harness.h: partially fix kernel-doc markups
Date:   Fri, 23 Oct 2020 18:33:42 +0200
Message-Id: <8d816b5a5f31600176fd9ad5e58c0a74bf79f8dd.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kernel-doc markups on this file are weird: they don't
follow what's specified at:

	Documentation/doc-guide/kernel-doc.rst

In particular, markups should use this format:
        identifier - description

and not this:
	identifier(args)

The way the definitions are inside this file cause the
parser to completely miss the identifier name of each
function.

This prevents improving the script to do some needed validation
tests.

Address this part. Yet, furter changes are needed in order
for it to fully follow the specs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 66 ++++++++++-----------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index f19804df244c..665d04f3b802 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -79,7 +79,7 @@
 #endif
 
 /**
- * TH_LOG(fmt, ...)
+ * TH_LOG()
  *
  * @fmt: format string
  * @...: optional arguments
@@ -113,7 +113,7 @@
 			__FILE__, __LINE__, _metadata->name, ##__VA_ARGS__)
 
 /**
- * SKIP(statement, fmt, ...)
+ * SKIP()
  *
  * @statement: statement to run after reporting SKIP
  * @fmt: format string
@@ -136,7 +136,7 @@
 } while (0)
 
 /**
- * TEST(test_name) - Defines the test function and creates the registration
+ * TEST() - Defines the test function and creates the registration
  * stub
  *
  * @test_name: test name
@@ -155,7 +155,7 @@
 #define TEST(test_name) __TEST_IMPL(test_name, -1)
 
 /**
- * TEST_SIGNAL(test_name, signal)
+ * TEST_SIGNAL()
  *
  * @test_name: test name
  * @signal: signal number
@@ -195,7 +195,7 @@
 		struct __test_metadata __attribute__((unused)) *_metadata)
 
 /**
- * FIXTURE_DATA(datatype_name) - Wraps the struct name so we have one less
+ * FIXTURE_DATA() - Wraps the struct name so we have one less
  * argument to pass around
  *
  * @datatype_name: datatype name
@@ -212,7 +212,7 @@
 #define FIXTURE_DATA(datatype_name) struct _test_data_##datatype_name
 
 /**
- * FIXTURE(fixture_name) - Called once per fixture to setup the data and
+ * FIXTURE() - Called once per fixture to setup the data and
  * register
  *
  * @fixture_name: fixture name
@@ -239,7 +239,7 @@
 	FIXTURE_DATA(fixture_name)
 
 /**
- * FIXTURE_SETUP(fixture_name) - Prepares the setup function for the fixture.
+ * FIXTURE_SETUP() - Prepares the setup function for the fixture.
  * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.
  *
  * @fixture_name: fixture name
@@ -265,7 +265,7 @@
 			__attribute__((unused)) *variant)
 
 /**
- * FIXTURE_TEARDOWN(fixture_name)
+ * FIXTURE_TEARDOWN()
  * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.
  *
  * @fixture_name: fixture name
@@ -286,7 +286,7 @@
 		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
 
 /**
- * FIXTURE_VARIANT(fixture_name) - Optionally called once per fixture
+ * FIXTURE_VARIANT() - Optionally called once per fixture
  * to declare fixture variant
  *
  * @fixture_name: fixture name
@@ -305,7 +305,7 @@
 #define FIXTURE_VARIANT(fixture_name) struct _fixture_variant_##fixture_name
 
 /**
- * FIXTURE_VARIANT_ADD(fixture_name, variant_name) - Called once per fixture
+ * FIXTURE_VARIANT_ADD() - Called once per fixture
  * variant to setup and register the data
  *
  * @fixture_name: fixture name
@@ -339,7 +339,7 @@
 		_##fixture_name##_##variant_name##_variant =
 
 /**
- * TEST_F(fixture_name, test_name) - Emits test registration and helpers for
+ * TEST_F() - Emits test registration and helpers for
  * fixture-based test cases
  *
  * @fixture_name: fixture name
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

