Return-Path: <linux-kselftest+bounces-48104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE42CEFF5D
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 14:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 766863008CAF
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 13:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403BD2FDC40;
	Sat,  3 Jan 2026 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="L5WLxDmk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013021.outbound.protection.outlook.com [52.101.72.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1ED1917FB;
	Sat,  3 Jan 2026 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445839; cv=fail; b=g6SWbddjmwiEHPJqrD8IBJRAma7/khzXsd92JGiMeAXCn1V/KrDQ/QVlOUYl+QD8/nMHbrDwnggUhgdC2PD7Iu8uJgMEb6xdc5ir8zYFlw/mvkR5L0bnz8yMtKOki5gzDtw6TWfGtlMJfiFykWOot1g2bbisYMJN69gp7nyNS9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445839; c=relaxed/simple;
	bh=aeBPg9ltrFu1FJWEjMpRiI+j7hiD271PNF8jRqCE2YI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ayNdPzLLEBSos5Nsu7J7SBNxi4EQm0EAWA80poZOZzzWsZ9e6uanO6UoHkU+zanfsv8prTp60mBZwqNPh1OHe+NldDX8qZLBPqiYb5kHEmIPGzuPkatlIqPkLgFjkdfWZGy1jYAAFqvEvqyQWKomuyUvWB0AwAAFUtqnxrFNMnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=L5WLxDmk; arc=fail smtp.client-ip=52.101.72.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGHfng8aZ5oXn4+F9mrzOvyrFBAqSus698NSkyixV7FFhMg3wJcPQKUnUNxILo0DC+V9kozBaToMxfeI4AiyLtxH0avdCN4Lj1VVvGvbUCA3Vv0VVa2pGdNtyCd3dfUahGiakYeFjbYifHh8KHMedNmqAWIptIUaK5/FN8Sou81aKxfUxwH+3gN1TNGUfudeBWokZf8qG728jAlUy+HOPtokEscBTnIsgN1dAx++cPG7xTkgad1D3dPQS+OZJkcHwOSY+Uxn3i/yWdV2HdDgpCvzGLKIG7o7lAIm6U/3J/6eLSaALoDKUgTgm3W2lN7zD9+QC9IqzFANt3oMCuhMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohPmBs4RpLd/fHQDcFbtZ5Wn2JgePBoiPfZiiLKEZug=;
 b=IWgu8Xh4Vr0kb7uEpZwCrePJ2gtJLDylZ4w+WFFuq+bZd+q88b4yjtraVwcDGDxeo8i9MTPuQ83NSapBNoQ5v7fg9OtN9a9wSmP3coSaeFZPgJaSCG8BgNj+T7BrXJoBhldqhATj8+1nfmexOQiOOGNyQKQFzkYaSAuXK8n5OqPkpUf+3va+oc5IwRFr7XrD96kr/H2J9LmhAT7l7x0L4V19xT9V5DxCMEaXDKqSWD0n6rJ9DTRUno0+wxVHkCU+QVcG8E46P2za902eKU62EPj9lsQ4KVgPbhBifmDFEZ+tqJjvLo35TNR1eg21hXVMEOLeli5c+IIMmCrC8nQOCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohPmBs4RpLd/fHQDcFbtZ5Wn2JgePBoiPfZiiLKEZug=;
 b=L5WLxDmkjWkYg1Kmp16SwXoyCP3CQ8h5Rr9nWUS3mYhH0T/FyL5uwiskJzZ+9zUchRW5wyelsAOIWK3w+gcI5Yno2YXa1ZKkOl7N1uoi5uq4VPFaCSod0ceS85ZTbCqPT/DCi9EJXZEibgK9H1ToOHjuuemTnliUWGTRCkXQf75vAHK7JIkcgnG0mmYf9g00ftq78o3e9ki3FFWH+on9xhhAAVyj7sm/ua8nYNuO1Y37Ir42KE7tlThqsdWGpIBNHE6+Qaurhon9vK34FB9GeiYigjO0hzQiHqAa1UG3SaoeUahhV8SlePgAl1gL9JcuAk6Ayk6LuzlIYmeGHGOilQ==
Received: from AS4P191CA0009.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::16)
 by DB9PR07MB9102.eurprd07.prod.outlook.com (2603:10a6:10:3d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 13:10:32 +0000
Received: from AM4PEPF00027A6B.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::60) by AS4P191CA0009.outlook.office365.com
 (2603:10a6:20b:5d5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sat, 3
 Jan 2026 13:10:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00027A6B.mail.protection.outlook.com (10.167.16.89) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Sat, 3 Jan 2026 13:10:32 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 9F9881C0030;
	Sat,  3 Jan 2026 15:10:30 +0200 (EET)
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
Subject: [PATCH v7 net-next 00/13] AccECN protocol case handling series
Date: Sat,  3 Jan 2026 14:10:15 +0100
Message-Id: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6B:EE_|DB9PR07MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: dd476dff-dbc2-47b4-e3b3-08de4ac979a5
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?THQxWnlnSm5kd3Y5cHJ0cUZJN3JwTTYzcEhHYlJSc1IrRDdCWHdUT2pCSVA5?=
 =?utf-8?B?SmlHSG51ejJEZ0E4dytDb3A4YzJKSEl1ZGFkYjN2MUwrWFB2OXc5ZHJqT3VU?=
 =?utf-8?B?bE54N0RJdFpWdWxqSDhtV2RlbE5Za1Y3WHNCMDlvcEoxbm13WU51d3U2M2xz?=
 =?utf-8?B?WjZiTmc0eUtFOVNVOXcwSUdSRitWaGRPSjhFT3BvTzBUY3ZvUDE2MXhCUU0x?=
 =?utf-8?B?ZTQ1QW5MWkgzbjZZaHNVck4vZWQvRm5QaUF2bFcrbHdYSEFqZVdsT3dFYVU2?=
 =?utf-8?B?TkxwblVVWkorZ0RPY3UxTGxMeUhuNmYydXRnSEdhenVadnc2YWtoU1ZqaVo0?=
 =?utf-8?B?RFNGYTMxZ09xM3F2cW9xanVjNnhqMGZwWGpKL3pnL25PSTN2cks2NkJMaEFa?=
 =?utf-8?B?Wjk3N3BkNHRsOUI3VzNod3Z0Smg1QzQzTlowN3IwNHBkak05TVo2TXJqaTFI?=
 =?utf-8?B?aksyS3dOYkRSQUorUDdZZU9aL3l2ZGZlZkJBUGNMbHI2RWVPb0NrWmVrTGZE?=
 =?utf-8?B?dDdYZmhYVko2SmZhVkJPd2psanYyZGdGajZubE50bE52Qlc5alUzU3RtLzMr?=
 =?utf-8?B?d2FSRnkwaVZqelg4by9RWkVNTWJOcTFjdld1VWMyVTZDWUlhanBreXlCK2lt?=
 =?utf-8?B?TEM3cWZxWHRzd1dYbm5CcXphcFpiK3dEcDZJTkg2MGxFRFNldVZVQnpjd3JN?=
 =?utf-8?B?dzIxS0pvWTRadDhSNkF4TlRrL3l6cHlORTg2N0Y4WTJvalRVaE5pL1lsV21q?=
 =?utf-8?B?eE9rc2NYWXArOWMra2E3aU1QMVBQdXBJemdudzhFNlBwR0k0SUgxUU1PYUpa?=
 =?utf-8?B?UDJyS3F0N2tvOENydUQwL2poK0M1MUs0Y0RLZTltQVZxRnNyVnEzeHZiTnFT?=
 =?utf-8?B?OFNIalMwZkRBc04weTFuclFtMHhRTHdvMVQ3bmIrUjFlSFRNd1hUR25Lc3hT?=
 =?utf-8?B?bGRaekpiSlNKa0E4eEwyTWlqYndnSTFTa1FzM1M1NkI0WTNiZjNEWlZoV1ZG?=
 =?utf-8?B?SjFySzcvOHY3a0FzKy9NMzJFK1BVSk1vQ0NhdzFKejZhVDZKd1JScXcxeU9T?=
 =?utf-8?B?d1ppUE5XSktOWWNHTkhBcGNqd0ZTaGtyZGFOY1UwMWIwQ1RvOXFIVzNQamcv?=
 =?utf-8?B?dkhWRml0cjJXVmxEcGg4SFhxOE4xTURyM081TndQUUdPZWZpWkd4dHdXbDNp?=
 =?utf-8?B?MzVpUFErZndBdndmcHJ4YmwyYjBENGtnbmtudW9DY3JqT1A4dkpzL255R0Yx?=
 =?utf-8?B?a3NTbGRSWXk4TlJ2NUp2U1ZkeDFzVk5sTW9hQzNBQ3lrQkJHQmYvVGZEODJT?=
 =?utf-8?B?R2RzdXJjWEZTRW5rRHhlSk9xRkFPZ2VFYWVXNmNkbUxYVGxuRDVlRlo2YUFO?=
 =?utf-8?B?T2xwd0xYdTN6cll5dEhwU2NxNmQxYjdQZ1M0YmxqTTNDbjZjN0IvMC9GRDhG?=
 =?utf-8?B?Z0FuZ2NabmY4T2dCWDFZYjBGM1hhTW5EckNDTG5RVEpzcnNKSWl4NVJyaVoz?=
 =?utf-8?B?R1MyNUFVZkVTTEgxcW1ubXVqc1N2aTlqOXIycEtHSkphUlhoNUlsWHRHSkRV?=
 =?utf-8?B?TEFLazVCTzFDWjB2NWdwUi9BbDMvdWZjY1BzZDFsbkt1UXpMbW1xZlBVYy9D?=
 =?utf-8?B?Nmg5djRVcitZN01tVHhobWpZSzhNM01PQTlzWWYxdTQ1L1VTdFVQcmZyTjRy?=
 =?utf-8?B?a0J3NFRuOTRUcGdJQXM2MDJaLzZxdWEzNVdzb04zMFFKVHk4MUk3SHVKcFBy?=
 =?utf-8?B?Wm1ZTUVROUZIdU1VNnVGTXRWOTU4K2tZY2NVUURBNGhselVDS1cydTBDWVYz?=
 =?utf-8?B?bVNGY29vRjc1bmwyQjJ0MzNsVkxXTkw5aEd3OFdPNlEySmVJVllodnh1dHNF?=
 =?utf-8?B?dGg2NS9nSWRqVVlxRDZCaW5CRUoxV2JVYk1IVkhRMExscDFvbzBjRzhsdGNG?=
 =?utf-8?B?QTVZWUd2aVk0VHdvclp3VVRYTUxnbDBKczFYdFVhNFI1eWpqQzg1VW4zbVVS?=
 =?utf-8?B?Uno5MkJGWm16MHdVSEg0MDdCdW1YWkFidWpkQXhDNHJGSldqSklxOFZpbS9V?=
 =?utf-8?B?RXJ0WjFSaXhiYnIzT0JjWlJqWWY2cE5IN3c1VXpNekU4T042SjkwaXVNMzUx?=
 =?utf-8?Q?03hrxeaCpmPDIHWCff4oJ24wv?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 13:10:32.2294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd476dff-dbc2-47b4-e3b3-08de4ac979a5
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A6B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9102

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Plesae find the v7 AccECN case handling patch series, which covers
several excpetional case handling of Accurate ECN spec (RFC9768),
adds new identifiers to be used by CC modules, adds ecn_delta into
rate_sample, and keeps the ACE counter for computation, etc.

This patch series is part of the full AccECN patch series, which is available at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best regards,
Chia-Yu

---
v7:
- Update comments in #3 (Paolo Abeni <pabeni@redhat.com>)
- Update comments and use synack_type TCP_SYNACK_RETRANS and num_timeout in #9. (Paolo Abeni <pabeni@redhat.com>)

v6:
- Update comment in #3 to highlight RX path is only used for virtio-net (Paolo Abeni <pabeni@redhat.com>)
- Rename TCP_CONG_WANTS_ECT_1 to TCP_CONG_ECT_1_NEGOTIATION to distiguish from TCP_CONG_ECT_1_ESTABLISH (Paolo Abeni <pabeni@redhat.com>)
- Move TCP_CONG_ECT_1_ESTABLISH in #6 to latter patch series (Paolo Abeni <pabeni@redhat.com>)
- Add new synack_type instead of moving the increment of num_retran in #9 (Paolo Abeni <pabeni@redhat.com>)
- Use new synack_type TCP_SYNACK_RETRANS and num_retrans for SYN/ACK retx fallbackk for AccECN in #10 (Paolo Abeni <pabeni@redhat.com>)
- Do not cast const struct into non-const in #11, and set AccECN fail mode after tcp_rtx_synack() (Paolo Abeni <pabeni@redhat.com>)

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
Chia-Yu Chang (11):
  selftests/net: gro: add self-test for TCP CWR flag
  tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
  tcp: disable RFC3168 fallback identifier for CC modules
  tcp: accecn: handle unexpected AccECN negotiation feedback
  tcp: accecn: retransmit downgraded SYN in AccECN negotiation
  tcp: add TCP_SYNACK_RETRANS synack_type
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
 include/linux/tcp.h                           |  4 +-
 include/net/inet_ecn.h                        | 20 +++-
 include/net/tcp.h                             | 32 ++++++-
 include/net/tcp_ecn.h                         | 92 ++++++++++++++-----
 net/ipv4/inet_connection_sock.c               |  4 +
 net/ipv4/sysctl_net_ipv4.c                    |  4 +-
 net/ipv4/tcp.c                                |  2 +
 net/ipv4/tcp_cong.c                           |  5 +-
 net/ipv4/tcp_input.c                          | 37 +++++++-
 net/ipv4/tcp_minisocks.c                      | 46 +++++++---
 net/ipv4/tcp_offload.c                        |  3 +-
 net/ipv4/tcp_output.c                         | 32 ++++---
 net/ipv4/tcp_timer.c                          |  3 +
 tools/testing/selftests/drivers/net/gro.c     | 81 +++++++++++-----
 16 files changed, 284 insertions(+), 86 deletions(-)

-- 
2.34.1


