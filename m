Return-Path: <linux-kselftest+bounces-20814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7C59B3320
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 15:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D8B1C219FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 14:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27101DD0F3;
	Mon, 28 Oct 2024 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i0LuVf1y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50461DA631;
	Mon, 28 Oct 2024 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125058; cv=fail; b=heAptnD99wnuR5+vA3ZoX+ge2rNdaBWWyEDDS/BXnBNAm6NirgG4V/eKUHsOGG37OkX03D6p9oISUVrfLCnGsps4T5xmDrg7qaqmoxpimbl0Vsbj23FOVZqW/fwamEG9ToF39KBzjcjg3GYvBxvo/1FgCUpp1IrafrU+Wa24HcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125058; c=relaxed/simple;
	bh=P9WVVi1TN1t0bxF3rZ9o2gKm5V1V8Muhrx3hJ2ZHaD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YrUHka4RxfMb9MS87apoXh949/tIEewkCAJFKOQdezsDwGqPjqmOnouHoBO1v+uBTNrvUXg0/biQWallZ8Ev79KnOkIZ6zNwRovcFWptrxPUPyvQER7Daxe0LyTGlPvng9Xssx4Oi5zEu3X7RwoSOUNC1mniC/9jQcr0XgFDJaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i0LuVf1y; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhL81Oy6pcarp/XOE/7/XeZ9sGZoyRZo4v6EL//fsEvJc4jeICKDRlo5idEh5skZXOWHvgkzBoGeUDZuOnpcOgHxYhgamLvJ2AV0xtyS+y4CAjik+b3WQNqr4vK3SD4lTV++emxRJeuYI3j8Md4Ju4/DgegQKJZXc4a536XM7pPhtmc8uMGbVgGRuHV6X5UUYAZ7NtcQWgnNd3c+PA1pCu6cdrNCsisKpVjeSVBQb2fAA33iW4RwpcMq6JlEjA5PuGRVAMXeap8/k0qmQ5RSg9b3CBa1UIlZ3O4NP5ByE0qTBvYE8XVZvCNM9JZ3GpYy4Lh91fOrzhDZnDXCbIlzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tbr8xWXEAsGn8XE+3EXL1/BYRbTxBxe8MoPo1mYh14=;
 b=rpK/WI32BXkV0E2Blv8DZX0YqBPlSVijwde5kYZpK6Q8FrQCALzY9/14pfQBPvv3OKxLk0AugiFP7aux6tztGQNg9JX7pYLSLZ74U8PpzCA1lVfKlCxLDOr+Ml80vtr3rE/ng5JepBmsG132Mfx+Gwephdhn5rofkhDlB94n8SlRedhLT1VJzt7Urqu4x3BIYh9BgWKyTd/BcfV5aslrK0loH/IFJV0sPmg3eOL28bUj4ZiWc1sCchnFlLNHf+j3QbyrMTGpUpdTCcYWHWGIOuDlncYWkvSSdfRFk4Szj2KQYeSJUB5Mx0Du/+zMf5NMI2gyrpbpiIUhjBzB6vyHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tbr8xWXEAsGn8XE+3EXL1/BYRbTxBxe8MoPo1mYh14=;
 b=i0LuVf1yM2B9EexrLMpaLJrstoeTH1ZgwYT4dfjGiMdMlDssmTH4cevQx3+UXingc3NQIwBcmklqi5dDvl4iuUwyS2ASp70An7pMnDKRJIMh9NDlmPFdulzrgfwNJhARvpVT6/C/y6HaY2bng4P+ufEbD8657XBtdoFzfH1Fgy5sUKg6fUbnZ+cA8h/n4DDFEJcw9J08LMSCk49ZIrO9gro36kpg4hM+9fpR79p0Pn3Nu55eAOy/mNHKCQM6LU/BCqqGu7zuUiwMG9eke3dcFpCR52Qw3H7aojOiJoc5/l3hy3dCnmJsV7ebUhsFCtH7GXj6M6pJ7sV3jNc9jc5G+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 14:17:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 14:17:28 +0000
Date: Mon, 28 Oct 2024 11:17:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>, "aik@amd.com" <aik@amd.com>,
	"zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v5 00/13] iommufd: Add vIOMMU infrastructure (Part-2:
 vDEVICE)
Message-ID: <20241028141726.GQ6956@nvidia.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <BN9PR11MB5276FFE90D75B2146674E0BC8C4A2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276FFE90D75B2146674E0BC8C4A2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:408:f4::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: fa452227-3f9d-4935-5a87-08dcf75b4090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iaqF2ijpLCWQ956trmglik1iKt67jJ0eYojSOHnVZ/gJY4BUY8/g2NaiMA6m?=
 =?us-ascii?Q?nvYYI0EhAcoDav2tCeh+IFgk6SHplaZXycn2JHDk6CasfX452Oa9Ap+XRYLS?=
 =?us-ascii?Q?f50MPZA0/a8xIkf9VhRvSYYv/2GSPg0BVUl7aFb2i1cS7pJrUnbeLMHihyUp?=
 =?us-ascii?Q?27kFYoaNiyYz5C/Bmt+dig4K6AqPd+Bk8PUQjktjQ+STs6uu5HGV3ESmGhla?=
 =?us-ascii?Q?VtlK82vAkja3FSny+1IDim4mjkcGL92KrpJ9qRH5t5uDX5egHVJQ6WA2YsG4?=
 =?us-ascii?Q?JDldkUFsRzv9wGyPy2dflceLA1QalNLr8UQoITKl9M58xfY+g15xBtEn1yYd?=
 =?us-ascii?Q?Gf+S6hdTJmdkG+zHZNqo2l7J5kPJzrcNuX+WLmcUyeV3GWyDdQ0l7sQHKmR5?=
 =?us-ascii?Q?8ihpBw/BkydW15/u2j5MdTlM7k0wTcqBWxT/864B43WM3Fvk0LXe6yqqTqOb?=
 =?us-ascii?Q?LercCtcr4DAPK8PNQt5p0AfmzODNoMuKfAmxoqPKTVi4YFtBjRdkAZcRayQ9?=
 =?us-ascii?Q?hEQuh1FR8OxoZ/kFdZ17vQAiDkBfED6W41oWPJswQF8NcFVLSe3AOQBql5SB?=
 =?us-ascii?Q?Zuu6bMrIllMqvF07u8Uun79sIQjzYjsO1t6jg/HUd8sBZGr/0/r2O8YePFtj?=
 =?us-ascii?Q?/cnM+gj/y8mzdv+JI6BAoYdKQyLRGiJ9DupuMno87Ky+fChvzww52PZLE0HY?=
 =?us-ascii?Q?Qn/qr41yx46YlxpmECca2xj7q6UB9kLqdh6xFARmbp3hgoHN/qpXqyF4fiMf?=
 =?us-ascii?Q?0U9rvRzSTOZQN4I6CRTSRuZF5WDnoPjjARkZvCFwjP6MZfUmJkiUGYv3DZQ4?=
 =?us-ascii?Q?C2wPU9gQ7COlUnqVkZsBZ3ssCEwoAiNh2ogKRadVib4eD+LtLFiisNm6dqCP?=
 =?us-ascii?Q?kJF7fxulwLdAqkRYNvo1qfIQXoi5OdDWZkaN5EJ+rYT17Uuuy/UtWlZ+EVMq?=
 =?us-ascii?Q?iIiM5RseGWOBlaKphmdBWG4c0SBr0a7Y09zHS16crnbm4+unegcZdonXS9e3?=
 =?us-ascii?Q?TssBhkgRoRLeqwQl39FOg2K7XaEVi0/sisksWIou55l6bgMUhS7CFRMkyaKf?=
 =?us-ascii?Q?VWZB+iT6zSombR5E2ZXGAQDPuXWq4f/sIEcm4EPtC/0FY0bt4mn1K1ZnTn8A?=
 =?us-ascii?Q?0aLDXhGgHkijYS0bJIwxbpgjdb63+ds3JhH9+RgzfkiFHkp3Waxc9lq9+xgn?=
 =?us-ascii?Q?yUOTSZvsbpOsQd0H9dxSRUAJRDMZbf9CZawz8W4LOPtxJ6szaPCqyU+sSaIK?=
 =?us-ascii?Q?S1oFP0HQa180gO0sy3HBktMGXsz/yk7CPo9r+OOjItyvuf3JlDC4Tuz7t3XC?=
 =?us-ascii?Q?WfNE6Z1/KJybNLf2fmP/M4xA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0iXCjL6MezErf5YmVF9YWGe8PvzgIsZz0Ebb/ltg17dM52U/Jh0jkJAecWl/?=
 =?us-ascii?Q?r/VFyzBoYBYwQBvUAHIKpawGXhejWLPDLIHRrfcYvHmTTjezP/0Bp4Ob01/5?=
 =?us-ascii?Q?Ku8fX7tM2wyR+R3xtZks5kcUmEOOAPWR05i8NgRWd5RNqsbDMjZGunfqAphX?=
 =?us-ascii?Q?Qwg5CiNbW3WtiZHI4s32H83ALhg/KkyAR7+5kjrK9rtbupu4os0vCQCv+0Qe?=
 =?us-ascii?Q?UwhIuKlPTGpl1oN5KqtLPNa3bTse+mAwExUghi0CYDZWK/9rVwsX2HKPQL6F?=
 =?us-ascii?Q?QpigdpaTr4BCQYaRD3mCl7TOT1gHEWavstknq3awsO3EH4J8SxnjG7ITfv2w?=
 =?us-ascii?Q?HoPNQ1hMyDVN8rfU3IXm6cg2Sjx9CTe/nsIMXshWJqlj2muTvpaFCJ+KB5al?=
 =?us-ascii?Q?KGYjM2p3Yey/l0kgq/AUHNA2hJRmwj1onKBu5wL8W9KgwkiUZ9sQP7snFglM?=
 =?us-ascii?Q?zCIuW+ctULmngcNXnwvCD/5D+z1CMLBxZUWfMeS+Dvryuqu+AIG99dj/yeVG?=
 =?us-ascii?Q?XKk+Lebt07nTpiiK4QY/OH5ChFsjQyPELHRy9k+6A76P2ejggQO4q0WZvpGJ?=
 =?us-ascii?Q?Tyfj14+7GLloB0QcXf0mf7O4y7zCSbFI3OqFVovK0JWRAwCcz4TH8vnLAFde?=
 =?us-ascii?Q?jd85I/ei8NK8jHP0EImSbVtHPHkC2yxe05tsfwfBpqBg+kHcodIrCYIIScK/?=
 =?us-ascii?Q?v/o/6JpwIFpnrcmjj36prHcJjQXsw9WVjndCHFTOZvuUR6S479PlMQtegZyA?=
 =?us-ascii?Q?3lSx8pohdiDz9HkCIXlyTWD187p+uTyCcRjUUr+nsYWQeivnRzo7OYDfdlpP?=
 =?us-ascii?Q?ApBmb3ZxioPAnVmw3+aLzp7KmFm20/XbHHeseIltz/jGnWlzvzqW25guZdWt?=
 =?us-ascii?Q?e5xoRgZ1U08M1ldv7WJK34CfRbRbZJMZL1gIJmFot2XBzdo/wfJNxAUA6BNG?=
 =?us-ascii?Q?WXTnW4khoNNOhzJk+npt61vY4MUMBwJizNAlnnPnxhUEhpXlqkBI84nrRh/2?=
 =?us-ascii?Q?Kubqb2aKiOrvSwXrazfHVwzADEQsNF8Tk0En2z76zg39ZuYcmTvXyx2gwlL+?=
 =?us-ascii?Q?YtjyeFBTqv57CSOeJeiCbkIQsq5dPoT0RgjHjBRN/O9gCwQhMf7KwoEWx74K?=
 =?us-ascii?Q?4hMi1t/G4d7PbHeN6c3/PmxiWZeLAJRrd4cDJXeIlRvD+GRYHZiQ7z8RhfGI?=
 =?us-ascii?Q?uWUT2pYR0hg9l63UuaH4XN5p3AQYz7E5JQ5xSVs3owRXA83/XWYt8AECa/s2?=
 =?us-ascii?Q?HMvuHZA5FN5CZLSHzwK0QkSVRcBj7HAOK/oUMkLQnm88i62AVT7QJbbzOzvp?=
 =?us-ascii?Q?c/AVQzhmrTYKGCT7TIGJ3gXhA7UVGSPN/PQmws4+IhUa68RO2T4lnY2mMw0b?=
 =?us-ascii?Q?IISEUzzmPolisYqpiK6OxSCMO5qh93R7hUvaZfBP5haFuZF954XcVw8kqNtP?=
 =?us-ascii?Q?p31BQpRjp8k2EKfbuqWGqnlERzXUOv9xtHWotlpwcha7E+0E1nyFq9bkm1Uw?=
 =?us-ascii?Q?WrphDzPWZcZ99UACkuhTqodkPBVlI9SgEQRc44ExaAzWYnKbU8VlCm41AevY?=
 =?us-ascii?Q?AsygE2orJfcfuP7Aa3FCPKE1W1rsMb3IdeukTh3R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa452227-3f9d-4935-5a87-08dcf75b4090
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:17:27.9492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kjg55FUNx51BLBXd7AJN/r70TEGktWWrm30uPWqBVt/Ox1PO97xsXQ2nnSGtRn1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019

> > to
> > a Context Table. This virt_id helps IOMMU drivers to link the vID to a pID
> > of the device against the physical IOMMU instance. This is essential for a
> > vIOMMU-based invalidation, where the request contains a device's vID for a
> > device cache flush, e.g. ATC invalidation.
> 
> probably connect this to vCMDQ passthrough? otherwise for sw-based
> invalidation the userspace can always replace vID with pID before
> submitting the request.

You can't just do that, the ID in the invalidation command has to be
validated by the kernel.

At that point you may as well just use the vID instead of inventing a
new means to validate raw pIDs.

VT-D avoided this so far because it is pushing the invalidation
through the device object and the device object provides the ID
directly. No IDs in commands, no switching devices during a command
batch.

Jason

