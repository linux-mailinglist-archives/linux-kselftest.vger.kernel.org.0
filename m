Return-Path: <linux-kselftest+bounces-7007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E8F895F50
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 00:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9153284358
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 22:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA0B15E7F3;
	Tue,  2 Apr 2024 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DD5x4s5L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BB315AAA7;
	Tue,  2 Apr 2024 22:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095459; cv=fail; b=dMy0fSW+PsXPYo+ieiqW/LKpsrVqtdqnQcbH6bqTum28oC69gqssaIyW2CW6qO+1lfLm08mJTZIHtpznTwYmKZ+WjWxMeQ9GfSKZdKIypc1g6bIXUrllx4CDtlq3QAd9q2Vd2SQbjUgTUa6jslPVXcYDZbrHkSz5rpUOVroGFVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095459; c=relaxed/simple;
	bh=y9h9ymHq+1KTVExSSL2GwDEqWGHdmrSSVTXV708QqQg=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kim5hJvMNJwYzAJz6lAvFOt3Po8z9K84wXGhN7JIhWm6gZVQ8DJApUYxLRUfGtEYWPvx+DR5dyS2EYiiD4SuRtMxEYuh+yTKhN00ZImE2NzAOWUbBkL0h2ApSIsYot3UKVQqpWfG9Kahji22WWH+5D2Vv0HtfUbWR5krgIUm7pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DD5x4s5L; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUbJ06hk69Bf9q8Rpbv3PxvJSm+Wyytm6aN9pXuKcG6PL6XVXCudPZ6ThmRTWiWBn3MZ8RNWfj3iQzN2senBSHef3e2MpBRbe0tx/7qbN5dvZqyz2g0uScCEYEMQh3Do5apuABjYPzn8hYbn5zpGMFbWuWA9lIAFGfzQ/6IOKEVhtAAr5w3hUTbWdQFIN/meNO9jjHnlTP8Jp3zpJWmRySgoef/y/IMni6s3NqxAXpCWQSBbkCiO7MM6nPGDfKTw4OFulBtaHkBCSStCYKdRobPMUAF2yLHwH8DODUfq5+uLbJC837Mo1K9F8QOq+wMbxw5Q/3/0bCD0m8bfw9gU3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sF5WuXU23YTHX5gbK0x4gZQg33EOKTD1Y2AqASyd9g8=;
 b=RTAH5gHMDLMUUSem3IHsCVqaXZfW84jRVvhDm3H5HFkTjx7YddGJuVG5zbgNYxLSV+GuR6rGC54r1iRfGZFgm7djhGwC9cWJ7H+aKcd2p03Zuw6FSx88NqGbOyjMS2xRzhd/OWf6eze/GVS6G8Pc4yE4CNFXLnj8prblnid+DO0gtcGq4EYGRXZkIjhDoCTI4UjiwwuqdTfWIY2IQZ8Ctjpl/CvVT3ztzwm5caTaOKKym3qjcTQa+MWebFxtZhwwXriwLyYxo6qdJ0ATy0HAro8fB/wNu9bt+Ayl0lu9ysYx3jepO3djIi2vKMa0pOnk+3gDUNbahQtJT1H/dmXXNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sF5WuXU23YTHX5gbK0x4gZQg33EOKTD1Y2AqASyd9g8=;
 b=DD5x4s5LrMYA++cHkycGYrPSLcLMqS3fcaMQNSkYGPm8gHvXRmadK3CrZf0nKSlXYz69GUcJ0W89Ir1mrODSOcIAtWhI+b9ZtXgBOjOlMKXxEy/J8ggLH9LkHDPXTCOF4cWJHmPsDFxNy+rFKp7YNwKc0vav0q+J9bOAT1brhKKLCjvCuwJIo7+/zUUgr09W8m3IwmLm5yaRPp2zTMq11DDwkuIn4WFfMtl1b/u0fPg4Zy1IUMqI4BM34SFMdCUNrkOSfcaqiDwC/dyFM5bcx509krh9KaXOScysdXGMBuRy2vVqvBX4sFYQhfCsMsfS1Lz3qN8tAMC5Ya8A1qd7/g==
Received: from DM6PR01CA0009.prod.exchangelabs.com (2603:10b6:5:296::14) by
 PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 22:04:13 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::2b) by DM6PR01CA0009.outlook.office365.com
 (2603:10b6:5:296::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 22:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 22:04:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 15:03:52 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 15:03:47 -0700
References: <20240402010520.1209517-1-kuba@kernel.org>
 <20240402010520.1209517-8-kuba@kernel.org> <87bk6rit8f.fsf@nvidia.com>
 <20240402103111.7d190fb1@kernel.org> <20240402104439.4d833997@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<shuah@kernel.org>, <sdf@google.com>, <donald.hunter@gmail.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 7/7] testing: net-drv: add a driver test for
 stats reporting
Date: Wed, 3 Apr 2024 00:02:27 +0200
In-Reply-To: <20240402104439.4d833997@kernel.org>
Message-ID: <877chfifr4.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|PH0PR12MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c50512-31f8-49e0-a13f-08dc5360d4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5se6iaXM5KS55KgcHXCCjzHS+R6HZ7pR1IO8Sm6bk3hQBc8FdpqlNgCFtDXUVvUjH/gNSHAEToNSQDIX6bSKT5S0wrFJTrZ7oJWQNbK/xWc8QkySnO/K7lB5ySKWn8gMg11WuI/tUQJ14hjKaD6Mx8fFsehEc0UOlNCqbdPyAJwSmMY/FB92/c+mne0QVyPBtP4wwAP17imJABL6AFZdqVe14tXpTNRQipmx8OVIyg3twkkNH1FThXjngScWL4zVL1yymL1kXEkLpPCZcbQq9dwH1nKiy6NzH6O7VS79t0YSWkLuEpzhpb/TxeqQ4ZxMtKAzVtmoWhV6bSKKFpDA6Gxe3QBi3rIOqp9o5c7eH2+kchbhG0tLlL1JO278+lV4fvr7Lr8HS/SnZcIBNR3ojRMwGKe3HWtvJTq4Ww4+lmj9M4D4jdjb5W+9Q+KFYMBqRglq0C0KooKg6VxPKQ633ydeb1ZrspYdxRamlqiszp2B1PuMgIS4rCkwtoRbXDU7yVk34eB2+DNpofHtQS6IaOLFeVNktoOLIxK+xlmR1pf3jzEdoptKK88KFvxZoPYEI4pB74PY5+rHZJsP/3+hcTlIf4vGmaWCt9aB/k3XLOkO7Oqy4K5CfaJi81DthzLG7Mk/zVgxESo8uMAsfyL2XKaDSzes4KNGjMqpF42geIFg3s3YtyzGOrtwlLUTurUvRCQK/3Rqn/rspV25IoWuoE2NdSp1El0rpu9/tzXY2a30AbK12Rw3J1lQ2z2cJw5Q
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 22:04:13.2514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c50512-31f8-49e0-a13f-08dc5360d4ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790


Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 2 Apr 2024 10:31:11 -0700 Jakub Kicinski wrote:
>> Yes, I was wondering about that. It must be doable, IIRC 
>> the multi-threading API "injects" args from a tuple.
>> I was thinking something along the lines of:
>> 
>>     with NetDrvEnv(__file__) as cfg:
>>         ksft_run([check_pause, check_fec, pkt_byte_sum],
>>                  args=(cfg, ))
>
> seems to work, is this good?
>
> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> index 7c296fe5e438..c7210525981c 100644
> --- a/tools/testing/selftests/net/lib/py/ksft.py
> +++ b/tools/testing/selftests/net/lib/py/ksft.py
> @@ -60,7 +60,7 @@ KSFT_RESULT = None
>      print(res)
>  
>  
> -def ksft_run(cases):
> +def ksft_run(cases, args=()):
>      totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
>  
>      print("KTAP version 1")
> @@ -72,7 +72,7 @@ KSFT_RESULT = None
>          KSFT_RESULT = True
>          cnt += 1
>          try:
> -            case()
> +            case(*args)
>          except KsftSkipEx as e:
>              ktap_result(True, cnt, case, comment="SKIP " + str(e))
>              totals['skip'] += 1

Yep, looks good.

