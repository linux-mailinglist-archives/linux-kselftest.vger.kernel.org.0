Return-Path: <linux-kselftest+bounces-7418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44AC89C9A4
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 18:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DEF7B27D35
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA97142E6C;
	Mon,  8 Apr 2024 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixvJhA/A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DB4142E61;
	Mon,  8 Apr 2024 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594069; cv=none; b=E5Ef4NAhft5YNTbTdvs10EgwKedFZxmTqbOx2921GC+jOL417HxSFjLzl/M+9+jSdxgAuS7M39lsD1quqq17Y1cojCQVGF+BhmJZbcg57+vv+qhMUgSP5WsP+IcimHVqmLb7IpuQyx+2yyk6UDJP6Fs6GcoVNhFMJTTJGraO4kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594069; c=relaxed/simple;
	bh=QpW5brB/LvcI+rpeDm/UJI1VDqdShQHuflR/NQJVaaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+mLKb4J3pbddXhJh/Rhkvd4wtZAHhPrqeBiELkOYwvLbZJjmBK0D3PsN63lk4Kt8Oa0IlhF/MZWr/t8+S8DgofkjOz+BGkv1R6vSQIpizDslQ+Myq/q3xLy7Ql0gk3B4iBdaRGdy4WPkVZgrbuq5u8Y5mNv9C8swBaVbC3pr1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixvJhA/A; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712594069; x=1744130069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QpW5brB/LvcI+rpeDm/UJI1VDqdShQHuflR/NQJVaaI=;
  b=ixvJhA/AGp+64iNCcp/nDDM9xLU6T/vFrWQi8LlCam325Ii0FwxN/q5V
   ypmAKbr4Qk2/jSGqASAjj++VMVc8KgcpaCaYMm5AVNUeBx1jZC3dzfGep
   X3AdPAugFjK/jnZjLmESuWNq7s5QIsHRqG/sdkVD61RTWwwHfTuY+nbl1
   Qx+IXtaYBpSW9vYA9B/rilcr65chHmaEKJhpjmmc0hWr2JpUKyoYW5xuQ
   XG7BfRUQNiM+TaUAoRyPzRXA5rvdi2ZypbG+j/fYeqal2KSUbUx/L+++g
   +vgVkR717YR/wQZFkAVFkD6ZSAClG3mtmJLK4Oy1GrzInLjOwmGcqVhGZ
   Q==;
X-CSE-ConnectionGUID: 6W+HkiYKQDuC/2yYodzykw==
X-CSE-MsgGUID: 5706C/blS1SPpBKupXOBKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="19315347"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19315347"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:33:50 -0700
X-CSE-ConnectionGUID: SYvaqgBmTZu5+3bWi/zjmg==
X-CSE-MsgGUID: 7xcyE4X4T+e0vxaQO7tv3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="43113574"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:33:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 06/16] selftests/resctrl: Use correct type for pids
Date: Mon,  8 Apr 2024 19:32:37 +0300
Message-Id: <20240408163247.3224-7-ilpo.jarvinen@linux.intel.com>
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
index 00d51fa7531c..e6f221236c79 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -174,8 +174,8 @@ void perf_event_initialize_read_format(struct perf_event_read *pe_read);
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
index 9753914b2250..5ef97d171cef 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -563,7 +563,7 @@ void signal_handler_unregister(void)
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


