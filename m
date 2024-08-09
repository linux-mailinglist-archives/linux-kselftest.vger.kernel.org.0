Return-Path: <linux-kselftest+bounces-15092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C6894D720
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 21:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47B51F225EA
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 19:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E5B15DBA3;
	Fri,  9 Aug 2024 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qKqiZkD0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE7223DE;
	Fri,  9 Aug 2024 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231132; cv=fail; b=bV1vglmTnBcs8TRVd++STsUMxPjsjV/lcTM0OH7xsiTpoI6O3y29ITlC3ChjF1o3+BVV2bFe5P8vMwpYfn8Z6vwB+/s41BTDNrbeDBbgfvuCHHqfvq3s2W2lkW2tFN3/8bomdVWF4N/Lx4AAZtZq3qFxh7ecbp8AhEG7sn3Cj6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231132; c=relaxed/simple;
	bh=dmIuULJfqHzxLCwkThoc7wEifor3KBkrru0Duf6VSKQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGMLYOY2yRL7Hq3O6foRwyW/Z1euWdLh8/qhUj3S+j3IRkjfWvCRP1zBP1Uz12mbkz+1TMvmdcWVIB6uATRwcXxOfO/oJQfD6tKEqhaBvSI9RAuxFtCMdeeRlsj5Dz8CS3Y4iQXv4vG53/ItHnW/dqvCrQGLtVUML9oaMw9UoAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qKqiZkD0; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4V4CbGhKK2Vq56ycYJ5WeOti4Kly2ME8mQB405Hx0TmSe/9n5g977hV3KC+lFI91FfZ0a1omhQz6osV/y2TJjtPYXBCKQchClWcFcFSqMZMHXqB/ICsRfIqLSJo58FjxN6GF2DFInjwYV355bIk9brVgyu/X33GD9arIY5MsZYErQ0qcyGs64qc4QFSvSOhq3efxAQZl8FB07TDQnd8bCq4f8u2fAGY7A5EK7cybrdplV6uwddF9K5HgQveIbvTFklv4ymZVju62o3qhcxB0uDZpDPBXmRUXMf+oH0nziIhYE5O0tcs4FquUoCnztRVwGbpfM2qL/SEBGW1SOHHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ma8qwO2GL533vXzC+U+10OveH3OvTmjrNzXj2LmSZCc=;
 b=o+vq87LFfjO9uw2om1SSG+wZ7XAU+axeSijdUGmhAQ5uZ3oU+d4jiYYO97YEU+NTsHGnkW3Nyid7e0wc3v6aFO5hROgQlxNLWfO6ZEG0vztJNmkZ5rao7QCbrG5zGiYbqs0ZACQ1O9lyD1ueIbb5PDA+DYD0R7jXHbt1cmDyyZHnyl4wG5pLOCcPErpKiqbZPNnSJgy/h4PgTf63qTamXmwwH7PCPigY49YnSJCckC9+t+ImKyafpiAqwBlq0JKf9JAMTXfvqUzXY/NxPPm2jGvNGix6M30E5WmPd5HclRjdVAK0qmt33UVTvXlPuuCfTaz80HFBcyXAsoi/NdgrIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma8qwO2GL533vXzC+U+10OveH3OvTmjrNzXj2LmSZCc=;
 b=qKqiZkD0aqi2XCuWO+h933/y9QpJCcHeZb9lAJVBvlqWn1jItTIMZTqMrKjTgFMDMt9Udh56II8QllXDHZm1FIE+xMMvwXasNlio90q6fhA/njCpS9hZKry7rDjc0eRD3aLBOqvcyk904wsEMJrs9QZCUwH17q6Yw+NAspFnuNXyrfLUuRGCr4rMlp2VspsRuVd/FsQGCnSHSD+ylBaNmOguGVf8NUaIlYfBfRkEBcNPaHuMd8Zucs4VLHrLfmXBUaSwLV+rJX2MZHZIsx0zqsttvzAPe4aOAvE+5RJfWK+TevY5ICW2o9o3QEB4kG/V2Uug3ZCYs1eXbU9wnV8U1A==
Received: from CH0P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::19)
 by DS7PR12MB5838.namprd12.prod.outlook.com (2603:10b6:8:79::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Fri, 9 Aug
 2024 19:18:46 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::b7) by CH0P220CA0001.outlook.office365.com
 (2603:10b6:610:ef::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.27 via Frontend
 Transport; Fri, 9 Aug 2024 19:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 19:18:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 12:18:44 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 9 Aug 2024 12:18:44 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 9 Aug 2024 12:18:43 -0700
Date: Fri, 9 Aug 2024 12:18:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iommu/dma: Support MSIs through nested domains
Message-ID: <ZrZrku/Av/y7ID0w@Asurada-Nvidia>
References: <cover.1722644866.git.nicolinc@nvidia.com>
 <b1b8ff9c716f22f524be0313ad12e5c6d10f5bd4.1722644866.git.nicolinc@nvidia.com>
 <BN9PR11MB5276E59FBD67B1119B3E2A858CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <6da4f216-594b-4c51-848c-86e281402820@arm.com>
 <20240809184136.GL8378@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240809184136.GL8378@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DS7PR12MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b4a966-b548-47ce-0da2-08dcb8a8171e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xbpaA1r+8WCrDl/hpjZ1b2sJs6gJOFarDoZ2mVbBecbdtpVb2BanCl/J7jhf?=
 =?us-ascii?Q?Cp4F8ZqXNormyOyL2bMlFC1Ik7rNiCMfUbSLRe1GHD4A9GhyJUoH3tH98Yg1?=
 =?us-ascii?Q?3+G1jnQ47XVH25wtWRbOnZjUiekVANXzqoAmc0086ltpRI5Q0aao+/P4bKt/?=
 =?us-ascii?Q?c4HOmEFyXH5eo7HDzWaMKHzGTE6wFs0cEHRHuttc1cXAV1HyjfMhJQj7nU7w?=
 =?us-ascii?Q?/GNpPIav5DbOYTcBT0jJWtY+fEhOwXUUL1Tt17qUjf4/oCSFq/iSiAFolAvD?=
 =?us-ascii?Q?94TMlM/Gh7G1FjP1rM8Rtfqvffmp8B96vAu6uWWu7AXC/zlpZAbAKZ6Mz4jW?=
 =?us-ascii?Q?wr+i16mNOKFi1jNEbVcz+6PpITw5WoMRdqyBDSnfnWSfHv7D6BoGdCrImdaj?=
 =?us-ascii?Q?XwOnI8aDP/25z2Yy/VppuQc2YFO+8axur6+PhWmkYKbyksdfYA5ahH0QDL08?=
 =?us-ascii?Q?Fmpr/C1TaGG4TSJXFFm33i+LotH6mRRk4LlFZF5a45PeEowW9B2iCq6Eagno?=
 =?us-ascii?Q?iLH4V3yoE9RGUBBIouKVuErw3D99mKkECDOtDuLy+fodHnGIcFXRaeVK/+oU?=
 =?us-ascii?Q?TTq0iZdIHQS4Tb6GNHXW9n7MDKlQiQC+vhld916ex2NCrrwZh5hmLYTS8/6A?=
 =?us-ascii?Q?U1KMrkjUua1ouDmkruEcbCZKhS+n5Iv3ODleJZj8MOI3zURWE11Tg9i3sez8?=
 =?us-ascii?Q?LZ4aS8LcM7p0+DLQZGJykQEHrj8MVZn0q79C/rTvt+0hF0MGas7ToZ4X4gFd?=
 =?us-ascii?Q?RoiYzNYvgjqd6Z7h4msF9jFSVl3V01etGaF4nrTZMj4Ap8f/ZzGC4PKoMza6?=
 =?us-ascii?Q?ou2nqPwBiQ+38wZutOrfYI9VzrSHqmq9J1pGhiKX/DvSZ2Y1/c8GzBDyeQD5?=
 =?us-ascii?Q?yZ0VynGH3yuimsHIFljV+XftkoONXIoXi0FYconPI7uLzEFms/MCh9/GwymH?=
 =?us-ascii?Q?UmvN1pSnaPTU0sm1JiSu3FQq1i3AjReWJhYwoM+abHLx1ItFmwWIWMqPTr62?=
 =?us-ascii?Q?inq21PS9SL6R9gYxaiHxB2F6f7Y8A+NIZF6MtQC6foU9t8Ho/PDTVyGHCtus?=
 =?us-ascii?Q?eBsdRWdVVBvahIWA4Ljnl6Ifjz+5Cr9Ht4Kx3WzWTNitRBhr3TjY4l1g2IYr?=
 =?us-ascii?Q?Dm+DppaL3TRDx1qIwPikD7beWtWXwjREKnXVtkwLkS5ZfJWnxHizok/00Vg8?=
 =?us-ascii?Q?37CjpMj2M2+2bwymVS8kWBuCuunqbZE6B3JfFu7rQuPood2cMzhHzqTzTaaL?=
 =?us-ascii?Q?YJYp5ffqRZehujRM5ygAFlDB1zLTWuhKiReqs8zJWmx5bUR5cyI/FAexo+JU?=
 =?us-ascii?Q?7z0v2TvUiKpa0tNZsajFP9DgRbYzT3xgdSyQvYETK4qaeoQCBeUvLGg59wTS?=
 =?us-ascii?Q?iPCWzsNBLQAp8m+eDpjcqJ85hf0NOx/4i+PMo42GNANIviznQyG3jLBmagum?=
 =?us-ascii?Q?N0CHRIKmVRrhA9UdUwBJ1XbPL8t58kxJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 19:18:46.0379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b4a966-b548-47ce-0da2-08dcb8a8171e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838

On Fri, Aug 09, 2024 at 03:41:36PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 08, 2024 at 01:38:44PM +0100, Robin Murphy wrote:
> > On 06/08/2024 9:25 am, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Saturday, August 3, 2024 8:32 AM
> > > > 
> > > > From: Robin Murphy <robin.murphy@arm.com>
> > > > 
> > > > Currently, iommu-dma is the only place outside of IOMMUFD and drivers
> > > > which might need to be aware of the stage 2 domain encapsulated within
> > > > a nested domain. This would be in the legacy-VFIO-style case where we're
> > > 
> > > why is it a legacy-VFIO-style? We only support nested in IOMMUFD.
> > 
> > Because with proper nesting we ideally shouldn't need the host-managed MSI
> > mess at all, which all stems from the old VFIO paradigm of completely
> > abstracting interrupts from userspace. I'm still hoping IOMMUFD can grow its
> > own interface for efficient MSI passthrough, where the VMM can simply map
> > the physical MSI doorbell into whatever IPA (GPA) it wants it to appear at
> > in the S2 domain, then whatever the guest does with S1 it can program the
> > MSI address into the endpoint accordingly without us having to fiddle with
> > it.
> 
> +1
> 
> I don't have a staged plan to do this though. Getting the ITS page
> into the S2 at a user specified address should be simple enough to
> manage.
> 
> The bigger issue is that we still have the hypervisor GIC driver
> controlling things and it will need to know to use the guest provided
> MSI address captured during the MSI trap, not its own address. I don't
> have an idea how to connect those two parts yet.

You mean the gPA of the vITS v.s. PA of the ITS, right? I think
that's because only VMM knows the virtual IRQ number to insert?
We don't seem to have a choice for that unless we want to poke
a hole to the vGIC design..

With that, it feels a quite big improvement already by getting
rid of the entire shadow MSI mapping, including msi_cookie and
RMR..

Thanks
Nicolin

