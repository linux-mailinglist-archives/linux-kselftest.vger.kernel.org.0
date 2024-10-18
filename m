Return-Path: <linux-kselftest+bounces-20092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 056889A32B9
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 04:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44121F25024
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 02:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65BF185B54;
	Fri, 18 Oct 2024 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2lUcBeA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95B17CA0B;
	Fri, 18 Oct 2024 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218163; cv=none; b=ZGv0gTGDdScfbP2MIc/GkYMPY3paKCSbhgilbqICcOd4aLU5w6hyLKIFSmffKd5Ooj0j81MgqqTvlUbCvTLwjI+7aIQ6dPiiwfFbX/E3rtlj8v65RtDNCPDWBmpPSSt7KTn1YgoD/cHOjJLA4UWG3zrrk8oAsF5ZaRFKXcGn6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218163; c=relaxed/simple;
	bh=WDQXKvgThl+Gw40TkwesnKGx7YMUmY4xzJANs5XXJ0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDjZkIecQDuboti9xeOMZ97JlxD2m8kE8OYCGzXYo7WHNHuyuS/4MOYpdynCaNpPCOmr6sO66EO2GlQuDC7NG0m7ZxupliTnLX8epVKiRRNGX+sjWTPF38yzyy58a5CYbUU7FnLtv5izoYBxBwsJjeGRQ284j/wTa/GVWiWg3so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2lUcBeA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729218162; x=1760754162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WDQXKvgThl+Gw40TkwesnKGx7YMUmY4xzJANs5XXJ0E=;
  b=j2lUcBeA0kjyQhrny+hu40422qCQ/xsm/+7ZxB9UH/K0PYBp5ZAH3PSP
   b/eBkkYdbMOfYmV5fLlklQjfV4w6xYzoGjUwajwfgwpaVCKh67h9oqNZx
   +br8AnMs6JW6Eg+uuaDRUZQKP1FL336PlWcfrgR/5HtAaLbGlFjzXDXhO
   g0ug6wA0QWWD7HvVQkIdkGI16daN2cnWiX27j54N3tLswwrplR3UfL7kC
   IJiYlSDqibioHvXvqBBYTvj50CJnkuuz+qnPzMGWDwvq3FioBNp1KQTM2
   zppVF2IfnMODaSFtO7jjXb0fo6u/4JNowPXB05LfbiSvZTabkyjKxYAVc
   Q==;
X-CSE-ConnectionGUID: lR8yhIxITiW47EcLL7SdEQ==
X-CSE-MsgGUID: UmLADvKLSHOlVlIwRyN8fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54149696"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="54149696"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:37 -0700
X-CSE-ConnectionGUID: iydpUy+uQjeT0BT1/sSs/g==
X-CSE-MsgGUID: 3gWlkkdPTkKqew8URjcQxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78697714"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:36 -0700
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
Subject: [PATCH V3 06/15] selftests/resctrl: Make wraparound handling obvious
Date: Thu, 17 Oct 2024 19:33:21 -0700
Message-ID: <46b9094f4ecd8188b559bdd4146aa365b13799b9.1729218182.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729218182.git.reinette.chatre@intel.com>
References: <cover.1729218182.git.reinette.chatre@intel.com>
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
2.46.2


