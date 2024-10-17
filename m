Return-Path: <linux-kselftest+bounces-20028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6669A2C91
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C84C1F22A9F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C49219492;
	Thu, 17 Oct 2024 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JimVA9g2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5A81D86E4;
	Thu, 17 Oct 2024 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191067; cv=fail; b=qWvqQQHk8ucEH3Qr8DY84zvFDIsOn+UnH8P/qPRSiMN+1YlTCG+rDjqpQnBsa1bB0v6fb6AGO4fGciYyp1j0Dp4UXgwkYtw4VHQa1yxtSKb1pIBqFM2Qv3IMdzcxjr4BUd3G7rV9xhDQUrNIzYxA7AjkeJ64wK8dAH3a3SFEsDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191067; c=relaxed/simple;
	bh=keQjzrHXXDim7r+GFqlfaSXNceuZpUItPHBLCZV00rY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elvx4mLH0PNZoFoOpcI243pCQOI8zTVljJJlDrTHGZs8XgiGA0tTsWmsz8iDC1h2so/UqHcAkQys6JRmbz2V1PVw3+r+cT+dj0M/kScboB0kT84xYHHzQhkSkfCpwZYGty9OWYPUFxi1C9So0lfKwzzVCLCn1kF8WcXwTZUEj2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JimVA9g2; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yo43EE0yDcNM6tVOOZUlx6KC/C+iGB88BVhEzxsOWpHOXNwX8Cysgq/7wA1/NX2Hcgbq7600BaTNh4lEgDCuluLofF4D7W2Co1vDui3EQBtqKdkp6TxsH8Cet0kbiw8Y3gmB4XNCuAaHXJeH9NTWQ9QZcppgLr70/ZRwM1z7NyOtVQprmmLNmoGPlX2FGC9qjqeINV/yzq3hf2VZ5TqP06styp2DEAuFhbiaCTdg/6zbtVgG8p2WQ0W8lfGXfZIXqEvhLVAAc6Cy00GJYxsGwGLs+FDCx/UXCms33BktVvlHvqk1rMzRnrwTwuoCRvai4AnOSqUFBAYVJ5beteoB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSln1DjEuYx6DG4dmnRws1IgdsZyA57Ta38iFBntaEI=;
 b=QJmcsBasw0sRVSPwQty9zURvbgGW1QFjuXP5VSKFeN0Sv6CfWZdeuNMj5dx4sP0nZ9H26CR2QA/FFfPceWGaM2zGxbWMIY+ot02AciZjmQetoknYnuMHATL29vM8gWt/09SIx7sjwqMtQ86PRHzgY5zkQiiLzViR2dbZg3HmuEdt0q3VgISXYHzvY+3WKQp+Yr87o3DrvkydLj8v/eI17HA8FLiKThPgXSWNOhSY3gDBlvSVIanpaBYsmaSYl016mfe8WuREjQLna1x1+gedBvxWm79r//Iw/fwYMqAbOF15SES4nS+QCNaM3BSV9mdtbWNa7oFmvk6xq16/HzJkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSln1DjEuYx6DG4dmnRws1IgdsZyA57Ta38iFBntaEI=;
 b=JimVA9g2AmdrYbxUQkgnihyO5O+x9f0czqi6XKHG8zZtmtjgR+VP3rkwAHDTfa1yYem3SGYMeoCXnE5AMVdCHaEEgmy3hQ1kFaaJsKeLCDRy1tJSLnCu/aCuJNfK8OHm2B6OIKTh0tXG55p9w+S5uP08Sa3raciZo6WsGbEM2xNmC+wUmkqv4SffxCKNQqUga9BiwgJTABVs/WaqZvknN5jYG7DmERShVGuXOfSM2+RVERsCNev99E8RKHaxcN1C4zVTp55Rv7XJ0G8aimT7PTya/riFyv2VPuDXW2uvuYLq3/ljV6SxJOlV2DyhSqLMpbF/ARfYxg8xHtGOTplFzA==
Received: from SA0PR11CA0037.namprd11.prod.outlook.com (2603:10b6:806:d0::12)
 by MW4PR12MB8612.namprd12.prod.outlook.com (2603:10b6:303:1ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 18:51:02 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::7) by SA0PR11CA0037.outlook.office365.com
 (2603:10b6:806:d0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 18:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 18:51:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 11:50:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Oct 2024 11:50:46 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Oct 2024 11:50:45 -0700
Date: Thu, 17 Oct 2024 11:50:44 -0700
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
Subject: Re: [PATCH v3 02/16] iommufd/viommu: Add a default_viommu_ops for
 IOMMU_VIOMMU_TYPE_DEFAULT
Message-ID: <ZxFchFtb8ilUf9Vz@Asurada-Nvidia>
References: <cover.1728491532.git.nicolinc@nvidia.com>
 <b7acc7b61f1ffa156d5922a17e3974f41adb964b.1728491532.git.nicolinc@nvidia.com>
 <20241017184729.GR3559746@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241017184729.GR3559746@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|MW4PR12MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: 2307b559-3695-4631-bb37-08dceedca57e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vfdFkVuTGx1b/nZknUz5QvDl4i/GmiVr5l2a1t/V7/guuM/RXRRrpoACuI2W?=
 =?us-ascii?Q?g3ThRrEE/1TEzeD9I8S4OSTUGKWrf9lJrjCka+IHZOPMYTfp1TRTxsJ5+A/H?=
 =?us-ascii?Q?glhQBh8ZElf84Yty366aSs1ufGHJQh0NM1zjduHRdASlarCBrSe63j9jGWMb?=
 =?us-ascii?Q?ia3J2oC1V6URqnnuZo4RzYSjMzRJ6XjCUVQgo/foX6lzX9pZCISaTc6M8EpE?=
 =?us-ascii?Q?gZZW/NSI9ZnQdBZilI8wwAfafMH0Y2ZigGZJ9kzjxi5dV3PEHAwq7Dng8BQ4?=
 =?us-ascii?Q?dvJwEHfFLXC2hZdfYB05R7Ujq1aFwO1fCdcGL31Uj0eFTBjEwPpUi2LWcUWt?=
 =?us-ascii?Q?EOUW9FF829GhEO4JCcTMJtWoOxnIK9Ls4YsBxJzueD9mEWKu3v00yjvBJbaR?=
 =?us-ascii?Q?kwJOzXX00tg3ykOPGbIzV9WHaRGXbjOL66qrZKf0isTS/IYq4eKAN9Q2YUUP?=
 =?us-ascii?Q?ZGT0eq2Ktx+9egTFMBWApPeVm7fghSLTZynXBng4aTkhZVSXTjWK1iZtmnzz?=
 =?us-ascii?Q?XEf4RxTfZkGDDsOZS6rYfsdqVX8YhcIXKJVsg0i146zqGuPLEf1Hmfk0XYNg?=
 =?us-ascii?Q?Yp9WafTeXZaGfcrxh82lbaoxUr+6L4900Ibv+Xu1IDJWD3FIC2HeFh7HZbrE?=
 =?us-ascii?Q?1mh/KNZA1U4gQuHp2yDgsxNPbccBv9J9k6cy0Sogw+SBLVyybU866e0n7T5Y?=
 =?us-ascii?Q?k4MBNMRd0vA8szu/v4H7VwhE2rZg/PVsZHMZ0Ft+L8Z7nnTGM0HdQ6rzt+r+?=
 =?us-ascii?Q?BH015ResaahTOh0TXEhDn4xiirNJekzFxfuylQtnOG8sEsB4N/UnPCp+Oe1e?=
 =?us-ascii?Q?jTwO5Ltoz7DZ1L4tjDoIguDHO4s24m3crIEYsNb7zqsFCh2gaiS2+FE/yLAD?=
 =?us-ascii?Q?lBL7mHxgMpaFyg88xvRZdQep1+fTOoG0zpXRrSe4cH29sQfgNOZbhGCVnbzU?=
 =?us-ascii?Q?QGFTfeJN5nyRXzQAVT/lIHRl0ujAED4kwvuAJZ3ycJDmjcCtDGElWpFyOdxy?=
 =?us-ascii?Q?sQd0sHnHaX5+Ye+0Y1vjAXo30k1V7ODfiODd+AUF/myhBmwnB2bmbkngaRRa?=
 =?us-ascii?Q?8ECTeIx0Aj+6E+94k74cJnaQGPJbLYgymspaK8jqTD+J1vJMzZcmLZijx2Du?=
 =?us-ascii?Q?hoFQaNL8xrbybb2YTAdSm96utQRRCrSCb3k5u/Qeu8NoyHeLfG1ATNI94eF+?=
 =?us-ascii?Q?u2tME2h4hzhOXYtDLuB/Llp47NSE/2ewC/DrTZ2EK3XSJ28pxpx2ulYJfHqb?=
 =?us-ascii?Q?A6iShMGN6227Kori+gufdaMbS3wTmJ0T7jfFujpVxK1/AMXxjhCpl1/7eXPY?=
 =?us-ascii?Q?eACB8PexgVwiLmRAmE26T/jpl1e9Zlp3k4CdP9WbKzVhEJR29o7u+l3agex0?=
 =?us-ascii?Q?ojQ5Tth4/TNxzvxQzbmpK7Wcdgw6Wi/KGGtDFkFq8Ej0KKXu0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 18:51:01.5279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2307b559-3695-4631-bb37-08dceedca57e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8612

On Thu, Oct 17, 2024 at 03:47:29PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 09, 2024 at 09:38:14AM -0700, Nicolin Chen wrote:
> > An IOMMU_VIOMMU_TYPE_DEFAULT doesn't need a free() op since the core can
> > free everything in the destroy(). Now with the new vDEVICE structure, it
> > might want to allocate its own vDEVICEs.
> > 
> > Add a default_viommu_ops for driver to hook ops for default vIOMMUs.
> 
> Why? arm_smmu is now creating its own viommu object, so who will use
> this?
> 
> Do we have any use for the default mode? It is already a bit
> confusing, can we just drop it?

Hmm, that would make the default model completely useless..

Should we unsupport a default viommu allocation?

Nicolin

