Return-Path: <linux-kselftest+bounces-17193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E61B96CCF3
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 05:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26171C2245C
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 03:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607F41422D4;
	Thu,  5 Sep 2024 03:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZNxQEaSI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B442AA2;
	Thu,  5 Sep 2024 03:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505695; cv=fail; b=CZAQAK2M88PxLO3We02rEmMc+drdwQ1jwoXRdBDwTMZRSEYqIC3Ybe7pOXAq/2GvPvt+thk7rO+O6eKaAdte2h9UH9vh7tp7B0wQo/PgLXF7kNWZAgL6SKQs15KwmJ62a7poSUGAllrgaX1x74uqAq3aHY1hD4zlfERYYd7Y8E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505695; c=relaxed/simple;
	bh=z5DBOxao/TSJCJ2BYcfw0WvhYg/u3BhdpJ0AygfG+xg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKH/qkk58lZLjYHL9JAzWjCB+zGqqTu29mkqUrRhtGeJ6SGG+degPR13bFYB1d3f2q9KGeHQQKwihiPBJ+mv4fNQmIfHkfRlUideH/LOEuA2JAROTwRw3ALg47TyBDJd1561d/le30y/IYAXEYWC9mL8bUw5drYz5R0rZCkqPgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZNxQEaSI; arc=fail smtp.client-ip=40.107.100.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sobc/1sWp14CoUItC7tHiHHcqbTAgtpNwxl4Ef0fPILZR217SDQkxjVVG3sjLkq4uIh7xAAueQ2zr2R+uwRqb1JAVlo36ExtFulXd3t0MYBhFGIpXkBJdj21uAnBzQPJb0eE8ZPWeLpEcTkTLe4cZqQ6/s0B2yXKdtxmjNEMUO+1UFA2ell0Iu3+UdT636fneZQtrwQux2DMYuPFuU4C1OUTurFHTJuHIwn2tGlHQW3hY7fVMshMJXxpcbHs36EdoG4H6cE2/qr+Ew6w8ZGA5DnrWR+5QHPk0Fvgvh+KNdJlOZ1vWTIcDG9nTDer7BVSgFMNmV2f8FVXtA8U5FzjVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16iVbfaLUsSAsQkr8m/sNAnYjbCJ5otSK/xmLQggjJs=;
 b=T6qJ3i70zIjuQYJSzlhLPo2feKFBLj7omyTIxhbIY7mK73waJ/osBp19O2CbT9mxT3MEl/SGONKLqplN3V0e+XJHYZ8aY+L7w/XN6Ue01MQZxNF7aYjWzpm698I7BdZ9gvIOieGzXn8W7y3UucOSp3GPmlcmr799FUDSQo4f13vDX4AoAHKR+HrQlyAw6vyaQEfHVuHZLUAPy2Vr/FaLMJny5Q1ZxlkCQblXpYAi6CKLHCmZp9vlpYuI16bIi6s7jZuiVvdzOfGP0jB1/bYCQpIoNUaDGXZA6OIONQbwaNzrg/kTcOJxRVZeGyijaAzWmr1JkKhB91m+UbCezhAxBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16iVbfaLUsSAsQkr8m/sNAnYjbCJ5otSK/xmLQggjJs=;
 b=ZNxQEaSIMlqnz3+4CG+0Un082FDpeBeWLE4LDH3BcWyy2nxXrvBSZlQtKAlhhA4wGUm3+CuNZ+rwFFI22O3G65SpTuGBxA5iEokxQPHWs57Cmwf9j7prMp0/H5EgxXboEaGx6aUSx5pbYJGdipTn0NEdHiXlk2jEBZ/DhRxYEOnSEcaEu72EWNXvMcnvn1W2CJwNtX6WUKvlp4vzed2PvIo0BoWFQl3C7oIPCCGfaLdpt4KYe7ydyW8rPIHcj4NCCsTQAhtQISbNsY5xQul6c7qEKIQXDJ9KopfepwHB4x3LGDBX8Ftcrw0ghtEd/Nme4T+ttUXRGo/GydRPJ8riYA==
Received: from BN0PR02CA0039.namprd02.prod.outlook.com (2603:10b6:408:e5::14)
 by PH8PR12MB6915.namprd12.prod.outlook.com (2603:10b6:510:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 03:08:09 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::15) by BN0PR02CA0039.outlook.office365.com
 (2603:10b6:408:e5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 03:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 03:08:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 20:07:55 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 20:07:55 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 20:07:54 -0700
Date: Wed, 4 Sep 2024 20:07:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<will@kernel.org>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 02/19] iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and
 IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <ZtkgiJD7Mo6K1fZm@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <c6ac7dc5031e96abb4634db504a0bf4a0c82ca66.1724776335.git.nicolinc@nvidia.com>
 <55918c41-65c4-435c-860b-b2a177b0d364@linux.intel.com>
 <ZtVMrXXESy/RfWVi@Asurada-Nvidia>
 <20240904162621.GN3915968@nvidia.com>
 <ZtiY9gE9YDbgJyRN@Asurada-Nvidia>
 <20240904233707.GA1358970@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240904233707.GA1358970@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|PH8PR12MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e924a2e-2f03-457c-fe27-08dccd57f728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tagqVyc45esUSFxa7QxdtCV6Yrj/pqEIxjO8+ynx6rfhoOIzTvHDbguJrApT?=
 =?us-ascii?Q?JqwnAX24Oc5jNXOdJbgnzQzrFd6CKBRb4uo2qbRZqx5sRN7mdSOuL3kIiVEy?=
 =?us-ascii?Q?lKPuSVhFCNDdOFogK3n7LRFdPj4B3p+2YOnm5lf6SnUV/IZ6zlU99pCyFSJQ?=
 =?us-ascii?Q?krUJyxnboWkSahE0WTV503e/DVlvKk1x8iPrNeGw2eExIxQd/wrhKSjQWI8U?=
 =?us-ascii?Q?A8oq1HqE4gXDSSWnV2Ae8tLRv1L/oF49YvnGM/iDS0i7Gpq7WDZSB6X2OuOH?=
 =?us-ascii?Q?cxqr9CTwXWNOA+0TbErE05PTGimrRMAXcjhzELZ1f9Hy6T3bs/cJ8ZKXPGVp?=
 =?us-ascii?Q?0g/scyKI3CPe8m4RKBQKmvv77siR9Og9HQlIx8YzW+RB2eLDaSMVDYtTEKV5?=
 =?us-ascii?Q?OmNj6gLgss48ncQE6sJBcy/znEfFOgSDeL97XYH8CHC/wREv3Y+sVp4VS5OW?=
 =?us-ascii?Q?O3OQvnivKtSI/vNPXa7CQmFKwquzML/GcqVeUClfk0M5pEl1uQi6RjoE42CO?=
 =?us-ascii?Q?EpZABiBLnBN6vTJeXubVUqS5G1/au8pFexeORjuAy3dKPph8Yac4PlSonXWN?=
 =?us-ascii?Q?Iz+4oEl92K9ZFE62Gz6j22nlIRh/COYh1RE0F/GTc1VOO7FF06z4GoHP7ekY?=
 =?us-ascii?Q?DZ9gSGEOYbr0hESe6Ur5zE5aIm49pcSs6OqGtsXl03XY/hZE/AdxkgbUBGVo?=
 =?us-ascii?Q?EysWAlVmAh3XrW4GNCxmuXlETLLmiWbufZNIof3CnX9LqRWeg3/A4b27GpxX?=
 =?us-ascii?Q?es2C+P0beJ3M0OB47oO8zdLuSukU5M8kJ3HVdgcTc2mAu2HdDlfci5Y/sK+6?=
 =?us-ascii?Q?3rXjL8qA9BbgpBBCWzlOuynG4+sqcs2XZ7+rBE1bbBNggHsswgt35Pb9K98U?=
 =?us-ascii?Q?K/MgptGzP+FLV+ui4wwnXP6pI/DyQd3x85xD0GBYSshL6bwLG7xaisi9eJYS?=
 =?us-ascii?Q?aPCfn7oNKyHIoJvjmWt5Xhts/544sXItFbBZnW+Hl2joHafByiSkjBqno+Qb?=
 =?us-ascii?Q?6BcW3chuDAIH5Km4V4HB0B7vKGcGQKG+Z0qKw8Ha0VlzyWMT9d/AGXQZRrdU?=
 =?us-ascii?Q?A8I1hGSAHspBSqVAuI1oHAMJ025n5kDjjwFRv+O1E1Ky58yoQZuuUqZGlneP?=
 =?us-ascii?Q?QAr08Nv8H9z6VcQr3k1JmhrQbENkiEoWXPlDiRLenw3g+FeRrDUKSQmi7LgN?=
 =?us-ascii?Q?x+b6qEaBO6tq7uxF4/ibMK0BnAhJbDsXiJBFAdT9iltEon2LpF/AmktkGNyo?=
 =?us-ascii?Q?YE9B5kiJexP6iJPkSJlVsYNG4EqlJXmagRSTB/WCsBXcHpsyhAC42EMnqbp8?=
 =?us-ascii?Q?DgCt+8syzebAaM5lmVE7Hm2ZFRnhnKanSGUDGzz96qBdNWsRDQm02jE3CmYZ?=
 =?us-ascii?Q?xanwbuUeNQB5CDla+XVOhjGfFBXerTRyCgmy6nPV5KkPb/335vtZi9lMdj61?=
 =?us-ascii?Q?m6fa9MzvjxS1hr9XE2qIDcku8kDeg85S?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 03:08:07.0244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e924a2e-2f03-457c-fe27-08dccd57f728
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6915

On Wed, Sep 04, 2024 at 08:37:07PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 04, 2024 at 10:29:26AM -0700, Nicolin Chen wrote:
> > On Wed, Sep 04, 2024 at 01:26:21PM -0300, Jason Gunthorpe wrote:
> > > On Sun, Sep 01, 2024 at 10:27:09PM -0700, Nicolin Chen wrote:
> > > > On Sun, Sep 01, 2024 at 10:39:17AM +0800, Baolu Lu wrote:
> > > > > On 2024/8/28 0:59, Nicolin Chen wrote:
> > > > > > +int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> > > > > > +{
> > > > > > +     struct iommu_viommu_alloc *cmd = ucmd->cmd;
> > > > > > +     struct iommufd_hwpt_paging *hwpt_paging;
> > > > > > +     struct iommufd_viommu *viommu;
> > > > > > +     struct iommufd_device *idev;
> > > > > > +     int rc;
> > > > > > +
> > > > > > +     if (cmd->flags)
> > > > > > +             return -EOPNOTSUPP;
> > > > > > +
> > > > > > +     idev = iommufd_get_device(ucmd, cmd->dev_id);
> > > > > 
> > > > > Why does a device reference count is needed here? When is this reference
> > > > > count released after the VIOMMU is allocated?
> > > > 
> > > > Hmm, it was used to get dev->iommu->iommu_dev to pin the VIOMMU to
> > > > a physical IOMMU instance (in v1). Jason suggested to remove that,
> > > > yet I didn't realize that this idev is now completely useless.
> > > > 
> > > > With that being said, a parent HWPT could be shared across VIOMUs
> > > > allocated for the same VM. So, I think we do need a dev pointer to
> > > > know which physical instance the VIOMMU allocates for, especially
> > > > for a driver-managed VIOMMU.
> > > 
> > > Eventually you need a way to pin the physical iommu, without pinning
> > > any idevs. Not sure how best to do that
> > 
> > Just trying to clarify "without pinning any idevs", does it mean
> > we shouldn't pass in an idev_id to get dev->iommu->iommu_dev?
> 
> From userspace we have no choice but to use an idev_id to locate the
> physical iommu
> 
> But since we want to support hotplug it is rather problematic if that
> idev is permanently locked down.

Agreed. Thanks for clarification.

> > Otherwise, iommu_probe_device_lock and iommu_device_lock in the
> > iommu.c are good enough to lock dev->iommu and iommu->list. And
> > I think we just need an iommu helper refcounting the dev_iommu
> > (or iommu_device) as we previously discussed.
> 
> If you have a ref on an idev then the iommu_dev has to be stable, so
> you can just incr some refcount and then drop the idev stuff.

Yes. The small routine would be like:
 (1) Lock/get idev, dev->iommu, and dev->iommu->list
 (2) Increase the refcount at dev_iommu
 (3) Save the dev_iommu to viommu
 (4) Unlock/put those in (1).

Thank you
Nicolin

