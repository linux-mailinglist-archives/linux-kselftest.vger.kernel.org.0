Return-Path: <linux-kselftest+bounces-19996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 528309A2A42
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11552283B02
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BAC1DF963;
	Thu, 17 Oct 2024 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="flnQS2UH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF61DED5B;
	Thu, 17 Oct 2024 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184516; cv=fail; b=AnVYUHv4wZu03nymSlblAcYuAhWIUqzMBXEzn1AMGmG7MS4Gm8PFl6bIW+RX3u/8flFiSs0s9IML/Sk7/jI9MFnXw39+hRPMZeH2P9bjq093w3lhueufLFjjoonjiEjwiOfG0yc5xXTpjDHJVAkMguukEMi5dbpV8mLbo91/IHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184516; c=relaxed/simple;
	bh=MWlsmHaahB7LX1imUTUGzwTHvwaDDoB6Utuxskypeb0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIuwv78YOll2wrohqYixp3Oo+Bfx5oloJRO1qzg1z2+bqzbamljnjCFzjZNEfm2yefL9szlFOXGeBuiKyend9ffdptT+GCfFp7v/EXUrJO4vQlkJyEWied2p7p85UbHVnMvARmtu6ERwXSArifGn4kvtsPzxd4UdrZXPs9HYzhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=flnQS2UH; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ry074ysBRA++BxwpTrHPdvSkcbPnZKxwKzm3LensoTotmeeD9XIlSgalqYpfFn9nIfDiuJFxKzFmjImqnKTFeSmHkM2iAm6YcYRQqod1/ubNWcUgzt9X2XUge4H+r0Eo1usPfk6KHOLw+EO1TRuZW9iGBulPLgY8gUTRBB4AeVIliWPj2mnjzoqA2C/u8qa1n/ILZrL+/q7hdo0BUkcnCoKuFJEpCh2P0tVMG86b/LH8B5ouZH2RMH2J3kRxBWF/0FU4u4RrAYUbhoGoS94tTIsQHkA7miolajXCxv5/l8iB25q3x02fH3zLDiLu1cQe2zuMX97bcmZtJHh0CW/5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kG1k6y6V0h+6kELChiSl8kOl1gw+eZrRp9SvDtOaqVU=;
 b=RSYXJxi3UHm2ARAxH9e/ZqLQlr/oPxAwXZ0TTSj909ILIbFEVAGAw/D8hUJOdMcdpdj8JXsTW+EIjsKd8bku0W9ddMPLRXgaLYJ3FFHQnrF/ZJGJk4YoHOQ55RWed0ZtdMk7ynTwN/5Wr7dQPHELxalm3Ht8M0QPMscP5dxkQprOGdbCYWMQWY7iViOiGxcnyS9U4snu7nSkZUOV2a44Ye9JJ3beTErVHzn3C3cdvHAVvpkn0ek9CNNRdIhTy91r7yy0+pgodds/JRcolR0Bfd983ZWcIneiaiagsqAtpY5FodffXFbEES2Z1t+MDgRaeMZ74PhwbhdySA4BrxhawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kG1k6y6V0h+6kELChiSl8kOl1gw+eZrRp9SvDtOaqVU=;
 b=flnQS2UHWMoRAUDi5YqhB3HoVARQo2PYxZhSkU/u/4xTkzva16G6tADlJvnzi4wOWrN/jAwaWM7el3LUT0ivw0Bcr0/vkYBKBOyEnN5Zlobvqq6DWJBVgoP3uOxSzr/HUpCnod9ronthZvgsqaB3/lFMRWZwxgXbjM93elstZIsuwsjwtrV6yB1S1Zz7B6je7QfxrifCQvJYwh/ZoRYoZi/jrZnwL1GzEn7V2Aii6Os/spcZXziBKHuLcSi1F50sKs6OD7RoFQw90t6+mULg5aXiJGuKxIr90pzqwAYHjZ3ooccfuiv98KEteXdJLnUxCVa3BrrbtMgBjG874T5jGQ==
Received: from BN9PR03CA0732.namprd03.prod.outlook.com (2603:10b6:408:110::17)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 17:01:48 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:110:cafe::fb) by BN9PR03CA0732.outlook.office365.com
 (2603:10b6:408:110::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 17:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 17:01:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 10:01:31 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Oct 2024 10:01:30 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Oct 2024 10:01:30 -0700
Date: Thu, 17 Oct 2024 10:01:28 -0700
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
	<patches@lists.linux.dev>
Subject: Re: [PATCH v3 03/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
Message-ID: <ZxFC6KSLVLOi8ok4@Asurada-Nvidia>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
 <20241017163359.GB3559746@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241017163359.GB3559746@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a64513-c16e-4234-fdd6-08dceecd62eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7PbK/Zvgy6n2DzGvUUvTUy6Ai2lK4Sa3qh6cRD1U/YZu0Mo7jgmEfNUlFLMf?=
 =?us-ascii?Q?rT2JlEYch2onIJQRSDmLnB/Bt5vzn/0M6rg3iROi3Ri+xsuTbUnAvbsvn6fS?=
 =?us-ascii?Q?sZFXw9tZdJzHTmdzsKsHR0kiOWzui+HPRWhmmhLLwC+pkyiNfXpS9ueh3RrH?=
 =?us-ascii?Q?+3eNeXSNtHWc8fUfa/68nw84ODOG1VISbu3JK/aMFIcP6SP5b3c1W2smPsuD?=
 =?us-ascii?Q?PDiLENpEm7Zw4u/uGaUr4cXPCFSW4yBbpALigy0iXnjmGS573QZ3I7jYi/5+?=
 =?us-ascii?Q?IQNk6+PYHWY/mvmaQ9m8sFYLUQW4Ki2e/2wZVKZGKHbvKfDofmzo+mKh2sk/?=
 =?us-ascii?Q?nY8OpA7/NdwxXxkm0E7NScmy+gViIP5wJbIqJEzPGK5V50TJKy4ug9x4yTYF?=
 =?us-ascii?Q?06xNAuTAB+z1IDrCRk0W/yN7IOCLwT5HcHp1AaBxWFVH7cdeIT6vng3iX+bd?=
 =?us-ascii?Q?kKgoW4xARcJKAfL6LUcwjvuRKbfhRblJs+IGrJMF+Qp4yAzNo6hGvDf6nNG1?=
 =?us-ascii?Q?tlQzWEe/A9PRjMuxf0fPYnNHMfmt99fn40DadkU8oGOWGhOJdYA8JLpCCYS1?=
 =?us-ascii?Q?TsFsv9ya4hXlWRX9CxkMm6Vs3+hFsNqLMkoJZn24F8766zJBtfcAHPQYnhvz?=
 =?us-ascii?Q?7bIz9MWCgv6Yg5xnluPucpvPMTHRPAiTJLNlNQvTudi5FVGR6ZEdqk2sXuoY?=
 =?us-ascii?Q?UnRM/Ds/8kZBccwjG2EPMK5wp4fmZLGhfJZHgH2dhNSWbIJ9tpPuLbCfAP8Q?=
 =?us-ascii?Q?1BQ8XHM2V1XXzr2//JzOM7+XEp9hRFkBhIKCJdqj/4226YZverYdKewC7CDc?=
 =?us-ascii?Q?ltcwOHRyksw3BI1fohcJbOgXelgjhJP52f44gbPG/EXugHhq1U2HJfae9oF9?=
 =?us-ascii?Q?6W2BXJe/p9LJU06ImSPpclxsRS0/xrhrMjdyv7WL0AeZNEmBaK9UYEadeV6g?=
 =?us-ascii?Q?pDOqisdQFROi3a62b1cMGtg8wxW8sN1gsdLuuBWNebON/CKaFEI2mvDZwXBd?=
 =?us-ascii?Q?HMXK6/GAI68PeQ7niJ1l8fIW09ksYOa64q1d+b43iTI+deIcrqRRA+2nUVA8?=
 =?us-ascii?Q?00JkmeWnU2rJImjvR/Y3Vus3Rph/AkZs9waeHar2ksRFxJl/4uohB9XVpRGZ?=
 =?us-ascii?Q?c6i4zjPpRp1zeaHECdFAiorSmpZ7JcdAV4rd2NE/K4V83DS/XkWCBPrjqbXj?=
 =?us-ascii?Q?iJh1q4grm9z8Mvi437OrqeIHbxxaM6TyWqksE8DY1t9Mo1Y7ZSjffhSshEMr?=
 =?us-ascii?Q?qCqvTwhI5KoidEypJdsdnl4SsdO3Gqv7FC6tw160np3VaBz+90A18847O+ea?=
 =?us-ascii?Q?4GNObXrYfDXI+Uhkx3ocKtdjDYzW5OuUzsVEk4KVUcPgwUBI8oUZ1fAkhG7w?=
 =?us-ascii?Q?4BI49Nyw9BEkOoBX0GizIz5Iv3Y1s6jO5iOCDj1k9mwOHcblCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:01:47.3701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a64513-c16e-4234-fdd6-08dceecd62eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233

On Thu, Oct 17, 2024 at 01:33:59PM -0300, Jason Gunthorpe wrote:

> > diff --git a/drivers/iommu/iommufd/viommu_api.c b/drivers/iommu/iommufd/viommu_api.c
> > new file mode 100644
> > index 000000000000..c1731f080d6b
> > --- /dev/null
> > +++ b/drivers/iommu/iommufd/viommu_api.c
> 
> Let's call this file driver.c to match CONFIG_IOMMUFD_DRIVER

Would this make its scope too large that it might feel odd to have
the iova_bitmap.c in a separate file?

> /*
>  * Helpers for IOMMU driver to allocate driver structures that will be freed by
>  * the iommufd core. The free op will be called prior to freeing the memory.
>  */
> #define iommufd_viommu_alloc(ictx, drv_struct, member, viommu_ops)            \
> 	({                                                                    \
> 		struct drv_struct *ret;                                       \
>                                                                               \
> 		static_assert(                                                \
> 			__same_type(struct iommufd_viommu,                    \
> 				    ((struct drv_struct *)NULL)->member));    \
> 		static_assert(offsetof(struct drv_struct, member.obj) == 0);  \
> 		ret = (struct drv_struct *)iommufd_object_alloc_elm(          \
> 			ictx, sizeof(struct drv_struct), IOMMUFD_OBJ_VIOMMU); \
> 		ret->member.ops = viommu_ops;                                 \
> 		ret;                                                          \
> 	})

OK. Will try with this.

Thanks
Nicolin

