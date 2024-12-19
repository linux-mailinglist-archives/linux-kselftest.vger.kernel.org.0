Return-Path: <linux-kselftest+bounces-23570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988949F73D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 06:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54F6168E3E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 05:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E072A1F3D4A;
	Thu, 19 Dec 2024 05:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JSXcSuuU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0671509BD;
	Thu, 19 Dec 2024 05:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734584801; cv=fail; b=eZNRmhCzvP/OqYdUzy1MHllL/EgL/CeY1WFyzeBo8WGbEvrwJrrbZgGS/eFPMvs3lfxQGfrsosXsvQyAEIenNV+t7aUWfAJ4g7wbV11Kd+4xTFsp6Amf3g+ev7+2lbjq4Mp5kNnjL+7iIpeh7+razvWTJJTndZHvrCd/jLrZeck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734584801; c=relaxed/simple;
	bh=/iUg8zFp0NVNL6QsqFHZvdTZIhm51FpYGrpkyBbJO88=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiGkY8qVT8vnOWSlVli6MnCliQE2Z1aGAsn7kEG1+9KpKCDG6POQn7pAObNolM/NlUpfdQmAQZLZn/mQfpmGb6SwLU1aZFHx8lk6wROQ2oagHrKo5fBEJ+/c5v4I7YgG3Ruuw9dzKbOVe8vennBLXodXaMUAMus70FBEz9fNvno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JSXcSuuU; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyK2EEjW3dbK1lEsUj+cy/K6hv1WLXDJDWxu68sns19Js7n4p+sn3T+UzW+Q9pPygzLuTyrl4w7dffWzrdjsJUwGA9n/wucj1v4OUJ7rX1Mdro3tISK+tKRjVHJbgmRfnsqQv3Dcn42OCRQsqzP8kVWw5/OR9A+qMq4qYqWMQ7bOXhgQjMmRc7rZIAqRbyHrZxhJC9koAuv1/D3PByy2enuEbPhXu1IyppTyG9aIWKV6ZHwRm0IQhg9W/N3Mci68xjLVt3QDVoUy/ILwtHBLXFbThaP7vc1lrp1l/YUxCxRFLRxCroS6gP07s5wJ4dDct4U0atzcv84Bi/amUDBa+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+COgn6qh/7P62aj2SHlNb1Sbq3ccnc5uB/QXN/w596E=;
 b=aDK4T4E/6TRZmEWmd12X+gUkZYjMErnX6n/mdyks6KeNdHoov2AHQPSucqkkrReoO5G+RPgajFYsh5iXA8I9ZkHwoXD9U/NBcyKxncNAFg+ULiDPLDPD2quuGJqbUCfkkAu6sZHyib22LDB4jBowVAHI4mESSy5v+tCjNyfvbReHYN2QY9MMQZJ1z8yRiJju0hMSGSv6zPq/EA5gXAWKQW2wOuQHBgEQZ5HOwZYc5p2rmbCe019Ll/iuYnYPnq8fBhkbm/3Ct/9eSEqtGeBhGYhcqmDwjSRWDW/gGspRYtWsuaNFCUhNj0iIdBHF3T4qq1AD/UJLl2rxGMnXeXyopA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+COgn6qh/7P62aj2SHlNb1Sbq3ccnc5uB/QXN/w596E=;
 b=JSXcSuuUUZ/d0QOt+qa7ZsbbongvjKiV4knCNfTu/E6CFPL3c9ttRovto7HqJ4R60yvM+piBDfk3czBrvzCSvSPo0Sbufao1eCBE8bOiPjebDSbAiXqtNK6Gc8XgRrgiT3/fiHpmIBQ1dPwBHD58IJ7hZsIvnxVE7aK5cWqTaY/Cr73jYj5N0MTPwPv0NRCtl/mwdOxzyW4V7Po+loKJtSlBc+wZfi8JcgQ6bIIi/a3zDp/q4j0JrHkiIO6RFqmhMg8w7LveP5zHZANQnyIboRBdDceWiFPKhEHz8sfYo59d81feMefZP0oDKrzNnIejUpwJI7dNaUgTyACWCTNCjA==
Received: from BYAPR07CA0074.namprd07.prod.outlook.com (2603:10b6:a03:12b::15)
 by DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 05:06:35 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::eb) by BYAPR07CA0074.outlook.office365.com
 (2603:10b6:a03:12b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Thu,
 19 Dec 2024 05:06:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 05:06:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 21:06:23 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 21:06:22 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Dec 2024 21:06:20 -0800
Date: Wed, 18 Dec 2024 21:06:18 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v3 07/14] iommufd/viommu: Add iommufd_viommu_get_vdev_id
 helper
Message-ID: <Z2OpylDlhLXoo3dt@Asurada-Nvidia>
References: <cover.1734477608.git.nicolinc@nvidia.com>
 <21d7e63b97d81d0acf9127418a67efe386787261.1734477608.git.nicolinc@nvidia.com>
 <56c65e50-5890-42af-85b7-85f8a1bf5cf5@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <56c65e50-5890-42af-85b7-85f8a1bf5cf5@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DM4PR12MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: d06a371e-68f4-4faa-7583-08dd1feae843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bQ86aPOnqojefukgnu1C9+zfV7yJ2f/Xhjm/SMJnqNdPAh4i0n6dG1qNMHKv?=
 =?us-ascii?Q?zjv+2bzKvgwIM2yBKGjrmXIp0exPAYspaqgG/krwttk+k6/LhGEN7btCZkry?=
 =?us-ascii?Q?Dkd7mqA2K4lrr3LWQsdSgaX5VI6GqZy6REkGdFkPA+Js2DJo8mIdR5GgAx0/?=
 =?us-ascii?Q?kvt7324Z2D5VDM5KkTHn86Zi4P/JCib9WE6esjvQWSOtHMplbY03swJcxzFP?=
 =?us-ascii?Q?hWzKH+K6msUjiRk4Os/uIAa3e/MSRCtwRq1c+GJcXvNvIaSrVhIWo+RPsh7E?=
 =?us-ascii?Q?D4NgNuVGowYVa+2RCvS9o6FuU2sbxruFciRg9mAz/isWNyY8sb/S4eIZfaAv?=
 =?us-ascii?Q?QsO7H11ey23kVqxhxUMkZvuhKE3lXrA9i3JMadcjURNTH3Csk2SnsapoudDI?=
 =?us-ascii?Q?l5s8srnrUOYr2jRC5CZnnplI/geosini8BblrHUYqbTkIeBWz9Gzrzx5dSgv?=
 =?us-ascii?Q?xdyEFYvgWHIbvLOg/ZskxEKXFQr4Yb1yf3haBqgwsRXcPLwoL6ErwFWwkmm0?=
 =?us-ascii?Q?4VZq57zj2eDWrUYDEKA+p3xiPRYFPsQxma070VQxFL0D68tDYGa2CtsFpGfN?=
 =?us-ascii?Q?h8OrWqkzvvtOM3uVPrHAjJvS/LvNH5GEzjudAmY64bxaacuZuUXxtp2Mgq+E?=
 =?us-ascii?Q?clI9uRWsQZZ0kQKNc+Ob/YLqfYl34tfmKJDfA0uOcdxuhQZYptxOG637V2h7?=
 =?us-ascii?Q?Tciz4aNky8YF58NmzV0bzrDrN2VAKdlmgb6V2rag7p/TJF07BeqCHJZFf38E?=
 =?us-ascii?Q?KTkKm6VuTttzQ866/k/VJ/iVqeTBs9dzE/7hrzh1rV8b4SzpFCZBf08joYyT?=
 =?us-ascii?Q?Xqt/F9TInLi8Cv3f2J43reUv5H71cD6AwQ4iUJpX6cWNtI0Oc/PrNwXAAaew?=
 =?us-ascii?Q?wNIawB1VfIm9fmmfbxKUPHL813N9uCtK+TsF5fLdYFO+zMLKLD5+FzZSufkl?=
 =?us-ascii?Q?FL47CrHBU3xbBw/4HykJOpAilAxOyMsXfSTWZUVE/BFwT1BG6st6aMkrPNku?=
 =?us-ascii?Q?m5ttVHIJ8ckIHVlQdJa59AVWZzfUDIuM2T9rQk9TX3bSzn4ussNMNP3Vd1MK?=
 =?us-ascii?Q?OED5yRWvcyb8IjDNhzV/SdjjwPtczTgc2lnjG8uge9bi3a6nGC4ZiYfHyBlD?=
 =?us-ascii?Q?bpP4Xgh3OHxzZG8g8JbTAUWH3RCw2obIQYhm5Sj+Hp4pwuzrFy73cEfN1IQH?=
 =?us-ascii?Q?dKgFEXuX1m5XgHbcAepBC+ApTOSnl7Oh2vJT8RbfGKlDiDQW+7KkwViAKz7o?=
 =?us-ascii?Q?qKBA3jbws7Om9yfTJ2m7KmTyo8sUOLPQ6WRwih9BSdJ2W2vA8EK1a7ICOeYn?=
 =?us-ascii?Q?nHD3X1I58sKi3JNK1Au6uKxDI/2xvsvtNAobOZq5baWBXApUQoUx1soWT5zy?=
 =?us-ascii?Q?jWJp5WKHbKkbOr0oM2Z8Wb5JE7cHYbMztzWUeis+H7tiuiv+mh/bDq6XY+K8?=
 =?us-ascii?Q?lT7dm997x9Hb6s2XPY06zLyrdJgcinKE60xH7fVWQxy7UpwzwvyWNhhe3mpV?=
 =?us-ascii?Q?Bsaff5tmes7sEVo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 05:06:33.4928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d06a371e-68f4-4faa-7583-08dd1feae843
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474

On Thu, Dec 19, 2024 at 10:05:53AM +0800, Baolu Lu wrote:
> On 12/18/24 13:00, Nicolin Chen wrote:
> > This is a reverse search v.s. iommufd_viommu_find_dev, as drivers may want
> > to convert a struct device pointer (physical) to its virtual device ID for
> > an event injection to the user space VM.
> > 
> > Again, this avoids exposing more core structures to the drivers, than the
> > iommufd_viommu alone.
> > 
> > Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> > ---
> >   include/linux/iommufd.h        |  8 ++++++++
> >   drivers/iommu/iommufd/driver.c | 20 ++++++++++++++++++++
> >   2 files changed, 28 insertions(+)
> > 
> > diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> > index b082676c9e43..ac1f1897d290 100644
> > --- a/include/linux/iommufd.h
> > +++ b/include/linux/iommufd.h
> > @@ -190,6 +190,8 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
> >   					     enum iommufd_object_type type);
> >   struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
> >   				       unsigned long vdev_id);
> > +unsigned long iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
> > +					 struct device *dev);
> 
> Hi Nicolin,
> 
> This series overall looks good to me. But I have a question that might
> be irrelevant to this series itself.
> 
> The iommufd provides both IOMMUFD_OBJ_DEVICE and IOMMUFD_OBJ_VDEVICE
> objects. What is the essential difference between these two from
> userspace's perspective?

A quick answer is an IOMMUFD_OBJ_DEVICE being a host physical
device and an IOMMUFD_OBJ_VDEVICE being an IOMMUFD_OBJ_DEVICE
related to IOMMUFD_OBJ_VIOMMU. Two of them can be seen in two
different layers. May refer to this graph:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/userspace-api/iommufd.rst?h=v6.13-rc3#n150

> And, which object ID should the IOMMU device
> driver provide when reporting other events in the future?
>
> Currently, the IOMMUFD uAPI reports IOMMUFD_OBJ_DEVICE in the page
> fault message, and IOMMUFD_OBJ_VDEVICE (if I understand it correctly) in
> the vIRQ message. It will be more future-proof if this could be defined
> clearly.

A vIRQ is actually reported per-vIOMMU in this design. Although
in the this series the SMMU driver seems to report a per-device
vIRQ, it internally converts the vDEVICE to a virtual device ID
and packs the virtual device ID into a per-vIOMMU event:

+/**
+ * struct iommu_virq_arm_smmuv3 - ARM SMMUv3 Virtual IRQ
+ *                                (IOMMU_VIRQ_TYPE_ARM_SMMUV3)
+ * @evt: 256-bit ARM SMMUv3 Event record, little-endian.
+ *       (Refer to "7.3 Event records" in SMMUv3 HW Spec)
+ *
+ * StreamID field reports a virtual device ID. To receive a virtual IRQ for a
+ * device, a vDEVICE must be allocated via IOMMU_VDEVICE_ALLOC.
+ */
+struct iommu_virq_arm_smmuv3 {
+	__aligned_le64 evt[4];
 };

Thanks
Nicolin

