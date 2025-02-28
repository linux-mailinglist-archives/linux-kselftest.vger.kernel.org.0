Return-Path: <linux-kselftest+bounces-27861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E64DDA495FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24EAE3A577F
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5883A25A621;
	Fri, 28 Feb 2025 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3AsQ1EWG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC52580CE;
	Fri, 28 Feb 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736343; cv=fail; b=PnY09qBA8LTV8EHNhvfD9QL6ntje8z5BfBhoWDcGFiCozZ3Ilh0ZZKeG3QNOdZQuSYKwim5xjtxzdkoz0zOEB98T4d+AKL1rAnxznr/KCUc0FYLVpRWmnyjn8E2IOmrkbsHZJrkShdIyP0/xREvmsYNE3maMpxlwTFkLwB3RJPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736343; c=relaxed/simple;
	bh=LSEJyd7RiklyOKaxcJ/MrPG3wKoulWwh+ZAn6WLuwt8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lulTSydn7ORp4i2KT5+17QKCDuCoW7oAfUgqaWnvQiol/K+e+P6biKsvC0xWgA6xMCPK9J009KywohwkVFlyXqu2K2W8dhETwNzzB96pw8PsHVuQHaWzfJ5BAcfsVncVobBhd5Ftl3GMCuW8Rk+/bF0oniQ/wRihV7e6U6AlibM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3AsQ1EWG; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+UYOqeBnoXU+ujLEMzhHRxWm2TbPtQU33OwzArp8ACe502esH6kqQfEiI62TPhb5amvzKeMxDmEvZkbqWfijybX0t6QyodQEWCNee2KZVx54gyUKAGihQZjNVRJWfcDTc4Fw3hk83ttRwPxaDT28XQwb6thUtPjHm6fps1kW/nMY8gPjDRGNP8UCQES32lddp/kSoMtynfGhmyHo/rqAosXSJz21zgTA8XgxzpOh7i8LmM392bw1dpxedmGZ1wQ44t6Bn/h+WnZ5XScv86RwSnv8YqSKT45G9Olz4d4hZcSg5aqKo/49Op3ENkHtL7dKpvfqX0xSowcAPvS7D7qiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlVIfj3eavVfdhwaV8diMiha5/TX7z4HTfxyRreuYJI=;
 b=cCjINs4z1u4zT2DmbOKtdc1vqSdqCJfAI18T1CxrkSfFgZmkA9tDg55suNSzt3StaPTUYtrsqDU5qcXlDkHCmWg8lpqPOhvxE30laKhn9s8tN0xRizqWUYDa6TQu5Fue6mwQApimm1z4Ax086Go5pBEKWqZe8mlkorkeymSANHTbqC00z6F35VZ3nnre2+Z62kjfIFdAh807XHQvRPoker9X+WGavkTfV5yu6LPk/3gPKLXi7hGveGFVt/JK9NFK/x/Zfc6Q84w0dkhcFcsBt+Tn3U3DGqifZ85S0FU4BBCMyysgQupaXCAO8ZmHaLcFQfIKOUrfUqr9pd1Ou7eqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlVIfj3eavVfdhwaV8diMiha5/TX7z4HTfxyRreuYJI=;
 b=3AsQ1EWGmUd7Okj+X5qPzuN9BV6cHyVVzPTR+2G8FYstfOeNiU5TPJCLQWjBwrEzNz4H+YuAIkOk4yc7wUl2YB3hz5FY/pA8sszoTJmPeZ5l4yE9a57eFNkWSmIpva+eReGhF8DaaMlhgilgVioD0Bpivq/ZUCW61cq9+XDL2FY=
Received: from MW4PR04CA0187.namprd04.prod.outlook.com (2603:10b6:303:86::12)
 by SJ5PPF75EAF8F39.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::999) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 09:52:16 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:303:86:cafe::4b) by MW4PR04CA0187.outlook.office365.com
 (2603:10b6:303:86::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 09:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:52:16 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:52:11 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 19/31] KVM: selftests: Add  Secure AVIC lib
Date: Fri, 28 Feb 2025 15:00:12 +0530
Message-ID: <20250228093024.114983-20-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228093024.114983-1-Neeraj.Upadhyay@amd.com>
References: <20250228093024.114983-1-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|SJ5PPF75EAF8F39:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c5d7e1-d587-4c3c-f286-08dd57dd9566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DDfxNycqnHJ+wpYtZZoYE7ozrkiDHdmI1s/64qmIslSwak/IsHJ0UDPBPu9K?=
 =?us-ascii?Q?vYn3aZhCSMMYb4AXZiy7jtUndkxPfKqhb/8Fud72NV9i7GM5vqOkPxfzbZQC?=
 =?us-ascii?Q?hqfFI8ExbTc+9n4iknOqJmwLDPD85GGCD4tGwTGnl+MuJNdcP6rmCCumGcEw?=
 =?us-ascii?Q?HTnm+BREe+bV4FBRBfk34baRy43e3t+xNp0Z/j/VRfeyFNFzr8phNBteKRsV?=
 =?us-ascii?Q?23UMRPtslO53X56k2d+BamWCO71C2PX1ghKP7kc0y8tvObworQon36O1KLQl?=
 =?us-ascii?Q?qHlew9UYPSRyPAJ8YH00y1M/OLiZUKKdY+fCHyEsG6xuNzajVwKiyUqd/CWJ?=
 =?us-ascii?Q?sPxLPx1T0I/N5s8AaA9TxudTsklNg/KYd341vLvo0WuLucbePIKih/AuUUBt?=
 =?us-ascii?Q?Zb54CPd0FJFcC0C5eyMrXtP8ILxUM9r+ZYmUHNJVVkDN+4D6FLPHnqsEmu5l?=
 =?us-ascii?Q?m2ERn8sVMAuftHgw80vtvNbH9b5Yu3ml3cVyuLyYrKS0/RVSkJdwjp1vOYdk?=
 =?us-ascii?Q?dl/KNtYQkKjnqk94+rZckNSXP8NmVpunCmKGlROU1b+46cq68sDSSLEjUQE3?=
 =?us-ascii?Q?q9tDvaGcgfPLUnlps2HnCxuAghosal18/N7LYOIMHbWPhdKUbdXVGVgEMYXh?=
 =?us-ascii?Q?AiIfEinsSSFKqAPpCro+evtCKnYQirSNky7QPX8CEvp5YxswL9q6K5KPjgYD?=
 =?us-ascii?Q?J/ErLSy4JDrW7AXrBUSjVEH1bejZjB1jEnxD7+Ff3w2xzCKw2ARTKYtw+Eb+?=
 =?us-ascii?Q?prTqv0mszlLZNkytFONLzLqacdKYHGm0aphUaP1hAyYDq/k6jsurfHD0mNKz?=
 =?us-ascii?Q?trEiDfc6dn8tpex1yTayqHs6kd2fqepFNf9BjLKizGQuZ/p5blK/lOhnKQ8z?=
 =?us-ascii?Q?kmrtgWaYFPZlUyRTe9Px/UCJ7XGNiMvMdPcD4UrL5pZH2+YrcoomeUxXIlHV?=
 =?us-ascii?Q?bTuhbBt8va0seqPdMaS6XlIbrUzFsHQRtlht8Gl/EhLKJ3F00blWtgf37NJa?=
 =?us-ascii?Q?CbmtvTLKlXODYWE4S2gO3QKN9MARJIY3nAJHLvxj4X1oqdUBsHSbuKttcZlM?=
 =?us-ascii?Q?FtUffRskCwExAu5IKihNspabHxhVc0tLU8p8iw1SGopwU4uYVVL5ur7J8w0P?=
 =?us-ascii?Q?4CNCH4kbcrabGf6u8OsaQjV1af8GMLeohKibAkmTQfZeUXKk8pHYxspVxghE?=
 =?us-ascii?Q?M1rks1lqPCStLEHqzN8K/KJ/NzaLX/p2x5ZAiJCWnzi1MDh6f2K0pNS1VP5o?=
 =?us-ascii?Q?2pt8hgpcbkMiNlHZ9rNeYdzVn2KE7/wDz4/TYt4ptlc0XEo7YiqqgX+cScDl?=
 =?us-ascii?Q?Hjj11e9y2hkyt8ODjEkGqDL0VFnpVdqBL0BsGySesdLjlK5DauIILJoR3uLh?=
 =?us-ascii?Q?LE1stkHlaP73cbHBcqOWjk5wbHI6xfLatjLYC1Gwha8W2Z6Y2Fc4ZeS6b6B4?=
 =?us-ascii?Q?oV6CG+3hZbeGuHQYaZs0dIBlnr+tRY+UiajaOaMm0MrItotGcBuniHTThnZb?=
 =?us-ascii?Q?7e93CIs1FEB4Czw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:52:16.0856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c5d7e1-d587-4c3c-f286-08dd57dd9566
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF75EAF8F39

Add Secure AVIC lib which provides apis to enable
Secure AVIC for a vCPU. In addition, add guest APIC
backing page initialization support and helper
functions to access APIC regs from guest APIC backing
page and from hv.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/include/x86/apic.h  |   6 +
 .../testing/selftests/kvm/include/x86/savic.h |  19 ++
 tools/testing/selftests/kvm/include/x86/svm.h |   3 +
 .../testing/selftests/kvm/lib/x86/processor.c |   7 +-
 tools/testing/selftests/kvm/lib/x86/savic.c   | 206 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/x86/sev.c     |  15 ++
 7 files changed, 255 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86/savic.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86/savic.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 5a67e79ae848..50bd78e03d9f 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -25,6 +25,7 @@ LIBKVM_x86 += lib/x86/insn-eval.c
 LIBKVM_x86 += lib/x86/memstress.c
 LIBKVM_x86 += lib/x86/pmu.c
 LIBKVM_x86 += lib/x86/processor.c
+LIBKVM_x86 += lib/x86/savic.c
 LIBKVM_x86 += lib/x86/sev.c
 LIBKVM_x86 += lib/x86/svm.c
 LIBKVM_x86 += lib/x86/ucall.c
diff --git a/tools/testing/selftests/kvm/include/x86/apic.h b/tools/testing/selftests/kvm/include/x86/apic.h
index 80fe9f69b38d..6ba5d0545bf8 100644
--- a/tools/testing/selftests/kvm/include/x86/apic.h
+++ b/tools/testing/selftests/kvm/include/x86/apic.h
@@ -29,6 +29,7 @@
 #define	APIC_TASKPRI	0x80
 #define	APIC_PROCPRI	0xA0
 #define	APIC_EOI	0xB0
+#define APIC_LDR	0xD0
 #define	APIC_SPIV	0xF0
 #define		APIC_SPIV_FOCUS_DISABLED	(1 << 9)
 #define		APIC_SPIV_APIC_ENABLED		(1 << 8)
@@ -60,10 +61,15 @@
 #define	APIC_ICR2	0x310
 #define		SET_APIC_DEST_FIELD(x)	((x) << 24)
 #define APIC_LVTT	0x320
+#define APIC_LVTTHMR    0x330
+#define APIC_LVTPC      0x340
+#define APIC_LVT0       0x350
 #define		APIC_LVT_TIMER_ONESHOT		(0 << 17)
 #define		APIC_LVT_TIMER_PERIODIC		(1 << 17)
 #define		APIC_LVT_TIMER_TSCDEADLINE	(2 << 17)
 #define		APIC_LVT_MASKED			(1 << 16)
+#define APIC_LVT1       0x360
+#define APIC_LVTERR     0x370
 #define	APIC_TMICT	0x380
 #define	APIC_TMCCT	0x390
 #define	APIC_TDCR	0x3E0
diff --git a/tools/testing/selftests/kvm/include/x86/savic.h b/tools/testing/selftests/kvm/include/x86/savic.h
new file mode 100644
index 000000000000..1ab92dad00c1
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/savic.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Helpers used for Secure AVIC guests
+ *
+ */
+#ifndef SELFTEST_KVM_SAVIC_H
+#define SELFTEST_KVM_SAVIC_H
+
+struct guest_apic_page;
+
+void guest_apic_pages_init(struct kvm_vm *vm);
+void set_savic_control_msr(struct guest_apic_page *apic_page, bool enable, bool enable_nmi);
+void savic_write_reg(struct guest_apic_page *apic_page, uint32_t reg, uint64_t val);
+uint64_t savic_read_reg(struct guest_apic_page *apic_page, uint32_t reg);
+void savic_hv_write_reg(uint32_t reg, uint64_t val);
+uint64_t savic_hv_read_reg(uint32_t reg);
+void savic_enable(void);
+int savic_nr_pages_required(uint64_t page_size);
+#endif
diff --git a/tools/testing/selftests/kvm/include/x86/svm.h b/tools/testing/selftests/kvm/include/x86/svm.h
index 66dd4eaf23b9..689fefb72d06 100644
--- a/tools/testing/selftests/kvm/include/x86/svm.h
+++ b/tools/testing/selftests/kvm/include/x86/svm.h
@@ -179,6 +179,9 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define SVM_NESTED_CTL_NP_ENABLE	BIT(0)
 #define SVM_NESTED_CTL_SEV_ENABLE	BIT(1)
 
+#define SVM_FEAT_SECURE_AVIC		16
+#define SVM_FEAT_ALLOWED_SEV_FEATURES_VALID	63
+
 struct __attribute__ ((__packed__)) vmcb_seg {
 	u16 selector;
 	u16 attrib;
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 197110ff1380..2d6105b1f610 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -659,10 +659,13 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
 
 int kvm_arch_vm_additional_pages_required(struct vm_shape shape, uint64_t page_size)
 {
-	if (shape.type == KVM_X86_SEV_ES_VM ||
-	    shape.type == KVM_X86_SNP_VM)
+	if (shape.type == KVM_X86_SEV_ES_VM)
 		return  ghcb_nr_pages_required(page_size);
 
+	if (shape.type == KVM_X86_SNP_VM)
+		return ghcb_nr_pages_required(page_size) +
+			savic_nr_pages_required(page_size);
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/kvm/lib/x86/savic.c b/tools/testing/selftests/kvm/lib/x86/savic.c
new file mode 100644
index 000000000000..f4a765b6040a
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/savic.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ *  Copyright (C) 2024 Advanced Micro Devices, Inc.
+ *
+ */
+
+#include "apic.h"
+#include "kvm_util.h"
+#include "sev.h"
+#include "ex_regs.h"
+
+struct apic_page {
+	u8 apic_regs[PAGE_SIZE];
+} __packed;
+
+struct guest_apic_page {
+	struct apic_page apic_page;
+	uint64_t gpa;
+	uint64_t hva;
+} __attribute__((__aligned__(PAGE_SIZE)));
+
+struct guest_apic_pages {
+	struct guest_apic_page guest_apic_page[KVM_MAX_VCPUS];
+};
+
+static struct guest_apic_pages *apic_page_pool;
+
+enum lapic_lvt_entry {
+	LVT_TIMER,
+	LVT_THERMAL_MONITOR,
+	LVT_PERFORMANCE_COUNTER,
+	LVT_LINT0,
+	LVT_LINT1,
+	LVT_ERROR,
+	APIC_MAX_NR_LVT_ENTRIES,
+};
+
+#define MSR_AMD64_SECURE_AVIC_CONTROL      0xc0010138
+
+#define APIC_LVTx(x) (APIC_LVTT + 0x10 * (x))
+#define MSR_AMD64_SECURE_AVIC_EN_BIT       0
+#define MSR_AMD64_SECURE_AVIC_ALLOWED_NMI_BIT       1
+
+/*
+ * Initial pool of guest apic backing page.
+ */
+void guest_apic_pages_init(struct kvm_vm *vm)
+{
+	struct guest_apic_pages *g_pages;
+	struct guest_apic_page *entry;
+	vm_vaddr_t vaddr;
+	int i;
+	size_t sz = align_up(sizeof(struct guest_apic_pages),
+			     vm_guest_mode_params[vm->mode].page_size);
+
+	vaddr = vm_vaddr_alloc(vm, sz, KVM_UTIL_MIN_VADDR);
+
+	g_pages = (struct guest_apic_pages *)addr_gva2hva(vm, vaddr);
+	memset(g_pages, 0, sz);
+
+	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
+		entry = &g_pages->guest_apic_page[i];
+		entry->hva = (uint64_t)entry;
+		entry->gpa = (uint64_t)addr_hva2gpa(vm, &entry->apic_page);
+	}
+
+	apic_page_pool = (struct guest_apic_pages *)vaddr;
+	sync_global_to_guest(vm, apic_page_pool);
+}
+
+int savic_nr_pages_required(uint64_t page_size)
+{
+	return align_up(sizeof(struct guest_apic_pages), page_size) / page_size;
+}
+
+/*
+ * Enable/disable Secure AVIC in control msr.
+ *
+ * @apic_page  : Guest APIC backing page for the CPU on which
+ *	       this function is called.
+ * @enable     : Enable/Disable Secure AVIC.
+ * @enable_nmi : Allow host to send NMI to the guest.
+ */
+void set_savic_control_msr(struct guest_apic_page *apic_page, bool enable, bool enable_nmi)
+{
+	uint64_t val = apic_page->gpa | BIT_ULL(MSR_AMD64_SECURE_AVIC_EN_BIT);
+
+	if (!enable) {
+		wrmsr(MSR_AMD64_SECURE_AVIC_CONTROL, 0);
+		return;
+	}
+
+	if (enable_nmi)
+		val |= BIT_ULL(MSR_AMD64_SECURE_AVIC_ALLOWED_NMI_BIT);
+
+	wrmsr(MSR_AMD64_SECURE_AVIC_CONTROL, val);
+}
+
+/*
+ * Write APIC reg offset in the guest APIC backing page.
+ *
+ * @apage : Backing page address.
+ * @reg   : APIC reg offset corresponding to the xapic MMIO
+ *	  offset.
+ * @val   : New value to be set for the APIC reg.
+ */
+void savic_write_reg(struct guest_apic_page *apic_page, uint32_t reg, uint64_t val)
+{
+	*(volatile uint64_t *)((uint64_t)apic_page + reg) = val;
+}
+
+/*
+ * Read APIC reg offset from the guest APIC backing page.
+ *
+ * @apage : Backing page address.
+ * @reg   : APIC reg offset corresponding to the xapic MMIO
+ *	  offset.
+ *
+ * @ret   : APIC register value in the guest APIC backing page.
+ */
+uint64_t savic_read_reg(struct guest_apic_page *apic_page, uint32_t reg)
+{
+	return *(volatile uint64_t *)((uint64_t)apic_page + reg);
+}
+
+/*
+ * Write APIC reg value to hypervisor.
+ *
+ * @reg   : APIC reg offset corresponding to the xapic MMIO
+ *	  offset.
+ * @val   : Value to be set for the APIC reg.
+ */
+void savic_hv_write_reg(uint32_t reg, uint64_t val)
+{
+	sev_es_pv_msr_rw(APIC_BASE_MSR + (reg >> 4), &val, true);
+}
+
+/*
+ * Read APIC reg offset from hypervisor.
+ *
+ * @reg   : APIC reg offset corresponding to the xapic MMIO
+ *	  offset.
+ *
+ * @ret   : APIC register value in the hypervisor's APIC state.
+ */
+uint64_t savic_hv_read_reg(uint32_t reg)
+{
+	uint64_t val;
+
+	sev_es_pv_msr_rw(APIC_BASE_MSR + (reg >> 4), &val, false);
+
+	return val;
+}
+
+static void savic_init_backing_page(struct guest_apic_page *apic_page, uint32_t apic_id)
+{
+	uint64_t regval;
+	enum lapic_lvt_entry i;
+
+	/* Update APIC ID in the backing page */
+	savic_write_reg(apic_page, APIC_ID, apic_id);
+
+	/* Set LVR, LDR, LVT* in backing page from host values */
+	regval = savic_hv_read_reg(APIC_LVR);
+	savic_write_reg(apic_page, APIC_LVR, regval);
+
+	regval = savic_hv_read_reg(APIC_LDR);
+	savic_write_reg(apic_page, APIC_LDR, regval);
+
+	for (i = LVT_THERMAL_MONITOR; i < APIC_MAX_NR_LVT_ENTRIES; i++) {
+		regval = savic_hv_read_reg(APIC_LVTx(i));
+		savic_write_reg(apic_page, APIC_LVTx(i), regval);
+	}
+
+	regval = savic_hv_read_reg(APIC_LVT0);
+	savic_write_reg(apic_page, APIC_LVT0, regval);
+
+	regval = savic_hv_read_reg(APIC_LVT1);
+	savic_write_reg(apic_page, APIC_LVT1, regval);
+}
+
+/*
+ * Initialize and enable Secure AVIC on a CPU.
+ *
+ * @context: Called from x2apic enabled context and Secure AVIC disabled.
+ */
+void savic_enable(void)
+{
+	uint64_t savic_ctrl_msr_val, exp_msr_val;
+	struct guest_apic_page *apic_page;
+	uint32_t apic_id;
+
+	__GUEST_ASSERT(apic_page_pool, "Guest APIC pages pool is not initialized");
+	apic_id = x2apic_read_reg(APIC_ID);
+	apic_page = &apic_page_pool->guest_apic_page[apic_id];
+
+	savic_init_backing_page(apic_page, apic_id);
+	set_savic_control_msr(apic_page, true, true);
+	savic_ctrl_msr_val = rdmsr(MSR_AMD64_SECURE_AVIC_CONTROL);
+	exp_msr_val = apic_page->gpa | BIT_ULL(MSR_AMD64_SECURE_AVIC_EN_BIT) |
+			BIT_ULL(MSR_AMD64_SECURE_AVIC_ALLOWED_NMI_BIT);
+	__GUEST_ASSERT(savic_ctrl_msr_val == exp_msr_val,
+			"SAVIC Control msr unexpected val : 0x%lx, expected : 0x%lx",
+			savic_ctrl_msr_val, exp_msr_val);
+}
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index 24aaa75ec450..518e30275960 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -307,12 +307,27 @@ struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 	return vm;
 }
 
+static bool is_savic_enabled(void)
+{
+	u64 supported_vmsa_features;
+	int kvm_fd = open_kvm_dev_path_or_exit();
+
+	kvm_device_attr_get(kvm_fd, KVM_X86_GRP_SEV,
+			    KVM_X86_SEV_VMSA_FEATURES,
+			    &supported_vmsa_features);
+
+	return supported_vmsa_features & BIT_ULL(SVM_FEAT_SECURE_AVIC);
+}
+
 void vm_sev_launch(struct kvm_vm *vm, uint64_t policy, uint8_t *measurement)
 {
 	if (is_sev_es_vm(vm))
 		ghcb_init(vm);
 
 	if (is_sev_snp_vm(vm)) {
+		if (is_savic_enabled())
+			guest_apic_pages_init(vm);
+
 		vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
 
 		snp_vm_launch_start(vm, policy);
-- 
2.34.1


