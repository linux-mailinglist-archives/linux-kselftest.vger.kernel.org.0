Return-Path: <linux-kselftest+bounces-31716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31724A9DC80
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 19:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625BE1BA2813
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 17:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7B325CC7F;
	Sat, 26 Apr 2025 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="m81EWBNA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D084612E7F;
	Sat, 26 Apr 2025 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745688038; cv=fail; b=hQZY/OKbq0rIlHEiDACubsS3MUJR9tdEcLj07QuPHoxSX1xnY+ENjVHNSNvwKFgh0waGKFTiLDpSzBd+nNRXhJ0B2epFTz1QeetnVmv6j1egfoMhrHqzpcAeNg12PWLgt4OLjCO7m0q7EY4cg1TZNX2oRCBtELRY03Z/m1RikY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745688038; c=relaxed/simple;
	bh=eVlJqjaQpC0dy56YwNB9ehIzBwDlqBK6L4iynYEla14=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fhrTlTWN8TfviNAMfg1nP2iEpys+MAZZtHOhzqte+vu8JrM9ia67qDqfBRZ61tejpGoCNMgrBPW9j+6jkQaC0R3DxUEn08lPkZCvJb20FIhP0n7PpmLiumgVqdaX1g7p884MPjltGEmka9NgB+WHUMYd3J4g2JG6c0O1IuZZCMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=m81EWBNA; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdlUpZE29KTKE8rSsSqryV6P6ISkaEHgCj6PE+TyQtgnneyQIeYI32bEI9/Q9Xj+o/He9xyD8i+2b9O4Ckpg++5aRAeWenS4uM6UiFUI3ZbHVgX1RnYHhYP+kcoEvtw0DzkRRxljalsgqBuGelgVg6MdHQWMOBi0k+PoPqbcr8KKwAqAa4m+djLl8ZfwJ89B7PWzys/Y2jCa763OMlsogrjUUkcyd8fD7O7DTqjJHDF0prjif0RpdxdJ4eC8yUHjEH0RxBRV8Tld3hOmcVlWa/pELnk12LQW49G3SYOC9mOOQqrhLm6i2O/Hk8vQCOdplJyEUYn/yTRttO2Mq7tAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bVgm+54njT58DFTCKlI2kHHn12S5V0moq5aFYvmO/s=;
 b=b1hvp3iAk3gexJccc2/LF1wFumyGloEFwDlyegTv2vAs/si46a3f+6gnIyYSXtMCBPnRkfThQ74rP57nkpiFHzcGlWnfTAclLSSUtU701NOGM/O7AqNNBC/uyH6VMkJXFDQJp2dlZsJt4L0LOJo2ev+APddZOjnhTccB9qhmRDTq5WCOdwgeRtqVXkY6M8i854syG++Qq3GT7ibTuTPl3VazUbxw6VA7mTERQXpNvS0q58i0uSmfL186DYtduyyjmG+q9+SHtjSZveuWNNoJNh738OKjXVzovfMqCaoBYjDYnKs2YaeZbuDpTxC4E4bQQ/fdpvg53i9vqzJDed0W+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bVgm+54njT58DFTCKlI2kHHn12S5V0moq5aFYvmO/s=;
 b=m81EWBNAOJkG9skWKR2N/7xHWErslW9Cf7czaQkRDcCUeYND5E+IYrOTFsC6CYg/BKbdsP3W3s9XcXxdahUo+5ne3ScYD8A5xXkkt6nCBtQ1ZE/GsqC85nwbYquDVRmnItGnVCIPb2UIUgESctbcFSuSjfP4iBpAtLCQJPHlu2cbadSbhjWkW68hinWXzqjJiY+dKLRpf8YfGhyQ2EEsV0H/6ecX1VIytTtt1vHQE+pWrD8Z9gErVYBkQAlyVT7ND+7myf1PdItxoM9ezxqID4YQngW+lX9njdjiqwmgM9Othr999YePkN9KwpmjATTInn/1MqJIxCOTTc/QwYT55w==
Received: from PR2P264CA0016.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::28) by
 GVXPR07MB9680.eurprd07.prod.outlook.com (2603:10a6:150:110::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Sat, 26 Apr
 2025 17:20:30 +0000
Received: from AMS1EPF0000004D.eurprd04.prod.outlook.com
 (2603:10a6:101:0:cafe::64) by PR2P264CA0016.outlook.office365.com
 (2603:10a6:101::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Sat,
 26 Apr 2025 17:20:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS1EPF0000004D.mail.protection.outlook.com (10.167.16.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Sat, 26 Apr 2025 17:20:29 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id C82E2200E1;
	Sat, 26 Apr 2025 20:20:27 +0300 (EEST)
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
Subject: [PATCH v13 net-next 0/5] DUALPI2 patch
Date: Sat, 26 Apr 2025 19:20:20 +0200
Message-Id: <20250426172025.9459-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004D:EE_|GVXPR07MB9680:EE_
X-MS-Office365-Filtering-Correlation-Id: 5190634f-f2b0-41f7-1293-08dd84e6a463
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZFE5SjVZbVczNjRsdDN6R013UWRTWXNUL0hOTG9IYkF6YzVNY0djc2ZIelFy?=
 =?utf-8?B?aFlRM3NSNEYwQUdxMUlieXRXNU8rcVlEM2krdnRzaHNYQVM1WkhRUW9ZWEpj?=
 =?utf-8?B?YVVEcWlRbC9ZdDZyQjdZSm1GZmxXUHhYeG9QKzl6S05uN3Z4TER5aGFsb3Nn?=
 =?utf-8?B?SWlRSHljVDNBK3pQdDE4RmNrRTUxV2J2ZFUxdlduYVJ6MHlpKy9YTlVFSEZO?=
 =?utf-8?B?bzd5ZHQxWkNEeDJpOVhXSEhLWHVJN2JOdWxBek5rWXplRkJtYitzbk50V2s0?=
 =?utf-8?B?cE9EbTlEYzY3elAyRkhTMmRpSE1hRXRXSEdPREhuTExxTFk0RFBBQXdyUFVI?=
 =?utf-8?B?a05LVWF3QnhEenpzUk4wYXBIdXB6djVwbXprNUoyUzAyM0ZhOExEOExQb0dQ?=
 =?utf-8?B?VEh6SFRrZzBvZWx3NEZRVi9DRTdEdnV1OEpoQTlna2kvbjNablhZdy9iTmtq?=
 =?utf-8?B?ZjJ3TCtLakZSQnZOa3doazBaWk1TVDRsSGZ4aTk3bjBVbEhnek5lZmtBSStt?=
 =?utf-8?B?bmFvMTVDK2VETWY0R3gvemNxSFk5K3pkSUtzeFpqVTM3azZYcVZydUVpTEVB?=
 =?utf-8?B?YVJLNXloaWZvTE16aWdBbXdLYlRsZXd0VmdxVnlTQXBMamlYZ1NEZ0ZrQmti?=
 =?utf-8?B?a1QybDB5Y0FNZngrdElhQlNuQnhFLzl6YVd4RHJuZWQ3RXFab1Z0TkxyeDlk?=
 =?utf-8?B?YWxpZUE4RUs0cVVWNURhR05DVVpIN0RJaFN0R1JGSWdJSlBZbUJVWU5jallV?=
 =?utf-8?B?bFY4dXgrdHNxL2JYYk9EMmNERWNvSGw0aVRlRU9GYi8yN2c2YmVEbGRWK2hQ?=
 =?utf-8?B?UEkwY1ZvbytFN0pXSG9hb0Q3TU9mcmRRaHhiK1ZrbjJyRjEwM3BYZ1BUQ1Yz?=
 =?utf-8?B?ZUt4UFdwWG5yM1pOa2NjRDFRSTJrb3daT1NRZlB5YUdsUHNaQ3J1RVhRb2pE?=
 =?utf-8?B?cUpVdnJ3OElFK0JuTnhodU1nSGpiaFkyZzNmSXlXNVRuUzJPOHo1RDdYN3dy?=
 =?utf-8?B?ZzZKWHhUN2VHaVRPRGpYTXY3d1dtZkJRejJ1aHJZNWNtQ0FqZS9tYWQ5cnJq?=
 =?utf-8?B?SGQ0TEp2U1FXczlEVjlHcU0wTGVJN0FmRUxxeVVtOHoyLzRyTjZPUHZHMjBO?=
 =?utf-8?B?cm9leUNKNFFBNFBqYmlNaTl0Tm83Mk5kaWZEWDNwdDNrRmoxNWpGb1BqMEh5?=
 =?utf-8?B?aXAyRHFzb09kYy9jRDY0Z0hmWmE1MEVKSmpuR0tDeW5yZHQ5b1NQWXRabDZv?=
 =?utf-8?B?ZTN5YVQ3SXlmaGxMS2JBa1RQQ1I1UURzV3o0MWw3TlE1Y1I4dk81UTVCUXlP?=
 =?utf-8?B?UG11SitweVdhcUpJWG1MbDhpb242dmg1WHNhWHJnc1NiZ08yeWxsUG8yZVk4?=
 =?utf-8?B?b28zdnJrYzB0YWRjTHJoMGRkKzRTaFFKdE9uWllYMklKMVpkWnByMXozNk82?=
 =?utf-8?B?eW5DbW8va0tiMWVkL3pIam9pVzA4UFRieEk2ZXdLRS9EMFc2TTdmYTMrKy90?=
 =?utf-8?B?Vnhrb3lQK0pkRFdJb1hyM2VpOVVZRkJ0UGIzM3JtUkdTZnJNZlpYUGU2ZnRN?=
 =?utf-8?B?dmhaV0dBSm9lYlMrU1JyRmZGQ25ybFNIOWhaeXhmK2ROMmgyV3p2dWdJcktF?=
 =?utf-8?B?N3BoVEI2VzQ2WHd0VzFIVStCRk8yMCtMMDlJdjU1UXhheXdtSmpvUFA2R0JN?=
 =?utf-8?B?VVpjZXROcXpuTjJBQkxTQjF0QzRGdmV3S09QMWsxT1Qrd2pnOU5yRURSWFM3?=
 =?utf-8?B?ZVk1TDZ2M2hjK0hIMklob2pCN2J6d2lTamwrd0doQ2Jwc3ZScjFxTW5QdnpO?=
 =?utf-8?B?QnFuemRqNXprVk9IblNpTDl2cGdaRVUycStBUlZJdGdqSWgzS2hjSzkxRVNM?=
 =?utf-8?B?cWN3eUZ2R1Z3cCtFNWd3VzZlYnU4RmtSNGo4UnZRM2oycHBBZUd4bVVzWVJu?=
 =?utf-8?B?MFVORE9TOThMUGlvcVdrendLSkRLdEp4Nll3R2JkaTBDZVdINGtieFlGZ3Bi?=
 =?utf-8?B?SktTOFJXWjVCU3poaktwQjRMSHBoaFBZbkZqU1Z0bWkwNDltdlFCS25kamo0?=
 =?utf-8?B?YU5hQXNscnN4UVQ1YlNYMU0xMEV6ZXFJdXM4dz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 17:20:29.0841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5190634f-f2b0-41f7-1293-08dd84e6a463
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9680

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find the DualPI2 patch v13.

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
  Documentation: netlink: specs: tc: Add DualPI2 specification
  selftests/tc-testing: Add selftests for qdisc DualPI2
  sched: Struct definition and parsing of dualpi2 qdisc
  sched: Dump configuration and statistics of dualpi2 qdisc

Koen De Schepper (1):
  sched: Add enqueue/dequeue of dualpi2 qdisc

 Documentation/netlink/specs/tc.yaml           |  166 +++
 include/net/dropreason-core.h                 |    6 +
 include/uapi/linux/pkt_sched.h                |   39 +
 net/sched/Kconfig                             |   12 +
 net/sched/Makefile                            |    1 +
 net/sched/sch_dualpi2.c                       | 1089 +++++++++++++++++
 tools/testing/selftests/tc-testing/config     |    1 +
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   |  254 ++++
 tools/testing/selftests/tc-testing/tdc.sh     |    1 +
 9 files changed, 1569 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json

-- 
2.34.1


