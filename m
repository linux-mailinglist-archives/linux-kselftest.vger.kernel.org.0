Return-Path: <linux-kselftest+bounces-22642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09D19DF1DD
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Nov 2024 16:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7A90B214C2
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Nov 2024 15:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE69156F39;
	Sat, 30 Nov 2024 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YB55wB9g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ED5433BC;
	Sat, 30 Nov 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732981728; cv=fail; b=eOtPlzS5ldoDRnUkPl2ZbplItC3nSra66gOjinN98GiVkAGV1nrkfYdykwP6sSCnglZIOzgzV4+RkLWqESWyx/TX2vBHye1RVMlKqB8Id13iqACsDJiElLPKNUvgBpPYTg5ClgSsynJHj2oY5hF9i6sav7QPkNdJebxwMxL3qSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732981728; c=relaxed/simple;
	bh=XNi9ww78EOlQCuK9vbDb4LLw27HfCOhVIR8ul+wbnec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DV45A5mHLQ8GTZ5z1r7q3JLDoeC10aKgyP1Bq4QaXt/rCgly7oXfmSz3Fv2pJIfvn3cSpkXefuymm1lmARLIXE1887fieoHYhuQvgNqZgZzu45xx6HL09kA93gfxbXgC2rCjdczfvPwzc3ENparCmMYr/rJDB5DwMzZMouIFZlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YB55wB9g; arc=fail smtp.client-ip=40.107.21.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlGJgUvhtlQr5FHr+NrvnSQbCCMHAlhtfSZkPvbB338bOGNp9Yz27V2J8peaKuSBuRMjorbjlOGE+ohpbClWZ2DGhVixUTAC6EUDSEsgYxteDOPXGoiMgjUhUbyIVXsAPaaPTCaKWO0xlBuVRPnDBJUr98wLfzHJB9GmTndErzVqOfIuBN0OOOYlkCheRL6Y9eWhW4Jz3JhyNnCZB3EEzLOc5d1/oifYHbDS9QF1+Df8GZ0hY2Idp/C+NgDgE6hNZY1TBSrMB3XVzV5J3nZ7vItE+aQRY3lJkMrWOGUc4c+cNtHLYsSD1k/QXyFOQFTT8ZX2j6jzOZzrMHM1IoWz9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dgECCUGYaZSnK353NgB3DRzvOM36k7j1Ir/SMGmVOA=;
 b=tWVuyxXkFzHwdMWDgUeiHYVwCUu4DEujVjvmLnj2gryieTDV/TZaNMmbU/6qTA0OYMxK/4HlfEuKkdbgwUWvmJaq9IGdzXSctF7PSM4RRiiU/5nhWFpPC3ITFyOt6pL7El/+uJRGb/qL8mBOc3rhfW56MjUj8ravfLpW621g9BtOo0xNJUBE8tublSp7CS2z3rzEc4mGcxvL+GWbQ+DFPn7j6jYl1fUh4gbn9a+luj1BTXneVkb4jgT9GgSLuYc+OVa8DlED/zOW8HJfRU/mE2LHyY0qVSE0zfYxlJtfhlE0pSgDB9L2LrcibgF0NAVlhaNEDAgT0+O6E5W2TJF2pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dgECCUGYaZSnK353NgB3DRzvOM36k7j1Ir/SMGmVOA=;
 b=YB55wB9gir2FfRyqBvIuszBWkNZHdX9Lqz/XbiNAQrZ3TaS+2mWlesZm4EVsiPEVcxokUxeonaM9ZxJeP2dfIkqZo9TeLdTlkfhFy/QMxZhFxyyF77MWy+wKL64E5nm+De6/eatE7mRFHdDZo0o3T6wTrH8zcnZr9WsYbcadSkIH7NVToUKOrtfnuHNHPb4Ue96dvhkfGW4NQYEjVNlSacbxY5qR24CubQ4D50O8g/MVKU7OaKfFESiNpvW0u8Ub1KsFD2UqK3pTbtEX7VWsMsdL0jDewidZqwrW8mG5jAv7I/9Y7rABQTMu0BLfP8PkWAE/VO+a9W8Z+2XFFkwnVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI1PR04MB10074.eurprd04.prod.outlook.com (2603:10a6:800:1d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Sat, 30 Nov
 2024 15:48:43 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8207.017; Sat, 30 Nov 2024
 15:48:43 +0000
Date: Sat, 30 Nov 2024 17:48:40 +0200
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
Message-ID: <20241130154840.lv4rmor4dv66cctf@skbuf>
References: <20241130113314.6488-1-ansuelsmth@gmail.com>
 <20241130154307.cskk55ecltjkinqz@skbuf>
 <674b334a.050a0220.3b307b.ee8b@mx.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674b334a.050a0220.3b307b.ee8b@mx.google.com>
X-ClientProxiedBy: VI1PR09CA0111.eurprd09.prod.outlook.com
 (2603:10a6:803:78::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI1PR04MB10074:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb278ce-de70-4bd1-79cc-08dd11567819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?24kq34rAAxW9kgLBQ+dm+E+m5vIQJu/PkbC0Nx62DboHKiMfaw0gftjtzVi5?=
 =?us-ascii?Q?/d4tsHE0/Kyk2l1k0CGqO6lf5iEtuFiFwQV69Js7iQpO30BsTwqF0FsZHuUp?=
 =?us-ascii?Q?iUTrYvuEaJAxsPI0AndE2dsLT4Jz/1wL6/O/N/bJvV39s2SNwxzhZ6JwE7EC?=
 =?us-ascii?Q?rA6e7Lkv8Jds3vEHMeqg5DnNRhGjlMGoLmthwumccdweS53o/Pr9cmzg3lmL?=
 =?us-ascii?Q?HIclSgwfBHa+1jBsTdqcNScFb+9Q4Q+4XGYaOimuKxcBQR5KfXYvKXbBbeU6?=
 =?us-ascii?Q?CGfUoJPuaNbQ9b+rMtmKE7eSat4eab1ldGGFJ3+tNKScv8ulzkYhGHhcR7HX?=
 =?us-ascii?Q?1kudBjy5/i+E6dR3S9KsJJGEnYQh3oQwtXyOpkVTjFeCNo51N+7cgFfrvbF5?=
 =?us-ascii?Q?UFndEBek9Y78hAW/zdA16pOY86W3VM9Nr99W7igaY1A9rUwMGyZQx86rD2yY?=
 =?us-ascii?Q?4vpiddP04JaBp7JeYzDoa/cJwPlGCvvXedc2XITsmVq/b/otfItIDZh6YIdI?=
 =?us-ascii?Q?Vr4f93FjduYKYQV9bU50K0AMWMsFcEj+QX8ml+uy0rCg+ef0tzxSMoA+1txp?=
 =?us-ascii?Q?1rcuZG1EczWJeJhMP8N+CtQYWcJpbHETvy9UEYL5qXYb0wnwz2WfOHvrK36E?=
 =?us-ascii?Q?9Fd0OWFktxhnwHcLMcsxA9hdXhoDKi41rb+G4HAeDIrPoyMg8tpfY/rSY2aT?=
 =?us-ascii?Q?5wT16iepqvYbjL5trwn1QYL19aYOvZug+cKmxX6gwRhgjuDKMWBLSpiXc8AX?=
 =?us-ascii?Q?BYJ6YXYSoeyJPHSNRv2+RxP9snms7DBdS69gLQIse5apO1FiFhhqdA3cldjv?=
 =?us-ascii?Q?eBbqw+fTKFxO0Xm0vP7g5FU9xqwPORL7vGPSRUs/giNO/X5UJXBr7cTkbBEY?=
 =?us-ascii?Q?xga6uSWnz5PiV8OUcpBW65XtLhBDMpTbr/qmLg1bO2ECPLFZC1692hb6+61R?=
 =?us-ascii?Q?AjhNN7+qlxegOJ4p+bPVPtf6IkBLnkWnu/PC49H8Pfhwp7JRv4JN6WEgNI43?=
 =?us-ascii?Q?Z4SelmeGa3bEHTW5c1aHi/AW0fW4rqVnZ3C82nWOvR38iEhL+D7z52pfToA3?=
 =?us-ascii?Q?rxZXIlvlU1zVUvRMjCfrwF2MvxVEMR50B2HuVUdqrugKClusM5GGhl6bw+hB?=
 =?us-ascii?Q?ZI5Eph9vHv9dT+5Q6LUcn3r3i9RQJC57Ucq2WgMF5DtHXpuIVbBWswWLjvQZ?=
 =?us-ascii?Q?2bpClylFihTx2rt60P7ec+B9a4tGAlsyvAZ919hXQqXe4BAXqNK/mhv+ETEo?=
 =?us-ascii?Q?9F4GW2S6fOY94o096GBSCXlh0QS9+N1ZOiMV30meByCdWx3vYTkfhhaB+8df?=
 =?us-ascii?Q?fBuwhureCLJqTIv2C4aLV7ZlTuQg5dX4Bo+IkLvuDNsmcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VYMnunJ47snu59tnzGCwmz6Z9cGDoxCbxDKiTSqwQdMTsndke8zPQLnxJ3A5?=
 =?us-ascii?Q?yZ605ZAX1diIIZlKx/xLd/5jEGkhPXtUk2luOBGc7LFRSpy0bFgvSP+L71j7?=
 =?us-ascii?Q?v2VJhFF1PcJfRUOqiI7ofL6BQRyDx/xfiSHw1XqzrxR5mG6D6DBWnDsluZeI?=
 =?us-ascii?Q?y0cCXOBdxGv53dNc22MToJTgnSvaaL2HQHqrwFiqxpH9z+QG924AvYgggl/r?=
 =?us-ascii?Q?624X8V4GXxbBeqBEoyMMaxcs5vvUBu1cxSanCAYjlADHTdu1K3vJNrsaT1zX?=
 =?us-ascii?Q?3/TMRO7bPY4gYi5NzmC71TuuUdzCS0fq8Z9ECUHCN21ZqTjPiygAhR/ysr3/?=
 =?us-ascii?Q?eMt7QIeed/sHv3Ar6tmHTpx8aEoe+tVMuEnozara5UeUwYAWCEIIXp9pSHbm?=
 =?us-ascii?Q?VHe3aaHra+FZ9JU4tWSjYXW9Qbsw18Yhvt8JMPuN9dBFr3ERR/yubZOfn6B/?=
 =?us-ascii?Q?+iyJADamsK/icgKqsAneLcpjHotmLgc51j+8S7slNExdDvr4y81nk+yCPAhx?=
 =?us-ascii?Q?tChMzkBbi7APZNoTegQt+cX8L2jKFaz6e2wjOR7bvTNRb37y8Y973d0vwTwI?=
 =?us-ascii?Q?iRig9SYQJnHTdpJWFYC0Anx6YGIUiDflEiI7/SewfP9/txtYnpJ71sLcQYQE?=
 =?us-ascii?Q?k6HKPipEWgG1YT1FaX6kq/IzpCTHGj8wzhyoB15la9VlQltc9WsIzeNg6+W2?=
 =?us-ascii?Q?9QaQ2R6SCDbEA4AKSHTWQz3/6ugtVqLzRZhXOtkyoEAsVul87Fx+YmC4JOAG?=
 =?us-ascii?Q?H7mNbgDqkD2SJLCHRq+70hITngH0Hh5yvSv70HgpEn/Sg9XhIVx5nnWZgVTY?=
 =?us-ascii?Q?0ws9rRiFXtigJAEagco2Zm3mRxpvn2C5HvRvV+mL6/hPmqonTPlJ6EcqtQEY?=
 =?us-ascii?Q?T/NwL+aRdvfB6AADgrB6m4epLOPjT1ncfAPZEsha97ql6VtQiqMUry+bmLje?=
 =?us-ascii?Q?keLLS0ADD+xwohw8o6YxiFbKXjYs0A3PRQG15+tz+mMOOGumvOB1QvunOCyL?=
 =?us-ascii?Q?Q4EFC7KfjGLG1bvfowXSmPBhI9kmM5vYl670MR+0c+UcabLKIsO2jiV2D443?=
 =?us-ascii?Q?jD13tP+zCg0CIyjWz8fMSDC1kivyFLxtNLbPizt+tEFtczIVTW3Zmv33UjBW?=
 =?us-ascii?Q?YGLLZlQJhIHHVF3i224QtLI/O+j3Jx673mixFvE4teNw7jnLUx9bQ4Ik3Gmp?=
 =?us-ascii?Q?anaxgI5d8atRHufthfs29JueXWa6VIgvM30Lcqy5DZqzIoPu+zoxqoE+d9xd?=
 =?us-ascii?Q?r6+MzcskkX9UYxfQtt3pTxaj96akoXER9mf5IJURjSFPTRMO41Nmt6pxob9F?=
 =?us-ascii?Q?oESPWJdkQPKNp7LsfgY5seTF7XXrn13pMsAdN01HfHbKA2ttB04yFE+JmlVQ?=
 =?us-ascii?Q?/TPjh5d7nvjOS3Yqbix803ThPOQHIyYipmGBP81BLBfk8xfZDXnCL5RiYqsO?=
 =?us-ascii?Q?U36Ve/lOCROfqTeMSJwtYskbqPFpOiwcF81vOxV8M52Ab87Bk8g2UCrlBywU?=
 =?us-ascii?Q?VMY42xy1jOLIlEPLVVg+JjBhRlnqshwZbw3NJ1rI35XIGSzlJPkahBE0fdP9?=
 =?us-ascii?Q?Q37Ac5ERvj3EGDRwqo8qvQhYXBNfH5J4zlGzY3GbYea6Yd6HpF/FgOpUNv7B?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb278ce-de70-4bd1-79cc-08dd11567819
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 15:48:43.7651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ugL2Ei5sb1aCGIm+V7Gh76v6R9Msz45+ILb7I+Zs844g9DsF+0djQ72TMrqs8Df9bVW9547KxWIyR/r4/Lqmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10074

On Sat, Nov 30, 2024 at 04:46:14PM +0100, Christian Marangi wrote:
> On Sat, Nov 30, 2024 at 05:43:07PM +0200, Vladimir Oltean wrote:
> > On Sat, Nov 30, 2024 at 12:33:09PM +0100, Christian Marangi wrote:
> > > If the coreutils variant of ping is used instead of the busybox one, the
> > > ping_do() command is broken. This comes by the fact that for coreutils
> > > ping, the ping IP needs to be the very last elements.
> > > 
> > > To handle this, reorder the ping args and make $dip last element.
> > > 
> > > The use of coreutils ping might be useful for case where busybox is not
> > > compiled with float interval support and ping command doesn't support
> > > 0.1 interval. (in such case a dedicated ping utility is installed
> > > instead)
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: 73bae6736b6b ("selftests: forwarding: Add initial testing framework")
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > 
> > Do you mean the other way around? that the busybox ping is the broken one?
> > And by coreutils ping, you actually mean iputils ping, right?
> 
> Mhh no busybox ping utility is problematic only if FLOAT INTERVAL is not
> enabled (aka 0.1 interval are not supported)
> 
> Yes I'm referring to iputils ping. With that I notice args are wrongly
> parsed... especially with the -c option.

But isn't iputils ping what everybody else uses? I'm confused. I have
this version and the current syntax is not problematic for me.

$ ping -V
ping from iputils 20240905
libcap: yes, IDN: yes, NLS: no, error.h: yes, getrandom(): yes, __fpending(): yes

