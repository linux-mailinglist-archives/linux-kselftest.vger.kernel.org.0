Return-Path: <linux-kselftest+bounces-21186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548379B6F77
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E611C22814
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3232B2308B0;
	Wed, 30 Oct 2024 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o+X3eBaE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC35E22EF0F;
	Wed, 30 Oct 2024 21:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324187; cv=fail; b=rSWXgCfuNKjJniDC/J2nnMTn5pdyX5W2UkPVPW/GX8pbYtjBK0vh21fQHRdV88ShltVs0TwW9UajJaF8vYA3UDmxdNnUKiDY8W0HT4428zpk2l2ADLYzdrQ8wM//Goo3kDXRF2KmcJexUYqTBjayZfrFnn3/Uq1kiTOiAXPeIgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324187; c=relaxed/simple;
	bh=gqAmTtjGNe//h7WyfJWTfYQcfzTYpZbrdNYuBztEhfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oChVuU+xbzr6wXjKmkD6yQtsaQciU8PiUgz9vHlpp/QCwZJpKCrHrOufh6D4VrRv1/rdrAOvCsT4Bi50OJGVhzNhZqewl4x9X0l8yxSm6lrmsxCQD1kZLKo2lBGeD5C1ksWL798py4a6KvGSIjekTJcWlwXxGDrntDwVp3avebY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o+X3eBaE; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThGEW2gxE+RmVwdL95It0okmGYKEp1JKO6QWTi68QLBSquLi0yOdxWsUOL/+lhdMiBwQGKzILJuLyhevm4j1P8c7ZiLv/YnBjyKpMVt5/+ypqlhCAVm1O/Vd0Yt9FomnI6H4yHxaf8HLrenqdLagzrbj3HduhRBWVfNsuTYg1wzdq4HuKc8W8lkMNvS8uKs99RY0Jqut6dkDiNAlEf8Wcf466MSuKDmq9K0YYjCp/lwFy+kRM4mjgHGOu1HAGHOuOH4CAdJt4zMdYMpHB+DmpIcDSAKZAL35SCfgp8ilgt7tcADctmo5ZfYNDP+jc66KuNFGksztEs3yK/yHQWz+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vry/3B2n3DbjWYyPpSM9wzN3eWtoc60oWW2YJWfIQVQ=;
 b=HOysrR26DRWkFW1VYLS2kevPcAtCO8uOOMBdlCb6VPYx1T8/OxaR0AnTABvAgMoVGHNWg2duUTYA62uZSVX+SvzbXGxX129q4aCPyyPdksMcPE3Lc/C+f8cox2isAYXnBP2bdhs3Lbi4miAtSn0ir7tbKlexXWClPD0vCzi3AJ0Ba4t08eZuzIi0Yt5Xcyi2FA8vCD6zC/4PDYysFs8eicp/CY6RZuAYLyUgCOfyWPscEd+IMvZRAYk/R2xhxYxps/cGX2ffcvi0ya0C1TU02hGuhlXzsdHN5fdliwd5PNVQB4ZFmJpyciufzru48yDnHhMDyvk1zQdZTZ1HAgDCPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vry/3B2n3DbjWYyPpSM9wzN3eWtoc60oWW2YJWfIQVQ=;
 b=o+X3eBaETMv6lnhA+7IoYv8MkKmJFDlqvxPX8jOxg2XrN+s4EvLdeZSqZoT+uQF9fwwqFFuCCxc+mdc/eqmqOCNYKO+vwRdGNkP5kkwXqMkeuHDiyhSiWmtGzUsfDO7Q0v6crm0ipCCUz9/306tkA2zcTqXIS674PZU6Bcqy8xtNA2mkM1FGA+yHKQQiLQsg2UPKJ0EekPP1ATWeT0OaOZe8lICclRaKkHHqJcXzWUrswqzuNUvvN2dpFjz8iMeh5+rcWETLzNFhw9+jYBVYJHvi03VPJL8jvGsUqpzKcSFukqlkAC3/6gIKpAaLDz4U+X/4W1ZxKaFQtiUKxDxlMA==
Received: from MW4PR04CA0195.namprd04.prod.outlook.com (2603:10b6:303:86::20)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 21:36:18 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::ce) by MW4PR04CA0195.outlook.office365.com
 (2603:10b6:303:86::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Wed, 30 Oct 2024 21:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:36:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:55 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:55 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:35:54 -0700
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
Subject: [PATCH v6 10/10] Documentation: userspace-api: iommufd: Update vDEVICE
Date: Wed, 30 Oct 2024 14:35:36 -0700
Message-ID: <637d97557328ee158ac2cc9039bde9bd114629bf.1730313494.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730313494.git.nicolinc@nvidia.com>
References: <cover.1730313494.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0e8c53-8138-42e2-7bdc-08dcf92ae375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?03v7LP/56+g95H//dcCIBL5H1NAcJRLmZN04rGbbgj6xyPqvMZlBnMVL9a1d?=
 =?us-ascii?Q?MohmZYFoFdb1/p+N0eG+DF+RbMVGwId0Oa1pfd9z+STqUR3QKyzxE2euW8PZ?=
 =?us-ascii?Q?1mtB2WaRX2CH/rvrBzAH1DUykoIY8pSuZf45/mki/6snhME2Uw9rlRQ0J+ck?=
 =?us-ascii?Q?5+r+gwardvQPXUS4uw0s8JFpOkIbZnbDiAU+sHt7U8CRYD9r2Y7xz16ZMczI?=
 =?us-ascii?Q?Lhtyz1zcuoUh/QRJV5mm5wVWkEXhK5SmiUHVL/OZ55qDwB8WT8wzo0AjyG3K?=
 =?us-ascii?Q?Tmy8IR69pfBRGXD2FBMKolRJMjqzgwXfRkomVrRoAr3DspT/sZFEiKrkraS6?=
 =?us-ascii?Q?EJo3oxSz1kW15LB9i5vZiXiNUY6qeXbJiHRcZB9EIQQktXlCmvAzvcLOveJS?=
 =?us-ascii?Q?5hah6yOaqYoUiL2UBTiRUYA6+bUhZfKsWK+gS5flHa+Y5uHCu4wKaMlmcXGR?=
 =?us-ascii?Q?mgBAjSllYjFBbWGvulpr6Sy9ssZp58uurjXU1/JDXGb6Zm3L0rfjVMsTxq54?=
 =?us-ascii?Q?Ru5MXKjBUVUzDVbs2EZy81Ab4ESf/ufvgAc6OZh2suamm5Y3jE216lp2zlc9?=
 =?us-ascii?Q?mgIDAHdXAJU9Thi8sERMBbUYN1c7Z0kZSzOwLbGD1yXYXLKGksoi+gecUDAl?=
 =?us-ascii?Q?ipr27Jk9b0z9qyEY/yPxEHwkRgZswFbKoDOqz2W6QwkKaMH+iB++CZ1NpQ3T?=
 =?us-ascii?Q?gVAtGrYadpZICyPZ2FZQMWTxTqojwGN2xxVRYXt1FSTF6UJbsnlkzvq+MWn0?=
 =?us-ascii?Q?BuAX/2IJJ91tk6PY2D2LYTrymfK14d/QVwfjwGKbgV1AOywMZ+sYIMy6MfIu?=
 =?us-ascii?Q?STr6izJqEqMCmjPAffX7sS98JLMySwXkdWH/K6s/b8BFJUxxn37CokQlWsrS?=
 =?us-ascii?Q?EU4gR4gqs1XdgD+b/zHzRlfIN61mbWZvhXuworavjd/IkQNAayWEnCaUiizy?=
 =?us-ascii?Q?JpdsqN/5zwc/p3qYBqEa7DLNYFTqyzgFyadYqzWQpXCz3ehblUG+nSP9qXOZ?=
 =?us-ascii?Q?cgyY9eWq5xCj54qYtILujQ1aPTk18+tHwgM/+030c1fZu4abP9xcIy7upokB?=
 =?us-ascii?Q?sFCYzh+Dfl0Ouew+d4IxhYrs2C2BtPeEs3impyTyL2k/dMpPAce5XYrbYiJo?=
 =?us-ascii?Q?85uOYCnwcaHXkc07TkihujrVwnCOnwOcsPUxLdRFdbu7RYvZ6dexU2t/95BL?=
 =?us-ascii?Q?4Cv8m4RNetWAllQVI5OzReKAWYxAa+T9tDZ2xFOSy+Wa3fXVP1MOzC37O1Ow?=
 =?us-ascii?Q?lcstWn+QqQgP5rBLHhsg+tLECpwi+G96U6GJePk3o8dyj8hH+8SPJZqy6428?=
 =?us-ascii?Q?UmIlWq1XZq9Cu03kKb1LU28L0UEpyadXHR3kuClOJDv5iKPL7OXO4Sh7Z+I4?=
 =?us-ascii?Q?SIUtTgHDKRjWHpULCKWIajT2MX3+diyhfjhY/P+V9l4k7/nEFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:36:17.8900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0e8c53-8138-42e2-7bdc-08dcf92ae375
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020

With the introduction of the new object and its infrastructure, update the
doc and the vIOMMU graph to reflect that.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 Documentation/userspace-api/iommufd.rst | 41 +++++++++++++++++++------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index a8b7766c2849..0ef22b3ca30b 100644
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
+- iommufd_vdevice for IOMMUFD_OBJ_VDEVICE
 
 Several terminologies when looking at these datastructures:
 
-- 
2.43.0


