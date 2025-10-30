Return-Path: <linux-kselftest+bounces-44402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ACBC20A11
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 052034EBE6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FC926E6F5;
	Thu, 30 Oct 2025 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="krTQm+gK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013059.outbound.protection.outlook.com [52.101.83.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E376426A1D9;
	Thu, 30 Oct 2025 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834884; cv=fail; b=XB9EW9v3tUio1OCqBXRzBmkMqUADSYFx6WqQ5E0kf/Is3naRWf6rGbcAvP8iPJgqvxTZxd1GA9KZlWwhC2ki8N7pFixkkvtkPXj69uL3VJmPab+7mOeIm8D4rrjpk9/8VzPTFiPs6euB2WENf1pCXZxnPLKeuEcrqas2FXPoN2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834884; c=relaxed/simple;
	bh=dQEGJx1YNjzC3HboCIvJG36beTOioQfq2xP4TV1Cf74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AU4Dye5e0LlxpNHI5KNIOBaBwt4Ozzs2Z54/1ROjJy5dORE1giCIBwQwkyOsMhJ1fRkg/qsYYpFxwzJy0cdyuhHV96/3azi7mlXSgO64wl96zYNCI87J6zhBTn1LsjXDTjZ57lTsomNpLToCexHUeL0yuini9F9+LZwceoMqQ+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=krTQm+gK; arc=fail smtp.client-ip=52.101.83.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1AI59BJh8GmQrHHAQq8txyQfcM7qZzAoPZ6v47mP/ZH3nPV/m5UTL7nSkAgXakznFxZi596o0RKEBXRYx7h39m3ZlACFMSsKGVPRTo7RO+UtCXQ015rMw5VbOgWot94jimWCaNe1wMYchqturZZ0bYcJSn7X1XI6/qhUt5IBp7hI3F9+s0DnxtA2wI56/nzq9sZ0maAeRD2a3RMHKXPszy2CLJwvecqa8tTxSPxPz0UXSyQQaL4CDsPPWZvAz1iso0Lh0cNcIe3ywbhmLjug01pl74rKDxzRKOPG701I/D1NJn5w2plFePUzUKPm6LrsI/ZjOmRTpN1xo8Vleg2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tp2be4a5WkOLwFsSD3QmajURfl8JuW25p006R9FsJuw=;
 b=hG1Dk/2+zqxyC9OMZVl60OXIXMa6YRlpXoU9aKoNumDYP9awzFUcnC0cZhKapxy+Y3WS3xZlSk9EzfHR3C2Wa00jjBN6GReCixYsr1lnge/L2Wm73P2iUmIECPbRBh+NYBHs6pWNfVD0FN9Cqq1TGQIxzTajCJA2fSTzkWgM868SyK/3DR6DmUUqOl3Kj0kRmY6MdduVE3RTiYJhNeLb+WBiw/Qu6z3HDeFPqdCbGniGlMmNqeQlKPsdQVJLdJA8opagrDaiOya1NbYuLPG060qz0VXjV1wGuPm6EfPGkJWR/yAqa8/PHAb6/1+uVKMWvEGDGcoviIpZlXJe0OCeYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tp2be4a5WkOLwFsSD3QmajURfl8JuW25p006R9FsJuw=;
 b=krTQm+gKp1ePkJ3iBqiiWJSuLZBW/hZquPXwrkR1134WQoRgIhjqg29QxkeDYqcZdsegH8rcQYD+cHg5tQwYZdxGnm4+T3KtbO9widb+s0E7nP//7A9/89OFtyD5SIClycTgmtfppW6YeeNFAKbeJSlgp/TIN1yodHvlDPPkVBWH0T6vxJ2h468hVGazuR+NoHCpZycE5w9WNN9OObEzczTtbfug1IYBkdD6QRAdOileq0a/aK1wM2VNuF0qNcyydE0bYQo67wLnbHEDanWKI7iMS4GCmQziAOFu8s3+QyxPEyaXtsTHP1dBJntmDmg/1YKFEoOBsZr5OwV5orj4+A==
Received: from AM0PR06CA0132.eurprd06.prod.outlook.com (2603:10a6:208:ab::37)
 by AM8PR07MB7555.eurprd07.prod.outlook.com (2603:10a6:20b:24d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 14:34:38 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:208:ab:cafe::d1) by AM0PR06CA0132.outlook.office365.com
 (2603:10a6:208:ab::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 14:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Thu, 30 Oct 2025 14:34:38 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id AD5D420123;
	Thu, 30 Oct 2025 16:34:36 +0200 (EET)
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
Date: Thu, 30 Oct 2025 15:34:21 +0100
Message-Id: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|AM8PR07MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e60a12d-010b-4d8f-b56f-08de17c17473
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SkE5Q3VMYXJnSThCQVVFbWlZRWZmT1N5MmQ5bVRHQkcyVXpFZEFYN1Z1Q2Ew?=
 =?utf-8?B?Vm1KbU5QZTN5ajF3dThmK3duUnFrWno5WkxLaDFlYU9WcFZubWx2WnJUMnl0?=
 =?utf-8?B?ekg3UXJZQXNDakVLeWk5bVQ3eTFXdjFlUkQ0cy82eGJHN0hxdDZ2Nm5hUnpt?=
 =?utf-8?B?RFloRGlMM1B5eDhoMzlIelBmR09qK2kyU1NCTE95MnJkK0ZYMms0Z21zZWR6?=
 =?utf-8?B?eDlUYlVhbVNCY21UdkFSYXpTcU5sQlBvSTZ3dDBuRVk1NTVDVjRaUWF4WkhS?=
 =?utf-8?B?UHNwSnRFRXo1MDJWYWN2NVlocnRNOXdRTnpUWklaWTNFL1ZTVExRaFVoRm5V?=
 =?utf-8?B?R3c2MWh0MDYyOW1wYlI5ZlZPMDNUc0FVaWZ1enBLSUExd2NQeHdWLzNpZjNR?=
 =?utf-8?B?ZEJQSE1jWGRiWnpORzIyWW1BYzgxckpJY2h6a09qQzIyYjlJVG92KzhwSkEz?=
 =?utf-8?B?dmZ0YXllcHVTbFFpTTdrb1JtbnFOci9OU0dpSGI3Q29PSCtoVkQrRmpraGNR?=
 =?utf-8?B?OFgzOWNJbHo3UStIcjZRYjBTbmNmWDBCRVlEbndvK0owNExqd2ZqVWRBdldz?=
 =?utf-8?B?aUlpYmpORTdIZTZteDRBVDB1NUxJTDRXVDExb0tCNmRic214V2U2dG9QVkJP?=
 =?utf-8?B?VkhOK1RwMkhwQWNlMDI4cXJmVUlQUU9CRG9CQzBveHlOazhSMjNGQ0VkcWh0?=
 =?utf-8?B?dTVmUUpTMzdnYUN4V2hRNjQxTlhYWE5zYzFCdDBDNytQbjdISmNCaG5yV2Yz?=
 =?utf-8?B?TGsyYjk5NllTdlZRNEtPaFlDNlJaaEg3S0k1WE1Vc0VEcjVaY053WmpLVWlu?=
 =?utf-8?B?RGRVeXIvL05lTGRPSkhGMzY1OU02Tm1vNWhlSjdBTTEwMVcrc0FHd0JTVUVh?=
 =?utf-8?B?N1BiQy8zRTdtTmpWd2tjeUlndGViRVdvWUFDVFNRU01TbGpLaGtLU0Ivckpn?=
 =?utf-8?B?T1J6VmRqTVhsdzhCWk43Rjh2ZTF4QUhZcUNyWExBZkJ4TUlqRHdrR2h5THZ5?=
 =?utf-8?B?QjhlejhEbEVJWFhRcW5uMk9MaWdRdTNTVTlUSjNpcCtIM1ZGd2ZmbXVtd2xL?=
 =?utf-8?B?VVRodkJzNDZ6MnRFZnk5bm1xSG9UUlJTbDJCRncyNmtLVk05SlRlYmRVTWdN?=
 =?utf-8?B?aFJ4Z2RtcjBTWVcxK04zeDJacXNna3A0dmRkRmprZFZmNjd2Mm9BOVZGanR4?=
 =?utf-8?B?cEpLTnU3U045SUxDM0gyZ0oxQUVPcUUrdk9LVFVoZ0N3NW9ReUs1dWd6VHc5?=
 =?utf-8?B?Y1YwMXptYm5nVFMrbW1nVllwOHdwa2k1VGtLWVU5SE1TWkp4b2xSS1ZhK0N6?=
 =?utf-8?B?TTNkOUcyRVY1aHRIaWozbXNBc1hBV1hhNHRSakFMY09MVW9uT0FhSzl4KzZC?=
 =?utf-8?B?MUwwc1g1Mjlqa2xKdUkvRjZWV2tKV2VCOWpYakZLbTc4RHhJa2lIWE9leVlu?=
 =?utf-8?B?b1dPTVpNTjY1NTU0dDNuSmVDbk41MXBXMWh5UHlFb3lPU0pueG9uOGZBNkZX?=
 =?utf-8?B?R0R3YU1PMWw1bWEzdXlQS3hHS0Yyem9DVHc2VVJNQ24rSTZQa2pDRWd1ZFJP?=
 =?utf-8?B?RUQySnlnL1dMbmdVdkJnNjRhQU5qVnhhMWt6VVdoRmhvdjNhVGRQYStKMUtT?=
 =?utf-8?B?QXYyVUhpMGZnelVUQVh6a1MxQmF0QndqT0RYdHJoMW1BL2Ura3Azdmdsd2pX?=
 =?utf-8?B?MFlaUTk0RGc2MVlIaUVmcVAzdWtBL3hQc2RnVGdKNldycU5ZYlBRdzFIR0FO?=
 =?utf-8?B?aDZxVXpvZnd2d1lJMjB1QnRVTmxIVzhRaGZTdU9MTTVkMVVLRzNQdUNWVGl4?=
 =?utf-8?B?WUxQcUwrRkxsMjlmRVlTMURJOXJQaEIyMWR4dzRpaitTWGwwMU9lend4UkpM?=
 =?utf-8?B?clcrRlJYU1JJREJmWWZZVlNqeWZOOHR3eG1wRUN2a1FRQjZrenBRM0pKbCtT?=
 =?utf-8?B?TFBaMlNNUFdDbWs5RGZINS8vQXNNTXF2Ly9Sb09oVTZpN3VyV0xpSjhFeVh3?=
 =?utf-8?B?MVRVMjR5V29mSmlWb1ZKVGoyQ0tjZVROVmhMOG05UmxIOFVPTXpYNlBUQmRF?=
 =?utf-8?B?V29aYm8zbHU0ZC9tSmo2T3lKb0ZadHREVTBENkVyNzFlNzhKYTQ3dldzTlla?=
 =?utf-8?Q?RxT+gSr3noVGHJbjYWsxNGy5k?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:34:38.2385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e60a12d-010b-4d8f-b56f-08de17c17473
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7555

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


