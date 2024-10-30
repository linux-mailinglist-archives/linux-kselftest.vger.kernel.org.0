Return-Path: <linux-kselftest+bounces-21173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8E99B6F4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087DD1F21608
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2559E21893F;
	Wed, 30 Oct 2024 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lvXseqPC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D7D2296F2;
	Wed, 30 Oct 2024 21:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324138; cv=fail; b=Lva3u6Dl4og7nV/6rNkdHYVnwndVwmCtaxvsJ81dy9jiLIG1gci37bCjqbiYkLV1Tst1vvMDKbwh7IZIcJEZl0zbRFq8pMyV6bymt+zUIm3clNrA1mNDM3AjOf88Cq1+WAwxsGATv6G7vVb/5xyukt6mwb3q1E6XSGRIPmHZgUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324138; c=relaxed/simple;
	bh=Bc7irgx/6rjjEyhgYWm5e4HG/xlq3Zz6q1tfakfeWrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfCBRUJwsDmw7oVR6yKJKyhR219UeLpNG6uFh7V6B6E6YMiYreVtJT4Gw2Dn1WXP0c62d26i1X6K++QIsbs/ctlrToQkyBgzh3AEIPepQpRFSEfQa2G39H8KfWXnC09t6ZpNghQAXDTVpv5CoVTaVxMWkn/EekvmLSzsBmE6FAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lvXseqPC; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1jOOYuKpA8kK8c0NaUeIfsL7KSsSU3BPQ9okaatyC+oco/4E6UkPGFU2uOrKOJ6zuM2aKLACRgU9cH1Zp6dIulOqWofdr50Fkj59gLd/rK/lN2LT66gNQE3oWksZB103CRN/tv6NZg5ceiEkpDQPexWbcBD40aTgrsXnEmVKyWxfQRAT1FFCpN6+6xHFoMmnb5lq7sHRbLP052Ik/P6Io5t1czsI8c5aJrPTW0kN5Fgl3VOmL23ukP6Ou84D3XP3KUGJmn3HKMukZtTh+LElmXfbxn9ewX9xQr8AhzIOMxUl4m1FNrqVJXzA2x9vwHBl5fFVG7Ou7MU+EXTvAczsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEMmgACXamRJHRJ8k8PHyMQpZBwcJXQxMazWsnOea9A=;
 b=kS2Y+NJVj029x3bxZXOGu7XYis/Bfg+yx49PR4pn1Fb7hEfdzQgJV0NMVuMLYn9ZKfC5vB1Kkb5wDj8bAdRLATHLf+08gbNJ2MGdzPqUxMgs0tRgPGMZlBFUD942YlHQlIs7BBDFMsUsioNO2gkkwDyGVI2jjDZA2zKXTV/pdKqyDoPN4e6SxGthExHF4aAuVeAV6RYbvsogAMD11avW0m82kZPIAvYDYNj/KkYhTofpRRXEcaethoMOCeXbOTAhGYrylaKkCswMMPNNOVhmxWBLjOe7CDcUTvpfpazRUAHiGus9AesIcCy6+yY+YjMLDcipo5Ls+gl8QkkbSqQ0VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEMmgACXamRJHRJ8k8PHyMQpZBwcJXQxMazWsnOea9A=;
 b=lvXseqPCCRzJQNPQwLe85r9113e/1X+yVTVI1QqI6JS1jvBRLZD8RnmjvgOKCMRc24bwTiwm91k8GFIllMwF4A/OiF3pqxt53C3MOnTYQcV7Knr9NMQvWxYh5GZVohC9dNsE7ejMdT4svJ8shCzWUOTaS1ukf2bzzBweV5mffUnOZdXTgo+TqBVCIOsqfe12/TkCc9ryz4qzkTeVywn5xOtmIgyP74V3l/Sy7Gvhr4CaJ5hDDSJtydt5W4N7CoEMZ260dN0wyT0VVSdg0MtoXZ1ZAzKz68SfhgUXEzOEKbfAjWMbGnqs+pHpdqlsMlr1c1VO9C/Vo7LG2nNWm4kjmQ==
Received: from SA9PR13CA0130.namprd13.prod.outlook.com (2603:10b6:806:27::15)
 by MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 21:35:31 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:27:cafe::8e) by SA9PR13CA0130.outlook.office365.com
 (2603:10b6:806:27::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.11 via Frontend
 Transport; Wed, 30 Oct 2024 21:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:35:31 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:14 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 30 Oct 2024 14:35:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:35:12 -0700
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
Subject: [PATCH v6 13/13] Documentation: userspace-api: iommufd: Update vIOMMU
Date: Wed, 30 Oct 2024 14:34:39 -0700
Message-ID: <621bc7a4f727b5563b01985e86969a7c8131c6b2.1730313237.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730313237.git.nicolinc@nvidia.com>
References: <cover.1730313237.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|MN2PR12MB4344:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d908eaf-d577-429a-4728-08dcf92ac7a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zcQ3ceeC5vcMpgl7z5IQNm0YTu3LB5uPEQ2nmIOdvkFBdIAZPj1YFVwZm21o?=
 =?us-ascii?Q?YXkO/vcuKxVow9aEkkcSNY+rsXGka2mdAgDiFzKwOTVJ1kKLnODkqUZgO7Yk?=
 =?us-ascii?Q?5HHMmFrpyDsN8kaSEgaCCqwglW0bUs1/hbJsBjqTGmszY1wVkChWoPqi58L+?=
 =?us-ascii?Q?rhGX+eD+sF7858asTmphK8EOfbplpj9bwSy64GtHCpa4O3xY8e1f4BPYkWHK?=
 =?us-ascii?Q?HuO8VrG8e/xwQsaJU0HA2q1251tR5rle1dBi8/YsVEYGyPrxCxcfB33GpF1d?=
 =?us-ascii?Q?iliWr25+jHZWQB/AD3lAD0J7aI+b6S72hThKv9VmAYwdc8/KjPx3TmSI3oJp?=
 =?us-ascii?Q?2jse3sEc5jCNVGgusXcVsBCn49v4vBXVYVmh1wStb3rEjRMrJFWNqDPUHhJF?=
 =?us-ascii?Q?3oY+mkM0PW/vErDZ/YAYHiTpMnj4A1Kk0BoFldyV4S6dmtVzITonG0hOoqp2?=
 =?us-ascii?Q?ub4BsAWDG9PnSpgEoR6sh+/d16IqRGWd6J3co6su2y8R1Ldr7IoO5dFBbfam?=
 =?us-ascii?Q?uJVhY779Ptd78ItFVq8bK4frdxvFjIwDbKje8yjAeAYQWQn8dP7YIB93hiwc?=
 =?us-ascii?Q?7JLGp470Gdb5gJGmbrU/NLDV4pSaUI2hWqiiuK7VEz4EBxT78SGkjLEvcj2z?=
 =?us-ascii?Q?EYs8mh63dZpannt5wtv2Bqs48pVNeYAs6lhgLLJeUfAImM+DZm/PMjYIUNZg?=
 =?us-ascii?Q?G7WLvjKunpMfnxnjrohoLGrtli+CsfPhDHnKbb6yHS4myUePf1ShblKVF0LR?=
 =?us-ascii?Q?UZ1dylQtYuY3BAvIV5fw5QDtMERoAYaoMguD7WwjuN/dUXnQyPVKlSWYN/VZ?=
 =?us-ascii?Q?vFi16ExJcCjjvWGW37LfcEki3G295aqhLlbTnr6NRpXNjjVwU0HxcwEQjB5x?=
 =?us-ascii?Q?ZEqs+2nJc+M57E79OgpT6kOTdLCwM0ggxZuWWYT01wnXqlpzovxoh58+5Spq?=
 =?us-ascii?Q?CM6/C0Abgb1STDKTK+qasZqB7pEk42WAjN58GJ4zAWhx68VD7kiteGenX3AH?=
 =?us-ascii?Q?otZ06UhzqQvWuRsmOIWWCBnDukNLvrCWd2FJzZZm1TtvgjkdjGp6VsSdPmJ5?=
 =?us-ascii?Q?8oC2TDbTpGku31qbEuirl/sGy1EtEhcDteuzcVI4UCj4CBRMrhkyrKehJEbB?=
 =?us-ascii?Q?qWBom0pnIPAQ+POPKXcCDAhJN2qd07IuF1cx+HXENutaOsIv/L9t4VqaVY5b?=
 =?us-ascii?Q?kZA2D//Av7f7m/yC4aGrZVrGF9ix2drPvHJGzIVsZLc/8S0FmZVS0Ysnqz2R?=
 =?us-ascii?Q?5UaDIzvKKGJu7GLYIGFzSqIGw4KloMe/Lv4Ac3G9JBEqd70PsxHM7atHIPDN?=
 =?us-ascii?Q?roe/oUZ6vfUIN5JesaMEyHFbaoVST/GLmWclvHTmr7jtQM3lOD+pL26kOC8s?=
 =?us-ascii?Q?/cQ0Bj8Ldf0Pjrwxfq1rB2ZpF2SfjF8JxTcQaxA+bpjaDxq8mQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:35:31.1892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d908eaf-d577-429a-4728-08dcf92ac7a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344

With the introduction of the new object and its infrastructure, update the
doc to reflect that and add a new graph.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 Documentation/userspace-api/iommufd.rst | 69 ++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index 2deba93bf159..a8b7766c2849 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -63,6 +63,37 @@ Following IOMMUFD objects are exposed to userspace:
   space usually has mappings from guest-level I/O virtual addresses to guest-
   level physical addresses.
 
+- IOMMUFD_OBJ_VIOMMU, representing a slice of the physical IOMMU instance,
+  passed to or shared with a VM. It may be some HW-accelerated virtualization
+  features and some SW resources used by the VM. For examples:
+  * Security namespace for guest owned ID, e.g. guest-controlled cache tags
+  * Non-device-affiliated event reporting, e.g. invalidation queue errors
+  * Access to a sharable nesting parent pagetable across physical IOMMUs
+  * Virtualization of various platforms IDs, e.g. RIDs and others
+  * Delivery of paravirtualized invalidation
+  * Direct assigned invalidation queues
+  * Direct assigned interrupts
+  Such a vIOMMU object generally has the access to a nesting parent pagetable
+  to support some HW-accelerated virtualization features. So, a vIOMMU object
+  must be created given a nesting parent HWPT_PAGING object, and then it would
+  encapsulate that HWPT_PAGING object. Therefore, a vIOMMU object can be used
+  to allocate an HWPT_NESTED object in place of the encapsulated HWPT_PAGING.
+
+  .. note::
+
+     The name "vIOMMU" isn't necessarily identical to a virtualized IOMMU in a
+     VM. A VM can have one giant virtualized IOMMU running on a machine having
+     multiple physical IOMMUs, in which case the VMM will dispatch the requests
+     or configurations from this single virtualized IOMMU instance to multiple
+     vIOMMU objects created for individual slices of different physical IOMMUs.
+     In other words, a vIOMMU object is always a representation of one physical
+     IOMMU, not necessarily of a virtualized IOMMU. For VMMs that want the full
+     virtualization features from physical IOMMUs, it is suggested to build the
+     same number of virtualized IOMMUs as the number of physical IOMMUs, so the
+     passed-through devices would be connected to their own virtualized IOMMUs
+     backed by corresponding vIOMMU objects, in which case a guest OS would do
+     the "dispatch" naturally instead of VMM trappings.
+
 All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
 
 The diagrams below show relationships between user-visible objects and kernel
@@ -101,6 +132,28 @@ creating the objects and links::
            |------------>|iommu_domain|<----|iommu_domain|<----|device|
                          |____________|     |____________|     |______|
 
+  _______________________________________________________________________
+ |                      iommufd (with vIOMMU)                            |
+ |                                                                       |
+ |                             [5]                                       |
+ |                        _____________                                  |
+ |                       |             |                                 |
+ |      |----------------|    vIOMMU   |                                 |
+ |      |                |             |                                 |
+ |      |                |             |                                 |
+ |      |      [1]       |             |          [4]             [2]    |
+ |      |     ______     |             |     _____________     ________  |
+ |      |    |      |    |     [3]     |    |             |   |        | |
+ |      |    | IOAS |<---|(HWPT_PAGING)|<---| HWPT_NESTED |<--| DEVICE | |
+ |      |    |______|    |_____________|    |_____________|   |________| |
+ |      |        |              |                  |               |     |
+ |______|________|______________|__________________|_______________|_____|
+        |        |              |                  |               |
+  ______v_____   |        ______v_____       ______v_____       ___v__
+ |   struct   |  |  PFN  |  (paging)  |     |  (nested)  |     |struct|
+ |iommu_device|  |------>|iommu_domain|<----|iommu_domain|<----|device|
+ |____________|   storage|____________|     |____________|     |______|
+
 1. IOMMUFD_OBJ_IOAS is created via the IOMMU_IOAS_ALLOC uAPI. An iommufd can
    hold multiple IOAS objects. IOAS is the most generic object and does not
    expose interfaces that are specific to single IOMMU drivers. All operations
@@ -132,7 +185,8 @@ creating the objects and links::
      flag is set.
 
 4. IOMMUFD_OBJ_HWPT_NESTED can be only manually created via the IOMMU_HWPT_ALLOC
-   uAPI, provided an hwpt_id via @pt_id to associate the new HWPT_NESTED object
+   uAPI, provided an hwpt_id or a viommu_id of a vIOMMU object encapsulating a
+   nesting parent HWPT_PAGING via @pt_id to associate the new HWPT_NESTED object
    to the corresponding HWPT_PAGING object. The associating HWPT_PAGING object
    must be a nesting parent manually allocated via the same uAPI previously with
    an IOMMU_HWPT_ALLOC_NEST_PARENT flag, otherwise the allocation will fail. The
@@ -149,6 +203,18 @@ creating the objects and links::
       created via the same IOMMU_HWPT_ALLOC uAPI. The difference is at the type
       of the object passed in via the @pt_id field of struct iommufd_hwpt_alloc.
 
+5. IOMMUFD_OBJ_VIOMMU can be only manually created via the IOMMU_VIOMMU_ALLOC
+   uAPI, provided a dev_id (for the device's physical IOMMU to back the vIOMMU)
+   and an hwpt_id (to associate the vIOMMU to a nesting parent HWPT_PAGING). The
+   iommufd core will link the vIOMMU object to the struct iommu_device that the
+   struct device is behind. And an IOMMU driver can implement a viommu_alloc op
+   to allocate its own vIOMMU data structure embedding the core-level structure
+   iommufd_viommu and some driver-specific data. If necessary, the driver can
+   also configure its HW virtualization feature for that vIOMMU (and thus for
+   the VM). Successful completion of this operation sets up the linkages between
+   the vIOMMU object and the HWPT_PAGING, then this vIOMMU object can be used
+   as a nesting parent object to allocate an HWPT_NESTED object described above.
+
 A device can only bind to an iommufd due to DMA ownership claim and attach to at
 most one IOAS object (no support of PASID yet).
 
@@ -161,6 +227,7 @@ User visible objects are backed by following datastructures:
 - iommufd_device for IOMMUFD_OBJ_DEVICE.
 - iommufd_hwpt_paging for IOMMUFD_OBJ_HWPT_PAGING.
 - iommufd_hwpt_nested for IOMMUFD_OBJ_HWPT_NESTED.
+- iommufd_viommu for IOMMUFD_OBJ_VIOMMU.
 
 Several terminologies when looking at these datastructures:
 
-- 
2.43.0


