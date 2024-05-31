Return-Path: <linux-kselftest+bounces-11003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7B58D628C
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 15:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1753DB26BDF
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 13:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECD6158DD8;
	Fri, 31 May 2024 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DmDArlOo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E499158D85;
	Fri, 31 May 2024 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161145; cv=none; b=T/EmBmi2xxUKOffEUEpivpiCEj9J6jw6NyC9VQ/9tSd/6m88Bn3TXbLladIk2Azc7PNuKa7+9hGQfZCFJqK3WuCGygOBpISPEdmEsZmZq3tSLLJpYhCNTtQszZdudL7DMnZQqGy1XgZfb0s827JpBhdAhT+cZw61SQziuU+BjhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161145; c=relaxed/simple;
	bh=NG1uY964FSNqyOMf+sAZwD5EJEZlHVOtk1dHvmR7BEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKKnfMUSQGQN5h0JnTKRHYRUJQhZLvA5oWqSLJ5QSMAyfaHknYetqE29POsxI/YN4T5D8PCMBvjuo6hDceY/3lr/wbZlFTYUU2bMwh/tL2WzcGoJQfbnV7MUnZdcD0+5Jdcu832iLzIoKVlSYPVORxXB9xqjUk4NSPe+9x29BBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DmDArlOo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717161143; x=1748697143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NG1uY964FSNqyOMf+sAZwD5EJEZlHVOtk1dHvmR7BEc=;
  b=DmDArlOoyM/C45gmqOXKdn09dRQpuxZqsmiBN0+r4FFi8lB5GP4wasbW
   Gbd+6aARD89IXj/xUrqe3Mj7tCv6yBqJQhyJz1SWjrmEdF1riNgVsTzdg
   /GTNRAQ9pVQ6A4K7yQ+S8JFPbxo4Cu1DgkFQEpBRhceEh40OdbkjLQZMH
   N/ssc8JdDQT6yYyxrbt5AKZN/OnDMry8ibeJietlqacCrUGiUdO/k4fsb
   n9iNl+4NILlWXvi32U/D8dLw9OZ0KC9xQNqZ6qj/5xj57Nhf8GCAQPA6a
   sCW8TlaGHXsvnJ7na0UEaISDkjZ6lISgfWJ4n7sMsm6EQpX4trTpH28Er
   Q==;
X-CSE-ConnectionGUID: 3h98UQUuQQSk6ooOyC4O9w==
X-CSE-MsgGUID: beBtCp+iRzO5e+XYghxOjg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="17532520"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="17532520"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:12:23 -0700
X-CSE-ConnectionGUID: 0HnF7vpSQHiduhk6Y6xgSQ==
X-CSE-MsgGUID: rT+rkPL0TES18D2TKRrd+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36106863"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.152])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:12:19 -0700
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
Subject: [PATCH v5 03/16] selftests/resctrl: Make "bandwidth" consistent in comments & prints
Date: Fri, 31 May 2024 16:11:29 +0300
Message-Id: <20240531131142.1716-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
References: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---

v3:
- New patch
---
 tools/testing/selftests/resctrl/resctrl_val.c | 14 +++++++-------
 tools/testing/selftests/resctrl/resctrlfs.c   |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 6231275a6e6c..cb646168179e 100644
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


