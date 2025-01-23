Return-Path: <linux-kselftest+bounces-24977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55E9A19EAD
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 08:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2213A4943
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 07:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ABB20B21F;
	Thu, 23 Jan 2025 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qCnuGAX9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94BD20B208;
	Thu, 23 Jan 2025 07:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737615800; cv=fail; b=QCTEQOsTOnnY/IAhvOvS+JZ8JaIVXaTGgiNLIe1MbhWb2DFjyfTF0rd9ZUJ9VZ9pu8qBQ0zFleYg78CkoXV6KTlgAQhJFCSQiw0UJ/u8kIz/KjksLHvSOV00Of4ClYDxxHgw5xxRNYc+o0XIO077szGxGPPn84uXb0mOAye1iG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737615800; c=relaxed/simple;
	bh=ByRJjAdldrDy7l+2uk0iEbjWhzGArjK9yAdxfikqPRM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQqGw808Z5R1LfPTUuwLyLrd1xd+iuHMETzDchblAMBTSz12Aj1jVd7ynYqaFEGB0C6hPzN19uRFL4aolo9dLsipyMwO6w/yEe+d9jG4WbKxUGUHy2VOtIxQ/C1ta2BbM4ARFv+cknjLPlIMBLB4NUvwnWq7goy0pv+fNjMLn1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qCnuGAX9; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hI8f2fIetf+WUXjJj22guRSw8Iiq8JLL8AJ2e38lHiUPqVQIOUd4esfyNrfgOEokjcIlj3dT46r7y1pg8mpPiAAuq+/31Ogv7x6oLwPssd0PL2RMeY+Cq78PHBRZvJggToNLxFFlLjFMYaE6aOymBpKNAJySNHVayPzixQyK3M6REZZVNn59QC/5Yr2FaosymD1e7BuFt4kePdmJOZQGaFhdDO8DdetrXxTWkKAdre/NB4z57G7gN+XFUzxJkwjXoY4y5S1B7GUYNjny45nBHnE3zpIuNbjZQ/385mGDfPxl/XpaFOt3vC3bZO6ybFc/+hgUjHXKvmF4fm2zH4T9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PUDWflv1IsiwIz6s7j0WbLrVTgZNrVXZBwlWJYex78=;
 b=IYykq2JFYu7PH0fGW9ihJW/lPUH4p+LEqt53Us9x3BzUXDH1kMDL+bWXmoMqhHlo1bT6XE+XzEZFcWUXMhuz6BeW8bZSJwSwsiju14V7Jb36uQd0CW4FPT+DXQWNzxuiJghdQNm3LryuXM/tHO8kkd+eXonjMkEZSPHUYi8cE6h0CPnbK/C+xM65eXnjyc/VgXkDlozq3+2HoTKwAmEeALu1r+hCSw67rd6F9wET0pEdflo7/XGWiYLHJ07qT+xjDR76o1MY9Wy+QNGekYHoENC0pD9RQ+mgj8P03fJ1BpIkxN8PBtiPZraqHWAn1LBRzVYrX31W6e/sZiBINqL1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PUDWflv1IsiwIz6s7j0WbLrVTgZNrVXZBwlWJYex78=;
 b=qCnuGAX9X5Y1pMbmZ+sztVYMZ75hafD6kQ/dJVnyL41lf8IZBChZAV9zAH5VGcKUwdbu3NqFeji0p3lyeZQt0SdRsxi1vJddtELM9GILpVmLwNjeRQn5Huli/fvLzzWpH/Yo/2tpz58JCUAFZN0dpabJuThQCHyLmsnpeUGahizkHFAMPOObpKwiM+JZAEiLRBk9b/vchMVW/caGHNRKneDAY9+JVqjTcPrki2GmENPewtp6r6n0odzeSlBOMMeSiUbapOiJeWMQlGtuv8xgYxxhFwNLCnXscY1oy+Niu6Ivhq6wxgTiP1puxi7NuKsKXLSaeIHr8OCNawnZ2zOfDA==
Received: from MW4PR02CA0022.namprd02.prod.outlook.com (2603:10b6:303:16d::15)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 07:03:14 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::eb) by MW4PR02CA0022.outlook.office365.com
 (2603:10b6:303:16d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Thu,
 23 Jan 2025 07:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 07:03:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 Jan
 2025 23:03:05 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 22 Jan 2025 23:03:05 -0800
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 22 Jan 2025 23:03:01 -0800
Date: Wed, 22 Jan 2025 23:02:59 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <Z5Hpo+Q6gcwc0+r6@nvidia.com>
References: <20250120181854.GQ5556@nvidia.com>
 <Z463eXfgNArCOfPn@nvidia.com>
 <20250121183611.GY5556@nvidia.com>
 <Z4/7pGx6F1mpAUuV@nvidia.com>
 <20250121200924.GZ5556@nvidia.com>
 <Z5ALWFVTOSC/8+ji@nvidia.com>
 <20250121211404.GB5556@nvidia.com>
 <Z5AUNVHzJPATVqAY@nvidia.com>
 <Z5Cmvfp4JW9vmMTP@nvidia.com>
 <Z5Eywl1o9pdYyuQO@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z5Eywl1o9pdYyuQO@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ae463e-10ac-4ff9-b4fd-08dd3b7c0161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g6n46JD4XoLiSogMFA2PIlth23m2HEgxWU/Dkrw2sRCRVer6O1/nSSjHn0On?=
 =?us-ascii?Q?oZAmNcKVCLUg1zZ/nKPwyN0MHmEooJiZvnnO0bOHhN3Gj5bCT1w1z0Yq7MtH?=
 =?us-ascii?Q?Jy8QcHn6fPIDyDZgFBrBIy8HHx16fPsZRryTakILATTog9lu+50FrA66SjI8?=
 =?us-ascii?Q?eAzYtQDoABlCimmQ6bN2c+EijEFL8B+MQQPg6WQ/qf2bEqE6xC82oC2PU0iK?=
 =?us-ascii?Q?5CXwq04FQZX/y/fMbWE0vDQsxmxc3WqNXZCtI4fhu+XWu1z9kElUnwBi/gem?=
 =?us-ascii?Q?+gtLxyok4J7LtG1aTfQC0kXNLVy43m6+DwQ3xIy59rHIC56oDL0rhZQexGUs?=
 =?us-ascii?Q?TiYRN3lDGbUObNDU1DPbmmyc/5BSOGwcLbuxxx15vxsPYwXFPybQq9CBp59k?=
 =?us-ascii?Q?kyFtAPJ9JwltT0yUpSEFq4s+2TzcHmJDoJYbZeJDhioUS1UJpcIydMY8sYNl?=
 =?us-ascii?Q?Gz71bBwNbSp8704TF5+wazs6BgwtBQDgLS7TiOMjMXyV/KrS7O+mWWwagrPc?=
 =?us-ascii?Q?USqlbK+VrW556Raj9rFwBv0PwE14ofqI/QML8JZYwafjCAUmIiOer2oUke9a?=
 =?us-ascii?Q?deWkN+pdjxJ2G47eqwHJgmb5eD64AC3p3qLep0JUV89ACm5XaZ0eXMSyxbTl?=
 =?us-ascii?Q?f38sj5d/8Zm3VUwHMK6Nd2xwxJ2wBkAizg0pM5FtJhuDUKE+hA93ZE1Ig9o3?=
 =?us-ascii?Q?igonZT8HR0Ch+ECBvDLNvz0IL+HO3Jbwhpw8QXkojXvEpTdOiXWa4j9SSKmf?=
 =?us-ascii?Q?PMExCAzhx6zmAqRDEx1aOTSRqyAmIvoinV3z4DWJjyr5c8nGuLOuVrhC94ym?=
 =?us-ascii?Q?STZAlUV/SjxsNItEqNtS772JvpTIrJ2WlHM0DTGpajqoZNQ0RvWn1OJKChJr?=
 =?us-ascii?Q?Eg35E6TSZTAOuYePhx4O+BtGk9PYrmKJ7dlgWQzR3jVwztMpJ4KLXZu/B+py?=
 =?us-ascii?Q?OkQYTv8fIi/5/9hAAy68qS5l4776NzxwaZR0J6wmEeNpQm1YnEGXw4JPm86W?=
 =?us-ascii?Q?FwHj9I8QsqCLRW6BS15LAocpfQxh9skOnuM9l6fO4cGqKL2qVww7r8mG3ZTu?=
 =?us-ascii?Q?9u3q/vq3f4dlGBxIMKubWxTUJBTBoGxFYQJGal8cM4L5gMNtL/VS8ENN8cZM?=
 =?us-ascii?Q?vkIOudTj8J+NmMJoEbPBsZ4+Zi6bfQVoM87yJtJWtJ+t4Bp8196mJEOATcbC?=
 =?us-ascii?Q?XuPfXFw1IBUSieMSJ2Jbl6QXEdJ8cq8b6UPParMakuHV+ypjqmKoLZLewwgf?=
 =?us-ascii?Q?N79zpldIpyEx7ysm8mHebYGIMW+roRU+X2gj8Qvs1N8rcIL1LXEQlcWkptV3?=
 =?us-ascii?Q?zbQEYy9PZF9fxt9KOYyFaEQvQJYCHoiDpJ27nRcCFF71+4ozk0+XapDnnhFi?=
 =?us-ascii?Q?FBa6rp+90+G4+Q3OC2IORTO/Fc3HYZ8t6ueAVSk93wWV8pgzdWZAbKJZKSde?=
 =?us-ascii?Q?lFOf/RtskL6/8vU7D5ynJHKFHfqdJN/rfhti6ddWFGN2xgWauYCxygFdihtH?=
 =?us-ascii?Q?xTCMqE15z+p41nI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 07:03:14.0861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ae463e-10ac-4ff9-b4fd-08dd3b7c0161
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393

On Wed, Jan 22, 2025 at 10:02:49AM -0800, Nicolin Chen wrote:
> On Wed, Jan 22, 2025 at 12:05:27AM -0800, Nicolin Chen wrote:
> > On Tue, Jan 21, 2025 at 01:40:13PM -0800, Nicolin Chen wrote:
> > > On Tue, Jan 21, 2025 at 05:14:04PM -0400, Jason Gunthorpe wrote:
> > > > Since we don't hold the spinlock the whole time there is a race where
> > > > we could pull the overflow off and then another entry could be pushed
> > > > while we do the copy_to_user.
> > > 
> > > I see. I'll be careful around that. I can imagine that one tricky
> > > thing can be to restore the overflow node back to the list when a
> > > copy_to_user fails..
> > 
> > Hmm, it gets trickier because the overflow node is a preallocated
> > single node per vEVENTQ. We must not only check list_empty for its
> > restore, but also protect the overflow->header.sequence from races
> > between atomic_inc and copy_to_user. However, we can't use a mutex
> > because copy_to_user might DOS...
> > 
> > A simple solution could be to just duplicate overflow nodes, each
> > of which contains a different sequence, like a regular vEVENT node.
> > This certainly changes the uAPI for read(). Though the duplication
> > of overflow nodes doesn't sound optimal, it's acceptable since the
> > duplicated nodes would have been regular vEVENT nodes if there was
> > no overflow (i.e. no extra overhead)?
> 
> Ah, didn't think clearly last night.. We can't simply add overflow
> nodes either for rate/memory limit reason that you concerned about
> in the other email. On the other hand, though certainly not being
> ideal, indulging the race at the sequence index might not be that
> harmful, compared to the extreme of the other case..
> 
> I'll give another thought today if there's some other way out.

I made a change to duplicate the overflow node in the fetch() that
is protected by the spinlock, which is used for copy_to_user. Then
the other routine for vEVENT reporting, protected by the spinlock,
can race-freely update the preallocated overflow node.

Nicolin

