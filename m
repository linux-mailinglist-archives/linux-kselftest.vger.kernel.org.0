Return-Path: <linux-kselftest+bounces-36271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB75AF09F7
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 06:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1922A1C06371
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 04:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EDA22257B;
	Wed,  2 Jul 2025 04:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="nzIgD2jc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670001EFF8B;
	Wed,  2 Jul 2025 04:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751431078; cv=fail; b=XvVFdkMjJLvh9sqO5U677qfII0AKC3OgOg3W/NRS5k9QlB4sSMheU6bwZIj0D16bk96Fwjli8Ja6uf2aGVwhU6pHsuKUxMui2D7Kgwf6YIeUVrxaX+spxTAyAko1xkMdjAwEUy2rT1Q54H+VMhQX3+4KeJB891bpc3QwuRxr6xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751431078; c=relaxed/simple;
	bh=DMGRb3RB900YnSeibBqTvGKUd9QEzgrJW/Ki0UxN3w8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQM8oUO9R6PnWlFtiKa//XAFthlBSiZhyicQVwVGZR9zN68lc2Ih0HcKoE5poiC8GK4bCm4p12K/EXjNlF8rj1Cef3aX1PApXAhPGixQ5l+TZveLJOazxwA7ZgrZNXdDk+smPawBiLaeikAW5SpdydATBkDFKlf5p4lve6cnhsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=nzIgD2jc; arc=fail smtp.client-ip=52.101.84.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eY73EFSaDnGeWzM1Rz/BG3D9iLrLPC9j7Ps6+65XMq8IEZK/ENRgOx0QZk448N5yc/+DcY+7cOvmAauSyonF1y/Xp5KUX3jFusy36cdjquYDD00ZMZsT6aka4gkGwEHrqvwvYyqguhNqAS/OkdV25sTHd0eLkOf6On9TAcThft/ETbOVUryujxiPSDdyzTSBb2wz9ZFqOcAfUw7s3Uh7/gr+WLO8F14AhByQoak5bp0seDiH6WurcK+K7FtUh33AKVghRn7ejzCCFB6Iba91gpAQZm7VJoZ5qS2tsAKNUsWMNfH+XNseJEdHmHC1La+gGtXPMJcVGTKfxx910NcVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzSxPc45HM6ktl9tTU664k4Zpn1exUUs1AAkUm5HNsI=;
 b=km9gr8HByklu+RVo/1Mbb25m16ThDjUmdetLl0Xl5ZFni2No2jzoP7gjvwuUpQ11SnVp9+OgyoaoKWVM/rxg1GNQcLoEprDOkfe9YJCzMM5Sn/9dblOmfjpNPvAV+psYwOFS/M+jmQuN8rpisZhizH7d/nUYIUn/i0VRNgRfYtghmGJV8eacGwR+3aIJVabqYB/fJd4RVSyF2coZZB1YMDhQ0AOPkk0ijIcvLGPV2XrOliV7BO4mG/9O62G2ZEOZdpIlB4VfAxYMtFrG9UgOAiwowtzc4d8scX6DWuc6bArDUlcSSt5KQ/l1ef0wcN22A5Sc5/dltkRzKjwhOwnUOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzSxPc45HM6ktl9tTU664k4Zpn1exUUs1AAkUm5HNsI=;
 b=nzIgD2jc693cCZ0ozHquhP7/qRT07qU0oVOJnUB3U+gMz14fNGxPYBev2tByK3faK4/kOyHiKQbwIvbVmbG2FDwKlCmgA3EuR5sSi9g9lLbpyDxtAIM/nrAM+qxAbJXRXIzjALL7A93+e7SaOFhPQeeW5KdPnPqvqeo9VuyvGQCum8mk/UR4dcnS0SeFpM/52xID0IKaQhW/wSVpER83aHl69kVhN6jh7G7PHVUxRWFBgdBZ+z77n2hzoIkBIpWdIgusb88kPptMBQGQtTmWQ3shDJ8y8pZiXx4+zfIN0KFmTQBqKCQFVRBzTvb4nmhudywW4ujmhM4JnUnQzzZ6aQ==
Received: from DU6P191CA0051.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::7) by
 DB9PR07MB8010.eurprd07.prod.outlook.com (2603:10a6:10:2a6::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.32; Wed, 2 Jul 2025 04:37:47 +0000
Received: from DB5PEPF00014B8A.eurprd02.prod.outlook.com
 (2603:10a6:10:53e:cafe::f1) by DU6P191CA0051.outlook.office365.com
 (2603:10a6:10:53e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 04:37:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5PEPF00014B8A.mail.protection.outlook.com (10.167.8.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20
 via Frontend Transport; Wed, 2 Jul 2025 04:37:47 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 7E9A71C003B;
	Wed,  2 Jul 2025 07:37:45 +0300 (EEST)
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
Subject: [PATCH v10 net-next 13/15] tcp: accecn: AccECN option failure handling
Date: Wed,  2 Jul 2025 06:37:17 +0200
Message-Id: <20250702043719.15130-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8A:EE_|DB9PR07MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9af1ed-a176-40c5-80b8-08ddb92231c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NURkYWkzeFRlQU1HVW0vU0FaZ3FXc2pGbE4wdkQ5VlRlSHZ2WjN0OXBlQmRj?=
 =?utf-8?B?QjBkN3AvL0VnZ05MbERySW5pU2JrNjhKVWRwYzZmeWhabCsrVXd4TWVmd2Zk?=
 =?utf-8?B?Rk83Vmw4OTJYMmRwY1RreXMyLzQxYmZJWmxYMmp3OFdwL1Qwc0pjWTFiUHRM?=
 =?utf-8?B?NEF0Y25wR3RLRDdGWnJVRjZwVFYxV1ZiNzVoelZoS2cvS3pwU05HdGJhNzlU?=
 =?utf-8?B?ZUtqT2JEMHg0T2FCcmNWZlEwM2pKaGp4ckkrc2xWOEZoNjRKNzVkRGhQUDc5?=
 =?utf-8?B?cVhYdmlqK0ZmUDMrelZEbG1rTUttU0ZPRFFsaHhyWEZoeXNRU1FaakJEUTVV?=
 =?utf-8?B?cFZaaG9mSFBYTXcvWUlqdDgrRUpYZ2hJeTB0VytZdXdmOS96SnBVbjFnejB0?=
 =?utf-8?B?MTk2S3JxMUZUOHhtdFpGeGJlYWorOVg0Ry9LZHlMc2VpYnhKQ1hPOU4vSzdD?=
 =?utf-8?B?SFBqRElXRDNXWnZkTnpqVEZMZ0NJZXhDbk83Vk9OYmQvYXQ2S3lOTXhtS0w5?=
 =?utf-8?B?ZnZ0RHhqbTVxR2ZEbjcwSlh6eWsxRTdWTTJSUVZyRHhLTHdXT2RhRHk5WFo4?=
 =?utf-8?B?a0loOWgyTDFLb2szRFlmQzdlVlFCYjVwZ3B6YmNYTEpoS3Z2UFgvZmErWnAr?=
 =?utf-8?B?OXBsdEpmMlZCYmFzRE5wZDRIYVRYNEgzWGM2VTlwZ01HbTN5alZ1TUhMVDk3?=
 =?utf-8?B?dmRHYUpUcWNnbnpWR3A5cFRJT2luZERoODUzWXhieEhydjBScEo4SmlCdUlQ?=
 =?utf-8?B?TDJONUMwYXFXM1NYWW9udkYrMnN4YlQwai9oVTUycytPOVRhYlhBU24vWktV?=
 =?utf-8?B?cDlma3ZEaVhLaEJNUTBLbkNJalNmTTRrcTdtM0tjdnZhU2NuMTVCNS8yTFhR?=
 =?utf-8?B?R3AzWWxIcjQ4VkwycTBiTUFSem9raE4wMndKNldGTlNOeTk0UkhpYkwxZkFT?=
 =?utf-8?B?NExmSmY3blhBRm5FQXFnSUdKV3RBaEFkRnZ4eTN2ZHAzeUpIZ2FFQTd1Q09a?=
 =?utf-8?B?R093U09oRmVzdWN1Y1QxL1prSGtBcWR6VlpXcUhOYmg2UHJpZkxyRjJQQzlJ?=
 =?utf-8?B?ZTlPUTNDRnNBWTMxekU1WGptN1RNZWVmczV3MjVRYjFaSTRnUUN5T3Njd2Jl?=
 =?utf-8?B?Y2FyQUZRSDByUSs1L3pmV3VzdkZvSnU1KzJnUlJrNVRjc1FrSEVmQm5EN3Vz?=
 =?utf-8?B?YTFrZ1Avd3d3ZHFPVWwzeG9yVXU3YU4rcm1EVkRDVUsvaUpJY1o4QWdvWVhE?=
 =?utf-8?B?aG5pQnJ4WmxqVVhIR0huWnpOdW51VWFkK3M3b0U1WDNUNzhMak0yRGUzNm1r?=
 =?utf-8?B?MTZSQ25QMjZ1WnVuMnJJZzYxbzFLWi9oeWQ5aDBRSVZ3c2pmMjViRy9MNGhy?=
 =?utf-8?B?MVdCME12aVVDYlFwL3hQUlltaTZySTYraFlWZTF4bGFydkpVQlFJZXhMelZw?=
 =?utf-8?B?bDc4eGhjVkpsOUJ4cWxOdUhJbjE1dE5qRlUwd2dTTlVCRjVzZzlreXdLNUUy?=
 =?utf-8?B?bUNoYUxPakdnczIvZnlYdDFIb3pHYUd2OFU4UkwxOEdtck9pRlJDdmFEMnNv?=
 =?utf-8?B?QlhlQjVPeXphTUUvYURsazEyUnJIVGJ5enYwS1RJMEtGeGc0Vm1XRU02ejho?=
 =?utf-8?B?cDNaZHFHeWswSmwwWVlyem5RdW5lRzFyMG9PcEhEVVVIK1dWblo5enFYSzRO?=
 =?utf-8?B?UDZwYkhXb3dXYXZ3L01hNlZ5a3NGV1NHTi91dHhrSlFTdlYvc1FYNWMrQ0M0?=
 =?utf-8?B?Y3Z6UHVsbnExcUdlSVBmekRYR25hYmVpazM3M2VaMkdqRU54OWV0R09KSmtx?=
 =?utf-8?B?QnArelZQNi9qakg0clNPU1lSMk9TbzJtN1F2cjN6VG5US1BMVlhmNWt2MktE?=
 =?utf-8?B?VXVxM0F5ZGRuenBxc2hoRFFVdFUrWTRnQXh5elR5YmpXVE1JWXJqeEZXNVFj?=
 =?utf-8?B?SlRBL1hBZ09tNGsxbkJPMDBHLzB6amZBUGM0RGFKaGtleW1EQWlyaVhNQzNV?=
 =?utf-8?B?V2JjclVzOVo1QXdWbG9ma25CS0MxZHRpanVsaVJFbWdHNDVtL1RtSjFvMWdY?=
 =?utf-8?B?Y1ZKa09nQjE1YzBnSUh3NHlUaWh0M1EyYlNOZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 04:37:47.0908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9af1ed-a176-40c5-80b8-08ddb92231c8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8010

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
v9:
- Add comments about the 1st retx SYN still attempt AccECN negotiation

v8:
- Add new helper function tcp_accecn_saw_opt_fail_recv()
---
 include/linux/tcp.h      |  4 +++-
 include/net/tcp_ecn.h    | 50 +++++++++++++++++++++++++++++++++++++---
 net/ipv4/tcp.c           |  1 +
 net/ipv4/tcp_input.c     | 35 ++++++++++++++++++++++++++--
 net/ipv4/tcp_minisocks.c | 14 +++++++++++
 net/ipv4/tcp_output.c    | 11 +++++++--
 6 files changed, 107 insertions(+), 8 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 2c0a2db6e6dd..8609fb138108 100644
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
@@ -408,7 +409,8 @@ struct tcp_sock {
 		syn_fastopen_child:1; /* created TFO passive child socket */
 
 	u8	keepalive_probes; /* num of allowed keep alive probes	*/
-	u8	accecn_fail_mode:4;	/* AccECN failure handling */
+	u8	accecn_fail_mode:4,	/* AccECN failure handling */
+		saw_accecn_opt:2;	/* An AccECN option was seen */
 	u32	tcp_tx_delay;	/* delay (in usec) added to TX packets */
 
 /* RTT measurement */
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index d4c4f04a4ee4..be189601b2fe 100644
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
@@ -151,6 +156,14 @@ static inline bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace,
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
@@ -427,9 +440,34 @@ static inline void tcp_accecn_set_ace(struct tcp_sock *tp, struct sk_buff *skb,
 	}
 }
 
+static inline u8 tcp_accecn_option_init(const struct sk_buff *skb,
+					u8 opt_offset)
+{
+	u8 *ptr = skb_transport_header(skb) + opt_offset;
+	unsigned int optlen = ptr[1] - 2;
+
+	WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1);
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
@@ -468,7 +506,13 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
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
index 797b7121e1cc..c1bdbb241003 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3396,6 +3396,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->delivered_ce = 0;
 	tp->wait_third_ack = 0;
 	tp->accecn_fail_mode = 0;
+	tp->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 103260fc9130..5a8f5ca9efde 100644
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
 
@@ -414,6 +429,13 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
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
@@ -6092,7 +6114,13 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
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
@@ -6582,7 +6610,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 */
 
 		if (tcp_ecn_mode_any(tp))
-			tcp_ecn_rcv_synack(sk, th, TCP_SKB_CB(skb)->ip_dsfield);
+			tcp_ecn_rcv_synack(sk, skb, th,
+					   TCP_SKB_CB(skb)->ip_dsfield);
 
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 		tcp_try_undo_spurious_syn(sk);
@@ -7157,6 +7186,8 @@ static void tcp_openreq_init(struct request_sock *req,
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
index 65ef1c3c97c2..560b0ca54bb8 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -986,9 +986,14 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
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
@@ -1077,7 +1082,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	if (treq->accecn_ok &&
 	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
-	    remaining >= TCPOLEN_ACCECN_BASE) {
+	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
 		opts->use_synack_ecn_bytes = 1;
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
 	}
@@ -1156,6 +1161,8 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 
 	if (tcp_ecn_mode_accecn(tp) &&
 	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
+	    tp->saw_accecn_opt &&
+	    !tcp_accecn_opt_fail_send(tp) &&
 	    (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) >= TCP_ACCECN_OPTION_FULL ||
 	     tp->accecn_opt_demand ||
 	     tcp_accecn_option_beacon_check(sk))) {
-- 
2.34.1


