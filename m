Return-Path: <linux-kselftest+bounces-44263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C32DC18EF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86419507CAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCD932C31E;
	Wed, 29 Oct 2025 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="byq48XGh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FB5313549;
	Wed, 29 Oct 2025 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725201; cv=fail; b=bv4mxJKCuwRg3vlua3O0vEi9V58t4zVFR2mwQlY/NPhK9PuGM+S8lTUAHruC60b0ueh+5Hu+DrqomVOSW3XCNAe28LIzSOhNWf96+4Ve/Nntpx+C/gS7HQBX/un7GIQ3DE5/I5HT5yUUFCoOn5NiymsJkvz7Kxll8+UGtWdG8A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725201; c=relaxed/simple;
	bh=JpETmcnzkD566/jvHubSYt6pOop+nEoP6itC8bWgwVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CXep1PqqOAMJnwhshIeA4s62xiFdpNh64VUyanTyrazlaYQYtnW9GwnCVpAc15PBGyO67mFy12r51PUGGVMDY0+hC82c63y+85F4cDBEEEmNDhngjHDwS9tSeX+8/+8IHvgswcvUFdbmGwE0JNS5yN7Iie5MQB64tWt7yp2Fg8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=byq48XGh; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/rHFKOGuhwesR/LYVxliS3nEO3GzRtUoGT0R7XFo4Ka1I1WpsM33FAxKOllNTiV4b2pOz7omhasKE/vFupK6jKDLqBbVPvZWrSF5K3Xs4UYzDufKs/OEkZ7P20eUic0iNbysBvmVmdGSrDV7wthV/OEDXf1DYrExLy2i4DY0MgoUX88if6luzoZYdUkzHOHklg4g70VjgyRT9mzi4dQPV+JSo0dDUDvcH2+7/1NeAmB4uYuehUk4mUZbFTWIl01gNz+jxTBPBZcL/B0yfvn4ZqkIKG1L+MQ0wyaInqaNdDnmliJwCMsEp83xOPCyTOgBkcLTzSmPgGjsv8YbQxpCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xYBR9VPiwUQOKW955teSRW41ypAoDmV4gCO8opeT4s=;
 b=oi/ieJ2BYNhDk/C75xk5pwpAdlsgNkDBiyljRNPabHSweAceNEuyKXXFBZd+gxR5TvGpZ6Nccx2qW86myeouPFG25gD83kQdAjFpip16uT502zJl4wWE+aqSm3rrWO7hcYFta9kupYBfo54AdVjam7/V7Wr4RajuJqSg6qbrnAxpR1MF/c3Fg5oeo/OcLcoaOiHpIOP4gfhZDzOThGhZebbQkHeLYOg84tTFb7zGgLY/DQL4cr3NNXfjYecasLu6TYiPf1gzPqgivF5uq1orv5EBkF1tEQCpFed4jvUZRMxHXmKb05LV/eBUx3jFtjXTsqLheDbVE82BokXttkUdWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xYBR9VPiwUQOKW955teSRW41ypAoDmV4gCO8opeT4s=;
 b=byq48XGhjTHie9Tny2TtBXHQdHKAA2+7wv3VxDf5nocWGjMczZE2ExahxxCgGLtmbNS3aVUGqMY+Nbk80vmcoMpTwzTMcq526dShZGlH9dUNkhgiETq9BCyuu1run6K+7XR2WJdQz156d/GymqjET5poE9Kv9r7jym/XesTWAywHSlKf7fFQJDX4FtwEhTo/1Vw0fyk1SnFeuOwIq/T2HG9kd2GcZGgdaXXKOVfZDwPOs5Z8BbYPLL91NiZGLo9ngbxKjTm+Myu9vR70Sj6SJbH9Xi+oyjrdi3YnRyXi0jmlG3NCJWMJ+YJnhxlz6k9C4wN9tVn/mQVSbu+pRIhfYg==
Received: from AS4P250CA0017.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::6)
 by PAWPR07MB11238.eurprd07.prod.outlook.com (2603:10a6:102:509::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 08:06:33 +0000
Received: from AM3PEPF00009B9B.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::a3) by AS4P250CA0017.outlook.office365.com
 (2603:10a6:20b:5e3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 08:06:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM3PEPF00009B9B.mail.protection.outlook.com (10.167.16.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Wed, 29 Oct 2025 08:06:31 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 6D0D620186;
	Wed, 29 Oct 2025 10:06:30 +0200 (EET)
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
Subject: [PATCH v5 net-next 07/14] tcp: accecn: handle unexpected AccECN negotiation feedback
Date: Wed, 29 Oct 2025 09:06:01 +0100
Message-Id: <20251029080608.92428-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9B:EE_|PAWPR07MB11238:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 742d855c-c1e1-4083-ae5f-08de16c2124f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?PguWS8EBfrltjx1qmGLbThzKdiRFyaO0UvMHPV/s6yViS9lYP3qtYl/0Ct8U?=
 =?us-ascii?Q?Ho4gJp+6wQo7g4SyjxXV5xivrP1DaDPobwZV0zZrP/wXs8DuCKhJC9Q5a1oh?=
 =?us-ascii?Q?4lX11mPy9VgQCDuZVj2tYFkSj+zDP3rBPEaR5zYYat3uDjIiPUMU6ZYfyB6K?=
 =?us-ascii?Q?GOqqASjD2buVYNV101LSKuqpB+XysIy2Ywrk3terMh57O/Z6SB0/dB1EbucB?=
 =?us-ascii?Q?AVHBKNeXF4B4XrI1K5Hus6cDqwadw6Xt8pQZHD7xB4GEaPoYbqQNFrskatLv?=
 =?us-ascii?Q?S/fbPBbrL5p3CTWougAbBeZg7hRhAk/mCa/CCcea3YDjGqZRDuCg4Sw5jAbI?=
 =?us-ascii?Q?HFggHPxcb2yeXXeUftbF1NXpOnOou932oSCxd+yjxCmmGWwYkwXv09Daw7Ow?=
 =?us-ascii?Q?1q3PTQ7S0xJWbJvm1mJsRj9qmFX9bghgAONfIVXZYnq15DZU+Y7/FpzKD2mG?=
 =?us-ascii?Q?iTj6oXG1bCT1RsQwCJpCYXDRJjvmF9QZBJtLYD/7JLFjJhkvgv9BhkudTiZq?=
 =?us-ascii?Q?dhDEtdVlSAvO1drwO0JlCreVzkt3qxY16OsYvghTvKorRudEqcZv2j6MDgYr?=
 =?us-ascii?Q?JAWk5UNRIGwzUgK5VC7E05UwFpyOWYCTf5QPJ1dyUYd3zEcIgjy1eKggBsLB?=
 =?us-ascii?Q?OnVuiQPaeUHHctrk4BGXR3HikCDuUKvDJPJaZ/Dhyptq0V2YLPQKGRZYZL2g?=
 =?us-ascii?Q?7UCmQOsKXU4RFxqSSZVpXJ4osUJ44pAMnt52DD19MHVlXuoQPo+OxJYx3b9H?=
 =?us-ascii?Q?3idD0g9rVrc6n9ant6XaNmxLYuVlgW7i/3J7zHsIABEZppv+uVuF7pWjQirA?=
 =?us-ascii?Q?mL6COaMiEe1y6n5u0jH96LEB/ym9ng1mA1p3MMRV/u/GoNvwsZb8bPRsbLf5?=
 =?us-ascii?Q?vBXUafM9+T6uwWl/MLf0knZLipWw8Yg/ua5PwxBv/l3w0Xsjm8Y7+L49ha4e?=
 =?us-ascii?Q?f0RqP/wQIfLpUPT90s738ISIoK3DLkFu341d8jgtEQdfKiGKFw2COOjiEfKV?=
 =?us-ascii?Q?UStjQKAktWE3Uh9+V7H7M1mc2yYQW2bctWto3FzL7tiFMHuYrz0DiE0dS5xS?=
 =?us-ascii?Q?YPtynWrUsHehA4g3TEdJy00qTGC+ItS3VhNgxSaU2BRic5kFLT32O6W5/0IC?=
 =?us-ascii?Q?vWMrfMhzWaO+NWi86Nk8rPwFlA/hyN3iXqrxCWePvQJVq/0S2iKVl+u5Jwkn?=
 =?us-ascii?Q?QR4KBqVOgnQuqtXk1MyOh0K/Ah1dXLE4PyVW4ZzPN7vrk26QSYMJ3m/flsml?=
 =?us-ascii?Q?mh0MSGSV39LubB5iYEtK2WfjY6RRcBU4myxxkZEbrQ/U903Hnth8I7vRN0e1?=
 =?us-ascii?Q?0Olt/XZot+u9WQWhUmm/Pm28ABJBGbETmuc48xstI6YnxeudrUgibiQSErWe?=
 =?us-ascii?Q?M9QdSJ+wpChOcxx1s4k21utMDvo6+UCwqPHp85dHCP8nNJraH5tbCa3KRtwi?=
 =?us-ascii?Q?BQT9j8FL+qSPn6Z9h0gwGxZsaHiuDx0+lWgW/3p5HwXkFgNl94InyqnUcLDf?=
 =?us-ascii?Q?RoQosPIvieAmd5nqgEJ/VIBHMx/Dg18KCAoTsLeVmvTcQ5LorhoM4iYlq8z3?=
 =?us-ascii?Q?ly3i5Kq8Acrz+pOWCxcrj25KHjZfND50fiiKp2rW?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:06:31.9164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 742d855c-c1e1-4083-ae5f-08de16c2124f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF00009B9B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB11238

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.1.2 of AccECN spec (RFC9768), if a TCP Client
has sent a SYN requesting AccECN feedback with (AE,CWR,ECE) = (1,1,1)
then receives a SYN/ACK with the currently reserved combination
(AE,CWR,ECE) = (1,0,1) but it does not have logic specific to such a
combination, the Client MUST enable AccECN mode as if the SYN/ACK
confirmed that the Server supported AccECN and as if it fed back that
the IP-ECN field on the SYN had arrived unchanged.

Fixes: 3cae34274c79 ("tcp: accecn: AccECN negotiation").

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v5:
- Add "fixes" tag.

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


