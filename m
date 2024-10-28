Return-Path: <linux-kselftest+bounces-20818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC409B3408
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 15:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C16E2B22E06
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 14:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729131DDC3C;
	Mon, 28 Oct 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mpCpxaGV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DB91D2B24;
	Mon, 28 Oct 2024 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127151; cv=fail; b=aIItsQxXbeEKSXUSTyTu3jHnZzchI9Eq+47uzQqYV6FZJ2GttuLxkkwJBvNx1XtZS4pG4XqeUPIRDF+lOloe8Ilsi8hWExNVBlu/+cmd62YVP+R1Xz1gWajI826mTQRGAy1tczAEuB3R2U4G91DrRAFq3F6RpWkTRmkp5Wi+Z54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127151; c=relaxed/simple;
	bh=f5MF66WtVD9kK+0wPpwkdAnaSutI+UHQw1WThKHSgn4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhdzX1hVjMj+UjHPWO2ici+Xybc0R+qDM0yV527phhz8I7nB5be75LuShdjuZx4MY+t805Hm7xichF8srlGXdEZCoaFKzEaD4qdiD/VsSEODUrIG2QlDeU98w4yZzSqPq1xdI3EWvKa0KST5QpxSQ8BGvMQ39rtcwSt43k87tOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mpCpxaGV; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdTXZ8C/f0w9tcYqU1etwXQ6OxcDfkEo5n/jK1T4WGEgUnQBtAMQfy1CLr7CDG8l2ZQnjflAYP7/GAmwSJVhYujf5/0qhwWoknrViCZlGjVNdtPW0IpCsczgqlPgDTTHo0qSxy1upNq/Or56lSO+0QHALjqwECz39TuqnbCMGi5sw3OFatK+RWceyjQ4+mEYEb+7MK9s39RXBCQ53OyLWFhe9KlMqwH1phQ2saNMQrB39DaSIPH7qkbqd2/3evXMVAq/qpVKDtKMRfOYB3n9eZY7jguamm1O4pWLlu2mYJJo1h91KKe0o0uMmFX6qHhQ2DlACe49uRSrXYeBXqvYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pP09e11POMbD6Q/muDfAQ0bPDCim/PA3ble5fX72UHw=;
 b=tBptN/YUrzTZEWh+SRSAEFVNR678xsmtulQ9HvEJlRoG9HYQ1rn7or2YvbpnfbuBqtXyQoIQrzJriZpbFFHh078kM72G4JjSwTDCEbzyFtiQXtfA+F/hm7RVFx2YLJ6Um/7UTd2EiHcoNz3EwunVgszYGjoJy4xWmtEHxa5VUnKrXNh402DuGsN9qdk34HCRu49NUZNY7Ek+vx2D6a3P9TTkjCRwdLPTaULBXCFKgklGULS2JYA/C8VDm25CKUV6qznyXczfo/YNJX7oSXmfwVGLfMeROteY/t4MvlKBtL7dpQ2cFWE+GXf6bgrsG5egTT3cnCgZMVXOmedNe+JbXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pP09e11POMbD6Q/muDfAQ0bPDCim/PA3ble5fX72UHw=;
 b=mpCpxaGVIc0JnoAMUMgm0vRW7R94us0XM1JItnPa/YwwdxQpcv8CEx0rtxGL/hvNRQLwuMqegCNZP+rCJPtwVO3nrz6xhQjnoyu+g8ZIwJsik7JC5VN94UAe3KX50HVLapiJnPco5Bmpp+soY1pQBNQBn/UqW1v+Raf5Nfxoj4kbwJTPzjyS9XADZGe6c/2Jfx2/JrvW0Y8V121UWrNF1hF00xL0IHuVOsxtB7sj60Vcsowb1XxPi6bW4fGMmHgcUh38wxdn6jL59E4cHI1HMT0SSS6SoJnWcnWIJBmCu45LucC0m2jQeC02WJUV9rk09Ngmhurah5366PBCFTbLcg==
Received: from MW4PR04CA0041.namprd04.prod.outlook.com (2603:10b6:303:6a::16)
 by SJ1PR12MB6049.namprd12.prod.outlook.com (2603:10b6:a03:48c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 14:52:24 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:303:6a:cafe::49) by MW4PR04CA0041.outlook.office365.com
 (2603:10b6:303:6a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 14:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 14:52:23 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Oct
 2024 07:52:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 28 Oct 2024 07:52:13 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 28 Oct 2024 07:52:12 -0700
Date: Mon, 28 Oct 2024 07:52:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Zhangfei Gao <zhangfei.gao@linaro.org>, <kevin.tian@intel.com>,
	<will@kernel.org>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v5 06/13] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Message-ID: <Zx+lGr9iD4DSkc8I@Asurada-Nvidia>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <4f5ed9d75c23a503ffe672a85cf9010569652794.1729897352.git.nicolinc@nvidia.com>
 <CABQgh9Gkt5tsw+wr_=WeA+m=Kz2xY5Z7aSBNhHCvBG2r=7O3TQ@mail.gmail.com>
 <20241028130309.GP6956@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241028130309.GP6956@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|SJ1PR12MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: b9bc5a34-9b2c-4fd0-5084-08dcf7602213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DegHqCV376zSliwaKbESmpoVePCAhdtrydPDcXcO+0oOtf+4MtSez0Pd5a/O?=
 =?us-ascii?Q?ds6030i/WuoWoC6DwLAR5uEfvtc0Ondp/pn5L4jFynXrLgDP4WKwxVds3LKZ?=
 =?us-ascii?Q?Y4Q4GpIcpdfmnhqGM+ffZEsYXrOpYtnDsJN/vxxREccGGk+WE3YAQ0SlW3Dl?=
 =?us-ascii?Q?piSlwN2a3MQMFvRb3gz97dLmxgwKuoKfrH0NPyobLQtdm9tofD1hevKx+32c?=
 =?us-ascii?Q?iI+2Ukcp6AQehRRwuRohXT7EVqbmjbMMEY4U0zDWYMtseS/a+H5fZQtB3o/k?=
 =?us-ascii?Q?56l92t9FN+wyXgYrwuvvS9r4ybW2f4g+g2a2tXj2Oo4EgacoltABLvBebuQc?=
 =?us-ascii?Q?E0Ncry9JRWQSt3dc0CzgFsQWSAD9xypCvxhwdGniLWgz27ZI7a/SD5wpcvcQ?=
 =?us-ascii?Q?h+0iV28iG4fPy8T9GpT/kZNWWJGwzo7J3ka5wnEnu9Yf3XlU8GjKmSZXCm7r?=
 =?us-ascii?Q?IK2osa19JZxgJXfqCEqB2WdH3iP9BXWkg579WA1yb+6wocJwW0p1b8ENIyBI?=
 =?us-ascii?Q?ElctyqKwTL/wdNOeOu5nX6i11C/cLFkzdelFj0dQHV1TkT/HNR8pwynUxrTj?=
 =?us-ascii?Q?PsTW3wYh+IxvXKQgBGtrjmc3hXLzQnzch728evKYgnrvMDuRbw82d1BuLi/Z?=
 =?us-ascii?Q?AgbhwPe99AAjLBjD/pSY2Q2+7JGGmDZq72uGfezrpWbVuz33G9BOpwJTtCh+?=
 =?us-ascii?Q?iQz3zf125wLyEpnuGpLCYB51n5b88njayEzasa/guRMPz3DqWyUeAb/N4Iu1?=
 =?us-ascii?Q?CDjuw1JoHJNYVfkReZDv3ixY60K8jcRasfA5FKPyBhgE685EVh2JbnN6GnfY?=
 =?us-ascii?Q?6sPtGrSxx/zKSNMokVeWqWx2rSXXGACDHxCp4z7JIa1X7BzfxwzUkzRclusk?=
 =?us-ascii?Q?J+amfnaLK7BWu9crCvNLbKuuGhAL8wfgqegYmdCGfqcRVe0wka98i0NH3Bq0?=
 =?us-ascii?Q?gSbL5IzDHHmEIPM0wWGVKGZ14SKGuA8zyuL+qqVvY8QRS+pZ648TToS9DKEy?=
 =?us-ascii?Q?L3+JtNkaCoQ1Uml68BR6t2SAVtNihw9wioSYIAArQBv8+rO+pmHEqLpLlnJ8?=
 =?us-ascii?Q?4U54N9geax3hzi7BTWooNBrsa3ciTxt3MqlvfHti3mDmf38juNlb0yBquEiS?=
 =?us-ascii?Q?DXHDMAi+67b2TCzyxI9dMGRnQTMchZKE9bRpiWkf5dh/P4O0BKSRnrC+AxdZ?=
 =?us-ascii?Q?xbiIzwQ0qfWxactu15RmxXmO7yvuKRQGk4dJcCUQ5zJhsqP635aTbO2XQuLk?=
 =?us-ascii?Q?PO+NUGWk+w0TgHRPrC+tQkQjsgHoUS5OTG8N9tsHcnxGQu322R70EuG8BODd?=
 =?us-ascii?Q?BQGFeYhJQ01nSaxk1B9Qb+QN0lm40WcHU6l3niFSYNKUDgTOAwwXwV5JT7VG?=
 =?us-ascii?Q?NbvY+rF26xBB0ytmi6SnOyMeAYEyA6qLLR1fkSA9hCf2ipeeig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:52:23.8505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bc5a34-9b2c-4fd0-5084-08dcf7602213
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6049

On Mon, Oct 28, 2024 at 10:03:09AM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 28, 2024 at 11:24:10AM +0800, Zhangfei Gao wrote:
> 
> > > +/**
> > > + * iommufd_viommu_alloc_hwpt_nested() - Get a hwpt_nested for a vIOMMU
> > > + * @viommu: vIOMMU ojbect to associate the hwpt_nested/domain with
> > > + * @user_data: user_data pointer. Must be valid
> > > + *
> > > + * Allocate a new IOMMU_DOMAIN_NESTED for a vIOMMU and return it as a NESTED
> > > + * hw_pagetable.
> > > + */
> > > +static struct iommufd_hwpt_nested *
> > > +iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
> > > +                                const struct iommu_user_data *user_data)
> > > +{
> > > +       struct iommufd_hwpt_nested *hwpt_nested;
> > > +       struct iommufd_hw_pagetable *hwpt;
> > > +       int rc;
> > > +
> > > +       if (flags)
> > > +               return ERR_PTR(-EOPNOTSUPP);
> > 
> > This check should be removed.
> > 
> > When a user page fault is required, IOMMU_HWPT_FAULT_ID_VALID is set.
> > if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
> 
> It can't just be removed..
> 
> I suspect that IOMMU_HWPT_FAULT_ID_VALID should not be set on the
> nested domain but on the parent?

By giving another look,

In iommufd_hwpt_paging_alloc(), we reject IOMMU_HWPT_FAULT_ID_VALID:
	const u32 valid_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
				IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
	...
	if (flags & ~valid_flags)
		return ERR_PTR(-EOPNOTSUPP);

In iommufd_hwpt_nested_alloc(), we mask the flag away:
	if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) ||
	    !user_data->len || !ops->domain_alloc_user)
		return ERR_PTR(-EOPNOTSUPP);
	...
	hwpt->domain = ops->domain_alloc_user(idev->dev,
					      flags & ~IOMMU_HWPT_FAULT_ID_VALID,
					      parent->common.domain, user_data);

Then, in the common function it has a section of
	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
	...

It seems that this IOMMU_HWPT_FAULT_ID_VALID is for nested domains?

So, aligning with that, here we need:
	if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) || !user_data->len)
		return ERR_PTR(-EOPNOTSUPP);

And looks like we don't have some detailed documentation w.r.t.
this flag and Fault Queue. We'd likely need to update the uAPI
doc, prior to (or along with) the Part-3 vIRQ series.

Thanks
Nicolin

