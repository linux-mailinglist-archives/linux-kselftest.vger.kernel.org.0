Return-Path: <linux-kselftest+bounces-22640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EFD9DF1CE
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Nov 2024 16:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB5BB2158C
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Nov 2024 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316F01A08B2;
	Sat, 30 Nov 2024 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JqX6zHSg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A0B42AA4;
	Sat, 30 Nov 2024 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732981398; cv=fail; b=b9b0tpjbrQx43SnEkm+ew0mHpuLC9N0D9VL/nRR5i95SGpD3kzAM6qZ8sPzgSdv25ILEjEU79uqGGUMESkcc/6ExxiIxozG/gPyrEsCN6CM8e4kJBRPMQKirDL/XK+anXYWf+zNoqbRv9KF6a0+FV8zOSfwJk40vBE6rR3FU8KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732981398; c=relaxed/simple;
	bh=T7IDkhnTz01z49E+S5kt46n+mGNm7Jt56+1zQxfmEKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cz+Koe0tVfhrZJOEu8EJzVxxS3ZRenh63c84aGy+pT9Wy0eOqQrKtsncPQUUqTfmo8X9tVY3pbgOO5qoI+2wWMbJ/KvQnRtqnF6RvScsIrj1lC/46zQXcRz/uJlJPlfowz16xwtGBKziXCJ2Gv1lYNYnZ7YHUFQDJzbUgvs+hDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JqX6zHSg; arc=fail smtp.client-ip=40.107.241.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9+GfCXPc1YDQm0UBh/6mdxnPhwcrp06cnH/zVKXKFHqg3OHRGKLUZz2L5vts6kA3rIjmrphnNL9H79ia0koNVbBnEUGinjSPydR8IfsIsceC/KpbEQdC8uMwjfMO+2903r0x1FIVIUydCf7z2QyQc22dmeS60nX4dsUzqepvyxMnrzuw0HXDSmuY43VBkpf1inz6GVwhNuEMxZ25VRAu2Ou8x1QP4+fFPNk9+eWSnQqWyZWUjSiLytgLNHGLk03Me4d0YpRSfGmOl3PdPYNU8dAbn70+f0EVopb6YJBeWaRqePnRbEcwRMvqI22u/S+mXgL6Fzqwhqfmv9a0Snfhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I40LB55bf0vdzmc2NDuPhbTQT+FEe7tpMAFZKX1xvfI=;
 b=vwzJH5IXVp3T4MnIXkEUhGro8NbHASxM3vCURNoKAghuh61xnutvoBD/4Qh2madhJ5PSQO4HNIgkt0nU5YkTHEMOuox8YlfhKTELVO46HZoya+HlRp0oBdL0FV6H/nP5OW7tsXSktKwFPy1gZ9mrLk96A/v2NBHlq8iMn0/qLlb8PdFvlC2o6BwnHfJzu1hQ46EOeSd9szKWolhBTb83tFf+Y7IL2T39NrXSt7Cgh0Zk5H42bv3fIOBX7Cw+kOQyWOZMD2g9QfzCGoh8gGihcU/rgicv61npqVw5901uZhdYDaWAHl5oWgsl7zo3t2t73ByrcZ/8SCt0QtNwuzNfPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I40LB55bf0vdzmc2NDuPhbTQT+FEe7tpMAFZKX1xvfI=;
 b=JqX6zHSgGggNj4kmJAv16RIfsWjzUOKbrbib9pWZkMRWYii9FrjhJSUfIRSpsEBNYQYGIHMYS8JhsIFtF/45CNzWKrgmx9g/hZ0SnXZEvlaKlxOHqivUEGfIE7gdHu60J36SSfbPMIxKNMiKk8ws2H2xWDelY6bkGSCRm8ipgAdp9fTqXlUYaTnK5vQk50ETa3PVJw3JLc0ZSy8p/eZLIe8P4Szmwi1LqXqz0ytx8h43/3ssu1Ej8ene0eotCAVndipoNpFTObNTHloabiSZjdT7qrBGAsqjhvuxUsRie3cHcng7FG3x+avGpKpX7kVE49R6YAqcb625qhTvz0Wnpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI1PR04MB10074.eurprd04.prod.outlook.com (2603:10a6:800:1d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Sat, 30 Nov
 2024 15:43:10 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8207.017; Sat, 30 Nov 2024
 15:43:10 +0000
Date: Sat, 30 Nov 2024 17:43:07 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [net PATCH 1/2] selftests: net: lib: fix broken ping with
 coreutils ping util
Message-ID: <20241130154307.cskk55ecltjkinqz@skbuf>
References: <20241130113314.6488-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130113314.6488-1-ansuelsmth@gmail.com>
X-ClientProxiedBy: VI1P190CA0051.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::10) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI1PR04MB10074:EE_
X-MS-Office365-Filtering-Correlation-Id: f79e15ab-93a1-4ba9-718c-08dd1155b17d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n2FWfZg88a2J7oidHft/hnZRNJI8uMSi5iItXObFQRrUBn8sj7Q6rOOYs7o0?=
 =?us-ascii?Q?AqVKyJjp3N7XsI/RcGkHfqk0yDSHe9ztz3za7ZXgfoDKuVqa9oriyc5dD2YZ?=
 =?us-ascii?Q?GMfhTjkDZwL+wrj6rKdNeRUwFKWUOgDJ+lA8Y27ZC55EMtEgczqtFqT5a00C?=
 =?us-ascii?Q?vdu1uGlwuiuxvQIhhkEm4z9K+b8ObSF1BoYtJTNpHg+hCoyE23b0GCEytMnQ?=
 =?us-ascii?Q?XfnBIEvHp/8NTYMnEGbhYtWn3gDyGPJs5RZWjVIWgslU8TR9c2PMs2nzLvxl?=
 =?us-ascii?Q?W9IpANUAyYqO5/YJp+FsbTv5f+v892m3zqrpzmacnebATLplN7UU7BAOdlcA?=
 =?us-ascii?Q?W0eG5cVE9d4pH6RN3RtUQyMe/A+pOT7pipUGVLDVyVTeIsrPzUgoeynsj8XC?=
 =?us-ascii?Q?Z/db4gONw8Rr0exQexnUgDbSM+3bW+lZvWzncT/saQw4uM3Yb2OAPj8dnQLL?=
 =?us-ascii?Q?LGNU8hV6ZuvkV5x9Oa6dTsvPdSmWSPREJPP8EaGuLfYpnXb9AS1KzPs4hONq?=
 =?us-ascii?Q?QP47izi8v73aZanYf+i4IqcjpGMJhfgcXAhsDoq5yg8GYix9rjplB10LMpOc?=
 =?us-ascii?Q?qxwIf+9tdW4Ku9D51kEVtaCJMj7wHn8zlX4vUpcrPF8oJCXUK4yBF2BBnCq2?=
 =?us-ascii?Q?wMpdlHktOcs+i8xJNDoRTkWL4CoxyZr11+o+zshrsb7qwqlePWCw0Ez5bLFz?=
 =?us-ascii?Q?mJ4gXENlbrOntK7LPI0udRXDturimRUZzxTGQHvMHiOzD302I+7mgEj1/3ET?=
 =?us-ascii?Q?fT3JhBL8iUrqzfd3JqXevPsxVOohnPQsq4ROlATMwqm47Lcn6qPRr3/Ksh/h?=
 =?us-ascii?Q?lm8uvwnFlvn07GMENoFHgBmY/9SfrUOWzYLoSFo+rL/07jLKI9Epa2eJMQhV?=
 =?us-ascii?Q?whqj4180v09ZnYfOemyqDZ5B+QayR9DDL/TGOzKiH1anqih3vNP/c/3ES+Ya?=
 =?us-ascii?Q?PgvBr9FiyjBLMSQ2JQ6XguoDepF7CxKeP+bZuHPvQMNsqn38Ot2Eqvy2IfqO?=
 =?us-ascii?Q?Ny9abWYp80XTBYsQ58mtRdsRQUHTZH7bh5e7Ka3tBGEljzibqr1lxhl+L3pX?=
 =?us-ascii?Q?mGMxJCN/HMdN1kGwGq94eoroFfsYZtpWZqlGInO0P/RZ6U5HOFDyjc+pzGeB?=
 =?us-ascii?Q?wTyG3xEzKYHYYTu5SQJTkJyD4CDirN2MlH4v4m3+6mcT3Zj6h7vcGEXEm5xD?=
 =?us-ascii?Q?mX0T979qp50wPyIFKGwTv7MN9lCe45MLrqsID7OLk76AdHc2v8EoB/M++12+?=
 =?us-ascii?Q?7D+CGFfjQoipM6Z2r2+37paT3rJOtiU5kKcsmBME6l9UAAxlcsEE2ACRNq4K?=
 =?us-ascii?Q?uJPad52FKM/x5a4zTSv41AGhIOTmaLWyX4mkocfaFSeGNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fumK6X+Di8aK+SWAWVZ2hwYbgR73oUmrQFWOyejZoFrGkBQjtXUiUeTsi/7s?=
 =?us-ascii?Q?kqgjAg6OLcMSMExvqSkPBSPr8XxBj6wl3sHKV4U20mrCQs47/a7Dwc+hNep1?=
 =?us-ascii?Q?PxrN2mtpQsBpTSVKbfPREnjz4QPY65bnBiuBpsa1K+ddnLQuMm1L6uGln35w?=
 =?us-ascii?Q?E1VMvKNsf+iaoOOAbXiU+DMhtg69DftJ6yOAjgo8hkryktJ+SpaWtbbXy0DL?=
 =?us-ascii?Q?aCpIj36jXX0oom7EcaY6EGMeqOfRNW/mPAXfhkTIbHfEOo7QZIgw5+GEV491?=
 =?us-ascii?Q?yZ9NyvUjOW5fh2o/cjOXkBMhJpHVm+YNQNc8FZlz5G/p5/ma08j+VGZ9VE1R?=
 =?us-ascii?Q?HHSGhu1KB76UKH1xn4QXRTAIjUmEpNYwpob2fysDjpXSaStF+zKb1I7Hhe5R?=
 =?us-ascii?Q?OO61Ol5908llZz1ZK5SM4XJfGwXob5wlYGA4lMKFyKLNDptfuDzFDmtQYngr?=
 =?us-ascii?Q?ItTpYbwy/VedXSUiKIfwDAoJNqnrqjM1hH3ZwL56a8ILUgjP3+BzjVhYAms3?=
 =?us-ascii?Q?wE0pSiCAGytWyJ/RCGLvgS3jIiBdLZfN7mtDNppa/KHFl+S22a4ExYQDPDi5?=
 =?us-ascii?Q?hgytpgwz+WKgrhpfETmoMD/OJrzgwnuTuDL4jp7ttNZwu2WC0oXz3zwRmulI?=
 =?us-ascii?Q?Y/oVocF0W0xFKwUxb748bd5hq4Kj5IgYEGjoajLrpbolkXn2Jpwiv/t7IPZe?=
 =?us-ascii?Q?YLKKWv+zOCMHEYQ5lnoIM2cqMHE5qROeHXLgYs4MNItL39bYoUdkPfrJNQok?=
 =?us-ascii?Q?OHvA0KG1RMPlxLU7LQaQo7G4vqXrxa+wBdjokpA5Q37xluAtQxlPAt4lBIbQ?=
 =?us-ascii?Q?2ZEXjusxQXiAlxSJJKvFrBxze8G8FF55XysDqDRCEux9fYKdM4V+AhJ1Am4/?=
 =?us-ascii?Q?t0wbrBwug9hSgRA4mf+SqT4cmhgjOHsL8DTHibVGRotDqkyUoS72sUVlIPuf?=
 =?us-ascii?Q?Lz/hAIohs5t6XuHU7guFtrUDqUFELflY41xPRt42T5VHAm5WDvWHkoEDS/N9?=
 =?us-ascii?Q?GellwiJw5abRnfkXl2w8PamToepwwuW3C3uJLbhfzeVo1/92NwHMUACRb/fe?=
 =?us-ascii?Q?wnLSytTTnw69LpJC7Dj1kSEPPz0uH/SvqWAfGWKoleg+dnGiPICorplobKq5?=
 =?us-ascii?Q?tK53XVtcCXZ6oIk1SM6yYsmtUJ/aX1RKodMGX4/+CnH7bBXfxunk8eNVPNcK?=
 =?us-ascii?Q?l0vnnG2vcVzE2B1zhnjHll/EPhP6JoxSAUc9Qm3ve9kFyKoiz3AFleiMnXTD?=
 =?us-ascii?Q?GbupdqngT1o4hbsdEQNVCBQPpzNbHgnFpnT6jXYgmMu00hg1N0tr7MWQvdDc?=
 =?us-ascii?Q?chhN+o39IoJlB7FaKZf3NdLx3tq8rcY+QZ+is0v4H8JmaUX1RXq3rCSstWkW?=
 =?us-ascii?Q?IpHmU+D/tf6XQAfHnyBr/Kt32V7XP7eORkJuFfXTDXFk0ipkJipw9DXoa3vA?=
 =?us-ascii?Q?c6Z7MBIHh/usDYKQbMGVLi1ixPW5tVfmMXCIJOnL/sKyfPqLQ/UysIi+XaUL?=
 =?us-ascii?Q?nJxgzg46CorNrgG0rGXtt+m6jVJdSuXp2P07WW+SGAEGhxbNeuF/6q66JjCh?=
 =?us-ascii?Q?SthuUGh0SP1QdLIZWNIckEsBIv29F/y9aAb9MDykJkd+WMmWwYYiR2NKg95m?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79e15ab-93a1-4ba9-718c-08dd1155b17d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 15:43:10.5761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMddPiZiVqnRMu06C+zdudtZq+AckHeHnsQtrTCBqHJ3y6PYLNY7xcDBcECfX3rzuQpz9D1UrZtNCZ1xEs1SQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10074

On Sat, Nov 30, 2024 at 12:33:09PM +0100, Christian Marangi wrote:
> If the coreutils variant of ping is used instead of the busybox one, the
> ping_do() command is broken. This comes by the fact that for coreutils
> ping, the ping IP needs to be the very last elements.
> 
> To handle this, reorder the ping args and make $dip last element.
> 
> The use of coreutils ping might be useful for case where busybox is not
> compiled with float interval support and ping command doesn't support
> 0.1 interval. (in such case a dedicated ping utility is installed
> instead)
> 
> Cc: stable@vger.kernel.org
> Fixes: 73bae6736b6b ("selftests: forwarding: Add initial testing framework")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

Do you mean the other way around? that the busybox ping is the broken one?
And by coreutils ping, you actually mean iputils ping, right?

