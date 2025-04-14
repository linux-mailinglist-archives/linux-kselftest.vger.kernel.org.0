Return-Path: <linux-kselftest+bounces-30689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C18A88166
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC2C3A7C5F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4B02D3A9E;
	Mon, 14 Apr 2025 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="pyJ0BH35"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2058.outbound.protection.outlook.com [40.107.249.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3844E2C375D;
	Mon, 14 Apr 2025 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636442; cv=fail; b=eTYe2uQt8/kN3T7ddABGtvNatI4jhf3WDkw4h0nrdk+AWxn0lkRZK6akzNDO13Z5QHOA5YNmEykW+8kDsawp/Qn0IvXEHVmltjLeII7jkdiovadT3xEASKbuCSKj4GaeEOzg3RjP7GVmE9Ltn9saZKP2pda7WEA5bmIxdyklE5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636442; c=relaxed/simple;
	bh=jzGjlVHTjyWEGx0OxJrvgDWNiNQ6gwMZm/yT5kX2loA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpNuiFlCoHU59Yx7QmHHB1Uu7KJPP9eUjinxBj2OWJ/tlsKo/YuwUe5U7mXj0Gb+iJt0zXY7l66RCg5yQknHuJ+MwOg6ytViSSbTXYaLUVqMgPEFcvUZ/6MufUIV97tJtZ4toahVk6+ctpx7evsrexiinV2OjA4/KkijpUCVf2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=pyJ0BH35; arc=fail smtp.client-ip=40.107.249.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSHRgXUdxG8/OwHZ2N8qbix8e6N3YQQDfHy70hOepmFu1wTF1qAzuODzm9GBM7NsslNvrr7ERx6u/Bfgbf7Ly7Bc//Dhk7i7Tpj8sER3Y8E6KRbrwy0jlbMSJPudv8iD1mRFuswD2+AkkT+/olOk1HfByQ6emXSeM6peV1iJvXATTOAkGdDbbeqjfkHo+4rCNOTeJKOfJZ2BTSHwcsHvgOWqSpVE7BaXwRFyrClldQ/+Jqfbe3eiOucZFcK6wvavwJMvIsKp8+cMb9IstvpJTfGw412Kf04EAiLG9qYWhEqIvIHp2L/gxiRbZXdE8ywe2RDpNWQbfCs1gk+WOWvP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aP/7Psq07ihqriJaEJ63jaVwaWZLAB4da/DunpSK6As=;
 b=jyvpuZGhLkkvQ/KlP68FjjfOVQI15687I0E9wB4MvcwQlqlzSllDqsVrVwzf/pTNYYKuACK0g6MCpQ69/c2SWhQqX5s2ZA6E4es6UNSoRU2BkoC1+SXU4hGTu1lsY6fFv+XhVHKitydrRd37PPG02geIUWb6JlYfoYP6/otKv9hQtLvOht1Jh17W0dCT5ylry5ocewoSoMxttdE+6vcpxVBnV9l59If6IYMZPK0ph7NSwDBL1vTBRksv2JPrZeQejmoer4UczOTg81oHvKrH3A+jZ0HSylpUzlptH3yCuWuvikMkIWxrXI2sq8w2QTEdFbwY2AnrmW14sLSbU7Bt+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aP/7Psq07ihqriJaEJ63jaVwaWZLAB4da/DunpSK6As=;
 b=pyJ0BH35b7ZiObheuECAY97AkuP5Xe02OT95giHEN8vdlO8RbwB7RA3acN3n/R6ORUvsV4ymr4PfPoARgP8gtSDlFAMA7OhNBgsBLLw9SPBx15881WUjr80+Z8QShRRD1SSm7gPLcGvvABm60hIrULyH6qKwuKzJAYR+2jM+3EPBiFpCU15bLGo0hENyMElxyUIsSJVR6WDsKRtgX3bUlMnJ6Vvs4ZEroe6KxON3+Yko8NInzqBcN7LkNb1DW05fFBOnf4SV8uwZ9EUyE1CQJzsrKYF/HO8NJGoixNcg+RlLLZnUgG3iaaRRnN2FB0IXbuEmm8HTUL/0sCU62mCnmA==
Received: from DU2PR04CA0301.eurprd04.prod.outlook.com (2603:10a6:10:2b5::6)
 by AM7PR07MB6454.eurprd07.prod.outlook.com (2603:10a6:20b:13c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 13:13:58 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:2b5:cafe::41) by DU2PR04CA0301.outlook.office365.com
 (2603:10a6:10:2b5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 13:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 13:13:57 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 53EDDQBD009623;
	Mon, 14 Apr 2025 13:13:55 GMT
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
Cc: Chai-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 02/15] tcp: fast path functions later
Date: Mon, 14 Apr 2025 15:13:02 +0200
Message-Id: <20250414131315.97456-3-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D04:EE_|AM7PR07MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd1b3bc-092c-45bf-b91f-08dd7b5636de
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NCsyb3BlbUVwZDV1Y0pmWWprR1MwTWRQeGRlMzhFWkFkRURyNUNka29CNEZj?=
 =?utf-8?B?WmZBbCtrWUZsV2JuWVhuUjZpb2NHd3pLSWFVQlNEVHNhMm05akNqQjcxbEZO?=
 =?utf-8?B?anBXZUFNdUx2Nys1QUhmNERKTHUzTHNkYTZ3UVByTXFpRXlPdldyWXF1NFY1?=
 =?utf-8?B?L2ZydCtHeGh6KytwUlVxZ2p2SlpqQ3F3Q2d3NU83RFNVZTlLK2lUOEJDbXdp?=
 =?utf-8?B?MGJPVXpLdWFlWmJDTVZhU0dHTnpVWXUzRFpLdGx1SjVmMjVUSHZ3dzdMUHZl?=
 =?utf-8?B?WnJwYTg5MUF1cW56cThuRDJLSEg4am15MEFzY3JpNFhRSTIxK0pMVGhJSk94?=
 =?utf-8?B?VWU2M1RzQU55RGp6ZmdnZnVSMlFkZXF6ei9tS1JIZVZETkdxVE5Hb05RTFcy?=
 =?utf-8?B?U0tRdUlRODZndWVuQW4wV3Zld3FYSVJXd1VUMENtVGtsd1F4aDA2SWdEbTBZ?=
 =?utf-8?B?blo1cnVYMGw1WThrVG9keEsyMG1JNXQvaGp2d3hTdHhJU3AwNXVJSzhobm81?=
 =?utf-8?B?WllGcnRldENDd0hlU1Zndk80dGx0aTFJK1NURkw3RmJyMjRuRFY0dlZWeDFR?=
 =?utf-8?B?Vk5lZTFsd2twTzJRdzAzY2xMdTIrWWdORG9SWENLalVsOTB3L2ZmaUlCay9G?=
 =?utf-8?B?dnoxbllwa25UZTZHSXp3R3ViNGw5Qzl6cEV6dXNNOWR1SWhsU2lwQjJwWjA4?=
 =?utf-8?B?WVh3ZzNaRzBScmpRbDFwVVFxY292Znd6M2tTQU55aC9CbEMwWnVCaUplWWY5?=
 =?utf-8?B?NENxYXpUeTFBWk9yV2JkRG9XUDBQMEhGdnRZdUZ2NnY2RjMxZ3llMkQ4ckg1?=
 =?utf-8?B?OHlTSmRuQ1RBT0taVldBL1pZS0dhK3JHWVRWQVE1NnVVWXpwSDJpTmc5ZGlU?=
 =?utf-8?B?c2c0OTVvNFNKdjJNNlBVOUdmOEQ3Mk5xNTJrT3g1TXdDWnp3Wk1ZdjdEN3BW?=
 =?utf-8?B?L0d5dWJiTU9JMThZTDh6cGJXUlUyZW5RYW5lRkJ5TDlwTTVpNkY5eHFzRWxQ?=
 =?utf-8?B?NTQ5ZVVWMm1rUHgwbE9nTmlKNXkrVE0yOURyN2krWU1aanRUQU1DOWZoSDhU?=
 =?utf-8?B?Z0poR1NMN3BMZkZwcjgxVEhFSEpPNWJiZGNDUXM0Y0MyU3ZjLzhVa0hWWEJk?=
 =?utf-8?B?YmlhVm9mQ1l2dG03eWNzWm5Hc3pnZGRYOE41aEhKN1drZDMwemIxNS9KV2ti?=
 =?utf-8?B?NVpNNWU4SUV1b2xWQXkwd08yaVZ3Nlp6NmVLa2JKL0d0ekQ1UGJDYUtRdUsr?=
 =?utf-8?B?RUJFMGRoT3duVkVvcnZrbzBWZEVDTEE0ZUtpVzhyVE5uU3h5cmdrTWhxQkpr?=
 =?utf-8?B?UUR0NTJtcktabit4TkIwc2s3Z0RaR1Y1amZkaXBtNFRrOUdRVmNBSjBEaDlQ?=
 =?utf-8?B?cUp1dGpMeDB3bmVRZm9vV2JPeERISyt4YWY4cWkxdWMwN3Z2eDFJV1JUaTBv?=
 =?utf-8?B?OTlRYWVXWmlIbmwvYXRDMmo0aVlCSWhKTk05Zmdqd0FFU09NRmtHMDFWbHFX?=
 =?utf-8?B?TkV4NFVZNHRuUE5ORFBRTjRVWGRsaGFWYjE0UGRyUitIUFZGUWFRd3h4V1M0?=
 =?utf-8?B?M1VCdUw5K3VQRWpQSlNwWWozZjJhMzBKeVN5enpwSkpqNi82UjUwYXdzZUNQ?=
 =?utf-8?B?VVphYXNLS21kOE9lK0I4ZlhUWkYzeU9EMDk0ZDdFZlh6NlJBSDB6eW9vOTNu?=
 =?utf-8?B?NjYyQUdYRUFROExDMTBpdmtJZ29UWE1HazZRVGptTVVTL3I4RWZwdFRQVXpI?=
 =?utf-8?B?WVZoOWhEZ0psNlZwTnZIREZBODdOVkRVd3ptYjhRTG05SGw0Vi9BYWNlYnZS?=
 =?utf-8?B?c2lBTFdnZ2VQSFBQdWdsQ3VvbloxamhvM1dCbFl3eVBIM2xUN0xzY0NTdVU1?=
 =?utf-8?B?bUNqYjBJVldHWXRmNFJrZ0FsSFlCUis3SUJ0QTl0cnRLMFpLYmxpVjhBeFp4?=
 =?utf-8?B?bTMxNVhFQVAyYkxINlVLNWd1R0JTODk0T3krYTdzcHpUM3FEM2gwaHRFR0J6?=
 =?utf-8?B?R0V1TkRWWE5NNGxwTEQvQlY1V01mSC92Q0FLQm5Xam9lODhBWDViVFZ2TUk1?=
 =?utf-8?B?RTJWQ3E1aFRlbTVIK3pJUnM4YjV5NSs3WVA3UT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:13:57.3510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd1b3bc-092c-45bf-b91f-08dd7b5636de
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6454

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


