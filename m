Return-Path: <linux-kselftest+bounces-32330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19A2AA9003
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 11:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD783A5083
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 09:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFBA1FBCAF;
	Mon,  5 May 2025 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="nDWlgn3N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BAE1F3D20;
	Mon,  5 May 2025 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746438538; cv=fail; b=Eu8K+hEI6MsIITkxYVQH+6Wd0mo1yh2K+HoO/F4nABc68YYajTiNGPtL7o345S1l2fxs5up/RhaojmCRTEMTu0NSgEQIA8+ZBxruwPfNVnhu324arEcqu+CNC4vKakkOXrDXVu61lFQpiJ9c0dbs6o8hWt6f5VyfjxG123AqT54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746438538; c=relaxed/simple;
	bh=Ir6EfIcppaM4GhjVe0fqBwKhdzZKnH1KdREcr+A/m1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Hnt+Ayxgq3UTupPXhymSU8/xGhyL2sPKxhTmhSvYTGxZW0UXHODHnFGlVXIGjXvaFHG8mzKfJVnn6tBfxcitWnfHWCEm3W5nTckWShDePnxYiwn7JmCnynZPn09P4YRfpWwy9zs27fwXA8AyJVzZ65CkTzGkcn/fBp2LIsgtpoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=nDWlgn3N; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7G9/VJ6z7MFGUpo/nfLFnORtjzsG2vV95BQEajjC/Q+Q6bBDwhRwIOOR+b0STZlbBixFyqlDWIKBgfFrhs3dARxJLLMoan79uE4eyO9cKCpezdRNJHEscY7QyJ1xQS1EiKbfh+Lw080g2zjfVhlumMZA34OiQNo2cBkBuQfzJTdfYsCM1qOh7MOksLxuZ1Lsfc5W+2DWVF/gLx+wpq3vZH64ngumYLqcegmGFTdgVoyhlndPRGGlVrDMKbNjIFwfro5odVgvCHG6x3JXQBygo/BJYqYn9VCXJi8gnPgF2Js8rP7osZt++1VVLjv6WVxgRdYPJrr1DB48CK1W5YUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vzr1NA6RfXb2YVWrR9naHYgL4q02seUvnSRWRGlbRKU=;
 b=x1EcCKBwddenO55pslFm29zHqlvYhtQ1SgM44wlmkb6ngpq9FtLg1AQ2Z5cpGLnZK7VqXCGsSQbU/DW0Zwf+7DhUasA4mUbznuONPYGVgm5C4ZamAliVd7ajOZAMwCQZtuNu8WQPrBwtS96aMjJNOo6hBUhL6K0Z90Lj0uqmeZuhtatrqMOF/eyrxB+VH0YB45XtpFsO3Pf3dFsQ9Q0eupcUDvmUInFXJZP5xXfVPaK7bdCo81TzUQJ7SlIlScu+YVzqPpMmmSc1Xn21MFizoTe07JfhaJUdV7qQROQeoVY1wsUNlsDzTb07cVBllD18jcGd+27L6oPZ7Lx2u1SJfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vzr1NA6RfXb2YVWrR9naHYgL4q02seUvnSRWRGlbRKU=;
 b=nDWlgn3NopgC1H6RCa415uRrSg74QoFEnz3y1jbbvMqPAb9kwsIKRK58QPaaMqxdEV8UBpKAflE+C8Mc+F+XqxFVaS594DEXsudGw9h+motFOVQYHG8/1kIWSm0DjXQpVa9wsklf4blodcJ4wQPcjIV6cckthSRDavj62ARP/hXgm7IkPeVNZMUbmCB9I8ojab4wCOgN49bsJwihRksuEDEmsu8wXz1/s1IXLey9U6BZtUfSqmhqHCPl/jztWmbSr0DD9xPgP3l439t+BIFUJAi8N/TMsX6ycmypKcSpFkJidq96rCULZwLrMPKubgr96PDN87EWNeF8q4q3Pv+sig==
Received: from DBBPR09CA0019.eurprd09.prod.outlook.com (2603:10a6:10:c0::31)
 by AM7PR07MB6296.eurprd07.prod.outlook.com (2603:10a6:20b:13e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Mon, 5 May
 2025 09:48:51 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:10:c0:cafe::d1) by DBBPR09CA0019.outlook.office365.com
 (2603:10a6:10:c0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Mon,
 5 May 2025 09:48:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 09:48:50 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 5459mcwB006243;
	Mon, 5 May 2025 09:48:39 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: donald.hunter@gmail.com, xandfury@gmail.com, netdev@vger.kernel.org,
        dave.taht@gmail.com, pabeni@redhat.com, jhs@mojatatu.com,
        kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        horms@kernel.org, andrew+netdev@lunn.ch, ast@fiberby.net,
        liuhangbin@gmail.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v14 net-next 0/5] DUALPI2 patch
Date: Mon,  5 May 2025 11:48:32 +0200
Message-Id: <20250505094837.7192-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D13:EE_|AM7PR07MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: 993d18a2-59c7-4ce7-702e-08dd8bba0a2b
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WFVVbm9VclFkSFl4andZNmdCc0pkWEhFQ2NzZ1NCRW9WZ2NTT0N2Z3J4cUZv?=
 =?utf-8?B?RmxMTGN4V0w2Nm1RQXZuR1hxcHQxRGZQb0FKSXQ0Q1pPYXYzZk1qVGFKS0VR?=
 =?utf-8?B?elJiSnpDTHdrMkd3M3N2QzU0NVBKc1FVZ0tjZzROa29BNTdMczRFZVBvb01V?=
 =?utf-8?B?clNKRlo4ZXl6aEQ1UE9ONzREU0JyeS9MSURjYWNYUW1HSjBUZTNUUnF4L1FH?=
 =?utf-8?B?SVpDNmFJM1R6eHM0YjQ1SUhUa1QwTEc5Z2dsc3FONXQwL3dJTlFwMGI2ME84?=
 =?utf-8?B?eWt5WnBSQTNXMnVaZU1uMmdIcFFpWFRNSFpKeXVhMlhnVnVRU2ZMTy9nYm5B?=
 =?utf-8?B?Tm5KcEk2dC90MHZhQUwrYVNLRzh2dWFTVzdqamRaaFYvYWk5eUZNcWI5Q2U0?=
 =?utf-8?B?UE1OYVA3TTJ3WERXZXpLendtUmZhVVFiOVVnUzkwZEJzaXRQaUtPbTlGN0Y3?=
 =?utf-8?B?NnJKNEttNE1TeWN0T2NoN2VkTGpoQlBTSGI0M05RUEZSazBudlJnblFZVXZj?=
 =?utf-8?B?ekN0UEFnblk5citBZnF5UVdhYzlLbTh0NVlsS0ttMm9BUC9Ib1BWdnErcXkx?=
 =?utf-8?B?VitlZk0ySEc3Yis2MHZvcnFLV0l0TzQxRFdNaWdZVlE2ZDhFUzR2cm5FQ0Ja?=
 =?utf-8?B?aEZLM3Q5MWx3Q2c5NDViRWVTTE5XQ1hmSjJUa095dWNjMnYvdmVlZnVpcDFC?=
 =?utf-8?B?Rktjc2N6a1g1SE93UnhXZXdlZjM3eHFzOGxQT2w2anF3UEtmeFN5Vk9VU0J5?=
 =?utf-8?B?RGpWc251U25PV2UyWEhsZWd0cnF4eFZWNjhYYjVaSVRqak41eWhtcDVXcTJ6?=
 =?utf-8?B?OTJMaVFHVmRINnA5c2p2RTU2ZnZCNGhvY0FNRW1WbXpSR3BkZkU4MWdaNnlo?=
 =?utf-8?B?RkVYTWltaytDZ2RUdHAvQ2Y2NC96S3Exa2FvMnJsQmlPN1E5UDNwSlZydUN6?=
 =?utf-8?B?SGJKN21XVzF2SzdvZkJhSTR1bFFaNmFhQkV1WXczRWNLQUVVcnhYc3BweXJr?=
 =?utf-8?B?WWl5eHUvWm13SXZVT1BzOEhXaWx6RTUxM2EycGxjMWNBZHorOVR3NHJ6REdV?=
 =?utf-8?B?SURLcTBiSmYwY3hBem4xeXR2QnI5UWsveHFGZ2lCZHMzVWdENmpXbk5nWVJF?=
 =?utf-8?B?M09vSnF0WlBtMTg1dlNIVkxuSCtqTStxZDd3VTBZZXBpK1BVbUpIckFXODRH?=
 =?utf-8?B?SG8wYzNhblFGN0lQcWNnVTZTR3M3VVRxM0pKTmZWN1IwMGxIT2dTSjVNNEts?=
 =?utf-8?B?R0NNaDZ5NjRLMXJ4RTVkYTVHL3hIeXF3WmhkN0FwVVJlRjVXNkZyY0lLdjBp?=
 =?utf-8?B?V0FNN1dSbmtIc3Qxa1dpSW4vY2NwUlQybno5ODZOekN4NUdjZ0RPNkFWQ1Zr?=
 =?utf-8?B?Ujg1VHhEeDJIVzh2VnhPa2NHSjRnZ0RDQWZxZ2hJNlYva1VIWWE5Z1NNZXRZ?=
 =?utf-8?B?cWI0YnNKMlV5Ym8yWGFhckFRM3V6bUtTMmJmR3QrSFFRVU9lRWhmcERhWXZa?=
 =?utf-8?B?azUwUjRWRlAwcEEyWXRZbXJCOFBUMzEwSmJIL1F5WFB5VFVZdVE5cEJzTloy?=
 =?utf-8?B?Z3VrQjdNTGwrTzl5b0VlSkgxcW9JN0xmSzEzM0ZhUjNJUXZGYU94bVNlcldx?=
 =?utf-8?B?Z0NKaWFlR25xQTA1Q21scjVJdXdRRkFjczlxR3lLdVBOMUtqZS9ZdFg1ZmQ4?=
 =?utf-8?B?QXVUVFJkck5LRWQyOS9oYW9yVHBVR2xqOVB4UE96V1djRHhNTWVSU2lRUk5w?=
 =?utf-8?B?bWJxN3RldHdzS1A2UmdEcjNBWHUwaDN5bXUzVzJUOGhjYlNUcDdJa0JtK3pj?=
 =?utf-8?B?ZkxUdVFTUFMxeFpLR0ZORVNjU2ZaOHJuVDhmSGhxQkR6MlRyZEcwWGtMNERt?=
 =?utf-8?B?ZzUvMlVEc2FTQVF6RERPdXZNYmdEZ0dyWGFpWTBiaWRWV0IvamFma1NTeEgv?=
 =?utf-8?B?OHJMZ0RQNFZxTXRjaWs2Q1lQV0pNcFQ4ZkdXUHJGSi8xdFliVURWZjRtamds?=
 =?utf-8?B?bGVVQmhaNkxid3JTdWZXUWljWTNWazVjWmRnRXdWcTlxOTRJL0JjazdUY2U4?=
 =?utf-8?B?ZGdyUHBDejVDUFZIR0FaS2lIV2tRSjRqcmhnVnhTZUlrSWxROTF0RjVsbjN1?=
 =?utf-8?Q?e+Ew=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 09:48:50.6079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 993d18a2-59c7-4ce7-702e-08dd8bba0a2b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6296

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find the DualPI2 patch v14.

v14 (05-May-2025)
  - Modify tc.yaml: (1) Replace flags with enum and remove enum-as-flags, (2) Remove credit-queue in xstats, and (3) Change attribute types (Donald Hunter <donald.hun
  - Add enum and fix the ordering of variables in pkt_sched.h to align with the modified tc.yaml (Donald Hunter <donald.hunter@gmail.com>)
  - Add validators for DROP_OVERLOAD, DROP_EARLY, ECN_MASK, and SPLIT_GSO in sch_dualpi2.c (Donald Hunter <donald.hunter@gmail.com>)
  - Update dualpi2.json to align with the updated variable order in pkt_sched.h.
  - Reorder patches (Donald Hunter <donald.hunter@gmail.com>)

v13 (26-Apr-2025)
- Use dashes in member names to follow YNL conventions in tc.yaml (Donald Hunter <donald.hunter@gmail.com>)
- Define enumerations separately for flags of drop-early, drop-overload, ecn-mask, credit-queue in tc.yaml (Donald Hunter <donald.hunter@gmail.com>)
- Change the types of split-gso and step-packets into flag in tc.yaml (Donald Hunter <donald.hunter@gmail.com>)
- Revert to u32/u8 types for tc-dualpi2-xstats members in tc.yaml (Donald Hunter <donald.hunter@gmail.com>)
- Add new test cases in tc-tests/qdiscs/dualpi2.json to cover all dualpi2 paramters (Donald Hunter <donald.hunter@gmail.com>)
- Change the type of TCA_DUALPI2_STEP_PACKETS into NLA_FLAG (Donald Hunter <donald.hunter@gmail.com>)

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
  sched: Struct definition and parsing of dualpi2 qdisc
  sched: Dump configuration and statistics of dualpi2 qdisc
  selftests/tc-testing: Add selftests for qdisc DualPI2
  Documentation: netlink: specs: tc: Add DualPI2 specification

Koen De Schepper (1):
  sched: Add enqueue/dequeue of dualpi2 qdisc

 Documentation/netlink/specs/tc.yaml           |  153 +++
 include/net/dropreason-core.h                 |    6 +
 include/uapi/linux/pkt_sched.h                |   67 +
 net/sched/Kconfig                             |   12 +
 net/sched/Makefile                            |    1 +
 net/sched/sch_dualpi2.c                       | 1109 +++++++++++++++++
 tools/testing/selftests/tc-testing/config     |    1 +
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   |  254 ++++
 tools/testing/selftests/tc-testing/tdc.sh     |    1 +
 9 files changed, 1604 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json

-- 
2.34.1


