Return-Path: <linux-kselftest+bounces-20095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 032909A32BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 04:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B790428270B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 02:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803F1188008;
	Fri, 18 Oct 2024 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejAsSolL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16B517BB0C;
	Fri, 18 Oct 2024 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218165; cv=none; b=eslfklMSWXxqTCtoZ1/0TbkzDpAevq9dcKlBtZqiYybzUR0dNRgtDzr4NcvQb0dCxL+N2ufyiVCTO7ZUd/s2XQNs7TY5tatCpYv6/sYq5fZopaRR/CX++A/Eyngq3HO4dwq6xwn1/2RW15ArdvGP63XQ96PBaLEi6Ddw6vq8DLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218165; c=relaxed/simple;
	bh=4fILn7na/aW84mv4lohoLeaRP0yj+magIYxVwwrx9U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R70sg1sZcTD2YTr/I7IK1eQ68Leq4Kx1K4zMNfF1OsNpiYDsGfoqSUDT4V6raJgoXRT5AL5q2QZn9h5HSRaYn128PjYhgk/W/KVwmyf9W2iQ68taRZ7+9JfWKp4TTlLLZVMrsAhcUuEeRBjCCvPBfPpLGAaSIf43Sl2rLMHilmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejAsSolL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729218164; x=1760754164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4fILn7na/aW84mv4lohoLeaRP0yj+magIYxVwwrx9U8=;
  b=ejAsSolLJFFiuFXnp9E5lFHh+jvt4q0YFgVNdfY8zPBBAHE0Rx80glsg
   MJERuXlnRdOO/vttNDq0ZNlQnW1XDTLbDFEhiuxMxiAc56ouAKzJg9QR9
   PrRfE6R/3IHhtiLMn9fGy7mdhD2AdCiQV1793jS5/XghC9RtJ4DnRYQYn
   Jb5ppRJeHqAq6v8++XGiehpALtpdQxp4gVJ0t3lDjgCAcAuOpL3Uid5pe
   WDUdPqwIfvzkGyA9v2Z5BM5VS5+XbbMvsfVLpe/he5lU2AYY50WskAVxv
   x2pi7fvWflbyUZS41K2NbhTq3ZAF9P8C6GXRWoOfAb70I5va10TbJe1Pg
   A==;
X-CSE-ConnectionGUID: CdDd8Tt6SkOvyIVYdPmmUw==
X-CSE-MsgGUID: 59zKvyEaQ8+lUcOAMhiRyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54149705"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="54149705"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:38 -0700
X-CSE-ConnectionGUID: S90sLa7zR0ebGd1yO543fw==
X-CSE-MsgGUID: 15JIJBfZQwy9VDmmSIP9/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78697722"
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
Subject: [PATCH V3 08/15] selftests/resctrl: Only support measured read operation
Date: Thu, 17 Oct 2024 19:33:23 -0700
Message-ID: <3e451b37bf88a96018d6ab6564dbdf2f853c86ee.1729218182.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729218182.git.reinette.chatre@intel.com>
References: <cover.1729218182.git.reinette.chatre@intel.com>
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

Keep the initialization of the, now unused, "fill_buf" parameters
to reserve these parameter positions since it has been exposed as an API.
Future parameter additions cannot use these parameter positions.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V2:
- Update changelog to justify keeping the assignment to benchmark_cmd[4].
  (Ilpo)

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
index e7878077883f..0f91c475b255 100644
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
 	}
 
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index b0f3c594c4da..113ca18d67c1 100644
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
2.46.2


