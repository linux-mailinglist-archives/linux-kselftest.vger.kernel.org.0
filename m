Return-Path: <linux-kselftest+bounces-20680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15BC9B0980
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 18:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64E41C22E3B
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 16:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B161E00BF;
	Fri, 25 Oct 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UD8mDVr5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAC11B0F3F;
	Fri, 25 Oct 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872913; cv=fail; b=qedghB5Wi744dojuhYHLS2LCJ5vjyUjxzV39KE7Vm4512ldBV6c3mCqrd5B16mMl4FNTK5JcOMJpoCXSR2QGFsXnxvAEvEcLjLG0pULIMhsSl0IrDu50bJQWYe20HEe+fv7Vdr1h/7Y1/15/kCA06PojPWDmJmO+jzXhBnSmVco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872913; c=relaxed/simple;
	bh=JAweqgE/E9bNq6kyaNP9/ul3ltHvRGCUQv3AtFNB7JQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MX1lEqNrsZnQrA7Si2djmaV6OzEyCPxawKfU99U8oGjI9LYl1gW/d6MSgszfhiMbKX6xqd5MmATWRsc1WaUIfE20Hl1p8kS9Hw0jlX2cvU0MaTH/AY0EglLeVRmFndWN99i+qLqta5Yw1p0izEkRKAntDiObS+kB+ukft3NSRrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UD8mDVr5; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsfZv+msXBkw1sKOIfb1P9s5jF0Web6nhfO5m3q+mLaaWkKeIM9sdJipOOtD56af9HGDE5W03Vl4HHdeu5Ped5lohMisbeRmc3kSLMX/N8ltWFGToG3xVI65Y4QAtSAg+lcxf3z6kxVccHqrf82jBmzgbTN86gaZ8rD3ppkx+3pjAdho7XBCP2vFuiYqyoIBshd8JMhh0SQTO7+cuD/cBlLr+c6X1QolqXcld5CjTtGVpVOe2TbV606NitXNVtdTBgAv+a7neNBON/dvSqI2WIjjcd+HiVOg/PqWBN9kfg2IgCBAYT9qXcovvWpXqWBOWTcDHokC+s7pVmzYHVFuBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnXiCdGD/CKTEHm2nBL85/df2l6mhhB4s0DdikOIGyg=;
 b=PR8T/q9VtAPX/y8lfjTadhflM9YXeMGcjrfZ2xwShLb8esU6UrAO7ZZ2osRl/ZicsE+jLeaUThmGDXY1u4ziwE9wJDM4MBYC8j2jiCDcGlMsUIhWb9gt1YIitgAbpmbJhrgYCXMrZWAgYYbspqLu8LxF/nsM17ZhV0QiuRuGZGRtzuWEM81vd/VTnU0QqGMkv1l7LoQ1j4M8Q0QCWoM507I4MMau+Kdu4Py+LgAvebkijzZbMtnGjEduGZFidXnGuxFIzBT9lopfiCvHOjao44hszappZRHNIVYigQyycJw2X8H14JMv+pNo5dm5IM8jci2oDQeffC4tOGR2PdwNKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnXiCdGD/CKTEHm2nBL85/df2l6mhhB4s0DdikOIGyg=;
 b=UD8mDVr59mlVG4efXEJkDILqtda2K1qcOWJlsTVyCxCgyIKat8Wi70ePfImNDrqkMIOD6d4tjA16iXYxWh0ozGYSOuYPYnNHuDaTs8qWu1E2ptr03/k3/xcctsgzNw/Otp0dRRpb5VKOG822dbbOid9zai1Irbb1mkPf3L4lrUMwUhmzbLx5zqMSid8FgYqikHRuR7VLcWUGXTAjDaULj7TgDxfR2uuz2AQ1zBRgLLt+EtFs42UAuU2fdwNEAHY38Bdk9BEPQJovgxiR/GHMOnO/kF9h5RSxRHLPxFVHzD4VJRAbxyoUDvUZtJj0n8I6L7cuweuPO3H+YTHKaXdhCA==
Received: from BLAPR03CA0150.namprd03.prod.outlook.com (2603:10b6:208:32e::35)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.22; Fri, 25 Oct
 2024 16:15:04 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::e7) by BLAPR03CA0150.outlook.office365.com
 (2603:10b6:208:32e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19 via Frontend
 Transport; Fri, 25 Oct 2024 16:15:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 16:15:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 09:14:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 09:14:54 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 09:14:53 -0700
Date: Fri, 25 Oct 2024 09:14:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
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
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "aik@amd.com"
	<aik@amd.com>, "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v4 06/11] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Message-ID: <ZxvD/KEnzjTMOYnA@Asurada-Nvidia>
References: <cover.1729553811.git.nicolinc@nvidia.com>
 <ba9ce9b3c8a93c9c790fee52961d075dfbb63ca7.1729553811.git.nicolinc@nvidia.com>
 <BN9PR11MB5276BEF20579F3CE7DBA15908C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276BEF20579F3CE7DBA15908C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eaaf42a-e82c-4a12-e6e2-08dcf5102f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nrZmgaZb3t6PbpfXD94b+7Q0AmL/BhK6cxqeCs2t0GbNgu5RlidD+YOgHRwM?=
 =?us-ascii?Q?mpIcg/dXnsKj8z9fGNeiAYF5fjjxnrVva6bT9xSWRLmaiVb3zcC64ln/ANp7?=
 =?us-ascii?Q?IYmFT9Z1oyfUdY6EPK4ad76N4+3cm74KBHgYjA3dD1TrlJgVku+d/iPYO0hJ?=
 =?us-ascii?Q?UryUuwxDP8PBbmaAIJnN5vlMbtZBl5mbJmqn/oZNLpSKHttLCxUEEHLZ3UqF?=
 =?us-ascii?Q?dE+hbP/+nynwpMyexB+/zs4nRIpT68kmI0UWBWXCT8Gws/dX8/b+8FwTSofT?=
 =?us-ascii?Q?IFiJ5ho4kqhcmOFhJQz9r6OT0Hrh8Rj5E2E9xOQmomJ96p+S8wSu+8VY4usX?=
 =?us-ascii?Q?/hd3DG0iuJjtrz2xlMVyoiNNzq/1TqE4MRmA8W7whvvcqBvcHHhG7OF7ilVH?=
 =?us-ascii?Q?4Ne8Tx2lCxh43iJZUsPiePjkgEWv/VWhUaNo1VNBmX3XcVBO+raMt8LbB+Qp?=
 =?us-ascii?Q?uO3ZBR00bXq7M5DtJbLX+kbnzrBGVlVYkv14JWME/7MzU9G6R9cICyss7fX/?=
 =?us-ascii?Q?lDel1nTpjcfQvBO55Wum0iTxmN8GKIc74bbXjFRFVI8xMPcIgLFCkaaaYgih?=
 =?us-ascii?Q?FL8lqq+zXwgMsVJx1My92fhvkqWpaGGNY6nc0tpQLAHoNWQecHWOsHnp1ybK?=
 =?us-ascii?Q?qrBl0PKFYiLYLaQMIyCB1xXV6TwB8mSm81OOtbXIf6byInezO3QDkkpTXUEw?=
 =?us-ascii?Q?9xHPZsJU6PBHT+2wJsB6Qp8nAPx5cAgD06M6zQjuhrFimSTl3vtNS9Fe31GW?=
 =?us-ascii?Q?K/PWRN2qVs1UyiCWbANyjVToV0RUHm1AdQrL1r+eqSWq71klPTftvkrA+1Iz?=
 =?us-ascii?Q?ONyE+VR+4yWeUH+As03mmYVIQU4rb5U+Hdj8gBftfSijRtIib2uuRSWsrhxu?=
 =?us-ascii?Q?IPDaS0W161OpYrp6BzHAG0KiYed5ZvPf5G6A3FNdNajB/wML7icd3CczFHNO?=
 =?us-ascii?Q?wnS4CSW31trpaw1rEQeyqIWo49eu6xMUOhhcHQE8D7YgiuY7hi2C+x8C5rqR?=
 =?us-ascii?Q?ombN6kWV1sfXU3PeQ3QA1cUGUlP7dX371GgW8C7QxwRuvOSizWeoxZpiRGO8?=
 =?us-ascii?Q?a5daMOEWSiVc8yK49UuQar0x4HQNrARp1nJjUC153ga9hqp7CmDKzFsTkcUK?=
 =?us-ascii?Q?SmyGBizQskyZghOBwRqr/bO8IH8Ry2eZED3jDgxAYlRn9G3I1gBrA9D6rRHU?=
 =?us-ascii?Q?ebgbsHK9sZeBq9PYVRI1ETCw7gfp60Cy16CsWrV/jaWU5CnKrdShp5DNvy7l?=
 =?us-ascii?Q?n0z/kRTKrS8SiiCzbzLqp+fscZ9AP8tlLdpnTyY5vBinD6f5Dv+SbROOuFYl?=
 =?us-ascii?Q?f2VjNXpbTtR6ZW2NbClXt++QJPJsugK7uHLyH/AuSmAk4c1ufla8iZpUsmxO?=
 =?us-ascii?Q?mnvpxqObdy278X/DhcLekrNEfmTmnrApoH/fT4XO+/5LCfiDSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 16:15:04.0792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eaaf42a-e82c-4a12-e6e2-08dcf5102f5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

On Fri, Oct 25, 2024 at 09:04:15AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Tuesday, October 22, 2024 8:19 AM
> >
> > +static struct iommufd_hwpt_nested *
> > +iommufd_hwpt_nested_alloc_for_viommu(struct iommufd_viommu
> > *viommu,
> > +                                  const struct iommu_user_data *user_data)
> 
> probably "_for" can be skipped to reduce the name length

That would sound like a hwpt_nested allocating vIOMMU...

It'd be probably neutral to have iommufd_viommu_alloc_hwpt_nested,
yet we have iommufd_hwpt_nested_alloc (HWPT-based) to align with..

> looks there missed a check on flags in this path.

Oh yes, I missed that. Will pass in the cmd->flags.

Thanks
Nicolin

