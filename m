Return-Path: <linux-kselftest+bounces-20966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C909B4DD9
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 16:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE312816A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8B6192D84;
	Tue, 29 Oct 2024 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="shRb8zWV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018AB22071;
	Tue, 29 Oct 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215557; cv=fail; b=k51MboDe9onhdFIm2gOerJfFXaJCBzOhIhx5V17R/bSdi8mzsmMeFDJtyL8J69Up8ETaKggkq0TK1IZrwXMGjQrnO4P9bz3u8jtM5goDQKgsuyEIJCh1UH1qT2xC3yhJdRR57mbYa6aNOmSEXjMKxGwrwF0pS+3p54V6BsMOWEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215557; c=relaxed/simple;
	bh=V2eor132TipNsOoXwDtjyJ/bChN9c2mrokuYnoyQenk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kxozb8ikRPCsDR/6/gfJzQIUDXwxHQTSkx9CuWZ8LlwKwZDXrf2VM0KwNLejKm/fiLKE8fFeisL0NQnoV8Hi2kojRLK/Xr7VATTdpGE9ak9wYcnhcbDPt0ogTntUhVpjGHHLSiqAGu8+yQaJxhOONz569/ISajEzRerZDEPKiWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=shRb8zWV; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KB4AizCLvRYE+D6M2r5FY1qaPKVcbigXsPLzEeRSxrsr4CKgXOclCbL+35z6Nn+36KcRJg6VEoCFMk6puDh+E8qbtCXOxL2YE7SZtOFhHKfUmqY0Ib6FV0N85TRNYDMrTYs7ycpRrbSH/YW901HVHetIVwPg30YLKxpEkJopHwbnmWtbHQzRsd9IudJf2eZr4Ev3oJMsBdc8HEJAlo67wPS4XiXV9r49IYV10SN50fQfeM2ByMkKwDGrm/R8Ex1DXGSZSHZ5eRp8o2PKXJUvebUa0WxEuzxOGjkNGi7/3FjIUBv/o9avlCCYQ+kkNjvpsOTubIYhabRliU+0xLdWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHvBzl9w3OI5R3OU1r4sk6CHWCg7j0B0EECaJJvUXSk=;
 b=Do4P2S1EEuxOqhZMxDyVlpDGKaq2YEX/G5Zkfu1yjnYxEcPLMC3/OUHrZgPNN2d/unDXTv3ujAPDxX0GXy7gAd89y99YsUEyHjj/lG1LSGGMle6KrLqVr9xXtH0wkQ0Oh0pUKofy4D56Y91z/plbly2aFh2ypEfaOSyZKHy5OGGZYt9b+DMIVo/20CpEAN7aOKU6/O8uqauGt0tTC1kE+B6c2t/BSvsb76+KlD22PEkiKoJApoSTSXg2PuY8tS+CxdURppggSalqXJNEryz917LwVl2lSk3Dv/sDDwZ/usAOr8YhfQXV4HMF9jEam5oTJ/vxc5YaJ+k3Wyy/iiA4eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHvBzl9w3OI5R3OU1r4sk6CHWCg7j0B0EECaJJvUXSk=;
 b=shRb8zWV9mBdJWgNjgX07zMgDOogCaAcXkT6tbPn4EG1w+Fh2D1VFbidNPipoWRXrXBuc8O1y/UxhwpzqGrrpWBeZiIbsStPw1T8rf74H3tlp6lwxeDgLJt2we86bfNupk5RTzFb4ZeGkLyS5VveUMHHOQdJVuHk7tsq1f7SGhK/bpODrcAsMIdLeQY6BmU2x1AYEbPb9lBTl9LbIIn6PttyUyof/XbpM9Z1AAdit3GFvsqAEPvV3OgkO+spitBYKOJupKBWR6iXdWwQjVSE6rPdO95u0UAy2UIOKklZa9SfcsqjtzcA/upRotPhJapfS/sx6bjJ3h1MPZ0kOh+a7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 15:25:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 15:25:52 +0000
Date: Tue, 29 Oct 2024 12:25:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 05/13] iommufd: Add alloc_domain_nested op to
 iommufd_viommu_ops
Message-ID: <20241029152551.GD209124@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <fa5231cad2bf4b3ee9a18434a8981acb45f0e0b5.1729897352.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa5231cad2bf4b3ee9a18434a8981acb45f0e0b5.1729897352.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0257.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 859a2065-4380-4920-8d83-08dcf82df95a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?coYbDyRw+QqlVaZE3iw0noXO+gQ9DUdN+zcUz1mT7onys7kKh/oZok0W2xSQ?=
 =?us-ascii?Q?hiA8gV6ohE2oNtfsLQ8zfd7zttCm7n6NCS9NEt98ErQs/gAKIQFD3lmQbBhE?=
 =?us-ascii?Q?66JgM0RptiP9LyIBG5tKxUaMMRBF+rlrGrULKiYNF6pfwgDWj+Nb9PHsbHtL?=
 =?us-ascii?Q?XjMaLai0kuHcT+bfWK0j9T1812LOyeFOXMaTFsTT+P5KOft79yIWINaUqenD?=
 =?us-ascii?Q?fcOPqrdRzk6QtQcFKY6w6sVUIQFm6snPvVsJcoBLeo++E8myj9ayuKddJ+AB?=
 =?us-ascii?Q?dmtPGOTKn6kGKXzFG/0zkHN8uRMFr1JHQhUGZIKxh3FAtowrxJj7b4fqF5Hw?=
 =?us-ascii?Q?msa0htno9j8Tsd88hHkFHsz53W2w2X9x4qg3rnmpwv9l5yVG7YoUAhdJPONh?=
 =?us-ascii?Q?RntXzaZlCUmFEtc5aSm8yOmLa4Iq3hEAa+ibKm6OIfujCy/LWHiT9bKE1Npv?=
 =?us-ascii?Q?CMNZHFLZXZU1MDFJAwmJM2pU0293P3hobFtanawMOUuO9GosEl86pNDOhmBf?=
 =?us-ascii?Q?/NUl4vv7xfxkOy5OzmsCI4Nc41HGCASVWjOu1yl537FVemcLecKYkd35Rp/n?=
 =?us-ascii?Q?QIYG/yHkjp1/lQ59C/dmg6guyW4gRY9Tsw/XIVI43l0y18wn4etcua3/EbaC?=
 =?us-ascii?Q?m480OndAZ2yPD+XYohBw/y/37suwvnv6NDoVcIL8TOsNGXSIv7nmCgz0Ls7+?=
 =?us-ascii?Q?gzup6YIGShwlHiEcGes7IsKgDJld2zYSSmWHZrNPDhkv9QYIK1G8NYyAq/6c?=
 =?us-ascii?Q?4sv2Ys6coDd0eviB4VgrXXG2rSzz3/Rf8iXQWQZiDpwJBiYKYZYrhpMF5zTs?=
 =?us-ascii?Q?WYRvFW34umWroy8RWE1jzeKWgnLpnHXYcC5iRYL1l2JvBowpY54XxaLVzSrm?=
 =?us-ascii?Q?5+ZbJcSrhAKp7KllwJDdKuK5LaRuKEfK5itmgx5geTZ+uenLnW/0fdPec75L?=
 =?us-ascii?Q?/+8nSVGK6vp/CGLpuYLwHWn5wZsVwPoUP40V6av2x4nBN0OE2eR5wN+2z/4C?=
 =?us-ascii?Q?cu9XaXws7QIPkV9tfvEU2lj4eNSvaUebBGeXtQkW7WfuzWkDwSSwUnk0Vfeh?=
 =?us-ascii?Q?WWlJ4ak6K3kcR5YIt3kp0pOCqvvc6JsiefIt/m+qqcMBoLeT6ITqaqETIObd?=
 =?us-ascii?Q?po5xTozE6WBwo06SuFQLz9cinXm0KSdXsm83mp2KpeCgjzZCMthrnVUfjXUw?=
 =?us-ascii?Q?PNGGibAnwipTBtFsd8MTkVPXu0omrIYdqpD1yx232Rtndu7bsiggONZeLx6N?=
 =?us-ascii?Q?os8NfyqNrMnpUBkviUtk1FkxZuAEf8QoLYIHCVKFHFHQSVhIRo3FiaXR3U42?=
 =?us-ascii?Q?d7NfQx0ZoLe4uF9DxrFHq3hj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LJE6W5gSciSQt/sY7Tokk4DZWxf4VxaWTYhgS4+YyPbZBU7Z6YKNMpEEWarF?=
 =?us-ascii?Q?yBwF9zxDE7IJMDPvuPcmK4A0S5EW77TY8I+u+mTdIlSSB9n8H2zC2Ur7Mbsp?=
 =?us-ascii?Q?7B6KNeBdIs9HJxdoXzUjZ6EuvKMDYtGdIOMWUdIPBNZU7YztpWwhRunBznxn?=
 =?us-ascii?Q?VZnxwhsmleitF2PZ8lIwk6DIRjJw1yHOTPyPocum5TZowJdMzU9+ouy1OmC5?=
 =?us-ascii?Q?pHjy7LcLSbJ89MRFO0iWIwkQuuowWxI0kAZ5HmK7DnGD3X6d6WS0RMlE27hR?=
 =?us-ascii?Q?5OxnCdPFyofKNeqZ60oyajznnpo4eNMX0UGvQslHcNDG8Nw1TwLOWRA9gkmh?=
 =?us-ascii?Q?BGyuJYAXLW3ZhzV+gszbBcxlmAWGl00gJ7GZSGoOCszEbex1QeFQ2nflZDH9?=
 =?us-ascii?Q?at6doJO+IIUIVaH3J2LKG3dTYVkWeDpA1fsEk4btvN5HATTy07gHbI/1Wt3K?=
 =?us-ascii?Q?hEFKrHLBq4sGH1nA5iegWQK7LsdkcqZI+PpyOmLqGbImYimfkwN/+nVe2J9o?=
 =?us-ascii?Q?tm+1/5daFm7+ZJTmhyVxV7ebVSf8Dp7nh4RznE2H7CJKKmK7PzhyxIBN+Aq3?=
 =?us-ascii?Q?XjZKXaDnEVKAuQWWxNPpBKam42qsPNTey7ldKc7EBtDVWjnDYmc52hLANd9S?=
 =?us-ascii?Q?auOlIJ1ooSiWRHDYHpb2v68bktZZIM9euuIuI3s3pO5cTUfTMabqEf8u7+X6?=
 =?us-ascii?Q?/ML/J9QiXmhtkW0KebNOem794lzVbyAYYUvU9j/gE5At1s6KC/AnKFz9eEX5?=
 =?us-ascii?Q?tluJrEyk/yznkUl+2LZO8OTl370Fg250y8q06jy1aZgTur4nevkvuiyytnjR?=
 =?us-ascii?Q?YYYBU/ulKHBrWE9KUfBpgJ/Fkov4b036Xelc2ADcLNleYofYlMI8LnFOX58B?=
 =?us-ascii?Q?2Q3mFbHVOn988eqLOI6JXZ3dskW/J0EBjI3Rf37fshAeAPcbsGs/IM2Qs3uI?=
 =?us-ascii?Q?q9DQPOyBsxftKup+S32slRfDWO/abXrST+GjvsMnP8GJ/+Yz74T+YRHLT4xs?=
 =?us-ascii?Q?yziU4bzwIvuUYJJPRqmckNaw9i7zQgJXAer3BpeheM4zwXXO9w47O3wDN37d?=
 =?us-ascii?Q?ZRw7d887x2LeADOTRHXXppKwvc3Qqh/vGbmzJ3tXkbsbVu1RaPEs+Xr0tkBq?=
 =?us-ascii?Q?SCIGvC0PaNofc+o+8Rkye/KDjQlejsfdOXq2aPXurcYpWJMsJRZDsGWVqadR?=
 =?us-ascii?Q?R/AUiVcjXZ3P2aTu3S1nD7HyGFWMIhPij5o4t4T16jteE7am0I8CqnEI1YfV?=
 =?us-ascii?Q?e+mo/iuRvHuohKUVxSrtXxcJNdHDxZZbqR27zlz2o4ZQBB++hB+qJEbKNOdF?=
 =?us-ascii?Q?asxdwFCJbTDNwDQNKCi8mS58EiHieamoOzlQCIQYeOYihMF0PDRUbT2t6lwk?=
 =?us-ascii?Q?OhhxBtBwxR5u0gEg9acT/+Su2t0EreFFrIi6nDSK3kFZjYLssxSRJzidhbGB?=
 =?us-ascii?Q?oDz6MWZ7LVpCXPhCMBZljLZUWv8Kj1dz9o3GiuDbSD4o+h2O1xd1mE9odvHX?=
 =?us-ascii?Q?e6lwfSMf0Hlxg6rAMjBkQr+tICyA1fGTL7ZnTTMX+Tv9Ta5fsgg+DkZfyYHF?=
 =?us-ascii?Q?eaj4ASjcuCkdsdKlyCZCfvEBK4Y+y3XxytEDGrXr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859a2065-4380-4920-8d83-08dcf82df95a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:25:52.2688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WjJuK3Dj91Sfm/TD8nT/+A0faVqoApwHSga+sKO3Bo70xUCAumUQYv+qQM1rJP+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177

On Fri, Oct 25, 2024 at 04:49:45PM -0700, Nicolin Chen wrote:
> Allow IOMMU driver to use a vIOMMU object that holds a nesting parent
> hwpt/domain to allocate a nested domain.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommufd.h | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

