Return-Path: <linux-kselftest+bounces-27864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA94A4961B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2FE1166CB1
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BE72594B9;
	Fri, 28 Feb 2025 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wDjLqeix"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33711C549E;
	Fri, 28 Feb 2025 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736684; cv=fail; b=OiDfd3g9z21lwRSFsF/kC/e0ATW9lqojl6FGvDz8qqwNkFrV04tDD0v0V8fZ0eIMu3D0xlcQRjqY4wYCbJQ8J4exjZUSCmULipckY04+aaSIZEGoX0a981x5SYU9iPwIpKozBd+HPyDkQlqxj/u0Jz/3C1GTBZXGAK7fla5KY+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736684; c=relaxed/simple;
	bh=D4naQEK05N1WoYO/35g+u8u0dlFcr5QuLifugNWOxhw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bBg2k7UP7A2j6fNwHEbTvsf2DGNdpUmJN42ykaSa3mR80ZpdouYE4oB0mhL353Y7VJSEjKCy8WxQAOuiktR9fxDjeWNP30qLJU6Nwu3qQd2TSRfPPewPWE/Az5bdO+J4Fj6duiXup4WEGQCwjAkCKHRqTfDgB5qW4uclYwiGbxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wDjLqeix; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfL1UbxR92C99LMjZebmljTv9rDbJMwyBPt4PtVY56SKuChN12WDQQFpGFCRvGmJCFwRnEp1UAE6UNsu8xoBbV+YzM8nkIIljoeRKWoLBuRB05rwG2V2vnJzfiQLvzd/TSCFxIJWJAqyqZQePwOUM7lEVGWo0/1zieoVEWA3vo+Ia2Hl2GbbVBxzwGHMfP5ziSuftsYPSDCa0n/l83DSGbCuExSvdZ/QGputyw7VG5lj4gGKyT5bO8eHXWxG/MCIDNgNEO+P8U+oy+Yf5d2P4XTYjB7wHlwsEGJm8DV18UjB3tlWwe5O/rPaVfQbAN9nq61ewhk6iFb5MDaKa8z3iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVpOsls/JXexXlGl+j1UlPV4bV1c23yW/fdSSxCiuB0=;
 b=SjtCHUaQDZEydBejVLancqabtH1sTrEQpInjG/n4e7RtqiZKX9WoxSyERsLJ0d4hz7AkAp3M+7l0xsMSYrc8x/mf9vleWyBrWI7I3Yh9eN2dM4TddkgjrNntAnGrKFpKNXSE/NCMgw562MVKrjxe1TW88FmtvkdG1Q6xbNrwZseBcS34S8USx/Hb3qzHnrFe7SSXiqNGeZvY1jMlNnxrXyVJQFS4cwzbRVCbUc0ZAGpL3uzNfDl2DSniDvoivDiaFMWjIWvxw1vK1jvsxs4+2kryCxWTCtpLsWTxgE13++Ig+nP+R7FaprlQpxcCOdsMFtGzfY79nMNhBUwml8hz7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVpOsls/JXexXlGl+j1UlPV4bV1c23yW/fdSSxCiuB0=;
 b=wDjLqeixQxokcHFFTZbanXTvCZod87VJnTOwgd4rPgqR62TP38RE4ANPd6qbvsIyVRbEyfEQ9m1hmBELdWVUKmxQEwl9T51+uzH2jeOyGU6qIcyOU7D1c0nwrB7P+KinoeWTwT49zD2NH0QBvcF0g5XnHvqxgg3FXhpTIVGyFXs=
Received: from MW4PR03CA0230.namprd03.prod.outlook.com (2603:10b6:303:b9::25)
 by IA0PR12MB7578.namprd12.prod.outlook.com (2603:10b6:208:43d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 09:57:58 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:303:b9:cafe::d2) by MW4PR03CA0230.outlook.office365.com
 (2603:10b6:303:b9::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 09:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:57:57 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:55:24 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 22/31] KVM: selftests: Add args param to kvm_arch_vm_post_create()
Date: Fri, 28 Feb 2025 15:00:15 +0530
Message-ID: <20250228093024.114983-23-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228093024.114983-1-Neeraj.Upadhyay@amd.com>
References: <20250228093024.114983-1-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|IA0PR12MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ddc7f26-f68b-4163-34f5-08dd57de6131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W7VmRunEEVH0pQEdnxyzYQ1bPeLmuuqTHoOdZ/QshLwpToRQWs6z3cQT0YvE?=
 =?us-ascii?Q?6ah4Rwxxvj9+cgVUac/svGwndWCgVzWdc3BeQTINAJU4SIQlDZ+SfIebXg1u?=
 =?us-ascii?Q?6ihJT8EA+CSXhAoA83PxsjUVQKN4U0W8XD0lTx1YuAggXks9W/a03frPdBAg?=
 =?us-ascii?Q?RCIHFSFo6y9w7jjRzNf9KVWv3WbQabJvjDygDglriv1snB7Eagswl293Rd50?=
 =?us-ascii?Q?OJcQZHoBeM9yOW6xBIRnT+AuLc8OTaG2nVK4oAHtloaMgre4Bv3gDr3Ax/IU?=
 =?us-ascii?Q?l3SDrZ+NFrryU1qhjs+m4LWPLR94/JI2wCvsoabo0DSq8UvlD9UFI5wPaQ9L?=
 =?us-ascii?Q?N4S/RvDfOQTPK9w0bliFTg56YCYJ0WOmo/TcAOvjwh9RBUL8sq9gOpJhh5kt?=
 =?us-ascii?Q?BRKj1ze1mmKs2BJWjy1lJheRonQK4/t0XjjWkEZYzJR0YM8OVmU2n0+zHBTg?=
 =?us-ascii?Q?X+RE7rSrtAkEVHin/VSWElVd5JMRtg2rZM42lYOiKUd9cCSWADp5kfF4F3cI?=
 =?us-ascii?Q?r3OVjWno5BSV9AI8NzVuC36kfV2B84/wN7Mczq/ilmOQ9z7nDkeadBkE6wIj?=
 =?us-ascii?Q?s/f1oe67S7G2c2LRr5CggUfSOHkQh9hpuQofdmksl03bJeDBV34NoGPf6sJB?=
 =?us-ascii?Q?qx9EjN+16WP/EUFlyLTHQnIRqOthhpvBfJbFEaum6lKLd8KJtmP7pAT3JdYU?=
 =?us-ascii?Q?wUhb32yFl0dwxRnx1PpW0ptp3QhkbEpzg9u81zhzaHdA1jZmHt+1RhgKzOxT?=
 =?us-ascii?Q?z6+t0nI1KoVxUijcasDU0SqH6O+Blx1Ngh5volHsqApLJEtOAZskSnW7xSEj?=
 =?us-ascii?Q?9xuPKmdbxlWC9FJDUDMNSSAd1qa+tW8le20zYqFE5K9WfPtzXtUs7C4nZDOy?=
 =?us-ascii?Q?QvxbAiJPUE7EOqMub06oIoaHl6rszkFLZg3cXAti7hROpFLfrBxKip98YN+X?=
 =?us-ascii?Q?TKML2HRr5lcMMaAigCGM3TUr+Mti/qh0SOtmavNcvhEhB4zN5oF5c0HWRv7L?=
 =?us-ascii?Q?aGMX2Fh8S2Y0zLMHpKocuAAEsQDroLqnDTdk/OHQ5atVaqh72qm/DzYv9/ej?=
 =?us-ascii?Q?pIIfBLBzJwZLAoodhB6uh2qwZdTE2qW3++MnSI9XCfqNfsbToVJCtSUiwCJl?=
 =?us-ascii?Q?57ghUlfiDwljBhpycO7EgsanRfOO0+/xK+vda4r2O72jGuNf6fOozAgESLPO?=
 =?us-ascii?Q?36rW8F8ZOAykdVETo9L9Boj+zVuFIiq0vmClnijFN7Rj7Vw8fyBDZcVf1I6g?=
 =?us-ascii?Q?6y+Spuux3i9X6yRLGPuYMPhH6einulqkfIREt2z5y+KAlWNQc5W9d9EmHJFu?=
 =?us-ascii?Q?n0yYkgHqD85S/sB3Hxvv045KaSDnpYnfpgkOGpgCE5abjdTjsV3z60Ou1eIU?=
 =?us-ascii?Q?rZT9/4soPhbPOv6gZnwRjLnUQYL8uOu6VAy7EbqoyGQrGqPWMB3sTYGlS8Q/?=
 =?us-ascii?Q?hrxsvM064Hh4gQBDf2bbWCdpbeIt52BFqlBPLJXFy0xcAEXv1mDyXPWTnhka?=
 =?us-ascii?Q?VN7ArQUSBBG0c+U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:57:57.9574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddc7f26-f68b-4163-34f5-08dd57de6131
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7578

Add provision to pass custom args to kvm_arch_vm_post_create().
This will be used to pass sev init args (vmsa features) for SEV VMs.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  9 +++-
 tools/testing/selftests/kvm/include/x86/sev.h |  3 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 51 +++++++++++++------
 .../testing/selftests/kvm/lib/x86/processor.c |  6 ++-
 tools/testing/selftests/kvm/lib/x86/sev.c     | 13 +++--
 tools/testing/selftests/kvm/s390/cmma_test.c  |  2 +-
 6 files changed, 62 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index a160e1ac7cbc..7f97bade5797 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -901,6 +901,9 @@ static inline vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 struct kvm_vm *____vm_create(struct vm_shape shape);
 struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 			   uint64_t nr_extra_pages);
+struct kvm_vm *__vm_create_with_args(struct vm_shape shape,
+		uint32_t nr_runnable_vcpus,  uint64_t nr_extra_pages,
+		void *args);
 
 static inline struct kvm_vm *vm_create_barebones(void)
 {
@@ -925,6 +928,10 @@ static inline struct kvm_vm *vm_create(uint32_t nr_runnable_vcpus)
 struct kvm_vm *__vm_create_with_vcpus(struct vm_shape shape, uint32_t nr_vcpus,
 				      uint64_t extra_mem_pages,
 				      void *guest_code, struct kvm_vcpu *vcpus[]);
+struct kvm_vm *___vm_create_with_vcpus(struct vm_shape shape,
+				       uint32_t nr_vcpus, uint64_t extra_mem_pages,
+				       void *guest_code, struct kvm_vcpu *vcpus[],
+				       void *args);
 
 static inline struct kvm_vm *vm_create_with_vcpus(uint32_t nr_vcpus,
 						  void *guest_code,
@@ -1141,7 +1148,7 @@ static inline int __vm_disable_nx_huge_pages(struct kvm_vm *vm)
  */
 void kvm_selftest_arch_init(void);
 
-void kvm_arch_vm_post_create(struct kvm_vm *vm);
+void kvm_arch_vm_post_create(struct kvm_vm *vm, void *args);
 
 bool vm_is_gpa_protected(struct kvm_vm *vm, vm_paddr_t paddr);
 
diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index 3756805197c3..ffb5ded0a35a 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -52,6 +52,9 @@ void snp_vm_launch_start(struct kvm_vm *vm, uint64_t policy);
 void snp_vm_launch_update(struct kvm_vm *vm);
 void snp_vm_launch_finish(struct kvm_vm *vm);
 
+struct kvm_vm *_vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
+					   struct kvm_vcpu **cpu,
+					   void *init_args);
 struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 					   struct kvm_vcpu **cpu);
 void vm_sev_launch(struct kvm_vm *vm, uint64_t policy, uint8_t *measurement);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 34e586d4fec4..93b8e2ccc7b3 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -408,8 +408,8 @@ static uint64_t vm_nr_pages_required(struct vm_shape shape,
 	return vm_adjust_num_guest_pages(shape.mode, nr_pages);
 }
 
-struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
-			   uint64_t nr_extra_pages)
+static struct kvm_vm *___vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
+			   uint64_t nr_extra_pages, void *args)
 {
 	uint64_t nr_pages = vm_nr_pages_required(shape, nr_runnable_vcpus,
 						 nr_extra_pages);
@@ -447,7 +447,37 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 	guest_rng = new_guest_random_state(guest_random_seed);
 	sync_global_to_guest(vm, guest_rng);
 
-	kvm_arch_vm_post_create(vm);
+	kvm_arch_vm_post_create(vm, args);
+
+	return vm;
+}
+
+struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
+			   uint64_t nr_extra_pages)
+{
+	return ___vm_create(shape, nr_runnable_vcpus, nr_extra_pages, NULL);
+}
+
+struct kvm_vm *__vm_create_with_args(struct vm_shape shape, uint32_t nr_runnable_vcpus,
+			   uint64_t nr_extra_pages, void *args)
+{
+	return ___vm_create(shape, nr_runnable_vcpus, nr_extra_pages, args);
+}
+
+struct kvm_vm *___vm_create_with_vcpus(struct vm_shape shape,
+		uint32_t nr_vcpus, uint64_t extra_mem_pages,
+		void *guest_code, struct kvm_vcpu *vcpus[],
+		void *args)
+{
+	struct kvm_vm *vm;
+	int i;
+
+	TEST_ASSERT(!nr_vcpus || vcpus, "Must provide vCPU array");
+
+	vm = ___vm_create(shape, nr_vcpus, extra_mem_pages, args);
+
+	for (i = 0; i < nr_vcpus; ++i)
+		vcpus[i] = vm_vcpu_add(vm, i, guest_code);
 
 	return vm;
 }
@@ -475,17 +505,8 @@ struct kvm_vm *__vm_create_with_vcpus(struct vm_shape shape, uint32_t nr_vcpus,
 				      uint64_t extra_mem_pages,
 				      void *guest_code, struct kvm_vcpu *vcpus[])
 {
-	struct kvm_vm *vm;
-	int i;
-
-	TEST_ASSERT(!nr_vcpus || vcpus, "Must provide vCPU array");
-
-	vm = __vm_create(shape, nr_vcpus, extra_mem_pages);
-
-	for (i = 0; i < nr_vcpus; ++i)
-		vcpus[i] = vm_vcpu_add(vm, i, guest_code);
-
-	return vm;
+	return ___vm_create_with_vcpus(shape, nr_vcpus, extra_mem_pages, guest_code,
+			vcpus, NULL);
 }
 
 struct kvm_vm *__vm_create_shape_with_one_vcpu(struct vm_shape shape,
@@ -2270,7 +2291,7 @@ void __vm_get_stat(struct kvm_vm *vm, const char *stat_name, uint64_t *data,
 	}
 }
 
-__weak void kvm_arch_vm_post_create(struct kvm_vm *vm)
+__weak void kvm_arch_vm_post_create(struct kvm_vm *vm, void *args)
 {
 }
 
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 2d6105b1f610..09474be27986 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -9,6 +9,7 @@
 #include "processor.h"
 #include "sev.h"
 #include "apic.h"
+#include "savic.h"
 
 #ifndef NUM_INTERRUPTS
 #define NUM_INTERRUPTS 256
@@ -631,7 +632,7 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 		REPORT_GUEST_ASSERT(uc);
 }
 
-void kvm_arch_vm_post_create(struct kvm_vm *vm)
+void kvm_arch_vm_post_create(struct kvm_vm *vm, void *sev_init_args)
 {
 	int r;
 
@@ -648,7 +649,8 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
 	if (is_sev_vm(vm)) {
 		struct kvm_sev_init init = { 0 };
 
-		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
+		vm_sev_ioctl(vm, KVM_SEV_INIT2, sev_init_args ?
+				(struct kvm_sev_init *)sev_init_args : &init);
 	}
 
 	r = __vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL);
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index 518e30275960..7675950efe56 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -291,8 +291,9 @@ void snp_vm_launch_finish(struct kvm_vm *vm)
 	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_FINISH, &launch_finish);
 }
 
-struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
-					   struct kvm_vcpu **cpu)
+struct kvm_vm *_vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
+					   struct kvm_vcpu **cpu,
+					   void *init_args)
 {
 	struct vm_shape shape = {
 		.mode = VM_MODE_DEFAULT,
@@ -301,7 +302,7 @@ struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 	struct kvm_vm *vm;
 	struct kvm_vcpu *cpus[1];
 
-	vm = __vm_create_with_vcpus(shape, 1, 0, guest_code, cpus);
+	vm = ___vm_create_with_vcpus(shape, 1, 0, guest_code, cpus, init_args);
 	*cpu = cpus[0];
 
 	return vm;
@@ -319,6 +320,12 @@ static bool is_savic_enabled(void)
 	return supported_vmsa_features & BIT_ULL(SVM_FEAT_SECURE_AVIC);
 }
 
+struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
+					   struct kvm_vcpu **cpu)
+{
+	return _vm_sev_create_with_one_vcpu(type, guest_code, cpu, NULL);
+}
+
 void vm_sev_launch(struct kvm_vm *vm, uint64_t policy, uint8_t *measurement)
 {
 	if (is_sev_es_vm(vm))
diff --git a/tools/testing/selftests/kvm/s390/cmma_test.c b/tools/testing/selftests/kvm/s390/cmma_test.c
index e32dd59703a0..b6a3fa1d71aa 100644
--- a/tools/testing/selftests/kvm/s390/cmma_test.c
+++ b/tools/testing/selftests/kvm/s390/cmma_test.c
@@ -145,7 +145,7 @@ static void finish_vm_setup(struct kvm_vm *vm)
 	slot0 = memslot2region(vm, 0);
 	ucall_init(vm, slot0->region.guest_phys_addr + slot0->region.memory_size);
 
-	kvm_arch_vm_post_create(vm);
+	kvm_arch_vm_post_create(vm, NULL);
 }
 
 static struct kvm_vm *create_vm_two_memslots(void)
-- 
2.34.1


