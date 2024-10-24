Return-Path: <linux-kselftest+bounces-20584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1EA9AF461
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 23:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E729283733
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 21:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC8721B426;
	Thu, 24 Oct 2024 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nXIsj4aR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2A4219CB3;
	Thu, 24 Oct 2024 21:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804094; cv=none; b=DfPAv9IM1iwwv85RYLj4nhAsbw9GKIlEvYZGjPUlStb5m3mcZsNKkqWlg70Ux+QYRxeTtClFnm7see9AJu9fckhlAhMsOyy/e/o7HgTZU6F5kXsPZ+maFoLrWj7LcpJmvArQAi2G2qWiEMk5C3cG0sqG6N9wpjoQieOFyIDao1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804094; c=relaxed/simple;
	bh=zYnxcthe37nzkFi+pQL7JPm7hpbOY3j7iCqr9ypKhq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOn84Y0FeYDk2AMoaqaQ0fJkXu+IgtmFGQvqH+93q88YJjh9tD5u5ZQx6q4XRtjun5e40ZSSe9VxY+06hUx6FPCwSxgkmjwJnEJEci5fAYnxKHhxvxCzsCDQypFy6CUJrSfX1XD6E3/oVpH0tKKt6pSwbCafCiSVug+COjUn+Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nXIsj4aR; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729804092; x=1761340092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zYnxcthe37nzkFi+pQL7JPm7hpbOY3j7iCqr9ypKhq4=;
  b=nXIsj4aRfdHd78Oia41jU8O0OMXeYKJChH3vecxtkTw+g0pInAGLoZoI
   HWkOZ0UyATr0RmDJrTUvmGMe3B7NzXJ86KTPSTVPPxQuR31xl8CAcW3YK
   tbLddY5yVyuIa4QPKU6TwxKdBQOUevLDoc7R14T6gSuoO2msmX4anIy/+
   1WDQ8Nwl5zz2KqYM4m9aCp1c/tT1bvsiBwI3rGTfZUVPEmt/NGoN0CscT
   lMcDS8QjkYrLInWOTSjcRj50mRlkOsBK6A62j2B3K/Wj9rk8sCtcNHt0J
   xVzFC5JDU3qX7yCjwARAnD4rgd8atM6Kj3Bf8DwqRaqjOeeDLH6EOoNnt
   w==;
X-CSE-ConnectionGUID: kfBsqmkPSxSzQsXWL/oI5Q==
X-CSE-MsgGUID: /MVW1pDoRr+PLA+YCCvmMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17090922"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="17090922"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:01 -0700
X-CSE-ConnectionGUID: QkZ/ri0cRsWHoliKeEr2LQ==
X-CSE-MsgGUID: 4fvVJcbWRuaUl9Mp79RGCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85488057"
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
Subject: [PATCH V4 12/15] selftests/resctrl: Use cache size to determine "fill_buf" buffer size
Date: Thu, 24 Oct 2024 14:18:49 -0700
Message-ID: <8664a46c42a66f0a767fb8d461a2eff86a4c0bee.1729804024.git.reinette.chatre@intel.com>
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
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changes since V3:
- Add Ilpo's Reviewed-by tag.

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
index 24daf76b4039..3335af815b21 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -189,7 +189,7 @@ static struct fill_buf_param *alloc_fill_buf_param(struct user_params *uparams)
 			ksft_exit_skip("Unable to parse benchmark buffer size.\n");
 		}
 	} else {
-		fill_param->buf_size = DEFAULT_SPAN;
+		fill_param->buf_size = MINIMUM_SPAN;
 	}
 
 	if (uparams->benchmark_cmd[2] && *uparams->benchmark_cmd[2] != '\0') {
-- 
2.47.0


