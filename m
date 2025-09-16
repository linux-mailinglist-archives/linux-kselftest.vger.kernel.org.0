Return-Path: <linux-kselftest+bounces-41580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C268EB5906B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 10:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0ED189D574
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 08:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747FE2EAB85;
	Tue, 16 Sep 2025 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qJ9jxDmF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013054.outbound.protection.outlook.com [52.101.83.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C1A286426;
	Tue, 16 Sep 2025 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011091; cv=fail; b=Eu8Cc29Qj5/oaqDTQK8iNacAH18uHo1OHBRVuCs2KuVM0ksfMR9ZKacRmgdijqKf8EBQsvc8iSyNvyRGsBkeBXpGpvG+lKOIbrAThXLIM9AcsF/FPck9knVMhM7iESYO2yNaa/9b7HVrZd4gF+x009QQTwacXgE+pXqZzoS/H6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011091; c=relaxed/simple;
	bh=5UAT9LuCNNaqW+IdG+SJ9whDb8KRQOka+fyUTfwmqqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHR46mZ26uLjd3hteV4HEifUhmmImv5kfLqIGu8XvXV74naJNaVbhYDNWn+4Pxbxe2mX2hz7SYKUEwGgFHiiqUDDQ4XuA0pUrj4z4eI7xUmWfx8xU13G6iZIZPqU6aMdlIceIqE8UUwwGEEs4+h2Mpv3WlAiTQy5twxEJI/Esis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qJ9jxDmF; arc=fail smtp.client-ip=52.101.83.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaK8TTNh3gaBsCisXkajw4L8TfOqYYNAucDcijBpv2uZKtymgkWO7G++7AcoP5i+EC7qC4ReuoUx0nC3pC8qDh1p51AzWBYwmbbY6A5sNkAbry17rMJ1CYpOY6/wKR3+oFKOo/+sT+ZmeQEOT6vRC6K1O5Ih+XTzBc8IsW3WSpx/YXqpY5Kxyjp4bgt/05AbopGMzNNoHKpfiDn49yuOlBPROIF/1eu0ng9whMs+ZzwbZK19q1WMpQP7MPHzj9IBHAInF7rf5TQZlaFhuWh207xDlPECcGEZfC3BFZN+sVkdOzqCVSAbVV4y7OAIUeFp7jlBzQz37xMuhV2edFfkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1NzVipv5tB+0xsLgqy45+DtWBKsAf+oz7cIh0o8XHc=;
 b=oEckoOQfAwUhVFAKN+RMQEKn6LII/kPAZbK4ClZ1u5+CO+LgG+/lvq+izwh5PlxGzYMPeQroDnVTZXkOnl6BsOE5qwxsQCGHEM6VKxPfmCKdFQVRsnOqXYU0KG8V/lI3cNciTUtNSN5MGT+oK7L7+AQqzzjXAGHrftqIsfP0GpuU/HWmpB8cOUbmE2XQVAEUb86by8hDteuz0rXZ67c0hyCjFMjM7/v21+t8RDG2jIU8E5PPvsN01Z8YXECko5lpCXX5Y3V4LZHMBgQhZ14Kl7PrtxPk+iR/3GHTDa8ltHu0u9rTdjeIEBowdUBHUJz5lZElKEAbaG5hLRpoeJPF3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1NzVipv5tB+0xsLgqy45+DtWBKsAf+oz7cIh0o8XHc=;
 b=qJ9jxDmFhmb14Y/cWAb2cKZdSAOsieaEZGLdxm7hKe1N/5l5NVgbFR0m+AJuSTOxiNzSsqJ/b2Xsjhjkoug+BoiSjxpctXABiCu4AMq7JZzzq112SmbbN9sLJQkK3jE4x4Adtnj3ti+8Np/tpC5iZ42ALV9VDWWf7ioxv19G5XlfgxXPgldS+/AXFK3zRrf6X6NSsKu4HIK/mc2f4qn/Q9fmqySdg0Uvuki1JtSPTKXAXHaIVMNx2NF/3TNARZqVXeiOhkWLntYrAjrAztuf7hP0VQRSBjQNoq/835S8oeKE2E2Zfkr9ojcoomLDxP1Kl81l+/Ab74Lh9igH/LA+2w==
Received: from AS4PR10CA0030.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::11)
 by DU0PR07MB9268.eurprd07.prod.outlook.com (2603:10a6:10:44c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 08:24:45 +0000
Received: from AM3PEPF0000A79C.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::85) by AS4PR10CA0030.outlook.office365.com
 (2603:10a6:20b:5d8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Tue,
 16 Sep 2025 08:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM3PEPF0000A79C.mail.protection.outlook.com (10.167.16.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Tue, 16 Sep 2025 08:24:45 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id B29E920319;
	Tue, 16 Sep 2025 11:24:43 +0300 (EEST)
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
Subject: [PATCH v19 net-next 03/10] tcp: accecn: add AccECN rx byte counters
Date: Tue, 16 Sep 2025 10:24:27 +0200
Message-Id: <20250916082434.100722-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916082434.100722-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250916082434.100722-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79C:EE_|DU0PR07MB9268:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e17f28-cdd9-4d8b-b826-08ddf4fa7e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aldxVVpqVjZsSXpCY0hXTzB4Si9iUU44ZzhTQWc1eGlMdUdYNEI2KzgwYWlH?=
 =?utf-8?B?Mzl6aFJuL0lQQlBYNXhpR2drWXYzNWxRSEtSUXUrMlIrN09DeDVFVDRxQzZJ?=
 =?utf-8?B?QktJbzRKZHlTKzJjem9YbnZLU1NCdUpUTVV3Ykk2dm9MNE1JMDZjTEtLMmcr?=
 =?utf-8?B?S3BFb0s1aldyc2FVbjZNY1IySmszbE4zVEN4RHNTM3pWaUg0YTZrYTNNdXUy?=
 =?utf-8?B?KzhsM2hZdG5LM3dSRXVTL1puVjIrK0pTU1Z6alM0WFlsN3I1Y2IrTGwxRG1V?=
 =?utf-8?B?WXg4VkhrZlhqajFmeDJteXA3WGVyVlJFS3diTnlLRG5WY2Yrb2pjOUFPQWZy?=
 =?utf-8?B?Vlk1Y2htQUxLVGpyajVQcERYYkMzZ0NULzRqZFBYRHdmRC9vT1AzRU9PUlNi?=
 =?utf-8?B?N2xIQ3hRV294TTk5OUcrUFhMVG0xVnBzOEJpZVA0dnlYSXZXQkxjcWRuSlJs?=
 =?utf-8?B?ZzBMenhRUUcxVmdHbmpRbFRnVzVtbGVTNnVIM2FMdmRZQXpoNmNidmQ0Mlhk?=
 =?utf-8?B?aU9EQXZMWUJwTlFkUlV5c0UyZVRTU2xab3ZnSHlyWFMrS3VqblhvbEp3SkI1?=
 =?utf-8?B?bkF4dUxZVGVERE5WZ25VYmtGVG5ZRHFvZWt1RmtOakJubGdSZ3lzNm44b1R3?=
 =?utf-8?B?T0g3d0dsRjlJcVcxbDFlMTNEZ01RYUk0YVhJaXVaVUVZRXdqcHl6ZG4rQWVO?=
 =?utf-8?B?KzVPRTZiWUMxekpJa3RCWEIyVzV6MFVyYjgxZS9CcWI4cWtJU3hBdDVrSFdM?=
 =?utf-8?B?N2tuMmRveEdKMTBvSWhFWVFJcHB0T2xNeDBqNEJZYkNrV3NZdUNiVmJMMk4v?=
 =?utf-8?B?ZjF3Q0tNVVBrUDg0TDZQSUR6UFB4YUc2QWh4aGxRc2pVQlVVY050ME1XRzVD?=
 =?utf-8?B?c2xJc3lhZjBiMXFSWm93amZuMllidldUQ2xsQUgvWHo4SjBrRUlWUkc1L0JL?=
 =?utf-8?B?OHBXSEV4bXJYWTRNVXZSTDFiYTl0cHJHbTdjeU51L1JodDVWTXlXb1ZwcFNh?=
 =?utf-8?B?STZKdmdEb3d3Z0R2aEYxbkw2WFEwbDU5Nno3UHY2bEFkSzRObDdTVkwycjVJ?=
 =?utf-8?B?bW5CaDBkUndlejRYQm1zbG5VRmhlN0tvSU03RmRYM01GeWUzWVM5Q2krckt4?=
 =?utf-8?B?bVAxNVhsd3Q3aEFZOVMwdHFkSDZjaXJJcWRiU0VJWG84TTlMM3B2YTBsK1ll?=
 =?utf-8?B?KzRDK2FSSkhBdy9nWmVJTHNERCtQNzMwUDdReWZGcXpMTFNESmV0ZHlyZyta?=
 =?utf-8?B?WnI4ZGxaREx6RkF0TGZwZ21OMHFBOVdkb2JQaDU4dnphZUFJeUVibUxEbmpQ?=
 =?utf-8?B?WDNEVGxmSlJMaXRNQ0pOSkh6b2ZhcXZ3RTRDdW1sbmJLeGEybU0wWDlaTlBQ?=
 =?utf-8?B?UXVHZHdpbVFzaXo1RTNOR3drUGlibEhJOXR4Nk1oQ1RsbXdGWVQxbXNzbHBI?=
 =?utf-8?B?Y1krS1lLR2lYR2lucDVTVE91QXd4NnFqc0JMa2hza1RoS2NLRU1Ybk1aRTY3?=
 =?utf-8?B?bTd6QzFTT0xjRkhCRGYxVzdpeVNGS1hQUjFOVmxxTmxZTXhhT3kxMWVVTkRx?=
 =?utf-8?B?S1JQZytkMVdMR0FQQXpKemJuc2pLaHVPRy9mbVY0TWN0b253K25YbHhjSHhz?=
 =?utf-8?B?RTNBTkIvaksyRnQ0YkFYbjYyeUtoS0dMT3MwRG9TRVVHTWlmejlHRlpZdmdX?=
 =?utf-8?B?R0h6c3lJamhpYWxmTlFYUlU5TzlCditVRHJOOUpyOStKc0ZuRmZkNnp3REh6?=
 =?utf-8?B?TWd4UHdqVGhGc0hWaUdDZlNYeitKM0U2ZStLQ0xqMkhFdVNoa05QUDBhNTAw?=
 =?utf-8?B?RnR3aWdObFA0QTVEbEZrVU9GUE82ODBtVmg4bXNsYlppcDZQRzVwNVJPUkdJ?=
 =?utf-8?B?UFY3WmJiRnZLcXZGeGtYV2VlME5tNjkwOTZTUG94UFZRcDlyZ1ZRTFRVeUZV?=
 =?utf-8?B?MXlzcHF4emkvL2FZUFo1L2l1L25HVjFja25wWVNpbmE1U0JOK1N6amZCbEtG?=
 =?utf-8?B?SEpEbUJIK2lGaFFBZ1VQY0FoSUhHOE85cXAzeXdLL0FTb0k3aHlSRzZyZ084?=
 =?utf-8?B?SUJMMlRmS1V3N0FtczU3d2cxTVpwSnZqK2p2dz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 08:24:45.0902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e17f28-cdd9-4d8b-b826-08ddf4fa7e20
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9268

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
    u32                        delivered_ce;         /*  2576     4 */
    u32                        received_ce;          /*  2580     4 */
    u32                        app_limited;          /*  2584     4 */
    u32                        rcv_wnd;              /*  2588     4 */
    struct tcp_options_received rx_opt;              /*  2592    24 */
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2616     0 */

    [...]
    /* size: 3200, cachelines: 50, members: 166 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ce;         /*  2576     4 */
    u32                        received_ce;          /*  2580     4 */
    u32                        received_ecn_bytes[3];/*  2584    12 */
    u32                        app_limited;          /*  2596     4 */
    u32                        rcv_wnd;              /*  2600     4 */
    struct tcp_options_received rx_opt;              /*  2604    24 */
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2628     0 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    /* size: 3200, cachelines: 50, members: 167 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

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
index da0b355418bd..1a41a459aa07 100644
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
index 7261ee6dd875..a45a4184b603 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5142,6 +5142,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5149,7 +5150,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 95 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 107 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8449a5a3e368..636a63383412 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6163,7 +6163,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 					flag |= __tcp_replace_ts_recent(tp,
 									delta);
 
-				tcp_ecn_received_counters(sk, skb);
+				tcp_ecn_received_counters(sk, skb, 0);
 
 				/* We know that such packets are checksummed
 				 * on entry.
@@ -6213,7 +6213,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
-			tcp_ecn_received_counters(sk, skb);
+			tcp_ecn_received_counters(sk, skb,
+						  len - tcp_header_len);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6254,7 +6255,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 		return;
 
 step5:
-	tcp_ecn_received_counters(sk, skb);
+	tcp_ecn_received_counters_payload(sk, skb);
 
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
 	if ((int)reason < 0) {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index a4b8be6fdcdc..1dbcc09ff7a9 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -463,7 +463,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
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


