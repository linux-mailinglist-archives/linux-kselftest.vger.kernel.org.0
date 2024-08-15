Return-Path: <linux-kselftest+bounces-15361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E02952694
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA044282AE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CF018D65C;
	Thu, 15 Aug 2024 00:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mu0hB3py"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C03018D64E;
	Thu, 15 Aug 2024 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680583; cv=fail; b=ra4htoVcpaQllfipwxsToW7sNpa5qTZBULsyqo2iObo08Ji3w3VGiJnjKMhiiGTaFlKm1mbUkOMSsHs5rq4+afClRCS5bwfxWYb1xnBLTYbO1B38RRQBQu2DE6sta836GxBIDWCekHpx2Juom0a1LoECiFsGsPyBgC9Dv5Oyh3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680583; c=relaxed/simple;
	bh=kiC1aBzZik3frYM2xJDS3xMO/dXeowPEMXdkjfsF0JA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JD4aVpjnSFKLFram+Ij3G62uA1wtK2eulvGAvEaNRoJi2FpwihNzBLM10XmtS9CYT/ib4nPKJ1i1jfp5E8ms7vFdjCL9ZWYydm3kEAmHDPHMF7xk/q5vYeiUG7Ic+G/6K4MHwD+tv66CDCTCqUeFHorzBe/0oscbWi33ItLuH7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mu0hB3py; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oh6hdxLmaS2VDhOS65qAFoUXmWjqPQUj561Qa8M/E/mDvc0AanSZ4/DzyqMiL4gjEkx/pZLkZDHr8bbjB4idZPmky+DoyRxa9pKyuAcEx1fASvlBggaMEayy/e92KQCZnblqFiKqapV9kQc4DLoCdW0hpWrHd+ETQ8p8UAAzc2hpZUHbU4lAqWGGbB+tbou6FcLSvVk6eYcKYDvVDdBSgWRDK6j1wX2WaxH0RYsylMeSN8uopHO5lKLy1n78zgfeK4kDeEvNBAWeUeErHgh4vn5ULwpKN3469WisDCUlL5qI1AF/tiY0E0XrU8STBJYH14UIryF6swhAOrtaeXhqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iapdVsPVDwJAQMwEyKbqzgUxfq7FOyMpaekU4nSYng8=;
 b=Los09c4CIey5nX1cRMBXpn3l2FabY+bQxLIfb04NSEqTwxpBUMcA2Jx2VNOpAewG5LG/56IVGvrg7pi1RVWoeTAS5VaDMKx6OFouzePOmA0On4x6B4yuZa1CYFJlqBdOcuSWeA/LaRcors7zI54sg40y1TrsefoMp5MaTPorV2xMj3XaI3OPkSxraEl+8fzEKuloPX8f9kTZHM1XShUHWGz0HvFppmTh83d3riPkQEqLBllpWf4j6X7pIasdWxWk4O5bbKpkl5T0mKJMKnYHh+nz6M+sTGKfKGcWRTtvUvUmD1b7wXoJh/fmsf57K7xG3Hf1Swm3NIb1XIQ+CexsvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iapdVsPVDwJAQMwEyKbqzgUxfq7FOyMpaekU4nSYng8=;
 b=Mu0hB3pyGq/k3gSTX6v6PKEcwARtGpvMwQzD6OUu+4dRq3kJolW7275J9OoasF4F7llUi7w0YPEhwPpAop+F5YX2W5Oya7X3rZC8Zf5oZlVWZLAbMAyEYy04jbH/Kig23LZ2a//SPM05kM9QlosBjGZILuMrI3KCj0sZrZ+a3ITdyCUN84aD0zJhbw2pgxhYgCGdmCTDaCS1D/5rUJ1eHfsnIiq8aAwmbH1dWpSqSXKN6xdsiB1pgkGlr5Pr32oHJ1Kh5GP9A48F7VROwrn+fMkV4a0VhCu28wpnbUe+GYHtfJg828iv7AuaP4bZ5QSOq+OzS3E0DK7lwq0RBbq10Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10285.eurprd04.prod.outlook.com (2603:10a6:800:21e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 00:09:36 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 00:09:36 +0000
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
Subject: [PATCH net 06/14] selftests: net: local_termination: don't use xfail_on_veth()
Date: Thu, 15 Aug 2024 03:06:59 +0300
Message-Id: <20240815000707.2006121-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815000707.2006121-1-vladimir.oltean@nxp.com>
References: <20240815000707.2006121-1-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4ad49aa6-3ae4-4104-03cd-08dcbcbe8c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rnqH48gpW1o/v61hGWMfZzuFFmkvxcPp+BzI9114+UWFr3XkbLgcTyjecMxP?=
 =?us-ascii?Q?YddyJpr8Lf9JVLlgo8v3DbTduPDELA6gTinqXBZq/GkOgRUv801vRXw1XBLE?=
 =?us-ascii?Q?TXlZ37MKw2rdTdFJFjywEeAAlXFB+05+/SNSOYgpsUSXu5uV5lD3OrVin0F8?=
 =?us-ascii?Q?uaw3KUdsLMuffrL4Wbu0QTjejilU4/hBTm/XYalM3v7YdMJrcMDLO5rWmihk?=
 =?us-ascii?Q?owUsF6X+QM0nKzNzKaUCRTQ3Er30atPST2jll9G4rVyXH5gHBOy8r7USrVUn?=
 =?us-ascii?Q?3ORIDZrFfR87jOs9QOS5vsICEZC0J/TIglq6ZXkok/fjCDP2coNkNBJCfZbC?=
 =?us-ascii?Q?SK4D3T8NZAC9AmB1uCX6k9Ou4ymDN/MsNuKAOt6BYshelVcU2+phs9W2cMCz?=
 =?us-ascii?Q?AyP8YxfvogSKfm6/9K8qAhGZe/KyoiPyiXtFSL5UE2NCD7zwfQ0iaIP7wFfC?=
 =?us-ascii?Q?jDC6gs/aSuRN7jw94J13tV8ruR6TUUDUzo7o9352YlvbVBVqMG/pk0zS0mtr?=
 =?us-ascii?Q?qmTITX6f+voIlHydH/4N2btg5bGFKy3XFoJGIqOLqZeqgA5IIn2awOKGNC0/?=
 =?us-ascii?Q?+Z7xGHS/f++mQJor+qJ+ROrh83QSycj7vpPkFqFW4tkRBboJgHngsxqd3sCJ?=
 =?us-ascii?Q?ke+0D46+FW7kDYaXzkJf3yw4NquXBL8BaXWnhGJr6KU/s8e4nLqcmqFZlhd1?=
 =?us-ascii?Q?jXiqM22Sn7WYuq7PTJzesRGaEWR28dId8k1N+fDgoWqRcGjOf7k3lH/sgTZi?=
 =?us-ascii?Q?18oWCgCpIYvMPwM4+KMpW/xBHJAiUkFLIxvBwIx+xMIM/wYA8CuZtnoQZWJ9?=
 =?us-ascii?Q?oItDsZncL3rSgwfFOyCXh3O59qis1P9PVoPdX5cMqPtHA+ppKkQzQxAw3e4J?=
 =?us-ascii?Q?02Xr9o9CRXaJdqiUEj+0V3hunfEK4j4lRb+w8eh7W3QPM0h7JPuT+1RsJ46W?=
 =?us-ascii?Q?yISkIOwPqOaezPFT03TngP3PkS9Pe1VA2apGvjGOpNjBxG/yYiQX8SSgd7m5?=
 =?us-ascii?Q?xRsWMDMeN1ZHLhk57IMld5gX8i2Pqp+PDwpZ/4C+0/WKbEb4gG0CPIdUiC9T?=
 =?us-ascii?Q?GMvFDwvJkbymp8RnlHGbGnvkR6Qt6Zpz+HBNAPOEtxYj+QVgMWN3HAlg9YcS?=
 =?us-ascii?Q?sbP+/Og//qGCCbSrPsaYKHrnHlW0HCsOMQ4LSfjQFtf5SMfrZPX/pjW2LW9Q?=
 =?us-ascii?Q?1TQWWVJ35R5nn7+1NBjpeQAkDXCNTiDuJ5Lth5sPaKTcTd64dv2kX2hsKR1E?=
 =?us-ascii?Q?I5Bfr5iMAcf4RZ3SeuU7ckY4NS+7VCksaa1C+vu9nG277XMOsrfU1dxQPxRC?=
 =?us-ascii?Q?/GkEr6YP0FFHVPF6yLnvNdI4D8bCYyDixX6RUDCRXMuZq2dT1T4FlOSKzohJ?=
 =?us-ascii?Q?FTXYOgfVBMR60S9W4qBlOTsiiVsqtXKPpLNkKm5k3oOSf2fuZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2k2BtNEvTc1UZY8UjVczZVL5G3PBsQqXszmOtRkGMRiLJY3ybtSreOEiHxl8?=
 =?us-ascii?Q?1nQqXOsenfAYfq+2trisOA/a0MAuL2YO+qcPBvK6e2fXO+3kd3voIPRjGRsJ?=
 =?us-ascii?Q?bLr5km4W0Ziz6PqFq87H1KfibHzVQwDHCWOrtlQ6vpe2ArBivr0TWN0uKQll?=
 =?us-ascii?Q?SN9SMB/KLniw+zt5gO523eEZOcp0kCb1pr/zgLUpP0O+BVFJHmCAVLBk/XUD?=
 =?us-ascii?Q?tDPqIKVvurQNu7Y9/8B4UsEnApMTrU6Rj9Pb4QT+83ErUaeVhKCpyYIkp0C+?=
 =?us-ascii?Q?IsvEB7kPE1bywhah50tkeZ0NN6fUhKqGnOBS7KRvlU8CsKAHmhQ7PbPBkgwi?=
 =?us-ascii?Q?lheG8pbor2+wCLFYbbAyZSk//kXZlUziw1TcPL97q/t6GPlmFtytcshhxe2s?=
 =?us-ascii?Q?4t0jBNa1o+y6pfdpZxdZZ3Pt+ss5d5gDdmk1ToLz4WWRuBG14l1/PSGR18kf?=
 =?us-ascii?Q?W4pyxkHeTehc3HaOofnkPu179rIaBvyJzIlRtIW7YhWKhiTgnpbukTqj1VnU?=
 =?us-ascii?Q?kjAqRvywW5lFAo87xX/PRdF8fDN+0bdQtHkknQoNWmt4iNuU6lIE/ZMqu6bG?=
 =?us-ascii?Q?5iq2M/K7XLHAwqhStaxSlaAbXPS1J8zD+D9OUewK4jsqCuhQve89zJNDgsMp?=
 =?us-ascii?Q?Agn7Y+bTGAMrzJWZvvF7/oHX90F1HMJeeJrpe7rb4+IXLgJBtDZllscAKwE9?=
 =?us-ascii?Q?6TWUNQ/e6rz5DaNXkW9Ug+HPi/x3Qb3ou9liX+686qB8NNQxo/eRIpd/jcs1?=
 =?us-ascii?Q?KN9nMQMhrKPfKPJX4I8v5CAR6J1ErkKMy6aegLbQJbdFNGz05AYI5IgkrRCI?=
 =?us-ascii?Q?r8B5OYxjPwars7q/p1MtffJDtIUaa3YOaafeJRBMEN4eTCRkmNEBUJnNmMso?=
 =?us-ascii?Q?8vsvBnW7YoJon5YxccSHEPnrZSX0KIN7mmz9sWE2PyXUJ4B+bIY75MCse2au?=
 =?us-ascii?Q?rOyiytt1Pu2yOBt//n7apNMShW5egOIDtkP2LAg25zlhDM0XtcgQSIMVxDR7?=
 =?us-ascii?Q?+VNodnQ+5k2L/4M3naG3e6gPG2vgC5PI5PQwMGO+GWnpTjfEjhmuZFJCXMD7?=
 =?us-ascii?Q?C6TFgF0MsvWyTVTA5VMhIfwXSaIYD+b3aXQaduWrCCadALhT7Iol+NIXFb+S?=
 =?us-ascii?Q?6YIna1r3fBtGD2qNfPzviebajAjJb0Bt4bt5FtE1h7zaICmRbUZIvmDExhZZ?=
 =?us-ascii?Q?Tup4sa25mPa9Vo9Bk2jX7JlJtYN2cwSoo5W/T6+q9JHK7mp12T/bWTuow1CP?=
 =?us-ascii?Q?vf9Pgn/m+lbvWYGbnnsvI9bdnBKexBjoCeVPcVjJHeql97MiBF0LsNlq4Lix?=
 =?us-ascii?Q?L2YFCt36bZxVnQuuDrVB+BpwPWozTrmT951IGWQtp2wokJBOcKQy3OixRHcZ?=
 =?us-ascii?Q?Uxr+dB6AanFJDJoTz9RCp/4wJVfakQC4hqqbzSSyM8F/EJC0KilxEN+d9hfx?=
 =?us-ascii?Q?NxeIeoKj8PUMIexU9WiPhnshCndh4KKlPxhT2YYXIyO+VlaA0yzrXLTJmawg?=
 =?us-ascii?Q?CmQRIm+A8XFYL7FxA+2i/H8r4McDj13p69U+WVsss5OCNogll9Fq3taPEkRE?=
 =?us-ascii?Q?9+J2IQ/AZyMhdpYcoYBTlfaAYApGxM7NfgfuNu3WYLkXB/ILHtLBGGPLm3TY?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad49aa6-3ae4-4104-03cd-08dcbcbe8c2a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:09:36.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihMfl9S8FGUZiXbYpumguI6vqzH4jU/cCUz03noKoVkBoDoEQ4NZueCndjp0PoM7idEhfDEdvwIh5GvXJBCqyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10285

xfail_on_veth() for this test is an incorrect approximation which gives
false positives and false negatives.

When local_termination fails with "reception succeeded, but should have failed",
it is because the DUT ($h2) accepts packets even when not configured as
promiscuous. This is not something specific to veth; even the bridge
behaves that way, but this is not captured by the xfail_on_veth test.

The IFF_UNICAST_FLT flag is not explicitly exported to user space, but
it can somewhat be determined from the interface's behavior. We have to
create a macvlan upper with a different MAC address. This forces a
dev_uc_add() call in the kernel. When the unicast filtering list is
not empty, but the device doesn't support IFF_UNICAST_FLT,
__dev_set_rx_mode() force-enables promiscuity on the interface, to
ensure correct behavior (that the requested address is received).

We can monitor the change in the promiscuity flag and infer from it
whether the device supports unicast filtering.

There is no equivalent thing for allmulti, unfortunately. We never know
what's hiding behind a device which has allmulti=off. Whether it will
actually perform RX multicast filtering of unknown traffic is a strong
"maybe". The bridge driver, for example, completely ignores the flag.
We'll have to keep the xfail behavior, but instead of XFAIL on just
veth, always XFAIL.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 57 ++++++++++++++++++
 .../net/forwarding/local_termination.sh       | 58 ++++++++++++++-----
 2 files changed, 99 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index cb0fcd6f0293..c992e385159c 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -500,6 +500,11 @@ check_err_fail()
 	fi
 }
 
+xfail()
+{
+	FAIL_TO_XFAIL=yes "$@"
+}
+
 xfail_on_slow()
 {
 	if [[ $KSFT_MACHINE_SLOW = yes ]]; then
@@ -1120,6 +1125,39 @@ mac_get()
 	ip -j link show dev $if_name | jq -r '.[]["address"]'
 }
 
+ether_addr_to_u64()
+{
+	local addr="$1"
+	local order="$((1 << 40))"
+	local val=0
+	local byte
+
+	addr="${addr//:/ }"
+
+	for byte in $addr; do
+		byte="0x$byte"
+		val=$((val + order * byte))
+		order=$((order >> 8))
+	done
+
+	printf "0x%x" $val
+}
+
+u64_to_ether_addr()
+{
+	local val=$1
+	local byte
+	local i
+
+	for ((i = 40; i >= 0; i -= 8)); do
+		byte=$(((val & (0xff << i)) >> i))
+		printf "%02x" $byte
+		if [ $i -ne 0 ]; then
+			printf ":"
+		fi
+	done
+}
+
 ipv6_lladdr_get()
 {
 	local if_name=$1
@@ -2236,3 +2274,22 @@ absval()
 
 	echo $((v > 0 ? v : -v))
 }
+
+has_unicast_flt()
+{
+	local dev=$1; shift
+	local mac_addr=$(mac_get $dev)
+	local tmp=$(ether_addr_to_u64 $mac_addr)
+	local promisc
+
+	ip link set $dev up
+	ip link add link $dev name macvlan-tmp type macvlan mode private
+	ip link set macvlan-tmp address $(u64_to_ether_addr $((tmp + 1)))
+	ip link set macvlan-tmp up
+
+	promisc=$(ip -j -d link show dev $dev | jq -r '.[].promiscuity')
+
+	ip link del macvlan-tmp
+
+	[[ $promisc == 1 ]] && echo "no" || echo "yes"
+}
diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
index e22c6a693bef..80ea4c10d764 100755
--- a/tools/testing/selftests/net/forwarding/local_termination.sh
+++ b/tools/testing/selftests/net/forwarding/local_termination.sh
@@ -109,9 +109,11 @@ run_test()
 {
 	local send_if_name=$1; shift
 	local rcv_if_name=$1; shift
+	local no_unicast_flt=$1; shift
 	local test_name="$1"; shift
 	local smac=$(mac_get $send_if_name)
 	local rcv_dmac=$(mac_get $rcv_if_name)
+	local should_receive
 
 	tcpdump_start $rcv_if_name
 
@@ -160,26 +162,26 @@ run_test()
 		"$smac > $MACVLAN_ADDR, ethertype IPv4 (0x0800)" \
 		true "$test_name"
 
-	xfail_on_veth $h1 \
-		check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
-			"$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
-			false "$test_name"
+	[ $no_unicast_flt = true ] && should_receive=true || should_receive=false
+	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
+		"$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
+		$should_receive "$test_name"
 
 	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address, promisc" \
 		"$smac > $UNKNOWN_UC_ADDR2, ethertype IPv4 (0x0800)" \
 		true "$test_name"
 
-	xfail_on_veth $h1 \
-		check_rcv $rcv_if_name \
-			"Unicast IPv4 to unknown MAC address, allmulti" \
-			"$smac > $UNKNOWN_UC_ADDR3, ethertype IPv4 (0x0800)" \
-			false "$test_name"
+	[ $no_unicast_flt = true ] && should_receive=true || should_receive=false
+	check_rcv $rcv_if_name \
+		"Unicast IPv4 to unknown MAC address, allmulti" \
+		"$smac > $UNKNOWN_UC_ADDR3, ethertype IPv4 (0x0800)" \
+		$should_receive "$test_name"
 
 	check_rcv $rcv_if_name "Multicast IPv4 to joined group" \
 		"$smac > $JOINED_MACV4_MC_ADDR, ethertype IPv4 (0x0800)" \
 		true "$test_name"
 
-	xfail_on_veth $h1 \
+	xfail \
 		check_rcv $rcv_if_name \
 			"Multicast IPv4 to unknown group" \
 			"$smac > $UNKNOWN_MACV4_MC_ADDR1, ethertype IPv4 (0x0800)" \
@@ -197,7 +199,7 @@ run_test()
 		"$smac > $JOINED_MACV6_MC_ADDR, ethertype IPv6 (0x86dd)" \
 		true "$test_name"
 
-	xfail_on_veth $h1 \
+	xfail \
 		check_rcv $rcv_if_name "Multicast IPv6 to unknown group" \
 			"$smac > $UNKNOWN_MACV6_MC_ADDR1, ethertype IPv6 (0x86dd)" \
 			false "$test_name"
@@ -290,11 +292,17 @@ macvlan_destroy()
 
 standalone()
 {
+	local no_unicast_flt=true
+
+	if [ $(has_unicast_flt $h2) = yes ]; then
+		no_unicast_flt=false
+	fi
+
 	h1_create
 	h2_create
 	macvlan_create $h2
 
-	run_test $h1 $h2 "$h2"
+	run_test $h1 $h2 $no_unicast_flt "$h2"
 
 	macvlan_destroy
 	h2_destroy
@@ -303,6 +311,7 @@ standalone()
 
 test_bridge()
 {
+	local no_unicast_flt=true
 	local vlan_filtering=$1
 
 	h1_create
@@ -310,7 +319,7 @@ test_bridge()
 	simple_if_init br0 $H2_IPV4/24 $H2_IPV6/64
 	macvlan_create br0
 
-	run_test $h1 br0 "vlan_filtering=$vlan_filtering bridge"
+	run_test $h1 br0 $no_unicast_flt "vlan_filtering=$vlan_filtering bridge"
 
 	macvlan_destroy
 	simple_if_fini br0 $H2_IPV4/24 $H2_IPV6/64
@@ -330,11 +339,17 @@ vlan_aware_bridge()
 
 test_vlan()
 {
+	local no_unicast_flt=true
+
+	if [ $(has_unicast_flt $h2) = yes ]; then
+		no_unicast_flt=false
+	fi
+
 	h1_vlan_create
 	h2_vlan_create
 	macvlan_create $h2.100
 
-	run_test $h1.100 $h2.100 "VLAN upper"
+	run_test $h1.100 $h2.100 $no_unicast_flt "VLAN upper"
 
 	macvlan_destroy
 	h2_vlan_destroy
@@ -343,14 +358,23 @@ test_vlan()
 
 vlan_over_bridged_port()
 {
+	local no_unicast_flt=true
 	local vlan_filtering=$1
 
+	# br_manage_promisc() will not force a single vlan_filtering port to
+	# promiscuous mode, so we should still expect unicast filtering to take
+	# place if the device can do it.
+	if [ $(has_unicast_flt $h2) = yes ] && [ $vlan_filtering = 1 ]; then
+		no_unicast_flt=false
+	fi
+
 	h1_vlan_create
 	h2_vlan_create
 	bridge_create $vlan_filtering
 	macvlan_create $h2.100
 
-	run_test $h1.100 $h2.100 "VLAN over vlan_filtering=$vlan_filtering bridged port"
+	run_test $h1.100 $h2.100 $no_unicast_flt \
+		"VLAN over vlan_filtering=$vlan_filtering bridged port"
 
 	macvlan_destroy
 	bridge_destroy
@@ -370,6 +394,7 @@ vlan_over_vlan_aware_bridged_port()
 
 vlan_over_bridge()
 {
+	local no_unicast_flt=true
 	local vlan_filtering=$1
 
 	h1_vlan_create
@@ -383,7 +408,8 @@ vlan_over_bridge()
 		bridge vlan add dev br0 vid 100 self
 	fi
 
-	run_test $h1.100 br0.100 "VLAN over vlan_filtering=$vlan_filtering bridge"
+	run_test $h1.100 br0.100 $no_unicast_flt \
+		"VLAN over vlan_filtering=$vlan_filtering bridge"
 
 	if [ $vlan_filtering = 1 ]; then
 		bridge vlan del dev br0 vid 100 self
-- 
2.34.1


