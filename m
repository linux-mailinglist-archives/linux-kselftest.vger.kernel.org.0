Return-Path: <linux-kselftest+bounces-44847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0305EC380C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 22:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27EFC4F98D0
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 21:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB9E2DCC1C;
	Wed,  5 Nov 2025 21:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K43++eXd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82692DAFAA;
	Wed,  5 Nov 2025 21:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378306; cv=fail; b=Pa2aLbtgqsVOQn/HToKU2W5kPiQfl4yh/iJWIjIFNokYsz1kWEZfw2RDdz6bIz1DTaAG7dViHC6586QTrfcgpymwRRYjIXdjtffD+mWVrbfEe7/Xvmy70xVfBeY/oCdedk0hNmZxD2TPzY0xMXZmj6b34qjf3xPc0AhZ71Hl4co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378306; c=relaxed/simple;
	bh=HX/4MDCk91YuMdOZgW7/WGIzgKgzf2N5fKndsfpYlhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uRjCvuRu48WDszMrAp2CKoTn5vmOn62JKRw8ScIFzlC33MkP2zZy8KTzVJsBk7BViWaH5jxcrrApj0+hUJpINNqAeatPrbjhwEedgN7qn7QI3Ik/citxDZt4GXJK1p6OvEdJ0pNlftLtzM0jR5ZER2dInU/b+5g/r+RHyF/4Vqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K43++eXd; arc=fail smtp.client-ip=40.107.162.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6yPE+vg1Y0zN6BRmljOoCzavTKOQo9y2DEGaqQMDvpv08YOHlOATz5r2Jb7aBxAdOE0ir+fdociGUcF6z0VQUMkr0F4YsRgiE4MB8vJl9r/Ip6h9s5gFtHI9wz//lgraG6IvByc7d7yX/Qi/XgUSwpu9OiWiPFCfwfju6YPM3jy6/pu7ah53Kf47SEMJFh+TevxrzYO/lB/mm9kAbVDw8nKhIyvvCLbgpdKJZN2v6wQhBi3KhhAq/Gyb3nEVg3oVTbATOgXgaoXLnrokUqc9Xwl0r7YKNMjMDmnYybpzLfgIKdYhSEgcRGH+9TUAenhSFqqwAxM5NjdQcG3xm8IMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cw7oOsyCJa4SLdoqEGH/yqNERAqA9A5RjWoz8TuuYwc=;
 b=V4AHSsMIbRWDOqXVw8Sh98hs3TnwhQF8do11pfpZ2H+Hk60gpfj7V9Eg/8ax4XeljGhLdTFZ/cD6qI55hHkh0/41kKymExaYcf4a9JUrtty9OAI1mAFPwY6MoIiS148h9xgbGgot1m6sfM9rJhiTtLia/4OsKOoQZ8gbQWnodg7iQfCfiPzq9okbla6HU+wM08M0w83qYIhYEsQXHCVOsqMcOwp++h0uj39ndOKllIwyKL5x10vvjMyXB7LP0IslZ05poaoF+kIlBKHE1Q0Xak1Rwdfq6fDDJI9MciUMPygyIFh/wz2HGCwJaXefkWd/k7iDoYyyP3HNWufMBCc8lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cw7oOsyCJa4SLdoqEGH/yqNERAqA9A5RjWoz8TuuYwc=;
 b=K43++eXdEIzxKMFsHmWhYJ3M6Z2GI6UC4OR5YfUXtMA7XuxCyz2JlGgL0LI/nQhpfMFbGgCopsw431Iczp45N3w9WJvCna7QPR6WRrosGIi4CLffCoq191nzl7pFnH82QfLm2dZp1h8xYfZwEsOtlKxED8SbWYdqyP74bXDMk3OMV+t+iWLNb2vX8sHhHQ8Gm6dKhUr0lD3RHwZh0nXx8Bx6pn3AWLQPlY0TRlCLw5X67yNxpDWbLukAhER5ZiRVEiwb/0JJMP1agQmrT06qQUnzqNVeFkwoTaf0RthDtsXJ1ZPySFeo4X4VUXefbSQf28i3TXc30o1pCUkfQoWMyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB8367.eurprd04.prod.outlook.com (2603:10a6:102:1c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 21:31:40 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 21:31:40 +0000
Date: Wed, 5 Nov 2025 23:31:37 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: local_termination: Wait for interfaces
 to come up
Message-ID: <20251105213137.2knkuovcc3jpnhqv@skbuf>
References: <20251104061723.483301-1-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104061723.483301-1-alexander.sverdlin@siemens.com>
X-ClientProxiedBy: VI1PR07CA0220.eurprd07.prod.outlook.com
 (2603:10a6:802:58::23) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: 4079eef6-5b0d-4557-2b95-08de1cb2b523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|10070799003|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bW5Mci+ePRDQYSr8bcEtnS47giEVJ2Gox3aJkxRE4d+3OmNsvPWjD4TsPGhY?=
 =?us-ascii?Q?qXjAvHnVBgEE3/2UOIQmCvQJgL7XEwIlX4W2ez2dSa+Sv/THkWO8FY6QWOIF?=
 =?us-ascii?Q?VXwTG9tTvlPm46cjKxKDhZ1x87Q1yvI2fo7bAg0NFIZAf22ZGIL1MNyc9G7a?=
 =?us-ascii?Q?wt8AFfwUpyDrMRPvK5nvDrWWSt2wK47JHNZgz6cMKFAcJkUtpceNoonJ/U2h?=
 =?us-ascii?Q?zfurXg/oQWVvY7dr/XEzor0SHkm6bWGZKG3h7NQynRM83F/EmRRu//dReq8l?=
 =?us-ascii?Q?FFHcAB2aLVwroA3PE2MINv2g4WXMlRk63Du46DOK1VUdQhArFyNEmLfcWHF+?=
 =?us-ascii?Q?gGFTU7QRh0p/925iuHjSFWAOuMNuoGD+w8MeczdFeYO1CWRAvLkJkSK6U90y?=
 =?us-ascii?Q?vpbzUYJNlBhP3CKkjxDs+pUrJhYLZTgcBf3noZroOHzsUAwKa1FeSmRHjVPs?=
 =?us-ascii?Q?oPNB5ljTeh1fm66UcH2ieZYUTD6Cq4Vg0mX1WJezP7ox+HdQH64s6rFC+XtX?=
 =?us-ascii?Q?2y5C9NzGrvy0WXiMdfzgweW5gCu0imBpM7D9MNWNf2SH0RCh6uOD+KoOjjG7?=
 =?us-ascii?Q?HJO6JoEGvLIpPl69avKPEhF/3P9r1p4VCx2Igc3vfW+GXUs5XC7P8+qmm/LI?=
 =?us-ascii?Q?P6PI6UyWy4s4iuNVlC83kwn4tD7wfHh0Czyk/6UmX+vbP6AHqhpTvLiUXTKC?=
 =?us-ascii?Q?I/XB8POEYmU7iX5laW7Yty1KSYkkaUzhYCsadJ2LRR6OwWQQ4dHw3Bm9wVVY?=
 =?us-ascii?Q?Fnu3z1dl0evNv6sPjFnHvuzWWcCqZPQfPkaBZ+vMvgiB7Ula7ePlj2gNgWUa?=
 =?us-ascii?Q?WtQlRW6b+t9u27UHjF+l8vgxwOeb7VHnZrB/xmso/s1k0PW6yYFA8a0pm5uA?=
 =?us-ascii?Q?RzY/bAMTg0ugkTPxUUxbjF6RM4wQcnhXa86JgP+RE1eOhL9bRWD1vRXAQJJW?=
 =?us-ascii?Q?E4df6k8WqpYU5b7TwquBqAHGINr+QEr2122RFJdabFXjmq2vT7NqlurN5TfI?=
 =?us-ascii?Q?774t7FYB6V+WZ3Jh4Plb7yP5GYuYaW3IPNPOH+f81dcTelom5vDriFZXDYZC?=
 =?us-ascii?Q?skmwfNE5V3V/HXbhfDvxo9rTZ0FXw0lmHLT40TXWEEg12FbQWl9EEh+8xpY6?=
 =?us-ascii?Q?Wa+U4+m+i8DYmeXF0M8Q7IYQGH/UJWUjUZzqyipYnkdF7qu/elvs7a47MUdF?=
 =?us-ascii?Q?AwYtTHNLgmWsR2YE/zkIxsAvbW1L8eYwpPkbJ68G1QyJ+FzwpYCZLoQ7Y06O?=
 =?us-ascii?Q?rI2xLETIjvxQoP5uI0k6S6q76baMZCp+PNbaYU29eHP1B88mEfVwO7IagkR9?=
 =?us-ascii?Q?ydLxtsCOuJSE3pfo6GVdvrhvOUw4Sn5KWdRVsqVQNJ5Z3vtmoW3RIsvrXwub?=
 =?us-ascii?Q?pUskhJNO+pIkXjj0K98JWoxZM/lv9x5Us/1szItj9GQyZdW6SWWnO0CxhUXt?=
 =?us-ascii?Q?oDLmQqHndREDM3k7rdL439ZbyI4tsfzo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(10070799003)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8nWkhmcbqWQ3xlt2/8CoFhux2xd7y0Oz+bfQgmQe9B/TxIZjgtd2r3dq1tTp?=
 =?us-ascii?Q?YsTNLdtJh94/TE5Fvg3RTvIjlNF4TtspGvNGxiknUQkUoRyN4sGfKOo5nWXH?=
 =?us-ascii?Q?whKQxv+e1i4EhhLsQwTZRL2SNvbYrGsWez+7J0qH6G17LI6LyRz1+0OGiOnu?=
 =?us-ascii?Q?4LTBGJLN72fJxxExt9EAokSpTxWKCq6W4MbQroqbU+RvBvdIFpAJa8W8oUXr?=
 =?us-ascii?Q?8xmNzU2hQP5PFonG2oaB/R1g6t7nC2GEv6bw9iHEcJavJ/QNk/QraDM6FPTJ?=
 =?us-ascii?Q?N4g+YRKS5MxJGpPvAwiTwgloAtrFZGvQ+OLDvb8OXdUbdjffWHH18xNqB2CI?=
 =?us-ascii?Q?74EPSsQKFp0FjyO5TQA6aGugaaY0NlwzktO6nvi7Fryut4YMaeXla5f0slhb?=
 =?us-ascii?Q?vMk41RZZb5gh4xdnY/2Q9DA/Y5BCIKzlaoLduzDPhageUnWhJQXnw+KkZaAf?=
 =?us-ascii?Q?0fBcIqZWpcsiz/gm4zWTf1XS43mVgRMOBaytq22q8X4mpdCNT2X3fBUqO7BR?=
 =?us-ascii?Q?SkQipbCxUSAFwVoVZyj3rLxE0gvyi0okoLewmkfT7j9LA4RwWG0ze1XoRWkf?=
 =?us-ascii?Q?HlJdAYg8zZYoncMmBIYSuULAXRt4Ch6c/UNLlKCsU9Kl23kzTYVgcPdXq/Wp?=
 =?us-ascii?Q?tgq877aRgnoWUUO4bI3g01bMaNjZhMzto2qfjAQSfn3ozLCgLfL1QoR5HtqP?=
 =?us-ascii?Q?ZkmdEbZKOg4jClFUU8U9OFq/E5cTP+lA7lqDSlaa03JR7lPhkg/UTIenYD/6?=
 =?us-ascii?Q?vZEdtl0NX/9p6OgK8IrfZUqnMG7WiDinYV7dJGUtAkksyuQgg5CjxmhwNnni?=
 =?us-ascii?Q?ox4W7m0dei3rH9kKNbiooqTT3yBg8aMBRdxKiTcnhGxiAfBLv13W0IrIi3fA?=
 =?us-ascii?Q?vqUOSTxjJolOrrrqBOJzr8RLPtKKnh/7WVSGq5CYDfd5tnqlzh1VbP0gCA2f?=
 =?us-ascii?Q?6OPJDKNOI2VhSnGHyTiwG3zrEysctvQcou1Cb5uS3icIuhGbKF/jmenDJEQP?=
 =?us-ascii?Q?TQtKW3DCxlvd5DuYQcIursm97tqudLEJavpljl5vZoEfWX1+S6XL7DLi6T16?=
 =?us-ascii?Q?cSrYG5+pFbOjkxSh2vcNvyNQDg13WCHTEPiD8gjIPwTmHJlTP8UyT7Z0akdL?=
 =?us-ascii?Q?fouNUZOf/cLhTVeGQLOXSIy5RTyDzTLVlg6LlzKI06xpa++XlKQluUIN6koa?=
 =?us-ascii?Q?+rqCvsSzshAP7lPHkcm0m7UAUx+TWqeCuvJ7ZRoAsVdV6lLerp8quCNpib7D?=
 =?us-ascii?Q?eN+LSjsMxLOoswnrPz7Va0kTDPT3HQJqTIaQYbfm+4O/uuS2Rat8YANluAOA?=
 =?us-ascii?Q?kkV7zFIGSoIJ9CdXKOUcpVdBXDHbKwsVt9l3vQrecYNnIg8DUPmaTOwDK6L5?=
 =?us-ascii?Q?5a67Bhp31pYBcNb9dYTAQlfpovcZpajTrQ8QNCe1FQ5kbgEFCSo2jZ40EaKO?=
 =?us-ascii?Q?+Kq4euXaLZT2poaI/wpADHqJHG1gKxJnp7bmJL8sioeXz7B4X/0QydsyvrET?=
 =?us-ascii?Q?Tw4t/uWbtmCq4CfTAI6UcY+kCw+g0wpOYTIqJxjKeet+75U9cK04LN/R7BWN?=
 =?us-ascii?Q?CQBG1pqqRR8TkLID47II0d4LP8cBc2odlj8iJROrIunuFazNYxSnfPSeMbhL?=
 =?us-ascii?Q?f1hZZPMgj0hUZR8p9FT9LjsvXxiY+9HdzIle0AocAqO8J4irdaRx7ZVTPbYj?=
 =?us-ascii?Q?QuvHzQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4079eef6-5b0d-4557-2b95-08de1cb2b523
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 21:31:40.5363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4J7r/vuK0sp6FipbA5hSdcPoJjAb8FgHM7hlzkOGR59HQf6fRgAAAMwmMFFmQdlfWW6zVwzJiqn8xWfyPNWuzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8367

On Tue, Nov 04, 2025 at 07:17:21AM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> It seems that most of the tests prepare the interfaces once before the test
> run (setup_prepare()), rely on setup_wait() to wait for link and only then
> run the test(s).
> 
> local_termination brings the physical interfaces down and up during test
> run but never wait for them to come up. If the auto-negotiation takes
> some seconds, first test packets are being lost, which leads to
> false-negative test results.

Yes, sorry, dropping the link is an unfortunate, undesirable and
unaccounted for side effect of simple_if_init and simple_if_fini,
mainly used for moving the IP addresses from the physical to the various
virtual upper interfaces.

> 
> Use setup_wait_dev() after corresponding simple_if_init() on physical
> interfaces to make sure auto-negotiation has been completed and test
> packets will not be lost because of the race against link establishment.
> 
> The wait has to be done in each individual test because the interfaces
> have to be brough up first and only then we can wait for link (not
> individually, because they are expected to be looped in pairs).
> 
> Fixes: 90b9566aa5cd3f ("selftests: forwarding: add a test for local_termination.sh")
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  .../selftests/net/forwarding/local_termination.sh      | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
> index ecd34f364125c..369c8b2c1f4a2 100755
> --- a/tools/testing/selftests/net/forwarding/local_termination.sh
> +++ b/tools/testing/selftests/net/forwarding/local_termination.sh
> @@ -430,6 +430,8 @@ standalone()
>  	h1_create
>  	h2_create
>  	macvlan_create $h2
> +	setup_wait_dev $h1
> +	setup_wait_dev $h2
>  
>  	run_test $h1 $h2 $skip_ptp $no_unicast_flt "$h2"
>  
> @@ -448,6 +450,8 @@ test_bridge()
>  	bridge_create $vlan_filtering
>  	simple_if_init br0 $H2_IPV4/24 $H2_IPV6/64
>  	macvlan_create br0
> +	setup_wait_dev $h1
> +	setup_wait_dev $h2
>  
>  	run_test $h1 br0 $skip_ptp $no_unicast_flt \
>  		"vlan_filtering=$vlan_filtering bridge"
> @@ -480,6 +484,8 @@ test_vlan()
>  	h1_vlan_create
>  	h2_vlan_create
>  	macvlan_create $h2.100
> +	setup_wait_dev $h1
> +	setup_wait_dev $h2
>  
>  	run_test $h1.100 $h2.100 $skip_ptp $no_unicast_flt "VLAN upper"
>  
> @@ -505,6 +511,8 @@ vlan_over_bridged_port()
>  	h2_vlan_create
>  	bridge_create $vlan_filtering
>  	macvlan_create $h2.100
> +	setup_wait_dev $h1
> +	setup_wait_dev $h2
>  
>  	run_test $h1.100 $h2.100 $skip_ptp $no_unicast_flt \
>  		"VLAN over vlan_filtering=$vlan_filtering bridged port"
> @@ -536,6 +544,8 @@ vlan_over_bridge()
>  	simple_if_init br0
>  	vlan_create br0 100 vbr0 $H2_IPV4/24 $H2_IPV6/64
>  	macvlan_create br0.100
> +	setup_wait_dev $h1
> +	setup_wait_dev $h2
>  
>  	if [ $vlan_filtering = 1 ]; then
>  		bridge vlan add dev $h2 vid 100 master
> -- 
> 2.51.1
>

Functionally I have nothing against this change.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Two ideas to minimize the delta in a more obviously correct way.
They can perhaps be implemented together, independently of one another,
or not at all:

- setup_wait() could be used directly, as it waits for $NUM_NETIFS, aka
  $h1 and $h2.
- There is no case where run_test() does not need a prior setup_wait()
  call, so it can just as well be placed as the first thing of that
  function.

