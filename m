Return-Path: <linux-kselftest+bounces-40328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B434B3C21F
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 19:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120CF7C7331
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 17:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2C033A031;
	Fri, 29 Aug 2025 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MwRuJroP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0BF33A02B;
	Fri, 29 Aug 2025 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756490142; cv=fail; b=cDKHYc0AP3vocTQfMgCFRytQj7keDpuHap5rdgUG4TDOOYFR7tIGE14ffAvK3B+CQjQMzj9gu/Uqjp6qFDyu1o+RaBEo0RKm2L/FWNj3xKJ1+9E8RncBPjqG4b8+mn32uB8dIHrmI25eNKdqkWgNOU3cOGnDMdAj66pbMQfcRGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756490142; c=relaxed/simple;
	bh=QgUGun2ydkCaHCK7K7pbvbT1nBXO3KPltRNwjXcXNRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mjoyVDDgdHYJjfpWxRACpxkNwnb0EAOHqe1QmV369tJo2ZKqntEjAtWf/RIX2eVOyNP9/axaNdhkOOiqRnSqq1Zdx6t+dDGGZrmvCfSxhfkKTy/guk3H2FFor6BN/pUagCDPle1Kk1yg2DOseRH59e0JlkfGG80QgBzIEP79jcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MwRuJroP; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7K2Tn1V17uSkshR9e1i8ovaNBTWslBjC6E/Zytg5xsZl384h1xL8memjJv0iTcJAdfSwXHW9VZHgEBIvIK4Frz0klsjUb26y2KLboaVcJvDmqIblsOMX9oBcK4m3x67yynNkywBA4koKZ3XlyqkoJ7h/BKVpuklAWajyEeduzNQpUdLJ7Zzjo93dLBRrDUf+PHLmHuQp71ohWUP13wCTy8WCb+Tvn5YXsl7+h4Wtu6Daxm/lzuKds7VUvkj/zoO5R7Mjm0Ye/C+/mCqbmYL9BHb14AZLDKbpJvAQmLmFjwopn7TG1jbWijKcQXX9JNlZyF2eX7r5K/l/OzHrOvLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDsN/3FKPXrGYdH8eE6NPKGmDunc7y2bj4V3UMDSviE=;
 b=qCQdkri3ksuy0sPle4X1efhXOrJj5YYjhyV65a/P2Iynt5sND989iCvhapqr36UfP60YSRVyIO1hwDaAeJ+t5fJGrS2HYTbmb2iUfTsXSK33zpnsyGIj5ouM8PZkUj5kYMG8OF9iCY6U489YP9P2AWgDFy3wlo+1dErSYYPDLjkDPLQAQxrusWWvpGXX8NdWtYA7l+i5KIExLVPvmzA4b8Jf2j75vzB5ZYLIiy7hArQROC/YIVZ/KlKuMRV217QbvIIBp3dGHkDbSKTA5XBIWWaosa3eLELE7o4O4mfNxQ8dfIuVHaVQY3PHMSEpi75wy1xDUA3eAo6rCEXbbz8O/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDsN/3FKPXrGYdH8eE6NPKGmDunc7y2bj4V3UMDSviE=;
 b=MwRuJroP4UYgz0IZn6bLa5iWIERXigTnsESUwiVPqCkaKM5zH9wKMtDfz8/DGkuBiqcG7L+ULNmfQxWUuFBKT2YxEEEfnnN40w+2hIy2szB8vZJrshn0hVndV6UgevpKnQvU3F80QnVsdrvA21xvybsg91phOCDSoRGUqL3C50d+BCsmjwbXB9diy0vIGJotqAjiym30gU7poNeq67oOWpyICI3tz1n69dLt+TZ+sM7Ipkpsgt1XvlE6e/KEl67q6mhqB0GrkYu2klnA8LeexYUY7195qho4sbp3MqzucArh6BS/OobFIY3QDalVZLgjZpPTpX1HIzsAjIyUGt+SYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 17:55:39 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 17:55:38 +0000
Date: Fri, 29 Aug 2025 14:55:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v4 08/15] iommupt: Add read_and_clear_dirty op
Message-ID: <20250829175537.GB79520@nvidia.com>
References: <8-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
 <5ffaaba9-9890-4198-9ea8-03edba6e0725@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ffaaba9-9890-4198-9ea8-03edba6e0725@infradead.org>
X-ClientProxiedBy: MN2PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:208:236::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f88851-e17f-428a-80fe-08dde725431c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U5buIDTCH0PIpsNMo9KEqpEkzOawlGe8iXOEZ9mYJ74sVduDHZZxBSnVOGcZ?=
 =?us-ascii?Q?k0n384fvwjFJFKpse42M8isbbjvDQc3CTfasDCxIsc5s+noyl6EWGsKylC+E?=
 =?us-ascii?Q?7fEY3I7rz/cNG0iNElPQg+sydA4GhZVPd8RmeoyQewcevPIbyFkPVnKIPAp+?=
 =?us-ascii?Q?F7OTzDPg8IG/pgOmOUC3v4lAT20Fam37nI8r+CJVI2HUb7rLB8dYHxIrt+Nt?=
 =?us-ascii?Q?PklofFXT5lIexvcsJrqkpId1soC63otGzUFK3qD2H+38ZNdcInZ6CrX/yEmP?=
 =?us-ascii?Q?IbUsyVaDjhg/b+QvlUvbJx/FS89epXSXSlelXwnX0PjtMLkMu+fvgRkoPenK?=
 =?us-ascii?Q?vyyAHRc7u7juAp2WA+81rDilEl3fShpBrFkU/Ta+w2iw++54Q49GKolqNYuq?=
 =?us-ascii?Q?enN064S183hSI1pKZG6gj5LnOtwoOlCSeDgu5mRc9rqhyBHM3z6G/edKwvew?=
 =?us-ascii?Q?gllK9Z5z808tUyBbEQTov/8moK4zL9uAmOqjzM9d4G78wFHEOim2JZB374c9?=
 =?us-ascii?Q?3N6XgYK25J0VW454MaodMVB6qabVspxIc3KJmNkazRy3FJHq0/H0RRGyadfY?=
 =?us-ascii?Q?FBxquOpOZgsexCywGCEtOzIyOkbSAsAFOS8ERiG4HMXUk0YZuiod4I/wPUhL?=
 =?us-ascii?Q?NzWhqFGsY60pBZT6GHWaiwiIRlJeiRu6U2MD2T4q1RKyB09W00MJBvGL0oV+?=
 =?us-ascii?Q?3PBeuzZp7hFSgxJwdG1tCoGvLo6dXHNvXO8cyAcr8HG+FY3K7JKJwLIceTRZ?=
 =?us-ascii?Q?oDMAiqJvWryRndOY356WoSr7iV1rNcRI/if6WliCcXNqilVX7RQa54o83KYb?=
 =?us-ascii?Q?RLAHvyhRkcVIjjdKbheblkQMSjehuXbRKHd2FfWD1sISZMOU74TD3Y4cYSNB?=
 =?us-ascii?Q?aJArEGSaCBLIj5s4b/NBSJzvLxiZO+pbUkNBU8FTlIL4EvHDXR4r3SKAxc3d?=
 =?us-ascii?Q?IOUsPExTBsBj1wsR8Vp9SXKgUn8NpxTsK3x571obhNr47lqJwAiNPVrGyqtK?=
 =?us-ascii?Q?RWOLzmliVhR1p9Xz1uEGouqsQPwqfAc33wl/WX2+pR5ynlfkg/XSZ9nCCPEk?=
 =?us-ascii?Q?LVqiwDoOOA7TNTMOZZRZ2JcxDSMeYnAjfpIt5muFmCPGOIcFNE4+4yNK8zjv?=
 =?us-ascii?Q?8gPZZB2iBi1PifPila2VT8fo9qq7/sUDXYeiNa6MZbm069E7vvCta/0kOfuL?=
 =?us-ascii?Q?yP1h1gwLAwLri2lddtSNrolrVKmxCuWU2ppEtm3yoSIVbIya5bMUW47ZD0F8?=
 =?us-ascii?Q?VIhbC4u9NtXX7jY9yg1DRgrbHXM5JD3bCk2VZMNIfMtcm8lvyQ1Xn2B1fmI3?=
 =?us-ascii?Q?cAGKgooAwP1ofrSMGGJ4osm0VlTOAV4oUnhUfuRbuo6SwtPFg6g0IsPPmBb3?=
 =?us-ascii?Q?w/EZZZZdn+G5RnnV551DVr09VaIWtCxqjhvUx64dzlFEP5BeIb82sAXzcdQs?=
 =?us-ascii?Q?PM81twEhFjc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FELoEqj1an/LCgQJZsIOjifWEst97+vGlzsuwqol47Yiz6yHQCeukS8mhymD?=
 =?us-ascii?Q?PV5lNbfClvGLDY9N7GBhkYhbXn6SPZGwS4/xUC9CTng5UUb+ui+AGXGXK0a9?=
 =?us-ascii?Q?7818XI7hY/uFZ89S7YKOQgrN3F8ZUiuCoH+cnmYFZ2odg7Cg1/9kc9WjTp6x?=
 =?us-ascii?Q?gfEF9DfTz/g4Y8lS0Ejnlx1JSj6vfUEL82aeZn8CeIwMBMXQVUq7zqZM+ZYs?=
 =?us-ascii?Q?WIa6BGQnOnCBynHs4vCbxZ/OiigSKG/+V9uukIjs8AgIHQgMeejzz6MUKc66?=
 =?us-ascii?Q?1ACEqqNYueQ5uTzI1ZNX2CX/TGtVhNVjontdQs8+OwgV395q4P6/fFNffdVJ?=
 =?us-ascii?Q?16wSCCFaPHT6J+9MXL6nTvJ4iXbDqQkJBW6Sp6NAEvr93DVPrMY4b1UujASe?=
 =?us-ascii?Q?KCNjH8uFQOuuOmbRUBa+xMolTvPikEWFq6UllXySYsZmKc03TMhP4lj6zRGk?=
 =?us-ascii?Q?74M1ihnZwTqxmpghpzVo/Ko/94eY6JIyfZ6riXdttNJoHABBsCOSFKbW1qwc?=
 =?us-ascii?Q?jlOKTk7WAwT8ALzXhb3IHFSwQMWbaVpTxmgtgt7CGBTme+WubDyMg61odS07?=
 =?us-ascii?Q?E/z9mhBrqvRxDe9MzKFILeGEbbWp0uDCTvY6D8fa+SE460zcLJwKElq/VcZh?=
 =?us-ascii?Q?A0Hj9XzguHqFdYN82VmYYf2mCczS11yfAXQcPCeRgviNgIDEYEuclprVC2Ak?=
 =?us-ascii?Q?0ar5xxu0M5EdnIWVI09s7OLHnU9q65wjtLmVNi0BkZJMiXT0SCSpJ9czz6oi?=
 =?us-ascii?Q?K43UrYbYUD7pQOGvkif1ICRbje3o7VDJJU/GoRiFuGmFUxdclHGv7Z+aASzx?=
 =?us-ascii?Q?CjgT4YlTpoqKxbFLxBWz24r880dIZLMH95uhcGC1wTyGP8AeKB4YAabjOlo4?=
 =?us-ascii?Q?Wz7DkhmNld6w7yseoUiN9VFlaFmxlEo1FgqWMe5hvR1spO+z4urh36YqaU8K?=
 =?us-ascii?Q?OZfzy6IaSqusxGxTV6oGyh1Lu+SC1ebG6bzrmNPKggwdy3VFdqTb2a1W57fY?=
 =?us-ascii?Q?H9yCa78FVeawrK2brUBTR1rD6kWnIRchuJF/SrPBWy0VvyJizXCTCD8nDeUa?=
 =?us-ascii?Q?NAlugUyTmSKP7+ZNm4eDdPv2IYr3IH0SvkpPRxbpG5K01rHQhGFSCa+42ABF?=
 =?us-ascii?Q?LfVWP0vx0OCMS2F7eLF+8/z+15+dh4TIohm3T7HNMImSsKxAvqFBdZOdWMt+?=
 =?us-ascii?Q?tQYxyKIDbYlxPbDz59ZJxeep+GKiRNykjv6XEcPJUaUo1rct+AjUvvoCb6ml?=
 =?us-ascii?Q?ACsDWdzmLL5Fb+m2ASqmyAWXivOjZFR9+Jdgk+U/YC/Epbq328regsvkKvGa?=
 =?us-ascii?Q?H/nkFIOgbefWC8Tjzg9q8p0JEgbgGU54QsXnbb9YrtdZy9vLZhn4J4lLbCBB?=
 =?us-ascii?Q?/3QZzpxnwr51THnzkyu5GWjO+x1NlQ0F14TGYLLHlS7EgPYVT5fYWONayw+E?=
 =?us-ascii?Q?WmKFEWw9AurvmxzEuIkqlU8WvM86HENuLoNJfXllogk/RtJI83BStwZe0fVU?=
 =?us-ascii?Q?NpwYaKkt/Ht5G4VS+UjrkgGejXqpzgTLmt80xtFgHccjyIK5DMZoF68bIOFE?=
 =?us-ascii?Q?DPDNgMfl1VCn4riqTRuuaQEbnx2OBBiVjaCQdvtn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f88851-e17f-428a-80fe-08dde725431c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 17:55:38.4965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YcdEx+xyE+JxsK9gMLKDaKphp6BlKr4WKQz4DHc6XFXk3eUrGsKL9TcPoAaJ9WEL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180

On Tue, Aug 26, 2025 at 01:47:07PM -0700, Randy Dunlap wrote:
> 
> 
> On 8/26/25 10:18 AM, Jason Gunthorpe wrote:
> > +/**
> > + * read_and_clear_dirty() - Manipulate the HW set write dirty state
> > + * @iommu_table: Table to manipulate
> > + * @iova: IO virtual address to start
> > + * @size: Length of the IOVA
> > + * @flags: A bitmap of IOMMU_DIRTY_NO_CLEAR
> > + *
> 
> Mismatch between @params above and function arguments, both in names
> and one argument (@dirty:) is missing above.

Fixed it thanks

Jason

