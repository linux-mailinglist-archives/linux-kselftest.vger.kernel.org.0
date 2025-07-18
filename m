Return-Path: <linux-kselftest+bounces-37549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA020B09D92
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 10:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505B9189B1F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 08:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058201F8AC5;
	Fri, 18 Jul 2025 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ajr6kXGu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E12F1F95C;
	Fri, 18 Jul 2025 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826624; cv=fail; b=YCwESyVkUBqa8mT307JG/2gbfh6SSK59ZWckSOlvHM+KRyBiOtzLvUZIkH+UqM0xEgv9KOPSmvBdMr9dwUqcJDzH76xOel1suJDiE5IDWWxnLBBpwJMSuVoNm8Iug5gvuas3qnfA7x4F5KNJno/26sLRIjeEa5TqsU691FZmvh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826624; c=relaxed/simple;
	bh=A16MMOeH8eVddNha29Ul/mMcjB81dI7ABVh8wbm688w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPj1pWdDd21LogA/GJqMG9DTM/3z8zCNXQnbLwwgnMtpvzPnjGNO5PJo+8P0+5IVlnwfSwvcw7HkS1+/1/MN6a1ufx70WNrd0IIL4MwYTCQkX7yroi3ZiZ+zswcwDCYuYzDqs+sSnTSNv3D0G4UNKUHlmiSzujBlzYZM0//A2IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ajr6kXGu; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQNfkBhNjUus6MOIRP+WDxhubpcpLQS0F7lA8nOC/WLrEkN+IFvAczYi7Vp7IiQi7GBj/8/uDoIjxkCDXxTca+VfC5hmDZBAWV+ClMuWM1h3vLXFPj6sLFUTKxqZLgcmhUJEJjYiPKopmz9T196FzC1UwqiN21LnUziYzIyIXf1BA532jdFMpslPkoO68pDrdy3imE4bVKNSbW1q0Ep09TwlR87Zy6ILp2U9yF/yHUpEjBGC8MDr47dKPQSOcHKYqKGA/9TESPTCV6FpeQmq0lar7wnjaqfMk5pyViIJCSklUIa/zQp2EN3pZeaPvKVh5qdYzRXh+Pu7sNdUlycO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCscc1Mj8zW5D6KeX+rSYnw+j9uwJ3K3JthqD8Ei4fs=;
 b=bX+uMub+IPKv6F2OjCjd/Esr6n9ISwHwGZUFOLRMiNn0AJORPaGZuEJMR2VXUlWw4vVzzulc8Ice5WxmM7qeXxT/jycLBGgcK8k7IkwDk2wC+SWlUGB+kcFUWB+E0/knr5VRVW5CV/m826hRYWn1C2kWupQ5xlaRO2RgTlKrmZ4aYAE+rL+wFeckMtGvnxsRa9mg3A9f8S016H4rBeiRhi3zcb56uzNgMyn6NCfYd4cxsvK5g/EB42TXHT+FZl/wqDX7WuF8Fb1S2mqf0/efRHScxJ5VOY4wC85p5k5w6RZ9B0HVRC3rE2D140gRtb6Wp69guZvwNeKSFwuSm6xdNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCscc1Mj8zW5D6KeX+rSYnw+j9uwJ3K3JthqD8Ei4fs=;
 b=Ajr6kXGuMlexwWVBKYBbuw5ybGMrQWB0Nn9iWabBZug/Cl/RVrcblZpxb0nzQOOXIM55zSGSr6QZmDyORsumxeSmkQ+3iFdNstGeGrhSV6Y4Ma3//I47XL4hjtRPepXJ7C55OzZoiM/hhVtkhitq5Komkqy+46S0e1kRsuP9CGs2N7QCPw1tTUmx+aC9R7+UA+xcyV2wXuNNWK5VReZkr0uYrxCDOgHi+KotPyS+NG1sqwK4jDbItUF3sDF4SLgmPgTM9zYSfaKHQKoF2B7APEfg1aSu+xfqnD62zOHg4w0SEUDrLBIRkv/eKlUnSMWhx2Ggotq4mN7kGQSzOK3lKA==
Received: from BN9PR03CA0988.namprd03.prod.outlook.com (2603:10b6:408:109::33)
 by LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 18 Jul
 2025 08:16:58 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::16) by BN9PR03CA0988.outlook.office365.com
 (2603:10b6:408:109::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 08:16:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 08:16:58 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Jul
 2025 01:16:40 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 18 Jul
 2025 01:16:40 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 18 Jul 2025 01:16:39 -0700
Date: Fri, 18 Jul 2025 01:16:37 -0700
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
Subject: Re: [PATCH 1/2] iommufd: Prevent ALIGN() overflow
Message-ID: <aHoC5c/PSLSZfVXG@Asurada-Nvidia>
References: <0-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
 <1-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|LV2PR12MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: c0322bea-359f-4a11-cdf6-08ddc5d37751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eftON92hKnMCTA2dESyIZO15Zi0kMfo8wFHDYnCR/qBEvQg4B8mggtlSPiOD?=
 =?us-ascii?Q?RxBoObDn9xQe8CqlFscZbCaANtw0GbATz1VgI0ZdenSzUiYeKvtvIGaavNlW?=
 =?us-ascii?Q?vs2N1mBYSpVXVqUEdE+ENkNzoD2nVvCmlqsFO6rPUAXIzf1Wqc4uYGJU5TiC?=
 =?us-ascii?Q?AJ2lGfsM2s1syv6duihjhOczOk0oiSrn+6Q0GiiB10F062SzRTx7W1U0+rby?=
 =?us-ascii?Q?xz163CVH8/U5rF8BV8yB8eNDI7tLqa47WjeESGig8lkFwtQLUOzvyFxpCCdn?=
 =?us-ascii?Q?1A+wpGpC5xrmJ5iodlKW4awJtehD5oWepeeVQWk13VugsmeNp/PXQwe+mJbL?=
 =?us-ascii?Q?AJYNnxcMylzVnCFZDWlbW6HujFz7YyQeNnhtKYq3mRFxY7sfr0FrDCpciTv7?=
 =?us-ascii?Q?SDtTh7u0cG6NpdCQExW79rQSa0sPXy6hX9fNSSMBuZTIjIpVm5SjyKtU2fJd?=
 =?us-ascii?Q?9e/P53I8px02eBd3jCkjQgM2QKXW1iQ4feWVjDWq33da861zEg+RXM6TF9H4?=
 =?us-ascii?Q?R9oEyhnuCTWjSnhtCSYMTH5PFzIpUyBP99MaK5FfTDYs4dBLgWbxIP0ASfuE?=
 =?us-ascii?Q?sJFzRhdC3gWR26fARaxVrhbTJP64cBkisLnm9Tri3jf7ywRwxXCLktvAlDMF?=
 =?us-ascii?Q?b3HDn3qrEL7m2+Wu9gVtT0ccOmY3TsE/ObFK4e595pKulk7kRB5HNwCq3mWD?=
 =?us-ascii?Q?/eJmfnRrlIMaBQPv3devjGSHPL8JbYrv+9wRr82ortLm1hKizUKGEgD+Bt2Y?=
 =?us-ascii?Q?4refx2nUeiKymecmKz1n/2x4triw1XcVPM6Hqd4VM1aofR9/qZtdoAshy8r4?=
 =?us-ascii?Q?EOOiE4Du/6KEO/L36jDgxotU8mceurN++YssQHnpf4RqidqzcMOkp4duK2Cs?=
 =?us-ascii?Q?Mbexw1QLjN5n3MxUMpb3ru/jz04cihpUJ6lyxhfPkKbLcGnY0LqowdVca6It?=
 =?us-ascii?Q?eXATu6MWf8nRhYaFK03mdxhlmph2QVrCjH0+Jw0/x95fWQGS5ztLO6YELDio?=
 =?us-ascii?Q?ojMPVJnjvy7GddC6I190Deo/rW2MpogSIqfW8aGJQXl8Vx12OrJ7NdsSkdpL?=
 =?us-ascii?Q?Z5ymH1DlGvpj7996VFJ0KeKT4hXRIOSmFdbkbry+EkcyB2IT9DJBwjZ9FdeX?=
 =?us-ascii?Q?hJxtCOXP35k0nyYUlAKVjyzy7ZyyBYT9zPMwjN7zntGjQ2ovs6vNTEcRg1RZ?=
 =?us-ascii?Q?q6lp7UzlPMK5DUrHVV8ZRmiHLVoVwsFxz2bGlqWSBV93M6VEv8E77NJiyaaF?=
 =?us-ascii?Q?xAk+T7z5w+m9GRHJt5J+q+fOSixdwHp0TWNSj9bnpClnsPrlaiJc8YsNZ4HN?=
 =?us-ascii?Q?UMMHjrz2Iw0Va40c12JjYWw8vsEq2Ur7XK/EY6Y9ZtnDICg4C3OT1TZ6eeMk?=
 =?us-ascii?Q?Lg1olsxDesDBw5KxHFe0boszwRzT6p+kmQjor05MHFfQdi4A03QCNtKfXuQD?=
 =?us-ascii?Q?by735sGbP0Jy7zLdp6xr9+c4BvyOgxMeABtx4+XD4J4OxmDnVm0BybRDuy/w?=
 =?us-ascii?Q?FqTcW3ty6rQmMwXhKRnKpt946NjilL/P8xPSf3WwmnyjRIXxXarOhe+mpw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 08:16:58.5026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0322bea-359f-4a11-cdf6-08ddc5d37751
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5893

On Thu, Jul 17, 2025 at 04:15:08PM -0300, Jason Gunthorpe wrote:
> When allocating IOVA the candidate range gets aligned to the target
> alignment. If the range is close to ULONG_MAX then the ALIGN() can
> wrap resulting in a corrupted iova.
> 
> Open code the ALIGN() using get_add_overflow() to prevent this.
> This simplifies the checks as we don't need to check for length earlier
> either.
> 
> Consolidate the two copies of this code under a single helper.
> 
> This bug would allow userspace to create a mapping that overlaps with some
> other mapping or a reserved range.
> 
> Cc: stable@vger.kernel.org
> Fixes: 51fe6141f0f6 ("iommufd: Data structure to provide IOVA to PFN mapping")
> Reported-by: syzbot+c2f65e2801743ca64e08@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/685af644.a00a0220.2e5631.0094.GAE@google.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

