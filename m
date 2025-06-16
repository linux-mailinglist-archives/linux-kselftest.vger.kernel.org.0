Return-Path: <linux-kselftest+bounces-35057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C976ADAB34
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 10:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49B1188E488
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 08:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCC527056B;
	Mon, 16 Jun 2025 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gywVRQ3Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3772CA6;
	Mon, 16 Jun 2025 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064081; cv=none; b=suUHEuPnwgzz9jyOuCJZRAfstEWI/R3zBOLvGgrhtgOTKZzO1dpayn3SsgiveC0YMSkDHt0/XY6Am0SmbnTx539vuJze0k3IVncHc3MzRNZICv8Ny5WWBSmexcnkp+asLcgjsMbTuXAle94SU58OKZuV4cL2HvP4bAcgdHZRero=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064081; c=relaxed/simple;
	bh=otw8I+8W1B239RmxBQSKF1BU6xwz8WJKADiUDu222fs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jm4hptYS3f6/3yl4iQUSqpiTQKi665F6/2SKiUIY7FqQPSOp3c64m/u4h//HfQfHIVpX33PlUWMAV4TfccQWqlgw2zPkC6eQxc2T2a9hNiByJIPg7g3Ye11/pvJJ/d5+UgFCGyTopluyAuDhXZ7JLOIN0uudBqAOg4ygoHQQuY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gywVRQ3Z; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750064080; x=1781600080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=otw8I+8W1B239RmxBQSKF1BU6xwz8WJKADiUDu222fs=;
  b=gywVRQ3Zyuaref8/ZS6iOJjXsMrdBhPS9H3Z82sd39AbnsHDM0TdXuwL
   0A+72m3UKp/TTLooZoV03kYmYyE0ZocRynawN0OCiZvuNzkRNQW9v1izr
   XdntWY8Gl7XwbjlZW2k2yIGfSf6xu0qTQw8RHRLOq30i7nX+dzi6JxZqU
   Ye1Qr+cNqtpQ4Fy/pm/NOQHrCA4Wlf6zV9S52eX6E2XropaYUn6ysx/xv
   Kxot01e1ppLKCVPnjhJHpgJ2UBDCnJ0Ifi6fZxkZp8l2koILLVDYqHrQ5
   qA4B1SLeAcIxu8p13iWh6dpebrb/pYxMoboIcyx9IIbbSx9Fs4dzr/bLo
   w==;
X-CSE-ConnectionGUID: uZgjAKfNR7iGFWRcPKtfEA==
X-CSE-MsgGUID: RqDGJctOSlO09PA8eOoZTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52344546"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="52344546"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 01:54:39 -0700
X-CSE-ConnectionGUID: SPbYS+9sSXSlp8aZezGOJQ==
X-CSE-MsgGUID: bXILv3N6Q8iiRtWRw4SinQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148245590"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 01:54:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC PATCH v1 2/2] kselftest/resctrl: Add L3 CAT CBM functional test for Intel RDT
Date: Mon, 16 Jun 2025 11:24:53 +0300
Message-Id: <20250616082453.3725-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250616082453.3725-1-ilpo.jarvinen@linux.intel.com>
References: <20250616082453.3725-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Resctrl CAT selftests have been limited to mainly testing performance.
In order to validate the kernel side behavior better, add a functional
test that checks the MSR contents (if MSRs are accessible). As the
low-level mapping is architecture specific, this test is currently
limited to testing resctrl only on Intel CPUs.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c    | 126 ++++++++++++++++++
 tools/testing/selftests/resctrl/msr.c         |  55 ++++++++
 tools/testing/selftests/resctrl/resctrl.h     |   4 +
 .../testing/selftests/resctrl/resctrl_tests.c |   1 +
 4 files changed, 186 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/msr.c

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 78cb9ac90bb1..fbe1d2f7657f 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -9,8 +9,15 @@
  *    Fenghua Yu <fenghua.yu@intel.com>
  */
 #include "resctrl.h"
+
+#include <string.h>
 #include <unistd.h>
 
+#define MSR_IA32_PQR_ASSOC	0xc8f
+#define  MSR_IA32_PQR_ASSOC_COS	0xffffffff00000000ULL
+
+#define MSR_IA32_L3_CBM_BASE	0xc90
+
 #define RESULT_FILE_NAME	"result_cat"
 #define NUM_OF_RUNS		5
 
@@ -452,6 +459,116 @@ static int cat_ctrlgrp_tasks_test(const struct resctrl_test *test,
 	return ret;
 }
 
+static int cat_ctrlgrp_check_msr(const struct user_params *uparams,
+				 unsigned long mask)
+{
+	__u64 msr_val;
+	__u32 clos;
+	int ret;
+
+	ret = read_msr(uparams->cpu, MSR_IA32_PQR_ASSOC, &msr_val);
+	if (ret)
+		return -1;
+
+	clos = (msr_val & MSR_IA32_PQR_ASSOC_COS) >> (ffsl(MSR_IA32_PQR_ASSOC_COS) - 1);
+
+	ret = read_msr(uparams->cpu, MSR_IA32_L3_CBM_BASE + clos, &msr_val);
+	if (ret)
+		return -1;
+
+	if (msr_val != mask) {
+		ksft_print_msg("Incorrect CBM mask %llx, should be %lx\n",
+			       msr_val, mask);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int cat_ctrlgrp_msr_test(const struct resctrl_test *test,
+				const struct user_params *uparams)
+{
+	unsigned long mask1 = 0x3, mask2 = 0x6, mask3 = 0x0c;
+	cpu_set_t old_affinity;
+	char schemata[64];
+	pid_t bm_pid;
+	int ret;
+
+	bm_pid = getpid();
+
+	if (!msr_access_supported(uparams->cpu)) {
+		ksft_test_result_skip("Cannot access MSRs\n");
+		return 0;
+	}
+
+	ret = resctrl_grp_has_task(NULL, bm_pid);
+	if (ret < 0)
+		return ret;
+	if (!ret) {
+		ksft_print_msg("PID not found in the root group\n");
+		return 1;
+	}
+
+	/* Taskset benchmark to specified CPU */
+	ksft_print_msg("Placing task to ctrlgrp 'c1'\n");
+	ret = taskset_benchmark(bm_pid, uparams->cpu, &old_affinity);
+	if (ret)
+		return ret;
+	ret = write_bm_pid_to_resctrl(bm_pid, "c1", NULL);
+	if (ret)
+		goto reset_affinity;
+	snprintf(schemata, sizeof(schemata), "%lx", mask1);
+	ret = write_schemata("c1", schemata, uparams->cpu, test->resource);
+	if (ret)
+		goto reset_affinity;
+	ret = cat_ctrlgrp_check_msr(uparams, mask1);
+	if (ret)
+		goto reset_affinity;
+
+	ksft_print_msg("Placing task to ctrlgrp 'c2'\n");
+	ret = write_bm_pid_to_resctrl(bm_pid, "c2", NULL);
+	if (ret)
+		goto reset_affinity;
+	snprintf(schemata, sizeof(schemata), "%lx", mask2);
+	ret = write_schemata("c2", schemata, uparams->cpu, test->resource);
+	if (ret)
+		goto reset_affinity;
+	ret = cat_ctrlgrp_check_msr(uparams, mask2);
+	if (ret)
+		goto reset_affinity;
+
+	ksft_print_msg("Adjusting CBM for unrelated ctrlgrp 'c1'\n");
+	snprintf(schemata, sizeof(schemata), "%lx", mask3);
+	ret = write_schemata("c1", schemata, uparams->cpu, test->resource);
+	if (ret)
+		goto reset_affinity;
+	ret = cat_ctrlgrp_check_msr(uparams, mask2);
+	if (ret)
+		goto reset_affinity;
+
+	ksft_print_msg("Adjusting CBM for ctrlgrp 'c2'\n");
+	snprintf(schemata, sizeof(schemata), "%lx", mask1);
+	ret = write_schemata("c2", schemata, uparams->cpu, test->resource);
+	if (ret)
+		goto reset_affinity;
+	ret = cat_ctrlgrp_check_msr(uparams, mask1);
+	if (ret)
+		goto reset_affinity;
+
+	ksft_print_msg("Placing task to ctrlgrp 'c1'\n");
+	ret = write_bm_pid_to_resctrl(bm_pid, "c1", NULL);
+	if (ret)
+		goto reset_affinity;
+	ret = cat_ctrlgrp_check_msr(uparams, mask3);
+	if (ret)
+		goto reset_affinity;
+
+reset_affinity:
+	taskset_restore(bm_pid, &old_affinity);
+
+	return ret;
+}
+
 struct resctrl_test l3_cat_test = {
 	.name = "L3_CAT",
 	.group = "CAT",
@@ -484,3 +601,12 @@ struct resctrl_test cat_grp_tasks_test = {
 	.feature_check = test_resource_feature_check,
 	.run_test = cat_ctrlgrp_tasks_test,
 };
+
+struct resctrl_test cat_grp_mask_test = {
+	.name = "CAT_GROUP_MASK",
+	.group = "CAT",
+	.resource = "L3",
+	.vendor_specific = ARCH_INTEL,
+	.feature_check = test_resource_feature_check,
+	.run_test = cat_ctrlgrp_msr_test,
+};
diff --git a/tools/testing/selftests/resctrl/msr.c b/tools/testing/selftests/resctrl/msr.c
new file mode 100644
index 000000000000..1e8674036c7d
--- /dev/null
+++ b/tools/testing/selftests/resctrl/msr.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <fcntl.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#include <linux/types.h>
+
+#include "resctrl.h"
+
+#define MSR_PATH	"/dev/cpu/%d/msr"
+
+static int open_msr_file(int cpu)
+{
+	char msr_path[PATH_MAX];
+
+	snprintf(msr_path, sizeof(msr_path), MSR_PATH, cpu);
+
+	return open(msr_path, O_RDONLY);
+}
+
+int read_msr(int cpu, __u32 msr, __u64 *val)
+{
+	ssize_t res;
+	int fd;
+
+	fd = open_msr_file(cpu);
+	if (fd < 0) {
+		ksft_print_msg("Failed to open msr file for CPU %d\n", cpu);
+		return -1;
+	}
+
+	res = pread(fd, val, sizeof(*val), msr);
+	close(fd);
+	if (res < sizeof(*val)) {
+		ksft_print_msg("Reading MSR failed\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+bool msr_access_supported(int cpu)
+{
+	int fd;
+
+	fd = open_msr_file(cpu);
+	if (fd < 0)
+		return false;
+
+	close(fd);
+	return true;
+}
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index d25f83d0a54d..909a101f0e4c 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -243,8 +243,12 @@ extern struct resctrl_test mbm_test;
 extern struct resctrl_test mba_test;
 extern struct resctrl_test cmt_test;
 extern struct resctrl_test cat_grp_tasks_test;
+extern struct resctrl_test cat_grp_mask_test;
 extern struct resctrl_test l3_cat_test;
 extern struct resctrl_test l3_noncont_cat_test;
 extern struct resctrl_test l2_noncont_cat_test;
 
+bool msr_access_supported(int cpu);
+int read_msr(int cpu, __u32 msr, __u64 *val);
+
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 71b7cd846dc1..08ae48165c7a 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -19,6 +19,7 @@ static struct resctrl_test *resctrl_tests[] = {
 	&mba_test,
 	&cmt_test,
 	&cat_grp_tasks_test,
+	&cat_grp_mask_test,
 	&l3_cat_test,
 	&l3_noncont_cat_test,
 	&l2_noncont_cat_test,
-- 
2.39.5


