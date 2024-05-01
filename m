Return-Path: <linux-kselftest+bounces-9214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3388B8C38
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 16:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFBA51C2183E
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 14:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3094812F5B4;
	Wed,  1 May 2024 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xCkwmAZP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7106C12EBCC;
	Wed,  1 May 2024 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575327; cv=fail; b=bq1df1WdtZvhdhrd7Q/Uk6o2XIt3RsSORA+vuxT0AR+SBbUBxH7jElIu+5Axxn+UjDpiW09fjqxnz+mt0pSbQC86Orm/6G/9K1qRcsTPGlxhEzuV/o4AJDNMHmTb8wbnAsq/TFXpWImfmVc1CS6XeR9EXvyySujUtWyVQm9faPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575327; c=relaxed/simple;
	bh=TjAb69OVRcVxE+ATZRBVvDKSBq0XOqz4+21X4RPthus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1UcIyVYEDTorjqTFkmQ7+oabeDmsJwWU37TDgMjOJBOjxfwr1Lzy2T3hDd3SYH+TE+Zt4OmMfMSyMsuC8CoxQVCYqcGhtdWmGH5oSBNnHt3kPA7Uiu/xr+eMITckW5WOIAor6dLvUOkvRSeuwpzZsTBPD/pxYEsdxUWDcfe/d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xCkwmAZP; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHYvJrCKTVhxlw1XKMLaP//kuAkA5TleyBq+dFg3hB2kAyTIBEEM2o2OwAj5XRk6v827BnkNzeE+mzS1yGQprvSuIgu6LXWkqnBhOpgu9NJD/ANRhpksQrc+Kfcf6UNrMYZFR9aCTgZud3lzm6Z0tu1OJatwQyqTPilUHqX+CuoEGNOWT6xEnqEUJEOpwA00vhQD2vMcsnNy4E1oY9GR+OEl/lXj6AF4CP5n5djZvp+3m2BmTB6ugWQcvSQkNWXdpxWrIf2bmRD2OKFwmrkiaTD5JJ6nYoUI6TnlvjzuaqdVp58U+/JDEK2p2G/nGquCjdnCGRUCne4nW+VZS8dWTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKpmEanb1+kqijWMrcl26r9SQLcjXziANdt0nCooqrI=;
 b=D5F/UjLCUiM17qmJDlwgoY35qgwzMHTPJ4JdO/IVakwIV2+UJNIktkjl9sZaWSRdIoqS1WSi/nbJZgbLZTxoPwfUfA6zS+cnni6bz62tq6ccMXtEfOdglULfx9J1iQm+i2GmA6TROk1d0dNQQK/9yE67xu0aImtikKtEjgTOruiOvUnFquTQDKcSatXq8fbuemQpFIfVrB6u6sjX1IIc3nFVSCG66/tR5GmPK9if84plJydGVthAL9s4jdN0jNkcV8S9SNkqvQxqsmzxuvbucrMbFVFPXr4vrCsu9nMI56LPTjyAG7Y3wXseg9vzOSGj9AoQDtQt27l5V9hGk333mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKpmEanb1+kqijWMrcl26r9SQLcjXziANdt0nCooqrI=;
 b=xCkwmAZPx4K5PWka1fBwp/JYJhkUmPW+PoW/3B513FDjNSj2cg55ZUlOWMGyKoJHwU7eBcA///ujDivunMZdpiORbT2SMD8AoWIFYonldLbPQmE9aw8IC3/AUoX1M9tW+HmNgNfX5/JGgMffO18KNkNFIqp0yPBopnS/TcKGhU0=
Received: from CH0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:610:76::35)
 by LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25; Wed, 1 May
 2024 14:55:22 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:76:cafe::a3) by CH0PR04CA0030.outlook.office365.com
 (2603:10b6:610:76::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28 via Frontend
 Transport; Wed, 1 May 2024 14:55:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Wed, 1 May 2024 14:55:22 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 09:55:18 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>
Subject: [PATCH v2 5/5] KVM: selftests: KVM: SVM: Add Idle HLT intercept test
Date: Wed, 1 May 2024 14:54:33 +0000
Message-ID: <20240501145433.4070-6-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501145433.4070-1-manali.shukla@amd.com>
References: <20240501145433.4070-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|LV3PR12MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6f3479-1b80-4f97-50e5-08dc69eeb9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400014|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yPWkM2SAHPbM1sWj+5bSEtQRzeNTqCsdVmr5yYvRXcqQJtu0QcjEI21JHXzk?=
 =?us-ascii?Q?OrKiVjMUHRUCSavspunSEVMWMyXDqk2oks4eQ6KhqosKqCAZg0fEwEkGRGEt?=
 =?us-ascii?Q?lcPLpUyBG/2HYDkC826AKsnuVCNG3+IKMdJAjay6qne6FgsabDGkmP2klzJH?=
 =?us-ascii?Q?S+rPXEQ6O2aDF/XlmTdtIS7u5Qyc2Fm9dmAnOp6o4XyYEtTTec7O8G71HTWx?=
 =?us-ascii?Q?nGOt1OQpH6RwBYvUgnRSdq0uHvMBUocUDtiia9x3Lxj6W4IEBnAc3tvstZmA?=
 =?us-ascii?Q?B+f71Px5FDB1z9hSrGXdYmnwAcSYeSQTmGZ7730KgcNMpJ7cU2X9wdFzQ4o4?=
 =?us-ascii?Q?gJDWf2cUp9Cc9liXrHM/QXjwzRWyPxnutyKxr3LMYmqKoxF/FMDknkzHX9Rb?=
 =?us-ascii?Q?v7pNe3eIiLzghWw6TXtyhn3oCgmhE9Iit+j+/JPVdkuy4sQiiViXQjcFcQK4?=
 =?us-ascii?Q?+P/nIhHzhuMn1wdkh0ABQ+7SwIRCwKSr87Hrg/knRiQUDh3smu8cbk82odgg?=
 =?us-ascii?Q?iYDlpRWymFUzDBCBAr070hAT0E2Me+ZYzil4MaprhfLUuJ5vtGK5DrwWLzwI?=
 =?us-ascii?Q?0khtNw960cgNhLkHb01+vUaOtiIK2rYHmXfiF6Vzfiabb51MfpjeOOSgttZ6?=
 =?us-ascii?Q?Yxnec+f1hfGPzvjyvGKc2P8wh4NRo6U7v+SNPlXB7Bl9tV27pb5payou602l?=
 =?us-ascii?Q?JBDsbRSWNvvDTfYF3BLwq3PO9JNRVelYlio1v65QWuLOcqwJ9oBmTZB39OeH?=
 =?us-ascii?Q?6MhkPgO+QFbAtUT8n3X7SDCsxgmlnW0QPf6N9Mu+Z/ygAjxXGehOaFt6LRM8?=
 =?us-ascii?Q?HoqWWReKX9Ozf4phxmVqtXIAnXKt02X7oprlvqVM8/TDmMQRUKj56KxSywyP?=
 =?us-ascii?Q?CsEyC5DTmBBUItpW9t72G4+y31zOC965PH4jUClzawmTAegqg0ng9HHRj3J0?=
 =?us-ascii?Q?6YRwSrOhuUKisV8AQ7bvwy23JqIN6JqseDPCWkmmiSz47Lu0bIJwoR7FqEE1?=
 =?us-ascii?Q?XMfYk1G0yAsM4lLvII+qnWAXmIRlzn9yi2sw4xqgQ54wL8A6hnulo2ABDzWy?=
 =?us-ascii?Q?8hMRixMHL1wnfwQqJbgCU3WkgyE9dCdfrcvT+yAAnUb+24Wt+zRzoTUOi0iO?=
 =?us-ascii?Q?IzO9M3XtdNOvsnnGufgVZoaEfrXQQvVeD8UCXbLpH4ItlMUDKt0qerI4daPZ?=
 =?us-ascii?Q?/Vu7ULmQ1p3CL9GhAue5SZWFWMrzNGjn2we1iayM57RD4/RQnOW3GHCAw1Kc?=
 =?us-ascii?Q?QSoewY7lgHUIVBC5slOdnitf7TW7bc2X2tIGhr/itN5y+JdOxPOFrhnEvFC6?=
 =?us-ascii?Q?jfmBitfazAJpGdAAhUbMIiFfvPtM8pRvpyZUPb1qoimzkNEVrV0vz60vIoI/?=
 =?us-ascii?Q?d1UhbX0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 14:55:22.1482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6f3479-1b80-4f97-50e5-08dc69eeb9eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258

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
index 6de9994971c9..bd97586d7c04 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -93,6 +93,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
 TEST_GEN_PROGS_x86_64 += x86_64/smm_test
 TEST_GEN_PROGS_x86_64 += x86_64/state_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
+TEST_GEN_PROGS_x86_64 += x86_64/svm_idle_hlt_test
 TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
 TEST_GEN_PROGS_x86_64 += x86_64/svm_int_ctl_test
 TEST_GEN_PROGS_x86_64 += x86_64/svm_nested_shutdown_test
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index f74f31df96d2..0036937b1be4 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -192,6 +192,7 @@ struct kvm_x86_cpu_feature {
 #define X86_FEATURE_PAUSEFILTER         KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 10)
 #define X86_FEATURE_PFTHRESHOLD         KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 12)
 #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
+#define X86_FEATURE_IDLE_HLT		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 30)
 #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
 
diff --git a/tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.c b/tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.c
new file mode 100644
index 000000000000..594caac7194b
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
+	halt_exits = vcpu_get_stat(vcpu, HALT_EXITS);
+	vintr_exits = vcpu_get_stat(vcpu, IRQ_WINDOW_EXITS);
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


