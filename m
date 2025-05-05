Return-Path: <linux-kselftest+bounces-32365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DFAAA96EF
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B43418853A9
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BD525D1E9;
	Mon,  5 May 2025 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rFjmhXJP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD6258CCA;
	Mon,  5 May 2025 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457345; cv=fail; b=drusKNIYUpuNyrlYocnLs8B68sQBgb70+F4yHB92rc6P4Ll5L1N5b4VOwYoXIR7wd9HVOIT38jx8ozmp1+mkT21o053kJAu9RrqZBvJ5/VLuu+exUOgl/o+yGBQm0HJI9LmYkKO511+gdioKio+ldVdu2tjBioZyx8Cx00tg6eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457345; c=relaxed/simple;
	bh=vIT96vVOFrx+fy8/DOhWzLo0SQhPzMThA38hBQKQUIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q+JlOuQinpe7wRJwzPCGzz3qs/sodwzeux7kprAn/9MzHAfqXFIb9ytTjcAB1X2lLgifUMlmlOZtmsm7eOsmExnz0oL4jF3csgkP37rzxs2Byz3KmW2z1kgnLWXzW2Te2fX2RRivD4U7xeTvljnpco/2oj9lBepFRYrGp9rJ69o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rFjmhXJP; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8xyHO3M7GuxFo0eRkSgSmEgxMbWA70R92MEKe/savh6PyzPvMjiM6gaR0K+8BH1tJuEUDmJ2Zs5JlnuFApxEygKq9lbPN/d1z56djHMjXUnAqrVFBSBXr05kjErPg0vlyQGJiWj66Fxde4qsqvNlzM6GDHnBkQARlz4XZ+NbsqmTSV6gryfBc3nTdr9HuSVyHTb8nEQdqluN2mcMJYPZgMp1FeRccPiYb5M2EmI/AgHIwQinsTPU9gBw2HkOxv0tz/Jdb0hcljDM29KT0Vy2Udljo3fBDtT2V/RSyMgWmK9F/mFACASyu2h9S+3kbQFfY6uGr9d7YQ+gZgWpbNTtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzWlA3amoFk1it0k8iDxPiJsO+YlG4E8JvhkZgcv3gs=;
 b=HW89qw5ad1S0COGTYznmfOEbW0DRF2HRq4nu/Kh1TuE4L9j79k4cHgXwsFZw9DHjZKs1CoY2WMPethXTMJYOA1LJUD45EnTab7pr6tI0IoSvW4tfprPH6sB8WD0/IF5f/vcEgM8SboBXlTFiUnLDMUnwJTuYd7lOgl8lyggMrBTWmK3TyzG/submYrl060AevsgTUZFWrBlVLfhCT7m+f5PyZKDsFBnh/n6GsnAFduCBJvtishW3MDe3o2UY/cKQdw8+Vfg1Fdl+P0xL7HQy5kZqRnRuVDp/MUruOIiYioct13t95GvmrXv5vwIbx2E19Jw2IK5z/2Zv3/2/wKP4uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzWlA3amoFk1it0k8iDxPiJsO+YlG4E8JvhkZgcv3gs=;
 b=rFjmhXJP4MhKNnaTDrW2C8upczmnI/nf8P4yjQhcWRpamhXCW++5QBeAdF9DwXrlv81c3rHDEJ4H1hfq43aA8DGuplFTaLbm4vcWE4JI05av7hkeDIdmKx+oXnB1dqPKlTjeZnRw0lzodbSDVrFRRMV9sgqq2oqWrUfJTe+QyIy3/CGGaGSyMKQVbX/G/jQHsKOnTSR34r6vOExF+3MGc25L+1TO1Wu2/dPRRoeZhXNRvBNz3VRCHgendugp53puk4t+7dsIJP9cvnsQwVtI/YHAKmspGLqrJYV1zog1fWZNgMpgJljALmtMcF/uL5siMeoe7e7u7VkXqTk8WxLUJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB7117.namprd12.prod.outlook.com (2603:10b6:303:221::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Mon, 5 May
 2025 15:02:16 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 15:02:16 +0000
Date: Mon, 5 May 2025 12:02:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, praan@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 09/22] iommufd/viommu: Introduce IOMMUFD_OBJ_VCMDQ and
 its related struct
Message-ID: <20250505150214.GI2260709@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <8bab0069503fa21b48298ed2ffe29a06963f71f5.1745646960.git.nicolinc@nvidia.com>
 <28e513ec-4d8b-4967-a241-d6f63d533050@linux.intel.com>
 <aA/EoEFtbnL2+zAw@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA/EoEFtbnL2+zAw@Asurada-Nvidia>
X-ClientProxiedBy: BN0PR04CA0190.namprd04.prod.outlook.com
 (2603:10b6:408:e9::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a051da-219a-4298-05bf-08dd8be5d2cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wL+g9ma3haJxsRa6S6nIap3cec4PtceOEcol/SzYhXeOYJJA5ZFw+oBvE5SR?=
 =?us-ascii?Q?hJwRcXTFqQ6H7fPG1iqOwRnsr29mAc3727A4aFffKT7WsSaZhot6zLS9FBSa?=
 =?us-ascii?Q?FTcI9JwLrpvC8uXCLpqE84rz7IATcuRJS9OszUWjLZD4ln++gpcIbawtTq1P?=
 =?us-ascii?Q?QE6oo0zPke0prQHHmeWAhNLudWouCxlkvAOcojLEzgBszOZ1GFlXcfa4mT6H?=
 =?us-ascii?Q?x1Z/mkDC3KHicrk43S4B+fEHMTNb57TgQRgT4bcJfEinpIy8nKx/LVvA0ICG?=
 =?us-ascii?Q?6RtTAE49D8lKrXoQ0HRUSX8Y2tIV0iggWl+3J02Px8CgzJK1MUImT0ExsRa4?=
 =?us-ascii?Q?FHXwAppPoWKEYZv/A0LZTX+ejWebrOBcXrw9TUH3X/eHJcPrXfjO0hBaxIh/?=
 =?us-ascii?Q?z4lvs5cC2SR+N/f8TwfNv/Xz3KurqeJ5i/H0wc3htSBeiKGyCdhsXT2YSLp9?=
 =?us-ascii?Q?cQa5/2L1QT/NZmEGAkF5cSrpyz5ZQmIhtQeesWtR4umA97eNLY0ZWDxkOFb7?=
 =?us-ascii?Q?6ZoUMpvqEzdeP59JSGDWANt0UOkxS6INpn6FE8CymHOpMSYGJ6S93oo9XBI5?=
 =?us-ascii?Q?eZaG7360wqkWITBVlnyyPBpCJYv9VS9fO5ZprihXfDD9bXnEbagpBqqZsMQd?=
 =?us-ascii?Q?c6SNrLrvNeokCeKSwuI9kqORFr4bcJAtwjL3Hh6S4R7+KBROORurLwM9/bdU?=
 =?us-ascii?Q?nzFDQvb29Z7aHzi3zsdAhfTmw6Z3pmEQdg6pYBD8Bx2rM9+czuOiCNFAvX1u?=
 =?us-ascii?Q?f3hvCmoSW8Ujx+tpgIJJXXx3xns3MBpNrSRsq2arve+REu2ff9lzx3s5YcIj?=
 =?us-ascii?Q?pkzZUXhkM32z7WfsXWft523HF1sSMD4ClPjLQYGcKAq9aJ1RQSgb4raARKml?=
 =?us-ascii?Q?jLwJ+7Zd31U7dCR4P7/VwiQD3An030QSkN3I+X+KkQS301WmHQT4mIEdBTI8?=
 =?us-ascii?Q?G3UBZjYsz2ZM+ssdeNpSfy5nFXT5GAJLwm6azEkyMrgfeke7Hf4rquKtkX7u?=
 =?us-ascii?Q?SD2HYTegwN20kCrYlD7JF7ixclDOh8CkU082JFLC0SB3T5cWo9om+cbZ2hZk?=
 =?us-ascii?Q?A/TRyYiCeP89wx+K/NWokXrQsY0Bz+4iPazWlHgyF27t36mCoLuAQp7KDGCk?=
 =?us-ascii?Q?C2yhdfef+yRHq5qy4p8EXsRbBmI6IMU6vgHOU3ZpgiVma7SebT3aSGg0J0ue?=
 =?us-ascii?Q?qD0+ylj6M91PuDKDv0wwh5/bVlVqzRMb7ZNP3tuPdqMd2fczHhaxPKjOKebY?=
 =?us-ascii?Q?U0NdbHAZDmxVd4M6Ab/WwUQFu3mww4wqEzqkWUEJamaM3i3WWTVylcQWDE7N?=
 =?us-ascii?Q?51C1yOQXWG8OpBTf5MrAsmSrwr6kM244UMK47TPaBrUwdp1pG1XH+hawDOFk?=
 =?us-ascii?Q?siy4W8xQWhvmD2udGXJqhxQD7wzoxAvuVsWB/VtpfjGpOFkxkwqJLz0UfeNH?=
 =?us-ascii?Q?nUe5/XP4oO0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fh1IWAeES0phdNM5+mCBMTKipvkG9U7C4lbApe15LJng43Rh9hbYEvV0ys7o?=
 =?us-ascii?Q?AgTtSObMALPygcbTG2xR1sOoZZasuypcR7Lms3BVnDVgMSQoT9uLAq73WMoR?=
 =?us-ascii?Q?7RDiiYvUhEVWi7zQkkaRC9KN7FIv80BNd5GGzeQE0IZETxyBK3boy//nbJBQ?=
 =?us-ascii?Q?wTfgruZ4S8+r2ib2sWmdRL96RkQzHPRFHqLa3EIn5fm14CLCoKABwfCQa96t?=
 =?us-ascii?Q?AvnRLw8X8/9z5hDBrkNix7th3tMQwcMExx1Hs4c57XcNfCTDo8Um31DqVcNH?=
 =?us-ascii?Q?Jngv6QIN2RWGtFv+76E7/+zi8Lc7QjWjZI91srGpJfmSoHEsl96OSCXtCTUj?=
 =?us-ascii?Q?zVDagkVDaFO419SxtSsSUv4e6ytGxtCTlq2IPIkEuDSem++hyiwm62bOcy58?=
 =?us-ascii?Q?ZBzJfcOvem99pR7atYEEPX6VbTVx0cYrFi+WSkiSsTpYrS4Wjmo7juwxknMe?=
 =?us-ascii?Q?h/hSukv8hRL5odJKpJsdyOFWGzOOHHm6mUqelZgoU6ZZDXNtfGkr0JXHuRpZ?=
 =?us-ascii?Q?F1MfbgTMm5Tjua0DO5aPsGKr3eiz/c74MK/Qv8tRnZwMcCnC9uBsepG1eStD?=
 =?us-ascii?Q?EONdvpXFSVGPgSktwN4cIvo21fgvGPRIzCPwZkpGaUCZJrTQKJktVw/SsAgg?=
 =?us-ascii?Q?5GsBAs1C6lgCZngsDw7uIY0+AkoMn84FexsCjIzZzg8LRcVJazGk34AM6sYp?=
 =?us-ascii?Q?z73PgKB2WVRDyyy3n1+qvVEP5hGLqfVdDhnzJBKxF/AVkQq+GyPPQEHkUaj5?=
 =?us-ascii?Q?9nKEe54M8OxT5/TeOYoq+hJaJXAhp1gQ6fVmMh49gtNj7tlsrV8Xe1+h6MCL?=
 =?us-ascii?Q?tEYemqjCaCNIqj3t1M7VAQGQKfovoal+d+ssfADvSGuk8TjFePXqbvw57Hyi?=
 =?us-ascii?Q?G/SivIksmoch7/89aS87G29S0xH9pSLvK7wH8DOx98faZ+b18tzPm5o5O67e?=
 =?us-ascii?Q?KVOf9+UlYtB5PrNJ/Gydz+loByBPmvn6K5/75asbqZjQrKFflK+rruscVOAi?=
 =?us-ascii?Q?aOy+OZ0LZM1Ia8h87X+tqTNB6B9R0DvdzpJlF/Jn18I0EF2YOOGlqJESpQh2?=
 =?us-ascii?Q?Jka7oCafk5NW2DMhNebIAx+xmpIH04B5vux4pABU4xq4y7vOVXkQhLYtEzW7?=
 =?us-ascii?Q?cXd45D/JRFcsr88TMo+3LBO5FMzas7OUOVE9Z73X5sRAlFsiPYxUyL8KEjl6?=
 =?us-ascii?Q?bOVZFZ3BCSeLwifuJDO0LRj0gYXKUtqEdOG4XA0ZZyl3VnVgqUti7sjeIRjM?=
 =?us-ascii?Q?tfEL+QwWFs0dB01YtI22/ymp03Ge6cdxedzOsmOesNyi71h+PfWVi+hDure3?=
 =?us-ascii?Q?ZxRhwTSBgc4iF6HQHyp+6RgQIFjUdiuucIt/VgP5eu8AzhcmLKgDbRN/7B4J?=
 =?us-ascii?Q?lqSQ2/ydUlajRngpG8Q1B9bkG2p5qJ4R9xPPMY3QWPnbEOQYAmPpPGNmsQT2?=
 =?us-ascii?Q?nLODxJopktewkUv5/fpf6AT/fZU0kKFc3cgfCildu9DVqO0BzFdD2PmWdfn7?=
 =?us-ascii?Q?bYV535J5OOuhcT0Af6fviIWsObvkLHb5iNfyHKzqYqCzCsWvjkCwrt+xWxsO?=
 =?us-ascii?Q?UPQmre+w42IDaEQf9FIovuaS7di3uQVskGgT10P8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a051da-219a-4298-05bf-08dd8be5d2cc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 15:02:15.9718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cNBB73R8omzS8OKkz4DxR0N10sTBBzFBaJa5dgVMRUJUvpZnGV+DQwLdoGUE38R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7117

On Mon, Apr 28, 2025 at 11:10:40AM -0700, Nicolin Chen wrote:
> > > +struct iommufd_vcmdq {
> > > +	struct iommufd_object obj;
> > > +	struct iommufd_ctx *ictx;
> > > +	struct iommufd_viommu *viommu;
> > > +	dma_addr_t addr;
> > 
> > It's better to add a comment to state that @addr is a guest physical
> > address. Or not?
> 
> Yea. Let's add one:
> 
> 	dma_addr_t addr; /* in guest physical address space */

If it is a guest physical in a nested page table it should technically
be u64 not dma_addr_t

Jason

