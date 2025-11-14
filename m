Return-Path: <linux-kselftest+bounces-45620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09486C5BB9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7383B4046
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 07:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA2A2FAC16;
	Fri, 14 Nov 2025 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="nPgQQASL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8D12F83B3;
	Fri, 14 Nov 2025 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104454; cv=fail; b=pz3IM8py9yU7WulZP+8YFPN2NTcAzLcOKjv6Z1jQzf3/gK8E4TQgYojbi2xJyUtsjGnZ3/hQv00UbL6Dsjyrh5ysu6+ObCTwt2W1ylOm6ODA8tPs1fJou7Ffx2qiviHe9qa34MHgP/vBaXCLeTMwrRvoTL3YzfVs4bd9sgawPOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104454; c=relaxed/simple;
	bh=Tbxrku9UDXe1WskClpxfRhgbDqQVukHy16K6i4RtDXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J7v+QKtQdKuwI/2ImJvdg+7IZt9iPth1dfGWlhBQS1LAUP6w+VsmMk0a3UBOTv7s+oCpjmAeA1oFX1J+Jqr7XRH9zaTaKXbJ1iMyg61c4A3/M9yaDXiYAoatYVS9jsca9mBbqt+E6SUo8JNOVzMUS0VgxX5IzwMFJHthtFnZ7cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=nPgQQASL; arc=fail smtp.client-ip=52.101.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUSeVskHRzYnMckpOluH/SipJWetpYGlRwbFiM5pbp2yLQW/6oAyVa9C9KlJ0DwK2GlJuZ83OBDrN1CDFHqQMHDZLynNkKVHHfXx7EoBbHsjuD2tN1f/d/jMYgHMvippqBqU3K0yVeEAFUWwUj71dizhxtP2Tz70tGHdDYbOuUI4gLe68mHtxRfEolrKNNikij2+w55kP3iAfCpkhMxSKKuOjssp4qqWEs3awZiAKsOlpFvLamvOV9upo+fUnyAP/gtaUaQ9uv4tYL1QIHjx2IAmLLeJQKKgB3LsCkSFHPCLao7rx60DXnHO2Keks7S6V8wCJ48gy+xEjF7NPP8UEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7B1UPys3cw1Ek16aEc45ZhAPLh7QDV3dwz1Cz2M08s=;
 b=a2VgG/IoGawHgwF9KsY4qKmjY7m9vqOmhrhjT+N4CVgY9gvSwbPsrFRrq2AkFWTW41M6n/e+wiL4M1651iB68jQZ2Co0xPaK3D98WG2Swg0punT/wZgwj6lkXkB0VCYjUExEsPorJGg+8Mh1zJKtdiYBmGarkn5oBoudAGnJflF5fYg2yw2t+c3eiizi6pL400m/DZxxRCPiDMQO+rChzGFO2mJoc4pzXXEyNlg1vTED1mX4H1PpIjd/7TqIoy5Nmq5q8Zfd3TaNfm6YlBGp2b7yJf2x9yoMQkwdR+EgalZTCsEYTLR3OSmXAStqfNnlU2HRurDHI8dJJ+gpDv2a+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7B1UPys3cw1Ek16aEc45ZhAPLh7QDV3dwz1Cz2M08s=;
 b=nPgQQASLRoYfW+7MsevfJnlq9xDI82Bo6j7sqE68AWhzZyLrhO129ZURjslCdxlmv4hLpK/xyIUshNvdgIqHYPULEfFPS+jjB4kMRAV/cjDI4idqEwzCPT1ruGVKjeofMSFL2lUrpFuKc+MXM1o0HAaks1KTHg5VMlARe2btQcMnzMtQfdNybc0At3+Je+7G7di64CyADELGwKFh/yrMkU5k5DtyNwyAkkbBk6CtJrjfW1+UaJZNYPrZQH82Er9v5deOtQSXmVE771HN5a2Av8iAe0nhyZORr5qxS304IA7v8RD/ESw6olrHybIr7xnLERkbRGKGmhKZ8uzxamZr0w==
Received: from DB9PR01CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::22) by AM7PR07MB6405.eurprd07.prod.outlook.com
 (2603:10a6:20b:132::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 07:14:08 +0000
Received: from DB1PEPF000509FF.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::36) by DB9PR01CA0017.outlook.office365.com
 (2603:10a6:10:1d8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 07:13:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509FF.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.13
 via Frontend Transport; Fri, 14 Nov 2025 07:14:08 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id BFE591C0043;
	Fri, 14 Nov 2025 09:14:06 +0200 (EET)
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
Subject: [PATCH v6 net-next 08/14] tcp: accecn: retransmit downgraded SYN in AccECN negotiation
Date: Fri, 14 Nov 2025 08:13:39 +0100
Message-Id: <20251114071345.10769-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FF:EE_|AM7PR07MB6405:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e96e50b4-db41-4b4b-1956-08de234d673e
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?P6hPhAHmnduY88p0dsEM4LYII6JU+gubH4bHzLc+F9/5xGm027xhectG/9sn?=
 =?us-ascii?Q?yxL7q8fUg+UWDE0yOSFBB2gDQH4kcEFh05irTihk+y4OH+x65lzDCUnNuTOO?=
 =?us-ascii?Q?JAZHpNbgMoNh7cvTJibN1LItl5zRyXZKjLez6z5U5CxGObEXu2f967BnpO07?=
 =?us-ascii?Q?No8AOxyesSuztr40RFqtgaqYCVhr5hJxaziQO9wkBKaxbZL7bHKRGYCEkq+F?=
 =?us-ascii?Q?ebpwOybCoREvf3bTm1PwX1Odsd5dJiKYeJO0iTG1jM21IS8KUlW/i0tNVDpF?=
 =?us-ascii?Q?EW4gklh1TT0jmaEL9UvrWgt86bF88+MCT8Pz9oi99u2Pyf7cuz/FTghvcT76?=
 =?us-ascii?Q?RNi3GnWTLljsPFxB2AqFRfaoqzAJGkxzHtHQIM+d8w9QHc4dhKvkU0I9bXbj?=
 =?us-ascii?Q?u0IxrpdkY2fZxB2enQo8TPuWrL9xHO8UhDvNfBQ0sFM3kJ7ka0N0kdEFc0gn?=
 =?us-ascii?Q?H0QCJYHXh+7c7rN0raLlxEGQASWV2KZBZfsO/zhQC9adDidxv4ZTwMLjNd+u?=
 =?us-ascii?Q?TRkngl0Mc33lKxCw9ELFtXfj+ip9KxGq/Gbb7fIVefhDZUNZKVJ8grjfaKAX?=
 =?us-ascii?Q?aNIA/ICoXB7gk0qeSQpDlFA3eYO51fWuHMfS0OoGVuvHGZM34gPU5KWPjyEB?=
 =?us-ascii?Q?tCvZdXVyksEQ3bx9heGk8pWPSxCKnU/HPmwEy0CohIAzJCpT+1HWQt1+WC3A?=
 =?us-ascii?Q?JP0ISZcBSeZhndNCHjyDZhPIZiUzXwNO9KkcUS9OHi3RzbvLZzLBX/3hUC+G?=
 =?us-ascii?Q?V3DQDdQLYXj345pNmGc4NWE6tWRbXAIj61tUTsMDTSmw1COj1DF7/iXECkLe?=
 =?us-ascii?Q?CPl4aedFus3Q14ed5wKUh4RiHS7UTrezVXfdgQSPiSL/UB8+suT0xX8K5e5y?=
 =?us-ascii?Q?KNQ5iBMj528j4O6VV3BzkG87qHVOqD0OWyewxbdh1xAdCWlIYnGNwCGZUV3D?=
 =?us-ascii?Q?fLfPMSflrWWoopYlF0xwSQ36vhpINlE3ZJYGN04dJqukbNFaSSMA3QHWirkj?=
 =?us-ascii?Q?adfoZw50MwyMs78hyQUMUsqy4cdB+sHy5kaFPIVxrrKTLyQ2ePTZuewvKbje?=
 =?us-ascii?Q?wjzwI9YR9ebBW9JElGtFfyJTbpghvMT1lYKd1XZ/0Sv31LQG16mYAUAoguQH?=
 =?us-ascii?Q?clnpsgMJ8fSZA0XI3iI+U0HTQIxlRDdCPWG/HRjaGEmebFG/heVIW04l95wo?=
 =?us-ascii?Q?4YUjGvz/dFS9fP2juZIhUK7s2ZhAx4DFR1VGPLvFde8whPn2BDgHOa1Cu+fv?=
 =?us-ascii?Q?mqMUmGRWMHe4JwFpqPgSBdaHTf+sQUCVZ8A5qGVl1Z9xM+3LDguoyiRZ9wqH?=
 =?us-ascii?Q?A4LC0nmE4RgNYIwmVmsEX2iBiHMV+nzEYJsmLOp5JoYYrhc6XxWS/tUmMFhF?=
 =?us-ascii?Q?C/ryvYjwPB3MZltSuOMQjXbTCn5jYemU94qkQYldznrh66aMCf6pY0bj5KCN?=
 =?us-ascii?Q?OeXq1Td+Wy/+RMTmhj5Qf5gEi8OaIMmlLbUySuOa1/Lwyh23/jo8gUIe+Gwb?=
 =?us-ascii?Q?fyeGTCtRqlWhhknPCIHd6qaSHuNaH6jgk44LIKOPsKGUV11bKvs7QTD1K7wt?=
 =?us-ascii?Q?2wVfS5Mv3R12Xe6rENewv58KLjdmwg0FHhW8ln8b?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:14:08.3972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e96e50b4-db41-4b4b-1956-08de234d673e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6405

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Based on AccECN spec (RFC9768), if the sender of an AccECN SYN
(the TCP Client) times out before receiving the SYN/ACK, it SHOULD
attempt to negotiate the use of AccECN at least one more time by
continuing to set all three TCP ECN flags (AE,CWR,ECE) = (1,1,1) on
the first retransmitted SYN (using the usual retransmission time-outs).

If this first retransmission also fails to be acknowledged, in
deployment scenarios where AccECN path traversal might be problematic,
the TCP Client SHOULD send subsequent retransmissions of the SYN with
the three TCP-ECN flags cleared (AE,CWR,ECE) = (0,0,0).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v5:
- Update commit message and the if condition statement.
---
 net/ipv4/tcp_output.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 479afb714bdf..8039c726d235 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3571,12 +3571,15 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 			tcp_retrans_try_collapse(sk, skb, avail_wnd);
 	}
 
-	/* RFC3168, section 6.1.1.1. ECN fallback
-	 * As AccECN uses the same SYN flags (+ AE), this check covers both
-	 * cases.
-	 */
-	if ((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN_ECN) == TCPHDR_SYN_ECN)
-		tcp_ecn_clear_syn(sk, skb);
+	if (!tcp_ecn_mode_pending(tp) || icsk->icsk_retransmits > 1) {
+		/* RFC3168, section 6.1.1.1. ECN fallback
+		 * As AccECN uses the same SYN flags (+ AE), this check
+		 * covers both cases.
+		 */
+		if ((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN_ECN) ==
+		    TCPHDR_SYN_ECN)
+			tcp_ecn_clear_syn(sk, skb);
+	}
 
 	/* Update global and local TCP statistics. */
 	segs = tcp_skb_pcount(skb);
-- 
2.34.1


