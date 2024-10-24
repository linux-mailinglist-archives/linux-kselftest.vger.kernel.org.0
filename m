Return-Path: <linux-kselftest+bounces-20581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45139AF459
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 23:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21083B22837
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 21:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD848219C9C;
	Thu, 24 Oct 2024 21:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gbyYkxqk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91433218320;
	Thu, 24 Oct 2024 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804090; cv=none; b=Za0DnUEADlbTCQJxEAxHahsqnTZrmx3M3Ry1QdRNCnedCQ2dArrYP472Lus7YUeoDezJHZaGFYmyccsSSmrbwDBvqAiTsfS+g5iV3XTAtWljoPcHIletsvW5LP1Ing/i0CM6Ov60z+UJS803IQOwTpyxA3/3oWoaPDd6fXLcFNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804090; c=relaxed/simple;
	bh=jYJhpr/7IMJQAZ3azMO430LcvmKCQNmOW0TWywlpP9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saRsageE8Gas+FdUSeOKzsUHBA9yqWIcjWKXfG8uxgrd5NWzjrYsGniXcLwyZvjNNtjjMwkDgRsIbLWYWpJRRMqJIrbrBzuu7wXmwv5GOWXDB2BNBqtnX1lvhNokZt4pd6U28tWh8Q55nIdmAzZ2I8FEeuI0nB7NNi++a0I1xG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gbyYkxqk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729804087; x=1761340087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jYJhpr/7IMJQAZ3azMO430LcvmKCQNmOW0TWywlpP9s=;
  b=gbyYkxqkB1BmtNoetXt+ZpshD/AfhWBFHkfPgyhhHo245rOBWkGbeVqF
   v773pi1cYxQ34f5TN9zMVRmCsakut6+c6MCyqwb7IqkRZ7wqJ/TfFr4r+
   HCADwCmKYHYVUKaMdLPZTwJQ4MRE8GUo/LJ2lrp5T00JIbwqHBpFZT8f2
   ESZdtZgh253QuY1I3lIiZWlf4+UjLlF+8bMdO5PoBTeHbXspjD4ZPi86P
   RLW4qP/zc/a7zah8N5xfgivww9i+MFKATzZKicmyV6t7f57ImmtJWNnvu
   3rnAe1bBCzRBFXEK8Y5oK7QHulTm1jG/BbMY7M/KUs9faAMr5P/hV4gsq
   Q==;
X-CSE-ConnectionGUID: Zvj6B6XzT/y2/o7A9C6IAQ==
X-CSE-MsgGUID: HUG8BQ8nSFq2QKr7cFbGFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17090907"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="17090907"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:01 -0700
X-CSE-ConnectionGUID: jQTSxGgpTUGcYD4oGu9UWQ==
X-CSE-MsgGUID: f+3Irla0R5G7TkeY6WcRfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85488040"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:01 -0700
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
Subject: [PATCH V4 07/15] selftests/resctrl: Remove "once" parameter required to be false
Date: Thu, 24 Oct 2024 14:18:44 -0700
Message-ID: <131b87e57d6cfc63420dd423baf25ee21c273ea7.1729804024.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729804024.git.reinette.chatre@intel.com>
References: <cover.1729804024.git.reinette.chatre@intel.com>
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
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changes since V3:
- Add Ilpo's Reviewed-by tag.

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
2.47.0


