Return-Path: <linux-kselftest+bounces-20365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E592C9A97FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 06:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624F61F23EB2
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 04:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485C8126BF9;
	Tue, 22 Oct 2024 04:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RWwa0rOJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C44F1F2;
	Tue, 22 Oct 2024 04:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729572060; cv=fail; b=bsmGREhQBU/NEy3SCO87K6TwO2CJdsa9Q6GEFF7xUQmtDNrfyE+Fl+AM+OJoO+JGwZJ343lYAwE2QbXYn5On/sBGqlPB8u/45oqITXA+dJzx7zGf5fi/vGZsr+9NCeYSwkzU/p0stbHco7dJBHCbtIuQBqkC2sMw1uOvxBf1pwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729572060; c=relaxed/simple;
	bh=OIfankuCWqZznnGUpOv89vBXxYnwx4nLZnSrgTK5J/E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNcyzHyIRMKSwyGHjnbeTmZRVSBTIoeweHfJu6UDHbxUipoNPmPrrKsHAzlBRRlVd5LP0OZ/o+LXt/PDhq78SCT0hzp/UBMtZwl5kBUplLEmcZlNbfHqvD8qMhqP5kKOtVifMMFuzi2gDqb/a465Dcp5V93lh3nKHbSJysieWZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RWwa0rOJ; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLzil9d0P+qjL4OQEp1qezhvmghlG1GSHeiTXb9T3sg2LUln47zIMWDgZa671CeE8rbn0LQXiY8GSquRG6ZqTdmOVAMdCPKOWcnOuMIVzYs4O6PfxuDTPsuXcpepLqgsErkbMN6bH92ZwnQHxs5j4h5AQ0LQiGdfWKjF2XO/JSX4QV0qs69lxJzavy4bEMeu56U/99JCb5U17ehRPimqQ89pNQ5Ion5Od5FGPDdzRVO2YUtRdN8i6MifXk/QOOH901q2eN+8yDAZrjs4PCTXqlX6+ldxxuOfbdAU7jjDw8EPpLTMCiMsly1mYL9Uxe0hfjR+qLwmLSmt89zk0C4ZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YS2mlDZcwLCfIgT0ufGHPuOiiYwpll5Xkaxn5lPCFVE=;
 b=eBwyXMzf4y5VZLEL311qDFGUIRTrBLMaIK5LMz5LLgOpHJ8JYb4WYZp57cfkrDQZPwECpHMRchS1hxknAsoPuapZXkFVH/2Neg/4yrInJO3TZ51jvLcZAC0/u/DmcECu4GKgq6gD+0wYVbOH0EQxxCPCQkGynIkDUcOfze5ap9yzpNdmnpqA3oXJOgYwlRGto3lzP1MDKrpfGsiZItd6YrN15pUOEJ+xaY5/AAAY/UslflP6UboijkUWRtnGkxNoXNgtLmEubO0SXt1YKRPcnIT6KF/WnpuavivXazj0afWAAjdDdDAF7PTyArIGuYjc1SnfFOFGxv5BstySlF/1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YS2mlDZcwLCfIgT0ufGHPuOiiYwpll5Xkaxn5lPCFVE=;
 b=RWwa0rOJka1j9SLMi8Wg3pm7Lb9GFlFSUox5iB3LPJzR76RXgzcDyLze4u4XpLvoQWYz6mnAzT888EL+duP/V99eFgKKl5zBldGhMpdHWp7NagrU/GCFtujppnUuPXHGxdMMIgDnlS77xTbvP3DrDhk4NFPo3CNXOIKXKH0pSP8tCbv6lgcmQkRnVp8tSCquWvSjc54PpCqeOze7K+q3nVjEY96kF+L9wvbJVoo5c78LBfJJZQMVCSHn4P1ZcMGfxVj3f2ILUm9zLu5bHSrlw+iCqIHljm/hlXs5XpyknTidPVbXB77+uEtinu0Nm+xu49qeD1bM3zVHRBXqP7UC3A==
Received: from BYAPR11CA0049.namprd11.prod.outlook.com (2603:10b6:a03:80::26)
 by DS7PR12MB6022.namprd12.prod.outlook.com (2603:10b6:8:86::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Tue, 22 Oct 2024 04:40:55 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::44) by BYAPR11CA0049.outlook.office365.com
 (2603:10b6:a03:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 04:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 04:40:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 21:40:50 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 21 Oct 2024 21:40:50 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 21:40:48 -0700
Date: Mon, 21 Oct 2024 21:40:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kselftest@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v4 02/14] iommufd/viommu: Add IOMMU_VDEVICE_ALLOC ioctl
Message-ID: <ZxcszxlwuB5kkBmv@nvidia.com>
References: <cover.1729555967.git.nicolinc@nvidia.com>
 <2404ee8d2bd97e7b8c4c45b24cf52b157fb0b635.1729555967.git.nicolinc@nvidia.com>
 <1886d618-5539-4108-96c7-afebb65b2c80@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1886d618-5539-4108-96c7-afebb65b2c80@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|DS7PR12MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f13a69-9697-4659-5ddc-08dcf253b73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8IfW/6VwabxPgGDBvmGDNl5eXWSEm2LD1a7vTmrC6D7MME3MgG1QF3fRPsKj?=
 =?us-ascii?Q?aTuay6wXT95sPFbbVlA4mIqM0OY81pPwXgnsAWrSolihRxL3SHhkXLEUpuun?=
 =?us-ascii?Q?VteqjkBcAPHaQZzOuOvCgVL+uW0+Tjr5eeUkClmR7w5o3gkZW9N4yYp8hPXT?=
 =?us-ascii?Q?Mfdfp61jX0da/LyQtp/nSQdh6rxpojNkllnScjHRWpZt4OAN0FKIQZKuMmsq?=
 =?us-ascii?Q?8XewmfrkgLFpK+RytKKt5iQuS08LhUc9NASejqCII6+gvLdZ3DUfRFBz5ENY?=
 =?us-ascii?Q?eu5Thaumc8DXBCG0fD9dq4WYwP9x2PGJDD0psUKrZQb9Klp5tA9YR+RmmG7Q?=
 =?us-ascii?Q?U/TOMMh2vUM/ZxZdNbJeXPgtHGcsmVeiREFQrUxZ0yz3flmcHa+7X0hmCu6e?=
 =?us-ascii?Q?ZmHszcaCjPUuy833vBeHz4aOIQThFhdP2nUk//N/Di3QzaM6cpXLvYPI+WN+?=
 =?us-ascii?Q?7nSZsanYsUtoWk7ghZ0m9gAq7BfkiX2EtkLYZmJl+EkfgkMHZFj0dIJLc0KV?=
 =?us-ascii?Q?Kmg8hqZ5d/Wc0Bc4Cfdx1PYrODcFHY7YO8iXUP7yFgGeqjEp6W7zSaPd6yDk?=
 =?us-ascii?Q?+riY+EDq8wSBqAVF3Sv3751it/49whaDM/MISdJvnmtwbIcagFcdhIwvRE7Q?=
 =?us-ascii?Q?l+mMNe1BAMDtGFEZH3hU1el9fiYP1vcsyR21OPUuMZvFI1ofKzWH2cwFCd0X?=
 =?us-ascii?Q?PzFxQflX3NxWruyX/z6kWH+MddszbA/Sc3umLdd/WLqCyGLTeS9vADZ2bKzc?=
 =?us-ascii?Q?LAbC+YajfMBe3hTOnkcNP5LRJNY19pLtj0LlYFTU5OEIgzqs88E7r05jjE+i?=
 =?us-ascii?Q?reBG+H7bqVtOe7h4l7QPvSXN2uU1OGkQ6HCKYaa7J2nVvxgy+Z+TV3LVYoki?=
 =?us-ascii?Q?cE7FP8wwjr1VBa6AacowZhEj/nWTuvfcLpJBC75FG9Ms3aECIn3c840Gec4o?=
 =?us-ascii?Q?hsEfuQCWT+305J27KdYlQH8RPKqbgg2CCRqN6SBVR10FUT+dULe0tacnV/AK?=
 =?us-ascii?Q?J7nkgCMTQySx+aSkwY46bap5/P2BgosoTGGwhNwwww+T+ebhAF5yfBitGcCX?=
 =?us-ascii?Q?jU2ThII5Ki3bzoO3VW9EIykLg2FT0IGUnklduTsS1/orj6H+m5EWculKeZbF?=
 =?us-ascii?Q?47Cq+3Da60r5GhktVGkjtvWz/oZiXtFX6gPZbyQAUmb0RFh+UC4SZuwCmJXC?=
 =?us-ascii?Q?yszDTLDqP9mGOae2dbc2MoYwrvj5+fenKJLPXOLtJrxiVupdYaoul2o58Cx2?=
 =?us-ascii?Q?+y5fClvELkie6iZ0PDVCQ6bk8FYMA68TebBoGCBIRpt1xctwNLgHG5/5+hAA?=
 =?us-ascii?Q?01s8VDC+mxqWo250xL/elSPRRVm8Ikn1rOlJHkpcbw3w0Cyw0zmMAaI2WcQN?=
 =?us-ascii?Q?mAHb9Tg0XHmS4qIIO2DSLdcqfdMwba52h62cwhw7FFCQGQ0CMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 04:40:54.9849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f13a69-9697-4659-5ddc-08dcf253b73c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6022

On Tue, Oct 22, 2024 at 11:40:11AM +0800, Baolu Lu wrote:
> On 2024/10/22 8:20, Nicolin Chen wrote:
> > Introduce a new ioctl to allocate a vDEVICE object. Since a vDEVICE object
> > is a connection of an iommufd_iommufd object and an iommufd_viommu object,
> 
> nit:
> 
> :s/iommufd_iommufd/iommufd_device/g
> 
> or not?

Right, thanks!

Nicolin

