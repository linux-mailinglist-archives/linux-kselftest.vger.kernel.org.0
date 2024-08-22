Return-Path: <linux-kselftest+bounces-16060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFFB95B579
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 14:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B4E284624
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 12:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DE61C9DDB;
	Thu, 22 Aug 2024 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGjR79J0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996911DFF0
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331319; cv=none; b=F209+z1j8+AItgci4FNgJaYigzemZN0m8ToPcDCinn23gTk37RbtHfz7XxnMOjOazAH269PIaz44/jsPcGrAszgDes84LDgbNdqMouP3Y5ETTYAlwfllafXRPmn6S1Ccri8GFwsAb19LdmNdgqYRsCTqaaAx3l4oJ5vMjAgCOyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331319; c=relaxed/simple;
	bh=Nwfu5H0qJ6kodiBmbvMMULIzd9nDyr2Y5wNL2p4SJkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CyRpHBmnHo6rzs7nnVQYZhZ2YXAgibI388rlcrP11IXktMfK1YMUdAl9xutS83WJjf/A9N5q7zZVq/GbrfFCRBbGDrUOowejS0/1TSDr5eB36r0IKOrRNE4TCIiuGvEiy7mKr7wqER3Yynsd4+dVsyGqoAqR1BH6E0vub4Aoz0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGjR79J0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724331318; x=1755867318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nwfu5H0qJ6kodiBmbvMMULIzd9nDyr2Y5wNL2p4SJkc=;
  b=jGjR79J03/Xhkxzvp7ZysfXZCgKGndD+LTEFeA8+pK93ftfWP4atWEPH
   5L4bz5z2fff2aotRwhMCZbZ6teM3O1t+OBKCnLDkpjYdnNKWBYuG8ENpT
   64oBs6DvKGGHYWarAhbIMoxzSscqoEZTpuzwmBwYIYor2QHxKDIpoYOnR
   7BwMfwedqc2zP6xUDrP2T3EctqtIUcw6PFixyPtwmNNbCeaxGWOJiluJF
   XY2D+Y9Ymw7pWDs9lTpImaVJI6jSpdPrsLw2jR9rh9n5bJMDVYJZEOdCW
   AWJBBdD9a7nQUeHyRpOpUwgL04mwtMYctugkMFL0CECU5hBz8DzCV5NSV
   w==;
X-CSE-ConnectionGUID: b1KSNHxbTOqc8JplFE6fxw==
X-CSE-MsgGUID: adlQYy3UR921fTcHud4qUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="40203326"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="40203326"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 05:55:17 -0700
X-CSE-ConnectionGUID: WjkDDsqgSoazqQ/ypH3t0g==
X-CSE-MsgGUID: WjSwbNCMRBes2a6LkZaNog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="65634771"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.19.248])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 05:55:16 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>
Subject: [PATCH v2 2/3] kunit: Improve format of the PTR_EQ|NE|NULL assertion
Date: Thu, 22 Aug 2024 14:54:58 +0200
Message-Id: <20240822125459.2075-3-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240822125459.2075-1-michal.wajdeczko@intel.com>
References: <20240822125459.2075-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Diagnostic message for failed KUNIT_ASSERT|EXPECT_PTR_EQ|NE|NULL
shows only raw pointer value, like for this example:

  void *ptr1 = ERR_PTR(-ENOMEM);
  void *ptr2 = NULL;
  KUNIT_EXPECT_PTR_EQ(test, ptr1, ptr2);
  KUNIT_EXPECT_NULL(test, ptr1);

we will get:

  [ ] Expected ptr1 == ptr2, but
  [ ]     ptr1 == fffffffffffffff4
  [ ]     ptr2 == 0000000000000000
  [ ] Expected ptr1 == ((void *)0), but
  [ ]     ptr1 == ffffffffffffffe4
  [ ]     ((void *)0) == 0000000000000000

but we can improve this by detecting whether pointer was NULL or
error, and use friendly error pointer format if possible:

  [ ] Expected ptr1 == ptr2, but
  [ ]     ptr1 == fffffffffffffff4 (-ENOMEM)
  [ ]     ptr2 == 0000000000000000 (NULL)
  [ ] Expected ptr1 == ((void *)0), but
  [ ]     ptr1 == fffffffffffffff4 (-ENOMEM)
  [ ]     ((void *)0) == 0000000000000000 (NULL)

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
---
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
---
v2: keep '==' and raw value (David)
---
 lib/kunit/assert.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index aa3ae225f49f..414474841b61 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -156,12 +156,32 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 			  binary_assert->text->left_text,
 			  binary_assert->text->operation,
 			  binary_assert->text->right_text);
-	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px\n",
-			  binary_assert->text->left_text,
-			  binary_assert->left_value);
-	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px",
-			  binary_assert->text->right_text,
-			  binary_assert->right_value);
+	if (!binary_assert->left_value)
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px (NULL)\n",
+				  binary_assert->text->left_text,
+				  binary_assert->left_value);
+	else if (IS_ERR(binary_assert->left_value))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px (%pe)\n",
+				  binary_assert->text->left_text,
+				  binary_assert->left_value,
+				  binary_assert->left_value);
+	else
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px\n",
+				  binary_assert->text->left_text,
+				  binary_assert->left_value);
+	if (!binary_assert->right_value)
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px (NULL)\n",
+				  binary_assert->text->right_text,
+				  binary_assert->right_value);
+	else if (IS_ERR(binary_assert->right_value))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px (%pe)\n",
+				  binary_assert->text->right_text,
+				  binary_assert->right_value,
+				  binary_assert->right_value);
+	else
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px\n",
+				  binary_assert->text->right_text,
+				  binary_assert->right_value);
 	kunit_assert_print_msg(message, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
-- 
2.43.0


