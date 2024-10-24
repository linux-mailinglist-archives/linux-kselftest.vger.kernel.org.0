Return-Path: <linux-kselftest+bounces-20580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554EE9AF456
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 23:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CB61F22240
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 21:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFF5219488;
	Thu, 24 Oct 2024 21:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atis4df6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3EF21832E;
	Thu, 24 Oct 2024 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804089; cv=none; b=qv5AX9fQ9sjTfu/MtZnyrqkGgDtOhigfIY2Pwy3R6Z43gS0OLP91YkpH6kqPobxJ+29+KHG9vSqdgEr6KsP9WFJ8w+Hc+VznM1z6Dq8IYLo6Vl/08RlnhyE58KJ9J5nqBQlXkIqwbrCuQDkj3pDEee6Q8WW4uDLQTMgorZ1Ruxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804089; c=relaxed/simple;
	bh=K3dDL/ARG9AHDi3oOFzH+WG7DuBUfvcX+mwZNnT6MGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SeUtLL8MYf82Iyom2ifP6O3JjcJYAyXynxaIaL5LWwWhDxzMmNqR2YkPNePFhf01UolF47M3nyIlcDYaOUWfxlgjElqtcnCmUlf267zTZ1OnHi+H6wuP6V5XzLKRRQO+4be2Ap/GP7GQwlnH2Nh+nIjKE9mmn/SgktvW2YwWT9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atis4df6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729804087; x=1761340087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K3dDL/ARG9AHDi3oOFzH+WG7DuBUfvcX+mwZNnT6MGw=;
  b=atis4df6Kg3mK63XiapyT0N2N/xCG+YVZkfhwvzzOxgsKa66PQkUQ5IO
   DEaU76AtVG1mOWZxnlPsahpYnFVZk/NDwYgMI75lrU0CmT9fkhDoclqG2
   mHb86j+j6eSwvJijJ1ETs03cjNx2rDIBm7DWXuopWPGn6BcmBAJoH9+ej
   04kU0PlMSwUi+daDTyqdQUSv9qF5ZzaOev5UHLi5+3H19rUAn8jzuQiPu
   VLNDVAjhYodNkGKHpNZRqjCxON4EYG4X63VNlTVh6p/W6FY5lyGBwlrjs
   Irh6G/Xk91JTXZc/S6DpriYmZ3yflChFPggphkaM55HyK9WbmIicpvZ13
   A==;
X-CSE-ConnectionGUID: j/dPH2bnSTWh3m5F6lOX2A==
X-CSE-MsgGUID: O5hFrmLEQLKr7/qQOV+Edg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17090905"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="17090905"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:01 -0700
X-CSE-ConnectionGUID: TK8Vk/jXR1qcmmLPcEbsvw==
X-CSE-MsgGUID: e9NfCFGfR6eApHvDs72UQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85488036"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:01 -0700
From: Reinette Chatre <reinette.chatre@intel.com>
To: fenghua.yu@intel.com,
	shuah@kernel.org,
	tony.luck@intel.com,
	peternewman@google.com,
	babu.moger@amd.com,
	ilpo.jarvinen@linux.intel.com
Cc: maciej.wieczor-retman@intel.com,
	reinette.chatre@intel.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 06/15] selftests/resctrl: Make wraparound handling obvious
Date: Thu, 24 Oct 2024 14:18:43 -0700
Message-ID: <890c35b8c7b1aef384db0a1f9042322cf2dd23c8.1729804024.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729804024.git.reinette.chatre@intel.com>
References: <cover.1729804024.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Within mba_setup() the programmed bandwidth delay value starts
at the maximum (100, or rather ALLOCATION_MAX) and progresses
towards ALLOCATION_MIN by decrementing with ALLOCATION_STEP.

The programmed bandwidth delay should never be negative, so
representing it with an unsigned int is most appropriate. This
may introduce confusion because of the "allocation > ALLOCATION_MAX"
check used to check wraparound of the subtraction.

Modify the mba_setup() flow to start at the minimum, ALLOCATION_MIN,
and incrementally, with ALLOCATION_STEP steps, adjust the
bandwidth delay value. This avoids wraparound while making the purpose
of "allocation > ALLOCATION_MAX" clear and eliminates the
need for the "allocation < ALLOCATION_MIN" check.

Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Closes: https://lore.kernel.org/lkml/1903ac13-5c9c-ef8d-78e0-417ac34a971b@linux.intel.com/
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changes since V1:
- New patch
- Add Ilpo's Reviewed-by tag.
---
 tools/testing/selftests/resctrl/mba_test.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index ab8496a4925b..da40a8ed4413 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -39,7 +39,8 @@ static int mba_setup(const struct resctrl_test *test,
 		     const struct user_params *uparams,
 		     struct resctrl_val_param *p)
 {
-	static int runs_per_allocation, allocation = 100;
+	static unsigned int allocation = ALLOCATION_MIN;
+	static int runs_per_allocation;
 	char allocation_str[64];
 	int ret;
 
@@ -50,7 +51,7 @@ static int mba_setup(const struct resctrl_test *test,
 	if (runs_per_allocation++ != 0)
 		return 0;
 
-	if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)
+	if (allocation > ALLOCATION_MAX)
 		return END_OF_TESTS;
 
 	sprintf(allocation_str, "%d", allocation);
@@ -59,7 +60,7 @@ static int mba_setup(const struct resctrl_test *test,
 	if (ret < 0)
 		return ret;
 
-	allocation -= ALLOCATION_STEP;
+	allocation += ALLOCATION_STEP;
 
 	return 0;
 }
@@ -72,8 +73,9 @@ static int mba_measure(const struct user_params *uparams,
 
 static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 {
-	int allocation, runs;
+	unsigned int allocation;
 	bool ret = false;
+	int runs;
 
 	ksft_print_msg("Results are displayed in (MB)\n");
 	/* Memory bandwidth from 100% down to 10% */
@@ -103,7 +105,7 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 			       avg_diff_per > MAX_DIFF_PERCENT ?
 			       "Fail:" : "Pass:",
 			       MAX_DIFF_PERCENT,
-			       ALLOCATION_MAX - ALLOCATION_STEP * allocation);
+			       ALLOCATION_MIN + ALLOCATION_STEP * allocation);
 
 		ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
 		ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
-- 
2.47.0


