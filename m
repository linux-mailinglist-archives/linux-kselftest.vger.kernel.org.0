Return-Path: <linux-kselftest+bounces-31955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57710AA3B95
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B53D3A4BF7
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 22:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23A62750E6;
	Tue, 29 Apr 2025 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F1wPcxDX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057A36F073;
	Tue, 29 Apr 2025 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745966268; cv=fail; b=cBktnffFaOytqfuQh8VAWtI9qqdxrpBq3DB9yMOsEjQ/FjkfaQo6i5NlNBeVx8oC0TqRb9+ZTFBOGYXg0UFF65gD9mp3da21DGUKPSk3WrYB7puhHM1e9nvfkAvFU5VIhLf27xpV0e3yKZVWzKTB0lr0iKNzRam7KEkCAC6lWtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745966268; c=relaxed/simple;
	bh=3FNGwP58EP5fRvmfbg+64yjwbwVo/lGT2hI2Cs1JCYo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYOctHbm95AH1CJvzwQTWxrSCkd25G9mAmdm31e+BdLOMDZlcW6y+MNeHnjT0p+SIOv4JqDF+J86wm1godMwU4MHU4pyQ7sFJlZtj7pP1JkvW6LqK+r98TXKGacI7mvKE1ADLiLrNAWDQtOAKoaNOBFwrbCPaoNCDnBDTa6E3fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F1wPcxDX; arc=fail smtp.client-ip=40.107.95.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7T9ozYgDy/RxeF72mlMH0kKq33mDi1PJjc3tXksf3qFvNmFLq/lBQZtszecE3ST3SAm9VnxoIsaHv8+4YbsaVezBD/frEFqRKJ7R4Cx/1/G0EZZ8bzvGu8vWWxI18I+XcWYIvUYHtEwStrZmHbee5c8J3TL/MmtpOqAuipnFFnH3pKrLmSrvLWRW1XJbbQUHmgGTwrszPEoCDj8q5Wm7TpsRbGnluFDa5rcV16WaII5F0rO/qt/qeCw/rqSabBXFeN/ZF8hqaqI1AujqF4LPIKF+md4dZkqdz6DfTScMIvZUxvyw3+b2diS6Y4a7faMC8c7RAtTEQqYBgrWCSkbag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MO2zVd6uiuKR9fHteSEBTCaG2BHhQGEM/JyJPwKPb7Q=;
 b=H59P6y2BN/5LROzTQ5NsJ8Ymo8OX0FSw8kG7fr3pRnG/Ymk0JAIeFCUp9E93pySmEHYseeSR6JUxnNM/UfLu050orzynkkUX5W71rvFzVnTb88d+rhikeArj3CGmcBosV5CesM64hwDRpWa421heJqZLozxvHEcTQ+aONveT7XpV1WhpwdpnnlIyE+VXaDQ3oNM1WBtnzcSeZi/vc5ld67HxTq+RrxCooGW/HAJpDw2LIZcPexBuhqqpd/VX7EF5Vw5ByQrCmaVx5EJVfc1md7k/YoDvx3CWjq2coQjJ7m2F6wkMs/6qh3gtEXpiTetIUvOHJbopI2+0Yeb5bb2x1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MO2zVd6uiuKR9fHteSEBTCaG2BHhQGEM/JyJPwKPb7Q=;
 b=F1wPcxDXgaUnDyiOA0+pvFLrCVOUcCUl8iNwBePzDw2hb6QQn2mw5iD1/uNxkmY4hByUuC1WLA99B0Vf1J9POEsqbxMS/a1Tdu9AjWVZ2ADQz73Ifc+kghkfstiv0L+JJIh10yR4xqdTSxjTuePT9b04F6+YR5fNv0wrlwf5wcAW0rlGun4mmTNpHyVmQUUUy6OTyA9HVM68PbKl5eLdZWZHGf6b21Y2niQb22c1c8syLAcj4WeaXJ2nnPDiNZgLL+RoY9Os2Hz6owwawang7hczQH3adp+5ykJB71fKjoPSfW+pBYRuFBPi+chAeDX39xE1fA9L/q12+sqcrg/OUA==
Received: from CH0PR03CA0366.namprd03.prod.outlook.com (2603:10b6:610:119::12)
 by SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 22:37:43 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::6a) by CH0PR03CA0366.outlook.office365.com
 (2603:10b6:610:119::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 29 Apr 2025 22:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 22:37:42 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Apr
 2025 15:37:33 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 15:37:33 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 29 Apr 2025 15:37:31 -0700
Date: Tue, 29 Apr 2025 15:37:29 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 20/22] iommu/tegra241-cmdqv: Do not statically map
 LVCMDQs
Message-ID: <aBFUqR/UF+20A8s6@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <3981a819a4714b21d11d5c6de561a2d0c6411947.1745646960.git.nicolinc@nvidia.com>
 <aBFTc1Q1r_jrnJ63@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aBFTc1Q1r_jrnJ63@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|SN7PR12MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: d67d7edd-ff0f-4a33-a4bb-08dd876e7477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+a/970f+uQUAg1QCAxLXtladuipsr3wlTBVC2DqHSg5FQYNDxN3v3neyVw9i?=
 =?us-ascii?Q?4MloCLVC+texqoIv9c904ONnXfDPtnvovnGl6Ey6zAhWVUTCmwYRV3doB31m?=
 =?us-ascii?Q?0iz/TvrHLv0+7lAkpznLYFCLZLstuujD+PXcWfyNbKSd2zkQstcqI6tQWhpZ?=
 =?us-ascii?Q?fG3/1M8q9DObYgcJOq+ycOfL0EBdnRrXDLbh4EKlrufeqivKSNFcitiI4ZZs?=
 =?us-ascii?Q?BlZCtfUSsmuy9osJJHgf83/47XEixfXs42pobcuUrTzCPQrXAfisoxLDenSN?=
 =?us-ascii?Q?TtEW1wKP5Omt2Ii+I0aUXo0egeGkHZj2KJDojnPIXBzYhDkW7XY3Ixk+p74R?=
 =?us-ascii?Q?TDbRsJQicD/UJc9QGKCds0Q+Pypbr+7fxilhk+QmX7/yLZvvW3Q/dgEvrdGK?=
 =?us-ascii?Q?aoFXTNrFPH0vBJAcuEEjt7aWg9yv2HoQr/bRsvhuBEYuOfPiysXCWdz9MrpQ?=
 =?us-ascii?Q?FW06ihYIzZWRKsUWM2BWoiNaqb5t8z03j7cmPKZFe8QPiCxjH9mV04T9Fof8?=
 =?us-ascii?Q?aS5Kx6MldC4Z3BPzUjhQCjNRfMRzcLn2/cimt7FAyf5hD/5u0HOtyYJpXuwT?=
 =?us-ascii?Q?MoNchnwMBC5oAkOdrK/u5dBfgv1RJdaqIBby34565PFm6jZQLJjwEhN7v/3a?=
 =?us-ascii?Q?k9EldD5u02a/qeWRueCKd2ga17BR+CvunQwC6g0AbPzf1dAIf31maEj35lh/?=
 =?us-ascii?Q?YDvCX6qKJTJkvZQR71D+KGhNPCEYn3hIp3IboVE4W2Bc9uRbh68MzQPVE8Xs?=
 =?us-ascii?Q?hfmMRjBI3u2vk/nwbAiJE6jMsGAKHKy8uCK9+6nMjG3X8uiJmqkWig2Xx+uQ?=
 =?us-ascii?Q?ysKVmKNyzmyjFMLQW0Yd5sHz5MMH/obOM9Fs7FaT2cCWUel+kR62+b09jOZe?=
 =?us-ascii?Q?rqJdWI80Icx0q34Dr0sF4wfz0cXgzrgPjDQaos7psCg/C0cz5WTGTKCWGOox?=
 =?us-ascii?Q?k78WXLtsrEHC8iBt8ikQc28hutfARwDQdiMTZZvR4MGuiIq2zNAkA/chRin4?=
 =?us-ascii?Q?/MUxXYUWD0p2D/B3eVbNwuZlGeANaF5oUYItOGbOhizthIgDPNwuaHq4cKL0?=
 =?us-ascii?Q?I5g1b0V2ZByAcsVrSujGV5h6cqGiOecA9GCWYYpx6AnPXLZPGIryLkHv9th8?=
 =?us-ascii?Q?Gw63KFL+LMR0+BSzMjEj3mDLDECfKnrw1G5dkyR6mukW6SFRgn7aY3/Bwzq9?=
 =?us-ascii?Q?/e6dSd6325WO07sfNieE6smJmh+e4308DXh+EHuBb70V6rr+go75iIH6/uE6?=
 =?us-ascii?Q?Xcdm/CZgTxTtG5hrkc5vqUx/FkatR8vwswtOBS9Vj3zfApo2st7vgvQ75KvG?=
 =?us-ascii?Q?n/GKu7lIlLptEjMC9wfj8ZFwBaFy0erqKOCz1Gy7Yyv6ITLcctucqrJcPMpc?=
 =?us-ascii?Q?3DMEnuIlIu6JkFsG442vu45U0FpLU01S3rucww8K4T8lCB5+lcQFHPw4GVne?=
 =?us-ascii?Q?0TNKZFMDX0Bn0ep6/XORrbd+Ib93PXq3Akx7S9WFJlA7PUNd2KlTx/KWFPUo?=
 =?us-ascii?Q?jCMCktDIYFjE3cGLo8Cdt8KVc+bgPHS8qatD?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 22:37:42.5071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d67d7edd-ff0f-4a33-a4bb-08dd876e7477
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371

On Tue, Apr 29, 2025 at 10:32:19PM +0000, Pranjal Shrivastava wrote:
> On Fri, Apr 25, 2025 at 10:58:15PM -0700, Nicolin Chen wrote:
> > To simplify the mappings from global VCMDQs to VINTFs' LVCMDQs, the design
> > chose to do static allocations and mappings in the global reset function.
> > 
> > However, with the user-owned VINTF support, it exposes a security concern:
> > if user space VM only wants one LVCMDQ for a VINTF, statically mapping two
> > LVCMDQs creates a hidden VCMDQ that user space could DoS attack by writing
> > ramdon stuff to overwhelm the kernel with unhandleable IRQs.
> > 
> 
> Nit: I think it's worth mentioning that the current HW only supports 2
> LVCMDQs. Since it's not clear from the driver as it calculates this by:
> 
>         regval = readl_relaxed(REG_CMDQV(cmdqv, PARAM));
>         cmdqv->num_vintfs = 1 << FIELD_GET(CMDQV_NUM_VINTF_LOG2,regval);
>         cmdqv->num_vcmdqs = 1 << FIELD_GET(CMDQV_NUM_VCMDQ_LOG2, regval);
> 	cmdqv->num_lvcmdqs_per_vintf = cmdqv->num_vcmdqs / cmdqv->num_vintfs;

This is a SW choice. HW supports more LVCMDQs than 2 per VINTF.

> Or maybe, re-word it to "if user space VM only wants one LVCMDQ for a
> VINTF, the current driver statically maps num_lvcmdqs_per_vintf which
> creates hidden vCMDQs [..]"

But yea, this makes sense. Will change.

Thanks
Nicolin

