Return-Path: <linux-kselftest+bounces-22714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2D39E0E46
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 23:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFA3EB34391
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 21:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B57A1DF277;
	Mon,  2 Dec 2024 21:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UbAGFLU/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E277A70800;
	Mon,  2 Dec 2024 21:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174679; cv=fail; b=MTfh9Brt3s1lW9w60SqBU5DuFnNZJU42AxTxhewwEqHOuRyKmgLWjlcTPebJxVHfIALGwMRq7jFR/qAxY3l6NKPspXgwpAgtsiar9gK8TDC2yPpcKRFFae87HdKHL5lL0/pGIEh8kAWf6LlAh2+5t+g9EnoUzsxQJ3JRPaMx1sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174679; c=relaxed/simple;
	bh=aBesD0juCn/n5lNOlb1LH2mstCFwnEuIpCzmRsOyvrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gw3NyEIEKeMF5H2HNH7Q+eciAqdXsXLaMWHMha7aQnN4KK6oXghpNiHMiE205QOe2KX5u+uVbXeGgEE/fLBYlM+OVzB24JrhR0QEKH6JpXcIihm3Ghqv4G2BjGRL5/kOzBzPNjVra9VfQ1PLuQMQBJmnpV0RYvD7aVLdIkRW1l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UbAGFLU/; arc=fail smtp.client-ip=40.107.241.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnVWakMmrrMjSbn9LMUlIcPZup2+fnviifhu4Z1tAOlY8QfXw0BgB+WLJBBJnRawLIXMI5S0s0BnlT+gR0UG3ht/UrgDUSvqQdaJ3RQsXvZawy3055bJl94+vg57z1s+1XEeVvIhcdhMepOcTzOPu2/Rfqdrv6Cem8Fzs/Y9BSwrNFocT5DOXtIqYJXTeN7+w9F21/fGmdO2cpVy0nTyLeP1MDZCtBgwni+ZVEhyBGN/p38udI/Eap5Fp2Pnfd/6i6jvfks64YngEi6NnW6eekeTPwCJ/W8/dFt7y7g4GVJ59du4C7jL3LqEDx6f8Uwj+0JyRnnS4U1s1RX6oq6KSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2deUob98ILpUvu6aPN8fCuSHul3tj+o+iC9267GiOg=;
 b=Qc0/Y3qXywxmm0cjd4DGS7eGIgITsA92IZlg8j8jPpcZHdMam4+/76/4GA55zrl6SHyS0UwgcegmRb4Nbm14iL2G5KBm4iws2j9DCThtu13zyqckfj0ws7lRROYiUlTjRiBO9Hf3u1YUEY7eCdqZeqWnlN0oygQA8B34XT31AekCVTs8z/Mi8grVyQe3ox2+cpyhnqQT5UtFKtiHdU+jYC0hrk/oHy1/bOMzARVc2C98xyy5sV9eE2BBPhz5nXnakr7tDJGY8d1vTFbpxwJKClsVRAl/W6gEvB39a/o+lcEhIj3FHrsZ+WyaprTnnSRFfMNzPz+i7usuDNZE20ZsKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2deUob98ILpUvu6aPN8fCuSHul3tj+o+iC9267GiOg=;
 b=UbAGFLU/mU+2Onjuef3aD57qy66ifssvpzMZVWqABceUwFtoQR6Y8QWfGqWdKR2I5n1LkB/JOnIZLQtltDyitxtsr0wJixi+flknWynxzcokUbBJeCIDAj0Vw2NAFKtbRpal6B9Bnx4nKunC53k9M1YXEG08ptTRlL/u74EnuIVS8u83hDaPkz/U5phGEsf+KTOfEr6eIPA/0nFTBhJOtN6fDd6dgqzpxzg3aK8sJGmI7J/jyRVfmhsKUkayrJbPnE2LbMyoyOPR8QASQ5GKiS5FEaBEpizvWtzUxRLewXPYUIOKcIUjRpBTPaPnrcmPcxCJGQl5Q5yG361quCb6zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8306.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 21:24:32 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 21:24:32 +0000
Date: Mon, 2 Dec 2024 23:24:29 +0200
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
Message-ID: <20241202212429.n4f2ig6mx4fb27dz@skbuf>
References: <20241130113314.6488-1-ansuelsmth@gmail.com>
 <20241130154307.cskk55ecltjkinqz@skbuf>
 <674b334a.050a0220.3b307b.ee8b@mx.google.com>
 <20241130154840.lv4rmor4dv66cctf@skbuf>
 <674e1af7.050a0220.3799ad.fa5e@mx.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674e1af7.050a0220.3799ad.fa5e@mx.google.com>
X-ClientProxiedBy: VI1PR04CA0111.eurprd04.prod.outlook.com
 (2603:10a6:803:64::46) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: 10099523-cdf8-427e-c253-08dd1317b66c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VZhSTC7wh77cFitLN7iuPVECGJ8EJThS+pFbecYYs7s2zukiCdpZXA4KSBsV?=
 =?us-ascii?Q?EUmfBcEeGGtzKTVk0KfQ0ZNhAshS8nOiIN6h0UlzVRpF6myGYrp7qZbpaFUs?=
 =?us-ascii?Q?730LV903JKXhaxDNsmHl4jPTbOUvGzPCqa98ILn31k5LsTelszTHhzG9w+0I?=
 =?us-ascii?Q?yl5gHksfM7jH/lTVK8kx0ooIxmTRvLx1faEOiDOh6gd8FgODK7xBUlwZJ2wO?=
 =?us-ascii?Q?hkjVGsydMiWafxbE/fF7xOg/a8z+CxGgh0l8kcOSneguib2yKYxzYaEo1176?=
 =?us-ascii?Q?H5O/Ry6ttZAfkz49ezVBYoypGCVobutNsSFM04+7eszU0xnsfx7JWQ8j+TAA?=
 =?us-ascii?Q?0DecNZECzcLcxmd6forjqcKf5f0UX0KTt48q/P3ai5dnMWtEOio6Fd/IB/Ja?=
 =?us-ascii?Q?/JxeTsGL99fJxh11nv8vBhYEscsmTE0ha3rlpNM/Mv1LJqmL/RpEwWueCANM?=
 =?us-ascii?Q?x4k4nRcnor/5+QMR069cojvD90AxLSB8PoQgrPqMjzHcRq1lSkeOu0uL/wIJ?=
 =?us-ascii?Q?UZp/F5flXYPJkInuAsdqlMrl4HzHhGjGKHLQBmrG9FbYBTR+sQgwnMS95W71?=
 =?us-ascii?Q?gP+ter6NHN4lCPfWXJ8y7q5yl9WGiICNJk6w88ghviG/Z+ESvJ5dERTPuJxh?=
 =?us-ascii?Q?cVRl0JY+XwGy/GjCR9RiEhQisK86bl5m6WVo8Uj7Cxa+daf3KBZ+EzLf8o8u?=
 =?us-ascii?Q?WOUwedPUZ8zKkj44qSgh4JDYSY2WjgYueE+S2I6WVdZXtz6SMZPMB+9mW+Qy?=
 =?us-ascii?Q?u+GUFx340tsMO4zZ/tgQYdb5HDTjsY+6nFK+wGbqJ4B648ejcWNFlFyoMhPR?=
 =?us-ascii?Q?di7vzJaP07cBbDMKrelllxqxHO0pvc1KKreSJqmhPTQNQssYcqdAfDVi3gFO?=
 =?us-ascii?Q?gav8/UjppGcV1p5aHpN8WMWzz4jKGqc81cK2VqY/8kfnI527TFBfb3a+DHz2?=
 =?us-ascii?Q?JIkI7HycCWb2XSpjObizL2dksJlteWIjOymwFK63fNwFjIJlrVUFzOqzvq5X?=
 =?us-ascii?Q?Dpd4sKygCM/Oo7v+LTF7TClBUSR/LqlbYell2K4Fq0kwQ6UaPVtagFVtMsxF?=
 =?us-ascii?Q?o1ppBSVy0ExKyRMsttyqR57QWKKImTXx5SfU6mRXCi5WEZeA8BkXdq+Ku2hC?=
 =?us-ascii?Q?SjPA4nCchlnh4EEkmGfYKMW96dPfHrYZ8hR3vAaLqTX2Be1KOU/Dc/rjifuA?=
 =?us-ascii?Q?W9byKuwqJKzJW/b7V66eGQeL552QaLXe5t5sjedTEdMMQH7TZ1uOfz91rmht?=
 =?us-ascii?Q?kOzcVZzTV+N4OKEUgoTCOKbpHBPfyc26pq4qC0pN99ZrwFtOldqZgXeAacLk?=
 =?us-ascii?Q?aXc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HhWDN/GXETof2UbUReNW+s7b0yPlbsCNxpwkE3Ta/KyPDGBrsDWmGKas/jO5?=
 =?us-ascii?Q?6QJRbT3Y9DCSUOus5lUlgWfyZZlviqaNfvXVE+fzvocvpVZlbQfOxWcRi4Tj?=
 =?us-ascii?Q?qWerDKt25/biMNRsS7+pVEYodSiFV3ExommMnR9FMDeMkG15dND9ElMSKc1y?=
 =?us-ascii?Q?BVhqpDL65vxgBs3cRGB7PgSeZ30wxcjngbJh4HuG3pKj6xjjPzEfLg+l24Pz?=
 =?us-ascii?Q?vIXdA8XfPhMCWQMVHD+FaKFjF4rppPOkSx175qaLrlRzmD1JIxz1ONlvcQsK?=
 =?us-ascii?Q?tXsw2M5DhIp327+/htj9sL7wPBs9sIRTPuGphrXVg0H3wnWfq09OJBK6RE6r?=
 =?us-ascii?Q?QSTcp2P0uEoDejNtjMVssVZ8Ho0JApN23FwH/0wt7FTGwQPTTaD8WPlv8Ews?=
 =?us-ascii?Q?5M3d9IWezwZt2cJ/WVGmZjkL94xygbN3ek/qFWk+OvB2bBditfZctsMgFGlb?=
 =?us-ascii?Q?YIKXGRX4odOu8o5kdhd+lrD3zj2KLVEx2SloCaG+dI9z+b3jamax3tTPkoPC?=
 =?us-ascii?Q?bjjl/NvR0eyrlBvPPvbhqfjPjCiI2tOuAaBOoz+M6y/O8bHSV8UIOP8XsAP9?=
 =?us-ascii?Q?o19NkG0K48/E2BcLT7n7TqWYBVStrO5LMJHmQAjRc4QO41DH8hGq37kQLYgv?=
 =?us-ascii?Q?0dzIxMpnrs9HUQYqSRSjo+g/jBMzXOuOtgWh8nN5zsYZDHABw1WVzQHKjZPv?=
 =?us-ascii?Q?cplaQAjXuQvS48RqHSQD1b9b+zjEVcjay0KO1xXrjOrBVmJY2Gyw4fZU5I+A?=
 =?us-ascii?Q?uWQTB13qkqtsOyMXKslD4xFAejD0EW9DLahgNmXh0fbd8L9M60/P3reaXCzo?=
 =?us-ascii?Q?/b7qU0lmtIh+cvaTOS+kMMuO893wupckGVNyf2K5pyGkWwzU/jn109C1OPWR?=
 =?us-ascii?Q?Tka5Dsia6DDPJXlDpB9w0kYhQT1jdgKNuZMgoqzsR0ViewAdRgbLryMeiJYY?=
 =?us-ascii?Q?Rb950SCC24BhPPxjLsZaImmZ39V3DyMS6NGgf4eTkeM1AEx0N01BdNQhKRC7?=
 =?us-ascii?Q?Yk8zuWRY0ePqVyQTBPalqXqXAih+nDiVArBjRT+6mwkeg1cSn1O+K8zBbazm?=
 =?us-ascii?Q?jsmEwrXuldxxvbpAn+qAJc6GzR4oPretly9eGINxoEK8CMX7HoqCLfkf6Rc9?=
 =?us-ascii?Q?6WbcGkt6rTRlDU29+VjLDeJpSfZh2GNX/YNEFjOgqbk2ijlV9rO+ILRIfJDR?=
 =?us-ascii?Q?YKIJWyhrOqSza7K0YSkE8j7UILVViYxwRgUuerwSKEdCLFKtPvskyC2NtNA3?=
 =?us-ascii?Q?g6/Al33D7V6x604yMGUpQeJ9XatEtXeU0fUF6oJnURPxGsNQr/I9V3Ea+d3c?=
 =?us-ascii?Q?6V7KBfHf9OlGatHrteDW1JkqQIqZDYxYKOQEUfv2qWMjmhEY3n/m2FJfjoPf?=
 =?us-ascii?Q?ST8mzvXkkaEnwPas46rALtNhlZNbt/xiiwDajI5ddm0nZbGqZtweQgxJZmiF?=
 =?us-ascii?Q?GdELKwiLn/WXU9tlJOjZsospA/8XKhBGPTytiYRxZLYQbLYBongXHwCUW2q+?=
 =?us-ascii?Q?I9TggHafcdUAxMH3KuajW0PIDnV7UnAHHCF1Y1fBInnqGYnvv6rx+sSWiV2w?=
 =?us-ascii?Q?jIyvXXluXwOsFUfuxg1X6nzbpUFoMkMpyD+xNCxJROwniqwollzGhU9MNfeN?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10099523-cdf8-427e-c253-08dd1317b66c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 21:24:32.3856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPWUucA1GGCo7K6i8GxIkIdlLSPi+uKzysrrxEFJRFtWg+ksCt/FfX5N7SA/yJGsrIOOePJ/jtPRY9xFgIlKVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8306

On Mon, Dec 02, 2024 at 09:39:15PM +0100, Christian Marangi wrote:
> Mhh the problem seems to be -c 
> 
> Let me post some outputs...
> 
> root@OpenWrt:~# ping -V
> ping from iputils 20240117
> libcap: no, IDN: no, NLS: no, error.h: no, getrandom(): yes, __fpending(): yes
> root@OpenWrt:~# ping -c 10 192.168.1.1
> PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
> 64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=0.102 ms
> 64 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=0.084 ms
> 64 bytes from 192.168.1.1: icmp_seq=3 ttl=64 time=0.236 ms
> ^C
> --- 192.168.1.1 ping statistics ---
> 3 packets transmitted, 3 received, 0% packet loss, time 2080ms
> rtt min/avg/max/mdev = 0.084/0.140/0.236/0.067 ms
> root@OpenWrt:~# ping 192.168.1.1 -c 10
> ping: -c: Name does not resolve
> 
> As you can see swapping the ip cause this "Name does not resolve" error.

Ok, I opened the iputils source code and there isn't any relevant recent
change there. But it uses getopt(3), and that seems to be implemented
more simplistically for musl libc:
https://wiki.musl-libc.org/functional-differences-from-glibc.html
"musl and the POSIX standard getopt stop processing options at the first
non-option argument with no permutation."

On GNU libc:
$ ping 192.168.1.1 -c 1
PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=0.696 ms

--- 192.168.1.1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.696/0.696/0.696/0.000 ms

