Return-Path: <linux-kselftest+bounces-11245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3918FC93C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 12:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2C31C20D5F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 10:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D19619147E;
	Wed,  5 Jun 2024 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LhaHhqDe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA6F14BF85;
	Wed,  5 Jun 2024 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717584056; cv=fail; b=G5pBMDbAS0UtZEPOkjHQJpCUdaTTyrnPCMOfd4taesuQjfj8RXDwNkAz9fByiHXWex6e7+QFJZlxOfWQZZ+4BWEeKwsYOnfHH2dS4OPU6xp3ESvkbYNgySZcuWusAhqPlqislZkooARZp3NEg5yrQSo/d/KMcZSM5FXeMd9wv+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717584056; c=relaxed/simple;
	bh=8Wedm8Q50FSfh1coOBlDj+HvIrOeKIcrX+QgQMU//BM=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HVgp92OLouWeg8LqiFEHhhWbw9SPkuaVxmmCR3fC/FwhAlMqoT0kHkomvhmn/8hxXIa0NioS6yLC/IMDC9wtoyOugSVnQHGrrLQwISoYhPnjVb0TYH9DLZDUCGc2vfBXrOwZeURx+8jzlYV/t8q7+HXEiRdXu/BKMqC5u8rwgFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LhaHhqDe; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1dIABalQH0OkxOyEKIwIM2esM84w9u11JBFaHT2L3Hzq80hDJF1gMUnZd8cZe0ALx2TyApa/79jlVI8HqWKuHeVJcZ3nc07yINfySo1hlRvgMyeMn7P0rOSb665lGqcWiuMjSGVDmZ5EAXtPodnbDmthb5DH4YU0R0xfndpJdizZN+RJQD4tqM2i9/MvG5/jY8AvFWYF7w7wugnbSlbqdK177IrUI5upvc5tKK5VuMTuidpCvaL/1gRE5orYGlX4qvWcS4NDebbtrON61rhWGj5vl2M0DRWiJF+KBzc9+2sSIB7uwWp3namobKRy5a6e3ptI7ib+tO17aSG3zCuzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gK++XqQPBV96yxM7ZZj+nasONXXjZfWYsNctzHZp1Os=;
 b=LOftBh0sl7Wie2b+tXgo78Ll0BaIfFXcYMstqNwpS+3VlBrBrVwJWHEwtH9nugLt7o9NoJnNI/+hJrGuINrY56ChsLH/DhnY7UTwDUew/1ZF+iiAqlAurzahjZjkcGkt2ib7TEMr2Y2JZE6G/wLRKOksbglFfrXCGUY5fRzsviSPWLJgoPL+0vC8Z/bjZx3YK3g7ArJZ9/QOkNlZy4w/fwb9Rxn3abDdDCKMA0AQ7ehktXzORDmXnnIoA9xgWT5hlPHej4fE0DmHRh4G+h26GjHmrRMqTtt5UeXagbfcqYtLbr1PPJk7OK733T+yZnR0Y0FwiprxYpbOmyosNrTdFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gK++XqQPBV96yxM7ZZj+nasONXXjZfWYsNctzHZp1Os=;
 b=LhaHhqDeBC7cY5j320AB1K/LqR+Lgo54JNKY6mnaCZxdDCWtRalzLJ3eVwu1n17+henGm7oayn5FtZsd/yovKIjnJEb63Z8HzVsyl44UrNMe/u/xK2SFN6dpeI2aHTtJzoX3LLoDI44k24fRmMF6OeOVZlqI7ggLL7csyZBKpTrImXc2uGrppXOnU+KBoTUUoUGLU6JUyYosjWmoKgoP6ZZTCVrX+WFOKgL80UVUZPfJfHFH8PwXk8BfTSzZxucRYIRr+ejJ32rIX/fBs7UOfCtyqkOOyqiHPBv0mtUPX0/HDf+sATMiQuRXhVkMNTwPxHMnDU0ikFoFmSc3c8lLXg==
Received: from PH7PR13CA0016.namprd13.prod.outlook.com (2603:10b6:510:174::9)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 5 Jun
 2024 10:40:52 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::f7) by PH7PR13CA0016.outlook.office365.com
 (2603:10b6:510:174::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.6 via Frontend
 Transport; Wed, 5 Jun 2024 10:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 10:40:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Jun 2024
 03:40:36 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Jun 2024
 03:40:30 -0700
References: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-0-b3afadd368c9@kernel.org>
 <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-2-b3afadd368c9@kernel.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
CC: <mptcp@lists.linux.dev>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Petr Machata
	<petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Geliang Tang
	<geliang@kernel.org>
Subject: Re: [PATCH net 2/3] selftests: net: lib: avoid error removing empty
 netns name
Date: Wed, 5 Jun 2024 12:38:27 +0200
In-Reply-To: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-2-b3afadd368c9@kernel.org>
Message-ID: <877cf38yg5.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 061f4b0f-e66a-4c88-b22f-08dc854bf8a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OLvtNQOO/JtATKf9Hwo0rNIZf9kHXM0LkvrfSAxlWV+rF8MP4gNtQUrEA//P?=
 =?us-ascii?Q?KFVSLpBa5Kz5eqAc7IeL+TrFvj4tFWAqX+5gH01RbyRG5VMn4BgJ6SV7jS56?=
 =?us-ascii?Q?PjQJWtTc6cw1QUeo0ThVeI8q2nEz6Yvy7+X9+iTuz8IslVAX0GvZ6rjtUMud?=
 =?us-ascii?Q?pQQZiZcfmNBkqnaLAzpNUlO0dqdNizeZwY0COni7id7Oe4GJNrlOGupcI7+M?=
 =?us-ascii?Q?ssem3rwNywGzEYAMbtiCkwGMhRHubQUEpuCMhrsKB5+sRuoGzVyzsCi8wZuF?=
 =?us-ascii?Q?hhtI9i6GQt0eAq5YmSr8YU/rPuW1rHrlwL4xCM/vATkL5Dv1zeFcj1d3x1sV?=
 =?us-ascii?Q?eiL/zlWMn7XrAnuxFxfQxdRH7UfvJUJZnKN9NxlYi11U9+LP8tl9CARb8IxK?=
 =?us-ascii?Q?HlCHmuLvpkTQWwvmHLLYAqv/5cyCb7pYZHufm4JxnnapMGdnleFsfSv8VKtn?=
 =?us-ascii?Q?wILQruyxw0LEcSAS76cQQ64Y48fqUi3LWl4dBGORdIRJ1QyegkjG5pPPLtUu?=
 =?us-ascii?Q?mbaYS1s+MVZoptc75rxJZPxNs58PzpEda6OfYfy273pJS2CT3sieScceYvD4?=
 =?us-ascii?Q?wkpvRq8B62R4P5v55ECUbhi2QQP08YyWarbH4SQem22Pp2CbpFI1cBnKMY4Q?=
 =?us-ascii?Q?ipU+gWB4s1Ek9fexl18Q6aX9OjFzkCsy+URtwCEIaFrH4aL+Rky1aieyagQR?=
 =?us-ascii?Q?ygaiW06DCCnwIt04HdiEwsVrl+I7+2eAUyyqeycssRiZnH4GHUXRT3999/D1?=
 =?us-ascii?Q?PjKgzva/UFR82Xc7g+xJtgJh63ld+gP5S6lb6X1Az3SuDVJssa4N64693nZP?=
 =?us-ascii?Q?HByPJ6HVjVcY2oAEt+bSuPMVpqjvhrtwUzry9J6nrU9OpK2QIDyJbGd/OBKr?=
 =?us-ascii?Q?Q7LR3Yjbw2/z4YMagDNLYDJhsexr1ioobTQuK5xZz3ok2gzwS0pghbHSdyqN?=
 =?us-ascii?Q?+mJi0xwi84e9c/UJWiRQmAiJmkjsMPdZ1kIDGFu5JfOoXNN2iaFiFObrTxcL?=
 =?us-ascii?Q?FGtQGRGZUsYmFVGYg4w2+2JlIw+IlwDHQkHpTnwcWkRTrsmZyv0HajETrBOv?=
 =?us-ascii?Q?x14J6R5SE5NA1UZQ0T4MZsvnBV304awIKCpW5qEslod1efIRU0QgezIQ8fob?=
 =?us-ascii?Q?FBKwPKOv5CkyyKds1aOoq8lUZIuLkmNM5qv77q/n+EVI7nFCT4maW4bo7vaA?=
 =?us-ascii?Q?DGOMtb97nMXu45Y5O13cZH4+eXrWyuL5VGidlWD0BgoIVdfe6ljraJkCxfMe?=
 =?us-ascii?Q?gHNjjGBCHwTn3rdzhVsGq+SQXGza/8ZswiNPD8f12Kf3Vszk3jb/SQw0uCCU?=
 =?us-ascii?Q?U2V/80mCDI6riWlxPs77TLn2QtbxHF67AEGI4h9TUvSlgURxresLnozIjL+s?=
 =?us-ascii?Q?p42D8rElK2r6EDZcOXvglsZt2URFvONh8gOajAb0xr06KihwZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 10:40:51.9036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 061f4b0f-e66a-4c88-b22f-08dc854bf8a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534


"Matthieu Baerts (NGI0)" <matttbe@kernel.org> writes:

> If there is an error to create the first netns with 'setup_ns()',
> 'cleanup_ns()' will be called with an empty string as first parameter.
>
> The consequences is that 'cleanup_ns()' will try to delete an invalid
> netns, and wait 20 seconds if the netns list is empty.
>
> Instead of just checking if the name is not empty, convert the string
> separated by spaces to an array. Manipulating the array is cleaner, and
> calling 'cleanup_ns()' with an empty array will be a no-op.
>
> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
> Cc: stable@vger.kernel.org
> Acked-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/lib.sh | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index a422e10d3d3a..e2f51102d7e1 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -15,7 +15,7 @@ ksft_xfail=2
>  ksft_skip=4
>  
>  # namespace list created by setup_ns
> -NS_LIST=""
> +NS_LIST=()
>  
>  ##############################################################################
>  # Helpers
> @@ -137,6 +137,7 @@ cleanup_ns()
>  	fi
>  
>  	for ns in "$@"; do
> +		[ -z "${ns}" ] && continue

I think this is now irrelevant though? Now cleanup_ns() will be called
with no arguments for an empty NS list, so the loop does not even kick in.

>  		ip netns delete "${ns}" &> /dev/null
>  		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq "^$ns$" &> /dev/null; then
>  			echo "Warn: Failed to remove namespace $ns"
> @@ -150,7 +151,7 @@ cleanup_ns()
>  
>  cleanup_all_ns()
>  {
> -	cleanup_ns $NS_LIST
> +	cleanup_ns "${NS_LIST[@]}"
>  }
>  
>  # setup netns with given names as prefix. e.g
> @@ -159,7 +160,7 @@ setup_ns()
>  {
>  	local ns=""
>  	local ns_name=""
> -	local ns_list=""
> +	local ns_list=()
>  	local ns_exist=
>  	for ns_name in "$@"; do
>  		# Some test may setup/remove same netns multi times
> @@ -175,13 +176,13 @@ setup_ns()
>  
>  		if ! ip netns add "$ns"; then
>  			echo "Failed to create namespace $ns_name"
> -			cleanup_ns "$ns_list"
> +			cleanup_ns "${ns_list[@]}"
>  			return $ksft_skip
>  		fi
>  		ip -n "$ns" link set lo up
> -		! $ns_exist && ns_list="$ns_list $ns"
> +		! $ns_exist && ns_list+=("$ns")
>  	done
> -	NS_LIST="$NS_LIST $ns_list"
> +	NS_LIST+=("${ns_list[@]}")
>  }
>  
>  tc_rule_stats_get()


