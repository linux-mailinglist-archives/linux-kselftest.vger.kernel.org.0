Return-Path: <linux-kselftest+bounces-14876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A90B9496AB
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 19:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216F4281ED0
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03E456B81;
	Tue,  6 Aug 2024 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tJtdQQH4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D1E56B72;
	Tue,  6 Aug 2024 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965121; cv=fail; b=ORO+iU95vuvC5i9ERXqoyovwGPPzceMyV7BhOhTt9eO6BsZgkMxjp+3HzoE3SuisDc52xrSbQ6BbbIXHAuOW4S+Ql/kelcXVXcU39k1haymaAp/rr8b0F/zRQx6taLpprvqmTmshzfqYh3ZvbCgtddzYcv8Q2m6oeYq2RD6R6r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965121; c=relaxed/simple;
	bh=uYWMVTGDE1yyE19J+KxGX2jj0F88BYgnObMZ9g8/JUM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgOWbT4x6ZdwBlcTUvJsqMu/qq8YdIcx0CL4jD5pabw+m/q89l/PneyS4VzGTityRuCrPNwGb/LQd4Hh/j23Ui3j0zCnRd3Ge4ugzQ/JZFXfBVH0FF4D0bcwNMiWiPZ8/otBo/WxqO3NMwbSA9c+ZJRCq6cAiQ4JcKGaNLPhqhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tJtdQQH4; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xK3LoBZfKqJyDDxw29nEUdUKOvO9Zr51rSdLM6pxJvl5psv5i5nZDoNnqtdZZ1rmdImbBHen9/dwGFHx3wFAz14RHCpIo0XgZSjsy2Yb0dxngSXjpKwobK8RzBW/dRT3PY/ml1ER9KRjD2A0oNwzyfg4c4MXhowiZ40C2IA1pRxxH3BMz0g8nmec6MBxuklOEIIUCBMCtkOW1LjbqZuzYYy1M6Jrx+tMkuvz/5qbMf+u06ib+6BuUOk/fyUukvPvLaAfaALEIlupUREJCttzkt/hrE1xNYpHwijoP1Zfyvhkx74hc/l7SU4N+J1OOfSc4WeqmluwyZ3JSVaeTqOc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ht7NapxLSZwele9ljHxrwQojERnqME4T1bsrr1CnRmc=;
 b=JoTUU5MC78DyaXfakI8rqavUgAj/HEiEW5nAOEdp3aNpTAeBNSnL7v+Cz3wVmQoh7IhqWRZznC7UVmnW2M8id7rTIXeNn3sZW5QmOGSRoqvWgb1+9s7ycB0deLwJGAvtdzlc9XC9dS/QS2Az1zI+coawKr7YJYJ76QclNK9T+vQ7ZqIHn+tm2xNhBgMFjv62WSM422FiGaPxthTvFCpv86iBm82PYjW7dNXEeS30nnYnYMY8XIooUhFXlEpMbxFy6uEsuMlk5LJ4nI2sog0Cg8B2T2yEapH1G3bCy8xv8z1bX4iJiF+TeC8g1JdQlomWdqlIMKITlCleGhYw5rczQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht7NapxLSZwele9ljHxrwQojERnqME4T1bsrr1CnRmc=;
 b=tJtdQQH4dy0NUZmEzMrV0bYa9PMzIonAPxJVnRi3MkSPzhEobF81/vqbY/yXW0boo8VOdE0D/k7WhLHjuv1Jofc7DRreLOJs2xc2GeejfX/VkK8v9Emqvcwfx+le+H5aejNJBU/GHEVcN8PCwVNhqA1vfrBEa9gkK6zgV/31bWj3OuPFP2hoEYsk4H7Bf2+0m5xzChwgChiu6Ih3qrGThdWQzZKflkp+BYlaNlz1ES9yDDLrBymQfIz3ckFvg5fz2vJrAp3oFzkjWjawgCQSO65Ua9dotmBP2SKQ2xpsaH6qghOxVbELfSQYGs/pHsBPGiuYVVTfX6IDd9o5whS8WA==
Received: from BYAPR03CA0015.namprd03.prod.outlook.com (2603:10b6:a02:a8::28)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Tue, 6 Aug
 2024 17:25:12 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::6) by BYAPR03CA0015.outlook.office365.com
 (2603:10b6:a02:a8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Tue, 6 Aug 2024 17:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 17:25:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 10:24:55 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 10:24:54 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 10:24:53 -0700
Date: Tue, 6 Aug 2024 10:24:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "robin.murphy@arm.com" <robin.murphy@arm.com>, "Tian, Kevin"
	<kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iommu/dma: Support MSIs through nested domains
Message-ID: <ZrJcZLVHw1QrHRcN@Asurada-Nvidia>
References: <cover.1722644866.git.nicolinc@nvidia.com>
 <b1b8ff9c716f22f524be0313ad12e5c6d10f5bd4.1722644866.git.nicolinc@nvidia.com>
 <BN9PR11MB5276E59FBD67B1119B3E2A858CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276E59FBD67B1119B3E2A858CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|MW6PR12MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 4371e20c-6157-4177-f158-08dcb63cba34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YXRSKMCKF9f1WdgSAyonK09o0Nea2q49Zn913jyGTFgeF9Q6VQkjHqnq9tpA?=
 =?us-ascii?Q?qNeQ5LC2xEKpsifZJNCC3hPhFaqktLTzxTRd4QfR36vriYvvXwMBrvu3vMTp?=
 =?us-ascii?Q?WlYjINcsemzLI6xRqUF6aC7xuF+hb3HgpopJRAmORd9F5aCLkcBd22J7/S1i?=
 =?us-ascii?Q?bAj2yObHSwTjDDfp9k+RjFtrVhB82ISpXQyjwP8NjA8hlwrJfzSPm1G8FQIq?=
 =?us-ascii?Q?8wH6O8o5LYVZZm/7IM00foIReTjmsmHkeG3to5P15Rhz/ZJIzMW7kZEk2yjP?=
 =?us-ascii?Q?/fPtDeQxK9IZvg1cUbIa4b6PsNmfAntog80viVOZyxiBjv5SH7aQ8YKcfmNF?=
 =?us-ascii?Q?Dba8gANG83KR+u5NgBwJMbosQnCeuQ8cr4Pp5eMHwAiV04gMBFlwiwa5+1MU?=
 =?us-ascii?Q?H03sEgsVzbtKylGGpf7M359cwMVcZHBL+MprEvbMgJ4wvx8x7+CS3Di0Kghi?=
 =?us-ascii?Q?V7WVnqMAKJC1iokv1DewZI5MVuU7MCSoeajGeS1pEFpgynKFneuAsHzWttRG?=
 =?us-ascii?Q?JmzUkLbNptO9AyQn4TKaL2EctC349nHvTAH37fpn0BF+2BmC4KlWXmTlHeCn?=
 =?us-ascii?Q?1i7yfw37M0RYNJTO0CWK9jBaFdUKV2XXrru+7OUnARCoayo2F6vklbFlzN/E?=
 =?us-ascii?Q?CosCREUuL7SI9W9CswmU8g5yRQrlekdd2NugXjief2fXW4hNP0fdgaOy+8Sq?=
 =?us-ascii?Q?g1GD2q1uVatUN2zHuT2AKdNfQ5KDyOQJ9JwmH1/4r0lKbYxCivJ6hQlqhI3M?=
 =?us-ascii?Q?uytC8/YtPSHSAz8wwGCct2Ro/mMeFU3yIl5ClGDHYzmKMC4xOKyku0zcQIf5?=
 =?us-ascii?Q?bSjeROeCZ6GKyrNq3oTGtyESnCd/vAG0mWal3pkHmzBhRD3fZWkP2FapU2Up?=
 =?us-ascii?Q?wTAsYu4vuMGSfCIDNT8x/Zy3SGzQLfSctcPgkfb0uZ/SZ72987gTluX7qbEf?=
 =?us-ascii?Q?OYGnPfTlTfPhc4Kgdte572nSGtvM+Kn9T/jrOgNL0sLH6MQDnro3gF7hCHD6?=
 =?us-ascii?Q?EXywkTKxH14VSgSktjOkWRZ5t1TPcPtaRoENyVUpRrTcT4SPdohwrlIF4fZ4?=
 =?us-ascii?Q?FeL2Y3Aaf/hl3LMNZGHW4o8XnQRqoHBNGW7FhV4Se2tbBJKRpxzJuJq9VcO2?=
 =?us-ascii?Q?vIemNRJ85M+Cf0xlIQA8e4Q7ZK4s9lsCbw5WonnBjAAXoQV63YS+S5DXZ1P8?=
 =?us-ascii?Q?HJNiz+iWiTu5vqPM881YIj+G30vFIYCzuhWXaTRmqG87iQKWt0BMePu/nJDD?=
 =?us-ascii?Q?4JJ5fz13o0CA5S85EysWa8SrppZHvs5Phu7PnCaWnykY1Hkn+LAM26v/fOJw?=
 =?us-ascii?Q?Mrwa4cBTgHWPwXAH8F41ioqOCMukPoTDJ5qWmPn2/j7/5jMs3AzxHnfo6CC0?=
 =?us-ascii?Q?n1f2V43P3HbvpRAyOPyLPac+UBJCZT1mWfwild7IGfLWg0PrTM8DWwNU2DG+?=
 =?us-ascii?Q?ttqXhzZx+9l4TN7mQpnN7kHYIQHpbNeT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 17:25:11.7780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4371e20c-6157-4177-f158-08dcb63cba34
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736

On Tue, Aug 06, 2024 at 08:25:33AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, August 3, 2024 8:32 AM
> >
> > From: Robin Murphy <robin.murphy@arm.com>
> >
> > Currently, iommu-dma is the only place outside of IOMMUFD and drivers
> > which might need to be aware of the stage 2 domain encapsulated within
> > a nested domain. This would be in the legacy-VFIO-style case where we're
> 
> why is it a legacy-VFIO-style? We only support nested in IOMMUFD.

I think it's describing the RMR solution that was decided in
Eric's VFIO solution prior to we having IOMMUFD at all.

So long as Robin won't mind (hopefully), I can rephrase it:

Currently, iommu-dma is the only place outside of IOMMUFD and drivers
which might need to be aware of the stage 2 domain encapsulated within
a nested domain. This would be still the RMR solution where we're using
host-managed MSIs with an identity mapping at stage 1, where it is
the underlying stage 2 domain which owns an MSI cookie and holds the
corresponding dynamic mappings. Hook up the new op to resolve what we
need from a nested domain.

> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/dma-iommu.c | 18 ++++++++++++++++--
> >  include/linux/iommu.h     |  4 ++++
> >  2 files changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 7b1dfa0665df6..05e04934a5f81 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -1799,6 +1799,20 @@ static struct iommu_dma_msi_page
> > *iommu_dma_get_msi_page(struct device *dev,
> >       return NULL;
> >  }
> >
> > +/*
> > + * Nested domains may not have an MSI cookie or accept mappings, but
> > they may
> > + * be related to a domain which does, so we let them tell us what they need.
> > + */
> > +static struct iommu_domain
> > *iommu_dma_get_msi_mapping_domain(struct device *dev)
> > +{
> > +     struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> > +
> > +     if (domain && domain->type == IOMMU_DOMAIN_NESTED &&
> > +         domain->ops->get_msi_mapping_domain)
> 
> I'm not sure the core should restrict it to the NESTED type. Given
> there is a new domain ops any type restriction can be handled
> inside the callback. Anyway the driver should register the op
> for a domain only when there is a need.

I think we can do either way, given that the use case is very
particular for IOMMU_DOMAIN_NESTED. Otherwise, driver doesn't
need to be aware of the msi mapping domain at all that should
be just taken care of by dma-iommu. If the domain pointer had
a generic parent iommu pointer, the get_msi_mapping_domain op
could have been omitted too.

That being said, yea, likely we should check !!domain->ops at
least.

Thanks
Nicolin

