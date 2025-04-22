Return-Path: <linux-kselftest+bounces-31309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DA9A9712E
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A5417F9E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB8128F51B;
	Tue, 22 Apr 2025 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IwPNH+bi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011015.outbound.protection.outlook.com [40.107.130.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB82E28150A;
	Tue, 22 Apr 2025 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336270; cv=fail; b=Sr5h9iqQjl+a2jPcwoBYeMtRqm1H2w4QajxdTgfpzlGn288kw3FnL3zcaiI30/y8/pl66KnL7qlbNI6N90jxkF7kjOPogcmQhSg7y8CDVGg9dDoZ64p2pMmM7A7lCQgLuw417Naflws81PiW7cXlig6/iY1rBrvuZc4NzYTN9Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336270; c=relaxed/simple;
	bh=vuVmMiXIlIFrE9SzFK9pAEnSc3+Q2F1dEruNDsDrnp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NuRlE1UjK3zXtZT2Wcdb0nQ4+cwz01VBQdpskgJoxoe30kl4mh0SvN0fJoH7VDt24CAWRr7ydFStZgwFiWclwSdN3h0x62VbWWLd74CITWdA6xmWyLzjns48VkMW7NPiCvu56VR9DCFMXzrmiCrNxKA36oShGcHWkgjvBR2nKfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IwPNH+bi; arc=fail smtp.client-ip=40.107.130.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEBo3J21St+717WggkB9mii7tAFqZ4sy1SrB5MOQLfPsOAPfqK0woo3XVh/AcVL+XI76GPhWTogPzGE3+f/unx6V8BsdxXWS5eZLb0xuaeU624s6ti8OSpJ7ZntkJavPnV6lUagJULMuBjIBMLoe0T0HPJyYSkxERjp60uNan9ODodFQvLLelAZ7nBJdVItqVG0oNlyBIRHCZu6UiiVuGVWGnvKVX/WN3EI/bYLLc/JAY3xN39V3o8pSINCsKZw/JQTW9QDugtbqI9HfpXOBLTpTQ9eWPZG3L7fmtRXDxhTVyKHNQXW/rryE9Qd8SvKLB0Po6IeTGjnMUtwbxzzIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/lunyvCm0Hb8cd7sJ/iaSABAweI957IMRI5NtjFtSY=;
 b=VBWhcb+PZHv7fl3qOJeG9YFG7wRlrLWHIagnAZJUQH6qNLt19Tb0jnnIXLnXnLSxjWXBPoMDvni2tR11a4NaeYGDUuTx/v0v6airJGGk9c3dCGwDJiYxFv4IQGxnZQV3GsPaj9S/E+Jtns+ziYfrTfAkupfzfQraIABVlxuqlUCeMP/sYREMYP7JkyH++gQUqpCgg1E6TzCOvM3wdOd0mkRf6y1F4wVazkq/iRUzLDmNo+QV0cJATxnHnk7330NsyezDgrj7h+6azr6TRB05vx7kYJtjJFP8kOjic+tZMVmJWlYZo7Kly5ITR9+mTa4vc6tFiSFt8cDSiKgeFLf+dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/lunyvCm0Hb8cd7sJ/iaSABAweI957IMRI5NtjFtSY=;
 b=IwPNH+biMwbETanBRWO1Ay7HXcGHp9ieg2MsPW/Frsn4UNZzaeg1DDB7kGkBVOYN6O3+jxkcn4Lr3ohY/Bv83J93HeAYQv23gJLrgbzPcF2GSpPib0rC4AulEl3oOtxVthuDcsqF+5eQHgknRtIhdaaenYjVSQ2mF+Xzpqtevfw6dwYxeSFs7bZPmjRMuTDTp3TisXE3308W9841Ewrms33X1SuxY9AxM26oAvytd9Em5PZkHoZ2Go4f0k6klAKkTQhZ3mEsEeNsCxa0RkiI/UETnCZwY0K5sI8uaxmHKESOUrnvBWHuMpOtuvL0NrNR5a6qkD9IIzo962x7oVOr+g==
Received: from DB9PR01CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::26) by PAXPR07MB7901.eurprd07.prod.outlook.com
 (2603:10a6:102:134::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Tue, 22 Apr
 2025 15:37:45 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::d5) by DB9PR01CA0021.outlook.office365.com
 (2603:10a6:10:1d8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Tue,
 22 Apr 2025 15:37:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12 via
 Frontend Transport; Tue, 22 Apr 2025 15:37:44 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 94CAB20A27;
	Tue, 22 Apr 2025 18:37:43 +0300 (EEST)
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
Subject: [PATCH v5 net-next 00/15] AccECN protocol patch series
Date: Tue, 22 Apr 2025 17:35:47 +0200
Message-Id: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009525:EE_|PAXPR07MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 32dd5005-711f-4cb9-a4c5-08dd81b3a09f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WWk5SGVoU3ZYMnpvVTUwQXNyRUNSa2J2eC9xanJuZDBBY2FUOHVPZ3g2aFh3?=
 =?utf-8?B?UFBPNXBBSkQ1cVVVb0VIQXJ3RmU5dGJneWtSdGxiVUdPSDdhd2tNL2NLT3VW?=
 =?utf-8?B?Smh2Z1dzQ2QvckRVWWNlcmxRdmRYZWlRUXJUeXRPTEpmcTZqQTc3WXdiZWlk?=
 =?utf-8?B?MGVEbDdRbHhFK1hOQ2RGMFA0a1VMVkRCVnVyMVYxL3BGWDZIYmpLWEpUUEZO?=
 =?utf-8?B?S1A3Y0NjMGdGbTQzQ1FqUkk0QWtLREZ1RnVmY3pJVUgwSm9zT3YxYW1kRTdS?=
 =?utf-8?B?bGliWkY1YVpBSlR6WGpBUUNMSnlqRWMyNUVvVjZseXpKdVI4Q3hWRUVoUVlp?=
 =?utf-8?B?RytRb0dFaHJ4aXNMWGFtLzVBcWk3OTNFb205blVucDZ2bHB3MjE0M2VFdWNy?=
 =?utf-8?B?MlVPUVY1U3V6WmZXYktmbE5GcDlPY29uM3p2THR3bzdTYlNBSmk3VEtoUjZx?=
 =?utf-8?B?Zzc0eWsrVzBRdFp2aG1yajdOQnBoYjJQR0FDTW1mVEMyc1VOVUJWRmRZb2tS?=
 =?utf-8?B?R2UzVEw1a2MydElkWDVWaWVWaFVtNHBDaWtDVUtEVTlTck5TSktOK0p6dDZB?=
 =?utf-8?B?S3hWRk8yRitPNUZSTnBLSFVGbXVBZFJvc2J3eG9FSHhaWUVBZUtCeVl4Uitr?=
 =?utf-8?B?eGRaaGsyaHBLUitkOEpVYm4vSVg0TU42MjBZRU5Uc1hyQUEzUVR2bHBPdHRJ?=
 =?utf-8?B?QU9IbTRHdDl6TmJ5eDM4cHZtd1Y0WmJUbXRNczY5cVNsazJHcTVGaWZ3b0dH?=
 =?utf-8?B?NElybkVTSDYyY3FHelNMaGFpbXdiVGtISFlROHI3NDljMnBSL2ovUDJMV1Jz?=
 =?utf-8?B?MXdMcUxqeC9nZGtwcEZlUHBnSW4xNWxPemkydzRBdCtlbHBYQitpQ3ZVQVZh?=
 =?utf-8?B?d3QxclVNMzQ1cDNMZ3ozaVZHblNRQU9wWFBub3NoN0JvbVRvek1EejJSMTIw?=
 =?utf-8?B?cWRESFVZQXRKUVhEM3BKT3hoZndPTUE5VG5TUm1YdFhkdHkwck9qdEFtQWZW?=
 =?utf-8?B?TGM2WTdIekFLTWUrN1BnL0pwZmVKMG5sVnlKZGo3TGlNT0owSmJyOGQvbjRP?=
 =?utf-8?B?aGo1WjhhdW9WODlzL3N4N3FxV09yeWFxL29lVTNkSWhXbTU3NTM5eDFJWVpU?=
 =?utf-8?B?eStwdFRpMnhJZk9iUVU2K0hjM2pvZmlBemZlQkZOTmd6Q1ZGWTNTQWdoZlky?=
 =?utf-8?B?TU1vZHl4U1lCMGV5aDVSaVd1Y0syQ1hHUVY2OHRSRjFTUEtRRFlIYWZCZFE5?=
 =?utf-8?B?OFFHay9xUHFaaUo5OHo0aHlka0F1Mlc5ZlhHL1ExWVFvMkZ3cjQwM1k0OWw2?=
 =?utf-8?B?ajJJSzZKUEszalU0eG02dFBFbHNXR0RZK1Z5QVRBTlFsVmZCUjlSU1hmZVd0?=
 =?utf-8?B?UzUwSEJOVWsxQXBtaVdqV1R6WnFsMlM5andaS3Q5QWNndFVYKzU0dU5wOXhq?=
 =?utf-8?B?UHYvRFFtSVIzU3RpQVpiQXJZeVlGVHRXT2J4cDRNN0s2enMxaDZJODYvSTgw?=
 =?utf-8?B?WWNjY3NrRDdSemtueG9jUVdlb3cxV0JNZDY0WnJ3WkRTQjFGV0ZnVzdLbHoz?=
 =?utf-8?B?RnFlT0lyVW4zVC9oU0lGRnRWV2lrS0I3MGcxbTQ3SzBhQ1RMMHB4ZDZFLytU?=
 =?utf-8?B?WkttSTNkT3lzMWxEOUhJR0MvNU5SRHlDREJpNEFMUEFid0t3Yy8zTmx1VXB1?=
 =?utf-8?B?QlplVmhWeDFQT3dOVko2NjNkRk1ndkVsMHR0ZmJGajJyVTVtTTZrMERON3d5?=
 =?utf-8?B?TGZVV3BFbDI3YmJRMzBYcjVFZVJFQ0JpaDdiemhtYXFDSnBBZHljN2FXVXBm?=
 =?utf-8?B?NXFoWHRCbk9qYjZNSzE4Ryt3TTBIVkcvUEVmQ1lKcnJwdm9ldjQwUXovYjBX?=
 =?utf-8?B?N3FwL3dvRVdKQm9sVzRtUWxIS2Q1UzNRcTFSNVMrR0c1OW96akVzSTVFeGFv?=
 =?utf-8?B?djIvMStrTVBFbUJaa25ranJRVEhZMHNHVkZhaFlLdWN5U2pERXFaR3loNDU1?=
 =?utf-8?B?ZGJqWGRXczJCeEthRmpzY3dISE9VYjZYekcrTmQ2OEMwVXlUK2ZvWU5MWEtB?=
 =?utf-8?B?d3VNbGJzZEYxRDZWM2lnNmd3UFhWVVd0dlpUQT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 15:37:44.9945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32dd5005-711f-4cb9-a4c5-08dd81b3a09f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7901

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Plese find the v5:

v5 (22-Apr-2025)
- Further fix for 32-bit ARM alignment in tcp.c (Simon Horman <horms@kernel.org>)

v4 (18-Apr-2025)
- Fix 32-bit ARM assertion for alignment requirement (Simon Horman <horms@kernel.org>)

v3 (14-Apr-2025)
- Fix patch apply issue in v2 (Jakub Kicinski <kuba@kernel.org>)

v2 (18-Mar-2025)
- Add one missing patch from previous AccECN protocol preparation patch series to this patch series

The full patch series can be found in
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

The Accurate ECN draft can be found in
https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28

Best regards,
Chia-Yu

Chia-Yu Chang (1):
  tcp: accecn: AccECN option failure handling

Ilpo Järvinen (14):
  tcp: reorganize SYN ECN code
  tcp: fast path functions later
  tcp: AccECN core
  tcp: accecn: AccECN negotiation
  tcp: accecn: add AccECN rx byte counters
  tcp: accecn: AccECN needs to know delivered bytes
  tcp: allow embedding leftover into option padding
  tcp: sack option handling improvements
  tcp: accecn: AccECN option
  tcp: accecn: AccECN option send control
  tcp: accecn: AccECN option ceb/cep heuristic
  tcp: accecn: AccECN ACE field multi-wrap heuristic
  tcp: accecn: try to fit AccECN option with SACK
  tcp: try to avoid safer when ACKs are thinned

 include/linux/tcp.h        |  27 +-
 include/net/netns/ipv4.h   |   2 +
 include/net/tcp.h          | 198 +++++++++++--
 include/uapi/linux/tcp.h   |   7 +
 net/ipv4/syncookies.c      |   3 +
 net/ipv4/sysctl_net_ipv4.c |  19 ++
 net/ipv4/tcp.c             |  26 +-
 net/ipv4/tcp_input.c       | 591 +++++++++++++++++++++++++++++++++++--
 net/ipv4/tcp_ipv4.c        |   5 +-
 net/ipv4/tcp_minisocks.c   |  92 +++++-
 net/ipv4/tcp_output.c      | 302 +++++++++++++++++--
 net/ipv6/syncookies.c      |   1 +
 net/ipv6/tcp_ipv6.c        |   1 +
 13 files changed, 1178 insertions(+), 96 deletions(-)

-- 
2.34.1


