Return-Path: <linux-kselftest+bounces-41873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB2FB85FAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F65E5437F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8F031815D;
	Thu, 18 Sep 2025 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="KNGOom2g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011021.outbound.protection.outlook.com [40.107.130.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0325F30EF86;
	Thu, 18 Sep 2025 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212512; cv=fail; b=f7E5F5kLLGRWmZM1/lbHzEi6r94l772bz2Pon+R44LfGYH9Io+E00ghjWZjQRpwEYqBglgL1k518RPO4/7Qcel58ScUHeY5+sBTZICecNJeP6/X0E6LgSlXCHq6Hr5yINSiwsl+XTBvsEPBWYvjT38m1+5u0zQF4S6t/vUNp/uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212512; c=relaxed/simple;
	bh=AONhHbBbxZOGDIPCFjMuDfuegMrZBvbNXKI2zDCdhy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+Pv/FObyqX26gzKWoEeDhCI6a2p6Jh52Lh4yJZ1Ndt75YsmtEm6NkNlXAPbFUR7kGAlQpap+Y8ZpgkdKCFpVJ/1mBTCNHa77fRPe80oNEVHot44c4HtevNCAgY2fNqfcwTwVHlVWGk6dS8zf/wmKes5fC2At+AvtAOfqcU8nhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=KNGOom2g; arc=fail smtp.client-ip=40.107.130.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGqxolzbiMKTNpOu25flO1R8I26bW1htA7UBCOd4DRIUIddiYT6iu9m/OlWhzDRWnOLQEquuL9Ayh7UCynUyu9WDqRoN6CoZORQunZaMyRfZ7ywTr1amIkHlfDgKJqJ9l9Sm0bEPBwQ5AWLUu5JyseL5MUmAABu3U3VDBACvGMJAdsPRLuJt0cAE9x73oYvH0UIhQqtmgWcDRtVE+nu0niR9jhOeMNxD4FSJQnBTGROnEjO8Bo2lIi3oR/P3uMqgmoy9hayHe669RYoTiTLNXQASbpxMYgjYAg9QFFX3RyBtHL7cODydl/gcWC8NKHRu88OS0pyaGrbLhaMwh0qm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLls09Wg8atFbiv/KCe0EdTumaSaPFW2qkTnqc9kyMs=;
 b=bZeGvykY4oiifQOo/8mJjtH+8cOZFt4qtNHqaoCtReYcjg7qDAyHVDaQ+4VzRgLjVQx1Sgb4LPlp4lq363m2GLuGTV0G0Y3YBVM/osDCd+/JCkv4n4FvKpTkkgOhLyHjtrb78VjZlWsI3xN3HdT+kZjQTdhHLbjzu5SJBurZgMdVEa+VlUVr4mV1/6XdO5cRUeBsQPQgNsNIBzuv+laNzGngtefziJhlCESto1ZBdzl3OkMMvHVlAhoCHzjGR8B8ks6ckq+78Ti6360b+cle1PD3RuXXC4LfC1IFfgjWHH9Gx5JOf5GDYp9aal7781Glji2HMl+8K+kSqhAqkxxP9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLls09Wg8atFbiv/KCe0EdTumaSaPFW2qkTnqc9kyMs=;
 b=KNGOom2gjv/6vrVjCiZHi0r/5Cfh/JpHddMH4m8/5uOWCgByEZPleCC1YkHQEV7y6GFe44Jnop6CfYj16dKMQ+B9Ofk2J3+T1+MRuQpK2iF+n34UVPz0+8RqsJbeQDA0GfDbMJjwn1UtMlcHJwhwnyG1P8DAALE1hUCbyN1v/gM24VbMmdgZbtWKKg3ap1n2WMcU9W/VYQ4IWGIInggsBtVCyxw/LXM4HhVnZPC1ERj1o6AlX8umMug5kfJ9CKxQgEPaixPUqqMXWH8JM9aVB5EkYY6JMlfbRTo66mJjRaMLnS2i9E7mDCZsPTIENNDOn5yIlTSreLYTTaJvhMzelQ==
Received: from DUZP191CA0002.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::12)
 by DB9PR07MB9176.eurprd07.prod.outlook.com (2603:10a6:10:3d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 16:21:42 +0000
Received: from DB3PEPF0000885F.eurprd02.prod.outlook.com
 (2603:10a6:10:4f9:cafe::2a) by DUZP191CA0002.outlook.office365.com
 (2603:10a6:10:4f9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 16:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB3PEPF0000885F.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Thu, 18 Sep 2025 16:21:42 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 3179A200E5;
	Thu, 18 Sep 2025 19:21:41 +0300 (EEST)
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
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v2 net-next 03/14] tcp: accecn: Add ece_delta to rate_sample
Date: Thu, 18 Sep 2025 18:21:22 +0200
Message-Id: <20250918162133.111922-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885F:EE_|DB9PR07MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: 08987857-cd8c-4c38-f6ee-08ddf6cf7464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2pWOVZmQlc0RnRnWmo4cDN2UGVZN0gxZDRXTTYwUzdreFUyVjYrbDJvTVFo?=
 =?utf-8?B?L0dGaGZWcXU1NnZaSXZJR1Exbk1BUFpNTHNUaHhTa0k0N2cxRnR5VUdyWWZa?=
 =?utf-8?B?NnhuOHkzMm5YajZYNjlxelZIWHdYcWpkWlpkcTV2M2NRbkxPQ2lhRDM2YUJk?=
 =?utf-8?B?dXZUdnRDYnBLY3lRVzlUOTlzZnE1NUNLbnIwT0QrdlNNRDV0UEFSaWx6MGNQ?=
 =?utf-8?B?MGhEeHBHd0kvUVdkcVNZeTlLUm1CVGhMWG44NFNHalFwMElZdGg1VW0rRTl2?=
 =?utf-8?B?dzMyQmR1YnlCemdQTUNCV1hkUmF0R2xMVVRNbW1GKzNOSm1velJ5ZU44UGhm?=
 =?utf-8?B?UWs3UGxqNjhva1FCQ3hBcDFwTy9ibTFVWUNkaHl4aUtjQkE5eWpWWjdBYXFx?=
 =?utf-8?B?em1xWVdVQy9RcDJQRk9PTDhqU0phaTdMMUQxVEFQZ1JxZXhJRFZqVFI3WU9i?=
 =?utf-8?B?UUoxbGRvemU4OE1LOVpUVkRra1NCZlZhQzVLcG51LzNXbHlmNS90WGNWQVRM?=
 =?utf-8?B?cS9PanQvV2Z1c2pWQzdwWVFWcVNKbUxTV2FkRlhxWC9EZVBiWnZhVStyOWxI?=
 =?utf-8?B?am9iQkUwWjQ3QnlJcEthU3l3OXFWbkdPdDlaVHAyRDRHUVpoam05UlFyTjZ2?=
 =?utf-8?B?elpBcENoSXRwRWxENVlZbmF2N0V5Z2ZaaFZDZ25ydWlvbzh1c0c3UElhS3V0?=
 =?utf-8?B?cVhSZUVYV2tyc1VWZFlnUjR6UVo1YkxSVVdjenZrbDRYQVhFQlh4STVLN2V1?=
 =?utf-8?B?QzBWNm9GWFkwTU1xZUdrSk1DZjlEWkpTeGtPV0tOMEd2RDhFZXJxV0sxSmUw?=
 =?utf-8?B?VGpuTlJJR3Jja2lZSThRZ295WWZRL3RwUVo2RHJmaElkTld5K1A0SjdhTXY0?=
 =?utf-8?B?QzJ0U3BsbWdNRlk3SjQvSk5odE1sd0dWK1NnV0szcGJaY29mem1yaXJZVmpB?=
 =?utf-8?B?UWhhVFgvRldFd2hCKzk0VEtjZy9hMWV4UW9UR2dBc21NSzRTbFBUZm1TSGZa?=
 =?utf-8?B?Q2h5UVJXTnp3dk92eDRaVWVBcytwNkthWUpUeTJQVHpBWFF0cFlZZTRrNStr?=
 =?utf-8?B?QmFOdU5hUUNHemJEMU1DMlVqM3RYVG1Ea1pXWlFjT3BhZmJTcXRhQVZ3bXlw?=
 =?utf-8?B?QWhKaC80TGJZWGNjR3ZHWTMrSWRGbm01ZkwrWWwzU0VteG54bmZMT3NCTVNO?=
 =?utf-8?B?S095T3p1dFRIYU94aGNXOTQyVFlhQXV0MjZCQjUxQ2VNaWFuZkpRWW9ZeUNn?=
 =?utf-8?B?TjFZKzNGMDRqMUpLOXp2S1pIbzlQVVBKUnhIZi9HaXlScU9IenVhMWo0Y0xP?=
 =?utf-8?B?aEFPYUdzRnMwRXZ1Y0ZOMEsvcHJlUEhrV0NYVGhoNlhQVWdvNkZCZnNKV3Bj?=
 =?utf-8?B?eHhqajNvNmlmMkM5L3RYSFlXMVl2M1hwdGtNZEV1ZEJTMTdaMm4xaFg0SXVN?=
 =?utf-8?B?bDJlcDVOOWpCdTdRRzlOUTByclo1NEFmSGZWWkFkVFJNYlNxQnh2Q3ZwUmlr?=
 =?utf-8?B?TGtBYjRXQmh3WFhOajZVK3puOFZYNXZ3SmorK1Vlc2tUQmdDQk5KTlZ2UVdO?=
 =?utf-8?B?L3E5NUpaOEVtZVpYL1ROVjQ0aUlvdVZvejB4Qm1hcld4V0hrMW0yTFNCR0pa?=
 =?utf-8?B?OVd3YXhDUk9jWUh5ck9PVm5TSmRoTWVaN3hYM2s2RzhkUVpiaTFPZXhJaDB2?=
 =?utf-8?B?L1lSelRZd0xmSStDTVE0TzRWdkRPME90azB0VkxZd0ZyYXV2cENqdHZIenRS?=
 =?utf-8?B?cnJ6bHVJKytxMWpxeTFUQlRWZkhIbTB6WlA2UThLNG9ZVSthZUVtUTN1SjU1?=
 =?utf-8?B?dEhlMWxVdXFQSnlWUFFBQytxV3FiampUcThGdFZ2N0xnbS9VVzJ6RjNxbjBs?=
 =?utf-8?B?SXg2QkozSko5L2I0ZGtqS3BUZS9ERUdHWllmcGZCTGFGTk54UFBrb0pIbVNy?=
 =?utf-8?B?cmkrcWlqUUhmQ2tzT1hFZjRBSlB5a1ZzaGVqdlh6aHBlM05RalNhWWFjYlp5?=
 =?utf-8?B?dXZqOWZ3QjFtUEtQa01GNVFSREFBcEFqY2V3NFprVmlEeTBkUERlbExTWnQ1?=
 =?utf-8?B?aUpGRE1Hekg3UzA2QVd4emZrSy84c1pqUEp5Zz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:21:42.7094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08987857-cd8c-4c38-f6ee-08ddf6cf7464
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9176

From: Ilpo Järvinen <ij@kernel.org>

Include echoed CE count into rate_sample. Replace local ecn_count
variable with it.

Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp_input.c | 37 ++++++++++++++++---------------------
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7c51a0a5ace8..23f0355d1991 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1220,6 +1220,7 @@ struct rate_sample {
 	int  losses;		/* number of packets marked lost upon ACK */
 	u32  acked_sacked;	/* number of packets newly (S)ACKed upon ACK */
 	u32  prior_in_flight;	/* in flight before this ACK */
+	u32  ece_delta;		/* is this ACK echoing some received CE? */
 	u32  last_end_seq;	/* end_seq of most recently ACKed packet */
 	bool is_app_limited;	/* is sample from packet with bubble in pipe? */
 	bool is_retrans;	/* is sample from retransmission? */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 0b25bf03ae6a..6f7c2f0fc0f6 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -578,9 +578,9 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	return safe_delta;
 }
 
-static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
-			      u32 delivered_pkts, u32 delivered_bytes,
-			      int *flag)
+static void tcp_accecn_process(struct sock *sk, struct rate_sample *rs,
+			       const struct sk_buff *skb, u32 delivered_pkts,
+			       u32 delivered_bytes, int *flag)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 delta;
@@ -590,11 +590,11 @@ static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	if (delta > 0) {
 		tcp_count_delivered_ce(tp, delta);
 		*flag |= FLAG_ECE;
+		rs->ece_delta = delta;
 		/* Recalculate header predictor */
 		if (tp->pred_flags)
 			tcp_fast_path_on(tp);
 	}
-	return delta;
 }
 
 /* Buffer size and advertised window tuning.
@@ -3971,8 +3971,8 @@ static void tcp_xmit_recovery(struct sock *sk, int rexmit)
 }
 
 /* Returns the number of packets newly acked or sacked by the current ACK */
-static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered,
-			       u32 ecn_count, int flag)
+static u32 tcp_newly_delivered(struct sock *sk, struct rate_sample *rs,
+			       u32 prior_delivered, int flag)
 {
 	const struct net *net = sock_net(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -3983,8 +3983,8 @@ static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered,
 
 	if (flag & FLAG_ECE) {
 		if (tcp_ecn_mode_rfc3168(tp))
-			ecn_count = delivered;
-		NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, ecn_count);
+			rs->ece_delta = delivered;
+		NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, rs->ece_delta);
 	}
 
 	return delivered;
@@ -3996,7 +3996,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_sacktag_state sack_state;
-	struct rate_sample rs = { .prior_delivered = 0 };
+	struct rate_sample rs = { .prior_delivered = 0, .ece_delta = 0 };
 	u32 prior_snd_una = tp->snd_una;
 	bool is_sack_reneg = tp->is_sack_reneg;
 	u32 ack_seq = TCP_SKB_CB(skb)->seq;
@@ -4006,7 +4006,6 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	u32 delivered = tp->delivered;
 	u32 lost = tp->lost;
 	int rexmit = REXMIT_NONE; /* Flag to (re)transmit to recover losses */
-	u32 ecn_count = 0;	  /* Did we receive ECE/an AccECN ACE update? */
 	u32 prior_fack;
 
 	sack_state.first_sackt = 0;
@@ -4116,10 +4115,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	tcp_rack_update_reo_wnd(sk, &rs);
 
 	if (tcp_ecn_mode_accecn(tp))
-		ecn_count = tcp_accecn_process(sk, skb,
-					       tp->delivered - delivered,
-					       sack_state.delivered_bytes,
-					       &flag);
+		tcp_accecn_process(sk, &rs, skb, tp->delivered - delivered,
+				   sack_state.delivered_bytes, &flag);
 
 	tcp_in_ack_event(sk, flag);
 
@@ -4145,7 +4142,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	if ((flag & FLAG_FORWARD_PROGRESS) || !(flag & FLAG_NOT_DUP))
 		sk_dst_confirm(sk);
 
-	delivered = tcp_newly_delivered(sk, delivered, ecn_count, flag);
+	delivered = tcp_newly_delivered(sk, &rs, delivered, flag);
 
 	lost = tp->lost - lost;			/* freshly marked lost */
 	rs.is_ack_delayed = !!(flag & FLAG_ACK_MAYBE_DELAYED);
@@ -4156,16 +4153,14 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 no_queue:
 	if (tcp_ecn_mode_accecn(tp))
-		ecn_count = tcp_accecn_process(sk, skb,
-					       tp->delivered - delivered,
-					       sack_state.delivered_bytes,
-					       &flag);
+		tcp_accecn_process(sk, &rs, skb, tp->delivered - delivered,
+				   sack_state.delivered_bytes, &flag);
 	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, ecn_count, flag);
+		tcp_newly_delivered(sk, &rs, delivered, flag);
 	}
 	/* If this ack opens up a zero window, clear backoff.  It was
 	 * being used to time the probes, and is probably far higher than
@@ -4186,7 +4181,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 						&sack_state);
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, ecn_count, flag);
+		tcp_newly_delivered(sk, &rs, delivered, flag);
 		tcp_xmit_recovery(sk, rexmit);
 	}
 
-- 
2.34.1


