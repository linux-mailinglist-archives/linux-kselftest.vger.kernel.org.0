Return-Path: <linux-kselftest+bounces-31316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4327BA9714A
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506173B75BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8FD290BD8;
	Tue, 22 Apr 2025 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="VKApYS/r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC76290BB7;
	Tue, 22 Apr 2025 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336319; cv=fail; b=UWwgKUjSg56R2svqTZ2D4k9l0Jybv9wEzEApa2y/YeiLNnu3xDaSjY1EwO9Fh2FLxXCHQ+JJBtd5YOSgZgZeXTZcSl5rZpk6Zr1ZDecl9o/xJH/2GBKlmmlkepPAEk9NCXHonCwccLxjMvnEVvS3i/ZVG05WVpevRGbGitFJkOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336319; c=relaxed/simple;
	bh=bnrDau03MTqEb+55uE4ECIXJc1PXmTb+6uznb2nRdxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bI/lBNEBJanIk4HI4RYyogfRGe7tCPeoPosILimsoldddv4z3ZvAjHsYJoPj+kxTaFLqL6M6qg4KKPaSyl5W9pazrTvDDIThWqkXwvSA0+jBW/Tx+SaI6roGw12WqeeSjLJK9byyz6cgtUA86Kolm6Q9Hg8ocFWUtDgpIzSq+IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=VKApYS/r; arc=fail smtp.client-ip=40.107.21.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEMVgxPp92w0EMLvRKJLyHNYEjon0fkUCUY+pOmSi6f8uourUoGA73xkDCt2MNXQEpOXDFqFNYWqtTtiA1+iwBdZY5rsN58lXjkvsMDdUxGN4lTn4xxkzoQ41VDddrzn8MyhnJxVyEeH/2kkQLCBo4ylFGtqLjtQI67nMAmfGiMPlHA2fxdK7C6pENllhYDHb8RQpxvPhO7cagoBpeqEP+9oGT453q3pjk37QLEhQMOEMS9xrNXwFvrTF2t8xCievu70ilYbuQtJw20ndaLHTyR7a9+NqThEGldBPXnE+h+iskkPS7CO9VG+7EPsTWPPf9WUUlO2wyhE4JN4Zuyzgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF6XTXiEfjIReTh6hy2n4CrqURGfKz4X+CBDtXd3M1A=;
 b=mTf/r8g8OtsYPgJv37LLwN36H12WS8o7670HhmUe7YAeLhp5zhPz8xyPvr4fn/4p2GWyJLBpgvtUVmaAl8fzqqxcXHt+/UiQRINrGgAuMJo4WDjCUplM9qcEcaTitCweA+hJC2W4+UqRk6WlHot+I4UvrFH8FcDPn6jCoRHhWxSeyRubybXVgqdwqPIIrXEnF5qs5fb5CG6RtVXtfOLY2OrvwDx/C5nL2RimpH8fnuaovXhef8FTli3wehuvAtYrn6FZ27X00og7yRRnBRlYpcXyBfhJ9KSxF1zs5Ro7/vpEmOZr4T8pPQGV5XgO123vObOmeSW5qOnu+z4oelhjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF6XTXiEfjIReTh6hy2n4CrqURGfKz4X+CBDtXd3M1A=;
 b=VKApYS/rX4tqRa2y6DjyQCS6Yp8Bou7GVFo1mJL7zC/wpxmrbPdyt9m5HWCjiTd1puQS3VDHaYXYXOVot/Q2yXYc88j0D+tS5pkzF6m3gNJs4HAwsMYfywrZQdaNtkFfgm6werqMsJY90bqPEzVWPNovniRaEL6ISwIiZp4EAQ9FuTrp8yc048/EHK8hQDZDgpeItow58vjS8YJbB+8zhNBzCsXMaFrH7L3EBmUmp/0k35OnV/3QTibIU1VdQRKX9Sve6+5u5vnCNurLtuQuF3chyMkLh+HZ7LldRJq7DwJO6Oeh5/VZZ20viYmTf496XeDjCQIq7s46LXZJYpwmGA==
Received: from AS4PR10CA0030.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::11)
 by AS8PR07MB9188.eurprd07.prod.outlook.com (2603:10a6:20b:5ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Tue, 22 Apr
 2025 15:38:33 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::d5) by AS4PR10CA0030.outlook.office365.com
 (2603:10a6:20b:5d8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 22 Apr 2025 15:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 22 Apr 2025 15:38:32 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 45BA120A29;
	Tue, 22 Apr 2025 18:38:31 +0300 (EEST)
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
Subject: [PATCH v5 net-next 07/15] tcp: allow embedding leftover into option padding
Date: Tue, 22 Apr 2025 17:35:54 +0200
Message-Id: <20250422153602.54787-8-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000040:EE_|AS8PR07MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c61c47-ee85-40c6-a661-08dd81b3bd0c
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RlFwWlg2SThYOTNYMXdZWmNmWjR4bENLaHJONXdKVzVPUFVDdkRBZm5Rem1h?=
 =?utf-8?B?R09sN1czU25qNE9MSGxTSXp2U2hQbXBBRFBjMDN0bTFTREt6b0YxUmptMWk4?=
 =?utf-8?B?ZGhPRUtvNCthVHlxVXUvdTFKRm8yWGJRUTVsemZGVS9QZm5mOFVNK1pLSVdZ?=
 =?utf-8?B?c0xOejIrK05oYTNVSitMaXpETWJISkkyTFZUY3BXV29lS1p2dSt3c3JFWFNr?=
 =?utf-8?B?RjV0NmNJT0YyYXpYOFFud0s0RjU1d3dFa3laOUVnYTliWWgvTWk4SEhWSTFV?=
 =?utf-8?B?Q0gzcm9Jc3VJSk5MRExJMGk4T083OFdKNjI3bzEvWG9ramZnVGNQRHNZNlNN?=
 =?utf-8?B?WWJPV0J3VnVhY2pJV2ZxYU9QSmE0T3RGS2piNnR0QzJDNDVOeERTcE5lU0lk?=
 =?utf-8?B?Q05CVXhmeGxwUS9nd1JsSEZVQmpycDYvWDQ4ZXprVnk3R2dpbjFtZ1ZwdU5L?=
 =?utf-8?B?UHVpTWVZdDdZWDUwVTBXMThkWjE0N3JMQWVNYUJuMzVCLzhic0l0VlloNGc2?=
 =?utf-8?B?N3RuWENVMmI3djdWTVVHK1luTzM3RjZQZTlKL2U3aC8zSzJqVjd4a05QWStN?=
 =?utf-8?B?Q3FCRVI1aGxta3VSa0thdEZZdkZ1TVJrS1EwQUIrWGgyS1RwTUcyWnZFTmEz?=
 =?utf-8?B?aUJhSXUweUFDaFUzMmZsa1NKL1lVT0plRVRzUEJzNGxGVG9OOURVNjVEVTBt?=
 =?utf-8?B?ZWNPUEFFeTJTbkZWcDE1dXBTb0hWMjlyUjlwZkRnTGhUZ0xrMjlZWTMrWWNG?=
 =?utf-8?B?WGZrdDM5b24wdG9sWm5vMWRLTjBhLytGU3NLOHBXVzNiN2VsK3FqditJbmFL?=
 =?utf-8?B?N3diZ3hDaFNRZGpXM25ibHM4UnR3QVhmQVNnWWpIZlpDbnI3SjdQQ09tazVB?=
 =?utf-8?B?NkxLanVaZTVWSDNmK2pUZXRHSnplVWxJREsyT1RYODI2TmJnMWlnRmxML3l1?=
 =?utf-8?B?RGlmOEkxc0x4VVg4eEhTSDRQQWZKQ0NtcUJhbklhZlBndXBoL0pUaXcvYURL?=
 =?utf-8?B?RFhwR1BvZUxNTGV1a0lkNDVRbjhuN2FuOVlRQ3BQMVVrUE1TMFNZcGlOQWJp?=
 =?utf-8?B?RGpHU0FNRzJLTzBRN1N4MktXb2l4aVN3di9FbStUbWtGRjNVZDV4U1JhQmpU?=
 =?utf-8?B?UWRaVElWdmFwWXIzdnpILzExWXJKOXVXOEZMTTZ3alZ2VHJJdDBtbVFNWk5h?=
 =?utf-8?B?QkhYS2lXcTFYNFdJWWlVMjNVRnBHODJLeEt2Rmw4cVo1ZGVyR3FHYWdIZE5I?=
 =?utf-8?B?ZlQ0ZFhvM1VMVmJjK2dqQ3QyT1VDMTZndUIwSjZOS3Y1Tk1WbHcxYWZ6NWZp?=
 =?utf-8?B?Z0FNYndhbzh0ZUFuWi9EM0ZEeGhUM0d3Z1AvaVhZN3U4eDVBNTgvZUlIdXRD?=
 =?utf-8?B?Mk8yQzR0M0dWL2gyNFFCT25OVW04VnpyK1dGYmkvc1ZKNm1FaGlTNEpSdUlD?=
 =?utf-8?B?bi9odExyV2V5UzJQWmRHb2t5Wlg0UG5kd2I4VVhHSzBSdzUxOS9tbDNVK2lH?=
 =?utf-8?B?b000bnhIVzh5OStlNThCSnZmVnZRZ0hQM3pjOGZvVGc1WXlqQUpYTGp5MjNR?=
 =?utf-8?B?NllZSktENGdtV3UrOGJtc3VDaWNCT0p1dnhhUW51TEx3OVJFZEFSU2dzQmgv?=
 =?utf-8?B?MVovV3BEZmtXdGNwcncxTENEaFh4NGhBR2p1TUtjaG9wMEtKTkY4TVFzS0po?=
 =?utf-8?B?VUtZUkhoeXdNMzJWR0pLZ2FpQjhoVGpZWCsvdEs5Unh3NEJXN0d0c1h6cEZZ?=
 =?utf-8?B?MkF6VUdQWm9iVUZJMmh5WWNFQWNnVkV5S2ROVitMVFB1UjRndGUxeEs2ZFhj?=
 =?utf-8?B?Y3pHVkU2WXRCR2wxdDZkTkVRYVBhcVBjVVpJTEhuRHZNa0FGT2JVWEhFb3pK?=
 =?utf-8?B?ZlNnQVRxQXhVZkhkWk5sR3U5VXlGMldlUWllZS9Bc1ltL3dUMEw1UlllRUJq?=
 =?utf-8?B?eHhpNzdKbXF5bWpFZ1F6dXFvMjlaVUZCOFdoUnE2ZzhyWTk2NFRwR0R3ZGc3?=
 =?utf-8?B?TFNUc1ZqTXV1a1pQT2FPajVuMGRJeEVac0VwSlFSaTAxdURrMnBpT0w3WXgv?=
 =?utf-8?B?Z3pFYXBmbUcrNTVjU0xoZm52QTU4Q0lrc0pZZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 15:38:32.6861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c61c47-ee85-40c6-a661-08dd81b3bd0c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9188

From: Ilpo Järvinen <ij@kernel.org>

There is some waste space in the option usage due to padding
of 32-bit fields. AccECN option can take advantage of those
few bytes as its tail is often consuming just a few odd bytes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b4eac0725682..d63f505a30e2 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -709,6 +709,8 @@ static __be32 *process_tcp_ao_options(struct tcp_sock *tp,
 	return ptr;
 }
 
+#define NOP_LEFTOVER	((TCPOPT_NOP << 8) | TCPOPT_NOP)
+
 /* Write previously computed TCP options to the packet.
  *
  * Beware: Something in the Internet is very sensitive to the ordering of
@@ -727,8 +729,10 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			      struct tcp_out_options *opts,
 			      struct tcp_key *key)
 {
+	u16 leftover_bytes = NOP_LEFTOVER;      /* replace next NOPs if avail */
 	__be32 *ptr = (__be32 *)(th + 1);
 	u16 options = opts->options;	/* mungable copy */
+	int leftover_size = 2;
 
 	if (tcp_key_is_md5(key)) {
 		*ptr++ = htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
@@ -763,17 +767,22 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 	}
 
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
-		*ptr++ = htonl((TCPOPT_NOP << 24) |
-			       (TCPOPT_NOP << 16) |
+		*ptr++ = htonl((leftover_bytes << 16) |
 			       (TCPOPT_SACK_PERM << 8) |
 			       TCPOLEN_SACK_PERM);
+		leftover_bytes = NOP_LEFTOVER;
 	}
 
 	if (unlikely(OPTION_WSCALE & options)) {
-		*ptr++ = htonl((TCPOPT_NOP << 24) |
+		u8 highbyte = TCPOPT_NOP;
+
+		if (unlikely(leftover_size == 1))
+			highbyte = leftover_bytes >> 8;
+		*ptr++ = htonl((highbyte << 24) |
 			       (TCPOPT_WINDOW << 16) |
 			       (TCPOLEN_WINDOW << 8) |
 			       opts->ws);
+		leftover_bytes = NOP_LEFTOVER;
 	}
 
 	if (unlikely(opts->num_sack_blocks)) {
@@ -781,8 +790,7 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			tp->duplicate_sack : tp->selective_acks;
 		int this_sack;
 
-		*ptr++ = htonl((TCPOPT_NOP  << 24) |
-			       (TCPOPT_NOP  << 16) |
+		*ptr++ = htonl((leftover_bytes << 16) |
 			       (TCPOPT_SACK <<  8) |
 			       (TCPOLEN_SACK_BASE + (opts->num_sack_blocks *
 						     TCPOLEN_SACK_PERBLOCK)));
@@ -794,6 +802,10 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 		}
 
 		tp->rx_opt.dsack = 0;
+	} else if (unlikely(leftover_bytes != NOP_LEFTOVER)) {
+		*ptr++ = htonl((leftover_bytes << 16) |
+			       (TCPOPT_NOP << 8) |
+			       TCPOPT_NOP);
 	}
 
 	if (unlikely(OPTION_FAST_OPEN_COOKIE & options)) {
-- 
2.34.1


