Return-Path: <linux-kselftest+bounces-32715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 236FBAB086D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46495521D7D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A7E248F7E;
	Fri,  9 May 2025 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CACT/yvp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E5E248F54;
	Fri,  9 May 2025 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759835; cv=fail; b=WwKD/l1Cf91POtl4/aaXi8eD+MmbNy5ncAKYtkLPfqHSC6MZmiLiqtrUdckqdrbUBhWY9CN5L15++vIprH5Al3k8T1QL9oI37Kn0GUKNXDnunEvCgoFXQ8+RcdCuLuDAwrBJ+R/FjN/yXBsWDVWdq+UIP8OGHAeRwR6EmVeKh7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759835; c=relaxed/simple;
	bh=AkPdeaZ5pIinYvlFc2UssffAtRql980xNWjJoNfMzKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnxghmREsKrLFQAuupy6EJpiTB4JGuWGy26Oq3UYvZHmE6u45Pme6yQjfP/u41W7pLEPYX2oaf25/MeTb7l79gLZpVoyX/1Jz8m3CRWBpP3pkPb2I8FG2zFL7iJMnT56XcXmX3Z5RRIWans466+PMPZmwkzPo16JMKmFm3pO9VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CACT/yvp; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XG09oE6d2OZP/+VjGjSe/3lvjuWuwGz6Me1W2SYkDC/PyDmYiOFHrZ/dctdX2vIYVKT0ytdrLW3X2puT2XlSoSOch/IQAmd9I7WpQzC+HHhU3/ZNFlYxaLvoJdjZPe78bZwwC/q+Sm4E5/JkxsvCvxLZFQKPUYobLV8emCCjeUcClsKDFSIQ6FKasBfKeqYLM5ifLuvEQ3gJmBrIw56T6w7ViNxXiAKo8NSiWmkJ7ed/HpsFZfhvdWAGL0DP+KgLjeDBa9gvjKJLZl6iIWXXZ3pzmxGo3bv6mCFdlHM5bY+DJOIlOdJlE1aP9qRW4QCaXO4+ZKlpQGlepIG6GVtY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02Zxw8/Ib0RLoSCelVciNibM8xr2PXvMqA8nmzind5w=;
 b=TbK4S8V5LCDgivRIkjN1wYkM5l1OE55bWkTBsyxgaUw9y0FkPAw1AzzZ81vqgbV9OICqEMrQjCqGDpxbZvACegL7EsN7O+PaXqmeN2mm3oW4GAusGtA3/hyZzv0tCToeG50bCBZ+J5zIFIawRgk/I9WQPcMW1mbsflqawAODwLtBAZLLNFgcF4d8PaklgVlBZEDJoRAfHzQLmWxu6UbvNk3CBkgLvaZ5hVEywLQWkkhGoPGEO9w620FtCnozgQb2DxZe7GG4F8wmYoB+OoHs1xQuZxvv80f81PaymONuu+zCIx20BWPV5/54WKZtWqQsD7xdMjKa/61zHbA1m2USaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02Zxw8/Ib0RLoSCelVciNibM8xr2PXvMqA8nmzind5w=;
 b=CACT/yvp7/TWRyStj3JuU8JXPJxZkbsfwjVuUj6LU8YUPnEXmymJ17jFqFZ9KurJUUHwuOAp4/gcGBk9uXO8tGtBSC5hTTRx4zTcUnbjz5/nSFdijjIfug6V4DNTom122vNbbwpXBzLWVmPobrpFu1n++8fyjEhXsvgEi30asXtZUWeNbpX/5wJ5K4mYNutT4RKtWq3l+oBerokB3WQLbUw2nsWuxMbRjLM0j6fkXYHwSAyzB5hAH1prmpjBNMqPazgjvjtBB5JuPynJCedY+xKXVVjfQOxpwc24mwsWwb0YJbAL7zj1grgoF+Oy5732Cwv+NP3VSYvRV0ZhyJaaUQ==
Received: from MN2PR11CA0009.namprd11.prod.outlook.com (2603:10b6:208:23b::14)
 by PH7PR12MB5618.namprd12.prod.outlook.com (2603:10b6:510:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Fri, 9 May
 2025 03:03:45 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::a1) by MN2PR11CA0009.outlook.office365.com
 (2603:10b6:208:23b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Fri,
 9 May 2025 03:03:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 03:03:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 20:03:35 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 20:03:35 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 20:03:33 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v4 16/23] Documentation: userspace-api: iommufd: Update HW QUEUE
Date: Thu, 8 May 2025 20:02:37 -0700
Message-ID: <06b52408c31858e39a2fb557fd35f80db965f646.1746757630.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746757630.git.nicolinc@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|PH7PR12MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad5303f-9c03-45da-75aa-08dd8ea61cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ktgFaDJCX30dBSPjNnpvE7kXbG0mct42WDzi1z6jLVF1PCpxsXjRlsUWqNiB?=
 =?us-ascii?Q?tynC9Gu1HridJGWrnZX2rFU2NTmjnZWm4QZUQoSrZXVJiHV2Ajn6ndaobktj?=
 =?us-ascii?Q?0FVNRLZ52Ler4/aC8CJr8kKVZ69fSohWUuvvYuoxykpwyci7tJpbJJR2BV9L?=
 =?us-ascii?Q?4AO5+3XFNmkXeAz8sXZjyLA0y/di1FT7OvKttLEzrx9eJM9vuCAsBaZ9/TBq?=
 =?us-ascii?Q?nd1RfF0/tfyorXC65RsDTkP8cuq2d7+Irk+8AmUdmW+t03U16pfSNsQ0Y8fJ?=
 =?us-ascii?Q?p+uHCkojofwutuSEq2dcAT9bQPqORxPKeYlXteX2iSUQNvwlrA/ndQwWG8sj?=
 =?us-ascii?Q?GvxvTBiblROT5QofklZxTKPVozaW0o+g0EJZlCcI3PA3gDoOuD+wrycC5VR+?=
 =?us-ascii?Q?6alJvWAC/5HamZ5gHdSzr/Kvt+torBjCLZajt572u6lBJgCkOxNz11fNaQDy?=
 =?us-ascii?Q?8cQsqa+trkqF8WQJ8CjJufLuVwXV826O3YkGZMPlAshqMUYPvHZHNTwqZTBM?=
 =?us-ascii?Q?Dvbf6fa9oqG6jCdPqQjITouaWDxzNUO8zM9LtAZyD73+zFDwBi9ilVYQcrCQ?=
 =?us-ascii?Q?w5AvP3195ECdAPi8o+mUZhD4FRtxYwEN1QG0YNTuUDlnt7j9DNskNf1O5VgH?=
 =?us-ascii?Q?nBsfBCghZaPRYGy6J6m0xdckUtmEQ4DGXoxGDiCBZ7NszMc+1M/1E5pq3vKJ?=
 =?us-ascii?Q?LUX3GG8zns4SAq1qzM/yxg7dtEnle3naOFYW6zLG2ARGOgV504HEKo/ZHU1X?=
 =?us-ascii?Q?1UyTGcOiO3KP5kk8sWB8rm6VeT2vZZYJl8HQN5zPLJVpH27NWoi7FUeAIEQ8?=
 =?us-ascii?Q?WdW3PilkEEMP7AtdVMMKqpd13+9e3EN2tO5gpwriLJmu8Y8HVzZia7hUIhZE?=
 =?us-ascii?Q?pn9Lz0vTP7RL136v7g0/430W80uNbzVcayspYcks4it+yJx3iCm6gMQiXl8b?=
 =?us-ascii?Q?p9TBgxTK6Mjbdsr8ztf7OeimecVttHCrjTR7lPm/4TZ5LZRTS8j5jopPasRo?=
 =?us-ascii?Q?I15GciBcW1Lh/YgtcOvKYI1ycLJWuP/NfvesteESfq0tOl38jsoLWhnL0Mx5?=
 =?us-ascii?Q?bggUO1j/H+Ku53FsVb8ShP6goCGl/6mQc7krXF4MsGuurodqUmcGmIIvZ26n?=
 =?us-ascii?Q?Fn+MJ2/vOyAxMdEiq1EwaBMNY0vjCI5J6huQec6WS8dTHYO2t2Y4TUJqgrvc?=
 =?us-ascii?Q?4isYm852UnIM+cdDiT5QhYf9rhq9NhPen4oQfX9ZfAgK5NU0AH3Uum8Mnbrh?=
 =?us-ascii?Q?Gq0y2L9k14b1WFNVTbqaWmAXiyd7xZUxZkdk+2X/6Wfn0pN2UEYSsj814im+?=
 =?us-ascii?Q?+vO2Unq8uI2SdkZFcc+GgQx5ZnAWR+VjxTb/xgYm94KC7GFihX2AXmOZCLNE?=
 =?us-ascii?Q?l8fBUSwqreHh1BP+a4ydDy1ttCo8e7pkajcihB8oQxsFsS48USXfPlsB49LP?=
 =?us-ascii?Q?JZF7kwm5U9j4Pe8xtpU1jnop5MLTYwugXdnCpOAkYfbj2KyvVTTj7Lf/845e?=
 =?us-ascii?Q?wjoav69y40eNatSPg1aFtZ87WKfi8O31HKez?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 03:03:45.2154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad5303f-9c03-45da-75aa-08dd8ea61cb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5618

With the introduction of the new object and its infrastructure, update the
doc to reflect that.

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


