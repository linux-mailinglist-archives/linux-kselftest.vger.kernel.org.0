Return-Path: <linux-kselftest+bounces-16707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1118C964D81
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 20:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42C701C2284B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2581B790E;
	Thu, 29 Aug 2024 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLNdc7lN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F53A1B81AF
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955243; cv=none; b=ophbg+jaSvo7byFwUMoKjeAyBkQ8S45c1RTeT6jQpOCgVVf1F5HzmAW3VtRpRZJ7WAflHNMOXrJ2F790v34ay44KxqOquB20gBdNCc3hapD83mGSOPVwQ0sufao0a+214Q4hy1f3Flpsqr7IoJEZJ1A0zqFvSEfxRnzhXhEvIQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955243; c=relaxed/simple;
	bh=DHjTZDh5IupglN5LpuQT50PBCXxQfXP83MHvVKsDzEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ABwN5wITWS9nvq/ozENCayowy/r4VVCoBIJuaJG4y9kDYm+N7rF5KQT2rctFuw9LylUwHQgnKOmFgO10rMSViIc6HBmxLLsB+NXG5Z1hDipnbgk/9C8wwBKymzw1ibp80c4pTTxNhu3kPJcXX4ks29ogYoszIW8mG03Hui9RFyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLNdc7lN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724955241; x=1756491241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DHjTZDh5IupglN5LpuQT50PBCXxQfXP83MHvVKsDzEg=;
  b=cLNdc7lNtjPM9HNuvs0N4f16eGfI0lYiFdRLNkCCNvnm6W91X2ssbe7/
   0mjxBr4nKNVk4GwGjFax+JG0KkCesAazJvaQgZ2keF7IdUv56yQEdlW8j
   Vdmd6Npy/zWcrc+7CI+MDt1XZLIXr04CZfyb1vUIbbw4tgstSUUin1xvU
   eqOV38yntAdeLttHCErtRIWHUABP/9AJkU6gbOJ3D0I54K+4spYZnV+OR
   KXue/4QthLPhEru/G2/uSk/4KJD1+W2JtwOq/M31amVuGD2x6c8oR7yS/
   nHBcc1hfRxF/tjaJNraQXrIU75kREAVT0TkyGhyY3rDgnopzg38o/NqQA
   w==;
X-CSE-ConnectionGUID: j+8boKxfRDK7pCercUSEcw==
X-CSE-MsgGUID: BtSWFUcuRHKc3vGWEFdZKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34238432"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="34238432"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 11:14:01 -0700
X-CSE-ConnectionGUID: 93wrvDhdRZGSuPpeEiZYPQ==
X-CSE-MsgGUID: O1gzga54TQGVk0ewNkc7qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63353215"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.245.120.199])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 11:13:59 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Rae Moar <rmoar@google.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	David Gow <davidgow@google.com>
Subject: [PATCH v3 1/6] kunit: Introduce kunit_is_running()
Date: Thu, 29 Aug 2024 20:13:43 +0200
Message-Id: <20240829181348.1572-2-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240829181348.1572-1-michal.wajdeczko@intel.com>
References: <20240829181348.1572-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wrap uses of the static key 'kunit_running' into a helper macro
to allow future checks to be placed in the code residing outside
of the CONFIG_KUNIT. We will start using this in upcoming patch.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Rae Moar <rmoar@google.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 include/kunit/test-bug.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
index 47aa8f21ccce..e8ea3bab7250 100644
--- a/include/kunit/test-bug.h
+++ b/include/kunit/test-bug.h
@@ -25,6 +25,13 @@ extern struct kunit_hooks_table {
 	void *(*get_static_stub_address)(struct kunit *test, void *real_fn_addr);
 } kunit_hooks;
 
+/**
+ * kunit_is_running() - True, if KUnit test is currently running.
+ *
+ * If CONFIG_KUNIT is not enabled, it will compile down to a false.
+ */
+#define kunit_is_running() static_branch_unlikely(&kunit_running)
+
 /**
  * kunit_get_current_test() - Return a pointer to the currently running
  *			      KUnit test.
@@ -40,7 +47,7 @@ extern struct kunit_hooks_table {
  */
 static inline struct kunit *kunit_get_current_test(void)
 {
-	if (!static_branch_unlikely(&kunit_running))
+	if (!kunit_is_running())
 		return NULL;
 
 	return current->kunit_test;
@@ -53,7 +60,7 @@ static inline struct kunit *kunit_get_current_test(void)
  * If a KUnit test is running in the current task, mark that test as failed.
  */
 #define kunit_fail_current_test(fmt, ...) do {					\
-		if (static_branch_unlikely(&kunit_running)) {			\
+		if (kunit_is_running()) {					\
 			/* Guaranteed to be non-NULL when kunit_running true*/	\
 			kunit_hooks.fail_current_test(__FILE__, __LINE__,	\
 						  fmt, ##__VA_ARGS__);		\
@@ -64,6 +71,7 @@ static inline struct kunit *kunit_get_current_test(void)
 
 static inline struct kunit *kunit_get_current_test(void) { return NULL; }
 
+#define kunit_is_running() false
 #define kunit_fail_current_test(fmt, ...) do {} while (0)
 
 #endif
-- 
2.43.0


