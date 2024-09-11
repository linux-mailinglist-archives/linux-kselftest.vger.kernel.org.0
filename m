Return-Path: <linux-kselftest+bounces-17722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B80974BC5
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 09:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92FB01F25111
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 07:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF6D13CFA1;
	Wed, 11 Sep 2024 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZmIMYQGA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0B56F2F4;
	Wed, 11 Sep 2024 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040878; cv=fail; b=rCLvCLYLaanZQ67q7QvUhzjLfUpe4uNKCWJCiGut9liRahhP06sbMdt/43ELkVatFIGV7ykebpdk21wgLUuqISQN7Ya1VAgKL2B0Fme8kT+P8DPAPGGEVz1VoOw6Pg75q+yIgNulaEoo5ZZYgoS4XKtBbAUaXVaXg1ALuDMhZaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040878; c=relaxed/simple;
	bh=ySR7HgTRHl+qL2de5Px1hTrwDDXdyxxNqb9PS06vk50=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLJDxE7xKx2ck//IBPohhvjlnzGcCa/ffTTXis3njmEHTuX1krYbqA0Su52Ds0Qnt/73k+YOBfX9KbjhmRfvdOzS9wJ8STSaPjMw8YytqX8KxsVx4QBoMmkTPrif55/K1ZUPT1Bktq/fUB0sSriEpok8Zec9UD6+J+ipHIdRumY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZmIMYQGA; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7i7CHwKx9nrDcz71SYSsD76/QzJsbOkA4Xx1XA94eq6Ot9MXJe6/lv/6jL6CV6En0a7HBPND+wBBag+1yJ/slR8CJIUHq2zxEzMCLsYV0aulkImwq35sHoaKLpW/rf06AiL4P5S4Ss/DnRs1/T+Ui6P1pxfXG4t65WcO7jrmhSTj5bO08sEls6m+D1p/iFWps24Jult9A0LtwU8V/kpbxsUnZVwHXpdJHmzUNj95dhtVReIzRfc80PW99Jc23AN788XyvTUo4exlQMBp2hL8IrUah3YxMBQ8ATQIGYcahLjjzFf1/Ed2OSeGLGD4/MaNXlPT/ysNwg3YnuO0O+QkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv8Gkse/3O71/sx1dqA5C4DS5NQwn3TcbR9Aiso8CzQ=;
 b=y2AimjYHBwpS/xkVvMRGDKmcPvw9I6fmV/DFRgeVLuKFaxSyNNcZmf8M4iVy91DaWhyxsB/br49yV327d/Dq7qHb38ULn4jwdAQXen3RATHCZbbQO/Gy9mGsRBVIPLCU1Wh5JthpvuNFqmztYy8QPPCO1Wt262urTFevxWEhAo0eLZ3957+bXVjFwBfJpzIs1jmvl8kx53YYE1gMCwdxoQduHuOfdpCzu3AZt0IjAuulivliSO3zmgy1BQjJzoU/7AdJdC6aI2bTi1G1G62IHCtjjuLWDi0vBAV2Uo2aee/Dlh/6xQ5wFxblmKYkrdFCxVVUuOki31mEuXnhNWQX2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv8Gkse/3O71/sx1dqA5C4DS5NQwn3TcbR9Aiso8CzQ=;
 b=ZmIMYQGAfrzQjZcfKuDx93tQH/zAbBNzHv5wF8CQ2Z7swNa111TShiGQ2Y5bij4fe4VPSFuNcYcFSauXX687yThtkJ78WcqU7Y14k4UwOmA6a/liiGhH/nN3DUGIqASB7qwQ6dsgHe8h7QnzPcy07eGy6wTy+VFuh9WwgSRaPm9jNRSVZ48p042MvuT+R5bf7oGw4QANwZBvmcCQrQOkDeS5GsbcARqmGrFkzOAi5nPwQCyUAL5fuQyqnWlD69/ncFvzNE3sTj4+4ViWULL8Eh/f94PUcoNp1F43oecYcP9lzmMjD1uXpgbpwfnX9TqfbBmneYj98L/awM9FW/qx8A==
Received: from CH5P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::21)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 11 Sep
 2024 07:47:52 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::a3) by CH5P220CA0003.outlook.office365.com
 (2603:10b6:610:1ef::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 07:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 07:47:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 00:47:40 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 11 Sep 2024 00:47:39 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Sep 2024 00:47:33 -0700
Date: Wed, 11 Sep 2024 00:47:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <ZuFLE8rgVuB+OdXP@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <20240905160353.GP1358970@nvidia.com>
 <ZtnsaWgeuuy7+cJG@nvidia.com>
 <20240905174326.GW1358970@nvidia.com>
 <ZtoRLlk3hLlP1c9Y@nvidia.com>
 <BL1PR11MB527144A489C069EAB8FB99578C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZuFCtKoE/xbf6i4y@nvidia.com>
 <BN9PR11MB5276EFD18580E4ED3009BB478C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EFD18580E4ED3009BB478C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de26e96-ac91-4835-3f18-08dcd2360a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QNZqwWb84en0ZXtrfZaVp3llU1KCFdSqpd2sR9o8EwdFT8K7gk+WOTBI0c0n?=
 =?us-ascii?Q?Z4R4KMwJhpuHSDvGRY7srZLFuDCT7F5r0jfGTzjM6EME9KctLnxS1eEoaLHo?=
 =?us-ascii?Q?rwRsRd/QSQHYp+VLgiUfgCTKquhfua8ASd/q23ibVrhwujqFE33BnELBta2s?=
 =?us-ascii?Q?dzNRgmZhOlWS1elR5bcwBuhJ3TGVx5Nmnc0H2W9lttx42nb2+HCoF2W4L+D2?=
 =?us-ascii?Q?5+ALK4yvl0ZHupEnVDwPeGeYHUCbqfYlFjcRe3niDr+xQsi+yKEHXti5Mjt0?=
 =?us-ascii?Q?fwulKu27id+4DzkldALa62tkWYKehoRPeEY+CWTPeI4SYNTtFMgGCWphwgTY?=
 =?us-ascii?Q?Bls3SjLS9yL27gQecIjQ6M8KFwbML4jhHZHwZaSed7TYFIH4vZeIBz7u2cCw?=
 =?us-ascii?Q?oqZpjND5WZQFDSq9rpldsRVL1R74tsV5NPbsn2uihGWvTzK9BCufGqAPiNoF?=
 =?us-ascii?Q?smdioX/b9jSw/sa1d2PVL7C1QlPCemjvoiSrv0MCpZtpV58ACvCzY2NxxwPm?=
 =?us-ascii?Q?Kfu8E2V+yr19PsEQCAT7k6J5w13PW1m9M1z8fLlC39/FPz4oXQh84jh9C+fs?=
 =?us-ascii?Q?+CVjfxmJNaAbJ3s4780iFwW05VYmMoAJOBjBkfes/p85D6VmQJUh3TLZJJmE?=
 =?us-ascii?Q?QBQhHX+rQqsOxHB0DMt1khYr1ozX2stM6q8CG9wiTKTvOY7yQHz3O0H8WGyF?=
 =?us-ascii?Q?ozI2NQ5ai1E7QA3YaMmGA1nDXnMdYq4wEQDFTLEQ2yGVru/QTGyRtPx5R15P?=
 =?us-ascii?Q?BYL0KqFy6MFXihFzVimdv9Z++ntAkDUFghIzAkb8lWcHGXBdGn41XjNYh13z?=
 =?us-ascii?Q?eRmEjac7cfwrPx3966qlWtEMfop++4C3+4MzTrAnZeUhjOyiBqmkrAk8r3U0?=
 =?us-ascii?Q?949xocJox4wOcX5R/gwHtLPzZj+4CBJAsTPmWMT1GShEpJS1Z+zJzcEYaBE3?=
 =?us-ascii?Q?MCLJwhXZ1jye7QP10jRD7xOGXhC+EvXj4Ejdofu4rGXwJryjjBdI/HMhQhcD?=
 =?us-ascii?Q?zghD1I1ded3VqKnatBvIp2bsXY061dxy8RsO2DnX/ZArYITka6beVHSFc0IC?=
 =?us-ascii?Q?txegU0dlCZRfOiVO4ExzGrdb2L4RhUpGlV1avRYGNKDZeWSvwsgo5RN5NgIU?=
 =?us-ascii?Q?CdiPPXhmtz1SmgmOXxJC+WLNmQ3IEaBVqlL1cY7Ab7jgfcXKXqHAffnsIGYV?=
 =?us-ascii?Q?QADP05wBbdkt9rHkM4K3Aoc4itUQ3FfGh35DUUoTeJ87LitKRCK3/ua+vyqq?=
 =?us-ascii?Q?hukcckXMZxCd5Hu+Dfi2ItjnAEA5VNHN67rNOCd1tfNFEQVbqbFW/5V62lr3?=
 =?us-ascii?Q?YT1YcJZH2kcxDYVjgbdf89FE4u+GRNu549FLwM109kbEq6eETeh6AVAfecFY?=
 =?us-ascii?Q?NumvSJyb9GK8KC7T+fnM3EGGBDQyN2RpuZWsljjVRb0mgYGA7UJd3aK+TZoi?=
 =?us-ascii?Q?I+BM0+S1PSM5gg8cbh68kwzSgejuwpxA?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 07:47:52.4277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de26e96-ac91-4835-3f18-08dcd2360a7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088

On Wed, Sep 11, 2024 at 07:18:52AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, September 11, 2024 3:12 PM
> >
> > On Wed, Sep 11, 2024 at 06:19:10AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Friday, September 6, 2024 4:15 AM
> > > >
> > > > On Thu, Sep 05, 2024 at 02:43:26PM -0300, Jason Gunthorpe wrote:
> > > > > On Thu, Sep 05, 2024 at 10:37:45AM -0700, Nicolin Chen wrote:
> > > > > > That being said, if we have a clear picture that in the long term
> > > > > > we would extend it to hold more information, I think it could be
> > > > > > a smart move.
> > > > > >
> > > > > > Perhaps virtual device can have its own "attach" to vIOMMU? Or
> > > > > > would you still prefer attaching via proxy hwpt_nested?
> > > > >
> > > > > I was thinking just creating it against a vIOMMU is an effective
> > > > > "attach" and the virtual device is permanently tied to the vIOMMU at
> > > > > creation time.
> > > >
> > > > Ah, right! The create is per-viommu, so it's being attached.
> > > >
> > >
> > > presumably we also need check compatibility between the idev
> > > which the virtual device is created against and the stage-2 pgtable,
> > > as a normal attach required?
> >
> > If that's required, it can be a part of "create virtual device",
> > where idev and viommu (holding s2 hwpt) would be all available?
> >
> 
> yes

Oh, I misread your question actually. I think it's about a matching
validation between dev->iommu->iommu_dev and vIOMMU->iommu_dev.

Thanks
Nicolin

