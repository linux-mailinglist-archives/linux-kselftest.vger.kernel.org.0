Return-Path: <linux-kselftest+bounces-25150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A90A1BFCE
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 01:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5DE189018F
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 00:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B510146A6F;
	Sat, 25 Jan 2025 00:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lmvkuoJU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF77132117;
	Sat, 25 Jan 2025 00:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765089; cv=fail; b=j8+bQbKdauVGDv1b+CBn7HOPG/qlkN2LU86CfvoDn8xy8Kb/pJLuEgrtx68WfrIfu052bQMqTL/6iO1QVrfgdxRjNBtuC1G7qcTIR21jQIvJDrQP45cz6+KCJHsLqqbjNSlLnpaSm73/2+PZ3aO0HEeeJ1BSmR5eYg473hzkwJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765089; c=relaxed/simple;
	bh=zdZfB4JkDqYNnMQC/zjzbI/tPsSB88DFJhPUrZIpJck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fHZznM7YG9lkutCMgNjEEXpWWNQQ2A0nEcA5v+kZBSdlFdnOMWmHmaYQ82yEkN3La9BeVlk1CpMj+elmLGrpg4rAseyO3LXyksjkpmYkZh6yXbCRoq8k/Gzw0y5kJpJSEsKvu5JvKwWUQHt3Z557RnQOTlu0OvVy8F8QjVdV6hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lmvkuoJU; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/uwCoOrXM6mAATvwcXLNjRb1IIjEQDp3rhvpF91EWAm/hdyaM1rm62uDAII9MEpf7f/4ytp0mc0ODCSYM9bY4DPTVC0dg/i04dZX8boLNpdspCwFEgQQBvy5caR7qeMdCHnKpJf509lfnjgMS1ux9cnDbJo8f+OT6MY/X1xmy5MqcNIkeUiIizGjpzOzwwcRuuW+C+ga+BgI+wPtWS1kFLxyfTAqQRoxoTuXtviD9aC7SvK/zz4C1S4vU4xpBBjY4pjpb6repg1zg+jiWJ3uujPxqSFVRbQuRMMhUqzplNnIRY76118vr9JgI85I7L3CvrQt/VDYR3U4DkjvsNVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMfNg1hPh2mOg0OlvPZ9wMRhkAHnTAAVx+IL0zUPw5Q=;
 b=eXBkMFIl3PuF3jzV7WSyyYLj4l6gVfM1gaujSBr0nRTwnw6JVB/2+1tjf6CG2cOi+z8vOtHEFGZSSn0/FuZre+rXCsWsMTt/14HwkfYlKfjSL8VkxrM6wFb1sB3LH2qjgDN3mfh4QCVNWbVKumsuZIxsMaANI6A7oxMfUr18RsVEqAhtKcK4DC6YXtPez3/Km4pHFcR77qpPQtzkpu5Oqhz4ujXR3Q1optQQeZzEj2wQzHTd7cY2+97Ubel786oy2mI+8nD+dyhW4+1rjizZVXGGikN/tblOlYh4lTuvh0NjGKXNVnP3B3SOvIRJbhZ9OjSxdieQdT1ohrwuMjKeCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMfNg1hPh2mOg0OlvPZ9wMRhkAHnTAAVx+IL0zUPw5Q=;
 b=lmvkuoJU5YRzLISbqrp0EiALsAXE23DaOHYxJRbCJ0iJdOzgsgBi86smFEbeZ1zCl2MtfXhL6kY7rXUS8FrNsgTOWn2MNcmvylSwZzZM5hcNPwNHtCTgv/LQqc2MQVnb1Eous5YdqsTk8OJBDhuSTwL/WrHs9+Huvp59tB0dZ427zDuKZPNfwb/T8zig6+Zu5+O6ny9cqxMLJBJjo6Ab+71pXWROZKibtRUKrjuGFC+4J7x+A3VupDTZYjCRSi2D+AlAMAlG4obmbCpsqIVH2pNfX1iX1+bT41n9DTus0YfiUy+YVI/RK0vHiFlHmCy3zNJGmCFulGCZK5wbzyynnQ==
Received: from BLAPR03CA0146.namprd03.prod.outlook.com (2603:10b6:208:32e::31)
 by PH8PR12MB8429.namprd12.prod.outlook.com (2603:10b6:510:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Sat, 25 Jan
 2025 00:31:20 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:32e:cafe::41) by BLAPR03CA0146.outlook.office365.com
 (2603:10b6:208:32e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.20 via Frontend Transport; Sat,
 25 Jan 2025 00:31:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sat, 25 Jan 2025 00:31:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 24 Jan
 2025 16:31:07 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 24 Jan 2025 16:31:07 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 24 Jan 2025 16:31:06 -0800
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
Subject: [PATCH v6 11/14] Documentation: userspace-api: iommufd: Update FAULT and VEVENTQ
Date: Fri, 24 Jan 2025 16:30:40 -0800
Message-ID: <300d03449b9420d756c1589e1c24bb8b4d508293.1737754129.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737754129.git.nicolinc@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|PH8PR12MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0ea4ec-a468-4070-cd44-08dd3cd796cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XPcr5vSbV5LTFzS7K/KrKPRCv6bx/KDLYXFUeNnGpetG1XFuNURNci4ZPnzi?=
 =?us-ascii?Q?WNaH35RYC1QRU02r3tma4+hhRvkxS4ylMptMlsJAdfnhoV56LBhF5PufykOF?=
 =?us-ascii?Q?o523rIy8KYtDwNKC+Jy39N9vgcF//TjnSxIAkfI3IfAbMhx95MCHsUfeYdmR?=
 =?us-ascii?Q?QJkqgcJEVqcWBchJP8Mdmpwy3r5nLrZhdiE28fT8uoEaol3FyYqZGIov6jsC?=
 =?us-ascii?Q?+hcDodxA5GwfTk/KRFa1rT8momFNA0X5gI3tA0x8fIBa1GRuDqat+2Nr8aU2?=
 =?us-ascii?Q?XIX/NSuFF/R3K/KF1w0lvhkP8jWiHulGohi9g8Jv6oenh686YcKtSG4tgzeS?=
 =?us-ascii?Q?hocucirGtnHLzkyUv2MOM5mnURS6PWffl3AnxuvFkxYjbdP7htZ5mXaJdofS?=
 =?us-ascii?Q?s9k+PIHWxC4gxQ/kp3gIG12Fo7uH0nD1aXMLQBRR9XGRPulWhNd7cvjalJor?=
 =?us-ascii?Q?qykdI2BnEA16oTA60d4FTJ2dAAxhT5GZ2obNYrXJIMlGTVxIm+yBnF20Hc88?=
 =?us-ascii?Q?GTavvdVvShpp+AI2fEG2FDf9w4e9F44hikdsHb3FAfEAnSqLJK1VwZL/zE4T?=
 =?us-ascii?Q?jqnl11Rovk/dQLZVTbtiQ4KVqlDWrTMBu/FHev0Ocg3GVK732viH/3T3Ubb3?=
 =?us-ascii?Q?6lPv9XeCJoubbelxsq/nCvAU732QpPmpjNJQM/YZfQ8Y2fFWaoekQEM5VUje?=
 =?us-ascii?Q?4xLqzwXi2oGXQ7BUubAYdifeHQ0+mEMk2fMfN+DnmlcPUKwk+kz58gCQbxz7?=
 =?us-ascii?Q?I4qcHSQqQ7bj7WTnqpbuuZbSm7uW2FaLz+o0ra8nSJ4QCqzgr8Ruz7u6jD/x?=
 =?us-ascii?Q?sAKhtxuvfwS/JEd0o4Jyc+6fOBC6db1Lad7TGGS7OPKEqEw+qBdTuljPUv9/?=
 =?us-ascii?Q?XZlNFNFtiIHCjLU7YD/M2vTq2AzwgHXWi2/bxzwXcYuhB2PekzzMsfwU/B8w?=
 =?us-ascii?Q?h9Axs7WAg78JCL57tO+ab8EAyKonOuUkxstjT1XnmPNIcn8jZ4NjDiqrmjOX?=
 =?us-ascii?Q?Z27QI368EMqaDMDlsA6zjmIkrDq35LgkFL1akro5SnAwzTj+LXl2un7PKy2o?=
 =?us-ascii?Q?grDWXaxVvcMCaV4atoKh4STDbhEd33HJ9Y6CvUJbcjhHcnI6jhyvQjp2Pb2+?=
 =?us-ascii?Q?AowduQ4OCIBVWBx64ETBEsWWiHJuWBpeCUHYVJtMdRe134J3tp8CRJPM2aFE?=
 =?us-ascii?Q?Ny8AxqNkKIBMFQi3Ixz4j6nZ3EHhJ07UYvT5XiztKOQrQWnOlj7AVf3rFRVt?=
 =?us-ascii?Q?3cTCYocvZw/wh+oqhVIFatLFbZCgbtgLqiL6+TG1YFjco5y6Kk59z3JNr6Ut?=
 =?us-ascii?Q?ZZbth0VyFPMUXmyk3j42QnIGghzD3aC2YiWa8n1JnE8jGSaPNkIG5cPDHUlS?=
 =?us-ascii?Q?O03uBCE7ohDQWB2b4Rtx9bk/Eb1xaMA6+HHwqcc0traHlirhMtRiCOJF8gq7?=
 =?us-ascii?Q?90bGqBgHDN5i7B8NkzdwBehMIg0ntmeXp/DfkobWVu5g61NeGa5QpzQomeSW?=
 =?us-ascii?Q?aMzv9XfOt3mNBlA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 00:31:20.0308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0ea4ec-a468-4070-cd44-08dd3cd796cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8429

With the introduction of the new objects, update the doc to reflect that.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 Documentation/userspace-api/iommufd.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index 70289d6815d2..b0df15865dec 100644
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
@@ -109,6 +116,14 @@ Following IOMMUFD objects are exposed to userspace:
   vIOMMU, which is a separate ioctl call from attaching the same device to an
   HWPT_PAGING that the vIOMMU holds.
 
+- IOMMUFD_OBJ_VEVENTQ, representing a software queue for a vIOMMU to report its
+  events such as translation faults occurred to a nested stage-1 (excluding I/O
+  page faults that should go through IOMMUFD_OBJ_FAULT) and HW-specific events.
+  This queue object provides user space an FD to poll/read the vIOMMU events. A
+  vIOMMU object must be created first to get its viommu_id, which could be then
+  used to allocate a vEVENTQ. Each vIOMMU can support multiple types of vEVENTS,
+  but is confined to one vEVENTQ per vEVENTQ type.
+
 All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
 
 The diagrams below show relationships between user-visible objects and kernel
@@ -251,8 +266,10 @@ User visible objects are backed by following datastructures:
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


