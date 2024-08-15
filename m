Return-Path: <linux-kselftest+bounces-15362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 547F9952696
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7AD41F23465
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C252A1C5;
	Thu, 15 Aug 2024 00:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jI/0FkL0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721CC1EB46;
	Thu, 15 Aug 2024 00:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680585; cv=fail; b=innWgJockgb584h8XGWCjTGqs3qzD1kc6TO5cYLQBjMaRUua+As7FBbz+C6sSYUL4ncBixT8j3iHUBjm1qqfuKFbj4RpcZseHl3GiZHIkfFWeVReUWedwSeYm3omlLGgiwP+DY9uQE7k3RpHZD+250HiR2jPvYnRVnYlqk47OAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680585; c=relaxed/simple;
	bh=qehDAs1pa8Q1SKGJqJDjCj4NerbOL3efC3syimLs3Cc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OM9BFQvMU9OZmrHKyBEWwrQp8MIL5K97zH4EPxdYV8JX1ulSHqDKFZRaBnvVtoCgCempvlCgOx8vp6GCW8SjgaGMGaLgXcSdd+ylHD+fJG/pw6SQ2SAQxsgPs8vYPOO2kQTdtxZF9D7F9RN/VbHVghikOcBlH4rT4Q/TTIJXpiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jI/0FkL0; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hegwgz6DbIFZ7KO4vvgmDftN5upw8q5CgS6iQoQohCpyeRGLF2a8OTpZcIUU5AA9obw5meSk8cYe4tfw5F+z05cx2kFfjdETIh9yx3Hf96rNqAXH9NuZNIdESFpNmaUpH8ebCVn8WanpS3OAAJItqKBvdX8UG0d8pCVC8oLWCbgHfAuPFCGdCEAiGoo3rWTMHEzhhnogGUQInr82Wi1q5TqrnZ5c/9n6C8uYEdERymrz3OxsD941rR7VmDSv2Y5Fu4cIszdJ6vtFIGtqSTH2jI0HJQkej4VDwF4S1Y6bg12Kq9GwHmeGTEIM20ol1G4UYnlXNq/LoI6qdvC2gjX1LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKTuxN3Nem7Ye7Mz87vdjHN6iUukj/i+kZNh0Ot9Vp0=;
 b=NrWDxuev1zBQP2x/Dv8E0yIxpNlvF6TXdLoX8uE8jtaTYudG1EnizfZEy0Eb44FmKsvqLVCqHNaKQhzwVdCQH4+DUlSFrrfIoBb9UPrldqJz4q0dVM0lD0oe/btTmeKR+GtxO5EfgW3EROCJhlztsHs79gM0XoykImsbcAvNXgPH1XsJvvCYHhOPG8w2IJcUR8ghIn27tOkpmVq7BZTY13uaz4IQ2uYJJIyaKFmNv6b0k8nbvkCmxMMighW0K/Ns8uj3lVVl4HYlLa939lDKQhtGyTFd0coDLfUtpVc0CpNjTFI5H1Ela3bpWQpE/E3vx6auN2UbfPbmyjPx2Rt0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKTuxN3Nem7Ye7Mz87vdjHN6iUukj/i+kZNh0Ot9Vp0=;
 b=jI/0FkL00uF3pXIBsRlryq8jwygdh5GPgqirJBYbBUoQpq8FM6C1nMdOIpZ/yL0aFGRYV31/SM2yVVCzDRn8VnmRhMYkCs1TGr31DjGOw0B6szL5KcayeodPykWD/NWYSm7zeyE7g4BWfHu7jJZKTdzM7T1S+5kPIm3OwSxsFD66JdnxDUFScKrB3INwrilNgBEuPL4r9cAw5frAUXwrAanCBt/Eqf3bdI6q8+E3HHcK54kiEVxSlQTNQtBiI0Y4dgVyESqAuNcoFG+baoix7D3f1cwKS/h4WoM1bKfLjGFkWq4pftbejKXoZqQ2mznR5/AO1yQsyFXn4wS5RGLLKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10285.eurprd04.prod.outlook.com (2603:10a6:800:21e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 00:09:38 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 00:09:38 +0000
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
Subject: [PATCH net 07/14] selftests: net: local_termination: add PTP frames to the mix
Date: Thu, 15 Aug 2024 03:07:00 +0300
Message-Id: <20240815000707.2006121-8-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a1c38934-b1e1-4fe4-cfbe-08dcbcbe8d6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v9qIFWOPuGETpKa4UAAVISsdG5d/cKOEBH0UmsBw5k/qo32k8sDhSIHOHg+H?=
 =?us-ascii?Q?hz1TtRjp9xcUDl0x88MKIwFQ+AmfihokF9uwGei6hXQmBsEC1NR6/E5zBfoQ?=
 =?us-ascii?Q?AzzkoN6cZ+XZcX63j20ssLmtrfk/o+VxtVLPWuSN+D9KDsc7s59QzjV7uNcR?=
 =?us-ascii?Q?kacJPLF8tWz0vl6aj4kpFPZ+1+4S8PpDjdff0Hvga3ATITGMSOytEi6JhLbU?=
 =?us-ascii?Q?SJeQRKnSzOwxBYvE5Xgd3OYz32SrTJxwqU11FgcKcEv5SWhMA70uC7GJdLhK?=
 =?us-ascii?Q?UhtTNvazyijsvp3OkLEL4IYvJyub3GM7txyqAEXXlHWVWd+SowL3BLsZadob?=
 =?us-ascii?Q?4ku8/A5RzrlPubOFDPoMoVgLjeLELLoJ9fT7E47tXEHhZNlq8FHu4b5mR1QO?=
 =?us-ascii?Q?4ITEzr4Ofq0K0HO5a38WTWzUEjxwPmcpOdBsGFFN4Vo+hJumPUV/UL6t0uSy?=
 =?us-ascii?Q?59ZuJP9YJ8RjyZeGPXFcTY3qik3KCMVewKvG8iTkOk5FRyQJPSc7RPm2sdRd?=
 =?us-ascii?Q?Q5+rLFKqSHcGpT4QGhEInlgb5T6Ms8bfpjiFZwhYOg/kMBkLIhi+NXO+fpwi?=
 =?us-ascii?Q?05/p/F2TtnGyNZI8I7KmmDT7X8pENEDQJV6RNJveylOVHxmFJ564CNGnZvms?=
 =?us-ascii?Q?eo+8IuGEjQRX49Zk1osn3KrHwn7krHZefpkYkrgzN2KVDttv2tApkKjPkcaa?=
 =?us-ascii?Q?aDbs579RDO+9Q9huLUGq4cDpggVIaVWtYRCtDSRfC6Z0oSuwhfWIH9iuMU07?=
 =?us-ascii?Q?5CdSED+L3lkrzn6QkKJB9ARJoM/om6rEJqoDXoHCrVKK4MQT3Qk9shOjkBeD?=
 =?us-ascii?Q?NN5iNHfqj4o1ga0ULZArZeqopE/XtRTquMgWqBmX3Sl1a5SQNenhI9l+qkzw?=
 =?us-ascii?Q?eTG19v2fEoThoRLqLLTYgglo0igTzsGc82rFc5snq0olsqsoznxjSK7KYeIF?=
 =?us-ascii?Q?U1SYftjTzgKxJPkRhSvzgViH7Po/UtSk89cJvy/0Ha1H+RxlE+plFhfkrcn8?=
 =?us-ascii?Q?DYaZNdP/xHVM5Y/Gp5EJpSrabdavjtxulbqjY50R7WYfNKzAlcNNCG37jha8?=
 =?us-ascii?Q?HZdweZx6Ruwn7vtHM2tRjTR6TtpIbqnI0kYYteubP9rC7YNIMc7QrAeB//ks?=
 =?us-ascii?Q?Jb85lhiIp0+/Q+ws8vREDEdqB/GgS64XLa/k/izcPonoK1gthO/hRT2qTaI+?=
 =?us-ascii?Q?F0jU4h24Ix2Rz9nBbhFOyKAtCGDjbUwVARFVMDkhsF5+LrNw621EAG+XlT++?=
 =?us-ascii?Q?LkUdmXRSiCMF73P0oF7nCsj0xt1A980e97pJuoGORaQjkA2Fy8i5k6VQGiJ8?=
 =?us-ascii?Q?qU323xh2DSTdeNy97Ah8c8dOdpqF75lPrPG1VocmrCotuuANSatBuZuBogy4?=
 =?us-ascii?Q?jWcU8FXsN0s1mHvLSBWJ9+TBpljpzF8JXm3A5VVNhMOHcpkjOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?27uTxV3KT1x9FFLY+e/Qkey6TaYacF0pOsdwOjPG+Ne/pt012qzu4ddsD86v?=
 =?us-ascii?Q?Eqa0/Q00AOQLkyO07HTeNDbCu/qk1EGoTGsU5zNcvcwcJg3D3OgTPtqvgfjp?=
 =?us-ascii?Q?4wf9XLEqI8wuhS3pPuEToZZKJCqOgnYwcpqreGx9qy6sfKnknVi6xjF0ziU6?=
 =?us-ascii?Q?ScQBWjxjy87OYIiHTsgPJT5dHVYpulbkteYeGE7boA5BYmxQPQKHI8RlHm4c?=
 =?us-ascii?Q?WdKw7GfGlGKPfv/vYw7qH89TqvtqM613Z8pBajpFhP6kN2n1oq0K9oWnyT0w?=
 =?us-ascii?Q?Hf59aBfolZlMDssPSXGf43MCw+HOxNCjQjm9bzk+SARo/cOWeJQXEHLwx84G?=
 =?us-ascii?Q?yprIi0Ck/3oliL1MJVOllQX59Mwa4NdSGyTn+KVpxoy01zIML/1KLND46is7?=
 =?us-ascii?Q?yrJAPo+3At9B9G596n/RuMg8Bk2gZJZNRC/hOX260vo4j52hLEQkuljA54kV?=
 =?us-ascii?Q?HQS9H35bBkyzXaXeY0QfZB896dOXjhbb330iBD1n+C55vjStMihvjkQiQJnF?=
 =?us-ascii?Q?6iPb7va3PqIqnKs0uFWbr+lVsjYOx4pyt3yuG9FfBJ2JwMSN8ZGEcAOb+maV?=
 =?us-ascii?Q?COtaHEJPZ6JiZlXEkVdmzWrr7WOHySkWFOgerkxz45qdrbU1J33hpEQfiTdf?=
 =?us-ascii?Q?Lo6SVN+7nIQZu4djth0K5XvKKRsqbN1Z+IXIUIOc8+3cJhujNZUyfXDeoYnW?=
 =?us-ascii?Q?+1LQMzg3PC+zMPgig0zFFIXFmEzLSrWYLNnmw82TVN8Jsw9rnctFPwf7Vt7J?=
 =?us-ascii?Q?0YJ2t5lH0oLqgNBAOLjNWnIzU2q1d17lfrGjzyHuG2fQtukGbk1EkVVS6cQe?=
 =?us-ascii?Q?JHuH1W6L1OC7zXxG/QAVVvoIU1kT24alIk2L92cztwQvNnh9RNy223EQ/d9s?=
 =?us-ascii?Q?iN8jvSZFmgR8A77P6lFbK8V/Cdmf2FQAzz/EEvVu7nUZT2YERHh8y9h3CYiI?=
 =?us-ascii?Q?M+xC9UDvgsbaW9ISnNTKKgxaBza1gd9TJ//66X1SahRli24y37xOE2gbnt0u?=
 =?us-ascii?Q?/xw3UFA5nTIvNE4eEe1Pl196JMNwtuVxVPZs9VMxBWamuXu7wdx8hcM9D9g5?=
 =?us-ascii?Q?DlxZta6NqD+IwOQQ7sqPw8dN2BfKGbnSXRdrgNWIGyyRGHo4MJowbc+1TAD9?=
 =?us-ascii?Q?OpfMqtOn5Kd5WfLpe+J7b3rEldqe60Y53MTwFW9pARv96SHPoJHj3W6r5Skd?=
 =?us-ascii?Q?l0Rgvdj4sfR9uYWB6sHNGVRTfX4KncbJTB9JjIOLdiOBfBvwsOTBpivfQH0e?=
 =?us-ascii?Q?MQ0AWGTx+ULBbPYUzUKUSvdAH9m5mF5ffjt9lMD32OBDGKXiTg3GteJ+Wiv5?=
 =?us-ascii?Q?Z/boKnzSIRbtDQfAZPnmjrBx//CnBsovTBzmFn/hLk2jsPF8P2HJZ60Xlqwv?=
 =?us-ascii?Q?rgfSaMFGUkUA/5c+AxvwAhM2xtGk6c7L/bLZjt53BKvpEKodsBNVQOm+jkLa?=
 =?us-ascii?Q?oKNKgxIfi5/7yrdBpzuxItUXg+eEZr0YwxYOQtigVtS1YmZdUXMOkLzmAFT8?=
 =?us-ascii?Q?MJp/xtTiF/4234IoCStt1mg9h5JvjPfHREGhaywJVF4y4EfWFGOe45wFode5?=
 =?us-ascii?Q?UkNPWZaYVS99TS3sk99/c5iebTJdzWTEMWfEXHpPUfsc2IEOow6WEzDYZh1i?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c38934-b1e1-4fe4-cfbe-08dcbcbe8d6c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:09:38.3598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gks7L81D+Cr26x6nGXdssw3iM0tTOZD7Erj2uMBFAw0DgOhTBKatIZhvmHLfz82/LeTX5myfQ2eIwh1QbO0eAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10285

A breakage in the felix DSA driver shows we do not have enough test
coverage. More generally, it is sufficiently special that it is likely
drivers will treat it differently.

This is not meant to be a full PTP test, it just makes sure that PTP
packets sent to the different addresses corresponding to their profiles
are received correctly. The local_termination selftest seemed like the
most appropriate place for this addition.

PTP RX/TX in some cases makes no sense (over a bridge) and this is why
$skip_ptp exists. And in others - PTP over a bridge port - the IP stack
needs convincing through the available bridge netfilter hooks to leave
the PTP packets alone and not stolen by the bridge rx_handler. It is
safe to assume that users have that figured out already. This is a
driver level test, and by using tcpdump, all that extra setup is out of
scope here.

send_non_ip() was an unfinished idea; written but never used.
Replace it with a more generic send_raw(), and send 3 PTP packet types
times 3 transports.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../net/forwarding/local_termination.sh       | 161 ++++++++++++++++--
 1 file changed, 148 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
index 80ea4c10d764..648868f74604 100755
--- a/tools/testing/selftests/net/forwarding/local_termination.sh
+++ b/tools/testing/selftests/net/forwarding/local_termination.sh
@@ -39,9 +39,68 @@ UNKNOWN_MACV6_MC_ADDR1="33:33:01:02:03:05"
 UNKNOWN_MACV6_MC_ADDR2="33:33:01:02:03:06"
 UNKNOWN_MACV6_MC_ADDR3="33:33:01:02:03:07"
 
-NON_IP_MC="01:02:03:04:05:06"
-NON_IP_PKT="00:04 48:45:4c:4f"
-BC="ff:ff:ff:ff:ff:ff"
+PTP_1588_L2_SYNC=" \
+01:1b:19:00:00:00 00:00:de:ad:be:ef 88:f7 00 02 \
+00 2c 00 00 02 00 00 00 00 00 00 00 00 00 00 00 \
+00 00 3e 37 63 ff fe cf 17 0e 00 01 00 00 00 00 \
+00 00 00 00 00 00 00 00 00 00"
+PTP_1588_L2_FOLLOW_UP=" \
+01:1b:19:00:00:00 00:00:de:ad:be:ef 88:f7 08 02 \
+00 2c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 \
+00 00 3e 37 63 ff fe cf 17 0e 00 01 00 00 02 00 \
+00 00 66 83 c5 f1 17 97 ed f0"
+PTP_1588_L2_PDELAY_REQ=" \
+01:80:c2:00:00:0e 00:00:de:ad:be:ef 88:f7 02 02 \
+00 36 00 00 00 00 00 00 00 00 00 00 00 00 00 00 \
+00 00 3e 37 63 ff fe cf 17 0e 00 01 00 06 05 7f \
+00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 \
+00 00 00 00"
+PTP_1588_IPV4_SYNC=" \
+01:00:5e:00:01:81 00:00:de:ad:be:ef 08:00 45 00 \
+00 48 0a 9a 40 00 01 11 cb 88 c0 00 02 01 e0 00 \
+01 81 01 3f 01 3f 00 34 a3 c8 00 02 00 2c 00 00 \
+02 00 00 00 00 00 00 00 00 00 00 00 00 00 3e 37 \
+63 ff fe cf 17 0e 00 01 00 00 00 00 00 00 00 00 \
+00 00 00 00 00 00"
+PTP_1588_IPV4_FOLLOW_UP="
+01:00:5e:00:01:81 00:00:de:ad:be:ef 08:00 45 00 \
+00 48 0a 9b 40 00 01 11 cb 87 c0 00 02 01 e0 00 \
+01 81 01 40 01 40 00 34 a3 c8 08 02 00 2c 00 00 \
+00 00 00 00 00 00 00 00 00 00 00 00 00 00 3e 37 \
+63 ff fe cf 17 0e 00 01 00 00 02 00 00 00 66 83 \
+c6 0f 1d 9a 61 87"
+PTP_1588_IPV4_PDELAY_REQ=" \
+01:00:5e:00:00:6b 00:00:de:ad:be:ef 08:00 45 00 \
+00 52 35 a9 40 00 01 11 a1 85 c0 00 02 01 e0 00 \
+00 6b 01 3f 01 3f 00 3e a2 bc 02 02 00 36 00 00 \
+00 00 00 00 00 00 00 00 00 00 00 00 00 00 3e 37 \
+63 ff fe cf 17 0e 00 01 00 01 05 7f 00 00 00 00 \
+00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00"
+PTP_1588_IPV6_SYNC=" \
+33:33:00:00:01:81 00:00:de:ad:be:ef 86:dd 60 06 \
+7c 2f 00 36 11 01 20 01 0d b8 00 01 00 00 00 00 \
+00 00 00 00 00 01 ff 0e 00 00 00 00 00 00 00 00 \
+00 00 00 00 01 81 01 3f 01 3f 00 36 2e 92 00 02 \
+00 2c 00 00 02 00 00 00 00 00 00 00 00 00 00 00 \
+00 00 3e 37 63 ff fe cf 17 0e 00 01 00 00 00 00 \
+00 00 00 00 00 00 00 00 00 00 00 00"
+PTP_1588_IPV6_FOLLOW_UP=" \
+33:33:00:00:01:81 00:00:de:ad:be:ef 86:dd 60 0a \
+00 bc 00 36 11 01 20 01 0d b8 00 01 00 00 00 00 \
+00 00 00 00 00 01 ff 0e 00 00 00 00 00 00 00 00 \
+00 00 00 00 01 81 01 40 01 40 00 36 2e 92 08 02 \
+00 2c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 \
+00 00 3e 37 63 ff fe cf 17 0e 00 01 00 00 02 00 \
+00 00 66 83 c6 2a 32 09 bd 74 00 00"
+PTP_1588_IPV6_PDELAY_REQ=" \
+33:33:00:00:00:6b 00:00:de:ad:be:ef 86:dd 60 0c \
+5c fd 00 40 11 01 fe 80 00 00 00 00 00 00 3c 37 \
+63 ff fe cf 17 0e ff 02 00 00 00 00 00 00 00 00 \
+00 00 00 00 00 6b 01 3f 01 3f 00 40 b4 54 02 02 \
+00 36 00 00 00 00 00 00 00 00 00 00 00 00 00 00 \
+00 00 3e 37 63 ff fe cf 17 0e 00 01 00 01 05 7f \
+00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 \
+00 00 00 00 00 00"
 
 # Disable promisc to ensure we don't receive unknown MAC DA packets
 export TCPDUMP_EXTRA_FLAGS="-pl"
@@ -49,13 +108,15 @@ export TCPDUMP_EXTRA_FLAGS="-pl"
 h1=${NETIFS[p1]}
 h2=${NETIFS[p2]}
 
-send_non_ip()
+send_raw()
 {
-	local if_name=$1
-	local smac=$2
-	local dmac=$3
+	local if_name=$1; shift
+	local pkt="$1"; shift
+	local smac=$(mac_get $if_name)
 
-	$MZ -q $if_name "$dmac $smac $NON_IP_PKT"
+	pkt="${pkt/00:00:de:ad:be:ef/$smac}"
+
+	$MZ -q $if_name "$pkt"
 }
 
 send_uc_ipv4()
@@ -109,6 +170,7 @@ run_test()
 {
 	local send_if_name=$1; shift
 	local rcv_if_name=$1; shift
+	local skip_ptp=$1; shift
 	local no_unicast_flt=$1; shift
 	local test_name="$1"; shift
 	local smac=$(mac_get $send_if_name)
@@ -150,6 +212,35 @@ run_test()
 	mc_route_destroy $rcv_if_name
 	mc_route_destroy $send_if_name
 
+	if [ $skip_ptp = false ]; then
+		ip maddress add 01:1b:19:00:00:00 dev $rcv_if_name
+		send_raw $send_if_name "$PTP_1588_L2_SYNC"
+		send_raw $send_if_name "$PTP_1588_L2_FOLLOW_UP"
+		ip maddress del 01:1b:19:00:00:00 dev $rcv_if_name
+
+		ip maddress add 01:80:c2:00:00:0e dev $rcv_if_name
+		send_raw $send_if_name "$PTP_1588_L2_PDELAY_REQ"
+		ip maddress del 01:80:c2:00:00:0e dev $rcv_if_name
+
+		mc_join $rcv_if_name 224.0.1.129
+		send_raw $send_if_name "$PTP_1588_IPV4_SYNC"
+		send_raw $send_if_name "$PTP_1588_IPV4_FOLLOW_UP"
+		mc_leave
+
+		mc_join $rcv_if_name 224.0.0.107
+		send_raw $send_if_name "$PTP_1588_IPV4_PDELAY_REQ"
+		mc_leave
+
+		mc_join $rcv_if_name ff0e::181
+		send_raw $send_if_name "$PTP_1588_IPV6_SYNC"
+		send_raw $send_if_name "$PTP_1588_IPV6_FOLLOW_UP"
+		mc_leave
+
+		mc_join $rcv_if_name ff02::6b
+		send_raw $send_if_name "$PTP_1588_IPV6_PDELAY_REQ"
+		mc_leave
+	fi
+
 	sleep 1
 
 	tcpdump_stop $rcv_if_name
@@ -212,6 +303,44 @@ run_test()
 		"$smac > $UNKNOWN_MACV6_MC_ADDR3, ethertype IPv6 (0x86dd)" \
 		true "$test_name"
 
+	if [ $skip_ptp = false ]; then
+		check_rcv $rcv_if_name "1588v2 over L2 transport, Sync" \
+			"ethertype PTP (0x88f7).* PTPv2.* msg type : sync msg" \
+			true "$test_name"
+
+		check_rcv $rcv_if_name "1588v2 over L2 transport, Follow-Up" \
+			"ethertype PTP (0x88f7).* PTPv2.* msg type : follow up msg" \
+			true "$test_name"
+
+		check_rcv $rcv_if_name "1588v2 over L2 transport, Peer Delay Request" \
+			"ethertype PTP (0x88f7).* PTPv2.* msg type : peer delay req msg" \
+			true "$test_name"
+
+		check_rcv $rcv_if_name "1588v2 over IPv4, Sync" \
+			"ethertype IPv4 (0x0800).* PTPv2.* msg type : sync msg" \
+			true "$test_name"
+
+		check_rcv $rcv_if_name "1588v2 over IPv4, Follow-Up" \
+			"ethertype IPv4 (0x0800).* PTPv2.* msg type : follow up msg" \
+			true "$test_name"
+
+		check_rcv $rcv_if_name "1588v2 over IPv4, Peer Delay Request" \
+			"ethertype IPv4 (0x0800).* PTPv2.* msg type : peer delay req msg" \
+			true "$test_name"
+
+		check_rcv $rcv_if_name "1588v2 over IPv6, Sync" \
+			"ethertype IPv6 (0x86dd).* PTPv2.* msg type : sync msg" \
+			true "$test_name"
+
+		check_rcv $rcv_if_name "1588v2 over IPv6, Follow-Up" \
+			"ethertype IPv6 (0x86dd).* PTPv2.* msg type : follow up msg" \
+			true "$test_name"
+
+		check_rcv $rcv_if_name "1588v2 over IPv6, Peer Delay Request" \
+			"ethertype IPv6 (0x86dd).* PTPv2.* msg type : peer delay req msg" \
+			true "$test_name"
+	fi
+
 	tcpdump_cleanup $rcv_if_name
 }
 
@@ -293,6 +422,7 @@ macvlan_destroy()
 standalone()
 {
 	local no_unicast_flt=true
+	local skip_ptp=false
 
 	if [ $(has_unicast_flt $h2) = yes ]; then
 		no_unicast_flt=false
@@ -302,7 +432,7 @@ standalone()
 	h2_create
 	macvlan_create $h2
 
-	run_test $h1 $h2 $no_unicast_flt "$h2"
+	run_test $h1 $h2 $skip_ptp $no_unicast_flt "$h2"
 
 	macvlan_destroy
 	h2_destroy
@@ -313,13 +443,15 @@ test_bridge()
 {
 	local no_unicast_flt=true
 	local vlan_filtering=$1
+	local skip_ptp=true
 
 	h1_create
 	bridge_create $vlan_filtering
 	simple_if_init br0 $H2_IPV4/24 $H2_IPV6/64
 	macvlan_create br0
 
-	run_test $h1 br0 $no_unicast_flt "vlan_filtering=$vlan_filtering bridge"
+	run_test $h1 br0 $skip_ptp $no_unicast_flt \
+		"vlan_filtering=$vlan_filtering bridge"
 
 	macvlan_destroy
 	simple_if_fini br0 $H2_IPV4/24 $H2_IPV6/64
@@ -340,6 +472,7 @@ vlan_aware_bridge()
 test_vlan()
 {
 	local no_unicast_flt=true
+	local skip_ptp=false
 
 	if [ $(has_unicast_flt $h2) = yes ]; then
 		no_unicast_flt=false
@@ -349,7 +482,7 @@ test_vlan()
 	h2_vlan_create
 	macvlan_create $h2.100
 
-	run_test $h1.100 $h2.100 $no_unicast_flt "VLAN upper"
+	run_test $h1.100 $h2.100 $skip_ptp $no_unicast_flt "VLAN upper"
 
 	macvlan_destroy
 	h2_vlan_destroy
@@ -360,6 +493,7 @@ vlan_over_bridged_port()
 {
 	local no_unicast_flt=true
 	local vlan_filtering=$1
+	local skip_ptp=false
 
 	# br_manage_promisc() will not force a single vlan_filtering port to
 	# promiscuous mode, so we should still expect unicast filtering to take
@@ -373,7 +507,7 @@ vlan_over_bridged_port()
 	bridge_create $vlan_filtering
 	macvlan_create $h2.100
 
-	run_test $h1.100 $h2.100 $no_unicast_flt \
+	run_test $h1.100 $h2.100 $skip_ptp $no_unicast_flt \
 		"VLAN over vlan_filtering=$vlan_filtering bridged port"
 
 	macvlan_destroy
@@ -396,6 +530,7 @@ vlan_over_bridge()
 {
 	local no_unicast_flt=true
 	local vlan_filtering=$1
+	local skip_ptp=true
 
 	h1_vlan_create
 	bridge_create $vlan_filtering
@@ -408,7 +543,7 @@ vlan_over_bridge()
 		bridge vlan add dev br0 vid 100 self
 	fi
 
-	run_test $h1.100 br0.100 $no_unicast_flt \
+	run_test $h1.100 br0.100 $skip_ptp $no_unicast_flt \
 		"VLAN over vlan_filtering=$vlan_filtering bridge"
 
 	if [ $vlan_filtering = 1 ]; then
-- 
2.34.1


