Return-Path: <linux-kselftest+bounces-44256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F05BC18E8C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84450464C6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDFF31D740;
	Wed, 29 Oct 2025 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="XE1MmwAc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5836831B806;
	Wed, 29 Oct 2025 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725181; cv=fail; b=lrVMl1GMPkWUnEHz4q/MAwOQOlcOcK4tWfI7LNUqSVW095nbPhhOSZZKKNf+29sWGeDTqzfowl4R/elbIaaybvkLynQ2mtgmdoAZpekkksfcn39ooMDSIAVbPyG2hfv6KOFizZqwUtNQedIem+qkVtR/JYhN+X6P0thCt+h+pDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725181; c=relaxed/simple;
	bh=dQEGJx1YNjzC3HboCIvJG36beTOioQfq2xP4TV1Cf74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eMC59oNtEzV+9BdJjNnKdDAbQ9nEb3geDfHHP6465+LUmZjuoICdCq7Lo61QZxvgtqGs4G43ZHqMWnss4M5zdYELF1O+Mp2YW8xkwW7UGhxpZdaJ2YaKj9U9+Ho9QK2QXTyKCGC3pxwxdg4w2CJa42kQlQn3GuufwPjkJpcbv+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=XE1MmwAc; arc=fail smtp.client-ip=52.101.72.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XogGHAjnJ0WnyK1dvovVD6yUVBSBWBD/DzFSwDfgr5s0nQX+QzjH6T+3SsPmXQH6MnfNO2enqTDhUWFg0oou8eYhhX6YffFcKL96MAELnfZA0r8bHfNgpmHqhkls6Gzp6CQq14R1OsdMee878c6MjfoI/9P6DcAdQ+O3a+BlD0O5duzYvAWyNtRZHF9LmOJzSNbyA+85ASfTt0dMi1T8mhHFexhiWTxe3iKl8GJdWR7f10Up0whdQ+KQmmLmkB4/eUIEBUSbBeZJ152ffAKv4u5XkA0Q7I3pD6nxO6ul7Lre9qo91Q7C++ZMePGgJx5Km6ukervH4SGMLy/xhmfzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tp2be4a5WkOLwFsSD3QmajURfl8JuW25p006R9FsJuw=;
 b=Vskl/xnHQZzoTaYwllYNNJ1HmjFerLI1WOQ8XbTMk89ZmkFRJCGUnofdek0lnAtdslfpoGjAlwEXo8GX3fCNru4bqiApB7kg2NZ+rP9pCA4aXHGllFCs6hhztM5Sg4kg6Oj6x+2+zHqt6y+R8CD3frabfeiJmqFUJrSUbAA4oU35WVMUH3P6yW8LfJsypTJ8/evsk+3P28SwNtsIXslI/1sJUZ03awlCfFmQ5zWvWlNGRzOwRTsvqCcIZspgFvfGFL2Oc2lHnvvBUdlSUaNPy3sQRKLDJDLkKiVfPQMOljkgbXfuVOxdinn9M14R6aWPv6tlf/m4GVZZ0KBBUdmEZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tp2be4a5WkOLwFsSD3QmajURfl8JuW25p006R9FsJuw=;
 b=XE1MmwAcJsbnjPzwkhAAwPoDUWzFbA37iM86lFDQP+usECAq20SMqQ1PF0EtpyyXdIviyeZGrKf/4gvOVNQ9CirCqRPG4IBrzjqNqNqdFmM0qp90apSHPYC8jleqrRariOgN5SwsrEBO3F5gORzDeOOR+aOrMIeLwtrJY7crVQqrtUguJnuxNPANNHyZDSB7TfgL9aBA2wzm3LM38GBklbm+vgEBa0U9fbpnaH70TBcsku9sVjbjFOn7OSsZSYs7JZMbPTC+MpEfxB5yL9C/IKt9LuIB96sxGt3dZVtbCxlfcbbPlgj2ORbkIiKPLxnz0I/B/eo+s4I6NAYXQnc2JA==
Received: from CWLP265CA0459.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d4::23)
 by PA4PR07MB7664.eurprd07.prod.outlook.com (2603:10a6:102:ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 08:06:12 +0000
Received: from AM3PEPF0000A796.eurprd04.prod.outlook.com
 (2603:10a6:400:1d4:cafe::70) by CWLP265CA0459.outlook.office365.com
 (2603:10a6:400:1d4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 08:06:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM3PEPF0000A796.mail.protection.outlook.com (10.167.16.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Wed, 29 Oct 2025 08:06:11 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 6869020202;
	Wed, 29 Oct 2025 10:06:10 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
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
Subject: [PATCH v5 net-next 00/14] AccECN protocol case handling series
Date: Wed, 29 Oct 2025 09:05:54 +0100
Message-Id: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A796:EE_|PA4PR07MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 245ee222-d835-4c66-8bbb-08de16c2066f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QWgydXFtNi9Uc3drcndKaEZBY2NJZmVnQjR4VHN2V0pkQmxrVTNrZmFnN1JH?=
 =?utf-8?B?TTBqQkQ4ODJBTUN0Vi8yYzU4NlNTWFNHd29OMXdkQzdxL2RDd3R5eTlScDZt?=
 =?utf-8?B?aENTaklwb2NtWmQxekVFOXZ5VStpKzRwa1JmdE9NOXJEUTBWbjF0c0l6MUs0?=
 =?utf-8?B?OHg3YnhULzVscXhVbHhkMyt4OXNTN0F3dlRMZ24zTDVTN3NaZVBoY1BuTFF6?=
 =?utf-8?B?dlpyTHdUdlhYZDgwOFhoZVVyS3paWjBzdThHM3YxaXZ1S05QVzlLZTRpSldv?=
 =?utf-8?B?S0FPTU4rNGxPazAvMG9BanpMajBobFYzMU00S0wyeXBMRkhHTnVEeFgyc0lv?=
 =?utf-8?B?UnFhZW15bXJ4VjY5L0k2cUhtQjZLMW1kaEVRRml4bFZKelVZSFZ6NkxoTlV6?=
 =?utf-8?B?S0tKVDlDRDZWQzVQcTkwdUFmN2I4S0hEWHVVWDFJRStsZlJEOXlIdlg4SGhk?=
 =?utf-8?B?eDd4d1FUajRub21GZ3ZGU05hNmEyd3FzY2ZGRjRSdXdZYUUxSW9hUWpmZ0VC?=
 =?utf-8?B?azR3Qy9laHZ0M2Y3cloybHlHSTExOXFQVmJ6aUpTZTc2ckRtbHBIQ3dxenRM?=
 =?utf-8?B?RCtqTXM1UDJyNmFSakUzMUtjZEYyWCsyRFhjUEdPblZxME1lOC9IVjdvaFZG?=
 =?utf-8?B?Y0dIanpKam9GREd5NEZxRWdWRjZXblB0MXhiL0Y4YVNYR0VaV295bHhMaXlh?=
 =?utf-8?B?K0V4UlgzQ3VjRWhaK2NsS1RCc1dPK1UzdUtvZFdldGtPclBWMFhRbWt0aVEy?=
 =?utf-8?B?SXQ5ak5yY0dnUzdRb0VOc0lWL2JsNmErOFROM1lKaUExWmtNWXdnaVB4cU1T?=
 =?utf-8?B?TVpQQUNmRVdteWxac0cxbmxmNFBZKzljVjBpc2REYlNGOTF6ckN0Q042N3dt?=
 =?utf-8?B?MnBWY3VrRWRuOHFqVnBjS2oydDd4UWtwd01IRjZIRUZsSURiVXBZb0w3QjVz?=
 =?utf-8?B?SldBZHdFdnJzdk5jc0xHZkNCbXVLL2UzajRsZHZTZUltRWRnZ0QwS3pIcWNN?=
 =?utf-8?B?MDhJWmdpeS9LdFNRcG9wNXhPUEJ2dXZ6ek5DL1l3dmpmK09kdlhNbHpKYnRN?=
 =?utf-8?B?NjB5VVZzdG5HYlZWd2I3WTRGTlZiVjhjWThsREtmOGFFOXp3Y09KVXJSblZF?=
 =?utf-8?B?NklvaDFyYmFvU3pkRXRpYmlGUTZnNzFVT0RXMW5JaCtXamxRVjN4UlZDNHlD?=
 =?utf-8?B?OHJQTy9kRndCTEdSOUdCcEhmeUlIVDRIT0RyUU1ZMmhXMGFBaEpvZVFickkx?=
 =?utf-8?B?MUdGdFhOMm5sbmdndmtvQk9BQUx1UTdDcTBCRTJRMW8wemhheldWRTNvMVUx?=
 =?utf-8?B?Z2daTXZCN2NnTHlmYjNBanNNemU3UFh1cS9sWnhIblp3bHo3UnZNRjN1NUo0?=
 =?utf-8?B?blE5SGVwRklKYzlacGpiSmFVcUZiaVlMdFF4S2pxVXZnY24yWVp2a1hzNXdZ?=
 =?utf-8?B?Q25qdHFZMWkvenAvSzdvT0g0czhBOWtUNjRPYVhCQUc3NzF2a1I2R0srdXQ3?=
 =?utf-8?B?Y25YSUR2cm5NVU9ZcGN2UFNjdnpPdXFHU2RDRysxaWZsWmZBcG9rY3JSQ1J0?=
 =?utf-8?B?UjExeEMyQUdodDdVR09wMEx5TGkyQ1JRbElLN1ljeEtZSTRxN2pwd2JVSFV3?=
 =?utf-8?B?cmpZYVlJNmZZZWgzVmtpTloyZ056eGRmelVCWlNjTDdEYS9QMHZCaWNLaE4v?=
 =?utf-8?B?MTZTdTdpcUlLcnB1K3VLWWM4QzVVYnluNkxyb0RodXBuVnprYkhwcmpvZ2tD?=
 =?utf-8?B?UGlxbzIzZVgxN00zNjUyZERnM0ovZmpwU0pxdGNtNFRKb1B5NW1PUjNwMER3?=
 =?utf-8?B?dXdpQXdpMnhGUVdkMTBFdXA5eVpsejNYQ1llT1JpU0tZRHJ5RDJ2bkMxM1dF?=
 =?utf-8?B?Rmw5a2NsYWNQOWNhWTZDdWJHSE5LakN4Z2dIY1BLSHNCdStUUGVPUWdaVEpY?=
 =?utf-8?B?eFB0dXM3ekJ4enBOTTEyOWg5am04QmpQSlBSYWtGRkNRdGtQUWJrQVppeCtZ?=
 =?utf-8?B?UjF5UlYwRU4wKzgzbmdlbnE3V2MyNkVENWIrNDFlUk1mZGwyaXFQdG5XRytR?=
 =?utf-8?B?b09GZ1pnb1lreG5LN0tHcEt6RG5UWUtUdC9LSk1rVU9FUktWOXYyc1JlaVZr?=
 =?utf-8?Q?Tks31xxueycVpLtm7FMoGeF/q?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:06:11.9917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 245ee222-d835-4c66-8bbb-08de16c2066f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7664

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Plesae find the v5 AccECN case handling patch series, which covers
several excpetional case handling of Accurate ECN spec (RFC9768),
adds new identifiers to be used by CC modules, adds ecn_delta into
rate_sample, and keeps the ACE counter for computation, etc.

This patch series is part of the full AccECN patch series, which is available at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best regards,
Chia-Yu

---
v5:
- Move previous #11 in v4 in latter patch after discussion with RFC author.
- Add #3 to update the comments for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN. (Parav Pandit <parav@nvidia.com>)
- Add gro self-test for TCP CWR flag in #4. (Eric Dumazet <edumazet@google.com>)
- Add fixes: tag into #7 (Paolo Abeni <pabeni@redhat.com>)
- Update commit message of #8 and if condition check (Paolo Abeni <pabeni@redhat.com>)
- Add empty line between variable declarations and code in #13 (Paolo Abeni <pabeni@redhat.com>)

v4:
- Add previous #13 in v2 back after dicussion with the RFC author.
- Add TCP_ACCECN_OPTION_PERSIST to tcp_ecn_option sysctl to ignore AccECN fallback policy on sending AccECN option.

v3:
- Add additional min() check if pkts_acked_ewma is not initialized in #1. (Paolo Abeni <pabeni@redhat.com>)
- Change TCP_CONG_WANTS_ECT_1 into individual flag add helper function INET_ECN_xmit_wants_ect_1() in #3. (Paolo Abeni <pabeni@redhat.com>)
- Add empty line between variable declarations and code in #4. (Paolo Abeni <pabeni@redhat.com>)
- Update commit message to fix old AccECN commits in #5. (Paolo Abeni <pabeni@redhat.com>)
- Remove unnecessary brackets in #10. (Paolo Abeni <pabeni@redhat.com>)
- Move patch #3 in v2 to a later Prague patch serise and remove patch #13 in v2. (Paolo Abeni <pabeni@redhat.com>)

---
Chia-Yu Chang (12):
  net: update commnets for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
  selftests/net: gro: add self-test for TCP CWR flag
  tcp: L4S ECT(1) identifier and NEEDS_ACCECN for CC modules
  tcp: disable RFC3168 fallback identifier for CC modules
  tcp: accecn: handle unexpected AccECN negotiation feedback
  tcp: accecn: retransmit downgraded SYN in AccECN negotiation
  tcp: move increment of num_retrans
  tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN
    SYN/ACK
  tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
  tcp: accecn: fallback outgoing half link to non-AccECN
  tcp: accecn: detect loss ACK w/ AccECN option and add
    TCP_ACCECN_OPTION_PERSIST
  tcp: accecn: enable AccECN

Ilpo Järvinen (2):
  tcp: try to avoid safer when ACKs are thinned
  gro: flushing when CWR is set negatively affects AccECN

 Documentation/networking/ip-sysctl.rst        |  4 +-
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/skbuff.h                        | 13 ++-
 include/linux/tcp.h                           |  4 +-
 include/net/inet_ecn.h                        | 20 +++-
 include/net/tcp.h                             | 32 ++++++-
 include/net/tcp_ecn.h                         | 92 ++++++++++++++-----
 net/ipv4/sysctl_net_ipv4.c                    |  4 +-
 net/ipv4/tcp.c                                |  2 +
 net/ipv4/tcp_cong.c                           | 10 +-
 net/ipv4/tcp_input.c                          | 37 +++++++-
 net/ipv4/tcp_minisocks.c                      | 40 +++++---
 net/ipv4/tcp_offload.c                        |  3 +-
 net/ipv4/tcp_output.c                         | 42 ++++++---
 tools/testing/selftests/net/gro.c             | 80 +++++++++++-----
 15 files changed, 294 insertions(+), 90 deletions(-)

-- 
2.34.1


