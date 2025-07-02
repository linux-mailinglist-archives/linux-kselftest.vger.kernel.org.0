Return-Path: <linux-kselftest+bounces-36360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E143AF6306
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 22:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D626E1C4537E
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 20:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49AC2F5084;
	Wed,  2 Jul 2025 20:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C8ZDUoQH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557682D373C;
	Wed,  2 Jul 2025 20:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487141; cv=fail; b=T2pKM7totEam4iAyYC97O7OO4KlqUwxta5v/V0eiCsB11RMIFUubye1NlasVrQKV9HXjuLy5OW+xKrSeHWwSsSEIAGs9DuS2zOM2AtkYVW6st+7gxGR9YTYd9gHFvMraSCdfK+32kOaw0/GcwVphVzRAfOmYsQbrgF+E2y/U1zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487141; c=relaxed/simple;
	bh=ErNtvOz3uOyLMAac7CSododLS/qr2nqXFf03rjHcyXI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kR7UVsbAVWO3bIeRM9zkapu/XU32Rzo5WlyMzK21MGawPOXXgvhDP1ilmP0HumpqhqSOCr8zYbKhr8QkUBMOA3NkN+TYgsfxX09VyrGsS45lZXlvmaM+Vjqmabq2BDzOTS1Yj6hVvnw1jRB59B/DXdRHAFy9H8xEf014XqSh0iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C8ZDUoQH; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBoF03w8xeNH6PiVkNtZsOeu5IgM9ohIM3AJSL6DEzfBiAdM6ZBZMHdeeRYyLOixf2WU5mqn27XPaNr+EAukTJdD0S5o0TUj8J7Y2kaVKaiUNNxaFTRwV53SGacxMIuUIMDsK1ulUW6GsqgluiK+za53xWuh1mjz7bd/6Z4Nn2jti4wjBfYgrorR3uKN5bgESaHTDCu0XSJh+AdBu03LHjkIMsROLPHm67T9U1dQM008gdvDNne7G6pYVeerke1Uv7KQ6Y6qX9eQ4F5XYyoyFlI4kKtuctxymafcuIKQg2AJB2pHXi1GgfW/QeXaqcVCjsDHSgJFvIJdHJg9k5iEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbuInP6gymCEIBLiH2j0Rf9KawZKOjf1n/X/Dt/Oroo=;
 b=TfnqNI0yaVsMNngHmS46lQcrcrhqqFhQmUmFGZTcXTNLl+C++e5mKd3SA2qctqybC+9G/fbBCPtjJanAAAOlDpiWjSMDGAKGOjP+XQyGFU5I1T6E3GA28EHhN+DigTH+IX62eASLCMPeTo04aWmY+1GuCcSqvIvHqM74Lu/NxCK5LYNdMXFtj7tH5z/BhLNSyMOAzO8kYteuyUGx7s2AMBWJphKhLAZYtBJajTCJqwvxkT6PTPvVrxwCuJ0duIJpbhCnQ1IYdFzlkCeKKwu4lbi45cVTQ38RK38u1aTetG91ngqvOZBWvto7IH6SJXI4SKj2v/+8jxx/rMCoHHz90A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbuInP6gymCEIBLiH2j0Rf9KawZKOjf1n/X/Dt/Oroo=;
 b=C8ZDUoQHtXcy6AcshUPleJrZA3QsLNrPjJM3EqZXjqu0m29OYVYYkGJOH1W+/Bd+Xrg63NRiILenTYbLHNE7B8qTAl9UToAtvJwK8kMHC6X522jP/CxoTjLgA/fsn40NFaGG2njfb9d5vqLbGVnzTbbWVyTB0LRdhVP2uVBI/uLJFDsbxWKGhmp2A49g8gUm76URxcBmmiOH4igkr1t8mFLT/U+y3XVJp0LpU4mPDEEgdqgqNHVFJz4ewfRRoaJ33ttdL871wLW/IuagLBUTIEjE90lFx/vfItKa/CHMpIWBkeQDF6Tl+9aIJ5q6ZlWzQ2ah3FKEZuwCpCk5u7/5nQ==
Received: from BY3PR10CA0028.namprd10.prod.outlook.com (2603:10b6:a03:255::33)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Wed, 2 Jul
 2025 20:12:16 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:a03:255:cafe::f0) by BY3PR10CA0028.outlook.office365.com
 (2603:10b6:a03:255::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 20:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.1 via Frontend Transport; Wed, 2 Jul 2025 20:12:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 2 Jul 2025
 13:12:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 2 Jul 2025 13:12:03 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 2 Jul 2025 13:12:02 -0700
Date: Wed, 2 Jul 2025 13:12:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "praan@google.com"
	<praan@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v7 10/28] iommufd/access: Bypass access->ops->unmap for
 internal use
Message-ID: <aGWSkRX4yUuuOVZ8@Asurada-Nvidia>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <a2b2a9704d7efff717448cbb76695e83f2fe67c9.1750966133.git.nicolinc@nvidia.com>
 <BN9PR11MB5276F03CF1E97173E711A5288C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276F03CF1E97173E711A5288C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: 3777f8d4-ffd3-45a0-2118-08ddb9a4bdb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?biEz0saaeLsQgaLF5v9e14FSTu94VPbWNLatu5HekJqJjqAGdf9x2k5nw3Ba?=
 =?us-ascii?Q?3wPfCpNqsf0zquBhj0dcnI2voka70BoWz+v/3DDpRgsd/D7QG4A+Skru02oE?=
 =?us-ascii?Q?UNyzE8EpFT8FpHrtmVGfq8p3qf0dCsteD5tR9Mq/KKjTB8uZvfH1i0LBUjJs?=
 =?us-ascii?Q?KsYGkvYK3uqhw9gvk+v+RX/fbuS4LS/cSoXtkJ/f4Cy/R7yTJVczt41zqJc1?=
 =?us-ascii?Q?rtwYyq6ooqlhCK9Jgq5dJqXN/xnknWHgV1YRFArFpDbopyzLAk+Y0k+5ro+Y?=
 =?us-ascii?Q?8gPjCMxLEW3dk1Om7KQl1/yfmkknSJ90ZvpceYSld7Ep9SyeNvimBbUQ2CgE?=
 =?us-ascii?Q?TYd/bGodvjItM1ehipnRxkVD/DibG/s12u98m9x9yMAf7YmQ3rL5fE0vSZfh?=
 =?us-ascii?Q?oYVAVWZJ+HGPSUtVbLqRPswOA7Tf3hAVsoIPbW6v6f3fH8FJIaNz0+GdB48L?=
 =?us-ascii?Q?e9JhNIe4yJozFsDWvAU85q+0NKJtvyb4CnjySqOleodpIlTUernzJ0N2K7j4?=
 =?us-ascii?Q?rMYegQk4PV+gwJjsoy8Evd8ZfwXinFCyI4Gv+VUWa2XEXakEwei6INp+U9et?=
 =?us-ascii?Q?c2r5VQ06QI8H11Ts6CIvLaVc/Hvy5w6JgGQ6Hz7pAzIRrUPBvFd1sdp5KG73?=
 =?us-ascii?Q?2S/+QaSkZxwl9cVMPsu46Uqs0hol+o17u4zHJGwYBHknQmHrkiymtVWlpI7Z?=
 =?us-ascii?Q?ItR5Tl+F+qWx8n5bqfwiG57P0k6gVFfT3PRYMSt3uwAzLJbCaqF3WGPLK5BT?=
 =?us-ascii?Q?okM9ZEknZ+E/bDz1aECcDv11V4KHRliYC4Ow7Mn8EqrAY6UyRQjFmrvbrNoY?=
 =?us-ascii?Q?h+ynoacxQ1xNBEJPSttiaf1iXdSnOfMX0d1kL925G+bLUWEMY3v+GFOSaw74?=
 =?us-ascii?Q?qXnMLmwrChjCijrH3mQ5sUFZQNsiwtoQlg+59+wo3PYDhE3LsjSuTE80i7Qt?=
 =?us-ascii?Q?t2iyUjeabfL2ifSAJI/VhR/u46Sy2oaXyqQfZe3JVtZDsKoP7qNyk3lq4WoG?=
 =?us-ascii?Q?kHT8O4xvBM4O8K2fHalwntLoTF6n6SHIdRRWxO6NA5jbKFssV0e7kHbgG+EW?=
 =?us-ascii?Q?6kZGuuFV2n/bkfPndtiUL824GUcOae4CZqDNNNhnXqDB/pfpKuicnCphH5MU?=
 =?us-ascii?Q?mo7HCipnlFVltcZwKSP+gjaSHNGI90n58+fLV12ESnNEKQPuM93jteTYQTgZ?=
 =?us-ascii?Q?+VJ30JmwY2SSO10aI6G8JpHz1Ijs6cV73WJ8FIeCZMV0DqiNabwq176ZPF/l?=
 =?us-ascii?Q?N2Gp6kXx/JoEkg9QzqfdeHoXksTQDl3RtSQETMOtXGoPAvjyDol4kSy4fm8Q?=
 =?us-ascii?Q?Tq9y/Zf54BplAP4g0ZF7q4eVjgSAJC7uT0RA70J8fdpwy9fJlM4DlXHjqrUL?=
 =?us-ascii?Q?1kbfD3+r0oTx/+2Vx1UC61ASWZr7S3Dntg2eoB2wppH5fzrUc4MM9Y+2NH7p?=
 =?us-ascii?Q?FtJ8PAdeSpEj3Yn0GCV172DAj94auULEBK0LpdhUrrc2unKVm/Z4BOdqiCJw?=
 =?us-ascii?Q?rACz/g7ycjeyCq7Km79yDU9sHZrsfZx1e0k6?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 20:12:16.4340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3777f8d4-ffd3-45a0-2118-08ddb9a4bdb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246

On Wed, Jul 02, 2025 at 09:45:26AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, June 27, 2025 3:35 AM
> > 
> > +int iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long
> > iova,
> > +				unsigned long length)
> >  {
> >  	struct iommufd_ioas *ioas =
> >  		container_of(iopt, struct iommufd_ioas, iopt);
> >  	struct iommufd_access *access;
> >  	unsigned long index;
> > +	int ret = 0;
> > 
> >  	xa_lock(&ioas->iopt.access_list);
> > +	/* Bypass any unmap if there is an internal access */
> > +	xa_for_each(&ioas->iopt.access_list, index, access) {
> > +		if (iommufd_access_is_internal(access)) {
> > +			ret = -EBUSY;
> > +			goto unlock;
> > +		}
> > +	}
> > +
> 
> hmm all those checks are per iopt. Could do one-off check in
> iopt_unmap_iova_range() and store the result in a local flag.
> 
> Then use that flag to decide whether to return -EBUSY if
> area->num_accesses is true in the loop.

I don't quite follow this...

Do you suggest to move this xa_for_each to iopt_unmap_iova_range?

What's that local flag used for?

Thanks
Nicolin

