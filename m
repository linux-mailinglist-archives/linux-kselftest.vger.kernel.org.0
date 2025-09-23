Return-Path: <linux-kselftest+bounces-42094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CABF8B944DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86072440842
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBD130DD00;
	Tue, 23 Sep 2025 05:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X2p6cPEw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011009.outbound.protection.outlook.com [40.93.194.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA3B25B662;
	Tue, 23 Sep 2025 05:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604254; cv=fail; b=Z/+GjxlTft28YfY6//X+MRZ6K0+yHIjFDQJlkf0qF4eHMIce8Ht17MlIZkcdlsCn1+mr/a1xIsWCc1f3j4O83HTwtxRJgUZrrXLMEDQcBN72N98DhYTxcVx5ZkiHT22gmtxEhw2pMRgjlBL0OW0dWulOVYBh2iITRhkSVMxVV30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604254; c=relaxed/simple;
	bh=MTHnPH6V5cNXr7Kx/Z/WGsayU1vB3YScf9LdF8yTZFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMiqhVMSjjW+BX93fCNmJ56gh1jizKEeE1Kj5C4Ygrq9cQ2vUynTBLZPWBvBH25cLqRU605IZt/h/Mn+9XFFbXgYOODge7l60lLggYYG74qIIQXwa6DX9ZGzL2AAd+085a47GxWwfvSrAPSA1+H9vJ+wukfINiWv72sTjgwH5mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X2p6cPEw; arc=fail smtp.client-ip=40.93.194.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRzFvHIoAtYVth5V5GxfuMOtdhyHnTyDCGCM3bAhpVNhNmBuLlyXjhItCGrZtgFIuS2Y7o8xaSIApSiivsVw8fZr0nxwu2YeHZYGXnfU1wq/D5Fga7sQ1Ko86fe0uWZYJ8gRnK+rwdNTYeAVqq3wnRnT4GC/JHJrLkywHxrtKORUz4Xzz7upBjSLplTk7weS9SeF15tYvQ9XrBY+Cqz4VvNr5m+T3UB74nk5Jh2OXzzktJoS7GagoWIC74q2vfuSOaAqjcMpfOwJPqf5B6mb0R2XB27zHHWg7AA7lSW++WDq6v2rK88tcPEqcucRpYjebE+RXoQgV06Wu8LCjflbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkI0MJxPKH/l4KHI8R3iTGH5GJw1hG/6niatmIKE19k=;
 b=ru6OszXAnTkn/5AF/H6x7yi8rTf5qSCQMcE7zsTKKxMcPKSFgJAIlGpCAJ6HGUIfEW8e50/prQZUIoOgBIf5H7OG9S8i3+bfC5Bo/7sKD0KpDt0bYJXtU2sZoQS2K00t5D88PdAY07GRCjryaCek1wFod4AUsmkGs6WzMuFroyKFre7On+O3flk41VUkZQt9WBkpMETIBUwWscS9AsN5KC7bxmeRhuHMXClwGLiDbfwfa5Hv5k1MBSTK1gMvt7E7Hc4VuM0Y6Gh+GaoS5mVsCDYrSN7oDkVqDQFH8ykfIES8taYbyYuMgqVyZBgNSa/8i3PkOiWY+W5w5jKsbDHhMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkI0MJxPKH/l4KHI8R3iTGH5GJw1hG/6niatmIKE19k=;
 b=X2p6cPEwRDiqfuOTCwMi0fNH+3C1/p5cmACPbS9BeQwhtBnLmImGk5V1uU9L08jeSfw1GFESh7VcsWZSRlY+kuDbfWDgMUbX2Zjy/lhuUUC2/Dy1XPt2YigV5XfIH7/ywaRtjpBSGPZTTOu+8j2krUBr5tytZkcSPZ44q8EiPhc=
Received: from CH2PR07CA0063.namprd07.prod.outlook.com (2603:10b6:610:5b::37)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 05:10:48 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::6a) by CH2PR07CA0063.outlook.office365.com
 (2603:10b6:610:5b::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:10:48 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:10:43 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 03/35] Add vm_vaddr_alloc_pages_shared()
Date: Tue, 23 Sep 2025 10:39:10 +0530
Message-ID: <20250923050942.206116-4-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923050942.206116-1-Neeraj.Upadhyay@amd.com>
References: <20250923050942.206116-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4f6a92-80c6-42d1-7dcb-08ddfa5f8ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ez8dTp2cEuNUk70PVzWKw6lJ1a+zNzszpakxRwkg3FO2Pf41qhmunp978QGK?=
 =?us-ascii?Q?heB5RylXmw6t0G451cmOTzbB7vl4sGYVZAeVmGE/TkTAhYtM7MZV5CVzX8+6?=
 =?us-ascii?Q?LETzC1DFJAz412uSJb4ac4BJyv1NeAs/VCrQZ3ii41CtOriV21+W8ddj6G4c?=
 =?us-ascii?Q?zUuVro+K0KUrUZ6LN4xNEcfZhXfJNE985EKGm2ApV5MKYkQVlZRQ9F1kNUHS?=
 =?us-ascii?Q?wbjbMYFKkwZXH45KjFYYQsjvibU2qPRUf++0aOTw0kmcdCe/1nqF5lvNpcwe?=
 =?us-ascii?Q?V80lShrnR0tVQXPZnZ+8hAhVv2vASQZ6sSdAzED31bapH0/TUk1YAC7shhPQ?=
 =?us-ascii?Q?N3ORxP8CEl/wlOeNat6OyWutmVs0zD3zPKbiod4+QNfrTzF7Z3po4h8vA8hq?=
 =?us-ascii?Q?QC2PRQcwUH+V2v9y0ix/juA1Rb55FJ9gOsso5DOrX70+g2nCHRCEAEa46PkJ?=
 =?us-ascii?Q?O2RA1eZMFSfpKhgaQNh34m17WfStaYOFk27C/vr9gCMYkBoJt3hYd7VJmJfA?=
 =?us-ascii?Q?w5jqxTqxOWhD8MiXA1oKfl/SweJP5qXNIVgXdEgHgZ0TPI7nzrp2aF+zCxyb?=
 =?us-ascii?Q?yQ5RLMO7zOrrANIdNPw7xziygLiLzpCsWZSyZVeutVybUvnqxamw5yndTtx8?=
 =?us-ascii?Q?m+eIdF2RGkTJFhcOQJWBOsn+U9+kwjnDZiAzVn8AYuHVbzcI3dHdLHua0eVj?=
 =?us-ascii?Q?qsk2d7fafFqSGLqtEyvp/3pc17cnoXIMGU1s0AkezbuJ53OqRIsL1+EQvIgJ?=
 =?us-ascii?Q?x1xYaUczckFio9ONPZlOrgUy1zoSrtQf1ey7e3uogJds/Ub3oe8OjrKb2dyw?=
 =?us-ascii?Q?/qfXe9rgGWFn/4oD/NNjRSEyvJiPUE8KdgEb0XIVYNxeKdFueVhHkv+AXq8x?=
 =?us-ascii?Q?rKqHlAk16HkSrAKCIveqKeJXJbviJ6IyP0rZXO1sofxyaXb0wDu3UqNW0wSn?=
 =?us-ascii?Q?I+RWMFsW1xSQrYH7uKhka6wMLiBV9qRw773MbrN4AcSe+sCh2+Th/SLcuGGk?=
 =?us-ascii?Q?GOgF6t9/RdeX08FpZVbsqPKz84TJ8o1xBX+BSqA6oDb8fa13s2T1N6pohutG?=
 =?us-ascii?Q?OecpwOl77DoohE938raPeACuZHuo09RWgqU2PSgYpwRNEClSEzE5X7kD8CLl?=
 =?us-ascii?Q?JxtOTmFuzhn2MM34ceU964lNB/KgI+95FOVQLJf7sKBh0X616UleLbY1xSqC?=
 =?us-ascii?Q?eppiHz317DGc4NxDv6wKA3rwzbWCj3wLT8sdCR2IO/ZIhsbGpqXvrVPizhae?=
 =?us-ascii?Q?9pLCQIb6514GSKnwsuXLqcyAMhzg3G8JUNgjB6KE5LzlIee8tX4kXN52WbVl?=
 =?us-ascii?Q?GxhRyjYcwgSjgLPrXMONvPX+K8jDve4jVqW8hdw1MOxbtVvzphr3kBkmazDR?=
 =?us-ascii?Q?CjHoQRGT679BBRiW16Nill9Q1zx8NZfkGp6wbU9TR++5kV5yVygXzAA2CnuY?=
 =?us-ascii?Q?Mix5Hg3PRpdeSINkvlfdRiuBC1W0Zaq4SHSu03tJjvDc8GRFRSVHHKPrMXV0?=
 =?us-ascii?Q?BFOLzXCORyQKz040H10+hT8dm78J2cd+TMrM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:10:48.2971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4f6a92-80c6-42d1-7dcb-08ddfa5f8ef1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764

From: Peter Gonda <pgonda@google.com>

Add a shared page allocation. To be used for SEV-ES GHCBs.

Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Carlos Bilbao <carlos.bilbao@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 1 +
 tools/testing/selftests/kvm/lib/kvm_util.c     | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 1a9764658eb9..2e27682c5077 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -696,6 +696,7 @@ vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz,
 				 vm_vaddr_t vaddr_min,
 				 enum kvm_mem_region_type type);
 vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
+vm_vaddr_t vm_vaddr_alloc_pages_shared(struct kvm_vm *vm, int nr_pages);
 vm_vaddr_t __vm_vaddr_alloc_page(struct kvm_vm *vm,
 				 enum kvm_mem_region_type type);
 vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index a3b16793b2fd..00317ce5dbb9 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1562,6 +1562,12 @@ vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages)
 	return vm_vaddr_alloc(vm, nr_pages * getpagesize(), KVM_UTIL_MIN_VADDR);
 }
 
+vm_vaddr_t vm_vaddr_alloc_pages_shared(struct kvm_vm *vm, int nr_pages)
+{
+	return vm_vaddr_alloc_shared(vm, nr_pages * getpagesize(),
+				     KVM_UTIL_MIN_VADDR, MEM_REGION_TEST_DATA);
+}
+
 vm_vaddr_t __vm_vaddr_alloc_page(struct kvm_vm *vm, enum kvm_mem_region_type type)
 {
 	return __vm_vaddr_alloc(vm, getpagesize(), KVM_UTIL_MIN_VADDR, type);
-- 
2.34.1


