Return-Path: <linux-kselftest+bounces-42121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E41B94612
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B010516CDA0
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FF030FC2D;
	Tue, 23 Sep 2025 05:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fd8qXVdS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D38730DD34;
	Tue, 23 Sep 2025 05:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604736; cv=fail; b=jltcT9kFNo6BZjgO/6x3hydi6n4cMPiEDrXoOWwe19uWzItAknbITmkP04XWv21lXT7LYXPdOfQPHHqkxRoEbdGteAJrXoe/KhN6lapPo+gtmC2E09IL8AMNY0kxEqx9qslK3wkMEBH4ZgJeqNJu2ohxs8GXhj5THq5xxEujoJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604736; c=relaxed/simple;
	bh=kgpiGzo8PcWptKpmlY0ga6ms1RXTqMv9ljzWmNgaJOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eSRsZVUjgkKW4d3/g60pAz5dlbzEQ/aGmTDVPYF+7tQwVSzqGaTFidF2s1pN1tRTltxgtY8lFqlUQAZwQWCrQZu4XKq8aRk5WuhrJL/RLn2yQffV/FcquziL23cEAda2loGYMn4y3y25num8nJXJVmIlGiARFVNiuboD1cKemCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fd8qXVdS; arc=fail smtp.client-ip=52.101.46.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZG8OijFOmvCUQcqBfrP8O4ziChnoUzYVXAd44CLv+GghkiWpYBHWlCp6hSEV76QCiXPd6cz2FBhDYXak2flMO5hUO0zt8u02FNEvrlYP3wspIs8PkUNWKbqQuqNI7hcWqrTykFYBpmcV3XXo70XqixxLdW5lJ41O2bjL8gjsTwo/3ZOVJlphMENckZXuwCdXoXzEQYRZ1eZ4c6u9Iylqu7Z4Yt9TZDVzndh9iRHDeCDAjVrNs0MljWEqG4RY36KH7TJxv6md3s4Z/s0JwkikhTJUeYt+xZmkOgsVjOTxB2q2sPn62tIbm8e44C2oo9IU30QweBWlFUzsYyX2yIt1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLyrH6WACChjeEOUOrEWp+ia8msxA52N4U1Z90AQmnM=;
 b=BbYPmz0OD7Bsjfgiw0iUU02HRYXYb7pSWTFewubFG5WtdJQMqtDkekkqngTMUQ5Wt1dHQZINnmgtSZl1e0yI4Q4dOIHzO7qZGNLY3WYCqrjrVvp/qj4YFwdAEra3A7TBCrFRllXWFKPyjfDwkSEfiBpURis/aujZ3yZggyAF665/bM+9QOLRL3R4SAlHKBLIZUhoZEeJcvkTcIOlu4iNCgYCeMv4ajKCa34J14ezYAACU7M0PB6fhLpI8uoBBCxdkr6oGQvY1PWBYBrGsxNNAdGq/0U4X9Qe1m6uYn9EO01NoISRCFqK2NSaevdjXo4qwGeBjQKiwRwsMrTsTOMT/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLyrH6WACChjeEOUOrEWp+ia8msxA52N4U1Z90AQmnM=;
 b=Fd8qXVdS2Pxz4CJDvvD3yYZxdJZ/ylMcrCxh3yo9AlMOFgQOYhqj919jk9N2y4IaImCoh3UBu03g2QxK1koEg6ZZxQXGJq2Vy/kU6z1BqcP/eGfc7Ta/S6YumzMBHbB5EhWdmCB5pRqSAbfV2d/jxyCIBbDdMxg5ViyyeEwixXo=
Received: from SJ0PR05CA0137.namprd05.prod.outlook.com (2603:10b6:a03:33d::22)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 05:18:48 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::ec) by SJ0PR05CA0137.outlook.office365.com
 (2603:10b6:a03:33d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:18:47 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:18:42 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 30/35] KVM: selftests: Add test to verify APIC MSR accesses for SAVIC guest
Date: Tue, 23 Sep 2025 10:39:37 +0530
Message-ID: <20250923050942.206116-31-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923050942.206116-1-Neeraj.Upadhyay@amd.com>
References: <20250923050942.206116-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f61841a-40c6-426f-0b27-08ddfa60acc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U0+fBppDfnP8pP0pNQb3TYiMmkWfKaIzznaTkPLkXY99Ko6EKSFZ69qzwvEy?=
 =?us-ascii?Q?Jo2AZzR6MCxGJX4x2Dzon5zUVZE4ho4bnJXLNsEn3FlEI+KRRd2+cuIkdv7/?=
 =?us-ascii?Q?0Kx58owKt3HeTqPbNjURxI0vvrE8yqrztwtH9L9Yh7glJz0Lf39yazuaIEEV?=
 =?us-ascii?Q?O8YNTT3sG3BwdiBMAHDQRz4sqGJXe4OLBrvieDxkQxQ2FwQVRV+O3RnWEPf2?=
 =?us-ascii?Q?2TF+EaL81TZtrZhe+ttinkUpiHfASu13Ta2E+jeDgzc3OlIlJ1g4ob9Rc6tN?=
 =?us-ascii?Q?B5B0/rqsHTidhvEYMETyqrWkHWwUUGH2ClB7HTFA5ovfOtQzaA5jhdX1Zq56?=
 =?us-ascii?Q?b+xepV3+v5BvuLT1xSAb8jU5XqG59tK8ThFV3cG67VvnNT4FoutbhzONpcVE?=
 =?us-ascii?Q?/iQ0nziJ4XGHogjo9Qduep9wy8ZDkZ4bZWH2TwhMWWLMBLGyD4CG2+HDxbGw?=
 =?us-ascii?Q?wG2gSs01Aa7Agc8RUpFCYwIa/2VzdQPqazAKSyI295qXpmGZx8lWfjdh24cF?=
 =?us-ascii?Q?V6u+Al/qC2bRkN1h7wFg1Sw1pS7q+SBMh3lC/h7Cge4DK+c2ae3oxQJhNAU5?=
 =?us-ascii?Q?nBDqsc3ALdSZhpGpVzzHgnOfyNPm4bytxO1HKC5YDH+pYNjR/tAB0DHt73Eq?=
 =?us-ascii?Q?NMluIqYtAVTt5MvJnKNms5WJ3CJRF0qnkJC3PdLfrh2LgB8w+yTshsHiYSg0?=
 =?us-ascii?Q?JhwUmnXjFzjGPDX9ix3M1Yubb/vdeNotfMkgeOLvTrouWn3aD017tH6qOXG+?=
 =?us-ascii?Q?B/qZXVs+sB+Bbs1gHMqjnGz2E7+aFaxNLYnhfZI7YFbDtVoAR00kFZzbWvZz?=
 =?us-ascii?Q?LCFGbT0hlJ9SfUO7GhlWhXFotrieN/3NNKX1Baxm1Rp0BmFJ67nMBgMIcW5y?=
 =?us-ascii?Q?RR0J6oOAvOcK8ii468P+GV3hJihvs979YriXAWsefma5USousFa4aezjXvvZ?=
 =?us-ascii?Q?SA4UxmGlZnRr8/W6mbJn2//rbCFNMtP5BPig8TwGCrP8qeQgVNI/1X7gE/wl?=
 =?us-ascii?Q?683EwROZliIwQH4lB7PDPMD1XZ1Rxdqx9QD53ZkNuja0iV7OWPe7HqzUzPWW?=
 =?us-ascii?Q?YYZPetD0Z+/Of3bBf4oZtOe2zAXqeSp/VwxKr3tXRGqPAa1IogjguejFFxpS?=
 =?us-ascii?Q?nvhH9izqtUr7DpuWJ8JASoc4K4/+vXLUbSZvAXySKijdaqJ11jbgUbAXTQEQ?=
 =?us-ascii?Q?gd+B4UQPFl//K2FnyeBMAXzqDdZ9MY5jyZhLasn3WZV5Z/ZbJc8iLNTvB+nf?=
 =?us-ascii?Q?lXXpA+NuEgmR210wXEXHAbbsvforRvoBTdCkcNecSsqIwbkoKiNs/96+51kx?=
 =?us-ascii?Q?p0YMjdl9a0f2702IBnddSYaHJIhXfPCSx2BWNjFJ8ZK5rnDgH9tBuUCv7GO6?=
 =?us-ascii?Q?cFVjAJFwxiLypPbjlMVdOrfxxdXdVB0GBTcmflsGowlQA5iE5SQkYUcrQbkO?=
 =?us-ascii?Q?xVQx3pwN8S5uD7C20P1ohz6b3NpoVsgdq3KxpO2yDuey0hLHF+3AT7lpHMvk?=
 =?us-ascii?Q?uXVrvk7ArWNQVCIPUlVmvQAQqGkU036A7Y6N?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:18:47.7467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f61841a-40c6-426f-0b27-08ddfa60acc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398

When Secure AVIC (SAVIC) is enabled in an SEV-SNP guest, a hybrid model
for APIC register access is used. Some registers are accelerated by the
hardware, while others trigger a #VC exception for emulation by the
guest's #VC handler. This complex interaction requires dedicated testing
to ensure correctness.

Add savic_test.c, a new selftest designed to validate APIC MSR accesses
in SAVIC mode. The test creates an SEV-SNP VM with SAVIC enabled and
systematically performs rdmsr/wrmsr operations on a comprehensive set
of APIC registers.

The test verifies several key behaviors:

* Ensure that accesses to unaccelerated MSRs (e.g., APIC_TMICT, APIC_LVTT)
  correctly trigger a #VC exception and are properly emulated by the
  savic_vc_handler().

* Confirm that architecturally invalid operations, such as writing to a
  read-only register (APIC_LVR) or reading a write-only register
  (APIC_EOI), generate the expected #GP fault.

* Verify that the state in the guest's APIC backing page is consistent
  with values read via RDMSR after a write.

* Validate that register writes are correctly propagated (or intentionally
  not propagated) to the hypervisor's internal state, ensuring proper
  synchronization for registers like APIC_SPIV versus accelerated
  registers like APIC_TASKPRI.

This test provides essential coverage for the SAVIC feature, ensuring its
MSR handling mechanism is implemented correctly.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/include/x86/apic.h  |   1 +
 .../testing/selftests/kvm/include/x86/savic.h |   4 +
 tools/testing/selftests/kvm/lib/x86/savic.c   |  20 +-
 tools/testing/selftests/kvm/x86/savic_test.c  | 291 ++++++++++++++++++
 5 files changed, 312 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/savic_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index b94ac1caa514..1b0281e6bbe1 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -96,6 +96,7 @@ TEST_GEN_PROGS_x86 += x86/pmu_counters_test
 TEST_GEN_PROGS_x86 += x86/pmu_event_filter_test
 TEST_GEN_PROGS_x86 += x86/private_mem_conversions_test
 TEST_GEN_PROGS_x86 += x86/private_mem_kvm_exits_test
+TEST_GEN_PROGS_x86 += x86/savic_test
 TEST_GEN_PROGS_x86 += x86/set_boot_cpu_id
 TEST_GEN_PROGS_x86 += x86/set_sregs_test
 TEST_GEN_PROGS_x86 += x86/smaller_maxphyaddr_emulation_test
diff --git a/tools/testing/selftests/kvm/include/x86/apic.h b/tools/testing/selftests/kvm/include/x86/apic.h
index aa3a5d54c404..af555638086f 100644
--- a/tools/testing/selftests/kvm/include/x86/apic.h
+++ b/tools/testing/selftests/kvm/include/x86/apic.h
@@ -33,6 +33,7 @@
 #define	APIC_SPIV	0xF0
 #define		APIC_SPIV_FOCUS_DISABLED	(1 << 9)
 #define		APIC_SPIV_APIC_ENABLED		(1 << 8)
+#define APIC_ISR	0x100
 #define APIC_TMR        0x180
 #define APIC_IRR	0x200
 #define	APIC_ICR	0x300
diff --git a/tools/testing/selftests/kvm/include/x86/savic.h b/tools/testing/selftests/kvm/include/x86/savic.h
index 238d7450ab6e..33f19f5e39b3 100644
--- a/tools/testing/selftests/kvm/include/x86/savic.h
+++ b/tools/testing/selftests/kvm/include/x86/savic.h
@@ -6,6 +6,9 @@
 #ifndef SELFTEST_KVM_SAVIC_H
 #define SELFTEST_KVM_SAVIC_H
 
+#define APIC_REG_OFF(VEC)		(VEC / 32 * 16)
+#define APIC_VEC_POS(VEC)		(VEC % 32)
+
 struct guest_apic_page;
 
 void guest_apic_pages_init(struct kvm_vm *vm);
@@ -17,4 +20,5 @@ uint64_t savic_hv_read_reg(uint32_t reg);
 void savic_enable(void);
 int savic_nr_pages_required(uint64_t page_size);
 void savic_vc_handler(struct ex_regs *regs);
+struct guest_apic_page *get_guest_apic_page(void);
 #endif
diff --git a/tools/testing/selftests/kvm/lib/x86/savic.c b/tools/testing/selftests/kvm/lib/x86/savic.c
index 24ee15cc5603..da01bb5deae1 100644
--- a/tools/testing/selftests/kvm/lib/x86/savic.c
+++ b/tools/testing/selftests/kvm/lib/x86/savic.c
@@ -8,6 +8,7 @@
 #include "apic.h"
 #include "kvm_util.h"
 #include "sev.h"
+#include "savic.h"
 
 struct apic_page {
 	u8 apic_regs[PAGE_SIZE];
@@ -44,9 +45,6 @@ enum lapic_lvt_entry {
 #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS      0x402
 #define SVM_EXIT_AVIC_INCOMPLETE_IPI            0x401
 
-#define REG_OFF(VEC)		(VEC / 32 * 16)
-#define VEC_POS(VEC)		(VEC % 32)
-
 #define SAVIC_NMI_REQ_OFFSET            0x278
 
 /*
@@ -104,6 +102,11 @@ void set_savic_control_msr(struct guest_apic_page *apic_page, bool enable, bool
 	wrmsr(MSR_AMD64_SECURE_AVIC_CONTROL, val);
 }
 
+struct guest_apic_page *get_guest_apic_page(void)
+{
+	return &apic_page_pool->guest_apic_page[x2apic_read_reg(APIC_ID)];
+}
+
 /*
  * Write APIC reg offset in the guest APIC backing page.
  *
@@ -175,11 +178,17 @@ static void savic_init_backing_page(struct guest_apic_page *apic_page, uint32_t
 	regval = savic_hv_read_reg(APIC_LDR);
 	savic_write_reg(apic_page, APIC_LDR, regval);
 
-	for (i = LVT_THERMAL_MONITOR; i < APIC_MAX_NR_LVT_ENTRIES; i++) {
+	for (i = LVT_TIMER; i < APIC_MAX_NR_LVT_ENTRIES; i++) {
 		regval = savic_hv_read_reg(APIC_LVTx(i));
 		savic_write_reg(apic_page, APIC_LVTx(i), regval);
 	}
 
+	regval = savic_hv_read_reg(APIC_TMICT);
+	savic_write_reg(apic_page, APIC_TMICT, regval);
+
+	regval = savic_hv_read_reg(APIC_TDCR);
+	savic_write_reg(apic_page, APIC_TDCR, regval);
+
 	regval = savic_hv_read_reg(APIC_LVT0);
 	savic_write_reg(apic_page, APIC_LVT0, regval);
 
@@ -351,7 +360,8 @@ static void send_ipi(int cpu, int vector, bool nmi)
 	if (nmi)
 		savic_write_reg(apic_page, SAVIC_NMI_REQ_OFFSET, 1);
 	else
-		savic_write_reg(apic_page, APIC_IRR + REG_OFF(vector), BIT(VEC_POS(vector)));
+		savic_write_reg(apic_page, APIC_IRR + APIC_REG_OFF(vector),
+				BIT(APIC_VEC_POS(vector)));
 }
 
 static bool is_cpu_present(int cpu)
diff --git a/tools/testing/selftests/kvm/x86/savic_test.c b/tools/testing/selftests/kvm/x86/savic_test.c
new file mode 100644
index 000000000000..bac56f85caea
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/savic_test.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ *  Copyright (C) 2024 Advanced Micro Devices, Inc.
+ *
+ */
+#include <pthread.h>
+
+#include "processor.h"
+#include "apic.h"
+#include "kvm_util.h"
+#include "sev.h"
+#include "test_util.h"
+#include "savic.h"
+
+#define NR_SAVIC_VCPUS	1
+
+static struct kvm_vcpu *vcpus[NR_SAVIC_VCPUS];
+static pthread_t threads[NR_SAVIC_VCPUS];
+
+#define SAVIC_TEST_STATE(STATE) \
+	STATE ## _START, \
+	STATE ## _END
+
+enum savic_test_state {
+	SAVIC_TEST_STATE(SAVIC_APIC_MSR_ACCESSES),
+};
+
+#define SAVIC_GUEST_SYNC(sync, func) ({\
+	GUEST_SYNC(sync ## _START); \
+	func(id); \
+	GUEST_SYNC(sync ## _END); \
+})
+
+static int savic_wrmsr(uint32_t reg, uint64_t val)
+{
+	switch (reg) {
+	case APIC_LVR:
+	case APIC_LDR:
+	case APIC_ISR:
+	case APIC_TMR:
+	case APIC_IRR:
+	case APIC_TMCCT:
+		x2apic_write_reg_fault(reg, val);
+		return -1;
+	default:
+		x2apic_write_reg(reg, val);
+		break;
+	}
+
+	return 0;
+}
+
+static uint64_t savic_rdmsr(uint32_t reg)
+{
+	uint64_t val;
+	uint32_t msr = APIC_BASE_MSR + (reg >> 4);
+
+	switch (reg) {
+	case APIC_EOI:
+		uint8_t fault = rdmsr_safe(msr, &val);
+
+		__GUEST_ASSERT(fault == GP_VECTOR,
+				"Wanted #GP on RDMSR(%x) = %x, got 0x%x\n",
+				msr, GP_VECTOR, fault);
+		return val;
+	default:
+		return x2apic_read_reg(reg);
+	}
+}
+
+static void guest_verify_host_guest_reg(struct guest_apic_page *apage, uint32_t reg,
+		uint64_t val, char *regname)
+{
+	uint64_t hval, gval, gval2;
+
+	if (savic_wrmsr(reg, val) == -1) {
+		savic_write_reg(apage, reg, val);
+		/*
+		 * Write using PV interface if wrmsr fails. Skip for
+		 * regs which trigger GP
+		 */
+		if (reg != APIC_LVR && reg != APIC_TMR && reg != APIC_IRR)
+			savic_hv_write_reg(reg, val);
+	}
+
+	gval = savic_read_reg(apage, reg);
+	gval2 = savic_rdmsr(reg);
+	hval = savic_hv_read_reg(reg);
+	__GUEST_ASSERT(gval == val, "Unexpected Guest %s 0x%lx, expected val:0x%lx\n",
+			regname, gval, val);
+	__GUEST_ASSERT(gval == gval2, "Unexpected Guest %s backing page value : 0x%lx, msr read val:0x%lx\n",
+			regname, gval, gval2);
+
+	switch (reg) {
+	case APIC_LVR:
+	case APIC_LDR:
+	case APIC_ISR:
+	case APIC_TMICT:
+	case APIC_TDCR:
+	case APIC_LVTT:
+	case APIC_LVTTHMR:
+	case APIC_LVTPC:
+	case APIC_LVT0:
+	case APIC_LVT1:
+	case APIC_LVTERR:
+	case APIC_SPIV:
+		__GUEST_ASSERT(hval == gval, "Guest 0x%lx host 0x%lx %s mismatch\n",
+			gval, hval, regname);
+		break;
+	case APIC_TASKPRI:
+	case APIC_ICR:
+	case APIC_TMR:
+	case APIC_IRR:
+		__GUEST_ASSERT(hval != gval, "Guest 0x%lx host 0x%lx reg: %x %s must not match\n",
+			gval, hval, reg, regname);
+		break;
+	default:
+		break;
+	}
+}
+
+static inline uint32_t x2apic_ldr(uint32_t id)
+{
+	return ((id >> 4) << 16) | (1 << (id & 0xf));
+}
+
+static void guest_savic_apic_msr_accesses(int id)
+{
+	struct guest_apic_page *apage = get_guest_apic_page();
+	uint64_t val, hval;
+	uint32_t reg;
+	int vec;
+	int i;
+	uint32_t lvt_regs[] = {
+		APIC_LVTT, APIC_LVTTHMR, APIC_LVTPC,
+		APIC_LVT0, APIC_LVT1, APIC_LVTERR
+	};
+
+	reg = APIC_LVR;
+	val = savic_hv_read_reg(reg);
+	/* APIC_LVR state is in sync between host and guest. */
+	guest_verify_host_guest_reg(apage, reg, val, "APIC_LVR");
+
+	reg = APIC_TASKPRI;
+	val = 0x30;
+	/* Write new TASKPRI to host using PV interface. */
+	savic_hv_write_reg(reg, val);
+	val = 0x40;
+	/* TASKPRI is accelerated and state is not up-to-date in host. */
+	guest_verify_host_guest_reg(apage, reg, val, "APIC_TASKPRI");
+
+	reg = APIC_PROCPRI;
+	val = x2apic_read_reg(reg);
+	/* APIC_PROCPRI is updated with the APIC_TASKPRI update above. */
+	GUEST_ASSERT((val & 0xf0) == (x2apic_read_reg(APIC_TASKPRI) & 0xf0));
+	GUEST_ASSERT((val & 0xf0) == 0x40);
+	vec = 0x20;
+	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT | vec);
+	/* Interrupt remains pending in APIC_IRR. */
+	val = savic_read_reg(apage, APIC_IRR + APIC_REG_OFF(vec));
+	GUEST_ASSERT((val & BIT_ULL(APIC_VEC_POS(vec))) == BIT_ULL(APIC_VEC_POS(vec)));
+	savic_wrmsr(APIC_TASKPRI, 0x0);
+
+	/* Triggers GP fault */
+	savic_rdmsr(APIC_EOI);
+
+	reg = APIC_LDR;
+	val = x2apic_ldr(savic_rdmsr(APIC_ID));
+	hval = savic_hv_read_reg(APIC_LDR);
+	__GUEST_ASSERT(val == hval, "APIC_LDR mismatch between host %lx and guest %lx",
+			hval, val);
+
+	/* APIC_SPIV state is not visible to host. */
+	reg = APIC_SPIV;
+	val = savic_rdmsr(APIC_SPIV) & ~APIC_SPIV_APIC_ENABLED;
+	savic_hv_write_reg(reg, val);
+	val = savic_rdmsr(APIC_SPIV) | APIC_SPIV_APIC_ENABLED;
+	guest_verify_host_guest_reg(apage, reg, val, "APIC_SPIV");
+
+	reg = APIC_ISR;
+	(void) savic_rdmsr(reg);
+	/* Triggers GP fault */
+	savic_wrmsr(reg, 0x10);
+
+	/* APIC_TMR is not synced to host. */
+	reg = APIC_TMR;
+	val = 0x10000;
+	guest_verify_host_guest_reg(apage, reg, val, "APIC_TMR");
+	vec = 0x20;
+	savic_write_reg(apage, reg + APIC_REG_OFF(vec),  BIT_ULL(APIC_VEC_POS(vec)));
+	GUEST_ASSERT(x2apic_read_reg(reg + APIC_REG_OFF(vec)) & BIT_ULL(APIC_VEC_POS(vec)));
+
+	reg = APIC_IRR;
+	val = 0x10000;
+	guest_verify_host_guest_reg(apage, reg, val, "APIC_IRR");
+	savic_write_reg(apage, reg, 0x0);
+
+	reg = APIC_TMICT;
+	val = 0x555;
+	guest_verify_host_guest_reg(apage, reg, val, "APIC_TMICT");
+
+	reg = APIC_TMCCT;
+	savic_rdmsr(reg);
+	savic_wrmsr(reg, 0xf);
+
+	reg = APIC_TDCR;
+	val = 0x1;
+	savic_hv_write_reg(reg, val);
+	val = 0x3;
+	guest_verify_host_guest_reg(apage, reg, val, "APIC_TDCR");
+
+	for (i = 0; i < ARRAY_SIZE(lvt_regs); i++) {
+		reg = lvt_regs[i];
+		val = 0x41;
+		savic_hv_write_reg(reg, val);
+		val = 0x42;
+		guest_verify_host_guest_reg(apage, reg, val, "APIC_LVTx");
+	}
+}
+
+static void guest_code(int id)
+{
+	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SNP_SECURE_AVIC);
+
+	x2apic_enable();
+
+	savic_enable();
+
+	SAVIC_GUEST_SYNC(SAVIC_APIC_MSR_ACCESSES, guest_savic_apic_msr_accesses);
+
+	GUEST_DONE();
+}
+
+static void *vcpu_thread(void *arg)
+{
+	struct kvm_vcpu *vcpu = (struct kvm_vcpu *)arg;
+	struct ucall uc;
+
+	fprintf(stderr, "vCPU thread running vCPU %u\n", vcpu->id);
+
+	while (true) {
+		vcpu_run(vcpu);
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			break;
+		case UCALL_DONE:
+			return NULL;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			break;
+		case UCALL_NONE:
+			continue;
+		default:
+			TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
+		}
+
+	}
+
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_sev_init args = {
+		.vmsa_features = BIT_ULL(SVM_FEAT_SECURE_AVIC)
+	};
+	struct kvm_vm *vm;
+	int r;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV_SNP));
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SECURE_AVIC));
+
+	vm = _vm_sev_create_with_one_vcpu(KVM_X86_SNP_VM, guest_code, &vcpus[0], &args);
+
+	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+
+	vcpu_args_set(vcpus[0], 1, vcpus[0]->id);
+
+	vm_install_exception_handler(vm, 29, savic_vc_handler);
+	vm_sev_launch(vm, snp_default_policy(), NULL);
+
+	r = pthread_create(&threads[0], NULL, vcpu_thread, vcpus[0]);
+	TEST_ASSERT(r == 0, "pthread_create failed errno=%d", errno);
+
+	pthread_join(threads[0], NULL);
+
+	kvm_vm_free(vm);
+
+	return 0;
+}
-- 
2.34.1


