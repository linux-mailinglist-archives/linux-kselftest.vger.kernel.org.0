Return-Path: <linux-kselftest+bounces-17280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B8C96DF19
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 18:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B38287402
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 16:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E6519E7D8;
	Thu,  5 Sep 2024 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UhmFzS3p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB41219D06B;
	Thu,  5 Sep 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552242; cv=fail; b=i+suNnEcepPMks/ZJmX7Y5CBE5sNmV5FLTnlv1x2J9jQZ1ocSZlN8HjjXjTNidqEiOGYua+fGwEkHEvb93m5hHbEvlTZqRVAi9BbHaIG6SceeyacZ3t8BXFLsSKPt9sZNGQ4HYWsY5qS1YK6XBRFlsg96DoVHlRnlY7l0YT8tx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552242; c=relaxed/simple;
	bh=4NX83lpJYP+kVxlquF/MymQlaUJedSOwPIpEUDozsnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dN0yEbmQvi6vDRlggt1ttmhFj6Z4HRMJjhYvfBRjZX3wtOoFc/KCBPaxhj8FmqK6DhKcXmDUriisi9IpDkt5YjPb4iVeLd6aDbfVIFRUpAGr/vD/0Q3nld3XXAiAocVFEpqo6ZHKsSrHORylhPUFY1Gas6zirWD2TWIlySqnlD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UhmFzS3p; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnPTSU8GzR4q1m63KLIjfnvvMlFQZv3KpDoyuYkGhA7JXzsnzEESIKYOVlTQSllDulHJtVGxno7W6z6D6IthsOyvtHfMfUvDbBFpIErDBWex+hE2ZpZIjYlBe5R0DieYS0Jp28rQ4bwRm9h4ojhnQOrR3q6gCq3bNFAMNyG6c14+2VLG1M1Onz/QS0fIv1qDFxDucgqlox8/JYclMBrwvdHS7va9ajrLdR2um9q2A7FsWLkJJnoYGECTgYvQrjmkfi30h6ZHmlOuA5mqdxPvPHJv0jQ6UhQWRCMeSnxrqJa6aPI+tcwsiF/o2MFTZv1k5WiccPQXWDmT5xvwm4OPHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NX83lpJYP+kVxlquF/MymQlaUJedSOwPIpEUDozsnk=;
 b=CjYS/UL+RmvJJy87LvcBWgzgFKGm7I4wI6TrZOi3yzMkghGxbbaQaJXH4p9GEio+Yt4W+fzARCPvLkzd2VMo4MkfqgP2KpCZY9lZ8Rvw78fYxBIQy91axRalV6pb9b51MZFOn5DIXUAPl8R+7J2Tc/jIUbu/nLpWXvGJ2Ym3Fo4lnz7+dDOTN+nOD55NW+zOBh4wFhczm6LJu6DeU2hsXk6N5RXQFeb+BjAwEvOqlZ/o/0bmYZHrx4IFcxNLjIJhGhCHg4Ms5gr9uORRezJUWesq+2ktbW5frpE8KxgrqHURVqq+mlLgBiviJV8JZxOgFRlFz2PVKLhW2PlUwQtFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NX83lpJYP+kVxlquF/MymQlaUJedSOwPIpEUDozsnk=;
 b=UhmFzS3pLyR/FHB3eQ8kcpo0AARFQW9jd0KGCFyHGCBS16zhzge66WHG5bcuAmK42KremaEl9xEFchyvliLwp+dvhuKQR5xbjQNGZlUk3a5KFRHIkoa713Zkq2MOKCm75KjA3p47mIiNOxydv4IxZYMcBzaKbifV0w16hML//Qzg3YfFQXMqa0inQrFPHB45kEJ3bB4JzEd/tAEXsf2Vk6bWG+DljaWvARGBbKb/6k+aaEnjGqE5RzZUerk7s1McbbP3zY3DMX6tr6TshmPW+vxzrSLECCDbDC0fkRyXxwX72TB3TheQ+75cdseqErCrgUCCAJKqefAkSjwvnNd5Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by MW4PR12MB6825.namprd12.prod.outlook.com (2603:10b6:303:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 16:03:55 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 16:03:55 +0000
Date: Thu, 5 Sep 2024 13:03:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <20240905160353.GP1358970@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:408:fc::9) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|MW4PR12MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d789e56-1d38-41eb-5200-08dccdc457a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XxZjrrXY6/XUov9fPD2rffgrwIA/BYSPNfbkR3MYAQCWurHHIbIfd9RmwLAm?=
 =?us-ascii?Q?Gfm5jg6m/ZALPokzb9r8MnIYuIEqBZH1tSTn5S1pMSRi/A/8f7aOCT8e82EA?=
 =?us-ascii?Q?jO0TZGgo3EaHlRx4X4199PPdVSGfuxegxt3YEYi8WRD/F2GpmX9rrlhKUU2d?=
 =?us-ascii?Q?VYpmxxDec0dogh3lfS0ixI85eeu9bYflak+66hCVeWiSplttw3j+qhVg4VDv?=
 =?us-ascii?Q?XEvIGH8j43z77JnwHgVWq35F37c9Zupk0O7JCgdz32VPeKPb7mef93UyZz8D?=
 =?us-ascii?Q?w885bsAYmntVeR3i9EwgIrIJa+JTelxOmNSh3u2C3Kp67FR2J3t2H4CSObGg?=
 =?us-ascii?Q?BGy98Z0Fof4NN8IbGAhcTDshud067fxFJHUcuxjb4gTkIuahrFharaDoMQ59?=
 =?us-ascii?Q?i5cxSFtigng5C+dPqnM8trVG0PUdIk+dp26xq9Gd3HSGdN04nBzqC+tfZVGj?=
 =?us-ascii?Q?ghukSSOj3BB9eEWNNrZ/Uhk0cVOzPv6YNtmVJJah5FAzoT595r7QOUEiIhyg?=
 =?us-ascii?Q?/vCIBSJialLio/h7burVITLgqYO4/eLNqMOFRpkYfyST0k/y7txaI/qqkLyE?=
 =?us-ascii?Q?3o8KSIAlBu8UDo3hnFMEUJNl++J+vp6epZN0sO7deIXJv/dVLVag97Lp+mbl?=
 =?us-ascii?Q?0lQRYSoGCSHgkTdd3aW5Fw9hJN4cNfsujt0pU0aORGzD/qTorE+l5w03HAp4?=
 =?us-ascii?Q?PjP867s6IWznFIziZm/g/9DgeNfcNLttlj8sJV3LAfP6IzRRjK2l+UUHQv9B?=
 =?us-ascii?Q?01gLHst5nIjRqjcSI9BDUSUueqc+chyCey22LC/ovqwe8tMxy2Ya9lDVHZ7X?=
 =?us-ascii?Q?lOymhdtRT3c9UyQMlUwTfO20wAJlNTccB6XRAfINvy25AIr8cH7zDY1dPNB1?=
 =?us-ascii?Q?rwHIQQ4CTSI68VHutQoKfNjMFMe4xb/kAq+8nf5EoglIEQkg+lM3siWrZ2Js?=
 =?us-ascii?Q?qBez6RKlI1uJIWUW/sdBjbwTIqFKfCRUM34y39tkL9g+P3s8dN63v29AQhc0?=
 =?us-ascii?Q?Eel+sX1MVLwEDykrvAG9/E1cwby8D7DCn3GY+w8WBB5wu60CgZDR+8TqidSY?=
 =?us-ascii?Q?mezQVyyDVx7iDve1KlAFbzPF37voGbUf90EROtOAl4e+r9Lt+PkyhvbHwBZw?=
 =?us-ascii?Q?+kzpfFJMYchkWugJ+6yAxM+1r2Vu5SrdZrX7jlINv6YulDBDpydnrjFKajV/?=
 =?us-ascii?Q?+9kiLQNjKiJIQ9eZkWb4w6C7rQdRjlkoh7dJQy2Ols45KmJuglbWS/zWeJ+1?=
 =?us-ascii?Q?ev5BYooBZtgH6PKxnRv5akk6EvbKQjxQgG0KFJn1eRwiNNFL4DizergmlTaO?=
 =?us-ascii?Q?tjuQpbfyO4Hqn2eusOgAEvw0fWcX6CK9gIzCCE0dqHuRmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MGCdSdvnt+y2mc4dUpwELYarCp90AIA/v+Jieity9hAmrABGlsfkV477xFjU?=
 =?us-ascii?Q?0Jia0ZKD2K4417sQ8FHJghJdYW1yagJmpiblPeqjaxw6j1CvBIUgi7hM8F+9?=
 =?us-ascii?Q?BqoFKOTTmnnewEgiCp2TzjlkFN51Ayit9LAJ624nByP1XTM0/+1khiHVHXMD?=
 =?us-ascii?Q?izKz7nSsFnl7L3UnX6WPQKKUFiW5ct0DD2Q5V0dQk5+oBzaWcdwuNtLq7lya?=
 =?us-ascii?Q?l0zQDteu9X+UNpIMTJgFRPy6fmIrrY+wZ8GdXz4Sa1jFw/mPquW7VIZ0lOWD?=
 =?us-ascii?Q?xytZa+GmHZ2Qriz+4spDYAj6XMc3lc+VTT89QasjGJ8JD1WrLP9xbaS0/gEW?=
 =?us-ascii?Q?jl3iC5yvv8pUoqUrI3nN2pn9OahjkuDFgfMhWzNEpKBixbgA77A74AJefGWS?=
 =?us-ascii?Q?gjYdwnDhuV3I6NRsKlyAkt9pI9rjYwH9KTNs7Q72DX2glbHbOGXijC2KNQAk?=
 =?us-ascii?Q?MPhtgXTK133pepZ2RfXM8V5IonEhaIT0ES1E7JbN/8FyGSIJHxKkWWD7agIH?=
 =?us-ascii?Q?VfVM4b3ovtx72ImP7pdGlf55ZYweYHaNBgbr+xCTjiu5fYE++/eB2ycja5ci?=
 =?us-ascii?Q?DGCQvH4jFUR88yutaYUC+LqGnuKT0fbyTJ7u11gkxFA85XzZfDKEKOE9qGEp?=
 =?us-ascii?Q?ppYgfqP2XbxDiHz3RP/KxmtjRUBxu62xm9GwZjODq18mzacWaqJ2IfeR7eqK?=
 =?us-ascii?Q?TigkoSvqK5EQD8LlYGsjxHmOqwNm8Z3t8FGooCNSLXB6IMXduGZE9+f5eqlq?=
 =?us-ascii?Q?fZbhMSIieNfHGkuZh9vFLBTKSbYZAwhv4+z8K4vbU3z8Vt5MKo2rOyxLWUyJ?=
 =?us-ascii?Q?NCgmJ20opn12rbB7skQ8H4uN9fbzU1sO4TRFIARmpZrMBbKZcKiwruxmkty3?=
 =?us-ascii?Q?0aRMsHaoYkTGD3BQ12Dt94e41bz8ZYS33U/matZSlRyrMvtPwiHP39ixZkgw?=
 =?us-ascii?Q?S7bf9EIiWIDw2w8nUtYim6dzFVD4lyjNLcuVoK72X9UCOnTog1d9MxSa+0Sk?=
 =?us-ascii?Q?ZBULCasZDfvhlbzy9oN4ZIIORzI6fjFp/cTHy82K4BD5fXh/HboKMHns7QvM?=
 =?us-ascii?Q?tuwxrBp6T53sn4MsKqFqr9H24mLRQeGaVp6deGRH57kFQtjChHjrcZm82PuM?=
 =?us-ascii?Q?pvy2dSXKgDykkDJaTkmky00h/tzQ33hjWc4YupVUSbCiRucVy3AZ3hIai7DD?=
 =?us-ascii?Q?Qg03v5Dva3HySe56TtoX8Uw/YbX21uZiiHzYymUOVpyqCzOmSuxh1LnJthHU?=
 =?us-ascii?Q?HPdd+iEASP2d6iWFnBjmztGXO2KMjDwl9k1zO392MsF5sCYc3FMOSxKcXu1a?=
 =?us-ascii?Q?lz/xuZDTFw0mT79RXxPorCzKmORjuL50Wu5kG/NV4BEbx0yRW/40Zrbxa87h?=
 =?us-ascii?Q?QE/bFoeTgE/bH2byklSUGRMOv5ogRCr4YNPhwVKefsYDv30undRzALQJLCrr?=
 =?us-ascii?Q?dizxKsbGEIJYJ8mQMAPqGuud6Ph50A9WmqMLfU0Tp4zGVIqwaOZxcU2q/kfU?=
 =?us-ascii?Q?HC3r825QqSGt7qigQuNBzWjFtMjmeGeNpw9nnwvHi+yhJhJrxzv1df3pJ5gU?=
 =?us-ascii?Q?/k70GdDaCaV4xa8/RIW+Vbi1Pu0WAI/J/8REQ9v5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d789e56-1d38-41eb-5200-08dccdc457a9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:03:54.9196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdDphmOdyCi2m17q2ZvoJCgiPg1Wo1iPxUNBDUIeuItHsm+EnZjBm2xsW/CDfm7Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825

On Tue, Aug 27, 2024 at 09:59:43AM -0700, Nicolin Chen wrote:
> Introduce a pair of new ioctls to set/unset a per-viommu virtual device id
> that should be linked to a physical device id via an idev pointer.

Given some of the other discussions around CC I suspect we should
rename these to 'create/destroy virtual device' with an eye that
eventually they would be extended like other ops with per-CC platform
data.

ie this would be the interface to tell the CC trusted world that a
secure device is being added to a VM with some additional flags..

Right now it only conveys the vRID parameter of the virtual device
being created.

A following question is if these objects should have their own IDs in
the iommufd space too, and then unset is not unset but just a normal
destroy object. If so then the thing you put in the ids xarray would
also just be a normal object struct.

This is probably worth doing if this is going to grow more CC stuff
later.

Jason

