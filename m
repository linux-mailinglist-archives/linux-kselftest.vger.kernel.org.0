Return-Path: <linux-kselftest+bounces-36376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4983BAF6972
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 07:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C954A77B7
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 05:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36BF290DB2;
	Thu,  3 Jul 2025 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IW2uhKpT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010048.outbound.protection.outlook.com [52.101.84.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37AF2DE709;
	Thu,  3 Jul 2025 05:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519921; cv=fail; b=D3zSxBLFHhzweewiJuigJHBMwmgRdT3X/j3gjzrH5g9vevTqi+493tNb8wYlG6MQ1BSsvcW2X2uS39huv3jy2nTBO5xMyqGVwMc2xVce65UFupIUZo8o4+Ym3wKZ1bwK8Fece8ynl4Gh0WUsRJSfWvLnwneUk+ZOemQr/IghugM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519921; c=relaxed/simple;
	bh=InicG2r8DcNrHUWqnq9mW/kSZ7b1H0mscWTTKAmq3Ts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjV9tSvw8V1IS+0uRqYNODdWrL3dwU0woJ39t2ygUMdakKE1a9Q4yELQfSo6U1z8epRMAKtcvA/FnCD2wyI6DRVn6gf+VY8p5Jd6NGbHhrsCAiQuTG7gQAKMJA74bX4+0dYY/8YzZ5Ap4rt1Ka2b+hluvlmsgqGBJF8lAZ2XHSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IW2uhKpT; arc=fail smtp.client-ip=52.101.84.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1aVzEwnD9g6IT8F41aYQ49Vs3iWoHJrXlPlmhVpwmkAyJu5rgpmpDtzFFAKWJ6QDn7OTmBLdv9yq+NatJULi7ESmT7eo+jpha8AwpIeKYAx5W711QhjtwT60l+FTlehkHB2/MFojX/ijcLvQ0xz5vT2O3OA9rqK7K+rFeXehl3S9Qv52RVsLn5dan11d4EfoKXis2FwritM/O69tqAxzmWFLVk67LcdZWkizIEE2DO2C7iBha1LEjv0+B7TdV4mBln18J/VvMRbq4IJrNX8ez/aMPIeLLwMb2k+U8tKLPVYYlDv6pqwC2kx135IVfnP5HAol+qR4WspRWscSAd/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dv2dgs+jipuA5JMRg6udlVfPlwEJHfa5mcE0DJv4Z3w=;
 b=OasOkIINHrpb71dt1dE9d879EN+qeAHDQn45zpkjXT/HfZMiE1r/jXINs8abPDrleMSBDPc7Jfg/1Hf4su8fpbYybw5/I65laxb/HwPA7DCkLUpIIrvulIXzolLFo1Qrl01N8ptf693b/ktAmJ277djenqf6Md03863WdvrwjGxIWTVc8aps/TbwESqRJjwu0yQC6MDsKvPZO9NyecquIV7P0+SwWCd0AbLvKzZTtjnrdUdnlL3wqCh0hSUtf8SmA3rQvCj44+vjuPFcAcw3g7uPe4+ceq8LX6CL06g7jc5+S/vCTtiV2zghwvbrjMtyOaJ7bRQ8tz8074HS/qcd6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dv2dgs+jipuA5JMRg6udlVfPlwEJHfa5mcE0DJv4Z3w=;
 b=IW2uhKpTYjQHxZWUiqcPDw9YbREUcPVjzusKhhfbnwVSM/pGK34tdHWRGRAwPVQsl7iphSRxuwr7FxF0pCz1xhASUq6WHtnp08/H/gSHBc8TjDl8o5h9HCuo2rovEYx4tMKa9PVMPBslwtWPmQOSGgbkse4F4DEJi0K2TTtxir9CcV3Oyx3PpKRzSAU0q+2MYJh7TugdXqOaiiRTg7GF/DCZyYyBpXYwmg8jVaPd5iLoy3VHLZZYNiNo2KBIsDw8gCD8D12BpiJRf5liJKHh7Bsns8i5yhAqEegkK+ySxtF/jM2jlwzBWxSQ6/f8TsEKfQ0gMrcY22cSx28IsSqaUA==
Received: from AS4P191CA0026.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::17)
 by AM7PR07MB6529.eurprd07.prod.outlook.com (2603:10a6:20b:1a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Thu, 3 Jul
 2025 05:18:35 +0000
Received: from AMS0EPF00000194.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::87) by AS4P191CA0026.outlook.office365.com
 (2603:10a6:20b:5d9::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Thu,
 3 Jul 2025 05:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF00000194.mail.protection.outlook.com (10.167.16.214) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Thu, 3 Jul 2025 05:18:35 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id C220B200C7;
	Thu,  3 Jul 2025 08:18:33 +0300 (EEST)
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
Subject: [PATCH v11 net-next 03/15] tcp: reorganize tcp_sock_write_txrx group for variables later
Date: Thu,  3 Jul 2025 07:17:16 +0200
Message-Id: <20250703051728.37431-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000194:EE_|AM7PR07MB6529:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 704ac498-c581-45db-96df-08ddb9f10f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sgWy2Kq2pSzVT+rrAdPcPVogOqM/nlXFsu6PL+QETPcxzDYOQnzgd0yEjS3P?=
 =?us-ascii?Q?Lm7pn4td5YAQuvgf4ie+GEBvN8iGTOEfECkAsyTKaqWLygA8lHlH4dsy02nV?=
 =?us-ascii?Q?+3SrlCyliwYjUVK3qOvbZvO5L3btynMynRtp2p+HFFsgNP5gvWfIwt/4D7zM?=
 =?us-ascii?Q?bLLUQQ4XsPbyN9oWsIQsiQAe6ywuNkkqQ1rEOlhrzJ1pN1v40VOjcKGYszaT?=
 =?us-ascii?Q?5PuOoKTMbqirvJZSWz0plBqHCKadqh4cuSdMCPQbv4GIS9jOywJn7CMXZZRZ?=
 =?us-ascii?Q?A+6hHXqbK5TwaqZ65haxJDDmDT53DYNov+7qgiCJ/greVN3J15Zo1LNsu6zW?=
 =?us-ascii?Q?ulxCrG82ILM1/1Z4Oji3krMWn6g68wxlUC0p/6By64YFClXOkmnRrtDUL6dF?=
 =?us-ascii?Q?Alb7k7c9ISCpEsZG6NMkDNNvoiEg8wx97+YozXomFQ3+JLrw9BILE+ESXNwR?=
 =?us-ascii?Q?WbyO2R+vylIgapLHA7H0ECqKlma+xRa3Px0G5v5J4j2EEfUjHv6B5M3zmEgJ?=
 =?us-ascii?Q?KyZ1kTSTUE9UXMMkfaS44XOmwgPNb88sYVjBN4pYxNW6llQb8YInYLd1V6KO?=
 =?us-ascii?Q?nwzf6OBZNCllPqUbl4MEKaMy7glOHEMdZql+Dg9uDnhYVnEt8/Xmel98OMQb?=
 =?us-ascii?Q?6OVyeIpJrOMLa4b5O1PQ2x3V2EPfODS3cEpd4SCkfCLGJTbSktOHWwtRcYif?=
 =?us-ascii?Q?zuzmxUxvU5cCr2sg2iwYhTgXuJ3eaSnIqPLlhlBnfNknvL8b6KLgYK65qPZN?=
 =?us-ascii?Q?Ov7gUyWBrJjhjY5Z3sNAfVJ3vmUgVN9zMzebfsdUtf9syxagN9aOOvNd5SO0?=
 =?us-ascii?Q?+W2o78GhiJKPQWUJnW9MSU5f0NnPZLlIUxgiqwdVC3WHn6ka7pcC5fUsPUoi?=
 =?us-ascii?Q?P5cvE8raJ0h5nPv5rcZD2hiQ3aixUyJRdsA1f7HyaUtSFAWH0CNmwKCK0TEf?=
 =?us-ascii?Q?f9jgxPDJqOortcCI1YLZAQ3T1tdP9+xcJ2p0RZ9qJWgddDcaY96SSz+8hSIc?=
 =?us-ascii?Q?BkjUkrkAUfzKMqg6MEYDng7aTNawhE+xf9D3ISv8fST4a3xrVXtOyk9FUNMk?=
 =?us-ascii?Q?JU3jCMcd6C85jgxAVxioFDSjdoiJHPtSxetspBuoCD3wtnB5CSRNv1vSMY03?=
 =?us-ascii?Q?nMGgk3fnUy73pVn4izp9Bkse++Lu+84jhMZCTyTNLFHDuFa4UIMnY+Jc4Lre?=
 =?us-ascii?Q?PvNb1N2v0dGuYqvA2AP5xyeBVd8lhdTESvqcM6qwD7o2uXUoe4cxls4d4KFH?=
 =?us-ascii?Q?FOKoSNOqVUftmNKrBKp8G3+uaCmMSO4jTfOwz+9gFD/5rLO9nvKotICZDHBq?=
 =?us-ascii?Q?bH7UDf0oLdGexsPMzrO4pfkhzwN4hfdGVDsRR1g1OihAMrGcRCDSqVuuv2tH?=
 =?us-ascii?Q?doUh2fsmAycupv1pH85CMS1Y+uZo81lfhLqXF7AkVYV1tW10Q4iOkd4E5x1L?=
 =?us-ascii?Q?iNe5KrRLOUHo6BNT6FY7CBD83dZe17WYjB4QmKaM+RAZZ/5Uf62PO+hjy6yg?=
 =?us-ascii?Q?PA65jHjheD5LbXQohvl9Ol92PUVkLjp876RFsrUVKxnugl5Fl93ezqmOog?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 05:18:35.2876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 704ac498-c581-45db-96df-08ddb9f10f6d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6529

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


