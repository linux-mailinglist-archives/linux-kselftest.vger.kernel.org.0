Return-Path: <linux-kselftest+bounces-6038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1E68747B7
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 06:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B4B28200F
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 05:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AA31CABE;
	Thu,  7 Mar 2024 05:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lzibkzoi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD65A1CA81;
	Thu,  7 Mar 2024 05:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709790414; cv=fail; b=PVwFrkb90XFXFcpVqfDmjwGnM+xc5kLu0reV2BbU0/dfvxashDRWTK2SyQJsbICTd0odfZ23stdp6nMLVR9BOM4BvUfQ2T4sEos3egJv0LYFzjtwBF71cKM9TDzvWwO71QUVwhjyMGVlPV9GckkX2NYEPnC3jxj8Ov134YdI7ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709790414; c=relaxed/simple;
	bh=c0qqNCoZ1BjWCamzX8Wj0FI8tw5sFKTIc977NKQ/RAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9zVN7qGKz4qAAIZ4OguUFEn5L81fBIjprXaM4yOKSX9HH30PsEdLkwfjCV+QhLKn9DvN3bV+qgymXWZUwnrQBTDXgRhoU22F/FawoTBovrsX/1LI2WYkfRnR/dErafDihiyvGPjZyesQkMkHR4FNvRgx3WBhVfK297Mdcyilh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lzibkzoi; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRuistx740COSSwjvgjBNSj5MY3WQNjAwxZW7wcpaPENramivCF3X545/Brxm2SM3sU4QggxBqofPaqOzgveA2aEu4N2mH+2mV9dI0QOm4/s4ys+9NG9Oeg0q+Jd95iRL7nPkDfsXB3kpGV/r9Z5hYKlrs5YIbnsA1UmtQzYysex7QC2pArsS3ucbr9emmOf9BEzGoBkAJeh0fZ1Wf47MLQWkxq7/C7R3ijbmlXeFgELd3nBBlmOBpVMBfZv72ZKprG5s8AAXvAvfLU4+KZSbL8nlZb6tlwF+lqm77K5rmhJJ/9Fsrk4t8yJYnPUPo9ibQWWvH1g/yeyXxyQXTSROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6MVw/l1yHU3lulYT4ZVcMcgUWub85R8yT6m9cZOkFw=;
 b=aBb4kUXR5mwH/q39dW7YxSN3IsjHnoOdw78r/+iLF7Hs0c92Bnye0dMNnxdYNcKc2kuixnhZowpGOhzU6Hv16gibAKzW0WjLj62ZhZjZkmHIHWLP1r27oKaKgQsLvb7TDaSWPT64v0m7XFDaCUEAL7A1cg86NO1B49Gw0lsSA4mBTtCprUkkdaRB6YTQeWDx7YCCSjHmtqyZVwnyTL1MVoupQJpjglJ3Xu86rH4G8hfNbbx7XBWYarJAFhS1A+gnhWobi2NtFUZTUiiy/G8DZSsAjPpivkx3tBPdtWq2u2APumauDMxppdJ4Q6Z56vAoiz7d366SEQwS1qLhfxXDeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6MVw/l1yHU3lulYT4ZVcMcgUWub85R8yT6m9cZOkFw=;
 b=LzibkzoigiegNKgoUMcptAoe4FF+bFa3jCQHt6MHYJ/t9uo4GNBvLsqHgbDqscZTJqgtqThtd/hJHDrEM4JsEe7p7NSMVSDNdLWYkTkpNUEVH+i3IyRYlniuR0iU8lt6E2weiFXrwQRT5IB8hSnr0r8LmGawseSwPtlr+AopIs8=
Received: from BL0PR0102CA0012.prod.exchangelabs.com (2603:10b6:207:18::25) by
 SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.24; Thu, 7 Mar 2024 05:46:50 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:207:18:cafe::f8) by BL0PR0102CA0012.outlook.office365.com
 (2603:10b6:207:18::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Thu, 7 Mar 2024 05:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 05:46:49 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 23:46:48 -0600
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<bp@alien8.de>, <manali.shukla@amd.com>
Subject: [PATCH v1 5/5] selftests: KVM: SVM: Add Idle HLT intercept test
Date: Thu, 7 Mar 2024 05:46:23 +0000
Message-ID: <20240307054623.13632-6-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307054623.13632-1-manali.shukla@amd.com>
References: <20240307054623.13632-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e0551a-e8ea-4bb8-f8c8-08dc3e69fbcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8AFR0dLH4yhZpeIXrXWiPx0LZoFobvd/a7QfCl7ncizdK65piQSKpehylibcsqHaIJR0jTQEVmkGWWmzkaRVdDPQaO6V89s0M4aQVSZMJzSI/n8urQQ1XTda+YaRliV95EKRyp5zsuXRKgW9x0UE9VyjM/Bah7n/RNbY+3NnW9a743sm1i5DHsSHGWtW+JXWE+QFQLGv+309gjvKu8bI/bUyUtB4uZcxpK5s27hCx27/qQkIwQ8r+R0fKnAITBlGdF48+Nj/1YRw2AVFm2VVhp2Aei5Ps+8XN5hwY3uyXo5GAsffw71Zdf99L64ivo/Jo5NrvWZJGtgl2NykXAK5g4ogBd/S6jDTr7874WQ5eGXUjgCXFs7EmKjsTWRBEugobsNFZSe2nfAT7h6TH/NCHVFHIDx2BFYnHanMkX6bx8EeZIP58DtxZe8X9sm1fCGuigwndo7D9vVdOMhWbO7RBck4y1ZzebL/o3GJVZEe+e3llk5mnr+qwwlbO+StNGrTp66mgLRvCrsNyKypGe4Me4bpA2uKpFYRYlsXwFnWB6+2dtzEFArw6jinXzr86Yx5ZdDjrK5HlY8yvdT6PssHFWkX/0IMvLFqvbqXJPATtXqw8+yZfOOvdBA4pFo0ZI7psVavcVMll8kEHapF6eNs2Ofvh53iHPIN5CMZIcqiWLFDs/Kc5ryd4rbkZvkw/WTjS8WZuqNcMDxLNUOwPE3/gcHrX6E/4fNn6xCu4k+joTFJb8S7yKTdJdzCo989CQYC
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 05:46:49.6235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e0551a-e8ea-4bb8-f8c8-08dc3e69fbcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848

From: Manali Shukla <Manali.Shukla@amd.com>

The Execution of the HLT instruction results in a VMEXIT. Hypervisor
observes pending V_INTR and V_NMI events just after the VMEXIT
generated by the HLT for the vCPU and causes VM entry to service the
pending events.  The Idle HLT intercept feature avoids the wasteful
VMEXIT during the halt if there are pending V_INTR and V_NMI events
for the vCPU.

The selftest for the Idle HLT intercept instruments the above-mentioned
scenario.

Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/svm_idlehlt_test.c   | 118 ++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/svm_idlehlt_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 492e937fab00..7ad03dc4f35e 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -89,6 +89,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
 TEST_GEN_PROGS_x86_64 += x86_64/smm_test
 TEST_GEN_PROGS_x86_64 += x86_64/state_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
+TEST_GEN_PROGS_x86_64 += x86_64/svm_idlehlt_test
 TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
 TEST_GEN_PROGS_x86_64 += x86_64/svm_int_ctl_test
 TEST_GEN_PROGS_x86_64 += x86_64/svm_nested_shutdown_test
diff --git a/tools/testing/selftests/kvm/x86_64/svm_idlehlt_test.c b/tools/testing/selftests/kvm/x86_64/svm_idlehlt_test.c
new file mode 100644
index 000000000000..1564511799d4
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/svm_idlehlt_test.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  svm_idlehalt_test
+ *
+ *  Copyright (C) 2024 Advanced Micro Devices, Inc.
+ *
+ *  For licencing details see kernel-base/COPYING
+ *
+ *  Author:
+ *  Manali Shukla  <manali.shukla@amd.com>
+ */
+#include "kvm_util.h"
+#include "svm_util.h"
+#include "processor.h"
+#include "test_util.h"
+#include "apic.h"
+
+#define VINTR_VECTOR     0x30
+#define NUM_ITERATIONS 100000
+
+/*
+ * Incremented in the VINTR handler. Provides evidence to the sender that the
+ * VINR is arrived at the destination.
+ */
+static volatile uint64_t vintr_rcvd;
+
+void verify_apic_base_addr(void)
+{
+	uint64_t msr = rdmsr(MSR_IA32_APICBASE);
+	uint64_t base = GET_APIC_BASE(msr);
+
+	GUEST_ASSERT(base == APIC_DEFAULT_GPA);
+}
+
+/*
+ * The halting guest code instruments the scenario where there is a V_INTR pending
+ * event available while hlt instruction is executed. The HLT VM Exit doesn't
+ * occur in above-mentioned scenario if the Idle HLT intercept feature is enabled.
+ */
+
+static void halter_guest_code(void)
+{
+	uint32_t icr_val;
+	int i;
+
+	verify_apic_base_addr();
+	xapic_enable();
+
+	icr_val = (APIC_DEST_SELF | APIC_INT_ASSERT | VINTR_VECTOR);
+
+	for (i = 0; i < NUM_ITERATIONS; i++) {
+		xapic_write_reg(APIC_ICR, icr_val);
+		asm volatile("sti; hlt; cli");
+	}
+	GUEST_DONE();
+}
+
+static void guest_vintr_handler(struct ex_regs *regs)
+{
+	vintr_rcvd++;
+	xapic_write_reg(APIC_EOI, 0x30);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	struct ucall uc;
+	uint64_t  halt_exits, vintr_exits;
+	uint64_t *pvintr_rcvd;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
+
+	/* Check the extension for binary stats */
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_BINARY_STATS_FD));
+
+	vm = vm_create_with_one_vcpu(&vcpu, halter_guest_code);
+
+	vm_init_descriptor_tables(vm);
+	vcpu_init_descriptor_tables(vcpu);
+	vm_install_exception_handler(vm, VINTR_VECTOR, guest_vintr_handler);
+	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	halt_exits = vcpu_get_stat(vcpu, "halt_exits");
+	vintr_exits = vcpu_get_stat(vcpu, "irq_window_exits");
+	pvintr_rcvd = (uint64_t *)addr_gva2hva(vm, (uint64_t)&vintr_rcvd);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		/* NOT REACHED */
+	case UCALL_DONE:
+		goto done;
+	default:
+		TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
+	}
+
+done:
+	TEST_ASSERT(halt_exits == 0,
+		    "Test Failed:\n"
+		    "Guest executed VINTR followed by halts: %d times\n"
+		    "The guest exited due to halt: %ld times and number\n"
+		    "of vintr exits: %ld and vintr got re-injected: %ld times\n",
+		    NUM_ITERATIONS, halt_exits, vintr_exits, *pvintr_rcvd);
+
+	fprintf(stderr,
+		"Test Successful:\n"
+		"Guest executed VINTR followed by halts: %d times\n"
+		"The guest exited due to halt: %ld times and number\n"
+		"of vintr exits: %ld and vintr got re-injected: %ld times\n",
+		NUM_ITERATIONS, halt_exits, vintr_exits, *pvintr_rcvd);
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.34.1


