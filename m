Return-Path: <linux-kselftest+bounces-34569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F44AD3847
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA5F9C0E0D
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 12:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B832D4B77;
	Tue, 10 Jun 2025 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="pLS+Wu0R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64272D323D;
	Tue, 10 Jun 2025 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560018; cv=fail; b=Zd6X3wSquFxlS2xovl51miwJQdiRHt8ryHjTlyRNeuDRDFpnE7tG6cizzPh0YX8VwtNbQ2/CLdX+7iFtk/SElGCwNeVabkhliN+xhF7rN8UxKBlhMTXqoKaW0njKBY4tTkm2wwV3wBKoR8BBFoTqH04l8wEqAhKmNww+lp5E8Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560018; c=relaxed/simple;
	bh=ynTSXhycaqQ9sonKj5rSCWovdzfKAzKVaahpu/laZlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBY+DLmaotAvSocKyRTbHEVdaWijxg+9f8d0rC5XgpnZl2KtavlVZA3mzWPIGicwp5TFrOOeeI3O0JnI+uwRZC+b2MKw09Cym7MEVzVNW8EjUuNArVAyt8s98LLmEMtlS/Dm6ht/Dys0zzE6YzWO1fA/mf/Y2/06rXufe1DcHBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=pLS+Wu0R; arc=fail smtp.client-ip=52.101.66.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9OG3MGjHZvyvX84QZ4U5DR8x6nxxNLIY/Ec/KW8MjrH91/5JBcSC8rgowCtgTa9mYCti1XlpCN9mhQ8TvEwC0CbP5OROMRL6pr+kqp3xlCtu4I3wKqcYJGt1Vlxa6NesxfqTDspd5kk+8yhYMWYZlDcho2CdKv6bEzV4gx9vDq3A7UKTEs6oZXVJb/0xX/fysxukxkXv7lBAG+e4GjPnEg150UsiT2nay36ApczkNcmxgCdCa7AWEu/DMsPIJnQYF+hhUF9EAtvW9eoG+0lmpYiKVgqTv3p+QMVgEc448pirmobdCBm/ztmEGUecGSBCZEGt3rkQjUUrHFmLltD8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyUtvGYL3eEFM1/OKjBfAdQ0HEVs1drfaFrYSAQSGlE=;
 b=TiGEmKr5HHgIR5cJtKvoNRXuim5a54z2I+GCR1XtxXB8sdoZGaZWiS/4pM++QLRi0tLSFQRSgWjfaUdexpLHZgX+p7bwgQG7jUxVzGFCkT0P/rsYH/bcf+3ITIplSeeh4SFqgS9UZpcHBAtH9be+bD16kcn1IJxwVjD95xdRhPK6GJQrMI9ATjESXljteSQJKIIeq01LcE9/ngyFoutLhbWNduDrddfH03ybV8ZZCYCxtrieJOd0qwGFZQYNfTTMkKiwI2RlBTBg5CH6a2XZpRsAJtP1nEqsN/YW05yY2SV4b8HbDzpNQWh87YMiLlnDVRjQYFP7tVc+OehnEFBqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyUtvGYL3eEFM1/OKjBfAdQ0HEVs1drfaFrYSAQSGlE=;
 b=pLS+Wu0RiE37S3lDMONQMTrgEAQCgDOkhjuCpsNkMvj7B6FzAewk3J0EaxcJ67OTLTYgGUGA0UUctGpJ+KDANVbvdKABEsOFORpU0mN4nQUFnbe7Dti3voO58OJQfJ1zn6xOssoiIn6VQG48g9D/7wFE/Cbi8snCcQLYdyz4WQzU2TeG2sOtVYYqoM4fMph9WgCVRvk5ehY8VNpNaoiMM8quYcROOgssAlNFV2Mbw8LE+r5OhCHZwLTu6nUXBjn5vBhlR1TCW81iYMxAdIN4SNfbWRjAtH5iw0WfPATlZhI0gX1f6QWrTaM0W7MfPnV+REGY7jdcSbK/5+JLSOfvpw==
Received: from DBBPR09CA0016.eurprd09.prod.outlook.com (2603:10a6:10:c0::28)
 by DB8PR07MB6458.eurprd07.prod.outlook.com (2603:10a6:10:13f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 12:53:33 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:c0:cafe::bf) by DBBPR09CA0016.outlook.office365.com
 (2603:10a6:10:c0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Tue,
 10 Jun 2025 12:53:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 12:53:32 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 6F08820099;
	Tue, 10 Jun 2025 15:53:31 +0300 (EEST)
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
Subject: [PATCH v8 net-next 08/15] tcp: sack option handling improvements
Date: Tue, 10 Jun 2025 14:53:07 +0200
Message-Id: <20250610125314.18557-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039233:EE_|DB8PR07MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7ab243-a79d-4529-02f1-08dda81dce96
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UzEyWEZWS0d6aW00dUpNaW1YK1BVZmFvY3BGc1lRcUVuRldGUi9qRXlkaFBz?=
 =?utf-8?B?cUNjblU3SEtFMXRrM0pPa1NPdFFiVUQycVRaMGc2YUdmcGRZZDJwdVhWVFZR?=
 =?utf-8?B?QU9TcjErMEZDS0x3SnBPd29ESE5rM1MzWi9VdVVIbFpQTnpIbE1JaCtMcGJH?=
 =?utf-8?B?eHNCMU53aFMvVFMyRmUyVXZsdld0ZU9tTWZtaGh2YkV3T3A4ZC9vdjFFVlRs?=
 =?utf-8?B?Zm42c3BmY3JIcGNrVHlZQ1h3ZVFNOUdBczZqd0R4ZTdQa3B5OERwc2crUHlH?=
 =?utf-8?B?VHdESUVpanNjMVFoVk9jVk1vYk9nbXAzTGg1eHE0VzFaWGR6UDZPa3NwY0Nm?=
 =?utf-8?B?VTh4a1NMTk9FVm9QTnMrNFlrTXRGc0lWTGxxMEpSSlVCTEQrVXgxNDZqUmZu?=
 =?utf-8?B?UEw4N0ZmTzY1eFpnRmpTblI2V0RyakRJSHlyMkFySE0yRWtDWmkxUGtBam44?=
 =?utf-8?B?QkFqTkRaaHV2YzBBMnE1NUl0KzRtV1FPSnZaa2Q4MXdZTzc5MTJKcmh4d0JK?=
 =?utf-8?B?elJWeTZ2cFpvUUNRcWo0TFNTSmwyYTcvTHNCTDdlTU9pc0xWWGZzMnVDYlFE?=
 =?utf-8?B?VzVXRHBBd2FEdTQ5RUVGVXZFRm83cUl5Y3lydG93c0VkV3RaeGlBV05zWlF0?=
 =?utf-8?B?TWFCV0VhL2d4bWoyd0xpUFdTbXJ6ZHJmTWs5K21KemZqZzQxbEMreUZWM1Jk?=
 =?utf-8?B?QlhpT05ONmVpR2t5MHZZdlk2SmM5WE13MWNSZWJ0ZnJqWHRRRGtLSjJZSHJp?=
 =?utf-8?B?RzJmTjRCYUtqNFhNTVJTYzZXNWlQVkNpTktRanJaNGlwdFJBVTN1ZlBodWJD?=
 =?utf-8?B?TTNZOWtnV2NqaHUzWmoyYTl3c2xNZmZFaTBJL1VLOUlwaE1tUHRGOUVwWmJB?=
 =?utf-8?B?RHpZYTRSSTdFdmdiOGZyTk9ISFU1RjV2d2QrTE1FL2VUS05WU21yNEtUYkU2?=
 =?utf-8?B?Z2xvTVVqTFFnTzRzMmtwVjhuejM2WjFjd2h3eE5kZyt1SzlGZlliQjhXUWF4?=
 =?utf-8?B?Si9kRDJidEZKYWxyd2xpOExrRk5oMmJqb1BDN1A4U0JzeGxYZlNVbWhLaTFY?=
 =?utf-8?B?U043cTl2SzEzejFSQzBIYWVOTnlLMG5wSklaRkRNSlM5YStFOTlBVmZmVFZ4?=
 =?utf-8?B?Qyt1S3VheUZlNHBsMEZmVURTczYweGNPMWRXdVRFdktSYWVEbURqOHVBTW02?=
 =?utf-8?B?ZjduSlVXd2dsK29PR1FKVlV3WnZiTnJoYTF3Wm9ISkdoVFUrdXc2bm1zVDlD?=
 =?utf-8?B?c2hlL2RrWmIwa2FiUUNHcTdaUXprcDlkS3pCcVJ4cU00RS80MDRPeUk1ZHNo?=
 =?utf-8?B?YWhqODQ2ZThnbWFqRC90Q2ZpOUhTL2NCakpxZUtzNVpFNFdGN2tEMGdYclRC?=
 =?utf-8?B?WkRzN2J4N0pDcGpoeDBuc2E4VHl6dGtTNmZ6Nzk4N2V5dVZ1K2RMVFlkL1FM?=
 =?utf-8?B?WllzeEFVWVZEeFNVWnJuMHlkSTJmb3Y5Z003RnhRMnBzd3hpejZOR3lUUjVO?=
 =?utf-8?B?Z0RacTVtcXZJbDVzVnQ3RUxnVnloVEJ2YVFZRkM0V3czMGFJL0dUNlJDZVo4?=
 =?utf-8?B?amN0R3poUDM2Z3BZRWVmbzdSMDI0TFFpeDNwQ3U2MXExeHAvQkNDMzd3Z2Rq?=
 =?utf-8?B?QU9ROCtMT2F1NXo4Z1BkV0xmd1JPWTZtS21rRUlCTGpnNVk0RjJId1NVTnZ5?=
 =?utf-8?B?UXgzdDRyanpXY3VtempWdWQ0bE1NT0pGeW02ZnBtMzdHeTJLb1hLaVpwSXYy?=
 =?utf-8?B?VmFka0ZpYmpNaU9pY2ZNeWFhOElYR2dkL292NkthdTVibmxGUHZFRCtrMEpN?=
 =?utf-8?B?WUh6Q3pYbWpTNkNhQWdFakMwRm9LeitsNVIxZWhzODB3TlhrNGxDWkN3amJw?=
 =?utf-8?B?c1JPT3NSQnFHRnNXdmIxd3ZJdk1aYmdHRkJXOU5CbzNBZm5ZeTkybmZXYzg3?=
 =?utf-8?B?TVoyWS9MYjFSWEFzSC9qYXN3TTNsb2VsQ0hDY2pDUUxlV0d6Tk1PUTA0RWps?=
 =?utf-8?B?c1V5dnFnRTU2OElISFhNVWVYektySTVDZWV6aFRmQ3l1dXdrM1JKbHdrb0tS?=
 =?utf-8?B?a2IxOG1aN2pTd3pCaVFjc1dHQVdOT2xWbW4rUT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:53:32.9113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7ab243-a79d-4529-02f1-08dda81dce96
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6458

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

---
v8:
- Set opts->num_sack_blocks=0 to avoid potential undefined value
---
 net/ipv4/tcp_output.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 5f3243612044..78e78bca0db9 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1092,17 +1092,20 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
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


