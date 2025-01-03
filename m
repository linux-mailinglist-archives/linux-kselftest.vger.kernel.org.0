Return-Path: <linux-kselftest+bounces-23896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D8BA00E97
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 20:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A68D162ADB
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 19:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE611C4609;
	Fri,  3 Jan 2025 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U0lcETyq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610A91C3F1B;
	Fri,  3 Jan 2025 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735933500; cv=fail; b=GFMbUY/4wnnGVXwoyORxsW/mhZmXzfbYV1MvZJPDKDihD/XX5mfMFMmcdJ0XkbCrVThlU+1luOS3HQ8B+HRbFv520UukplTqwN6HxxcogyqB6I8Pto++T8tIP0tRWZ8UbyepanTIndc77e0cL7hXq9a2HJhV/r/ei45E65vVNHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735933500; c=relaxed/simple;
	bh=GHOsZ64gtDUHN/NVjp4XsPohG1CnHhafL5kbaecUNNY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPMuGSzkceXYeaWz7ko6rx6xbmhTQ3z0JprODu6o6cAj+CbQeIXKZdZDkXtC7hBqEjx8BsYe685xUB7zcGHrGi8ya9Kv9F9SlMcCOS6Nb6FzsyWb82yIR2UCLIg7EO6JohDM+0LSQ6PbnnvmhlHQmFvLt74bXKVq8tLCGBw5aM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U0lcETyq; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsCuU4xPddAMU1XAtsvn6qcCdFL7/CT7fl0LTJVt3gfVsUW3ToisKZiMeBm3Bcl0dGED5uqV3tF+LVUrqTe12nvKp7jljfKqx2+LSfiO3PZWyPN3EnfirKLQECIZwrFMexJ//5totK396AqIBnKkeLy/X3n4w13i4YPdIfG11OY3XShSv8y3hlDN5X8Kl2SlPlZqmnsd+DSh0KnhnTM0Mb+1Ny1GAdBW3E7c/fZ4YPJ/TJ2rWp1/6FbaOyK6QXrlEv7RcrJ2/IET0MGIZc1HNzw4JVs5ZyTTCseadC/NkLLrme1lNr397wRg3yuL8hJ6NHea7QKDmjdoWosxgKKmTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13eNH/j23XIsjdSroVruvt51chchriTKTYTuwZ1uLbI=;
 b=uMHiosBKzJ8vH2Yfgj+OkzWNBd5SL1GLktSHXmarr3VpGoyUFTQPPWAav6QiZR9dekqYV5OWUIpEfehhGdXjPnZAFDa0o57wp7JU4EQWWE0hVebeleHeeo8cLeS3Uu9i8AQSLzJXvSt6T02JBe4oT0MgWOpzZfXXnyxhhjmbPoLEhNF0RlZgN9UrPeIbXSeQStw2hpFnmsXCyDvIRcu++vAY0N+XcGM7B4TTbzEUgKqHKMWABP/0529qWIy7wrlKIWpRuVu5FYmDgWclkWLebHYKxwaet7JE/SXPgqlP2xC7lpVlLGEf2+fN2N11+zjghUG1qKc5zXPNTfWC6x3arQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13eNH/j23XIsjdSroVruvt51chchriTKTYTuwZ1uLbI=;
 b=U0lcETyq54zKq1oSJtBepg3rZ9NGJn55lLO2lk0j4RdOsRUcajNo/5uRGespeFn7FwPKJio0H92Gkw0JZpM+YS7o9sK6kfpCWucuT33PQwMezuMEVG1Go8xFxszrbuFhqdvCb1S2/TNJ9gMx9YUSGpG3/qQGIW90beD46kLk4++d5gYG+iMcg0oAqyFJNbZ3vUH+X/QVpBrvYCFE2yPC9mtxddCmndXzZncl/S8gRZcGofTAgZ9HfWEAW9yHW7pWwmMnZvsBDgNg0xX+FP+ep7lQKDhymmUEBIo6wzTLTikmZSQmNyXDoxLUFAKcHoVJujdkd27lEDbDEuYc8JklNA==
Received: from BN0PR10CA0004.namprd10.prod.outlook.com (2603:10b6:408:143::18)
 by MW6PR12MB7085.namprd12.prod.outlook.com (2603:10b6:303:238::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 19:44:48 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:143:cafe::23) by BN0PR10CA0004.outlook.office365.com
 (2603:10b6:408:143::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Fri,
 3 Jan 2025 19:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.0 via Frontend Transport; Fri, 3 Jan 2025 19:44:47 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:30 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:30 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 Jan 2025 11:44:27 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v4 12/14] Documentation: userspace-api: iommufd: Update FAULT and VEVENTQ
Date: Fri, 3 Jan 2025 11:43:35 -0800
Message-ID: <14ee2076bfd7df1d2f7a3322d7f24a71b7417867.1735933254.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1735933254.git.nicolinc@nvidia.com>
References: <cover.1735933254.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|MW6PR12MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f2d92f-8661-441f-177e-08dd2c2f14dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NZyJxisMtFFNe7stZCCuvJEMP5PD3l+LJ0PxUpyzd63BvNK1u+nG4tuksCqP?=
 =?us-ascii?Q?AjjyeFdm9lDEDGdrFpyxkubY7l52G32FRSWyM5LDW1CzNwY7FrOdKV0BYy61?=
 =?us-ascii?Q?5JExooyWASLSAdYhgddaChXlPUAkumglkcRNOXza8yDw4mhu8WQBYGZAr4Xm?=
 =?us-ascii?Q?uORHiEGt7P6tfPN9lacNpfqnmTQiDBpUyFnaO3lqX244hw2GfTq40th67eLj?=
 =?us-ascii?Q?tEPTSIK/xUSjOKtctKdzTQiO8A2PWZH+zwxwIrQANPeCuBjpqckME6RwVUk4?=
 =?us-ascii?Q?KNBrrotWVV2yrSPvXi2MOlz+niT2U3JmKLaUeB5degQXImCUNF9QP+I72c5C?=
 =?us-ascii?Q?RKpcCrXhD146kYpHtDGV3OLgmjgAyEKV31Cqk6tv3ju8xioRkF4dcZCVkDg9?=
 =?us-ascii?Q?RnwASJuKnfU0zTpizM9Lvdl8U+8/AV2F+YP1j21gDOv13+hByRm/7alMZmSQ?=
 =?us-ascii?Q?PNYiy06S/6xbU+oqHedGEKRMVFMd6jcKaX3QE1/QT5goi7uJGtKaYbB8vVOo?=
 =?us-ascii?Q?Sucw1m7iwVqFdgnclq2iZ5mkm5llhtGpvmr3jCaGvmrs4NUXOhzpATmCIMcT?=
 =?us-ascii?Q?jh0jiG5q+IUsa2lXiaoLIfHVrdi6o1aNteUbZ/VmoSGRifvku1UUTrp7YyRS?=
 =?us-ascii?Q?ZmH+0cv1mgWdehAAifNBUQeOFUWj0NIjxH40N99nZTyNpzMv56O4kcQmHvqw?=
 =?us-ascii?Q?oHLmlgqyOoySq9ZcFIUhZW3I8Bx8lu4+EOEjE5uS3My+X1JHnkShbSBgE6mB?=
 =?us-ascii?Q?eeoqMP/ioaO5Yle+pTYB1KyX2LlzKT4nC7mbd40oGpijx7+LTCmgvXhQcUm6?=
 =?us-ascii?Q?rAl7PUw1stK/BZQsBlvKnqlxxLN1uhqeGPV2pRk1B1sDnFoh1aXs/dLgl8y/?=
 =?us-ascii?Q?KnYeeeCqTGMsvso0Q62bG+/GzIVWSWoQT4ZwGLdmriuAO04cDCMeeEecREPL?=
 =?us-ascii?Q?GT/7Vzqc0rMZ4g/lv/+1KKBfOFGxzqswPZG9JAMjeyjM9jC0VH3UmgXn6JO/?=
 =?us-ascii?Q?h4u7ErTwgtbrB1CnIB36YR61f6rt+oDO8Z6aPVbZtAaXCpZsAlOWlBMfSWaj?=
 =?us-ascii?Q?8vvunZTgFUs9nzS9r+P6oEfazLTxdF+wXmprgNgRQTkZrygNg4jUZLJloUSq?=
 =?us-ascii?Q?vSqqCIWe3Rg0BNx4O8Gr6BjLCzS5cjVpdxcF3V4QUoT+vXiVH3qj1AOPqPgl?=
 =?us-ascii?Q?4b6nMvsJES5SMgedpqOuVw4j4G8sj/32Kdy/yWwEWBIDMPkmAaI5/NMiZatX?=
 =?us-ascii?Q?TsnNFH74CoxGZN66UbxOYJdX2+kvMwoGOVZxoyf6XSjHI6BAo6cISC8decmq?=
 =?us-ascii?Q?Ec5ZwkBf8vtk79V3V+KT6LTLEDmFgRnr6fPq8HbbhrLVX452BXN9umlfwCK3?=
 =?us-ascii?Q?IXuVJtFPrlN2VXApIw84vVapujp79pPg6zb4ZZVuH85oApYCZUp0BnYImWaS?=
 =?us-ascii?Q?pi0XhrBPHoli3erUY2Bpv8aktc3NMao4Nk/Mdbk2l5MsnnDN3rIvkVHgT91/?=
 =?us-ascii?Q?/p1OPDSQsUgDlOM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 19:44:47.9656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f2d92f-8661-441f-177e-08dd2c2f14dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7085

With the introduction of the new objects, update the doc to reflect that.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 Documentation/userspace-api/iommufd.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index 70289d6815d2..cb2edce6f87d 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -63,6 +63,13 @@ Following IOMMUFD objects are exposed to userspace:
   space usually has mappings from guest-level I/O virtual addresses to guest-
   level physical addresses.
 
+- IOMMUFD_FAULT, representing a software queue for an HWPT reporting IO page
+  faults using the IOMMU HW's PRI (Page Request Interface). This queue object
+  provides user space an FD to poll the page fault events and also to respond
+  to those events. A FAULT object must be created first to get a fault_id that
+  could be then used to allocate a fault-enabled HWPT via the IOMMU_HWPT_ALLOC
+  command by setting the IOMMU_HWPT_FAULT_ID_VALID bit in its flags field.
+
 - IOMMUFD_OBJ_VIOMMU, representing a slice of the physical IOMMU instance,
   passed to or shared with a VM. It may be some HW-accelerated virtualization
   features and some SW resources used by the VM. For examples:
@@ -109,6 +116,13 @@ Following IOMMUFD objects are exposed to userspace:
   vIOMMU, which is a separate ioctl call from attaching the same device to an
   HWPT_PAGING that the vIOMMU holds.
 
+- IOMMUFD_OBJ_VEVENTQ, representing a software queue for a vIOMMU to report its
+  events such as translation faults occurred to a nested stage-1 and HW-specific
+  events. This queue object provides user space an FD to poll the vIOMMU events.
+  A vIOMMU object must be created first to get its viommu_id that could be then
+  used to allocate a vEVENTQ. Each vIOMMU can support multiple types of vEVENTS,
+  but is confined to one vEVENTQ per vEVENTQ type.
+
 All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
 
 The diagrams below show relationships between user-visible objects and kernel
@@ -251,8 +265,10 @@ User visible objects are backed by following datastructures:
 - iommufd_device for IOMMUFD_OBJ_DEVICE.
 - iommufd_hwpt_paging for IOMMUFD_OBJ_HWPT_PAGING.
 - iommufd_hwpt_nested for IOMMUFD_OBJ_HWPT_NESTED.
+- iommufd_fault for IOMMUFD_OBJ_FAULT.
 - iommufd_viommu for IOMMUFD_OBJ_VIOMMU.
 - iommufd_vdevice for IOMMUFD_OBJ_VDEVICE.
+- iommufd_veventq for IOMMUFD_OBJ_VEVENTQ.
 
 Several terminologies when looking at these datastructures:
 
-- 
2.43.0


