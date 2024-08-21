Return-Path: <linux-kselftest+bounces-15858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3632095A033
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 16:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81E6285136
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 14:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DC31B1D42;
	Wed, 21 Aug 2024 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N7lv+TK/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6362E1B1D50
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251405; cv=none; b=YGHdhxY6n2Ul88QZjyoNaNakVp++f2Cp4Tz3jW2gfeuYCf/Rj+R9CAkxT5LQ+xjTEAbf1CZba/+5qyzHg+/okV29lqMWQh/MCwOAcaGUFYG13qP8nJ+u8eXnLNUNL+Tp7pxg03bKmmPJmOhuG1DWBHbVzqoNq7nBgGaGAtxRhJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251405; c=relaxed/simple;
	bh=4FmpeBAoNG/9XaYQU9yKn+nz6rX9KfOZV11sxbb0Z6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ayu7ercJX4kPSVmsNM5MUqOc5/FgWim7YfL/2S35S5dWu5aKoXHm6TEKNgqV3rDM0q8ShzBcLr9D+mupPiOrNVNZQTwNIKw8ONzmDIxyDEZFOBdlqE7SmfPl2E+WIWk/Q5Wcg+KxJoSOMgJefXgJGVAXXw/xYXGILTUpStBshO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N7lv+TK/; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724251404; x=1755787404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4FmpeBAoNG/9XaYQU9yKn+nz6rX9KfOZV11sxbb0Z6M=;
  b=N7lv+TK/fQDfIGjPYky1nsYydzGGou2rFr6m0tDXAd0ezGTJs+H5/9sP
   u5547IjtxvGdMy/gnfNqjZgdVrmsaTe4A8M5JQlszk4j+LI8MKSL33l2o
   hD7yy39IubRVUdpi3qwL4PAnRH3Pri++h2AjIB8Yh2Y8gym5/yXMzMAZW
   ERBWDpFqHFY7jYZhMZnG/N1P1zxgWAnWzuWLcy8bv5F7mN2VKgwtiTOVU
   yhj3vEFDKqHvgsy5ovRYvuVozVDw7TUfAmloCOaJwnsrHFDAMeXv7/74B
   wzqUeZNbSrDS3co+KgOUDTNs0ySghBYyiCUgrk4t0edKjfihZnDAesEIo
   Q==;
X-CSE-ConnectionGUID: m3X4Pi5tQO2c78j9Lem5bw==
X-CSE-MsgGUID: bAIHj9iCRHS8Ux61fs9TDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22750525"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22750525"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 07:43:23 -0700
X-CSE-ConnectionGUID: 7ieikMQFSz6j3WGnrLP2eQ==
X-CSE-MsgGUID: mqeOvKHqSAKMM76O4y+1rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65316490"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.19.248])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 07:43:21 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Daniel Latypov <dlatypov@google.com>,
	David Gow <davidgow@google.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 1/4] kunit: Introduce kunit_is_running()
Date: Wed, 21 Aug 2024 16:43:02 +0200
Message-Id: <20240821144305.1958-2-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240821144305.1958-1-michal.wajdeczko@intel.com>
References: <20240821144305.1958-1-michal.wajdeczko@intel.com>
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
---
Cc: Daniel Latypov <dlatypov@google.com>
Cc: David Gow <davidgow@google.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
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


