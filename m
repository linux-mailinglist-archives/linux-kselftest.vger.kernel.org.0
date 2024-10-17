Return-Path: <linux-kselftest+bounces-20007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0969A2AD9
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1BD28252D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B431DFD88;
	Thu, 17 Oct 2024 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SzelwWDb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7D61DF996;
	Thu, 17 Oct 2024 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185955; cv=fail; b=EodaaALkkaTye7+KwoaZlGl6ho41GxBTqqZoKnc7qPBW5KrDUcALY81I9eWWf2+y9/S4t4lwwrmTlbGtKQNxGuEhwDQVeW4DC1vbfr7YCmTjJ7LQ2qwKqMAzq3o0brWuV6SB4t1mMbOxuvxK27LuM+l3mDkSj2tw11aXz6ttvgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185955; c=relaxed/simple;
	bh=vcHZvAo6SswJyIZdLHBAk+tVts6JrcQ1g+tync/IFo0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O27rrG1j5MPHCe20QExlT1/+D9ttj7CkvaarN3bFhe/nbykOKOqG6a0zmzSZDGPVFoO3rmrzlZOfzoiBC7BsTb5cPszGT6ZMQmf+TKHNAuWxxGdbeH+smzDFvWGMVB2gJxRO4yHWqcA47KQgCLJcLvI9gXLAc0KDXT8P5WXqH7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SzelwWDb; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJOuyxbdOM0gCb1WL2JSaBJQz20KxWJaE9BAqcP6t9oW2tWqjhBntJ9/nX2U0gM57s5YZIE8dMxFvPpysIoFT38KmnZaNThmGP/i5fBlMuBW4IQPumAcpRP5bacRmbjY0p/98Ax6Me+2+owAoCYsZhNgfgPFe9s6AVJAbKEhhaGgOmCdjYQFYGkjQqjO0SsfwRKvirSsX3zZ1B85XbAU9OgoP80Xb70PTdc+OvGbSqe4FX0LdJ3pULWPC6y8hrAMG4V+evgr6GtSUeNGu6dk81moH7iXfMh39bShWktmdKiJ03qJBAHWfYYnlIEjWJOMqUzyBD5o0Hrub6V+9AxMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WY1JUzcuQJsakb6RlUodmTfektvTf2hBrxS7CWYfHCA=;
 b=Y0cfe7ARf2EBColBcw1hN6p5hTm3rbFFKEY6kCal6ExjFjbdMnvLlJYd5diFYjZvYORc7GKKg6lV3xtosnXEUEsHg9VTMwGx5myCqGc4av9hUeAG6fA8mIaBF8Hxx+9oGsuin8yA+nhumsvUPcc3n/7GEl3i9SsFgTXQAHoPLb49t5N/4iOarjt0Xrlr1enHO7IoM7fXxAcnU4NqG4/WUOihG6qrOV20KmkGUnNo7wwCBPTZUht41QtuGUg6OzRkY879Wp5XM2U6Icc/q6L08XBb/ImD2bTr1bODNmLYFIRIoDn3uL86ZZqgvG+TkXAS4xXAgxv9kYdqBTVrThLnOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WY1JUzcuQJsakb6RlUodmTfektvTf2hBrxS7CWYfHCA=;
 b=SzelwWDbW0xnlZVdJGmOT9/hd/a89fL3UNbSjOMoCL7xdF8t4cudMBUz9ITcfdYjE8xMy40mLZVAGuNDdBFKlHI1w4FE+h9l6nyn8Xod+/f0yPuv9/+WUjSPA/2UpobxKvX+NCyLPLWiiV5Mok1MSGEJyZfnjGCQMGMN+plQU+8fdDJ0TbOE47F6ec0zV7Nq+EAYhJ7Bg+qQmKOtQDRiWWgNZ7QABrdztRzMTbSFzy6XkC+TdTisx36MTFq3as46f0ZRKmp6GErtS896/GWn9eyv3Gl+/QljQ84BKMXnBmN+KRDPJNerEeQDz/eT7+4ZOiucPKjhiCkStBXDnDZt5Q==
Received: from MW4PR04CA0061.namprd04.prod.outlook.com (2603:10b6:303:6b::6)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 17:25:49 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::93) by MW4PR04CA0061.outlook.office365.com
 (2603:10b6:303:6b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 17:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 17:25:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 10:25:36 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Oct 2024 10:25:36 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Oct 2024 10:25:35 -0700
Date: Thu, 17 Oct 2024 10:25:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v3 08/11] iommufd/selftest: Add IOMMU_VIOMMU_TYPE_SELFTEST
Message-ID: <ZxFIjfc7gtXocb/n@Asurada-Nvidia>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <240dbfe0bec59b39e759d610485ff062054c370f.1728491453.git.nicolinc@nvidia.com>
 <20241017171500.GM3559746@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241017171500.GM3559746@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|IA1PR12MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: 87fd0e98-d470-446e-3197-08dceed0bc58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HoQ23t6HjZRYLqWvKvfw9RpYil3zKnz3oOOnUkfKoivJD7etrqfA0K5X5GD8?=
 =?us-ascii?Q?Qdj+WYKW8dQlp+ZOh3pUJbJL4yxusEyuhURemWgNmaziegYM9mvzk7ziftFc?=
 =?us-ascii?Q?yETKREJii5HyeEc0ACekSW25vXA9Z5r4Tuu8zfSjalgBfnAlnwni26+sMqWF?=
 =?us-ascii?Q?zwSgCRjU+zgYwEFoKVOjSurP7TPb8lWiZFr0SQKJRqzad3M5hg+cI23GxYBI?=
 =?us-ascii?Q?fcb2GnIJy8KH3oZnmaVPdqKKOr06xdFzsXf9qmF71rKsFXjMZESdJ4tkW+tT?=
 =?us-ascii?Q?qxDwho9nXyoHl0J+Sp3xIOvMg8AfdpzbWpVSftzgrEWTNDT++bslqrJyVZol?=
 =?us-ascii?Q?zMfhdiEaGjpS25YnXJnAAHJGJi7/19eiYCobF95DYTyoHaXwcYtAJGXjmRCJ?=
 =?us-ascii?Q?TYYNPjkcvX4OjtJeM5Fg8y7Q11yy/o5dudMHyx06ACBk0Gghh1d6+JB5NLn2?=
 =?us-ascii?Q?qso3QWGVtjUEydFPA7eB/hYESc7ikzCX/2iUO56nKSemIptJlPe5gwOgpStj?=
 =?us-ascii?Q?gvCJft1x6TmhuWnlcK8x9X4UWbOJjfVwWlGbHikiLux1Igseu9m5JgnJ3IW1?=
 =?us-ascii?Q?qEyra7t2LA1e4S3tWqAyjcZbVm2WjEOVGBI/DU2e+b7QArf2yBPv9NXY33iq?=
 =?us-ascii?Q?Xq+xIeilxdaG3TMRtTz95rLFD2LWx44NW4IJh9q946OqCE7edhztG67u5+NV?=
 =?us-ascii?Q?nIW6o/KIrcUMb3IzMgbEGFdHjsOB1b35rb+ulLIbT7FOEM6dQ1FjzP9QVGab?=
 =?us-ascii?Q?v/bQa8sXZeRpJBW9gitTudT9Pia+ZSrd0njfachOC32/NqgpAL6Ua/N/c2ew?=
 =?us-ascii?Q?BEbjRaUxPa/HuxPgohM8zPO6shSquGFUnjBwiyS45b22rk5g1o6En1RSMlbf?=
 =?us-ascii?Q?OV0ZU1f8P9Z/F7il6M/+OCK6O+6EClAgAhYWE5CH38VAkUbgh5ps6p+IVCyx?=
 =?us-ascii?Q?2AxW0AHccIAmucMCO6E7FDpXKgIrqdN60+c6+uhUbmQKvQn8WNta8CWF6cVH?=
 =?us-ascii?Q?2Ah/A/EUtRwAXKQU33qOovsQjlOp2d1B3G/HfuS2phHUpcG3oy256cOdRjCs?=
 =?us-ascii?Q?jzdF1bxxxulPYdCWri/UcmazKpa/CoQh221oWnC4MybKFCdjri9LQ5KtBY/j?=
 =?us-ascii?Q?AThiWlhINoovLJRs3fvAssZltzULK0nTyv7eeZC1NhWe06ibEDkjFfq4DaMC?=
 =?us-ascii?Q?ddw4m43m+r54d0VYdXNStNqUtXOU19ERCBpvJHPiJ6yfgDKOP5d9ecFgcwiX?=
 =?us-ascii?Q?et9CYagYv4QNy73VXR/3j0251gpqX5bihO+oLtLOXB4F+ov6Smf57iqBS1Gl?=
 =?us-ascii?Q?Xx3o6cF+dwrjg3SREQJUkSOn3ToyFqA6didZRLxdSXD2gHeMaEeq2600gMGk?=
 =?us-ascii?Q?syBf97ZW9E+glPnJThMzjeOPGzaPhTQzPEenuaBsForoLp7ZpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:25:45.9491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fd0e98-d470-446e-3197-08dceed0bc58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661

On Thu, Oct 17, 2024 at 02:15:00PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 09, 2024 at 09:38:08AM -0700, Nicolin Chen wrote:
> 
> > +static struct iommufd_viommu *
> > +mock_viommu_alloc(struct iommu_device *iommu_dev, struct iommu_domain *domain,
> > +		  struct iommufd_ctx *ictx, unsigned int viommu_type)
> > +{
> > +	struct mock_iommu_device *mock_iommu =
> > +		container_of(iommu_dev, struct mock_iommu_device, iommu_dev);
> > +	struct mock_viommu *mock_viommu;
> > +
> > +	if (viommu_type != IOMMU_VIOMMU_TYPE_SELFTEST)
> > +		return ERR_PTR(-EOPNOTSUPP);
> 
> What about the default viommu? What happens then?

IOMMU_VIOMMU_TYPE_DEFAULT is allocated by the core, it won't go
down to iommu_ops->viommu_alloc (this function).

> > +	mock_viommu = iommufd_viommu_alloc(ictx, mock_viommu, core,
> > +					   &mock_viommu_ops);
> > +	if (IS_ERR(mock_viommu))
> > +		return ERR_CAST(mock_viommu);
> > +
> > +	if (!refcount_inc_not_zero(&mock_iommu->users)) {
> 
> It would be a bug if the iommu_dev being passed in was somehow
> released while iommufd had hold of it through vfio. So just use
> refcount_inc()

OK.

Thanks
Nicolin

