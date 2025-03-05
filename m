Return-Path: <linux-kselftest+bounces-28350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C5EA520B5
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 00:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFAFC16960F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 23:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FA02066F2;
	Wed,  5 Mar 2025 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D80leKj9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551352066C4;
	Wed,  5 Mar 2025 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215631; cv=fail; b=XpnsO/ztNlbE9rRyg4RZT/sNfyhfEu/9/waQapXGABeHJc8lSrhYkpPeBKgdPdG8nWZtLtiSzcKH/jxiDPgE+HwI8Bka+TwEuH2c9YzngWvcrXinQo+EQoJXwA1Ya+6VVkNWywWS+XEg3Rlny06v4U4gRqvzojNEfCV1P4cvyVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215631; c=relaxed/simple;
	bh=/4/OT1ALXFSX3C2vo5CwlhdXkOxJ16JkPDnW2WjRH/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DtqaZtF5UNiGDAI1otB2zKoM03pTvvKrJppYyEU4ZW1fc3iEd9qXAAFW58iuaKeUmdtlozTVGUsIiKRxxM3JSzTBRRhTn9nqe5wUV9yOO4pRjfwTOSmhtMM8cJ+TsE9yF/TOROiE/dGfRQRa8PBhbbuw7hbRWloyIUjG/RKgAOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D80leKj9; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeGc/rRWooqlxm08ojLaKlXyaNUZ2t265DrCA43F7xNBJSMHt3hSHAa58wYYp+Xo69CNjUppzp4tkaIeizw3HG0eiZqix9KCqW31dZPExxxcV73niDAt7sNmiMx+gXwWuT/kOr9gfAq7ikSG6Wy1JJ61/ycIm5uOXUBqIr9irOf6HJowjq0xPJeoatw4R86pB5A9qzwZGh7doZVOlIryAxO/BfctQknLQ64FT8TllQpMvM+M2eZDz0kzN2bmA4X6CoitypLC0t3Wl7pKo04aInVe8vEBySF7GuwEpGPDki+tWEQ7if/GrDW20khBp/GzhNEdjjJ2CwwZghg8+nE14w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPzld0uPyREdpEwrjDRUCdr4rmcxggdsKjC/l8fKW4M=;
 b=aUNd2yod9Ln+Iz4W2pAZt8DTka6ZcftE6Q31gSYfcqipXjP1ohxfTd8WGVQS2DtxP6s+y28JqYHS4CHAKTJ+N6qrD6l3Ua9B2gn1mzi7vQARcfm5866on16iSTB9qJ17lVPaHwfCKDlDJsi33WuXeOBjX7Xw5+D21gCaZr1zzb8UjlAkWmsgTElORfo3vmuSI27sEO1AQlPgj8qvHiufdQ1vdgG1T4zeM+ATRrm+aevE7cJlIj2LTHi22d80tzKOjGFalwcfdRksZvnzROtU1kOyBr5lebvYj+MD2oM4owrBu1w1/WfMiJsWTkS+Z/6NTcondyV+wiyDTIvTxW+jUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPzld0uPyREdpEwrjDRUCdr4rmcxggdsKjC/l8fKW4M=;
 b=D80leKj93tM1voBYl+PgVzfm9s0jecHKN2qcVq3qR/XBdAzFIazhO2xaMZ4y2sdDV3En1QHhzjIuUHl+tURTRWH1LhYKbRzMHaU2ylIzUvJK+xQIF98fKeKLyhcR/KuG5qi4e4VbwJk7gKY9djR15Eb516r8tOaf9HLvBwlyUTg=
Received: from BN0PR04CA0073.namprd04.prod.outlook.com (2603:10b6:408:ea::18)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.16; Wed, 5 Mar 2025 23:00:26 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::38) by BN0PR04CA0073.outlook.office365.com
 (2603:10b6:408:ea::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 23:00:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 23:00:26 +0000
Received: from zenon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 17:00:23 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v8 01/10] KVM: SEV: Disable SEV-SNP support on initialization failure
Date: Wed, 5 Mar 2025 16:59:51 -0600
Message-ID: <20250305230000.231025-2-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: ca97ab9a-cbe7-4c92-11ef-08dd5c3984b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4QKRuJMQ3s/kHnfu+gzxXYnwh5VBA/ehqbchIw+KdYAJWyO5JCyN5piy3FtE?=
 =?us-ascii?Q?JDyZ3LW4mg9BgJh+MFfC2JcuU4aD7/WxC1J6JGIiLSsH1jwGWNTzj31Rg4Ap?=
 =?us-ascii?Q?vdJtq1lHHmoT04WOLk13OTR5lm+ziOLwRVV4mJCDo8trQ+PJph1j9takSsBm?=
 =?us-ascii?Q?v6mnov2yqbN9PvJYpR80BR+q4sn2iH5bpEb7B31nqfL/6GnWT1RBHnyMDlqY?=
 =?us-ascii?Q?JZLs1qpbvBifWaIUaGWsYZKCw1+hvMi6zCM2eSqxwGIEjcULJo8NYaGaZ5d2?=
 =?us-ascii?Q?euDH1Sned48xC/4av+QeSbocxjYmHSuagO3+lzBag5ZFi+jhfDTGliSRRC3N?=
 =?us-ascii?Q?xBIWZPnuJGoam3k1jb8Ibpvy2VNt7OJahwB6NXhs/HXICFPVL7bvlbzLGvLr?=
 =?us-ascii?Q?4oQFCL54Kmg7iUbZzcVw5Ncumn8Kc8YSUgh1Hatyd0/wUuW+sIz/Obp58Myu?=
 =?us-ascii?Q?sdg6F85+C81pElIzEQGkN6K61pn3/+nHw5uyFa8w3WxviOJK2gmkjH/yixZr?=
 =?us-ascii?Q?ZmkAGYaDpUNXzho7HhsHtAsK2KEgYMvyBPckYg6Jq1p9nvca3gN1hR/nl9ya?=
 =?us-ascii?Q?RWzQGeO87KiiL/i5T6Q+CbvKvZba6oZhN1tLGqmdHy/5GSaAtB0mG4QEndYF?=
 =?us-ascii?Q?P8+G0pgxeC5SX3f6xrNb0H81RDJgVTlzBN2KmbVPwKoglK5DyXwMyOQT0FhU?=
 =?us-ascii?Q?F+gjecLYi6XxAljeZxfWfIhvMPrmR2C2dn3qGZM7rYz/wY3ZT+i4QTmVaA2J?=
 =?us-ascii?Q?wtU84aBnNXS0Vlc6CKUCaUUFhTER/njfHlP4evQ1eoldXdUnkcG/6eDfDCHk?=
 =?us-ascii?Q?cBvZ4nRMASNJJSFmchKGVjByNOlZd44QC+eENv8+5nglIleN4Dn3OXLZ93X9?=
 =?us-ascii?Q?TT6G9SdKzQls5uFL4F+40E8DUmNL4LQxC0LnLmpQUD/v8mXgG0PJSzkKDjBf?=
 =?us-ascii?Q?X3qouJ1e5PPL4MivHufo0YmiDzuRtXTPzxiLkKHOah5Y1Ecym9ISjfM+TUZs?=
 =?us-ascii?Q?DfFTeosWoL6U8q7UnNao/5+wralEnssoWF2CnttPxNCWr4ctC3Tjccsv0FrS?=
 =?us-ascii?Q?6zYEEQSReHupjGNAQkIjtHj63+TZG7/zZ1DF43bGfCur8SLtH1bQqv5oHyao?=
 =?us-ascii?Q?zT/nnsds+HDZG8LvTV9l1FB7Y1nAHOMUlx5hSvP4D9ZfSwRHMzquBrD4WLS0?=
 =?us-ascii?Q?nIXd4AOH+aOVvCsuqdDePAp6p4tVDaEbhVHNgmzMNaaY9OD949GLZKW3D1z2?=
 =?us-ascii?Q?1wTXq8B/7KSzyZryhGKijLRLOKKQCtjePn3Q/gSyn9xdi+NoggVMk4YzxlVb?=
 =?us-ascii?Q?C12Lc840f+hor80uXYYfNWKZy16wLqhf2K/6CL7n2//pgUFHg6fZaK/oMU7L?=
 =?us-ascii?Q?DsA/hKEZ5iW8Xo6edRUwuxo0f6KRP1WSSMRi8fFZVoTrezV5+Lc2Aq/tbenw?=
 =?us-ascii?Q?5leJRmkeeuGaVIOOyBn+twXnxVCupxls42HlBFOjBzOi0APGHLxukO8bTum2?=
 =?us-ascii?Q?Rjvy5/yHmSsZ7yc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 23:00:26.5425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca97ab9a-cbe7-4c92-11ef-08dd5c3984b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416

During platform init, SNP initialization may fail for several reasons,
such as firmware command failures and incompatible versions. However,
the KVM capability may continue to advertise support for it. During
setup, query the SNP platform status to obtain the initialization state
and use it as an additional condition to determine support for SEV-SNP.

Fixes: 1dfe571c12cf ("KVM: SEV: Add initial SEV-SNP support")
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v7..v8:
* Avoid exporting yet another API from CCP. Instead query
  SNP_PLATFORM_STATUS to get the current the initialization state
  within KVM (Tom)
---
 arch/x86/kvm/svm/sev.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0dbb25442ec1..e21c3aa6f592 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2950,6 +2950,32 @@ void __init sev_set_cpu_caps(void)
 	}
 }
 
+static bool snp_initialized(void)
+{
+	struct sev_user_data_snp_status *status;
+	struct sev_data_snp_addr buf;
+	bool initialized = false;
+	void *data;
+	int error;
+
+	data = snp_alloc_firmware_page(GFP_KERNEL_ACCOUNT);
+	if (!data)
+		return initialized;
+
+	buf.address = __psp_pa(data);
+	if (sev_do_cmd(SEV_CMD_SNP_PLATFORM_STATUS, &buf, &error))
+		goto out;
+
+	status = (struct sev_user_data_snp_status *)data;
+	if (status->state)
+		initialized = true;
+
+out:
+	snp_free_firmware_page(data);
+
+	return initialized;
+}
+
 void __init sev_hardware_setup(void)
 {
 	unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_count;
@@ -3050,7 +3076,9 @@ void __init sev_hardware_setup(void)
 	sev_es_asid_count = min_sev_asid - 1;
 	WARN_ON_ONCE(misc_cg_set_capacity(MISC_CG_RES_SEV_ES, sev_es_asid_count));
 	sev_es_supported = true;
-	sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
+	sev_snp_supported = (sev_snp_enabled &&
+			    cc_platform_has(CC_ATTR_HOST_SEV_SNP) &&
+			    snp_initialized());
 
 out:
 	if (boot_cpu_has(X86_FEATURE_SEV))
-- 
2.43.0


