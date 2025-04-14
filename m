Return-Path: <linux-kselftest+bounces-30832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D10A89745
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 10:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2014409CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 08:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02682798EF;
	Tue, 15 Apr 2025 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="eDkOcew+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BCC27587B;
	Tue, 15 Apr 2025 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707487; cv=fail; b=dpOKgoaYB+AAFte/qtJn0IuaJc3NjfLG7vK0Xjy68e+0ZwuOQg211ksAhPJ0sjgxuZJoqD5hYCFjn6afMPSD14joEpAZzofVSXK6Ip5MWoq0vZnv21SysbXsOsWSA7brskjUJuP2VEu1X3VxL9QBcX/HP5owW1wHOdT8ahNEbLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707487; c=relaxed/simple;
	bh=bz0uIeWpSGSuIQvh66yhCx2wBEBZLK1Uhj3GCh55+fI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iyIXS/k9pXVX8/OkgGbgK2NKSXkqswvtZcpCuESyWoIGiJESaL7cYWAPA1zOWbOo//Q4bEadnReNK4dA9N6+eYyVOagrTykQ8PVswix1PuG01PAnHkuVzlCXI6MuPLlieR2CEUKXuhgt17rWsy/k5vH3gluufsaCgVpLubyB9Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=eDkOcew+; arc=fail smtp.client-ip=40.107.21.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snYQ7OhUk6CP8JtjDrgt0Q2iltJgMH1DOvixkNXOAC25G8CBecbD4GMWl+Y0gu+fW5yKEYqQ1IfeSqs0RxeXp6Tb789jWhiUze1ARhri3mq8KKf/o6t4oy6GsHr7AUUQ0UOVwaEBR0NQcj4yfua+RJhuLnqwi+Z39LFV8DQ4Bdnx/twvgy8wMPkOXYe/o4SGFzNymQtCMWoUDR9y8HiH8bhn1jm7G9n7JekfcynIgZkUmmK4NjP7tvvPdhw/wwjZqQdCwvCfYDqJ2doqUK16Fyr0QCQfGof3J8ZYu2b+XluQuwayWNR9Y62jyl4VKm7GjeDvxDqH1eYvBsaMRjeI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xY4cSgz9DD+izQ5CHXWWIiWN/HVvG4kiITK+k1h7IUY=;
 b=xuMGm8ai44dROUnzrS8TB8lZTZXY/P8POgG07NDi8i/vx35gS3jQKAHol3AVDrhO/A8MSbpFzA29/kM9Guc9LUMWGsWlfcqFenZ7/TvJNozPikiL+kA8wLscpW77NeVLpRQepTsDVglWQ6TfnarUuVt6BAwfuqrEJq19N5N24NCWGFzzlBB7NH/ENmL1HIUx219LFZaKt7kVADJohqsP0PUq0tdvsvDPGXU7hcHnyIGRXUSsb18xpkJfHrThgZwvT5rbMQEAxch0zdifd/OaqMibHVJJF+xLsWrqOad3MgeiVmszFeCJjupFi5iDP+pVxD/Txurv+tDwWEiUCElTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xY4cSgz9DD+izQ5CHXWWIiWN/HVvG4kiITK+k1h7IUY=;
 b=eDkOcew+pYHn1BmRrRaklTFT8XIcB04HH1XbgYRjaT25fklfAdYGxfRyZqnxaTLF1TSSggT2+fA4eMZkzGpcj9+cYvnYvj9KhdAcE7azVqG1cgAwydoQDv4wDrJyiGNWf51cAPedFojjeDiLnZTy/3V+K3yxegim9SrgsMFs9rZertzNf2f68H9E3u6bms9oEJ6NeY++cYHYActJ4QWR4z6OMu+ivVWGwK5NNjI2vJkuRT5kVEfpIgsN7BbPCcKwOPbNX8gkk+ulfIqXYAph2970nY7NfFpdxeaMDQa6ISzIWeFal197OgpgO1adzepKW6TJodcQU/atSMPNpcTOwg==
Received: from AS4P189CA0051.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::16)
 by DU0PR07MB8907.eurprd07.prod.outlook.com (2603:10a6:10:323::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 08:58:00 +0000
Received: from AM3PEPF0000A79C.eurprd04.prod.outlook.com
 (2603:10a6:20b:659:cafe::c5) by AS4P189CA0051.outlook.office365.com
 (2603:10a6:20b:659::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Tue,
 15 Apr 2025 08:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AM3PEPF0000A79C.mail.protection.outlook.com (10.167.16.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 15 Apr 2025 08:58:00 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 9844B4EE7A;
	Mon, 14 Apr 2025 16:00:11 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org,
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
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 06/15] tcp: accecn: AccECN needs to know delivered bytes
Date: Mon, 14 Apr 2025 14:59:35 +0200
Message-Id: <20250414125944.97350-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414125944.97350-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414125944.97350-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79C:EE_|DU0PR07MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab65cb8-1e7f-4cee-68f7-08dd7bfb9fe7
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Rm5XRDVaTTlaaUpTdGtXc3B6SXVWVEU4cW8wUkJtcjNlVGpmOHFJbERNOFdm?=
 =?utf-8?B?dS9ZYzZ2OWMvbXhxRjVKVFN1d1hGRWFQZEFsejEwNVI0MEFSa2kwVjJIRTd2?=
 =?utf-8?B?c1JrS0tXWWtyK29DaEtkL3hZZ2RoMFJ0OHlNZFNkZkpsc2MxS2hneFdMS05P?=
 =?utf-8?B?SDZWd1pFcGZQWlRtMThTcUROYlBtQm80Mm9oSXJ0MnNxdXpJM3I2YWs4TXdE?=
 =?utf-8?B?cDZMRDRSd0c5cXhKem0rSVNqbmVzaXJleGc2Z2YvUjVhWC9xV0RUZDNYK2xL?=
 =?utf-8?B?OXRUcWwxKzAwelF2RGgwdTI5MXQyTm10SFp2ZWoyYmViamNMbTlQTVlzRmhN?=
 =?utf-8?B?VzFZTVRqQ3c2Zkw3L3lpQ0ZMaUJ6QkxYR0t0VHZncGI4RGFTZ01md2sxQmhO?=
 =?utf-8?B?MTN4MXhiOHFIeGZxbURsR3k1bVhZR0RiWUtvK00wa202MUJPUEdKYmRpZ25v?=
 =?utf-8?B?bHFpVENQWU02NDNvV1huckxVQ1hsWXFlbkJOMEtqdUF5ZGFUOENydGZJWDM1?=
 =?utf-8?B?VEszWnJ3aDc4Z2lNRHl6SDkyNFJ3TXZjdUp2V2tDZUtqL2F4TXo0di9ZRTk4?=
 =?utf-8?B?cktwcWlrMVdIdmlLL0FmSG5NWTBWbDIzSk1RWlFlYVQxRnlDRHJBWWVyaVFy?=
 =?utf-8?B?VUk2cEFBZFdTb1RHQUUvRm9ITmxMU29TdUVrWGNNNmR1L3RoRHR0K3R4Z0hD?=
 =?utf-8?B?ZVo0bDFYOFQ3VGNWanNqVWVJZ3d0OWRjSStXakZJL3Y2bUwwQVloUm8rYmU4?=
 =?utf-8?B?SUw4c09VbE9LeCtmZHBtUmdaQjBtWUtiZUJwaUZOamVPWTFPd3FUN25RUS95?=
 =?utf-8?B?ZWhEN0RITHZYdk9UMHN0TUJVcTFHeXh0UC8rall1KzZJQ0dWSU83dG1MRGdJ?=
 =?utf-8?B?T3JmR296TnhGa3kyaG5kM2J6QmxqK0ovMXZjcjg1UEhzOTlHcjgxYU96NERD?=
 =?utf-8?B?Zmk1UnJTd3phOGdvSUxxMlJkM1ZMbUQ3WUl4RTR2WlRuS1o5TlBzTFhhdnNj?=
 =?utf-8?B?U0ZFSk04UUJIR0NZSTZnVSt6T2huSGpiZzI3OGY3ZDdrM1VuVUNPWUtiZUZB?=
 =?utf-8?B?U2ZIV3hOdUNqaWw4T2VDNzYxbjRDRVhXS0tBSnFzOXI2NlBSMTlIUUlLS2NG?=
 =?utf-8?B?Zjgyc1h0S1RBSnd1TDZjZGpYVHBBRUcwTDF0c3dDa3BTUzNGbmFaMTdibU1Z?=
 =?utf-8?B?NU1EeEhCand2Ly9DZW5EZEREbkJGQU8wZHQ2dysycFhVUktXb2pPWDllWFhT?=
 =?utf-8?B?N0JzQ01IQ3JQL1UrOXRHdVR6V0NKR0hDQURkYXB3TWhIV3NqYlkxVDF5TVYz?=
 =?utf-8?B?QkxzYVpmcmxpWkFSb0VKK1p1TUNibEhkbFZZbXNiTUtEYnJ4K0ZOL3h6VnpB?=
 =?utf-8?B?QXBCVnhQeUVWeUYxazJhUkcxTkFYUDl6QzQxRjJlWUdlY3JyTEsveWZPdE4r?=
 =?utf-8?B?M2hPTWpVSkJDS1N1UzN2ZlpxOHhVOXhObGVST0NPdlllbkpZeGpFZXluSXUx?=
 =?utf-8?B?cUdjcVFiVSt2T1pzVkl6RGp0SHI1Y1hpajNoTGpYYnNTRnRQQm5uUXhJYzli?=
 =?utf-8?B?WlBZVkhNRjRZUmRYYjJDU2ZvNlRyYnBDNU0wR0l2aUh1MzFDY2dCNGg3REpx?=
 =?utf-8?B?OG13SitjQ3RwVVAzT1FMMmhueTZDSTUxSnlWTHpyb2d5ZnNPK1pNWHFJdFMv?=
 =?utf-8?B?dGNwK0wrZUt5NmhWNVJ3Y2VBczQwcFNSWkVYeW1LQ2wrYmIvclM3cHNKT2Nj?=
 =?utf-8?B?Qkt5UGwrWjZ6RlpYbGFqV1hVRzc1NW14Q1JMQ0RLZ0g1bFZTOTlEc2JsT3A2?=
 =?utf-8?B?SkhuNU94S1pzSTNtaytjbU5MZGtWQnFycXBteDY5VTFRRUNSWWViZDRXSXp0?=
 =?utf-8?B?Z1ViUnBQWWVROUtnTnYvUHJ3Smx5MXFiclFJV0cvNXZEUHd6TWtwYkhpOUUw?=
 =?utf-8?B?ZkRQbmlueVlieGpKLzNHR21jc3pYU1orTDJUdlJ1djBUdk5pY2NLVHQvc2Uz?=
 =?utf-8?B?bmQyYW9FREpyT0ZZbXJYelgxM0taV0dFdXpsSTVZczE2ZnhLSElORnAxTG50?=
 =?utf-8?B?YkVCaXp1UUNuNUdEcEJ4OHhzQ082M05ZVGlJQT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 08:58:00.5291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab65cb8-1e7f-4cee-68f7-08dd7bfb9fe7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8907

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


