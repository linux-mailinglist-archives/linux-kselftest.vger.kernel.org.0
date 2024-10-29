Return-Path: <linux-kselftest+bounces-20986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 893E39B4F23
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 17:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4756428531F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 16:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F8E196C7C;
	Tue, 29 Oct 2024 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j7mPw2Ds"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F0F192D68;
	Tue, 29 Oct 2024 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218712; cv=fail; b=GLM5bw0KjqDo1pOgXGjNfVZ8QT3L5jYexEnlcGu9gWAMVJd000eMl5qnEkGTazFoG9HxVJ+US/IwjET8C3+4EaDPbSBtwEFYf1krHe14almf+dbm+RJVwW4m8f8Y+Vg8UEPCNBWAtwfGRDDdlJ6O+gf2ai/mOc2ziAk57C3ZLL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218712; c=relaxed/simple;
	bh=ui84a2Dt+kI0Rm+GZnj0zQ6o8MbXOzRTgB6kdDGAdIw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMgPRj87tiTHUuYZaPd5Qus5PZYP5qPZOw3BxLV9T04Oz2UGaTV6OvXvs4Qcs1Sghy2Bk2HYlZziDdiXWjGrQqV+S2rMHZywvjlccMdFFNDZhiQM5zs7GIICWeGDi5I4Mkke71UxWuYrHmtCFCjmutvlRrVjFco43Pil8SWh6y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j7mPw2Ds; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqrpLWL0cT8TvwK8hs0qGoYWiLT4LFpFZ8jQ6TW2OrrIeLHfCJsldf61Y356y4e6bVyU1NyhBM4morpYoLw/pD3HcZVG0uqMvtgie4UmBZX09YEwEiGkGoDkDV/aahh/SHCcr1S4BFgUiBJTlJXVrrcCqiMbdztyvslqr6yNh1XPxyHVnToyAGyUl68ziSSwbNFVhNihTr2m8tn+7ZlgRqmChWlckV/1RRJGzgpc/qJQJ0oRN68sZUOp6tNvGtw4ED6mTHVQHaurZ5wVmol5dY+WF8J2JvrbJvr/l5TvQcizMmy2u/bZk0N44QzaRkdkLvcliABiME7Hw3qVjWvbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wywf+WjxkcYsKm0sj94F7Vq9koNkB60UEnjqYCVrlA4=;
 b=CsRQBEOfbl/9ft1cs6lD1OZtLxCh9BxFVukRe66fCfg/5pIjuyOceayL0eNEfemzE281d5lTDIj7kWyKOngKDnNHyDGTFlSFFRkcPsw0+kz+93Jy+9oz3YyMRx6SRMsu/SW+eEjGJsk/whVHRHYZba9iXxzap2jbJCSeaMd9XBuNNbh1fL0s5X3KpUi//Jq8QbI4k6M98uW0dPpL6H6ZgRG4zL2BonVeU4NdkhnI4ryZqnJ6v217q3FWHK00SThmkUjrbK6M3J8Pgvvvy77Ze9VbpeBAspJ/CO/r+2SHyokwpqh7PjPmNrnMV0sJnWRXEfk4/21CNrbjfSSnPaubNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wywf+WjxkcYsKm0sj94F7Vq9koNkB60UEnjqYCVrlA4=;
 b=j7mPw2DsBRt//uJAoMlRaB3No5wEyc20Qkxkm4c9nAyvgpXvdpT9hV+wcV3dnUuzRWQk3rsRz8HjIKCbR3ZE48KK8ZjVDNuTegOJTcrYRrDqJJCpwOuILDnCG0DZla8v7Q9K32/nT4/UTZOJkogPFGIsgyKS7poVk+UFZO289fLM4GVaGf+5K0mx+G/yOF0UrjiDbKdDQUCdumVipyKRU38858nLFV7GjZ2Yiq6U45Iqqx64fO57VvfOzRkKgMM0H6XENilptN18Kn6PTCnEsGEP/kFWUHsuRYqeNSrpuyIhJu9IELNrZgQONOvfuX4lY+25tlp2MfshISdm/z46Zg==
Received: from BY3PR05CA0027.namprd05.prod.outlook.com (2603:10b6:a03:254::32)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 16:18:25 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::cc) by BY3PR05CA0027.outlook.office365.com
 (2603:10b6:a03:254::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.14 via Frontend
 Transport; Tue, 29 Oct 2024 16:18:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 16:18:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 09:18:09 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 09:18:08 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 29 Oct 2024 09:18:07 -0700
Date: Tue, 29 Oct 2024 09:18:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 03/13] iommufd: Add iommufd_verify_unfinalized_object
Message-ID: <ZyEKvcpgUsS1nCEg@Asurada-Nvidia>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <e99946ea0128370349373c94339d465397946137.1729897352.git.nicolinc@nvidia.com>
 <20241029144907.GB209124@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241029144907.GB209124@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|CH3PR12MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: a9fc50a2-03bb-40aa-83b3-08dcf83550fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z7xNHfJ0DISxTXvb58qOeG4Tl/w8hyLOk1chRTVMgXh2VPtdZrxIx3SlIvIZ?=
 =?us-ascii?Q?TLkKW+J7ADCI3HGxlhyXgNTk9vM1yauTuheKkwCVDsxx9gfkMZDxLFp24E90?=
 =?us-ascii?Q?W4dPdMylS06mMUQZPw8X/cYUM70fFjFSEViV0zf+OcFNeBqq8w4Ze5oY69tF?=
 =?us-ascii?Q?HObvye26rpM4RHRJ4NfRhtkosilKYiL0q5cdLwvW34DSaFigxr8zgjvNYLyN?=
 =?us-ascii?Q?fZLcWx+QL3o+atD/OcRCWyBXx3Z1ksCKxHs0lNQe/9+AgjiZAxZpfgbRu/se?=
 =?us-ascii?Q?w0hcepBCYXgR4M9+nZ/kmkXuNcPfP/x5FscWNxLmx3y4SlnGo9Uh6sHRO3Xn?=
 =?us-ascii?Q?6lTAIj1FSPEVithkbKAlZgIlcnp7h+i9sgcdI8Pmd4zYjNJM+MYsnSciy9Jd?=
 =?us-ascii?Q?j8IqEVQbv8ZOza7zWmntmvo0Xoxlcy5dQVnQp53Bds1aJAQrfHQWllcdtL0Y?=
 =?us-ascii?Q?troKoAUkAf18bRQVwZv0d1IUU78kroZpLEYi05hmsuLfz3OOngkWN98udDeD?=
 =?us-ascii?Q?y/817DfcA3o3DYbJBxGQ/HMM+a4gScj7JyTzMs+5b1eTjgVDH6G46cNVuAGn?=
 =?us-ascii?Q?i7mC0OhEEjm0A5IGx2X7JM2dMuG+RZDOt/IYT0PP5AeElr0ElWZoHTq46afa?=
 =?us-ascii?Q?Mrye5Wkd4zYrst9WdUDwcazBTSvVcQ/ewlBV8MQpg4fAFandJB7+1KD8GU/U?=
 =?us-ascii?Q?LWsx1NwZII9LivzMIBfOZqjf/xYJ7z6tHVZ+0KUCH56ZjX7EotFnjUdzNXBU?=
 =?us-ascii?Q?U15ZSVDqfuVFt8i8B6N4hx1oI+Ah20eFIKQiqg+K6KjoTkTtmi78KRiG7VQ2?=
 =?us-ascii?Q?P54lvw+PSeTODz2Y6zEEXvZLVte077fR1VVI+Lt0yYyxcKluVuuW5k76v4f5?=
 =?us-ascii?Q?mAPC9HJ/zxEDkAA+bP+ZQZ4cpPSwNwM97nKPbgZiQRTekkFG8LJA66oec12d?=
 =?us-ascii?Q?J/fap0Gklbx2ispWoO5/6y9cg3rJpdWVTKGvaVbHKfgXJgcc9i+mHX5F5E7q?=
 =?us-ascii?Q?jpGqLPif1EqIDiS1hiFfaWd9xYVfOgwD7sd/58jvi2TwCHBPn1liaojT3/Yo?=
 =?us-ascii?Q?b/HMRm+m0O9uc2D3oAe54LpbD0hT/rkwKwVfbROmBMU2zIC4o4I/G2wsnv7D?=
 =?us-ascii?Q?PQNGpCCT6uS6EwsOU2GlB/yAzlF3SFHRMBzlJ3oyl/Z2q1Fa4Om7k8aPzUyS?=
 =?us-ascii?Q?J6YwPUByUF/IotPRYjbzqJ2SkqUuhREFQBe6VYbGvxJalGRxpyS8UaNUSitx?=
 =?us-ascii?Q?lpvBJb90lYLTnSK8ZmUix/9kabqFogPnqvoO/+cxzCdNcCHukEsV91Q/J6nV?=
 =?us-ascii?Q?fH5nlhXMUrGTgGRl321L96iC/FvGHy4J2cHc4W9oXFJp6yiznmSDiGOnK4dA?=
 =?us-ascii?Q?HBoksIaIrTwgn+oSuLY01Zkp5SHE2QzkBYJRhdmKT550EpGfhA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:18:25.4199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fc50a2-03bb-40aa-83b3-08dcf83550fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658

On Tue, Oct 29, 2024 at 11:49:07AM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 25, 2024 at 04:49:43PM -0700, Nicolin Chen wrote:
> > To support driver-allocated vIOMMU objects, it's suggested to call the
> > allocator helper in IOMMU dirvers. However, there is no guarantee that
> > drivers will all use it and allocate objects properly.
> > 
> > Add a helper for iommufd core to verify if an unfinalized object is at
> > least reserved in the ictx.
> 
> I don't think we need this..
> 
> iommufd_object_finalize() already does:
> 
> 	old = xa_store(&ictx->objects, obj->id, obj, GFP_KERNEL);
> 	/* obj->id was returned from xa_alloc() so the xa_store() cannot fail */
> 	WARN_ON(old);

It feels unsafe to carry on the iommufd_viommu_alloc_ioctl() until
iommufd_object_finalize() as the function would touch the returned
faulty viommu pointer? E.g. what if the viommu has an even smaller
size than struct iommufd_viommu?

> So, we could enhance it to be more robust, like this patch is doing:
> 
> void iommufd_object_finalize(struct iommufd_ctx *ictx,
> 			     struct iommufd_object *obj)
> {
> 	void *old;
> 
> 	old = xa_cmpxchg(&ictx->objects, obj->id, XA_ZERO_ENTRY, obj,
> 			 GFP_KERNEL);
> 	/* obj->id was returned from xa_alloc() so the xa_store() cannot fail */
> 	WARN_ON(old != XA_ZERO_ENTRY);
> 
> It is always a driver bug to not initialize that object, so WARN_ON is
> OK.

I think we'd need the same change in iommufd_object_abort() too.

Thanks
Nicolin

