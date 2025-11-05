Return-Path: <linux-kselftest+bounces-44801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB376C35EB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 14:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BFA84EBA7A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 13:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B23321440;
	Wed,  5 Nov 2025 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kBM61rT9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188BF314A93;
	Wed,  5 Nov 2025 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350475; cv=fail; b=sF+JjsgtYBwF6j1l/O9UtQIdfcpXUxH2fEGIGLcxrFF0qP9uvCxi/OdLXw75Fp+yUqm8zv/5zEgoFji0bq6zR0aD+bL7MEsCl1x1GfQhJc18tJ/TmEu4AZE0RCQOtUye3s8enF0ENXa8zSAe4o7z6r7TUW2o6yOt5ETGre9+KlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350475; c=relaxed/simple;
	bh=eJwPuP64A66agv9BLvdfkp5J2O0Vu0jWbiW3jytpfYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WJO3c6FlB9QDJ43PapN1rOB0MK+WIFFlyzBHyHj7DBwg1IStDf6jeE3uTp1tnLCbNrmu9JTehjS4wXIhuGpyMHKd4jthHIYx05kWzpXQHT+rN1tev5L4f1rlOVRRtSeas2M/asqi1JW/7HAdy2PfvN6EVghlGZNhdqIZTJzvGbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kBM61rT9; arc=fail smtp.client-ip=40.107.209.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aw390t843lmrPVB1eWzZS0YGjtthhuPOUYum2YPd176JjwpX3GUC8oK33NsbsDjnd7mdIBG2NkS4DA87T2QOvdVd/W0kvONHrmwuwCu6YTEtEXCcsjd1iUJsCdrvyhxaUQofoviABum3xCkll2Za2T4Lk4f2M5Ya1/PXADgHEDWprNfaWh/5pqaHA9hu4zR09GtGMOCSKyRq6vuQljaoCPkq3fE43VG7zSztnK4fLT59pVgFi1SZG0tUnShTzCVRkBcjKe0ehOZ1cmgvNlBndveMx+01dPCr0xXyPVZUVyxCBUR1HXv6tVR5M3ZRJHhHFldRP6kGY/GL4lGHQX/Ztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rl6u/o4hVk8mINQEY9wsPAKphoJbq1svr2S5V3ypdJM=;
 b=DEAWjXwFSIw5uiKv2IuPrTs+5PH9VQhZ6WYzurv7DVr9mSwdeVRbv2f8xAAE1rEpA9UM6Tel/SvVnjDBGNODhy1YouSLCfXSNYeuGtC+AQs6Qm7XRJdSvLHYxLiiSIQsUgmYnXwznpA9V/VmhxX0fXOYuI+OdfiTXkeiwY+R+5Lk/K7dY+lm/RvJSfaLfsH0GpOylWpa6GkYIZgJ8pVtuz2z2Pck1aUH+PjkxoXfjukz/IYsfGmmONJFxU1XlSXLmVE65q0SXH9zBeJjXFWaHqN+EC7dfk/E26uDo8ZkoKki4U44uo66sr7MUJhn/jyVyKhfxy5GHLuQookV8XKYUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rl6u/o4hVk8mINQEY9wsPAKphoJbq1svr2S5V3ypdJM=;
 b=kBM61rT9JWVej69z+5kOOIIquyjfKtj5QTE6p5Xvgzrjxnh4o5jrBbEZMGk6d9vXVRqzgVXZ0X88s1bda3iO2YpwLYOmi5lwFSXJgONu8r/KPy1dsifGVqpvS7FacTvctLHnmPWQoFg8YOP5GTBT0+OYepBCUT8auDHBW9/N3SXVKMbH5tiIvK+Z3UIehlDpa7l1940Qhdx3b/VPA5Sc5c+Q4OBQMcxFee93AfgXju8a7EX6T6WwfaADKBDQeQn0ZxNB7X0rqmISOV6kwlKuFvEbvQrcIMUfeM3linvnbScSCUwFvIu3rJYpZCx3PmyAmNp2AqtwIGYS8Yyps7E3mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB999089.namprd12.prod.outlook.com (2603:10b6:510:38e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 13:47:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 13:47:52 +0000
Date: Wed, 5 Nov 2025 14:47:39 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v10 sched_ext/for-6.19] Add a deadline server for
 sched_ext tasks
Message-ID: <aQtVe9LKuQ_W3qwY@gpd4>
References: <20251029191111.167537-1-arighi@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029191111.167537-1-arighi@nvidia.com>
X-ClientProxiedBy: ZR0P278CA0056.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB999089:EE_
X-MS-Office365-Filtering-Correlation-Id: e111b8a1-8fed-401f-dc95-08de1c71ea36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Z2COt355Y6cGsSGxoOhDSSPwkdLCnWd8Q1N+QDb2t02TrvIXTY4uETd8nDl?=
 =?us-ascii?Q?utrTR4vm+64KR30diJOB6R3a5t7AmU1GMGJwl5+U3apoWC8tFM2bOQopVQyd?=
 =?us-ascii?Q?/vsw1CbY9xtMluO9DNfVNCjyWOypQLGMYJv1f43okWFnP6Kljy8hkxgsZg5j?=
 =?us-ascii?Q?Lh2ZrQ4PGWjgPtzvDiCKyMpzh5pjk58M7CNE7xhb6bIh6APJ9/umODQ+p6NF?=
 =?us-ascii?Q?n4/UcOY8907XjcxCqLBg1L7nAEnmFM7I+WcDmhlauYBusb1wHPoQ+eHuf2M4?=
 =?us-ascii?Q?S0mT9jzf6VeMT4X63tOE31XIgRFMl6spr4tfsd/iW6cETTSV4GtYRwA+8W+E?=
 =?us-ascii?Q?KSHDDjYDIZDqpmm+s41mwLG2TXHW9EZx5VgSNXvJv2z6hJNk9ngXGJo8n8R0?=
 =?us-ascii?Q?tSgOVL+f5uEIaCx7A/GKOdl+urHWIOunf2SRwttwSlbYd+oFfAf5MSvJl/WG?=
 =?us-ascii?Q?WTZGPpy0f/um2cS3/JPKMWKN3HN6/KKD/K0IcWDK/PUNJkKp6qG2iCwtQroQ?=
 =?us-ascii?Q?LyG7so6a6KkpsJitbJvbV3lcIWJd5h1mwEbLn/4dL7jPcbbt2hNY4EBQMfc5?=
 =?us-ascii?Q?KSz2tcJL+R1WwmcgOtIEHp90+LpgD/sxUzrbUE7RXBE1u6A36tyXJCLAAJt6?=
 =?us-ascii?Q?fxkwSPmsZ500MpHNqRt21YFv01cQB8kHk5jJSooEbvmJveyNaOhjFuA7T+Yn?=
 =?us-ascii?Q?WVgQYtev1Gyx0UycapJ/RUR+AWMqDTz7HnetKeXFvzqIcgxyL9F/VrXFOC+U?=
 =?us-ascii?Q?G9ZNxl+KciD0mSvXkSii1osy6Jmm9U19ezYu3ii7rayY6AaprdL90wGK7ViH?=
 =?us-ascii?Q?+iPLeleFWkR4yJwRMk9wcihHrtngbGhYqPYmv0sRkjcp9x/obfAUttQ3f7DS?=
 =?us-ascii?Q?dO1+L1Rx+n44R9MpQwXidwH4LdACWEIofUXr2BlRuq942xbltzI8atDrtuFW?=
 =?us-ascii?Q?OpHvh4QmnS43qYHGkqHEg6OQasj5wW9Our3/ppmbumF8OYBykRAXzvA+CXUL?=
 =?us-ascii?Q?pDhMqvhLHTMng2bt8mtzUUMRAefyIqM3TkZ58Ec5X9/rxwhYxJgfz9/T4RAn?=
 =?us-ascii?Q?8Ykioz4QdS6MQyUlpK5w71f0TH+mMHWxmPE1GkUMnKOLkTs4yAYvavbbw7/u?=
 =?us-ascii?Q?O2ZgEeJ1DnPFljqr81ySMIHbQ+zVxSD4776lggesWu/qMc5KMu1pIVGxGxIY?=
 =?us-ascii?Q?eCDLXfKFAa5tpSBU4CWkr7Xg+wlb6O0Hg2ixsd9tda21LJGtrY/d8ybEO82W?=
 =?us-ascii?Q?zxJ/jNOa3//WtFEncP6AkDe5QaATsE2HiGXVs8kA82WURv3D1GAzuq1ROfK6?=
 =?us-ascii?Q?FXFoIsf/WbFL0ipoYr2LVivEqpH2QgB1LW0foRjK2VPERjwtinjuZO8eXWAr?=
 =?us-ascii?Q?iEHx+ScPMO63WQnY8cHaHJ43YRqdG0wQsI+AVt0ger3hSmBezShkuvQaIkD0?=
 =?us-ascii?Q?791iHC4U5fIOn6JEa13leS7L8xTI32kQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r+YPZ9NqEvfH+czQt8yKS57xCpMkEA7PNnLQ6JA1tyJmrnAZG/yDuzx37r8y?=
 =?us-ascii?Q?2nmUhqGB2MzEZ6kM3/tAgVGUUprfxF83mFY0SGdZUnECQQFOKtgi1kHpiWL/?=
 =?us-ascii?Q?Qp/xAYFNMNAxrqnM9GGS3hyhrrBjUt1Nb/tppivxp7xHsP7dk4/ZuZZ/nfcj?=
 =?us-ascii?Q?xMlCe6P4QgmyVTml9fT1aDq9kSRQyQjeuieZoadUbIU1RmmTrCOOEP+PMlHr?=
 =?us-ascii?Q?EhS/QzJbZKboxiTLG2DSyYIe7G6vpt7GAtxu4T9cM5QpWah16zA82gsAfXk4?=
 =?us-ascii?Q?lQSi2UKo1l85a4Xzj4FDwo5YJ24TkG032XTBgHnPTZ4CqoF1vILBLzzDFawx?=
 =?us-ascii?Q?bvhzEkMLmEisbSHYas2BM0AW4/e+ZPjCDWX+0pO93o0YKUHxp8g8SCEkiS1Q?=
 =?us-ascii?Q?yHevmgdgZ8b+rVJZ8oG+uKSwN/ZYcbQVYgTw6mpwH3yOYfj1MiNv9DOBICK8?=
 =?us-ascii?Q?EpEwvVlN4twaZGHaaSEL5ztzpCwHUCR6Y7amRBmG1TfPVrc0pEz+vvXnCfUZ?=
 =?us-ascii?Q?E52zbG6zlCSoz7GlV+jMXOsANBrio48yuhfapl5kh5yQ+/5ttYXZuCafcgLF?=
 =?us-ascii?Q?Gyz5OsgAfjhu9DppAwes730vLx6juwOofOAF+WZ6CkE4o7iRwVDI1mSBpMbJ?=
 =?us-ascii?Q?j+CZkw8FcL07f7EhCkWNhaVO0yrJBIrOAcRPued8BHqohK5dsjjt5AjXW0RP?=
 =?us-ascii?Q?btwuZ0Q5pQJ8jfiS5cKqwMSvYgKZEjjWTUTvXhF4+IwObRa9iTSNPs4zuO2C?=
 =?us-ascii?Q?IPW/GdQQmuYg8WoY8sJPSdjBaUuN/Svk6a8TEwAfBOuH8DKHz6x4f/pvq7TU?=
 =?us-ascii?Q?siTnntDzbDoJ4YsrO2quBZF5+S6JOwymjp+GOILKiLdYC0NOJp4uRtNMXvdK?=
 =?us-ascii?Q?NmnJWissHnu6Gestpm+po2DNCzXXb1Eu5GPnyyMZNs0yDUOc0ZPAq3tq4Zh+?=
 =?us-ascii?Q?tFX3JQvFQ1QAXAxFunUTY7l6hKvF4c2DD/w3KbUOx03nuBq0SCljplHQdYGO?=
 =?us-ascii?Q?ff9foTLMGdAVDFszis9JpcGBSw+Oda0PqNtFvQXASp/dMjljprWGQ6mdvxVO?=
 =?us-ascii?Q?0bF248BBGJJ7Y6x16zTkso6SKsy5kJsdTJ8xqvaW30xIGw7BvORzYgpMWSdG?=
 =?us-ascii?Q?CovJsnfmz8ZacQwe+meAk/CznpzV3EIiWIsJI4+fwBu2sGpd8oxVytdRnnVp?=
 =?us-ascii?Q?eSxvnbF9gnNgUbqNYgJe+j1hVmY3u+hNYJv2790/35pZ2y8tCWwITORmcC6K?=
 =?us-ascii?Q?41BdrDlegek4FnKvOO9kMQsGg1odnM9Ypmq2dUNLWxzKRzNxcR4k67GMNlF+?=
 =?us-ascii?Q?Q3JpPViYWpYt+Yqn8v1edgwJ0IG5rjfPUpMV4p5/6E8+xwdYbk4T2KhQ43nT?=
 =?us-ascii?Q?SQ5HLcI93k5y5FiM4aA0wNPH9y3mQcL0pOiMzFc1h3KFeKO/eeGmcZAlMO+U?=
 =?us-ascii?Q?P6iBXOxywiMWIpSl2qaBQ1n9fhFW8fAfzEbPZVGeinyF9c4SkG2mXJJcthQv?=
 =?us-ascii?Q?gSlmk4VWeho/7q0nGlmXq+oO18jeFbsCMuCGS+7ShL8pu/zMjMGb4DvKOW26?=
 =?us-ascii?Q?IdQ9mFm6si6bozFIpM8X7kl7ZPq8iTLB17aEblv5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e111b8a1-8fed-401f-dc95-08de1c71ea36
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 13:47:52.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxkC3uM54cs89rUyAaP1ApyCiXG86fagMbmGPceJu1fAcE2sbehvmEp+AiGPametTB6bHlpVLD0BBie31h2EkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999089

On Wed, Oct 29, 2025 at 08:08:37PM +0100, Andrea Righi wrote:
> sched_ext tasks can be starved by long-running RT tasks, especially since
> RT throttling was replaced by deadline servers to boost only SCHED_NORMAL
> tasks.
> 
> Several users in the community have reported issues with RT stalling
> sched_ext tasks. This is fairly common on distributions or environments
> where applications like video compositors, audio services, etc. run as RT
> tasks by default.
> 
> Example trace (showing a per-CPU kthread stalled due to the sway Wayland
> compositor running as an RT task):
> 
>  runnable task stall (kworker/0:0[106377] failed to run for 5.043s)
>  ...
>  CPU 0   : nr_run=3 flags=0xd cpu_rel=0 ops_qseq=20646200 pnt_seq=45388738
>            curr=sway[994] class=rt_sched_class
>    R kworker/0:0[106377] -5043ms
>        scx_state/flags=3/0x1 dsq_flags=0x0 ops_state/qseq=0/0
>        sticky/holding_cpu=-1/-1 dsq_id=0x8000000000000002 dsq_vtime=0 slice=20000000
>        cpus=01
> 
> This is often perceived as a bug in the BPF schedulers, but in reality
> schedulers can't do much: RT tasks run outside their control and can
> potentially consume 100% of the CPU bandwidth.
> 
> Fix this by adding a sched_ext deadline server, so that sched_ext tasks are
> also boosted and do not suffer starvation.
> 
> Two kselftests are also provided to verify the starvation fixes and
> bandwidth allocation is correct.

Peter, Juri, this has now been tested quite extensively on our side and
we're considering applying these patches to Tejun's sched_ext branch.

Do you have any objections or concerns?

Thanks,
-Andrea

