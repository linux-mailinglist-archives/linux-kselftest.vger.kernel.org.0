Return-Path: <linux-kselftest+bounces-27503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A007EA44849
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36A8173203
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978EF20F07B;
	Tue, 25 Feb 2025 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QnOdd9kC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB61922E0;
	Tue, 25 Feb 2025 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504391; cv=fail; b=ZjHA4ZN8lo8z92L7sk3Cob70gpKhDw+9r/+0SCvNsXj2+jJAhCyQYCwliqPQux3rsdsXjgZynZLUqBKhx0mTsfculKJl7ZINjoFiyz27ORON24FXZiSfndf/EIe9ZP05ZtNMpmkqjr37iVgSi0ze1hiA76qrp08DDtXk7FeXRWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504391; c=relaxed/simple;
	bh=2Q+la1Vr7KdS12V/vYxQZgWA60+Htge+0ih7MtG1OTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2sGhnUb2OqHPN/RrO1GriKA2MEBOuQBG0zxHeZDl93slkqn8mjA02gA/izLNcGunCr/I6bZxdlrBHjJTWmUiF55iei2tpDsnFr6eGz9cJIERkw9f2zXZVNkQuPyZttUk8ZqXCmcauRfvIMixK69ng+ZMOl6nWiJK8ALLuDYEmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QnOdd9kC; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w50CgGDJXqoiZnTquVQNPDLjl+fR5BTbCUGECe9LUY78qZJph/og3jZWw3Rei7VRL9zfjkoI4Ud8nRiPMfoOCcILp0R/0SrDGqB9ssmfdT+srzzQtgyMdCG3f+L8gFo6UFvdnIQjI2CRUDpIvtZy6CWnK9TBahLNjKa/w3V/jefPnvP+d4iEEFdm7YBCBQX/fW/eCJWZdFLFkBy8teHb453zyK+v8eWJSFclG9IBan1fr2drI3dTRwhGmct8YdmRelfmPamaypScHsIy9MF8ERp5bs+fyuVOEIzOLgRZ2aDbm1JCyegJuW6xvdxCOvkWfKMqxG2+CGE5zr4fik56qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NYHNYHk4Eskt64jA06hjjLb7nD8fIqO7zbe3QJ7OYY=;
 b=UbgAiO5IbUCL2WokEpIzt5zfXHaiTbGirOrQwcVDGkNLz/tSxYwTSyEqRl6J8LkCC0AEMHoL8eLl352dSyNlKcTN5Qq/c7M6pcP2Wgq2er0T21NGs4+2Dm5JAGJ6ujvTGRbHPSoqWygNDlkJL0yWdTDboYFEzGLbL9BERmP5iKXVOO4zaShEYugadIBTFua5A/tcrSALZGqg4T7LcKbepD8RAPur/7NAa3w0oei1GWwhVtCo4VAFVNnQE1tnJAKrE1aBqCEs/o89ronu0W/S0uZaUWIkGIwg11tzlmEtqTbQl66xoCNUOc9QqQcPIo/fgdhAXKfOCM7TOk5oupq3Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NYHNYHk4Eskt64jA06hjjLb7nD8fIqO7zbe3QJ7OYY=;
 b=QnOdd9kCVl1zKqb1L7FB7QWq9C71f8kIqr7eV2G91JExP/f/OE4XbJZKtTV0H7/5omnuPjMcSNfvEbmtd2TyhOWWqtMNog5pzoJ8//jKSrcz8mSwZvmD+K68z3+ol6utuXHPLdNXu+T0mS9t5AiRN7zRO9SaYNIl9v3fH/bG0hNw1tQ1Lwi9pEOkiFSBpvYTrzzPSBDoLftKJ17fLttErdF1JCOTTpGca4LatPMVi6wWDvSVANdZzESpzCeQovYA9TbWiuEOZdYxWVC2H4fOnkgqcMBr9PxbnazxG23Zb3qX9cPKkOwIgDMiW/vk3uh8Hl9JG6ZashBzYUO1rnjonA==
Received: from DS7PR03CA0172.namprd03.prod.outlook.com (2603:10b6:5:3b2::27)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 17:26:23 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::a1) by DS7PR03CA0172.outlook.office365.com
 (2603:10b6:5:3b2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 17:26:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 17:26:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 09:26:09 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 09:26:08 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 25 Feb 2025 09:26:07 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v8 11/14] Documentation: userspace-api: iommufd: Update FAULT and VEVENTQ
Date: Tue, 25 Feb 2025 09:25:39 -0800
Message-ID: <73e33f17df6df07286b8e32f004c2347d8fbfaa8.1740504232.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740504232.git.nicolinc@nvidia.com>
References: <cover.1740504232.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 1746fb84-7ea2-4346-3592-08dd55c18672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vNx93U3MGAn9txHawW6L7FGM3xAfEhRD5bkVe4lq4NzLbkYrLfpQYffQlpt0?=
 =?us-ascii?Q?N5TuTq0INX90L+dHfZZiEOq5a3Qjf9Fx7clbUHYkF2h58x+XNIF4Y32Ughs6?=
 =?us-ascii?Q?It3CxU4iGv3ryS0dbl7fnHew0s2rpYkmusQRmx215FRMqdUr/aRP4CV/JAg2?=
 =?us-ascii?Q?UZgKEg0Q/zlUY6jpN41jrVJbEF4hcSH+H2hdueUrCsPLtTf9UFLf++jEU5a4?=
 =?us-ascii?Q?As+9KfcCQ7Fs0iCIl6rkRnQU0y1ApNHef8m9rgJq8ct+yt/EgsetE6McXvuD?=
 =?us-ascii?Q?a/n3A/reUSsaPF3HHE7J6KcBndHmzZppyIh1WPfeh2SrMuqWm9stV0VJohez?=
 =?us-ascii?Q?bA7WXvT2VqfvVMNnBw0Yjexx4bSt/TYhmdjh/Q+xWI+SPSWUIkPT4FXCggdI?=
 =?us-ascii?Q?Ag0mNEVep3m+LTUWThLYhMheRInWnOhxXzdvc/yabI55LdY9Dq+E1wfyHk2C?=
 =?us-ascii?Q?HX/YELqRS+xeIG8yHa6EC+nqLM1kr/RTVUhYOQn5sGPvY0vXWagE9+7KKO4D?=
 =?us-ascii?Q?pVrrpEVwcXw+AiTjiIP99Yky/OGS10AghDrQ4hYfzBmcqgJc50dp9CpF5z5p?=
 =?us-ascii?Q?RMyFxt3jIe4rUoesCPmfCFUpZ7F39KBPbvZ5MrRmHAbTzqWl8NUjMBKQG0fN?=
 =?us-ascii?Q?yMo5xnvdw4RrQnxq1dlJrvrQo5/QCecEs7zVY3rj+/Lnr0fO9QBH0eFL5XhT?=
 =?us-ascii?Q?OFxBjN8g275vekkM+OBqa15TNvLiUX0PD/6w+tcScu/faBQEYe4A8jQZ4Nla?=
 =?us-ascii?Q?SrGTVTriGSWRz3Qf0rjxNymF/2pvpjsaeNoljQ8KsXmIg8Q874FSQIEH9ZAv?=
 =?us-ascii?Q?JtC7xhdNgJypuRk0YMWECw9BUF3NXkIQsWzQWLmNI9maR8GesB7PNZzZRjqg?=
 =?us-ascii?Q?qZdYO8IWzDZAPndpDfJ7g5rH8hkEeBAU57FR+xsnB+LTTLN3+QNHxqmHmklv?=
 =?us-ascii?Q?lTH+eDGMacVm3BVPNygxSpOeIyMbHJuJW0v/FBUUJMLDc17cujdJ58JxEZ3+?=
 =?us-ascii?Q?iMw83Hv2NU+NRi6Ovnse5Kh7SZm2KW5lYvKIe8s5LbXKoF99q5LBe0oHvx++?=
 =?us-ascii?Q?Oqxx4Mvlh+8vzkfGQ2/eQeXP0xr5nsTdUBZaFM6uO+1vtb7bEJIJiL9qk1qg?=
 =?us-ascii?Q?5jnZLEiPvdTKArLsLpZEHZQBWK+Px5Cv6OLVVXcTQRQeR6/u7VmLbcQoHjUR?=
 =?us-ascii?Q?Xu7ZiJFnccZTVW1Yj9Lywa/T2Mqt9biniqQQHDEQ/3uoK2O/Rqic5xwI/Y+I?=
 =?us-ascii?Q?eNimn2v+xk0jufHAsqbaqD0fVDm4gEewzK497btMwsUwUtUw0KItMBUvoJzj?=
 =?us-ascii?Q?IJPSVkU57a3ZPbsoolka5a2VTb7k6rE+l2+iItsNb2v65ynnnTqPSREEOB0B?=
 =?us-ascii?Q?zRQ3ERNxZDPuUZhZLwcomTNsWiZiUZArgbOHT1r4BIGOt9qf/Ys00SGuSK1y?=
 =?us-ascii?Q?SaAdbTrIoZI+iJRww226QjuJkk2QNtEFlHy0/Q1IXPzkSZktY/P+gWkop78k?=
 =?us-ascii?Q?dhNXjXhIAsjoID0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 17:26:22.7595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1746fb84-7ea2-4346-3592-08dd55c18672
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069

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


