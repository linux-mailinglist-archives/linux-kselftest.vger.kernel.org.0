Return-Path: <linux-kselftest+bounces-40978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32346B4972D
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 19:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5C4165E6B
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C243191A7;
	Mon,  8 Sep 2025 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ZOIQnpIK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010042.outbound.protection.outlook.com [52.101.84.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4FE3176E6;
	Mon,  8 Sep 2025 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352882; cv=fail; b=OINeD8+f4hu788tPo4FWXXkfdzEWIeemXukARF26glF9oVIugWGPXbtz4I1PgcWaZQwIlQ6qURNHmY6lLRoBqW5oAtBaJeQdX4+lPVth6a6YQtEQnu4WexKVWzQehcFD5pwfCqH62PD/fGAKTNciv6R7rEvUNThD4bc9LKSTxrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352882; c=relaxed/simple;
	bh=WOkz+ILNeSBA9CG21DA7O0TrviveUyv1O9+7vTpudYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GhRr9EyDoJYCad8yPZYZ5NYKmt0IWQ8RhlLpv5vlNjDb3wlj8ye3FfUyNBOYejR3hp6BKjAqCMtRsMY/+LjO7C06nUdq7023RiI/OpOb5OxG85WyBh96VeoA5k26CtitypqEBJgh+hBvIO4MA6j38kiGeSQwQ6z8sXxJBS0w57E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ZOIQnpIK; arc=fail smtp.client-ip=52.101.84.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7kMpLnS2HJGRcqxP2xe7vv7m+atikD1zzt4rwiclHanQ7fZXxLSosCSfQ+7tox6zRaQ0hbsCT+xh4AWtK6qaEcg9M3Rb/MffKwtEsVvCOFk+gJ/wdKPdgmpbOF/+zoDqHOYxdWXLP1242Xkd/ODR0c+SOUVA2NnSRvWzLlM8YOdLI5gCdujiV+9gJDJZ6seQi7IOut3CW/x66DbXuG3CC9Ue5iESA3yE131u8geNQDLwpr1TXKOt9KLiCYdZEXKx+vBc18wJHIsOx4z+kycEQ9r7A7M5KpteMbSmbaUrYiB+gsvrsNUyZkWZRmojFR0r7wZiEgy+pqXwFdiv8iS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9g8P+p+nvkS/qhDKHHvgjjF+BYHKbrzJYbIl1/ENCy4=;
 b=FDX1nKCNDNAqkDXYLi/MW7Sig6kZaHmZKDQhj54t+5mOZPPo3sH4o6IeGUVrQ7nUX8lTHiNnz8g+fR5++G+oFWaQYZ9CrR8pVFZfKRukRs9IB8vQ+zAhL1D6MDbwMKGL/+wYQMtfeWMe6PLgBz8W6VIOZrLVY6CEcNpClpXhM/V/gzQHAGkMo8EFXy9Q/Kuq9uhCE9kN/pySW1v0JKT81EQkpXcUau3fRZS+wH3wJ0vXzR1ydW4il/TBd8iaNIpSmaTWUMzN7l98AjIm8+SK3rM8YktBuH6J0kZA3do6AcM59jzbXsas5le83CTIQx+aqc1lFEi+oF221bhXnf7rgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9g8P+p+nvkS/qhDKHHvgjjF+BYHKbrzJYbIl1/ENCy4=;
 b=ZOIQnpIKcUZ/6ah/oKQJbQRQlYnbT0YN8IuMwwwUG7ScR9uwJD2UP3UbOd4iMYH/ZnxaHobme5b3j+7HXLyp+JxQIo4asboikvuviNPe6JHBscF+15jjipsqk67f4YsQZQM4plfr+dUVsgV+sXTE9zcVgvWD2eAgb3PypKXqkRR99EY+xWjkxFEImg+oCega6uo2Q1DcBGOu8NW5joQVp/YcjU670vss2UB87OTNJRWYDVd4naaL+cQd6PMCsyoVXV6+Y7+qG/TIHHS9jVmm2wzJySugI80D7ljT8EwQ6zhE4VZkUKCdsjJKL2I1ulXjiuLhNEKCWTX28K0RCdT8oQ==
Received: from AM0PR02CA0140.eurprd02.prod.outlook.com (2603:10a6:20b:28d::7)
 by OSKPR07MB10376.eurprd07.prod.outlook.com (2603:10a6:e10:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 17:34:36 +0000
Received: from AMS0EPF0000019F.eurprd05.prod.outlook.com
 (2603:10a6:20b:28d:cafe::17) by AM0PR02CA0140.outlook.office365.com
 (2603:10a6:20b:28d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 17:34:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF0000019F.mail.protection.outlook.com (10.167.16.251) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 17:34:35 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 71A661C004A;
	Mon,  8 Sep 2025 20:34:34 +0300 (EEST)
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
Subject: [PATCH v17 net-next 12/14] tcp: accecn: AccECN option failure handling
Date: Mon,  8 Sep 2025 19:34:06 +0200
Message-Id: <20250908173408.79715-13-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019F:EE_|OSKPR07MB10376:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c269c01-1fc3-4e84-cf65-08ddeefdfae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S29adDdnck5wUFVTUUJHdmpsbkFYLzY4cHZicnJHOE4veUNzTFRwNUU5WGhm?=
 =?utf-8?B?MmdtQVVSMTRMV1psMUFYZ0RMdmV6dk9FVTh0T2N0TjViV1NKREwrWUVoNHpZ?=
 =?utf-8?B?d3c2RytxaGtOc2VUREM1eUo2cmJTcWI0YXMzZEhuKy9lK21CT1U2eEhuaWIz?=
 =?utf-8?B?RWhDRXFyT3lvVmNaMjYxUXZHdlY0VW5qN0dpRndsRXpza3k2eERNQ1MxMFpF?=
 =?utf-8?B?c1hjL1VqRnY2eEFCUXliYmZsei9PMExkYWRnTFBKaEgxWGxVRlFHVVFMZG56?=
 =?utf-8?B?VnR4cHlWU3hza1YzSmkyZTZ4MHY3anQ5NHJjK285clVwbG1PU1FhSW43cVhD?=
 =?utf-8?B?ejZXNmE5U295eDhLQkkvUW9YK0EzbmRSWHUreEJZRlRBVzNCTkFxSGtUbUZh?=
 =?utf-8?B?SUZkM2tnK2hSaEIyQ01idEpKYUJIenRIL0JGRkIwWU9YVVk2cXN5UzBRUTdM?=
 =?utf-8?B?eFlDU3RMOW1HaVZlVjBSY2xBUTYyM1lvQVVDUTZUU0NaeDBUbHpBSHBZRmxH?=
 =?utf-8?B?TXk5a1A0MG1ZV25TL3VlZjhreVkvc3pHa21ESE4xUzVBbUtQcWI4M015Qm5i?=
 =?utf-8?B?MkFLdVpDOGtuS2ZRbURVcWtpRWs1WnJud2Z4UkxnL2h2U1o5akFYdHdaUEN0?=
 =?utf-8?B?NUdZZHgvRmFDbk45SWowR1JwT0psamVyN2hZSDFUZWdZU1hKNlNJdFRzUUtU?=
 =?utf-8?B?ZWcwKy9GbStiV3ZqdGh6bUlGdWp5RmhERTFoU3RucVlKdzlqdGkwSUFmN2JN?=
 =?utf-8?B?MFVNQ2dxdjQzSi9nYk5jb1hQUmJSNEVIaGt2d0tEQndCemI1WS85M3JBYWd6?=
 =?utf-8?B?VUhEMHNPMG1ySzNUTTJBQ0p4dFZ2aStUY2YyUHlCemJ3ekNhSCtrR09Oakw1?=
 =?utf-8?B?MWk4UldZazUrTEdlZ1VLYzRhNDdYN2Njank3UmZNZE1SWkFvcmI4U0szdHo4?=
 =?utf-8?B?ZElhb3BFZEN2bW1sS1Z2VVdmVDZOc1NOMU1ZNEx0Q0kraUZka2M2a2s1S1Rj?=
 =?utf-8?B?eWNHcEs0dzRRVG5wS3ZxRjVydEk1RGd1aEFxemg4QlcraHV5bHZaVWdrb3B5?=
 =?utf-8?B?aDhPSXFZVVE3dFpvL1JvaWNNWUVrT1c1eTNRdExoLzBDVDdwd1IvdE9NRzky?=
 =?utf-8?B?Vm5WOGJtWG5zTzhpUTFQZGxaeDRkR1BJeVJ3Ukl1MVBuUXJ6ZFd1ZzM1VWgy?=
 =?utf-8?B?UmdXQXAzQkFlQVpwaGgwZUNZektXTjVhTlgyZUhhOUNXQXB4amhDaXkrMWhK?=
 =?utf-8?B?aHc0SGdmenhscHFBVzhVWHRsaDJuemwwdFR5a1dUbFFpaWtzSXdKUmhxcU9O?=
 =?utf-8?B?aDRTcy85dnB3VnJmZmd4NjRoV3VDSkcwdVpKSEdYN1M3RmxDbEh1bmI0ZVhC?=
 =?utf-8?B?U1M3enBDR2x1QzcrN2kzWGZIb1NzWEFWRWVxb2N1Yk51aGtZMFRtNlIwR0pq?=
 =?utf-8?B?SFYrZWwyTWVKQk9IZmk0bXFUcVRBTDgvRVZYeDdEQ2w4M04xTkdraUpuOGRS?=
 =?utf-8?B?S1JvZFYwRWQySE84WVpwbE1lTTVpcncwUFp1M2FPbzJoYmtiQWNZTlhCY3FK?=
 =?utf-8?B?SkQvaEY0TXlBWHd6N2U3U01hTXlBZENuc1lUbzBKTDVVQ0tWWkpqOEYwTXor?=
 =?utf-8?B?WExWSEUwMTlrK1c5d250TjB1ckdjQlptNVBkeDZxalNOQTY2a0V3MERlS1o3?=
 =?utf-8?B?d2trbk9wYWpZdlNrbDhFYkpVdmthcFpDbGJNcFdFYm9xNzFGWFBnNmxDZitk?=
 =?utf-8?B?ZnNZbkQxeGI1Zkk4bm82MjRSTTZ4cWFIcVYyZUtQeXFZd0xqaElNclVwUitt?=
 =?utf-8?B?cEI2THhNcHgydEU2WTFFU21Cd0tRdHJUWTRZL0NWTXlQcUpnTFdJakJ6bFFG?=
 =?utf-8?B?RTZqNGgxNlgrZUgvTjVLRUxtTWRHaUp5ejYwN0k5WHN0UStuZGFnYlI0Rnpt?=
 =?utf-8?B?VWdpNHJCWjg0bU9aTDY3Q1FWSDYyZjVKL0VJbHFKL1V3QWs1b0NNSENNRENF?=
 =?utf-8?B?Wmt5dkt5T01PWTZCckJLb1VvMldmaTNYYzZTcStoWWZ1bExGeXQrRzM3Q1pI?=
 =?utf-8?B?dE1rc3R2QUFoTmdBRkxnWXQzVVc0SWFqQlVSdz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 17:34:35.9482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c269c01-1fc3-4e84-cf65-08ddeefdfae9
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF0000019F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR07MB10376

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

AccECN option may fail in various way, handle these:
- Attempt to negotiate the use of AccECN on the 1st retransmitted SYN
	- From the 2nd retransmitted SYN, stop AccECN negotiation
- Remove option from SYN/ACK rexmits to handle blackholes
- If no option arrives in SYN/ACK, assume Option is not usable
        - If an option arrives later, re-enabled
- If option is zeroed, disable AccECN option processing

This patch use existing padding bits in tcp_request_sock and
holes in tcp_sock without increasing the size.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v16:
- Add tcpi_accecn_fail_mode and tcpi_accecn_opt_seen in tcp_info

v13:
- Return TCP_ACCECN_OPT_FAIL_SEEN if WARN_ON_ONCE() is true in
  tcp_accecn_option_init()

v9:
- Add comments about the 1st retx SYN still attempt AccECN negotiation

v8:
- Add new helper function tcp_accecn_saw_opt_fail_recv()
---
 include/linux/tcp.h      |  4 +++-
 include/net/tcp_ecn.h    | 51 +++++++++++++++++++++++++++++++++++++---
 include/uapi/linux/tcp.h |  2 ++
 net/ipv4/tcp.c           |  3 +++
 net/ipv4/tcp_input.c     | 35 +++++++++++++++++++++++++--
 net/ipv4/tcp_minisocks.c | 14 +++++++++++
 net/ipv4/tcp_output.c    | 11 ++++++---
 7 files changed, 111 insertions(+), 9 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index f637b659b35a..3ca5ed02de6d 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -173,6 +173,7 @@ struct tcp_request_sock {
 	u8				syn_ect_snt: 2,
 					syn_ect_rcv: 2,
 					accecn_fail_mode:4;
+	u8				saw_accecn_opt  :2;
 #ifdef CONFIG_TCP_AO
 	u8				ao_keyid;
 	u8				ao_rcv_next;
@@ -407,7 +408,8 @@ struct tcp_sock {
 		syn_fastopen_child:1; /* created TFO passive child socket */
 
 	u8	keepalive_probes; /* num of allowed keep alive probes	*/
-	u8	accecn_fail_mode:4;	/* AccECN failure handling */
+	u8	accecn_fail_mode:4,	/* AccECN failure handling */
+		saw_accecn_opt:2;	/* An AccECN option was seen */
 	u32	tcp_tx_delay;	/* delay (in usec) added to TX packets */
 
 /* RTT measurement */
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 133fb6b79500..f13e5cd2b1ac 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -91,6 +91,11 @@ static inline void tcp_accecn_fail_mode_set(struct tcp_sock *tp, u8 mode)
 	tp->accecn_fail_mode |= mode;
 }
 
+#define TCP_ACCECN_OPT_NOT_SEEN		0x0
+#define TCP_ACCECN_OPT_EMPTY_SEEN	0x1
+#define TCP_ACCECN_OPT_COUNTER_SEEN	0x2
+#define TCP_ACCECN_OPT_FAIL_SEEN	0x3
+
 static inline u8 tcp_accecn_ace(const struct tcphdr *th)
 {
 	return (th->ae << 2) | (th->cwr << 1) | th->ece;
@@ -146,6 +151,14 @@ static inline bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace,
 	return true;
 }
 
+static inline void tcp_accecn_saw_opt_fail_recv(struct tcp_sock *tp,
+						u8 saw_opt)
+{
+	tp->saw_accecn_opt = saw_opt;
+	if (tp->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN)
+		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_RECV);
+}
+
 /* Validate the 3rd ACK based on the ACE field, see Table 4 of AccECN spec */
 static inline void tcp_accecn_third_ack(struct sock *sk,
 					const struct sk_buff *skb, u8 sent_ect)
@@ -428,9 +441,35 @@ static inline void tcp_accecn_set_ace(struct tcp_sock *tp, struct sk_buff *skb,
 	}
 }
 
+static inline u8 tcp_accecn_option_init(const struct sk_buff *skb,
+					u8 opt_offset)
+{
+	u8 *ptr = skb_transport_header(skb) + opt_offset;
+	unsigned int optlen = ptr[1] - 2;
+
+	if (WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1))
+		return TCP_ACCECN_OPT_FAIL_SEEN;
+	ptr += 2;
+
+	/* Detect option zeroing: an AccECN connection "MAY check that the
+	 * initial value of the EE0B field or the EE1B field is non-zero"
+	 */
+	if (optlen < TCPOLEN_ACCECN_PERFIELD)
+		return TCP_ACCECN_OPT_EMPTY_SEEN;
+	if (get_unaligned_be24(ptr) == 0)
+		return TCP_ACCECN_OPT_FAIL_SEEN;
+	if (optlen < TCPOLEN_ACCECN_PERFIELD * 3)
+		return TCP_ACCECN_OPT_COUNTER_SEEN;
+	ptr += TCPOLEN_ACCECN_PERFIELD * 2;
+	if (get_unaligned_be24(ptr) == 0)
+		return TCP_ACCECN_OPT_FAIL_SEEN;
+
+	return TCP_ACCECN_OPT_COUNTER_SEEN;
+}
+
 /* See Table 2 of the AccECN draft */
-static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
-				      u8 ip_dsfield)
+static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
+				      const struct tcphdr *th, u8 ip_dsfield)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u8 ace = tcp_accecn_ace(th);
@@ -469,7 +508,13 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
 	default:
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
-		tp->accecn_opt_demand = 2;
+		if (tp->rx_opt.accecn &&
+		    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+			u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
+
+			tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
+			tp->accecn_opt_demand = 2;
+		}
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 53e0e85b52be..00604b7f2f3f 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -316,6 +316,8 @@ struct tcp_info {
 					 * in milliseconds, including any
 					 * unfinished recovery.
 					 */
+	__u16	tcpi_accecn_fail_mode;
+	__u16	tcpi_accecn_opt_seen;
 	__u32	tcpi_received_ce;    /* # of CE marks received */
 	__u32	tcpi_delivered_e1_bytes;  /* Accurate ECN byte counters */
 	__u32	tcpi_delivered_e0_bytes;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 3216d5e2657f..76202706d3ad 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3393,6 +3393,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->delivered = 0;
 	tp->delivered_ce = 0;
 	tp->accecn_fail_mode = 0;
+	tp->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
@@ -4271,6 +4272,8 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 	if (tp->rto_stamp)
 		info->tcpi_total_rto_time += tcp_clock_ms() - tp->rto_stamp;
 
+	info->tcpi_accecn_fail_mode = tp->accecn_fail_mode;
+	info->tcpi_accecn_opt_seen = tp->saw_accecn_opt;
 	info->tcpi_received_ce = tp->received_ce;
 	info->tcpi_delivered_e1_bytes = tp->delivered_ecn_bytes[ect1_idx];
 	info->tcpi_delivered_e0_bytes = tp->delivered_ecn_bytes[ect0_idx];
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 87154fd86167..5732f2d4329c 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -398,7 +398,22 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
 	unsigned int i;
 	u8 *ptr;
 
+	if (tcp_accecn_opt_fail_recv(tp))
+		return false;
+
 	if (!(flag & FLAG_SLOWPATH) || !tp->rx_opt.accecn) {
+		if (!tp->saw_accecn_opt) {
+			/* Too late to enable after this point due to
+			 * potential counter wraps
+			 */
+			if (tp->bytes_sent >= (1 << 23) - 1) {
+				u8 saw_opt = TCP_ACCECN_OPT_FAIL_SEEN;
+
+				tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
+			}
+			return false;
+		}
+
 		if (estimate_ecnfield) {
 			u8 ecnfield = estimate_ecnfield - 1;
 
@@ -415,6 +430,13 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
 	order1 = (ptr[0] == TCPOPT_ACCECN1);
 	ptr += 2;
 
+	if (tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		tp->saw_accecn_opt = tcp_accecn_option_init(skb,
+							    tp->rx_opt.accecn);
+		if (tp->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_RECV);
+	}
+
 	res = !!estimate_ecnfield;
 	for (i = 0; i < 3; i++) {
 		u32 init_offset;
@@ -6123,7 +6145,13 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	if (th->syn) {
 		if (tcp_ecn_mode_accecn(tp)) {
 			accecn_reflector = true;
-			tcp_accecn_opt_demand_min(sk, 1);
+			if (tp->rx_opt.accecn &&
+			    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+				u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
+
+				tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
+				tcp_accecn_opt_demand_min(sk, 1);
+			}
 		}
 		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
 		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
@@ -6606,7 +6634,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 */
 
 		if (tcp_ecn_mode_any(tp))
-			tcp_ecn_rcv_synack(sk, th, TCP_SKB_CB(skb)->ip_dsfield);
+			tcp_ecn_rcv_synack(sk, skb, th,
+					   TCP_SKB_CB(skb)->ip_dsfield);
 
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 		tcp_try_undo_spurious_syn(sk);
@@ -7177,6 +7206,8 @@ static void tcp_openreq_init(struct request_sock *req,
 	tcp_rsk(req)->snt_tsval_first = 0;
 	tcp_rsk(req)->last_oow_ack_time = 0;
 	tcp_rsk(req)->accecn_ok = 0;
+	tcp_rsk(req)->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
+	tcp_rsk(req)->accecn_fail_mode = 0;
 	tcp_rsk(req)->syn_ect_rcv = 0;
 	tcp_rsk(req)->syn_ect_snt = 0;
 	req->mss = rx_opt->mss_clamp;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index a5a814a655fd..7dc641227acf 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -472,6 +472,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->saw_accecn_opt = treq->saw_accecn_opt;
 		tp->prev_ecnfield = treq->syn_ect_rcv;
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
@@ -687,6 +688,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	bool own_req;
 
 	tmp_opt.saw_tstamp = 0;
+	tmp_opt.accecn = 0;
 	if (th->doff > (sizeof(struct tcphdr)>>2)) {
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
 
@@ -864,6 +866,18 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	if (!(flg & TCP_FLAG_ACK))
 		return NULL;
 
+	if (tcp_rsk(req)->accecn_ok && tmp_opt.accecn &&
+	    tcp_rsk(req)->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		u8 saw_opt = tcp_accecn_option_init(skb, tmp_opt.accecn);
+
+		tcp_rsk(req)->saw_accecn_opt = saw_opt;
+		if (tcp_rsk(req)->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN) {
+			u8 fail_mode = TCP_ACCECN_OPT_FAIL_RECV;
+
+			tcp_rsk(req)->accecn_fail_mode |= fail_mode;
+		}
+	}
+
 	/* For Fast Open no more processing is needed (sk is the
 	 * child socket).
 	 */
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f897c2594954..65b90f73daa0 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -985,9 +985,14 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 		}
 	}
 
-	/* Simultaneous open SYN/ACK needs AccECN option but not SYN */
+	/* Simultaneous open SYN/ACK needs AccECN option but not SYN.
+	 * It is attempted to negotiate the use of AccECN also on the first
+	 * retransmitted SYN, as mentioned in "3.1.4.1. Retransmitted SYNs"
+	 * of AccECN draft.
+	 */
 	if (unlikely((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) &&
 		     tcp_ecn_mode_accecn(tp) &&
+		     inet_csk(sk)->icsk_retransmits < 2 &&
 		     READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
 		     remaining >= TCPOLEN_ACCECN_BASE)) {
 		opts->use_synack_ecn_bytes = 1;
@@ -1076,7 +1081,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	if (treq->accecn_ok &&
 	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
-	    remaining >= TCPOLEN_ACCECN_BASE) {
+	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
 		opts->use_synack_ecn_bytes = 1;
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
 	}
@@ -1156,7 +1161,7 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	if (tcp_ecn_mode_accecn(tp)) {
 		int ecn_opt = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);
 
-		if (ecn_opt &&
+		if (ecn_opt && tp->saw_accecn_opt && !tcp_accecn_opt_fail_send(tp) &&
 		    (ecn_opt >= TCP_ACCECN_OPTION_FULL || tp->accecn_opt_demand ||
 		     tcp_accecn_option_beacon_check(sk))) {
 			opts->use_synack_ecn_bytes = 0;
-- 
2.34.1


