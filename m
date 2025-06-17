Return-Path: <linux-kselftest+bounces-35159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C82ADBF2E
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 04:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85FFE7A4155
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 02:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87152367BB;
	Tue, 17 Jun 2025 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ko0qPZgI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3368F5C96;
	Tue, 17 Jun 2025 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750127410; cv=fail; b=RYS2jI0CWjucbdDCLz4+Aexs7DcABQtzqXDe6GvXbZYpqgPXrINh/xQ3elHmM2siwp4TwMC9bQ+4bWlCV0c8++k2rgklqHpWZ9c6/YRSrJH/+bFyt6T4I86jbHhRmzmAB9ZCoz6pQLKLy2TxsgIzdBvOcSZATbxTNchdmqh86tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750127410; c=relaxed/simple;
	bh=W1wwa5OS3TFQuS7hKIjT5JIpw3iGlbGkCJ2+9TIAMGQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDvlUokzvb+SkKvmKB08F2BZYCqBJ/0qKPeETuHx1pRJMzcK9x2bF+20WX/DU6X2rd16ci2y4EP+mWe2R0I0J/z1Hyis53MdtnbRS30dMY9URinwo+Tp2csFD+aNIltRuBK+C3nv+zax/1dUzatHBXk+EuoTZaeYtR8pteftH7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ko0qPZgI; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAow2q67AN1YtXYtLLcnK3ApWt/VzI2xSA6NrDrRqhV1+u1EhWxXgP4YftXj3mctbeWxeKrBsOW6ux9TbCqlgWXXhVQaRzhC+fgm3b5C1gOQqqtaMBK+Jwf96lwDjevMzPb/0AquNShC6hdQ6QByaNn2CPAI1VDSR8wp1sEtjokvdvAg7TmJY3RiQeBHvgCbUDc/mGjf3MEW6Y05DTpUEmpIziVLe2WR1kDJ70PnYgZFY1Zl20TCO56BbSTPfF7t46DTYFe2TNU/514wz3/DVNpvBItXmxdOISpmYq9k7RgyVRtYXDy8h86+5l7Nv0MIW40L5pSNDpnoNMUbqUMpyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW3pl5hNcH0EAyycAQuXVBqsktTtX6fZKemNJ7/qAqg=;
 b=he2Am0gecQ+mxWue6FXIqpA/JDUZaj9f4DI1PHYVZKqkLMGcXReFvDmmfJc+GPf7JGxML1TBSUVbr+bbfHT+e60qvjRCGkmWLb1CTrseb6Te35CN4WSt8tbfrOQjUiT27ecr2DHt6kPZlC28YcKAbDpMnkFmgqbsPVBIeBZQHFl+JgyEsh4yv2UzXUBP4vzkFF6vuaIv2mmvv5RM+raj7n96OVHDLvuXvw8zG8g39/akdlQyqB4WrgFRRDLIxXtrGwd9YF0jPiZltb8t5H6eSFTYwLxeigoj53wBW1Qqr5d1M3LTeUwrd5Bu8/5UBBTmumDHo9iPIeg8uHp4cXpOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW3pl5hNcH0EAyycAQuXVBqsktTtX6fZKemNJ7/qAqg=;
 b=ko0qPZgI6MlQ5eJvSRIeQ2iVMwEvapWV9DmDqicmBaqZ48WQkNBELFq3iG9A3pqabnCq4Lh8Dha+Ll0ec1thm/IxyNOf2VdmxlYPvmWIygnTvE4rb8FjLyioZ03jQ8ea15PM93W8GDZEUg8d2rigTm5hQvN2Et42qSHursw0U5NQeDDaDulPVH8awvdrDq5tP9hXUb+ue1NXEqfWIVmz67IOt6uitneoCiJMoPuiHBzddvBbTCjSU6gG/GAZ5t8WfU7f2PzJMVBGFdna9pTKTrzD3CXCBp/OPgD/6pSUx+jlGYDEtyuoj5rK+9PDl07kRGhi5vwzd0fJDEmoEcFKTQ==
Received: from SJ0PR13CA0217.namprd13.prod.outlook.com (2603:10b6:a03:2c1::12)
 by PH7PR12MB6936.namprd12.prod.outlook.com (2603:10b6:510:1ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Tue, 17 Jun
 2025 02:30:04 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::6c) by SJ0PR13CA0217.outlook.office365.com
 (2603:10b6:a03:2c1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Tue,
 17 Jun 2025 02:30:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 02:30:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 19:30:00 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 16 Jun 2025 19:29:59 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 19:29:35 -0700
Date: Mon, 16 Jun 2025 19:29:28 -0700
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
Subject: Re: [PATCH v6 09/25] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE
 and its related struct
Message-ID: <aFDTCOwlcfZuSj2N@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <c9ce52fdbcc7a049b6e27e93875fba4cbc516220.1749884998.git.nicolinc@nvidia.com>
 <20250616134723.GD1174925@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250616134723.GD1174925@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|PH7PR12MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ada549-51a7-4674-b716-08ddad46dde6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mEtva88TxWXxL+Ciohk75B2HkaigCG5M48t7CbkRYktiNtvnN69jxRtLYDOg?=
 =?us-ascii?Q?+MyWXtmgnOJ98jfs4wVytinvvssTYLAB7/oKIstDpHtBkHfcp8PVDyor9qb2?=
 =?us-ascii?Q?r6qiJPMKor75TAX/+GOuq3GuHkXBMJRTJ467iPoQD5D+0NS2SXhwU20SDBFV?=
 =?us-ascii?Q?2KG+xpFysUhQTRA9Yd7upmCKlnZ/zQ86e70GswfuUxCiMFSFJP4ywFbheQp/?=
 =?us-ascii?Q?0uiLXY2vFr1+BVaFyZ1fuZF3AhSu6FqDPwb4SXe85v2xheMZdXznhVBI8le4?=
 =?us-ascii?Q?B88250ZRCTCOW/Zpt39Raie6/uYINsUMdfgznxzhEraSfbxCmSTcYmPug72D?=
 =?us-ascii?Q?ruUZ6c6re1Y+/+xzRr2KDYTZUJRSdV2MHBtWpi1N2NLQe4YHK+xmj9absM5I?=
 =?us-ascii?Q?iW1avW9B2H8R1QgGEd9d/gC1vN9TsZ+GAF4XrtXXSX97mHy5L+yf21zlmnNI?=
 =?us-ascii?Q?8hDd5H79Rg1mZp2mixx36A8V4mJL/sAcLcB3jpet2ZRwA59eVXso3X8r7bc7?=
 =?us-ascii?Q?4BcVqQJ5YJ3nM7qmdU+r+g8Y38O75jDqcFvsMq0siLnk8VbVtO3iDz98nnfB?=
 =?us-ascii?Q?QcHp6glbNYOHZR2IcDxsRtzootElxy7BqtZU+7oeGaFDWCvNqkLruYoN0I43?=
 =?us-ascii?Q?EVK6QU/OrJpi6c9wH+ZQKDiiGADgVdfXH17PYWra0cVmTm/EgNLgoAeWb0F1?=
 =?us-ascii?Q?D8nRI7F6ZdULTZ+1izGHtZPdRZo06E4B7QoUd4ZkqSDVgaYm4WX0D3SF4Wvw?=
 =?us-ascii?Q?HqL0xXo4ZjJp0GM4n29RIr8cLKBX3cZmXdqcv17omIHATNvsQ6yiQkSgYGxP?=
 =?us-ascii?Q?g6QFntgsuKGomw7R42VU1vDtln2XAUM/+6IA+6xmppfXcWQuS7ua2Z3Zyj0U?=
 =?us-ascii?Q?dqloGCbRHTr30/qQ+M4mYD84Cj8WqyRH0snO9c/W5LkbmlXokgzjjRE0+kDC?=
 =?us-ascii?Q?uaH7M5yQg95yVxWH5N3NjRdonrfCjpHqW+D2SLXMuYg2xg+Zp2h6ZxuppeGt?=
 =?us-ascii?Q?hVr/5+2SxJ5lTeUOlSGnkKnX8wZTPYycDZHXXft/w0JDXwe2zK+KkMQuwPI8?=
 =?us-ascii?Q?SAGCfuCnniWANXHoJoP0Rzo/Q/mhWeN4oOWyoLmXbH5OoQpAmjXHB9PNNBpU?=
 =?us-ascii?Q?d3i1nOH0bMYTA75SK1HhfKSsJdDdyYbFqhOkglm0+pwhzEh2EQaYqNdaJzLc?=
 =?us-ascii?Q?mLJOeL20/nwLbKVWEs7b9ClU36wFPseT7gm5a4d/91qAQByFiwH4K485ZtOW?=
 =?us-ascii?Q?++bhDr5ttaK26+VjnP/ISpg4VaL+qfU8h/dI6iPE8mu59jsV+3h/muxO/biu?=
 =?us-ascii?Q?G5WHSgYCQWQQGivPiUeeShYxMkhHMUWXI+W0xNGp0L4ROBynMuMOCcfAzT4k?=
 =?us-ascii?Q?x6TbAT1pcgY/xo4xbXDIbdarN9czaxNrrqB1OWqssI1iq4p8UN3Ozg4JB5ME?=
 =?us-ascii?Q?0IXi1Ly4kJ9IUZwdSt5k/PdGq/Azss0spsrG7fvKpb6HifhKJZ/xtcpXaR7x?=
 =?us-ascii?Q?/IlY1u686uGW8B5LXx0Auk9hcVtv78VGHQDH?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 02:30:03.8019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ada549-51a7-4674-b716-08ddad46dde6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6936

On Mon, Jun 16, 2025 at 10:47:23AM -0300, Jason Gunthorpe wrote:
> On Sat, Jun 14, 2025 at 12:14:34AM -0700, Nicolin Chen wrote:
> > +struct iommufd_hw_queue {
> > +	struct iommufd_object obj;
> > +	struct iommufd_ctx *ictx;
> 
> Try to avoid this if we don't need it

Ah, yes, will drop this.

Thanks
Nicolin

