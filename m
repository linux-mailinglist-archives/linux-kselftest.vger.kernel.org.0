Return-Path: <linux-kselftest+bounces-16061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E207295B57A
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 14:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B10B2307D
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 12:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070161C945E;
	Thu, 22 Aug 2024 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5qsegb1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E631C9429
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331320; cv=none; b=StMXux/RpsO3lZhhykoXzdex0/eP2e/LEkBe+dC7HjmP+e7zeve8F7oylWof7y4S/E/UTxR05ZEkX9jAd+E6p/jwGfhtiUtNWbqewUniGGJfqcmwKVzThscH4eFqfvf5ymaxI8p+ycG77JYttLL45ofNVfhAKe66hUIWxYGkDME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331320; c=relaxed/simple;
	bh=lTby+jgl5c1tPzhv5758TzH19EWXku1duFb478mok9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gZRmkqDSATDy1+Mx2CN4z4W58UvfveU8Z7SFGZP9VJxU6LYiIloY4/SzifKxcMK5PYmE8MYTc0atsN5xFSXH4OtEZhHBkwCdPTU05jcYmthpPj3YEVBVF8vtKxGdmzb198bn3PpNQwThBEw3jrUGCz42rNPZXG4jkxK2/2XmIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5qsegb1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724331319; x=1755867319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lTby+jgl5c1tPzhv5758TzH19EWXku1duFb478mok9Q=;
  b=M5qsegb1Mkj1TJygSfanQ8KPfc/cjMO+oaj8fmZJBZyFozMeh8dXYojL
   5NxyvX1SrP4liOUBEoeOsLsdT1zO0suWC7dwfy0PcK2Ei42iTXCzhMuMy
   Ies+r6rZ33BBjOlpm0wgrNKC24fM24U+vHMds0PiOMb8vy1tv7Nwdy+ap
   ugY0f/5WnlJV6EvX0IYgU01ANHepBgP+e0/Jc7VBQiJQte5SkmQZiqx8d
   2Vfis88UyOH+/fTRHxLhuPBoHqU66Rprup4ueZj71DL6bqL1gMTSDwR9I
   oz06uyPD5dgwih9qA6pzNa4ENPFs7vR1l4Vm/FrVBJfFGsTUDoxQujzEn
   A==;
X-CSE-ConnectionGUID: k1vHGiYTTl+n6H/P+gkYjw==
X-CSE-MsgGUID: nTEjFWoeTyaPeiTob4SskQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="40203331"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="40203331"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 05:55:19 -0700
X-CSE-ConnectionGUID: cR+ZeAGYQRO/BJX/tTLNDA==
X-CSE-MsgGUID: sTCLUtjgS62+l1cpkrKARw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="65634775"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.19.248])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 05:55:18 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	David Gow <davidgow@google.com>
Subject: [PATCH v2 3/3] kunit: Improve format of the KUNIT_EXPECT_EQ assertion
Date: Thu, 22 Aug 2024 14:54:59 +0200
Message-Id: <20240822125459.2075-4-michal.wajdeczko@intel.com>
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

Diagnostic message for failed KUNIT_ASSERT|EXPECT_EQ shows in
case of integers only raw values, like for this example:

  bool flag;
  KUNIT_EXPECT_EQ(test, -ENODATA, kstrtobool("dunno", &flag));

we will get:

  [ ] Expected -61 == kstrtobool("dunno", &flag), but
  [ ]     kstrtobool("dunno", &flag) == -22 (0xffffffffffffffea)

but we can improve it if the value is within MAX_ERRNO range by
using more friendly error format:

  [ ] Expected -61 == kstrtobool("dunno", &flag), but
  [ ]     -61 == 0xffffffffffffffc3 (-ENODATA)
  [ ]     kstrtobool("dunno", &flag) == -22 (-EINVAL)

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: David Gow <davidgow@google.com> #v1
---
v2: keep '==' and raw values (David)
    use better example (Michal)
---
 lib/kunit/assert.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 414474841b61..5f0a2e2f5231 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -129,15 +129,37 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
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
+			string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (%#llx)\n",
+					  binary_assert->text->left_text,
+					  binary_assert->left_value,
+					  binary_assert->left_value);
+	else if (IS_ERR_VALUE(binary_assert->left_value))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %#llx (%pe)\n",
 				  binary_assert->text->left_text,
 				  binary_assert->left_value,
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
+			string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (%#llx)",
+					  binary_assert->text->right_text,
+					  binary_assert->right_value,
+					  binary_assert->right_value);
+	else if (IS_ERR_VALUE(binary_assert->right_value))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %#llx (%pe)",
 				  binary_assert->text->right_text,
 				  binary_assert->right_value,
-				  binary_assert->right_value);
+				  ERR_PTR(binary_assert->right_value));
 	kunit_assert_print_msg(message, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_assert_format);
-- 
2.43.0


