Return-Path: <linux-kselftest+bounces-20854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B06729B3C7B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 22:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD081F22955
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 21:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AC51E1043;
	Mon, 28 Oct 2024 21:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UseCCBb3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C254018FC75;
	Mon, 28 Oct 2024 21:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730149736; cv=fail; b=fcTLdlUeRHvzsv+F8q2bg7C+NuCfTOeCPhShrSloQB6sZTLa3+sFJiunJoa3yT0wFI6TdjMpKT0U4N1oeYe4K+3w45LcTpL4N4FLIiJNwN780bCHm98hALTTqVa0UnE7Q8diGsgRr/oaWr60WTZgiPHkvPcwegVuoByBLullxHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730149736; c=relaxed/simple;
	bh=h3Ek8FSN8kh8AqcTPRFmJujaiabhLKgKFFL3wZtylQw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpOydMMxswv5yHhJG042RCKLXZDYkO50xeDruNb0SMdkU10Al6zoxuRUFIS5pMu9MX+iRs7hxowVqfsmophjj+9g1fgzUiMgCL4XM2flybhSP5fxr008kBtoqwB9LOakB+dyyfOvSJ4ZhY7sUgrtz4ZC3WQeie3ffjspfWXgRxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UseCCBb3; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIIRmxnipvJTmlFIBVFxbjSP8s1hGRi5a5GJJV16aV7Dic4EKJ/etU2GIIZnX2+gqIMzLLWu96qS+tMeTudbkllakmtcqz8KuJo9OLNgNLnDUyIVeLLMWtC1It2GK46X+JfP6xGCv6fM60hZF0t0RB8+I5DCRpMP/2AsdNccOp3N0ywcesbRFpLo+pZtcTw9TJR1FjrespKGyv2oidAjIDeoM0Osxu0eWvKalA7Cu/LOtSFVzsr3ckAzaFurgPP8ag3aG1fz2oohmZaYlMuSbbRXRrngT1bYivL9n9cbRAUZ7mDm9yZKm8RBU2Qqa4Nk2ehraS25MBFqG2yVTbQAPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/94DjP8AZN+nyxAsn4CFaOPl50B8/B4vzqoL8xHL1I=;
 b=GhlmGo1zABUSZy7qCK/7o347gIEwPqQBSKvsx8/IVz9QX4T/C3ow22+oSVuOJgvltj92iokmUYGztWHWtbpACqlY3xfHD4rUYJDabSkRqrKw1xc4xN4UTe6WL8gAEA+SStMOouJ7/W4DBW03S9bN+6f40JhQQI4Ah1S6lqOJ4UHU4H7BdbUq/KwV0nk5wZblYJPljMkq5rc6/gGA2LfVUsVqwMLHHwDkVb8gj9+T2ZwGgwGIKn7l7ODaPTZSPqnD0GGWK3BCPPkQ/Ff13OA7SI7mpyX3jnenlxY+IcmrVVBwlKg5dkyvLXD1LrYDKHvVE6NJWTVeLHSZWASTTgfXmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/94DjP8AZN+nyxAsn4CFaOPl50B8/B4vzqoL8xHL1I=;
 b=UseCCBb3Ynh/0a60uQYL41jI8CiYaAq/XNH+TqH5XAzOqFv3cyQxeSLGSRAO75uuSt9GtafIsousDLtltoudPIo5oQ/MJUC0JUwW95y2Tp+ka9xoWLCyOmg+2HFjCDczTQ5UP07lAarc8EcJvT/M5sIPnXylNXmFAFtuC1GVsLR5KqUuFV5zrrDThQIOyht1TsphiAVl0hptKw7S1OEgJ6aUngjGJvn9eS3yc7q1yQ84Gz16THgA4u7iG+vlhIDMFlcAda/5dOIqrD35DW5IQOXcFAumA4YlhdQxEA+zOY1QUFVgH9b9EKrd2764RoVSbredrRhAi5TO+0km5x46BQ==
Received: from MN2PR14CA0024.namprd14.prod.outlook.com (2603:10b6:208:23e::29)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 21:08:51 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::86) by MN2PR14CA0024.outlook.office365.com
 (2603:10b6:208:23e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 21:08:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 21:08:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Oct
 2024 14:08:26 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Oct
 2024 14:08:26 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 28 Oct 2024 14:08:24 -0700
Date: Mon, 28 Oct 2024 14:08:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: Zhangfei Gao <zhangfei.gao@linaro.org>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v5 06/13] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Message-ID: <Zx/9R5o59B2knsx6@Asurada-Nvidia>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <4f5ed9d75c23a503ffe672a85cf9010569652794.1729897352.git.nicolinc@nvidia.com>
 <CABQgh9Gkt5tsw+wr_=WeA+m=Kz2xY5Z7aSBNhHCvBG2r=7O3TQ@mail.gmail.com>
 <20241028130309.GP6956@nvidia.com>
 <Zx+lGr9iD4DSkc8I@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zx+lGr9iD4DSkc8I@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: e781456a-75ff-4c26-1f23-08dcf794b8f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DoJwqzvTgm2R8rlc3zAX8aGQGcr83niqJfAyedc4SaNz7L3tmPsoZ5dLgOR+?=
 =?us-ascii?Q?YxN5eAHAVeMCb8oK3knO7Axk7QXDCY67AX7jwQproCjXCbyDZFJgg+bnWOgc?=
 =?us-ascii?Q?kNa1szTERW7/WU+2bOjsJu26K64D7OuMszRiXOw4bcbsPjMeb9z/h6z/C6m9?=
 =?us-ascii?Q?/Qntgy4e++YRuLGYilMNFIqBPzYpYoXZAxbjW/kVvB9bK9aUuZrSUq13/xyu?=
 =?us-ascii?Q?lefUaqJVuO0RBAWHuEqWPcx4NXttIliW+ZWb//ClFCB2ZD9DZVbUg8VxVdxN?=
 =?us-ascii?Q?L+vUzCvgsJs9jMpwrg0HGN7WeGC6tSO/YTalJmS9ZW7RdHapIvHO6mrmINc7?=
 =?us-ascii?Q?4lh8p+Lq7mz5XjveLBH0gpbYnCHNmz55HdvRuqICr91Uk0yYvYlfIhD9yqVk?=
 =?us-ascii?Q?aNigz2uN9+/+OH8UG2JUYgnMaOtCgW0WxrADJOq9vxF+2TgEq7JeDeEFAPcV?=
 =?us-ascii?Q?a6OF5O+CKy1hmGXJNvUNdEKyQDeM1KWDI38w9RsKGskiKXVJXwNLYT1vcr5r?=
 =?us-ascii?Q?sLsdhjfbVcgUvxR61W3jMxxb2BJSVHWxBHmSCoD2fTiseAegn/oFk+F8ACjc?=
 =?us-ascii?Q?5OtQ9NVmwbpIyYndCdM3bjq9/bk9/ZxFsjjnX6T3hb5tLa3tbWSimhUI5WYv?=
 =?us-ascii?Q?DYCaQFltSlzRnEZgReLTUs8zVj/qNM+8Vw85OCGPjJEPt0UPQYb13Bt4g1Ph?=
 =?us-ascii?Q?yxWApkChoqrp/jdtXqPQOv/4xA1kWV9t8qrt/y3TF8o5qGYZ7qsXVSgY0H6y?=
 =?us-ascii?Q?BnJLzDuOZsq47y1MK7JTT+DqaU/8s62hhuC86dTYrMlDwC93q4arY2bxF23d?=
 =?us-ascii?Q?v8bB76RAjGoxkl4AjNMjLtitPA6jiLVoPcoUx+YL2NfXY+awxy3iNohqd1pW?=
 =?us-ascii?Q?mbZsZEFqb104v6qNyuJc4FmLxmmysx0sI7F2MzQ25XidgpZsSqfupJTG+s24?=
 =?us-ascii?Q?Wa9LzZ4wXCeoCl+8bGJXYTSd90frigYgS1ABtqnFUzbnfBDcpLLVS9BrL9+l?=
 =?us-ascii?Q?dAqi+/YdfT9nIGs82/zga+kb1PoB5DHCeCXBvivpDlJ0TZaAVNgeeG8zyF89?=
 =?us-ascii?Q?/m6oDVdKOiDg6VdQKrbUH+t9F/WhpsinjqUSXgiFnowBxJeiY/zqVYdKrxSl?=
 =?us-ascii?Q?ocacrSdKfEWQuUlI8Rt+I1fnCY7q6adaWwme62aAe1Z8QgdcmKyAOgUGEpZT?=
 =?us-ascii?Q?8F+rz5gEqTrm+qyLWgKqC1VeH0vgAjP80y6WiTprf5vTZgT2mx1FsK8wr44Z?=
 =?us-ascii?Q?zT4xVUXIo5PD9yYa9xuJ2SqoWjji6JihtGK3BS2Wvk0gX8uvzverc9618ZQS?=
 =?us-ascii?Q?X/vhhGr0cYgjCwABBqITxr0BYCdjF4Ru7qcv2WxKmKgEIPfeuC+m9qnRXHTu?=
 =?us-ascii?Q?YZhYQIfRmKDDTx5d4o7MOcG3LjHRbL+6bKEmp5i7oJha8Vjeag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 21:08:50.7026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e781456a-75ff-4c26-1f23-08dcf794b8f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685

On Mon, Oct 28, 2024 at 07:52:10AM -0700, Nicolin Chen wrote:
> On Mon, Oct 28, 2024 at 10:03:09AM -0300, Jason Gunthorpe wrote:
> > On Mon, Oct 28, 2024 at 11:24:10AM +0800, Zhangfei Gao wrote:
> >
> > > > +/**
> > > > + * iommufd_viommu_alloc_hwpt_nested() - Get a hwpt_nested for a vIOMMU
> > > > + * @viommu: vIOMMU ojbect to associate the hwpt_nested/domain with
> > > > + * @user_data: user_data pointer. Must be valid
> > > > + *
> > > > + * Allocate a new IOMMU_DOMAIN_NESTED for a vIOMMU and return it as a NESTED
> > > > + * hw_pagetable.
> > > > + */
> > > > +static struct iommufd_hwpt_nested *
> > > > +iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
> > > > +                                const struct iommu_user_data *user_data)
> > > > +{
> > > > +       struct iommufd_hwpt_nested *hwpt_nested;
> > > > +       struct iommufd_hw_pagetable *hwpt;
> > > > +       int rc;
> > > > +
> > > > +       if (flags)
> > > > +               return ERR_PTR(-EOPNOTSUPP);
> > >
> > > This check should be removed.
> > >
> > > When a user page fault is required, IOMMU_HWPT_FAULT_ID_VALID is set.
> > > if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
> >
> > It can't just be removed..
> >
> > I suspect that IOMMU_HWPT_FAULT_ID_VALID should not be set on the
> > nested domain but on the parent?
> 
> By giving another look,
> 
> In iommufd_hwpt_paging_alloc(), we reject IOMMU_HWPT_FAULT_ID_VALID:
>         const u32 valid_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
>                                 IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>         ...
>         if (flags & ~valid_flags)
>                 return ERR_PTR(-EOPNOTSUPP);
> 
> In iommufd_hwpt_nested_alloc(), we mask the flag away:
>         if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) ||
>             !user_data->len || !ops->domain_alloc_user)
>                 return ERR_PTR(-EOPNOTSUPP);
>         ...
>         hwpt->domain = ops->domain_alloc_user(idev->dev,
>                                               flags & ~IOMMU_HWPT_FAULT_ID_VALID,
>                                               parent->common.domain, user_data);
> 
> Then, in the common function it has a section of
>         if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
>         ...
> 
> It seems that this IOMMU_HWPT_FAULT_ID_VALID is for nested domains?
> 
> So, aligning with that, here we need:
>         if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) || !user_data->len)
>                 return ERR_PTR(-EOPNOTSUPP);

I added a TEST_F for the coverage:

+TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
+{
+       struct iommu_hwpt_selftest data = {
+               .iotlb = IOMMU_TEST_IOTLB_DEFAULT,
+       };
+       uint32_t viommu_id = self->viommu_id;
+       uint32_t dev_id = self->device_id;
+       uint32_t iopf_hwpt_id;
+       uint32_t fault_id;
+       uint32_t fault_fd;
+
+       if (self->device_id) {
+               test_ioctl_fault_alloc(&fault_id, &fault_fd);
+               test_err_hwpt_alloc_iopf(
+                       ENOENT, dev_id, viommu_id, UINT32_MAX,
+                       IOMMU_HWPT_FAULT_ID_VALID, &iopf_hwpt_id,
+                       IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data));
+               test_err_hwpt_alloc_iopf(
+                       EOPNOTSUPP, dev_id, viommu_id, fault_id,
+                       IOMMU_HWPT_FAULT_ID_VALID | (1 << 31), &iopf_hwpt_id,
+                       IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data));
+               test_cmd_hwpt_alloc_iopf(
+                       dev_id, viommu_id, fault_id, IOMMU_HWPT_FAULT_ID_VALID,
+                       &iopf_hwpt_id, IOMMU_HWPT_DATA_SELFTEST, &data,
+                       sizeof(data));
+
+               test_cmd_mock_domain_replace(self->stdev_id, iopf_hwpt_id);
+               EXPECT_ERRNO(EBUSY,
+                            _test_ioctl_destroy(self->fd, iopf_hwpt_id));
+               test_cmd_trigger_iopf(dev_id, fault_fd);
+
+               test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
+               test_ioctl_destroy(iopf_hwpt_id);
+               close(fault_fd);
+               test_ioctl_destroy(fault_id);
+       }
+}

Thanks
Nicolin

