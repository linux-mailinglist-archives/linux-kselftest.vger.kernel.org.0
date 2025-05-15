Return-Path: <linux-kselftest+bounces-33139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9126CAB90D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 22:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64FD41BC2075
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 20:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A1727A461;
	Thu, 15 May 2025 20:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TRFK9ws+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E49185B67;
	Thu, 15 May 2025 20:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747341187; cv=fail; b=Yzt6S/GcEuxE4Q6Ue4lBoXsXwqAoP+RJ/52aZfaucm2I8Z7h/vhza3RxRDWHygk+4ykCvbxulqrNU2fDu5gAvU+D0qwEYbYkOLQmIESMPI0VC9J/VEXc7I6Oe3nm0DNnq+0S4BpNAt1nxjPE0B06Kmn49wcaeHh+dd8tBiH5+5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747341187; c=relaxed/simple;
	bh=UdDsSnxx+rs0DdB1rEoUH6yMCVZT8ASs5ITpSXxi+kA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d18vg2En6ZCwQOv2DUkY6dlcSze/PyjtQUIlOK+sGi5pAZJDNSWYtkfltwdDWptKTbykJaQ3Wy0nFTn5X/yy46fK6ZHotxcbVYQQENdD63tMWyCi/mi21vP1evkQeUIks81rlkajj/5lUJkRKy5C919XU2uj3FRyX1DhSUFqv8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TRFK9ws+; arc=fail smtp.client-ip=40.107.102.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7wTK346m3GqD/WjcKQZd84Al+YWVnoewJKhl7BMD9YNf7oCsDoI3e8064eASpjtGgE8OxiwI9EZJo+sAZzgsTBY2BBCHS/9TMNfk40cUV0ZNA83fON0BPRYe7TlYGvT+tDmHEKP3gi+ruvoTIQedakKdV8swjqCPVmvNzjHhNWgEnlwbLCEFY+B4XMkTruD09jQM0AWf5ihq/KGRv0HgZdxeWElHsSoNAXUlFD0dEPGxO6cGStxbWJHNcDuXRjWca2/9IkcngnYce6miHpVQtLPvICLjrRYWqbXyRr94ciLTgU0iRdnEp2GCmZ7HCaDziIAI1SS74pBgvWlA6UVmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5HlsZLk1Tiwl9MDE5QGy9/di6T/TzXjQ/J5OxXsb3o=;
 b=jkB7SFM2DV1bTpSx0PcYF3ZEuA5OLKpKZSRUGjByNWNLA1s2lqvkGM1GryZDN4C9yLzjsWKsGZyArFeL+p249xgOe0h4R75DYkfmDpjtnD2bmTr502z+4QBTu2m+c6BrQyZW7DJVTheRmB/rzq6YL/qCBNTYdi2dy8xT5bFLKheMVbIe//rQrFAP0K0x3yZJv3sfk28IvNX8um3M5np+jh1Ne6/4vN6EtSqH90g2y1dBSF7N8JH9LxAZ52qywNNBwkBjW0d47QuzDcHW3EHZHMM/xYEppVnM19w3IFBGH7VDqztvlpwWQWghGOgHlVRexHzYQLcrYu0X0SMTwO03iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5HlsZLk1Tiwl9MDE5QGy9/di6T/TzXjQ/J5OxXsb3o=;
 b=TRFK9ws+GyGc0oYCxaYCd4oLDr5wZQX1dmoWWGxGnxaBuwFiFKrxPOh9mLzqhPqnEuLFWzVKCU6Hmh/wDfYz9oM20aOS+bvARDPi7ymo+LYFc+FcVlW0N2RIfHSKRE39O0j+wPH1N7Cw6CioFQkHQom8Wzvq5vcVe+j8iXDoP9BJe6Cwv4HIWwLBfHt3feb2XiH5d832gxg0DNuvIOCn3OAUdNSWOqL+wInh+F13sRD+eXbhoy/RrwOfAw5bA+Ok909xUYYvpzfZTojVyLRepaeH2jRaa2N5HhX25MvK6+QO8/mdVWDyIuRKozDef78WRxgtqDjhBBVxlIKQbZefuQ==
Received: from PH7PR17CA0056.namprd17.prod.outlook.com (2603:10b6:510:325::17)
 by SJ5PPF4C62B9E70.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::991) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Thu, 15 May
 2025 20:33:02 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::2a) by PH7PR17CA0056.outlook.office365.com
 (2603:10b6:510:325::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Thu,
 15 May 2025 20:33:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 20:33:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 13:32:51 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 13:32:50 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 13:32:49 -0700
Date: Thu, 15 May 2025 13:32:48 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v4 11/23] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <aCZPcH+GiZKUjzWn@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f52937c027e2fd25d76bc47f4965ba46f82c77c0.1746757630.git.nicolinc@nvidia.com>
 <20250515160620.GJ382960@nvidia.com>
 <aCYvjeZW+7NmUtoE@Asurada-Nvidia>
 <20250515185938.GT382960@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250515185938.GT382960@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|SJ5PPF4C62B9E70:EE_
X-MS-Office365-Filtering-Correlation-Id: 657e53f2-0f3e-49c3-8b2b-08dd93efb015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9MgOS03szYgiRVtPFcfgqGXhkUajnTm422UtNCgDAkfaoU+I1kAQQkuk/ChU?=
 =?us-ascii?Q?ev8IH8sQHB/mGzhJ3d8ZZ7qOgBKIsIgvvoS7WawRYadrtptGxc53oGrS9x2x?=
 =?us-ascii?Q?xTMLdHUo8S14x3zsQLhn5s21fZyXBbfNbDSVg+WCO/U5P9AFhiiVeyKBB26L?=
 =?us-ascii?Q?UZNLMXNwLTN9V8YuJW6YE9KVyyP4Zi7Vr9tVbQ40x/WeUfIba29SoA/WhZIk?=
 =?us-ascii?Q?6qc2sx+3K2U57iRIZgYyYg5cflRbd6WdeI7kWQHlImGZ7IjFdaZjhKKK4/d3?=
 =?us-ascii?Q?c0SEE6hShKA3POYO0+Tsi536w6P0pvgOLcQR1weKz75+565PLh8p0r3kZ4wa?=
 =?us-ascii?Q?ttsHyB/nExf36Bg9SjRgk3OJHLUSy+Esur2gKf5xisAl/jU671Jg3GGZzJEX?=
 =?us-ascii?Q?P5ussSjxIORCzrKF7rRtvEh31RY8BbkliGcDTCXOX54zNBjBpYgDJiZQrsfl?=
 =?us-ascii?Q?oqZbUVScBMeMwp3qdz5K4bK9PQ2t454R5Sr76n5oZ0apAS75eelsoAa9P12I?=
 =?us-ascii?Q?MOcan+4z0lWvUw7MlYisA9wGdogJoD1mp2xQMe4G75vb2VugbVakJ8j0yns4?=
 =?us-ascii?Q?lpYACI7TGQzZD7Adbrveri1PlXCcxdjuIqvrf1Bm3mZ8jP8IoC6Ra877dSFD?=
 =?us-ascii?Q?nZbsrERTNM73kkTVfAFnTYSDWISxkNHsL6TGljwYTvWLQjLg+n0Y6zblw2sl?=
 =?us-ascii?Q?77nmFTz3UW8NDEKDIeH5v2a5FXvtwopkFb+HACkhiFW0QqDKFEiwhl3S0AZM?=
 =?us-ascii?Q?gnFPzMXdbUlXQKP1crZFSrFR8mfGtoYRnPFrLvv21hs3Z50EnYjiVmYrK1QC?=
 =?us-ascii?Q?LCbLHbJVB2zfuuCa6l+2WV4J0KiujfhcDQV/LMDTC7GMSYW+SIN1JMtkBJFk?=
 =?us-ascii?Q?NKxcL2uoKvVBPz4xS+gxkYow967QynH5ZzzytpvClA1OSRg2kCFaNw1uoJX8?=
 =?us-ascii?Q?QmioAsRWImeR1mjCx4YYfID3qTNMgh+hfC90TQh0yip9yhdy1dfShICOEBVl?=
 =?us-ascii?Q?6VgMEMeS7ZCCEgn+0q4aKfFinKwb/QspzW4nHjkLKLqyXGl8fU+FuI9u6nAR?=
 =?us-ascii?Q?ODyEFDCAxsf5zqr7Jtmdbb0OIyKOIaCLqyNdqYgs3RMfSbbmioQMVAdzNwxh?=
 =?us-ascii?Q?cM36Yt1x7Sur9gOMdqQY+p0Vy1f7W2FQiVLfYBNk0yydTXLk0hlWnreUsoXa?=
 =?us-ascii?Q?6aHsqN3xbyoevud9A5n4nytv7czErx0RLJe3fDkjMUt2I8fg0vk7IMfxZ9DE?=
 =?us-ascii?Q?op+eyMi2bZl2BIxYhte95ulFs1F96mzLplURDHNegHQWqQABjXkgd5QqHWVF?=
 =?us-ascii?Q?E4j3Rq03bgdjbyNiaJo+/AKCq81Bz8BtPM/i5dHhBPFaYpEoFnPAS0nkl5Cq?=
 =?us-ascii?Q?DhUI6ZfWHuh+vk3ew2hiSIu0QCR5a5MBoICpZ6Lb0hGMcLfE9xXPv+NApAiy?=
 =?us-ascii?Q?hpgcwEmOs+Un07DtUYMmUvKU3483sDzfTpzBmbv6ZX9DZEdpzLeE1IE4tz0J?=
 =?us-ascii?Q?Uwrk5e9yHxDzOlHSUxuFinM3x0GI6GQeicky?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 20:33:01.6083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 657e53f2-0f3e-49c3-8b2b-08dd93efb015
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C62B9E70

On Thu, May 15, 2025 at 03:59:38PM -0300, Jason Gunthorpe wrote:
> On Thu, May 15, 2025 at 11:16:45AM -0700, Nicolin Chen wrote:
> > > I don't think this actually works like this without an unmap
> > > callback. unmap will break:
> > > 
> > > 			iommufd_access_notify_unmap(iopt, area_first, length);
> > > 			/* Something is not responding to unmap requests. */
> > > 			tries++;
> > > 			if (WARN_ON(tries > 100))
> > > 				return -EDEADLOCK;
> > > 
> > > If it can't shoot down the pinning.
> > 
> > Hmm, I thought we want the unmap to fail until VMM releases the HW
> > QUEUE first? In what case, does VMM wants to unmap while holding
> > the queue pages?
> 
> Well, if that is what we want to do then this needs to be revised
> somehow..

Yea, unless we have a strong reason to allow unmap while holding
the HW queue.

I think we could set a new flag:

 enum {
 	IOMMUFD_ACCESS_RW_READ = 0,
 	IOMMUFD_ACCESS_RW_WRITE = 1 << 0,
 	/* Set if the caller is in a kthread then rw will use kthread_use_mm() */
 	IOMMUFD_ACCESS_RW_KTHREAD = 1 << 1,
+	IOMMUFD_ACCESS_NO_UNMAP = 1 << 3,
 
 	/* Only for use by selftest */
 	__IOMMUFD_ACCESS_RW_SLOW_PATH = 1 << 2,
 };

and reject iopt_unmap_iova_range().

Thanks
Nicolin

