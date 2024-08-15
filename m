Return-Path: <linux-kselftest+bounces-15368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 314589526AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75F12B22C11
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931D853362;
	Thu, 15 Aug 2024 00:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PlY6gL9L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D81847A66;
	Thu, 15 Aug 2024 00:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680600; cv=fail; b=EJdR/bqQ0YPLGnGABCeAHtHrkaiB1koPOL9B3Lxo8PpQes+9Tk+nWiJwYpmyyYFAmZQX0E6wJEe1aqVIzX77dyllwaoIP+Cf1+EmQkcYe8DF5d/RwMaR47sawM4kVQdKmvy00M5kkqELWkvNAWjftkXSTn2d0anhXnnHe7w0Ipc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680600; c=relaxed/simple;
	bh=gFF/32PFqq7ox3Pfmb1RYJpRHUxx1+OLIwbaEMzl+Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OWqCEgCRtDxEZiIBe1qTJI+zXZjJWK0xR/YiePovIyCe4uFR4UCUAdVmLAjdFEAVfWBYrCsMIoKa41JHKHRFko/zvyKSFEHtSFVbyWEYTrz5yN7Ll2Kq7A8hQ6PFjkw6UhV5vQlGNcw1W4GU9tY2itPV91QJp0MIKj6AFDag4+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PlY6gL9L; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNVx9ka1QypNb1oBVoXe10GzCcxsgkiPar/fL6NYeDN7GN4FJc9bHfIPxRJ1TyKvS+3lA8C/NXyGFjR9X3e1qmUo+WCfW9kNYw0JlAIO+noYaPoLyVDDP8a9hbbh/Ko2GZx30KAdPI1+xU9Zvy4Irj0FApDBysSG7+6SXZrCK43+sKDWCcoZAn+9YnKZGWScxSAHiPx6A1pFPLlfaQ4ypFHAnpAKGkopO0vn4GCh9aCXjlm4lJMj/93EYixRFVCVU8JDr+WGQvkvul3Zu2UrGDzTOjAixaEbt6nOujpbyWHbej5TJuHNPgH6YJMast6nuo1yQoBrK0qo5Uxc1uJAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCcgThH71i8kjAzpmGAIeoNjeTwQBNzNOh84iWzZGSA=;
 b=AKr5aTZ08ENdz0vnHCf45EP1mGjLnCQaWEdIBfqy94doYMLoOWdLK+UgrR7aT17Amir1Fh0kwSty232doYdUIHISM/Oc/MruJyG+U5Fpeb/yQH4EgaH30yRhD/eRkT8nB5ZOgaAOCA1SquL+6gGYin3941keiNaiM9mexWmL3Ck1a2wNTqItyU6otT4rhVmxXEmaQ6WmkEQRokMAlUxydI+4D7mYFhOL7iHpql/KKiFSk/3YJWsJQ86JQaYazp9Gm7pgOIZEtQJJH0SxrvkF61eRZYwfoaOFosplh11zrbP8DKGAgLnbWE48r8jirhx1a5eokfimnm92ILrsUQUwEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCcgThH71i8kjAzpmGAIeoNjeTwQBNzNOh84iWzZGSA=;
 b=PlY6gL9LK3GeAqEuv9w9JbChaVqYn6MYnZT5tkugFTn7qyvBg6W/T/+8VfA5Cp9kyBaVhGbo3Yz1VVHiikqhwjRJCK0M/xzWzbYyQThiGP9lr9InSJq8Cuzq4Ic8syKFVkVYY0IlmfDD+TCr6rllKKMXUIIDkDBbpNGKZYigOrV2he/TWoAa3K76FS/V3eM4DnibGRyWLLtWRj4No/CPlSqZ8lJUL5mx+mmFKVqJ4qH9oLekfeLMciNeG6HSCjePFgKhaANqDA65MaaEnCsjazIdh4dGwYk7JaCTdSN/fI2IpRrctUlnxz+sBMi7hx+5AfhlB2La8wZEY0aHd4BHqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10285.eurprd04.prod.outlook.com (2603:10a6:800:21e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 00:09:52 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 00:09:52 +0000
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
Subject: [PATCH net 13/14] net: dsa: felix: fix VLAN tag loss on CPU reception with ocelot-8021q
Date: Thu, 15 Aug 2024 03:07:06 +0300
Message-Id: <20240815000707.2006121-14-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0a7d7ed3-60e4-4eb9-b375-08dcbcbe95e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p3YpmzZlvGM/oWcpZnfxkOXsBEU7lf8tCFyY11zs9o9GFZ/LXEFfoiD+uQfA?=
 =?us-ascii?Q?cswnZgX16TZzR9lEZyr09nxhE5yarvs/fBMk2YpWEGH/dJRFLHz0Ejs+nPmL?=
 =?us-ascii?Q?xFM5/2PInzwJ1HtvnhN90I8+DPguB/V+ugZ8C2GRx2y9YIh/4OGgsXAucIe0?=
 =?us-ascii?Q?o0w5rDJTpwnKpE5LKeK4kgni/W9PJejwA0KoZ3pj1LEwtDjvJzYRw9Mcfk6m?=
 =?us-ascii?Q?wefz5mtr1bxAicX3Ub6uyXmJQJgXBMVWb+YIrJAZ4wmrItskMuZMitqoP9PL?=
 =?us-ascii?Q?NRleNQPQp/RxT9IlXoV3xXGMdVDTN6OfytM7HXYhW1b0LKIWNXWn0Z+7T0c0?=
 =?us-ascii?Q?RGWMNQ8t+147P9L2ywgtP2uof/Q3JtIvEEaWuv50wWsNnwC15MkJUBDGKORO?=
 =?us-ascii?Q?m98OrQx7hPrRVgXKJtVohKYnbL6uj1nCHFOfWi421EiLUWlgFdpZPaT3jKCo?=
 =?us-ascii?Q?wG0fnnIdkAmtNLbvJN2xtydY/nfyRCKImELXeGCm5ertmFM8itCBGaEyO0fa?=
 =?us-ascii?Q?EqMWjZvwJg+cxJAe3FgtYiz0xdhu2s9OO8Df7WtqUKFmXt4l5P73uQi21Y/p?=
 =?us-ascii?Q?wCBqJSgV5WFhzYrelA9ke3ovV8GZLm+k6CtdeIh2F1Q0JYKaGGMxmV13145B?=
 =?us-ascii?Q?dyt6e19aVYq41hQuRsv8KnJ8tIJPCJMvXjbuaEtP1ZgFyynFfi/sgyUIuBCI?=
 =?us-ascii?Q?ADoKuakvFEpaDJYjZOoMtpl755mBWFcIfFBZg43kHzJDm6L3L4paSf4pn+wh?=
 =?us-ascii?Q?0mbd+duhzNxIaRPPSCqX/bqkZzXEvFR9qk7H/c4R2eGHoUoh+P60P4DHfFsX?=
 =?us-ascii?Q?+f81VxJGQR/SAyQI9iLi41tiwLiX3WwULreQ2n5DYijnkuYWkDYLqDS0RkDy?=
 =?us-ascii?Q?yNnkRNM+9j0QdyaXE/g1rIdGddAiDfZuEp0hsYlN/0kmh7/LGiJJlfnA+2ZQ?=
 =?us-ascii?Q?RpenVUZICMk8/asmKa2vKMMtyoXPfKNNdbrrdHiL8ZytX6gVuNEbpmPqqKYN?=
 =?us-ascii?Q?h+uicM3vcsYoDbg8ueLJg2HZ2M4vlf7Vy8grB9JC31pwQf3liF7/txHjM1Np?=
 =?us-ascii?Q?WoQpgb9WybJQJeYSDxv5W4E1yl0guRpdyvciT+59kuuUYJK/bHu8XFV9E+GW?=
 =?us-ascii?Q?dvUDasRh3O3ACkklkKvrfnUyUwTFT75c0/3RFc1AX0grwx1XJFswGruCu6Lp?=
 =?us-ascii?Q?Rnj0jGIP9ZEhdkJSjvhq17uJrjsixd4lI+w7PZQyRwzSDrySnhV36ngiuUj9?=
 =?us-ascii?Q?dA4AswCOKp72lUlkSEKrNGo8ge1Hy0feRlafahmUwcgW0SQd3zXLQ8m9BHgx?=
 =?us-ascii?Q?9m+CojULLtPclh4FDBMVrX/lR5BGYZuz8fvY1aWujAYW27KCYxxa66cgNxvM?=
 =?us-ascii?Q?8ivjNqZWfWUT9Uo0VFACYLxI6cq4JJ+SOqgMOz2BGbwDRlQMDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s/qyxBMe1JeV83JgXti8yQb40b6nPGJ/Rimmr8uDk3aT5HgZNdKcQJST5tzd?=
 =?us-ascii?Q?V98BPPQ70vl2nhlsbYf6K7RP9Y75hgkxgCg+AQe+NG22W/0hXb/XDJCiQq3v?=
 =?us-ascii?Q?3f8SYV762GBJPB7Fr7c5w2beKT1uu6oI0ew3NmK6ZNdLVLmmBX7Hn39c5hS5?=
 =?us-ascii?Q?wlJuq5KcuBEDmKk8Xl3O6ky3DKUg45YG7z1bUW1MGz/21ULj0Z2KWsXapSuF?=
 =?us-ascii?Q?JdDexkquohOuB3nPnegJLdQLwlZGn57NQYCiLFWP9yhz9z/oPZU3JudYL7Dr?=
 =?us-ascii?Q?IQ2i7HHrlbKY0zcPJxI4V+sdvXqJMMeuNtpgIKCHhtEKXNouRkSOMPxcCN3c?=
 =?us-ascii?Q?Fw2ePIVwiTbmQl/63UoQupHjX05/YupLjHeUlZQ3T10NQvrZ5qA5BApR+Urp?=
 =?us-ascii?Q?ZlW4fPnBz8Bh8hqmEGIXwdZyC68F9zoPGEScvEWKyomofg/XoDxoz09zbxjr?=
 =?us-ascii?Q?RPRCkqGeAICNE4kNsa/9kA6W4z+SwnEyBSU+kU03H7XRj7V5PTAhZUs0jqgK?=
 =?us-ascii?Q?V6pIroYCy17ibTxFDibXapv4w7SCfTcGMqpdgq/fH35M02fprhL6Rni3H2Nf?=
 =?us-ascii?Q?0Pa8SUq8TNHKzOieNUOItLjL+HPz88nXNMNveOp/mVCylFuaECkSXht1zvEB?=
 =?us-ascii?Q?uANvOu0QQxyJ8pxMF7R+Vj8AiZ0tnSfFRctkLhVOxfV+bSPmEsR5iIFXmneo?=
 =?us-ascii?Q?6Oxehate2awAWATYTGAtX1QEkppaqa2+0Yy7RSAd14rEQ2o45iAn7muYbKmz?=
 =?us-ascii?Q?KVvV6KK1vodomYFA4ORHavLwSKTM08lXesQ30P3ybelsMIla9jJOHtTYbDZL?=
 =?us-ascii?Q?pSn2XL9aGxRzD/j0LHTU9+wgLjbO8Bqp3aHUIE8lhF8yRtMYv/4lodeGnU2A?=
 =?us-ascii?Q?4pYLDLpAdCS5cTPVoUEyoJBy6SyM+yuj4jaD0dvAUG9PyZG9NH5ocd7VXP+y?=
 =?us-ascii?Q?Tv476COl5jJgqC9G+wm6WZ+NjkHXXT8oOl51ykTuve95MRNkAojfLwt3P3sM?=
 =?us-ascii?Q?m4b6fOsPu4ceG0buiUsdeJ9ipXgLCDdyyi25zjZoNZxDeZcNo2wh8jsiw23w?=
 =?us-ascii?Q?5mnXu5kuYwv+CuZMFZeCBa3NeTLIAyYGFQ3x1AVLMbKQF6LOhaSjlf/aEr9s?=
 =?us-ascii?Q?OXygn73kbPkvrRNx9nJF7h4yTJ/q0/JIdhPoQAv9wsBxDdARuhpma3kDhDvI?=
 =?us-ascii?Q?NE29z6xaSt0NAqdnzHESbP2Ob49057fG+FE2b0u6InCIy/kMYQoFXYkZlas+?=
 =?us-ascii?Q?/MjfYxRuG47LSjz1wZoxOdU6pUC3lkhUkSaT2epcDY1dRR7VQ2VWnjJwjeVk?=
 =?us-ascii?Q?o1sT96X2rIwVZM2E/qhb0A01506JMDGOYFkmd5lrJV2DKhswEwTSdJirXad9?=
 =?us-ascii?Q?n0za+ZVyI9A6ypfe5jO70MJBfZBOSO7sUXtNTzkModtiI1rz7GqFyNhzTmKs?=
 =?us-ascii?Q?6Zdg5RTGxrtCiyTJWnJXLUP3AQExpF9GHdLYmfL5m9ZVzk5ZKkEWfamBNj9g?=
 =?us-ascii?Q?66KHkgTqy9cR3hDplrKz8zBHtxo90xItlXBMJtIwhZ18ugboZtn56rdRTa3k?=
 =?us-ascii?Q?esHzTG0nA0txj2Vzgqsz5CGN/xbXqcRwMkxbf8W2auDn4xGdm6LrqO0WUXlO?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7d7ed3-60e4-4eb9-b375-08dcbcbe95e4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:09:52.5819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwgGa2mNQ+JZo8zTLmXV2UgNYOm5DRDBfJmYD84R5Ce93BJf64St0ZTj8c9ikmINwZRZHmRZqaRbJyZ2StpRuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10285

There is a major design bug with ocelot-8021q, which is that it expects
more of the hardware than the hardware can actually do. The short
summary of the issue is that when a port is under a VLAN-aware bridge
and we use this tagging protocol, VLAN upper interfaces of this port do
not see RX traffic.

We use VCAP ES0 (egress rewriter) rules towards the tag_8021q CPU port
to encapsulate packets with an outer tag, later stripped by software,
that depends on the source user port. We do this so that packets can be
identified in ocelot_rcv(). To be precise, we create rules with
push_outer_tag = OCELOT_ES0_TAG and push_inner_tag = 0.

With this configuration, we expect the switch to keep the inner tag
configuration as found in the packet (if it was untagged on user port
ingress, keep it untagged, otherwise preserve the VLAN tag unmodified
as the inner tag towards the tag_8021q CPU port). But this is not what
happens.

Instead, table "Tagging Combinations" from the user manual suggests
that when the ES0 action is "PUSH_OUTER_TAG=1 and PUSH_INNER_TAG=0",
there will be "no inner tag". Experimentation further clarifies what
this means.

It appears that this "inner tag" which is not pushed into the packet on
its egress towards the CPU is none other than the classified VLAN.

When the ingress user port is standalone or under a VLAN-unaware bridge,
the classified VLAN is a discardable quantity: it is a fixed value - the
result of ocelot_vlan_unaware_pvid()'s configuration, and actually
independent of the VID from any 802.1Q header that may be in the frame.
It is actually preferable to discard the "inner tag" in this case.

The problem is when the ingress port is under a VLAN-aware bridge.
Then, the classified VLAN is taken from the frame's 802.1Q header, with
a fallback on the bridge port's PVID. It would be very good to not
discard the "inner tag" here, because if we do, we break communication
with any 8021q VLAN uppers that the port might have. These have a
processing path outside the bridge.

There seems to be nothing else we can do except to change the
configuration for VCAP ES0 rules, to actually push the inner VLAN into
the frame. There are 2 options for that, first is to push a fixed value
specified in the rule, and second is to push a fixed value, plus
(aka arithmetic +) the classified VLAN. We choose the second option,
and we select that fixed value as 0. Thus, what is pushed in the inner
tag is just the classified VLAN.

From there, we need to perform software untagging, in the receive path,
of stuff that was untagged on the wire.

Fixes: 7c83a7c539ab ("net: dsa: add a second tagger for Ocelot switches based on tag_8021q")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix.c | 115 +++++++++++++++++++++++++++++++--
 1 file changed, 109 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 8d31ff18c5c7..4a705f7333f4 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -61,11 +61,46 @@ static int felix_cpu_port_for_conduit(struct dsa_switch *ds,
 	return cpu_dp->index;
 }
 
+/**
+ * felix_update_tag_8021q_rx_rule - Update VCAP ES0 tag_8021q rule after
+ *				    vlan_filtering change
+ * @outer_tagging_rule: Pointer to VCAP filter on which the update is performed
+ * @vlan_filtering: Current bridge VLAN filtering setting
+ *
+ * Source port identification for tag_8021q is done using VCAP ES0 rules on the
+ * CPU port(s). The ES0 tag B (inner tag from the packet) can be configured as
+ * either:
+ * - push_inner_tag=0: the inner tag is never pushed into the frame
+ *		       (and we lose info about the classified VLAN). This is
+ *		       good when the classified VLAN is a discardable quantity
+ *		       for the software RX path: it is either set to
+ *		       OCELOT_STANDALONE_PVID, or to
+ *		       ocelot_vlan_unaware_pvid(bridge).
+ * - push_inner_tag=1: the inner tag is always pushed. This is good when the
+ *		       classified VLAN is not a discardable quantity (the port
+ *		       is under a VLAN-aware bridge, and software needs to
+ *		       continue processing the packet in the same VLAN as the
+ *		       hardware).
+ * The point is that what is good for a VLAN-unaware port is not good for a
+ * VLAN-aware port, and vice versa. Thus, the RX tagging rules must be kept in
+ * sync with the VLAN filtering state of the port.
+ */
+static void
+felix_update_tag_8021q_rx_rule(struct ocelot_vcap_filter *outer_tagging_rule,
+			       bool vlan_filtering)
+{
+	if (vlan_filtering)
+		outer_tagging_rule->action.push_inner_tag = OCELOT_ES0_TAG;
+	else
+		outer_tagging_rule->action.push_inner_tag = OCELOT_NO_ES0_TAG;
+}
+
 /* Set up VCAP ES0 rules for pushing a tag_8021q VLAN towards the CPU such that
  * the tagger can perform RX source port identification.
  */
 static int felix_tag_8021q_vlan_add_rx(struct dsa_switch *ds, int port,
-				       int upstream, u16 vid)
+				       int upstream, u16 vid,
+				       bool vlan_filtering)
 {
 	struct ocelot_vcap_filter *outer_tagging_rule;
 	struct ocelot *ocelot = ds->priv;
@@ -96,6 +131,14 @@ static int felix_tag_8021q_vlan_add_rx(struct dsa_switch *ds, int port,
 	outer_tagging_rule->action.tag_a_tpid_sel = OCELOT_TAG_TPID_SEL_8021AD;
 	outer_tagging_rule->action.tag_a_vid_sel = 1;
 	outer_tagging_rule->action.vid_a_val = vid;
+	felix_update_tag_8021q_rx_rule(outer_tagging_rule, vlan_filtering);
+	outer_tagging_rule->action.tag_b_tpid_sel = OCELOT_TAG_TPID_SEL_8021Q;
+	/* Leave TAG_B_VID_SEL at 0 (Classified VID + VID_B_VAL). Since we also
+	 * leave VID_B_VAL at 0, this makes ES0 tag B (the inner tag) equal to
+	 * the classified VID, which we need to see in the DSA tagger's receive
+	 * path. Note: the inner tag is only visible in the packet when pushed
+	 * (push_inner_tag == OCELOT_ES0_TAG).
+	 */
 
 	err = ocelot_vcap_filter_add(ocelot, outer_tagging_rule, NULL);
 	if (err)
@@ -227,6 +270,7 @@ static int felix_tag_8021q_vlan_del_tx(struct dsa_switch *ds, int port, u16 vid)
 static int felix_tag_8021q_vlan_add(struct dsa_switch *ds, int port, u16 vid,
 				    u16 flags)
 {
+	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct dsa_port *cpu_dp;
 	int err;
 
@@ -234,11 +278,12 @@ static int felix_tag_8021q_vlan_add(struct dsa_switch *ds, int port, u16 vid,
 	 * membership, which we aren't. So we don't need to add any VCAP filter
 	 * for the CPU port.
 	 */
-	if (!dsa_is_user_port(ds, port))
+	if (!dsa_port_is_user(dp))
 		return 0;
 
 	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
-		err = felix_tag_8021q_vlan_add_rx(ds, port, cpu_dp->index, vid);
+		err = felix_tag_8021q_vlan_add_rx(ds, port, cpu_dp->index, vid,
+						  dsa_port_is_vlan_filtering(dp));
 		if (err)
 			return err;
 	}
@@ -258,10 +303,11 @@ static int felix_tag_8021q_vlan_add(struct dsa_switch *ds, int port, u16 vid,
 
 static int felix_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
 {
+	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct dsa_port *cpu_dp;
 	int err;
 
-	if (!dsa_is_user_port(ds, port))
+	if (!dsa_port_is_user(dp))
 		return 0;
 
 	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
@@ -278,11 +324,41 @@ static int felix_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
 
 del_tx_failed:
 	dsa_switch_for_each_cpu_port(cpu_dp, ds)
-		felix_tag_8021q_vlan_add_rx(ds, port, cpu_dp->index, vid);
+		felix_tag_8021q_vlan_add_rx(ds, port, cpu_dp->index, vid,
+					    dsa_port_is_vlan_filtering(dp));
 
 	return err;
 }
 
+static int felix_update_tag_8021q_rx_rules(struct dsa_switch *ds, int port,
+					   bool vlan_filtering)
+{
+	struct ocelot_vcap_filter *outer_tagging_rule;
+	struct ocelot_vcap_block *block_vcap_es0;
+	struct ocelot *ocelot = ds->priv;
+	struct dsa_port *cpu_dp;
+	unsigned long cookie;
+	int err;
+
+	block_vcap_es0 = &ocelot->block[VCAP_ES0];
+
+	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
+		cookie = OCELOT_VCAP_ES0_TAG_8021Q_RXVLAN(ocelot, port,
+							  cpu_dp->index);
+
+		outer_tagging_rule = ocelot_vcap_block_find_filter_by_id(block_vcap_es0,
+									 cookie, false);
+
+		felix_update_tag_8021q_rx_rule(outer_tagging_rule, vlan_filtering);
+
+		err = ocelot_vcap_filter_replace(ocelot, outer_tagging_rule);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int felix_trap_get_cpu_port(struct dsa_switch *ds,
 				   const struct ocelot_vcap_filter *trap)
 {
@@ -532,6 +608,16 @@ static int felix_tag_8021q_setup(struct dsa_switch *ds)
 	ocelot_drain_cpu_queue(ocelot, 0);
 	ocelot_unlock_xtr_grp_bh(ocelot, 0);
 
+	/* Problem: when using push_inner_tag=1 for ES0 tag B, we lose info
+	 * about whether the received packets were VLAN-tagged on the wire,
+	 * since they are always tagged on egress towards the CPU port.
+	 *
+	 * Since using push_inner_tag=1 is unavoidable for VLAN-aware bridges,
+	 * we must work around the fallout by untagging in software to make
+	 * untagged reception work more or less as expected.
+	 */
+	ds->untag_vlan_aware_bridge_pvid = true;
+
 	return 0;
 }
 
@@ -556,6 +642,8 @@ static void felix_tag_8021q_teardown(struct dsa_switch *ds)
 		ocelot_port_teardown_dsa_8021q_cpu(ocelot, dp->index);
 
 	dsa_tag_8021q_unregister(ds);
+
+	ds->untag_vlan_aware_bridge_pvid = false;
 }
 
 static unsigned long felix_tag_8021q_get_host_fwd_mask(struct dsa_switch *ds)
@@ -1010,8 +1098,23 @@ static int felix_vlan_filtering(struct dsa_switch *ds, int port, bool enabled,
 				struct netlink_ext_ack *extack)
 {
 	struct ocelot *ocelot = ds->priv;
+	bool using_tag_8021q;
+	struct felix *felix;
+	int err;
 
-	return ocelot_port_vlan_filtering(ocelot, port, enabled, extack);
+	err = ocelot_port_vlan_filtering(ocelot, port, enabled, extack);
+	if (err)
+		return err;
+
+	felix = ocelot_to_felix(ocelot);
+	using_tag_8021q = felix->tag_proto == DSA_TAG_PROTO_OCELOT_8021Q;
+	if (using_tag_8021q) {
+		err = felix_update_tag_8021q_rx_rules(ds, port, enabled);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 
 static int felix_vlan_add(struct dsa_switch *ds, int port,
-- 
2.34.1


