Return-Path: <linux-kselftest+bounces-42948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E634ABCD169
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 15:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC77B4FD067
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 13:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B00B2EF651;
	Fri, 10 Oct 2025 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="uKh8jlHP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68F01F63FF;
	Fri, 10 Oct 2025 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102256; cv=fail; b=klrdrk66FDT/Ut3spPn5777UB6rDwelngCa6pF0baqdrwR4jJxabAcrS8uhoFKatI/5e8ZhaTwn+gQw5aaaM28uBKZQn9dxmBrI1ecSqcIqlWwgnuabJ95vdasUaZ6/T/tVrZDQYQk9weOHDzpO1ivQkgwlExQimvSeeHw0gDi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102256; c=relaxed/simple;
	bh=Hf8GkYzB+qqqOXrjlRNB/0v75XKReaiSXk1etCqppWs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=R2r2s+UxDbDLfyX26+MzW1My7CYQXa2plK0F/Dzd4A00mijhYNPn8bCQ5vVjE7xrDGGGPl+KG0hUUNEgcnSxJhsE6UpBi7TlqjWM28txQ/VSRFxanB7HotN5f+n8sCyt9mKnntB8rZO6CoqMDKyBUmhntcIMji1+GUW0FTgQ2zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=uKh8jlHP; arc=fail smtp.client-ip=52.101.70.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2as/EC0biERDkUPr7VlIbj45sVonlWVchRAy/b0jwTAtoMMSnkxkCg+ky2xSNcYOyiEKyZAz36iuzeT7FffcUfXHKe02ZaEhqqOLWHJVzFVLm1G0hN5m7TF9xlBlcQNGmbtIyYqbuXr1JxaBBREcF+czY/I91nKzUBIS1orA4bLi83At1iqC7KTbZxgKiZ7Zc88zHOtTy4QpuaBxhvmbt6L9JuBavVrU2x+aDLLXIBxXTtSzbXachGcA3JOTZvOQGe+Q0RPDsGa9VB48OnN2AC4prWYkwkKw+FUqdnyImRSsvZmD7IenyTStEZcJIoC+H67bhHz5Xu5GZy/7iyyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnaT0BrUbHRTlWXSxwNklBvMVknsnOUcj1S/6RwJ1e8=;
 b=qVQ+aSpmCHdb4RVdcfv6vdGOh8U4pn6tdE0V2yseCiG1l7THS4oR6pm5zGCVdxKV+2iVjOMTg7ksnylfNFefu64kOIXikozqS5eYHeR+3YDFRwTMgCNazq6RqrlHjnuY0YGF+6cydbW7PGpT1IkEzaZPNbsK+HmfLLQ62wFFX1fcFwvc1ARWeIyDXfOWF+JVxRndCEtUqN5qLTrV5uU7RCrWLiArkr0R9e/WG6skq8ATmiok48ivEb/Nf03HkD/L9MnR7G+xlYSEZxoy+dkD5nl1Cn3HZ5IlPTmYU2HoRYUipCG9Ooh/Hoq2GKIEloBopor6RKs4G9AHxORKgLhBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnaT0BrUbHRTlWXSxwNklBvMVknsnOUcj1S/6RwJ1e8=;
 b=uKh8jlHPNAkzd0wQfOUoFeGK0BINPRDuuQe2L+xh3UnyLQM8QanqLUrR08JP/CGEeChnlB+ganPZ1eAu7r1nGf9LBInafY9bhGMyIL7CqK4KYFBCqSLRF/llKB13p3WQR3UJOQNwDvbzTTRqGg9ToYeUhfZFTF8RXKzpFGVEI6rN+s0tfgqdcVbM1XVI82xk2ppQTNpT4v6jOp2eUQe5udGsmEftz3Yhc2LimDbZOY3kyf/vORqS79hW8uHnsH3S1udXftT5WkTnAJ+7rXLDy0Fw4oEg7v5y2IID4PE1Z98CFwkU7x5THXJZPkekaGPQxW57BcoP6wbiGPkfQ/SsJQ==
Received: from DB9PR02CA0017.eurprd02.prod.outlook.com (2603:10a6:10:1d9::22)
 by VI1PR07MB6223.eurprd07.prod.outlook.com (2603:10a6:800:137::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 13:17:31 +0000
Received: from DB1PEPF000509FE.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::80) by DB9PR02CA0017.outlook.office365.com
 (2603:10a6:10:1d9::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Fri,
 10 Oct 2025 13:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509FE.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Fri, 10 Oct 2025 13:17:31 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id B7ED61C005A;
	Fri, 10 Oct 2025 16:17:29 +0300 (EEST)
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
Subject: [PATCH v4 net-next 00/13] AccECN protocol case handling series
Date: Fri, 10 Oct 2025 15:17:14 +0200
Message-Id: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FE:EE_|VI1PR07MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee0d5e3-bb4a-403a-1c15-08de07ff5e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlFlTFU3UlloUDRML2JZS0plbmZBblZXdzRHbHNTaVlBYWdVSEk1cHBMakxF?=
 =?utf-8?B?cTU0NVhTaEJ5eDdHZjNaQXg3MGJUYW02VlpESjN2c01ocEpZTVZvQ2UrZno1?=
 =?utf-8?B?akNCR0JVRTZZbjJWbnJaZ0plVTdxYndKbnlLdjNXUFpzMGozZzIwcGJxVm5u?=
 =?utf-8?B?VTRYQU1tUjY3UUI0bFhEOU5CRCttYWpGLzVIZFZBZjU1ajNpa1g3Tjd0OUV0?=
 =?utf-8?B?b3lrUk5aKzVPUzNJSmZzcTZUTUE2dklmRDY5RmMxSXBwMkU2ZnJZVW5OSVNE?=
 =?utf-8?B?SmVXbGRqZFFNS3AwanZXUi9ROFZDSnVBMHBzMU1UVXJOR3h5VTNnakZ2cHo5?=
 =?utf-8?B?SWYwWFJSU3RYTUJ1OWpYcVB0N0FOY2d1aUY2bHNOVEVtZmxTNHIrUVJxNlc5?=
 =?utf-8?B?T3YxRnhacXJTR25NdDNyaUlKNmtINitFay80ZC84WjRrR1hEb3F2WU9GZHFX?=
 =?utf-8?B?Yk9KQWdCUm0rcWJ2Z0srb2daM2EzTWNFZWdRMmNINERaYmRuV3dlSGI2dkpv?=
 =?utf-8?B?Rnk2THRDS3NvUDJ5M1UrNURhV3RIOVcySW04MldWMTZGaUp6bFpwamxaZDA4?=
 =?utf-8?B?WnF6OXZocFhnTzN1SGNPci9wenF1WUMvODh4S0RwemFmM0pyOXdXbXpBYis2?=
 =?utf-8?B?Z01uM1I1b1lBR0hoam90dTZrRndWN1ppaGpydFdVNkZoWE5qUFp0TEFQOSta?=
 =?utf-8?B?RVZuWWFENU1KRkJtc3FvWGloaHFnaTAvZHdkdStWd2xlSFg4V2kvR1BoZFMy?=
 =?utf-8?B?OXh3Nlk4LzZVVFBqYUNRbzRUVUdQL1dHWGx5dGRNOUlRTGhXenJlaFBwSzhS?=
 =?utf-8?B?MTlZbWJTc2JDaXY1OXJZdm9mRmFWdk92eHFoeWYzNTlucGVtcnpIN3pKaVRi?=
 =?utf-8?B?bkpnRzM5bFhPenB6V2FzTTZIR2lRRHd0UHU2dkRvR0habmZuSFh5Nk42MWE5?=
 =?utf-8?B?cC9uMVZXUTkvQTIySnFkZkU0UUZZNDBLUXE4MW1HZmxlcnBHa0JBYTUwQTVY?=
 =?utf-8?B?YUMxK1M3YzRsUm9WUWg3Zy8xWlhWT1lXb29mNitzcHdzeXZnUElZQVV3TTdS?=
 =?utf-8?B?M0FGVzVxcERnTHlkZUIvSmhWNjlCdkhIRjRpQzd2dlczaWx1MTV6eHZNbjcr?=
 =?utf-8?B?NGMvYUZnOExUYURTdlVHcE1WbldKdFFwM0JCdFpWTlA1b29ETEVpeHlPbC91?=
 =?utf-8?B?RWo1M2d5NTJacE9VYkRRMVZDcTl0bVFWVmVlVXZQN1hnZmdxZ0Rzajk0V3RF?=
 =?utf-8?B?RWgzL3l2cm9VekVNUmh4M1lQVXJqNFl3RXhsc1N5TmxhVnZrNk01d0hxMitH?=
 =?utf-8?B?Z1dFNVpuR0NKRGovYmhqc3VneHc3TXBFMlNQajBjNDNSS0pIR0F5UjlORlNO?=
 =?utf-8?B?NGNRcHI4NXR5K3hWU3BCRDJNRURrMXNOU0w2WVhxUDhCeFl5Qmk1djZkNnM3?=
 =?utf-8?B?eVFadU1ab0ZCZUw3M2twTUM0Z3VFbWE4eUJvU0ZjK0dGVWs5TkFhQlRTNGwr?=
 =?utf-8?B?UHVHQnJpVmtyWGY2RmpaZ0kzQXJsUlJzNmkySXoxbEo3OFBxbzgyelR5cGVs?=
 =?utf-8?B?WXVRNzJlRjIyOUYvcHBFdVZIVWxWUjB6K2pjOXlnVTVoeUpCVWFhWHNMR2VN?=
 =?utf-8?B?Q1pMaGtmejdmaXpjMTFBQ2RwNG1IREZPMHZ1eDlyV1dUT21KQWdQcU0wLzRw?=
 =?utf-8?B?OFRTa1pjSDVIWDk5S3RnV0VRZWxoVVdEeHdpNndhSzNRTHRDamhTK2crSkRz?=
 =?utf-8?B?aERyeFU1em1MbGpoZHVsZnRpb3N0bXpTSTlKTkFhMHh3aTcza1ZvUFQ1aXli?=
 =?utf-8?B?SjVleXFYc2prajZpQng3T29QWmdFZlMvSjhlT3BJbXZDYWdxZ0RTMm1vZGtD?=
 =?utf-8?B?S3ZsYWtNdjVteVU4S3czTk5XSy9YTUlFdXFIRWE1VXNDcHdqUTRsUEV1ZHYz?=
 =?utf-8?B?SjhpY3hRZEZsTDlXdkhaeXFhRjk5MGtVb1dXNHJ6WDJwWmlHMTFoQU90REUx?=
 =?utf-8?B?OEpUVDFSUmUyNzFGbWpRMjhtZzBXTExzb2NMcGg1VTNwdXBsWU11Qzl4Qjl5?=
 =?utf-8?B?dGV5Mm1aUUlJQU5zZlJ4bkFNaVl6R1hBYWJLUFlMK0lrVElTd1RIclVYT0NZ?=
 =?utf-8?Q?5tn166IKSf6ALdUhUwDtLTiQr?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 13:17:31.2823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee0d5e3-bb4a-403a-1c15-08de07ff5e51
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6223

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Plesae find the v4 AccECN case handling patch series, which covers
several excpetional case handling of Accurate ECN spec (RFC9768),
adds new identifiers to be used by CC modules, adds ecn_delta into
rate_sample, and keeps the ACE counter for computation, etc.

This patch series is part of the full AccECN patch series, which is available at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best regards,
Chia-Yu

---
v4:
- Add previous #13 in v2 back after dicussion with the RFC author.
- Add TCP_ACCECN_OPTION_PERSIST to tcp_ecn_option sysctl to ignore AccECN fallback policy on sending AccECN option.

v3:
- Add additional min() check if pkts_acked_ewma is not initialized in #1.
- Change TCP_CONG_WANTS_ECT_1 into individual flag add helper function INET_ECN_xmit_wants_ect_1() in #3.
- Add empty line between variable declarations and code in #4.
- Update commit message to fix old AccECN commits in #5.
- Remove unnecessary brackets in #10.
- Move patch #3 in v2 to a later Prague patch serise and remove patch #13 in v2.

---
Chia-Yu Chang (11):
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
  tcp: accecn: detect loss ACK w/ AccECN option and add
    TCP_ACCECN_OPTION_PERSIST
  tcp: accecn: enable AccECN

Ilpo Järvinen (2):
  tcp: try to avoid safer when ACKs are thinned
  gro: flushing when CWR is set negatively affects AccECN

 Documentation/networking/ip-sysctl.rst        |  2 +
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  4 +-
 include/net/inet_ecn.h                        | 20 +++-
 include/net/tcp.h                             | 32 ++++++-
 include/net/tcp_ecn.h                         | 92 ++++++++++++++-----
 net/ipv4/sysctl_net_ipv4.c                    |  4 +-
 net/ipv4/tcp.c                                |  2 +
 net/ipv4/tcp_cong.c                           | 10 +-
 net/ipv4/tcp_input.c                          | 58 ++++++++++--
 net/ipv4/tcp_minisocks.c                      | 40 +++++---
 net/ipv4/tcp_offload.c                        |  3 +-
 net/ipv4/tcp_output.c                         | 42 ++++++---
 13 files changed, 240 insertions(+), 70 deletions(-)

-- 
2.34.1


