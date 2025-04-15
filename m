Return-Path: <linux-kselftest+bounces-30864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B99A89E69
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 14:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618AA3BE540
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 12:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B5A20E704;
	Tue, 15 Apr 2025 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IptEYBmX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2052.outbound.protection.outlook.com [40.107.241.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9063E1F4722;
	Tue, 15 Apr 2025 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744721026; cv=fail; b=QGCRU7nRSWeCfJXQSh5JIobvl9okLv47Rszew3ocB2OsC+C/q0/c9EDKNkVaUCYSQ7v/4Te9p193TA9MXtSY11rFAN4iSLbe3EU1YtZ038SpQPeQtXkA0iXRw2VeUlSpNcLqSPbBWupTaIr4fDOXBfJpJA4kczgh/DXAEuPv4eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744721026; c=relaxed/simple;
	bh=blA7j+b63nae+sd+N5LtT5PCLTfQX7hTJl5yPFWmhSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HyEq8T23fXYkDigWfjk8pyXTPZGtog65DDnuZ3NPVjdQDiEnJmVzWXZ07aCc4DsDpud5ugFC9vg8SsCnnnTSQWUi41f+p3vW1wdKcvJURmfv18DepC48SugHHcPJC3v6faZontB4KzEOq+RaR+VWVB8MzWQatHrmZRtpBrwLevk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IptEYBmX; arc=fail smtp.client-ip=40.107.241.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2KaTycjWwuUDKwADY76QCF3V88WGGk0AD1iotoifohRLcRBCb4ikhNlyEC9C5TWq0cmWlD0k7ukbRkeYbWlkq3f6TzmPHXO5O34hYKGCGWuUDHWDJ2LuRG5d8+H5y5F+f00IgxRVrl6UGfSOvmqq3mQ0s32rGbYk+JvkVkh4LE9gXHwzOKJ0y0vWU1B/QlZijJt4PsU5J7DV3uMj4H0cf7Q2TG/3n/Ztm0pZePFNjQrojUHr7nO9yyFDsOI0Mymuase7iVZ5OuY3fUjP20AH7GyuZKZypdul8zAO4Ov9x/Kn4bkIFzmcQ6l2/5pr4gGazpC3zpYo7aRd6y0O5zS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yN5uJggzy86piSYnKQa9BKo82zIUcEcmPO7TJ7yCYmo=;
 b=wW2m5PQLCIZfE09zUNChfH8aeeIWQPJ7FZ3qObBop97KDeyMBSnBqKg5Ap5rLq0DQ+4vnOozmBObg+Aec8/+4tpBXf9m/f1Jsm2gpXO7XAwolc/PRLKZTTyBc/QEUHoJBDsagl/nTAtMMkkpdzu2Q7wRnkdt0wV2pawiIb+wo54cGyAF9SpaAqsfKHHcJ720VvIcHsDCtWPHwlvuHDto8gx74vCtD3DuZCaubdyoiWthv8M4OUMnonTNXjwNghxfigSnLJpEtynJ5Hi6s6OGb6vgV2fmKns+6Zfck5IBbdHZxTv/UuLutT++IhXRmVQg97Z3cU7+8UtIzwALDufw2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN5uJggzy86piSYnKQa9BKo82zIUcEcmPO7TJ7yCYmo=;
 b=IptEYBmXlCvgsDkSEGZ/b51U5T4ruGkL58RPyMpaKwmzPTbBJP+yRNGzOmVE5JMEda1UFIYf09OUUf6iXHVZ+n3wn2hhrBBjKEUfWyNf8iZYyrnn5DDgCkQxC36KeYKduqs69XdYIBdVgWDSlLjbrHTazckUPC8e7g0q5pOR7kdAzI7ju8/aQOPd6vBU5p8Dd4xkmbeCfm2FMAzWu56vwKani574cfP5wfSxb4nX50SHWCc3vwfQ9wmyE6291m8HICsf27AIQmAutfQdvEWFknMdeqEITLIeRVbeU/yVIUN98LnkpR4nnDN3K1OcObtV6LkKWGUvubTYdtV9NZXAGw==
Received: from AM0PR02CA0151.eurprd02.prod.outlook.com (2603:10a6:20b:28d::18)
 by PAXPR07MB8555.eurprd07.prod.outlook.com (2603:10a6:102:24d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 12:43:41 +0000
Received: from AM2PEPF0001C70A.eurprd05.prod.outlook.com
 (2603:10a6:20b:28d:cafe::da) by AM0PR02CA0151.outlook.office365.com
 (2603:10a6:20b:28d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Tue,
 15 Apr 2025 12:43:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM2PEPF0001C70A.mail.protection.outlook.com (10.167.16.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:43:40 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 53FChgEd013987;
	Tue, 15 Apr 2025 12:43:43 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com,
        pabeni@redhat.com, jhs@mojatatu.com, kuba@kernel.org,
        stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, horms@kernel.org,
        andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net,
        liuhangbin@gmail.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v11 net-next 0/5] DUALPI2 patch
Date: Tue, 15 Apr 2025 14:43:12 +0200
Message-Id: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70A:EE_|PAXPR07MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 414bd611-6b4d-4ccf-cf57-08dd7c1b2690
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VEtoeExJcSt1YmtFMVRWa050VWs1S0ljRlZsUGsyaGhldWpWNngyYXNuVXBG?=
 =?utf-8?B?VTRITjF5K0huZTdtQzF6T25WYlNTc21XNnRoaFJWbmFFWEhYK3NldDA0dXNW?=
 =?utf-8?B?UmdaM0xuS1k0MU1HNURPYXdpSUJDVFFnOHJIMjlYZ3hCLzFYT1ZoV1l0QU1q?=
 =?utf-8?B?RmhXNHRnMjV2M1JiemlBT3MwamxXb0ViOCsxNFJjd21RWFJtdWhnNXJsbDJ3?=
 =?utf-8?B?SFZVbCs1dFZGSEJvQVU0NXRZdURWdWdDUXR4dUJoNW5qOXVNc2ZyTnBhNFda?=
 =?utf-8?B?NDFyZmFOUjBXaHRRUk1KZGprc05OcTNmM2U3cjhISkhrekNjd2Z1cCtkWk53?=
 =?utf-8?B?RTkwZ3hMV3ZaTXZUdTJvMm51YXdxMksrZWRzOGw1alJIOHJVb1FmSzB5Vk9U?=
 =?utf-8?B?RDVNTmQ4MVFkYjBMVzV0eWNhZTFTaXZ5OTJVZFhvR2ZCVDQyVGpzeSs3bnRO?=
 =?utf-8?B?S0wrdlRkSUkrTFZpeHZpOTZaSi9LT0d1YktDVHBQV3FRNFE3eG9ITEJzZ2xp?=
 =?utf-8?B?d0F2ZmRFdklHcWJrWXN4MzRwdklXZGRodlR1Z0JTMDJoL1hOSHFtU09WSEc2?=
 =?utf-8?B?eTVwdExVT2JWaUV3WlVQYXg1Ym14M2h3WFRta29yZllncDZ6MmFiaFJxZHNu?=
 =?utf-8?B?ZnhGV0hweVZtTnZxcmVWSEt4b2VvZnhZOWZNVmRQUmRia2plSVdPUk5XQm1p?=
 =?utf-8?B?SWxycEpEK204TTc2Z3hJc1BNdmFGd2gzM0N6OFNqUGVRejNtQ21rQVY1M2Nk?=
 =?utf-8?B?ZEEvL0dOVjE5dlBzemRzclJ4a3hEVXBBbWUxNVFzZEplOWtqbUs2MFVtbDFH?=
 =?utf-8?B?bWVJckhTZXFiWTY5Z0xoZkZhbzlRZWdmZVdPbVVkUVZtaDNPbXJwRXRUMjIr?=
 =?utf-8?B?Y2ZvcFc5RFFhUjFIS052d1FrZlkwUGR6QlNCdGplVkFVT1RBUmorQUxKdk9s?=
 =?utf-8?B?TXdIWmdHcmlRV3ordTMwdUdqSXg0cEMvM2RNREVtK1ZOZFY1dm9aajBpRTJ6?=
 =?utf-8?B?SXJXMUdpYnBVNU0yOGlqYzRjODBSd054QzVOUW9hYzdlRERIaTNnMGFSbGY2?=
 =?utf-8?B?Syt0cXQybndPT1BUek5UUTZZZmlUcG1sRE5kSG1PU21JM3duelNnd054c21N?=
 =?utf-8?B?a3cvL0x5ZW9kVW94NFVPNG92SEdFekNzeTdCV29aM293NEhtY2hQaGlqSXln?=
 =?utf-8?B?ZGpvRjMzMUJSYkY2U0hQTVhTcmEzZThsTXlYRStUZzdkUy91SG9CcTNwTWo4?=
 =?utf-8?B?YVpabW5SaHBsclpUTXFRSVhhRTJZcGFOeVZuV0daYU9xb3RkMHhvUDJhRExu?=
 =?utf-8?B?RHI0RmxjZ3BJTFJGenhHemFZZWlwbHNHRDdVSlA1UjhjUmtMbW0zM3p0S00v?=
 =?utf-8?B?NUtnSzYrcE1Xb1l2UEtuNFlOdEN4dGRtbEpPbTNsWTd4RmVrSGN2WktBcFo3?=
 =?utf-8?B?dHVIRDlNWmVrbDlPV09WRWgwUWtKOUhmeHhKNm5qV2NFSWNBOUhXWUhJbDMv?=
 =?utf-8?B?NFhqTTB4SzQ1Y2tZeVE4MGJiRGgzU2JmSkJTWmUxbnRSTTkyaW5DNGJZTGpi?=
 =?utf-8?B?RnpJWE5pUDk4UThLQTkxU2Z1Nmx2ekpYMFlNN1BRL2NjVXpWNFNxUjZzNm83?=
 =?utf-8?B?WlN4d2VrUmErMHg3ZnZ2THo3OXlLM0JZbzMva2QrZU10UzFTTVV2dkZqSjZM?=
 =?utf-8?B?S1FpY1lpUEprRmFFWVZvemZDbzdRT2h3OE5SWXZzdnY5eTdOdVFTQTlhVFc5?=
 =?utf-8?B?em5UcThDRElDQzh3cTc2T2ZtYmFoa2VNZlFWNVcvV216QnA5TEVJVXB5c1Jn?=
 =?utf-8?B?WUs3MUttL0dGRE5GT3VqcVVqemRVam9reG1reThrQmFhbmNEOUhZU2w3Q3Ey?=
 =?utf-8?B?Y3E3NW45azhGS2VjQXFoNVhvNFRPQUtHQzhPS3lXYlJET2kzZGZaaXNjdkZI?=
 =?utf-8?B?ZkoxVkErUlo1R1NjY01OSUE4Q2tvd0RKZjI2RktyYStEQlg2YitBMUF1Y2dw?=
 =?utf-8?B?WElMaU54YTM1aGdKcnNySlpHSDNoQ1pvOUVqOE9lSW52TGNKdUxzK1pQTFIz?=
 =?utf-8?B?SWREVDZjaGxoNTF6Z0JFY0U3ZEYzLytobmZwUT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:43:40.8370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 414bd611-6b4d-4ccf-cf57-08dd7c1b2690
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8555

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find the reposted DualPI2 patch v11.

v11 (15-Apr-2025)
- Replace hstimer_init with hstimer_setup in sch_dualpi2.c

v10 (25-Mar-2025)
- Remove leftover include in include/linux/netdevice.h and anonimous struct in sch_dualpi2.c (Paolo Abeni <pabeni@redhat.com>)
- Use kfree_skb_reason() and add SKB_DROP_REASON_DUALPI2_STEP_DROP drop reason (Paolo Abeni <pabeni@redhat.com>)
- Split sch_dualpi2.c into 3 patches (and overall 5 patches): Struct definition & parsing, Dump stats & configuration, Enqueue/Dequeue (Paolo Abeni <pabeni@redhat.com>)

v9 (16-Mar-2025)
- Fix mem_usage error in previous version
- Add min_qlen_step to dualpi2 attribute as the minimum queue length in number of packets in the L-queue to start step threshold marking.
  In previous versions, this value was fixed to 2, so only when the queue length of the L queue was greater or equal to 2 packets step threshold was applied to mark packets in the L-queue.
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
- Add memlimit in dualpi2 attribute, and add memory_used, max_memory_used, memory_limit in dualpi2 stats (Dave Taht <dave.taht@gmail.com>)
- Update note in sch_dualpi2.c related to BBRv3 status (Dave Taht <dave.taht@gmail.com>)
- Update license identifier (Dave Taht <dave.taht@gmail.com>)
- Add selftest in tools/testing/selftests/tc-testing (Cong Wang <xiyou.wangcong@gmail.com>)
- Use netlink policies for parameter checks (Jamal Hadi Salim <jhs@mojatatu.com>)
- Modify texts & fix typos in Documentation/netlink/specs/tc.yaml (Dave Taht <dave.taht@gmail.com>)
- Add dscsriptions of packet counter statistics and reset function of sch_dualpi2.c
- Fix step_thresh in packets
- Update code comments in sch_dualpi2.c

v4 (22-Oct-2024)
- Update statement in Kconfig for DualPI2 (Stephen Hemminger <stephen@networkplumber.org>)
- Put a blank line after #define in sch_dualpi2.c (Stephen Hemminger <stephen@networkplumber.org>)
- Fix line length warning

v3 (19-Oct-2024)
- Fix compilaiton error
- Update Documentation/netlink/specs/tc.yaml (Jakub Kicinski <kuba@kernel.org>)

v2 (18-Oct-2024)
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
 net/sched/sch_dualpi2.c                       | 1091 +++++++++++++++++
 tools/testing/selftests/tc-testing/config     |    1 +
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   |  149 +++
 tools/testing/selftests/tc-testing/tdc.sh     |    1 +
 9 files changed, 1444 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json

-- 
2.34.1


