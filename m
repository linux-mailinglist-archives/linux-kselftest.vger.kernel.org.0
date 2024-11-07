Return-Path: <linux-kselftest+bounces-21591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 709759BFD2D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 05:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27DF71F22BD6
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 04:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A188B18A926;
	Thu,  7 Nov 2024 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HVfkJiBG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC83417D355;
	Thu,  7 Nov 2024 04:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730952263; cv=fail; b=TwSBR9LzrAkRsoiy9O4dlwUujoD/qsA0O8B5w82jtmydoVbHbtukLhFxwGb9Zecy5nRwdTF5IGTTtf0VFE3F5OeeRB+Y8t7vFUfEq4S/UrtVcXG6di1k1UaUZ96WZsiGhmtaCHieGfG4TwrAVidxKwpfniLmzTwBp5M7Cc5oM3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730952263; c=relaxed/simple;
	bh=Zbp+JMnMXwsrqGHR6VnzXX41uQzKAFdKFwoZ3gaeEW8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3uCSADbeenLEPGcgHkf2MRnzVaSSo+8duNwNjXcdmb6zXCVJsz+zccx93DfRZllPdYtcP0xB7/a6vp1VjQVltps19WO+wrevMDBd1YCbCJbtI8xY9IOwj/KUoskylGcfcjm7tEFjHqy2WnUVpavZH2JKYV85ZO6STtfU28rC54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HVfkJiBG; arc=fail smtp.client-ip=40.107.95.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J46wkMXyQZoKDvrCVYEuf6C/TCcJ67c5XpXflbxVThQY+LiEvmmwy8olPNFDCrbmDgZNA6LUHC0Jyx6mfcGfe7J8NVI6mgoSF1aknAKvdzcbpY82UfJSGzME5MPWiT8c8AqFhCHro8QUoHEcCUw/3QZFUY4dhrKrdZFMRmi21W8el2vt872+BPlR9urPA40udnmcGLJGEYEblSl+I1AaAHHCisGH4DDwnPQQSJxSHVyJuPUczbeZAadb75ooKVRFR5au64x4oTUpdOuCFfd3MUYwdwRKJEJ218YLEBtgIpPOXAG1mcRLWXsajHUZLuEZcHyFcdkX5a6AFKl4QaiEow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X9rUaQdMQ/aBmME9MScxeedMtfk6+zS+QPYIrEuSQE=;
 b=BO9/lIGaSpIg1rc4ANeGPsTW2twJkFbfz+Gc9GeP7qBWU+/9jlh/xChSWhPrQbS/f3uWz2Wg68D31zTJ+xR28HyYgwQFX5mV9gFWOXCNdn6mTdru3ytzmUzqrXYYfhfPHs/HUQncjv/8ty493/TuezLciFV9xc4r2dFF2tNVbuZDf4VuZoa3o8SR74sF6wkZ6MwM3ZRtRnLmovh5MBBOdVlofmEBZ+Mwd9Io+WUza7cJFmAffvE1fqji0M2VWW5rG6LeriVIPaaR9ma6+/rMrwc83J2QpSZZoObSS855sDt+NVpKRTRLb8BNxlDhb0rrrWB/chj3GoXmfN2ODN/b0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X9rUaQdMQ/aBmME9MScxeedMtfk6+zS+QPYIrEuSQE=;
 b=HVfkJiBGqpA3bxrMe8ICUuqtjkkxYN6ybAUA70NAWxj/lT7B0hA5wx8W55igbVxy7HRzOTUxjdcZleyV/uRQK8EPBXWcSb4qw+ki+7HqqYsocOxB062u+/7dyYuL2f1v+Fb51G0oFN5ocPFXcvmfKHBP3pNGLPRBtOEK06ITVt1P9wJM39qiYgvZXl6Ko5gIN52LHECbUmr63h2j9D4XF0579Hu+NgInveBi/NLgXDADnfm/Mz7lYirbxEZKsHO/gQFYmf0d3YCaraVO83vMfIp3nHpMW65419/P4PczjoYAUlGMJly91swpGGeO1Gk8Q29nkSGbkYhS0ZpDzFP3Xg==
Received: from MN2PR11CA0020.namprd11.prod.outlook.com (2603:10b6:208:23b::25)
 by DS0PR12MB8504.namprd12.prod.outlook.com (2603:10b6:8:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 04:04:18 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::5c) by MN2PR11CA0020.outlook.office365.com
 (2603:10b6:208:23b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 04:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 04:04:18 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 6 Nov 2024
 20:04:12 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 6 Nov 2024 20:04:11 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 6 Nov 2024 20:04:10 -0800
Date: Wed, 6 Nov 2024 20:04:09 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v7 13/13] Documentation: userspace-api: iommufd: Update
 vIOMMU
Message-ID: <Zyw8OUTLrG3Yx+Yx@Asurada-Nvidia>
References: <cover.1730836219.git.nicolinc@nvidia.com>
 <7e4302064e0d02137c1b1e139342affc0485ed3f.1730836219.git.nicolinc@nvidia.com>
 <ZywQP3_TpdttuCy8@archie.me>
 <ZywZcSidYCWkJgrw@Asurada-Nvidia>
 <ZywyEUmL4HvM8B9v@archie.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZywyEUmL4HvM8B9v@archie.me>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DS0PR12MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1329aa-35a9-4ebd-fbc1-08dcfee140d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rn++p/ct/uakTl92Uu11DIZ6Jh/3FsX73q6BX70Tr+9K+ShJNxHzyJTH8MNp?=
 =?us-ascii?Q?VOTjEAX4F4w0eA4ZoqlDiPKiqWMJmifmxZahEKkfSDWzDiTqu5uwH/9Z8Juw?=
 =?us-ascii?Q?O1eyuZ1Kb3FN7xDaDfGnQ9JYmlT3M8lK89fZ6lzV3NbojR08ADMR6I1DzQha?=
 =?us-ascii?Q?EG/Favj3ojQwwwlPuG9cFpzclSwytQEsSIQYceFqnCmKdq2+SBh6aX2PLGNH?=
 =?us-ascii?Q?iJ9OMyZRvdK6/GppEq3OJleG7ELCY+IqnrlaDCs1rDuRlYIe99skpgBO7zAT?=
 =?us-ascii?Q?jSyedhsH2LhEH9mmfd46Da1Se2wypA4utO1YkVAwClXFwLb79ZpY2GuVM8J+?=
 =?us-ascii?Q?B2o++HgOXdYOToOgPxIuVMGcS5arDSNuRAcCEuKRnus23AfqlBi3jGRuwcpi?=
 =?us-ascii?Q?ux21i6mggwPkDEhNmy0HmiFQac30SDNIRCmno3Ke5Y792lJnHBm8vFXa2pSo?=
 =?us-ascii?Q?9roVsMcjJZ7AtZqSmWOGRNkCY6GmTcblc25L+1cTNVCMzViWztTitOHIwPjN?=
 =?us-ascii?Q?EyxnCEqzolXp+3bOPrDqtx+weuL6AJaQxuK2n0ostJb9VcZULPETn+Y2SGmc?=
 =?us-ascii?Q?Aad//fMLMt1KAI6B7JS5R+M7uWOfvD1nj13vkP0PKfLTaFWxPChqZNp0KNGb?=
 =?us-ascii?Q?2sE9PaZtQvxtsMJ2UdWQmv223yRYIqGG89aSn5oUqSg7Jt1fb6alYW8eO5vu?=
 =?us-ascii?Q?1h7kF9lNTKi2hjcMtHqNhI6bePnilqo8/tayYMnF9HlKnMdwnq/m2IEHCgNb?=
 =?us-ascii?Q?aNUv/23jW330+FQ5KlAWRm/LKglNWpBPZPgmparM5f1CofFmbbL/0foSVaKf?=
 =?us-ascii?Q?gOxBZGPeTi4nDBEd0oyDQ0qHBi7YCnc9PzjDKVMy5xedHnfRwXGQUeiZ4ATH?=
 =?us-ascii?Q?M49s3HEFMYBU6iw8VE/M0/aD1rshnfRrUtOhPYJ77v+o6o+EHVPTrjJa8/oY?=
 =?us-ascii?Q?YLMTzQ+ka1g1xa5Zoo/gF9/nKi7ZGpQuA3YOIPtXDpJJw6VLnC+Hh6IQk31b?=
 =?us-ascii?Q?DsAXwg8V3Zf7Qu9MxSEwqj16wLaJFLSWteleEgLXMSEQyapqh9bnvRTyfjAN?=
 =?us-ascii?Q?eWuC8Tpva4j2i7flmHD562DgsNrd/NjXkYuOf1K2E3SMyO09yM0GKTLvf4Uu?=
 =?us-ascii?Q?vRt1ryHlNlKIzXbPyO/6Qe0cxvK2ZGH6uQdj/Ii+8aYXW7FCEvLrcSYyDUIF?=
 =?us-ascii?Q?3SLf7YVc0yFW3ygc41tYHIreodfaiT5SnUYbAeTqeR2I5EJm7ywqIb8sqkEL?=
 =?us-ascii?Q?nsQ5bfv0/XuosRgEfI2f4g/X+qqD1JukVuljZrPPzWZmTVuqVmr83s4IAQfp?=
 =?us-ascii?Q?kodpFseb0DQGaTC8zdMFqnKSpR/Ips4ReFSw5TgFR4JxFj5v7B3AXI2kX8BP?=
 =?us-ascii?Q?d1eFfemaEDWDwniP8QA+9Kbdx3jYVm7NrKUqcGEkSQbmBQBYBQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 04:04:18.6870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1329aa-35a9-4ebd-fbc1-08dcfee140d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8504

On Thu, Nov 07, 2024 at 10:20:49AM +0700, Bagas Sanjaya wrote:
> On Wed, Nov 06, 2024 at 05:35:45PM -0800, Nicolin Chen wrote:
> > On Thu, Nov 07, 2024 at 07:56:31AM +0700, Bagas Sanjaya wrote:
> > > On Tue, Nov 05, 2024 at 12:04:29PM -0800, Nicolin Chen wrote:
> > > > With the introduction of the new object and its infrastructure, update the
> > > > doc to reflect that and add a new graph.
> > > > 
> > > > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > > > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > > ---
> > > >  Documentation/userspace-api/iommufd.rst | 69 ++++++++++++++++++++++++-
> > > >  1 file changed, 68 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
> > > > index 2deba93bf159..a8b7766c2849 100644
> > > > --- a/Documentation/userspace-api/iommufd.rst
> > > > +++ b/Documentation/userspace-api/iommufd.rst
> > > > @@ -63,6 +63,37 @@ Following IOMMUFD objects are exposed to userspace:
> > > >    space usually has mappings from guest-level I/O virtual addresses to guest-
> > > >    level physical addresses.
> > > >  
> > > > +- IOMMUFD_OBJ_VIOMMU, representing a slice of the physical IOMMU instance,
> > > > +  passed to or shared with a VM. It may be some HW-accelerated virtualization
> > > > +  features and some SW resources used by the VM. For examples:
> > > > +  * Security namespace for guest owned ID, e.g. guest-controlled cache tags
> > > > +  * Non-device-affiliated event reporting, e.g. invalidation queue errors
> > > > +  * Access to a sharable nesting parent pagetable across physical IOMMUs
> > > > +  * Virtualization of various platforms IDs, e.g. RIDs and others
> > > > +  * Delivery of paravirtualized invalidation
> > > > +  * Direct assigned invalidation queues
> > > > +  * Direct assigned interrupts
> > > 
> > > The bullet list above is outputted in htmldocs build as long-running paragraph
> > > instead.
> > 
> > Oh, I overlooked this list.
> > 
> > Would the following change be okay?
> > 
> > -------------------------------------------------
> > diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
> > index 0ef22b3ca30b..011cbc71b6f5 100644
> > --- a/Documentation/userspace-api/iommufd.rst
> > +++ b/Documentation/userspace-api/iommufd.rst
> > @@ -68,2 +68,3 @@ Following IOMMUFD objects are exposed to userspace:
> >    features and some SW resources used by the VM. For examples:
> > +
> >    * Security namespace for guest owned ID, e.g. guest-controlled cache tags
> > @@ -75,2 +76,3 @@ Following IOMMUFD objects are exposed to userspace:
> >    * Direct assigned interrupts
> > +
> >    Such a vIOMMU object generally has the access to a nesting parent pagetable
> > -------------------------------------------------
> > 
> > The outputted html is showing a list with this.
> 
> Yup, that's right!

Thank you! Would it be possible for you to give a Reviewed-by,
given the condition of squashing this diff?

Likely, Jason will help squash it when taking this v7 via his
iommufd tree. So, we might not respin a v8.

Nicolin

