Return-Path: <linux-kselftest+bounces-6097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3305B87651D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 14:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9961F23265
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 13:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CE6381A1;
	Fri,  8 Mar 2024 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qiok1CKC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7068723767;
	Fri,  8 Mar 2024 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904235; cv=none; b=UocFkjCIpKSDS0XCMBXJKgeqPvnILT3YG0p2rNiX3uM8ZjY5x+dhmIstWbNJzhAca7UZn6k89fWCzs8OfTPkQ6el2hYT6evFXSbwCsuh9yckoAllYuTAotmfVT6bNw1eXJ9Rvp+Adm+PU3cIHEuRQrNzKRr3NcPOAoD5BA2+HXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904235; c=relaxed/simple;
	bh=UwT8iBT61ZkB/O2eyhYFsYiBKuijPzZksRKeyKnS+y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IhCNxCkh3N977BSa70LkZ7lUgrnIBW9FynYBiMcGQNVLBCxILgICeRx3ylJASEGX5AYPM/0fflQhlMB4WgGmMK27hbH0B/Nm0LNsaXf0uYFS17TFIjNe8H681BiMviSei4t+3fEMhwNj+oj9/WYwyNL8wwbqOcgkiB0hSP1NqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qiok1CKC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709904234; x=1741440234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UwT8iBT61ZkB/O2eyhYFsYiBKuijPzZksRKeyKnS+y0=;
  b=Qiok1CKCP0GUv2nlH9fDwRV/8ifqzb/dSjdRE41fsZ4lO+JG7Jd/5QWm
   x2XWiMe9w2xjDLm1I5ffYeACB3oVtur9bXJHCL/Rs7KXQXccLkc4fElAK
   dgJ8aISfTcp/vAWeCygJ5TzaLqQkGIHiVxfpHfcBB4Dfs4QAPBfWzU3Fs
   janX15Fxnt2XiPSx9BfAqqHFmMtZCZ7eV8i/J/X95mXOY1vHaGmmVRzk2
   vmU5pMZrRTBCiPonQsSsLzAmNtc3fIhuStmMEnY0j5NK63/fdc+DHVm5A
   rrVjkqjgHxlYF99CkL2o43JXZo1wBWonZ/cYRz+ZPKELZBkg8IvR2W1kF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4801430"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4801430"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:23:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10505939"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:23:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 04/13] selftests/resctrl: Use correct type for pids
Date: Fri,  8 Mar 2024 15:22:46 +0200
Message-Id: <20240308132255.14442-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308132255.14442-1-ilpo.jarvinen@linux.intel.com>
References: <20240308132255.14442-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A few functions receive PIDs through int arguments. PIDs variables
should be of type pid_t, not int.

Convert pid arguments from int to pid_t.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c       | 6 +++---
 tools/testing/selftests/resctrl/resctrl.h     | 4 ++--
 tools/testing/selftests/resctrl/resctrl_val.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 1b339d6bbff1..9b74fce80037 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -101,7 +101,7 @@ static int get_llc_occu_resctrl(unsigned long *llc_occupancy)
  *
  * Return:		0 on success, < 0 on error.
  */
-static int print_results_cache(const char *filename, int bm_pid, __u64 llc_value)
+static int print_results_cache(const char *filename, pid_t bm_pid, __u64 llc_value)
 {
 	FILE *fp;
 
@@ -133,7 +133,7 @@ static int print_results_cache(const char *filename, int bm_pid, __u64 llc_value
  * Return: =0 on success. <0 on failure.
  */
 int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
-		       const char *filename, int bm_pid)
+		       const char *filename, pid_t bm_pid)
 {
 	int ret;
 
@@ -161,7 +161,7 @@ int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
  *
  * Return: =0 on success. <0 on failure.
  */
-int measure_llc_resctrl(const char *filename, int bm_pid)
+int measure_llc_resctrl(const char *filename, pid_t bm_pid)
 {
 	unsigned long llc_occu_resc = 0;
 	int ret;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index c52eaf46f24d..84d18d66dab2 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -171,8 +171,8 @@ void perf_event_initialize_read_format(struct perf_event_read *pe_read);
 int perf_open(struct perf_event_attr *pea, pid_t pid, int cpu_no);
 int perf_event_reset_enable(int pe_fd);
 int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
-		       const char *filename, int bm_pid);
-int measure_llc_resctrl(const char *filename, int bm_pid);
+		       const char *filename, pid_t bm_pid);
+int measure_llc_resctrl(const char *filename, pid_t bm_pid);
 void show_cache_info(int no_of_bits, __u64 avg_llc_val, size_t cache_span, bool lines);
 
 /*
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 7981589f4db0..07fd57d8d125 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -545,7 +545,7 @@ void signal_handler_unregister(void)
  *
  * Return:		0 on success, < 0 on error.
  */
-static int print_results_bw(char *filename,  int bm_pid, float bw_imc,
+static int print_results_bw(char *filename, pid_t bm_pid, float bw_imc,
 			    unsigned long bw_resc)
 {
 	unsigned long diff = fabs(bw_imc - bw_resc);
-- 
2.39.2


