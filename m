Return-Path: <linux-kselftest+bounces-37818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6958FB0D69D
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 12:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E9D5623FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 10:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBA52E4248;
	Tue, 22 Jul 2025 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="bUnpMas+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010042.outbound.protection.outlook.com [52.101.84.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0286D2E266E;
	Tue, 22 Jul 2025 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178392; cv=fail; b=pqanpMd8rdP4p3z8EZgdzVGl20vtM2cWNJctiqPHg1cdRo91NFw4AO9XSRd4RuR37cx3EkvMbdpQdwF+aAaHdcHxeogsGOM716w/7VbAeqkn4NPVrlMdu9ihKbpR0cO2jaHKP/3tvb6J2wTw1YnV42hpY/Qmf4kDlnar9g+M9h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178392; c=relaxed/simple;
	bh=F4KzWmo8fnqURFTtikfKI8Y/gXwxQ/cyPy41cYUOub0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZYNMOnEgHe0kj+gfKX7j5twS6/OVAW1zU13kLjz0Yx6IFvwXUDuZiggKLvK/G3FWYJ2adnOV1ahJgJkKuEOuw/UbCzJbLSRb3cTTJjgzNApH4YirHGY4VDdRoILutr480mBYwGSTvXl+mbEy0R5ecReG36/QSVRl93SUJPP4ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=bUnpMas+; arc=fail smtp.client-ip=52.101.84.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNyky79EXaR7sL3OzXriuQGkM1l6UHoW6uAZWPnNe+97YyHrdgu5ofceHcgPwzyMwWGHCSMT9E3XRtDM+M3TO8a0GMwIdmajoBY2BpfbSehyzyVCDtMk9t7hVuIqulHWj+5PpzWU7dkNs2vOZigNOaQBMWHYDqvDWKyeGMzgxzG1xM948oQoiRxKe8PSHHDArmM8ti/phiU1Mg1nFy1hI8Q+1N8JcfCtp1USIl83KpLg7Y0AReMfIyRDeqZtqdWkS3jygSYHMSgCx1Dh/Uy5dTn5TxI3lK4SI/Dn39u/Ngl0TmZVa55YZzG9QGTv5qE7r2QRdUZ48g2nWe/GSUuAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6H+IZzmo5rx+LKDY7gTciuHhbCBJPA5KMlOeLkRE88=;
 b=wp4dKCUkS2JsUuXfZpDGprDdjWPbN4whGvcx67vmdNu7aPXohTcg8iDw/XSFwIWu0BfiCfZgIaYX43m9+Kw/qtFV3syllQSDjrh4Jab5FHZvXEXMEaslbCev0l639xNV1bMrIIo5CvRbmD6Y6nVGjFXgCuNoiWXPNBDk9U6yao1ImuAeoxJweoTkWW1fNj1cgV8EcGDg3JG6YbDCSrKya940nMQgbcnQJmdum5ZzUrKajmneQBzPnhUron496+Mk4DUpZaEG6ZiyWW3bL1zEBvPwUiR1LQ3k9HnvJKqWQwnWXpqXzoJeDUJK+KsyhtbyjwgFTytvSP1ebmQeX7GH/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6H+IZzmo5rx+LKDY7gTciuHhbCBJPA5KMlOeLkRE88=;
 b=bUnpMas+1Pe1wkSu7VvSR2JlnBxN6HqoFno5TbJFHGxhcW8maLvYfgOoXh52wmVTbcaODnYiFHetxF3OyOWBAJ4jZ0r2zx101LIP+QDlss36uIyT88xf3WUnjsHL/TiGKviKJE+Zp0EnzddVxHwUoe9QbEWicvxnFsOZUt3UDnyJhKgjWMLR1MVgJAl0ae9lSrXoxEs89Z/3DcI43uQAFH2vb0WlaS95wGwnLikbnjRWuCGIk6TImOfkzLm5Y1/hy+pDHy+zEbJ/jmEb+OzTOwclqjxrVguP4pjd8cyQ+34vuWq8yTKhWJJl3UWSZMWgfkOZ72h4KXj382Xx/fISkQ==
Received: from DB9PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::9) by DB9PR07MB10097.eurprd07.prod.outlook.com
 (2603:10a6:10:4cb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 09:59:47 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::e8) by DB9PR01CA0004.outlook.office365.com
 (2603:10a6:10:1d8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 10:00:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20 via
 Frontend Transport; Tue, 22 Jul 2025 09:59:47 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id A08D2680042;
	Tue, 22 Jul 2025 12:59:45 +0300 (EEST)
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
Subject: [PATCH v14 net-next 07/14] tcp: accecn: add AccECN rx byte counters
Date: Tue, 22 Jul 2025 11:59:24 +0200
Message-Id: <20250722095931.24510-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DF:EE_|DB9PR07MB10097:EE_
X-MS-Office365-Filtering-Correlation-Id: df31d5f9-611f-4bda-ef82-08ddc9067dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWs5a1c1dUtrQWZEcjRhUzVzdEpDVjJ4b0pGS3NKK0xjRHFKV0h5VnY0eEFr?=
 =?utf-8?B?VWlNNkFaQzBhTGc5WHlVb1RiTzMyNEdNRURuQVIyeWU2QzdUbkdSZUJ5MlAz?=
 =?utf-8?B?K3RPTGVpRzl3ano2dzRzWFdsWG1EVzlWd29WNDNYM3RtS1FKNng5cW9lVEti?=
 =?utf-8?B?alVpOXc4bUd1MzlYZlZ3WTZHUjFlbnM5Q3MyeGthaTg1d3l5NVoraUJLbVVF?=
 =?utf-8?B?aWlHZkIrVVllNDIybmJuQW1UaXV3SW5YT3FUQ3d5em9Ud1NDOTVZZVIwb2hK?=
 =?utf-8?B?YjBLZldvQjd0eVhEZ1FjQWdQRFdSZHUxOHpHQlhneUFydDRaU2RLZm9lQ015?=
 =?utf-8?B?QlRuaWNhTDNMWlY2Y1BiSFU4QzZnSUNOQzl5K2JibnFlcnlNb0krWnQ0UEVi?=
 =?utf-8?B?Qm9JajJ3SG5paDBoaXdSdjhBM3I2T2JuSWxiVTRYVlZXWFdsNGVVQmxPTlpK?=
 =?utf-8?B?VnQzdy9TQlpWdXRFSm5GS0RPWkl0bVdSU1BHRGFBeit4N3IzSHNiSjFvWGpJ?=
 =?utf-8?B?KzVUMjBhdzJzdSt4cWc0N3A3Mnhkb1RBSE5WdzNJZmtWYk5QZWZBcFhCMDY3?=
 =?utf-8?B?RnUvWHpPemlWRlZpMWFOQlNqdTd2dXpQenM1cVRlakFxREROOEFSTFRxRXNJ?=
 =?utf-8?B?bEZLRFZVM2xjV1dqWkpRcXVTRks1cEdkTnRkUnFxQ2Y2Y3ZwQmNpcnIwRHYz?=
 =?utf-8?B?ZnByV2hSN1pyaEtKZE9QR1lmbkYvd1cvRzcxVGtWY09UN3VMT1d2ZEUzemlG?=
 =?utf-8?B?Wk9mS2NKRE8wdTFsRitmV3Z6ZXlUTlBPbVF2MVpKY2ZSZzdra1MrdTM4ME4y?=
 =?utf-8?B?QXdudnVzbHJDQlp0VFhoZnpEUzZTbDJ6RWU3bW5jVlRnaWtWc2FXOE5OUVJ1?=
 =?utf-8?B?b3UwNzR3czJDSVFMRkhjWmQvNENXWFUvUCtsSVFYTnF5RVBzRDdjOFljRlUx?=
 =?utf-8?B?UGZkRGVVeXRQSWpZYnpQVzlDQWdyaExDMXBZVHloRmxLajlrRGU3bTQxYmxp?=
 =?utf-8?B?V3liMllyRVJYQWpTZDJWazRsSzNKdlhNV0NEQmhMc2ZDTVlvdzgxWkFMSWx0?=
 =?utf-8?B?TW5NYjhuVFBGZWsyU056Z2ZGRTRMTnRPSE44V0pLR29jazBwTGU0T1JPUGl3?=
 =?utf-8?B?dlJ1YkRWbmwrMkFoTjBaVWxXeFdnV2hkZ3VTUGZ2K2Z6VERBQVRUQlhXWUZI?=
 =?utf-8?B?a1E0UUx5YUM1U0l2RERjTDkxYVZaQnpMdjlEZTJORlZzT1kvdmFSR1I3V1Zh?=
 =?utf-8?B?eW1tYnhGa3hmdkpGVzZvdExsbGt5QzRVc2NrTWdaU2tTZ2hIUnR4WnZOQWJl?=
 =?utf-8?B?MVZmZzY5UlFZYmNaUmV6a1Qrcklua1ZYYlp3SjkzYnY3NTNJb3FrL3Y0L0o4?=
 =?utf-8?B?dHdLWHNWVzJ5Y0oyYTF4WFhNYUhDb3lmODljK3R6dEh3dFowdE1vYlZWZ2ln?=
 =?utf-8?B?aTJ6TlByYm13TUJMQnhWV0VucU9yVUdZWFdVTHNVZDFSRTgwVEs4aGFVcGIw?=
 =?utf-8?B?dG9mSVoycmxzM29ud1hzR1FVQ2xFWTY1cmY1aXVNVXdESXk5MHlaMUo1SERD?=
 =?utf-8?B?WG9tMlYzZWNYVDBJVDRWc2JxS1RlWnZURHE0VEd3S3dXRUZrYkx1WStlWGtH?=
 =?utf-8?B?NzNJY0lNQXFKYy9oUnkrcXlmMFpsZmdpMlV6WXlXTXBTdThyZm1GekRvQ3l1?=
 =?utf-8?B?NEx3UitCSEtWd1RwSlNTTm5KUE03L3RuUnpwaExSNFJDYlo3eUdZL2VMUk95?=
 =?utf-8?B?UjJ0S0VNd1dZaHRwYXJxVFVkdnZnMkM4Z0s5THFDTGxDS1hIUGdWbS8wOFVS?=
 =?utf-8?B?MTQ5NnBrVWNMVllaM0J4ZjRGb1I1Um9LdW1JMlVlWU9wRlRpdmMyd3gxbE15?=
 =?utf-8?B?WEJPUTNHLzFOWTFHQk9PczczMWhuZWlJYmF5d3ZEa1VXYXlySDJNYUlGNm5Z?=
 =?utf-8?B?cHljYnpSSUpHWUx5bTFoK0F0dE1RNGplYUdrK1ZBQS83WkFISDhKc0U2Mk9E?=
 =?utf-8?B?OGlmQWtEai9yTWlRTTJDTjlodmpFalRRZXVLV1FPKzE0ZkwwWldiQXN5b2tj?=
 =?utf-8?B?bWVNWC9jMGtOa3I1c05GQStLU3pZZmZtSGh3QT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 09:59:47.2201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df31d5f9-611f-4bda-ef82-08ddc9067dbd
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB10097

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
v13:
- Move TCP_ACCECN_E1B_INIT_OFFSET, TCP_ACCECN_E0B_INIT_OFFSET, and
  TCP_ACCECN_CEB_INIT_OFFSET to latter patch

v8:
- Add new helper function tcp_ecn_received_counters_payload()
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  4 +++
 include/net/tcp_ecn.h                         | 29 ++++++++++++++++++-
 net/ipv4/tcp.c                                |  3 +-
 net/ipv4/tcp_input.c                          |  7 +++--
 net/ipv4/tcp_minisocks.c                      |  2 +-
 6 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 4f71ece7c655..5a2b0af57364 100644
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
index b8432bed546d..012d01347b3c 100644
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
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 1367d003abf2..97b2dd79c883 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -171,7 +171,7 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 
 /* Updates Accurate ECN received counters from the received IP ECN field */
 static inline void tcp_ecn_received_counters(struct sock *sk,
-					     const struct sk_buff *skb)
+					     const struct sk_buff *skb, u32 len)
 {
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
@@ -191,9 +191,24 @@ static inline void tcp_ecn_received_counters(struct sock *sk,
 		tp->received_ce += pcount;
 		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
 					      0xfU);
+
+		if (len > 0)
+			tp->received_ecn_bytes[ecnfield - 1] += len;
 	}
 }
 
+/* AccECN specification, 2.2: [...] A Data Receiver maintains four counters
+ * initialized at the start of	the half-connection. [...] These byte counters
+ * reflect only the TCP payload length, excluding TCP header and TCP options.
+ */
+static inline void tcp_ecn_received_counters_payload(struct sock *sk,
+						     const struct sk_buff *skb)
+{
+	const struct tcphdr *th = (const struct tcphdr *)skb->data;
+
+	tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
+}
+
 /* AccECN specification, 5.1: [...] a server can determine that it
  * negotiated AccECN as [...] if the ACK contains an ACE field with
  * the value 0b010 to 0b111 (decimal 2 to 7).
@@ -232,10 +247,22 @@ static inline bool tcp_accecn_syn_requested(const struct tcphdr *th)
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
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ed427a51853c..6255b2d4c6c5 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5124,6 +5124,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5131,7 +5132,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 95 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 107 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 35673e30cb11..064b26e2086d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6155,7 +6155,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 					flag |= __tcp_replace_ts_recent(tp,
 									delta);
 
-				tcp_ecn_received_counters(sk, skb);
+				tcp_ecn_received_counters(sk, skb, 0);
 
 				/* We know that such packets are checksummed
 				 * on entry.
@@ -6205,7 +6205,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
-			tcp_ecn_received_counters(sk, skb);
+			tcp_ecn_received_counters(sk, skb,
+						  len - tcp_header_len);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6246,7 +6247,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 		return;
 
 step5:
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
-- 
2.34.1


