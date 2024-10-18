Return-Path: <linux-kselftest+bounces-20093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D479A32BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 04:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81CE281A76
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 02:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDBE185B76;
	Fri, 18 Oct 2024 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maK/gWjk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F1D17E003;
	Fri, 18 Oct 2024 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218163; cv=none; b=lPBtPea9AHLmg+8PxiMtLIkRzRNmkqWMQMmhM8mri75J9xr3Bqn//0Wb49r0dzTAjcUROomlMyIb88tcIfsUdM5KyVWfKOUE+eEEgQmJaInapMQS+lvP+eBSROaRf5o1ZNkIyzlKxnmpkbsYIVNUezHpxR2AQIzBYz32Kux94aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218163; c=relaxed/simple;
	bh=Uy3NsyHGrTIOaOBOdWrwbIKqErrl3314XWdNn/0fdeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8s46eduxBuqehI+8k4wedNJftMTQ186z2r/w1UoDc25lkAC5Jq79hr0X3NO03RlACwxVn6DEIMqtFmbF7XiM1/JKePgW0+ccMrS0j2M2BXB6LTRmXpol6UToPGze/dQIKOM9cS5oRnewKIUO/PPqgnhp/NeuANPFhNc6HPovJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maK/gWjk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729218162; x=1760754162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uy3NsyHGrTIOaOBOdWrwbIKqErrl3314XWdNn/0fdeA=;
  b=maK/gWjkyIebFBDP5aI0bpvnd6Q2BJBym0DvNrbvm6Q7L4DO3qKiAfG2
   m0nlyVQIuP5yRASqwOF4asRFp8jd6fVqVf8fy/RCPcKk4RQnyozaW7ahu
   dIgeZIGA2PtBs4y+R3dknyEPN5EwhafpjRy3gMMvhSNIQiN4ypnfwtr8c
   31tKvsrOTrnFeaMNdjfawfnyK/5Spj7eeySFOxga2NHNaPenbUHffPt22
   20oZr5IO+Box1hV+13Y/VStb/W+tyx6EQNlRrGbOyxmLmMKMiAbfkVxLP
   JivdWDpZjOOD7kSt32a3JbGnQLjYGuWQf3g0JF+2gdCeJDA5ifdus5v0Q
   A==;
X-CSE-ConnectionGUID: ETzGKCauR7Ov9HJxHDv1Kg==
X-CSE-MsgGUID: rXpu2AwcRmiSN5mh68sCEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54149703"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="54149703"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:38 -0700
X-CSE-ConnectionGUID: h/BfrWXvQsC+rXBTnCilKA==
X-CSE-MsgGUID: yhRKHipfT7uYU6YM4e2nAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78697717"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:37 -0700
From: Reinette Chatre <reinette.chatre@intel.com>
To: fenghua.yu@intel.com,
	shuah@kernel.org,
	tony.luck@intel.com,
	peternewman@google.com,
	babu.moger@amd.com,
	ilpo.jarvinen@linux.intel.com
Cc: maciej.wieczor-retman@intel.com,
	reinette.chatre@intel.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 07/15] selftests/resctrl: Remove "once" parameter required to be false
Date: Thu, 17 Oct 2024 19:33:22 -0700
Message-ID: <8749a13135c7e66bd9d463d94b15a9214b8c4b69.1729218182.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729218182.git.reinette.chatre@intel.com>
References: <cover.1729218182.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The CMT, MBM, and MBA tests rely on a benchmark that runs while
the test makes changes to needed configuration (for example memory
bandwidth allocation) and takes needed measurements. By default
the "fill_buf" benchmark is used and by default (via its
"once = false" setting) "fill_buf" is configured to run until
terminated after the test completes.

An unintended consequence of enabling the user to override the
benchmark also enables the user to change parameters to the
"fill_buf" benchmark. This enables the user to set "fill_buf" to
only cycle through the buffer once (by setting "once = true")
and thus breaking the CMT, MBA, and MBM tests that expect
workload/interference to be reflected by their measurements.

Prevent user space from changing the "once" parameter and ensure
that it is always false for the CMT, MBA, and MBM tests.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V2:
- Remove unnecessary assignment to benchmark_cmd[5]. (Ilpo)

Changes since V1:
- New patch
---
 tools/testing/selftests/resctrl/fill_buf.c      |  7 ++++---
 tools/testing/selftests/resctrl/resctrl.h       |  2 +-
 tools/testing/selftests/resctrl/resctrl_tests.c |  9 +++++++--
 tools/testing/selftests/resctrl/resctrl_val.c   | 11 +----------
 4 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 34e5df721430..854f0108d8e6 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -151,7 +151,7 @@ unsigned char *alloc_buffer(size_t buf_size, int memflush)
 	return buf;
 }
 
-int run_fill_buf(size_t buf_size, int memflush, int op, bool once)
+int run_fill_buf(size_t buf_size, int memflush, int op)
 {
 	unsigned char *buf;
 
@@ -160,9 +160,10 @@ int run_fill_buf(size_t buf_size, int memflush, int op, bool once)
 		return -1;
 
 	if (op == 0)
-		fill_cache_read(buf, buf_size, once);
+		fill_cache_read(buf, buf_size, false);
 	else
-		fill_cache_write(buf, buf_size, once);
+		fill_cache_write(buf, buf_size, false);
+
 	free(buf);
 
 	return 0;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 2dda56084588..51f5f4b25e06 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -142,7 +142,7 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 unsigned char *alloc_buffer(size_t buf_size, int memflush);
 void mem_flush(unsigned char *buf, size_t buf_size);
 void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
-int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
+int run_fill_buf(size_t buf_size, int memflush, int op);
 int initialize_mem_bw_imc(void);
 int measure_mem_bw(const struct user_params *uparams,
 		   struct resctrl_val_param *param, pid_t bm_pid,
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index ecbb7605a981..e7878077883f 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -266,8 +266,13 @@ int main(int argc, char **argv)
 		uparams.benchmark_cmd[1] = span_str;
 		uparams.benchmark_cmd[2] = "1";
 		uparams.benchmark_cmd[3] = "0";
-		uparams.benchmark_cmd[4] = "false";
-		uparams.benchmark_cmd[5] = NULL;
+		/*
+		 * Fourth parameter was previously used to indicate
+		 * how long "fill_buf" should run for, with "false"
+		 * ("fill_buf" will keep running until terminated)
+		 * the only option that works.
+		 */
+		uparams.benchmark_cmd[4] = NULL;
 	}
 
 	ksft_set_plan(tests);
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index c9dd70ce3ea8..b0f3c594c4da 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -625,7 +625,6 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 	int operation, ret, memflush;
 	char **benchmark_cmd;
 	size_t span;
-	bool once;
 	FILE *fp;
 
 	benchmark_cmd = info->si_ptr;
@@ -645,16 +644,8 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 		span = strtoul(benchmark_cmd[1], NULL, 10);
 		memflush =  atoi(benchmark_cmd[2]);
 		operation = atoi(benchmark_cmd[3]);
-		if (!strcmp(benchmark_cmd[4], "true")) {
-			once = true;
-		} else if (!strcmp(benchmark_cmd[4], "false")) {
-			once = false;
-		} else {
-			ksft_print_msg("Invalid once parameter\n");
-			parent_exit(ppid);
-		}
 
-		if (run_fill_buf(span, memflush, operation, once))
+		if (run_fill_buf(span, memflush, operation))
 			fprintf(stderr, "Error in running fill buffer\n");
 	} else {
 		/* Execute specified benchmark */
-- 
2.46.2


