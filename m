Return-Path: <linux-kselftest+bounces-16342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED82E95FCA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 00:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997FD1F21CA1
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 22:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22FB19D080;
	Mon, 26 Aug 2024 22:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/jjgN+p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E4019AA56
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 22:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710836; cv=none; b=D8ZSr8Y9vzrmHYDmh/HCZY8UzulegbsYrcfdlH8jTwBIdz7imiEykCzy+anE3lJhtkp/MHGgIaeeVNQdArmqxU2/xTo8aN3kA5/gySRVFaPXD68o1/IKC6zPIAeLZUm1DvdeuOkRYPJVd7b5x+jSR8nAQ9iV+rnp9B8BJ5P+gdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710836; c=relaxed/simple;
	bh=DHjTZDh5IupglN5LpuQT50PBCXxQfXP83MHvVKsDzEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mQFdzK9zw8Cp8IBIHJsrvxtXjpxAmTN7Qp4xmsGRqSCxcYCxIt+iQR06cn/UOTZpsCYMnIHg9tArgctiSbouUs5pbRMyyRyFNnlbLUsfjDML+X+nNeH+h6zShukU7dcU0XYnaKAV+9VJojd/jsX5IgVJe2vEoXlY66yMcpj6dHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/jjgN+p; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724710835; x=1756246835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DHjTZDh5IupglN5LpuQT50PBCXxQfXP83MHvVKsDzEg=;
  b=g/jjgN+pPwXOOX/CozEKFvZgA5HDgmT+a+KHDj8gzomAbHSV5mAReGKy
   3av+tVaPDZ9bWN/4R0WcGMR8QzCJRWbD4J4oGWgpCWxay+Lt7BBvGKPz6
   CZtfCoODA65gr4TLpxD32VMr5bMBcR4wbkTBt0kOmvfjvc8mBqXicMNRy
   etqLFp5QF299MwSj74awoir7DA9pX56wx3eni32HZoWzfeuWXuC53Fx0D
   rYjTrJN37EBpWhBiHpVqY5c4Gv3W1sRoaOBbYWuX8Ff/btJ7qzSZGEQfL
   B0Mx++arBL3eYYT105lJG55ini2Eop/7ua0n6Zn8ZnvQkyoqwgwaEUBfo
   w==;
X-CSE-ConnectionGUID: OvYUhmBRTla/tYgTbuGMRA==
X-CSE-MsgGUID: wHbWz9z0RWK0p8od6MV6lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="34537385"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="34537385"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:20:35 -0700
X-CSE-ConnectionGUID: Q2b/PrBlQ+umJbsTxNeZ9A==
X-CSE-MsgGUID: frXaX9lhReaBmyuZMDCAGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="66992203"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.1.253])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:20:33 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Rae Moar <rmoar@google.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	David Gow <davidgow@google.com>
Subject: [PATCH v2 1/6] kunit: Introduce kunit_is_running()
Date: Tue, 27 Aug 2024 00:20:10 +0200
Message-Id: <20240826222015.1484-2-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240826222015.1484-1-michal.wajdeczko@intel.com>
References: <20240826222015.1484-1-michal.wajdeczko@intel.com>
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


