Return-Path: <linux-kselftest+bounces-23489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9305A9F5E20
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 06:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CFBE7A3723
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 05:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48537189BBF;
	Wed, 18 Dec 2024 05:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uEz6Fp3C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674C5184542;
	Wed, 18 Dec 2024 05:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734498120; cv=fail; b=IasRF6Smrb89g5VJo005nLpR0WLFCQbP/gMgQdtNG380I0Tl8BdSiJOVJDEU+vaE/ennL+CODZjklY8WKJkomFfDVV8GJbiPIeDXJG0scgn1iWM0cl0W5Mjh9PpJcw2mBNLezs/rh8mpcURoGJ9brXTjVMr2dj7dR1Nz94PeWTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734498120; c=relaxed/simple;
	bh=Oy/qRhx3BdqdpeF4HQYdYw48RZ7w3addYcMB/HGgcws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDQ3m5WECXtxhwMN8+UBU4I2yowAIrLkEFBJsXwLmxqIuQmqs5th6iVrVF9+XUVSodE21xNFgltogmW1cFkKiwefjfNXlhyMrpsOBMBv35Y+db8n2SMVkeqBcPF9ft4WY1GZi2L0N3O9ag0kwjf3MG0RRCvPXVFJ6RZ8d3p8q0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uEz6Fp3C; arc=fail smtp.client-ip=40.107.100.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/hlDp0fTgmH6OlP+oreWo0FwrMesRuxXR8R/xUTjF1FmM/XFODtJtQQrwgeRUU3SMMbZMzRclUSGOmPmtnJ7mTFwZ2eEgrr34yi/7aTLuARh0ckm+zflZZNTHbmlx96JxqWfcC3zIrbQUTouL6daNxSzfpHHeGImKO5Z0jNjRndypiAUnb/ljh/HrulpPqk+4WJ9EIRA/dftzGw0+7U2d2+cuxd94qowIxdsCIgCDRODZ1AELMHgQLEOHOPcaeVJ+k5XJD33hljmvP98HQ2eSifdJOvvMU9UxcsIsUl59/mQ6gCB5HFsd6Qn/22p3zr+HkLYngp14UZ7WyeUEyA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QrpHObP2qPjzpkg1inITv0VQOzmJZdgd6cWO/WaDtU=;
 b=vSSH1pvKXhHkmhx7nxhkyOGh9supSgrIn6vdf5uM/F/4bUp0L9ie3Q/m18/iTJUKJ9tayGYS6UZlv4M4STZQRTGgjh1m658GPzOOKbsdykkDstHIPbsa2ncok3sCNxgcSVOIKCo8ZIYY+qUWH5vtIso6tizZ3IKDzbifDs1RYPRuDs/7ietirCkIC5MmZeclQyyAFTL3ZDWkv6JJ1w1COsTKUsiYg0TWyweBep0br2b8zE35kgBGUy0+7MTbtfChB0dC7S3cecQstR/cJ7pxhIxBZpDaVKsXZiu3KltR5KKZFkbfUUA51nP7TIqwlRuwuFPDnveKlPn6N7WIEjyI4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QrpHObP2qPjzpkg1inITv0VQOzmJZdgd6cWO/WaDtU=;
 b=uEz6Fp3CSvziAmwTx0ZLMhvVLNlYg4o8oYx3cfbnYTLfWqvdYl8TCvm1E/Dk7QmxftFiMdqUgk04e53JGbkphrhRoZRX30jBB7NG9ZpNPkg/1O3kKoHWTE1B4w2sAyFMztk5R6cWWq3b6yVeAoI5qyvz/P6PaAMtwJymQ1UpZ8pqvmz0qegqBNWfmDDusekxrsmN5G/xA0vg6zwgOSLfE7vIREDN6322OErXMx7yaUpue3LssAs+pcOBr3zl4fZEcB5QFKAAKiXPFI1E4JORbPiCd6FmkylBs3uKVdmsXAvQjGvt+M3ik+aEdiNAJxsfE6+nNqQ53BHRzvnST+EkRw==
Received: from DS7PR07CA0020.namprd07.prod.outlook.com (2603:10b6:5:3af::12)
 by PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 05:01:53 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::4a) by DS7PR07CA0020.outlook.office365.com
 (2603:10b6:5:3af::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 05:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 05:01:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:42 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:42 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Dec 2024 21:01:40 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v3 12/14] Documentation: userspace-api: iommufd: Update FAULT and VIRQ
Date: Tue, 17 Dec 2024 21:00:25 -0800
Message-ID: <9026d32c1ef46ca867e27777f653c736551ba692.1734477608.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734477608.git.nicolinc@nvidia.com>
References: <cover.1734477608.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|PH7PR12MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e722d23-e4a2-4fbd-27ab-08dd1f21170d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8jZZpIvpoL5jB/pgM1hrct169TmsmQxzj7zkteJWsCeUz0XueNqajxNV5Z90?=
 =?us-ascii?Q?2nCWcpTqxLyhvsgzpaxwbcIWWql1o5PDNFNywmkkt5+js3XSz0vbMcIj46LR?=
 =?us-ascii?Q?5EmKanJuyMJg7j/Es/fVNoTwRBnuqShyjUcAYLPx0S1NcqO6aOejwMLFjdzZ?=
 =?us-ascii?Q?FrxqQpTI3uXkmserjvOeKS6Hn05VNCuNtqHhZxLdcY9fmUADv2fhNSqS9Xqs?=
 =?us-ascii?Q?JudtaomALrXYf3a+SGR2aweAVDt5yuaohOe7fByt+IG+aV/0QOWFuI9Fs5l7?=
 =?us-ascii?Q?vcfSvyFozyxxCQ/SLK04y4emqC7DSml/nJAKkWd3K4j5RgW1FrBHMINeOZlt?=
 =?us-ascii?Q?W+F9WjnmNDKBT5w0XdACbReVzXHtKFpGqeZG/5jFRVRAbULZUTHef4/KLWJA?=
 =?us-ascii?Q?bbuNebT5mwrwd/ltrNaH5BtZrjW+fJ1csirUil+euDHmzvJvVkUz5rw+mIEf?=
 =?us-ascii?Q?FA4dFdT/58LwZ/OOEc23a0qQdqgtsVHiYge9HzEBa0ahqz62GldDMD4tacjM?=
 =?us-ascii?Q?mYM543/tq2WCr/LDmRISD3hPNZtlVWa/fjV5iDdA6QpYHjqc/doSAAkx+AIF?=
 =?us-ascii?Q?wD3Ml8+Bq1zbsl1EDwtOknR1uVjs7SdfYRxryw8lChndOQ5L7mTM2JTOnvOn?=
 =?us-ascii?Q?qHLJVi/N0NwhYiAj+OHUj7C7P5h5fQOEZwr8SDybwkATKQc9BAQel0/Lcqax?=
 =?us-ascii?Q?3NsYN2epyBSS63G7PqHaG9wF7OmYdRoCeV/eix5hg/z08Om36HJDACd/kosG?=
 =?us-ascii?Q?7BWEn9Oy0HGak0ajLEnQn5PDjvx+sX9DO/vJ97lEBcpzeE9A9tGZ9Jv0Xxkq?=
 =?us-ascii?Q?O+Mz6njeXM9tlf2Tq+CUz1fBfBn5KbH1HJ0zUBUNSJmyzgOCm1uE/SdtkpVM?=
 =?us-ascii?Q?6C8rokWOp5p9lBpcePYFv7yYTL81NVjROYtSZCq638LGwGYilUqWmwv5gCqp?=
 =?us-ascii?Q?L0uPP7pYoCpp8btcNADK0oNRQIBInkXTlQ+HOYg7Z19+sEvd+wQmcjN12cpl?=
 =?us-ascii?Q?ZPGx/Gyu6awTf/btdqInPzOaIpp08fCEFO60WYMHgDsuKE8aS/m+N8rvAqWU?=
 =?us-ascii?Q?WnfnQ6WvlHm+GENU0q0WKPqHDuZUL+/QAzIMOWXI9mMNG4HbHPMrGDf0+sEd?=
 =?us-ascii?Q?jna/lD++kzxWdBL92y7BWaKPuKl5bCgxcNXYe7+l1gwQUX0quzcTZ5IndRb2?=
 =?us-ascii?Q?lupGAdPAB89Sp58jbmN6UbxXbH/ii7WA2Ozvy8+lUko9X2Sm/DXcA5+VdDHG?=
 =?us-ascii?Q?Zb/QppEigIMwxE/+2KLnVlwAuM1g9H6Lk/84i7bCQFoiKSiz0kHHte+JkTBH?=
 =?us-ascii?Q?WucW5/DuteKgxLWnGULW6n5Am7P2EOIV6flyISFRc6lx6QtQTV1Gxwwlrior?=
 =?us-ascii?Q?RK+lp5vVn6HeF/oXi3g2HZIXNHmpjqpY/cyyH3Ckyms1a1u+zZNV0k0+IfVl?=
 =?us-ascii?Q?EPcgmsM5qGu2RnSdEmba0M2UURYu+yMeJ1bU+mI71EXKMjGRvdZ2zM9P6dUZ?=
 =?us-ascii?Q?6VRQbCpjWqBOy90=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 05:01:53.5879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e722d23-e4a2-4fbd-27ab-08dd1f21170d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456

With the introduction of the new objects, update the doc to reflect that.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 Documentation/userspace-api/iommufd.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index 70289d6815d2..5b4ef5d74fd1 100644
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
 
+- IOMMUFD_OBJ_VIRQ, representing a software queue for a vIOMMU reporting events
+  such as translation faults occurred to a nested stage-1 and HW-specific irqs.
+  This queue object provides user space an FD to poll the vIOMMU events/virqs.
+  A vIOMMU object must be created first to get its viommu_id that could be then
+  used to allocate a VIRQ. Each vIOMMU can support multiple types of VIRQs, but
+  is confined to one VIRQ per vIRQ type.
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
+- iommufd_virq for IOMMUFD_OBJ_VIRQ.
 
 Several terminologies when looking at these datastructures:
 
-- 
2.43.0


