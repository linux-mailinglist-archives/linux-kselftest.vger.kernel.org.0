Return-Path: <linux-kselftest+bounces-37826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48290B0D6C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 12:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0C1562B91
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 10:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57D92E62A7;
	Tue, 22 Jul 2025 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Rky7J0+x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013040.outbound.protection.outlook.com [40.107.162.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC24A2E54D2;
	Tue, 22 Jul 2025 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178404; cv=fail; b=hhDrU0I4qgTJEWss0KOQYFNbqAtKjlZq+Yu0eEMqr+mmH/bueEXpOy6j3h41bLGhsZDVgW02RpQZrdkcmsUIKMz5ePmVSdg39FK2tdo7ont8MUSuwtdy7oemWuqq+gkqaDpIHvI93lnenH96fTJs1bgKGxvjnkQH9AwPNK0BSAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178404; c=relaxed/simple;
	bh=nZ9BCtT5Xx0y8cY6cTEi4wZQPsnXr6DdN+JIdxZEi/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6DPvFwOjn34Z5IXULoElP13edBnhZ1kF7LFGSeZ6xvLKq3LCZT6j66W83awIL6FCbNET+iZ1Hq4vAbXJDYFV7lcWEPZr+MQ0fo20GcfynlMrE3ScCes/wJmt0jX88QWf9Du4pBPEnkKaoXIon3GxzSd1vmc6jQSRi8EtVqKohg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Rky7J0+x; arc=fail smtp.client-ip=40.107.162.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIqaOjZcHX2dFbLnJIV6k+J0xLS3fDWTiTJ/CRzTY4jeQOvL25yfkXX2193kjYbZHNm5C/Y36soHrQKb0xwGk7oFpOQOj9D5h9xA3ypdaqnjg/iTGCauiUu4PCTx7tItC5uoQlNuQok+9wiba4xFIND6ctlmzMvVMNYpEEON+6Q1A7FSajZQJNzEp36uNSxdvGwY3QqQh7eaIs7+w6fkPBwDrobjv7LbYNWee88imK9SmpsWyAzq95ygtLzzNqOexWLuFtRY0J6dw2JBsuROMvdWjUG5ihJrctSts3bfGAijhcT+qnxb6yMlJ6pBbtfKrQH/95uZ4ufP1UESkd5+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zQIzSUqVyryLf5W+vAYwpW3CZCp4VmidPa+5yTyOkI=;
 b=TruIvqt91gme7Frx6D3MsJ1fVfIld+8HKxyEJt1to0QmC0bbtenv9SFMJBFZDXJXN3fzIqshB2Me2Jfa8eKbs1WrUE31VfBUA/n8m24+TfkcwzhJRP5C7PiA3Nsmn/zHFnr/P3gJAkDokr5QmBvFDHFfjMejzWQDF1RhpHSOAS91W6uvEzlmbo24f8uFHAuos6SNU2ESCm/Q+QZOyXHBeC/5gIq5/pJd17+xURgQIzq4GGzplaXNCUnGXEKSBjFQBAFCQjOKwdUshJWg/FJvaChbyB+I5UrlfgqtZyiRDYUwj26fL0i4x6zt7clI2Wx/vLaF8XYFfmx9Xe+Bkabdgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zQIzSUqVyryLf5W+vAYwpW3CZCp4VmidPa+5yTyOkI=;
 b=Rky7J0+xnf1Pv4uRQkATX8JeAbYF/MRjNhOhvNIqG5vJ7PsQLJmDAcW1npBG87xqiv5PYhYctLrBh5wKuobz/ZKc/+lpNzify1agJ4+i9QAwGlwDRa/jBT3g6c93EL8faS9qXOtd+rhtUxygqt4E/+k5KrLI995PF4f6rV7jaxOnbhf2CgvZ5gxVIYPGmjE8rlx9QZZrxVZn3EOMZrCmr6jkdNylogoxz9UoEzGj6HHIsBzqc0w+y2KfwHOem/PBS/xwhGgaSaFdSAAQaAcROj9n9AnP4yzFy/Erf7B1I60QtwfsxjWD6lItfuPgl7LnU2PR/l5hTV/v2ud9ID/nQQ==
Received: from AM9P250CA0027.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::32)
 by GVXPR07MB10193.eurprd07.prod.outlook.com (2603:10a6:150:215::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 22 Jul
 2025 09:59:58 +0000
Received: from AMS0EPF000001A6.eurprd05.prod.outlook.com
 (2603:10a6:20b:21c:cafe::5) by AM9P250CA0027.outlook.office365.com
 (2603:10a6:20b:21c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 09:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS0EPF000001A6.mail.protection.outlook.com (10.167.16.233) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 09:59:58 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id EE204680046;
	Tue, 22 Jul 2025 12:59:56 +0300 (EEST)
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
Subject: [PATCH v14 net-next 13/14] tcp: accecn: AccECN option ceb/cep and ACE field multi-wrap heuristics
Date: Tue, 22 Jul 2025 11:59:30 +0200
Message-Id: <20250722095931.24510-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A6:EE_|GVXPR07MB10193:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb0e371-d1f0-4244-41f4-08ddc906846b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RisxcC9JbUlNUUorcU9vRExHWVFYLzV2dnZZWDhFZFJmY1BMWmc1TkMxbUV6?=
 =?utf-8?B?UUFCcTEwQzdCUFBGUitpK3d3Ri9XSzE4N3JNZTdaMzhwOHBBaUhBdlpmckFS?=
 =?utf-8?B?K1JVYTBRVlFHdmFOWXd6SGJYb1prSUVvOUdPcUV6aDc4QzZyWnk4dTVGbjFC?=
 =?utf-8?B?NjJFbHJxZXoxVTZNUmUwbERIK290Mi9lclFVWno1RHJwbHFYUGZDMDcyY2xW?=
 =?utf-8?B?QUdDNTJQQjBYdmNTZmFHcW5tR1N0TXdSc0NndFlZQnJvMDhFNnFDam5CN1Bl?=
 =?utf-8?B?REdndkRuMFZwemozbndyVmdtYitnV1ZJSUYvVWdhRHQ5dkpIU2h2Z1kranBD?=
 =?utf-8?B?b0Z5RXY5NndyYlJpVTdobEtPKzM4bjM4bWdDZk9jVGZOVmtidlVBVUVtYjR3?=
 =?utf-8?B?VEFhcXFpYllyTHZoc2NsQm5ZRGVjRDRrYTNzYlROdm14U2FIRVAxQzRNOHEw?=
 =?utf-8?B?Wmd1YVJWN28xUUFSVWwxdGhuNi9Yek44NWtnQk5rcmY4aURTN3dpV1IyTXVo?=
 =?utf-8?B?dlVkd2lHYkE5bGppckFFTHUxUksrdVpQeTJXdjR6b1BESDhRRFF2WDBBZUhM?=
 =?utf-8?B?K2w3Rlg5eHJwVWhkSlNaaURWR1gwcWk2Y2h4bmtWUTFvTVpZcEhIaGJrd3ZL?=
 =?utf-8?B?dEVYRml0TVNDWVh6RXZMRTczRkgrOEl0SlhWbFFLNkxrN3FKdnZsQWVmOEs3?=
 =?utf-8?B?azZqcHZWWk9IckZ5aGZFUjJHZm52QTJDY2ZQM0Q0ZWF2SWd3RVl0cGVRTyti?=
 =?utf-8?B?TFJLaGQzTDMyZHI5a1ZOL0FwcE5jUHNuYldmRWFlUk9OaFd5SVpQL0E2K0Zu?=
 =?utf-8?B?ZkNBTGJJS0pOa1FQbCtFVFJ4QVowRG5YS000a0VuUjJiS3AzM3VQa012SkVD?=
 =?utf-8?B?czdlT09VeVlEbjYyUnhQNmttaTU5UU90SEZoRzdBTmZSckl3T0VCQmV3Qmlj?=
 =?utf-8?B?TmFWZUczd3crU3orTHlrZm1GdlUxdDhFcXBQZXRKL2tJSmZOTy9LTXhHd0Jk?=
 =?utf-8?B?WDlCb0pLZUVKZ0dNVEw0VThQR01wVEp3OXNtekJkWkJaRm1MdlNJUC9ZSEgz?=
 =?utf-8?B?UUdTZDhnUi9zMlJDQ0xzSE9QNE5Pa3BBcFNnY3RFdGpvMTZhRTBkM0swNy9L?=
 =?utf-8?B?UVMrVFpoN3lOK0RlaUJoUFJKTzBxSlNJck1TL002RkJreWl1Qzd0am1BUjMw?=
 =?utf-8?B?MFdsdmtQU0Jhb2tuQkZBUnN3dDFFdEsrcW9zMFlRZnl0bksyUWxYRHJhb1BE?=
 =?utf-8?B?UWloc251K1k2UDM1UlFXanZjL1F4UDFmUlZkcHRyd3pNM0E1YklSZmY3RTAx?=
 =?utf-8?B?WWU3TER4SmluUzVYYUw2Vjh1UmY3dnRlKzJjTmovRUhmbEx5Z3gybEFlWkhP?=
 =?utf-8?B?ckM2WDBUc1B2L0w1VndYT0FWeVRkeG1Hckd5SEJsRnFtM3orY3ZjSEp1U1VP?=
 =?utf-8?B?Ny9rMDNMSU5LWHFPMDVLN1hxd1E2bG9vOUNaUjQ0Y2JFTE5RS1NXcnVnZ1A5?=
 =?utf-8?B?YlJwdXpqSXJhaTl1M1hEWHZtZlJlNW15SFVaQXJESEdPaVNFdkxXSVJQNitW?=
 =?utf-8?B?VXJOT3FtL3M2akNKVEtYVFRDNm1nZGU1bVBtcWU0RkxXVXRoSkU0dDBZSmd0?=
 =?utf-8?B?ZWRkM09VQk9OY05TcUFaM01oVm8zQ3k5cnFwbEN4Z3djMUY2ODJQTmo4ZHZy?=
 =?utf-8?B?OGVVMGQ0SlhhalJVNDVLbDJETUdBRUh2QnJUeExJMmVrajFpY0NPWmVqOTBr?=
 =?utf-8?B?WEpyR2hwYnNCbXVYTDFreUZjSWc2UlFjc1NLbi90eUVuVzZsa3Q5QmttN1Ru?=
 =?utf-8?B?MkdSUXBOMHVOOWFUb0U3S1dmT1gxSHJGQkZId3UzV0hjMmsvZzZYWHZZK1Bt?=
 =?utf-8?B?dytRdTZkcUoyRWk1REZPOEVBQitlbkVKSTRhZHpTMkhObWo1OERRQ1E3dTVN?=
 =?utf-8?B?RzhXWmN3ZVo1c0JTdVlaeEpjNm1tZU01YVRleGpJNWlpdEp3dW0vWm9sUGNK?=
 =?utf-8?B?Z2FyTUVERTMrY2JtTUY3STRTNGpRUlV0Ujgwc2h4bUZzN1REVWJZZ1NET2Ry?=
 =?utf-8?B?Y3hST1dSSVBITEtRdXNvRmdzb2xNbVlndDloZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 09:59:58.4392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb0e371-d1f0-4244-41f4-08ddc906846b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB10193

From: Ilpo Järvinen <ij@kernel.org>

The AccECN option ceb/cep heuristic algorithm is from AccECN spec
Appendix A.2.2 to mitigate against false ACE field overflows. Armed
with ceb delta from option, delivered bytes, and delivered packets it
is possible to estimate how many times ACE field wrapped.

This calculation is necessary only if more than one wrap is possible.
Without SACK, delivered bytes and packets are not always trustworthy in
which case TCP falls back to the simpler no-or-all wraps ceb algorithm.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp_input.c | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4e1d91bbd415..c482b7b75de7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -246,6 +246,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCP_ACCECN_MAXSIZE		(TCPOLEN_ACCECN_BASE + \
 					 TCPOLEN_ACCECN_PERFIELD * \
 					 TCP_ACCECN_NUMFIELDS)
+#define TCP_ACCECN_SAFETY_SHIFT		1 /* SAFETY_FACTOR in accecn draft */
 
 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 1098929a4246..730e7d62854a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -493,16 +493,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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
@@ -525,6 +528,35 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	safe_delta = delivered_pkts -
 		     ((delivered_pkts - delta) & TCP_ACCECN_CEP_ACE_MASK);
 
+	if (opt_deltas_valid) {
+		d_ceb = tp->delivered_ecn_bytes[INET_ECN_CE - 1] - old_ceb;
+		if (!d_ceb)
+			return delta;
+
+		if ((delivered_pkts >= (TCP_ACCECN_CEP_ACE_MASK + 1) * 2) &&
+		    (tcp_is_sack(tp) ||
+		     ((1 << inet_csk(sk)->icsk_ca_state) &
+		      (TCPF_CA_Open | TCPF_CA_CWR)))) {
+			u32 est_d_cep;
+
+			if (delivered_bytes <= d_ceb)
+				return safe_delta;
+
+			est_d_cep = DIV_ROUND_UP_ULL((u64)d_ceb *
+						     delivered_pkts,
+						     delivered_bytes);
+			return min(safe_delta,
+				   delta +
+				   (est_d_cep & ~TCP_ACCECN_CEP_ACE_MASK));
+		}
+
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


