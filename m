Return-Path: <linux-kselftest+bounces-34567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74011AD37C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDAA16E8AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 12:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D26A2C17B6;
	Tue, 10 Jun 2025 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dlLo4wD8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E722C032E;
	Tue, 10 Jun 2025 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560014; cv=fail; b=Y1Nru4XbM1yOJIeCCE7oY/PQDuMlJqQa/4A/PpkyxeB0WFv031cVOJBt0WIynzSeRqEe1skIHVMHUpaCn6LAAIhq7OHP3sB7siExKjDsTQyfBn8deFtV9ryq9+VKLb3LArZ/rAwl38Za30A9imHEYId/ITDAdyzPgg27yjJaVtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560014; c=relaxed/simple;
	bh=SQFRGebUzeXWT9TfhrR0PX1s/WGoJ7naY6uW61cD9DY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nl2feqMKAugUkojtJeOuVQ0hUGTekPH2AbY5W4y+1bnnreiCUofnzp851e8LMbOOr0Nw63op7B7cK71L2t/4qtwUNrN+aIhy62nu5Fy2tHDHyTbAQGYnjNiG5QyW4cFW4J3E7yha/5rhDgi2WEL845gGkSklyRjmkeb9otqwbMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dlLo4wD8; arc=fail smtp.client-ip=52.101.65.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fbez0SCeSDO00Me929or2QJsmPWuUGWrMcxEqgNI8kLtK8HZIUaJaENaS8QySYCSb5ruwYuoJKJ5AJG5IMlprrWJjRnrZrOjHuSt1PckrJ5o8vIvQEakj/DjFY1OOyytbHczZkImuxpHGElrMQNvXMfrd3YDQ02Ngrn7+SpqYHifjj7VIniwSvZv/E4M/+91t1JTLElOmNN15WnH8QxLFkzDVkP9OwDWt2P5zqmFV51ow8Rwgg+6qGIFjqNLrr9DqxEfI855J0d2fzRbmIutSQneQ2weNGO8+vtJ0qVBhgFGizqSY60TjUD3360DBdXa0IpCRC7ck09wMtGUZiyxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KFcxbBjwa6Mq1tkQYvtk9sRNTnJmu9m7jqwGX+OOOM=;
 b=RTwmN9oGMvvSkS60CQWStHSRKI46tW2ydotVKGmrmsbDytgSapUyxyOa7XiKhh/nGiQdERPfIUErSeP1VIm7FvxCnVnyC/AnS9K7qBnmCBkoazeTpsYtOxIlX7yCXbhqulX8I6r+nRNTeEXECzE0igpQLqzxmA1vBOClw82MCIJBwEgVD1RB4kVegwXIAjF0nhczT8JuPvSBixuKi9i4kyH5NXHJ/SMyzae2+eiYe4ejoGFzejUs3tkumdeQgfGRwCTcFZp/Yqu6dA43v33AkyqpAZ8AAvBNrG5gOzwhhDiGMWSM4jYOZ+TyCLlxZC6+71OvSRGLQCnIwdbAmREsDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KFcxbBjwa6Mq1tkQYvtk9sRNTnJmu9m7jqwGX+OOOM=;
 b=dlLo4wD8PcdpV6Va3uMBH1jcBWjCDMU/eKnlYOcwpMjW/pgrNo0uuJCndAixwkWAAkuRwPlcpSg5+xV6Yb0cEtf6JHe3zlr/LCu714ZFMAJlasygZIFz88BJkd6GbtSC2ecD7XpMJtzZmoSyqMRWaYeZGCXW5GrLkr3chlbiECO8hBePWFS88YSdgQ5/hTi28lzzXI14Y1zfPW/tb2ubvUD6GbI9BEIHQTG9mR5RxXbbQbBUt5GwXbmflAi2lGHmNINajiuuZaSS6qPK6qtfKNBtm7yGHAH9b7S5flhUrVWbegDMd99EOf0AAr9OZdntyHKATCv42Ae/TwnglfV4WQ==
Received: from CWLP265CA0520.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18c::23)
 by AS8PR07MB7365.eurprd07.prod.outlook.com (2603:10a6:20b:2a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 12:53:29 +0000
Received: from AM3PEPF0000A793.eurprd04.prod.outlook.com
 (2603:10a6:400:18c:cafe::57) by CWLP265CA0520.outlook.office365.com
 (2603:10a6:400:18c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 12:53:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM3PEPF0000A793.mail.protection.outlook.com (10.167.16.122) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 12:53:29 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id CEE4120099;
	Tue, 10 Jun 2025 15:53:27 +0300 (EEST)
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
Subject: [PATCH v8 net-next 06/15] tcp: accecn: add AccECN rx byte counters
Date: Tue, 10 Jun 2025 14:53:05 +0200
Message-Id: <20250610125314.18557-7-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A793:EE_|AS8PR07MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 7846b1d9-6e2a-47bd-f4e2-08dda81dcc65
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cHoxeDVMNlRMeU9nY08yWUZFSEdYd2NzV1F5RWc5bDZhRUtqaVMxanNaUzlt?=
 =?utf-8?B?b0RLM01vVGF2T0laRFpTZHNZR2tnTXFqSk12WExEV3REdWdJOFlEL0FzRDFs?=
 =?utf-8?B?clBFQW0zeXFCWURzVy90SFpRTENyNEdmQTBKdld6RUJTaXBBQ3dpWjFGcjdx?=
 =?utf-8?B?OWdNSVl1dlM5eFRsZFJ3ZzlaRHFaMXJqb3JGbVNvYUYwUFRHYXRURjhRR2Ix?=
 =?utf-8?B?YXlROG9BanBBL0ljbUtsVnVQa3laRDdtT280TUwyTjhvU2gzb3hRQWY4dDBn?=
 =?utf-8?B?N0hyMFE1Y0tqd1dLTVdBZlBiemVkVTJPNUpoclpSR1UvczVid2pnQkpsYXJK?=
 =?utf-8?B?S3l1MEU5ejkyS1B2TlduYjk0SFRqNHFsT1UyTUtOSzd1aDdiK1dpYnpHWGlE?=
 =?utf-8?B?czAvNGUwYXlkVThlOHA4WXB4RVpoaEJzVEpYYng2ellxZktjV0ZkYW1RVy9O?=
 =?utf-8?B?bmJScldhUXkrSElybU82d0hZOFZOSUcxaWVPc0NtM0kwYWVXMHo3WUhSdVhD?=
 =?utf-8?B?bW4zVUZJU3ZuQXY1N3U4aVZkWEQybEV3V3JUaWVWdjhxekxZQ1VUWFRuOTUr?=
 =?utf-8?B?dzdYLzAwS2VLcmJ4LzNjSzFsYXZybW1QMkdMRkV3RXFCdFZybFpZdkUzZ0Na?=
 =?utf-8?B?ZGdYODZtSlFJbDVoQlU1aGVPamNPQ0Q4bHg2RytJSmdIODFqVnFsOXdWd2Z4?=
 =?utf-8?B?WnhJb2hwQW05WmVNZ0lmSW81VTNFdzRSRjFtL1Y5eUVhVVhrUHJCaVlaL1B3?=
 =?utf-8?B?MzE3WC9WdzROTnFLY1VIbDhBOVdGZkxQSWp2dnliMEpMUmthOFhacUx3TGVo?=
 =?utf-8?B?NVdweHBkL2pEd0tISjVRb2p5VDdnUkJ3NUJYZUlXRjc2Qlo0eUprVFEveGNr?=
 =?utf-8?B?Z0dFU0J1Y2lVdHhFTW9CejRwRzBxMFl5eGIrY3lWZDhsYkFXaWxrQTlWeEdo?=
 =?utf-8?B?Y29rUGRjYzRRZFhsRjR3TkJpZzd4NVh1eldtS2M1ejZiVENlMmk0Z3RNUEZT?=
 =?utf-8?B?MWtpSVFPazJLd3h3cWZGMkEwNWlLSXFnRDd3ZlVNM0VkTnR6aTQxK1VqL2tw?=
 =?utf-8?B?UlpVMVZXMWNCZkNxQjE5RU9SSVF2U2tiOFBFRXZMc3pGWngyc3ovbzc0Wmpi?=
 =?utf-8?B?QXBBSUpYUG9kMWN1ZkdhNTVYSVR3ZVlzS2s4UjExNGYxK0pLTmxsWk93TGt0?=
 =?utf-8?B?QzdzVnh4TU5CU0Y2QngxdStiQ0s1Nk8wV2pkdzJrTEZ4NDlZRmJNYTZqNUNp?=
 =?utf-8?B?WkRXd3Z1NlN5bTlVMTdFdFF4TjdlcEVVVlIzNEU1RkM3ZVFVSnF6R3R0YnBu?=
 =?utf-8?B?Q3JYS2FueURMRTNUWGU0bmVmeGg3dnhJdUUraXhZdlkrWHZVWkhwT0l1Nzl5?=
 =?utf-8?B?MVF3eTlaVUlybDdvcUowcEEyS1VEd3h1T29RZ0RhU2dJc2NGSEFOaTY2RTVa?=
 =?utf-8?B?QTh0cEFlZXY3VzZCdTlHS3JWMEkwK3dIcEp3OUpQUmVsbFYxSmppOG5mRTYr?=
 =?utf-8?B?SHBwR09xSUozeG4yQlN1U2cwNy9NSWVRN1d2dUNBL0ZCc2NNYks3RjRUY0F0?=
 =?utf-8?B?ekx4emtyd3p6eEtIcHJmWVdReDdkaC8rMWROQW43WmFhaU5oc2dyMWp2UEt6?=
 =?utf-8?B?elQxOEhPTHFBZnBtT2FPM3JKNDFRcU9XS25MT0t2Q2Z6S2oyNkJJQm1hbi90?=
 =?utf-8?B?V1hvYnRIUTVZSkFYQW1KeGZOME9BZzh2cWkycDEwSCt0dTZHU0NzMy93cWN3?=
 =?utf-8?B?bVgyZDVtcmhlZkwvdGFMV01ubm9xZEFhalJsWFdneHBoUVJ5MTFGWlZaUlJZ?=
 =?utf-8?B?S1ZKcWNqVmw5V3ZpWnVhU21mSFlVRzJ2TisybzJlZWpWSkZMa1pERjdueFNo?=
 =?utf-8?B?RnBlVysyUjRMSHQ0dkt6OUtsMWh0WXVKOEo5NFZFYlV6UEdOaGdESGdJSHdX?=
 =?utf-8?B?dm44cDJ1TzNOeXhUMjR3ZnZmV0EyWDZWa1ZJd3RDUEg5MnZqNXdVdFNOeHdr?=
 =?utf-8?B?MnRBWTZjNzFBS0VSeVdwWThLRFlMNlQ2akZ2NnBlK01nbkVHL3JIRnU3dk8z?=
 =?utf-8?B?WjhRNEJZclpTKzFlN2JBRGtoamJJdjhoYXk1UT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:53:29.2539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7846b1d9-6e2a-47bd-f4e2-08dda81dcc65
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7365

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
 include/linux/tcp.h                           |  4 ++++
 include/net/tcp.h                             | 20 +++++++++++++++++-
 net/ipv4/tcp.c                                |  3 ++-
 net/ipv4/tcp_input.c                          | 21 +++++++++++++++----
 net/ipv4/tcp_minisocks.c                      |  2 +-
 6 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index eef8700085de..64306ae096cd 100644
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
index c25110f36756..98af3ce97767 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -307,6 +307,10 @@ struct tcp_sock {
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
index 5fce4b49e132..0110df8b5571 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -467,7 +467,10 @@ static inline int tcp_accecn_extract_syn_ect(u8 ace)
 bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect);
 void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
 			  u8 syn_ect_snt);
-void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb);
+void tcp_ecn_received_counters_payload(struct sock *sk,
+				       const struct sk_buff *skb);
+void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
+			       u32 payload_len);
 
 enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
@@ -1035,6 +1038,20 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
  * See draft-ietf-tcpm-accurate-ecn for the latest values.
  */
 #define TCP_ACCECN_CEP_INIT_OFFSET 5
+#define TCP_ACCECN_E1B_INIT_OFFSET 1
+#define TCP_ACCECN_E0B_INIT_OFFSET 1
+#define TCP_ACCECN_CEB_INIT_OFFSET 0
+
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
 
 /* The highest ECN variant (Accurate ECN, ECN, or no ECN) that is
  * attemped to be negotiated and requested for incoming connection
@@ -1053,6 +1070,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 {
 	tp->received_ce = 0;
 	tp->received_ce_pending = 0;
+	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 }
 
 /* State flags for sacked in struct tcp_skb_cb */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 16e8f866f984..632a69126f6f 100644
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
index f14eb93cdb80..ccaa768db145 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6130,8 +6130,17 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
 	}
 }
 
+void tcp_ecn_received_counters_payload(struct sock *sk,
+				       const struct sk_buff *skb)
+{
+	const struct tcphdr *th = (const struct tcphdr *)skb->data;
+
+	tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
+}
+
 /* Updates Accurate ECN received counters from the received IP ECN field */
-void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
+void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
+			       u32 payload_len)
 {
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
@@ -6146,6 +6155,9 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
 		tp->received_ce += pcount;
 		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
 					      0xfU);
+
+		if (payload_len > 0)
+			tp->received_ecn_bytes[ecnfield - 1] += payload_len;
 	}
 }
 
@@ -6419,7 +6431,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 					flag |= __tcp_replace_ts_recent(tp,
 									delta);
 
-				tcp_ecn_received_counters(sk, skb);
+				tcp_ecn_received_counters(sk, skb, 0);
 
 				/* We know that such packets are checksummed
 				 * on entry.
@@ -6465,7 +6477,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
-			tcp_ecn_received_counters(sk, skb);
+			tcp_ecn_received_counters(sk, skb,
+						  len - tcp_header_len);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6512,7 +6525,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
 		tcp_fast_path_on(tp);
 	}
-	tcp_ecn_received_counters(sk, skb);
+	tcp_ecn_received_counters_payload(sk, skb);
 
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
 	if ((int)reason < 0) {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 779a206a5ca6..f1e698c323f3 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -500,7 +500,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
-		tcp_ecn_received_counters(sk, skb);
+		tcp_ecn_received_counters_payload(sk, skb);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
 				     TCP_ECN_MODE_RFC3168 :
-- 
2.34.1


