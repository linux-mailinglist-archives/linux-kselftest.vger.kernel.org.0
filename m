Return-Path: <linux-kselftest+bounces-30699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBD8A88173
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F439188F6DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0BC2E3392;
	Mon, 14 Apr 2025 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="AcKRU+rg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1AD2D3A87;
	Mon, 14 Apr 2025 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636463; cv=fail; b=CxMik0fknLJ2lYnTl9ShL4Jtw8GSK0kJFqiZN+jAoQysi1IfewGMBYyWGIw0ASSSnBZigBenTeodHtadClq9exuC/9XBwfrP8wT56bQYE5nwBNN/6c4IwAW5TZhG8j8ZXX3KTw/UkcssbFezwAbZfX9eo9VQJ6iCpYo+BMq6EF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636463; c=relaxed/simple;
	bh=O+Ij6PnJNya24eNiQTfN4/gm9ym90RRZa7lNIALkuHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+G48viRewUC4AZvWXd64RlLUnl/2Z4lDCUgb/6tHQGVFUyfg2J2wC69Po339nD4/ffC+y0GNluwLQ6XuMtQ2qZF9AGpgOricKmtXusMaMLpWuEoldbHmZ5ujZbmfO5Y0Ja8JaooWBoGy+wSWMS5d5OtOws5D9eyMt6QkBZ3Kzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=AcKRU+rg; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIJql9kDWJoo3bSU+LXdF4OmauGQLc80cuCkWYvFN5tI8GRshgU7ktq0LSTuXyS4dsIsNSB16Xdu30fzoTgge0cigjJt6zY7jw6FBxLtB+2WstDajqmTEqvGjIrbK86KY6S5UGnT4N4tEFTDQZ9YKjpGCaDe7/KWYgqUzqCwBFFO3T7o3PKU+oXZgmVpD08cuxHaPk2aLtkXx0DrcIfXH6kzH8tzGxndEXmM5qTdagQgDslfeevIBgeH28F/Tn89HcKsUUugo+L9A4Ldeq4LPNJPXfI7Od2RzponIwT9a5OTLsn9TJLnQfLjMs3y2g2+PZdPl2hwH9G3T++kpBjxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKL/5UK0OSKaRdCSKsrub6d7dkYoherKF2ghFpWUBbM=;
 b=Tb2nFWHBuSSzOFSPXiIvLE5rcacE95lPSA2+FDR5FcmPlh/it5+RyQgCP1kzWcr9W9KyYmC5ae+N0dmOL/D5ZipsKv71X4TAQPJSzXsz/dbxFq+L0X0r6wM47B2oceyB0Hsgt1jaizdE/beCVuTxwaKgeuPRuBRZ/Gn8NfU/1TtTuABcmDomhE5nbVGqDYi9rjbCNl619h2wjzHQoI133xUK6RR/9LGxJkGMSQnATly5Czi37rgPrusp7VyyEhpdO0jmuDQ+ZKJ1emlotfNtv3fshzrT3lt2/xzbbTDRUL4MSA6TZg+efCLPZWhELP7YoQC2Tm3T4+9f/t99SuqRbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKL/5UK0OSKaRdCSKsrub6d7dkYoherKF2ghFpWUBbM=;
 b=AcKRU+rgv8sSxZ5pA2n/E4T8JXElGihib6rvoyEW6RoKszauyeOhFjzeCjwG7p9X7Vi2Z6FL8mhf9TSFBizHB74TN2mhNj+A0s05fwSsRLBocqDPlhS6v2vAutAXmXqEhWbV5LC0oRDJERx/+V75uC1DtknZJxxf08YGqr+Url0tlSsO+CVRkzEECZAB+gRrcaLpHL+p/ZmC2NsOY9bcm22LKru+7V+YKhNJGYeXQuqFKCbk25kFvNPkbE5KmG2mf+xRxTjfwFezdyXSQJQZfrUo7E38ttSMZx2i7/gm/+rWWrRBtXbUUoUaet4ZWoMLmr+B4f5xUmAAni7M6pOTwg==
Received: from CWXP123CA0002.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:73::14)
 by AS4PR07MB9657.eurprd07.prod.outlook.com (2603:10a6:20b:4f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 13:14:17 +0000
Received: from AM3PEPF0000A791.eurprd04.prod.outlook.com
 (2603:10a6:401:73:cafe::d6) by CWXP123CA0002.outlook.office365.com
 (2603:10a6:401:73::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 13:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A791.mail.protection.outlook.com (10.167.16.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 13:14:16 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 53EDDQBN009623;
	Mon, 14 Apr 2025 13:14:15 GMT
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
Subject: [PATCH v3 net-next 12/15] tcp: accecn: AccECN option ceb/cep heuristic
Date: Mon, 14 Apr 2025 15:13:12 +0200
Message-Id: <20250414131315.97456-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414131315.97456-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414131315.97456-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A791:EE_|AS4PR07MB9657:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e10be1-492b-4bd1-261c-08dd7b56427c
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?M3lnSHMxY1VKOUdFQUNqZllXQ0xXWmFwSlE0MTIrUjNQSFJIQkFCQmFxVFpO?=
 =?utf-8?B?a05NSFg3OVBKMElyUUlNZzhIT0R0cjdjVlpSU0w4QUp4YXVmdW1jNFNIcG1Z?=
 =?utf-8?B?WHErVkgrL0hLWnVmNUJOeHZVUHZMaXhJTFlvWlpRbnh3dGZFdlpmL2Evb0RT?=
 =?utf-8?B?eFF3QktJL0dlMmJVNVpDSDBrclRjc0tJU3ZkbEU4a295QnVIZkxtWEtDTlNP?=
 =?utf-8?B?L3JxS1NoTUhtRFNNUG01VlZqZ1EvWDg3b0NvWU8rOS80dnFyZE5oM2RObEVJ?=
 =?utf-8?B?YnZPaVdKSTBwVTUvUVFtYzBUZkV5elNUenpjd0wvV0xLbENLMFc2amNZV2tT?=
 =?utf-8?B?d1QxWGdPcE1ZNWdLWlQ2djFkZGM5emRRc2xoMHVJUVd2RUtqbDQrL1ExS0lB?=
 =?utf-8?B?dDE3NmlaRGg4ajRWYk5JZktxcFU3bHlIS096ZVI1UXFQNjZZWkg5bXduTFdC?=
 =?utf-8?B?bWsvc2c4MmMyblVCNDJ6cCtxcnAvRXcxUm1pVE1sL01RdHk5YkZlUnJETll5?=
 =?utf-8?B?Zk11dHhRajB0QWtrb1dwczVRNmcyU0tXbk13Z2FoNVBHTU9rVnExb3RRTUd6?=
 =?utf-8?B?WGtCNWM1OW8ySzFmNk9uVExXWnE5V2VwUGR0dDVLVzBabThCSk9TOXhCZHR2?=
 =?utf-8?B?NUdpWHlSSFRnNndmdmRaVytUUFZ0QXE0NlA1b1N1TkwvdERqSmJweFhWOSsw?=
 =?utf-8?B?ZUNoRHRwd3U2NytXZTdFQVQ5cWFuTU9tLzhpOTBmWW0wY2hEU1h1RXFyR3Zo?=
 =?utf-8?B?bS8xZEJKYXdZZWpiNlVNUzdrbE5lbjBRQmlXNFhyN0VtdnVQV2tYOVcwRTJm?=
 =?utf-8?B?SWF1Q2lkSWlqYmFZOHJZY0NzSFhGOWt5bWxnaXNkZUNHYngvL0tlWjRJd3Qx?=
 =?utf-8?B?TXJ0Z0t0eldORmZ6RTE2TDdVTW15MGUwT252ZHNWelRNS0d0VzkvZnpUeWFU?=
 =?utf-8?B?b0VwNVVwcG53ZVdTQlFQSkNQZXk2Q2p2MW0xaFZXalBmcUUxSFNlTG9BNjRJ?=
 =?utf-8?B?YlRjV244aThJeHRGd1ZQSFAzUTBZK2V6WWdqMmVIc0FxeWdweVRjOUVaczVY?=
 =?utf-8?B?MjFWS2NOTW9WQ2toQWhjMnhBSHhMV041L2tNK2ZzLzFrem02dlNGWjZYUUVQ?=
 =?utf-8?B?aG5rdkpOWDlsMlNFQURDTU5CUHdqa2Vmby9aYmJmZGlncnVUbVN0L0Y5VkUv?=
 =?utf-8?B?SlNpUVVWK3BQU3dGZnUyUmhrTlA2UkFCWVM2c1lxQTB2akIyUFVDcVkycHJy?=
 =?utf-8?B?OFBEZ0NBK3IvL3cwTEhhd3BJSTEyZnJLWjRVdjJRbHRXSXRDZXlsU29hWjh2?=
 =?utf-8?B?L3VKcnBGYnFxZzdUay92dWVkOGMrMGpXU3htVlR0aDZ0R25QYnBUN2hza0wv?=
 =?utf-8?B?M2lOQmZnTEFxLzBNQ2F0VXBKV0FSRTQzYUQ5QXR6Vk14V05paERIeTRzSnNi?=
 =?utf-8?B?QnlxRXpxdHg4V3JPVUxNaWZHbmIrdW5sVzRLWTU5a0lVYVg4SS9BYzFnVFYw?=
 =?utf-8?B?bzV0ZmVNTEJDcDQvcmlLODd4VEEySENaMFlTUlZ5YStjcDlLNUFRa2svSGlx?=
 =?utf-8?B?OW95NHZHZ2xWaFFVZlplUklHcGVZNWcxWUJsZ2VxdWJFVms5S1UrV09FbFlN?=
 =?utf-8?B?clFNckxpZCtYaHBQcE9nQ3phblNXaTdORjcyOG5vcFpsZGIrWHhkVVlFdCts?=
 =?utf-8?B?VjFRamJ2bWpobWUwdGR0TDlvN3A5aVRyOUVNRmo4a2U5SGltWVRPbzJYcnFz?=
 =?utf-8?B?czBLZHlDN0hjUzRKT09DT3ZEdU5vcFBFRzdNbUtuQjc5aTZEOS9CejE0ek9z?=
 =?utf-8?B?QlFIamh4aU9iQUhETDBZRWtkWTFEWEkwY1pQdFNRanVqSnlVR3RtUzg5dWZy?=
 =?utf-8?B?bERxdWxaK1lSeTljVE8rdXZGVnZCRGMyeWRBbCtoVmwvN1pKaXRRYkZTVjZj?=
 =?utf-8?B?NTI1SVVmYXpKZnA3aUlOakd3SWZ5ajl5NFJPY2N2ZFBoc1d0Qm1aVmk0ODBz?=
 =?utf-8?B?NURFL25JbFM5eFdEeXgvQ1lpelNHT05qRm1VT3Yrd0J3QXVoMmNKWG1SelFM?=
 =?utf-8?B?QTR1STZwL1V1SVArb2h3eEpsdWtJUlJkY3Vsdz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:14:16.8533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e10be1-492b-4bd1-261c-08dd7b56427c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB9657

From: Ilpo Järvinen <ij@kernel.org>

The heuristic algorithm from draft-11 Appendix A.2.2 to
mitigate against false ACE field overflows.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp_input.c | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0ade2873b84e..3ceed4792d13 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -244,6 +244,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCP_ACCECN_MAXSIZE		(TCPOLEN_ACCECN_BASE + \
 					 TCPOLEN_ACCECN_PERFIELD * \
 					 TCP_ACCECN_NUMFIELDS)
+#define TCP_ACCECN_SAFETY_SHIFT		1 /* SAFETY_FACTOR in accecn draft */
 
 /* tp->accecn_fail_mode */
 #define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8f1e10530880..54f798161d14 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -694,16 +694,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
 				int flag)
 {
+	u32 old_ceb = tcp_sk(sk)->delivered_ecn_bytes[INET_ECN_CE - 1];
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 delta, safe_delta;
+	u32 delta, safe_delta, d_ceb;
+	bool opt_deltas_valid;
 	u32 corrected_ace;
 
 	/* Reordered ACK or uncertain due to lack of data to send and ts */
 	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
 		return 0;
 
-	tcp_accecn_process_option(tp, skb, delivered_bytes, flag);
+	opt_deltas_valid = tcp_accecn_process_option(tp, skb,
+						     delivered_bytes, flag);
 
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
@@ -726,6 +729,17 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	safe_delta = delivered_pkts -
 		     ((delivered_pkts - delta) & TCP_ACCECN_CEP_ACE_MASK);
 
+	if (opt_deltas_valid) {
+		d_ceb = tp->delivered_ecn_bytes[INET_ECN_CE - 1] - old_ceb;
+		if (!d_ceb)
+			return delta;
+		if (d_ceb > delta * tp->mss_cache)
+			return safe_delta;
+		if (d_ceb <
+		    safe_delta * tp->mss_cache >> TCP_ACCECN_SAFETY_SHIFT)
+			return delta;
+	}
+
 	return safe_delta;
 }
 
-- 
2.34.1


