Return-Path: <linux-kselftest+bounces-34576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9106AD381C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD9C16E3C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 13:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE9623AB80;
	Tue, 10 Jun 2025 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="tL5fp2Fs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD9125B2F8;
	Tue, 10 Jun 2025 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560032; cv=fail; b=Ep+vBQYko9QRs2efiAV3JUwFPr8/g10U+NbwLw9O1/dIF+g/jrr21FvW38evygsWVMh4eqokaiyYFUdCLgeX27K5oSAr3NH5kn9/5fc0p1xda/yXn01P2HUywgZSN5I57li3iT7Gl6KGKRvZ8pI5TaKaraW8FognBAJ4lM+HQEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560032; c=relaxed/simple;
	bh=3mXu5OHGUO4POeqR1oToMk0bdE1HIUNpoaYUJIvQli0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWVD85ZbuFN+DgeRfc4DzjOQEF/InSaN9hrI1dlQj06LJYlwmeTFMHbmXzioZ+C2poVHPCQDYz3m3/6MYu+KqbD7nT530am1TEfwpLmszt/qOCUfWpeQc4UtaVkWLrG0wNPvhS7xG8bITY+ImqI+vj7cn1mO+v7Emyg6Hpnajao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=tL5fp2Fs; arc=fail smtp.client-ip=40.107.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENE96N0GPbip+fctFE4U7b0R6TgdqjLOoOHnbttcNML127j0x5AH/G92Ia1BqkxmbCi99avMWltXDrp/sw50R+XCGYlJrMhgnweWSoj43Q4i/2nKczNysPk6Z0Kyw/CrrQ+hNkhSoyKTzbrDp5JmQ5UdeNHy67BAsMhM4TK7WMKVKXn/PpNz8dDeY5j9CzOKfGy0chvlhp8VPZnMQqeqXYw3v8pXVoP6fkARLAxjHbKvtDj9ZZvAC+zkGfW5kcanwtVPIHN7Uh27MnmBIOVOVtYvjPmKvuuXCPKfEUyD6oUJdMlvLi6PFRWKf9FmITJTDMnBOQerVK6hvXN9UebR6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMbjNnY7BO518SVsKeKMhY3j8yJK4IP4rfkb2wVgnGM=;
 b=vNSRDL+sBuYvhzYYbWcnLK8EPETJy/R24qohy1Qxl9tVODrb6r1AFOF74GWRIO2+nhcIVpvlprLFK9+JTA213uvLWTyOMtVUnUShlVE7GsUZ7oFmDtDve1kNY0tg+0x0U37SWBsP64AaWZHHry46Kt17ZGBGZ5A2yPQJSmnnkbAJuhhCp+JYW/nD/sv7y7ZnB8o6zWosSLV2Jfpv1NLKRbUCuTWsZNIKjwouREbdpviohR2kAzt2AVu/yqKzVrmAFrY6rKXffBqoVIjmq43/2/YMlmkvyPfq9x1mUhwYX378TL6q8MqeIdNKeJ/ywXjrIL4yS4WEDzQxySfTN2zzsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMbjNnY7BO518SVsKeKMhY3j8yJK4IP4rfkb2wVgnGM=;
 b=tL5fp2FsKi/gGsCzrGKuf9PWGjo/mv6+8jk3aBdjbwZzL3BZ8JZ079OoidpXw/E2GoyyxaZOKeOHlnW2SkyhP++TdSnirX+tGZaTD7+7G6h+WZd5M05lShP7PjOlLuhN5Xh7XM5IIeCGxTVuuTUDh4UMj+GegEbAzJPJukS+T0wJCIBzSmC+3lVxOZWKUcDdJx4PC2jBbccATpxv87RzUjiCi+aqh+wJi/wKsYlIuuNLWjMe6dMy3oHL6vuNuO1eq6nGiuvfZN40dZWy1e2Sf31+ZHjEDseOY9aEwLmMPy4CpimnQCw07psA15vdPtXPfkbGJ3vIMfU/T9AhsJFFBw==
Received: from AS4P189CA0013.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::16)
 by PA4PR07MB8791.eurprd07.prod.outlook.com (2603:10a6:102:265::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Tue, 10 Jun
 2025 12:53:47 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::1e) by AS4P189CA0013.outlook.office365.com
 (2603:10a6:20b:5d7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 12:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 12:53:46 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 5839F2009C;
	Tue, 10 Jun 2025 15:53:45 +0300 (EEST)
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
Subject: [PATCH v8 net-next 15/15] tcp: try to avoid safer when ACKs are thinned
Date: Tue, 10 Jun 2025 14:53:14 +0200
Message-Id: <20250610125314.18557-16-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000041:EE_|PA4PR07MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 00756222-306a-4feb-df7f-08dda81dd6d5
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Z3hNUEZhbE1NWERQWm9TeHo4aFBiamRTT2xKYWlzYnJiU1F5OVhNcjd6NDdw?=
 =?utf-8?B?ZW9ob2VNd1FaQUxrU0F6S2YyVU5Jem5XTGZSY3FOcDFDTm5ycHJOZitKcTJJ?=
 =?utf-8?B?WFdlTmRpWkpLMXZRNnA2STkrZXRMdmg1WjIzTGhMTWQ2ejZNcHhZZ0pFNVU1?=
 =?utf-8?B?cVRVVEQ0MEZaQUZNd0gvRHkwdjZHWXFmZXhmQnFodmMzYjFvTGlxVWw1VURw?=
 =?utf-8?B?M0Q0TE1ZN01BNVU1SFd0SlEzY05BcTQxUVNQb3FkRmN2dldXZHdCdCtpNE9J?=
 =?utf-8?B?SWE0U1lubzJDbnVRRWF3d0lIaVNJaEpYSm92WkhpV1pnSXJRN0hPdVZBOTZ6?=
 =?utf-8?B?Z0ljWUhtbUI3eldpeXhRM3E2UmpvOUVyNjZPOElVUVlxbXZEZDhuaVNTS2dj?=
 =?utf-8?B?SWdqLzVqSXhBUnB3SnNoRkFwTXBhSUlDaWExZmlac29TaG5MU21BSk9zOXJj?=
 =?utf-8?B?VjRBck0vOUFuVCs3a1pVYVJMR21xYTk0ZVFIOXIwM0Jaa2l2RUdXZUtjMjMv?=
 =?utf-8?B?RXQ5UkhhYWRjYjE2N2JMT3AxMTNnWWJFZzlhQ3hwc2t5QTAvQUtaV2N3Y3hK?=
 =?utf-8?B?Y2w2VVdjQU1kQzVjc2RmZ0tpVzdOcnZqMEJtd0pKYlFsa1M1ZGFaM2wzYVBP?=
 =?utf-8?B?NUFKWHMwTGJjYTBjZTFMa0dRbCtQZ2FQTjZ1WGpSRkxOdmJtTm1WM2JWV3FD?=
 =?utf-8?B?STdLNklhUHpNbGpIQ0Qwd2gvZitwR0lsOUxpZUZmdTZua2pIS1NtemFUUGIx?=
 =?utf-8?B?cHBaSmF1Rzk3eUFQbUZKc3M0K3VLUU8xbXZQY0U1U1NLbmZZVWh3R2tIRy9Z?=
 =?utf-8?B?dUhDanhLNTYwL2pLaGdvMFg0V21kNWV3d3lwelNDNldpMXJkdG9IZUZ4YU5p?=
 =?utf-8?B?NThHMHVtQkVvZ09pWW53K2FvSXFPQUY5b2F5NG1kalByUlcySHY4TDNQZlg3?=
 =?utf-8?B?ZDgvMUwwRDlESDJ3dFdRMnZOaUpiV2VJdXdEdml0NC9vODdBdVFmZGFKVDBt?=
 =?utf-8?B?TXNjQUNMMWZhQlpkekVXc2FKTmFCemhsM2RORXdlZXNQNVJOSG9aTXFtdW9O?=
 =?utf-8?B?dmMwTFo5ZHpnTElzOGpRVkFqNzkyWnZBTytYRlJOdkMzVGsxRnI1TUdyN1ph?=
 =?utf-8?B?YnZLYVhKNW13c043WDd5NnZTME5OVUNYNVR0WlFqMjRYZlVPZjhoRFV5NUFU?=
 =?utf-8?B?VWxhS1NYbmVQS1VtYnJvZG8rQzR6ODd4Q0VtandZSm93WVZJc00vL0kwRnZI?=
 =?utf-8?B?Y2JzRVczWFRNMlNmOWg4QUd6cEFTSHhJRHFPVXFMaWgzV0lpblFHZFFqbk81?=
 =?utf-8?B?Y2plbVE4VVJHNm5GSjdLZnZ2eHRuT2diL1B3NW5ab3ZYZFFMcFdNNjVDQVEx?=
 =?utf-8?B?NnMwSXpFcWNCekFyeDdUKzZNSVZXUjN4clRmeXlEck0weStxU3A4YkUyMW9y?=
 =?utf-8?B?SVBRYkxhUjZUSFJXZnI1S29qN1Q2bEVwYXpSbjNJUzEzM3ZDbEFHMFh6aC9E?=
 =?utf-8?B?bnh2WjBoZzNPYXM1SWk0Q3ZwRWprTGRqZW9DMW9tbmhOUWVZZ3JrclpQUGVh?=
 =?utf-8?B?TW94R0ZQY00wNmEwalRxRFlEcEZQdExYaE5kWHRlUFNKZDhqaXlmaGt0TVF6?=
 =?utf-8?B?R2k2WlNhZU1YakVlSXdWalVlMGkyZ2czZTdXVldldmREcGoveTRLY2lKRlVC?=
 =?utf-8?B?b1dyZ2h0MVVVVWhpNE5MWS9PRW9uTmNRTUdieXlGUUVoV01vdjQyd1FuenJK?=
 =?utf-8?B?MUxLRnNjVTg5bENLaWtXLzNzeTdteXhWUWhRVXB3dDVlNlI4VXpUcG5maEYx?=
 =?utf-8?B?TVdTNFlNTnpwaDRUUllFZjF5bSttb2psaktGMHVmc3dGUW9ETGU3NDgxcStp?=
 =?utf-8?B?VjNsT1Q3OEh4SHRISWVxSVJsTk1GUExEdWorWlFEUUxkVmQrYzlWSFpSZ1dM?=
 =?utf-8?B?bFdXQVFHVC9yOUtvVGhwQlVmSkpkTHpCeUowVzNIeWJpcStHODV6MWxzRU44?=
 =?utf-8?B?YlIrekhKZjBuSWFOMktLQXpJSTFtd05JYjJUYmlHNmFvMjc1dDFPREVydnZW?=
 =?utf-8?B?ZkU2L3RYaXBYaHNXTlJ0ZmgvWk8wbTQyT1M5Zz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:53:46.7611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00756222-306a-4feb-df7f-08dda81dd6d5
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8791

From: Ilpo Järvinen <ij@kernel.org>

Add newly acked pkts EWMA. When ACK thinning occurs, select
between safer and unsafe cep delta in AccECN processing based
on it. If the packets ACKed per ACK tends to be large, don't
conservatively assume ACE field overflow.

This patch uses the existing 2-byte holes in the rx group for new
u16 variables withtout creating more holes. Below are the pahole
outcomes before and after this patch:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ecn_bytes[3]; /*  2744    12 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 177 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ecn_bytes[3]; /*  2744    12 */
    u16                        pkts_acked_ewma;        /*  2756     2 */
    /* XXX 2 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 178 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 net/ipv4/tcp.c                                |  2 ++
 net/ipv4/tcp_input.c                          | 20 ++++++++++++++++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index af76d4f9b33a..2e6ef8290aff 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -105,6 +105,7 @@ u32                           received_ce             read_mostly         read_w
 u32[3]                        received_ecn_bytes      read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
 u32[3]                        delivered_ecn_bytes                         read_write
+u16                           pkts_acked_ewma                             read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
 u8:1                          wait_third_ack                              read_write
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 91d60fd4b229..9fa2a1d0e2f4 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -346,6 +346,7 @@ struct tcp_sock {
 	u32	rate_interval_us;  /* saved rate sample: time elapsed */
 	u32	rcv_rtt_last_tsecr;
 	u32	delivered_ecn_bytes[3];
+	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
 	u64	first_tx_mstamp;  /* start of window send phase */
 	u64	delivered_mstamp; /* time we reached "delivered" */
 	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 15286f6c6504..61525b626c68 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3399,6 +3399,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5160,6 +5161,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 6fb845e9b3aa..f509e432e2a8 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -704,6 +704,10 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+#define PKTS_ACKED_WEIGHT	6
+#define PKTS_ACKED_PREC		6
+#define ACK_COMP_THRESH		4
+
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
@@ -723,6 +727,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	opt_deltas_valid = tcp_accecn_process_option(tp, skb,
 						     delivered_bytes, flag);
 
+	if (delivered_pkts) {
+		if (!tp->pkts_acked_ewma) {
+			tp->pkts_acked_ewma = delivered_pkts << PKTS_ACKED_PREC;
+		} else {
+			u32 ewma = tp->pkts_acked_ewma;
+
+			ewma = (((ewma << PKTS_ACKED_WEIGHT) - ewma) +
+				(delivered_pkts << PKTS_ACKED_PREC)) >>
+				PKTS_ACKED_WEIGHT;
+			tp->pkts_acked_ewma = min_t(u32, ewma, 0xFFFFU);
+		}
+	}
+
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
 		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
@@ -771,7 +788,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 		if (d_ceb <
 		    safe_delta * tp->mss_cache >> TCP_ACCECN_SAFETY_SHIFT)
 			return delta;
-	}
+	} else if (tp->pkts_acked_ewma > (ACK_COMP_THRESH << PKTS_ACKED_PREC))
+		return delta;
 
 	return safe_delta;
 }
-- 
2.34.1


