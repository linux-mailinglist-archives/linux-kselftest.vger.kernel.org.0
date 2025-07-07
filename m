Return-Path: <linux-kselftest+bounces-36701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA246AFB72B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 17:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128D23BF706
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 15:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E75D2E266B;
	Mon,  7 Jul 2025 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Uo4nZhUU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B342DECA3;
	Mon,  7 Jul 2025 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901758; cv=fail; b=LhfrdO6DFoeMzgt7pnm3cbtEx9bhnEimoBU+zfJatQ0XRYLUC+As4VK1zDl8OfCEJPlrcnPslJHbUDXihptku0auhK/UvbAQe0ufnnr0g8DsPSYF6gaQt3oS7UfDqvRw2fDqq+Peu2nZwl+rSilXXlNDLDiglWwxLTLrM7ZuG7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901758; c=relaxed/simple;
	bh=w0rMpBqpbwget+/RtlPGhSxHwaSXHNrg6OFmQ97NkqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rUKafoTjqxfFHc8S0GlAcHyFjbeh75FYL6HTpeR6cgIC981wDNgOQgTDopS8MXyAsv/S9XAg6SIJJnEORC+pNOBDUWBS3JbCQ6kPoZM3TNllJcG4Sw7aOwTEoeSCWDjEr0trYzNp29Qv2qV9tnbGDjUua7lcJeVyrn7m9FcJGXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Uo4nZhUU; arc=fail smtp.client-ip=52.101.69.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnRvyP7lHiHHUdZv47Xlt2xUc9aO/KnbOPtArVPWzWc+WcSB2cIzgwW+2A1b5tAZnWXgdkkh6LQCPO/ca82uXLMvlpu3ALF7Xi6mwYuL7ytPoFV6j0G9LL41kJzFccMJyBP1J27p9quaZMDLahjdjnCUfgv+GXG35MZHiDyPE7ACI6RRDVlgi1g7JozNxOYikWVFJbG4X/47VMeWXJ9rxI2DU1f3ypSBdlM5s7kn33+d5cvCCX863AJAHp9L/0FoeME3UBRbLpJ+NMVhqEEaElAMZzqQdj3jirjjsT/1JgOdjpXC+YCQnovnBx2nK96ZSoqvS/qFuefExwyHBrZK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hR8hOieKK6vac52Ube/YYV53ub+Og6VU/PYXeYs++Ug=;
 b=rnnTyJUX675Wg2m8I98PfENQaAuCgxlpzqkJ7BZNb/B17FxT5ErYRIAmEH39Dy+gC/0/iu/NMbSrtpqBS0HT8QgyK9ndL0MRfQfrOaOyJ3QbflHqro4AQhy4ysn+DJ4SP0HchntcYBspNbWsfRt1qMwYV1Z/i1eUOV2Gnq2Ovtsjbi6rsGoLYJ6GNuNMer6COxfsIpDFbYcainj+FnoWVjwGfp97EHCYQZ/fvWVp1NEPMrOCjQ4pwdiQzihAWFPXbKfsXYfxCts8ZvI1mzqQBII1kpnrzzzR5RaUoIa7JVodoB7Bkf4NHmFONe93x5dmZXk0NOWkvZslSpcC/83esA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR8hOieKK6vac52Ube/YYV53ub+Og6VU/PYXeYs++Ug=;
 b=Uo4nZhUUch0HtoRPG1lj5iY4ubMxwgr8Ji4+M8I27wThW9sP1GmiGlsekSPRA3sCW59Dmd/ixa+9kkQnrFN07ANz6mTmKYKHzkDPVYtHDAF/2cGdSe2h2LemYyWIeLmVGcSUUwDOadohSDAp/T/4HaHntjg0++frzYAvX40kQdLubD1n7/ysaREeRC3g7G03IZnChJI3mp3hZiUu82ILRb2ZJrbEFFPMa2QZHmHqzwuX72zZ11w/N6cJx5pNWkOQW9MConpWpGtHu2ZCJu4QIOOGeTJlH6Zm3aVY+eK+Ng8pELwf3itBglwQ+AMsk5wIK1ozZhNLnwP8mxo7OZ9yLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB10928.eurprd04.prod.outlook.com (2603:10a6:800:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 15:22:31 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 15:22:30 +0000
Date: Mon, 7 Jul 2025 18:22:26 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?utf-8?B?S8ODwrZyeQ==?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] selftests: ethtool: Drop the unused
 old_netdevs variable
Message-ID: <20250707152226.q6wkavbmfca6y7k4@skbuf>
References: <20250702082806.706973-1-maxime.chevallier@bootlin.com>
 <20250702082806.706973-3-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702082806.706973-3-maxime.chevallier@bootlin.com>
X-ClientProxiedBy: VI1PR0102CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::45) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI0PR04MB10928:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b7061c-5d35-4ee0-3f86-08ddbd6a16c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Xxcu3bd7t+ltLpBHjSm1mnlad8L0wtT8kWMtYTkYXOzVBF/yI4SI8t+94jf?=
 =?us-ascii?Q?Npj3I9VidWibnxh4ssXjH4O0S8wK4MEKkGaD8d9dj2sdROsdp/laDzhNic9M?=
 =?us-ascii?Q?5I6JKzZMzd6pv2JNnytLjixlLwYR2YuIUgrbBQSZB9AO6pVnmDg1b1SdtT2N?=
 =?us-ascii?Q?WVnjUSyl23x80dpTptqPqA+6ePngkIjE+ru9jAV2Zd0dVMdcw/C9YfKZZc6y?=
 =?us-ascii?Q?5GjlMqabfHVasuu7sapnZQJFzahEnaWy/vHMgohKItntaCR7jL6kw2EKgyy3?=
 =?us-ascii?Q?HuNYQoGSpUDlhDK7bODHmKfPfHIBNKRBXmq94I2hPhD5qxnBr1s3FO/f2TNg?=
 =?us-ascii?Q?Umdrq8jnrGvX/Fb+TruUy4i6HfRtpEPYnZrGAzawCZ9SE4M3pAFgc+ogsKvD?=
 =?us-ascii?Q?4fej9ZKQss2dxJE0QgWRS+I0A9b37zdnB9Hj/iAnPuQkYm94y5fMXnl9ZWpH?=
 =?us-ascii?Q?jg4J7GPAwUUMBkBJR256Q2E7ggDyb62Hk4y5P85ilVdHJTN6xwnIiod+qeaK?=
 =?us-ascii?Q?COakKXFe1RnZjZUJStsn5HfkOsGEYB88LGVwS2JU9imIPblUxvCxP6OdUVe7?=
 =?us-ascii?Q?PcVxqlSdUeFmw8Vr6WNfL0HrcQga+BT2vGe+kDGhwG+b4JcaGbS6zt2K07mC?=
 =?us-ascii?Q?BFMXpMEXbhD9JNc91Vwas5v+zCtLOWkeXSRvEVvcQg5tWc0yCzB/p4NLzaN9?=
 =?us-ascii?Q?OwJlprHYoHgb9/MRPbaq8kUulrW5qjig49D7svV+oGe/aSc+EQWv3RhPMihR?=
 =?us-ascii?Q?WTLsqFGcifeh2iQp2jLkE/qxsL9gA8s14iP3Wh1Ey9GtZ0FsIgxqLh8mg8+E?=
 =?us-ascii?Q?h1OHOR0y2WoeKOwSd+H/BykiGaXl9rAIcO3NsbhV23i/A0xkiYz4j2lzvx5i?=
 =?us-ascii?Q?gf9i9vSx7o+rUP7GtqFetZn6S1foLHOagLUY6JpWTx+ikyoiyHgkorigShm+?=
 =?us-ascii?Q?guUWXh0IAlJ9Rt570ODYN03vPR8lWGqAOrZnknNlA93lLY2cUL4L7ldqXAh/?=
 =?us-ascii?Q?hT+TPhKuvw8HpW1APHqn4xYwqrX1Looen8cLiyY7Y/hmhzVaF5AcCKPOznEv?=
 =?us-ascii?Q?142/2EU6DK+VBy+SAWjFvnGmJnBL+bpRCmCpsz4q7ktC3kE8Ek30ei7KHYIw?=
 =?us-ascii?Q?sikhd30X/FEHwbrpVzclYTt328mS4PqhjVkWO4MUEEaSEfTTUOEGssGRrmZK?=
 =?us-ascii?Q?nyNJcROk7rjFw4ywQwzvl+SkRG7V3in9lDGiznLsFtaclmfpVYEbP77BdDHD?=
 =?us-ascii?Q?Y+VkpDTIuoOIaYJXrNXvfv4mT35Yus27oYMC5vIEAQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8HOqnHilce0I0pej+Okv4kaCclE2Ei6HYk+uS6T+wkd1x725M407+/p70W3j?=
 =?us-ascii?Q?RywM1RDyl6ru+NwtJRND4U9zbxG8hIA7BAS2/ewSRKu0NU4Cm7X04hYz0gUV?=
 =?us-ascii?Q?2yMLAn3lgAAF+ygmhuEG4tLWrk8NUWTfvmgFxX977rVL11UPDiW6esywDVrc?=
 =?us-ascii?Q?5ut++Heraqx1EV16wnP7gwhQh3OPjnBl89B0ud5dQ88jHaGtHspmqeLk7K9E?=
 =?us-ascii?Q?MBHYd2Ge1pdBocvkBXiY8xlmkZkbgD9ND3T+jD/mIRaxL5mbYloMGvFSCMvi?=
 =?us-ascii?Q?Q/l3oyJZtmUEOHqrKlRuUf4ErTMP4wldHUGSXkzIDQ6D24x2iLFMXi/PQcgP?=
 =?us-ascii?Q?KCmibtRzSN9dR45axqfQMGEQJE2jRnNd4Gz+Ydjedemss79aZY3bckIFfLR4?=
 =?us-ascii?Q?HKbnspzpCLjYe4r8xHNlk25hl33/RvHp0z88E/Drk2TK6pc9lxCy9pI4zp2b?=
 =?us-ascii?Q?mI9Rjdbrh6kxX9ofaQejfO7Km5n6XGRlOL50L5Sq7mgDHWL9HlyVen2oQJPu?=
 =?us-ascii?Q?QzGaXh2sPQD70HK4fK3X62ruG3t8iJeIQBQtuETmTqGycnZRlRkv8cN9PDfL?=
 =?us-ascii?Q?ZsAwuH71E6H0foekIRdLNEzKYfG+DpZ/lcEvrLzTlRZ727LoktyICuYk0A7V?=
 =?us-ascii?Q?4hrxH54OZMY6s4n6AyzJH7VigVeZ7zkkCj4zwAJtyFANgjDizCnpJuGCs3d8?=
 =?us-ascii?Q?D3xtKjBaAnjeVjFUp86qNaFDSolDUIPSDNJZ4YfKQItOyei5idCR+Y6Frynn?=
 =?us-ascii?Q?Tb1oMkAr1SJDDs/cxNNZmx4LRiE9rEXGjmdX4bChODaL1AHOq0dAvp9hog/Q?=
 =?us-ascii?Q?pZVnujS6xBI9Z2jMX/uaFHeLfupy+7sLVEY3J8yUfLvUg2bBsdxkxFjWgiZs?=
 =?us-ascii?Q?xZcacmkDrdxrsB0sTX73R1IkniZobKPsMPK/Rn3k+lKoeCINA9q3RN0z1Vtv?=
 =?us-ascii?Q?7JrRItVM1Ma9emnK5rqxNtXwfeGA0turZSiInjftm6A8qTdz5qi4nzkwHUBs?=
 =?us-ascii?Q?Ief9NMcSzk0qSLMlcYZLGeT7wD5Eu2MphGv318c0bFrF+Dg2EQke5KOD8Njx?=
 =?us-ascii?Q?Hd7juKNPzuqEFH2XdHbucLA+hXPCucU0l3na3kGbdF+S/qgpvzLOvfGfpKax?=
 =?us-ascii?Q?DOuBckicT+LiFdymVWC7Ub9eRyB9QuYec+Y8onl++K0GF1vZw0C0P+eQlmGB?=
 =?us-ascii?Q?9w1DDYrSKqSRPS+lYEH3T48uMPU3smKoiLnGy/ZDFbjS7UsNr4WhIhTL38Cy?=
 =?us-ascii?Q?fz8HUNPJ657wLQrCpzPw5BoyALU95QIGag543f5tApUGAqANaoR6q6of1Wd1?=
 =?us-ascii?Q?vq2v2v2FW7urKcRzn5DgEGc6g6iXqJXIz9jEQ2Gs8/kdrFL8J1WRA62V5/Gx?=
 =?us-ascii?Q?2RPjaD3zbDrFfaVEVZY4qYY/kdByNZRDbJxC1HgyUIUxFimCDb0Rd2S/O1iU?=
 =?us-ascii?Q?0PXrkBM7aPfuw5JpeDredZxCLSNvRf420Y6C4NWofJoYdLBFdvGP/X+IIJGi?=
 =?us-ascii?Q?4ZeyvJqN6QtLYwKqIkSY5b5f/nnL3VH8xbl+rz6wqEbx7Q2HMnRrVnbGQ74R?=
 =?us-ascii?Q?aIQOmUBRbz6PxtikKfjv/AsZXY67MPt5vzc4a8vYWfwcn+zBMIuz4wm9o5h2?=
 =?us-ascii?Q?FwPqQT6IbK0ZD5V3aGURvXoDltC28XGDkVXwiPD8pFASsdSxe3WTP4aJBWRQ?=
 =?us-ascii?Q?OlkAAA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b7061c-5d35-4ee0-3f86-08ddbd6a16c8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 15:22:30.7850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3t2c4Y1S1bZ2kqj/yt9z+10lFbPp7nUu2PSkDKlgbFaKfXZ+FHV7IQA6rGSQhZ/P3KaXecIE6UMHlG4+GvfDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10928

On Wed, Jul 02, 2025 at 10:28:04AM +0200, Maxime Chevallier wrote:
> old_netdevs is unused in ethtool-common.sh. Only the UDP tunnels test
> uses that variable, but it maintains it locally.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---

The story seems to be told by commits
fbb8531e58bd ("selftests: extract common functions in ethtool-common.sh") and
9e48ee80ac4e ("selftests: refactor get_netdev_name function").

make_netdev() returns the name of the newly created netdevsim interface.
It used to be implemented by comparing the "before" and "after" of
"ls /sys/class/net". But the name can instead be retrieved from /sys/bus/netdevsim,
and "ls /sys/class/net" is a left-over that was never fully cleaned up.

Meanwhile, udp_tunnel_nic.sh still uses the old and racy method of
finding the netdevsim name, based on the before/after comparison.
It seems like a case of not converging the entire netdevsim test suite
towards the same solution: ethtool-common.sh modified the logic in Nov
2020, udp_tunnel_nic.sh had the logic since Jul 2020.

