Return-Path: <linux-kselftest+bounces-49020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D537D2489D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 13:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA1423085A55
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 12:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4213396D0F;
	Thu, 15 Jan 2026 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="WSla56iH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90801396B7C;
	Thu, 15 Jan 2026 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480158; cv=fail; b=S3wS2CjVF8C4uRb6ojUR/F15WAKAM2XElssW7cCHBziErTtFKMIpx0oKbNMFwaSAbpCvCm0uleFaadTq022FGYzaHvl8fXjCzXfUgz+L0yZ7SriNf0jCC9djakMLO320Bx/6jRSHzdaHP6vqkNIxgHFzPK7gOkXKJk/mrbnQ8I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480158; c=relaxed/simple;
	bh=RD+A3cZguQr6TqxpHDNg2uf/PO2Bg5clQseL6HwOFHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZ3AQwRhBHsJ8n6xC211Xg9rmO/vHj0ddXMwq8Q00cugSupEPBsSyGR7fTdo38SVReoBJWwbrSiW/Mishb/2TbFIX/ijCrl+eI0O55Lkv6lBokkCWQ2dfnmFm694VcGxOUIS23/ScK/xvTwgo6Yc8OPbU9kkI11LXA2jCaDjgJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=WSla56iH; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaS0de1LVsWGpUXIECbyeOLbfhUEIipNNA7QxIMkLIfWOk/pgqqDHuqHJPi70KVMMI+SpBo5zxh1iDif8aSi1lz3FKW/XOlbSmIba43uhxZ2HSmC0trmj9ROK4LZkICHdbUZ1mcEAWbFWG/3F0RQmgcwUVXEwVALxyZmrVMK/JjUcg8A6gwhWtrKCr/7Oibn3Wjx0U15sTY17yxjz+OkcjsV88ThZnZ4Qs6Xo1qYl4+ulzNR2KcX9pLrZoVghjXWoioCUxm5rwD+dqoLmIthWJmUMN3AXdcE+bWCqcDjNKtlX9+5/i9e1x4nbizemQEf5XhEx3nk0u7shQh8galyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=in3XawnwSMdZu7sGbNc71YEG6YMsIoGzJ8bwCEZoyac=;
 b=OwZ5dQqcvdsuUPnisho+k5c/RlMbtII4aHMgQvbd83cHWvabXMVZj9iL+PdrXwpBLbyKCu0MeqsUtZsA8WgfU5e5xbkX+A1q/nTEsbr24ro6I5t9HtzvXiBStxhZMy77sER2UNdqIaA1vMZhrCM/0x0H9JopLotfDc0M5y1BiZ0pGGvOqSUgvIqHCk6b0ht55QXAbLQiukWo53FiHGTDWHEq4GDDu+1ayacds/fBoSVFurTtVHPLyed7WVu+6WFG6kGbA0xFV0absyJFk7qQj7vrLmcPS361p2qeSFt4k81Z1jGUqPY5ay1PZWF6PvNp/cD6eqFeUGjUMRFo1aRekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=in3XawnwSMdZu7sGbNc71YEG6YMsIoGzJ8bwCEZoyac=;
 b=WSla56iH3gfRm1jM4ZiF4+jyuI8P9tUXvqxJBgLz5R+rpEzFrsaIVYBURRNIXuwV/qMTBIOg5vdEdTPo/eOxqeAJxQW5ccqPZYOu6kuMgEfiU+DiUojV5+XvtgXqBjxX8EJTxmYRTtnOz2RzCj6xDSRjn89ezjZMwSA6a0O6VcA+LHGat1eVSCJ7pE+BHip1X8SRZX1QIDwulWzT/AFmOf3phfW3xXLvvxy59AZaVidg0ZBYhNKPVxjp5ZBKKah/ChPyz9A4Lx/UsmfLm+jONHSQptgtxNeLr5Xr2YIZ1I18p/ftn3FgDEMfmh3k6C5n6h8ODAjZrwFnkZw7iX0HuQ==
Received: from AS4P195CA0007.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::7)
 by PAWPR07MB11265.eurprd07.prod.outlook.com (2603:10a6:102:50f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 12:29:08 +0000
Received: from AM4PEPF00027A67.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::8a) by AS4P195CA0007.outlook.office365.com
 (2603:10a6:20b:5e2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Thu,
 15 Jan 2026 12:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM4PEPF00027A67.mail.protection.outlook.com (10.167.16.84) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 15 Jan 2026 12:29:08 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 1661F20341;
	Thu, 15 Jan 2026 14:29:07 +0200 (EET)
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
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Olivier Tilmans <olivier.tilmans@nokia.com>
Subject: [PATCH v8 net-next 04/14] tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
Date: Thu, 15 Jan 2026 13:28:36 +0100
Message-Id: <20260115122846.114576-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115122846.114576-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260115122846.114576-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A67:EE_|PAWPR07MB11265:EE_
X-MS-Office365-Filtering-Correlation-Id: 05de9598-a1be-4492-09aa-08de5431ae3f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aWY0VjBQMkJiZG44WjdacWgxeCszR0VLYlRZRlJoTHRqMzB2WENJODQ5YmNM?=
 =?utf-8?B?bDdydDAyRmh3My9Oc3gyNlR1ejJDcHJOTk9vUnJoWjlnWmFsTlB1dVA3OFBa?=
 =?utf-8?B?N3E5VW5QNmRTWkJYWTJHYWtNUkN5NFMyUFRjYklPc2g5MGlVTE85VSsyR1Bm?=
 =?utf-8?B?Y3RQN2Y2YnNmZkpIMEptbnV5Z0puZkY1cVNqalZjS25ONTQrVTVoZFV0VU9y?=
 =?utf-8?B?ODRhejNFR0tKL1NnaHdYUnM2SExkOFhLcThGRWVtNTZQdzkvY2wxQWZNeFZX?=
 =?utf-8?B?cVQ2bzdHMXFRK2o4a2U4czl5S2twKzROeGdrbGkxdTRYeVhlSjBOT2tXenJL?=
 =?utf-8?B?bDRaVU04VkprUTc1UkhWTkEraXQzYlJpQWhTWHJySDRVOTcwNkVaNklUYm9y?=
 =?utf-8?B?b0cyNTJPcHRYdTlVZEY3WDJhNTB4NWt0NHlQSFFjdXdEaGg5WnFHdHMrdmwy?=
 =?utf-8?B?bHQyL3hQdW14QnFRaTRTZmszRkNzU29qV1pWdlBCYUZYTzBMMnhad1d3L2c2?=
 =?utf-8?B?ajNwcnh1SVMvaWxQRmtsdEJWaWVJZS9lV2lzQ1BYSTNkWlNkek1tNE1CdzJh?=
 =?utf-8?B?QlZzS3A2KzlYUnB4YXJsZ0dWNkUzU3dxR1hNZEt5M0RXOWxveE1rTzJUT1JU?=
 =?utf-8?B?MFRwcG9ydzNmUVVvQVVhMWNzbGxIaVRpbEp6Vko5aVpybEQ1VDRLWjd0TU9X?=
 =?utf-8?B?aXpnVWdNcmxXdTJBL2IzU0hvaGc0UUZweE5IaVhteFVTTG4yQW5CK3NEa0Nu?=
 =?utf-8?B?MUxMOU9NMHVURldRNlhsS2JwWTNhL3BsMFU3YTZOZUNBMXViNS94Vm1tVm9k?=
 =?utf-8?B?WFBsSjNnZGlUZDBsY0NpODRNdzFSdStLcVNPc1RzUzdEZ01kQjAwendPMkg3?=
 =?utf-8?B?ZGtZVTFJdTZ5L2U1SWwzNGtGcm9FeWRmZWtibUZrS0VhMXdZblJnYU5tVStK?=
 =?utf-8?B?c0VLbmRmc0RISmxrNFJiemZielRMaTBtRUtLeGN0TVFsMWF1TXZ5d0lYM0FT?=
 =?utf-8?B?VkFvaDFCUlNIelFjd05yVHJkZkhIcElSUHhJblZ2L0tqcnJRRlorWHIwZ283?=
 =?utf-8?B?YVZLTTl5cEVkWkpOQnFZRGJ0TCttbklCY2tpVjExY1U4VWk4MVlOam02cHVj?=
 =?utf-8?B?MFNhYjB6bER0amMzN3YrZnBCWlpUQ2liT0ZBSFNRR1l5NHh1Y3dtUThVOFZj?=
 =?utf-8?B?OFliVGwrQnhBSWhnSFVqZW9rVXZUMk9DNjJmb0ZWNkl6Mld5TXR4L0lrL2c2?=
 =?utf-8?B?cVFadjhaeDdtWU81RnZlTlIxakVadksxYUVQN1VWNjhEMHpObmNkNW5kbXVl?=
 =?utf-8?B?TnJvQjNnMHRRWEtRVnY5RGlWbVFDUFA4U0x5d1M4SUFqMDdvWFRTcThwcVVm?=
 =?utf-8?B?NWw3QnlIdEFmK292V1dnSmo2S3hlWGg3U0FPRy95NVJLeGhJVkYwSmp5N2xa?=
 =?utf-8?B?OWxlc3d5YklseDE3N3lLZ2p6UzJFYmNmWUpwNE9XUmFTS2Q4WVRZZE1CcXZE?=
 =?utf-8?B?QldRQlU3VWdFb2hFOUdmNzY0YVFaVHB0NG9CZHVLT3hObkEybkFLOUpVRVZJ?=
 =?utf-8?B?ZlVSK0hPN0YzWldCWTVoaWxMeTFGSFZib3VIa1A2bW91dXg1YWdJWkJFbTBH?=
 =?utf-8?B?OE90aDNuanZkMlZ5Y0lzN1Z2dDJsNWVHTnBUSHJ0dWNpN2NWakFlTk9hUG0x?=
 =?utf-8?B?enAveGs1Y2J3Q0JuL2JYeGFsdjVhUDRVTlFJa0N4eEEwWjRlcDZhMFNwYmhW?=
 =?utf-8?B?RUZBbjNFYjBkOUloRHdQWTFlSDUzMkJ6aUFQaUFuSHBaRi9pNGQvK0Z2ZUgv?=
 =?utf-8?B?NnJnSGpYYUJQVGxBVytCQ1VDcnZ1blMwK2lrYnRTUGZ0cVNuMU90ZysybU9C?=
 =?utf-8?B?Y0R0Rm82MytKRktVQzAzajI5MEpIMnVmM2NOaGhPNHVkT3FjMExOSGdVMHd5?=
 =?utf-8?B?OGdTYkpvSklxRythTHMvKzczd2R1VWpHT0VLUzRGZEVxc2dmK2VrT2pQSDBv?=
 =?utf-8?B?NTZQbzkybFduMVRSWUZER3N5bUlSTjhYYzZUUFV6UzRvMkFockVpRFROclh5?=
 =?utf-8?B?K2JhOGhXUHoxT1dYQ0J1QzU2cTdvNXVSdnRzeHFXZ3d0ZGtyMzluZ0NhTkpV?=
 =?utf-8?B?TU1qdDlnWlQ3ay9RTk5laUxUcGRHNmkrZ004eS9ZL1dyQm5KbHFpd2xtZHFH?=
 =?utf-8?B?Q2UxUVJPWFBMaS9JYTlZcGJ5dC9yZHNMNDdYVkl2b2ZlbUVQQU5Mck9xL2xR?=
 =?utf-8?Q?+1oCKHivOKFzwoyuUxadjwL/FqYTr0ZO/A/LeDVzoM=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:29:08.5914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05de9598-a1be-4492-09aa-08de5431ae3f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB11265

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Two CA module flags are added in this patch related to AccECN negotiation.
First, a new CA module flag (TCP_CONG_NEEDS_ACCECN) defines that the CA
expects to negotiate AccECN functionality using the ECE, CWR and AE flags
in the TCP header.

Second, during ECN negotiation, ECT(0) in the IP header is used. This patch
enables CA to control whether ECT(0) or ECT(1) should be used on a per-segment
basis. A new flag (TCP_CONG_ECT_1_NEGOTIATION) defines the expected ECT value
in the IP header by the CA when not-yet initialized for the connection.

The detailed AccECN negotiaotn during the 3WHS can be found in the AccECN spec:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v6:
- Rename TCP_CONG_WANTS_ECT_1 to TCP_CONG_ECT_1_NEGOTIATION to distinguish
  it from TCP_CONG_ECT_1_ESTABLISH.
- Move TCP_CONG_ECT_1_ESTABLISH to latter TCP Prague patch series.

v3:
- Change TCP_CONG_WANTS_ECT_1 into individual flag.
- Add helper function INET_ECN_xmit_wants_ect_1().
---
 include/net/inet_ecn.h | 20 +++++++++++++++++---
 include/net/tcp.h      | 21 ++++++++++++++++++++-
 include/net/tcp_ecn.h  | 13 ++++++++++---
 net/ipv4/tcp_cong.c    |  5 +++--
 net/ipv4/tcp_input.c   |  3 ++-
 5 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/include/net/inet_ecn.h b/include/net/inet_ecn.h
index ea32393464a2..827b87a95dab 100644
--- a/include/net/inet_ecn.h
+++ b/include/net/inet_ecn.h
@@ -51,11 +51,25 @@ static inline __u8 INET_ECN_encapsulate(__u8 outer, __u8 inner)
 	return outer;
 }
 
+/* Apply either ECT(0) or ECT(1) */
+static inline void __INET_ECN_xmit(struct sock *sk, bool use_ect_1)
+{
+	__u8 ect = use_ect_1 ? INET_ECN_ECT_1 : INET_ECN_ECT_0;
+
+	/* Mask the complete byte in case the connection alternates between
+	 * ECT(0) and ECT(1).
+	 */
+	inet_sk(sk)->tos &= ~INET_ECN_MASK;
+	inet_sk(sk)->tos |= ect;
+	if (inet6_sk(sk)) {
+		inet6_sk(sk)->tclass &= ~INET_ECN_MASK;
+		inet6_sk(sk)->tclass |= ect;
+	}
+}
+
 static inline void INET_ECN_xmit(struct sock *sk)
 {
-	inet_sk(sk)->tos |= INET_ECN_ECT_0;
-	if (inet6_sk(sk) != NULL)
-		inet6_sk(sk)->tclass |= INET_ECN_ECT_0;
+	__INET_ECN_xmit(sk, false);
 }
 
 static inline void INET_ECN_dontxmit(struct sock *sk)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index ef0fee58fde8..91e1dfe58160 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1203,7 +1203,12 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NON_RESTRICTED		BIT(0)
 /* Requires ECN/ECT set on all packets */
 #define TCP_CONG_NEEDS_ECN		BIT(1)
-#define TCP_CONG_MASK	(TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN)
+/* Require successfully negotiated AccECN capability */
+#define TCP_CONG_NEEDS_ACCECN		BIT(2)
+/* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
+#define TCP_CONG_ECT_1_NEGOTIATION	BIT(3)
+#define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION)
 
 union tcp_cc_info;
 
@@ -1344,6 +1349,20 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
 }
 
+static inline bool tcp_ca_needs_accecn(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
+}
+
+static inline bool tcp_ca_ect_1_negotiation(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_ECT_1_NEGOTIATION;
+}
+
 static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index f13e5cd2b1ac..fdde1c342b35 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -31,6 +31,12 @@ enum tcp_accecn_option {
 	TCP_ACCECN_OPTION_FULL = 2,
 };
 
+/* Apply either ECT(0) or ECT(1) based on TCP_CONG_ECT_1_NEGOTIATION flag */
+static inline void INET_ECN_xmit_ect_1_negotiation(struct sock *sk)
+{
+	__INET_ECN_xmit(sk, tcp_ca_ect_1_negotiation(sk));
+}
+
 static inline void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
 	/* Do not set CWR if in AccECN mode! */
@@ -561,7 +567,7 @@ static inline void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ECE;
 	else if (tcp_ca_needs_ecn(sk) ||
 		 tcp_bpf_ca_needs_ecn(sk))
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_ect_1_negotiation(sk);
 
 	if (tp->ecn_flags & TCP_ECN_MODE_ACCECN) {
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ACE;
@@ -579,7 +585,8 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 	bool use_ecn, use_accecn;
 	u8 tcp_ecn = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn);
 
-	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN;
+	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN ||
+		     tcp_ca_needs_accecn(sk);
 	use_ecn = tcp_ecn == TCP_ECN_IN_ECN_OUT_ECN ||
 		  tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ECN ||
 		  tcp_ca_needs_ecn(sk) || bpf_needs_ecn || use_accecn;
@@ -595,7 +602,7 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 
 	if (use_ecn) {
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
-			INET_ECN_xmit(sk);
+			INET_ECN_xmit_ect_1_negotiation(sk);
 
 		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
 		if (use_accecn) {
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index df758adbb445..e9f6c77e0631 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -16,6 +16,7 @@
 #include <linux/gfp.h>
 #include <linux/jhash.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <trace/events/tcp.h>
 
 static DEFINE_SPINLOCK(tcp_cong_list_lock);
@@ -227,7 +228,7 @@ void tcp_assign_congestion_control(struct sock *sk)
 
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_ect_1_negotiation(sk);
 	else
 		INET_ECN_dontxmit(sk);
 }
@@ -257,7 +258,7 @@ static void tcp_reinit_congestion_control(struct sock *sk,
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_ect_1_negotiation(sk);
 	else
 		INET_ECN_dontxmit(sk);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8e95a4e302f4..ccbab5569680 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7266,7 +7266,8 @@ static void tcp_ecn_create_request(struct request_sock *req,
 	u32 ecn_ok_dst;
 
 	if (tcp_accecn_syn_requested(th) &&
-	    READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3) {
+	    (READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3 ||
+	     tcp_ca_needs_accecn(listen_sk))) {
 		inet_rsk(req)->ecn_ok = 1;
 		tcp_rsk(req)->accecn_ok = 1;
 		tcp_rsk(req)->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
-- 
2.34.1


