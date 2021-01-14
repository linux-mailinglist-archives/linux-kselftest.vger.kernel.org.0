Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12872F5C15
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jan 2021 09:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbhANIGr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jan 2021 03:06:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbhANIGX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jan 2021 03:06:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 498F923A21;
        Thu, 14 Jan 2021 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610611500;
        bh=lsHLlzifMdLeh1RjXgXq4YH0nFTVQMHUlzqRL8ytCbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BVoPSYZeaO3+EqGZlYd47ZQh+7h2gGRbGYiMnF7O3RGWiop/ZL4bULR6Tj537YLtL
         2uQRwbluVqEq4qyA7NJbCKAzUoBTwGoKhuPHGPUcgQwbhoyvbNUNru0VrpbR+kEYT+
         hjKwjdupWkFlnmXj8Z0bVnSBQWq+o4z6OqCq2higqpK4jSZ7XOv8tF3DAicmp6zZCQ
         eMj0t0MkxZsTPtWKAVe0F4tpTTyNkC/Zsf/TVsgRK89Ijkwutcax5Oa0NVnatprl/z
         J6gxWLBrkLV0fx3dKG2MHKWIKs+NMxwHhgbyQa/qKu9wP4zNH6dURNHDphm3grayND
         BtvwYA3/U7C7Q==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxco-00EQ6m-5l; Thu, 14 Jan 2021 09:04:58 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, Will Drewry <wad@chromium.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v6 10/16] selftests: kselftest_harness.h: partially fix kernel-doc markups
Date:   Thu, 14 Jan 2021 09:04:46 +0100
Message-Id: <8383758160fdb4fcbb2ac56beeb874ca6dffc6b9.1610610937.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610937.git.mchehab+huawei@kernel.org>
References: <cover.1610610937.git.mchehab+huawei@kernel.org>
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

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 26 ++++++++++++---------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index edce85420d19..ae0f0f33b2a6 100644
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
@@ -113,12 +113,16 @@
 			__FILE__, __LINE__, _metadata->name, ##__VA_ARGS__)
 
 /**
- * SKIP(statement, fmt, ...)
+ * SKIP()
  *
  * @statement: statement to run after reporting SKIP
  * @fmt: format string
  * @...: optional arguments
  *
+ * .. code-block:: c
+ *
+ *     SKIP(statement, fmt, ...);
+ *
  * This forces a "pass" after reporting why something is being skipped
  * and runs "statement", which is usually "return" or "goto skip".
  */
@@ -136,7 +140,7 @@
 } while (0)
 
 /**
- * TEST(test_name) - Defines the test function and creates the registration
+ * TEST() - Defines the test function and creates the registration
  * stub
  *
  * @test_name: test name
@@ -155,7 +159,7 @@
 #define TEST(test_name) __TEST_IMPL(test_name, -1)
 
 /**
- * TEST_SIGNAL(test_name, signal)
+ * TEST_SIGNAL()
  *
  * @test_name: test name
  * @signal: signal number
@@ -195,7 +199,7 @@
 		struct __test_metadata __attribute__((unused)) *_metadata)
 
 /**
- * FIXTURE_DATA(datatype_name) - Wraps the struct name so we have one less
+ * FIXTURE_DATA() - Wraps the struct name so we have one less
  * argument to pass around
  *
  * @datatype_name: datatype name
@@ -212,7 +216,7 @@
 #define FIXTURE_DATA(datatype_name) struct _test_data_##datatype_name
 
 /**
- * FIXTURE(fixture_name) - Called once per fixture to setup the data and
+ * FIXTURE() - Called once per fixture to setup the data and
  * register
  *
  * @fixture_name: fixture name
@@ -239,7 +243,7 @@
 	FIXTURE_DATA(fixture_name)
 
 /**
- * FIXTURE_SETUP(fixture_name) - Prepares the setup function for the fixture.
+ * FIXTURE_SETUP() - Prepares the setup function for the fixture.
  * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.
  *
  * @fixture_name: fixture name
@@ -265,7 +269,7 @@
 			__attribute__((unused)) *variant)
 
 /**
- * FIXTURE_TEARDOWN(fixture_name)
+ * FIXTURE_TEARDOWN()
  * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.
  *
  * @fixture_name: fixture name
@@ -286,7 +290,7 @@
 		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
 
 /**
- * FIXTURE_VARIANT(fixture_name) - Optionally called once per fixture
+ * FIXTURE_VARIANT() - Optionally called once per fixture
  * to declare fixture variant
  *
  * @fixture_name: fixture name
@@ -305,7 +309,7 @@
 #define FIXTURE_VARIANT(fixture_name) struct _fixture_variant_##fixture_name
 
 /**
- * FIXTURE_VARIANT_ADD(fixture_name, variant_name) - Called once per fixture
+ * FIXTURE_VARIANT_ADD() - Called once per fixture
  * variant to setup and register the data
  *
  * @fixture_name: fixture name
@@ -339,7 +343,7 @@
 		_##fixture_name##_##variant_name##_variant =
 
 /**
- * TEST_F(fixture_name, test_name) - Emits test registration and helpers for
+ * TEST_F() - Emits test registration and helpers for
  * fixture-based test cases
  *
  * @fixture_name: fixture name
-- 
2.29.2

