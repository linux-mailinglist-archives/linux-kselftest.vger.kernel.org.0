Return-Path: <linux-kselftest+bounces-11362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D017D90040F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 14:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AFD91F24859
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 12:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F59819408E;
	Fri,  7 Jun 2024 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QonDSOGU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B3019307F;
	Fri,  7 Jun 2024 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764833; cv=none; b=of/Wm531C5Ljv+PWSHAqD9lsz+oLde3dNHkrjAEhztmDDLpna8qBgP/v4raVnIK40BPzsj+YcuZS+XZGYu/AJ6P9/4pDV5WHGfUE8LYWcNT6NRiUyMW0jW/5ye8ZafkCpp7bvw0ccic2r0IIRCOkuLcPn0z78PmtoifHxdL5Bkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764833; c=relaxed/simple;
	bh=HHtF8o07l8NToXdH2Mf4stPkmOXSRC7X31A90PY0ihw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bhxib0fumQa15ZvdoMFzzoQBGIAbOiDYrAevd7c1kEEB3sHTBtPqPhhgu8u1tNiFZfZCn7Wu3N3qBbjn+7cwlx4HN86elDtzqJKSbJBfUS0PxPAN2U5pvdl8rKXCRAkNKo7VF4quxaD5DIyZq4XJplv5sf4+A8Tbk2m4oHkxk/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QonDSOGU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717764832; x=1749300832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HHtF8o07l8NToXdH2Mf4stPkmOXSRC7X31A90PY0ihw=;
  b=QonDSOGUvcB8VwIZGX2/vcXgEZy7QH9D9E6PPNsXPfmKybW3B2jN47pm
   JPQWBqTN1I08mxW7Dz9Y++3S6nNZPRIPVmW0aupb2x8jCp51ijTHM58jg
   B6cLU8hIv/fTMkI1EmTe6B4pAPv/RSsG9OT7taaRv/0BRL09QqG599uoK
   JcvuR/IdT4qvBce0cxQdgIrRNODxa8QhIyYzW0EVnAHufSkvKOCyi+zxQ
   vnyKd8hg2Ge7MYK7lA3+KgRE4hN/HZsTlOe6bpzfHdKHAmV1Fv29Qa7WD
   fFuQBxupnh1xYdTnnDSkv4Kgp1T8PM4Tf2KXRTBF2d4CRUQWb0pu0Lut/
   A==;
X-CSE-ConnectionGUID: PU7wm/jOT9Cjz9c6PpzkpQ==
X-CSE-MsgGUID: cxEueNrGS+a+UOO3wW2biA==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="25110863"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="25110863"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:53:51 -0700
X-CSE-ConnectionGUID: UvKs85Q7SgOYEQpOuUbXqg==
X-CSE-MsgGUID: f5hm1kRORcaVN2BgM0sbhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38237479"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.184])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:53:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Babu Moger <babu.moger@amd.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 03/16] selftests/resctrl: Make "bandwidth" consistent in comments & prints
Date: Fri,  7 Jun 2024 15:53:03 +0300
Message-Id: <20240607125316.7089-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607125316.7089-1-ilpo.jarvinen@linux.intel.com>
References: <20240607125316.7089-1-ilpo.jarvinen@linux.intel.com>
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
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---

v3:
- New patch
---
 tools/testing/selftests/resctrl/resctrl_val.c | 14 +++++++-------
 tools/testing/selftests/resctrl/resctrlfs.c   |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 1575c5c09ac7..9979879eda74 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -361,11 +361,11 @@ static void do_imc_mem_bw_test(void)
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
@@ -379,7 +379,7 @@ static int get_mem_bw_imc(char *bw_report, float *bw_imc)
 
 	/*
 	 * Get results which are stored in struct type imc_counter_config
-	 * Take over flow into consideration before calculating total b/w
+	 * Take overflow into consideration before calculating total bandwidth.
 	 */
 	for (imc = 0; imc < imcs; imc++) {
 		struct imc_counter_config *r =
@@ -389,13 +389,13 @@ static int get_mem_bw_imc(char *bw_report, float *bw_imc)
 
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
 
@@ -492,7 +492,7 @@ static FILE *open_mem_bw_resctrl(const char *mbm_bw_file)
 
 	fp = fopen(mbm_bw_file, "r");
 	if (!fp)
-		ksft_perror("Failed to open total bw file");
+		ksft_perror("Failed to open total memory bandwidth file");
 
 	return fp;
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


