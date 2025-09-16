Return-Path: <linux-kselftest+bounces-41583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67C4B59072
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 10:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4058E2A7D58
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 08:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB622E7194;
	Tue, 16 Sep 2025 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="XpgV+gNV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011017.outbound.protection.outlook.com [40.107.130.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0731FBC92;
	Tue, 16 Sep 2025 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011125; cv=fail; b=hNZozFEFaiO5lnqzzCK/GUxCAqq0gkmQNz5MqYmjkeCzNRddy9QfBm3Cru8+CpGAJAyXh7sLCECyKH+Qipmtn43bY/JZziwm/VyH5F9kIQE9+yjQ9Np9uamqyaZ5tOT4HV2ZKWeL1b02vNSMq+a8TMYevRHLly+f7+BQYxHpSkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011125; c=relaxed/simple;
	bh=/V5Tsht2NDxkT5nX8xNrWaEEwIkpwc8MocPQ3W4gmkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFQeG9VlTf5LK7DtDWcuDq1Vfa8GUuBqlixbjiy9641wGPR/1XqLPsG4DOdW/WN/yHvC8PEzpIo7tCbLNmyRxobsKa7LHukd7Fe5vKB4ABrh0iI0hU0qpBC+ucJY16hrQ+0x9tfOSHChv1BgMe6Qyx8kq7AKf1nEtnnHprZHKJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=XpgV+gNV; arc=fail smtp.client-ip=40.107.130.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPapz6OUJc9Vz7BmXYv/ejNnCQ9Zg47ZpryTDtfAvIx48i0bz7XeS9cUl3eH7G5O5o4V8uXRs+aleVDZFVA15MCfT1KtRn5MP7qsl2len3ULhx+dIkicV51obmO6ak2OjtLVTLq9b4lOHg9Fa6hy6dkL03lS5NbR2zkTc+3bD5hn8pfNMiDtqJuDw7OFjds+zxRztr2vqLOlXSJgD1nwXDV3QJqYKo+gue2ts2V6yG/pBfFgPH3BhV4rlC3aC4JCOSGcMfJuWJBw/Kwursqif5MsZ2ihRFf07J4KKgYubhfrrAaNxfkRRsS1WtMGqnhV5hT++bJm7/wdm/bEmUNJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/yFbL74OQ/XK/3sptxkfjUCa27CcWJ0rFxpfari+wM=;
 b=x4KOZ2CqHz8BCye0CGTSIce6xQ4MdrvbSNta4Vi3tjUtVkGgXGsmd/f1O4DUri0866Z/pWFNUf+RJaGuyzzGCSXpSKvtlJbYyJJVOxR+Kx3ZsYHDSSVjS3wm8wRZqXU7mQTXyBGT78RSJLzCuHLix6/JdnneGfXcq7HRybVt0TgR7wG2efz1SCWkttxM9cdMmF/XDtiWJJcw7POVet6Qz5RpoY9Zg1DpzId3+uLkmjFmLT0CGN+e/gm9OBR4NFVsUeLRfO+irg/LwxmQjBbvb5tNUne/sTbL481pYNkCeNXZjwzPIk2F9gBXuhChgK5KDSs4wF3j7Z1HpeE/MagP2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/yFbL74OQ/XK/3sptxkfjUCa27CcWJ0rFxpfari+wM=;
 b=XpgV+gNVEebhyN5b9qJbLISmXe9lDINYXRKCvSPWBwRcV8LKWQiVqUwu5qP38fD2+svPUZxq3MnsENdQAFgsWWew+johG8USU8VwmLGvoH1YV7n2OQf9BHE4/HAju+L3IBxKDqLhuU/bdnkBj7Jx9XZhBXUjBJOSd/83DXvwNhAQKH9uiWsoaeu/DhuaP4h59Js11ogMlLQJ3GUJwRxbF6Ck7lE+IdRuXsVInabL28JGpXr5CMUFSvY94mh6abVyHckqCgFJl7Cn/N0x/qsg7b+wdptAUDnq4yFZqNkSU1HLWP5+rfYgQdzTD86egT8g7kcE2vYkjz43jPBp0a0LIA==
Received: from DU7P189CA0021.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::17)
 by GV2PR07MB11198.eurprd07.prod.outlook.com (2603:10a6:150:2b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 08:25:19 +0000
Received: from DU6PEPF00009526.eurprd02.prod.outlook.com
 (2603:10a6:10:552:cafe::ec) by DU7P189CA0021.outlook.office365.com
 (2603:10a6:10:552::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Tue,
 16 Sep 2025 08:25:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU6PEPF00009526.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via
 Frontend Transport; Tue, 16 Sep 2025 08:25:18 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 64637200E7;
	Tue, 16 Sep 2025 11:25:17 +0300 (EEST)
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
Subject: [PATCH v19 net-next 04/10] tcp: accecn: AccECN needs to know delivered bytes
Date: Tue, 16 Sep 2025 10:24:28 +0200
Message-Id: <20250916082434.100722-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916082434.100722-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250916082434.100722-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009526:EE_|GV2PR07MB11198:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b0541d-c25d-46a3-6035-08ddf4fa9248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wjd3cEgwVDdhNGFIeFJLNDluYk9qZG9vN1ZYNTBzRVV3aDVpKzFidXFEeFQz?=
 =?utf-8?B?QWJHeXhaOW1uODhOYWxjcldQbDF0YWl1SC8wQm8waUxqZFRXTjdObkJkc2RU?=
 =?utf-8?B?WVRBQTdUNjV4Rk5IeEw1ZGwwd3hCTm92WmxvVTg5Q0o2QlpiRmVCVFBROTRs?=
 =?utf-8?B?dTdLVzI3SGR4ekdFWGQ0N1V1QVhNMFE4NkVIeG9YeTlWN3Q3Sk5sUEcxak1K?=
 =?utf-8?B?UWZnOHBJaXdneUIzNmU4bVdPRXlWcjIrTDhyM2wySSs0RTI5MmlEOTlqL2NO?=
 =?utf-8?B?UTVQTnRYdDJpVmNUWkNYbGR5SWp1NXNwYldNSUlxWGJ6eE85ZHBIQngxNnhM?=
 =?utf-8?B?cTYyNzNFaVJUQmNXVkRKRExxMW9Ic3NqQnNVdTdZbkdJMXAyRUt1QmRJQVNN?=
 =?utf-8?B?TDBNSE5rNWl0Q2RKWW5ScGtFTW1HeE1NMDVjakNYUXBnQmFBT1hXUC93aDhT?=
 =?utf-8?B?U1lxSXRhNXliTUJXdkdaTWtEeVVRWXRZRzlxdHZHQVJSNm9WRWpSbHlkYWpM?=
 =?utf-8?B?TVFrRnNzVDVXOHo3WlVoWWlyMU13ZzBkQ2gvUmhxdzA4ZDJvS3pwQUxPbW0y?=
 =?utf-8?B?dDNaNUlnK285eHdSWktyQjBBcU5rV25yelBzYTExYlhvQ1hUejJKRk4zNlVT?=
 =?utf-8?B?d2FESzA4dCt5SVFGb0N0RDc5WVZhQTZSc0VNaDhCajZnQ3JWbUROSE14alBZ?=
 =?utf-8?B?U3VpbE1IZytldmtjOE5vWjhQQnQyZ216bnNmMndWdGdTVEplWURYeDlOYjBa?=
 =?utf-8?B?a2Z5STlqSXVoWUkrL2RrTXN1MmcxSEw2UzNkNHY1NmdzT01oTmVKTTVsZUIz?=
 =?utf-8?B?WWxOdmVYeVN6NDVHbGZJWGMzREw4aDgvZ2Vmbyt4dk12NE9qV3A4OXN5M21r?=
 =?utf-8?B?TEZLbWJXc1pWbFVOOGplOEt6M0ZCNHVXYTZHM0JaNW1JQmd4NnJxNXJDRVpX?=
 =?utf-8?B?WFhtbDBSUHAvemxmVWR6cmNYMmZGQVNmbExMN3JZUnFPVjl0M25TSUxrZlNE?=
 =?utf-8?B?dFRYajU3ck14L3FZOEc0aitaR3poakp1a0dWN283OEtzVjhRd0NPcTV0aTFQ?=
 =?utf-8?B?MGJTLzF2RzJnbVN2VVQ0dEE4c0pvbFR4WFZOZVNJMmFpY09RMml0eHZHYU9Q?=
 =?utf-8?B?OURlTTRmdHIyVUFTZTlaUHlkVUs2NzlXK2MzaW5ETEpjNmdEa1o3OTk1QTZv?=
 =?utf-8?B?cWF0MmVqQ1kzL0NHaUNuZHpWNWV1TDl2bGR1aURFSW5HdVZtK3pGckFGVFRN?=
 =?utf-8?B?U0ZCUjh5NU1raEIzWHRkRmoxeGJSMWU2YUhremhDMTJNTTdQNGJDcjZpWjFZ?=
 =?utf-8?B?SWI5eFdhYk5pbk0wTG1saE1uWDJQQnBqby9MVmJqeXJ3ODJmVW96OWx0a254?=
 =?utf-8?B?VDBURThwZmo1T0Z1akt4RUlwRnBid3p1YWhxUjBOdVNLc0t1VkJGN1VGYzl0?=
 =?utf-8?B?MEhNOUx3L01sWHZzN3FROVNrVER0eDRHY1BLYjhDYlkyTm9zZXg3UTl6MVIv?=
 =?utf-8?B?M3NBY3VKZ1hjd0l4RXZFTHJ2WFVmOW4xNzhWY1lPbGZDeFFzZEtHQjM5c045?=
 =?utf-8?B?blZDSmkvUGsyV1NFY09XV0tYNzNQbTVIME9FdE5PNlI0V0grMWtNM1R3aUhP?=
 =?utf-8?B?ZGVwYnczUTN0Q3N5ZSs2WW1sczdGY2Vzaml3Q0VxSVVCT2xZamdoRkNLamQx?=
 =?utf-8?B?NVpvS3NldlVnc1VpaVpzQVY0aDRLNmVTU1FUcy8zSVh5OWN0R2dIaDlEaWxx?=
 =?utf-8?B?RmVQMmZnQkx2d2NDa0lMTlh5ZVNKS0p2MUlQMTNTR2R2eTdyZ2UrdFlQYXNZ?=
 =?utf-8?B?VFJYRWRaM0hHMDZjTnNLNUwvbU9Id2ZVWmMveXVQZVpPYWZubExUaXVXeHJM?=
 =?utf-8?B?c1ZWZjRTUWE0SkJ5SzRoaFk3THlJMGZrdTAveDcvVE16dmNMdDRkM28ya3BP?=
 =?utf-8?B?MmVWdzY2VWlzMHZmbWZGRFJocHZwdENQajNBVUhnNDJINVZxdlVwMVg5eXBh?=
 =?utf-8?B?SGU4WC9FM0RjQUw2NkdXZnlnTFNMazhFRGNocXJTM2NkNWhCZldMV3BoRjBx?=
 =?utf-8?B?N1B2Z242WkViS3dFWWc5UUwrRDQzYzRQVjNpdz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 08:25:18.8876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b0541d-c25d-46a3-6035-08ddf4fa9248
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF00009526.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB11198

From: Ilpo Järvinen <ij@kernel.org>

AccECN byte counter estimation requires delivered bytes
which can be calculated while processing SACK blocks and
cumulative ACK. The delivered bytes will be used to estimate
the byte counters between AccECN option (on ACKs w/o the
option).

Accurate ECN does not depend on SACK to function; however,
the calculation would be more accurate if SACK were there.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 636a63383412..8b48a3c00945 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1050,6 +1050,7 @@ struct tcp_sacktag_state {
 	u64	last_sackt;
 	u32	reord;
 	u32	sack_delivered;
+	u32	delivered_bytes;
 	int	flag;
 	unsigned int mss_now;
 	struct rate_sample *rate;
@@ -1411,7 +1412,7 @@ static int tcp_match_skb_to_sack(struct sock *sk, struct sk_buff *skb,
 static u8 tcp_sacktag_one(struct sock *sk,
 			  struct tcp_sacktag_state *state, u8 sacked,
 			  u32 start_seq, u32 end_seq,
-			  int dup_sack, int pcount,
+			  int dup_sack, int pcount, u32 plen,
 			  u64 xmit_time)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -1471,6 +1472,7 @@ static u8 tcp_sacktag_one(struct sock *sk,
 		tp->sacked_out += pcount;
 		/* Out-of-order packets delivered */
 		state->sack_delivered += pcount;
+		state->delivered_bytes += plen;
 	}
 
 	/* D-SACK. We can detect redundant retransmission in S|R and plain R
@@ -1507,7 +1509,7 @@ static bool tcp_shifted_skb(struct sock *sk, struct sk_buff *prev,
 	 * tcp_highest_sack_seq() when skb is highest_sack.
 	 */
 	tcp_sacktag_one(sk, state, TCP_SKB_CB(skb)->sacked,
-			start_seq, end_seq, dup_sack, pcount,
+			start_seq, end_seq, dup_sack, pcount, skb->len,
 			tcp_skb_timestamp_us(skb));
 	tcp_rate_skb_delivered(sk, skb, state->rate);
 
@@ -1792,6 +1794,7 @@ static struct sk_buff *tcp_sacktag_walk(struct sk_buff *skb, struct sock *sk,
 						TCP_SKB_CB(skb)->end_seq,
 						dup_sack,
 						tcp_skb_pcount(skb),
+						skb->len,
 						tcp_skb_timestamp_us(skb));
 			tcp_rate_skb_delivered(sk, skb, state->rate);
 			if (TCP_SKB_CB(skb)->sacked & TCPCB_SACKED_ACKED)
@@ -3300,6 +3303,8 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 
 		if (sacked & TCPCB_SACKED_ACKED) {
 			tp->sacked_out -= acked_pcount;
+			/* snd_una delta covers these skbs */
+			sack->delivered_bytes -= skb->len;
 		} else if (tcp_is_sack(tp)) {
 			tcp_count_delivered(tp, acked_pcount, ece_ack);
 			if (!tcp_skb_spurious_retrans(tp, skb))
@@ -3396,6 +3401,10 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 			if (before(reord, prior_fack))
 				tcp_check_sack_reordering(sk, reord, 0);
 		}
+
+		sack->delivered_bytes = (skb ?
+					 TCP_SKB_CB(skb)->seq : tp->snd_una) -
+					 prior_snd_una;
 	} else if (skb && rtt_update && sack_rtt_us >= 0 &&
 		   sack_rtt_us > tcp_stamp_us_delta(tp->tcp_mstamp,
 						    tcp_skb_timestamp_us(skb))) {
@@ -3858,6 +3867,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	sack_state.first_sackt = 0;
 	sack_state.rate = &rs;
 	sack_state.sack_delivered = 0;
+	sack_state.delivered_bytes = 0;
 
 	/* We very likely will need to access rtx queue. */
 	prefetch(sk->tcp_rtx_queue.rb_node);
-- 
2.34.1


