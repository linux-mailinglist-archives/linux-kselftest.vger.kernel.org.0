Return-Path: <linux-kselftest+bounces-14682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3211945427
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 23:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75B01C22C55
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 21:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB51714A4F8;
	Thu,  1 Aug 2024 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p30UyR8f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E112714AD2C;
	Thu,  1 Aug 2024 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722548300; cv=fail; b=kY3jj+MXEGLBuuokjPzTCZJ2930jsZ+KpDhSyDJ3JO0wYTTJxIHbcVTaroCeOwZsAJpk1aGQYuxhTlJRjBdgyYCTnLhn7nTmTyjX3K9MEY87IBoAcqcj5KKYQccWIAN6icb1OGs6IOcRvXgFPxFjIDCyYEMs7dnja/shmnFxAnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722548300; c=relaxed/simple;
	bh=i1BjtLDN2o19OVb3CCHpjXoJm6a9GV4EBiFTgYqgnxo=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=T5zv1WO3qlF8dCzTVk7oYbJeKAYheC2pcZ8kcbPJCQlTt/poOKQSjqNYrpJqZmu24JtwIwzLavymOnovEHjDjCy4lczJXQzi76arNeaVA+Ob9kZHps/r+S13AV2a0bSwQnake3lojnZ0mrXJZokmGiSpwC6Xuze1IiF5F/fprYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p30UyR8f; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEoBG0xiSFeQrGn8PTrFdPrHv0tMYObZkvLDTVI+2ReQbydpXAvL5PZl23xn4nuOwpiFfMhmvoV4mzqBU1pgHXr1DU6qkSU62qITW2CTmock3o/SEfb0fZL8+iSbUKG00d1pr7VjlhgT8JDsHo2yGaUdzokOwM3qQceuIJIAbn+DG4k0KtphKXTcdIyoxVyeUNiaSNO0k/bSBTGfoZiTbHFxAG+fjvcHT4Wi4wfgJauuRY0altmaoeyus4+akdLCYT3FDw0r7JTVwOXdMF8ciDPg12v21gTM55g6b1hmNi4qH2pdm+eoxzW+RcEmRmhZLHktMQelwL1v+A4JJQEFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXqPbYVMLMhqc3BPVZ5o1DInuaIXmELoGHF7KzLR28M=;
 b=NhPZoOKC3nLlAZKApRw7E1TrbRqLODlO+yYObwxw1lcypQDvcX+jbQ8JJzCaW0A8ZF6zZYUkATXzNVulIOYHsZqbDsCi4LUVWVc973Y2+LJ42I4ObiesJyPHOH2um8DUcRtXTNgtf/kqsOjM7bvzoh63/OLyntlTqDKqnQd8MxdOjYUI0cai7cDTHTB9AYHZpDQAPguzyhu+9/XEpSkPYv+8vLr+cgFMGiJNIRt5XQx+tOTB2Kkqu37UfqViedjweDICLEQ+6HMWhprTZKULLWpU6A8dn+vSF41xdxrFA3rrjHexe5h2Q/bV1+bTqVgQLKSBadU+okv7oBcivwIciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXqPbYVMLMhqc3BPVZ5o1DInuaIXmELoGHF7KzLR28M=;
 b=p30UyR8f8ZvUG7CPhwRGHjuuD6eKc54LwEXLI0xAJsrk3Pb74ynquNiUHXmZt64f0QhzX1XF0G/Kj3H4z3rWhXeCDkt9tfq6sKHwaFQ7c2bvmIh1CK9cHsbHASrdhe8kIw82a1ebvQOfSOkHfOg8ymvhJQ2tpGorC8wHa2db0OrDwXJqHJJ0G60gRZzWpFpSsANENmGp2/jpdClaL9IBl0abp1HIrQLHoqjrNjrvTnmMbimgUrFfnhXGhWvCDwFVr6mey+4Kpkq5cuKi+PWpiei103UX4ovc1rbrfZUJrRwT2LrGv/x/DP+lu1Phc/9f0CrKF2cAA/nD9gWCuDmGGg==
Received: from SA0PR13CA0012.namprd13.prod.outlook.com (2603:10b6:806:130::17)
 by IA1PR12MB7637.namprd12.prod.outlook.com (2603:10b6:208:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 21:38:14 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:806:130:cafe::4d) by SA0PR13CA0012.outlook.office365.com
 (2603:10b6:806:130::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.6 via Frontend
 Transport; Thu, 1 Aug 2024 21:38:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 21:38:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 14:38:03 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 14:37:59 -0700
References: <20240730223932.3432862-1-sdf@fomichev.me>
 <20240730223932.3432862-2-sdf@fomichev.me> <878qxh7mf4.fsf@nvidia.com>
 <Zqqi8LhvSn1MXu9B@mini-arch> <87zfpw62hi.fsf@nvidia.com>
 <20240801070740.4ae582df@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, Stanislav Fomichev <sdf@fomichev.me>,
	<netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Joe Damato
	<jdamato@fastly.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] selftests: net: ksft: support marking
 tests as disruptive
Date: Thu, 1 Aug 2024 23:31:02 +0200
In-Reply-To: <20240801070740.4ae582df@kernel.org>
Message-ID: <87jzgz6i19.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|IA1PR12MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 16adc152-ba47-41ad-1ed3-08dcb2723f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+uheeBF0inIQ+KQqCt4hFS61VCzBXbmCnu2MeM/heTvD0s+rClvqz3nsTygm?=
 =?us-ascii?Q?inb0g7nCXAPIj0BYTmv8Raf70qs+0XT24VbM0M91KDCbiRZDlzoR3swwvvBO?=
 =?us-ascii?Q?EoskeOYGXCbyQ4TE0Gx1FqP4iNc7mCLacFSJRY4Wq18+JbumdI8dyDd1FzUF?=
 =?us-ascii?Q?ixCnIS0JzdjQLVdswlXPktvrMA7RMuSbuU2EfJiMsVZ0zAVDWDC82Im6p0gU?=
 =?us-ascii?Q?In2W4xpaHSCK0HDQ4jrN7f6qgzY/G82OYn/BLSTAcTL1YIlU1C1n9naTF/al?=
 =?us-ascii?Q?DD6TDf+2XBkt/ceeeUIs8eq0lnUJliWfUUfQjldfrb2iq1FaFTc+7jzfMjlc?=
 =?us-ascii?Q?LYSpCVtzQp+++MqNZUIlE1x+RdsOgB/ma1yhaJjPTGZoHtHUHch89YBVnj6P?=
 =?us-ascii?Q?31HH8UgToOJl/6JTg4BCAzCsr3SWDjmODQ7r+7SMW7TtcV2UcNHvDvFXGnbY?=
 =?us-ascii?Q?R/O4fiSa6exw08kAUV88Ksxg/KmsSnKkpztwWOnZ93Qfro6W5sw0EhZ9YqKS?=
 =?us-ascii?Q?ohX1ZeCJeQkCZV4nVbFhzia1e9217rGHfysKzPPzIkYosr6AU88E0v2Blq0O?=
 =?us-ascii?Q?Eptu90eG8cH8pnD8wNi/tCCZy1C4aAZkxWS/RUUYnZNDFB0DMk2CqWLFw8lD?=
 =?us-ascii?Q?DPWVDJSlEVk/uzl5ZeEe1iUp/qMA58GRaFx/bxGSdRAXugPtXQL/XbF0Vrnc?=
 =?us-ascii?Q?LbNGwDFZeQyrJH60R2+ji54nsiY/STipxOL1T1GHHBRo4mzyj7ji8jRQbHki?=
 =?us-ascii?Q?wZbdeopl7qOsY8LBoVwrwo9p5VOxuC2Qb/ZiRgt25iIhHZpGSO7a92I1liwF?=
 =?us-ascii?Q?6qpezdL/4mE0pq6t8Djjew5G5T6ApdNDBk09x2EYPsykOFSDKnNVfxMurUAH?=
 =?us-ascii?Q?4cwoqsOz4zH0YPpZhd7Oz15tKGPcyxfTWTJ+a08jR1d+Q7Xby6mdSwgkIODL?=
 =?us-ascii?Q?rH8jFYcm/PMxW0QLyQ62ReNJQTUMHtpkuIRvGertfk5+X7vg2DttyZ1JFOM9?=
 =?us-ascii?Q?lM09KGzE6AXKm4hztcZv7q5oSXWFsGqN2hfAi6KS4IPZCZFalWdUQBI70src?=
 =?us-ascii?Q?vTdPgs9TAGpbg8I76o33doQQd4ghVwY2CMWwVaZ9X750Hz6OJdd3jZqUhBfx?=
 =?us-ascii?Q?7AG5NcKgghWTs7uqsL7Luez4S84pmDqze0kKnC2GLV6aYbk6aQqWMLvjGXEb?=
 =?us-ascii?Q?UChhkspEGPC5bRtQ08rnVuVotC4rP3k7SdpsvxSUF70WROn1n0dnGm1ewCqM?=
 =?us-ascii?Q?CKVhrdqLuqKT4N7OB+VF70d+1qQY9JbbcgwoBoSQu2ilocDsyXjJXWUbxn3t?=
 =?us-ascii?Q?JJAPSzeffS+ptJ8/h2yv7qjmoBGuygknVtX2EK+SBf+29Nq37SsKqJSHQKza?=
 =?us-ascii?Q?1uAe4XNKdjqrsgHve6NCTT0SWZab0mBEiovpbjtcAszEpTASTiOtzKyWkaS0?=
 =?us-ascii?Q?Qqx0XXCTgg+hknugQOjlKcBLxhzQ8CDD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 21:38:13.5085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16adc152-ba47-41ad-1ed3-08dcb2723f39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7637


Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 1 Aug 2024 10:36:18 +0200 Petr Machata wrote:
>> You seem to be right about the exit code. This was discussed some time
>> ago, that SKIP is considered a sort of a failure. As the person running
>> the test you would want to go in and fix whatever configuration issue is
>> preventing the test from running. I'm not sure how it works in practice,
>> whether people look for skips in the test log explicitly or rely on exit
>> codes.
>> 
>> Maybe Jakub can chime in, since he's the one that cajoled me into
>> handling this whole SKIP / XFAIL business properly in bash selftests.
>
> For HW testing there is a lot more variables than just "is there some
> tool missing in the VM image". Not sure how well we can do in detecting
> HW capabilities and XFAILing without making the tests super long.
> And this case itself is not very clear cut. On one hand, you expect 
> the test not to run if it's disruptive and executor can't deal with
> disruptive - IOW it's an eXpected FAIL. But it is an executor
> limitation, the device/driver could have been tested if it wasn't
> for the executor, so not entirely dissimilar to a tool missing.
>
> Either way - no strong opinion as of yet, we need someone to actually
> continuously run these to get experience :(

After sending my response I realized we talked about this once already.
Apparently I forgot.

I think it's odd that SKIP is a fail in one framework but a pass in
another. But XFAIL is not a good name for something that was not even
run. And if we add something like "omit", nobody will know what it
means.

Ho hum.

Let's keep SKIP as passing in Python tests then...

