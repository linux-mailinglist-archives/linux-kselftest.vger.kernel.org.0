Return-Path: <linux-kselftest+bounces-43007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F008BD5626
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 19:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88A33E6A71
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 17:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752F12C027D;
	Mon, 13 Oct 2025 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ZkVtfH+C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD315A85A;
	Mon, 13 Oct 2025 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375030; cv=fail; b=tpsPcEZo0nW8HimJad8aMa0b4EiNWJ6ElQtZUjUDqO650hmZN0lVmpurc3GJJuxJhHfLyGnTgtMIk1xqbYZNgx7///nJH4VgyAj/YkPw1wgMHNbdeO6oEmg9295I1o6EgwwmxqZRIwtCJQMbHMKLx6KgNif/gEQdDY1YoCpB5ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375030; c=relaxed/simple;
	bh=D1IrH9KpzphbSN5fWPcw49XGbXy5/FqQCZJYNSMlge8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Tjpreg6/5OL8T7Dog+kvH4hpa0CSskP6BdodN8d4nkJ0dmrpas/IJuRw4aYHXvaNEqtEpM2v0s0XILsCJ73zuU/dWxs0gHyj4tO+6eqCxC3DQ0jP49HEEtxaopMbFrot3qeFVBkAy6Cf7MwsQ1LBx4DOV2hw3fTT+OYwyrc+mtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ZkVtfH+C; arc=fail smtp.client-ip=52.101.65.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbP+i/vM1qoSqlWYIkCyR03pm7vKa3Pg51UiyJL6kzU7qKV5F/DRFnkEkUGhsmQpztVRhl2WLomw32ZzP6Xb64GzS9WPizxn6XbR8FfnCG/zSj3o0GbdIFPMVQ13GWT+EZlcXCHV0vV3y7DrUG9RARZ9SYP9+QE48d/EoLIffI4sS5c2KUHmMgXb5RcCgAiIMGcpuABEj6Rx5SIHuA0xmowmaK0kwL9XobfNnMtIOl0dngdcghIX7+oIn0+yXWC1V1EU6i0qXV5g/0OUsQH193gZ31k4gAEiq1iJb+yAZNNOPub0KJ8eOLTnQnbhAdZswC/oYpSSp3DJcKLFcgtZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imjkC5sOEtxYDNgu1yiuaWdzr802PT2vLYZ0tP33hmY=;
 b=C05lyxboB5BtfdiJtCLfjEX/I+zoKonO1lz7v8jwksWEWBNwYL2yNeQptX0aZtSgVAr2rW+rI/RDi6almoG2+3q/QR7yA5enKqa+pKqQSs2RmfBVzCLjQSIKjveEYmoShqrF5f7vIsI0ZYS6gLQQ/OyKavrSjXg5m44WEDHE/f2+RsOoXIb7Gwt7MNsqmuabgEcXgpYQ5IBXK/uPUCIU4QmBkS4jb+OP3+gLFh35SCAMzhIbwWzMUC17+kAWwzlQPzQ6tzG12COUyRtKbR/kTmR90dPc//MLFNH61GpWsnbIm/7UGXpv3cq34YK8J8b7xKH77bBg72BIpt96isG5NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imjkC5sOEtxYDNgu1yiuaWdzr802PT2vLYZ0tP33hmY=;
 b=ZkVtfH+CB/B3voH2rMqA1ULHXk37kw9wRPttFWdKzUkfqC7qa7mzATPKMfznAJolnPlcHV65D0epWXscULPRbKaLsz/niXUaeWpjfOZDT+UzvVWemJVghsL7ME9GruWoy60Z0cTIddyz4E7gN/kN0CNm4/322GEbfI2uCcY7JoTzra8XUPjfjpZgYhGbQLN9GVpbWZwKWr6sYNnieZl9CpQFZOLLabbh0CllVDG6Lb2mH2NYY8ehvo1u83FE2Q+7Cp5CRWX6Q6lNIJDQbMKmXBqYaBRYX40BBX1YuT9O8vVVDT267NldzZ9G+wV1nUdfoKAFgrdAZiMOZAtk9Zhclw==
Received: from DU2PR04CA0040.eurprd04.prod.outlook.com (2603:10a6:10:234::15)
 by AMBPR07MB11342.eurprd07.prod.outlook.com (2603:10a6:20b:738::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 17:03:42 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:234:cafe::55) by DU2PR04CA0040.outlook.office365.com
 (2603:10a6:10:234::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 17:03:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7 via
 Frontend Transport; Mon, 13 Oct 2025 17:03:42 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 0BF441C0010;
	Mon, 13 Oct 2025 20:03:41 +0300 (EEST)
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
Date: Mon, 13 Oct 2025 19:03:18 +0200
Message-Id: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|AMBPR07MB11342:EE_
X-MS-Office365-Filtering-Correlation-Id: 96958c6a-224a-466d-7c50-08de0a7a76bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVgrTG81Q3FyUVVkajUvV0VmRjlJWStwTHgzUm5sVDEvTTlRck9wMW1BNVFw?=
 =?utf-8?B?MnQ3TnZmd1owZVA2WGNlNTl4NVJ6bWVhbHMzak42UWRRUnBITTl6SVVVcnI3?=
 =?utf-8?B?MXE2M1Z6cXVzTTZCRDVib0ZyRnVVbWRUYkt2ZEdzRmpEYnIvWkNxWEZHdW5T?=
 =?utf-8?B?WllrZ1l1VExIa3U5ZXNyblA1TmpFT0JiRVdEckx2TGpXZ1VzWFJZelA0UHJU?=
 =?utf-8?B?SEc0QWN5MDFmYWVjb3BQZm5maXVJdlFjbzlqQzFGVFBVZWYyQzJzekFLWnU3?=
 =?utf-8?B?YTJtRGFzdGZOUVpLZFZyZnROU3Budmx1UjJUZEd0dVpCWkMyOGdDcmc4SXVZ?=
 =?utf-8?B?WG5NSlAvcTFLV21lTXdXbUhBb1R0SVNqTVU5bVZQVnh1Q28wOXdKLyt3VXJl?=
 =?utf-8?B?bmwwWUV0bjRmemdyb1htVThPTmpZaG02L2c1RUhoeUNwckVhY05tYmZhM3Vy?=
 =?utf-8?B?UDhUbm4zY2ljckcvN1l1RmtUNnhwSXZZdUJFcDJKblFsWVhIb3ZyTGtMZDA2?=
 =?utf-8?B?YmltYXFEOVlrWUUvbW8xcysrYnFwUDlXMTZUVk0xS3Jpb2lpT0duaW5CTnB6?=
 =?utf-8?B?YmRRQ0FDdWJEK1NkUjFhMGo1TSsxQWViMFl1Qkhtam9SS1dIY3c1bVV4QTBx?=
 =?utf-8?B?b2ZCcFlKWjhLOGNsc0hDVlUxNFY3bnJoVk1icHRIalNPRnhGZy9PdUl2MVhO?=
 =?utf-8?B?Uyt1cU1qWGZjYnNqODBKZ096eVRDL3M4RGVpbktqRUJ6TG54Z1N1VWt4NFZP?=
 =?utf-8?B?a3VVSEFCNVpiM0pRYitUckhMUDVGT2dBeVJEak9PZ25MUGh1RUwwL2VDRUJ4?=
 =?utf-8?B?Q3NGZytpTUhldnhwLy84dG1rMXRUTDU3Znk1YjVkQk9ZN1orblUxdEVYUFhj?=
 =?utf-8?B?dXU2a1dod1lhWHRIRE1wYUJ0VXIzeHpRV2djbmVGQlZ6WlgyQ1JCQnlvREJt?=
 =?utf-8?B?Z0lwTXh5WmgvanUyMFZOdHJ2ekhsQXlkWnVwM1UvNDNnand3NU9zNEV6am5t?=
 =?utf-8?B?NUdJV1htUW1xU1FUTEt1YnptaUZ0cmxENEVWMUs3TUdIRHpWUmZteUwyTTBv?=
 =?utf-8?B?RlFvb3M1NTV2eVErWDFtRUY4RHg3cHppeVU2WlQvR0FxNmdyb2RTNjZmNjlq?=
 =?utf-8?B?QjhIc0tMdGM5KzBKM1FvbFpkcTUwUDBhbFFnRkNGZWVBVXpVYld6emxXN0k2?=
 =?utf-8?B?N2ZjdG4yR1BURkdMTURTNGNJb29QaWEzRUhZRGhGNzExUlVQL3phcnlEU2Qx?=
 =?utf-8?B?V0h1YmU0d1V6K0xhMEpWNFM2T1V6OGw3aFdUdThoNm9keHl0TlZlMklsM3pH?=
 =?utf-8?B?WmxWZFBoZnY3djFZenZIQUwzYWpPcm1PM0w1SlhRYmZnNDZtUXpiTnl4cjB0?=
 =?utf-8?B?azd4MzVKclhKbXROZHN1V01JYlJ3S2UvQklLM0xuWXFpalo4WkRnUS9kWlgw?=
 =?utf-8?B?T2NuN3hjTk9VV0dwdWhkMGxaUVBpdzlPck1lQVJNcElBUjN6VTBGZktGRlpj?=
 =?utf-8?B?OEloSngxaDZTb05sbnVRSldLMnRhWHFqaEtIVis4ZVAvSlB6NHloT3lnektJ?=
 =?utf-8?B?WGRRajVrUUVmZHREQW9hSzZUaUswV2dYUU5vWTllM3NJaWZOMjZjVVEyRWxq?=
 =?utf-8?B?NkJBd2E2REV3Vnl3OVpsZGVjRmZJWmRjbUZNeXFMRFEvOCtZYlVZY1I4S3d0?=
 =?utf-8?B?MEg3ZHFGVEpBYm8vSHNldkZhZUYzV01SckxCRnVzTGZRdXgyMkM1UnRLckM2?=
 =?utf-8?B?RjVVcmllS2ZmYjRFS2plTkdLSm1YUWlXM3R4TE10M3ZDZGpYWTRUc04xbHJ3?=
 =?utf-8?B?UDlzUmpwMS9QRWtQbzdqaTNxZyt3ZStwU3dMVEN2MVl0eU9ObVpJT0FvNDlO?=
 =?utf-8?B?VWxOdkR2eEljaFJleUJ3ZDRhcFhib2h1eHVjNW5SUFQ4YXplaVRZMFcrbjdo?=
 =?utf-8?B?cVlGZWkySGRXQmtRTzYrWFIvMGc1ZzR6NWFuaHpkZ3hQczhNcUZCVnBTRVJU?=
 =?utf-8?B?cDlmSFFxN1V3VU1Mb3hqblhJUEhhcnlNbncxL3JyRE1laHVvRU85R3J0bUhn?=
 =?utf-8?B?NE1qNmhQMVlGWjlCSVZ4dUFvSWUyWFNRbFVWandwNHBLeUY3K3NMMnZKa1c3?=
 =?utf-8?Q?tsCF8ZAv+zWz9+lTJLxBYUnis?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:03:42.6727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96958c6a-224a-466d-7c50-08de0a7a76bc
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB11342

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

 Documentation/networking/ip-sysctl.rst        |  4 +-
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
 13 files changed, 241 insertions(+), 71 deletions(-)

-- 
2.34.1


