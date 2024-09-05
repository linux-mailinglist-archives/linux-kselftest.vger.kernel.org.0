Return-Path: <linux-kselftest+bounces-17233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E2096D92D
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 14:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5501F2BAFF
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 12:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A74919DF41;
	Thu,  5 Sep 2024 12:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BElAJpG9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903E719D8A6;
	Thu,  5 Sep 2024 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540195; cv=fail; b=HFzEIUZRkLMJhArBnrpXO4cdM0vAIk7c2/I0JfxpS3Ct/+rdm7GHwSlS3J3ErD3yEyLFAXNevCCwj73hKyWVCjieGeoVUnHD4P013IaO56EZMtFFPer4YuG0ah7d32Ne76IkfQmaU4Gu44XwvB1ogtRasjokrHs96lxXrEATzMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540195; c=relaxed/simple;
	bh=XyLdegXjDFmKsgQeOEVbSRFofBL4xHb035QdY05IH8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnuV8VEzwsholt4xlLIDUdm2oD++J0VjI42mFi4Cr889x6qLQ8M/2Z449UsjXBMCcECZwx2fKI6FI26aUGlAXuchjhusvZLlojB2Yzx2Tf1Kr8YcDkXtbgzBfMPICK7wKb7a9My7R9yJVHCEuLBkx9HQhp6lywxTsR1GS9/0THY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BElAJpG9; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4k1/LFaTSadD9MgDmiueWrKn1v6xaVQ/4OxfzocTs/6R7BunRCOuIRcIFkS3h3MKbXfmSGdMnLvSW6pHpC4aKIhUdFAQfnXj9vw/Q9R1ExhJr36d7UTWluf4CQMKSapskto1bYpXf48+jaNObwblUfdrU7Ot9xihzJ5FGsjG8wyGhOWaIEQprBnp7P2A/R/QIifPizoJ0vH7QT0uUW0DZZLNfxMonEgO6sPcPVKApfMoKMBpFQDD0HD9sHaCK+s2etjxqqXGt5jLgcb7iO6XBSDWP067C0zTtioC+jkMAXUQFoka5qGRUtrWUjygrUYwKSSKU+9e1nfhjE8Ois4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoIgTE7HGNF3oV0V7W/GTL+EeDnGn5BEnENEzLIluBo=;
 b=t0nHM/No74cLddvas1/XaU3RViQ2HQ0eZRtN0ZjJx0aDBuQ4zTH9wdSleX752oTG/mKcz6aGjy0+tkLL2+/AMxKZCzzUILiOVPfkiVSod7ilripZvLePGY+rPnxHDBkmk/VWnDYwcnli89WpHq+8m2N5wBkh4v7TKvfOxW9kM16cvFLfkaTbuJFihMms4ciEHtK1H5Lttwu2UD0TXNmPIqZxsApP+iyskLf7xu/9HW1WR12M+/RQMDp5cwjS6lpIvAOsOTP3srzhHyIsHzeLcmQ8+sb5bi6IpgNwuNQjtSTBQ/tJ67Ls7r+NgnW+AKb60USOV94qn+WsKhaMhRQeOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoIgTE7HGNF3oV0V7W/GTL+EeDnGn5BEnENEzLIluBo=;
 b=BElAJpG9IV/xI6XGjJwM7SlJ2DBWzvyKLZyvyBJ43VNIVZVxpDuC98kHj9gvyQnB5kMohGiD18Nh/yunes/g4u92L1ciiKr+t/dNCSw22cC7AYcdmH0GV2diquinOz+mhZgh0nGxZwksWr7OjYVkgRnQL6dqpzmXbsU+hwgzI1o=
Received: from BY5PR17CA0029.namprd17.prod.outlook.com (2603:10b6:a03:1b8::42)
 by IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 12:43:10 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::23) by BY5PR17CA0029.outlook.office365.com
 (2603:10b6:a03:1b8::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 12:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 12:43:09 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 07:43:07 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 9/9] KVM: selftests: Interleave fallocate for KVM_PRE_FAULT_MEMORY
Date: Thu, 5 Sep 2024 07:41:07 -0500
Message-ID: <20240905124107.6954-10-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
References: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: df9a7700-a83e-4fba-43d6-08dccda84c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eIyvd06dJHfw4gS5mXAvZ/sf8UBEluPKFgHaB56VWUPwupYP7Vs+135p4kdX?=
 =?us-ascii?Q?vFbxd1oJCootznV0m3Xb5pEJx9N16RQG6iaPqvWBI5dhYjoiuIEIpB8iih/+?=
 =?us-ascii?Q?rtfRlSODpaKNahjajdW5uLSAYoGUcGD0Xng39I9zYWPDcgJv8OLZPB8ww3pm?=
 =?us-ascii?Q?8mf+C+8VHcGgk8pPI5bsU5hqTpoasIgp1bvUBhenHIllHlYj5nOjvgmdinGI?=
 =?us-ascii?Q?0mNNlOdkCmj2tPQ3rSNSuEjjpXb6PWvZ+ATSV/4lRzYhi2cAqBEVpa3v8UYW?=
 =?us-ascii?Q?NGZegxHvlJQ6h/YaE9UEIHQfizmkQiiMVlEDq9LgM4yTIasb6o+rR7A+zKlr?=
 =?us-ascii?Q?nTKh3DtUk7tQMP0NxTySV0qD1wiFkfUzov3YYBYqyyXyQbRWodeL8hZhXxpu?=
 =?us-ascii?Q?iO1ywbVQqBbVwzXp3uW8HIXvj1sSA7LQfd4aWRvo2SzXUX2Osus3VeBXVxAI?=
 =?us-ascii?Q?oL9km45PLTdFLdVIUFohJ0EP/OEmhWDJFT6/GlJwwkzzdQX5CqaG9u/TaZII?=
 =?us-ascii?Q?/E+U3gByvJd08+OxcVYnKagKV/Mm9uv5jcGFlj5eTOytEQ6y49gucXUhC0Qo?=
 =?us-ascii?Q?40jaPoH6kZJbad3MoqfHl9Mv/XrB056g+qTL2hIlL6Rs74aIlvmOqvCnXLeR?=
 =?us-ascii?Q?ySvl5KsGjNEwQEXKHUBJ2CvEOkc5Xh4k1Po07lwxaBxdi5TUqMjaAam3JDoK?=
 =?us-ascii?Q?lfpc49ZzwPaPKwUwl5VhzUPT2W4zoawo6rYbV6MXbvygJBmftME2Bu8pUWrr?=
 =?us-ascii?Q?AanjwXmtmX9ZcsBQUQX1ITFZtGQnpTxaEZDIjSvvIaH5dVNWoDw4tNVIy/YP?=
 =?us-ascii?Q?zcpr9plnZvLH1THPtSnhTbRmkm1heJ6xHLpJqUA+TizJhzdPpgVvD/xtbM+b?=
 =?us-ascii?Q?yloUnxY6r9iGFUTPd9KFgUfp0iIVaQh5fv9Wev7KOhebVu8XvWSo0hOhbcCN?=
 =?us-ascii?Q?2DJntsPS15yYujmOJEQITjm1RXb8YWzSnEdO4TprO+uaMoBX45Qw88nJc2ik?=
 =?us-ascii?Q?pnqNOJR/bAsHlEiYVT+7tYnzkwIWVhrg8Ey7RIdLZZkf0IYAczbVFaZHplJL?=
 =?us-ascii?Q?Kdd5D1RkxUHIAP3zfbDhY/sT1405qvvgYjR1vpHp3OYfrtj1LOu4yH3UWxI/?=
 =?us-ascii?Q?BpLB1IYXo2HIhwS4v82fKXHD6YcYUxE2j8GLIwy3bG7SjlnrxU+xAdP5Jl9V?=
 =?us-ascii?Q?qdG8aMuPlmp1ca10IDZhnSTZbKJ8vb30/tfoImoyhJbW7R7/PLXFixWz1UEx?=
 =?us-ascii?Q?fNlE0/uZGVlVPcPioztPuKRX+QAnTLQIlcoFEsdEsiAJEydAe+9mLiscJvIz?=
 =?us-ascii?Q?kTF8cFTDYAC44uWzxDXOHx/g7VHARpcJHbEcle9ls+KoI8FpWSi5M0xnMVmm?=
 =?us-ascii?Q?h9xMO086AVDZUjw5dhcJISKkMig7ATX7q85Uua3CjBrVXq4M6C/wwvR7ka4j?=
 =?us-ascii?Q?oxLWEk1sDRXC1VocDR5gZN3GLgaO+tyZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 12:43:09.8830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df9a7700-a83e-4fba-43d6-08dccda84c70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508

fallocate triggers gmem_prepare(), and KVM_PRE_FAULT_MEMORY can cause
guest page faults at unexpected points. Therefore, introduce several
test cases to interleave fallocate, hole punching through various
parts of the SNP launch lifecycle, and observe both positive and
negative vcpcu_run exit statuses.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
Tested-by: Peter Gonda <pgonda@google.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
---
 .../kvm/x86_64/coco_pre_fault_memory_test.c   | 121 +++++++++++++++++-
 1 file changed, 114 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c b/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c
index c31a5f9e18f4..e9757ba3234c 100644
--- a/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c
+++ b/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c
@@ -47,6 +47,31 @@ enum prefault_snp_test_type {
 	PREFAULT_PRIVATE_SHARED_AFTER_FINALIZING
 };
 
+enum falloc_snp_test_type {
+	/* Skip alloc tests. */
+	NO_ALLOC_TYPE,
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


