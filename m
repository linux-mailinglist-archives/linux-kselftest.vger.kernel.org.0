Return-Path: <linux-kselftest+bounces-32799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB628AB1F47
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1158A25C55
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E052609E0;
	Fri,  9 May 2025 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="XtBcRWPO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488FA25FA1F;
	Fri,  9 May 2025 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746827294; cv=fail; b=BpIlySp6grbHl4OuS7mtuR8xcXyYSbQtlJ5eEUtlRYlpzjBuzCl1GveXew0ezj/Sw8wmYMJs7HX+cLRJHQBG+McBsyM2A8rr+MHkniKBa+PLTOOPbAiT1an13sZaC31jLrl4pHGWmFsgOAv/CXCFQHcRS/cAUhpWJL57QH2WVSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746827294; c=relaxed/simple;
	bh=bF56jqPGzQZIbrYVw1CgDqS1W2X1k+XZ1qSaNuSFRAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=M4QXsab5rRlc5RRuJyiQMeoioLk2mrlasdWWSrCk1Kqk0o+ndnsmBRgaovFplOSE1I0ZPdakkB2YYAcCzOhHULdzvl8D9BI9dllmG/pggqUidQp+ytgK5BQwRZ0rTuW2KDtoGvBF7U1Qe7m98iLiiPBihfIdoKB3NSkxq4hCpnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=XtBcRWPO; arc=fail smtp.client-ip=40.107.21.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKYHvu1/yRPKGFm578IQy5q1b2dUOjkmovjsS94ZPAyAk2OA/9AtM666exRHIQb/Y3AhhZtXUZgoh9TvKCgM9dmWnRqRnTH8sUISBJZJdoOTBupuANx62CrnOQi0rDN7go+SLwylz2mXA6yI0ehSJdC3sLeF8w/BNj5gA7uGR+Ns4HbUBwNSKT85FjOHcCneyXC0l+EUL1/MMJFKcRqqtUfS+w5KlnlVi8lF1JPcK5X3GyiWVBcmLewO04Pw158nPOq99eUpHw9xrut4kuAJEhIp6apCWNJtKqG3KY/3ee4pxZlyoAwE+8d4hk0cc3sPnFjGPd/XW53ikZ39CVVXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfQFpXO1Kbn82xkc0NyFuJwfUhLaFP2Z+MYaOVwJqU4=;
 b=fl7dm9sqAreoD9sWY+uvpnWJFQP4tp/X2kFdaoR8q1lXdfFnNSiAB/PDFO2FBKY4+FFHduR9YCxoFsPFI38qOlgrLvRm2S9MZujhJz7DxhCcsQkNLRu2Q+UokLOSsIqioU/NE4S2TembNC2Ap4UHDZBbWrqNmgPWzIjLgfGygJitWEI2GLElcTGN6LGS5ElFHpudjQyWvPuC5CfO3fZKXzGH8/7ie4X+KdJE3s9xA5Vs3wLUh5WfdWqLS+OeePYXDqSuwcL6G0hcvX+kpGc6XNYQNqMjNRWcCrKdTYGHlVNiRFI8j4xuG9Ay/ahGFagwrN0M5K5lCVJScS03Oad0AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfQFpXO1Kbn82xkc0NyFuJwfUhLaFP2Z+MYaOVwJqU4=;
 b=XtBcRWPOuP62aPQ+i+tmtJlKZul9wnDrpTnz1/dY6jgbrphdJ2JfOcZy9HO4WgbY0SXxKmfDbTKIh2a0CTlvXmddhx0Q+rnzkA7PW4ZpJ/019YFZmMqlJ6AR1gpJcR7UdXbLecCpjZdnccp2ki16WJZuxpp7CX9LARRXenjiv9M6N/03wcpgWJYwp/BkOjH7P1inWhpbDh37NLUGpHp/Yj9V4IBarVitr6IRWgzvTxLHrbbd3jo8FUCcrF+NsZ1lD1Zes7gd19CmipzHodKL040GTl7YBkG/aW05bL6rU8Q4OS2cEIPAM1f4pROJJfptITvaol29tLlTkGAmwD8iQA==
Received: from AS4P192CA0009.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::16)
 by VI0PR07MB10173.eurprd07.prod.outlook.com (2603:10a6:800:25a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 21:48:07 +0000
Received: from AMS0EPF00000190.eurprd05.prod.outlook.com
 (2603:10a6:20b:5da:cafe::fb) by AS4P192CA0009.outlook.office365.com
 (2603:10a6:20b:5da::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Fri,
 9 May 2025 21:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.100) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS0EPF00000190.mail.protection.outlook.com (10.167.16.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 21:48:05 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 549LmPMn011840;
	Fri, 9 May 2025 21:48:26 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org, donald.hunter@gmail.com, xandfury@gmail.com,
        netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, andrew+netdev@lunn.ch, ast@fiberby.net,
        liuhangbin@gmail.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v15 net-next 0/5] DUALPI2 patch
Date: Fri,  9 May 2025 23:47:56 +0200
Message-Id: <20250509214801.37306-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000190:EE_|VI0PR07MB10173:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d4b142-1ae4-4024-0b57-08dd8f432e1f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QlNnMGVUcmxDcmkzdWF6WTUwY1hKNU5ZZ3hpQTdGNUN6cVAxQ2ZVK1Z0Q05y?=
 =?utf-8?B?V0lyRWh4UVFsamd1WGliUlEyb2hXbDVTSmd4bFN0Wnp5NXpMWURBWGhrV2xK?=
 =?utf-8?B?ZVRmOUxJSmdCRjNHTk1zZ3VncTdsbU03dUNmaHhTTnRFU0lxYWNyZ3JUMTdw?=
 =?utf-8?B?dHdGYkFGd2l6Z09YTkxmZVVpbGFlVmRFcHhnT25iOXZvMG1CeGFZdngybHdG?=
 =?utf-8?B?THViSXBqamw4azlGTzR3bWx1d1duczNxQkJlZUIvYktyMjY0Q2l2Q3FpQUly?=
 =?utf-8?B?SDlid0s1bEV4MzI1U1ptU1hldEVkczJhR3VieWRBeXRBeWFFelVnUk1XTU5x?=
 =?utf-8?B?ZkNZNTk3S1Y0UjY3QVRhaFRiTzYySGM0VWMwNmtMc2tINExDQzdiS0VKYVNy?=
 =?utf-8?B?VmRISEZWd0pwaG1IeWMwRlpBMEF2b0dKc0hZQjVqaGdMMHJQZ1dhWkdkYmIr?=
 =?utf-8?B?eVY5dHVTbEdrTWVwWWltWloxWGYzSU9CRVM0WWRzTzg3cG5NdXhsS29KKzBX?=
 =?utf-8?B?WldNOTMyQ1pkbkdRbVNEZFNhbWgrZzE3NWtlYmRMaHhDZC9RaWE1MjJmT2d0?=
 =?utf-8?B?c3QzbkxXeFY4V1U3S21xK1N3a09Pb3JUR1V6TTBRQTdRQWI5QXdWbm9kSDFL?=
 =?utf-8?B?NnVMdkx4c3lkWUh0dURFblpFaUJXQmhUYXBveTZSWDJiZmRUM0VwZHdzV2FC?=
 =?utf-8?B?TFo3aFIwalM4enJBZHdmazUxQ0hXdGx3aDR6a0VoT1l2bVY3eS9zR0pYTGJ1?=
 =?utf-8?B?dk1UbXpCdVNFMUhONlhZWStKNEpBajlKTlA2K1dqVUdaandvUDV0TDF1cit1?=
 =?utf-8?B?NXRYdWtxNmRkOWxwZFViWU9TUE1uR0ZNcnduNCt6WG1WRkN0L3dVZGVLV1RD?=
 =?utf-8?B?bDJRSEdxYit5OXVxY3R5OXhabzk4ZmZQTDdhbXhIT3I0bjhoT2g2TjVia2k0?=
 =?utf-8?B?VER3RmNiNy90K1FobHdSV2JveVN2aDVhaUN0NG9seFpTQVd4bXdRaXZFeklS?=
 =?utf-8?B?Ym1JZXVoZVRQdkV1c01ROTh3eExwRkhDR3llWno1cHhFbDVIOG9RU1IyZmI5?=
 =?utf-8?B?UDY4amdUdjZJTmlCWkx3VHArZkM2L2RyZVVCTjhySWhOTzRpQ3NDQzZZZndl?=
 =?utf-8?B?WDl4cTl1cm1CT01lM3BwSUE0NDNrbjVWaEFKUUhVK2hTcDVPcXJvRVA2M2Ju?=
 =?utf-8?B?amNKNXF2TzduVUxrbmowWkd3eGZsbkxvV2JzcFR1T0t6OG15YXpyanhpWStm?=
 =?utf-8?B?eHY0T3RNMkhzdG5kYjdlUStML2JtcitqOHNyQXZsOGR2Y2xyS1FidXFxUFB2?=
 =?utf-8?B?S2lqdTZzVXhyKzlESlFLTngwZTRTM3lCSHMxckNLLzI2NjdXOHdUYlcwdHpk?=
 =?utf-8?B?OFcrMU4xbzlJcjY5S0cvMUk2SFFhbUs1NXJRSjlPbXBpYVNpUGNQdElia2hh?=
 =?utf-8?B?UjNRNCtDVnNlNVhuYlNxeXRBdTlJcUZOdWJBWE5nZ2pHVi9PVldPWkNwTGhn?=
 =?utf-8?B?RU9wd2ExTmI2MHVOY0VOYWxjTkFlWXYwNEVvODgvSmdTdTArakdwdy9tNWVR?=
 =?utf-8?B?QWFOQlR6cmMzakFNb0tVclhtVncyWnovQ2NQOGdBUzN0Q3pXWDZoQ0U2ZW8z?=
 =?utf-8?B?T2RKcHZIdnBVOStDOWZwZkVINXZleWFLaEExOEtjc1RiSldqakduU3gvZVkr?=
 =?utf-8?B?dHpWdWFmdHhidDJkREhTeFNpakFucFRSeXRJWDRYVWx6ZXE4ZFhxYkY2WkZT?=
 =?utf-8?B?RjdMY0JaazhZaVJaclRNZXUyTUVEYm9xdEtzdjlFK2JkZDAzTGhmVnhlUHZM?=
 =?utf-8?B?c3ozOGEzcVJxL21VdEp1NVJKSVMzK2lSWmJkb1p6NVZpZm43RlZzNWVsaXM4?=
 =?utf-8?B?TmVGMzBtbTRaS2Y2cENyVk40K1dER0Y1VTR4S1BKaHhDem5mSE1QU0U0aFp1?=
 =?utf-8?B?bXRPMnpyM2hBcUNSSmFiZE5Rc2lyZUlRWEx2OWlKdmhaYi93UEg0UlZLRENN?=
 =?utf-8?B?ejhuTlArVFFZLzZHU1JPWkxiVGR4MW1GMllhR0xlbWNzYWlyNXpBeFFIdnZ5?=
 =?utf-8?B?Vk5Ed2p6M1hsRnhzTC9UTW5icS9CRE1xTEpmNHNTb3BkTUluQ0tIYlJENkg3?=
 =?utf-8?Q?/WHQ=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:48:05.4884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d4b142-1ae4-4024-0b57-08dd8f432e1f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000190.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB10173

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find the DualPI2 patch v14.

v15 (09-May-2025)
  - Add enum of TCA_DUALPI2_ECN_MASK_CLA_ECT to remove potential leakeage in #1 (Simon Horman <horms@kernel.org>)
  - Fix one typo in comment of #2
  - Update tc.yaml in #5 to aligh with the updated enum of pkt_sched.h

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

 Documentation/netlink/specs/tc.yaml           |  156 +++
 include/net/dropreason-core.h                 |    6 +
 include/uapi/linux/pkt_sched.h                |   68 +
 net/sched/Kconfig                             |   12 +
 net/sched/Makefile                            |    1 +
 net/sched/sch_dualpi2.c                       | 1106 +++++++++++++++++
 tools/testing/selftests/tc-testing/config     |    1 +
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   |  254 ++++
 tools/testing/selftests/tc-testing/tdc.sh     |    1 +
 9 files changed, 1605 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json

-- 
2.34.1


