Return-Path: <linux-kselftest+bounces-36523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198D9AF8E73
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 11:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17EB2B4275C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 09:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306612F234F;
	Fri,  4 Jul 2025 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="XJgFq//g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010032.outbound.protection.outlook.com [52.101.84.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3881C2F1FD7;
	Fri,  4 Jul 2025 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619329; cv=fail; b=OxUdTANbjO3WiG12JRm+31zFmJEwQCwxHgWo2IkKd7kTurgIkn77hbQjq3jYgOjeUwTCiT/CBe5qJ0ioagZ6v7txtgAlHwIobyc0EUFhGtOhmv6z17fUgN8WDsb8KvK2P7QexpnwTO7022u1z/AK1+tUrKI2TDsJf9NB/r/3giM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619329; c=relaxed/simple;
	bh=Mdybeq9G3B7GP0/beCF/g8cOd609L0fOuIyY9L1kj0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wxku6I+RsrXZ7AF6W5zLK/c6GA7K7JAXIiX7vwyL7mZ2Uk65U1zYzwpfxpouiaAj0js3T3p/C9WKuvZLrffRPb7sUBNtXrLU701sgzKmtBTcnvjtPhOvlVBWwi4v+v7cunCyWpEEXu2XhLCJlfHUn6xscEoud6hI0W0NT9kR/LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=XJgFq//g; arc=fail smtp.client-ip=52.101.84.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kg6Rp4eMhfOoMRGQA5fCiZsN48SxBm3JGNzJBXsMrG+MIE4UcMg547vOWcD1W3Nd1GMOdgbGtXau4PtfcefqvnhKA1JNkjC7UfanLPdPIK0tf6snFet83p3gVCGLXNURDCMRK4rRHo6+raaTrhPZDS8SbqKPXXuT4w7ESVQOOBtzC8/3jp0Y4G/UlpO733rJwn+4/4IRS/v/8Det655ppbucA1BeadMEMxxCBfAqFtZtGfqBOjEeK8sSP8zFlloc259412Zuk8lyMtNeydauhXCSApz6KcQ/eQ8eGd7t7kKRlfKplm17IqXxHuZBAshCE+EZosetOp2PXYJoQzAGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pM0xWJCdgOMLIxC5MdTge+tEJZ9kxNrnSEOTj6/s8Fw=;
 b=vub2Wc5b1qv09kuYsD2YDgroNA+YOugH0JRWc210aCFKH6w5f86PM4ucQM4nR7ivbExQhROGlXTtuBmINmAX9wS0XlvU90ife10U2Lk6Mtsj2gaLToxjE/C3JGNzE90G6GtPx/pW65D3p+f07jcjKq3Ox/Rv9mZHV4ohwxeRD2TRfJI9WZZD7cQH8ajeTOXOS0ISfgYamfxAc9LJduRoQxMWVrx2BFPbtRc+6pyTLkis/nnL6p2Dbp5qlJZrnYFsll6ZAjFkPgmR479jofsoMwvv57pxOqHrXXGY0dAjuNl5vz7cnJelWEyJ7Rf03+c5crhyrz6gv72II42EubwXzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pM0xWJCdgOMLIxC5MdTge+tEJZ9kxNrnSEOTj6/s8Fw=;
 b=XJgFq//g1KHPzUfDYy7y0xOFUYtGSHqR5aZSuWPUR6MBpfJVLkA9QxmpxchzASaINSG1xvYfEYq2iujH6tmWtLHUiEzo2mnDSKc7OkKYAIcjd6280y62MCaElbPoZj/p/p0tUSoi+w1Ts7dmeDjWlIc0n1Af5IHUj4C9nonErucVjnC40TAUk1T8U3FJDFHKtIeS9qSTpTA/ZUIYzcgHK0GY81w+CU5WwF3DihgcFuyetHGvnVZO9agDpWHZQtZn8YVRIRAXaV4zXGHrkESbnC7E/3nceuZ+GaAnO1LJlcGnhQmvzfws/5ITYg97XB41bUjYlY0Tm7eRNkDAoCXw3A==
Received: from DB7PR03CA0094.eurprd03.prod.outlook.com (2603:10a6:10:72::35)
 by PA4PR07MB7245.eurprd07.prod.outlook.com (2603:10a6:102:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 08:55:24 +0000
Received: from DB5PEPF00014B8A.eurprd02.prod.outlook.com
 (2603:10a6:10:72:cafe::98) by DB7PR03CA0094.outlook.office365.com
 (2603:10a6:10:72::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Fri,
 4 Jul 2025 08:55:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB5PEPF00014B8A.mail.protection.outlook.com (10.167.8.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20
 via Frontend Transport; Fri, 4 Jul 2025 08:55:23 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 5141120171;
	Fri,  4 Jul 2025 11:55:22 +0300 (EEST)
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
Subject: [PATCH v12 net-next 09/15] tcp: accecn: AccECN needs to know delivered bytes
Date: Fri,  4 Jul 2025 10:53:39 +0200
Message-Id: <20250704085345.46530-10-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8A:EE_|PA4PR07MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f47ddb3-b185-44ce-bbec-08ddbad8838a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azQ2c05hbStDbW1oTFNNWEFnNTRrNHZBZ0tmUENlZ2NmTHJmKzBidmphcWRN?=
 =?utf-8?B?aTlsd0tFMmp4ZFBJOUlYZHZDcGNOK0krOENuKzd2ZFkydUhCa3NsUERuMG40?=
 =?utf-8?B?aWFOQ0U1TjRGc3BWeDZQdmxXejZla2VSeEY0RW1GdTBnQUoyUkJkNHRPVmsv?=
 =?utf-8?B?L0Q0djJsR2d0azlMVFlPK3I2OFN3U1p6V2hnZzRabVZqTmN6OEc4MG1EMHdt?=
 =?utf-8?B?cFVxVGpuZWM4M2Y3aUVqREZLSkdyTUc2NWs4aEtqZ3NyZmI0Y0ZieFdNYStr?=
 =?utf-8?B?cnJtSmdpSFBzR1d3K2hLSWF0eEovZEVweTJ1QmhDK1dvWGV4TEVldkYyeDdt?=
 =?utf-8?B?OU1ZRzhsQVJmOXE3MEpHU3VaOVVFMmpaaTBSNTNpRm5Kc2RqYXErbG53Nktz?=
 =?utf-8?B?Vy9kVzJlS2FLaW01UldlQkh5S1liNHBtYjdZY3JqNHJWY1Rxa01vNk95MTZv?=
 =?utf-8?B?RHhoZmttMklOc3U0eWk1WDhwUFU0T3ljL0YvQ3I0cnZya0R6UEdpbFJxSXht?=
 =?utf-8?B?TTVORVZuNzRZcTJCanRBRzBwUHRoOU14dzROVFBNUnFURjk0MmMvbEZrWkgr?=
 =?utf-8?B?M1JoNUdna2JOVmZtMTBWNnIvc2Q0WGJFK3E3QjZGdS9sRjdSdzZFd3NvbUF3?=
 =?utf-8?B?U2cyWVd1QVNXMHJ5VjdKWjdEMTNvQ3VqOS9hU0ZPRytBZnZNUXpscUxqTlhD?=
 =?utf-8?B?eXA1UUVvTmQyYlhkeCtzdWdGQ1F2YVVLL3BuWE1iS3hZdi95UzhISnZQNXhw?=
 =?utf-8?B?RDkrUitScHJnV3JyYlVHY2FYVGlsZExIL3Bjb1ZhRTk4bHJ0clhEMmh1QURa?=
 =?utf-8?B?NUd6TnhnZFRVakxzZkZPdjA0b2NTVW45MFZ2akQ2cnJIbWZTQ1hsN1R4ZTFK?=
 =?utf-8?B?MTlqM2U0dXd3ZWFxK0J6ZGxLbm9lTlQ5VitrWlliTDZvdzVBaVRPdmo2OW0v?=
 =?utf-8?B?NTlJK1pwb2V5UEhYS2dCdG9CWTZzOVdLb2Y5UTg1MkdCbHBFZjdZallhdW9q?=
 =?utf-8?B?Y1FvRHVLdTdvazRPajlidkpFSStnaVgwK3FkYVZlT3d4TlRFWE1ENU1KU2lO?=
 =?utf-8?B?MGI0c1gxUW1rWC91QW8zVnFxWndaYkRJNm9GWXFlZDlPelJ1ZzRzWW1SR28w?=
 =?utf-8?B?Slp0cGNHekNZTzJNV2NJcktnR1BHbTVBeEFBajlHOFRSWEl2VGJTVVlXWE8x?=
 =?utf-8?B?elR5Vy8ySmFQQzl0Z01BZFh0blJVd1IrRmpidHlDd09iVGkxMHZWZzQ0RFJ1?=
 =?utf-8?B?TGtxMzMvdzdYdHlVYzQ1bHlxcExsYm9YV1Q1RlJ4L2tOVDFDTTNwLzI4MGVB?=
 =?utf-8?B?ZklNSWxWUDRUUU5STG5qKzRzbXd6R3NoTE45MGVJMEt0ZUl4dEZwUWw1aEJ6?=
 =?utf-8?B?eXhoeXNxMnhOcitDcmpJck44bnpyRmFwdllNN1JXWElXSGd6aWRZK1pxZGRv?=
 =?utf-8?B?VExLSHA5czZMVDkwd0lzTlViVGJEdGhKdFJlSjM1bXNNU3lLTkRvemtRUmFI?=
 =?utf-8?B?b25FOUUxaHFiYWM4TnZiQW9JNmYyWkcyOXZVSEhGSXVEeWdYR0IwY0Qra2p5?=
 =?utf-8?B?eU9xdi9Ib3JvNU9YMWdqYnRYYk8reFVTRWxGYmJMby80anpyNTVIRDk3Nzhm?=
 =?utf-8?B?T0xXbk5vejZ2NllxV3JKQXRJdVlXKzdWSXZJcExFOS93VWZmbldXQXc2ZlJj?=
 =?utf-8?B?SHExcjZITHRNTnlaMVA1TS9YV2V1Qkp6a1JiaDU0Vzkvd0p4YmQvM1BIa20y?=
 =?utf-8?B?cktNN2Y4VENGajVxeU9XaS90WDVBZHg3dHpPYmVXamRkU3F2L2txTm5MdG9l?=
 =?utf-8?B?QTMwQnBrK0YzbExQRHp0Wi9DWWNOQ2RidXpzMDZYdlN3b0NZcFEvWFVwRlBB?=
 =?utf-8?B?TndXZ2VhS3dWWk8wOG9LWWFoRUxOM2svV1lhL3EwZHBIZGhEY0dnVXZrQXVt?=
 =?utf-8?B?eE1aQ2ZDUHlNQkFDQlh2ai90Y2w2c3U5MDhBWkJaQ3JocXZNMjd0bjdHT0di?=
 =?utf-8?B?M2d5WlZYMVJDd01oa3YrZ0pKa0k0cUFoS0tQb3JlMWV0Y0o1bjYzUnlVam83?=
 =?utf-8?B?Y2NsTkpMSUlncDY3TlNEZEJSNkZtbWtYL1pOQT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 08:55:23.8281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f47ddb3-b185-44ce-bbec-08ddbad8838a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7245

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
index eea790295e54..f7d7649612a2 100644
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


