Return-Path: <linux-kselftest+bounces-49407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6D5D3B6A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F18530746B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6439039281E;
	Mon, 19 Jan 2026 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dT+YFUje"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9997F3904C8;
	Mon, 19 Jan 2026 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849176; cv=fail; b=e5KuGaGQI4syqzSNbh70d02Rwzr/yMCymKwRX1E3PuRu7GfDaDXjSz+YXH60U7l7mIvg7r6UdE8/CH/pQ7YV+fxPJSWHDI7ZLJuP+E7fVhH5y+HqbOS3k0gIYDwsZGKwzq3pcb9y0WN0HyINNVwaz2fT53QpZ/KAF4VMJDcRg7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849176; c=relaxed/simple;
	bh=fJkK5Yk1Mv19yL2cXk75h6MkWRU/ckQ5je798AYMJZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrMSErotzvp/d2YpwhW2kwoXlOI0/yt5rzYsazDAij4fAUPIgmuiUCX0FTwE4JrPst1w3ldt+uwuIrszQAjiHKqFU20es/S9I7fD2wdp4X9TGAvCmlyrVvCZtU9he3YvrsZ9lMyFkKo5ynjeVFjs7TmXdnnvz05Skke2BvceQQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dT+YFUje; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tiuLY+q+LNN6ay8g/PVZckzWr1u8x/uw0+kBNKXewqMFFIoR15DDOBRZraP+hmaaonE9/4yFteKGnU9xuE+NLM2spx79Y0mv9HKdwRkOJjwdF+EAbHCqZKyIaAPeFYOEcbYCdbNmlx8I3YCbR2LCpPqVOEDzLf4j7/wY0x6sKnjL9MfswyMkkLwEnpKpCcwuA5NYxBKt16py+sPOfhqjRRz6KSHlYEkTVmfQDw/4ssxvxbuQuCCpDNAislKYr3eVU9Y09cMTJiQQ+ZmpP5p7MNjxTbDUPktVh5b0IS5ZOwi2ALzVql3e2+6O7zwUqNJvNs9zWb9CcD7xN9krP7VgFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cT7Z11qrjah/SBBFfT2o0VbV8RwtMFQ9dqJ8hLgddp0=;
 b=D6/c5FX/As9e8mZ8/UyikRSEx+RxXMlcvlv/b26xk7jI4NZZtG4rsTqljoytdb7plZ8XIgQua96qkVMdjbgpSjWLnj6zTrPDC9a1RhKvX8CGhyRPFHynvunUUfgWnObLZ3PcdFs7xpncv/Cme+B7KJisROmgCqqilHtVZO9TRRV050I5gchgnlaBNtijI5Ww9Rf8WTLUNFPXxagDUMJCYx/mENGWOLfARJDWxmUfKqcGM/3Tbv8lJlrM8FtZVX6ilzT/NOW3pNT2ZCu23LoubMnIPcNVmA73kOZ1iYPK41+tb8X4OPySNBkOuOEVqlX8+RqpZTCBkwhVfWbLfyc1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cT7Z11qrjah/SBBFfT2o0VbV8RwtMFQ9dqJ8hLgddp0=;
 b=dT+YFUjeH+kVKGnMBZcL3hGDzjOjqlzW6QyNyKfVjdGa9d0an5lLSt29wwxKB28um3tIdsmhuk1RPQj6bhJLvAMhsigMorlsXyUkmxGEK1WbJlSkMAA+IBpmHDYdGuzVX52uxaArD7CjgqTiuSBHWlf+gAYjIJvczvZLRWGMNXMOYn2nGSs2LwfPfKYcm1AY5T+LyAjWPZMpDHGbwZjOnCfgHN213R7FunDAKKXa5OnXyPJqFBgWcyr98Y9H95U7tJeyLGJ7LyjMM5iYrvc26d2pnwlSlHoLj2B2fYtGknDlMOq3IGeWJZp4MoWV0LadhRYp+/YtKlbwmnQfiAV9Og==
Received: from AM0P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::27)
 by AM0PR07MB11669.eurprd07.prod.outlook.com (2603:10a6:20b:73e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:59:28 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:208:190:cafe::64) by AM0P190CA0017.outlook.office365.com
 (2603:10a6:208:190::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.13 via Frontend Transport; Mon,
 19 Jan 2026 18:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 18:59:28 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 00AC520538;
	Mon, 19 Jan 2026 20:59:26 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
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
Subject: [PATCH v9 net-next 13/15] tcp: accecn: add tcpi_ecn_mode and tcpi_option2 in tcp_info
Date: Mon, 19 Jan 2026 19:58:50 +0100
Message-Id: <20260119185852.11168-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000046:EE_|AM0PR07MB11669:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 70cee1e3-7489-4809-dab1-08de578cdf4b
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Bq36QbzqxTeBmFTcW1VhgnxS+kR5oVTOlJ/zqNUxxYfsMlO2yIWIumhvqJg6?=
 =?us-ascii?Q?em381OGBFu9FWNO9rOlZYtNb8uD1zp1AvLCUH70DGQf4GGqkS2o99yDlrbih?=
 =?us-ascii?Q?YBITUEZPkggFl6EJXHudoeKrOjiq3VtJJtpngyJ9TFqDWg320oWpsnREF/pH?=
 =?us-ascii?Q?mP49SjHB3VQJOHNkbwIqNOKAPu6WjhSFSqNbMhIxjDVFRI1JqUCJXzzPWmUn?=
 =?us-ascii?Q?/R5TN9GDxwJSD2mXPJv0e3dmuaDcs/eddtd+fcw8dUt9sHfKqF3r5rQfIrsS?=
 =?us-ascii?Q?sDHyqxL+hkAMy6v4jMZQiuOrcFxqb9f+CS272kQ0CvQdAOUPQgM0tn+W2nLc?=
 =?us-ascii?Q?se35d5f5jqt80CE/RsI8kqq/RvHybv7Oth6qjFJZlyDQzFIrXWIfjDPy3Jbk?=
 =?us-ascii?Q?50+07u9bGkzy759OEybMz3aMSFpSMZiQT45r82I10BpmbCl32ABcmQWpx0Tl?=
 =?us-ascii?Q?q9xnx+HAsaYiY8ORXQA77ScrSrzei/vPpW6bmMO6pLQ5m+ibB8QZ28vSKWvv?=
 =?us-ascii?Q?1+6TlZbcqpcjwWZpoDb9KV1I+4xMYSX0SFNcPcuG/esE9tlEqw+9/kVP8S4t?=
 =?us-ascii?Q?hxsnC0howzZYZrXBmcYgdjYzDpYdRSrY3z0JxkUMJu0+mDsBc5Khh/Lu24Hy?=
 =?us-ascii?Q?5TVX9a+CvTovRHdll9pHrLIekydwbxKGqaSxeUmGYNoqEy4aXa4bO48PpmLn?=
 =?us-ascii?Q?nxvU8S9AbFs0PM4YESSoP7oB4IF2N91o0acG6fZ96pRQhrJqzukgubcVrzDO?=
 =?us-ascii?Q?l/6leMXFvWOHDXc+HWIRvNwJirfK0hDPteohQVqO1PKd7woNZobOSlQey/3F?=
 =?us-ascii?Q?k1EkBzoQVoIzqKkShFo8ZqFTh9cyiKMBhJx3nxvnARUzVRtKYfG/iXTOMfQa?=
 =?us-ascii?Q?mR3ofCeIw/6PChKAa+k1PZM4o+OpYU5/af+y3LJbDrAGQ3K7sVy7BJUjE0Pj?=
 =?us-ascii?Q?qaueEyzyaAGNT8xfawyNyxguvluH2lwD66p8p+tSRUci92FXaYsGpSoHcnDz?=
 =?us-ascii?Q?g5l5Hitv/n3vIM3B0nmisznCUjXrQKh0gMBQAa4c/ywnIlQJfI4SMLkbK7cZ?=
 =?us-ascii?Q?u67umlTfdk47ZWI01IYjFSZTHMbJDBcqfQlv5B8GGd7v4mwrhNRhte91UAd+?=
 =?us-ascii?Q?5cnk+lwYE2RRQ8mI88y4wOwoWxSBh4PEjMK/PbUola+X4SEO68Ldlqw3nhA/?=
 =?us-ascii?Q?CMrnUo7aqgESUs7ppob0d0N4BBAQ2p74Nkd5cf6m4jPnoDouJh0c56I6iqYL?=
 =?us-ascii?Q?BiEolubruVWPKBYPnMGbuJkoxoUWbiBBRCJyCX9Z2YUWKbQijqVOCuJt7hnR?=
 =?us-ascii?Q?PrbJLMZoaS/Wcj/czBmhlexNcaWXBRbHADS5vZJd0boBlvwzCmgBg9LPUrOg?=
 =?us-ascii?Q?AcYWWpktfPLEJ7aEJoVzeWKmmoxMOS8nn9H9u/S5shdPPy+ra2KThc+n+xCr?=
 =?us-ascii?Q?5kK332JCNSXXR1wPVxm3Frws/PUoP/49NydVrvxikK3oaKlKpiCBnLvgMHHX?=
 =?us-ascii?Q?QV4Wo6DUVfeg74KVkgSXp4/81coah7m6rSFePsJdBTcwxp2A+xnyYcQhRpq7?=
 =?us-ascii?Q?/jFaO//1u10CyzpWBMCz0fofNAJuGAXR2wfibJYFAKiTt1okUCviNcaQNm0z?=
 =?us-ascii?Q?J/AVHhR2OJ2Cj0eEWLxC6bWvS5ujed8I/ILZg8JGYON5zBFT+upbhsABr8u5?=
 =?us-ascii?Q?BCGVa0n0rL7KVCbDkfzX7Qc2bUA=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:59:28.5806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cee1e3-7489-4809-dab1-08de578cdf4b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB11669

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Add 2-bit tcpi_ecn_mode feild within tcp_info to indicate which ECN
mode is negotiated: ECN_MODE_DISABLED, ECN_MODE_RFC3168, ECN_MODE_ACCECN,
or ECN_MODE_PENDING. This is done by utilizing available bits from
tcpi_accecn_opt_seen (reduced from 16 bits to 2 bits) and
tcpi_accecn_fail_mode (reduced from 16 bits to 4 bits).

Also, an extra 24-bit tcpi_options2 field is identified to represent
newer options and connection features, as all 8 bits of tcpi_options
field have been used.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Co-developed-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
---
 include/net/tcp_ecn.h    | 11 -----------
 include/uapi/linux/tcp.h | 26 +++++++++++++++++++++++---
 net/ipv4/tcp.c           |  8 ++++++++
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 41b593ece1dd..a31ba18b10d8 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -67,12 +67,6 @@ static inline void tcp_ecn_withdraw_cwr(struct tcp_sock *tp)
 	tp->ecn_flags &= ~TCP_ECN_QUEUE_CWR;
 }
 
-/* tp->accecn_fail_mode */
-#define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
-#define TCP_ACCECN_ACE_FAIL_RECV	BIT(1)
-#define TCP_ACCECN_OPT_FAIL_SEND	BIT(2)
-#define TCP_ACCECN_OPT_FAIL_RECV	BIT(3)
-
 static inline bool tcp_accecn_ace_fail_send(const struct tcp_sock *tp)
 {
 	return tp->accecn_fail_mode & TCP_ACCECN_ACE_FAIL_SEND;
@@ -105,11 +99,6 @@ static inline void tcp_accecn_ace_fail_send_set_retrans(struct request_sock *req
 		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_SEND);
 }
 
-#define TCP_ACCECN_OPT_NOT_SEEN		0x0
-#define TCP_ACCECN_OPT_EMPTY_SEEN	0x1
-#define TCP_ACCECN_OPT_COUNTER_SEEN	0x2
-#define TCP_ACCECN_OPT_FAIL_SEEN	0x3
-
 static inline u8 tcp_accecn_ace(const struct tcphdr *th)
 {
 	return (th->ae << 2) | (th->cwr << 1) | th->ece;
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index dce3113787a7..7be9044c5af3 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -226,6 +226,24 @@ enum tcp_ca_state {
 #define TCPF_CA_Loss	(1<<TCP_CA_Loss)
 };
 
+/* Values for tcpi_ecn_mode after negotiation */
+#define TCPI_ECN_MODE_DISABLED		0x0
+#define TCPI_ECN_MODE_RFC3168		0x1
+#define TCPI_ECN_MODE_ACCECN		0x2
+#define TCPI_ECN_MODE_PENDING		0x3
+
+/* Values for accecn_opt_seen */
+#define TCP_ACCECN_OPT_NOT_SEEN		0x0
+#define TCP_ACCECN_OPT_EMPTY_SEEN	0x1
+#define TCP_ACCECN_OPT_COUNTER_SEEN	0x2
+#define TCP_ACCECN_OPT_FAIL_SEEN	0x3
+
+/* Values for accecn_fail_mode */
+#define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
+#define TCP_ACCECN_ACE_FAIL_RECV	BIT(1)
+#define TCP_ACCECN_OPT_FAIL_SEND	BIT(2)
+#define TCP_ACCECN_OPT_FAIL_RECV	BIT(3)
+
 struct tcp_info {
 	__u8	tcpi_state;
 	__u8	tcpi_ca_state;
@@ -316,15 +334,17 @@ struct tcp_info {
 					 * in milliseconds, including any
 					 * unfinished recovery.
 					 */
-	__u32	tcpi_received_ce;    /* # of CE marks received */
+	__u32	tcpi_ecn_mode:2,
+		tcpi_accecn_opt_seen:2,
+		tcpi_accecn_fail_mode:4,
+		tcpi_options2:24;
+	__u32	tcpi_received_ce;    /* # of CE marked segments received */
 	__u32	tcpi_delivered_e1_bytes;  /* Accurate ECN byte counters */
 	__u32	tcpi_delivered_e0_bytes;
 	__u32	tcpi_delivered_ce_bytes;
 	__u32	tcpi_received_e1_bytes;
 	__u32	tcpi_received_e0_bytes;
 	__u32	tcpi_received_ce_bytes;
-	__u16	tcpi_accecn_fail_mode;
-	__u16	tcpi_accecn_opt_seen;
 };
 
 /* netlink attributes types for SCM_TIMESTAMPING_OPT_STATS */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 37a6e0aa9176..f9e61e49f811 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4321,6 +4321,14 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 	if (tp->rto_stamp)
 		info->tcpi_total_rto_time += tcp_clock_ms() - tp->rto_stamp;
 
+	if (tcp_ecn_disabled(tp))
+		info->tcpi_ecn_mode = TCPI_ECN_MODE_DISABLED;
+	else if (tcp_ecn_mode_rfc3168(tp))
+		info->tcpi_ecn_mode = TCPI_ECN_MODE_RFC3168;
+	else if (tcp_ecn_mode_accecn(tp))
+		info->tcpi_ecn_mode = TCPI_ECN_MODE_ACCECN;
+	else if (tcp_ecn_mode_pending(tp))
+		info->tcpi_ecn_mode = TCPI_ECN_MODE_PENDING;
 	info->tcpi_accecn_fail_mode = tp->accecn_fail_mode;
 	info->tcpi_accecn_opt_seen = tp->saw_accecn_opt;
 	info->tcpi_received_ce = tp->received_ce;
-- 
2.34.1


