Return-Path: <linux-kselftest+bounces-38126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34430B17788
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 22:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2B51AA5EA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 20:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCAD2676DF;
	Thu, 31 Jul 2025 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wjig+Wze"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD012620E4
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753995540; cv=none; b=HRFB2hea+L9nwg3g6wI17hOiU7IhI1lWH8BwUy+yuIPOaGcerqgD04U9sGvbito7Pe/Jhj0Ar0lWpHUUQYOs6Bho+Qirx0WcFNCOqGNhSDPNb4wI6j8/OTTIyHTuc5wPx+jNnsJB8jG9U50LomibVjCrazpxDBbaH3LfLReFW8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753995540; c=relaxed/simple;
	bh=cGMGpgMDOFtemFI0cHnoeNNANpjz/ZQ3gUUSarXqgHI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AN21Z5VPW2+E3ymu0tGxPqnHyVlRKev0u/8Y9GNop8mnX+Rzq0TKv8aySpbWTf37GraBcWiVyrJHYNht+Z5q9y03qjYXxK6CKmjbrAWuztrTFEHJ6hF8KH10jwFiupAul6CCix5IzTrRdUFTtYhGBL2nB2gD35PEUq7I81oxxHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wjig+Wze; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-315af08594fso135300a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 13:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753995537; x=1754600337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F46pMH1+iZGmF9xaF77AjZh22HwgVlr+zZEaUyOdnFk=;
        b=wjig+WzeYoK61PbdPSKW2eFme651kMtzdAB2HHt7e4Omb0fcAaJiVNXHMqWnzdfylv
         2LlOAYyq/5jCKtoOSqM0jDfsN4ovouRbhfbjT2Tx9ANEQR61HRNRiobUhwGpwGGanX8K
         sl1YdcHmBvuega/5Uhl2L8kvhIo0+FDgdECY/6YNmHQjSJEvQzW69t3+xlx+3Cz8URtl
         XVxN02C1rxT/jfn9y5GzibsVlJC3oW4PUuRc1W2IFQthurCLCNMMHyGiUZfC1hxwZIgw
         HEDV/VcXEGTx7Y5eRNadgXd/06LXSmazg8IEsgkd3UWWkfVntjZVz96DeSWCogMp7VG0
         953Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753995537; x=1754600337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F46pMH1+iZGmF9xaF77AjZh22HwgVlr+zZEaUyOdnFk=;
        b=vGX+dI9ozWOJNdELqvebKUYgYsD/Iqu0b60jRudCqatruYuoFbIcc7CgPtfyckvYMt
         ud95FKqjegY8ugGbjpBQP20HQJVEUuOAmoxe96j5347aKVNwyA2w5rZBuKdpOYZKpNFq
         Q0hyTiU3ss87M4jEMhX95bmhdjV2riGQ0uLkAy6hZUgOy9JZ8BQoyp2jMoxJu9IQCbIj
         aCD1ai1P6/RkDMs97oIKsqxXQQxqHH8pzi2bXwY5XQFDNXLpsiO3yWffYzAUDDJPoBvv
         h+C4Gag7mUf5IGSuXs8U1p3PDKKenBj45SWJ7jk0oJk0yr6w7vTLswuASJq6PtojKgpg
         RVAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX49jsrt/TV3w6q46aSw/GlHL32bZVqsZ3MD8A2ZoA5Q1gAR/zLO9+56x+pYWpugq9xHAMmSnobD/7LjX6S4dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzigyIxglHUXoGHqoCW350dZCJwViZcHMgCgJJ8/bj7WeMjl3fx
	6OFH5xxNWwGVVBJv6q9sMVOJtFO/7hhWmeyd4fOLsKd4eOvTned+ev3IL2eG2IigRIrgDhGCx8g
	yJ3upwSomPE6RHQ==
X-Google-Smtp-Source: AGHT+IEQ3yXPShvKLn0RwZSyuAR/26fLbmN+PMhu/KUx8Bqh8AprTssst9Gv9dW7e1g9nfOkQELiWT0go9UbEw==
X-Received: from pjyf13.prod.google.com ([2002:a17:90a:ec8d:b0:312:e266:f849])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1f88:b0:31f:336a:f0db with SMTP id 98e67ed59e1d1-31f5ddc4b7fmr12701699a91.10.1753995536842;
 Thu, 31 Jul 2025 13:58:56 -0700 (PDT)
Date: Thu, 31 Jul 2025 20:58:43 +0000
In-Reply-To: <20250731205844.1346839-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731205844.1346839-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731205844.1346839-3-jiaqiyan@google.com>
Subject: [PATCH v3 2/3] KVM: selftests: Test for KVM_EXIT_ARM_SEA
From: Jiaqi Yan <jiaqiyan@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	shuah@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	duenwen@google.com, rananta@google.com, jthoughton@google.com, 
	Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Test how KVM handles guest SEA when APEI is unable to claim it, and
KVM_CAP_ARM_SEA_TO_USER is enabled.

The behavior is triggered by consuming recoverable memory error (UER)
injected via EINJ. The test asserts two major things:
1. KVM returns to userspace with KVM_EXIT_ARM_SEA exit reason, and
   has provided expected fault information, e.g. esr, flags, gva, gpa.
2. Userspace is able to handle KVM_EXIT_ARM_SEA by injecting SEA to
   guest and KVM injects expected SEA into the VCPU.

Tested on a data center server running Siryn AmpereOne processor
that has RAS support.

Several things to notice before attempting to run this selftest:
- The test relies on EINJ support in both firmware and kernel to
  inject UER. Otherwise the test will be skipped.
- The under-test platform's APEI should be unable to claim the SEA.
  Otherwise the test will be skipped.
- Some platform doesn't support notrigger in EINJ, which may cause
  APEI and GHES to offline the memory before guest can consume
  injected UER, and making test unable to trigger SEA.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 tools/arch/arm64/include/asm/esr.h            |   2 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/arm64/sea_to_user.c | 327 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |   1 +
 4 files changed, 331 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/arm64/sea_to_user.c

diff --git a/tools/arch/arm64/include/asm/esr.h b/tools/arch/arm64/include/asm/esr.h
index bd592ca815711..0fa17b3af1f78 100644
--- a/tools/arch/arm64/include/asm/esr.h
+++ b/tools/arch/arm64/include/asm/esr.h
@@ -141,6 +141,8 @@
 #define ESR_ELx_SF 		(UL(1) << ESR_ELx_SF_SHIFT)
 #define ESR_ELx_AR_SHIFT	(14)
 #define ESR_ELx_AR 		(UL(1) << ESR_ELx_AR_SHIFT)
+#define ESR_ELx_VNCR_SHIFT	(13)
+#define ESR_ELx_VNCR		(UL(1) << ESR_ELx_VNCR_SHIFT)
 #define ESR_ELx_CM_SHIFT	(8)
 #define ESR_ELx_CM 		(UL(1) << ESR_ELx_CM_SHIFT)
 
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index ce817a975e50a..8512e790f45fa 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -159,6 +159,7 @@ TEST_GEN_PROGS_arm64 += arm64/hypercalls
 TEST_GEN_PROGS_arm64 += arm64/external_aborts
 TEST_GEN_PROGS_arm64 += arm64/page_fault_test
 TEST_GEN_PROGS_arm64 += arm64/psci_test
+TEST_GEN_PROGS_arm64 += arm64/sea_to_user
 TEST_GEN_PROGS_arm64 += arm64/set_id_regs
 TEST_GEN_PROGS_arm64 += arm64/smccc_filter
 TEST_GEN_PROGS_arm64 += arm64/vcpu_width_config
diff --git a/tools/testing/selftests/kvm/arm64/sea_to_user.c b/tools/testing/selftests/kvm/arm64/sea_to_user.c
new file mode 100644
index 0000000000000..3ddc890e8a8b5
--- /dev/null
+++ b/tools/testing/selftests/kvm/arm64/sea_to_user.c
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test KVM returns to userspace with KVM_EXIT_ARM_SEA if host APEI fails
+ * to handle SEA and userspace has opt-ed in KVM_CAP_ARM_SEA_TO_USER.
+ *
+ * After reaching userspace with expected arm_sea info, also test userspace
+ * injecting a synchronous external data abort into the guest.
+ *
+ * This test utilizes EINJ to generate a REAL synchronous external data
+ * abort by consuming a recoverable uncorrectable memory error. Therefore
+ * the device under test must support EINJ in both firmware and host kernel,
+ * including the notrigger feature. Otherwise the test will be skipped.
+ * The under-test platform's APEI should be unable to claim SEA. Otherwise
+ * the test will also be skipped.
+ */
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "guest_modes.h"
+
+#define PAGE_PRESENT		(1ULL << 63)
+#define PAGE_PHYSICAL		0x007fffffffffffffULL
+#define PAGE_ADDR_MASK		(~(0xfffULL))
+
+/* Group ISV and ISS[23:14]. */
+#define ESR_ELx_INST_SYNDROME	((ESR_ELx_ISV) | (ESR_ELx_SAS) | \
+				 (ESR_ELx_SSE) | (ESR_ELx_SRT_MASK) | \
+				 (ESR_ELx_SF) | (ESR_ELx_AR))
+
+#define EINJ_ETYPE		"/sys/kernel/debug/apei/einj/error_type"
+#define EINJ_ADDR		"/sys/kernel/debug/apei/einj/param1"
+#define EINJ_MASK		"/sys/kernel/debug/apei/einj/param2"
+#define EINJ_FLAGS		"/sys/kernel/debug/apei/einj/flags"
+#define EINJ_NOTRIGGER		"/sys/kernel/debug/apei/einj/notrigger"
+#define EINJ_DOIT		"/sys/kernel/debug/apei/einj/error_inject"
+/* Memory Uncorrectable non-fatal. */
+#define ERROR_TYPE_MEMORY_UER	0x10
+/* Memory address and mask valid (param1 and param2). */
+#define MASK_MEMORY_UER		0b10
+
+/* Guest virtual address region = [2G, 3G).  */
+#define START_GVA		0x80000000UL
+#define VM_MEM_SIZE		0x40000000UL
+/* Note: EINJ_OFFSET must < VM_MEM_SIZE. */
+#define EINJ_OFFSET		0x01234badUL
+#define EINJ_GVA		((START_GVA) + (EINJ_OFFSET))
+
+static vm_paddr_t einj_gpa;
+static void *einj_hva;
+static uint64_t einj_hpa;
+static bool far_invalid;
+
+static uint64_t translate_to_host_paddr(unsigned long vaddr)
+{
+	uint64_t pinfo;
+	int64_t offset = vaddr / getpagesize() * sizeof(pinfo);
+	int fd;
+	uint64_t page_addr;
+	uint64_t paddr;
+
+	fd = open("/proc/self/pagemap", O_RDONLY);
+	if (fd < 0)
+		ksft_exit_fail_perror("Failed to open /proc/self/pagemap");
+	if (pread(fd, &pinfo, sizeof(pinfo), offset) != sizeof(pinfo)) {
+		close(fd);
+		ksft_exit_fail_perror("Failed to read /proc/self/pagemap");
+	}
+
+	close(fd);
+
+	if ((pinfo & PAGE_PRESENT) == 0)
+		ksft_exit_fail_perror("Page not present");
+
+	page_addr = (pinfo & PAGE_PHYSICAL) << MIN_PAGE_SHIFT;
+	paddr = page_addr + (vaddr & (getpagesize() - 1));
+	return paddr;
+}
+
+static void write_einj_entry(const char *einj_path, uint64_t val)
+{
+	char cmd[256] = {0};
+	FILE *cmdfile = NULL;
+
+	sprintf(cmd, "echo %#lx > %s", val, einj_path);
+	cmdfile = popen(cmd, "r");
+
+	if (pclose(cmdfile) == 0)
+		ksft_print_msg("echo %#lx > %s - done\n", val, einj_path);
+	else
+		ksft_exit_fail_perror("Failed to write EINJ entry");
+}
+
+static void inject_uer(uint64_t paddr)
+{
+	if (access("/sys/firmware/acpi/tables/EINJ", R_OK) == -1)
+		ksft_test_result_skip("EINJ table no available in firmware");
+
+	if (access(EINJ_ETYPE, R_OK | W_OK) == -1)
+		ksft_test_result_skip("EINJ module probably not loaded?");
+
+	write_einj_entry(EINJ_ETYPE, ERROR_TYPE_MEMORY_UER);
+	write_einj_entry(EINJ_FLAGS, MASK_MEMORY_UER);
+	write_einj_entry(EINJ_ADDR, paddr);
+	write_einj_entry(EINJ_MASK, ~0x0UL);
+	write_einj_entry(EINJ_NOTRIGGER, 1);
+	write_einj_entry(EINJ_DOIT, 1);
+}
+
+/*
+ * When host APEI successfully claims the SEA caused by guest_code, kernel
+ * will send SIGBUS signal with BUS_MCEERR_AR to test thread.
+ *
+ * We set up this SIGBUS handler to skip the test for that case.
+ */
+static void sigbus_signal_handler(int sig, siginfo_t *si, void *v)
+{
+	ksft_print_msg("SIGBUS (%d) received, dumping siginfo...\n", sig);
+	ksft_print_msg("si_signo=%d, si_errno=%d, si_code=%d, si_addr=%p\n",
+		       si->si_signo, si->si_errno, si->si_code, si->si_addr);
+	if (si->si_code == BUS_MCEERR_AR)
+		ksft_test_result_skip("SEA is claimed by host APEI\n");
+	else
+		ksft_test_result_fail("Exit with signal unhandled\n");
+
+	exit(0);
+}
+
+static void setup_sigbus_handler(void)
+{
+	struct sigaction act;
+
+	memset(&act, 0, sizeof(act));
+	sigemptyset(&act.sa_mask);
+	act.sa_sigaction = sigbus_signal_handler;
+	act.sa_flags = SA_SIGINFO;
+	TEST_ASSERT(sigaction(SIGBUS, &act, NULL) == 0,
+		    "Failed to setup SIGBUS handler");
+}
+
+static void guest_code(void)
+{
+	uint64_t guest_data;
+
+	/* Consumes error will cause a SEA. */
+	guest_data = *(uint64_t *)EINJ_GVA;
+
+	GUEST_FAIL("Poison not protected by SEA: gva=%#lx, guest_data=%#lx\n",
+		   EINJ_GVA, guest_data);
+}
+
+static void expect_sea_handler(struct ex_regs *regs)
+{
+	u64 esr = read_sysreg(esr_el1);
+	u64 far = read_sysreg(far_el1);
+	bool expect_far_invalid = far_invalid;
+
+	GUEST_PRINTF("Handling Guest SEA\n");
+	GUEST_PRINTF("ESR_EL1=%#lx, FAR_EL1=%#lx\n", esr, far);
+
+	GUEST_ASSERT_EQ(ESR_ELx_EC(esr), ESR_ELx_EC_DABT_CUR);
+	GUEST_ASSERT_EQ(esr & ESR_ELx_FSC_TYPE, ESR_ELx_FSC_EXTABT);
+
+	if (expect_far_invalid) {
+		GUEST_ASSERT_EQ(esr & ESR_ELx_FnV, ESR_ELx_FnV);
+		GUEST_PRINTF("Guest observed garbage value in FAR\n");
+	} else {
+		GUEST_ASSERT_EQ(esr & ESR_ELx_FnV, 0);
+		GUEST_ASSERT_EQ(far, EINJ_GVA);
+	}
+
+	GUEST_DONE();
+}
+
+static void vcpu_inject_sea(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_events events = {};
+
+	events.exception.ext_dabt_pending = true;
+	vcpu_events_set(vcpu, &events);
+}
+
+static void run_vm(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+	bool guest_done = false;
+	struct kvm_run *run = vcpu->run;
+	u64 esr;
+
+	/* Resume the vCPU after error injection to consume the error. */
+	vcpu_run(vcpu);
+
+	ksft_print_msg("Dump kvm_run info about KVM_EXIT_%s\n",
+		       exit_reason_str(run->exit_reason));
+	ksft_print_msg("kvm_run.arm_sea: esr=%#llx, flags=%#llx\n",
+		       run->arm_sea.esr, run->arm_sea.flags);
+	ksft_print_msg("kvm_run.arm_sea: gva=%#llx, gpa=%#llx\n",
+		       run->arm_sea.gva, run->arm_sea.gpa);
+
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_ARM_SEA);
+
+	esr = run->arm_sea.esr;
+	TEST_ASSERT_EQ(ESR_ELx_EC(esr), ESR_ELx_EC_DABT_LOW);
+	TEST_ASSERT_EQ(esr & ESR_ELx_FSC_TYPE, ESR_ELx_FSC_EXTABT);
+	TEST_ASSERT_EQ(ESR_ELx_ISS2(esr), 0);
+	TEST_ASSERT_EQ((esr & ESR_ELx_INST_SYNDROME), 0);
+	TEST_ASSERT_EQ(esr & ESR_ELx_VNCR, 0);
+
+	if (!(esr & ESR_ELx_FnV))
+		TEST_ASSERT_EQ(run->arm_sea.gva, EINJ_GVA);
+
+	if (run->arm_sea.flags & KVM_EXIT_ARM_SEA_FLAG_GPA_VALID)
+		TEST_ASSERT_EQ(run->arm_sea.gpa, einj_gpa & PAGE_ADDR_MASK);
+
+	far_invalid = esr & ESR_ELx_FnV;
+
+	/* Inject a SEA into guest and expect handled in SEA handler. */
+	vcpu_inject_sea(vcpu);
+
+	/* Expect the guest to reach GUEST_DONE gracefully. */
+	do {
+		vcpu_run(vcpu);
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_PRINTF:
+			ksft_print_msg("From guest: %s", uc.buffer);
+			break;
+		case UCALL_DONE:
+			ksft_print_msg("Guest done gracefully!\n");
+			guest_done = 1;
+			break;
+		case UCALL_ABORT:
+			ksft_print_msg("Guest aborted!\n");
+			guest_done = 1;
+			REPORT_GUEST_ASSERT(uc);
+			break;
+		default:
+			TEST_FAIL("Unexpected ucall: %lu\n", uc.cmd);
+		}
+	} while (!guest_done);
+}
+
+static struct kvm_vm *vm_create_with_sea_handler(struct kvm_vcpu **vcpu)
+{
+	size_t backing_page_size;
+	size_t guest_page_size;
+	size_t alignment;
+	uint64_t num_guest_pages;
+	vm_paddr_t start_gpa;
+	enum vm_mem_backing_src_type src_type = VM_MEM_SRC_ANONYMOUS_HUGETLB_1GB;
+	struct kvm_vm *vm;
+
+	backing_page_size = get_backing_src_pagesz(src_type);
+	guest_page_size = vm_guest_mode_params[VM_MODE_DEFAULT].page_size;
+	alignment = max(backing_page_size, guest_page_size);
+	num_guest_pages = VM_MEM_SIZE / guest_page_size;
+
+	vm = __vm_create_with_one_vcpu(vcpu, num_guest_pages, guest_code);
+	vm_init_descriptor_tables(vm);
+	vcpu_init_descriptor_tables(*vcpu);
+
+	vm_install_sync_handler(vm,
+		/*vector=*/VECTOR_SYNC_CURRENT,
+		/*ec=*/ESR_ELx_EC_DABT_CUR,
+		/*handler=*/expect_sea_handler);
+
+	start_gpa = (vm->max_gfn - num_guest_pages) * guest_page_size;
+	start_gpa = align_down(start_gpa, alignment);
+
+	vm_userspace_mem_region_add(
+		/*vm=*/vm,
+		/*src_type=*/src_type,
+		/*guest_paddr=*/start_gpa,
+		/*slot=*/1,
+		/*npages=*/num_guest_pages,
+		/*flags=*/0);
+
+	virt_map(vm, START_GVA, start_gpa, num_guest_pages);
+
+	ksft_print_msg("Mapped %#lx pages: gva=%#lx to gpa=%#lx\n",
+		       num_guest_pages, START_GVA, start_gpa);
+	return vm;
+}
+
+static void vm_inject_memory_uer(struct kvm_vm *vm)
+{
+	uint64_t guest_data;
+
+	einj_gpa = addr_gva2gpa(vm, EINJ_GVA);
+	einj_hva = addr_gva2hva(vm, EINJ_GVA);
+
+	/* Populate certain data before injecting UER. */
+	*(uint64_t *)einj_hva = 0xBAADCAFE;
+	guest_data = *(uint64_t *)einj_hva;
+	ksft_print_msg("Before EINJect: data=%#lx\n",
+		guest_data);
+
+	einj_hpa = translate_to_host_paddr((unsigned long)einj_hva);
+
+	ksft_print_msg("EINJ_GVA=%#lx, einj_gpa=%#lx, einj_hva=%p, einj_hpa=%#lx\n",
+		       EINJ_GVA, einj_gpa, einj_hva, einj_hpa);
+
+	inject_uer(einj_hpa);
+	ksft_print_msg("Memory UER EINJected\n");
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_SEA_TO_USER));
+
+	setup_sigbus_handler();
+
+	vm = vm_create_with_sea_handler(&vcpu);
+	vm_enable_cap(vm, KVM_CAP_ARM_SEA_TO_USER, 0);
+	vm_inject_memory_uer(vm);
+	run_vm(vm, vcpu);
+	kvm_vm_free(vm);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index a055343a7bf75..d3234239b9845 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2041,6 +2041,7 @@ static struct exit_reason {
 	KVM_EXIT_STRING(NOTIFY),
 	KVM_EXIT_STRING(LOONGARCH_IOCSR),
 	KVM_EXIT_STRING(MEMORY_FAULT),
+	KVM_EXIT_STRING(ARM_SEA),
 };
 
 /*
-- 
2.50.1.565.gc32cd1483b-goog


