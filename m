Return-Path: <linux-kselftest+bounces-25606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0E2A266A5
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 23:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC461611A7
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 22:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F57520FA96;
	Mon,  3 Feb 2025 22:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KAaOZkT2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99AC1FF7B4;
	Mon,  3 Feb 2025 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738621956; cv=fail; b=KVnqTZBPCGkLLvZLvlusZLi33a3k9rDlGYbH5OnY0qoxhiTsqMD3Ts9D5qcjzsLAeqr7fJf6Gy2XANEnIWHBmTr14JAtjawwDm1+AYN3RNp+QyquTd1/T1lWYiRIeyHkF7IqQLiEMIPbQHACcEVtUtcMr4Q/u8QRD2NvECxrnw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738621956; c=relaxed/simple;
	bh=R0wWoETAu/rG/sVt8eKTjdHmtOVoBleYgNCRl6Eekuc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCJ4OCkbXlP23j7IWQAe7kE4cV2+5SqqksW3a3o5zSjEx4EQH1sfDCY4ITF+IZ0q+SojDCLWquCwvWEAdZSy65e9p4vr2K44OKb5atnweG+P4Te9WE8Gk/MDECReCNBL9KyiTm4zYVZgh1/k/juIZ0xZxvX9gQ1n/Mu9Lgrke5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KAaOZkT2; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M69jcw8dOI6Hp5VC27e01qEtjCUL/uQYD4cj2U9VTo2KibSNn2mD4x9FeDAKCxPsiymK7JRuVAoHfuyu4fIcBsaOTNePzN0xLeCKuAj5RMzKrlyhAAta3jvCVc3Qk3CRm2KgDPUKHyenfLQ92/f2GHpwd6qm+kZVpwN3jQbtSk1DkK2iXjE10J9wfZhzIG6ruoyaK4KEiNnN1ftMcM/K2YN6Igy4qIh1kOtVOtROHGqN+tNMwExiKG3Pa7vJ5Rx/BNwfSxXmfsh+K9kEZer2Bpon4qiJJH1ohuzv73IWNtxYrbV8MFoZt4fkRLv5CKK0IhQVKIOXiLlwqPN45WXaKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8k+fsTkWW+QLt8Ur3ZzC8OGpQYWHzq3HmAuL/6QstE0=;
 b=uafnOiAHpMzRwK1kuwiDoAT0t7MUG6hStc1I0DEeC8dLvKj/EQn1oXbu6osDLzVKRE54EBwZSCd7PyQ/ae7y7CDeDPIuK2l9WvIQ1aZkyKZqu0wK0ee3niVXBBK9VhqI/QiLtefOil8wV8SWc7dXbkemYHmoyeDcPOOGoTi0eT/S5Qzd36bs4RFindKAvEbR0VvznfOlgI+adIdV2nZo+dbVEaB2FXXr9ARpi1HlMD1RqTT2P49cWZz37Kv+JN/6c5UVsUqrZL7/JGFgiSxK/qqT0x9o7+6VwdDaRaHisdK60BozzuMZLSda7ye2IyFfhLKGPUqQy+gnDBFAXGmuqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8k+fsTkWW+QLt8Ur3ZzC8OGpQYWHzq3HmAuL/6QstE0=;
 b=KAaOZkT2JCGd00YzcOTZ6quiMKKDdulL+zZkvAw+e2ktb7zZW3Ghl8Eeiyv2w/cIjfYxFwzOyIjUrnESALmo6pbMmbBIEBpEfBH7J0tmzBvqBMxo/CKTyxholblseKfmQ1LRNLZpP3kDfNT++JS3XbQb9Kv8K1ElyMuf5YDQKM0=
Received: from SJ0PR03CA0189.namprd03.prod.outlook.com (2603:10b6:a03:2ef::14)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Mon, 3 Feb
 2025 22:32:30 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::de) by SJ0PR03CA0189.outlook.office365.com
 (2603:10b6:a03:2ef::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Mon,
 3 Feb 2025 22:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 22:32:29 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 16:32:28 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v6 1/9] KVM: SEV: Disable SEV-SNP on FW validation failure
Date: Mon, 3 Feb 2025 16:31:57 -0600
Message-ID: <20250203223205.36121-2-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9e4046-a3fb-46c9-1b6e-08dd44a2a4ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ihRIAb+1MF29PDj+FSi7Mge/ppGhymaAG6X6g6Z7Yylq/UDqCfei7MBFQo1O?=
 =?us-ascii?Q?EWCnDZziwBCpV92wC39x6e1bvQFvyXs5KSspO/pNQMzez3+u+f1D11xo7NhQ?=
 =?us-ascii?Q?xUigv7pjRqnW6HkNOVAAsXefY9JEH5LPUgremX3mUL8J5wtH/BnOmLnhhJFp?=
 =?us-ascii?Q?FiM+cqU06JyFcqKj/XBs4WjlSOFzk8MwfHM3CqI2Ycb31oZITXu5tAYakzfl?=
 =?us-ascii?Q?S4S6uuCV5HxZedEeVO8Auz0ty0f5s6aVdbtvmT4+ppbTdiMfS22dcrA4HcJj?=
 =?us-ascii?Q?UhO0v4e8Xn7rsnrANKfAuEIfPopUGvZeql8Oyjm2QE4TqEPm1/a3AURJRjH7?=
 =?us-ascii?Q?kyMp/u5u/Z0k39D9RAwz7CWsJRy5ovgP1Iz+p6DzB8YbfL4uHtMvTaPR/PSd?=
 =?us-ascii?Q?GBqUp7Xm9J1sF+k+Zt4BytP0JGYMPzOsWuq1J74p2QxbLp+Lso5PzT2GchJH?=
 =?us-ascii?Q?USUD1ZYf8ra8Rzal9VQfU9fW3pfTPbaQYH7ZR1vDTEALCe5TrBncIo1ySf3z?=
 =?us-ascii?Q?BgDiAkI3lLO7KlTcvrbmWSuiqVhodH5NsKuLSA7hlVhm3A+qnK9FQXDzf6Kf?=
 =?us-ascii?Q?Szg8UITicOawM7l1rHZWNmPLQnSztx4/S0nRnRUP59atkLwIMl/J/k+v9y6j?=
 =?us-ascii?Q?KGiRfsGQ/I/Z8R8wPL1EGzZdFdlI1W3Ixk602e/PYSaHTBaHVRno6Tg0ckPK?=
 =?us-ascii?Q?g+kGbnJjHixYkXSe/GcTyLLEe5F0xE4X3TuOgFoYNc/nM2NV3GstsMrgZkRa?=
 =?us-ascii?Q?5mQ6S9ysOLIaa73Aqx7Krx2clF9xEqeLRhQ7P2H1SErNXZ6zI7f/tiVQEnD9?=
 =?us-ascii?Q?Blga+uBQf7EDeETuIVa9ZJ7nSb8HfZcad625OEKKUUo3/cwIwEwO+tdmYOmW?=
 =?us-ascii?Q?kA86/PJZWGYrt6IQLK0CwcPnavEiNyVe+xaiL++WAlonPAKeskHL3QUrU6QS?=
 =?us-ascii?Q?/o5oypzRXnhFRtsNWauNJF2YfEWICRd7k7mNAre4R1tEIU7EY0S/1gn+56/B?=
 =?us-ascii?Q?23FOITrphQ+7WfitOVcFeN5GeOcyNaDxWdDnWAm4LO60hkRnLHYyexpFFxzL?=
 =?us-ascii?Q?KifzjRClU30Mv9ONao5BFpOrV+T00BEtAIfSinOiC78DsTMjMg4DC23X/P/p?=
 =?us-ascii?Q?eFxWFkGvB5c9g/k4c3X0KKUmDSGVBoOtS5216PXw+iC4ZDETjp+Z9d8MYcpl?=
 =?us-ascii?Q?7CiS00Z9No4Zd/kXhUrkSjYnki/r4NCRUWeP8DyQwYp9yXzH8uufzyI2gAGQ?=
 =?us-ascii?Q?Qpbg/nvY97GfVop6Zin5joW2MGwQjclFEPVHtn4I2z0IriKIS79tYGr9q+Yf?=
 =?us-ascii?Q?bjKlamTN2PpfT7QfHy8kOvsCRusR8w83j+p6kUVOWOdrOpXoYJJltS8pBJ69?=
 =?us-ascii?Q?/e981DAZajH6P7rwBVOsT97KaO9ZzwJDPeCo/hhauFoYbIbpTF3GkAzueyRN?=
 =?us-ascii?Q?Ph6r1FctbUD4QtsAN1DmahdyR/aO12YPc8+59j7Xr/gAlOXoEvqetzZexxGD?=
 =?us-ascii?Q?My1gCP/e6IrbQ4o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 22:32:29.4123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9e4046-a3fb-46c9-1b6e-08dd44a2a4ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440

On incompatible firmware versions, SEV-SNP support is pulled and the
setup is not performed. However, the platform and subsequently the KVM
capability may continue to advertise support for it. Disable support for
SEV-SNP if the FW version validation fails.

Fixes: 1dfe571c12cf ("KVM: SEV: Add initial SEV-SNP support")
Suggested-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v5..v6:

* Collected tags from Nikunj and Srikanth.
---
 arch/x86/kvm/svm/sev.c       | 4 +++-
 drivers/crypto/ccp/sev-dev.c | 6 ++++++
 include/linux/psp-sev.h      | 3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0f04f365885c..b709c2f0945c 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3040,7 +3040,9 @@ void __init sev_hardware_setup(void)
 	sev_es_asid_count = min_sev_asid - 1;
 	WARN_ON_ONCE(misc_cg_set_capacity(MISC_CG_RES_SEV_ES, sev_es_asid_count));
 	sev_es_supported = true;
-	sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
+	sev_snp_supported = (sev_snp_enabled &&
+			    cc_platform_has(CC_ATTR_HOST_SEV_SNP) &&
+			    snp_fw_valid());
 
 out:
 	if (boot_cpu_has(X86_FEATURE_SEV))
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index af018afd9cd7..b45cd60c19b0 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -122,6 +122,12 @@ static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
 	return false;
 }
 
+bool snp_fw_valid(void)
+{
+	return sev_version_greater_or_equal(SNP_MIN_API_MAJOR, SNP_MIN_API_MINOR);
+}
+EXPORT_SYMBOL_GPL(snp_fw_valid);
+
 static void sev_irq_handler(int irq, void *data, unsigned int status)
 {
 	struct sev_device *sev = data;
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 903ddfea8585..e841a8fbbb15 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -945,6 +945,7 @@ int sev_do_cmd(int cmd, void *data, int *psp_ret);
 void *psp_copy_user_blob(u64 uaddr, u32 len);
 void *snp_alloc_firmware_page(gfp_t mask);
 void snp_free_firmware_page(void *addr);
+bool snp_fw_valid(void);
 
 #else	/* !CONFIG_CRYPTO_DEV_SP_PSP */
 
@@ -979,6 +980,8 @@ static inline void *snp_alloc_firmware_page(gfp_t mask)
 
 static inline void snp_free_firmware_page(void *addr) { }
 
+static inline bool snp_fw_valid(void) { return false; }
+
 #endif	/* CONFIG_CRYPTO_DEV_SP_PSP */
 
 #endif	/* __PSP_SEV_H__ */
-- 
2.43.0


