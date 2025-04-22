Return-Path: <linux-kselftest+bounces-31314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF44AA97142
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE5B440342
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B08290BAA;
	Tue, 22 Apr 2025 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="YXy8l3I4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E13019F42F;
	Tue, 22 Apr 2025 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336316; cv=fail; b=H6gn44xanJYVRKOaNwS5NRZYH/Q5EL+w2TxoCh8RaEbUf4p+gxsEikw/i0xKV1gyfWYxmzxQ8BqjKjenD4Ujw4NtHFQC+NlgOVRfheLF7Y0IgdSHRUFfpUtfvWJwMU2y1TXIwhtTwggNvOvLcmhRGB9NGejhjsfj3s5srnl67o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336316; c=relaxed/simple;
	bh=bz0uIeWpSGSuIQvh66yhCx2wBEBZLK1Uhj3GCh55+fI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hm5j0ejh88Aj2Oh5RYkWPg35pkRNF2wk+LX3SoKHaAkls/KRrLlQ0pBi4W6qwt+wJ2YwjdjNd/PFxK0L4imJ4ulcQ8RHje9WGcISHqLBKrF8upLEOkjg4ePBx4jKAxRxOcJYZBv0mMN6Hlpgc3IFk0o76ZScZh3R4G0Ui5BFOvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=YXy8l3I4; arc=fail smtp.client-ip=40.107.159.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFvqmhGWS/+4S/AmFHZuuF4bDHTmNobyK5AsbH2bsjh7SzXaTAJ8fGvvMkTulOA17ZMFPwdzAcBiN9uGJ+E//TiOHqupXoWboAUP8fsy28AWqjidh9X0QUlS9UjQxOEy0qiP8LtjxHUNuuvUZN6yUBbKSDVCh2fU9lAoAltUZXmniAx2vo5BSyUMqBrFzdXKrOncCLl/mYJhig8zSvfVU6tfRMZFdsrcW3flRPLOEUjqDiDIPYVsA1VMZkt0cf7g63IaeDzil7+1+VPDx27z7R+yU38K7IkqhhbZqFk3LmI0xYloIWKtFUc0xJsUV2dQ5TOTVE/Fx3Q3xSIOeyh/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xY4cSgz9DD+izQ5CHXWWIiWN/HVvG4kiITK+k1h7IUY=;
 b=erN2MVfijcEYCEiccRpCgY2kJeLDH0GT8TzUdxQcU0bAaskyg4qObyEcMq1VfNhrTwiKag6vFuDfYySPUAA2PD/lXzOZhH0/YysaDW329vTkeqQXRO6Ui6CMEutDEcDLJva2f0jpCmEl8OlieIk8mrh/poFK2Xu4YjF0B8MFYiHnWOat98isCq4dDflWmQMhvcIeMpZw1iNYAR4lRdim2Q+wttqFzbUIfOkRAcklocSnTA+H2Qu1HoF6j+EascgxMUT2AjnVX9FBHjq9WPFh1oFw2bw7GVZiSKfTfrtTrxSg31WGffOuOKN1EUFlQtRyFmcGEh5CLacgC2NEkSCtKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.29) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xY4cSgz9DD+izQ5CHXWWIiWN/HVvG4kiITK+k1h7IUY=;
 b=YXy8l3I4KRDxJqbvV3aKj11K2VRtiZ8Q+7/ZpThIBuGWgJ0TKdlYWwt3GTs8rDZHGQ1ABcrGWYFkTp/FJ4UJIF8JXLyjJn9ZE6V5SUqkvlQuyorrUKCiVa91ik5r3ISTpQVrUL29H8WRDuMncLEgzfPbMpm5zX79yrXwxKKO+CcqbVzmP7ate225exJIo0SrA0ciwXOBNvrAGqRIlru9hrBhi3DIbtNSDIBZs5dHEFGto2sV3fjWsaO6kS6CQ0N9LiaFSSA3YvEzXPI+W6RB+jSxigSgLfGTqEozNZv8tbGzmHm65rvoEEO+zSb6PI4igvtadRERzQJG6/Fn4V9AwQ==
Received: from AS4PR09CA0024.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::12)
 by AS8PR07MB7606.eurprd07.prod.outlook.com (2603:10a6:20b:28a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Tue, 22 Apr
 2025 15:38:31 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::74) by AS4PR09CA0024.outlook.office365.com
 (2603:10a6:20b:5d4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 22 Apr 2025 15:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.29) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 22 Apr 2025 15:38:30 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 5E3E120A1C;
	Tue, 22 Apr 2025 18:38:29 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
	dsahern@kernel.org,
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
Subject: [PATCH v5 net-next 06/15] tcp: accecn: AccECN needs to know delivered bytes
Date: Tue, 22 Apr 2025 17:35:53 +0200
Message-Id: <20250422153602.54787-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C717:EE_|AS8PR07MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: e83ba895-ba85-4ef5-e3c9-08dd81b3bbf9
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bVpkeGZBOEwvb2VHSy9ZZDFYZFB5OTk5a2YzNmJjOEV6Q0k2ODVjMm80UlR6?=
 =?utf-8?B?QWRCcHBxWGQ3bnZvUm9NV1N3eG1VZGhVNGN1cXZGVm1hUGJuQS9mM0JId3VP?=
 =?utf-8?B?NlFEWVFrRDZjeS9UVC9MVHR0RjJMYVZtNGlHbWZNaDQ2ZDZ5M25kSEpXSUFv?=
 =?utf-8?B?a1o1VWdISldCZHMwM0JheVgyM2Y3TG9wWXJyM3pRWklxcVhZSU5rcGRTTWps?=
 =?utf-8?B?Y2lTRjVtV1lEVGRLNmFpSEhISmZEeDNoa0hXQ21La3pHdHJGOHpMRkxXVlZH?=
 =?utf-8?B?RjNvTmF5eE9qVFZzVHJBd3krTFJEZ3p2bGlIZTBxS0hScDJNaWRKTUlQU0Jk?=
 =?utf-8?B?WVh0TUpnMzBpS0ZwZ1VBMlVQSXZvbXNmU3gweS90aC9RR2ExMmowTnVxZktM?=
 =?utf-8?B?WDgzczBhTUVOSFRwT25GdHphVjZzbkhZdStoUmdiT29aNlF4bTh2VUJGMjY1?=
 =?utf-8?B?dXhvVTFVbUVvOWRxYjdQNndjTk1LMUIyWVFQcDF3cnFUYXU2QVpzUzdEdVox?=
 =?utf-8?B?NW5VOTZUMG1qc2VIWXBHb0ZrM0p2dDYwTTJXMlVycmZNdytxa05DeEE5QzJs?=
 =?utf-8?B?dEYyZWxOZnF5eC93WWJpVHlVNFhSSVVjNTNHUTM4RFhiMFZpQkxDdDBmMm11?=
 =?utf-8?B?Ty81eExxbVluajZJam0zdVc1MUFpU0pUenRBa042N3hJTzF1Smo5ejJDNXZ1?=
 =?utf-8?B?Z25pYmd4Z2xRMXhoUWkzdGJxMnlXOUVJWUNwaXd2bXpJZmpZNlgzSlJ1NHFL?=
 =?utf-8?B?MzFOY2NiSThEejR0R1VyOHdtM2Z0Und4RFByZEFxWGtWVzZYZEVMYWFZSCtK?=
 =?utf-8?B?OUZ3YUdtMEtqdWtiZ2tBQ2k5VDhpakdZb0thWG9hem9IdWhmZ0RvV3hUL0px?=
 =?utf-8?B?c2pIRk5nZHgyeGVlMWFwcEEwM3pXbnpzOXB6VDRmSThYTHlSdHN2cHB2MEVa?=
 =?utf-8?B?S1pqWWgrUU9uUlBIaHdUL2VWME9HeXdKMEdVYjJrZUcwMXVqYndncEVYRldj?=
 =?utf-8?B?U3QwdU1BTTFYL3l6bHZvWEk5eVd2VzROblR1VDBja3F0QVJybnd1ZzJISkZi?=
 =?utf-8?B?TG5sYWRtM1k0U1ZEUXJTSXJwaWd6eE44dXRMN2RVYTZ5TGVGQm9kVjU5WGt2?=
 =?utf-8?B?aHBLNnBLZC8vU1VKbUVaWmZLNXZKcmF0VkV6eWRWM0c4enRzU3BqMUpVRzFX?=
 =?utf-8?B?NnVYemg4c1JaT0p6NDdURjdWZkZiUWFGeFJ0TnpYRHVqbU1xT1l0em9BazRR?=
 =?utf-8?B?RWNSZnFUa2NzS01JeEk5MWhiZmRHc2lENWR1T1pRYU13N2Ztd3huMDRlMGZs?=
 =?utf-8?B?ZlhlN0NYODJvYXRKalZacC9TNFRZMG9UdW1QSmpNQ3pubjd5YTJyNnZRc1BB?=
 =?utf-8?B?b05aR0t2T0ZLT2VCTEx1cFNhTVJDVDh1eVU3TkFzRFEwcHJ4WkhpN1VMVDJ3?=
 =?utf-8?B?WU9obEJGY0RVdTJBUHpHTFE2SEtOR20vdkZ3ZDh0ejlHWUkyZjVTZGFTYVVm?=
 =?utf-8?B?U3pWUStjTUxseFd4VGswN09seVlPK3ZzYllPSnF6SC9nRzZxdWo0Z09XOHR6?=
 =?utf-8?B?K3FFbTdRRitZcHNFTlFRdkVFakl5RERLejZMTFVtcW9GUzIvTmNUV1FmS1dx?=
 =?utf-8?B?cENnYk9nckJuNUMzVGFqaXJjbDBDREtHd3ZaQW1YUkgydlkySGw4SEVMVmtz?=
 =?utf-8?B?cnhoY3FsaHN6ck9YMDlsak54LzBsdElLRTdQbnNUZU4xRUxPZ0Z1cmNpS0ZK?=
 =?utf-8?B?TkZUbHJhMHMzSHliaVcybzFaUS9GLzRWOVZQU2xMM01HSWI3b0dZK3dEK1NM?=
 =?utf-8?B?U0dNMWdEUGpxaTZNZ3doRm8rM21IZm1TU3M1TXJPRnV5czN6cjVJdm05akcy?=
 =?utf-8?B?Sk5wdENyOXFGWTZvdzFDOWZzV2Y2RXhXcFRPQUZXY0NvbnJaWGVubUFET0dK?=
 =?utf-8?B?blZtR1ZGTHhiank2RGxEY1lUcXUyK05FTUtHK0laR3FHRnczajgyQXFOQnVW?=
 =?utf-8?B?eS9TRW5nUzNBdXJ4bHZDOE5zQzdRVnFSOVR2dU5haHovT1R6RDhUaVFPRUlM?=
 =?utf-8?B?TmxJallhZkJFYkhRZWkvRHJIUmxrd1BWMzI3UT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 15:38:30.8542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e83ba895-ba85-4ef5-e3c9-08dd81b3bbf9
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7606

From: Ilpo Järvinen <ij@kernel.org>

AccECN byte counter estimation requires delivered bytes
which can be calculated while processing SACK blocks and
cumulative ACK. The delivered bytes will be used to estimate
the byte counters between AccECN option (on ACKs w/o the
option).

Non-SACK calculation is quite annoying, inaccurate, and
likely bogus.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c017e342f092..5bd7fc9bcf66 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1170,6 +1170,7 @@ struct tcp_sacktag_state {
 	u64	last_sackt;
 	u32	reord;
 	u32	sack_delivered;
+	u32	delivered_bytes;
 	int	flag;
 	unsigned int mss_now;
 	struct rate_sample *rate;
@@ -1531,7 +1532,7 @@ static int tcp_match_skb_to_sack(struct sock *sk, struct sk_buff *skb,
 static u8 tcp_sacktag_one(struct sock *sk,
 			  struct tcp_sacktag_state *state, u8 sacked,
 			  u32 start_seq, u32 end_seq,
-			  int dup_sack, int pcount,
+			  int dup_sack, int pcount, u32 plen,
 			  u64 xmit_time)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -1591,6 +1592,7 @@ static u8 tcp_sacktag_one(struct sock *sk,
 		tp->sacked_out += pcount;
 		/* Out-of-order packets delivered */
 		state->sack_delivered += pcount;
+		state->delivered_bytes += plen;
 
 		/* Lost marker hint past SACKed? Tweak RFC3517 cnt */
 		if (tp->lost_skb_hint &&
@@ -1632,7 +1634,7 @@ static bool tcp_shifted_skb(struct sock *sk, struct sk_buff *prev,
 	 * tcp_highest_sack_seq() when skb is highest_sack.
 	 */
 	tcp_sacktag_one(sk, state, TCP_SKB_CB(skb)->sacked,
-			start_seq, end_seq, dup_sack, pcount,
+			start_seq, end_seq, dup_sack, pcount, skb->len,
 			tcp_skb_timestamp_us(skb));
 	tcp_rate_skb_delivered(sk, skb, state->rate);
 
@@ -1924,6 +1926,7 @@ static struct sk_buff *tcp_sacktag_walk(struct sk_buff *skb, struct sock *sk,
 						TCP_SKB_CB(skb)->end_seq,
 						dup_sack,
 						tcp_skb_pcount(skb),
+						skb->len,
 						tcp_skb_timestamp_us(skb));
 			tcp_rate_skb_delivered(sk, skb, state->rate);
 			if (TCP_SKB_CB(skb)->sacked & TCPCB_SACKED_ACKED)
@@ -3540,6 +3543,8 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 
 		if (sacked & TCPCB_SACKED_ACKED) {
 			tp->sacked_out -= acked_pcount;
+			/* snd_una delta covers these skbs */
+			sack->delivered_bytes -= skb->len;
 		} else if (tcp_is_sack(tp)) {
 			tcp_count_delivered(tp, acked_pcount, ece_ack);
 			if (!tcp_skb_spurious_retrans(tp, skb))
@@ -3643,6 +3648,10 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 			delta = prior_sacked - tp->sacked_out;
 			tp->lost_cnt_hint -= min(tp->lost_cnt_hint, delta);
 		}
+
+		sack->delivered_bytes = (skb ?
+					 TCP_SKB_CB(skb)->seq : tp->snd_una) -
+					 prior_snd_una;
 	} else if (skb && rtt_update && sack_rtt_us >= 0 &&
 		   sack_rtt_us > tcp_stamp_us_delta(tp->tcp_mstamp,
 						    tcp_skb_timestamp_us(skb))) {
@@ -4097,6 +4106,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	sack_state.first_sackt = 0;
 	sack_state.rate = &rs;
 	sack_state.sack_delivered = 0;
+	sack_state.delivered_bytes = 0;
 
 	/* We very likely will need to access rtx queue. */
 	prefetch(sk->tcp_rtx_queue.rb_node);
-- 
2.34.1


