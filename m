Return-Path: <linux-kselftest+bounces-9209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD618B8C2F
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 16:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01291C218B4
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 14:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540C912DD83;
	Wed,  1 May 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2I+PX8VC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8F912E6A;
	Wed,  1 May 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575321; cv=fail; b=XX2SAjSO+9jTLLlElXrFFOxP33KAVd4OS79qqj6Ce+pGAtHLv0pss5SHP4YrKBjP1IJoxuJIbHP/duq9AKFl6FANWONL7f3QPGYQTHyHWi+5lQyzZq0vObtGyYHHvTHJ8AsvxsgEnnSKpECblmJwxIP+xA2yw0GJwwRzwniwws4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575321; c=relaxed/simple;
	bh=48q1j6Zleo3Tvd1hgW3XVRzW4u5hL79/W3FOzcFXhpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YtTth7BXapv9YiamnNcYV2hSYf7ocGddEL0r/VD7v7PRUKkrv/Dnnu5Lsyl+iY4D6fY4NE9DMnk03tJlXO8VDfkC3v92MzFloBXMSUeK9XLCvez78xWYFYrviHdDNDUw6ZnTuCcAB7TDndaXVTMDBeV2GwGArXH7K/7vyniVXF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2I+PX8VC; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frlGvCFayWR+cO8HBuJ4+KsQgophEAsK6D8NtePMym+87ugpd+48XAriNpB9T88Wy67GMPw+WBkNHKtWFN0HQoVEk65teYIpuO6Fz0Bo11r0zvNfO6LGkhkSEuIWkeiFixrGwGsnjqtFVRtvu/TVxsWMEjIj1kI2wzZ9FGUIFeXHi6l+GEjguKWgJXAkUF25dzs7yxrBn90/QFSjz3xqUb0v2y+JbUar7Y+c1vMZTw8YhQVFJSTxd/Vp0NN8Hq3DqaFzyIgSboddqln7FhJLIh2ZLPlEtJwM+yr8nHQ53PV9jYF29LE/Y0y07SNz+cQ/KKpDL+Pano6zFltEhcyRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7O1D9rPzshxPT36TCV4lnUf/IACP+FaJhuqydq6OOE=;
 b=bTfMKuEmIERjiSJM0hezddoonvZflmCRSUQEOBnRLGzusjwbgmCpBe48AHZtMGrQuv1UaLBSuF37itKuy4eVscHie+vJCWU14vA9Ufq3ZCGxpgfSfsHhSt9FKIJafx+FiUHpDmYW4FNRcbXcr/bNMfkzjn0Euh4ilJ39UmNB5sdpCa0/TkWDcqdnY/fHpr8o6bsQpGaNiKqk0n/MXW92GZnkDtRf/K7Lf7h0XfR9lxWtQxZur5oUoRUJdAqCTkTMayjyiNbqta36ToJL4MR7Cn8HWqQ0BRXQhTZiinUBFDlrQUkqxfxPCNPdqE55mdBW4Ekf+5KYWJ7IfHUYeZrdew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7O1D9rPzshxPT36TCV4lnUf/IACP+FaJhuqydq6OOE=;
 b=2I+PX8VCfCEvB4HHnq8SRgqYLJmNlt4Zim5AOF/Nrb5l2t0by3BoqBgB/ZefNv27tx/4JuZIwC8dkYqEqDLIsAZ4tbRme2PQ8BQAJTo2V9k3t/5RLl2FJCPVYLMuS7npLT3zoz0Hm/BUNEfHB8M3xokQiTY36hB27gRb8p4xrDw=
Received: from CH2PR10CA0026.namprd10.prod.outlook.com (2603:10b6:610:4c::36)
 by DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 14:55:16 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::84) by CH2PR10CA0026.outlook.office365.com
 (2603:10b6:610:4c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Wed, 1 May 2024 14:55:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Wed, 1 May 2024 14:55:16 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 09:55:15 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>
Subject: [PATCH v2 2/5] KVM: SVM: Add Idle HLT intercept support
Date: Wed, 1 May 2024 14:54:30 +0000
Message-ID: <20240501145433.4070-3-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501145433.4070-1-manali.shukla@amd.com>
References: <20240501145433.4070-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4a87ea-12a9-4006-b0bd-08dc69eeb66f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aEFKlzsIu9U/8VcPACN2yQeEZw+hZ0PxeqzSLrieU6QuJvaHpscM47Dw2CAw?=
 =?us-ascii?Q?vFbWFIKlSlnhPbvQWT9v94XnJKTS41bRwUagrFKnvAsErKxcixlsDtJItEsK?=
 =?us-ascii?Q?QEezuMUOPdDwKJjkXpej9TngrVTOHAc0BhXgVkyQzfB27j4NiKpLgmllskjt?=
 =?us-ascii?Q?X2gASXdBuZRzefFrtLLD48bxcAgM7+rZoYUR6mLCpm7ymVPFODZfTpZ7TB44?=
 =?us-ascii?Q?Ye/L8j8EFQa80QE0K0o5GWrMWZvF4GkBW6qF4HJQrBzw4fRC97mktdD/uHT2?=
 =?us-ascii?Q?i1OI7BIXD7gGiEivPzP8913jDtRmC1aOcHg4XoQoNO8bEfmtsPpNylAF1LNv?=
 =?us-ascii?Q?HXt/+pVNuB3xG9qNQIrgvVfzZ7GBwK4+FonPefBgOEInu6NbifTu5KPpObyv?=
 =?us-ascii?Q?m0UmaCEMKsyaTlbxczgVVzjtD6uYBhDwwF4RBEdcZax9Ho561B0Nrmm+HSUg?=
 =?us-ascii?Q?+s0JFzhbwEogGuUXhK5iNTtv2ROEbO2Nziaz62Cib2u/mq0P5ZykrwL/8dEs?=
 =?us-ascii?Q?SbkScigi6Kn4CnteP7qMQl+NXhIqHEL6tBjRbwmDftgVSBKoDAQZAFW5wA5q?=
 =?us-ascii?Q?D2+tuE4qhde0bLRzbQ4lyWiIwAAqTEv+eyiEy+5xFBy9ExRsFyBcNpw/1/k6?=
 =?us-ascii?Q?JZgXoIydPgvxVUKENz2z1ClXpJzJMESWDenPDduCEHkmO4RAxt4Z7tPIVseT?=
 =?us-ascii?Q?12VPWoyKVR3VWAp4i3P0HT0uFT0PsQbcUO7P2QmnplKWgepZB/1ZtpOvtDx8?=
 =?us-ascii?Q?QGzdH28ByDZs8Qg+nXukUrUc2qtjHVSki/ezvRdUELXpMn1/fxwnk9qdSmag?=
 =?us-ascii?Q?5TxulvlVKhI0XhPV4sxzjcmySLKlHvPCnkxZGWHjq0CdFamBbDa17ZyA04T8?=
 =?us-ascii?Q?r9OYRp8hdQlhKvRhStIAi4Dzgt/1V6Z94z0JNqK2yjQMHw0gZhLukGSowPdD?=
 =?us-ascii?Q?NZiMQdo6ynqMSfpGwamb6dUcQZIZekKr+egh5KPh5Lvf58alTUBydlPejlzp?=
 =?us-ascii?Q?2iwYEtMqREp/9vLMlr2fe8HPrxyadJwxlcRTn6IBbPORClyZHrvI9r2cEuLu?=
 =?us-ascii?Q?0fiaI3qlRheXpRRjMeTR2kHOS/N0+3sDjtYUgus97RbFXroHR0cX7R8Tdgw7?=
 =?us-ascii?Q?eKUcJjLcSi+2KL8FXXd9aJdkcTSCPlI4Z2FfHkSFN1hbIZPqW2srdZqjXfij?=
 =?us-ascii?Q?NAKYaoIbth575In0Gq0OqWOFFqbEK0NlyGfOfwQrnVjz/83nWVa7yphJ0vgM?=
 =?us-ascii?Q?gz+04l7z0lmTQRogP7DUpo8DGkeLP55mEBcKJRRxGYYPhbugaP5T1i2CdHMH?=
 =?us-ascii?Q?kG3XCBBsB7SucfqdPqi3lPmL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 14:55:16.3048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4a87ea-12a9-4006-b0bd-08dc69eeb66f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199

From: Manali Shukla <Manali.Shukla@amd.com>

Execution of the HLT instruction by a vCPU can be intercepted by the
hypervisor by setting the HLT-Intercept Bit in VMCB, thus resulting in
a VMEXIT. It can be possible that soon after the VMEXIT, hypervisor
observes that there are pending V_INTR and V_NMI events for the vCPU and
causes it to perform a VMRUN to service those events. In that case
VMEXIT is wasteful.

The Idle HLT intercept feature allows for the HLT instruction execution
by a vCPU to be intercepted by hypervisor only if there are no pending
V_INTR and V_NMI events for the vCPU. The Idle HLT intercept will not be
triggerred, when vCPU is expected to have pending events (V_INR and
V_NMI).

The feature allows the hypervisor to determine whether vCPU is idle and
reduces wasteful VMEXITs.

Details about Idle HLT intercept can be found in AMD APM [1].

[1]: AMD64 Architecture Programmer's Manual Pub. 24593, April
     2024, Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
     https://bugzilla.kernel.org/attachment.cgi?id=306250

Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
---
 arch/x86/include/asm/svm.h      |  1 +
 arch/x86/include/uapi/asm/svm.h |  2 ++
 arch/x86/kvm/svm/svm.c          | 11 ++++++++---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 728c98175b9c..3a91928a4060 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -116,6 +116,7 @@ enum {
 	INTERCEPT_INVPCID,
 	INTERCEPT_MCOMMIT,
 	INTERCEPT_TLBSYNC,
+	INTERCEPT_IDLE_HLT = 166,
 };
 
 
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 80e1df482337..9910f86a2cef 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -95,6 +95,7 @@
 #define SVM_EXIT_CR14_WRITE_TRAP		0x09e
 #define SVM_EXIT_CR15_WRITE_TRAP		0x09f
 #define SVM_EXIT_INVPCID       0x0a2
+#define SVM_EXIT_IDLE_HLT      0x0a6
 #define SVM_EXIT_NPF           0x400
 #define SVM_EXIT_AVIC_INCOMPLETE_IPI		0x401
 #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS	0x402
@@ -223,6 +224,7 @@
 	{ SVM_EXIT_CR4_WRITE_TRAP,	"write_cr4_trap" }, \
 	{ SVM_EXIT_CR8_WRITE_TRAP,	"write_cr8_trap" }, \
 	{ SVM_EXIT_INVPCID,     "invpcid" }, \
+	{ SVM_EXIT_IDLE_HLT,     "idle-halt" }, \
 	{ SVM_EXIT_NPF,         "npf" }, \
 	{ SVM_EXIT_AVIC_INCOMPLETE_IPI,		"avic_incomplete_ipi" }, \
 	{ SVM_EXIT_AVIC_UNACCELERATED_ACCESS,   "avic_unaccelerated_access" }, \
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0f3b59da0d4a..223c670bf986 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1289,8 +1289,12 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 		svm_set_intercept(svm, INTERCEPT_MWAIT);
 	}
 
-	if (!kvm_hlt_in_guest(vcpu->kvm))
-		svm_set_intercept(svm, INTERCEPT_HLT);
+	if (!kvm_hlt_in_guest(vcpu->kvm)) {
+		if (cpu_feature_enabled(X86_FEATURE_IDLE_HLT))
+			svm_set_intercept(svm, INTERCEPT_IDLE_HLT);
+		else
+			svm_set_intercept(svm, INTERCEPT_HLT);
+	}
 
 	control->iopm_base_pa = __sme_set(iopm_base);
 	control->msrpm_base_pa = __sme_set(__pa(svm->msrpm));
@@ -3291,6 +3295,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[SVM_EXIT_CR4_WRITE_TRAP]		= cr_trap,
 	[SVM_EXIT_CR8_WRITE_TRAP]		= cr_trap,
 	[SVM_EXIT_INVPCID]                      = invpcid_interception,
+	[SVM_EXIT_IDLE_HLT]			= kvm_emulate_halt,
 	[SVM_EXIT_NPF]				= npf_interception,
 	[SVM_EXIT_RSM]                          = rsm_interception,
 	[SVM_EXIT_AVIC_INCOMPLETE_IPI]		= avic_incomplete_ipi_interception,
@@ -3453,7 +3458,7 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
 		return interrupt_window_interception(vcpu);
 	else if (exit_code == SVM_EXIT_INTR)
 		return intr_interception(vcpu);
-	else if (exit_code == SVM_EXIT_HLT)
+	else if (exit_code == SVM_EXIT_HLT || exit_code == SVM_EXIT_IDLE_HLT)
 		return kvm_emulate_halt(vcpu);
 	else if (exit_code == SVM_EXIT_NPF)
 		return npf_interception(vcpu);
-- 
2.34.1


