Return-Path: <linux-kselftest+bounces-24017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990F0A047BF
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 18:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067A83A0446
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F92D1F7091;
	Tue,  7 Jan 2025 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rui6VRos"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C781F7077;
	Tue,  7 Jan 2025 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269868; cv=fail; b=RjErzJQnxREcqCa2M9sYnBgRM2ujDEwrPwcsXbYtwN/zyS/JxMhymQgppImHXt/hvapfG7njw7IxRd4/n09ABW7L1HeySb0gE3n2q41X+5Thi99/WZZnUpf78xkrjI8Dn0kralnpnFxZCXAC97crVvzRSKAdPFkVbK9ag8haBPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269868; c=relaxed/simple;
	bh=B2FmAhnZ9U0k2CScENOyhhngC9Bh+d35A4fFQ28r7hc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlrViqnZRLE7cO4Lys562iRGlZcIehAtHYjRHJNwrz1/CdZ+5wttaFAnWQ8sCWUwS95mvdkM/TCffEYBkNFDjqaViSBjjVjo6SK9s7R4kIoMIrFQjduGE3reZ4Xu/6YmM0rOsMFWrLdYXUE4peA6hcpikrqaRCydkf+c2Ln7lvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rui6VRos; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hprHhcNVe9zeC8hSlcS6NJKSSOCPZsmAEiAsYuq9Y1PIvrQZRdrys3t/c3JYC7jyshlWz5dqTcNEJcI0bmOmmjzIBU4bynHSh74Cfti/am/hqJuxQpru3dvvUWBzYLEt2e75WtCixoXEI8LX8oCpt2bb033Nu6C2KA0HZAulh1gxXI7gTbsZZU8ZsRx4GoDaEvPyBKfAfsS9Pd7NxDA4l3eGL96kLnoHVEEv1Itk8cl0TOnzOkWft/qt2Fj4rhCMTRU/1u7muizuM/cNjoGBJP8jBZJGUY1+l9RyzAYiRT3MpMh/uGiDDb++pOj2HsOTnredMRPtUjTDSSaCC8Wjbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqWIeKVH4ZVvezMJBQc8VWW9UMvWwlEcM9KiCKB+PH4=;
 b=BS3NlSQv6PEYCab0fYBL+lUAvlXLjndWwmugHbXzgvlSDFNUFbIW8lFCrdStb32RiZ5fDQRaA4SAzqUF0nXPGpl0eFb3D7JN00NOqqPk7zRXFtzJWPSweFLuWToKXEL50pyG9Xl3ahMRkifXxjiQ8kd3snn7/pmhsVWapv0gwW1cR1rS2dX1/rhZc/wCL+y+8SUrvxC2T3LrRmNC6QHPwnQF4XXxGkuK7tMGWouHEG0GQ83TskdtfmwQD+A4DlyymCO45lpIKwUGoDjXEpzlwi2qHuIJ4KN/UcsOM+Zjnc7S4agpwVuyDhee8lI+t4vlteZt/2w8ZTnur3BuYCo/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqWIeKVH4ZVvezMJBQc8VWW9UMvWwlEcM9KiCKB+PH4=;
 b=Rui6VRosto4wV3MNOtOm50o32NGPsq+J8jFjmMEbHLF8W0Yk+3o+yNGDejNVwMb+j5YX8ibm1E7VNBZDc6FD+QpmiMtpukmGISMjQZuFD21Fu+SxhEyPnQfCG6RuHCND2vEYOabdnpNcJh8N8U4eOJwonAm+2gL4NpI78KddsdaJWms9n4yjCzwZjVL6kPQPO7qusZ+SEWbwvorGrQwVO6yHZ/nhXWjQmcO0ep8hycNzAI8nHvz6adA3OgEEX/IWhH1oThrglwPQqU3VUfbEWI7CmvIa7iWM/QivgZbcl/LRz+59wWGmzfl5x+LxBURZ59p3Ujl80S80jhejrf/viw==
Received: from SA1PR05CA0002.namprd05.prod.outlook.com (2603:10b6:806:2d2::8)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 17:10:55 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::24) by SA1PR05CA0002.outlook.office365.com
 (2603:10b6:806:2d2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Tue,
 7 Jan 2025 17:10:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 17:10:55 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:39 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:39 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 09:10:36 -0800
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
Subject: [PATCH v5 05/14] iommufd: Rename fault.c to eventq.c
Date: Tue, 7 Jan 2025 09:10:08 -0800
Message-ID: <af08ddec83b021cdcc6b2163042b04e369b6c5b3.1736237481.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736237481.git.nicolinc@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 88503494-eeac-4d81-7650-08dd2f3e3f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hIPsPgbYyGgbMh5RLoCceazFnXw91ERJ3IUM4+DHmurkJWDpCLxTDabTlIwm?=
 =?us-ascii?Q?BMCnFGGF7MlUzMd0Irl5IyQoBj9BvaJKpskKzmudY8kxjAQnaJFPpi01xKsl?=
 =?us-ascii?Q?rp8eQam3e6W8Fokj3IfqEZCgAbMZqsFT0/dYbhPApX1zFwYp5jbJuUhkfk3d?=
 =?us-ascii?Q?Wa/CMkQuKf9GScJlZ2FcxjB4IP6OuVNk0gD83JwKpvTOPlTnQHsnv9PPdNLm?=
 =?us-ascii?Q?cuKslQpYtBp/QrW803bR5g8969mtn+GWW4MhjoMuzuDhR5BROACgOqgAMAC4?=
 =?us-ascii?Q?HDBtrBvib/hxUxNiqbfglFqV0Lvkif+kgGnjOp06i5SBEhJrfYSLwzo3gL3i?=
 =?us-ascii?Q?Mu1OItj/ZFnP6j8F1pQqX4/J4cQO1FRrDaUabPkXrz6ZKv24oZ3wut1OlR1E?=
 =?us-ascii?Q?5CH8kvvOkm/yRheqczzYSfMuEid0/l4CZgW9kzvCXNzG1r1PI0ID3hSDe0ry?=
 =?us-ascii?Q?omfr7l7m005EtPFb405FG10DHEOZFvJkfcr8fJlxaz8wGJSPvUim+wACUZ1Q?=
 =?us-ascii?Q?hwyOK1GBEOxWN1TzWtbrN0wv0eZu1gB0KJTl6ZXAa6wWAGnChcMOuae1RBnl?=
 =?us-ascii?Q?WH9s5LWiugWZBixxo7dHH+Zv7N6SXOF/OvVU5N07OfONQKer7CYvPU9nd9Cf?=
 =?us-ascii?Q?/ubu9aRgAyMpzz+Wsmux+GPCMv6tjZ3Yo1KdO+UWKSRFWCzGj/89GcN/T6FB?=
 =?us-ascii?Q?snYzKZe1yIrNhYDQU0R6Pi4CBU4vtrmw2LY/SuCGH/LVqLzSq3PcAJflP8sZ?=
 =?us-ascii?Q?vlsynkl5HorwbxQj85sAiOFsqLYo9RFnH4TJptOPXo3B7OL8mgD5mIr8EJtY?=
 =?us-ascii?Q?Vow0uXh2dGJZmnmTtf5KDwKGcDA+1B1YuEFZlpEg9jpPUW0D1O8Mi20ls/kA?=
 =?us-ascii?Q?bqQ6o6cBeIqT0BGZrI4HNzqxGpFHEAloJ1lJh6LFBUKqVpcn75vUvbrhFAqM?=
 =?us-ascii?Q?UQuikSKGOoxmhf5llo5A+Y6y7Ri4bTboUW/KOf6DswY3zu6GSmMyPBTgH7Jh?=
 =?us-ascii?Q?CWM0UyaMeYwjdiMVOV+1ua1G7WH7CDxu9flVzBzOZDpg9rIGmYwUd8HC/rUx?=
 =?us-ascii?Q?Tws5SJvD36DSareFVX6PPfB/UKHqSJNHP1Q3cuphervM49cAQeC4REm4Wpgi?=
 =?us-ascii?Q?/+LJLinfwT5OEPPjbVIpcdBcZlqLT6+5IjsB85eQOBhZF8bmZ/zGfVZR/BAo?=
 =?us-ascii?Q?O3o9Girb+GNqVDExbqIyfabWdKWpDESnTs8IeAqrbZHCtryzh7a8Q5spr6s6?=
 =?us-ascii?Q?ZbsXqujSuzKRrZQfSYMitJ84UqyZlDpZR85DH35cRd7+hLEIxAPmdkQ3OGf7?=
 =?us-ascii?Q?ZQ8GfmArcELFaYuXBP38KpsKWYyF7YGBH8nJSKvLx3WZaQbr+8oKmaUSCZ7u?=
 =?us-ascii?Q?Ia3/UqMmDWzWy4mDxo2ePPegU/WeGa3Txqnv9T50f+x1p0W9N9SAL6VNu2x7?=
 =?us-ascii?Q?5JidDxFXVPn9MCZGnzBmIu8nX/jrp9/gX7WfUVpCQZRFvOWxkP1yWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:10:55.6088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88503494-eeac-4d81-7650-08dd2f3e3f94
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015

Rename the file, aligning with the new eventq object.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/Makefile              | 2 +-
 drivers/iommu/iommufd/{fault.c => eventq.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/iommu/iommufd/{fault.c => eventq.c} (100%)

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index cb784da6cddc..71d692c9a8f4 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 iommufd-y := \
 	device.o \
-	fault.o \
+	eventq.o \
 	hw_pagetable.o \
 	io_pagetable.o \
 	ioas.o \
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/eventq.c
similarity index 100%
rename from drivers/iommu/iommufd/fault.c
rename to drivers/iommu/iommufd/eventq.c
-- 
2.43.0


