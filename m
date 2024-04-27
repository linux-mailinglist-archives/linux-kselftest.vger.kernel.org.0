Return-Path: <linux-kselftest+bounces-8974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF3E8B45D8
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 13:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC127B21857
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 11:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9584C62E;
	Sat, 27 Apr 2024 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JtLN/VWf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D334AECA;
	Sat, 27 Apr 2024 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216786; cv=none; b=Y5OMkrVx2JeF1AGVdG6NDm24QIfCMEIREQ2+TYmSTNJYkk+G/ODNgRtLTIAY/oQpADkGi567zX3HqOdvpUzr6IV1dgh/yWEqzllyMYju9yipxruhwwHPviTUsVF3nZBu0NZDP5YkoDA0VHwW09HiYzTKxUH/xAI1JKT6WOEUWE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216786; c=relaxed/simple;
	bh=Dq+iRmfWqC+oGnGc6SEeDBeFDmm4R5sqzPe9lbeFNTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrp9kVnAqnQDxYjbVMnhvn4SWui+vxbtaKPKhu5ArCrRo9ogzXDA/zDE9QWSvkueXlw5emsBMC3ZNENXRAuHxl5IuLFe2cFiEKzBGHYZFX0AbNqP5NZQSikP4JODuiJtFyuD8YcU283ta9f2f4nyCXXj+IkpXjnnbfes2pv9mas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JtLN/VWf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=d0tAW7inZvisjFhc/6LlLKz7+e8DpSZwRtoGBfIOh4A=; b=JtLN/VWf8Z8yb3DPEbmLy4nfEo
	Hr5/kRZzEYroae3l2E6WUPDewL6IsPxF5tnvl0NsESmHSHXiOIUArvDwwU0Eg6MHbuZcN7JsmnA5j
	CSl1JSWDf1mBps72xbPc1M3XKzNxyieTYaSu8YfJXVhqNYkQbBS2M/lcmZu0qqgYzIKfdvzUbYJSb
	iWvZokogEjUBhs2kON747zNHeI0oJcCLbxB/NOC3SB8YBoMEzjgs4fXL0OUOYJFqFAc10MDBMsJ0r
	lMUyYDu0OaHoT+9tNtdro+Rikssf+zBgcvG+vz7VRzIcmXVU2V4G/3m5pZT38fe/dfgVr6HBZbIfm
	VCb22SdQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5g-00000007Jwi-2KCE;
	Sat, 27 Apr 2024 11:19:37 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5g-000000002bF-08v0;
	Sat, 27 Apr 2024 12:19:36 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paul Durrant <paul@xen.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	jalliste@amazon.co.uk,
	sveith@amazon.de,
	zide.chen@intel.com,
	Dongli Zhang <dongli.zhang@oracle.com>
Subject: [PATCH v2 04/15] KVM: selftests: Add KVM/PV clock selftest to prove timer correction
Date: Sat, 27 Apr 2024 12:05:01 +0100
Message-ID: <20240427111929.9600-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240427111929.9600-1-dwmw2@infradead.org>
References: <20240427111929.9600-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: Jack Allister <jalliste@amazon.com>

A VM's KVM/PV clock has an inherent relationship to its TSC (guest). When
either the host system live-updates or the VM is live-migrated this pairing
of the two clock sources should stay the same.

In reality this is not the case without some correction taking place. Two
new IOCTLs (KVM_GET_CLOCK_GUEST/KVM_SET_CLOCK_GUEST) can be utilized to
perform a correction on the PVTI (PV time information) structure held by
KVM to effectively fixup the kvmclock_offset prior to the guest VM resuming
in either a live-update/migration scenario.

This test proves that without the necessary fixup there is a perceived
change in the guest TSC & KVM/PV clock relationship before and after a LU/
LM takes place.

The following steps are made to verify there is a delta in the relationship
and that it can be corrected:

1. PVTI is sampled by guest at boot (let's call this PVTI0).
2. Induce a change in PVTI data (KVM_REQ_MASTERCLOCK_UPDATE).
3. PVTI is sampled by guest after change (PVTI1).
4. Correction is requested by usermode to KVM using PVTI0.
5. PVTI is sampled by guest after correction (PVTI2).

The guest the records a singular TSC reference point in time and uses it to
calculate 3 KVM clock values utilizing the 3 recorded PVTI prior. Let's
call each clock value CLK[0-2].

In a perfect world CLK[0-2] should all be the same value if the KVM clock
& TSC relationship is preserved across the LU/LM (or faked in this test),
however it is not.

A delta can be observed between CLK0-CLK1 due to KVM recalculating the PVTI
(and the inaccuracies associated with that). A delta of ~3500ns can be
observed if guest TSC scaling to half host TSC frequency is also enabled,
where as without scaling this is observed at ~180ns.

With the correction it should be possible to achieve a delta of ±1ns.

An option to enable guest TSC scaling is available via invoking the tester
with -s/--scale-tsc.

Example of the test output below:
* selftests: kvm: pvclock_test
* scaling tsc from 2999999KHz to 1499999KHz
* before=5038374946 uncorrected=5038371437 corrected=5038374945
* delta_uncorrected=3509 delta_corrected=1

Signed-off-by: Jack Allister <jalliste@amazon.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
CC: Dongli Zhang <dongli.zhang@oracle.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/pvclock_test.c       | 192 ++++++++++++++++++
 2 files changed, 193 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/pvclock_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 871e2de3eb05..e33f56fedb0c 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -87,6 +87,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/pmu_counters_test
 TEST_GEN_PROGS_x86_64 += x86_64/pmu_event_filter_test
 TEST_GEN_PROGS_x86_64 += x86_64/private_mem_conversions_test
 TEST_GEN_PROGS_x86_64 += x86_64/private_mem_kvm_exits_test
+TEST_GEN_PROGS_x86_64 += x86_64/pvclock_test
 TEST_GEN_PROGS_x86_64 += x86_64/set_boot_cpu_id
 TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
 TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
diff --git a/tools/testing/selftests/kvm/x86_64/pvclock_test.c b/tools/testing/selftests/kvm/x86_64/pvclock_test.c
new file mode 100644
index 000000000000..376ffb730a53
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/pvclock_test.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright © 2024, Amazon.com, Inc. or its affiliates.
+ *
+ * Tests for pvclock API
+ * KVM_SET_CLOCK_GUEST/KVM_GET_CLOCK_GUEST
+ */
+#include <asm/pvclock.h>
+#include <asm/pvclock-abi.h>
+#include <sys/stat.h>
+#include <stdint.h>
+#include <stdio.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+enum {
+	STAGE_FIRST_BOOT,
+	STAGE_UNCORRECTED,
+	STAGE_CORRECTED
+};
+
+#define KVMCLOCK_GPA 0xc0000000ull
+#define KVMCLOCK_SIZE sizeof(struct pvclock_vcpu_time_info)
+
+static void trigger_pvti_update(vm_paddr_t pvti_pa)
+{
+	/*
+	 * We need a way to trigger KVM to update the fields
+	 * in the PV time info. The easiest way to do this is
+	 * to temporarily switch to the old KVM system time
+	 * method and then switch back to the new one.
+	 */
+	wrmsr(MSR_KVM_SYSTEM_TIME, pvti_pa | KVM_MSR_ENABLED);
+	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, pvti_pa | KVM_MSR_ENABLED);
+}
+
+static void guest_code(vm_paddr_t pvti_pa)
+{
+	struct pvclock_vcpu_time_info *pvti_va =
+		(struct pvclock_vcpu_time_info *)pvti_pa;
+
+	struct pvclock_vcpu_time_info pvti_boot;
+	struct pvclock_vcpu_time_info pvti_uncorrected;
+	struct pvclock_vcpu_time_info pvti_corrected;
+	uint64_t cycles_boot;
+	uint64_t cycles_uncorrected;
+	uint64_t cycles_corrected;
+	uint64_t tsc_guest;
+
+	/*
+	 * Setup the KVMCLOCK in the guest & store the original
+	 * PV time structure that is used.
+	 */
+	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, pvti_pa | KVM_MSR_ENABLED);
+	pvti_boot = *pvti_va;
+	GUEST_SYNC(STAGE_FIRST_BOOT);
+
+	/*
+	 * Trigger an update of the PVTI, if we calculate
+	 * the KVM clock using this structure we'll see
+	 * a delta from the TSC.
+	 */
+	trigger_pvti_update(pvti_pa);
+	pvti_uncorrected = *pvti_va;
+	GUEST_SYNC(STAGE_UNCORRECTED);
+
+	/*
+	 * The test should have triggered the correction by this
+	 * point in time. We have a copy of each of the PVTI structs
+	 * at each stage now.
+	 *
+	 * Let's sample the timestamp at a SINGLE point in time and
+	 * then calculate what the KVM clock would be using the PVTI
+	 * from each stage.
+	 *
+	 * Then return each of these values to the tester.
+	 */
+	pvti_corrected = *pvti_va;
+	tsc_guest = rdtsc();
+
+	cycles_boot = __pvclock_read_cycles(&pvti_boot, tsc_guest);
+	cycles_uncorrected = __pvclock_read_cycles(&pvti_uncorrected, tsc_guest);
+	cycles_corrected = __pvclock_read_cycles(&pvti_corrected, tsc_guest);
+
+	GUEST_SYNC_ARGS(STAGE_CORRECTED, cycles_boot, cycles_uncorrected,
+			cycles_corrected, 0);
+}
+
+static void run_test(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+	struct pvclock_vcpu_time_info pvti_before;
+	uint64_t before, uncorrected, corrected;
+	int64_t delta_uncorrected, delta_corrected;
+	struct ucall uc;
+	uint64_t ucall_reason;
+
+	/* Loop through each stage of the test. */
+	while (true) {
+
+		/* Start/restart the running vCPU code. */
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		/* Retrieve and verify our stage. */
+		ucall_reason = get_ucall(vcpu, &uc);
+		TEST_ASSERT(ucall_reason == UCALL_SYNC,
+			    "Unhandled ucall reason=%lu",
+			    ucall_reason);
+
+		/* Run host specific code relating to stage. */
+		switch (uc.args[1]) {
+		case STAGE_FIRST_BOOT:
+			/* Store the KVM clock values before an update. */
+			vcpu_ioctl(vcpu, KVM_GET_CLOCK_GUEST, &pvti_before);
+
+			/* Sleep for a set amount of time to increase delta. */
+			sleep(5);
+			break;
+
+		case STAGE_UNCORRECTED:
+			/* Restore the KVM clock values. */
+			vcpu_ioctl(vcpu, KVM_SET_CLOCK_GUEST, &pvti_before);
+			break;
+
+		case STAGE_CORRECTED:
+			/* Query the clock information and verify delta. */
+			before = uc.args[2];
+			uncorrected = uc.args[3];
+			corrected = uc.args[4];
+
+			delta_uncorrected = before - uncorrected;
+			delta_corrected = before - corrected;
+
+			pr_info("before=%lu uncorrected=%lu corrected=%lu\n",
+				before, uncorrected, corrected);
+
+			pr_info("delta_uncorrected=%ld delta_corrected=%ld\n",
+				delta_uncorrected, delta_corrected);
+
+			TEST_ASSERT((delta_corrected <= 1) && (delta_corrected >= -1),
+				    "larger than expected delta detected = %ld", delta_corrected);
+			return;
+		}
+	}
+}
+
+static void configure_pvclock(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+	unsigned int gpages;
+
+	gpages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, KVMCLOCK_SIZE);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    KVMCLOCK_GPA, 1, gpages, 0);
+	virt_map(vm, KVMCLOCK_GPA, KVMCLOCK_GPA, gpages);
+
+	vcpu_args_set(vcpu, 1, KVMCLOCK_GPA);
+}
+
+static void configure_scaled_tsc(struct kvm_vcpu *vcpu)
+{
+	uint64_t tsc_khz;
+
+	tsc_khz =  __vcpu_ioctl(vcpu, KVM_GET_TSC_KHZ, NULL);
+	pr_info("scaling tsc from %ldKHz to %ldKHz\n", tsc_khz, tsc_khz / 2);
+	tsc_khz /= 2;
+	vcpu_ioctl(vcpu, KVM_SET_TSC_KHZ, (void *)tsc_khz);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	bool scale_tsc;
+
+	scale_tsc = argc > 1 && (!strncmp(argv[1], "-s", 3) ||
+				 !strncmp(argv[1], "--scale-tsc", 10));
+
+	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	configure_pvclock(vm, vcpu);
+
+	if (scale_tsc)
+		configure_scaled_tsc(vcpu);
+
+	run_test(vm, vcpu);
+
+	return 0;
+}
-- 
2.44.0


