Return-Path: <linux-kselftest+bounces-35534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F3EAE276C
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 06:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4EA3A8391
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 04:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC72B5258;
	Sat, 21 Jun 2025 04:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kjtM902p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6402D146588;
	Sat, 21 Jun 2025 04:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750481513; cv=fail; b=FjRh5Xu0933eaXAhAnVzxg201aUdfBK0Ta/VlD8BhdmrcLqOkU9T8sjCfJPUzceeVwxhCWdcuKK61q8B78Dnjf1rEfWNFW5seB5hkpTOWpUC9QfclxVmUkVbUbsZwnpZWEzF3duStoQmPt9aQdsUYlHTORyZ0SVGZkr5r/hgsvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750481513; c=relaxed/simple;
	bh=FlBmEJs+oTovkMaPWjSbI0Y1xNJ8vYD4R9+uSZd2ATo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dr60h6yZHyLYjv1PNWVRz2q3MILmCrLJOnIJaGhPRuit6jK4ezojaBnzV6qD0EeYysCXjvP785OKwHbfi8wwVbYCJyj9G3Mn3r4tfUgugO3FFKpkafswjURoH0eNSS92fkt+6Tk3ArMxqsN9p/aTpnVwgvMsKGAjBD7E6yghEjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kjtM902p; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMEqoeeb9B831ISorOol1WGq8K4ESDIIdkfRNx++QZET2MVrTdXQtwnu2kmKfAqTjD/z1ghdjHz7R2biwikAs7yyhM3MWRCLyWJJmTuDbcu5BtfqG8rHjo058G7UJa85Fp4SF20PoxbOZ3Qg0LxHrLWNUOwvOk5qHdFJ2FDG5L5HCbrUV8FnwsLYQViBqwiEKkVdMdA6+nzrgwzTI5C33j+PPQ3467+M2akOaQCdX0So53mOOeIjZjgYelGLWaYAPoKkqpiepKzWLl5NeRhbVvc9EJDCWJCwm42VyLt/17nojpIEYs7JA8p85YIRuFQ1x8PQc+yB2R6vFUW7/ZOZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBdlixYsvOcxHZFW6ofTe3G3GBiHaRdt10Hz1nuS61M=;
 b=BPEjYt8fsKx/bKDjMphXlVtZQLecE5StMZ1p9K6GxaYz7HK1DHI2gn6dUvlfivjlnlU5B5UIwz2A++CNpXPihkeGW8QLJErZ1nSYBOPjLcqRl2n5akRPHRiu/EFiuVmh/hxVHfylzmWGgyR+1/+/Dit9my4DkLsBhMmUrJkIm9QRdAn6+15u+Dlp+UOJ7heN0bOlnZ6JLV9ql7blYNXazVTtQ/P8Y5lo8UmT4un440u/NR7+rWXz2rD/YLZD0p/vBuYckkeXbfX30bSJuvFxQr7zdbyT0TUMlttcwDEXyOWO9+p1S+PyYJkWkQiWdeGs1pP47CqjfmubkXCzE1o0AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBdlixYsvOcxHZFW6ofTe3G3GBiHaRdt10Hz1nuS61M=;
 b=kjtM902pAIPSCXuZJ4KfCxUYUdGT1hFo4UsDiDoAiJQO72fiFKmUstB/pjXXwmKd1zeOGwouqLEwQGJqb0lJIw7A+sPO+rHuX0IQ30d5Vdr+nIWqdiRujQbkaDiAnZn9nL8ZwnOe0Ha/ib4Df2sSMori0LbCuFWZK5qECbbW3qg2cWaEa7V/UafX0lQ8BPjd2GAxBbo0MICTdgtnuCtFqlGwgDaAf2kR06Oj1CWKdJp7/XWueRcnDBUgBiUQdgHsAW9J6GroP816RtYQMz+ZPiYXmwBVIrivQSUabPvpa4BZhnH8TTkQFPUFYHy/N1WxDlt+lzatOA/RX6y6BJxJnA==
Received: from MW2PR16CA0069.namprd16.prod.outlook.com (2603:10b6:907:1::46)
 by CH1PPF2EB7CF87B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Sat, 21 Jun
 2025 04:51:48 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:907:1:cafe::5e) by MW2PR16CA0069.outlook.office365.com
 (2603:10b6:907:1::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Sat,
 21 Jun 2025 04:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Sat, 21 Jun 2025 04:51:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 20 Jun
 2025 21:51:46 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 20 Jun
 2025 21:51:46 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 20 Jun 2025 21:51:39 -0700
Date: Fri, 20 Jun 2025 21:51:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Pranjal Shrivastava <praan@google.com>, <kevin.tian@intel.com>,
	<corbet@lwn.net>, <will@kernel.org>, <bagasdotme@gmail.com>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<jsnitsel@redhat.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <mshavit@google.com>, <zhangzekun11@huawei.com>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<patches@lists.linux.dev>, <mochs@nvidia.com>, <alok.a.tiwari@oracle.com>,
	<vasant.hegde@amd.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 08/25] iommufd/viommu: Add driver-defined vDEVICE
 support
Message-ID: <aFY6WZAxeFTweA7h@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <937d515032be07af36c06a4adb662ee2f7693c75.1749884998.git.nicolinc@nvidia.com>
 <aFPl1LD8r3Du-Far@google.com>
 <20250619114425.GB1643312@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250619114425.GB1643312@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|CH1PPF2EB7CF87B:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a24bf0-b0bc-4e0c-fe85-08ddb07f5463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gorHbAfQc/BorjlhfqE0doyh+hIS22CU7Z24lvN3xv9Ph7arNi7d9KLuXaQ7?=
 =?us-ascii?Q?3m+Fi/qp8Wwpd/INRvnKNq7xzWydOAASaP0sBv5w54xLqIk6lSGDB/ShitCn?=
 =?us-ascii?Q?jaRA3LBhAq5XtVHqSKDwEaK2UWCVbBDfKpKKaM1DVG0OvtLUvS2/lwGKdtaG?=
 =?us-ascii?Q?SmvYGhw675f37o+6GDcU1bn/WuO0rqGdvUBccpDDMXh7zG9uTHzpNQtSFczd?=
 =?us-ascii?Q?L5vYXHkI4lv8XZU6TXwhgBXBTxq9qNzDExbBnwIPz6afjHl2NLandR9sWmLi?=
 =?us-ascii?Q?J9Z+GUAhjJuJNwDImUmLlABpPxJGjqxEEiMX/bnqlUbvuMUww9U1LogH9jq7?=
 =?us-ascii?Q?iIQL/leFUT4ASbFxjtPsqLChq7SRmLVoIwpFGs6DChPxtyhyhNpGOvk8OEPc?=
 =?us-ascii?Q?363p8ti9HlIB5E9753zw+lj1kmevqIL4ERgc/7X04P7wjNdrOl6yjjnmlV7t?=
 =?us-ascii?Q?f0qSg5AEreZ7pYc9PxIlWHQAFwErwFSIwLUSymtHL92/23yIQNFu5WNx9j7s?=
 =?us-ascii?Q?3qlSXV2zbgNtimFao4Qx4NiSP/UbjJwomA7zLL/yCNI9xfnY0I2L30H3/3yl?=
 =?us-ascii?Q?IafbQo469Jgw0Sxx3q5COw01pKMAQG1lGqeuc7uk2DEw8kQa6ZYB964snEUu?=
 =?us-ascii?Q?LNldJaCEjA09gsTz1czmDT6KRMIgWmmj4ilMjHoaze+GiLQOdBepk9SpOWpC?=
 =?us-ascii?Q?qaxV6TGHH8HE4ZjEgA1/cFVgYRgm0QulqbBwkq8nyf+SWr5t2y27WYzTPN00?=
 =?us-ascii?Q?qOpp2mQBGBf4QtigrISkCZCKFIoMoqsnY29kJJth1pIo4bY5fOpWpZzxHSS2?=
 =?us-ascii?Q?I0FVBH+ySRVjHzg4wI1B7wsdiMnA/Fkgsf0MgajvMzUC6svTBre8JsU2rAyZ?=
 =?us-ascii?Q?iSnbu/crovFaRSsPd3z8pvOcwYKZsDBLl9OuPyaIYuHclbEceZmmiFqf3vDw?=
 =?us-ascii?Q?Y1ze2IkM/CBGItUwmYQAKCWMMgnZ1512A4biUxORWRAJ23Mnz3BQK6DW8EVg?=
 =?us-ascii?Q?Zb45tW2M4cG/r1cmIrVokkdpmHx0Y2twtUONyUAHhNjk01rM2T65icCESf1d?=
 =?us-ascii?Q?GkcAIfuQscEHTT4zcV7D8YhaQ409ojyfQCqi4oJ20wg78Gx/OPBeFvrxU4ZH?=
 =?us-ascii?Q?7gEyyRFKvJ2try5DLFeKcSyNh3S00Cr4G5vuG+YQBvwidHsf69OWqSFnOOW6?=
 =?us-ascii?Q?BEd/XhDewwl5EalljXs+zENdpvAHz5ecLc7/+ysn4lWGSHhLvYgpU6gvGRdF?=
 =?us-ascii?Q?Jo9SSydWEzWQc/4skbFHNMk+DenDtrjULmwbTv9DYdKYcjcNCKAYpx9XLJ/l?=
 =?us-ascii?Q?BnN6oSVQDSFSG08IzeeTO3iKLCeHUq0RKqs1P1DzresJ/VcfmJ1XMwPf1zu3?=
 =?us-ascii?Q?HgAlfq/CSNpxppAxtB8WJf9ESf9olBIIOV7/+ENbIIHTDT45Q3IhbDjdONcx?=
 =?us-ascii?Q?1Y6GTzvEDont4Zi10DdJ+oF2VhEazgTTB9hHkXJas01EC5oj5NiLXPomepKd?=
 =?us-ascii?Q?BJiV3ASyfUq/0XmaAqElpySJY5zC01bZjc5S?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 04:51:47.8931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a24bf0-b0bc-4e0c-fe85-08ddb07f5463
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2EB7CF87B

On Thu, Jun 19, 2025 at 08:44:25AM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 19, 2025 at 10:26:28AM +0000, Pranjal Shrivastava wrote:
> > > +struct iommufd_vdevice {
> > > +	struct iommufd_object obj;
> > > +	struct iommufd_viommu *viommu;
> > > +	struct device *dev;
> > > +	u64 id; /* per-vIOMMU virtual ID */
> > 
> > Nit: Why not call this viommu_id?
> 
> And lets have a comment here too, we have so many different ids, what
> id is this id and what it is used for, by who.

Sure. Will change to "virt_id" and add some description here.

Thanks
Nicolin

