Return-Path: <linux-kselftest+bounces-35908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 972D0AEA6E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193283A4E88
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6732FC015;
	Thu, 26 Jun 2025 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RqhCt+k9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4212FA64B;
	Thu, 26 Jun 2025 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966562; cv=fail; b=QwvmFnRaEFIgKNk1Pq9bM4Aah9KjN4871Mj4MAvBGuC6ZBmBidG0HkjAtXhj9uRosTMXSBtn5Ik5cgnFre5WGDlK+AlS1vpMskyab8Fzxr39t0VpEt+H3fJostLWUi4Yhfy1k9BAp52yy/7dUgzw+LT5FMAcZe/kuNVe2PPwrfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966562; c=relaxed/simple;
	bh=D/6G8y8On+326gHYmip5Eq8Yhgz4Vss/ixHGuIOjq7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vE8xj5WOJOaGP0GVjeN92TP/SE5Qgb+a1Ep2X6bHlHz8A3xWIqTkSRVpynDZ0vceegEKBCjyJ/w18Wb8+lsvgT9hKwPyiefKAs8TmqOqF8SoPpo4INL1EFDrz3rqzNbDUTTw4FLNiADQiLrac9u596phgV4S5KBJV74K3A8wz3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RqhCt+k9; arc=fail smtp.client-ip=40.107.96.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3PpsWxxYRdoj3nbENTjsbM5AmBCMZhb+lLHmorDcksu0jXbMhCoUAyT77bgIagD58tjQwFQygq9FoL78DXFRbwDqL8johjur7cbdVsYOBk48PIDV+PMmVCMlWrtR/xRg2/ILlEQUlURCoWEgfVKH6ylCJoumwhfUoW12lpdZcMWjEP85Z/q8a1vWKxsS4RZm2lZGGKTOZNAemTBVUotE5hnDpr4aRWZ7zNSu3Q8AwSLJ+w7g/RodX0RWrylieE6cXxSbQpUUx8t3mLcblI0I8cjAdXd3LjOnC85E/oSoYdDqUQf24uci7AaqwcHcw6QEE7KJgeB4w4zFSgFn7LVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP4++gMVso6NJgCf4yKAKkzqkAKXxdKz2sTcPjJo/tU=;
 b=DoRU9KeOVxDqipIhGRoHPLjnVlyhl/2CxEDxyN9RVe3DLqz98+6kl5YK+Cf0i9PcSncn9oTdcFk0pXB7tlCCp2RIwfbJROf9sTqDodXMPDOMl/9Y+Y2ZI19ivgUi1JXcC7Uu65lbCknmGp82/waz32BNlQDWuAiKo+LMW26o0XeoXHrwqHKYlPJ/wdmgzDLLgO+8C4J+0LgIoIUWBpZGbXEWTqAYj0MtSA/zkyDF96czd1l+Mxwuu21DYD78nG9VPCz6pgiaj5qpUBEVCrzFwDspXzrTSRAjCvJxQyD7I6dTCzhMeEqienJRdVlhZnnFENJuqgTIUtgF0LZSM6rv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP4++gMVso6NJgCf4yKAKkzqkAKXxdKz2sTcPjJo/tU=;
 b=RqhCt+k9+xBj89RupwIY0/C2PPGJDULWLtyxF9vnCl5f0wgdlZQcYMukdfPWIhKuPSmkwOCsCuxCFf2vxF4LYph3cnKDlY+F93XPmGp7KhPLT/UygC2l3KO16741vHFqbiZhq/OyxASxEh3p98gSKin35X3a/jVL/n8IHNeLDunhFy8bdioMaP8Af33ScckBm4ZzBthSzv4FtS73b1/WyteMyDO2AkfL4SqutNF+ehrRk4eLGAUNZOUJyraSDEbjIWlc61GKwOFfkLbNABGz0B97uBFequ9HormivFNaN0ORcL4F90sYpRdoS1dNK0HoeFJviIle3gZA8Hnx0hCPbQ==
Received: from MW4PR04CA0125.namprd04.prod.outlook.com (2603:10b6:303:84::10)
 by DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Thu, 26 Jun
 2025 19:35:54 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::86) by MW4PR04CA0125.outlook.office365.com
 (2603:10b6:303:84::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 19:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:32 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:32 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v7 18/28] Documentation: userspace-api: iommufd: Update HW QUEUE
Date: Thu, 26 Jun 2025 12:34:49 -0700
Message-ID: <83b9571cd6a80e8c5baa8d06cbf491c1709a05ef.1750966133.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750966133.git.nicolinc@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|DM6PR12MB4387:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e28d5b-ad25-4e11-9a09-08ddb4e8aa3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LjSlt/afyHTHjhP3zwt+F9o7yMbttjdVkl6pSS6b9PO5jlDdRjyFWwDdfCL6?=
 =?us-ascii?Q?Nr55I61tFXRq+MiHKj+CNScD3XhHRZkngng3OlZ4+Cl3iMe93KORkqkCYtip?=
 =?us-ascii?Q?KAhtDuTJTlEs4buJmI16MIEfMIuIC7xhPvI5tItzfTp8y3zBph37VdDPj8ab?=
 =?us-ascii?Q?gKMw3fwt/8jXpsyBLn4Mf4XOl7vnI5ve0K8Jw6/gzG3+dF7VcMaHMXkTFgMv?=
 =?us-ascii?Q?3PtlmyleViHcCVc2ktu7z4fqpQHu5NVBQw8qSwR95kEvmVhE/qPSZTMC4ox+?=
 =?us-ascii?Q?V7BMXHObNYsywW35IHSTzQ1mhj7Z0TLDnkMhVALiS1Es8vs671qoa/Mnpg/z?=
 =?us-ascii?Q?gzV9weeoJPiSrowf8T23vYfta6tu5TvJQAZozHIVkrIx3njpr+63foGkWFNx?=
 =?us-ascii?Q?IU+tlfuitWC2YEvzY7gYUBS/aZQS81XweV7vYM5YOxfSRWfKCKiHqyO0z6fP?=
 =?us-ascii?Q?beZE1cRzGdpHIAK72FLw1YN7+xh69z0bLCBctSmtE1GqduQPUTtyaQGwXec6?=
 =?us-ascii?Q?/uaze2kIW6IGG5M/cA4FMeUag9haDDPmYQKxn9XrUurQcu7LhgNoM3/VrL2X?=
 =?us-ascii?Q?mbuvXHm8+L2JXsPJTtScuubwpGIK+UVPfVnKeqyiX43AQfTWTHYh3PSP853q?=
 =?us-ascii?Q?WPEj4uglwjIqf9ykrwchF8j5weiMHaZkxES+tE3h3WidS5/A+nNQHAKILRsA?=
 =?us-ascii?Q?jo1QBzau814jOZe7mlp1JBhbazqFgWeL9qzEtAhJsYmzI1wns5AleNhmT0oS?=
 =?us-ascii?Q?t5VaUA5XklhPhAeQ9aDDUgXFv/Ik+mXhLFkG7RgsIYGJF5p3MktfhbXbVRVb?=
 =?us-ascii?Q?sITI148r9E0KuVshEfv7SXTyFq4FQpYOAAK6bDLSm80kiZxOPQceKzpvuYoF?=
 =?us-ascii?Q?1d2iE0IWzTX30CjVDCxMBXR6626kri9hiDRdw0wzj3LImK+SAWeuz9zhg3o5?=
 =?us-ascii?Q?RyJcAc/5RMNaOf1VdGHhRh1JwUeMp/tMeZlISNYWrwxjhR8OA2+dgtfe5CM6?=
 =?us-ascii?Q?hNe7T0tcpCp4Gc9cxmqMzYd/wtdEVrCxzy1xQO+aRkcHBDMxgjjU4dHzfZH+?=
 =?us-ascii?Q?z0x3/ppVVWbH7Mp9a+BKbCcALXgeAKf6ZsiF/OBOw9mEqW/pA89JtTdFOe+G?=
 =?us-ascii?Q?pNyO2K6y0R71wxpyhTr8awor6k5viD3rMqRdisjOFH9aJUiXmFlolmJzG6wF?=
 =?us-ascii?Q?9qvi4XGotUCNc3xcncM2+bUdzgR4dgxiysRaod6D4puvNuyp070vnulxSHUx?=
 =?us-ascii?Q?vcD8PTE+erV3pB0inn4Htcs/OFGzIdWMoBcZGHUIly4JtV+ZfKnNYDpOI3iy?=
 =?us-ascii?Q?P+1hqdIsQEG6Z2tbDrrg67c8dyYRKVnAAAX56rVBbEpY663Y9e49scMUWcGU?=
 =?us-ascii?Q?a8XC+HHEGoFHAF9mCg9xozOg84nlQRgyJcJYojJhgf027bnKFSif/RW7YiBx?=
 =?us-ascii?Q?Re5iDw4eLgmyc6sylPWDxZ7Jezf9lqEmhMKIzW6etCNOYG04Gq+wsSOr1c2m?=
 =?us-ascii?Q?ICeihQMD5VJ9KsZEocwBvxOrARTXTN9/CVd9?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:53.7896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e28d5b-ad25-4e11-9a09-08ddb4e8aa3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387

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


