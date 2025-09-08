Return-Path: <linux-kselftest+bounces-40974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A3BB49721
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 19:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F592207CEA
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA2D3176E3;
	Mon,  8 Sep 2025 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="H5szIgbv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013022.outbound.protection.outlook.com [52.101.72.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FA53164C4;
	Mon,  8 Sep 2025 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352877; cv=fail; b=enB7qPQ3uThVQcNYzWLXPEHIMxAs4lbTWKzUcwDRKSAIcGp7GZPk1lE60Wc18CdIBQfKitQnopH/X2YEtHVyEs3THcy7fykOT1D/u6hiw8X/0da9oXmmNicHuYrgy6i6NTZdqPxG2JT5/fdHbeynKFHmwoWVEsRKA1ChvkVuz2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352877; c=relaxed/simple;
	bh=C/dhWSWt+O3PZtD/17zVGFH5w/aYQMeOKKd7dgXZz4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHiN7Gw1ex14XExBiFfdSIhmQPe3RDTPXWFNTdcA0yBnT0AooOR91Ao9p0ukoku5CoLR4ZWxYDwsiqaukMx7wbmYNugVq32G+az/0qMWNnNVZXmybV4iLWXXe8VWQR15o6XX1+h55aP4g+L5XBzVIyZ9RdgJMlSDjq8H3rVUyNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=H5szIgbv; arc=fail smtp.client-ip=52.101.72.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWoiFFQN/qctO/p/VrgGhHm2dmnggFZ7D/G78jLASurwqlS3HqVV289+UtvMg5NzeyWr01iHX6nhvujjv5wt8rmdApJ4KlK8AoHofB5K8r267HC3UrsmMQvooc+advYeauWffzknc5m8R/pTR8fn15m0xhnkaZ+pCFrU394DnObuvQId+nxFvkgNfx+t6+J0dGXzaAuW/7LCM15usFWIF3IfQvACaZIP+/eMEIMoHJqXdolH76bpJfa4rGgN2CAzVMgd3PsT1dGiZR3uDukKLq3iPw5Eyeo2GVvn1XO94fakBPt4ONFaQfRttNdOi3KTI8GUqvybZHCFFxDfz6hsGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ta9CTQXzfsJln+e8CsRqChrLbcfgUPSfklUNiwzkFSU=;
 b=KkFdWSh4KxJxlL/6buhsQOtQZnBVlfIQIYxsoH3P4zOWbI/9FbVx9froRFe0qpZD603OGcxopItRzZ3SgH8h+ZtnDd6XTMHPQmjGLVSNm8HjgVcxFI6IGVZAE9C9kkbK3UtRc4t8hKBnwbxCVpHOH9aGyHlYK/kqbd368YI6Kv584iqaDF61AiHR/OF3QEKx1haD2AdiSG09yPfoWeIXnFSfF42FNA3/X55IUY1pj7RyhLjzgSEJ8KVe5bpNZcTFIgB6l7EEztSINEqo3Ts47HODmM/PIAiZpswQD4g7Z/8DfUYcdXcSiE8clauKl8f+bcXVaz03cOh+YjF9rAcmOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta9CTQXzfsJln+e8CsRqChrLbcfgUPSfklUNiwzkFSU=;
 b=H5szIgbvL+xxGxvmBdyBKw8NINQS1OMRKB82AL0ruMAemYBMCXhy5xfcrTYTxUV3sc8NZ8cTBDf1kwOOxTeuM8nXQ1O+5gp9NvroGg5WMw8LA8NkkwcZGNPBmOIt9yac1H2qhdHJ/Q2ZK/7ZtpbCT5EppC6qQMwSzuBzrGK0rCAbxGA/IsnwXc28TRxkEJEzWJKOhqsVCuMNLoGwcdNVC7kKEwp8in6OL8Dt37mrRy1tQy/XHmf1Majy+KWUTnOy/E0pwnifGZxkUeU/SeJeuOil8TSmOcRN7NTUR7qdKI3MigIcisYEA4saNYSx5davYyodZu6rDo/vpUxymjtO0g==
Received: from AM0PR04CA0058.eurprd04.prod.outlook.com (2603:10a6:208:1::35)
 by DU0PR07MB8884.eurprd07.prod.outlook.com (2603:10a6:10:323::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 17:34:31 +0000
Received: from AM2PEPF0001C716.eurprd05.prod.outlook.com
 (2603:10a6:208:1:cafe::4d) by AM0PR04CA0058.outlook.office365.com
 (2603:10a6:208:1::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 17:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM2PEPF0001C716.mail.protection.outlook.com (10.167.16.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 17:34:30 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 3ABD91C004A;
	Mon,  8 Sep 2025 20:34:29 +0300 (EEST)
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
Subject: [PATCH v17 net-next 09/14] tcp: sack option handling improvements
Date: Mon,  8 Sep 2025 19:34:03 +0200
Message-Id: <20250908173408.79715-10-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C716:EE_|DU0PR07MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5fabe6-e8f7-475b-be63-08ddeefdf7d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bURMVWFjakdSZVhXem5kRmIwL3pLOVU1d0N5ZnlxK05EZ1FYTHJDQTI3MEZ1?=
 =?utf-8?B?dVZ3NGlKU28wY1BndmExY2V5TTZ2cG5QM2wrZEZsTGw2SUh5dGU5N012czcr?=
 =?utf-8?B?ZUJJQlhEYUsxQVZMK1NMekw1cXpvSTN5a20yQ3Rlay9mU1NiUEcvMHZ6OTZH?=
 =?utf-8?B?TzA3RUp2YjhqNnM3MnlndVdqWU9YN0hHRm1hZ3ErR041MXpxUlJyR2tXbXhB?=
 =?utf-8?B?c0o2ejVVcE5TZHlSUExGU2Q4cXJtR25sdjVkMHdXRkhxZHJSa0tuc0NTNWM4?=
 =?utf-8?B?RVRvVTNUdTZRck5VR3g5ZGpzRk11NkM3aGdONzF0b0MwU1NBcGp1OUd3NWkz?=
 =?utf-8?B?Y3ljYjZiV2xUYTRVb3ZYcDU1VkxXTml4aEE4dGhLL0NzTEVMRkZJTnpEWEdH?=
 =?utf-8?B?ZlJkb3ZxaGpxT1M4NUUyQWlEbXJHa2JHQUVJMnZDYllPT3A5RmRrMWhpOWFR?=
 =?utf-8?B?VTVGQkZlU2hlM245S1lOeDF3OEEyOXJMSElib0ErcS9HYm5iU2VDaFZTSWtE?=
 =?utf-8?B?R1ZnYU4xSEVBZ1NuNVRhN2tXOW14Mjg1b1pONUtkM24rN3Zoa3FKSUVPc1R0?=
 =?utf-8?B?Y0ZtQnhob2hrblU5c0JWeWhsaFc5T0tIWW56UC9DSUh6RXI4VG1SWHpJRS96?=
 =?utf-8?B?Y2h2Syt0TFcya1JaZTJtUXRISnlDMmxRak9hV2k3QkpLRkNORWtLYjV2WjNz?=
 =?utf-8?B?UnRmUWhHTGhVbkdNTlVaSnhDV1FhSUorMnRxcTM2eXdjRGlxSDRNbFF3dW1s?=
 =?utf-8?B?VjlHYzRZZDZHYkRjRVlrR0NWd3lxZjE0UHE4VVZEZVEyTnA1T1hLSTQ3ZFBm?=
 =?utf-8?B?cHhZU0R6RmpMQnZibVpvZmdrdzh4T2J2WDdZVE0xOThyd1FObWRmSmRVZE1x?=
 =?utf-8?B?ODRYSHBxMm9JTmNxNXZkYmlkendlTmUxWEN2VFRhVWNXNHNxcG95eHMvbFdp?=
 =?utf-8?B?dlJHY2U5cmRvbnZjTkpjUVZFRTNBd3dpNlY3STJHb2plajFJSzBMVmZ4UUwv?=
 =?utf-8?B?cGc3VzVzZmJOV3Q5dlBjSE5pdG56ak5xTjJGN21DMkhmM2FuNFpadDJxSlFQ?=
 =?utf-8?B?K2VwcVpsRlJEdWJiNmxGR28vbjhuRG5kK0NjYnZZaTl2UzQ0ayt2WXlMWU5U?=
 =?utf-8?B?NnJJREx6Mk1hQldCVXlFZGJWdHhUQXdaLzB0MDc0U24yRHZRWG1SWG1TamF4?=
 =?utf-8?B?M2hEVGlCUTl3eGhwR1diNWtBVUpnRU9mWlRxSlhsd1Y5U2Q4NEc4dGYxTDFF?=
 =?utf-8?B?WlMvOTUxSVRkMXJubndyU3pxT2FMZERrQWRPUUFMSkF0K3FJMUlRbElVWkdC?=
 =?utf-8?B?U1JTbWFLbFl0L3pwY0ZZSExqUFlvY3JZSlhNY2JNYkRRVVdUN0sxZTZWVy83?=
 =?utf-8?B?ejNPVldveWRtUU5RQnJDSEhkL1lMQ0pIMkFrVGlUS3lidGN5bUtEdzM5dEdM?=
 =?utf-8?B?V2tlRWR4WWluM3Q4ckt4T3BzNkJEMkh0MWJ4Q3h6N1kxWjJoZmtSOGYvNitF?=
 =?utf-8?B?ckhGeFl5dlJadVBEVXNxRDltbTdub1hSMHBTOXEwbzRFN3VIOGhieVdvR1pS?=
 =?utf-8?B?ZW1WNTVLNiszWVFob1oxdnBMeVZnblhkRjVlMWdKY0NYaVhVSzNheWdXY3Zv?=
 =?utf-8?B?dWtMQTRiaTVKMXNvR1Z5VlVkUSt1RGwvZ2JYUVJtdDlXMUEyY3FTem1uQW93?=
 =?utf-8?B?cEp6Z2p2Z29Nd2gxcTlTNm56MUZuZ0VaWitxNWI2OTY0d2ttSUtWcWZCQyt3?=
 =?utf-8?B?YzQ5MUVUZkRUSEt1YzFOQjBQTlQ0OFN4YXdCUitPUkd3eXJZZ0YyNjZncFJm?=
 =?utf-8?B?VGZ3Z1pYQlZwSitlMDVFbUVVTXc3bUdLNTlwdHZnWVJqQjVzeFIwSml2ejNs?=
 =?utf-8?B?WUdORDRWTk1ZWVpZMVlabkhkRmx1L2VoYXRPTkN4RXc1YXZGL0FZTFJkUjk5?=
 =?utf-8?B?UjRUM0d2ZlFXbkpVckZENkxyRm1ORG55a3JabWQ0L2VwS3JMcGxYVXZHa1Nu?=
 =?utf-8?B?Z0dyVUZiZHZDbkh2cTdEVFVNVE5IM3FIVUY0eEQwWnc5TGdyNjNlWUplWmVX?=
 =?utf-8?B?TG53bjBXOWtGSHVEM2hDUFhjU2dnUDFLeXlXQT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 17:34:30.6942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5fabe6-e8f7-475b-be63-08ddeefdf7d8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8884

From: Ilpo Järvinen <ij@kernel.org>

1) Don't early return when sack doesn't fit. AccECN code will be
   placed after this fragment so no early returns please.

2) Make sure opts->num_sack_blocks is not left undefined. E.g.,
   tcp_current_mss() does not memset its opts struct to zero.
   AccECN code checks if SACK option is present and may even
   alter it to make room for AccECN option when many SACK blocks
   are present. Thus, num_sack_blocks needs to be always valid.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v8:
- Set opts->num_sack_blocks=0 to avoid potential undefined value
---
 net/ipv4/tcp_output.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index deb9b085a8a2..5be2b3eb73d3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -985,17 +985,20 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	eff_sacks = tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
 		const unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
-		if (unlikely(remaining < TCPOLEN_SACK_BASE_ALIGNED +
-					 TCPOLEN_SACK_PERBLOCK))
-			return size;
-
-		opts->num_sack_blocks =
-			min_t(unsigned int, eff_sacks,
-			      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
-			      TCPOLEN_SACK_PERBLOCK);
-
-		size += TCPOLEN_SACK_BASE_ALIGNED +
-			opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+		if (likely(remaining >= TCPOLEN_SACK_BASE_ALIGNED +
+					TCPOLEN_SACK_PERBLOCK)) {
+			opts->num_sack_blocks =
+				min_t(unsigned int, eff_sacks,
+				      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
+				      TCPOLEN_SACK_PERBLOCK);
+
+			size += TCPOLEN_SACK_BASE_ALIGNED +
+				opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+		} else {
+			opts->num_sack_blocks = 0;
+		}
+	} else {
+		opts->num_sack_blocks = 0;
 	}
 
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
-- 
2.34.1


