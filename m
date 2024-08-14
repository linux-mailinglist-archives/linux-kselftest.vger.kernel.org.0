Return-Path: <linux-kselftest+bounces-15341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2319520B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 19:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628561F2298A
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E491A1BB6B8;
	Wed, 14 Aug 2024 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TEKAGWit"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E61B9B50;
	Wed, 14 Aug 2024 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655394; cv=fail; b=KQPtcrlzuvN28h3irdpk4bOYhWzlum7nsD3d3qDAzkOJijhfRg3YhkNZWgvfzpDk+G0LwoIGm2jbfSl1OZZYdeDnWBPf800xi7nHCoMTwQqs4mSMIdnBxnD9QB98wAikz/CPsqmvUqACf71I/ijGPiQvjTYmO05eXtiTHOrphDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655394; c=relaxed/simple;
	bh=rd0WURGF+j2Dxrgt1zseaDdB2IM2xGpC5bNkKujYUdc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCBOEOfF2hMvKyJPZWpq4+SkVLe4BaanukAHPtbkNbW0bFRGWLYwBjzMDlxQb8TWyrRcSfwrNa5n2buWbdSc0q880aNkBHYC+NI3IcKfJlEuFO4rqvJuvBjtW/it0MlQuNfPD/mAviPK/c7h8Oy8kwrYi8uzH/fWU159qfOLjF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TEKAGWit; arc=fail smtp.client-ip=40.107.102.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQHj3S0NZQaNOhmUFkuo1edSiEjYACQlpqO5O276m2CVlhybvTdETp6fKUBbpykt/ys/cnmmheKHXhE3s3a8OkDFX1R94PyxGTrNg4fyS9+2RFtf8TKKMQ1a4tSxVsvcwVDO2cWTmLpqMMc02FKUd4jOwTR9u5kjXZB9Z5d8wilKTE0tVd1wfIYLjEyQEBXHmPDd+PL6epiynb76oVy7jLhvC/hH+2u7jlJtMZLzBK8PmvkxgARJto7v5CsF1PGfi1ilGs6mD27csf5SXqFFUXWOKsKfWk3FlLbE5QTUr36kjqxWAnXT+sASQbWJmPAyvYMhHKHWi5qIzpLRuUvMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UD9xFFCT8bY4ME9Dcgqr7/VW5znu4rIB6+pO4Hzkz1o=;
 b=Bk2aA7/udxUmcRvFantq9PumQgOZcauUky33XxsIyNuvi5VZGyGTzZiuLHA6KKbg3QNGptWrIQieJKOwR3S68O6tQk0Z1OCjKc9oj1e+JZX2cUgpyL+FwuxdeisLL2yHnU6jKljNxozBroNEqZyANGDM2zZ09obLIQwsI5mylox1+XWiZHYVOie8D/bks/UuAi/5VVf0clZwibeovwAhSpczgVWrX1C8pShMZJQ+qTj1LE4FuWUEXDS6rRXho0o/israqSm/ebOBWYbqoCygBF2Tr5YuOnNG4E4tZzUox0WyHGinGf3uSd5JwGmuvTURsut+NGRm6rd0zED2rL86gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UD9xFFCT8bY4ME9Dcgqr7/VW5znu4rIB6+pO4Hzkz1o=;
 b=TEKAGWit2HKWXqaHKGocPu7ug96yGhFrwRfy4QaBwFwLYV/dTA3agqCUPaSJnkuPt7scKMNy/HniGe5t1Ahp981xCoFmPfKxgxWOVOjJXLybr7tjQQqff5gZHc28uAINfHBNC+n8XRwpKT3FoTyY+8g19QC+oTuBuysEJ67un+Rjs08n2itKC+4AkPF+HDTGvGcDEeYdl4EU+is5OCi2FKQ+F8k2ZaOVIylYC/TohwD2OOfCwIvCcJbSFE3zhMc5fVMcUoBl87asDqYyyqg1lYjP1cVyYrr0WwHmmEsFYf81/ZJvVRDmzcM0j6XuORKsyUhITkk4hB1HliQObSLXHg==
Received: from BN0PR04CA0192.namprd04.prod.outlook.com (2603:10b6:408:e9::17)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Wed, 14 Aug
 2024 17:09:49 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::71) by BN0PR04CA0192.outlook.office365.com
 (2603:10b6:408:e9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Wed, 14 Aug 2024 17:09:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 17:09:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 10:09:25 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 10:09:24 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 14 Aug 2024 10:09:23 -0700
Date: Wed, 14 Aug 2024 10:09:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 05/16] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <Zrzkwu7srmLTch+a@Asurada-Nvidia>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <e35a24d4337b985aabbcfe7857cac2186d4f61e9.1723061378.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e35a24d4337b985aabbcfe7857cac2186d4f61e9.1723061378.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc4c600-dfb6-4e98-b7a2-08dcbc83e7c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dENog2mSWI6j/sfkQ3ixoN2Sw6To8U6FUOp9JCjuVkXgxBPpG3Y7I+4J+t1S?=
 =?us-ascii?Q?FiQ735w4a/xa22HeCfmovdMa16zXhAfMlOdnLkn+XaEfBw9HK/S8xnquFCWw?=
 =?us-ascii?Q?1ydB38OPcalaxOa4vrwoVISL2Tm2yHf9caiD1E1Y7LYPixV9m9JjbqMA3deH?=
 =?us-ascii?Q?pE357S1FO773sOt41160XCP/IGZOOpMyc4breqgdBjYf8aS+5OUXgbESONo+?=
 =?us-ascii?Q?7NjqndnRq/Ugc8IAsHhntUaExF8clqmqo8E4jvD7cJxpS2NDQ8Kpu8UwmspJ?=
 =?us-ascii?Q?2QfGQg89bN2YkcfOqJ2TCfCAiNnsiX5Yq+pcVnXcc+MeL4nHi5kCc+35ZPkk?=
 =?us-ascii?Q?Zh9Mi6AfF47GyhHFXRh07kY/aP0K11ZiIMK2Sw3+leX2YfyttSyvC4r9ZRzO?=
 =?us-ascii?Q?0aXPj9m/40HPotP6xw7XhFSLQgSPr8in5MZHS5LMEArg34ZMvc6SjW89VwzN?=
 =?us-ascii?Q?5eZopBRTTaeqjHmf9yeVbyFVVUlidrxH8rdAUFvN8WdOSwtA7cyXPOusXONY?=
 =?us-ascii?Q?+gpXzZJ9Yh/JdRIEYUANQxrhY9rIru+xUqn+k5pwUEQRi44ZgdHivwcZQZgD?=
 =?us-ascii?Q?XLeNhFN/gXy2DZ1xWMZQ0aZrpdN7/pbJJLo64pb7zdN0x3NOa2WZpThP24sy?=
 =?us-ascii?Q?O357LhftuyoJvZnt+xDthXwT+wc4ozf6OMB+dm79u7WecUdFD0o1D6aWIJ73?=
 =?us-ascii?Q?eHKy34c0Zc3xTg1ZlS6C/7NZ2PiqcGL+YHI9Ee5NXJTCzXrc/XtY0VjvtIw0?=
 =?us-ascii?Q?3Tvhimr3/rhB2g1j+hUfd4SKobCfqLEFdJ3226ZfUEqXlXOj8nhimis+fzdA?=
 =?us-ascii?Q?AVu7A594P6iVlbBGHjVdrnT9/isfVRtymofXke+e8buT5tVr5uYaSMyS1eK7?=
 =?us-ascii?Q?TNRrYOjAyIOibbFXCugdCM0pmySmYsqU8Qp8/nzSKJlQH50qaoa6nt0VmL79?=
 =?us-ascii?Q?SMA7e7buppL0CwjHPKmmi7bVowRo/g9+UXguH5e1IDYfiIqQ6pqhduOljD9w?=
 =?us-ascii?Q?F9ciqSutMnt41RkeHToIjIV8xuKm4LktKJBQmWQ372aE1eHPsCZmWO/Zwp9Y?=
 =?us-ascii?Q?f/wTzOnlWzlDYjbku2TMjxfaBgEPXAscRfLmTkxHSAVFuyjPEaim+tc7jHNm?=
 =?us-ascii?Q?JlSUPao1oNWj7AntyAvdHLh7mOnrhUhgX5LpMdOQborA1gR6HboPpvD6ZDwy?=
 =?us-ascii?Q?PuNs3VgTmPCQ08pz0ELfv5/juj+rauuQyJF1r0QoHsTcDdLR7O8r0IXPK5zB?=
 =?us-ascii?Q?bJZ2RnN6gacbB5mivU2NxdTWmQTMXVBJFo7cTRQoiTBTSYomWAYCAoBQ7Dc8?=
 =?us-ascii?Q?sTIaSJX3mpbtrwSk2qL4xGdopXjlXzqg4BcXtQ+Vym7Gt2KSdcZ6H+st304h?=
 =?us-ascii?Q?kRYf8+N8LdAHHFi3Dg+bXgW27JT5YqQgWTT+NwFicPfojryn9s09A/07BL8g?=
 =?us-ascii?Q?X4T7xvvOTpbgEpw8lZoOFofde8GuOhVz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 17:09:49.2797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc4c600-dfb6-4e98-b7a2-08dcbc83e7c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452

On Wed, Aug 07, 2024 at 01:10:46PM -0700, Nicolin Chen wrote:
> @@ -135,7 +135,14 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>  {
>         struct iommufd_device *idev =
>                 container_of(obj, struct iommufd_device, obj);
> +       struct iommufd_vdev_id *vdev_id, *curr;
> 
> +       list_for_each_entry(vdev_id, &idev->vdev_id_list, idev_item) {
> +               curr = xa_cmpxchg(&vdev_id->viommu->vdev_ids, vdev_id->vdev_id,
> +                                 vdev_id, NULL, GFP_KERNEL);
> +               WARN_ON(curr != vdev_id);
> +               kfree(vdev_id);
> +       }

Kevin already pointed out previously during the RFC review that
we probably should do one vdev_id per idev. And Jason expressed
okay to either way. I didn't plan to change this part until this
week for the VIRQ series.

My rethinking is that an idev is attached to one (and only one)
nested HWPT. The nested HWPT is associated to one (and only one)
VIOMMU object. So, it's unlikely we can a second vdev_id, i.e.
idev->vdev_id is enough.

This helps us to build a device-based virq report function:
+void iommufd_device_report_virq(struct device *dev, unsigned int data_type,
+                               void *data_ptr, size_t data_len);

I built a link from device to viommu reusing Baolu's work:
struct device -> struct iommu_group -> struct iommu_attach_handle
-> struct iommufd_attach_handle -> struct iommufd_device (idev)
-> struct iommufd_vdev_id (idev->vdev_id)

The vdev_id struct holds viommu and virtual ID, so allowing us
to add another two helpers:
+struct iommufd_viommu *iommufd_device_get_viommu(struct device *dev);
+u64 iommufd_device_get_virtual_id(struct device *dev);

A driver that reports event/irq per device can use these helpers
to report virq via the core-managed VIOMMU object. (If a driver
has some non-per-device type of IRQs, it would have to allocate
a driver-managed VIOMMU object instead.)

I have both a revised VIOMMU series and a new VIRQ series ready.
Will send in the following days after some testing/polishing.

Thanks
Nicolin

