Return-Path: <linux-kselftest+bounces-19446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0BC998A2C
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 16:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D2A1C24420
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 14:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0B11CC16B;
	Thu, 10 Oct 2024 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hABL4J/g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED061CC153;
	Thu, 10 Oct 2024 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570775; cv=none; b=ZEV1gwOHl563Sriw3+1yO2WNt416is+5pXYP+FGqo5z0OzO4kSdzOZpHeCu3UvhNRHo5zk3PIS410K+fWOLXbWW6feKUh4WZj+l8mJUgtkKsXWHdND8VYfUINjb0RayoTWu+NcRfN/EovR9Yo9S25GZB/NyH8c9Af5/DUhczMWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570775; c=relaxed/simple;
	bh=i2BUc074sxqOtY3NfjpMV/uBIE8RPIDaUUPYU1B/5I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVNWlF7g7q0NhUHchR2mW0MVeEVxA5Jg99aW3WeZfRrWFfu5xyOnDC6Bh5mVlGJ/NqC+eHAMxAbDbYlheeC4lm8yelcAD5DzZERsC5J/+E6sDZU7ioHNyGCa8t1w3wWb13Wud72e/HeT0lH/Vf59PrX1ccGWtrLdKrwCkTnYs8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hABL4J/g; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728570774; x=1760106774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i2BUc074sxqOtY3NfjpMV/uBIE8RPIDaUUPYU1B/5I8=;
  b=hABL4J/g/+7/YLdDklIzA3J6HV0x9QvqfjkvXc2gFHQ+Mr9Q6NA8sVVI
   HxRstUCCnSMQg0yXBoNszIierharM/eryLMUkcZWLt4VjOWAl7qtV+NyW
   9avAL29Gwn/HTmz5/koxfWrjDpCc139RfGs3xiL6zG4e85j5OaK9CJc0U
   wUBqwZvtfCguQore7ad0L1+bqsG9tGH6qkZHGLWt06iWkAIhfoLteEcH9
   royK2na+ocYzHDJF3DmWwjypzsZeo9QHpzN/+ZS3iB0FUMDBqvkFPTFiU
   tcpLolmHC0zyj3mA+Awud8/Ws9Umvv2SPIqSLGPQ/NHkQAcaOXNYdw/mj
   A==;
X-CSE-ConnectionGUID: osHYVszTSg+i4FkcP68E9Q==
X-CSE-MsgGUID: cDJgP4A0SouuIQEQFZfUGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28064151"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="28064151"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:32:53 -0700
X-CSE-ConnectionGUID: ltrPHnvwQNWBOfDQOHLntw==
X-CSE-MsgGUID: hZzIDqqsRhOfm8qPY/SVKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81189240"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.16.81])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:32:43 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	kvm@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V12 04/14] KVM: selftests: Add guest Intel PT test
Date: Thu, 10 Oct 2024 17:31:41 +0300
Message-ID: <20241010143152.19071-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010143152.19071-1-adrian.hunter@intel.com>
References: <20241010143152.19071-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Add a test that starts Intel PT traces on host and guest. The test requires
support for Intel PT and having Host/Guest mode enabled i.e. kvm_intel
module parameter pt_mode=1.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/x86_64/processor.h  |   1 +
 tools/testing/selftests/kvm/x86_64/intel_pt.c | 381 ++++++++++++++++++
 3 files changed, 383 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/intel_pt.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 960cf6a77198..625222f348e4 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -79,6 +79,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/hyperv_features
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_ipi
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_svm_test
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_tlb_flush
+TEST_GEN_PROGS_x86_64 += x86_64/intel_pt
 TEST_GEN_PROGS_x86_64 += x86_64/kvm_clock_test
 TEST_GEN_PROGS_x86_64 += x86_64/kvm_pv_test
 TEST_GEN_PROGS_x86_64 += x86_64/monitor_mwait_test
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index e247f99e0473..808a23ec4160 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -161,6 +161,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_PCOMMIT		KVM_X86_CPU_FEATURE(0x7, 0, EBX, 22)
 #define	X86_FEATURE_CLFLUSHOPT		KVM_X86_CPU_FEATURE(0x7, 0, EBX, 23)
 #define	X86_FEATURE_CLWB		KVM_X86_CPU_FEATURE(0x7, 0, EBX, 24)
+#define	X86_FEATURE_INTEL_PT		KVM_X86_CPU_FEATURE(0x7, 0, EBX, 25)
 #define	X86_FEATURE_UMIP		KVM_X86_CPU_FEATURE(0x7, 0, ECX, 2)
 #define	X86_FEATURE_PKU			KVM_X86_CPU_FEATURE(0x7, 0, ECX, 3)
 #define	X86_FEATURE_OSPKE		KVM_X86_CPU_FEATURE(0x7, 0, ECX, 4)
diff --git a/tools/testing/selftests/kvm/x86_64/intel_pt.c b/tools/testing/selftests/kvm/x86_64/intel_pt.c
new file mode 100644
index 000000000000..94753b12936e
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/intel_pt.c
@@ -0,0 +1,381 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KVM guest Intel PT test
+ *
+ * Copyright (C) 2024, Intel Corporation.
+ */
+#include <linux/sizes.h>
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/perf_event.h>
+
+#include <sched.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+
+#include "kvm_util.h"
+#include "test_util.h"
+#include "processor.h"
+#include "ucall_common.h"
+
+#define MEM_GPA			SZ_256M
+/* Set PT_NR_PAGES to 1 to avoid single range errata on some processors */
+#define PT_NR_PAGES		1
+
+#define PT_CPUID_LEAVES		2
+#define PT_CPUID_REGS_NUM	4 /* number of registers (eax, ebx, ecx, edx) */
+
+/* Capability-related code is from the Kernel Intel PT driver */
+enum pt_capabilities {
+	PT_CAP_max_subleaf = 0,
+	PT_CAP_cr3_filtering,
+	PT_CAP_psb_cyc,
+	PT_CAP_ip_filtering,
+	PT_CAP_mtc,
+	PT_CAP_ptwrite,
+	PT_CAP_power_event_trace,
+	PT_CAP_event_trace,
+	PT_CAP_tnt_disable,
+	PT_CAP_topa_output,
+	PT_CAP_topa_multiple_entries,
+	PT_CAP_single_range_output,
+	PT_CAP_output_subsys,
+	PT_CAP_payloads_lip,
+	PT_CAP_num_address_ranges,
+	PT_CAP_mtc_periods,
+	PT_CAP_cycle_thresholds,
+	PT_CAP_psb_periods,
+};
+
+#define PT_CAP(_n, _l, _r, _m)						\
+	[PT_CAP_ ## _n] = { .name = __stringify(_n), .leaf = _l,	\
+			    .reg = KVM_ ## _r, .mask = _m }
+
+static struct pt_cap_desc {
+	const char	*name;
+	u32		leaf;
+	u8		reg;
+	u32		mask;
+} pt_caps[] = {
+	PT_CAP(max_subleaf,		0, CPUID_EAX, 0xffffffff),
+	PT_CAP(cr3_filtering,		0, CPUID_EBX, BIT(0)),
+	PT_CAP(psb_cyc,			0, CPUID_EBX, BIT(1)),
+	PT_CAP(ip_filtering,		0, CPUID_EBX, BIT(2)),
+	PT_CAP(mtc,			0, CPUID_EBX, BIT(3)),
+	PT_CAP(ptwrite,			0, CPUID_EBX, BIT(4)),
+	PT_CAP(power_event_trace,	0, CPUID_EBX, BIT(5)),
+	PT_CAP(event_trace,		0, CPUID_EBX, BIT(7)),
+	PT_CAP(tnt_disable,		0, CPUID_EBX, BIT(8)),
+	PT_CAP(topa_output,		0, CPUID_ECX, BIT(0)),
+	PT_CAP(topa_multiple_entries,	0, CPUID_ECX, BIT(1)),
+	PT_CAP(single_range_output,	0, CPUID_ECX, BIT(2)),
+	PT_CAP(output_subsys,		0, CPUID_ECX, BIT(3)),
+	PT_CAP(payloads_lip,		0, CPUID_ECX, BIT(31)),
+	PT_CAP(num_address_ranges,	1, CPUID_EAX, 0x7),
+	PT_CAP(mtc_periods,		1, CPUID_EAX, 0xffff0000),
+	PT_CAP(cycle_thresholds,	1, CPUID_EBX, 0xffff),
+	PT_CAP(psb_periods,		1, CPUID_EBX, 0xffff0000),
+};
+
+static u32 intel_pt_validate_cap(u32 *caps, enum pt_capabilities capability)
+{
+	struct pt_cap_desc *cd = &pt_caps[capability];
+	u32 c = caps[cd->leaf * PT_CPUID_REGS_NUM + cd->reg];
+	unsigned int shift = __ffs(cd->mask);
+
+	return (c & cd->mask) >> shift;
+}
+
+static int calc_psb_freq(u32 *caps, u64 *psb_freq)
+{
+	u64 allowed;
+
+	if (!(intel_pt_validate_cap(caps, PT_CAP_psb_cyc)))
+		return 0; /* PSBFreq not supported */
+
+	allowed = intel_pt_validate_cap(caps, PT_CAP_psb_periods);
+	if (!allowed)
+		return -1;
+
+	/* Select biggest period */
+	*psb_freq = __fls(allowed) << RTIT_CTL_PSB_FREQ_OFFSET;
+
+	return 0;
+}
+
+static u64 guest_psb_freq(u32 *caps)
+{
+	u64 psb_freq = 0;
+
+	GUEST_ASSERT(!calc_psb_freq(caps, &psb_freq));
+
+	return psb_freq;
+}
+
+static u64 host_psb_freq(u32 *caps)
+{
+	u64 psb_freq = 0;
+
+	TEST_ASSERT(!calc_psb_freq(caps, &psb_freq), "No valid PSBFreq");
+
+	return psb_freq;
+}
+
+static void read_caps(u32 *caps)
+{
+	for (int i = 0; i < PT_CPUID_LEAVES; i++) {
+		__cpuid(0x14, i,
+			&caps[KVM_CPUID_EAX + i * PT_CPUID_REGS_NUM],
+			&caps[KVM_CPUID_EBX + i * PT_CPUID_REGS_NUM],
+			&caps[KVM_CPUID_ECX + i * PT_CPUID_REGS_NUM],
+			&caps[KVM_CPUID_EDX + i * PT_CPUID_REGS_NUM]);
+	}
+}
+
+static void guest_code(void)
+{
+	u32 caps[PT_CPUID_REGS_NUM * PT_CPUID_LEAVES];
+	u64 status;
+
+	GUEST_ASSERT(this_cpu_has(X86_FEATURE_INTEL_PT));
+
+	read_caps(caps);
+
+	/* Config PT buffer */
+	wrmsr(MSR_IA32_RTIT_OUTPUT_MASK, PT_NR_PAGES * PAGE_SIZE - 1);
+	wrmsr(MSR_IA32_RTIT_OUTPUT_BASE, MEM_GPA);
+
+	/* Start tracing */
+	wrmsr(MSR_IA32_RTIT_CTL, RTIT_CTL_TRACEEN | RTIT_CTL_OS | RTIT_CTL_USR | RTIT_CTL_TSC_EN |
+				 RTIT_CTL_BRANCH_EN | guest_psb_freq(caps));
+
+	GUEST_ASSERT(rdmsr(MSR_IA32_RTIT_CTL) & RTIT_CTL_TRACEEN);
+
+	/*
+	 * Test repeated VM_Exit / VM-Entry. PAGE_SIZE to match aux_watermark,
+	 * refer to the handlng of UCALL_SYNC.
+	 */
+	for (int i = 0; i < PAGE_SIZE; i++)
+		GUEST_SYNC(i);
+
+	/* Stop tracing */
+	wrmsr(MSR_IA32_RTIT_CTL, 0);
+
+	status = rdmsr(MSR_IA32_RTIT_STATUS);
+
+	GUEST_ASSERT(!(status & (RTIT_STATUS_ERROR | RTIT_STATUS_STOPPED)));
+
+	GUEST_DONE();
+}
+
+static long perf_event_open(struct perf_event_attr *attr, pid_t pid, int cpu,
+			    int group_fd, unsigned long flags)
+{
+	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
+}
+
+static int read_sysfs(const char *file_path, unsigned int *val)
+{
+	FILE *f = fopen(file_path, "r");
+	int ret;
+
+	if (!f)
+		return -1;
+
+	ret = fscanf(f, "%u", val);
+
+	fclose(f);
+
+	return ret == 1 ? 0 : -1;
+}
+
+#define PT_CONFIG_PASS_THRU	1
+
+static int do_open_pt(u32 *caps, unsigned int type)
+{
+	struct perf_event_attr attr = {
+		.size = sizeof(attr),
+		.type = type,
+		.config = PT_CONFIG_PASS_THRU | RTIT_CTL_BRANCH_EN | host_psb_freq(caps),
+		.sample_period = 1,
+		.sample_type = PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_CPU |
+			       PERF_SAMPLE_TIME | PERF_SAMPLE_IDENTIFIER,
+		.exclude_kernel = 1,
+		.exclude_user = 0,
+		.exclude_hv = 1,
+		.sample_id_all = 1,
+		.exclude_guest = 1,
+		.aux_watermark = PAGE_SIZE,
+	};
+
+	return perf_event_open(&attr, 0, -1, -1, 0);
+}
+
+static int open_pt(u32 *caps)
+{
+	unsigned int type;
+	int err;
+
+	err = read_sysfs("/sys/bus/event_source/devices/intel_pt/type", &type);
+	if (err)
+		return -1;
+
+	return do_open_pt(caps, type);
+}
+
+#define PERF_HOST_BUF_SZ	(4 * PAGE_SIZE)
+#define PERF_HOST_MMAP_SZ	(PERF_HOST_BUF_SZ + PAGE_SIZE)
+#define PT_HOST_BUF_SZ		(2 * PAGE_SIZE)
+
+struct perf_info {
+	int fd;
+	void *perf_buf;
+	void *pt_buf;
+};
+
+static int perf_open(struct perf_info *pi)
+{
+	u32 caps[PT_CPUID_REGS_NUM * PT_CPUID_LEAVES];
+	struct perf_event_mmap_page *pc;
+
+	read_caps(caps);
+
+	pi->fd = open_pt(caps);
+	if (pi->fd < 0)
+		goto out_err;
+
+	/* mmap host buffer and user page */
+	pi->perf_buf = mmap(NULL, PERF_HOST_MMAP_SZ, PROT_READ | PROT_WRITE,
+			    MAP_SHARED, pi->fd, 0);
+	if (pi->perf_buf == MAP_FAILED)
+		goto out_close;
+
+	pc = pi->perf_buf;
+	pc->aux_offset = PERF_HOST_MMAP_SZ;
+	pc->aux_size = PT_HOST_BUF_SZ;
+
+	/* mmap pt buffer */
+	pi->pt_buf = mmap(NULL, PT_HOST_BUF_SZ, PROT_READ | PROT_WRITE,
+			  MAP_SHARED, pi->fd, PERF_HOST_MMAP_SZ);
+	if (pi->pt_buf == MAP_FAILED)
+		goto out_munmap;
+
+	return 0;
+
+out_munmap:
+	munmap(pi->perf_buf, PERF_HOST_MMAP_SZ);
+out_close:
+	close(pi->fd);
+	pi->fd = -1;
+out_err:
+	TEST_FAIL("Failed to start Intel PT tracing on host");
+	return -1;
+}
+
+static void perf_close(struct perf_info *pi)
+{
+	if (pi->fd < 0)
+		return;
+
+	munmap(pi->pt_buf, PT_HOST_BUF_SZ);
+	munmap(pi->perf_buf, PERF_HOST_MMAP_SZ);
+	close(pi->fd);
+}
+
+static void perf_forward(struct perf_info *pi)
+{
+	volatile struct perf_event_mmap_page *pc = pi->perf_buf;
+
+	if (pi->fd < 0)
+		return;
+
+	/* Must stop to ensure aux_head is up to date */
+	ioctl(pi->fd, PERF_EVENT_IOC_DISABLE, 0);
+
+	/* Discard all trace data */
+	pc->data_tail = pc->data_head;
+	pc->aux_tail = pc->aux_head;
+
+	/* Start after setting aux_tail */
+	ioctl(pi->fd, PERF_EVENT_IOC_ENABLE, 0);
+}
+
+/* Use volatile to discourage the compiler from unrolling the loop */
+volatile int loop_spin;
+
+static void run_vcpu(struct kvm_vcpu *vcpu, struct perf_info *pi)
+{
+	bool done = false;
+	struct ucall uc;
+
+	while (!done) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_PRINTF:
+			pr_info("%s", uc.buffer);
+			break;
+		case UCALL_SYNC:
+			/*
+			 * Empty the buffer and spin to add trace data in ever
+			 * increasing amounts, which will cause the host PMI to
+			 * more likely happen somewhere sensitive prior to
+			 * VM-Entry.
+			 */
+			perf_forward(pi);
+			for (int cnt = 0; cnt < uc.args[1]; cnt++)
+				for (loop_spin = 0; loop_spin < 5; loop_spin++)
+					cpu_relax();
+			break;
+		case UCALL_DONE:
+			done = true;
+			break;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			break;
+		default:
+			TEST_FAIL("Unknown ucall %lu exit reason: %s",
+				  uc.cmd, exit_reason_str(vcpu->run->exit_reason));
+			break;
+		}
+	}
+}
+
+#define PT_CAP_SINGLE_RANGE_OUTPUT \
+	KVM_X86_CPU_FEATURE(0x14, 0, ECX, 2)
+
+int main(int argc, char *argv[])
+{
+	struct perf_info pi = {.fd = -1};
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	/*
+	 * Guest X86_FEATURE_INTEL_PT depends on Intel PT support and kvm_intel
+	 * module parameter pt_mode=1.
+	 */
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_INTEL_PT));
+
+	/*
+	 * Only using single-range for now. Currently only BDW does not support it, but
+	 * BDW also doesn't support PT in VMX operation anyway.
+	 */
+	TEST_REQUIRE(vcpu_cpuid_has(vcpu, PT_CAP_SINGLE_RANGE_OUTPUT));
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, MEM_GPA, 1, PT_NR_PAGES, 0);
+
+	perf_open(&pi);
+
+	run_vcpu(vcpu, &pi);
+
+	perf_close(&pi);
+
+	kvm_vm_free(vm);
+
+	return 0;
+}
-- 
2.43.0


