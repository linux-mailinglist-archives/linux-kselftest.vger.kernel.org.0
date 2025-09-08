Return-Path: <linux-kselftest+bounces-40967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 510D9B496FF
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 19:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0664F3B4B02
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE09E313E30;
	Mon,  8 Sep 2025 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="AuPhdqvG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011065.outbound.protection.outlook.com [40.107.130.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A557313521;
	Mon,  8 Sep 2025 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352862; cv=fail; b=aOpjzVmxBA388KtCeKGJa9BzuBfnBmnBVE4dyctuW5UkiC6FisKluLkkiaR5pf1gNhrkTZGZe3PbUl4itgBlRPMqmzRajE/cOG8HvM+K0pqnd8o/1nRj2Yxfq/pF3aXMSKNUC5n/WWnHlFidv0NKaBlWTr8vBLv8/joBonHipso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352862; c=relaxed/simple;
	bh=QfBZJZTaijVfUGXpNNq7FqDbIyo3bYPrMYBOZNgpUzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gjyv9+K/DNZ9zLajM/IjIXV6vDfx8CUzFjC6ACG/NJrnXSjZQVkFli9ZvFflHNc95/RLC/VB9oe8V8Bg5pCA5hMZh8nR14v/tdfx4bXVQjk+w0uyM3AbkRxWlZsaZmd0pA8Nrw5rSdldiBS9L71uLAcoB6yifjZmRmh+oJIV7gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=AuPhdqvG; arc=fail smtp.client-ip=40.107.130.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzMdmHuayXTgIFpNxU1IghjyKBz/6WSPbk08dD4hAlAIR02X/rObxp7gkpP9AvjuEJA2wKloFDXelmvVu2hqiGi+hDGRueTSGcwzjlwD0OE+Q5cPc7/1Jk8rKGfGyXG3fE9sR/3UULthbbZYNk61WBp1Lypvuo/YjWfStlDNSFVm30N9PJJCKa4qsjDcxFJr3vGYvevaA7KWLqQxxWNWBQJ3yZaJn9sDh27gzFaqhwiIJKbhAL5IJ7uDk5y9Vk/5mywi63Heo5Jq1frSWZELQkAVDAXTbDPt6Vuel4ZylnCjHIamqzhLzwUefI0nF/5f3p6eKXH4tJYdEOOgI3JfKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vo6KMiGFFPh6BbGe3v1eOQrACUwFe/695f3FEbGpowU=;
 b=iwPO1CH+4KJajFOzwV0EBHjXl+2uEObkN7rh1+1k7ZpmiWJRZ1tNhNLuAwS5p32GebDsZfpT1IVyCyGZ4eiLLOpqLzg6tXK2UKrtPRQpZ9tXIqt7zyD/Flq7uE36P7YdfojuWZu9rJKJVue1XqKhczxhIOusMZC1FxKj7jbcMpt22vZhKQnjejHbeW54vK+7TuzrthLrdLe4QvIMGC5DuHDmK7dAfxShytYqXfq27q4NJ2vICRv4SI5Us5eHkCsCah0yfVOy23Z8waO65TdTPAx4dYTH67lZKSrDlq7AIPwG5j8gIwbl5rJm+IhUn/yDdIHUjYoAzQVydVSYTCxhkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vo6KMiGFFPh6BbGe3v1eOQrACUwFe/695f3FEbGpowU=;
 b=AuPhdqvG/EuwGg+cKM8P3XPmdhdUoI57T//lTiLOer/8IJumt9hbaPfSvNkgSfyzWB4J9ahG8t/vSAy7IJnrCVMNx0m7WRfx9qj9glJ3EzVnK0JIFxWVKOlr/b9mDzP6RlsR8PfqWN6HtK5EH4WLLHKil6NRUuwSPsBlTwdIQbf8v4o+eKaRSE4lbB9ZDVwRBKVGC3c6qDU8sjtEuw6Pm2AP6W93e5CtTeBW8EnBMZ/zO2FhtZObrG2DCkgxvhAVlJbD0+XcDQPXMT9v8/VQ3BaAETCBjgBEQ/S72yrNw0YXYDuDkm4PCh5su2HE8UiaBHECJmQ2lLqEzdu9ncSMVA==
Received: from AS4P195CA0028.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::13)
 by PA4PR07MB7279.eurprd07.prod.outlook.com (2603:10a6:102:d4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 8 Sep
 2025 17:34:17 +0000
Received: from AMS0EPF00000190.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::ef) by AS4P195CA0028.outlook.office365.com
 (2603:10a6:20b:5d6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 17:34:13 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF00000190.mail.protection.outlook.com (10.167.16.213) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 17:34:16 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 28A781C004F;
	Mon,  8 Sep 2025 20:34:15 +0300 (EEST)
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
Subject: [PATCH v17 net-next 01/14] tcp: reorganize SYN ECN code
Date: Mon,  8 Sep 2025 19:33:55 +0200
Message-Id: <20250908173408.79715-2-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000190:EE_|PA4PR07MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7cb13a-d2e5-4d86-296c-08ddeefdef6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDdDSUR5WlRlUEtPOUtaajlLeENIYjdOdHZFeVJtVDBYb0xqS0lHMTJTbzA4?=
 =?utf-8?B?L25zNWtSZE5KNHlIclBtbFEvTUtOTXdRdmhobGduS0ErR1VRYzByOFJqM3d6?=
 =?utf-8?B?OXdVbmQwSDdEOUVneWMxeGYxVG4reWppY3g0SXA4Ti85OWFPODRENTJEUlNa?=
 =?utf-8?B?TmdPek1KUmFhSWlZT0xqWVBFSjB0R3I0YXZBOGMvS0lZTW12YTFNQ2ZNNW9O?=
 =?utf-8?B?ZnJhd1pGVUVVZi9mRUhDcklENWs1SmpJOTR2YndrYXpkWjIraStJZEFaYzlz?=
 =?utf-8?B?bHNaamc2NjZPd29EOXNBeWRYTW1Oc0xXS2JkeW5CaUhvM0NhUHFISGdXL3FH?=
 =?utf-8?B?VHo0b1lCQmxRUngwbzVYR3B4TG5iWDhiZklZSXpZaERpMHF6Z2FQeXhmZmpn?=
 =?utf-8?B?V0FXZHBtOTJXY21XQk95MFpKN0gyU2d1ZHpmRGpVMnpzQi93UjV3WGgzd21C?=
 =?utf-8?B?Z3ZtdE03ZWJTR0VFMGRwQWFTMDN5OGFWWFRFWWlrTGRUYkFsU1E1S2dwU3NX?=
 =?utf-8?B?akRTMXNLMzkzNjFNOUR6NWRDL1pEYWxHTnhDN2w3RzQ5WmppQnk3TGtpb2F4?=
 =?utf-8?B?SU1CNHE2U3h6NG8yeXhvQm0vNWVuaDV5K2huOTMybVhtMlpZOHlXOTZaWW44?=
 =?utf-8?B?d1BjY2pISnBYUHZGWWs2eWNWWHpUQ0p5am13eTZzQU9iR1ZHaU1qMmsvUUph?=
 =?utf-8?B?WDA5OWRvZEY5UHVjZlBNRHhoUFM2QlVUcjh4Y3Fwck9md29IWTVQRE9Ka2NF?=
 =?utf-8?B?TUJsTjRrQ2pwQTJNenRGUjZEd1NyeFRRNUxtc1hqeUQrRTZOQzNCdjVIeHBw?=
 =?utf-8?B?SFdxLzRtYm9UQ1ArVmJpQk11SEc0MmRVQk9rUUMweTRra2o5aDFNK0xMamF4?=
 =?utf-8?B?bXQrNXA0TUF0dzc1dzhPQmREZFkxUHN3KzdIRnRMc1g5VzBsc1Y2U21PUTRo?=
 =?utf-8?B?VjUrYmdHR0dIVHRVMVZzekFhdWZaUno3U29odG0vNUg3RzkyazY5TzlTSFRw?=
 =?utf-8?B?NkJFNUF2MzlRNVJ1QmJKNkFpc3UwbEsyUEpPOW94RkdkYVJhYTRmN1FuVU5m?=
 =?utf-8?B?RnhraVk0N0NjZkZkUTR0OHl4LzJoYkdFMTdNeC9ocVhzTXo0dTBaOGJwRDVx?=
 =?utf-8?B?bjI0OEpQMlo3bURPWlNkcTZGcHhFNGZmTldHd0pqMkN1NExycVE4WHhkc1cx?=
 =?utf-8?B?Tkoyd1NCWVNGUk8zdFpLS1A5VFNyZDNNbkQrbHM2RUgyNTViMFoxRU5HVlZu?=
 =?utf-8?B?NWw5ZjFPcDlaOXhUSUMvRW5qQTBoRm0wdEU3dmRPc1o1TVJ6S1ZERSt1WUdn?=
 =?utf-8?B?NzdrVExKQThNd3c4V0k1c0ltT0J2NTVsM2VmSXYxSFV1bDYxRDAvNTRLZzRS?=
 =?utf-8?B?eUFvVmJ6M2tBQmNuWStNVENCMkVBR1JpTnJmQlpUNlhtbk1NV3czRGtQUFU2?=
 =?utf-8?B?ZG9GTGxuTDVBL2pMR1FrTGxUUEtqQWRYeDhCamk2c0RoaXh6MmNEMjcvMWZu?=
 =?utf-8?B?ZHlmMkprUld5UGlBL0VRZXZFYzdzaEhGQ21kdlRmVHJkMXg3dkF3T3g0cDdv?=
 =?utf-8?B?ZEl3MFZObmVwSjBxYmI1S2FQa1FkclN4Ry9yeTVWQm1TZTJ3SjJxc0VVQ0pE?=
 =?utf-8?B?YjVkNStJQnRVbzdEWngwUEVQbHVIc05rTm5lTlU2K1orNjd6RTdtYU9NMkcw?=
 =?utf-8?B?ZkJrM2haeEJ1UHRtVFNkYkFwZU9rck16QU9YK0Rzb1dOMTNYUCtzSHkrTXN5?=
 =?utf-8?B?Nkc5ek1keDdwYTdubHpTdklVU21yODNhdG9kengzNGI0a3hwQVQ4VWRvNW5t?=
 =?utf-8?B?OVJzWnpUOUYrY0t0MHNneXVCUW1ERDNISGFXMVJoLzZ1Q09jdnkvb1RqYmVC?=
 =?utf-8?B?aGdxRy9sZkYyWDhGUURSQjVBbnhmTDZTQ1dSak9lVjhaWkhWbnNEODZhUmNC?=
 =?utf-8?B?bXlTSURra0UvSWt4MURVM1RlMmxTSEs3a1B5MVFpQTVBaWZTWHB2NG42Q0FF?=
 =?utf-8?B?RlN6RHA3czk2V2JOVFh5MkNvZ1VwQUJOcm0yQ3lLdCtiUlFmdUlxN3A2N0JL?=
 =?utf-8?B?eENhTDNkU2hsTk9paTRGK2Nnck80bmxxKzRBZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 17:34:16.6453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7cb13a-d2e5-4d86-296c-08ddeefdef6b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF00000190.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7279

From: Ilpo Järvinen <ij@kernel.org>

Prepare for AccECN that needs to have access here on IP ECN
field value which is only available after INET_ECN_xmit().

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_output.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e180364b8dda..54b8faa3ad95 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -350,10 +350,11 @@ static void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 	tp->ecn_flags = 0;
 
 	if (use_ecn) {
-		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
-		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
 			INET_ECN_xmit(sk);
+
+		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
+		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 	}
 }
 
-- 
2.34.1


