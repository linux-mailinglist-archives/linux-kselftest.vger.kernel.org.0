Return-Path: <linux-kselftest+bounces-33959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C85AAC70B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 20:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E691BC5FF2
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 18:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86B528DF52;
	Wed, 28 May 2025 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qhLpHU6k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33629288527;
	Wed, 28 May 2025 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748455692; cv=fail; b=uowdvWcWfDJxxtR3B4XcC4VROZaGaFFDpOUhKGa0KXUwISXicEfHMEzSYBufKpw1Wy/VKFoE99eZTigpSnxA9M3ikFHu90iOwQGoriuivypQewgYtbr9XjjOC5aagiWmbqITaPUbSsZPRsZjd4ZP3daNgxU5FbjULAQ7pQ6ipS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748455692; c=relaxed/simple;
	bh=eeIosDLclYUwj28PrLn1VzvdyT1Imu1N0BnQ0+n0w4w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVUivaRxFVBqRNCjKVRvdEpzG9MAM9v1RjLT6hnsNBuh835Zij8dYu/vXzqrSRg8AEl1ULV/E09jlK+iQzzVXQehIgSJqjW037RqQAWVHbEBQ2ozXOfmysptUYrxHQTjjbQJ08Bk0KzcMjxs2Qwd04tBnTgXDaLzBUMlpUcYVBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qhLpHU6k; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rzw/yeEEv/sjitQMPUz556j3OtzS7QO2eIfaAMBXYUcyGktqbvwMPuHR5nqluzQsDqp36M9PJdKHUJk9XvY4KjGxJ2K4yPjiVlIgWUcvcwEPlAma82d5dx3xfz5dKSIcW+PcBtOyIbZccD8v14J+gubK9ES6VR6mciYRwWS1wyfmvfc1eBeiFVDCfFDZL/NjF3pUzCcTB9HKnK0qmYu5AD0Jf/PZnCDNMicYoo8uzRkyENI2FjcYp1vHL+KQ8ntEJRXAHQtAaTgPcvefTFDodYcFz5qmyG82vcD0z7ohslxNvelSOrRm6vuoCMYqBeso6VvUZeI8TeY1VOmijVH2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeIosDLclYUwj28PrLn1VzvdyT1Imu1N0BnQ0+n0w4w=;
 b=TkUb60iYmUgepHbc2qiMQY1z6t/DB2yZ8s6Ch7fZf3NU5yJERZrPCStB8YFvRgDz9y8x4rgWaZcueapMDuoTsiS2HupDj6MBCq50WM+8gWCUeWCyxk83oDqgYbrnR1v9ArxzVljJEqRepkogBGbQg8ihJGeNwFL75tAEvp3FK8tc1DWkTZeiIyexjlNdY5jk9O7lzlyk3OOcdQS+FXqJG9rfd7E4AbLjUWLfkO/T/PFbrrGeUhH+CLq5PkmJ4Iad6RCvFFKG4Rr6sxjVWRgb/r4+iCFCwWZnrRYph4Hs4wGTm1RWaT8KGV3woljwZbCS7DlNxFTItJBLLsRj6HGSdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeIosDLclYUwj28PrLn1VzvdyT1Imu1N0BnQ0+n0w4w=;
 b=qhLpHU6kfeaA66twVqbbHtE8zh3ZWGs1eiaNU8X5S1Lf3Kp/CcP3Xm/MbN/msrhqIT8kgeYQVtiQr44Ap/l+VzSQL6taiwpXSoLSP2bqcv8KAn+YfzeayxrKoxcOZoWW8sOwspFEBYExiWctyo2nH4qDRg2WZNCf+fSKu5S+vkNNlP9rbMOk5fZMWxgPL2Lv0SuHnbX9mYcq2ahAlxQkfd9to4SK9Bb45V0UCnDIBH15yCLxGDPmo7JX7+y6WmlRt/JZTTyE6WE1sOwcd8MkJPTNXa9OFXtkqRoLziKm5+PYGZtTQSAjAnhtcSFBBFq6U0k5G5AoxfZrDKj1nDgCTQ==
Received: from BL0PR02CA0032.namprd02.prod.outlook.com (2603:10b6:207:3c::45)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 18:08:06 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::87) by BL0PR02CA0032.outlook.office365.com
 (2603:10b6:207:3c::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 18:08:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 18:08:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 May
 2025 11:07:48 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 28 May
 2025 11:07:47 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 28 May 2025 11:07:45 -0700
Date: Wed, 28 May 2025 11:07:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 09/29] iommufd: Do not unmap an owned iopt_area
Message-ID: <aDdQ78ZPXexJILR4@Asurada-Nvidia>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <3ddc8c678406772a8358a265912bb1c064f4c796.1747537752.git.nicolinc@nvidia.com>
 <20250528170845.GX61950@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250528170845.GX61950@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f56261f-7834-4720-4a06-08dd9e12986d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9QluxvScCz268DfQKpx8VYZgKsh1SOdQYMODK7V35DTz0RL7sap/zwxqoASF?=
 =?us-ascii?Q?Z5q7R58RcMrQf8ouLcwCTGogjZiQhDWNDtGi/TDwTasMxkJJ4IOoUlUPCDlN?=
 =?us-ascii?Q?JmpVhxGmDaDly8fiH+NhsnugpStnIsPKNLd72SWcpOG3EbT7GDOCjYLBh7RT?=
 =?us-ascii?Q?qngzokrsSqct0zRidQ7iJ1IpaqNjB0X2jrjVlRB8tAZchtmk8NWCQhFkEQVh?=
 =?us-ascii?Q?cETW/BYkDj4Lb1OOM20Otva1PB/ZgsDSFwHBIOEe26kU1gLQ44oT9qhKbui5?=
 =?us-ascii?Q?tz/gkqeCVHZDlhUsbGHqkaAvW+oZmicnqmf9jeWmeMG9ywtDAQ/eFlkjsVJU?=
 =?us-ascii?Q?426tH+72zJfTFa4+L668/3Ax51t5aa/kVBMVryYiyifP7B86l1UIKusMCrXf?=
 =?us-ascii?Q?FED6t5akBEUfQOA89nUefNKQU7dYcgRD6WQor8nPNuN7Ui2yiYZ7207aR2m8?=
 =?us-ascii?Q?DpVjM4eqXgPIdD027JYJY3dP/rqDudBN68YSgkj+1clR7Nmi2RUccpFr/772?=
 =?us-ascii?Q?TiP/pI/DNs+S8VqO09dww1s6W2ehqbnJN475lfD4zwWrXQZPNAPE3Rl0j44f?=
 =?us-ascii?Q?e1P/mkx/v6Fbnp7GOnVgEFOqMU2rEGNAvog44Vjj7rYTLnndfeXbgqX6Xtws?=
 =?us-ascii?Q?7VkDAQem7QOCDaHvmiKeGOVNjj43fVJQcby6TlTjXviEniN3GdWwSQkyLKni?=
 =?us-ascii?Q?cftF7+VkVUAmzK6AfYVrN9m0m0slfbOLD+y6WeOqHl2CaI12hqKLfJjME2T/?=
 =?us-ascii?Q?D8jvktDbVS0l40Tb0cJ42Vc+a2gEc6Qxz5canOHcgG1HZnrcns7s0QiXy53i?=
 =?us-ascii?Q?KaphKi3WcJNiyu7tUV/UtzbvvcxsdRUZFrnkM/ftVlFOrE9Cjgh12J28qK8w?=
 =?us-ascii?Q?ec3YQttiQOisI+gz7gM07Qc24ZpdVZFqckUVyeN5PvoshMTXRSMCGf7ZE2dZ?=
 =?us-ascii?Q?7Oos5NfiS6QnxxIjjolZe86awPEEJiwyrn6NbCTX5l/+Ygvm6/YHJJ+n/LWg?=
 =?us-ascii?Q?kavc9r9za7aVCdK1rUaAkt+5WQcZYbZf+KnsFmlvstTgRmfHgpCnGvl0nQDN?=
 =?us-ascii?Q?6Wuryhjk5vfxbL/r3Et1+jbve+H3fAT6UeCABzWLA/q27FrMFeEOqzOgNQSr?=
 =?us-ascii?Q?tOeTeFuYuz6rqXD7ULxdATDdtiAGL7Fqm/ydWzjKgCG2S3coGtOgca3FaX5/?=
 =?us-ascii?Q?1m4ppVletNcsRRuZyxxPNDZE4D3Tm8u5rZTZv8Z8DFIuKYexkucKEHzEw879?=
 =?us-ascii?Q?d01tLqRL6Nfkc3wXmbUS96l+VahOv6HIGRVzk79W+QHSjd06VxkWBIdz1ik6?=
 =?us-ascii?Q?Uf9fV2a3Mio4M2T3/PqiAfxtNk2PpusxGngfbEiBsFd4AdVOFHcn/yutHfiG?=
 =?us-ascii?Q?aAlu8nnz2E+cALpU+HeHgr7N+R4EwQpjqagek+7X8aMjn9mwpQ/1vuTAsssb?=
 =?us-ascii?Q?kPKrQA6j3ClyrkQIap1EcUz1l78ad06TnKzurTXvTdVAqlXCFZUNaMm7w4yj?=
 =?us-ascii?Q?dWbfFvFuCmxGccl7bPX/5wBO8myRxnnLth+S?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 18:08:05.8391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f56261f-7834-4720-4a06-08dd9e12986d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492

On Wed, May 28, 2025 at 02:08:45PM -0300, Jason Gunthorpe wrote:
> Fundamentally this is supporting accesses that don't have an unmap op
> callback.

Ah, I see.

> It could be done differently, with the below just create your access
> with a null ops. Prevent mdev drivers from doing this when they create
> their accesses. We don't need to optimize this failure case so it is
> fine to scan the xarray. All we really need to do here is eliminate
> the WARN_ON.

Yes. That approach looks much cleaner.

Will replace the iopt_pin_pages patch.

Thanks
Nicolin

