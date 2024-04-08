Return-Path: <linux-kselftest+bounces-7436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A739989CE41
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 00:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207641F226A9
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 22:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96814149C4E;
	Mon,  8 Apr 2024 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="L/awBl//"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B303148854;
	Mon,  8 Apr 2024 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712614090; cv=none; b=kDtrmafRU8rDj4rik0sc5y6AgUnJDSCUk+vebbccrDgKSYOvw1rhhCpS+eyXVpXP7gUmrTXJNgsS1qN2Eh7szibsM2Dn4HA/qt/zOTgfVScQCidovDVVkZW1j1HweIxRKQaVz7jT4pQyDhJvqq5LZ7A3vpsKdV4mdPaX9yLpsKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712614090; c=relaxed/simple;
	bh=6mi6jakl+vhCGrJBzcTDV5CynKVnsfEKynhyvw4ZIDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dASbqCJKUADgIzljlOmcYCYdc6auJVnuGyxkyWb32cDPdTBJ4FJSV4aPOy+2Vvgi6UGEQkHamPvzcBUvs7H3ZUzz98XQi4r6uInID5GomJDHOW85vZgIMhMXqFzs0J9u/ixBTH8jhjs9wpuQ2hUmTcNHjn5Es8DvZ4mXl6Iphoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=L/awBl//; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712614089; x=1744150089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DvVGnq9BylvqxGBtmGF6jdpkEtxi98A9Ndid/G/EBM0=;
  b=L/awBl//QGb1Q1HlNwZLYh+88tvWWQEKzIbdFH/v6eSCa2sIKGP4THDz
   i5Ei6xaaO0FKBVDCt8de4Kjro4z8JujvHwcbGegWlxCt2UVtd+MC5hqr5
   koyRqJNLavRZocMLHjqN8d0lNeMtzxFD3+vHzJGHKBrhbKc9dx4R5joG2
   E=;
X-IronPort-AV: E=Sophos;i="6.07,187,1708387200"; 
   d="scan'208";a="646453268"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 22:08:05 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:64060]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.5.247:2525] with esmtp (Farcaster)
 id 4bf308e4-6f56-4b76-8126-c5904501e6ab; Mon, 8 Apr 2024 22:08:03 +0000 (UTC)
X-Farcaster-Flow-ID: 4bf308e4-6f56-4b76-8126-c5904501e6ab
Received: from EX19D033EUB003.ant.amazon.com (10.252.61.76) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 8 Apr 2024 22:08:03 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D033EUB003.ant.amazon.com (10.252.61.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 8 Apr 2024 22:08:02 +0000
Received: from dev-dsk-jalliste-1c-e3349c3e.eu-west-1.amazon.com
 (10.13.244.142) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28 via Frontend Transport; Mon, 8 Apr 2024 22:08:01 +0000
From: Jack Allister <jalliste@amazon.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>
CC: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, "Jack
 Allister" <jalliste@amazon.com>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH 2/2] KVM: selftests: Add KVM/PV clock selftest to prove timer drift correction
Date: Mon, 8 Apr 2024 22:07:04 +0000
Message-ID: <20240408220705.7637-3-jalliste@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240408220705.7637-1-jalliste@amazon.com>
References: <20240408220705.7637-1-jalliste@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

This test proves that there is an inherent KVM/PV clock drift away from the
guest TSC when KVM decides to update the PV time information structure due
to a KVM_REQ_MASTERCLOCK_UPDATE. This drift is exascerbated when a guest is
using TSC scaling and running at a different frequency to the host TSC [1].
It also proves that KVM_[GS]ET_CLOCK_GUEST API is working to mitigate the
drift from TSC to within ±1ns.

The test simply records the PVTI (PV time information) at time of guest
creation, after KVM has updated it's mapped PVTI structure and once the
correction has taken place.

A singular point in time is then recorded via the guest TSC and is used to
calculate the a PV clock value using each of the 3 PVTI structures.

As seen below a drift of ~3500ns is observed if no correction has taken
place after KVM has updated the PVTI via master clock update. However,
after the correction a delta of at most 1ns can be seen.

* selftests: kvm: pvclock_test
* scaling tsc from 2999999KHz to 1499999KHz
* before=5038374946 uncorrected=5038371437 corrected=5038374945
* delta_uncorrected=3509 delta_corrected=1

Clocksource check code has been borrowed from [2].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=451a707813ae
[2]: https://lore.kernel.org/kvm/20240106083346.29180-1-dongli.zhang@oracle.com/

Signed-off-by: Jack Allister <jalliste@amazon.com>
CC: David Woodhouse <dwmw2@infradead.org>
CC: Paul Durrant <paul@xen.org>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/pvclock_test.c       | 223 ++++++++++++++++++
 2 files changed, 224 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/pvclock_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 741c7dc16afc..02ee1205bbed 100644
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
index 000000000000..172ef4d19c60
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/pvclock_test.c
@@ -0,0 +1,223 @@
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
+	STAGE_CORRECTED,
+	NUM_STAGES
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
+	 * a drift from the TSC.
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
+	struct ucall uc;
+	uint64_t ucall_reason;
+	struct pvclock_vcpu_time_info pvti_before;
+	uint64_t before, uncorrected, corrected;
+	int64_t delta_uncorrected, delta_corrected;
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
+			vm_ioctl(vm, KVM_GET_CLOCK_GUEST, &pvti_before);
+
+			/* Sleep for a set amount of time to induce drift. */
+			sleep(5);
+			break;
+
+		case STAGE_UNCORRECTED:
+			/* Restore the KVM clock values. */
+			vm_ioctl(vm, KVM_SET_CLOCK_GUEST, &pvti_before);
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
+#define CLOCKSOURCE_PATH "/sys/devices/system/clocksource/clocksource0/current_clocksource"
+
+static void check_clocksource(void)
+{
+	char *clk_name;
+	struct stat st;
+	FILE *fp;
+
+	fp = fopen(CLOCKSOURCE_PATH, "r");
+	if (!fp) {
+		pr_info("failed to open clocksource file: %d; assuming TSC.\n",
+			errno);
+		return;
+	}
+
+	if (fstat(fileno(fp), &st)) {
+		pr_info("failed to stat clocksource file: %d; assuming TSC.\n",
+			errno);
+		goto out;
+	}
+
+	clk_name = malloc(st.st_size);
+	TEST_ASSERT(clk_name, "failed to allocate buffer to read file\n");
+
+	if (!fgets(clk_name, st.st_size, fp)) {
+		pr_info("failed to read clocksource file: %d; assuming TSC.\n",
+			ferror(fp));
+		goto out;
+	}
+
+	TEST_ASSERT(!strncmp(clk_name, "tsc\n", st.st_size),
+		    "clocksource not supported: %s", clk_name);
+out:
+	fclose(fp);
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
+int main(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	check_clocksource();
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	configure_pvclock(vm, vcpu);
+	configure_scaled_tsc(vcpu);
+
+	run_test(vm, vcpu);
+
+	return 0;
+}
-- 
2.40.1


