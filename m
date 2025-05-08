Return-Path: <linux-kselftest+bounces-32641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A10CBAAF1D5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 05:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0301B6807D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 03:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8256F1F417B;
	Thu,  8 May 2025 03:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TZt/lTNZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8E317D2;
	Thu,  8 May 2025 03:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746676208; cv=fail; b=qjKLJPeKwYgAXl6Uim/OBwXcSTKejMHi/nv+Yl7mIHDkRVxPTfvm4j5JlhQsi/SjNkfvFbixBffCM0FjCqKtPSvjDIxp7XOIGHEC15s9Y31UvRtyKNGqcmKsMjXduASkxh1Hg475HJbSdAcFzimf7en7pus+O9bUI858aLXGsAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746676208; c=relaxed/simple;
	bh=DVgXe5rlob5tKTyDt4ZQLwPTz4CQTftwFWS1sp1KQMQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ovn3kU2SFAGsQwImLUPL0fxKA5uOCndrx94AiDtCSAzky83Bz/W/9dKhb3uSy1JOiri9Z9e7v3aTLWkt8yJ3GJ5cBFwj9/2VOG3zBjdibY30BNV3apVDoCp+qUmzTIAU2EkS24ejtCdd1WNLZUycE32XHPaPCA2i9taalLCiXnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TZt/lTNZ; arc=fail smtp.client-ip=40.107.96.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a75N8MVidv321ugN13ysnsIuwK8fW0PJaKpB8P5T6TQ+O9HoXLbJjYGWiFDwR4FDzofuYMieVrRcMpQe0L2I0iCq7i5In3inP6jLOXItB8pVrsNoCQ0XZFS18FabJodNFYzkSEehOJ+eLEnYbQaoBB5BQCBI7pj4mmKxyj7lzmUkpeyEY+wZo2O8Jlnqm+NJ46SIUEaSgziehwhBWnXvgAoVH99l4waxv6W7Ivum5LWd3SaZklkFjU0/3vb1Q0JvOxndgfyAXmKdVEv2G5JOS54R4eqay48QN8Q34NdWR2RCbRnyHGZxLnbAVopCkWPnfDwDup38p3oqI3bHooWwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I10NWOjUoVDEV6omEiiwULNqIIMK6vUbjI3f2khPkFw=;
 b=Uo3p4xlvl3YqFHDi1aRiRCPjm4sbcazg09zZZlOf1lv0ncgoOfHOOY25GlQo1/QQrQ8ca0eFJrkrgh3PCJu6oLFigVFBzIN/MLwbN5r1omqcMqK1ThzqO2dyENTAPlmPYKuFupeAqo87fgXibtpEIGQVj1J2AecuPvxdnsrXE2BzVgzFbwxa6wwmhglYsrlMPwu76aiE4XeGkznc/lnyloOfWXl067+bcpIbjMyl7R5+6gEBgP6fDeaL/N/rfUHYVj1mugWC1MhIkwsAg7DanWCbEB9tkjuL8g6IR/DCFXPelKYFD60Nu+W24fo47vhvbTcuwFd4ytukYW1XqPHamw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I10NWOjUoVDEV6omEiiwULNqIIMK6vUbjI3f2khPkFw=;
 b=TZt/lTNZctQOSighJQQkJ0zfg+H0TjsIzB8qrXxep81U6+elbdnOymg+c5oyoaU0ZUtdSRhSgw3TAGA3MmTAXUjAsClh1GRl2QTWFr8jgjZh+6Cg9mV2+YSTIZrru1YGYDk7QkWmL1Q6xJCg2uEXuJyWc9Upsd85I6FCiugofOuQgc8kQp5+9/OCL+FxNfPBxYmZf58i1NKqsvl8bLTOcfPKomy3NwXZ2g5w0KyMDGpixoTIN3T2WIb6Zy+rloI7eMIpcr7RNZnJ+caedUkyKGrEk+3diehySdBKonM0+UgrSOH8q+ZkmNbPalbL2ooNz3IKVszu53WctVsFaqagKQ==
Received: from MN2PR18CA0024.namprd18.prod.outlook.com (2603:10b6:208:23c::29)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Thu, 8 May
 2025 03:49:58 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:23c:cafe::71) by MN2PR18CA0024.outlook.office365.com
 (2603:10b6:208:23c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Thu,
 8 May 2025 03:49:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.3 via Frontend Transport; Thu, 8 May 2025 03:49:58 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 May 2025
 20:49:53 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 7 May
 2025 20:49:45 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 7 May 2025 20:49:39 -0700
Date: Wed, 7 May 2025 20:49:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Pranjal Shrivastava <praan@google.com>, <kevin.tian@intel.com>,
	<corbet@lwn.net>, <will@kernel.org>, <bagasdotme@gmail.com>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<jsnitsel@redhat.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <mshavit@google.com>, <zhangzekun11@huawei.com>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<patches@lists.linux.dev>, <mochs@nvidia.com>, <alok.a.tiwari@oracle.com>,
	<vasant.hegde@amd.com>
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <aBwp0JviKskqbPXz@nvidia.com>
References: <aBFIsYg+ITU8RvTT@Asurada-Nvidia>
 <20250505165552.GN2260709@nvidia.com>
 <aBj1Av6Xaj8flMN+@nvidia.com>
 <20250505173101.GT2260709@nvidia.com>
 <aBkWoH23VysYake3@nvidia.com>
 <20250506125222.GW2260709@nvidia.com>
 <aBpjbtRgR1nK/LIm@nvidia.com>
 <20250507123901.GF90261@nvidia.com>
 <aBvMC7dnYghoX5Aq@nvidia.com>
 <20250507220809.GB232705@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250507220809.GB232705@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|MW6PR12MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: c8eab009-aae4-40c3-fb27-08dd8de36708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3lLuynQOwGD0PpVfsvvho8wjzE7kEGZfQJ6jdBXHohawe9FxHJXX/m5qkRED?=
 =?us-ascii?Q?+FP7/os1fuV7CWpkXaanA2SB+mv/VhBrdEW5Xhfabg2bBGegD9uJ/SkBFs8D?=
 =?us-ascii?Q?Qh+vbq0pxzrENqu6/zYDzjdUnq+479otuD5yh4s+3ahKY/C66qGYXbCEUX/I?=
 =?us-ascii?Q?eQnM9NISNirnm9FJVIpL7rZ80R8jobcgygh1iofWORRumduPFHiQNNVIYfwM?=
 =?us-ascii?Q?qbh5pvww7TjeBo8PB5R2uJoh2otTlvFuev3WAGeNYmkKRwmHpeIgGu4tj8aO?=
 =?us-ascii?Q?C+h/f/1Qt0HBGe67G+btk0HlqJnEeWNlOW2dC2Jn3CVBGqmH8NKd77+oNH7H?=
 =?us-ascii?Q?u5cdRzh6s2zFV+zCgrliGo/ozsgmFv34lZMz1a9bTwoBMeidYwtQblzJOtj2?=
 =?us-ascii?Q?PCQVTl1jbRsHLqX7men3G5I+QW8///iBi7eEHDzvywGfhcUyp3A992DCY+Ek?=
 =?us-ascii?Q?62sTKfmmXKyMG54MEcfDd5cyw61ojRO7bbyWaXoed0bIp8bCmKZDbXT6ZBSO?=
 =?us-ascii?Q?S1syChUNLWMp2SIKGY3+tFEBe7OVKzD4zRHReaZGy5jYYPYFQ42R8IZDZwWk?=
 =?us-ascii?Q?dYueC5MmoE4mXvDrFc5unVzVZA3/sFV7zwlctlQpE6vXRONvPfNbBz4J/gfu?=
 =?us-ascii?Q?kAhJ3OeXKoHwZ2PwPf23Qq7iyvScPPSDrNFaD3/YNEhGSJ6u6GsDGDtqjZ3X?=
 =?us-ascii?Q?otemllEOrNaKVLtJnKqoqpaJzJNqOegNQw/vNJe5QvW+lI2NyPRNexFv1sa6?=
 =?us-ascii?Q?bdv0zJhNIyHZXicituDYqPi59Wf3DE17GfytnQ8Lpxo35ceLv9nLhZD/ZNQj?=
 =?us-ascii?Q?Eb03OIzi1qaMl0NMsWrK6/f84zMXqnVIGqf7uM6qFlg8AINWaefH1MMta3La?=
 =?us-ascii?Q?5uYnKrnG7/QRgYbKYU73boANeFw00Ff0yef3DWzFXYu52REC6+PzkrLCYw16?=
 =?us-ascii?Q?lRSGdDArYOJ9y6gUWh4iaWvmdT+BQGjJC2osZJ6vBnU6fsK9Muv5RgJheFNA?=
 =?us-ascii?Q?4mA/stSUbXlMwULHP843HH0wATDyhyZ8gI1xbinMDA5AoP5+H24jyuBpB1Cd?=
 =?us-ascii?Q?yOxPngSvlYZ+Crp30OcCy+F3hUETapgVr9MJaOvRWIQYfPCnm8uoyjl2ioPi?=
 =?us-ascii?Q?6lLMPDmzllbaF1tDpuea9F+yxoM4qptoy3gJVZOariObynrlY+qHUvjS6x9H?=
 =?us-ascii?Q?X8imIihhZtNUFt0yU5gHTZutH4dQUXu8GiDncHvr6lUzMnwMjPYpFdcGvD25?=
 =?us-ascii?Q?nWKOdkMzGovE7RS3U22mlwhtxrYZUGOHWG6fZPpAK6eIs8WRvYX6RzqMZqFM?=
 =?us-ascii?Q?+hQ+tGe5Mk2Y50KLzGRanaUyTDiWkqhbQ444ahFf1Am5f8aOmsewNG2IuBgr?=
 =?us-ascii?Q?oqu8Zaqf7iUnmO4iUIGsw5QJ7YNUS3ic4trtX37ivHSNjKLIIl3PXknZioCN?=
 =?us-ascii?Q?kddeJRsIW/PSDVdwymlEfQ1/dRpQuFhtYbq2LW5Dz8j++r8BerxpJe8Ahw7Z?=
 =?us-ascii?Q?xvBMkmCkVH5VX2DiRDYtAJP+cHiiy8A+2TBK?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 03:49:58.0233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8eab009-aae4-40c3-fb27-08dd8de36708
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736

On Wed, May 07, 2025 at 07:08:09PM -0300, Jason Gunthorpe wrote:
> On Wed, May 07, 2025 at 02:09:31PM -0700, Nicolin Chen wrote:
> > I have another question: while I don't think my code is handling
> > this well either, how should we validate the input address is an
> > allowed one?
> 
> The pgoff to mmap? If it isn't in the maple tree it is not allowed, if
> it isn't at the start of range it is not allowed, if the size is not
> exactly the same as the range it is not allowed.

Kevin suggested to allow a partial mmap, i.e allow the size to be
smaller than what the cookie describes. Yet, surely the mmap size
should not above the allocated size.

> > Because mmap() is per ictx, i.e. it's a global translation table.
> 
> It's per-FD. The pgoff number space is per-fd calling mmap.
> 
> > So, the following might happen: let's say we have two vIOMMUs in
> > the same ictx. Either vIOMMU has reported a cookie to index the
> > mtree for the real PFN range: call them PFN_RANGE0 (for vIOMMU0)
> > and PFN_RANGE1 (for vIOMMU1). What if a buggy VMM inverted these
> > cookies between the two vIOMMUs, so it would end up with vIOMMU0
> > accessing PFN_RANGE1?
> 
> Oh well. That is too buggy for the kernel to do anything about. The
> mmap cookie comes out of the VIOMMU_ALLOC call and goes back into the
> mmap() call, if you mess it up or mix up the pointers then too bad.
> 
> But if two VMMs are doing this then they each have their own iommufd
> and their own private numberspace and VMM A's VIOMMU cannot be mapped
> through VMM B's iommufd FD.

I was concerned about the one VM case, which uses the same ictx
and thus the same mtree.

So, an address translation table (like IOMMU) has a separate AS
(i.e. iommu_domain) for a device. This can limit the device from
accessing other device's memory. And it would be ideal for this
mmap interface (a translation site) to do the same.

However, given that it is a global translation table, we don't
have many choices for the isolation, but only (as your remarks):
1) Check if the given vm_pgoff is in the mtree
2) Check if the given length doesn't cross the real PFN range

Thanks
Nicolin

