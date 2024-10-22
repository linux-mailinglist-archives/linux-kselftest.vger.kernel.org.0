Return-Path: <linux-kselftest+bounces-20370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A28189A98EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 07:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279E71F23ED7
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 05:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3C213B280;
	Tue, 22 Oct 2024 05:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NupElujd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76E913D8A3;
	Tue, 22 Oct 2024 05:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729576117; cv=fail; b=U0fNBGpWkzlCNXG9pvOvTVKUWwGK3Wh0YaxGrCDYat0quDIN51jBWVxvhXxU/OhSdv0S2g0098rQHxB/RCDf5OTzH8yn4Tr7HqWO4JTK0kkWnrU+k9KAgla6sMNv//b6UOO4rWVHh2MWxahm7Y+/YRPZcI0daE+kyk8AXMzat80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729576117; c=relaxed/simple;
	bh=KQ8Mg8m6P94QNtSTdZclvzfNwVhh/10TsjnisGgslvo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkMqje3h/z3aCSKt34zVDGEXX8O3smogCKgcaWZU4tf0XKRtPqfykEbVYVI7GlBqqV3nm3PcqwQ+6uMpbTzIEeG0M9b3Nn1++lb7Ou9JSlWl2VTv0y9os3kHRvr2UAkpUXgQ4onatNSKN0F/nchWmx+/Sbv8i1OrUlCJ93oY35k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NupElujd; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QP2uEeABsdrCm6aeHakteja3wnF8xxZR/1V5lfEpAOWJMOg/wAVb66VfKGgoBFtoZPQ5MAFw3yPHJ5Wb+iBKhAtBNBvQKjIPGeIfWZPo85ky8RxctxpfVyEnDAcaTmQMlz2v/vY6bmBr1wIPyxyrt5vms+K+Kwksmgxkt296L92YtqxLuUp5yTrWhjWXvu2wMjT6AKaTL2IUUOg+QC1v0/iWFF7ivwdzRG4JGN1ZAdjb1JDzsCKCeo/XX5cdk6d/uCaQnRTBGEWoLePgzkWus9BR/7rjfUYCBAydwMrKtfgoyQWoX0F7HO93QKoPcqNt6lD8hZTWIEoGRYoqxaRIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1sWCVnMPzhuQjhvBehanKowo8g+FB0kzW25tpSpa0g=;
 b=S2OqesI1HzIVzPaRvDnqGdQMWPx8Ar54CuhOPozfTzIIJ/ef9czeKYwUQysmWt7jExPJfZk3ZAV8GedL5DxgA3DyQaewbWyW8KwOX3VcSSsRA7UE85/kuc4OwSmNEQGyBLUqBiwqeN+jbw+uNb5WlOKqgkyXhCeFnyylKPf2+Ok3KvcukYiQPXxh1SlO0o2/3H9wwbQ1TeBLUx4a0Hsg/B+dq67Q2QtIxfCq1Vx8/+oVaRBJdvt1OpUo5nUJZ4LPipQfTgW6F/2LzfIrkngYKwiheCNFWVdoRDcWrHrzrYJgrJLjYEfYn3hppHBb8GeObmyYIN8UBWbQuLRhFz8LUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1sWCVnMPzhuQjhvBehanKowo8g+FB0kzW25tpSpa0g=;
 b=NupElujd2rdb5+mAp9MyGS3A8EpVBLF5Iapd6uHzQOn2EkbZ6N7PWT2W1Yudr5bpDjzzx5bmftqbr5qM1msuwdUToAd6mNqRbyrhlM4Rjp9HEdAh36jnkRuX+1XpaE8yrjTjZcfz+oA4a7QGBKy/MNZpKHRN+ROEkWhl3ak+Sp0=
Received: from BYAPR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:40::41)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 05:48:30 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::ec) by BYAPR04CA0028.outlook.office365.com
 (2603:10b6:a03:40::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 05:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 05:48:30 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 00:48:28 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [PATCH v4 4/4] KVM: selftests: KVM: SVM: Add Idle HLT intercept test
Date: Tue, 22 Oct 2024 05:48:10 +0000
Message-ID: <20241022054810.23369-5-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022054810.23369-1-manali.shukla@amd.com>
References: <20241022054810.23369-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: ed08898a-c85e-43f4-5860-08dcf25d2863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BvGYQZ4mSTIKyvpqa8c15e6SzOqermbI6jkwlM5cqXVJYxM5C1LcDzUxFTGR?=
 =?us-ascii?Q?Kg5jScbFa8C/2Kl1oavakDf5jvxedu6oUsTMyhy6kTkJnOc52gb8VDKkrVQq?=
 =?us-ascii?Q?kHa7mHknIqi+x0iXjJWaZ7+BuBUL1dlLPTdekG0ybLt/eKzn6Sr77BzhpgfN?=
 =?us-ascii?Q?sGdbhkHQ3giQsftenPjE/cgUiRPEmkMNC4k0gxMFQEQlMpn4JAHlL1QfVomv?=
 =?us-ascii?Q?JT1G7BhDXDBATI9LwQ0GYsr9CGBGB5HIeoktFGQbDwHItv1364NgR8kSiaQG?=
 =?us-ascii?Q?gdkH/tHetwx8y5XF25fyIST1NPwa/PYIkpi5Df8RBSjR251ADXQp6AKRY+i8?=
 =?us-ascii?Q?WjeCk6br7oWv2DI6QfTMW3lmO7aBXrk8Ha8zcskVfoCxM77I7Jq9PJ0x+EgP?=
 =?us-ascii?Q?it6iZS1UAq/Vi4fgMvGWPR84IfIn59tXavVQQVX+4uoh1ngN/pxz7KAT5jqw?=
 =?us-ascii?Q?dj3+eknzT2oZ37x6ZGktzqASGSdGDg6drXpaNgVyUkOeUZE7QVEUXT0p798A?=
 =?us-ascii?Q?m9MPXnAEx+Y/7vSr9Jkyq3NxyZ9LZfgcPWcAy+4hJ0SgrvXMaO/HteYr97qy?=
 =?us-ascii?Q?mWTfF5A5NSlZuLpp76hyjCfjKwWzprky4sVKjIyEvbeidieIeXyjtkoC0zAV?=
 =?us-ascii?Q?rBpahEN4x8DGEIUaoMZZhBY2hswBOzKluKaaCGuMEJyDayAccn/NayLzG8Xh?=
 =?us-ascii?Q?4v0M9SyKo7nZLYmYI37YsxttI8E0lKPsw80brFrHFmxewqxBKkYKxiCs9Ahe?=
 =?us-ascii?Q?2FNa+0c4OToCagsOe5ol8+uQKbA/CT0w5yJLD3A6sSij5JmDibxC0ivHVQdf?=
 =?us-ascii?Q?w1oD/Rw+UCubWZKuNnosYPwNjyRCdHxBTVzcgXnRgkJvL9zKaPp0fGQQ52N2?=
 =?us-ascii?Q?c/kf5hoVshD9Zu97wjJsimLXGlsh4iNimwHZ3zQnuj5P2sstxu+H/pLFXwzd?=
 =?us-ascii?Q?xKMGADsPhXtZ+wT3fmIEkcVLFu4Iyx6F7rkxojy0HEiEhWUTSPDT+rGOSqee?=
 =?us-ascii?Q?tb6L+Q/VFpI0dchkJQNIK3dr7knCPrM5I0T4h/V6ok+rYi92ry/Tp3R9wMw6?=
 =?us-ascii?Q?CUFfXZ/rEakrDTquFYyrIwqWmBqYKcY63QK2s7P45Ynn+/grAasGuj0fEnvW?=
 =?us-ascii?Q?sZ0K2+6B9Lq6jszMbB6lPoj04FZvEp11ExNpcZm8epncLYvOjfxo7SZ7imaH?=
 =?us-ascii?Q?/1LPnZW+WmEayMMW8fbKB/MAD+JdsyzNytCrEs2GvD/O6QPRKtZATM2HB+4x?=
 =?us-ascii?Q?+RYkmkbzr39EbuXfvDs6x2rfEiMEXB2RHdmLl7/EuJjvoe0Qpd7ujqJ5vxFc?=
 =?us-ascii?Q?w1mWvHeI6PFUW2CsgwfdG/rN9/72q5ibs46fwXcUjO55t2jy1UuzZ8CI3/aD?=
 =?us-ascii?Q?dTJrkTp7oU6Mjl6qZwbAg6nzKDY8UlXVKrT19b7pbywPyJBimA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 05:48:30.1528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed08898a-c85e-43f4-5860-08dcf25d2863
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978

From: Manali Shukla <Manali.Shukla@amd.com>

Execution of the HLT instruction results in VMEXIT. Hypervisor observes
pending V_INTR and V_NMI events just after VMEXIT generated by HLT for
the vCPU and causes VM entry to service the pending events.  The Idle
HLT intercept feature avoids the wasteful VMEXIT during halt if there
are pending V_INTR and V_NMI events for the vCPU.

The selftest for Idle HLT intercept instruments above-mentioned scenario.

Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
---
 tools/testing/selftests/kvm/Makefile          |  1 +
 .../selftests/kvm/include/x86_64/processor.h  |  1 +
 .../selftests/kvm/x86_64/svm_idle_hlt_test.c  | 89 +++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 960cf6a77198..25e4bc9473d5 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -94,6 +94,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
 TEST_GEN_PROGS_x86_64 += x86_64/smm_test
 TEST_GEN_PROGS_x86_64 += x86_64/state_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
+TEST_GEN_PROGS_x86_64 += x86_64/svm_idle_hlt_test
 TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
 TEST_GEN_PROGS_x86_64 += x86_64/svm_int_ctl_test
 TEST_GEN_PROGS_x86_64 += x86_64/svm_nested_shutdown_test
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 8e36de85b68f..41815d6ae500 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -197,6 +197,7 @@ struct kvm_x86_cpu_feature {
 #define X86_FEATURE_PAUSEFILTER         KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 10)
 #define X86_FEATURE_PFTHRESHOLD         KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 12)
 #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
+#define X86_FEATURE_IDLE_HLT		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 30)
 #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
 
diff --git a/tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.c b/tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.c
new file mode 100644
index 000000000000..fe2ea96695e4
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Copyright (C) 2024 Advanced Micro Devices, Inc.
+ *
+ */
+#include <kvm_util.h>
+#include <processor.h>
+#include <test_util.h>
+#include "svm_util.h"
+#include "apic.h"
+
+#define VINTR_VECTOR     0x30
+#define NUM_ITERATIONS   1000
+
+static bool irq_received;
+
+/*
+ * The guest code instruments the scenario where there is a V_INTR pending
+ * event available while hlt instruction is executed. The HLT VM Exit doesn't
+ * occur in above-mentioned scenario if Idle HLT intercept feature is enabled.
+ */
+
+static void guest_code(void)
+{
+	uint32_t icr_val;
+	int i;
+
+	xapic_enable();
+
+	icr_val = (APIC_DEST_SELF | APIC_INT_ASSERT | VINTR_VECTOR);
+
+	for (i = 0; i < NUM_ITERATIONS; i++) {
+		cli();
+		xapic_write_reg(APIC_ICR, icr_val);
+		safe_halt();
+		GUEST_ASSERT(READ_ONCE(irq_received));
+		WRITE_ONCE(irq_received, false);
+	}
+	GUEST_DONE();
+}
+
+static void guest_vintr_handler(struct ex_regs *regs)
+{
+	WRITE_ONCE(irq_received, true);
+	xapic_write_reg(APIC_EOI, 0x00);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	struct ucall uc;
+	uint64_t  halt_exits, vintr_exits;
+
+	/* Check the extension for binary stats */
+	TEST_REQUIRE(this_cpu_has(X86_FEATURE_IDLE_HLT));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_BINARY_STATS_FD));
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	vm_install_exception_handler(vm, VINTR_VECTOR, guest_vintr_handler);
+	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	halt_exits = vcpu_get_stat(vcpu, halt_exits);
+	vintr_exits = vcpu_get_stat(vcpu, irq_window_exits);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		/* NOT REACHED */
+	case UCALL_DONE:
+		break;
+
+	default:
+		TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
+	}
+
+	TEST_ASSERT_EQ(halt_exits, 0);
+	pr_debug("Guest executed VINTR followed by halts: %d times.\n"
+		 "The guest exited due to halt: %ld times and number\n"
+		 "of vintr exits: %ld.\n",
+		 NUM_ITERATIONS, halt_exits, vintr_exits);
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.34.1


