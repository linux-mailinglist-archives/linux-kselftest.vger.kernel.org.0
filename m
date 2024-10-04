Return-Path: <linux-kselftest+bounces-19007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8048898FD12
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 07:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D035BB222B6
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 05:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6B112F375;
	Fri,  4 Oct 2024 05:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IpssXoyl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFB681AD2;
	Fri,  4 Oct 2024 05:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728020051; cv=fail; b=qcES7+d5ov/dgZxEI4r3oMSCnTrNbnPdkRQpd6BBbx8F8eqCSW+3MBq+CevIVIZm07Gq0X7VENTjQpZ9yGV9MIIHe7gOK57HfpgDi1LjOT3v5PixEOJCNTr4u5tB0MUq7/UW06zV+cyTR9E8Qafak8wmmaVV/cXC1NV9DbkX+i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728020051; c=relaxed/simple;
	bh=c3FIEmH00FB6mke84fG3HnOgDShjeVfwQcN5BUyOqQc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MD8Wq+zs0E3BhgJx6Lpixpxi+/3FOHk/A8RASbtv6HRlKxePJRLyoIJaTkkgVpSuCvU6YmDWqOuPdtnRes6gKfb3vYMlAhQ9LzqOpNuCxGL7kD1gz0pyDz12J5LS8HWgFCL8PrP+HzdLuAT73ZgLupIJVIhg5STFWYjx4MSKXZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IpssXoyl; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Itmht8ey/3WBqnaDR5GuCtBEHfvXzYE0lCcJzgKWhusFMZlEZd3cNUtsTWVyQF7M1AWEoOQ2zcmfVwSVC5zT44MLDz3lKw330aQ3I6vwwtdbbTqVDfeI5DpE2M86Y33bm8aWIoDk9/LNUxWYXtJNz+KebGdkHDXaDjfasG+XJhO1oVF3A2EumIvpfROwf9ooJLuP8PPtrB9ls2pc8VqBsRWN2UzwgXTz8SfWkgHBtB2uIFcIOig5ddCh0g62d0zzzOLBupaFiiXqaHHOrDn5JZ8xag30tA8sMPF57g41ZzLgbzyWT7ee3n3MFHUwTHGUMcWFjliQWrR5ikgRr6fMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nU58zmn+ptaJ66wihrajBbVUfn1aZFZ6/ryClZ4tg2A=;
 b=D4906dA3BIu37IOg3M3ffPAbesSoKj5ejUeNsdYvnq4Drt2FbK7HHwTQtfXz4PW5xj1d3dpuyKJ3kM7WlYP61DGQdt9Hft9ZMlFv3gSbXnj0RECH5nhKNbzB5GqP64UMrnuXn+Rtu5r29GJWJL1wfHq6OjvPLwEBpgpq4gZrcFJMT5kQwy6k7GL1G1L7xtTZe7NnJA/aRjtWfOTUPgM+Uap/9hn0IxNFBoCx0/xm6Gbhvgl3Q/+yJGe+o8qY0p6x77VIezmHe/EEpcCWFnuCtasrES609EQu6fIExAvNatJMAMX13kdT+2pMtQN1w+6yQ0/pRUlT4qLrTuIxl7fSgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nU58zmn+ptaJ66wihrajBbVUfn1aZFZ6/ryClZ4tg2A=;
 b=IpssXoylNHHDI646GRPa/BB27NXBqJNpnH9TaaJA2uuR3KH3/mcPmgqRio45fJ7xYXStjyrGSX0NmzohtknkJSnM4DUbZPZi7PW06EmfDParA660bYxXokYxhSvOcfLb/t6Y+f4qpK/sRj+hpEdVVGfXDvO9B3pRo1O3Vf4Sc5A=
Received: from BN8PR04CA0002.namprd04.prod.outlook.com (2603:10b6:408:70::15)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Fri, 4 Oct
 2024 05:34:06 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::d7) by BN8PR04CA0002.outlook.office365.com
 (2603:10b6:408:70::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Fri, 4 Oct 2024 05:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 05:34:05 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 00:34:02 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [PATCH v3 4/4] KVM: selftests: Add bus lock exit test
Date: Fri, 4 Oct 2024 05:33:41 +0000
Message-ID: <20241004053341.5726-5-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004053341.5726-1-manali.shukla@amd.com>
References: <20241004053341.5726-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: d52c536f-d707-419f-3c1f-08dce43629bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KntMIWeA8NESraMroCiQL/A6/1ZJKDVSrOiByCEn2+SwfRKPu12fY1ae16CN?=
 =?us-ascii?Q?iSUqgOyj4qJhFTss+zWPpDQwVVdk97lW6X57eTWZK8eohnQjbZNJT95jFAj8?=
 =?us-ascii?Q?mcPHYCXNW8upzvlh43zz/xeaNgqKXx234/lshik+iYcmdSlMTRn+wy9g5jY3?=
 =?us-ascii?Q?vtaVHK1gLimqHHSUbB2fQp+dAs62gyYUe0waT18DaIxd3d4rf3mvUBvgdcVM?=
 =?us-ascii?Q?5kM1bv38zFG3AyDwZTxI97B8UkdN5HfKd5160VXvJUfZxY8qOth3p6v8DnWJ?=
 =?us-ascii?Q?aSdPinqw7u4dKiE52edu3yl+u/LioDpgNczD0KqTXBCHPgaBlp4cEmPNqtQu?=
 =?us-ascii?Q?HZS7AgETRoShkax/6RUKecT82Y3p2jpMpupJEDqBaPxBa3yaK83LYt5zHuec?=
 =?us-ascii?Q?2+sPMOMC2p+b/3RQTA1vyH/7TdIsAYLu4C6gFarGFP+ah0cOZiw0tUsNTfym?=
 =?us-ascii?Q?ii2EnL0yh4gjQRupHYo5rUWcK1JOLmHi9nQ1yRfIRU1NFMR9UmUAZOM+aZyp?=
 =?us-ascii?Q?fZu1GVOoUs7OkPOGNr//GV9J+29duoHsaNVqr2zztw0qzFNR7UKPhoMJtcPi?=
 =?us-ascii?Q?WDXmSO1hozvTpDYZinwJF7gJIoS1t90LmEz8XDJENNlKcgFXw1LPmjt5KUkb?=
 =?us-ascii?Q?0PE45SRldDDHfentj25RwD8Y3fzqCJLP9mAQR63aBzgBAqmnn2opB4os2wBc?=
 =?us-ascii?Q?y3Dc3044PJLFeDDRw1IACHeeGoTY7NCXx42ywjRZLhcqr8BHQJYxOa8sQeww?=
 =?us-ascii?Q?IWwZ1E6u6wJTTDVBMmxfIxPa59xzTotwxVWP5pNwqSKxbTUUMzRcfQp/FRN+?=
 =?us-ascii?Q?XD1bWpSNtUAOKAVN7BsGS/lZx/NUe9jUfaj+C0sVAhE+zzp0efQXGEXHzuMN?=
 =?us-ascii?Q?tf6i0EulvZ0ynJjnuq5e9Frd3sLET1MRNTAWxKGGuFTaHdiliB5w7xCyQYd9?=
 =?us-ascii?Q?L3xcJ3UWpmkV0hHnCj5QRZoE7lHBzfRi8H31NhbH+GT9YInkBC2kTcYA331h?=
 =?us-ascii?Q?jvU5ZFCnNKm2ZcbT++FgbIs3JqTkcVjkPadqIXbsjhLfEAWWQTokUmVOSBZH?=
 =?us-ascii?Q?lfO1R7Wh1MU79cWUifvTMoIaBQEtm9lFkjlnafml7ImekWaTvPjpfGAqRQLe?=
 =?us-ascii?Q?L8TlQsIJz7cMgfT3JwXBUTxHgn/YkKYgLAZawtAz0Cs1Vt59ODO2J1McXsoK?=
 =?us-ascii?Q?YMTeRUHtuPQUnH3SO0NMQeKtOmvbjwenLPeGi22+TYC0SeN/RSepo9kiKn7+?=
 =?us-ascii?Q?YdQhQwl3/Oy88RKl+xQ3Q4wnMHJS/0Ut5IqHkATbOIBYGfFiLsvdXFqWVVbe?=
 =?us-ascii?Q?Hle+mLxzvRIZ7x2mKTmS8mUG6oP/qylSZW2pkhU6oOthP64LvW+uSzLIRxLG?=
 =?us-ascii?Q?V907tOs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 05:34:05.8908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d52c536f-d707-419f-3c1f-08dce43629bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434

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
index 960cf6a77198..b2de61e4a213 100644
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


