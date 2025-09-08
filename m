Return-Path: <linux-kselftest+bounces-40969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B60B49708
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 19:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA00203B44
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BA8314B6A;
	Mon,  8 Sep 2025 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="CBqyaEx9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1653313521;
	Mon,  8 Sep 2025 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352868; cv=fail; b=cI7mOJh77YK3qH+XWaAkZg0OctLOEQAVH+GPbs9TZoc9/5qK2ebGjBbELOWxzoh8U9QRUsx7qtOBdnG/yxX9Hq9nPmTRHav3RUeXgzxJ3YXA3+P889unm3W/2fm8VI2vYjNSoeqiduSO5l+XUih2eldeSMQ7ggrUD5baXoMmRbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352868; c=relaxed/simple;
	bh=gLkB6wcnu6R+8ALzjX0mKL/4JMSqSN6MGrhFKVAhVjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUeJmWWh16LARsEDbL3ufCYxEHbNwjJ+j86RDJVNq+bx+u8JkeR5z3gc+wOC++CKfBVAYlzQNka3fHw4BIMHp4WBz9zCwzSZulryOzPF8y9hsbKWpdpo22Ds+/Sj91EDf+U8mxeV0mwWx4xsDwDPDjc33kifC8Ee6rzbNpoBU80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=CBqyaEx9; arc=fail smtp.client-ip=52.101.70.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvgaXaKGq1Zhd+F/WdGRXwQzCI9em57tKRRkz0lpD7aKd0TA8EaWjaak14SzzeiKs5yDj579ebsj6CsvWSwWgf+hPlgNw4Qgr1G/sbY0QTyfbHKUHX5q2M8Dpr6y4CK/FPawOvNuH92c2/0yNX/7rkUAUcTqMPz+lj1V7zx+yO3j9t8N2fxgIAYREG3NFqacB/7edrdSurDwOrPgcKkaqVUDMSUcdcsIgaZeRYPTlnQBH8U+oH/RLrYKBJfCMhn7HE2aHiYggZarH48DHg08jy+xTa12foV90/NI3UxygetkM1hQ1UaJ7+MN256WSCeDge/lU8mxYr7bJ9B62hWCUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfVwSbWczeSddiE83kdcW71NDfTHvpdbHXpfA2JQXwQ=;
 b=cv+Id5WoeubYLKxdAHisLMECz1owLKev8n+yXRCGKo6nq1MHL2f8LoWAL2P/nRSMG0kWAi9nB/+rybnPY+oEf/7j/wS0ObaROuTD85yltaHzdWwc3WG9i4vGdqiGFtlvEAbyqLx20Enx5OcXi0LuqIDA5aHPEkk7DZYEhJPMwKVmWVbt/JvAwaF4x/FtghGl9WPXdHbaM4RgFiCGAMHM2z48GCpY1Unuu+mhAauxmVjrYzTdz4gtiq8yVqfB/EUuOTR3L4N9/U6xSe5SHZU+LGBk5+5J+euVquKJobhJ4JbLnvA1WmWhM/6oQCQdCfhh8q7twyEcsanYzzw9D1MJig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfVwSbWczeSddiE83kdcW71NDfTHvpdbHXpfA2JQXwQ=;
 b=CBqyaEx93W+qA85PzeApciCK50LTVqHDEcChNP69K40+9Z+snMZRmJLJT+siaBtCMg7BbgmWx/Bzyuh26OLIjAhmTynTBdqjYgF+DomCbz6YBTbtjVDV0LZJyx4UK42z7/KX4N3we9ZJTJmaqIIMN3s6DaxBHRHqbGTDeiEh7AQNZJKWfXm2EsQnEDObYzsXOQWbPeXrBl3JWurGZ9LwMq2A/Ni95qTcimVkRjCgeexkryNUgjYvRGgLRyhsWqvy93dCxf6ULWohLxtu3QOaaIcGiRO/yiOTgNriwQRk7umjrVg5Z+4hVOk7YAfOws74roQKKFpLp3fIQjv9wpd90Q==
Received: from DB9PR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::34) by VI1PR07MB10020.eurprd07.prod.outlook.com
 (2603:10a6:800:1e2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 17:34:20 +0000
Received: from DB5PEPF00014B89.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::20) by DB9PR01CA0029.outlook.office365.com
 (2603:10a6:10:1d8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 17:34:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5PEPF00014B89.mail.protection.outlook.com (10.167.8.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 17:34:20 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id AD1921C0053;
	Mon,  8 Sep 2025 20:34:18 +0300 (EEST)
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
Subject: [PATCH v17 net-next 03/14] tcp: reorganize tcp_sock_write_txrx group for variables later
Date: Mon,  8 Sep 2025 19:33:57 +0200
Message-Id: <20250908173408.79715-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B89:EE_|VI1PR07MB10020:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 092d0fdb-52f6-47fa-2eeb-08ddeefdf18b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TDHPD253Pf8QCk+OY4fW5BUzZutlXliKnnR96ykbe3M0RFH9DW00Ca4HvX9R?=
 =?us-ascii?Q?L7WSMYo9Cif+zO6tWdNTH7SSuPRyjm8Y6SZvF+D3LDAYxcRTJWvB+iKoA4i8?=
 =?us-ascii?Q?ZLe8syKzDd1DUFEzkGd46YIa/wXo6C1wKsjFC+J1x7jUoXoqdRsUXNUeHIMU?=
 =?us-ascii?Q?zjipkRt1NF6gHAjszOShVoSKUaqZ+u7JP1gNiP5QAeBbNWoeVjE3jBTniOss?=
 =?us-ascii?Q?Tet2TeUPL6ALRQ7lHnlYeoLNLzfzyT5fbNQZO6zHgXIXMe+Ege9Dpe7mrW0R?=
 =?us-ascii?Q?5WwktYxh7YpHU4uc52NIVmp9nD1KmLA9gKFKyAAqyShFztkM7ugoZiZRGkHb?=
 =?us-ascii?Q?H2WSYbn1bgDXb8iezMsoXsR3vkpkoaIjRrmTx6J3zb1MW+2K9F9wsrwAtm1X?=
 =?us-ascii?Q?4FFbvzTHYj6czP/x89ti9K5OgXdFou5TPY/p1JttBIswL0TFKEPQyzWc+x5K?=
 =?us-ascii?Q?8PnwokameDi36avHYIK1yuNUdy4ARQLhAwZMy602nr6PhCTkdNdaxQ4mSrwY?=
 =?us-ascii?Q?wvF8EY5Dpir3XFW7eB9IO2MApy21b9g6zZXqzilfToAQYm243mwyerr+OaAs?=
 =?us-ascii?Q?6tWS6mm1oRxkMbgOj0ZVxWFF9cCpLXiX7UJDI1F79FSCmnmDiIX4lUwEY55o?=
 =?us-ascii?Q?O2KiZS+HAiKzGn/pHcdvVw0WBAu7BD84MU0FzdYWCK3fF3If8uZEo/6MaXdU?=
 =?us-ascii?Q?aLuElAJTrSY2Pbe8kpfc0QoGj6airM/dVKPGaTD43FwlHq77rXjPEfd33KU3?=
 =?us-ascii?Q?7+r3l83pe6/IvfjQSlBb2vryFzwlR3uFRZI60KXd77ZHpWdwx4rReKlHtd7n?=
 =?us-ascii?Q?pkFKvAcJpkPf5mrPFh5mYlF1lGkAx3eZMDgKUJaXJICBLUtdvdLBne+yRCsY?=
 =?us-ascii?Q?4I7yZkCnyQoVMfq5MXfn6/PwrnemvOQlHvsPDUb5dcbM+4ZqPd61Ft8PXjOA?=
 =?us-ascii?Q?c8jAmo2HmVzDf6VXBMNHV8qVhGPhrv1C4hCqod7NlqqUJ475daVcYwezeNSO?=
 =?us-ascii?Q?eQEJXVf5rl7VI5TXf2dd8GPYvgCVZ8NVy/PM4GH5ZAAaQGJikivF3bbip19/?=
 =?us-ascii?Q?u1DJIWFoB0lepBvtAuISEcv4O1S8EgZ27aNCcrsOgDPihs7sBZb8BsYZXKJH?=
 =?us-ascii?Q?p5KxAnM30zMH5LEHMfsln+3aTMxlPMML7iASVyG3UlrtvL0W4rjJsY2UKJAq?=
 =?us-ascii?Q?Jka6flw3EO/9N3IviYuMN0RkWfz9KeDlD0Vwaur9nlDkS55KrgIoCwm2yqZt?=
 =?us-ascii?Q?jw4yne1cpG5yVLLTM9k+HRYes4La0pxyBOt7hZKVasO9Ek4MHg3D7Ojogi8i?=
 =?us-ascii?Q?6btC4pIEfQEmDqgcMfQZFDbNq95QA5caLt0V6Y+t/CSM3gw6RsJLMd53Dxjt?=
 =?us-ascii?Q?luTyLCO/g7P49YM26NWB8+P1zMpl8ryzk6qiiTm7mVFk3i7cKZ6L6c67aA17?=
 =?us-ascii?Q?LMGyMw9x6Tb2KuuSKVpSpJf65dT/oK60vAF0OgVqcOOjFENoxaiXmzag1IWT?=
 =?us-ascii?Q?UawogF/++F9/fWrCddP7i7pcTL0ccYvDvz97YeDN8xR7P9/3CCCtO68z7Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 17:34:20.2252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 092d0fdb-52f6-47fa-2eeb-08ddeefdf18b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB10020

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


