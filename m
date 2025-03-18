Return-Path: <linux-kselftest+bounces-29298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA417A663C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B8F17CED0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 00:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E80158545;
	Tue, 18 Mar 2025 00:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Uw5q3fGT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013000.outbound.protection.outlook.com [52.101.67.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF95E149C7B;
	Tue, 18 Mar 2025 00:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257686; cv=fail; b=MaWyq4sEPbW8c2LNqt087H0a5InamaRs+9VXAQ+r1KiHFFIKfaD3nEEMCSkdwjIF5HaAUwfu+FxvkqC3Kw5VsEiyNwVbtkPqZS7RwPRB4sBIZ2jMuGgfTQaMgzYellyZnE4GP3VIrbV70MnXrf8ef1qXpsvkc0JLCe+SZSQUKUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257686; c=relaxed/simple;
	bh=mcQJpmjSzL62FdjH+VYiKQ6QmWX5Xcp1sbHA6UPYShM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jh8ziVykuCHn8RfArswHyUJcR2xGOin1KZ/+u/MGJMDAe4Os/Vq7Op5b7nJLT8InX135aUt0aOF8Ess34vM4pC6nq/EbSRKRJygdutG2C4H7v+cXmwnZrenwMUQXnpEUQlzYWTj4CELUJDPTqE7tiLvuGrWSOXELrOflN/6lY+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Uw5q3fGT; arc=fail smtp.client-ip=52.101.67.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2wjjZ6KBjJQf3T8jMJRg+0yKOa+S9L/SOhb7H7xLOtdn6UcJT3BkPMdckLyhOJyOP2ugFXSYR2/kTRdF3PYNFPtx6qWVIAAB4lsqDLsCiRUjhqRU3Kc6ave2SOb0yMKgugA8SaST3hIWYhcwlC3YPCpCj/Oo1YhxxWXzmnsBYxDNAm4MZJQGjFaLCfLrhhf0rcjodRVkaC6ULixA5BKaXVJ5uzGSKZunAsF+y4MCgFL05OtystpTkn4n+NyxqBh6H6v8hsmXHfeAfYfgzZNmfC5a6yNa6MsjqbQ2YAUNH+6o/LS47Juz94FQ6Q6/RWpu95t/T1ujfM3FUWPWdn2gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rs6bt+XzymTPEqXWxB38Qk5p3/58eWQSq/Au1qzRsdI=;
 b=lnEZyi13MjLCBNY4sGqhOFzp0+Jz1sC2l2i+qD5g4Y+4fPb3GyNS3/c5MoUVtZ8hpVoF6iv4Ls55EHfxftYVDmOdGdIei6t7hN6QTR23ug2gOoYR3qI0LIt+Nayj7LADip8w4HGixI7UP+4IY6zIe48cgpKzYjGQnp8SaFMyBmqWp+EHEN0P4vF4b3MQQTQmdDEx3XiiIdtljHzBBzu6vQm7FPjzhPf0TLfmksw1V6iIDyLeBwkjtrT3Y7e5On2/q7KY5nx3vNpmMWGWrAgRoj/GAI49FAMt4HsxsF4CPAhk9YATeC3i0LzPSuakpT+WPeUAz7bff7YXorqFhyvF3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rs6bt+XzymTPEqXWxB38Qk5p3/58eWQSq/Au1qzRsdI=;
 b=Uw5q3fGTJUxD3lEp/HDOmtbckOYv3rXiyFiXlMmBF7dzuDALvbSqDX0ykCKhiiDz8q3CLs7jgx+iTehSLrIk/rTKlmfTaGSHXSZw01yk/iC5h2o7RTd/JuJUUXb0FaYi3c50/TFC4fM4IBI0isClFM9CCEpSzBwZzsBaOSfunSpuOrEsJwdeVSa4jIju/UED5p3q6IjuW9FfTw0SrsBHHNo1FdJbdDxwbbeduh7WKD5kGuLlLSK4sErevVxRWoX31X4AOhzxT/wG4nqCW4lDHhaEY1C9kctdqHUCd+cs2NoAiAkjheNOgwbh7kLS/LaDxKd83r8mMS6C2afju+9+iA==
Received: from DB9PR06CA0016.eurprd06.prod.outlook.com (2603:10a6:10:1db::21)
 by GV1PR07MB9023.eurprd07.prod.outlook.com (2603:10a6:150:86::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 00:28:00 +0000
Received: from DB1PEPF0003922E.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::56) by DB9PR06CA0016.outlook.office365.com
 (2603:10a6:10:1db::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 00:28:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF0003922E.mail.protection.outlook.com (10.167.8.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 00:27:59 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 52I0RNBr024935;
	Tue, 18 Mar 2025 00:28:07 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v2 net-next 11/15] tcp: accecn: AccECN option ceb/cep heuristic
Date: Tue, 18 Mar 2025 01:27:06 +0100
Message-Id: <20250318002710.29483-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF0003922E:EE_|GV1PR07MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a9ecc1-a4af-43b0-8229-08dd65b3bce5
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NG54WXhsSTkzK0wwR3hCeFpvWlZMQVFYalkxN0d0U2x1eldETTFEeHZYd3R0?=
 =?utf-8?B?VldVanhRanhjOURlVDZSOVdsWFBnKzJBWVFWVTFST3lDSGh4djk0aE5BWkNJ?=
 =?utf-8?B?WkV2OEh1a0dJOWYwRTBhckRFL0s2Njgrb29CNVRWaUtub2RVdWhWUlJCdlV2?=
 =?utf-8?B?YTczU2dUMUFzRjNtbCtTQVlxbmxWamlaMDBjY0pMNlJaRzBDaXovMWY5RGFi?=
 =?utf-8?B?UFJRUjFMS3dDQWdOV24vNDgwNG1SMEFJaXhUZksvRXdUMVl6ZDYxaC9TdHBW?=
 =?utf-8?B?UlVBRW9HYSs2UkNDZkMzTlZEUm91Y05PY09uL1pqeFFyKzNmbW5yYThpVGc0?=
 =?utf-8?B?SDVDS1hGdGdQN0tZbjdaTDNLeXIvL056R2hSNlVXNUNwdXc1U1M4MGV4QUZr?=
 =?utf-8?B?RHVMTHdoMytObjNaa1U3ejhLUXNENWF4ZlNrdnF2K2NMTDlWQTBEM2Y4NzEv?=
 =?utf-8?B?T0IrQVJ6d1cwSWNqMEZhbkVKVEV2RW5peHpWSEcrTE01OW9sYjc4Sy9vaUtX?=
 =?utf-8?B?TmEyc1NHM2FjaFF5MHRqa0VJSjJRNU9peWhiMHB5V2VicFMycWlBRnN3ZzFY?=
 =?utf-8?B?UjRIUmt4TVBoNE9EbjNvT25SemxEUnJkY29IdXRKTWhUaFNIM2JBR3VtdHZv?=
 =?utf-8?B?VGVia1NvcEhGdXp3YTA2S3JtNG5aODRDMnZXcHE2VTBkNlFZeW1ISHFrdGpP?=
 =?utf-8?B?eFI0ZXJNQUpYeTJZWEF5WVpBc2dsVXQzZHptaXdDZ2UxYkFQT1lqSk9jVGVS?=
 =?utf-8?B?cWtWRUF0NXo4dnduZFQvNXpLVnRiSHdSWjByRUljcUU5ZWErNTBDNXBVYWJP?=
 =?utf-8?B?djJEMUNvTUp1VHJBV1JtMU44MTZuWGk1ZHNUNVNLcGxid3ZlN0daSzBTNzVm?=
 =?utf-8?B?L0R2c01EU3pRMC9PRGJXTnE1YnRIZkMwVDdnWXJpaS9UcGMrWUxNT1JqQ0dJ?=
 =?utf-8?B?ZzlqR1FzN3cwVHMyNUhxWHVqS0svN2lERFhkUzF5aERYc3plMGJSL3RMZk5F?=
 =?utf-8?B?d2J3RkQyUjBjU0hZdDlrb3piMXpQZ3VQMlVRSzFHeHdvd1kzK3V1UmdwcGJT?=
 =?utf-8?B?REplWk8zTkQvandGd2UzRUhCdDdLcnRkcys3VjVyUGZFOExCS1A3dW1aVWhp?=
 =?utf-8?B?aWFKRjRxOUtCM3JvUmw0azFFd3VoRm0vRERlNnRrd1M4UHRSbzJ2MzM0UFdK?=
 =?utf-8?B?Qk16R3UvSWM1REsxQ2x2djJYbCtRUlJKZnB0bDFDYllzYXluTFhWTkEyTEw4?=
 =?utf-8?B?ZGR5eGRBOVM4UGdxdEswRGF2MjVkaEhMYU9Mb0ZNdEpidWtaU1FUcTNXTzJq?=
 =?utf-8?B?STRKZE9YYTBBNU9lb1lheWxQaklMNVhsODBHRG11MzNoL3Y5RWgxUk1vcGFi?=
 =?utf-8?B?WStDTHc3ZVNVbWtMZ0h1VGRYQ1JBaDFnWlp3L3gwaXA3U2ZWclhCSDk1VEFD?=
 =?utf-8?B?ZHkyMW1RNUNrcDkxaG1md3c3L3g5aWs4VmJMcHVWZ28zSzA0WUZZZFNTY1Jp?=
 =?utf-8?B?cWszQmRnYmdxblNXb0FXbzRaRUFha1R2dzRoMC9LL2IwQ0pLRTBJZGJFR3Nm?=
 =?utf-8?B?M3RwNERhcmlTNXRmWWR1KzcvM0VkZElrenZva3BrTlNrUHZBMkkvRlRIWGxP?=
 =?utf-8?B?MzFLTWtmUld4SlNUYTV6bWdyTE51ek92MXJiTCtGSk5VZTZEMjNnUklTNWFs?=
 =?utf-8?B?djcybnRweGRwS0ZNdWR2a201c08raTF5TzJwNlhmTWtxT0hXNDZoQ25VOUFw?=
 =?utf-8?B?U0NDenRFWHA0aWVGVjRCaThGWDhTZHlpYVJwZWtZb2U2VnptM2FXeC9DQnhm?=
 =?utf-8?B?b05CR3hXV1Zhbkl1elNmWmhUb0pENVNUbVZJYSt0TTUya1JYNjZMaTF0Zjg5?=
 =?utf-8?B?M2FpTU1RSVdCTS9Gdno2WEhKMmlMclcyWkxrNzNiMndLeW4walU2WXgvdVU0?=
 =?utf-8?B?YTJHUGJ5NVR2NnZEVXh4MUJmMXg2L0daR3I4eDBBVnhkdGlLMnJTRGprcXF4?=
 =?utf-8?B?L0ZJS2RNVHZ4bXN3ZmhTWXZhb1pTcExkTHl1b1YvSkNPTEpBNmQ2N20xbTZy?=
 =?utf-8?Q?Fq9AV8?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 00:27:59.8249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a9ecc1-a4af-43b0-8229-08dd65b3bce5
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF0003922E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB9023

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
index d531da9f9af8..09220668d2e3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -244,6 +244,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCP_ACCECN_MAXSIZE		(TCPOLEN_ACCECN_BASE + \
 					 TCPOLEN_ACCECN_PERFIELD * \
 					 TCP_ACCECN_NUMFIELDS)
+#define TCP_ACCECN_SAFETY_SHIFT		1 /* SAFETY_FACTOR in accecn draft */
 
 /* tp->accecn_fail_mode */
 #define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d7498b1c9fb9..f62bbf6f4eb3 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -695,16 +695,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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
@@ -727,6 +730,17 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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


