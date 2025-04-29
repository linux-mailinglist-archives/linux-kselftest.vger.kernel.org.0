Return-Path: <linux-kselftest+bounces-31924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 529C6AA19E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 20:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08131896B86
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 18:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8538253941;
	Tue, 29 Apr 2025 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UAfhclOV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148EF251783;
	Tue, 29 Apr 2025 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950522; cv=fail; b=QOXfTjZpkSaFeC+YR18y+1QckRkhtmpo8NnT5RR0makfMzWLil7zvTsck402dA2F3pjG8zAHx8sBrRFoZDu0uP/h7E2WCV0LawmQ55w5RaTHRqHuVpieugxEEjMlbX+WJYtOj4rAGieNEtNhyHLQUtWsXIRYgvkOdEMV4BXBLzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950522; c=relaxed/simple;
	bh=dIiOYC9h0cXg2CQj5MEDix5OVQEOGeltBAQnznuzO7s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjeuTFzIX8ytt+BDusm3Fa+eeOztn9oZK6FbR6gZcbqbdvGNd3OLE5dPTkMOLa2Q3N1vowePZgpHcHF16NRVfJuyT69MGgyDdoX/brkrEhi4O2o9yKqMxFwEyYroNMOhupzcND91UVmIamHR8ilMIVJG77PmD5mAGk7eiavzB0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UAfhclOV; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIPaSKM1xa0+0r8kHBy9QrD1Vpu4z9Qz+cQ2nhSXdJcCG3oHyOKDJcqYrsOYc7u/hdxJhWXAmwv2CfYfbdcqY2pdYIUerBrE6muIPg3Hxj84oU7ioxf7H6BhZJtKDTffiNgXauWj7UqhEId8KVj4DcyclIpSWDVSaFziIVf4SjcUbJYqgVJkEwJRCMfLep4KTHoJjcH+mh6o+XlYN7K+rdWvJXD47j+UyWAL7IhOuIxd3cEIbyWBNIQSr+Ua1HMQTfJ/LOqviydtBy0BgQR/nexynIxEaoq1iWeIe/5MdxMzm6RhnM5HxR1QL2zknC5ih72OqM3TO02aXenNOqqRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZjd2AJcsFaYi/nRk0zh41/cqrcDOBosGIW9jn0Zsbc=;
 b=MinnTn04AcKsKKn2MgoUe2K5P9IlRQA1WfGlagsTAsebOakystMfGTtr7BGWqwVrdiYhRrWdjRMdWG2OrVLln6XY+1iZLKFS+iI9XfeAzXEdROUYKEA6g87aFI/jXewk0k5kXrqgRmis7tUyxhwksHfediM9pj70bJY5jgEiNMbXVhMmLOAsCZBn7QAKuizTFAcrbLxQ027Gx4I2k0NZsKuQ9LtZ2p5GWiPoSpT2rWP3cg0gr1lxNw5tYfr/l0oapN6nheVeHxQk4SKCaxQAXKtTxVv9uow76ZdERENF0pDcliJdM8j0Nvh4T4qxJWmsRTiFOOWPhWuMmEnp4hlJOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZjd2AJcsFaYi/nRk0zh41/cqrcDOBosGIW9jn0Zsbc=;
 b=UAfhclOVX2+nIacGd6b4AbEQ7SFz6xe+bCb3sv3LoglorV/7snKytbn9zrIXm+ktpOU2bEBb4mQqjCv4v/dmxRMWy/uJLTIzuP5hG4caGP+TbYQ+tEGuWzJDIWIM8OINMZag5Dgo+eenV+UHCyDVfFWeoFukiz2ZyVI++uLnyPQ1XGvi1/TGPPMRc7+rwdgNBBmPS7u/cAZVzl7YyhUQYnzI1Ci29DUMgFF+VVmZdDy0ldji8SlL3wXP6/07SRG/DYB4feO8eN3ZcUYvMbnbpaK4pESSvxlTLmFcwvvgUQLeNUTi87jWA8lvhFttZzxGGnVeoY6sgHHppuU7ltDn9Q==
Received: from CH2PR08CA0005.namprd08.prod.outlook.com (2603:10b6:610:5a::15)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Tue, 29 Apr
 2025 18:15:17 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::27) by CH2PR08CA0005.outlook.office365.com
 (2603:10b6:610:5a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 29 Apr 2025 18:15:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 18:15:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Apr
 2025 11:15:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 11:15:04 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 29 Apr 2025 11:15:02 -0700
Date: Tue, 29 Apr 2025 11:15:00 -0700
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
Message-ID: <aBEXJFnLalIh788i@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
 <aA_0TV0RkVOHk7Qj@google.com>
 <aBAEuP9962XweHPc@Asurada-Nvidia>
 <aBCNkcLp6XZpjYYT@google.com>
 <aBEWFw2wq40SHjTn@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aBEWFw2wq40SHjTn@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: a674492f-654b-4d77-92ef-08dd8749cb5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i47DZKPnZvI/KB+eNLyVsx6DYkeieEGt7G3z8pL0N/lsj6S4yRvhxqwjyWBo?=
 =?us-ascii?Q?9oOTAFK2D30mDayKNrCBtI+xND7nWjGd/qmhZD5F24bSsPwefqtnoboR5Whz?=
 =?us-ascii?Q?s1CL5wEfv63oo+lcCWUylhFi7ClcT5uB5nm1Z8+xk+t0qLKl7RDv0v3xmtf0?=
 =?us-ascii?Q?gk7JgpaFndQOjbxUT92W4LM3nvuGzoRcxFyDPzdwnyP7CxjoA+gcGv7K0Rf4?=
 =?us-ascii?Q?T7G3P2wWm5FjG6trRvaa6VOsXCfyMR+1IzyVSDPHmUSYa95rKPf7ihWBbReL?=
 =?us-ascii?Q?P8dzlp6NzrlHK6XiUCUHWqUqXJzPt0bd18MSkEyFofc+dMpN5dwh0H/B7RNu?=
 =?us-ascii?Q?foEva7R0rhzjlHEkCvjB2RE8eVlEyvw8vDO0ozwTKD0niWcE7eoEZiudZ1Sd?=
 =?us-ascii?Q?8XNUK7+v7IuXKH0A8QyLYayNzyg2WiJbFzIzyjQqI6APEsTTWCzOqJqamHq9?=
 =?us-ascii?Q?y3EOqbQfn+tIPh7l7e5ZijYOK20vzpcHizsUtqZmxChGU2RhBQyprxCF9KWz?=
 =?us-ascii?Q?tSz5krPnBF+lx1Y0mzNmpnsTBF0aSKdSxLByNP6EvmiboYCdMVzTA3It+sIy?=
 =?us-ascii?Q?ginMdShKNS7Qs/mHrDHcEvSzEl0eFSZ7/0pZiM0kB8T9nXHCOKk+MdxIAZJV?=
 =?us-ascii?Q?IAV5wDuFd4/B7Q0F/sUgIY7DGm3/Bvti6ebnmqLfcVj4YLEfAzaccXQu2qEF?=
 =?us-ascii?Q?tbbA1irt2tJvvXnxhN4lvLQY37OLSNIHj6CQYEjJmf28Wm6VeuLhoSQiuKph?=
 =?us-ascii?Q?kLDn3TOaDmomVHRoiGyYR3RYfXC7cbYgv6kmw2rZN11yDcBGLwG7ezjSmZYD?=
 =?us-ascii?Q?2WLc8teaZlXKWBlIbyjheEmcl07jDct6mEU0V/D6fmtkVKXt7h5USKFqIuHc?=
 =?us-ascii?Q?3J1sxvltePUOcmHbcFtuX06AvEtlKezye2nnayS6HDzPoxmAda6pk4TwjfxG?=
 =?us-ascii?Q?rMCSQzAwe7GGTbdfF1Yk3iiv1UW3AIG69GUAp1M084esS7rj1gmGNeEdofoA?=
 =?us-ascii?Q?7VnFrsNcKw+MiR4ouhMR3ZWOgBNxsNShPjalpH9d/k0LHNZWOGUtSmK7EVEi?=
 =?us-ascii?Q?SiRGNo93CrzoiEhX/xqwxWl0Ih2rkzOF1ea3wCd/X9/QZwBO4mwo+CXG/iac?=
 =?us-ascii?Q?BCMvf/HLE6ejuXz5RHPyCWYG/A5ialNZokG1QdV4dW9MO/ovrYe0y+UC4Wbz?=
 =?us-ascii?Q?ggUtr/dyWMydTMLgeENDnUQxXR2tJUZbTscbquxN39gliSjrf2jiC6d/V/Q4?=
 =?us-ascii?Q?JahSBLXC5mx+O0TTjRHGPx/wKsBQV1hJbEh7faykTyRUerI/WCQcLmJfDezP?=
 =?us-ascii?Q?nmUf2avQeCdQAQXyUYNYBcvonv+WMteGXZ4+vCsnJg/TZU3m4wVLAfHb28LA?=
 =?us-ascii?Q?9b84h/x40khRCL/mfoFxH/r/AvFpp62PRBPmhZpituGGbHV8X0dUstUsRat8?=
 =?us-ascii?Q?/2QGqSYo/dytFrX4UgYxJhzSnU/MzZpDMX3ONYdiIUZbmskNOg1GoOL7EITG?=
 =?us-ascii?Q?ke3VxSML2yuY/kPnzTPopVF71rWFg8kpFEV4?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 18:15:16.9249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a674492f-654b-4d77-92ef-08dd8749cb5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128

On Tue, Apr 29, 2025 at 06:10:31PM +0000, Pranjal Shrivastava wrote:
> On Tue, Apr 29, 2025 at 08:28:01AM +0000, Pranjal Shrivastava wrote:
> > On Mon, Apr 28, 2025 at 03:44:08PM -0700, Nicolin Chen wrote:
> > > On Mon, Apr 28, 2025 at 09:34:05PM +0000, Pranjal Shrivastava wrote:
> > > > On Fri, Apr 25, 2025 at 10:58:05PM -0700, Nicolin Chen wrote:
> > [...] 
> > > > IIUC, one vintf can have multiple lvcmdqs and looking at the series
> > > > it looks like the vcmdq_alloc allocates a single lvcmdq. Is the plan to
> > > > dedicate one lvcmdq to per VM? Which means VMs can share a vintf?
> > > 
> > > VINTF is a vSMMU instance per SMMU. Each VINTF can have multiple
> > > LVCMDQs. Each vCMDQ is allocated per IOMMUFD_CMD_VCMDQ_ALLOC. In
> > > other word, VM can issue multiple IOMMUFD_CMD_VCMDQ_ALLOC calls
> > > for each VTINF/vSMMU.
> > > 
> > 
> > Ack. I'm just wondering why would a single VM want more than one vCMDQ
> > per vSMMU?
> > [...]
> 
> I guess the only thing on this patch from me was to understand why
> would a single VM want more than one vCMDQ per vSMMU? (Just curious to
> know :) )

It gives some perf gain since it has two portals to fill commands.

Nicolin

