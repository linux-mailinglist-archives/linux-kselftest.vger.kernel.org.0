Return-Path: <linux-kselftest+bounces-29752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A3EA703A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 15:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81EFD169A6B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA5325A2A0;
	Tue, 25 Mar 2025 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="jhZWGJcF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DD12571A8;
	Tue, 25 Mar 2025 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912949; cv=fail; b=lxlI1VsheYZ4cJKB0bxcHP07iy0i005R+UgIbAHcfxAT4LOjxPbpGov6cS1HCNJo2bWxU0GEzHuN5RSyosHGMsIap1jpOXmckt8OuPVlbK1qJu3RmlUduAFsFt9JI2eg9q5rb/SRo4W7Q5b6KQAvcxwdII81ZpwIJBRlgP4lqhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912949; c=relaxed/simple;
	bh=zAyPw/hPnB2XeQ1g1yimW564MMQP7bTZCBauIH9U5Xg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RSIzSi65w7BrwlTPhAaMtL/yyy2Tly8Be6FS0Vpz2Rbsm7VOTDRZKJbUZvFI+tCQhbEIrAVYksTnWd+HvKhj2u7l3spzev8EwpOYD4iu5sweUibFf/TwLHA5ZuRB1N7n+bkeivHFZF0DQr9PE0XonnZmCmw+gI0kFImD2eV9bAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=jhZWGJcF; arc=fail smtp.client-ip=40.107.21.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjYAmSNtLfkVSIxjTTBcdI5eDdyOgCdeucr02FX/bdRrgEGZf2KrUgnyc3OW6byU/JrYXuhqc7DDJzCznY2KtlK/5Z63tJ/53F3oViF3RJIHZ//SGbohwR7owTDy3sEel3H6AJ0F8ddnu7nMzNWx2MZJSdivEhEeNESDcr4PmsTnlQ7cp7GYd36kt1LSOMM/e1eE5k0HdICj2AV+vDtahc4xBwU9Q7q91d7EJsYAEnVgFyBLbpB6K/iqA4vUFIoWKNt6XNP3hrRVk5K6NFocX6gjPvGDv/89TjGinoAKxCSOTP8ULTrC77jh+6KMlioe7NHD7L+OikkEqPzl8XfTnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ej5KSgbwfcwPtQ+IQeTkDMpK0tsw+43fZiCFe+n/ISg=;
 b=C53BrnjSEtMUoNwJ+MQon4izy1+8rB3ZVWcPdjK5As4+4iePPlKk0ajr9ZKAfbNtD/pWUKnFpjhbRQH18Rae6ORo+Oxa5mwO6ZhLmQWCyyexFPa1J4XiCj3cqKuw0OEgZXAtrSmR7UB4YqUjCcprGqRxCuSddiY9GwEA29iCt5VykOJwDCnov+jRUBS6BgemRDM9AwFcY1BeTxeLZtVLc+HWhygN2vjpM4jPtMwt7/SLJj9WsS+MwEhIYrveQa0Z+yCw3ciPPe3DQsmihyB2h+Amwc2JWUwlb6QPCO2NHAEvamAk2UnaJD4nOkASB4RGGydjLTIHRaNDDAlfzeAEuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej5KSgbwfcwPtQ+IQeTkDMpK0tsw+43fZiCFe+n/ISg=;
 b=jhZWGJcFrtC97qw2BbmOpffI5z6EwerphRdgksmTDwx8I2We4UMeeg3DureyMwZydqQCgVe8C5vTmN1flIRQcOlMSzMidGcfAt9gJdynixEXXppMI1jGQvsf48JYY7afIM4Mla5jrPaUKeYsidRsAbIFm5F7FO9L+qRgH6myPdqBR358Fc1M4IWgxHYW6Ob8v+7uHH3n7qAyDCzpVlNVAzHTfMAMRjc1/Azd4sWswBuwRGrCyaVt8XDbwD0dE84BNeZMGYsdhPdhSeG/6nyvCc70oQQ7iKNA2cik9e/VkI/fjGRTdjdZyIuI9rzZ6hqEJPu7HGj8kPKxrqTihtFYVA==
Received: from PA7P264CA0111.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34c::13)
 by PA4PR07MB7294.eurprd07.prod.outlook.com (2603:10a6:102:d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 14:29:04 +0000
Received: from AMS0EPF000001A3.eurprd05.prod.outlook.com
 (2603:10a6:102:34c:cafe::5a) by PA7P264CA0111.outlook.office365.com
 (2603:10a6:102:34c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Tue,
 25 Mar 2025 14:29:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AMS0EPF000001A3.mail.protection.outlook.com (10.167.16.228) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Tue, 25 Mar 2025 14:29:04 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id AD4BE32D91;
	Tue, 25 Mar 2025 16:29:02 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org,
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
Subject: [PATCH v10 net-next 0/5] DUALPI2 patch
Date: Tue, 25 Mar 2025 15:28:31 +0100
Message-Id: <20250325142836.47048-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A3:EE_|PA4PR07MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b6d1ff-24e1-4732-bcd1-08dd6ba964c9
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Z1YrT2RQUGlDc3VEYUx0ekE5VVFPNVNIZ0dBTDkzcXJXT2FWYVI2WHNHeVQv?=
 =?utf-8?B?UUt0dEtUOVo3dnB0ckcxbzRKUitMSFN4Mk83dXFRSDUyOFBQdmdJWHlDN1FJ?=
 =?utf-8?B?aGV4NmxXeHJHQUsxaFFJZXVDVEJqZ1RHMzNGZjZrNmFLZnRUZFhFS0xOU2xz?=
 =?utf-8?B?cXRST0NSYVZqV21Ed083QTRiTFczMUNGQUF2UFBrcmo0clNvVGhETk5NczRO?=
 =?utf-8?B?Z1dtUGN4bU1zOUNzdUFOYXZaK2dEYUtqcERSbmZVT255NTFHbEJJc3hCQTRD?=
 =?utf-8?B?dHoyOHlwSW1LZ2VORWhCWGhqM01UdjlRaERtZG5NN1ZTcThQSlR2RzBDWktj?=
 =?utf-8?B?dGlOaW1PSEdpZmRVVUd4d0tRSjNqV1RobXBaWTBxcEVYb29hSXBLQno4WHZ0?=
 =?utf-8?B?ZldhelFGSFRFeTltRXFoOWJiTi94QzVHMzBBRTY3bkVEeTc5d01Zb0RjSVdo?=
 =?utf-8?B?eXZWUFl5THFlMnFEZEVpVkRSTFB4QWtFTkovemF5elR4Q0Vwd1krN241bml3?=
 =?utf-8?B?RE9FVGpnNHhRTFJGL2ZVQzE1K1BGNWlUOWZZcWtLMWVuOTdOQjVNemcrNHFq?=
 =?utf-8?B?ZGZseTU5UlNKTE5XeTl1M2Z5WSthbWJPbld4SW5DU2QyVEhHZUtSUGE5VmU4?=
 =?utf-8?B?T3FVb0wrZWxZaTZhaHNQY2pZa0RwTW5YWDFXS3ZIRFJRWlVyN3dlVENnSzI1?=
 =?utf-8?B?NVZUTDV4Sm5YVzgwRmxETEg2N09XSmJrTU95a2J6OGZVK0NJWGpPcUY1aVRG?=
 =?utf-8?B?RFltYnV5NjZKQmVpaEVPTUs5aVVLaWZMbXlOUDJUOUQ2TWEvU0R1bHMrN0I2?=
 =?utf-8?B?VUw3TXlyYVJVcmF5TXRUdGkxd3dmcUdraGRNOVNFQ0FwRG1FazUyUVkvSTgz?=
 =?utf-8?B?ZzN0b2JLdkRCcGRJdFAwcitSUXZCcTZ6YWFCemRuVlFEdnJsNUgrMGFaWmJa?=
 =?utf-8?B?dlJsM1NJVXZlTTRZMU4vUVg0bnhiRDRtcVg2SmJaS0lXTDdBZm9hRml1WkI0?=
 =?utf-8?B?Mk9UWFlhTDR5MW1QNk5OdmhPZWt6d25oaUVZT2xONmNUWHFRNWlxZWZlNStO?=
 =?utf-8?B?Z0Jub3NZN3AxdUI4VXVSMHpZaUh2bmVSUFVZamFsd0doOEczaUszOEk2NjdZ?=
 =?utf-8?B?bEhJaU03R0theWxoZ3Y5UTg3SXg1ckl3bkJYeXFmdjdoa1dFQ1AvMGtrOFln?=
 =?utf-8?B?WlpUSE1WVkp6Q05zakIwbENKRkh1aUN0TFppMVoyVDFlRFUzTit3T3ZSWExh?=
 =?utf-8?B?RmJ2REw3Q1JiZXluTVFYK0FrYkVYRGhNZUJqL3lQWk5oSG1udDVJakdGSEVY?=
 =?utf-8?B?a3pDMnZTbWdsWkd1THhVQ0tlbzNYZUtLVVVzbEtSaU0wWTNKQkU0aXVxUmNS?=
 =?utf-8?B?U09iRVVjSEFuQXYwV2E4S1JFYVFxTXJJOXVPNHpnbms3YVBRU2hIanR4cUMy?=
 =?utf-8?B?Nm9uSnFWMlZhNTBWdGpqd281VUdNN0M4MGtVY0FUYmxXd0ZmVDhOZHJPZ2dx?=
 =?utf-8?B?c3ZMQWxPKzh5NGxzRUZmNnI5dUMvaHhEQ1dsaEJpTFN3UVNhNkFKdXpIL0VY?=
 =?utf-8?B?aTFxT3RjL21ReGNHU2Y0aCtTdlNFT3cvck5odjdCc3EwWlFEcmxWNmlaZnRT?=
 =?utf-8?B?em9HanVidExLQWExY0h6VHR6eTFjaXdFUnZDMUZXcTl2NDRNVFNMSHFaL3lG?=
 =?utf-8?B?RE1Kd1hXQnVlQStGdGhWYitPTkFjM1NYMWd3Sll0emU0ZTNseVArWkpvU09T?=
 =?utf-8?B?QTB4ZUwrcjhJRVdOalU1V2pDMlQwSDgvY1crLzhtRHNMd0ZvK2VVb1ByNlgr?=
 =?utf-8?B?eWZMY2c0dndoVXJISTBSWWVqdWNERnovNVBTUGdjNnR0RHBIN2hkZEUya3Mz?=
 =?utf-8?B?TjBoTjFWZStaKzhPbTN5SWliU3BjMzdTRmZ4YXBWbGxEaEw2U3FnWDNYeE1q?=
 =?utf-8?B?MHg5bWtPQmg5TWs2bHY5eC9VenhncHRnWE9LVXo3bVFTUnBlWDB6b21pMnhp?=
 =?utf-8?B?RW5uZndmR05FLzF2Qlc5UkZRbm10Y1psV3VZY1VMU212aDJEZzdCWkFyWG82?=
 =?utf-8?B?bnBxNUpPZlpMdCtWLzJtYXJoWi9TOWpGMnFJdz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:29:04.0285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b6d1ff-24e1-4732-bcd1-08dd6ba964c9
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7294

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find DUALPI2 patch v10.

v10
- Remove leftover include in include/linux/netdevice.h and anonimous struct in sch_dualpi2.c (Paolo Abeni <pabeni@redhat.com>)
- Use kfree_skb_reason() and add SKB_DROP_REASON_DUALPI2_STEP_DROP drop reason (Paolo Abeni <pabeni@redhat.com>)
- Split DualPI2 patch into 3 patches: Struct definition & parsing, Dump statstics & configuration, Enqueue/Dequeue (Paolo Abeni <pabeni@redhat.com>)

v9
- Fix mem_usage error in previous version
- Add min_qlen_step to dualpi2 attribute as the minimum queue length in number of packets in the L-queue to start step threshold marking.
  In previous versions, this value was fixed to 2, so only when the queue length of the L queue was greater or equal to 2 packets step threshold was applied to mark packets in the L-queue.
  This will cause larger queuing delays for L4S traffic at low rates (<20Mbps). So we parameterize it and change the default value to 0.
  Comparsion of tcp_1down run 'HTB 20Mbit + DUALPI2 + 10ms base delay'
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


  Comparsion of tcp_1down run 'HTB 10Mbit + DUALPI2 + 10ms base delay'
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


  Comparsion of tcp_1down run 'HTB 10Mbit + DUALPI2 + 10ms base delay'
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

v8
- Fix warning messages in v7

v7
- Separate into 3 patches to avoid mixing changes of documentation, selftest, and code. (Cong Wang <xiyou.wangcong@gmail.com>)

v6
- Add modprobe for dulapi2 in tc-testing script tc-testing/tdc.sh (Jakub Kicinski <kuba@kernel.org>)
- Update test cases in dualpi2.json
- Update commit message

v5
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
- Add memlimit in dualpi2 attribute, and add memory_used, max_memory_used, memory_limit in dualpi2 stats (Dave Taht <dave.taht@gmail.com>)
- Update note in sch_dualpi2.c related to BBRv3 status (Dave Taht <dave.taht@gmail.com>)
- Update license identifier (Dave Taht <dave.taht@gmail.com>)
- Add selftest in tools/testing/selftests/tc-testing (Cong Wang <xiyou.wangcong@gmail.com>)
- Use netlink policies for parameter checks (Jamal Hadi Salim <jhs@mojatatu.com>)
- Modify texts & fix typos in Documentation/netlink/specs/tc.yaml (Dave Taht <dave.taht@gmail.com>)
- Add dscsriptions of packet counter statistics and reset function of sch_dualpi2.c
- Fix step_thresh in packets
- Update code comments in sch_dualpi2.c

v4
- Update statement in Kconfig for DualPI2 (Stephen Hemminger <stephen@networkplumber.org>)
- Put a blank line after #define in sch_dualpi2.c (Stephen Hemminger <stephen@networkplumber.org>)
- Fix line length warning

v3
- Fix compilaiton error
- Update Documentation/netlink/specs/tc.yaml (Jakub Kicinski <kuba@kernel.org>)

v2
- Add Documentation/netlink/specs/tc.yaml (Jakub Kicinski <kuba@kernel.org>)
- Use dualpi2 instead of skb prefix (Jamal Hadi Salim <jhs@mojatatu.com>)
- Replace nla_parse_nested_deprecated with nla_parse_nested (Jamal Hadi Salim <jhs@mojatatu.com>)
- Fix line length warning

For more details of DualPI2, plesae refer IETF RFC9332 (https://datatracker.ietf.org/doc/html/rfc9332).

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
 net/sched/sch_dualpi2.c                       | 1092 +++++++++++++++++
 tools/testing/selftests/tc-testing/config     |    1 +
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   |  149 +++
 tools/testing/selftests/tc-testing/tdc.sh     |    1 +
 9 files changed, 1445 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json

-- 
2.34.1


