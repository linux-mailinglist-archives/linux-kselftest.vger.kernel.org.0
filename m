Return-Path: <linux-kselftest+bounces-37568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B5FB0A61D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 16:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0873BE9A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 14:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455B72DCF62;
	Fri, 18 Jul 2025 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="cF/LD/nR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529F22DC333;
	Fri, 18 Jul 2025 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848457; cv=fail; b=K7vHuNyM5AT2i0LHQQoHn0R0KzfutbS4YXF3X1988SfTzkL6sMh5ljSuKw9XzhdXcCno31+pWoG/euyBVNiIAI8R9H/KfhmWH0w57oRBj2VncWiLei0oJepyXF3RyUbPjK1nS9rLe3SUTCz/L4OY2gI6SVBgWVE3p7Y2HbrqrIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848457; c=relaxed/simple;
	bh=T5Ec0yA/IjggEMiiYDma1CPD802IPDmZ9mSgQakPf34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOYU29jNPKqexM3MeCPVL1uLcduN2nUcjxaJYzP0qGvLwMaY+dx9Xt/0Fme4M79rMLFlqj6serRL7dW1FEKWu+6qem0XY404PGj/lXauEEwkS49AZQIuuuKC2/Pea4WzffDlx363uhAMaHh6VceWghWWfDU3YtOkIxvku9KxB9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=cF/LD/nR; arc=fail smtp.client-ip=52.101.84.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3AbOJO6IqjLG5jM9aAB23J4N88DSXmeXiRaEYnx7hO6EKoa/CyaOPfRKv+OLgK7dt8TAa/UwurTZT8dGkPJo4qIVA2Nj3OivMjIiw9XwOaUkahrdlqqPlOVLJiBuSnd/bKwQU3E+vm4W598akZ2pHyZVt2OkriCitBlk/KFeTKJcBkvATBP85AUPplv5IU1gtQuYSujVvg9dAm58kvZcfefG/mORejivqj7bAACnlciEAm4OE986DepJeWhF6A72kwlc1kZV6+9kcMoVilP68cCfOy8PDSfqQdaq1ad1pIioVbbT+ciTtt2o5NmIAal9L1bNxEh1JUdoapTHynOCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1E60UUe++NG06aAujX6nEvUmnAHzo5LwpKkj6mVMzQU=;
 b=GEPvJGr2YI1BaMuCURP7QXQ/vFzuOlGWTWzMgRCz58vjeGRUO8AOGwwwCzbcS5Zd/8ZVTo48dnHfX4zc8sm3x4t1zYQWtFpieknGhfp5SoQ3oKi+rnVk4+f+Ibf547mVDelFoNr2nFWuFqja0WIKf4cRViHXt+IUjAsk3brW6pA4JUBCqdy+rsHHzN41aaThY75xRvQt02VhUb09ghpWvBfIFxA/5ui1rS+OY396e/pZh4BcV0MpXljrePDrA10W8w4yX0Dwj4baRT7fylehy59BiiCxU9brjmIcFz/aKVNGbfnANvdupg/FCfgPi6x9vM5eMsno9sXQsDkMbxSZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1E60UUe++NG06aAujX6nEvUmnAHzo5LwpKkj6mVMzQU=;
 b=cF/LD/nRr0HBtye9dMA8hH8mhJaNQhHX1EVVehtx1SeMTA+jDel/jydVt4FnlLEmRMwEYn8EQm85fF3AORTEGJhpqYZUNr91gvpzcvZ4fahu9RgGZMVwo68mZGEYM9vpYVFSyIomVNPmatJcK0Hbg5Dme8i8BSm7ySVJVB/JGWAZGOy9f+yXMfTeCfnO088iyBw696C1y2iwNBNHlDF1hdnrPkOTFUYgfdDWnJMWrK3+i1+Ia2mo4S+vNAnrsFzib1+pctobG1Mxqc1IPdskg7BrEyLFqwG1WZsZTLUOMp7G/hl5/8ZfZZwaI/1v4Yd6OZxMJ8i9zaH2r+VhHVID+g==
Received: from DU2PR04CA0028.eurprd04.prod.outlook.com (2603:10a6:10:3b::33)
 by DB9PR07MB7193.eurprd07.prod.outlook.com (2603:10a6:10:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 14:20:52 +0000
Received: from DU2PEPF00028D09.eurprd03.prod.outlook.com
 (2603:10a6:10:3b:cafe::51) by DU2PR04CA0028.outlook.office365.com
 (2603:10a6:10:3b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Fri,
 18 Jul 2025 14:20:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU2PEPF00028D09.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21
 via Frontend Transport; Fri, 18 Jul 2025 14:20:52 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 27A9020119;
	Fri, 18 Jul 2025 17:20:51 +0300 (EEST)
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
Subject: [PATCH v13 net-next 03/14] tcp: reorganize tcp_sock_write_txrx group for variables later
Date: Fri, 18 Jul 2025 16:20:21 +0200
Message-Id: <20250718142032.10725-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D09:EE_|DB9PR07MB7193:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 554cc65e-13b0-4785-c234-08ddc6064d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ISNb8p9D+JaBB/tOzARrNFIEZ9rtaxW9lZvvmSfpMf2JQOA4AOFh7DeUIfUb?=
 =?us-ascii?Q?fvMIviuW+hGZOI1gaafv7T68qy2xt4t0VxgxLTkqXVxLGQptUAHDDPRvjdE3?=
 =?us-ascii?Q?z8wurs8sUuge8c4JbzlGSdp0N3m/67dgRhzXDTLiG2wx+TtjB0B57YyvKXXP?=
 =?us-ascii?Q?8WLrB5z9wcxTKDafy8rtcTEU1RwAb8hd29PeGdLITs00pZLKjGvabUowarwH?=
 =?us-ascii?Q?w4YlpOlXPWcUwW/WHFQu8JZ/7Rl3B9afKgFMYq2enBUIMxCpBcARP7Q2pexN?=
 =?us-ascii?Q?4z3F9NS93yG+F1bKWE/g5o0P93+Bjv3Eh/pnlH8tLoFMRlLC77NjMyK5QTLj?=
 =?us-ascii?Q?qLrmJUygrLKZxYPsMnSUkuBjcT/SHwmix/75hkr3yKVO6woztLQksrmyBsMq?=
 =?us-ascii?Q?HRe2AOlUUXvHP3/IZOF8vNbL75CGPX6E8u1LEcvr9BScDg+pOPNTgtrVhxBL?=
 =?us-ascii?Q?m5XhZ+eZ7L25Pg8x5pqPCbvxWds0RoV+x1C7QNuBMQxXUujk7YKBwQl7bIT7?=
 =?us-ascii?Q?DE9yXkcAb4ynE+5XDz8542NAY2WEaHbZH3IPd2gbESq5WkfM9Ha6pR3ewZNr?=
 =?us-ascii?Q?wMpPOi/eANNgfsJlVc1NW6hXdcaj0O6x2Qb7X6V/jIsshxWmIn7Inw9WD+/F?=
 =?us-ascii?Q?Jth3KEccJG2fAmerCeW+butzLsvsV1xuwBhNE2DhE3d/gh6tPz9B1CkJkrpa?=
 =?us-ascii?Q?gnaUqJm7asSLE7h7D/130Me79lEp1ljaCvYaXO0USBSF5UUVovR+FtNoLK0r?=
 =?us-ascii?Q?WrvIt5ju9PJNIiNXhtGyE+Xce2EBtStzx0JC/DtyH85aRpYXGM3U71hHuumV?=
 =?us-ascii?Q?qVi47ZlWeiJcT2KLu/F71YzG1gxJ+/Meex0JbNd5alj17caZXb5vm57lrx1F?=
 =?us-ascii?Q?CM0YGej8cqRqUzazILB22Yha4cLi5fNIM5iKktNvUZv8vBeqta1J3JkHjQqo?=
 =?us-ascii?Q?fU5eDyCj7eSzcVltyC2QE1pZjjpNdyGgYpv0wXlpYYTF4gjAt8NvrKiqZ74x?=
 =?us-ascii?Q?JWv6vNmPJ9oh3KyqInrLXo6SOIm+F9IhmQ4POBeIHnifpmyAEUNSVCpt3+yc?=
 =?us-ascii?Q?xvwuXpsag6l6GEutyxCoBntXB64/az2mqTpSTecfju3m6TkY4IXp8mGFWXaT?=
 =?us-ascii?Q?O4eKKxwHDez3Vl/bIaYf0hfhTNZmxotZWsP3FEBnq3LgMWgJExPc3pa2x9mg?=
 =?us-ascii?Q?iEWgWUg3SzhGm81bD5C4WjDOHGkVxUSLj//stCXraFTpD8y58W1kv7HcLeqB?=
 =?us-ascii?Q?czFbfarlP0pVgEabSVTSVDxy15p6yy2v+5Rtj0qsy5ndAvvrK2o4Tc3GvFmA?=
 =?us-ascii?Q?rm/37UknwYZKjhxahc0ripMd7cplqmC2YFqJ1Fav94id587iZrIm3mDNpyWt?=
 =?us-ascii?Q?za1Jr0zml0cAAgX1s55MzxpHgyXjusWlx2HWdxdecprs90TkCjSQR0dSwAYm?=
 =?us-ascii?Q?34gLXH+RSF5du0yXzasqhx5zVDXt+JgWOtbqUgZMDDGGyO/5N+SyRaeCMs+9?=
 =?us-ascii?Q?8F7wg0BdBbhMydeKEAmf1RB1jgnGityJYvupQGL4pX0XXFKyMAmGNWyHzQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:20:52.6142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 554cc65e-13b0-4785-c234-08ddc6064d78
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7193

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
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/tcp.h | 4 ++--
 net/ipv4/tcp.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 1a5737b3753d..bd692764d039 100644
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
index 31149a0ac849..1a80d1b35d10 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5122,7 +5122,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 91 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
@@ -5139,7 +5139,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_est);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcvq_space);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 99);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 96);
 }
 
 void __init tcp_init(void)
-- 
2.34.1


