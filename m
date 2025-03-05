Return-Path: <linux-kselftest+bounces-28355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7B0A53DDA
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 00:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA030188FB54
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 23:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D7D206F1B;
	Wed,  5 Mar 2025 23:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x+VyfmeR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4FF2066FF;
	Wed,  5 Mar 2025 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215727; cv=fail; b=ovfpCxOevehTl5cVyIIVOoaTsy85fnHM/72fqoUNChb5gQaM3r1ecaqmvZ2CiBSJZaOKrIk/q5m12leAwGZVkG7CkV66t6DY/S2/yRPxj8LjvsrOsNgms2UyWDDgtu36D8Dsj5sFRST9PvAgWIbZ8K8iDPOZQSDjHX5zWQeHXTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215727; c=relaxed/simple;
	bh=/Ouu5XCq3a4k4UxbRqtM89Xhd2DI6zgv6pliaxrFYGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzwbZzuyMnXyJlD851+ZV8G7y/PHiNy+ndU6E+EvTcuZkxTJ8xrSKaXTSGuit3uYVYHsd964H5acqun+7/WNMNJjCFFfTHBf1a4f7LEXSNNz1eqqqv4T8LLZWQsj+zYgYxmXC75Xlnr+g7Cbypc4i2Q6R0JmQtVZM19n3nfIsuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x+VyfmeR; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAZqy2We3GDpclE08csQcshs2cpJ5nYcleJQqV+iym0J3H4MqGCmfB3vQW4nhxplJ3HAM4wEzK8nvUjCTsBi+Sl9Vtg5jb9jg5/vfyq2daC0h6v3y0uOAZwg9N+633GCUDDcH4SIqXCKFIkge22RdJfrrfT3OmiaWZZ5USwInfzIiNOtiPDxexUsAmIrkgj/e2dzX+bgqkrd9Xsq1ZsoYOlEf5y7W5oAmwzXa/F/CYRNx4yV8UrvCf8M1A/UopYeBFldX1kwpVNIhRes6yhFm0BehUArlMFh1KwlqloFEwIMDZaK/MQK7xWTdRXr/+3jL0PbwSOKChavc1t4rFlvyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6Gjv1pvh24smJKRL+zGAzSFWJoFqxEhFKzHsMiFV50=;
 b=uH7SjEkIcraR29hRJfPaCld8xyPqlUlINjRRQRS65wqw+LgNr0hF0/OnBLexw4VjiTCKplisjwFqTI2uqXs1yALKXIqpcEaHY8dXfkwMUq8UTWWpoot9SKNdI1X82tQtMR5jXmxDm3irozECdsOcbEfq5mr3YBIVNZMBCboxnjT+/4jG72bawQ142y14uVJh6UYmKXGo2/alMFJCndBVnrP8ZkkYUIYO0GUOENJrDmVHocPIb7ixaS0H8LbMS4inyDPnqw3NMk5MaM38SNYocwXgH/769fO5vTZplotVuYaNKIIR5E5uE1qUlrJ3MyjaIRsQvWOfquGURAutQUB+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6Gjv1pvh24smJKRL+zGAzSFWJoFqxEhFKzHsMiFV50=;
 b=x+VyfmeROxLKsc+ZM1uLrgWa93qYAlzP9db2LTadJOJ4rhsmoiFKirILal5uXGl3Ctp54FNnGENCwnxw08idsJ7HzM1zNuUVpJ3VTh5dNiF6tZ+kV9/B45CB71MI3Yn3426OKDwbjFOHS+16fjN24U2od1ZHDBqGJAo14ctVGgo=
Received: from BN9PR03CA0393.namprd03.prod.outlook.com (2603:10b6:408:111::8)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 23:01:59 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::51) by BN9PR03CA0393.outlook.office365.com
 (2603:10b6:408:111::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 23:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 23:01:59 +0000
Received: from zenon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 17:01:57 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v8 07/10] KVM: selftests: Add library support for interacting with SNP
Date: Wed, 5 Mar 2025 16:59:57 -0600
Message-ID: <20250305230000.231025-8-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 81777d01-76ca-4012-1840-08dd5c39bbd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?41HEsQlQwCr5ayXdfn0mnU7kHsATWjt9gRa27Y6yqSeMLcZoOdo1TvxC/Fis?=
 =?us-ascii?Q?sHmRC18i2j29VOhq/WbvPhYPDqY+KVDpFxsZVapo0DcVGPLSt45n1t5904xI?=
 =?us-ascii?Q?JUsJwuqjFv84UMmeDWNaxYBrKc9hL04blLZnVBRo250NnJMTzZsrBaIFiaei?=
 =?us-ascii?Q?Vk0OzUaOQ3iSjTMeyvZ/wJubngVvRl30WHiaFpG6/BmjJ+xxIixEyKP+Eh/j?=
 =?us-ascii?Q?isDrLb4WgmxogOdC8fsveUcwQCr1i9zJRK7rwmrjKFOt9sRC4uzxC8OabA7g?=
 =?us-ascii?Q?zd1y+BFy7HZxqxChS385VYHk1BiGqz6jsmXyVY0kXosS2DZTbzQsCK5yiaax?=
 =?us-ascii?Q?H7OWiYn8bGGyaY3vu+13JMnC39eVmuFfUH+J4vXisNPmr5gK/YbGopKCEvl3?=
 =?us-ascii?Q?GuO98qdG4dAkAcNEz3giyfBgpNNZJm+wWqvBnIIJpFUAE5Oo2TQdOmoFEb85?=
 =?us-ascii?Q?nmFscPrkYanKaDgnSkwXGbzdzSFTHS+C/ywvrY4z3jRLPhLCuStUxF/TF069?=
 =?us-ascii?Q?Qk3eo4U1vB494y8CIlDred8ch4mKZmekIvE6YCc+lcFhZ9zmG5aGrY4XsZRR?=
 =?us-ascii?Q?FhJNs8I9SKwmWP8MWszwRDiy6zLjBZfJmQ5XGxmpBWq1udezlnCLssYbKxC9?=
 =?us-ascii?Q?I8oqwsHiu/41oGvnLl88wvpvMCpo1syMSWhb//2CdZTuk4b5sVzG2HPuFpeG?=
 =?us-ascii?Q?8Ww4ApIbtr76+83pXzvnIzcj7E/nXlsa1WjTmn78LSbWJs7vb5ie3j6thXNK?=
 =?us-ascii?Q?1epaR62OhODZjW+sYers3ymUl1O1ftB6vYed1yj/EYmrkcLX7Y4x2XL26Mdx?=
 =?us-ascii?Q?se/RwCTznnbE67WhpouM1g+gL6Ujlc1ty6+qaPknOUrXSDs9ARm4H1F6YRZA?=
 =?us-ascii?Q?e1WkiUV5ghVChqg1V9m0ikCypFidjDMMiEszfLRm4dkOjxxdD+Hr+jElu1Y+?=
 =?us-ascii?Q?PCTb/He+vULzryBiJxNCzYeDFa3N8XRisRF5kZipFzqzl4S6sMnr0RTiRDkv?=
 =?us-ascii?Q?l1XpPUmIomv9iQ/wHaACNPdCRFO5D/EE8CKjQdKZF+pZwvMf8TWp87rvNTds?=
 =?us-ascii?Q?+XacAr4eibi7/rsi0UupUQ0eJ24i44+Lqxbj7XE4bwfsP459GZx5tkXuMO2p?=
 =?us-ascii?Q?PvwhWe8etyksookOpUMhGc+1Bl3gdl4c6eszg2f0z4UGgPrUk3C6iBC0KA0B?=
 =?us-ascii?Q?+sEYQ1lTo620NoqbjnUxB9txy23ZOGGdrAfDONlPeZGEXiwkMWArR3BxgqoF?=
 =?us-ascii?Q?/E8Ja+kVGtVNBriSooH/jdu7fEmsPkKaPleq3x97UHM6WUrlOVkNmXaUFDXu?=
 =?us-ascii?Q?xF7NORAZrEZCXKjiwS+tYqj6+Ofi6y8p+AJsWXFi4B9IBPy3skUZNGDYrZQ6?=
 =?us-ascii?Q?aleUqqIGv0Vl1x2JBDODjqoJE2ls6WPkTnQsuvaj35SQIrbtbzMVURouMWKV?=
 =?us-ascii?Q?nEVqktdPJLHST1E2pCmQKxasrW9no5MKCo2I4ZycD7IV2+PPMViAdhG9rRku?=
 =?us-ascii?Q?FTf1XGkD7emPfvc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 23:01:59.0165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81777d01-76ca-4012-1840-08dd5c39bbd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663

Extend the SEV library to include support for SNP ioctl() wrappers,
which aid in launching and interacting with a SEV-SNP guest.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
 arch/x86/include/uapi/asm/kvm.h               |  1 +
 tools/arch/x86/include/uapi/asm/kvm.h         |  1 +
 tools/testing/selftests/kvm/include/x86/sev.h | 33 ++++++++-
 tools/testing/selftests/kvm/lib/x86/sev.c     | 68 +++++++++++++++++--
 4 files changed, 97 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 9e75da97bce0..565e4d054627 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -841,6 +841,7 @@ struct kvm_sev_snp_launch_start {
 };
 
 /* Kept in sync with firmware values for simplicity. */
+#define KVM_SEV_PAGE_TYPE_INVALID		0x0
 #define KVM_SEV_SNP_PAGE_TYPE_NORMAL		0x1
 #define KVM_SEV_SNP_PAGE_TYPE_ZERO		0x3
 #define KVM_SEV_SNP_PAGE_TYPE_UNMEASURED	0x4
diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 88585c1de416..17e44fbdc2a7 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -841,6 +841,7 @@ struct kvm_sev_snp_launch_start {
 };
 
 /* Kept in sync with firmware values for simplicity. */
+#define KVM_SEV_PAGE_TYPE_INVALID		0x0
 #define KVM_SEV_SNP_PAGE_TYPE_NORMAL		0x1
 #define KVM_SEV_SNP_PAGE_TYPE_ZERO		0x3
 #define KVM_SEV_SNP_PAGE_TYPE_UNMEASURED	0x4
diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index b112f7664534..c696d10f9332 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -25,6 +25,10 @@ enum sev_guest_state {
 #define SEV_POLICY_NO_DBG	(1UL << 0)
 #define SEV_POLICY_ES		(1UL << 2)
 
+#define SNP_POLICY_SMT		(1ULL << 16)
+#define SNP_POLICY_RSVD_MBO	(1ULL << 17)
+#define SNP_POLICY_DBG		(1ULL << 19)
+
 #define GHCB_MSR_TERM_REQ	0x100
 
 bool is_sev_vm(struct kvm_vm *vm);
@@ -34,13 +38,26 @@ bool is_sev_snp_vm(struct kvm_vm *vm);
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
 void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
 void sev_vm_launch_finish(struct kvm_vm *vm);
+void snp_vm_launch_start(struct kvm_vm *vm, uint64_t policy);
+void snp_vm_launch_update(struct kvm_vm *vm);
+void snp_vm_launch_finish(struct kvm_vm *vm);
 
 struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 					   struct kvm_vcpu **cpu);
-void vm_sev_launch(struct kvm_vm *vm, uint32_t policy, uint8_t *measurement);
+void vm_sev_launch(struct kvm_vm *vm, uint64_t policy, uint8_t *measurement);
 
 kvm_static_assert(SEV_RET_SUCCESS == 0);
 
+/*
+ * A SEV-SNP VM requires the policy reserved bit to always be set.
+ * The SMT policy bit is also required to be set based on SMT being
+ * available and active on the system.
+ */
+static inline u64 snp_default_policy(void)
+{
+	return SNP_POLICY_RSVD_MBO | (smt_on() ? SNP_POLICY_SMT : 0);
+}
+
 /*
  * The KVM_MEMORY_ENCRYPT_OP uAPI is utter garbage and takes an "unsigned long"
  * instead of a proper struct.  The size of the parameter is embedded in the
@@ -74,6 +91,7 @@ kvm_static_assert(SEV_RET_SUCCESS == 0);
 
 void sev_vm_init(struct kvm_vm *vm);
 void sev_es_vm_init(struct kvm_vm *vm);
+void snp_vm_init(struct kvm_vm *vm);
 
 static inline void vmgexit(void)
 {
@@ -102,4 +120,17 @@ static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
 	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_DATA, &update_data);
 }
 
+static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
+					  uint64_t hva, uint64_t size, uint8_t type)
+{
+	struct kvm_sev_snp_launch_update update_data = {
+		.uaddr = hva,
+		.gfn_start = gpa >> PAGE_SHIFT,
+		.len = size,
+		.type = type,
+	};
+
+	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
+}
+
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index 4587f2b6bc39..a56f5164b0a6 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -31,7 +31,8 @@ bool is_sev_vm(struct kvm_vm *vm)
  * and find the first range, but that's correct because the condition
  * expression would cause us to quit the loop.
  */
-static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region)
+static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region,
+			   uint8_t page_type, bool private)
 {
 	const struct sparsebit *protected_phy_pages = region->protected_phy_pages;
 	const vm_paddr_t gpa_base = region->region.guest_phys_addr;
@@ -41,13 +42,23 @@ static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *regio
 	if (!sparsebit_any_set(protected_phy_pages))
 		return;
 
-	sev_register_encrypted_memory(vm, region);
+	if (!is_sev_snp_vm(vm))
+		sev_register_encrypted_memory(vm, region);
 
 	sparsebit_for_each_set_range(protected_phy_pages, i, j) {
 		const uint64_t size = (j - i + 1) * vm->page_size;
 		const uint64_t offset = (i - lowest_page_in_region) * vm->page_size;
 
-		sev_launch_update_data(vm, gpa_base + offset, size);
+		if (private)
+			vm_mem_set_private(vm, gpa_base + offset, size);
+
+		if (is_sev_snp_vm(vm))
+			snp_launch_update_data(vm, gpa_base + offset,
+					       (uint64_t)addr_gpa2hva(vm, gpa_base + offset),
+					       size, page_type);
+		else
+			sev_launch_update_data(vm, gpa_base + offset, size);
+
 	}
 }
 
@@ -77,6 +88,14 @@ void sev_es_vm_init(struct kvm_vm *vm)
 	}
 }
 
+void snp_vm_init(struct kvm_vm *vm)
+{
+	struct kvm_sev_init init = { 0 };
+
+	TEST_ASSERT_EQ(vm->type, KVM_X86_SNP_VM);
+	vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
+}
+
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
 {
 	struct kvm_sev_launch_start launch_start = {
@@ -93,7 +112,7 @@ void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
 	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_LAUNCH_UPDATE);
 
 	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node)
-		encrypt_region(vm, region);
+		encrypt_region(vm, region, KVM_SEV_PAGE_TYPE_INVALID, false);
 
 	if (policy & SEV_POLICY_ES)
 		vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
@@ -129,6 +148,33 @@ void sev_vm_launch_finish(struct kvm_vm *vm)
 	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_RUNNING);
 }
 
+void snp_vm_launch_start(struct kvm_vm *vm, uint64_t policy)
+{
+	struct kvm_sev_snp_launch_start launch_start = {
+		.policy = policy,
+	};
+
+	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_START, &launch_start);
+}
+
+void snp_vm_launch_update(struct kvm_vm *vm)
+{
+	struct userspace_mem_region *region;
+	int ctr;
+
+	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node)
+		encrypt_region(vm, region, KVM_SEV_SNP_PAGE_TYPE_NORMAL, true);
+
+	vm->arch.is_pt_protected = true;
+}
+
+void snp_vm_launch_finish(struct kvm_vm *vm)
+{
+	struct kvm_sev_snp_launch_finish launch_finish = { 0 };
+
+	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_FINISH, &launch_finish);
+}
+
 struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 					   struct kvm_vcpu **cpu)
 {
@@ -145,8 +191,20 @@ struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 	return vm;
 }
 
-void vm_sev_launch(struct kvm_vm *vm, uint32_t policy, uint8_t *measurement)
+void vm_sev_launch(struct kvm_vm *vm, uint64_t policy, uint8_t *measurement)
 {
+	if (is_sev_snp_vm(vm)) {
+		vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
+
+		snp_vm_launch_start(vm, policy);
+
+		snp_vm_launch_update(vm);
+
+		snp_vm_launch_finish(vm);
+
+		return;
+	}
+
 	sev_vm_launch(vm, policy);
 
 	if (!measurement)
-- 
2.43.0


