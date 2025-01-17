Return-Path: <linux-kselftest+bounces-24725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8673A15052
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 14:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31D81884B3B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074AA1FF7C1;
	Fri, 17 Jan 2025 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iExiolOa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA401FECA9;
	Fri, 17 Jan 2025 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737119505; cv=fail; b=t7eVBpEjg2u61WvLZQw4iU9P5inxJ1Kfbp1DyW/9NbX5KbxM8GZ6XK9jr8XjbPSrFY03saKiolO6e1nvg0WvzvVi6qgRjgGp9MxkCptfzQCSocgdUHC5zIabXCG91iUtQ+Hg/pQWIKUTaqpVhSc9uGk69tM05fF2UW3cdXyDjjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737119505; c=relaxed/simple;
	bh=GdPptwGYkCx5yhyDt2tZjCpteQpjfR4QGxj6n/LTf3E=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qq3pSx+ynx+QJ2MsDyt4Iuqsf0g2kBnshk5mUmLAohM7dMXEn3od/XcWamYbT/IHHFqGLJvwyJH0neZUrZwRJjrVcAGH901zzWIbiWdqcMvbXtMluQrL+gsry5EwEDl4vD68BplCo0OtYGc/laZmVQvUbkPmoJT2eAgJZPnOKkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iExiolOa; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUHZlgfC6MEqUQlbF2IFIUBX8/QaVh/+rX7GJ3kjK4TGXpCWnqar0wdYU7/j5Wr4aieWMv4A7ADVd5ZYQcij8P8SEteNrH2wCop+pUCcbEcH+CyqYFfjx8TRaBX7ZkFWDp2Dk1wL+gNg+hz1uByuOdfP4FzlcxkIPxWBOlmhQ8E61SZ2erD0geZiDFJhZkyjD7oiuA3jOPxhv7gaSx0TkBLSod3RRww+ouMNINknXx+R4jqx/R9VcwM1S2lxWyefQ5Ru9bIBbamDCygDQH6G5JL8OT8C7m2Yl6qKuTEavIXokGmZlWO84fZiqQuC+w7Ryf2WhyTKHqDldMKIVhDTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arkTkIu3D3QChMZeCJpN9dLTQb/+2W1u7bzuUocbyU8=;
 b=qqtJEEaGW5zOq4wINyz1a8aA+0FtMiIyeRbc7jLWRnZybTpdXnQT3oVcPpH/evtzd86YmuBlrslOd+7ztEb9OYAD+XQyy3a2pO8n9nXUwwcbffZRbrp9sAZ7Ze6m2QfOXNoWYY1WT4rwn4ivOYTLLUvMzBCZ4C54r4SNqL8OSQPZb+Gf9wCW4IfqSwCeIFWdeZPOu3IfmRqfNymaqp4/8ikIMJSONTrDStWbx3HgxMyhZUNK3wXln9PTgOm04nJFRW6dIlDp+L4S7IMKY5SM3vQOgJFx7P2BWq2lB5IfS/Oo0S3QUXXbCuOF8J9ZzVGncXmgUX0m+K4Sb96Ans6BWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arkTkIu3D3QChMZeCJpN9dLTQb/+2W1u7bzuUocbyU8=;
 b=iExiolOaTyo/RGVhpVDSh292ApW16Nl82Gk4R9FEgHUVxCi9SxkhCqj9Oqxeq2FGNxe1js8cecGZfFKokawPF2UxP6LwA7H8vEnsoGiA2jlIyHU44mTzRnQfQe08HSMJq1uX1T8fBt7Tnboi63CrxsX0CfT0v687WDMSm8mlUpYyBT9jLf5qCIzMV9TordRz0/RiWbFoMdVT6g4y2mABtDKRUA7K+RzTHGB2wCs4JdDdPhKCxmg61goi73EatvcphtG6JsuDh+MyHKuNe430SlYeRg8kn/ucC/3H8M7VATQToDo3qE4kYZFmTO+ylQkrO4aF5U/tGdX01yuBjC0gkg==
Received: from PH0PR07CA0046.namprd07.prod.outlook.com (2603:10b6:510:e::21)
 by DS0PR12MB8269.namprd12.prod.outlook.com (2603:10b6:8:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 13:11:39 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:510:e:cafe::77) by PH0PR07CA0046.outlook.office365.com
 (2603:10b6:510:e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.16 via Frontend Transport; Fri,
 17 Jan 2025 13:11:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Fri, 17 Jan 2025 13:11:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 Jan
 2025 05:11:30 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 Jan
 2025 05:11:26 -0800
References: <20250116020105.931338-1-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next] selftests: net: give up on the cmsg_time
 accuracy on slow machines
Date: Fri, 17 Jan 2025 13:49:23 +0100
In-Reply-To: <20250116020105.931338-1-kuba@kernel.org>
Message-ID: <87ed114mbw.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DS0PR12MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 154084fc-da05-4d17-a27c-08dd36f87a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SkB++HMHasph5yCsygwX3PxQ+Klx5XoeBsNAOynpmuh1EpK5gP/n3avu65bi?=
 =?us-ascii?Q?Q82CL6wMFqms4KqprwIOj/fGFKj4nlHZmLldlwnYO5A6cC9AwnCID2o5zHrr?=
 =?us-ascii?Q?tHBBprP6JMT1r7+4Q2S0X16JGYrlLRH2msM4sCVa9X58SVsYyM6AGPiupZoJ?=
 =?us-ascii?Q?nSFU5hs2yX/jvK2N343aSVllnkMIJkIA8JpFIy/l8M7STZAhrjgpMHek6+Yt?=
 =?us-ascii?Q?oCw80ZV1RC8BJx6tufYcUCM82VV/xy6N6WxG+IHPWQic1DDG76QznPJzV5QN?=
 =?us-ascii?Q?hgwNdRRRCyGJMLF5vgTP8j6ShCVoDwx3hy7/ueGXq/mL+KvK2jskJFawaUCo?=
 =?us-ascii?Q?K3ZGEXL+DmA6eSI/mecnwDJOVBjtMxnYcP/TfK6xTuCqT7d+42s8CKM/QhaY?=
 =?us-ascii?Q?eseq8onODWEc3AUznaq18pocFjo1Geb7dqptF/syIJrOga3pi+Xnw3+pKKWo?=
 =?us-ascii?Q?7iuqRmZprSCRNLjAgO2UBytkSA4eVNY5YYEOYm+lSGv0b3LHU4bTg2bcvnQF?=
 =?us-ascii?Q?6PJgcq5vVWdlF8l03Zdxoh9eF9yIb9Z4MsmWoUjGz42rDHYtu3qF7zP0zPT+?=
 =?us-ascii?Q?C73tSu2KgVJGOlbmU6clmrQxMc38E7fpI4P/RGZSr4cZy/TDWSSnVbDwo9HY?=
 =?us-ascii?Q?9vLfwYBuADsEzWq2rvGwTJaD/OON6LZrm34LgglIBrSrib4lBZoNNjc76bFK?=
 =?us-ascii?Q?xDnDZOQ9SlWlSKA5zB0rMpVmwxqgDKFZKXoldR9FfeK+kYDvE4SPzY6UPI9R?=
 =?us-ascii?Q?uy6tQlfR54itGwJP49DpDGWQoNRygWVUr4qDE7yM1SU8VDbQnb9cDbyjeghX?=
 =?us-ascii?Q?wrQaaI4B5HoWswG09CzBoL53XRHt/TprGQvvzZI8AZT8FowOiGoFsGw47Gg1?=
 =?us-ascii?Q?jLlrEhQpenRvcXBcek28FV3imAhNprCzSIJeVC763leCrxq2D+mTMIHmc6JW?=
 =?us-ascii?Q?q85kMrCAviU0YlZQUwQ7OqrrmSKoR/Woa0VKgTtNUhmA3AosHTxrmNe9uvpe?=
 =?us-ascii?Q?2jU1POaHgNVN2gJsrWRfBtR00GKqpm/hF0/m8+09V/Yz+GyT7zWZrG37QUr4?=
 =?us-ascii?Q?TqCQLKPmd/3MxYBvhoalpGVZ5dxlw9kvYUEnV1qiwnoNPOglwrlm2xI6pxsB?=
 =?us-ascii?Q?icu+H/xyLPbQZQ8AvVvF9jOJL4Py2dPJPeupu0kuCF5H+TN1XYoGHuArmsjb?=
 =?us-ascii?Q?nXl5nXGLtDf9uwRixQyTIxMClSxdX1QbzfMJj/y8rRRs7mQMy/CQDvUZw5gE?=
 =?us-ascii?Q?iKPCfYVZBXQmR5d8DbkaTUyW8KEcx0hT+0e+dX+yJ8C34Hj9yKJfRWyQm5WV?=
 =?us-ascii?Q?opU+s7lPNcpgtvvsCyGazRlAbitCS9QBNTEdfaLXLQ88Bs82vZrdxzacDMZ1?=
 =?us-ascii?Q?xRxV5/7rlanmZst0Z+ZYUb7ou5gWZEDNthKcx6js2+o+JQ8ul+/FIiMdDZV+?=
 =?us-ascii?Q?WdI0hYgx28QyJlYTgtOpDj/tAbnzb0L77Coqdv8p00C6BYKF3xu6Etgh1ZER?=
 =?us-ascii?Q?/MVS+6StgufW2mU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 13:11:39.1997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 154084fc-da05-4d17-a27c-08dd36f87a98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8269


Jakub Kicinski <kuba@kernel.org> writes:

> Commit b9d5f5711dd8 ("selftests: net: increase the delay for relative
> cmsg_time.sh test") widened the accepted value range 8x but we still
> see flakes (at a rate of around 7%).
>
> Return XFAIL for the most timing sensitive test on slow machines.
>
> Before:
>
>   # ./cmsg_time.sh
>     Case UDPv4  - TXTIME rel returned '8074us - 7397us < 4000', expected 'OK'
>   FAIL - 1/36 cases failed
>
> After:
>
>   # ./cmsg_time.sh
>     Case UDPv4  - TXTIME rel returned '1123us - 941us < 500', expected 'OK' (XFAIL)
>     Case UDPv6  - TXTIME rel returned '1227us - 776us < 500', expected 'OK' (XFAIL)
>   OK
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> CC: willemdebruijn.kernel@gmail.com
> ---
>  tools/testing/selftests/net/cmsg_time.sh | 35 +++++++++++++++++-------
>  1 file changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/net/cmsg_time.sh b/tools/testing/selftests/net/cmsg_time.sh
> index 1d7e756644bc..478af0aefa97 100755
> --- a/tools/testing/selftests/net/cmsg_time.sh
> +++ b/tools/testing/selftests/net/cmsg_time.sh
> @@ -34,13 +34,28 @@ BAD=0
>  TOTAL=0
>  
>  check_result() {
> +    local ret=$1
> +    local got=$2
> +    local exp=$3
> +    local case=$4
> +    local xfail=$5
> +    local xf=
> +    local inc=
> +
> +    if [ "$xfail" == "xfail" ]; then
> +	xf="(XFAIL)"
> +	inc=0
> +    else
> +	inc=1
> +    fi
> +
>      ((TOTAL++))
> -    if [ $1 -ne 0 ]; then
> -	echo "  Case $4 returned $1, expected 0"
> -	((BAD++))
> +    if [ $ret -ne 0 ]; then
> +	echo "  Case $case returned $ret, expected 0 $xf"
> +	((BAD+=inc))
>      elif [ "$2" != "$3" ]; then
> -	echo "  Case $4 returned '$2', expected '$3'"
> -	((BAD++))
> +	echo "  Case $case returned '$got', expected '$exp' $xf"
> +	((BAD+=inc))
>      fi
>  }
>  
> @@ -66,14 +81,14 @@ for i in "-4 $TGT4" "-6 $TGT6"; do
>  		 awk '/SND/ { if ($3 > 1000) print "OK"; }')
>  	check_result $? "$ts" "OK" "$prot - TXTIME abs"
>  
> -	[ "$KSFT_MACHINE_SLOW" = yes ] && delay=8000 || delay=1000
> +	[ "$KSFT_MACHINE_SLOW" = yes ] && xfail=xfail
>  
> -	ts=$(ip netns exec $NS ./cmsg_sender -p $p $i 1234 -t -d $delay |
> +	ts=$(ip netns exec $NS ./cmsg_sender -p $p $i 1234 -t -d 1000 |
>  		 awk '/SND/ {snd=$3}
>  		      /SCHED/ {sch=$3}
> -		      END { if (snd - sch > '$((delay/2))') print "OK";
> -			    else print snd, "-", sch, "<", '$((delay/2))'; }')
> -	check_result $? "$ts" "OK" "$prot - TXTIME rel"
> +		      END { if (snd - sch > 500) print "OK";
> +			    else print snd, "-", sch, "<", 500; }')
> +	check_result $? "$ts" "OK" "$prot - TXTIME rel" $xfail
>      done
>  done

This logging and xfail handling duplicates lib.sh. Would a patch like
below be OK with you? The gist of it is to just use check_err, log_test
and xfail_on_slow from lib.sh to achieve what the test open-codes.

I can send it as a follow-up instead if you prefer.

--- a/tools/testing/selftests/net/cmsg_time.sh
+++ b/tools/testing/selftests/net/cmsg_time.sh
@@ -29,19 +29,21 @@ ip -netns $NS addr add $IP6 dev dummy0
 # Need FQ for TXTIME
 ip netns exec $NS tc qdisc replace dev dummy0 root fq
 
-# Test
-BAD=0
-TOTAL=0
-
 check_result() {
-    ((TOTAL++))
-    if [ $1 -ne 0 ]; then
-	echo "  Case $4 returned $1, expected 0"
-	((BAD++))
-    elif [ "$2" != "$3" ]; then
-	echo "  Case $4 returned '$2', expected '$3'"
-	((BAD++))
-    fi
+    local ret=$1
+    local got=$2
+    local exp=$3
+    local case=$4
+
+    RET=0
+
+    [ $1 -eq 0 ]
+    check_err $? "Case $4 returned $1, expected 0"
+
+    [ "$2" == "$3" ]
+    check_err $? "Case $4 returned '$2', expected '$3'"
+
+    log_test "$4"
 }
 
 for i in "-4 $TGT4" "-6 $TGT6"; do
@@ -73,15 +79,8 @@ for i in "-4 $TGT4" "-6 $TGT6"; do
 		      /SCHED/ {sch=$3}
 		      END { if (snd - sch > '$((delay/2))') print "OK";
 			    else print snd, "-", sch, "<", '$((delay/2))'; }')
-	check_result $? "$ts" "OK" "$prot - TXTIME rel"
+	xfail_on_slow check_result $? "$ts" "OK" "$prot - TXTIME rel"
     done
 done
 
-# Summary
-if [ $BAD -ne 0 ]; then
-    echo "FAIL - $BAD/$TOTAL cases failed"
-    exit 1
-else
-    echo "OK"
-    exit 0
-fi
+exit $EXIT_STATUS

This is much more verbose, but that's how tests tend to be. I could
change it to only log on RET != 0, but like this the custom results
block can go away and the test is overall more median.

bash-5.2# KSFT_MACHINE_SLOW=yes ./cmsg_time.sh   
TEST: UDPv4  - no options                                           [ OK ]
TEST: UDPv4  - ts cnt                                               [ OK ]
TEST: UDPv4  - ts0 SCHED                                            [ OK ]
TEST: UDPv4  - ts0 SND                                              [ OK ]
TEST: UDPv4  - TXTIME abs                                           [ OK ]
TEST: UDPv4  - TXTIME rel                                           [XFAIL]
        Case UDPv4  - TXTIME rel returned '34us - 30us < 4000', expected 'OK'
TEST: ICMPv4  - no options                                          [ OK ]
TEST: ICMPv4  - ts cnt                                              [ OK ]
[... snip ...]
bash-5.2# echo $?
0

