Return-Path: <linux-kselftest+bounces-17859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7B3977004
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 20:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397BE282087
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 18:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97D41C173E;
	Thu, 12 Sep 2024 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXTzZJbR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A321BFE12;
	Thu, 12 Sep 2024 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164298; cv=none; b=Rfpi1iapXL43SOyyKOwIfpEuUFu6urCsJmgjl5JinEkNuI/xYwvw+tq9JhTMvfj9l2EhiGtTDwnKO8hd6bgl6a1+YF8hek7jiRxBe2mYwcvoaZHpoG+h3UYA6+/HjMYdn3dAgnZXHqv1S6Eg7rn77wEVmHj6GveXRpBAzwm0XL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164298; c=relaxed/simple;
	bh=5P5W0kYgnMSBtMvsT2SGgLIHyLZ89ci/M47K44qbq2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgGFdjC2UOk8NJGBW4KQeiFZTH+dAE8OH4TtU+CGMMjEZwbsrptmERWRmVGXntaXOUoPlRbVGON1ywD6PHwx88XIjVylZt7BFcij3dDpifSZP8R3lOq4bCNDCZP2M9MKCMmbRGiWf+VnMsoKZXmQSTUiBpN+SkJnvq+i2rtHOtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXTzZJbR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726164297; x=1757700297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5P5W0kYgnMSBtMvsT2SGgLIHyLZ89ci/M47K44qbq2o=;
  b=FXTzZJbR7fCXJAsg1ySEMSUx5V97gfpeq5+0T3dMtqLmYO4EkvvMRXX7
   ymDADyA/Lh3NiWG6yHAYZ51/Fx3ZvRtPjZOCmYRngZbHbQk4hcWAycMfi
   qCJUN9ozmuLdNS2otVmh+vI8LSCxx3USU0zF20z2tqnHdI11NhNGw2Pzk
   42uRsKFKHD6k3KXY7DgP3P+tgu9vMD0zyUzSXx5su0OArbzm9VZQ0OkJR
   jJpuxPUXYoa2YIhymMh4YuttN4P0k9wnnd4oIV5HWCQMwYOX5nzZiKe9o
   gFo2U1JXujwnz9+OzU517xoeBtBrKYZ+S3YjM9Qh+KfL6Ni+OFNvqnrQi
   w==;
X-CSE-ConnectionGUID: l7W/plX1RhufYDb6j2B8nw==
X-CSE-MsgGUID: NBRtwcMKTSO1L5Tv2t41BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24976597"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24976597"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:04:53 -0700
X-CSE-ConnectionGUID: 1g+CQN7tTpS5Iv+jnHDJLw==
X-CSE-MsgGUID: Xmcr/F0OSWal21qmqkUqEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67724615"
Received: from b04f130c85c0.jf.intel.com (HELO rchatre-desk1.jf.intel.com) ([10.165.154.99])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:04:52 -0700
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
Subject: [PATCH V2 06/13] selftests/resctrl: Remove "once" parameter required to be false
Date: Thu, 12 Sep 2024 11:13:55 -0700
Message-ID: <1f5ad02dc424bfc3cca705ed9a322df8f35f2ff4.1726164080.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726164080.git.reinette.chatre@intel.com>
References: <cover.1726164080.git.reinette.chatre@intel.com>
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
Changes since V1:
- New patch
---
 tools/testing/selftests/resctrl/fill_buf.c      |  7 ++++---
 tools/testing/selftests/resctrl/resctrl.h       |  2 +-
 tools/testing/selftests/resctrl/resctrl_tests.c |  8 +++++++-
 tools/testing/selftests/resctrl/resctrl_val.c   | 11 +----------
 4 files changed, 13 insertions(+), 15 deletions(-)

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
index ecbb7605a981..bee4123a5a9b 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -266,7 +266,13 @@ int main(int argc, char **argv)
 		uparams.benchmark_cmd[1] = span_str;
 		uparams.benchmark_cmd[2] = "1";
 		uparams.benchmark_cmd[3] = "0";
-		uparams.benchmark_cmd[4] = "false";
+		/*
+		 * Fourth parameter was previously used to indicate
+		 * how long "fill_buf" should run for, with "false"
+		 * ("fill_buf" will keep running until terminated)
+		 * the only option that works.
+		 */
+		uparams.benchmark_cmd[4] = NULL;
 		uparams.benchmark_cmd[5] = NULL;
 	}
 
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index e88d5ca30517..5331354aaf64 100644
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
2.46.0


