Return-Path: <linux-kselftest+bounces-7414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F1289C997
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 18:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D5E284371
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA221428E3;
	Mon,  8 Apr 2024 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kx4puvFb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7111E14291D;
	Mon,  8 Apr 2024 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594014; cv=none; b=MeFOepN8se4HsMcpCiHTnqYucHGz0wHWiI5CIXMHQiLKkAOcoLBp5FN9M0asWZfQz0E2vYtomcku0leFUgNSjD7bVw6OLnDSyZu44aud1o/EAp35uf95OVSjo7Y6BrhDfY//2brkUCDnJqKjBv8w7RbzbV5+3Wx+4mVi0c8XLWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594014; c=relaxed/simple;
	bh=xTfFrwH1xgFVTljhCAm/asdXv1HKcLDnfZLy3W8Rb5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YD1OXpFxbaDq/vB/e+ZuqT9J5dLmtor4PmR2b4kjJg46u3O+X/sSF8mNJfB2IzDlBKwkQ21mJP5/AiL86u4RxpE4KvxrZ/IEe7FGYwHyuT7tI1hhZNoUWN/yBt2HflM5RHuwrJ8fBMKZDWCSkh+CW/ayapI8A4Rk57m5E3jEP7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kx4puvFb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712594014; x=1744130014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xTfFrwH1xgFVTljhCAm/asdXv1HKcLDnfZLy3W8Rb5M=;
  b=kx4puvFb0xEHngXa1gTvZrewb640U2LHvs6BV9v/6Rc7xi/1CU34SbBu
   pQ9SOfX9kFudrjQ96A1MzdRdLqylyttaMmzuE2wnovk+PuNnQpMUwabQP
   TuecYOdH4TOp7zZKzq5JqR1w3TUVX9ulv2hA5Q+snBOmGlUVA/8KEN0J9
   pFOvKTLMgOuILOdtYz0tsNw+IKzmoO6f8R1tnySzsMTA8xW7RZ3tnyCG8
   j2qgCNYQx62YMkxhxPDHi4oTg8g6mKMJqwQ521msjZtgMqTY+pk0tGvAq
   p1IfpuSXF3cos1pIcyufxrzhlgN7k7VYrr/Yk0OHNek4WRJumxheAPAZf
   A==;
X-CSE-ConnectionGUID: h8klxeZoSJmwAmW2Auyf+Q==
X-CSE-MsgGUID: ARDREjtrSrWAoaXWr+qsQA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="19315282"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19315282"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:33:33 -0700
X-CSE-ConnectionGUID: o1nDEQd8RZmbOnQx5kA8ew==
X-CSE-MsgGUID: u0LjE35YS9G/3+oFgFzuqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="43113529"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:33:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 04/16] selftests/resctrl: Make "bandwidth" consistent in comments & prints
Date: Mon,  8 Apr 2024 19:32:35 +0300
Message-Id: <20240408163247.3224-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
References: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Resctrl selftests refer to "bandwidth" currently in two other forms in
the code ("B/W" and "band width").

Use "bandwidth" consistently everywhere. While at it, fix also one
"over flow" -> "overflow" on a line that is touched by the change.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v3:
- New patch
---
 tools/testing/selftests/resctrl/resctrl_val.c | 14 +++++++-------
 tools/testing/selftests/resctrl/resctrlfs.c   |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index f2b6824cd5f2..e28a1ebef730 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -350,11 +350,11 @@ static void do_imc_mem_bw_test(void)
 }
 
 /*
- * get_mem_bw_imc - Memory band width as reported by iMC counters
+ * get_mem_bw_imc - Memory bandwidth as reported by iMC counters
  * @bw_report: Bandwidth report type (reads, writes)
  *
- * Memory B/W utilized by a process on a socket can be calculated using
- * iMC counters. Perf events are used to read these counters.
+ * Memory bandwidth utilized by a process on a socket can be calculated
+ * using iMC counters. Perf events are used to read these counters.
  *
  * Return: = 0 on success. < 0 on failure.
  */
@@ -368,7 +368,7 @@ static int get_mem_bw_imc(char *bw_report, float *bw_imc)
 
 	/*
 	 * Get results which are stored in struct type imc_counter_config
-	 * Take over flow into consideration before calculating total b/w
+	 * Take overflow into consideration before calculating total bandwidth.
 	 */
 	for (imc = 0; imc < imcs; imc++) {
 		struct imc_counter_config *r =
@@ -378,14 +378,14 @@ static int get_mem_bw_imc(char *bw_report, float *bw_imc)
 
 		if (read(r->fd, &r->return_value,
 			 sizeof(struct membw_read_format)) == -1) {
-			ksft_perror("Couldn't get read b/w through iMC");
+			ksft_perror("Couldn't get read bandwidth through iMC");
 
 			return -1;
 		}
 
 		if (read(w->fd, &w->return_value,
 			 sizeof(struct membw_read_format)) == -1) {
-			ksft_perror("Couldn't get write bw through iMC");
+			ksft_perror("Couldn't get write bandwidth through iMC");
 
 			return -1;
 		}
@@ -488,7 +488,7 @@ static int get_mem_bw_resctrl(unsigned long *mbm_total)
 
 	fp = fopen(mbm_total_path, "r");
 	if (!fp) {
-		ksft_perror("Failed to open total bw file");
+		ksft_perror("Failed to open total memory bandwidth file");
 
 		return -1;
 	}
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 1cade75176eb..9b86f826a40c 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -850,7 +850,7 @@ int validate_bw_report_request(char *bw_report)
 	if (strcmp(bw_report, "total") == 0)
 		return 0;
 
-	fprintf(stderr, "Requested iMC B/W report type unavailable\n");
+	fprintf(stderr, "Requested iMC bandwidth report type unavailable\n");
 
 	return -1;
 }
-- 
2.39.2


