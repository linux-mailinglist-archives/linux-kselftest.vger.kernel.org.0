Return-Path: <linux-kselftest+bounces-37577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A55FB0A64B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 16:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03495A80593
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 14:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52962E03E2;
	Fri, 18 Jul 2025 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dJLhRji4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010008.outbound.protection.outlook.com [52.101.69.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A092DFA59;
	Fri, 18 Jul 2025 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848478; cv=fail; b=H+mGcnFWYdeeN1DIunaOPbYAxKwQSBt2Noi9UQFIGehPTwJIKh3zmoGmw3D8/ICAJ9JwhIAwKsLHkddpa9klVFTXM6CM0XEaL/jRl4rWwT+ewbo8/EDC5mjHmaRqXh2nyJt1EogrEn5eRaRHgzFEoZjsWuxZJKb5eK6FS0ABmSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848478; c=relaxed/simple;
	bh=hmgHHAsfAlgDo4WNtcDAyFhuWEKCM+hCQWZ3e4+iv8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRollznI/FCFoP6n2DMtsQ7xkostTzowOEGQtCO5NpIwndSUJY/rLuz08gGl3Bdx7yLeVAzOBxOzMu9slrmeD5Sdz/w1au5PowwUtqNeZ4XrAGIfxr9nohvnWOufrB2IzNYm+PfnrWCpK12igFb+2Ea4DLXvTLV6upxda0uT5T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dJLhRji4; arc=fail smtp.client-ip=52.101.69.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymPLy1N6pdLT0Eeo6p2r5/qYtDpRXoVc7xKWzNfMNNbGupclvMEcY2D1UX3mkAFYiQ9LluK70UnO7LfTCuKXTLXb9HOe3y9ins8VtdevkTr24PTnkIG7D3JVWHkZs6tCh4cq0TNdESD8oTIweQQEyMOgdzp91lhTDAgdhsBRxscpdXTizjX4THgMYXWGZJXrY5icA5gusSxqNiuDgSRAiIOAmHch+mD6ZicVRNALuKnWP6sLDynNMl4xMHEIzSms/zXBWl985OcfSHq5tHaSUCGkSM9dEQF+ZvyVWsQvDhxxHOnVFM3h2ph2v00Oh2BA1qBKDI4h/CjJhkXzYQLxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ9lchobSW4bPs5ztmT4d/dC2S4BO1ySrRki6sMJRBM=;
 b=mnUOnXEnfFi9tZ8xbE4i7ZfANqzIBZ6GNHj6zJApPgcX3ZmPWhDDBbLJOH02FlAqyjLLTCYqMIA9S14RWYrVmc50WIvtCvgpMkVwSad+JqvIpM2HKN2VRNjj/s1k8HtNuiT3SwRs8GBMYCFQAIrplTdggpPFgQo54mPAcgWLOeVbsOFHe1zVhms41MH4KRABGSt15+SbmHeqPYkNtVhX5L2zld/E8H2x5jf99q4oKt850k7B6nbdI1qkE6Hso7+koW+HXcjAwr8kNl15Ld24Xkc+ol8dFJEdEIa3rOvUnYczHUg5LI5s2oEJdxv5pU1JQpWRoQHJi9yT2CC3SfAODw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ9lchobSW4bPs5ztmT4d/dC2S4BO1ySrRki6sMJRBM=;
 b=dJLhRji4h+gcHuD+0fUrlFaoVnITl+CkQDpO90pjyJmuFHmgHS25mv6EBqBq+uFw8sU2tRkuAzZyHVynGQWrd6drOAYpIJrLzr5ymaw1Eb2opdAfiDmJc276TeS0VdpJc7lG2NBoX1MFL3NR+0MaSUp4YnryuLMuAEXfjw7YyTPWn7oLvPPLf8p93LZ5CVPpOkmiQtt/FuKw+sZFgLjRUOPaAcTxJYVn+mvrlQfztz6UK3L4lqEdCLkqGTI6HasHCy9aSNkfRF2RSaoOeY+9tOUmgYFwfXDxTvP9bw9xu62/7L4sc7B3PrsD28mlzs3TK3rI3O5N1NKbSF3Q5cQzdQ==
Received: from AS4P189CA0066.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::14)
 by DU0PR07MB9589.eurprd07.prod.outlook.com (2603:10a6:10:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 18 Jul
 2025 14:21:09 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:20b:659:cafe::d3) by AS4P189CA0066.outlook.office365.com
 (2603:10a6:20b:659::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 14:21:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21
 via Frontend Transport; Fri, 18 Jul 2025 14:21:08 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 1999F201C8;
	Fri, 18 Jul 2025 17:21:07 +0300 (EEST)
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
Subject: [PATCH v13 net-next 11/14] tcp: accecn: AccECN option send control
Date: Fri, 18 Jul 2025 16:20:29 +0200
Message-Id: <20250718142032.10725-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000193:EE_|DU0PR07MB9589:EE_
X-MS-Office365-Filtering-Correlation-Id: 9844fefb-87ad-43b4-6200-08ddc60656f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THh5bFdBUTc2c3VPK3BnN2pQN3pVcFpLVTVwTjhoaFhUdG90STBmMnhrRmpt?=
 =?utf-8?B?b3lqWHZKb0U2NFFKMXpscDU2c1FYbXBDNmswZndFL0xvS2hlc0prbWZwdXBS?=
 =?utf-8?B?RHhGYjk5Rm9Ma0NXdkVsZTkweXZDem5nTVhSNjNMbjlJQmM4TU9FN0FsL1Br?=
 =?utf-8?B?SjIrM04rZnUxWWdjWllEbWxuYjB2UkxmcFZULzVhWXZVdVNTTGJ0RHBnN1pB?=
 =?utf-8?B?NDExd3U2L0hoY2lJL08vOWVYajlGVVRJVFRsSHNUOG9QMjFJbmkzb3ZWdHVh?=
 =?utf-8?B?K3kzcmxuYThSM2wrRkJCQkFjRDhDK3hSTndCcUpla0p1d0R0UGFsR21zdGFr?=
 =?utf-8?B?dXNiWm1xdE5uNnhmTmN4Wi80RU11RXVhVDByMFVVR3ErZ0x2dDkwaEtsdm5s?=
 =?utf-8?B?b0ZOSHI5UU9qeStzdmFwamc5YlVaQ3JJdFFlUnBieFZEd0pjWmF6WVlyanNN?=
 =?utf-8?B?SVR4eWJVSGR5RW1EWk1rRDVXb0ttb0Q2MzRGMlVSS29CdVFVV08zdGpNLzVT?=
 =?utf-8?B?d3Uwd09BK0YyeE8wcEw0YjFyclM4SjA5TGl1b0lHdDJpQTZLNWRIdklmRHFM?=
 =?utf-8?B?VWJsTStyellCNmszcUJkUEViaWJ5ZThzVGlnSkF1QWxuSjQ5WHJETndwWDlt?=
 =?utf-8?B?cG5vZ3gwa1A4eUp0NUd2VXJxZlBNZUs4Q2pkbzNzemlUQy9iZ1hUU2VzREJR?=
 =?utf-8?B?YU9hM2d5YUswNHNyN2JBMGNrczZUVlFBbHh4OTJBekQvS2hzVXhnQ1JkL3R2?=
 =?utf-8?B?STBVdXIvMUw5bHB6VnhZMTladkJVT1h3dmdvSjlEMlZWWDR6S2M4MjNlako4?=
 =?utf-8?B?VGxTa2NtY1NQampTd2Rzc29mWWpoWlIwSmc3Mzk5U1c2WVJSNDJjNFRIaTB5?=
 =?utf-8?B?blBPNUd3UWNBRjd0QmRFVm9jTStzajFqcG9QWXlhK0NrT0J2MUs5bFdxc0R6?=
 =?utf-8?B?V0VNb1g0bTBnMk9ndG9xcDV5SWEvRFlndUZ1YUxSK3FiUlRSNVpBVDZ5cm1j?=
 =?utf-8?B?bGdwQXpPeHgzOWdENW8zOC9OcUoreEFtMFEwekQ4VHlPZUpYcFZJSVZhZkNo?=
 =?utf-8?B?S3ZmUTdiOEtsUzFGZzBYZHhDcENheUhnWEhyTFp6S1RQSFdzaG5FMVVIM0Rl?=
 =?utf-8?B?eWMyR28zbDRoakRBdmxkdnJxbHA5VEE5T3RjMzh5NmhHeXh2TFZmcEhJQVpt?=
 =?utf-8?B?Z2R0RzJiTHZCSkM5WnQ2dEY0R2EwL0FGVDQ5d2trZEx0a3RDSGo0MHJ1NGZ3?=
 =?utf-8?B?TFFKamtoMVVha1Z4azRPMU1OeExCcDZQUzZPVkVwODFYeXl3cDUyb3VwZE05?=
 =?utf-8?B?T21PaHdPb0pCSkpaZGpQQ0VOOHpBWWNEWCtDeWVNZDdQTWk1REJnQXJDUnpP?=
 =?utf-8?B?K1NDRElTN1hod3BLWTk3eE1tSWFRejlaaU5kWVdLd3RjVTEvUjhrWjBGLzc1?=
 =?utf-8?B?eHorL3ltZHY5N3JOWHQ0emxmSmlXdmxJOVpUTE5SMGd5aXFJU1dMcFpWYm42?=
 =?utf-8?B?ODRwaVRLTHA3SFBVYmQ3L0FScGVORnlHd1JiWmV1UHd3aCs1UWpiK0RIL01n?=
 =?utf-8?B?RlBUMzlFbjVPK1l2bHJ2MG5ndmlrSElBL204MS9ES0tvNkI4aVdHdTBZNFFK?=
 =?utf-8?B?bzh4Y2tzNjhWcjdCdDkvcVpnSmUxYWVkR2JIdi9kRnA3M1Y5Y2t1M2JOWGtN?=
 =?utf-8?B?SXdDbFBLeFVKZjFpTHQ0V215ODJoRUlnTEdKeG9GV1RSYm4rVjhYUFVFQm5F?=
 =?utf-8?B?Qmx1d2FHTk5UYnVrM1F3NHRPYlUyczR0a3o5c1B3Qng3ZnR5bVZ3cllzTXJj?=
 =?utf-8?B?eVhxUEtCcVg0N25OVHRCbjRLV1Bub1ZaZWVsaHJHZDFwS3JmSUthcmU4bGh0?=
 =?utf-8?B?Qi8zKzRmdTdiWnZLcUZkeEJnL04zM0FqVkkwemVJRXd4NmQ4RXVFa0pqVXZC?=
 =?utf-8?B?YjRTd3lpNDRFRHdod0lCa0NTc0xlb2xBMFpHN3ZIV2diNzhvRlJSZi9OWEN1?=
 =?utf-8?B?aGFWenFocW8xTCtQVUhaRHVzK1lDM0xKbTQvcGFLUWpCV0JiZGV6WkphNlRi?=
 =?utf-8?B?TU5xWnlaQTBCdGM3Wk01UUlqeG05ZE11b1Z5dz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:21:08.5155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9844fefb-87ad-43b4-6200-08ddc60656f8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9589

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
v13
- Use GENMASK_U32() for bytes_mask of tcp_ecn_received_counters()
- Make tcp_accecn_option_beacon_check() consistent
- Use READ_ONCE() only once in tcp_established_options()

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
 include/net/tcp_ecn.h                         | 52 +++++++++++++++++++
 net/ipv4/sysctl_net_ipv4.c                    |  9 ++++
 net/ipv4/tcp.c                                |  5 +-
 net/ipv4/tcp_input.c                          |  4 +-
 net/ipv4/tcp_ipv4.c                           |  1 +
 net/ipv4/tcp_minisocks.c                      |  2 +
 net/ipv4/tcp_output.c                         | 26 +++++++---
 12 files changed, 107 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index b9da5c96eb2d..f731e39a2ce3 100644
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
index b941151f8c0a..d4dc01800945 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -109,6 +109,9 @@ u8:2                          syn_ect_snt             write_mostly        read_w
 u8:2                          syn_ect_rcv             read_mostly         read_write
 u8:2                          accecn_minlen           write_mostly        read_write
 u8:2                          est_ecnfield                                read_write
+u8:2                          accecn_opt_demand       read_mostly         read_write
+u8:2                          prev_ecnfield                               read_write
+u64                           accecn_opt_tstamp       read_write
 u8:4                          accecn_fail_mode
 u32                           lost                                        read_mostly         tcp_ack
 u32                           app_limited             read_write          read_mostly         tcp_rate_check_app_limited,tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 066bbd70912f..3934961c9b33 100644
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
index 4e8d6a0a4171..4516b4910fae 100644
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
index 6bf5b3b7c648..5e3f91bbd317 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -176,6 +176,17 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 	}
 }
 
+/* Demand the minimum # to send AccECN optnio */
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
@@ -256,6 +267,7 @@ static inline void tcp_ecn_received_counters(struct sock *sk,
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool ecn_edge;
 
 	if (!INET_ECN_is_not_ect(ecnfield)) {
 		u32 pcount = is_ce * max_t(u16, 1, skb_shinfo(skb)->gso_segs);
@@ -274,9 +286,34 @@ static inline void tcp_ecn_received_counters(struct sock *sk,
 
 		if (len > 0) {
 			u8 minlen = tcp_ecnfield_to_accecn_optfield(ecnfield);
+			u32 oldbytes = tp->received_ecn_bytes[ecnfield - 1];
+			u32 bytes_mask = GENMASK_U32(31, 22);
+
 			tp->received_ecn_bytes[ecnfield - 1] += len;
 			tp->accecn_minlen = max_t(u8, tp->accecn_minlen,
 						  minlen);
+
+			/* Send AccECN option at least once per 2^22-byte
+			 * increase in any ECN byte counter.
+			 */
+			if ((tp->received_ecn_bytes[ecnfield - 1] ^ oldbytes) &
+			    bytes_mask) {
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
@@ -349,6 +386,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
 	tp->accecn_minlen = 0;
+	tp->accecn_opt_demand = 0;
 	tp->est_ecnfield = 0;
 }
 
@@ -431,6 +469,7 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
 	default:
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
+		tp->accecn_opt_demand = 2;
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
@@ -451,6 +490,7 @@ static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 		} else {
 			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
 					  INET_ECN_MASK;
+			tp->prev_ecnfield = tp->syn_ect_rcv;
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
@@ -549,4 +589,16 @@ tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 		th->ece = 1;
 }
 
+static inline bool tcp_accecn_option_beacon_check(const struct sock *sk)
+{
+	u32 ecn_beacon = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option_beacon);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!ecn_beacon)
+		return false;
+
+	return tcp_stamp_us_delta(tp->tcp_mstamp, tp->accecn_opt_tstamp) * ecn_beacon >=
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
index 8bdc9f81cc49..7002f6347119 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3393,6 +3393,8 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->delivered_ce = 0;
 	tp->accecn_fail_mode = 0;
 	tcp_accecn_init_counters(tp);
+	tp->prev_ecnfield = 0;
+	tp->accecn_opt_tstamp = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5111,11 +5113,12 @@ static void __init tcp_struct_check(void)
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
index 41798c7ecde2..1a8c40b573e4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6113,8 +6113,10 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
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
index 309beb6e0ea8..8d0d673d17a8 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3583,6 +3583,7 @@ static int __net_init tcp_sk_init(struct net *net)
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
index bd59278062aa..3c755a6d0f9c 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -705,8 +705,12 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
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
@@ -1149,11 +1153,16 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 		opts->num_sack_blocks = 0;
 	}
 
-	if (tcp_ecn_mode_accecn(tp) &&
-	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option)) {
-		opts->use_synack_ecn_bytes = 0;
-		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
-					       MAX_TCP_OPTION_SPACE - size);
+	if (tcp_ecn_mode_accecn(tp)) {
+		int ecn_opt = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);
+
+		if (ecn_opt &&
+		    (ecn_opt >= TCP_ACCECN_OPTION_FULL || tp->accecn_opt_demand ||
+		     tcp_accecn_option_beacon_check(sk))) {
+			opts->use_synack_ecn_bytes = 0;
+			size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
+						       MAX_TCP_OPTION_SPACE - size);
+		}
 	}
 
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
@@ -2863,6 +2872,11 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
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


