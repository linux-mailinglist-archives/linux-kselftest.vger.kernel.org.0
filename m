Return-Path: <linux-kselftest+bounces-34079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDDCAC9468
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 19:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2246F3BE233
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 17:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D115522FDEC;
	Fri, 30 May 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ACRLD7pH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA7176034;
	Fri, 30 May 2025 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748625124; cv=fail; b=Z6wFjRhaUTGsxi3R3k97KjFBtXkcgDCw1jmnxHmH7umdGrD6TwY3W2I8c1rB4Uxl3Cx/mczef/qQLfZ3A3JkfmAPe8/7/DlfBtXtJd3TV1CJ5tpqjsMR7MM9msJrKS/Y2EV77ke7okn2TIDuwjtMvCgBZZ+LMj2HZ3p9KbIiwQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748625124; c=relaxed/simple;
	bh=Oe3xLALMODaYCn6QeWQYb1ClxJJ3NBv65igZuCbOf+U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lnm6U1JhKfMW9VkKlZ4kz3Y58wZqlKddmPDoXEz/WJCp80K0NNSMYcPkH6f3siHnn6mFU3cjv5kDRGqin2QFFlHJB+DNZq9zRICleX64zXP7mojgPPT4OzqbcuZAZSBLc6u1tu2M9wHH6CVFVuz53uWgbJVmIV4LBRSodsJY+tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ACRLD7pH; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dn8T0zVCEbiNoU2eE8k+Ij0FNyi4H6X98fzvNT3zZj7TRZIqiXJiyhaJhDNoNNP76Psd5QIGFSNh1RUZ5HNLCo/gdtzH9R7lDwLf7zRxwCud8WT6x85+8Tfn1keoXiqmFv2+zAu5JbtIPOXwjvDyXycYSYb1u2kYpGc6OBFS9rtOLO69GMeIZwXOOHCnYjbJen0s9m1mN9hZlcbJ4mAcPcX1EgW44FdeyeE0pPYSVRtirlNDqUpzZaLy5Li9zk3NLQf1CGvvbobNy8TST4GGY0B/h4wZZlrJl08LRkj5ioVNp9NOob+85XN+ss8MJWX+RERlHylrhhIE1hVTcFsKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giid2Id7kT+eRBZdYI8hV8r6H2yNkqiUlyfCapIs9kE=;
 b=rBJ1rqiUuLyQNoXCBuFK+mEo0lcyJDZg5xPc/T914z6bvjiUgoykaOO/e2Qyyv6sLGuytow62ipG+fUhNs1LQDHDrvT7rQ8eSzx9Xf4yM8Pb7UNnd4iR3Poho6kVpXvrYi/CLS0Ae+y7Ipt5IB09UIG53h+6hnxblOsrIeM61bnVw6HVTPaaOPVdZ2qCdZ61KEiBXEoNi2UI9DQ1t5ecVjWV6Pq8zhZ79fIgM6WvxInRTae4weCafU6RQ4YN2CSBR82v35Q2chQXv2Fa5PuYr4GSenPRbfJslrdgOVLSXSPk9bVTkA2akUsKfQ8Ch3Qxk4rmn3RhHhGsVJAlV41biw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giid2Id7kT+eRBZdYI8hV8r6H2yNkqiUlyfCapIs9kE=;
 b=ACRLD7pHMW3xst2aitKaarolZkTxHGsaSvhAIvAtPCapN37DwvfFKpHogIKENGHekO4y5MY/u44CtfdMlIz4hzcRvZiT2i0MW2XVxI/hRN6ec9cHzawd6smFKFntXnuBJCtGDZH4qJAtITSCVasFwJyGylgldjXsznWbAXVfo9Cod7Uk6lN5zcKLyXFp3ZFxEHK0qyD5YsUsWgvrpQjVZyXvI3wLTVxkWIJvoChNsMkwq2YqqKlRkTE7t7BUuNaixOA+CU5lKQw4uyunncHzmA65GCkyYbIk+obzcaqTVwSBf7ggmGRWsEFacQjCEmQjPv0vzn5zv7/dnGpyURiDDg==
Received: from SJ0PR13CA0006.namprd13.prod.outlook.com (2603:10b6:a03:2c0::11)
 by SA3PR12MB8000.namprd12.prod.outlook.com (2603:10b6:806:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 30 May
 2025 17:11:59 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::a5) by SJ0PR13CA0006.outlook.office365.com
 (2603:10b6:a03:2c0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.17 via Frontend Transport; Fri,
 30 May 2025 17:11:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 17:11:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 May
 2025 10:11:36 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 30 May
 2025 10:11:36 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 30 May 2025 10:11:34 -0700
Date: Fri, 30 May 2025 10:11:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 21/29] iommufd: Allow an input data_type via
 iommu_hw_info
Message-ID: <aDnmxLMHq+E9UnVw@Asurada-Nvidia>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <a5781101aea86e223ab23e88062a82c95ee3c411.1747537752.git.nicolinc@nvidia.com>
 <20250530165218.GG233377@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250530165218.GG233377@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|SA3PR12MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: da1803d0-0701-4cb6-0074-08dd9f9d16a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VyiZ8GJfsARF+Yf/3zGhT3HY81P1RYWDY13z5h5cKnLLNtYuHnu/uGYA0nCf?=
 =?us-ascii?Q?dDgKK6dtcZ4lRdsHR3aeJVKtjfQa8ueVGkyTIwxmxHJpcS5NHjVPXy4jDm22?=
 =?us-ascii?Q?UxRZPpMEdhpPwiD/XVu6XI+dybnn+phtZuUlcu1PDHNIaZ7Pp+lQTQsyVWVK?=
 =?us-ascii?Q?8ZZHZ7AAMb+jKSp0JVHk991RzLc2kVdG+fDJ17G2nR5JbT5TCUHOcQQQ2ljh?=
 =?us-ascii?Q?o0V2VEeH5WBaLEM8CANMBPMtSHNEGjcLdGrWtPzo1O2itzcVQTu1sMxxJ6Qg?=
 =?us-ascii?Q?9tXJKM0SBGlDRsNkRCL61HS0S/XD5H0Gzdyye3qBlmbVot/e94/EzVBGryS4?=
 =?us-ascii?Q?ma7/P4ILdOywZNYN71nmWw2fr89WliB0QedOmBDXgJTfGNyvhMr4ZHVxBbB3?=
 =?us-ascii?Q?CcysBgPv0w2ddjqfpnniRF5iHnXOXXTtpuHfmPm9C+Bus9MGJE/4zcgytQVB?=
 =?us-ascii?Q?LitMXObAmDb5LWlA2kk3EtmVql/Z0hT7Q+lZc+2+FmyfhRB3gtMz9N3KAEWb?=
 =?us-ascii?Q?ZgGk7QKoAomOFSvU5kEoK2sEFvU4Rl9nGXLnkYRfLT8VgFr4BERTvlSWZ9rU?=
 =?us-ascii?Q?9QBu66/XLIDeNcv9V6irHeRzZVW+huDNbXPEl6VKoISO+/PE31O+Yx4V66fP?=
 =?us-ascii?Q?3bBA4dcQoF5NjHT2xG4Vvdq3r/vxDoJuZ5ZD6dQAB9ZJG6ZltWTeQy+1DhkZ?=
 =?us-ascii?Q?xlN4k1w8GzwaQQmE/xLfV35EQcahO4lECRcNr8+f4LAqWYTN9E99qRt6HX+f?=
 =?us-ascii?Q?z5k/RaUY5eVLCMu4nJ5zLlivkndn5HDaoKjmLRSMjZklhsHtH0alCZnoZXOA?=
 =?us-ascii?Q?qyGxcAo3hutAwoQw/yJtIUKarUp8r7QY3525WUldXjzYPTAJHPu5Sbc1S5OO?=
 =?us-ascii?Q?5BGUxbFEbYBK7Y2GGpDnqsMgaRPpwnubUWLBGGyJ7pK15LvjZSmGOAyjfQgm?=
 =?us-ascii?Q?B4OdVp95++YLmCRdSaFaPgpxO44VriYINpJSUjF3JlXH0omccIJOM+2vI6cu?=
 =?us-ascii?Q?mUth8sjuZJLagh+WpUIqbv+x/A6hNIZiDE2Abw6TXcvafKSujtt2sYIDh14E?=
 =?us-ascii?Q?0FwqgWIkxkeTmZFxM9G5i9FUpacmMQLLdfhhF3NWd3nxlF8vGh5/d7pQ55eS?=
 =?us-ascii?Q?sJMl54qf0xQz0IzkKl38SxltxFbhe6dVxYdYzuD8h+5stXyvP5Q3y6fHdJJa?=
 =?us-ascii?Q?ebhJ19NTxlW7fBU08Gs6o5yGPdnFl9sbZRhqOjq0sr6NNhvCRka8EDA4xXM5?=
 =?us-ascii?Q?fyTYEJ9JmYs57G2T+/LpQUKkMXEIuKUUF/g+Z9mv9ne/3fIHuRZdK7xJvDdZ?=
 =?us-ascii?Q?wCrmlI+YW+lsbwH2Q5XhS/8djn6N/ycPUxivvEKuttRGOLbc9q1s+SksT4SL?=
 =?us-ascii?Q?bCNo9vuM5oeqaZZmhnH4hfopzrsrW34o0ioFH0cEgrLrlIXx1QSq1fSNIL0Q?=
 =?us-ascii?Q?eNHsCw9c6t990uv1MWclkHFk/P1tLiYd2/A8UZJMGk+GEkY421llKWzXbND7?=
 =?us-ascii?Q?tsNawM7KNNprmB3da4oDJHPgII3N+7XsNGSk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:11:59.3594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da1803d0-0701-4cb6-0074-08dd9f9d16a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8000

On Fri, May 30, 2025 at 01:52:18PM -0300, Jason Gunthorpe wrote:
> On Sat, May 17, 2025 at 08:21:38PM -0700, Nicolin Chen wrote:
> > @@ -666,7 +678,7 @@ struct iommu_hw_info {
> >  	__u32 dev_id;
> >  	__u32 data_len;
> >  	__aligned_u64 data_uptr;
> > -	__u32 out_data_type;
> > +	__u32 data_type;
> 
> It would be better to avoid changing this name, maybe stick a union
> around it?

Yes. I think a union is nicer.

Thanks!
Nicolin

