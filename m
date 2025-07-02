Return-Path: <linux-kselftest+bounces-36259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BB1AF09CB
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 06:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6511BC6EF0
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 04:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900511F2BAE;
	Wed,  2 Jul 2025 04:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="fOcnOkVz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010034.outbound.protection.outlook.com [52.101.84.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BA11EE01A;
	Wed,  2 Jul 2025 04:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751431055; cv=fail; b=SmVRtkJeouaPCS69677iLwwNRrFtMpIDNBM9tAIDC1MWa+DNK4Znnbp+HWsP5czU55yn8uIwfxZg0Ultpq6pp1PHoboTenGh/9yErvP9cseJ9flv2/stWuxpSBh3TYUkAL3YJnUUyVaemsjW3tXXku32vxzw5Yoc4jdJGptdG2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751431055; c=relaxed/simple;
	bh=Oktc3X18D2KH1njXBkWFFNRAEUovceisI1SMAoMesz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPwwpgsN2Z88FxHJZZgP2QqdZRn20bJpmog3Q9zUoy6vcmgws+kYSrZKk5ElObqhZQY17UYF+4MYvq4JtPH3RIi1FcJ7POsFxolH002szlBcXdy70EMOexo9A7hX6HmKCDYr514VeYsyvWzlU6B4/IQcwCpT/gQqd6cTwMFxUq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=fOcnOkVz; arc=fail smtp.client-ip=52.101.84.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJ1uNv1uxpoPg0f8hV79yz/3b52Qfj9eMbBwXFzbzKSoPhVtca+mBypOhTwQieM5nl4mYgxgjWrsoP4RZ0aip/KSjZH7GUDnJBZbIFM08E7aA/qdMvvcD9Td5IIFXH3Lav1uVYBKrn0FHhaBrSX3XaBAAXDW+RO+gCPiA/R1SoMklm1VEsaY8GV3S19HNqYgnfKerunTC8eWfDwMXFSysun5fS0VjzJNx4a8aEPyzOThhxEhY9sAtYBPtDTBOqIbymwLJWPe17TUrz1/Nq308cAo42Cch7kKcqQbLV1fRlpM7rsyrMJ4h6R0kgbimBO5sOM6+g41NbKADH7UGUQpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBjy4oLrb8IsyiMwv1oMVLOAWJmtjSAvgsmzwsfuMcU=;
 b=lRKEP0IoBVt2taKJi6wml2tB8plGtfDy/lP6GFykYMuI9uCWxP26smaLhZ3gBuEki9saIvHKlF2/XDh/7U8Py45LEyuC7Fs/0kAgOJaL/ESoC0IXHrjqG3cPEq739BjVKjz1/UfXITto5Eq0FpyGl7HKY+Npz/m9F4snMT+hFZAIJPBySXBYvXm3s7zl0yGHtKFKOFMV7KQtsnWCfh0PfUOkUMeNxIUDspZLW4Ul/YlsWQs/n3Udgx3AigP3R2yvRj5hQbKR+CwZiKwjtv849s1uVQmGVdqxEBdPXxi+Krgwui10ZXduME6uVb/ILv2rFpDQt1Dk32Ful9cE6Rxuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBjy4oLrb8IsyiMwv1oMVLOAWJmtjSAvgsmzwsfuMcU=;
 b=fOcnOkVz3AIJtyBs/jo+QV4hOq6QUNnO8oHLt0d9/F4wKAC1Cj2Ro5NW+TSSBqpBQaEpPD6QPaiDpc/Fmg7Psxu9hogz9sKv5At2WD6J+2q0V0hCDzTHqy5MYi30kFBSI9Hz6MzX8nHUEIWdvX7EJ93Y4rHs35HotzcTY2TWOrzM5MrWwQHHiwedGkEXfIBUFkyOp4pHri3w2/sVx+2Pn35eL2Rws/prKgDzvQrQdgdFBdmmcDBY94hobnSPh2HSgBcEvhOHv4goWLM8Nmu47L0epXLLYTLjgxmPXK0n1zDe9POKWAve8qmTixrPhhHz8Jz1G6JYFzl0g2u1V/g2gw==
Received: from DB8PR06CA0002.eurprd06.prod.outlook.com (2603:10a6:10:100::15)
 by VI1PR07MB6623.eurprd07.prod.outlook.com (2603:10a6:800:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Wed, 2 Jul
 2025 04:37:29 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:100:cafe::2e) by DB8PR06CA0002.outlook.office365.com
 (2603:10a6:10:100::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 04:37:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Wed, 2 Jul 2025 04:37:28 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id E1AC71C003B;
	Wed,  2 Jul 2025 07:37:26 +0300 (EEST)
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
Subject: [PATCH v10 net-next 03/15] tcp: reorganize tcp_sock_write_txrx group for variables later
Date: Wed,  2 Jul 2025 06:37:07 +0200
Message-Id: <20250702043719.15130-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FC:EE_|VI1PR07MB6623:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 614a0047-5d6a-4dc7-d747-08ddb92226af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RyxodBv8VYDsIxfdbh5SMAMwbi3KkUEefzDAccfezP16NIqwruS5u2d8aMC7?=
 =?us-ascii?Q?PPDCqdAiDwUEgbJ0VRTsv+yMvA2EXdMjMzu9mDYoA5lXUrJv/7Gpcdb+EF2i?=
 =?us-ascii?Q?Y0FpCZxBjZJcQJtBxXwata64mWOrhFsO+ylkorP592n4n3jOW5CDLm0ifMaf?=
 =?us-ascii?Q?qROHPZT6YgHT3Oi6EkS0EJf3ZKnNwo8xxa8xCZ8a+gNcMdynN6Jxb2nZ8KnE?=
 =?us-ascii?Q?vlL1aNPnwxY3jLUVuZWuWxF8BBXLqZafK46CgeBKrh2FanB+5659opxH4fMD?=
 =?us-ascii?Q?HyNw4kfZidUocmuUcldk8/u2jmc2s3uW/FtJguoEW/LF3HhpChQybi0M39G0?=
 =?us-ascii?Q?Yh6oyskQrWLXi8J7n8EbtzHSj/R5neKq9w7DW+et8GG4rPuR6jWpKFoU5rS3?=
 =?us-ascii?Q?ZR+1/rRMMKeQuY0tNgiuPPJdHBnaYqRL1QQs+QFey8hz0QIVKvcLSGr8JHZF?=
 =?us-ascii?Q?6N5FSdFoOxILGfOKQrnuJmk40rhHGd4sNCqyGJ+AcmeieJ2wRn/OvpXShVPx?=
 =?us-ascii?Q?4M8y6OTBPRCPufhBI1Sx6p2Q3ZMJ1VywXpwE2hrnHDNdB92b2rlUIjfv7O3q?=
 =?us-ascii?Q?QphfrEgQGefM921eJkz4S7J1AjDik8CGnqMcUHmoSalLXYT+qlpynWSCsTXM?=
 =?us-ascii?Q?aqm2+6iCs5/qNoYbwwcGo003oOnoVfsrOAzC0Y8+1DboRRvhXVPrgDP8mgH9?=
 =?us-ascii?Q?AIBuObgWsB7XL0UM5SlD4K1B1flFN+qjKMg8/cTgfLcd2ez4ZEg64pvbwtWv?=
 =?us-ascii?Q?C2Vm/St0iq+lO2jfxTrI8P0OiqIu076/DBSCNTaCSllL0ihax4QWOfaaEiDk?=
 =?us-ascii?Q?mm9IxHBxRA8XQRf+FLlieJRpmnF+0+to05lNexnBtggPrpV2R16NaBO5QdVX?=
 =?us-ascii?Q?+1iXXwojwAKAxxjZWqF9SG6dA5UGMhVI/MRQ+xjMVC46GdD2xbGLoLmEhoEh?=
 =?us-ascii?Q?FQ5/y3p1/ZqQT9dCTy5DchmSywvF3AzTrFf6Qf40CLg8U4pG3B23NWYK8Hwf?=
 =?us-ascii?Q?OiGCJ8W1qSh+HJnnGxqpWeIpADhBQ3YRzGVv+R/tXlyuRNvr+6r74ZjS6bMo?=
 =?us-ascii?Q?aSdWuMJ6xJZE1OBcfX99eBISoMJEsC3jCTikpzS2pY6mGkAJY/DKtj3g1wsA?=
 =?us-ascii?Q?O61MUNve/cOsNcTlYjRgfaoiBbUDRDla+dZ5l0P7kJ0BY/Vxxv0zUf1BkD66?=
 =?us-ascii?Q?YhCeFguCt8IJzTr8pyG2p5e+W4SRBHEbdF2MrLxDU7mbKD5VarGK61UYixVd?=
 =?us-ascii?Q?wms2uA2Lm3Eh7nfoJNmec5iK/8O1x3gsjPd1cjpTs0+XhRrZO8YQsn7C4Nnc?=
 =?us-ascii?Q?/l6LPBWWIPCRqIRYdMnMDT5qPNPIZl2uGXt/E3j4jY8zOfqnfCvm8oHOuix9?=
 =?us-ascii?Q?jOzS2pZjGsMUKWp/ODK0n6Uw43W909j2nv54SDQxBCZVXZFpztIUsI3yHbjZ?=
 =?us-ascii?Q?BmgM1bLaQD5lKoVTwaoXrwseI2Fmx2YXMsZyyUErEz/HEILSGc+0vYXh1SGx?=
 =?us-ascii?Q?3aFx/KOJ6GTImuBPgP9GZryZYF1Btlw8VSKkrS9kuYnXo05ykinozgwAYQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 04:37:28.4780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 614a0047-5d6a-4dc7-d747-08ddb92226af
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6623

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


