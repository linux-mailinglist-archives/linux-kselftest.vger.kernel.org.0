Return-Path: <linux-kselftest+bounces-37584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D5BB0A9FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 20:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420D33B29DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 18:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1759A2E7BD3;
	Fri, 18 Jul 2025 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CR0JW46L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B5F2E7634;
	Fri, 18 Jul 2025 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752862253; cv=fail; b=C1kxVmdKDcF2wLxI5Ao0m2V/E4vvIvkRe7D3TWBW4toW89rOBKCEkNOUAWO6e31plmlyJWG/vvIFXm07ASswkrSI9m9YELvZ5FJWdcQBXX83JeMh6VnpPwqi9nk/J7xl2UWO233JRSQzjsrB0byoTzBr2v7UQLlbFt97FMpgdnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752862253; c=relaxed/simple;
	bh=SWLsfajP1nMwpOzRNYwzSt02sOMDEf1P4QIhQ2aPCpM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPSv9ucngVpujdandMh4dSrX2uIEzv+RahfxHsvGfvZKRczDzheenZl/VJFrY+IFot6ihdfOcP0RYCtPLU7V2H4XBShx2oVYJ1MWVEGispiL9ld/19y6CheFjncR1TVNd4+M2LxtAk9B+/+/vX7IG8xUEBViY0iieVRJsmrSA2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CR0JW46L; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDiIjfeNKX7e21PxWT1JV0OgB+vJ31BpgWFzQW/gVidn2XkJukwu8wXGLF7SihtFp84RKGisIQjWDOyAW1B5TJOSMzrpnv66uaGKOKQdA/fHCKZsEHYH1b75E1Q5EikXXdWCXd3bkD7TtD8Agr2XlhLLyiqS1k+Mb41m/bwgFtzp8NQQwzWMWFiKB9IGYMHElnxT+I5S8bEI7ecskhSErS799NoOFdp414tz+Fv3GgR8L6OvL9/EKRLAngdY3LoSD1nGrCt0Y8DNTKnczl36t/S/Mm7lW+JhnLJG6QuzbuUQK3/uk3WbFsiSzrGR3I2qCrmWUMumiJPFLpNs4GKmSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gqx5BuRv9k9P/UT6Wb9iJAq3QVTkrS031m59kDRYAGw=;
 b=m7KFGnGlrqfxZN7UVJGB9BobYs+mvzoEORqY/soEIjSQpNVNVGgTx723ReQTWAsh+VHd+6hyKA/83NSX+5DnzIQmQ9hUM0JXKBlwlDFFBYxZ/+q6v+lDrnIgAJ5DXzdFBKPdgNN8H8PMk1PydbrOt7HymYK7V0Oe5MO4ID7qB+GQ90YH3HWCambztLvtLhsInwwPc4WIsFax1yeiOx5//0xrGbN6sCRM4MlPs+A56fjPpLz2oVW16dTuu3dHJziL80FqbZlAn/0QF6rp88XcGw6UB3p3/3NJy2IV/5E2lHtSvTjGv3oAMSMdSG3UetNgpRMMTYK+Z+9NexgLP785Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gqx5BuRv9k9P/UT6Wb9iJAq3QVTkrS031m59kDRYAGw=;
 b=CR0JW46Lt6deArZOSWp0gqUjcWDkzgfkc0EVc3F2uMmhdhew7bFSvHheWZBzi5C9+jqQX9fyGcXeeooRNqHF8Mtn62n7Ccth8yPFz/4RhQYaZbtPvI40o+7G5pHat/Dmj8M2WxOP4I6JcCWOPJJU+t+oVSjXYY5SGcN7iY3Or2SEr6NkeBRtlyHE1WwWEUPPSHoqWtFQ+1dRnNfDLVhOuT4aAUK3h/zBgRAJNu/5wgjlDm3xDAvcCww/IqI24ZTkDMOuAYLQgHAWozlR4EYOaNT7gcrqZkirnPrvPeApMijO+9r6CmikQe75yuohotrG4hJ7LMs4Ej/IYXWB9uWU0Q==
Received: from SA1P222CA0037.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::18)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 18:10:46 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::4d) by SA1P222CA0037.outlook.office365.com
 (2603:10b6:806:2d0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Fri,
 18 Jul 2025 18:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 18:10:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Jul
 2025 11:10:28 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 18 Jul
 2025 11:10:28 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 18 Jul 2025 11:10:27 -0700
Date: Fri, 18 Jul 2025 11:10:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, <linux-kselftest@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Will Deacon
	<will@kernel.org>, Lixiao Yang <lixiao.yang@intel.com>, Matthew Rosato
	<mjrosato@linux.ibm.com>, <patches@lists.linux.dev>,
	<stable@vger.kernel.org>,
	<syzbot+c2f65e2801743ca64e08@syzkaller.appspotmail.com>, Yi Liu
	<yi.l.liu@intel.com>
Subject: Re: [PATCH 0/2] Fix undetected overflow when allocating IOVA
Message-ID: <aHqOEWe1Babqr3Xq@Asurada-Nvidia>
References: <0-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 112fc91a-7ce4-40ec-63d7-08ddc6266afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?flRamOYnijiy6EIq4QkTxgmea9H1hlRBkENsJ7BpmzM7M1izg0FzJGAIBvse?=
 =?us-ascii?Q?HeSAihiqnlHQMEpD7MZs1mXk0dJQnSnjnWHomd5u0/9IL2f4p/Y8x49cJqSE?=
 =?us-ascii?Q?+EOFJt7/K0iEfblfTC2CAOtjK1lYKhKTev3UlN0Rj7zvzqMweOmCjgZ7pHMH?=
 =?us-ascii?Q?sjVuUZ+2nf8FHx2cLqOzYzPmgptxpvK/Xt/63//PCU2Xb7pzM2zxP1g52h4I?=
 =?us-ascii?Q?JcyjTU0MqaH3wAEujywmMgnYInfaIvdv07G6gUCD1jAC33gWEmq14vautHjt?=
 =?us-ascii?Q?X5xY3zUqzkAZ6d5VNyVZin4ejM5HTnnj6W5sFJZV0+22ndF4RGE5BqRfnx6w?=
 =?us-ascii?Q?Dsj/kZPE4JQwSGvPe7j/GK5SfJkO03364a4bo/kMGqZB0GWh3Tf7Uol4hH2/?=
 =?us-ascii?Q?X1LMSx2ki49w03gSBAgFej7N48OYKpUMf0VqZUpudV2I1IXB7p0FiSp60sc7?=
 =?us-ascii?Q?85ZuDNPjhHlk7Ppg6qNh9a55NS90LDZK90C3P+c9cfPIP28mEdNF8yZR4VUf?=
 =?us-ascii?Q?MVaUcOJFD2B6J1YXO2T9x0wkw1w7h6qtkyO6WUaVgXGL8luPM/QmMF5ZZJSa?=
 =?us-ascii?Q?r87OltTCdiv9m3IdPHPlMoXl/huDrUlp03aYOcll0EFC3sccJ8LDQSl0uTm+?=
 =?us-ascii?Q?V2+OGbZFW052/OHZmbuOwicLxKDDAHGJvhheu7zFoMqZohEk4Q+XkUGrO9l1?=
 =?us-ascii?Q?c9aqaNVQBOheIqy70JbiRdGGKp7KXj1IsIPi4ddpIzbxNnzu3n8uCusmj1UF?=
 =?us-ascii?Q?9xx66JMnme9RIOGrCqQ8ZbphMwJ4RWDDwNO4tDMIkZZIRQidHWx3mL8IY61L?=
 =?us-ascii?Q?dLeASnCjrluPin8OL0lllSQU6dTHA4l9tr/T/PlRcvJO0MzGCAR15QM+6KwH?=
 =?us-ascii?Q?3gMAB0Xkb//V1bToxgqScRz6WtxtDX+v1yFn/k7atPHB2W+k8D691DU7Wdzp?=
 =?us-ascii?Q?yBF39Vbap+5ziZIJtqRLKZdcT47xTuzA0PF/DeWMDKNGA11y0PfZy5SnJafT?=
 =?us-ascii?Q?IY6JXUSs7j3+l/xNNhomIpSBoXIJtERDpNr51RId7ASumx/83K+9I+McwNP0?=
 =?us-ascii?Q?KCoJBf2t2U3dLyZlFOwZQzK5r5RK2xVZGPfjKnZ34BsLZZM+wvl8pEf8fO6z?=
 =?us-ascii?Q?kX9ZPg8VIGagOiMksgYcGiFYdcAWwxH9Bw50IeiVjbtuv/yXJd+VHe1wrvfd?=
 =?us-ascii?Q?mOPscwDfzRcLpYiIPGgourB4r93OZPV+UBRkZ9umBP7k/r0x3fcEKfylC+o8?=
 =?us-ascii?Q?SDY04wHMsx34oWYAANJ5SyPRK7FeUYJEk9Dra+os1/+9Y7662FsDtDB+QMXi?=
 =?us-ascii?Q?Xv0K1mQl8i5ei2a/+pFKpd9A+Xp1/Ro40Qn4o1/ls0ygMvsP48wGTgMTOPoU?=
 =?us-ascii?Q?1H7wzzpTlYEpETU5vOwz3Ad0IxZ46NBRo3AMLV9cuBCyIy4zCa+Pz4HQlT6D?=
 =?us-ascii?Q?lVUeHIG931dXJGdxKVaK7Mfix8F9LWRNAM1mnci+Tw93nhc+Q4IfKFZJZ+5/?=
 =?us-ascii?Q?6bxL9uYb+uBDpSp2lsHO4Hpkp84Y6HlQg9lp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 18:10:46.0401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 112fc91a-7ce4-40ec-63d7-08ddc6266afc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519

On Thu, Jul 17, 2025 at 04:15:07PM -0300, Jason Gunthorpe wrote:
> Syzkaller found this, the ALIGN() call can overflow and corrupt the
> allocation process. Fix the bug and add some test coverage.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason Gunthorpe (2):
>   iommufd: Prevent ALIGN() overflow
>   iommufd/selftest: Test reserved regions near ULONG_MAX

With the SKIP in PATCH-2:

Tested-by: Nicolin Chen <nicolinc@nvidia.com>

