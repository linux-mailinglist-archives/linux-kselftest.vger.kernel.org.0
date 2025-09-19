Return-Path: <linux-kselftest+bounces-41955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28730B89BA5
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1813587C01
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 13:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DAB30AD18;
	Fri, 19 Sep 2025 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e9iE1bw2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1219D082
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758289417; cv=fail; b=r7sQDjmeIDQkL2CPtgsKKVwZwtq+1lmTVMHWGkrqhaVT7byOUHkuRVjxzhXFWcjdKU338J6xSqBKlkIyR05jiF9RqXW5MY4QrHqS68PiCPTXirmvCGyksnHHNQzQmd8tkO9wJENS1MSOWdZ5/YNWfH8JbCAPgshDy51qvCkHceU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758289417; c=relaxed/simple;
	bh=hOl7DB1cExYsd/thOeEjtHzpCGQDjaj3mNh57XDt0/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZNv4PpDzE4PePkIMMTsDfeuhxcGTOFdHWeng/THPBiVWQKQ4iKXHjwLHiblfdcdWVDVVaxT4qshH3LFBX9pPSBMRhb49wYVZgdcjgimYoeadA0Og7uhqGbx/rlDTRV8hy/RSjqZKQUPc5jAizWU5/av5UucAiQLLvoHVGommZEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e9iE1bw2; arc=fail smtp.client-ip=52.101.52.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVxUO1BvxZ6PK7n5V4q3CYuJhYgDmnrKw9H2DPoqp/c5+PK/VfRXpAMaJQYm66KpIvVUV6SQHmQwTpbjic0I+74uCwCVI2deadO1CC6cGqKtM/oYQ9BCMO60RxoDb2bus+ySCsB1YF7jUpiIIt0o3JVUHBnMEvRLSBXca44ZBY48+8vm+VwBf6I7DWFckeW2Sw8aPXc8Aw9JiwI90a+m24mI+shjZcXPMfMkpDxNJ4/aU6tER4TUkXPDk3giHV0E5fuBKqDVuumaB0D4M809p8AK4P4/6DWW0ETaF/HowD/ipJwz/zq186Ty5BK/fA7b+xvIS08eOI7Rv+fK2kFyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIsgAjBHzOYnHnkrqOxPJDnVPkhoQoOQCOBlV6F5F3c=;
 b=jkR175GJE3NlxSHhsw4CuAxzTSKhHxL/tIOAzHpI4TKWjdepNUD2pkXFt7sozYK5rvtoJwApowMxzDXazHXL456fSjz5gJ4U2/LIqyJwEy6ZRgF713IEGwo3302WlP0xGXs8em/wxz6aFhZBgpQnmhwcJJbrG7OXmq1w8sP536Et7QXOIj1vG5oupa3EFLBknuoqlwlFgXrG92M5+2I7oMT3DuK99MsGvd/Zn1bCUfuod1FhSPi+g1jmNSXpIZHBFlValzgc8r4RekuUowHVK45c6x49h4I/v3/l2a/4n5onqdEWG3HGlSuF7ayhF6hWcdI598MeQvM7kiDRmjvSIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIsgAjBHzOYnHnkrqOxPJDnVPkhoQoOQCOBlV6F5F3c=;
 b=e9iE1bw2XAcAHbrvKK9Ye09Zu7TNhxtRf3sG6IQ4aOD5drhN+RfJTH1D4x44OHhp4KPir4fB6gZ/oqGPDrUd/YSAVAvYE3vzCy3v7sEnDTJmuWJ6Dt9dNNNe0mryig9r/5JMOP1xXqXULfrRB9ivr1SR2QR0ESavOVtfjqoKjHYWDgfI1hxpVCblfI8w2mvfogvPE0IulZIpDHwwF5yRzvDSs8q6g5B+ANifGH/KR/cbvGvV0Hgtsexli5/2weMf4VnIQrqoq8an4ytDhpNAjJY94il8yMEavMGGAQxy0Q5+fN08ztirr6X+C6mAW+JMlckLV6FFp7UvBqynEatIdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by BN3PR12MB9571.namprd12.prod.outlook.com (2603:10b6:408:2ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 13:43:32 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 13:43:32 +0000
Date: Fri, 19 Sep 2025 10:43:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kselftest@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, patches@lists.linux.dev,
	syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/3] Fix a race with fput during eventq abort
Message-ID: <20250919134331.GA2215435@nvidia.com>
References: <0-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
X-ClientProxiedBy: DS7PR06CA0045.namprd06.prod.outlook.com
 (2603:10b6:8:54::26) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|BN3PR12MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: 591a83fc-f537-46de-338f-08ddf7828620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MDWDdGqzgPhi4plsNV359bqlGkcxWk4Bw6RGYWG0LtYt0p/jin7xHaGWixmA?=
 =?us-ascii?Q?4HstWRjUzyK4gLHEPUBj0VlaCuf+Six7IpwMeUKWKX+Fquyx0rSIIso6lf5d?=
 =?us-ascii?Q?DemKFF4A+NsiCZrGtJMzEgjwvHcTFGP80ui19VQJ+YED3OPqvXUKqQCOo0G8?=
 =?us-ascii?Q?6QS6PtgBQlQWpIS+bn3siPvImYWS4kSwoCBumYpSnuFGOFa3WwWZbaW91Wfy?=
 =?us-ascii?Q?BtSIF82USGkn8e8BNoOlRSydU3yEd/kfZ9PxIVj0uZBmKDdte5KKhuNXMo7y?=
 =?us-ascii?Q?ZfYJ/FGN/XPSB99D6Htl5emdDhp8Wg/FTTUWkQhG6iiBGDCB32jAghw9XW5s?=
 =?us-ascii?Q?y6khpvukQW7ipagqd/EHejQlebxvSGvdbJARUTlMaoklT+gtxFQCpzOJslPS?=
 =?us-ascii?Q?kC94pmH4Qhb1YECpWkpONU6qfzDOtWhl6h5VvzBBJFmC14V57R4Wjn0qv88y?=
 =?us-ascii?Q?U6xdQrzN16VafNLdtfd/zYMRQ1FfDMLJZpSaRQxmTVfFxOW5HTd1comMsaKG?=
 =?us-ascii?Q?qvcb8/h3T+4wj/Hg1iv+ajzBtTLSK27DZ5J+DpdWaRLnMd86ja5acloqSI9+?=
 =?us-ascii?Q?ydydCq5mhMjPEnOyEYPYaWf1PKU7XlY0SsdHLjVHfDc/ti0yhZ7obTI2wFWi?=
 =?us-ascii?Q?t+oHpJiHczTZbYaHzlWg21TxPDJeCBViFkOveNIWqnlWJZnioBaqEfQOJkeY?=
 =?us-ascii?Q?PXNvbdy1ysDx7JuCKH9qTkROJIF0NLY40hjpxNvQ5cZ5D2XByzAgFRlWDJ0C?=
 =?us-ascii?Q?mKJig+Abgxt5vlaJUBa+gvV9ZK6hlXqkkR7lN/JjYV602o/Vie586p5HnBP9?=
 =?us-ascii?Q?REeTU6h9ejRG879GFOPFPrEaGd/CBUPZ5oNSkp3cei4sNH76JAobDeovtcCD?=
 =?us-ascii?Q?Y7MbNWWzA2nItR+ghT/mseG/E49MUdWOZ+MLgFdPuMxtzjEthinZo46H+qx6?=
 =?us-ascii?Q?VhNN3MXG96HMoCmuMY+/zjmo695tVqjEVE2ava4qfFiIQiIBtUk7dLEbjhKV?=
 =?us-ascii?Q?PZH4I9/FW0lqppPrKHb97IkbvpCA23OY2RyOFg1z1RoUcYGcII+Rx56ftmBP?=
 =?us-ascii?Q?rcE32WbUOfFq8F7vnd+3Q+Uhm/sLNbs0046K0Woji+dPCLEY943l23zuFe/y?=
 =?us-ascii?Q?gQCwG0Bj5qbESFwx48m9Yz61uH7SRw17k9eKmeZAwx4n6eh8GQ5JRSohcO0u?=
 =?us-ascii?Q?JfLG6RzD6xWYIXFTS10cn6UYQLEteCmhE//QKVP5Jf4qb/FRXcxFHwvHL0kM?=
 =?us-ascii?Q?kC1TBFfivR+SrIWKrEHKH+f5bHmkHOufClNuDRFmysZt//WJ+gg6sYkFuqI6?=
 =?us-ascii?Q?4wTFXRsUetrKzJqeJVtMxYvXVn5lxO4j3OmlZVCo0tFlGbblIrPL+GJhc584?=
 =?us-ascii?Q?qj/YzGCT3vhsrH/0+awwoNxzZJD0Yp76bawXAVNPRlNL1Hkb8p3/Yd7PJ41P?=
 =?us-ascii?Q?/7yGbzIM9EU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mk3Bp0y6iQBZWoIhRuPS7BCWuH+gtyh7oV+BVs7PTci+5SBxrB1ZRm+NkG05?=
 =?us-ascii?Q?sV2H4+ZB0tnGvH/hJvw7Bs3Nt9zeqommLZKTUiCjgWGLksVhr2nBgVb3aa6/?=
 =?us-ascii?Q?dKtmH0++5WGExfEHKAgEc6HsfKx0M8dTjO56eIrU9ke8HqA6r4uG4sbZ7AfX?=
 =?us-ascii?Q?4a5pvt43tSAScHfUdUYo6k8WzGJfOP97HkEeZOgCy6gYxz89zkmxS2YsaYnR?=
 =?us-ascii?Q?ULaTP0uUyJVHiML7GbtHyz+s7+Ukq7mJm04vHReAfSqubENa5WeEd6SVhdNr?=
 =?us-ascii?Q?1bExonh47JcLZed/fU3ty0nxnBE3Mn6jYYKJvkUPxy/NXThvKkd0lgDS0j4m?=
 =?us-ascii?Q?eX3fxygdx6O0IbKA3iNEebHhmOieMwNu4tK1yyKAP0eiOPWggatQyHQiGyz3?=
 =?us-ascii?Q?H6ogknmT7Nj+GaawIybj59VoZkuT5HZtxhJylP1vMsE/CSzXfv194SIiwFKE?=
 =?us-ascii?Q?jY/OZc1X4b7NxZsh6FOWke4Beum0NyhlqUWhhSuwwPrU6RipQKgSgTfOlLha?=
 =?us-ascii?Q?ZHGED39YDdovQOzgemRMBfHeE6cFnOSWE2c7Y2EbVCAT3hf8/m4cAg9XLxKV?=
 =?us-ascii?Q?5RxICw6QPSLiB/MtuaVL98uCUKRcMlz3WNA2pryyIrsOw1U9CobF6RXH5Hoq?=
 =?us-ascii?Q?i0ZLX2ftQuG6b7U5eOje/aBBcQGxGgPHPa97i+xEPvNwEuc1t+lLFopjHTH8?=
 =?us-ascii?Q?y6NBSsFcxm3BcibNYwtGFLLJoUJg21/VyCZr/4jb0BHBLgdf2gauIRaH1vBh?=
 =?us-ascii?Q?EE2qjIQI69Ubh1Z9KwU5VBXnqdI6tsLlPC2gDGeDnv2qWFkBoLXJZBMCL57R?=
 =?us-ascii?Q?G0pEF6R1AxblyPkeIUrMM8rgVukyhs6XKai6JzyfEmwYdUqWMhPnTYH4G5mV?=
 =?us-ascii?Q?3UKK3/f/0f55Um2NtOA5I9FlwXFt1Pub3uQTs3kVxYUKvN1gxQ58zP3L3ICZ?=
 =?us-ascii?Q?QxD47jZOuKlNzLkbxE2oKpRxvVA/zZiXW60E6LfOpFd1Spsv+cUdqMhRnU97?=
 =?us-ascii?Q?2yAUkVGE0AkrCfD2J+PGLx/gVOZbiJPSlK5C/rjSKJidDxDjab8FUTC+IEpA?=
 =?us-ascii?Q?ucCwS0ArsiqHmPt2RM/L+4+cySNUliVGjq1crD6qt2Jz1a4ujPwWNLT6ZLIF?=
 =?us-ascii?Q?nOkIxJd2ZGR7WZzvbDqg9YaUaDye73OTmVeM95iQrvq5nHhdEPzf5PT9Jx8f?=
 =?us-ascii?Q?sErQMLRPgOJHFg4DHuLVCsR/C4aITM1cO3aH7RAjBFx32gBhX9fsKM3jOVdv?=
 =?us-ascii?Q?8RDov1gPQ9uDWG9maqmb79FgnKEFkoIdPFwGu/ktRvFne/oYryYq04gh9tHn?=
 =?us-ascii?Q?RXMOwwgX1+RtK7x1p1lnW17VCNIXKvo8XADgBOdtgU5HAo02zkbateXmF6NM?=
 =?us-ascii?Q?qSfd7zoA5SDOgPTkcotoqF6lEz66b6GbSuOwCI+1pi/CwCMWSkcgMhwXXyUz?=
 =?us-ascii?Q?qohFV5ygmnFtfICFTsMwbaQPg21t4wnDGFnA5jFE/+vitEcvZDewL8NvPdgC?=
 =?us-ascii?Q?LPD+Y0xTgA6ACcW8Jqrt635k1BItwsyu2XZigcIxN7HK4ZzRmeGobcZ6oZ1y?=
 =?us-ascii?Q?94Nh8ZV4zPhIMWS0IJp/azsKcJ1h4jJY99we68Uu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591a83fc-f537-46de-338f-08ddf7828620
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 13:43:32.6253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +TkBgirReGwUV16NFBaFzovJ8i6pAOnCj3CDA3jNpdnFjCQJOVQ1pUASMOMCO4VS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571

On Wed, Sep 17, 2025 at 05:01:46PM -0300, Jason Gunthorpe wrote:
> Syzkaller found this, fput runs the release from a work queue so the
> refcount remains elevated during abort. This is tricky so move more
> handling of files into the core code.
> 
> Add a WARN_ON to catch things like this more reliably without relying on
> kasn.
> 
> Update the fail_nth test to succeed on 6.17 kernels.
> 
> Jason Gunthorpe (3):
>   iommufd: Fix race during abort for file descriptors
>   iommufd: WARN if an object is aborted with an elevated refcount
>   iommufd/selftest: Update the fail_nth limit
> 
>  drivers/iommu/iommufd/device.c                |  3 +-
>  drivers/iommu/iommufd/eventq.c                |  9 +----
>  drivers/iommu/iommufd/iommufd_private.h       |  3 +-
>  drivers/iommu/iommufd/main.c                  | 39 +++++++++++++++++--
>  .../selftests/iommu/iommufd_fail_nth.c        |  2 +-
>  5 files changed, 42 insertions(+), 14 deletions(-)

Applied to for-rc

Jason

