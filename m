Return-Path: <linux-kselftest+bounces-17315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1824A96E179
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 20:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5437FB219F0
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 18:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F99179967;
	Thu,  5 Sep 2024 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lh0eyyB3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C00979E1;
	Thu,  5 Sep 2024 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559491; cv=fail; b=L50BfaMm0Lo77aXdKuFv0TCBtoERKQ+6BhUu15N2am6GWpakO1Arl/Yfgrjc2SYLN4SkY/01oHK8tkwk3JlD5DkOcGhnnF+oVk06jHFE6YIeeO7DKHEBfT+cTu4xM1iJzOu/hatOz0VFUYCgJmStpG/fxcKO4AsW39dmt3oE50c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559491; c=relaxed/simple;
	bh=YaswTXksL2oMlwcCwNqBVcEVscM14XkvEeWXDi+XRGg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+N2b54wdGfpowUcFV5jSlQp8N5iwf8oSIwwBq8+QpqX1mwIwMpq9RdCuiFYj4pdWBF3e7Xc7T8rq/zqUS6TRqKcUypV0IVI/ecKramTvLx3+upZaVJ9j1PYJllDv4j8gLsBZytXAUW1hOPWGig1yxjyMicDpu1I6wz5ztax9C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lh0eyyB3; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7b/bp1BEky0N0r3hC0n3S72J+MB7DQy1s3kUq1QGSl5QqCrOTN3pLDlGQG2k8ust02zoybi3oXCAKlPeaclKO/SGgAeJWfklHMR3JPRqQZvCGca4YQBWfkkSdOo1RqPXpQ/QX36U0KotlhXJOAbxCG5JsSffUMHFLZF+rnd4hakEpXXcJQqBsBXw6BXVy/58Fx/OkkralrHZVGr6Yht3EluLjbn3t50AaK5GJpQLyu10dTWK/rn/7rh3/RSQkK+RxBE6jwKMyXXrsDL5xzg0oUO/2GBQxKQViB7w778wqnE/sq3oU6vZLrwz+ilLYHFP3FKkvHwElo4k512UNaC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+E+vkqn4JO4NLeIFU/WxxPqxeG95NKA/QT2BbAyjEk=;
 b=m4Ce/M3cL5/4TUZ7AEortvRiQo7ZlGu0K+FSYqvCA+fnmW9AFWv9vWLX9Y1K+ePcguteorf3S3ySYQx1z9vKJCONVStpIgstCtmX50UWUcyyR75jUnuWsVG1FFRNMSefcqpsVKUvZc4E6T7hSMUar1Wm1FdI2BV6wZi1Gma26oVOssdjXi4ZfsexTu+UY/NgRAuLfiB8MgvPxdoiHJt5XZGeugiaDhIztHiTKk0avKy9kISkqnQbqFkx1P+5jNNLN669lsNmhbuxdyyTOLZK9ww1ub8eGdsNsHVYB/UviSi/i5itPiVichiNB5U92byIow7Z078h6l7poHfFIXV3Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+E+vkqn4JO4NLeIFU/WxxPqxeG95NKA/QT2BbAyjEk=;
 b=Lh0eyyB3UJJlCXql3GXVGcO2UlIKLsio7if3ND5EX6aq8lgSp6+806LqGd0VFJS8HR8Er5htBoWsxubMBJ8w2lww9Ry1x6CELiPTKxC+Gfaati5dY5LQ3ahrCrhd8zhfJ7BnpjqBS8Lj/eKRxPAG8rXembWTNykvbU4EA2fpXkhrpzJywyi+lrBLug+iZhC24NpMU8doO4A+ti98bK2pkwspXFnYKAvcD4reZZcrnuLezmpf/gV2CcgeWPAotn40uVkkfoCUyAQLlvEUFengG6X9TBhtp5anSUMbJsorZoDlssBZhrfIg1SVLT/ALfAQxr1uwe7wKWRlQBeshkkkJQ==
Received: from CH0PR03CA0206.namprd03.prod.outlook.com (2603:10b6:610:e4::31)
 by PH7PR12MB9224.namprd12.prod.outlook.com (2603:10b6:510:2e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 18:04:46 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::ae) by CH0PR03CA0206.outlook.office365.com
 (2603:10b6:610:e4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 18:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 18:04:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 11:04:31 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 11:04:30 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Sep 2024 11:04:12 -0700
Date: Thu, 5 Sep 2024 11:04:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 02/19] iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and
 IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <ZtnylrkYMwzbpAl2@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <c6ac7dc5031e96abb4634db504a0bf4a0c82ca66.1724776335.git.nicolinc@nvidia.com>
 <20240905155302.GM1358970@nvidia.com>
 <ZtnmDvhVVKeE4Z/u@nvidia.com>
 <20240905174100.GV1358970@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240905174100.GV1358970@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|PH7PR12MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: 059d0f8c-4049-41da-0be6-08dccdd538fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F+YZ5KpzNEV74t14gN4YJ9qrKcuC8TP6MBdQ/DxDXNsOp3ZZjDZVcwrnkVWA?=
 =?us-ascii?Q?oaz+eta2UZyYXD2ouLjfL7SRpUs/DQWkLby6dtpdgeNECZiTobl5rW9UTioO?=
 =?us-ascii?Q?13fGYceoHnJgF2Eho7kjZ50cnZFyTs9QiJKst22K8eZrqHXEnra0BVM/Nnuw?=
 =?us-ascii?Q?eZlTx1UsM8jKBg4MpSEbgNkumo6D3Ew+pcjLcaRHSMlmEOWs17BKY7rEX6dR?=
 =?us-ascii?Q?d2/2Jg++kZIqk+Dw01mJaNnHp1kuWYXqVCI6U1DNXHpKpl8saPugqklbPoH2?=
 =?us-ascii?Q?OUuCvTaxCyZiiU8cS3Kkacjvaox55WLugRGjKQBP/E9+wJVl3kLUucPAdt/D?=
 =?us-ascii?Q?Zn1Ki0sBF/VKl74EQzDcHxy2b6Z0D7waaVwMqJnhOXW76PyXv+fNzCDtc2/9?=
 =?us-ascii?Q?N9EZIQdlYERdDgjLxRENDzAK6U0wyuDqJc9d4FTCCpcDptAKKLw5hn/W0Sh+?=
 =?us-ascii?Q?ShoZ6L7NjcMlkBU7DHuX9cZo/zRkbFocd1kjk09tuY9xeh71v+dpTO5+1J/A?=
 =?us-ascii?Q?7BdQAalVRtBcqj+Tfwb8sRP/7nXFpDYZNchlG3JGX48D5rV5FiifgMMk3Rt0?=
 =?us-ascii?Q?nYu8cUtyJvotykA7M2STmUJ9Hq7pErw+Ug3JQVtf+fXYpXnbsh9DWYqIHdrV?=
 =?us-ascii?Q?oaE/02NDoVgq0XoplFHYqAUKZ3h0GoFK+lG3YtjoArJFK2pUdFVokIgkjJP5?=
 =?us-ascii?Q?KRcbBBnnO/BgkocZGrUoSZRC2J6FedDPKccEAnVtxRr2iabmuXbQ69FNGoe/?=
 =?us-ascii?Q?TQkzJzSlVAhXqSzs4xZD8+GZUqrh+7d0HlXGoV4VIBVCcYoTfAdW3AKoUj/i?=
 =?us-ascii?Q?ncsal4FBdheBLLWznJaPL8urpzSF8EXXalXTC6hNUTgDCvQ54REGikORFUL5?=
 =?us-ascii?Q?qv5N1BFQsBYlq2IKFl74eP6rXIzssuWBw/qG63BF9wsc9HSd9Jtsz0EW5nha?=
 =?us-ascii?Q?sDEfCieDIE6hTHFErz2Mbl9NLHOYb0ydXglav3+kShsuykbLzZ81Jw9fRWE+?=
 =?us-ascii?Q?kqAFI2YIidGwEpuWvypgQWHlfB8mJ0UkG6izRaWup5VvR/flb8KZWHQ/KZtW?=
 =?us-ascii?Q?/sKb60g8KXs64w1Gnhqv8uSlYvO0uXD+whGhkq3ErfEH1yoANrsIFB75uXhp?=
 =?us-ascii?Q?uy9EPgSQ0jgGrSeMBdGnfAjYrCp9MxAb0yk0oZXB+F4iDIWpGkWK1QFEE0N6?=
 =?us-ascii?Q?VAxbcgLr9BvCamJps04j/9LPiP19SBacCC1Qf/J7I4YVNeBSNGFCTIjQOA3Y?=
 =?us-ascii?Q?w+rXzy7t179mvRK2kEHWGhrD6H5h1Rnj/xuMIjaoxcBnev5lGM3Ift0t2Ptr?=
 =?us-ascii?Q?gdUJsDbVgwuf6LLV1kunnzY7asY4yt6K6T3s3jSYqKmXx4ChFYGJZM9e18Hk?=
 =?us-ascii?Q?riFzf5UZ9WKxheObMFRjelDECMHc46kTM3rc1USsjP31zfX2bcampQ3Ozrt1?=
 =?us-ascii?Q?5DEJFA2zTeWTbAGGd0OYYz44LvmjDCyO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 18:04:44.6106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 059d0f8c-4049-41da-0be6-08dccdd538fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9224

On Thu, Sep 05, 2024 at 02:41:00PM -0300, Jason Gunthorpe wrote:

> > > > + * @out_viommu_id: Output virtual IOMMU ID for the allocated object
> > > > + *
> > > > + * Allocate a virtual IOMMU object that holds a (shared) nesting parent HWPT
> > > 
> > > Allocate a virtual IOMMU object that represents the underlying
> > > physical IOMMU's virtualization support. The vIOMMU object is a
> > > security isolated slice of the physical IOMMU HW that is unique to a
> > > specific VM. Operations global to the IOMMU are connected to the
> > > vIOMMU, such as:
> > >   - Security namespace for guest owned ID, eg guest controlled cache tags
> > >   - Virtualization of various platforms IDs like RIDs and others
> > >   - direct assigned invalidation queues
> > >   - direct assigned interrupts
> > >   - non-affiliated event reporting
> > >   - Delivery of paravirtualized invalidation
> > 
> > Ack.
> 
> Also write something about the HWPT..

Assuming it's about sharing parent HWPT, ack.

Nicolin

