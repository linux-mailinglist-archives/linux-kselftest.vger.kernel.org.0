Return-Path: <linux-kselftest+bounces-26896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 116A6A3A67D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 19:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6B13B4975
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 18:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDFB1E51E9;
	Tue, 18 Feb 2025 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bjz0BsMi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397851E51E3;
	Tue, 18 Feb 2025 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904859; cv=fail; b=WlP+oO4rEyb5M7skdUtKIPbO45Jztp3c25bEcL7EaurxNxYgVziJaYRg9aCKOBdw1E+rekXWNg92Iv11TEYyht83pOAQF+Aw6Y8L7JByjB8pDajLjB+mHmqw3wiQwWYgW0UoFYGMeA8P9LrzY4I5xoLyeW8mH8laPfrBSliGeLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904859; c=relaxed/simple;
	bh=Q/qq8YaiM0ZB7ALnPyZs8AIZT8Hphbgvhg0OY5EzbHE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgN8ABveFm2WMtNLaWKSjH0yAjKlRMrvy9cbzDLfYCpdNaakp2hDKgKp4fB2UI+qSjQ1GY9Nrl+ni4w6rLrOj/qTkgslZPXt5AMzYvxHrV5NOrjoHBUq1ZpEL2IM0ZB9xIBYhX5JLYkVWX4aVxtofli7AMpEg1kz1PBNl7ebtlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bjz0BsMi; arc=fail smtp.client-ip=40.107.101.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wq0VY3UXbbGWfgMB3Uf99yTAiJCoZ6fLbl92kaOL1UYBth/pyZkqpu19IntpA/9PI3zGhBoe510+4aRfJ+OfiLW0kJQv/rh1UfmyHhDgQ6zrrfPDNdXeJQ+sdJTKr/Sf8GtgVeO/ky32rhrfohtBA4Yo2kzwN/hLNlZVBHRHlNXRw5kKLXJxeSg3KdeDp3NekMYG2hUI46FM25dM1FE0cTHNJ9O4ugl9DY/XX/dUhFrrT3YWm5VeccC4fFN8kcz36UQF5/O7ubSVhBVhjWPQyd7vLvK/o/03lFsQQFBnfrc8Vo9x5QH4dnzweg+7FXn1N4qDSiYcW2SLAPp1CnKf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vu8ly7rUYFy452p4af475UQ3tEs2ByV2EyauIXDfY7s=;
 b=qg0sc1DpiE8regW8M5AgicKYMgm15TQ7VOUSwN+Np89dKrSlN/PMK9/p4znpzXD9HgS/yqjGij1X9y4HtNeGQqcrgas87bysPunJu7HWxE+6FaQKyzgo+mSC33w1WeqVJ5Zd8b4Sr42DUMefp97rSIjG6I9P4mG74FM6mhzb+qZN9+Pr+Keb6eB2SOl/zZ8vem6e1hXFle9yHImvw2II6iMqbo+7OdKiQUUJOmnFbdvaz6dMIEzEcfhm5BMv//EcyMXkJDYxSTUVyMrOgVk5vGWVzd3t50t0378qn6QCfJCRHIQJNPKQ5AQrSWpPtvvlsSGnxAXjnU/XH3Gt1YWa6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vu8ly7rUYFy452p4af475UQ3tEs2ByV2EyauIXDfY7s=;
 b=bjz0BsMiYQdiYt9jhS+b0s8v2imCB6RQEMJ0utgkrpsrmP31A6taANuDLiEjkZxDFLTbKC6/nU7NFBkLf7BgV4dEenxDAdHhc9XSgFVrjeI+8AyhN5rfP8KtgOb664bsy2xB0994IO+zC3mGd6ZeMYGwWnLSgk31/PcjLd+nskN7cTV7iqRKT6ZdiINHeqEZZx0tpRvjT/pY/EXiPtzHsjE2eEV09MW4Eemg6dFb+ZlqYfOTgkqPBd7o039GYs4uWCfnh1Bh1J/O2rvzql/cSgqpNlBXg9n58xXonAYJqbVFxIVkMQb2BKQzmSZ4IYHMaMKdFaVKgQ0IFfMcTrQbuQ==
Received: from DS7PR03CA0077.namprd03.prod.outlook.com (2603:10b6:5:3bb::22)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Tue, 18 Feb
 2025 18:54:12 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::8f) by DS7PR03CA0077.outlook.office365.com
 (2603:10b6:5:3bb::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Tue,
 18 Feb 2025 18:54:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 18:54:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Feb
 2025 10:53:59 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Feb
 2025 10:53:58 -0800
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 18 Feb 2025 10:53:57 -0800
Date: Tue, 18 Feb 2025 10:53:55 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "mdf@kernel.org"
	<mdf@kernel.org>, "mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v6 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE
 for DoS mitigations
Message-ID: <Z7TXQ9EdyvHp/lmD@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <436ac2021bb3d75114ca0e45f25a6a8257489d3b.1737754129.git.nicolinc@nvidia.com>
 <BN9PR11MB5276291C74E2DF0C8821BE718CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Z7TOq-gIGPY_ztW7@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z7TOq-gIGPY_ztW7@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 73787e3b-96e7-4f27-a5c2-08dd504da27f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HKZnfCgIP6+iQlgFXN/1lHXO3vVgkAqng6TkHl73ilk+wQOxQpZ+i4w0NyGD?=
 =?us-ascii?Q?SU/aPLRCC1e4GtxUomfBoKr/aUQ5zLpYFQpsGt2emdbm6nk/cef27oJXqGM3?=
 =?us-ascii?Q?AQpyayQG2hrQQxVABX9ICKyUdzsamkuAYBahTBolnTb+tqdyoDsrCWLewce1?=
 =?us-ascii?Q?evFQgy2w67HZPRG0Tb7NVlGE760SwJt1Ohu3pjIiHwMIQp1TROcCY64djeRs?=
 =?us-ascii?Q?hiejP/+lEyEPOc/3bkYmtpoOjD+6nwiL+PUHATrdlqRiYScZmZIdtsZRCQQW?=
 =?us-ascii?Q?N1OFBepFSHCNLIqcP7WcQZc+Lym190kGUxKjEqeLqU0z0VLAQtSETnlny8Oh?=
 =?us-ascii?Q?MulS/7wRy2s9oWD5wwyg0w9ywnJzyO84rKhVZcYbasI/odFPFnlPqSPJOGx4?=
 =?us-ascii?Q?h7wty5HFnxTuMg+KYiM+yNHxYU5CJsslwAjWkGCdwAibSSVW8oRi51dOaUlv?=
 =?us-ascii?Q?Mcx7XuIu42Nko8G56NB1qwzeSxHUjSxrOOXSh9M5RLAr4L/OKRQT8v1M+Er6?=
 =?us-ascii?Q?nxMhn13qm1qTPYJLNDBBErR2TGjMuYd4RcNOALLTbrh0iRpR9WncMrd9CDxE?=
 =?us-ascii?Q?ak7EovdWugzLBOAT6rpiuCEiKgo7T5ZFGMhrjkgeS/Ze0h2epDsqYe66N1KF?=
 =?us-ascii?Q?9+cgZhQQzCl1Hru2l1jBtUgqj13ODPhkNHCfZcNJZR8IC5mLadrY0G2moYdl?=
 =?us-ascii?Q?rL8axIOie0h4XFiidVRge665ybv7VcgAZJJh2b6jPu3zUmWUilb7jbtdP6vW?=
 =?us-ascii?Q?ZkM3qXlEd8LVgUkEjMXP7hXoKMeUxTc+OZMjH50XJ0crkJBW0iB8vFjgX4fk?=
 =?us-ascii?Q?OxmiOn0sTwldKGsF2BFGmAe8mPMVgGUhztzE/wYmNZP6a2+HtMdQ85+x+qPh?=
 =?us-ascii?Q?7OKg2AwJiY7yhbX0zRi9g8ZqnXoNjn0nV0A3656fioWM3cpkN/lnZXdw86vI?=
 =?us-ascii?Q?pxYb6Ru6sgOSMhq9pHspYZY0rHJDcTI+BPiBblEChqOuwxxXNWubOO8vQUxM?=
 =?us-ascii?Q?BK/kg5IYfCW2earxepPrl4x4cZ87iN6oED7CCOSNCTx9b0bVZL0fKg6PAQqL?=
 =?us-ascii?Q?8R5jciynWkvbzTEG+TpP6lvPx/TWjkwQu9hNTwKvDdSrbFutzHVlTHfgGhHJ?=
 =?us-ascii?Q?kDA4mT4s7vhi/zPyod02JsOO2s8jyJB+amDomdjOdKB6dRIWIdtJrCo5wCab?=
 =?us-ascii?Q?eknUyoyMCPLuYsH5FJY3WPGGUvl+6kziFZXpfFb43jSTGxFc6kw8zzxeaPDm?=
 =?us-ascii?Q?c5ifYUmYTVCeZtEjjAxybpEZxrcGs4cy839S0L03vjaclTLBxlqESNQoELT+?=
 =?us-ascii?Q?18tW3EW40W6vaIT92cCGo/NHysn71c61JuU5dNlrNMrmJjE738OUzbbh0YO9?=
 =?us-ascii?Q?/8lvP5nZiHfcOEbqAGDVlegIm4FemvXN0Brze3j3NH59QOuSLYgv0O34Bn19?=
 =?us-ascii?Q?IlLpFoTWXoIAsGvm2Mj6fUKQpEd2NBL/6VYj+Jdtyq6BzTKenHpvTl6JaZkK?=
 =?us-ascii?Q?sQiTXnuma+T8IB4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 18:54:12.3581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73787e3b-96e7-4f27-a5c2-08dd504da27f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200

On Tue, Feb 18, 2025 at 06:17:15PM +0000, Pranjal Shrivastava wrote:
> On Tue, Feb 18, 2025 at 05:24:08AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Saturday, January 25, 2025 8:31 AM
> > > 
> > > There is a DoS concern on the shared hardware event queue among devices
> > > passed through to VMs, that too many translation failures that belong to
> > > VMs could overflow the shared hardware event queue if those VMs or their
> > > VMMs don't handle/recover the devices properly.
> > 
> > This statement is not specific to the nested configuration.
> > 
> > > 
> > > The MEV bit in the STE allows to configure the SMMU HW to merge similar
> > > event records, though there is no guarantee. Set it in a nested STE for
> > > DoS mitigations.
> > 
> > Is MEV available only in nested mode? Otherwise it perhaps makes
> > sense to turn it on in all configurations in IOMMUFD paths...
> 
> MEV is available at all times (if an implemented by the HW) and doesn't
> depend on the nested mode. As per the Arm SMMUv3 spec (section 3.5.5):
> 
> Events can be merged where all of the following conditions are upheld:
>  - The event types and all fields are identical, except fields explicitly
> indicated in section 7.3 Event records.
> 
>  - If present, the Stall field is 0. Stall fault records are not merged.
> 
> I'm not sure to what extent, but I think *trying* to merge similar event
> should reduce some chances of overflowing the hw eventq.
> 
> > Is MEV available only in nested mode? Otherwise it perhaps makes
> > sense to turn it on in all configurations in IOMMUFD paths...
> 
> I think the arm-smmu-v3's iommufd implementation only supports nested
> which could be the reason.

I guess what Kevin says is that non-nested STE should set the MEV
as well, e.g. BYPASS and ABORT, and perhaps stage-1-only case too
where the attaching domain = UNMANAGED.

Thanks
Nicolin

