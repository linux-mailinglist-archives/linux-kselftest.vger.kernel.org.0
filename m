Return-Path: <linux-kselftest+bounces-15909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453DE95A52A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CF2EB22929
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E01C16EB4C;
	Wed, 21 Aug 2024 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PEkfvQAX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7241416EB7A
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267705; cv=none; b=huTYVRj8Cc8MZsMO7rBoC1gP8uHVjqllzcNYVWUF7eOIHGPMtrmAnRQO9XBU9b7BhbptbjeIYDvTRrb/ab6c4rB7nJcDGO1DSPxyIOr9VMXIaYGC6dzLZxD7fsrTMeGS61RfS7+MwVd1TcV57VgrHNRdu5jCeWbJmMLB9QP8nN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267705; c=relaxed/simple;
	bh=66Xki9LwmC1Vh1VD6+4OfUi24dYAnWUDKf8ddfIYAlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oRQFzK94EJA4fOtHRMc2oX5TPfh+FU/+IDRcZH5ZAyBtaECnQgPMYT8NYQIKKFIx8YeFqcgx2xNzdSJsAD0JHPCs45ql7oo90W2InP9N0NWuDq/XSx6UVzrn7WrC0HcWqxXaL3cNsJr8fC/h8tjS3uSANEbFVkoZ7oYnXLak1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PEkfvQAX; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724267704; x=1755803704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=66Xki9LwmC1Vh1VD6+4OfUi24dYAnWUDKf8ddfIYAlE=;
  b=PEkfvQAXFxaiOgTJTb5yNkilHq4ZijJQ0SlYlAswffaZFaw2GqVysryM
   3nUhgtSMjSxvKJp5vmSsL8I2B1jFN9vjeEtQgQvUhXABkjR5bnOzznlR7
   KdCJ0ivsDqHUcKw1eHDCXV1VjsNURuhvZohQQN7QcihofBYsUy4eG+Ft3
   pTuAf+vVXlwivHrDdEaBlqPHucgW3CQwXCOqrsIJRf78+Y5ZQiXn0mCdR
   2T5lCeOymafYI3IsqlaWG6Z71h3dS2iQGQyJLh2NI7uqnMeJrvei2lbMo
   IJ+gzuRV+grS864yam2aqupmV6XDzS/fkeZnCO/m7VL3JRHRSEqbeFVId
   A==;
X-CSE-ConnectionGUID: z5cBud28S6K69/NltpHUfA==
X-CSE-MsgGUID: Cu7eMDaBRiiwuYVgKg5uSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22802464"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22802464"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 12:15:04 -0700
X-CSE-ConnectionGUID: VAxZhLA9SY2D4H8t0qugmg==
X-CSE-MsgGUID: n84231uXSEKtLkRMbKDQxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="84357314"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.19.248])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 12:15:02 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>
Subject: [PATCH 3/3] kunit: Improve format of the KUNIT_EXPECT_EQ assertion
Date: Wed, 21 Aug 2024 21:14:12 +0200
Message-Id: <20240821191412.2031-4-michal.wajdeczko@intel.com>
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

Diagnostic message for failed KUNIT_ASSERT|EXPECT_EQ shows in
case of integers only raw values, like for this example:

  bool flag;
  KUNIT_EXPECT_EQ(test, 0, kstrtobool("dunno", &flag));

we will get:

  [ ] Expected 0 == kstrtobool("dunno", &flag), but
  [ ]     kstrtobool("dunno", &flag) == -22 (0xffffffffffffffea)

but we can improve it if the value is within MAX_ERRNO range by
using more friendly error format:

  [ ] Expected 0 == kstrtobool("dunno", &flag), but
  [ ]     kstrtobool("dunno", &flag) == -22 (-EINVAL)

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
---
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
---
 lib/kunit/assert.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 8da89043b734..9dec0551d0d0 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -128,15 +128,35 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 			  binary_assert->text->operation,
 			  binary_assert->text->right_text);
 	if (!is_literal(binary_assert->text->left_text, binary_assert->left_value))
-		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (0x%llx)\n",
+		if (IS_ERR_VALUE(binary_assert->left_value))
+			string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (%pe)\n",
+					  binary_assert->text->left_text,
+					  binary_assert->left_value,
+					  ERR_PTR(binary_assert->left_value));
+		else
+			string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (0x%llx)\n",
+					  binary_assert->text->left_text,
+					  binary_assert->left_value,
+					  binary_assert->left_value);
+	else if (IS_ERR_VALUE(binary_assert->left_value))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s is %pe\n",
 				  binary_assert->text->left_text,
-				  binary_assert->left_value,
-				  binary_assert->left_value);
+				  ERR_PTR(binary_assert->left_value));
 	if (!is_literal(binary_assert->text->right_text, binary_assert->right_value))
-		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (0x%llx)",
+		if (IS_ERR_VALUE(binary_assert->right_value))
+			string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (%pe)",
+					  binary_assert->text->right_text,
+					  binary_assert->right_value,
+					  ERR_PTR(binary_assert->right_value));
+		else
+			string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (0x%llx)",
+					  binary_assert->text->right_text,
+					  binary_assert->right_value,
+					  binary_assert->right_value);
+	else if (IS_ERR_VALUE(binary_assert->right_value))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s is %pe",
 				  binary_assert->text->right_text,
-				  binary_assert->right_value,
-				  binary_assert->right_value);
+				  ERR_PTR(binary_assert->right_value));
 	kunit_assert_print_msg(message, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_assert_format);
-- 
2.43.0


