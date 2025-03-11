Return-Path: <linux-kselftest+bounces-28775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B092A5CFCC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 20:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C18189EB95
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 19:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEED2661A9;
	Tue, 11 Mar 2025 19:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hn3Q/jZu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F1C266189;
	Tue, 11 Mar 2025 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722346; cv=fail; b=UgZg9Oqu5oRbIIMXB+kSLzzByVqosUC0k9VitXTKOngK1v+OZGjAxX6YWX0giTyByBx3w7jHrN87ObsuhhFt0jOuoPC6tvu9yHAR96g4dd4FILP8UfBUm6hBe6A6emvmmky0Z2mqVNvdU+l8rVBXuFSIEC6w2p6Kij5/g0GzSH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722346; c=relaxed/simple;
	bh=2Q+la1Vr7KdS12V/vYxQZgWA60+Htge+0ih7MtG1OTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ztvl+/CRkMThQ/aq61IZF9rg1wfsECswcrO7HcXomGGehqaUKr/iLzHaA2WxkfXRgQnWww8rCf0VswkMLGrHxmlsHkQ5mnTGR6gh9+vTpmS1A+cEumgW+gUFLMSbHG/vh+JHZL9L4VtcBDxhnrUr2qBTmrmoQd62y/XKhkCP1d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hn3Q/jZu; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTBodu9NVz/xQwOwX0lUf9pXaC53VFx26+UqJyHZ74tDaMZCDzCuEp8BSyhcIb9y4iiHlqBVp451j5uxfZ7YAuwqIz6aGWdBCNJF2c0TDVd0VH0tcKJxZfM5U0HgvoJr4Itl3njE/FPTLgABdmHfwHrX9TdnaOBGw4F3xtYeF+chsrSk4/liGBxl8KNPWNl7/NzGtfEqdNXGmldnYffkeXqWU+gnycsRfo4EtAZOspSoLdanBDhOCyljBgXUj/1qrkBeI8RtCK5TvkhlY5a5HBn+9LNMrSeCaia3E5rXrekhHW4BkgPAexL4CiGrC1mvZ/CgzRcUfYgO0Rd9nfJr7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NYHNYHk4Eskt64jA06hjjLb7nD8fIqO7zbe3QJ7OYY=;
 b=LZsl85bFQ3r9Q/imJ8/5A2q2VLnmVDpwiy0H/f3EKg+MpdYUbHCdJ2S5Rfs2HlLPIHhsNbF3M4Mb6vRE7PvANq7d2D+agtRJrYeE5+LbRk7nYh+GjnCeOlHex6cJMWBAS2nDg0BtHat6vrPJCIWfYuNuy+E/hhnicJ9PDjJS+GPXu0yjfvcA8el9jLzWaAIy01Ii1DzqaPZ/ZR4ZEZEYydrTggAsqBBrqpG5Ez/bMuYb6S9j+c921tFVf5eAqhKWYZZVwrenbSLTl2NwvTzc+d9QdoM6xQDBtS8yCueBPNyb59/O6p9JiVO09JhWnPE3FTVZHNK1O02zyArsw9QBig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NYHNYHk4Eskt64jA06hjjLb7nD8fIqO7zbe3QJ7OYY=;
 b=Hn3Q/jZuDaA1K31d4hZSzfAIYCv2k/7/wFNt983PeRJEm9UO0K67CGTpX/OLMUrBsNd/WwPIIoOuJ4bb6kBEkgXfz7Ck0R45lQT3u6o9FYyY0gP8zwLOHuQoiHg4ZTfvb5gRD7vxcLM1u+oBFtOCCaRRCFG3AU8LpfnbwXr01kIp6jL4m/J3LTrtrDTjQiYYN9L0YLvgY7rMw/QuZtLSpdADOYURcVEevZrKXtftPeJBfaTDJJ+AXCJJlmJUbCJ4/qUvB05sso86cUg2gO4gg0ME6kMNL8TSDd0fQOIp7DEp7tr/YvUHN6xs6X6VVeHJW+kLB0UlejnO0jfrEiM53w==
Received: from BY5PR16CA0030.namprd16.prod.outlook.com (2603:10b6:a03:1a0::43)
 by CH3PR12MB8969.namprd12.prod.outlook.com (2603:10b6:610:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 19:45:38 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::36) by BY5PR16CA0030.outlook.office365.com
 (2603:10b6:a03:1a0::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Tue,
 11 Mar 2025 19:45:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 19:45:38 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 12:45:27 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 12:45:26 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Mar 2025 12:45:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v9 11/14] Documentation: userspace-api: iommufd: Update FAULT and VEVENTQ
Date: Tue, 11 Mar 2025 12:44:29 -0700
Message-ID: <09829fbc218872d242323d8834da4bec187ce6f4.1741719725.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741719725.git.nicolinc@nvidia.com>
References: <cover.1741719725.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|CH3PR12MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 47318468-a7f4-442b-d12d-08dd60d54c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q5YSd3frGtciYp9a+Zuq6TiZtlNwJCk393pel8deh/3OlPEePbPGD95HmrXA?=
 =?us-ascii?Q?zpgp1egqmdEZwJY/waUMEoR1rZeBUZCP98x8SHVQnwAuJUGJY2XhTqzu3ECi?=
 =?us-ascii?Q?3K6lY5GeFlf6sj6MgsyoXaunxvQBSWF2kryYPkq2qJanSQ4IcHphHNHk5euj?=
 =?us-ascii?Q?qYos10l8UNr2Il1lMpegMxlCNQIPVaja5CHW0lVA2JVbUc8QA/iWycf2BOxg?=
 =?us-ascii?Q?Fzu8xfNnWA3BHU5SRc290Dulkv8mi5RSfEDjTvqNzngsjTCszj2CsPbye5Gt?=
 =?us-ascii?Q?ivLh/y74/zFJLOfdmrD9pnfQruWfUHJ72PZASawsdJy+oaDfFMNhkniLZTSQ?=
 =?us-ascii?Q?VkcroWSKUdycSPnIKmUcQ283OfpugK/aibixG/UKZFuBI7LoU4lgrHgY1zUM?=
 =?us-ascii?Q?Qh00vOdKmHao7OEC7+S7aeGr+j0HfHdi4Ia8TEfIjw6++u/LXMD3ABfw3Ya5?=
 =?us-ascii?Q?cWmv2q8TXxSP40O2OpKjpLC55Z5pUmBnR1rKrB2X0o6jZhBTM7VEKydHIp3b?=
 =?us-ascii?Q?MHVex0VEFT4o1BTJ6qeoWshY2m3NY6OL9DVZhSbBbF/PTqjivGytnT8y4/nM?=
 =?us-ascii?Q?3Ncip7EVkjagelxXUOfRAhQmDczqS3pmstc/+hWSo1aK5+KEcsyMLNWwZH03?=
 =?us-ascii?Q?fw9CpNd9bamPLG4uMfM2NuuQ0sNBf2Tm0j3GyGuI8ysSSR1XeC+r2wkQaOiO?=
 =?us-ascii?Q?CDY9Q7MPnBMScsLTQ8RTNjZYCec7lggXzE2iyn3WwZJMfgesPqNZTd/imPuz?=
 =?us-ascii?Q?epmpsBvkE3BQf0wYv3SBqKaLYft6Zs5QbCgc0kTHNR0y2h8FU9SY0lHuu9F2?=
 =?us-ascii?Q?LVXfK5Td7c8l+uhmhuh9Fu1V4R4wSi67MVbo/zs4z8rio8GifdkDiC2ZUQmO?=
 =?us-ascii?Q?ORWvI5hPE65wlVkzZHc4tUxx9GHKGCy9VqnjrAGj4kJYhNQgBUlRg0kio2xl?=
 =?us-ascii?Q?XL0AK8a0YcxdjDi8ei1tufCs6j5xqrz1UJ3OkSiNIhQdX3MoXLJrn8HC7hgz?=
 =?us-ascii?Q?U0eLyKHVVN99VvFv3wvO5M3FrToyF8aq4RvRays+MGsaxbGFbDNZ8cpFh+c5?=
 =?us-ascii?Q?nEs9VPPGqgPro42y6iOz7GlxjEZF0bZwYRydBqFx8UjjbFYNKofFpkivlxWL?=
 =?us-ascii?Q?mkA2JYUkSliqNaPFyEiijet+pDrr4ZdLhQaKF6GlB2SyIGpM1A0UBGDoQM/l?=
 =?us-ascii?Q?jpkOW0lyaEaR3aJl6TyeXLon3ffr569sgq6nEK8ykbmYrKNgdS2qBVMMAs8v?=
 =?us-ascii?Q?2ou9zLGEo/nTdTqes6+ViGZV8m7GwqeO6DuzhC4RGfS3L4Cs06D49tCrlRP/?=
 =?us-ascii?Q?hwA4A7mThEGZRXZztuXs8Wk1/K+xgM5q9CMJqDXGTpoY40ohdktvoISeadVF?=
 =?us-ascii?Q?KjehhrQfmAWQYeh2pY99CAnfkS+FvKcUCLgJSXdrWUL7YcfLw8EWdy801fia?=
 =?us-ascii?Q?WDD3Lp/cSuQ8IapbJnZAs4VzFzYpgv95KJUcB4niTFEVMFPHCfFOs1Af2QN3?=
 =?us-ascii?Q?/UQt+uym5wohq+8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 19:45:38.1149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47318468-a7f4-442b-d12d-08dd60d54c5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8969

With the introduction of the new objects, update the doc to reflect that.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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


