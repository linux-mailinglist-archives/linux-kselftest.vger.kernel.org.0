Return-Path: <linux-kselftest+bounces-37576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DDDB0A637
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 16:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B1D5C0DB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 14:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C27A2DCC02;
	Fri, 18 Jul 2025 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="d5nV3MgV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011065.outbound.protection.outlook.com [52.101.65.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1492DECCB;
	Fri, 18 Jul 2025 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848475; cv=fail; b=C3Q7aKeeW79PwDHrpRQMxXz5vKgD+5JhsHLF68akBoi7Z+2kMWGwld7ReWVka1gq4vmZGy0Rowa8ctrHT9kEUgEQfkqRnvbnfGe6LcETgkckHmqGIt1IvQPJ/NAvOJCGDHo+S98pFkDRiZGmsHB5JSUs41AQPcZavS19XGHdeqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848475; c=relaxed/simple;
	bh=LflVPNgNrilt//sbnUb/RZv0ETlP392JMFmApbgITX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCXYBiDymIBuU2Y383+1x2GzFJJR5N4FC/VUTTlopmk5bxrPAW1AZOixYP6ADYahVbHKeziLb9HI4QEVR1FjkUVQaA2Zom1aISK0gXVBnRWSSFIOaiyfZ/BSK5G/D60g/BC3IdSJ5YYXGDbpu5rsYEFHq+KZlPTtdr8ALdrafIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=d5nV3MgV; arc=fail smtp.client-ip=52.101.65.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRT+9WykXkzQa91LR9UIQDlmC6SS3YImyGp/k276LNiA+C5eYMOMEHlwN0FGEJ8bqfCimuHgRRinjanlGQzPC7+4LZ72hPBucpACnIeDzEeRSgUS0ith2+NO4Ixf0VnHuK/Y5ZX8jDpYft3EOdFVG2WxVaTf62hlRZ8EcOYRmI8usLBlKYw50pQiKAvdysrY+oR+P5FrLoA5VK0fA/UWl9iYyiI77dnzWIc4/W9qudLtXkJfr68AACZIZblmcthUFkj/OBnLSiSwdTKslvLeWmyXfd0ouj9oUuRgeYW5JE0/SfTpW3IXcvFz0XtVaWMrYT61wfEyxGZnQJgZRqIYZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvwT2YQJEsz2QCh890zN26zOtJFG39k6aUjzDNrgKLc=;
 b=NO3pRCHaEi98Ztt9+sFmCbEfFldekj4oYjKQ5Z3wzH7ziT6+EIgulAR5rXR/lAMoIeREad7ktEe7ZkA2drk2nArWdJWOc71z7qsmIeJ8HibKhVpruteeO+jpvm5dxUGpS2ij1PYxjMfIpVsNN23/1ci4FgNd/FLCOms5WaXZnst6e6O/LqiPvztbaM+qYylahcfW7aruLZdNmyn6/v72WwxWkVqJCQ+ZTeoSF8UEye2qIFsFRAuVc6Nmb3XFJrAQ12Uw7y/ksFEdhaIDPb3uzGKB4FfesAnY3clqUBwoyqDGGZccM1+9eSYLk9YKmuSEZprBSuGL4N7Z/gZ1ao9XOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvwT2YQJEsz2QCh890zN26zOtJFG39k6aUjzDNrgKLc=;
 b=d5nV3MgVcXMmcHMH2WoNTFm+bYpURsYGq7MN7sHcNYUmJKctEnphBngLpGMJTlhkzFxH5mjngHJBcv9Jw4jlKQkBQ0tWGYtI/16Pf5QNbELCkZ4/M8Y3iCpk6Ye1BfPrfG0Q8gjaLPK4PJJq+0O58VIVFXLraOwYdA5+glIjH+8blT1280WNihz6ydrJH9CujweTcDUnJswYtZr1nDWYDPHTYxZ8vJid6rWrY+4vj9IZNacBuCNWfnmH8FPDtxiGI5kCJW+uqr8a1uVVBcQ8zQEo7StOjA5NhD1f9wCCj1CIX/xxU5DohnyrzDUCQmhx7LX+zhQ3SCZLyaUhlWEBFw==
Received: from AS4P195CA0012.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::18)
 by AM7PR07MB6995.eurprd07.prod.outlook.com (2603:10a6:20b:1b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.41; Fri, 18 Jul
 2025 14:21:11 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::7f) by AS4P195CA0012.outlook.office365.com
 (2603:10a6:20b:5e2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Fri,
 18 Jul 2025 14:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21
 via Frontend Transport; Fri, 18 Jul 2025 14:21:10 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 2189920119;
	Fri, 18 Jul 2025 17:21:09 +0300 (EEST)
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
Subject: [PATCH v13 net-next 12/14] tcp: accecn: AccECN option failure handling
Date: Fri, 18 Jul 2025 16:20:30 +0200
Message-Id: <20250718142032.10725-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|AM7PR07MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 775806a5-8950-4a8d-2597-08ddc606581e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tk9GOXJ6ckMzTjlhWWhKVmVWTnBwZW9xUnM4L2VFMklZNlc4WWhsMjA3cTQ3?=
 =?utf-8?B?MWRWSjAyTXNZT3pIaEkvT2wvZ0pjcHI5emRsU2l6eHVFMFNLeUtTb3REQ1Ex?=
 =?utf-8?B?OWNrYXdQZU9MRnlMR3dRWXRqMzBYbEIyblpLdGVkRVNQSnEzL3NOMHBKUkVV?=
 =?utf-8?B?Zkk1ay9XNWs5c3F6Um0wMnJhS3BuQnZtbGdoWkdHSmphQnp6elBTczVCSU1R?=
 =?utf-8?B?d0FjT3hOVHdPbmlxVFk3K0xxWlhwS2tlc1hiUy8wTjhQaVcxVHFrWkxWbURi?=
 =?utf-8?B?UGpNVWlZTUVhOWZpTERXNVYxTEVYdmdqdnQ2ODUvRDRiTHZnd0ZidU9vOUZk?=
 =?utf-8?B?OFc5ZCsrNm1MWktEUXhvdStBUDhEYzdaQ0MybWlLTjIwSnRpNzMxNE42VHRE?=
 =?utf-8?B?aUVqNjgwNFNvMzBqQ2JwOE1WYWx5RTdLYUEzNnFwUTNKWGxPMFF5Q0Z1c1FO?=
 =?utf-8?B?cmhCSnVzVkgzaUVpU1NMSmFXczFsOC9OWnBjS29EVUl1cDByejRCWWdzdy9z?=
 =?utf-8?B?S2ZuSjkzN0NUWGhla3JNREZORUNsY05WQTA4OVhQVXhMSDdONjJoMDBBK0wx?=
 =?utf-8?B?Rkw5dzlmalhjVHBPVDhNU0llMXR0ZDlScndLWW5tYnV2U3gzaXNaZG90SlNr?=
 =?utf-8?B?TUEybldhenBiSzlhYitzQWZ6c2toVFJjWVFPenkzS3dXVGozK1NKVGJVYnA0?=
 =?utf-8?B?SzRGU0R0MXdJdWp3UVdTckg3NmZ3QkVkQjRRRjFBbHp4UzJqMHF0Ymh2NXEv?=
 =?utf-8?B?eWdXQzJHT1BxMVVvVWFtaFJKU3RPN3QvOVI2Z1dVUlRQTzJMUHZhdkRYSktU?=
 =?utf-8?B?VmQ0MTlmTDZXakhBVU1uRlVKTUM3dWRMRGhQTjdza2hsZ0JxM1d4L1NkUlJy?=
 =?utf-8?B?UHdKTE55dTVVNDBiL3cvUys2RHhQRllENG9nNklLN0QyNEZQSmVrV3gzS0R4?=
 =?utf-8?B?RFRSTjFyRGlSNXd3U0x4bUJyalJmZjdkSnNkOTBobWNUTUpqWWM0cjdmc054?=
 =?utf-8?B?YW4vQ25Hc0psTGpFT2xteXk4bHIwc3QydzNBei9HWVQza0pFWHgzN3RwN09T?=
 =?utf-8?B?YjNja0EzVkl1QUhWRDNrMHdSRFRoZ2lxRWloSHBxVW9UTHBSZmhjYWJZUDZB?=
 =?utf-8?B?c0I2NEVWeVFZd3ZKQTdXazJRb29LelJWbnVmRmlDSi85dFJib0JwUU1QamtN?=
 =?utf-8?B?ejRmanVxUWpUUnhYU0ROQ0lGYUlKZU5yNHhhMDcyUU1Hby83bmhTUjR3MStE?=
 =?utf-8?B?YnUzdExLMHBPQndEYTRtNGwzNjhEZXdYRDFWdEVicXdJZithclNOT3M4R0FQ?=
 =?utf-8?B?RGdEYjJXMHdUQS9SZGFsbHlQOHNGWldGcHd2S0QwTTdtRGFHc3FzL3BnRlBh?=
 =?utf-8?B?MFVHWm9xdDE5SklsZ3RESVNtL3BwSWZQWkxvQWJzV0xjeUNxaDBhdHRTa2lh?=
 =?utf-8?B?KzljMHVlWkJrblRiZ1FDV3FQNTdzVk5LclVGcHdiYUdzZUNmcC9NUmEyK25v?=
 =?utf-8?B?cWZQRWk0QlpXTFVDY083VUR1eXdOQzU1SUpaQWVUY1RoeUJOZ2hENEVpaUJw?=
 =?utf-8?B?K0JEZUFGejRqYzF2azlTaGJZWDRFL3VFN0JjRzlVeG1odE9tUDMvQjV6UVpm?=
 =?utf-8?B?eU1sdi85U2FKUXRjUld0eWxxdEs5YlN5VjhBVDZkZG5VeVdvZVhzNVpiRWxv?=
 =?utf-8?B?WnJVU0pZNzlTbjdqWnBjczVQRHRhanArU0svTmlBb2E4eW1USWZ1STNrM3Qr?=
 =?utf-8?B?ZmtzTXRKNUcycURtMXFkbmZ0UW0vMElMc3ZlTytJcjBZWnJ5cmNXbm5DL2FH?=
 =?utf-8?B?Nk5ZOGl4bURHVlFvcGM5VUVBeFlQTzcvaUtoS0RWNkZkclNhSEdRMG9DOVI1?=
 =?utf-8?B?bDR0bTI0eGdQQkxmeVB1NUJoTk02RHErYnkzVUJ1NDFjR0d0VmJhVU5sS3N0?=
 =?utf-8?B?Q0E1YWM4YW1URDRoaVhGaCsxQnVmaUlrNTdkMTVLWFpBTHE4L3JmOTRSNFll?=
 =?utf-8?B?eWxOWmFEaXlicHdDOExaQXFEZnhLby9ETFZNY3EzamhNdHU3aE5pSk1LZEpi?=
 =?utf-8?B?bHVNMGlZU1g5WGg1VnFxdVdWc0dHZUxhaDZkZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:21:10.6258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 775806a5-8950-4a8d-2597-08ddc606581e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6995

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
 net/ipv4/tcp.c           |  1 +
 net/ipv4/tcp_input.c     | 35 +++++++++++++++++++++++++--
 net/ipv4/tcp_minisocks.c | 14 +++++++++++
 net/ipv4/tcp_output.c    | 11 ++++++---
 6 files changed, 107 insertions(+), 9 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 3934961c9b33..7e6c68503a38 100644
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
index 5e3f91bbd317..f1f20045f12d 100644
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
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7002f6347119..4eb8d6889763 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3392,6 +3392,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->delivered = 0;
 	tp->delivered_ce = 0;
 	tp->accecn_fail_mode = 0;
+	tp->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 1a8c40b573e4..1098929a4246 100644
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
@@ -6115,7 +6137,13 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
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
@@ -6598,7 +6626,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 */
 
 		if (tcp_ecn_mode_any(tp))
-			tcp_ecn_rcv_synack(sk, th, TCP_SKB_CB(skb)->ip_dsfield);
+			tcp_ecn_rcv_synack(sk, skb, th,
+					   TCP_SKB_CB(skb)->ip_dsfield);
 
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 		tcp_try_undo_spurious_syn(sk);
@@ -7169,6 +7198,8 @@ static void tcp_openreq_init(struct request_sock *req,
 	tcp_rsk(req)->snt_tsval_first = 0;
 	tcp_rsk(req)->last_oow_ack_time = 0;
 	tcp_rsk(req)->accecn_ok = 0;
+	tcp_rsk(req)->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
+	tcp_rsk(req)->accecn_fail_mode = 0;
 	tcp_rsk(req)->syn_ect_rcv = 0;
 	tcp_rsk(req)->syn_ect_snt = 0;
 	req->mss = rx_opt->mss_clamp;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 848c756a37b8..fd80e24ea30b 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -473,6 +473,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->saw_accecn_opt = treq->saw_accecn_opt;
 		tp->prev_ecnfield = treq->syn_ect_rcv;
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
@@ -688,6 +689,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	bool own_req;
 
 	tmp_opt.saw_tstamp = 0;
+	tmp_opt.accecn = 0;
 	if (th->doff > (sizeof(struct tcphdr)>>2)) {
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
 
@@ -865,6 +867,18 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
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
index 3c755a6d0f9c..a309fb87bd49 100644
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


