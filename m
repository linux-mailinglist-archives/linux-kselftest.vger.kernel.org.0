Return-Path: <linux-kselftest+bounces-25306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DBFA20ABD
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 13:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258373A1918
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 12:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472161A7046;
	Tue, 28 Jan 2025 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gd8nvwH5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843721A2567;
	Tue, 28 Jan 2025 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738068531; cv=fail; b=nNH3+8nKltAe9w9WTRFYbhcY2A3shebzuGhN1YuISq0LPA45ecQ99LQ/aqk1R2dWVZzIjmI4FzoMoENlZPncnRf5akeVZZOaXeYtMm1phq6E7do1rYAPXOjPc6c8qaAC40iZIPdyRpGN90J049M3z3Ilpyc4J9i/PMyoLX9M15Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738068531; c=relaxed/simple;
	bh=/HMGmhZlwvST967SjZOHgd/cHsdSVuUbPYKRhcm7HPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ts/9ixHpKzBI6Uz8fH8UP+/qrsDY3XjHLTEF8hVv3Kfu9ePN99EQNc6f/pc1KKUn0N+AI1t8Yi1Bvjt1QLZ3TLDJjtQxLQmMvH0vlsF3AY26MGyqxgD8Z4Mtd8EzmMZts3VvbhWrINS5UvP+CXFf8XQtxkOdG782ev9D4ObyTFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gd8nvwH5; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioU0WUIZK9RTlGD8ffWQXXGo5VtirAYkWRSCnqQA5G9N7ewkk1/33MaCI5u1LrdJE5roE3OcN9c8s61LZJ8DrpJsZphf2KVLLDrmjPE7GAWnIxQ0PVUk+ZVFSvELDhW4e1LxkmaOKnHL+6syLfASNT6VK6BvdroobiGx9KDACo8G1yWQlTORLMznjqf77gBJKSIseOZlm6xHmqGYKpou9W6csn3vKk2IJ7A4wNxvyhBxqYrDa6vJ+V8yWtARkMVmxbrDWkVyBa0mTRzdtqQC3nD/EsNNvHvYUw64uumWVM7YcUHXDz7GpBUo7UOYCjCba5nlCUfU1ateJyjuqW0wzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7w3BkydccKs7oaoi6dIQvArX42Bm3ueWNAnp0/Ow7A=;
 b=c8jDK1/px0OHVnDiTssPwjG1R7DfHzPi1rFYCkqeMw/c6SrBP9I4NZGk5ZO1Zl0njKnhRrpnnEcTgWItODcJQo++JEJoK6SDRMlpuppsaB5RzH6tiKJLkC5tCtMKlAkSHpcETur+nJ+IjZ+fWD9gXYhzjev1GavfUeh++p+GzUMellD6spP1S81lPRCtZghTUnrFLXE9M/L48ZcH0RD/D7mkayFr1ziR0rEhyng1uvy2B9wCizio8LDAUIlGyoaBBbXlp7id8U3ElWKEoqLXJXnj+1cWMPjf2PXiig39FvGMQqabQ3JViIeSDDZE0HsXmKL7asjSoFdhldPdxdDiSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7w3BkydccKs7oaoi6dIQvArX42Bm3ueWNAnp0/Ow7A=;
 b=Gd8nvwH5xgEAqa6kelfQeCd9qj3DmmTlVKS80SeeTcLv65+D2uU9tMD0KtMKtNE8Uvm/aSkJRN+U4StOWVhSmyx4lqA1fB3wTAVDTnOVCwVYhWSzKackEV/IgfZFVc3O7ICx3BpISbwdaOLPgpx6oPyD+o24+6IOoYuOcXpzlPs=
Received: from BL6PEPF00013E05.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:4) by IA0PR12MB7675.namprd12.prod.outlook.com
 (2603:10b6:208:433::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 12:48:45 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2a01:111:f403:f90b::1) by BL6PEPF00013E05.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Tue,
 28 Jan 2025 12:48:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.0 via Frontend Transport; Tue, 28 Jan 2025 12:48:45 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 06:48:44 -0600
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>,
	<neeraj.upadhyay@amd.com>
Subject: [PATCH v6 3/3] KVM: selftests: Add self IPI HLT test
Date: Tue, 28 Jan 2025 12:48:12 +0000
Message-ID: <20250128124812.7324-4-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128124812.7324-1-manali.shukla@amd.com>
References: <20250128124812.7324-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|IA0PR12MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e606e7-8f0a-45fa-a8ae-08dd3f9a1a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zd5O4pNJ1M81N4YEA3hh05CaxTavUd78eE/CrLhPnL/6yMJNICrhYcbUgm3O?=
 =?us-ascii?Q?g4fJ92SWyESaDCBcPzS9jMMqb9zXSSX90hK8Gp7in23BfA1hp9RNePJQJI+/?=
 =?us-ascii?Q?GRCGO13aDHVx+dZErfIQ/InuaATz/1m8PcPZKY9C4N3Ty/JbuYlHP/Ah2M6N?=
 =?us-ascii?Q?S1g68/RXp+tIrKuJiZ7vg7wYCX9IjU8p/WPK8vqp7Kdh2c3bGaQhSOXnYpq4?=
 =?us-ascii?Q?cIuWI4M1bPytRxtcUJfFTeZi32TJao+B7vSxxFIYdCqE2Of1zwt4w7c+98Yy?=
 =?us-ascii?Q?eodk/4C17ECrcRXMi3ZGOLiQBbrc8E/TMn2nlHn7UrTmWY1WYqG2LgKBNDBI?=
 =?us-ascii?Q?H7RVn+7dLPFAouV2FZDjouSUoxs3zCKmMByk8GX4u+x3A7fvu5ijsXWFhMhb?=
 =?us-ascii?Q?hp39QNTY3glRQ/3nkHj6nPLC9ABBrI1INRgFg/iOyrVWpjnYwo/OxypP+tVc?=
 =?us-ascii?Q?0TFiJaSM5MZL1vWpVqUdvef7/tGEro+2dENJkvuAF3C6kpolISmnwMYZFkhs?=
 =?us-ascii?Q?Hh1Nl18ShtLUVc8wenJMXu35vqBd13FuffiiVAajg8DsgUDYi+D4BM/21O7P?=
 =?us-ascii?Q?ah0HJgNCb8qKp2rY0R+/wwS4AK40FT9hsjfDJQWMiOHOZWPGQd//vaKJFXVt?=
 =?us-ascii?Q?xY2FZ0IZpGfCNGe1az8leL5JK0oasU+XwDpjLpL2105/9a886wIpIqw+zbMd?=
 =?us-ascii?Q?/1FniwEBAjy6mhKjop+A7f4AJ617xLinWU7hjW2XZ49hDWGUK0YcSay1Goni?=
 =?us-ascii?Q?UKY56la50Vw92p6ZUi2Y6N84j113i60KyPcrUS3JlFKUp9TIk7Cqrc6Pc7GA?=
 =?us-ascii?Q?v7hioD0h1ctRwAG8qJBeTISDCE3iNHq4Hm4KQDCvNGoJWHrS5KEq5qdHGyOl?=
 =?us-ascii?Q?I2EuIedCxncRA0l/Sh7knEaQGj81etR92sFAqcUs+yUYLFW2k/as2+/k2pPy?=
 =?us-ascii?Q?YgqQsrDvbM7c07Kvy9cP0/oA8eCaF9+xMOwKxiOSclWlvhKQnrZAMqkbY0QS?=
 =?us-ascii?Q?cwWLrcHUb634p50hKVNkjRdD+pSeadS2C+qYVxipdPwC/5skJb9LTbAqspCC?=
 =?us-ascii?Q?Ls6Rb5D8tHZbWEbg9iH/dxCzbMh2WDTSi5C9oxkw8rvls22THDTPzk8G+wT/?=
 =?us-ascii?Q?InQb92JLfAN2I670rZ7neGXtV0YjzuHzqTSFfVCXBtnKd3SkfEIQWAHe4pYL?=
 =?us-ascii?Q?CTEmbW9x9Y8k5Ket2CCEWSQd4E4vivnq+LrwYpx7gAf/zUqmTxothoQIldsw?=
 =?us-ascii?Q?7L3X7O+ZrobCCbiIGsE+xRPhoqnkbeOE5tF31OsxWyYgCbKXygh38bQDDV3w?=
 =?us-ascii?Q?KeRljsdtYVTrjJLkN/TnKYwnUEQM8+bu38JeT6q8pcpBPh+G+2nu5T3bQgzz?=
 =?us-ascii?Q?ly3p8ckLaxP9m919VK4+GC+7/bg02ZAbT9+6Ew77O9kFmgPsPGp6WxRyKw8Z?=
 =?us-ascii?Q?WviKX8jrJIZrdssu2pxrgJXu1PAFeB9B2RWQ13oST/FeLYab686jnnRVZ3Hu?=
 =?us-ascii?Q?qcK1IbDulFBEVyI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 12:48:45.4336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e606e7-8f0a-45fa-a8ae-08dd3f9a1a48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675

From: Manali Shukla <Manali.Shukla@amd.com>

The IPI HLT test simulates a scenario where a pending event is present
while the HLT instruction is executed.

This test evaluates the idle HLT intercept feature of the AMD
architecture, if available. If the feature is not present, the test
exercises halt-exits/guest-entry for pending interrupts.  It can be
extended in the future to include cross-vCPU IPI testing.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/include/x86/processor.h     |  1 +
 tools/testing/selftests/kvm/ipi_hlt_test.c    | 81 +++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/ipi_hlt_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 4277b983cace..d6eda8c19fed 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -135,6 +135,7 @@ TEST_GEN_PROGS_x86 += steal_time
 TEST_GEN_PROGS_x86 += kvm_binary_stats_test
 TEST_GEN_PROGS_x86 += system_counter_offset_test
 TEST_GEN_PROGS_x86 += pre_fault_memory_test
+TEST_GEN_PROGS_x86 += ipi_hlt_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index e28c3e462fa7..fe0ed8d33e37 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -200,6 +200,7 @@ struct kvm_x86_cpu_feature {
 #define X86_FEATURE_PAUSEFILTER         KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 10)
 #define X86_FEATURE_PFTHRESHOLD         KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 12)
 #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
+#define X86_FEATURE_IDLE_HLT		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 30)
 #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
 #define	X86_FEATURE_PERFMON_V2		KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 0)
diff --git a/tools/testing/selftests/kvm/ipi_hlt_test.c b/tools/testing/selftests/kvm/ipi_hlt_test.c
new file mode 100644
index 000000000000..449845fa2a82
--- /dev/null
+++ b/tools/testing/selftests/kvm/ipi_hlt_test.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Copyright (C) 2024 Advanced Micro Devices, Inc.
+ *
+ */
+#include <kvm_util.h>
+#include <processor.h>
+#include <test_util.h>
+#include "apic.h"
+
+#define INTR_VECTOR     0x30
+#define NUM_ITERATIONS   1000
+
+static bool irq_received;
+
+/*
+ * The guest code instruments the scenario where there is a V_INTR pending
+ * event available while hlt instruction is executed.
+ */
+
+static void guest_code(void)
+{
+	uint64_t icr_val;
+	int i;
+
+	x2apic_enable();
+
+	icr_val = (APIC_DEST_SELF | APIC_INT_ASSERT | INTR_VECTOR);
+
+	for (i = 0; i < NUM_ITERATIONS; i++) {
+		cli();
+		x2apic_write_reg(APIC_ICR, icr_val);
+		safe_halt();
+		GUEST_ASSERT(READ_ONCE(irq_received));
+		WRITE_ONCE(irq_received, false);
+	}
+	GUEST_DONE();
+}
+
+static void guest_intr_handler(struct ex_regs *regs)
+{
+	WRITE_ONCE(irq_received, true);
+	x2apic_write_reg(APIC_EOI, 0x00);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	struct ucall uc;
+	uint64_t halt_exits;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_BINARY_STATS_FD));
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	vm_install_exception_handler(vm, INTR_VECTOR, guest_intr_handler);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	halt_exits = vcpu_get_stat(vcpu, halt_exits);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		/* NOT REACHED */
+	case UCALL_DONE:
+		break;
+	default:
+		TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
+	}
+
+	if (kvm_cpu_has(X86_FEATURE_IDLE_HLT))
+		TEST_ASSERT_EQ(halt_exits, 0);
+	else
+		TEST_ASSERT_EQ(halt_exits, NUM_ITERATIONS);
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.34.1


