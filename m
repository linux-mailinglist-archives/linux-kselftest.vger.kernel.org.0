Return-Path: <linux-kselftest+bounces-27232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD06EA401B9
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 22:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2EE3B82C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 21:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B038253F35;
	Fri, 21 Feb 2025 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gA59DnBW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A849D253F2E;
	Fri, 21 Feb 2025 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171848; cv=fail; b=YRwKDgkQTqH24/A9guAoByoUBApdi95IgWI0TJJySut1FCqPb2DdtKDvv48E/mf/7Wbrfa19zNyc/yV5l7EkwO9hE6F0l5rHsJVPYS1xED24x8cU0bFLnS5kXThb30uRgF6v+mfnEwgmL0I4Oc13As5Q8+rqZ6IeuKmGbauBdCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171848; c=relaxed/simple;
	bh=Wh1VQunxSshhzHGnqMnZr2cx1/MbSN/znQMG2r1BSzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWEAr6kjccuDgoGZ8GnwmhZEOMx/puaVy5FZEPBCgIuQDPKgtQf7pyFvTbb/EXBI9tsRwf9juAWYBPemBTaAyZzf+KaAVqOvpkcHu4avWlE6zYmfra6JoSJLBdRrm5NyL7IKPCVNZHz7FJFSlvwhsRiC5SLtBUlMdF+0fg3yixE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gA59DnBW; arc=fail smtp.client-ip=40.107.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbYP6F30Oid0VgtJVlfVc3RMu/E9BBaqI6vJnjFtdaU11HOuxd6eaa8Wrvh7a1XpMr/ddC1OJMfgQoP2uz3tznrsjfXjcbPPMcD/XMX3RhVT4PoMHSZmapwyjHEvuFz22mj2LmFTpENWG/RMAGjn/RGrXyvDSc4IIv97m2yidIvQz5Zi8HQlzLun0M0SOW8lYuDGNyN2XoW80I+bqVEZQbwvGic1lFRL5xoEs0tvbgOwdAlLhVQGQS/pU4iDypOQYbmp14jr8wzCR5ipBUQb/IJeKMNd/PFjuvEBoj2MIEViF+KRYC9QWZHRxRZ1lS7MnKzmV9eUvOIDWNHXeuVwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPm/75WmSpIvUKzTZ946aEih21z1rjQg7DpJCU55CTY=;
 b=bkUrtabv17WwJA+FQQFYOyPnW5bDklwpL22yfHAczUv67NPno7IRTbV22+KpbwXlES/r9+/E78J7/P3WeuATfxs8WzoaK+9Kn1bao97m+fD7wGh/8cQ41RBgVGO/d+ftnH5SOo/f894juPY9fO8zDBspyBC8j91XZqGb/XShqe3s1JbJOrCqIHD1T4rZteBmirXPna6MLRrI2qOzXZ2s8yLZBPay2v/IlPB0Cqp+Gm4AmA4bUsmpvDMrxahR0/tITxHBX8iUn/n87r5bPbP4Cev+25GIRO4ryH9HkdK8Pi4hmHF3GI8P6gqM4IJ/fVMrDCLYs9/oW9uD4YIPD9SD6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPm/75WmSpIvUKzTZ946aEih21z1rjQg7DpJCU55CTY=;
 b=gA59DnBWiqLOewB/QTjkkiZDkfNvlCY7ucXKa01K4pq+gqpohqwv9LM6bp7XXrVcutxo3/xE9k7C8DgYnRLW1WcyaNfgOdEEaAR6d4YmcjPfMmi70SjxyoawlUt9r/zGHtWNnD11XLB1o1+a2NY/aRiaRoG58iQ8pycpcPhrjTA=
Received: from BN9PR03CA0166.namprd03.prod.outlook.com (2603:10b6:408:f4::21)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Fri, 21 Feb
 2025 21:03:59 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::37) by BN9PR03CA0166.outlook.office365.com
 (2603:10b6:408:f4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 21:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 21:03:58 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 15:03:55 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v7 08/10] KVM: selftests: Force GUEST_MEMFD flag for SNP VM type
Date: Fri, 21 Feb 2025 15:01:58 -0600
Message-ID: <20250221210200.244405-9-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221210200.244405-1-prsampat@amd.com>
References: <20250221210200.244405-1-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4ce0fe-6f3b-4c77-30cb-08dd52bb42c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J75oymspuRIi9jd8BSXgke98qvN/pnTB5K+H73bU2hvaUm0xpAkvDGNAG173?=
 =?us-ascii?Q?uNdvxmFM7MR6AGAzcsstIiaD2P0QnQZwUsM41Z3C+fKJsO98HMWXxSES9hNk?=
 =?us-ascii?Q?MNXhl3FXZmgGCNevGh8pJ6cIYaTQpQHVmSxgvbw0CBNa0GL79LiLVGZYvyXI?=
 =?us-ascii?Q?+dywdb+k0NwaBaZrlqzLz79kbTK79eoUfwLHr7MmtMAcbUqxqWRFo/UDE4Mg?=
 =?us-ascii?Q?XPH/iWXSO8Ik/MNTXcApFviQixwGQcXHfQwFNyAKmh1OLH+gwOgCHxx8J4jJ?=
 =?us-ascii?Q?nWCCw6Nhm54iwKNOtoTG7JCDEQLltBPdtMMxHrlFUNpy6Ct6IrGFMP74ArxF?=
 =?us-ascii?Q?81REu50wZntc969rsxqejWxq34R2wgb151oi7MOcHL+FncKzYMw9sRaGes5E?=
 =?us-ascii?Q?RfRpIPRTzCOqxN5/TPhHt7HOQTfYSnvpuvXC2KcP3ys1M+BOeKHab/uIsYDr?=
 =?us-ascii?Q?zvtF+CwXy1YXGZrc1yiRKEtbZrqldyutUJrzhTexqTOUljuoBrXE7feQzHgZ?=
 =?us-ascii?Q?9G1EGSzlcE7mTBIwuLsTCJKY3gMO3OEsDIaViwhzNnMJlh1HRir8KYuVmk3o?=
 =?us-ascii?Q?1H9zpBDSUoNGQunpyeiIEfF/WvuTZQlj3g4nY2bJ8uYJoPQwBOvqudzQ797o?=
 =?us-ascii?Q?p6DpQL6zLk5SIQ1zKqX1oPoZEMZOdLhty1ZbhFjwbQ1YyacrclD5f8XQ9aB8?=
 =?us-ascii?Q?IEZ1+TWwSp7sMrSn5GoylwNDuMRL5vaUm0seMavCpkFL03xsqijl2/BvGG8B?=
 =?us-ascii?Q?WnhdxrwDwSx6fx8dB0r1d18Zk04frSVpNFYcrf2Hk3m03F5k0XN3LDQRAQJm?=
 =?us-ascii?Q?JFRsVZwgXhEl+eP4fSl+5kBbtfO04afXvoqdbjGkXOGhgi4K6KrR9aqTZc0S?=
 =?us-ascii?Q?vQEZY1hjptmuNS2NYeVXNAoZ+wvXimwn3uyWzYVZ9o2y93Z4IZ1G2HZQ2aME?=
 =?us-ascii?Q?ro8hATv8lVG7LxyMBanUSTnBNLdlULE+i6QXuNGnqlszaFQ0ZOApW1DdOy7/?=
 =?us-ascii?Q?Lb7F4C+aqoHpn8kUaqNK5M+bGQ7UhT68pnIif7eDPoc43ADIYFlj6oWmA053?=
 =?us-ascii?Q?58hmt2qgW7Acp+kTvnbNaP94jwPzNA0UC4iZpjAkREF4ZOwiP8B6NApXCJqq?=
 =?us-ascii?Q?vMHCsFL4Wn0FZcYFafoLfI8QBRvqQljm7GdivZfp4sJTT6lblqvkKDXx2p4I?=
 =?us-ascii?Q?yjhqGAxgiosI82g9cYjEVm4cLG6Yoddmw+QSHVSm9yFj3GSj71Zru7IrFETo?=
 =?us-ascii?Q?liJAkDhKyMjYXjH3GZYs5n1JMxDIJ1BdI9gxLQbs10ccH/dbc5EccHSpgsil?=
 =?us-ascii?Q?nDF08LodusYA9F6LclAvHYujsfvhMOAu3HG4Xp3Ourhkye8xmZvQQ25YuogQ?=
 =?us-ascii?Q?nwvyTjIwDmf5tbdFntSU5CpN/4WwxLEBEGfybY1WddVRFWc9sBcUhPd+wLvw?=
 =?us-ascii?Q?nmd/gUySgQ4WeMAivbiHOlqjwsPjF4Xdl/DSqJDb6FbalSD5X0WJNO33/WAh?=
 =?us-ascii?Q?UwM5zkmvMTOU+2Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 21:03:58.7950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4ce0fe-6f3b-4c77-30cb-08dd52bb42c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169

Force the SEV-SNP VM type to set the KVM_MEM_GUEST_MEMFD flag for the
creation of private memslots.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v6..v7:

* No change
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 33fefeb3ca44..089488e2eaf6 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -413,14 +413,17 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 						 nr_extra_pages);
 	struct userspace_mem_region *slot0;
 	struct kvm_vm *vm;
-	int i;
+	int i, flags = 0;
 
 	pr_debug("%s: mode='%s' type='%d', pages='%ld'\n", __func__,
 		 vm_guest_mode_string(shape.mode), shape.type, nr_pages);
 
 	vm = ____vm_create(shape);
 
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, 0);
+	if (shape.type == KVM_X86_SNP_VM)
+		flags |=  KVM_MEM_GUEST_MEMFD;
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
 	for (i = 0; i < NR_MEM_REGIONS; i++)
 		vm->memslots[i] = 0;
 
-- 
2.43.0


