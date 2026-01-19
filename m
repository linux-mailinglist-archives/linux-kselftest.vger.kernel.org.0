Return-Path: <linux-kselftest+bounces-49409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03427D3B6B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67D1E3123B4F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4715392B95;
	Mon, 19 Jan 2026 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="F3A5qipf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010020.outbound.protection.outlook.com [52.101.84.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C0538B9AF;
	Mon, 19 Jan 2026 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849185; cv=fail; b=Jua7DSQoM6TyxWLxbASX3SjVmwBsQe30xNlaMiokiCeJH1XoqiSXTxx4huZkWxtdaYSNRnF2ytfGVhQgmBbs6Ox8EcG0RL9PJdx5A9v41fNrTTxf66acuhK8Hxskiv+vucOt+eBUqDO+R2Iw3SUWOu/qm8bqu4zaclejxUw1tpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849185; c=relaxed/simple;
	bh=n19sG+lbN+3ZHDWIukAJJRbT8J2sehuJVUmEjrTXWOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYd54zHDZU90keXzkFvtWq7lKs0MOlxtXr7rS18eLBp5yNBpEPkWDXGCDqYkqBZDoSAPsyyZ/IdaNNQSw8+uSH99CfkCfhOO9WjOxPG4vb5XX5u/IkfWQGA+ky3WCfQaI6BZkmtEuPAOz94xkSxHspNwjmIzGm4q2kZEZLGvLis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=F3A5qipf; arc=fail smtp.client-ip=52.101.84.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ia0z3hwNSBFtRZjfcrrpk1Yvri4YvtszVCZ5kruBUL4JrFiebMYLfB4RHSTeYrZDvIZ+rl4YErk2qZu6M2pM6xyQcoETG6/Y3+sXsZOhVyQmRUNeahEVF1o59/sUopnrce3R5Fid7fUdVvmNudiwAbALjf4G45UlAinA3r0hHgaybAFldwvmbbsRlGv+jji8LCPV2wqh7Oz5ntrWxDKVLdgfHa1hNTBcI+7prC8qc+k9Jff3TrWl69KM9d1c6yvzwXFV7+q+9nFpoN62nWobSK8E53nL4Ye8l5z627oBCOR5jlerYT6EheNHixqrtoHcleKtK5F2UM0C/Pa7TgVsnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqE3Hx/v6ppby50Z5TrnfZhBiWyxtHdA3bbqpT0OJQI=;
 b=I+lywXrq73t+i1DpBLbPebNJToIf+Y4l85NrnVqjHK6QBh+OM9GnqyfkdEackXfyG4vBtiBUxKZVk/zU93JopBZPYfh0O3otE4zf89WNgvqwHFx+TKv2mlhNtNWoLULt1YD1Vq74yybQgGeltnfCYVlDZXq3V8InX1+H45PUFeTodpD1CJk867VinfjnZBf7GS2kANmM6GWVRe0LU0x9G8GYu20RVoiLt6uRhfi8ZOvdavawffLnbLwYq3iliON6F5VY7idYz0z/teXj03GXuec4Z6oF/TcW+W7JjolAgvJJnziRb+dbCaE92DzOnqA0Dfvq5je9hHis899ZWJQAGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqE3Hx/v6ppby50Z5TrnfZhBiWyxtHdA3bbqpT0OJQI=;
 b=F3A5qipfxwhlbs7ce08DFzdfqJ2Gsi0W+fxd5KEmfdxJ3JQbgL1Ubu1Pevicc2HYnNDpiGuqARX3rGVIE3E/cJtEj2lJ5tUsLUL9/qtD3XPZgd6ovtOwf3g8mP9kIX7FRSUJQ9uqjZe/wOQmRttom2NMRZFbYNhN/gdz38TcJvLknKJ8sMnbsT7y+og9AmqaVoe7Hs3mn+2cGbu1QopZhsT8MsAhFH/CIP5liGvEVaFdch3dJJK0NzugfGcwrkQLL6rS4y7qPpYudBRy03Jo3744HCqjXTlk2cJUkdCHVNS0z5XXwFgs6YMq/6XwukzYGoYcgCjYeChbthbjH4k+IQ==
Received: from DBBPR09CA0027.eurprd09.prod.outlook.com (2603:10a6:10:d4::15)
 by VI1PR0701MB6975.eurprd07.prod.outlook.com (2603:10a6:800:19f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:59:33 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:d4:cafe::5c) by DBBPR09CA0027.outlook.office365.com
 (2603:10a6:10:d4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 18:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 18:59:33 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 8FC11200C1;
	Mon, 19 Jan 2026 20:59:31 +0200 (EET)
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
Subject: [PATCH v9 net-next 15/15] selftests/net: packetdrill: add TCP Accurate ECN cases
Date: Mon, 19 Jan 2026 19:58:52 +0100
Message-Id: <20260119185852.11168-16-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885D:EE_|VI1PR0701MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e739c2d-4303-4dc8-28a0-08de578ce219
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZkVXZjJJd2pVSmlmTEsrRjZYY1ovdHR0cGJkdE1sdHk5MGRlYytRN2F3dVlz?=
 =?utf-8?B?dlAybTdlOXMwc3dDMkZyK1U0NmlFMjBGdVFBTjdqTExHTE1odDNHTjFoQXV0?=
 =?utf-8?B?c0JWODlBYXpLSkluMTV0TGdZckRXRWFxdmhTaU5FT0xlZ1ArdVd3UitjYS9T?=
 =?utf-8?B?OVB1K1JRajd5KzNnMlFoN1dON0IzazhMd3doMjEwZ01kaEpNUW1UaUdxTlNy?=
 =?utf-8?B?RjlMbDB5WUNZNU1PaC8wUWpodUU2N29Qam12b09BMzUzOEdkcmdYczIyc2la?=
 =?utf-8?B?UGZrVUdHMFEvbkRrQ2laQ3NOL2MwSlIxemVYMEptOXdHRytCTVEwaWtxMnBu?=
 =?utf-8?B?TkRTdnI1QU8wN3JWdGhMYmQ2MmU1dk1UOG8vWHVkWTRLYU5xeEpqeG56ZXQ2?=
 =?utf-8?B?QWFGZXdoelhOSzdOS24veGxYUVF2MzE0Q2JzV29JSVlPa0xCUTV5cTVWVFlK?=
 =?utf-8?B?ejNzdGV3SXJicmxrOWZrQzJOQ1MwVlRaV09FZ1BwVDFJMUtsMUZxQmVtWXlR?=
 =?utf-8?B?b3grTWpUNzZWdE0wZythYU83ZVE4bk5oUWsreFJzeFNvMGdtYVVRaGY3ZWNY?=
 =?utf-8?B?T1Q5M2xjMURSTzFMV1NwTE82SjZPWVRETTRjRDRDS1puTGtxaEJXK01sTkFy?=
 =?utf-8?B?bzVZOXFpL2E5VWdNT3FQR2hvL21vS0trQ3RITDI2YmkySlZPWmk4ZWhFdmI2?=
 =?utf-8?B?cWtpaThxM0RSV3MrMHZiTWx2L2tvNGh5cDJGSWhVWHowOW96OTFxbHpzVENO?=
 =?utf-8?B?czFGLzZGRlo3OVlxR2IvaGw0eHdQcW9GSmdHOXloMzhGMnJaWjIrNUZxdCtR?=
 =?utf-8?B?bGtId0R6RkdkQVdGMXRHMDhDVE5IQmRkbWRWSGRqOTRQRDNZaTVYZnZySDdp?=
 =?utf-8?B?TW5hLzg2d0FtZFdOM2YzRFhiY040MUw0MEZGSzZFUGEva05YaGxJVmVUYTlC?=
 =?utf-8?B?TitJbTF6eEp5TTE5OS9xcGw0cUFhU3JsNndBSjR2YlU3ZXVuL3pmUThJMWR0?=
 =?utf-8?B?c3lTT21RdXpCSEhMclAwRnh3dVV2YWJOYVk0RGZpVXhwd1pOY3p4VzI4Y0tT?=
 =?utf-8?B?NlZ6TEJSZ2QzNStSeUMzKytzZzRZQU9KRjJVZlkrWndjRXBqdDFkeEtWbzJZ?=
 =?utf-8?B?UG1Fb1U4LzRaNUY3UlZrdEdab2xmR2hBQlRER0NKTkx6ZEtvVUhIK2lqVDlE?=
 =?utf-8?B?OGZ0Snp6b000VzBtdDg3cThJSDViaVZrWmVBeXl1OWpkdXJ2SjlVZ1RGa29I?=
 =?utf-8?B?VXoydjdPM24zZ0I4Sm9KbnhOSUdrWloraFd6VFFPSnpEUUROVzlZdXJqdm0v?=
 =?utf-8?B?MXk2YUZLdEFvdWFwRXRSVlhoclNkVkZDckozbTVqWW9xdWJZdU9BOThsSFJQ?=
 =?utf-8?B?K2dIQkZWQlJITG9mSTQ4bWFQY0Q3UzZwNS9FQWlyWFVlTk9nbUdrSWdmVm02?=
 =?utf-8?B?UlhZZzhoTlJHRmhkYjliOHJpUnB1YlZmZGxDdE1mTnByM2taYjRBQUtxN25y?=
 =?utf-8?B?alN6UE9pZHdLMUxFRVRKSnhrRDdzMVFVRVV2U3ppQXVEcFR5alZ4V2doeGRx?=
 =?utf-8?B?WFFkckk2MU9lbVFjWG5jbGM3SXljMW5MaVF0QzVkVVN1ditUUk5KYUEvN1pI?=
 =?utf-8?B?aUtWd0N3cHovN3h3bFZOeE00ak51MWJjUjNYRzhTMDV4VHIwVlcramxzS2lw?=
 =?utf-8?B?U0NFakZnaUFOSkpJTVJIaHFleHJVYUt2eWM1cW1MZUhaSnJvNlZMdk4vekdn?=
 =?utf-8?B?cmdZV0xQdjBvYjV2N1lQNVdKaGp5ay9vSlhYdU1Naks2VlpNTnRLVnowQm5K?=
 =?utf-8?B?YkNEQXFsQ0dWT2xoZlU0NWpIUnA0QTZmQWZSdVNpTVdRcElIWGJaRjB4T1FX?=
 =?utf-8?B?a1lyMVhldXhwTFluMzdySitOQU9tSDVvTkJCL29Hc3ZCdzNZa1pYczVSWFJP?=
 =?utf-8?B?L280S21vV1pRQzdXQWhsT0dhd0owblZoeHRQWGhWb2ZSYXJoU041dFFUS3hH?=
 =?utf-8?B?UHd6RzQwK1N1M1FLQkY5Q3ZaYnVCZmJrZ0o5Z3lXb2d4eUJKc09ZRHVSV0Jv?=
 =?utf-8?B?OVlVczNqRXpsNU4zNUFvbGR0ZXFWK2ZkRnFaUE45cSt1UTY0VmpwamJySkw2?=
 =?utf-8?B?NFRRNkk5ejB2aHd5WG9zUnUvVFlkU2pjUlcxMzdyOXh5OUNMMEhveDVJZ0Z1?=
 =?utf-8?B?VkNKRzZmTkFobWZCWkFxQ1NJakhKdDlLQm4yckhXOE1vc3NOcFY2bW8ycWdD?=
 =?utf-8?Q?WiD2snTV52UFQTqHLCVsQd670kktRbQhsla0GooxAo=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:59:33.2385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e739c2d-4303-4dc8-28a0-08de578ce219
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6975

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Linux Accurate ECN test sets using ACE counters and AccECN options to
cover several scenarios: Connection teardown, different ACK conditions,
counter wrapping, SACK space grabbing, fallback schemes, negotiation
retransmission/reorder/loss, AccECN option drop/loss, different
handshake reflectors, data with marking, and different sysctl values.

The packetdrill used is commit cbe405666c9c8698ac1e72f5e8ffc551216dfa56
of repo: https://github.com/minuscat/packetdrill/tree/upstream_accecn.
And corresponding patches are sent to google/packetdrill email list.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>

--
v9:
- Update commit message

v8:
- Change patch title
- Rename all AccECN cases with tcp_accecn in the prefix
- Move all cases under tools/testing/selftests/net/packetdrill/
---
 .../tcp_accecn_2nd_data_as_first.pkt          | 24 +++++++
 .../tcp_accecn_2nd_data_as_first_connect.pkt  | 30 ++++++++
 .../tcp_accecn_3rd_ack_after_synack_rxmt.pkt  | 19 +++++
 ..._accecn_3rd_ack_ce_updates_received_ce.pkt | 18 +++++
 .../tcp_accecn_3rd_ack_lost_data_ce.pkt       | 22 ++++++
 .../net/packetdrill/tcp_accecn_3rd_dups.pkt   | 26 +++++++
 .../tcp_accecn_acc_ecn_disabled.pkt           | 14 ++++
 .../tcp_accecn_accecn_then_notecn_syn.pkt     | 28 ++++++++
 .../tcp_accecn_accecn_to_rfc3168.pkt          | 18 +++++
 .../tcp_accecn_client_accecn_options_drop.pkt | 34 +++++++++
 .../tcp_accecn_client_accecn_options_lost.pkt | 38 ++++++++++
 .../tcp_accecn_clientside_disabled.pkt        | 12 ++++
 ...cecn_close_local_close_then_remote_fin.pkt | 25 +++++++
 .../tcp_accecn_delivered_2ndlargeack.pkt      | 25 +++++++
 ..._accecn_delivered_falseoverflow_detect.pkt | 31 ++++++++
 .../tcp_accecn_delivered_largeack.pkt         | 24 +++++++
 .../tcp_accecn_delivered_largeack2.pkt        | 25 +++++++
 .../tcp_accecn_delivered_maxack.pkt           | 25 +++++++
 .../tcp_accecn_delivered_updates.pkt          | 70 +++++++++++++++++++
 .../net/packetdrill/tcp_accecn_ecn3.pkt       | 12 ++++
 .../tcp_accecn_ecn_field_updates_opt.pkt      | 35 ++++++++++
 .../packetdrill/tcp_accecn_ipflags_drop.pkt   | 14 ++++
 .../tcp_accecn_listen_opt_drop.pkt            | 16 +++++
 .../tcp_accecn_multiple_syn_ack_drop.pkt      | 28 ++++++++
 .../tcp_accecn_multiple_syn_drop.pkt          | 18 +++++
 .../tcp_accecn_negotiation_bleach.pkt         | 23 ++++++
 .../tcp_accecn_negotiation_connect.pkt        | 23 ++++++
 .../tcp_accecn_negotiation_listen.pkt         | 26 +++++++
 .../tcp_accecn_negotiation_noopt_connect.pkt  | 23 ++++++
 .../tcp_accecn_negotiation_optenable.pkt      | 23 ++++++
 .../tcp_accecn_no_ecn_after_accecn.pkt        | 20 ++++++
 .../net/packetdrill/tcp_accecn_noopt.pkt      | 27 +++++++
 .../net/packetdrill/tcp_accecn_noprogress.pkt | 27 +++++++
 .../tcp_accecn_notecn_then_accecn_syn.pkt     | 28 ++++++++
 .../tcp_accecn_rfc3168_to_fallback.pkt        | 18 +++++
 .../tcp_accecn_rfc3168_to_rfc3168.pkt         | 18 +++++
 .../tcp_accecn_sack_space_grab.pkt            | 28 ++++++++
 .../tcp_accecn_sack_space_grab_with_ts.pkt    | 39 +++++++++++
 ...tcp_accecn_serverside_accecn_disabled1.pkt | 20 ++++++
 ...tcp_accecn_serverside_accecn_disabled2.pkt | 20 ++++++
 .../tcp_accecn_serverside_broken.pkt          | 19 +++++
 .../tcp_accecn_serverside_ecn_disabled.pkt    | 19 +++++
 .../tcp_accecn_serverside_only.pkt            | 18 +++++
 ...n_syn_ace_flags_acked_after_retransmit.pkt | 18 +++++
 .../tcp_accecn_syn_ace_flags_drop.pkt         | 16 +++++
 ...n_ack_ace_flags_acked_after_retransmit.pkt | 27 +++++++
 .../tcp_accecn_syn_ack_ace_flags_drop.pkt     | 27 +++++++
 .../net/packetdrill/tcp_accecn_syn_ce.pkt     | 13 ++++
 .../net/packetdrill/tcp_accecn_syn_ect0.pkt   | 13 ++++
 .../net/packetdrill/tcp_accecn_syn_ect1.pkt   | 13 ++++
 .../net/packetdrill/tcp_accecn_synack_ce.pkt  | 28 ++++++++
 ..._accecn_synack_ce_updates_delivered_ce.pkt | 22 ++++++
 .../packetdrill/tcp_accecn_synack_ect0.pkt    | 24 +++++++
 .../packetdrill/tcp_accecn_synack_ect1.pkt    | 24 +++++++
 .../packetdrill/tcp_accecn_synack_rexmit.pkt  | 15 ++++
 .../packetdrill/tcp_accecn_synack_rxmt.pkt    | 25 +++++++
 .../packetdrill/tcp_accecn_tsnoprogress.pkt   | 26 +++++++
 .../net/packetdrill/tcp_accecn_tsprogress.pkt | 25 +++++++
 58 files changed, 1366 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_after_synack_rxmt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_ce_updates_received_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_lost_data_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_dups.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_acc_ecn_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_then_notecn_syn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_to_rfc3168.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_lost.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_clientside_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_close_local_close_then_remote_fin.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_2ndlargeack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_falseoverflow_detect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack2.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_maxack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_updates.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ecn3.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ecn_field_updates_opt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ipflags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_listen_opt_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_ack_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_bleach.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_listen.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_noopt_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_optenable.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_no_ecn_after_accecn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_noopt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_noprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_notecn_then_accecn_syn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_fallback.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_rfc3168.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab_with_ts.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled2.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_broken.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_ecn_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_only.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_acked_after_retransmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_acked_after_retransmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce_updates_delivered_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rexmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rxmt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_tsnoprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_tsprogress.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first.pkt
new file mode 100644
index 000000000000..07e9936e70e6
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first.pkt
@@ -0,0 +1,24 @@
+// 3rd ACK + 1st data segment lost, data segments with ce
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
++0.05 < SEWA 0:0(0) win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+// 3rd ACK lost
+// 1st data segment lost
++0.05 < [ce] EAP. 1001:2001(1000) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] WA. 1:1(0) ack 1 <ECN e1b 1 ceb 1000 e0b 1,nop,nop,nop,sack 1001:2001>
++.002 accept(3, ..., ...) = 4
+
++0.2 < [ce] EAP. 1:1001(1000) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.001 > [ect0] EWA. 1:1(0) ack 2001 <ECN e1b 1 ceb 2000 e0b 1,nop>
+
++0.05 < [ce] EAP. 2001:3001(1000) ack 1 win 264
++.001 > [ect0] . 1:1(0) ack 3001 <ECN e1b 1 ceb 3000 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first_connect.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first_connect.pkt
new file mode 100644
index 000000000000..76b8422b34dc
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first_connect.pkt
@@ -0,0 +1,30 @@
+// 3rd ACK + 1st data segment lost, 2nd data segments with ce
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] SW. 0:0(0) ack 1 win 32767 <mss 1016,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
+// 3rd ACK lost
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 write(4, ..., 2000) = 2000
+// 1st data segment lost + 2nd gets CE
++.002 > [ect0] .5 1:1005(1004) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.000 > [ect0] P.5 1005:2001(996) ack 1 <ECN e1b 1 ceb 0 e0b 1, nop>
++0.05 < [ect0] .6 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 996 e1b 1,nop,nop,nop,sack 1005:2001>
+
++0.01 %{ assert tcpi_delivered_ce == 1, tcpi_delivered_ce }%
+
++0.002~+0.1 > [ect0] .5 1:1005(1004) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.05 < [ect0] .6 1:1(0) ack 2001 win 264 <ECN e0b 1005 ceb 996 e1b 1,nop>
+
++0.01 write(4, ..., 1000) = 1000
++0~+0.002 > [ect0] P.5 2001:3001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.1 < [ect0] .5 1:1001(1000) ack 3001 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++0~+0.01 > [ect0] .5 3001:3001(0) ack 1001 <ECN e1b 1 ceb 0 e0b 1001,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_after_synack_rxmt.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_after_synack_rxmt.pkt
new file mode 100644
index 000000000000..84060e490589
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_after_synack_rxmt.pkt
@@ -0,0 +1,19 @@
+// Test 3rd ACK flags when SYN-ACK is rexmitted
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.1 < [ect0] S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// Our code currently sends a challenge ACK
+// when it receives a SYN in ESTABLISHED state
+// based on the latest SYN
++.002 > [ect0] A. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_ce_updates_received_ce.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_ce_updates_received_ce.pkt
new file mode 100644
index 000000000000..d3fe09d0606f
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_ce_updates_received_ce.pkt
@@ -0,0 +1,18 @@
+// Third ACK CE increases r.cep
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
++0.05 < SEWA 0:0(0) win 32767 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ce] W. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] WAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_lost_data_ce.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_lost_data_ce.pkt
new file mode 100644
index 000000000000..d28722db42b1
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_lost_data_ce.pkt
@@ -0,0 +1,22 @@
+// 3rd ACK lost, CE for the first data segment
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
++0.05 < SEWA 0:0(0) win 32767 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+// 3rd ACK lost
++0.05 < [ce] EAP. 1:1001(1000) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] WA. 1:1(0) ack 1001 <ECN e1b 1 ceb 1000 e0b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.05 < [ce] EAP. 1001:2001(1000) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.001 > [ect0] EWA. 1:1(0) ack 2001 <ECN e1b 1 ceb 2000 e0b 1 ,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_dups.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_dups.pkt
new file mode 100644
index 000000000000..a4d808116e34
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_dups.pkt
@@ -0,0 +1,26 @@
+// Test SYN/ACK rexmit triggered 3rd ACK duplicate + CE on first data seg
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// SYN/ACK rexmitted => two 3rd ACKs in-flight
++1.0~+1.1 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+// Delivered 1st 3rd ACK
++0.05 < [ect0] W. 1:1(0) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
+// Duplicate 3rd ACK delivered
++1.05 < [ect0] W. 1:1(0) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
+
++0.05 < [ce] EAP. 1:1001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] WA. 1:1(0) ack 1001 <ECN e1b 1 ceb 1000 e0b 1,nop>
+   +0 read(4, ..., 1000) = 1000
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_acc_ecn_disabled.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_acc_ecn_disabled.pkt
new file mode 100644
index 000000000000..509838d5a4b2
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_acc_ecn_disabled.pkt
@@ -0,0 +1,14 @@
+// Test that when accurate ECN is disabled,
+// client uses RFC3168 ECN for SYN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=1
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEW 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] S. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,nop,nop,nop,wscale 8>
++.002 > [noecn] . 1:1(0) ack 1
+
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_then_notecn_syn.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_then_notecn_syn.pkt
new file mode 100644
index 000000000000..10728114b11b
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_then_notecn_syn.pkt
@@ -0,0 +1,28 @@
+// Test that SYN-ACK with ACE flags and without
+// ACE flags got dropped. Although we disable ECN,
+// we shouldn't consider this as blackholed as
+// these are dropped due to congestion
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [ect0] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SA. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN
++0.1 < [noecn] S 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
++0.1 < [noecn] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
+// Write with AccECN option but with ip-noecn since we received one SYN with ACE=0
++0.01 write(4, ..., 100) = 100
++.002 > [noecn] P5. 1:101(100) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_to_rfc3168.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_to_rfc3168.pkt
new file mode 100644
index 000000000000..04d928f0d44d
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_to_rfc3168.pkt
@@ -0,0 +1,18 @@
+// Test AccECN -> RFC3168 fallback when sysctl asks for RFC3168 ECN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=1
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SE. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < . 1:1(0) ack 1 win 320
++.002 accept(3, ..., ...) = 4
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] P. 1:1001(1000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_drop.pkt
new file mode 100644
index 000000000000..788af6bea69c
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_drop.pkt
@@ -0,0 +1,34 @@
+// Client negotiates AccECN and starts sending
+// AccECN option in last ACK and data segments
+// Middlebox drops AccECN option and client
+// reverts to ACE flags only
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+sysctl -q net.ipv4.tcp_ecn_option_beacon=1
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.05 < [ect0] EAP. 1:1001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EA. 1:1(0) ack 1001 <ECN e1b 1 ceb 0 e0b 1001,nop>
+   +0 read(4, ..., 1000) = 1000
+
++0.05 < [ect0] EAP. 1:1001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EA. 1:1(0) ack 1001 <ECN e1b 1 ceb 0 e0b 2001,nop,nop,nop,sack 1:1001>
+
++0.05 < [ect0] EAP. 1:1001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EA. 1:1(0) ack 1001 <nop,nop,sack 1:1001>
+
++0.05 < [ect0] EAP. 1001:2001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EA. 1:1(0) ack 2001
+   +0 read(4, ..., 1000) = 1000
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_lost.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_lost.pkt
new file mode 100644
index 000000000000..d04e11bba37c
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_lost.pkt
@@ -0,0 +1,38 @@
+// Client negotiates AccECN and starts sending
+// AccECN option in last ACK and data segments
+// Middlebox accepts AccECN option but some packets
+// are lost due to congestion. Client should
+// continue to send AccECN option
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [ect0] SW. 0:0(0) ack 1 win 32767 <mss 1024,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] A. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
+// Send
++0.01 write(4, ..., 3000) = 3000
++.002 > [ect0] .5 1:1013(1012) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.002 > [ect0] P.5 1013:2025(1012) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.002 > [ect0] P.5 2025:3001(976) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
+// First two segments were lost due to congestion as SACK was
+// received acknowledging 3rd segment
++0.1 < [ect0] .5 1:1(0) ack 1 win 264 <ECN e1b 1 ceb 0 e0b 977,nop,nop,nop,sack 2025:3001>
+
+// Since data with option was SACKed, we can
+// continue to use AccECN option for the rest of
+// the connection. This one is a rexmt
++.02~+0.5 > [ect0] .5 1:1013(1012) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.1 < [ect0] .5 1:1(0) ack 3001 win 264 <ECN e1b 1 ceb 0 e0b 3000,nop>
+
+// Send new data, it should contain AccECN option
++0.01 write(4, ..., 2000) = 2000
++.002 > [ect0] .5 3001:4013(1012) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.002 > [ect0] P.5 4013:5001(988) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_clientside_disabled.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_clientside_disabled.pkt
new file mode 100644
index 000000000000..c00b36d6a833
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_clientside_disabled.pkt
@@ -0,0 +1,12 @@
+// AccECN sysctl server-side only, no ECN/AccECN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=5
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < S. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,nop,nop,nop,wscale 8>
++.002 > . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_close_local_close_then_remote_fin.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_close_local_close_then_remote_fin.pkt
new file mode 100644
index 000000000000..f9c27f39f354
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_close_local_close_then_remote_fin.pkt
@@ -0,0 +1,25 @@
+// Test basic connection teardown where local process closes first:
+// the local process calls close() first, so we send a FIN, and receive an ACK.
+// Then we receive a FIN and ACK it.
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+ +.01...0.011 connect(3, ..., ...) = 0
+   +0 > [noecn] SEWA 0:0(0) <...>
+   +0 < [ect1] SW. 0:0(0) ack 1 win 32768 <mss 1000,nop,wscale 6,nop,nop,sackOK>
+   +0 > [ect0] EW. 1:1(0) ack 1
+
+   +0 write(3, ..., 1000) = 1000
+   +0 > [ect0] P5. 1:1001(1000) ack 1
+   +0 < [ect0] .5 1:1(0) ack 1001 win 257
+
+   +0 close(3) = 0
+   +0 > [ect0] F5. 1001:1001(0) ack 1
+   +0 < [ect0] .5 1:1(0) ack 1002 win 257
+
+   +0 < [ect0] F5. 1:1(0) ack 1002 win 257
+   +0 > [ect0] . 1002:1002(0) ack 2
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_2ndlargeack.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_2ndlargeack.pkt
new file mode 100644
index 000000000000..6d771234124a
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_2ndlargeack.pkt
@@ -0,0 +1,25 @@
+// Test a large ACK (> ACE field max)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 14600) = 14600
++.002 > [ect0] P.5 1:14601(14600) ack 1
++0.05 < [ect0] .5 1:1(0) ack 1461 win 264
++0.05 < [ect0] .5 1:1(0) ack 14601 win 264
+
++0.01 %{ assert tcpi_delivered_ce == 8, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_falseoverflow_detect.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_falseoverflow_detect.pkt
new file mode 100644
index 000000000000..76384f52b021
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_falseoverflow_detect.pkt
@@ -0,0 +1,31 @@
+// Test false overflow detection with option used to rule out overflow
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
+// Stop sending option to allow easier testing
++0 `sysctl -q net.ipv4.tcp_ecn_option=0`
+
++0.002 write(4, ..., 14600) = 14600
++.002 > [ect0] P.5 1:14601(14600) ack 1
+
++0.05 < [ect0] .5 1:1(0) ack 1460 win 264 <ECN e0b 1461 ceb 0 e1b 1,nop>
++0.05 < [ect0] .5 1:1(0) ack 14601 win 264 <ECN e0b 14601 ceb 0 e1b 1,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 0, tcpi_delivered_ce
+assert tcpi_delivered_e0_bytes == 14600, tcpi_delivered_e0_bytes
+}%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack.pkt
new file mode 100644
index 000000000000..8bce5dce35a2
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack.pkt
@@ -0,0 +1,24 @@
+// Test a large ACK (> ACE field max)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 14600) = 14600
++.002 > [ect0] P.5 1:14601(14600) ack 1
++0.05 < [ect0] .5 1:1(0) ack 14601 win 264
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack2.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack2.pkt
new file mode 100644
index 000000000000..5f2b147214f4
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack2.pkt
@@ -0,0 +1,25 @@
+// Test a large ACK (> ACE field max)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 14600) = 14600
++.002 > [ect0] P.5 1:14601(14600) ack 1
+  // Fake CE
++0.05 < [ect0] .6 1:1(0) ack 14601 win 264
+
++0.01 %{ assert tcpi_delivered_ce == 1, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_maxack.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_maxack.pkt
new file mode 100644
index 000000000000..fd07bdc14f37
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_maxack.pkt
@@ -0,0 +1,25 @@
+// Test a large ACK (at ACE field max delta)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 14600) = 14600
++.002 > [ect0] P.5 1:14601(14600) ack 1
+  // Fake CE
++0.05 < [ect0] .4 1:1(0) ack 14601 win 264
+
++0.01 %{ assert tcpi_delivered_ce == 7, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_updates.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_updates.pkt
new file mode 100644
index 000000000000..cb1e70ff2d26
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_updates.pkt
@@ -0,0 +1,70 @@
+// Test basic AccECN CEP/CEB/E0B/E1B functionality & CEP wrapping
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{
+assert tcpi_delivered_ce == 0, tcpi_delivered_ce
+assert tcpi_delivered_ce_bytes == 0, tcpi_delivered_ce_bytes
+}%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake CE
++0.05 < [ect0] WA. 1:1(0) ack 1001 win 264 <ECN e0b 1 ceb 1000 e1b 1,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 1, tcpi_delivered_ce
+assert tcpi_delivered_ce_bytes == 1000, tcpi_delivered_ce_bytes
+}%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake ect0
++0.05 < [ect0] WA. 1:1(0) ack 2001 win 264 <ECN e0b 1001 ceb 1000 e1b 1,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 1, tcpi_delivered_ce
+assert tcpi_delivered_e0_bytes == 1000, tcpi_delivered_e0_bytes
+}%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 2001:3001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake ce
++0.05 < [ect0] EWA. 1:1(0) ack 3001 win 264 <ECN e0b 1001 ceb 2000 e1b 1,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 2, tcpi_delivered_ce
+assert tcpi_delivered_ce_bytes == 2000, tcpi_delivered_ce_bytes
+}%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 3001:4001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake ect1
++0.05 < [ect0] EWA. 1:1(0) ack 4001 win 264 <ECN e0b 1001 ceb 2000 e1b 1001,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 2, tcpi_delivered_ce
+assert tcpi_delivered_e1_bytes == 1000, tcpi_delivered_e1_bytes
+}%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 4001:5001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake ce
++0.05 < [ect0] . 1:1(0) ack 5001 win 264 <ECN e0b 1001 ceb 3000 e1b 1001,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 3, tcpi_delivered_ce
+assert tcpi_delivered_ce_bytes == 3000, tcpi_delivered_ce_bytes
+}%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_ecn3.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_ecn3.pkt
new file mode 100644
index 000000000000..6627c7bb2d26
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_ecn3.pkt
@@ -0,0 +1,12 @@
+// Test that tcp_ecn=4 uses RFC3168 ECN for SYN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=4
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.05 connect(4, ..., ...) = 0
+
++.002 > SEW 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_ecn_field_updates_opt.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_ecn_field_updates_opt.pkt
new file mode 100644
index 000000000000..51879477bb50
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_ecn_field_updates_opt.pkt
@@ -0,0 +1,35 @@
+// Test basic AccECN CEP/CEB/E0B/E1B functionality & CEP wrapping
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.05 < [ce] EAP. 1:1001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] WA. 1:1(0) ack 1001 <ECN e1b 1 ceb 1000 e0b 1,nop>
+   +0 read(4, ..., 1000) = 1000
+
++0.05 < [ect0] EAP. 1001:2001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] WA. 1:1(0) ack 2001 <ECN e1b 1 ceb 1000 e0b 1001,nop>
+   +0 read(4, ..., 1000) = 1000
+
++0.05 < [ce] EAP. 2001:3001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EWA. 1:1(0) ack 3001 <ECN e1b 1 ceb 2000 e0b 1001,nop>
+   +0 read(4, ..., 1000) = 1000
+
++0.05 < [ect1] EAP. 3001:4001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EWA. 1:1(0) ack 4001 <ECN e1b 1001 ceb 2000 e0b 1001,nop>
+   +0 read(4, ..., 1000) = 1000
+
++0.05 < [ce] EAP. 4001:5001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] . 1:1(0) ack 5001 <ECN e1b 1001 ceb 3000 e0b 1001,nop>
+   +0 read(4, ..., 1000) = 1000
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_ipflags_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_ipflags_drop.pkt
new file mode 100644
index 000000000000..0c72fa4a1251
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_ipflags_drop.pkt
@@ -0,0 +1,14 @@
+// Test IP flags drop
+--tolerance_usecs=50000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 1.1 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++.02 ~ +1.1 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_listen_opt_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_listen_opt_drop.pkt
new file mode 100644
index 000000000000..171f9433e55f
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_listen_opt_drop.pkt
@@ -0,0 +1,16 @@
+// SYN/ACK option drop test
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.02 ~+2 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.02 ~+5 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.02 ~+8 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_ack_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_ack_drop.pkt
new file mode 100644
index 000000000000..0f65cf56cd2b
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_ack_drop.pkt
@@ -0,0 +1,28 @@
+// Test that SYN-ACK with ACE flags and without
+// ACE flags got dropped. Although we disable ECN,
+// we shouldn't consider this as blackholed as
+// these are dropped due to congestion
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [noecn] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN-ACK without option
++1~+1.1 > [noecn] SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// SYN-ACK maybe getting blackholed, disable ECN
++2~+2.2 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++4~+4.4 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// Received an ACK after sending 3rd retransmission, not a blackhole
++0.1 < [noecn] . 1:1(0) ack 1 win 320
++.002 accept(3, ..., ...) = 4
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_drop.pkt
new file mode 100644
index 000000000000..343181633980
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_drop.pkt
@@ -0,0 +1,18 @@
+// Test that SYN with ACE flags and without
+// ACE flags got dropped. Although we disable
+// ECN, we shouldn't consider this as blackholed
+// as these are dropped due to congestion
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 3.1 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++.02~+1.1 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++.02~+1.1 > [noecn] S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++.02~+1.1 > [noecn] S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.1 < [noecn] S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0~+0.01 > [noecn] . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_bleach.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_bleach.pkt
new file mode 100644
index 000000000000..37dabc4603c8
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_bleach.pkt
@@ -0,0 +1,23 @@
+// Test AccECN flags bleach
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] . 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [noecn] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.05 < [ect0] EAP. 1:1(0) ack 1001 win 320
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_connect.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_connect.pkt
new file mode 100644
index 000000000000..5b14892fda51
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_connect.pkt
@@ -0,0 +1,23 @@
+// Test basic AccECN negotiation
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.05 < [ect0] EAP. 1:1(0) ack 1001 win 256 <ECN e0b 1001 ceb 0 e1b 0,nop>
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_listen.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_listen.pkt
new file mode 100644
index 000000000000..25f7cb2feb25
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_listen.pkt
@@ -0,0 +1,26 @@
+// Test basic AccECN negotiation
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.05 < [ect0] EAP. 1:1(0) ack 1001 win 320
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_noopt_connect.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_noopt_connect.pkt
new file mode 100644
index 000000000000..50e08c492a69
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_noopt_connect.pkt
@@ -0,0 +1,23 @@
+// Test basic AccECN negotiation without option
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < SW. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1
++.05 < [ect0] EAP. 1:1(0) ack 1001 win 256
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_optenable.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_optenable.pkt
new file mode 100644
index 000000000000..2904f1ba9975
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_optenable.pkt
@@ -0,0 +1,23 @@
+// Test basic AccECN negotiation, late option enable
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < SW. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1
++.05 < [ect0] EAP. 1:1(0) ack 1001 win 256 <ECN e0b 1001 ceb 0 e1b 1,nop>
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_no_ecn_after_accecn.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_no_ecn_after_accecn.pkt
new file mode 100644
index 000000000000..64e0fc1c1f14
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_no_ecn_after_accecn.pkt
@@ -0,0 +1,20 @@
+// Test client behavior on receiving a non ECN SYN-ACK
+// after receiving an AccECN SYN-ACK and moving to
+// ESTABLISHED state
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
+// Receive an AccECN SYN-ACK and move to ESTABLISHED
++0.05 < [noecn] SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
+// Receive a non ECN SYN-ACK and send a challenge ACK with ACE feedback
++0.1 < [noecn] S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_noopt.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_noopt.pkt
new file mode 100644
index 000000000000..f407c629a3f7
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_noopt.pkt
@@ -0,0 +1,27 @@
+// Test basic AccECN negotiation with option off using sysctl
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1
++0.05 < [ect0] EAP. 1:1(0) ack 1001 win 320
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_noprogress.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_noprogress.pkt
new file mode 100644
index 000000000000..32454e7187f9
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_noprogress.pkt
@@ -0,0 +1,27 @@
+// Test no progress filtering
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake CE and claim no progress
++0.05 < [ect0] WA. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 1000 e1b 1,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 0, tcpi_delivered_ce
+assert tcpi_delivered_ce_bytes == 0, tcpi_delivered_ce_bytes
+}%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_notecn_then_accecn_syn.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_notecn_then_accecn_syn.pkt
new file mode 100644
index 000000000000..6597d5f2d778
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_notecn_then_accecn_syn.pkt
@@ -0,0 +1,28 @@
+// Test that SYN-ACK with ACE flags and without
+// ACE flags got dropped. Although we disable ECN,
+// we shouldn't consider this as blackholed as
+// these are dropped due to congestion
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [noecn] S 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN
++0.1 < [ect0] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
++0.1 < [noecn] . 1:1(0) ack 1 win 320
++.002 accept(3, ..., ...) = 4
+
+// Write with AccECN option but with ip-noecn since we received one SYN with ACE=0
++0.01 write(4, ..., 100) = 100
++.002 > [noecn] P. 1:101(100) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_fallback.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_fallback.pkt
new file mode 100644
index 000000000000..0f97dfcfa82d
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_fallback.pkt
@@ -0,0 +1,18 @@
+// Test RFC3168 fallback when sysctl asks for AccECN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEW 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SE. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < . 1:1(0) ack 1 win 320
++.002 accept(3, ..., ...) = 4
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] P. 1:1001(1000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_rfc3168.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_rfc3168.pkt
new file mode 100644
index 000000000000..9baffdd66fe5
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_rfc3168.pkt
@@ -0,0 +1,18 @@
+// Test RFC3168 ECN when sysctl asks for RFC3168 ECN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=1
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEW 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SE. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < . 1:1(0) ack 1 win 320
++.002 accept(3, ..., ...) = 4
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] P. 1:1001(1000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab.pkt
new file mode 100644
index 000000000000..3fc56f9c6a6f
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab.pkt
@@ -0,0 +1,28 @@
+// Test SACK space grab to fit AccECN option
+--tcp_ts_tick_usecs=1000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++.01 < [ect1] EAP. 1001:2001(1000) ack 1 win 264
++0.002 > [ect0] EA. 1:1(0) ack 1 <ECN e1b 1001 ceb 0 e0b 1,nop,nop,nop,sack 1001:2001>
++.01 < [ect0] EAP. 3001:4001(1000) ack 1 win 264
++0.002 > [ect0] EA. 1:1(0) ack 1 <ECN e1b 1001 ceb 0 e0b 1001,nop,nop,nop,sack 3001:4001 1001:2001>
++.01 < [ce] EAP. 5001:6001(1000) ack 1 win 264
++0.002 > [ect0] WA. 1:1(0) ack 1 <ECN e1b 1001 ceb 1000 e0b 1001,nop,nop,nop,sack 5001:6001 3001:4001 1001:2001>
+// DSACK works?
++.01 < [ect0] EAP. 5001:6001(1000) ack 1 win 264
++0.002 > [ect0] WA. 1:1(0) ack 1 <ECN e1b 1001 ceb 1000 e0b 2001,nop,nop,nop,sack 5001:6001 5001:6001 3001:4001>
++.01 < [ect1] EAP. 6001:7001(1000) ack 1 win 264
++0.002 > [ect0] WA. 1:1(0) ack 1 <ECN e1b 2001 ceb 1000 e0b 2001,nop,nop,nop,sack 5001:7001 3001:4001 1001:2001>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab_with_ts.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab_with_ts.pkt
new file mode 100644
index 000000000000..1c075b5d81ae
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab_with_ts.pkt
@@ -0,0 +1,39 @@
+// Test SACK space grab to fit AccECN option
+--tcp_ts_tick_usecs=1000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,sackOK,TS val 1 ecr 0,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,sackOK,TS val 100 ecr 1,ECN e1b 1 ceb 0 e0b 1,nop,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <nop,nop,TS val 2 ecr 100,ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
+// One SACK block should allow all 3 AccECN fields:
++.01 < [ect1] EAP. 1001:2001(1000) ack 1 win 264 <nop,nop,TS val 3 ecr 100>
++0.002 > [ect0] EA. 1:1(0) ack 1 <nop,nop,TS val 160 ecr 2,ECN e1b 1001 ceb 0 e0b 1,nop,nop,nop,sack 1001:2001>
+
+// Two SACK blocks should fit w/ AccECN if we only need to use 2 AccECN fields: check ect1 arriving.
++.01 < [ect1] EAP. 3001:4001(1000) ack 1 win 264 <nop,nop,TS val 4 ecr 100>
++0.002 > [ect0] EA. 1:1(0) ack 1 <nop,nop,TS val 172 ecr 2,ECN e1b 2001 ceb 0,nop,nop,sack 3001:4001 1001:2001>
+
+// Two SACK blocks should fit w/ AccECN if we only need to use 2 AccECN fields: check CE arriving.
++.01 < [ce] EAP. 5001:6001(1000) ack 1 win 264 <nop,nop,TS val 5 ecr 100>
++0.002 > [ect0] WA. 1:1(0) ack 1 <nop,nop,TS val 184 ecr 2,ECN e1b 2001 ceb 1000,nop,nop,sack 5001:6001 3001:4001>
+
+// Check that DSACK works, using 2 SACK blocks in total, if we only need to use 2 AccECN fields: check ect1 arriving.
++.01 < [ect1] EAP. 5001:6001(1000) ack 1 win 264 <nop,nop,TS val 5 ecr 100>
++0.002 > [ect0] WA. 1:1(0) ack 1 <nop,nop,TS val 196 ecr 2,ECN e1b 3001 ceb 1000,nop,nop,sack 5001:6001 5001:6001>
+
+// Check the case where the AccECN option doesn't fit, because sending ect0
+// with order 1 would rquire 3 AccECN fields,
+// and TS (12 bytes) + 2 SACK blocks (20 bytes) + 3 AccECN fields (2 + 3*3 bytes) > 40 bytes.
+// That's OK; Linux TCP AccECN is optimized for the ECT1 case, not ECT0.
++.01 < [ect0] EAP. 6001:7001(1000) ack 1 win 264 <nop,nop,TS val 5 ecr 100>
++0.002 > [ect0] WA. 1:1(0) ack 1 <nop,nop,TS val 204 ecr 2,nop,nop,sack 5001:7001 3001:4001 1001:2001>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled1.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled1.pkt
new file mode 100644
index 000000000000..6b88ab78bfce
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled1.pkt
@@ -0,0 +1,20 @@
+// Test against classic ECN server
+// Not-ECT on SYN and server sets 1|0|1 (AE is unused for classic ECN)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] SEA. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,TS val 700 ecr 100,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <nop, nop, TS val 200 ecr 700>
+
++0 write(4, ..., 100) = 100
++.002 > [ect0] P.5 1:101(100) ack 1 <nop,nop,TS val 300 ecr 700>
++0 close(4) = 0
+
++.002 > [ect0] F.5 101:101(0) ack 1 <nop,nop,TS val 400 ecr 700>
++0.1 < [noecn] R. 1:1(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled2.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled2.pkt
new file mode 100644
index 000000000000..d24ada008ece
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled2.pkt
@@ -0,0 +1,20 @@
+// Test against classic ECN server
+// Not-ECT on SYN and server sets 0|0|1
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] SE. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,TS val 700 ecr 100,nop,wscale 8>
++.002 > [noecn] . 1:1(0) ack 1 <nop, nop, TS val 200 ecr 700>
+
++0 write(4, ..., 100) = 100
++.002 > [ect0] P. 1:101(100) ack 1 <nop,nop,TS val 300 ecr 700>
++0 close(4) = 0
+
++0 > [noecn] F. 101:101(0) ack 1 <...>
++0.1 < R. 1:1(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_broken.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_broken.pkt
new file mode 100644
index 000000000000..a20d7e890ee1
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_broken.pkt
@@ -0,0 +1,19 @@
+// Test against broken server (1|1|1)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] SEWA. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,TS val 700 ecr 100,nop,wscale 8>
++.002 > [noecn] . 1:1(0) ack 1 <nop, nop, TS val 200 ecr 700>
+
++0 write(4, ..., 100) = 100
++.002 > [noecn] P. 1:101(100) ack 1 <nop,nop,TS val 300 ecr 700>
++0 close(4) = 0
+
++.002 > [noecn] F. 101:101(0) ack 1 <...>
++0.1 < [noecn] R. 1:1(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_ecn_disabled.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_ecn_disabled.pkt
new file mode 100644
index 000000000000..428255bedab7
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_ecn_disabled.pkt
@@ -0,0 +1,19 @@
+// Test against Non ECN server (0|0|0)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] S. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,TS val 700 ecr 100,nop,wscale 8>
++.002 > [noecn] . 1:1(0) ack 1 <nop, nop, TS val 200 ecr 700>
+
++0 write(4, ..., 100) = 100
++.002 > [noecn] P. 1:101(100) ack 1 <nop,nop,TS val 300 ecr 700>
++0 close(4) = 0
+
++.002 > [noecn] F. 101:101(0) ack 1 <nop,nop,TS val 400 ecr 700>
++0.1 < [noecn] R. 1:1(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_only.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_only.pkt
new file mode 100644
index 000000000000..e9a5a0d3677c
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_only.pkt
@@ -0,0 +1,18 @@
+// Test AccECN with sysctl set to server-side only
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=5
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_acked_after_retransmit.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_acked_after_retransmit.pkt
new file mode 100644
index 000000000000..412fa903105c
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_acked_after_retransmit.pkt
@@ -0,0 +1,18 @@
+// Test that SYN with ACE flags was Acked
+// after 2nd retransmission. In this case,
+// since we got SYN-ACK that supports Accurate
+// ECN, we consider this as successful negotiation
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 2.1 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++1~+1.1 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++1~+1.1 > [noecn] S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
+
++0.1 < [noecn] SW. 0:0(0) ack 1 win 32767 <mss 1016,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0~+0.01 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_drop.pkt
new file mode 100644
index 000000000000..4622754a2270
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_drop.pkt
@@ -0,0 +1,16 @@
+// Test that SYN with ACE flags got dropped
+// We retry one more time with ACE and then
+// fallback to disabled ECN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 2.1 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++1~+1.1 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++1~+1.1 > [noecn] S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.1 < [noecn] S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0~+0.01 > [noecn] . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_acked_after_retransmit.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_acked_after_retransmit.pkt
new file mode 100644
index 000000000000..ee15f108cafe
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_acked_after_retransmit.pkt
@@ -0,0 +1,27 @@
+// Test that SYN-ACK with ACE flags was Acked
+// after 2nd retransmission. In this case,
+// since we got the last ACK that supports Accurate
+// ECN, we consider this as successful negotiation
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [noecn] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN-ACK without option
++1~+1.1 > [noecn] SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// SYN-ACK maybe getting blackholed, disable ECN
++2~+2.2 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// Received an ACK with ACE flags, state should be set to negotiation succeeded
++0.1 < [noecn] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_drop.pkt
new file mode 100644
index 000000000000..3807e7fafafb
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_drop.pkt
@@ -0,0 +1,27 @@
+// Test that SYN-ACK with ACE flags got dropped
+// We retry one more time with ACE and then
+// fallback to disabled ECN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [noecn] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN-ACK without option
++1~+1.1 > [noecn] SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// SYN-ACK maybe getting blackholed, disable ECN
++2~+2.2 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// Received an ACK with no ACE flags, state should be set to blackholed
++0.1 < [noecn] . 1:1(0) ack 1 win 320
++0 accept(3, ..., ...) = 4
+
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ce.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ce.pkt
new file mode 100644
index 000000000000..dc83f7a18180
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ce.pkt
@@ -0,0 +1,13 @@
+// Test AccECN ECN field reflector in SYNACK
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < [ce] SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SWA. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect0.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect0.pkt
new file mode 100644
index 000000000000..e63a8d018c37
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect0.pkt
@@ -0,0 +1,13 @@
+// Test AccECN ECN field reflector in SYNACK
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < [ect0] SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SA. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect1.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect1.pkt
new file mode 100644
index 000000000000..23c0e43b3dbe
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect1.pkt
@@ -0,0 +1,13 @@
+// Test AccECN ECN field reflector in SYNACK
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < [ect1] SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SEW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce.pkt
new file mode 100644
index 000000000000..44add14c57f4
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce.pkt
@@ -0,0 +1,28 @@
+// Test SYNACK CE & received_ce update
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [ce] SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] WA. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 write(4, ..., 100) = 100
++.002 > [ect0] P.6 1:101(100) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.05 < [ect0] P.5 1:101(100) ack 101 win 256 <ECN e0b 101 ceb 0 e1b 1,nop>
++.002 > [ect0] .6  101:101(0) ack 101 <ECN e1b 1 ceb 0 e0b 101,nop>
+
++0.01 write(4, ..., 100) = 100
++.002 > [ect0] P.6 101:201(100) ack 101 <ECN e1b 1 ceb 0 e0b 101,nop>
+
++0.1  < [ect1] P.5 201:301(100) ack 201 win 256 <ECN e0b 101 ceb 0 e1b 1,nop>
++.002 > [ect0] .6 201:201(0) ack 101 <ECN e1b 101 ceb 0 e0b 101,nop,nop,nop,sack 201:301>
+
++0.01 < [ce] .6 401:501(100) ack 201 win 256 <ECN e0b 101 ceb 0 e1b 1,nop>
++.002 > [ect0] .7 201:201(0) ack 101 <ECN e1b 101 ceb 100 e0b 101,nop,nop,nop,sack 401:501 201:301>
+
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce_updates_delivered_ce.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce_updates_delivered_ce.pkt
new file mode 100644
index 000000000000..5fd77f466572
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce_updates_delivered_ce.pkt
@@ -0,0 +1,22 @@
+// Reflected SYNACK CE mark increases delivered_ce
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_fallback=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
++0.05 < SEWA 0:0(0) win 32767 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+// Fake ce for prev, ECT validator must be disabled for this to work
++0.05 < [ect0] WA. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 1, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect0.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect0.pkt
new file mode 100644
index 000000000000..f6ad1ea5c0c4
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect0.pkt
@@ -0,0 +1,24 @@
+// Test SYN=0 reflector
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [ect0] SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] A. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 write(4, ..., 100) = 100
++.002 > [ect0] P.5 1:101(100) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.05 < [ect0] P.5 1:1(0) ack 101 win 256 <ECN e0b 101 ceb 0 e1b 1,nop>
+
++0.01 < [ect0] P.5 1:101(100) ack 101 win 256 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] .5 101:101(0) ack 101 <ECN e1b 1 ceb 0 e0b 101,nop>
++0 read(4, ..., 100) = 100
+
++0 close(4) = 0
++0 > F.5 101:101(0) ack 101 <...>
++0.1 < R. 101:101(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect1.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect1.pkt
new file mode 100644
index 000000000000..7ecfc5fb9dbb
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect1.pkt
@@ -0,0 +1,24 @@
+// Test SYN=0 reflector
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [ect1] SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] EW. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 write(4, ..., 100) = 100
++.002 > [ect0] P.5 1:101(100) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.05 < [ect1] P.5 1:1(0) ack 101 win 256 <ECN e0b 101 ceb 0 e1b 1,nop>
+
++0.01 < [ect1] P.5 1:101(100) ack 101 win 256 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] .5 101:101(0) ack 101 <ECN e1b 101 ceb 0 e0b 1,nop>
++0 read(4, ..., 100) = 100
+
++0 close(4) = 0
++0 > F5. 101:101(0) ack 101 <...>
++0.1 < R. 101:101(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rexmit.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rexmit.pkt
new file mode 100644
index 000000000000..9e0959782ef5
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rexmit.pkt
@@ -0,0 +1,15 @@
+// Test 3rd ACK flags when SYN-ACK is rexmitted
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.05 < SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rxmt.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rxmt.pkt
new file mode 100644
index 000000000000..a5a41633af07
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rxmt.pkt
@@ -0,0 +1,25 @@
+// Test that we retransmit SYN-ACK with ACE and without
+// AccECN options after
+// SYN-ACK was lost and TCP moved to TCPS_SYN_RECEIVED
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [noecn] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN-ACK without option
++1~+1.1 > [noecn] SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.1 < [noecn] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
+// We try to write with AccECN option
++0.01 write(4, ..., 100) = 100
++.002 > [ect0] P5. 1:101(100) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_tsnoprogress.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_tsnoprogress.pkt
new file mode 100644
index 000000000000..f3fe2f098966
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_tsnoprogress.pkt
@@ -0,0 +1,26 @@
+// Test TS progress filtering
+--tcp_ts_tick_usecs=1000
+--tolerance_usecs=7000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,sackOK,TS val 1 ecr 0,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,sackOK,TS val 10 ecr 1,ECN e1b 1 ceb 0 e0b 1,nop,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <nop,nop,TS val 2 ecr 10>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <nop,nop,TS val 83 ecr 2>
+  // Fake CE and claim no progress
++0.05 < [ect0] WA. 1:1(0) ack 1 win 264 <nop,nop,TS val 2 ecr 83>
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_tsprogress.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_tsprogress.pkt
new file mode 100644
index 000000000000..1446799d2481
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_tsprogress.pkt
@@ -0,0 +1,25 @@
+// Test TS progress filtering
+--tcp_ts_tick_usecs=1000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,sackOK,TS val 1 ecr 0,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,sackOK,TS val 10 ecr 1,ECN e1b 1 ceb 0 e0b 1,nop,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <nop,nop,TS val 2 ecr 10>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <nop,nop,TS val 83 ecr 2>
+  // Fake CE and claim no progress
++0.05 < [ect0] WA. 1:1(0) ack 1 win 264 <nop,nop,TS val 3 ecr 83>
+
++0.01 %{ assert tcpi_delivered_ce == 1, tcpi_delivered_ce }%
-- 
2.34.1


