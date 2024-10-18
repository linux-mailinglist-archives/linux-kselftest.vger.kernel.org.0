Return-Path: <linux-kselftest+bounces-20097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8739E9A32C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 04:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39DD81F24337
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 02:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C4E18801A;
	Fri, 18 Oct 2024 02:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bssk2wt/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B4B188012;
	Fri, 18 Oct 2024 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218167; cv=none; b=V4OwmjKr5+oAkR9aasX4ebfnxHEtdZbX4Axs46jkpUpjvvFqOXPpoSvHyzhp0eOAggbzWO/6exUPLidFq2sApaQ+9jw+lkqSkbHveBqwomG/hJMqHBGksQrJkNEgsj2oJ+A/nLAta1DxTT1jJTlH2s3+KnhdH3FpkCNBMij28Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218167; c=relaxed/simple;
	bh=LF2o/Era7xSNvAB0Kk818hm/mieubwe/KElr/Vt+Yrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZmgtcbK1aH9s6gf2SH4eY5t5mSfakUTAvbqWrEkmXtWrJsS7nQeEWbEb2oITIC7ICZ1p1IWWUDXD38DKzd/aUdou0DyUknON2p9HJROZbnOZ/CpWx55D00ZSL9cpRJD4RwcUwPp9DqNrrgE2RvIyxuNHmzxp7iVGsxZO8vHnnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bssk2wt/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729218166; x=1760754166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LF2o/Era7xSNvAB0Kk818hm/mieubwe/KElr/Vt+Yrg=;
  b=Bssk2wt/5+BBZC2m6G1Qpwvqiz86nvl9nmbfCvXIVJ7/gO+o8er+0Gzt
   9ArzQLaIgRzYAipBAefPmh8AorQvjLIOMzip6FtwCmOQkvQ8bmsxJoAEi
   wT+b0uGdX3rhY1YrTtp+MtO7BlLPojqLlMsKXfCL/ysvZcyeEPzmSMXU8
   n5dTNBua7HsQ249S1aTzVOtqRcmh9SXbWLJI5a1tEx7gi2oi7vf4pvjVU
   fHaVUD8YyXFwUsW7qp0AvdldbxYVDI7aR1vpNQnK2IBpOv4JQoziGybK9
   8G9b+GiAjfUd0cJS/8/DGmuuz6DFkonVWJ02eh9er3gUKoP34JTHU297w
   A==;
X-CSE-ConnectionGUID: l+ZA4yaURSqE7EuYrKq1Cg==
X-CSE-MsgGUID: LBolW/dIQYaM9WY1mqeNUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54149720"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="54149720"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:38 -0700
X-CSE-ConnectionGUID: 7SRKs+ZNRDmg0VmC5TZpjw==
X-CSE-MsgGUID: KLZW7h8zS5SbNpsazrYVrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78697734"
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
Subject: [PATCH V3 12/15] selftests/resctrl: Use cache size to determine "fill_buf" buffer size
Date: Thu, 17 Oct 2024 19:33:27 -0700
Message-ID: <388c93423d9a071f5877f3edb4f55ef64bf384bc.1729218182.git.reinette.chatre@intel.com>
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

By default the MBM and MBA tests use the "fill_buf" benchmark to
read from a buffer with the goal to measure the memory bandwidth
generated by this buffer access.

Care should be taken when sizing the buffer used by the "fill_buf"
benchmark. If the buffer is small enough to fit in the cache then
it cannot be expected that the benchmark will generate much memory
bandwidth. For example, on a system with 320MB L3 cache the existing
hardcoded default of 250MB is insufficient.

Use the measured cache size to determine a buffer size that can be
expected to trigger memory access while keeping the existing default
as minimum, now renamed to MINIMUM_SPAN, that has been appropriate for
testing so far.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V2:
- Move duplicate code into helper. (Ilpo)
- Rename DEFAULT_SPAN to MINIMUM_SPAN to reflect its new purpose. (Ilpo)
- Do _not_ add Ilpo's Reviewed-by tag ... the patch changed too much.

Changes since V1:
- Ensure buffer is at least double L3 cache size. (Ilpo)
- Support user override of default buffer size. (Ilpo)
---
 tools/testing/selftests/resctrl/fill_buf.c      | 13 +++++++++++++
 tools/testing/selftests/resctrl/mba_test.c      |  7 ++++++-
 tools/testing/selftests/resctrl/mbm_test.c      |  7 ++++++-
 tools/testing/selftests/resctrl/resctrl.h       |  3 ++-
 tools/testing/selftests/resctrl/resctrl_tests.c |  2 +-
 5 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 380cc35f10c6..19a01a52dc1a 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -129,3 +129,16 @@ unsigned char *alloc_buffer(size_t buf_size, bool memflush)
 
 	return buf;
 }
+
+ssize_t get_fill_buf_size(int cpu_no, const char *cache_type)
+{
+	unsigned long cache_total_size = 0;
+	int ret;
+
+	ret = get_cache_size(cpu_no, cache_type, &cache_total_size);
+	if (ret)
+		return ret;
+
+	return cache_total_size * 2 > MINIMUM_SPAN ?
+			cache_total_size * 2 : MINIMUM_SPAN;
+}
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 74d95c460bd0..bf37f3555660 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -182,7 +182,12 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 		fill_buf.memflush = uparams->fill_buf->memflush;
 		param.fill_buf = &fill_buf;
 	} else if (!uparams->benchmark_cmd[0]) {
-		fill_buf.buf_size = DEFAULT_SPAN;
+		ssize_t buf_size;
+
+		buf_size = get_fill_buf_size(uparams->cpu, "L3");
+		if (buf_size < 0)
+			return buf_size;
+		fill_buf.buf_size = buf_size;
 		fill_buf.memflush = true;
 		param.fill_buf = &fill_buf;
 	}
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 72261413c868..4224f8ce3538 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -149,7 +149,12 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 		fill_buf.memflush = uparams->fill_buf->memflush;
 		param.fill_buf = &fill_buf;
 	} else if (!uparams->benchmark_cmd[0]) {
-		fill_buf.buf_size = DEFAULT_SPAN;
+		ssize_t buf_size;
+
+		buf_size = get_fill_buf_size(uparams->cpu, "L3");
+		if (buf_size < 0)
+			return buf_size;
+		fill_buf.buf_size = buf_size;
 		fill_buf.memflush = true;
 		param.fill_buf = &fill_buf;
 	}
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 032cd9ebd761..a553fe975938 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -41,7 +41,7 @@
 
 #define BENCHMARK_ARGS		64
 
-#define DEFAULT_SPAN		(250 * MB)
+#define MINIMUM_SPAN		(250 * MB)
 
 /*
  * fill_buf_param:	"fill_buf" benchmark parameters
@@ -169,6 +169,7 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 unsigned char *alloc_buffer(size_t buf_size, bool memflush);
 void mem_flush(unsigned char *buf, size_t buf_size);
 void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
+ssize_t get_fill_buf_size(int cpu_no, const char *cache_type);
 int initialize_read_mem_bw_imc(void);
 int measure_read_mem_bw(const struct user_params *uparams,
 			struct resctrl_val_param *param, pid_t bm_pid);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 88768f4d4961..790f4eb7871a 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -189,7 +189,7 @@ static struct fill_buf_param *alloc_fill_buf_param(struct user_params *uparams)
 			ksft_exit_skip("Unable to parse benchmark buffer size.\n");
 		}
 	} else {
-		fill_param->buf_size = DEFAULT_SPAN;
+		fill_param->buf_size = MINIMUM_SPAN;
 	}
 
 	if (uparams->benchmark_cmd[2]) {
-- 
2.46.2


