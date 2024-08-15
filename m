Return-Path: <linux-kselftest+bounces-15365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E073B9526A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 250A1B21158
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D893F8F7;
	Thu, 15 Aug 2024 00:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SWeZ0t6o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11B739FF3;
	Thu, 15 Aug 2024 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680592; cv=fail; b=eTk4dQzVERctKZLCENhDAcpYyflDnxfB7X+eKfBImbtqr+nZ54gI2f4MQlM4KZEkw3HRyQ2uVYaxUDSgyzke5P6BEhhe7GpROWUrdRS+klV5xTZgKrdyUBxYWmr6M2W3EQlFuhpjw4vC28dB1vSZW/m9RKw3o1f6QBVD9d3hD8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680592; c=relaxed/simple;
	bh=YuJ7NQyQWm76vxmErrRlK7JMZexUZ7hjgATCEw9l11M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P95nqEuFC3RE4BXlajWhlspdcTidLxL9aK6+oUXgxGpGRT79+EcllRVHtb2bNQ1TBpca3DRwEmfuxPIKbfmxgfQPphT07DC4QFL1KcGKXrLpJiPvzaDa/HFqqFn/CBAWzrLIM9yx1qbvMA8Kz11XwdYESHK4Yv51R8iiFsoQ3QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SWeZ0t6o; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqkmD7nzl+2ADeDxpUNioV618bVxtrDRxQTuFrnt9B48yViUT2eUwZqwRl7e0rsPM4R0cNHRAuCLuF5v6YDenUDmRZJYFl4IW323L9I3zhaDfF6zCuE0QcUQXqbjRVRxs2uxZN9Kq42M3nhvovo6RQJvuwxlUDQigJU1SNmtiIQW96Vui8tZhZenbyhGixRP/gOsqqfz8YS7q4WTbCmKGWA1xT/ji/umjKf0slHD6kK4JfMgj7QIBhJfxXwzXgFeaXXsu/Z+wuQt0RmFDPKNUivL3wfrp1wqKBbuWFesoRlOpY/9fdqKDJxM3hueeLLgUNdh4VN70OLYP5yD3LBYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRvdSMSbREMt7oTN8amvkVPhsMYDAV6b4DEsItJsj/8=;
 b=Dtcapo/RnK4xqYIVp0SZBdGRqAYbwrmHsNGq9JiArBxNRrH/fUouAjvk7o5JrDFn/J5SqOVsMLlwZwYcuPlmKzIZENFAFE4tdZ7cvZQePR2YxAFGE8Y+/L9a82RPMl8Ozms1k4r7ocBlRH7AVJQAvNp72Bt+UGXwiO2GGvDXxpXzZdgorhV8fmpwH3IXChz0G14fzabP+06DsN6vG3bCfU5ovSeEIfpRbq+p7AFTlHYqK6yVviGi/Nc+dmbYqLjgT6hzDFRWPB2CUmXjKcOWgAqYSxLBEACnBor/9jLYh3qvZ/aEC00Dn3ifsIZ8mu8hP7YsadQ98GE+P1KUOCWWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRvdSMSbREMt7oTN8amvkVPhsMYDAV6b4DEsItJsj/8=;
 b=SWeZ0t6ow6ssUy19wYW4EaSJnFxRcjJrvLZ2IyZeKFW0K9wrbAS4rdoNm8v2mEKQlyfL3tcikflyoGuB/qPWbq6pn+Vs3i+I9Yjhc+8+YYat1hzJlSv2IH/nGUme69LveS+airNm96mmvP46XtUhHEC152wIgnSjuLQZdf0oppZQImc4pcvo28x+GIAKnUyHbC45TE8Itp7RgAbF9ZU7eA4YH/1BaIZwSQOPFIosUkDWTNUH4TR+1S1bL9CwH8dG/5dLAJkSqh5Ob6YeZhzIziorxefVXXpd5+nrMdonclFaJ4TL2ZgBMzeYcJ3D94nDF/TH3vtrsrvz3HPsNSJBkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10285.eurprd04.prod.outlook.com (2603:10a6:800:21e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 00:09:46 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 00:09:46 +0000
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
Subject: [PATCH net 10/14] net: mscc: ocelot: fix QoS class for injected packets with "ocelot-8021q"
Date: Thu, 15 Aug 2024 03:07:03 +0300
Message-Id: <20240815000707.2006121-11-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f4de2165-b29b-441f-4ca6-08dcbcbe912c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uQ3jjszLf9ybbnt4rCmf6qt1+D/LLTZugr2H3wi2tQOa/1Jt6e/v91kyi/qc?=
 =?us-ascii?Q?gZkFWZWOxmflZ9voBLXbFmjAA6YUFQeoWOwuc6r+SHEf4QKQeL/ac8PNnvK3?=
 =?us-ascii?Q?VtcOTZG9NNfajmeydrn3QYVbwTrWj5qZlMQdab7b9N5SOYsdkwheAE8sHJWa?=
 =?us-ascii?Q?nR+tb9yVecIUODY63pPaJ6GiPCJSIDhphs59oasAjRFk74FiVvM7owJzMjGh?=
 =?us-ascii?Q?EYNnF4Mm6GP1GkJJnB2HYzjCxLXZA6lHJ5RUd9ulky2yMjcG0C1Iko9PLEBu?=
 =?us-ascii?Q?6XfzGlcRB2ntmdkKw7j1qxIq4VdUpTNYjd1IIhsKw+Ed5PJFWoFf69i5U/zt?=
 =?us-ascii?Q?/9q/OJ6+uz9HF7D/pnk1Mc7fYy/uCH9rVYM3F2jFVZHBO1BxyAGoWC8RfEah?=
 =?us-ascii?Q?dkq3mURUFEhYjo/unUdyrilccm2MB0jb0Fh5OIKChrxLwbvTHAAm0o2n5gm3?=
 =?us-ascii?Q?AaKSxJHETUyCHvUewdirw24LVqrcL2GMD9u0Uk9zHiQ7+/pFC1nGDRPCyCbS?=
 =?us-ascii?Q?naDjA0zl1erTqpSRYlN4o6plgyDjS54McMBVEJvqGBZKiLTE9+Eg8ksMlXp1?=
 =?us-ascii?Q?y4xjqw1uiGOTJHm9NRLIr3Moqi0G3rI5F1tFD2/v57VXdt+xIQGWbPAPpAPG?=
 =?us-ascii?Q?/W03BsHfmduLGDK9YCLvr8Wp4R4MLMjp0dSFHofoLN9iMv3L3E9mViGf0B3K?=
 =?us-ascii?Q?QK9fQG2OGHXb4IZPOH2cICq6Pdb0/q95tj/3TYm5ElzTJv0lOF14J2OO5a9e?=
 =?us-ascii?Q?J8niVDOUHwuOU8/v8WQkBHIgsYmKZewp/AkmrdwaJPaAKA6b08aAmVrs1Nes?=
 =?us-ascii?Q?wxttYKZ2pLribIaaAAQWrG/rrav6tnQeK2+EZbizfk8a8i53d8eONymaVlnK?=
 =?us-ascii?Q?6sw4J7Qo4S9hP7MDjjAKy6/65GPyVnm8OFBqgS0zIbI4BYEK3iWtL4pzb+ia?=
 =?us-ascii?Q?JieTYD6JGH4oBzdP9paOCIDeHpr3TfNGN4cq50abTWfcm00M1/dgS3EOG6bZ?=
 =?us-ascii?Q?cJyO4dQTIZ0q1w7O5aso0SGYUBNxX5yV2PYF9w/LeA1D10fQcHxnaN9D+vow?=
 =?us-ascii?Q?9igBFdxTC4Cb0sBm27L1AgLHtq46VJp4K+mhUf1lr2/oIxLK1ferkeb2h1my?=
 =?us-ascii?Q?YxwToHJRX9dr5WwBNrJxbLzklLTjRT6P1EcRLHEE5O7rU9F6TAnYnnsyQK0P?=
 =?us-ascii?Q?bEZO9iUY7uCqjike3B1fpPCw0Jf8laLV3vwy9lDt0LvqQW/a9RdZEj8x6qQD?=
 =?us-ascii?Q?4DabcUn/9fmH9dvlEyvC5BazrI20v+IMYBUW15uc8/+iLngL0jEAuFb/wgDB?=
 =?us-ascii?Q?ze+MdwRiY1QCHQe/WgcaAo2yZxhbi/MrumX8fofWC4jjoBiXO1W8If4QHI0I?=
 =?us-ascii?Q?x1fQE08L1YLlrD3n8bq/TcaWDremLeqRK7f1aEsR0wYReKwVGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yeYTKkoUA5vIWAm2ki/S/A40lsrE+hQtRBFg5xTeT5B8FTfUxQlEybsINUjD?=
 =?us-ascii?Q?PEqiy8OQgDg7KRqJ+aH4FY+8HiiqYGrCxnRZ/hsekqNL0RnE/Via0l+WYjYG?=
 =?us-ascii?Q?tvGAUlsoOKkHiifTEBt6/Z7tjepYKHuUgwduiCoI4dDKPEQTOFxNKNgeB7D+?=
 =?us-ascii?Q?Z8dgNPd9/ddq3UAifIjYFTJJDfnIuzubJIkDZMLTubCCWY8dtGUtdVw8My9i?=
 =?us-ascii?Q?kDULUy2cg/RuMtVXIC7Wc+oglK4g+x89jKX+F3ZM19Vmg3qZJAP2lPFOKkMA?=
 =?us-ascii?Q?uq8A2UoYd2DiFktns10AUqtSW41n8ShBRt0M6nQZetDeHnNC49alhK0gU/ru?=
 =?us-ascii?Q?bs6uBVRmarr1vzFmlIQJoUhNPfCFrxn8RfGkJWcAtSnFk88J8REDHdZbMtDA?=
 =?us-ascii?Q?h3lwxAWhqhTojSq6vo2Sb/jUjNkbIWz1ik5FxgvRV5kimekvSVAsiNxZhRkL?=
 =?us-ascii?Q?5YUZMxRk4Z2Krh3U/kVr5CLMBoxeWHVuRsoCgaQ8dgOSERIgTOztFNfmSe1W?=
 =?us-ascii?Q?JTV0HFO1xZ0ACute1sJYcpvloJVFh8eM6X3EghyXPGp0QuZxg7x7qLX1tuYn?=
 =?us-ascii?Q?PJBFTqRhPYcpw3GV5pOOP+A/2lwQ/amqiSRJrJwAac7OlWdTy366MN6WSDYy?=
 =?us-ascii?Q?kVyfbqZwtxglVEW+SpAwj6utuFyoDJwcLZhttdRg8KPwE3sMm+UPBacqr939?=
 =?us-ascii?Q?gy0IdkQq154BWAXGtgnBsnCrOcqvVPJfW9Nx6ripnNpjPdRtqkG7hH0JDVPs?=
 =?us-ascii?Q?HXh9kuDSKHuKgwdqnyqDjnbZdgHlmgP96HAZ58cMByWTetd6l727UGYtSrQ0?=
 =?us-ascii?Q?vNtYdEbXttGa3nJzI8cWEf+JkGNepfjKheG3ZHdb08/d+9NmfRDrcDEec4qN?=
 =?us-ascii?Q?I+70VSapuOWilTadVGzfoLKHrJ39CD9HU0kZHYTP0B3cPDgjMMXRapsEJy2T?=
 =?us-ascii?Q?bMHwdNjpDDkXV2qDrOQSSwOD1r3kbib+DNWCUgRhdZNPLghmTipOOzpcpyJC?=
 =?us-ascii?Q?dEGvZgrJ0S3vh5x9hxmdzonO2BnIvc9mLY2Se2GYqD0wa9lZwLeHTusRa8Jt?=
 =?us-ascii?Q?xEN52noXC1vTSNCPikA90rLHC7q1+uSkxqAg0u5X+Zp0CJnDo/TbK8tkBpr3?=
 =?us-ascii?Q?qpKKpC+se2/DtcSrcpCiw8IMeNrELmzX8q87N7cTYPiRczJjK/jogk5Zfs/0?=
 =?us-ascii?Q?rRlHDQBeuoNIvGjwP2GMMoH75H2qWKgfuTfgJ1K7Njc+/X2N92JytCxfdmeG?=
 =?us-ascii?Q?7a4R19BWUZmpw6EoGEOoZ89Qv/pRDRZXtLee3Cr/PAzU709FlgbgOSvy1E/o?=
 =?us-ascii?Q?nDshkqR3nVZI6jfslnudIxsG7zm+1SG8vMtQFfVUBp6pgsySzeHovtgQc6j3?=
 =?us-ascii?Q?0VfhMgEGNPEMQNhxOoNo/ft/c0sGcoLWjIyLzkPINcZcC8KuZ3Wh1T59mt9E?=
 =?us-ascii?Q?Adeae1s2kcudq8hYM/DuMZQAhDxYknasMSm5w2qsnTAtFuf2AGXVEtIr+pMe?=
 =?us-ascii?Q?3AWCJnPdDZBdQD7syI73QekX+1S8PaViTJ3ZbhaUwcVEynDrvZMT2fx/6mN8?=
 =?us-ascii?Q?2yKBltsz9Xfigli9gNv0SoFzDk18KwR2dHpIvtTxcFSIPBkmEC4c4MUrsrRx?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4de2165-b29b-441f-4ca6-08dcbcbe912c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:09:46.2033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/Uo8s9H08tY4IlcHpsgbq93RmLPIoQxgTiGPV6MBqtsgdzUjTME9djeTKCQYWdI565JNmdSeXfXqbB71Rgi/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10285

There are 2 distinct code paths (listed below) in the source code which
set up an injection header for Ocelot(-like) switches. Code path (2)
lacks the QoS class and source port being set correctly. Especially the
improper QoS classification is a problem for the "ocelot-8021q"
alternative DSA tagging protocol, because we support tc-taprio and each
packet needs to be scheduled precisely through its time slot. This
includes PTP, which is normally assigned to a traffic class other than
0, but would be sent through TC 0 nonetheless.

The code paths are:

(1) ocelot_xmit_common() from net/dsa/tag_ocelot.c - called only by the
    standard "ocelot" DSA tagging protocol which uses NPI-based
    injection - sets up bit fields in the tag manually to account for
    a small difference (destination port offset) between Ocelot and
    Seville. Namely, ocelot_ifh_set_dest() is omitted out of
    ocelot_xmit_common(), because there's also seville_ifh_set_dest().

(2) ocelot_ifh_set_basic(), called by:
    - ocelot_fdma_prepare_skb() for FDMA transmission of the ocelot
      switchdev driver
    - ocelot_port_xmit() -> ocelot_port_inject_frame() for
      register-based transmission of the ocelot switchdev driver
    - felix_port_deferred_xmit() -> ocelot_port_inject_frame() for the
      DSA tagger ocelot-8021q when it must transmit PTP frames (also
      through register-based injection).
    sets the bit fields according to its own logic.

The problem is that (2) doesn't call ocelot_ifh_set_qos_class().
Copying that logic from ocelot_xmit_common() fixes that.

Unfortunately, although desirable, it is not easily possible to
de-duplicate code paths (1) and (2), and make net/dsa/tag_ocelot.c
directly call ocelot_ifh_set_basic()), because of the ocelot/seville
difference. This is the "minimal" fix with some logic duplicated (but
at least more consolidated).

Fixes: 0a6f17c6ae21 ("net: dsa: tag_ocelot_8021q: add support for PTP timestamping")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot.c      | 10 +++++++++-
 drivers/net/ethernet/mscc/ocelot_fdma.c |  1 -
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 69a4e5a90475..9301716e21d5 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1208,13 +1208,21 @@ void ocelot_ifh_set_basic(void *ifh, struct ocelot *ocelot, int port,
 			  u32 rew_op, struct sk_buff *skb)
 {
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	struct net_device *dev = skb->dev;
 	u64 vlan_tci, tag_type;
+	int qos_class;
 
 	ocelot_xmit_get_vlan_info(skb, ocelot_port->bridge, &vlan_tci,
 				  &tag_type);
 
+	qos_class = netdev_get_num_tc(dev) ?
+		    netdev_get_prio_tc_map(dev, skb->priority) : skb->priority;
+
+	memset(ifh, 0, OCELOT_TAG_LEN);
 	ocelot_ifh_set_bypass(ifh, 1);
+	ocelot_ifh_set_src(ifh, BIT_ULL(ocelot->num_phys_ports));
 	ocelot_ifh_set_dest(ifh, BIT_ULL(port));
+	ocelot_ifh_set_qos_class(ifh, qos_class);
 	ocelot_ifh_set_tag_type(ifh, tag_type);
 	ocelot_ifh_set_vlan_tci(ifh, vlan_tci);
 	if (rew_op)
@@ -1225,7 +1233,7 @@ EXPORT_SYMBOL(ocelot_ifh_set_basic);
 void ocelot_port_inject_frame(struct ocelot *ocelot, int port, int grp,
 			      u32 rew_op, struct sk_buff *skb)
 {
-	u32 ifh[OCELOT_TAG_LEN / 4] = {0};
+	u32 ifh[OCELOT_TAG_LEN / 4];
 	unsigned int i, count, last;
 
 	ocelot_write_rix(ocelot, QS_INJ_CTRL_GAP_SIZE(1) |
diff --git a/drivers/net/ethernet/mscc/ocelot_fdma.c b/drivers/net/ethernet/mscc/ocelot_fdma.c
index 87b59cc5e441..00326ae8c708 100644
--- a/drivers/net/ethernet/mscc/ocelot_fdma.c
+++ b/drivers/net/ethernet/mscc/ocelot_fdma.c
@@ -665,7 +665,6 @@ static int ocelot_fdma_prepare_skb(struct ocelot *ocelot, int port, u32 rew_op,
 
 	ifh = skb_push(skb, OCELOT_TAG_LEN);
 	skb_put(skb, ETH_FCS_LEN);
-	memset(ifh, 0, OCELOT_TAG_LEN);
 	ocelot_ifh_set_basic(ifh, ocelot, port, rew_op, skb);
 
 	return 0;
-- 
2.34.1


