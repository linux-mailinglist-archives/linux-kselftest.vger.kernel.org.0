Return-Path: <linux-kselftest+bounces-32948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1654AB6DB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 16:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81721BA125C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 13:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955F128469C;
	Wed, 14 May 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="glZe0iPF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2083.outbound.protection.outlook.com [40.107.103.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EA0283FD6;
	Wed, 14 May 2025 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231042; cv=fail; b=ExDRTlSrl3SAveWRJ8onU6Av7nHSgnSdig+69tLgpUSnw/9lLDaQFnhV3IYq4TRcXCSxOHhvfqv1I+DlRil/lbphTjofO98YYXCLTKlSpQdIacR9OKtcGteV7+/Ojk0Jl6z1WSFyEoLgZdVkXUiIYaH/4RAzBesjAlTha4vYPSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231042; c=relaxed/simple;
	bh=vEiMyl0tItWbzCFovRoAhoe5pTMFIHY13iEfTNZhetE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBpANJTcxdS/4LJ6ujf5t0m+UzkK/eTFMrBOtLWZk03cxOwSed7dXnnnvpab3SzujozU3CIpBehjmJge/QROEu+1iCDhpEmoj/EA3tWo25nfU8yYqWon4swzXEtpmj5jOihkbyvkpb4ebJDDTkKTMBSmynjNKtgtoav+Mp11aiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=glZe0iPF; arc=fail smtp.client-ip=40.107.103.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWZS4clTyJXQkwJCFz7LTbnqQPUU1MGx1jjrop5yvcS4ko/kWuq0caCJdo1lXaXGF/7w6ku0LMA8rxFp9e0o86+CUlqyuvOqMFX48dbHWKryedVT7AI/ST5o1OEzuUMZq80RDUd6qDJMwWt6YcetquVTAFGUEP2QaxqiwZf0BH0COYVCHogDJeS1iUULlGICgdEA8/lAOeg75Wo/9Y7LzFkoAY6pEVjipclfzLH9SxpXK4AaI/Nmi2cNnslYBl/PwWeLXSDZtPpI5GotO4OU0Y6i3a9fIheDH50WVG8WJwYwWc6gvwHxwHyWlFgVxBHg80/8Hk82/8vdm5wedxj4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmCn1YEUV++G3Rr42GWmORqhBlju/X5eu1+GdsG1HBg=;
 b=e8xqFAopmHa2WnYPG8x/MCHu+fKX9o9H5FKN81fcxi+Sq0Q+3EyZGXutEHkP6uWPHg03EndUH5SgYUlQqMhm/qRXXXf+ghA1iC9FwvsBUVApksBz79No+ktpFPtZcgquVDAJVC4jnL8uOq88k+gKIyDIz0l14PZYd4/lEMvhJ0tHNBa98ppFhIgMryon94U91gFNXDfFIN03ggeR4v8OLtWrJlwZ1RU7KM8u67/oPvJDsFY1VuGQi8mPn4idCMqoJOTZ7R0j3P98/P2bQggxCwnahKvPLbSHFOR678hGTOkzLnFSCfJ/M0EVcFWzu7apaoGcqhKVg3ruKW9sdnoiZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmCn1YEUV++G3Rr42GWmORqhBlju/X5eu1+GdsG1HBg=;
 b=glZe0iPFhSVUr2YrpT2ODjgJMBXefqFrYZ+/RFUav14Fj7Dolwdvrf+UFOKy9DVS8G/OHz0YnqgL2xwffAksIFdO0coSVTrw9Zzeg61guClOxX7lXF2lYxP3WITaSdZf6Gem3Om0YTKOQhRKc+wv0kFgnwq8f3ewJh7zJMFDFV7uZztospUVEWo4PWxFX0VUWRuBgBRZuCVj5UayxJ/8VZHlf06f7HWYu32tBsUMywh/vC9mbTT/NSwmNJzWqskjiv0b83ulYLPq41e4QsNXn0bKmiVVkxo/rxhYPaZRnkvvZ+QN6sINPQCo92E5GYBDc4ybAmOLAg++tk1nZwUgQA==
Received: from AM4PR05CA0018.eurprd05.prod.outlook.com (2603:10a6:205::31) by
 DB9PR07MB7868.eurprd07.prod.outlook.com (2603:10a6:10:2a5::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.30; Wed, 14 May 2025 13:57:15 +0000
Received: from AM3PEPF0000A794.eurprd04.prod.outlook.com
 (2603:10a6:205:0:cafe::67) by AM4PR05CA0018.outlook.office365.com
 (2603:10a6:205::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Wed,
 14 May 2025 13:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM3PEPF0000A794.mail.protection.outlook.com (10.167.16.123) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Wed, 14 May 2025 13:57:14 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 652D2200A1;
	Wed, 14 May 2025 16:57:13 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
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
Subject: [PATCH v7 net-next 13/15] tcp: accecn: AccECN ACE field multi-wrap heuristic
Date: Wed, 14 May 2025 15:56:40 +0200
Message-Id: <20250514135642.11203-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A794:EE_|DB9PR07MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b01e3d-619f-4d52-eb93-08dd92ef3b81
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?T1lnays3SUtMbVVKRWZxcnpnRStpeE5jZ1FDbjh5cDdBRkJRUGlxekJRU1hj?=
 =?utf-8?B?aDJ6ZzNrVEJseHNUeFJkQnBKWVJsNHJjVzBWRzhBM2ZVUFZ6dnhqRzZsNTZP?=
 =?utf-8?B?TVdBbC9GOGdmaFY2MStnRGx0YnZXOGxla3JmZHlleFJueWc0V1FhVXN4YUlF?=
 =?utf-8?B?MHhuZ1gyZzVvc2ZMbXVKdjBGdmN0YkRBdWNwQ3dHTkF6SWNLa093TXFEMVdB?=
 =?utf-8?B?S1NqWURhSm12T0d5T0MxL25jZDFybXd2Wkl0R0R3TjcxN3NjVUFiS0t3OUZw?=
 =?utf-8?B?dGtUa3BPc2Nzc1pBSk0zTW1IYkZCRTB4d1h0Z1MrSXo4K0ZGMjZ5SEhNdzJY?=
 =?utf-8?B?ZEdwYlZwZzVDY1ZmZWpjMTVXaWZWT0l0UTNmVk9JNUdKN0hUYnU3SjJWRjBr?=
 =?utf-8?B?enpZcFdyU3o1QU1QTGg2QVlRUG5LRmhaa3BHSkM2UDUrVkhJUHgwTW9UK1Jn?=
 =?utf-8?B?aVp2UXprMUUxZEtZcnRidlFtL2NlZlFaWW9MUm11SXZvUzZCWWd6OU1wT041?=
 =?utf-8?B?Q2ZWNndnTnRiTzF6M0hjOS9yYzh6LytsU1VPN0tnc0NMeThyREpma1BlUWha?=
 =?utf-8?B?TW5mUEFlQmJlaGJLY0RPb1o3WDE2aXlBQ0tOeGtSNVJWdW1WTWc3ckFhY3pB?=
 =?utf-8?B?UFBtd1g2Q3FjcXJWZi9EbUM4QXd5Q2FRaGM1Zm1hemtUOVN6NWR5RmRMcW5s?=
 =?utf-8?B?K0c0eHBhM3g0MkRsY1ZWbkZSUWJYWEM4YVJWb0FXdUlNbFVsV2FsSEY5VmtZ?=
 =?utf-8?B?Ulh1UE4vNVoyZmpKdkI4L2VtR2xHOFlSY2dnUlJ3ZEhmUVR2YmlHN1plb1Zh?=
 =?utf-8?B?UFhteVZQSkI5WkhlcXpETnlGbVlXRzJjTmM2NGhuQUpmeXNGbEQxRjdKRUZJ?=
 =?utf-8?B?RlFEcjhRVmJDVU1IekFXU0xBbEtGbkRIU3U2TkM2UkcySks3WWkxSnNwVE1U?=
 =?utf-8?B?QzFIbDBiQUpZbG9sN0hLd3k3VGNTbnVualUwQ0hHanpUYTcvQVIzZFV1SFgw?=
 =?utf-8?B?RHFHZURhRlZNN0dlYUUzRzNhLy9IRzl6TkNmOHpPQWVhdzQyeDE4Y3EvTHZu?=
 =?utf-8?B?MXhQeDJEM3BucmMwVFFnUTF5SGRxZjBlV1NUdXZLK0h4eVlRUE43MWVhcUlq?=
 =?utf-8?B?VDhYK051aU0wbTJndFpKc3Z6bU53a3UreXplbmRBaVhyWGxyYWpUdnBuNW44?=
 =?utf-8?B?OGZxWDhlcHBjd05WZ0NkN3VXYjhnb3BJTjlMczc3OWtWb1R1OVdKUnpsa2hk?=
 =?utf-8?B?WGdqeXo4Rlp6WHlmN0xreVF6U0ZYdDZMbFl6bVMxTTdRZE1RVkIrV1JHRms0?=
 =?utf-8?B?M3Q5NkJZY2JvbzhnRlhuMlVVS3VuK0s4TXB6VmM4Qm4vUENVRk1SMnY4TXNy?=
 =?utf-8?B?aUNXODZyS1Z5cmRCSUxXNktTSVpZUTZzNUNqekNhaSt0WnErUU5oZlRwWjhq?=
 =?utf-8?B?RFl2YkJkM2xTL0cvaVAxeU9Cc2RrdWhNdGRQR0g0cVRFazNyOTlSYnZraTVj?=
 =?utf-8?B?VUNqdzZwQXV2M1R6S3MzZ1FHaWZkem1WcWR5YmJ6Rk1ZcjR2VTlHaVE1ejQr?=
 =?utf-8?B?VzNuTlA0TUVzZGN6K2IzYXBMYnNCTnVBMUswV1poS2RnS1B6YkVwZ0l3QVdK?=
 =?utf-8?B?RVgrMEtjRmVMVTJDNjZqdzIrb2dzeXI4Qi80R0dXQkd6Y0h5MWNacnkvTmxG?=
 =?utf-8?B?eFhXMVRmM0JkYnM4cEpVYTRSTlNFYllwckJTWFFhK1J1UU84Y2VSVmtad1B3?=
 =?utf-8?B?NzRBeVJtQ1BFQTlDMFo4SEgzVDFCdWY4aW94ZU5lSGRqR21QWTA0SzA1Y3dX?=
 =?utf-8?B?RHM3R200bE8yN09EU003RWlxV2JPWWxCSFVOVXkveEZ2M0VTcWJBVjQ2Q1hB?=
 =?utf-8?B?MTI2eHdjM1NBN2syOXlnM0x3SFJpSjBQZjA0eWFVOWtYajZ2WnlhZDltdXMw?=
 =?utf-8?B?YTNiQTdBT1REZStaSTdUSFRJYVFER1EzUFozK2kzZFY0R05Ga2k2VTdGSnVQ?=
 =?utf-8?B?ckRvR3paazRUelhhLzJnUklXd2FFWVhhbW01WVArdnZwMUxrWjJTWHZ0SUZi?=
 =?utf-8?B?K2RxRzFJaTRMVVc3bUhVSVh5bXRjc1BqbzVVZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:57:14.9011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b01e3d-619f-4d52-eb93-08dd92ef3b81
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A794.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7868

From: Ilpo Järvinen <ij@kernel.org>

Armed with ceb delta from option, delivered bytes, and
delivered packets it is possible to estimate how many times
ACE field wrapped.

This calculation is necessary only if more than one wrap
is possible. Without SACK, delivered bytes and packets are
not always trustworthy in which case TCP falls back to the
simpler no-or-all wraps ceb algorithm.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f206c1a93a56..deced87f31f8 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -748,6 +748,24 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 		d_ceb = tp->delivered_ecn_bytes[INET_ECN_CE - 1] - old_ceb;
 		if (!d_ceb)
 			return delta;
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
 		if (d_ceb > delta * tp->mss_cache)
 			return safe_delta;
 		if (d_ceb <
-- 
2.34.1


