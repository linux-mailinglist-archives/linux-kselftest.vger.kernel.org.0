Return-Path: <linux-kselftest+bounces-29288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DADCA663A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591A4179E7F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 00:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D501A28D;
	Tue, 18 Mar 2025 00:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ccZQue5A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357481119A;
	Tue, 18 Mar 2025 00:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257671; cv=fail; b=YhhPhzxLv24mHL8qQO3beMuHKf43q2FpMU23moo0cGBk8+WXqEkwhJsz8ShXuL6oEBjStTT2DjY5IqBbXFEqO8fxWcVygQsLOYwxQbSjEF57f7FHt0Ns8FiiceH9CcJkY1X6b60NyS4G3ReORZWXvXeGtSMHj2aoPDUUg5vaK90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257671; c=relaxed/simple;
	bh=I/5cWdvN6eEd3lEuewEFqflav7KgszSP7X6bWuPgBpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEX/LfF2jVqlfhaQ/SFpOHZfG2cn8NXqJGOfWyEnWQREWj8IY0df/3DotEZe5Pj4Fto3tsP3UyuigFFoKg7oBpRLgsqJuOUkLiKKfZgWL1K4CTzMvdKQKbgfKzQ7lDWD5pbCrplBns3PfYtj2lBa6Sn11OERJtB+kp4/2AYbHUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ccZQue5A; arc=fail smtp.client-ip=40.107.22.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYXETSbiZ6G2JrgClBZZoJd2203r/1ck0EimE4pQsJIWZwJwW7snHhwrMqQ2YUe7ut8wqNjAcLYIFDWOBYjIG0hGx85xo+RduNdSZnG5S/msgigHVePKNPpRF3UrLMXOxLosJXWmDBx9FuXb8HWAdXLJKkPDpXqWxJxG8OdplJkcdWtgq9/hrzMFgvt7uoawCI+XbYzBxfdPb2U6K2xEBxFKJVmHtSvIkP9k3fB6fG+KRETghRwuQp8vvQ8KCwVsxgU3CcAYL1iKAuDRm40OXXyz3lRDLMAbA3fj/nP8/uPiRiNhtxLAmn5+s49ee7Faxbgm/Ex4QtrdVZKy8kUtfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSmzk3vr/+lmZuoLWRV8sXEH2FYqAyZicyWsAkprjgs=;
 b=YV4QmFyWgAdSAqadQazctNz9N2aLE7q/jMh6dBOUImrFtYPxjEkuIXEIbRJlhEVxsowxoWoaiINQSN4ICNT8VRMgQIjoCzNf7ZgYyxBMdehTXL5Z0Duvji6LKffTbCxo8VluWpO7fBuE3kt1xdD7FdCpDKpp2TDVtzLgCRL3ux4TqvyvKRq9BHkxD3809yqXgskgMwyuDlCHMeS4+CGhvHFFxgR++iwycwfA31PsFJV+Q49W2RfLm8dQE5+eAXEjadCAaBqrkM25LVkODuENR55/YssPTRzanPh8Ccqy236htvs39hf0NTv4fGfGBLLSFHiBhSafJCi0o4e2V8gX2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSmzk3vr/+lmZuoLWRV8sXEH2FYqAyZicyWsAkprjgs=;
 b=ccZQue5AcKWRo8ROl4RzoDOGBiKrDNdn/4rkgiKo9YlBnsDER9jHNey1pmrLy9+SWAes6+ksM5TOa3tB3/nwUOlTza+uGUjTUwFjBurisFnPeDlBzSQx+P+uzV7Uy1KBVUSk5Vz8em+wNz7wCpeKVckZ3DHNUbrroNlvsGaJA76GnlDq0Xvr33ZZzO2XcJ2GQDHzP2O+yw22u/YIf1FnbKGXBpGik4R2Uz4hucz7NxSK6DHCn795dS/yWOYco4VGhJVen0HaiqtZtY5rO5cb5X/u/62LJG89tTRGcATwsfcX1p/y9f993XhkTh7eWsqDX6z02vBHOOm5uPwnMNFqew==
Received: from AM0PR04CA0069.eurprd04.prod.outlook.com (2603:10a6:208:1::46)
 by PR3PR07MB6633.eurprd07.prod.outlook.com (2603:10a6:102:6c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 00:27:46 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:208:1:cafe::7) by AM0PR04CA0069.outlook.office365.com
 (2603:10a6:208:1::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Tue,
 18 Mar 2025 00:27:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 00:27:45 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 52I0RNBh024935;
	Tue, 18 Mar 2025 00:27:53 GMT
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
Subject: [PATCH v2 net-next 01/15] tcp: fast path functions later
Date: Tue, 18 Mar 2025 01:26:56 +0100
Message-Id: <20250318002710.29483-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B7:EE_|PR3PR07MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: 47772a8a-f667-448c-fec4-08dd65b3b494
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?V3VjeFVRZGo0bWJ5d3Nxei9hTGZ1VmtFZjA1ZWtEdE4vRUlWU2dWQ2lNSUc3?=
 =?utf-8?B?ekxDdEQ1ZEJCR2ovVlRBZE9sVXNJd042eWJ3ZmNaNEZmS0lEYURHa1VtZnhz?=
 =?utf-8?B?aWxjbGhOZnhrbzZZWGFxRGdVc0NTMXN6enhYV1BldHlIUlNOTUhuNTcvZTRW?=
 =?utf-8?B?RWdZNnpKS2RwNGtPcFZIeXp5WHdTSXFXWWZnMnNCclhwMDVmZjg3ZStWcjRQ?=
 =?utf-8?B?alJycTVWZ1F5SnQ5YlRlcE5ERmJydGIyWWlXRnhham9UcDdOZzZSUkMvOGhz?=
 =?utf-8?B?Y0puZVRnRjR5Q3E5QlpIYTVQOExYWHlyM1AwUExFNzZ2SnVKbnU2TENiNzhi?=
 =?utf-8?B?UWVndUJrbWd3QUI2T3g4QUxnN3JLQ0JreVBmTzRrRnVTazhzbGtkWGtKMmJQ?=
 =?utf-8?B?L0dsMVlQd0NPZC9JeS9ISjcwM2paM0Z3U3FUY1ZTRXZIVFRhekJGR1htdTN5?=
 =?utf-8?B?L0ptcG9UcFIxbmhSVmliQk5WblRxSno3MmhPZVdaSmR1TFNIemhnNVhadUll?=
 =?utf-8?B?Tm84S2xiT2UzM1pGYmNSUmlFclg4VFMzTFJYdHYzV1diekNRWVBtWW9HUmpO?=
 =?utf-8?B?SUh3SFV5bnltZWtYZGY3R2JEUFkyZk1IS3ZtckF5OFZjRFpBSnprWVM1SWFn?=
 =?utf-8?B?RzU4SkZZOHlRamlJRzhtV0VZZStsRG9XV0xqSVJybXpOQkE0cXRqTHdsSHds?=
 =?utf-8?B?ZVBLV0JXVTlCbnpMWkNuOUNZNnBhdXdRN2pmRDFCbmtCdjZCOUZYemdSbnJK?=
 =?utf-8?B?djdQRlIwMzFJVDBLS3F0OUlkNkpyUWlaTHhVQ0N1SytYaHNZbUZBYkk4b3VG?=
 =?utf-8?B?YUhNRW9yMDNkNG4waFdRUnpQOHQvcFMwQ2JNOHJwR25tUk9mc1kvS05wYWlo?=
 =?utf-8?B?NmlYS25GRjhaU2NCRG1GTUNPOWZZTXF5NVhMN2RlYW1seE5oNjh1TjhTekxW?=
 =?utf-8?B?VFhMS1AwZlpTK2p0REN2aDdnT2tJRWhZZGpzZDFhaGZNOWdYZ29lR01QMHRx?=
 =?utf-8?B?bWNWalhTYzViRTZCZTE5MS9EamIyNVN4SjRaVHl0T1htMDVjWHY5Z1U2Skpr?=
 =?utf-8?B?c1QwaE1jejk4NDNZQUlQRFhVekRIbE1vdEVlbXIwa0h5aFJONTc2dWo5NFRr?=
 =?utf-8?B?SG42bkNOK0YwVzF3R2svVzRQUU9VbWZ2Q1hOT3Izbk1zbTQ2Tk13SmhZaHFH?=
 =?utf-8?B?SVVacitHMVU0Z1orTmpDRGZJbzVhV3NLd0xRN3NpMDQ5YzQ1NGhlYmdRNksw?=
 =?utf-8?B?ZG9BWmhNWStQNGI4eGkyZGNJVlV1MWhsM0FEUkJhdW93TWZxZDdvUytkRmho?=
 =?utf-8?B?cGdJakEvd3dudWQyTllzc0xObW9GUHFqbVI3Vk4va3FyR0dGYjdlUWtPcDRo?=
 =?utf-8?B?ek1LK0VwcFQydSsrUXBzeUtadFcxOEphazh6dUpiYkUyZU0xaVltVS84QnNa?=
 =?utf-8?B?ZFhNVG4xby9xUDc1SjV4TTNRS3QwcDNNbVRNTk1jME9UblJOdFQ4T0g1ekF6?=
 =?utf-8?B?YnlxcC9LeEE5SG5Bd1ZXcXdQZlBSMUJ0eHVMeXpmRlF0bmRUcTFsUTA5YS9M?=
 =?utf-8?B?bXZ4WWkvZHFPdWZhQVRUSEVhc1dyTElJMGcyYjNMOG85Y3hQK1VTQnVuVDFX?=
 =?utf-8?B?d20vL1dEWUFQYjFhZ295NUVxUVdqMzNGTHBnYjI3OERncHl2YUZGZ2NETm5w?=
 =?utf-8?B?K0Q4VGZXRnVROXYyR00yd0llNlg0NDZiZTE1NWI3ZVZPMWRqVnZEMHdJMWRS?=
 =?utf-8?B?bzVBYnUzeUIvak5pMmZIUUxMNXNYTGRucGtGdUVmeDFWemVZT0t6OGdWSlEw?=
 =?utf-8?B?dFMvT21JdDN4NXNTOU8yV3ZDSGFUeFEvTFFxcFlwQUhDcUdCQlRCNDU4YXdY?=
 =?utf-8?B?WnJGRXR2SUdjV2FkOFFoVUZxa09QVUd2R0VFQnJoaHcxVkJHSFBFRi8rVVZX?=
 =?utf-8?B?UkhreUQ1cTY5RElTMXJiN1lBWGt2d21DVzVib0ZwWFZXb29tMko0Mm9zOTRa?=
 =?utf-8?Q?wmUijG6zrqSmqTiiUtNk3KthbgGxO4=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 00:27:45.8911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47772a8a-f667-448c-fec4-08dd65b3b494
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6633

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
index d08fbf90495d..830db65e5487 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -811,33 +811,6 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
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
@@ -1797,6 +1770,33 @@ static inline bool tcp_paws_reject(const struct tcp_options_received *rx_opt,
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


