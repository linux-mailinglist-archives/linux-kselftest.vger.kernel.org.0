Return-Path: <linux-kselftest+bounces-49396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 348CBD3B66E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 19:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 861123074E4E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C0638FF18;
	Mon, 19 Jan 2026 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IygDp9ny"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010020.outbound.protection.outlook.com [52.101.69.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8966438F930;
	Mon, 19 Jan 2026 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849147; cv=fail; b=lpHBOE53BgKWurkfEsff1mXWGE15sYYKAcmem73PoN9IB1wLH4Q7iOnFkkd2Y3Lj0DFBt5O0/9z3BZxGoP8ZLaPAa5H8tKreyip4/KB8IFs2pDRlk+J8q65lyQQN+GrgX/JYuqV3ivCSW0PlQ4yMTUoGo3jSuB+b2U8W2DPZaAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849147; c=relaxed/simple;
	bh=sfaivtWgi8JvvhfVjCCFe/2X2sqfNciS3sai2mg6OS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uurTbwmFjfzP+87PZKABZnixGCJCPvbH++hJ2MtVhB3mufICyrw4nA0T+deyZBDKeqmoRQeuYVqB/NkfpmxHzoILdpm02UcZr/96VoUPzyoZtHt40MFZtd4YwYmGucUgWQ1YvCRb4p67OiyWvL060pfeRwtU1ZE0+OY5Mtiqq3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IygDp9ny; arc=fail smtp.client-ip=52.101.69.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAdvSeLxkzYk/17DNLCGAM0YJXL64qFwvJN4pUjys7KnxfaqeaKW3ZSMV6iODJ1/A6Dg4vAH1flABQ6UJhq2u4FCVZqHEqiweZdmAXsKfYLliCTnYPr/xLwrbHlBpHvUT2UuQnyB/NZDJpbCtf+qEdUNyS9dUgIVbMPVE4U2uYrsM+BlQwiacoIO5LjN7kj7vOMOOTum+z43jqzsqnOMIKGz07IrlhmAx1z8wbgPmi+9R0LGOTDevzXvkFL+Qgn5u5tjKChp9fseV+uFUwM0rz/HhgJtelSxXB71EYVtSCH01al0tgyKYHSsSeJ0DQCTAN4pl/yYTW+FsB1EqQmSwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0Vkd6ZAGJZiROzsViYZ3djaHdNTx7wxwvFgDOJe5+0=;
 b=cdNfNWhI0+BCdF2791hOvY2Mcl1ylsN8NNiKzkn5ueriRM4/+fdcbIYsGY8T1PlwLI8Odhxt3H2GD38ldjE/JWB42FqWLAgHUYhlLv6n779Kdqn4hbGPPj5zypzViS/+ppnmiwmq93ggQ0ZbgB8h4wn9+/sOJTpuQ34hT5UPDZ3dhUwW7eM0gHuWZ9Eq4eleByu/+QiqEuPj+dUhBMf+t+Wgi1Gd4eyInBuD3d4Ko08gbBrDlNbiO/EalARRnb4q+WZ8h+8luNshRR3kxVwnq4hqD52EHpxP5wq0BSgSZVfkHb1vd/aFvs9hGgwCpVQhuq+9EksjKMomqXRraCLmWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0Vkd6ZAGJZiROzsViYZ3djaHdNTx7wxwvFgDOJe5+0=;
 b=IygDp9nyInD+UQrspB+08bjURerkoVNypGf8flSQ20TncxCh/3U3FMNqGEvas/MFyNJOCxWn55Xj1GdtGN+Lqc51xE1QOOW52kae7CNq8DgbYE4Ux8DeERaUpQpL5c6TK+JTXk5SvzBml4xqNMuq/bUCpERQYmAMwvAP/F6Don8nqB4i93xqcwZf6akczWJWeh12Xutf/JHOKo6Unk84G2+YC2gAxjFJaqa2ZRX+tZOyqAQFYw8y7tqGhhOjhTdef3OZeSyw2SBDAjSFAxBE2rNlJjJ5fuPrRMNkMZhFg3filpNRn5aMbGkov7EwOa7eMPSXPyxggN3Acac+0EO3mQ==
Received: from AS4P192CA0022.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::20)
 by DB9PR07MB11232.eurprd07.prod.outlook.com (2603:10a6:10:60b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:58:57 +0000
Received: from AM4PEPF00025F98.EURPRD83.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::b5) by AS4P192CA0022.outlook.office365.com
 (2603:10a6:20b:5e1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 18:58:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM4PEPF00025F98.mail.protection.outlook.com (10.167.16.7) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.0 via
 Frontend Transport; Mon, 19 Jan 2026 18:58:57 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 16FAA20342;
	Mon, 19 Jan 2026 20:58:56 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
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
Subject: [PATCH v9 net-next 01/15] tcp: try to avoid safer when ACKs are thinned
Date: Mon, 19 Jan 2026 19:58:38 +0100
Message-Id: <20260119185852.11168-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F98:EE_|DB9PR07MB11232:EE_
X-MS-Office365-Filtering-Correlation-Id: b9bb8f1d-739b-4f02-ad0c-08de578cccd7
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eE13Wkt6N0tNbGR6Y0xXZmM3S2FzRVV2dGUvdno1WVpwbnNTY1ArVCtiVTZX?=
 =?utf-8?B?RUJVdzMyTU10WnlIUld3Q1pERTJ2SzJSWDl4bFNMY3N1THRsV1F1bWlsVG9y?=
 =?utf-8?B?LytpZ2gxY0ZMNVBLVmxZNklXdFl6dEtMdmFmWG8vTXV0N2JuekVyaHUreWty?=
 =?utf-8?B?QVI3VU5ROG5UT1VQQituTVlwMlVtL1AvQXlKOFVDMnVQaG1jaGtEMXQvZ2sy?=
 =?utf-8?B?dEYzbnhXK0VtaXZDTjlSa0lWWnQzYkJsR1ZUWC9FbGZhV0VBNW1JaS9aS1Nz?=
 =?utf-8?B?TXVWdmVEUWZqd1EzalF2RkpnZ2VEVllodnZNTG52eVQzTzBpcjJUTzBhb1dm?=
 =?utf-8?B?aHc3b3VlY1JzajFUM0s1UGVuWjdoaEdSSWQ1VTVTVzFuc255YmxBWnQ2Sk94?=
 =?utf-8?B?czM3QUR2OE9adkMwditNZXhDMUNTSlp2d2F3S3FkOGQwb1B4eW5sWlBZTGxn?=
 =?utf-8?B?MURjeXJ0U0dyMi9PQ0cxRDdjZnZ3T21GODJHa2RGZDZ0RzgvZnNPaGU0T0JC?=
 =?utf-8?B?bENTTlUyQThmaWlhMlUzenpBRnFrWDZEM2NFN1BmM1hUbC9mRkZlcUxoaDRm?=
 =?utf-8?B?aUNleG9kYUNQVXFSTkVpWllNVkxQc2dsWGY2cVhoVWJsa1RRRXByOFFWR0hB?=
 =?utf-8?B?UjhBd0RvNy9wWmR0Qkh5YUY2N01PU09uaDlhT0JCaWRYajlTN3phamgzL0lY?=
 =?utf-8?B?NDdVa0pYN1JtcEl0Vk5Mbi9VVllrYnZXNTlxdi9HRlJGWmdLUjBNUEFWcko0?=
 =?utf-8?B?SnpVdE1HQkJBampHMFhZS3BUdGkvaTZydk9oVk5rWFVmWkFnVnZSQ05SVDdY?=
 =?utf-8?B?dkIzMlhOTTR4bHJZK2RWbWNIdjVPM2p0VXJPb21DbXQ2bFNTWnY2U28wbUpa?=
 =?utf-8?B?R3VBNENhWFBDWllQQ1RFdkVuYVdnNGNCMGRYU3dkZk96Ly8xZENhZ3FNSE5H?=
 =?utf-8?B?RTJLemNVblFCYzhJMUlablpTTHhyd08wZ1NMYVVUaG02NXRvWVY2NDBtRXNj?=
 =?utf-8?B?QkdOcDY0cGVYcEJFOEFVZ2JDWTZvYVhOUU85Zk9JSmRObUxtK3RSR1BiZE1y?=
 =?utf-8?B?bVZwdEJHRkJXZFF5VE5JaVdNeFd4N2lSVFZKdWJRNFFRT2VWZE5EQ3FrNkVV?=
 =?utf-8?B?UG0zN0JzYjNJNENqRG5CTGtzY3lPekgvdkNsRWZndXNhZG05dXVxakd6dnk0?=
 =?utf-8?B?TkdoRnRlbDROcER5UXlWSGtiUm5Qb3ZRQ2VKb0lvaTN3Z3Bkc2JuKzNmajdW?=
 =?utf-8?B?QURFY0NtbldQN294SHZJZ1lUSjBXRGVvU0E4allVRlZzRkdWUG9kRjRYTUpM?=
 =?utf-8?B?eGt2TzY5WWlDd2MyQmk0TU9Ga3BNOExEdW05QTBwWTNqUnpIaC8vTVlCZUh3?=
 =?utf-8?B?WnlzcldIMEg5Zlo3c1JVdVBua1NNeGR2Zzh5djVhemVRSEFaWGhXekZIakM1?=
 =?utf-8?B?dGJSTWhGekc5VVJ2dzhVcWxhblNaY09wVlFLcEoyejdjR1k5QmhTNk1OZEhp?=
 =?utf-8?B?eEpPK2pvVHJDRnlkeEZBbnUxK3U3b3M4dUQ0ejNaZmNFcEdDRVZ2S0hTN0xB?=
 =?utf-8?B?Y3NCOW5HdnVqQ3hlN3lYbmppRnJmWEFXenlSSnFVZTNUcG9zWGZGNGJJMzRK?=
 =?utf-8?B?Y09NWER1YzREWkVmTndHQ0VtL0dXRUVEcDBmbTcvWUpvTVliZzdCKzJDL0lk?=
 =?utf-8?B?dkEyNDIvNUFKc1lIR3BPSm5NTzFkZ2ZGNlgySUdzVldDU0R6WHZrNGwza1Nx?=
 =?utf-8?B?V2RIQ3EvWjlwOXBubG8vd1dYQkc2TXhGaCtnMWhiaVdZRExBZG96MCtVd3V2?=
 =?utf-8?B?Qzlmamg3MTRhMlV4NEFkR0lGMytZSzgyRVRHdkk1bVpQcGx2ZXBhSXRaY3RN?=
 =?utf-8?B?QzV6WHIwLzZPYWFZcnd4QjE4R0tHd0xmeWJZMEhXNm11QzJkd0RDSjdCeGdp?=
 =?utf-8?B?RXlmdlpDNGhaa0lyWVFFcUdHOEJPcUxMM0Z3LzcwSjZyV3hhQ2NyYWZyZ0xD?=
 =?utf-8?B?Q3lFMVNlWDhnK2xHTUQ5L3A1R0gzaWN1SG5rWENOTUlDSVdNMkZNZjNXVVhD?=
 =?utf-8?B?WWRDQng4UWFKa1lvakVaMEpFZ2JOS1dsT3NMYkhpYjJGQjYvT1gzSExKQ0xE?=
 =?utf-8?B?WlhaalJ5VUsyNE93cmF1aUhEUXF0WitLY2VwbmNZR1VlMktBdkwzeEF4c1dw?=
 =?utf-8?B?WmM1SzJUNFpIVlB2Sk5JUnR1YTA4NGEwUWc3NUhHYVc0cWFGUWRicXQvUzdI?=
 =?utf-8?Q?eEoAQ6skKPAlEQwSU7va/F7p5+VlToV21FYvRI+URE=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:58:57.6182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bb8f1d-739b-4f02-ad0c-08de578cccd7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00025F98.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB11232

From: Ilpo Järvinen <ij@kernel.org>

Add newly acked pkts EWMA. When ACK thinning occurs, select
between safer and unsafe cep delta in AccECN processing based
on it. If the packets ACKed per ACK tends to be large, don't
conservatively assume ACE field overflow.

This patch uses the existing 2-byte holes in the rx group for new
u16 variables withtout creating more holes. Below are the pahole
outcomes before and after this patch:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ecn_bytes[3]; /*  2744    12 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 177 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ecn_bytes[3]; /*  2744    12 */
    u16                        pkts_acked_ewma;        /*  2756     2 */
    /* XXX 2 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 178 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v3:
- Add additional min() check if pkts_acked_ewma is not initialized.
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 net/ipv4/tcp.c                                |  2 ++
 net/ipv4/tcp_input.c                          | 20 ++++++++++++++++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 26f32dbcf6ec..563daea10d6c 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -105,6 +105,7 @@ u32                           received_ce             read_mostly         read_w
 u32[3]                        received_ecn_bytes      read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
 u32[3]                        delivered_ecn_bytes                         read_write
+u16                           pkts_acked_ewma                             read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
 u8:2                          accecn_minlen           write_mostly        read_write
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 20b8c6e21fef..683f38362977 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -345,6 +345,7 @@ struct tcp_sock {
 	u32	rate_interval_us;  /* saved rate sample: time elapsed */
 	u32	rcv_rtt_last_tsecr;
 	u32	delivered_ecn_bytes[3];
+	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
 	u64	first_tx_mstamp;  /* start of window send phase */
 	u64	delivered_mstamp; /* time we reached "delivered" */
 	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d5319ebe2452..37a6e0aa9176 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3418,6 +3418,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5191,6 +5192,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 198f8a0d37be..8e95a4e302f4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -488,6 +488,10 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+#define PKTS_ACKED_WEIGHT	6
+#define PKTS_ACKED_PREC		6
+#define ACK_COMP_THRESH		4
+
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
@@ -499,6 +503,7 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	u32 delta, safe_delta, d_ceb;
 	bool opt_deltas_valid;
 	u32 corrected_ace;
+	u32 ewma;
 
 	/* Reordered ACK or uncertain due to lack of data to send and ts */
 	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
@@ -507,6 +512,18 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	opt_deltas_valid = tcp_accecn_process_option(tp, skb,
 						     delivered_bytes, flag);
 
+	if (delivered_pkts) {
+		if (!tp->pkts_acked_ewma) {
+			ewma = delivered_pkts << PKTS_ACKED_PREC;
+		} else {
+			ewma = tp->pkts_acked_ewma;
+			ewma = (((ewma << PKTS_ACKED_WEIGHT) - ewma) +
+				(delivered_pkts << PKTS_ACKED_PREC)) >>
+				PKTS_ACKED_WEIGHT;
+		}
+		tp->pkts_acked_ewma = min_t(u32, ewma, 0xFFFFU);
+	}
+
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
 		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
@@ -555,7 +572,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 		if (d_ceb <
 		    safe_delta * tp->mss_cache >> TCP_ACCECN_SAFETY_SHIFT)
 			return delta;
-	}
+	} else if (tp->pkts_acked_ewma > (ACK_COMP_THRESH << PKTS_ACKED_PREC))
+		return delta;
 
 	return safe_delta;
 }
-- 
2.34.1


