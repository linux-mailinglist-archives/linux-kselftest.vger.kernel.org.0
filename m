Return-Path: <linux-kselftest+bounces-36380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E9BAF698E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 07:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45548188B7B1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 05:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106712949ED;
	Thu,  3 Jul 2025 05:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ZwuxRXA6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012012.outbound.protection.outlook.com [52.101.71.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C3C224FD;
	Thu,  3 Jul 2025 05:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519931; cv=fail; b=ql9LWxQA0rIXtdQz5V0B0jm+66RKFWTdYkI3NhtzldZRP8pwDsyav8ZRORygvCokglx7A5HaoMdKHxbp0r8fbP5xKFtAbX7H63nygVkA80T4Auy/hYkWn7t1XfrgUPji0xjO/YgPa2yHUls5WRcXRrlZ4TozM7/8wABJO1zYRVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519931; c=relaxed/simple;
	bh=Dxhz+4hIUE9CU9odTvOb3csSa6qB3eQT1ofObVBJEik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWLg7oTApsUZKlVxN0oWJ9cpL4RoPlLdSnek0s04HVXfTLg4RmSW+RRfBxVuuKV7dL+CWrdZthUg4W8/be0W55ae8ndNxtGLvqsFcr6rNaawgojlNOOMAvhbxSRxfp5LsVflBcM+N12j9DscEopRoa0xBwUj1R/RjeahhyywFsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ZwuxRXA6; arc=fail smtp.client-ip=52.101.71.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0hXQeY9jRuowgvNrhSN/QYwrh1qK/bohTCqrMdZkQ6GQHMErWdZnAQmfaR/uMCvK+66nuiCfGBICNYOcthjM8xgOj7SPg6aT/R3SClyaxLPM6A2Ad+P4vKBg9/cWoj0YHtEKwSNx6v1e2ng9IPZvUMrJ1CmxZ69o9tpa3OPk0FTzyE5LDDl2ivR0w7mY2cpNRZWw6mTKgPwkdwFJR99XS4kkRok/L+FiTIXg7Zq9b1W1pTnVV77Yi2gWSpfsdFgA8qVBIPjx2SRcP3tF/5R2Gv2rstHV7lWpgFZf1pMCLQam2OiUL4ZxPiOTExkH6hqcRZUFx+0VN0lmwUZYk4Kyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vev4SbXsKlSveZ5ZGBx2T9TjFUH8UIT+uor4XjzrD+s=;
 b=S5ZE7EYFKdmWirv3h7QeoID2WK9bolttcYl2pAvdDSnCx44Pj27eUvPjZwrUeVG90jSNkLheGyCMJEMGCJQsgGTM59NtFmd52dNKFv6QgItuTImeiKUQNz+zUK7NwZcfzw6yUnOWDZmknrAVwjDgi3jKFnAtGfhSCWkP34w5oDbKaXHu5lTkVC1tNI+stHhNTs6oJevdcQrtoqThDRyU5nW88HTAztkWoeZoMP67nvVS2cryhAkJNnTsx8U6AdC9LPGBwwiTLDtOZOzpp/9HY5uNunUie9ySCkxF1k2ScwZgXpB9SAGxcEL2EWuhv7gWSVb6t85iH98c6fD3RMElAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vev4SbXsKlSveZ5ZGBx2T9TjFUH8UIT+uor4XjzrD+s=;
 b=ZwuxRXA6s0vXHPI2DEg+2g5ncd1dEbwkq2nWAV7UAlFhO+uEiBzBTsS5NmP9AoTv7VtIADhOXsXe+4MVna+DY/rrQML5vwPBPdpuIKwqbNdGa1Pstffon5grp2jW4Hij00QlXFU+ZiHOj1SGCXmi/dzY5hNWrM2+0J56pUbp9HcHdpUmoYrYz/GWI9iDRRy/guO/1PtSJ+aFtwCFSS+IsxVW8HtXHY9DEksgzMebuiTru+tnNn4UWieb6R7hdEt9+pL0fIaSjlj3Uz5KNeAe0aXEg5Y4lppIFteegCftbCFt/u30Ucs0YlkaUNzLPqof9bcB7xAXt8IfbxwStxoWUw==
Received: from DB9PR05CA0024.eurprd05.prod.outlook.com (2603:10a6:10:1da::29)
 by VI1PR07MB6719.eurprd07.prod.outlook.com (2603:10a6:800:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 05:18:43 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:1da:cafe::11) by DB9PR05CA0024.outlook.office365.com
 (2603:10a6:10:1da::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Thu,
 3 Jul 2025 05:18:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Thu, 3 Jul 2025 05:18:43 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id CF974200B2;
	Thu,  3 Jul 2025 08:18:41 +0300 (EEST)
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
Subject: [PATCH v11 net-next 07/15] tcp: Add wait_third_ack flag for ECN negotiation in simultaneous connect
Date: Thu,  3 Jul 2025 07:17:20 +0200
Message-Id: <20250703051728.37431-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D06:EE_|VI1PR07MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: d83a5967-4a04-4864-f75f-08ddb9f11433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmhyMm1PTVlkRUhib1JoYmovRC9WRUpZVkhZVnEvT0hla2ZaU2VwbXVydzJT?=
 =?utf-8?B?R3F2QlJNdzNDNUlxRCtzbWM4NmFaWTVPUHhyazZhbXRkTzZzL1BDeGxYZnV0?=
 =?utf-8?B?QVFtdVdjNEh1a2IvK2R5U0x2ZHJzRHpKYjdHY25panZuQ0twYUFlKzNPZ0Uz?=
 =?utf-8?B?anN1RFRHaTNPeXBwalNEcGh2Nmd5UHhlekhvR0thWDZqd3pUK0ZBL0ZaUGl5?=
 =?utf-8?B?RDY3cGhxR2pIL0MvY092VzRMYjdZTXZJVEhLQncvUDVKQU5ub3JmWGVjVjF0?=
 =?utf-8?B?YWZWZDdVUThqVFo3bm5Ra3UwNnRNVmJmN0ZOQmxwaEJ0WmM5eGs2SW1WVVZT?=
 =?utf-8?B?N1BMdDViSjdCSkJSSVFPdG5MWG02UGx4dnNVcmtsd0NscnllRzdNeXltQW42?=
 =?utf-8?B?aUMycUEvOVIwWXBQVkFxaUMxRTI0VmhSRS9vS3BNSTZGUm9oVHdzMVFsN0cx?=
 =?utf-8?B?NDFwMWtSaVdrUGo1YkVhT2JPN1BWWE1ITVhDelVlUXRrQ1VKMHlxVEhvUHJ0?=
 =?utf-8?B?ODZCYVZWelBHUHRFUCtXWDUyY3pmY0hsanE5aEhEbnR5QXFGaWtQR1JWV3ZW?=
 =?utf-8?B?SVdTTWhRN2FPbHFYOXRROVUwSFIxMEduM2FxRDN2ZEdCYmpMeTI5QXhDeXZ3?=
 =?utf-8?B?RkRmZUpvdGJUejZFSW9vbVNTUi84STNFaTliOVNlZVpaQzEzUUdrSGhmZUhL?=
 =?utf-8?B?THluTW1waC9lQjF2S1dDSERhY1NNYlBCNzR2TTNIb21NR1VER3dhd0xrV2c4?=
 =?utf-8?B?ejZmdGRDN1F5NU9jWWRwNHVBWk4zODc5bFpCalB0UVd4RlpyazZZTytBWFA4?=
 =?utf-8?B?SDE2SGd4Nk5OTjNqcjFYU2RBeHVZZTZpSENWK2NoZzJISU1zNzNQOW9RM2Jy?=
 =?utf-8?B?YXQ4d2lCeEZINkIvVGlWVHIxNTVITGQxa3c4TWp6T0YrUU9tWjZwdUROYUpo?=
 =?utf-8?B?ODhlaG9Ic0hpQWowcEp3T1BWdE5HdUZjT1JnV00rRkgxdEJ0akhJa3lrNDNZ?=
 =?utf-8?B?NjFCVElIcVZ4R1BXRWtvdVgzY2gvS3lkRXlHWkhkT3JjTHVPY2ovZXJ0cUUz?=
 =?utf-8?B?alRmcDZmaHNzWFdFTGVMQlFLZzhwVnVvZXhrdGZ3V3U3Y0h1RzhPKzZ0ZGRq?=
 =?utf-8?B?dUNhVUlWUVpmcHlyOGlOcDNSankvbXY4UXNwdHlBZk1jekp3SVRlV2NNbkFl?=
 =?utf-8?B?bXdYd3dqKzV5NEdMT0hobHJLNzVUUXJSb3d2eW9sem1VK3NKOHpzVm1ZeWxi?=
 =?utf-8?B?blRlcElhZmZvVVhaaG4zVVprQ0ljeVAzYzJVcG9VTTNHR2JBQzVGbDR1c1Z4?=
 =?utf-8?B?RGZqVnU5TkxudXFIUHo5YTBYKysyT0tYdStqYm5haHFtUHk4NEUwY3JBakNr?=
 =?utf-8?B?ZFdWNngxR3A5cmRlNUZvY2ErUXBMdVczT0ZKMUxscC9Oa2k3Mi8yelRkK0FE?=
 =?utf-8?B?eFFMcXUraFlLT3BlUDlhVmRaWVM4MlRscTNKRU5KNWhpb1ZYcW5YMklheUc3?=
 =?utf-8?B?VkEycEZkZ0owRjlsNTZueTlPRml0VFBlakhWMFU1RnFVR2FiejJ4SFduYThp?=
 =?utf-8?B?b0JsdEk1Y00rQzU1YTRVN1hBZFo4dUxMbkFaRHhtVjROdjE4NkJKUnhxZ21p?=
 =?utf-8?B?YlRyVStrVTYyN1BrZ0FINnNEN3Y0ODEzUWtVaFNIZ2dzTVFEdkxJeXdGNitE?=
 =?utf-8?B?V0pGSzg2cHRnMkNVZWpDdGh1VCtrOUx3TEM1cXR1SXZmU2NIb0tvUXlGaUJj?=
 =?utf-8?B?RzR0MFBpcm5oclNCTTByNHIvVnVxUjZvTFhkaGNEcmErUkhGRzNmZTZjQXZM?=
 =?utf-8?B?dXhQNllzRFNVdjJQY3psNGhRQUxTaUI0Qktsa0RYRWtzZ21FQlNWNFQxZmxJ?=
 =?utf-8?B?S1pMUkVZQS91a0EzMmVnbXdSM21yN05lTEI3ZjZHTGt3SnhzdHdoOVNiWXYr?=
 =?utf-8?B?bDk0RVhQZWt6VlM5WkRZN0lBSElIalV2Q1ptNFBMZXJGQ2dFeWRaclVUVzZ1?=
 =?utf-8?B?czBmNTU5M3hyYVJ4UEhWWlZBSjg3dE9uMmRXQVU1bk5vNEI0TklsQkorMVYz?=
 =?utf-8?B?cTdiaVQyeTd3WTFSYUhEblRRcHNuUmJXbXQ0Zz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 05:18:43.2885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d83a5967-4a04-4864-f75f-08ddb9f11433
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6719

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

In simultaneous connect scenario, the connection will be established
when SYN/ACK is received after patch 23e89e8ee7be7. However, the
third ACK is still anticipated to complete the negotiation for either
RFC3168 ECN and Accurate ECN. In this sense, an additional flag
wait_third_ack is introduced to identify that the 3rd ACK is still
anticipated to ensure ECN or AccECN negotiation will be done in the
ESTABLISHED state.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  3 ++-
 net/ipv4/tcp.c                                |  1 +
 net/ipv4/tcp_input.c                          | 23 +++++++++++++++----
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 4f71ece7c655..22ac668fe6c7 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -105,6 +105,7 @@ u32                           received_ce             read_mostly         read_w
 u8:4                          received_ce_pending     read_mostly         read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
+u8:1                          wait_third_ack                              read_write
 u8:4                          accecn_fail_mode
 u32                           lost                                        read_mostly         tcp_ack
 u32                           app_limited             read_write          read_mostly         tcp_rate_check_app_limited,tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 994a6e7256e1..1d8301f2883c 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -380,7 +380,8 @@ struct tcp_sock {
 	u8	dup_ack_counter:2,
 		tlp_retrans:1,	/* TLP is a retransmission */
 		syn_ect_snt:2,	/* AccECN ECT memory, only */
-		syn_ect_rcv:2;	/* ... needed durign 3WHS + first seqno */
+		syn_ect_rcv:2,	/* ... needed durign 3WHS + first seqno */
+		wait_third_ack:1; /* Wait 3rd ACK in simultaneous open */
 	u8	thin_lto    : 1,/* Use linear timeouts for thin streams */
 		fastopen_connect:1, /* FASTOPEN_CONNECT sockopt */
 		fastopen_no_cookie:1, /* Allow send/recv SYN+data without a cookie */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 45c85c788def..0548c74458c6 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3391,6 +3391,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->window_clamp = 0;
 	tp->delivered = 0;
 	tp->delivered_ce = 0;
+	tp->wait_third_ack = 0;
 	tp->accecn_fail_mode = 0;
 	tcp_accecn_init_counters(tp);
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ea5d47354978..7ccfde9bcfda 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6001,8 +6001,13 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
 		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
 		    TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
-		    TCP_SKB_CB(skb)->ack_seq == tp->snd_nxt)
+		    TCP_SKB_CB(skb)->ack_seq == tp->snd_nxt) {
+			if (!tcp_ecn_disabled(tp)) {
+				tp->wait_third_ack = true;
+				tcp_send_ack_reflect_ect(sk, accecn_reflector);
+			}
 			goto pass;
+		}
 syn_challenge:
 		if (syn_inerr)
 			TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
@@ -6220,6 +6225,12 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 		return;
 
 step5:
+	if (unlikely(tp->wait_third_ack)) {
+		tp->wait_third_ack = 0;
+		if (tcp_ecn_mode_accecn(tp))
+			tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
+		tcp_fast_path_on(tp);
+	}
 	tcp_ecn_received_counters(sk, skb);
 
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
@@ -6833,12 +6844,16 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		tp->lsndtime = tcp_jiffies32;
 
 		tcp_initialize_rcv_mss(sk);
-		if (tcp_ecn_mode_accecn(tp))
-			tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
-		tcp_fast_path_on(tp);
+		if (likely(!tp->wait_third_ack)) {
+			if (tcp_ecn_mode_accecn(tp))
+				tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
+			tcp_fast_path_on(tp);
+		}
 		if (sk->sk_shutdown & SEND_SHUTDOWN)
 			tcp_shutdown(sk, SEND_SHUTDOWN);
 
+		if (sk->sk_socket && tp->wait_third_ack)
+			goto consume;
 		break;
 
 	case TCP_FIN_WAIT1: {
-- 
2.34.1


