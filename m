Return-Path: <linux-kselftest+bounces-31351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8593A976A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 22:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277713BD7F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 20:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C06293B75;
	Tue, 22 Apr 2025 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ee9HTLJS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18571EB5C2;
	Tue, 22 Apr 2025 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745352977; cv=fail; b=ZnH0EFxDSIeFxNOLIpIaKl2snravpab3d94w0BJwLlcn4DbB+veQesKy17krYx3NNqJUou/V2lgeKAWz/33/svyHDRAycpRfNESgOQ9HOTLx+auXGAGU+782I4LcEXsKVB6x6nrrFAcZxxYRUShHJ770eLNEGY616hb/+VmFo7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745352977; c=relaxed/simple;
	bh=3/b7mFHORH+CDuUqRnMdAoMQjXJqtepK2ei3527Y6Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lLe1aGjZiGr/z/W7yGT/F/mBGgHquQ+mQ6/7po5AeQTUtAOniS4o9+juUUZbBmpZZAIakqX6lmQOsSdFsd0n5q6Vl82D6qjkTQVUylQftb+ZPwCpdgMw2LI/HOiNtbferXXIfk+bxIdXadYnzwEz88hErh7vRn8xOLbvizrEfEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ee9HTLJS; arc=fail smtp.client-ip=40.107.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnaVFfWF9W8pnzv8bSoMxSj0Fh+5wZMql46HgSlO63/pxaUcmPcRmC0OjSWmfC5VF1pOvIhpCEicZq4LggeUH6HJta5RluB/a2fOujQCpxOPWfgkAW189CUgJr3Bl1+xO+NpWe0EMqmHI9WSAThLqi27c60U2YiGw4Kuih8bawgVrfjnrSUPtxO6IOquI3gFq2AMaGnIhI9PVI2hHFD+2GG/Z/iPqkIHq3ZrYhy6nGl3W0EIR5150l+4XoZBapvtduOPyz4CNGOuYkrA0o75a6eKTXXTE0Gi328bR4+En3M2Y9G/+hw5anjvZ5iscPaC8hEAYo6hg9LtdisC2QdKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ci6mDdsfuKmplU8229xsQtKhr0SfE3NaHERiXsq+t8=;
 b=cmDOoOKBl00ES2oGa+WPBcW6muy6mdT3f6MBvQWesBMEusgAkTLmMwMgvONjA5qfYV8mFwQU+gCXHEnrwvQQZWvq28eCNG6DnA42DfZHdmyMKaUoLNyvYPg3qvMHOfCI3JVtJKOUxMR/sYKxZc11atdt+z5w9Jcg3bpwahMvn72Xt2i8KcTrJVi4vOcwqQ9NgqktZaqm0HBo0dsLJERBdxu8lznziI0YSKUDRIVqJ8hBf6Fq9VdnLNVW5VUJntWh3U5l7p1L1GUE/mDsDabAb+4PG2VsY4PsF4i3v4WpDvr+lztx8Jj5bx6mD0KInZivQFqJAOYDwyMN816htwyITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.20) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ci6mDdsfuKmplU8229xsQtKhr0SfE3NaHERiXsq+t8=;
 b=ee9HTLJSj6EllWUyYl9JXjJRn3m1em6Y+Q3T5vZQU8JzxZnmaCT6N+q5bZNGr63YepIqkejOSu83QZ0xSA4soWQAg/CqtBwe67d8O0cMhtNHUlKL+nnzTr09Pi4mqPIDrAHPxZ39PKo+yzIDTk7F6c37Db6a7hN5MT9r9ch9/SsGTyKzawT0UTgX1g3T8Z0LRBTduftaXugCz9CqoeX70exDjJFijkJlHEdv4tngcvCAkz9ujf+MW1yrJEi0fuCY4ZJEHQRLQUh4owdZ22C4xnO9DuNqmB7GAGpUld70ink8f3v2uRkkoxlSHiYEKMCiqM4Gq4jgJm0yGTX0uQv3XQ==
Received: from CWLP265CA0530.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18d::22)
 by AS8PR07MB7253.eurprd07.prod.outlook.com (2603:10a6:20b:25c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Tue, 22 Apr
 2025 20:16:08 +0000
Received: from AMS0EPF00000190.eurprd05.prod.outlook.com
 (2603:10a6:400:18d:cafe::6e) by CWLP265CA0530.outlook.office365.com
 (2603:10a6:400:18d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 22 Apr 2025 20:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.20) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AMS0EPF00000190.mail.protection.outlook.com (10.167.16.213) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 22 Apr 2025 20:16:07 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id C6374200A3;
	Tue, 22 Apr 2025 23:16:05 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: xandfury@gmail.com,
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
	horms@kernel.org,
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
Subject: [PATCH v12 net-next 0/5] DUALPI2 patch
Date: Tue, 22 Apr 2025 22:15:57 +0200
Message-Id: <20250422201602.56368-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000190:EE_|AS8PR07MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 9758c08d-b515-4111-1981-08dd81da83ea
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WHQ0S2hyTENZaXc2R3FkdlE0VEkySHY3T1hFZzZZT2JZbGNvTXB6OGE1MEl0?=
 =?utf-8?B?amFidW50a20zZ2p6QU9Qd2I4UUw2eFA0TVBTdERTUVllR282cmFpMTFXN2hY?=
 =?utf-8?B?cWhuTk54N09zM1NrdHlKd1djMWlRMWtrS2tiWHZwM1phSmdwNE5PWlFFWHdV?=
 =?utf-8?B?Ty9sVXlaSzYrTWlnaUZTRFJZc0ZpV0swdlZDVm9TQWtYMDdSZDRYZWtTVGdD?=
 =?utf-8?B?aWFmZGRNa2dDa3JKblNGZW9nam93UXk0bnNFbUlGbzMxTmNVQXFYZTIxaGZC?=
 =?utf-8?B?RE5RZ0ZhQy9wMUlWWlp5K2tnS00walpvZ210LzQxQ1FXcE5XbVZrN3Jub2RO?=
 =?utf-8?B?UmMxWTIwNDVkOUFYaHV5RVVLL3N6eDNlcGloekk0V1JsRUJVakF0YWhudXN2?=
 =?utf-8?B?NnFmcHhSNHRiMkw4OUovcFY4clpPa2dPelNKQ2FuMkhHZmV3aTdmeFp0b05M?=
 =?utf-8?B?V080cUJndDdyb0dITy90YmtpVVM1dlRmMGNxT1FwbjJ6aWRjQlhSQ2cxa0ho?=
 =?utf-8?B?OHBTd0diVkQveWd1R3U4WXNEN2VLdVdQYTdYeHR3WlhLV2NTdzYvZGRWQ0Rz?=
 =?utf-8?B?WFBlaWVsZWNodW55eUFjaUM3VFR1dC9RQnBwa0FMd0k5Q2hKVXVoVXEzeUpD?=
 =?utf-8?B?NklWTUJnZkJ6Uk9jMHhOakRDck1EcGRFeHdzOGozUURBMXZNRlo5U2ZWTDBn?=
 =?utf-8?B?NGFuVDRSTkFWQTEvWEgvdnNRN2dSb1RwblRUanpoWEZ0MWZyeDhacUhmdUlj?=
 =?utf-8?B?RGxLdDhxckMrWmJrMnVVNkpzdHBSZEM4UXRzc2dxdk0za21kdHc3My9vdkFO?=
 =?utf-8?B?VjRRbHhhS21QMHl1RWdhNUFqVW1sTUJxOHRoTm1WSVdUdG42d0xtbmFzY0hK?=
 =?utf-8?B?VGZoc3ZUUEZGalZNTndVM0hGVURzNEdZWGFScm9vVUZ5NWtKeWJDT2oxUWJO?=
 =?utf-8?B?VE9SVzRoQUdSYTVQb2g2Q3owQytRZk9PQzZpSGxUNWxwaG9KS3BIVXBqM2M0?=
 =?utf-8?B?dnN4ajFXRU43czc2NmFYclpCR1prUHFiN1hvNGhBZ1lRS2hkY0ZUM09OQmFl?=
 =?utf-8?B?cDM2YUx2ZFlHZkFGeEsxQ2RPangvMjRiVi9WWC93bCtwU2hPcUFqb3lsTCsr?=
 =?utf-8?B?RURqaEhSdFU3ZzJONTVQMkNwa0V0WDNUbFBrUFZnSWNDTDhSSldlQ1l1dkJ2?=
 =?utf-8?B?MHM4ekF2NkJEckJ1dkthMXVMT2h4M3NkNDNyUThWSU82SU5Cb2s5ZUZZY1Nv?=
 =?utf-8?B?RDhmQkhzUk1EcnArQ0VlUmkvK0V5SmpSQzQ1a1BrNS9NTlNGLzlka1VGaEFj?=
 =?utf-8?B?OTJ2bjdqcFdFYnBHbXZRU20zNzVsUXZ6SUhiTk16cmZaSVRYMnR1bkZuOFhv?=
 =?utf-8?B?QzhhREcxQS9pNlhLdERCU0tTZVFzZ2F1aUFIS05yV0hNZ2pIMjhRdnREKzV2?=
 =?utf-8?B?OVFPSThySzE4M0loOUUreUt4NVhxUytHT09Qb0RtRFJwYnZCOHhLeWxMRTNy?=
 =?utf-8?B?OG4vUmljUUh2YTZMV2JVRWxScVVtUTNKYlBqNnBuYmJkcFY1V0c0MzlDSWxY?=
 =?utf-8?B?eWd3RUtqSHp3MkUvRjBqSE9ZcFB1UEdqTVl1QldHb083S3hMcDNxSUo1R2Y1?=
 =?utf-8?B?d3FIV0RtZXA0V3podjF5QjgvQzBUV00rcXlTYjhPWlhKWmpOUHlTS3hHUG9r?=
 =?utf-8?B?RzNLYXoxeWg5ZEh0WEtrYkxidlhHWUpIdHN1RXUwaU5uL0w4NmthQmhna1ps?=
 =?utf-8?B?Y2xrbVZNS0pyZjdQUzAralhpTjlNdGVRWFJDR3FpamJCUVFRUW5meFJJQkZO?=
 =?utf-8?B?UFFkUTdvS29KWXQwNy91WTA4cDhudnFncXNqdzJVcUJRUndpVDd1VEZmVFY2?=
 =?utf-8?B?S0t4OHQ0amZnZ2l3d0YyOWJqZ0dZQjFtbnVxZGx3dXZrd2cyWkZ0eUI3bE4w?=
 =?utf-8?B?OExQV3hHYnpsRXpmUU9ObGw4YTNERHgrQ1EwTFlJa2ZVc2x6UDQrTW9TVUVY?=
 =?utf-8?B?YW9EK21GcjJndStKYTc0Y1BwdHpRSmN1dXdySElBMmlpcTZIQWQrbzZrRFNB?=
 =?utf-8?B?QjJ4ZmJxR1oyd3ltckJRTHY1ZlF3ZUpJemRtQT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 20:16:07.1551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9758c08d-b515-4111-1981-08dd81da83ea
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000190.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7253

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find the DualPI2 patch v12.

v12 (22-Apr-2025)
- Remove anonymous struct in sch_dualpi2.c (Paolo Abeni <pabeni@redhat.com>)
- Replace u32/u8 with uint and s32 with int in tc spec document (Paolo Abeni <pabeni@redhat.com>)
- Introduce get_memory_limit function to handle potential overflow when multipling limit with MTU (Paolo Abeni <pabeni@redhat.com>)
- Double the packet length to further include packet overhead in memory_limit (Paolo Abeni <pabeni@redhat.com>)
- Remove the check of qdisc_qlen(sch) when calling qdisc_tree_reduce_backlog (Paolo Abeni <pabeni@redhat.com>)

v11 (15-Apr-2025)
- Replace hstimer_init with hstimer_setup in sch_dualpi2.c

v10 (25-Mar-2025)
- Remove leftover include in include/linux/netdevice.h and anonymous struct in sch_dualpi2.c (Paolo Abeni <pabeni@redhat.com>)
- Use kfree_skb_reason() and add SKB_DROP_REASON_DUALPI2_STEP_DROP drop reason (Paolo Abeni <pabeni@redhat.com>)
- Split sch_dualpi2.c into 3 patches (and overall 5 patches): Struct definition & parsing, Dump stats & configuration, Enqueue/Dequeue (Paolo Abeni <pabeni@redhat.com>)

v9 (16-Mar-2025)
- Fix mem_usage error in previous version
- Add min_qlen_step to the dualpi2 attribute as the minimum queue length in number of packets in the L-queue to start step threshold marking.
  In previous versions, this value was fixed to 2, so the step threshold was applied to mark packets in the L queue only when the queue length of the L queue was greater than or equal to 2 packets.
  This will cause larger queuing delays for L4S traffic at low rates (<20Mbps). So we parameterize it and change the default value to 0.
  Comparison of tcp_1down run 'HTB 20Mbit + DUALPI2 + 10ms base delay'
    Old versions:
                           avg       median          # data pts
 Ping (ms) ICMP :        11.55        11.70 ms              350
 TCP upload avg :        18.96          N/A Mbits/s         350
 TCP upload sum :        18.96          N/A Mbits/s         350

    New version (v9):
                           avg       median          # data pts
 Ping (ms) ICMP :        10.81        10.70 ms              350
 TCP upload avg :        18.91          N/A Mbits/s         350
 TCP upload sum :        18.91          N/A Mbits/s         350


  Comparison of tcp_1down run 'HTB 10Mbit + DUALPI2 + 10ms base delay'
    Old versions:
                           avg       median          # data pts
 Ping (ms) ICMP :        12.61        12.80 ms              350
 TCP upload avg :         9.48          N/A Mbits/s         350
 TCP upload sum :         9.48          N/A Mbits/s         350

    New version (v9):
                           avg       median          # data pts
 Ping (ms) ICMP :        11.06        10.80 ms              350
 TCP upload avg :         9.43          N/A Mbits/s         350
 TCP upload sum :         9.43          N/A Mbits/s         350


  Comparison of tcp_1down run 'HTB 10Mbit + DUALPI2 + 10ms base delay'
    Old versions:
                           avg       median          # data pts
 Ping (ms) ICMP :        40.86        37.45 ms              350
 TCP upload avg :         0.88          N/A Mbits/s         350
 TCP upload sum :         0.88          N/A Mbits/s         350
 TCP upload::1  :         0.88         0.97 Mbits/s         350

    New version (v9):
                           avg       median          # data pts
 Ping (ms) ICMP :        11.07        10.40 ms              350
 TCP upload avg :         0.55          N/A Mbits/s         350
 TCP upload sum :         0.55          N/A Mbits/s         350
 TCP upload::1  :         0.55         0.59 Mbits/s         350

v8 (11-Mar-2025)
- Fix warning messages in v7

v7 (07-Mar-2025)
- Separate into 3 patches to avoid mixing changes of documentation, selftest, and code. (Cong Wang <xiyou.wangcong@gmail.com>)

v6 (04-Mar-2025)
- Add modprobe for dulapi2 in tc-testing script tc-testing/tdc.sh (Jakub Kicinski <kuba@kernel.org>)
- Update test cases in dualpi2.json
- Update commit message

v5 (22-Feb-2025)
- A comparison was done between MQ + DUALPI2, MQ + FQ_PIE, MQ + FQ_CODEL:
  Unshaped 1gigE with 4 download streams test:
   - Summary of tcp_4down run 'MQ + FQ_CODEL':
                             avg       median       # data pts
      Ping (ms) ICMP :       1.19     1.34 ms          349
      TCP download avg :   235.42      N/A Mbits/s     349
      TCP download sum :   941.68      N/A Mbits/s     349
      TCP download::1  :   235.19   235.39 Mbits/s     349
      TCP download::2  :   235.03   235.35 Mbits/s     349
      TCP download::3  :   236.89   235.44 Mbits/s     349
      TCP download::4  :   234.57   235.19 Mbits/s     349

   - Summary of tcp_4down run 'MQ + FQ_PIE'
                             avg       median        # data pts
      Ping (ms) ICMP :       1.21     1.37 ms          350
      TCP download avg :   235.42      N/A Mbits/s     350
      TCP download sum :   941.61     N/A Mbits/s      350
      TCP download::1  :   232.54  233.13 Mbits/s      350
      TCP download::2  :   232.52  232.80 Mbits/s      350
      TCP download::3  :   233.14  233.78 Mbits/s      350
      TCP download::4  :   243.41  241.48 Mbits/s      350

   - Summary of tcp_4down run 'MQ + DUALPI2'
                             avg       median        # data pts
      Ping (ms) ICMP :       1.19     1.34 ms          349
      TCP download avg :   235.42      N/A Mbits/s     349
      TCP download sum :   941.68      N/A Mbits/s     349
      TCP download::1  :   235.19   235.39 Mbits/s     349
      TCP download::2  :   235.03   235.35 Mbits/s     349
      TCP download::3  :   236.89   235.44 Mbits/s     349
      TCP download::4  :   234.57   235.19 Mbits/s     349


  Unshaped 1gigE with 128 download streams test:
   - Summary of tcp_128down run 'MQ + FQ_CODEL':
                             avg       median       # data pts
      Ping (ms) ICMP   :     1.88     1.86 ms          350
      TCP download avg :     7.39      N/A Mbits/s     350
      TCP download sum :   946.47      N/A Mbits/s     350

   - Summary of tcp_128down run 'MQ + FQ_PIE':
                             avg       median       # data pts
      Ping (ms) ICMP   :     1.88     1.86 ms          350
      TCP download avg :     7.39      N/A Mbits/s     350
      TCP download sum :   946.47      N/A Mbits/s     350

   - Summary of tcp_128down run 'MQ + DUALPI2':
                             avg       median       # data pts
      Ping (ms) ICMP   :     1.88     1.86 ms          350
      TCP download avg :     7.39      N/A Mbits/s     350
      TCP download sum :   946.47      N/A Mbits/s     350


  Unshaped 10gigE with 4 download streams test:
   - Summary of tcp_4down run 'MQ + FQ_CODEL':
                             avg       median       # data pts
      Ping (ms) ICMP :       0.22     0.23 ms          350
      TCP download avg :  2354.08      N/A Mbits/s     350
      TCP download sum :  9416.31      N/A Mbits/s     350
      TCP download::1  :  2353.65  2352.81 Mbits/s     350
      TCP download::2  :  2354.54  2354.21 Mbits/s     350
      TCP download::3  :  2353.56  2353.78 Mbits/s     350
      TCP download::4  :  2354.56  2354.45 Mbits/s     350

  - Summary of tcp_4down run 'MQ + FQ_PIE':
                             avg       median      # data pts
      Ping (ms) ICMP :       0.20     0.19 ms          350
      TCP download avg :  2354.76      N/A Mbits/s     350
      TCP download sum :  9419.04      N/A Mbits/s     350
      TCP download::1  :  2354.77  2353.89 Mbits/s     350
      TCP download::2  :  2353.41  2354.29 Mbits/s     350
      TCP download::3  :  2356.18  2354.19 Mbits/s     350
      TCP download::4  :  2354.68  2353.15 Mbits/s     350

   - Summary of tcp_4down run 'MQ + DUALPI2':
                             avg       median      # data pts
      Ping (ms) ICMP :       0.24     0.24 ms          350
      TCP download avg :  2354.11      N/A Mbits/s     350
      TCP download sum :  9416.43      N/A Mbits/s     350
      TCP download::1  :  2354.75  2353.93 Mbits/s     350
      TCP download::2  :  2353.15  2353.75 Mbits/s     350
      TCP download::3  :  2353.49  2353.72 Mbits/s     350
      TCP download::4  :  2355.04  2353.73 Mbits/s     350


  Unshaped 10gigE with 128 download streams test:
   - Summary of tcp_128down run 'MQ + FQ_CODEL':
                             avg       median       # data pts
      Ping (ms) ICMP   :     7.57     8.69 ms          350
      TCP download avg :    73.97      N/A Mbits/s     350
      TCP download sum :  9467.82      N/A Mbits/s     350

   - Summary of tcp_128down run 'MQ + FQ_PIE':
                             avg       median       # data pts
      Ping (ms) ICMP   :     7.82     8.91 ms          350
      TCP download avg :    73.97      N/A Mbits/s     350
      TCP download sum :  9468.42      N/A Mbits/s     350

   - Summary of tcp_128down run 'MQ + DUALPI2':
                             avg       median       # data pts
      Ping (ms) ICMP   :     6.87     7.93 ms          350
      TCP download avg :    73.95      N/A Mbits/s     350
      TCP download sum :  9465.87      N/A Mbits/s     350

   From the results shown above, we see small differences between combinations.
- Update commit message to include results of no_split_gso and split_gso (Dave Taht <dave.taht@gmail.com> and Paolo Abeni <pabeni@redhat.com>)
- Add memlimit in the dualpi2 attribute, and add memory_used, max_memory_used, memory_limit in dualpi2 stats (Dave Taht <dave.taht@gmail.com>)
- Update note in sch_dualpi2.c related to BBRv3 status (Dave Taht <dave.taht@gmail.com>)
- Update license identifier (Dave Taht <dave.taht@gmail.com>)
- Add selftest in tools/testing/selftests/tc-testing (Cong Wang <xiyou.wangcong@gmail.com>)
- Use netlink policies for parameter checks (Jamal Hadi Salim <jhs@mojatatu.com>)
- Modify texts & fix typos in Documentation/netlink/specs/tc.yaml (Dave Taht <dave.taht@gmail.com>)
- Add descriptions of packet counter statistics and the reset function of sch_dualpi2.c
- Fix step_thresh in packets
- Update code comments in sch_dualpi2.c

v4 (22-Oct-2024)
- Update statement in Kconfig for DualPI2 (Stephen Hemminger <stephen@networkplumber.org>)
- Put a blank line after #define in sch_dualpi2.c (Stephen Hemminger <stephen@networkplumber.org>)
- Fix line length warning.

v3 (19-Oct-2024)
- Fix compilaiton error
- Update Documentation/netlink/specs/tc.yaml (Jakub Kicinski <kuba@kernel.org>)

v2 (18-Oct-2024)
- Add Documentation/netlink/specs/tc.yaml (Jakub Kicinski <kuba@kernel.org>)
- Use dualpi2 instead of skb prefix (Jamal Hadi Salim <jhs@mojatatu.com>)
- Replace nla_parse_nested_deprecated with nla_parse_nested (Jamal Hadi Salim <jhs@mojatatu.com>)
- Fix line length warning

For more details of DualPI2, please refer IETF RFC9332 (https://datatracker.ietf.org/doc/html/rfc9332).

Best regards,
Chia-Yu

Chia-Yu Chang (4):
  Documentation: netlink: specs: tc: Add DualPI2 specification
  selftests/tc-testing: Add selftests for qdisc DualPI2
  sched: Struct definition and parsing of dualpi2 qdisc
  sched: Dump configuration and statistics of dualpi2 qdisc

Koen De Schepper (1):
  sched: Add enqueue/dequeue of dualpi2 qdisc

 Documentation/netlink/specs/tc.yaml           |  144 +++
 include/net/dropreason-core.h                 |    6 +
 include/uapi/linux/pkt_sched.h                |   39 +
 net/sched/Kconfig                             |   12 +
 net/sched/Makefile                            |    1 +
 net/sched/sch_dualpi2.c                       | 1096 +++++++++++++++++
 tools/testing/selftests/tc-testing/config     |    1 +
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   |  149 +++
 tools/testing/selftests/tc-testing/tdc.sh     |    1 +
 9 files changed, 1449 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json

-- 
2.34.1


