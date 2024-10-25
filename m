Return-Path: <linux-kselftest+bounces-20602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 060849AF847
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 05:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E041F24F62
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 03:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1936A18C01B;
	Fri, 25 Oct 2024 03:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KzP0diu5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BA418BC31;
	Fri, 25 Oct 2024 03:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827443; cv=fail; b=fz4NmPpcCkK2X+fLlz4t8XrncnUHFoZY/NV7gMYuc4PufjrKp+aGYKEPuBiafLW00NZblYiSDNkSQSnGXkBYYka8ziYVfq8Dv8+DihoAOg6B5UsBO2MD4dVlllIhbP2Fyo2rO1DNaMinfjthU4eYDgkNAEQXhhaWU1uG6JFAbkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827443; c=relaxed/simple;
	bh=bR/u6QUSOA7CsQkNZFSLxkcMToz79d176qgrvhWVJ58=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIvLIoq9Kdwc08NqLrE4Zb8Tidm2cEgq3/Vl2DFVj8vDt07in+5P6/fKh21B9Y1/RYPmDuCqMYgEa57ioBTzBzXzECsZ/AkeLRFdzApSvmFxcqA6O0ZBB5V3CuzeuIwVaqdVNp1lCX9OS5/T/w6EGWVnqFqpH6DP+pqktiPvjko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KzP0diu5; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwIHzkFzb9EBsR6tgKlYKL1H+HETAFqHta0vRJClKY+XCHw1JK6OEdqF7s6TJbCu03I7K8MPQdPrA8rQdFcIBiI1ySu58M1F79Cqb/Y0EQWHCUEc13g0DHCnB4hxZqUK7ZhK0Pd9aJ46rNoD+LkmZdhDQMloVkEdxl/5a1It2wv8/6fsKKdVxMHxP+v6lbg27UrbTYLyZLBL8VnmqNTg9zQTeTj/70IgXEaA80JgoUAhflHkqpglOzKVb2j6oEC6h+1z5nscY7j4YaeToXvUIpEJGTZvEPeYpvCYcyIr7Y+BjsGTarIRDG30fs8fAalffitS7KzN/czDsf+3I3h4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfVJABw5JQWdwn95WrUwMmGTNcJ4UEokIeSIFXViSmE=;
 b=ABeMsFQfsVfmLwdjUFeJnN0jRNxSBDjaHru6uaSVQUugOS9p1MCZgtLGDHM2zfJ1dYpCh+y9/uIDRUpy2iOQeq/4S7Ct5CEkdB1r1H19qVDln7Io05mjGnZnjHVA3qe1KQk5iH+CNUo56rKTlbRWgIyZfcfNEGCS7ixGRTLTAa9qlZfD7ug0IWD96azqdmXheWft4RzYTyAaQ++tsWFshX1eU25Lqrq7isp0ACoQcoUKAJnYNvnIu0rueEtZmW8LQAEp81oPCxynnVtYKpAhLIRTnzHesFxx3fyr5mBU+ptlhZNNqlMmqHQCJh5fLRa4bXbrl1ekFw5+kprx8SPqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfVJABw5JQWdwn95WrUwMmGTNcJ4UEokIeSIFXViSmE=;
 b=KzP0diu516uTHzafI6wQV95y7CQ5DY6Fzel+Gr2n2GOM9yr0uNGQU1vUjtgKVBB6+a79zr2SMLRrWyIbxdPYeh6Y/vhPIpe0pd/UqcIYcxzd07tEqh3cdHttzuElkGxkizA7a7/hpsMs2qIlQXMgkLNibATFFCO5vBASYL9zkFikDsqS6Kfe0bHUQOFLyaGhF6MVwFIWMZuD2wk5auZ86YG16Bi6pczJZsApmSwQKAcz4qYqZRqgk/vwE7qY5yyLtMTwmrYcTHmmslv3MgPmwuXJczq/aV9h8/xrAzzslDnClZJv8JENcB4WTpsvgF8tW5xjunGOAwcl4mVRUN+BUQ==
Received: from MW4PR04CA0327.namprd04.prod.outlook.com (2603:10b6:303:82::32)
 by SA1PR12MB9515.namprd12.prod.outlook.com (2603:10b6:806:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 03:37:17 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::e8) by MW4PR04CA0327.outlook.office365.com
 (2603:10b6:303:82::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 03:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 03:37:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 20:37:08 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 24 Oct 2024 20:37:07 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Oct 2024 20:37:06 -0700
Date: Thu, 24 Oct 2024 20:37:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v4 01/14] iommufd/viommu: Introduce IOMMUFD_OBJ_VDEVICE
 and its related struct
Message-ID: <ZxsSYbK3gqyC84U7@Asurada-Nvidia>
References: <cover.1729555967.git.nicolinc@nvidia.com>
 <ec230c740b649bba1ca4d2ef054d90c79be4be28.1729555967.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ec230c740b649bba1ca4d2ef054d90c79be4be28.1729555967.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|SA1PR12MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: 302e74dd-c970-45f2-a173-08dcf4a6527c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+yzuM4q671pT7jNPb9kHaBhDr+aOVSbIi95WeN13/75jNItC5Wd8d4wjJkYP?=
 =?us-ascii?Q?j3CrYM291L+F6uYmM1aiUifwdhBhJwjb9JEWpJsgEGYhdMf3l4Y4T/CCbCd7?=
 =?us-ascii?Q?8ynwEjBkGXl+aaAmG10TJ6q8c6sS1z8uFBuns25nRvWh/y6Ri0wSOevyIKtB?=
 =?us-ascii?Q?xc2tLRLj8EKB53kENWzdXAPAxxvDuJ6xcPNKmDqemRkHx8YwMpwktgCpPQX1?=
 =?us-ascii?Q?OYkxRcuy6jQ+/Obcf0Fne2oqX18VIVAKZEME+cc60IhY9qK7qZugC3IcOXQD?=
 =?us-ascii?Q?gnTQiCCPQac2QD987lFl+yitYEY/WVAPqI+4wbpjKdXCEavz136szYq2M2h7?=
 =?us-ascii?Q?Fe4EWhaWRKCAUZkzrd247dD+VQmYAO3D2K5hO9mdvLSBg9X7wDI5PaguqRhj?=
 =?us-ascii?Q?/RyZSjbXFGuzgiSsBvJDutlSNb++jVDV28rG+7UjjdJzhlBItCqW0u/j1T5r?=
 =?us-ascii?Q?CajjAoXlyf9QaFKT/eiw37B7RWllu2rEuPmagOCik00NGAOYvuz3oGQfkmzY?=
 =?us-ascii?Q?I/oFpcazNEBA0sYJVW1LuvhOSQYCQYUDsgcoopQTn10KWRQxSRqQojZDghUq?=
 =?us-ascii?Q?QedJW5EZpavJBBvalLW12xuKJQD3xfJJql2IrlSEHElO4R80YZg9bauJOMSB?=
 =?us-ascii?Q?nYKyllm6QwbYOpBq6SSlCV4k1X9/COOBj3eFL4FUUWbLh76g6eV3rw0+1bNf?=
 =?us-ascii?Q?YF7kCIdI6ttBZPjnaKxWftq9sZgupU80i56MRz60tlc8ksnvaxZglEEOcSVV?=
 =?us-ascii?Q?QHFvjwEjTI0Ug36nKnZKPnenD24NnWccFjXs/ClJ5Tl8VYLvbeD9BzR2W2S0?=
 =?us-ascii?Q?5XJWp6QIwrwJjwwBZjKk13dZXsEnJf+CSSOn34UyXO6ji4qURCPG9khsvslU?=
 =?us-ascii?Q?Ycq/BudosQtJsyPLQ4fmX+czDvH7Xb8yFXcpTnBwEP3rFG8jF4YYdas+3lxl?=
 =?us-ascii?Q?H5rTvhgAujwNwFJvv8xzPeKuodgVV7mFjhSaoeHc6ZllWPLKdkyeW4zDAJka?=
 =?us-ascii?Q?1JYO4vwAQ1BwzkviuC9NqNdLbQWAUI0d4+8R4YsL01frkoRSvU4tvWQRiffH?=
 =?us-ascii?Q?HhGABaiP7KsFyeNHdo0ZLBfkAPYKD3y8y2/PS68l08PvVnlfqKyx/guSRZAS?=
 =?us-ascii?Q?DPNNyz2nlTkG+rABLa7KdxtU6l6t27SyfzOrpIPyetjd+Ha9J8fjxqgVHjDA?=
 =?us-ascii?Q?JUKGTvJHqqGzpfwDo+i5/sc+849ygdRTI1S12oeFitcC/Z2z+WQDtnS6oDz9?=
 =?us-ascii?Q?3wSrNsHRzJFup3Fk0tYavEddCM5JbFsnMdV3MWGWBqZ6Y1km++X9AQmxtfzZ?=
 =?us-ascii?Q?gysJ58aonWCEYZDaFvKTLAgpC6PBPSWXxQKMIqy9eTefuXa5mThVaiZaO4zL?=
 =?us-ascii?Q?OdRKa8LbMUhgt1vsDaW7cjJsQfSORyVfzclDV2MnWkJsKb7VUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 03:37:16.4947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 302e74dd-c970-45f2-a173-08dcf4a6527c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9515

On Mon, Oct 21, 2024 at 05:20:10PM -0700, Nicolin Chen wrote:
>  struct iommufd_viommu_ops {
> +       struct iommufd_vdevice *(*vdevice_alloc)(struct iommufd_viommu *viommu,
> +                                                struct device *dev, u64 id);
> +       void (*vdevice_free)(struct iommufd_vdevice *vdev);
...
> +#define iommufd_vdevice_alloc(ictx, drv_struct, member)                        \
> +       ({                                                                     \
> +               static_assert(                                                 \
> +                       __same_type(struct iommufd_vdevice,                    \
> +                                   ((struct drv_struct *)NULL)->member));     \
> +               static_assert(offsetof(struct drv_struct, member.obj) == 0);   \
> +               container_of(_iommufd_object_alloc(ictx,                       \
> +                                                  sizeof(struct drv_struct),  \
> +                                                  IOMMUFD_OBJ_VDEVICE),       \
> +                            struct drv_struct, member.obj);                   \
> +       })

Per discussion in vIRQ series [1], we might not need to expose
struct iommufd_vdevice. So, dropping most of the changes here,
and moving iommufd_device to the private header.

[1] https://lore.kernel.org/linux-iommu/ZxlGfgfwrGZGIbeF@Asurada-Nvidia/

Nicolin

