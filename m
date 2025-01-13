Return-Path: <linux-kselftest+bounces-24358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0153A0B668
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 13:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A65117A0175
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E8E1CAA99;
	Mon, 13 Jan 2025 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OMftHPBk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5538C20459B;
	Mon, 13 Jan 2025 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736770081; cv=fail; b=iKJUd3GJKzbVwz0TuzX30GGRDpd3OUplpV95ncfpx1hP6XWnjZZaGXsVqVdrKCyNQM1T6hugUYqkhQctZidS6ffdDzl5C/igZOd56bYIGzoP5FMgpP35cYkPwTz3uekuKhInjRQZeeapQ4R3eyzZmwwgAa+XlHJdROJcY+iidOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736770081; c=relaxed/simple;
	bh=YeK+naNdKOJ03TPmv4yaOoRtFOo1RX266Ua45ujIjXo=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=bmg6SiRo1gqeFgkXYaDGYnCXlKFgLWIi1z9BNy/NQEv2Cn9ucZIZwk6pzW4z5tgWLPKMPmgXz/dS6SdIBBfdf1TJfRcPZVnDXGCxx309bqZee4IEWSgcRYp5xv4Tsnyj59qAXGudx0jPwRjc/yeQELEE6pUmIUGEhkJOt8ggD/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OMftHPBk; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0PiMUwPlE8ZF/w41Xt2qNvHKfQP5k8rC625EewBaz6VRURV4GgBDbdShqe34w7zuwqW665MqDFjqWvUj0eHUiyrnZnsVxVmQDid9UwFjnSbeqzMFc2FtnPqtlOqO8CBqd8kc0dBUjrONnwLnxFtfSvqjV6h0wZZX6b4lzRBqemDrzKtGN9ld5Q55g5jYKnattx4CR4hCYMZHDjLefDUQg6tSAYmi9sjvBrDex9KwJKbbWxtTEYWBNjf9P+IzZCJ/y1ZD3/Ct4rtN0IzcB2sVsmgw4dahofXZF1HAqUhZLT04zNhaYmBcXxuhJx6KTnGqywlzPMEvFQhfCp6dpMZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx854dRNvHWbaU2rikfD4HpwdSR8iR9oK2NNRmWf1Wc=;
 b=J1M7I7cyFPm9nCPBY5tdaH9er+X0rKraJQO9+7bRl+KQp4bw5LpJnYR5jzmaR7sFXWcxY97aHoQl59/iW5tq4plLVdxD8wajBD9tfNCTv0DIN2wH4CQT+SXwDkfccxflQUMPYuEZ0ah6d0k2+M23pjtvuTIwRFz+zFzD2Grug1JbJBfrzsYbFje/1mrjVOLFXrJzjLArV5Uf+MXTWba6yx9oLO3JdgdS8+HHoH4Y2arS7Av6+ZkoGX0SsS4perUqWO8CtU2tAmOb3M1tV+wc9eIxH5FDC26Aus/BG1Uyek0wq3sWNQFKZfAE+H+8rEbxaHrC1pxQV0CylTOdtWXPkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx854dRNvHWbaU2rikfD4HpwdSR8iR9oK2NNRmWf1Wc=;
 b=OMftHPBk/O+Q8qNGPhHQ7UZR7wUwkJqulPyNwx3PXyaPoniCAQZEmGx5+6DDhFHrZ1Wzeekod68t6SC30xnMmoNta9BW5Maib0uYtZKCLj247TRURhSO2zMX+srV5TnOUoSBGW33z4gReZZJzQKc2MKltXbidhzM9S/JIQ+9jag1fO80Clwj+sZ+2QDxEhsLz6yhouApo1pgxVNBLVad5eCceWqU0eHnVDVatt/IgzI7l5Z0ByyNTnnwW98UqnpfiW48pezNvOxcGDDpYJ+mj/ekr0I0e6trCggBn4KfVgVev1tsdEVvXUUw95NsO3PVYVdgh8KzN/ts3w+q8YI++A==
Received: from SJ0PR13CA0012.namprd13.prod.outlook.com (2603:10b6:a03:2c0::17)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 12:07:55 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::fe) by SJ0PR13CA0012.outlook.office365.com
 (2603:10b6:a03:2c0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.10 via Frontend Transport; Mon,
 13 Jan 2025 12:07:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 12:07:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 04:07:43 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 04:07:38 -0800
References: <20250110000752.81062-1-alessandro.zanni87@gmail.com>
 <Z4CdYzmSn2cySE_h@fedora>
 <s564xh7c2xtmjz2cfwqq3zl4krjxiy4hqjeuvjpa6uhabcgvcb@k662t5irg2yi>
 <20250110171638.58114f75@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Alessandro Zanni <alessandro.zanni87@gmail.com>, <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/net/forwarding: teamd command not found
Date: Mon, 13 Jan 2025 12:48:31 +0100
In-Reply-To: <20250110171638.58114f75@kernel.org>
Message-ID: <87ikqirk6x.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|CH2PR12MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c66231-cd00-49e0-149d-08dd33cae95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l/ANVwiXcDL2s0GuMTbi/SsAWoYnIirNjII/XsofLEBtpm9kkQ7yg4Pqzm3z?=
 =?us-ascii?Q?Ya5viqjg4WQqUxrwbqh1tyGuApli8U2AQixKDpXZJ0vtEupSzpk6cJItyleq?=
 =?us-ascii?Q?JyuNpPIdNnhFk5Aw8TYYfqIJZ34qQv2clDxwCshK3q6UVq8sUd9FLvcessv9?=
 =?us-ascii?Q?0U/3J4w/o5UP7fFeWNE4FPUjyw4g1qhMN9vBIz/8Wua25VHqbXpmexnBdu5H?=
 =?us-ascii?Q?4NYw3TvK60WooX0Jf6ckWhqGHlN0fIpLbtPqVxMH9JmLObSLMzrrz/INsC/L?=
 =?us-ascii?Q?FzAkOR9gY7p8kb1HYROmo1WelJ+sur6dvT5jsUNZve3979SscsThd6w2CgsW?=
 =?us-ascii?Q?gHTid8ON+YXKXxpufkLeCFdcIeiQclnTEwvu0h0pfzPSoxs6+T1NwULbXO9d?=
 =?us-ascii?Q?TQLXxp3tUVbP6+dCfDy6dZI0ibceXpFQaEQDQOXaepExpfRPfmE99AvKX1I3?=
 =?us-ascii?Q?ZaeZxz24Z0Ts0HRKKmoQRfVfAQC7KyfuKVfx+ZfIX/a/rm9MNAU95gapxVcL?=
 =?us-ascii?Q?GLw1HqpDiyt+PBHZvLYESb1FPdzIm/QrBE6gFWqTNTXb5Rb2uXj78jwqxFaW?=
 =?us-ascii?Q?sDTbZCSPCmHfqPXT+MCtnrgDV8s6E19Gw2wiwamkPMj/CLWj9DoichOW82Mw?=
 =?us-ascii?Q?AQ3BJMYJ/kNfC6vEkyv7/6WZJ71T0lQuy9W50aaZF1TngesmKr3PwXCSqAMu?=
 =?us-ascii?Q?lNY6D/Uqt84PIFedLwQMwMlc19aIUNH1fuPCSbUfLKN0NeF0Ks/Ab1fu/CHH?=
 =?us-ascii?Q?/qS2841WSJQ8n/6pV52hLSChMq+XnpI2MFjnZVLyFb5QhGgG2ZDJvcdF+SSl?=
 =?us-ascii?Q?azMME3Mvf1QRGR/mC/YunmNJrkdnynJV1v4MAN0CypZv4farVEg3aiEE7w1V?=
 =?us-ascii?Q?2pIOfOg0pvXpSlQCCETV5/ootEeRmnhA2E/cpAzCq7DtWfMPlXwpYVOjTh9w?=
 =?us-ascii?Q?p5DyeCzlGIhO5ncd0WqDTtrmIEpLl6dTVtoIJxtchHv/vfuKGk10bWRd3TsW?=
 =?us-ascii?Q?EzikLSKiqVCjjLud+EKHOfIsPJjsvZa3YkczJNJp9ivMRBoMAxbjpb70EAqy?=
 =?us-ascii?Q?+tPRwskHq+cMpSXa9rdXUY4A9jWz2xLx5P6tTXbVTNw3duPJItPCk3IYcQoa?=
 =?us-ascii?Q?IO61P5/btvObTnafXUvf8TdQJHqEWoAJmvG22s7RAvY2bKnCjgGYRVHygUFy?=
 =?us-ascii?Q?mmh3rFdqnEO6lP7PGyc16Qq+dDUumEbsdlDI1DA3g5rVxRS3jrlj6g+hXSHs?=
 =?us-ascii?Q?6KEaa+0GMb//dnuwhfMMEI40CkniQZpABk4R8U016SxsVq4F06TEUQ3ZW6xU?=
 =?us-ascii?Q?DKGbC98zIUNyuO9QSBIjLpFobin1D8zU5rvTBhUVHhR/T3yAzzmEn6vPDYvv?=
 =?us-ascii?Q?rqKs106s59W7amsdhCYXudC0Kx2b6Gu9XGXbEpm5wPxzX6HomzlFAe4+kHi1?=
 =?us-ascii?Q?XxcHhdbKRUoOFjzwBquUYAIztw+udjr9umqRfwzsk1Fhcq/vQVezM+i8bu8H?=
 =?us-ascii?Q?I3G/O4+QMK14en4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 12:07:54.7233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c66231-cd00-49e0-149d-08dd33cae95c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248


Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 10 Jan 2025 15:35:23 +0100 Alessandro Zanni wrote:
>> On Fri, Jan 10, 2025 at 04:09:07AM +0000, Hangbin Liu wrote:
>> > On Fri, Jan 10, 2025 at 01:07:44AM +0100, Alessandro Zanni wrote:  
>> > > Running "make kselftest TARGETS=net/forwarding" results in several
>> > > occurrences of the same error:
>> > >  ./lib.sh: line 787: teamd: command not found
>> > > 
>> > > Since many tests depends on teamd, this fix stops the tests if the
>> > > teamd command is not installed.
>> > > 
>> > > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
>> > > ---
>> > >  tools/testing/selftests/net/forwarding/lib.sh | 1 +
>> > >  1 file changed, 1 insertion(+)
>> > > 
>> > > diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> > > index 7337f398f9cc..a6a74a4be4bf 100644
>> > > --- a/tools/testing/selftests/net/forwarding/lib.sh
>> > > +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> > > @@ -784,6 +784,7 @@ team_destroy()
>> > >  {
>> > >  	local if_name=$1; shift
>> > >  
>> > > +	require_command $TEAMD
>> > >  	$TEAMD -t $if_name -k
>> > >  }  
>> > 
>> > I saw team_create() has `require_command $TEAMD`. Is some test called
>> > team_destroy() before team_create()?  
>> 
>> Actually, the errors seem to raise in the "cleanup()" method.
>> 
>> So, first, during the test preparation the "team_create()" method is called
>> and checks if teamd is installed. 
>> When it fails and skips the test, the "cleanup()" method calls
>> the "team_destroy()" that raises the errors.
>
> Actually, maybe we're better off switching the team handling to the way
> REQUIRE_JQ REQUIRE_MZ etc are handled? That way we'll validate and exit 
> when lib is imported / sourced.
>
> Petr, do you have a preference?

Yeah, that would be better.

My first though was that this is fine, because it's just for tests that
don't use defer. (With defer, if the creation bails out, you never
schedule the cleanup.)

But if you bail out early from team_destroy(), the rest of the cleanups
will be skipped, which is bad.

So maybe we need something like this:

	$TEAMD -t $if_name -k 2>/dev/null ||:

... i.e. to just quietly tolerate failures. But that's no good either,
because then you never catch issues with the cleanup itself even in
valid runs. So maybe team_create() should note whether $TEAMD was found
and do this conditionally, but at that point, going with REQUIRE_TEAMD
is the cleaner solution.

It looks like we have 7 scripts that use team_create(), so it's not
crazy to just fix them all.

