Return-Path: <linux-kselftest+bounces-36524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5403EAF8D2E
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 11:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2178F1888D8F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 09:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4952F2719;
	Fri,  4 Jul 2025 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="n6Ltcyb2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D162EF65E;
	Fri,  4 Jul 2025 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619330; cv=fail; b=f5YAyf1njQpP9lAfMw0eHWpzmWmh+FSwKfCy9bhulfYkVb1yDS5i2WN2vZXh52ivzajzPsftU/wq/KT0nAwtMJ4ixG5/S0uc2p7qEfy/LRPpXnHSShb4VkQodmjMaPNGgABexL4toDkrnqrZsRU3AdG1TRlYMowwEQPwLkmuyEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619330; c=relaxed/simple;
	bh=lYjoMYVkQ6TMPSqLx32o//yWG3/dKAVety4N2DAKvO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mf3wPF6OVOmKdSyzHd5a6OHwxLFksexdpwVDpxHTSWmbVAHh5L9sl0cDNDSdXEiPv1EYw1/lQw5+99Ujdeg2YAU8TbkXwZD67crfuk0guP8oAaOEZcbB5xvaBwjM1TSl6NUoT9utUY2MOjjXH/nkeLy3v7xluHFw2IewSsp8DQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=n6Ltcyb2; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjGva/mpCqet2KC9TrZZpn2FbmZPaI4pJwk2+6d2k9U4HohbVUX4QJ1mXe+5la3hjL74QasIrHB0kPe1MaWXz3oSI6YIyx3wLcxnH6HESAwrxIq5jQlA/ojm+qwNST+YR9E/bZTol7Waoj6Nb62vtHbOTKxZ3UGg7isYNR1Fh99uolbW5eYST64ApUeISw7EhgGpIGbXUYModRtXo5vxW6CL1HkajPUDure9r+Ql8Wypf1/gX9M1QewSuAkc5R19GcjwgO2fUi7vT/puNUWvIk5lvfJHE3amqXxRTsSPb5AbrLNVPcKPJaN/eLWV/uU+FawG8gaqDr0jZs1RMqrY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88yrjy4ZePNBWv7XPsZv/vaWSkI+rH9CwZt3Gel23e8=;
 b=JN6kjm+Q7E/UdPD/s4LMCV8L6PXsGf+h2arMenqptVv+YRyI2iLyny84vL0zucs11htthUOo3W0A1jmn/o8BDWOw5f2znWrYU0iFqQmqBBAAONMiNjVT39i231uUs0w/G+bODOMthlj4MuaEJaep9ILw+tLpe2NcshSA+ne/m51sAG1zU3Ezp2EDQoQAaSZ5xYuPQSNMm5RGMWPBsEJAdiffTPZ6VmrKHThNs8qGj4lPgRXctvAiNUwq+2cUSsDeWTOtfuRczAnjion72j/6F/7l5HOeSYXNA7OejPKq3ukGhI0Y69Am50DgP5J0AWkfkfVUEcuKOcWMnx7Ujx/oxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88yrjy4ZePNBWv7XPsZv/vaWSkI+rH9CwZt3Gel23e8=;
 b=n6Ltcyb2sC7Ox5Dr8+uYhJDic4xRbJ8FngWc3iu1i9SQOL0AH7zAT+ZyoiXP+PEWcRGnD0yvpW53PQxpd+oELzNgF4cpTM0EsiSjqdLE/NsQYeUfCsgZJQit8+Oa2Qz7z82V1nkm02+XY0+XTW3Qi4XzhAT8+/pRLn4wh3pNUvQSL5ZCGOzCAHKWpmAjMmzaMDZ/E1pSxc6V9KvskK0u0dCEAMxI+G41NhOHmzVNNhHc86qHze/yDW0WY0z2s1W3d0kTTAfEfRuD25dCiudScadycTaemdmnYQZgkNiHmWelOHpoQbfpFW6aHZEIe4ODn2ozc4HTiBAhWYt9mfnFyw==
Received: from DUZPR01CA0101.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::22) by VI1PR0701MB6909.eurprd07.prod.outlook.com
 (2603:10a6:800:19c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 08:55:22 +0000
Received: from DB3PEPF0000885B.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::d6) by DUZPR01CA0101.outlook.office365.com
 (2603:10a6:10:4bb::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Fri,
 4 Jul 2025 08:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB3PEPF0000885B.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Fri, 4 Jul 2025 08:55:21 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 464D620164;
	Fri,  4 Jul 2025 11:55:20 +0300 (EEST)
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
Subject: [PATCH v12 net-next 08/15] tcp: accecn: add AccECN rx byte counters
Date: Fri,  4 Jul 2025 10:53:38 +0200
Message-Id: <20250704085345.46530-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885B:EE_|VI1PR0701MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8c11d0-5c3b-4e20-a8f6-08ddbad88258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzJDWjdOSXVQK2I4ZFc4TWlaT1NPYzZmU2pBbDBYUGN4d0NzSDQwQVVEcGJP?=
 =?utf-8?B?ZGtNYW9PWHc1aUxTRGk4bHZqQjJkWXg1cWZRZjY4Wi96SmU2ZkxlS0FlUjRR?=
 =?utf-8?B?cVFGYTdpaHdPYWl1cEZraC9ZbnZLL0VaUURPRHVOaExPZ0IyUFBHalJJTWt3?=
 =?utf-8?B?SndLajhpTGFSdEZTL0twaDdUN1pqb3RnMHdSUnBCSEtpeEJ6bHR4QmVpSjBy?=
 =?utf-8?B?YjlsT3BkQjlWQTdEcXBvOFlaMkIwS2FrVzFXVXo5M0krVHBwNktEemYvWmVZ?=
 =?utf-8?B?RkFpL3k3bVZRL0xxY0lxRHpVOTdHUkMvdGJmZEhJUGZrMk9nNDBoUWw1NEFE?=
 =?utf-8?B?UVNiUzU0enNLUkFYSXhvcVBFSUdHdnAwRTlmVEdzcUM4YlZHY1VUd3VNalhn?=
 =?utf-8?B?Mk1pNHVpby9oNnZOaDI0M1lrK0JRaENYWVdMekxPZEpEUVlFbFJXMlIvUHdt?=
 =?utf-8?B?T3JFQWt6QzRSeUN6Q2g1Y0lLOVZzbUphWnBnUlBmekFBTnhQQU5hOG03ZS85?=
 =?utf-8?B?ZEkyclBuK0tMZVZDMEtjQ3lzTGVMZzNTQlRHNEhmTEtqTDdUemJvSW5CZ3Fr?=
 =?utf-8?B?OVROWVlCRkhXbGV6KzJzUURadUJtaVUzSGdpMkd4REFjUnRaeVRIa1VFdjJZ?=
 =?utf-8?B?UlpvNHVhUXpOSFliY0NXWkhQdjZRSGp5TGI2d2Zlcy8zYVF3K3c3TndJNnJ5?=
 =?utf-8?B?ZWVoMitSSFdwZG5DWUZraGZWYk1lVVdKeCtsS1VkVVpIMXdpQ2lJdXNVUmtr?=
 =?utf-8?B?WGtaSjUwclFlZHMvcUlmL1RLN1AzL0pDZ0dRelNIR0REc0w1QTk5bTBqdlBD?=
 =?utf-8?B?OXcwVUdZME1TUUZwdFh3VXVTeWQ4Mi93K1ZhRHNVNnZZZXVaR3c2b2JCNDha?=
 =?utf-8?B?MEVEUHJRQmc3cUx3TnNpUGJuWkFMdE5kanZNTVFRU0tCbXI3TUZQelhoeUtY?=
 =?utf-8?B?enB4Mi9VRjM2VEp4Q3NvTVl2SW5naFJVZDB6S0g1MlhzMGpIWkVnOEpSaDNU?=
 =?utf-8?B?cmFaWjlZZWlHazhWUlYvd0ZNd3ozZ0ovWmlwZHhuV0Q1UFpNUnBjRTdHUWdj?=
 =?utf-8?B?dGd0aU96aUZRVWphWXRFbmRjYnJmU3JURy82c3RDR3NoSXZZdlUwTVA3RCtI?=
 =?utf-8?B?SGk0OFpQZ3BvcGNhMXZrQ0JySCtrY3dMcm51aHlybElRZ1JkOXdxUSt0UktQ?=
 =?utf-8?B?WEpaWVlYYjdsemg4Nkg0eEdEelZMbGtlR01OSUhYalExUklxN3hyNjFhU2Q3?=
 =?utf-8?B?VThRVVhOa0cvMjR4WitCMU1SU3JaN0ora0l2cUdsYXpGZFFyZG9GUlEyVWND?=
 =?utf-8?B?d0V5bFhhZEs4ZXowSUpjTGhnc1FWM2lvdDk5REZuQXNobVJCWnZlcllUKyta?=
 =?utf-8?B?WUN6cldjcGVuMVk3SUZxT05ZMGdHdlkvSDRTTk9UVE9nN1pKRmFtWkhmYy9T?=
 =?utf-8?B?amF4Vk4zMGU5UTJ2ZUdhbkhyV2ZOU0pZQ3dXdEs4Q2tIcWFyb2dlVmMrNFVF?=
 =?utf-8?B?SHV2RENkc1NvalhWZnhQM2hxZzZaS01hQ2xtemRMZ3krcWFuUkFDR2tzMjJP?=
 =?utf-8?B?Yk9wcCtDakNVT3BIZXJrVzJxVjVzcllwWm8xNjVRcjJ3Sk1qYzJHZ09RSHdT?=
 =?utf-8?B?Q2lvS2xtRWZtNEJ1T0hFSllqbzZzSHlSZG0xaklRM2JEMVhIc3c2eVZWWndF?=
 =?utf-8?B?NS8va3B4QzlFcUMzV1hEWVdDTFAyUU5VMmZBdEVhbXBIYktTNGFEQmg4eXpS?=
 =?utf-8?B?ekZ1ekZDNTg0R042Y3NqMzhtcVFBaEZ3UlM5NjQycU1pL3hJSWIwQU12T051?=
 =?utf-8?B?bjNGUEllakNJNG9ENCtLRCtXbmd0MWt0MjJEK1JpUTRnbHJhdmhTVlo1U3Uv?=
 =?utf-8?B?NkFMMm1hbXo3VFRldzRQL1haZTVLOUFiS1grUEY1dHJsdWZNR1JnSEVRLzhy?=
 =?utf-8?B?MkR4ZlZveENKVzdjYWcraG5ZcGVCdE1ub2FLTzNwUDN6R2NtWGoxT0lDLzlZ?=
 =?utf-8?B?ZHBSZnpKWGh6V1ZGKzY5WGtPcHlCN1FoOXdKYTliMU9aNk5Kb3FCU05KaERO?=
 =?utf-8?B?U0Y4L25vVWZUVHRPWUZ2QjJ5b1RjMm44TW83dz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 08:55:21.8226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8c11d0-5c3b-4e20-a8f6-08ddbad88258
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6909

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
 include/net/tcp.h                             |  3 ++
 include/net/tcp_ecn.h                         | 29 ++++++++++++++++++-
 net/ipv4/tcp.c                                |  3 +-
 net/ipv4/tcp_input.c                          |  7 +++--
 net/ipv4/tcp_minisocks.c                      |  2 +-
 7 files changed, 43 insertions(+), 6 deletions(-)

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
index 61b103633da4..0d8e1a676dad 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -971,6 +971,9 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
  * See draft-ietf-tcpm-accurate-ecn for the latest values.
  */
 #define TCP_ACCECN_CEP_INIT_OFFSET 5
+#define TCP_ACCECN_E1B_INIT_OFFSET 1
+#define TCP_ACCECN_E0B_INIT_OFFSET 1
+#define TCP_ACCECN_CEB_INIT_OFFSET 0
 
 /* State flags for sacked in struct tcp_skb_cb */
 enum tcp_skb_cb_sacked_flags {
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 7ac68cb70ef3..971355c63d72 100644
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
@@ -196,9 +196,24 @@ static inline void tcp_ecn_received_counters(struct sock *sk,
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
@@ -242,10 +257,22 @@ static inline bool tcp_accecn_syn_requested(const struct tcphdr *th)
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
index 0548c74458c6..237435927b9a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5121,6 +5121,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5128,7 +5129,7 @@ static void __init tcp_struct_check(void)
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
-- 
2.34.1


