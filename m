Return-Path: <linux-kselftest+bounces-34565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE52AD37BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9318116695F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 12:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E0F2BFC67;
	Tue, 10 Jun 2025 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="oAyU3jU8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79238299933;
	Tue, 10 Jun 2025 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560009; cv=fail; b=oDFTHbWAPnmlYCEMTWx1bra5O1/asKj2TaZP4Z0qk4WAkJ0wmyrbLYVJR8F3pbQ6QDgilg4IW8dwXZQCx70g9BH8H9nLhiD3fIGMHx6t+HNIZqzJVdygwRWkByPrMHFQfbOdd3OCiZJGQIPokNTE86zRSNukt8RAcETcPde9uXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560009; c=relaxed/simple;
	bh=f1oDZwnL546rDM5GcSxc6Ij+WMBhffj190sJV4EMnxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPyeyOd+tF/8cXxdbcbs11fDJrx8CwrMDoCSgbdnFcSFGbrcB1Srk1zQYKdxuoIPMtxKNNm5wcg1xW+yU7OmDqqZygIsUDdTOw8wtdtWeFs/N1g1QEPHPhC623Ndj+6yeo6HXtDKMbd0Bnsw51js/IDlnWwak+bVhFpoIjvZhNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=oAyU3jU8; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOsF6u7LP6zJ2BPPwH5bz33XvXoYJWb4p24fG+8bdsUrUZMJWVB74HMhFmb1ZSFBsuilfdYA389dZ8MPamkNCVftEnUYfvt2H9qM4tf7Ixk25+pYO4YdxVNKnZFdP4YfFgg60Oq+GUG1WuhrsveVC5bD4aKHk4EtnkBld4s/x+1PWATgWEIyNb8d/6LR0pWF4G+sBrWWMW4DHuhCwjB/HC6w3k/Q/uunrusJWQfwMj5K5K3IVcTWUEufyJE2MRW+DwOxqAi1gm7I0j+/4BOwMLpd/2erV5nc1Ae40jTpBPvkaAtUjGa8Qa51jofkg6R8ZQGRRacI+jS175kH4jAjbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGxye9zFiZVsLLww5v6CkYxIFDGK5TQE1Q9mverAbVM=;
 b=EHufhB2RuvJXm+BdSefH7e3fabNT7p3U/scXl1xmUDupFer/2vYO8lpUEdg+cNXXuPqqifM9UXPllGV4WqqtTUC+/1gKcB0B/N1f7EHhTwIpQlBRX+tE36aiWzOrikTX3gIITYdm8T4XLwV8P6IjEJYcFJv+5rx9QIgqOPwcdCWjbpYpC+IT+kNmEA6NgASlOpDdQTCAfu2j9U3U+vcab8wDfPPg7rAhvwwojU1gS1RNGWyQ6FImPhZyBGVwAu3YkJJrV2vFHD49GO1RXHgNg2JwNVVU+YunrWMDtkt8/uBVwc7CCqjAOHlXxMJFS3pe3rahy4L8JpNFb9hpxttbPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGxye9zFiZVsLLww5v6CkYxIFDGK5TQE1Q9mverAbVM=;
 b=oAyU3jU85A0Zh2a8cUAdo+LFUI/LwX/GGVL7iHjVDFYE0WOT48lNDpd3cIw202tQCrepXHAq1WV9pOsAwCvfI98Xs9B5AuQInCSssdWqISVf+WssYgEUYBLu47dyfXHT6SH0UmaOfdtA7mP9bH4ox3FqZ5Io0zS94jsBKMzBfQWpfhV2NDFggL03HhAPRONSg26App2GiNVCvBfFzbXgfpqj47YG3Y4iQvFdq3G/qT7tErdeiYW1mz9gFucKUHrIhWaf5beM17i1fM3NVGqiT8+BVbh8nskka4UyOnOR5HxKqgNYuW1dO8lhAQaFBGEzAsixmIuTcK4JflmEYhgAmw==
Received: from DUZPR01CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::12) by PR3PR07MB6778.eurprd07.prod.outlook.com
 (2603:10a6:102:73::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 12:53:23 +0000
Received: from DU6PEPF0000B621.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::d0) by DUZPR01CA0022.outlook.office365.com
 (2603:10a6:10:46b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Tue,
 10 Jun 2025 12:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU6PEPF0000B621.mail.protection.outlook.com (10.167.8.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 12:53:23 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 336BB200C5;
	Tue, 10 Jun 2025 15:53:22 +0300 (EEST)
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
Subject: [PATCH v8 net-next 03/15] tcp: reorganize tcp_sock_write_txrx group for variables later
Date: Tue, 10 Jun 2025 14:53:02 +0200
Message-Id: <20250610125314.18557-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B621:EE_|PR3PR07MB6778:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 62ac916e-4cb5-4e39-2471-08dda81dc926
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?VWdqTlUIY3PMntzUIoWE0zjXCdw9mqoHrlFOTMU0xTUOmWQKiWnOEJUKwwI+?=
 =?us-ascii?Q?FaybgcAhBbLUyRrH6hxnpbpEwsRbmG2ATJitPJwT634fQTlpJyIvcce59EMb?=
 =?us-ascii?Q?tl+eXTCcakdGivibeTfMzDwtiQGe/iRrzsaH/ekOLMN/g/9Y6DkZ8nnDw8IN?=
 =?us-ascii?Q?U9TNmX+6DI8k/VUqx1r1cl7C8ygDj8oOoh/EXjMiGOIorQeoIiMr42V1NCu3?=
 =?us-ascii?Q?Vvwcm8eU6wksAkUkYlZq03YenwINb5f0Seb9XNVkAu0mON2aF9H08In31rsE?=
 =?us-ascii?Q?f0ljDyDj4iYH/d5Vla/fwjpDPeCoSy6psuKbEQrTiyOZy81VxyP6HiasDSF7?=
 =?us-ascii?Q?04J84wn5VPLiX4FqP+kZj3Ooyi9YORdh0pBEV+Hd9agHq4fe+832QT/DEujn?=
 =?us-ascii?Q?2w/aP3p1Vqi/RvK1IKL5eTSxeENg4bxPSpx5AL5z1do/SYamc4A56mO86hVE?=
 =?us-ascii?Q?Ca8aljQ0pgy1wmo/b9qRukxDOPR95L4ddyZGALJk5HYBUTOj7hVDug2BDI/W?=
 =?us-ascii?Q?sGSbGcS/v2oaWdraz4d/aNWlkJxsNsmLcwn/IYVkxjKJQR2PJDi+CfclRniB?=
 =?us-ascii?Q?2AAR+0HOGYHahP3U7kZ4RK7kEKGe8eg9Qvf5fApAhyKhgTcJahtezIomYKWd?=
 =?us-ascii?Q?EbGIpaZge8y5d3L4o5NbbblHM59tgeNda8nyDw+7Z+pSDUOOUWEh4YanhDf5?=
 =?us-ascii?Q?q/D6Qh1kvEPlw/VxNxoP8yO2759ZQ0pxjIT1HBGP11wO9uPNNosfBKjMDEUU?=
 =?us-ascii?Q?/ulnlIdJlB0oTs+R2LK1D6HjH6ufEJenNxAN9dZuPMnYWXo3l6B2hMlbFYjM?=
 =?us-ascii?Q?wSgQ949EO30bGJ7cLbvFazhl2+rysHtECj0NpV6tL6YBWKFjde930uRQXXfq?=
 =?us-ascii?Q?ri5TKBsQ09EH9+aCcVykdIp905SLZW3ICaseWQ0fxPEBpZ9cEGtFNqfBXaVW?=
 =?us-ascii?Q?wDSVOIrflTiTCCnPNqj4L42fIg+Zy0ra8AvLrErcA/3YYnLy9uJVacLRd8MK?=
 =?us-ascii?Q?7OTFUc2onTuKXpkvA/W/VmFOE4d61x+ovWZQWP4cBTS9G6nBorqhnagjVb5X?=
 =?us-ascii?Q?MjqvrERrZ0T7WOq2YFdJpQpPZ8ZiHuG4AFPmZDue0NJ2k5ZXyQ2VfsTSeQFD?=
 =?us-ascii?Q?2ak7SVChLa2DEWyeNSs6xYqBna5WtpT78BwZ051wGp2TMF+ltNOJKbMmoYd2?=
 =?us-ascii?Q?qokR1HForJwTEnIEJmKVGCuRUP/lnobuUsii5Q6AjaHab8L54DsA2a13/QLB?=
 =?us-ascii?Q?3+7NY/IXtNcCPxxgwemJYuxcQIupNfsxulAoJhhT4/UGA0OHPmH4OHyQ5bKR?=
 =?us-ascii?Q?eOMtHWRzF0aMickKRhM+GWKOoCPBohSKkXoSJQjF3nxdeS7m9Kb76kn+DBMM?=
 =?us-ascii?Q?bX2HaDjgTCCf6YD03ycnDyNZz6gW5jMZWmUO2nx53lX4f8rPKeGu0Rm8R2Ll?=
 =?us-ascii?Q?9OjRFMkSfDScFN0QLR/ohhjD+ICs7cisFhKp/ckoL5h947zBc2tpCgJyD/j3?=
 =?us-ascii?Q?z5VflZSlXKagZ7s+HHGg6daSM2x161AdhrvXkTnlhrZxaW7YwO6VEJweJg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:53:23.6838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ac916e-4cb5-4e39-2471-08dda81dc926
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B621.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6778

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
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2585     0 */
    /* XXX 3 bytes hole, try to pack */

    [...]
    struct tcp_options_received rx_opt;              /*  2652    24 */
    u8                         nonagle:4;            /*  2676: 0  1 */
    u8                         rate_app_limited:1;   /*  2676: 4  1 */
    /* XXX 3 bits hole, try to pack */

    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2677     0 */
    /* XXX 3 bytes hole, try to pack */

    __cacheline_group_begin__tcp_sock_write_rx[0] __attribute__((__aligned__(8))); /*  2680     0 */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];     /*  2776     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 163 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2585     0 */
    u8                         nonagle:4;            /*  2585: 0  1 */
    u8                         rate_app_limited:1;   /*  2585: 4  1 */
    /* XXX 3 bits hole, try to pack */
    /* XXX 2 bytes hole, try to pack */

    [...]
    struct tcp_options_received rx_opt;              /*  2652    24 */

    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2676     0 */
    /* XXX 4 bytes hole, try to pack */

    __cacheline_group_begin__tcp_sock_write_rx[0] __attribute__((__aligned__(8))); /*  2680     0 */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];     /*  2776     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 163 */
}

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h | 4 ++--
 net/ipv4/tcp.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 29f59d50dc73..191e69e274a4 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -286,6 +286,8 @@ struct tcp_sock {
  *	Header prediction flags
  *	0x5?10 << 16 + snd_wnd in net byte order
  */
+	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
+		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
 	__be32	pred_flags;
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 	u64	tcp_mstamp;	/* most recent packet received/sent */
@@ -304,8 +306,6 @@ struct tcp_sock {
  *      Options received (usually on last packet, some only on SYN packets).
  */
 	struct tcp_options_received rx_opt;
-	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
-		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
 	__cacheline_group_end(tcp_sock_write_txrx);
 
 	/* RX read-write hotpath cache lines */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f64f8276a73c..86872ff89a27 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5126,7 +5126,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 91 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
@@ -5143,7 +5143,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_est);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcvq_space);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 99);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 96);
 }
 
 void __init tcp_init(void)
-- 
2.34.1


