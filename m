Return-Path: <linux-kselftest+bounces-33791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1C7AC4077
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 15:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684FB177D70
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 13:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA354202C40;
	Mon, 26 May 2025 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ut00by3A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6953B45009;
	Mon, 26 May 2025 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748266251; cv=fail; b=fFd7yPfjvmvOeOKjRmQXpiHn7EnnNny/yJoggMi5ShTRuX4RRCpVZ4C5/TvmKxloU++AYXlRmPJTFj+8IUY9rtVjD8smvc3oijIF/EROQxbVH5vInW/7o98MmVZf3x7zFVECzBZTZqvYCwobcwRFfdOd/OQnXtA+Y8d376G1bRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748266251; c=relaxed/simple;
	bh=HW2hQTR8K/hLgbbRaJh2gUL3OYDZZ3IiLuXXbT0Cl6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C0ezcGKBM2P1u3ZncOU/GldRFp1IHF+4KhIh2Utgx22xDXNjRrdntmWX2T9TN7GCzXYJt6Z3WmiiUERV3O/bIHoVrc45ijwKmXNGW7CJo0Gguh35OEN6YkOvRucQ67zjnxMurDEtcvoMUgC5bkD0PFoapL8DFe0y9wdcHdUq/30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ut00by3A; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJlm7f3oAzdXZorAfkB+tY8/W0zcSiH5uL/FpmNtidQQj/aaZWW7wiqL6PGHTg/obcliQvws//3nrNOh9xyB8ODApB9JdqrnDk/El+ES6FagIwP8X6guepy48SEhVfwQNz8G6UrX5aYh4NsaE/tyRwxmSQc14sCGlaKFi1IHr+5vanqtF+yhxIuI8oO5rVunpLJfgdw6QteoD6wjY/I1WFc0D9yEpk9NaJoamP1fSvFTBDsy8WUGdLXEyxlT8Ri5OtrISH5KKqXtr4KFhBJt5p9MUR4QdvBkXqNh3bGGoijV47b/6kQlWlof/NV6Fj7gvBxuJXwsWN4+V1gZEouCBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnBYyrvKQO19fIrvVH1iHkQkLCAlLdUcINadjeQdBLc=;
 b=ofZvcMOWYM3DzIn7n3gt7w6pRyg5wVLqRzEloVF65mk0vzHDgextiknBtKfWnbebqn5pVucA7/Jp5bQ+FjfBMdlxVAczzgrQpqqy2IJ7vfKuYGQO8oa78E8AhIolobBmSUmoSDU396IdK65b2/9VuRMqzohH8XyAZr+jnr9zDaZNW3KW79cwzTxUmEoyC30PFa4p4bCwsUtg8Rz6hz+l0g8AeMuyVOpJRCd1a1+IxJOMxSvFXYsS+APY+7kf9m4+g7rtNbvbFe///ur04PVZDQtOXqaBGqAcZicsATUAGm73l5v18IdV3fTejYkENJHlw0L4uReyypkYlOaNWq+OxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnBYyrvKQO19fIrvVH1iHkQkLCAlLdUcINadjeQdBLc=;
 b=ut00by3AGK3aPkz3qBE1b/ACYlWsKpRrP9VfT6XOQCBKeUQulrqGKRw0xub8dC9+Mf7IvX3B5MvFvIzwmM1kbjreKqxc0VmclEJp6lwJ8wqFJYffwsr0Ufb7BG4C8LKe2YzoTP9IR93WClwRfN6UTuF5sCjy+6MZPCeF49QNaQVPmttz5Omm8rvaIvH9cG/SS7/CMAq+jz3KkQZSq0+hiFKs0vIOVfP+HUHdwMfNq7XPByjWMaF2s9yYLvCRigytS2sQZSwI7KpC7185RabAXxnjhhm9wVQyniX45WbrrOBAaYM+drpGiZvc2fhWRoBsM6NbLfLgxobikgkaSrl9iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA5PPFE3F7EF2AE.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 26 May
 2025 13:30:47 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 13:30:47 +0000
Date: Mon, 26 May 2025 10:30:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v4 05/23] iommufd/driver: Let iommufd_viommu_alloc helper
 save ictx to viommu->ictx
Message-ID: <20250526133046.GD9786@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <5288cec9804e7e394be3b7de6b246d8ca9c4792a.1746757630.git.nicolinc@nvidia.com>
 <20250514170637.GE382960@nvidia.com>
 <aCadeeP+Z4s6WzOi@Asurada-Nvidia>
 <20250516132845.GH613512@nvidia.com>
 <aCemeved47HE6Q2B@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCemeved47HE6Q2B@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA5PPFE3F7EF2AE:EE_
X-MS-Office365-Filtering-Correlation-Id: e1876dbc-34bf-42fd-cb9d-08dd9c59861d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pFAlow/I7M519XMW0PGCpLlmVqJuY01rrsSstpO+taccOAvpESUOCosefI7R?=
 =?us-ascii?Q?oWmE/6WZjEHxksfCj7JTjMb1PSsBb9EEEOITmPt24T0JJYOUn4vcHZibbFTT?=
 =?us-ascii?Q?yvHvM2EMlMLZY9m9LFQ8cOyUGFwv+Wp9QDd1jsMObsYFEg1FTLFT/xn1woNq?=
 =?us-ascii?Q?ESz+qgFnNWkbK/jryk3kzuvMgLdPkBcsc7jH0Jsp5VaZ/W04h2qzxNF5a5Ig?=
 =?us-ascii?Q?rFjQPcOQvIy7EYWW0dOAUQBbGhseRMzJLUIiYEETjYZ/cqe/Ym/Me6B1e3iD?=
 =?us-ascii?Q?wNmh5mDWBHZhOqpB5qa/SC6bKnVBMgTUlTJZsI3Zqm9vQp5U+v9HChsFVl8J?=
 =?us-ascii?Q?2jkck3kpRYdPBhj4qqXBO0LHATyW4KS+toxsfUK105cPpOZflkp1fDB0U719?=
 =?us-ascii?Q?m746uLaB7Z1u7B4OdY9vjtwZTMidQy25i2Z3ZY3f26nG0988IW71/fnKMpJe?=
 =?us-ascii?Q?1xonLcBbLGBJEv4P+fT/eo23VSAJ2Uis+O15GJOyIvFtnthTpXX4oqrKIkHT?=
 =?us-ascii?Q?pwsfhBcqDdAPARxEkaDhZZD7mcUKRY2zI3OqQ0FHF3iLGidwnj2lHBgNfLz2?=
 =?us-ascii?Q?uQXNU0k97Q+eigAuwx+jmPod/7m1HLabtWYOW6Eo4XAO2xaf+v7Y0ZSjxGvm?=
 =?us-ascii?Q?t8PPTD4FJPPj6ywB76twNYWHBlh2VMjWUcjX75/bVl7d86v4GQgN5ps9bKZN?=
 =?us-ascii?Q?A3CQf7Nw5hR/WmxSo5xDM4gR57v88+SQuyx/Y4no78UfRS97EgqBCJk7kmrK?=
 =?us-ascii?Q?tpoaOOtZjNCadrBqWJKE4lmPjgbUmQ9z05O+k8G5NbAR5Lhk3jYXsB1KGTos?=
 =?us-ascii?Q?lKSIFHVNs50b7L0v7/5yqdC+TKVTCl0T5Hub/BHe9jIRlANftKCF5KWlTjG4?=
 =?us-ascii?Q?bxFnpPVOUMYHkET/fzavSY+1A9M8QwrZ2PMO96qQWcrZkF8eomp3J6b4145b?=
 =?us-ascii?Q?wViotJSGX5vPy8Fy62JW6ay9dFJfYhsZ4HgCtjesXMEme6RFkR6rOipFTWu1?=
 =?us-ascii?Q?CLVKo8rzbpz+x++D2dVg5/noS0AJGMdstknJqh/slc2r6P2/M5ZwA6YEiZjD?=
 =?us-ascii?Q?GVgeBO8go7hgTqHpIVFrqi9VmF+/iEJ1x8rR1+vVNCgmnxH5mHH5qHrQK6QT?=
 =?us-ascii?Q?d52nw6BVzH6bYAO+NTKmbJDPs3mrqIXMJKWkTV9d09fqNYEyZkxmB95VR3kL?=
 =?us-ascii?Q?ZLlaj4EToUXtRhKlWw8L/hUYmOvWe4YR6umhXbART7weXU4dIcm+7s63FSZA?=
 =?us-ascii?Q?wKTiHjqqRgrqWLouJiJTbY+Ae34sELu6vf9RlCGJrxXoT9wSGdMQqQumS+JU?=
 =?us-ascii?Q?zr/4A7KO4lybgjYbU1uEpciK49w8Cp62VIB+21TgN3z8LIHVkWK61nknIoVF?=
 =?us-ascii?Q?dfKcr0ltOcaNrwWF+1NyXqNkR/r2x5lMJalZYcnNinqO40kOzm1qqyoEQ33h?=
 =?us-ascii?Q?YYKs2qhTgDc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o36fO8c7YgiFnbHOBT7DFEwvWBooaL7Se4lQDT0gxw9cqcuZPnRSzMhwFqHD?=
 =?us-ascii?Q?gdfNA34Wn2kZ3TMuky7W1H3dO5+s3tB2KP2DlT5vWLAYUAb6MKwvCzgX9wAF?=
 =?us-ascii?Q?g5sq1PjcSyNCn8C5vID327c3q8D/mGESueWibK7CQPSdXE/HJBtcei4a9f1h?=
 =?us-ascii?Q?/9DR341UKM6qeniFZT8EW/P5WoEaahIANfgdjOlriNPfmNyMwqZR4UW59ykb?=
 =?us-ascii?Q?Qyrfbfg74fu7b02QcwnY+GeNib6B3huaBhCmCvCllQlkeWl1lxbXtEhgdbzG?=
 =?us-ascii?Q?Zxc5ZtHKRl9c6zvrhnzKT8zQba2KAb+n74xqLClSo/jSa+y7UjbnlPstRbt7?=
 =?us-ascii?Q?V6eIsBmexr+yFeRiOwGYCpvHR1qbLhfwoIRQi0+BJhsBnaH/G85GnIFIxb6h?=
 =?us-ascii?Q?jf3ZhJEkn+44fJWXZhv07fXlNpgOOGgGQ2gkS8aCdC1DRkUTCyV6wuGTUhau?=
 =?us-ascii?Q?Hxx/16phb7wucx899yImqlmjFcyJT08iZl8Ca9AtpJPqcH06oChMd6rqE5ya?=
 =?us-ascii?Q?nCSTLvMCwN8mlfYo8nbsgRWoccOsf+Mk8FuTVib2RwQObxd5JS9sVxNdEGiO?=
 =?us-ascii?Q?k3Wo5YahMMnRWs6FXMOlgpdU4YaqV+BmzUnZPMTbfNa1RV8MH3qN8LnwppQ0?=
 =?us-ascii?Q?645iC9cvezCnziDLor1qGorm93cWDzU16qhDcFxuGPLJVEkX42J/9hwlzOjc?=
 =?us-ascii?Q?BxU22mq+nzycClyfpoWHzVg2GnhFZwGrbQV1+pI9iTRdWRVvOn7DKeJoV1/B?=
 =?us-ascii?Q?j3KFUg8fdkNS8SqXFrJKyu+FIexzvDGin9jKaqWU+FuIFLI+Ixd2EKAxzphV?=
 =?us-ascii?Q?knlPsHZMPgFlHIXgXl/1gGW059Dw9El8M3sVPV5vQOJbc6s18vT/DOhlrZ4w?=
 =?us-ascii?Q?FYGRQjtlVZZjvMTvFmHv9rqlz98wNrxypMFLC3md3nKfwfEwuEFcBEb54IDp?=
 =?us-ascii?Q?ZfZkJRusnu9Hj3JSR59E16Ag1T3Aw4JeimHPk6gCNN6DgRlUnXoGIk8gEfUA?=
 =?us-ascii?Q?fXMXWB1YJ78AiqdgOm1hN84tVTLqqM+boFb01gkNlTuY/XKs0PJj6B8z/vDH?=
 =?us-ascii?Q?uYs5djihvxKgn9E0qXuDcgJ2bq2HZSvXGZw5dhsR/bCixFoqIAk9wEcQeUlO?=
 =?us-ascii?Q?uwyuLlPOrwDMvBpleHDkMLtGzjNxOxM/8L9ijg9msJ2+o7S3hLMqJLdxrW57?=
 =?us-ascii?Q?YaERv2HQMFryZZXz6kasWfKB6kpsXGdQykUoZqfPJeU3y+U6CNhc7YzoGuoB?=
 =?us-ascii?Q?3NCvkBcFFUS5wip2ESBpOEvR/SCFeV5SDEnlzatKC0otLSrs6bZegpDn5vZf?=
 =?us-ascii?Q?W1FxS14Kx46WOsFETvnV1+KwwKGkK+dRVmhFPClGBJZitYIyZgFJlphl7zwr?=
 =?us-ascii?Q?xuxjmnnZq/HW+NBK+qY2RjZFFyXfx50UgdNnB6vUGDo1a0MVoNUHuH9HI0dm?=
 =?us-ascii?Q?izQbczdtkM32NpoAzcwMDdxQcXXwJ1EKhIcJGlk+mXeLEj3Kqks9vxsleEin?=
 =?us-ascii?Q?8Wdil1r+IOdDse4DpWYN0ZYhb54u6+NX4YgoMEyvd0FJxeuAKU+JKeUuu7d9?=
 =?us-ascii?Q?Wed6bg5ljyt6vZcbDGtbqf9s//bHm1skKAv/47LH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1876dbc-34bf-42fd-cb9d-08dd9c59861d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 13:30:47.4954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UotRtQtPWOd8JpTh9aCsF+6kOMCdcyPy0B+5cifeV2C2hQUaYdylWfVAByi4OBVa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE3F7EF2AE

On Fri, May 16, 2025 at 01:56:26PM -0700, Nicolin Chen wrote:

> > You don't need to move this unless you are using inlines. Just use a
> > forward declaration.
> 
> Since we forward ucmd now, ictx is in the ucmd so we need this
> structure for:
> 
> -		if (!IS_ERR(ret))                                              \
> +		if (!IS_ERR(ret)) {                                            \
>  			ret->member.ops = viommu_ops;                          \
> +			ret->member.ictx = ucmd->ictx;                         \
> +		}                                                              \

De-inline more of that function probably..

Also seem my other remarks about not storing ictx so much..

Jason

