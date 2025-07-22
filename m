Return-Path: <linux-kselftest+bounces-37814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3093EB0D686
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 12:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE4954845B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 10:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FA52E2667;
	Tue, 22 Jul 2025 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="FSsJp07G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012008.outbound.protection.outlook.com [52.101.71.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F7F2E11DA;
	Tue, 22 Jul 2025 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178384; cv=fail; b=JN25yjVGbOu4icL9xn2LCFxz8/goTmoVA3XAjIo9uNr24yGLTMGnIGM2fk/tmt8yNWSzxUadCzBAi3+9w9h5Q2G2/4Og77XgzIz1mpDHp3noG+aBdXOFKFnuh7i96S1Tmb0hrFOCQFY34mJvSm4xIUXLKbnJg9EpsFBi3/l2OCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178384; c=relaxed/simple;
	bh=iChWke9gPkgAkN+JCtQatnwMWT5cv0uZ+EsBVMCnhPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/8Q6lUtgJv0X0kxzhtFXQ+Sx2bIUyJtHyr2Pk6g/M4YjpAiEa3QLlLd19kunh+nlNICFLZy+RNt0nypTKA7V5gCqfuPOCOhYYzzScYXFa8kCKsQl3c9zfZarmmhlJ9VsYZQDitNWCjhag6vEH45XabfYP4Ku2cbSDJk3BPA/oI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=FSsJp07G; arc=fail smtp.client-ip=52.101.71.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STGTBPhec2vaYguisfORiRP+vyZsoMHrcApdgqi7iYLp9rE5RonkjmJE4knXjuIeK9Z5ftMwPYPKg550Q0mL3/8gddMjfNjUPhfh1jBbquAXq4n0tXLkdeG3vIf0z5i6si11xSkKlCejHWwd6fIA+ZNWEznEbTRwIROwvHnGEMys+1mTkUBQMET99MHh8vDlvYhYsatisGjqCWUwA9MW/rqY8ZOmIUkGNU6q5XxafBTCyaViqLO+CHc+PcAc+Ny227uAJjzuMUvUsPPP9ZwpExU7vHuHvRzvyVVkqdWmjkXqegZleVsPQy6q3tCPiajEcDtUL/R3+uBYQV+ICchjdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXA5nzFY0p0rCQRv460PTQQYPAWtxuUt9TPNRjfDtnE=;
 b=hYbwM9+ux192dL3eDzk89ipdZc3xnSIzokoH0CXkVbbX/0KwD7uutM8w+qFh7li/ZZ+9FLTp0SD+fg7LEIQl687r2kdAtHgJ7W85o7ZzTCr+S3B49XykyN/poHtq95ITAFZ6xJRYljNOP0tpQhVsW+pQvnZDHr+3Hiwt+k8fUJmaZJIHiuOD/lBV8S8arhAPmRSECCIsvq1v40AJuOezx7wbAp7SkRFLl+Pv1diUD/s6jtdkUS2glkWe+YCmggEiu57kpeAbnTgRYXTQjPWsSfu2MLBSuHV5DILhXKsrQtiAmOWgEzbb53VRULX2rwSAoel0fEBee0PRzwqZdQ2dnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXA5nzFY0p0rCQRv460PTQQYPAWtxuUt9TPNRjfDtnE=;
 b=FSsJp07GRLQeIvOo3l3Y1xbiWpLmjxyLI79tUu9k49/q6HWqnhHc1/5NOfYZdQkSHQJsTNlNzPJ/vgF+aVDwolkS1yUwcuQC7jpUWq+d+iiwwNAlsnrPdzKpbqHnsClPAbXmTxLpHPA7xVPKsYbcCkj4FqHyfr0JYhLQIQxVnMk8Ss7Wcq7N+lk9oFpuqddrMuzG+UC5FyNPgYJGYOyoPEVQ0Fi+/04OWY0ST73yviKTnN5dJp2sJTQoOIL6fqa2zmKFQEP3vymbtXGku27TNy83zBV+1bvF9L8UpkWvZuv4Hyniv1JkBbFrEhh6N8++QfKx0M1R+LjRz6RGKB8bOQ==
Received: from DB7PR03CA0082.eurprd03.prod.outlook.com (2603:10a6:10:72::23)
 by DBAPR07MB6821.eurprd07.prod.outlook.com (2603:10a6:10:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 09:59:39 +0000
Received: from DB5PEPF00014B9A.eurprd02.prod.outlook.com
 (2603:10a6:10:72:cafe::b2) by DB7PR03CA0082.outlook.office365.com
 (2603:10a6:10:72::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 09:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB5PEPF00014B9A.mail.protection.outlook.com (10.167.8.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 09:59:39 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 2F21568002E;
	Tue, 22 Jul 2025 12:59:38 +0300 (EEST)
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
Subject: [PATCH v14 net-next 03/14] tcp: reorganize tcp_sock_write_txrx group for variables later
Date: Tue, 22 Jul 2025 11:59:20 +0200
Message-Id: <20250722095931.24510-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9A:EE_|DBAPR07MB6821:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cf250b21-2fc8-41a9-26b2-08ddc906793f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L4OQ4mtgWmVs8RIhWrr3yqKJ5uyRH/QBH0+EWsci6v3pAvyPPzAUMVZ/3NgU?=
 =?us-ascii?Q?CaK4Ai26lAA/wDQ0fYrNBacN6D66oKu5N/oIKcEoK9BRLNqmize53Pz1ZxS/?=
 =?us-ascii?Q?PdbWW6XpDH72ONF4JQeeIOmTcbgB/zh24Rzir45mIPg9+UE+AwLybnYgyujh?=
 =?us-ascii?Q?7VB2LyIIcYhPNv43LfM93eEdc3XerkwDLcAICV/Qj4vW8LqFi7xRYyZFOXfq?=
 =?us-ascii?Q?fDOr50vor30IDY1MihwLyOqNqu8ysNPhDmRoTkk5gTRysMxSUofCQfUhiS5F?=
 =?us-ascii?Q?yZfEgxrKm1VyltthmZAr+2K0KHhtG1zgW/8burK+bT9a0l95/yzZ47iVybCy?=
 =?us-ascii?Q?n4IfpGDQqoWSih8MkxTYWvnwCJH5Ywpegk0JrALJNHzMnmIs1VH34tep8ue2?=
 =?us-ascii?Q?h27vvY+EqEwbqFHVpVXSIOqEETzspVFsOsd5PUgB6zy1ov1RNH/B31ReOgnR?=
 =?us-ascii?Q?WswJsyVf+k1SQe3czRWmMaPNeIx6xydQ8y/v+xuD6B80+X3cCycnKKoagRa7?=
 =?us-ascii?Q?CoK0h9Wo8hRbRB2PWLQOdnxsdjI029MWAyACFCwf1+CXok6GD1aJuuAvCnqW?=
 =?us-ascii?Q?5OS4VYkv/GGy1WlWLGWsSlUT0ATwYdJCu+GtBzrOrbl1rp3VGzJ6Lv3h1VDN?=
 =?us-ascii?Q?ruWKeRSeKqzkSmxEnAUupJ93IhT2zpq3f7VGA/NBErEEgCPeSSZBFBF9HcrN?=
 =?us-ascii?Q?+txj8PS8q2/WgigOIaHku+XiPx04OQTSGitO5eulOiqzcAPnL+P3Ko6M4pu3?=
 =?us-ascii?Q?rfnrQ8G4ASdShkjEF+/CiaXWOH1Yr2MVO+CHQ0fZdifyqGYonP1xnHi1nHMS?=
 =?us-ascii?Q?xj51WRuO3PtlHfB3QcdDEmR4A4fLifukaorJtcfQXBK36AyaGevnAha00SCH?=
 =?us-ascii?Q?dfcSqidmkZTGC/Nqmo9q6YHc5FXlr3ryrevhRzSYoBOWTvf+9FBWKH2h2vAG?=
 =?us-ascii?Q?OPDoKEdiG9YMdWyQNKa2gM96KJ+YCERBtl5WqYZNbbqhHGI466WHVBRkf+A9?=
 =?us-ascii?Q?Oj2rOYLM5gka2oihzz0vS5tUpu7adlOvjHHz+gIPY1m55VgOqXAmHvkysaTb?=
 =?us-ascii?Q?3/PXiIxNvPdnwGZ5EBw8RYhRuHXul5R6+QRRmtikaMttfhF5AYPmpkGlus+A?=
 =?us-ascii?Q?mYUwV/Qo8yA5JP/inFMtBhy66wybYGeaT4IbyClF9bGCsgJR0Vl4bSuosZxZ?=
 =?us-ascii?Q?uCQuR3Swn+AWFCyPwR7GcD0PxcL6437xw4xEYDgXX53hk3jtcbKsKHE8aNR6?=
 =?us-ascii?Q?vWaqdrX7hq55limoha2r3ark/w7XHDKDfDsCobfVcu7JTsJ4nWjqZgpODVkd?=
 =?us-ascii?Q?CY2uC44+sFvvMZVzg8zVZkqrCJ/3/EJ3AgXVPJM+tfnRpe4FjAjjnOUHhwMv?=
 =?us-ascii?Q?P+9T/nORoFQ5j6CfLleeqUGGynbJiyTrFu/fZ63+ZyLu8NbaduxkIKFufWCJ?=
 =?us-ascii?Q?3EnwtapQxyXtGSeix/ypHn+gdhcbWDv89kfLhylFEqaHOYpkx9FuNOg24dNi?=
 =?us-ascii?Q?SlSVSDZkn5ICnua1YRP2iBXGUGvv8CKRmT5Oxv9fPBZXsPLDbTjzzcyDDw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 09:59:39.6848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf250b21-2fc8-41a9-26b2-08ddc906793f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6821

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
index 71a956fbfc55..6fc127271983 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5127,7 +5127,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 91 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
@@ -5144,7 +5144,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_est);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcvq_space);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 99);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 96);
 }
 
 void __init tcp_init(void)
-- 
2.34.1


