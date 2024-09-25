Return-Path: <linux-kselftest+bounces-18368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64589986699
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 20:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8616E1C23B20
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 18:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0733413C8F6;
	Wed, 25 Sep 2024 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DBvVQCro"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD141D5ADC;
	Wed, 25 Sep 2024 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727290573; cv=fail; b=Z0Fs0ShkyRgp/cETY6fb97cR2ZBAMjTm3OvGGXjxo/r4cOHWVV2dD26vKHSDLtax16CGnYnGV+++6JRpcxPB8WylMHsd9D3cClJ+AeaW626/GHBaDdte3GWPzjPpdEBAryHw1ZL3vRnibrmUCCKt4iOAU8SqzBY/4vTULnZS0Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727290573; c=relaxed/simple;
	bh=Ky860SbDAHZElD5VtZDPiKj5a0k+PuV9Wvi/Y6jf6gc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pA1MEJFYY4kcAi8yiNPnjidwPq563zI8AkAOXLs4EIJY+Q4lcSvuS5ktyo63RfmUMxcsW55rhdZNOKi99btK6X2nomgSvj5ntcVDpIPrmio0BW4hRJUCNrW7ATtFiEN6wnhrIl0zBda0ekuQZuW5w/BOJS8d9hqQ10RIqNJ2XMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DBvVQCro; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbEc47KcjwpkgHu1Jq918JR3ft7wJmR3GMDkuOatBw1pqayaoIeQAMgmGsXz26d41nn/sVBaDeh80XMHQFXVzRFcL8SIuC68MxSNUCp0897xp4dfJy7WtprKT8KnbYhAXNjnuzu/ssmV0wAieYpAdorlEdyCm1ADYrG7bnq5nk8FCVo6pCQK/BSCMBTOuEclvhrgrdsc1nlF4z/dYDlrBSCE4bauVpAlMLhAi6iRIh7BgASXuszI6mRIDaDezjAynPnCBaytXE7aGa5BKDjUlGJ0u0/gMDH1B5zk2xFwqT58g77B2JUNpDKBHqA2jENAv7De2hfWOz4IdfZFv7h6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERRrTJGoWPGwm/7bstvUfWFZIT8YlOXgdp6fi+IgjDE=;
 b=WnZ4q22WZS5fn3fEDz+jihLRfWTmqSGruIR9V6V2b2JdNyUIGK7L2roO35uu2fsCv21XZ7bEhAaio4HU2ij/noj2CCUBNKk5uinTD3MemcM32QpLAat3hLa81MJ21DQCQN2bywowaM/DzjdlZcxIKaFFwIvy5fjo4rigzgjT9vk9FgI/iHNZqBmLWMcHdTKPvBiZBfmJ4pj7iqUu7KZ4Vq8scrQ7MC2ebBTOXkl6ZnTXYtrBIqLO/5M2NLig4swrp5WjQVfci5ZQTv4GglR76oyVxxwjw3N6U7pCSe5kbEbsh1I9ZrreeZg6GBic8IFdYQBpL8pHFjLYPZK4ieIRqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERRrTJGoWPGwm/7bstvUfWFZIT8YlOXgdp6fi+IgjDE=;
 b=DBvVQCrolmIeXzhZzzXyG2R7GFTxEZZd4XGWFwBDpG/vrII9fyoyFurRcCX/Lcv2EDMjZtaenNCyut3K1ChmNx+dgmbGKC9GUNWWwkkAOeTkasudxh/LHiWlGiQFLezEZPaSGWDutz4Mpytn3tSBUPFEQKt6YQuR81JW6PozfxRpYp/ZTUhvfh6mutQCqKrS/NQOmAEhiU7vzUqyuj2eUXPkERqKwwyn89YrKSzqK+AEgx3tWK3LVLYW37n5RAaW7hZEx1gz7AZdveT0M7uLYiJX/ZoIvK91PUIqRdoNaB9Gd+agpO+Z/7nuddBfnVaXoMCLrm+93CCaXRZ4/w2QyQ==
Received: from BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::17)
 by SA1PR12MB6823.namprd12.prod.outlook.com (2603:10b6:806:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 18:56:03 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::b2) by BY1P220CA0013.outlook.office365.com
 (2603:10b6:a03:59d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20 via Frontend
 Transport; Wed, 25 Sep 2024 18:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 18:56:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 25 Sep
 2024 11:55:48 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 25 Sep 2024 11:55:48 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 25 Sep 2024 11:55:47 -0700
Date: Wed, 25 Sep 2024 11:55:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Message-ID: <ZvRcskGx2u94Vs+R@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <bf95f910-e837-4d79-8218-18d234ece730@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bf95f910-e837-4d79-8218-18d234ece730@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|SA1PR12MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7e75bc-fe1f-4f63-3deb-08dcdd93b375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pUYk7J1VhCey14tN5m91g7xa3Suql7zgd3Qab8fRVHVe+R2V7L6DwQtxv74B?=
 =?us-ascii?Q?8YFTx+UiTHcPkThOR/9Zhpa2HsbQRJeqk1NQXOQdmRaE4EQe51N3P77RwAvA?=
 =?us-ascii?Q?+TT58MbP9iIkKksA7ikIAdlEo20UzVURDJwxl9MAqAnplgQGQM45iDhXhP29?=
 =?us-ascii?Q?9YUeoBsbel9KhU5H3OdRwfHFFzHQaXaHsY2d3HPhy76Jtzc7m46btccRLsoH?=
 =?us-ascii?Q?Yh/veuzkUF7me5ba3KTJy+DEmRM90hWNg/oc2WyzQ5/7UJCQlwMElDTfPh4/?=
 =?us-ascii?Q?lEPlGCk16UgbqnPJerI8yXiA6i1g8YDKMp9Hosbjrwqa/KMrC5Zvc9yF1Xsr?=
 =?us-ascii?Q?NoR8KZTSwFtznJ/4adbk1OUmJ3OfCdMkmnflvLwIY3dz/7yEPXYey/b+RnAA?=
 =?us-ascii?Q?m5wRFXLP7EtSS4WDFywtarEvpE+3TP93Y3bciRCKOquIrNxGvNe1X5eJOSZ6?=
 =?us-ascii?Q?tIdfQFFDSAc1UpbJhUdowQfwOl+5sLt2ji5V57eVgVnfPbc4U5dhMWLWcSv3?=
 =?us-ascii?Q?j4ilmFLwca4OjB5xA+BtzTZnzpMl3dcEMrhk83y1p4PGCSL+dIJ5oCl7blFj?=
 =?us-ascii?Q?UEKxzXkYUbzJ5U88hcVBPXPNpSkAxTh5vlEWKgq/H3nPSN9K9bE2G30xXUkk?=
 =?us-ascii?Q?eFclhx6XNCcBJRPrQ96vQ5o1/I/A/FwCXtWatqs9u4T+hDSsgPTGopQaw10P?=
 =?us-ascii?Q?yhtDYKF+LIRzo7xEcLmsc9rIYXw5smgbVq0DsPztKC4qNuid9IMJQd5bkgvu?=
 =?us-ascii?Q?yYEqDUzBIpdwmgNqaZ4c/LdgBKJzZumKiQk336LMLphj16in74aJ6B9D7ufY?=
 =?us-ascii?Q?AsZxW8CYlvn7EsJcjsNQBC3wzfZf4LqaHYykfZAtWrqpflz7GLS5Ca21jH9R?=
 =?us-ascii?Q?WZ48gF4No2b2nWQEGacpIDoWLwG/V3F2p+GMztoRIN1LpB8ZHNyls9catVIH?=
 =?us-ascii?Q?7KUeU+6qfK6eT+xG1Eh8TXcYT2hc0OB+v2+P0mFbBxEqvcpf8d0k+OpJzjk/?=
 =?us-ascii?Q?eHLDYOkKh5t0lOj88Dn4Jl8yDFNja1RspqXwYXebMmXMGjWgCnclR9kj7YbR?=
 =?us-ascii?Q?t2gLO0VWiTyJBK3VMUNlYE/22XJYkpjfVPqfLKGAD8xrvlzEUoqNRpdp7h7X?=
 =?us-ascii?Q?iaO4gi1JuefmH9BS8+QEcaZBPtSADMKxQ8zlgKLXSW007abnS/J0j5FFX6sM?=
 =?us-ascii?Q?xF2k5AMbnonJoRX0hgD0mxyPk8Me/ZB/X/OZ2RFSyaRwx4Uo0SslYlVKOumC?=
 =?us-ascii?Q?UtWnCJoeOwwPZ7pqwPtAcKuLtXhQJoiJ5weBWL/P1fFm4i/OpA8ak7owuUd4?=
 =?us-ascii?Q?+eEbm4eIqFk/xlp9RmECJjzSzNuf/XX7ixE28pIxyBVXTqBAG32/aBIfVre2?=
 =?us-ascii?Q?PdfkluTGFfkO8/fzDbo3NGa5mpjN?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 18:56:02.0191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7e75bc-fe1f-4f63-3deb-08dcdd93b375
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6823

On Wed, Sep 25, 2024 at 06:30:20PM +0800, Yi Liu wrote:
> Hi Nic,
> 
> On 2024/8/28 00:59, Nicolin Chen wrote:
> > This series introduces a new VIOMMU infrastructure and related ioctls.
> > 
> > IOMMUFD has been using the HWPT infrastructure for all cases, including a
> > nested IO page table support. Yet, there're limitations for an HWPT-based
> > structure to support some advanced HW-accelerated features, such as CMDQV
> > on NVIDIA Grace, and HW-accelerated vIOMMU on AMD. Even for a multi-IOMMU
> > environment, it is not straightforward for nested HWPTs to share the same
> > parent HWPT (stage-2 IO pagetable), with the HWPT infrastructure alone.
> 
> could you elaborate a bit for the last sentence in the above paragraph?

Stage-2 HWPT/domain on ARM holds a VMID. If we share the parent
domain across IOMMU instances, we'd have to make sure that VMID
is available on all IOMMU instances. There comes the limitation
and potential resource starving, so not ideal.

Baolu told me that Intel may have the same: different domain IDs
on different IOMMUs; multiple IOMMU instances on one chip:
https://lore.kernel.org/linux-iommu/cf4fe15c-8bcb-4132-a1fd-b2c8ddf2731b@linux.intel.com/
So, I think we are having the same situation here.

Adding another vIOMMU wrapper on the other hand can allow us to
allocate different VMIDs/DIDs for different IOMMUs.

Thanks
Nic

