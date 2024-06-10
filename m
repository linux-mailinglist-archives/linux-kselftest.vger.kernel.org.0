Return-Path: <linux-kselftest+bounces-11560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE381902538
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 17:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0997FB250CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 15:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B96B13FD84;
	Mon, 10 Jun 2024 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dfZV4kER"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7808C13D63E;
	Mon, 10 Jun 2024 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032537; cv=none; b=SJfS8SLL3W+82kUdq1LiLqcj0N/hegywklIU32HV/ONNj7cvW09YfGZiEYEpJFhBkYrfr7E2bItFx+B14jnfjlGY3jib7BYSzWu737r8wYviehqk20nWW/90IVX5Q3ywWex2AId/wc2IRdP0ekEID/Pc+NiSsfqRR+KPEQL5K8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032537; c=relaxed/simple;
	bh=txOdnyzOZSlUtJWZAp7znb1Tmc2oa6fkNXyfq6rUxzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9nbcWfEHxnICyZyixvWaA/7pJrPUqg2I+DoMYrVPmQKljSyNhgIjDsZ6Skk/OBoKFj6Z+vP0XkVBGKJMZlNiRtkKw0pdZi0IxAujmYxA3z+1JfGCtQCxzO6X4b+mQ0skNXS+bxvkSPDgQJWR1lO1dMGJnEA1SAzru7dJ5xR2pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dfZV4kER; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718032535; x=1749568535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=txOdnyzOZSlUtJWZAp7znb1Tmc2oa6fkNXyfq6rUxzM=;
  b=dfZV4kERZq2GvxGuCCN81X8hKmXkDJp3AQfXZy4s5VZWS6+234BT3w09
   7oBOCjl1ykgq4OD1SyQY1xbp1cViKcUEUwhPwc2EE+FVahw4HIKfNKgj5
   kObGrpezo0vuDq4idl+yNgxS0Hi2+Y3PSdsXidZ0upUl+QYHgqXTVS0cJ
   JWhGYAPvqNJwYxpdigpS2V0uFDE+SRkWx+RvBeApdwHx5VLITmpgRCTwn
   jHPqPwGfx+wxc0INHauf/9OscgwZ61krDZJfpRpmax5IEIj+eOep+48zP
   bwdkxudDzqP/8jdbIa4cJwi2LC1cdjBdaASnj78SA5cOdhXU8lhI4P0Rl
   A==;
X-CSE-ConnectionGUID: 4S6hxvVORmC7WRwpkf51bQ==
X-CSE-MsgGUID: sivjGbmYTB2vAhNqoiqf8w==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18530775"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="18530775"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:15:35 -0700
X-CSE-ConnectionGUID: U7+C+GMgQEWFZgghv240MA==
X-CSE-MsgGUID: kUSsJ7ggSvylhh3XsxYO3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39650649"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.194])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:15:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v7 03/16] selftests/resctrl: Make "bandwidth" consistent in comments & prints
Date: Mon, 10 Jun 2024 18:14:44 +0300
Message-Id: <20240610151457.7305-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
References: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
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
index 3c7f6793c261..5fad7e757af3 100644
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


