Return-Path: <linux-kselftest+bounces-35554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8470EAE2B99
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 21:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9191898D44
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 19:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF1526FD90;
	Sat, 21 Jun 2025 19:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="OEH5ZpEl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD5926F463;
	Sat, 21 Jun 2025 19:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534675; cv=fail; b=kGaj0PID9veTeKcBjs+t+21KusiPwLlUysj8mSHIO3tk78nMjkQ7IyVXBOCvbzYEpuLaGqQJfvq16edkxL+ZKfMuTwGL2OVLRjT8+VI22BvbwiQPMyxJ6OgygSSazcPsfPgud5UGlBgLg05tVvHPiVyMhJ5dpVXSr0iFGX2rMKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534675; c=relaxed/simple;
	bh=nDf/yOa1ufj27OPz3xTq2SQ8opaHPEkpIDkB9/dTfe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Se9VpDk/OAWA9XhTVtjJ9X/eFQkTyOp7RxV0PeJhJbx5SLeTTf8G6uGhiVpn6aZjAuFzvXr4H7qIEu3Gfde5OLobSMnuutbFMJIlJU2CA68w1dL6nx0X8LL9w+g68bcm5/UgEBCW8524KYEMBH1Yq3m7l7s9Cz/gNxXFWArlqo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=OEH5ZpEl; arc=fail smtp.client-ip=40.107.162.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQVqJbfAmhG0jntmKIk8qoiDDtRRi1wpTpMGkvNPuWKSmb9iYCFMnbyPbpK28lYuFujxSmU6PjpNEuq20nc1+a8Jv3/RZ0BTfuf2Yz1Rzesvqziq/PpbVjEodII63UW/QA78MFRg6ixepVRWzdm1Sg7A8R3DMXp1YISTisaaLnUdpaU4IKviqbqVnI5Pv/4m3fu1hvhEuAS21gFyD/fPB7Wsi027UJImkbqsgqtCPjpL2ba9quSfFvI/OkgKRcVgkLtiLGfuOY7yaTplckrMUhpBsWNBQ327Rjg+6CHrIy70RsBYdVtzI7yv4H7m9MSAYbDEpWMeoBA1skfT3jAayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLKPUGHLRtyswalpXa4p/tr4f3oQ7VtfziVT4i+hUG8=;
 b=aN8octbXj5ldfquugrYEQmdyhtCrUhvlyr8hCzy8IUazeiNso0qM2YfKEUw6xWCBNd/Zd6hix2KzsKqNfAdUV3ku+gkej3oR9/6Elz4KQyf0nxHzs6NKkJE+rnZkTx/cn+GBij4TfnU8epTalYlBK/7KWWXLMR0UiFQl0tPLQ8zotPEWXrNd/rTy6rDaoyiCRCZ4O4hTR7aKbFuwD3v5ZcEzT318nHG14rupoD9QP13tgBiatKLKgPqt84GZ3zaGY1tBrUG/+frcGahwyPXu1tbdCL3hahlvowdpw24XdBIC37I37/NkYjljQhM6FiZ5OnjRM+lIPajd6CMml62aJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLKPUGHLRtyswalpXa4p/tr4f3oQ7VtfziVT4i+hUG8=;
 b=OEH5ZpEl+CBTD+jXZeI+IYB9ciWi1U39xlm6oG7DDSiQWkVTrNJLFhoATdCgKUwguiU7Vb9UaeXtMe7HtEtqP9W4lE7PgUkcMp2bv6ahofhsI4pnkvN2pwusWTtbtZES+PgyZAIUowX3UQWEgwgmlZu6e0EzEvD+wp69cJoP7o6aIQdcsggVQeJ39Hp55wdhkr7wWf9JeLGQuw1WIqy2ygjuiKCovgTP7ETOJmMUNH4MWR8pmBHeZQJs6Dn0CVdgD17Svfb8066yDSey5wcgtlWGiuSetvp52Vr+X56rSLDvEr/25mMPrCFESSBbRlF89/iov/BaLBIbUNx9CDNDlw==
Received: from DU7P189CA0017.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::31)
 by VI1PR07MB9826.eurprd07.prod.outlook.com (2603:10a6:800:1d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Sat, 21 Jun
 2025 19:37:49 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:552:cafe::30) by DU7P189CA0017.outlook.office365.com
 (2603:10a6:10:552::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Sat,
 21 Jun 2025 19:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Sat, 21 Jun 2025 19:37:48 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 051D01C0010;
	Sat, 21 Jun 2025 22:37:46 +0300 (EEST)
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
Subject: [PATCH v9 net-next 03/15] tcp: reorganize tcp_sock_write_txrx group for variables later
Date: Sat, 21 Jun 2025 21:37:25 +0200
Message-Id: <20250621193737.16593-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E5:EE_|VI1PR07MB9826:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5ba467e6-295b-44ab-0195-08ddb0fb1b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WtmUrcWdMqwHB2lUGkyV0BzQ1JRALuQ+OcFtyEfwtUZrwDdBVosanFESNAjN?=
 =?us-ascii?Q?zaJV6DfFdE6cm/Mhcz0ViNa7s1y6v78BAUKS2Gn+ihD/89ryBYFKOoKQo5u+?=
 =?us-ascii?Q?F2NfDumu0XhXLNEvvucLripe5sGGVU2Bqe+U2+WuuVMWt6cuCjzFHyqhgc1r?=
 =?us-ascii?Q?pDb+hxohh3OHo9eAwLmY1uO8O6jORM0UEdvXHf08g2nHPOhIyB3TmM/Qa5Zm?=
 =?us-ascii?Q?gEdB+fhsZo8BxYYJ3A1grEOOIpEFzsMjfgiJgglkq0vIfHCVCAT/E9th7Y1o?=
 =?us-ascii?Q?Y9bRbUiOCJX66OTTszMUKVz2aIkPGmJcodYnpeocFtE5j5JIXv2HR39VpYwm?=
 =?us-ascii?Q?IEneCv7Sn2dKfrC0GncO5q6xj96C4RU8c5qDnmXpfSp1QsMWK0xJb5m6B/2N?=
 =?us-ascii?Q?gFIIVh3v5r7moWJvqql80mh7fctKAZYP+eoZTTETN9rjvIDqWPUdLJsJDmjE?=
 =?us-ascii?Q?hBrQGnECgL985LRi5vNbsuAO+qzOD9Tbx2czLT9FfqQRMT9S7xMieAaZSAZQ?=
 =?us-ascii?Q?hpmT7GyfDjCs1AE3cTlWQ8RVoNZQ134ZaBsAf+hJQizho55nStftxITRsAp5?=
 =?us-ascii?Q?QnJTt4B7+eWJIZfIwNKlyCjKe/TtZOJtgp9eqFVwVwP9Ho/QAQYmHDSU1Ufk?=
 =?us-ascii?Q?nZORCIChqhb2zmIHbRGQhZGngsac46g+UHgyBlNzCBaoD9J0GPcrNocsaUzH?=
 =?us-ascii?Q?4gZ3hUHkQSwTA/adsBJMtDHnNZWk9dLAalZtEEhMM9/vgp5TEjgOVbqTueyc?=
 =?us-ascii?Q?edogBv7CS08W+cGpjkOmhwywU9uB80kT7jZDrCtsqUSbVKm3j7cX73oXHvXD?=
 =?us-ascii?Q?oxgkr18v24KQzNarKqJ8bHYIOlqf4V+r5oJjaadvqx4cMrpDhMq6NintWNmn?=
 =?us-ascii?Q?PfVxPrYQh5ULjjoW2ta5NS5Iuz+nzT9J3z09DdBXMgMuNYB9+fGlbAcpWWcC?=
 =?us-ascii?Q?VI/4gY8sd3q38JaWefHCGU13nxNFFhIHKd/y7LrBA/zSM3Muf0W91vyG3sQB?=
 =?us-ascii?Q?Lp70BV2aStEKSKUJsdDqWTVZC5dGhFyeSmEKB9zNLDh4qjpDwSdaLWuboYoq?=
 =?us-ascii?Q?3BUeD3Snwv9+zDGMYF6LD9NrvvRv/eNlwCb8zg8cRjOcrU3VQidYzeHh6NSA?=
 =?us-ascii?Q?JByEvaY8m1F2y6h1gPQwuG3EN0PRKyF+opVshsDl25QlEXuONOL0TiQOrtD0?=
 =?us-ascii?Q?mxMgn372a52c7qpFtKhjF9nIuNrfLEsldtGGhYPgag9wn8h5wwDQQKc8Djbs?=
 =?us-ascii?Q?O6GEDXNqnoa1r2L3GRevNy/KggXTOTwy279FR6OrO/fMv2W2H/sSQa0ISyiu?=
 =?us-ascii?Q?cyl1l4IjLd2ypfk6mraJPcNiyWWsm27EObzpLgg9GodCE/ykudBtUiFygPnx?=
 =?us-ascii?Q?+UB+4GICsvRTq20FXcyf0lXdPSCDFdPjRRKZHuaobnd5R3w/oQm2GJJU06lj?=
 =?us-ascii?Q?Sh4NfmFVHDGd3kfH3079EJfWqIQ2cKHgWtEMlWss84Qk8mn3G9S7sxyTPoaz?=
 =?us-ascii?Q?RgSlBZ1kh3/gChSdgbP06rW01BxMKoI65TnJNQ+asdPPMZPu+d6ZOK/t4g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 19:37:48.5603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba467e6-295b-44ab-0195-08ddb0fb1b1d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9826

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
index 8a3c99246d2e..18b6cb7dc02e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5125,7 +5125,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 91 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
@@ -5142,7 +5142,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_est);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcvq_space);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 99);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 96);
 }
 
 void __init tcp_init(void)
-- 
2.34.1


