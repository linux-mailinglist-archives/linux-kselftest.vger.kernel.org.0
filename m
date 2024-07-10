Return-Path: <linux-kselftest+bounces-13521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3A492DB90
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 00:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FEE1F25D41
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 22:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D801148FFC;
	Wed, 10 Jul 2024 22:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bnTrxLu+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EF91494B9;
	Wed, 10 Jul 2024 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649183; cv=fail; b=NiBPTOUDGx4HQagweqYcnnhniQFgGqGoCYIV8Sj/0FasZ+mfoU7vkVkD2Efl92cqdCm8creMQ0J9dNVHCT/yZx1FZxTm6LlsOuaFIoU95bh2dSjQw3NSeCypIwL7ywM3sL/a5/GOdSlHhohbkj/UFsgd5SznJETDs2zgLWuAZvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649183; c=relaxed/simple;
	bh=eYW9oWp7xlAp3Fbw8UhmH2VJH/koBhf74Lg98FpK2hM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+AF9/C7u4vtwLLIuuTL0OpIwIw7ut5K/gqcUJ1iMOFrEO/rSDUX1PxR5sYB/jKPgxAmsAfB0zwtFJTBvfvISAcKA18SDTxZnv4N7OOhj/ASBy+1yxcZVwoja0HOXub9zulUuBQKtBrWK8AFMWo4LwZbfOSBYiePEFU/QL4zpFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bnTrxLu+; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+gsHM04jQCSyJkhOfiX6sG2c0D3zn0peon9EUBh49kz643ZezMEsiKkTeO7qa+hsJMxcM70U3bAhfNR4uLqEdY4K8J74Ri0Sr9QJ3w2JK9ar7GmAcl2PmccDPUWXqwk/fQpP5lnyDnk2INH5ZfQ8tpnYRg3Ch4wBJdOQiCuohlMeUgUurUkyRLac40WbPANfilvBby19wHBf9aWJy+tztO0ryLZSJvhht/Rx8pmQN4EIdoVLMsOgs4Iuhkm1lzIbWcZC9iyKrUQYTI/gN6deRZNw/1dBeXFyHCaANDnd6CozfHNVud5pUrPviROPtgGqMzujaGu/tEYqP5/QZ+wAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oc0bjhKzn8c1pi+aPWN2txh2+UfjYsqqFj9QNubWo4=;
 b=U4o7Z6Ir0aChdg5Pyq6H6zJr+y6RouopBp1HR2kspRJ15SO+UiFumdF8zyiklgZlfYDWWlcxPVJU1re/O6hl++3izxousKs3f6MPn08MYxZArNx3pZsPsjF9/3T4KUN49ugYYtLj9PYkzFZYlZl5vrlkIBunE7M2QmGO74CaQL2jIzkA8AifyLG+sdMHu+tL+Mhwot2tMUnFGI9yIV3Ynxty122Q1dmaz2/GtoN/sUkcyQglhK/rSb+D6sQn1nG8ULqgXZVFtOtFfk2UaK+/S+ifzVjskP8wvlyEbRttvc3Qjh2A1K/chI3/ixw3rNk13FsXjuYE7MO51K5v9FynHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oc0bjhKzn8c1pi+aPWN2txh2+UfjYsqqFj9QNubWo4=;
 b=bnTrxLu+LtE75jqVrzm+kQx6K8mc/ORllRcjg/7PGiVU/RMSAT4w8QjzJJrkE5Lqa46UaDdYL8Blo+JyWttnE+y7WB6n2Y+/QSjRf6MMT09I5wEdd03ynZ/2OwP0rErQx5bSXhQLhqCf65Uf81cvXwr8/q7MNNlIIuoQqOvRGJY=
Received: from BL1PR13CA0072.namprd13.prod.outlook.com (2603:10b6:208:2b8::17)
 by PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Wed, 10 Jul
 2024 22:06:18 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:2b8:cafe::ba) by BL1PR13CA0072.outlook.office365.com
 (2603:10b6:208:2b8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Wed, 10 Jul 2024 22:06:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 22:06:18 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 17:06:12 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <shuah@kernel.org>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC 2/5] selftests: KVM: Decouple SEV ioctls from asserts
Date: Wed, 10 Jul 2024 17:05:37 -0500
Message-ID: <20240710220540.188239-3-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710220540.188239-1-pratikrajesh.sampat@amd.com>
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|PH7PR12MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e43660-5dc3-4769-ee22-08dca12c8640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3WpyamhSFmaQ7EyedjceSuaeWjYShtIPbG82xWHEzA3AxnmQ0CXv7HSZoIkH?=
 =?us-ascii?Q?qbZgSfqZ7HtFi9yRTJMXzlO3KxnRol7armvGtpkxWihcqhtcSRz6SkedeCQc?=
 =?us-ascii?Q?AXtKtb3zdP+lAEF9s4YRsknJXrOcs0RqOI04a7uZNwNBqmpjO12R13WOS+zt?=
 =?us-ascii?Q?5qbYD0daSTLtat1eHT0ExbxDkrM6n5uJfaKZ6ky+ww9I0gftVTr0bngO2m21?=
 =?us-ascii?Q?hPgIsZsyXAdSuG1T50rkgxLsENoMkFeW0bSb5aYZLXGl2/bHz9Y+9PtLfmyw?=
 =?us-ascii?Q?/dcqlZVhDsPrZxw3skh2kjWTgH70Aa0Tfrft6cIqcvjEiN7hoOdBwAhThXVQ?=
 =?us-ascii?Q?GUPfNNq4eQtHZE1Lo8pv8RoFhthxbt28luXVVr61KwbUN5zQhnMX6SUMctqx?=
 =?us-ascii?Q?X4ex4Jmxrun40QkkJWtBgyg9UaNiHMuAVtxCR9wxTbgsMGAoHvlHmohKeX/y?=
 =?us-ascii?Q?72qz8qe8AFcG+B8xP2Ld0fnPCyDLxWJPkPGoO76/F/jZK2Oa45Z/vvweAL32?=
 =?us-ascii?Q?9tqhGcqL8KYGZwtGQlXN+zKFOP6mYoI2/XRbTbNfDlfLOxbBECWHznB5jKTS?=
 =?us-ascii?Q?csB9Qa9T4lXTljgJm7GPkUGfhCgDTtiKbu9P4ajIomhDL4TMBt3RgAbWUp4R?=
 =?us-ascii?Q?QP4FSw9NhUshjq9frquoKqkazf7mrDgIhRUoiq/V5QoKI0NEBzshpA37RHfc?=
 =?us-ascii?Q?geCthjb/o0hO83fB8Hu8RmJ7iEAtPU4meNQqZaGAnKVBfiOHEjXSC/AsQ1IA?=
 =?us-ascii?Q?o/tUVPF0QWALHH8UJ4FFfDv4HebUmgFeq6X0/x8HJiBPDL1hljuw07EtiHQT?=
 =?us-ascii?Q?suDZFl5uN+ToQFfPW2zyZ8H+ABDXEvQlDoH+x7lD31y2UO1D3bR4Dwhi7meQ?=
 =?us-ascii?Q?RoJKeZ63FAZO6PpUaCjZWtRkR9/zNv56+dScK8UV7u/In178LgNeZP9QTqHU?=
 =?us-ascii?Q?CHGJdO6EppwtGZWGhvuVHDKZ8moWiMC2Y1CHsaBAL8J1UL7pc+yY4GLZhbY8?=
 =?us-ascii?Q?2BuHICzkay7vGV5pcd+7r/OHf4+7HJ2iv8uyjc5BLxpdFXDbRhKoRzH7rDgg?=
 =?us-ascii?Q?MqmhYbp0SIjmHv6b2onpBDi8DTc7aA3szgKq4RLVFzYEDFl7BJ6FM5FC7Zf8?=
 =?us-ascii?Q?mdNvOU9ugPTYylBene2Zfv/51Jb0e5mMPiaeQLTRXEHvE0Aj+5fMp2Vnuz/X?=
 =?us-ascii?Q?UvsEKBLRFwDHLZoVRYdl1yQfvEcgbk1Z9eQCpW5i6fWCsPte2YtvD7zDlssf?=
 =?us-ascii?Q?S1m6nq0KztXFdFrcLPxYcRmFxo8IdkpDT6ZtEzSEuUiDWt0/3WZCeqa2S9Lv?=
 =?us-ascii?Q?iWqgEaPPIhxz6SsMz3kqDGQtZrl9HFYPXUaEz0hBAmN7jjNXb/3Oipv7ugQH?=
 =?us-ascii?Q?BUAWeuYKSNGNY6uETdYg+OknDcexR4MjQ94pB55Z/aPw1cGHaLtwPUTXDsJE?=
 =?us-ascii?Q?IJCLqxWlw7kqTMAi4mTh2f7CWDNcDAgp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 22:06:18.0615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e43660-5dc3-4769-ee22-08dca12c8640
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7914

This commit separates the SEV, SEV-ES, SEV-SNP ioctl calls from its
positive test asserts. This is done so that negative tests can be
introduced and both kinds of testing can be performed independently
using the same base helpers of the ioctl.

This commit also adds additional parameters such as flags to improve
testing coverage for the ioctls.

Cleanups performed with no functional change intended.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 .../selftests/kvm/include/x86_64/sev.h        |  20 +--
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 145 ++++++++++++------
 2 files changed, 108 insertions(+), 57 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
index 43b6c52831b2..ef99151e13a7 100644
--- a/tools/testing/selftests/kvm/include/x86_64/sev.h
+++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
@@ -37,14 +37,16 @@ enum sev_guest_state {
 #define GHCB_MSR_TERM_REQ	0x100
 
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
-void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
-void sev_vm_launch_finish(struct kvm_vm *vm);
+int sev_vm_launch_start(struct kvm_vm *vm, uint32_t policy);
+int sev_vm_launch_update(struct kvm_vm *vm, uint32_t policy);
+int sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
+int sev_vm_launch_finish(struct kvm_vm *vm);
 
 bool is_kvm_snp_supported(void);
 
-void snp_vm_launch(struct kvm_vm *vm, uint32_t policy);
-void snp_vm_launch_update(struct kvm_vm *vm);
-void snp_vm_launch_finish(struct kvm_vm *vm);
+int snp_vm_launch(struct kvm_vm *vm, uint32_t policy, uint8_t flags);
+int snp_vm_launch_update(struct kvm_vm *vm, uint8_t page_type);
+int snp_vm_launch_finish(struct kvm_vm *vm, uint16_t flags);
 
 struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 					   struct kvm_vcpu **cpu);
@@ -98,7 +100,7 @@ static inline void sev_register_encrypted_memory(struct kvm_vm *vm,
 	vm_ioctl(vm, KVM_MEMORY_ENCRYPT_REG_REGION, &range);
 }
 
-static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
+static inline int snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
 					   uint64_t size, uint8_t type)
 {
 	struct kvm_sev_snp_launch_update update_data = {
@@ -108,10 +110,10 @@ static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
 		.type = type,
 	};
 
-	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
+	return __vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
 }
 
-static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
+static inline int sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
 					  uint64_t size)
 {
 	struct kvm_sev_launch_update_data update_data = {
@@ -119,7 +121,7 @@ static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
 		.len = size,
 	};
 
-	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_DATA, &update_data);
+	return __vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_DATA, &update_data);
 }
 
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
index 90231c578aca..a931a321968f 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
@@ -14,15 +14,18 @@
  * and find the first range, but that's correct because the condition
  * expression would cause us to quit the loop.
  */
-static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region)
+static int encrypt_region(struct kvm_vm *vm,
+			  struct userspace_mem_region *region,
+			  uint8_t page_type)
 {
 	const struct sparsebit *protected_phy_pages = region->protected_phy_pages;
 	const vm_paddr_t gpa_base = region->region.guest_phys_addr;
 	const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
 	sparsebit_idx_t i, j;
+	int ret;
 
 	if (!sparsebit_any_set(protected_phy_pages))
-		return;
+		return 0;
 
 	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM)
 		sev_register_encrypted_memory(vm, region);
@@ -33,12 +36,18 @@ static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *regio
 
 		if (vm->type == KVM_X86_SNP_VM) {
 			vm_mem_set_private(vm, gpa_base + offset, size);
-			snp_launch_update_data(vm, gpa_base + offset, size,
-					       KVM_SEV_SNP_PAGE_TYPE_NORMAL);
+			ret = snp_launch_update_data(vm, gpa_base + offset, size,
+						     page_type);
+			if (ret)
+				return ret;
 			continue;
 		}
-		sev_launch_update_data(vm, gpa_base + offset, size);
+		ret = sev_launch_update_data(vm, gpa_base + offset, size);
+		if (ret)
+			return ret;
 	}
+
+	return 0;
 }
 
 void sev_vm_init(struct kvm_vm *vm)
@@ -75,83 +84,97 @@ void snp_vm_init(struct kvm_vm *vm)
 	vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
 }
 
-void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
+int sev_vm_launch_start(struct kvm_vm *vm, uint32_t policy)
 {
 	struct kvm_sev_launch_start launch_start = {
 		.policy = policy,
 	};
-	struct userspace_mem_region *region;
-	struct kvm_sev_guest_status status;
-	int ctr;
-
-	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_START, &launch_start);
-	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
 
-	TEST_ASSERT_EQ(status.policy, policy);
-	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_LAUNCH_UPDATE);
+	return __vm_sev_ioctl(vm, KVM_SEV_LAUNCH_START, &launch_start);
+}
 
-	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node)
-		encrypt_region(vm, region);
+int sev_vm_launch_update(struct kvm_vm *vm, uint32_t policy)
+{
+	struct userspace_mem_region *region;
+	int ctr, ret;
 
+	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
+		ret = encrypt_region(vm, region, 0);
+		if (ret)
+			return ret;
+	}
 	if (policy & SEV_POLICY_ES)
 		vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
 
 	vm->arch.is_pt_protected = true;
+
+	return 0;
 }
 
-void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement)
+void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
 {
-	struct kvm_sev_launch_measure launch_measure;
-	struct kvm_sev_guest_status guest_status;
+	struct kvm_sev_guest_status status;
+	int ret;
 
-	launch_measure.len = 256;
-	launch_measure.uaddr = (__u64)measurement;
-	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_MEASURE, &launch_measure);
+	ret = sev_vm_launch_start(vm, policy);
+	TEST_ASSERT(!ret, KVM_IOCTL_ERROR(KVM_SEV_SNP_LAUNCH_START, ret));
+
+	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
+	TEST_ASSERT_EQ(status.policy, policy);
+	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_LAUNCH_UPDATE);
 
-	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &guest_status);
-	TEST_ASSERT_EQ(guest_status.state, SEV_GUEST_STATE_LAUNCH_SECRET);
+	ret = sev_vm_launch_update(vm, policy);
+	TEST_ASSERT(!ret, KVM_IOCTL_ERROR(KVM_SEV_LAUNCH_UPDATE_DATA, ret));
 }
 
-void sev_vm_launch_finish(struct kvm_vm *vm)
+int sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement)
 {
-	struct kvm_sev_guest_status status;
+	struct kvm_sev_launch_measure launch_measure;
 
-	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
-	TEST_ASSERT(status.state == SEV_GUEST_STATE_LAUNCH_UPDATE ||
-		    status.state == SEV_GUEST_STATE_LAUNCH_SECRET,
-		    "Unexpected guest state: %d", status.state);
+	launch_measure.len = 256;
+	launch_measure.uaddr = (__u64)measurement;
 
-	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_FINISH, NULL);
+	return __vm_sev_ioctl(vm, KVM_SEV_LAUNCH_MEASURE, &launch_measure);
+}
 
-	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
-	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_RUNNING);
+int sev_vm_launch_finish(struct kvm_vm *vm)
+{
+	return __vm_sev_ioctl(vm, KVM_SEV_LAUNCH_FINISH, NULL);
 }
 
-void snp_vm_launch(struct kvm_vm *vm, uint32_t policy)
+int snp_vm_launch(struct kvm_vm *vm, uint32_t policy, uint8_t flags)
 {
 	struct kvm_sev_snp_launch_start launch_start = {
 		.policy = policy,
+		.flags = flags,
 	};
 
-	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_START, &launch_start);
+	return __vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_START, &launch_start);
 }
 
-void snp_vm_launch_update(struct kvm_vm *vm)
+int snp_vm_launch_update(struct kvm_vm *vm, uint8_t page_type)
 {
 	struct userspace_mem_region *region;
-	int ctr;
+	int ctr, ret;
 
-	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node)
-		encrypt_region(vm, region);
+	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
+		ret = encrypt_region(vm, region, page_type);
+		if (ret)
+			return ret;
+	}
 
 	vm->arch.is_pt_protected = true;
+
+	return 0;
 }
 
-void snp_vm_launch_finish(struct kvm_vm *vm)
+int snp_vm_launch_finish(struct kvm_vm *vm, uint16_t flags)
 {
-	struct kvm_sev_snp_launch_finish launch_finish = { 0 };
+	struct kvm_sev_snp_launch_finish launch_finish = {
+		.flags = flags,
+	};
 
-	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_FINISH, &launch_finish);
+	return __vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_FINISH, &launch_finish);
 }
 
 bool is_kvm_snp_supported(void)
@@ -190,20 +213,46 @@ struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 
 void vm_sev_launch(struct kvm_vm *vm, uint32_t policy, uint8_t *measurement)
 {
+	struct kvm_sev_guest_status status;
+	int ret;
+
 	if (vm->type == KVM_X86_SNP_VM) {
 		vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
-		snp_vm_launch(vm, policy);
-		snp_vm_launch_update(vm);
-		snp_vm_launch_finish(vm);
+		ret = snp_vm_launch(vm, policy, 0);
+		TEST_ASSERT(!ret, KVM_IOCTL_ERROR(KVM_SEV_SNP_LAUNCH_START, ret));
+
+		ret = snp_vm_launch_update(vm, KVM_SEV_SNP_PAGE_TYPE_NORMAL);
+		TEST_ASSERT(!ret, KVM_IOCTL_ERROR(KVM_SEV_SNP_LAUNCH_UPDATE, ret));
+
+		ret = snp_vm_launch_finish(vm, 0);
+		TEST_ASSERT(!ret, KVM_IOCTL_ERROR(KVM_SEV_SNP_LAUNCH_FINISH, ret));
 		return;
 	}
 
-	sev_vm_launch(vm, policy);
+	ret = sev_vm_launch_start(vm, policy);
+	TEST_ASSERT(!ret, KVM_IOCTL_ERROR(KVM_SEV_LAUNCH_START, ret));
+
+	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
+	TEST_ASSERT_EQ(status.policy, policy);
+	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_LAUNCH_UPDATE);
+
+	ret = sev_vm_launch_update(vm, policy);
+	TEST_ASSERT(!ret, KVM_IOCTL_ERROR(KVM_SEV_LAUNCH_UPDATE_DATA, ret));
 
 	if (!measurement)
 		measurement = alloca(256);
 
-	sev_vm_launch_measure(vm, measurement);
+	ret = sev_vm_launch_measure(vm, measurement);
+	TEST_ASSERT(!ret, KVM_IOCTL_ERROR(KVM_SEV_LAUNCH_MEASURE, ret));
 
-	sev_vm_launch_finish(vm);
+	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
+	TEST_ASSERT(status.state == SEV_GUEST_STATE_LAUNCH_UPDATE ||
+		    status.state == SEV_GUEST_STATE_LAUNCH_SECRET,
+		    "Unexpected guest state: %d", status.state);
+
+	ret = sev_vm_launch_finish(vm);
+	TEST_ASSERT(!ret, KVM_IOCTL_ERROR(KVM_SEV_LAUNCH_FINISH, ret));
+
+	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
+	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_RUNNING);
 }
-- 
2.34.1


