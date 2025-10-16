Return-Path: <linux-kselftest+bounces-43338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE91BE4342
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 17:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E970F4E906F
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 15:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683232D2499;
	Thu, 16 Oct 2025 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eBOZSI+m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87414C9D;
	Thu, 16 Oct 2025 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628156; cv=fail; b=boMmrWdlGy30L9gKTuW7HeZXJBUa37OYMui1PfxJOY2VUpC4r11tleMPySFYm4gD2gJqzGWUjvfZ4s1rzyBvXvHPeh8FdDHqoDwojbvPjDuu1Vwq4NSta3HnGPf5h7K5hgnmmUZxJ/mjJftvlB9doe68Q/oq99QuySZwXWd0vCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628156; c=relaxed/simple;
	bh=4pzezHOOI2aPcvAb22U11XNZHKdn1xtxhpBoNOf1p3U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpPhFiE/b62uhZsWPIJmW1LSA/guFRmGc9r1/ulIUMLUrnbCBX41t3XHX4dxPuEtTdW13abwV0yfnfw/mk+R3mZpk8laKb50r7/Nog14ozkOtmzG/R2J9klVvjjNimS1z2mLJMvSCih/u8eISbM7WLd0lD5A+xNAeFgipgRbtaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eBOZSI+m; arc=fail smtp.client-ip=52.101.46.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0CS1bVxkCSD5JbSLWECCgPb29lFiAbr0BYqqPbvn6WpjcgI/Nn2Gxq0pqHoygyh9ZXwyYqlH3BCF0zijwR7UHkiGw8OTQZJ596FH2WR58pkylEO1Y3fAGDR5vlPPELGGWyEmS3472KBTZwQQN+/YsP34tZC0gsdXStpqDHriS5s7XHXfJLdjaYAXy4a1ebvlLoi5kkFn+PtEfEsJPnF4q77yREHdpsBZWQRIXfQ1251OxWAOs82NejgBga/BHU5fdmLEiFjtZpAaBrUEWfx3+lJ9h5LL1rFVBXpM5Kj+K1ALJXs3RDoOp8r0Y5UU7JTsIdpAgNzClVTBViP4TWEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8tYLxsfCD6uVPBGHv6AcKUvMSDzwj2PAo6zQl3bvEM=;
 b=MwxhdTv9f5vc9rDX2nB54gyHHAdpDwOtxJ8RL2mCGXh19inK8IBsA1gOH/zBljD34eOQF8lpYWjQ7Nzs41/iwGH6f/T3iMiYW+awxBdrpufm51T6X5dF0HkgvOrbfOvndSmTjVxbtvMr9ncfeTzrpG9WSJiPYD6gg7NNW4WqHB0QhipEInUV4rI+m7u6Ir9fhFCYnCrs6U9Fuv8n3PVouj85kZgr/3g0ds4O75ifn6ULU8Ep9N0efQPZ/vaLuDzERYOOWlcgmak5ibUsrcjyar4E+RAAgSAlb2efWno1vc+LWu3yVMDGW67AMcVVKIYuiVj9FtsyiWIvpr+nKzzg8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8tYLxsfCD6uVPBGHv6AcKUvMSDzwj2PAo6zQl3bvEM=;
 b=eBOZSI+m5RaB77Xc1IbopV+dcxrDgPpX/z5foUvAa/JOgZhQtQSAyNsnOSb7R2aj3Emo4toPkqpH4j5ZFr2FUV8agN+5bbpLMI8l509PsIcNLOPhqG3EAGaN5tpbNEiiYQkavYyIkf7PCNnkENi7urVCa4RcokARNU7wJY23N9zEc/1/mYgH+DZfv+RiGDPCzUtf7E2TNn3MZzIRXIyGiPXgyNfa9fekzd+xyIv4bgeZJxGV9VKXCSbcOjht0dFVKapj9vkYR/OMTLEBXS7bcsSB3ijYgYN63DD6gY3FKh3BSI0pJ3yR1mHLmVH+TRfnb9UAvYAzvBXNSfoZN43jqw==
Received: from BLAPR03CA0129.namprd03.prod.outlook.com (2603:10b6:208:32e::14)
 by PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 15:22:27 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:208:32e:cafe::1f) by BLAPR03CA0129.outlook.office365.com
 (2603:10b6:208:32e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Thu,
 16 Oct 2025 15:22:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 15:22:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 16 Oct
 2025 08:22:10 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Oct
 2025 08:22:09 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Oct 2025 08:22:09 -0700
Date: Thu, 16 Oct 2025 08:22:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Alessandro Zanni <alessandrozanni.dev@gmail.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "alessandro.zanni87@gmail.com"
	<alessandro.zanni87@gmail.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc] iommufd/selftest: Fix ioctl return value in
 _test_cmd_trigger_vevents()
Message-ID: <aPENnxVR+wtlGVAJ@Asurada-Nvidia>
References: <20251014214847.1113759-1-nicolinc@nvidia.com>
 <BN9PR11MB5276834E90A7990269EBBF608CE9A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <gn4l62kroj74d765uojx2vmu4tugxbmwnhodckfbath2pafeuz@nw2kudzcucv2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <gn4l62kroj74d765uojx2vmu4tugxbmwnhodckfbath2pafeuz@nw2kudzcucv2>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: ee92dad4-846e-4d4b-007d-08de0cc7d08a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MHFccf+jbshrJ3sWmh6489mDLd4A2VolxBf2RxMyIR89SUsDdkZ4tmFe2Nxt?=
 =?us-ascii?Q?ETGbuRnARTgjkvbiVMcwFqJGRotVL58XIY6tTJHwHS3+nWQe8hgT8km0fD/w?=
 =?us-ascii?Q?nNEwYfJmXWoI19Cqtck5lPfyekdhtcPZYQqpNlw0BYcEanbTesWetOq1tIHK?=
 =?us-ascii?Q?SqGiHIYILValWFzQPhXrZudCxhQVhcyInsMLGc8u4h5oODr0ZIoShvKDrno7?=
 =?us-ascii?Q?G3t4BwFztWAyPnUQxSgMuu8spIrmuqYO+X+d5y9FVrOiG04cyQMT6/DAMdPn?=
 =?us-ascii?Q?e/wnLD9gTEZG8zIYuzeiUrfWY3O0FXVINdUYUn0guEzPaj6fd1da4xNRMs0Y?=
 =?us-ascii?Q?bVvwuRomIpUO01/4YHE48uJPijSuOaRruYOllR3jTEHL2o4f2nDUB2reti/Z?=
 =?us-ascii?Q?q0ygwXeWfAkJeXmlLOn7cARWdcZlwgtTNmeEGnhY8Nv1WzoHpIN81k3V0iyx?=
 =?us-ascii?Q?XM56STUsnHjLfcldBA4DWxYrBoT1/j3WJDuh0iP0XfoAZXvSGvfhxCLNOVsu?=
 =?us-ascii?Q?zzViHj5ErgmB3iL8ymdZSZPGJ5jaAKk+Ix1Wbp5WSTBm6nwm2wFsh60Vj+cN?=
 =?us-ascii?Q?TtuEAiAB48a2dFov43cgwUf2+oW94wMdn/IcKDjRMq9WCq1IeTDJpQLEFf9x?=
 =?us-ascii?Q?Yyl1//2ARo9nGTDXrIs9pe8dje9/SIuezYitMneiM+EVZliJ6uD19z20Rx8T?=
 =?us-ascii?Q?Hom1yk/m5DvFwkFrWtRjNcuWOiwGfAuHc2xA45vtz47ZJxLHDUGJ/7+FmCoH?=
 =?us-ascii?Q?pKlj2faF/2YGhkXIkrPpnHfTp1YV+OCyh0i3jFIUfw3L/VbWt/JEbJz8WKsd?=
 =?us-ascii?Q?tj//oBlCHOnWa2kSicZbxe91V+JLtuTNb8tgOmzuTCFImLb462o+I4hylNEg?=
 =?us-ascii?Q?o7g3H/vldYhnC98vrEeQMgHiTPx4ZjLUFC+JqPfhKTCArCpSJo3/IsSj/wvz?=
 =?us-ascii?Q?WvhPfU8sz/nnGrsUCCFFmSzwx/Zu8kKzru39+xjLpeSAsiCSz4aOY6IkJMgt?=
 =?us-ascii?Q?KhOBSpegyzW9uu5sbS5HrrQiSlqysZ8nCUyjvklRA4Qn052WQr+fBu9o785q?=
 =?us-ascii?Q?L38l/2r9p2NFNX2NCjwO7gVVzLiaIpq+P569Bqtw2cEmGkQtItm5XW8etXZi?=
 =?us-ascii?Q?47khkNmeR8gbaI4QBLIbRDNP6Y7tk0qETo2B/N22MBqIKYPAlBEuLU87Xjww?=
 =?us-ascii?Q?kJZOfpJeoEf7PIJJD4HCRbl7CG87oHUuXRcHvqHiFWhBNmSpNHrSow6duEKu?=
 =?us-ascii?Q?cO1qQIgwDZeb+SxmDUD737x63A86Ir7+zhrD2/j0v8JIOjLRHeoh4iZU9NzR?=
 =?us-ascii?Q?VsLYihVizMSxgJniEdqVYWs+PNFNwpTLz9XwNj8RzJKPdkV2WbATg40wQfJL?=
 =?us-ascii?Q?qn1ua2yne2EdFMHo6Wvebm8wTBpq6QGEGz+MMlS3RMtVZA7zaqk0mPcyJ8UM?=
 =?us-ascii?Q?4NKeZkQciFBy+Hi58itW4Cpb90HHndIi6rWYiwzQcy70rSejo83glp18EvTW?=
 =?us-ascii?Q?nwONiTG+JZ9Xh5WhAyuxHslx6kK/zr8G2dszw4NwilsRjBzWQbilrB7DXZrt?=
 =?us-ascii?Q?SlU/PjG7sqkKx/GN3xI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 15:22:26.8029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee92dad4-846e-4d4b-007d-08de0cc7d08a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761

On Thu, Oct 16, 2025 at 11:09:59AM +0200, Alessandro Zanni wrote:
> On Thu, Oct 16, 2025 at 07:47:20AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Wednesday, October 15, 2025 5:49 AM
> > > 
> > > The ioctl returns 0 upon success, so !0 returning -1 breaks the selftest.
> > > 
> > > Drop the '!' to fix it.
> > > 
> > > Fixes: 1d235d849425 ("iommu/selftest: prevent use of uninitialized variable")
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > 
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> With this fix a positive value returned by the ioctl() ends the loop and returns -1
> to the assert.

Not with this particular ioctl(). And in fact, I don't recall we
have an ioctl in iommufd uAPI that returns a positive value. All
the other ioctls in selftest check "if (ret)".

Nicolin

