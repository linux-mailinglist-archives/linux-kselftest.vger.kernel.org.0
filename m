Return-Path: <linux-kselftest+bounces-31570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 491D9A9B313
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 17:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852AB1757DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 15:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4C327CB12;
	Thu, 24 Apr 2025 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IkJgtpaP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A98130AC8;
	Thu, 24 Apr 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510076; cv=fail; b=qgOrUeE8y0+JqdF46BWp66aLHS3sB8nS/ood1NjjPsHLZrpAj1s/IWOI9+kh7xJgouVL+BoWLq7zzS0anxLOCljGyLro5hGqFO2eiy7Ne8kECVsjL3fSP+uBwRQ7OB9Yqc6Zxo52Go1xkEy2PRlFSlUGGQaUMLF55SctyCU1svM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510076; c=relaxed/simple;
	bh=9bMnmoKButLreF2/P0L5NwfzD+IUXmnSX5zSpR8Bkxk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MusAeOZafohAc5YLNjKVAtKwd+rrW8c2C1RPl/TaDC6F+WLCdJVoDR7hMU5IN+uTP1JBALFrS1bXeLEdH19zepHp6HfE4HCvMrP7lZYlLeqaAeTZHSSg87Dhie+R4F+wakaMfNc0MkTRv3dGqpYI5AHXe3Sf/tUzheOkz8i/eBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IkJgtpaP; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ti+XylLkXDIzdbeP6RWe1qygFw5RHwsDLiKP2EdJ9geOMJjvbv6udksNy1tKbZeXljP5sD9Xg5Y0muRUKl1H1+4DhXcGyULk2uGonBxa1yEoBA8U6cX40soZC0AfnvtFuCJR+xtGRr6mz9BNS2B0MN5wwWE2JOuMY0q4k6hd4MF/hFSPg351pQJhLDtJgDMj/gXi33jZnQBLEENsPDqmdo5ZoJqeaJ+Qz3i3Js0hH2kWvxAuoJueP0QkxBjxcDOFs5J6PhBf3lRPe31DvGjOtsxssqgpcLgFa3m32YaCUszh+6kIT9fEJuPVDuH7hb7lr0KIj8pML/2IgN8UMeabfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8p4Q93VuGjMMJlzt6Z+FMJBOH/YNHCIj/0ylEP8gwQ=;
 b=VeZ07c0YrL8Lde65swEDBNUteM4SnP4CSgnaXSbgZnRe1r6lNR4s4suFmXkZqAiI2LY7ReS93TzWOVwzqo7+T7Reeftk5Hlt8Fb5k4+2JOcC9m+d9tb8nzWUNBC5kcpBClVEa6b7VY/l6jazcE4YmfcBdPKus2V5DmCf3tKsmZXHPHeNkGb+QN3UAunjUdWJSYfyLcZuNljjS/LS843ohDNfCBIwOftG0CpYII8UG4Hf3TkXT1EK4KMUPJE1g9HIbDrLBJE1UoZ5u4gzQwaoYmzCc2z6WMbjiFyNVfDaa11huVIKSu2r73jTNL7uNtsCwPyLcqBedcltw9TlByQIqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8p4Q93VuGjMMJlzt6Z+FMJBOH/YNHCIj/0ylEP8gwQ=;
 b=IkJgtpaPJATT9HVcGuz8XI+BajbyRyohnP3g/L0Ho13bz7bP5avXwyPy7epDWj5NGNunqK0fKEXp8/ofxb7e4w4FSpDPhLwSTPsbemjFOpK7kYmCdPFhGRHGGUIxKWtEmwVpPdG216H+JJPklwXX++2RgtyvAfQxim7rms5vEAPZF8VC6ryKsrmenNvlI1sVz2dICxg6buaiZxgHpnMVo1CmNy3F0D8Mak2UKjTWhqXAu3euEKdd2KWLoGfAYKlUdDVfxF1mo+YzAOnlIK7unBjQOiKYrtUZhyRWf+mGMqIO9sCE7dRjZ37Q9FhW6c57kd7te1BJzBSqgdIg+bdK8g==
Received: from BN9PR03CA0044.namprd03.prod.outlook.com (2603:10b6:408:fb::19)
 by DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 15:54:30 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::83) by BN9PR03CA0044.outlook.office365.com
 (2603:10b6:408:fb::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Thu,
 24 Apr 2025 15:54:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 15:54:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Apr
 2025 08:54:17 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:54:17 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 24 Apr 2025 08:54:15 -0700
Date: Thu, 24 Apr 2025 08:54:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "praan@google.com" <praan@google.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>, "mshavit@google.com"
	<mshavit@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: Re: [PATCH v1 00/16] iommufd: Add vIOMMU infrastructure (Part-4
 vCMDQ)
Message-ID: <aApepRZrZhywKqo6@Asurada-Nvidia>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <BN9PR11MB52761DAB62D3A4D3F6B53F698C852@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52761DAB62D3A4D3F6B53F698C852@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: d22c8039-7c04-41d9-e96f-08dd83484ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pIGQMmoaeTTbl/FHtrxVb1LL3AKztrOXLGq5KKzpX7iP8RID67Jp0xTfUBIJ?=
 =?us-ascii?Q?MfeYr+Ha58XtUmRZo2OIe0n7lLoPS48drwCpYabsDp+3Fuw2YYIfL8QUw6kF?=
 =?us-ascii?Q?nXHfX+oSXt1qu3hXsDdgrj7xT4yjGmGwza/D9AEwCbsa7p5kbxZJEGde+DlD?=
 =?us-ascii?Q?aiXHeLaxiDWuGs05HtuwodSV5AlKOxFA4gJEq1O2kDIQJAtlo+GT2Pd9RIGV?=
 =?us-ascii?Q?XLmIi8ah+kfdkIqBmkgYQ+1pr+X5Th7gCflgI8yfU6XfJzsXDahvSPCiRUI0?=
 =?us-ascii?Q?Z6uXMoOC0HggvQKbTufTy+GB0QsrFVSRK3cgNQMCRziaeiJDsVffoIslyxt9?=
 =?us-ascii?Q?IqeMlGZe2CxedhM/wMuQshRLk0hn2ECEj5Ib9kdC1SQnrgWnUI41A0SZZY3t?=
 =?us-ascii?Q?yL9jxAvJ710tRgD0layaeiHH+bT1sLz76oefHA0nj0/Nq5xlObm3Aq9lvjT5?=
 =?us-ascii?Q?/aHUrlhkNCyDu+HVgiGoWNl8+aH0HXeeoLM9xBB4dsM8VKV4OkU92NV6Dahe?=
 =?us-ascii?Q?T4EubHb6hxmCPMI9kYtLw7XVxFXucAzXV899dQ8xWvlr+sZ8iT6ffYl6kaJH?=
 =?us-ascii?Q?6qjO4b1WLtCqDVTolY7MwRUoHNWbl63o4IvsQx4dEFE1jHnvc3NszCodnqLo?=
 =?us-ascii?Q?7p5kntsp6eVuFk9UQ27WfUEhikJCpWnG59gadUtY6zgjb0mS9KLCyTsC89Je?=
 =?us-ascii?Q?rRu25PoizNtU3DvKpBLrC6mBJE4y1f1VnKyFZ0Oe4J5laswCyw48UosM5Do8?=
 =?us-ascii?Q?+GMk1dQBHrULIUEDOgdEnwjShGl1ugjBAgO4O5LToY3whXutW6u3h0etoUTs?=
 =?us-ascii?Q?gxUH8zGpzJJj05alumIZKDg8rMuCiTL0ile8+7aCidLB2jAEnBe8QBXgGlMF?=
 =?us-ascii?Q?JpE+VqX5qFuzX5rCo9YDGFOGCuE7vFQiTR635I8MAOHPFt3ikz1DxDGzrSDX?=
 =?us-ascii?Q?b02lFJJuJsfPESUyfnCE7+kwNXb4hbtri6Nz2VWCuP44mKFfnAnqMI4yLkxy?=
 =?us-ascii?Q?OydmbP7Q81LviCXxo6ao0Eh56NA3Em7tP2RbZ3SipEdanduPg0sHI1rw2Zks?=
 =?us-ascii?Q?WAlmGg4mbPwUgGTIcM1PdMVECTWlT0Ac16p4ybYfzD/i/unc/EpyHNR95qId?=
 =?us-ascii?Q?nHOULcHcORAiMe9KGFWHclikVzPkbmneQxLIhJLpmKH2/1XyA2v9YCTPnaiF?=
 =?us-ascii?Q?9lEJ29eUqncVHrpZ0051vwTeM1X5RUKNTTZGtBaGR2AaHxDHPkHYMGRqLpfa?=
 =?us-ascii?Q?qTWHbeVQEgiE/n3vJkfYx5H97uWHfafNUwk9QD6FVbsPOgCz2nRTO7Br0hXh?=
 =?us-ascii?Q?f1yWu3xFsrTu44uSyiOEDMD7nmzY+HOfvr34pBZyEX39wOUvouD/GYVSH5DE?=
 =?us-ascii?Q?beJ+lj6P1YS0WIDXnynYRBEXJ56Wa7o5HUUUv36Sy+jUl24/5tDQZyNgjYFZ?=
 =?us-ascii?Q?QfULIeMNd6sb0WP+bYH5ePxvU7kyDUu7fp0suJzi4tDP6Wi02lynqi4AJREs?=
 =?us-ascii?Q?yuBFtdTP2Bd4Rz9ndFyoxdLzWidwt6jynyPU?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:54:30.0944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d22c8039-7c04-41d9-e96f-08dd83484ca0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996

On Thu, Apr 24, 2025 at 08:21:08AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, April 11, 2025 2:38 PM
> > 
> [...]
> > This is a big
> > improvement since there is no VM Exit during an invalidation, compared to
> > the traditional invalidation pathway by trapping a guest-own invalidation
> > queue and forwarding those commands/requests to the host kernel that will
> > eventually fill a HW-owned queue to execute those commands.
> > 
> 
> any data to show how big the improvements could be in major
> IOMMU usages (kernel dma, user dma and sva)?

I thought I mentioned about the percentage of the gain somewhere
but seemingly not in this series.. Will add.

Thanks!
Nicolin

