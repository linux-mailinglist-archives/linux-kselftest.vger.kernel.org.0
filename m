Return-Path: <linux-kselftest+bounces-42519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 417FABA5ADD
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 10:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F3E189FEB5
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 08:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FA92D47E8;
	Sat, 27 Sep 2025 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="kZ23pgg4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACDD283FFC;
	Sat, 27 Sep 2025 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758962895; cv=fail; b=HB8zfyjBEUh9MEJzNROwEUFFR/NOEjkHK9gEzsKxEtOMC7dIptattx291yK6G0Dv/whaGBSqqYgVMhoG9WWOO9u31vKOnnzhRfrXTrZEzRw9wvbTkyeETkOrkKsJ3AJeaRIAl0TOBpX667YV8q2r5AvUqR1acmyoH8d9HPy3Zqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758962895; c=relaxed/simple;
	bh=qStcHyBvBXwO9hPQVEWx5/+J+TJH+7/l3HuGAoj9rJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NUy6kcq9pJ6Zzq4rvyLjEY0ClxZYKrim4F6K391SaFHit7xUFwJ+8Dr0gUgcYUMvAXnb+tD0xlP0xRUlce1UiO5BPkxh40uBi2SM/k3GkQ1z7DPJWJcC0YzBlNBNLx6U5B9aj1S86pfzNeWgAzFa1yvYDGhY6rYkwhqpxO8xlGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=kZ23pgg4; arc=fail smtp.client-ip=52.101.69.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fd/DaP6SGNxaR7V5IFHBR+paYdhgzU7e7urXq5/sV5DaHHUj64PIuGJnHZ3r+RnxsA2vqiZ5YfFKeA+sDTqc7WoHwFbxkBLkg2O1U31gN2rucKhc3OMw3ElDHLqCeaT3iRYaxIpWoJRHYBwn9X7hp8179bn/Q4ARXrhIiRqpORpyE/IrSh8usymhmBClezS1hKBtwlLBdbu1GS+bRHf/Anii3rrADc8Epib6uIxZnDdx8JcJlwehphIyItYgcQgP2oIPYPXlAKa7jLvS1SEunyye3KvfandHc86NKYqt7JaCodpyWZH2l2Q3m4tmsa9/BHKH6n+ZHwJxSJryxt/NvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTDIPNJ1sg6g4WbILEKpBnbLcQfxJE9gKde/OTkSCfY=;
 b=NmbgMnvAvZXSYmyFoUVsXtf6sNrqLM4A2Fn+IiYOwrCu/MTExiKnJxYzwhvBE0BTywpSjIUWoff1k4vgeC+yJ5BL3LEZ/JdbfapRvb0ZPL9M89ARbH+g2cPNkL+NpWmEvKWvTlWg7XEAb4aPVouXcs5SI2N0FELD1474BZSm48WPTLVW3cZnPLTpQqnzFUZ7RohvZhS/W3+pXmDKYi+//Cp5+MUPC+HSPkK6gUxtZxp1tsdDF20zAr7RRXVT/9asgm5Y81ZZa5QkBWcuEKndLCUhBo8YPQY2rYHa+Fe6u/7HE5afYxWT5N+WfU9IvEHzmDmRY+d67rBxChG6WcRtig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTDIPNJ1sg6g4WbILEKpBnbLcQfxJE9gKde/OTkSCfY=;
 b=kZ23pgg4qhEWrTlIJiUxm5mR4u2slNU3ru/orTxrCPQ6YLBV121H8MYRLl3ucPczSpd4bBRlb30I9OtIXBiVbpbQLh+r3rfx1SjIosbhq/yNDK6XF9jzfq6ZLrBlFIZ+GB2aT801mF7rFYWpisEK/5dfWrFViGdFXbCLohbEW+LvMKALF/T/71WZIdx0mO8s6uRySlDnJoLRnW1W0noabvYyPybcmFSmAp6QNZtuwYhYyhqHYvcYkypYcTqM0kREOW72Hm/4Tyjm7sewEtkSkleodWaEEcFHbr/h87byac5iTCxeAy8KobURsVcdqIJwTyJj7hkANHrcEjWRCxAJTA==
Received: from DUZPR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::8) by AS5PR07MB10547.eurprd07.prod.outlook.com
 (2603:10a6:20b:6c9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Sat, 27 Sep
 2025 08:48:08 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::93) by DUZPR01CA0002.outlook.office365.com
 (2603:10a6:10:3c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.14 via Frontend Transport; Sat,
 27 Sep 2025 08:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Sat, 27 Sep 2025 08:48:07 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 907AE200D5;
	Sat, 27 Sep 2025 11:48:05 +0300 (EEST)
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
Subject: [PATCH v3 net-next 00/12] AccECN protocol case handling series
Date: Sat, 27 Sep 2025 10:47:51 +0200
Message-Id: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9D:EE_|AS5PR07MB10547:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f726e38-f190-44f4-9c0f-08ddfda29458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NklGcXNycE1GRTUxREFBODllR2NISFc2Y3JBQmppQ3hzdHhsaVErSUwybTRl?=
 =?utf-8?B?TnlsUGVrUHVxRjh4Wml4b0U0a3FZUlBwQk43NWw4U2JkZXpWYmdOdUY0NzEx?=
 =?utf-8?B?STdPYThsMTlhb0pqMXBIM0ptNjRJODc5eUI2RmJzRFZ2VkhqV3V6ZCs0UXl2?=
 =?utf-8?B?K1hMSDZQVTl6WlZJKzV5NDQ0NTB4ZGhXTmVObTNwSWk5R3Q1TXVqdjBxMHdy?=
 =?utf-8?B?VUZ1YVk3QlNIbjQ1c1dhenFlaTZ0aWhORzNzc0F0ZTdmUllPZ0FKNDYvbFgx?=
 =?utf-8?B?aHJENE9wb3lNVnpGZk13MHE5V0dMNisyNXliQmdWRFh4Vy85MGJ5MThaU2k2?=
 =?utf-8?B?MTB6OWdSQnNjQWgvYlk1dHkyWTdmUTBHaGxmNVNWMGRQVGNEVnE4VUJCeUJG?=
 =?utf-8?B?UkFjSDJYUExvcERIS3ZCa3V4cjVESksyNGhQY0FKbGZMRDIvYlBPckZJcldN?=
 =?utf-8?B?QmpYTGdhc3FWM0h2b2tjbFB2WW1wWWlhN3NDVmd5c0Y5OFAyeG1mYzFyNlNu?=
 =?utf-8?B?cEVmYjVMSVNqVjNid0RiWGpGbGU0b1BhbEdyVm1iWkR0a0VydkkrWkI0a3A4?=
 =?utf-8?B?MTBFUU4vYk50RkRDTjNKQjZmRHRMOWxQcFJWclAyL0dHdk1DNFNHUzZybEVF?=
 =?utf-8?B?R1dDT2pXRmRPeWR2ZG5WWUtYb2thYmNybEZsVmZpRGxGRGVBUSs3NFVHTHpk?=
 =?utf-8?B?SDFyZ2JVQ3QyczRNaHlSNjZoYXA4MXU5ZThpSTJKc044RzlKMzM5QmlRR1dG?=
 =?utf-8?B?YWJ3K3FNSFlqYWtOMXFLUHRpQlg4aTBHbUFKMXNmZEVFS3QzOURibS9vUE1z?=
 =?utf-8?B?NFNnK3FNdGpVU0MwYnA2bWpZNVpOOENuMHJsVlU4TXRIZHdra001OEt6MFJw?=
 =?utf-8?B?WFV0TENkRU5DUWFpa0IyME1xMVk3WkRuTHAzZFZlTlVQUkV4QTVKMXU2eGFC?=
 =?utf-8?B?U2cxMHNRTFFCZCtGR1p2VlVtWWQyRDlqb0dEOS9HQmp2QWo5dVYvc2tmOXB2?=
 =?utf-8?B?RHlZNVB0YjJZWVVCcVVoNkJhbU9DWkZrL0F0UlBGdjlTazZxdUZPTkNkMVVp?=
 =?utf-8?B?RGJKZ2h6a2NxeER6M3dNWGE1ajdEZXdQRE5EbDU5S1ZzMUhUcFd5Y240dWF0?=
 =?utf-8?B?b1NPOG5sQThwZUJ6aW9rUGNTZHVnN2d2VXNsbkRWbkZQdG5MaFlwbGlScm41?=
 =?utf-8?B?azBzWjlNazN1cFpzeGFHS1Z3RlNEZVZJbytuWlpWUHlQcTZ1Z1NhZlEwdHRN?=
 =?utf-8?B?Wi9KdG9WNDFUSGowZTdhaE9ncWlYUHZQNHB1NUpwcXlKdTBmZEZlbS9kVVEw?=
 =?utf-8?B?RHV6OG5qU3d4WUlYbklqZTBqK0c5TDI4RWpsb2FJcFNjUHdrMFMvZXRWM3hy?=
 =?utf-8?B?cHBXR1Y1OE1DZEM5QXVQYTYzcXZRQ2tqS0plektiOUowOTN3cjNQRmw5cWQy?=
 =?utf-8?B?SVJKYWphaTVYMmM4c2RHaWdOV1RMNFFoK040NEQ3dUxLOXRmOTVxYUFBZFFy?=
 =?utf-8?B?V2kwS0U2ektyS2NQOHB5anozVlNMWGFHN1I2RVM0N1JXM3Y0NFVIR2xyMmlh?=
 =?utf-8?B?VTg3YVVVRjNoZGJGd1E1YjgwanlkL3hZUjBvODIwQ2IwZExGekQ0b25STU1W?=
 =?utf-8?B?bDAzdlZpRUZZcWdCZi9NYTNzTDNDaXlqUGZDRWJ6VXpDQnJ3dHpoQVNBdms0?=
 =?utf-8?B?OGw1d3cxQkI2R0hZT25sMkEyd0RVK2xiVHp1TmNiemZ6U28xRldpcEE5TWU3?=
 =?utf-8?B?dC92TVlZOWtTckpCY29KUVNpYlhBdXpJaytwWFNUbWdQd2lZZnFiRVZqY2RX?=
 =?utf-8?B?ZG9iR09CdU1Wa1dvSTNrdUNWVTBJSjlNVTcxbWVUeTNwRGhiS0lvL0VYMmFY?=
 =?utf-8?B?am9lUDJ2ejRwWERzeGs0cjlaNzFoQjIxZEpKRHQ3SC9kYXBpNkhGNFhRZHh6?=
 =?utf-8?B?bjltQUJ3TCtMakJWRkpjTUdod2Qxd0k3VWJobHRPWGdlNHZjUjArSi8wT0h4?=
 =?utf-8?B?SnFZVy9XNVhqM3ZhUHd5bktWN0FPNjYyQzFmaExzS1RPTEZvUHlNVWs0RE5h?=
 =?utf-8?B?Z2ZvMjVCU0IzTkJub1UzZGJ4SDZuNHAwRjBYM2s2Z3kyV0Y5aE5ybzdXYWxK?=
 =?utf-8?Q?0g4LTq0haOXo99wx3Q3aWvXIK?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2025 08:48:07.1049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f726e38-f190-44f4-9c0f-08ddfda29458
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10547

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Plesae find the v2 AccECN case handling patch series, which covers
several excpetional case handling of Accurate ECN spec (RFC9768),
adds new identifiers to be used by CC modules, adds ecn_delta into
rate_sample, and keeps the ACE counter for computation, etc.

This patch series is part of the full AccECN patch series, which is available at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best regards,
Chia-Yu

---
v3:
- Add additional min() check if pkts_acked_ewma is not initialized in #1.
- Change TCP_CONG_WANTS_ECT_1 into individual flag add helper function INET_ECN_xmit_wants_ect_1() in #3.
- Add empty line between variable declarations and code in #4.
- Update commit message to fix old AccECN commits in #5.
- Remove unnecessary brackets in #10.
- Move patch #3 in v2 to a later Prague patch serise and remove patch #13 in v2.

---
Chia-Yu Chang (10):
  tcp: L4S ECT(1) identifier and NEEDS_ACCECN for CC modules
  tcp: disable RFC3168 fallback identifier for CC modules
  tcp: accecn: handle unexpected AccECN negotiation feedback
  tcp: accecn: retransmit downgraded SYN in AccECN negotiation
  tcp: move increment of num_retrans
  tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN
    SYN/ACK
  tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
  tcp: accecn: fallback outgoing half link to non-AccECN
  tcp: accecn: verify ACE counter in 1st ACK after AccECN negotiation
  tcp: accecn: enable AccECN

Ilpo Järvinen (2):
  tcp: try to avoid safer when ACKs are thinned
  gro: flushing when CWR is set negatively affects AccECN

 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 include/net/inet_ecn.h                        | 20 ++++-
 include/net/tcp.h                             | 32 ++++++-
 include/net/tcp_ecn.h                         | 90 +++++++++++++------
 net/ipv4/sysctl_net_ipv4.c                    |  2 +-
 net/ipv4/tcp.c                                |  2 +
 net/ipv4/tcp_cong.c                           | 10 ++-
 net/ipv4/tcp_input.c                          | 49 ++++++++--
 net/ipv4/tcp_minisocks.c                      | 40 ++++++---
 net/ipv4/tcp_offload.c                        |  3 +-
 net/ipv4/tcp_output.c                         | 35 +++++---
 12 files changed, 218 insertions(+), 67 deletions(-)

-- 
2.34.1


