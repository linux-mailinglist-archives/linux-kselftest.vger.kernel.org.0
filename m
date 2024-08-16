Return-Path: <linux-kselftest+bounces-15565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E2895516F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 21:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC8328940B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 19:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0CD1C688C;
	Fri, 16 Aug 2024 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cGlsRLnL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB251C57B6;
	Fri, 16 Aug 2024 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836305; cv=fail; b=S1ya3dYOU8ICJ58RL0sXJejq0K0IVZCr+EhtGQg9fKyVy65o8hUK99hpe4cflQwjQnQlYqXLEaUhBTrE7zMrISYQEAdPYuZBjqW4RhGHpvb2z3dzeNxnA4fKnJGc7yi5i8Cj4JLiEphGEvv6me5bRQw6qfjtybPiwTm736RpoyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836305; c=relaxed/simple;
	bh=IrSQwlkoFJxFwTfiEycarB9pqWv6fk3NHxoTLlcpF0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgzCF7Qep/INn9JkSM22KMm3KeOoy6mpmnm9KiuGUMlZwOGqwd5pIPQZvNAFz8A6KF99h1pQ6nXgFkYBFvitEjCzh66+DNg6oa0qtzjh4UD+/L3+hR74aoH6kteBjEL3eYOpSe1/Eq+gDkP0gVhGK75/j49U8JN0oOLkqvxgQbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cGlsRLnL; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1VmvrZf+L5WBrSBZjX57xZv0z7Va4W1ib4Js/9yuMxlg7BAw7Q+daoirw1JjusCwHoZRk9VxuFj9YMDS2DxwOXND0AFfoIpgwufz5H+7zkNC/kldH4VX6Io6G+5NEwOLeLc9KveIE35EsFgdBMFg6SEzbICh0kv6EaI/wLhQ+6l13QOxjtUQqjQHaaK6LexvZoxETrDFRxn8WpD+dl2sLSZubnYrj7/zjMaNY5kp71lIQeJh05i+95LVA38evg4xow4qQUkz+Zvl2HIKECBYGWBuB5kxP1hX354IqcIn+33hT1uPUH7LMxv7Jd0Pmb5/JVO62BZvC0cYcbnSzCXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sm8ioKdDNp+5Kz3rLUSSVW9umY7+7/6wi45XMxUlDIc=;
 b=QKTYX7cX3vB0lu5jiKZWUwxhHzOsvLHzwg9gTkbJBrTvxw21Y+3vJAxFTb0gXHvYk0YKWd1Kx4eJwpsDjytbl5NTT+0t9ABfmLCbzdo4CERwX+P44gPn3g1RDNxL0423W2N5jExYAEi00T4qQd0QrTXb/yV1idg4u6fWjncVm6ewBiPkRR1CrK1AHC9d3nTdniLuqHT4oVA6LwIkkP2MLs+jVq3uyIy2UWArtSTqRGPifVCqGo5dYWtUZ9TSkdkZcVrw0HJN/evDAuljcj3deKjVYaE6VrFOAeIRfH2N4HKfHbVJUiW2i/p7sk3Wi6DL7sglReconQOYCLbQpFOOCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sm8ioKdDNp+5Kz3rLUSSVW9umY7+7/6wi45XMxUlDIc=;
 b=cGlsRLnLfDFat5tf6s7W7JpNTIMKecvJ7I3OCUUHOIeUwfim4dgfhpES4x9UQSN6KI85Dkpqj5lWY/bOtND+g69lpg+cxSq5JBVmRNfXStIjvPEMb/Ej0dJEIRQiWrT5c46EQ1hHVv5Lknmi4nihudLSUueL60eAiDsQtSxDrgE=
Received: from SJ0PR13CA0161.namprd13.prod.outlook.com (2603:10b6:a03:2c7::16)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 19:25:00 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::51) by SJ0PR13CA0161.outlook.office365.com
 (2603:10b6:a03:2c7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11 via Frontend
 Transport; Fri, 16 Aug 2024 19:25:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Fri, 16 Aug 2024 19:24:59 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 14:24:58 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 9/9] KVM: selftests: Interleave fallocate for KVM_PRE_FAULT_MEMORY
Date: Fri, 16 Aug 2024 14:23:10 -0500
Message-ID: <20240816192310.117456-10-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816192310.117456-1-pratikrajesh.sampat@amd.com>
References: <20240816192310.117456-1-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b8f14e-a9b9-431c-b4c0-08dcbe291ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hGHpITF4gcc1o/Tn3PdsAyDPHyzZWN4xA9IDdciWQ/HYHY4D+rPElNVIf+mI?=
 =?us-ascii?Q?LG0GW/EsfRhf6sxfPIfhj962Fc9yxH36KHUCJ+WbaHYxMS2U49SzJZea7umE?=
 =?us-ascii?Q?HWEb9oOgfYff99Lpzn8CCg6RLl2Pw5hcdTKJIzBdO/ie1RIopoRvmm7aREmp?=
 =?us-ascii?Q?hNJkANhwQLgDNHs3FzFpQfaan+9NBhvoARXz3c/s93QmLwwnCtNwVQuWBtfv?=
 =?us-ascii?Q?T1XuD8Q5d+1uLBynwCD6MmTpXJEGQLK4BEOH8ActerW+4e8bVswfZxNCkoH6?=
 =?us-ascii?Q?8Rdly5ce+li21oLUQtBCv6FpwIL8k9ZGJwp25mSIoAwYmXemPjrdNCcCOJ4i?=
 =?us-ascii?Q?RMlJKn2cwVO+Y7TmRPXDxMh+9Q+7vlMYXJFJ9gAyHcXr11QGcpVFfysv14/t?=
 =?us-ascii?Q?+s8RJmQMD0TrSvekw9qgb0WGltfGKrB1/sp8c9Ova/hKMoaAb6U4vKhHPuna?=
 =?us-ascii?Q?JQI8Pbv1gq8v/xYWly9L7ZpCRt9xQyikZJFiqV82/VdJoMJFjboPkB8oCCs5?=
 =?us-ascii?Q?ZC0J6ZqubqEV9BsHf/TWuCZStiw5JaLEVsPhESg0H9GrFwhanaLM1ZD2hlMs?=
 =?us-ascii?Q?tpvZbmHozNZnytsJ0EVfMBG7HGcJxxQJaDN51X4Wxcjht3B0yLv0nbHTunDi?=
 =?us-ascii?Q?NUOab3DUXnRQngXDpA9Hzbvaz6GXrDomhr3HNdulE1sK/A4HHhcd8I5LXB7w?=
 =?us-ascii?Q?Xu+qpgMrtI/sNDbUUjjT8ubnUZYAXxo7OBd+Y4Dng05c6K8sYGF4ZRkx8tlw?=
 =?us-ascii?Q?0IW58qS72+kl5cJxNrOpEc2YmrWtIw6fvKZ3yki6EIBeoadNmOV++AxFZsjF?=
 =?us-ascii?Q?1RXLgyzN97OCqVMaudvh9xUN4yrLChtNoDmcFZaGv+YWQOnbDFWLLvoc1QaF?=
 =?us-ascii?Q?W+AR6lqY4RtsVi+kW1jlsnpGcOTN4X/YAvcZQrwXa2n5H7pxsVmETpccO1aq?=
 =?us-ascii?Q?HFwd18T+JqvBxMjL1Mj4Sa5VRh1kve4QXjNkdnvRGFsk+kEUKf9NM1yor5Z9?=
 =?us-ascii?Q?He7qB8dJWkKKbrb1fhp2zgW+LQGf06orGzjkRutK9v2dIOX15slRK/KJeAS+?=
 =?us-ascii?Q?yM5Y79deP8qFiK0WaJWF0eDUrdYZirdObDMILluxQiprt+g0NDjvvggm6vg4?=
 =?us-ascii?Q?mUQYWikLFpAIR+TfMgSTLsH200zBbv2XYd9GpByoD45bQZh1BgV9B+22iW/v?=
 =?us-ascii?Q?0+roV9xEtWkcH+4KAi7gB6sBsTQyulUdZmoGmhRkkxDb1tGxhVUrAg9gHl6c?=
 =?us-ascii?Q?Jw8hXMdZYHK1NkuADugLWAfroi3gJ/5lmxlOMchQFvpA0iQ9JWoIo7HDtPcU?=
 =?us-ascii?Q?WTpPPgVEQ0U0C7jZ42l9XrcJxjX42rLQV5E0EPyd8B/QrPIOQ2qU8TKUf2cf?=
 =?us-ascii?Q?qZYMKU/skvalYvp9ibjd4dq3zD6P5IOo1/OJms8Waofq8Sm4c+taNkLFkipS?=
 =?us-ascii?Q?f49uXWxX4wYGIf6ODv+nTjrrmrrHOGYk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 19:24:59.8267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b8f14e-a9b9-431c-b4c0-08dcbe291ed2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446

fallocate triggers gmem_prepare(), and KVM_PRE_FAULT_MEMORY can cause
guest page faults at unexpected points. Therefore, introduce several
test cases to interleave fallocate, hole punching through various
points of the SNP launch lifecycle, and observe both positive and
negative vcpcu_run exit statuses.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 .../kvm/x86_64/coco_pre_fault_memory_test.c   | 121 +++++++++++++++++-
 1 file changed, 114 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c b/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c
index e16fe185fb5a..6ad07e2f25b4 100644
--- a/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c
+++ b/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c
@@ -47,6 +47,31 @@ enum prefault_snp_test_type {
 	PREFAULT_PRIVATE_SHARED_AFTER_FINALIZING
 };
 
+enum falloc_snp_test_type {
+	/* Skip alloc tests. */
+	NO_ALLOC_TYPE = 0,
+	/*
+	 * Allocate and/or deallocate a region of guest memfd before
+	 * memory regions are updated to be protected and encrypted
+	 *
+	 * This should succeed since allocation and deallocation is
+	 * supported before the memory is finalized.
+	 */
+	ALLOC_BEFORE_UPDATE,
+	ALLOC_AFTER_UPDATE,
+	DEALLOC_BEFORE_UPDATE,
+	ALLOC_DEALLOC_BEFORE_UPDATE,
+	/*
+	 * Allocate and/or deallocate a region of guest memfd after
+	 * memory regions are updated to be protected and encrypted
+	 *
+	 * This should fail since dealloc will nuke the pages that
+	 * contain the initial code that the guest will run.
+	 */
+	DEALLOC_AFTER_UPDATE,
+	ALLOC_DEALLOC_AFTER_UPDATE
+};
+
 static void guest_code_sev(void)
 {
 	int i;
@@ -73,6 +98,29 @@ static void guest_code_sev(void)
 	GUEST_DONE();
 }
 
+static void __falloc_region(struct kvm_vm *vm, bool punch_hole)
+{
+	int ctr, ret, flags = FALLOC_FL_KEEP_SIZE;
+	struct userspace_mem_region *region;
+
+	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
+		if (punch_hole)
+			flags |= FALLOC_FL_PUNCH_HOLE;
+		ret = fallocate(region->region.guest_memfd, flags, 0, PAGE_SIZE * TEST_NPAGES);
+		TEST_ASSERT(!ret, "fallocate should succeed.");
+	}
+}
+
+static void gmemfd_alloc(struct kvm_vm *vm)
+{
+	__falloc_region(vm, false);
+}
+
+static void gmemfd_dealloc(struct kvm_vm *vm)
+{
+	__falloc_region(vm, true);
+}
+
 static void __pre_fault_memory(struct kvm_vcpu *vcpu, u64 gpa, u64 size,
 			       u64 left, bool expect_fail)
 {
@@ -137,13 +185,34 @@ static void pre_fault_memory_negative(struct kvm_vcpu *vcpu, u64 gpa,
 }
 
 static void pre_fault_memory_snp(struct kvm_vcpu *vcpu, struct kvm_vm *vm,
-				 bool private, enum prefault_snp_test_type p_type)
+				 bool private, enum prefault_snp_test_type p_type,
+				 enum falloc_snp_test_type f_type)
 {
+	if (f_type == ALLOC_BEFORE_UPDATE ||
+	    f_type == ALLOC_DEALLOC_BEFORE_UPDATE) {
+		gmemfd_alloc(vm);
+	}
+
+	if (f_type == DEALLOC_BEFORE_UPDATE ||
+	    f_type == ALLOC_DEALLOC_BEFORE_UPDATE) {
+		gmemfd_dealloc(vm);
+	}
+
 	if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
 		pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
 
 	snp_vm_launch_start(vm, SNP_POLICY);
 
+	if (f_type == ALLOC_BEFORE_UPDATE ||
+	    f_type == ALLOC_DEALLOC_BEFORE_UPDATE) {
+		gmemfd_alloc(vm);
+	}
+
+	if (f_type == DEALLOC_BEFORE_UPDATE ||
+	    f_type == ALLOC_DEALLOC_BEFORE_UPDATE) {
+		gmemfd_dealloc(vm);
+	}
+
 	if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
 		pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
 
@@ -164,11 +233,36 @@ static void pre_fault_memory_snp(struct kvm_vcpu *vcpu, struct kvm_vm *vm,
 
 	snp_vm_launch_update(vm);
 
+	if (f_type == ALLOC_AFTER_UPDATE ||
+	    f_type == ALLOC_DEALLOC_AFTER_UPDATE) {
+		gmemfd_alloc(vm);
+	}
+
+	/*
+	 * Hole-punch after SNP LAUNCH UPDATE is not expected to fail
+	 * immediately, rather its affects are observed on vcpu_run()
+	 * as the pages that contain the initial code is nuked.
+	 */
+	if (f_type == DEALLOC_AFTER_UPDATE ||
+	    f_type == ALLOC_DEALLOC_AFTER_UPDATE) {
+		gmemfd_dealloc(vm);
+	}
+
 	if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
 		pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
 
 	snp_vm_launch_finish(vm);
 
+	if (f_type == ALLOC_AFTER_UPDATE ||
+	    f_type == ALLOC_DEALLOC_AFTER_UPDATE) {
+		gmemfd_alloc(vm);
+	}
+
+	if (f_type == DEALLOC_AFTER_UPDATE ||
+	    f_type == ALLOC_DEALLOC_AFTER_UPDATE) {
+		gmemfd_dealloc(vm);
+	}
+
 	/*
 	 * After finalization, pre-faulting either private or shared
 	 * ranges should work regardless of whether the pages were
@@ -210,7 +304,8 @@ static void pre_fault_memory_sev(unsigned long vm_type, struct kvm_vcpu *vcpu,
 }
 
 static void test_pre_fault_memory_sev(unsigned long vm_type, bool private,
-				      enum prefault_snp_test_type p_type)
+				      enum prefault_snp_test_type p_type,
+				      enum falloc_snp_test_type f_type)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -246,12 +341,22 @@ static void test_pre_fault_memory_sev(unsigned long vm_type, bool private,
 	}
 
 	if (vm_type == KVM_X86_SNP_VM)
-		pre_fault_memory_snp(vcpu, vm, private, p_type);
+		pre_fault_memory_snp(vcpu, vm, private, p_type, f_type);
 	else
 		pre_fault_memory_sev(vm_type, vcpu, vm);
 
 	vcpu_run(vcpu);
 
+	/* Expect SHUTDOWN when we falloc using PUNCH_HOLE after SNP_UPDATE */
+	if (vm->type == KVM_X86_SNP_VM &&
+	    (f_type == DEALLOC_AFTER_UPDATE ||
+	    f_type == ALLOC_DEALLOC_AFTER_UPDATE)) {
+		TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SHUTDOWN,
+			    "Wanted SYSTEM_EVENT, got %s",
+			    exit_reason_str(vcpu->run->exit_reason));
+		goto out;
+	}
+
 	if (vm->type == KVM_X86_SEV_ES_VM || vm->type == KVM_X86_SNP_VM) {
 		TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SYSTEM_EVENT,
 			    "Wanted SYSTEM_EVENT, got %s",
@@ -278,7 +383,7 @@ static void test_pre_fault_memory_sev(unsigned long vm_type, bool private,
 
 static void test_pre_fault_memory(unsigned long vm_type, bool private)
 {
-	int pt;
+	int pt, ft;
 
 	if (vm_type && !(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(vm_type))) {
 		pr_info("Skipping tests for vm_type 0x%lx\n", vm_type);
@@ -288,11 +393,13 @@ static void test_pre_fault_memory(unsigned long vm_type, bool private)
 	switch (vm_type) {
 	case KVM_X86_SEV_VM:
 	case KVM_X86_SEV_ES_VM:
-		test_pre_fault_memory_sev(vm_type, private, NO_PREFAULT_TYPE);
+		test_pre_fault_memory_sev(vm_type, private, NO_PREFAULT_TYPE, NO_ALLOC_TYPE);
 		break;
 	case KVM_X86_SNP_VM:
-		for (pt = 0; pt <= PREFAULT_PRIVATE_SHARED_AFTER_FINALIZING; pt++)
-			test_pre_fault_memory_sev(vm_type, private, pt);
+		for (pt = 0; pt <= PREFAULT_PRIVATE_SHARED_AFTER_FINALIZING; pt++) {
+			for (ft = 0; ft <= ALLOC_DEALLOC_AFTER_UPDATE; ft++)
+				test_pre_fault_memory_sev(vm_type, private, pt, ft);
+		}
 		break;
 	default:
 		abort();
-- 
2.34.1


