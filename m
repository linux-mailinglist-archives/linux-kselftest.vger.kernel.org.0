Return-Path: <linux-kselftest+bounces-37579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D319B0A650
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 16:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629623A1C68
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 14:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6A92E03FC;
	Fri, 18 Jul 2025 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="GIOb99eh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011040.outbound.protection.outlook.com [52.101.65.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36332DFF2E;
	Fri, 18 Jul 2025 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848482; cv=fail; b=B2gzIyleFhgaZk3ihM+16YxDcx+uw9Vv7E696ANpCpKqW/xVmU4eRrUjSmIOB1z2oFPvzFtBTS1GvBMzxhCRDux3wwPtPX2H7PUluaKHxroi7F4fYUWDwAKIkYXVZ9xqmmmW8EWESNC+k3/9leZvCP3thPCb6jUuFjNDPfrUzy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848482; c=relaxed/simple;
	bh=aizSszXthie2zj/4+hQ58MVQOaqs8H2FL+c2ygOdigI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adcaQ9/40dOoDwc1bZX4rI6tJMfqJJhUnLsQhJ3pQmOwTvTmcwe6yRrSXQaKG95pb3eSltQJTS1cogutP1PpXF2dUebBdehr3Rp1w047/p7Egh0JDE4n0F119/XtBHYPB0ecfJAWz/kUhnOBbi4r3Crj3Zs7PX0+kuhCSsGabRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=GIOb99eh; arc=fail smtp.client-ip=52.101.65.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asiBO34FidMFzaHV8cIa0fpKkpP71Uf6GMXRmgopKLS2NPJX937oI3D6OpyoPDFUdBPJ6upbDRwjoN6/4nWE9SKG93mWSrRuGmYPwFgBbBHPO7/SYt82JhSunqeDj3vUSOjn+ET1iyu/jRe3I4SnJF/kRbkOPllAXUwN+IzcO2dw1SRGkmWD7/MNnAZpYeNGCq3P4O30Ms9E+N6m3qyFBLWpcanLeuQpWLpAvn+vLaauw8o2l9+rQHLdhqKB2ceODvS9Bc6osLbZjfkcjU6onekz9aRy7iY6TsPw3GltiIxokcL7s+PjZwPGv+9j5+pHXdP4Q8Rww0XkzM6oA0r7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJ1dfn8KVImhDwOpH1wNkS5flZ2b+dg2K+yh4JaxCn0=;
 b=vL8A1uOZqjZqwgrsdXml+YTtD8EZizsOvzcYo/WdXLejItBUrRiya4mz8ttEdpCfs9euIxLLmvD/e5VmukCiYlqGHH2jagrT60Oz2M5HuxmOlcWknaH47jnE6knx1gxZ5EinScXPH7q1VZItKcuNwuOmfrQjhyM2iGCINIat8CyqHVxezA/DqeLiast2U8tk8dfX9ndWMt2EH4HgCACy+AbVrg0cnDq6i0P6xY+C2G/bKdqh2z3qGzaG+cruRUwZqpVWiOoSaNBdfAwQIIfm7AUV4Vs6cikIMMj31unYyesaIu2or3cZCARzyOY3otVMRcvYLK/LbgshCgQkEJMcKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJ1dfn8KVImhDwOpH1wNkS5flZ2b+dg2K+yh4JaxCn0=;
 b=GIOb99ehiq4c/k8qmbV/NOsRKBIivYUUbFU6tHEyvG4d1coWApONW2MftUKtfPFqCX1zbYHvRjAge5jIbDg5GElJA4jro57u+15EF4rYDvf/1kqalzIyak05LpaXaVtqRAXyw4m4Y1Wg382pjCLtcRQbJfTtXdvqOzlXM1APBFgj/Z6R7ZmVp0LE+azhgGNuvFG2tI3SMEZsBBYJjYTXLPiofioJdDRLEOEagP42QibK9iCKYxE1nO3UNTHts3WrZVkuxYJT5MgsqhEqG8rZBqFfeCA5mOADzEfKN43ejR22CQDSub8TX3GXGm04YZBFmqDLVzDyJ9ZCAwC24Qidvg==
Received: from DU7P194CA0011.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::17)
 by GV2PR07MB9057.eurprd07.prod.outlook.com (2603:10a6:150:c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 14:21:15 +0000
Received: from DB1PEPF000509EF.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::3c) by DU7P194CA0011.outlook.office365.com
 (2603:10a6:10:553::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 14:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.241) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509EF.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21
 via Frontend Transport; Fri, 18 Jul 2025 14:21:12 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 19F6120098;
	Fri, 18 Jul 2025 17:21:11 +0300 (EEST)
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
Subject: [PATCH v13 net-next 13/14] tcp: accecn: AccECN option ceb/cep and ACE field multi-wrap heuristics
Date: Fri, 18 Jul 2025 16:20:31 +0200
Message-Id: <20250718142032.10725-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EF:EE_|GV2PR07MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: f0787ad8-85f1-4a52-4568-08ddc606594b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEpmbk85TXhwZjdvVm5WUzhEdGZKaVlVR1BhelVFOXcrUWVsY0pocWZ4SE9T?=
 =?utf-8?B?eWxwUDZTd2RuNytyYzU0Rm5mVVFJUVV1Q0ZIOEx6cTM2VUFDWkxpWUJySmZ5?=
 =?utf-8?B?QSthNEx3d1ppbkZVaTAydUJ2UjIyM2JtSmVoNDl0QmN6OGFla0JpeXA3cHRG?=
 =?utf-8?B?b0F3T051T1MxS3cyMkwxd3A5K2hxYXNDc2lXNGZIUElRK0xBQU04R1NOM2hw?=
 =?utf-8?B?bUhyOEVtczlyY05LaXk3L0RCaFRuMDZ3MnhGcE5wWUVlSXB3RkZhZXliRGt0?=
 =?utf-8?B?YkJ6QzdSbm9saWgvYmdxVkhxdDJVd0hIR0svVkRUMlU5RnhERWdNcmhZL3Jq?=
 =?utf-8?B?WjNGdFVTT1FPYkZncEV2ZHROcU5TUVJMYkJOT3dtU3JoTjI4YzFTa2F6UzV5?=
 =?utf-8?B?cUkzL0hicGxoM0dXaGZlYlRCNFFHSnB2ajBzMndscG9iamtOZkg5QjgwcGhX?=
 =?utf-8?B?RHB6Z29RMGhhRStEVlAvN3NyS1B0YWNJbEF6NVZBYTE1WStHOExOSEd6cXdS?=
 =?utf-8?B?d1hZQmdtNVhQa21hSHBva3FhRXZmWlBCQmUxLzFzVDU3WUlXUkg4SEJZaVRH?=
 =?utf-8?B?SzgvdEdicnpzSGxJcU9rZFFERkhMeGRHSitjQjhheDFISWlMcnF3NkZaQktI?=
 =?utf-8?B?K2p5eVkxZzlMY0xMOXRsaE9Lc3RmREtaMVZ3R3lvRjVPUmxhSEVtVWdwTlpE?=
 =?utf-8?B?QmI2Rk5FeWM0S3ltYk9ibDVZQWd6bDZEMjBaL3ZnZmVpNGcvcnp2ejBUTm9t?=
 =?utf-8?B?MjVjcUxNZUxHVm9xSTEybnFGK2F3cDEwMElVaWRjNnljb1dxMkJzY2NuRnBk?=
 =?utf-8?B?ckNYYUJueWxRQU5IMnNjcGdYNDYzbnB3Y3RIbFRNVGJ3eVdjZmNKUERHRHlO?=
 =?utf-8?B?N1ZqV3NPYzVUWDhpendialhFc0hLamM2RG1HYktSZjAvQS80aXM4Um5KY3V0?=
 =?utf-8?B?UGRid2hkUTdMemZHV2d1eUE5VE8rdTVJY1RsOTgwMGF3UThYNktZeHVPc1RJ?=
 =?utf-8?B?U2JkNUx0Qjk1R2oxQVFZMnBlRlFxZUZXZkVldGRRTVRRbG4wNlgvTGVCTFpN?=
 =?utf-8?B?YXpqRTFnb2oyZVZ4c2htcVhDL2J2QkREVitndHBBcWJGVFpPajY1OEJnVllN?=
 =?utf-8?B?KzdVSk1IeHZScWx2N3FXKzVmb0pPa0lQQmNFYm8rSDQyM2NZaW5VUWVsdnpQ?=
 =?utf-8?B?dzdNdGIwWG5XMm9YQmMzOGlWUmNFQjY2QzhkWjN1RTZmUXFwWjJjVFNGNGl0?=
 =?utf-8?B?dFJwVnU0TFlIaEhoTXpxRDgyMEFCK0lmQnoxQTg4ZnpCKzZENGNpTExReExn?=
 =?utf-8?B?dVhMVXZhWXY3czBmTmV3TmpPNjlTdVNEQkcyeS9iSWNldVRGcGtpQWtveUFn?=
 =?utf-8?B?VjB1cUFHZGxrRGJPckRpdjcrK0FYZklaNThJN1V5ZHJUSDQ0ZzZ2TW5LRlF0?=
 =?utf-8?B?RmU5b1dDa0lZaDBiQmMzZUlLMU5PRVU2QWFrTXQ2QldIT3ZwRm9ENTd3T0No?=
 =?utf-8?B?czl6bFJzRWR3RDYwd1dRM1RBdURqZFdSWjhoKzBidWwrYVlhbFkrakpzL2dj?=
 =?utf-8?B?am1qalVhUk5QUDhlSHVxNU1OaE8vMVQ2TEZSNjRoOUZVVWZaQ2V5TStGdDlF?=
 =?utf-8?B?NlRCT1ZFa2JaSkFqSVRucXRqaTJqZTBtUGlCSkJIcjRmSzdNNDQ3OHh6WHhP?=
 =?utf-8?B?UnZDMmh6K1kwL29keFphbURxcGduR0dtYUp6MXpSS1did2p4dmYyM0xWMUNQ?=
 =?utf-8?B?NlgzbkRrUVZ4NUh6WTZYMmZ0dUNoeWJWR3BXMGMwaGFLVnA3L0dsblZrZXNE?=
 =?utf-8?B?d0NMUnVkNnV4RlNKQldiZTdMa2lOOHVKOENONUE5VnJrQlE4Z1ZJR2xMTFFs?=
 =?utf-8?B?NDZDb29tZ2VkMndwcXRsVW1wUHcvTTM4dDFWd0lxUGFaRW42VEJzUDM4SDZ0?=
 =?utf-8?B?cUhESjd4eXZ1czJLSEtiMHROb3N3eXM4S0dXckh0TVNIZlBFWVp0VG1Kc0pS?=
 =?utf-8?B?UDRTZzh6Yk16Qk5YQnF6MVFWeWcyYmdGcFduSEorQzRDT01jVjRDQ1Foc3F6?=
 =?utf-8?B?blNLMU5BanJCNm9xWGwveEF3RGRaN0EreUc4QT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:21:12.5820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0787ad8-85f1-4a52-4568-08ddc606594b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9057

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
Acked-by: Paolo Abeni <pabeni@redhat.com>
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
index 1098929a4246..730e7d62854a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -493,16 +493,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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
@@ -525,6 +528,35 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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


