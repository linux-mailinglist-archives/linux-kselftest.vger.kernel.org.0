Return-Path: <linux-kselftest+bounces-42524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F627BA5B1F
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 10:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1DB1C00127
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 08:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53682D73BE;
	Sat, 27 Sep 2025 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="XJi2Od8K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013065.outbound.protection.outlook.com [52.101.83.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B082D6E7E;
	Sat, 27 Sep 2025 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758962903; cv=fail; b=ppNbRvP3TAh5UhagiNwxoK9hi5bsgfjvm2ayx2ZJ9AbMSMS+M3ft7eh7frr80XxL+P0+/7DdXgiz+VELEeHFwXc6leq775InwgBb3QKVrtwTPr1f8KSdhmVRFChoAl0qmo6jbRxm/gDU+kZfvLBQWt8BhkPph/sG0Q8cTEmCwiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758962903; c=relaxed/simple;
	bh=Bmd1yqV6O1sES9qpyJ2kMDlR/P3iTbOt5T9WIWk1MmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OaxNQ84r4jHG/2aIAajhSC2IyiA3pO/vEYWV5XOJjjfL4B4mfsMfXD785mkk+2NR9S8gA70CPA+1sBeWjeXVBLBzGZUWHJlvZH1DDapMGEM49kR9ANhD6xKF1y4+DGEThXN4UNK/4qgThAWxmKuN+TqSBCNnYXAIDX9oGEfbsL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=XJi2Od8K; arc=fail smtp.client-ip=52.101.83.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shM140+nXsamBpOoalnGf/4+JNoOpcuFJh6tytOH7wL/PXLL0ZgWfpFKPMl3MDyDe9nozEEE6fubgPQ5E5kW5toDeyt2dwuR1KGD+O/ggCETYEPc4q4prX+x4yxeBNX2wqg59KFMkL4viip4M0by9bJaHr1wIihFLvQggnsU0ItwIJRLZNtSO7c653qTMnzzsWu1RMUBRuDOhStIvN7Ekz/rJRpEXcrKzcpgxb+Q8uiOSFffoVuKxXPC88eMcUtlChGk6dUdycoLzgOafsZFiO+B+oBpKSE1bALd4Wmc4JDLmxlurooRSP2102XSa/xwVro1WnS2xev0xQ9Ss/dYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uQ4bl4fU0QRZxb2AOptBsDSPl2kJgcYchY6xmeybn8=;
 b=hGMZ76bMgwkPLB0SqH7W8mNj4OdTR9ld3jJWXV0XKWdJuQKsjZI7jkXhdTRRX9yGxRBnN0TuT5GTLJN3HHCREU48J6pEM/VtKchEk1jzzNn5F5ygJmYYLEICjcYB+TuNVswOOex5ZdJ6kXtbFOAk8iA/W5nVuB+u8ebUvU7iZ3A7GHzUCwgrNLB4xBHLD8kCeR66mKwSi48ta46pOcX7xXJ5qczloYa7gmhEGZD61JvjPhEX5oxwmoQ0jsSJKn8oxN/qlJdEbszSzpF6W8HgnTeJp9g5pdxANZMzwcF3bEIQR2M/ciXc3YFETObpcNE79PP1+nhu7PsZCGzq+lAi+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uQ4bl4fU0QRZxb2AOptBsDSPl2kJgcYchY6xmeybn8=;
 b=XJi2Od8KoAoJt2EdOuGq1KU0QfNatoS9dhZCq6vCWt25nha4HZ/JPkZZcQpOvpwrb8LfN6GHbG/0bovMLtijAOO+ZJ5vmcY1ksGNfXXGqhl0TIbnG7yTh32ielnu0BQ3a67x0AuHH749zA7OByKshduFPFJ737V4OYJR+DSxN08+zEd78DScRcv1cjCWFloU0tMPhziM8aInq2TTfubDwCb2bFHzSe1FE5ex/7mLDzrzriX6FCoNsACJWeGpbQd1+7FjbzvSwb09WkXKZSWJT/tM1HCApJocwEdfpq1F3oyeLf1wySbnoFNez9W2pP3P0zQnQdH6ZJd4V/oYdwuoXQ==
Received: from AS4P191CA0033.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::20)
 by AS5PR07MB10057.eurprd07.prod.outlook.com (2603:10a6:20b:67d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Sat, 27 Sep
 2025 08:48:16 +0000
Received: from AM1PEPF000252DF.eurprd07.prod.outlook.com
 (2603:10a6:20b:657:cafe::1e) by AS4P191CA0033.outlook.office365.com
 (2603:10a6:20b:657::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.15 via Frontend Transport; Sat,
 27 Sep 2025 08:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM1PEPF000252DF.mail.protection.outlook.com (10.167.16.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Sat, 27 Sep 2025 08:48:16 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id A40CA200E3;
	Sat, 27 Sep 2025 11:48:14 +0300 (EEST)
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
Subject: [PATCH v3 net-next 05/12] tcp: accecn: handle unexpected AccECN negotiation feedback
Date: Sat, 27 Sep 2025 10:47:56 +0200
Message-Id: <20250927084803.17784-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DF:EE_|AS5PR07MB10057:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a1996082-fbf4-4d20-1254-08ddfda299b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b8JKKycJNq0Iw0HpjaGBe2yZvs7ulpLpUb1oMxuN/D8+/EMOk4PMZIBV9md4?=
 =?us-ascii?Q?1aSz9weA4vwFdZfeHk0aFXfIi6r/1cc9IJlIkEr2FTJzffd9W1zFuLw2nBpl?=
 =?us-ascii?Q?lBIqO0X/YCXGtHMxK5G7ZQ5R9CN87BRw8Pe4UUKXCodnd9Xxlc8r2NUfJDHX?=
 =?us-ascii?Q?rhaIzd5CPZkWM7gDDo9MI44Qj67OeBcKAYYxSvukiMXXgCUHKwpd76Qy8ptu?=
 =?us-ascii?Q?1mX501yuuQlck1nNREl8HNfmAew9dM4ZIeJKfA/t+VtQ2uztGbP1R87UHeLK?=
 =?us-ascii?Q?fGEYmGczBV/oNKvZ0zI8eD8XkpyXcxxY09HW4QKld5dwo1t+yJPNhBRWMmhM?=
 =?us-ascii?Q?GJymDQ0Lt+XHeQLzBxul2eVZ2d1rjm3MT7yejkRASCxPR5dE6Coj5r/NMO2h?=
 =?us-ascii?Q?FRvjY0otBmBD4ijp3e5NDBwkIWkI5S/IDmrT0KQlph+TovuTaM8wniLBReB7?=
 =?us-ascii?Q?uCIbXK5EzlR7ztFbRxUaO9I14N7jgaaPmiJqX5E5gmwUvfdz04Ian5Yb8Yqo?=
 =?us-ascii?Q?LKpvE+S9EF+j7CHg7THDQkzlWCL7gn7JBuzzquL60GaY+38rcXvYov1rdBFy?=
 =?us-ascii?Q?dw8zOkzJg12p7xWYLz5xFzJBsVGr1iRA5l+t9hUwrjwyoPNCa5dpBQpNqkQ5?=
 =?us-ascii?Q?pV1mMDgED+4g7oymxrHr0JD4lg8DO2pflM09hOwTXGVBpP/joADSv6P3Apes?=
 =?us-ascii?Q?6goVqCX4fJpDUYTx2TmUJpCS6wgIPLCqYSQp1mPIQFYIDt2sJ6M4MDQiBFpF?=
 =?us-ascii?Q?Qqwq5K62gl9uN3M/kZ+fpoLBRpulccDlrcULvz0E3S+l6gSc5oEBrDi1j/Ql?=
 =?us-ascii?Q?0er1I3YHY9SJm8hG7bwUXpX+tDogKJJvxYaB1hYjMOlDqRcgbaiTi5Q9/hz6?=
 =?us-ascii?Q?LB/kzPFvFppoApxqP1HFM0Y8SoQSepnbnDWDaZuMrr5NYjlBJ/W/vCKs6A53?=
 =?us-ascii?Q?AtTWFbYD5OnSW0pSAfK+elya2wWhBvXVYk3mZ/0EWhDmvp8aM1SV4SBLPtK6?=
 =?us-ascii?Q?70IO473kew/2oRPDldbq5QmBtnsz3/VgghkqFeh7czfP9mQVQfCcdI7zU8iF?=
 =?us-ascii?Q?i8G4AFnYhvTDz8DyFAuRWdiNQ+W4xyEs8tl7zGw/si7vBubKFgWBXoxCu6Si?=
 =?us-ascii?Q?DnJQwDv0IvgYHs4KYp/5OhUOjf9efNybbQAWcxfPNst6zR774DAs2/FU+H8a?=
 =?us-ascii?Q?96emyAY7/4aYyjpciwcZ+2V+bGeGUaHvyB2sdRDlijFLVYyIr51FHbFjrTUX?=
 =?us-ascii?Q?JnJPfBO/y782+PK0bebiBNODOH0+AVyCJSXcz3yb5a9+DqbmmaemZ0KVeinA?=
 =?us-ascii?Q?UYEguVYAXEnm6l+nate2h9+/9EdRN6/vid1Y5woO8XRaAmEbxacLyUdfExON?=
 =?us-ascii?Q?iPUemqt0xyM/fXzalqgBgn+x2asffACZtssVDJ288asvy4Dk6+xPN9fbDUMU?=
 =?us-ascii?Q?dZXU5vdQK6SWDTigThLHEygAw5e16qOUUHfb6EsQk0y734EefnWcXeGPrIGa?=
 =?us-ascii?Q?fUcxhLqymymmT727mlCFVEL2c4yU+fsDWYlhZ5172ph0cUBoC2d2VrB2GwN3?=
 =?us-ascii?Q?+OpnokAWT6+hAuH3nKowybNZjsSMoyDSFc8VGNZI?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2025 08:48:16.0707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1996082-fbf4-4d20-1254-08ddfda299b7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM1PEPF000252DF.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10057

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.1.2 of AccECN spec (RFC9768), if a TCP Client
has sent a SYN requesting AccECN feedback with (AE,CWR,ECE) = (1,1,1)
then receives a SYN/ACK with the currently reserved combination
(AE,CWR,ECE) = (1,0,1) but it does not have logic specific to such a
combination, the Client MUST enable AccECN mode as if the SYN/ACK
confirmed that the Server supported AccECN and as if it fed back that
the IP-ECN field on the SYN had arrived unchanged.

This patch fix an incorrect AccECN negoation of commit 3cae34274c79
("tcp: accecn: AccECN negotiation").

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v3:
- Update commit message to fix old AccECN commits.
---
 include/net/tcp_ecn.h | 44 ++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index a7ba21d298ff..c66f0d944e1c 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -473,6 +473,26 @@ static inline u8 tcp_accecn_option_init(const struct sk_buff *skb,
 	return TCP_ACCECN_OPT_COUNTER_SEEN;
 }
 
+static inline void tcp_ecn_rcv_synack_accecn(struct sock *sk,
+					     const struct sk_buff *skb, u8 dsf)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
+	tp->syn_ect_rcv = dsf & INET_ECN_MASK;
+	/* Demand Accurate ECN option in response to the SYN on the SYN/ACK
+	 * and the TCP server will try to send one more packet with an AccECN
+	 * Option at a later point during the connection.
+	 */
+	if (tp->rx_opt.accecn &&
+	    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
+
+		tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
+		tp->accecn_opt_demand = 2;
+	}
+}
+
 /* See Table 2 of the AccECN draft */
 static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
 				      const struct tcphdr *th, u8 ip_dsfield)
@@ -495,13 +515,11 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 		break;
 	case 0x1:
-	case 0x5:
 		/* +========+========+============+=============+
 		 * | A      | B      |  SYN/ACK   |  Feedback   |
 		 * |        |        |    B->A    |  Mode of A  |
 		 * |        |        | AE CWR ECE |             |
 		 * +========+========+============+=============+
-		 * | AccECN | Nonce  | 1   0   1  | (Reserved)  |
 		 * | AccECN | ECN    | 0   0   1  | Classic ECN |
 		 * | Nonce  | AccECN | 0   0   1  | Classic ECN |
 		 * | ECN    | AccECN | 0   0   1  | Classic ECN |
@@ -509,20 +527,20 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		 */
 		if (tcp_ca_no_fallback_rfc3168(sk))
 			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
-		else if (tcp_ecn_mode_pending(tp))
-			/* Downgrade from AccECN, or requested initially */
+		else
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		break;
-	default:
-		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
-		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
-		if (tp->rx_opt.accecn &&
-		    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
-			u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
-
-			tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
-			tp->accecn_opt_demand = 2;
+	case 0x5:
+		if (tcp_ecn_mode_pending(tp)) {
+			tcp_ecn_rcv_synack_accecn(sk, skb, ip_dsfield);
+			if (INET_ECN_is_ce(ip_dsfield)) {
+				tp->received_ce++;
+				tp->received_ce_pending++;
+			}
 		}
+		break;
+	default:
+		tcp_ecn_rcv_synack_accecn(sk, skb, ip_dsfield);
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
-- 
2.34.1


