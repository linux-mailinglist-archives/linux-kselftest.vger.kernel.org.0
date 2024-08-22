Return-Path: <linux-kselftest+bounces-16059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3D695B578
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 14:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3407284603
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 12:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4681C9DD5;
	Thu, 22 Aug 2024 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5VQlet5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205601C9429
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331318; cv=none; b=foTVhfB0V7US+Fk4NWjiMzgEKoreiVtZYJDugOxuDsnAAy9LYy5YYNCppJ+Z8SA8gU2ahYRld5H0TbIjiLDCrYIblCPyuc74NMqR1UWjfbVlnmFdbi3W4a1lVNFb7flh2oe9vkG72AMUsZ2MlPchN6f3/6XimcWZbmjnh6UllQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331318; c=relaxed/simple;
	bh=y6iffii5u1U6CWVKIe5Vw/RZStrf//qPsfTb1f9WCp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z/aX4Pg3e8GuVye7rt0T8VhcCab6eiVtu9s025M+HYQxmnUVTpYaDZtsLY9obaaNBgB34r6Mte55TQbA3KO+PR/Bkg6BowBl8dOzjCcVI6/NLM09spBehHtK2vcANDGj9Nf+Xpack79wr3iE2cZn6R3Yt7SY6HJsfDEt8ykGQhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5VQlet5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724331316; x=1755867316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y6iffii5u1U6CWVKIe5Vw/RZStrf//qPsfTb1f9WCp4=;
  b=h5VQlet5S+8t+kkgjeyXHC1x3C8+gY2Uohoc6SiKZc0UW6RaA+LweFD3
   oUQ8B2IKJS0xYaXBwyZf9P5MUErB9JG/KM3inOCBg4JU2XgOp28s60ru7
   fp56fAWpfxp2pmo5RcGxCkWiXsyecEE8KK7zGxrTiCknA+ei88r/g4NiI
   /nC23n91qdA2EtNFc3T+g4jU+Ft/5sRvAKDNrBnYlNbelDvOqe+GhdjTB
   Y8twZVUQE6mIhT+QN2T7+GBZ+kGZOsHFPTqiEZc7iczoezk10LaKK4qT7
   +q8K1tS3dBQUSmXGbP7fgVmthM10JTsQVILrOm8OZ+hIkyAgWN/PRE2ud
   A==;
X-CSE-ConnectionGUID: zJe/x9s0TmOJjK/yEJHdGA==
X-CSE-MsgGUID: aXZfYfrlR0qCNxx4c+9SaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="40203323"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="40203323"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 05:55:16 -0700
X-CSE-ConnectionGUID: V1vYzxKkQIKbz5qjAx6rcg==
X-CSE-MsgGUID: hVca5xo+RVSysANlBYANfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="65634765"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.19.248])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 05:55:14 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	David Gow <davidgow@google.com>
Subject: [PATCH v2 1/3] kunit: Improve format of the NOT_ERR_OR_NULL assertion
Date: Thu, 22 Aug 2024 14:54:57 +0200
Message-Id: <20240822125459.2075-2-michal.wajdeczko@intel.com>
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

Diagnostic message for failed KUNIT_ASSERT|EXPECT_NOT_ERR_OR_NULL
shows only raw error code, like for this example:

  void *myptr = ERR_PTR(-ENOMEM);
  KUNIT_EXPECT_NOT_ERR_OR_NULL(test, myptr);

we will get:

  [ ] Expected myptr is not error, but is: -12

but we can improve it by using more friendly error pointer format:

  [ ] Expected myptr is not error, but is -ENOMEM (-12)

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: David Gow <davidgow@google.com>
---
v2: keep numerical error value (David,kunit-assert)
---
 lib/kunit/assert.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 867aa5c4bccf..aa3ae225f49f 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -77,13 +77,14 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 				  assert);
 
 	if (!ptr_assert->value) {
-		string_stream_add(stream,
-				  KUNIT_SUBTEST_INDENT "Expected %s is not null, but is\n",
+		string_stream_add(stream, KUNIT_SUBTEST_INDENT
+				  "Expected %s is not null, but is\n",
 				  ptr_assert->text);
 	} else if (IS_ERR(ptr_assert->value)) {
-		string_stream_add(stream,
-				  KUNIT_SUBTEST_INDENT "Expected %s is not error, but is: %ld\n",
+		string_stream_add(stream, KUNIT_SUBTEST_INDENT
+				  "Expected %s is not error, but is %pe (%ld)\n",
 				  ptr_assert->text,
+				  ptr_assert->value,
 				  PTR_ERR(ptr_assert->value));
 	}
 	kunit_assert_print_msg(message, stream);
-- 
2.43.0


