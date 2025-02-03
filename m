Return-Path: <linux-kselftest+bounces-25611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B3FA266BA
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 23:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8DB165A9D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 22:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071A021148F;
	Mon,  3 Feb 2025 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o8MEgKXi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A97A211471;
	Mon,  3 Feb 2025 22:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622021; cv=fail; b=HZy1nTu7PyzvgYQt3DMRHnxyIxSrHJZgfBYt3cpam1Xqf9WKz96OWViYX7B/IS+iEK8ea9UnjBgBAl+1vO1Rk55s/ZFahTzqyCD5ozbQXXAbkQmOJbVrAarHbg4iBi8ii0Rhl5i2s5Ya8A+2VH7VkqgzcIicvEGQUoA4aD1fl7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622021; c=relaxed/simple;
	bh=NCE3S6EPDny2AwJQItQMRPIy96NGMIj2w1WxZ1aAm5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlqACprBIjAu+GXtepBLM/0PyvHWQxOKENg3CxCCNvMNd9i33bJI1xQOnbPKkEY5Zec9h6e2X+rIqP7G2D8Nsj8YS/3mX43+W/S4pnVbmjzrb8Bc2qyT/Xd0OVHT7Xg30ksOuH179kQgqsGGkYcIsAC4fSoW9j41S3ZcSVSS/iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o8MEgKXi; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3gUV7H2HtHLVXU0DHmTS96Yc8u5vOwpMkVL75BOiB59I2sZceiKU32jP1EFhRhAvpl8m04f27pt4tf6rLJ5yMFjY03/8FMjr5DC6rgiT1CifwuOg0hQV76wOcKnFxNHdbHRo5Vq1oim0u8ufczhH4i+a0h4mBst39IfJvdlD44vkS3jxHHKvUz5eaph7RfABsT/pfz6j2+sRM6OrVD5h+Umc+TyB+0Y/xQXpqGsFcKn7jmq4YBp8m5wB/Iz1f8TCt1t3giL1G5Ura1WYq7s0sgp/aecIOCPVuWqstkEmQCi6vz5vgPwcsCKIWav0H3vP8IeLAw9++jVMGAYus7G8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scG/YWKkmWSWmBdktSKvge4tOfw/hd/lidIATv3qGPo=;
 b=J+BaYGATdwxzdTI5KzIX/vK/aUKNqYrPyQFSlMYjbM4Q5iz/VcEAvTnj0CUQrvFb7lpxNlJff6JGzTc0hMuImmVt0mn2+so9UpOkqA98kI908hLgxsxuwrltRJHrcQBkrosGo1bKOOXE3cbfgCG9R+vVVlnzoyV8hd9YR3FNp7e/bYARU2fDUCMu8H4+SDIkp0Dr2K7UXS7nC82QFCH1zgzwpmBsxvXfLpizRaUlxjv3pQS3ZKmDAUj8gyjSM6IPvN/7WLcW7qV2IQ8i8NKkAt4niJca7jW/Oi6OsztH6j7ZMKZdE8behC1V63SXPdNi4hglPLvrlVcoTnC929WDYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scG/YWKkmWSWmBdktSKvge4tOfw/hd/lidIATv3qGPo=;
 b=o8MEgKXiEYj29qNkGXCj2T/tYuE8zCgr/oHMbkqZvxbA+w+F5iE9fRtrk1GpMtp43nyK11U5M9e42UgH2NOjrnaIRbW/Sdli8kk4pMaATFeGnte/8NmlyLW8EMZZ53LSbEIx9poNIi5s3vmEB14tO6zuPTpy4H0qajfmA9jmrs0=
Received: from SN4PR0501CA0115.namprd05.prod.outlook.com
 (2603:10b6:803:42::32) by SA0PR12MB7092.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 22:33:37 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:803:42:cafe::2e) by SN4PR0501CA0115.outlook.office365.com
 (2603:10b6:803:42::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.8 via Frontend Transport; Mon, 3
 Feb 2025 22:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 22:33:37 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 16:33:36 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v6 6/9] KVM: selftests: Add library support for interacting with SNP
Date: Mon, 3 Feb 2025 16:32:02 -0600
Message-ID: <20250203223205.36121-7-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|SA0PR12MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: e8af336e-a134-4bae-1d0a-08dd44a2cd47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+XnQjTctRoSiXU7m0ZVUVssdRRkPpqXzbTAly5TvtFhBGPcQApZnbRgcnZrA?=
 =?us-ascii?Q?rjF4Zc7yDQEyaBoSXxP9Zy+C3qZNgxOgYZmEwMzTXxo/aJyhtfqjmFuSJC99?=
 =?us-ascii?Q?vNEZxwDm9hzlpaiZWDteu0dQVee9J7xDHXqmZtY635LnwYkIIVJLhFe2fRV8?=
 =?us-ascii?Q?gsAR5Tq67t7NalhZm9z7VT9y8i46O/GfgcAeR7Qp993LjujnJgJvle1Nb4jz?=
 =?us-ascii?Q?sehYFyx8z309leAc4qUVJGzF3mKTfoRVpPQm7thiDCU2K8geQDuTda7hBCqH?=
 =?us-ascii?Q?bSudEvyAOoqF5jLKKftiVB4+V79WHXP8TIiaKtH+RJ53WEtPfhwy+H0GAxar?=
 =?us-ascii?Q?O8/K/WR2KS6P+j9LEFvwscHXD9fh2zA3l8GKC+FBZT1iD1DSJTfKMhHwx6mE?=
 =?us-ascii?Q?QdKoGjcFEc9y7LA2mlmtkZ6f2vmOMVWFA4khSU9hwhVpCTilRsBNg21FgEpg?=
 =?us-ascii?Q?Sp6qkZDXbCPelFplnwbJEzDI+rgw8MXkwiJp6y6vlGiF7lnRwOYNQl3QAaZ7?=
 =?us-ascii?Q?NeFj62u3lCCIVaXJVcBBDciP6hTsS+jjQF636RS10mMD5qKFzhglGKHng3bo?=
 =?us-ascii?Q?W2n6K5Mwypq04lqjf2oGQLyv0ShIh1aGwXXBwdQb4RjEHaUphXiz3KnuSYl1?=
 =?us-ascii?Q?+/BjBXq6QaVADn255Bl2f3d6ENTAqCh2PAXC7PK4Lz34xxyg6GTIMd8PbAiT?=
 =?us-ascii?Q?aYfSRgjFVN4LN7jE4+mxs+9Gko3FJq3l0Y4cVT5hmCazF1hBP7Qk/3hb/TbX?=
 =?us-ascii?Q?EC1QHT/uC+HYLuXuSxK2EbdjBspYTQ90uMmXWjXjTdEDs/st/oSEI+T3A2K3?=
 =?us-ascii?Q?70toMEY4cnzDSJDE+yDRG7kzL+OMlHAHrDfEB+WRASDIwkW4Z+lDxotV6XX/?=
 =?us-ascii?Q?JTp1QWhM6pdaPUhW3SlVlcSU3Xu4f6yarqLCV8ou0ffXJJxcwkntsjhzg9eM?=
 =?us-ascii?Q?HgiK/oSNP+1KwkXlHfz8y7e8ZfFUMP6DrnYhi9XSJKnjGY2GNb3t21puboNp?=
 =?us-ascii?Q?dsElYpGYKsqjTIt9mfJp7HFYmouKWjjxo5S6EEv2dasc/n+BZktlsbfDEZu2?=
 =?us-ascii?Q?zpRxQUwVcXY5crCfARHDdT8lTlcDGEcy4v/TSYqd6GhcqmZ3ur15ZSwjw0Ou?=
 =?us-ascii?Q?cUlc+udnSmzSbbcRJ6x1XfgWboXHdqGyyZQbxH4MSVQRdVV8nepuSF6hFcmI?=
 =?us-ascii?Q?4UYTp5DwGMiGhjwtH9aNKcqY3xhDJicBIJrMz9+c4jMO0HAAHKR4K+5C/RsN?=
 =?us-ascii?Q?otkT3kKM0Jdtl/+BT11XOF5deaYKKB/63JTCAQbpKtuiI1DFiVIJinUWBIx6?=
 =?us-ascii?Q?AtmBwo1X4zRoeBdPTN9Zrtpu3V8UbNGv8O2rn4+g/leVfnTLiRN9dtmXMYn4?=
 =?us-ascii?Q?6tOyXj1LmP0scxCA4cvyqL816fR4b5CiInlNyB44j5DsBhXUn2CDfxHGLYVB?=
 =?us-ascii?Q?c6QOOo3WaBMbyJCdnfQ0B5SpGlYIIXtcBb3/iBO+2knkKm0kVQKRJwm+ALEJ?=
 =?us-ascii?Q?xzAcjk2qCmldhQk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 22:33:37.4921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8af336e-a134-4bae-1d0a-08dd44a2cd47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7092

Extend the SEV library to include support for SNP ioctl() wrappers,
which aid in launching and interacting with a SEV-SNP guest.

Tested-by: Srikanth Aithal <sraithal@amd.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v5..v6:

* Collected tags from Srikanth.
---
 tools/testing/selftests/kvm/include/x86/sev.h | 49 ++++++++++-
 tools/testing/selftests/kvm/lib/x86/sev.c     | 82 +++++++++++++++++--
 2 files changed, 125 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index faed91435963..fd5d5261e10e 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -22,9 +22,20 @@ enum sev_guest_state {
 	SEV_GUEST_STATE_RUNNING,
 };
 
+/* Minimum firmware version required for the SEV-SNP support */
+#define SNP_MIN_API_MAJOR	1
+#define SNP_MIN_API_MINOR	51
+
 #define SEV_POLICY_NO_DBG	(1UL << 0)
 #define SEV_POLICY_ES		(1UL << 2)
 
+#define SNP_POLICY_SMT		(1ULL << 16)
+#define SNP_POLICY_RSVD_MBO	(1ULL << 17)
+#define SNP_POLICY_DBG		(1ULL << 19)
+
+#define SNP_FW_VER_MINOR(min)	((uint8_t)(min) << 0)
+#define SNP_FW_VER_MAJOR(maj)	((uint8_t)(maj) << 8)
+
 #define GHCB_MSR_TERM_REQ	0x100
 
 #define VMGEXIT()		{ __asm__ __volatile__("rep; vmmcall"); }
@@ -36,13 +47,35 @@ bool is_sev_snp_vm(struct kvm_vm *vm);
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
+	bool smt_active = false;
+	FILE *f;
+
+	f = fopen("/sys/devices/system/cpu/smt/active", "r");
+	if (f) {
+		smt_active = fgetc(f) - '0';
+		fclose(f);
+	}
+
+	return SNP_POLICY_RSVD_MBO | (smt_active ? SNP_POLICY_SMT : 0);
+}
+
 /*
  * The KVM_MEMORY_ENCRYPT_OP uAPI is utter garbage and takes an "unsigned long"
  * instead of a proper struct.  The size of the parameter is embedded in the
@@ -76,6 +109,7 @@ kvm_static_assert(SEV_RET_SUCCESS == 0);
 
 void sev_vm_init(struct kvm_vm *vm);
 void sev_es_vm_init(struct kvm_vm *vm);
+void snp_vm_init(struct kvm_vm *vm);
 
 static inline void sev_register_encrypted_memory(struct kvm_vm *vm,
 						 struct userspace_mem_region *region)
@@ -99,4 +133,17 @@ static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
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
index 280ec42e281b..17d493e9907a 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -31,7 +31,8 @@ bool is_sev_vm(struct kvm_vm *vm)
  * and find the first range, but that's correct because the condition
  * expression would cause us to quit the loop.
  */
-static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region)
+static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region,
+			   uint8_t page_type)
 {
 	const struct sparsebit *protected_phy_pages = region->protected_phy_pages;
 	const vm_paddr_t gpa_base = region->region.guest_phys_addr;
@@ -41,13 +42,35 @@ static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *regio
 	if (!sparsebit_any_set(protected_phy_pages))
 		return;
 
-	sev_register_encrypted_memory(vm, region);
+	if (!is_sev_snp_vm(vm))
+		sev_register_encrypted_memory(vm, region);
 
 	sparsebit_for_each_set_range(protected_phy_pages, i, j) {
 		const uint64_t size = (j - i + 1) * vm->page_size;
 		const uint64_t offset = (i - lowest_page_in_region) * vm->page_size;
 
-		sev_launch_update_data(vm, gpa_base + offset, size);
+		if (is_sev_snp_vm(vm)) {
+			snp_launch_update_data(vm, gpa_base + offset,
+					       (uint64_t)addr_gpa2hva(vm, gpa_base + offset),
+					       size, page_type);
+		} else {
+			sev_launch_update_data(vm, gpa_base + offset, size);
+		}
+	}
+}
+
+static void privatize_region(struct kvm_vm *vm, struct userspace_mem_region *region)
+{
+	const struct sparsebit *protected_phy_pages = region->protected_phy_pages;
+	const vm_paddr_t gpa_base = region->region.guest_phys_addr;
+	const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
+	sparsebit_idx_t i, j;
+
+	sparsebit_for_each_set_range(protected_phy_pages, i, j) {
+		const uint64_t size = (j - i + 1) * vm->page_size;
+		const uint64_t offset = (i - lowest_page_in_region) * vm->page_size;
+
+		vm_mem_set_private(vm, gpa_base + offset, size);
 	}
 }
 
@@ -77,6 +100,14 @@ void sev_es_vm_init(struct kvm_vm *vm)
 	}
 }
 
+void snp_vm_init(struct kvm_vm *vm)
+{
+	struct kvm_sev_init init = { 0 };
+
+	assert(vm->type == KVM_X86_SNP_VM);
+	vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
+}
+
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
 {
 	struct kvm_sev_launch_start launch_start = {
@@ -93,7 +124,7 @@ void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
 	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_LAUNCH_UPDATE);
 
 	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node)
-		encrypt_region(vm, region);
+		encrypt_region(vm, region, 0);
 
 	if (policy & SEV_POLICY_ES)
 		vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
@@ -129,6 +160,35 @@ void sev_vm_launch_finish(struct kvm_vm *vm)
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
+	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
+		privatize_region(vm, region);
+		encrypt_region(vm, region, KVM_SEV_SNP_PAGE_TYPE_NORMAL);
+	}
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
@@ -145,8 +205,20 @@ struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
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


