Return-Path: <linux-kselftest+bounces-15392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 025B5952C42
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 12:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D994A2860E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 10:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCE81C68AC;
	Thu, 15 Aug 2024 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="az+CRVpb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABAE17A5A4;
	Thu, 15 Aug 2024 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723714743; cv=fail; b=EVUOxhRvB2zgBASogMDS9YV+HBR6znzmpAw4Nyl0v0I6XhsTheXeBdokc/fqx1VicbAd+MebyG6shHf4iAftdj9DKc28WnJ28Awax2wS6Ur3oY3dpMAIZ/J4mh2UXCR2YnjEf2lJpv19g5B1wsSXGRCPhZEZb+vGnOjpGNXK8GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723714743; c=relaxed/simple;
	bh=bRYH6QMokHnFCEZPDJVOmrf8P9U+yBuT7xHhceoN2gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=owld+hk2Mk/a/pbHqzmg63PYO+9drVt/K3Op2vLa3fhIiBkbl9X3NxQmKzj61qoHupR/er8tX+bB9d4b8OozKqhR2G6uhc/psUfClIfy93KBMtLjYH25iGF9h4hEmLZxF4nZT+WIoWC0EpdP2HBWlGFox5HPs4YAm8sMNm5fFYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=az+CRVpb; arc=fail smtp.client-ip=52.101.70.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+0PPp9i+UWAp9nULB86DIj9ftaMH5Q+x4H8+NRIg35YnaVUCV55CYBX5r5somb7hUhrPo2wtuuJA1FSpT81zI4H5c0upuJrx/KppevschP0blscSKgInBTSXSGeOfru/fMKZU90UdPn2uht+iAG7LEQIBZ3KWfuhWsp9wTnzMz18j3l6/Yr13DWAJXAXUMaiXUgicq7qKXcf7OX+stY9zmJt6O2MGYelmerDaEdeGtxDdUcWwVW22sNRkfkfBAuEPWmalRGG5AmlrD9gPFDcEFF2/yK7KhcrqITiHCt5DO2lE+GIRBgMmLg34eKF5g5rgJ+8/EfmRcMV9YfN3shdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqOLX3Qj4kcAzUpgiGaQuWsXCsmGJCeDKDubjgl+YT8=;
 b=ufbY3jeDTFj8RJdaeAnKuyXLx1RguVG2O9f4C6G2LdKUMwfbbSMwsgroFQYmrFht7RUK7ztpVaXICxEIOOqpTYyJyzprwyRYiv+H2myhaGEH3c/+XKm1C3TIJ1jAvDd8L4aivoU/Yob8dFoeRybFdryFLNA2QaHrA0/NbdNt+MRbwVomVKgGIkBo1NU8fRFMXdkNpXNvZBUNI8fbj8bgSHCIFIpRIeSjVo8QsCNHdTmoMhR48hEwnx4N2bB69NiFSZHhJcVv1pOU8Ft1VfgjIsqkjuW+8+7AFcf8zfHWg9Oc6Nfd15KE/pGnOa3VFVHrsPZumrDKm/9RWXpdRn4AEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqOLX3Qj4kcAzUpgiGaQuWsXCsmGJCeDKDubjgl+YT8=;
 b=az+CRVpb1kZc7UexBs/WJ6r5GXgYbpbqKiY05oKx8krZypvNfjsvqBQSng/gJhJX+kbYJ7rnNxBwb8aRTjwCdPGzvjEbhN7mLoBf08KCdjXdWcK9nf/wviM44oZ2b3ogKVD8hgo+QLxNruZal6Q2Dr6BHtQFBXDyfVKI0gi9GM6m511bWOqUw3D2v6PYrR1htUSDZBU9k8730iYudszwr1ywnuPXMvxIACeRORCSBTUXvyucGGQu7G0K2zmOemUApx6KicBftp0mvLtyMckhJjqC1Ecpx/pxs7n9Wq1CV1sVrVl8VZv8EQDajHr5C+rnvIjPAP9utISE0yNZYyew2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB9094.eurprd04.prod.outlook.com (2603:10a6:20b:445::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 09:38:58 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 09:38:58 +0000
Date: Thu, 15 Aug 2024 12:38:55 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>, UNGLinuxDriver@microchip.com,
	Hongbo Wang <hongbo.wang@nxp.com>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Colin Foster <colin.foster@in-advantage.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Hangbin Liu <liuhangbin@gmail.com>, Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 08/14] selftests: net: bridge_vlan_aware: test that
 other TPIDs are seen as untagged
Message-ID: <20240815093855.zvosiich6jyxggag@skbuf>
References: <20240815000707.2006121-1-vladimir.oltean@nxp.com>
 <20240815000707.2006121-9-vladimir.oltean@nxp.com>
 <Zr3GK3NeZGGt2lpx@shredder.mtl.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr3GK3NeZGGt2lpx@shredder.mtl.com>
X-ClientProxiedBy: VI1PR07CA0311.eurprd07.prod.outlook.com
 (2603:10a6:800:130::39) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB9094:EE_
X-MS-Office365-Filtering-Correlation-Id: 6938865f-f5aa-45c8-0bf2-08dcbd0e1658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fa6xGGw+U/1FtP8x+r2oG9zVngmXH9wpzKo2mgLy8jzwCjgdzCIzanN+MH8B?=
 =?us-ascii?Q?eBaDortdykEQoM+hxYHiCt4JMvWBOFcvDlapzpvu3R3RF2GqIbBR94vp8xWU?=
 =?us-ascii?Q?zTH67HMWTTXFTlh0Oc+XLx0vLzQEHF5mim60gpOTrsV6k/JS0Sdc20CtffDb?=
 =?us-ascii?Q?VpZP0m0lBRDT16Kb0AGdTDCbhGYVe/JvOpBYZBzkhzakZpr6QwVuIcwFO1TA?=
 =?us-ascii?Q?J6cUyUB2VsKsQlS4r6Ek/AIk3zadciQrreEfrffBBeeR66fFvmLu/2EF8iSc?=
 =?us-ascii?Q?ZukaORDQsLFWmERl2isRpN3P2vy1JdUMw7Flxg2SNQ02Zas+88yyZ2SdaL07?=
 =?us-ascii?Q?Dxx3AIkS2O5n1YlpCrhFQbpN2jy/Dh34L3BlA6MGNGefxJCtfQ2c4ofHDSLo?=
 =?us-ascii?Q?0DILDgOCL1bh7T1LWD9gAv9ZkVJxb/ZaXWwPDkNgKCm2DlXChPy5GQencmnf?=
 =?us-ascii?Q?af5kFYK+MTge6eUwcClh+kW8w+LVmCnsM4fjshoHRtXvXDeTqharjfS54vfn?=
 =?us-ascii?Q?Bmqmdx6bYD5bgHxD1ZTDGZd/6xqLQpqjNso2Re6/Ap4C+bwSSjkNMKp9jw/L?=
 =?us-ascii?Q?WSMoJP2bDFIGFUP5ydERX+iCk8MccRd10qywGXhNf5+57QkyXJiZsbf86oVo?=
 =?us-ascii?Q?fc3T+yAJblQwQKYMwZuHiBywL3qZqfAJGPqh/T390Z7uQCpwaoHEW7wlfuXC?=
 =?us-ascii?Q?6DmZnStQoq9wT78zjLfpxrC9Ir2COV6MFeL9+A7V1w7Sm6K5Yqu5zKyEerqE?=
 =?us-ascii?Q?lhL4K+PNFsIcPo8knto3Sf8PkUBveNHUMC6/hEW0V7RzbDCR4XiQbnOPCc7n?=
 =?us-ascii?Q?5h7WMJdmm4aqwH6tag1wqvJKPuMlO4Vb6NsjOt9OjTq90feH07lC2g5jdR0M?=
 =?us-ascii?Q?uG/O8ViAa4507SnezTkXjF81Bvdy9sBPTQSkuu6mSbWVcwLmG+69aieYHF3c?=
 =?us-ascii?Q?S85nWs+EUdtDRiH7kpdWsOq4cg5+POuytTIdazEGRqj5H9AydZwhsE/PaP03?=
 =?us-ascii?Q?LFiQ166UyG4fFTcwylhpaRhH2l1xBYFFA0f98FXgLq4/jasys4DWJ1ltefPN?=
 =?us-ascii?Q?lp6/OCVAnPMATbZwfmDaV+BeD3DT6odQl+0JCCeTasM1RAZ3v9fb1cYjPfbG?=
 =?us-ascii?Q?7No6Op8kCVbEp8KU/IFaYMNNP7u/hBp3oQxhGhkjBEJMCAcVEU8FB9/uRUVR?=
 =?us-ascii?Q?ANW4fCqlDbD4WLov6Wik7odvTKYFnZtt6gaLxHzylywIMx2Heez0j6Ehdn9W?=
 =?us-ascii?Q?8O/7f/laO88fhe4szr9ckhIL6stkoZ7PmkVnNH277PoLU1lZpPk13NB3QyWK?=
 =?us-ascii?Q?j7gkqWc4eO9DFXItd3Zlq9iIAebH0IPtJvuLXi3C9jK38w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DFScjWPSIrHxh2qycR8PSgQxcxnGeryWMcqZaLVtp4NspQKLoTqxdOMBLYLh?=
 =?us-ascii?Q?BNFgC7JyDPAFQnXPRUXqnnDb8YlrQxZ7onMtbOoBU/gC/VYhE9YJRZuNSKEq?=
 =?us-ascii?Q?4fH2M6SxGOwiYJRAMmeHu9Voo88q6EGsa5O98Pz6nhBerwwrhUyuFXQ8vMW7?=
 =?us-ascii?Q?MzQwYWPlSRCLsMf25qA/K18lFFNNB1wH3gYM7s/WKhcFqsXEwTcba1NNVW1p?=
 =?us-ascii?Q?rwhUEMKDGbiSykQmudY+ZSJiO+f/a3sZNJzv7ucxqZKlhfG8hBqk4QUiMpIY?=
 =?us-ascii?Q?SnQ2iaYfsniC+EapiyMEo/Na6i7kxSKLSRDfE0nNWnRochtj9tc+TZL9ILLi?=
 =?us-ascii?Q?Nfb6XktHOjnq84tS2ejqjhDgF8ZRNqa4MCLAlp1BC9ddpHezWnW979akiQWT?=
 =?us-ascii?Q?9fXiA2RHyCzjvl/dFduRbEVzGuEcoOuYrldaCdSMLqVi4VI/YKwZfpLi6Adk?=
 =?us-ascii?Q?WvRFekboH4+7sJgMiJv0eAy3vH3t24MEFPNjzPSSM7BncLQzCYPEayjHMtNo?=
 =?us-ascii?Q?AVSmW6ENShmjn37rrv5SrZff6WR+sG7+Tc9SBQ2w2Czroxj6r8ggIEbcH04n?=
 =?us-ascii?Q?iG76uv9W5G8GcDVttlQ+H2pmGuL4NCYlNbD2Qsm3IdnxLahBB+mfkWzemoCV?=
 =?us-ascii?Q?LayRsXo6ZPaZnt3j8bCl2XAOVQB3X1aI5c0JMIVtENGpsRSd9eRNN7hJrchc?=
 =?us-ascii?Q?ckERLDR/0HlGvqxBBE5C9qKjvy5+CSk+IgsKg5amL+gz/qxPlLZmi96XRIAk?=
 =?us-ascii?Q?AsQnOiSKeJAAYZjx69Lp9aKZKSW8hMYap9SaEwtSHk/XxBdJuGJLpj8dJPPN?=
 =?us-ascii?Q?voNLC3gDcKhBzf+JwW20xVWP5gXlxDo7Q5xCpK0kL89liaiogNRhJXwQ+Bc/?=
 =?us-ascii?Q?6+Pilns2BdHg1tYYiMUfexKv/Jby13AS5JtvYl07up93Dj4YPNXMNG7fV0qU?=
 =?us-ascii?Q?XL0biw7fnUT/wzsdCYUWfTOj05zOt6nH/Vg0gkBXQn4n/mfW6RhduHveGD9P?=
 =?us-ascii?Q?2VCX+28KJSNDRjP2zfH6eP9rPhM3eq2L2lrwi8jSsMjkrbQ0JBUtZssgnLMZ?=
 =?us-ascii?Q?tCsEQLkMDis54pPBak2wRM/K8qjRIrI/fUv5XlrJapjmue0KDUqMJtmZg6pE?=
 =?us-ascii?Q?Us5wgxUGS0IwVmdBB1Ol5mfzoAQNa/TqTQcA+/R9D1tpQYrOAFeBIKhE6+uY?=
 =?us-ascii?Q?ialeIKINub6lJyxAWtODtnIB+BZBDfhglgHhZhqbwn+ZrGQM52L9WMbZiUwD?=
 =?us-ascii?Q?s0+PkTwkvHvHmAxe0U+HiVRTJ39rJe1y6DpejNdeD14c4CRWUzdJwqpVsTEX?=
 =?us-ascii?Q?Ln/6WXNIf0i8eZdR+lHu/o1sq8cY7FpD6y2Sy8f2HI8AgipHU+Q4el0ObCvG?=
 =?us-ascii?Q?M5VURoIkSgtKxkIid4cuhs3jRu35Xs7XBrCl/VlvAvt8OnVbpjqyLhTomXtI?=
 =?us-ascii?Q?Q5ppHrsRIRvcLvwBBcjjflkglL51iKAJ/qixbh5UszBK1vIUD+GYz7d+T1F2?=
 =?us-ascii?Q?LC2rbHzHuY6BJQLx+61xzZX8pomycZFdA0+FIvuaJpJVEfNqVKKPMhSpdYl4?=
 =?us-ascii?Q?4DQJf9eFxNbVD7Yj5A2u8MPQyVeCOzVDfz/ih5qLVI4hLxyzw1JwRt7/VAK/?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6938865f-f5aa-45c8-0bf2-08dcbd0e1658
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 09:38:58.2882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: th17GsL/69/ghrreehzfywYH2p0Hz+7ztL9WHfHWHn49RBvH319K4nrkVUi0TSq9Vy4T8IlDYT9aQprODTJZXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9094

On Thu, Aug 15, 2024 at 12:11:07PM +0300, Ido Schimmel wrote:
> Thanks for the test. Passes with mlxsw as well.

Thanks for testing.

> > +	ethtool -K $h2 rx-vlan-filter off rx-vlan-stag-filter off
> 
> Any reason not to undo it at the end of the test like other settings?

A combination of laziness to add even more logic to save/restore the
ethtool features (should probably live in lib.sh), plus a persistent
question of "who cares anyway". The default values are driver defined
anyway, so it's likely that anyone who cares will control these features
prior to starting their application. Plus, turning off RX VLAN filtering
offload should not technically leave anything broken behind.

