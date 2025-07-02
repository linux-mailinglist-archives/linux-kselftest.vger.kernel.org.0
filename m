Return-Path: <linux-kselftest+bounces-36268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8E1AF09EC
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 06:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE94E480C30
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 04:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D5121B8F6;
	Wed,  2 Jul 2025 04:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="FYA9w/sA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509441DFDAB;
	Wed,  2 Jul 2025 04:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751431073; cv=fail; b=CDeSwewtj6UNCRjQSBo+MpuJypUfaTfpg7dHyRKhuAkFBJg4O/W21KWE2GL3yWEkyhNfFvyzxPrA3lvLujQTQtZMJ+3IoFiP8QE7s10bndL6Ex4LxCNVuW98c3YlQyAW5i1amdE/LgXgJcXzy0oi+2w1XcD7kgzWiA3h4M6XSzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751431073; c=relaxed/simple;
	bh=/YIU1Tt5gWiXai3T0e4icBoGzaZsoAYWCDuiv6Z2pkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehIijLRIg+LHizLINgEEV9C731ZqM4mkqv19FY+hrHZYK5RcoNJ2v1fQEbMoym5u6y3eCAtPvhJDk8erlKPjtCd9/YL2umYBlNEPLNpNNYKLJ0GJDGutJ9fzHfI8B3tC13VRP8KIUlxlO9jurcq0HOmX4L4FFx1ClG8dCAuq5jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=FYA9w/sA; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxTtl9fCJt9Y8U3gfmJVwqbeNERMzDioqwCwbFydWtZxcZm6ielfqY3Dnc+ynrr+gPuxNNs2I5HanJnhk8GeCg84FBPieonGudK92tavjOkfhQuwAZkOYeYoyubEG20icMQoNugG/fmwmLoXodftvdygL2NMjnmQa9LLt0f8cfOEZR49hYDxpoedUAQDZc8WmsxKTu13k9UM45NzXdG6YEP5D9RVkOTownnmVTY2c0mBXEyxkSd5+ExgCO9/PvneIh3xc17xDUJr9sqmaSXy7qPjnC/dqF30kaz5/ANLJ0cLBVgKhHhTqe1vAum0hr2ZyHD4CnJwS4MED3nkyAfkyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGvCRIPc9Ao+rd7vMNDW9Sc3P4vA1t6HBJnqK/NFzfs=;
 b=rtEN7s7yOVjsyaHKX4qkBUUJjLSXsqXFuvCIZrpBvD1hgLB5fkM/PWwaMlF5e6kuHjcECrY/xU7Y1dwpWA+s0ZegSXKkZIw64FZcjZ2PxRZ3AV8lA8tboM4Tg/wkxqyvb413oLThPapWa2XmRxN/v9/hSJrjFZva+QD8lvwHup9d4gA8MoRBArUdgIBKimzOBuXk6M1mJ7mjpJDCVemeNJOC0Qt+or7TWULnlrEk1od3J/rhr4oKscb9jSajXQi8ZrtuB8P8R8S5yQOLgGBeGB6lxD97VPdhyOmXBajarD55/6GoCfI8GkMGy6iWeNvxItfDhPFPazKEDd0/KI2GHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGvCRIPc9Ao+rd7vMNDW9Sc3P4vA1t6HBJnqK/NFzfs=;
 b=FYA9w/sA4fmBdPS3jX35XE2kZ0xzWtsfCoRg87KYkObprISAfWl+gVrqIHghExfRsuT+Ue1BBzBtcbHMEXX3xiEsd0sb5nqYoVdzSqnoH38xZTh1u4FXxxBOBX7qxRDuPmTo6uL7P+kaSXEjVN7hi1ldU3VyYs/SzpW6kpwjGD/w0JrQKiMfvSmbUitafj51vvZeBDkQNQ3UDcQSjJxC+2DKZJ6SqgOPhaM4eer7D4VvXq7Zh4uht8UaLpOYHtoR4gteMdGVbGQtI9Z5xuJWeh3TbgCABx9ZspZazaY0OTZk0rQvXacfpo+fMllXaN+FSLBWgK5OfaH1dk2elwpgyg==
Received: from AS4P189CA0055.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::22)
 by VI1PR07MB6318.eurprd07.prod.outlook.com (2603:10a6:800:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Wed, 2 Jul
 2025 04:37:45 +0000
Received: from AM1PEPF000252DF.eurprd07.prod.outlook.com
 (2603:10a6:20b:659:cafe::ce) by AS4P189CA0055.outlook.office365.com
 (2603:10a6:20b:659::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 04:37:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM1PEPF000252DF.mail.protection.outlook.com (10.167.16.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Wed, 2 Jul 2025 04:37:45 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id AFCCC1C003A;
	Wed,  2 Jul 2025 07:37:43 +0300 (EEST)
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
Subject: [PATCH v10 net-next 12/15] tcp: accecn: AccECN option send control
Date: Wed,  2 Jul 2025 06:37:16 +0200
Message-Id: <20250702043719.15130-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DF:EE_|VI1PR07MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b76562-a37b-45c9-8278-08ddb92230ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mm00cGNBRVcrMjZYT0YrSzBGRXRzcWlYd1J2b2pobWRGOGVXcE1hcWd3Y0xk?=
 =?utf-8?B?VDVwNGNwVlhDbVBqQWczMlpkcms3MXNKQXhjUW1HK0JidUltTHBJRjJ1eWxI?=
 =?utf-8?B?K1RsZjZPcWN3K3pISUlsYkl6NWU2MHIxbWxQK01xOHhqU2hQZGVCNTU0dDF2?=
 =?utf-8?B?SGx5cmUrOFNBVVBySURRVHVnYkkzNmM0aXR0c0RyRVhoRDFCUUV5cWlvUWo1?=
 =?utf-8?B?QXljUGhFRlBZYitnV2EvYUs5MmVhR05aL3pBL3cvNXJLam9SVVdlZ2wyUTNH?=
 =?utf-8?B?ZmJZTjhVQWFqMEdpZzhFZU5rOHlQMlgwTlliUmM5TXRPbThHcHViS1VDVXpM?=
 =?utf-8?B?REdEa3lQcGkwOXZhV1VFODNMMnBlTTZiTHVqYlZucThEUEZsa3djQWRVcDE1?=
 =?utf-8?B?ZGxWR2kzT1JtUUFReDlLWGZ2UndpbGE2ZXV6eURzRVFNa3hFQUxtOWNLM3ZW?=
 =?utf-8?B?NGQ1QVl3b1Z4bGlmMnZQZVp0VVpNSVJ3YmdEYklaSGhMZjZYSmk1OEZ5dmdQ?=
 =?utf-8?B?YkVCK2l1MjJ5aThjYVh2STBKRUxJRFN4NkxIRG04Q2dEcDJQWWpBZ2RIM2xT?=
 =?utf-8?B?V2ExYlZydmVXMWRENkt5dTRBLzdDdllRdnFhM1ZLeFRZcmhHT1FhZTJqWDk1?=
 =?utf-8?B?V0JncGFYNVdaSzkycnQ2OTF3MnVLaXljaGlQT0pNRm9XOEs3V3V4akplZ3dU?=
 =?utf-8?B?OEk2Umc2YWZiV0NFdmdKRXJ6eGwzZzBqOFNFbnYrTDZXSHJQT3M2d3hsUVRT?=
 =?utf-8?B?b25GdEJQajJmM01adXE5bGREYXBDVmtNYURVc0cxM2JyZTh1WDRVWEJWZHE5?=
 =?utf-8?B?bEhyUzFXUVFkQzhYV3dKemtXTWZCTVFEODVjd0x2SzhtRjFKcTRzZ1VTeXpI?=
 =?utf-8?B?UXlTaDVXeTBpWm1QcXQxV1dQYWdpYWJWMTdvSHJvS1g0WkRaMUw2S01JTkF5?=
 =?utf-8?B?WWZGNTNIc2FmbXhZRXgzcDFLWkhadjArbkZ4VzQySk9ybk03cGNlci8vL25X?=
 =?utf-8?B?ZVhuVE9tVU9MNjE3TVhoanVBNFRRNTdIMWpTbFl2bmpUb1hCVFlBaWhiMTh1?=
 =?utf-8?B?aDRocUU5WkJUbWJqZnFOWWYyM0VCOWFhbXJCakZpb3hmSzZsSk9LeEhHMTI5?=
 =?utf-8?B?Z0xUNFF2VGVFSk4wOFUyNVcyZzludVNFYXJYeDlydERjL0tPeEEyUVhLOCt6?=
 =?utf-8?B?TjJSdVNHQll4TVdnSEl1RlBha1NoR2lDYURMS1dhL056NEpwWlUvM24xQVQ3?=
 =?utf-8?B?TVRBVFgzbU1hbldjT2p0U1J3bHltcmtDV01hdnpzMWgzTFlYMmtsSkFDaFo4?=
 =?utf-8?B?NWl5bHk2Umt6TFJVK3plK0c3SGVmaUlvTkgwSm9qMTlZTUZZVXFoS0ZENkw5?=
 =?utf-8?B?MVVPQlJaSnVtNDBmbU9sU3gvc0FNT3dsUDB5S2pPU0RERGlaeVJrclg5R3BZ?=
 =?utf-8?B?QUNNaEdOTGRTWWNDaTZrV2RyY1VwWE10a3RDdnFBcnVram1RMEFQRVR2SVRN?=
 =?utf-8?B?QTV0ZEZrZEJYc2pHS0pIWFRvTVlSZnNhbkV4N083blNYd09XQmVwOVp1L29k?=
 =?utf-8?B?TWNaSG8yd2dSbEFIeWFXTkI1NnZ3QTZCaW5YZSttWkc5NktKTk1oOFVVM3Jp?=
 =?utf-8?B?dWZBeGZNekI0QUI0cHMvQk5mZmJnT1F4bUd1SC9WZWJCeGJmMWUrL2t0T2FY?=
 =?utf-8?B?YVI5alREdXNyN0ZJUk11U0RZWkFYVEdaWGNRc2ZJUTloZk9FUkI2dVZGY2hW?=
 =?utf-8?B?anN5ZXdnSDhoVGsvODhOVE5xaDBVL0twRnNWMVFDTWFhQnI2MGhwNjBJNlUv?=
 =?utf-8?B?SnVLNkF1WUwrRzU5WmMzR1ltdGN6Q1dPeDhlOG1GbWh0UG4wTWRaaitEaEpk?=
 =?utf-8?B?U0xmczhia1JaMElvSS91STlrZWZLQW90OENyd21YUEVuQStjanpVckhRNEQy?=
 =?utf-8?B?MmZHL2ordzhQZnNYMnpVVWhQS2trcUVyaXJlOCt2cXBtU0VvVGl5SEYzWlpu?=
 =?utf-8?B?WENyU2FPOHNVL281dExHZWRrWkUyb2w0MHVxOXVSRG5kRjhpdEJRMlkySU4y?=
 =?utf-8?B?RXlEUDVxUG9uSU9PMjQ0U0ZhTERkNUlrYjFrQT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 04:37:45.2491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b76562-a37b-45c9-8278-08ddb92230ad
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DF.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6318

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

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

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>

---
v10
- Add documentation of tcp_ecn_option_beacon in ip-sysctl.rst to this patch

v8:
- Add new helper function tcp_accecn_opt_demand_min()
- Remove white space only change
---
 Documentation/networking/ip-sysctl.rst        |  6 +++
 .../networking/net_cachelines/tcp_sock.rst    |  3 ++
 include/linux/tcp.h                           |  4 +-
 include/net/netns/ipv4.h                      |  1 +
 include/net/tcp.h                             |  3 ++
 include/net/tcp_ecn.h                         | 50 +++++++++++++++++++
 net/ipv4/sysctl_net_ipv4.c                    |  9 ++++
 net/ipv4/tcp.c                                |  5 +-
 net/ipv4/tcp_input.c                          |  4 +-
 net/ipv4/tcp_ipv4.c                           |  1 +
 net/ipv4/tcp_minisocks.c                      |  2 +
 net/ipv4/tcp_output.c                         | 16 +++++-
 12 files changed, 99 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 9b63466bcbf5..5698dab3a7b0 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -487,6 +487,12 @@ tcp_ecn_option - INTEGER
 
 	Default: 2
 
+tcp_ecn_option_beacon - INTEGER
+	Control Accurate ECN (AccECN) option sending frequency per RTT and it
+	takes effect only when tcp_ecn_option is set to 2.
+
+	Default: 3 (AccECN will be send at least 3 times per RTT)
+
 tcp_ecn_fallback - BOOLEAN
 	If the kernel detects that ECN connection misbehaves, enable fall
 	back to non-ECN. Currently, this knob implements the fallback
diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index ed6af7d0110c..88c668f9c68b 100644
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
index 0008b8190ea0..2c0a2db6e6dd 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -275,6 +275,7 @@ struct tcp_sock {
 	u32	mdev_us;	/* medium deviation			*/
 	u32	rtt_seq;	/* sequence number to update rttvar	*/
 	u64	tcp_wstamp_ns;	/* departure time for next sent data packet */
+	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */
 	struct list_head tsorted_sent_queue; /* time-sorted sent but un-SACKed skbs */
 	struct sk_buff *highest_sack;   /* skb just after the highest
 					 * skb with SACKed bit set
@@ -296,7 +297,8 @@ struct tcp_sock {
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
index ff3e774fcf26..014a22aef25a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -90,6 +90,9 @@ void tcp_time_wait(struct sock *sk, int state, int timeo);
 /* Maximal number of window scale according to RFC1323 */
 #define TCP_MAX_WSCALE		14U
 
+/* Default sending frequency of accurate ECN option per RTT */
+#define TCP_ACCECN_OPTION_BEACON	3
+
 /* urg_data states */
 #define TCP_URG_VALID	0x0100
 #define TCP_URG_NOTYET	0x0200
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index bed52eb38faf..d4c4f04a4ee4 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -181,6 +181,16 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 	}
 }
 
+static inline void tcp_accecn_opt_demand_min(struct sock *sk,
+					     u8 opt_demand_min)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	u8 opt_demand;
+
+	opt_demand = max_t(u8, opt_demand_min, tp->accecn_opt_demand);
+	tp->accecn_opt_demand = opt_demand;
+}
+
 /* Maps IP ECN field ECT/CE code point to AccECN option field number, given
  * we are sending fields with Accurate ECN Order 1: ECT(1), CE, ECT(0).
  */
@@ -256,6 +266,7 @@ static inline void tcp_ecn_received_counters(struct sock *sk,
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool ecn_edge;
 
 	if (!INET_ECN_is_not_ect(ecnfield)) {
 		u32 pcount = is_ce * max_t(u16, 1, skb_shinfo(skb)->gso_segs);
@@ -274,9 +285,33 @@ static inline void tcp_ecn_received_counters(struct sock *sk,
 
 		if (len > 0) {
 			u8 minlen = tcp_ecnfield_to_accecn_optfield(ecnfield);
+			u32 oldbytes = tp->received_ecn_bytes[ecnfield - 1];
+
 			tp->received_ecn_bytes[ecnfield - 1] += len;
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
@@ -350,6 +385,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
 	tp->accecn_minlen = 0;
+	tp->accecn_opt_demand = 0;
 	tp->est_ecnfield = 0;
 }
 
@@ -432,6 +468,7 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
 	default:
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
+		tp->accecn_opt_demand = 2;
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
@@ -452,6 +489,7 @@ static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 		} else {
 			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
 					  INET_ECN_MASK;
+			tp->prev_ecnfield = tp->syn_ect_rcv;
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
@@ -550,4 +588,16 @@ tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 		th->ece = 1;
 }
 
+static inline bool tcp_accecn_option_beacon_check(const struct sock *sk)
+{
+	const struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option_beacon))
+		return false;
+
+	return tcp_stamp_us_delta(tp->tcp_mstamp, tp->accecn_opt_tstamp) *
+	       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option_beacon) >=
+	       (tp->srtt_us >> 3);
+}
+
 #endif /* _LINUX_TCP_ECN_H */
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
index 3bf9248f5e11..797b7121e1cc 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3397,6 +3397,8 @@ int tcp_disconnect(struct sock *sk, int flags)
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
index 107c20ae0f5b..103260fc9130 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6090,8 +6090,10 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
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
index a6ae6f261ce8..4a850c379c65 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3451,6 +3451,7 @@ static int __net_init tcp_sk_init(struct net *net)
 {
 	net->ipv4.sysctl_tcp_ecn = TCP_ECN_IN_ECN_OUT_NOECN;
 	net->ipv4.sysctl_tcp_ecn_option = TCP_ACCECN_OPTION_FULL;
+	net->ipv4.sysctl_tcp_ecn_option_beacon = TCP_ACCECN_OPTION_BEACON;
 	net->ipv4.sysctl_tcp_ecn_fallback = 1;
 
 	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 0a0ee33e38ad..848c756a37b8 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -473,6 +473,8 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->prev_ecnfield = treq->syn_ect_rcv;
+		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 2169fd28594e..65ef1c3c97c2 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -708,8 +708,12 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
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
@@ -1151,7 +1155,10 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	}
 
 	if (tcp_ecn_mode_accecn(tp) &&
-	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option)) {
+	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
+	    (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) >= TCP_ACCECN_OPTION_FULL ||
+	     tp->accecn_opt_demand ||
+	     tcp_accecn_option_beacon_check(sk))) {
 		opts->use_synack_ecn_bytes = 0;
 		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
 					       MAX_TCP_OPTION_SPACE - size);
@@ -2864,6 +2871,11 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
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


