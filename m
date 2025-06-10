Return-Path: <linux-kselftest+bounces-34572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F2AAD37EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB27317DF59
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 13:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B372F2DFA55;
	Tue, 10 Jun 2025 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="SlG/nXuD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012071.outbound.protection.outlook.com [52.101.71.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D2F2DCC12;
	Tue, 10 Jun 2025 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560027; cv=fail; b=lDUZbIrJnxPT2eCxvxLt6Reao2LSowvfvsBAC7dZ6kHz4lShEB6gm+nkFiyQ+bH3ubgz3m6gE0F0KcrerAFrbipUoC4zM5k7aoSiY+60plYSStpPg8ARr+FXPuAQsamHeQIvTjkUxK/KjBgWBOKCC80z1Hui6epQdy4M/qHOMTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560027; c=relaxed/simple;
	bh=pIvQKrqrAzaO6ZaHM/KamnmUgdkQzm7uhijSgHZCd7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsvpFiPoAJ0v04xajTyJdZef1deRKAXds+FxMNwVYrCud+5jE0/5nzTFS5OIE1JTbwzErXMDwKHALOOuVjLpkiRFqvAw7n6FsFODJT+PqrvegagnbH2aTdJr8/JsWPXoNLKasBB0Z9H4ST/9cYK5v7m3mx3FeeKqwF/fT1dpedI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=SlG/nXuD; arc=fail smtp.client-ip=52.101.71.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qa7BqNdy7+Co3BliaMCAwFbesNqoHSSebX6sGCn+FzM9k8MAI8nBHRhf/7/xa58d21NLBHIT4qrDhW3mtIVDLPzJcbco5vHwyl+PYqlV3ACy5M/p7XIY/h2ckTqTLSBRJLTcmQAdKHkgAoP/2Wb87fqXGjgOnzxLNDiZElGhwjm8E+eF8C/IX6tMAb64T1+PYzJEnJYo8IlOpx2b6q5M4INrlNbXwDNoSs4a1jNs1hWDDMUV9PRYjgkQ8L5PsLaP3IIQlfl1rtIJqFQ4T6cYg1YAF+iaLt/Our6uX9FhZmZmRTkO5l2cIA7H9sQc9kDM8LQZR5NzxYep96fMj4ZP4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=450prCG4w5S7WbCfR+AtWErzdhVfsAN7wH2RdImx4G0=;
 b=dWrDsF0po4PQqYFncD5XxYEz5AJEYi+jLDVokkVqKPlYQB8ep9xuMNqMmxoev6w2OUXDg1IcvzJ/OaLPZXCtga/IznU4ElvsEljkEqBygJDGG/24/XTO3yBk0vWEMrjrRAyQTkqZ7OREva6GEBwQZ4vUSdPjyqeoHqkYizm/DVRjCGa7FhdChfKzQbEM6a4CKEE+Es4tLoNxp1+dGaNH5oBxeRLejum3Pmjy8P6YdsPN1q1hMciD3ikLjCLRT9/lzetTQvSubmOpElUZXO7ZXglfqB68sKyEvS45L4/T29Se6XvPu1GeS2MDNywicOU5J4Ws+aOzfqIF8yFADyjK1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=450prCG4w5S7WbCfR+AtWErzdhVfsAN7wH2RdImx4G0=;
 b=SlG/nXuD+RRVq99AzsP5NwbWyCuU2hGt/cTY8UIXVpbNclBjJYUIS+rnQTQVuswowhwDHUriJiJ6YGLGSMiQeUVafw8j76S3Cwyc3LOl+ay+7UhIzIf3T7LpgsvdbaR2cU356Z847YDMwN5c/EnyC1wYxyICa8C2NbR49iF9yzCYieieenaurXman95VB7b+3P6aNi95AVaRefnngOp2Zo8y/eTAMUcZH9M5/ialjrmhatUhWm3+n/KjcKGpguEEg39eKIpodljL+syupLW3RaXCb6OXmOE1DNfQt8bqTLShq3Cn9Pq5ZSwMGmHZJLR/IJsR1RS0/4La4nCB6aAdig==
Received: from CWLP265CA0375.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5e::27)
 by DU0PR07MB9062.eurprd07.prod.outlook.com (2603:10a6:10:409::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Tue, 10 Jun
 2025 12:53:37 +0000
Received: from AMS0EPF00000191.eurprd05.prod.outlook.com
 (2603:10a6:401:5e:cafe::35) by CWLP265CA0375.outlook.office365.com
 (2603:10a6:401:5e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 12:53:37 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF00000191.mail.protection.outlook.com (10.167.16.216) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 12:53:36 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 2D4A3200A2;
	Tue, 10 Jun 2025 15:53:35 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
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
Subject: [PATCH v8 net-next 10/15] tcp: accecn: AccECN option send control
Date: Tue, 10 Jun 2025 14:53:09 +0200
Message-Id: <20250610125314.18557-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000191:EE_|DU0PR07MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bda4d6c-7b39-49b2-af4a-08dda81dd0e0
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZFpzZlhjRG1Qd1owWkJ0djdhRkJNbElMREQ0UXlGOGpsVlJoakoxVzFTS0pi?=
 =?utf-8?B?RXFJLzR2cExmbHJzUVBvRnJmdkxnSmVvMmNBc3IvVEpYYXlNUjFlZG9zbm1C?=
 =?utf-8?B?eGFTNE5vekc1anhIQXpJVFVKSFdoWks2N3Yvcy84UDNiZFBHVUJHbDlGb0M0?=
 =?utf-8?B?WE9lN2ZmeXNFVFBsUXdvUGNObUovZjlFRHdDOFUyVWVndjdwMk5IeGQ0d2Np?=
 =?utf-8?B?R3NwdHpveTBrdDF1enBIUHNkVzQ2UWRNVFpOVHppTnh2YjZkVFFmSndJa09h?=
 =?utf-8?B?aEoxWGtGYUl2VTBmOFhHbDlCcjhOUVRoT1J3aWNrSEVSaTkyYW5HV09RMEN3?=
 =?utf-8?B?Ry9teUJ2Wm1ra28zVk1PM053MW42bExmcFU5Uy9FMHNoY3QyTkJsSXNha2lR?=
 =?utf-8?B?b244L1NXY0pyYTNVbDdUbmVEYmFSa05HRWdrZVJFK2p6QlZ1L2ZsWFNnYVA0?=
 =?utf-8?B?TnNSeWZnamJkVjUrbEwzT0tXRHl5ME5YL2ptSU9vNk1SSXFEb3UwaGlvZVMz?=
 =?utf-8?B?RmFJSGMwd2JLYkhDS09IUVRZZnpLK1pVRVV6QWdRL2gvSS9GSmw3UnRPWFNh?=
 =?utf-8?B?cTZFMDlla1pjSTVuMHYrbXpOZTlrc3hPano0T2hFRkRDeSt0QlRCY2NwSjFY?=
 =?utf-8?B?QnJId280RFY1bWl3dW1qRmdlZ2YzWlk3d3UzUWJqRi8rOHR5WUpkUllNUC9p?=
 =?utf-8?B?QlJjbGtORzlpc3pMSVpRbHFMRVN3eHpoNWVsQjhXWmRGQWkzdFdpTlNETmpm?=
 =?utf-8?B?QXVEQlNVdnVmVjFqZ0Q4R3UrbGlkKzgvUDJ3Qm9jeHpjYkRkWTlxZzZDcU9V?=
 =?utf-8?B?a1NjNFIzQzFRaXplV1QrSWs5L0dpdmorTWtCd2EyQ3JXVmpXZjRHTEFhT3RD?=
 =?utf-8?B?dzZzTmJCdFRsUjEzQkZtQ3oxV25GMkdTaThOeE5OUkM2aFVCR3Bjd1NOMk9C?=
 =?utf-8?B?MXRTTXk1NGtncXdWcGs3QVh4Mk5CMWl2SzdnUFhaaXRmYzJ3QllMeWh1OEVI?=
 =?utf-8?B?endSQUlZeWpPd1hpTjM5WURSMEtySjM1MjlQalR1ejJDKzJqMjVPSVc4V1Uz?=
 =?utf-8?B?RGVBMnhXUVpsckxNM3NkbjlHTWFZL3VVRk4rUzhwVDhtaGVENVBHL094a0dP?=
 =?utf-8?B?Q1BXU0ZOV1k3QnB0SlpkZzBOSmczQzBQaWo5SEptZEpwbHE4N2h1RmxVQ1hB?=
 =?utf-8?B?bjFUU3Qwdkd4N2FFb1FzeGVjdGcvOFY3VTVGVEhRT1poS0tlS3o3MzBtQmhi?=
 =?utf-8?B?c1dCVGJ5Qi9oVUhrb28vd0toT2lFUXhWMjBjRXVZZjNLOThJUWY3ZlJOTEFN?=
 =?utf-8?B?QTdhTlR3WFNrWU51VUxOdDQwZlhQNUExY2ttUzR4M2ZlU3c0VzVZUE1yL1dH?=
 =?utf-8?B?NmNrd24yUFhKK3pkdmJWQlNwU1g0SFU3ODFwWTJMZlAvbTh4cUgrTTM0Ulgw?=
 =?utf-8?B?MXdoSWVPVEk5NXdOK2FVZ05BcGcrMmtpbzU5bHMxd2xuREhTYmZaYUp5YXFK?=
 =?utf-8?B?VVduK3ZEMzhlejFMOS81b0h1Ni90eFh2ZjJGS2NmaFF5cGRVUGZzeGI2cGdP?=
 =?utf-8?B?NExNMkd2VU1TeGE3b1JqUHpzYXNMVGRKSWN2dzgrUTQ1cXZCcER4ZUVWc1Nl?=
 =?utf-8?B?WlViR1pNQ3FzS2JzeXJtSjI5dTMydXZnTTl3VER5Q1orWVdvOGZ2TWtWUVNG?=
 =?utf-8?B?MUkwYUgybFFoRWcwNzk2ektYbnQyWWNKRlBlVEVHT3dHUWRhbkpMci9IRnNZ?=
 =?utf-8?B?RXA0NUU4SkNqNStuRDdJWTZoZXE5YUhhWG16aUxRc044UmgwZHl3TUVWTGl4?=
 =?utf-8?B?a1NyQ3hSZk9aL1BPTXE5Mk5HU3E5c3REOEt2NEZLL1ZPKzZxalhCVHdkNGww?=
 =?utf-8?B?S0h2ZG9FWVlwbXR4emZkNFJMMG9zMEM3THlYN0NxbzZwbjlCYnJuR0o0WUR0?=
 =?utf-8?B?eFBoeFcwSFN2Smd2WGRDRjJMVnhCM3JUcFNzSjdFUEVLMHc1SHBUVnFXak51?=
 =?utf-8?B?eXNtOGF2SENmTVNDWXgrNFBkTTFJYi9mNGlBY3pYajUrcU52WVBaSzYwMG9O?=
 =?utf-8?B?TU9HSVMyR1ZZZWlrLy9UVXlhK2pReVRrazVBUT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:53:36.6338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bda4d6c-7b39-49b2-af4a-08dda81dd0e0
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9062

From: Ilpo Järvinen <ij@kernel.org>

Instead of sending the option in every ACK, limit sending to
those ACKs where the option is necessary:
- Handshake
- "Change-triggered ACK" + the ACK following it. The
  2nd ACK is necessary to unambiguously indicate which
  of the ECN byte counters in increasing. The first
  ACK has two counters increasing due to the ecnfield
  edge.
- ACKs with CE to allow CEP delta validations to take
  advantage of the option.
- Force option to be sent every at least once per 2^22
  bytes. The check is done using the bit edges of the
  byte counters (avoids need for extra variables).
- AccECN option beacon to send a few times per RTT even if
  nothing in the ECN state requires that. The default is 3
  times per RTT, and its period can be set via
  sysctl_tcp_ecn_option_beacon.

Below are the pahole outcomes before and after this patch,
in which the group size of tcp_sock_write_tx is increased
from 89 to 97 due to the new u64 accecn_opt_tstamp member:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u64                        tcp_wstamp_ns;        /*  2552     8 */
    struct list_head           tsorted_sent_queue;   /*  2560    16 */

    [...]
    __cacheline_group_end__tcp_sock_write_tx[0];     /*  2585     0 */
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2585     0 */
    u8                         nonagle:4;            /*  2585: 0  1 */
    u8                         rate_app_limited:1;   /*  2585: 4  1 */
    /* XXX 3 bits hole, try to pack */

    /* Force alignment to the next boundary: */
    u8                         :0;
    u8                         received_ce_pending:4;/*  2586: 0  1 */
    u8                         unused2:4;            /*  2586: 4  1 */
    u8                         accecn_minlen:2;      /*  2587: 0  1 */
    u8                         est_ecnfield:2;       /*  2587: 2  1 */
    u8                         unused3:4;            /*  2587: 4  1 */

    [...]
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2692     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 174 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u64                        tcp_wstamp_ns;        /*  2552     8 */
    u64                        accecn_opt_tstamp;    /*  2560     8 */
    struct list_head           tsorted_sent_queue;   /*  2568    16 */

    [...]
    __cacheline_group_end__tcp_sock_write_tx[0];     /*  2593     0 */
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2593     0 */
    u8                         nonagle:4;            /*  2593: 0  1 */
    u8                         rate_app_limited:1;   /*  2593: 4  1 */
    /* XXX 3 bits hole, try to pack */

    /* Force alignment to the next boundary: */
    u8                         :0;
    u8                         received_ce_pending:4;/*  2594: 0  1 */
    u8                         unused2:4;            /*  2594: 4  1 */
    u8                         accecn_minlen:2;      /*  2595: 0  1 */
    u8                         est_ecnfield:2;       /*  2595: 2  1 */
    u8                         accecn_opt_demand:2;  /*  2595: 4  1 */
    u8                         prev_ecnfield:2;      /*  2595: 6  1 */

    [...]
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2700     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 176 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v8:
- Add new helper function tcp_accecn_opt_demand_min()
- Remove white space only change
---
 .../networking/net_cachelines/tcp_sock.rst    |  3 ++
 include/linux/tcp.h                           |  4 +-
 include/net/netns/ipv4.h                      |  1 +
 include/net/tcp.h                             |  5 +++
 net/ipv4/sysctl_net_ipv4.c                    |  9 +++++
 net/ipv4/tcp.c                                |  5 ++-
 net/ipv4/tcp_input.c                          | 40 ++++++++++++++++++-
 net/ipv4/tcp_ipv4.c                           |  1 +
 net/ipv4/tcp_minisocks.c                      |  2 +
 net/ipv4/tcp_output.c                         | 28 ++++++++++++-
 10 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index c74f939f32cc..af76d4f9b33a 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -110,6 +110,9 @@ u8:2                          syn_ect_rcv             read_mostly         read_w
 u8:1                          wait_third_ack                              read_write
 u8:2                          accecn_minlen           write_mostly        read_write
 u8:2                          est_ecnfield                                read_write
+u8:2                          accecn_opt_demand       read_mostly         read_write
+u8:2                          prev_ecnfield                               read_write
+u64                           accecn_opt_tstamp       read_write
 u8:4                          accecn_fail_mode
 u32                           lost                                        read_mostly         tcp_ack
 u32                           app_limited             read_write          read_mostly         tcp_rate_check_app_limited,tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index f2fefe6b3643..5d3743ef5d91 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -276,6 +276,7 @@ struct tcp_sock {
 	u32	mdev_us;	/* medium deviation			*/
 	u32	rtt_seq;	/* sequence number to update rttvar	*/
 	u64	tcp_wstamp_ns;	/* departure time for next sent data packet */
+	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */
 	struct list_head tsorted_sent_queue; /* time-sorted sent but un-SACKed skbs */
 	struct sk_buff *highest_sack;   /* skb just after the highest
 					 * skb with SACKed bit set
@@ -297,7 +298,8 @@ struct tcp_sock {
 		unused2:4;
 	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
 		est_ecnfield:2,/* ECN field for AccECN delivered estimates */
-		unused3:4;
+		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
+		prev_ecnfield:2; /* ECN bits from the previous segment */
 	__be32	pred_flags;
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 	u64	tcp_mstamp;	/* most recent packet received/sent */
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 4569a9ef4fb8..ff8b5b56ad00 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -149,6 +149,7 @@ struct netns_ipv4 {
 
 	u8 sysctl_tcp_ecn;
 	u8 sysctl_tcp_ecn_option;
+	u8 sysctl_tcp_ecn_option_beacon;
 	u8 sysctl_tcp_ecn_fallback;
 
 	u8 sysctl_ip_default_ttl;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 88643eb9bbcc..96cd8d99ff6f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -91,6 +91,9 @@ void tcp_time_wait(struct sock *sk, int state, int timeo);
 /* Maximal number of window scale according to RFC1323 */
 #define TCP_MAX_WSCALE		14U
 
+/* Default sending frequency of accurate ECN option per RTT */
+#define TCP_ECN_OPTION_BEACON	3
+
 /* urg_data states */
 #define TCP_URG_VALID	0x0100
 #define TCP_URG_NOTYET	0x0200
@@ -477,6 +480,7 @@ static inline int tcp_accecn_extract_syn_ect(u8 ace)
 bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect);
 void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
 			  u8 syn_ect_snt);
+void tcp_accecn_opt_demand_min(struct sock *sk, u8 opt_demand_min);
 void tcp_ecn_received_counters_payload(struct sock *sk,
 				       const struct sk_buff *skb);
 void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
@@ -1090,6 +1094,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
 	tp->accecn_minlen = 0;
+	tp->accecn_opt_demand = 0;
 	tp->est_ecnfield = 0;
 }
 
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 1d7fd86ca7b9..169a393374b3 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -740,6 +740,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
+	{
+		.procname	= "tcp_ecn_option_beacon",
+		.data		= &init_net.ipv4.sysctl_tcp_ecn_option_beacon,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_THREE,
+	},
 	{
 		.procname	= "tcp_ecn_fallback",
 		.data		= &init_net.ipv4.sysctl_tcp_ecn_fallback,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b0574b2a2e81..2514eef12dcd 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3396,6 +3396,8 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->wait_third_ack = 0;
 	tp->accecn_fail_mode = 0;
 	tcp_accecn_init_counters(tp);
+	tp->prev_ecnfield = 0;
+	tp->accecn_opt_tstamp = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5115,11 +5117,12 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, lsndtime);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, mdev_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tcp_wstamp_ns);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, accecn_opt_tstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, rtt_seq);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tsorted_sent_queue);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, highest_sack);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, ecn_flags);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 89);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 97);
 
 	/* TXRX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, pred_flags);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c0898b2a2394..37c4c7995934 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -487,6 +487,7 @@ static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
 	default:
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
+		tp->accecn_opt_demand = 2;
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
@@ -507,6 +508,7 @@ static void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 		} else {
 			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
 					  INET_ECN_MASK;
+			tp->prev_ecnfield = tp->syn_ect_rcv;
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
@@ -6299,6 +6301,15 @@ void tcp_ecn_received_counters_payload(struct sock *sk,
 	tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
 }
 
+void tcp_accecn_opt_demand_min(struct sock *sk, u8 opt_demand_min)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	u8 opt_demand;
+
+	opt_demand = max_t(u8, opt_demand_min, tp->accecn_opt_demand);
+	tp->accecn_opt_demand = opt_demand;
+}
+
 /* Updates Accurate ECN received counters from the received IP ECN field */
 void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 			       u32 payload_len)
@@ -6306,6 +6317,7 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool ecn_edge;
 
 	if (!INET_ECN_is_not_ect(ecnfield)) {
 		u32 pcount = is_ce * max_t(u16, 1, skb_shinfo(skb)->gso_segs);
@@ -6319,9 +6331,33 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 
 		if (payload_len > 0) {
 			u8 minlen = tcp_ecnfield_to_accecn_optfield(ecnfield);
+			u32 oldbytes = tp->received_ecn_bytes[ecnfield - 1];
+
 			tp->received_ecn_bytes[ecnfield - 1] += payload_len;
 			tp->accecn_minlen = max_t(u8, tp->accecn_minlen,
 						  minlen);
+
+			/* Demand AccECN option at least every 2^22 bytes to
+			 * avoid overflowing the ECN byte counters.
+			 */
+			if ((tp->received_ecn_bytes[ecnfield - 1] ^ oldbytes) &
+			    ~((1 << 22) - 1)) {
+				tcp_accecn_opt_demand_min(sk, 1);
+			}
+		}
+	}
+
+	ecn_edge = tp->prev_ecnfield != ecnfield;
+	if (ecn_edge || is_ce) {
+		tp->prev_ecnfield = ecnfield;
+		/* Demand Accurate ECN change-triggered ACKs. Two ACK are
+		 * demanded to indicate unambiguously the ecnfield value
+		 * in the latter ACK.
+		 */
+		if (tcp_ecn_mode_accecn(tp)) {
+			if (ecn_edge)
+				inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
+			tp->accecn_opt_demand = 2;
 		}
 	}
 }
@@ -6454,8 +6490,10 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	 * RFC 5961 4.2 : Send a challenge ack
 	 */
 	if (th->syn) {
-		if (tcp_ecn_mode_accecn(tp))
+		if (tcp_ecn_mode_accecn(tp)) {
 			accecn_reflector = true;
+			tcp_accecn_opt_demand_min(sk, 1);
+		}
 		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
 		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
 		    TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 387cf8994202..7d4660378378 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3451,6 +3451,7 @@ static int __net_init tcp_sk_init(struct net *net)
 {
 	net->ipv4.sysctl_tcp_ecn = TCP_ECN_IN_ECN_OUT_NOECN;
 	net->ipv4.sysctl_tcp_ecn_option = TCP_ECN_OPTION_FULL;
+	net->ipv4.sysctl_tcp_ecn_option_beacon = TCP_ECN_OPTION_BEACON;
 	net->ipv4.sysctl_tcp_ecn_fallback = 1;
 
 	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index f1e698c323f3..5b0f703f23a5 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -500,6 +500,8 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->prev_ecnfield = treq->syn_ect_rcv;
+		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 8869e49c07ec..3de6641c776e 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -807,8 +807,12 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			*ptr++ = htonl(((e0b & 0xffffff) << 8) |
 				       TCPOPT_NOP);
 		}
-		if (tp)
+		if (tp) {
 			tp->accecn_minlen = 0;
+			tp->accecn_opt_tstamp = tp->tcp_mstamp;
+			if (tp->accecn_opt_demand)
+				tp->accecn_opt_demand--;
+		}
 	}
 
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
@@ -986,6 +990,18 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 	return size;
 }
 
+static bool tcp_accecn_option_beacon_check(const struct sock *sk)
+{
+	const struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!sock_net(sk)->ipv4.sysctl_tcp_ecn_option_beacon)
+		return false;
+
+	return tcp_stamp_us_delta(tp->tcp_mstamp, tp->accecn_opt_tstamp) *
+	       sock_net(sk)->ipv4.sysctl_tcp_ecn_option_beacon >=
+	       (tp->srtt_us >> 3);
+}
+
 /* Compute TCP options for SYN packets. This is not the final
  * network wire format yet.
  */
@@ -1240,7 +1256,10 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	}
 
 	if (tcp_ecn_mode_accecn(tp) &&
-	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
+	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
+	    (sock_net(sk)->ipv4.sysctl_tcp_ecn_option >= TCP_ECN_OPTION_FULL ||
+	     tp->accecn_opt_demand ||
+	     tcp_accecn_option_beacon_check(sk))) {
 		int saving = opts->num_sack_blocks > 0 ? 2 : 0;
 		int remaining = MAX_TCP_OPTION_SPACE - size;
 
@@ -2962,6 +2981,11 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 	sent_pkts = 0;
 
 	tcp_mstamp_refresh(tp);
+
+	/* AccECN option beacon depends on mstamp, it may change mss */
+	if (tcp_ecn_mode_accecn(tp) && tcp_accecn_option_beacon_check(sk))
+		mss_now = tcp_current_mss(sk);
+
 	if (!push_one) {
 		/* Do MTU probing. */
 		result = tcp_mtu_probe(sk);
-- 
2.34.1


