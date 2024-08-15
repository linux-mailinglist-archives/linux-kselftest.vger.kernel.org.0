Return-Path: <linux-kselftest+bounces-15355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F060D952682
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB4F1F233F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C85382;
	Thu, 15 Aug 2024 00:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CeX5ISSW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC55A20;
	Thu, 15 Aug 2024 00:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680569; cv=fail; b=mTXBrUDy05X04WgKIuO6IRHg8fP1Lnsys+o4kOeHuaCRzXOsXb8aIdFeMOKjib9y5Q2Rjcp4eF7IQm/PMi+pifimkBdDFZqczMUC4ztqvhctr5lbEZQ+T3vZV6A1+8eWoBFCe7pHhd+lgc4rGOy4WvafEl73VCU7sRvco+lns5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680569; c=relaxed/simple;
	bh=JqdqPVoQKIaKtIPhR9Y598LN+cwBiChjJxTPCg6YioQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AcMJeW+gDe3k0c1EcSAN14J9hVdG+CjKUavDAm/4AsUMV4ylwX7mKJKY3Q8w13HVm2UnqlnP/FJmF0EM2T08xNBwig27JSvdkA1WmkC5m1Mdf6ysRuuvNu8mwIMrA+TP6pl/zx+sJ1KB8gwQn7ZykKJBo3GqPAC8Ui/nUV+09nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CeX5ISSW; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7dgnFQBpLkkozeTvxsYEgpy0cpZyimra8SEtrRy44wORtUfv+HpuFK7a564o35lM4d9+QPwPPhesT3wATqG18iqyRVs9qGzY4lA54po6ZFH+4gCMP+tvRZYi+oUJ7DKGQzfG8bA01VCz/+wRgvSOAWm/GPkmY4TNpTO7DgMrhOsS+YQEDgwIz4B+13tkZJHXABEdi2/OZiUOPHsNGyYdVkpkXV/p9W0YcHxZEPi9VNz1ouA86DfwEMjJQDlorvj3+LWIvJ+HImWEIzANSZzDjnORwYN87o1Cam9BfVpyAoAVHNyZwxnRrvChp5kRMHlts7nGHJrKZBFjCTWDDMi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2s2J5v4yNMJYUmwxuWj6s+lY7aSx7dDlXfFFyax224c=;
 b=FojmB2rGChjGhuMdr+Limq3j7mLXLfoxP51x3B2WwDWojN+rXwISyDHwBPNj/orM+xZMnAgZZq0+vY5J7lkFrF6UiQ3UeOoWKyCYNLjcOSEoWm0cXdgRVcwsU3bAPLtutQGnwJlHr3SYtTBQnTjPZhoQlVWkrJ+PiObv4ZKu3qHF+okPKtm4EQFw5ylZhdVCWxnZTDZD7PgkuVmtcqJPHZy7wDuzx9uCgizuK+uNPJjdTkEgRY07c4Nf1n7ibUnGYq9OhhZwStGF/QezkxEghlfg5SfSV6md0+j4Hs1h+TBeWUVJBVL10T+4xOKfnk9no/jAUWemlicT8Qd2TbN9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2s2J5v4yNMJYUmwxuWj6s+lY7aSx7dDlXfFFyax224c=;
 b=CeX5ISSWz2GCO7upMn5xyr0st2JU7r4Hu9UDShghYD6iW4esd4rKWcB/GWefl3J5TNnK86Le2I0bK8Xx85ekvcVWsw6OIC7LRRPOafeEW8nA6srG4gq98QZhgKfDjZSQgKxnGNg1iRW5WNmuKr0gt2x+SOli8+08G9F7uPyQ6SoSqxlmArefoy9VsC+3LQ2S1OQy+bfZp8Z8zrAdNpFTy0oPWMX6EDrxuVi4Cct6MehhJujO2htWPZIrh0ZfSWS5stYZ57Lb+PJ8SpbtT/Db4N92yVUJnIUPyamt9oWwNSX0dlm5yg4dOf80Gmp9r78YzaG+UydxYnEvZtvXt+YlLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10285.eurprd04.prod.outlook.com (2603:10a6:800:21e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 00:09:24 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 00:09:23 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Hongbo Wang <hongbo.wang@nxp.com>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Colin Foster <colin.foster@in-advantage.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 00/14] VLAN fixes for Ocelot driver
Date: Thu, 15 Aug 2024 03:06:53 +0300
Message-Id: <20240815000707.2006121-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR06CA0143.eurprd06.prod.outlook.com
 (2603:10a6:7:16::30) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10285:EE_
X-MS-Office365-Filtering-Correlation-Id: a80d87d8-5fc3-40d8-d530-08dcbcbe8478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pp+DcOLGht55cRLJT7/6pPzYFnmkrqJTHg5XE0ZkZkhTOscA8tA1Gg2TF+CO?=
 =?us-ascii?Q?Srt3kPIXJFqiUCkp7ZezkWVpRfxuskd0FgPAFkWZKIRW+t58K0lgZCRmuXLy?=
 =?us-ascii?Q?XjnFWv+Yk3o5lVbIpew2L+QSOaXVMhMXuCuouR2cEiZojVf4yZmw2oYxGVrC?=
 =?us-ascii?Q?dw7OATnkPkl0+UkVZnsCXCEQsqnJ6zKhUnuRBXBG/2bAGTiYkfRjULeqj4Gw?=
 =?us-ascii?Q?IJFbMMIgKPY4ePXgYOXxSLTpaZ523EtYHVmBvavmSC2NXc68jeRtwme5/z9a?=
 =?us-ascii?Q?HDgXc1MWKG2agcq4rSlsbfmEdM0Z6f45jb4T4a4OJNXzSEdfOZnYfXd4gtnR?=
 =?us-ascii?Q?PdcWrv2p+LPVGikTlFIjljjXokV8Td7uevW5a5/kfMceojTtn6Z4K+7XyghY?=
 =?us-ascii?Q?g4O9LsPwbVukQXn2wpe6S4s+RmKfsqlQPqm0cU4vW4Xqg4rp6lwanPfh6gVk?=
 =?us-ascii?Q?2ljzZNH1Eo8tks8I1623KZo7K4wXFFAwlqKsvBpZPJZZMlxrBvV7NA+vDIHl?=
 =?us-ascii?Q?tq8vWEL70af8ajUz4jnLD3Az8SFhY17jSluoJ6icHJD2rQPztQT3av/D0+Ib?=
 =?us-ascii?Q?QEM8wAbP1vjlHUFxLQT1X/NsIGgCjIZ1hQ4AZnEofYZnGsQr/RetqmHyqXkc?=
 =?us-ascii?Q?qF6GFCVLuzq4joffd1+3f0rM3ydQfilfn1SbYfsrH9J4eHrvXxnrh9awF7nH?=
 =?us-ascii?Q?yrFtZIJCzb3koGL2AfncPSlh8vLRSzcxiPYAyMOixhS++GCEVri017asyz3o?=
 =?us-ascii?Q?RiMcGSQIW572vsmtHqVsEaIgYO0dd/a+iOXvHOhiI/bdmIP6dy/5w7SGDYLP?=
 =?us-ascii?Q?2/rfS0On0lNCOqY0TCPI3jAv4NXmMVp+9wQ+vAehXeaBp7e0DQ3OPwJTsWbe?=
 =?us-ascii?Q?RRI/f4jPMbt8+EAfj3CoJA/e+mG8rQxGYwXF0lxV+htOPvJHHXjfPRrJLx9m?=
 =?us-ascii?Q?nQCeVrkfukabmxiI3Da8yk055I0LOlEUoF/nsiYC5Se0rfsOzuSwLFs/2yEP?=
 =?us-ascii?Q?TTpBj7f+9KaRUr1OclUYoDg5hR6jOQP4PpBUHm96W32RRvcMrN/U61r1CXOG?=
 =?us-ascii?Q?VK9jkYOzZARQi7bnw4ZQnrqkyFEF6MOgwV0o6bmcT17lxp7RdhzVOHhpWMSV?=
 =?us-ascii?Q?2Ya/u+KmRkdbVUA2DlQwl9N3IoHrcIZS1/o3BZ68TUqOYlcpzjRw+ISu9qjP?=
 =?us-ascii?Q?pfN1rrr0RArEEhcVK/LFEfSLqkhvRg1BVedV5EkEP42Pj1dgAN2ptbjg2AIs?=
 =?us-ascii?Q?Wio8Y/3t+cB1DJ/R26DfJY6kOS8K/QPEi3+ZhgL7KeCUignV3aMB5hX/Ms0U?=
 =?us-ascii?Q?CEJl1yb6tO5QRbnF86RaTt2OTupJ3dr7zO6UXtIQaaLRO9Lo0GfD3qtuUlls?=
 =?us-ascii?Q?JufgjCIYBiX4e0wL576PfM4P7q+tStRVHqrMY3yuHBjiZqS8zQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GGMnuT3HYsixZruPaxIGvxSg9kgmAUOIjGNe6oQxFf93hO4xstN6yLK8sNYR?=
 =?us-ascii?Q?yeoLzQLYFaa48t8BeKLWZW1D4gVjkJ51GOAIFZGnGHN2jgSojIduhVTTxMOF?=
 =?us-ascii?Q?R8vXmzfL1QO2HAcn5gqYMyN6/u0wNhrZbBHLZoJPHryeFqHLKWPklmfFquxa?=
 =?us-ascii?Q?77B+xs9f1l+j8e7+ehq8VKFd9jlZTN5Xb6KiQ+C60XeiIyOEh7xLCGW05BHI?=
 =?us-ascii?Q?jqg6q95BEu5Yh2VHvORef4gnIAUt79Ho5QiKHFso92j41aKdGAHYfV2irpET?=
 =?us-ascii?Q?x4BBSXHNB7VML1DcCFkqTlh4Y2xIBJciq7td3M67TWA7XUGhL9iMmix9WKl0?=
 =?us-ascii?Q?MoSiiuCCIys1ij2PnLKdIe7u8449l7SEGlh6LiHWjxqbVCnLkhT0EGV8Safb?=
 =?us-ascii?Q?I1PVi293nJnbW/PYkCUVD0QTsaWYFGq3gHePHq8ajZrEzMgJOJEtpM0180ix?=
 =?us-ascii?Q?ANqnSs9ZM+PPV7xksHwH83XmpSTdQWxfqmhvXqstF7PyL58s3Gp3q3/NqZvE?=
 =?us-ascii?Q?oqaoYpb8BbNVsyqhuwoWYJSrxvqw5W8bBH26TqGbdkDEruPGgdMSUZqK1ysa?=
 =?us-ascii?Q?hiO2+1Dr3k+crM+2pv2wwMQQ9vHAfYseGNL0Q0LNZwUob3ktdmho0u8F69Y6?=
 =?us-ascii?Q?TeJV8JgbQ+a044vn66d0Dj9kw3Yu1zpI0lYF+3iaNwljNtLnTmhCeHPhrH6q?=
 =?us-ascii?Q?f5wvezBgJMbrCpTmiHltT7Y982bGzYPe7Gz7KnNJgCE/1F49f3J+m5QTSj9m?=
 =?us-ascii?Q?o9lEuxO8GLDPrk3GnlTEPtawtjTUVWkJIY6AC2wsDDjnj2UQrmu5Dh7QrAzx?=
 =?us-ascii?Q?6sdUUtlmlbsgb+P91aH7AH4thpxz5qLXFViacuZ9FFeTKyYXYXZIwu7LOoMb?=
 =?us-ascii?Q?k0S5BWmGvL4rtiqgPgRKGfXut3zbhCErjb3wCq0Ew0Pcez60qn6Za6OdQm9u?=
 =?us-ascii?Q?ESvmwKCzK5FuaOzcgItu4jg+jDBVdWhH6H3x+OhlOynOd/e3EW94TfMp0Zuy?=
 =?us-ascii?Q?Sb0eWkAQVoNJDHRyJA2v6FigAChTu6TtqqyXx8Eu3DIVsd89mmsVhCOYyiSq?=
 =?us-ascii?Q?AommhsVlqJZRbdwyrbBI4pp93AHCPlU/fZebDQstQy0j30iMlT0Qa14dWsDM?=
 =?us-ascii?Q?rwI+moPbB76DCwlro9R+zp3hQZGWVG86SuLJsXstD0OlVZoyufMqyure6W+M?=
 =?us-ascii?Q?J4MeXi1DEUYc012TsEwRKerNlTGyadK6Do1efAAKC5f4zs4cMZsHdntcU0Gw?=
 =?us-ascii?Q?x1RUBPed3TUAeSRpEruy7AMd8A4ZUp6U+edhPKyhDovOGVwc12yrt70Q9Ph1?=
 =?us-ascii?Q?KLAxazw7A4Q0QwQvpp6gvM0c2Jb23QFs8TT69/HIWVY9cakYbuGTiNL50Z20?=
 =?us-ascii?Q?i2vDo4iISu2PGKwwmpMWqJvQuLDDnAncOO4OQuDmSbF/gIVUmJqb1k7MBXlg?=
 =?us-ascii?Q?VdvvUMI2VS9WxV7ccGTfdUNl3xPK8FHNF0nrWZebSg1jHTpICzt7A6IAsOvb?=
 =?us-ascii?Q?HZvO3TnATbPlRkRhLNCF99ZhcWpVrRFnhWv2A19uBYHo4aQxQ4jys0YO8EaM?=
 =?us-ascii?Q?jU/LfwwbpszZm5ynQqayUab7xmFQsEE1ZhRJK4pNOVbV8cYwbVfM1OePgpkz?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80d87d8-5fc3-40d8-d530-08dcbcbe8478
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:09:23.3912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LY0TZSYjFtUvUqkBNwhDWRp1FYLy4pOF1915Qf45bgT8/zyPvhx3L3wk0Jl8XiTyjME02GprgnAKCr9zB/fohw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10285

This is a collection of patches I've gathered over the past several
months.

Patches 1-6/14 are supporting patches for selftests.

Patch 9/14 fixes PTP TX from a VLAN upper of a VLAN-aware bridge port
when using the "ocelot-8021q" tagging protocol. Patch 7/14 is its
supporting selftest.

Patch 10/14 fixes the QoS class used by PTP in the same case as above.
It is hard to quantify - there is no selftest.

Patch 11/14 fixes potential data corruption during PTP TX in the same
case as above. Again, there is no selftest.

Patch 13/14 fixes RX in the same case as above - 8021q upper of a
VLAN-aware bridge port, with the "ocelot-8021q" tagging protocol. Patch
12/14 is a supporting patch for this in the DSA core, and 7/14 is also
its selftest.

Patch 14/14 ensures that VLAN-aware bridges offloaded to Ocelot only
react to the ETH_P_8021Q TPID, and treat absolutely everything else as
VLAN-untagged, including ETH_P_8021AD. Patch 8/14 is the supporting
selftest.

Vladimir Oltean (14):
  selftests: net: local_termination: refactor macvlan creation/deletion
  selftests: net: local_termination: parameterize sending interface
  selftests: net: local_termination: parameterize test name
  selftests: net: local_termination: add one more test for VLAN-aware
    bridges
  selftests: net: local_termination: introduce new tests which capture
    VLAN behavior
  selftests: net: local_termination: don't use xfail_on_veth()
  selftests: net: local_termination: add PTP frames to the mix
  selftests: net: bridge_vlan_aware: test that other TPIDs are seen as
    untagged
  net: mscc: ocelot: use ocelot_xmit_get_vlan_info() also for FDMA and
    register injection
  net: mscc: ocelot: fix QoS class for injected packets with
    "ocelot-8021q"
  net: mscc: ocelot: serialize access to the injection/extraction groups
  net: dsa: provide a software untagging function on RX for VLAN-aware
    bridges
  net: dsa: felix: fix VLAN tag loss on CPU reception with ocelot-8021q
  net: mscc: ocelot: treat 802.1ad tagged traffic as 802.1Q-untagged

 drivers/net/dsa/ocelot/felix.c                | 126 ++++-
 drivers/net/ethernet/mscc/ocelot.c            | 279 +++++++++++-
 drivers/net/ethernet/mscc/ocelot_fdma.c       |   3 +-
 drivers/net/ethernet/mscc/ocelot_vcap.c       |   1 +
 drivers/net/ethernet/mscc/ocelot_vsc7514.c    |   4 +
 include/linux/dsa/ocelot.h                    |  47 ++
 include/net/dsa.h                             |  16 +-
 include/soc/mscc/ocelot.h                     |  12 +-
 include/soc/mscc/ocelot_vcap.h                |   2 +
 net/dsa/tag.c                                 |   5 +-
 net/dsa/tag.h                                 | 135 ++++--
 net/dsa/tag_ocelot.c                          |  37 +-
 .../net/forwarding/bridge_vlan_aware.sh       |  54 ++-
 tools/testing/selftests/net/forwarding/lib.sh |  57 +++
 .../net/forwarding/local_termination.sh       | 431 +++++++++++++++---
 15 files changed, 1036 insertions(+), 173 deletions(-)

-- 
2.34.1


