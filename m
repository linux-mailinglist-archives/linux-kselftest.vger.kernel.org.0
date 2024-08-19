Return-Path: <linux-kselftest+bounces-15682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439F2957403
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 20:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692B71C21E53
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 18:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07366188CBC;
	Mon, 19 Aug 2024 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="skO1nGbI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415A6175D50;
	Mon, 19 Aug 2024 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724093671; cv=fail; b=duB8R1MIWa/EpFSyPQfOwJwRo3oiHOS9uX7Bye5z+AGH6umjsji+UYq08nZXWWUx5dTz0SiB/kUjA06S7oVzeU9FV/xz+2mrnWNqz/aJFzaPQelw2DBJBBN9dsZE1mYq5Tbl3m1WAn0n3WswDk4KuXXMusfxUxPEmTFG++qdb84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724093671; c=relaxed/simple;
	bh=O+1bYjq+/v4KmeGviZtCOk5qvPwjA5xq6kjCkAh6huY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4QecHXxcAFxt0ARBupr/ANK66LKvUViq0fgcvp524ctFWlNxG8LJJXuP1JjC5j0OKn1rqc60sTzDZVesLGsp566w53cBjmOGLnD4PpuC2l9BkJlqIBrUy/XPC6mCLoXYDLT3jm1IqPc9Gnpyc6sK1kIdSOJAgvoRZlexDBaMt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=skO1nGbI; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diUF8EBEvQj0WVda/A+/CYsZODcJgmUSs3AqNUPxiFQyXVpO+BZXR+hLplh0Q04dwy2skU6iV07jsZMjzSt8m/pm3g+9e//ztR+JYFu6obfDHlZZxWopdLK+gBtQoMPGIw5Oo2zc8y4uQQHt17sS0A3HWGqT5UT6cYP5vC0ZxvpNBSM2A2wtVYKgmSxve2tCM1QfUarDKl40O4ZxgzTCiozjMmWhUOKRv4w40zPHxsPFd5jBfTCwgBIJPxmCWincz9nqa6hEhtWJGuKheN6ztsm4B87GacUIuZU/364IwoPa/nUfWe9uMQ2jrX7lzbTVQPFNN4ya0Z1SZlJFkRMD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02m9Z3REQO0NWP4N4j3sGaW/XCKa82VuYlF6X+EAmK8=;
 b=pLEr2HoATr2XOuE2N3ie4nIIkQRa86VC49l/7+8jfXAoGPbNBvhvpJzpnGtRDKan6N4yYbUxxX3v7kjWoP0nD1c8jaP0wrWKNZ/Mf/lYiMeGOY5MWp4fnGM82kXvrvHEEuTtglOqsL/64tEfkX6DMZBwAukmTRN+hCxQDWVCJxkzVvmOv9Ria5r4VY6Q0cj1kjuEgQkY44ulkFRfmItrIz7EyifJATAzArW9vQ/8x/iIVaxGU5IEffQkwtAoVe89zzt7/SAP6/gVZHVrXUwLAtM4es31aANUFmVVy824+Cfw0Rk3X2PT6zz/NuTI02B/2CZwIIlYkQNlPVrHp5DvyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02m9Z3REQO0NWP4N4j3sGaW/XCKa82VuYlF6X+EAmK8=;
 b=skO1nGbI6ob/wiGCfS2SsDC+Hi4uoHy/RvisPZn74twbyRAJ9HZKTQYn2GQBhMV2puw9nqJSwZReHpTwm3Pde4WwhbDQwOJJzrD3z4vceJcAL57ujneMp1yMhk6HZBDPOh7HGSy+OPcfffgF5KzOBrJ/MEL6nrNwJFvmn8KKkiZJ/jdC3MFGTrB0FQQXUFp6TgLBRisL86Vduap5oUbWFRRg0ssTX6PmEP7WBDdY6CvuPneItSM10/xC5jVv9v4DjL/+ddnirep28b2Irwh66ot+APvpcGPmp/IXs4YDnewGUAqgsxpCIdWDtte5fp1+YEiQHzKAtJexS/FN+M8Y8w==
Received: from BN9PR03CA0592.namprd03.prod.outlook.com (2603:10b6:408:10d::27)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 18:54:24 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:10d:cafe::75) by BN9PR03CA0592.outlook.office365.com
 (2603:10b6:408:10d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Mon, 19 Aug 2024 18:54:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.4 via Frontend Transport; Mon, 19 Aug 2024 18:54:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 11:54:12 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 19 Aug 2024 11:54:12 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 19 Aug 2024 11:54:11 -0700
Date: Mon, 19 Aug 2024 11:54:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 15/16] iommu/arm-smmu-v3: Add viommu cache
 invalidation support
Message-ID: <ZsOU0r1ECS6+9O7l@Asurada-Nvidia>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <729dfd0808f85d88fd3ef8bcea0168cc1d2c0d59.1723061378.git.nicolinc@nvidia.com>
 <20240815233635.GV2032816@nvidia.com>
 <Zr6iPtiZ/afonJ5k@Asurada-Nvidia>
 <20240819173615.GN2032816@nvidia.com>
 <ZsOMu3OnMn49cDXf@Asurada-Nvidia>
 <20240819182811.GR2032816@nvidia.com>
 <ZsORHnIKJsJaTkiF@Asurada-Nvidia>
 <20240819184716.GT2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240819184716.GT2032816@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: d4475534-d96d-4091-ac8d-08dcc08057f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dyu5tIZC5vXH87CB/T3acT0En/zEtrSijbs8w4KEXPXfrlNFq28gcOqvT7wh?=
 =?us-ascii?Q?w+/AG2+ZiqSpUQZo0YWg6T/TybKmrKDtDYp3P0CIFBcg2TEfPCcciO3CPaGm?=
 =?us-ascii?Q?QrrMYUGREpNvmoHlGFo0cxryk30KzpwSkT5S6Zc9v7UJyqdwPoVtsZMBjmcU?=
 =?us-ascii?Q?XwcJFnzH7/CHOiRneUpBvcGAKCVjhd/6+7oq72axvPJ3hVb6PiBg6UqW0h3Y?=
 =?us-ascii?Q?4dIoGU8k6WNsw14iyTVX/gD4Y57vkM2Putr2AoCyMM1YVw+QtR4/6kznAH05?=
 =?us-ascii?Q?qHscFXZIvjVYDMgHKsgrOKkgCIryhHEhXy0a+RQ82fJhCYs4W/rgSa7CcnfN?=
 =?us-ascii?Q?mIwGnVNOjwm6tdfCcm0jjZzapb7wh9HqO9yomlj2rxg5PQOlYV7GOB1hotQa?=
 =?us-ascii?Q?TRs5HleZcBy2e1Tvf3hp5PQze1uLqn/UPGojIAwnier60ucT2x02BaBT4wyt?=
 =?us-ascii?Q?NM56vOcxrskp7tB2jS9vNPfbtqjka5MkIbKr+Kk6m8Fse5YHGcgEj/bTAGz8?=
 =?us-ascii?Q?8g3wVn5b0+t2UMI7J6T6r1aoB2QlWBi7SeZLNtEAzAFWDtldZ7QH5l8IQDI1?=
 =?us-ascii?Q?zIrCCZm31tqdQA0kbVAQQo6736CN4R41yPmbCxb1J55QV+7Mcwn2lbpD5r2E?=
 =?us-ascii?Q?TyV8NmTgSp6KgoUtbgunX47tgzuLs9ovOc/qzl5IleBG0dFlAptUEThxhFYJ?=
 =?us-ascii?Q?BcqMlnx5XvYV/+DnSftoFRjKiIC4ZCM4P+ylRpTQf8zhwc7JC7Zwjgl1ITN6?=
 =?us-ascii?Q?qmZ1SllQftiCkZi/6Ax/6HPLSnsTzT0ZVkftQUqHLi5rotXXY+10Q6yTPG6G?=
 =?us-ascii?Q?hA4PwNigHW5qLvOr5/2Q2N1UPJN80FfoMLyBU0a8HQfPov6P3TD4VHPJlcqF?=
 =?us-ascii?Q?qDx7TsbnJtQviSvztAne6waDa5Wt9hXkVEP+DJix0Ck2msjCROlGzjrPPzMj?=
 =?us-ascii?Q?2Mn+uk8UzPdiZS2C6KVKuGvv2L8oo76mG2HFIVoburdHzYoH8CX/YLl7VwM0?=
 =?us-ascii?Q?pqiW7+K14/wej7123ilmpD16px0tgxwky9kTQYAF4hr9O12sfVilAc1FDKgF?=
 =?us-ascii?Q?5T6ck3dSi1CX3yChagxXV+2LMwJby1j6f+m5UGPCJv6x/QAwWyMgTXgOgNlr?=
 =?us-ascii?Q?HcSmDGS1iDmkMkpqQDOj93qcNQQ2oUcIMes9RqEWOv2rVzQmdEp1yzwCUhJc?=
 =?us-ascii?Q?6TpKzsdF1xvaPzeZbIHSa5Gp2kbWPKn3B0RvkT6vt5ihQczj73RuEN+0Ct4P?=
 =?us-ascii?Q?4+crowENCbQkki5myqDJGqTbuG8+ien6eUsq+feaGrn6a2jlsCO6VZoNjVvW?=
 =?us-ascii?Q?L6xGdT7quO5/ulaUJzFtcwlMmWTOJdqOJTF5nJ2rP0uk9EO38suHsD6OOeBG?=
 =?us-ascii?Q?YwFkupkZEqnIHzc9pYnY5fRK/nJmGrK7RsDY0of8Ow35BMkrA4CUiBJmq2Io?=
 =?us-ascii?Q?h5SBX72Hxv4EhGq90TSIHRo8+Iv9hA99?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 18:54:24.1867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4475534-d96d-4091-ac8d-08dcc08057f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799

On Mon, Aug 19, 2024 at 03:47:16PM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 19, 2024 at 11:38:22AM -0700, Nicolin Chen wrote:
> > On Mon, Aug 19, 2024 at 03:28:11PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Aug 19, 2024 at 11:19:39AM -0700, Nicolin Chen wrote:
> > > 
> > > > > But nesting enablment with out viommu is alot less useful than I had
> > > > > thought :(
> > > > 
> > > > Actually, without viommu, the hwpt cache invalidate alone could
> > > > still support non-SVA case?
> > > 
> > > That is what I thought, but doesn't the guest still have to invalidate
> > > the CD table entry # 0?
> > 
> > I recall it doesn't. The CD cache invalidation is required in the
> > viommu invalidation for an SVA case where we need a PASID number
> > to specify CD to the substream. But the CD to the default stream
> > is only changed during a vSTE setup, and the host knows the PASID
> > number (=0)?
> 
> I think that would subtly assume certain things about how the driver
> does ordering, ie the that CD table entry 0 is setup with the S1
> before we load it into the STE.
> 
> Yes, the Linux driver does that now, but I don't think anyone should
> rely on that..

Oh that's true...

Thanks
Nicolin

