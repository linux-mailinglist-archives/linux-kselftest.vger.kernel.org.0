Return-Path: <linux-kselftest+bounces-19590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E1F99B0DC
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 06:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F391F22ED7
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 04:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1BC12DD90;
	Sat, 12 Oct 2024 04:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rvh832T4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7456C27702;
	Sat, 12 Oct 2024 04:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728709003; cv=fail; b=ZyL+nEdQqv4PHBwiFgWWemkOWlxcchsoXmyuEUImiLAiiW+V3OMIom8JfNgahgg018m0nYouJkM1L4nOX05DTuXjOS6NEcBAb289GwM0isC7b42LR8iLpMcUY3e3Z8qsSrsuWXtqXmqvZRzmBt4Kafv3WRiNIb05dPQFuPZkZ/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728709003; c=relaxed/simple;
	bh=8UGbL/4+XtkZsfy7tdqr68u2gl7CpyaN++YJdB4dK3U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J22UOJFYu8DeO3Y508AM2O1uWZWBqF7dRG2fjlWzyUgvymmTTBzNsL4oSImewEF9mQrvRW3JMRmJ1mah9oUptGnmT8RnqgwKoU57Hm9KY1nuKNHqi6kImL5UhHtYldKLzfhT58JkrqraLbzYKakJlhJBG5++lubQ5kUIT2MIBvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rvh832T4; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJhvhjUZUtTTpsx8C67kSM32ovIHEBw0i9mg6Q2KBs4/T9in2gjW9RmFGYQi3DbAgYFIYkkwayAi2WmMCxVvqMbqOpO8EI3azb2ZWC31rAo9hy4QxlZtr91UIaKBM1msEI5hts53osqYImd9BVpLMyjPLl23o24I8HPB9rmIy5aRt56sa6zvP5+8Me9IC1GPiX1k9sh4AG+JDDEvBfPLYMbRB+jNyVFgw0cy9WRKeVIxWSDGn9lYeqQVYiV958ZmRBDbk/weVW7i2JnNrVgcrs9qPT0PY/3qNkU/SPqE/gaypI79YfCiF60q0uCmbfdmXuuCBQsBtve2RVNn1uvTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GrOwLyfIS97I8J5B6KE+GSTCG3rf3UHVkzsxHAKe84=;
 b=zO2sD6GJOufI6I25KcrZi4A2UgMbVNDyrydVHzDJyRCuk0s08N7ySjSih2e7BVJ9PpI9PtkWLBdaFJ7KH/T2qCKPv3Z27JOCeYc3CLEou1Y4a7qEY7v8WvjKKjp7mjWXM/34t4S6zjKjyunvFIHl9ExOwOHjMEXGqGWKEnW1A6LEoEk/VZsVLZYBt3LAvV805ICz+EUcuOnt1CFwNBohLOGbkKOuCLldCwp09SCSnIf/XR5teQgGY13Nc49HQXhAn4nk9dBbiBDRrm6eZtWoLngJ49c63yccSsIBqneVfwZvu4KvpHKr9/br2DAlkDkSIxPImFQi8Y7wys3yhgsTRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GrOwLyfIS97I8J5B6KE+GSTCG3rf3UHVkzsxHAKe84=;
 b=Rvh832T4kjtEzL3GZ2FfuvuMjg1QsqJY0uBQeCm6EDG5RbE6SjDOQ5SRTkNvYTrJC5ECMSErrS/Zlsibpa4PtBxtyAA7n8fY4mWimWfkwBYi1nb5ZqjpWEE6J8QYStt4XGKjF89csBKxaYfrQKfegJSxesDUR0vFsBJsD5DaZet/Xv6Qekn1oDRHN9+VNqYvktD0ra62jzdbPD+Pu4LGGdgjty8EaUvTAjLvS/F3gd+efjOG+8HLIJNUuwM6ajmpyUVjDTZN6OpTxHYoVKoxj2h5PbIlzNXXGkYgcyAtvKXpVj6OmHc6SxsYV52eQ+AveKY6D8i6IGepJWbDoivMeg==
Received: from PH8PR07CA0041.namprd07.prod.outlook.com (2603:10b6:510:2cf::29)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sat, 12 Oct
 2024 04:56:39 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:2cf::4) by PH8PR07CA0041.outlook.office365.com
 (2603:10b6:510:2cf::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20 via Frontend
 Transport; Sat, 12 Oct 2024 04:56:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Sat, 12 Oct 2024 04:56:38 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Oct
 2024 21:56:21 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Oct
 2024 21:56:21 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 11 Oct 2024 21:56:19 -0700
Date: Fri, 11 Oct 2024 21:56:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v3 14/16] iommu/arm-smmu-v3: Add
 arm_vsmmu_cache_invalidate
Message-ID: <ZwoBcm8XRgn5JoRa@Asurada-Nvidia>
References: <cover.1728491532.git.nicolinc@nvidia.com>
 <d714a9d107696194cc63e5f6c2b6bf5877b37f68.1728491532.git.nicolinc@nvidia.com>
 <CABQgh9E1rfA8i+x+6VRgyFb41n+n_F6-gqnT-TfqLqVeYaYmew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABQgh9E1rfA8i+x+6VRgyFb41n+n_F6-gqnT-TfqLqVeYaYmew@mail.gmail.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 311e08ca-ea69-499c-cc5e-08dcea7a417f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8A2vgnW3O4ysfcmqzCA5Q8YPH51LWJCdrxAQHA0omOPl8Igywyd0bWbMJOwW?=
 =?us-ascii?Q?PCIZnGfUBjKoDkmIeP47KS6Q678pkub9ELrjjxgQ63c8KyggpZeOSrxCZLOW?=
 =?us-ascii?Q?qJbRn8oRvimohAk8y1hZ5ViaGD0zxXJwq5aGYawk44629ecuWQsG83oyBgVL?=
 =?us-ascii?Q?vSxa/atLPzFax3N9PsUs4Qp1Qkp0rGVBVlN5mxdxWcoki3XkfIaNdIWqE8RQ?=
 =?us-ascii?Q?np/Aezo8B9aAIdIsmTDXFPZywv+cVAvH2ICbMs+AFOPy1tPfsWA+Puae94aP?=
 =?us-ascii?Q?W9ie41hocP83rDI5g7emwr8f6DyxR4GaKRn/+kZUaWGFOf+yGg3J10+91JWm?=
 =?us-ascii?Q?vfRB2cUzk+Pbr9lbjucsnK7Zz9bnzvifP8edVPMb/o5xpa7jZAI2dWbhtNqi?=
 =?us-ascii?Q?CvX8i31c0gCQWbT7RklhmLqUMFZi8wEEBUoM1HXZ20re1jYadSp4udoxL65W?=
 =?us-ascii?Q?12q/BkNMpGgtUVf5sWkGUxkuaoo+ac+0a5pUDZM4UMlSa419VlDyMAzBCEsv?=
 =?us-ascii?Q?/BCzH/cMxQGTLnGTIu8HDUEL+Rn6WbulL7MPknptbgw88R7Zo8pSthRMw4La?=
 =?us-ascii?Q?nxO0waP2sEUUFrhjijmFM27294FPH7G9dIsp8u6VUrcluuLgsT3BBHr4aaB+?=
 =?us-ascii?Q?eho5FmhoitlkTSsmskGsDpAxoD3TSk+10MfEMydT7erh/ak+g2EEKMtgvywJ?=
 =?us-ascii?Q?cn1uQ/Fb+MiRZDPS/0Ww73pkK+g/ZL2p7w1PvUPaJHPNR/9DdE423tublMQS?=
 =?us-ascii?Q?9unNQl4rnGdFdmIlWPpD4zvcFXNSv+V5jE35Zyd9u0LH2R2ILT4sZXAz5zMi?=
 =?us-ascii?Q?IMH0JO4HAoHOYmK41Yg3M+UruawOuI2qRpcNH2pFp86J62hNIQHLP/RIOvcn?=
 =?us-ascii?Q?wstmHoLxaqRETECeaHlZcMSelNBNTlu/JzoWmPGO74jeWkJenz4rfYQGtZCj?=
 =?us-ascii?Q?H0cazL74Hs5i2rlcavWTHyEX9Ii5dROqxfNqVAf/YtCaKfFX7XWOF/JPyn2c?=
 =?us-ascii?Q?kq5VQKhdvE7vp98WOOZ2y8Z2U08bdeH96qJDpDkDTrnDmANj2b12+XmjnFfj?=
 =?us-ascii?Q?X0RFDlF3MD/FiH+kLbU3ZcqOr16gBpc9VR/cnIqzx9bSoDbwTSnzBKboJiz9?=
 =?us-ascii?Q?SCH/IGPdOTzR8bwfevHp/WogR8wXz/uf+rauS7VPIRWSd2ak/wD3/gRN+Vve?=
 =?us-ascii?Q?xO0KsK13v81Rm3C2QYeqBULUR49XPcd6HRmhcUWfg9l3kzLoxTI1x2bTSXvM?=
 =?us-ascii?Q?2gYCjr7p/SabQvtlkjxJbgVHsfNEW/ABWFh/axKAXshY8rVJOu1616K3tvaN?=
 =?us-ascii?Q?rMHW/hKXlWTTOUJ3Te4ymYsnFsTVE7WTM49NCp+lRWEsKE+7GbJQgra3W5IV?=
 =?us-ascii?Q?x9xxZO4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 04:56:38.4165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 311e08ca-ea69-499c-cc5e-08dcea7a417f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575

On Sat, Oct 12, 2024 at 11:12:09AM +0800, Zhangfei Gao wrote:
> > +       case CMDQ_OP_ATC_INV:
> > +       case CMDQ_OP_CFGI_CD:
> > +       case CMDQ_OP_CFGI_CD_ALL:
> > +               u32 sid, vsid = FIELD_GET(CMDQ_CFGI_0_SID, cmd->cmd[0]);
> 
> Here got build error
> 
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c:302:3: error: a
> label can only be part of a statement and a declaration is not a
> statement
>   302 |   u32 sid, vsid = FIELD_GET(CMDQ_CFGI_0_SID, cmd->cmd[0]);
>       |   ^~~
> 
> Need {} to include.
> case CMDQ_OP_CFGI_CD_ALL: {
> ...
> }

Oh, yea. Will fix.

Thanks!
Nicolin

