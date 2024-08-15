Return-Path: <linux-kselftest+bounces-15466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9316D953E15
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 01:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E3C1C2127F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 23:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF4015696E;
	Thu, 15 Aug 2024 23:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Emg+kKP9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B37370;
	Thu, 15 Aug 2024 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765923; cv=fail; b=Ui9G2neYVWcE21Klq3fUxsqYTgbWsciUdTFxlACQ2s85JGV0ch5YTATGhG4K59zOa7ERDGalAMw4IVfW38rkFY5CBLmPSFhGoQo0IejUry/ATr0V2W5DHkvLguwg0Ioy71kxXyenTFEs4C/MnrDz9CKXs13pahyo0QBHfWF+Ins=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765923; c=relaxed/simple;
	bh=qqc0vwR4dSZq+x0NIRe07tI5GuLJDbdkaQwLZZbIr60=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOJEAtqby3wh+nRrbXRlygxvOUt8iKkZ0SKAQuFOqSs5+G3awTdl1pGt44bNoPE7+vcyZNBHxLtVBsiUpK/UnoIxMtELNnauCVTL3MUKgoyioZXIpypAdMVZ7/ae3vJEuHKyB4PZNOdWvD5UJOVSPqZwZJl95gOwUpttLl2WSdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Emg+kKP9; arc=fail smtp.client-ip=40.107.102.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYAmm/8Tp/FhU1s+Gd/Tzl0wSQ4/RGIxuJQsxB4dN53PK3NFvR7kV+p+q7qDaAZl4Sef7xGJsyCs9VLeXopCozXkk4FwTqBaust+Qurrrvqf91/eRhfg9pnqQe5lKSKlI6708OYDtX0z4hYBSdFx5ebbs/5Di8RLT1VNCQOMDZh7SXx5WTw1yvY7wId0/O6VJNixZqSU4Elixf0iZEYJnBjBalSQJSzUIXCLCBFDbTJQWCfMWi1KU/0gz7wAQbg93Lab7tuYo7AVkriXetlFTG/1som9FWHJEReMlHP9GSu5ePuQbDXed2RLtSUFh/bU/TczMqXzeBNgFJhC/iF9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/th+zJxotsHtImpchbkP4caMP71RVHRWpySib8AYdc=;
 b=KH1iWknoJJh0B9OSoV6lOg4lT13MeahFOM+xwad6ThSR7b0TTme5lBM2tHbh0ddzAWd1WRBXdtpyuzcG+4bguEMTGTwRuqCuyeCAg6jOOFeCgH4QKiOMZBrwZvgXiIEq99c3bIHRkhshGx4QP6C4YiLkCwyd+e4fU2b35ChcQ0tsinONaLAJAOXROb3MXHYLW8/G/4suB/1ReszWCuX6UqGxhf6Jh38teEkM4pOqrZ0D/cHL1ej+lV5U7nA9Zk6xvwZKoYnlymldskTHv2k4DMUa2fSX0b6bACD7R4KqV69d3FCKlDYHMXN0v2QmvKfoo435nduSIjyi4+AqZpJXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/th+zJxotsHtImpchbkP4caMP71RVHRWpySib8AYdc=;
 b=Emg+kKP90KVOMAmZFW6/XyveBQMUVkTLDhkvUMTlVbdG70/sYgimpHvh7DoQMQy3/FADdSc7YGmWStMYaGd4YaDys3kaOHEBX0FnrdquDvj2b5GWAQXAZXUyT66JYnWw4bhZnXdu3FJjyqQOuO+w42gJjc6yZLOeZLeQfjT/T+wh0HCRe/9chSsNLylJuiCTsXdejD2S6fGxE4Dn8P+grdFfXAvo3m4vO+UbkJuR7ZFMDMeoclwWrX/Z66/YJdCOLGxMeoTZRwfMVoM+CdEEPh42H0fsIzxcDJ7zvNmxxLNZmXUIyI5hhGxLUC1hCtmmVgWRiOwDcPgXrTzUcav3nQ==
Received: from PH0PR07CA0038.namprd07.prod.outlook.com (2603:10b6:510:e::13)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 23:51:57 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::b1) by PH0PR07CA0038.outlook.office365.com
 (2603:10b6:510:e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Thu, 15 Aug 2024 23:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 15 Aug 2024 23:51:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 16:51:41 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 15 Aug 2024 16:51:41 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 15 Aug 2024 16:51:40 -0700
Date: Thu, 15 Aug 2024 16:51:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 08/16] iommufd/viommu: Add IOMMU_VIOMMU_INVALIDATE
 ioctl
Message-ID: <Zr6Ui1NBQ8078hRZ@Asurada-Nvidia>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <59ad8c075bfa9de7098fd79a30b51d1f53d61a94.1723061378.git.nicolinc@nvidia.com>
 <20240815232405.GU2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240815232405.GU2032816@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d83d488-49ed-43d6-81f4-08dcbd853f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rMhdpzQIyTOLXnFJaTgKGM2OExp2/7dFlfLcZne4vVAKdTXphiuQu26152eb?=
 =?us-ascii?Q?ncFysPIFubhlTrSGRg1DOaqZX00bZweheYrMbAtCGxZUbQcLJcNQzlToCOsG?=
 =?us-ascii?Q?xL4CbGIzjIJ0PIP/H8EA89XNjrJ7Sgi9NzOlOfBSaGVc2nkbMNcU8vamzQb1?=
 =?us-ascii?Q?cWRj6mP8OXXShpN8bCv8oSMTdGYon4BCudG5HcRFU0wown75iKKltlxdeWBt?=
 =?us-ascii?Q?Ph6yLaxgDg4njOcRluspjZy9p5EH7STan1BWwaTvulrKUDyNAaQUSAEMzutm?=
 =?us-ascii?Q?0bGgx6hIqiNc3IfqoKAwimc+NgiF6GSNSS0/Ko/nHWMxh8HuWDraHZfPtpfq?=
 =?us-ascii?Q?C8ybn35d1fCyuJC1lM69cxc2Qk6Cei0qk/DojWwlgpE7nnTu34ZjYYcKq0/O?=
 =?us-ascii?Q?cYw7+4QV5+9i9mqTDUhDxBkVwBWQxNfe/4xvMkzXeUq+uE0BCm3jqweEy3Pc?=
 =?us-ascii?Q?xCFhWv7YF/IYKrvtVgbr1BiGXf7KJjxOQ5xu3vh97bhe2KuwNyuT4cmcHJYD?=
 =?us-ascii?Q?Z0QrIr/qHC44tL0MIkddxSnXPC104SWa+Qxj0eTy3sv7OCfy89d9ssd+XdHH?=
 =?us-ascii?Q?giqhi2M+wXckFF2dXAnqoxDNdTp74WreyHKX79uvFgIKYK6VONm+LPkEeLlD?=
 =?us-ascii?Q?X1qyPSzgIGJqNX4R847NnGnwyY2F7A3ljY7UzDtjjflLSEl//TkcIfvBPBVN?=
 =?us-ascii?Q?ciZMus1HHzk/wuNFswK2rDsL4ABsZ/fEXfW5zC+Q/HmUQWG7o2uZiA6qja1h?=
 =?us-ascii?Q?Vt+BFUymjIE1gLF5iXAVoYe982Hkr8G/hAvOoj7hs9UC3LT0wjqhBmQfPWyo?=
 =?us-ascii?Q?boGkeOafoipgw0Kz3ll6+phYoPlkI/+idpVbini3zphdqEeQkg9KDu3VoVBb?=
 =?us-ascii?Q?nfrexFblkXa7zB3eI8AIPbAWc/NXsg6IXG3MFkEopY4uFTSw//YPt29+mU3A?=
 =?us-ascii?Q?cO+lPzfYm2TODw8qHgnpP8F1qTHUHuYSEHXF+PANdEjpT3cxRI3uEy8cCqKq?=
 =?us-ascii?Q?eEvOkOg/QQ3jiTdJG8IfDVuo7y6UfuMm4CXlZkvR6DoVF5mbWvwKgZFGtcYV?=
 =?us-ascii?Q?BID6rK7aew8GnNjiXJi4GpOeEzKSTAGQDfDDu7Mv1y8n/03X59EQsnGbTZ5t?=
 =?us-ascii?Q?PvQ1ikP2FDjK9rvj5kr+1LlOtCLkX6WKkGrssOS5cfAQdaLc5y1dKP8hkHP0?=
 =?us-ascii?Q?v+POAjuJxMbD4yWYyL0BWoVQIVeN/7mOzJVqY1ws4pFCFD5DmY77KWaNlXho?=
 =?us-ascii?Q?K/gm/nZTj74Cm0WraRPAMonhdR/x2QM7Nyv8C2q/5YmqpTYjxNNahwIJ+S0F?=
 =?us-ascii?Q?vK1tg0d2PdbR8dl63ehZshWqQTzXLR4VcyjoN2p1DImTA73gM0DwNzhvIcBh?=
 =?us-ascii?Q?wsH4JAsKSzOD+sfl/rE1fCOI74lCq2w0hzkRZsTNmMjINlDxzmTLbe01+dop?=
 =?us-ascii?Q?rb9iGFekOWGrkHJ5OUGaU/Uy+/F//oRl?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 23:51:57.2884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d83d488-49ed-43d6-81f4-08dcbd853f88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805

On Thu, Aug 15, 2024 at 08:24:05PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 07, 2024 at 01:10:49PM -0700, Nicolin Chen wrote:
> > @@ -946,4 +947,40 @@ struct iommu_viommu_unset_vdev_id {
> >  	__aligned_u64 vdev_id;
> >  };
> >  #define IOMMU_VIOMMU_UNSET_VDEV_ID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_UNSET_VDEV_ID)
> > +
> > +/**
> > + * enum iommu_viommu_invalidate_data_type - VIOMMU Cache Invalidate Data Type
> > + * @IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3: Invalidation data for ARM SMMUv3
> > + */
> > +enum iommu_viommu_invalidate_data_type {
> > +	IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
> > +};
> 
> =1 here I think. Lets try to avoid 0 for the types..
> 
> And this shouldn't be in this patch
> 
> But also we can probably just use reuse enum iommu_hwpt_invalidate_data_type
> here?

Would that force IOMMU drivers to implement both hwpt and viommu
invalidations? SMMUv3 driver would implement both anyway though..

> > +struct iommu_viommu_invalidate {
> > +	__u32 size;
> > +	__u32 viommu_id;
> > +	__aligned_u64 data_uptr;
> > +	__u32 data_type;
> > +	__u32 entry_len;
> > +	__u32 entry_num;
> > +	__u32 __reserved;
> > +};
> > +#define IOMMU_VIOMMU_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_INVALIDATE)
> 
> I wonder if we should use IOMMU_HWPT_INVALIDATE? the hwpt_id can tell
> which mode it is in. The ioctl becomes badly named but these have
> identical arguments.

Mostly they would be identical. So, I think that's doable.

If someday we need something hwpt-specific or viommu-specific, we
can always duplicate a different structure.

Thanks
Nicolin

