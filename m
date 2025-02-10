Return-Path: <linux-kselftest+bounces-26267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA11BA2FE65
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB551644B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 23:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC94F261375;
	Mon, 10 Feb 2025 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tLeQSbCQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A2C26136D;
	Mon, 10 Feb 2025 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739229983; cv=fail; b=mRtabPQBMpRVdQ8J89wD5qicaMbd+B1LNhBx5vJcG/iekEtxXWvVVoEbAEkTmm6H7ASsU9uvp/UULR11jsq4H3s14bzK8NM4yKNfrlRFJFDz00jnQV90rARlNO5RpIOElNjbpmaNk2+HUfEQ7jlgyPQMNgvnju5rfPLLFG3dyaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739229983; c=relaxed/simple;
	bh=e/5c/E65ye7ULhAohVmCyvGmXtdKqpEBwHeuxWjJil0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWejM8bvxZkStJh4D0jKkYsw8tdJ16qQ2xbA8qEbIfYltORgUlp0+HUNRYalPtD/dndjC483sliuFgb5VGB8Ct9Hr1tXO+tUQCq9qOqS7J1hyAG+xFPyWziYaJhVIh4EjQ+vbL/1zBwx7G4IKSJRN7s0120ORa04a19PKRu9UHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tLeQSbCQ; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lb84Axc2ep6Kli5I4SthyYKzLV4NJjVd9iby68xvHLvlZoPBQ4Cmx3lwBk3AV1kNYlQ5PVRNUpt8XuILhofAzyLgo4PVE4c8stIvIRp4tfH2E82gW4CHpH/4O0JQqRRh32Pj6jPTojIxYy8zISNplgkLN4SYrwqEVXOgcEIEdgeD6AKgOWgHy5W1L2grBOU6XFpLc7Q4SYjan+Wvo0Bmfkx5S0NGdp95ikZpOjiegKz2/Q121e9jrp2Gqumw4zCeUOejVD319Z5DW+jLATvmxvs2ASJDdzYhDQe6Unh1Fb8WOSIHcITRQji+7kd2lC6jJb9XFUKobc2UQZwIQcllfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCSO1NGAhddc4SHqawhZbtlPG5oTPdnntF1TUiwczlg=;
 b=FaNRgHaF76oPewpMX36wpqAsB6TLjGWbGCr3VNcs8okOBuxT0Nv70yhBv216Aa3WqY0vPfBrH9dC6zRQMJyoE2JstNTHRrD9jMz+bm4UR2pK6Fp2OwTA9nLcUSk5RoTDppCTC84eTtWKK/T71ToiDXnKHOt9Nja3HfBSIVZm62KyH/N7GeE8k2wBy/kq0Rb3kLwORAGNvzACuiK6nmP0ExYYtty0mskZFxh4gI9K17tXJuXoqx4Kpo87nGgwUSFdk3Gr/bbqDrJ2gDiVXFS3xMuwPO/JIqmIur1nQQnUD/6f0DVwm7attfQrVjOneRd2cyqyxxhoVahVvsTr/UJjPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCSO1NGAhddc4SHqawhZbtlPG5oTPdnntF1TUiwczlg=;
 b=tLeQSbCQ4BV2UNx+SrAJ+pJr084ig6v36Y73ooRXGzD5btGpCECFj8I8aSwif1Jf0Ph6fxpcNZhH+mf/onPmz0EPFZbgdAmkdrwF8yscE6uF2PQrOCMD9OJOZhH6q5Cd8K7hE/ZqRuZ9xkrdVINbQMBdYjXBnD/J0tRXroNCmdEUSSWtKRSFMKwIwgOe842wGNrrVaPeOCOq7jaLmOmkUkMtYyaf4oFeRHH1daAsv9kOF89tRSEp0zISvpxDyW2shzx+kOTQHIeWg4yCtE10MHttYcoBqdIaOsrSXL5GTr1aQlIhOAkns9No7YvjRU9pMzdTGJsVbYlZ4uP7EFIKhQ==
Received: from CH2PR12CA0027.namprd12.prod.outlook.com (2603:10b6:610:57::37)
 by SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 23:26:18 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::69) by CH2PR12CA0027.outlook.office365.com
 (2603:10b6:610:57::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 23:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 23:26:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 15:26:01 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 10 Feb
 2025 15:26:01 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 10 Feb 2025 15:26:00 -0800
Date: Mon, 10 Feb 2025 15:25:59 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <tglx@linutronix.de>, <maz@kernel.org>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v1 08/13] iommufd/device: Move sw_msi_start from igroup
 to idev
Message-ID: <Z6qLB3jV45zxPdZh@Asurada-Nvidia>
References: <cover.1739005085.git.nicolinc@nvidia.com>
 <550f103125805461491b87bb6018293ce9b888b7.1739005085.git.nicolinc@nvidia.com>
 <20250209184152.GM3660748@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250209184152.GM3660748@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 391bcc87-8f28-4dd1-ca6c-08dd4a2a51f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Ok5EREUpYuD4nTXmLZGAdE7S1rewojhhqy210+BmDlfBUkg0uI8Vc/u+yZD?=
 =?us-ascii?Q?lbF3MLRDFhdmR1cj0JV7kCwkvlyHYXXXpcB921Tex/OPEF2Q7JTvmgPMqLkv?=
 =?us-ascii?Q?7U5IwB0VKUxclZPt/1WFKz4XsndklW+N5AkQCo8UyI6NpKg5PG+POBzbsg2P?=
 =?us-ascii?Q?UMp0zAQ+FiiX74L12UysSPZlACcOubBu3imwLQxq/D+jfcLD5pfq9bXwNWtR?=
 =?us-ascii?Q?3Z+SB3uPtOvDwk7yZVH7D7ivucRAWq6UnTsMN2Ls3UmEmY1hhu9ZNnLVeHRl?=
 =?us-ascii?Q?aYSpyGM2ada6E+BiIx9MW+nh9iVo1JC3yLwQPgs4h+HliYJ63lpTiIixKGEj?=
 =?us-ascii?Q?qf4E6QjFwRtnNl3l2Rw6jmZMvWwWpicSVpW3zUT2BzTLmryOq8np73vWYR98?=
 =?us-ascii?Q?dR1McYKlN4GHyg/n54cpffGq6GC+MxMWzMPY3iX5qaODkXg87Adrf9p7XbrG?=
 =?us-ascii?Q?DVzhmHFQjjWmCnFZClAgn3M3xufGWFBdWa+7sqzb2+Ksdc2FzGsYn5eISB1j?=
 =?us-ascii?Q?euQzx5m9YCbQNQ3jmGdGEUxZsSzA97Cz6gjffz4aNfFChkxrgAay/5wdzUpE?=
 =?us-ascii?Q?gmJmHOvr6wTxiDrSqGLO2gWTfeeVMxoSFrPDBJx5a3N8WVD/eqc5c2ETCUa9?=
 =?us-ascii?Q?25W2KpCx304LAQSquJk/WIdc7Jj1zXBorsMkFfTvPSOTF/xMaQD3IXvKrTXc?=
 =?us-ascii?Q?xuydT1CaMw4CYwM9z4et9lKmP8mMb2rLQjEAfHK7usHAi8u65a9PJrmVAt+W?=
 =?us-ascii?Q?uniCqIn352rKZgHR6a+0qZJJmdc8XU3Yof9L6+68eC/Hl5hTg2s4P6DuCQ1l?=
 =?us-ascii?Q?dK1YtERIJYC/6vOAox5XXSporpEB48EygTV9bqvr5eC4LF/gWqSVYuzTdBOO?=
 =?us-ascii?Q?iTHExchJ8B1YDqARDGfJ4R/srU67CijqEghQkoU6toRcUmYU2AlXWpMqWGrq?=
 =?us-ascii?Q?aKfrfPKnZs/cg2XSVlvcdAc+4ZuvR2jlUoHDHOYbinIcqxAxMMY2JQzeOI1v?=
 =?us-ascii?Q?bX6L0UAweSVczlyMY5uJbGPhS39xOFrtkrm4AzcE8d+hdB248JyWhKexgdqV?=
 =?us-ascii?Q?xgjK0s00RNdfeGyEmqHY6xB4T3aJWDp5RnJtmfQ/fzofmKueI7fMYUlyku45?=
 =?us-ascii?Q?UeBeeKaNO3Hk/G/XYnBC0k0egB/ZN9zq5yqvX7i5X4DqygyrN4IuESc493Fi?=
 =?us-ascii?Q?fFoAxloa7qlW8+1b0P59iMsK5KfxLPYtjrn3xefpwfAEqxyund//6dgDKiVf?=
 =?us-ascii?Q?HCbPl5JKz5HtL/5Fk9Lv2c2j6cx8fj7Mzz26kbSyhYJzFZEpGq9fKMfxBCoz?=
 =?us-ascii?Q?IZOjBDKrr+PrRSY3Hd8alsG7dgCwSKNqpxOXJRo0XbNhxaOblpvFkK+0aDNB?=
 =?us-ascii?Q?tjVhsuMsM0hs7kaTu2tJCteXkPYctlRszMe0ZfnDKq1eldkF6iRYZr2CDoWb?=
 =?us-ascii?Q?+j4yi6wtFl2ydAW1pS0oCj7W6g1rQuMyKhATwSL5eIu8NIlRKH5Mmw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 23:26:17.9035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 391bcc87-8f28-4dd1-ca6c-08dd4a2a51f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893

On Sun, Feb 09, 2025 at 02:41:52PM -0400, Jason Gunthorpe wrote:
> On Sat, Feb 08, 2025 at 01:02:41AM -0800, Nicolin Chen wrote:
> > @@ -433,8 +433,8 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
> >  	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
> >  		int rc;
> >  
> > -		if (cur->sw_msi_start != igroup->sw_msi_start ||
> > -		    !test_bit(cur->id, igroup->required_sw_msi.bitmap))
> > +		if (cur->sw_msi_start != idev->sw_msi_start ||
> > +		    !test_bit(cur->id, idev->igroup->required_sw_msi.bitmap))
> >  			continue;
> 
> So we end up creating seperate sw_msi_list items with unique IDs for
> every sw_msi_start?
> 
> That indeed might work well, I will try to check it and think about
> this harder.

The sw_msi_list is still per-ictx, so there won't be items/ids
that overlap with their sw_msi windows, right?

Then, the per-HWPT bitmap could still protect the iommu_map(),
as the design wanted to? No?

Nicolin

