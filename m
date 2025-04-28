Return-Path: <linux-kselftest+bounces-31824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C570A9FD36
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 00:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584A01A828E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 22:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED58212FB6;
	Mon, 28 Apr 2025 22:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JXNrTLj8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF4F7E792;
	Mon, 28 Apr 2025 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745880268; cv=fail; b=RaxnXb5ZA1aAxkO2DYuTEB4gcmqYbqxm/nE/AI7moU0DVoEJVkpvcgZVNvtrPYCyc7YZhgfHITotRHTPrd12eFPxRHZt1TJbsJ9B3S6Iu1jNvfzol8gDHjzUSNyLc8JMLvDgFCOzBSKPQLiSQi9QaChszjAu1LanONfwePKDe7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745880268; c=relaxed/simple;
	bh=XmASLbpNMTHPh3P4+0EdeRd5txkhzRJFIm8jw/lMWsY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHhy/BFFkPwPj3csEHpMqxRGP0DPTF9Khx1gel3VdTfhExhiaJOmc6kzpesztEk3fqO5PtoZ14zfsQquOdYYNk6EsriruqE/wV4xBfKQZtzvci+h74EDThF8Rm56KIq11i5FXg0vajRKrn8fNn5ULR8h/g7QUpyujrU1GG+uD2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JXNrTLj8; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bi9iEFqy6qgP/hJx9mN5AXh3JTsbeO9t+d1r4uAlY9QJeOos74YBxXgWdKKWW1SSq2AQ6H/mUydULj98Bdp03TDwfB9ZpUq+k8YlvT5Pu5pEcT4C6i70dfqNqXsYb0d0wniCJw83dPysP2spHFpFt0pUG8fuvSBbI3yl9ix8F/GrdG6RgZSE3LekugepB1t+A+I6KHuMAJ6jCTwUNefDPbIljZVPZs5t8e1X0w5yIQqt00CjdsIHUF7Ed1KJ1xp3ZiMLyyIQgbqXXXr1AOi6fZ0eBul+y+cV/bujB8JJ23b9GWfutOn/2eptIBOJc0DGGjdRYeeISatbUPKYIGg+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcu0VhdocjPUY5Om8/5e95ZLsbzjCgF4NnK60ih07I8=;
 b=cnftzoyXQQB4BYtDTkb4/ouIr+RzzIqLH+WCzmdpCSZ48PZliXAUKwmmAxbrdrEWH6MH4umxq7v8icyuzTW6Md2VZyHlOMGUO8TxDFTAq9Ispk21PNRqus0gWGfsP2lu8xzHLHpu3esDS6OkSLJTPu3iIxIdi+3V3JLZDZ708hnIYicpGtSgB7/v/1fZqyREnagEPMdlee5zfEl9Ai06VyLCXMxkc1axV/czVObFtt2qI2OiYP/NtWgXiTQftRYgSmdsXLO+dvaivCVJbDlW/qp2pGEAOSoqy4RKEMYTVMSrju7kTkWC3/qSi45JRF7Y6LRmbVqXzIprjUgY3ShFeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcu0VhdocjPUY5Om8/5e95ZLsbzjCgF4NnK60ih07I8=;
 b=JXNrTLj8RO4DT6/Kr/opDGmj1R90IVU2qdgt9MPBvTQq9qQsnupuc4ymx1vOkPGGs0p1GV6jv++qCio3RPJ3lHbIdcbfv6E1Us8d0F429C91nHUDbBmgtzUFCliZe4McytKG7TZ/V/jMlU7dXIt3FuP1uH8wjGnCRCWAR2t42oAqX6sLGzjN5KlXaC+GvWnL3e7waiRknVVyhjjOZV7Ci5a0K96yOB8jRfp4tmSbVdGnpkKjCXYdY6zl6i1AGFN3LWALvixwBV8Rh3+/T0w8sfFFs9A/iUuJzE9Y0P4MNSmmaFhyZQv9Gm4a9hR3bMCg3EiZHYXB8E0OncbHZInRxg==
Received: from BN8PR04CA0023.namprd04.prod.outlook.com (2603:10b6:408:70::36)
 by CY1PR12MB9604.namprd12.prod.outlook.com (2603:10b6:930:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 22:44:22 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::54) by BN8PR04CA0023.outlook.office365.com
 (2603:10b6:408:70::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 22:44:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 22:44:21 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Apr
 2025 15:44:12 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 15:44:12 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 28 Apr 2025 15:44:10 -0700
Date: Mon, 28 Apr 2025 15:44:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
Message-ID: <aBAEuP9962XweHPc@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
 <aA_0TV0RkVOHk7Qj@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aA_0TV0RkVOHk7Qj@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|CY1PR12MB9604:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7cebfa-3188-4e81-05a1-08dd86a6381f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TBK+Rf5Rzote/I80I/6BxV7wV+v550pExbyJGO3UqeMFyMCOeMmPja0N4BQv?=
 =?us-ascii?Q?GkeHilz2zMPL+Zk22kcsOdP2EQFNXeSKoEjE2eA1Bl/fVszHn2Pf2RabUmVh?=
 =?us-ascii?Q?loacwWcR1xi5yWD2zexvu1EiNxkcIlgOiftOMcFzzkhaT3I4URXB+74EI6Hd?=
 =?us-ascii?Q?+/LtqeFH/jdJV4pbcD2LCQZa5jaH3y+t6qhaxmL31dyTNLRU4SGRPtgberpr?=
 =?us-ascii?Q?dp0pNA1Aj5mtMaYNoW9B+VUpym5WatSSJLKt6LD9jeNIF0vSey9QknXEvoCV?=
 =?us-ascii?Q?MTmgQHfQ+T9dfeDCHDdm0AQhGrjcDl2QkQVW/vBc4bcfhmSqYtk+Bgt6Xy0k?=
 =?us-ascii?Q?/BsehlgAn1OvJ8MxqmLlSh7LCrg9GVjmZtvgeyJvWD1bV/Tj6F/PwaAhCP3P?=
 =?us-ascii?Q?23JmJkShRZMoZ9XxeAV6RWtejNi9HZK/vuPROeTwWUZd00LA9Ag5+0s9bo6+?=
 =?us-ascii?Q?nvQUxNupeb1cNITuV9BuBVqKLROFwCadVv9xSZxvpkLMHly9yh4kiatjBniM?=
 =?us-ascii?Q?x1r3ZrxB8RkziGvsew3eUXdds+AI6dfVZ1bDLwVkpDxBr+V9MsGQ8E5lPyBY?=
 =?us-ascii?Q?mFCybtXheEYreHjqAgCMhO4tXk3mfFxH04izcSG5N5VFCPVuf9SinW9PNRI8?=
 =?us-ascii?Q?sm/B94+BCXoKe7BPh+RuUtImgz4pPylgaLd7sl32cV5zAaj2yd2WmXoC5Thl?=
 =?us-ascii?Q?b4CHW2ZgES7fzyVZfNqrHvYEZ2jvMx5dDhCHzJd+1NeWnzR+5KMZOutz/30r?=
 =?us-ascii?Q?xm3arfO7NLMYa4ujls5+28hk87Ryc1vS/kGcZC9A6Wg/5nQM603nNAgrPSlE?=
 =?us-ascii?Q?xYMw86bcDKyhFGOGgCVD0AQ1BBXaYsEtFw6y79zT5wmTMbr8AzUN3W2B3men?=
 =?us-ascii?Q?Cl8BleCfuVrl80QzIgYgivmaNqsOlxM2DlgxrLtgUx4MvLRX7oW+ZP68nQ1K?=
 =?us-ascii?Q?EdZegyC31voDZ0+gyVctrSlJ4wNW65o0RR3Anq8x10hYI0jzC3Chxr2LzYMY?=
 =?us-ascii?Q?jk1X0e9DKMQh4bngHFgBThufx2q4M1Z0FayN9ioASB97FmJJcVvQHm4Y4WvB?=
 =?us-ascii?Q?g5c/yjpo7moQwU7gitaFNGB154p8dljixx60+KolEcEiv/O8QOjvJSPQ4YZi?=
 =?us-ascii?Q?R4X02DY5ViQZxa7pdv8F2ZiENTjMt3uVJChKnXeNfvUx5p9MzsVxkAV62DS/?=
 =?us-ascii?Q?4siYl9lGt49YVEXwllerWIOX+/UkabBjCRgsKijPnqoe7/yZy6F16HmSKQp/?=
 =?us-ascii?Q?qSqjSsgBnujYLC+sXQgarwrMgYNcT09NQYorrMVHaRqG2RmZt8U4dtpliJ4k?=
 =?us-ascii?Q?xbBFWskAVcfUORwzeSFCyGQFydYg7kV9x6J8Pi63UHaue11sgmXJcjzJ1nCK?=
 =?us-ascii?Q?T9FtJqa5eFLWnfCB3DDAIiJegkqSaaApClpZaT4aMWcqxMX6Ps/tEXgNjITa?=
 =?us-ascii?Q?p6IQv2988sW71x8+99xKemdTyHNsT3kDbsRjLgQpc0du577AHxhc7nk/IV2g?=
 =?us-ascii?Q?ffN9emaQ72XzOfNePUPbGmSxJnW1vyosJ+Ni?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 22:44:21.8852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7cebfa-3188-4e81-05a1-08dd86a6381f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9604

On Mon, Apr 28, 2025 at 09:34:05PM +0000, Pranjal Shrivastava wrote:
> On Fri, Apr 25, 2025 at 10:58:05PM -0700, Nicolin Chen wrote:
> > @@ -501,6 +504,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
> >  	[IOMMUFD_OBJ_IOAS] = {
> >  		.destroy = iommufd_ioas_destroy,
> >  	},
> > +	[IOMMUFD_OBJ_VCMDQ] = {
> > +		.destroy = iommufd_vcmdq_destroy,
> > +	},
> >  	[IOMMUFD_OBJ_VDEVICE] = {
> >  		.destroy = iommufd_vdevice_destroy,
> >  	},
> 
> When do we expect the VMM to use this ioctl? While it's spawning a new
> VM?

When guest OS clears the VCMDQ's base address register, or when
guest OS reboots or shuts down.

> IIUC, one vintf can have multiple lvcmdqs and looking at the series
> it looks like the vcmdq_alloc allocates a single lvcmdq. Is the plan to
> dedicate one lvcmdq to per VM? Which means VMs can share a vintf?

VINTF is a vSMMU instance per SMMU. Each VINTF can have multiple
LVCMDQs. Each vCMDQ is allocated per IOMMUFD_CMD_VCMDQ_ALLOC. In
other word, VM can issue multiple IOMMUFD_CMD_VCMDQ_ALLOC calls
for each VTINF/vSMMU.

> Or do we plan to trap access to trap the access everytime the VM
> accesses an lvcmdq base register?

Yes. That's the only place the VMM can trap. All other register
accesses are going to the HW directly without trappings.

> > diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> > index a65153458a26..02a111710ffe 100644
> > --- a/drivers/iommu/iommufd/viommu.c
> > +++ b/drivers/iommu/iommufd/viommu.c
> > @@ -170,3 +170,97 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
> >  	iommufd_put_object(ucmd->ictx, &viommu->obj);
> >  	return rc;
> >  }
> > +
> > +void iommufd_vcmdq_destroy(struct iommufd_object *obj)
> > +{
> > +	struct iommufd_vcmdq *vcmdq =
> > +		container_of(obj, struct iommufd_vcmdq, obj);
> > +	struct iommufd_viommu *viommu = vcmdq->viommu;
> > +
> > +	if (viommu->ops->vcmdq_destroy)
> > +		viommu->ops->vcmdq_destroy(vcmdq);
> > +	iopt_unpin_pages(&viommu->hwpt->ioas->iopt, vcmdq->addr, vcmdq->length);
> > +	refcount_dec(&viommu->obj.users);
> > +}
> > +
> > +int iommufd_vcmdq_alloc_ioctl(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_vcmdq_alloc *cmd = ucmd->cmd;
> > +	struct iommufd_viommu *viommu;
> > +	struct iommufd_vcmdq *vcmdq;
> > +	struct page **pages;
> > +	int max_npages, i;
> > +	dma_addr_t end;
> > +	int rc;
> > +
> > +	if (cmd->flags || cmd->type == IOMMU_VCMDQ_TYPE_DEFAULT)
> > +		return -EOPNOTSUPP;
> 
> The cmd->type check is a little confusing here, I think we could
> re-order the series and add this check when we have the CMDQV type.

This is the patch that introduces the IOMMU_VCMDQ_TYPE_DEFAULT.
So, it's natural we check it here. The thing is that we have to
introduce something to fill the enum iommu_vcmdq_type, so that
it wouldn't be empty.

An unsupported DEFAULT type is what we have for vIOMMU/vEVENTQ
also.

A driver patch should define its own type along with the driver
patch. And it's what this series does. I think it's pretty clear?

> Alternatively, we could keep this in place and
[..]
> add the driver-specific
> vcmdq_alloc op calls when it's added/available for Tegra CMDQV while
> stubbing out the rest of this function accordingly.

Why?

The vcmdq_alloc op is already introduced in the prior patch. It
is cleaner to keep all core code in one patch. And then another
tegra patch to add driver type and its support.

Thanks
Nicolin

