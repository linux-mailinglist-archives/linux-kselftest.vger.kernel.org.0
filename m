Return-Path: <linux-kselftest+bounces-45622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AC8C5BBFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 715524F5617
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 07:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A962FB99A;
	Fri, 14 Nov 2025 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="CXrJN63h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011044.outbound.protection.outlook.com [52.101.65.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE442FB962;
	Fri, 14 Nov 2025 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104459; cv=fail; b=YU1e2PgA3uRWx8hlJ+7Xrg/IUa1fxkKeBs7ri+uVwnazXmyMLMx1nW07L3uUx5cSg3JQKjwHn5NdOM/t0CmU+pnruujSZv5cuAozuM4eCvlHypHIu3mWzOSBw/vt+eh6uckzsTpl12h2GYA4t2DHUaQmqcWqgVlesIY9yRwbjhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104459; c=relaxed/simple;
	bh=6G3r00wKvuJIBMW0i4Z29Bjyxwm2/Lg1/qROVfh/Sx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/+GBh5dQeDxrBjFbzDiEv25HqOaUaA1yu1k0+RRVjKaBnL/wZ0sZl7FDm43ETmSDD4uWbVNndGwhDxCGkofRqqacAWyB+x0KlXwQrd3+aTgG3bOdh+VGlNAPkDcOZRorzXjkDYz8xXZaWvTIxE+GV0m8QCAv0rNhZm7PMrRi5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=CXrJN63h; arc=fail smtp.client-ip=52.101.65.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoxTkUkZ7YVtZRvCQivfykk7tmReockJNqOdTohCB75fFwxt9aYhaplUGqViuTGRa76mALY9wzR1hJGoKsUIXibkDYjzvGVOfXWi5vUvOJJC6Wb7w2fezb294J0bzDk7VNTahxL92+LK0YxNyiQsAlpxInAH6zS3qR8yHrCrvJ2E/pYxkh9ogiNTZ/7eoqJq+K2QGg7tfR57GqRH4Ih2sf8YXqyg7ctXUZPRTEgUt/8EPU6AsqGnH6r1eFNyxDUX+5r8OZxj46W2vJ7ovXVxUtChGm1Uq6HuVKsz60Qp27iBMvjj9ZsPVBpCuEQkyAs7wHWWDUHO1a5jVQJU0ozRBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eLaiXbaLVBYO9BxW9z9ybWPeCCSCRzM4LKcwQ1M5BU=;
 b=I8OO/6mO0aatQ1sf6dhOSMuAQFLwOskLrJosrx6UaoUDFBnuLl6R8DR74W6Jm3YIWSskDUVg1hjUgonphtGr8qsw5I2rSBYAh9sJbbmVxUwOvN/a2lMdkOjX1rPPJJkVZj6perLZrgOAAINE9Og0XNnafdiduz8s0TD+0gTQY/c7kvCwAfoR+drQDwHm268OQxvu8CuNbMdqYeFKpd3W2kmscHFiaVuIgQTrEg1pEWZ6shdwmbdDNk5+2WHCuMzFhCk0b/2nBgn0hrWcCVJGrRkhwm3xaXDYft8nW153E+cnYoAzLO/M5IlAsWRSNNLggSYHGjIvl/nwyGNt3SpM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eLaiXbaLVBYO9BxW9z9ybWPeCCSCRzM4LKcwQ1M5BU=;
 b=CXrJN63hgB5infnbqMlRmZ0yuqqbawsnAceCzS/riO9wy0MQvdkIgl6PskaBhjC8ffmjOE/lIJ8bOrA6rs2lJ1ITn1tezuVhVSG7IKzxpknUe+xeMzV1Aj0dYlKLYhE/FIr5Nt4vCspgi6RLp4/aJGcU8BYn6usIu+yT+2JwFCkvuO8cA8gVlbDO+lbwIGhNdBjDuRFvZpca4ymdJehFDMA1UtjYgpb4lBk5mPcMEMkBiidMhDpOV5ct8t685ol1IClOQKttFC+MoNY28f12kAwXY9FP+w+0J+fSqMo9d+OptRb99kh9COzeScHH38mP//u5aQJ8I2f280CsJrK4qQ==
Received: from AM0PR02CA0143.eurprd02.prod.outlook.com (2603:10a6:20b:28d::10)
 by AM9PR07MB7956.eurprd07.prod.outlook.com (2603:10a6:20b:30d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 07:14:13 +0000
Received: from AM2PEPF0001C70E.eurprd05.prod.outlook.com
 (2603:10a6:20b:28d:cafe::3a) by AM0PR02CA0143.outlook.office365.com
 (2603:10a6:20b:28d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Fri,
 14 Nov 2025 07:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM2PEPF0001C70E.mail.protection.outlook.com (10.167.16.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.13
 via Frontend Transport; Fri, 14 Nov 2025 07:14:12 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id C89871C0030;
	Fri, 14 Nov 2025 09:14:10 +0200 (EET)
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
Subject: [PATCH v6 net-next 10/14] tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN SYN/ACK
Date: Fri, 14 Nov 2025 08:13:41 +0100
Message-Id: <20251114071345.10769-11-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70E:EE_|AM9PR07MB7956:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 918b6882-a9a7-4ede-4253-08de234d699b
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?E+2lW/YFDTXNTpzCl6EtbsSgpdQio7JRWFSOjytg28n1RrH5vK5awoI0PwfO?=
 =?us-ascii?Q?pRXU1P/1Xnv3T9j7jBPze7rsqP1Z3uq8L6Un1Zeg7/U8CWKz86QfPZVCG4kP?=
 =?us-ascii?Q?PtwSUDIr1rI1+zn0hZnIJ0G9JwSoEdysgpyEOGRpkzeesO2pVO3d+pmVBiDH?=
 =?us-ascii?Q?TQCmAAYhDq/TrRUr5CS2mLrBWqZ+oaEtth3xEjEsnYkuWRO71G5Ipv+I6/2t?=
 =?us-ascii?Q?cgM9WjfscVbq5JfFrlTLTwdOTI0W7Sgza4JPO64Bu0z1V9eldaBvNAja1SeJ?=
 =?us-ascii?Q?6Jmxv/A1q1helGLsXU5lOq+/vsa85J4W+HzURB9rG//ieIHSsQ3k5KvUx4PR?=
 =?us-ascii?Q?3DgaUipQ1PhCp4/QQ+7ssQD3jim+FZfwVbRsj0dY8PH8wI5EZmmewMvbrteU?=
 =?us-ascii?Q?x6elko79N4qmlqvEiWh7F6UdJA1acaYnW9KXsvV3U7LfeAPxvOLVVoYpbaMM?=
 =?us-ascii?Q?UBLbKXRS5QSpXPJOmh8xx0CCdyt/Aw6OMuQrpeaOySIRDPOr6QuQ23Op/YSm?=
 =?us-ascii?Q?bqJgMCgBaN+/P1tlHo0RKix0YazdvgoLYT7JxZgpi4WQDanWD45LSccFAKJv?=
 =?us-ascii?Q?aCA7WVIgMDMmhsVT2REuhJB6NB/d1U8+1a129XEllpwzvmxbFphASZ9mp3H1?=
 =?us-ascii?Q?p1Z5MRrwy1azxHL4ils9fDMW8+dnOGjGN5yUDDd7EyaFy8pkViIDkaJxp+59?=
 =?us-ascii?Q?r+3J99m9L0V7mAomAUB1rk2Y5tPHMoM6SzNbsA1ILA6nm5Z9C57upejL3p4o?=
 =?us-ascii?Q?TZndGc8ArcAFjv22jTv7GoueZvGKUfrNS3dh+1YTwKVaKUvPtWTV02ArLTnC?=
 =?us-ascii?Q?BRsFAkRCrtPu3OImevpL939hTswjLuVFtmuDR4xTCtN2/zJVKrZ1H/B66CT/?=
 =?us-ascii?Q?k2PDdsSkD2Q/zA7tZWBJVR7TCnRy7+CvNESTiMBGflX0BnBuk32gFOA+viih?=
 =?us-ascii?Q?yqfv4o6BSlRKgo0FiV609K8F5rFhOs9aW1Wu1y/I/sxVQtBekEwksItOJUoc?=
 =?us-ascii?Q?gkIuB5OYz8HwG3snFTGUQr+oQ2qZ+U1KL24yHGp1tESAaIaxiSiiiAzrbC32?=
 =?us-ascii?Q?bgJdTOLXtcAnDmmzQLlydhwHWdIK7AyDP925NSyqA2RK3s3lfJm4hzr7uN42?=
 =?us-ascii?Q?RponXgkQrRCypkrHfp4k+fQ2fC4+kYbThSux47iPdAaYMK3V438kBHJ20fkN?=
 =?us-ascii?Q?Six9qaOPDNsFRd8iaUHw1PIRe6UwQB4KFSLHQIRHlrkfRy3tF9S+5HN/IyYY?=
 =?us-ascii?Q?4lzmgGQZlsi4EN4SYU1uDSpvagxu+W6hKcszY7BFDjWzab4s2fFFjTRAzA3M?=
 =?us-ascii?Q?EUXJBxy5IqpmOoPHo+AbQ8XOoxNqIsLilRSAvSWivjDz/W18YRjicyg5RdpA?=
 =?us-ascii?Q?QP0FSrm+Sdr2xsWj/CoP1wQv9uIt75Y6cGnr/UkkYrGCh+fFNbSG1MDj8JSk?=
 =?us-ascii?Q?ZMU50mGMm/8Wf0kgVYec9MJcA+ObmiQuMSNvLw6mpMCNTgos3s87ugwG9Pzc?=
 =?us-ascii?Q?cTST9yLS585Km5jzAboh7FO1gM6rEwudLIGb70nHRF1hvZot4YX55XjsR1xL?=
 =?us-ascii?Q?9tyaHS4vjy0wJ8V4C3/sJh0yxf4CNZAP6Mlec5Fb?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:14:12.3641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 918b6882-a9a7-4ede-4253-08de234d699b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7956

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

For Accurate ECN, the first SYN/ACK sent by the TCP server shall set the
ACE flag (see Table 1 of RFC9768) and the AccECN option to complete the
capability negotiation. However, if the TCP server needs to retransmit such
a SYN/ACK (for example, because it did not receive an ACK acknowledging its
SYN/ACK, or received a second SYN requesting AccECN support), the TCP server
retransmits the SYN/ACK without the AccECN option. This is because the
SYN/ACK may be lost due to congestion, or a middlebox may block the AccECN
option. Furthermore, if this retransmission also times out, to expedite
connection establishment, the TCP server should retransmit the SYN/ACK with
(AE,CWR,ECE) = (0,0,0) and without the AccECN option, while maintaining
AccECN feedback mode.

This complies with Section 3.2.3.2.2 of the AccECN specification (RFC9768).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v6:
- Use new synack_type TCP_SYNACK_RETRANS and num_retrans.
---
 include/net/tcp_ecn.h | 20 ++++++++++++++------
 net/ipv4/tcp_output.c |  4 ++--
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index a709fb1756eb..57841dfa6705 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -649,12 +649,20 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
 }
 
 static inline void
-tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
-{
-	if (tcp_rsk(req)->accecn_ok)
-		tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
-	else if (inet_rsk(req)->ecn_ok)
-		th->ece = 1;
+tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th,
+		    enum tcp_synack_type synack_type)
+{
+	// num_retrans will be incresaed after tcp_ecn_make_synack()
+	if (!req->num_retrans) {
+		if (tcp_rsk(req)->accecn_ok)
+			tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
+		else if (inet_rsk(req)->ecn_ok)
+			th->ece = 1;
+	} else if (tcp_rsk(req)->accecn_ok) {
+		th->ae  = 0;
+		th->cwr = 0;
+		th->ece = 0;
+	}
 }
 
 static inline bool tcp_accecn_option_beacon_check(const struct sock *sk)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 5fa14a73d03f..c6754854ad09 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1106,7 +1106,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	if (treq->accecn_ok &&
 	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
-	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
+	    synack_type != TCP_SYNACK_RETRANS && remaining >= TCPOLEN_ACCECN_BASE) {
 		opts->use_synack_ecn_bytes = 1;
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
 	}
@@ -4004,7 +4004,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	memset(th, 0, sizeof(struct tcphdr));
 	th->syn = 1;
 	th->ack = 1;
-	tcp_ecn_make_synack(req, th);
+	tcp_ecn_make_synack(req, th, synack_type);
 	th->source = htons(ireq->ir_num);
 	th->dest = ireq->ir_rmt_port;
 	skb->mark = ireq->ir_mark;
-- 
2.34.1


