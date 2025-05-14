Return-Path: <linux-kselftest+bounces-32939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E5AAB6D8F
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 15:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADD21BA0E95
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 13:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADEE27E7FC;
	Wed, 14 May 2025 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ApIdg+GC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A1F275853;
	Wed, 14 May 2025 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231026; cv=fail; b=tkcQQJcgCQkA9M4HJKeWc8bCdDN24weNTQ8WdfYhfbrlj97qWFIF2OCDCI0QixQ1mASlFdfhnPMpfGrbmOaKcrvOS3pne5xzOd8FI3C0jYxbhuKx7iugz9aqvUEtAydx4+zMOEgKAjss9iluB1Z71WeGH5E8OefJFVmSUYPuKhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231026; c=relaxed/simple;
	bh=9qmujAjk4RWg91NaBZA23iQgM+Gxiha+wF+iwobw0uA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n75Dc1RzRGbh7oXtLv5cjMgeoCPLbrTX5+zbz36ZxrXwlnKZAbeclgLKRuXeQlOaAX9K8nNphAUaGdu67EBNNkOwkYo4j47s+13RQmY7u9B8cUbDI3AkhQzGXGLToWZzKLQr/qOnxBzQKJcS4nCSNCUtAC9x8bdd2CKReRIrd9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ApIdg+GC; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KE+8Ssk8w0DbDswbSoJcz2wwEI+XvvorQIia3k69iaywrBKeWmqOZzBZSyQExD/RBomVGlSSeKjiwFCaivsXKxqCKsqsPYKWbfMNeuZcEs7BNBmSlp3Vcq1GhfZ/BrMeN9R0iOZoTRw5nvakVoM3Oa368gaBGhi+4g2vrMkEacQVIHlt2r2veeCGlWXzdMKHupR2Voy/PMDRad+tkp2IdZD49rdPrAQyCTWgJRE5uIIkq2D0ypnqr/VgG7pgresjRcJbV5NUL1V0CvVTcKNiimxBAyXSfFDsORQmkezSJNXprv7gLyaAEZIRnS2M1b64r2QPoasVP0xxnhJOQDdxgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7F71i36/NPvNde2+sbLfpGH2LLOkU+UOArXF07/SJI=;
 b=T/49ek0LwyEHqYH9GRxrwcAb7CtrWopTkkD4t5lF1v+toTls87lOGN9GDvouq6Kt3MWxFNL6Q2n5zRd3DK4ZlA/kRDs47o9ltRq/zw1IDqlFHESO/qReRZZqiTwLAsTA5TLpVbJg3pT3lYt6AanoWrvVQnbvyyLg96PmxSAKm7Fj+B2RpJ31MNO6mRvV/l2P1p+CLYFSVGAIqeDs4d8vQABJaOm7DXAFlOoksPjWgkR6H5FDBQ7QEdCKZQmZ7RB8htypvm3kUrQjJMozCy172PPWLRDZl/40gAddp3JcmptLXYIqZg/saa+5/eJ3SVZOfuJERJO/t0ORFHd/bVIyGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7F71i36/NPvNde2+sbLfpGH2LLOkU+UOArXF07/SJI=;
 b=ApIdg+GCwwnTbB9dtWUFQEdFYT8oEbqhXUPlERM38d++ND+62kJjDTfLvwbCKuqio7G0my9T9Z71In7qDW+FTpzmdCsfs28h3as7T2P/5vz0kx0bp80AUlz24VxahXLyX2jaRLptF4Bnm/w02DkM00+sEh88Iu0cjYqq5UWrTq/oIPLtABqcjxViB5UTqVGo6FBxH161L2rlifSOEA+5jB0cryxR4Gs2Z58l/xIQnD9u7+Lch2MtNKcrOulaT9hJ3lLaNjrKOUk32KrcjibfpFkV5Ly5lawNMYbsX5o9ADYMwudKHariJXeYUTK1oCk5M82nksMt9Lgst9cAEbBpmA==
Received: from AS4P191CA0027.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::10)
 by DB8PR07MB6284.eurprd07.prod.outlook.com (2603:10a6:10:131::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 13:57:00 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::6c) by AS4P191CA0027.outlook.office365.com
 (2603:10a6:20b:5d9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.17 via Frontend Transport; Wed,
 14 May 2025 13:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Wed, 14 May 2025 13:56:59 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 0DA292004A;
	Wed, 14 May 2025 16:56:58 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
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
Subject: [PATCH v7 net-next 06/15] tcp: accecn: add AccECN rx byte counters
Date: Wed, 14 May 2025 15:56:33 +0200
Message-Id: <20250514135642.11203-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|DB8PR07MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d02c6a-63b4-420e-b17b-08dd92ef325a
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cGtja1ZZZmhHeEhYa0dUalowUnFNTW5ha2JpQnd5Z21oU3hOV05kYWtPVDdn?=
 =?utf-8?B?MkRldS9nMkdJTld6ZXpGMDlRbmVRRWFJTlhLTWJwMk0vdThNVVpsSy9yMkdm?=
 =?utf-8?B?THlKc3RrdXMyN0NIN0dpUEM2MU5CZ2N0ZUhvblZRM0JnTFc1Tm9TRnpUTEQr?=
 =?utf-8?B?dnptdDFiMUJKYVh4Vi9lVkl4OXY1L1FXSGFGVUtzTDNrZlBIbnIzSnU0aURJ?=
 =?utf-8?B?M0YvK3lpTEJMN2lRY1hzZDdPeGZ3VkNkd09BWFdoSVY0VnJ3VDMyZUZoUzZs?=
 =?utf-8?B?cWNKb1JibTZGK1YzN2k4UFRjaG56T2p0TytCZmFxM0xhTDl3V3lHR3V5Qkdp?=
 =?utf-8?B?dUhFV0lpdU1WaHhpcVF5MGlTS0tHNWJOOXRkSjZia3ZncCtSVDFkZjlOTTZG?=
 =?utf-8?B?OG1KWk5QbkhFUjBhWHlUZEM5ZzhmU2FodWNjYWJjR3RmQTBWT1RTVEN2c2Rq?=
 =?utf-8?B?ZmdBWmZTOHlJWUU2YXEvQ0EvQlF5TzE5ZXJRS2djNGhkZFdHckR3QXlHbmpU?=
 =?utf-8?B?S1FjZjJ5aVVEK29NcFlCN0ZmaXNTWWxOUWJVWktOUkpyMmprbytJUGtnL3Nm?=
 =?utf-8?B?OGE1c3JQVExnQXRuWFRtdDdVbGJEd1ZnQWg1SHhSMzBVZFdCNGFTekIvbWpP?=
 =?utf-8?B?eEdyVE1TQ2NmRXhseTgyMU9TN29zUDdXOER6bUU1OEdlWVhWSWpIaTUrQlVm?=
 =?utf-8?B?SFptM1VMTU1TNXhvVjIwT3gzM0J3WlFraEY1MTJCM0FCUHVicVR3cjY2Q2hX?=
 =?utf-8?B?aktSTy9McGtIZjhBQlRlRkI0dXI4Q2dYUVU4YmsvbWI3Z1N1ZWROM0pyVDhF?=
 =?utf-8?B?cEpqb0ZwRjRtSE9vcDQ2QWJsTUlEQ01EcmErcWhoOGdCRmxkVVFUa2RXSVgr?=
 =?utf-8?B?ZzJXVDNYMmhaUHFudXpHaEZhcFVHQU5VWW04bVp1RGhBUVBLZWRCTEJqQmdo?=
 =?utf-8?B?cExLQTQxRUxUaVJ2S1hIb0lGQ3VjTTUxQWRFVVNHQ1hYbEE4eDlXV1k1MnZ0?=
 =?utf-8?B?UGtZVGVack0xeXd1dUE1R2F5OHI1eUtSZUN4SjNMTU4vVDdPcm8wWWphQ2Z2?=
 =?utf-8?B?elE0ajFIbTcvUTdSNWNKbFBvck4xdGhFTnczbm85MmVGeGxMMzlTa1liMUsr?=
 =?utf-8?B?RDEvam80ZXNUckJxRldvRVUzempteVM1bkVLeTlGb0psRjZITkVINnB2S1pF?=
 =?utf-8?B?a0xXTkpGZ1ZVb1REVnpYYUtpYWJBbnV3YlhxYUJlZjZtK3g3TURqS04vSjZo?=
 =?utf-8?B?Y1h4QUZ2ZlM4Qno3TGk5R1A1Z09DTGZHSTM3TTRBY0hsQmxQN2ZJMnRlV3cz?=
 =?utf-8?B?bXlqYnMxY1UvYlhkVVJrNUN6WHZ1RlFnWEwybXY5SVV6L0VXdkhWcVRYVVMy?=
 =?utf-8?B?L25sbFNmZG5wSFhCSGJETVdLQUlVQ0FMZ3VZRTZSY1ZQaEQ4NDduV2w2SE5l?=
 =?utf-8?B?MlFOSE5qdW05d2tOekNmVEt1bFluRmZOT1NLbDVqeGt5ay9LUzhkbXV6aW0x?=
 =?utf-8?B?T3NKL2ZTOE01Q2gweVMyTXlNL0IzWkZReFJtblJ1c0drZmZrWm1SYW9rWHh6?=
 =?utf-8?B?YUs2dlV6ZGFIeWNWTGtoWTJvZkh0dXRmVlV0MlNFcERCMjZuRnV3Rjd4b2Rx?=
 =?utf-8?B?OHhUOVQ2b1VPQnpzQzZYTTNhczRBRU9pVzJsdEhkSWFtMEo0bkI2Qmx4QlZh?=
 =?utf-8?B?eTkxSzkrb29HYVNtaFlVeE4vanV6QWJqUDAyUFdCcGNjdDltcU5NYnlObUtZ?=
 =?utf-8?B?NFh0VHZPWFlNUWdTb2FVZ1VVVTNhVFZ2QkxjN1loZ2taajg3QnVsTjROWE9l?=
 =?utf-8?B?TFVpYmpxTEJpNmhQRHJGUDRIYmk3UmllNDVWeVpyWVJCQm9KR2dsNXdEcG9z?=
 =?utf-8?B?RlpHUHVTNGFFbXpvVTFmSS84NUYzQW5Vci9hVTIwR1pPdHZVNE11NUFENkh6?=
 =?utf-8?B?YWpNU3pydWs0cThxWUN5QVljSzlvWVo1RTk2VjZJZjVQcEZOSlBidkwzTUtu?=
 =?utf-8?B?MWlYdVdKWlBuV0xwejVDRUsxNnljQkFlY0I0bFBjVVVNRVI3cGx5MjRGSjdk?=
 =?utf-8?B?Zm05aythNnBrR1RqdlkzemhscVduNUpRZjNLQT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:56:59.5469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d02c6a-63b4-420e-b17b-08dd92ef325a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6284

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
 .../networking/net_cachelines/tcp_sock.rst     |  1 +
 include/linux/tcp.h                            |  4 ++++
 include/net/tcp.h                              | 18 +++++++++++++++++-
 net/ipv4/tcp.c                                 |  3 ++-
 net/ipv4/tcp_input.c                           | 13 +++++++++----
 net/ipv4/tcp_minisocks.c                       |  3 ++-
 6 files changed, 35 insertions(+), 7 deletions(-)

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
index b0e6a11a3fa1..427f2adab247 100644
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
index 5fce4b49e132..101e07b8a089 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -467,7 +467,8 @@ static inline int tcp_accecn_extract_syn_ect(u8 ace)
 bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect);
 void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
 			  u8 syn_ect_snt);
-void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb);
+void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
+			       u32 payload_len);
 
 enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
@@ -1035,6 +1036,20 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
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
@@ -1053,6 +1068,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 {
 	tp->received_ce = 0;
 	tp->received_ce_pending = 0;
+	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 }
 
 /* State flags for sacked in struct tcp_skb_cb */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 29146bb3585a..af52ebfdd734 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5127,6 +5127,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5134,7 +5135,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 95 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 107 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f0475f95e112..76fda2a63add 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6135,7 +6135,8 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
 }
 
 /* Updates Accurate ECN received counters from the received IP ECN field */
-void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
+void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
+			       u32 payload_len)
 {
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
@@ -6150,6 +6151,9 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
 		tp->received_ce += pcount;
 		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
 					      0xfU);
+
+		if (payload_len > 0)
+			tp->received_ecn_bytes[ecnfield - 1] += payload_len;
 	}
 }
 
@@ -6423,7 +6427,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 					flag |= __tcp_replace_ts_recent(tp,
 									delta);
 
-				tcp_ecn_received_counters(sk, skb);
+				tcp_ecn_received_counters(sk, skb, 0);
 
 				/* We know that such packets are checksummed
 				 * on entry.
@@ -6469,7 +6473,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
-			tcp_ecn_received_counters(sk, skb);
+			tcp_ecn_received_counters(sk, skb,
+						  len - tcp_header_len);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6516,7 +6521,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
 		tcp_fast_path_on(tp);
 	}
-	tcp_ecn_received_counters(sk, skb);
+	tcp_ecn_received_counters(sk, skb, len - th->doff * 4);
 
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
 	if ((int)reason < 0) {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 779a206a5ca6..3f8225bae49f 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -497,10 +497,11 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	if (treq->accecn_ok) {
+		const struct tcphdr *th = (const struct tcphdr *)skb->data;
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
-		tcp_ecn_received_counters(sk, skb);
+		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
 				     TCP_ECN_MODE_RFC3168 :
-- 
2.34.1


