Return-Path: <linux-kselftest+bounces-32780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4065AB1ECC
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8402CA00039
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB1225F7B3;
	Fri,  9 May 2025 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="EuwDIpyB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615121CC4E;
	Fri,  9 May 2025 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746825509; cv=fail; b=nJAao49SzIwtCM0stenEpuuXko/KJhEYXlzuZU7Log3n6GOq2EBVTTkiMGU/64VlYnjDmCPi2Fp726ZlKk099mcz5qKd5frBFvveQWu4i8lvUKX8L1tUUBgMw4ODQpvN25Btqs/kRxADjjUDxpRo06+kRT7VZXOBIBnWYWiEfFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746825509; c=relaxed/simple;
	bh=CC1pNGvT0PR8+Rrcyr9+7N5XBuecThYeyBd1g5x81fA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=S4DGZhtR83REF66V0W9VyFLQ2bx531cMJAvWWgF/V7cY29+WzCS+kjeyEFiBl3YB3i2/FR5hfXPK33FhWQ6t6mKwQxbHQzw+UeGAsBCUnOLGhNbO82cZ8FWDm6fYtoEbCoWZy87rWOpwP3yC+frfeSqdHycVmAqBAC4/+jv1x7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=EuwDIpyB; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KspZkMx45OQpiAwCeVaNCSC0aMkLnVOUAl6li7wzbhcIlzLL2QJRdRizgQQllelOtJom/YFhCtbO939WR0HqdpnZBC9Ck4jzJ4yrJDPNxwNZb8zs5N07ix0TEwLoxdKPDrvbApZzShB0PwM7Olj9bUcpMK+sr4ws5Wfm1YXUyzUfe6wlnjy4l0QbHnVsSF0A36CdhLfFcEOZQjz/QntvFTEjpVCIya5W00LBuTf4uvIimT0/fQ0q8rEnPSY1ELKzl4Ah1syf2lQOJ4ypcmxpvMT1I4H1K5Lkm1DSWqcX4sKu0yQI0TRtnekJQVsOyssQet7VIfyvp+SR2wBL+ckjgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Rv0bACpz/5EfX9APXHynCu4JVZHOLp97JtYwMCvkf4=;
 b=S1g2E7h+I5/N5yQZVEpjlbi2MAD27xovh7gjnlmeMDw9EOZ7IgT0HDRVOODEqRLwKgrV+ayu8oTBalsmzDIPSAe3nd+icY4z+oBeqZIfU4qlZrZk0VlfZy7uQ0yb70BpYGxDwAp+XcSpaSsKRVPzcIxeqh4UjhIF0O7qhInibjYRSL8p6IQz5Tc4xBs3gtkenWqWoZKXrmaMaRI6RYzt0vwO4rMC3AMvzYbsCyn3jOB22jecxIZ49gzSzI2/V7g+x+qCu/3p98KCGPN2bzMW4slf4i0v6n5zzC5EZyTei2RdSKzijwHRIHB83Fn9xPvGJ7muHVA933T6mcwSxFsh+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Rv0bACpz/5EfX9APXHynCu4JVZHOLp97JtYwMCvkf4=;
 b=EuwDIpyBkAg5BWQomWS7XzmHKFp264O4u53bjW4HPDBIa9ciKXG+VLIHYoq/6HvQoE8kNIfvvGz70cAxPf2i1EEU3L5GkdzknhNugXvoVoJhzxhP0vlpa+rHruzg6YXvTN0vRTRBuWcJqzFQvTAAe+lBjS9FS7Iz35JPWORMd1GDU/MXS+LK8xc9eVzjMElGgsV1uJVp2haRQFx7Q56venUB8FKmr5UGprcnPWYm3e38Sz2+t7C7CCoYKxF5xN9+8VOOCwDY0yfTwKOFf7qbRNW00gnzp7wRWqER9KzZ7BtagnMC838kEOOeHs94kBspT+NAcrermblPfFsBkkrrDQ==
Received: from DUZPR01CA0210.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::24) by AS8PR07MB7064.eurprd07.prod.outlook.com
 (2603:10a6:20b:23a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 21:18:23 +0000
Received: from DU6PEPF0000A7DE.eurprd02.prod.outlook.com
 (2603:10a6:10:4b6:cafe::c6) by DUZPR01CA0210.outlook.office365.com
 (2603:10a6:10:4b6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Fri,
 9 May 2025 21:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU6PEPF0000A7DE.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18 via
 Frontend Transport; Fri, 9 May 2025 21:18:23 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id E5BF4200A3;
	Sat, 10 May 2025 00:18:21 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
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
Subject: [PATCH v6 net-next 00/15] AccECN protocol patch series
Date: Fri,  9 May 2025 23:18:05 +0200
Message-Id: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DE:EE_|AS8PR07MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: f509ed22-a62e-4076-0e35-08dd8f3f07e9
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NFlmQlJHblhBcGZNaUNZdXZibjluRkg3RUZrS0wzVGV3Wm9mTlBJMDZzUXhU?=
 =?utf-8?B?d0oyTjZPN3YvbnZJZTBsZ1k2bFVjeGpSQXpDQ1A2bkJ0VmJ6SlM4bDBoQ1ly?=
 =?utf-8?B?M3NqZzcySWphU2NQa0JiQmdHSHZjTzNUS3RuYmtzRjJmQmJXSEExU0dPZlpW?=
 =?utf-8?B?ODVnd3JHQytvdXNXRzFlM0Z5bU12SVBjcWdQc3Z0YWQrMkozQ2VMWEsydXF5?=
 =?utf-8?B?bTFhQWNtNktTak1aZThrbHJNUkNFUHZUL0xHWnk2aXNVTnBjd0RrZHRLZ25t?=
 =?utf-8?B?ckpNMlc0QnBibVExdHRHTCtpc3ZVOEMzZE9YaEN2bWJPOEp0MzRFUndJVnBW?=
 =?utf-8?B?eW9LeElycDhxNjBsYlJieTZVdFpjdmVsKy9WMkdkcjFmWmwraUkzN0h2L2hT?=
 =?utf-8?B?Wk1jV3l2V2o3Y25xSXQ5YjdOVUtZblFZRVRJSFQvWUpZTEpKdVMyMmZIempa?=
 =?utf-8?B?VjhPOVJzZkRJazhMcHpHY2hVYVcrdEpkZlFkcXBWSUF0NWhTeUpCdm9KbmNS?=
 =?utf-8?B?a1VlYjRBcXFUdFJNa1dTU1ZLeXpSYVBwNXh3T0pKYnB4eGl4ZkVLTm9tM2U1?=
 =?utf-8?B?OFFTTVpLNno3RW9BR0VJczkyZ2JDOEkzU2FyUWV6RG5EQWFEVVh3YmlkaEQw?=
 =?utf-8?B?Tk93eTRQRUVNTnNUK1BFWlNHd0EwbTJOUU1nSkoxajJvazFjRytqSnlsbzRk?=
 =?utf-8?B?WU13VVRVSFpzWUIyd2NsZFJheEZRRDJCVk5CL2tCTEh6N1dXcXRoamRJZWlY?=
 =?utf-8?B?UDhmb3dwekI2WEwxN3N4aHU1THcvQUhsMkZPMHVkWCtQM2wxRGRnbHlTZ2NM?=
 =?utf-8?B?SWM1YndydkJmYmY0a1d0ODExVTQ3L2c5WG9lVlZuS2ZXZUt4MXBCbzhDa29t?=
 =?utf-8?B?NW9XM1ZwMEhsSXJ2Nk52NEhmRG13eW0rbVJGM1lCTGJMSDhEYzJPeVVqUjlG?=
 =?utf-8?B?QWowbmNCNEh2eWlNYkppMlMxaVV3Rjk1R0R0MGV3TXJIR3pZMnNxQnlYWWRF?=
 =?utf-8?B?UFl3NjNZeHlYS1Z4b2pySmdZMDJRNmdOUG5Ca0VQVllKMUx4eTkxN3B5ZVFw?=
 =?utf-8?B?N2twZTY3S0tJczY5aSthSXpxMWlJZHdvTmtoaG1wdGFISGNuYzQ2d0hrcTNB?=
 =?utf-8?B?TVRFZldodHVGY0FRTWFieVdFTU1RZEprVE1KYlllb0NwZ3krYXZFWXFDU3FR?=
 =?utf-8?B?dWF0bXM1c0RoS0VGL2pTQUZaaTl2RVg2dTZjVVI5ZnRncTVGZUgyM21Zajky?=
 =?utf-8?B?L2Z1L1U2YjhVVW40dlVUbE8zcGZPdytSWVk1b2hrb211SUFkYjBTM1kyS2JP?=
 =?utf-8?B?bGxtbHNMb3lhOGhaQy94RE1HdlJxSE14cnIwVlRXK0k0YW51QitZQWlkZVBI?=
 =?utf-8?B?aExWQzlSKytKZ3hPSFNVTDlVNzRUQzZBek03cUx6K2NudnVRcnIvQVkrRXhV?=
 =?utf-8?B?UnhRUzFha1J5REdWZlgveFkrbTJ6R0tDeHREdjNqaC90d1BTQXFJWVFZa1R3?=
 =?utf-8?B?cHA2eUd3anh5UldKZEJKRGUwSEhYYnQwcmNZZERBcExseVNWVzVxemNVQStK?=
 =?utf-8?B?RXpqTGVjMlN3RFROZDJqMWxOaWhQQTJNMUlUTjB2QXJuOEZRejN2ZWsycWV3?=
 =?utf-8?B?c0hFR3NPQ1ErbVBOQkR6emVaQWZEb3BpZ29YR3dyYzJKdVFFTVVaTFZvZEtn?=
 =?utf-8?B?Z2dZcUd5SnE0NTdGME1mR2gzQ2JOK3dlWTlvRDRQdGxHVmVKV08wOVkyYXMx?=
 =?utf-8?B?NWphT0VIV3lHaHJQUEJ3TEtZNW9mL3dLOGNBQm50c0tJSUVhZSsrYm5RcmZB?=
 =?utf-8?B?UjNQaVNTODM1dGRuQkFiZTZMMFhVNkpwdCtNUWtkWHdIam9xRGFadzRXTEJv?=
 =?utf-8?B?SW54SURBbzhzbmRrQVFFQVpiNUVnb2xhQ0hFV2xoVHp5VW1BMFFUdDFRYk1N?=
 =?utf-8?B?UndodkludlJBaXpMQXYyVHJxb1NoRU9yRHRLVGVOZVlpVGxkcm43clBCV2ps?=
 =?utf-8?B?b3cwMlFoK2QycTdFc3lDZldWZXZ0TTBRSk9VUnczdVpZMFEzUFlwNExlZzRy?=
 =?utf-8?B?M1pjVyttSmJMTmJnNW1FVzJaYVdJOGh4QkJ3Zz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:18:23.4054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f509ed22-a62e-4076-0e35-08dd8f3f07e9
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7064

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v6:

v5 (09-May-2025)
- Add #3 to utilize exisintg holes of tcp_sock_write_txrx group for later patches (#4, #9, #10) with new u8 members (Paolo Abeni <pabeni@redhat.com>)
- Add pahole outcomes before and after commit in #4, #5, #6, #9, #10, #15 (Paolo Abeni <pabeni@redhat.com>)
- Define new helper function tcp_send_ack_reflect_ect() for sending ACK with reflected ECT in #5 (Paolo Abeni <pabeni@redhat.com>)
- Add comments for function tcp_ecn_rcv_synack() in #5 (Paolo Abeni <pabeni@redhat.com>)
- Add enum/define to be used by sysctl_tcp_ecn in #5, sysctl_tcp_ecn_option in #9, and sysctl_tcp_ecn_option_beacon in #10 (Paolo Abeni <pabeni@redhat.com>)
- Move accecn_fail_mode and saw_accecn_opt in #5 and #11 to use exisintg holes of tcp_sock (Paolo Abeni <pabeni@redhat.com>)
- Change data type of new members of tcp_request_sock and move them to the end of struct in #5 and #11 (Paolo Abeni <pabeni@redhat.com>)
- Move new members of tcp_info to the end of struct in #6 (Paolo Abeni <pabeni@redhat.com>)
- Merge previous #7 into #9 (Paolo Abeni <pabeni@redhat.com>)
- Mask ecnfield with INET_ECN_MASK to remove WARN_ONCE in #9 (Paolo Abeni <pabeni@redhat.com>)
- Reduce the indentation levels for reabability in #9 and #10 (Paolo Abeni <pabeni@redhat.com>)
- Move delivered_ecn_bytes to the RX group in #9, accecn_opt_tstamp to the TX group in #10, pkts_acked_ewma to the RX group in #15 (Paolo Abeni <pabeni@redhat.com>) 
- Add changes in Documentation/networking/net_cachelines/tcp_sock.rst for new tcp_sock members in #3, #5, #6, #9, #10, #15

v5 (22-Apr-2025)
- Further fix for 32-bit ARM alignment in tcp.c (Simon Horman <horms@kernel.org>)

v4 (18-Apr-2025)
- Fix 32-bit ARM assertion for alignment requirement (Simon Horman <horms@kernel.org>)

v3 (14-Apr-2025)
- Fix patch apply issue in v2 (Jakub Kicinski <kuba@kernel.org>)

v2 (18-Mar-2025)
- Add one missing patch from the previous AccECN protocol preparation patch series to this patch series.

The full patch series can be found in
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

The Accurate ECN draft can be found in
https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28

Best regards,
Chia-Yu

Chia-Yu Chang (2):
  tcp: reorganize tcp_sock_write_txrx group for variables later
  tcp: accecn: AccECN option failure handling

Ilpo Järvinen (13):
  tcp: reorganize SYN ECN code
  tcp: fast path functions later
  tcp: AccECN core
  tcp: accecn: AccECN negotiation
  tcp: accecn: add AccECN rx byte counters
  tcp: accecn: AccECN needs to know delivered bytes
  tcp: sack option handling improvements
  tcp: accecn: AccECN option
  tcp: accecn: AccECN option send control
  tcp: accecn: AccECN option ceb/cep heuristic
  tcp: accecn: AccECN ACE field multi-wrap heuristic
  tcp: accecn: try to fit AccECN option with SACK
  tcp: try to avoid safer when ACKs are thinned

 .../networking/net_cachelines/tcp_sock.rst    |  14 +
 include/linux/tcp.h                           |  34 +-
 include/net/netns/ipv4.h                      |   2 +
 include/net/tcp.h                             | 221 ++++++-
 include/uapi/linux/tcp.h                      |   7 +
 net/ipv4/syncookies.c                         |   3 +
 net/ipv4/sysctl_net_ipv4.c                    |  19 +
 net/ipv4/tcp.c                                |  30 +-
 net/ipv4/tcp_input.c                          | 608 +++++++++++++++++-
 net/ipv4/tcp_ipv4.c                           |   7 +-
 net/ipv4/tcp_minisocks.c                      |  92 ++-
 net/ipv4/tcp_output.c                         | 297 ++++++++-
 net/ipv6/syncookies.c                         |   1 +
 net/ipv6/tcp_ipv6.c                           |   1 +
 14 files changed, 1237 insertions(+), 99 deletions(-)

-- 
2.34.1


