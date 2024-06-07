Return-Path: <linux-kselftest+bounces-11360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA02490040B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 14:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25571C21B52
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 12:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CA218F2D9;
	Fri,  7 Jun 2024 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6DL9+qv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883804AEC3;
	Fri,  7 Jun 2024 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764816; cv=none; b=fIgibGmwXa+h6RV+vQmwY/pnNemqQjJDgHpl44qCd3fsAKqPSMt4IuVAD1Lo4exVGl3PhMHZqGhRW2pBLXqDPhZJPZjDNWAWKSM/eL5zcuaWgqChD0gxix6gvRbGMyYYvxnz/R55DvTVj/JBDHJ7e1PwhUXKOeVpjNVifH6q2vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764816; c=relaxed/simple;
	bh=4/Qp8u2h+IfawVv608B46Hfr/DmfJXUXdWM5x/4OihA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPl+WjCwypNwUMxcFbhLeH1ON/gc6s0huypXxATGBPbcqNd1RGZs4msVli3rBgn4gPYb6wedzUpuEv/o8R8MNdz13zNJqgq6TT2WpbL+Cw3wN62GL5RY5ACHbJ+g+37xJIE08XJ3yq1m8o6HQo3lwRTgXBxHJ47oJypu8cei9NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6DL9+qv; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717764815; x=1749300815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4/Qp8u2h+IfawVv608B46Hfr/DmfJXUXdWM5x/4OihA=;
  b=T6DL9+qvW795ldMNvp2dJUoOZhQ57eC92LmSifY3TuSC+J2zfHUOgZSs
   fmOxrGnHwHI7flr5+qTJNrR2E5TVerlEoONioHhxJl80TA04R6pu6kPsw
   ZoNHGpqi8lHsxDn7XC2pOdTbHKtCxiRwq0bA4+4dzWmbTH7tnVmAxYxeE
   klBlkPqI4dkhH9Xv/MrBJkNDvuEu7qkK3mLlNFoX/MxlqhoF/87VldVgs
   GfnkKjM/2sSnZpoDd4CoXOedgKCAuRPIjj4d0GpubYSDimCfKnRCDJKRk
   yHpEeW9X2O8tQIEs3DCuGOeYnDs54wJ+TLLd5LjaLWukQ3FRtvpxZ3Jtp
   g==;
X-CSE-ConnectionGUID: 321mGk0/TDmKCS/Bz14k2A==
X-CSE-MsgGUID: fhy5oz3yT5OjM8ZY7wBbrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14708789"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14708789"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:53:34 -0700
X-CSE-ConnectionGUID: zW7QvzuXSq6k/QdN272Tbg==
X-CSE-MsgGUID: +4HcuEXQT2C2IU2m2+f/iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="69104494"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.184])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:53:31 -0700
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
Subject: [PATCH v6 01/16] selftests/resctrl: Fix closing IMC fds on error and open-code R+W instead of loops
Date: Fri,  7 Jun 2024 15:53:01 +0300
Message-Id: <20240607125316.7089-2-ilpo.jarvinen@linux.intel.com>
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

The imc perf fd close() calls are missing from all error paths. In
addition, get_mem_bw_imc() handles fds in a for loop but close() is
based on two fixed indexes READ and WRITE.

Open code inner for loops to READ+WRITE entries for clarity and add a
function to close() IMC fds properly in all cases.

Fixes: 7f4d257e3a2a ("selftests/resctrl: Add callback to start a benchmark")
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
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


