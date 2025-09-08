Return-Path: <linux-kselftest+bounces-40968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 904BEB49706
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 19:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886EC1889C97
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECCE314A86;
	Mon,  8 Sep 2025 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="nULpAJQ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44C03128BA;
	Mon,  8 Sep 2025 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352868; cv=fail; b=cZH9tuXY5IxRTvGlITMhI8Krsv2CtyQKGDXsiyVXyDHA96h4L5alX7yWeLXMenjAil4snXnomImDzPY3KbSQCNKx1QfUqmCgiQ7I6Lpjs15W3ASu2G2b6420k+Qa1xABqC7sh4pnOKV5LGkOW5vZqAqML7rwvwktrbeR9FZ13z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352868; c=relaxed/simple;
	bh=azlbo0PhwafGWTiPCHQ9Dm1jdZR0kwlfdvCJY7T27lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyTbSpG9oo00KmLPZf6RYz6O8WXow2fkrsSeLzZy561rfEjbkN4T27in3DgXNL0t7Zq4tV3mD0mXSxwuttrFq1kgKeGDF/xAzC74+R/I1kj+V+KtL0cikMCGbog/7uzD1Z2UlKjwSWRgNl2EVju011pZKN/L13ZXmoUw8ytyVCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=nULpAJQ1; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZ1dDvfHWwjAAPQUACUwEtewuZy6pwngVi9NzN11XZ+0LOjSC+pms1X3JSexr+NpLmWifnJt5Nh94ubfcpA+46MVCJq818IjIVukpTMzH+rtH06qtQ56NbroMG4SO7MY8lFxY/YZgfaAHxR056Gc0OmVlizS4QBWOobPel9fu7DMfy5+gC6e6Hl54OXD7InLLPaQvo0VARGACEn7ukfgZ9TowGCcFMR4Gq+I1OTQPfyHKFESREw/yEDE8i40eRfssVB7fCwgl/x/2sug5ABmVIfPAremHc0BX3xRBooFux1S9PjnFfSZGQ6En0IKiTdNMgYO8ay2hhpd+pC/5JaPTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IopfSuglR6MCcxDikYp4Evzs/AWq6tf8101xj3JPpq4=;
 b=azdd4Pq5NRKJrWmYm6kXwM1dQh/QI2yfIl2X2e7HcB+gwbEAL5hCTRD4a3oPo4V9j4trNmSfXkY+klOSaCkcr1CCr+WJVc8qLps3AXFX4ExiCefxJMGc8fW+ShcM9D96/Hc6HZbpU90/usDSRjyXoJkUYDKZOq2WUHC4wnXaycUT4hstnTAUGL25Sv+sKCUKHRHVuAZLMl2hAmnm31Z6cQHLm0iUfZ1bsnc7wvoz3b2+7peidxBHffmwrJPr4dkzQAnwo4+gSYRJNPbMU19EKzLjFNcJyHtKFY2QlFBBX19334sB7AQdFXPL+CAgcNZRXSDpsXHXjJLP1cP40QnbaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IopfSuglR6MCcxDikYp4Evzs/AWq6tf8101xj3JPpq4=;
 b=nULpAJQ17+8gj8MViqembGgWfDLN3u1zsUGKIQKjHftdSPHE875/dvX1FY5RKvaMmy8FTZbuARcoeqbXhiLVTCDBPPhCYXr4cmjQz2AKEvVi4m2RzADXz5Yibw97+vv/BFb28UgzlWKzzPJcUE38v/ZvmPMMJVJsTTV3zHSMbL89nZOAMN/DXkWiD/CHan8a82mvKwbYk3NLGjHpGhJM8DPb2I/jOG10UsbWwNzxj+TirD0Lf/LKlj6k5mhSMzOSjstoM0OjxowYbfUdnfl4+GnW2dRSyJffdDdy9Wmbb5ScBiQjJtfa1PpefQJEQYOB8iIS7VLB6+ZtdOPzpsv41w==
Received: from AS9PR06CA0483.eurprd06.prod.outlook.com (2603:10a6:20b:49b::8)
 by AM8PR07MB8278.eurprd07.prod.outlook.com (2603:10a6:20b:325::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 8 Sep
 2025 17:34:18 +0000
Received: from AM3PEPF0000A796.eurprd04.prod.outlook.com
 (2603:10a6:20b:49b:cafe::69) by AS9PR06CA0483.outlook.office365.com
 (2603:10a6:20b:49b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 17:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A796.mail.protection.outlook.com (10.167.16.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 17:34:18 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id F07911C004A;
	Mon,  8 Sep 2025 20:34:16 +0300 (EEST)
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
Subject: [PATCH v17 net-next 02/14] tcp: fast path functions later
Date: Mon,  8 Sep 2025 19:33:56 +0200
Message-Id: <20250908173408.79715-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A796:EE_|AM8PR07MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a155ec-ff05-4675-ae08-08ddeefdf07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUxVbUFIN3R4TEpOSGVnK0VxZUErNmFkNFJWNmEyQ2I2bGlqWjRtU1NuRStK?=
 =?utf-8?B?a29NQjk4Vk8zaUdrUVk5T1ZuaDVQTnJFUENxOXRVT3pvalBhTUN2dU9WU2o4?=
 =?utf-8?B?T2E1THNKdGtSSEFKdFNDcHVoQkpiRW5keVFQVmpPNmt3Nml3YTdaeXhmQ3RT?=
 =?utf-8?B?N3NTNUJ3RTZ5WmNna2d1dmRERm03OHRWRzF1ekNRa0g1ZStOeWlnTHF5Ymgv?=
 =?utf-8?B?WjVtcER0anpuQ2RBd2lkT2ZFTk5tTXExYU1iUG9RdGZjYk9xMzFHK3IwNFhk?=
 =?utf-8?B?K2tsTVRFbFVTMk1XQlJ5enBUTkVpSmU2UHVvTlZ4amFJYTA4dVdNVFBsWUlp?=
 =?utf-8?B?djhjVUROQnRHaFZPclNROVU4RVNuQnRHdFo1R1l2WDVkOHR6ZjR2dXcydTUy?=
 =?utf-8?B?Q3hGdXI5UExRdWxvNGtKZFlXMWYxbjdTWXkyaDEvclR5eTVmeGVRcmYxVVhs?=
 =?utf-8?B?aE9vMGlYL3FOa2FKT3VHS3FOeWlCa1d5OEF1Y3o4ek5QQ09HZS9JbTNmU0pV?=
 =?utf-8?B?ZHNDdlZRb3llM0lMelVYVVBiZVMwanV1OGpUeWVwdjgySG5TeFZqZWpFbENM?=
 =?utf-8?B?YlkxNHJISVRDZXNyMFlLK2EvSitubWxmSmxRUWV0aWJvcTZPRk8zTVZBa3pK?=
 =?utf-8?B?SVZLeDVocndwbldiVnh1VWU3QzM4TGZQK3llM25qQzh2M3M3R0dXL2dtTkZ3?=
 =?utf-8?B?SlJtNTlGQ2pBWVJkckpyZWpIZER6NWVXdC9lTlBIczJqR3BiZG9jYXNsbVRa?=
 =?utf-8?B?aHNZcndkYzQ0aWpET0RtZ1F4djkrK0puUUcyck5NYkVvNzBnNFNWdlBPL2ZR?=
 =?utf-8?B?UExJVlltZTNRR1d1SFlzZ09MdzJsZDgydzE4eFI3b05GRHpDMjRMY0xReGhQ?=
 =?utf-8?B?K1hNbDBpNkVhdnBxUkh3Z2g2SXZzeG1ER2Vzc082SkxoaEdiZFMwVHJWeWo3?=
 =?utf-8?B?cUZtZzF6MjBleXkyVmJucmFGMmthUXZqaHluUVhwRHg1UDZ5b3psd2tUWWg5?=
 =?utf-8?B?SU56T0t3VW9sdmVZUDArZXBzQWw5aG05ZkZidGpHbWxLeDFza01uZDV2b0RH?=
 =?utf-8?B?ODFTeldQVXNxQjBwWGNWVFdhNGhpZTZnMjgzaW0xUnlWMFErTW56QjV6bHow?=
 =?utf-8?B?c3E1RVFTTGhOQ3pPOUxoNzY2LzU4bE1JWHJsdlh6OW8vM3VIeSsrTTB4TDFS?=
 =?utf-8?B?bmF0K0wrQ0QrWnRkdXU0dGNBSUZoWGJFNEl5clkwVTVpVXVMVXpMd2liN0xk?=
 =?utf-8?B?RXUvNVhGajhzNDhlRHZKbGhjQXpibURHeHh4NG1pa1NEYVVHeXBhVHdvNmwv?=
 =?utf-8?B?dHQzbDZBOWY0VkhGdG1SYnhka1c2ejBRdkJDMmpKcldwU1lOL0dCdDZ4VEJh?=
 =?utf-8?B?YW1RUzVNeXFRV0VtWFBSODNnbk5PaE5LWnZ5T2MyMUtvTStiQlVHY29USEgv?=
 =?utf-8?B?U0Z6SFNpa1Rwam5mVGtMZDZIRDNFbFVVdlJmeUczZUdhR3BnRTM4TVp1cHE1?=
 =?utf-8?B?MXJBK01KVUFKeERBZ0JMc2FaM3U1RmdrY3dlSVpGandIZ1dycm5hbXpPSmND?=
 =?utf-8?B?ejg3THVCS1YyRUJ2YnBwcjlYZnRpM0ROempOYkhSTE41WnhnWXdxQTZUWm1k?=
 =?utf-8?B?bmNZWjVmT3RHRVVJRk96OWhDRmdEV2JZR1U4OVRmS0h6akgrK3o2NkFHbXNy?=
 =?utf-8?B?cklCVGJoWmRhZmgvbnJETm1CM3NydmVzSUlneFBYTHQ1VW5FUU1SZExnMnU3?=
 =?utf-8?B?Tk1GVUw5RXFocE1RWGNoKy84d09leTVlb1FScC9xMWRQdEhnS1pLN2xZRzVX?=
 =?utf-8?B?aXJHR3kzb3F4WXdmaDhJTVFOUU1QK1A4M2pvMUNoT2RTck5UYXdIVWgyL2ZU?=
 =?utf-8?B?VEUzblNnUHNKL1h4U1NQL3MrQUtrZG02alFrOVJsMVp3N1lTTXd4VHlBd1Rj?=
 =?utf-8?B?d3h6TjhlZ0Z6WFN0NXJRWGNmbll6b0xKR2tEV1h3Nm9rRFRjaFR6d2JpTTJD?=
 =?utf-8?B?QXFDK3E3eXF4V014ZFBvbkJuNWJnTWhRdG4rM0MyNTJnaFFkRVM5VnFCekdV?=
 =?utf-8?B?bXBCeFVNUEtocUpaTEpHMWFtWFZCd3N3ejhJdz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 17:34:18.4500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a155ec-ff05-4675-ae08-08ddeefdf07a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8278

From: Ilpo Järvinen <ij@kernel.org>

The following patch will use tcp_ecn_mode_accecn(),
TCP_ACCECN_CEP_INIT_OFFSET, TCP_ACCECN_CEP_ACE_MASK in
__tcp_fast_path_on() to make new flag for AccECN.

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h | 54 +++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0fb7923b8367..905fd63be74d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -821,33 +821,6 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
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
@@ -1807,6 +1780,33 @@ static inline bool tcp_paws_reject(const struct tcp_options_received *rx_opt,
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


