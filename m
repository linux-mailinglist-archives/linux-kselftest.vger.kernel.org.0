Return-Path: <linux-kselftest+bounces-17312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527E096E16D
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 20:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09782287386
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 18:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9A015B562;
	Thu,  5 Sep 2024 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mt20mdRw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9649214EC71;
	Thu,  5 Sep 2024 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559288; cv=fail; b=DUDm6I8HICTsnQdXvF2HzbrZ7hmLj9RCIdwSTPpPltkbRb0jhqOuVjOacSBRBeSTv/WyKM0BA4O4dMB/TZ+UotztnrmfqQSgSBXMo/hrB4yFQNZHhXlsyrt8a4FtrJwEsQqJkL4q6G0dIkIcwW1axL0pEJoJd7hu0G7+OwqjvIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559288; c=relaxed/simple;
	bh=HHV62tM07wI86V0oSEktJn4O3LlJW22P2mifusgRvnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LAx8FDn9zpAm5Nkn/dZcs62cpn4QBCYBRHOErgKUROw9K3PaRtInqOffVdnNshcQV6LRRMb1TFmvC3gXlvO8g7h7aAM46HOvnLsLO6JqFH+HEOUEgIP84Fe8MsLWeODsQ6l8JOim81xZVJk6JnjFQ8n8C4MI2C099tpG07nc7jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mt20mdRw; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MH9JLsztNl+/ZwZ3ntNmGvQdAqkcPYVa5wyk4Xk5acTLz4SaqWIBmwzdGfZ6xyJe5vUCXEMPZ6ZzGQByNNbJscP6c2IdOd5yL31WrtaTKhtrf5SsEsVsZEHe4ivd5Gupe4D51WqpD07D2VK3Y6q5Zb80dI981DJdup/TrtoJ0lwKNjmz/sy7YU0cOoypJOtdp6V8l5oWisNPck3iEMTvXICLbypm9iPJw1x2NGIerVMUKqz/iy5MrqGXeIia6p47vi3fqXiyBCZgWAgcq7+RqFCMQ/CPtIutg3szLUGqGtJTjzlxcostZyqsjHwA7MszlZ7BRTJcO3V/GyA+1qINqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtSfH52xrACekY+PPhGUpSRkXQ49CUx0vzWYFei+hJM=;
 b=SvMwZj4GRBSFTgZp9/uQg6XOg0cxylpp0SthjOVAOjX37HY3gVQpa3XVmRnhCbxJOswORpbMh7XDhqjLxqf3r1hlfuUbnBy80fD04RSnazgEOL+12M5e51VTwZx/T3Xqjwxqu0k793ZRUMQfUHPo+3WBrJKM3cJMCFzbF5FAjqir6zYPRRt4z/JROfGqyJ8BgSrmQuT5aMXEmX+hJpiAuS62S0qbbfOgx83ZV7wZvWrymZmzKyJ8LfB3xfMtnCwvURQfnFfDVbNOxph5mZy8mSkrNu5LkYrYuYGrJ7jlrfZw63t56GUpxwQnajb3gnth+QvSW4RtQpyDKmiyBI6e+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtSfH52xrACekY+PPhGUpSRkXQ49CUx0vzWYFei+hJM=;
 b=mt20mdRwO4Et1auHnxSLWnTc34pjoR7LXH6s8yy+W3qbgzShJ+xYDHGdf8jj0zJKFSxiK0QcMxiCsagDCuCMwQjEjKJ/ErHFoHnjQSK4+R1dt3xtb/0OSXMgvntJjqlP7hedvtmwhyYHIblHsfTvL42JdTIFOfssVtZQIAxsH00MwtbozRzTGXXDTdfmqEGE4ek6n0zqCVrPeOrq5jXXna+wPBlcXVc8WspHvaPjdrsZWT6CZaHNre9QDNx6NyWkHMYtXRyfSbEBA73J0/mfRpX8uiVP1s+NPA6zDFcPpmeSTKAaHzjtB4H4blmlBmsQppUiQC0MHCqRsyZPGaK/nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB7102.namprd12.prod.outlook.com (2603:10b6:806:29f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 5 Sep
 2024 18:01:21 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 18:01:21 +0000
Date: Thu, 5 Sep 2024 15:01:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com
Subject: Re: [PATCH v1 04/10] iommufd/viommu: Allow drivers to control
 vdev_id lifecycle
Message-ID: <20240905180119.GY1358970@nvidia.com>
References: <cover.1724777091.git.nicolinc@nvidia.com>
 <3ab48d4978318938911d91833654b296947668ad.1724777091.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ab48d4978318938911d91833654b296947668ad.1724777091.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::18) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c5e7d97-31a9-4c1b-fa4e-08dccdd4bfe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wdvi7lXB2QEa1P6eB1MfW1PEUebb52kS6rP2vgdwFDkQICEOm+xwlK1MbxRw?=
 =?us-ascii?Q?8E9uFa4D+qNtDXiw6SF8dMOio5zdhVNUQIC8jrdoIxZbM6CdxBiZP6ZCnDCS?=
 =?us-ascii?Q?LR5fY3EmbxbtwgTjkMruGbZSIRtPYUDJnEOr03PK6gDIC8Wjb1F/kayNcez7?=
 =?us-ascii?Q?uJxLdm89nc33DJqFO4crN8UkdF1kkLZ4hklVioATn8Adw5wZiV8F/OXmHowC?=
 =?us-ascii?Q?/bJn3nLjtm1cxNJmlriwlLBSEEFq5zulx50UcCRYTAn4xfCKVb9kE4J/1AGo?=
 =?us-ascii?Q?beFWZWd1IsnKDpmIuiny9R9JaH4swLQo9pQFHWKaeJiPPet3+55IhyKOY3vM?=
 =?us-ascii?Q?biQR2uuFQerLQwpmnS2A2y1Chkh8Q78ryysHS/Wn2A3LJwEanwqTXWmq513W?=
 =?us-ascii?Q?T/tLDpXM80InaONg0PIkYf2aQEmpRHNgoJ2VNnITJu0nV3VbVVi4J2yaGYr6?=
 =?us-ascii?Q?jwv1hPfwPzeD1Y8/ca30v8ts7HB9GqZi75dfMtrmrBmX09LQr4oH27zR5z7U?=
 =?us-ascii?Q?O8I8yPUxI9QfXPraGRYs6JQ8IMdG62rgqexRA5ilAmBQT+6fVrdlY3Sy0f0p?=
 =?us-ascii?Q?YBKRVPfWlP6c+ECvIB+IZ+OijV2QqvJeSIeq5XmWVvm/h99ksoe9FM/6KT1F?=
 =?us-ascii?Q?kSYtjZvEPYL34MR3jy4d7BQ02quODQhPi8YjsFz0WtipDQI75mbCHK8I6+/H?=
 =?us-ascii?Q?x/rBVGw3EtRCVR0odPnN6jfsfDdguY8LgkQYVsP3Ujq3yT1GCdX6Yat5tg5O?=
 =?us-ascii?Q?GC/UpYrnon0tNJq3g3GIozbVP+39+oUsLNQbQglVRZbDdH8XsS9YHDT3vUCF?=
 =?us-ascii?Q?8eSV6kIGX9FxSQlWw9Z+e2Z1JWD44XHaCJjz9jaATdZsztVOJph+Rw5hDqlI?=
 =?us-ascii?Q?lCDRZhnI6nP7gzerEGjqnBW5tg5bWZOaljdSTdWPkzx/DiytCsmpk8KDjvKu?=
 =?us-ascii?Q?XVnDqS6771Bpl+cr3N2/ULgnh4H0dMTwkqQuoIfRhG3gPobHJqzr49ZRs065?=
 =?us-ascii?Q?TpghCwQwkYZXtjYFwObsCArB1ND6jb5g3hTGDRTVUkQWM3JFqbQE6gFgWZh/?=
 =?us-ascii?Q?1LBB7O4+nSu3aOGied7kutb2ibKL2Uukrqe6YqUd+o9bebKn8GfG8VbFUtt6?=
 =?us-ascii?Q?gqrnunBLXH03Z8PIx9F9kDySAoVag2rkjk2hHa2vBMikq7hK/frxlQ1KxMCa?=
 =?us-ascii?Q?aO/immt97d1Qg2U1pnSTgMsSjJJDPoZi46w0cBnIb5UXswhr1MgRcntyzyFP?=
 =?us-ascii?Q?drRt1f7aKy5bKnix49430hE7lUudF3w/8bI8sFFkh/3QkJ//ftOXyawMmigY?=
 =?us-ascii?Q?sTgKiP7Gl5Xn5GLbRrzGz4Ny08yi9lmJaTU7uh0w5skMew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ByC8EHqAZqSFgyiLfbpTYSuhBGKx66no3PX6RQzKlFj1bfcLCSH8WRvTshHe?=
 =?us-ascii?Q?ucZq7+7iowRONLZseFXtr1riaU3QkN/G+3Gcgq1qxDRmulbzX9kvY5AM7Up7?=
 =?us-ascii?Q?jUZVBDiRA8yhHTnHSnEgwychEkgSlRqq6foPqYd8XlnQlVCy3zEVXHBz+I+2?=
 =?us-ascii?Q?dEspUXhKU7m+4F9mbSPKQnMJZ4v+QPrq8AWoKguZWOWJi20HCNDsZr4IQweF?=
 =?us-ascii?Q?jvoE78eR2SB0356EQFjwU8IaH9mqJde6VKwNsaKVTw3pk4etMFdqg/9qnCRm?=
 =?us-ascii?Q?vJVq9VRt2psacPU5aXL4rwDVtD+emRwctUFiCK48wdzBc0bbop/nMAvEJFEL?=
 =?us-ascii?Q?xNQ1MbqPj7sFFZPJcW198FmvyY8QZY4I8Eu4lN4Di83SK7QlQqo2V7RCYl5I?=
 =?us-ascii?Q?J3q1IitghBKhoKdJzEfbFGE+paG0iVZ3iq+YM1LfBUXBbA/fHCEMm67xo6Ok?=
 =?us-ascii?Q?V7X+q7lzv4gaZrTjfQacQN3A90Lkxlhc5P8P7o0wJdRvbftI1qGVyr5cAxMa?=
 =?us-ascii?Q?AUzn0AyqSA9AgA1nlDO85MNlJ2utUgudAeu66Iz4Y5m3ESfk1ExQZiJVlviE?=
 =?us-ascii?Q?RgN2315+6i8VKEPgqCp/aB2HnoBDWXZcy7yeifECdFtKvdJyDL23ZkqW8kU7?=
 =?us-ascii?Q?HbZKWcLPnfV3MHgfgWK8KoTvA1UOiU4AF6R/d+hqZ7w4AyMybqTEiatQKCvj?=
 =?us-ascii?Q?aZWj6UhXbqsj9BEpYr/vHaSHf/s5d1pAxx0FfrDd0xTJTcAbLHiFCS/Zw6Rd?=
 =?us-ascii?Q?Kx4phn68cnNxbUVQpbX1zWWBHj27/JRnvgKqxW/eSAuLzJAaLzc9qzVhLKpa?=
 =?us-ascii?Q?asfIz+chFSpV+DMSkCgmtQa0TOszy/Z9xya+COh5xP0sOTKmlOfl+oQIkzQ5?=
 =?us-ascii?Q?T7AIri3SBTZOcRHxUhW4ex7id8PZWNklcZRz2s56FArTll+bASJeS/tfOSB4?=
 =?us-ascii?Q?js+BvVuXD0tIxlWEJXTPNxz0NqWGBIhcohzQOvB/ATkHIrfjotrsqXBm3fqo?=
 =?us-ascii?Q?L8h999FznSZXm4TVNzM2ey010hGZS+3MjWyvvfi7cN2yMAD835QfhoUjW4bt?=
 =?us-ascii?Q?4z1mt9x3UxE35gKavRyEmpFjJWwAQoMXqmWycBTME7xOINp85ZhDuYgD66Ly?=
 =?us-ascii?Q?ad9uY9W+5B15Q9rK1yDd4pmUkOwiCD8ggXQ/hwWFZQO+CC46Y1MHiDrSbU3B?=
 =?us-ascii?Q?xA+odHGqWk+0aEOQgp9z9W3Q3McpfV+diq5UcJiCeU+qTJg7KsSNzlQ6bWJC?=
 =?us-ascii?Q?gnieZJj1jPYw4tMvh/Ggnh85rNvsJzF3830GTiY6+JlIi2ZtvFIrIqlzuXF8?=
 =?us-ascii?Q?TWICTqNuBHnra6eQ59AjtacHr793CdcloVrFA7MbdqFwV9jlozWtNeW+TEJn?=
 =?us-ascii?Q?QFL+ShbukMUusEo9W9pe91lUQYtS3kzRhn6ErhFP9lBfCzftt7sZYxsOdVOf?=
 =?us-ascii?Q?8SobWQVoQwpPioXQ4pfHf82dOv+o5nhLV9j13iq/hxka/hpARFEkeEHeeu1r?=
 =?us-ascii?Q?B9GFakOw2oNJnYQPaYbSBbJM0yp/jtVavoCmNf6UtKLL0cD5a8z5a9I5/SEX?=
 =?us-ascii?Q?wINEOQ8ftW3BByXWtTAPZmmO+RDOcjaYSdFCmDG2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5e7d97-31a9-4c1b-fa4e-08dccdd4bfe3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 18:01:21.7473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DFwHu+Lk9Ea/MBCdsKGR0LNiRcvvldtc+NHCIObQPViQoq+QyNIJKr3smsGJh5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102

On Tue, Aug 27, 2024 at 10:02:06AM -0700, Nicolin Chen wrote:
> The iommufd core provides a lookup helper for an IOMMU driver to find a
> device pointer by device's per-viommu virtual ID. Yet a driver may need
> an inverted lookup to find a device's per-viommu virtual ID by a device
> pointer, e.g. when reporting virtual IRQs/events back to the user space.
> In this case, it'd be unsafe for iommufd core to do an inverted lookup,
> as the driver can't track the lifecycle of a viommu object or a vdev_id
> object.
> 
> Meanwhile, some HW can even support virtual device ID lookup by its HW-
> accelerated virtualization feature. E.g. Tegra241 CMDQV HW supports to
> execute vanilla guest-issued SMMU commands containing virtual Stream ID
> but requires software to configure a link between virtual Stream ID and
> physical Stream ID via HW registers. So not only the iommufd core needs
> a vdev_id lookup table, drivers will want one too.
> 
> Given the two justifications above, it's the best practice to provide a
> a pair of set_vdev_id/unset_vdev_id ops in the viommu ops, so a driver
> can implement them to control a vdev_id's lifecycle, and configure the
> HW properly if required.

I think the lifecycle rules should be much simpler.

If a nested domain is attached to a STE/RID/device then the vIOMMU
affiliated with that nested domain is pinned while the STE is in place

So the driver only need to provide locking around attach changing the
STE's vIOMMU vs async operations translating from a STE to a
vIOMMU. This can be a simple driver lock of some kind, ie a rwlock
across the STE table.

Generally that is how all the async events should work, go from the
STE to the VIOMMU to a iommufd callback to the iommufd event
queue. iommufd will translate the struct device from the driver to an
idev_id (or maybe even a vdevid) the same basic way the PRI code works

Need to check the attach struct lifecycle carefully

Jason

