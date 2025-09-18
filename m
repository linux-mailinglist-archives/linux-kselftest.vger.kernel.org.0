Return-Path: <linux-kselftest+bounces-41899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BE3B86F43
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 22:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048341B240E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 20:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEB92E5B21;
	Thu, 18 Sep 2025 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ug9TrDBa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010068.outbound.protection.outlook.com [52.101.193.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AB7214A9E
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 20:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228654; cv=fail; b=fZAXRTpOEoXMzzRMjDe3OVtjOPO+bLIkn4vS1REYXmTOexEdRik42HW56Z/OXaP0RkWoFUa8frdj542gtmjNq5x5MFILmh5/CnUNu6CUkhvDbp2qcKJC2Y5R5ItaWohOZQgGoJVegklmmeJX097Z4f1dPeFlXT0C2DPK1gk9vFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228654; c=relaxed/simple;
	bh=RbPZz+eGeO6cI3C1eM1lzCipmY21sKBeAGHJVf1gmew=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXcxO5/kl3Z/vw7NOQ6BUDjUhsFbNAQXoCgwhLj7rVohiJ7q8RXZ7q66szxK3xVW8f4wR7MFVBvIj+NBvwDEvPcWltAzs3R/nFeeErYpTIxI/id+ges9947MPL9fVSEu106WJDRO6J5mV8KmBjfQQePo507TLkPObT9nse9h9Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ug9TrDBa; arc=fail smtp.client-ip=52.101.193.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vX7bwD2Fp91inO9JpHgWHjux4ix184SB+CJWdUVmNLOVh4eus96TAxmUVYm/y1dohUbmtCJ3kObrbKvCcy9+SZa746h93rahIMV6fBiI04+/wpJifyNVmM0521/vYBXZkgeduvn6zYtjyf4ZvYUAl1g7pZG6Lw/TofvcO0m6mVwkmfXd1WoI69NfevoYgh/FhpG5EHSCs3BkZIEuMC9Byeb0CwQo9juliFW+S9lmxpEcx++htnoSWuStro/Kvl7u5mGKXvmWQ6tKinvVWLaROcxp/rzHl4YgGzFNoOTv/ojD+5MLzwBhbZOSd6vlG2XupET55QJ7jzUKEMCobBy/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FE7aj+h5adckkX1m+PPqOz3EVqUf+UJ25wgshWalgts=;
 b=uMariL6h/4WCNarfQYpx/TsaWprtE6ez/r77KEJhj98AFMAEFxRTnX7aFLzVhFD1lh7FNFtHB3O/kg5fffbPNPaUL1h+DLjLH5tY5cNJFJTLMa12IY8EheMrxX3FtcjCZ7MdtWi35yHvJ/+TICHnbhBYp2qlogeemDfX+3pQIA/PmPjm15F22e08+F11DOFBzsAaeG4n/G/5tvwV7c/jx1jphRRttG3HgBo7M6iEn1xVM43W2+LhfCyM6vV+RrggkZMrDK27ViHmesHkE8HK5t8NV5TEaWL00Z3ELYLoazUoxNIc0WmZJ1SnZhOTBXH3OsikhMZxQ7SzMjVP9987JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FE7aj+h5adckkX1m+PPqOz3EVqUf+UJ25wgshWalgts=;
 b=ug9TrDBaoDIgXtx1XFJ3vAPFa9ym+ukMBj2PwX01ZWVIcvP1DUyXrwTJ7PEfKcJwHeSsrhA7a+levJkUq8+nq7P1wvTycEPATK452RiyjEGDfUYgN6jPfJQuXpWR0MyHcJvmJDO86muVYr5eX9Y/V8VSVOAr1uvW38WSIzrE7y2bzViTKwUmxSWK1QrTqW274xQ/y4u+WVQqIqB75Avci+KU5NjhSgZ4Almf93rR6hwxIgvAk7lQxe5KyQMZ5SMb1m8z01zPr59ZPyFbHH5huWves/bIabNFuuraiXsm2IhSNmxo9ATjyhpU2NRvwuHgerY8zQEwjB/SCTbKp+HOdA==
Received: from BYAPR03CA0007.namprd03.prod.outlook.com (2603:10b6:a02:a8::20)
 by SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 20:50:47 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a02:a8:cafe::c0) by BYAPR03CA0007.outlook.office365.com
 (2603:10b6:a02:a8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 20:50:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 20:50:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 13:50:29 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 13:50:28 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 18 Sep 2025 13:50:28 -0700
Date: Thu, 18 Sep 2025 13:50:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, <linux-kselftest@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Will Deacon
	<will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	<patches@lists.linux.dev>,
	<syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com>
Subject: Re: [PATCH 2/3] iommufd: WARN if an object is aborted with an
 elevated refcount
Message-ID: <aMxwkk4xMywvsZdB@Asurada-Nvidia>
References: <0-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
 <2-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|SA0PR12MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c6d0be-a3c2-417e-b7e9-08ddf6f50b03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cJGaSMB7+2A+yhE7v6yRdBmguADr3vycMwbvY1wbE8/IGzMllEEAU2XvI1XM?=
 =?us-ascii?Q?+ZI8BnuReKnMRbyQr5EKZE4n0an3JgvXmkmCJP2t/lmczmkKFAVf1XOHS/rr?=
 =?us-ascii?Q?my+HYNrD2yJqzpGdbT4AOiPjnz1LqlPH3rPm4PeeMQJ5DeTYYkN+lBbZYBPG?=
 =?us-ascii?Q?BCmwx8AraOSlfABb5wDqJ9bCM7Goo/dT2sZCym8KpXHFCcZNYQIKeVcJ0l6K?=
 =?us-ascii?Q?+inTFgNn4nLcc22I6Aq8UX23pnOI1Rlnbz+bGdDTRH22Ack9fRHRROjfNnIZ?=
 =?us-ascii?Q?1HMv0v5sYOArgy9xutaUh3Gt1DYS+ze3mPafkOLq1E49clhsQf2amacgNLCv?=
 =?us-ascii?Q?owEY0TZapnWAALpNIb7cCzimndb6DyHHyBKOwgS6ay/5mzZyFI+CLtALg4aP?=
 =?us-ascii?Q?m64AoyLDauWP31ok5NWH6gcYSvuZre/PtBJN3T+4t06MZtjBo2TWGSNlhoUI?=
 =?us-ascii?Q?NjghH2HZNsXOZxHi23PsHjObGrP+bvJGmECRuojIl2B4eaYFqmRgSRKeZ5Ec?=
 =?us-ascii?Q?0g52hkDyumg3k0ts+vbAQv83rQMgQ9tZ/u+orfDktfoc2XiiGImZR1X2eVcc?=
 =?us-ascii?Q?kEIj7CLr6LXAgVYSKdnTvCy9j28pwJi6+uxlNKBfJKcDMplJzDX1X5G8Ah5d?=
 =?us-ascii?Q?YLdc6EPvxxyfLaRvKfLHEFdDEdfzhhr3t+0sUFJpJ1d8WyI/LZYvCM9G8HSt?=
 =?us-ascii?Q?2Dayocp3ImsJ5s10xthEt9zezMOLeLJiSEj/WZu15b3ncad3Bf2AHivMcHAG?=
 =?us-ascii?Q?j5HwoOPHYi8uVWtH5tC4eOjy61v2nb8GXlrx5yckOKqKkOuD5M9HR3/9phzG?=
 =?us-ascii?Q?ele8Xdejfj7CrEGBNmywsv5Oe9ds1zxWOj0S9nENMoLPxq4dJZaFkkaTeJGy?=
 =?us-ascii?Q?1MvmYWp7pxGn0R4k/jyWyInRJCJqL+0TpqZv0OlSSwSu1weVvYw/O5a/Dfzp?=
 =?us-ascii?Q?nyvk9qH+3EERN1Nh/o1YazoNUdwAr5YdesCo3sAS+4aeFdN0ErLmbea7BjNk?=
 =?us-ascii?Q?X7pH1iMfdHpRQ5EV0aBzn0voeL95ZD2rLXJk4vwhu1BvTWw/PnAEbt+CXjNL?=
 =?us-ascii?Q?KSzCxw9m1+xKbFQIYgSVmlrNFAmv3VR3iBCGF0/x6SnnfMpBw6oUk81eloAu?=
 =?us-ascii?Q?05m2TyzHoKPxY4pWlYyHJ0lHtkzjNFTDT7aEFMg/7GfQqZ8OToqbWwND5i3G?=
 =?us-ascii?Q?O8hCI0W+EWSnm6cZ+BHMfTRs9GKgnASKSGMvCFMYqB84uvn0vONNV7w2wCy3?=
 =?us-ascii?Q?HRiWtOrK6YKKgqVlBe6CtgdIWENpx/941YG8NUEwlYrqOO70R0eF79WfzRB/?=
 =?us-ascii?Q?GdSFyQ12rSwsjkc25JeaaKGNfFETHUq9bEIljolCangECTWIieuA9KPW29++?=
 =?us-ascii?Q?19dJXJyVt8f1EctudcESAgCHt2hIbvGvO4a685MxpozKj/1j9W95DZNv8eJi?=
 =?us-ascii?Q?r5DquguC7XagkuihwHUm/sh/Fbuo4T6ooKFkKJwLkUwf8zwP6IAt/2nod5dU?=
 =?us-ascii?Q?Az6dnQHHdmaq1k1nWX5yt24UdPyeQa3VBMlm?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 20:50:46.7402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c6d0be-a3c2-417e-b7e9-08ddf6f50b03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7091

On Wed, Sep 17, 2025 at 05:01:48PM -0300, Jason Gunthorpe wrote:
> If something holds a refcount then it is at risk of UAFing. For abort
> paths we expect the caller to never share the object with a parallel
> thread and to clean up any refcounts it obtained on its own.
> 
> Add the missing dec inside iommufd_hwpt_paging_alloc()during error unwind
> by making iommufd_hw_pagetable_attach/detach() proper pairs.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

