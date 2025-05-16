Return-Path: <linux-kselftest+bounces-33164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0665AB952F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 06:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D63E4A7F21
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 04:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF679231A42;
	Fri, 16 May 2025 04:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l97/GjeG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4723C72631;
	Fri, 16 May 2025 04:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747368646; cv=fail; b=MabHqdWTn+dZEzQoqch06q7ItKcSv1HX7xtTFLnubxtitoaNb0bv1FsZb18IivFbhNlugKLdWLLcAcp0CiWg6+Su+Cw4Q9DPPzLsoJ1RE5AajGS8B4WF7J6MRM3avRFfA2xioPgrcR8JYdekLHBBsfMKyvVyt1Kn2bB6QqjKqwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747368646; c=relaxed/simple;
	bh=YXSNO/P4FxsJgf22AsaV67IdSygBAj1UVfn/OMTlCvk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zjy295pQze/hBXUvDyIdfQFo5UooAFDZkGylczSqHu1bxU8qUeM04WhgjP2YJT+d4Q3zx0EuS5AQCx983CVpFZjgBbEy7oJeTWj8RxDSrj3Bxk4iZa0maMvxb8pfB/98nbnLjCl6YGIKjgTebNQ81WRu704vTuL6pbu2p2PHgZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l97/GjeG; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3dCBWi4kS8AqXwx4o+Cju8M1x/FfqhU3B8sFFiIMmUF86kCSK8hGpYbkRwoOw6wMSn4UrcTh8mxucKwL2a/w9Vov10P6EpTRIPwVSfFe9lrnrIhApkWFGl5WtWuZUPlzdnGI1dJ/73TJfVET5JsysCeI8ItYvno3kN2d/OC+Cc5fvpKIYgw5KQa/gRqrk+3qZNWcqn2PA5J5vgA1VnFoy0ejAFgGCJdYSPIrBWK4DCGM4XwJFozCC3t+uTIbWKJ8ujD5Ax9Z8zhymxkox2tU37PsUdGxSx2wbHLsPNCcb3E+TkWcORZeTNFy+Oqyxszu7Vezz0n7nSPEH+zqOLoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYY7439NwvX3z9HfMnUoNER4AlbYKCkqGHR6GGEf5uE=;
 b=DSb8OQ6PgHcCCdWj37TXdbaPF3cdzisByzXTGxQ8CLwAh+baJAtsTz+qmc/jH6sDwmzQTLx+I4f9Zh1Zw8lbH5zbVtwKb9Vt76qj+qa3lcE+vn3fIauuSSpMrLJs3f9oq/OhZ1T/ofM/9nqd1K62aUAoCC9fZcV6e8fwb3Ahf7FbjzXeNzExfxNl7mScQqZSd2AQlkqv5zS0OmPZoiM2b6AyTWj6Ydymp6aAL7mZBA78WifAGPVeUynhcCQrAMnMpN6RSaRROChArzwxhtQd4pWV/A/F7cievrJdwuNkx9dmM9TySbFk1AhAXlb8cj+DUcQz+KdEdg5CYZQCzi+zWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYY7439NwvX3z9HfMnUoNER4AlbYKCkqGHR6GGEf5uE=;
 b=l97/GjeGB8PgVXwBXUGY/jepCWoIyxj7taJU4QISIMChahHBumQEwvY7yKAIOPaJzkPRlGNpZmzVV7x7ynrXk2L+QvssVDoTEJYiEFWZh39aXkpGU0MUf3PCSPBu2a5YXLQcb6PkRbekoQcGctJOowOMADl6yw83qPUDyzNz4/xImEi8FAzZHmdnR/6LKpeIKJ0+AX485lMte1G7PL+01Dvb4ni3STuoeAJTmrCa/fC1mI+tRDTcOjvaj/4C7pE9O2AmKCgLpDINKacqWROIgsKaQeBiRYDQpP+JcVgJ/g56yytpVigR6u+LkRo1f1hB/uzGs6wGsUTvTRVFf83RgA==
Received: from CH0PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:76::16)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 04:10:40 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::81) by CH0PR04CA0011.outlook.office365.com
 (2603:10b6:610:76::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Fri,
 16 May 2025 04:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 04:10:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 21:10:29 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 21:10:27 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 21:10:26 -0700
Date: Thu, 15 May 2025 21:10:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "praan@google.com"
	<praan@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: Re: [PATCH v4 22/23] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aCa6sdNwutK75Lnm@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <a06e91b8bb4a2966dbe7fc3349502d38c3ba38cb.1746757630.git.nicolinc@nvidia.com>
 <BN9PR11MB5276D8FF50750CF35D0DF1838C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aCYgyyHwJsQvLLOo@Asurada-Nvidia>
 <BN9PR11MB527611498E2EB3A93BFED51E8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527611498E2EB3A93BFED51E8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c74ce62-1967-4017-e60e-08dd942f9ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j3keZhN75lsv709CUkLNBPfG0uawbsZc0V/Y6kpD4x8jBycvk5Y4dJujV+Au?=
 =?us-ascii?Q?bHGkaoVaLI0AzqqAmo3jrJtw5F0NkA8jKMfdlPSj4WPJFKIf/j8toReLQ/BV?=
 =?us-ascii?Q?OlXxBShJhQMcc/ezphdxIKyHprOmFKfl9/yyfTopAR2EGG3Etl9i/p/cQTpA?=
 =?us-ascii?Q?/UnqWLFNVzABm6wIkvKHfEN0KissAzSIYU5RlFCOHhqCVXBRy3WdSCDoz/Dq?=
 =?us-ascii?Q?8axyQdC3n5px7WYH/W5DDR/8zPGDM52OBFewC5O3lnTF6WMK0CkcS6D/kuym?=
 =?us-ascii?Q?+O0YK7VgYtMDplT8FkN1G1amgh8kuseNtHje17Q0TVIkeSF5llNFZ9MQ0/YX?=
 =?us-ascii?Q?dkSTSkAZCs6H3lqqChvveTL+rTqKpC0od9DshOfp4cg7ctfMr49b+SV6D1DA?=
 =?us-ascii?Q?YnBBiMknIF+qqjxkmldAV8agyQpiIWHR0keDvGp8kUvOERrdf1Q/MmVIGiRM?=
 =?us-ascii?Q?xQlNkVRXQhnWp+0ldCukJ/B3KJ0DiZ8O8xhlXHwvV0IXUIMqYodlkPAqLLoJ?=
 =?us-ascii?Q?EsXZk54HOg5ZVGcBTbG8TiCL60TN758MubwLTut9z9Q8XuRJ9qur9tUAoME2?=
 =?us-ascii?Q?s77uGzNDLpXSVaQPreAoczHVBe8F7ImVtggiLLYhfoIQHR/H4STqqfi1Ikdu?=
 =?us-ascii?Q?InkmILj4/EgB71p65s5X24GfyEfKDGfEZabOaQousvgD2JF/qYp0eSkpUhY2?=
 =?us-ascii?Q?oxwNbHabW0FamR1PLJBxhZM7nABOGEeixQ07rqwpHDyhGOcFs/kAaz7WZs0h?=
 =?us-ascii?Q?xR8FCxjGCTztVNFXtFa733x0QhJfsNn6jH6Zg2pdfTMlnCXGSQsuA1sjaX7g?=
 =?us-ascii?Q?RBC4+wGLBIGffLinlqT5KNXJ7vQW4ZsuKh3Q9QK2Bj0Y2lX59KGoAjBl9Mz9?=
 =?us-ascii?Q?x2Vql30SNwZzaYG1lM3Dd/BDBeznzAul2SA/M616ww7L0ntVvdaS+VFqeQDz?=
 =?us-ascii?Q?757ldq843N5GPZAMsrsPJZVIzIVYBLh2ur5RX4rK0qHbzUtW9UJBt60lgDcN?=
 =?us-ascii?Q?AheEYtRTbKUAc+qu3EKvAWvN85Jp/xlZn7W091Czun0KBDwT//fsf8p1XCwE?=
 =?us-ascii?Q?45o2Dm1yJaRN8DpMjydki/oncsUnCrxCUOPEDptvu7a2HKBA6/5VhzZJNfv9?=
 =?us-ascii?Q?bzBsCsBtOXNL4BpgYl1ZwVUkUEkaob5EE11bPd8Z4E8h8UW5mbwfJ9Hr4fbS?=
 =?us-ascii?Q?adBsE/I4c8aY5Jml3iK2DT38mKZVrCwZTuxIr0Ni3fE/h+PzSORhepqgje8b?=
 =?us-ascii?Q?zW7KuiIX7Obs/Lb+2f5UnvAcK2M8YH3b7XoDdkgtt/USzZX1dMNhegsjcvfr?=
 =?us-ascii?Q?x2G75N+x4ARY8iwz0Caow8j+PP59tBtQ4/CQHZj8mUD8bPUiijT/OqVvCTZ7?=
 =?us-ascii?Q?LsvSiQIYa6nIdecRRdHZ5csTYd96LROcVEtBwUmOv7YT+XkdZzcmWcaca9p6?=
 =?us-ascii?Q?83ifqohpFJIfEG934a+UcK1YCai6s9oBt1oktxIwhLyfjStPblTHu1TqaOjp?=
 =?us-ascii?Q?6mq+BSAxt1qh3J4vcmYTvmzN2m8q0rptHTr3?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 04:10:40.6261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c74ce62-1967-4017-e60e-08dd942f9ef3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327

On Fri, May 16, 2025 at 04:00:58AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, May 16, 2025 1:14 AM
> > 
> > On Thu, May 15, 2025 at 08:27:17AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Friday, May 9, 2025 11:03 AM
> > > >
> > > >  /**
> > > >   * struct iommu_hw_info_arm_smmuv3 - ARM SMMUv3 hardware
> > > > information
> > > >   *                                   (IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
> > > >   *
> > > > - * @flags: Must be set to 0
> > > > - * @impl: Must be 0
> > > > + * @flags: Combination of enum iommu_hw_info_arm_smmuv3_flags
> > > > + * @impl: Implementation-defined bits when the following flags are set:
> > > > + *        - IOMMU_HW_INFO_ARM_SMMUV3_HAS_TEGRA241_CMDQV
> > > > + *          Bits[15:12] - Log2 of the total number of SID replacements
> > > > + *          Bits[11:08] - Log2 of the total number of VINTFs per vIOMMU
> > > > + *          Bits[07:04] - Log2 of the total number of VCMDQs per vIOMMU
> > > > + *          Bits[03:00] - Version number for the CMDQ-V HW
> > >
> > > hmm throughout this series I drew an equation between VINTF
> > > and vIOMMU. Not sure how multiple VINTFs can be represented
> > > w/o introducing more objects. Do we want to keep such info here?
> > 
> > You are right that VINTF=vIOMMU. This is a per SMMU instance ioctl.
> > So, each VM should only have one VTINF/vIOMMU per SMMU instance.
> > 
> > For multi-VINTF (multi-vIOMMU) case, there needs to be more SMMUs
> > backing passthrough devices being assigned to the VM.
> > 
> > What exactly the concern of keeping this info here?
> 
> First, you agreed that VINTF=vIOMMU, then "total number of VINTFs
> per vIOMMU" doesn't make sense as it's fixed to 1 in concept.
> 
> Then, each VM can only get one VINTF/vIOMMU per SMMU instance,
> and this ioctl is per SMMU instance. This also implies that only one
> VINTF can be reported in the ioctl.
> 
> In multi-VINTF case, the VM should get 1VINTF per ioctl from each
> SMMU backing passthrough devices.
> 
> Then what is the point of " Bits[11:08] - Log2 of the total number
> of VINTFs per vIOMMU "?

It was not there in the previous version. Pranjal pointed out that
it was missing a field.

You are right that this field must set to 0, indicating only single
VINTF is allowed.

Given Jason's comments about this impl rework (to a data structure),
I think I will just drop this number of VTINFs. Instead will add a
line of comments say that VMM should set this field to 0, i.e. only
provide VM one VINTF per SMMU.

Thanks
Nicolin

