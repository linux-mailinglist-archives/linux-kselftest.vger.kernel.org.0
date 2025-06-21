Return-Path: <linux-kselftest+bounces-35564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A4FAE2BC5
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 21:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B81176278
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 19:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7847273D66;
	Sat, 21 Jun 2025 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Q7l4ds6y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D70C270547;
	Sat, 21 Jun 2025 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534692; cv=fail; b=iIC5kiGVx5ukuTEVeKsxGRpl1BZjsjXXo5w5go1wGO0qFd8OrnptUUi2lQfeFiFgL2x5HY2HrgB4wwEDsiZQYutOwDmYxc90ppnWwkPNJ2MyiPsjOlGJFWBMy+HTh+R/cES3O+Jf2NLL1oVzg3/36p9DbZSs1bAapGOqBsjrX+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534692; c=relaxed/simple;
	bh=FRoI616yxso3gaaAKTLjTvJ6f8GHWU6LeVgUOKu1748=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJIL7XEHZrmGVyf3zmtB4oVnn++jNgL7/KL2XADCmJApcKnjiLL+OyMsJjUfqLcBw6RMSjp/m25PctVtVGWbf66Wk5V58Q+nNIfvgGzapLUA2e9HeBY6NvWV9nxURHf5CSX1PP28wANvGrVls/xS5PRApYNpORa+peenYXu+pWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Q7l4ds6y; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtqGe0Njq5TuOC8uMwz4efjwudhPv0JIKpiYKzLq+RyY2NL5gIN147EpglY51NgExuvCzplOMLik0zOLwXV76gH9e6Qb4ibkkO8Ov0uZLGtqTgylq5uSL8drARgCxRvY0rfTAUXbkTslWM9jonlAegsjYmG+CXmAzbCmavrhfvAFLWUKbQMq3DZE/1hGyk7dMYsCzc13kFeEMqzBJV6HNuVsSAecmbc8XfqW5usGQmGTjP1tjGqN6SYUpYtpKcbv6QORemgXFkSE1lSPIfCcM8l6jBhMQ6XODUiqpRujvhhmzuSqzEfbzSgophbueTKZfI4YIyXqK+7zdg65rwcPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTQnRKfFU0mp3C0uMxbAdvL68jlEk2o8by2QIQj8wh4=;
 b=ZCu+5U+013txVwsc4fGrON3XxCLSTGjYyo2x5RMSTxZc2azXejCKqvhr/8mha8hVPNPkdoMdkrDW1xe1x7ioFmB8iwO0Eco3AUBt5wEQfCPWobmdhGc79LnbPPpYwcE/rUsD+sxBic9n7eLSzbb7hauZ1mEwerctfCpjK2PXhgLJW1j35gxy+LRzFAluCjZ0C3s1Zn4ExJ/GDPuJiecZ42XFUuZMYPTja2Ay0W9djDj94njkxfvr2+NuQ0SS2vsJqdI12iYSypYXS5fSCSW55SRGIRoI27qvpU+nTthZNCmDxELZ4usmdsC5NFY0buJcs/M9ipDD/bCw7x+8nv/nxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTQnRKfFU0mp3C0uMxbAdvL68jlEk2o8by2QIQj8wh4=;
 b=Q7l4ds6y3SCuuEGMlEChT2nZxkHoMPsTmsZhst2n0SGsQjvjFxRHWOyhpC/v1PB48fN2zi9N2QxEv0eFixe2I0Omt0Uykv7ETPdlkWCyXaxNchbnKdoYy7/Kr+9ei+7hWs9c85OevfU3IAPWwVaub7FfcomRqKYuTf+UsfuH2R62rH1MN/ZlZAsJ7oEf6WPZp7b1aK/twtX1Cv8WAbxA6qPzw1OKpOlQkLETta4kEtDjDa9llRu1civi0tJ2o6y970F8BYBVSB25ZHdJCE62ZMxsGZZ4hruX+L4Fvys08Ht1J/7GbwKGkhkQ6OoZTZNFaEogjei5fOrj/aLb44dbQw==
Received: from AM0PR06CA0135.eurprd06.prod.outlook.com (2603:10a6:208:ab::40)
 by AS8PR07MB7896.eurprd07.prod.outlook.com (2603:10a6:20b:397::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Sat, 21 Jun
 2025 19:38:07 +0000
Received: from AM3PEPF0000A799.eurprd04.prod.outlook.com
 (2603:10a6:208:ab:cafe::21) by AM0PR06CA0135.outlook.office365.com
 (2603:10a6:208:ab::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.26 via Frontend Transport; Sat,
 21 Jun 2025 19:38:07 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A799.mail.protection.outlook.com (10.167.16.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Sat, 21 Jun 2025 19:38:06 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 8934A1C0010;
	Sat, 21 Jun 2025 22:38:04 +0300 (EEST)
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
Subject: [PATCH v9 net-next 12/15] tcp: accecn: AccECN option ceb/cep heuristic
Date: Sat, 21 Jun 2025 21:37:34 +0200
Message-Id: <20250621193737.16593-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A799:EE_|AS8PR07MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7ea6fe-e692-4424-9b05-08ddb0fb2513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDZxakY3azk2a241TXhiMFppeE41RkwvZXk5WVBmd0UyeFlJRENWWUsraFI5?=
 =?utf-8?B?amJ1RVFmZ1h1V1BqTVdMREVCbVl2K0NhczhiaW9MQjE4REhTWXJLSUxERzdP?=
 =?utf-8?B?dHZRcU94UmFPN01YMHpqT0lmOTU4MGFNVHp1UEdJbVRWaHlGSTc0Tk1oTk9j?=
 =?utf-8?B?Rjl4RVVQV1dkYWludnZZK3hrSWRxUTlua0F4Qm9WbXhGWjFPTlhad1hTaXV4?=
 =?utf-8?B?TTQ5VUtWTlV0dEJCUEZ5SzNXU0kwL1lMMEpCR1ZuODZMNUI2V09pWWhjS0VG?=
 =?utf-8?B?VUZVcXhGMlA3YXowUGlldnBpWEdkTTl3Y1c2TXB3a1NtUmlVM1ZFVjBkWG5Q?=
 =?utf-8?B?czNEVDNuZFNlVUMvSVlKMzVHZlR4dU1yYnpobWg4cGI1Y0hnS1NRT2s2cTJZ?=
 =?utf-8?B?c29SMER2aGJuWmJpZGFSdmxwTzg2eUZTQk1FUFN6elhSZHZaTUp0MnBhaUNT?=
 =?utf-8?B?eHBZemhkU2EwdzQzbE4zeVdyUno1emZxd2JDZnBwTlNpV3d0UmNDdTRvMlVT?=
 =?utf-8?B?Z3N1VU4wUXM4M3VVU2RDKzZOMlN0RHhpWTRCNk1qcmk5MWFRZUI5QUlSTTNy?=
 =?utf-8?B?L3dwb2c3VkNxQVdFaUhOOXNaTUhYK0cwT0p5ajdKTlFITVF2dG5FR2xxcWJy?=
 =?utf-8?B?RlNpbkpWSVByZW5ESGJzRnc0cUhBd2pHSmp2Zk9BVzFrNjVveXZhdG1qTnhs?=
 =?utf-8?B?MXRWNXJUdC9jYTBoalNTNElHY1J0cURDWmZ1ZXUzV3Q0VElBUk0rZFFxMkR4?=
 =?utf-8?B?cGFyYlFiRHUvbjBLZkJQRWIwc0Y1RzN0d2liSG9sVDN1QTkxZXNEVXNraHZR?=
 =?utf-8?B?bGZnbFNCZEtad1I3SWpSdmNCTDhvdDd4ck44VkpmNjcyQjhDR1lYVTZmZmo0?=
 =?utf-8?B?VXVHUHBvVU5ZKzVYY3g1QTRGaTBmb2ptYUlYUWxRa2hNRHR0S2FEVDFRM1BC?=
 =?utf-8?B?T3lXV1ZuQXBodWVOQzlJazFIRVJjTTZXNWkzLzdzaU1vRmxlblRPUHlHSXdB?=
 =?utf-8?B?UTRza0kxbXphM3l1QU4veGlsQzdCa0N5b2gwRU9vVGIzQkdwN0hQSVhwL0Vq?=
 =?utf-8?B?UXJWaWpyRjhJUHBjenRtTFF0bWFReWV3c3ZFYlhzeWFpM1I2Vm9HQ0FqQmE4?=
 =?utf-8?B?R0JSZU9WWEhLeC80VXFoTEZYR3BGbmNQNkJKZXJrTjlUbEZmRnR0eklLSnBq?=
 =?utf-8?B?YU5maU52SlpHQWJFN2J6QkU2Vms0WTFzQ2cyMVdWY2UrN0ZoQnN0RUN3Uk1U?=
 =?utf-8?B?dzAweHZGSm5zYTZQWEozeFpCR2QxSVQ4UFBLZ2JMYjJxRVFCTFNnQnRzY2o3?=
 =?utf-8?B?cWZrcXFEVml0T3c2WHJaT0VDVkhsd2hNak91YUIwNlBoc0c3MHdCTkRoUVQv?=
 =?utf-8?B?WjRIa05tendjRTdHL2RQcnd2QzljYmNOcllSMzZSSVFSL21XdTRTU0xMcGNu?=
 =?utf-8?B?d0pwRHoxMVNCZmgxK3ZjNGhSb2E2ZVpvYmRHajlkakRHRjg4L2o4RkRMZklr?=
 =?utf-8?B?UkhJK1U2eFVOeXhsckNWMUg1UmVPZ1puZU90eEJ2VEtLY0tDdjlaMDBIZ0wv?=
 =?utf-8?B?Y0FtV0JaeE5McVlSRjRYOFdmdHJFVjVQaTVRbFJqR3NtZnJMbE5vNmFIVjJu?=
 =?utf-8?B?MXFVWEIzMHl0UFM5b01FM3JPVUN4dUdYVDQ0T2laSFhUR0lrWTl3RTZsa2JH?=
 =?utf-8?B?UEkrY05EVXIraHB5YnFWcGlpSkVhOVl6QnpxT2tWeWxiRGVDb1dxUlNDTlNj?=
 =?utf-8?B?T1RKbUgvdC9XdlZEbjA3UEdLazl4NXAyejJ5cXo2ZG8vdFl6UURPYmptR1J1?=
 =?utf-8?B?MXhYckxEaXJQcm1wQksvcSswb2tzZ0UxbnY3dDlCNzhmR0Naai8zbmdrZXBi?=
 =?utf-8?B?OUtVNmE1ZkFBS1V1aTYvVjBCMDg4RHZ6L1dWRFRoRmVNdHk0OHpNRlVqVC9z?=
 =?utf-8?B?em15NFQxZXZDNENtNG1jTFRKOFVQakZyOHJ0b1ZnZkVwT3cvR0dSNDZlK0p5?=
 =?utf-8?B?eU1ZSWE5V1BHK3RZNEhqa3FvSFZUYmV2aC8zZGVodXhieGw0QTBnVm16SkEr?=
 =?utf-8?B?KzBPSC9qeWZSSzlsL0l1TlhOTGZvWXBmOXlyUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 19:38:06.1126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7ea6fe-e692-4424-9b05-08ddb0fb2513
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7896

From: Ilpo Järvinen <ij@kernel.org>

The heuristic algorithm from draft-11 Appendix A.2.2 to
mitigate against false ACE field overflows.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp_input.c | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7ee85f6b733a..a122784d844b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -247,6 +247,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCP_ACCECN_MAXSIZE		(TCPOLEN_ACCECN_BASE + \
 					 TCPOLEN_ACCECN_PERFIELD * \
 					 TCP_ACCECN_NUMFIELDS)
+#define TCP_ACCECN_SAFETY_SHIFT		1 /* SAFETY_FACTOR in accecn draft */
 
 /* tp->accecn_fail_mode */
 #define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f415ed549339..3f8cac22efda 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -719,16 +719,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
 				int flag)
 {
+	u32 old_ceb = tcp_sk(sk)->delivered_ecn_bytes[INET_ECN_CE - 1];
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 delta, safe_delta;
+	u32 delta, safe_delta, d_ceb;
+	bool opt_deltas_valid;
 	u32 corrected_ace;
 
 	/* Reordered ACK or uncertain due to lack of data to send and ts */
 	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
 		return 0;
 
-	tcp_accecn_process_option(tp, skb, delivered_bytes, flag);
+	opt_deltas_valid = tcp_accecn_process_option(tp, skb,
+						     delivered_bytes, flag);
 
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
@@ -751,6 +754,17 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	safe_delta = delivered_pkts -
 		     ((delivered_pkts - delta) & TCP_ACCECN_CEP_ACE_MASK);
 
+	if (opt_deltas_valid) {
+		d_ceb = tp->delivered_ecn_bytes[INET_ECN_CE - 1] - old_ceb;
+		if (!d_ceb)
+			return delta;
+		if (d_ceb > delta * tp->mss_cache)
+			return safe_delta;
+		if (d_ceb <
+		    safe_delta * tp->mss_cache >> TCP_ACCECN_SAFETY_SHIFT)
+			return delta;
+	}
+
 	return safe_delta;
 }
 
-- 
2.34.1


