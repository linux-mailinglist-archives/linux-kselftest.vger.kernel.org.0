Return-Path: <linux-kselftest+bounces-26596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9E8A35089
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 22:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57304164687
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 21:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EA52661B2;
	Thu, 13 Feb 2025 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JekI7C3T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC47B28A2C1;
	Thu, 13 Feb 2025 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739482476; cv=fail; b=B5Xmwrj5XLZnTh8zHpShK8YC9AcvY/fObyHgmENHATwWPnOz99S3mn0OriHedNZbMxnKfhE66hYeCKyjsAK3n6E0Yfv5U2k4jSuCX5Y79sbRIco6AJxFabrptvvYNwHc55Jy7EuQCkNLJXf3PIyDMNSI1gWI/2uoQuElV1yas7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739482476; c=relaxed/simple;
	bh=pLDhHoud85giXy4fM5JCw2WOFoaLZm/wPUivrXzLmwE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drYCeGRAaQbeWrPipN0rtqQK3sPOUCF2V7N6fvVfgDC+e1BquNPKKoM5NsNJty/6hg+X7XFZFJzVMDc0n0MF08TupXaqic4kwfDRmusbn8Jqo1/c8JJFRXRL6EXaj29vtwqRWdYRFframiRWnMybHDMkLYgmaMhAQioehATNxr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JekI7C3T; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKbIj3lyH6XMHHHHF3V8OSYxckNCwyOaGwd+oSQ7+IsfV3pW1Mz+M+VTR95N1SsswXwI7BTLKxi+jBQ8Fd+Ks5xEQYfJP95RMfTcAT4QPVYn35cf/hhrfqNZsuYENN/wsTQb3XbcfGrWtn1LrSDqZOffzN/TR8cCy3MasPburICNzHb7hvbD+P8yBtDr6lfzmprB+3LG3ojH9+zk5LY0bOhC4TfgHhWO1J9DIiz29ckKh+D9QyqlbVs71/RIvxaYR1mg5UyOtZm1Lp1uz13SfcMWYli8qbFHp5nec+NmsXHtGCo+c1W3Q4yBiPuoY+7b+ydUjPJ5RUaOHXqtXJIG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLDhHoud85giXy4fM5JCw2WOFoaLZm/wPUivrXzLmwE=;
 b=PgW6OLYaYASAKZrYW420JktXDImTrNzoR1sLRvws1I/Qt74kTt9xeuqRJElHjcet30RKhb/rQQCzBkigpBtbEQntM+3ptajP7Y+oWq6kT1icQu1/bOB39bUZ21lf8Fk8WWAaUGDFj1DnOHOB4pgI9Zl1xOLRWw3eKlLhZt9E/mvdVfBVjMPiMaAh8nQGVXAqYBFQQi3RsoNNgSw3vLtFQl9nAu7rxmQ5KjAfE20vIpv7cFPoG8p4sVB87xf3ziKfmQlvDHn9vk408fALCWFWBD8IPXnXz54vTgA/UkTMnHG+TB2yNNi3/QglmIJQbdsZ9mD/44tRtYvTd3rCHgpaOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLDhHoud85giXy4fM5JCw2WOFoaLZm/wPUivrXzLmwE=;
 b=JekI7C3TsBNG+9sgVMuf30qK3zmmh58cM0yP4o0MApPp9DZ4snTW0W0jmB7ugrtzzPYX85NIBnadfO9Y+/EUUHJyh4HXZeXC0QeeWXBOxuK6UcH++GE0ujdFL2F7VPL3VR+iTCLdgCg2oklAWa/d/5vvxAc94DhNVGFO5j+JFy+uM7rMYoV0p20DWto7hZrplqk+ux2gu9rPpvLl7kJWa2IWrlWUitITAtg8IiKRGCWzW7X0A8WuJFcl8Q2RhdikqtIWyAxfGPHewyal3f8/XxLrlrYrbhJOVbL1o6LUX4mP0x9ECqQQqSI+GXTJGA4Ib37KEUhjrJs2YkLpL2uofg==
Received: from BL0PR02CA0130.namprd02.prod.outlook.com (2603:10b6:208:35::35)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 21:34:29 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:208:35:cafe::32) by BL0PR02CA0130.outlook.office365.com
 (2603:10b6:208:35::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Thu,
 13 Feb 2025 21:34:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 21:34:29 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 13:34:04 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 13:34:04 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Feb 2025 13:34:03 -0800
Date: Thu, 13 Feb 2025 13:34:01 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Thomas Gleixner <tglx@linutronix.de>, <kevin.tian@intel.com>,
	<maz@kernel.org>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kselftest@vger.kernel.org>, <eric.auger@redhat.com>,
	<baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>, <yury.norov@gmail.com>,
	<jacob.pan@linux.microsoft.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v1 01/13] genirq/msi: Store the IOMMU IOVA directly in
 msi_desc instead of iommu_cookie
Message-ID: <Z65lSeo7PGLxC0uP@Asurada-Nvidia>
References: <cover.1739005085.git.nicolinc@nvidia.com>
 <a580069c5e494ffffa668218b6fe3a207b01efec.1739005085.git.nicolinc@nvidia.com>
 <87y0yajc0o.ffs@tglx>
 <20250213135752.GY3754072@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250213135752.GY3754072@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d36834-4a3a-4b63-e29f-08dd4c7632ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+CoHvpwwpUqto0yigpPB+8ZoNY1FdCawsmqQpA6H4V/LhHmYUnukIILW69o/?=
 =?us-ascii?Q?3djD8d0BYEpXPMyHp46u1WbsQ42bOqR3Lhjeyf5f0e8IqyfR+qgTZ67PgrNz?=
 =?us-ascii?Q?l7zGbzNpA8C6zN4YYZRS6V4KEUh9I1Qcf7Ie59yDqQt7QPiq3suMWgAqS3bG?=
 =?us-ascii?Q?YjAzvH6LQ/BjSo2x2OqOOuougYlEc1ISm+6+vEWkeXHayog7M735uyCAqSqZ?=
 =?us-ascii?Q?B6mOi+JHnlBt2i/pErlcOZuDeqQKYUvTjb9sMhVOKv0byVXMcJOSJyV2s5Mm?=
 =?us-ascii?Q?DitfxW0gWkROR3nby6dX9uYRJvNYSYqPUWyhORmnQ/BiS7XlwQu2MFUSHDVA?=
 =?us-ascii?Q?KBraSo6dvVkP3necIaUw6XfTz4xjPXjVt9uzoRw9g0FExYVUbL7AjwWACJNr?=
 =?us-ascii?Q?HhZZw3QUeOH3OekQapMQ65aNgPb97lQOtg3b1H0uKmSZlOFLjKyWVUzq4Mip?=
 =?us-ascii?Q?KEXidhYfrpBglFUZNKpGCkPapk6JNmHUrUdQxS90xNiTNcjV7wEbw7JKd53a?=
 =?us-ascii?Q?YrHWN72We4jhMdf3o1ijheTvcyzhQ24y52fnuG68Y9g6OhF51juguCAbZZcb?=
 =?us-ascii?Q?GuXXWAfjeSgfXskhITNR6HuAlX1QAsriwtLbBZk/rY99UCdBzLqOo9mnwNc+?=
 =?us-ascii?Q?DG4x48KfkxcuRFR58UNJzACm+YtZSXgtsjwx/stX5jqxjPepOp6OpJmzuk5q?=
 =?us-ascii?Q?HnJI5yJLkgQQiUvmdDKosL8q7D8P28JwMKpFUaQBmMR4TFuoyN72EX1HpDhE?=
 =?us-ascii?Q?vNNNVNNVOfdMvm9q2wAzucrFKmOHS7FeU9vUkESR+GXyBeWSdtLigFAYW0pM?=
 =?us-ascii?Q?p5UFKJrWMnvJzQmeGlkmY3qBQeYCWWOCgywgxKvVW6d5fn4aL7rTb2FSXo2a?=
 =?us-ascii?Q?cTOuE3CCR9W8KpVkkFtBGcx4Zh8fFB0MG792/Or8ajSGySjvJhoHtnx91uxD?=
 =?us-ascii?Q?LIKtNz4hmP3mY/2KD7B6lXeFc06OaSuhVEZVJQmIq7eeDA5DzLgtjBeFZwdo?=
 =?us-ascii?Q?PPnqee232u6a4l9L7bIH7SEnkQZmOjUx899rpumpYqC3y3LO09NB1Va5hlzD?=
 =?us-ascii?Q?dIrTsEDs4odwOFIGnfqPB+PbjpyShuegmGeVWs0vsZ/Ru9Qva/msmR58ejgD?=
 =?us-ascii?Q?w2mT0hBwgjm+4mMT2yJzXfpaXVqVWOc0tYEurDOPc6MubFs5qmmKyyhkm2hg?=
 =?us-ascii?Q?wtAZuMBTaoY1cIK1hwVixE7lqrgGYCPSHS8jLoyQ9gskQYV1hoNEDWlj9bJu?=
 =?us-ascii?Q?5xBD6UeYGS6DGAyYs0wIo7yExUC5bozZndUzzNUUo8jH13czZUWyddhRfbzz?=
 =?us-ascii?Q?zywMixJs7OgUaEWRPTHeyD/ai24Btly40/rfY8K2aS/ZOOagAtNGMK6rYHGK?=
 =?us-ascii?Q?Nc4SiacQS6QO91Aey3dF8txADDOU7sAbYVqMXOQzC9vQLahqanYeI551dNiV?=
 =?us-ascii?Q?iOKpTEVOqB031zXtS6T0B4y+3+p2q9qC0NSk2ekAOtBQKzenvrzUiW13LMzC?=
 =?us-ascii?Q?Zmbecz0OGgOHAiw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 21:34:29.6456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d36834-4a3a-4b63-e29f-08dd4c7632ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764

On Thu, Feb 13, 2025 at 09:57:52AM -0400, Jason Gunthorpe wrote:
> Nicolin - lets change the patch structure a little bit can you adjust
> this patch to leave iommu_dma_compose_msi_msg() in dma-iommu.c and the
> next patch will be all about renaming and moving it to the MSI core
> code instead? Easier to explain

Ack. I moved that and updated the commit message too.

Thanks
Nicolin

