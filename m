Return-Path: <linux-kselftest+bounces-36264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8F3AF09DD
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 06:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01DB161058
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 04:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B071EB5DB;
	Wed,  2 Jul 2025 04:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="X2LA0KtF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011001.outbound.protection.outlook.com [52.101.65.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286B21D54D1;
	Wed,  2 Jul 2025 04:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751431066; cv=fail; b=d0X3d2dsaCyEcQEESZM68el2IAT/mlfwsEhtCtBVq8BnWBi/9rdT04RBCozKMvAgxDLAMa0YwHUPa3nOk7zeCJJ4PZGYFQaUVmRt4MAEludBfuwEdR7y3WXy6HXboYq74wjEwtQpgMBPwh/gOEBRzFNj2++HlVNwU8idYCofF9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751431066; c=relaxed/simple;
	bh=8x6WaHXn34sCgQY3pM1Zn52OBpBFM98EPcIpAUbMO+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/vMens4hadUY06iYqNS4nE+8Q9vrsjG84SzoNjvHlFmu0+ms9RQ8BeixbwAjO6T1mbnVdWTXO2JajWIDCZjDcLArs762XOnoDUsUrvy/tmnn6Cx/+jWqt5hureFILREotLoVeneOSEuzO2uJl3vi1V9aLvSCQdRnSdZzYy4go0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=X2LA0KtF; arc=fail smtp.client-ip=52.101.65.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0+Ocqq3mP+VhJmCCZ24iHgif0f2ENFq27Ndhj+zVy9AVxIZVp7FQ6m8SRa7yhwOq/rWrf+i9pVtKCrYk9s2vxkbLK7MI3/ymAU2dtQeFJC0ANWIEWUeowMNTav+DllklR2+41yxATYFX6Vbb5VOu5jsnKOVGshf+6lAiaWf7ohYf6/MwsZSp1FMBOp87xcXrtfPzm+vP5XS7PxuxpVryxeiftUwTgf9o36GfOl8Q28jwvAMiPFKnTfnlfsCdjFmi34paAmj0CMs+PnGJ1jo+kIoQGBoTVD29zuPQG82TafLyt1/fZ+/kQ5vCzWWLMnSGD5PgDrkwk7BC/WVrSd7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxYYSvtwbMj+NUIwM/WQ10GWMIU9vgEbF9PmIh0BQio=;
 b=ah3Qu+wCWhuEVMV7dCdStoXdZ9sDu0p1duJrJ/+20XDXo3ekdKTrFYu4jZ/rhyuVUj427eOwSubHxdioCPhK64cANDbp4eKiAKDqpeCpjVGuk9M+jj/yzYurSDfayP5mIPsNnHAbXDSTMv9Te4w+2NVLlz34bu7beFNB2mkRyXMIXhEnD1P+Q7NTnc9ipdFolsQImoTIU7CSq8mN3un+x3ORSxem/L9MG04nnWI32dmhGKGgHMt5UdoZJe1Zj4H8B6u+YLamgfSTzHa4OCpqmhrTSj+weeWHsMkXhBOq5rUeVh3dqFGdba8gdkiEwBBD255V5k82lPWOl1lKEapK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxYYSvtwbMj+NUIwM/WQ10GWMIU9vgEbF9PmIh0BQio=;
 b=X2LA0KtFdK1miBWjz9b02aGR4H8o39VH/iqTysZD/rDrIFe3WyP7zP9PSdcsX+vC2Av5JvCIxwGK0CJJNuc7UxRDX7h4s1k4QMCUb69vBSJ6Zl3TVUGkUKVmFzAgeAJOoZtjyK5LkpH5XLP9GYq56JWsDC6qaIbgIx8pEm/Sfk6ECxuoSHKny9EsLVPbTj1XFXMNmiG77s9p0QiVNANz+5vGYnLSiE29rFE12+pXeN6wPMnrZIObft1zI3HpyrJUVBRig1ELpcH9WvYXCIr0UCP6wnTKlKzoxhjbIYBe0dqvLsbhhOjKEUPnovZnipewCwxX+z+imoDDQwKZNre/0w==
Received: from DU2PR04CA0290.eurprd04.prod.outlook.com (2603:10a6:10:28c::25)
 by DB5PR07MB9536.eurprd07.prod.outlook.com (2603:10a6:10:48e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 04:37:38 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:10:28c:cafe::72) by DU2PR04CA0290.outlook.office365.com
 (2603:10a6:10:28c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.32 via Frontend Transport; Wed,
 2 Jul 2025 04:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Wed, 2 Jul 2025 04:37:37 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 1D24A1C003A;
	Wed,  2 Jul 2025 07:37:36 +0300 (EEST)
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
Subject: [PATCH v10 net-next 08/15] tcp: accecn: add AccECN rx byte counters
Date: Wed,  2 Jul 2025 06:37:12 +0200
Message-Id: <20250702043719.15130-9-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0D:EE_|DB5PR07MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cfb49d6-b651-486b-cbd1-08ddb9222c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2xEM3Z5c0cwVnE0SWdqWk95YWNhT1lYYmN5eUR4RjhhZjNZK0MwZjR4d2Nh?=
 =?utf-8?B?MU9HYXFrUEF4a0lWTGpZazAxUjFVVWNuTWQ4RnBxOGx3NDVUQVhoZGNob0g3?=
 =?utf-8?B?d1U5SDBLN3B5RmpWTzZEYysvaEhKSDhlTWJYSlJQdTN0S2lQSTk4MnVyMUxR?=
 =?utf-8?B?c01MdHNYVlBMM1VscGgxWEpITmFOWEJINDVsVndKTFR6RzVUc1FjYnN6QUNs?=
 =?utf-8?B?N0xCeStsa3lydjZQVUVvMk1jejFXTUQrUnIveWgraVErZm5KQlk1V2JIUE5R?=
 =?utf-8?B?dlBPcmkzbEJxSGZkZ1hKUXV1RHNMYnk1TkdOWTNPT1paUG83Y2tlVFltV2hl?=
 =?utf-8?B?ODNROEUrbGxSUnlOVG8rU2xIMDNVa1EzU2VDZFJTY1Z4UUlaSnlvNnVRanFv?=
 =?utf-8?B?U0VDbWdOcGZycnIzQzBUdHhJWDBiRXZlZHdmTjZtbDdOeUtzOUVoTWxnTDBo?=
 =?utf-8?B?aE53czNKSEpsdHI5VnlCa0FSMUVxL0dsbnNrNzlhcEhITmI3WFdZVW1EUnl2?=
 =?utf-8?B?azJYOGhqK2dUWkR3ZHZUZU5YKzV3bWRvUVdwWEYxdytGcy9VYVIvWmRVeFJm?=
 =?utf-8?B?TVdXcTFFSUUwWlpjV0FtM1daaVlDQXhrbnJZMnROOVpPdktpTXY0VjV0akVK?=
 =?utf-8?B?WGlrNzcvZ3VqWEpIRDkwOEM4WG5JNjBqOEovSlZGeDZiRklERE9lNDFnL0ZH?=
 =?utf-8?B?UDNiNkVCdEpBS1VtdGU0TmlQOUhhN2xSTE1sV1RHT0RGY3JmdjJiRmFUa2Ja?=
 =?utf-8?B?MXZmWElPZVY2aktsUk1Md2FSTSs0M2dNd0ovSGQrNzBwOWZlaVZjNHlreGIy?=
 =?utf-8?B?WEluS2g4Vnp1OHR6RmZqM1loT2laSStVSjJHSHR3aURoLzNwdWg1SnlYNk1D?=
 =?utf-8?B?cWhselc2ckw1WEwrcVZIZ0dmcFc5WFFvNUVocGdqRHV0ZUg0SVFjMjFiSHRZ?=
 =?utf-8?B?M1VaOEVGeFl3aUN0SWxMWjE0dVNmdHA3YjhodWpNUThLbktoWkUxR2pwemVp?=
 =?utf-8?B?RWQ1MDdENEYycVhPWWdocjlFYTNacEFwRmFkMGpHWHZRVGZpNjNhTGIvTXZi?=
 =?utf-8?B?dkZmUlpaMEl2c1RrSG4wdHFnTmRyY3F2UnJ4ajR4dnJuMkpodk1yWTI2c0xD?=
 =?utf-8?B?ckFEemQxZ1FpSlMvajFYNlBKcENZWWxML255TmhGeWd1SDVIQWNrbkRGcW5o?=
 =?utf-8?B?cWpYVmVCVzhDbWh3dU5DY29UVk1wdndoc0ErZDJzb1AxRFBsM1NMNk9KckZ0?=
 =?utf-8?B?WTRFMUU0UmhDbTB4SWxIOUdka3luSngzYzBDTFNETkJwQk0rRkw1MU9VbHhX?=
 =?utf-8?B?dzBzV0s3VUV6bGtvQ25paHVTbDdEVGlEMWRnVXRrb2hiSWlRNmJmZHZGd3RG?=
 =?utf-8?B?R2hZZGZoOWNyKzdyVG5yai81bzhlL0hLSHdrUXFRT0t3ZGs0Z282M0tiTCs3?=
 =?utf-8?B?bnNKZjY2dGhvVVRmZTcraHpOSEw4Yi9KNFhNcHBMbDZOMGZWOFg4dlQ1Njd1?=
 =?utf-8?B?Vk9uZHNTams5RFRVSG0rMzB1QjhBeitBTTZmUjBVeG5xWlFoSUNlQ0IwM2Uv?=
 =?utf-8?B?Yk91a2JFaEdSM29od0pXT1V1M2dJL0JSVkVyZ0pBdmVwVUZwc0o0ZnFGNGpE?=
 =?utf-8?B?c081cUpOc1IzTGdnVkk1dmxlMjBMUmZvR1Vjb3JhUTVnbWxqQW0zNTY5MW5N?=
 =?utf-8?B?cWVzU2tnd3Y5ZXFIK0k4R0ltMkNwbnRaMFBmMWVJaWlwdCtSY0c5NXJFODNy?=
 =?utf-8?B?VHRHVDY4TTRVNm0rOHNsamttY0hzZ0lpYnJQZWU1VDcvd3IvVmdQVUlQQlY1?=
 =?utf-8?B?TitjaDVENTlGcHQ0QitiaXlSY2ZaK1dPa3kwNm5vMnBnSGlJQTNRU1Rra1c4?=
 =?utf-8?B?M2JvbDdTN1VvcEF5Q2VpVm5YaVZ0MXJ4bGtKUzB1STZEOXF6THROckkxdWI3?=
 =?utf-8?B?cHV6MkovZmNIQjMrNkg2cTNDMFR6RWlNdm5Nc0FCSllqeEQycTVyQXQ1N24x?=
 =?utf-8?B?LzljQkV2STVSUk5DMHRuUjNpeU0xNFB0eW9rWnpBaFdqUytHR09Xb05OamI5?=
 =?utf-8?B?SXgrWmZ5TDBmREJDUXYveTZmdkY4M1VNclM3Zz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 04:37:37.9595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfb49d6-b651-486b-cbd1-08ddb9222c56
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB9536

From: Ilpo Järvinen <ij@kernel.org>

These three byte counters track IP ECN field payload byte sums for
all arriving (acceptable) packets for ECT0, ECT1, and CE. The
AccECN option (added by a later patch in the series) echoes these
counters back to sender side; therefore, it is placed within the
group of tcp_sock_write_txrx.

Below are the pahole outcomes before and after this patch, in which
the group size of tcp_sock_write_txrx is increased from 95 + 4 to
107 + 4 and an extra 4-byte hole is created but will be exploited
in later patches:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ce;         /*  2640     4 */
    u32                        received_ce;          /*  2644     4 */
    u32                        app_limited;          /*  2648     4 */
    u32                        rcv_wnd;              /*  2652     4 */
    struct tcp_options_received rx_opt;              /*  2656    24 */
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2680     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 169 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ce;         /*  2640     4 */
    u32                        received_ce;          /*  2644     4 */
    u32                        received_ecn_bytes[3];/*  2648    12 */
    u32                        app_limited;          /*  2660     4 */
    u32                        rcv_wnd;              /*  2664     4 */
    struct tcp_options_received rx_opt;              /*  2668    24 */
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2692     0 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    /* size: 3264, cachelines: 51, members: 170 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v8:
- Add new helper function tcp_ecn_received_counters_payload()
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  4 +++
 include/net/tcp.h                             | 12 ++-----
 include/net/tcp_ecn.h                         | 34 ++++++++++++++++++-
 net/ipv4/syncookies.c                         |  1 +
 net/ipv4/tcp.c                                |  3 +-
 net/ipv4/tcp_input.c                          |  7 ++--
 net/ipv4/tcp_minisocks.c                      |  2 +-
 net/ipv6/syncookies.c                         |  1 +
 9 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 22ac668fe6c7..804480d39132 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -102,6 +102,7 @@ u32                           prr_out                 read_mostly         read_m
 u32                           delivered               read_mostly         read_write          tcp_rate_skb_sent, tcp_newly_delivered(tx);tcp_ack, tcp_rate_gen, tcp_clean_rtx_queue (rx)
 u32                           delivered_ce            read_mostly         read_write          tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
 u32                           received_ce             read_mostly         read_write
+u32[3]                        received_ecn_bytes      read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 1d8301f2883c..0c2331e186e8 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -306,6 +306,10 @@ struct tcp_sock {
 	u32	delivered;	/* Total data packets delivered incl. rexmits */
 	u32	delivered_ce;	/* Like the above but only ECE marked packets */
 	u32	received_ce;	/* Like the above but for rcvd CE marked pkts */
+	u32	received_ecn_bytes[3]; /* received byte counters for three ECN
+					* types: INET_ECN_ECT_1, INET_ECN_ECT_0,
+					* and INET_ECN_CE
+					*/
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u32	rcv_wnd;	/* Current receiver window		*/
 /*
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2d9011557201..62e3ed0a1954 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -652,15 +652,6 @@ static inline bool cookie_ecn_ok(const struct net *net, const struct dst_entry *
 		dst_feature(dst, RTAX_FEATURE_ECN);
 }
 
-/* AccECN specification, 5.1: [...] a server can determine that it
- * negotiated AccECN as [...] if the ACK contains an ACE field with
- * the value 0b010 to 0b111 (decimal 2 to 7).
- */
-static inline bool cookie_accecn_ok(const struct tcphdr *th)
-{
-	return tcp_accecn_ace(th) > 0x1;
-}
-
 #if IS_ENABLED(CONFIG_BPF)
 static inline bool cookie_bpf_ok(struct sk_buff *skb)
 {
@@ -981,6 +972,9 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
  * See draft-ietf-tcpm-accurate-ecn for the latest values.
  */
 #define TCP_ACCECN_CEP_INIT_OFFSET 5
+#define TCP_ACCECN_E1B_INIT_OFFSET 1
+#define TCP_ACCECN_E0B_INIT_OFFSET 1
+#define TCP_ACCECN_CEB_INIT_OFFSET 0
 
 /* State flags for sacked in struct tcp_skb_cb */
 enum tcp_skb_cb_sacked_flags {
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index eb9aaabc9866..1027edd3c387 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -176,7 +176,7 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 
 /* Updates Accurate ECN received counters from the received IP ECN field */
 static inline void tcp_ecn_received_counters(struct sock *sk,
-					     const struct sk_buff *skb)
+					     const struct sk_buff *skb, u32 len)
 {
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
@@ -196,9 +196,29 @@ static inline void tcp_ecn_received_counters(struct sock *sk,
 		tp->received_ce += pcount;
 		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
 					      0xfU);
+
+		if (len > 0)
+			tp->received_ecn_bytes[ecnfield - 1] += len;
 	}
 }
 
+static inline void tcp_ecn_received_counters_payload(struct sock *sk,
+						     const struct sk_buff *skb)
+{
+	const struct tcphdr *th = (const struct tcphdr *)skb->data;
+
+	tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
+}
+
+/* AccECN specification, 5.1: [...] a server can determine that it
+ * negotiated AccECN as [...] if the ACK contains an ACE field with
+ * the value 0b010 to 0b111 (decimal 2 to 7).
+ */
+static inline bool cookie_accecn_ok(const struct tcphdr *th)
+{
+	return tcp_accecn_ace(th) > 0x1;
+}
+
 /* Used to form the ACE flags for SYN/ACK */
 static inline u16 tcp_accecn_reflector_flags(u8 ect)
 {
@@ -233,10 +253,22 @@ static inline bool tcp_accecn_syn_requested(const struct tcphdr *th)
 	return ace && ace != 0x3;
 }
 
+static inline void __tcp_accecn_init_bytes_counters(int *counter_array)
+{
+	BUILD_BUG_ON(INET_ECN_ECT_1 != 0x1);
+	BUILD_BUG_ON(INET_ECN_ECT_0 != 0x2);
+	BUILD_BUG_ON(INET_ECN_CE != 0x3);
+
+	counter_array[INET_ECN_ECT_1 - 1] = 0;
+	counter_array[INET_ECN_ECT_0 - 1] = 0;
+	counter_array[INET_ECN_CE - 1] = 0;
+}
+
 static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 {
 	tp->received_ce = 0;
 	tp->received_ce_pending = 0;
+	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 }
 
 /* Used for make_synack to form the ACE flags */
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index e0c1e951c53c..569befcf021b 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -12,6 +12,7 @@
 #include <linux/export.h>
 #include <net/secure_seq.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <net/route.h>
 
 static siphash_aligned_key_t syncookie_secret[2];
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 31326c462396..8b767f6f9524 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5123,6 +5123,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5130,7 +5131,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 95 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 107 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7ccfde9bcfda..eea790295e54 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6138,7 +6138,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 					flag |= __tcp_replace_ts_recent(tp,
 									delta);
 
-				tcp_ecn_received_counters(sk, skb);
+				tcp_ecn_received_counters(sk, skb, 0);
 
 				/* We know that such packets are checksummed
 				 * on entry.
@@ -6184,7 +6184,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
-			tcp_ecn_received_counters(sk, skb);
+			tcp_ecn_received_counters(sk, skb,
+						  len - tcp_header_len);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6231,7 +6232,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
 		tcp_fast_path_on(tp);
 	}
-	tcp_ecn_received_counters(sk, skb);
+	tcp_ecn_received_counters_payload(sk, skb);
 
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
 	if ((int)reason < 0) {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 845b1c81b3b0..0a0ee33e38ad 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -473,7 +473,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
-		tcp_ecn_received_counters(sk, skb);
+		tcp_ecn_received_counters_payload(sk, skb);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
 				     TCP_ECN_MODE_RFC3168 :
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index f0b87a3268ae..7e007f013ec8 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -16,6 +16,7 @@
 #include <net/secure_seq.h>
 #include <net/ipv6.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 
 #define COOKIEBITS 24	/* Upper bits store count */
 #define COOKIEMASK (((__u32)1 << COOKIEBITS) - 1)
-- 
2.34.1


