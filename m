Return-Path: <linux-kselftest+bounces-19589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 804F199B0D9
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 06:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D932BB226A4
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 04:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2B412D1FA;
	Sat, 12 Oct 2024 04:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o4C4E84t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1021D38B;
	Sat, 12 Oct 2024 04:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728708597; cv=fail; b=N1tlMFLYpmffvIUYYyza4hcpQovSWlODg1Uug1hkUK3rXy27YcIlKeycyR/lmjEXS/eMaGPa7D2sw8ilcEcPr9LbxGral4FmcSIjWo4176UQKlcSe+YxhCNqZ395sHLj9x5EPxP+8TXgDxXwRFDiCvam6XX7nH7Hq5mICGN023s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728708597; c=relaxed/simple;
	bh=DaFjxaHiFbNXGWG0GScewtP0cwnl+2LStT/7MEJtF+M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRvhCFI9UngVqLutut8PM9iLZqPi1GWc6mRgleI+v4B+CqwdzYgH6bhdp5rUapmsIogJdNz+EA4ZJR0XeCNh7+S7XVveWZREdDFl1XYn06W4LWeRlvb102mnywlO2hu5HDaNNURbwTmm5hcuoUfb8R1IW2OmhNE2FBOVecScjA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o4C4E84t; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkbgE2y3RdFikjxAdOy9Dal85M6H/H0PieW0/+C9L2VwLy+mxRCA3dzHVicuo6jGxU2duhUFvcyzxsQ6UosET1tS+H1gpwuGlHnOfLPn0aMNmSK0QwEP/CxU4X49laq49VQg35EcHqnsWGQfRI2t6aVgjUc3yODHmQDAxfJxPWdpIFCDvbGk+ht/rzsjh+kHAPeSuXx0GobGEv02BRxMqX1eCiSkJQwjBCi2lZ5F2TxrbYZCx2zWZitpvpSJ5raXhKmJtQIp+XvTfPfD/5RkJ4qmlAALP7go5ab+BS048mQamuV7KYnt5UNETpplkp7kZGeTOIjH6+JzpFLC3kyUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmeZFEXrCEpBnDFBBpNB9+9f+D4X0Vd5wW3r1TOpBCs=;
 b=FlL3Y8VKoTMsmF5bUzHbN5l8Ly5qAJgOFXS3snp/Mn4dlAO5j33X6FEUV7KGeA4Qzh9NmDfRkoVhWAJnUq5r0X+dW50A43cSj1xiEW6qY8hh+m01kIv8AI4NzyeNNMOwFs5XWAR+LLJGPmGB0WB3M152Es3PzHId7/maqNit6+cHgMBqauwlHz61d65pL5PqY/p9HeOno31tn356viCnnR0U2u4jaBml4Ut7Zv7iQwmx1HIkHzMGGxwLw6Pxt8MMU+zy70jtDM/MmrXuKj7k8LGf8cEVH2J2D13GgHlsgoiWa7W7e8INvU4F9ucXOGaZB0ahXbaeTdFU7cFOztyjbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmeZFEXrCEpBnDFBBpNB9+9f+D4X0Vd5wW3r1TOpBCs=;
 b=o4C4E84t+eycUtHv+c2Osk55M7tDhRjh21xvjaDflE5rKkxXUpWRfVnDxdpYGOvrIH+PKN+Lzo36CmQyz0630P0BNQnLGg21EjCdRlAPmwZ1Ju0t+ieDsOxHH3MzhyCAUtDE84Kyd+M8PZ2QAkuuPEu4phno36HVTvdXMeMgFM7Mp+PlF5ExolcLFTUgsJEDzWLT8FCITjlqYKAyEYHRhLwlaMKx/lff7Eh5kCmY+2/Zb+lHYBHYyszNYLata0lk1GEr+p+NkRQ3WhIOcyaUV5vkMDMtTgGWxh4xgVTpi0SCpBlhnYyvpwSC8UhS+H759CGu+jp6UUmynaTGsejkPw==
Received: from BL1PR13CA0029.namprd13.prod.outlook.com (2603:10b6:208:256::34)
 by SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sat, 12 Oct
 2024 04:49:50 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::a6) by BL1PR13CA0029.outlook.office365.com
 (2603:10b6:208:256::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.8 via Frontend
 Transport; Sat, 12 Oct 2024 04:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Sat, 12 Oct 2024 04:49:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Oct
 2024 21:49:41 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Oct
 2024 21:49:41 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 11 Oct 2024 21:49:39 -0700
Date: Fri, 11 Oct 2024 21:49:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v3 03/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
Message-ID: <Zwn/4m8Ac0xEiJi8@Asurada-Nvidia>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
 <CABQgh9Eaj_vy1=sS2Pf7RC7Vy5PopDfwoshECULEU-jK3JF_sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABQgh9Eaj_vy1=sS2Pf7RC7Vy5PopDfwoshECULEU-jK3JF_sQ@mail.gmail.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e72eba3-38dc-46e1-6ab6-08dcea794ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ta077WGGZD5nArmjNJ5lhlpGUC8k5UEGoX5j1Rtm5BnfFKm/bt7VxIk6FOku?=
 =?us-ascii?Q?VQGqMvt4nWIFgBm0VzB32FoPFpgEaciYYmmxf340EyjwHOWCGuGs5J3P3xNY?=
 =?us-ascii?Q?+LdxN6jAxis1vFpPTD8Hwf6xC0FM3xzsHsjk0JH0VMmj/2cQcv19f+HlsQKo?=
 =?us-ascii?Q?RSB2dTCcWzLlcvyK1JXyNhLtUpt1wo+FutWCI9WF19S1eNAQDRsoU17dmScW?=
 =?us-ascii?Q?HqY25Oq46I7jPgOL+ZE8cnNTwmd2cFFXeRc3sJYCbbrOIdkF+39XpKUIpDFA?=
 =?us-ascii?Q?QuywZuGk39sDwn5dgAv/byzlqlhxWThK5/YS/cBCLQPzdo2msRDSpsm6CYy0?=
 =?us-ascii?Q?kb1lx71nTndE2JoQRQURPl7yHXkbSTlktVnWoQfNDo9giSOy9O/qnuuEwmKA?=
 =?us-ascii?Q?WZmOJpk7ekNvKHAcu+EBO8Dirk3o5kh6HtF62iQVA8HXZxMnL0l07qUt9Zte?=
 =?us-ascii?Q?ZE04l5Vv+913b8aaUBXSpQFCl9BGf7ZxzBcWH0WO/h28TLGic7LjQMSz9Ade?=
 =?us-ascii?Q?K5TNGCl2GKng008jPEU+hMSpVXGnsrHG6/V9MuD7nbFVzIS5e7HedRJwVl53?=
 =?us-ascii?Q?3lrgfwhgjO+oHil33ZluhBjcTe+XuEiP1hvaE4gf2dLFxTq1DvvZZXMWHqP3?=
 =?us-ascii?Q?/zOnZaAdJalmZ0A/pV85+lCAzgiaidFhrhwrFW+SSOgNLcrnFJ8gbTOybGC8?=
 =?us-ascii?Q?AovVrCYRcWzFahHX3KZMGHxfNT1rm3AG0kr1yurojXSVMFkblxnCsoDZs175?=
 =?us-ascii?Q?sWjYa8S4P0Z+xjtmEV5M+Yd/RzCq9vtlcbX4HWJIax7WzWCjFBRoIeh8Sb3H?=
 =?us-ascii?Q?ewYunaREZuyjcBdFZUniOlbseZyOJih4WcGR6Q04MXZ+5mdg797yX1RY+ntv?=
 =?us-ascii?Q?7RmbYH+qjBSb5WmkhFVNbLeI+LJWICU0vLBsBmJt+xj+36+kLBax/TDzjYdz?=
 =?us-ascii?Q?um+J97aFq1pUU5wvcTfeBAf0f03XWoL6RrGb7ienPgqzFj/DmEIY4c0cE6QE?=
 =?us-ascii?Q?dJFJNk7IQIJ3VNMCLmrMU07p97h+L8TloUMxfijJu4FAaLvdpp/D13sR7s3e?=
 =?us-ascii?Q?jF3W0zi4khc10hF9t3Mzb0gXmHhqPMudFQ4bdbkvVziV1U/DHK0nulTM+8J2?=
 =?us-ascii?Q?+Zjy/0bpS9FGD7urwEleb/r511ykM0Ziut6mydXitvYhD3asFyB5IjDFnFtS?=
 =?us-ascii?Q?j8ZAl11j5W8TJ9hoP8jpOj+jMYcgNuhhDXeJnM2mxfDjOV+vIultYc6UAMHk?=
 =?us-ascii?Q?PnKgk7LOKbo0BjKFGLQR6aeJGVbOYjhzJvh55dt94woblQNk4+lCBELrIp+E?=
 =?us-ascii?Q?sM+OOylkk9P0rSgHgR8vQysLt8c2ImASxNy14eaISDtFNtf3yTAsLoxwA07F?=
 =?us-ascii?Q?EgCH/tIgGFn6yqdI7LU5qZHvTEa9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 04:49:49.6191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e72eba3-38dc-46e1-6ab6-08dcea794ddd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944

On Sat, Oct 12, 2024 at 11:23:07AM +0800, Zhangfei Gao wrote:
 
> > diff --git a/drivers/iommu/iommufd/viommu_api.c b/drivers/iommu/iommufd/viommu_api.c
> > new file mode 100644
> > index 000000000000..c1731f080d6b
> > --- /dev/null
> > +++ b/drivers/iommu/iommufd/viommu_api.c
> > @@ -0,0 +1,57 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
> > + */
> > +
> > +#include "iommufd_private.h"
> > +
> > +struct iommufd_object *iommufd_object_alloc_elm(struct iommufd_ctx *ictx,
> > +                                               size_t size,
> > +                                               enum iommufd_object_type type)
> > +{
> > +       struct iommufd_object *obj;
> > +       int rc;
> > +
> > +       obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
> > +       if (!obj)
> > +               return ERR_PTR(-ENOMEM);
> > +       obj->type = type;
> > +       /* Starts out bias'd by 1 until it is removed from the xarray */
> > +       refcount_set(&obj->shortterm_users, 1);
> > +       refcount_set(&obj->users, 1);
> 
> here set refcont 1
> 
> iommufd_device_bind -> iommufd_object_alloc(ictx, idev,
> IOMMUFD_OBJ_DEVICE): refcont -> 1
> refcount_inc(&idev->obj.users); refcount -> 2
> will cause iommufd_device_unbind fail.
> 
> May remove refcount_inc(&idev->obj.users) in iommufd_device_bind

Hmm, why would it fail? Or is it failing on your system?

This patch doesn't change the function but only moved it..

Thanks
Nicolin

