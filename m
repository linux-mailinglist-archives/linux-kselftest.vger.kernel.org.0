Return-Path: <linux-kselftest+bounces-10426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95FA8C9D4B
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 14:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8516A282FD2
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 12:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB97856454;
	Mon, 20 May 2024 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YP/J42fq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8369556440;
	Mon, 20 May 2024 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208261; cv=none; b=WDarpAMFoRYDJG1WYOWYTZNK4Z97tzk3JR4SnSmADyk5nTPf0EaB+hDRPCaEJpCgCrCwqFPOzvh+kSNgBeTG2hVMfyRPFtDBMzBtqgkgPGGmb1jO51uOb0Fh47xMIrTTf18cNLcTV9ODy7oTmNWg7ulrVyzd7eZWttn5Bk4QqpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208261; c=relaxed/simple;
	bh=qciJp89w73IYXrwUHbmWOg2Gey9XF1Mn/Uim9/b41Og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUeTnGKjcy9h19gmr9folGHr5U5VKU+W5k72ebO8TVL+Jqb6SjJVM5F7g+V2HLVfM48zFWGA/XofqoOiMrWwPOROsuHR7zr70vayyjf5Ykm3ILD9YPbwLvTcXb4qoz39PRGbGwTmLLjWBK1s7knHtyAsmxF3CnpvCWOTCD2IJME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YP/J42fq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716208260; x=1747744260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qciJp89w73IYXrwUHbmWOg2Gey9XF1Mn/Uim9/b41Og=;
  b=YP/J42fqH5gVydWGjkc9agBnF0+n3OlTXsCIqYmylFKY4Rubx/BoNzKt
   B/Dk8KYA6197cL80BvM1AVPuLcFcZKrB0gKTMZKwDA2JzAciX6xfIHC66
   i7OZP8APJlenQx8GIMume9YyFaoMwoLLFPdykib0aTFGSOTIQFbQu1xab
   Iuv5mXKX4WuxyDJvSZED9MFuy1apHZFGnCvYfDkS6rmvPchFU7XuhW/jn
   y092rQag+efYxa3/zkh5P0ldQ33l7fGUGvF4VfMWcML6vrGTpy7GvXtXj
   hTMwEF8B4Gq0AjEx+bS/aMisK3dqF4ZTwL4ZhIetvtClCNRj2MeNSQh0p
   A==;
X-CSE-ConnectionGUID: 5sfbBTevRF6HNyL11oIG2Q==
X-CSE-MsgGUID: pWY9/B8bR1qRa3YODbDBtQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12180314"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="12180314"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:31:00 -0700
X-CSE-ConnectionGUID: WQDHJ4k+Rs6N/1R1Anz/NA==
X-CSE-MsgGUID: A2Axa0apSSCuTMtQIjbAXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="33091062"
Received: from unknown (HELO localhost) ([10.245.247.114])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:30:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 03/16] selftests/resctrl: Make "bandwidth" consistent in comments & prints
Date: Mon, 20 May 2024 15:30:07 +0300
Message-Id: <20240520123020.18938-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
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
index bd5a1cbb8a21..126a9cad588b 100644
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
 			goto close_fds;
 		}
 
 		if (read(w->fd, &w->return_value,
 			 sizeof(struct membw_read_format)) == -1) {
-			ksft_perror("Couldn't get write bw through iMC");
+			ksft_perror("Couldn't get write bandwidth through iMC");
 			goto close_fds;
 		}
 
@@ -498,7 +498,7 @@ static FILE *open_mem_bw_resctrl(const char *mbm_bw_file)
 
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


