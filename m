Return-Path: <linux-kselftest+bounces-27198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EFDA3FC2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 17:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BBB16C1F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 16:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E691FFC73;
	Fri, 21 Feb 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lr3WaKVc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA061F8AC5;
	Fri, 21 Feb 2025 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156541; cv=fail; b=g9H0e5fKK0+IdRAuvhjZ5lfRAyRw5vuwQojyFJnUOrBYlJZH60WxxgSONO3aZ5//fIBAv8jTZ17+pHCo6nB2bT0tc+AB6PJ43TM3aFo/evy0Z9zzsH4BCwUGuzItFGvx7FfRyxq4Zpr7kiamZIQ7GMoVVdfFtrd5+8DrjwCXtBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156541; c=relaxed/simple;
	bh=iXpRhh3cJzdit1YJWiUPDkvidChv95ylShRLuheKdmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bA5fzE9xHF4d2ehNXjLFewiUC1Nn0jHAv86tnK2m0IS/uaiECZ1uZACK1wQOEUjQN86/sQ06uVsgxoCn1TT6nxknMWwGaEWnpriWA5O09eHdGEuApx8VCrUXcaeO4Jja1lHPfZ1jZR2qGPKMdBwpFunC5XEKmf9Z8LPQ+zneJWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lr3WaKVc; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sv5pLbicY06RJlEcjYy8fD7Z3kFkaj/saMP2E3x8C3AmgXaqx1+N6lk6lzUYF50pDaU5G//j28BwNVzaWmbHF8MLL/MiGTwtjznpauFzR4LSl2L9PGTpE8Xi/L7DGQ+HitsnoXnopjs9EGctKRv+aDLxPj3AosxS9+gh5Bpo3VXfAQaN0mJUO3R7PMrmucAxKP+Jde8DlFyKI6QUGd2VSrG+G0paLaziAOq0/TWYlxLfb0D7pMNHNur/yFL8/ijDkyklsT8gM4KRghIXelRYrnpOjq8ezQU6/WnmfQhTQLhb7kOPjiRL3k3BK4m5dNkg4cVgYrffiYjxVSvAMhOWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXpRhh3cJzdit1YJWiUPDkvidChv95ylShRLuheKdmw=;
 b=AkAWIdsYf8fLP1/3HJHkVFcef0F6euvRIVBIAU9xz2+Dth7+hB/CGFgwvEtyo4w8G6M4HjsD0XFw+NrMIDlnHsdFPyZp7csOjlePwUEYEIHCacxoaMVZc4ppa2X4XvIy30sCMobxNa6ymrcOfTo3U2XUqXbNw/i31Yjo74tdrRbBb5kp1IXqCl+ElY8Iph+n9ypDUvZ21hbtSUfla/D/dGCo4zRMG/xpsfuoHUqGHV+3AL1yy+yezmG7t+RmulPPwjqfQle4O8fYH/E8GXBfaWklHFR/WvQXlsN599fgKZCQbsdk10tWYpZUYz0pKDdrtx0OWnU48TlkzQZwPF4hCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXpRhh3cJzdit1YJWiUPDkvidChv95ylShRLuheKdmw=;
 b=lr3WaKVcuHaCuh90sUbeT9+7AZ+J7rf7PpjLqn+jhDjV2tKyw5pKh/geJN4oTPCD94eXNcnHiWPborkyV7ZpWXHQ/tCdcyccfuorWVEJqcdTsAx89q3C3Evf+L9govFLooSeYTlF37ZS/Tcp1Tk6gLWnMCzr1QkoEg9fFjJHpIiQSwxRik8RG5jOPfZxaQn9+87wOtzEA83TtTjiT1EIgIaEsi3ltK78GLGNs7S+m7PMC87LpfUBKtMQ6Hd0h/KillQDnaEdAz3tevRo+bhvIKqShlDkjffJqFCEGbOGHL+YLrYPxGQPiBb24xJrOrA0LIXRkbLBejBqS92gRbKGxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Fri, 21 Feb
 2025 16:48:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 16:48:55 +0000
Date: Fri, 21 Feb 2025 12:48:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	tglx@linutronix.de, maz@kernel.org, joro@8bytes.org,
	will@kernel.org, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	baolu.lu@linux.intel.com, yi.l.liu@intel.com, yury.norov@gmail.com,
	jacob.pan@linux.microsoft.com, patches@lists.linux.dev
Subject: Re: [PATCH v2 7/7] iommu: Turn iova_cookie to dma-iommu private
 pointer
Message-ID: <20250221164854.GO50639@nvidia.com>
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <949e28875e01646feac5c4951b63723579d29b36.1740014950.git.nicolinc@nvidia.com>
 <20250221143959.GA272220@nvidia.com>
 <b9b4bfe3-9d2d-4009-b3d4-e179e8bccd9a@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9b4bfe3-9d2d-4009-b3d4-e179e8bccd9a@arm.com>
X-ClientProxiedBy: BN9PR03CA0431.namprd03.prod.outlook.com
 (2603:10b6:408:113::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c06b000-ae71-465c-5513-08dd5297a12f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iPrNyVV5kGfkxi79KZCPJtvtsv4EEY0dav5orTkI4WG5A+Hp1s4rJ9r7eWjL?=
 =?us-ascii?Q?eCXCZigvt55pVENM70roWwdLMbXAdgwKM6teV9O0Y/qgM1adqEwTwwWGaFEb?=
 =?us-ascii?Q?FKRkZT1JJ0jtYTpp1qPqoAG93+B/xOHzioh8HcY6k/FWEdwR2pTZXJGBgSL2?=
 =?us-ascii?Q?l51GRFcvtvDBfdJdxgexuQ+OE2owEBszGextC5FJgQ/j7yPvSMjKq9WKp5+O?=
 =?us-ascii?Q?i36EzHl6K7ns8n5dibQDj/xCodwh6cjvvcULap8iEd6CNFas6qiXSbsbU/ky?=
 =?us-ascii?Q?2LUNASZgykZ0e3je1dDwtQBJM7CuzelCiP6NO/vUogon7vGPcqRd5YupHyGD?=
 =?us-ascii?Q?7BCNIDAoCUx0eF7gndawoO3dxuIvHeGnvTk+wFAqHChTJQNxkOy3wmmCV+VC?=
 =?us-ascii?Q?TizsX5IjhHXGyMFRK2G4R3qWUyvc4SbTh9mkuQfPy8r25uG+mNS/PUnyf3jp?=
 =?us-ascii?Q?HbnXSJj7HRioa7WGWJWUVJwhWrn7VAQcsc2Kz8cXIls9mIkCM+Uunt/dNSUQ?=
 =?us-ascii?Q?WyKjDPedNh0OcX1EAkk93TXqnxLu2IlY+WG3d4LNi8g3nPJSdlJF9EAbGlAL?=
 =?us-ascii?Q?XlWbiuNf6hcIxueWsmXb7XPU3eY6RB3LzQRaw380SWoRTgTlECoUqN8elXyQ?=
 =?us-ascii?Q?lr99eAHboQ5qxw+Y52eLlXIO1i8/4Hf1cawqY5CncSwTGYSyUJ+VtlJw1nfi?=
 =?us-ascii?Q?sznpSgZUPDq+szAcBaOtfwQlhc+fFxTn+ajK98NdUQZC8kepfF17RGQNOYlq?=
 =?us-ascii?Q?ZqLoAwkSa4VRkG+QB/yfU2kiKoMpISWRbTBzKJVu6fWxoQknf0ku9jgjFU/l?=
 =?us-ascii?Q?6WTM9zLyzd1q/sjFevOr4x8Es2Z7ryE7B8XlisMyWpu3SWRUqAbIw17Sl0H/?=
 =?us-ascii?Q?DyNO1WqubiIIwLvsaQ1yfDN0+qvJ/Yql3Ef+MxgN1JzjSLbCeMpcvr4nMPCS?=
 =?us-ascii?Q?dcnvNqRa0umNGkn9ltj9DpVvZj5q9DcfK2OjmmSEjoG0jsEhUf4mLe0Ac+rF?=
 =?us-ascii?Q?2i8n1NEIpABR21F4mrB6/c8brfg+hMunoa3fqpAczrVMUHah8BqPoSRgRZsZ?=
 =?us-ascii?Q?hDv3cWXIrYj2oaOnNcq1knaId52jFfkYTBY9LNCaEjicdMAGcSUWxvRU+ceu?=
 =?us-ascii?Q?C7IRbGWEbpha80Y/w0mID0Bg8t2BcDUhDYVczOP2iqRE/XS3xzfwrcGfxru9?=
 =?us-ascii?Q?Otw/z3trIwJmjz6Tik6if0Q2m/MtZY6yDZXqJe4EQSf8tGKu/88ADU+2dTQr?=
 =?us-ascii?Q?KdytJmIWCM1yAKbwSJwOtR7CvrU/SKkdbTlZWU0HhyfWTKqhu9Qx2PHjijFN?=
 =?us-ascii?Q?RIqEIgv38BbntLzlp2zy3ECvHo9tWsXErf2ZF0YxlIy7ICj1g5cLOqeXaNmk?=
 =?us-ascii?Q?ceDt+552cSu5XzXZlZqse1n46RQf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M0hMaK6tgedzNx4GzQ4cuZCg1osY6Go1BxcDEwxqtVDyUXSvr/ieVRo36yJk?=
 =?us-ascii?Q?UoPhpo2g/saaSidV/ngRek+1ZELh23+TdFmStDLabLWl1I/wOaXfujX+eTvG?=
 =?us-ascii?Q?ND3DfHkxPY1jpHeaP43b8PY/cW4eydzbqjhPg2epZDWz4gS48RvZWvUczb+i?=
 =?us-ascii?Q?+mEVykC5InXMX87K3sx/dbMOLv0FEpzjEpQMlKpjh7GwubZEkSbdDFnerVzj?=
 =?us-ascii?Q?GrW2gbIwkQopzPmgZi85z1jaCDUQR4u9E4ulpKXUi4ArLrPp6tN3JEiutxuI?=
 =?us-ascii?Q?VO5NbcD6RPxDwc+6/TB0oCGmwg7Yv5QmtsmGCZoLWrWBI9Ny6i48nvsMq+IW?=
 =?us-ascii?Q?tj1UCSXaJmCAm6ERGU8vjpJSqsn4mI4VabwFPplyA8zX29fAFEjm0yFc7RK9?=
 =?us-ascii?Q?WCVlnIZygGI/oX+ztOqFs5Kf8Otyfz1A58tUjcV1tHMw3uUkefnrquatYacM?=
 =?us-ascii?Q?/jOIkrDhXBhDd0wOYiZ8PjSBlEob0ENv/OOfOtBj7+azLG3sh0ROgjX1mPUU?=
 =?us-ascii?Q?FWCJ5ZO0+4cX7Xr7OEM0Ml1avvMziQG1U0uqiWu9NxPeKOJio3P3ldj0X81D?=
 =?us-ascii?Q?GTnfkyGpu8IgTAaCgjoXqcFrJbhsI8/iHNPQpHMBSWpTTHH8nAPpdNZYTTA7?=
 =?us-ascii?Q?O7AtiFg8YNmfKA5Nn0qZ6Y/KcFb4YZMlgrwhIwuvnqsGcn7esRHW/LR9SYcI?=
 =?us-ascii?Q?Jde8fZtlmrPpKaoZl0e/x6SIePOMXa7THOTMK4UFrws5BcL90YKcRkIDd0Dp?=
 =?us-ascii?Q?wnsxDYhf80yNaIL4hCjh7MhlSdWneJ1X87whT3PgWQ8bN6t8xYNYZ9YqKRR3?=
 =?us-ascii?Q?vVItkjL6JHDiOriGZr8VKl+BSsDHLc6HSX5hvZjskiqPueaovkOspi7tpTK7?=
 =?us-ascii?Q?2FSocO9GdbET83zbfJhkSfM3ssYX9wpsXMMX8YbYG9ahxkOIkLXr5LAr8nT1?=
 =?us-ascii?Q?NHel3S1EqtealrlHQ6dA8ArMUrKgPhpqmLcaUO7BIZo+HMCeukJS0gUvFa3x?=
 =?us-ascii?Q?fmW9us/CCSE8v8x1MLOg1jOLmcggYTZ6cYX+VmMHUqAlZbcKH3iekVqGC+4U?=
 =?us-ascii?Q?8UVE5QMuwkj4t4vQ9iFy4Xtq12JU5gmdwY578ilOBIjr3/G/zXypbar6Yrd1?=
 =?us-ascii?Q?Gyo9C54+2a60zRVC6QQaqF9RAWWsp7ihpvtCbpfQQYxyoDwhq9QoGNCDAOBq?=
 =?us-ascii?Q?+HKrRwhSH08caUJdQw/SRQPcsSe3vaHGnVZ0FdliGJXZOvIEKFTVddvyWKql?=
 =?us-ascii?Q?4AOn1tzRhx8fKiJKYv0+xT3gbdsaPhHbteOHNdh2eRXv9qUk7aeGQgKtGNYq?=
 =?us-ascii?Q?2DDTLNZW0Z/2rWiHEsgwYRFPK2gwdlSY52FScz+qTxk0XN1dq98Nv6uE4bcw?=
 =?us-ascii?Q?CdzvI0SU9YGCngpw8kHbCprLJm5KkUM9s4PwDMmLmgkxtYYMr8t5NzPi92CR?=
 =?us-ascii?Q?RMhq7mBmnGr21NRE3wBw0Z0mMBaRPBuw4e9IMVD9cbVxd4mLw3ZLI2II8/DN?=
 =?us-ascii?Q?oSpH+79rBGPOyujD7/gVYi4pEg394ZTMcucsFTNVFGw86EnBg/Izf9L0uIDN?=
 =?us-ascii?Q?A1iJXDOzR68I4Y4hT2p1Ooz16YauNmFo8gMcs9cJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c06b000-ae71-465c-5513-08dd5297a12f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:48:55.6229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 979+qsKBR22ECOA0hvYemiGlqtfV1nNtPQXq5lYlqmQG+NFBRpRMqejCv7IoLKvq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418

On Fri, Feb 21, 2025 at 03:23:22PM +0000, Robin Murphy wrote:
> Eww... What's the issue with just checking the domain type in
> iommu_put_dma_cookie()? Is is that IOMMUFD and VFIO type 1 are both doing
> their own different thing with IOMMU_DOMAIN_UNMANAGED?

Yes

> In general it seems like a bad smell to have a union in a structure with not
> enough information within that structire itself to know which union member
> is valid... :/

The concept is the opaque pointer belongs only to the caller that
allocated and owns the domain. The core iommu code should never look
at it or touch it.

The problem is with the mandatory call to dma-iommu in the free path -
dma-iommu code should never be invoked outside of VFIO and the default
domain cases.

So the little rework I sketched makes it into the caller knowing if
dma-iommu is operating that domain and then only does it call the
dma-iommu related functions, and the core code never touches the union
content.

Jason

