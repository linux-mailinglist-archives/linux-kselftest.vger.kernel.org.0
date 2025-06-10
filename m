Return-Path: <linux-kselftest+bounces-34564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1141CAD37B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BABD16940D
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 12:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363342BF3E0;
	Tue, 10 Jun 2025 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qWoK5+wT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012023.outbound.protection.outlook.com [52.101.71.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529AF2BE7B8;
	Tue, 10 Jun 2025 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560009; cv=fail; b=AiJmfTdh7OqmpB9ghCSta958Qqu2Urg2OfXqNmSghaypXX9eEWKDGRi+n0/GTR6SkaKzHOVuknbn2m996IRaifAEGKgPapIkoMmCFvZqcBTiFhNQdJbreAkiRfEYtBloyY+r4hlYh/NRvkQTt6H7oUBBK2IILxDW7wtoB4Ns8pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560009; c=relaxed/simple;
	bh=jzGjlVHTjyWEGx0OxJrvgDWNiNQ6gwMZm/yT5kX2loA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/ooCMqwmeGQv1InNlQq56nMKCq/oqFXVUjFGssmaJ1/+FTn/sKF7ba3RizaSOmrHQVZsGqNBkuWXl56khz1jdCZaaB+AYL9uCzPC9PhqijZKCmUJUxVbyQk2XbOf1TIfs48QNVnwK1u3HRPdpr7KQYGK4Z4tyneKdCb/cY6/ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qWoK5+wT; arc=fail smtp.client-ip=52.101.71.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGDjPmkCdxOBY3lWGJeB6NX2kmdtzSfsDIDudgoy6WHoPC98HDWrXUg7KdS/PFQnraSTks4r3/KJTKqD9h15dpGlH2BSRJwl23lVx0zP2xQvFpNeHBh/YB1bNtViXM8FjkzeAM30Gt/pW7UWT0MKo2hmIF5cNZycCAZERSa4TR+e0B3RqNsfOttJDaY0znA414Q+pGkXz2A/tQn0JK5UuS1wx+8uysMJfv58uFeT4wSEBT7/wyw6QSSlNoT34WkpPUQ3DXNRIpsTGdSEkoBK4WDNMAQOVCCnhQCp/61HjJZB88UZ4bR3LjT61ZEKyStwJMxP2lOXGT3yf5XAH+xtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aP/7Psq07ihqriJaEJ63jaVwaWZLAB4da/DunpSK6As=;
 b=yeIfuHfetbUT925FOAg+y2pLJ8Nc/EndnHVVzd07IvJ5yhCtK8ny+Fm9ZAr2ozhhHOf6ZbgjXnPR8H594yj/jFbCfCUxj5PBak9v73sJetI/LcBc5Gew/H5xZVdo4HdBWd8IJ8mMGx7ZV/1lrnvigDsPrf4QS/ZOQxwOfKI7ffiMrE8Hv9X/MkLzSyKk2wPObHsmudmgaw0RiExj6XYlE4+kGe4CxjpF18iAi3ZGLA0WFDqoRZtGj+HuyWCFzp9n1Vr0R4RcC1u3bbWmD7pDjZfY+WA0T8gJIqZmEx9gP+7N3bZ2TSBhqPgPsdUcRGBV9d5FDSEB/J9u6WDxnf0oLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aP/7Psq07ihqriJaEJ63jaVwaWZLAB4da/DunpSK6As=;
 b=qWoK5+wTCGnrWymgIeLfi3XPWSLXtkWztY8oITRXyqQC/tHVyH4vKjVa+MuapESFOoOQAthonaLiClBYJuIhvVO3IlUNTfCOipvQFjdMGw/r2VSxNkBbtGJOL2cFidyAI5WN5WEFL+Whmmoi9LrdccD6kC+qurjIKfPg8UGa8w6CwyGZAn9ah2VBC/alFrDTUQPtZ2UcIBMSp7dEU6tinGq7Qa3+Nd8HQpS4Kcn+jZWJMlwMp3optvnECLfMWUwJ5B1bORJyZy2GQciVKd/my9mkZprO972WAm3JWTo8eqkiDP5ZLdYdSnG/4p4Sy4Y1a11a8tsn+Ek9xIjX9T8MaQ==
Received: from DU2P251CA0004.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::14)
 by AM7PR07MB6705.eurprd07.prod.outlook.com (2603:10a6:20b:1a2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Tue, 10 Jun
 2025 12:53:23 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::d5) by DU2P251CA0004.outlook.office365.com
 (2603:10a6:10:230::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 12:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 12:53:21 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 59813200A2;
	Tue, 10 Jun 2025 15:53:20 +0300 (EEST)
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
Cc: Chai-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v8 net-next 02/15] tcp: fast path functions later
Date: Tue, 10 Jun 2025 14:53:01 +0200
Message-Id: <20250610125314.18557-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFE:EE_|AM7PR07MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e90916-1477-407c-445a-08dda81dc845
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?V0d0RXJ6azdkbkx4eG5mdUlCdlhzVTg4WHBFT3J6dW9uRnFHMnQreUQ1Q0h3?=
 =?utf-8?B?SnFQSzZjMHptaE5oTHdjQ1U5NXRHRVZEeEkwVE9hSHpYaG0xcFU3RmFnV1Fh?=
 =?utf-8?B?N3VrVWk1VXRZSUhLRkxQSllIK3RycC8vTHJuSXpTNkRzWi9ZazFDRlRsMk9u?=
 =?utf-8?B?aFZuejVidUMveUUvUkp5ZWtyNXJjZHZuaExyb1RPMTBrZE9UTG5kZXVIMUY2?=
 =?utf-8?B?VUVVVDhVL3V6TGplLzRFTEEycm1EUndJMk83bUxDditkV29hbzg3ZDloNU80?=
 =?utf-8?B?MmFLU0xLSEQ5OFpjVDFVRmJUYTFBTkM1R0JaZXEzLzJsQ3NqUDhyYnBKRENT?=
 =?utf-8?B?Y0s1TEk5LzluT3N0NG1qZk1Pb3oxYmdZUTFsNWlXL0hKdEtZZUM1QmlGcHVF?=
 =?utf-8?B?SVR4blpla3F2Q2hMTnBIQWtaVHJSeFFIcFlIWFZZRDZRYnJyVHd2dDRlcGVy?=
 =?utf-8?B?eTluYTZrZ25RNXI3emdDYis5QXZDTmtrOEZNMUVXZHFBOWJZa29UVlFkSVRz?=
 =?utf-8?B?WG5MZzZMTWMxZS9OOHJaK1RacWh6VnJqT2tzNiswa0V6ZzJ6VXVDYXhVN0dp?=
 =?utf-8?B?SEs4RkxxUHFwa3U2K1AyUnVEaCtWUHcxR0R5TE93UXpaZjAxMmZISjJ3Z3Ns?=
 =?utf-8?B?aDJtVkgzRmZHdkw1RmVRVVdJaDJYSnpNWFIxT3VlV0FzTkUyc0dOZHJ0OGdx?=
 =?utf-8?B?MjlhTUNDYmVGdnpRbk1kQ2llWTZ0cWpzVk1wV3FCT3JCbG5CYWFsd2JqenhU?=
 =?utf-8?B?dWtPQTVGT3ljWUtmbkl3VFZZd2x5RjlRQm5WeU9qdlVuSVIzbm53a01ZN0h3?=
 =?utf-8?B?WFExUlYyVTBlRlJhcHZGdXJYODRwVGNZUERkeTd6VXhaY3FtcUxnNDFId2RM?=
 =?utf-8?B?Sm4zRXFvdHp0UG91OUs0TFRWVkl1V294NmlNQkJFOStJQnpZRUIzbVJxZlh6?=
 =?utf-8?B?MVpEa1E3dlY3aXZ4dGR5QjdzeGJxTUtqd0pqNWtsV2lyYVZJb1FOa3FEdTE2?=
 =?utf-8?B?enlXSnFrZlk3bmxyQUk4OS96dWRRdTZHNzBLaERGVXYzVHBiQmNTZFpoZ1l6?=
 =?utf-8?B?Q3hITzkyMERPOVdvS0VscEpjS0pJbzdiZ05SUXVXNDVzdkR4elc3V0ZGakRS?=
 =?utf-8?B?dm9KYWJETHBuR2FQLytMTStKNklMZlI5dDBTY0xjRjZyaFQwOGQycGU5d0Ey?=
 =?utf-8?B?aEExcGtudXRsMG4vWGdQa0RNUmM1cXJTeEJzekl5NGdYdm5iK2hDSGUrd09V?=
 =?utf-8?B?SHZEM3hLYTMrL3NqMU1Vdk9tTVNQQnEwdy92c0lqU29aaE1KRXZpamE2aWlx?=
 =?utf-8?B?M1ZFTVJFV1lnTTBKbms1VEcvMlRuM0lyTHJ6L1M4UVVFNUR6ZkZ6MmU3YjJa?=
 =?utf-8?B?TVV5MlpzWTZkQVEwVmFiRTZrU3FtYWlUa3ovSU1uY1h6WTBHK1VvUGhLOFhz?=
 =?utf-8?B?MjJqREpMd2hWN3R4dXNheEJVbzZKUXJ0bS9mSlpsRm1INnZoanYzeGRMQkN3?=
 =?utf-8?B?ZklHdHpVbkZZVHh2TmNtYU5LVjRISHAwcUZuTUVEK2NhWmhCQmczNzE0SFlo?=
 =?utf-8?B?YmhPMUdISDFDVHpoWS9rU2xSZHUvQnk2aUZ5NVRoNUVKcHR0aG1UOUtMK2dS?=
 =?utf-8?B?bU5rdzNwTE5wT0doMDFITDBSZTdJbEorcE1CNCtCTDd6YjFjbXYrN2hLYXZ5?=
 =?utf-8?B?VDN1WnNBUS9YTGdML2RNblVpcmJQZmppWkRka0xpbmlMdTJKUnpPaFB4VnV4?=
 =?utf-8?B?OC9vYzIzNkQrSG8wM1d4RzNxOGlrRDU5bGRzTlhNdFN2VXVNM2p0aEwvNmVa?=
 =?utf-8?B?OXFkVHg4QmswTWRxSStiRzRGQjA1U29OR3ozTkRaa1BtYlJqNVZtSVlDbXJ6?=
 =?utf-8?B?YXFEaS8xbzA4SXRoNzBDWFZtbFRZTTRHU3RYMzFTNUVoK2lOM2ZJRUc3ZEdk?=
 =?utf-8?B?TWV0U1YvTDY4S09PRmthZzh4WXBmYnYydjFCSEFrSE1YeHF5WFZ5Ym5rWG43?=
 =?utf-8?B?KzN5a0JmaWZqb3lFc1RIQ2FhTHpzQXNyUGRvL0pIU2dqR3F1MEI4V2RUWGVG?=
 =?utf-8?B?WUZ3bGRPVU1LWUJUckNsRW9vWm9zMXMrUDBhdz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:53:21.8639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e90916-1477-407c-445a-08dda81dc845
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6705

From: Ilpo Järvinen <ij@kernel.org>

The following patch will use tcp_ecn_mode_accecn(),
TCP_ACCECN_CEP_INIT_OFFSET, TCP_ACCECN_CEP_ACE_MASK in
__tcp_fast_path_on() to make new flag for AccECN.

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chai-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h | 54 +++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5078ad868fee..4dacd4a11669 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -812,33 +812,6 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
 	return usecs_to_jiffies((tp->srtt_us >> 3) + tp->rttvar_us);
 }
 
-static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
-{
-	/* mptcp hooks are only on the slow path */
-	if (sk_is_mptcp((struct sock *)tp))
-		return;
-
-	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
-			       ntohl(TCP_FLAG_ACK) |
-			       snd_wnd);
-}
-
-static inline void tcp_fast_path_on(struct tcp_sock *tp)
-{
-	__tcp_fast_path_on(tp, tp->snd_wnd >> tp->rx_opt.snd_wscale);
-}
-
-static inline void tcp_fast_path_check(struct sock *sk)
-{
-	struct tcp_sock *tp = tcp_sk(sk);
-
-	if (RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
-	    tp->rcv_wnd &&
-	    atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf &&
-	    !tp->urg_data)
-		tcp_fast_path_on(tp);
-}
-
 u32 tcp_delack_max(const struct sock *sk);
 
 /* Compute the actual rto_min value */
@@ -1798,6 +1771,33 @@ static inline bool tcp_paws_reject(const struct tcp_options_received *rx_opt,
 	return true;
 }
 
+static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
+{
+	/* mptcp hooks are only on the slow path */
+	if (sk_is_mptcp((struct sock *)tp))
+		return;
+
+	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
+			       ntohl(TCP_FLAG_ACK) |
+			       snd_wnd);
+}
+
+static inline void tcp_fast_path_on(struct tcp_sock *tp)
+{
+	__tcp_fast_path_on(tp, tp->snd_wnd >> tp->rx_opt.snd_wscale);
+}
+
+static inline void tcp_fast_path_check(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
+	    tp->rcv_wnd &&
+	    atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf &&
+	    !tp->urg_data)
+		tcp_fast_path_on(tp);
+}
+
 bool tcp_oow_rate_limited(struct net *net, const struct sk_buff *skb,
 			  int mib_idx, u32 *last_oow_ack_time);
 
-- 
2.34.1


