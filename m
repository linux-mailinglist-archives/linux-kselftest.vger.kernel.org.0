Return-Path: <linux-kselftest+bounces-17860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A80C977005
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 20:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C282883E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255BB1C1753;
	Thu, 12 Sep 2024 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gkSySwmY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324AC1C0DCB;
	Thu, 12 Sep 2024 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164299; cv=none; b=MXzWbj6EivnXiT3NYgph0WiEJ+Qclja3QLYC7O+S7y5WBkb5xdJFEC9nItOiNLhIS5+EqbeVZSfFr3DNC74/E51zYT54WTrljQX30yM/dAxEldbKbavJDbe4fh0JxO0XIrLMpnJuXuoujmFXLhInjLO/jyewt51GDDSXMhunAeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164299; c=relaxed/simple;
	bh=Lk+V5/yzZoVIGzDqm4NYAZ6qI13eEq+3/+2cSjHu8KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tT634ha+wiImuz96qzcbKaiUOcKxa+DuRQ8OWIt9J1SJ+ZOEGAowuXjGFjjAAxhJC8eyCQ5MCdCbLElKfI+7FYPZps6G0768J3OyPFuOTE0kQJJAms08Wx0o4DIoa4Zdf0p7zlD8+3O+qBitbLRdJrkWmX2FIqHr4iGldf13sVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gkSySwmY; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726164298; x=1757700298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lk+V5/yzZoVIGzDqm4NYAZ6qI13eEq+3/+2cSjHu8KM=;
  b=gkSySwmYPG/E5qxtNKjcRWtNzBim/ib5haDLFhlZb/5/HfQrjjgYFr7K
   HoQlXBiCMxGsxjciDJipM1QfJp8yoLWQje9xHO+yQM80H7rc0A08BKzsC
   KKPPBqWIEtlVBfUP8hycGOlrqA3BEVV5tzk9dJSa9kjroFkZ5iVgAPYp9
   /WVESY/6gYgLSxhELCIu2ESY9ncyw7o3m82hqnZrJTtvu5EvIN6eNmBBs
   ZYZMr/SkK8DG/poyRAykHE+HfGcSfK9OShc9T9NJU9p9Z/rkbuG0xrA7F
   Ij6V2EvTC6wDegOpzozXGr/6rwmH5PWnQrrwNFkmwXDwBauhR4C1sw40m
   w==;
X-CSE-ConnectionGUID: R1xKRkneQ9ebQfNDERKsvQ==
X-CSE-MsgGUID: bhYwNXmfQAuZ1+gr4/MFUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24976600"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24976600"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:04:53 -0700
X-CSE-ConnectionGUID: TB/Bt/BMQkmtJ3R+1Gm8VQ==
X-CSE-MsgGUID: /BCwMR2cQHO3xRk2xcoBWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67724618"
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
Subject: [PATCH V2 07/13] selftests/resctrl: Only support measured read operation
Date: Thu, 12 Sep 2024 11:13:56 -0700
Message-ID: <491d5a951751dd74ccb84e175f6dd457dbed5c31.1726164080.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726164080.git.reinette.chatre@intel.com>
References: <cover.1726164080.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CMT, MBM, and MBA tests rely on a benchmark to generate
memory traffic. By default this is the "fill_buf" benchmark that
can be replaced via the "-b" command line argument.

The original intent of the "-b" command line parameter was
to replace the default "fill_buf" benchmark, but the implementation
also exposes an alternative use case where the "fill_buf" parameters
itself can be modified. One of the parameters to "fill_buf" is the
"operation" that can be either "read" or "write" and indicates
whether the "fill_buf" should use "read" or "write" operations on the
allocated buffer.

While replacing "fill_buf" default parameters is technically possible,
replacing the default "read" parameter with "write" is not supported
because the MBA and MBM tests only measure "read" operations. The
"read" operation is also most appropriate for the CMT test that aims
to use the benchmark to allocate into the cache.

Avoid any potential inconsistencies between test and measurement by
removing code for unsupported "write" operations to the buffer.
Ignore any attempt from user space to enable this unsupported test
configuration, instead always use read operations.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- New patch.
---
 tools/testing/selftests/resctrl/fill_buf.c    | 28 ++-----------------
 tools/testing/selftests/resctrl/resctrl.h     |  2 +-
 .../testing/selftests/resctrl/resctrl_tests.c |  5 +++-
 tools/testing/selftests/resctrl/resctrl_val.c |  5 ++--
 4 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 854f0108d8e6..e4f1cea317f1 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -88,18 +88,6 @@ static int fill_one_span_read(unsigned char *buf, size_t buf_size)
 	return sum;
 }
 
-static void fill_one_span_write(unsigned char *buf, size_t buf_size)
-{
-	unsigned char *end_ptr = buf + buf_size;
-	unsigned char *p;
-
-	p = buf;
-	while (p < end_ptr) {
-		*p = '1';
-		p += (CL_SIZE / 2);
-	}
-}
-
 void fill_cache_read(unsigned char *buf, size_t buf_size, bool once)
 {
 	int ret = 0;
@@ -114,15 +102,6 @@ void fill_cache_read(unsigned char *buf, size_t buf_size, bool once)
 	*value_sink = ret;
 }
 
-static void fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
-{
-	while (1) {
-		fill_one_span_write(buf, buf_size);
-		if (once)
-			break;
-	}
-}
-
 unsigned char *alloc_buffer(size_t buf_size, int memflush)
 {
 	void *buf = NULL;
@@ -151,7 +130,7 @@ unsigned char *alloc_buffer(size_t buf_size, int memflush)
 	return buf;
 }
 
-int run_fill_buf(size_t buf_size, int memflush, int op)
+int run_fill_buf(size_t buf_size, int memflush)
 {
 	unsigned char *buf;
 
@@ -159,10 +138,7 @@ int run_fill_buf(size_t buf_size, int memflush, int op)
 	if (!buf)
 		return -1;
 
-	if (op == 0)
-		fill_cache_read(buf, buf_size, false);
-	else
-		fill_cache_write(buf, buf_size, false);
+	fill_cache_read(buf, buf_size, false);
 
 	free(buf);
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 51f5f4b25e06..ba1ce1b35699 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -142,7 +142,7 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 unsigned char *alloc_buffer(size_t buf_size, int memflush);
 void mem_flush(unsigned char *buf, size_t buf_size);
 void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
-int run_fill_buf(size_t buf_size, int memflush, int op);
+int run_fill_buf(size_t buf_size, int memflush);
 int initialize_mem_bw_imc(void);
 int measure_mem_bw(const struct user_params *uparams,
 		   struct resctrl_val_param *param, pid_t bm_pid,
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index bee4123a5a9b..60627dbae20a 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -265,13 +265,16 @@ int main(int argc, char **argv)
 			ksft_exit_fail_msg("Out of memory!\n");
 		uparams.benchmark_cmd[1] = span_str;
 		uparams.benchmark_cmd[2] = "1";
-		uparams.benchmark_cmd[3] = "0";
 		/*
+		 * Third parameter was previously used for "operation"
+		 * (read/write) of which only (now default) "read"/"0"
+		 * works.
 		 * Fourth parameter was previously used to indicate
 		 * how long "fill_buf" should run for, with "false"
 		 * ("fill_buf" will keep running until terminated)
 		 * the only option that works.
 		 */
+		uparams.benchmark_cmd[3] = NULL;
 		uparams.benchmark_cmd[4] = NULL;
 		uparams.benchmark_cmd[5] = NULL;
 	}
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 5331354aaf64..8b5973c5e934 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -622,8 +622,8 @@ int measure_mem_bw(const struct user_params *uparams,
  */
 static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 {
-	int operation, ret, memflush;
 	char **benchmark_cmd;
+	int ret, memflush;
 	size_t span;
 	FILE *fp;
 
@@ -643,9 +643,8 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 		/* Execute default fill_buf benchmark */
 		span = strtoul(benchmark_cmd[1], NULL, 10);
 		memflush =  atoi(benchmark_cmd[2]);
-		operation = atoi(benchmark_cmd[3]);
 
-		if (run_fill_buf(span, memflush, operation))
+		if (run_fill_buf(span, memflush))
 			fprintf(stderr, "Error in running fill buffer\n");
 	} else {
 		/* Execute specified benchmark */
-- 
2.46.0


