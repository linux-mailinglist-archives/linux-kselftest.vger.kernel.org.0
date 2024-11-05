Return-Path: <linux-kselftest+bounces-21494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E75D9BD6C2
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306D61F21B0B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E296217F40;
	Tue,  5 Nov 2024 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pKklU0Kq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0723217F24;
	Tue,  5 Nov 2024 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837173; cv=fail; b=ITJfrx+uzeeGGrsj9wvYx2oB85m2q6avRmNhPvnUMzqjwTEB5SSX0w8Pj/ksgUjaKLP4l+z3+W2jNMqcSn4vluwcnOpDG0CwqAjmgKRceEFgeEeJuyV82qWpVistZvBhlAsGXUB3QoO9uTNxd4rreaaAzGovLwaK4U5mXXpHyFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837173; c=relaxed/simple;
	bh=GocVtaFMHsaoochqOKuLkKKhvjxtmjEjd6YfhwyRl7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ptUlZygUhBbGIh0kYwZOEa3NMiQDbmYUAyTJFrv3XFkEH8eow9iUW8a07U5T1Q72HQ7wZkG9UDg+vSTmEhWgAstn6JH6rDNja4eQURu4guF8QJBopXINIlDMx3Bhu/DMtcIOW7tRozgMyVSeJZ+ul2JyQaAO/YxgILIjkTX4a2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pKklU0Kq; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhzbz7jQhdN2mY99NpJ3QuYLLKc7r/rAsHFrm+X/Z/LLFP0b61U8Z8XPfs5z8954r3V3grs4XJJN3VO8jcWRS8SIhAnvDY08WcxVWTc58DXCpb0qR8Cyt0pF7plD8gfhpIKlfGfMG0TzzUdytYk8yQDT7ndJap7vPyMMqbQ+6KilinDKfPdMHUlmrgKOZhBzBJ17SgvXWhz9Q5TyUTh87dDnB9iU/zSsnxG2DUY4786EVLTetzfAPmKj3Akr1Z7a4DnQDQeCrjBvrG2JkV/MrtrRxMiloYN/WY03Kwbr3Sb+uCSFosLiJSseIFW4X8j7vfdnipux/g3g+REJCMcLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aN+F4pjDlqW2Vnng4x77irAKK+1SAUAlq3S+25YamwI=;
 b=tv5Zk+Ztljg6V6rsM3e6JjRyKpA5WM4ErAhkaD0a8ngOsaWcKOTTmIYRRFcKkgZiu1/kkyXx38ILf6hwRjwakO5Rd2tRbCpuRwfISuExlStX7kVCBRnaEUn4unFqlxcdkAGnmxAGA0wSPANoaB/bXJeIhq0uhQfPHKwy9UIyjm3ixiXPWvC1IHdFWka/UcPEHtOT4yGHIekhcphdEV4J62n9VEuVOfESaa2dAUKvyDeIwTZrpMOhlp4seI+YlrrCoULKx/DYHHeeRRRWL/1qo0SfWaNCkvARAEVJYxUM+UHcMT1J/dMHcw+DUff9XTlbTWsmyzPdi7LYCbF0ZcZkmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aN+F4pjDlqW2Vnng4x77irAKK+1SAUAlq3S+25YamwI=;
 b=pKklU0KqUqK4JmkmCtTWXkTzL5U0VC+4qUpqwt5CPHq+RS501pPrAo9SwyVv1Jta9jXdfAFdjhq4f9p0wJ4iX632wj3BZAbdCz5cWCRO47eozTcM57/FqfsH4Heh5nJZNWLO2hbY4KvrM18a0dcRnLhAp0tYsxByKhXKK6aZCstjZfmZjTYfIdpp0AediBdaVAHGfvbhziuvDG/mlQjzjobx0KPfLIVmj4C5oeZQq7/6fgRYGQueLk6nCeCIF47MtZmGAcZ+pAPTZiA4mDYdqNfKyVWUfPuGnrNQIbE7DqU6z8wBp8xMu6/jCfHF9vBhIKigWMW4l7UQx1tk5Ew6Yw==
Received: from BN8PR15CA0056.namprd15.prod.outlook.com (2603:10b6:408:80::33)
 by SA3PR12MB8810.namprd12.prod.outlook.com (2603:10b6:806:31f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 20:06:08 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:408:80:cafe::7c) by BN8PR15CA0056.outlook.office365.com
 (2603:10b6:408:80::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 20:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:06:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:45 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:44 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:05:43 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: [PATCH v7 10/10] Documentation: userspace-api: iommufd: Update vDEVICE
Date: Tue, 5 Nov 2024 12:05:18 -0800
Message-ID: <e1ff278b7163909b2641ae04ff364bb41d2a2a2e.1730836308.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730836308.git.nicolinc@nvidia.com>
References: <cover.1730836308.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|SA3PR12MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9f576c-d0e5-40d2-5317-08dcfdd54973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HkdShU9yP+XOW8ZwhFbv70cy+7I9YzRDQSnGE8qNPsgHrGxnSk5JzRNKeFes?=
 =?us-ascii?Q?f8ibYfTxMFuMiRFn2kXHU0Q+kFoefGfannzinnP3XCsq3GmATfRzukR505Kg?=
 =?us-ascii?Q?bbsnobVPUR1coC81oNs86BM5IlbGoNnM0tRA/lxzAXwQyw1CaNzOTZ3dCBuu?=
 =?us-ascii?Q?cbxQzPPRcDHXs/9+rt+nSyHKcwMHJ49OYqF4/xDNr8ycIEgnhOY126JxNY7P?=
 =?us-ascii?Q?pSUnhd3AMSgSAq2xHjweKiQSM/RUI1Kps1YhZMU1zHdg2D9wpRCOT8tep6Rf?=
 =?us-ascii?Q?tDqyaQamYPjcHLd1HN/XtzQT9ONmB/sLVWEQUBcEiGryZ5kx9mH+oAXret4v?=
 =?us-ascii?Q?Rf1WVEreR/4daoAAl+JE3RdL9hl+k3ZO2l6WysiEVb7wXj2SGOw8g3XaRGeB?=
 =?us-ascii?Q?kbZnhZbN1zpvRcRd8ApizuzhdjOiR6SORMFvCvb8Rsy6I8QTbC3uZ8hrqNBH?=
 =?us-ascii?Q?wdgjjF6ZRvDUs78gCPTiwCjKTZXIsLDZgPyVvKv/3JGooWSMEOBU7xh96Ti9?=
 =?us-ascii?Q?V48LUm5Hz1iCbcGUGMpvB/cjcgIaLvu9VL6Icbli9V7snfazeHDFJPSl1e9F?=
 =?us-ascii?Q?V9rojqUmGPtbcGuUrOPY3YHYsG0gbCK+yGK1TsrMelTlnbK7qz+I58lWNDFh?=
 =?us-ascii?Q?JL+yEHu+Lg6WIaywvwoeC14qK/Z3/pTzpZlGIqcph8OTwIrga1qhBPITY11F?=
 =?us-ascii?Q?IfJ0hM3tP+V6xOqc1B4NbTqwtdf3qSLdbMFNZfqxwWg32ghxYN5nm3zlbGat?=
 =?us-ascii?Q?fhzvDlArzZhVIn6Qe5p+I/StULgK3NWE2tmqxc2IFnicRk3OUHqOOHKELLPX?=
 =?us-ascii?Q?VhZ2zP0DKLW/wNFY10YOaZW5zN+/BbJoZKixW1c4Px/fT1SFqd8Mj+O50LJs?=
 =?us-ascii?Q?Yj13ktjXOsmMux7zdLnqjyLODltl2+VX1w07jEOrqog7UH2LfQclHrrfUct1?=
 =?us-ascii?Q?6FNMNGDWKaDbOY50Tiyzxme705Anbxq/UfQlgkHhJR7QoccJwjqWXJzIR3gt?=
 =?us-ascii?Q?672DWA0LKjpal39WDmhTkqvgdAzTmdes+Q7psO9DqnlpuTl3U3BmtR0im0oU?=
 =?us-ascii?Q?iJM4zmeBu19zvLgC0stoYa8mUiPxISj9rNVjpBto40Hy8ce5CD5M4egYNO1P?=
 =?us-ascii?Q?AMMS4OPgpaVidYpZJ8lBTB8yy/zAj4k4qfRUcXczp/kQ6iYMMq9FTxe2UYK/?=
 =?us-ascii?Q?JPHzqHZ6WFkrpJND4RR4LKLsjC6G/XR1SIMr3U0SAgu1CtGZOOjK7wSlAv+N?=
 =?us-ascii?Q?CyECCQ5vj3Q/plm65t7E5U6gwE2wLifkQNwXBxom+QyU6YflLNf9BLyy7nmc?=
 =?us-ascii?Q?QdHDUEuYIyE+9Ngxj4YbTg/1Yp2INdFd8OAh/+2OyV5jBHor+O0u6cL0pyKU?=
 =?us-ascii?Q?a3KKWUx6K6uJDyn+4mVBCmP2iNRPPx0wisEn7QFHCnx9cUdg+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:06:07.9736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9f576c-d0e5-40d2-5317-08dcfdd54973
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8810

With the introduction of the new object and its infrastructure, update the
doc and the vIOMMU graph to reflect that.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 Documentation/userspace-api/iommufd.rst | 41 +++++++++++++++++++------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index a8b7766c2849..8ba868ce7960 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -94,6 +94,19 @@ Following IOMMUFD objects are exposed to userspace:
      backed by corresponding vIOMMU objects, in which case a guest OS would do
      the "dispatch" naturally instead of VMM trappings.
 
+- IOMMUFD_OBJ_VDEVICE, representing a virtual device for an IOMMUFD_OBJ_DEVICE
+  against an IOMMUFD_OBJ_VIOMMU. This virtual device holds the device's virtual
+  information or attributes (related to the vIOMMU) in a VM. An immediate vDATA
+  example can be the virtual ID of the device on a vIOMMU, which is a unique ID
+  that VMM assigns to the device for a translation channel/port of the vIOMMU,
+  e.g. vSID of ARM SMMUv3, vDeviceID of AMD IOMMU, and vRID of Intel VT-d to a
+  Context Table. Potential use cases of some advanced security information can
+  be forwarded via this object too, such as security level or realm information
+  in a Confidential Compute Architecture. A VMM should create a vDEVICE object
+  to forward all the device information in a VM, when it connects a device to a
+  vIOMMU, which is a separate ioctl call from attaching the same device to an
+  HWPT_PAGING that the vIOMMU holds.
+
 All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
 
 The diagrams below show relationships between user-visible objects and kernel
@@ -133,16 +146,16 @@ creating the objects and links::
                          |____________|     |____________|     |______|
 
   _______________________________________________________________________
- |                      iommufd (with vIOMMU)                            |
+ |                      iommufd (with vIOMMU/vDEVICE)                    |
  |                                                                       |
- |                             [5]                                       |
- |                        _____________                                  |
- |                       |             |                                 |
- |      |----------------|    vIOMMU   |                                 |
- |      |                |             |                                 |
- |      |                |             |                                 |
- |      |      [1]       |             |          [4]             [2]    |
- |      |     ______     |             |     _____________     ________  |
+ |                             [5]                [6]                    |
+ |                        _____________      _____________               |
+ |                       |             |    |             |              |
+ |      |----------------|    vIOMMU   |<---|   vDEVICE   |<----|        |
+ |      |                |             |    |_____________|     |        |
+ |      |                |             |                        |        |
+ |      |      [1]       |             |          [4]           | [2]    |
+ |      |     ______     |             |     _____________     _|______  |
  |      |    |      |    |     [3]     |    |             |   |        | |
  |      |    | IOAS |<---|(HWPT_PAGING)|<---| HWPT_NESTED |<--| DEVICE | |
  |      |    |______|    |_____________|    |_____________|   |________| |
@@ -215,6 +228,15 @@ creating the objects and links::
    the vIOMMU object and the HWPT_PAGING, then this vIOMMU object can be used
    as a nesting parent object to allocate an HWPT_NESTED object described above.
 
+6. IOMMUFD_OBJ_VDEVICE can be only manually created via the IOMMU_VDEVICE_ALLOC
+   uAPI, provided a viommu_id for an iommufd_viommu object and a dev_id for an
+   iommufd_device object. The vDEVICE object will be the binding between these
+   two parent objects. Another @virt_id will be also set via the uAPI providing
+   the iommufd core an index to store the vDEVICE object to a vDEVICE array per
+   vIOMMU. If necessary, the IOMMU driver may choose to implement a vdevce_alloc
+   op to init its HW for virtualization feature related to a vDEVICE. Successful
+   completion of this operation sets up the linkages between vIOMMU and device.
+
 A device can only bind to an iommufd due to DMA ownership claim and attach to at
 most one IOAS object (no support of PASID yet).
 
@@ -228,6 +250,7 @@ User visible objects are backed by following datastructures:
 - iommufd_hwpt_paging for IOMMUFD_OBJ_HWPT_PAGING.
 - iommufd_hwpt_nested for IOMMUFD_OBJ_HWPT_NESTED.
 - iommufd_viommu for IOMMUFD_OBJ_VIOMMU.
+- iommufd_vdevice for IOMMUFD_OBJ_VDEVICE.
 
 Several terminologies when looking at these datastructures:
 
-- 
2.43.0


