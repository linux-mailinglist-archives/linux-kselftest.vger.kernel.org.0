Return-Path: <linux-kselftest+bounces-2300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FC181BAB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 16:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67341F220AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 15:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DFF58203;
	Thu, 21 Dec 2023 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VhcqlfAt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3DE55E66;
	Thu, 21 Dec 2023 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enevgfcHALPDaSeII49Mu2QoAfkBNes9tZWJpaOutBHHXjRwVHuPOhfWtn6FL1Oz+iLl6bAlcRdvni9jJWZghzGNQFEs2pI6D1AfSZYxXrX12vC3zR3FC7gT+BRTrJhy/pGR4DYDf+TKIGS1ZLmGXTEN1OINyw499PPVSMogqvVye87gYYPJSlGTABkKooso/DH0d+Hn1dK8wvd5iQLXwZH6Q1UuiMmFrgtMgsA5aD1eQPYvHBSmcMlrrTfViC+5MpqlWdgc3mIVq42aqjIxogoiMWIcqM/ANKVFjjdLbUwch95b77d3xYKuF6zJZ2HHnQGJZetcu/Eg7m6Xt5AFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3Y+YMZolmaO266DwnqLoubOILXov7DpGddWSWtxXFs=;
 b=VwQgTGeoD2A54BEF2pHe+6HDyOp5qn0/QxMUOj8DrYO+DwDYBUwKYWyc021olic/yfCAaFj51Pgf40vMJf+HXbL4cBD6Atn4Kz8khq5j0YATpSaLh0f29JEoLJ01DhVCrgyKK0c3r43v8c+my9cRVt5V/KehRfq3HYIfyAxlfe1YHoRjetePDAaynSZM8kLxfFBRDUUW6PdpcNERGcqzqbknaInIrYjmFrEwX9Ms4s/4o9pf2hSeuSna8E22C4xvInd8SYhlJV70xQ1tPYVYrU3ja05NNC9SJPW48RwxhGdCUOyhVqnbcovS1SmamncLSlfnV3d26qRY6XDzWJwfzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3Y+YMZolmaO266DwnqLoubOILXov7DpGddWSWtxXFs=;
 b=VhcqlfAtrnu2D/vJJ/63qLALTfSkUt7j6Bri7lm00vdWKK/z/SjTbQj1RxRCi/nti/XYC449pqHXjdT9Y7EL572CDDCNusTtfDA3CnPsQ0l6T40B0Wx6AjGtSNp+4SnMDObqpnpBhLGq9fFx8ePvuW+K/S6SEKx/2CgTrUmyaEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB9978.eurprd04.prod.outlook.com (2603:10a6:800:1d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 15:25:25 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 15:25:25 +0000
Date: Thu, 21 Dec 2023 17:25:21 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
	r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com, horms@kernel.org,
	p-varis@ti.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 01/10] selftests: forwarding: ethtool_mm:
 support devices with higher rx-min-frag-size
Message-ID: <20231221152521.fhxpl3x2ahiwk5md@skbuf>
References: <20231219105805.80617-1-rogerq@kernel.org>
 <20231219105805.80617-2-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219105805.80617-2-rogerq@kernel.org>
X-ClientProxiedBy: AS4PR09CA0028.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB9978:EE_
X-MS-Office365-Filtering-Correlation-Id: a03495cf-d25b-4a81-b554-08dc02390e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cOoGbnxVnyk30CjGfJIzmk/g9TI7Lm9vUKzWdVwBvKg0E1io3VVpdpm3gWWpvH5cqrFfwYHc1A90ibyWL8KUGYI3Xq8jzJzHBc2hB12AzbBcDmGAN14Go5IWgsG60DuI+pRWtSJ0t0eTn4HyT3XiNLUGWMcmizVw0LgDLzleCffaaq2po93ulIiAGXXe78jpRz4ZHmjyBVjrVer8dfa/R25mMt2DcUuuBNGt0lZ3NFMsRBpmmVnRdo3+XHcZ4F3DfcaQ/mchXd3LSgaL9VPg4Sb0miFp0Fqhm1dYVWUfcszXij1nPWK+9oj/dwye0YO72lq3lDd/Oebi6HsgtgcJyKpuFExZg9sLx0AMW3WPkclcRbp/nfJkmgs89oF312Y9EcDNqUybuwaQUlNZi6apflfPa3qDlykUlXvNTVhrESgM/zGBD1O36Vuob0uYwzDYGGVgBKT5ByCcsVRwiYz4nEUoEa7NDKQ2G0goCa9b5CMSWqcbxc6rQcIe+IUUWQV70wIDN8TxMhJNBC7BcuEdve71wD16vA5UX1V5wM/b6aEp5nGVdb5F3xtM+rmYUsXC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(9686003)(26005)(6512007)(6666004)(1076003)(6506007)(86362001)(38100700002)(7416002)(83380400001)(4326008)(8936002)(8676002)(41300700001)(44832011)(66946007)(6916009)(66476007)(5660300002)(66556008)(6486002)(4744005)(2906002)(316002)(33716001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3B4ZV0N7tNGG9ht+fLcMV93yA0Eyohv1qPrrZuVa4bYPNIu0LtrJfFDi3ERA?=
 =?us-ascii?Q?aDwA/ibO0y2PSCwU5kS7jusGccgSzILrxlJjkjtQ8CsOrilI1V5Qc9IIC/sU?=
 =?us-ascii?Q?VxWtNhkKCiVv6VokU2SzoPRmcBqzj3sWSR0rBZPSxInux1KxFE77eumF5iJ2?=
 =?us-ascii?Q?x7YDf/lNelvIXaREKvofMcifqBtQqGoFLvdGBtrwJ4RSb9WwAsYkltVCfQvz?=
 =?us-ascii?Q?r9EoWYVNgAN4pzF7+v8qvf9Rp/EC+YiOA2NgoXVh6cwcxUW9bjmJ0raOo46N?=
 =?us-ascii?Q?rZLpxsfxCJyT9WITD2VuyCdA6az/llwaIfZgU0u4mX8M1TFOE9V2IZlrgl2H?=
 =?us-ascii?Q?CJHz//BPVSJQgR4AW88nG912mLkQxAr7BeRdoaiMePDOykXk9OZuYcbS9Bww?=
 =?us-ascii?Q?sCMjIsE43Kf80pUZ6UTH7vLHhXKt4iSKJsZhexJ3SiRl+czZgbjAGty2G1cc?=
 =?us-ascii?Q?5p+EsMGWKvdZsH34dLkiemV8CCVsb/1oLntPHwcn5qKXGcWuCMWXsbK1RrEL?=
 =?us-ascii?Q?gpbFJy2K/0Bucn9XKMqaiE6YovJxAS1PNsntc6h4ImpBOrTxZFalr2j5BsFr?=
 =?us-ascii?Q?zk7Yzw5dRl6vvtyTRccssrw0ftA2wx0jX/fW025xJuOiepqS51GmkN84cO4w?=
 =?us-ascii?Q?cj1TlnbGtEAVs7SUE8NVNw68o1042P30E029Ps2YUxJQib4Urb5Y+P4ReC7p?=
 =?us-ascii?Q?j9ZnVI87ZaZLgr42KGAleVxmWf8FMbzr2g9b2KZYcZKhP/erI2LIDBq4nZr/?=
 =?us-ascii?Q?1udGl1Q5NSZSMjkUqxhrbejAOpmu/oZwoRYM32X9tsUJxZnr+HihyPQWTb+f?=
 =?us-ascii?Q?FePsYvH//MyhgemshlNhsVURDanwyzrCoOoPhyU/IPv3ldv/9odePVpQ9Euc?=
 =?us-ascii?Q?hvNz3YUbtSeK3TgXpKJI383S0S0vffZmdCnhIP45x61dsp7Q81l7CHZd25SH?=
 =?us-ascii?Q?Sxv2LQC67vJKgYDif08dGNuz/rgGqEo5WQERHkZMzdI3Ky9RUvILa2XSdNzx?=
 =?us-ascii?Q?pL+b5IPprnM7jcELnxBRKV0poxNmbPUxPoRDGFAIXh2sLLzyCdS0s+I0649i?=
 =?us-ascii?Q?lUlIpWSW9ZfpMzi81g4E73jjtkIztTd+obJnqqTn2ZWcNuVRdGnQhXK+oxKF?=
 =?us-ascii?Q?xs6zoDBlFmnIUNo3bxy280pwacZtA99YrlRjWd2Ni1wuJGRoazl6Z1eJuS7c?=
 =?us-ascii?Q?4ILe0VGCqX0kX4Z2PZ8ulVoNOTZnYUr91nTiYYR8eTOFt2q/0W3TWsfrllzv?=
 =?us-ascii?Q?cVGkj9txgOYSw7fraJQ/JNAtvwLZFRXc4ZlJMkqBP0gEJsWZqaQnMjcEVszi?=
 =?us-ascii?Q?kETBgRWN0/J48B60Ra25gvNK1MY5/Mt1cgrQCTv79sThs4kdDB7L6n6Q2pgu?=
 =?us-ascii?Q?8Icfj8wdLB1rmqHf/kIA2EpGQYdqXDI1vPWInIrMG86XA7IN6kVNKEWkX/a9?=
 =?us-ascii?Q?h9LyFwDaiuDTfqFh6IpfObR144SG9gmKaUb7jJFZBXPBdCSRedXnch+F9XRP?=
 =?us-ascii?Q?Qk8jgJQU22h6Gx9WXkDRT5cyEI1qyI7UYT1+epeKPwCZS0UheVmj3kHVZ4P2?=
 =?us-ascii?Q?VuF6yMn/rGIUZddW2z3lEodvMugRb7Rg24QuOnX7NZbemVG9hHrRd8rn8C6H?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03495cf-d25b-4a81-b554-08dc02390e26
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 15:25:25.5166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85x/oFClS99eLVUhY8Vtlv0m51nU/CHrtvIhoIGgziYOrrOMzB9GMUBIMv5GL8UmBHO6F90AdxkvVV0KqwN7+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9978

On Tue, Dec 19, 2023 at 12:57:56PM +0200, Roger Quadros wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Some devices have errata due to which they cannot report ETH_ZLEN (60)
> in the rx-min-frag-size. This was foreseen of course, and lldpad has
> logic that when we request it to advertise addFragSize 0, it will round
> it up to the lowest value that is _actually_ supported by the hardware.
> 
> The problem is that the selftest expects lldpad to report back to us the
> same value as we requested.
> 
> Make the selftest smarter by figuring out on its own what is a
> reasonable value to expect.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Tested-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---

Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

