Return-Path: <linux-kselftest+bounces-18723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E68598B48A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 08:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD67282F38
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 06:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6361BBBD6;
	Tue,  1 Oct 2024 06:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S0NNkrrS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14C21BD504;
	Tue,  1 Oct 2024 06:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764484; cv=fail; b=laZffNukiqFyH4oSpPc4gK8oZuMJzS14TfbShJRdWTE/BZVRg1BvfuS98x/3hhhTOqEQhEA+rgNOHN35iKoEp/gtLAsfq4GMRNGwHGAxD2G6gh8pm7nO0RhATXddksRvrMVDJufVssKmcQauKT48ttIJ27LCkMyEF4fsPjgpAKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764484; c=relaxed/simple;
	bh=bGCIAq0XNODp4VvlaTSFyrtLZRV4LehTY8Dagx8n8pE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVkZJKs4zMtLPZ2tJmRgromXbJ8Lc90S/uH4w60GLIH5ZXSQqjJfTJDCYAVvrZ2zi2gJ3+gRI0pjK5Q2tIebz8JCeF6SFl+F47E0ajFl++orYIePb/Mc+077Ieru0s5f68Lh/knqdbecBmPOdQgjsJlemoqhBVHyAaVoWHXxzuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S0NNkrrS; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmXyEBXaHoW1fRRY52HAXBpXIds5S9ty/riHvW1vmrWo+ZwV51CaK8bzW2bMl4ER73d827/wAzPeFjEzem4o8Q+5j0PcpMWm3a4v01Cbl2RJpalFJp+iSLUWsju8q/kF9WFZZh9tlNd8lfFa72rLR/x69pr/RxKR2qSKXdqk+XNMejiQv5Qr+DD9rmykXMg915iHaMGHer1aC3hnpLKLvYjBpUufzGWFw+/iYEb7J7bypS8FWZoWaWxxdEUZUaOYRpTtA0j9nYAbB/nV1p2yifv1jqTBv9fgVU+O5R5w4eoU984oi7nvNvuYS6IQWBVPKgSYrL45nFC4dcCQ0eb2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bneuj8dJUYnpYJ/crtKf1QdMoIS+NDfkqTcIZ4q7js=;
 b=wtXJDj06YAjv+E5T1kjFxmxti5FKhmoh5q8vKCU/7/YZ5hel/vOhDSYRl9YrfAxO45IMmre6n8bwJLnjze86y1Edg+lwLW4VRcXYn4404EKeHC3McOm6KSbniSHSrY11hPMGgx3gOWILeYpa/9tAZBVRjGrcLGbdtQxH6wZGcX1OB6VsL1FySE68xW85AL2RoufCDGw/BIcvbNHh6evKFCfpob6sfyoKE0DHT4p93c+lwT+dcwx68nGPFKshE5SSFh1Azu3+hJme9+APlwI1O3XiwBCr+1mvxQiWTZsmINL0INoOgTGsw71E5RywB9kBkiOg8yt+4DaJrJlHoUXFIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bneuj8dJUYnpYJ/crtKf1QdMoIS+NDfkqTcIZ4q7js=;
 b=S0NNkrrSdcXnY7uLPBgjnigj6Sfs5Oz/HbJiJts7Tc+OE+fIzh/NG2fS57j/DONXJPplRNIh4ytaJZYXGDclQeXFtmvTdm/Ozn0OYB4RUeYvdJ/Lnp7Lnmp+xY77P2SrIfkwpXMmI3qie8I10BGv+zHzendjUnMHrIZtY9XkYLk=
Received: from PH8PR07CA0045.namprd07.prod.outlook.com (2603:10b6:510:2cf::14)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 06:34:38 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::ad) by PH8PR07CA0045.outlook.office365.com
 (2603:10b6:510:2cf::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 06:34:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 06:34:37 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 01:34:34 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [RFC PATCH v2 5/5] KVM: selftests: Add bus lock exit test
Date: Tue, 1 Oct 2024 06:34:13 +0000
Message-ID: <20241001063413.687787-6-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001063413.687787-1-manali.shukla@amd.com>
References: <20241001063413.687787-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: d909b733-701e-492b-1853-08dce1e31f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DmJHrqq6jOZHIcLHj7VAcKQEPVaUWOs9i3WSi60RDcIaToAMI966tljg12yM?=
 =?us-ascii?Q?Y01uPphqsK4AqFgFyGk3CoFj6EHWmT0+MfbZJh+MPY5/hvVjuzhzVjgTSkrA?=
 =?us-ascii?Q?BfKTY9EiSZohKxQfNKzUK5q3h3oE5GvmHuHMYTGfJECCop/B1Ibb/uLh12Vj?=
 =?us-ascii?Q?HchGD90fY491PNxhHg/q8cT9j74f5s0C6ENp20l5EdUrfmIKC47c0zF4eRJ6?=
 =?us-ascii?Q?hTWRzyPDGGf9bzod0CyjAjVOu4eG3+fC6Y5vH14ba1SLL7fu+rS3MVXbAokR?=
 =?us-ascii?Q?yT3vhn/ufr69O/ZFMsj5+sgxvlM5HLgM/ANEyWbaQv3rtj00jVUEvYH3QwAy?=
 =?us-ascii?Q?svDPIwJrMDhrgP5QgAerCL4BI6EI02ue4bxzmbWbAWQzMYrShJd15PNd1hdy?=
 =?us-ascii?Q?XlNeIgSvfj6jCMCoXPe+FNtrHLoKfCumqH6hi4zua76qzmX5g8CfWcomNfI1?=
 =?us-ascii?Q?KQpXXd7yQir6XhGnYutDWleVuyUTj5i0OXtnKLqskwg1UxHyIQNcUYlYw40X?=
 =?us-ascii?Q?D8n+Q8nd4J1bnMJMqot0Y6zilrIFS/aEOIASDOCrIvhWE2hyvMkbe489shnN?=
 =?us-ascii?Q?pNy5nnE8EgD5Y1yE76oTlU1Bg/039IO4NMUthBkXOuSFKnZJEs5UjRBsPXgs?=
 =?us-ascii?Q?fWiM52JkD0feXL1hwe711BTS2vPw1DQBm9StvmMk/3bwj90yAboby6uA92Oe?=
 =?us-ascii?Q?ucSt9mHC+WC+Cfdi3xwd9e1gj+0Gij/qUnHXzSIc9rvE5o4bwEM5f181vEoA?=
 =?us-ascii?Q?XBpCs1hRD6PblHvaR3Rai5Cpa2bmNW2jE7nDIf8IYG+RUjX7eGdHx85Mnb0l?=
 =?us-ascii?Q?Pv7/aRNc3q4sAvpv7ZKc0rYm+pNnzFCQjTvhUqRp1FmzEjcA1Fo9ud5JKbQF?=
 =?us-ascii?Q?v5kATVvHeeqr+dld4u+TZOevmxP+txzTB65f0h0Jdgrpj8SPIQL5saqW7uTD?=
 =?us-ascii?Q?EwHgKJVE66h2MRK3vEM4q9xOX789RARhS4+DChGfrT6Qgf1WC9gOTHjYKpew?=
 =?us-ascii?Q?jiMa/X/IJwYUh5waWaW2CyoxsmMJ8t1JdqyAtV0E978HC91n7VN46ytU50ad?=
 =?us-ascii?Q?Bq524Y930HaTmEmAybVvQOKzJS8ZccIC445O5u78BTBywRJcLPPaMxiUPSY8?=
 =?us-ascii?Q?Kxb6JTSfoi9J7HLjU6Kda7PxaqeG/D8EkDwqV0ySqpC33Noeoz/3l5avX6xt?=
 =?us-ascii?Q?1YYpBMtwyvoR2VuE1CHOEfZFPNjbA9ggOI8nDyuci5DVOYYC1tUz4JPlAodd?=
 =?us-ascii?Q?zg987uwsz87SsCA3BXyBZ6lz2gJHOsDsFZX50qDGO00/Of1W6MO3aS/caF/4?=
 =?us-ascii?Q?TDEQsjVLkd1bHt4MpMAvleN39ci5vLejuAzDeaRGjpg7cIafZqjvOz/DM/vs?=
 =?us-ascii?Q?6eZ/c/NKzrH5OqnaKjZkLJdids2DSDjRiY9UggR7zCC87X4mdArJ5ysTG90K?=
 =?us-ascii?Q?Q/xHoo4Ti7HcebJTUi0y3dA0XT3G21sP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 06:34:37.4525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d909b733-701e-492b-1853-08dce1e31f1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912

From: Nikunj A Dadhania <nikunj@amd.com>

Add a test case to verify the Bus Lock exit feature

The main thing that the selftest verifies is that when a Buslock is
generated in the guest context, the KVM_EXIT_X86_BUS_LOCK is triggered
for SVM or VMX when the KVM capability KVM_CAP_X86_BUS_LOCK_EXIT is
enabled.

This test case also verifies the Bus Lock exit in nested scenario.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Co-developed-by: Manali Shukla <manali.shukla@amd.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/kvm_buslock_test.c   | 130 ++++++++++++++++++
 2 files changed, 131 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/kvm_buslock_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 0c4b254ab56b..fd7b43fd2a8b 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -81,6 +81,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/hyperv_svm_test
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_tlb_flush
 TEST_GEN_PROGS_x86_64 += x86_64/kvm_clock_test
 TEST_GEN_PROGS_x86_64 += x86_64/kvm_pv_test
+TEST_GEN_PROGS_x86_64 += x86_64/kvm_buslock_test
 TEST_GEN_PROGS_x86_64 += x86_64/monitor_mwait_test
 TEST_GEN_PROGS_x86_64 += x86_64/nested_exceptions_test
 TEST_GEN_PROGS_x86_64 += x86_64/platform_info_test
diff --git a/tools/testing/selftests/kvm/x86_64/kvm_buslock_test.c b/tools/testing/selftests/kvm/x86_64/kvm_buslock_test.c
new file mode 100644
index 000000000000..82693520485c
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/kvm_buslock_test.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ */
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+#include "vmx.h"
+
+#define NR_ITERATIONS 100
+#define L2_GUEST_STACK_SIZE 64
+
+struct buslock_test {
+	unsigned char pad[PAGE_SIZE - 2];
+	atomic_long_t val;
+} __packed;
+
+struct buslock_test test __aligned(PAGE_SIZE);
+
+static __always_inline void buslock_atomic_add(int i, atomic_long_t *v)
+{
+	asm volatile(LOCK_PREFIX "addl %1,%0"
+		     : "+m" (v->counter)
+		     : "ir" (i) : "memory");
+}
+
+static void buslock_add(void)
+{
+	/*
+	 * Increment a page unaligned variable atomically.
+	 * This should generate a bus lock exit.
+	 */
+	for (int i = 0; i < NR_ITERATIONS; i++)
+		buslock_atomic_add(2, &test.val);
+}
+
+static void l2_guest_code(void)
+{
+	buslock_add();
+	GUEST_DONE();
+}
+
+static void l1_svm_code(struct svm_test_data *svm)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	struct vmcb *vmcb = svm->vmcb;
+
+	generic_svm_setup(svm, l2_guest_code,
+			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT(vmcb->control.exit_code == SVM_EXIT_VMMCALL);
+	GUEST_DONE();
+}
+
+static void l1_vmx_code(struct vmx_pages *vmx)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+
+	GUEST_ASSERT_EQ(prepare_for_vmx_operation(vmx), true);
+	GUEST_ASSERT_EQ(load_vmcs(vmx), true);
+
+	prepare_vmcs(vmx, NULL, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	GUEST_ASSERT(!vmwrite(GUEST_RIP, (u64)l2_guest_code));
+	GUEST_ASSERT(!vmlaunch());
+
+	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_VMCALL);
+	GUEST_DONE();
+}
+
+static void guest_code(void *test_data)
+{
+	buslock_add();
+
+	if (this_cpu_has(X86_FEATURE_SVM))
+		l1_svm_code(test_data);
+	else
+		l1_vmx_code(test_data);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_run *run;
+	struct kvm_vm *vm;
+	vm_vaddr_t nested_test_data_gva;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cpu_has(X86_FEATURE_VMX));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_BUS_LOCK_EXIT));
+
+	vm = vm_create(1);
+	vm_enable_cap(vm, KVM_CAP_X86_BUS_LOCK_EXIT, KVM_BUS_LOCK_DETECTION_EXIT);
+	vcpu = vm_vcpu_add(vm, 0, guest_code);
+
+	if (kvm_cpu_has(X86_FEATURE_SVM))
+		vcpu_alloc_svm(vm, &nested_test_data_gva);
+	else
+		vcpu_alloc_vmx(vm, &nested_test_data_gva);
+
+	vcpu_args_set(vcpu, 1, nested_test_data_gva);
+
+	run = vcpu->run;
+
+	for (;;) {
+		struct ucall uc;
+
+		vcpu_run(vcpu);
+
+		if (run->exit_reason == KVM_EXIT_IO) {
+			switch (get_ucall(vcpu, &uc)) {
+			case UCALL_ABORT:
+				REPORT_GUEST_ASSERT(uc);
+				/* NOT REACHED */
+			case UCALL_SYNC:
+				continue;
+			case UCALL_DONE:
+				goto done;
+			default:
+				TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
+			}
+		}
+
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_X86_BUS_LOCK);
+	}
+done:
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.34.1


