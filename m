Return-Path: <linux-kselftest+bounces-28358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C9FA53DF0
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 00:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45F918915E0
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 23:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F23207A0A;
	Wed,  5 Mar 2025 23:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KSrL7Pnm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F17D205AD6;
	Wed,  5 Mar 2025 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215764; cv=fail; b=eybJOj/JwdMKYtQ2HBx9TNQK2FlHN5Ue5NKRwK1RfKlM6he8up/uMs9C8/ZQg/IkSEBY5u/Nwmb1fWEV8CiOl/1rUg6E2/OS/x1c5Xva5suSZCr7SFacs/il2sdcze8eTY8HqUtF1obJuG37gZoB+LZYg/wACLFq6JbaUlNeB5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215764; c=relaxed/simple;
	bh=RFYa9WD8MlAi5rvaLTmSbjXe5T/nmPNuTqO4PXcBJ1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzuFwkHLOJxxVFK/wyhnbZvZa02jT0lcs3L2p2cFh3upfIZRBQ1bbl1bYoFz/SIUHh/OaL6CQDP8tXt+LJcKB/LGA7GXD4Uo2ps84qaug6/erdLHCnDXbKwdOKe0t2doOAwQXMY2zTDol3L7vr1X9O867Lu5fJo0KPaKEMrtMDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KSrL7Pnm; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjZuMv3lOMhFE5O7wMXx02vwYjik8F1ghCCjkk6M/Lq7Y87W/1vLtGamqNhTGmZoH6ggUh9APvxnjLRijMOaFKwKY1aHPDH0mPuWFZq7A9jA9swCSiTswLNDQU5+LvAcVEnEn4u2tHLVy7t9boOg2UeDURA/ZSRqTXM++yHjh0QDwwzpM8IKmBejBL+25/XsI6PE9p7b5WUE0P9Inks3nTK4+nQVEpa8AT5nkCwaKjcGdvCWe2bKJTXi3SeuuskDcWmRMSyBkPeLK/Vo5vu6CWcfrKTsLLz5shxQoLxtipiBSxoNQ0d/q4SosBbyvy8YqSEuQDXZhX/KDl33ac3ARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3YD95RsUY5eTxx8ae5CVScVbNwbwBFPsy+5uUC4FJ8=;
 b=u0pTW8B8BlZuwdiYHZkkWlCSA/PEWRdbok1UPbRLfaglOXdon/e1uZ25UwaH2mz59swNcx9v7J/t3nsjSFZS5q3Yhoo6d6xrnwQfDjB4iEFQ85rolKTgIF/T8qZSVp2QhnRi6+4l8MFDlBVX8f8dg27vdJfidg4XkQf+0QmIKpsljnlySoLBup60f30LHgBX5yJy+u8CeL2bfWqHKP0TaP/lNguGeusBraAtaWXLxq8eTSMvHNexHs+HL8OsniywqjEVjVL9HAxDCghbC8IBkDnQADn5tl3D+7bmzP0L3+IPWjwWj8Rpgpkxw3RZgzOS76A55+KID3iQ68VduY+/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3YD95RsUY5eTxx8ae5CVScVbNwbwBFPsy+5uUC4FJ8=;
 b=KSrL7Pnm2zVWdKKn7HSNf0u465etDifAXsAw4Vtc7Bb6XDP5oq6xTsCTmuHSKbGLG5H92cbKxsWyqugQFDxbhTiz36ipowQMOR0O+8UTsqGaB75Cl042hyuvyItH/NJNwgffxjn0PY/ubhULtl6ykrV5OFf4RXuaBwtK4xtRhtQ=
Received: from MN2PR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:c0::23)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 23:02:36 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::3d) by MN2PR05CA0010.outlook.office365.com
 (2603:10b6:208:c0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15 via Frontend Transport; Wed,
 5 Mar 2025 23:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 23:02:35 +0000
Received: from zenon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 17:02:34 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v8 10/10] KVM: selftests: Add a basic SEV-SNP smoke test
Date: Wed, 5 Mar 2025 17:00:00 -0600
Message-ID: <20250305230000.231025-11-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305230000.231025-1-prsampat@amd.com>
References: <20250305230000.231025-1-prsampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: a91919c2-a281-41aa-33ee-08dd5c39d1cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BJHjwriffoFLJ+rFRMvj7+ywyyyYqki7zOdiFzii2Yz2MDkjUmCorXMbybs8?=
 =?us-ascii?Q?BvNUlLVQLrmLt7cRjQvhfOFhfv2PPZhpN7GPnNQ3QoNE5mfAGKyRPhzVk667?=
 =?us-ascii?Q?Tu8hWm+2EwDWnjIN37XeEFu2FVFUfYWlMW62FZ8WNmKbiOnJE+63cZ/sruJC?=
 =?us-ascii?Q?q6dOR3T/aP8HvRBQK9j0ly5HVpvs0beDYGrSxg2T8c0RDzSZxm5U+M0pPDSR?=
 =?us-ascii?Q?jRHUzaj9bn7ZJb4OlSa0VaPugzc5r1hz4Xg7rA7cWHTHBGOFiqGJ5CuLYVqX?=
 =?us-ascii?Q?z8zZEQBUS9LkBBEvlKLKdTVAatLSJ3GddvNet4cPrIRN0MNJso23KVAIgIIs?=
 =?us-ascii?Q?/6hesMhEs5SOHHgmi5RMGbsIvZwCqP8BJcfxcFE4jmTkl1FAK871TOKC35w3?=
 =?us-ascii?Q?+Byc1zOiqOu7ZCwfJJlC/EesVEwKNbSYCRvnDZ3KUnzDKc9DXkP15KY3etFK?=
 =?us-ascii?Q?PuqcUI2Xm6Ofl5jwASyNFdn6Wxe8/WPViCBMFxHY4/Mm4OetoazbN1lBUfUo?=
 =?us-ascii?Q?WRl3gN+L9+uMgbmWQzqqozE25DAGG4CdJNEMz6b1MCsQFQ5ye2KCabmRgvY4?=
 =?us-ascii?Q?v+6KnmcTROnvud7zeBH95xVxJLuoDJnpyfY5zHwRbbzK1ipsFeybA2XkeAN9?=
 =?us-ascii?Q?yQZPFO6LsEWCLl74ppn62qW6ve9Ivc6vW9JQ5cBG7idCUyYeARXFz1ePFjNX?=
 =?us-ascii?Q?c8NtNHmHAVr3J9lPKI3tjk2Fpwc819Id05+fmDHWx7Riq7Kf+A8bJkfTlTTi?=
 =?us-ascii?Q?6K92Pf04LLBnLABY1eSkZNsIo2AS2fKQ6+vz+KMtJ7HgEPEP5yjMapIcEC9P?=
 =?us-ascii?Q?SDdh6e8AyBXh9s2MbsZIc5Ui6Ronj5/OXvbGJL6BTSnMSZRtWUYPPeFht5nT?=
 =?us-ascii?Q?GEh6SWJS7VvlYLWtplHP9KUK9sW+QavsG72XTjpAHthXT6hoGTRJcNhDOmDe?=
 =?us-ascii?Q?LLwc1gOXSDPZ1P31l7fxosk5WLpUfGYZcERoosoXh99Y9UzLYWkEjmI9wh0S?=
 =?us-ascii?Q?7FPNwBwrhOVGEBYHkm86bpm8Z82C8kGfBysg3guVtGktmdSgkzWbsRucN97b?=
 =?us-ascii?Q?PT1MtuufZ8wY5SSOa23UMURaFnhbxRBrmI/GMgLOJOQpXR5rgwVfuBdhn2Ms?=
 =?us-ascii?Q?M9XVTbei+eSbzkkq8P/DnLltPGIBL0QNcjvjwQww7Ml5SEvXcrQu9wrwB6SA?=
 =?us-ascii?Q?JgzopxBxsEabcU9L+ipCjorcm53Yxpzr+0yy/6WbiCx8Dm4xkC/Wml0AeCDU?=
 =?us-ascii?Q?xBwQX4Y58T+JKLMZD2Pyn34Oc6XvCLMlzFq0j3nzgH8Etx7jLCSoPXxOYh2M?=
 =?us-ascii?Q?5OAmfFF6OCYaKKsNS2DSmFQcXHGJ6KNd8xJpayNIigck+vXaIZ7EvrUnJxft?=
 =?us-ascii?Q?6xz/8/P+O3yCOvKO8Y6kdxSmPGkIYhFljpvtKc3P4ZVVLkbJ4RieYmkmLccj?=
 =?us-ascii?Q?lgFaq6w9ilEnPiRaDgDtMS7NOiGtLcYltlXvCt5sSu/jbgPV8Qdiy4BWi3Ep?=
 =?us-ascii?Q?r/9HWYBvD1xRFQI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 23:02:35.8787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a91919c2-a281-41aa-33ee-08dd5c39d1cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353

Extend sev_smoke_test to also run a minimal SEV-SNP smoke test that
initializes and sets up private memory regions required to run a simple
SEV-SNP guest.

Similar to its SEV-ES smoke test counterpart, this also does not
support GHCB and ucall yet and uses the GHCB MSR protocol to trigger an
exit of the type KVM_EXIT_SYSTEM_EVENT.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
 .../selftests/kvm/x86/sev_smoke_test.c        | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 620aa7c41f7a..0505cde77358 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -16,6 +16,18 @@
 
 #define XFEATURE_MASK_X87_AVX (XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM)
 
+static void guest_snp_code(void)
+{
+	uint64_t sev_msr = rdmsr(MSR_AMD64_SEV);
+
+	GUEST_ASSERT(sev_msr & MSR_AMD64_SEV_ENABLED);
+	GUEST_ASSERT(sev_msr & MSR_AMD64_SEV_ES_ENABLED);
+	GUEST_ASSERT(sev_msr & MSR_AMD64_SEV_SNP_ENABLED);
+
+	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
+	vmgexit();
+}
+
 static void guest_sev_es_code(void)
 {
 	/* TODO: Check CPUID after GHCB-based hypercall support is added. */
@@ -179,7 +191,10 @@ static void test_sev_smoke(void *guest, uint32_t type, uint64_t policy)
 {
 	const u64 xf_mask = XFEATURE_MASK_X87_AVX;
 
-	test_sev(guest, type, policy | SEV_POLICY_NO_DBG);
+	if (type == KVM_X86_SNP_VM)
+		test_sev(guest, type, policy | SNP_POLICY_DBG);
+	else
+		test_sev(guest, type, policy | SEV_POLICY_NO_DBG);
 	test_sev(guest, type, policy);
 
 	if (type == KVM_X86_SEV_VM)
@@ -190,7 +205,10 @@ static void test_sev_smoke(void *guest, uint32_t type, uint64_t policy)
 	if (kvm_has_cap(KVM_CAP_XCRS) &&
 	    (xgetbv(0) & kvm_cpu_supported_xcr0() & xf_mask) == xf_mask) {
 		test_sync_vmsa(type, policy);
-		test_sync_vmsa(type, policy | SEV_POLICY_NO_DBG);
+		if (type == KVM_X86_SNP_VM)
+			test_sync_vmsa(type, policy | SNP_POLICY_DBG);
+		else
+			test_sync_vmsa(type, policy | SEV_POLICY_NO_DBG);
 	}
 }
 
@@ -203,5 +221,8 @@ int main(int argc, char *argv[])
 	if (kvm_cpu_has(X86_FEATURE_SEV_ES))
 		test_sev_smoke(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
 
+	if (kvm_cpu_has(X86_FEATURE_SEV_SNP))
+		test_sev_smoke(guest_snp_code, KVM_X86_SNP_VM, snp_default_policy());
+
 	return 0;
 }
-- 
2.43.0


