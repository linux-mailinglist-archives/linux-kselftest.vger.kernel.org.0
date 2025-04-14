Return-Path: <linux-kselftest+bounces-30681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA22EA88141
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9301756DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0439127F4E5;
	Mon, 14 Apr 2025 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="bF9+zeWV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011029.outbound.protection.outlook.com [40.107.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E75BEEBD;
	Mon, 14 Apr 2025 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636343; cv=fail; b=T2Z21Er+yIdJH4f2yOUBo4PVYQ5nByNlg2tQRuqyQAccdWJRGEAFAJaV2RD3rp+Eq3SG/jFsdV4TolZV2bCVPanIhXXKdGf9z9Eoh0bUDTtGTGEeebCR0ZLw9iKKaWdp6ZXDGL1Ivr+ewwZLyT45UlOHZgpsBSFpnJkLPL/Harc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636343; c=relaxed/simple;
	bh=H74a8qu5WHo3sMJJD/wIe1W1nkB9nNwYID2z0IZ6bw0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MgMC24lKiGlV7Hd1TY+NqjasyC5t54vxEBDaNZA0Zz7qSs1O3mQ4UbqiVL3eyObZjJQSshdKo3ZrrOt8k43H7LLKMMDd4GtxUSaEZmB5gIrdFIpBY4sBY00CB9DHjT6pJ7nI294jEFNy7JfYFfY/m+e0mEAQCBeHQKZiY6mOh3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=bF9+zeWV; arc=fail smtp.client-ip=40.107.130.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bg+0n7skjdIdFl/cY5V90rVWZdZFPVHIsf4Fx7Z/kpRJznwjj7sNEEmBO2ZIdVwwUmGwGms4KyQ/7+RIVclhgTuZoKIU7RxuMY/Vobdd8thvebR2eosCsHswDtNg/95gdZIRllTw/AVYSWIdG2i8DszZkJRSZVLhyXVp87PWTI0T/m/dYK1iZsw+TRG8Ns5Z3kDWz/kKf0lRvId2ojGoRPIhbG7wRAcU2ohXJTWrJcEMOoMFVZ1Ve++frfNXrXxMlRSouBiDiJyWbuGZ7FKFgd032/6egr+5FcHw+pz9lyaAxloZNToU5IwMxQOJWizytezCD2danhKRZobwjxjvtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tqiQeyWWjLlv2ZD6kM2h66JiFazdLotYd93GOcnT8c=;
 b=XjKaitMdGiMER9J4yKETA/fDO9Ad0/vRr4E9Jd3b5Gs32iUALniJGQpsrxmZcSIFKNg19Tf8wl+z+ZVf5EIxyq5iG3q8/IhhP6thBrhwE2d9SPfdkNW1uKlhtoiNp2eJ2Ln0YVHdZDuNGqjvpf0HyVgIlWxTv5vuo//TEKFfmGH2s+oPSOuZlLTBchj+o8jkMdNR6HAVZ8ezO+3FZE0QhrJ2WlIOovWASaYgJNgzqJICasYLOE5qAH2dUkDghj6GQCV+B37NWNH8D4fRyhqRmAAUA6flPo0QqxBpJI3nLc2ZzNctdh9isVrMdUAvUaXlBr0QQuhyW7+DKmAsdFPCRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tqiQeyWWjLlv2ZD6kM2h66JiFazdLotYd93GOcnT8c=;
 b=bF9+zeWVzeh6OcovfinV38EvwRhU0bQMySKmF5BtuWHBT2pCsvQZMC/wwXzeYmFh2GDf1Tf/Pytm5AGdEexHEeaa49uIi321TSHHNDqZuA4WakRH3/BbSGN14gttKH9w2zFft9Y++hFsh6yyy/mz8kNNEF83SDZLSm6ZRN/6LmoISlE1sWjNmeYRp+PoUwtQ6WMbYrfxNyfm2cGzDIT/oos9q4pMfupKInXeTuWs637Y1ZpNxNlZk7Fi2ddtnCsDrYZQP+hVDE5LM0jUE006Q/uoNSlMipHYdjaJNeSYGdAZedthwYWut0qxWNsDIjK4XvS2DrwZaHB/Uq188e4XGA==
Received: from DB8PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:10:a0::31)
 by DU0PR07MB9638.eurprd07.prod.outlook.com (2603:10a6:10:313::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 13:12:15 +0000
Received: from DU6PEPF00009529.eurprd02.prod.outlook.com
 (2603:10a6:10:a0:cafe::37) by DB8PR09CA0018.outlook.office365.com
 (2603:10a6:10:a0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Mon,
 14 Apr 2025 13:12:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU6PEPF00009529.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 13:12:15 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 53EDCIJD000852;
	Mon, 14 Apr 2025 13:12:19 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v10 RESEND net-next 0/5] DualPI2 patch
Date: Mon, 14 Apr 2025 15:11:52 +0200
Message-Id: <20250414131157.97425-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009529:EE_|DU0PR07MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: 3333ab87-0330-491a-67d8-08dd7b55f9fa
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UXJyNDhITTZCaUVJZGpHYklrdjRPUmRIVTlITW56cXBjMUV0ZGFYUGM0WlRt?=
 =?utf-8?B?dHU1K0hocGxCb1NmeWpNSUV6QnZ5SjA2ZXBQNnJqR1lWRk9IZHUvWW5Ebk5S?=
 =?utf-8?B?ek9zeUdSZmlXRnVUSFBpTHk1WFNyZzgvd28zdC82Rkh5QmNsTUVIM2RLUFFG?=
 =?utf-8?B?SDgzbmhjbXZUUW1DaWFhaVA0VzJsWEJpYWpMTHM0V0JpbDVVK1BjVGo0ZDB6?=
 =?utf-8?B?UmwvUGVJNTFkN1dJSFJQS0JVS203aE5WVS9va2lJNzBqaVNsWlJhckROSjN2?=
 =?utf-8?B?cjVFNjN1TFFucFYyWXBjMEExSDBTRkI2eVJSRGhsckxzbW5XRGpLT2xRK0xH?=
 =?utf-8?B?ek9MaGxXRyswaFFyNk9HU3I1L2pnL3h4S3FEbEZGWE5DMkJ5TWpFZys4Uld4?=
 =?utf-8?B?MXkrM2RlTGo4TU9SSUVha3U0dVlybXlGWnp6LzhQZVRQb1lJRnlYeVpzNk8x?=
 =?utf-8?B?eHFvakVCRzQvZ2Y2NzVYTVQyYjlZLzlrT1QrSEFWaHF4YUs1a0ZHTVUrM1hS?=
 =?utf-8?B?UUQzRk5KNnVSK2tueTFBSjdoTFYxNmFic0R1Z051MVZnUk9qaURKdWtKOEZk?=
 =?utf-8?B?dWdaYnlVNXNFRG1jbHRwVktqbWxYRGQyb3RVSklmYXliZkJqVTN6QjFaMTl4?=
 =?utf-8?B?ZmFDWXhscVM3L3dheWJGeVVWcm5YYWRMM3FLZWVUQ2piYlNiYnhMOXpCRTRN?=
 =?utf-8?B?TDhKUmp4ZTVveDQ4d2t2bnBsVmxBRzhZWkRtRzMvTm15MkJ3aXZvdHIvSE4w?=
 =?utf-8?B?a1NnblhUa0h2R1dhdmNsaTZDUmhSWlU2V1JvOFlibXFka1NBdG9INjRtek1G?=
 =?utf-8?B?MmpUZDZjMlU0VlRmQTBKTFIzM25PWEFVd0JmaWt4RGVVSWFuazRpWW0wc01M?=
 =?utf-8?B?RUdMU01PK3Jpb2FKRkk4c1FwMmR2WDZDNkd6V203WFRqemJFbTkya2cwTkZu?=
 =?utf-8?B?WWNmRnNvYk91TTlTZVJZNy8wcFI3VnM0UlMybm9EMWVvalpNYUNQYVA0QTFW?=
 =?utf-8?B?RlcvbUllYk5IMmhSWkdVbVBpaTJZZFdBZjVIYzVtVSsyYjNneXJOYXFUZmsz?=
 =?utf-8?B?eWphMVMzNlpaVEF4cE10R2pabU9SVGdzbzhrcjNWMEMvbUliM3N3UXl1WkFo?=
 =?utf-8?B?aDU4MU45UWV5eFdkd3RqQWZUWGtYZGtwOGpZR1FXOEljR3RTcER6QmVSUms1?=
 =?utf-8?B?QjhKUWVoTFpEVG51alorU003Z29oQkpSZlhFZE1KOENhbGdCWGpMSjFxU2tn?=
 =?utf-8?B?VDZYdm1LODdvNGZWV1BEQ0IvaVBsVTVRZFJJRHVUZktmSGl3MUFwVW5PNnEr?=
 =?utf-8?B?dXk2cEVxVnB3dlE3YVozT0o5QnZnYXJqQ0VnMkpvZzBCN2U0UFBSM0t4Vmx6?=
 =?utf-8?B?VzBIRUNqRXFCNDdQdzRDSGNybzhCU0R6V3hUZktKVkFFTjhvVFFwMjBRampL?=
 =?utf-8?B?L0tuSUgrRThiQmtKdEY5YTlubnpXQzFIRVhQZm1VYzFqUmZoS0tXbE16SExQ?=
 =?utf-8?B?ejY3aUhieWpaTk14R1hLTHlQU0tCMDRJeXJpZVlJc3pHMHM5TEF5VFZ4OFg0?=
 =?utf-8?B?c1FyZEwwVE9uZnc4OWIySEZPNkMzN0JUU3NGWUlIZUVRVllIdk5oR1pRcUtR?=
 =?utf-8?B?RTFOb0JFRHBHTDBJTk9PYXpac1cvMVA3eE16cEFrOXRLYnJ1TlRkbU1GN2da?=
 =?utf-8?B?TmtNSVVDMFp5RW1pUmNTbXpjeXFDc3ljU1JoRmVnY3dvVkFXSW9NTVVtQ2Ji?=
 =?utf-8?B?NFlZNUE1MmdzM2hSZ253cE54SVZkZnN2MFIwejhXRVMzdW1maDByVC9jUzlG?=
 =?utf-8?B?UUJlWUh0T3UxOW1aNWNYcUtkTWF2ckc5RksrZlNMbm5FRTNsVGFrajVuVkx3?=
 =?utf-8?B?M2RhMFArVGZOSzd4dGpSUC9TdWdQNVBwSW4zWFR1K2d1L2k1N2VKbG5zN3pB?=
 =?utf-8?B?Q0x5MUJScm44TVdiUy9HYUJwb3lENWtleDNaSzdxZHVmdXdBRnAxdnlxQjVC?=
 =?utf-8?B?Lzk3U01XZlBlb29yWGNLRHRjVmRuMXVQVzU3L24yUkhNMStiNmprSUNaQlBT?=
 =?utf-8?B?eE1IS2ZpRVJHY3FvcStmanF0S0tPMTlTaTJWZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:12:15.1914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3333ab87-0330-491a-67d8-08dd7b55f9fa
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9638

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find the reposted DualPI2 patch v10.

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


