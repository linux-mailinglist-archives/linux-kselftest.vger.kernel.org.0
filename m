Return-Path: <linux-kselftest+bounces-42115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FE4B945BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E503A70E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B1C30FF32;
	Tue, 23 Sep 2025 05:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wI1Xda/N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013060.outbound.protection.outlook.com [40.107.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5620630FF25;
	Tue, 23 Sep 2025 05:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604630; cv=fail; b=dIKibL7Q+lzpa7G1SV95LBZQI26veZ3gv+8OtivNRtrfzB6Gll5GjcuxhvnU/3LZiCvUvAjs3/SUIIqmGjDg2/8CV64WpIcXjhIQxtceaV+mtUqK+WHWUGbs3vRs8pnDqWHklbnUaA2MWYV5O00nk1JAJhqia5BJbm9z3MZ8HV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604630; c=relaxed/simple;
	bh=ZsQyO58cr8x5vJqgp640jL5MzyqYxXiFHAb4JgD5CL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2SOOtfZGG6U1wmKHDFhKEC6W/5yngqhsFQEYzfGs57BQDP4eFEdsrANorpf8HnzNHDimh7toB2qwps2P3fZjdoJ7uyyT6UkmJQys6XxcfYj5A8t9YknrcL8NTbCb+baB8GObXSdLcAs1XfmnIY7SEcqK5nqIb9JvxqKI796710=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wI1Xda/N; arc=fail smtp.client-ip=40.107.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yo99bRxGlIDHwDJJlUctYUKwUeBGjrSumPxupOfZbdiQjg7+v/eOnRr2F/k4VepuNyWUczK144dVazC+XkE0BEz7jyyzhq4OxQ9s8dg4zWAk+mV97rgNPGrL6xZzxLy7oUHTh8mFVuwMfVZx+hECIfdFl562ynlB8PqIeoKERhZ0RZCJ9GE5NK6AQ7EMznvOCOlZb8kDKc8ANAjQFUeyJ4BB8RV3ufthvJfaadkq6yj8OkUcAAEvqatWRoEv94l90q4jBZ1EBuOxsXVs0a0b61rpqrP0k7gjoV1P6fk0McPmH/4n1lJPp1jT5qKvI8A3ZVeLRzhEphXq2z1OnAFVWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TemSTNfe7Rc/LQx223hKXeWmU2u9uTIFRInWqTTJJto=;
 b=AcU7VOtDXSJTexxsUbQyJqg8s2aQ1XY3ban+FmDFss6y5F8M1XEEoz3c4MAw6JL/ZGTcvD6/V81Drn9f/VAkdhhlYk3rkyWNIBdHPaeDrzcwh/iiDKpd55YM7Ev3AbfCITXs5JxY3ftP5Bm9vEr8dYPql5FIHRec7B95zOPdRdkATfslYLi0m4s2w9EfG91NJ+1ble14Kp4WxiGtPMgnICExk3g6/Nwc5ScVbQyLmxtHTMhk0q5kmr8q4gPFohbEnY2wPtus0Lzolm11+wyhK0qpk3DmxqgDZ1uZ8n7C9z+nEyIDGyEovczgnunEc78qi8QOFbGkPMNWTXMnw2z7DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TemSTNfe7Rc/LQx223hKXeWmU2u9uTIFRInWqTTJJto=;
 b=wI1Xda/NOJmMRQfcTdnLKLzEqkTHwdP1S1pFA1536Hudmg6v8agkk+hmHRQ6mPE26rvCcaXncfujtMmVQ4DZosI0Bouu5vLoSY8UUsUGShYaIJ22RU4EbjiLaMyUajHzms1PQS4Z+piFVogQl9B2JWoA35LeFQuELaBMNkHp7jo=
Received: from CH2PR15CA0027.namprd15.prod.outlook.com (2603:10b6:610:51::37)
 by CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Tue, 23 Sep
 2025 05:17:02 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::76) by CH2PR15CA0027.outlook.office365.com
 (2603:10b6:610:51::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:17:01 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:16:56 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 24/35] KVM: selftests: Add Secure AVIC library
Date: Tue, 23 Sep 2025 10:39:31 +0530
Message-ID: <20250923050942.206116-25-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|CY8PR12MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 76947992-e2cf-4d6f-0372-08ddfa606d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bfMXATGx7H6VtnPpqZrmBnzdjVGfKfmFuFDGb9+DFhN4EShlVKWtAjLl1HwD?=
 =?us-ascii?Q?xVUZjCJzjw4BvspQCndseTT3nBfyMXJau0RRsBevoXrxY6seeKegE1GqQ2n2?=
 =?us-ascii?Q?XPpZRMxtW2CFRq/UPvl71NgwfUhHzfQOtVm2wmdvaAO5oEmRZIGZJOnKcDg0?=
 =?us-ascii?Q?lLCHeG9QygrnGcRFfBx1wLI32RFYTGIw5hBO2gmpXG8okdkXG26m0UcZnuNh?=
 =?us-ascii?Q?7fFfqQEXFPQu/vjfVLbc4sZEP0eysPHMBqc8vJAc9kie89u8I+ngGyRIIzel?=
 =?us-ascii?Q?Ucro4G3x7MWUBFH7L6N+TbLVG3MWD8uRRQfGBcwhTXr9TxVTUpZdFe4BNTrA?=
 =?us-ascii?Q?2PzJsMrqchD501crYB4KK1XAFoxPH3j0POacMBuNPClNJyxivvbOft/mfMgh?=
 =?us-ascii?Q?SlN1FtPYHMDlWZadALRPkQ6DNJhPAU0kJOXmwbnyFVHGTFo5tCxeBXLpCpjZ?=
 =?us-ascii?Q?noduxbHZ0kvXVU5xFlnmgbVihiLfpobUnb/zOmRPGoUN7tft3D/r4P2Ufr1R?=
 =?us-ascii?Q?j/Gvj/3tfXptoHArVuFY5YsModD0Brt59liy0nURFQByiBjX0dYkrTKnjOir?=
 =?us-ascii?Q?xvDVNO8k3MHhp/CRn2TFgoPlI+kIw7KwC6yb5WrGAgB0541IsNL1clIBIisW?=
 =?us-ascii?Q?0iHCaQdA2J/WeJ3X2Cod/EbqjtOPpCRmwoZrFMWa6F9ZYIzYodbbed7azgtJ?=
 =?us-ascii?Q?ePsjB4mDzRx921a4/m+i7zURB5ySxu+2n+RvFFNr/8Yi3dHVEsk7srEPP4I/?=
 =?us-ascii?Q?ZrpJtD+7A7HmZ+8Cju5lukEB9Ra8fYb1jkWzZxtx4IuuXbfN9lbFPby3wbna?=
 =?us-ascii?Q?CFH9Tp0jSblreCL3kSxxOVK7N8q8eVp92H9F/7jlhFfE7TKLipzaIxJqrL0g?=
 =?us-ascii?Q?yOf2DkivCCuC3mRHCk2cmwuhXrJygTaKeX1mo4g+6Bb2mjjygiLHdNOlkL82?=
 =?us-ascii?Q?bHZ7ib9mUvATtxDp8LmE+UVf0rZ9kITCbquXuR3cWDbGg2s0DWq9uYDwdYNZ?=
 =?us-ascii?Q?BYrfL5H78PePcyjZVgL7/FKX3D4lFHckxIE3sCdsorc4uQkslxYcP5H39jGZ?=
 =?us-ascii?Q?jcpCGl7LwPPTh53/3Z24Zdbufmwu+Nc6W5vSNoKQjyVMIbkzlJ9b9LmtJLiW?=
 =?us-ascii?Q?tAkFc+LjK6VQTMOZ8L/DuXiQDy4SqoogKCM8c/OeDBI5IDlvKSRWklcWMjmv?=
 =?us-ascii?Q?dhOl8RDjK+KdJi4A0Jvl7wil0qtA4L3x1XvCNCeYsD2+beu7V+VPnvcSaqv8?=
 =?us-ascii?Q?z7Vpl9vDWJBJTBKz6my/VJmA1+DhbKNkdDrg0BNroMQa1CeP3jfjv8DSqB+F?=
 =?us-ascii?Q?otFpyQf/C2xyi8QjXXYoS4NPSgNIPHYlZ1MZVwyCiMna71zX3hUtj51BF8sa?=
 =?us-ascii?Q?bdcgTEkzKWJK28Cha3Yy8Y7klqwTPkS/gLgB8xf6nanJK1BSZDCSFtg1V/Y7?=
 =?us-ascii?Q?Fweo/05WPTbdmrVyMmOjGmD8SYLPrmfdQPqeMHureGWkePadQkJrSuOVjfiE?=
 =?us-ascii?Q?iHOvD86FlODfzsfAmUkKTJWW5sKDcFzrGlnb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:17:01.8274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76947992-e2cf-4d6f-0372-08ddfa606d96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634

Add a new library to the KVM selftest framework to manage and enable
Secure AVIC, providing the foundation for testing this feature.

Secure AVIC (SAVIC) is an AMD SEV-SNP feature that provides each vCPU
with a guest-owned APIC backing page in memory. This allow SEV-SNP guests
to prevent the hypervisor from generating unexpected interrupts to a
vCPU or otherwise violate architectural assumptions around APIC behavior.

The core of the new library (lib/x86/savic.c) revolves around the
management of these APIC backing pages:

- Allocate pool of APIC backing pages during the SNP VM launch sequence
  if the VMSA features report SAVIC support.
- Update kvm_arch_vm_additional_pages_required() helper to ensure
  sufficient memory is pre-allocated for these pages during VM creation.

The library exposes a set of helpers for guest code:

- savic_enable(): The primary function for a vCPU to switch into Secure
  AVIC mode.

- savic_read/write_reg(): Allow the guest to interact with its local
  APIC state via the backing page once SAVIC is active.

- savic_hv_read/write_reg(): Helpers that wrap the PV MSR interface for
  communicating with KVM's view of the APIC state.

This infrastructure is a prerequisite for writing selftests that verify
the correctness of Secure AVIC.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/include/x86/apic.h  |   6 +
 .../testing/selftests/kvm/include/x86/savic.h |  19 ++
 tools/testing/selftests/kvm/include/x86/svm.h |   3 +
 .../testing/selftests/kvm/lib/x86/processor.c |   7 +-
 tools/testing/selftests/kvm/lib/x86/savic.c   | 205 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/x86/sev.c     |  15 ++
 7 files changed, 254 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86/savic.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86/savic.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 41aa99e5e0c4..b94ac1caa514 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -26,6 +26,7 @@ LIBKVM_x86 += lib/x86/insn-eval.c
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
index 181f1943c4be..a33a09a161d3 100644
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
index 000000000000..72ad43d4797e
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/savic.c
@@ -0,0 +1,205 @@
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
+
+struct apic_page {
+	u8 apic_regs[PAGE_SIZE];
+} __packed;
+
+struct guest_apic_page {
+	struct apic_page apic_page;
+	uint64_t gpa;
+	uint64_t hva;
+} __aligned(PAGE_SIZE);
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
index 1e0719dfd6b0..113f33ca40b2 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -276,6 +276,18 @@ struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
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
@@ -284,6 +296,9 @@ void vm_sev_launch(struct kvm_vm *vm, uint64_t policy, uint8_t *measurement)
 	if (is_sev_snp_vm(vm)) {
 		vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, BIT(KVM_HC_MAP_GPA_RANGE));
 
+		if (is_savic_enabled())
+			guest_apic_pages_init(vm);
+
 		snp_vm_launch_start(vm, policy);
 
 		snp_vm_launch_update(vm);
-- 
2.34.1


