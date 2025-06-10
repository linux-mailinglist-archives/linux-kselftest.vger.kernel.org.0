Return-Path: <linux-kselftest+bounces-34566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 402E1AD37BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EABD1672C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 12:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89A72C031F;
	Tue, 10 Jun 2025 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="GZ4ztMxC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FD42BF3F3;
	Tue, 10 Jun 2025 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560011; cv=fail; b=i2rTZksnxHPi9bVOw0KVxM3ZoQiucZHixnLmDZ+r0lkA6tvISNFj173tfRVxlPbfjXRWLprC+G12x80rmzw4/WYtBH9I71LtVxozrM1D5aUHyVdluQJutx4gWwIrotN4SAg0dIABNe5/grQy/XoaF+b+2JBuWgYykBN6dHh/+0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560011; c=relaxed/simple;
	bh=cpR1V08F/KF12bPTlPpXcXvqWSHXIfoJL2pzMqQn2EI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUm7iyt27OvFkO2Ku22zV+cVGCK1KfqOOls80mHJnBnMaZeckZUM4DSN4iDZXtGXqmjpYMxXXUVTWI/OLR7ZWS4wsFO9uSMeyVU8kZ7TLg6hufWiPyRjhu0VTxePKezFo+OGI1vZzC1mspWwibWDlAujuqncdQWo4165oRTYcUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=GZ4ztMxC; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aToRSOG1jBUuLHn6LxPunXm6VNI/FUqn2tsFzJhuXw507xjfA9sNOlX17H9TDmOehXZX/NNH4C3pG3T2RP9qABICW3bRnOQ3aC0TWcHx+0D9FC7WH7kwi+/4DCD1wL0UM/Sjr+n7bZmltx0brfZ/DS5SBd8Q9k1bYv1mcRraIUyBj89pHxl42uXjExLZRTC9Wo/+76LpN9AIqjTDe7eSf/PjE1G0xpJ0qu4enrDd0LpHizbL/Z8Iamy7Ivr2Nj6oJKZl184UXkcnqCOJ1GUtVEudsPaI2b8MyimVJR8/zHGoUepl+K4HAvQTIQBhOwTKTcDr3Msr1X2EYI0YulrLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeCqd/VY4OOlpQd/p6Y4Uzjyff+gPitq7IVx9BdcmNs=;
 b=kua/qXaBwIqFHHo1iFTL2xive82Yz4x6El+Dii3eiZ24ABZcMT0R9BYEZJjJiodfDhBxIcuFThLkEEaqrJqexijZQShLMPpdh9fJgTRIBAmu5HMTFHamzOvNuve0D/XbxOslGCgewAvfPsPCfSVycuYPAMoml8U8pIZbaFNUls3RGfqDqs62R6wVwQZ9eEKaToo9OACNngqXZJzHM0Qx3d5nSurIgOnRutVx5Za/kvxfvSN3E9wCT8IAmsILI8FlMDoXbmDw+BV89JZSL70FgOH1ZiglXN4T5GPKvvSBh1e/suYZpy5YZ5BqhtQLjif9PfQAYh0rxvQ2jXuQbQyNww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeCqd/VY4OOlpQd/p6Y4Uzjyff+gPitq7IVx9BdcmNs=;
 b=GZ4ztMxC2yTQVlJ6xIeZbMRa77O+Kj0L0MddLKTWtd6yn0z09VJRs3y2llnWaLuzQm/rJJpZFDGEGhG8aLhCbPAiTfyw8IDhVWNBrazMxW3vTuMw88ZsKiuoWNLE2IPcD9BEAOW3doUBGuIyffq8ErNGJEwy/qxh5V8gqf7r4FfmgAOa+hHKLPHYjQC2m9vYvnbg9scVhDSzyy2xIqyOTZF0U3iSTsujiz3GOATWlyIo/C5LGqr58Q4Yj9kh7Av4PG5raVCWFewYm/qeFdlvZ3xpdp+FZngIl9PlOVBr1Zuyc7sSLfUCvtUNbv/IAZHf2fwhg/mP6tlXDwvqNKxU+A==
Received: from DU2P251CA0030.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::30)
 by GV2PR07MB10287.eurprd07.prod.outlook.com (2603:10a6:150:2a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 12:53:26 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::42) by DU2P251CA0030.outlook.office365.com
 (2603:10a6:10:230::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 12:53:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 12:53:25 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 1CA7920099;
	Tue, 10 Jun 2025 15:53:24 +0300 (EEST)
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
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v8 net-next 04/15] tcp: AccECN core
Date: Tue, 10 Jun 2025 14:53:03 +0200
Message-Id: <20250610125314.18557-5-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFE:EE_|GV2PR07MB10287:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da8329f-8834-4844-da9d-08dda81dca45
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SWVFRGo3bEtsSyswaVo4RXpOeXJhZ3hkODhReXFldEgzTXY4T2VWMk1WQm9j?=
 =?utf-8?B?MVZQZkphMWhmb2I2M0ZCWEVMeWE3Tm1Ec1NIS0MvVlV2c2xGV0lVM2Vyb29G?=
 =?utf-8?B?ZTIwSlY1S1BHN1BKT1I2cmljOWhVS3ljRjdXOVpDTkp3Z2hWN1UrN0FGRWk1?=
 =?utf-8?B?bm41RFg5K1hxWC9VZjY5dUVnYlkwanZJQjU2b29SZmp0bmtsSms0a3BPTk5h?=
 =?utf-8?B?Y1JCbDVxY2dHcks4UHdzWDlFZFp6QWtPZExhSXUxbjYwbEwxcmw5OXBRdXlr?=
 =?utf-8?B?blBXdFdtOXdIcEZZL1JwWDlsWWF3VEljRURBUzhLRXFoeXZUeUhxRFNwNExQ?=
 =?utf-8?B?aVBVRDFzbCsyaDNxRTM4RWY2SUIvVWFya05mSzJVRE1vR2VoWUVycVBhdU8w?=
 =?utf-8?B?b1Z4Y25KRjI3cVlBVHNHcnZOdGY1a0pOUWdWUFJPOHNtTGQ3d0Q3cVh4T0ZB?=
 =?utf-8?B?Rjk4SXIyb2dBMzZ5dmxSVTRvRlk3SE9oQUlWTGo4SitXcEZzK0FIVTFOMEk2?=
 =?utf-8?B?YXo0bTUwWVgwRjUwbmZ3RDlFZ3FWTENudkxwZFB6eVJHMjJCRFZXa3grWW4y?=
 =?utf-8?B?U3VXQTkrdyt1Z0JXc2lnMW9Md25qOGo1Yml4emZ4SzlCUGk5RVluTjFQSXoz?=
 =?utf-8?B?YWxIaHpvcHp1SkcrZldWMDJYRERaZjJjTFo4VXR1eWx3TWY0d0lCQ0gwMElh?=
 =?utf-8?B?djBiOCtKUkJpTnVtTlB3UnZXSHUxNVNCL3BDTTcyVUs3cnVqakdaYUJBb0Q2?=
 =?utf-8?B?U09OWjM2OE9rbU1QdDY4bmt6S0tYd3I4Y2kxaU5XeE5xR3puVjNBNDlkMEp2?=
 =?utf-8?B?UzZMY2wyY2xVOTg3V0lidEpZc3ppblBodElwZjRKN1puaFFXS2ZHTDZBb2dk?=
 =?utf-8?B?K2VHWWxOdUlDMWFKRE92aEl3UDJXeHZDYy9SbVcwdzhvSjlTYml4UW1lQTVx?=
 =?utf-8?B?UVpVMjlPQVBWL0sycENoaFhuMlpUYmtJU04xQkp6NGNBVnAxcXU3RWpCSGhU?=
 =?utf-8?B?VlJLOWw3R2tzQWI3MUJlWDJzUncyZ3N6ekpGci9mbUxnemFVamhsZndTWlFr?=
 =?utf-8?B?MXdEUXhjSlVacjBCdVcydnlrdGUwQmxnL3RyTXNpajJIQSswWjlmSGVLb014?=
 =?utf-8?B?OW1aQU1CYkx0Ulp0bnZCME1ZaFYwTE04dnZtWDE4QS82cllKRFhBVHpUYjFL?=
 =?utf-8?B?Ry9ZZUZEQUpjbU5DTzhMdEF1eldvYWJOUG43MmR4a0lRbE9uNmozZWFsMks2?=
 =?utf-8?B?WTEzNU1ZY3luaGlMT2t6Z1gzUDd4V2laRmx1SEFFanpIR1d4QzhaVFFIb094?=
 =?utf-8?B?bVE0aXVvMU1oRlhHNHEyazY2aDhJWFF4RzhjeERqSGpHUXF5WXFFTFdLTmJy?=
 =?utf-8?B?WWNOZWNVWlpYUnEvQzgreXk1MHZLUlFwK25yNTlFdEN0bGhZSFNKdVRwUDBs?=
 =?utf-8?B?NkNjakdvYVRUcHh6NVJEOFBPTG1GMGVBTUxkVk5xWk53RytobVNJZkNLZTEy?=
 =?utf-8?B?TXBJT0dhOHhZUVpyQ2UvS1hDeS8zTllPeVp4dnBwNmhmc2h0SjNodGZxYmU4?=
 =?utf-8?B?UTU3QlRXcEU1S2E0VVBWYlptbmRMYmpNUWRoYjZ6eHBDSUl3VWYxeG1FcUZW?=
 =?utf-8?B?R3l6eGVFT0pTT0pxOEZ5cDR4MzRoMGNIbGxHSjB2V1JCT01TY3ZoWmlQZ2Vh?=
 =?utf-8?B?aCtIL0RGUEhZaTRMWUtGSGllT2FyaHJsanRlOTBMSkdFK0hKSjVPUm1qMGg4?=
 =?utf-8?B?ZElGWnk0bkNacWpKTE84ZSs5czdVUURXcyt5dW9udnJuRVVlRk5NWHBuQlZq?=
 =?utf-8?B?MVBtbGNiWHoyaC9aV2dETTBxM3FNQTN0RHlCem9aS3NXNkNOc2hTQlNQV1Uy?=
 =?utf-8?B?aWJINWdjNkRLZERWQTBMRE5hWFJoaUl5RCtqQlVCRjYyNnFQV3hOR25mVGJa?=
 =?utf-8?B?eEVzMm8wMjRNYlV2MHpvR0djeE9INWEvQ0phbFpOWk9ZMTJsSEtjQ3R4cU1U?=
 =?utf-8?B?UWlzWWRUeGxvZ2paM1JjMFpqbmNpRWJkazF1QzFFVnZvdFU5dzFWMVZiei9P?=
 =?utf-8?B?TkRFTFVBOXFINm03VU4xSTNhYktNeFNtcy8xdz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:53:25.6453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da8329f-8834-4844-da9d-08dda81dca45
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB10287

From: Ilpo Järvinen <ij@kernel.org>

This change implements Accurate ECN without negotiation and
AccECN Option (that will be added by later changes). Based on
AccECN specifications:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Accurate ECN allows feeding back the number of CE (congestion
experienced) marks accurately to the sender in contrast to
RFC3168 ECN that can only signal one marks-seen-yes/no per RTT.
Congestion control algorithms can take advantage of the accurate
ECN information to fine-tune their congestion response to avoid
drastic rate reduction when only mild congestion is encountered.

With Accurate ECN, tp->received_ce (r.cep in AccECN spec) keeps
track of how many segments have arrived with a CE mark. Accurate
ECN uses ACE field (ECE, CWR, AE) to communicate the value back
to the sender which updates tp->delivered_ce (s.cep) based on the
feedback. This signalling channel is lossy when ACE field overflow
occurs.

Conservative strategy is selected here to deal with the ACE
overflow, however, some strategies using the AccECN option later
in the overall patchset mitigate against false overflows detected.

The ACE field values on the wire are offset by
TCP_ACCECN_CEP_INIT_OFFSET. Delivered_ce/received_ce count the
real CE marks rather than forcing all downstream users to adapt
to the wire offset.

This patch uses the first 1-byte hole and the last 4-byte hole of
the tcp_sock_write_txrx for 'received_ce_pending' and 'received_ce'.
Also, the group size of tcp_sock_write_txrx is increased from
91 + 4 to 95 + 4 due to the new u32 received_ce member. Below are
the trimmed pahole outcomes before and after this patch.

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2585     0 */
    u8                         nonagle:4;            /*  2585: 0  1 */
    u8                         rate_app_limited:1;   /*  2585: 4  1 */
    /* XXX 3 bits hole, try to pack */
    /* XXX 2 bytes hole, try to pack */

    [...]
    u32                        delivered_ce;         /*  2640     4 */
    u32                        app_limited;          /*  2644     4 */
    u32                        rcv_wnd;              /*  2648     4 */
    struct tcp_options_received rx_opt;              /*  2652    24 */
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2676     0 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    /* size: 3264, cachelines: 51, members: 163 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2585     0 */
    u8                         nonagle:4;            /*  2585: 0  1 */
    u8                         rate_app_limited:1;   /*  2585: 4  1 */
    /* XXX 3 bits hole, try to pack */

    /* Force alignment to the next boundary: */
    u8                         :0;
    u8                         received_ce_pending:4;/*  2586: 0  1 */
    u8                         unused2:4;            /*  2586: 4  1 */
    /* XXX 1 byte hole, try to pack */

    [...]
    u32                        delivered_ce;         /*  2640     4 */
    u32                        received_ce;          /*  2644     4 */
    u32                        app_limited;          /*  2648     4 */
    u32                        rcv_wnd;              /*  2652     4 */
    struct tcp_options_received rx_opt;              /*  2656    24 */
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2680     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 166 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 .../networking/net_cachelines/tcp_sock.rst    |   2 +
 include/linux/tcp.h                           |   3 +
 include/net/tcp.h                             |  26 ++++
 net/ipv4/tcp.c                                |   4 +-
 net/ipv4/tcp_input.c                          | 121 ++++++++++++++++--
 net/ipv4/tcp_output.c                         |  20 ++-
 6 files changed, 162 insertions(+), 14 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index bc9b2131bf7a..9bf507c349a0 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -101,6 +101,8 @@ u32                           prr_delivered
 u32                           prr_out                 read_mostly         read_mostly         tcp_rate_skb_sent,tcp_newly_delivered(tx);tcp_ack,tcp_rate_gen,tcp_clean_rtx_queue(rx)
 u32                           delivered               read_mostly         read_write          tcp_rate_skb_sent, tcp_newly_delivered(tx);tcp_ack, tcp_rate_gen, tcp_clean_rtx_queue (rx)
 u32                           delivered_ce            read_mostly         read_write          tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
+u32                           received_ce             read_mostly         read_write
+u8:4                          received_ce_pending     read_mostly         read_write
 u32                           lost                                        read_mostly         tcp_ack
 u32                           app_limited             read_write          read_mostly         tcp_rate_check_app_limited,tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
 u64                           first_tx_mstamp         read_write                              tcp_rate_skb_sent
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 191e69e274a4..4e33ac298191 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -288,6 +288,8 @@ struct tcp_sock {
  */
 	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
 		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
+	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
+		unused2:4;
 	__be32	pred_flags;
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 	u64	tcp_mstamp;	/* most recent packet received/sent */
@@ -300,6 +302,7 @@ struct tcp_sock {
 	u32	snd_up;		/* Urgent pointer		*/
 	u32	delivered;	/* Total data packets delivered incl. rexmits */
 	u32	delivered_ce;	/* Like the above but only ECE marked packets */
+	u32	received_ce;	/* Like the above but for rcvd CE marked pkts */
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u32	rcv_wnd;	/* Current receiver window		*/
 /*
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4dacd4a11669..cc28255deef7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -415,6 +415,11 @@ static inline void tcp_ecn_mode_set(struct tcp_sock *tp, u8 mode)
 	tp->ecn_flags |= mode;
 }
 
+static inline u8 tcp_accecn_ace(const struct tcphdr *th)
+{
+	return (th->ae << 2) | (th->cwr << 1) | th->ece;
+}
+
 enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
 	TCP_TW_RST = 1,
@@ -964,6 +969,20 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
 #define TCPHDR_ACE (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)
 #define TCPHDR_SYN_ECN	(TCPHDR_SYN | TCPHDR_ECE | TCPHDR_CWR)
 
+#define TCP_ACCECN_CEP_ACE_MASK 0x7
+#define TCP_ACCECN_ACE_MAX_DELTA 6
+
+/* To avoid/detect middlebox interference, not all counters start at 0.
+ * See draft-ietf-tcpm-accurate-ecn for the latest values.
+ */
+#define TCP_ACCECN_CEP_INIT_OFFSET 5
+
+static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
+{
+	tp->received_ce = 0;
+	tp->received_ce_pending = 0;
+}
+
 /* State flags for sacked in struct tcp_skb_cb */
 enum tcp_skb_cb_sacked_flags {
 	TCPCB_SACKED_ACKED	= (1 << 0),	/* SKB ACK'd by a SACK block	*/
@@ -1773,11 +1792,18 @@ static inline bool tcp_paws_reject(const struct tcp_options_received *rx_opt,
 
 static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
 {
+	u32 ace;
+
 	/* mptcp hooks are only on the slow path */
 	if (sk_is_mptcp((struct sock *)tp))
 		return;
 
+	ace = tcp_ecn_mode_accecn(tp) ?
+	      ((tp->delivered_ce + TCP_ACCECN_CEP_INIT_OFFSET) &
+	       TCP_ACCECN_CEP_ACE_MASK) : 0;
+
 	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
+			       (ace << 22) |
 			       ntohl(TCP_FLAG_ACK) |
 			       snd_wnd);
 }
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 86872ff89a27..ec91c63d2ea6 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3392,6 +3392,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->window_clamp = 0;
 	tp->delivered = 0;
 	tp->delivered_ce = 0;
+	tcp_accecn_init_counters(tp);
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5119,6 +5120,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, snd_up);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5126,7 +5128,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 91 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 95 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8ec92dec321a..13d9c6f3d2cc 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -341,14 +341,17 @@ static bool tcp_in_quickack_mode(struct sock *sk)
 
 static void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
+	/* Do not set CWR if in AccECN mode! */
 	if (tcp_ecn_mode_rfc3168(tp))
 		tp->ecn_flags |= TCP_ECN_QUEUE_CWR;
 }
 
 static void tcp_ecn_accept_cwr(struct sock *sk, const struct sk_buff *skb)
 {
-	if (tcp_hdr(skb)->cwr) {
-		tcp_sk(sk)->ecn_flags &= ~TCP_ECN_DEMAND_CWR;
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (tcp_ecn_mode_rfc3168(tp) && tcp_hdr(skb)->cwr) {
+		tp->ecn_flags &= ~TCP_ECN_DEMAND_CWR;
 
 		/* If the sender is telling us it has entered CWR, then its
 		 * cwnd may be very low (even just 1 packet), so we should ACK
@@ -384,17 +387,16 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 		if (tcp_ca_needs_ecn(sk))
 			tcp_ca_event(sk, CA_EVENT_ECN_IS_CE);
 
-		if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR)) {
+		if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR) &&
+		    tcp_ecn_mode_rfc3168(tp)) {
 			/* Better not delay acks, sender can have a very low cwnd */
 			tcp_enter_quickack_mode(sk, 2);
 			tp->ecn_flags |= TCP_ECN_DEMAND_CWR;
 		}
-		tp->ecn_flags |= TCP_ECN_SEEN;
 		break;
 	default:
 		if (tcp_ca_needs_ecn(sk))
 			tcp_ca_event(sk, CA_EVENT_ECN_NO_CE);
-		tp->ecn_flags |= TCP_ECN_SEEN;
 		break;
 	}
 }
@@ -428,10 +430,64 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 				bool ece_ack)
 {
 	tp->delivered += delivered;
-	if (ece_ack)
+	if (tcp_ecn_mode_rfc3168(tp) && ece_ack)
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+/* Returns the ECN CE delta */
+static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
+				u32 delivered_pkts, int flag)
+{
+	const struct tcphdr *th = tcp_hdr(skb);
+	struct tcp_sock *tp = tcp_sk(sk);
+	u32 delta, safe_delta;
+	u32 corrected_ace;
+
+	/* Reordered ACK or uncertain due to lack of data to send and ts */
+	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
+		return 0;
+
+	if (!(flag & FLAG_SLOWPATH)) {
+		/* AccECN counter might overflow on large ACKs */
+		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
+			return 0;
+	}
+
+	/* ACE field is not available during handshake */
+	if (flag & FLAG_SYN_ACKED)
+		return 0;
+
+	if (tp->received_ce_pending >= TCP_ACCECN_ACE_MAX_DELTA)
+		inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
+
+	corrected_ace = tcp_accecn_ace(th) - TCP_ACCECN_CEP_INIT_OFFSET;
+	delta = (corrected_ace - tp->delivered_ce) & TCP_ACCECN_CEP_ACE_MASK;
+	if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
+		return delta;
+
+	safe_delta = delivered_pkts -
+		     ((delivered_pkts - delta) & TCP_ACCECN_CEP_ACE_MASK);
+
+	return safe_delta;
+}
+
+static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
+			      u32 delivered_pkts, int *flag)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	u32 delta;
+
+	delta = __tcp_accecn_process(sk, skb, delivered_pkts, *flag);
+	if (delta > 0) {
+		tcp_count_delivered_ce(tp, delta);
+		*flag |= FLAG_ECE;
+		/* Recalculate header predictor */
+		if (tp->pred_flags)
+			tcp_fast_path_on(tp);
+	}
+	return delta;
+}
+
 /* Buffer size and advertised window tuning.
  *
  * 1. Tuning sk->sk_sndbuf, when connection enters established state.
@@ -3914,7 +3970,8 @@ static void tcp_xmit_recovery(struct sock *sk, int rexmit)
 }
 
 /* Returns the number of packets newly acked or sacked by the current ACK */
-static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered, int flag)
+static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered,
+			       u32 ecn_count, int flag)
 {
 	const struct net *net = sock_net(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -3922,8 +3979,12 @@ static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered, int flag)
 
 	delivered = tp->delivered - prior_delivered;
 	NET_ADD_STATS(net, LINUX_MIB_TCPDELIVERED, delivered);
-	if (flag & FLAG_ECE)
-		NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, delivered);
+
+	if (flag & FLAG_ECE) {
+		if (tcp_ecn_mode_rfc3168(tp))
+			ecn_count = delivered;
+		NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, ecn_count);
+	}
 
 	return delivered;
 }
@@ -3944,6 +4005,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	u32 delivered = tp->delivered;
 	u32 lost = tp->lost;
 	int rexmit = REXMIT_NONE; /* Flag to (re)transmit to recover losses */
+	u32 ecn_count = 0;	  /* Did we receive ECE/an AccECN ACE update? */
 	u32 prior_fack;
 
 	sack_state.first_sackt = 0;
@@ -4051,6 +4113,11 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 	tcp_rack_update_reo_wnd(sk, &rs);
 
+	if (tcp_ecn_mode_accecn(tp))
+		ecn_count = tcp_accecn_process(sk, skb,
+					       tp->delivered - delivered,
+					       &flag);
+
 	tcp_in_ack_event(sk, flag);
 
 	if (tp->tlp_high_seq)
@@ -4075,7 +4142,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	if ((flag & FLAG_FORWARD_PROGRESS) || !(flag & FLAG_NOT_DUP))
 		sk_dst_confirm(sk);
 
-	delivered = tcp_newly_delivered(sk, delivered, flag);
+	delivered = tcp_newly_delivered(sk, delivered, ecn_count, flag);
+
 	lost = tp->lost - lost;			/* freshly marked lost */
 	rs.is_ack_delayed = !!(flag & FLAG_ACK_MAYBE_DELAYED);
 	tcp_rate_gen(sk, delivered, lost, is_sack_reneg, sack_state.rate);
@@ -4084,12 +4152,16 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	return 1;
 
 no_queue:
+	if (tcp_ecn_mode_accecn(tp))
+		ecn_count = tcp_accecn_process(sk, skb,
+					       tp->delivered - delivered,
+					       &flag);
 	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, flag);
+		tcp_newly_delivered(sk, delivered, ecn_count, flag);
 	}
 	/* If this ack opens up a zero window, clear backoff.  It was
 	 * being used to time the probes, and is probably far higher than
@@ -4110,7 +4182,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 						&sack_state);
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, flag);
+		tcp_newly_delivered(sk, delivered, ecn_count, flag);
 		tcp_xmit_recovery(sk, rexmit);
 	}
 
@@ -5948,6 +6020,26 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
 	}
 }
 
+/* Updates Accurate ECN received counters from the received IP ECN field */
+static void tcp_ecn_received_counters(struct sock *sk,
+				      const struct sk_buff *skb)
+{
+	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
+	u8 is_ce = INET_ECN_is_ce(ecnfield);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!INET_ECN_is_not_ect(ecnfield)) {
+		u32 pcount = is_ce * max_t(u16, 1, skb_shinfo(skb)->gso_segs);
+
+		tp->ecn_flags |= TCP_ECN_SEEN;
+
+		/* ACE counter tracks *all* segments including pure ACKs */
+		tp->received_ce += pcount;
+		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
+					      0xfU);
+	}
+}
+
 /* Accept RST for rcv_nxt - 1 after a FIN.
  * When tcp connections are abruptly terminated from Mac OSX (via ^C), a
  * FIN is sent followed by a RST packet. The RST is sent with the same
@@ -6210,6 +6302,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 					flag |= __tcp_replace_ts_recent(tp,
 									delta);
 
+				tcp_ecn_received_counters(sk, skb);
+
 				/* We know that such packets are checksummed
 				 * on entry.
 				 */
@@ -6254,6 +6348,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
+			tcp_ecn_received_counters(sk, skb);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6294,6 +6389,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 		return;
 
 step5:
+	tcp_ecn_received_counters(sk, skb);
+
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
 	if ((int)reason < 0) {
 		reason = -reason;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 2ede3c190293..aba9e2eeeb59 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -374,6 +374,17 @@ tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 		th->ece = 1;
 }
 
+static void tcp_accecn_set_ace(struct tcphdr *th, struct tcp_sock *tp)
+{
+	u32 wire_ace;
+
+	wire_ace = tp->received_ce + TCP_ACCECN_CEP_INIT_OFFSET;
+	th->ece = !!(wire_ace & 0x1);
+	th->cwr = !!(wire_ace & 0x2);
+	th->ae = !!(wire_ace & 0x4);
+	tp->received_ce_pending = 0;
+}
+
 /* Set up ECN state for a packet on a ESTABLISHED socket that is about to
  * be sent.
  */
@@ -382,7 +393,14 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (tcp_ecn_mode_rfc3168(tp)) {
+	if (!tcp_ecn_mode_any(tp))
+		return;
+
+	if (tcp_ecn_mode_accecn(tp)) {
+		INET_ECN_xmit(sk);
+		tcp_accecn_set_ace(th, tp);
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
+	} else {
 		/* Not-retransmitted data segment: set ECT and inject CWR. */
 		if (skb->len != tcp_header_len &&
 		    !before(TCP_SKB_CB(skb)->seq, tp->snd_nxt)) {
-- 
2.34.1


