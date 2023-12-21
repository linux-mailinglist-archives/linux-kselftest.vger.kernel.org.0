Return-Path: <linux-kselftest+bounces-2295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E19581B3E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 11:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B941A28250B
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 10:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853DA6AB81;
	Thu, 21 Dec 2023 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PijBGgiT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75C36A018;
	Thu, 21 Dec 2023 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL6AEek014182;
	Thu, 21 Dec 2023 04:39:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=rNoek7i2hFRCbF498o2jHOYXWryLj1e8+AacX3XSeLs=; b=
	PijBGgiTMMk/lKX+rDChXaawdFoWoo/wCCtCY6Q/h9oR7gOQrvrtJhraKZlB9scW
	hXpzsTUuAFTo5OHnFkqh3kjWwDKjkc7Ng4eomcFkOUmxL3EShbArXvJqMNmuX4uJ
	g17acFQgTFYBGfqdxCwVbLCyGsBnielHLpTHoGGqgrUe8Aw+mZqgs69nPRJSRVLO
	Omq+4c/F0BTkkyBOWWAri0vWAqCn39bpGN9mTh+zDklzzSHiiUr85nAB1SSla8cx
	h5uOcbufgZjkrd8z5sGrzRotFd+kdhRXy48GdyYr7Ou5Y9YsYP4nYL1CClxPioOg
	L4qj0Svz6tLLWaPzmaJc3w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3v1a627625-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 04:39:02 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 10:39:00 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Thu, 21 Dec 2023 10:39:00 +0000
Received: from work-debian.ad.cirrus.com (unknown [198.61.64.187])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3EC9311CC;
	Thu, 21 Dec 2023 10:39:00 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <brendan.higgins@linux.dev>, <davidgow@google.com>, <rmoar@google.com>
CC: <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v2 2/2] kunit: Add example of kunit_activate_static_stub() with pointer-to-function
Date: Thu, 21 Dec 2023 10:38:57 +0000
Message-ID: <20231221103858.46010-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231221103858.46010-1-rf@opensource.cirrus.com>
References: <20231221103858.46010-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 90crQN90oj-4uhzrdwETgjBfHpjxCXbE
X-Proofpoint-ORIG-GUID: 90crQN90oj-4uhzrdwETgjBfHpjxCXbE
X-Proofpoint-Spam-Reason: safe

Adds a variant of example_static_stub_test() that shows use of a
pointer-to-function with kunit_activate_static_stub().

A const pointer to the add_one() function is declared. This
pointer-to-function is passed to kunit_activate_static_stub() and
kunit_deactivate_static_stub() instead of passing add_one directly.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
V2: Added comment for add_one_fn_ptr.
---
 lib/kunit/kunit-example-test.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 359dbee10201..798924f7cc86 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -168,6 +168,16 @@ static int subtract_one(int i)
 	return i - 1;
 }
 
+/*
+ * If the function to be replaced is static within a module it is
+ * useful to export a pointer to that function instead of having
+ * to change the static function to a non-static exported function.
+ *
+ * This pointer simulates a module exporting a pointer to a static
+ * function.
+ */
+static int (* const add_one_fn_ptr)(int i) = add_one;
+
 /*
  * This test shows the use of static stubs.
  */
@@ -187,6 +197,30 @@ static void example_static_stub_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, add_one(1), 2);
 }
 
+/*
+ * This test shows the use of static stubs when the function being
+ * replaced is provided as a pointer-to-function instead of the
+ * actual function. This is useful for providing access to static
+ * functions in a module by exporting a pointer to that function
+ * instead of having to change the static function to a non-static
+ * exported function.
+ */
+static void example_static_stub_using_fn_ptr_test(struct kunit *test)
+{
+	/* By default, function is not stubbed. */
+	KUNIT_EXPECT_EQ(test, add_one(1), 2);
+
+	/* Replace add_one() with subtract_one(). */
+	kunit_activate_static_stub(test, add_one_fn_ptr, subtract_one);
+
+	/* add_one() is now replaced. */
+	KUNIT_EXPECT_EQ(test, add_one(1), 0);
+
+	/* Return add_one() to normal. */
+	kunit_deactivate_static_stub(test, add_one_fn_ptr);
+	KUNIT_EXPECT_EQ(test, add_one(1), 2);
+}
+
 static const struct example_param {
 	int value;
 } example_params_array[] = {
@@ -259,6 +293,7 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_mark_skipped_test),
 	KUNIT_CASE(example_all_expect_macros_test),
 	KUNIT_CASE(example_static_stub_test),
+	KUNIT_CASE(example_static_stub_using_fn_ptr_test),
 	KUNIT_CASE(example_priv_test),
 	KUNIT_CASE_PARAM(example_params_test, example_gen_params),
 	KUNIT_CASE_SLOW(example_slow_test),
-- 
2.30.2


