Return-Path: <linux-kselftest+bounces-31317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15529A9714C
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD9F441B73
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51651290BB7;
	Tue, 22 Apr 2025 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qSL3wPqp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0522918D0;
	Tue, 22 Apr 2025 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336322; cv=fail; b=S3/y98ms8nvHO5y/4Vpr5Uxk8d8oxoh/Kuw2JapRDg6cd8wFfXgTpmEGDs3xIIgHo4PlwQAObnEhxNcB5qvJ7SUBuuLdGTu0KYow7SmYg1il+hBOy1AJbzr3EzwZMyNlf2Gqctw7L/FpeSccXjzE38rRGIgVP6Mzk/EWyfAVh44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336322; c=relaxed/simple;
	bh=+ezEZy8hckPaea1lF4ilsBt0GsZjvoaMn1f9l0j0RCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICK/hz6ALlBU0sfPYYHYpla70z/LB4si8/DoIqpCUvdcdNGND1/0ARyEO/cnm/pfkpAMnK3ofKxarDh1Uut8PtSiY221EF2VxlA0mrq85ie75jQqBqxp73JatKvgtgA8kod1nrrDHVsXF9S3jppwM1hhMaALpeVkShxX4X1P9Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qSL3wPqp; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixmA9MUrUO8XTT1++QTRQhA2xHRDeLWeQ1BGMVq6w4yRoWX0hmbK+N85jQ5RGeFSt+2yqhQ//cicczw1zYR+dFFK3jxlcyBbrk9jcSRA3+WhwB3ouIlvUtLqlI+CNdmz27aE616lD0YJ1MGUh2tWOYYM9EaOn3Lvgn98R+EtJ972Grs0urEcEAeeMP1K1LuzbM0wMG6CCYH1w22q0EXvIDoH2d0W6KW70g0QFI/h6bUAUZxeT5fhm6JrGDLtutzgtmNI96PHwdlpLIiBGcnCZhCPGMVWf1xnD99SbxZmSXPU8cmx3xymQ0pju36MQzdIzB09Xa7SX7wfa7swzrUlHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ix+QtM7JJKtuEJJnzOOAErViBOEsmOlScq7uOdppACk=;
 b=umxC+whgWII0Kvhhx3vox3waW3nTujsU7L9qvq7sbw3rA3hBLSo7dTa5ui0Sx7XYLPh+yv1PfhZd3mmZFmh2FTudOq2mIRtfvYtFByYMNlnKXtBLr3brbDrxEWRijNYmLEDGTHDnf0ts8+bw5V7PpbLSJ8+3k5E7uDwYvqIMbf3ncZS5xU+U9unWm2HqYXFQbYKq6OistF7h2gdqgl0e9PX9zjgWw68zozYHQU48lhgvHzA4W4/ZiXU/V+JsJ9WvHgxKr0d8OQ/trM/K2OTun6XgT70zi0Eavv7A8XDket/ip5s2LCSn3fkpRktMkxig0/1tuU9oEJ0mQa7A07PvZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.29) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix+QtM7JJKtuEJJnzOOAErViBOEsmOlScq7uOdppACk=;
 b=qSL3wPqp30J933RKROhigfUuIQ1xlHKs/MLr/9BscMVjnv8XRAyUhLAgDLrwjf3RXBpajN4oirYG4gbeBxMoUJaRK3A6Bud7L/4PHJdtff4rpSAPDFvAc9WDmscrCELmg4PV3b2/Eb6g0jjPJGJx1g8GHR7SsAmaQ4BR0TnDzK7GUR0yVMsHMYy/f+PSpqLevzrhMj+i2VxLsRw25m7zpz+UWhzBr01n1APOFDAZpAmKBBaC/1LzL+kcSH3biiMBX4skftN6duLSyaIEmjMU9CqkaB+Khrjsz/I1F+XR24CqGtzbuYkyS/Rb144Kk7Hf67xGqSv9b0TvJlMkxi/N0Q==
Received: from AM0PR10CA0056.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::36)
 by PAWPR07MB9791.eurprd07.prod.outlook.com (2603:10a6:102:390::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Tue, 22 Apr
 2025 15:38:36 +0000
Received: from AM4PEPF00027A5E.eurprd04.prod.outlook.com
 (2603:10a6:20b:150:cafe::6c) by AM0PR10CA0056.outlook.office365.com
 (2603:10a6:20b:150::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.34 via Frontend Transport; Tue,
 22 Apr 2025 15:38:36 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.29) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AM4PEPF00027A5E.mail.protection.outlook.com (10.167.16.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 22 Apr 2025 15:38:34 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 37BC420A2F;
	Tue, 22 Apr 2025 18:38:33 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
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
Subject: [PATCH v5 net-next 08/15] tcp: sack option handling improvements
Date: Tue, 22 Apr 2025 17:35:55 +0200
Message-Id: <20250422153602.54787-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5E:EE_|PAWPR07MB9791:EE_
X-MS-Office365-Filtering-Correlation-Id: feccb209-1c39-4954-e056-08dd81b3be35
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?S1JRckVrN1NFYklsSGVuRjcyaklTdWlvdFRHcXVyNmdNWGpTZ3grYmY2Sk9k?=
 =?utf-8?B?YTFBck5JbW1zV0lUcklQTVV4YTBxOEFqbE1SdVVZenBFZnkyU2RHbTJSM3Vy?=
 =?utf-8?B?V255Q3RUb0YrOStSc0ZPWU84a1BFeFBUa1dpS0ZsaE5XU3pHOXNRcjVWSHk3?=
 =?utf-8?B?bks3a1doT3pUSlFEMlVyckdSN0tTWGR1S1dtUTE1dStTVWY3Y0srcktHZWhO?=
 =?utf-8?B?c3NsVTMzU1IycFNseUkrZlpxL0svazlRNkZLV1hQNTk5aUJJQUZIdHlMNTZ6?=
 =?utf-8?B?RWZ6dGJoWUU3MFE5ZHNvZHozbVpJQStsTURQTExLc1ZVWnpaeFQwL21MeDlB?=
 =?utf-8?B?UWRiSFRLVU02UzVqc0pROVFnSmdPaVFmNTFDenVwQ3VpdS9ac1NNcHNxRlpT?=
 =?utf-8?B?aUFKdDFPSTFES2FucXQ2WnQvQzhJQmhoUlNYRE51SVVXMTdkU21waXpBeGds?=
 =?utf-8?B?aGVUc1Y5a0gyNFdGWlJVUWhFSHViNnVraTlsYStNYkJHTDd4NUNac2NzRlMw?=
 =?utf-8?B?UmZKMitpbVZoa0RWNHY4d0t6SGhYeXE2bE5Dc0JKUTVhaFQxYUJlWmd0TVZN?=
 =?utf-8?B?VFVqbnNheWkyWDN0ODVPZ3Jxd3FaeXNHRG5oNDlqa1pUeHg0enc3UHZWejdt?=
 =?utf-8?B?QXByYjNSK1J3SWhTZ1U4ME9XRXdxYzhmd0N1a3NHOGpIVGk3VFR2cE1OTWdp?=
 =?utf-8?B?R1ZIUmdrWThCRkhWUE12YVNHcTNzb0Y3bXg5YWkzMUY0cnhQT2pDYmdFSXV4?=
 =?utf-8?B?TGxLSmRoY3ZkRXQ4bDhxaDlXNnQydnB1YUdNQ1l2eU4wQWFXMDVuZEdEUWZ6?=
 =?utf-8?B?U0NQTlFZQWk3TVpqUW1GekxKTTVBbzZTR2ZOZzY5UEFNSEgzdWhXOS9nTFV2?=
 =?utf-8?B?RFltZGhrdjh2SG9MK2cxUnduY3ZaWjMzQklTVnZZd0wwU1JRQldKZ2NBQTdB?=
 =?utf-8?B?U0VveGUrd2lGbmVhaHJGRTN1ZWYwdFBPVkxuSG03TlpUaUZ2eXgyZnZVb1Jx?=
 =?utf-8?B?SXd0dExwUnZJYnpZT3B4N3VGUFFrMXpIMyt3cmhnTDh5TVNmeEJpcy8wTGZB?=
 =?utf-8?B?aDcvQVUrL2QwMTEreEEyYjgzbUNPQ2ZwN3YwemRhUFJxanBsSUdkM1lvcnUv?=
 =?utf-8?B?YXdqS0x5YkMxSy9NQkxQL2RzdEYxRmUyQTZuL3JIY29ZMWNRWjl3UjY0eStO?=
 =?utf-8?B?cmQ3QUVEakt6S3d2c05ESEJFUFBENVZnZHlNN2taWDl0Y2pDRnYzVXpIaXVz?=
 =?utf-8?B?VndzaTVDenlRY1pBMmZKVXFzZUJpNnArdGo2NDU2N3IraU5TNFhoOGtERkQz?=
 =?utf-8?B?cFRmeUxITjFsVHBRVk5nN25mN3VFVm9VdlJvd0VoMVphNG5DZ0RISDJGUmlH?=
 =?utf-8?B?RXUvUW5Nb242d2plRzl3Z2ZvRWkxdEFhRjQ5NTJYYy92azI1RWVMYkoxYmhi?=
 =?utf-8?B?emM1REhpVU1xWno2MmRWQVRlekRJWGo3Yk8yNmtHNUVzRURKZWRuTnlSalVk?=
 =?utf-8?B?ak1iZ3hkNDlGOVV2Y3RlbmZXdkh3KzhnZ3JaYjduSDdYNGdTTXoydXVScmQ2?=
 =?utf-8?B?YllNWjZzS2ozTElxQzBURTYrUXlUVm41SVhyRk1KTzh0cUdnK0ZxanRTQUNN?=
 =?utf-8?B?SFZTb1dKWUxqQ0hEeUhVYjZqNGlpRFlNTVpjOStqTmRrNytRMFVYN1pLOWF3?=
 =?utf-8?B?Ylhubms5OWhlaFNTTlYrVDNqTVRmMS9qNWI4OFZQVlh2MC8vNTAwZ0JobWFU?=
 =?utf-8?B?UzE1cWo4akdDMjd6bWFva2ZocGpRQ2EwWEhQVGg3ZTFOeHF1QXJ3Z2dKaWNw?=
 =?utf-8?B?d1RwN3o5QW1aQ2lPZ2NNRGdPcWVvMVhpYUtsTmF3Nm5ZVldtR0dSdnl0OUlG?=
 =?utf-8?B?QzBqNmZGclNGMkNGOGxFdTIxamZrdXh6WUQwSGlpYndSNm1zS2NkVU1saEEz?=
 =?utf-8?B?WGlNOFQ5OUZuS1R4dVhHMWJxOHY5SE1jWnJHUldzNzQwR2V0YTVhM1dRR04x?=
 =?utf-8?B?RVgxR25uYkZiRWF4bldvWUUzcUNUalFvZHRWVGNXVWNCRUNyemlaOFEwejhI?=
 =?utf-8?B?WVlYclc5KzY3S0xWWEFqeTVlZ2RQZU9ZZUlPUT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 15:38:34.6340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feccb209-1c39-4954-e056-08dd81b3be35
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9791

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
 net/ipv4/tcp_output.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d63f505a30e2..ad97bb9951fd 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1103,17 +1103,18 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
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
+		}
+	} else {
+		opts->num_sack_blocks = 0;
 	}
 
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
-- 
2.34.1


