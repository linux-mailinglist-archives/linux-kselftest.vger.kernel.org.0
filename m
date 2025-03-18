Return-Path: <linux-kselftest+bounces-29296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4131A663B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF063ADC55
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 00:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1274B14B08E;
	Tue, 18 Mar 2025 00:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dZGsImFz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2089.outbound.protection.outlook.com [40.107.241.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA7C21364;
	Tue, 18 Mar 2025 00:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257684; cv=fail; b=VvVp5kwdB0jbuU6iJGPBOQUOJN6+O+DOjAVmoRVSSszex/hh38VAxnoPPTsgekKRjO664gK3JROJ6ZVLRa2ZvxUJ1hhI8GxpMEKBY22z1/37w2h4uSySi7sEGLqf/k8W+5jFNi3zLCTzoYX+S4VJCkGC6lfpdPDOlfPvf4FazDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257684; c=relaxed/simple;
	bh=WM3JGgZkKBWnizfsw/AJz2FKU3+wP7V8NYafTxs5mww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFSZbusxCzmRZEUaFPnvER2DnITBHlg4bonhds8MOxWJ3bdCGl/HGS72cT+NUIirusDLmE+4K5bg6Elv+SjAbhAuVHY+CV1W2mARAIbMD9MIkf7IXtzOPuDtnV0J0v8zOZlpqcEhqv8d1TGJRKEQ5sCtlAmpsubYS/znT6fWlLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dZGsImFz; arc=fail smtp.client-ip=40.107.241.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfYmpSphWpcxLSryHgt/+Juq4kEDJ4kdep2x1FdFSytty07gHW7rTdz5p4yZF0lpTPeqENz4pW+Ws0wjxQMTMKgYMcVKAk0I5LAmqnDJHiUq801MHRlmhLV06yOR3V0G5cqXkFtDTNRoLpZAPdHk8vhI9ebXS5eN79lgb2IYdiJ4UXWK/vDYekEYbe9Hj62SZQnf2odsM79URmD3PVRMWpBk41lTkkzGqpUIBqaRVDnbZqbuLLInJ5zOFd7AB74Syh8jm3aifNrfEaGOEcbTEnACC3004t+VVJocR54uVPMGpBuE1vadl4G11LvZoJ4BQJ+zj7BefQnCp6nyKT09bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4r7zoQge4NAdzXesTo6zfqb5PjGbZVAqT36vn6W3Ni4=;
 b=LRyHPG0z8ohNgM3M9DuZaWpYFLgv/aEnFWrGc0Z4V9BR2+8AeAT9JBfcFEANsTx9f2KtSeQo+19h6lbZbbgm4UGBD3GHFmvdUaPcyCtuBWLNCQPTDjWcrh+uArwuPLQOmhhmxbMZ/8iui/ggSExeyTsGPRz1fDlAHXpbZsHQr7+FAm7Mx21sdChEtX0dWcG6T0dzainkhadoXu5NNIe/SF5jmDYuFQFANB76dTZHulgFodOfZjM+rUZ6re4zLtY2tR2htyUDppM4Mkghaq6+Pki1qyF1Ks3V0MKRxZIEdKRfl3AN+WvgS7Zf6x6/sKghfM++MFHLxGovVpXoQtx7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4r7zoQge4NAdzXesTo6zfqb5PjGbZVAqT36vn6W3Ni4=;
 b=dZGsImFzMxF0N7eoqRCcQc41CyQGO6zN19A67WL/bMgaW1GH31OkDnt2wKBlOk2pwtbxoWKZSiuFFsFLqvTRxkvD+rJ1RU+PB6dmSBnP+ZXKY6A1SLFtFCfnM6hbnFW1P08bG8QzNGq622jJY6cWGt2HrKT5I8WVmsCS1+dhNbHJ4ncRnHoQBcC7qhEgAWvt0Gxf+YWgrdvY4V//julltTodg2fpXBx0if+MVLncNKFlXU/lIOmuRK1OcM056kCJLkxQMOFCcbxdoBw3DGyfAuDnEmSChb+y9DhmK+AtKUGVdwMIKOV6zzThHhADufyOXRQw8v9oJaTbHR7pQVa38w==
Received: from DB6PR0301CA0079.eurprd03.prod.outlook.com (2603:10a6:6:30::26)
 by GVXPR07MB10053.eurprd07.prod.outlook.com (2603:10a6:150:11f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Tue, 18 Mar
 2025 00:27:57 +0000
Received: from DB5PEPF00014B93.eurprd02.prod.outlook.com
 (2603:10a6:6:30:cafe::44) by DB6PR0301CA0079.outlook.office365.com
 (2603:10a6:6:30::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 00:27:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB5PEPF00014B93.mail.protection.outlook.com (10.167.8.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 00:27:57 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 52I0RNBp024935;
	Tue, 18 Mar 2025 00:28:04 GMT
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
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v2 net-next 09/15] tcp: accecn: AccECN option send control
Date: Tue, 18 Mar 2025 01:27:04 +0100
Message-Id: <20250318002710.29483-10-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B93:EE_|GVXPR07MB10053:EE_
X-MS-Office365-Filtering-Correlation-Id: a95dc151-16cf-47ed-03fa-08dd65b3bb42
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZEhTRk1UOWpES3hTeXI5ek9FYTJROGJNZTNzTURNYkdyOWduam1BMndScyt4?=
 =?utf-8?B?bVY2VVRzdnJaeDNyNkFDVEM3TEZSQ1UrYXBmTHBhdEp5OGtlK1l6MEdoZThj?=
 =?utf-8?B?eWFlNkhuaDRFL201V0o0NFJheXVNMGJ6Z0syRkt2TWlETndHd1B3VE9OSGJL?=
 =?utf-8?B?Q01LR05uSVduVXdYRTI5YWtEeWtHVGUzaGNXRjVmS1NmVnpGRXNUV3JCN2Rk?=
 =?utf-8?B?a25icHV2djdmVVZlWmIxWXVZdThlNVViQTVpdVdQY0Y1K3VlaGZSWTJMZVpP?=
 =?utf-8?B?MDVQS1NySmZXcEtLd25ZNzhVUkhVaG9US0dUc05FaW5iK1owTTRlNWxDTEE1?=
 =?utf-8?B?akxGVEdTTE5EQUJKY1luRURKeWtjY3NGS3h0ZnhLRlczQnpESG1DRTUzQk1m?=
 =?utf-8?B?enBUVnNiT2h6TDdOZ1BWWGhmalFUbW5WVDUzcGxXdjlXSnh4R2NCUnRCSzhM?=
 =?utf-8?B?S25ldURWOHNhMjFRQ1BoTk5vVkcwSWM1UGxIUE9TN2F6aWo3UFk3SlEwL1dO?=
 =?utf-8?B?RzZxd2RNajBnRWpXS21Ia29ucHE1OHR5R2dMVFZ1NXQyWUJXSXJRZ0VGSVNP?=
 =?utf-8?B?U3NRR09XUVJ4NGlpcFNDOWNZWmFydytxREJlSFRvdlFOR0I0MXRJTTBZclVR?=
 =?utf-8?B?eDdVSzdCaEh4bHQ3TFY3VTdVZmhGWURFeE9TbXVpRWN2YTB6SldnWmZ1RnJB?=
 =?utf-8?B?cnRzM0hOTGhPNmRJZU5vRXhRRDFSZUtyUmh0aTJMQjNlSkk4cExHd2lFR3Qz?=
 =?utf-8?B?VHVnOFJtSk5ZRjFYdWFBMUJ0a3liLzVoMEdzQXRlNk5FOWxGdDgvYVg4dW9j?=
 =?utf-8?B?bXFoc0tLSFQ1cXFRKzJiWGJqS21hdzc0akwzMmQ2Q0Y3cktkQmVMbi8xVkRk?=
 =?utf-8?B?REt1N0pZQ0cxbmYvYzR3YXZkVUZLa3lONWlsdGlCa0VKM1NxY1p0anRKcTRh?=
 =?utf-8?B?d0Vmd3RZdzdpOGJubEdxNDRmSWVRaTlRcTFlL1RZbjNMalZ4VXFjV2pHREJ2?=
 =?utf-8?B?R2FQT2E2M1ZhVFJaQnkxZWNOSTI0NURyM0V0MmgzZnNETlRlYWRkNGdIcGRh?=
 =?utf-8?B?Mk0zNFRsTjNkNVFqOVpQQy9xS3kvN2RnZGlvODRBQ1g2MlRDVnRiZERXWmRI?=
 =?utf-8?B?aHEzblkvdkF0NFlMTnRhNndEbzdvNmJaTXl6NzhwTWZYQmprRytlUGp6WnNE?=
 =?utf-8?B?VXpMVlJSa1RiV1pLRUI1RGR6REpoWXRyZVJ6b3l2NnBONkw4RklDYkFYUmZ3?=
 =?utf-8?B?UG5FY0FiYm1rcjdTU2k4cVpaUElnZjB4dkpiNDUyRVpzQkdQUGU4ZUNIaS9H?=
 =?utf-8?B?bVEybjlWb0puQ1hVdkxrWmJUTnFoUzgybkRhVTlQTEpHMnJ4cm9YQVBKSEpm?=
 =?utf-8?B?VEI0ZEdNOWl2Z3QyUnErdkY4ZlNDbVhlSGIrL2p6WEMwNCtDOWcxRWZ4SFZX?=
 =?utf-8?B?dmZocG8vanE1S0h3ZC9DU2FycG96WGZkTFlXcnYyYUdxSDV2ZVJKM2pac01O?=
 =?utf-8?B?WDIwT0pVcW9hMk01a2Z4dktNeUJmSVVHMXFoZ3d6NDFaZnd3NDZtVXJwQmpO?=
 =?utf-8?B?RTVUckdDcXJzOURncHRQY3JuQWtCV3JIMmVDMHRsOGV6VnBTdEhKNWx3M0dh?=
 =?utf-8?B?Tll3VFZ6UEpLeURMQkpCem9nV3VCZS9iQXR3NUQ5ZlRwemhlU3dhNWVvUmlS?=
 =?utf-8?B?RTVWY283RmhGbTI2VlNuWWlVWXcyZzNxN2FOUW8wb25GNWV1S1BlZUxKYzJD?=
 =?utf-8?B?dVpCdW9VVTA4K0pza2UyN2xMeGlCY3hLUkNQK3RUUmZBYTNWT3p5TWNGS29H?=
 =?utf-8?B?a0NhVTcveG1tNzNUUTYybzc4ZnJQZUlMNzA4TUsxRlpUTGhodHZ1NEc1K01i?=
 =?utf-8?B?dDNEdGtrcWhoeXRGLythU28vY2ZIb3RrMzVxeW41b3ZOWEg1RUFSci9GUlpL?=
 =?utf-8?B?V3FQdEprUFgzbVcvcGFjTXlQaFAxVmNnOVdOcklEQzJERnRHdzk1ai9MSEV2?=
 =?utf-8?Q?bxS/+zsb9lA8cvQKZ/JuiMiMIsg+kA=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 00:27:57.0758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a95dc151-16cf-47ed-03fa-08dd65b3bb42
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B93.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB10053

From: Ilpo Järvinen <ij@kernel.org>

Instead of sending the option in every ACK, limit sending to
those ACKs where the option is necessary:
- Handshake
- "Change-triggered ACK" + the ACK following it. The
  2nd ACK is necessary to unambiguously indicate which
  of the ECN byte counters in increasing. The first
  ACK has two counters increasing due to the ecnfield
  edge.
- ACKs with CE to allow CEP delta validations to take
  advantage of the option.
- Force option to be sent every at least once per 2^22
  bytes. The check is done using the bit edges of the
  byte counters (avoids need for extra variables).
- AccECN option beacon to send a few times per RTT even if
  nothing in the ECN state requires that. The default is 3
  times per RTT, and its period can be set via
  sysctl_tcp_ecn_option_beacon.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h        |  3 +++
 include/net/netns/ipv4.h   |  1 +
 include/net/tcp.h          |  1 +
 net/ipv4/sysctl_net_ipv4.c |  9 ++++++++
 net/ipv4/tcp.c             |  5 ++++-
 net/ipv4/tcp_input.c       | 36 +++++++++++++++++++++++++++++++-
 net/ipv4/tcp_ipv4.c        |  1 +
 net/ipv4/tcp_minisocks.c   |  2 ++
 net/ipv4/tcp_output.c      | 42 ++++++++++++++++++++++++++++++--------
 9 files changed, 90 insertions(+), 10 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index b282c076b6b5..8d0f5a73b0a3 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -306,7 +306,10 @@ struct tcp_sock {
 	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
 		unused2:4;
 	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
+		prev_ecnfield:2,/* ECN bits from the previous segment */
+		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
 		est_ecnfield:2;/* ECN field for AccECN delivered estimates */
+	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u32	rcv_wnd;	/* Current receiver window		*/
 /*
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 8f9feebbf9e1..f0ef79fa6485 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -139,6 +139,7 @@ struct netns_ipv4 {
 
 	u8 sysctl_tcp_ecn;
 	u8 sysctl_tcp_ecn_option;
+	u8 sysctl_tcp_ecn_option_beacon;
 	u8 sysctl_tcp_ecn_fallback;
 
 	u8 sysctl_ip_default_ttl;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 1fdd127b18ab..48fb4e5579d1 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1067,6 +1067,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
 	tp->accecn_minlen = 0;
+	tp->accecn_opt_demand = 0;
 	tp->est_ecnfield = 0;
 }
 
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 1d7fd86ca7b9..3ceefd2a77d7 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -740,6 +740,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
+	{
+		.procname	= "tcp_ecn_option_beacon",
+		.data		= &init_net.ipv4.sysctl_tcp_ecn_option_beacon,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_FOUR,
+	},
 	{
 		.procname	= "tcp_ecn_fallback",
 		.data		= &init_net.ipv4.sysctl_tcp_ecn_fallback,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d867957334e1..701013b0aa87 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3366,6 +3366,8 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->wait_third_ack = 0;
 	tp->accecn_fail_mode = 0;
 	tcp_accecn_init_counters(tp);
+	tp->prev_ecnfield = 0;
+	tp->accecn_opt_tstamp = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5077,6 +5079,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, accecn_opt_tstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5084,7 +5087,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 122 + 6);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 130 + 6);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e4db5ccff75c..8cdeb7765d91 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -467,6 +467,7 @@ static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
 	default:
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
+		tp->accecn_opt_demand = 2;
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
@@ -487,6 +488,7 @@ static void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 		} else {
 			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
 					  INET_ECN_MASK;
+			tp->prev_ecnfield = tp->syn_ect_rcv;
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
@@ -6279,6 +6281,7 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool ecn_edge;
 
 	if (!INET_ECN_is_not_ect(ecnfield)) {
 		u32 pcount = is_ce * max_t(u16, 1, skb_shinfo(skb)->gso_segs);
@@ -6292,9 +6295,36 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 
 		if (payload_len > 0) {
 			u8 minlen = tcp_ecnfield_to_accecn_optfield(ecnfield);
+			u32 oldbytes = tp->received_ecn_bytes[ecnfield - 1];
+
 			tp->received_ecn_bytes[ecnfield - 1] += payload_len;
 			tp->accecn_minlen = max_t(u8, tp->accecn_minlen,
 						  minlen);
+
+			/* Demand AccECN option at least every 2^22 bytes to
+			 * avoid overflowing the ECN byte counters.
+			 */
+			if ((tp->received_ecn_bytes[ecnfield - 1] ^ oldbytes) &
+			    ~((1 << 22) - 1)) {
+				u8 opt_demand = max_t(u8, 1,
+						      tp->accecn_opt_demand);
+
+				tp->accecn_opt_demand = opt_demand;
+			}
+		}
+	}
+
+	ecn_edge = tp->prev_ecnfield != ecnfield;
+	if (ecn_edge || is_ce) {
+		tp->prev_ecnfield = ecnfield;
+		/* Demand Accurate ECN change-triggered ACKs. Two ACK are
+		 * demanded to indicate unambiguously the ecnfield value
+		 * in the latter ACK.
+		 */
+		if (tcp_ecn_mode_accecn(tp)) {
+			if (ecn_edge)
+				inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
+			tp->accecn_opt_demand = 2;
 		}
 	}
 }
@@ -6427,8 +6457,12 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	 * RFC 5961 4.2 : Send a challenge ack
 	 */
 	if (th->syn) {
-		if (tcp_ecn_mode_accecn(tp))
+		if (tcp_ecn_mode_accecn(tp)) {
+			u8 opt_demand = max_t(u8, 1, tp->accecn_opt_demand);
+
 			send_accecn_reflector = true;
+			tp->accecn_opt_demand = opt_demand;
+		}
 		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
 		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
 		    TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 605a0e54a1ff..47f47ffa4f28 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3452,6 +3452,7 @@ static int __net_init tcp_sk_init(struct net *net)
 {
 	net->ipv4.sysctl_tcp_ecn = 2;
 	net->ipv4.sysctl_tcp_ecn_option = 2;
+	net->ipv4.sysctl_tcp_ecn_option_beacon = 3;
 	net->ipv4.sysctl_tcp_ecn_fallback = 1;
 
 	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 550c2d9d08b7..82065b49e7dd 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -498,6 +498,8 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->prev_ecnfield = treq->syn_ect_rcv;
+		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 7b102e7c76fd..61bb5f5ee357 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -806,8 +806,12 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			*ptr++ = htonl(((e0b & 0xffffff) << 8) |
 				       TCPOPT_NOP);
 		}
-		if (tp)
+		if (tp) {
 			tp->accecn_minlen = 0;
+			tp->accecn_opt_tstamp = tp->tcp_mstamp;
+			if (tp->accecn_opt_demand)
+				tp->accecn_opt_demand--;
+		}
 	}
 
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
@@ -984,6 +988,18 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 	return size;
 }
 
+static bool tcp_accecn_option_beacon_check(const struct sock *sk)
+{
+	const struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!sock_net(sk)->ipv4.sysctl_tcp_ecn_option_beacon)
+		return false;
+
+	return tcp_stamp_us_delta(tp->tcp_mstamp, tp->accecn_opt_tstamp) *
+	       sock_net(sk)->ipv4.sysctl_tcp_ecn_option_beacon >=
+	       (tp->srtt_us >> 3);
+}
+
 /* Compute TCP options for SYN packets. This is not the final
  * network wire format yet.
  */
@@ -1237,13 +1253,18 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 
 	if (tcp_ecn_mode_accecn(tp) &&
 	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
-		int saving = opts->num_sack_blocks > 0 ? 2 : 0;
-		int remaining = MAX_TCP_OPTION_SPACE - size;
-
-		opts->ecn_bytes = tp->received_ecn_bytes;
-		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
-					       remaining,
-					       saving);
+		if (sock_net(sk)->ipv4.sysctl_tcp_ecn_option >= 2 ||
+		    tp->accecn_opt_demand ||
+		    tcp_accecn_option_beacon_check(sk)) {
+			int saving = opts->num_sack_blocks > 0 ? 2 : 0;
+			int remaining = MAX_TCP_OPTION_SPACE - size;
+
+			opts->ecn_bytes = tp->received_ecn_bytes;
+			size += tcp_options_fit_accecn(opts,
+						       tp->accecn_minlen,
+						       remaining,
+						       saving);
+		}
 	}
 
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
@@ -2959,6 +2980,11 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 	sent_pkts = 0;
 
 	tcp_mstamp_refresh(tp);
+
+	/* AccECN option beacon depends on mstamp, it may change mss */
+	if (tcp_ecn_mode_accecn(tp) && tcp_accecn_option_beacon_check(sk))
+		mss_now = tcp_current_mss(sk);
+
 	if (!push_one) {
 		/* Do MTU probing. */
 		result = tcp_mtu_probe(sk);
-- 
2.34.1


