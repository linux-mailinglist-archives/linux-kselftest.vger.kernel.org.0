Return-Path: <linux-kselftest+bounces-34280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA9CACD768
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 07:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B589A1898379
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 05:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D024A264A8E;
	Wed,  4 Jun 2025 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBm1MjhO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E25C2620E8
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 05:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749013753; cv=none; b=FfJTrdElJxMpV2lCZYLddmawMp4fIscUM/aMPO5/7+l3xVO0yt1Qp691jpncmY7A++3suSE0O3FBJ3yjsjR5OvQtL/Sd8pz8cJYSfo/7K04m3CojbTluq9TqUE3onvbym30Dz5aPtYq6fDw5Gb6lyMFXJrLBABqYnbBxbV/dzHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749013753; c=relaxed/simple;
	bh=2zckfbgDtV/rdGQ1Fvm1kVb4yb2Bx4/marRdNdm+Z5U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DqenfrWATNs6HwVKBNbDXingQmkcMkDFbS2TffcX2LMfNzVLslJta2RHTXiyQHd5tG+cqPfqAzhETDIbi/kClR6oHfN9AZNUpGWjCWOnyTMDl0cKbeTlbw6lhsFTvzjAUsGD/cYPperRqzy1qJE+LZeVFNsLb4c4eHNBktCcU2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nBm1MjhO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c36951518so5962427a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 22:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749013750; x=1749618550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3CQQlLfvRrM2xbLSECzcA1gv8/mOL1bhrsH0MeOwqY=;
        b=nBm1MjhOv8SRSE8Oug4/sF0d/RLlFsmcQhnUVNT4TMQpnY6Qkie2JCUexbBr3re9z+
         TO5z8ff2960Q5Hfm2eMn0jZrh6TJV3EUf/XnwbQEZTEzXrzvwY1z99xJzWdBhjkfrsQV
         CxSBPGSiqvhfef8+tU+AsYGJr2IPi//u5Gk2rN97ddVjTTzu6SK3kArtR5+1iW/yhef1
         ABqs4DuaDODH4jlymZ+SxSzkI7OFdem7QB99nwBXaEbt4Top/bVjoVvbTJQJjUXzO5dL
         88dc9X/iQRy14zlm9bGqimzSeMLQNRSAACGPl7XFYt3lHhPVVtoIZZJ/up50W88SmYac
         e+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749013750; x=1749618550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3CQQlLfvRrM2xbLSECzcA1gv8/mOL1bhrsH0MeOwqY=;
        b=J8fIczUqvKh+OGP/G/lAz6QQSwFu1dOh3G+zIgNfTEhM7vj5RrUg1Jpm5W48Ctzc64
         UmR9ebhhd7OI3foUiM0n8nhvef8x5V0/a82aNduwq1P1vjAFX/5Zod7eb2XICnX2fv0M
         8LX+dMUZgro2pR3fRZpF9boKKwBIKl1pq/f6Vy/kEF7bb8m0X+4L9BkCLvwghlwYdW+1
         bOj8pCEEd52uVO8irbZ+AGr/l055OWST/5AQgdIC/ya66lwkBnkjhAMqRyRleyNfPxy5
         dLAVeUQo1lEtZWergxhNiBoFcYL6CcRWBWSMjTrCs7u7PMGs1n9ejM3U6qu/u9fQ5rNQ
         rVVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGDGxU748IZzC3b2V2JRIcoib7yauEZx/SD1QuG801wsX48DECI6xEEPlqxi3RA7A52C4rfmj0BVV8QYyjAas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/HR03oxnbk78MQ4hFRgwYqLj5m1eQiipGuhEO1njdvzaMd86C
	dVVPfHxOHUWSXybvLz1sRV6DSldPmwu35CjigWYDsooK4iNps86Zoi8IkKt0wkoZop202V9RaUr
	rPG/g8FmnXQ6Ueg==
X-Google-Smtp-Source: AGHT+IGqBQEiDPfTgv0utxEUZr5d04VYg3EaHPhFajTihoCJUcmcUQNRbmWxUD7/LsESavm3PsXj/WBpeRArPw==
X-Received: from pfbgi1.prod.google.com ([2002:a05:6a00:63c1:b0:746:1c55:a27])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3d87:b0:21c:ff38:9c6b with SMTP id adf61e73a8af0-21d22c6d84fmr2192393637.25.1749013750328;
 Tue, 03 Jun 2025 22:09:10 -0700 (PDT)
Date: Wed,  4 Jun 2025 05:08:59 +0000
In-Reply-To: <20250604050902.3944054-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604050902.3944054-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604050902.3944054-5-jiaqiyan@google.com>
Subject: [PATCH v2 4/6] KVM: selftests: Test for KVM_EXIT_ARM_SEA and KVM_CAP_ARM_SEA_TO_USER
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

Test how KVM handles guest stage-2 SEA when APEI is unable to claim it.
The behavior is triggered by consuming recoverable memory error (UER)
injected via EINJ. The test asserts two major things:
1. KVM returns to userspace with KVM_EXIT_ARM_SEA exit reason, and
   has provided expected fault information, e.g. esr, flags, gva, gpa.
2. Userspace is able to handle KVM_EXIT_ARM_SEA by injecting SEA to
   guest and KVM injects expected SEA into the VCPU.

Tested on a data center server running Siryn AmpereOne processor.

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
 .../testing/selftests/kvm/arm64/sea_to_user.c | 340 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |   1 +
 4 files changed, 344 insertions(+)
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
index d37072054a3d0..9eecce6b8274f 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -152,6 +152,7 @@ TEST_GEN_PROGS_arm64 += arm64/hypercalls
 TEST_GEN_PROGS_arm64 += arm64/mmio_abort
 TEST_GEN_PROGS_arm64 += arm64/page_fault_test
 TEST_GEN_PROGS_arm64 += arm64/psci_test
+TEST_GEN_PROGS_arm64 += arm64/sea_to_user
 TEST_GEN_PROGS_arm64 += arm64/set_id_regs
 TEST_GEN_PROGS_arm64 += arm64/smccc_filter
 TEST_GEN_PROGS_arm64 += arm64/vcpu_width_config
diff --git a/tools/testing/selftests/kvm/arm64/sea_to_user.c b/tools/testing/selftests/kvm/arm64/sea_to_user.c
new file mode 100644
index 0000000000000..381d8597ab406
--- /dev/null
+++ b/tools/testing/selftests/kvm/arm64/sea_to_user.c
@@ -0,0 +1,340 @@
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
+/* Value for "Recoverable state (UER)". */
+#define ESR_ELx_SET_UER		0U
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
+	GUEST_FAIL("Data corruption not prevented by SEA: gva=%#lx, data=%#lx",
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
+	GUEST_PRINTF("  ESR_EL1=%#lx, FAR_EL1=%#lx\n", esr, far);
+	GUEST_PRINTF("  Entire ISS2=%#llx\n", ESR_ELx_ISS2(esr));
+	GUEST_PRINTF("  ISV + ISS[23:14]=%#lx\n", esr & ESR_ELx_INST_SYNDROME);
+	GUEST_PRINTF("  VNCR=%#lx\n", esr & ESR_ELx_VNCR);
+	GUEST_PRINTF("  SET=%#lx\n", esr & ESR_ELx_SET_MASK);
+
+	GUEST_ASSERT_EQ(ESR_ELx_EC(esr), ESR_ELx_EC_DABT_CUR);
+	GUEST_ASSERT_EQ(esr & ESR_ELx_FSC_TYPE, ESR_ELx_FSC_EXTABT);
+
+	/* Asserts bits hidden by KVM. */
+	GUEST_ASSERT_EQ(ESR_ELx_ISS2(esr), 0);
+	GUEST_ASSERT_EQ((esr & ESR_ELx_INST_SYNDROME), 0);
+	GUEST_ASSERT_EQ(esr & ESR_ELx_VNCR, 0);
+	GUEST_ASSERT_EQ(esr & ESR_ELx_SET_MASK, ESR_ELx_SET_UER);
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
+	/* Validate the KVM_EXIT. */
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_ARM_SEA);
+	TEST_ASSERT_EQ(ESR_ELx_EC(run->arm_sea.esr), ESR_ELx_EC_DABT_LOW);
+	TEST_ASSERT_EQ(run->arm_sea.esr & ESR_ELx_FSC_TYPE, ESR_ELx_FSC_EXTABT);
+	TEST_ASSERT_EQ(run->arm_sea.esr & ESR_ELx_SET_MASK, ESR_ELx_SET_UER);
+
+	if (run->arm_sea.flags & KVM_EXIT_ARM_SEA_FLAG_GVA_VALID)
+		TEST_ASSERT_EQ(run->arm_sea.gva, EINJ_GVA);
+
+	if (run->arm_sea.flags & KVM_EXIT_ARM_SEA_FLAG_GPA_VALID)
+		TEST_ASSERT_EQ(run->arm_sea.gpa, einj_gpa & PAGE_ADDR_MASK);
+
+	far_invalid = run->arm_sea.esr & ESR_ELx_FnV;
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
+
+	vm_enable_cap(vm, KVM_CAP_ARM_SEA_TO_USER, 0);
+
+	vm_inject_memory_uer(vm);
+
+	run_vm(vm, vcpu);
+
+	kvm_vm_free(vm);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 815bc45dd8dc6..bc9fcf6c3295a 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2021,6 +2021,7 @@ static struct exit_reason {
 	KVM_EXIT_STRING(NOTIFY),
 	KVM_EXIT_STRING(LOONGARCH_IOCSR),
 	KVM_EXIT_STRING(MEMORY_FAULT),
+	KVM_EXIT_STRING(ARM_SEA),
 };
 
 /*
-- 
2.49.0.1266.g31b7d2e469-goog


