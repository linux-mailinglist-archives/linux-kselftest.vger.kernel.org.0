Return-Path: <linux-kselftest+bounces-25608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1EDA266AE
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 23:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60452162036
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 22:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C16210187;
	Mon,  3 Feb 2025 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XvDAK9nJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8DE2101B5;
	Mon,  3 Feb 2025 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738621984; cv=fail; b=sIz+UvIVe7ocnc/0pEYoh6A8UjFPud0qyG74DhXr3dce7KMu3ldprZdh35y3Er2twZlYt+UEvukvQBY50D0J5w1tPyo3Dr/ktqq+ykrjI7WcRRigndioqo/6ssvr4g3bxZYFulEjOs9m2DjFnaWv8BMJ/NriYkvb6BY0Kj4ZPXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738621984; c=relaxed/simple;
	bh=s/PrqXq00RidLQB6LHBb1xbgEvaNdJnxQ7kOudeIQ0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3sMFUwP8E4h3k7UdXTYZFg/gsZQu5W0L3U8pIAosa1S5NGJSt6dg1lWBCQUhnXPZNf87ML37qxVlWk/Y+auuPgfFjdPaAPjDP/AjDueBofJBuMNg4guAexT+QLhoA+Qlyzs5Un/vjMZG7T2dVLMIoxmdnD/Sel2DSk3xGy8PlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XvDAK9nJ; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEKhybZyVFPa8czJWjz2eth9HCKXQmmJmN67jKsQbFRNs9MqWR/e6YG8R3edwYL76WQPSjrGemTgWxuQ6HseCmflniAKG5cs9oB7deEcZUHJIiDLMVyBN7R/0Mz1ZyHiCruP1UW7UdfBtJvVmNOQsC0qePLfMsp94WI1b/+BaNwO5ZWSgUQo0bnEYjYSa+XU2y9inymxjn+QXX5pWATEzr4FO0pvQZrIJhXe1fXBIR1WyhFuCwea9oGlyHTaew6HB2nCYMeMTphNVgLjQu/+J5/XNlUCCl3Cv9HsBTR3X/o/h5wWiyVaaybI1Bqz/jrePSyan/TA9x+oaRbkD+8Q9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFSna/fvG1qE63VV7ANa4hnSuKMcfPjlvuaFiK81GEQ=;
 b=lugsSYGlG+kSizjmCnZ87dm9QogRWk1yHk2J1d/GeQkgaFqUzx8RgiSlcoRpVvye3vTKUfzLbSKpW+VR2P7See8naSUsROWNWYFT1pbFRUlsksfSp4uBqh9tVJc4+t0feRVrsE2FDx865zZrtRmD7Uazx47FIYu7U32ubZCFHbK2KBBbN74Itaw9gmZRK0/33/ODWFnYaY/Aaq00LmZoiXFyQr42nH9JZOgzRSLlS8jPja9UUlmzxMUWE8qq7FDDCTgtvl0hklg10fuJoWvFRsm9cK1N2ltwGhVGZ9FyVpJeHltkERgA+G6YcHQQdExOT223BDPWRzr7qJILys9/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFSna/fvG1qE63VV7ANa4hnSuKMcfPjlvuaFiK81GEQ=;
 b=XvDAK9nJCUPHLBa29VefZUJUlqOFuP+cizG8qROD4ipOee/A5tgG7q5cDS9ujWwFZuZ85E/Fm0LjYwjJfNUTWtuWLtugcEPZvIY+FQbhzKLYxmrhj5vUaoRsC6zKInaoxKEWP2gZu6+ceY9V6gjAZuHMEAk0/mGczP1MT1wZt4U=
Received: from SA1P222CA0135.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::13)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 22:32:58 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:806:3c2:cafe::51) by SA1P222CA0135.outlook.office365.com
 (2603:10b6:806:3c2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 22:32:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 22:32:57 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 16:32:56 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v6 3/9] KVM: selftests: SEV-SNP test for KVM_SEV_INIT2
Date: Mon, 3 Feb 2025 16:31:59 -0600
Message-ID: <20250203223205.36121-4-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203223205.36121-1-prsampat@amd.com>
References: <20250203223205.36121-1-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af52d96-23d2-42c2-9848-08dd44a2b58a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RTWiHJL6fep3bJXDdNZvMmTEQzj8wr8Ofn7O2s3QuvGrRXo4MzINzEL7Fu4r?=
 =?us-ascii?Q?bCFADQBkGVlnbhUo9VNiy5kROcmgJt/y+2TJHvr3EAGJpJWpasctxek4nn/k?=
 =?us-ascii?Q?oU/hE24xrW6aMC2zvAb3KfD7Za2csqGzzqIy1zExuFC/VHlevcjCbO0ozq0t?=
 =?us-ascii?Q?i3lttZ/GGXRIPztdrC9EV3HvRIdh8DqxbNLdoe+c4Gx8JxKI/fYnMI7g6iOX?=
 =?us-ascii?Q?jPhlpATEt/wR96C8ap5MB0RoMxaqsWsO1k/ZBokwxQwpg8ox8/z4pdH+KGOs?=
 =?us-ascii?Q?7Rw14kPgrm3IvCyZkvMCUsH3iy6t+/uwY9G0n1sHFERuYeeg7p9V0c5+Hkm0?=
 =?us-ascii?Q?/Odax1HlxXOfJDuZ9JRzo2R/yDDiKjLQpf87rCYK5KHCAZPfDd1x3o6bMU14?=
 =?us-ascii?Q?dj9I9Q74AR+eaVEjtfeiuSkMUxJlsTtvNytx/QU9CB3druv/g8bsCPC66VzR?=
 =?us-ascii?Q?pVCUg9kyEhDooDpi6R8B9pQq41s80A8HFm1A+acBHn2+Mj2pW/p4kcuUdnyK?=
 =?us-ascii?Q?G4w+3vmdT8ky/cHJg80B5zOqss0zdc6/Ci2YmgTXx5JglXh/Vjb0uZ5nUhbQ?=
 =?us-ascii?Q?WQ/1KQ/s2VAcOeiLVX2jjqNRqMdd49z8AxVVOec58+072fVW3R67Ud1PFmhB?=
 =?us-ascii?Q?KiEWj0XaeyF7NyZi3X7GLgKPm96VQzCMWU6hwV/WR2XMRASZUyqg8kq/YR3n?=
 =?us-ascii?Q?bmj2iSzWcePE4RPU9LOA2YVf+mO0Sluv7WR6v0dT3SLCRJYUarZDzSzawKXY?=
 =?us-ascii?Q?896h+tJn/Jhrx1OBDJj3w9l/cHnZIgWa0Q11FtTaZFL3elJgsN/8ZMtVMT6r?=
 =?us-ascii?Q?Amb3Pbtx7mO2pbWN0HwguK7hNq+t9AuGebHof1QChA6FiJeBUK7Fs25jJ3lo?=
 =?us-ascii?Q?4B/rnfVnmwWtI039dtun62VjXi40H/y1cQ9Z6802p6YEme+poGQSOBRJVKOQ?=
 =?us-ascii?Q?MDxDAPRyoRzeNMTgR+FtiGm6X+BghRvDL9fs6zpCse+S4DbKuSA0qJErp7/i?=
 =?us-ascii?Q?gxScSov0SCa5/PzQk54OCpa2RHKwtwzilRWmJKgMHy9/cf8mX1zpCyxnBuDR?=
 =?us-ascii?Q?vjUcO2912hy/vAWsOm8n1gkpl6djxYqCL8sQB14Yuje4WjtNK+DlVm+V5q9W?=
 =?us-ascii?Q?TSS16fN+1zUYqJ8OID8+9QU+T0ayXraLz+N9nuOdzKqcDz1bcV/6nlXogZFb?=
 =?us-ascii?Q?oiCF6E9xCCvIlc/HcTrfD5JTjDW1QGeegrVL8pRpg/YD5EGyFjyxG7qLb9EX?=
 =?us-ascii?Q?oJApIVEQAQ0dMm0qm6wtWG39WVoxc5ajjtv1S7MHDfCP5depoEqpaQ9F/Ebk?=
 =?us-ascii?Q?OZQUs+AvjvKtHEWfw+ibUbjwvdSd3REfSlgbV1zEba+zCi2EXGjnaHG9opeQ?=
 =?us-ascii?Q?4CxWPN9nThCjzqlvdXfwgiiAY2k84tLrYNTD2USnKQirZUadjaO3qIsnmLAl?=
 =?us-ascii?Q?22WDPkpM58EQo1GtKyDiTbgqYH3Plv5qCD7LMD+BIVfgDvgpRn459AHsbpL8?=
 =?us-ascii?Q?c+8dqfnbsAouVX8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 22:32:57.6846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af52d96-23d2-42c2-9848-08dd44a2b58a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565

Add the X86_FEATURE_SEV_SNP CPU feature to the architectural definition
for the SEV-SNP VM type to exercise the KVM_SEV_INIT2 call. Ensure that
the SNP test is skipped in scenarios where CPUID supports it but KVM
does not, preventing reporting of failure in such cases.

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v5..v6:

* Rename KVM CPU feature X86_FEATURE_SNP to X86_FEATURE_SEV_SNP (Nikunj)
* Collected tags from Nikunj and Srikanth.
---
 tools/testing/selftests/kvm/include/x86/processor.h |  1 +
 tools/testing/selftests/kvm/x86/sev_init2_tests.c   | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index d60da8966772..6f63fd10bbc6 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -199,6 +199,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
 #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
+#define X86_FEATURE_SEV_SNP			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 4)
 
 /*
  * KVM defined paravirt features.
diff --git a/tools/testing/selftests/kvm/x86/sev_init2_tests.c b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
index 3fb967f40c6a..ab3dd11ac163 100644
--- a/tools/testing/selftests/kvm/x86/sev_init2_tests.c
+++ b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
@@ -28,6 +28,7 @@
 int kvm_fd;
 u64 supported_vmsa_features;
 bool have_sev_es;
+bool have_snp;
 
 static int __sev_ioctl(int vm_fd, int cmd_id, void *data)
 {
@@ -83,6 +84,9 @@ void test_vm_types(void)
 	if (have_sev_es)
 		test_init2(KVM_X86_SEV_ES_VM, &(struct kvm_sev_init){});
 
+	if (have_snp)
+		test_init2(KVM_X86_SNP_VM, &(struct kvm_sev_init){});
+
 	test_init2_invalid(0, &(struct kvm_sev_init){},
 			   "VM type is KVM_X86_DEFAULT_VM");
 	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM))
@@ -138,15 +142,24 @@ int main(int argc, char *argv[])
 		    "sev-es: KVM_CAP_VM_TYPES (%x) does not match cpuid (checking %x)",
 		    kvm_check_cap(KVM_CAP_VM_TYPES), 1 << KVM_X86_SEV_ES_VM);
 
+	have_snp = kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SNP_VM);
+	TEST_ASSERT(!have_snp || kvm_cpu_has(X86_FEATURE_SEV_SNP),
+		    "sev-snp: KVM_CAP_VM_TYPES (%x) indicates SNP support (bit %d), but CPUID does not",
+		    kvm_check_cap(KVM_CAP_VM_TYPES), KVM_X86_SNP_VM);
+
 	test_vm_types();
 
 	test_flags(KVM_X86_SEV_VM);
 	if (have_sev_es)
 		test_flags(KVM_X86_SEV_ES_VM);
+	if (have_snp)
+		test_flags(KVM_X86_SNP_VM);
 
 	test_features(KVM_X86_SEV_VM, 0);
 	if (have_sev_es)
 		test_features(KVM_X86_SEV_ES_VM, supported_vmsa_features);
+	if (have_snp)
+		test_features(KVM_X86_SNP_VM, supported_vmsa_features);
 
 	return 0;
 }
-- 
2.43.0


