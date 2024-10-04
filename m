Return-Path: <linux-kselftest+bounces-19005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D465798FD0E
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 07:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A0C1F22C49
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 05:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB295126BFE;
	Fri,  4 Oct 2024 05:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fkjjHuhz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D302B49641;
	Fri,  4 Oct 2024 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728020050; cv=fail; b=Ir59Pu/6SDOSsS3eW1D/HknN3ZrXTr4sA7TSqskKQy1yiiB6SGQa2Lmc7dgtFgsLZQBAkIsF/apHUi839PNXpnyVzNGK9DQNcWOpnG+4h+xOAkZd/4wIuuiu3bygeFEJRefPSHZVHh6s5Zqe/JofVZZRoP3LjPQu8GqQIEc/5UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728020050; c=relaxed/simple;
	bh=WMFGWVCBHGBpWbFgCoh88dfSM9EKYB05SRTAg12ss6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEvHquXboxxiV+8DKCMPW+ntk1huYZGRBd+0b4Z22Cj3SalKlQS8BYo1hTEVAYeGjSig0r3y0yZBY0CmgobEiq7MrA80ymWULXNkf3MR6PBAGIR62Ukio5fJXODBYuEBj0qa1+8P85GgJtGEdMqRxCuDCEI24nCt2IBMyb2oWHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fkjjHuhz; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yATHFTXPt52UnLqd2wV1KxChbM1Ee98Mco7OA8ra7lbXcfb4RZueIjK385ECoiMgzv6e+g1RKiOS8bvzJzmsMV5Ze/XoPPMnDAfqhqJwWI2IjHnOKIJNCpiuSWHG15u2VuGmQs5uINPmoFXdSoD/j0d9zgbpP6Ae9+wrMSAkWUKZ2i+Yhm0BV/kti0WSu2T+N9t7uianXfIhGy3MqQrJUdFhEe1DXRFbiugKaxyfEQJK3T/zcCtmW5ka5puyZwgIyRcjf1XgEVRCcKjvk1xP9y7w0CVAAj8FJ56DEILIJePGObY1rNgkGJdEgigk2VLddllj5975/RgtwGsXXX7eIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48G6kVzdy45V/GMMuPJxWW4ES58XK0QgrU1F5AATAcw=;
 b=g4+G4bIqvOI50+cm7Jj5EjLdx/UYjjqHCQqaQFoQJQbwQ1MAQf1dZ4luaxCfRqNkWiaJ+v3tntGE0MOXd/cwvWJRVD1Vwjb+mmXxQBAOOn2jeZlFNa/090phANtvW/YoYr4gN2E2Vgnr8yz24+b1KaYf16xs7nah7cxsgctg1f1KZYyS8NcSRLKgz57/b4wF6tMxaYolstlM6Wqtk2ELgn3HquKIwlVVoid0z17Wgu1DeLuWGTp6Gx07Fc07i2WHGsUmM3VcC3GhyFE/frX6ghOsf/yCG55g3Uz5QvOCZSsuKBZIO7O39UOZr8RyH93Wc5wo49qufSfGwhbbTcRLTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48G6kVzdy45V/GMMuPJxWW4ES58XK0QgrU1F5AATAcw=;
 b=fkjjHuhzhmUlUb6kQOQGAJNog3Otjr1nd0BsyWl1m5wl/pU90VtpL4UOqySuAjMiO90m6vlh3WbkB7ZjMzD363ylL3q7Lz6YoCNWS5jj1BD/NQPefGGN1nZj5PHoBZH1LscBMHJPdUy9YUU2WHUN4DWp5HXwR31BQwvdpY04G4M=
Received: from BN8PR04CA0018.namprd04.prod.outlook.com (2603:10b6:408:70::31)
 by SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 05:34:03 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::cc) by BN8PR04CA0018.outlook.office365.com
 (2603:10b6:408:70::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Fri, 4 Oct 2024 05:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 05:34:02 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 00:34:00 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [PATCH v3 2/4] KVM: SVM: Enable Bus lock threshold exit
Date: Fri, 4 Oct 2024 05:33:39 +0000
Message-ID: <20241004053341.5726-3-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5ce7a4-cc5c-4398-c540-08dce4362803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3QeRPqNKrKeFbsJlcRmNMvaXxZ104Tnrs9gvJR76L/MRrOUBGUABg/vgEh9+?=
 =?us-ascii?Q?JwscfF0VUUf8B7K6B+d0PkAl0KHnvGnxjT7fHlLBh69/wRlZSyE18+cWFGcG?=
 =?us-ascii?Q?Lf7gdd5fhSrqUMKLJfyj+aC1CtpB8ygvHP7WcE4tbtTDMik2DeG9iDc68VZI?=
 =?us-ascii?Q?boHjDCv3wGbK6nWpKYDlaHX1GtFqh5ulm0hLuYg55GySwPhbacNIN/nzcFzh?=
 =?us-ascii?Q?wyKu7TgafhuC2MjWPt4eDtOZKVH3ifl6taPbAm77R3iiYaWZJyWws2QqnCMu?=
 =?us-ascii?Q?hT2QEqgmcJjsQX7FEMJm4Z4CJtfEzs/xhR0LYE8D9BSwJf45tLVjCxYW5f0G?=
 =?us-ascii?Q?StorOpkTo/42pRxLE6Rj+15BrEdayhzTDnU1ZJAGwV2d7VvquY9b+diLtGyI?=
 =?us-ascii?Q?nF7s7nixNLzWBrWsecA6MUUuCD7BVXiANUfmcY9AtYR8caX6MF6nA/i9H9vt?=
 =?us-ascii?Q?UxQZaKnkbAnbgKFKe+yx4FrKJCtHH+ipcG2QkifdZ6hHC0o3QBeEY4xusKxP?=
 =?us-ascii?Q?q5WwrN4BK/VTAU0T/d4geSnjSvhgAvpoKTmQhSIOFkJuOcJsjxPZ5ZhB0CBT?=
 =?us-ascii?Q?1QYir1YXTgk6fG3+Uzb/AcAFqF6KRfLs8GFqPCZwH4V1PvV7N7Bbbp4WvOw1?=
 =?us-ascii?Q?ACfCBBYUT03dUl46dc/h3+xzbTSD9bBQzwURRtBrKs466O9qKowTJ6/axnTY?=
 =?us-ascii?Q?4IAFDhk6nesjoQsWW05z6SgD36SvCETM5euoKtVPtKUpm1SOqWGwceKctLgZ?=
 =?us-ascii?Q?whlMZKsZeUS6NjrCT5chuPf2+BX6/OgcglU8fDMGsShw0TvkL5a4QkqwYy8d?=
 =?us-ascii?Q?AdxfD/Jt0iQJecgPjYzdLEiWzhtQxech2xu+qAJZtQQ1KV7Hz+ytBsvFWRZD?=
 =?us-ascii?Q?AaQy722P7JxIAueTWVRpwBJoX1QnxYfzGaDS7dtOqks6efORp0DYvovfNU1/?=
 =?us-ascii?Q?PeMmEPOh1X3Glb0n4gmdLLNiYlhlwkxjeieqHxexPYrsXV8TsLE2o2DTmVd5?=
 =?us-ascii?Q?Psnz4yYOn8aH4+gUEt4Db1TIvvLjIIFDKsUaTyyt2KmopgGNjZDSpM+Eyg1O?=
 =?us-ascii?Q?M6R2mbDaSJJAU7PfY/Vbh9sLCKJW6HtJAMj9IQ5VOd1Xt4q1E7goQmjkcdFV?=
 =?us-ascii?Q?kCJCoUUE5h+W5vYHy1xdc9aRebAUTT00swFi4/I1Lzxs7Hr0V5nRP+dAbR8w?=
 =?us-ascii?Q?QLi8QEjBaXE/UeuTb29H6xwt+IVGD05DGovp6VAc0IbTGr9sMp6nMBzehwnz?=
 =?us-ascii?Q?eCucNc/eSNHLHGSnpsclgKL4l4GbRA3dQ5O1FH+EqihFfoLgVS3TG4DZtkEM?=
 =?us-ascii?Q?0bY8F9JQ35KUNXra7mtoxbNpe8RrBh7ahos5JN0bemQe829Uj3eq02G/qMOM?=
 =?us-ascii?Q?W4IODJQhtAjMFpOdtCNFi8g0GQjF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 05:34:02.9689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5ce7a4-cc5c-4398-c540-08dce4362803
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961

From: Nikunj A Dadhania <nikunj@amd.com>

Virtual machines can exploit bus locks to degrade the performance of
the system. Bus locks can be caused by Non-WB(Write back) and
misaligned locked RMW (Read-modify-Write) instructions and require
systemwide synchronization among all processors which can result into
significant performance penalties.

To address this issue, the Bus Lock Threshold feature is introduced to
provide ability to hypervisor to restrict guests' capability of
initiating mulitple buslocks, thereby preventing system slowdowns.

Support for the buslock threshold is indicated via CPUID function
0x8000000A_EDX[29].

On the processors that support the Bus Lock Threshold feature, the
VMCB provides a Bus Lock Threshold enable bit and an unsigned 16-bit
Bus Lock threshold count.

VMCB intercept bit
VMCB Offset	Bits	Function
14h	        5	Intercept bus lock operations

Bus lock threshold count
VMCB Offset	Bits	Function
120h	        15:0	Bus lock counter

When a VMRUN instruction is executed, the bus lock threshold count is
loaded into an internal count register. Before the processor executes
a bus lock in the guest, it checks the value of this register:

 - If the value is greater than '0', the processor successfully
   executes the bus lock and decrements the count.

 - If the value is '0', the bus lock is not executed, and a #VMEXIT to
   the VMM is taken.

The bus lock threshold #VMEXIT is reported to the VMM with the VMEXIT
code A5h, SVM_EXIT_BUS_LOCK.

This implementation is set up to intercept every guest bus lock. The
initial value of the Bus Lock Threshold counter is '0' in the VMCB, so
the very first bus lock will exit, set the Bus Lock Threshold counter
to '1' (so that the offending instruction can make forward progress)
but then the value is at '0' again so the next bus lock will exit.

The generated SVM_EXIT_BUS_LOCK in kvm will exit to user space by
setting the KVM_RUN_BUS_LOCK flag in vcpu->run->flags, indicating to
the user space that a bus lock has been detected in the guest.

Use the already available KVM capability KVM_CAP_X86_BUS_LOCK_EXIT to
enable the feature. This feature is disabled by default, it can be
enabled explicitly from user space.

More details about the Bus Lock Threshold feature can be found in AMD
APM [1].

[1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
     Vol 2, 15.14.5 Bus Lock Threshold.
     https://bugzilla.kernel.org/attachment.cgi?id=306250

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Co-developed-by: Manali Shukla <manali.shukla@amd.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/svm.h      |  5 ++++-
 arch/x86/include/uapi/asm/svm.h |  2 ++
 arch/x86/kvm/svm/nested.c       | 10 ++++++++++
 arch/x86/kvm/svm/svm.c          | 27 +++++++++++++++++++++++++++
 4 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 2b59b9951c90..d1819c564b1c 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -116,6 +116,7 @@ enum {
 	INTERCEPT_INVPCID,
 	INTERCEPT_MCOMMIT,
 	INTERCEPT_TLBSYNC,
+	INTERCEPT_BUSLOCK,
 };
 
 
@@ -158,7 +159,9 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 	u64 avic_physical_id;	/* Offset 0xf8 */
 	u8 reserved_7[8];
 	u64 vmsa_pa;		/* Used for an SEV-ES guest */
-	u8 reserved_8[720];
+	u8 reserved_8[16];
+	u16 bus_lock_counter;	/* Offset 0x120 */
+	u8 reserved_9[702];
 	/*
 	 * Offset 0x3e0, 32 bytes reserved
 	 * for use by hypervisor/software.
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 1814b413fd57..abf6aed88cee 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -95,6 +95,7 @@
 #define SVM_EXIT_CR14_WRITE_TRAP		0x09e
 #define SVM_EXIT_CR15_WRITE_TRAP		0x09f
 #define SVM_EXIT_INVPCID       0x0a2
+#define SVM_EXIT_BUS_LOCK			0x0a5
 #define SVM_EXIT_NPF           0x400
 #define SVM_EXIT_AVIC_INCOMPLETE_IPI		0x401
 #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS	0x402
@@ -224,6 +225,7 @@
 	{ SVM_EXIT_CR4_WRITE_TRAP,	"write_cr4_trap" }, \
 	{ SVM_EXIT_CR8_WRITE_TRAP,	"write_cr8_trap" }, \
 	{ SVM_EXIT_INVPCID,     "invpcid" }, \
+	{ SVM_EXIT_BUS_LOCK,     "buslock" }, \
 	{ SVM_EXIT_NPF,         "npf" }, \
 	{ SVM_EXIT_AVIC_INCOMPLETE_IPI,		"avic_incomplete_ipi" }, \
 	{ SVM_EXIT_AVIC_UNACCELERATED_ACCESS,   "avic_unaccelerated_access" }, \
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index d5314cb7dff4..ca1c42201894 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -669,6 +669,11 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	vmcb02->control.iopm_base_pa = vmcb01->control.iopm_base_pa;
 	vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
 
+	/*
+	 * The bus lock threshold count should keep running across nested
+	 * transitions. Copy the buslock threshold count from vmcb01 to vmcb02.
+	 */
+	vmcb02->control.bus_lock_counter = vmcb01->control.bus_lock_counter;
 	/* Done at vmrun: asid.  */
 
 	/* Also overwritten later if necessary.  */
@@ -1035,6 +1040,11 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 
 	}
 
+	/*
+	 * The bus lock threshold count should keep running across nested
+	 * transitions. Copy the buslock threshold count from vmcb02 to vmcb01.
+	 */
+	vmcb01->control.bus_lock_counter = vmcb02->control.bus_lock_counter;
 	nested_svm_copy_common_state(svm->nested.vmcb02.ptr, svm->vmcb01.ptr);
 
 	svm_switch_vmcb(svm, &svm->vmcb01);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 9df3e1e5ae81..0d0407f1ee6a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1372,6 +1372,9 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 		svm->vmcb->control.int_ctl |= V_GIF_ENABLE_MASK;
 	}
 
+	if (vcpu->kvm->arch.bus_lock_detection_enabled)
+		svm_set_intercept(svm, INTERCEPT_BUSLOCK);
+
 	if (sev_guest(vcpu->kvm))
 		sev_init_vmcb(svm);
 
@@ -3286,6 +3289,24 @@ static int invpcid_interception(struct kvm_vcpu *vcpu)
 	return kvm_handle_invpcid(vcpu, type, gva);
 }
 
+static int bus_lock_exit(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
+	vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
+
+	/*
+	 * Reload the counter with value greater than '0'.
+	 * The bus lock exit on SVM happens with RIP pointing to the guilty
+	 * instruction. So, reloading the value of bus_lock_counter to '0'
+	 * results into generating continuous bus lock exits.
+	 */
+	svm->vmcb->control.bus_lock_counter = 1;
+
+	return 0;
+}
+
 static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[SVM_EXIT_READ_CR0]			= cr_interception,
 	[SVM_EXIT_READ_CR3]			= cr_interception,
@@ -3353,6 +3374,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[SVM_EXIT_CR4_WRITE_TRAP]		= cr_trap,
 	[SVM_EXIT_CR8_WRITE_TRAP]		= cr_trap,
 	[SVM_EXIT_INVPCID]                      = invpcid_interception,
+	[SVM_EXIT_BUS_LOCK]			= bus_lock_exit,
 	[SVM_EXIT_NPF]				= npf_interception,
 	[SVM_EXIT_RSM]                          = rsm_interception,
 	[SVM_EXIT_AVIC_INCOMPLETE_IPI]		= avic_incomplete_ipi_interception,
@@ -5227,6 +5249,11 @@ static __init void svm_set_cpu_caps(void)
 		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
 	}
 
+	if (cpu_feature_enabled(X86_FEATURE_BUS_LOCK_THRESHOLD)) {
+		pr_info("Bus Lock Threashold supported\n");
+		kvm_caps.has_bus_lock_exit = true;
+	}
+
 	/* CPUID 0x80000008 */
 	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
 	    boot_cpu_has(X86_FEATURE_AMD_SSBD))
-- 
2.34.1


