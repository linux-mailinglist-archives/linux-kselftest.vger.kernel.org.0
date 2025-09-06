Return-Path: <linux-kselftest+bounces-40880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 826FFB47440
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 18:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609DC1BC5709
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B192E371F;
	Sat,  6 Sep 2025 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="TFPGOWvR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B71229993F;
	Sat,  6 Sep 2025 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757176144; cv=fail; b=J3uGvffR2kM/mAmFp718SvWGbUw83w9/k/X68qf4HBY/Zb/zDXxmJRu9p4UDK7Y0dZP2gdjWm47SNiktLjCSMk+vdDBhBB/XA6djgKtASFED1O8B+5/Ro6zaGS7X55ODpY3HviN02vJRM2s4Spo6zaJ34O5FHuFOY4rHZEU/Lvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757176144; c=relaxed/simple;
	bh=azlbo0PhwafGWTiPCHQ9Dm1jdZR0kwlfdvCJY7T27lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLsXeQeolNc+OX6qrz3Dd7ZDh7K5nEN4xELz3eMO/rqCVvj9X1f7kCnGnG8kGw0RSTxMbiKKsTeqhPwXHjvKpbgZbCHdxa8jsp0AVHKGBDr4U6OvKTdqOGWjoOzxaV/yfqU+dWyYX/VJHF2MpxpFnrFqsZMHSf+bA6nd2tDzZPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=TFPGOWvR; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9VAw+X2wHm3Oq96P7Zr1NrTPLcc2pGNfFE/fqIu4w48bml30BIyuwU2YCR/NRGTvUUaUu3VxqiIrigkXjZEKENA9Wced5fhN9mRQixu3sY+3K9o9li2z5BUvR5AhlLuhnZCk1unDTN0EA/tuUOAqw8ELsvZIaM6y3TC62FlX2Rt/GIPosOKzXkuL6/ltg9ytyb7nmKRd35NsxTcbJN/+pptIGJgNhJloVZ9ca/xpt3GHFxAIC/Xo0V8Sr7nzC1s5tvtT989p+o1/BYM+cjQnKEFzPXaG3XLH5e2i4AOmyzHa3fPwGLDXT0ibK17qB9lDVcsIrfYol4zG9FQnANvrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IopfSuglR6MCcxDikYp4Evzs/AWq6tf8101xj3JPpq4=;
 b=Dy13K2Z5ZrEH81+2X3HRGgCixISTa0CR3EYU2pz8rk97y5WniernIsrCPWtos83fD+SI0IDUjaYgxLQGwF+86XCAW7BJLEL/fRZObXl1fWuJgdx/EpuY94iPjqffyxG30XGaZjb0nna20ISJkswKpaFQHJ0kovQGz1J+U0NHajSlX2hFYfVTFAmGT/qpGQ/wKzKOTn0EePnNTv4zM1X0YnapG3SnvuDlZsjADiqh8t8YBmO99h3FydzHIKl0LlWzUqwsTlKL7JHqPcTsUv9tcYMLVccUNVpJODOGdphX3gLe5OXRPGdMglmhpNJ7ZVN+to8M1X0LqDOjbV9gyWXUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IopfSuglR6MCcxDikYp4Evzs/AWq6tf8101xj3JPpq4=;
 b=TFPGOWvRYivB1iK0bs9S2K32+2KWmC4iIrlEBf2uzzekDW/+C87k/77sIEyAxS8/gTehgKGN12G9q8TchF8VwLdZYHg1hnOWPYaFfM0cmwiFllKKeflKMSlAE7QPOBWw984fWKvhys1S6CalkbWqDrmyzdxyHho/wOgRhh5LWBWm5cdg1DaFjTc2IzRalvs7eGNRQym/G/5+WhdqgbTEkTPDvDOrWf2ZxBNoheWyrVAUIixVKFupLtev4gL9nodhRGCHZqUyuiEA1uRWFxpmEo8i3mwm1ovGK3nFbYXcmsVWbiXG0/9GqWIWxl9wzeWs7PFjmPN5iJk+ELLJwFY50w==
Received: from AS9PR05CA0236.eurprd05.prod.outlook.com (2603:10a6:20b:494::11)
 by AS1PR07MB8637.eurprd07.prod.outlook.com (2603:10a6:20b:474::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Sat, 6 Sep
 2025 16:28:58 +0000
Received: from AM4PEPF00027A63.eurprd04.prod.outlook.com
 (2603:10a6:20b:494:cafe::ab) by AS9PR05CA0236.outlook.office365.com
 (2603:10a6:20b:494::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.21 via Frontend Transport; Sat,
 6 Sep 2025 16:28:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00027A63.mail.protection.outlook.com (10.167.16.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Sat, 6 Sep 2025 16:28:57 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 65FA71C0031;
	Sat,  6 Sep 2025 19:28:56 +0300 (EEST)
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
Subject: [PATCH v16 net-next 02/14] tcp: fast path functions later
Date: Sat,  6 Sep 2025 18:28:38 +0200
Message-Id: <20250906162850.73598-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250906162850.73598-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250906162850.73598-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A63:EE_|AS1PR07MB8637:EE_
X-MS-Office365-Filtering-Correlation-Id: c43f1539-514e-401d-5c04-08dded627ad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0M1U0pwSW5nVUtzRktSUDFnNVdDTnlSOHUyTVVNeFMvbDI1S2Y3THZMTVdi?=
 =?utf-8?B?ZXhtNnZaNjZSdkhMUCtodlpwL2JROGh1aFdBdVpwdDU0TDU0SzJ6eUJqajND?=
 =?utf-8?B?TFUwd1ViYUpQRnhoczZOWm0xSkRUYXVxZVBndzhhY0FMMzk3N3crUVE0cThq?=
 =?utf-8?B?Zk1kYlBxR1lZbnA1V3ZURXZuaU9BeVRvSEd4TG1qQ2tJVmkrMElhVnVWVTI1?=
 =?utf-8?B?aVAxLzQ2U2EwU0Y4ekFXTXRFSHBWVVZtQkNsZmtKekMzd1RHSjNjTkdkNFRo?=
 =?utf-8?B?NXJwdmZvOWNJK3pGWVlyT0pYZ0EzVkU4YWVBemRibnQ4QTRsV1AwUnpndzNm?=
 =?utf-8?B?cHJrUi9iZnJJODhXRm9iNlBqbHBIWlZXUXUvb09iL1BLTUlFZzRKV0h0MHhy?=
 =?utf-8?B?T0IxQzJoZm1vVi9rQUZBUE05VFFueHdOeWFiaXM4Y3lOcld6R2xSQUFpQ2lP?=
 =?utf-8?B?TmxMRkhmOHdkZnBXbWdrTmlwRnh5ZTNlamZqWWo5YmtFejhzbVR3K2YzQlVZ?=
 =?utf-8?B?SWcyYUEwZ0YzdFhJbFVySHhLUnRFUjVLMU1tVXc3WHVLejZJdWp5dmlZUzBz?=
 =?utf-8?B?bUp0Nm5nWlU0WURxWVpuQ25CSTJGenRGamYrYW5uS2cvU205RGJ4R3BIbkd3?=
 =?utf-8?B?cDhySXhvODZ2NVpaTTV6eGs1dmpISm1nQWxRekkxWjdFVlQ3WEZDS21hSHFS?=
 =?utf-8?B?aWg5c3JJU2pVYSs3UjdrTnliRDNLcGJSaHpDVWtEL2dSbGdsaS8zaC9hYnli?=
 =?utf-8?B?UldyOVh0aUZ3YmQ3YWZRVklJbWJKTVFUblIwWkgyc1JaMWxyc0RBc1JzTGNl?=
 =?utf-8?B?YXV6c2h5cmhITDFJN00yUlorOGkrTVJHN1NoSnRTWHpxRVZXSHpqRkE4L1do?=
 =?utf-8?B?dWp5S0h4QWJXWnl0S1hXZXFzcDdwZTN4SmtIenQzUWVXWFZNVG9KcXdyZDlz?=
 =?utf-8?B?bUlqRmtoV2YyZVR5elo2aGJDaWNDWEJ1Ty9rOHk5cm1ZbXcyaFZvNWFmcXk1?=
 =?utf-8?B?NW5pYzRESElUTFVGZDhBRVpIeW05K3ZCWThBR1dQYXh3dXBZZWgrdXR3RDBh?=
 =?utf-8?B?N2orWEtOaFk3cU5vOFlxSUU1bk16NUxhckt6cTFDRVpCSlRMWUkybTlMQ2U2?=
 =?utf-8?B?cGxFZDhwcXp4K3ZTY2hVcWxZNGpSRzkzTkJNM1lwWExEOUdwYlRqNWJzd01p?=
 =?utf-8?B?SFdVTTI1RUd4OUFycTYvN2M1MnpQS1I1ZE1wdHFjc085LzVhSWJ4RFJLay9h?=
 =?utf-8?B?cGFTNnNiY2dxTTFSMUhiZloxNFM0NEtBcEliSE1Nb1JKM09PaU05ak1SOHc3?=
 =?utf-8?B?VzZWY09GQnQ3bGU4OFVGYmN2VWlWaGM5M3docy8wbVdqOXFZMEs3M3JFUm9m?=
 =?utf-8?B?azJoS3lNUGJIbXc3U0NmcVhndDB5ZTIycENrb2M3UzVxbUljaWFMVU9ac3FU?=
 =?utf-8?B?bGtDbklLNk9VcklEYXY2TDBJS3NSWFBFWk1wYzlmUTNuc3lLQnV0ZlFlRm9P?=
 =?utf-8?B?UkpLVWJsaW1TNVY5cmVpTjN1L2x3eDdlWWRkSGhCT2VMaHprTUxUODFZVCto?=
 =?utf-8?B?Tm1LeFNFMWNQUnJxSkszcG9yVWtCL2RIalZJQlZWNU9ybytqbnA5SDJsU3FJ?=
 =?utf-8?B?WHI0QXFUVmJKV0hLaHZNMW1mRHQwR2lGYWxyWjV5RXV5Mm5Kc1lXVUNmM1Vw?=
 =?utf-8?B?dWJtYUkyNVpkK0E3NjFEM3RjZU91NW9ORU00RUxOV2RYQnlGT3FEQThLSGFs?=
 =?utf-8?B?eWJaOUZDMTBFWXpUbzJIMy80eFZuS0RRM21GZnpKdDdHcHZBeTBNYUxsU1o5?=
 =?utf-8?B?Zk95TCs1NXJxeE0zNkZSZ2FpWFZDdkw5d0VTSzlRMEFLOFBWVzhXWGwzT0NQ?=
 =?utf-8?B?VWtVMGRjcVdCYlZnSmVTbmU4aWtvQSs3MytLUndLWmFNY3l5dmFjWnk0aTdz?=
 =?utf-8?B?WDlFU2VOd3pzNnFCY2xLL1NmQUlEbHpFS3hVSUVPaWpLRG1LQk4yNklKeC9x?=
 =?utf-8?B?emFrbUpHUkl1ZTk0NVQzaXE1S3JGeTlNVnlPa0srNlhPUW1NVTMzclduUmJS?=
 =?utf-8?B?TkFTV3paa3ExTEpYcXBxb1VXSVRkY2xyMXkvQT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 16:28:57.9208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c43f1539-514e-401d-5c04-08dded627ad5
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8637

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


