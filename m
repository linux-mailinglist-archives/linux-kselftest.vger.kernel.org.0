Return-Path: <linux-kselftest+bounces-46815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C4EC98493
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 17:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A7834E201B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 16:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DF533506C;
	Mon,  1 Dec 2025 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="eNA8Bl/m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010019.outbound.protection.outlook.com [52.101.69.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A476731B824;
	Mon,  1 Dec 2025 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607109; cv=fail; b=If2APOlyX4shc428G8D4E/OcEjlUdknmMtVpD7ZDRIIQyXFI5zYt8SFgk/Dt/vJkvgHi6k7OjxweWyk4TzA3GbEnIrhBl/JgPnddhudo49P1x+kMjNofK3FysThKM1P647+FT7PWNKYavkzNcWA0u5U1tjgw5tCGwFPkvczZXC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607109; c=relaxed/simple;
	bh=aeBPg9ltrFu1FJWEjMpRiI+j7hiD271PNF8jRqCE2YI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oKvv02yMxw9tfcPHWd+Y+G6c4IJTnvHux37RryROOmNokrxdUKYhVYcGfE781GejWp0PD26/O0KrIz0jQAwy4FNv5XnF+prbOoKT3i2f2wbZQp5bGJHg6Yuh/vezH3dPm5Lh/+GSJcS0/EAtL9Oi5QJsbihzncp2ewMkD6dbefY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=eNA8Bl/m; arc=fail smtp.client-ip=52.101.69.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/m8uJGhWcpCPUFzRfQryyotVQWouG0Ig6GqhaIymu7iRfiyteNwvpaU8eOCCiKRshpLc1BGY5q2ow5F0R/bki53ZDXDL/xAtf00MI2YR8iAhegdmlp+P0aGwnF95163/+gxWnd2GpjQa1JVrknW76zLn8Kh/8fI2KIzRqFI214X+81hO+ehY7yfv4GPXOEAw+zhC/MnW1a9KYKfq85B3Q5yAGvpLNOEawn00SZ7jLUqRiQS8IWWVtR/4iE4Iybv5A1uuWe6/DJhTAgPtpbLWMxb5r+Qd4vHRFREWFMtr8zoZfLho53tDBr7Hz5g4DhKunfCmXfOnfXIt7i8zxzW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohPmBs4RpLd/fHQDcFbtZ5Wn2JgePBoiPfZiiLKEZug=;
 b=pclDFeWCgiUUaE1JvtDc214Y/qe4PTnWj8Ji9w71N64swtouRBC1Jyaq/Tf+5O8u3IDUUXjb9BC8voE5EAerkeBM9Z8OnH2a9WtnsQ/fg9FJhBcoq5kcPmsDiaaIuK5uryJvJjoIxhhQHR3o46/QwvKQwM91sFVicJTxhoaS9P/7Ma2ySWymXIAhP9TFivAOta9CNwwmgtLG65IWf5Ea01t66AOi1y/vmkrg+jZCkwiFcKhUgrAUn/dK7oBATvYsrEhyzFPgngacIWD7uKJSj0U8KrEdeWbogM4PmM4moMwvKmqSpA/I6t0Cule7N6hQpx5s1Ojdek/7TxC/FaO5Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohPmBs4RpLd/fHQDcFbtZ5Wn2JgePBoiPfZiiLKEZug=;
 b=eNA8Bl/mZjBQEbkCnf3yupW29GvRLksMiwXpS0+KkN4XxXx0QZordIgATWJMO9NxF5wLXmAYR5PPTQ74n2l7b3aA6DbC6lr+dnHAfKpYIxFFHoBcSbOwHoaxTT4TCYl6oi5FBAHl30Ghb0IiRb24BhOGiloLok4qbj8xvKKl7m2eWBwKx3925Kuokub/emRYgy7Vo1B/4A0U3r+J0+KvsS/BIEX36TmT+B229e0KoBXRaM9rDkynqOoCPx0EBxToSF9gsbIeYV1wj7AVxNlO4DakaxmcJJZIdcaMsJrIL417WoLFPmQ/GRDBNqaQ7zqnem3UZENzuzT6prhB0z0kXA==
Received: from AS4P192CA0005.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::11)
 by VI1PR07MB6510.eurprd07.prod.outlook.com (2603:10a6:800:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Mon, 1 Dec
 2025 16:38:18 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:20b:5da:cafe::ff) by AS4P192CA0005.outlook.office365.com
 (2603:10a6:20b:5da::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 16:38:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Mon, 1 Dec 2025 16:38:17 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 10EF368002E;
	Mon,  1 Dec 2025 18:38:16 +0200 (EET)
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
Subject: [PATCH v7 net-next 00/13] AccECN protocol case handling series
Date: Mon,  1 Dec 2025 17:37:47 +0100
Message-Id: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|VI1PR07MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: 7262eea5-2abc-4793-2fb8-08de30f807fe
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?U0M3dldvZStmN3hwYlhoSFhxNjlrWlRqajNtUkpnQUM0clBHWFhtVDY5cElS?=
 =?utf-8?B?Rk1xeDdDdkk3Ry9QR1pjbTR3NTd0NXFISEREMlZUdWhGZEhWSFB4WjBJenVZ?=
 =?utf-8?B?VWV6QUFmVjl2L29nWHR5bHlnaFhRL3ZtZ2hLbUdMYWx2K0ZIVHJvTzQyRGM3?=
 =?utf-8?B?Q0Z0UUJ1TjJsVk5yekJPR3pOQ1FoK0NZU1ZZK3g4Q3ZjZXR5ZXFtQUJrMlZC?=
 =?utf-8?B?U01SNzhZalJTMTFGVERvWXFyY2U5OEZhSnVoemxRMlM3cGNiZXppMmpvY083?=
 =?utf-8?B?SFpwcFZ0a2YxRktZbEN1ZVNielE0R0dqQ3JkN1p3d01td09zNDBjRzJPU2sr?=
 =?utf-8?B?V3RZS09ISFV5cElGbStVc3diMnYySk1FbUVCNmhyVld2VmNudzY1Uk1xSnBj?=
 =?utf-8?B?ZURaTXkvSXJoZ2M0YTdCNkg2QTZoOFlreDFPNGF4WHFHaW51RnBtSmVYTWlQ?=
 =?utf-8?B?Z2FvVFdlS0YzZnVKU1dNcUtiTWVpWS8wWTdnUlpiNjZOZEp0aDllNTBDdCta?=
 =?utf-8?B?ZWNxVFFXNUg0b2k3TkFEN3NDTXFMWGhhVWoxa2ZqYWNwZy9wa1dPR2pTVFlB?=
 =?utf-8?B?QVhhUmdqaWo0YW5wWHNMWDRCb3FORGN6cEJwZEVoTjd2Umh2eU9wU01Xc2lm?=
 =?utf-8?B?Z20yaDdjYmtscUxiQituM1ZOd21YVW9SNm5HUjJGNExzVnFUdkNRdTkvcEZi?=
 =?utf-8?B?ZWtWU1ZNRzhJWkVab3hrdE01eHJRUFJYYkpUc3h1WEw2RGJFeTdTTUk4YTBV?=
 =?utf-8?B?V1d6K1M0Nm4wMzFMUWpvOTl2NEtGbVRvMnpjSWhheVZHWmIyNUplQkt3YThn?=
 =?utf-8?B?MVVuSXI2OEJwMHVOQ3NhSGl2SlpVck0xeVE2dC9HS2t5QmVIQkQ4YWpCWFVX?=
 =?utf-8?B?ZEJtZ3duWFhuOWIzblB0V2t0SDRZYlEvdkFWTUNrdEhvRW9VWGJUM3hpc3E1?=
 =?utf-8?B?SzVCRG4rOHRNaisybmtEcjdlaWJFaFUya0ZZK1M1di8zM0hlbXlabHg0MEVx?=
 =?utf-8?B?YXNxVFhIQ3ZNa202UitWYTFkWmNMOEVJUEt6WWRqWnA1MXNnNDZ4UTZ0Y1p3?=
 =?utf-8?B?SG1PRS85cUlYWGNGcVBOdXJkNmJLbEp5c3RFUlJ5dFk2M3MrQ1ZwYlpQU2h4?=
 =?utf-8?B?eDl3cm9TbW1DZzFPdjFubWZoU0hZcERFWnNpRkJldnVMTGlITldhSHVKcldD?=
 =?utf-8?B?UTlndkl0RVFoK2VMa05XMnVTRWlaNENsQm0rL3dzS2pZQUtTR05HbkZIM2NU?=
 =?utf-8?B?ZnloR0p0TzI2OWc2S1VHYk5TUFhheWs1SWU2Vm1NdEw0eXlQS054V2pZbFlj?=
 =?utf-8?B?NVhXUHlnYkJtc2VWMDVBRXlEYVRSbWtJamdvMUJYU0RGMHllY1NqRjRickNq?=
 =?utf-8?B?WDdTMEFDM2hxTm1WYUpOcFpuYUJKOTcrWnpQRktKVEdFVzBIZ0o2ZzdaTkox?=
 =?utf-8?B?dHRSVkNnSmx0VVU1dXEzVUxkckc0Y3d5ZGV1YTM2bGF1OWVuRVl6cjFYcnN1?=
 =?utf-8?B?aFlhYVlpODVuZUh3czRYZllYWENoemFmRjBDbjlNU052bitLZk9YWDdPY1gy?=
 =?utf-8?B?VkNVdTFaR25MbnRoTFZqcklxVmNQTHJHQXMrL3cvUm4rR1cxcTdqcy9iSEsr?=
 =?utf-8?B?UWV2REdLUFMyYStqWjRUVWl2bUl1RG5iQW96MmR5R1hDZStzamR5NE51NFZL?=
 =?utf-8?B?WFAxcWJYaGpDYnlMRDRKRGxsQjBKYjVyMlUxU0F2NEwwMHg5azFHamNKRTJy?=
 =?utf-8?B?NGZTTVk2aVo1RUpuakVDTm5xNkhSUVBPMWs1alFqUmpQcnYwcmNLN1N1RUJ2?=
 =?utf-8?B?T1ZJNGNkSkFsNXRXc0ZYS1JDRU51NE55MkhxaUxzRXpKTHNwZDdNaU1mcjdM?=
 =?utf-8?B?QkdFNlVJQy9EdG9JTTFKb0ZmRko2T1laMjFxWDJ1UmQ1eGNWSmVEVTB4YTVE?=
 =?utf-8?B?TVdnMEdTTE5EZWNJZWlxa1pLeDllY1QvWFpkaGtySmh3ZzhIMmFnWVZFMnAz?=
 =?utf-8?B?c090L3VpSlhYSlJ6WkNIa2hjTE1pT0diK3h5VFhiVFpobko3amU0VTFnQXJ6?=
 =?utf-8?B?U2w3RC9OUEU2eGxHQlBneUtrcG5WS2dGd0tQVFlyY2RGZTN4YWNQa1VwSWpi?=
 =?utf-8?Q?Wwnr84p+NumzIOTfWUcPt0H8y?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:38:17.6427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7262eea5-2abc-4793-2fb8-08de30f807fe
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6510

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Plesae find the v7 AccECN case handling patch series, which covers
several excpetional case handling of Accurate ECN spec (RFC9768),
adds new identifiers to be used by CC modules, adds ecn_delta into
rate_sample, and keeps the ACE counter for computation, etc.

This patch series is part of the full AccECN patch series, which is available at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best regards,
Chia-Yu

---
v7:
- Update comments in #3 (Paolo Abeni <pabeni@redhat.com>)
- Update comments and use synack_type TCP_SYNACK_RETRANS and num_timeout in #9. (Paolo Abeni <pabeni@redhat.com>)

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
Chia-Yu Chang (11):
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
 tools/testing/selftests/drivers/net/gro.c     | 81 +++++++++++-----
 16 files changed, 284 insertions(+), 86 deletions(-)

-- 
2.34.1


