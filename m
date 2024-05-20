Return-Path: <linux-kselftest+bounces-10424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BEF8C9D46
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 14:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B92F282282
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 12:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90155646D;
	Mon, 20 May 2024 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pn4TnwrM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EC755E6B;
	Mon, 20 May 2024 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208245; cv=none; b=k9MZAEQwKhwEziWMx5bwsuFGdIFEagZXIyZiqbKjwhekvNPChBI9LbR4zWfKF4eN9xrU6JcXJYjNjtPScMBWSKmkkPWSUZUK23EvRP3s82xsyFcIZI6ZY4fO6C3w9wnYGv1BzgX8rKWi7k9wxtFYw5JA04zOv0PKngu92eBVDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208245; c=relaxed/simple;
	bh=wdgylQ0cZW/zhQH3/+NSWx0tyAmUR7W4z8W2bTRAPY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6KDizB3JNqPba3KV18Uc+fSdWCAh7fMGBzmt5H2MEpQaAovNFljJBZNR1QtTRITpUnTQKmFKyNNt1wMtAL3wWVg4GrDHEwiu7vtlLU6RABjU3aW3gVkNw2yO8pZnD89wGffBy8ysJIXl66wi9HlcDk4AJq32Ii/GDe/4RqISvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pn4TnwrM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716208244; x=1747744244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wdgylQ0cZW/zhQH3/+NSWx0tyAmUR7W4z8W2bTRAPY8=;
  b=Pn4TnwrMBqCX7COuYumWkW4xJPLCRxLnc0oUqy5+dj8IvmPXrIGp/mcv
   8AqmzcSnHauH3dGv18UW94ZWp0FsPztM+Rwy0jqd9Uwy8GQEiZGhCrJ6F
   oxBu60PiMJS9OsxAEyZeT8OkOq83miPmyi8yrhUUX+U2Ihaj30nQbWZJP
   xSN2B2OUL2lxxLb/sVDwiYx9fBvlW8ITWo8dSW0UVwwf6khGu01tvJdZG
   Md/AZTP9yL46y5Hu14vnQCqw6RnAeV1i/3tDnR/sHa7AdOEIzf/QX1kIj
   FURBor+nu4esvnNQROmnglV2Erge6LFllU2HtaTr4QiRAHmwm6g3npCqe
   w==;
X-CSE-ConnectionGUID: PxHWdLoBTWWVDzJLzt648A==
X-CSE-MsgGUID: qHv0/9QtS0S8yTq1wGslYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12444532"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="12444532"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:30:44 -0700
X-CSE-ConnectionGUID: rdwgDbY0RnGxJr6wJ/C3Vg==
X-CSE-MsgGUID: 9poR2QDFT8yyYFjohmG2Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="37115264"
Received: from unknown (HELO localhost) ([10.245.247.114])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:30:40 -0700
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
Subject: [PATCH v4 01/16] selftests/resctrl: Fix closing IMC fds on error and open-code R+W instead of loops
Date: Mon, 20 May 2024 15:30:05 +0300
Message-Id: <20240520123020.18938-2-ilpo.jarvinen@linux.intel.com>
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

The imc perf fd close() calls are missing from all error paths. In
addition, get_mem_bw_imc() handles fds in a for loop but close() is
based on two fixed indexes READ and WRITE.

Open code inner for loops to READ+WRITE entries for clarity and add a
function to close() IMC fds properly in all cases.

Fixes: 7f4d257e3a2a ("selftests/resctrl: Add callback to start a benchmark")
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v4:
- Merge with the fix close patch
- Add loop to reset imc_counters_config fds to -1 to be able know which
  need closing
- Introduce perf_close_imc_mem_bw() to close fds
v3:
- Rework entirely, use open coding instead of for loops for clarity
---
 tools/testing/selftests/resctrl/resctrl_val.c | 54 ++++++++++++-------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 445f306d4c2f..f55f5989de72 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -293,6 +293,18 @@ static int initialize_mem_bw_imc(void)
 	return 0;
 }
 
+static void perf_close_imc_mem_bw(void)
+{
+	int mc;
+
+	for (mc = 0; mc < imcs; mc++) {
+		if (imc_counters_config[mc][READ].fd != -1)
+			close(imc_counters_config[mc][READ].fd);
+		if (imc_counters_config[mc][WRITE].fd != -1)
+			close(imc_counters_config[mc][WRITE].fd);
+	}
+}
+
 /*
  * get_mem_bw_imc:	Memory band width as reported by iMC counters
  * @cpu_no:		CPU number that the benchmark PID is binded to
@@ -306,26 +318,33 @@ static int initialize_mem_bw_imc(void)
 static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 {
 	float reads, writes, of_mul_read, of_mul_write;
-	int imc, j, ret;
+	int imc, ret;
+
+	for (imc = 0; imc < imcs; imc++) {
+		imc_counters_config[imc][READ].fd = -1;
+		imc_counters_config[imc][WRITE].fd = -1;
+	}
 
 	/* Start all iMC counters to log values (both read and write) */
 	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
 	for (imc = 0; imc < imcs; imc++) {
-		for (j = 0; j < 2; j++) {
-			ret = open_perf_event(imc, cpu_no, j);
-			if (ret)
-				return -1;
-		}
-		for (j = 0; j < 2; j++)
-			membw_ioctl_perf_event_ioc_reset_enable(imc, j);
+		ret = open_perf_event(imc, cpu_no, READ);
+		if (ret)
+			goto close_fds;
+		ret = open_perf_event(imc, cpu_no, WRITE);
+		if (ret)
+			goto close_fds;
+
+		membw_ioctl_perf_event_ioc_reset_enable(imc, READ);
+		membw_ioctl_perf_event_ioc_reset_enable(imc, WRITE);
 	}
 
 	sleep(1);
 
 	/* Stop counters after a second to get results (both read and write) */
 	for (imc = 0; imc < imcs; imc++) {
-		for (j = 0; j < 2; j++)
-			membw_ioctl_perf_event_ioc_disable(imc, j);
+		membw_ioctl_perf_event_ioc_disable(imc, READ);
+		membw_ioctl_perf_event_ioc_disable(imc, WRITE);
 	}
 
 	/*
@@ -341,15 +360,13 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 		if (read(r->fd, &r->return_value,
 			 sizeof(struct membw_read_format)) == -1) {
 			ksft_perror("Couldn't get read b/w through iMC");
-
-			return -1;
+			goto close_fds;
 		}
 
 		if (read(w->fd, &w->return_value,
 			 sizeof(struct membw_read_format)) == -1) {
 			ksft_perror("Couldn't get write bw through iMC");
-
-			return -1;
+			goto close_fds;
 		}
 
 		__u64 r_time_enabled = r->return_value.time_enabled;
@@ -369,10 +386,7 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 		writes += w->return_value.value * of_mul_write * SCALE;
 	}
 
-	for (imc = 0; imc < imcs; imc++) {
-		close(imc_counters_config[imc][READ].fd);
-		close(imc_counters_config[imc][WRITE].fd);
-	}
+	perf_close_imc_mem_bw();
 
 	if (strcmp(bw_report, "reads") == 0) {
 		*bw_imc = reads;
@@ -386,6 +400,10 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 
 	*bw_imc = reads + writes;
 	return 0;
+
+close_fds:
+	perf_close_imc_mem_bw();
+	return -1;
 }
 
 void set_mbm_path(const char *ctrlgrp, const char *mongrp, int domain_id)
-- 
2.39.2


