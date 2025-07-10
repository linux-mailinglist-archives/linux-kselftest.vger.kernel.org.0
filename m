Return-Path: <linux-kselftest+bounces-36922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD8DAFF8FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2D31BC6E82
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0235028D8C4;
	Thu, 10 Jul 2025 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tEE++2df"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7A628CF4C;
	Thu, 10 Jul 2025 06:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127246; cv=fail; b=AstZHAnRc7WJO7a1P3jn6jJUKbUkz80PAz7NMtg/khkGJx/FRHmE6v6UB81mf6rTb5a8N+bmPvWAPFMW12FKMgirkkONtrHBs6tnCOGpwwuw43K8HOIfCr2KmiYr3FA0TtdqPCQpvPT72KXc9jtHUPEqkZb8WQ0bU8uZ4GQNyiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127246; c=relaxed/simple;
	bh=D/6G8y8On+326gHYmip5Eq8Yhgz4Vss/ixHGuIOjq7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiEogK4LwSAYVSavzDtV1Tyfe5wG2yeWH1Tnn1+oQBA+KyhFc+TdMRsQo6szJW2FZUdbJ38O1hdd0k5VmMmrjMYCXaf9Mxh94uAsImz8ADZ1PLfySKGgV63segBB4I+D6FiWciOQenu+QdGUBKwfPOb4rJML3M91JtZ61KVWMUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tEE++2df; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okRjkcaLlNaEgL2bi2vU3HCkcP6hcjDvz4cgKY+Gr7hs7ll50uzfd9MKtxwERe8rrn030zSdCMokEgqadJyPia9eEFeQ7Aslmb8kfH5nfxqyCT7f+7jYX921KlyFtOTbUTbRi31u+3axkR0KI4BzZpBOcHdmdSQmyi6B19r+w74DVh2Sx/UTLT6sCTWLN2gagLxQStJzXca0AwzC9cH09hKvCYReM0j+lNpisrcHG0DqUL4XtgD4TjhfNkjh3ln8ZS3NMBAzE9IAGlttnKcpTgHabkrMgD8k+xxwbo/e4mOW4ePScBoHf+4XjUxvcgSrEcEX3Qz7A7rTFD/xmT5Eag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP4++gMVso6NJgCf4yKAKkzqkAKXxdKz2sTcPjJo/tU=;
 b=XdnV6f18gFfYu84xbJqdBm4ITprlWHxGGLhkZTDa0aTEF7yjItG9IYa9RTZhoSb1oigwMbnAU8i9iYG8GAJZTjabTaIIqtTUPYHHNMLGSq7h+DEKqJQPDMiKWpmcVXI4CnVv4ox4uHImagUUuezPCtyUd+DDcNWkb/TsfIiX07HGIUozuetByh+0rQu+uaCmAdlYY4EILHwA4ig2hL3/Omq0ZPBcrS7/1jczyoo3fzcGzlbVZ4JN/FBx1g8s+ZLaMYC8ULcp1cltMqxkc7oBBXL9d36CMI8ulrd/1Nx5fdNvgWBiomNtNcuIVLNDFDdTqpcuY0gz5flMEm2E8P0icA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP4++gMVso6NJgCf4yKAKkzqkAKXxdKz2sTcPjJo/tU=;
 b=tEE++2dfMDlTJzM8Ningz0Y7zdMulXPkYYEh9lT+IWOnuPMQ3C7nU9fnt8Mb1xaLZaT8I7DVfSERJerzRKHktXcm/BGxEzeS7XQmdC4XtE8Z6Ca+CnEixqDArKouNd/JYtHtiRAGKL1BGSrPgj49YP4mkuTe0lolVihWRhZfI6IKBrTzJ/67LKcY9V2DYl8JPUbztdgQGy7h1XlRCgWf+N0wcpAkdSTd9VQ8OOoswwFH6clQz1r44imsIpDbm4N9TxC5sw4JycRdT+dEPh8F2kwGH6UMH5x8SWE7FO/vXgbPRbO5eHu/jgirkBeGBEfrCQKqYRiqke4Qoxr0JI+DUQ==
Received: from CH2PR18CA0021.namprd18.prod.outlook.com (2603:10b6:610:4f::31)
 by DS4PR12MB9820.namprd12.prod.outlook.com (2603:10b6:8:2a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 06:00:42 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::1c) by CH2PR18CA0021.outlook.office365.com
 (2603:10b6:610:4f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Thu,
 10 Jul 2025 06:00:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:00:21 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:00:21 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 23:00:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <bagasdotme@gmail.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v9 19/29] Documentation: userspace-api: iommufd: Update HW QUEUE
Date: Wed, 9 Jul 2025 22:59:11 -0700
Message-ID: <caa3ddc0d9bacf05c5b3e02c5f306ff3172cc54d.1752126748.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752126748.git.nicolinc@nvidia.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|DS4PR12MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: be660bcc-5d0e-42f0-e9c0-08ddbf771a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bW7VireCVAH5sxEXAgWz6H3O/5Vy63iNithyX3DBrLRS0cuAtpS7LCoAMXrf?=
 =?us-ascii?Q?+FuwMgXEWMkzBAPVVXnDOI9gbOwC9hzxnTYdzkKsIYoZPdAIkNvxeQWbZnh5?=
 =?us-ascii?Q?/arkZ6w7M5xcerTQDlRVk2J13lrjNj8QtcmohaLMi0hWxLZ7k+i1hchmUFbo?=
 =?us-ascii?Q?eVsHnLxE0lgefMTvizYhKFW9CSvdTA4cHU5bEUaKeAwwo2yabOchhaMqDe5y?=
 =?us-ascii?Q?isZ7+VWqK/gVzCBWLs+NyDi+slhNYbVbiUQwHp7KwlO0GmCqX+4zVhVaTuL6?=
 =?us-ascii?Q?0dppSjdStGUU8N4kS8SVQBY36GSbTytkoVixkgVzhZMrTnpd+eGSzRCHrBTx?=
 =?us-ascii?Q?+xiZjsPKOnICKJMYGX0BTMsZ9KadNDvzXBDij1d1D2UkhYRfARN/Z+v1T6gN?=
 =?us-ascii?Q?Qcwribbi8AQObVaBHd0Az8lTxI/K6mr3DuMYiiNWw80VFSdUJwsaLwDYVqx9?=
 =?us-ascii?Q?uqOsx1LGn2Q0CT3OGHS+NAxHY3kPn5A14xtQsTSAg19P8IH4netXvLlOqoNl?=
 =?us-ascii?Q?VFqdr6xvtSc9HM2p8ik5DI/uO6C/J8DB/rUtYyw0cXjERRxVel3z/CpKZWek?=
 =?us-ascii?Q?TrIy/mRlJOygE3O61ixE686C14+HZ5QlbZDLJxXQ38sCvA+diacTSf2Erxy3?=
 =?us-ascii?Q?ROquV1f1PWc8H0VFISDtBav9QX8QVrxr4kSMvkT1zhZFX8Q1AqBOKyHHhxOY?=
 =?us-ascii?Q?3JSMqSa5IRh2+kgtgY2JaxArs5M8mJ5pD41Ur8RhtJ+RKpppLG4myMm2cNSF?=
 =?us-ascii?Q?q3mBU7fsVe56nctTaymQcvTbfATymzrrnDlP6874Nn+BastS4y4PJVfka2K1?=
 =?us-ascii?Q?6CP4PblRnZs7fd6FUxfntcGToIHhqrCQlP3qP+RIUcu+ZwOcBQ/+P+viBk6A?=
 =?us-ascii?Q?tjK+epmnx3ICIAWmqggnz8OrBGCRAfgFJVqTV0pj6CXXTQhulklaUuzy7bHf?=
 =?us-ascii?Q?fHgOZ6NlPx2Q0GyXzyTMjrDG4I9dwIRVhO/QxUbV8924dp2NS8Qn1fd/AD4y?=
 =?us-ascii?Q?mfD0Z9upOIvRqZ0335J/3/AXIpJ85733b6zil9vdKWMrrk/K9DG26GwwOFYd?=
 =?us-ascii?Q?NzrHFzrdCgBuhkiR1R9zR85h44R/ghf2zXoi5WwXONggOvl0qUonR3SXw1sw?=
 =?us-ascii?Q?vfMjyV/byDUJRAgb8Hss3D4A68mt+AdM0ku5UjtAtAUOV01Cb9yAXgdxNVn4?=
 =?us-ascii?Q?n0/NmqD/cYNZ5rumDetGkd6AS0/STRnCaunVLJ0Ij3XtKBsx97Xh6LM7oJ8V?=
 =?us-ascii?Q?YiCGa3pw5SgafKlUhjmY+B18w/0sQmkUzJUId4DGWWrBVbjs5ppB3euAdMHy?=
 =?us-ascii?Q?lGiWa3w0FkGtRpWkLMgazGwstHKgyqX37G8mWmPc1sQYhcbJaXzQ/I3RrqA1?=
 =?us-ascii?Q?FCeK2nO2tnS+Qz8VYfu1J/g9JBrOlKKLp+mpo7pss9MTEfOHl6eqSvbCjJhl?=
 =?us-ascii?Q?zCYdsg4kwvk4uDPtObJ43wz47Q2qIQhZSMUulX8X2byT/KatgImT/aIqlE9/?=
 =?us-ascii?Q?7PxSCUiPJOUDUUdFPcWzB9/QcBIGwOlOvZTx?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:41.7114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be660bcc-5d0e-42f0-e9c0-08ddbf771a44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9820

With the introduction of the new object and its infrastructure, update the
doc to reflect that.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 Documentation/userspace-api/iommufd.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index b0df15865dec..03f7510384d2 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -124,6 +124,17 @@ Following IOMMUFD objects are exposed to userspace:
   used to allocate a vEVENTQ. Each vIOMMU can support multiple types of vEVENTS,
   but is confined to one vEVENTQ per vEVENTQ type.
 
+- IOMMUFD_OBJ_HW_QUEUE, representing a hardware accelerated queue, as a subset
+  of IOMMU's virtualization features, for the IOMMU HW to directly read or write
+  the virtual queue memory owned by a guest OS. This HW-acceleration feature can
+  allow VM to work with the IOMMU HW directly without a VM Exit, so as to reduce
+  overhead from the hypercalls. Along with the HW QUEUE object, iommufd provides
+  user space an mmap interface for VMM to mmap a physical MMIO region from the
+  host physical address space to the guest physical address space, allowing the
+  guest OS to directly control the allocated HW QUEUE. Thus, when allocating a
+  HW QUEUE, the VMM must request a pair of mmap info (offset/length) and pass in
+  exactly to an mmap syscall via its offset and length arguments.
+
 All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
 
 The diagrams below show relationships between user-visible objects and kernel
@@ -270,6 +281,7 @@ User visible objects are backed by following datastructures:
 - iommufd_viommu for IOMMUFD_OBJ_VIOMMU.
 - iommufd_vdevice for IOMMUFD_OBJ_VDEVICE.
 - iommufd_veventq for IOMMUFD_OBJ_VEVENTQ.
+- iommufd_hw_queue for IOMMUFD_OBJ_HW_QUEUE.
 
 Several terminologies when looking at these datastructures:
 
-- 
2.43.0


