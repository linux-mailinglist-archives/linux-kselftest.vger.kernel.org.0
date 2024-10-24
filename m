Return-Path: <linux-kselftest+bounces-20582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 438C09AF45B
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 23:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5041F22107
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 21:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A573219CAF;
	Thu, 24 Oct 2024 21:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+LBriGK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD76C218D7D;
	Thu, 24 Oct 2024 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804091; cv=none; b=m4i/zOll8Pr4yfVHElpsvQyac/rtrti0TdfL34PKqSk6swoxPVfykcNFxyRA+eQhQRzbWBol1+qwSUxzXrswg8nPpA6Ja4SJIh/PWLkVjkeCMhlKAPHtdWJbn5+fjhfxfGkBB2oO6icBLh4tEMIpsOpQE2MyArP1cCN4jwIGVGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804091; c=relaxed/simple;
	bh=aQX0cjK9HHCJqQRg1lw6DusEwJtaCqS8ZGRtHEIO3g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0EOaYOzoLMmR7jU3335uES4Os353YE2pWluEKGHUrsRhl4pFBgz/VzuTRePxYXmhDybHAoYyZVZuTsAc7/dkbijJPb9OAPJfQEbC1lA07Mwx8V0gTXcgHC6lx7WrW69E7+JyySjb4ekquv42qVkrtut6GdSEiIkbJTibUZJ6so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+LBriGK; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729804089; x=1761340089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aQX0cjK9HHCJqQRg1lw6DusEwJtaCqS8ZGRtHEIO3g0=;
  b=j+LBriGKJTA18CTopVSvqPuX3yGlQzdXsHFlO20Bx+IUz5qi8Ja3wfEn
   hPfdsBGRiMfnwDJRP1HTSqwHq25cpm4EP/cua02cuF0F8k5DnolQvYL8l
   4RDkr3b9/Xf8XwBlFczX7FQGHHNrdUvY+CUPE+Rehjy5lBJuD3iXET5mt
   /imJz8m4CCAM1Lm+k9uL8JSDh49kMzGk2KP3tMK+k8C5lDK/bClQwAJ8c
   pDatM7GdJB0fVrtaOwej0FFmJCU3Nf7/KSJGZ3cHiAWy8+kfaxgk7KCbB
   kNOZr/YO8tTnE0odiYLFEYUErssKrPA/E4vEfwfVmf2CXwXbmBk4WYJz6
   g==;
X-CSE-ConnectionGUID: xCj2dOt7SQeTDSbJM/R1PQ==
X-CSE-MsgGUID: UfqdJqxyRu+Qdh6OiQwzWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17090914"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="17090914"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:01 -0700
X-CSE-ConnectionGUID: Ou62wbVTTgOA4w77/hv6Ug==
X-CSE-MsgGUID: /cwRFDxvTkumHed3dIV2tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85488044"
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
Subject: [PATCH V4 08/15] selftests/resctrl: Only support measured read operation
Date: Thu, 24 Oct 2024 14:18:45 -0700
Message-ID: <ca80dbc5d8a52645cb16cb729a2ff601ccda6be2.1729804024.git.reinette.chatre@intel.com>
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
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changes since V3:
- Add Ilpo's Reviewed-by tag.

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
2.47.0


