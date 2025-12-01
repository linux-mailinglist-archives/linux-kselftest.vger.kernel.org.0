Return-Path: <linux-kselftest+bounces-46827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BF9C9853E
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 17:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E2384E3466
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 16:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D53335062;
	Mon,  1 Dec 2025 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="BaQHACEw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011009.outbound.protection.outlook.com [52.101.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1C13346A7;
	Mon,  1 Dec 2025 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607185; cv=fail; b=B/sCX7G+KtRXtcRlojQVxik1yiI9faTHp/3S4jLs0N/3/hqgGUrnnl+Ii5BxeeqMSHrsuqu9IOCqUqIiEf+yLacwfY12gQLjd7LCdG6Sa5lWy+0KS2qRCx1jarPX/6hldodiV4t8rPOGM6u9LX5ngFzjX0F1ly5seDElzKE+8G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607185; c=relaxed/simple;
	bh=RvdwvQHJmwOXRu3ieXVeT6Xuileq7yr33ztD8CGu+Lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YqO8hNOXJ5XjNsb0At1ppzSKh5WInDDjLKA0zGOqIW+/WepLrxet/37c1wrDQsQLlnCmJRKrfz/8AYpMhkNgwQgzCNDyHSSfF5V1FayVgI5gUKcvcPMnN6DdrG13euZoVlsH+ORQXZAuw9SjBYXGgmc9UGi9lddVx8bDNZ3g6i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=BaQHACEw; arc=fail smtp.client-ip=52.101.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crkjSRpR6XBpGvIye5yUXVQHKYGL7WHfbr57frYEezlkvfaJ2bTFWISqfL0CaWwJXa/FePLFXKzD6xRLnxhtJ8Uijdd5l3oV3zrgc/xKiKqqodZJQCGhJ0iBVHuL38mPMDhJk9R4pYo9S5FDo8fA0v7HV93BSdycnCWGJkGeuM9XWHliscPqIAcldxUmq2mTUnaMYZj84mrebqgUTUEn8a7jLrKKxtjH+28gtk6PQymW94+bOQqjflGHiGZWrw3esXvcukAsO/byCk3DTit7AkUkTtlKYanpQF8JCHVJFTfx3lMHO6PpY62w8jAo0zc64MpEu8cEhMFD0uhlYXcMjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H39qcEQ3bV3a6vUVFmPpn6mWBcKSElb8aFC41LqQnAk=;
 b=fV/r36/IjhFZQKkmafDcpV529y1Rp1kRB9e0U09llQLIekWqjPK/D+wRWpsPWZcb/lMFXsnOEOOajOzlYHJunqXegyiRNfA1wqljV1GKeevIaoqY+kWg5X4bGYVrBhdKkmSkpvaiR5zy4GqSpCDXqFz+Jj+yPK5J6RdV4WmeSHIc7jOpLYgJZhcuU4XeE+I2ZWKRtiABq8/YS1XvSPnxhIUicNuLel0xC+0daN4jgzwRWr7OdX9/KIj8qgjHXaY0fK4EzJr81dE+vYddgakC3nBUTow3I6oWdrhTHmSt0k3U8veOq00ztrmg2KkI3BmdyWSz64CSVs6AfGw5yV0LgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H39qcEQ3bV3a6vUVFmPpn6mWBcKSElb8aFC41LqQnAk=;
 b=BaQHACEwdBh1XDDm4VJ5DAuD8gzrFDzP8BmE2TyZ946R8TiEFic7Fy0X27qYZTSA62cR9Ew4gVIgsAu6zZMy5SGNuTtGEmXR57iGQVeYsoSOUOVngRczWE7mgxVuVZ1UFIZmrq0ewxn3LsNNXrwDocXI0pjZ5wlUKPDyDzb25e0jYuK3Z4/QHAmUrGfJkWl09RCTk/uPmA3YQWMPFWA/W6y9vHw70lWnBZ3XltGYJiMqA5xVP2HcHmWJ4r0StyVqld86eNtdNgf8IP97OjOSGNzCPtyYmQNveL0zYIB9DR6CzdaiR5pDVwKTIpZXcwyA6I4qcsMz47mz4hGoP3WhSw==
Received: from AM9P250CA0002.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::7)
 by AM7PR07MB6851.eurprd07.prod.outlook.com (2603:10a6:20b:1c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:38:24 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:20b:21c:cafe::80) by AM9P250CA0002.outlook.office365.com
 (2603:10a6:20b:21c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 16:38:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Mon, 1 Dec 2025 16:38:24 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 3D682680052;
	Mon,  1 Dec 2025 18:38:23 +0200 (EET)
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
Subject: [PATCH v7 net-next 04/13] tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
Date: Mon,  1 Dec 2025 17:37:51 +0100
Message-Id: <20251201163800.3965-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|AM7PR07MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4851b5-b8ca-4a15-79b2-08de30f80c43
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cW1aSUhqWlM5OU9nN2tNcVJrTzJ2TTVNMURkSGFkZ2xhQkZLM0xJQVMxYlQz?=
 =?utf-8?B?NXFTeDZqSGl0Zk1RYkVraFBhYnN6a3dWYzhnYmdaVXd6c21lNy9ubWhNWnl5?=
 =?utf-8?B?RXJtUEVHVnhkeHRYZUhGblFOazR4aTlWb2xuY1loNEhiNWhXMVlSZmVBdFhj?=
 =?utf-8?B?bTVKb0dJVEc2cUxhOEpkUldTL2pTUktXR2t1eXBXQVAwRXEveUo5c3E3c0Zz?=
 =?utf-8?B?S0pCTmFXdjc1YlhEL3kxV0dOTHVjcjV3bFlPdm9YNWZyeWhLM0JGM1FheVIy?=
 =?utf-8?B?RDgyYWtLZDIvWTJ0Q0JkTHJrVEdvNnJpRXBKbXBpVDg2NGpZL1NyaXQra1g5?=
 =?utf-8?B?S2h5QVVqaUo4NGI2VlBkdThleFlkOE14TWdsWVZBSVN3Mk1SNWplWlhpSEp6?=
 =?utf-8?B?bkVleGZ6aGIvZkUvSXhkaC9zblRYK3dRRzhXcWU2NFlnejFLRVBZNG85S2RE?=
 =?utf-8?B?NTdyQmNnQjM1NnVaZE5FSTJDek0wZHFOY01RQTBkVUdYSFFTWVRZaEF3K01G?=
 =?utf-8?B?UXRZclowZE1nT1c5dXZqSmxSMHQrRWxHOFBNZ2lvZ0JsTU5nZDlnTE1BWlJk?=
 =?utf-8?B?MmFzeThLTUtjZkVuRTJ4cXc4Z2RHR1pYVXl6VVNwS2tSemFZSmtaMU9lOUwr?=
 =?utf-8?B?Q215UVN5ellNcm9XQVdPMytPM08yVVdyc01YaHl2Rk5wejNYTTdNZ0FQSWxS?=
 =?utf-8?B?UTdqajFqcXVJR1RrL1pLRHdXdmJEZi9RMkxlazUyWWQ1L1hiSlVraDU5a0hZ?=
 =?utf-8?B?NGFpNmdLb2xxRnFtdytZZWNBZ1hGNjgwNC9DaXVLWEpBbk9aMmN5U291YmZP?=
 =?utf-8?B?TEhNQWNsODc2QXFVQldZMWliei9Pa3VrWWR5dWNSU2JHY0c3NVZqa0J1TExB?=
 =?utf-8?B?aUFSa2tWSllHWkJOSTlQcVRLTTEyejl5WDhtS2FGYkY2L2EwbVF5ZjBJWGZR?=
 =?utf-8?B?ZDhna2Vkc3laTU9rWTR2QkpPaHROYzBqdnlIRUJWcFc1c1BhS1BTaUFJMVRp?=
 =?utf-8?B?OFhCTnh2TkJlTVlRYndPcjMvQ29WTHdBYU02a2Iwc0h6MkwrbjJVR3MxT2F1?=
 =?utf-8?B?R2lDVEwvbzVXUlRCU3lwUHpGeGhlL1N1cE04MFFtUDFUempBL2tVQys4ZHgr?=
 =?utf-8?B?Z2tlT0dWVkZXeGozbW9iSzNMN2t0SVhISDBCeUl6NnRvUGZtOC9RUEc0VDZy?=
 =?utf-8?B?RkcxQlViUy9PNEpDNnV4R2NvVVNVUk9sQmpSVGdvbUx3YW5venF5Q21KQXJR?=
 =?utf-8?B?b3h2dnpUekpGd3l3RXNWUXV4S1JncllSVjgxcjlqaWpTMFhKb3h0cllscXVM?=
 =?utf-8?B?OUdHcE41UGRvUDc5b1RTM2t2d1FEWitFR1Q2dnlsczBOVExmcEJ0dFNlci90?=
 =?utf-8?B?bDlBa2g1WWRhankrRzZ0KzlITlZXL1ZJd1F0WU9sT3FSOXlpRnhnYUt0WTdU?=
 =?utf-8?B?UnpwUmJyN1VrVW1HSTlEWDNidllvWGEvblI0ODAwcVBENEZuZStyOU5RWUhE?=
 =?utf-8?B?YUV3cDZFcWtXcHRhNWh2UHBURVpYRkpyV2dpaTVrT1l6SEduZ0R3a3A3U0xm?=
 =?utf-8?B?YW5Jb2dPOXpIdjRHcDNCUGQ0WXVoMjVsWUlMWWNEWWNDQ0I1REV3Z1E3VzhT?=
 =?utf-8?B?UmFrUWdnVVpIZEJBSFQxamtUWmdRME5kN1Q5SFU2Z0YzNUk1bHpWQzJHTU5o?=
 =?utf-8?B?VHJBUk9SUEJrNWJGVzgwMmRnZStTcU9FWXV1YS81bDBLdjdnZys4U3FzcFcw?=
 =?utf-8?B?a29zTWxXU1k5T3BYUVM0MXVlb3NsOW4rbkMwNE9yTHFmVHpYUnJ3ZHpzYzdv?=
 =?utf-8?B?OTU3UDNENlBUR0w0YnJwd2RmenlzVW9pb0JCZTNBTVVNMVdMdmdWRmV3anlq?=
 =?utf-8?B?RlB0dnBPYjhWRFJDalJKTVFQZlQ4QWh5K2x1STE3Nmh4TUtESGZSdXVUUVZK?=
 =?utf-8?B?bVJFS3RscWREMTdaTWg2RFIxeU02REhOT3A1VWdzWmhmZEZvT2sxQTVnQzF4?=
 =?utf-8?B?ajZGVDRMMU1oY2FlYlBsNG52QiszcWJuVTJsRHp4YUsyczFmbWkvcVF3S25s?=
 =?utf-8?B?ZDNCbFVNWXc2Nlk4aVloNTNZaGZZYmtWTVJOUTA0RTlYZHRRUnF4RUhTRGEv?=
 =?utf-8?Q?4HCpT22aCFrxfTehyqwmoxa2T?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:38:24.8261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4851b5-b8ca-4a15-79b2-08de30f80c43
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6851

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
index 0deb5e9dd911..c4c25f2e0c0d 100644
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
 
@@ -1335,6 +1340,20 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
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


