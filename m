Return-Path: <linux-kselftest+bounces-13397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D3092C2D2
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 19:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7DF1F23389
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EE017B057;
	Tue,  9 Jul 2024 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1wIx0q49"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89831494C8;
	Tue,  9 Jul 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720547536; cv=fail; b=YODIhFl/dMOCGW9kmGlfYcpK7GGFivrTFffEuTo1pnVK9CZuQDhuQCBgw7KqwWqePa1BzihrJ+Xp6hpMvKqh8AR0TCKaeq9wBuSn/daZyIOI11bi6/XwXM8yrVXAlkZcTAOia/6U3ooFSIFY9uFaQ4BYN0luU8D/L1Pz7Fb/hNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720547536; c=relaxed/simple;
	bh=0bzjK2P1gQMuTkCSglANTx19JtGZrdZ0HZcnmCrwGMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsYC8EZnyyKF2guhOJCaZierjY6tZOigOCmoU8JABZ+H49sg5s7aEZdEHJGqD7P5Dt6/GjhioaRp5hn9HUwKWo4K1bOTpBHzWgDjVYAzUf7iieKfCAW56l1unLvmrQ7t0ZXPIsKxi7Bi0VdQNyv2GV9CoefeLywBiQ35petVhlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1wIx0q49; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRIMaFpeXdlVBHvs00UsmJ1hQl8i1+yCKLwNPvwZto8IGzZom5otF+iKfCILovGWicsown+U58FPcqjoASRIKHcbDc/0ddlFbNQX2ZifaufV/naXck5QUeIJlalHd1picBKwcJg8az1Cr2fbyvHo8puXBQKAGS/7P+nnjGt88SmLR4pIkO9Ly6a4Sx7tu7LcUG4HaUCGM/zxpNaSsB4jewzFwvnYRXlkk3t2KtOjK5oLhPKyadSQLknDvEYvymrJM4rD9lz0V/ay6+rp/h8CV/7pfJFc2Y9uFExbp0p9h0pVZD7Mr10bW95fc58fr3tF/ucwW+nZ6An7EP/K396TLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAJMtIZjyaMxoDQn8SckoHelyBuWTZrvkaF80D7mDLE=;
 b=PBo7Lm2rUBHCunoJWNFHJ4m+TQB3jLrePuRcJh+dfdfSzDZ+6Sn51Eefi6yPZzENRalqIvFFcbq37IHg2D2U2gyi9UIZVG3mejEs9uWzHjok6csuuItDGwL8St1EpC3EVzWPZCr2tFnwkug5WtGvWfRErfQv0Na1BD/46JdJ6Sy10LgqvPvdYNkuLLGgba6GwZkax0ZvAuh4QsU6yYH/JZzrxarOUStY1EfyTQatmAt+5yV/WCRKHhJKOpdzmblrtWkoRn+vJmMxAM2skwz7oZuB2oYYezvx/pwEJ9wiG4B0uGG16qhXLGzVpvtiAzYBwm/WCrf5GMQIJngeqiTpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAJMtIZjyaMxoDQn8SckoHelyBuWTZrvkaF80D7mDLE=;
 b=1wIx0q49dBxmOAyZF7Y7QYHqPHO1unTW1Q5VxtWvWvqJxbwCKP2jwLHtYCmiPjUf0ETsDxyHzu1F65V4dNSi4rnddpipsN8dU6rM1kGND/7XI0LAqgHq5Ld3oHHhR14PfJ7gythNRqJ5G5S48LUP4NtGmrFsY7eyw5rM0VxMXmg=
Received: from DM6PR10CA0026.namprd10.prod.outlook.com (2603:10b6:5:60::39) by
 CYYPR12MB8939.namprd12.prod.outlook.com (2603:10b6:930:b8::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.36; Tue, 9 Jul 2024 17:52:12 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::93) by DM6PR10CA0026.outlook.office365.com
 (2603:10b6:5:60::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Tue, 9 Jul 2024 17:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 17:52:11 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 12:52:09 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [RFC PATCH v1 2/4] KVM: SVM: Enable Bus lock threshold exit
Date: Tue, 9 Jul 2024 17:51:43 +0000
Message-ID: <20240709175145.9986-3-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|CYYPR12MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0822d4-84cf-46ce-6d05-08dca03fdc6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8rSrg4kTi7Ar3yfCdOz7GLS8RqkTPBAqo8sZZyLkhMVxyv++egj4Nz0lnHQq?=
 =?us-ascii?Q?pUgjAgGntXi5257xBvvZtC5KDc7pi8PG7izjrLO2E7q9tDyphzCFkTJR2W9G?=
 =?us-ascii?Q?DIIcReWEEvkcN52dUyoOvESV4wgKfGpicinKTSchLM3EJI/LXhtNM21Mvhv8?=
 =?us-ascii?Q?Cg3FqHou9V+ne9iDrJhjLtVU1sKbZaEu9Fe260pw43UFrerTzudm74SQ5+wU?=
 =?us-ascii?Q?3L/q2h77OSczy3GwPhOPiYO4fXLvYUzx14ob+Gj7NBolHMNl30i9Ev5FzqkZ?=
 =?us-ascii?Q?0HOfRqziaI8xI+Nt58XG4UeS9hnKhPy9hlYKR50yod+sjbDy6KZdjDJicN4V?=
 =?us-ascii?Q?Eg/wxOIdHHQj9fv/2Nejg1c95mc9awEglNjNtuOHUHXUKxDF6axBt/8mIZzw?=
 =?us-ascii?Q?gQZ6iVETgduBKQiY8gSKh4laBz1kYAickduTX86rv0vjfGdXSc7xKsDSYhXA?=
 =?us-ascii?Q?RkmqF/Ib44IVGnuQJo3uLQktEbWE05MihKFiKIrR/Yb9hnmOuXpabZbQL9Fc?=
 =?us-ascii?Q?zSaHuBzA8lkc8V1NPHqK5GtHH7+ffKpwrzayVKF0kXxSUEQ/vClPQceMbcse?=
 =?us-ascii?Q?jaV8aWRI7pA0sJmngf9ldU1uZnwTmaSyfy3Sh1VQ4UZeA28rxV/bCQ1H2Y/K?=
 =?us-ascii?Q?SPIVVSobO5JIH+tfH5uStkuf9QewLolhiUSLhwnIxRMbZgd2GZBtOiC7Hds4?=
 =?us-ascii?Q?brXlP1c330b/LCQwpDN1RRQViKLxnkDbjw1T6kCGTaRObyQEwuetHGAm75ob?=
 =?us-ascii?Q?Y2JIbvIAFXo6EYp218rAr44uR7B5GPOmvOM9wERBOtc416V+tVlkm+Y2Zr6o?=
 =?us-ascii?Q?xpNqAZEXQPhbEe3k1/MgXBx5OKcpnWnri4qBytpwKcYqdIJX3r404njOGUQs?=
 =?us-ascii?Q?SBgo2go6AASHRs4jO+ojb6H3bRcoGi8li0XxhvwTPhGYx81/VSYpvvL3NIac?=
 =?us-ascii?Q?mkWAP6lOBLhUfJYNVqJfrG9YC9n0UY510E9JkJVxP4d6HwX1ytQ+YG7+i/Ry?=
 =?us-ascii?Q?dqrJchLK2dkHpgOUC2YNhvB4/CNWMuxOUG8y9Fgju8dWiFdrWviwdYlKJayh?=
 =?us-ascii?Q?ckbuP2KNz0+/jYqb8BnxUj3EGqFK5yLwJBHuHBLUp5HWOu7F064chquZ4vH+?=
 =?us-ascii?Q?ymx5hf+LYlgxGkPSqw3+3cOzkDhQRn1M7K3wCjY7bQwSZfHtz6tS1vCCM9eh?=
 =?us-ascii?Q?nvS6Y581chVoq6JM6UZGp87km11gX25mSn67W4QjSpw+zEOAwBljX3S3jF5m?=
 =?us-ascii?Q?V628aG8wDVriXLPoLcPL4rGfHlaXDN4APaxXQBX2UUH/VpmBHjCm7O2tDuXY?=
 =?us-ascii?Q?Ue4VrMf1f6NMNGpgLjy72XSqEKZPW9zcja6gcTfBjXaF2/4q0+QMGEj9ITlP?=
 =?us-ascii?Q?GnDyi6ByY1RSVUVJMqC3uYfBNG59?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 17:52:11.8407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0822d4-84cf-46ce-6d05-08dca03fdc6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8939

From: Nikunj A Dadhania <nikunj@amd.com>

Malicious guests can cause bus locks to degrade the performance of
system. Non-WB(write-back) and misaligned locked RMW(read-modify-write)
instructions are referred to as "bus locks" and require system wide
synchronization among all processors to guarantee atomicity.  Bus locks
may incur significant performance penalties for all processors in the
system.

The Bus Lock Threshold feature proves beneficial for hypervisors seeking
to restrict guests' ability to initiate numerous bus locks, thereby
preventing system slowdowns that affect all tenants.

Support for the buslock threshold is indicated via CPUID function
0x8000000A_EDX[29].

VMCB intercept bit
VMCB Offset	Bits	Function
14h	        5	Intercept bus lock operations
                        (occurs after guest instruction finishes)

Bus lock threshold
VMCB Offset	Bits	Function
120h	        15:0	Bus lock counter

Use the KVM capability KVM_CAP_X86_BUS_LOCK_EXIT to enable the feature.

When the bus lock threshold counter reaches to zero, KVM will exit to
user space by setting KVM_RUN_BUS_LOCK in vcpu->run->flags in
bus_lock_exit handler, indicating that a bus lock has been detected in
the guest.

More details about the Bus Lock Threshold feature can be found in AMD
APM [1].

[1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
     Vol 2, 15.14.5 Bus Lock Threshold.
     https://bugzilla.kernel.org/attachment.cgi?id=306250

[Manali:
  - Added exit reason string for SVM_EXIT_BUS_LOCK.
  - Moved enablement and disablement of bus lock intercept support.
    to svm_vcpu_after_set_cpuid().
  - Massage commit message.
  - misc cleanups.
]

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Co-developed-by: Manali Shukla <manali.shukla@amd.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/svm.h      |  5 +++-
 arch/x86/include/uapi/asm/svm.h |  2 ++
 arch/x86/kvm/svm/svm.c          | 43 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.h              |  1 +
 4 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 728c98175b9c..538b7d60b05c 100644
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
index 80e1df482337..dcce3ca367e9 100644
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
@@ -223,6 +224,7 @@
 	{ SVM_EXIT_CR4_WRITE_TRAP,	"write_cr4_trap" }, \
 	{ SVM_EXIT_CR8_WRITE_TRAP,	"write_cr8_trap" }, \
 	{ SVM_EXIT_INVPCID,     "invpcid" }, \
+	{ SVM_EXIT_BUS_LOCK,     "buslock" }, \
 	{ SVM_EXIT_NPF,         "npf" }, \
 	{ SVM_EXIT_AVIC_INCOMPLETE_IPI,		"avic_incomplete_ipi" }, \
 	{ SVM_EXIT_AVIC_UNACCELERATED_ACCESS,   "avic_unaccelerated_access" }, \
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7d396f5fa010..9f1d51384eac 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -191,6 +191,9 @@ module_param(pause_filter_count_shrink, ushort, 0444);
 static unsigned short pause_filter_count_max = KVM_SVM_DEFAULT_PLE_WINDOW_MAX;
 module_param(pause_filter_count_max, ushort, 0444);
 
+static unsigned short bus_lock_counter = KVM_SVM_DEFAULT_BUS_LOCK_COUNTER;
+module_param(bus_lock_counter, ushort, 0644);
+
 /*
  * Use nested page tables by default.  Note, NPT may get forced off by
  * svm_hardware_setup() if it's unsupported by hardware or the host kernel.
@@ -3231,6 +3234,19 @@ static int invpcid_interception(struct kvm_vcpu *vcpu)
 	return kvm_handle_invpcid(vcpu, type, gva);
 }
 
+static int bus_lock_exit(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
+	vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
+
+	/* Reload the counter again */
+	svm->vmcb->control.bus_lock_counter = bus_lock_counter;
+
+	return 0;
+}
+
 static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[SVM_EXIT_READ_CR0]			= cr_interception,
 	[SVM_EXIT_READ_CR3]			= cr_interception,
@@ -3298,6 +3314,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[SVM_EXIT_CR4_WRITE_TRAP]		= cr_trap,
 	[SVM_EXIT_CR8_WRITE_TRAP]		= cr_trap,
 	[SVM_EXIT_INVPCID]                      = invpcid_interception,
+	[SVM_EXIT_BUS_LOCK]			= bus_lock_exit,
 	[SVM_EXIT_NPF]				= npf_interception,
 	[SVM_EXIT_RSM]                          = rsm_interception,
 	[SVM_EXIT_AVIC_INCOMPLETE_IPI]		= avic_incomplete_ipi_interception,
@@ -4356,6 +4373,27 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_FLUSH_CMD, 0,
 				     !!guest_cpuid_has(vcpu, X86_FEATURE_FLUSH_L1D));
 
+	if (cpu_feature_enabled(X86_FEATURE_BUS_LOCK_THRESHOLD) &&
+	    vcpu->kvm->arch.bus_lock_detection_enabled) {
+		svm_set_intercept(svm, INTERCEPT_BUSLOCK);
+
+		/*
+		 * The CPU decrements the bus lock counter every time a bus lock
+		 * is detected. Once the counter reaches zero a VMEXIT_BUSLOCK
+		 * is generated. A value of zero for bus lock counter means a
+		 * VMEXIT_BUSLOCK at every bus lock detection.
+		 *
+		 * Currently, default value for bus_lock_counter is set to 10.
+		 * So, the VMEXIT_BUSLOCK is generated after every 10 bus locks
+		 * detected.
+		 */
+		svm->vmcb->control.bus_lock_counter = bus_lock_counter;
+		pr_debug("Setting buslock counter to %u\n", bus_lock_counter);
+	} else {
+		svm_clr_intercept(svm, INTERCEPT_BUSLOCK);
+		svm->vmcb->control.bus_lock_counter = 0;
+	}
+
 	if (sev_guest(vcpu->kvm))
 		sev_vcpu_after_set_cpuid(svm);
 
@@ -5149,6 +5187,11 @@ static __init void svm_set_cpu_caps(void)
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
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index d80a4c6b5a38..2a77232105da 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -58,6 +58,7 @@ void kvm_spurious_fault(void);
 #define KVM_VMX_DEFAULT_PLE_WINDOW_MAX	UINT_MAX
 #define KVM_SVM_DEFAULT_PLE_WINDOW_MAX	USHRT_MAX
 #define KVM_SVM_DEFAULT_PLE_WINDOW	3000
+#define KVM_SVM_DEFAULT_BUS_LOCK_COUNTER	10
 
 static inline unsigned int __grow_ple_window(unsigned int val,
 		unsigned int base, unsigned int modifier, unsigned int max)
-- 
2.34.1


