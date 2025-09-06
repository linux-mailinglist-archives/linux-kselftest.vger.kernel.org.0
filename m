Return-Path: <linux-kselftest+bounces-40881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C9CB47443
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 18:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587F6A0212E
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 16:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897672ED871;
	Sat,  6 Sep 2025 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Qq+T79TK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011021.outbound.protection.outlook.com [40.107.130.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8591629993F;
	Sat,  6 Sep 2025 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757176148; cv=fail; b=sWYAm8OHayp18uDOb+OF868n0r1R1WAHNA37RF00Y5pY7xtQEEmsgDXBd/czRGL1Lpy/8osYkyjvb4lxFnlxgwNYRoN0x9cC6FVj1TnxQ7/pTf78s0vw7XHj95Lr5xuy0x4ugU02f8/8yh2CwQskXmEjeftRYuJ30fP57iAT1kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757176148; c=relaxed/simple;
	bh=gLkB6wcnu6R+8ALzjX0mKL/4JMSqSN6MGrhFKVAhVjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDwRyMUExRhFpsWUPTt4dBJsFQt+/gJ81JHeadtus/JMbxn8ftbhX47wIhiV2FPlQ2j03ntarJ0blVmSpVeXY9J0eqELL0jdf820CRYVq/tzqqN3YIXBU2jEJatEQtD8A4ryh9z6j6wWh5C9wN8mWgsixB+wrreFzWeutqYDZA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Qq+T79TK; arc=fail smtp.client-ip=40.107.130.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUhrlYvqB+AlDG/n3ZXQWveth/ayeTYKCTxlozOGr4Ags/wlOYfpdgxXkMOFicASA/jvMN5Mj3Y1yckwkMZz5iUHZ7A5vk/9TFVWb0D1hLHPwtkNFX0k6rgRkicqkxLtpuCXcbbFspE6j0/i65Lago3LCix49eRNfn0/8W1i/3InrQ6Olq9/zSg7ta0J4HCZs5nSYNwnTgKjFnMFN+N86gnfPqMkjlw6TOyjFIwe8the9Z/LjMi/Lj8YEXmdcL7ftq6Ot+zDocoRqZIKB7CM5dsq57MrxxwHfpzvuHc67AH+QatP5eqvuRuvK0zSfBT0/Lt8HXnabaUnL4EVcDpSdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfVwSbWczeSddiE83kdcW71NDfTHvpdbHXpfA2JQXwQ=;
 b=pMRfWqDFtQQhq+0hTTUI6SbdmGJMDqLzBAUPbZdVbmpYduvgHYPgAcJ0oOFhyBjwgKmXcmF4hcKioxMwp0sxNchILhEpY+9ws9u+yEmr7H+/IL/V1ZOIyOgLgZwnwt3LM3fQLcY24Ke4I8cLRI4UQGkaWtkSUkqKP1xjs2XxffhcyvJrMxveA33AVV6QZtHS5YiMyAvJurpXQEFu76PJTfHHxsE0SL9qUUMjnFu/Zru0RFyBuFhmsqeggnTbzZF0nurF9tj/7hmGYLv33CuPbYPq5Z40mycoQaWu7BE840cgAtEFvWrexeVK5/MQae+31gjgkXdiTogpjImbaUpMWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfVwSbWczeSddiE83kdcW71NDfTHvpdbHXpfA2JQXwQ=;
 b=Qq+T79TKvJq+/vSVPC0CidX/Q2xNMWwtlnMSTklH/O3E5MZqdYxGtucyBjhTQjGkQFdok4ED2f1MqrocSORgWHNeUCeHvE1jgnjoXqswFYrSMpJfJNzBdo1Hfu/iTdd9iAGEan7mB5ekaVlsKhDsEKKEEpuHNqXS/rJ8XnHWDcFfFYYsKaVhDCPIddICACywbAo60HebBsH6xb6wJIKSisemlV92N2FuU8oWi0XIY3B2qtkhy/N+C+6gQga7czUdwjVZTiaQi7yztrgevUmIsaWW1cCawCaQUW7p8nocwTqtfEbwbDR6t6a9Vx1SobjXIUeQth060XK6hb/Lf5FXSQ==
Received: from DU7P250CA0004.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::19)
 by PAWPR07MB11210.eurprd07.prod.outlook.com (2603:10a6:102:50d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Sat, 6 Sep
 2025 16:29:01 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::bb) by DU7P250CA0004.outlook.office365.com
 (2603:10a6:10:54f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Sat,
 6 Sep 2025 16:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Sat, 6 Sep 2025 16:28:59 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 4428E1C002B;
	Sat,  6 Sep 2025 19:28:58 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v16 net-next 03/14] tcp: reorganize tcp_sock_write_txrx group for variables later
Date: Sat,  6 Sep 2025 18:28:39 +0200
Message-Id: <20250906162850.73598-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250906162850.73598-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250906162850.73598-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FB:EE_|PAWPR07MB11210:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c686b952-74ab-47c0-034b-08dded627bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FMea9qkKmSEYl727Jcfy6jVzNCVPeb1EqGPBYIq3LehnKDgXLqtL141s6uQU?=
 =?us-ascii?Q?ZModS73q9Jz0sWFpz7cXpZsVYsPh6+sL5I1FWqyQ7ifkESEXwXA7zxBXBzDW?=
 =?us-ascii?Q?XlgUPMGOoUpiPf37TFtYaeC25LoYQwcdvSDYt1DioSx/AOXZnatcuKh1dFKd?=
 =?us-ascii?Q?ZgZ+j2AZNectQztEemrOCdDPVAPVNPrYrPQA1bo73+bjIIYtMXwhO2yzHiy5?=
 =?us-ascii?Q?QyeZe81+JEBJHbFiY9Si/je+7fQewFqJnfGM51i0BnLCJ4mPetjRkJJ5m6Ah?=
 =?us-ascii?Q?1eAXWu/XiSdZCdn5oAClqz176dv6JxEqsp4ygCpIn2KOLZXWYiWHhFqczNIz?=
 =?us-ascii?Q?ZxPeTNMZa3P6G/8dqTe9DDyKNlXwpbCfHjC+s68cd/vCi6H536zkes84VFGB?=
 =?us-ascii?Q?vT5v8tTvRk3MFU+8plVg5W76zKmR9kLRKKFrFrYuZC7GBNNKiKxjBYmpyrYS?=
 =?us-ascii?Q?T4r5O8uqjnjro6zuso/vczaXMplSBlnC7gqV8W23aaA5/LzVJkJ2pYg6nktC?=
 =?us-ascii?Q?wf5tMrCjk07/qxFmnNV7bQqjVPsJpkeNb4QWdxdUoUvVnIJuzBxxv/wxttSy?=
 =?us-ascii?Q?+X8krpLxOCtwcyhkjt2uxaNmR8qIYisRU0d7C0O6Ziwwjs/UU0jPbwmV/M2B?=
 =?us-ascii?Q?XrnabtEcV52fTexklmfjkKX/v6I/vLcD4OlMIpIN+Lq4qNdP6i2qnVjwXHvF?=
 =?us-ascii?Q?qYTMz8L3s1IKKtkJ62OLzPLIN9QQtVaRMr92Xp0Uinp4aRDrhW3b+WZ++Uli?=
 =?us-ascii?Q?rvSoOpy2rZ0oAiXwsjfy3DeR4kvxt2Xn9IkcP76r2b/z8NSl/AWmR5pe6la7?=
 =?us-ascii?Q?fpDDb8b8NlnUbreyh1ZUc6+Yj8ITX0vx1Y3JgkwWO14uraukOLtNX0fA14au?=
 =?us-ascii?Q?1a1VRwBn43h+uLAuauRmv6KVgfoJh96cR0ITnXzfo+ElJvqxhyMxyhWibqSN?=
 =?us-ascii?Q?Ht14NdGhtilglN4kDc622xvawWcuhEDtnbdbPXQ8dxWONM7JclealO7GdA+f?=
 =?us-ascii?Q?lUN9ExDZxpxP81IvHL0ZAZl21IbuoITpxqs146sqmPWjMbbvtn1x6KLy5V+Z?=
 =?us-ascii?Q?9iXhOHd8Eg0Rdrxo27dsqWgjQIVm+nPEI3k9aJ3h0f7CmsvJr0QwWEY3xO84?=
 =?us-ascii?Q?JhrLnLoP032x7V/Xb0tb4HUMfT2SqIRcIYVrZjeLukBq/kVZu2o6u0Y2KAZG?=
 =?us-ascii?Q?AY59HGaIniIuXzcrlOZTCq/q2yPj42tJ6/IX66rpaOUIIJmFvj6Aiw82hgDA?=
 =?us-ascii?Q?/G+6tcmhfpENoEpERu7LuZjgMiznRgcov/lrXRf+NXZtbrPcwgdpPWMwmLfQ?=
 =?us-ascii?Q?893vCTAiTcq3B7PwK3MBSTJ44debX4jCgro1VIudPpSGDSPSJ/6TEDkRyP9O?=
 =?us-ascii?Q?14BfoqFwowVctrd3qFicol1Am3RQ3ErYvJCIXIaxI7jHPVVT3M2ShZ9NlKQb?=
 =?us-ascii?Q?n9xY+sQ8YN6KiVBTnJxbq0S+BFGXW8OdSTTkJpc6BPF/7znIYtbQFnJkL9Vj?=
 =?us-ascii?Q?pSvF98ajcrurDfvj8m0OBz9N2MnNQmPmR3PJyZLeBy1/g3E/Z3FTxb6gBg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 16:28:59.8366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c686b952-74ab-47c0-034b-08dded627bfd
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB11210

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Use the first 3-byte hole at the beginning of the tcp_sock_write_txrx
group for 'noneagle'/'rate_app_limited' to fill in the existing hole
in later patches. Therefore, the group size of tcp_sock_write_txrx is
reduced from 92 + 4 to 91 + 4. In addition, the group size of
tcp_sock_write_rx is changed to 96 to fit in the pahole outcome.
Below are the trimmed pahole outcomes before and after this patch:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2521     0 */
    /* XXX 3 bytes hole, try to pack */

    [...]
    struct tcp_options_received rx_opt;              /*  2588    24 */
    u8                         nonagle:4;            /*  2612: 0  1 */
    u8                         rate_app_limited:1;   /*  2612: 4  1 */
    /* XXX 3 bits hole, try to pack */

    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2613     0 */
    /* XXX 3 bytes hole, try to pack */

    __cacheline_group_begin__tcp_sock_write_rx[0] __attribute__((__aligned__(8))); /*  2616     0 */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];     /*  2712     0 */

    [...]
    /* size: 3200, cachelines: 50, members: 161 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2521     0 */
    u8                         nonagle:4;            /*  2521: 0  1 */
    u8                         rate_app_limited:1;   /*  2521: 4  1 */
    /* XXX 3 bits hole, try to pack */
    /* XXX 2 bytes hole, try to pack */

    [...]
    struct tcp_options_received rx_opt;              /*  2588    24 */

    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2612     0 */
    /* XXX 4 bytes hole, try to pack */

    __cacheline_group_begin__tcp_sock_write_rx[0] __attribute__((__aligned__(8))); /*  2616     0 */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];     /*  2712     0 */

    [...]
    /* size: 3200, cachelines: 50, members: 161 */
}

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/tcp.h | 4 ++--
 net/ipv4/tcp.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 57e478bfaef2..d103cc0e7a35 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -285,6 +285,8 @@ struct tcp_sock {
  *	Header prediction flags
  *	0x5?10 << 16 + snd_wnd in net byte order
  */
+	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
+		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
 	__be32	pred_flags;
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 	u64	tcp_mstamp;	/* most recent packet received/sent */
@@ -303,8 +305,6 @@ struct tcp_sock {
  *      Options received (usually on last packet, some only on SYN packets).
  */
 	struct tcp_options_received rx_opt;
-	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
-		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
 	__cacheline_group_end(tcp_sock_write_txrx);
 
 	/* RX read-write hotpath cache lines */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 588932c3cf1d..897cd28d2d8c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5129,7 +5129,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 91 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
@@ -5146,7 +5146,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_est);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcvq_space);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 99);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 96);
 }
 
 void __init tcp_init(void)
-- 
2.34.1


