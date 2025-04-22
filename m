Return-Path: <linux-kselftest+bounces-31318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BEEA9714E
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80C5441D1A
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5B02918ED;
	Tue, 22 Apr 2025 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="JBn59DKz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15F428F922;
	Tue, 22 Apr 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336327; cv=fail; b=T0NnKrhZOyAzBkE5orZNDYqD7J+voYcWGA6peJRQESg+rUHY+roFbVuwxy4Vn74lIBbNNZx+jCQkH1jhLf10hdwClLf5BisIIy7lVflELRLam+DgIAaeXj86qJMafwmdj5ywqFoUjz2od1/U4wqxz4ui8N5t5P049NEnmQMW2k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336327; c=relaxed/simple;
	bh=NP4qkQJP0KEe3lZ/Qog38Tt8Zxj1v7BDVe0I4IvxWrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tWEh7a2yLcNjqd/cx7VWabZuyNI1vPGts3OpSdpGr/2ydpNCb/8Gz+WVpcpi0cVfq8hUysVKynGi9cFA+p3mJYskmgm1rkzCyVna5H46+gxXmPKxWVhmmRlEB8OpdXuxcG1wj65z2R3XRGjUVDmqkBt56BGzAwhNR+UtCcM4DJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=JBn59DKz; arc=fail smtp.client-ip=52.101.70.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V08+Ck8MtY/M7XRSIfjAY5aIXOeH9N1i11ngVUFYSSQrjRPl7QdDruTfV9xHCEotcIkShjt/NTrqMbvVsgJhhv1OfKJanwRiHuH2qTvhXicMh3uVeyC9S9GnfNl2z3qsSzjX8usryaU85zrIJuz+5dLH5OUNdD8LKZgEvKIZst9eEbP3GRCgpSxW5cUWqD9QODKVsK0Wa+Tdspr5F+7H2U0MCosKGRAFBjNMOnU95Zz9IGH12guB+dZq6RWe9Y0IcTPCqW8KcTV7ebnHvC+XcncrCxQHM146B6OVPVC7p7+3xjY831PGlgJq2YrGSADH7cFD8TUItzkfnu1qyHQx8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcTGWMcyxrtqx3ZEfcsgx2KweEhCJK4L721NwRY+QR0=;
 b=pFlwKwIJSOiCkLPSyL4ieK/57IwBIbl6tOXfWa8uWVjKu+OUzA80xMamFOmdHRnkkvtl45X+wVNFyxPcI9HFlaej7BClCqXlT0tv4HvMCO+SIjbpP/2oK2wFhTJsJhJIIuG9Piq4AGE0ala9i/YaH+GQkNh77xPyZCB9OxvkbkJaBJHSpG2z0Vhtxxs6+6Tjp9Ye8/fAj8difSnRYgkr5RdVuuveE5FhFRg4MlkDmzy3tBDjEJQ9RFHEwdU6wQ+r5KoP+jBYynSTWM2fmXUTzOqtAt4qwxjlCsn0ydyGHAHvgn8c5sPCgxTC+q6Q7KslM6HanhM4StEZLyL6bezWHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcTGWMcyxrtqx3ZEfcsgx2KweEhCJK4L721NwRY+QR0=;
 b=JBn59DKz4DQgrKNXm1LtTQsBmCqhdNLaSn0fU+23xs5RGC7f5NDTI8862VL+nAJmaRUCfClgI+uWi0zlZQFgtmpi3bmgJNsbeY+opL+6Aqvk2tsCSQnG8w0PLxyb7ORVeyHQsdn/S8vP+Zmt/X2y2H6V+AiPs1qPTDFJVpMyfT2sJe6qUXeYrU8zQ+TEVITF0hVFknNfwLGk/3IXBWj+P6Sz22uMgDKG0yFBrRA6n//T29TQvnuGQBFcPHEQuObmvDPSeUTrxi8Y1TIx+JyYyC2ZsVsbuNkSVtu+KfnndH/FQV808hdA7rDBiySN6JX2+h2qiNJCrMlC2BxLWnyBCQ==
Received: from AM9P192CA0007.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::12)
 by VI1PR0701MB6815.eurprd07.prod.outlook.com (2603:10a6:800:199::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 15:38:38 +0000
Received: from AM1PEPF000252E1.eurprd07.prod.outlook.com
 (2603:10a6:20b:21d:cafe::f) by AM9P192CA0007.outlook.office365.com
 (2603:10a6:20b:21d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 22 Apr 2025 15:38:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AM1PEPF000252E1.mail.protection.outlook.com (10.167.16.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 22 Apr 2025 15:38:38 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id CFDEC20A1C;
	Tue, 22 Apr 2025 18:38:36 +0300 (EEST)
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
Subject: [PATCH v5 net-next 10/15] tcp: accecn: AccECN option send control
Date: Tue, 22 Apr 2025 17:35:57 +0200
Message-Id: <20250422153602.54787-11-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E1:EE_|VI1PR0701MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e40318-c00b-4dc4-693a-08dd81b3c064
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?L3Yzc2dXWGxEVmFsUXl3Skw0bmozWGtIZWtpaHpCR0gzVEJTUm14c1p4MGJO?=
 =?utf-8?B?QVVwZjZ6c1U5NFlHdEFaQkhWVFNwa0pYMG52OTVIOVhDQk84SUZnL1p3QjZB?=
 =?utf-8?B?azJxVS9qWEdiOUVPb1lJTWxjSnpMK1NnZzVQbWxQTXY5TnF2eVU4QjJsS2Nl?=
 =?utf-8?B?bUc3OFlNSk8wekhZeUcxS0pRSVg2QXdqTk5hSEJGV0FMV1dpbEk0QlJlWWFl?=
 =?utf-8?B?MFFvRFJjMUpzK2xvaDY3SlJRZVpaZ3dCcW80RmdmUUVENGx0RGxteWZPNnBW?=
 =?utf-8?B?TnBvRXpKZHZ0anZzYXBiZEFaemNVOEMxOXdLT1Q4UHJDaWYyU1JKbU8wUHFV?=
 =?utf-8?B?NFZ5QnNkdlR4MzJ6RUF0MDgyRTV3dllXbW9CbTlhU2g0Zm1LeVBVM1lqQm9i?=
 =?utf-8?B?Zm5UanRsMFF3ajVPOFZpcVgrQi96b3dJdFphN0E5SGF2dHVMT1pWQno0d1Np?=
 =?utf-8?B?ZlMvNlYwYzg4RDdCeXk4eXplWkoxV3F3RXY1S1d1eVFXcHRmMmR6eVppOTIz?=
 =?utf-8?B?UytRY3k0SlZTODZ2Y3oyOTc3dkwyWHk2aU1XYnRvcEpkSWpaM2pOMWxQSHRx?=
 =?utf-8?B?cFNzUkZHamdRWU5pZ1JlS0RybUNKN01ibnF5akthck04MERHTEtnTjBXUUZj?=
 =?utf-8?B?K25ESDBhSndrNk5leUlUalhJMVMrZXRGaW1VcFhwdXFyYUdJSlJ3WlVObU5I?=
 =?utf-8?B?Rm51L3cweEZCRkVETG5KOHQ2YVZIbGFuOWJheWt6UW5pOGhNcHpBcXo5VHZq?=
 =?utf-8?B?TlhWK0NYcjd5cjBvY1dRTXIxb251ejJqd0JRbEVPNm55ckJMV3U4a0VUdlM5?=
 =?utf-8?B?TkVrMEU0c1ppWUkwYzBXQXVtamZwc2owcU5ESzRLZHZYY0RqYnQyVzIxdTcv?=
 =?utf-8?B?S1hseTdUaEJnUjBtT2V5VFdiMDBSYVJ4QUpWeXFYVXZnL2k5dTNkRjVUSzlz?=
 =?utf-8?B?QmxQcTdmeUd1U1U0ZnZ3YkdJb3JQNkh5ZUw2eDhMMFZ6VHJ2UWlRZGxRSHNq?=
 =?utf-8?B?MS94Q0hlVHpzUVhieE9JRlZNNk94M0NFZWxFMy9SVE03U0xCd3VUSlNtUmFo?=
 =?utf-8?B?SGlGUFJvNWlYTS9NQ0xLaTFuMzQ0b1A5MnpwNkg5dW5Zc0VsRGwrVG8xb1pK?=
 =?utf-8?B?b09oSnZYOEdsY3dUdnI3cjVLMnRXbmxrTk9uTGwrMUgzdDN3akZlRFJCaWFV?=
 =?utf-8?B?S0RvN0JyVS9wa1NINVZVdkxUQ1JhTXpXbk54eEZvN0laQVhLb3RIS0Ntdm9n?=
 =?utf-8?B?ajFiaEFwSG5vZCtrdnk2b2tNUFhsTm9tbWorRmZ1ZGdSRmFhb09IaTR1SXZn?=
 =?utf-8?B?REZ1cDMwRlBnbFN6ZnRFbDM5b1dJMnpmaFF2NDJnUncvMnhvNlAxMnJFajVN?=
 =?utf-8?B?dmFYVmJ3dmNHQXdHSGgxOUszTDQyc2dEQjd2bFRYMjl0Q0d4Z0p0WEpkOTJr?=
 =?utf-8?B?VlR3c1QzQlYzekN2SnNkWjVOb1YwS0JXd0lMOVFCM09HUE1NWGFWcWtEU1BX?=
 =?utf-8?B?Smg0eGtya1ZvZWNWQmFxVFFiMUtOU2hiZWtzWXNweTVEM3NvSXIrQjh6Smxr?=
 =?utf-8?B?bFN5Y0pWQmxnOVBEYUFUL3pRSWp6YXBHUFF0NGs1V1pwQTNOREN3NVpBT0tz?=
 =?utf-8?B?Yi9NUkdpNjY1aXgyRmk5dkJEZ01Vdzg0WlAxT0JGV0VQZ28rekZmWFBrdlFm?=
 =?utf-8?B?NHBaUVM0UFU5WEcrQUxCOG80TVlLc0U0dmdhSkNSS2ZCTmREdFE1RnJvZkk4?=
 =?utf-8?B?d1BNb0t5TUovMWpwRXFkWmdoeHBDQ3IxUFZQM2hDRjBJT21TVkY3UkZCMmJn?=
 =?utf-8?B?a1R1UHhUUzZhQVhCdEJCeGtxdnZsM2dxYU9pWDFhUHNMN0ZRN05NdXRncEg0?=
 =?utf-8?B?ZXZIK2h3WDk0ZlVxTWNHYTdROHIxSXZZZFUzaDAwVVpkQ2hvQUZpTURnbEcw?=
 =?utf-8?B?UFJleHczMXpCVmFieHlUdTg0Unl6TEpCMzZzV0h5RU43ZXg5N2NxOXJjNFdY?=
 =?utf-8?B?VitaRDlxVFBWVWVxZE04ZE1ZYzkvSEFObGlGaG5vaHcwVEVaNUpicUZaSjRG?=
 =?utf-8?B?Z1dValdRMHV5blZpOEErU1pnOEFqL1NraktzZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 15:38:38.2632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e40318-c00b-4dc4-693a-08dd81b3c064
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252E1.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6815

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
index 0e032d9631ac..acb0727855f8 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -309,8 +309,11 @@ struct tcp_sock {
 	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
 		unused2:4;
 	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
+		prev_ecnfield:2,/* ECN bits from the previous segment */
+		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
 		est_ecnfield:2;/* ECN field for AccECN delivered estimates */
 	u32	app_limited;	/* limited until "delivered" reaches this val */
+	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */
 	u32	rcv_wnd;	/* Current receiver window		*/
 /*
  *      Options received (usually on last packet, some only on SYN packets).
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 4569a9ef4fb8..ff8b5b56ad00 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -149,6 +149,7 @@ struct netns_ipv4 {
 
 	u8 sysctl_tcp_ecn;
 	u8 sysctl_tcp_ecn_option;
+	u8 sysctl_tcp_ecn_option_beacon;
 	u8 sysctl_tcp_ecn_fallback;
 
 	u8 sysctl_ip_default_ttl;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index bfff2a9f95bf..3ee5b52441e3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1068,6 +1068,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
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
index 89799f73c451..a712643a934e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3368,6 +3368,8 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->wait_third_ack = 0;
 	tp->accecn_fail_mode = 0;
 	tcp_accecn_init_counters(tp);
+	tp->prev_ecnfield = 0;
+	tp->accecn_opt_tstamp = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5107,13 +5109,14 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, accecn_opt_tstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
 
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 122 + 6);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 130 + 6);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 41e45b9aff3f..1e8e49881ca4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -466,6 +466,7 @@ static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
 	default:
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
+		tp->accecn_opt_demand = 2;
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
@@ -486,6 +487,7 @@ static void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 		} else {
 			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
 					  INET_ECN_MASK;
+			tp->prev_ecnfield = tp->syn_ect_rcv;
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
@@ -6278,6 +6280,7 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool ecn_edge;
 
 	if (!INET_ECN_is_not_ect(ecnfield)) {
 		u32 pcount = is_ce * max_t(u16, 1, skb_shinfo(skb)->gso_segs);
@@ -6291,9 +6294,36 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 
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
@@ -6426,8 +6456,12 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
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
index 3f3e285fc973..2e95dad66fe3 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3451,6 +3451,7 @@ static int __net_init tcp_sk_init(struct net *net)
 {
 	net->ipv4.sysctl_tcp_ecn = 2;
 	net->ipv4.sysctl_tcp_ecn_option = 2;
+	net->ipv4.sysctl_tcp_ecn_option_beacon = 3;
 	net->ipv4.sysctl_tcp_ecn_fallback = 1;
 
 	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 3f8225bae49f..e0f2bd2cee9e 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -501,6 +501,8 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->prev_ecnfield = treq->syn_ect_rcv;
+		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a36de6c539da..a76061dc4e5f 100644
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


