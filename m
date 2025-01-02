Return-Path: <linux-kselftest+bounces-23827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536CEA00000
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 21:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346E93A3163
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 20:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F151B4F04;
	Thu,  2 Jan 2025 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S+VxqMdy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57311B87D9;
	Thu,  2 Jan 2025 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735849825; cv=fail; b=i7ok6a6P3y/105VqmCZvrnn5wqCAL98RQ3ywpwCkk0WwivYkmFSbhxZPNV5D04y82zx9wcZfOBacY6ifwNr99VHu1DN4F6bAIqDgQFSML4BTMd65i/cUGIiDlZHv4rQ2GnBTVlgldooZq3/0/oLUbZj260j9RUPQS0vRjOJAVxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735849825; c=relaxed/simple;
	bh=O/jDb0RRUskzfgvmO8MFA0vnmshNwb08RQ5q7jqIrEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o9JsNJqJBlL+YyVvGDHzRzlyzSAUC03+jhBaaLjIKS0hkBMJcNuwP3DD4MxZiRTbMD1xi2STJrvf8c/st0T9+RXMe0mBW0Bom0rqoajOPCZTauAJgkGeorOLuP46L6krQCcqwj/DVt5gUxdyHf1yY5DsLOGYBlh2utjNgxopTFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S+VxqMdy; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hx9FfaDboWKSk0Rp5Z2uFLm23IktAS56nCZgDApWzV44r1f3zZPgWz1IqGOLypD8G7elXIyXm4jXk7NZjRVtkyxTOKYqxRklxwISwyuij2VaQ/AydI17ZThr9xRi9rbySFvmtazQ9S8LB+gF8jqRmqYCvtRF5nna7XOHE0P+Iu0jEGDGKdoBhTn/GPaWGyPBaZ3wOVE0UhlPFT7Zr7LEvn0XmR18bWM6AZSWPJ2I7zN3cGixYhFDvOKrbVvJp3r4mYzxmNRV/SEZ07KqzWtH2525D9//6IoqV7ST0d+C2gTh4mHElXLxAIMH48jOdkg1QWbUvXpVn1sBaUQeQYniyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/jDb0RRUskzfgvmO8MFA0vnmshNwb08RQ5q7jqIrEk=;
 b=DSmbcLCT9edHyTpO2dxm8gPcN4fZlDwB3wNmxV70gpk03r6innAUahDfiwQUg7O4byTYOfSvHtbwjTcgUvnf9qeiZcLQrnk2a9f81HgL9QSKUEJULnBSf7qntBD7mm1+Z3s/0tOJyQVR2EIHOU8+yevyDVCO24gYIlLgiE9h29UAnTCglMktlHxcEYl98dOIq56pHz0oY42mOI7df5nEg4A+r2P9QB0J1QgrGDLnsBOBG7lQ9tIOSbV3S1aqYvprg0KD6+fFVIN0Q/QzleaVro9sZwBIWkN7SaDmMDXXTXaGayn3UzARqwAnC7ufEFcjB0CR14C/VIW1hMPiQ5qyPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/jDb0RRUskzfgvmO8MFA0vnmshNwb08RQ5q7jqIrEk=;
 b=S+VxqMdy6sAUtMy+FwRg8hjEWV8cgespO9oD+USX9Z7QVHufWkyfVm8fQD72Han4IycTTEEvjbpkLT5m/SHtwJm0Ihz8gXHY20zE3jRi3GKkgvREnCgwI29EdOomkrRtia8xT3Toj/8GPeE2VQr5tOt67g7ac8TIfj6CtemRpr/s8LuDkvSa9P+TX/b/BvIegeyH2fv1Lgx8G8wQWvHSKzzJ9nB74rEtnrDD0kTmlnRNUeHNmvvvqhqsWR3YJenyPlm7b1Q9Dbe/ONF7+YNlbJlOKewLvo1i74rIUrpKjcpZ++LpBV+HUt2DhbGPgr7ChybogGBLqipdzWBb6wsw/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6568.namprd12.prod.outlook.com (2603:10b6:8:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 20:29:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 20:29:56 +0000
Date: Thu, 2 Jan 2025 16:29:55 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	will@kernel.org, corbet@lwn.net, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v3 07/14] iommufd/viommu: Add iommufd_viommu_get_vdev_id
 helper
Message-ID: <20250102202955.GE5556@nvidia.com>
References: <cover.1734477608.git.nicolinc@nvidia.com>
 <21d7e63b97d81d0acf9127418a67efe386787261.1734477608.git.nicolinc@nvidia.com>
 <56c65e50-5890-42af-85b7-85f8a1bf5cf5@linux.intel.com>
 <Z2OpylDlhLXoo3dt@Asurada-Nvidia>
 <74bc9dbe-3420-4f0c-9e32-db49327a723d@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74bc9dbe-3420-4f0c-9e32-db49327a723d@linux.intel.com>
X-ClientProxiedBy: MN2PR14CA0030.namprd14.prod.outlook.com
 (2603:10b6:208:23e::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: a330a8ac-a6f3-498b-5af4-08dd2b6c38d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RPHkk/KhAckCSNr7lfzKp0bQ6938+h8TD2uO7kQOuHnb95ZSIvsdJATirLz1?=
 =?us-ascii?Q?tMRjUvcwjyp50cri5slH81nvmZfVaMVXFVRnnbfBcmAhN8MH9rWK2DgItqAZ?=
 =?us-ascii?Q?m1/Fz9+m6Sv8rZ9QJzOH+EzenuZNQlBEQ8bf6umXttFFQ4GhvSuG6I8Ts4uN?=
 =?us-ascii?Q?dnyM726HeTh5FLjAsk3k3Y4i8lct9tfnE+MCdMZPO1UnbYZflK1aF5K/qF3s?=
 =?us-ascii?Q?bDxNUOBZNEqpKZLP6ohNZ15l/1vMJqJUt90pjexiioPY0G44zv00Gs31DGNp?=
 =?us-ascii?Q?R1fPRR5BJZSZhzEHNaNxzf1/ii3EqP4FiWSTNPx0rfEryH3JjDFFDMjpl9I0?=
 =?us-ascii?Q?miLcyO83D0BDAEop9z0Ue2ndBu+S2as65b0gqkxXMDMd5Bw/loP2XMYfFmG9?=
 =?us-ascii?Q?44elDVYKixodlbTyfW+S/OSSJutwEGjOnK53KZCLzEfocU5IYyZJnn0ATPoN?=
 =?us-ascii?Q?dDnHS4iz+VHbxvSIhS6vErkyU2ez2+xeQOUWYf9g1Z7w7+lorbTMTpGt4om4?=
 =?us-ascii?Q?oNvD8TiaHrVOYAUjzDlSVxl8DE+JPvctmKmXozVxsdsj5UorQ+51qTTRtWKo?=
 =?us-ascii?Q?sjxkSrfivrKpu0q+l3hBqk88SJ8KCUS9WNhWFynmjEoh05/5Q4QHJeay1yFk?=
 =?us-ascii?Q?3gzigfxIjXCGEmv6Vt6er/iTsecyCHg3LyzQlanlyZKqcB645Vk35OY4KxX5?=
 =?us-ascii?Q?xSEJnn91OBqZLosQq3LBxuhKtsOgTXpuL6uP6HNyMAvYkIEDS1qdS3LhJq1J?=
 =?us-ascii?Q?YVGwHeVUR3Gp+CXIjJlzHV/62qxGjIHA1lqLPIQOvVa1dLqj/cN2JZB5WC+K?=
 =?us-ascii?Q?rqNrlRdsk/BsgrKzbnxzqpRXrgqvcD6EP3pRq6LuvKrEB5nYT0PcOLt6IxwT?=
 =?us-ascii?Q?tlgT76AlLLoTvN08aAoo6W6oqwAW3f65cQyH54iFKA0e0G1rTCBVrgB2i02w?=
 =?us-ascii?Q?qsRwoYwHGaSXy12suIFlrMldz6cj0qZHMNEN27vezZWDazCc4xCxgY524H9U?=
 =?us-ascii?Q?aTK5Z68BvF1sOM0ys7a7c4vhnEzU7lNKwAmqmrxyNypJHI5SPRlw5FLif0Mz?=
 =?us-ascii?Q?W56pvxNpENje/bnbVY47SmgaqHIURfClHBrytwD+Qp/v5hZG9K6aP9wZJZwd?=
 =?us-ascii?Q?OjfnnTukVGI867ngq3sPSXXErBzhHUg7uS/6k71aARvff7s/qyE/ZgqKNYJg?=
 =?us-ascii?Q?P1i+jI4bRdFUpuUqXNUXSFXnfpvynrwUCmZpTqzxw6XGprdPgfaw6d0ldotx?=
 =?us-ascii?Q?C34JO4Tv7pXRoUul0S9+8EHtFMGcVLqNENn3MdMdMCu/H59f7EZfaHkrlx/j?=
 =?us-ascii?Q?oiN3Zsxi0iwssF65kEcDVxybzT8K3C6NT08PFYuwYAAMuJKjtCbviwMdiAbO?=
 =?us-ascii?Q?LJ523RDozs+d1yIwLrGfm1E8lV6a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GydD+F6lj2HiNr7VDHFJ6VV28FA3GZXXokE7TwVMc49d61hyk9VxMW5zPNKs?=
 =?us-ascii?Q?805Zx4AUM3x+6kcja2YaRB8HRdM650hnl0Z03R2mOGhwiq6Nt/c+4/WKAc+M?=
 =?us-ascii?Q?+3ipL7Yd52rDhBcaHp1lU2O1rvjoWXJkyWqD53feTTAHgJO/phWoctoLOZnX?=
 =?us-ascii?Q?HgGZMncb89BI3rzeFs3qCuivhYV8ZbQ8yt/LxQ32EYKkZWxq3YGqrd0FC7nD?=
 =?us-ascii?Q?tOwwdK67vTa21HwH3WAFWqZRWKdXFFtOQn+3EZv0C87RyYjrueVpcSPqNUCq?=
 =?us-ascii?Q?xwLBWCwyO7y0iIvsAry5B6QKlQQ4hTaadvooZ5tWtQGIO1i8y979jzAklYvU?=
 =?us-ascii?Q?rwVtjPeYXAwbvriLh6JnebSTtQN/06FGKVPatZc1Lod+Bpn4al23jJyMMTqx?=
 =?us-ascii?Q?ixOVmIHFzk2HONlvpec/gNObEqkvAk+aI5jeATBThTEeSK+DbHAJ4pHPZJxs?=
 =?us-ascii?Q?6+cNOEQb3nHH3xg6PVTcrzuEFo2clkFBoZlYexpjXWlgeCs2CCIJ/kWNfUfL?=
 =?us-ascii?Q?6SWER1nVy1zJUbGsomDTKYoQbxWK3ocJdiVa8eQOcMu7GcbxqVwlgMNN9Mkn?=
 =?us-ascii?Q?OROQ9bZEPwV/hGodpkfIE57fg12ZUu7MM1+Zmd4TeE6dlQCPeK0bfn/fgHWy?=
 =?us-ascii?Q?HaUHkwM10yQ5pOvJkJbMCZgVZiL/Wc5qYUm9rP6CQNr4H841WU/pRM3+RJLe?=
 =?us-ascii?Q?qsDMkm1qujYSygBWR85tbKGTwQmALkB2ppP5oVwNArKUPjQqMUAcOwpWrf1c?=
 =?us-ascii?Q?gzALKrWMSPKB8DWLBOhzJMUbxX2iHhhpt9cPwGDFNg6BvdB9cyVIrcv/AUsy?=
 =?us-ascii?Q?VxUCuoWn+JXNI+K5aJWyHVaxiiHMQX7FyH71H3Q8VsDtOeWHe5jzRIr/qvV9?=
 =?us-ascii?Q?vV4JRe+AWAFtPj7LT1YF04wRGzFsAWPXCK/h9xAuKFQeiMHazeFzm1K93nS3?=
 =?us-ascii?Q?doqgdpJvcJcLh0ofpERw6jF1pSm1vaNl24YJQybYFVCY6FkYmgHTRymM6mPa?=
 =?us-ascii?Q?1L5FRh3GU2j3zbLra5GLRcDs0IHO37DJeoiLPFG1Wm0qMhXKE2F9N4PmzZoR?=
 =?us-ascii?Q?D71fwbkW3k66ZPGZgY5Erqs1gZcdhb1y+q6EQGTjVfNOw5XBbXCzQXlsl262?=
 =?us-ascii?Q?YBxJ4lnrHpKrm42wIp5GQYiC0/pnHAkDbicqgnu+QNa3SxCS4fTNUxTbiroV?=
 =?us-ascii?Q?DSh3WlPpyUk3RgNh+EwABQhkfAE2Cz1Nr7NOtUBIEGqT4QHEkx2fRDp1/CKG?=
 =?us-ascii?Q?jKWr0DnZUxa/VrzhqhnWf7MPgGeOpgTsZnoaauCnZn3/CdWktcC7nRv36iB2?=
 =?us-ascii?Q?MHfwwiDsdNpCbDYvaOKEHYf5isg6RHO4+yILhebP3uMnsfp16KTi9pynYhST?=
 =?us-ascii?Q?nr0aeO2bxE2aQVKBc6hLdvtZYYEJnJMDFVo5poO2wZ9fidg7f78IlWYsQmK1?=
 =?us-ascii?Q?m/InvunN0YEjKCPwSuEkeikMUuUerzGsfe5f/e0Sa60oq0kPRb7O49/J8LBb?=
 =?us-ascii?Q?EyN6+5mDHmx0R/LRnGmjNDS3eieZ5mgjUNHIcv1y8OhTwRsVJV1nm9UtTmnx?=
 =?us-ascii?Q?3YrItRTJxsu9fTb2b4COujjPp1xZg9+Oz7ydDItd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a330a8ac-a6f3-498b-5af4-08dd2b6c38d5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 20:29:56.8564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taP3A/nNiBsZYa14C2BFlgRMLLHuLhSR9rb850/87/6fIWyYePgnKInAYWctneds
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6568

On Mon, Dec 23, 2024 at 10:28:32AM +0800, Baolu Lu wrote:

> However, considering page fault scenarios, which are self-contained but
> linked to a hardware page table (hwpt), introduces ambiguity. Hwpt can
> be created with or without a vIOMMU. This raises the question: should
> the page fault message always report the iommufd device ID, or should
> the reporting depend on whether the hwpt was created from a vIOMMU?

I think every single event record read from the FD needs to clearly
specify what its fields are.

Page fault need to clearly say it's field is a device ID.

Jason

