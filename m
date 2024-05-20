Return-Path: <linux-kselftest+bounces-10428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983788C9D52
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 14:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02107B21FE2
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 12:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55133612EB;
	Mon, 20 May 2024 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/q2OSFX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EB26A8AC;
	Mon, 20 May 2024 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208279; cv=none; b=jRPj6YFCUnEjDgD/LWNxz9eaxnhxeuGX6ZNkkMYEEFCgG6XXfSDGKtw0AkB7UhJrjEooasAulf/rLE8xYj0STFJgeoDKI+CZkHoTZJ/Cm1SgJktXrY+9ygsnk+aJiQs+MBrOgzenmghJHpQhOtNLuM35ITJ5NevmdWQgCg2YElk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208279; c=relaxed/simple;
	bh=OXLRHfwzhWhfF/o+k3sFxvU1ArXQmPhsk8nX+CqNWLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHDiPLMcqCgD+W2xnN0DNsFWGUUU7e9ldOU4/ZtNjRlS/LgjPCBOfr9GU1T7OBlLNPh53tgeS1Zik58ocsArWgC8nMFN+O/JgL4hwJTsuHFePoaMS1osJzzEUgz7Mfq5XhtpgnCy2EI9XiLF+4ySSDvC9BfY3XM9yKxn9XmwI94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/q2OSFX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716208278; x=1747744278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OXLRHfwzhWhfF/o+k3sFxvU1ArXQmPhsk8nX+CqNWLg=;
  b=S/q2OSFXstuVD0qwM6X0Bkysj75wxm07HxIz3bywBmHnf2HDI5U5V+h2
   e6wQWuq5ftSqyJtstq20SxWk4PKJ8XWhUdJGXR/npQU3qmclTz5K9dFZE
   PbEzS2aeFobr1maJ06Yu+RedKz4GKTbjrpBaeHYlkKUu8e6ppIAPvHglq
   mTpGpYtae3NH7tSzx7IgeSQ870vtHzveWNIwqWTVrqJT9Wlu2O+e1fHAC
   ToAGhwUPFLPI+kzT0qxMXbeGfng4yWHK9dwa0DLlQgTBWIclY2ZfP2MlE
   nOOQLMQ3KoKsEcd79lfHIWcOH8p1Ri86exh1DyIPK3Sr8zc4TTVSJIZpv
   g==;
X-CSE-ConnectionGUID: A6hzIa+9Tte4w3SxhMie2w==
X-CSE-MsgGUID: a5Z7Kz+6QhS7i/YTxAK2+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12180358"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="12180358"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:31:17 -0700
X-CSE-ConnectionGUID: lIpSSv3RSiihX+465unR8A==
X-CSE-MsgGUID: SiU3s4YXRKKwcZlDUzJZzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="33091197"
Received: from unknown (HELO localhost) ([10.245.247.114])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:31:14 -0700
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
Subject: [PATCH v4 05/16] selftests/resctrl: Use correct type for pids
Date: Mon, 20 May 2024 15:30:09 +0300
Message-Id: <20240520123020.18938-6-ilpo.jarvinen@linux.intel.com>
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
index 6ea8fd2c65cc..18bfdff78089 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -572,7 +572,7 @@ void signal_handler_unregister(void)
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


