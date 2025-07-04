Return-Path: <linux-kselftest+bounces-36519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E23AAF8D2A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 11:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50AE5565C2C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 09:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E882EE5FD;
	Fri,  4 Jul 2025 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="aE1iyT+t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012043.outbound.protection.outlook.com [52.101.66.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB292EBDE5;
	Fri,  4 Jul 2025 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619321; cv=fail; b=d1wyybGvepblOjkbO9GZBHcG/yV+O/4jRHQv+p7vqJ1w4TB7woi72Q7vZTtql/TSNAMETwdSD0aGQwB2PnAvV2gA+FLfcPzjPWkZhviCnDpVKq6+iKvtNouJl6bAS/apAfZgNN8a1Gv5rYGdV+cUgzUNy6NDRC6V/slb9HsIrpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619321; c=relaxed/simple;
	bh=InicG2r8DcNrHUWqnq9mW/kSZ7b1H0mscWTTKAmq3Ts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCklLyifRs4MKfYlyVJhwytBJEs0IdD9YohXZWUdVESp2wSKHjZ85NcYeL1291rt1Bu2f31Q4c4NqYT//athrXUngmhGp2ZolQOHuv/K9111F2rlcPKc35VACgiqAOluc31aVm4ZGNevUVkO5bc1mEiYGclTwve27vFbR+lpwbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=aE1iyT+t; arc=fail smtp.client-ip=52.101.66.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZI818GZh9JTE0+ZO2jIxutn9O2vLkKCOR8/vZm+xss+TvjUOE779JuvanAXutPnSyOQylLrECT2DG5Qh1VWWMq7zBTqlYe+sd58IaIjk8g3fb3hidRSwbnG9K285ygqRGWtu+1HjgK1VV9UsILRLGwmYIVStY1kQ/Bavk7F73ZqoPElKAvjr0QN77cmS8h15gcUtqdFrCHBCQGDRoy4OXY/PJc3kgEvCe39Hb95zmILz9cB7wnAzfORC/UKgeJBz5I7FiZnBNs2hSUGeC/Xogb4cYb9VqUUNFWzgZWeqj3eGCeZ+AUvLaQBD0zyb7Swd/488GHN7ADBSp5xX+ZtF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dv2dgs+jipuA5JMRg6udlVfPlwEJHfa5mcE0DJv4Z3w=;
 b=s4DcDjC/w9ToJoeqBaQ5qZgGVKx6usxFHAXOEMHfGJ6xXPvZ/lvcRM784O1vkfRN/Emi696rNeQJgT+VxiGkQTIHIKkpzVqrxU8Giglx0tOWfPR90+JBAKumQVWmeai2VD0Hc5LztrmXMjp3kNi6xbcziOeF/taL0SxsneP6ChaD5ZzkqmWy1LaC1aTSnQJgDfBvaGjGN5zlQgqiczitjIy7BsnvDW7wSiUxxLP//qPsf77wH77T0GBS6cEsGcEeJQ0c1BTicZ7zTZvVJFc2uZ+iGiTutyaWIODtlNug/Vsq1pu7+QuNaRX/iJHuwG8XWIlgiSmlF3JkSinFCEYurg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dv2dgs+jipuA5JMRg6udlVfPlwEJHfa5mcE0DJv4Z3w=;
 b=aE1iyT+tvguSUwqJ9Mp5QAfPil1WzdlaoDC3606BaCmKemLQ1clxGgKtlQEeibFEcx/rbewaSs7iIWsVhq8+Fk4EcXMT7zrJjE8KoTyWtWbRylj/g/ZhQhi1A4CW0/QXbsz1WQ+nfs+wDXgiKGOT16VoOCopPNlRLQUMaFxxEloZUEYZgZ2FSVMO4qPqWj5kRMHPnC6n/F3swlOVD+PhgzIpKxD9R+2hjR/d8C8lDgIT1NBV0Omxt6kYb2oBsuIKy+KBljUx1Qpfv8uwsrhIhysCoOw2dpnfC9tIyj+ABmMNiIdoy4kH1GOvr7oJD0xVrXbRidv1cKLoM8cCEsCEfQ==
Received: from AS4P190CA0020.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::8)
 by DB9PR07MB8821.eurprd07.prod.outlook.com (2603:10a6:10:2ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 08:55:13 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::52) by AS4P190CA0020.outlook.office365.com
 (2603:10a6:20b:5d0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Fri,
 4 Jul 2025 08:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20
 via Frontend Transport; Fri, 4 Jul 2025 08:55:12 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 811CA20138;
	Fri,  4 Jul 2025 11:55:11 +0300 (EEST)
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
Subject: [PATCH v12 net-next 03/15] tcp: reorganize tcp_sock_write_txrx group for variables later
Date: Fri,  4 Jul 2025 10:53:33 +0200
Message-Id: <20250704085345.46530-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5D:EE_|DB9PR07MB8821:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: abc03d13-d979-4578-f42c-08ddbad87d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z53nTckrhPTL9zmmGR/EMAreUEmoUmShfFxLmzLxMMTz9o5Z9Ufukih/ibvB?=
 =?us-ascii?Q?RwAF2c08ktxnwHHDZrfDjbwOlIRtTPOADfG4+pb/GWaui/rrbY6NpqJxLxXM?=
 =?us-ascii?Q?VmMAYEwRnzSM9ZqfjQ/QKgeyF6HA5O9Z4Kmy0DUscddqaVVL1mNlKU4T3RTv?=
 =?us-ascii?Q?hVjlD7oAJBfRhoksfnvcmD5gL8WD3vLhXNQfjxC7TyWaZFNNsvRYYxD/V85j?=
 =?us-ascii?Q?bETQKGE0RJPWpohv61KybkDEHrR+YDXr5FLZwtptnsZMZv5qpdXMJDndaHCB?=
 =?us-ascii?Q?tJi2J/GbwOqVgxZDZHEtGm0lUr4n8IT4ArjGOOX7YQniXDCpdrtsgCif0BAY?=
 =?us-ascii?Q?pf/HTEH1DWRlKsDQenhQ7JPfh/dYFMRKnjQksz2kog1JkcVsiuQcQ+8yk0cg?=
 =?us-ascii?Q?lFYa5cCJruNvOa9pA4uIp1eVMRcol+a/KGSpM1+NtBlavHX8xagqVT/RPqpO?=
 =?us-ascii?Q?zv2IuGzNy9Brclg7T3KCzHiTuqTRSfaCv/W7+R/mT9VIA4ZeEHgbuO0NDjCR?=
 =?us-ascii?Q?Th2Zpsei1U4oZ6NP51x7V3fjOEFQ7ieA43VpoC1WOAfUgboTALnf1r6tBE3Z?=
 =?us-ascii?Q?A20nWIX/UBcFB/PTplRB5C6FInBSB5I3Zdw1cEUBmGtzDs2HdsnfEecOTQ2S?=
 =?us-ascii?Q?Fwb3uOIakzLv2OeZxAkgip3rQbwehcWxDa283AqTmtoOXqk9a+rTx9Qhop+6?=
 =?us-ascii?Q?XmSq8SELmWSptyr34hdqrsLfc/Pu8yVzovJRwD26SWTxAMND/zfKD3MTDS6d?=
 =?us-ascii?Q?T18gucdnuC1GfY5ahV470AhqYeGo+jOE5KDD2Hc1Ldve6/FraunVhwEuxGCt?=
 =?us-ascii?Q?0+nvoolGSRM/X8Z/2utg5dCZo6AmSaTrP+tQduiThDeh04dSmmJyn3+IN4zc?=
 =?us-ascii?Q?xaL1GYG6pI9+1/FEnh6yFqcQ7+csLJpVMtStasq01gBVZY0dJY0wqzctRxdj?=
 =?us-ascii?Q?lx4U9/BewSWWhhscCBYeFxXTUomuuQoW5cWEDKjZT5UsFC3zqmU2Rb0kyTrq?=
 =?us-ascii?Q?KVvqfTVq6Xo0QANoXbSRcZILtgnNh275dfBzleqHgYNoIRvJqIVGY7QawzmI?=
 =?us-ascii?Q?skn8yKfs7hlSaIt5zXi2f92oJ/RJ9kLyi5NBglf6uMeumzRM6i00dDIOeiOj?=
 =?us-ascii?Q?30KcySBdw0X0oVV/loGtS76ZdXLushGHBmNEYCM0Tan9C6aax0EZfXIwhmIv?=
 =?us-ascii?Q?K3m2zCR/muSAQzVkgbuPp+A0eLjmTCULWV2uUVBra9KLCFJqu5WRDTS43EIn?=
 =?us-ascii?Q?daWQvexc4nJNdyxS4GvIuFBW+M3PQf/Z+LJS3uBOiCR+stdstA/MmkNn2agJ?=
 =?us-ascii?Q?1CHqE4D0H1lmokvDbeKpmxJWvBjDXxMtbZXaY7UYRKqouiXNN8EUZmc2PmFG?=
 =?us-ascii?Q?3kbxienVZ7fG23c60/L/a4FEE+vzGmaUOBc1wYudCzbZZ/HBrzKIp52R/Woa?=
 =?us-ascii?Q?RHT+wOGDpWiiyJrAkoRCdS9sCn80kuc8uBKCv+J/MfxIYKUa7Mbp4XghUqE6?=
 =?us-ascii?Q?AR+x2pAyzVRz4dFInOAgd1fLTzVJ7t3ZadP/SLpsRk09PypPdZUahpX7Gg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 08:55:12.9748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abc03d13-d979-4578-f42c-08ddbad87d10
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8821

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
index 925b2c572ca2..ef5574795174 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5123,7 +5123,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 91 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
@@ -5140,7 +5140,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_est);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcvq_space);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 99);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 96);
 }
 
 void __init tcp_init(void)
-- 
2.34.1


