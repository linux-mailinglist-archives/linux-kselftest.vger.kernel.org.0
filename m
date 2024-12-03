Return-Path: <linux-kselftest+bounces-22735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F8F9E1D69
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 14:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13078B251F0
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3FC1E411C;
	Tue,  3 Dec 2024 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="md0DV33S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C381DE3B9;
	Tue,  3 Dec 2024 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226397; cv=fail; b=CNKPB7TJbw6xq06H7RWcjAudPejG0urQVPyTVsBOi8gcX69oMyngnaO5HsxjYmXfa7yFdYjE4ZFvcsZ+kVqp/9uW6XfC2B1JsEz7vr1bcn1hrF6WmWNQmAyqciaWXRrWCOxuiIQpDH5G4efwO3m68tnfVeWtIEfZFMy05ut/4m8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226397; c=relaxed/simple;
	bh=msYMJrUlY1PJVx4p1uxXTnsKwLkOJs+nXgt9jRF1sgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N3WV10IZasV+uGb2AdDg4GtlEQbjx3dWIVDYpGdmKjmRdOhmungeHwNu+XLRna0c7/wwt5kgxVhtKCXZ4g99CRWR0XaapWK8OL7F+0CktbylU1rzFwOlZRc9/9y3QUpn5o2d9qyA17eHuTa98nnmix7z+rrN2XEOFnOd8rus2ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=md0DV33S; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZJIdmZimw9knBUePyp34vksMYzchWmdToyYd/WnF2tiMJyhdKceixRkUnDYZ70Qxk4x5c/oj9Yi+UmsKaaS/YadUkEiiTsMqGDg9m4SWu1MpSP8xoo3MfVyv2fuIVDGmQb9TkpEEgfPdfxsqA5+z78S5XfLR86GlyhZwySboy1BWSBdW6DWXlbE89/FoYHtPAjoeAXDwHF2dwiPqix/CVUEspzonu3GUZC94nYBFT7wYcSYprGUw5mLjYqQVcrE6FYEZ/RCRxyiwr97vw6U/F234Pf9UefVZoIg2Ps7CQJa9SW0sg8cHJOhlpXnztjJNo5l2nxjCqgg2PT9orQOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLoJR471pS2E+F5FXHwDZYgLQvO1Sz/UwqoAabku1ks=;
 b=QM1IZkcGcXCPHGfjWNYGY8wgfQYDG7nyRj4MLLtv9JhIMoFmQFrYhSseQ3BABISSQQ2xIZgE4V+VnFweFOtDSR/VE5y2x9K/XfBIcPpKFzA+UBMtukThXyuhqE4H20mHL4X+Z19xdxc7Vi6y9beHJ/XwQyZEvY7LQiIkGnINPW79cIQINgkp2tysQXU6DiYr/vK0MkrxkHCc8UZWofOFoO8tavLHwtX879tPEkb4zek2yd5QaZdJNFAAs+hWQI5i9pzSQKLvyoiiFju6HkoETDgXE2WSF8U2jF1unUAtbpi7fUn2IJKjSGJa06fiIkBDb8mvxU4EvoIKsyhYM7F9vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLoJR471pS2E+F5FXHwDZYgLQvO1Sz/UwqoAabku1ks=;
 b=md0DV33SPwdyJ/vHm1HU921Nh7N2yI3bYYx+YX2H1HQKhnDeiEV1kyieGzcKkz//+XxrCqIPAkSN15rKKEWwVN0Y2ZDNdFKrSx3vYMid4BOvGiyCbUBU2ejYdmbjBmJrdNawHvq8VolkHMg5iEY0umkci0tjgh2LqLZ3YFEoBWhIRDmmwbQrPv/iXDfFle1hVlGhxzLfWn64unmnjFcTXMq+wxsM+Wbqxpz3Kuel+gRkd0/klgj9aa24vjXti9/Snc9k6Fgx1Npi3XvjWWp/l2RJ3lhG809ljU85sfBvhwihoM7h9NA3eDDb6+GXWaKj+S8IkdHNWFVDRIcbne8Gwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB8272.eurprd04.prod.outlook.com (2603:10a6:102:1c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 11:46:31 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 11:46:31 +0000
Date: Tue, 3 Dec 2024 13:46:27 +0200
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
Message-ID: <20241203114627.dojf3zl3mwch2j65@skbuf>
References: <20241130113314.6488-1-ansuelsmth@gmail.com>
 <20241130154307.cskk55ecltjkinqz@skbuf>
 <674b334a.050a0220.3b307b.ee8b@mx.google.com>
 <20241130154840.lv4rmor4dv66cctf@skbuf>
 <674e1af7.050a0220.3799ad.fa5e@mx.google.com>
 <20241202212429.n4f2ig6mx4fb27dz@skbuf>
 <674e2674.df0a0220.33ed66.d434@mx.google.com>
 <674e26be.050a0220.2de4c9.13ab@mx.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674e26be.050a0220.2de4c9.13ab@mx.google.com>
X-ClientProxiedBy: VI1PR0102CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::17) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aee1c97-ed81-494a-064f-08dd13902130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z0Gb29adZJcnCKUkCD/LLTZssc0QKr/UZXS6D0PWqimkyiROIl/kz6BFtaKZ?=
 =?us-ascii?Q?oDeirid4XUy5HTGWIm9l8a4aoxTvJHsdoDrpLXqdVXXcqeI1mIhAK2OOGkyO?=
 =?us-ascii?Q?Ewjzb1Eg/S1tJFg5mqfvnLB7M7p/FbyyatCnnl48LHPsvyfcuYHS136kFb/r?=
 =?us-ascii?Q?K9TsKEXBwPKKOt5Bcfa2EVcjZEgMm3QmSW+OCQjQCTY4bB2IAds5qwopvXkv?=
 =?us-ascii?Q?ib5U1SmQ2Iqv6DIbURFMuu9ayFsi5+rpGZOFHQRLyBvYPcrg81CzEH86Wneb?=
 =?us-ascii?Q?rj7cBMkCGBHyegDgLKyhjENPkLy4FYRCEJb+LkAp/aFqXebHZCikeBle8Oct?=
 =?us-ascii?Q?R04MFtj4mpraXA4p2MUXsT+Isi3xy4Av0JKOsBUc6Onaw1fJOuU8fjz2U+fv?=
 =?us-ascii?Q?w3nvlsxS4yBhXWvc+OyPlbMd6cl61I7h9EdNmQCAcH1S7u/6AZd+nNd+yuUE?=
 =?us-ascii?Q?dH+GGImEGf9vC1/r85qdCZs0na/rjwTk0vE72pRpSRRnrjJcl+GBXcrTX0+8?=
 =?us-ascii?Q?saXUxGr6kuictj7suAGtp+oOHlJq5FuzbofPK6BB1D06EnoMOWpgwZor/YOl?=
 =?us-ascii?Q?vnseaJTCA8nnHv2Vjt0mbJ08bYUt/cj4i1aAQBO2Su2NqTs4BN45ZT/5dchb?=
 =?us-ascii?Q?mUml8FKItArjmsJ7aME6bG6u2FZfcVGKiWV60awwwMC6aMdTeE2mfRPMx1yH?=
 =?us-ascii?Q?s34EiW7ZtMFLE++bZBuPmPK/OzmA2TXlRkpEXHJ4c7ANfLNNBYy+3sHFmxr4?=
 =?us-ascii?Q?PnIyru9ru555khDEvhIozq97GZRTk9vCmMYSFFq1yE3Ow7SqVLOJXPu3byio?=
 =?us-ascii?Q?CTIXye1xNbnBp6wP0CU4rBrgDQqxEul0yi2X6tk1B7WugM/uyGjdQQGZyccr?=
 =?us-ascii?Q?raKXdBsctNIkDhX/4356Y2IIrLrJpoqkCXv1uSS2F+C8sa4TJzqEhA9DpYUL?=
 =?us-ascii?Q?31OOuichCXySrBHLdrysw/HsnkFdE+NXkCDM9BDTAqXQfCKUlqeNeRwgU1o8?=
 =?us-ascii?Q?WvYZIBgi8ojxhwJ884q+ek2qj6k9DmPAkplRCmBfF6RYEZKMOD/3b4xAYqAw?=
 =?us-ascii?Q?vEUyDewtYi6IKoYSptk6UuGu8bigIrNGD5dfmzbKZathq8X8mP8UyQs8PgBu?=
 =?us-ascii?Q?xGJAuhquMWVC1kbhjSiQD+Ch4pKvO4UsyTgvAsW3MaMIfEGryLlsCAsk7s/m?=
 =?us-ascii?Q?16IEcV/XDW9eAsr59YJXlPn8tujC1PJqNIJ0ePIVm9+FC3785p76zaR1BMMf?=
 =?us-ascii?Q?qjm9gRyKOc2RcSsXq8XMLvEx4F1L8LHWzCXM5yoSHQb2wOurJp5AEp4oF0Wq?=
 =?us-ascii?Q?bj61DzOBdOSeffEtHqSddbb5VBnCrNojyfFPp/Q+SeC02FoAX4C3G9ECLHa6?=
 =?us-ascii?Q?ci3roMc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CfHSBjzjeNeRDNuoeuDKY77Zg6idLy3fw/681mskJ8X6zpGcyyzkrgy2rVHu?=
 =?us-ascii?Q?eyVHg8x+/uSrJWgxD3LaTUqV/F5PqcE4R1PJf4h7SCwaPyuECXhKJafieddx?=
 =?us-ascii?Q?/4ErDj5ZIyxZLwpOTUiPlxE/B0RTH8bDmvmB3i4pEuF6rDtOUoaYcGufiB/O?=
 =?us-ascii?Q?jTe+nWVk766/cazY93P8sMxIbuyP/sK+M3hrnyFc4xXqucyGfeXl+phCTt3N?=
 =?us-ascii?Q?ZP5kxCZbcPv4MwjXUR2o9M3LWJNQg4+6IrR9EkPdb9CCsXWFWaf4Pb5qyUlt?=
 =?us-ascii?Q?hg1azYtUKerwpsUFlhdlDtmGo1FMK1w5lmeTMGB2K8xAbUIBxYGlsgEtkaz8?=
 =?us-ascii?Q?9BxUc/eT/g4Ugmcj3KrpkScFAGeET+2yd7BjJoDsfLbesTsN/5MYzMQWIwZ+?=
 =?us-ascii?Q?tvuDx65nENfeG36mImBdoW3DPA+2MFsz9oR0Ovv0UF+x0HVol9vB6s6J8jcT?=
 =?us-ascii?Q?0j0nm+hXFT8qswJaNBqjjDmXW1WfxjvndAnTCsbU686nvlohNySYUI5ZNuri?=
 =?us-ascii?Q?2vcAaOCmVpZ176zkDgVebvgoIX5XX+XC/A1ORPlyi1i6zoGMq0jYQD0hKGJH?=
 =?us-ascii?Q?zfzXPcEwd5SDKh0K9r8srjHzQAkbrw1u3ZGFemrLDFR242dqDPHIEf0Ndj5n?=
 =?us-ascii?Q?pYI1pRFQpu5Hs80CuUt9+IsVxNrkXhnPvHq1FPVIMBxo2dkqIveG1e2b2Tdz?=
 =?us-ascii?Q?eBNtkhAx8e/c0pjsjTkF2CD7PTVsBonlp2iFeVKm0+L5Qb6UPeEliubT5lhX?=
 =?us-ascii?Q?HmUQNLN+3QhQFoRZb1eXL4K7gOqHF9LX45bidIsbXihEGCWWiEuDmx8ICUfT?=
 =?us-ascii?Q?dV+RJhUJWBAJRGNmQdfjrG4FKBdYtwux2REO/PGg4IpW6tR+QX7m28t0qw30?=
 =?us-ascii?Q?u6YhYMuYZsgi9N9cYY1OaHZe3vg2syhj1/NZutgWyHkVuUtzwFJKj3c5+fyo?=
 =?us-ascii?Q?BJXd9nLRe5yamb9320+WMQjgyy8dQhQwyZ7Fwj/tEoxlUnsNhSC1nyHg27qW?=
 =?us-ascii?Q?uYT1uWV2pnn5231CgsuL/M42dx/zsLgGJyQm14Yt7fI6LY/W4xTWuqLoXK6l?=
 =?us-ascii?Q?fyxg8i5AFTJIYGjGXILAoPHACIq97ox+IOxxi6P5reZEMZCAD+B6FkVUnbcn?=
 =?us-ascii?Q?8MXyHGJLB+NP9eJY7xvWWjjxUc64YnurC7RFfSOf2+lmqbWvl2W4HRTGtErs?=
 =?us-ascii?Q?MqFOZiaVMHMqnauoXJ05Q5WBacuidv/jMpldwkXHNGq+mxwdWDQenJkYvQXb?=
 =?us-ascii?Q?elwnlJHPSi87gg+J4EU5RVP7dmZp8Sw1v2/nHeVxCts/Eg5RMRAOxT5R642J?=
 =?us-ascii?Q?Q9qnbsuqLyX08AbGVV4joFFbkyQ2LG1TE0wvwYGRG3+3XxByhT579aHv1bXA?=
 =?us-ascii?Q?TJQIT9CQ8H8zyqRGIhKJMdoyy8oFc/Dt2K7oRbv0/hqSEKt9TX+SEXYcsDIG?=
 =?us-ascii?Q?WFq1B2NIvNokqck6/ncFeWaq7VdCf2kdEMY10mbdGQtyPhSQzBmSpciQiNNr?=
 =?us-ascii?Q?5qL0o7XfiQ3LOg7S9lLP78ZouDl1GmzwTTvY2T8advtELYgaPoBwtuumn9Il?=
 =?us-ascii?Q?43Ueg7RNHmc3k/ZxaX92E1KTxUkNmKM6kYCAhM6TSDnoOzOs19C2tz+tWqVG?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aee1c97-ed81-494a-064f-08dd13902130
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 11:46:31.6882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPJ6AqyT68UGgnCR7CW5iwMKTU/3LnqmgVuIFHtKtYvLKP6KwqJ1na+y4abzeYJW2hlP6Fns/2ME0wYnDeLgUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8272

On Mon, Dec 02, 2024 at 10:29:31PM +0100, Christian Marangi wrote:
> > Also I just notice msend suffer the very same problem...
> > 
> > root@OpenWrt:~# ip vrf exec vlan1 msend -g ff2e::0102:0304 -I lan1 -c 1
> > Now sending to multicast group: [ff2e::0102:0304]:4444
> > sendto: Address family not supported by protocol
> > root@OpenWrt:~# ip vrf exec vlan1 msend -I lan1 -c -g 1ff2e::0102:0304
> > Now sending to multicast group: [224.1.1.1]:4444
> > Sending msg 1, TTL 1, to [224.1.1.1]:4444:
> > Sending msg 2, TTL 1, to [224.1.1.1]:4444:
> >
> 
> Ignore the last part about msend... just me messing around...

As discussed privately, "Address family not supported by protocol" is an
mtools bug introduced in v3.1. It has been fixed by Joachim today:
https://github.com/troglobit/mtools/issues/8#issuecomment-2514087499
Please pull and test with mtools tag v3.2.

