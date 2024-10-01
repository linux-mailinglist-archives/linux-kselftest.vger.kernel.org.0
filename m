Return-Path: <linux-kselftest+bounces-18720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A69C298B484
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 08:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A77282CDC
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 06:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A741BCA0E;
	Tue,  1 Oct 2024 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o9m437G6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB8E1BC062;
	Tue,  1 Oct 2024 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764480; cv=fail; b=uFC/S8KsTS6T6ASewKkl9vGQm4Cle5tuVfm9rfTCl6pz6jc5Oq5jxEkeBGnEt55xzDFyRqGyfGWh3+4SwE3AE+Utuor9bXkWvxB56hRP2HiNZqgZ9GS5Vx5s1h3DEv6Te/eFDwTUMnq/SKY8Gljc9+wqyJ7OA3CuWoCII9vdkmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764480; c=relaxed/simple;
	bh=51eVIjZ6U4T8+hdsbo3YZ86O0EeOyqK1kEvscyKllac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDP80wWUEZXUrD//uGilyziX5VqEb+d7+qrqMBYCfUIbgmKbySzsSyPn0avdldWIX8uBJPO5j/mmqhk10+b4IJrlGyFbiF+V7XOeTy0fZlDdQDIjHoYkEb500ZrJiFk7TLKBKrB6NnfeoOC2GfT5HdJciTVDGBBUV5mxochXdzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o9m437G6; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1kv1cdkaxMvJT0/KchDYEoI1tiETbnG+5NCZsZFkbZvAUN7t6GJum7XKtPpLa+OOS1BA4dp630I9wpHhF4nOFAu9pjcgcQUBLA+gIEvM3wtJaf6coIezVOpgqyINeYa4x1cROLzQDZ9FFxMhFKGewibAnjiJqTt8OWFdms0BrxugSoRCnYr3k0gCmxKarBynRBJtSR1JbZD/YPDILlQMUceQbQftTqVZQXD7QvVakVjzCVLwtjsB+v/qH+f+PPeeFDiA+qk1kBu2m+sRrYfBdfknTToHn8ILQfm36ddtYrFfcsaK+g06HnzWRxefXotp3jw2w1ByKDbyzRjyeAINQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zopjtBaXTboCoPoC/xMJCWHVyuSxfna49JW/FOUPmtU=;
 b=Mbq+Zt0FhNuGMn2DxtjF28w67VG1lUnUS/h9cvvERkLKl3ciAPS0ouNNuQRWnrCSJiO9pKwmNTfOuE/bWAKpt0pqDECr0oXR7Kn3+eYNenkkqJkhEFaB3dqVteDBlmjLrFI8njauZ6/DG/Bs2KYR7fBnNZwx0T0xH6FJAMjOOFu7MFujTYD2Ulcjf12bFU9MtbuvMbv72oTZs9cXEVtnuFB2GbWKhS2DbWUYLdsIhuwHkQAKrb4axBbkTCFMDwHmI6HyzHraOjHP826SJLjbGmhpQx7DhGU3nSn+btEBEkFlHjoBPjRNRFEicjOaipir9Ry28oncc9Y+kayiCKj3Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zopjtBaXTboCoPoC/xMJCWHVyuSxfna49JW/FOUPmtU=;
 b=o9m437G6U7kQVFD6TJSPGKHKvlfWlX/eST6169e6IqFo+BzR/GFAEUhsGXxhffXw9UMcYo/d+wfooJqXeSU+Ge822FjVlw8f+9qqoWxb6Ek8KZfGHJMwr/PWXtQXuPNwsGBEH7Bfn3+RNu2EyVlzc7/ZQV1pO5Fd714mdnAINpI=
Received: from SN6PR04CA0101.namprd04.prod.outlook.com (2603:10b6:805:f2::42)
 by DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 06:34:34 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:f2:cafe::88) by SN6PR04CA0101.outlook.office365.com
 (2603:10b6:805:f2::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 06:34:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 06:34:33 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 01:34:32 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [RFC PATCH v2 3/5] KVM: SVM: Enable Bus lock threshold exit
Date: Tue, 1 Oct 2024 06:34:11 +0000
Message-ID: <20241001063413.687787-4-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: 3415e48e-4b55-4d06-7a28-08dce1e31d02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z7HlOGQQesLDr5YW6fOFv4otVk6o1Op9Gvl1u8k/vSHLXlsz3K0SevSUVyfb?=
 =?us-ascii?Q?/xkzlDnVCHT9bcHLLbYDp+BzcF+Y2WRVn3NImoaCuVHE5iU5+B8HeQFYnxX1?=
 =?us-ascii?Q?fmpQ4TW/GB/I6kxM5Sm1hbegx7bACIDjOL90VWDXTzW3sf0PEx+tXSIn3Nl7?=
 =?us-ascii?Q?Sy65cx8pC9F+pfMzhXNLdCzfIJ5okJjcZ4U2G1qVjfwKDop2hdjlTYaLbFrQ?=
 =?us-ascii?Q?53guwHQKGC8mkxR2F0fSU8uGvq/xeDxhbpV/p1+7dwy20zrg4vqDIISJJkgc?=
 =?us-ascii?Q?bPBgZnNe4mfbh/SIXpuurwYGspAvuXukQdpueqBb1e0g1tzV6CYUexy/E3d8?=
 =?us-ascii?Q?XHT100I/ys7WuowuuvIHjimXTkd57/+yZCcaYG/urdTdMf0K5o2t0cSziW98?=
 =?us-ascii?Q?fKPIUaNtiYt+4fPEaO7f/9aKOydd0gfNS+Mx4BxAQ30XlQNS6gIudCJZhyv3?=
 =?us-ascii?Q?9ientT/q2NM+zs467mwQ6vRCVEMFkiZ90qmoTQyguv0xRhF5+ebiTDqAOVK9?=
 =?us-ascii?Q?RJ/pMAEL5DjpDPjIyGrlsSiw2iXHPCaIE6Kg/7brB1o61uIWnDnEJBNht0Pv?=
 =?us-ascii?Q?h/ys/KAEJ8jElJ+xeGD9AKSi0XEjQQT2Eet1TlHK4khIdE5kHSMnRt8lC0bV?=
 =?us-ascii?Q?4TE3HYjEAFKGGCyhDspjZyr831USmJMVTlNVsx1I4bFGNLpp+IADB3O/Z1DL?=
 =?us-ascii?Q?kZ9zgIh/Jvk8Czw14mqSqHeaiYirXYYLjJln6XRUjLOnqzD4HjOMqqwk3iq2?=
 =?us-ascii?Q?Jq4lKgeuq8jWKuw4iBu5luDtWh8uS+dB3qPpEIThqx/VWhyUhIha5t3/DQmG?=
 =?us-ascii?Q?16KHFf82HNcNWRPM9zAo8fLr/uKixxf7nlD1v1pIAu0IpnM+tFH55UBPEGyy?=
 =?us-ascii?Q?mcUfmQOZGmRS3UCkhpLx8fq+izvdlUPbcF5KsPFqgWbB5Q+9DnDPyKefDg8L?=
 =?us-ascii?Q?spWTw9ioL+esqNfLutv82SXr+G0ZGu3eLg4Gwfk7aY1uK/ZffrwUUanjuZY0?=
 =?us-ascii?Q?u9QxsH8hT6jU1mQ0TYzaJLAsdxjBF7MoKu8vOpmf4xnxtPkl8y3UD0UNh06/?=
 =?us-ascii?Q?lFocmd8dOYdqJOKpuCMaQTgdC9MGh/E4bWt5ohTnxb2RAKEhxrDHSzFW2/cC?=
 =?us-ascii?Q?W0wQ4Wx+iOP7qIjWJ7JzepuRPDF0Onqhc61PPECXX88MZaEOwSP1qZqzBhXe?=
 =?us-ascii?Q?CFNpkfbdqVp63kxjr8Q4slxQlhQxNKurhj8rDcJyNw76+ZKbWnrVxpTIdxQG?=
 =?us-ascii?Q?lsNdUHLTV9aJVLOr6TA8uK1yydo75mDyAUhoLnSMiJSb8EGlF9DxyNm38Y6v?=
 =?us-ascii?Q?gWRORgtAg6xpNlah4liWgfOoPBdjdiMzWtjycLswmXkYey4127wNZsgNfhmh?=
 =?us-ascii?Q?DGU3qzNsVENE2A19XpMwvXjMlJjAfoQg9cVqBN2EpVYKCMukUU0LRSh6NwSH?=
 =?us-ascii?Q?Z7aaRCmTHwAxskXOUQqEQI2bAI3S0PPl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 06:34:33.9357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3415e48e-4b55-4d06-7a28-08dce1e31d02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646

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
                        (occurs after guest instruction finishes)

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

When SVM_EXIT_BUS_LOCK occurs, the value of the current Bus Lock
Threshold counter, which is '0', is loaded into the VMCB. This value
must be reset to a default greater than '0' in bus_lock_exit handler
in hypervisor, because the behavior of SVM_EXIT_BUS_LOCK is fault
like, so the bus lock exit to userspace  happens with the RIP pointing
to the offending instruction (which generates buslocks).

So, if the value of the Bus Lock Threshold counter remains '0', the
guest continuously exits with SVM_EXIT_BUS_LOCK.

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
 arch/x86/kvm/svm/nested.c       | 12 ++++++++++++
 arch/x86/kvm/svm/svm.c          | 29 +++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index f0dea3750ca9..bad9723f40e1 100644
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
index 6f704c1037e5..670092d31f77 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -669,6 +669,12 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	vmcb02->control.iopm_base_pa = vmcb01->control.iopm_base_pa;
 	vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
 
+	/*
+	 * The bus lock threshold count should keep running across nested
+	 * transitions.
+	 * Copied the buslock threshold count from vmcb01 to vmcb02.
+	 */
+	vmcb02->control.bus_lock_counter = vmcb01->control.bus_lock_counter;
 	/* Done at vmrun: asid.  */
 
 	/* Also overwritten later if necessary.  */
@@ -1035,6 +1041,12 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 
 	}
 
+	/*
+	 * The bus lock threshold count should keep running across nested
+	 * transitions.
+	 * Copied the buslock threshold count from vmcb02 to vmcb01.
+	 */
+	vmcb01->control.bus_lock_counter = vmcb02->control.bus_lock_counter;
 	nested_svm_copy_common_state(svm->nested.vmcb02.ptr, svm->vmcb01.ptr);
 
 	svm_switch_vmcb(svm, &svm->vmcb01);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5ab2c92c7331..41c773a40f99 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1372,6 +1372,11 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 		svm->vmcb->control.int_ctl |= V_GIF_ENABLE_MASK;
 	}
 
+	if (vcpu->kvm->arch.bus_lock_detection_enabled)
+		svm_set_intercept(svm, INTERCEPT_BUSLOCK);
+	else
+		svm_clr_intercept(svm, INTERCEPT_BUSLOCK);
+
 	if (sev_guest(vcpu->kvm))
 		sev_init_vmcb(svm);
 
@@ -3283,6 +3288,24 @@ static int invpcid_interception(struct kvm_vcpu *vcpu)
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
@@ -3350,6 +3373,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[SVM_EXIT_CR4_WRITE_TRAP]		= cr_trap,
 	[SVM_EXIT_CR8_WRITE_TRAP]		= cr_trap,
 	[SVM_EXIT_INVPCID]                      = invpcid_interception,
+	[SVM_EXIT_BUS_LOCK]			= bus_lock_exit,
 	[SVM_EXIT_NPF]				= npf_interception,
 	[SVM_EXIT_RSM]                          = rsm_interception,
 	[SVM_EXIT_AVIC_INCOMPLETE_IPI]		= avic_incomplete_ipi_interception,
@@ -5212,6 +5236,11 @@ static __init void svm_set_cpu_caps(void)
 		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
 	}
 
+	if (cpu_feature_enabled(X86_VIRT_FEATURE_BUS_LOCK_THRESHOLD)) {
+		pr_info("Bus Lock Threashold supported\n");
+		kvm_caps.has_bus_lock_exit = true;
+	}
+
 	/* CPUID 0x80000008 */
 	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
 	    boot_cpu_has(X86_FEATURE_AMD_SSBD))
-- 
2.34.1


