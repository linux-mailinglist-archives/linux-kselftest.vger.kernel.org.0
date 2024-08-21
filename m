Return-Path: <linux-kselftest+bounces-15908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A17095A529
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00807283037
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C87616EBEA;
	Wed, 21 Aug 2024 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWXHm9TP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C5E16EB7B
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267704; cv=none; b=fMD1SZnwa1PjEt4lRUJ0wujdzJEyda0IgdDi3E1ZEaVvSqYrPPrfqOygN6lNMGdRQPld3XAXQvxzY1rvpr8uOTgthhemo7IoQHr2wfCwDxT5SfYALIjGD8dAGpzoFHpzvzvzHSKziYE0YXMibpQ0KYy/VKh9azoRa52bWns7hQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267704; c=relaxed/simple;
	bh=M4PxTCQ6jyBM/K2D7FkO4ym9mO9TBb3cwyXDa0/+pnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WcnY+QjZIR3aBBBIZGOmEKyG5kJHtN6nXa55J4vPTDHaBpw6xnGAEQ5Vp5Q54a3oKlPQAAb/NUQkCV3KUZ8NIqbUUYo0CyRRW6XnUja+uKy5d7r59zQ/h0wdgBJ+tx6pskP948UDJlSP34OlUBxnxOT5Tf4w7+N3yQxg9lfh0FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWXHm9TP; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724267702; x=1755803702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M4PxTCQ6jyBM/K2D7FkO4ym9mO9TBb3cwyXDa0/+pnU=;
  b=TWXHm9TPTV542WKKB11wmYVZSChO4Spo6K38OrGkN1mlLrMZhFGcagnZ
   rbb/NqOV0kQMvv9gcROaCTTYFwihH76aonnBW+xhRbNHv7AOfO3aPLIZw
   3TAjfUIlP2zLXdhlKhgcrrrcK3y/LleO6hUnKXw5X8cmldhFA/p1A1fGB
   xv9rzE3AxlDlaKT5odNaoLsckE8AOMnq2kkhHQP0xCRqn6E2TsVU2weKU
   DOklHyZE8Zp/Se/eH8wzgfksEmdXfRV9ZvDu0GtpHlkyB0HcIsuPZO5HR
   rq5s2VzFi85UOiNrTFoFa4Ev2Emk0p2Zi2bG6lXpZ7mn17Xv3MOjYVZiI
   w==;
X-CSE-ConnectionGUID: IQ8FzJYGSJ6Pwy0tT/KXew==
X-CSE-MsgGUID: TFM09fejQe+C5UlsFbEpWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22802457"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22802457"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 12:15:02 -0700
X-CSE-ConnectionGUID: F7FDX5CtRTqgWDODDIdHTg==
X-CSE-MsgGUID: 4DyOkCd2SP6+mCSfBAIb1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="84357300"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.19.248])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 12:15:00 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>
Subject: [PATCH 2/3] kunit: Improve format of the PTR_EQ|NE|NULL assertion
Date: Wed, 21 Aug 2024 21:14:11 +0200
Message-Id: <20240821191412.2031-3-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240821191412.2031-1-michal.wajdeczko@intel.com>
References: <20240821191412.2031-1-michal.wajdeczko@intel.com>
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
  [ ]     ptr1 is -ENOMEM
  [ ]     ptr2 is NULL
  [ ] Expected ptr1 == ((void *)0), but
  [ ]     ptr1 is -ENOMEM
  [ ]     ((void *)0) is NULL

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
---
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
---
 lib/kunit/assert.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 6e4333d0c6a0..8da89043b734 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -155,12 +155,28 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
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
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s is NULL\n",
+				  binary_assert->text->left_text);
+	else if (IS_ERR(binary_assert->left_value))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s is %pe\n",
+				  binary_assert->text->left_text,
+				  binary_assert->left_value);
+	else
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %px\n",
+				  binary_assert->text->left_text,
+				  binary_assert->left_value);
+	if (!binary_assert->right_value)
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s is NULL\n",
+				  binary_assert->text->right_text);
+	else if (IS_ERR(binary_assert->right_value))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s is %pe\n",
+				  binary_assert->text->right_text,
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


