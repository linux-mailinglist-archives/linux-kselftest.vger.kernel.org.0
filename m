Return-Path: <linux-kselftest+bounces-23849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C77A005A4
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 09:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D0018829C6
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 08:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B291CDA14;
	Fri,  3 Jan 2025 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fZx4H8Ea"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E659C14D2B7;
	Fri,  3 Jan 2025 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735892335; cv=fail; b=WYVAR7AHx//qty5x/6FtdwVTWpR/CVPo3bRKNwN7LnrdRcjObtrQWUg8X99GOdmKXBajYDG8pAY3/CsfZGY1idpOZNY3tduJ8K+Uml5U8KQ5zZguHs1yZdQ9L7p8u3AuLguX+oeCC7EivhShJd1Q6lgxKqEvv6xHygLuzls+VA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735892335; c=relaxed/simple;
	bh=HzwbGG1QAAjeo53Z6EkrqoIaEGvB2A2HlEbS86j3HnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/WIOGzYDgZgv7NVg8+ZUzjBU2i9OzxpeXcvSCxbvZpyvKEU6lKjGaexBSJpx092AN3jmG+9VEjjMvNQea51xwjKGUsWAifIS+808AQ8aJPDZy1nxCAOTFPxRvNT+ejkfgzFCYHb4IgFbixIYmpmP7jcIZhRandxRe3J8ggJSow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fZx4H8Ea; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVNJatUM3QHRoDYYGIFmnRyGrCaXq/FrFc7Pd324CU9r1oF9dg/1JFazmBIfmWTDgw7vKXAg5LIgVwOAy+H+RteMkp5GNL5lW3+ldXwp+RpVvea6nio9xljKjoFP48EIACZtGHiKyHIztkjw0gDa8U40XpdtIFoP1udp22KBXqwOBK9qfLmXc/CbP2ldMsT/oVeEC3n9LGaXQxKuO17o6Ofo5KARuuwOUHVM+UCKa6FS7xtxaKPdx9lCW4h2gbBf2k8792Yk/9z9R9Er8XrEPElb5SvQt06N/sgTAydYOV/KzHZH3yB3xZagukJBWYs1waqXqsnNWncl7T1N++EjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwMJUYjU9g5Z8CjWCAYWT0KA2GhAdSD6xbXQ6CfiHuA=;
 b=hOFACU4C9IXLxU9zqi0+mEUOMYshdafPBfK0rJ0weL3NYjfc/0oGRBP/bX3NuaCpDEqz5fwsZz8sKz2pyGZq0vCrBZJxJyjhfB1/m0dArFhJnRxYesh1d1OhtRioUP2DBcWiEPBtvqOA4+/yPndfvBLSHXRZnYwqcvCGL1TgB7aegWPC3+V7LFPhyyACSyZ/ZJx/Rlm4oKrjHjMT/UBqdXmQeK9ctO32/+X0kuMfFt1bFZOhbUOkp2axQVNrvY2djsmqZKc199DoXFZ0FJZZDynFRbBEZeCWJor4WymbicxduD6txA9rlF+hgs9/a9lPz/e8HcCJGX9cd6yboCwLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwMJUYjU9g5Z8CjWCAYWT0KA2GhAdSD6xbXQ6CfiHuA=;
 b=fZx4H8Ea/xm3G4Mi9RmsjWzJNVjyrBsbfK1HNQryRucd4UQCGaYYc5GmaQbr8doY9umhMXw48W1GjXEOJRwZGlVoZj1bKUY5skdckZXcipfZ2s40GQZvawtMYVS3/ptRVOX6N+EKrwduLMi0S4/600T96926YxbB6C/fwAyUpd0=
Received: from DS7PR07CA0003.namprd07.prod.outlook.com (2603:10b6:5:3af::11)
 by CY5PR12MB6131.namprd12.prod.outlook.com (2603:10b6:930:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 08:18:46 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::8b) by DS7PR07CA0003.outlook.office365.com
 (2603:10b6:5:3af::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Fri,
 3 Jan 2025 08:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Fri, 3 Jan 2025 08:18:46 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 3 Jan
 2025 02:18:45 -0600
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [PATCH v5 3/3] KVM: selftests: Add self IPI HLT test
Date: Fri, 3 Jan 2025 08:18:28 +0000
Message-ID: <20250103081828.7060-4-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103081828.7060-1-manali.shukla@amd.com>
References: <20250103081828.7060-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|CY5PR12MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: bb54c254-8dd4-49aa-e15b-08dd2bcf3ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w5onVsKRML9fD0Ef/CvIgOGIDtqNtRCATN4ZMYLuRmNbXFMwb1h3FSqoZEmF?=
 =?us-ascii?Q?ixAHBnRUDJ++Wk9hxLquPy2r2wHwvVFgQaZyaYBzbbs5Mz+7T2EjFVA2GcG7?=
 =?us-ascii?Q?02Zb6TnEglXQaovrNu/AilHAsei1IhHVESGei0IJp5MqukaHX1iK5J7lgaAS?=
 =?us-ascii?Q?NkOwfv+N9JUI4Lu72kr1H33jgMyCkV6HsVttKaNotK/H022Zc+kQcB0iFv93?=
 =?us-ascii?Q?qZwA70rrz2yRzkgSTzcDksKBa+Pm/Ls+qQX1Ub05hzZQ1FgN3wckqvXHe5T6?=
 =?us-ascii?Q?ut0JC21qzLAKT4o0rzbhOpQX6k/Gli9rh388lvL67SJGLUNNUCVPwRW5Y2Z4?=
 =?us-ascii?Q?9V3u5bp5dl6XNGeyC7/G9vUVzKwIo8hpwDS+eaGg8/Nmn+dw0L2fHgkYI6pA?=
 =?us-ascii?Q?D5IZN6ybZLc9ZtZNryxWd5VXWjKTYrTM8gIbWhJ8eJGTs1qQZt7VEILQyLUV?=
 =?us-ascii?Q?apNI20EM7KAoes/xnoRfNvrEsmqcjF/WR33XdZRMI1d6om6vVh/6EqbAILIm?=
 =?us-ascii?Q?IQosJ5ii15OdHSTGm+V2F8As5plfD+pPvD/kzLW8QFfOdZ+Mw2HLZd+MLiTF?=
 =?us-ascii?Q?UgB64uB14cJ0gFxUKF8WfAjmb36O1AY85y3xouy/+2ggS3KcxIBPA3s0ML3J?=
 =?us-ascii?Q?eP8+HemrQpnpEuZJP21q4cqck/j1t8fmgnGf3o7PGVaFmtiEjdROOOZDIzQS?=
 =?us-ascii?Q?zGamT3z7iiTe8xIBGv/GL2G/bKN1sk0FB9rzql1tCBeHzKS6toE5OKaAGrHM?=
 =?us-ascii?Q?mPV3h9FkN+/qi4M/iNlVLdlGDbWAL5v4ko+C1ltCGw/pFLW8Fcwabp+qCVkW?=
 =?us-ascii?Q?UTK6ZydKk9r9tXLzE1uazXTSsFx+ZqtXrJYlRfVHNE6wPhmjEKyYAQuCofh/?=
 =?us-ascii?Q?CRz8LQ1LiJYDSVObp/xjVKp3JQwKOfk2q9BsN7sSMp0eXjhCUmZFBU0MrhDB?=
 =?us-ascii?Q?kKKS+c2blJvJX3Lu3wW/sLAyEfc07bR44EzHazamAaLFHwvOihl0VW3TqHuJ?=
 =?us-ascii?Q?kzxwBkadCK0CauWCTuev9FqIJxQFKiPPZhqQfzK9wI78mnjR1Mc/fW5k2bnK?=
 =?us-ascii?Q?+Cuz2Usdb3Rb68dJDGLn5m9hdQBvZFiQSi14NI4WiHqmjt2s2avKO+iv6Fvh?=
 =?us-ascii?Q?ezWJwR1YYLtmUVAMnhwpkCWD6CcYvT+l/Xm1lowASyL8fy6cNmIwARrpLa5C?=
 =?us-ascii?Q?Vztw6nbu03rkWHI0oOLUeBTttQDq9AiReD4xt8OzDL7W2a4546kYxNh2C09P?=
 =?us-ascii?Q?BZWi0h+1C/X7QHfxV/5inT07j1nRcuNj0Cz2UbzAOpCGMteIW3pFGrJB6YHH?=
 =?us-ascii?Q?znTIMLAZ4ngblqbabYoozuk9HKtxLQwu2FYKHgPkOz5D3B5qpkPvCmE7BMAe?=
 =?us-ascii?Q?c3pWvPP2co3dx/MV+iIAgC2FUelV9WRLQmNJHa4q4GOpe5syIWTU0L+YuUry?=
 =?us-ascii?Q?3fm6u8OwqS7s3pW4+LOKF+utMVAOR6hmzdPLDq2vOXFOE2qHYtmUFGzMopoC?=
 =?us-ascii?Q?tYZqxGvrAl7E0BA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 08:18:46.6074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb54c254-8dd4-49aa-e15b-08dd2bcf3ec4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6131

From: Manali Shukla <Manali.Shukla@amd.com>

The IPI HLT test simulates a scenario where a pending event is present
while the HLT instruction is executed.

Evaluates the idle HLT intercept feature of the AMD architecture, if
available. If the feature is not present, this selftest can be extended
in the future to include cross-vCPU IPI testing.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/include/x86/processor.h     |  1 +
 tools/testing/selftests/kvm/ipi_hlt_test.c    | 83 +++++++++++++++++++
 3 files changed, 85 insertions(+)
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
index 1f9798ed71f1..23a34a12be48 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -197,6 +197,7 @@ struct kvm_x86_cpu_feature {
 #define X86_FEATURE_PAUSEFILTER         KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 10)
 #define X86_FEATURE_PFTHRESHOLD         KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 12)
 #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
+#define X86_FEATURE_IDLE_HLT		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 30)
 #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
 
diff --git a/tools/testing/selftests/kvm/ipi_hlt_test.c b/tools/testing/selftests/kvm/ipi_hlt_test.c
new file mode 100644
index 000000000000..09ed8011450f
--- /dev/null
+++ b/tools/testing/selftests/kvm/ipi_hlt_test.c
@@ -0,0 +1,83 @@
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
+	uint32_t icr_val;
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
+static void guest_vintr_handler(struct ex_regs *regs)
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
+	uint64_t  halt_exits;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_BINARY_STATS_FD));
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	vm_install_exception_handler(vm, INTR_VECTOR, guest_vintr_handler);
+	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
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
+
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


