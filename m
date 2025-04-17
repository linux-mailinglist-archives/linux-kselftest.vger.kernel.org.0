Return-Path: <linux-kselftest+bounces-31091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C22A92D8B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 01:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77EF31891C66
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 23:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3DB22172B;
	Thu, 17 Apr 2025 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="LYC4/1pV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4484522156D;
	Thu, 17 Apr 2025 23:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930865; cv=fail; b=WATqRkxmjAu9h3c6GqJUL/JH+4pwD6zI/AVJFl+rg8oSxhf49cvRXjmfHFrRrDcZvYGU9umQ+NyOzinNRby4PpaN6bUs2LX5MziyH0pCB371Aep/XTX/Opo1Xe1cG2nAVbmsgN0oc9vkXcLUL4BESzqLHo+GrfqUOA5lpL3LAQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930865; c=relaxed/simple;
	bh=bz0uIeWpSGSuIQvh66yhCx2wBEBZLK1Uhj3GCh55+fI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RO7a1IYOXrVkRjkCUDPVX4jmWAksnOE3yFTemWooErWcU5Xey76Zw+S4aZIIO4T4L/LEfdptFpAO1MmDOUnlw0o2G83pTjLaQNM30fDEZkr/Ki3vWwAyiVg0/yofX7X/IppQU2kNNrSp0CsRUAwVZEypgDjn1LokoKHGkUBTS+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=LYC4/1pV; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQMP9I7418l4SHiA9n0lLDH2uAi1nvchKNUel0xuLfDlQpY3pK6aFZ/71qhau+H9VLi9i1unlQeLLYqHBxLCVVPXGQaqs+A44FukZFtSg83/zTEfgJoqe1OqeD7MFMG/QcWc7ud+/tGIrQFA7GMHYXXfD4Ff2+tOl5rV+pUVyVAbXatld94FfQX1M0ptgQa9faU+NJdkZkM3ckB4Ey5Hl6T8epTwyWsa79HF/iQMrwU3YKG4zynDc4IarYtkk6JIV681KKnEKcmawnf0cWN2CcPbOATZQggWUKz94fNaYT9H8sEhGOJ9lt/wIUxQJOS/C5qVSGl+rwqqhKk47dAYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xY4cSgz9DD+izQ5CHXWWIiWN/HVvG4kiITK+k1h7IUY=;
 b=akUGRCko+d+8ahB7axYrq/rEkW+n1NdDizj1I3lZLdfvrBoaLIXdzOl2NZXSbeTdiHToIj28M3O/8GhTtNijH34R/OHpDSW58q6m0NP8DnWEjRbG2gZBL7kttlAzvkkF89uSwYdlEO54kkZOkiu4+r7mFu6pmKAhZjVxZVaZyHVD30enTBN3P7q7AFYgmrh5MsDDgMz+pzl5XJCJZY9e8Hy/M2g/oZNfxjRavoYZuGxcx4Sy0LnKW5JqjSSZ1umSHM+57J+L+2fb7ODcTWcDsDYPsUo0b66sJuQBz11WOo9dBqfsFfZ5QLnOuacUYyVjf/L0Ir/0pBFDxT2DhpCOEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xY4cSgz9DD+izQ5CHXWWIiWN/HVvG4kiITK+k1h7IUY=;
 b=LYC4/1pVKIRzt/uRZektppuC93Ga7FZafJ4OUiuPDmfM06V6dS8avxFJ+veHjAcqeQ67sSqJ4heyU6PxLYEMo9D1fYh4L9n/XUS+FNNr9/C0zcUQxpTcYFoOOxTp8vxSqC5fJezSB2lRTU/NCKRVLFdGTjaGZFzX759yx9r0rbzADEu0T8E5h2as46j2lArS5SIecUqMCd6QoMbKBBNFaI364wPu1VRPQaBjR0TaqswfbrKS47UBdywGmP6DnSXsgBJj1wbUwZZo5IwHFrF9iONiyeHJzNzAjunrZViYml4rxWeFeqSTgZHH+upaaLZe6IO6SdhUL9y/zYWt+2QxmQ==
Received: from DB8PR03CA0013.eurprd03.prod.outlook.com (2603:10a6:10:be::26)
 by PR3PR07MB6955.eurprd07.prod.outlook.com (2603:10a6:102:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Thu, 17 Apr
 2025 23:00:59 +0000
Received: from DB5PEPF00014B9A.eurprd02.prod.outlook.com
 (2603:10a6:10:be:cafe::36) by DB8PR03CA0013.outlook.office365.com
 (2603:10a6:10:be::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Thu,
 17 Apr 2025 23:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 DB5PEPF00014B9A.mail.protection.outlook.com (10.167.8.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Thu, 17 Apr 2025 23:00:59 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 93CE22084C;
	Fri, 18 Apr 2025 02:00:57 +0300 (EEST)
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
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v4 net-next 06/15] tcp: accecn: AccECN needs to know delivered bytes
Date: Fri, 18 Apr 2025 01:00:20 +0200
Message-Id: <20250417230029.21905-7-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9A:EE_|PR3PR07MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce50f3d-837b-41a5-4a02-08dd7e03b7dc
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZC9BWTFHWHFjV2dXc1Uxc0JocEdCSnBpMHV4dFFCeVJMQWhoNzMvM0lQNkFo?=
 =?utf-8?B?b0MybWNnY2xKeXk0SXYzTkFuTkJJOFIzSm5RTDJLWWtkdkZLNHlyc2s4bkp4?=
 =?utf-8?B?OGc0SW5OaGNFY1BkUkVyS3J4NTZvTEdnQUhDRFFSOStiVVNvcWdFWXhPZjJW?=
 =?utf-8?B?QkdDeFVRcmt5NHovUVp6K0l5NHUzd04rVnBRYzFtRVRvSU1JZXk0ZmhNSnc0?=
 =?utf-8?B?ZEtVQTNqa3grRkhPd00vTUcxVG5kMzh4MUcwK2dQaFhXZEY0dWpTZXRYbVBZ?=
 =?utf-8?B?NUxwbkN0aGZYdGN0emh4Mk5pZlJMZExuMnkxTUJXZXdiSWxFL3NhMzIxdWFO?=
 =?utf-8?B?b2hqWWtleHR0a2RiY3U2dndkZ2MzdWthcy9PSDRDeVNYMk03dmpnelhoVHli?=
 =?utf-8?B?Q2d1SGRhK3NQZ3dCZnk2ZGNIQmtsMlJJckt3K2h0aGZqUlZjelFuUHVxTU9m?=
 =?utf-8?B?ZFN5K1VacUUwVzNWWTNpcXdCc2s3SFM1RVk2bW0va1k1SXV4clE1ZUZPdjN6?=
 =?utf-8?B?dUdydjFmOCtNS25OeWVJZEVheUVJZGw2a0ppUUxOeU04NWtvSGo0dWFpZkdh?=
 =?utf-8?B?dHhld0pPNThXOEt4bU0yaG1PeXZoQ0llcVhTQ2xDVFBzNjFBem5yd0pXL2c2?=
 =?utf-8?B?SW5sRVFYNDNhMlRRd0o2NTY1cXZ2NnRBZkwwL1hlZWZOZElhWHZhV3psVjdM?=
 =?utf-8?B?Z0F6dkFlaDRqWWNWN0hkSjA5Z1d1MjhYbXRtUi9XTjZBS2g0WVkvWjRla3Vk?=
 =?utf-8?B?NmxqZnRGUDlBSGZTUmhUOVRjdHprb3BGWG5YSU1mTTRoei9TSUY1U0lrUHZ1?=
 =?utf-8?B?ZTRoNlE2aTd2OHBWNXMxQzdmSTNqODRTQnNRajMrNjZWYmMxYlNTcjlnRUgy?=
 =?utf-8?B?QmJYNFN2Y3JVdUdOckRVUmdSRXJVeVhLbFFzQmV1SlQ2eHpGQUdINEpNUFFT?=
 =?utf-8?B?T3NnbE1vRHdQZjR2WENLRDhKa2JqV3JsUWtEQm5kSnZOWTJ2V05CcGlZbnI3?=
 =?utf-8?B?dFdoMW5MdnBJbnB1QlhjYVUrbUl3N2ZkU1BTUno4NTlDNVYwZyt6Y3ozNS8r?=
 =?utf-8?B?TmlzV0VvWFNnbW1UTWJNVWF0UUNNQTVzaGN1azNNblN5ZXgyb1dQSnNnMDFF?=
 =?utf-8?B?c2FjeklQVEdnVXF1SFYyVkgvWFNGdEVnZldpbWRGRkxwUDNtL0Qzblhab1RX?=
 =?utf-8?B?dmNNcVFXaEYyZXNPSUlNZGFRSDltVEpmVXJWdXRrZHluanF4NlBpRlJucmxH?=
 =?utf-8?B?MmVTcjI0VndEWFdRRkc1bHhudmJFanRjaHIvY2hVQlYwS2JpNHVwd1RGaC9x?=
 =?utf-8?B?V2c1bXpPWW03MlJmY2pYeHJDVUY2R2ZGSWRWemlOSlJYcWc5WmdjZEU4bnB5?=
 =?utf-8?B?ZWk5c2J0WXBhcGJodXNWS0pGNUp5SUh5K1JOUk16U2RJRUxLaUtmU29OUTFW?=
 =?utf-8?B?azlDVVRCSVZJZ045WENRTEFoTU9rNkp2dXdqWEozMVhFZHd0M0FIUTBGbzV0?=
 =?utf-8?B?U1pqaFlvSnZqMDg1SXhsdmI2RWRuQ2VSQnM5Ym53eUpaM01sSnZudWtzODZk?=
 =?utf-8?B?d2FYRldQZmtjZkoxN2paY3BSR0NtNHhGK0hWWktiMnhvcXRpYjFGdDJNQnRs?=
 =?utf-8?B?WUMyWmVYVlZZdERORDB6T1FTK0ZidStNS2VwSXZZS1AwTU5ZdVh3bTE5Umxu?=
 =?utf-8?B?YmNTSXE2d0NsTWRBejlRcXNiQzQwN3hzTm5oRHlFR0RkcUt3NFppWUoxQUxV?=
 =?utf-8?B?YjZaQ1NxNVJiK3JjZkp5S3FGT3dXRWgyMWF3c241Znk3M1JxNXBvZ1VMSG5T?=
 =?utf-8?B?c29weXErU21aaGNMeDNJeVAveVIwVTlJZ1VOMkpMNU5wNE91SFlqRnlVWUIy?=
 =?utf-8?B?UTVkT1RuUURIWFFlSUt0eHBJdXkyQnMxK1ZwZDJ6UDU3aENjNDVtU2owUUhK?=
 =?utf-8?B?cm9obng0anhrQkVwRHpJNk1TQm5DaFpKWk1NK0xRdG80UzVINHAwZUEralBx?=
 =?utf-8?B?VkgzMzRubzJOOUw0ekFDblluZEduY21oWDQvZ2w1L2J1UG04eUZzcm5semhD?=
 =?utf-8?B?L3NvSWl2VVZmVU9MYVBjRENtUEU1YUFrMkZEdz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:00:59.0682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce50f3d-837b-41a5-4a02-08dd7e03b7dc
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6955

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


