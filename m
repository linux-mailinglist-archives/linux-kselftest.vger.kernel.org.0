Return-Path: <linux-kselftest+bounces-6036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E14B88747B3
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 06:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7E3286420
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 05:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E39C1C2A3;
	Thu,  7 Mar 2024 05:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BvCBI3+c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F161BC3F;
	Thu,  7 Mar 2024 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709790411; cv=fail; b=NV5r079ivq83ym2lK/KBGqMbcKxCkVIDA1ymZuS7xp3V8prvAsxius0a2YTmkgfNK6D8VAmXNgwvrU3ynSBbwucbAhFfE7eZRMS6bLoiLl7BineO6bAWp4msYygh/fTZiPkR2MbYJJS3q0exEVOTZVR45mu22jHaTHXBy8BlCbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709790411; c=relaxed/simple;
	bh=p66pOu4hk5yPz5/RDqTvRaO7zFdqQSYsEvygh51j9vc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQX/qJ2oik3Wust28ScrjM+eqUaMbYaqnGHOeQwiTrI4vFAyPS1VTNeXknAdD/xSZJ9VesuVgdx7wa2z3GclMlttMws9cmN9M+NtzWtWMNF8Q1C39wIwOC0n43b3P7M39RNzxoF23L7NXoEP8S63zVBDUH7KeMXrV1x5BpWHGRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BvCBI3+c; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElWu2w8M5mrXaUI5LGnr7EHMmkapNG1NpdrwJpk04zKRIB8ND8AVjDTpMU3khoRBjMgejjZqiWGRRwlbyMPvB0S7xGmPGYFw+gZ+mX0DxMspkaH+jW6Ta4X5NidXUgXiq3G8N9w1LK2vGZPR67dUDiAzjTJmnLJb7cL/09XPDV17HTjcVI6FwkYEG8l92Ojw93vnaS1Gcp10yFHjunnFfN76XP0SXcBQSA17dcce6AN23/yJUmNyVwrEMvkT9CrmU1inY7Wlwsas+OLrwgck1g+Eir9kKFs8lKJpdEulA5B9tZ4SEZUHNtkmA6VJFcehxK2ojeDAN1f8Y4e6FFgTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GSbtpFp+P6NxHWqU8u4qAbccBZRsl5v+noGEr96OTQ=;
 b=n60sygavI1euT+dHxfAmaSm8oNj/eeRMQc2bY+kOch+9GsOUT2r3KHVs7VSzb6eR1RVw8UR31yoEGustWhyjSLmOCmFTUnR3WzKMuE+ApstO5YlKoLp3zYBh6PKmIQpfOlJbFrbn0o2K4J0qhjPcLaX3FPgIn+FfzxazzlOnFRk1GRheVwRjI6bphN3H89pw1MakXlIYPq4Mp6FmmoWDku6lEgPI4nK7CIrJt73DgYTV2w/9gu4RtrI8+Awa6b6hl3Nmh9ho4Bzfim0R9lrArA1ffwggfuuwuFRZE4G5TafpYjuWlpunwPO4HF+q9b57rrdDILtreQ/3IIQtTyIWTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GSbtpFp+P6NxHWqU8u4qAbccBZRsl5v+noGEr96OTQ=;
 b=BvCBI3+cf6c4Kn4RgDVu0WwFTztIpAIfe6EDOs+qKokmB57+M9rL35yMSCJQJlM1fttGf6Kw7Chmu8nmkuZtjDxF5/Qt2EqKNdXTAPXnkJdJ/CdiyYB6xycHS+FKdEATVUpFYbIwyPkgXwk62wz2hLSysuYie3hTTeciB11rYa8=
Received: from MN2PR05CA0007.namprd05.prod.outlook.com (2603:10b6:208:c0::20)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 05:46:47 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:c0:cafe::f5) by MN2PR05CA0007.outlook.office365.com
 (2603:10b6:208:c0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Thu, 7 Mar 2024 05:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 05:46:46 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 23:46:45 -0600
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<bp@alien8.de>, <manali.shukla@amd.com>
Subject: [PATCH v1 2/5] KVM: SVM: Add Idle HLT intercept support
Date: Thu, 7 Mar 2024 05:46:20 +0000
Message-ID: <20240307054623.13632-3-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307054623.13632-1-manali.shukla@amd.com>
References: <20240307054623.13632-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec768e0-924d-4a47-5aee-08dc3e69fa1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0Ov/I6Wff2X+VB8ggPYOsCeFJbHGrlPcBS8w+0+NWcH5i9FOmiB9oYqtng+sYRZC22SYxYF1MCzsmH9C2SiovcTQdLpOijdAPefBoqGkWIk5OaWneEtfK/mnmEUtgif6XUFH+x27wJwvQ6dSD1s/1n4UtG7abqNEp34015fMEjrOZgfmKRvKiNw6Cav3+g8jkqv5shB7NXKA4FJL9B7aGSEjs2aF04a7f/k1/IW6OBwFlZTXgWZfzyz/zL+Ja7Z67QxNaN7Xu75LErI8rj+KNrKc0zn+HiYXH/9whyrvrw3maGmqslXP8XDxFwEUcNW+dmt/rHXKJH8V+fbG4Lk8ymOlmtMCa5hjbgsGD17jWOtPEXqkMP3CH8qguiIXmXHqi/Ad/bXIuswe4bG4RahdHqg2wdsa1Zv2rl2LOko+uN4VulEe8hqQBZWj5es0gbqNOR32k9w5q0BFzz4Thvsf6sN4NJ0ha3UURJpk0eyMA0P0ejijgbb4Gnw43Vcgulb/gkkqXTItd6gC7/28An9G7Y88ZEJ9rk5ecnAFfTbJnrCs/juCFOrxG0YZk68BjPn/oJ0WjiWvtsTuPWsFuBG1Nhic1r/G6M+e8j2pBFpLKbRQaQlE+damcR9+3kM105Gemw8qS3SzkTfg12M024Lu/y9g2/xOHnYLlYSeFDi8lXclf0d2xreod3gp5x3eXix2CUlVImmuU5hKhsX4zabzmtJEyrS8jLHIA0G9/KAbFU8VJlibcAlRpofEUUTNiNTd
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 05:46:46.8146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec768e0-924d-4a47-5aee-08dc3e69fa1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054

From: Manali Shukla <Manali.Shukla@amd.com>

Execution of the HLT instruction by a vCPU can be intercepted by the
hypervisor by setting the HLT-Intercept Bit in VMCB, thus resulting in
a VMEXIT. It can be possible that soon after the VMEXIT, hypervisor
observes that there are pending V_INTR and V_NMI events for the vCPU
and causes it to perform a VMRUN to service those events. In that
case, the VMEXIT is wasteful.

The Idle HLT intercept feature allows for the HLT instruction
execution by a vCPU to be intercepted by the hypervisor only if there
are no pending V_INTR and V_NMI events for the vCPU. The Idle HLT
intercept will not be triggerred, when the vCPU is expected to have
pending events (V_INR and V_NMI).

The feature allows the hypervisor to determine whether the vCPU is
actually idle and reduces wasteful VMEXITs.

Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
---
 arch/x86/include/asm/svm.h      |  1 +
 arch/x86/include/uapi/asm/svm.h |  2 ++
 arch/x86/kvm/svm/svm.c          | 11 ++++++++---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 87a7b917d30e..68ff0855a77b 100644
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
index e90b429c84f1..a08a53508469 100644
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
@@ -3302,6 +3306,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[SVM_EXIT_CR4_WRITE_TRAP]		= cr_trap,
 	[SVM_EXIT_CR8_WRITE_TRAP]		= cr_trap,
 	[SVM_EXIT_INVPCID]                      = invpcid_interception,
+	[SVM_EXIT_IDLE_HLT]			= kvm_emulate_halt,
 	[SVM_EXIT_NPF]				= npf_interception,
 	[SVM_EXIT_RSM]                          = rsm_interception,
 	[SVM_EXIT_AVIC_INCOMPLETE_IPI]		= avic_incomplete_ipi_interception,
@@ -3462,7 +3467,7 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
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


