Return-Path: <linux-kselftest+bounces-15563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD501955169
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 21:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E251F2170D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 19:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7881C4637;
	Fri, 16 Aug 2024 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rLpeHxO8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302D31C3F21;
	Fri, 16 Aug 2024 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836283; cv=fail; b=jXx4aLh+gwMpw4Ss0EgqcRGfNRjLIIiMe8Onpr0Xmg5HZcgxjs/jpjec8Nm1BFRJxtB/uOHRqw4nWHD5jL0+I+S6QFT8SfEqhl8BHFOD/2QZhEX0kHeq6efFANc5Sj7dHAajhsyS+OrPUZQ3uvcFsvDwAfmmHpkoqutvGpU+kts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836283; c=relaxed/simple;
	bh=VcJA07A4HZw6N56PINsN8bO6ADh5MLHwR4cYxitCTGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZfV7rF8eo6fBCGQh9DEy0KdVe2UeoaJKAvgmrhfg2/2QPyn9iQ00WCFwgJQts7d7A2rcwWlZmqWN2l1TJXQ5QRqpptkPMzk41NEUN7PIORR5v+xV2/0gm4P4F+hQHgrTCmkp8fT/J98sJ+jBBXK7MbNt1II/o2GtVGycVIrKaKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rLpeHxO8; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5RnLwydsDiGEt7Im599vHgWAF9dyMFX5Wh30ncJRui/sUFi+/01JxtZ7vB8hLGiuRKdVdNoJ82kW4TbcAxSHF5kKh4F4fLAYJj21bHXXbv1XzkN1dlr5W1Ow/u1m8UqOfBlFN2pKqfEyPc119RBXbdPJMGZDFQyD80UCTPBk1x4s8VNwDMv61Qfc7bfF+0EmM1h+rQGcJvAg6PBW1dWg5ePbPNnmGY7mBsPDW1QRyHONQCsIKi4k3l0sgVR9ZwtliHzYNlfkj9Kzy0QSWqxyadKSK5dwO6IYReT/An8/9lSbvdwgsycwV28AkfGey1ou0NE5kQJE6psanGYWZx+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVKXtwbxNMh0WSbHHwaj9KxTRjbV6c3LQ/UMYsh5wmQ=;
 b=L1U956ItSznwHsfgifDiGm4MsXDKUCVVSMaLmVs/BViJTauFM6ViTsgUqclsVfM3az01uGNjFScOhoHahpP6RjrUXWoZ9Y+FRgxMcnjjtK4e6n9tfwIoLmruRRLzgPijeLZ8oNzHjSoURLs1ZV7bi5QdEZsG6Ilo+e8g1AhpaBIi+jremXJMMDWWVm/64ZocPlnzSaIUBPc9Zyec5g39xmIFqax71nSkr42VgEkzNPdk6hZdRsccf74srBsP6OTwtJV86Gy8bNGLFODTmU87JAv4iR0BpOjZICdKZiDrtcQjw0+xrn5lDH+VeEd3q+4KsWeSF3/dvHm8vXgnPcPxig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVKXtwbxNMh0WSbHHwaj9KxTRjbV6c3LQ/UMYsh5wmQ=;
 b=rLpeHxO8PQsyoGMXAEmV3BwzaIGpnPe/zmqVBXD71uKRPE1I9blkKyBGTmiUBXHNdFdxBGh20b9naHljesQEyJgsMpYP0+QL9mNZOgHbpi4ZnqEOufPdBjHtz0/uINuVMl0MiFnARZH6z3+iGA/dW25Qgi7Xr/eExJaTE2n0dh0=
Received: from SJ0PR13CA0125.namprd13.prod.outlook.com (2603:10b6:a03:2c6::10)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 19:24:38 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::74) by SJ0PR13CA0125.outlook.office365.com
 (2603:10b6:a03:2c6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11 via Frontend
 Transport; Fri, 16 Aug 2024 19:24:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Fri, 16 Aug 2024 19:24:37 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 14:24:36 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 7/9] KVM: selftests: Add interface to manually flag protected/encrypted ranges
Date: Fri, 16 Aug 2024 14:23:08 -0500
Message-ID: <20240816192310.117456-8-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|SA1PR12MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0a53bf-9e56-463f-ed58-08dcbe291185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?REDx5gclNtELPd8nJB+2akWT3GDpgjxtf/eprlCyZy00iXlZ1YKUAFgB+yfD?=
 =?us-ascii?Q?K4p+HvXlOUmMo+HbbBXoPuoAjCjgqtflh0XOQxeK3cE4OHnDdEFJS10tvVST?=
 =?us-ascii?Q?QindHhsXN2R46IJ5gEk2o0NY67JldJ4bB6daS05pEQBKOR3hdyeSTtE6HMWa?=
 =?us-ascii?Q?O+/8rfw/h+QNcNAyzZQKkLKWlMopLbztn00Yg5StPiV+oyNjtGlUpOKN8O9R?=
 =?us-ascii?Q?YFCsaBNL2zFcSt1p03JgsHa+i3WkAtIUJIuHQ00YRkCvbp5nSnYY/vOcwjG+?=
 =?us-ascii?Q?N3HQbXdzMy+NJRWEzC7spWjQI2rKWZ7sCq1/Cr3fs+/0F9+oUC0gWmqSPw1G?=
 =?us-ascii?Q?388opfkG6H+5BscS+Ih3tqVOOLB4qkRS0HKCZ0Ud3AExqZRvS0+u5BzO2Sp4?=
 =?us-ascii?Q?pU69rcaCGGHfrKjzU0LTiJW/anrBLFwEW1bGVb0zHFBnqd31yihLKuh8Vnwi?=
 =?us-ascii?Q?awxr0HUzMw5Zk0DQNTs6D5c+taT5DW0f9TwFXNZ8ppvkAgIlNDh80LfZnKgx?=
 =?us-ascii?Q?St93bWnzFUcQI1mTS30/JA14sQeeq+oZv7KVeUpJqqpiWroVvB86iPUprArh?=
 =?us-ascii?Q?xLv9M4WMVJH2+3/ORajRVKzJ1v1A9uhvAe+iZuqIK84JhWaEkTxqlWY10iYt?=
 =?us-ascii?Q?rSYRFJWmq1tre6N+oJpKalsI0kBFoOgzk4ESUjj9UEDVfNPA5mNDdnhkXhMA?=
 =?us-ascii?Q?q4i50dKZakzxzVCJwWzG1lOog7jhhnflX2V2D03nmCF38UMKyUfz9XBs9Fym?=
 =?us-ascii?Q?I6RnL1eHxeyB0l1JJE2X6xzC2zlD/Iro9rzU4V6GUxLYxXEoQjuU02MEjlDW?=
 =?us-ascii?Q?I7MW3XcNyeDOXAF5JcN5orR9nYu56P36zX3+G9l3Otb5hYAkP6tRP2fTfXG5?=
 =?us-ascii?Q?khomVwXmNVv/Exe3KB1IOTymZbXC30FsRBFwrlEHxzwcU8hJ8o91LJUeDXFD?=
 =?us-ascii?Q?9tb7oTIA9N+0dwvZRfqXM+y1QR+e3MwPrzj2vCa4a4DalQC60hW6d5RuJ5Mw?=
 =?us-ascii?Q?iGaLDr305zCq0CMuTBe3t1w+6P7RUyaPgZTXJMJbFzNyOBi1G+9lPsCfk7n3?=
 =?us-ascii?Q?+SbI7/rs/eZCprWowb84rVNF+iJEl6FoI3U7TgAU70fJswgSM19m+htBInQu?=
 =?us-ascii?Q?x2lx8573IWJJ/PbD6hag97tLlItOKVsEevBNojB5W9MWO2Kdx2Q/f/AmoCFc?=
 =?us-ascii?Q?ca9qtojdjSS4hOOoleFOPhjULmA3EQW6IfM9wRfVTNHceVpGOUMtbX3KsYpQ?=
 =?us-ascii?Q?GUPCiOQPBQopYTfR6yO+p8l1gNeJSrezHispdpaabOklW/p2MSc8xKyZE8Oc?=
 =?us-ascii?Q?wiSzG7Ci/ksjkrIjJa9Wjivxp6CjWUkeW3KPtD1SJQqSpZ9tXImLvhRPhj4v?=
 =?us-ascii?Q?9LDzgoLfzATpWLJ/WrCyO4krUpUfAK5LiUdTXRKCQoK5hdVpIvHKLYtmwmkT?=
 =?us-ascii?Q?hZEq28ZWF15+qURnb+62RsAVs8vrG40w?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 19:24:37.5131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0a53bf-9e56-463f-ed58-08dcbe291185
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200

From: Michael Roth <michael.roth@amd.com>

For SEV and SNP, currently __vm_phy_pages_alloc() handles setting the
region->protected_phy_pages bitmap to mark that the region needs to be
encrypted/measured into the initial guest state prior to
finalizing/starting the guest. It also marks what GPAs need to be mapped
as encrypted in the initial guest page table.

This works when using virtual/physical allocators to manage memory, but
if the test manages allocations/mapping directly then an alternative is
needed to set region->protected_phy_pages directly. Add an interface to
handle that.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 45 +++++++++++++++++--
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 144730efbffa..8017a75a5a61 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -394,6 +394,8 @@ static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
 	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &attr);
 }
 
+void vm_mem_set_protected(struct kvm_vm *vm, uint32_t memslot,
+			  vm_paddr_t paddr, size_t num);
 
 static inline void vm_mem_set_private(struct kvm_vm *vm, uint64_t gpa,
 				      uint64_t size)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 9cc4dfc72329..fa8eb998f13c 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2064,6 +2064,43 @@ const char *exit_reason_str(unsigned int exit_reason)
 	return "Unknown";
 }
 
+/*
+ * Set what guest GFNs need to be encrypted prior to finalizing a CoCo VM.
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   memslot - Memory region to allocate page from
+ *   paddr - Start of physical address to mark as encrypted
+ *   num - number of pages
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Generally __vm_phy_pages_alloc() will handle this automatically, but
+ * for cases where the test handles managing the physical allocation and
+ * mapping directly this interface should be used to mark physical pages
+ * that are intended to be encrypted as part of the initial guest state.
+ * This will also affect whether virt_map()/virt_pg_map() will map the
+ * page as encrypted or not in the initial guest page table.
+ *
+ * If the initial guest state has already been finalized, then setting
+ * it as encrypted will essentially be a noop since nothing more can be
+ * encrypted into the initial guest state at that point.
+ */
+void vm_mem_set_protected(struct kvm_vm *vm, uint32_t memslot,
+			  vm_paddr_t paddr, size_t num)
+{
+	struct userspace_mem_region *region;
+	sparsebit_idx_t pg, base;
+
+	base = paddr >> vm->page_shift;
+	region = memslot2region(vm, memslot);
+
+	for (pg = base; pg < base + num; ++pg)
+		sparsebit_set(region->protected_phy_pages, pg);
+}
+
 /*
  * Physical Contiguous Page Allocator
  *
@@ -2121,11 +2158,11 @@ vm_paddr_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 		abort();
 	}
 
-	for (pg = base; pg < base + num; ++pg) {
+	for (pg = base; pg < base + num; ++pg)
 		sparsebit_clear(region->unused_phy_pages, pg);
-		if (protected)
-			sparsebit_set(region->protected_phy_pages, pg);
-	}
+
+	if (protected)
+		vm_mem_set_protected(vm, memslot, base << vm->page_shift, num);
 
 	return base * vm->page_size;
 }
-- 
2.34.1


