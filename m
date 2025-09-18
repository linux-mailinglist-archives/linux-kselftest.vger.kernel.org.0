Return-Path: <linux-kselftest+bounces-41869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F8AB85FCF
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366C11C83DEF
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6763031618A;
	Thu, 18 Sep 2025 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="fIuYRV63"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010053.outbound.protection.outlook.com [52.101.84.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A8F30EF86;
	Thu, 18 Sep 2025 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212507; cv=fail; b=M1IRKboehEr/UKiODBYrc4u5oIWmO+UeVbMhTIQB43izfsW+wV0Aj5v9V5dhxw5vuDWMDIJJS6tJULlcLG7QR9StattnetV7oWVCTPrikPkCtq6YPwginBQGmTzaVVa4ARlfW5driCwICvxECbE0rrqGmUUJZ0j6A4uIYujJu0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212507; c=relaxed/simple;
	bh=AS8LRd8WnRISDMzbwSRGx++FGL76f+bJI4N51DmefVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QS9+J+QxaFuXKqNrD7VLdMFRCpTqJOpxYaZtIwup2uxwUQ65S+JqMSgi8r1ZBMhkL8GAbXCyoBVYfaPdtSfr4YyYE0DSd8qf4kL+S0k1l6dgKRBtkQhagCQG3o+GPATA9QW0GR82KNeoZ21DL3NN/6SQBBOmXFRn7RE4vAudQLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=fIuYRV63; arc=fail smtp.client-ip=52.101.84.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9oYbXwVCfEVRF4Ki2LhnWV9LzxF/Oyaq3DlxgvwyG1eUnfmngkC3xp251WG+ylepKG61nWEIs+jhrtDPH88KdtkcmY81a0oswJJ0E7AB6kL+2deS3DXIrw1OWXQFrbJi7lCUxdkSM0UFuYQlp5/6vWl0JYaHbg+FsVkoblQF+gvqK3K5YCUymG0S1Q1AM9ZXtwJkcsPWAliucMgSEjyPxrKcMOvEiDsFlHrzMTRQR3/6QpXq0CWxzSSuXVAnzEff2wNxtqBdG+vSlqhSlVYMabBWClz4YF2rnaGSrjm5VOAwjEXEc/w8/pVJS8ALvgXsvRtUYV5MMrUVGZ/SzSYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7w9wDF+YqEby/9o2KiJhDwk6kp4zcG+D2XeNIipBpVQ=;
 b=JnpxxMQDThtoRFjkrkSOb5kHMUATPSb00Ji4QFs9rNkjbzo0CQZ12FT/fTEc3EhxFLU+gUsATkui3FMW8sm9JfBQkzpaAk0YyMSUPv1mTIBtMIt/N5J1q0lvD7VL6JnCVyJ3U2YoknAInd6Bro4HNJ1VpBQk+/lCUAje6O6oLtfNFw9KQ2AbgCKDGWPh2F2cmq0sbvFUWLkHyXyLBQVIEe++Mc9IWOtLSx6ctLpVoizeSQQ8UMHBGtFbcYXJ2X0MLwIMrQG4q25rIJ33mWp7iz6wTL8m7weQh1NU6ZFe/a2XyZXCFTSdKBCUc5EGqou34u/jIdgKrneHO2phqnbzkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7w9wDF+YqEby/9o2KiJhDwk6kp4zcG+D2XeNIipBpVQ=;
 b=fIuYRV63z2WpQY2EMQbr0yyG41o1SlWwAYIpHGAv7UTrpyKRsBjfCSw+0FJA4fcfANhRAKDGLvTVo4TxU3vd1SCdJ0o+vJNp1S4d2mH2hQoFE8nx1AkC7i7oq9B8e+sBVadlKXdr3DZrhUUO82G3A4bhATHYtUpzUEo5eIZnkHaZii70Qui+RWX+Qh6KT1/MIHwQut+qXO/mWgnvB9jPGO0Kk1YFgT4VdiRt/rT/K//nhj6iMQRGc3M9UIZkZvzeQhQQjEAgxIy8/YsrpshVLEn8yloo4fWSq7of5SN/kf3VS1MebfSepesVCA8uUkK1Ye1GACUZ7CPnr+5dO8pv3Q==
Received: from DU2PR04CA0190.eurprd04.prod.outlook.com (2603:10a6:10:28d::15)
 by DUZPR07MB10077.eurprd07.prod.outlook.com (2603:10a6:10:4de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 16:21:40 +0000
Received: from DB1PEPF000509E2.eurprd03.prod.outlook.com
 (2603:10a6:10:28d:cafe::f3) by DU2PR04CA0190.outlook.office365.com
 (2603:10a6:10:28d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 16:21:40 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF000509E2.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Thu, 18 Sep 2025 16:21:39 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id B135C200E2;
	Thu, 18 Sep 2025 19:21:37 +0300 (EEST)
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
Subject: [PATCH v2 net-next 01/14] tcp: try to avoid safer when ACKs are thinned
Date: Thu, 18 Sep 2025 18:21:20 +0200
Message-Id: <20250918162133.111922-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E2:EE_|DUZPR07MB10077:EE_
X-MS-Office365-Filtering-Correlation-Id: 086d8dc0-516c-4c28-ab4e-08ddf6cf7246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzFhQkhNa0Q5VTlhakJtNDFsVzFxS1hnUU55SDFLazFZWjVrSUdNNTY1eWlk?=
 =?utf-8?B?dnBmUk1WTTJ5bnRMNXpTUmxZQWw1c3dUY3Z0T2xRdnNYbS9iV0E1bHhzN2VP?=
 =?utf-8?B?clhxYSsyL3JZbytTc01VeVVBREdnRmh0VTYrRUMzNGl1K2FGVHlhNXVjdCtD?=
 =?utf-8?B?TU9RMVNYOFZ5cW0zOTV6SGNuQVFSNmZCYWxuU3c4OFA0OGg1Wk9DZGZnLzhE?=
 =?utf-8?B?WEJwbHZLQUkvb1ZjR0I0THZTN3o4LzRrdi84c1JiTkJBYVV1TEo3SlpZOVRo?=
 =?utf-8?B?ODY0NTczSHljY0pLVUZqV1lTRGdtaFlNOENTeDJLWW9tUkZSNHNFTWQxWThZ?=
 =?utf-8?B?N1dHL1Bwb2JsUnZOS3E2aUlBdzlxaU14bTkyNEFXT3RMcEVkYXlKR2hxaE5C?=
 =?utf-8?B?b2xrbFVtWWRrOWlRelVFU3ZhTDhkT2ZFbVB1NldpLzhBbHZqNDYrVCtsZFNo?=
 =?utf-8?B?dk9UckJlT2VXSlVhTzZERGtBTi9tZXZzamxmRjBXQU5SSGlVdUR6NUhnYlVF?=
 =?utf-8?B?T2s1SWMvK1hnc0RuN25iOU9kQUN5bFExY09TdTF1bGlTa0x4QUsrcDlOWmJI?=
 =?utf-8?B?SUlTcUxIbDA3QzlKbDZBVnlhVlB2ejFxdG5tWXhQR3MyRDhxR0xoRXZmYk1R?=
 =?utf-8?B?VWdoNHc4cWRKeFV4SUNsdW4xSXN3ZUppaXNua08vQ2loQkZEOWE0OU5ZbDlC?=
 =?utf-8?B?STBpV01LTS9NUTR2c2VYU29qcldiUGkyV0tYQ1JXNWppZVJTMG1sYndWL2wv?=
 =?utf-8?B?cmErMjNaV1FFLzVQdkNEaWk4ZFp3bnJYOXQ4V2lUZWN6MUNxc0h2Rzd0R1U4?=
 =?utf-8?B?RWVWdlgvWXI4dXZGSEY0cWNOODVXai9BNUxEMTN0RW9IR0xLZDlSakQ2Q3Y4?=
 =?utf-8?B?QU5RWFhVMFMxKzNoV1ZNdnlISnJMamx4Zmp6K2FqNGhjeGpjYjduNnhEc215?=
 =?utf-8?B?VzZINDMxUjAzUWl6eEpDQk5JcEowOHQ1WDAzWkwzYmdFSncvc3R6aTVEWklr?=
 =?utf-8?B?cjRHaGpINXkwUzVHNTdqc29XRnhaUjErVnZYMy95RmxnNjFYWjRyMkNHMVNO?=
 =?utf-8?B?TmRDMlVvVmcyQWZkRW03cE5jTW8xekFuZlo3aWlBTFNjMm93aU15d21pbkI0?=
 =?utf-8?B?czNaa3dlWklicjBWNENSdWk1MVhnaVFLSlFZcVIyMmVJTHpEVGJXcFdteUI4?=
 =?utf-8?B?Zm5ya2h3UVBEMDJ3SzAwQWtPTXJpcG1ScC9hcTBxcnZFRkE2WXBtVTJsb29S?=
 =?utf-8?B?UGNnaVRCaXhLMUVMOElBVG0ySkc3bmxNUzE5OG1YOXRXc2pGYVNGbXpwTml4?=
 =?utf-8?B?emNURDU5SGFTSmdTQ3V1QmJNNkNFUU5rOUdNcXZuU0pjWHAzYXlhWERhWWRt?=
 =?utf-8?B?ZGZtREFva0k0bFM4cnZnQ09wZjlWL0lNM3FPbVVSWHZzVUYrRFFrVDUwdTZq?=
 =?utf-8?B?ZEtoNnZMU0tMblZTamFKV2dKb0l3VDZsbFl1YzdHZjNDL3BxUlJhMDB3SG04?=
 =?utf-8?B?OUluY09MazVMQy90TnhMRTYyZUxHMWYxUWZQdmNIcEk1dEZ6OFo4YzVDbEdW?=
 =?utf-8?B?Zmt5MTl4WlJLWGkrSG82YlY1Mit1VUErc2ZQVmdHYkk0S3JjNnBkZVlHeXFz?=
 =?utf-8?B?U0dVN3R1ZWcrajJwbnZVVllFSzFZNi83UFM3Mnk3R1Y4NVFZa3RaOWNxclQr?=
 =?utf-8?B?cE9UcW5DVEx5ZndsSjR1WDMzV1YzYTRtT1U1SFJaQk5McXhNd29sNlhpYWd3?=
 =?utf-8?B?bm5iSHlqd1VaQ09zMEoyL0w4V1dJMFVDQ0tlRUV4Vk43TjhyWkJBU3FxVmQz?=
 =?utf-8?B?VC9vbTZmV2RacjdIamF3TlA2L3Mrb29Nb2s2dG1IYVE3dnVNZzZYNXNuaHFn?=
 =?utf-8?B?V1UwRlJkYWtQY3dGVU5oRS96aDFXOXZkVXVQZkw3WDhWMVAzTDVpQ1VvNjU5?=
 =?utf-8?B?a09CRVArUlpnYmVOZVRJZFUvZXpHTTZSN253UkpMVEpSQWs4RXJ1N0dLNzc3?=
 =?utf-8?B?T2FUZU1RbUJyNUgvcDhjZE9lT1F5aWticVFsUm1jbDJhdjNxNmNLVkxWeVZ3?=
 =?utf-8?B?NUlVOGJMaDdRanlJcSsvTElZaDAxVmpUOXNHdz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:21:39.1574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 086d8dc0-516c-4c28-ab4e-08ddf6cf7246
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB10077

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
index d4dc01800945..6fef633ce6b2 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -105,6 +105,7 @@ u32                           received_ce             read_mostly         read_w
 u32[3]                        received_ecn_bytes      read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
 u32[3]                        delivered_ecn_bytes                         read_write
+u16                           pkts_acked_ewma                             read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
 u8:2                          accecn_minlen           write_mostly        read_write
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 3ca5ed02de6d..53a4a0da35cc 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -345,6 +345,7 @@ struct tcp_sock {
 	u32	rate_interval_us;  /* saved rate sample: time elapsed */
 	u32	rcv_rtt_last_tsecr;
 	u32	delivered_ecn_bytes[3];
+	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
 	u64	first_tx_mstamp;  /* start of window send phase */
 	u64	delivered_mstamp; /* time we reached "delivered" */
 	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d6d0d970e014..92c91e35d1b5 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3415,6 +3415,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5183,6 +5184,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9fdc6ce25eb1..0b25bf03ae6a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -488,6 +488,10 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+#define PKTS_ACKED_WEIGHT	6
+#define PKTS_ACKED_PREC		6
+#define ACK_COMP_THRESH		4
+
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
@@ -507,6 +511,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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
@@ -555,7 +572,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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


