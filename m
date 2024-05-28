Return-Path: <linux-kselftest+bounces-10758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 559978D1347
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 06:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09CD4281FAE
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 04:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D95229406;
	Tue, 28 May 2024 04:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NcrzoNF6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BA11D551;
	Tue, 28 May 2024 04:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716869989; cv=fail; b=CDuZcw3HIqM0Y2rqDUHt6iuEOOhzzZG4cnQVqHha9IptNO93AECTIvR7lKjj70gnQSQHSLgXzapY9399woS6eVp41GOuYkiTQlAzAeYsBA7YV+u+JWYKtKnn9aa+66AVWQQapbZhlqLFNBptFUSIQAecp+j8LCJ0JOV+GsYv5dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716869989; c=relaxed/simple;
	bh=TjAb69OVRcVxE+ATZRBVvDKSBq0XOqz4+21X4RPthus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugMePkheesjIbiIrwxrDqxvCLbaIjVx+LTuZAzTvEzzX+9/4a5XcdwD+pzuCgeXmnvywhXLTSu+ABNvrZ1JU0i5+3FYEYKI4KfLqcIOEiGFGKgWPc2aC2A0fq3gAcpMDui5zd/FFKawI2Glwr6215JAvtuAXisw5HL9j29dyYk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NcrzoNF6; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVYzevsdFEZyN9BYT6HrPNe4UkqvP5j7b+ueHLq49bWT6OY4aimpmhKnmADKLKa+LD3bSgaBuZUaRNHqo8Z7S/tDN1m1D0tqSQxuheWubn7oDy7COZ+9HKe7tLoFU0BrGLYj3PGWvTgHWJhcHXexq6O6vPUMy087j6elO8/0Z0FzYXAxe/W6OjPoHHKDjP6+PxW7Kw0czfsSCzwZDA5mX4fp1vczfF9q1Qqjg5E9X+ll51f90dnx08/0JbpRltw+Ce8tcnk6pV1OFjyZw6IemtBLvKIffibOVwE5LhaIpst3dxB27j0LfiEftlqSvdIOefmRzNs81VqimXpofFMgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKpmEanb1+kqijWMrcl26r9SQLcjXziANdt0nCooqrI=;
 b=hqoG/1nk14upxLbURXPVTSfXZdYpcmH/F48wOXn07VWihlXZifTjELVkhylS3NKGvs4bQQ8bAgw/CVNBe6dIbxrCkFN00gH/6UAI77Vjx9X5hDdbenBDlq4ua+zC8gqJvFyywcDjOW1M54P5kJ6v9bUFPIVsc1diuuHWxRkfuVauHNDzIF77XtTt61fHP0kihC6uHTItRH/cBvOkFGRnPxLElwqGM7dPuek0jtBujGtBNLG4z7hrHLfIqElKvOJ5rUd68skOlad4n0FJYxP7fC8QUWOaRRhpbQ0pHUYPIlwz3YuW3pk/YI8aQnlHdo6/daq6MmHrLwdSII9z7inGDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKpmEanb1+kqijWMrcl26r9SQLcjXziANdt0nCooqrI=;
 b=NcrzoNF649BLrc5F8BmDydvlzXVEPz9EsoGcG2TbRB4yEYiDi40r7T9KMXZLMt+5orjBIntIbBBscwlEfmlfaLKMt80YkArAH9ffVspOAkoxeGuAZ2bnLGw3NVvRyaTjuNc/jdPj0itnbg5ckRSlGa9kmRTQFJoZHp4g8nQry6Y=
Received: from BN9P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::33)
 by PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 04:19:45 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::56) by BN9P223CA0028.outlook.office365.com
 (2603:10b6:408:10b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Tue, 28 May 2024 04:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 04:19:44 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 23:19:43 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <ajones@ventanamicro.com>
Subject: [PATCH v3 5/5] KVM: selftests: KVM: SVM: Add Idle HLT intercept test
Date: Tue, 28 May 2024 04:19:26 +0000
Message-ID: <20240528041926.3989-6-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528041926.3989-1-manali.shukla@amd.com>
References: <20240528041926.3989-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|PH7PR12MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: e5129e38-61db-4cfe-ffe3-08dc7ecd675d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wflSQkQcCkLiGooUIzSFpyP3YyzfhFUD5QwhqYq5OB308OhGMdiuXrckrb8S?=
 =?us-ascii?Q?viPHTXShgNGTioWxqi43n4NbGmAZJ1uX/SVmgUH07Nqb6W8y4ZhppTd/u4io?=
 =?us-ascii?Q?p7scKPwgJqMz+vevzYV+5PZPn7h/r3KNF5uDEd8sZdM+dvTg0unUmgmDoy6S?=
 =?us-ascii?Q?9Ti3wO8DW1No/leSitzxHKCg45sPX5sJT74z0HRHtvzEQb5vuAJBh8aB1A8/?=
 =?us-ascii?Q?T+2Xxvb9P1cVrEy2RynChr0vHmIiSVfmcmEriU6Gyol6wAM7fRXaWO5sqOT3?=
 =?us-ascii?Q?YAh9N/NI4ckKVxC4P0W1Rv4FYG/oARW8x6hg+zCg1Zrx+FXkX2vFMNalKCWx?=
 =?us-ascii?Q?oAXAbw7IRc3Nxot2t1mUIfopXT3ipZV/xEla5om7z1Kg2zk5YVCskOz3nrB6?=
 =?us-ascii?Q?UJq5udleyFKD+LZkCzMQpFPiauSacX1xPUfQ/ILwheYZqoW2CReFrBxbV7ga?=
 =?us-ascii?Q?VoI5WMYt/k5p+/4f6gR/Nfo57MpVuyQ5xGZh9FxEb6LRSfOH8eXTjS3jN9xU?=
 =?us-ascii?Q?i+pQqm8r76InLehqZrnY0DPO/VTE6gKWIyWqbFjIaRKkMIpFKv8MLr/ayxcJ?=
 =?us-ascii?Q?aYzPQ0IWZuxcL4C20UVAS/bi2ltiJ8ePNNVDAD7u25Ru0Rmu1gP8xiLSCTXf?=
 =?us-ascii?Q?gnEkIabj/NYysmLdmk87UjWRSoemJrnjzFIAIb4lz+vHe7EJLSWhTzVQPA22?=
 =?us-ascii?Q?MnGkKepCXgtFfcDfQuzbLabxkyB+MhH8oyUS83kjq42y0eYfT3e5uHU03ITd?=
 =?us-ascii?Q?yC3270OFbU98t7L/S9Vtd6iKYZ2yyK4/LFfVivTT2BfhgOnk+ZqU3Cd/sZwg?=
 =?us-ascii?Q?dgPILWDdwHGe47LHs9kXrO4/VpGf0QyJbGxTt6vEbU8RRakz8kIGqgm2myw/?=
 =?us-ascii?Q?3ohm0ZZZDERaoBTlhxOahMw3nkKNnLxdX78SwBUa9znPq5fEfcaE7zskbHns?=
 =?us-ascii?Q?TdbLgRAHFsqQyxfIAkCGibCUmeqRLppfTTqFWds9cZKCuqbQJ2OZH9DFWSdo?=
 =?us-ascii?Q?VEMZE4fkXXajQ0e4WiredlGsOtB2P7AsIR3K0OBx9DSp0xpBX09ejI4x/o4D?=
 =?us-ascii?Q?EtlzymR4UGACYFTQLdMpZSR12TU+Z4a/0NfZhnzmf8ezq1foxoHExYeAJZ1u?=
 =?us-ascii?Q?LjapLMS5DQKUqaNbyxVt9y3+g0Dwp+Zy9zjqyox0mXbeSo7Y0EPmpDM03rSi?=
 =?us-ascii?Q?Eri6DsxOM3D5p69u+8IiNQtoYwFLS0QdNaTMybtWELuhgk1QjHbo8DsncnpY?=
 =?us-ascii?Q?wE6PgH3aIjhFS+tAFTyvP5BHrbdXevB0/FZp1j3Q2zXAZeRvZ8AJSuLQjCzv?=
 =?us-ascii?Q?jlCAHPRVBXfayDkgI8zVDgxMF3LPXyuCJjPmBJ4Jlv88bC4uLB2WHXBJvhDL?=
 =?us-ascii?Q?aLI0aT8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 04:19:44.6908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5129e38-61db-4cfe-ffe3-08dc7ecd675d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7937

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


