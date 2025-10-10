Return-Path: <linux-kselftest+bounces-42957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61108BCD220
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 15:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179131A6781D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 13:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0D02F619F;
	Fri, 10 Oct 2025 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="kEa2JcmG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011029.outbound.protection.outlook.com [52.101.70.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDBE2F5324;
	Fri, 10 Oct 2025 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102273; cv=fail; b=LPlkc4XQk525MkvTD4vMHCREOQLVwgLwN5XH3N/YMkYNx8/Q83JYOBdTiene8b/Fems0EHfos6+gXqGx9MZ7boR0svaUyacN5IWDv/g4SeVw/n4t6gb5gTRK9Ss9BjUgjb6AJsXvvsrPir4g4ZmcNfSadG9SqgGmi5DHliWGTfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102273; c=relaxed/simple;
	bh=AYoR4N6THw8t3r8yBCuTokkdJr226+c27dQ8aMmd7pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjubuTAC0omMcZqkkcoUKF7X6iykpSFHqrhdgiNmeQT3Iv1/Zd6I5TXUW/VyePgG//tuss3XV2Ob8TvLJon35amiemKLbARzOwmaNOj3we1PpWV8czEkOSTWKZhjHQ7bsbSJPz7lpnnOmTWXb3oWmEZ8pjBmd0if212o6T2g6RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=kEa2JcmG; arc=fail smtp.client-ip=52.101.70.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbCBLk5pJGIZpUOJWYFPiamgIQnXBrpbDwLibzmyDnHsUXnWtKUZcAHB/SNSQHZpr7v9vOEvChjk65FkUtjyix9wULzn3pktb9C6ItoSr+CSL8VWDY5ypNl7S6zG8eTQHpEVlLSwCzFt57uVMlAkA0XwLWHmowcHEiPl2FjHkBBKgFHMdEYWRiDBHNUJf1ChMNXzJk2DC5KAKj6n/n5dBPB7axJG7vLhox0kFET4HwOuceRhu3XXg5Drd54O5/6rXhdPQy6FosIPjAnyD4Zx6xxGj7Mbwn8vi5Po/lIABikpEpKS/gvQeI87ddPxSUaqWxNntnDXT/xvw91ZbhqTVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs4n0ZaYS06ykjSoTviHfq2GxpUhjA9G9hIOioJYs7E=;
 b=vuObi89Hlgkm5eoD+XXqKaatEKTh44KZ3K5CnQ8WjyZAudSwA9cC4dsi0d1+qUfmFcSa+qKk7Ck4GKQTJsf3rohhDsBg/7y1Hv9bRMUVH46WyYnD0/2GuqUzv3mejOB8Jg2TPXUDk0Ktnp/6/i48tI6uKzIa2rfXLfAyoB/2BnlXbW7ysVwcxgcmjtOwnK47cSYgMb542hq+0fn7jDU6AqXnnukQcB4424iYytshtZ10gD+xkB19RNwMPMfl10So0jjzirW4f4Z3tlcreLeSphSr3ZCY+w/JnADZIIgGoXQ7qi+doJc0sri5IvIz1WdRIVux/9HH1Hwapw9FAfLG5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs4n0ZaYS06ykjSoTviHfq2GxpUhjA9G9hIOioJYs7E=;
 b=kEa2JcmGRdNigHtps1O66RlmZVNDFPkZLgN4u8+rYh4BhFDmG9cG6ZLu4Jcl22gwBflSKrJI2a/5Dsxcnje1d5KUC62IZxUJ5Jlm4IkLenxEz3aNzQy3tbfi5PtPAj9XMc5WlFglCQn0PHndDwgd66ApKhY/V844LPEcVjtZKhuhUHKNeYyfslPo5+YZOu55uXxhnYTLWbbQKaD1IU950hjfmkXhqIJcYBKwlzEucqfCWDOUCmRMfIRCrHEONrXig68DAlEfsLuW7LlVe4L0KOem7ZkhBjyC/AV4Y2jlOSqz4a79dkxpUbuFwRLnmnTRkAQgsAHnvp1jxtGT78/IXQ==
Received: from AM0PR10CA0038.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::18)
 by AM9PR07MB7875.eurprd07.prod.outlook.com (2603:10a6:20b:2fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 13:17:48 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:20b:150:cafe::58) by AM0PR10CA0038.outlook.office365.com
 (2603:10a6:20b:150::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 13:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Fri, 10 Oct 2025 13:17:47 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id A5D6C1C0042;
	Fri, 10 Oct 2025 16:17:45 +0300 (EEST)
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
Subject: [PATCH v4 net-next 09/13] tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
Date: Fri, 10 Oct 2025 15:17:23 +0200
Message-Id: <20251010131727.55196-10-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6A:EE_|AM9PR07MB7875:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 60fa87f9-35db-4d30-adc0-08de07ff67c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PmEWM2mWXe6CBrxPH+94mL39LJb2W3XqWI5V1hERQcoOAlV9oVZDRLyw2O+A?=
 =?us-ascii?Q?J0v03ruJXNBR0gKAuGzHb+CRxjZDCmFwjKWRF9MajuvwNYH11ZQ4VqMkDFkk?=
 =?us-ascii?Q?Ft8Ee5TPjN4Y/TlsP2TfIVda+G1E/DRjmxw1zScTMF+Y542TIfOaUrKLL4RE?=
 =?us-ascii?Q?vB9rzwGmjaf9xSVanFu4WY5kT1wiAN5znHGa+cVyvZ6Uyzq/AxiSl3LFP9i4?=
 =?us-ascii?Q?oDyo6OP5S5ThUPptElflOtbSs43OYLr3+DvMfxw8DYYTf5uOLUs7iRkE0ask?=
 =?us-ascii?Q?7ZG+q1lMwjdceBc6JuVzb8FSlWzEzMQxT4LfxrlbglIFtcyHfDlEzyZEAAFt?=
 =?us-ascii?Q?dXGUS4ozIp+y8ozVoEOxicEuKffQiqo3SaFpww/EBUTWHuRhm1dutE7XI+p0?=
 =?us-ascii?Q?k78yqgjlIQkvxGJ+Q9KJDcKsaY3guqJ1CoMaPoG1MpwXceGdIeK8UvBmwLJa?=
 =?us-ascii?Q?dlX+DbkXhub0OdzqTReb+3dRrp2Bk55UUVhP6Y8dbRctp2j9je/eYEkP8pPU?=
 =?us-ascii?Q?SIQvHxuahSKr2OL/tSGJXPf7KEHwI69F4ylF0YDikX12jnQB0YyvqZZZ5E0H?=
 =?us-ascii?Q?UVPcfodHv1t3yxifGv36DdEWNxSu67qNZM7MKOmiwx1fJbPP16T8OAvvbdPV?=
 =?us-ascii?Q?piJfkcCwmClFaYy6IDzejAlb4sk0J7KcySCypOrUdv4csZBS5esGfypMzrYo?=
 =?us-ascii?Q?HrztvErJxqwDbvmKnvliToG8pym99KcjyMarZm+/EB3MucEHHOpNIjRGse4f?=
 =?us-ascii?Q?PS/QvlRCnan7l1nXdldIkGZMlQUJPz96MYC668KhFxfI3QlW4fpj7+lRaRJO?=
 =?us-ascii?Q?N0ysC8p+mvKFq54e15M9AaL+FjpQFR2uA8KxhqwsKQlt2iq7hK80XB7mQP1+?=
 =?us-ascii?Q?9w/o2qPMHbTxK4SfVPn8ItJqZ/cgzFRrMTH9FURLeNjwAhWBv21wwDgd/rxP?=
 =?us-ascii?Q?NpkvkKwgrODLyJ5LEqGLF1XspZCij2H3WlgQ0JlQD7pAL8SWADQz0IKqeG2h?=
 =?us-ascii?Q?Hb/5LAJrYwMbaekMWG/cWW/67qiX8aJN15SEnMQTelZDcvIKRsPBgHoH6rtZ?=
 =?us-ascii?Q?ltCpOJDqk3yMEXG0Dgtz72uh6T7lZWBC+jbLYs402lgdEWEtei1dDJh4NN81?=
 =?us-ascii?Q?IGG4GsEBUuR3BOZyPrpWolDkyxu5SamifmHJrmYhLlYC1bca4Bmi+SfpYbTK?=
 =?us-ascii?Q?8eJiV4x49PQ6CWSbLwtSNkeGPssObbqjVQKdda/UAh57rniiXxN+zAh/ei6H?=
 =?us-ascii?Q?83QlHGv9GwDs7jbQqREHETGGwTZo/Uq2VooIWDSvO4dGM3QIVrE58n17Tg44?=
 =?us-ascii?Q?8rjSXJutdqpX3fhzJ399iNkAZVEg6ZhOfQS+VGrEb77pyjp1cEKtFkNh4Kf4?=
 =?us-ascii?Q?631nxzwnNATroHc8I/etW2uTm5fJAKakTNeBNeNB2eDjGNV62RWCgF8qKUQG?=
 =?us-ascii?Q?tQ0K/Mu61A8kXCiFp7CCiREZ+PrTLdryPjL+nj+oI869qM3bVV1uHL1eKMQq?=
 =?us-ascii?Q?QKT09Cx3e4oDKqEiLyQMYibzMCxzMBnIm/YNMfA2L+rhzB+ayLsH1hU4j03f?=
 =?us-ascii?Q?y4FZFnlKz8t/SWSzMHE8KtQPY1GZ46stZKEKWBI7?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 13:17:47.1790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fa87f9-35db-4d30-adc0-08de07ff67c8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7875

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Based on specification:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Based on Section 3.1.5 of AccECN spec (RFC9768), a TCP Server in
AccECN mode MUST NOT set ECT on any packet for the rest of the connection,
if it has received or sent at least one valid SYN or Acceptable SYN/ACK
with (AE,CWR,ECE) = (0,0,0) during the handshake.

In addition, a host in AccECN mode that is feeding back the IP-ECN
field on a SYN or SYN/ACK MUST feed back the IP-ECN field on the
latest valid SYN or acceptable SYN/ACK to arrive.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp_ecn.h    |  4 +++-
 net/ipv4/tcp_input.c     |  2 ++
 net/ipv4/tcp_minisocks.c | 33 +++++++++++++++++++++++----------
 net/ipv4/tcp_output.c    |  8 +++++---
 4 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 97a3a7f36aff..50551430b1fa 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -649,7 +649,8 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
 }
 
 static inline void
-tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
+tcp_ecn_make_synack(struct sock *sk, const struct request_sock *req,
+		    struct tcphdr *th)
 {
 	if (req->num_retrans < 1 || req->num_timeout < 1) {
 		if (tcp_rsk(req)->accecn_ok)
@@ -660,6 +661,7 @@ tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 		th->ae  = 0;
 		th->cwr = 0;
 		th->ece = 0;
+		tcp_accecn_fail_mode_set(tcp_sk(sk), TCP_ACCECN_ACE_FAIL_SEND);
 	}
 }
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4a6abf536dbe..f1e73e264b19 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6207,6 +6207,8 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	if (th->syn) {
 		if (tcp_ecn_mode_accecn(tp)) {
 			accecn_reflector = true;
+			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
+					  INET_ECN_MASK;
 			if (tp->rx_opt.accecn &&
 			    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
 				u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 1fade94813c6..ecead2b771fd 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -751,16 +751,29 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		 */
 		if (!tcp_oow_rate_limited(sock_net(sk), skb,
 					  LINUX_MIB_TCPACKSKIPPEDSYNRECV,
-					  &tcp_rsk(req)->last_oow_ack_time) &&
-
-		    !tcp_rtx_synack(sk, req)) {
-			unsigned long expires = jiffies;
-
-			expires += reqsk_timeout(req, TCP_RTO_MAX);
-			if (!fastopen)
-				mod_timer_pending(&req->rsk_timer, expires);
-			else
-				req->rsk_timer.expires = expires;
+					  &tcp_rsk(req)->last_oow_ack_time)) {
+			if (tcp_rsk(req)->accecn_ok) {
+				u8 ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
+					     INET_ECN_MASK;
+
+				tcp_rsk(req)->syn_ect_rcv = ect_rcv;
+				if (tcp_accecn_ace(tcp_hdr(skb)) == 0x0) {
+					u8 fail_mode = TCP_ACCECN_ACE_FAIL_RECV;
+
+					tcp_accecn_fail_mode_set(tcp_sk(sk),
+								 fail_mode);
+				}
+			}
+			if (!tcp_rtx_synack(sk, req)) {
+				unsigned long expires = jiffies;
+
+				expires += reqsk_timeout(req, TCP_RTO_MAX);
+				if (!fastopen)
+					mod_timer_pending(&req->rsk_timer,
+							  expires);
+				else
+					req->rsk_timer.expires = expires;
+			}
 		}
 		return NULL;
 	}
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f2e8a068f1d3..bd718e342638 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -334,11 +334,13 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 		return;
 
 	ecn_ect_1 = tp->ecn_flags & TCP_ECN_ECT_1;
-	if (ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp))
+	if (ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp) &&
+	    !tcp_accecn_ace_fail_send(tp))
 		__INET_ECN_xmit(sk, true);
 
 	if (tcp_ecn_mode_accecn(tp)) {
-		if (!ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp))
+		if (!ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp) &&
+		    !tcp_accecn_ace_fail_send(tp))
 			INET_ECN_xmit(sk);
 		tcp_accecn_set_ace(tp, skb, th);
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
@@ -3990,7 +3992,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	memset(th, 0, sizeof(struct tcphdr));
 	th->syn = 1;
 	th->ack = 1;
-	tcp_ecn_make_synack(req, th);
+	tcp_ecn_make_synack((struct sock *)sk, req, th);
 	th->source = htons(ireq->ir_num);
 	th->dest = ireq->ir_rmt_port;
 	skb->mark = ireq->ir_mark;
-- 
2.34.1


