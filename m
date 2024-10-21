Return-Path: <linux-kselftest+bounces-20234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0C19A5A45
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 08:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF067B21526
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 06:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9991D07B1;
	Mon, 21 Oct 2024 06:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dvjXzAms"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946E91946A0;
	Mon, 21 Oct 2024 06:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729491879; cv=fail; b=WQZFaGOZ1gDa/4makp2I3R/iX2PoMKB6Qe3vzWSpEnsnYgoRkcgfpz3BccuNWFCU8fQPkYxf5GHnIeLkx+ajBOf8aaj8GuufKf6t8qobIZ8XveR/+/MrUz/k7aJAphSO45dTIdeLiYOqiv4VK+uoXXBRfVtvS8gbGR2iFEQei6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729491879; c=relaxed/simple;
	bh=LGVNcsmGjBeXtZsxcz3pixZ1uoltgNyVDFYA/Qr3yRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQCuC1MnHqg7nEv7Vo56oo3bl8bitd8lj+7ost/PhtZeyU8O0m0tU+gEXYkMWeTm8YhcMdt/5R28dr5OQEEVFU3M4UBuylY5+LUPc6gK2z12O0TZULF99L32JtIL8oXA19XPHME/r9xdmnuG4lXdSporngNlpTRwa0vsZdTUCpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dvjXzAms; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vd097029CXiwxwZc2/FrscIzUQHHksIbWbWIA8eKR6YhPC6KsSmrnd//6ZLYYsgct+QQGzEuIYlu9oJz32XFeivG3ZPe4r7gYV3Kn54Oai6MvpaqFKuCSkOW+49/MSTTl2nVrEJb1zIImR2oAeknPhK7C77uMdl16BL5Ukl52srdaYniV269gdfhy6PzZGwosveny/AhZHYKjxo8qhc3TVh3ZqycZkc9x/tqZms/w0XZ+k95AyqSkUxvTixD36MJSz+QvQJEGehSeCmdV/Oxzw04srtzMtQr8kv7EK+PhEdY5Hd2t5bRSQ5HMKG4Mr3TjNyiP6IwDQfladfUl0br3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1V+RgIZhLgXnF7NvBaxt5BRFn5EuMI1cUsH1AGFvXw=;
 b=Z2Xhtyap6pEuZlSqzsf+vQ4M51G77KV8zhFQ53DJ+We5fRUUBY4llphw3gHhVKR8nwALqIKM7NEYvjta+T4lHUAoW18iOIzugx8U3FMgdmmUSd/PAQAT3cecAEK1kmFZsL5BhXsmLF9TpixLlKpHLG8obBB6Mo0tIQfeJFq1tWgfa3iYbDBsRf/HQhjwEwkT6XhWsMGXUCm/xZrrUf9+3JKV6WkxY4/TQhgknQ9tcM2IFLFMTUOaPdlRbJpl1q+9E+l2oF2ekJCA90SEclqLbojFraCEN4DTjY1JXX0KlLxGnq3LiycLf4MgXBUekS3P4QXAHXykoo0Qd61tQgtKLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1V+RgIZhLgXnF7NvBaxt5BRFn5EuMI1cUsH1AGFvXw=;
 b=dvjXzAmsjHPBgxNphrocDUfaHv8TzFAYxiKtIXjI2rxUbzUiIMlS2EW4E6tzK/iewBnvSzQXeyi7zsgBJ679RI9egk4LJEiOcEHYEX+OvMM6pHT5zM733PbvavRZxcxzWpdSi+ZmP0KifY9IoHk2H9V+L6XIYDPXNP2KGwkEtzA=
Received: from DS7PR03CA0036.namprd03.prod.outlook.com (2603:10b6:5:3b5::11)
 by BN5PR12MB9512.namprd12.prod.outlook.com (2603:10b6:408:2ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 06:24:33 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::8b) by DS7PR03CA0036.outlook.office365.com
 (2603:10b6:5:3b5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 06:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 06:24:32 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 01:23:44 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <manali.shukla@amd.com>
Subject: [PATCH v1 3/4] KVM: selftests: convert vm_get_stat to macro
Date: Mon, 21 Oct 2024 06:22:25 +0000
Message-ID: <20241021062226.108657-4-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021062226.108657-1-manali.shukla@amd.com>
References: <20241021062226.108657-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|BN5PR12MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: f52781f4-636a-48bd-8890-08dcf19906f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wo8haZxF5qagx2Ss8f+fPcvHlss+8GCDWejOZr13kNj+3vg9LyOLaRzkHGbb?=
 =?us-ascii?Q?JoeX6W3SJ5fQckRqc4KndloQTEZtkfaMV7ow43bq0mwAO4QXyvNz2Dtm5Reg?=
 =?us-ascii?Q?CK7Cur0fdsA2FsyKjZRT/aNbTexH3OX2wn7LTkEkSmwrU1r79VRDc0BFjgZN?=
 =?us-ascii?Q?bACwPc/Dt45ggJIRMCAfnaJ5nojBJabX1td1eyfKtAqM4eIYeOeJAgcMOkxM?=
 =?us-ascii?Q?xe0p8CcA7J+Kg1DZ8hT7aLzke6KEbDoKl52xJJU6t0siFr/M5xIk0q28IWYb?=
 =?us-ascii?Q?PLm7mAkMKK7CL4scnmrxeQX80B5OvD8YVDyfDcrr9j5FnYlxbyTvfAoU+BLY?=
 =?us-ascii?Q?dFvUXbSup0ixeTtMxvDz+RiIWj5dLG7Vrgn3HypMsq48YShkCq14WJeOQQvb?=
 =?us-ascii?Q?wnyfLK8skZNKdNwOQxcdIjm9aqjwh2/X/Xu9pC06Bxv7Ca85gdLgJqpUVbhN?=
 =?us-ascii?Q?T2CHjjlHDJXPXSH0/GKq/np2obFSXWhVzNJJhCEtAVdZJvP0l/5QcBLA/tpi?=
 =?us-ascii?Q?DpuC6xE4umLzSyC5OxStallMvalQRijpQ1iZLUXl+/z+iYUU6F2eivXOOBXv?=
 =?us-ascii?Q?TxE0gT3nlvRmOH6+JAWnue4IQLyduKvJr1Xn4lCRbz6NzGccs/suUat9OKsY?=
 =?us-ascii?Q?ubzDsWJf7BBCoSTSKdnLPDceAO1mRGOY4uihB4K2Ye8P7/e7nVpipog3zh1w?=
 =?us-ascii?Q?wfEbv9DwSd5J6oA25C+iu+PtW31UYM7IcwUTk1Ku1C+hVkEDtEhETogWvWcl?=
 =?us-ascii?Q?ROGdmv3/9z9c9NgmFhWk75GHKWhxQH2qN3LmaGqw+n8I0V1+h8G+UQNFjjPv?=
 =?us-ascii?Q?zPnNWMKGw3UnQuBKEkDW799+3x86+L+rKAHnsr+2jByWqMNRRpTnVVqIzIBT?=
 =?us-ascii?Q?et884rdwHuK6huBRj7jCktGq/VvRxZacE9E3l4lrONUMJqv4Xv4JwhWvcLZY?=
 =?us-ascii?Q?S5i0UgEeDpige8LRV/+inCE3+SxCGdtVEOwG4Dv1PFm8b8/fdIJ7sQc3GKlw?=
 =?us-ascii?Q?1EbEfFTNRUGh46RYYT0yLi2LChdmw+dCr9Dbszn2QpB6flHgnACkqTFK1Z/Z?=
 =?us-ascii?Q?72yNHJzzQ7Sp/2zrGID3/+jUHa9t5ZQLhMsex30ffq8LqQD64zGgErLIwqF9?=
 =?us-ascii?Q?tNzDtXRntHar6ej63Sn0zAuQQoa2jBsBIEazt7rtSZPE8M7SpULQ/pdbKyfx?=
 =?us-ascii?Q?TMW/YPjV/mJTzun+5uv2kZjr/760BSMg1a2U6bApn6j7SH9zTtcnhvMP9W+V?=
 =?us-ascii?Q?Fv4OlUw4S1sKGash5NVZp3b2WnyVZPd2UhvAChF3Dc80I1ZVbz8KD43z0Bpa?=
 =?us-ascii?Q?UVsOreiTmPgtRnyep5dQEhD6EkjnZBoZojsgIV3A5k5Q80FRq96kW1UJZ87/?=
 =?us-ascii?Q?OFI6HA3nneu+qgdCn7KzOSXCgbqLIV2wcP16wdVjsy2hGWybaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 06:24:32.7456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f52781f4-636a-48bd-8890-08dcf19906f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9512

Convert vm_get_stat() to macro to detect typos at compile time.

Add a concatenation trickery to trigger compiler error if vm stat
doesn't exist, so that it is not possible to pass a vcpu stat into
vm_get_stat().

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  | 33 +++++++++++++++----
 .../kvm/include/x86_64/kvm_util_arch.h        | 16 +++++++++
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 5dd3acf174f8..bd486a2899ca 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -539,16 +539,35 @@ static inline int check_##type##_##stat##_exists(void)	\
 
 #define STAT_EXISTS(type, stat) (check_##type##_##stat##_exists())
 
+#define DEFINE_GENERIC_VM_STAT					\
+	DEFINE_CHECK_STAT(vm, remote_tlb_flush)			\
+	DEFINE_CHECK_STAT(vm, remote_tlb_flush_requests)	\
+
+/*
+ * Define a default empty macro for architectures which do not specify
+ * arch specific vm stats.
+ */
+#ifndef DEFINE_ARCH_VM_STAT
+#define DEFINE_ARCH_VM_STAT
+#endif
+
+DEFINE_GENERIC_VM_STAT
+DEFINE_ARCH_VM_STAT
+
+#undef DEFINE_GENERIC_VM_STAT
+#undef DEFINE_ARCH_VM_STAT
+
 void __vm_get_stat(struct kvm_vm *vm, const char *stat_name, uint64_t *data,
 		   size_t max_elements);
 
-static inline uint64_t vm_get_stat(struct kvm_vm *vm, const char *stat_name)
-{
-	uint64_t data;
-
-	__vm_get_stat(vm, stat_name, &data, 1);
-	return data;
-}
+#define vm_get_stat(vm, stat_name)				\
+({								\
+	uint64_t data;						\
+								\
+	STAT_EXISTS(vm, stat_name);				\
+	__vm_get_stat(vm, #stat_name, &data, 1);		\
+	data;							\
+})
 
 #define DEFINE_GENERIC_VCPU_STAT				\
 	DEFINE_CHECK_STAT(vcpu, halt_successfull_poll)		\
diff --git a/tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h b/tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h
index 3cdc3c856ed2..6341c786dc9a 100644
--- a/tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h
+++ b/tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h
@@ -48,6 +48,22 @@ do {											\
 	}										\
 } while (0)
 
+#define DEFINE_ARCH_VM_STAT					\
+	DEFINE_CHECK_STAT(vm, mmu_shadow_zapped)		\
+	DEFINE_CHECK_STAT(vm, mmu_pte_write)			\
+	DEFINE_CHECK_STAT(vm, mmu_pde_zapped)			\
+	DEFINE_CHECK_STAT(vm, mmu_flooded)			\
+	DEFINE_CHECK_STAT(vm, mmu_recycled)			\
+	DEFINE_CHECK_STAT(vm, mmu_cache_miss)			\
+	DEFINE_CHECK_STAT(vm, mmu_unsync)			\
+	DEFINE_CHECK_STAT(vm, pages_4k)				\
+	DEFINE_CHECK_STAT(vm, pages_2m)				\
+	DEFINE_CHECK_STAT(vm, pages_1g)				\
+	DEFINE_CHECK_STAT(vm, pages)				\
+	DEFINE_CHECK_STAT(vm, nx_lpage_splits)			\
+	DEFINE_CHECK_STAT(vm, max_mmu_page_hash_collisions)	\
+	DEFINE_CHECK_STAT(vm, max_mmu_rmap_size)		\
+
 #define DEFINE_ARCH_VCPU_STAT					\
 	DEFINE_CHECK_STAT(vcpu, pf_taken)			\
 	DEFINE_CHECK_STAT(vcpu, pf_fixed)			\
-- 
2.34.1


