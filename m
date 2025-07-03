Return-Path: <linux-kselftest+bounces-36387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF29AF69A4
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 07:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B91523BAB
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 05:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985AC29B781;
	Thu,  3 Jul 2025 05:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="CToJ2oH6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011069.outbound.protection.outlook.com [52.101.70.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F6D29AB1A;
	Thu,  3 Jul 2025 05:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519949; cv=fail; b=iAtpmWpwZdXEXU/jX25cc3viShXx6XsYabO8F2yGcKdpXoF+VzexPSUlJaOgWLwdVk+pCiIhTtMMbK6Q04PR/w9YPF3uU+lW1PHdQFGEtPtUXNFO2a6Z+MJxMjQcT4mNd3C3hm2xZ0DWFrTUJ8r357cpTPEVoud2CJ2k5xS0k8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519949; c=relaxed/simple;
	bh=Y1Y8LC2q/64gptO4R/EZA7+n5Ufuomk0GkPTvoKUo8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lff778cnxIO+1VoG/URqI/70YDt35A7MnQGtitIVVodfHa/g76RfoFx2uB5aWgN3puDLIamyYcFDYdwoGif0HQNIMI1rQnTRmD3gb1Vp7bVZrIqtIRCKg8QEpealoZBOAPF3IG//J13htRnqae4wksXelEiy6qU2x2d0vLqzsLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=CToJ2oH6; arc=fail smtp.client-ip=52.101.70.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyMarDh2khmRNxB4y7F5VvVHBJjFnISO8z+H89ItmKcY5sa2y0DoiJbMbLU6fbwZa+ag6ROpgMu446d9oXEk4ypMi8XW289xBF3PHNORHSe5rNbBGzOT/BibZWmpINwREpWffS0ctpHSpu/8h5qCPN7uMBvuNR7VKg786pA6cyexhs5kjaWePUWyt0VjPrBzdMV6Y4FqUQiyHLk/EGO34Hk/FbDQ7stoGtoLbl8R6icir7EiOMTZmZ6mcgqvIvgqmlFzI296quWgpGyFay5vFjV3eAejeRQbqLKmpnXAXLXb9xVHCM9KJNrjLHfNer6Hj0LfZgOyxkWl7Nhsja+mQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkoqkf/eJjEGac82okIjQPc/rUHUMsRrJ6naZ6jx+Pw=;
 b=n90jUAasYzJ9YUHPv8LVJSvRKDudx+lvpyqhofq9pnmvWDfLQgvEdI05K1h4ovMTAVALeDL/Uh3YM/MjgCQfZd4ggBAxJp5CG24hcyIF6Uw/5Dbx3XU47HI1CEXGw0I7YqyVBBjEvSVsGluWhp4A3Fp/+rcYbhCRepnYZ2xT1nTz2ZGJcdAO+JVo8pslUfz6IU0BPkIOJuQRVJKwX/5Jlp26FbHUcF+kMKv2P/yNjeVHxic5vO3CJsz0cIDkTw4mLQJWqW3iWklmxktGLJ3Qv1IOmzR6vVFGg7VRU1Kydt9IfCu2XH13U4xo8j41kIUjadU9q6pLi2xiS2sHCC0Tfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkoqkf/eJjEGac82okIjQPc/rUHUMsRrJ6naZ6jx+Pw=;
 b=CToJ2oH6Lzyyk7NIt79alcaWbRnBr3a1T10eHrA1PsKQpt1JOb31Z2RZqQAYDeglZjEZL3kTHVz6M3XxahDxPOSWIK5AkwlpT+GNy9U40ZYKZmqbu0SNQNC6iU71EJvQ6eAce2v46ReY4KK5qVXf39z3ZJH19KdCy7cGjR9kFcyjwWP0Js+lrJOSSA17Q7CSEn2JPpmHeJozIihNl+WHT+wQaT/0QZPhGqTiE9kwnlewE9NNrlIy8VnlyY76988qBs7aHaJQm4+VonQU+c1qMjYTvr7kEL2d5eDhg3nlW0rjfnuoK8+iF5sHl0jzdpFeA2b59DAU0dolkT0vuq39kw==
Received: from AM0PR03CA0069.eurprd03.prod.outlook.com (2603:10a6:208::46) by
 DU0PR07MB9314.eurprd07.prod.outlook.com (2603:10a6:10:44d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20; Thu, 3 Jul 2025 05:19:04 +0000
Received: from AM2PEPF0001C710.eurprd05.prod.outlook.com
 (2603:10a6:208:0:cafe::3f) by AM0PR03CA0069.outlook.office365.com
 (2603:10a6:208::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Thu,
 3 Jul 2025 05:19:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM2PEPF0001C710.mail.protection.outlook.com (10.167.16.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20
 via Frontend Transport; Thu, 3 Jul 2025 05:19:03 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 4FDDE200B2;
	Thu,  3 Jul 2025 08:19:02 +0300 (EEST)
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
Subject: [PATCH v11 net-next 14/15] tcp: accecn: AccECN option ceb/cep and ACE field multi-wrap heuristics
Date: Thu,  3 Jul 2025 07:17:27 +0200
Message-Id: <20250703051728.37431-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C710:EE_|DU0PR07MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: ba78891a-b37c-4088-d742-08ddb9f1206d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmdsQ1c2V0JhZ3QyMEhBTmErbks3T1Q1djFBVjZUOHBlUmNsUFVjV08xRWlI?=
 =?utf-8?B?NDJsMFJYdWhJL01tbXZSUkdYU3Z2YUhSRGo2WSt3OUo4c2tqZlJqYThTWE54?=
 =?utf-8?B?K093bDV3QmozTlgrejh2R091SkpTQXpZeGZ4cVRxdHlndTNPdWhORnJxcFlH?=
 =?utf-8?B?SGcrSFBBYzJnNEtJQ3VXK0NDeUVZMEt3c01PZEFnUC9CWGdlNk1aU0hkazBN?=
 =?utf-8?B?ZFltekx5dzcweFNEZmsxMEZNcHhMSThKbFdVWVEwdytFWWtvMS9NU0tJYmR1?=
 =?utf-8?B?RjhzQUdyajBIYVVHbks1L0R0aU55dDFxRjVtbmZkd09LM213S2Y3L3cwbFUv?=
 =?utf-8?B?Wkt4RlJ0NHJkWGJqdlZyU1Q0SXJCRzYyOE55U2JEVC9tSGJoejlxWEJhS0do?=
 =?utf-8?B?dnNKaHNXcVVNYklTbXVna1pjcXU1SlhaSFpDeHNaTEVKbTZRVXV0cU5WVG5z?=
 =?utf-8?B?WThZcWF3N0J0c3oyeXR0SkozY25Id1RaSTZVQzV2OEZXejllYWpQRi9IQ0Ri?=
 =?utf-8?B?dzRKZnEzZVplOTJTUVlRSk0yQVcremZmRTFiM05LbVUraExXd3p0SXBxQng4?=
 =?utf-8?B?ZUVNQlovaVJkWTFSUEg3SFE2RlJuQ0w0d2hUZng2Y2p0M2ZEUUJndTdHT3FJ?=
 =?utf-8?B?M2c5N2kwK21KOWJBODk0N0JFZ0pxTnBJZFEydiszYWIzTS9jdFVoZ0Zxbi84?=
 =?utf-8?B?Mnhzb2VhZGRnWk5IVm9JaHRLd0YyQjNWVGdOdC9mdUZ0aHJqUzUxNnZCbVNp?=
 =?utf-8?B?TEwrNjVBME9CaXFSdE9aMS9CWlV6UzRRN1FOaHVmb0psbElKWU4rcVl4WWtI?=
 =?utf-8?B?cGMvdDRERXAyV3hjYmRPaXkzK2dIZm9wamFhdS9JdWIwT21JbWcxeVFLd1dz?=
 =?utf-8?B?YmF4TlJ1TEZ1R2VpQk9wOUZGVFJWd3labXVTOVFRdndRSHdobWdpaDQ4Y2hV?=
 =?utf-8?B?YkZKWHZiVS9QZTV6OW5namozWldWSElpTmtuNHpIY1VTR292UEwvejJpd01M?=
 =?utf-8?B?bzNRNTlMUDV2TmpNcmlMVUQyeUJiQXBrNE9KMGxGL1lnUWlEQ0ZUaytKckxH?=
 =?utf-8?B?WTFRRTh2Z2NTNHNEMm9PUnBRMVozK0x6SFdRdDhxRHlndVRwNzFMajlnSmw4?=
 =?utf-8?B?RExjYTBoRjR3Y0xuZGw2UmdGZmN1b0RVakhVZC9kRm1LQlpQS2NxNmJXL0tk?=
 =?utf-8?B?dHhOSWMzWGtsSVpkZlkwN1hkbUlNU29QSjUrb1hiOVdYRENkN3krdTBzUEpQ?=
 =?utf-8?B?aVB3M0Nia3FHL1U1UVBlVW9HSDhiSWU5SmZibHoxbEVzUmJZQUIxYmFyNEJQ?=
 =?utf-8?B?MFU1L2daRDdadmhTVnc4Z3E1MEJrTlcwUUpxSHk0MWM4ZU0xT25RUVZlZExM?=
 =?utf-8?B?aUduYUMvWUx1ZS91RWppemhsNXpMTnU1RkJlTlIvaWtmWjgyMURCRGVaWitM?=
 =?utf-8?B?Z1lLWkdYRGFTbTlOSGFCR2F0ZXRMUEwybUhBWDRML0JlOElJYmdkdmRFMlZz?=
 =?utf-8?B?a0Q0ekRiTXlJbVh5Q3ZmWmh2SUlGTURqbnBmZmtQQXNuL01tQmtuOGZBZE96?=
 =?utf-8?B?OVdHd0tJMGtFL2ZCalBKNzhwZ2RjOTR3QnZwL0JCN0ZuREhWalpWK28yVjJq?=
 =?utf-8?B?NWp0eENld0tSWllLN2J1VnlOazhLd2dLb2gwVlhFYzhjV2EzdmxWemFRcnZo?=
 =?utf-8?B?aU1VRXk4Q2NSUEkxWXU4cm5qYzhvc3F2YVlldTg1em1YVWVId3c3WUd2cTZU?=
 =?utf-8?B?VTUxNkVTemZHOGQ1TzRoM3ZwRmNETjFXS1EzdlN2Z1pZWUJFakk0Y0xlZHRP?=
 =?utf-8?B?eTYvcE1JalVhWXpHM3RYUHdESGsycUExZjJud2JXdk1PYzBZNkd5WThvODVn?=
 =?utf-8?B?MUJjM2Zic2FGN240QlRtSnhCbGROSTFrYjJEUGorekpxcEpDSXZpZUkvNExD?=
 =?utf-8?B?UGFRQ015SVNKelVzdXc1a0NKdnFHM2ZuZkxncGsrT2dCSE56WE0zUTA3b1VL?=
 =?utf-8?B?MUFWL1Z2cmk2UEtMbjZENmxXV0ZkeGV2K0h1Mzd2ZWdVWFhYOGRFN09BTGto?=
 =?utf-8?B?ajNZUUkyTHI1cWdxeUNvV2dYei9wZjRmOFE0QT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 05:19:03.7595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba78891a-b37c-4088-d742-08ddb9f1206d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9314

From: Ilpo Järvinen <ij@kernel.org>

The AccECN option ceb/cep heuristic algorithm is from AccECN spec
Appendix A.2.2 to mitigate against false ACE field overflows. Armed
with ceb delta from option, delivered bytes, and delivered packets it
is possible to estimate how many times ACE field wrapped.

This calculation is necessary only if more than one wrap is possible.
Without SACK, delivered bytes and packets are not always trustworthy in
which case TCP falls back to the simpler no-or-all wraps ceb algorithm.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp_input.c | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4516b4910fae..ad96bd2040dd 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -246,6 +246,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCP_ACCECN_MAXSIZE		(TCPOLEN_ACCECN_BASE + \
 					 TCPOLEN_ACCECN_PERFIELD * \
 					 TCP_ACCECN_NUMFIELDS)
+#define TCP_ACCECN_SAFETY_SHIFT		1 /* SAFETY_FACTOR in accecn draft */
 
 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5a8f5ca9efde..094645e0d9fc 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -492,16 +492,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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
@@ -524,6 +527,35 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	safe_delta = delivered_pkts -
 		     ((delivered_pkts - delta) & TCP_ACCECN_CEP_ACE_MASK);
 
+	if (opt_deltas_valid) {
+		d_ceb = tp->delivered_ecn_bytes[INET_ECN_CE - 1] - old_ceb;
+		if (!d_ceb)
+			return delta;
+
+		if ((delivered_pkts >= (TCP_ACCECN_CEP_ACE_MASK + 1) * 2) &&
+		    (tcp_is_sack(tp) ||
+		     ((1 << inet_csk(sk)->icsk_ca_state) &
+		      (TCPF_CA_Open | TCPF_CA_CWR)))) {
+			u32 est_d_cep;
+
+			if (delivered_bytes <= d_ceb)
+				return safe_delta;
+
+			est_d_cep = DIV_ROUND_UP_ULL((u64)d_ceb *
+						     delivered_pkts,
+						     delivered_bytes);
+			return min(safe_delta,
+				   delta +
+				   (est_d_cep & ~TCP_ACCECN_CEP_ACE_MASK));
+		}
+
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


