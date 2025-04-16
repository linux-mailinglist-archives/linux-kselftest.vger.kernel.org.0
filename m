Return-Path: <linux-kselftest+bounces-30987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA677A90FA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 01:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1549E3BA278
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 23:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5FE2309AF;
	Wed, 16 Apr 2025 23:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpeSk8q6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE4114A4DB;
	Wed, 16 Apr 2025 23:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744846410; cv=none; b=iXmOd/Fvy4J5UwEqPGJAy35hEqvtGNbfgeYxQ4kG0DmS1MXHuCLoeb2kOLNZymVD0o7P4IbRXgoKb6WGEwPSKfNCIz1ZI9N0cx4U2AfIMvf+w5myk5jkhGNYHcuRFcmihEgwuX7C7aBQrp6nujZvKsczy2Kezokx4LS+ZWWPMH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744846410; c=relaxed/simple;
	bh=Ecdg41vWCtpkSt3gvW7D8FWTYl606nKDN9OmlaG2l1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uHRyW2gmBbv510b960b0aAb6/TM6/96B+SWV5CvZMM8vlUJ5BMxCfaYp62KjLtQgNJtqYNvSOHDpxXyJNkiDVLS3cSNrVkJnqtmANwG6o6Elvm2epqoZfXL/iUU4IET7Kv/HWlKP5g2DZwTwT7k+g2mdBrfLpVk5+wS8ErDYspM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpeSk8q6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C54BC4CEE2;
	Wed, 16 Apr 2025 23:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744846409;
	bh=Ecdg41vWCtpkSt3gvW7D8FWTYl606nKDN9OmlaG2l1k=;
	h=From:Date:Subject:To:Cc:From;
	b=WpeSk8q6G8wXPJ6NfLBMGWG/BU/EcTU9c+pVJWlb9G9AnKnjn6UXeK/CbOqk2R66x
	 hIZZoSqqFsKwx1vUls2g07m7PSN3UMTXMFaEWUJRDUKJNHOhuzVLE5tjIXfLBvql3K
	 FqA3R7OpIgXv4pryPYERza9Nqh4TTFWcX+VI0FnrUNMFJIAkZwsx59/AaoSLbOUDOK
	 Lc38fDuGdMVYauv8D7YCaZ12rBBn+9P5yRNBadPiCgNEuA8nT7DOCaqBWs3VID6Aw7
	 H6ZYonMrwmLBRAa4GIn+Smsf9HcGB7dklXKkq82aFPrW9XOab0TGLPArz28ORDEK5V
	 OKnPJgQNEh64A==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 17 Apr 2025 00:32:49 +0100
Subject: [PATCH] KVM: selftests: add test for SVE host corruption
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-kvm-selftest-sve-signal-v1-1-6330c2f3da0c@kernel.org>
X-B4-Tracking: v=1; b=H4sIACA+AGgC/x3MMQqAMAxA0atIZgNtQUWvIg7FRA1qlUaKIN7d4
 viG/x9QjsIKXfFA5CQqR8iwZQHj4sPMKJQNzrjKOFfjmnZU3qaL9UJNjCpz8BtaT2SopcbWI+T
 6jDzJ/Z/74X0/uxe3dWkAAAA=
X-Change-ID: 20250226-kvm-selftest-sve-signal-1add0d9d716c
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4129; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Ecdg41vWCtpkSt3gvW7D8FWTYl606nKDN9OmlaG2l1k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoAD5GSLv2p33SybMnvyMowOIRAo8cX4B97rSgmn/m
 FcQJNm+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaAA+RgAKCRAk1otyXVSH0JsDCA
 CGWxC17NOadoAMvGZ1sYyldRUE7lDhlVDzftw1ctHVesXShJH7tox5uLPZKsb6y2qRbNs2prMZ/ZWF
 Ttq6K/zNNRoTyfk6Im9C1mwQ7Hyn89erkF11aFoU6OD/HHfA6AeXix8dD26yJkeB9UU/40sELfIV89
 vLogqEZbeTho53/NL4mzNsV41ecJeioVEwY7cc1JTuu6JhnTRfQt4TABTRxd8BL5dWxFYvjU8Ibiz6
 GwaedSRrkBqiLJsx5qy4wc1u03v94qITLQD8mPPlnV9/OfR9YyYxR3L03SDDn336Y8hMhTaJq4EvNZ
 ZoNnuEgEXV9+HwdMtNMJXKnDalcBF1
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This test program, originally written by Mark Rutland and lightly modified
by me for upstream, verifies that we do not have the issues with host SVE
state being discarded which were fixed in

   fbc7e61195e2 ("KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state")

by running a simple VM while checking the SVE register state for
corruption.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/Makefile.kvm     |   1 +
 tools/testing/selftests/kvm/arm64/host_sve.c | 127 +++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index f62b0a5aba35..d37072054a3d 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -147,6 +147,7 @@ TEST_GEN_PROGS_arm64 = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_arm64 += arm64/aarch32_id_regs
 TEST_GEN_PROGS_arm64 += arm64/arch_timer_edge_cases
 TEST_GEN_PROGS_arm64 += arm64/debug-exceptions
+TEST_GEN_PROGS_arm64 += arm64/host_sve
 TEST_GEN_PROGS_arm64 += arm64/hypercalls
 TEST_GEN_PROGS_arm64 += arm64/mmio_abort
 TEST_GEN_PROGS_arm64 += arm64/page_fault_test
diff --git a/tools/testing/selftests/kvm/arm64/host_sve.c b/tools/testing/selftests/kvm/arm64/host_sve.c
new file mode 100644
index 000000000000..3826772fd470
--- /dev/null
+++ b/tools/testing/selftests/kvm/arm64/host_sve.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Host SVE: Check FPSIMD/SVE/SME save/restore over KVM_RUN ioctls.
+ *
+ * Copyright 2025 Arm, Ltd
+ */
+
+#include <errno.h>
+#include <signal.h>
+#include <sys/auxv.h>
+#include <asm/kvm.h>
+#include <kvm_util.h>
+
+#include "ucall_common.h"
+
+static void guest_code(void)
+{
+	for (int i = 0; i < 10; i++) {
+		GUEST_UCALL_NONE();
+	}
+
+	GUEST_DONE();
+}
+
+void handle_sigill(int sig, siginfo_t *info, void *ctx)
+{
+	ucontext_t *uctx = ctx;
+
+	printf("  < host signal %d >\n", sig);
+
+	/*
+	 * Skip the UDF
+	 */
+	uctx->uc_mcontext.pc += 4;
+}
+
+void register_sigill_handler(void)
+{
+	struct sigaction sa = {
+		.sa_sigaction = handle_sigill,
+		.sa_flags = SA_SIGINFO,
+	};
+	sigaction(SIGILL, &sa, NULL);
+}
+
+static void do_sve_roundtrip(void)
+{
+	unsigned long before, after;
+
+	/*
+	 * Set all bits in a predicate register, force a save/restore via a
+	 * SIGILL (which handle_sigill() will recover from), then report
+	 * whether the value has changed.
+	 */
+	asm volatile(
+	"	.arch_extension sve\n"
+	"	ptrue	p0.B\n"
+	"	cntp	%[before], p0, p0.B\n"
+	"	udf #0\n"
+	"	cntp	%[after], p0, p0.B\n"
+	: [before] "=r" (before),
+	  [after] "=r" (after)
+	:
+	: "p0"
+	);
+
+	if (before != after) {
+		TEST_FAIL("Signal roundtrip discarded predicate bits (%ld => %ld)\n",
+			  before, after);
+	} else {
+		printf("Signal roundtrip preserved predicate bits (%ld => %ld)\n",
+		       before, after);
+	}
+}
+
+static void test_run(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	bool guest_done = false;
+
+	register_sigill_handler();
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	do_sve_roundtrip();
+
+	while (!guest_done) {
+
+		printf("Running VCPU...\n");
+		vcpu_run(vcpu);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_NONE:
+			do_sve_roundtrip();
+			do_sve_roundtrip();
+			break;
+		case UCALL_DONE:
+			guest_done = true;
+			break;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			break;
+		default:
+			TEST_FAIL("Unexpected guest exit");
+		}
+	}
+
+	kvm_vm_free(vm);
+}
+
+int main(void)
+{
+	/*
+	 * This is testing the host environment, we don't care about
+	 * guest SVE support.
+	 */
+	if (!(getauxval(AT_HWCAP) & HWCAP_SVE)) {
+		printf("SVE not supported\n");
+		return KSFT_SKIP;
+	}
+
+	test_run();
+	return 0;
+}

---
base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
change-id: 20250226-kvm-selftest-sve-signal-1add0d9d716c

Best regards,
-- 
Mark Brown <broonie@kernel.org>


