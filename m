Return-Path: <linux-kselftest+bounces-25050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C43A1AC59
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 23:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E975C1692F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 22:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FAA1D3576;
	Thu, 23 Jan 2025 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cg4jySLW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356861CDFD3;
	Thu, 23 Jan 2025 22:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669747; cv=fail; b=sjxVNyuA+YCSxfbfa2d7bXRfQ1EYq9LW5qup1p0i79GcbXmMLIaKQwy19IQdQxAfmS78D4mOeMm7YA8uO35fxz8r6+0U9VzNeGaqwyJBibAet/WAw4qA4ZTUyplfnFkcntBXE/451uA3f78lIr0cPm0OIRRb6YcE4Po1zyZ9VzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669747; c=relaxed/simple;
	bh=Ba/a+u3CzQBX2MTfiGagB8Hfkj4AB0Y7xhBwNbvqIcI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BT1GqfN2TzQh3ahc0ZPIhFkrtIiBtcINcFhK+6X1U9EVzMSCkYnkeUbpx3mV+TGACBRAeYyIw52qy9IrhC+rqgyVyk0So/CzKwxUoVvVtr+pgF6igoQDqrksAOP6KSMfL/OCEtJIMDabvSj2IFBYw6RM/JM36Zb9kGJb+N1uApI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cg4jySLW; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILNg9sBc3Ew4jo1vC5MNV7JS4Dx4bKJjLBlooBflDt335AUgQCWbo0H/GopvYPsuFuJ3eaVHSBTOSlH5MvLour6XXHRJMfsNh7O7YXP01p/TAV13E4LtifyHjrPkPTk+eseQJBqZLzPTcAiyb7I017oKQ9UEwpyrR8Q+1/eQqFGhRElgfpb+DHLYCZOPYt7QCfC4aTkNx1JqFlMG9yC2cEMj2tSKq1Q/IEdmKp/UgBI4vrxNQZxdtQs5aOdmO0gI7oVYsGLakiGTqAocVSFeehZgaBUvpL/ZOeeVgfTKQFt+2ZNU6bL+aNjhAd0TL/EHSo36jBrNXAb5H1EJPZ+Rdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtJuRok5jCqjdb6Jz7w9dLZ3t0DG1G1ioWe5IGE1f2A=;
 b=iLwujojVXwNIWHemhwQUqaypdgEyjQqABCLkCJOQcGLjzux4VsUQyLZuXqV8MaF4pbS5rO0bgVEFYj/T4Re2iX2iTh3vMZVM2EJ3WzYIGOXZ8+XYgUVJurNH5lItpdl635bA8J1n1CplrhgzRyklIXPiS+eNiDYOZjnvVRhG3vqIkUigWJIzYPzHAsvvbQpU8jb7IA1zZLw/5B5G7C+Bxpef810P3ErMNDWxfTp4JL+1UoK0cAV5geqg/AugUWdvdc5UX6MNvSQhiM1D1nccVLdZ0Z13pbqR8pDXlVA3CrHsDjnxXHGCT85X5birHGgxxgOGhssmDwDgOOX3qHdsVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtJuRok5jCqjdb6Jz7w9dLZ3t0DG1G1ioWe5IGE1f2A=;
 b=Cg4jySLWfgWU382YfKTiw5ESPgxahVh5rqNqtlFEopWniqAPd+QCiFWB7ZNEz1nETJFZZjJnlswmOZQImltVmbYMQ11TwtxSP+4aF5bzdL7SorphkRGB1uCsqpJ9WSQmRAAIifHlEEqutSROK9h/Ds1bfWfhNcmO5hPNg+V/rkQ=
Received: from SJ0PR03CA0175.namprd03.prod.outlook.com (2603:10b6:a03:338::30)
 by DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 22:02:17 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::49) by SJ0PR03CA0175.outlook.office365.com
 (2603:10b6:a03:338::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Thu,
 23 Jan 2025 22:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 22:02:16 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Jan
 2025 16:02:15 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
	<sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v5 6/9] KVM: selftests: Add library support for interacting with SNP
Date: Thu, 23 Jan 2025 16:00:57 -0600
Message-ID: <20250123220100.339867-7-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123220100.339867-1-prsampat@amd.com>
References: <20250123220100.339867-1-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|DS0PR12MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6d7af5-c514-4b82-47bd-08dd3bf999c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ITnRaDjc6v26SxCzavxZ/MBj4z18y8/WqPwLi09sGiuisS9CCYhYYILMwR+T?=
 =?us-ascii?Q?NfetvbtsSQ9bpw+EuHE7bHXd6HtQbWPf8psGhPEp6swAk2PK7V8JF5f3EQcm?=
 =?us-ascii?Q?+eq9Wk6gObrKMm9vBt9YuWZOsJNgsh1IwibKhgZZ8CCGx5jlxwufcyoHnVNn?=
 =?us-ascii?Q?L8F/QyzpDvhEdK3XO2oPIQvKnop6UOWnc5oGaanTf69eonr/1ByAkHsobc0G?=
 =?us-ascii?Q?6tDjmGj+C8dXsEgW0dNpWBS7Q5/niq3zklGt4cmd/EsmiPwRV5rf+ayJ2kns?=
 =?us-ascii?Q?ZbSewaj6isDAL8KGYhT99gI75q9GHearuChjXkchgA5I1Hw2Jk2g7OilbQRp?=
 =?us-ascii?Q?mvIbnXIEzizZBIyah06VgHFWOScEqxD5H396N6R3UJIUWk/oW8CUKVcOfsr1?=
 =?us-ascii?Q?Tjdg45Cf2KFkg75AJlKeHtLrshN5v0BlyD8eLFa//ryB1VgHSAcAq2Y20oKz?=
 =?us-ascii?Q?0CviqaUnw+Fvxqx4A9uMY7GGEz7w3Q13ek0N7+WybnfJx3THA4mycZDHkKlS?=
 =?us-ascii?Q?VjuMns5ZRVvQuTGlnKpp+9JzIKLgomcnhxJIyTS+R91GUFaRDEGwhUwrRuYs?=
 =?us-ascii?Q?ADpmv6wompcV6jaHkAw+p9lerRyelPowee3tsO4HRCw10HMOZzXu1AUhTjyR?=
 =?us-ascii?Q?KfdScblDW2UyVtXVRYXWgD5LEbw+jORuLJplMUOK4p+SlZXAAPc1sDYmaNwb?=
 =?us-ascii?Q?mL5MCz9aWx/Z3CgSzae5iohPwcJxg6E0InE7a7x3qZbFQxdiRovoznD4wGGd?=
 =?us-ascii?Q?1VG6p5pg4R9IlF5HNQ84mIcKE8ahi0+rabQzwGnmbygb7jENMqVRJH4dSxgd?=
 =?us-ascii?Q?qyA63dnYqgmAZBlAydEFC8W1cbIHpRJd5xjZ0AC8J3Yq4BvuS4nSqWSoEsLn?=
 =?us-ascii?Q?lg7erZ7ssamyyxIMmJpB1i0t3EwybpFdoTdDrcd1HuTod0EW9rb8MLCFgOVB?=
 =?us-ascii?Q?7+90knFKG9V1mT0iSE/e15FMp4u1j7L1OrqbyH9pjLQUL/0IUoq97PdZZ1vq?=
 =?us-ascii?Q?zl/Lu2pdNPHHWWGU+W9u4admfMCWpPrvjOigQmIYGdKUVLFY3x3npFacfOPi?=
 =?us-ascii?Q?jXrlGCvqBV3q3phg5iTIF7S2qPWYlHrb/9x+Ks84GTcWU441OTZEdp2EU2gb?=
 =?us-ascii?Q?2VSBZj1fbeL3RgDizG4jHNZre1aTr25Cxpm+pXxx0PU6oKnv0jljLOtAXNKJ?=
 =?us-ascii?Q?oftMv8awHRt+XpCEUKSJ58TfZaVynkxiPaTBYZZez6XN0PUpyS9gDxAweRxx?=
 =?us-ascii?Q?S2ZSzqLNFRhT0PxkoNcaGUhcAvK10S/LaZnFgiIC9gyYTPt9zpfmAKx643tt?=
 =?us-ascii?Q?IN/nqwzltU63/GgtGRzBixeD0Tc0E1UMntce93LwPSDyQw8ANiNIh1U/6wmM?=
 =?us-ascii?Q?fUIIzsEr7eb/VP5JU39DXLmvJPvm+WiYNXaNmeigShA1qbw2JdgfeipKfNMX?=
 =?us-ascii?Q?GAnB5cx93RZI1OmrzKFLQq7mebdIxANba7HHGe7FW5BptHvTsnRI58RArCUg?=
 =?us-ascii?Q?Rup2DmG3HyPd8VA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 22:02:16.7367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6d7af5-c514-4b82-47bd-08dd3bf999c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392

Extend the SEV library to include support for SNP ioctl() wrappers,
which aid in launching and interacting with a SEV-SNP guest.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v4..v5
* encrypt_region() cleanup of code flow
* minor changes to comments
---
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


