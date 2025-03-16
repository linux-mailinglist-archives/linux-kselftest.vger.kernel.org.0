Return-Path: <linux-kselftest+bounces-29156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963CDA6363C
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 16:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3691416C483
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 15:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0681BC07E;
	Sun, 16 Mar 2025 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="rhzXg24T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE6E1A8F97;
	Sun, 16 Mar 2025 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742138871; cv=fail; b=BU9JMHMUOA+euxw8RQbNw/QzkI8KmStZjxNbWNhSGdisuvOFct63QDqFORrAucTHhZBSysUIYXQZbWxeASzCBgtE1jrUYKgg/fwm2z5W/ZLt51JLBotUahlzaVYVlGP/PNUc/LrnmH86hgECvqISoyXKxr7DbgtbDh6D/irnA4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742138871; c=relaxed/simple;
	bh=+fln6bICG+1coKtciTClw/35q5oT1HUjW5Nw+zJfV0c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DKCV/8EeQApPVV2wmgrVpULferDtI+rNXi54ldHYvEbfasjpp6M7nxpIAp5wuVHqBZTKYnBYOt0yJBtz5ngfQnnlM3ZtobKXdhIFGQadBIc2Z0VgbPRFbjhWqwoCbhtvAx7PwCz4PBZYWVCS1GgSw9Pu8wpA1G3xW70B43CBKxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=rhzXg24T; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxiKBRPOVnJASxd6xQJ1+t04V7ZnH8pj8KGwGGO42K+vZP/c9Sh4WpQBqMEPabK3rHPN09+I0CFthmg+tlbJX5mctPLyPcESeh/w7N3x02AH8CnpntbCWGQXmK3rI+LCMS3YKR0qS0TU/XCselkBvMEtRLwhwbHaYa1nIK5+ZQOAaGs68IVXrAnE3+WHQPge9aYRZNsZH/qjoZl1SLP5AZY03pT/zmkRLUoU/xpxxgsdBloVTe9eMD5jVeKtI66D/v78ao/51cDb+SbaCG1imxmJ6Dgdqv/ji2ut/Kot8wYbckdg72QvzDX3GpIoPbwn6Pv9yUjmp3Wt683d5nlPEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1EVkRRBGncpU9vBu92o5hBerfS4/zTg54VTo6C367A=;
 b=zWnZbchs/VYU3N8zMV19fEMizQhAJ4wG9D9X0AOeTEDgur2U+Waff+EKP2EuLDLTBuu87Rafb7azYnG5V0BrlFd+lORCOKp0G5/AFfDSp5hqEuyI+hqnkOX6RLgH9LUoFrJAkt/k7bxTEaXKITwnYBQtZEOoR8jfaA3aA2kAAzZ+920sfnCVAkcYd1aI/WIIbY1vEER0gJ/1iwd7cZ2l8ezmgooPM50x8ek99n07XaVSEdgO8GQbCz54tSONwiJaPziUpiJTLOflgghybzqVeOHYnvVEnTYcTYO9zcG1h/wdtqGYTvM5MMnQxm+fTqxIMKDKdwhdiw3OSlWtLbh/qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1EVkRRBGncpU9vBu92o5hBerfS4/zTg54VTo6C367A=;
 b=rhzXg24TAdaODP84scDZSTrfmD5RAoFvZT6WKsbTEM/eJYVmJQ2c/ot8yv30+19DEYLkilb+YDiQJ96EZ64xJthlR2iUEdv4bC8QPQQwUWavxeHMJuSlpjs25cxPYOOm2u60nYd8M33+l0NZ9BqqI3DbHWhx8wQanQVTZAMZYL00LeaXMEKrmP900q/PSufbUTtqB8ug5hCX5504QuhRGkNO2vutwRnL2qvNgDRnx+WR4mLRk5WXzlSsicraTJnnVQLv9c2dFiPcR19SvZQ8fADjgDMSZb4HbHv2opKqS+OpuxAUv36jc+ONtgnUW3WM+Bz/0CYU/46obpt8ruXrnQ==
Received: from CWLP265CA0489.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18a::10)
 by PAXPR07MB8386.eurprd07.prod.outlook.com (2603:10a6:102:227::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 15:27:43 +0000
Received: from AMS0EPF000001AF.eurprd05.prod.outlook.com
 (2603:10a6:400:18a:cafe::97) by CWLP265CA0489.outlook.office365.com
 (2603:10a6:400:18a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Sun,
 16 Mar 2025 15:27:43 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.100) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS0EPF000001AF.mail.protection.outlook.com (10.167.16.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 15:27:41 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 52GFRT2s000613;
	Sun, 16 Mar 2025 15:27:30 GMT
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
Subject: [PATCH v9 net-next 0/3] DUALPI2 patch
Date: Sun, 16 Mar 2025 16:27:14 +0100
Message-Id: <20250316152717.20848-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AF:EE_|PAXPR07MB8386:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4948d5-44b6-459f-81ce-08dd649f17bb
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?M2FFQ1dCWUVUQUpwTis5TWZvcjRKbG9xQkI3N1FJYVhjVHc0Vnlrc1EyQUhT?=
 =?utf-8?B?WlBnZjAvMXMyOGFPRUNKZjFhV1JNcDRTN0VDYjlWQTc1RTdYQVpuUUR2QlFQ?=
 =?utf-8?B?SjBZMGNLa2tiNXJFVk1kb2FVeFY0cEFGaW1rbTdLWnp5eXhwRnl0NHR4TVN6?=
 =?utf-8?B?VEpoU0lieTVzSzRCQVIzeWNablVGVGxBY3QrNFlMRmpSaU1ybU9ZODNaeDJm?=
 =?utf-8?B?MDR0NGhiZ1R6SkFKbE92b01aVkhCMGlIaXBuNmxuUExZNm01Q2ZZYVJJUEdX?=
 =?utf-8?B?UlJtKzhsa21wcHBtTm1LTWw5aUlXWGkxMGxuR1RtTElpV2xIcmtiZWxUa1R4?=
 =?utf-8?B?TnlWWnIzME9OUnBtZ0s5dTgzcXY1Y3dvRkxydDlDUFVmNGRIMUlGZURzOHpQ?=
 =?utf-8?B?RFhpaGlMS2NaS3Urd1h2T05pTWgyWi9xd3BaUXZWQWN3cjR6UDRvWWxGc3ps?=
 =?utf-8?B?OFFNYzRRanNXcGgrTGo5UmkwanVwYytWKzFaeDJlVzBNQUN0U0pIaG9HekZO?=
 =?utf-8?B?UEVIcFpxejUzTmU2eHZDc2JQTHlUaGN6MlRYZzZVUEkwU1R3dWh0RThNNTZm?=
 =?utf-8?B?QllmVm45R051UVVIQnljdkNVRXo0WklEOXFrZERVKzIrY3oybEZydXI1a2hs?=
 =?utf-8?B?YndnNG83ZkVRR1B4aHI1cllrcXFpRlNueS82Y0Z4OXFwQnRRYVFGSk56QVlX?=
 =?utf-8?B?ZHpzNkhkODl6WklHYkxiTlhvTGM2d1BzVGxUM1dvam1JV2o4NFlubk9WVDRq?=
 =?utf-8?B?aGU4elRodWVDK3owZ1RLbVMvSzl6VmowMFpkWXp0SWpJd0dsaDhZMHlzR3VH?=
 =?utf-8?B?U0ZIN2xvTjRqQmxvQ1BxVzc1MFZpc2loRE91S2xNQ1JSMzFEUXBkcExnWkIz?=
 =?utf-8?B?dlpRN0hSMzE5dlF6RGE1RUIwMmpBTTdESEVXUWtkWUxRVEhGK2t6NDE1RCs4?=
 =?utf-8?B?cVRZelg3eHFoblFTdEFFaFd6c0dDWk9KQ3lzbkNiYlNZeWhaUGpIM051dXcy?=
 =?utf-8?B?b1Fsa3JsY2k5dncwaHJGcDJyWHZyWlZheHAwazdCREllV3FoY3VqMm9NSlhK?=
 =?utf-8?B?U1FoclBNTEQ5OE1rbkowUS83dHNtUEVYb1Z2RkwzZGZnUXJKN1RtSWg0Y3pN?=
 =?utf-8?B?cUxJMmxFTlJkcS9tWU5Ub1JQYmVyaWtxMGZMTDNFV21sSExLL1pYekc4R1Vw?=
 =?utf-8?B?TEwvT0RkWjZESWFYa2RHYWFyaVBWY3ZzMlY0a0RDMzJ0b3ZYM1pybk8yZENI?=
 =?utf-8?B?OFBEcUdUMVhiNGpzdFc4TUVqbE80dDBGWDVKcUo5UGZ1S1U0cWk5dHg1aE1m?=
 =?utf-8?B?WVdHcS9mTTQ3QUtpUHY0ZHV2TzlJVWZHbHY3aWpkSDJKNTVHVW9TNWprOWM5?=
 =?utf-8?B?aWlMRGtsRlFtR0tpMTdqSG1iUnE1cFhreVovMENsWUh4WFR1WFl3L0pBOUh3?=
 =?utf-8?B?MFhDSUpncFk1SEFoNWlpY2NucXFlalIvbDNFeXVSK0RQZ2VSVWdNREx2MlpT?=
 =?utf-8?B?VEtDNENDN0lLb2RtRXIrM3F0dDBmT0Izb05LN28xWFZDTkxFVWkrZEU0Tk56?=
 =?utf-8?B?cVQ5dllvU0d4V0VRcU51dUNWOVpLbW9YMUgyaXA1NlJ0b3RJb24yY0ZVUmFO?=
 =?utf-8?B?ZUIrSkUxYTJRVVB6M1VGTW51REpBZkZIZEZ5S1RueG90RStERU8vSkd0VFZ6?=
 =?utf-8?B?anQ4UDV1WWpOcy9qM0ROTjY2aG5qbE53S3ZJc3d2Z2dmMEVOTlEweWtCREIv?=
 =?utf-8?B?UVladi9GcG9vRkhCQmJMbkpxYnU4YS9TY2NqUmV1VE4vcEEwWUtTQzhuTVJB?=
 =?utf-8?B?dDNMVHBiUHJmM2FSSHBIVlQ4NTRZbDk3M1ZsY21qN2JLU2d4Y1plNUhjcDgw?=
 =?utf-8?B?eUoyV0wrakRyYklXazEzTjV4RDRoYWZXSUlSWFowU3FidENGcXM3Ukl1Q04v?=
 =?utf-8?B?dEVtWGF5V3U1QXNGdGR0dVg5NUFmWjlRM2w5ZEVSOGRlUXZ4V3p4RTZTY3NL?=
 =?utf-8?B?K0RtNVhmN0pxdDB1dTlaU2xLanJPQ09iYTl1THBJZ1ZCWXI4Z3dZYUs3eGxx?=
 =?utf-8?Q?LCX9b1?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 15:27:41.6439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4948d5-44b6-459f-81ce-08dd649f17bb
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8386

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find DUALPI2 patch v9.

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

Chia-Yu Chang (2):
  Documentation: netlink: specs: tc: Add DualPI2 specification
  selftests/tc-testing: Add selftests for qdisc DualPI2

Koen De Schepper (1):
  sched: Add dualpi2 qdisc

 Documentation/netlink/specs/tc.yaml           |  144 +++
 include/linux/netdevice.h                     |    1 +
 include/uapi/linux/pkt_sched.h                |   39 +
 net/sched/Kconfig                             |   12 +
 net/sched/Makefile                            |    1 +
 net/sched/sch_dualpi2.c                       | 1090 +++++++++++++++++
 tools/testing/selftests/tc-testing/config     |    1 +
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   |  149 +++
 tools/testing/selftests/tc-testing/tdc.sh     |    1 +
 9 files changed, 1438 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json

-- 
2.34.1


