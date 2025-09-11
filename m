Return-Path: <linux-kselftest+bounces-41230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFFCB52F58
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 13:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0B897B4D0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 11:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B43313E04;
	Thu, 11 Sep 2025 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="KVBxxgvl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E266A8F7D;
	Thu, 11 Sep 2025 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588817; cv=fail; b=E8z2FFFUu/zq/pssZoMVPaf1p/P7GftwrldxxRKnhWMUC4xl4uWbeZMi5zM+YWogFxpt845uiFsSMVGO8/7kB5BNtDLpUX2PlW1LQ7fUjAnj7F6WawHbQB89p52KDXtZuZnEWVUxKdzaU+/rlAd2T2yD6bd35qN1kNAFq+4FD3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588817; c=relaxed/simple;
	bh=gLkB6wcnu6R+8ALzjX0mKL/4JMSqSN6MGrhFKVAhVjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJPLs8N5De6fFJ7OygxQihlPRVGpTyj/OS22DJo/xNYZAdQx64v5ZvY2BjZgDTfe2AsA48mQgtKRSNbrX4O6jTzkiLYfHZyhH/OxTio5Ui7FZrcaWfTXxbxQ2+VJQs8pqnisjaXzAg+TfUvEeWtl3mvmkTXqHpn6QVdiEdJg+yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=KVBxxgvl; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrvEDmSFWFRIRYnc75QN7H4hEpi0xL779jer9M96UIxwuBE+cTarPd7zSvQnAmWoYjbiGVzyEhbE5SeXmR64YG9UwmPZUa9ZeRYKw89y4Mu5bZqf3VqSIMTd7pteRVPcLltcCXkOcwIyu1fiw7TLFjEAY8VnMv6kX2O8fimXC+AKiTPt2GxixE0zVNogslV88QJ9Dqe2wH0lymrbcaCtj7iIs+hh3R0D/hRf4tQtdk0yhG29aoBjChhVlyFPCLbTfzoid8C+yZizLB65iQbzZqSexBn34RkaAZ2eH9Qebv+5HhRKNpdO96pxGH0O9mawru8TI1i7hxz3ztzimORM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfVwSbWczeSddiE83kdcW71NDfTHvpdbHXpfA2JQXwQ=;
 b=pqOvdYSNaeRlLTwCBwgeV94C4WcoV+Pbv+2xBEOu2K9OCF4ej1PwRc5pAKPtguzmPjvbEuikmdGPAKTERsfY/9URjbHAOz/nF3grrTWgEnC1RciU4Igzh2BnypBwmaYdEzU3Z/nFnPeFbkW/LlHR7r67x0HB2rkMN+DeeOr4WgGFEq6udbDl7/YiFpmkTysMXEUJWpvwj/S97ibiIDAaejbhJ7XS/XTNAuIlR5oqSoU3tsTNUOisSl7Mfqvmz8Go3sjybX8pXGvsvzpAgyQ0sVGa6us60Jgfl8jX4T6QMP48orH2Dqq8XX0UOD4ywwUZT79+osWsm/UNk2G4q8F5vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfVwSbWczeSddiE83kdcW71NDfTHvpdbHXpfA2JQXwQ=;
 b=KVBxxgvlDbUcgM4VajyrWufu8K+qLWKiizwY3ZElm3F0SqEvMb0/sERTb7aDle5gPX/ZFhr67y0xFEksY6jpCFNzorWBfhaROvt1tBba4bvstvPRoR/Oon0GNFUw6f05cu0zwQdXiiI5WG4sg5jZl3zZH494JD7q+HLB3BoW8b6omt9MRh+z72993FQ0/eapdhx0v2vKYb9mwQzMyTOcuZyr06j2lkCRbtMtIOHI4DncObrKoSPfJU3kq6xYBj/B2ouleHIQhhJonk3NZlsEkjYWOQiGHc6RsRQKZThsZ+HiNaFQdqioDBlfTNtCE7JqAU13RQ5FJpKgWzGEBrjcDA==
Received: from DB9PR02CA0009.eurprd02.prod.outlook.com (2603:10a6:10:1d9::14)
 by AM9PR07MB7779.eurprd07.prod.outlook.com (2603:10a6:20b:308::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 11:06:51 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::20) by DB9PR02CA0009.outlook.office365.com
 (2603:10a6:10:1d9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Thu,
 11 Sep 2025 11:06:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13 via
 Frontend Transport; Thu, 11 Sep 2025 11:06:51 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 0EED0202A3;
	Thu, 11 Sep 2025 14:06:50 +0300 (EEST)
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
Subject: [PATCH v18 net-next 03/14] tcp: reorganize tcp_sock_write_txrx group for variables later
Date: Thu, 11 Sep 2025 13:06:31 +0200
Message-Id: <20250911110642.87529-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9BF:EE_|AM9PR07MB7779:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 867e8759-742a-445c-0e6a-08ddf1234f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uki3VloP4xpFBgszlo27avqzKYXCElanvja5srrDt8JxclOPL8NFoGlgbqna?=
 =?us-ascii?Q?3OhxurkcYIEqLrmsu2EP8Ydp542WyKCsS7fqjJ4TAhHP+NXMMVPu56bMD5OP?=
 =?us-ascii?Q?Kge/U3xlT14eYiuW0/nQ3B2gPyHe7kvUjrL+zIua2WheSu9Ouo4egd23zLb4?=
 =?us-ascii?Q?pkSBaj0sPssRG41EB3cv0gFp9mvp0yHpDZoWYQ842u7bzO5MDocjliUC0L0r?=
 =?us-ascii?Q?B1GYATOzTqJ5xrascTCGlAcrMH8aVWzbwcvYUdSeXSeRB3O6Q01Ug45WaYUW?=
 =?us-ascii?Q?OA3GdKPkYnFtQPiLEeks+7f/QxWmnmCWlZ7n4hqCy2S5fz8ubFK89E7DJr4Q?=
 =?us-ascii?Q?56eN0gQC2DP+IChH+gpXav25PAX+Ig2VCB0AI8B4tgjH2c3FEr6cZU8sPHz0?=
 =?us-ascii?Q?cDafQcN3wN01LyKIfjfzqR98twj1jL/26WVWVjW6xZIUxR+/u/bBuJwW9S31?=
 =?us-ascii?Q?V4lu8RJw+ll96/V7nEX+La0oQ64SVCK/6SXNUg/I0xEEr4cCSjzhUriw61Fn?=
 =?us-ascii?Q?KqTUbL8p+8xd6yBn6SvYxhzFX1yFDjjgKN1NOFAUlp+/zw0AtiTNoRSdl6gv?=
 =?us-ascii?Q?k0AAIECQSAjA0gHyFDSnEeiUYo0nHNY79Y3okGDQ+R1Ah4rwv6/03nBbVC8E?=
 =?us-ascii?Q?3t1LgkcdtwLVhP8z4JEbmrWhUwYioobV6VFUN5UGgfvdFc5eR7XQTSLMCEN3?=
 =?us-ascii?Q?EzFzbfHTsIOnTMH012WPNV+HRrpxp+6sALwPzWXDU/tdgHW8VXU98iPtMwRW?=
 =?us-ascii?Q?wsNrrO/Hhd4P1F3kpWzQdU+JPvdXit7ny2pSStJ+Bfewis77zYFh06b+Rezb?=
 =?us-ascii?Q?/8H+cnAT6GvMvlG4eaPl8vpB4Cny4UFskewpHleMU29A7KfWdCm3K6wX/GC5?=
 =?us-ascii?Q?Fk8Vhwrpw1fJVBKVVSc07nurR3qGzxldsKIa/TR0EukBPSo/+6Y6VuQg2Boe?=
 =?us-ascii?Q?6pp0SQs8BbIIMC1nfSxnJpcLgNEyT5SWDjNuktm30CWip4qq4f8hK2kHGbus?=
 =?us-ascii?Q?5rI/Bj+15KfkjMb2voYbv8SKq3+sLuW1WI696v4ADtdTziI/SJKXpx1XnvDU?=
 =?us-ascii?Q?iG/GMzG72EZQxnmD4PfA+NVlupNkTszhkv3RDhO0gfQkFZJiSfQiillFcGm7?=
 =?us-ascii?Q?Pyu8vAewJ9tHq5cwA9mo53LKg5heYSVJH5m+K72qsBlnqhkM6apbcwiNw+Kl?=
 =?us-ascii?Q?tLOxS+cod6Dc9CFq+UOg1oj23FkGIawY/Ua15L6bzYAStXivF4PsYbeNAvZS?=
 =?us-ascii?Q?lpX/yA4WLSaQIWsHkFp/GFeiacR4sCDzWZofW8cCW93jFn7lWQkPBZaJ+mQE?=
 =?us-ascii?Q?Op7HNGaU2y0agELKnDS/Wne9HRdXVEnpsGdxaGgLCaxX5hbbV/5lBjVw9Mrm?=
 =?us-ascii?Q?ZfeA/Iky8VGWg1Vvs7Itmyx1RgqP9DYEeqPNp+V90G8k9SCEsuBzPomKpBoJ?=
 =?us-ascii?Q?K8qtsPc4PzHAQEk8ZzMsfrr3KU62Bo+IRyh8/FFhAyu8/WhfVNV7NtcoioqH?=
 =?us-ascii?Q?w6YXs8uy3SVtnIXu5hh2ERus+2pydMSmZrlu9C2an1R6v6l1/J7OvOCcLQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 11:06:51.5763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 867e8759-742a-445c-0e6a-08ddf1234f82
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7779

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


