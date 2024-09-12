Return-Path: <linux-kselftest+bounces-17858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F14977002
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 20:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A831F254A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 18:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0901C1722;
	Thu, 12 Sep 2024 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRXAAln6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD9E1BFDFF;
	Thu, 12 Sep 2024 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164298; cv=none; b=Y2GWLgUP64/mT2Fh+B+SMEQBa9Y44InYAZpPyE6aCpYpd4inOCzAtxNCWnckR/jTBFcaGeuZJXPzX3bYZSGS+SLOe2K9QCaZP+VmwTcMZT3ipUjYJ90qGgvr0+jtEO2xYo7PzrAjZElDj9Ye9AaYRgoiFOoJaE20EHEs6CRiGys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164298; c=relaxed/simple;
	bh=uaLNw3+ytN+CB1MwOPqpnul7cEtlDlmWNYdX1kzswVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puJc9QlLY0tbQkJy+gwksg0vBjcanSMl1tjulmKPwYxpb1wVMA4fd6GbMtFQ/VlHVVChFCHMn0VmdShs2P1HkwYhZX7GuIwjU2Nw90vueEHZgpaButhxITCRZWMnAbvhCot4iSw+iVdoOWI4eie9y4JHF040cyM7f2MAww4O/7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRXAAln6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726164297; x=1757700297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uaLNw3+ytN+CB1MwOPqpnul7cEtlDlmWNYdX1kzswVg=;
  b=HRXAAln6r0MFEcuL20b0pEkaO8TENzRyWNOXbqupAM+Hbbgb3z0FeaHg
   /LjDU0Q8GVrNJ9GbBPx4BzK8zaSj0FkIejpOLT0yGYMEoDKq55hX9Qrfo
   gCvlMlCJKVsMtoELDox5AGUSJ/RSuLN6Ne5fJ2PgmkP4uWxcM+EO4mYx3
   jXFsXoyNRw42gwZ+hrDxkz72HC12/aVWzGLUkzgMeVZtKhksXMAXhIZf/
   CfFtufsUXQMhNUboR/SSQtsjHj4JWnYB1LHQOo5KiBGBmAPt65CdK3jRR
   NMk6Y7j5lsE8moLEXEWOl6V+vD4UAdmL7dwzvaCPr56/JFYLUR91RGEjS
   w==;
X-CSE-ConnectionGUID: i9YA/Y32Tj+BtA/h98CvgQ==
X-CSE-MsgGUID: qtb7WJ18SJCA/v7VvMMJWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24976593"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24976593"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:04:53 -0700
X-CSE-ConnectionGUID: fMHFH9m7QLaVIK7X+n8i4w==
X-CSE-MsgGUID: GBeizUvsTCChkp/pmCUMVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67724612"
Received: from b04f130c85c0.jf.intel.com (HELO rchatre-desk1.jf.intel.com) ([10.165.154.99])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:04:52 -0700
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
Subject: [PATCH V2 05/13] selftests/resctrl: Make wraparound handling obvious
Date: Thu, 12 Sep 2024 11:13:54 -0700
Message-ID: <f9d91e9a3403caed08a7830aa57f777207133edf.1726164080.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726164080.git.reinette.chatre@intel.com>
References: <cover.1726164080.git.reinette.chatre@intel.com>
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
2.46.0


