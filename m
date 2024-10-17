Return-Path: <linux-kselftest+bounces-19999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FCF9A2AE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32494B26B8D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB781DF99F;
	Thu, 17 Oct 2024 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QdNbVh+5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A161DF73C;
	Thu, 17 Oct 2024 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184861; cv=fail; b=GWBtzVPQHUUp8Oatn8uaf1iOTSRUL+rAP8GaQVh9izwD0cx6bA5wH/7fc+Y3u0wKHQXWOvscihhXT79WVaH9OC32xhPkPmwkHtlwcJFb+HqmQedSppvbvkYnkDRlRdWQrl1X8k01KgK13h165kDRxr7K3kRjOyBINjVdtmquBC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184861; c=relaxed/simple;
	bh=8wYHVW3MxbYsrhB5z3wDOe6anROQ8Q6gkNE6vASuL+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gUcLBYLkUb06TWGjSm+oklJaTQAqHjueb8/6wH4LXAL2Cg6XjVXQrCBrIuYMecLhe0NV0SOJj7PeKWvWLU826Ex8gmELNaCE5B6JkWRKwGuts6wehpps3LxP87hBMstokCbltIvoE7JiRmwzFdKjt+ojTPkk8xXE51FAARzO/FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QdNbVh+5; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7b2MesKGNaqlJBVan4oJFCfr7YU5TbYYBvmtZZWF4oIENbgQMVwOx936oZRoVRBjjP5RElAgj46R9gp80EXFYaIHtOVjtlCdxnEEZwc8QM1Rd61I3BsoSKHaQ32f6z802pBJR0seKO3+v0ZCbihZhdRWdkWVKZLvt5jiYHw4AE8obMWxl7/SrH7Fiq1Dlzj0oShpEFYzu3DcbEFqtVK/PdZfUAiGsePmxGaW+mOWBxGNuHilKum1eQ7TzDcQ6YpwYTp8weWt+MN1KaGZzLmy0RNK63nN0IKc/MbWiIZ3iJZnMp85mxhrx3aVeaoxxvSwb08qzSSnPWHyEoaZIYy5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJL1CSM8ItlrSONWLpSpa7mkJ6XZ9CCwnzzLXsLVZvA=;
 b=LugN6OJMC7hArismnOpn061BkiwjMyvvponPK70h0bruhiU4zRa7rRv/vloYYFCahttbUJl4ontEsXaZvcydeNTF4QX2X6nTuwedjfa8ZR3Ih95eCdP7e99QMx2qVbKMEsM4MtK6g6+9Ng11ApG8FRoLlrsots6z0veHwy7xG/SOzxBmo3DYLbnt4d2nJHxzS2sY829qcvglInJYQMxI+L8pDGBQUZ8tv7uFhK9vOj260AW0tPh2/5ZaZ4fJir6QfJD66qAWUOtmWNdn6PogU/SoqpEJ977nWhdeelDAIBneDZerod49rF05/DnIZTMcbR7g4q9PMhuZJbUS4/25rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJL1CSM8ItlrSONWLpSpa7mkJ6XZ9CCwnzzLXsLVZvA=;
 b=QdNbVh+5wnCLMYfaXFW7LZe75Sqj0GFOZXUSQGsi/h5tPSCF5TZAl/xFSiOBUJWyZ99Bs+PLh9bCee6Agi2hPXjss3veoJ+iBWQuOfIkJ7Wdu/aKdfLOMWysoqAS+mxB7JMzFO9tK1dAsT2cU+t0/H6iULo78Fz6Ajye83qdSbw6gpboafh0SaFeiWw/PmBb3PB+7LulLon356oCkANPtPDxWIVQX2kgz7WJkFNUfxuNzA5pa2UKXXRi7KXwgUOw7bLC/7S1axNw5Bi6kOzCsV1Qb6t740czOvgduoVVlKCMZ1LkL8injGoXuzi87JrLdDGDF8Nj40F1/xmu4hOs8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 17:07:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 17:07:37 +0000
Date: Thu, 17 Oct 2024 14:07:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v3 03/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
Message-ID: <20241017170736.GJ3559746@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
 <20241017163359.GB3559746@nvidia.com>
 <ZxFC6KSLVLOi8ok4@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxFC6KSLVLOi8ok4@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR1501CA0036.namprd15.prod.outlook.com
 (2603:10b6:207:17::49) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0a9dfc-e3c6-4d0c-9ed9-08dceece3322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i+XAvA2mzAr9NdVEWH/NAsE4PtmjU1ughFka7WAXrjETxPUMknpLxFXtz8rQ?=
 =?us-ascii?Q?xZzQQoSiEksNQRJTShtC6bUhGCPEUizEUx/VKSGdLUZV0DifHxuVYX666z+t?=
 =?us-ascii?Q?0zITSFGbCERnmB4mw4JjyFRLZ2fjN1bnVw6fEviWel/ikN6Ov2+46d9itMti?=
 =?us-ascii?Q?QZBET8YWqQWicXUr6AQI8fYnD3w8qzijdTm82EL/5ab0XZdChggh0CXh7U15?=
 =?us-ascii?Q?xPJExoIkdrVoRvV3+F6SWRhblzvVw8oeL6gK7/9Sy1zgsJ3DB3Ni6APzi6H0?=
 =?us-ascii?Q?GtLH2olz7E4JO0Cl/zlu5LQliuikBxa+cibOVuac6ITuV9SqyyjKkUNN1GVV?=
 =?us-ascii?Q?muBDs/gdE9QtTGr4xXfv+N9PqUvCGQ3RzJKl56MFaFxks4UE5KMZjLOlUDjb?=
 =?us-ascii?Q?ajMSdRrAaR1miG1KNN0hxjGqpqM/nUZBC6HRx+oQhDlnw8/hMclumEGUwD8k?=
 =?us-ascii?Q?BmU8qbXTS6+bqPHoS6a+2y1gp9nMy9a82Z2eswmxgiQCWs975KzL5pDFgkdZ?=
 =?us-ascii?Q?a9vQCQ7xRZlmtJIL9v7qn2OSqE2DdH913R6/9sBzdF8nt7sB34TQhi1fajNw?=
 =?us-ascii?Q?08xFqgc1/DsH9o6WPWvvfuLKnqTvGVXFDc7npQ4Ma+CsmW0+BkvfjY1cV84d?=
 =?us-ascii?Q?bATxW5TGBc47f2lNwmcQOUWK7fb5cDRe/CoSkXxQ8gRj0ThN6A15suHTFmcC?=
 =?us-ascii?Q?ci2ZAf3d8BLwVYqPGx1yVPIp8VAjgo5CVcjiCwP9FvFAjJmfg2b2c0vLcYb8?=
 =?us-ascii?Q?TaHeIgu8eiK+id+/5FlCYAkPfpTkcwx/shPBGKop3ug2Cp4Av5hTe2fXGFd1?=
 =?us-ascii?Q?2joT/6an1jOQkFkXHc5TAejrG/5DI/Nt37njltymV8moZjvDiTynbu5m4LV3?=
 =?us-ascii?Q?UZeRSRbsJPu4M2969ho/Cjtm9PhP40YIMwIVcznqK+fKMekFzJ2F5noK1IqG?=
 =?us-ascii?Q?V0D9VNLlbe2VdtEMGEUbAV3e9wbg9Bxih2nFl3pKz8YoPeIFwLJwzZWv5pco?=
 =?us-ascii?Q?xb+LIEqnxLf1wQhip2l+8/PimYE2tsKDVbGXK2uU8NvAaxxWjmMT5nZftv7n?=
 =?us-ascii?Q?fYjXBK0/Rd6SMq8vCOmFQoGz9zPpgq8nXF4eWtJJkDIPpGky3yedYJuyFzlB?=
 =?us-ascii?Q?BjozELJoz2oIY6OIHubzVS4EZ6Hm4FAOmIL8X5tulJ2yUxiU6+Ggx0WeAn2q?=
 =?us-ascii?Q?v21W/KnO1vBPWhg6888H09/BKadm00h+PJ0l9MJVJbT5HZTHHxbmuVk1hbbY?=
 =?us-ascii?Q?4kdhTeZrFrgUCe7BVnQOft5KKg0S/JEmxPcbxxorVswpeWIzLjG+sJzxtfgv?=
 =?us-ascii?Q?X0rZg6Xnn8nMLdFLahsHCy71?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5lUiavR4l3vTKNXFU8lc6GSGUOBjhBasp6m8Fe3uT9QCq67KQF/wzEs/tGr5?=
 =?us-ascii?Q?PTSykfzwIjO3J1ABsA/I1N5zjcxdJ7eKdCFEfZV+PQ8YoBxxLPnL6uGBTRrW?=
 =?us-ascii?Q?93YGv3rRnBnsqTMo0ybpyBWpzX3RN/3q2lBFbcP9qZR8chMDnXLA69cIMzSE?=
 =?us-ascii?Q?wJ0/c+32MczS7VAQLtjwdZvIrse2ZEgdPqJdmWpe0CKGkO6GXsGOFzrJRoRI?=
 =?us-ascii?Q?PJh+JnOF83OQ4xU8W0yNyB4yTbmul/UlYfWUt5KMxpc9tbtMZN5iPl/x4a5u?=
 =?us-ascii?Q?ILhg91qgth5I8f4//okQGDfLp4jV44YfsN3j1jEINlehsXBdSbvOjE2fXLnC?=
 =?us-ascii?Q?xnCQAXcVaMsSfKuPtasSFDZZaeCmIWPVeMR9QfrMfISMayU/Mm0uLr8e4t73?=
 =?us-ascii?Q?nJ7AWjNRnNhNpZvHyqFx4lknllGlSqX88uaTLnJkgqnvfAA9ZJ9Csz7829vo?=
 =?us-ascii?Q?GieLVzm98NEfBTsCk8EgLXXglXGHqUSnqWjHICiGm6/KjxZh0nkeBzryJh6h?=
 =?us-ascii?Q?gFqnoaquwPlrOiGYSaxVR0xLOPQv0EXxXnzWBXO8mq5yGFyhPvz9dHbP9G8O?=
 =?us-ascii?Q?S77iR7m5JuuLe6I03a3Tq5LgF4GEQfQkapZ1aTm4BCVy7UQg72Mj8K8xIwuN?=
 =?us-ascii?Q?d/m/CtiYypygovar6+BlHNnbLuXwQjyJqJZAaSAmsIKc4wyf7KfCEg+8Cy8g?=
 =?us-ascii?Q?XuasisMs1VX6cRwHYNoXT97ghIVfVNXQxHTlN0kJnoGm4sJX8v/FzKFnaCL0?=
 =?us-ascii?Q?ZZjsaP+BC6+j3uIyPtGKXg0Z+4R+3CTq8EcSAhrzFl8z8myT5tRjYZ4bzK/I?=
 =?us-ascii?Q?Vzc6qq/hcYqP3U02+j3SDgXYpUxzOdnbCCQq4rlYiSJOnMRT9vDWdJnOpkuG?=
 =?us-ascii?Q?TmTVKfJBBsngEHm6ulXx6HLpAI0nCxKd2uynphs9tRUT6AuEFMimoWYGLfD+?=
 =?us-ascii?Q?3xybKkkuQR/aieIA9yJFKOKer4eWYaYg+D5bcghDXHcOMezK1coU/Rlas3KQ?=
 =?us-ascii?Q?Avzhtvh69NCR3ZfwQECc46Y5gby3qMsvXCcGQ1pemmtW1Hqvyu439hAGSKWV?=
 =?us-ascii?Q?/GalYgrflEDS1leX9q2/BoYJBM+5Fv3Mkqd/gkYExYX4Uu14qbP0C4GQdzhd?=
 =?us-ascii?Q?jNUiHpdtYJUbU3RC9rKRLMHHRgMe9lIsjAKQ6Dc83lam2UJEaCn7VBFYHj+L?=
 =?us-ascii?Q?GvqELTS6+p1eZQExR8gq8TxtVau5f8kdLkTw0Q6cnlNRXnffsBJntQgLONMq?=
 =?us-ascii?Q?K0S3TuwAl7RJcjsOExxBx8F2xO0G0FIyYXbL6dduBNu5IMC8wkGQEqnSjGN0?=
 =?us-ascii?Q?Su6XUCK2Mu98oEjeThix8UkTK0RDZECiPl5IPt5fzdNNRtyjhsIC7bM0A0ye?=
 =?us-ascii?Q?BicCzM+pklmQ22bEL8db4EV7EEM3AP4hWL61y99qISq+vqX6rI/FToO6jA6x?=
 =?us-ascii?Q?mDt9PcmHHB9zUsYNZiw/qGm5pDsCspFGeHPEqx77PNi+DjTqJvM66rq0W8Hm?=
 =?us-ascii?Q?URs4ZtIkh+GNqNm+sEgBuJrVPQd3MX/YNNTZYZTA+6Jt0qu79eeqQXEHM7Pi?=
 =?us-ascii?Q?ZdiE2yZ4PWHgaPMChxs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0a9dfc-e3c6-4d0c-9ed9-08dceece3322
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:07:36.9772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zh17WjscpWg8wcOmJqnEJjqUZXpkQuH3Woy3/U3ePEBi/6KsH+WsmomaPpK0vtGR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015

On Thu, Oct 17, 2024 at 10:01:28AM -0700, Nicolin Chen wrote:
> On Thu, Oct 17, 2024 at 01:33:59PM -0300, Jason Gunthorpe wrote:
> 
> > > diff --git a/drivers/iommu/iommufd/viommu_api.c b/drivers/iommu/iommufd/viommu_api.c
> > > new file mode 100644
> > > index 000000000000..c1731f080d6b
> > > --- /dev/null
> > > +++ b/drivers/iommu/iommufd/viommu_api.c
> > 
> > Let's call this file driver.c to match CONFIG_IOMMUFD_DRIVER
> 
> Would this make its scope too large that it might feel odd to have
> the iova_bitmap.c in a separate file?

Think of it as the catchall ?

Jason

