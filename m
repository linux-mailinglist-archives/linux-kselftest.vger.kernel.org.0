Return-Path: <linux-kselftest+bounces-36853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180A1AFF137
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C6B567D50
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 18:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD3F23BCF2;
	Wed,  9 Jul 2025 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hs6yVIr3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2738D22256F;
	Wed,  9 Jul 2025 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087340; cv=fail; b=EQ/CLwFHnJAVz96Cz2kLgZk7MrUt4V8HyU2iw5DUVS6zFCjeR9gx9waZagvOV+NyitmAfixakw8+yKnnnjeRzfuGIxWmDNHrxysueE8zvLQ7dcGX4YWqOMtidTg7I0glyillCD6+W5X+J7XyufPKLxdMwtrVeGHXSBqSj2LaDXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087340; c=relaxed/simple;
	bh=tbCciAMPckCi0I3i/czCwtGQlXTIy8v4jE8edl53ZdQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG7Jw48PxQP0bUjCC3F4pFWs1OwZIQBl7ZRv3iiHAKWtsceXZ77D0rwvhPgqs8gODUnqqRM4RL9lKSO2f2tU5nCfQm/sQ4aT93oCmbbvzlFy8SW1IrfHRO32quHq4eTizJug6DpWg+VQJmYyiLDEuU0UqPzuXqYZ4PoppvfLXZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hs6yVIr3; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvUbXwXowqAd5XJUC+Skokn5uQZnV4QDtV14v0iChA+QFrAHbXxasSq2e8qAYrKBkDrl9AwSbTgkmvj0I+coF9Pm9XIMwBxz1I7YqQ4dGXyiXY4ctnw/ccdiK9+ofXV8sBL7/Jm4UVrT+WPVWNyEw7tGSsENYhIfdkc1peDt21WLqfrsFAWPgK0Zy8JfbdSnLTULkSmTYi6AU4boTA9ZIi3GVhuImNEbI4McX9iqi1rYQqSHi3G3GILbRluKyjOgNynWtl4Y5b3VhqY19kt0wPvmqIXbZsLAeM5sz6WEvfsKXlkV6nHzBQ84ZoH55HJWGWi62oFxU3T1KkFC469UiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UW/EqBnikuZrPbDGKrWFa/Cm1CNNxjLqc0Navg5SCKE=;
 b=MmCf8+HATLnTj7xwjVPXeb8ALiDsDLPtgCQdFChfIOE0VB2W09TSdxUHFbeHndFA4PJzhShsAr6FYdn1tLL9I4+O8yxWDZUE8aMLjNdbeg9e3eK+n5v7Hmd8mgGm4gtHpwl7LnDHKv98ME8N37c0R3q/6hYZwXCdujrLrO+JsooPcrzbYKZVJKpIvT2v7EPSCA2zKvck7Sp6QhZdDBUCmikJjHgJrhk/OR+QzCI/YuYnK4jictx9YExWvGwgo8klT8DtxT51LI7202P11rpj1pEaHnZaK0Q/4NvWpCzgsJjwoaw5GRMsM7xZRLqtDrFY0oje3isGl2mCepc0Y0L7nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UW/EqBnikuZrPbDGKrWFa/Cm1CNNxjLqc0Navg5SCKE=;
 b=Hs6yVIr3giOkIcj8DGdwWZgIeCQtV5olOnyQEHGfmKoTrnah8DXi+AIE3L2Jl+4ug7hirUsgeuaAVFEJdSimbGAfX/WQciK6YEd5JkrE8cxBKqCT9mZ/qKB5pi916IvjxQr1L/fyInwWKaRg/koYKVe4ARzK8ymwSnLZ0a0WmhSJG44eZ4pg2OuAmuLWo5ECD+r2ZDMGdd/8DSGZFpspU7mQlIOzlyLiA3gjKpPsTiUqWLywg2q80rVGOLx1O6Gm9KHWHHCh0+BAA58891/DmdFCF2dWR0hHqmc64N+V/fgz+neBV3VJNpwoy5Qz+6zMIrpYecfYb0oMQZscANfZjg==
Received: from BY5PR16CA0027.namprd16.prod.outlook.com (2603:10b6:a03:1a0::40)
 by PH8PR12MB6985.namprd12.prod.outlook.com (2603:10b6:510:1bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 9 Jul
 2025 18:55:33 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::3d) by BY5PR16CA0027.outlook.office365.com
 (2603:10b6:a03:1a0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Wed,
 9 Jul 2025 18:55:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 18:55:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 11:55:23 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Jul 2025 11:55:22 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 11:55:21 -0700
Date: Wed, 9 Jul 2025 11:55:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v8 14/29] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <aG67GDY97U8T6kuD@Asurada-Nvidia>
References: <cover.1751677708.git.nicolinc@nvidia.com>
 <49a93d92ce657cf6a0d588d2b31ad3600ace21f7.1751677708.git.nicolinc@nvidia.com>
 <20250709170904.GG1599700@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250709170904.GG1599700@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|PH8PR12MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: d000da8e-7d78-46f1-a1f5-08ddbf1a2ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UN98EhLKckUlMt40PlMe5saHyhsP6rlOTNyTy0DSSk5YNqgoZSWnOMWpr8lw?=
 =?us-ascii?Q?wAXSgPIT7Jd+o7RgTvrmfJoG9sMXe8QZVj8oEtIVou1BCu1BBXgiT3T3C4/b?=
 =?us-ascii?Q?gO3tckKIxwIAek9TMm/aBozah87dsmbmefVUb7DSuA00RYZg0NNNcOgq8rMF?=
 =?us-ascii?Q?SjSARdR4KZVz7IqbL/iMvR4NsBn86QgUS8d99pHYXTaAenwgds+WityhtoD8?=
 =?us-ascii?Q?gal/X+Oz0ElCPixPKNL9ZJNv/GB3pECf9byV5jGjQEgAPAiBdAKCYBq46VDr?=
 =?us-ascii?Q?3uoLbM4vXscR+9/uE3CjRbmaVI8Glm4isIzSurjS4Ut+ShPck+txTMiE9Zd9?=
 =?us-ascii?Q?SOZn4DXZiOYLvT8xoqC/Oby8EIUqB19BpLdZhhcVKeRXrYewYTusluE3IbQD?=
 =?us-ascii?Q?lXYPFI57qurNsD1HaD5LUIweiMr8+ynFchGIXFFOvQuEkQIGhF3KwxDrXl67?=
 =?us-ascii?Q?ZAHVjWu5fxq5GBaN2IOhYPmzXlvlAidAQkRpA6GZaFimRoovrWMOuK1gua/L?=
 =?us-ascii?Q?h2ns1B+IQ9ltVMD7dZR6u0TCiXjleGCiCo1YKaDmH7lII8lVjsdAoZQOghNo?=
 =?us-ascii?Q?oCgSmZCxtjIZctDqneaG4+qiLkqjGMGlZNaStBBvBPVSHBspjXta+yvfVMJS?=
 =?us-ascii?Q?gpk+Z4snBkGpsjAiwLLZIAR3sg3X2OzKjhJohfQ+84l6CTulrTZ5OrwKOgen?=
 =?us-ascii?Q?qyKLf5RTAKqd+pX8owopcNyAVjfgnm1fdTsMh1eM/5o5ChymZ+/shyh9Ezkg?=
 =?us-ascii?Q?q6ROpFCfBl6hlB7yuKM01OTs8eicozg7TLYK8m0BWi7Oen1cp1tX31yAp7YD?=
 =?us-ascii?Q?LqRKsNJ5CYG3hiQPH5PUXtbbGQKsC+YM74vh+rcgN040Qd4q36WBEEZFg0/u?=
 =?us-ascii?Q?off44wGriFJIaWfoA8HqBmm3edQO2D0+4x47GK9yQ8t9cPt6zH6eUvsFBbt4?=
 =?us-ascii?Q?aDS525ouAKqYAupYEzgHUga1Qc0LhcH3WiO3VoJAHOq/ggcK7gGXIKxCyurl?=
 =?us-ascii?Q?tAcERnCon98lpfIvr1S+r5AqgyOeKCAwpUEB6efohXBRuV9usBMrUFLTv/Yv?=
 =?us-ascii?Q?3sUvjHEgSCUXhGd/XwsiTyWsYldfzfJY8EruVtz4NLdHbkHH1MBDRNV8UrFZ?=
 =?us-ascii?Q?tW3ayVOQVsRB/YfL94Z8KO2sOzYmfJQPVczv+VcX+BPlWVuodxLdh7eKIgu4?=
 =?us-ascii?Q?Fk7yUrKmBmwjX/h/REYnx1X+19Em/BPnCphxSwzcos2d/ocrIUnZZMaNTAJb?=
 =?us-ascii?Q?wCi2tpy5OVDMw0PqwkX172UdrKQCJZW9ggX1rb/kmyYkl+wb2Gdu2fXcNJ36?=
 =?us-ascii?Q?03oRrEKbiEimaWtTD3peMIF10VRMSFp+BBMh2zxXxtLSyCkvdMwZc3pRK4AE?=
 =?us-ascii?Q?gC22askic9SsgTl12/aU+La3bHInDU8QdMHrsePYu+pfiLogfA+s55PL0ipz?=
 =?us-ascii?Q?wfX7IJ/i9m1GU9lfWDud23qWuvZPZMeOgMQYgcWibr1fQMXfoOhh5lDBD1k/?=
 =?us-ascii?Q?CNyJNyzuHJAkk3TXRced1i2be+GLj/mPzx5z?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 18:55:33.1639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d000da8e-7d78-46f1-a1f5-08ddbf1a2ed0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985

On Wed, Jul 09, 2025 at 02:09:04PM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 04, 2025 at 06:13:30PM -0700, Nicolin Chen wrote:
> > +static struct iommufd_access *
> > +iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
> > +			    struct iommufd_viommu *viommu, phys_addr_t *base_pa)
> > +{
> > +	struct iommufd_access *access;
> > +	struct page **pages;
> > +	size_t max_npages;
> > +	size_t length;
> > +	u64 offset;
> > +	size_t i;
> > +	int rc;
> > +
> > +	offset =
> > +		cmd->nesting_parent_iova - PAGE_ALIGN(cmd->nesting_parent_iova);
> 
> PAGE_ALIGN is ALIGN UP, that is the wrong direction?
> 
> It is just:
> 
>       offset = cmd->nesting_parent_iova % PAGE_SIZE;
> 
> And this is missing:
> 
> 	*base_pa = (page_to_pfn(pages[0]) << PAGE_SHIFT) + offset;
> 
> ??

Yes, my bad. And I realized that all my testings are page aligned.
Maybe we could add an IOMMU_TEST_OP_HW_QUEUE_CHECK_ADDR..

Thanks
Nicolin

