Return-Path: <linux-kselftest+bounces-10759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0988D1348
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 06:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BED41F23145
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 04:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935242E3E4;
	Tue, 28 May 2024 04:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WCWD8goe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7022110E;
	Tue, 28 May 2024 04:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716869989; cv=fail; b=MOjJWtluIMpvkkIRU/J1eAXIei3oF3mQDP74BIGYC6eqR0WxL229HB/ul53h2tr0DWxYtFGx1owtTl9ozVdBvhfBK36SsusE4cpcP+LnkbokXRMD/B9P/pSBdc6HnBJZbh1mCS1n7im2Wg2QrqbXQeTF2JhCEGtoX8GdMxNqs2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716869989; c=relaxed/simple;
	bh=+PpE7OSbqgD4TJj17DhUIBYvXAfbrt+REe4apd+vuws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCLw074xxrl4VMKHEFSy2DmipQ6HKepX2lAc5Dz+12RHfQi/llz5XpxyNfuOa6DtpTXwW/IBApNqajHZQ1Sn9eNXLt23X6EACsKrdKMnOXDGx2kq1cU51/gAxbjBeDwa6PhRyUlyxdjK+dnGzqzTkKsoCx5DIHdgs1CmFb7VXa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WCWD8goe; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0JWeYQ9hGwt0Nv6V1UzWlwlgdL4zZmAbcABOkHIb/dsmUj6I/giadV2u5R2PU0wu5kzv15Ff5P77to5J4OT8lMnlUfo5Ye6mh9qHDmO/Us8Y5i4EDrsnQ/nAVYW7hKGoNdh/poaFRC+m19EwL+g/K8BM76CAH3OfpSjv2ZnccRC579wIsRRM2QwngTY3IJ+tMnUMoeavHj21+h7fvPMtxzrn9jA6/8gLTUicgks3UxSyBmzawP6FlrKAXtJQmu/zWYyVhrE2XgcE/YTmpFG7FLYYIIR6UYRyKmbqcB4tA8C02dKAsugyIPDE++e3jLZRIRZEhnjc63AkVCvhZvHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17TNL9Ff3CSKZT4WSNqacUZhz8FMFtpKFHhMjc77pXo=;
 b=GfyILJbsSxU3Mfx8W8qb1cRFTVIZC6DS8fug2eSV2j6FpSHB6Jd3r2DnBJIZ5ZbPesAB8RTIESgTnsjOauQL5x2xBZXefp1AOBQGrBMminIzSAc8datg2fctco5H8bWY9rEJaOzs4xaVn7JjAFc+Bt1JmXdjvui7cI5BKeZ5pRS26aK9vzaxWpTbIEf4NBuJuAJOIaWRgD9hlcmO8s2JImDPvZjPIEBu0IKn6jEA1+JArF8AK4XKoIbSXbnCoMnKS8jSJ3ZDJMuHu3spb3dyhRjBFREbRw6kK4nq9mwdtwMZpNJY3umQs8chwl7ejJWJJLBEVmJ//Es8fMFApdOHRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17TNL9Ff3CSKZT4WSNqacUZhz8FMFtpKFHhMjc77pXo=;
 b=WCWD8goeqJRPV+Mt36qT75Ei+XBYgqItwnm9kIwIEbeugKo4OjqhUYA/UMezKUShFFMz1OcYNBInUim36VkU3BgltCNxl5S1MW4+5TYd7US19GAEJ1DVZ9o9KZoJYkFobI8WxkVvoiphZWzfwl7chblQo/58SvRgmg3/PV02MzM=
Received: from BN9P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::24)
 by CH3PR12MB9021.namprd12.prod.outlook.com (2603:10b6:610:173::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 04:19:42 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::9f) by BN9P223CA0019.outlook.office365.com
 (2603:10b6:408:10b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Tue, 28 May 2024 04:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 04:19:42 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 23:19:40 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <ajones@ventanamicro.com>
Subject: [PATCH v3 2/5] KVM: SVM: Add Idle HLT intercept support
Date: Tue, 28 May 2024 04:19:23 +0000
Message-ID: <20240528041926.3989-3-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528041926.3989-1-manali.shukla@amd.com>
References: <20240528041926.3989-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|CH3PR12MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: 97216f8b-8a15-4bf4-1114-08dc7ecd65ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wk0BCMZzGYUqIQ/PNpP732DuVWaeh824GNRLMVoPYtJF7YCwOCL3O3tUn6uf?=
 =?us-ascii?Q?qqrRUyE1jAmWauJKOhy5WnWGrmALYGBQl55ylSrhfBAOVpltNCLWiz/Lm/1x?=
 =?us-ascii?Q?qGLLKrmu8yYlcBJ+6qjR8UX+vr+uLQ6dRKtK9XUdD1u2Hf3c9JKOwOysQZcL?=
 =?us-ascii?Q?Zs5Et30hxypeM1jTVQptTKOc1v0E/INWUqHxONuF2p+y3m9HeOCvpNCjMlae?=
 =?us-ascii?Q?Rq5ELTvzSNnu8M6XJ8Z5doJHMt//+KdGeTkqvZlp7cbUH0PLEAI/O0PUZqHW?=
 =?us-ascii?Q?0Kct3wwju1ANTu2XnLB9O/92bu4uKrpbJ7C7I2g5EexCCHHO4HkIQDphCS7n?=
 =?us-ascii?Q?aELFAXQxYVNdPsMO2JWIvnHL+yNd7mPVa/08FA+cHaJYceLoo4Hgf0gLqIuw?=
 =?us-ascii?Q?RWdGYjbh+lxuFUtBcXAncDEBncIXI3Yq37Di+NaqSA0jn3ILXc7iZotk+KXQ?=
 =?us-ascii?Q?5Cv12F5R/GEzcMG2YUpHKk/BWZ0qlYHzviOe9KaMOw4yJ7mrtxwGRDiWuN1j?=
 =?us-ascii?Q?jhEGJbXxOFRl67sfF1RdUtBEHQUSxtszT/3E8Ke5B8WutGMZmA53xQO4g4sS?=
 =?us-ascii?Q?aQmk9HHkSqvI6gmJ1mwzAZwKTUdKydjMyUQm3pbvrb+Griy+dV0P7zKq4/FR?=
 =?us-ascii?Q?k4h1MDJlbLV8vyPW1W0eOxZA36SQjc4TWbC2AP0CzxmnSzxbq12tTMdlkwuP?=
 =?us-ascii?Q?CBflhSz3XU/0+uqM8aWc/bn8RdcrYTeNWD0xxfbrh/aGBNVk3mIpLwcfSO4h?=
 =?us-ascii?Q?Lri70FljMzwOtnD0U8PlcyB/U7R3jkqT09FBljADly0NG+bTkm5jD0zKlAM5?=
 =?us-ascii?Q?6zJhTK8Kc894Reg0dQ1eSpRUFrFEiBOF1wty4JoTCWdEkBUTNs7/TnwXQ8/R?=
 =?us-ascii?Q?auRb19bKi2a9kXHjg3biClM1jGBaKxfKjKX/VGyMe3q60uuHxTPj7HMU73pj?=
 =?us-ascii?Q?kZLpKIseEsakRU4AirFiNmvemlw/iYl/wnAm0vRhZls1o/g2Bm5yofH/URQx?=
 =?us-ascii?Q?48e/Ufbi5rj9i56sjA+gpor07GbWjditqdsyg/vC19pGnv/xixNEHyRVsfIJ?=
 =?us-ascii?Q?EphgdNYu4ODbXxUjButPJjZRAnMvdEj006oi0f2axmKXvAwCzh74tsT4qlWf?=
 =?us-ascii?Q?VLRDf0bW4p5qSRvsCPb/4RvcWp9tf1LAj998AT4Jw2opTR2rAe1q4/F96TCy?=
 =?us-ascii?Q?jSblu0xRxUW6SPGlfiWL2g4I/b12fs0MwiSCup0oK/iwYzCP90B/QD1krJsV?=
 =?us-ascii?Q?KsE5bYYJ3SHauRnlKBwS63t5OyWaI0O5Xl7gQgPiOBs1Mk1PfJHNJfreD9IH?=
 =?us-ascii?Q?pAyNDXrepYR/t+RKJ0Ylz7Wk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 04:19:42.2533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97216f8b-8a15-4bf4-1114-08dc7ecd65ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9021

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
triggerred, when vCPU is expected to have pending events (V_INTR and
V_NMI).

The feature allows the hypervisor to determine whether vCPU is idle and
reduces wasteful VMEXITs.

Details about the Idle HLT intercept feature can be found in AMD APM [1].

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


