Return-Path: <linux-kselftest+bounces-17304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB09296E0FE
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 19:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1921C25378
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEF81A0AE1;
	Thu,  5 Sep 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KdBXKbbd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE171A01B7;
	Thu,  5 Sep 2024 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725556842; cv=fail; b=ccveIkTnZiMM7LX2x76KWYBE9A/4DrclTwfuHpaCZvLvx6w3ENvBeZ96Gg2jqa80cKoi9NZfp2/5UlKHWlihY40VlX/pUpvM1YFEWDOG2lOr1WB7agGUFA+EkxcCcj6JKGLkbfr2eC0GUGNKCQEmTkDVFGq+8u+H6U7LKzvUYd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725556842; c=relaxed/simple;
	bh=Ecijq/UyL4sSB2tRJBRiUrfJ9v1BzRqBN82lBVbyjkI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0N5H+zYKyHxbemI01Mwsg9Yk8zMqADhhxecxPl/b0DMiYXQuEVpS2GCk5UtmgYZotLikbV6H4TUJIkwuYZIps7ohTRp1SGNwYBNM5j/PQG7R/8K34OdRVyz8uhAoAdiU/RRP3hfb/eyJEdwAqhXKvodN9A7+rjOZCnfdZlHtMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KdBXKbbd; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAj9H7EfXXDVG0AF2nVvp/MvCWTvEpxRtj20frcMqUg1oR0/lqmcIxRk9w6VfakTvMJN7HsoVvfCjgDhsuIhzOmNQBLVSxl2o4OzS+7eYwngSFN9YXPsvQizBKiouSa+UIPxKlt4+15TNclgBWgPRMB+clVCCFLbi/M2gEMEjjW4EiW5kBv0KYo6v1gf3pLiIhEi0XM7idkay2ksvQxw/f2UUaM2stK1lgZUs7PV/HqOh3I08Qp1+1Aw3RF6Hf6kCKQhl8DoJS7hIdZ3t06/wmmlGi1w6Iw7lmHh+PwMBTnMYKpawo8hkpOG3uOBuPlzw/kGtOWCI4moEQM1WJ2L4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRIPOC8OmpjFE4uuYOnFOa2mwvl3O9kXj4IjDUJPoy4=;
 b=CINRG45z2LrV36TOuTpefdvXjOrn6JsKLdXP+hAMM5GkSar+04r9YzC1EGI5SMxoUnjDpEQR4EWrRr8SMdPYDvkmSizjeqnehJm2xioo7t/0JMjeV9hXtEnLqbgNmo+XvhkZMK/oU9FfHHqSHoGgCZ0VKfAMPhx7y+g0x2kUyMgoTeBbRI0J7ScFA1Q7SIiAXj7C1GUY/OYbLBnssh3QkqjQizfKOVn/M7Z8vXFNVTaqQlxiplUFcER/QMRV3M4tQDzis4xUsl+UM+JuielqyJkigH20bVt43zqGOz1ePLE1D/aYVGC7hgKiJZ/v95G5BCSxTJiyTf1EWDHqW1mJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRIPOC8OmpjFE4uuYOnFOa2mwvl3O9kXj4IjDUJPoy4=;
 b=KdBXKbbdS8dLttUd2E3U25D5fMdqfe3iMENnL/HwBSXujaR0lwK63NzhD6rjwX/YpT8Ls5U+0zhRWBjSxkl9UAP3dWhnRmOfHytYoDEceZu3fZgU4lEa/sTFkxXYWHfoBd4s3zR8UC6261GlkHdHtyTzInr/w/TyuCQGiw9Q2IGjfkBuAgD+IoEe17r/zkSqt/wTXjqAo/TnHq42lcVEP7TDiZp5eXVfbFm9OdNSCmgeMVm8roBTatENq7OSd0rXmeN6zi4r5ck1zrj03k/hwE5HG5TwwV2pK6+KDYOYcOZ1m7QMTDDN5YWTwgocdaLZFgm2Ifk9HzofuFD3iVGRsw==
Received: from BLAPR03CA0052.namprd03.prod.outlook.com (2603:10b6:208:32d::27)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 17:20:35 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:32d:cafe::37) by BLAPR03CA0052.outlook.office365.com
 (2603:10b6:208:32d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 17:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.2 via Frontend Transport; Thu, 5 Sep 2024 17:20:33 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 10:20:08 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 10:20:08 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Sep 2024 10:19:51 -0700
Date: Thu, 5 Sep 2024 10:19:44 -0700
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
Subject: Re: [PATCH v2 03/19] iommu: Pass in a viommu pointer to
 domain_alloc_user op
Message-ID: <ZtnoMJPdeb17Uj/e@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <d6f9be955372adbee1e53621d349acde0c79aad4.1724776335.git.nicolinc@nvidia.com>
 <20240905155454.GN1358970@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240905155454.GN1358970@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: c17f7e31-589f-4ee6-74ee-08dccdcf0cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CioSm2ZZFMDgLu60RyYEAxK3ARryQjCXDolY6G8hhurh+zTZDFXtyaTHVJfV?=
 =?us-ascii?Q?VlUhg4BFosD4eEC97G8AdZaEkGjGWpM8tueo+1HjBI472fSIHlS4KLbPmvAc?=
 =?us-ascii?Q?vjgfvH/NxscUnODXqUSu0iph9a/X4zMcgL/YWxRr4bx7qfjGxs8PdS+vYwcz?=
 =?us-ascii?Q?M+Cp+LLHaFbDPa4rLb8LGItRPyfIsoVdyTExJ8uHY2ZpM8pHr7s0BNHzXWuQ?=
 =?us-ascii?Q?pwaXgne/+FTVeMOMh8VsflVQh+jPBzRYhrBvMCLMJyA/YpL7s/JsYwZVF2WV?=
 =?us-ascii?Q?t/CkfK+016Egv/w3Sn/amg0Xw8M6XhydUnWsFyOqCCpZM1gH96nhw4ZMcfsa?=
 =?us-ascii?Q?oJEUWPZsXlQx3BO5L2zRxO9//2kTs5YL4p4A5xNffjmz6yHRxosdQadfza8n?=
 =?us-ascii?Q?kX56um8VsvWtMYNefqe4jqBNybHT1QFDouVgne7NVbHMZnSrYrjykhPhd+Ia?=
 =?us-ascii?Q?Nwayhh1z9TKnEPYzFWYKkKPPlcjsWe5A7sXdKNGo6kwVIlrSMxAQLKSXkY9a?=
 =?us-ascii?Q?oV5IJQo857GWbybMOjpSJWbKGnsbFZYyyQH1076XXwUTGejbsXGVKLfAmsr8?=
 =?us-ascii?Q?UqEJqkZZWNv7BuZ9usbbBc4L6bwCtQE8eDbL4Hu4L5eEVVFqiPB8DlmKH+3K?=
 =?us-ascii?Q?3HFy9tJo8RDhifuuEJUxJwRhGn6dyFWX84WmHbaLjeOwQXR1pLWUn5WqMlIC?=
 =?us-ascii?Q?fvGhxY4k0xBjYCA1U27z2lToR+t+G7j/MY4mJ8BJivcBVCZ9LL1Eq3JNxxvQ?=
 =?us-ascii?Q?UPqRTPzSBeVpPrPJjhT9KKA3F1+Xv7IO89SeiOeA6SZnTQGKi1z5fvfE0/cp?=
 =?us-ascii?Q?Vfh33qqBuAtbrqUTQTXyKsNl0Ce0mj3LVjPkoiKFabHa8QGVpzoL/YlrrbUI?=
 =?us-ascii?Q?+SAA6s8nQvRNbyMbXGlAHbkm/FDr8/egPgCYJg8kheAx1F41EdBzcxCuNPPU?=
 =?us-ascii?Q?yIDagIuhjBd7tARDMCbyOOkH1P4HDKlJKkmFVMTtBMZK5mukRGrd+LdYRDyG?=
 =?us-ascii?Q?N50HinVQAdb901bt72iLXTwCAO/rvFyL1nylR4FHyOX+sWmtIhJx/M4jhpMg?=
 =?us-ascii?Q?NRqHp8hzLtI48W/U8o+Eur9hFGqgnz7dckKq/SjQSI+cIR0miSWEUvYiEPbC?=
 =?us-ascii?Q?PLfP3s5VowX9986ebnhd9GJ6+79tl/SXTvCBJDtMOMvnevmTKxtdFQg4Dvn2?=
 =?us-ascii?Q?m5AwxZfh3OJokSSL79ir+I9DLqr6v5OJPGcwFsGJhlLGMOigSQTaAhU64ZzK?=
 =?us-ascii?Q?rUTVKfbys6e+Tcq3BVC/XUBJ6K/oxlPZk5z2sXxuLHoxyUezrnPtyWSvzDV2?=
 =?us-ascii?Q?IDoeDcqLt5JFANXMMyzK148f0OyDZnxxUaY1HRfsg6gwoiLIzEI8i6Fnh/T4?=
 =?us-ascii?Q?DtUQZVMzT7UB0/ewkfdrSnhc6v7eDjAfrk8jS5P+uTVB/1Gy5kfaA8eFEkcg?=
 =?us-ascii?Q?DvT64ZCocmV28stptz8568NWuSLvC/Qc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 17:20:33.4190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c17f7e31-589f-4ee6-74ee-08dccdcf0cc9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241

On Thu, Sep 05, 2024 at 12:54:54PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 27, 2024 at 09:59:40AM -0700, Nicolin Chen wrote:
> > With a viommu object wrapping a potentially shareable S2 domain, a nested
> > domain should be allocated by associating to a viommu instead. Driver can
> > store this viommu pointer somewhere, so as to later use it calling viommu
> > helpers for virtual device ID lookup and viommu invalidation.
> > 
> > For drivers without a viommu support, keep the parent domain input, which
> > should be just viommu->hwpt->common.domain otherwise.
> 
> I've been thinking of add an op for nested allocation since every
> driver immediately jumps to a special function for nested allocation
> anyhow without sharing any code.
> 
> Adding a new parameter that is nested only seems like a good point to
> try to do that..

Yea, it makes sense to have a domain_alloc_nested, for hwpt_nested
exclusively. Then domain_alloc_user would be for hwpt_paging only.

Thanks
Nicolin

