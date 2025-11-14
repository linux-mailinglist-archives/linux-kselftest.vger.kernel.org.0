Return-Path: <linux-kselftest+bounces-45612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46050C5BB46
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906CD3AC908
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 07:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198E42DEA83;
	Fri, 14 Nov 2025 07:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="LJH7SV/t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013052.outbound.protection.outlook.com [40.107.159.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE69D279903;
	Fri, 14 Nov 2025 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104439; cv=fail; b=faWcAU21jv07vfxdjaUiVczvTgW06nGZ4mIdUOc8mIax8cgqkQelJyDedH13y4qrsPbr3QLrOxFVtLW8jiq7k3fWcfDqXFqzUhxn/OfamXhqmo7fkoQczC4F7Vbxcx18Oml8phKTX8OEIZyhTMcfHzC3nR3K0pO1NxJXIp9eT1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104439; c=relaxed/simple;
	bh=+XTZxqrjZd6aZnCugJJyagCyDufPX31IXiH/lFpxX3w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=p4l4oXFrhwJvvG/cy6xLO6Du3lGK0bgJCGwQ9iw5h9BG9g1h+jR7ezsS4AaYB9mrD+c9U1sp/WFSliRurZWzzFxr4oJOjG+iN2SFSuLvCXBtUA6YiquqwA1aTTYI1sIEDcuy/OnzPhq3cWqJ1kXtAk8EFUCh1EV3tqqVXQojLsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=LJH7SV/t; arc=fail smtp.client-ip=40.107.159.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/M5+8Glr1CgFIwKWSEEDw8aDnnvJzcthh4JpbEbAwrFWL3iI9VoUMbJAR4G06Nf6D/KTWCdKUORt4wyIPqxBoYWpeUFove+r/lbLU/V24w+tFkkrbS1oZRLSY0jTef19VRru73eALFpX/LbcR/X9IEWhOxAI9Vomz+ZjywDqPLz5i7gCzBuZ2MsnHGahqx7ezhI3NjE8W+tMXlMykVCDVVZKupWqvkgXqoK9zHxxqv2czQ9obZMMDpnoWRCPUsvwBwtL5Cx410O/HNhlNkLp5ZW940lx470bs+CHq2bNkZx8i0HtTKejKEmdD9ICx+pO9YRrdP0EowlYSXMEiUFiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mws05I907CQIyAykjxmUn38vVbT/s8m++wIZg1NXR8k=;
 b=xLpsc0tBW0FvWnJDfZZf/GgYn0hwwsRu4X0Cm0TwBZkLsrJ8WNsRcxOWkS+jV7IqB9muQuz8PEp5saH8qwTMlG4byufmLOos9KbQFHXIQy3UbLP7vguDgbm7jQM02LDV3IYs2j0Np11ybrXq8Cf3XnXUi/iNzEJn3LRkpvk4/U508+7nP/s9UjkkOmyHs5ZsAsQbGtPtTbvShruMtU0J3okjMKwLTddnk2zEGvAnI2zu75CsvUbA5jF8w8HDZ8l3BHLnaqFSB+tFPleQT6oZg36O2DzpW1y/EMNQWWD522JUI746Dls1JaB4Zhb39Th23jTcniNKzVQ2NIIHuuDBcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mws05I907CQIyAykjxmUn38vVbT/s8m++wIZg1NXR8k=;
 b=LJH7SV/t1Mxfsd0pURrMSgYoYCzN34pExpGf0OLDXe/GFeA8QILW2kctDBZIrVX/H977XiLzLyGbAE+yfB9j6gI07u92Pj8HxcmNDisRGA+6ItR5r5jfM3wdVRoHC/Lagz1z0Ho8fxHOyC4FqVVWly51hZ3tqYKvk5SMGh6W9Zwb6jRPFtkk6bPelcywM1GY8HWod1s9lq8ZMPLOz13iicoZ2TOJnfivEVL5SSMqxj9Z8XoPj/TxMN/9bZ/Iwp22WWTNtRxEtMFE3GRkyNgAmsgoKk9YL9Rd42gfZ5Uir6vAECqhUBOx9ebhggnFR1GRB6qBHQgQYWRQM5eeG/KFiQ==
Received: from AM9P192CA0012.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::17)
 by AM7PR07MB6641.eurprd07.prod.outlook.com (2603:10a6:20b:1ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Fri, 14 Nov
 2025 07:13:51 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:20b:21d:cafe::ce) by AM9P192CA0012.outlook.office365.com
 (2603:10a6:20b:21d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 07:13:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.13
 via Frontend Transport; Fri, 14 Nov 2025 07:13:50 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 065E51C002B;
	Fri, 14 Nov 2025 09:13:48 +0200 (EET)
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
Subject: [PATCH v6 net-next 00/14] AccECN protocol case handling series
Date: Fri, 14 Nov 2025 08:13:31 +0100
Message-Id: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B7:EE_|AM7PR07MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9f6003-0a94-443b-881e-08de234d5ca9
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NGZuazBWTEpHbDUrVTAwcGFvMVg3UDBZa0U5WW42TVc2SFR0MGpSOU05cDFu?=
 =?utf-8?B?Q1RvbjFKMFpIeFdtQnQ2YzNpdU5qZVdwSHFKS20zK004Y1k2RzdaN1M0RVkw?=
 =?utf-8?B?TC9sTFQzdnFYeUxqSjNIVCt4bVBENE5yUkIyQ1dGaDBJNGd4ZHRUdHE2T2g1?=
 =?utf-8?B?QmZWMGVJTk5qTEhSMWowMURuZ2ZTMHJyMG1BV3pkazh1aHZITmVOa1g1WjUw?=
 =?utf-8?B?KzlOUEJLemhweGRCZTF6eTl2MC82YkF3c1pjUm9rclpGdHh6MFcrSHNpZUV2?=
 =?utf-8?B?bzB6UnhucjNZb3AzaTJ3WGFRUFZ5YnFUbVNmcXIzTnk1QjVlMW84bzRKeFE4?=
 =?utf-8?B?aExTWmVlOG5DcWZMbnRyT0l6TDNUSklOVUptMldWcW01ME1wWGVST3QzVWli?=
 =?utf-8?B?TFBOa3RWbDNFVjlKTCtjblVwc1BDV2pBLzV6Q3VzTG5JbmVOaUxBZExvK202?=
 =?utf-8?B?YXJQak1KMHVpSVRvUXFGVXk0QUc0SEk5MDVmK21UV1dia2sxcDY3VzJaV0Fk?=
 =?utf-8?B?Y1YycXM2SnMwRDFEMytMNVFuM2RRNkpXeFR3YWxQUVM4K2kzayt0ZU96ZUhS?=
 =?utf-8?B?cHRUbTkwR2l2WDZiSC9nTldBUGlhYThVMXNJZ254OUxTQzBxTndQeVgzVzdq?=
 =?utf-8?B?K1M4dWZ6Qm9BSkVNMlNvRlBmVVlJQnk0ZGNLWGw3WW4vdHM5ZDFBOXZvMytF?=
 =?utf-8?B?TmVLWFdVd0RjbXlkK0NBQzliank1bUNiVG5jNytoWGFQa2paY0gwZVRCdm9a?=
 =?utf-8?B?eDI3dFRWandVelhFMW5KSVVqVGo4d0RDV01WeWZ0MXZ2OVZaSy9Ua1E0bTBR?=
 =?utf-8?B?T0w4N3dMUis4SlpHcnF0czN3VkNWQlRjeTVYckNDeUtRVFR3QXhCU2p6YVpR?=
 =?utf-8?B?eFMwTVhGWU9IanplZVpKN3lHMk55ZTFIb3g1TXRQRGRteW91ZDBndDA0dU9C?=
 =?utf-8?B?aVcwdElRRVBjc1RMTkpMdUlxM0JwdFZ0UDl5NDNWY1NpRzlhSmdhYmZMK1l6?=
 =?utf-8?B?czJXT3R4S2F3SFU1Z2UyZTJZVHM2UnE0ZXY3ejQreHdjYlNtME1QUUluTGRB?=
 =?utf-8?B?Q2IxWSt4dFArNk5TTDFESFhLYWpQajlveVJES3VKWHl5WnpKb1R3MWh0YndV?=
 =?utf-8?B?dklVM2EzWXNjWWpHaStwMlQveUc5SlRqeG1iTUQ2c0N5cU9HWjM4UDk4NFlS?=
 =?utf-8?B?NUloZlJyYzR4T1d4VE92NUl4WVo3Vm8rN2ExVmFWS0N4K0tLMlF1UWR4RThG?=
 =?utf-8?B?VTlRVGhsd1NiS3Y4OVpUaTJucW01Wm5YdXBmQTVuM0dvYWlBUUdSSmtLbWFU?=
 =?utf-8?B?ZTVKWXJMU0FRSDZZQ3pGYUZ0YjQ5T0YrdCtPQmdZRnJ3NjQ1bGV0WnpkbWor?=
 =?utf-8?B?d0hxd0JwTGRtYXV2WW4xYm8vQkN6WEFNL0l3Vmd5ZXFvY0pkWnlKdHlJOHdu?=
 =?utf-8?B?TTZLTytVWk5rbFRzK2oyN1pFc3JWdktNNDdoQkZJUi9ZaUozZTYrcloyMjVO?=
 =?utf-8?B?VUJuQm03bGdoZ0hpUGJGQ2VLMHB6ZUxldVV6NTJUV3RaalBWd2ZhVmhsMWdJ?=
 =?utf-8?B?Tnk0NDFyOTJuZWZqdW83ckN0K3Z1dUhUT0FjQWtoc3hVOS9GNG5IbzhwOTJW?=
 =?utf-8?B?QjhCYjBTdkwyY3ppckd0SWxUdVZkenJxcE9ld1I5TFlVRFVwOUw2aWg1Tjc0?=
 =?utf-8?B?SUFZbCsvRkFPazhJTnJmZ0QxM2NmdWhLNzEwOTF0clBjblB1QXBFZGpDdGk2?=
 =?utf-8?B?S1VPbG0zeG5QczVHQk9UVU9uZjkxVi8yYnVOK2JURjdmcG9PTWJ4REhnZUlz?=
 =?utf-8?B?RUlKK1hqTHdYYjg3OHdzVmVWbmhqTGlvb0k0VHJGTWIzRFFoOUdPb2tTWC9n?=
 =?utf-8?B?S2t1RURWd2JobzMyS0J0ZTlNZW9OWisrOHdiTm9yUmJCU1ZpSUFyZ1VpZ21N?=
 =?utf-8?B?a0tXMUNkSlcvM0Z2czk4d05QcWxIcGNCQlFDdFdIUXYxSlcrUjdacHNMRDlO?=
 =?utf-8?B?bkF5aDBIRjR4VENzTWt6TklkckpFdEJKaXR5ajNCVnp1enBvam0vY0RYYnJ6?=
 =?utf-8?B?VjZPQXZvN1RpRnZsMnpaQjBIMHBSTWVVYjZJUUd1bWhQdndnMitHdjk5QXJs?=
 =?utf-8?Q?/f0KOaXNxvZquFVCkZWKM1PcE?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:13:50.6562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9f6003-0a94-443b-881e-08de234d5ca9
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6641

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
Chia-Yu Chang (12):
  net: update commnets for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
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
 include/linux/skbuff.h                        | 14 ++-
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
 tools/testing/selftests/net/gro.c             | 80 +++++++++++-----
 17 files changed, 295 insertions(+), 88 deletions(-)

-- 
2.34.1


