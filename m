Return-Path: <linux-kselftest+bounces-29290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD218A663AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA3D188C2D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 00:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8B73597A;
	Tue, 18 Mar 2025 00:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="lITJo6gP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68474381AF;
	Tue, 18 Mar 2025 00:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257677; cv=fail; b=jwbS/7pNVGF+mCEbEItgtKiHG5eYic5Zq3iDFAq6nSnvsS2zN4G5LuPOFLdO5v1RP8mC5c7gYV89ZAJ8jwzJuLMbz/gmKnKhZgGWoHlShQ5sn3zTOVlOac9MVzjwQddqIrLc0ZOXAhX4uqJMRp1ecIMRve/LjM5wRvFIoOVbZU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257677; c=relaxed/simple;
	bh=pSlO/wT+zwQpxMsveSgD5QpwZqxSJPoTbBK9fdRZmes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=We1vBSeLuxSVkBkE5mJf3vxzMk21TGVFbCny3W7DzWTDxsIXyJntdav0Df6Ponqaw0XO9IwSYCJJ9+EYyWuCfMns6xOxs06QJOzu63nSkUpXTEh1Dsn90S8RGTnBnFyh0TxsUAm4BHD0yHnc5kROy6EkDGeoFMjuYh8rORpn7fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=lITJo6gP; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgoZ1FVSPBuJnwXcpEpyArI6Z8nf0Yw6R/KwPgp23FeLRnjoONfhJNf6McWmAWsK/oq25jzMRraACkreTOaw5EXg+zbkDx0bm2NmqgrXmHCZ0fg11sluayrZIa0KFRl6hVLthzjOEzMCKS3C2tJGrgis03hyyNjL/Np6EiGDWnFBDLeh+EK3ict8qJY5D+CbywX2daJdePV5JksQHHkQnj5AYTmKrkP2CU6lTvu9XpFOn0sg5FdoFmeJBDcNZ+dUuBf/lLTHPicsqHN+ID08IvjuP3rLe40Ck3EbdCclr9kjZ4Am+e92D9BHGdUfQ+Ht70c0KfIkyzYo8Fkv9ODtkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbF9Z5AttEUa36DqFVoF0RSc0xJM23wjMzYufsdhZiM=;
 b=yliVPJn4Zt0YcYjf8R4ZXxjTni8194uHf32snAh3slonZ9XgduW77AR3GKeof23Ivl/B7OdQOORjYIfCLrcJnM3sUVDzC+P6VqcHcI7kMhu60cYLan9MYjzyvliq0VUI/2KIp4Pi6oWv7rYHlqxrSlvzZxSTVnCqpYYmo+WRuoWJqmnl63Ddg6NJWvHUPdwIfkh3/hSI3poE+atJfXSG02o6bLtgmWyXFuEA6ulXMtGTfA4Ob5fIcpIuwfd/5TlCwJE2mKTbmvp2u/socGxVWokjFuwxxB8oMCmtBDhqq9gGiyxofTmfJ6iCaCvB91Sv28JldFKFED16dGAfAMGTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbF9Z5AttEUa36DqFVoF0RSc0xJM23wjMzYufsdhZiM=;
 b=lITJo6gPLYcfE7f5fPAaws50eJFkOqEb6abeTKonG+S/w7o2z4nCN/3xeslQuGIDHBMvd5ppqEHN3tk/bwyV+sXGcd1txBfhVPOS/4V3uYSD987cmImQP4N+aIngSY3w0kYic4f746Kk8xHsM0gN6MW4qVdQ2utxq7CYGpXRnLPvbDN+v6R22vGeZpiCsSEsZ8j1Ver/1877Exso5xLGN5KTEtFGrC6xO+n94A/BolKVjc09ZF4TIheSJkjTg0lUJPA1Bz1sqCiH9KsYQHWXfBY+QnG/qIn/Rvs6mmMuLIzLcbQXPrWySGDsqfSHJunGNmtLvqtG9l64Hy1pUbVKQw==
Received: from AS4P189CA0012.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::15)
 by AS5PR07MB10131.eurprd07.prod.outlook.com (2603:10a6:20b:680::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 00:27:50 +0000
Received: from AM1PEPF000252DE.eurprd07.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::2e) by AS4P189CA0012.outlook.office365.com
 (2603:10a6:20b:5d7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 00:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM1PEPF000252DE.mail.protection.outlook.com (10.167.16.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 00:27:50 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 52I0RNBk024935;
	Tue, 18 Mar 2025 00:27:57 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v2 net-next 04/15] tcp: accecn: add AccECN rx byte counters
Date: Tue, 18 Mar 2025 01:26:59 +0100
Message-Id: <20250318002710.29483-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DE:EE_|AS5PR07MB10131:EE_
X-MS-Office365-Filtering-Correlation-Id: ef0b5210-2277-4811-b02c-08dd65b3b71e
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eXZ3NnRMaEE1VkRhY29OZWJqd2Q5YkxCZkF5M1Jua1ovc1RLbkFtWkpsZm14?=
 =?utf-8?B?dmd6cGJ1VkdTRlR4TE43OVFYN2pmblA1NlA2M1Qxb3lvdmUyNlhDNXdPRk5G?=
 =?utf-8?B?VllaVmRpek9hUkxvUTRSNE1sNkVob1ZUOEwxdmwwSWJhcnlqcWQ0RDNESWRn?=
 =?utf-8?B?cDcyR2Jid216bGZPQmhsdUxPUEZzdUwybnNmM2JIVHkvSXhrem1XYWtvZklr?=
 =?utf-8?B?TmxxV3RMVHI3VVUzM2VQbC80R01MOTV5WktQU0FwWGVKTkdIcmlBazE0dE5w?=
 =?utf-8?B?VW01TTJSVFVPcnl2Y3dZbGpiTUQ0SWJ6UE1Gait6ZmRvNFBteWw5M01kcDVk?=
 =?utf-8?B?Q0wxcGVwYTkvVFJRTE9wZnFjTE90RUdWYjNVZ29ueTV2cGc2RVhrUWpyTmxl?=
 =?utf-8?B?bHNmMitNMXFkc0VEaGdERjMrOC84NVJhZDhFSm8xM0I5ckRxR0V6VnVTV0RN?=
 =?utf-8?B?NDk1TWlzM0U2dUdHMVYxd3dMOFo1N0M1endxTUFWcFoxMVc2Vm5Ia2t1cHhr?=
 =?utf-8?B?ZGNYWUNBK1ZhWExHVHVYN0dvWjhTZ3g0Ym5jUldpMHNUMHZ1TnNQMmhHWUhp?=
 =?utf-8?B?c3RqSVMvVHBnUTRBSjZOYXpVYnRZZE1pYXFlTTE2VTZqTVdUSndnU09kNmpq?=
 =?utf-8?B?ckdmNjl1dEZkTGtuVGc1bkExVXl4a0tJTGcvNGF5UGxCaXFuRXdjWjZCamxo?=
 =?utf-8?B?ZndGa3QrcVhqUU5hMzhrNE1sQVRHRWV5RW04cThnanY4MnVsN3paREErM0Ni?=
 =?utf-8?B?djdoUmJOODgwWHI1UHBnampwZlZPREF2QzdCaFlOeGxCWFNoRnpIR1Z4UnNu?=
 =?utf-8?B?Y2k1VUxaajliNEhTKzhWWUdFR2h3cldxYXhIOC9GOHFaSCtDZkt0aDNrK0tH?=
 =?utf-8?B?dnB5MlRyUlFoTE1WTS9jZU1YRXhVbFBac2lRc2cwWG5JY1Ewam5uV081OVhO?=
 =?utf-8?B?Zk14TU9USFVHV25Hbm8zVlVCdmkwVXhyMFQxN3lDNWJrYWo0OVY0MUxNY3Fo?=
 =?utf-8?B?bEI2UGhsazlzOFRFanlnYUZXRlh0ZkczRUtVZ2JCaW5lQ1A0cHN4L3I5YnQ1?=
 =?utf-8?B?NFFrTUxFREhaeFhqSjBiN2NGWk5tZ3hoY2plRHh0d0h3MXp2K05OVzNkaUlk?=
 =?utf-8?B?dGRxM1JMMUF6Sjl1N1U3dHVzaXE4WDR4VjhOZVMwY29YVGFZWXp4Rmp3M3RO?=
 =?utf-8?B?RDVPUU5abUN4OWY3MFB5OUxQaFZ3U0kxZWw4cjlVc1JsSFdCTUtzQldSMDE4?=
 =?utf-8?B?anNJK09sSWtLT1IzUUQ2VGhNNGVrS080ZFo2bVhDbFZnL25pczJaNjlBdUxh?=
 =?utf-8?B?Tm9NODQ1RjhBV0s4TitsekxkZHRBMGVHY0pLNjJCWkVvd0JrS3owUmFIZHBj?=
 =?utf-8?B?MGc1QnRUUG5vWkVYUTdRc0w2Q2grYlBzUnRFOWV4UDlvZm9jZUg2QVhlVG9Y?=
 =?utf-8?B?SEM4aHVKT3NSSlFtVmQ1SFpEWXpHa1JJSlJYeG9TMUdITTRvWTBuNVF2VERH?=
 =?utf-8?B?QXhCRVhTR1BmWmxBaDJmZ3M5UUxkMWRhbTQ4WjNvVE1Ea2NJaTdwTmhYZTBX?=
 =?utf-8?B?OCszcGM1ZUpmUTJvd3dqMkJ5L3BLNG8wY0V3ZU42eGREajljaHROdGxIL3BD?=
 =?utf-8?B?bGZMVFVoRjZKTVZZbk9VUjFUcFpaUHYvVTE0R085R1FGVVFNZXlOVUZlVHZ0?=
 =?utf-8?B?ZkZ0R2VDOHpKQ3VpMHRuY00wYllEdWI0Zi9XQWNvVnBxTUQzNExCUVUyVE5r?=
 =?utf-8?B?dmE5NWh1bU9xUUs3VHV1ZGRSb1JmbEs4WW1pd2YwNFhrbVpReDhaQWlYVHVO?=
 =?utf-8?B?Y25HYWFCTHkzaHhaMG9WU3htSGw2LzkrMUdVbXV5Rkt2VVA1V1ZLMiszV1NO?=
 =?utf-8?B?bUdhWEg1M1Bzd1N5QzFOTUZWaXJHc3QyTFFyZlQ5c21odUlKT1A3cVZURWtI?=
 =?utf-8?B?czcyOUZ4c3dvekNsdmVUTHpMNnJpS3N5YnFicjZ1UUc3d0tTYkR3K251YWJj?=
 =?utf-8?B?NjdhYW4zYnIyWG16TmZLK2l4T2JnK3kvaGFBYU5oUzR0cFNUWUhDTG1kTXVo?=
 =?utf-8?Q?wP/HiG?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 00:27:50.1490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0b5210-2277-4811-b02c-08dd65b3b71e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10131

From: Ilpo Järvinen <ij@kernel.org>

These counters track IP ECN field payload byte sums for all
arriving (acceptable) packets. The AccECN option (added by
a later patch in the series) echoes these counters back to
sender side.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h      |  1 +
 include/net/tcp.h        | 18 +++++++++++++++++-
 net/ipv4/tcp.c           |  3 ++-
 net/ipv4/tcp_input.c     | 13 +++++++++----
 net/ipv4/tcp_minisocks.c |  3 ++-
 5 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 2ddc9076235b..9de5090fadfb 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -300,6 +300,7 @@ struct tcp_sock {
 	u32	delivered;	/* Total data packets delivered incl. rexmits */
 	u32	delivered_ce;	/* Like the above but only ECE marked packets */
 	u32	received_ce;	/* Like the above but for rcvd CE marked pkts */
+	u32	received_ecn_bytes[3];
 	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
 		unused2:4;
 	u32	app_limited;	/* limited until "delivered" reaches this val */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 93fffeb59a15..aff31ba1dea9 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -467,7 +467,8 @@ static inline int tcp_accecn_extract_syn_ect(u8 ace)
 bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect);
 void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
 			  u8 syn_ect_snt);
-void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb);
+void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
+			       u32 payload_len);
 
 enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
@@ -1034,11 +1035,26 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
  * See draft-ietf-tcpm-accurate-ecn for the latest values.
  */
 #define TCP_ACCECN_CEP_INIT_OFFSET 5
+#define TCP_ACCECN_E1B_INIT_OFFSET 1
+#define TCP_ACCECN_E0B_INIT_OFFSET 1
+#define TCP_ACCECN_CEB_INIT_OFFSET 0
+
+static inline void __tcp_accecn_init_bytes_counters(int *counter_array)
+{
+	BUILD_BUG_ON(INET_ECN_ECT_1 != 0x1);
+	BUILD_BUG_ON(INET_ECN_ECT_0 != 0x2);
+	BUILD_BUG_ON(INET_ECN_CE != 0x3);
+
+	counter_array[INET_ECN_ECT_1 - 1] = 0;
+	counter_array[INET_ECN_ECT_0 - 1] = 0;
+	counter_array[INET_ECN_CE - 1] = 0;
+}
 
 static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 {
 	tp->received_ce = 0;
 	tp->received_ce_pending = 0;
+	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 }
 
 /* State flags for sacked in struct tcp_skb_cb */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 3c8894de5495..49289b5243e3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5063,6 +5063,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5070,7 +5071,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 97 + 7);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 109 + 3);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 47da42707738..57e3cdb44a51 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6107,7 +6107,8 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
 }
 
 /* Updates Accurate ECN received counters from the received IP ECN field */
-void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
+void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
+			       u32 payload_len)
 {
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
@@ -6122,6 +6123,9 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
 		tp->received_ce += pcount;
 		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
 					      0xfU);
+
+		if (payload_len > 0)
+			tp->received_ecn_bytes[ecnfield - 1] += payload_len;
 	}
 }
 
@@ -6399,7 +6403,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 					flag |= __tcp_replace_ts_recent(tp,
 									delta);
 
-				tcp_ecn_received_counters(sk, skb);
+				tcp_ecn_received_counters(sk, skb, 0);
 
 				/* We know that such packets are checksummed
 				 * on entry.
@@ -6445,7 +6449,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
-			tcp_ecn_received_counters(sk, skb);
+			tcp_ecn_received_counters(sk, skb,
+						  len - tcp_header_len);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6492,7 +6497,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
 		tcp_fast_path_on(tp);
 	}
-	tcp_ecn_received_counters(sk, skb);
+	tcp_ecn_received_counters(sk, skb, len - th->doff * 4);
 
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
 	if ((int)reason < 0) {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 0e63f691a387..550c2d9d08b7 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -494,10 +494,11 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	if (treq->accecn_ok) {
+		const struct tcphdr *th = (const struct tcphdr *)skb->data;
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
-		tcp_ecn_received_counters(sk, skb);
+		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
 				     TCP_ECN_MODE_RFC3168 :
-- 
2.34.1


