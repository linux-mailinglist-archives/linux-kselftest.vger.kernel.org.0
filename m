Return-Path: <linux-kselftest+bounces-29289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19212A663AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D113A8BED
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 00:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD332E628;
	Tue, 18 Mar 2025 00:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="r3wdl8jg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D66315AF6;
	Tue, 18 Mar 2025 00:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257673; cv=fail; b=ob1GBX5/QnLiGw9BLNhZwFlNRYm990/Vy+ipx8GVABc6De1cKpMWPJisBRhZK36NP5AzEsUNHB7anv9xnqb2hgXJjU0t3ZGBrH/wXu/x6u3R22+B+ULn8jbc2URJlf5Sd+blq7l0hG+r89KjVwTQ+EelaptctKlqMA4XXqirmgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257673; c=relaxed/simple;
	bh=a1NQRfa9dVcqvUOHGRW8NVzGEoGbqmvAeN8tjExGJKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bLL2EbKMKr0yQWBx8JtKzVTaCe4QAL2wM2sQ+CZn8qKApREEFhbxKFII/+s6mgv5sihlNRyIdV3u+LMfYmJbvfCEcJprW82hbUzl8GjhtKxjcVghlDigeShz75VDiqdXbfRe2WZl5Pe3mw2e2gcUu/pdFec42BtG5wfxkEu51aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=r3wdl8jg; arc=fail smtp.client-ip=40.107.20.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Emu3NWVFYmnkqB/Yrfd0Ldi2nyifAnIdMaeqIzo9nAFzfkonjKWDKuey1VR2E12J76FvhjqFF37rl5Tqrm+whKdpwWBJIPCAgKCQacqAqtZ3MX1SsfvhTqvNHmVHBhVJdN6a6Yoc5gYs2DZ4u6rBG0DK5yTGOv9/wVS6xRO5SLDsvjwPQDnc4qUQoNgyJIqtMXf+8g0ulm+TR76/l185qkujry5gDXDFdYOz8T66jsR0z0rzYDWdi0XcRuZhoXgmpf0CGF1xtFXf/g/XIM3qm/uCcqJAVzhPy2jXYqy1SoFs1B3acPzbnw2hOl2V55PSUPnN9r8IjzL7MZE0EQaSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyZtOjeyLMQPNv74yecIOz4up/0Lt/pLlFRRh9khBMk=;
 b=G5ym9wihiQAr6s99yjv4qH6iusganMeMhSO42h6eXGh/mglos/cbmt5wIfBXW0Vtk+47MBG+u0Nws/EPWgLjEvn5AJDP+MjvYTFuwMUQp6EARazOmbBnbZ1A8pTOEEsm4Q2yK2AOmn9HvO2ENbWcRYiQ0EzkXr4KYjm95Fx37BjLElbEefVoWj2v9Sl+UxpqcEVg3DBk41WlC82f8zKmGN0e1mjeGJv9UvGCPbs+wDX2QierStJ6kbfEbU0ajGlURTdPSE/lIwQzRGjX/d03egLBFTnxvKbUjwMINQaUOO9Z84ezxNIknX98hVQ0cBL4Szm3RxDF24O2VrxTDjkLTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyZtOjeyLMQPNv74yecIOz4up/0Lt/pLlFRRh9khBMk=;
 b=r3wdl8jgSCAt7/+Wfn30JIVPDjRbV/LKWgtuIJ51d/HNe7D6z3giHhHqNSDmTEnDLZZ2ztACeJgb/9Y/3R5oESLPOV2ZIrcV2oubdAG8Zvt5B3SpU8FQNPnj0zuRu824ae2vJT1CWXnOiLafrfFuv0YgWghsqtINdqK6gMiKXRMVhc0//ZOidifc5HTpDVlXY4+GIFhZyTQ7pdh7KBG+rFHqJu5mKjhVr8uF/KcipCIlo97zc33/1D+GCBUtrSDlSz+3liSWWHDArYIJzIMC81J9TWVvml3oLnCUc9Y7Ff6jsBEX97QzFdOFIH1U9aoexZIcAef9tdZCIgZqndYIqg==
Received: from DUZPR01CA0243.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::11) by DB8PR07MB6444.eurprd07.prod.outlook.com
 (2603:10a6:10:13d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 00:27:48 +0000
Received: from DB5PEPF00014B91.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::33) by DUZPR01CA0243.outlook.office365.com
 (2603:10a6:10:4b5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 00:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB5PEPF00014B91.mail.protection.outlook.com (10.167.8.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 00:27:48 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 52I0RNBi024935;
	Tue, 18 Mar 2025 00:27:55 GMT
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
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>,
        Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v2 net-next 02/15] tcp: AccECN core
Date: Tue, 18 Mar 2025 01:26:57 +0100
Message-Id: <20250318002710.29483-3-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B91:EE_|DB8PR07MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c6f6f6-f0d6-46c2-d070-08dd65b3b609
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NGwvSk1wWEZ4NmZMd2o4U3NGNURJb0tTWlFOajFRMkNsQTljblhRbVFwVkNr?=
 =?utf-8?B?TEg3WkNxOTY4Yzh5aEM4dzFnR2lMUkR5UENHUHNZaSs2b2JXVForbjVkOGFJ?=
 =?utf-8?B?SkxGMVA4ZThzQmllS0Z4N0lxYVVsdXkxY2o5YllBdlAwTTlRWlpvS3oxamtH?=
 =?utf-8?B?R2UvMnEzdTJNUTFaUHRmWkExMnJ1LzV1TWh1ejMwUktaZ2tzWkNtUjlHblM1?=
 =?utf-8?B?Slh2OGVxcUdaMFZzaVhGS2lVSU15MUJwVngxVTdPM2JPWHR0bUQ4UDJWU3FD?=
 =?utf-8?B?amlzZWp5clF5WHB4ekEvTEh0VENBWmZWRlpIbEs4NDFETEdlQ04vVGhSbTRz?=
 =?utf-8?B?WisxSm9MZUxEbjhuVXBHaWoxa1JuM3pKZ1ovSVZ3SjZDYnovdTdwazM5d2l5?=
 =?utf-8?B?RzhXZEpJSCtoYkVDNFkvQzFPSjZTTmE2UjJzTERXWmZIS1pDY2ZyS0dCYWpp?=
 =?utf-8?B?QisyWmZicGhKZUhwZmc0TFVwUHJyTFU1M3VHOGJCZ3R2Y3E4dkNzbnREc05w?=
 =?utf-8?B?MmFRdk41Ym11aVBmbWUyRlJUTUtHYmkzZ2ErYUlMcWVyanlpb2k3WTRkS1dE?=
 =?utf-8?B?bGRPV0FUdlFtbURHd0xLTVV3UllDMkQwWUt2MHZ2TDJkS0gzdzNkOFlUY2NH?=
 =?utf-8?B?akQ2SGZ4NWpBOTIwSzN3cGo1a0Z2MWhXOW9TMUVPUGNhRVFMU2lMSnlHTWRK?=
 =?utf-8?B?Tlg2M0JFNjJVRHQ3UTRMbWNxQVB5U3lrWGlna1VjMFpPOEtNVUluTm1VL01o?=
 =?utf-8?B?NDE1YU0yZkZSVEtVdlA1bXhlQzczUnRsU3dodTRZMGIxTTduSU1Xa0NmMVFy?=
 =?utf-8?B?OXJWZ3N4cGc5OEVZZlVCUktYQTdGVHRFVTQyRUY5LzJYdjNYR0ZNdGdPbC9z?=
 =?utf-8?B?czlaVUovdFBtVDZ2KzA2b25vZUNMQUwzcUQrZDFEdGt5UUxpU2ZpVmdCQlN2?=
 =?utf-8?B?TVozZXR3SHVoRlovNUZuYW80dHhxZ3FGeTJxbklhK2gzcnFIRGU1cU01WkNE?=
 =?utf-8?B?WHRTc0d5RFJJVTMxL24wVldrOTBYdy9DcG5rSnR5SHp6ZkNLb1RrRWZiN0dJ?=
 =?utf-8?B?ZlhBUFgyZ3NlaytkWmRtNXhtYythOVpVQ3hWZE5LWHFmTG91WXN4SHo2aUky?=
 =?utf-8?B?SDJ1djZDdUpUekdndU81dmZiay9xUFkvazYrbDFyWEZlUDczVWVWYnVtYzJ3?=
 =?utf-8?B?OWV4YjNEQXBPMS9Hd0U0RU8xZDNoUTZjOUFZRGszRVFwSFJneWpTWUhncng5?=
 =?utf-8?B?dDE4L01WL0RsRGNEY1ZOendIVlRMclpuUW5yaHFrWGV1M0c4bmdoRTBNdFk4?=
 =?utf-8?B?QU1aN2JuZi9ONlVGYUlnM3AxMlduOVZ1TlpGM1BtWXVXUXNVL3dKQXVURy9I?=
 =?utf-8?B?bnN1eTdLM2hNeTY1ZFNPSTBFS1dKeWVrclhDd2tWREo5YlVNZlhNTG1zNzdG?=
 =?utf-8?B?NGY3VzFieUhMRlk5Q2tVbFUyejEvS3NWd3pSU3pyUWx5ZnVGVkdwRkxMekFo?=
 =?utf-8?B?N3E1NDZXWWFBbzNiZnhjL2pIK0VKeFhIOENLWVNITHlpaW5TRDBuVDhNVnpv?=
 =?utf-8?B?Y0MyQTdXbDRwSUhWaG8vbmlYUkJaNkxMWTZEVVp4aFhUeW5xVHp5TXhQbWNZ?=
 =?utf-8?B?WXA3YzRFWkpndFZWZjllVGtQUFVnejkySWlOQnBpZ0VjMnNob0tRSXE3cG1V?=
 =?utf-8?B?ZG9IRHNrMzE4UmhHUjlOc3VsQ2ZpMWZsUnAxaTd2WU5PKzV6ZU9tMFhYaWVt?=
 =?utf-8?B?c3pINExnSytLOG1GQ1FGUGZ1dnMvbmNhbGRjUS96aGwwd1dIYU0yTWxsQ1RM?=
 =?utf-8?B?bmpLVi9oT0cwMDU1ZjRMdnQyOXgvbCtiVkhBb2FBRE5heG1mQUVvU0FJVisy?=
 =?utf-8?B?TUZFS1NkMnBaKzhETTVwR1lpOWk1Y1VnNmRhVFhhQ2g3UmFtd1YxbVBwaHVT?=
 =?utf-8?B?U1E0NlR4YjFBRTlHd3Z1SXc0V0dpTUVzUVFsSXJCTnp0am56WkRzQkpJK1lJ?=
 =?utf-8?B?MXhLSjJHRE81NS80WXJacVJuRHE4L1pOandWYTlZdEhSdkZvcWhkdUJUMmpn?=
 =?utf-8?Q?dtgmpL?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 00:27:48.3032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c6f6f6-f0d6-46c2-d070-08dd65b3b609
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6444

From: Ilpo Järvinen <ij@kernel.org>

This change implements Accurate ECN without negotiation and
AccECN Option (that will be added by later changes). Based on
AccECN specifications:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Accurate ECN allows feeding back the number of CE (congestion
experienced) marks accurately to the sender in contrast to
RFC3168 ECN that can only signal one marks-seen-yes/no per RTT.
Congestion control algorithms can take advantage of the accurate
ECN information to fine-tune their congestion response to avoid
drastic rate reduction when only mild congestion is encountered.

With Accurate ECN, tp->received_ce (r.cep in AccECN spec) keeps
track of how many segments have arrived with a CE mark. Accurate
ECN uses ACE field (ECE, CWR, AE) to communicate the value back
to the sender which updates tp->delivered_ce (s.cep) based on the
feedback. This signalling channel is lossy when ACE field overflow
occurs.

Conservative strategy is selected here to deal with the ACE
overflow, however, some strategies using the AccECN option later
in the overall patchset mitigate against false overflows detected.

The ACE field values on the wire are offset by
TCP_ACCECN_CEP_INIT_OFFSET. Delivered_ce/received_ce count the
real CE marks rather than forcing all downstream users to adapt
to the wire offset.

Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h   |   3 ++
 include/net/tcp.h     |  26 +++++++++
 net/ipv4/tcp.c        |   4 +-
 net/ipv4/tcp_input.c  | 121 +++++++++++++++++++++++++++++++++++++-----
 net/ipv4/tcp_output.c |  21 +++++++-
 5 files changed, 160 insertions(+), 15 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 159b2c59eb62..5cc6ecfccb17 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -295,6 +295,9 @@ struct tcp_sock {
 	u32	snd_up;		/* Urgent pointer		*/
 	u32	delivered;	/* Total data packets delivered incl. rexmits */
 	u32	delivered_ce;	/* Like the above but only ECE marked packets */
+	u32	received_ce;	/* Like the above but for rcvd CE marked pkts */
+	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
+		unused2:4;
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u32	rcv_wnd;	/* Current receiver window		*/
 /*
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 830db65e5487..d8ac90ef391f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -415,6 +415,11 @@ static inline void tcp_ecn_mode_set(struct tcp_sock *tp, u8 mode)
 	tp->ecn_flags |= mode;
 }
 
+static inline u8 tcp_accecn_ace(const struct tcphdr *th)
+{
+	return (th->ae << 2) | (th->cwr << 1) | th->ece;
+}
+
 enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
 	TCP_TW_RST = 1,
@@ -963,6 +968,20 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
 #define TCPHDR_ACE (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)
 #define TCPHDR_SYN_ECN	(TCPHDR_SYN | TCPHDR_ECE | TCPHDR_CWR)
 
+#define TCP_ACCECN_CEP_ACE_MASK 0x7
+#define TCP_ACCECN_ACE_MAX_DELTA 6
+
+/* To avoid/detect middlebox interference, not all counters start at 0.
+ * See draft-ietf-tcpm-accurate-ecn for the latest values.
+ */
+#define TCP_ACCECN_CEP_INIT_OFFSET 5
+
+static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
+{
+	tp->received_ce = 0;
+	tp->received_ce_pending = 0;
+}
+
 /* State flags for sacked in struct tcp_skb_cb */
 enum tcp_skb_cb_sacked_flags {
 	TCPCB_SACKED_ACKED	= (1 << 0),	/* SKB ACK'd by a SACK block	*/
@@ -1772,11 +1791,18 @@ static inline bool tcp_paws_reject(const struct tcp_options_received *rx_opt,
 
 static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
 {
+	u32 ace;
+
 	/* mptcp hooks are only on the slow path */
 	if (sk_is_mptcp((struct sock *)tp))
 		return;
 
+	ace = tcp_ecn_mode_accecn(tp) ?
+	      ((tp->delivered_ce + TCP_ACCECN_CEP_INIT_OFFSET) &
+	       TCP_ACCECN_CEP_ACE_MASK) : 0;
+
 	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
+			       (ace << 22) |
 			       ntohl(TCP_FLAG_ACK) |
 			       snd_wnd);
 }
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 989c3c3d8e75..494741e4d977 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3362,6 +3362,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->window_clamp = 0;
 	tp->delivered = 0;
 	tp->delivered_ce = 0;
+	tcp_accecn_init_counters(tp);
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5059,6 +5060,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, snd_up);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5066,7 +5068,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 97 + 7);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5c270cf96678..e3fc1e0bcf57 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -342,14 +342,17 @@ static bool tcp_in_quickack_mode(struct sock *sk)
 
 static void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
+	/* Do not set CWR if in AccECN mode! */
 	if (tcp_ecn_mode_rfc3168(tp))
 		tp->ecn_flags |= TCP_ECN_QUEUE_CWR;
 }
 
 static void tcp_ecn_accept_cwr(struct sock *sk, const struct sk_buff *skb)
 {
-	if (tcp_hdr(skb)->cwr) {
-		tcp_sk(sk)->ecn_flags &= ~TCP_ECN_DEMAND_CWR;
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (tcp_ecn_mode_rfc3168(tp) && tcp_hdr(skb)->cwr) {
+		tp->ecn_flags &= ~TCP_ECN_DEMAND_CWR;
 
 		/* If the sender is telling us it has entered CWR, then its
 		 * cwnd may be very low (even just 1 packet), so we should ACK
@@ -385,17 +388,16 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 		if (tcp_ca_needs_ecn(sk))
 			tcp_ca_event(sk, CA_EVENT_ECN_IS_CE);
 
-		if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR)) {
+		if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR) &&
+		    tcp_ecn_mode_rfc3168(tp)) {
 			/* Better not delay acks, sender can have a very low cwnd */
 			tcp_enter_quickack_mode(sk, 2);
 			tp->ecn_flags |= TCP_ECN_DEMAND_CWR;
 		}
-		tp->ecn_flags |= TCP_ECN_SEEN;
 		break;
 	default:
 		if (tcp_ca_needs_ecn(sk))
 			tcp_ca_event(sk, CA_EVENT_ECN_NO_CE);
-		tp->ecn_flags |= TCP_ECN_SEEN;
 		break;
 	}
 }
@@ -429,10 +431,64 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 				bool ece_ack)
 {
 	tp->delivered += delivered;
-	if (ece_ack)
+	if (tcp_ecn_mode_rfc3168(tp) && ece_ack)
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+/* Returns the ECN CE delta */
+static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
+				u32 delivered_pkts, int flag)
+{
+	const struct tcphdr *th = tcp_hdr(skb);
+	struct tcp_sock *tp = tcp_sk(sk);
+	u32 delta, safe_delta;
+	u32 corrected_ace;
+
+	/* Reordered ACK or uncertain due to lack of data to send and ts */
+	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
+		return 0;
+
+	if (!(flag & FLAG_SLOWPATH)) {
+		/* AccECN counter might overflow on large ACKs */
+		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
+			return 0;
+	}
+
+	/* ACE field is not available during handshake */
+	if (flag & FLAG_SYN_ACKED)
+		return 0;
+
+	if (tp->received_ce_pending >= TCP_ACCECN_ACE_MAX_DELTA)
+		inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
+
+	corrected_ace = tcp_accecn_ace(th) - TCP_ACCECN_CEP_INIT_OFFSET;
+	delta = (corrected_ace - tp->delivered_ce) & TCP_ACCECN_CEP_ACE_MASK;
+	if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
+		return delta;
+
+	safe_delta = delivered_pkts -
+		     ((delivered_pkts - delta) & TCP_ACCECN_CEP_ACE_MASK);
+
+	return safe_delta;
+}
+
+static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
+			      u32 delivered_pkts, int *flag)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	u32 delta;
+
+	delta = __tcp_accecn_process(sk, skb, delivered_pkts, *flag);
+	if (delta > 0) {
+		tcp_count_delivered_ce(tp, delta);
+		*flag |= FLAG_ECE;
+		/* Recalculate header predictor */
+		if (tp->pred_flags)
+			tcp_fast_path_on(tp);
+	}
+	return delta;
+}
+
 /* Buffer size and advertised window tuning.
  *
  * 1. Tuning sk->sk_sndbuf, when connection enters established state.
@@ -3920,7 +3976,8 @@ static void tcp_xmit_recovery(struct sock *sk, int rexmit)
 }
 
 /* Returns the number of packets newly acked or sacked by the current ACK */
-static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered, int flag)
+static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered,
+			       u32 ecn_count, int flag)
 {
 	const struct net *net = sock_net(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -3928,8 +3985,12 @@ static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered, int flag)
 
 	delivered = tp->delivered - prior_delivered;
 	NET_ADD_STATS(net, LINUX_MIB_TCPDELIVERED, delivered);
-	if (flag & FLAG_ECE)
-		NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, delivered);
+
+	if (flag & FLAG_ECE) {
+		if (tcp_ecn_mode_rfc3168(tp))
+			ecn_count = delivered;
+		NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, ecn_count);
+	}
 
 	return delivered;
 }
@@ -3950,6 +4011,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	u32 delivered = tp->delivered;
 	u32 lost = tp->lost;
 	int rexmit = REXMIT_NONE; /* Flag to (re)transmit to recover losses */
+	u32 ecn_count = 0;	  /* Did we receive ECE/an AccECN ACE update? */
 	u32 prior_fack;
 
 	sack_state.first_sackt = 0;
@@ -4057,6 +4119,11 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 	tcp_rack_update_reo_wnd(sk, &rs);
 
+	if (tcp_ecn_mode_accecn(tp))
+		ecn_count = tcp_accecn_process(sk, skb,
+					       tp->delivered - delivered,
+					       &flag);
+
 	tcp_in_ack_event(sk, flag);
 
 	if (tp->tlp_high_seq)
@@ -4081,7 +4148,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	if ((flag & FLAG_FORWARD_PROGRESS) || !(flag & FLAG_NOT_DUP))
 		sk_dst_confirm(sk);
 
-	delivered = tcp_newly_delivered(sk, delivered, flag);
+	delivered = tcp_newly_delivered(sk, delivered, ecn_count, flag);
+
 	lost = tp->lost - lost;			/* freshly marked lost */
 	rs.is_ack_delayed = !!(flag & FLAG_ACK_MAYBE_DELAYED);
 	tcp_rate_gen(sk, delivered, lost, is_sack_reneg, sack_state.rate);
@@ -4090,12 +4158,16 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	return 1;
 
 no_queue:
+	if (tcp_ecn_mode_accecn(tp))
+		ecn_count = tcp_accecn_process(sk, skb,
+					       tp->delivered - delivered,
+					       &flag);
 	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, flag);
+		tcp_newly_delivered(sk, delivered, ecn_count, flag);
 	}
 	/* If this ack opens up a zero window, clear backoff.  It was
 	 * being used to time the probes, and is probably far higher than
@@ -4116,7 +4188,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 						&sack_state);
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, flag);
+		tcp_newly_delivered(sk, delivered, ecn_count, flag);
 		tcp_xmit_recovery(sk, rexmit);
 	}
 
@@ -5953,6 +6025,26 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
 	}
 }
 
+/* Updates Accurate ECN received counters from the received IP ECN field */
+static void tcp_ecn_received_counters(struct sock *sk,
+				      const struct sk_buff *skb)
+{
+	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
+	u8 is_ce = INET_ECN_is_ce(ecnfield);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!INET_ECN_is_not_ect(ecnfield)) {
+		u32 pcount = is_ce * max_t(u16, 1, skb_shinfo(skb)->gso_segs);
+
+		tp->ecn_flags |= TCP_ECN_SEEN;
+
+		/* ACE counter tracks *all* segments including pure ACKs */
+		tp->received_ce += pcount;
+		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
+					      0xfU);
+	}
+}
+
 /* Accept RST for rcv_nxt - 1 after a FIN.
  * When tcp connections are abruptly terminated from Mac OSX (via ^C), a
  * FIN is sent followed by a RST packet. The RST is sent with the same
@@ -6215,6 +6307,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 					flag |= __tcp_replace_ts_recent(tp,
 									delta);
 
+				tcp_ecn_received_counters(sk, skb);
+
 				/* We know that such packets are checksummed
 				 * on entry.
 				 */
@@ -6259,6 +6353,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
+			tcp_ecn_received_counters(sk, skb);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6299,6 +6394,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 		return;
 
 step5:
+	tcp_ecn_received_counters(sk, skb);
+
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
 	if ((int)reason < 0) {
 		reason = -reason;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 124b2e95bb0a..36afa3b40396 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -374,6 +374,17 @@ tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 		th->ece = 1;
 }
 
+static void tcp_accecn_set_ace(struct tcphdr *th, struct tcp_sock *tp)
+{
+	u32 wire_ace;
+
+	wire_ace = tp->received_ce + TCP_ACCECN_CEP_INIT_OFFSET;
+	th->ece = !!(wire_ace & 0x1);
+	th->cwr = !!(wire_ace & 0x2);
+	th->ae = !!(wire_ace & 0x4);
+	tp->received_ce_pending = 0;
+}
+
 /* Set up ECN state for a packet on a ESTABLISHED socket that is about to
  * be sent.
  */
@@ -382,11 +393,17 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (tcp_ecn_mode_rfc3168(tp)) {
+	if (!tcp_ecn_mode_any(tp))
+		return;
+
+	INET_ECN_xmit(sk);
+	if (tcp_ecn_mode_accecn(tp)) {
+		tcp_accecn_set_ace(th, tp);
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
+	} else {
 		/* Not-retransmitted data segment: set ECT and inject CWR. */
 		if (skb->len != tcp_header_len &&
 		    !before(TCP_SKB_CB(skb)->seq, tp->snd_nxt)) {
-			INET_ECN_xmit(sk);
 			if (tp->ecn_flags & TCP_ECN_QUEUE_CWR) {
 				tp->ecn_flags &= ~TCP_ECN_QUEUE_CWR;
 				th->cwr = 1;
-- 
2.34.1


