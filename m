Return-Path: <linux-kselftest+bounces-35561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E07E2AE2BB4
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 21:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342231885B32
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 19:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8216E272E5E;
	Sat, 21 Jun 2025 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="OefF2Hb0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011032.outbound.protection.outlook.com [40.107.130.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E5026FDBB;
	Sat, 21 Jun 2025 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534691; cv=fail; b=nBjl2338IKF+zyPK84Cg5n9969WF9y1YtsnzxqPO10em/9Ur9HiPPvCawrm0pIvvFH6xw6O+BXdIwyRY2Ihg2tjwmUWOmW2YoD4s8Lc+IC7Ox3+B88O3hob22VDrZ70XslbJWGqJepvHJzggIssrA/VNVwrgoCB1yD1GpZRPY0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534691; c=relaxed/simple;
	bh=T69UkHj78BeYpDGldWXpxgO6i/D/6KFdYFyYfu6bipw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HvrQ6edOdnShTbbW/vio7yDfcgOPYxy62FQNHC358kdJ/zTSibercepKynaOfOzC4+mfqELEWIUpKysKbK+er7lfSAchO+Xl7Zt7r9Spu4DQbQMotaIbTgQNa5EuO1MeDW7yzKKzSyaKOFhGEoZjSWkfVdMwrHZOMiGR59eeJkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=OefF2Hb0; arc=fail smtp.client-ip=40.107.130.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgmWwVHhO3PGhFbimpYWqLKHo28lckDAOdErTXyEeZaAZt9oYQ888RTtQIkh7oQVjXSpVf3JY40ZtzK82aqG1/Wt94lfjz81oFIJuyt202bCnBDB9u2hq2+R9nptN3OxKKu65YhwG+o7m0f5lmSd0xa62g4y7KGem2bnuht+iTHV6drVIu8FPkzZMoMuNuiFU3RA5FLw2ZSBHDpnzhf1G64tBc64OegA2KNxF9FXRyfu85S1gTMWCQ3fN4Y+BGxl0TQ+bHlydZwmzilBre4zc1U+YIwZzgPOuAt4vZfgoDJ50892kp9wqb1nmTyMZyZnDwlTfTnQUNSZ9I1exmDHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0dROp/XxbJ6j1+6IqD/iOCwy90b/14d0XTNnNgrFt8=;
 b=a8q7l4QqQfGKIgMUhhkktAh7QhbfRVRNR/YrJ1XS9cf8hTldCGOLIdhFhrkYHOdRJmGF1c1Surxsz6XYK4GT59bXn+oufaHvE9MAMuvVsVBnwSPE6m83oMlPJbgnoGpb4GShE1IU8svcbsuElua74uJWnhKRkMIQOlOwXg8NXDc3d3h8PmnUHuVcjvpXcesSvg5dx2i832AcN6Ibl5+OAdwIdkLIUfisUTuyny2x1W87UuIIl6ayqdY2Iz48euYiwqnOnYE04iZfhnUBfguSpWKHr5uriZRlmUgyKjBxU/X/dvqx+8dE/SAR105MLKIXCAOQ/cYxSTmAf0AXfHLqiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0dROp/XxbJ6j1+6IqD/iOCwy90b/14d0XTNnNgrFt8=;
 b=OefF2Hb0tACBzzkGZZaVoCnwuuMPNwVG8yDau68IFu5DEY+Ug/h8yBI8iTmTcTX4vY5DbP5zK+A7wkWptSug2wH/101JtmHV4p5hQiQzunDbQvZbv7NwyR0od7/VW5h7DzvoVtwhSONQS1eSKf6RRxpt0p9TA1EEMD3Id2mGVVkWOfesIkO7WTnYeDVFOmaKiwiuLGMqs65mWPArx3usHwjkAcyZqmnb2l+1WY3JcU1MdLH1lVpiXwUaTTNG5afewrf6Oa47Z404ER25p5qae0nA20CZDP0MIWQOlroNHz/HwSLT/VAGq84oajKuV4npgGcVWHN4mv2ufAkfbONjiw==
Received: from CWLP265CA0425.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d7::17)
 by DB9PR07MB9125.eurprd07.prod.outlook.com (2603:10a6:10:3d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Sat, 21 Jun
 2025 19:38:02 +0000
Received: from AM4PEPF00027A66.eurprd04.prod.outlook.com
 (2603:10a6:400:1d7:cafe::f7) by CWLP265CA0425.outlook.office365.com
 (2603:10a6:400:1d7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Sat,
 21 Jun 2025 19:38:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00027A66.mail.protection.outlook.com (10.167.16.91) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Sat, 21 Jun 2025 19:38:02 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 0B01B1C0010;
	Sat, 21 Jun 2025 22:38:01 +0300 (EEST)
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
Subject: [PATCH v9 net-next 10/15] tcp: accecn: AccECN option send control
Date: Sat, 21 Jun 2025 21:37:32 +0200
Message-Id: <20250621193737.16593-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A66:EE_|DB9PR07MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: aeab3ea9-05cf-4465-0dac-08ddb0fb2303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVY1RmlPYXV0THQyQmR5N25Dc0Qvam9RU1lXVG55TzR4eFFHZE9BRFJ2eG1k?=
 =?utf-8?B?TEQ0aXBCY0JzZnFTay9UK2t0NVV5VGwvdHhMYUpqcTJkZTFWNDZkRVdEYTJy?=
 =?utf-8?B?L0F6Z1pHWUM4QnJraW1hS3U4QVQwTHZnY1NOMS9NM3lQRFdTdXV2dFBoUGtN?=
 =?utf-8?B?R0ZFV3NhbEFodFlxYk0vZW9wWmwvOG9ET0tOcTVYVzQ0V1hUU2dUSEhZN012?=
 =?utf-8?B?V1NKNDZQYXdDa1VBcWpndDI5V3VhdUdzUzQyRFFkMUhvd3lNOERRTHA4UUZt?=
 =?utf-8?B?TUNNRGIvaEhOVHVQeUZJYUhKc2pNeG9HMDZ5RkM1K0VMVW0ycXFhTHh5TVRP?=
 =?utf-8?B?VWVhQUdDNHZhMkFKS0dOVXdLbUkrSmVKMXlWTUtaM1pzUksySjAzbjhvTHdn?=
 =?utf-8?B?Qm5DNnk2Smd2U25kQ3p5N1owbVY3VEZ2TGhuT2FQUlVSbTRkc0VPbkx1a1Nw?=
 =?utf-8?B?TTU0YzRsbFc2cDFsV2N0YmhITkRhblduWWZkYWp5enM1TGNKVmY4N2xObUZv?=
 =?utf-8?B?MUdzekpsbVBsRVVjTlE5dmF0VVdXNTZxRUIya2JxMmF0ZHhxRVBzNXpQL0h4?=
 =?utf-8?B?RnkvNlZVay90YVI2aGpJOHg4Mk8yZWJ4b3FJbG1uMXJmeklnYWdLKzdSV1g5?=
 =?utf-8?B?TkUvdFFYQlRxNXo2Q1NTR1pSWVBKVUhESWt0d2NSeWNwYTV6emZsVzJ6RGxy?=
 =?utf-8?B?ZFY4QUpJUllDNjNvTENEVy9LNmYzeEdvNlNoNUdOcFhkamFOZ0VwT2xSeEtl?=
 =?utf-8?B?ZGY4MXJRM3U5eDIvTEZGVlBKZUttd3F2bElZS21HVTNEdG5GZ1VpOHZiSXVp?=
 =?utf-8?B?RXlCVTNPZ2h0M1d0d2c2cm9NWE5LN3FRSDFLdkNPRVF4cFh5SFlzZVNTSTJs?=
 =?utf-8?B?K0RkaUxra3lhaTY4VU0xVDNuaXpubHltRU5RbmpPOENpTXVpLzFrM1JkMFhO?=
 =?utf-8?B?ZE53WDUvUGFaSkJmeVE2N0FBOVhxeFp0dFJxNFVaYU14MUhJWEwzOG00bzNz?=
 =?utf-8?B?MmpBZDAxd2lSWENYYWZid1NBbHdJSDB1Rkx0M0h4MGNzejd0ZG0yVWM3ekc1?=
 =?utf-8?B?NkExV1BSQU4rT1ZQTmtWTGlIdEZUR3p5Y1dMa25heEViYWdKYTZXYTR1cmxD?=
 =?utf-8?B?K25GVmRSUmZTSjY0Si9lS3p6eDM2M0xLT25VOWc3clA3TXFwcUJaUXlaWU5r?=
 =?utf-8?B?Y1pZdTgzazU5OHY4MFEvZ3oraU9LcnU2UVh1L2RjcTczbkx1K2xaM3hCMG5Q?=
 =?utf-8?B?dUZBQVhCOW1Pdkw2dHVIUWVEaGRJd3Y3Rk1ycGphL3hZKzFHbEJ5eHRLRG05?=
 =?utf-8?B?b2lGOFAvRVZnbXFqNGtLdDRnTHV4SHpMQkxxdlZZSjJpem5mWVZLOVZ1REhQ?=
 =?utf-8?B?RUhYNS9RQlNXUTdpR2hJcnpUSlRjTUYxTXV0Smk5Ny9XSDMzNC9CcVYzeDJM?=
 =?utf-8?B?dEVtdEZENnFpSHE3UDBhTnRNSC9oekdyVm0rbkFwYU5EQ01JMlh4YnIyZDB6?=
 =?utf-8?B?VVphZE03WlFLTFVKRzA4emp0TURnM1BLeVVlMHdYV1N1bHdLSjFZYzlYSUN1?=
 =?utf-8?B?SUw3Q25ZTDVabnFhQkxheDRZMStuZjJTUllVZUpwRG9qTnNHR0pvSTJtcTNr?=
 =?utf-8?B?djNFWGZBUWdVc1AvanY0c3VEeUQ3MnViQ2h4dmJuKzVDWStYdFJ4TnljZm5H?=
 =?utf-8?B?a3lVWTl5WHZYZkRhV3ExL0ltcjI0anVmTGtJQXVLWllIbW8ycUhSZzlia2oy?=
 =?utf-8?B?VVV3Z290cjFBVUxCbE1yclY5Vkt0eTl1VXBjSW85c1ZpNUtvSnd6Zis5M1Jw?=
 =?utf-8?B?cjQwMEtWeWppLzRsS0dXeTcyeVVKZmF1ZEVJejI2Z2xsdjNnc3pZbGJ4NGFL?=
 =?utf-8?B?NE9tay9UZlg0ODBIaUtJNWsvZkRpZFlxWkxwcnFxYlVZS3RTTHpQVWQxNGIv?=
 =?utf-8?B?STl1T1owdkhvclU5YkZtT2h5azY1V2IyQjNCZHZvZytrK1dJUUxua0xZdzdT?=
 =?utf-8?B?KzhzWFRsYTZZMnlubnBlY0RkN0FuaUtrTXVya2NhQ2t4Y3dtcSsyU3dZKzV4?=
 =?utf-8?B?dnZVZUNRa2kxS3dQMS82K0ZVaFl2bnFyNzdCUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 19:38:02.6212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeab3ea9-05cf-4465-0dac-08ddb0fb2303
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A66.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9125

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
index f7ba314eb7f9..fb0d69ee3ce1 100644
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
index 1c1d4cbdda1c..f7a85192c86f 100644
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
@@ -5114,11 +5116,12 @@ static void __init tcp_struct_check(void)
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
index 66390966cc41..3cc9c57d9983 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -497,6 +497,7 @@ static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
 	default:
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
+		tp->accecn_opt_demand = 2;
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
@@ -517,6 +518,7 @@ static void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 		} else {
 			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
 					  INET_ECN_MASK;
+			tp->prev_ecnfield = tp->syn_ect_rcv;
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
@@ -6182,6 +6184,15 @@ void tcp_ecn_received_counters_payload(struct sock *sk,
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
@@ -6189,6 +6200,7 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool ecn_edge;
 
 	if (!INET_ECN_is_not_ect(ecnfield)) {
 		u32 pcount = is_ce * max_t(u16, 1, skb_shinfo(skb)->gso_segs);
@@ -6207,9 +6219,33 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 
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
@@ -6342,8 +6378,10 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
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
index ca36f5d775f7..a4c80be115e5 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -816,8 +816,12 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
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
@@ -1004,6 +1008,18 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
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
@@ -1258,7 +1274,10 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	}
 
 	if (tcp_ecn_mode_accecn(tp) &&
-	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
+	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
+	    (sock_net(sk)->ipv4.sysctl_tcp_ecn_option >= TCP_ECN_OPTION_FULL ||
+	     tp->accecn_opt_demand ||
+	     tcp_accecn_option_beacon_check(sk))) {
 		int saving = opts->num_sack_blocks > 0 ? 2 : 0;
 		int remaining = MAX_TCP_OPTION_SPACE - size;
 
@@ -2975,6 +2994,11 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
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


