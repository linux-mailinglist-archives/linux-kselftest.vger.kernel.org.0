Return-Path: <linux-kselftest+bounces-13399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EDB92C2D9
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 19:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E96B233EF
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 17:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3871512C549;
	Tue,  9 Jul 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oNbvnaMb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887721494C8;
	Tue,  9 Jul 2024 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720547541; cv=fail; b=IwYbIRCKqGo2LtxSmvnzp61SBcwujz+/4uowo7nxmvNVOzBhbhEcvn+tyM2AomN0be966wJE52Rlq81wGcQ9Nw9GCdXqbsZtZgAcXiLxSuPy2MhU8AQGQC06Hm82ALhWOw4pvXQK+abcZOgtzKtx7qjCXFbChsRvz5BspGi66vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720547541; c=relaxed/simple;
	bh=oZ4EpGhqlgAcr2qrzuWKOWT5AkS3NQHCeJOyTV1V8PM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KgDHtaaBivTMqlV2WmCnuhRTuxjtzjZcXnHrlZbCAG39sH/+o8YSOlljOrf/oktr4Fc5UdggnnAiTNyZAUlI1Zb557KqamFcU/TvH1oj1d64tcpbbRrARXmaUw2GLuzqMuVnEXYyRxpNKzmDD7TrZWcu0ipp0TOC/CypHBA9o8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oNbvnaMb; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G61JK3H7/LBLR/tKvCWYclIr3pw0KIOkETtG71jB47FGMIdMB/FNNL5USdkS3IE8hNaCy1/NTr3mXnxmAtEaY4VreG20IXsZL27/e6TAM4/sRTRUWKHEMenH704k6Jvoap/FkUhvCC/t1H0jI3h1zf2ySPc1waMMmfRKnnB+tujT8bUErP5w9WeKPBd1TSMWklv5RjQx4vFdUsFSSPh7BK2bn8u09d1T+ozZN2+bcO8ArVbJ3AzAPczYd82DkWtM4EWu/bm0MecZx/xkW4G+mYgpC6jKJUBkZgoq/jjstJIbwtk44gyQ+PCUE9DxZw3lJFyjkfflP+EhA7vRzRkF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olyTE//IDtXz7FOr/hFWWjoJ2E4C81hgOzAvsB1G12A=;
 b=eAqdS4tvC2Z2OHrdbyQHl3JvbSoKE14oiONt7OMhH8nLtbmqy/NWQdZ9lih9+XLNrB3TNmiaYc7yAFk3f2kATWWT0Y2XTTo/bhcq/qXANBF9oPu/i/h9xWMwUg8vKP4cKRYP5QiayROhlKUlC1wCyCp3RCe8HpBzeHs8Eeyf19bbqEhZl1siJKJckm0wS7h9d1H9t/qPh0jQa2BfS9PlAoJmSNC8OZR5u4ukCWLKuSg9ZzYeIBA0TInXBEwpXDoRkYy95CoszLf1dbwjJtOHzNnLOSsDA/UzguJtG6FDgfxuqlWbgJvowfav5fQ3T9eh+uxWdB3D4fYf8oJSE2HqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olyTE//IDtXz7FOr/hFWWjoJ2E4C81hgOzAvsB1G12A=;
 b=oNbvnaMbKh7LADQffc9by/PINohGAAcWgjhOPv0mGxPB3GkvJ2Ru9yJU+t+iUNsYiUAUkRw8DLVYJitkHOrJO0syUqHaPvpgef69hcE+p6Kv0t1WrFjAeSLeXOno+6vGZGTbZWzWtK7n8V6ZqFwzUFhfYjWBxA31iJjmvwyD5dU=
Received: from DM6PR10CA0014.namprd10.prod.outlook.com (2603:10b6:5:60::27) by
 PH7PR12MB8779.namprd12.prod.outlook.com (2603:10b6:510:26b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.36; Tue, 9 Jul 2024 17:52:15 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::35) by DM6PR10CA0014.outlook.office365.com
 (2603:10b6:5:60::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Tue, 9 Jul 2024 17:52:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 17:52:15 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 12:52:12 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [RFC PATCH v1 4/4] KVM: selftests: Add bus lock exit test
Date: Tue, 9 Jul 2024 17:51:45 +0000
Message-ID: <20240709175145.9986-5-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709175145.9986-1-manali.shukla@amd.com>
References: <20240709175145.9986-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|PH7PR12MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b6f54ab-cc22-4f72-e01b-08dca03fde67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+H5S6O+bX5BSvoPbIISw+VizqdiDQmpt/GqlWrhb9thG049YlRA4wfRYloTT?=
 =?us-ascii?Q?RTElneQdeYTpGjLCVg1uv2Y81Dj6GpG7J9vPynKByXsicSZDGRaBE33LxHG0?=
 =?us-ascii?Q?HqubgGAqe5mNDOTvG98wHMu6/XuKU/0GhSrvGgeT97D1V0ilj/RcNhHFOyl/?=
 =?us-ascii?Q?BKtMF6D5iiqfXODLJD0yWvVG6hJIZV8Grd52E41wq7H/mfwK+JxnUkI12le2?=
 =?us-ascii?Q?e79gzMY31M0btRarRiORMN8O8qYCcsJDJ8UoSek2bdsZjEIkHzCke51QiBEn?=
 =?us-ascii?Q?SfufL41qGYxoTUvD/cHUD0IT+uB8NyXn7Y7nWX9Ncua6Cu75bjAABiYfXYw7?=
 =?us-ascii?Q?bZ16hibV6S3MJcP+vz6d2erCPWsqelrBbWp/qTkaLHkocUlxHnBaslvIgm6e?=
 =?us-ascii?Q?Apaqa1UAVPRo202nPUHxNA0k96t0qa7+YygSi1ls8Ik2HR7GNme0Yq3szt/T?=
 =?us-ascii?Q?T0GMx2STlwWbwO7ryoWRb93G977vMRGATwyRbDyg4GpIZ2EJrwomlw8f42ni?=
 =?us-ascii?Q?IGOSqe702X+Yet8eIneoXycxSdYFntmTcN+vVGsNAqRAo6dahX2bGSt20BUN?=
 =?us-ascii?Q?r7PIWcHAElKeXtHSrLov9/482Pw+dn0aL0XiS3SIIqmR9pQKQ+VMIuQLgKZe?=
 =?us-ascii?Q?qVu8R5iodyzIdSKZleyL9fWkyKqs9e2yxUFLjwO+PXeHYO2P7BFJ4xNFrF+H?=
 =?us-ascii?Q?F3LopBnNGlA3+TJ6j5H9sgZcgfFm7VtD7lI/dKGkqaa30eYyU+vfGbPDZu+t?=
 =?us-ascii?Q?PZxzdnChIhw5NxB9YQ0pN8apTQ32Qjbg5RNb6YdAFDT79+N9gppa5unTXgxF?=
 =?us-ascii?Q?/kKdEQwOzpFzhiH13Xp2jSG2jConv8qRIK6t9THu+Tv/sTLQ4rbwioj6kjqj?=
 =?us-ascii?Q?ZxAiyolUpJggz3QZRQrHHweWh5x30MswUw75nwVgvMK1Xax1aLAiebWYyQyN?=
 =?us-ascii?Q?hdEKvs73pWG07PSVTPBfCajuH4PcgmfW5VRsL0uhAo2+Uk/39v2UK13YJmG8?=
 =?us-ascii?Q?j4bIruVY2bHIPOMm1wbVtTnGimlMF0D6tlL2SldPoMYV8+beuqgX7Vj6q5qT?=
 =?us-ascii?Q?1FpoepdAINMTM0WRxIQ/QDx5z6iN7G7lixvRScsURN1VvL/1T9Ztf13/EFb+?=
 =?us-ascii?Q?KalWZD9YCwQ9idl4iQItdiSpxFc6F7+tuPOqgbNMCrlOxyPP65pkFnOD2EFO?=
 =?us-ascii?Q?Y5272Wr0gaymTmxXi1wQP7vUsQGk99VSMRSeGqaxlsQsgdpPX5e/h4wSUvzL?=
 =?us-ascii?Q?zMrVnUdN9nscxWml3FErYZYQxQ8PsnGDzMYjsoHbD8Y0wf6TEbAsLeSDUVlG?=
 =?us-ascii?Q?VNvTV6mtLmU51Y9VAfGFErldy5fgYVJNWkLuVId5wXM7vwV6Km9Zoqvpm1BU?=
 =?us-ascii?Q?RYOS/n/t3kfJdLPmG0DZd5Fu6ZvC+Sdtc5rAsdzuxh511ilWyvnNQ8hmegs0?=
 =?us-ascii?Q?3QJxGfdpNIEY09YppLF1bl5rFWKHpMFP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 17:52:15.1688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6f54ab-cc22-4f72-e01b-08dca03fde67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8779

From: Nikunj A Dadhania <nikunj@amd.com>

Malicious guests can cause bus locks to degrade the performance of
a system.  The Bus Lock Threshold feature is beneficial for
hypervisors aiming to restrict the ability of the guests to perform
excessive bus locks and slow down the system for all the tenants.

Add a test case to verify the Bus Lock Threshold feature for SVM.

[Manali:
  - The KVM_CAP_X86_BUS_LOCK_EXIT capability is not enabled while
    vcpus are created, changed the VM and vCPU creation logic to
    resolve the mentioned issue.
  - Added nested guest test case for bus lock exit.
  - massage commit message.
  - misc cleanups. ]

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Co-developed-by: Manali Shukla <manali.shukla@amd.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/svm_buslock_test.c   | 114 ++++++++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/svm_buslock_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index ce8ff8e8ce3a..711ec195e386 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -94,6 +94,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
 TEST_GEN_PROGS_x86_64 += x86_64/smm_test
 TEST_GEN_PROGS_x86_64 += x86_64/state_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
+TEST_GEN_PROGS_x86_64 += x86_64/svm_buslock_test
 TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
 TEST_GEN_PROGS_x86_64 += x86_64/svm_int_ctl_test
 TEST_GEN_PROGS_x86_64 += x86_64/svm_nested_shutdown_test
diff --git a/tools/testing/selftests/kvm/x86_64/svm_buslock_test.c b/tools/testing/selftests/kvm/x86_64/svm_buslock_test.c
new file mode 100644
index 000000000000..dcb595999046
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/svm_buslock_test.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * svm_buslock_test
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ *
+ * SVM testing: Buslock exit
+ */
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+
+#define NO_ITERATIONS 100
+#define __cacheline_aligned __aligned(128)
+
+struct buslock_test {
+	unsigned char pad[126];
+	atomic_long_t val;
+} __packed;
+
+struct buslock_test test __cacheline_aligned;
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
+	 * Increment a cache unaligned variable atomically.
+	 * This should generate a bus lock exit.
+	 */
+	for (int i = 0; i < NO_ITERATIONS; i++)
+		buslock_atomic_add(2, &test.val);
+}
+
+static void l2_guest_code(void)
+{
+	buslock_add();
+	GUEST_DONE();
+}
+
+static void l1_guest_code(struct svm_test_data *svm)
+{
+	#define L2_GUEST_STACK_SIZE 64
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
+static void guest_code(struct svm_test_data *svm)
+{
+	buslock_add();
+
+	if (this_cpu_has(X86_FEATURE_SVM))
+		l1_guest_code(svm);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_run *run;
+	struct kvm_vm *vm;
+	vm_vaddr_t svm_gva;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_BUS_LOCK_EXIT));
+
+	vm = vm_create(1);
+	vm_enable_cap(vm, KVM_CAP_X86_BUS_LOCK_EXIT, KVM_BUS_LOCK_DETECTION_EXIT);
+	vcpu = vm_vcpu_add(vm, 0, guest_code);
+
+	vcpu_alloc_svm(vm, &svm_gva);
+	vcpu_args_set(vcpu, 1, svm_gva);
+
+	run = vcpu->run;
+
+	for (;;) {
+		struct ucall uc;
+
+		vcpu_run(vcpu);
+
+		if (run->exit_reason == KVM_EXIT_X86_BUS_LOCK) {
+			run->flags &= ~KVM_RUN_X86_BUS_LOCK;
+			run->exit_reason = 0;
+			continue;
+		}
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			/* NOT REACHED */
+		case UCALL_SYNC:
+			break;
+		case UCALL_DONE:
+			goto done;
+		default:
+			TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
+		}
+	}
+done:
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.34.1


