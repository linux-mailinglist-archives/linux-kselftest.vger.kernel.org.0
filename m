Return-Path: <linux-kselftest+bounces-43012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07479BD56E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 19:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1293C5000C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 17:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893612C158E;
	Mon, 13 Oct 2025 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IaVpAIIh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013017.outbound.protection.outlook.com [40.107.162.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB3296BCC;
	Mon, 13 Oct 2025 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375038; cv=fail; b=XqWX2zl6b+qs+9pEgu28d1WF0gA40cs/zmuQZ2BrBjQ3m6GMCWdGh1DtY+2ZySHl59PSXE8cbRyyr91681osXrrhnsN1l/HcnhxL2/z1PL1KIJzJmnEYaEmJmhrITWMls3wl8fMQz9qE9Rha/hleQrVhLUn/4tgnPbLzqzeJ5Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375038; c=relaxed/simple;
	bh=VvjNrgUOG+2q9U54TORO0KAheXriJpHU764d8EWI48U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCCSi9RwuwH6yKvLDDWtzb9AcCQYbC9YI3l8/OfVJQA3vQ2MXnA3vwKoSF+IdNotoIspjTOMJRhs+IEVRznwKixajG3Kx1y4z7xeC4lZdgdv8CnB2EPeofc7aIyaDX6PZSXXgfjNs70b4wHj8wXHh49TqJlgd2EeuK1bx41JqZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IaVpAIIh; arc=fail smtp.client-ip=40.107.162.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l29YdNsTboEuS5PY7CAjOl4Q+H6ih9GJ4YLZmQeDVyF8GHjOUjH3bRr0Jm6bjLPUkYV/yM/rB1c5w4McWxqv+IBc32qbVRXh/xOtghG3rz/PXBmKJxgVYr2CywBWXF65DPCRqx3AGyDDqiKdk24laN/OWD/qD8BtXLJe1EM+jaai19BEvMvwiwwl6g+hufFdtoq9f/Z1mbTr6m+q+U3bmO+23A/rnmkcT6nZBVWFRPPPcZshIbxQOWO0O4CJ5wHC3mZhicL8cNNZ9ELzWC36IXvNjsJRj6OeIzZ/Td4D+zwnbDGthgTo81nNQtDj8GzRdCXpj6WLCD2v6XidzQWlNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeO35W+pzTJIls9iqnzLDzbVijoVPNDIsl5W0qy0yFA=;
 b=iWkIgp3l3SdnR3RH0L2f+xoJTsvbMR1sYQ+tV+4gxZjkLaXH6nHi7JwzI1W0ETjyiqZSTkEWm+gcP+eQarXgvsUyVTUHDSe3zsrb3pTAqx25TK62t7SDOXIJjp6evNw8J2ZAbWN+H8/3N0JqQ/SDWDMJxg3q/fTsdKvuJefs5j9ALp/4sgMuWUKhMdxozXzTp5Vu6gDrlccYtsZl2wk7aCtBNwqLMH9dsDESKGicFoNl3IgsidLa7Hhk/+mh2VztMTASDcge+v43PYm07rdUWVxDXwjuX2hHYmP6s8EDO9OMoYL12WBb1T1TeCN17F/EUoX501QpwfwGeJLDokP6jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeO35W+pzTJIls9iqnzLDzbVijoVPNDIsl5W0qy0yFA=;
 b=IaVpAIIheIK/m7aCEgWn5Xc613oLojSg5edjDpMjhDbKLITys9VE600OlmpbiZRIxbl/uOzFaWiONAuHEIIKkby9kY+fx8Yyyf4IuQvxHElZB//sVLQXy5PkvwqbIBhyrqhNGCDeR9pek6gyc7HeMerdPrSt1c0656irJTF7r2TSSurWfjLU7/fa418EXEMg/DSK1+b+r//F7ILqpCAtbzx/Wcz3UDHsiIkLdmtYLYSWhdJzRyklexmmVirL/qP9J2yR6fG0p/GCWW9spq6qlX6OloD8SQUhiZIKO7rf0NLYCymJd/Ks5mBLQcBf2q+qbzOpejmlBa3XYPx8uEIrqg==
Received: from AS4P190CA0025.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::12)
 by AM7PR07MB6342.eurprd07.prod.outlook.com (2603:10a6:20b:13c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 17:03:49 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::5b) by AS4P190CA0025.outlook.office365.com
 (2603:10a6:20b:5d0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 17:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Mon, 13 Oct 2025 17:03:48 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 778801C003A;
	Mon, 13 Oct 2025 20:03:46 +0300 (EEST)
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
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Olivier Tilmans <olivier.tilmans@nokia.com>
Subject: [PATCH v4 net-next 03/13] tcp: L4S ECT(1) identifier and NEEDS_ACCECN for CC modules
Date: Mon, 13 Oct 2025 19:03:21 +0200
Message-Id: <20251013170331.63539-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000040:EE_|AM7PR07MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db2231e-7f4f-49ea-9d7f-08de0a7a79ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFJOYTJlS21MTzdrQUJtdEQyTW5kdG53TEVtbHdPdTJRTDZxUnlGMlZadHY2?=
 =?utf-8?B?UTRFaXF4Y09JUVkxOXdkcVlTakdjS05pRTgzeU9vdHhTdDNjY2NmMU05UnUy?=
 =?utf-8?B?SjZoMlhuMTZzWE01YXVkUWZxWnFlRWlKTkpSWHFSVlNvL2tZTUtQeG5hazZp?=
 =?utf-8?B?dEY5djVUMEF1T2ExN1lBMHkvdVpmSEM2SkZQOGlXa2kzUmlxSkFabFVrY0Nm?=
 =?utf-8?B?UTJGYlBRcE9vTERWYzc4R3JOdkdUa2NFVkV4bER1R08rZEdnRkVPRis3NzFR?=
 =?utf-8?B?NjdmTEVldVlqUWg2ZHRRYVZnRHN0Um9jZUZiT0ZydFVud3FGb1VJYWY0S0Rk?=
 =?utf-8?B?YXRmOGd4WEJFaGxiTzVGNE1iaVMxT1JRd0lFenJicWM3czFLZ1Fjd2E5a2Nk?=
 =?utf-8?B?MGhaeC9Gb0hob3ZsWVYvbmVmNzJqcE5CbzZ1RXI2a1haenIyT3oyTEV4ekZS?=
 =?utf-8?B?TmxKeU1CMkg5bTlDditaNVpKL3c0QjJMbjByTE9tZmg2SjkzUTh3M2VoemZ0?=
 =?utf-8?B?azBtVTc1VDludnVyWGNvNXgrL3RndXVRMWJoeVFqbjUvekFoV3dTNTNSTWVH?=
 =?utf-8?B?cDRwM3c2WUpJUTdzc0wrbVFFWkM4K0RidDhDMEN6TjcweUc3TEJxZ3hsRGtE?=
 =?utf-8?B?TDNUd0pnTWNOT0VRN1FOYmg4b0hVZTZ3THhOTk9WZmI2cDcvSDRZckFZS09y?=
 =?utf-8?B?eDdOd0hMQSs4bUJtRkE0bFJsT294SXlvYi9jUlhHT1FZVnhmSXB3bGtUOXU0?=
 =?utf-8?B?V203VHpDU0ZBQk9RRjJtSUlBQmhHc0YxWVNMMTVwY2VpSldLdlNackFtcUU1?=
 =?utf-8?B?M2NTamxFV3JMblZHaVlNcHRJdDlsNlBuWUtZQ2NOVmNOaC8rbkROWUk1cmZP?=
 =?utf-8?B?MzlKWFFEYUVtU3JMQWFWbENrNngyemplNVptUjJ2K014RkI1K1RwUjk2YVRo?=
 =?utf-8?B?ZStHUzBuWktNZS9RY0JNc2p5MWlXSmdrYmxyTVFUcWhkQlZkUVArWmNEOU9s?=
 =?utf-8?B?ZTF2WU0xdjdNWjU0YnZ5YUNTSTR2TElXNmNsOGdydE54TGtYQWJLZ0ZxZTZC?=
 =?utf-8?B?S1diVjREUEVGUWZNTkFxTlhBb2VyVkhTT3hpVk5Rb0RVZ0N1THFPK24zTDhB?=
 =?utf-8?B?RXkvVjRlQzNLL1JVZ3liZGh2eXhKR3Q5YTlmU3pyR2NwYlRSenZDVTRmWTBx?=
 =?utf-8?B?TW1qcXRnYmp6RTdYV3lOdXp6VTRNT09QRHFrV2dBdTF3WUJ0emppK2srTDh4?=
 =?utf-8?B?LzdOdmhnUXdoaUVpcTRHcnBrYmNPMjFSRG1UV2MrbUw2RXhPWGd3WVRzVUdu?=
 =?utf-8?B?NjltckZVVVoyYjQ3ZUh1YnFwRW02emphSUhLQlk0NXFrV2Rma05MSC96Sk1m?=
 =?utf-8?B?dW9LR2dSWmpid2RVd0pTNlpMN0I0WVVkYjZvajI2b0RPWmhlT0pLd3Jnbkti?=
 =?utf-8?B?ZjB1cWFXZUNJSFpkeWp1NGRQUXRrK2xtN2xEZGJSYXpjYXI4Q0FiaC91aTJm?=
 =?utf-8?B?RWpMNHNvR3NCVTZNQm5BUi9YbzNwWDlvdSsycXNOU3RZVENWOUJKclRlRmJY?=
 =?utf-8?B?MThSTnF4Ty9OaHhVNmhISUFZSm9reStHSnRqWXErbEFzQndyaE9qTEEwbFZD?=
 =?utf-8?B?eFdXOVdtaGNTSlQ3OFNGSEFtRHZLbURraEZ5c3c5T2VOSTRhK2I2TzhYbEww?=
 =?utf-8?B?d1JESFZrYnNTZ0NNRWNBRTJhNm1wbXlXbWtiQm9xMkphRkkrRUhXMFR2YVRr?=
 =?utf-8?B?RlVZL0pJSXhYWndKOVhIQ1F6Sk10bFRHUUV2cmFqVmNDQS9RSlFCdkJnTVVl?=
 =?utf-8?B?NHRiUy9HcmVSOXpOOWlLTTZ6TTk4SEF5aEN2TEM3dW5Gd2FIWk9HOHlMeDhV?=
 =?utf-8?B?L2REQnVSc3dJS1ZKdTFqUFBMa0IzQVlqcUhMY0xlZkZYaSsrSGJuWHBmRXk1?=
 =?utf-8?B?Q2Z2R1NRNk9pVFBsem9ycHpIREJvWkI1RHRFdk1TRHcwREJ6VmdndmZnMkhC?=
 =?utf-8?B?a0tBa1RCVm16ZTlSbWlIcEVWVEN5aVlpeDVXTm5yWTlENmVUK1ViMEFkMlUw?=
 =?utf-8?B?UHpnUWNGVllEOCtTOVUvTVBlN0k4cGsydW0yU2F1WEtHUEpaaWNka0xqT1Vs?=
 =?utf-8?Q?JOwCBow8tBuZ6S3F/1S0sGziI?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:03:48.0437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db2231e-7f4f-49ea-9d7f-08de0a7a79ed
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6342

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
index 5ca230ed526a..8467c83e4aee 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -403,6 +403,7 @@ static inline void tcp_dec_quickack_mode(struct sock *sk)
 #define	TCP_ECN_DEMAND_CWR	BIT(2)
 #define	TCP_ECN_SEEN		BIT(3)
 #define	TCP_ECN_MODE_ACCECN	BIT(4)
+#define	TCP_ECN_ECT_1		BIT(5)
 
 #define	TCP_ECN_DISABLED	0
 #define	TCP_ECN_MODE_PENDING	(TCP_ECN_MODE_RFC3168 | TCP_ECN_MODE_ACCECN)
@@ -1190,7 +1191,12 @@ enum tcp_ca_ack_event_flags {
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
 
@@ -1322,6 +1328,20 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
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
index 8af527f4e2b5..27fba14bb3b2 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7233,7 +7233,8 @@ static void tcp_ecn_create_request(struct request_sock *req,
 	u32 ecn_ok_dst;
 
 	if (tcp_accecn_syn_requested(th) &&
-	    READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3) {
+	    (READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3 ||
+	     tcp_ca_needs_accecn(listen_sk))) {
 		inet_rsk(req)->ecn_ok = 1;
 		tcp_rsk(req)->accecn_ok = 1;
 		tcp_rsk(req)->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index bb3576ac0ad7..c7b884f173d0 100644
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


