Return-Path: <linux-kselftest+bounces-6620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3A588C1D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 13:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34F1DB2576C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 12:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B2A74416;
	Tue, 26 Mar 2024 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vj8DTUWl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD9571B20
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455263; cv=fail; b=jvtq7yJLMmeZlMw9apAhMco/65wDhXC9ZWdWROG2/90s8EAnw+PN1h7sWZM5fpFJwsZfnHynkxWwomIk4Z77q/PiIIg0qHC9u3+Z7ouGcNukTdK+XrqszJ06u8+c+yDiGr4gu9dPGQ6E+DDG1aWnrm2FpXAzZ3vJoGuNFeE1yoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455263; c=relaxed/simple;
	bh=W2FoV8t9UTQ/XqUVR4pz8I6EYue488QIpwN8M5li+6Q=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=BIBEXkFpdmyAP8AJLrL+vq8LIbNTQphSs6beHU4JZyJickh745QI0sZBCkDbNMD0JsI9zYdsOrTuE1ndc8F7QOhMWNVLzjWKOKa2WRabcFqVMobXUOhkyvJ59a2KHe3Rp9/uqdyI/TKH053z9pVI2HdI2ShgEL0u4H5aNtTe/U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vj8DTUWl; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDjPZ5gShAsaShv9xbHlq3EoRg6Lw2JdzoIvkD1N1xRSDCHoKxihmBO71SsQXNs/JUzA9Zuw9/ceqcM8WsTr1d4+3DXsuieir2bRp5aBBFiHfC7ePxDfce51zyyFGk2XQPy/xv58QHAp0e0V8icYU3AIhPoVlbIOqWgAfS6G5snhVkuqoZaLenecvrd5yCJFetqd1ZptNqziuAafDwr4TCy68hTSUBIDQgtxf0ifEoc6Df92iZ8rNqwQJ8b14etsXYzeKm1fRyb/puAWmqsYjeeRiJYZxolynXkv5tBQmRqn9lDWWohkSRD6FxtyPZnWY47w2wlVUM43MF7RDY3wug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpjENSLu40/dEnZ7vFmNfngMsu6nhuzbCHKkHiB+p/Q=;
 b=V+dAxgcsmRB7l0pntDKCfozZq5pxU2ImmaADvdawlsye1Rxfpi9KLha4nnwza3jfdcT54eNJ/eUj4vpvlqZCKxv4yh2Y85ERm1QbPWcz04YH31z/SOjWiJmiUN1L8uZCPm7uPJMomdyKLIFug09gU1YvBdyLuFieCfPGhtLp/ub5KwheH/gmzbNFQhVPT3EPKbRxYRSH3pIr8stEe0qFeXY75a5aV73R/Sv9UqhzXoRsdkdYXwdk8xFlgz3Nb9p1A0u8m1+z7+qsbpyUln9FD2JgXpikJX0o6dz9PbhLSz4YFQs2CZJse2q+CXxR52XyoQ+SLFZ5+pajjYyTAwBcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpjENSLu40/dEnZ7vFmNfngMsu6nhuzbCHKkHiB+p/Q=;
 b=Vj8DTUWlIdKTxczRz08v649MZKIw3ZwQRrcnOKWeDgiuLZtAh5cyXed8+45rl2hgxmJqNAT3mw7wrRkc+HnVsYvCZflKJFuaQ9xS3+575UCmR7pLiE8Tyf5MEq5hTDRYk+uJLCO3TplaMcUPKqqFHfVx0hDaRIJBiOr7R+31tNQWtbmWd6OzcHuAyseER4R2N3Mcs84/ReStqgnwGbY2blGiVAAbjp3d9EAjb29xEjKpjbTMXiWGN84mJjq5C6jDgllFgTB1muM7N1eXrCGdD3Re1Emm2SVete5pU6BvXzeCNKy78K8hu/Wzh2JfRwI+eplx3ZjhLA0ipMotvP9ntw==
Received: from CH2PR19CA0023.namprd19.prod.outlook.com (2603:10b6:610:4d::33)
 by CH2PR12MB4102.namprd12.prod.outlook.com (2603:10b6:610:a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 12:14:18 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::d6) by CH2PR19CA0023.outlook.office365.com
 (2603:10b6:610:4d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 12:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 12:14:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 05:14:06 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 05:13:59 -0700
References: <cover.1711385795.git.petrm@nvidia.com>
 <e819623af6aaeea49e9dc36cecd95694fad73bb8.1711385795.git.petrm@nvidia.com>
 <20240325173417.1a79b631@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<nbu-linux-internal@nvidia.com>, Shuah Khan <shuah@kernel.org>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, Benjamin Poirier
	<bpoirier@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH net-next mlxsw 03/14] selftests: forwarding: README:
 Document customization
Date: Tue, 26 Mar 2024 11:31:31 +0100
In-Reply-To: <20240325173417.1a79b631@kernel.org>
Message-ID: <87cyrhjim4.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|CH2PR12MB4102:EE_
X-MS-Office365-Filtering-Correlation-Id: deb2ee42-fc1c-4aa0-d2fe-08dc4d8e4305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FyipFfhI/Ampjh+avNGRhZZpbhL+3eAjcfLf0A6pmz3PVAEr6S1H5YiuUlOHZJtWkab3F8TU0PypjGUbfa6GIBVTNBK+zmS3yBP5QPZ1K+PtE5UcFeU7z7IOMFqTBxlxmHcfTpqdxoZD0ys6/cbbeFwvAUiGIWCsnTFwLheiHeGJXClh8QEkqyxiXbhb/8Aara52xgX7SpsivG8cPsspo4KFZKEpWi/LAe5LMJJd8nWBn8bxY9jqMshjW0QlKCgOTLEqJM3U0nurKs4L/RpjRTbLvyEGJ+kPTtSKmvrjaEVYyqe07PrrtqUOsHPFKVZhO9dyxi4F3MRuaMCzuQb/1cd54YieKs1q4nS6jxNt26m5ZtAZBHkn7LkUNGRX1Sc9Oz5psVsSJ/og/eOvB8B6SSMLZRQFn9OIrPfBan0yZlUOAFFvzM5a2P4Uo0p8sR/sn4XvHuYbwm4xvT9v9Hhr1a6eldQuzzb0m/jKrnrYPcQsdYew+dTvfyUQiOz3wOI43j0EXvjR8W+o94OH7fIyAf+UsKI+mE9Kb+U3b6qpprdt6/HOtkHfgXQUGEWc5bO9Os8GFX0Z0JMSUlMsHgIJoW1EzmKNmkGAuHdOCI1doC19oVVX0hq06Azkvskwp94dbXhcY+czjOKlsHfmaJgDexeRofSfDuN9TiOmIiOB9JNs+vrVM/6dZyOoQj6SehNwUzKRbRaSvxnWBVaAOoeSgKUSQSJwFk/+IMh8WdpSx09bezpIWojDEoTtMSpV7eT0
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 12:14:18.3199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deb2ee42-fc1c-4aa0-d2fe-08dc4d8e4305
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4102


Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 25 Mar 2024 18:29:10 +0100 Petr Machata wrote:
>> +The forwarding selftests framework uses a number of variables that
>> +influence its behavior and tools it invokes, and how it invokes them, in
>> +various ways. A number of these variables can be overridden. The way these
>> +overridable variables are specified is typically one of the following two
>> +syntaxes:
>> +
>> +	: "${VARIABLE:=default_value}"
>> +	VARIABLE=${VARIABLE:=default_value}
>> +
>> +Any of these variables can be overridden. Notably net/forwarding/lib.sh and
>> +net/lib.sh contain a number of overridable variables.
>> +
>> +One way of overriding these variables is through the environment:
>> +
>> +	PAUSE_ON_FAIL=yes ./some_test.sh
>
> I like this conversion a lot. Makes me want to propose that we make this

Convention you mean?
Nothing was converted, this has always worked.

> a standard feature of kselftest. If "env" file exists in the test
> directory kselftest would load its contents before running every test.
>
> That's more of a broader question to anyone reading on linux-kselftest@
> if there's no interest more than happy to merge as is :)
>
>> +The variable NETIFS is special. Since it is an array variable, there is no
>> +way to pass it through the environment. Its value can instead be given as
>> +consecutive arguments to the selftest:
>> +
>> +	./some_test.sh swp{1..8}
>
> Did you consider allowing them to be defined as NETIF_0, NETIF_1 etc.?
> We can have lib.sh convert that into an array with a ugly-but-short
> loop, it's a bit tempting to get rid of the exception.

The exception is a bit annoying, yeah. But it works today, should stay,
and therefore should be documented, so the paragraph won't go away. I
use it all the time, too. I basically don't use the config file, I just
use the env overrides and the argv interface names. It's very handy.

The alternative is also very verbose:

	NETIF_1=swp1 NETIF_2=swp2 NETIF_3=swp3 [...] ./some_test.sh.

Maybe we could do this though?

	NETIFS="swp1 swp2 swp3 swp4 swp5 swp6 swp7 swp8" ./some_test.sh

And like this it won't make you want to pull your hair from all the
repetition:

	NETIFS=$(echo swp{1..8}) ./some_test.sh

But NETIFS is going to be a special case one way or another. That you
need to specify it through several variables, or a variable with a
special value, means you need to explain it as a special case in the
documentation. At which point you have two exceptions, and an
interaction between them, to describe.

