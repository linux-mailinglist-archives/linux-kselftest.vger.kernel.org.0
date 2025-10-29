Return-Path: <linux-kselftest+bounces-44259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F265BC18EB0
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24F2B506CF7
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C6C328635;
	Wed, 29 Oct 2025 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="NPvjcP6v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56AE31327F;
	Wed, 29 Oct 2025 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725195; cv=fail; b=hv4I0xxxHtXIOC6WMs6l+nd/3wO33SGGRjRCFI0pQ4WZLtGg1wgH6rQ5JYcp1Pn4IDrQ3HHk3mh/9nYV1f4prKQHdv4ZGEnvW0TjuRhUZJh6vshhPjgE/WGPMqOhMYdXDOIlzNPPfn8+AkBziNl6fvPeRN46ZeojGrq2aiJo2MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725195; c=relaxed/simple;
	bh=DZMc5Jj7nQuzt4HGTd59TXKPQkBwuAoRGiLNRW3jao4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+8lvBF5jhmI5uHhn97klLxw67mr1+Eu6JMqWPKGtU3L1xLCtuzS6pdFz9RuW3xmeayMpcPBEnRMAuKHBjof0lClqWdWFrsEGFKUr0WvnKkp7Rhid7apfw61Iuidwtcob4QIbQx6xIE2ajd1DBUyJxpfBn9fl3eFj4gKoLxmLow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=NPvjcP6v; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oG6t5G0APpcGjVpjER+kBWgQnzhH1ub7G6/iW6pl4heoyEXOUspzRtqwk8NPUrWaijPSW1rKzwupT+7L5xL3Yrb8BjY04IxRRarXXCtCVKKBvktxO6oN50MKWqVco8qyVc1KdFho6eDqJUPHkRtMmN0I4X76A8MwlQK0KU1VExpPNcJHvtYqUREt6HmhVJHyPveFNmJjMIOT4LHE1PhlvzCMF5IRSMk12M1fnmPa7BSQDdJhYTLZZFFoNMY3K71RJSjLJgTXXkjVpWIBFzoqiAGg7ufKNg3Ghvbv0VDvqsoDxvPJebPs4NkqKEf11MANA72glYkMLYvZKzpdndneWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ue9xrzn/0yreIVbPA3vYy2LyHolmrEXh3PJb/NdNIfI=;
 b=du4ieFctBz6Xqj6FxPWi+LtftDuSkdG/pDVlUbqwLK78L/1AyF3hLds1RmoSi9IeIQkEQA53r9KKiV2KgWln6JOAhsdb09OMMHaQIYhUWnA75gGChQVX0pG7piKnJOpOf1MuX5JzJeBjHzx+Mt7n8G4TBJHBuFB79aX5bJlNS3rPx5eLCFvZcoVqaCSQbsc+g4ETsNT1D2kMWn0kQYByCQ2zGY5tK8Idd8ndJm+g3dCi0P3u0V+ROrUG5wcnN0YMLsyf0KytfT3Dk7YYjh7P0UsI36IQBXAIlaUGdsWE3fAmGB9ORcMzlfhXyKTdN9/jM+/40YJhHfuLtYba3AwnMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ue9xrzn/0yreIVbPA3vYy2LyHolmrEXh3PJb/NdNIfI=;
 b=NPvjcP6vkqvx0Tnt5e1mNum+X0WdjcLtN80vv/+xfcDeb/f4F4p279bFnvUfn23+gj3IWJniJyizcWryPSWLdAv0OmfoO24RB8vQfMs3djY6Gg1SxabhY+Xdu67sjekNSwnY2a17TBTFTFopqC+ecmSZkWIMGJCN9YoV83bqMXhhE2yJVDduX+o2wvm70DirskJcWG77esixkYBAPdX40PJLBwClTqTui0yOgEEc1MS+gFlzFvy8fMp0WQ4naRdhxNstEGvEe3/fVJLZXwiZ5+OKGxel9MGvZwXn+eGEo9TJIkxfxLGEReD3je/MVRAmkTIpUmMhoyiF8kRHnKvZwA==
Received: from CWXP123CA0008.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:73::20)
 by AS8PR07MB7958.eurprd07.prod.outlook.com (2603:10a6:20b:353::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 08:06:29 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:401:73:cafe::3c) by CWXP123CA0008.outlook.office365.com
 (2603:10a6:401:73::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 08:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Wed, 29 Oct 2025 08:06:28 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id C267C20324;
	Wed, 29 Oct 2025 10:06:26 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
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
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Olivier Tilmans <olivier.tilmans@nokia.com>
Subject: [PATCH v5 net-next 05/14] tcp: L4S ECT(1) identifier and NEEDS_ACCECN for CC modules
Date: Wed, 29 Oct 2025 09:05:59 +0100
Message-Id: <20251029080608.92428-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9F:EE_|AS8PR07MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed941e2-5204-4738-a534-08de16c2102e
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?blljMXZIc0xlZ3cvSHRBeWdoaFpRS21hV0Vyd1hXMUVkVmZyNUx3N1Fmck5m?=
 =?utf-8?B?WXJmUzgxdWtUVitkVjFEY2t1TmJjdlVmOXVOOWoxSXRWdytRN3ZsaGhaMktM?=
 =?utf-8?B?eXJuVnZCMnpRM0ZESEwvQkdrUEFCTTc5aHNkak5YZTczYWNGTzlxK3hiMXhM?=
 =?utf-8?B?S25JNklJdjRqMWxTdkVVbnk2dDd1QnZaKzhJdnF3RmNocHNiM0pFUWlTR25w?=
 =?utf-8?B?WGprZzhVYUQwbFNDWlo0djdpcTY2c0U3NVdYb0J0dU5VZC9XaTMzUG5sTVhW?=
 =?utf-8?B?MnQrYTR1WFpRckI1QnFWTnQ5Smhwak9OVFVpZzhYaXNkT2lMUEdLVU16THZS?=
 =?utf-8?B?S3l2d1Nkak51SUpLNktaWUFkT1c1dnNWRm5BRXJzMUZsT29IdmtHdWlPYWVL?=
 =?utf-8?B?MStES0Q4YkJ2TnQ3cmdkODVuYktGbkRkOGUyaFhEcWZxYm9oOEQrcXRLU1Fv?=
 =?utf-8?B?Mks5WHdHNFB1b0VBdHpsQXFVZUJGVTM0MDhEV1ZOQUhGTFVlOU5Mb0lwWEtq?=
 =?utf-8?B?ajVQaFZIZDNFUUkyOFNnT2s4eGszT29NTElRVFBTWlNiRVVzQ0ZyZ3RwbUdv?=
 =?utf-8?B?VU8wYkNGRlAydkZjUGpxTTlFMnYrd3AyK2NHQnp1c2xTTmVhVy8yV0FVdGV0?=
 =?utf-8?B?dG5mSG1Pb1UwYnBWS1UvL1BCZ2hJdkdxdFFZV293a1B6U3NVb2xGcEhBM3N0?=
 =?utf-8?B?ZjJDQU5Gcnc4WUdPa2FuNmZZL0ppbVp1WFMzc3d6ZldaOGpDdEx5T0RFYlpX?=
 =?utf-8?B?L2pOQjErZEpwOTlLWE5ZeURGRmVWUlRIenB6LzdaSE5xMS83QWNHMEFVMFJH?=
 =?utf-8?B?NGRyQzdtSktqNjZPZGZxQUZ2am51UnBhaU5mak1xRFh3aUVLUXVUcy9vK1RI?=
 =?utf-8?B?WVp3YmZFeUlvQUxyTXhOeGgybkdJamtmNENoR3kyTVdhaTk4ZHNETFowUVdv?=
 =?utf-8?B?YWI3WXlUZUZnWXpHZUw0ZnRDVEVxUVhOSitpT0lUUWladTkxTHVtUG8wUVo2?=
 =?utf-8?B?d0ZTZ3hacEFXR3VoSWZFOGt3ZjAxSlloMXVnWXgxR2UveEtuQ09XM0R5VktL?=
 =?utf-8?B?Qm1tVHQ2TVdHR3BSbkM1UGhFVHJYNDdCTDcybEtCVlZJVFBlOGpnRTFOTDdN?=
 =?utf-8?B?bEJpenFraWFERStoZ3V6NHhOZEd3MVcxUlR4NDcxZDM2aDlEWElCWWRYQUNS?=
 =?utf-8?B?MnVjQVpMM0NLZ2YvMkVieWdYZm1QbTE0TzU4aEZjMG5vYUtBRXlpdU8rYTVy?=
 =?utf-8?B?cFZHdGxPY000bFFkYUNWNkkybWtIWlpEVkZsTElIVTZnM01xdHNydkdnb2Z1?=
 =?utf-8?B?cWtjN0JObUpLMHhYbFo2SGMwMm4rMWl4WGI5bWFFVmxlZ1pJZ2QweitobkFa?=
 =?utf-8?B?MHJ5QWw5eXd3T1Q2RDNpbnQxVXBYVjk0TmJVUTJlYWtETmljV1plSFNVU01n?=
 =?utf-8?B?TFF0ekkxZXh4QXF4b010UzJOdnZZV0pvWVVhWEdyWThPc3ZwbEJlYjlHUWxI?=
 =?utf-8?B?WDZmTmJMQ3FzTmlIY0pqdnVXRmU5UzhoeEhMM25zYVF2R1NuQmRBZE1vaXpO?=
 =?utf-8?B?UitEaUk2aXhPeU5ZdHZpcVB5c2lYOWw2aVl5ZVJMd3p4UGdMQWtyOWV4UTE2?=
 =?utf-8?B?NUFFME96M3dSWUUvNEpFZmwvck9ySUREWGZReEUvUWRGb2NnT0ZOQnVRbGdY?=
 =?utf-8?B?Y3VXZkw5MThuMzRDUE51OHdueUFkZE1VU1FPZHlkVDRLQ1lCR1Fjam81d0dR?=
 =?utf-8?B?U0p1VExDVENBRzFWTDhjL09oQzltajd4L0h1OFFreEJKQWdPNkJEamd4aStw?=
 =?utf-8?B?WkZhNGFrWTJ6UDdrbnVaNXZDbWlzdDBHT09qdlB6MGFGa3ZSS2wxYkl1Wk8w?=
 =?utf-8?B?WFVKOFBBZmQyT3lJZFlJTThOMGNRSWlJSWZlRXlkZXdWNU5ZekJFOEVqRjNB?=
 =?utf-8?B?VzNwcXFpTjhVL1hVckR3RFlmMTBZQnpwaWc5c1JkRWxrK1JtSXR1c3Fna1c0?=
 =?utf-8?B?ZXdtNjZKa3ZrMWxGQkNFRG0xaWRtT1R4Mk5GbGNKNWxSVmtQMUlvbkxweVVN?=
 =?utf-8?B?WUtCWG1JYVdqcTc3azFMLzU4NGZGQlVINTFrM3g5a2VtaHE1WGdvVEZtOWd3?=
 =?utf-8?Q?MSXxCD0zzylR4mFsB/yxAe01f?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:06:28.3341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed941e2-5204-4738-a534-08de16c2102e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7958

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Two CA module flags are added in this patch. First, a new CA module
flag (TCP_CONG_NEEDS_ACCECN) defines that the CA expects to negotiate
AccECN functionality using the ECE, CWR and AE flags in the TCP header.
The detailed AccECN negotiaotn during the 3WHS can be found in the
AccECN spec:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Second, when ECN is negociated for a TCP flow, it defaults to use
ECT(0) in the IP header. L4S service, however, needs to se ECT(1).
This patch enables CA to control whether ECT(0) or ECT(1) should
be used on a per-segment basis. A new flag (TCP_CONG_WANTS_ECT_1)
defines the behavior expected by the CA when not-yet initialized for
the connection.

Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v3:
- Change TCP_CONG_WANTS_ECT_1 into individual flag.
- Add helper function INET_ECN_xmit_wants_ect_1().
---
 include/net/inet_ecn.h | 20 +++++++++++++++++---
 include/net/tcp.h      | 22 +++++++++++++++++++++-
 include/net/tcp_ecn.h  | 13 ++++++++++---
 net/ipv4/tcp_cong.c    | 10 +++++++---
 net/ipv4/tcp_input.c   |  3 ++-
 net/ipv4/tcp_output.c  | 10 ++++++++--
 6 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/include/net/inet_ecn.h b/include/net/inet_ecn.h
index ea32393464a2..827b87a95dab 100644
--- a/include/net/inet_ecn.h
+++ b/include/net/inet_ecn.h
@@ -51,11 +51,25 @@ static inline __u8 INET_ECN_encapsulate(__u8 outer, __u8 inner)
 	return outer;
 }
 
+/* Apply either ECT(0) or ECT(1) */
+static inline void __INET_ECN_xmit(struct sock *sk, bool use_ect_1)
+{
+	__u8 ect = use_ect_1 ? INET_ECN_ECT_1 : INET_ECN_ECT_0;
+
+	/* Mask the complete byte in case the connection alternates between
+	 * ECT(0) and ECT(1).
+	 */
+	inet_sk(sk)->tos &= ~INET_ECN_MASK;
+	inet_sk(sk)->tos |= ect;
+	if (inet6_sk(sk)) {
+		inet6_sk(sk)->tclass &= ~INET_ECN_MASK;
+		inet6_sk(sk)->tclass |= ect;
+	}
+}
+
 static inline void INET_ECN_xmit(struct sock *sk)
 {
-	inet_sk(sk)->tos |= INET_ECN_ECT_0;
-	if (inet6_sk(sk) != NULL)
-		inet6_sk(sk)->tclass |= INET_ECN_ECT_0;
+	__INET_ECN_xmit(sk, false);
 }
 
 static inline void INET_ECN_dontxmit(struct sock *sk)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 190b3714e93b..76a67e77900d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -406,6 +406,7 @@ static inline void tcp_dec_quickack_mode(struct sock *sk)
 #define	TCP_ECN_DEMAND_CWR	BIT(2)
 #define	TCP_ECN_SEEN		BIT(3)
 #define	TCP_ECN_MODE_ACCECN	BIT(4)
+#define	TCP_ECN_ECT_1		BIT(5)
 
 #define	TCP_ECN_DISABLED	0
 #define	TCP_ECN_MODE_PENDING	(TCP_ECN_MODE_RFC3168 | TCP_ECN_MODE_ACCECN)
@@ -1195,7 +1196,12 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NON_RESTRICTED		BIT(0)
 /* Requires ECN/ECT set on all packets */
 #define TCP_CONG_NEEDS_ECN		BIT(1)
-#define TCP_CONG_MASK	(TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN)
+/* Require successfully negotiated AccECN capability */
+#define TCP_CONG_NEEDS_ACCECN		BIT(2)
+/* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
+#define TCP_CONG_WANTS_ECT_1		BIT(3)
+#define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_WANTS_ECT_1)
 
 union tcp_cc_info;
 
@@ -1327,6 +1333,20 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
 }
 
+static inline bool tcp_ca_needs_accecn(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
+}
+
+static inline bool tcp_ca_wants_ect_1(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_WANTS_ECT_1;
+}
+
 static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index f13e5cd2b1ac..0cc698a8438c 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -31,6 +31,12 @@ enum tcp_accecn_option {
 	TCP_ACCECN_OPTION_FULL = 2,
 };
 
+/* Apply either ECT(0) or ECT(1) based on TCP_CONG_WANTS_ECT_1 flag */
+static inline void INET_ECN_xmit_wants_ect_1(struct sock *sk)
+{
+	__INET_ECN_xmit(sk, tcp_ca_wants_ect_1(sk));
+}
+
 static inline void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
 	/* Do not set CWR if in AccECN mode! */
@@ -561,7 +567,7 @@ static inline void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ECE;
 	else if (tcp_ca_needs_ecn(sk) ||
 		 tcp_bpf_ca_needs_ecn(sk))
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_wants_ect_1(sk);
 
 	if (tp->ecn_flags & TCP_ECN_MODE_ACCECN) {
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ACE;
@@ -579,7 +585,8 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 	bool use_ecn, use_accecn;
 	u8 tcp_ecn = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn);
 
-	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN;
+	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN ||
+		     tcp_ca_needs_accecn(sk);
 	use_ecn = tcp_ecn == TCP_ECN_IN_ECN_OUT_ECN ||
 		  tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ECN ||
 		  tcp_ca_needs_ecn(sk) || bpf_needs_ecn || use_accecn;
@@ -595,7 +602,7 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 
 	if (use_ecn) {
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
-			INET_ECN_xmit(sk);
+			INET_ECN_xmit_wants_ect_1(sk);
 
 		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
 		if (use_accecn) {
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index df758adbb445..1a8ed6983ac3 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -16,6 +16,7 @@
 #include <linux/gfp.h>
 #include <linux/jhash.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <trace/events/tcp.h>
 
 static DEFINE_SPINLOCK(tcp_cong_list_lock);
@@ -227,7 +228,7 @@ void tcp_assign_congestion_control(struct sock *sk)
 
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_wants_ect_1(sk);
 	else
 		INET_ECN_dontxmit(sk);
 }
@@ -240,7 +241,10 @@ void tcp_init_congestion_control(struct sock *sk)
 	if (icsk->icsk_ca_ops->init)
 		icsk->icsk_ca_ops->init(sk);
 	if (tcp_ca_needs_ecn(sk))
-		INET_ECN_xmit(sk);
+		/* The CA is already initialized, expect it to set the
+		 * appropriate flag to select ECT(1).
+		 */
+		__INET_ECN_xmit(sk, tcp_sk(sk)->ecn_flags & TCP_ECN_ECT_1);
 	else
 		INET_ECN_dontxmit(sk);
 	icsk->icsk_ca_initialized = 1;
@@ -257,7 +261,7 @@ static void tcp_reinit_congestion_control(struct sock *sk,
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_wants_ect_1(sk);
 	else
 		INET_ECN_dontxmit(sk);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f6e6f30c3d79..b4098d5cce48 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7239,7 +7239,8 @@ static void tcp_ecn_create_request(struct request_sock *req,
 	u32 ecn_ok_dst;
 
 	if (tcp_accecn_syn_requested(th) &&
-	    READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3) {
+	    (READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3 ||
+	     tcp_ca_needs_accecn(listen_sk))) {
 		inet_rsk(req)->ecn_ok = 1;
 		tcp_rsk(req)->accecn_ok = 1;
 		tcp_rsk(req)->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 7f5df7a71f62..d475f80b2248 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -328,12 +328,17 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 			 struct tcphdr *th, int tcp_header_len)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool ecn_ect_1;
 
 	if (!tcp_ecn_mode_any(tp))
 		return;
 
+	ecn_ect_1 = tp->ecn_flags & TCP_ECN_ECT_1;
+	if (ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp))
+		__INET_ECN_xmit(sk, true);
+
 	if (tcp_ecn_mode_accecn(tp)) {
-		if (!tcp_accecn_ace_fail_recv(tp))
+		if (!ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp))
 			INET_ECN_xmit(sk);
 		tcp_accecn_set_ace(tp, skb, th);
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
@@ -341,7 +346,8 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 		/* Not-retransmitted data segment: set ECT and inject CWR. */
 		if (skb->len != tcp_header_len &&
 		    !before(TCP_SKB_CB(skb)->seq, tp->snd_nxt)) {
-			INET_ECN_xmit(sk);
+			if (!ecn_ect_1)
+				INET_ECN_xmit(sk);
 			if (tp->ecn_flags & TCP_ECN_QUEUE_CWR) {
 				tp->ecn_flags &= ~TCP_ECN_QUEUE_CWR;
 				th->cwr = 1;
-- 
2.34.1


