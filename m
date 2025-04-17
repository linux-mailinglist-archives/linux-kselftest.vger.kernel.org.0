Return-Path: <linux-kselftest+bounces-31087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E65A92D7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 01:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385E74A0E04
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 23:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFF821C19D;
	Thu, 17 Apr 2025 23:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="bUp4fow8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012044.outbound.protection.outlook.com [52.101.71.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC5421B9CE;
	Thu, 17 Apr 2025 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930853; cv=fail; b=ZRej638TIo1EGN6PUafO6EpKTL1SPwQFoGbZT4GjA+NUMSD4zXvHcT1PSUrFQeaBROFN5KkOnVVSxFBj9txNIpYNTfDrpAWyUIruRIgI4GtRQ5LwQkP2aWU+92b3bhnCOfruAopTuVtoouNKmI79dKP06V3VQXmbhRh89Enjmt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930853; c=relaxed/simple;
	bh=jzGjlVHTjyWEGx0OxJrvgDWNiNQ6gwMZm/yT5kX2loA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDzkH/4izGyAOJ6O2tBj+IkW4kWCtza9zRMfm1iP1c29tqfv4pJES29qo2DLiPQWFBWNR+izJwNQFeVPx8ND038xfsA68kdZ/iUWJOmq08blzyYpkrxDZrXUl9pgKcj1NY/ocs/VGsanMnHThvjdDVRrAYo83VJoMxEJru9OTIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=bUp4fow8; arc=fail smtp.client-ip=52.101.71.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vT4Z9V0ob5PlDEuSArEpaU418JEmHyq48R6F4rmGV9v5bs86gI5FkMj+kBDKESfHl6KDc/i9WvmrAIOLep0/G+4WvNIbsjYTfgdX8VeOy4AmHkRhoYxPQJH7tnmqw86ocHXJ/3LlpO4kNvqoFT/Eyd1DyUXbFryGirBYzFtPvPm2TelmSPVCSAREkaaDcNqqyINpIHj9CEDozF9H6lPWg3Y1lcLBrrTp2EGmD4glEHRLA6IvJiHqQUzel5VsYXHGPVIG61Oez4aFlAI6mshUsYtckWQJV5iCqSl6zYwHsESU/Q2uZByefqBnK1paWCgIFz4a8L8FrDUm51XhzvasOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aP/7Psq07ihqriJaEJ63jaVwaWZLAB4da/DunpSK6As=;
 b=gznMHl+J0Js8LHhovOuTVGhmklrF7Tq1c5NZ6i21UDQ+FvvTMSH33xgGgHQIG6JTL7mae8RBpxwXh1hLxAYvQgTVHN+3RT5eAWkbV/EaqnXkrLoiWJ//WbRBTqRgqElOrSzjaD38wGhjCQC1LNAT4R6vVJ1mpL398zUWp/Dsi3mgyAWOwtXAAn6+Ja3W6tsQ9SYitUf3HB8bZ9E05HWg8/FZDv5GaRKGtgPOscHzJasli4dAZtFMH/ib3pPx6zgFBXLw1JXETriGzDDcBSuivUpQPWDIjgUFgRBY+W87Tyg/jiYniDtEo4YM9xFdvw8XfCC2NwbAZCZfyPYFYuR5vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aP/7Psq07ihqriJaEJ63jaVwaWZLAB4da/DunpSK6As=;
 b=bUp4fow87yg+W9Wihf86bUKJErHaYmD9oMPgHB7Li/iCBjMUI7KfFsebSvMQulgg4gFmPDbuUn2Vu0KAq8HNNGmSr3we/qW1HWs0305xik7eqWSjbpifQsvP2YeVYHGTyVdwsj0BS7gk4nCunMvc8+G5wiHhkaGfncU0rEcE0mnEy4C4o3sjaP5g+9yrhrnoL74WMon6/3LIIEg0mBcnHpYPxHtzccwgqk7FpotS3zh8keybC0G1v7E+AVIA17LXHR7odVIa+jMePpLgyrW1sHO43gEHWL9OiyBj/NNYTX0CmWI9q8pxSgtLeo32U0KbYbMPX6yBl2o/EKLuBP0jzA==
Received: from DB8PR04CA0005.eurprd04.prod.outlook.com (2603:10a6:10:110::15)
 by AS8PR07MB9461.eurprd07.prod.outlook.com (2603:10a6:20b:632::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 23:00:47 +0000
Received: from DB5PEPF00014B91.eurprd02.prod.outlook.com
 (2603:10a6:10:110:cafe::12) by DB8PR04CA0005.outlook.office365.com
 (2603:10a6:10:110::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Thu,
 17 Apr 2025 23:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 DB5PEPF00014B91.mail.protection.outlook.com (10.167.8.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Thu, 17 Apr 2025 23:00:46 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 73CE32084C;
	Fri, 18 Apr 2025 02:00:45 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
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
Subject: [PATCH v4 net-next 02/15] tcp: fast path functions later
Date: Fri, 18 Apr 2025 01:00:16 +0200
Message-Id: <20250417230029.21905-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B91:EE_|AS8PR07MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c07be2-160d-41db-ee93-08dd7e03b095
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TStOeElEcmd3YzYvTGJrNnpWakIxaVpzbVlQTURweFpudUFBZXpla05FOGZY?=
 =?utf-8?B?bS9QQllTbVpTczhITzRnWkJnTDZLRmtzcUN4WDJtdllZdnAzaDVNTEhVNDQx?=
 =?utf-8?B?SksrcE0xTWJjb0VISGR5MmhhNVozcy9nQ1FWSkVYWHpuanZwRmtVYmtmanhK?=
 =?utf-8?B?dWltUXhCU05pWjVaM29NQWM4a2poWDZvOWJ4bmVQS2lRZDBEc0tJb09zWVRH?=
 =?utf-8?B?c1htd3FQVHBUVm1sRkZSbC9ESi9GbzNaUU5xb3Z4NTlrOWNCdkI4dkVNc2Fu?=
 =?utf-8?B?eE1xcjZab2pMR1VJSEdhYTNBYW1EMXd6VXhHTUE0QnhlK0tiYVJscTMrN0h6?=
 =?utf-8?B?bExBMWRUcWZJb3QrSUFCRzZsWUpIQkhuQWt2SC9yK0JwUjF6YTdMVFE0cHRn?=
 =?utf-8?B?VGRJcnhNYnRvSDhmdE1BZHRNaU1GbjQyVVZoRk1hc0ZOb3FweWFQRWZiT2hF?=
 =?utf-8?B?NThRLysvR2RJWkQ1aVRkYnZJbHFpMEliWEJUMjBQNUtrSmV3UXBPZCsxektG?=
 =?utf-8?B?N29zNTYwWEQzYmpMQWtXNlg2Mi9iNzRPU092c3lIcXJURnhxUG9ZR1BUenYw?=
 =?utf-8?B?Tkc3bGI0THFTOVE2MUhmZ0dZc0lwTnA2RllNV2xGUUgybVJGU0g0aDh4R1Ru?=
 =?utf-8?B?Z1YvSVF2Rnl6Q2hKRXNIRHdwY1dBdzdoVEpxZzZQbkUwWUNFYkxxMzUzdk5h?=
 =?utf-8?B?c1lIaWhvakVZQUxmYUhQcjNET0tob2poa2RLbGl6QXc1UklrNVBYRlJZbEZE?=
 =?utf-8?B?Z3FqKzgzNml5MVptWm92ZUsvWlNxYjk3dDV1eUdHZlJ5Q25Ga2xqSEZ1RUJN?=
 =?utf-8?B?SnBhM1J2ckRkZlpEUkdLQ1E0VTdBWGtmQUxVV3JHS09VMENoUXBVSHRTM0Iw?=
 =?utf-8?B?V0p5Rm9OdFF3UUNoSVVhTlhzUmR4TDFadTdyL05WNFlGaEwxS3gzK2hkVkhI?=
 =?utf-8?B?SzU0Vm03cnBzZWhkZWI4L0oramlBa0NLby9sTHdoRmMweHZWVDBwV1JjR0F3?=
 =?utf-8?B?VmV2OWZRSXpUVFBYQWd4akxwV0s4SmpmcWhIVGpLanFhK2wwL0ZPcXozVjRM?=
 =?utf-8?B?L2JIcGtnQm93RHVRQmY4V1c3SVdqeDBKWUlUYlBUNDY3L2M5VDNOZEVwT0Jr?=
 =?utf-8?B?MFo0OXlRanpQak1oQm5aY253ZytQRlpDSUp2OUJVd0ZVeFJFeHQwVWRaR0dM?=
 =?utf-8?B?a3RRYkFRNnpEZU1rZWF4VUVxWWNCQ3h6TXppSHh1d3kybjBpK2t1MGNzb2ZE?=
 =?utf-8?B?aXNDZnBJbDVDRFNWUWRFN3BqTnppYlF4SDBQMVZkU25JYWxZcFRxenMva3R2?=
 =?utf-8?B?bkp1R0M4ZFROSkwzazF3WXBTaTJvOW9sSlZQem9kclVSdU1BbklBSit5SDVp?=
 =?utf-8?B?NlJzdmJod3JHYmJNSDl4bk1oNWxNQ1RxR3JHK0xDWGx0THd1RWtGQnhZaXZT?=
 =?utf-8?B?bkp2djgyTW5Qc3hYb1padXJncHBXbGVRR0VpT1NZTHlhNldiTlpUbk9lTnhG?=
 =?utf-8?B?NUJTMmJYV0lENE5JY0UyTEFxdFhkdExCTzlCcFBrQzFkdWpsL1cxa21pN05M?=
 =?utf-8?B?UTBoWDZEeFJHQnNTOUQvb3Q0KzFhNFVXbFhMNzJGQUN2d1J4TFZQQXJMVk85?=
 =?utf-8?B?VThGUm0xbkRHMVJ4UXgzT2tmL2IyRTJ2REovRSs3anBMeFFUS05JcG9kOWQ2?=
 =?utf-8?B?N3k3R21TT1VaQlVxQ1lBZnB3SGZqdlozdmd5VDlmN1V4LzRXQUxnSEVuZ3BM?=
 =?utf-8?B?TGFMWU9mN2x0VjlENmt2dm1JdHVUOGoxc0JUYWVuUUZ1RVRIOTREK3hBWERt?=
 =?utf-8?B?WGkxUHJVOXpneVNrQXBuMy85L3BtUVQyTGN6ZWhUY2l4RTdMZFVPL3AvV3h3?=
 =?utf-8?B?R3VuL01HblZ3U05zSEJSNHZuZFFxU1NHVzBkUWFVR3FsZENrbWxnazJ5YkVO?=
 =?utf-8?B?cmtNZU9nSzI5Z1EyM21rL1hGTHlFMFh5ZisyMmlucnVPdFdlU0Zzc3pSaE5w?=
 =?utf-8?B?M1JEbEtSb3VLTFF6NzZZWG9pcGhXY082OXVuRG9yOE1tZzVmY3Z3VTVjUGQz?=
 =?utf-8?B?dWd5aTlsTHpBVit4Z0tCTno3ZHoxUTJYMGIzQT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:00:46.8604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c07be2-160d-41db-ee93-08dd7e03b095
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9461

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


