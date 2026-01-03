Return-Path: <linux-kselftest+bounces-48115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DBECEFFEA
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 14:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5080530A08BC
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 13:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2C330C35D;
	Sat,  3 Jan 2026 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IR4vLu91"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42E4298CAB;
	Sat,  3 Jan 2026 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445859; cv=fail; b=M4MtR+Dg5ZdVHoDAs6RRmso8D3Tah8+dQ6kCjzmZuMNCCBiLyXkMMr8BpNRB+/p4OBxdvK2Gkd6gsVJI7SA7asHFgc5XM6X/6dAOjRCCB1ks1HD6nPkez/DqRtxoKLy8RBk3C6goMGY3v+PNyRyRTN6bo8DHUncJAPydhDOsxfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445859; c=relaxed/simple;
	bh=fF6KhVNp2zh4zoIZ94EPbYaFEOnQkE+3FLYPegrByJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/7yCcocaxFSb+kRzBT9GDDVomBS6HZ14V6JDIRPDk25lifMr5+e9i4uZE4CQSDE9FugZhIp0NsXo07dgAhMKTexOqqKE05T4CcIRCnwEFnNyLvN3Y0Smn2F2qYQWcWRiIcXgQVZugQBoodWTHbbeNJDNZrqKqiZTVepREuG5fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IR4vLu91; arc=fail smtp.client-ip=52.101.66.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryrHutcNEUMrqJqFQeZ8qT1WfrcAugnKpVqaYgHcMT4/0zYW+VAaAMIGU6tdRY+nzfvzcSVwLJktnSS5sAKbKcPP3r7bKC6Tl7d8EcoXHZAgMEzcAXTTTAuPAR08zsflzDT8UsPgHBK2+fmKcNnBWCx+EM1+5oruIgcA/T4REABRdq+x/JZA4LIfEUKc92oVTAHOHSKIZyTMUI8nHtgpAgNobm/p9QpHPriKu4uZZUmiomK5CYod7UNA21jJ1rYdx5JZMqBJ1LXwkjHSg+aRlGjo1Q7cNhrr9jrGZvPzJqQdmxcxa/S2ynxbOWENGSIXqFow9TaHNvCGRIW9fF2HIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2ctgY7Q0ImIQTcp9Rn4gVjiwmfFtWYvfIc4xNCz55Q=;
 b=gwjHqpQOk47OI3CoX8+cIcIoRjmN7OJm7mIHJ/0vtYGX1wx8VldWz6ePVgXsQghuHdrE1uuNSmdj90iR2NYZjroy+/CNQ+F2M+oxBF3ywkVrxSsQIDzcbB3AmMzte+kkp5nyMdW6AJX7ZgPvTKctGH2SPIVEZKziDwMjRR242OJnfKz7oXAeBFqFCP0Iwe/GZMhmx8Mqnwa7Syc3qOg2tgbUHtSMEPE/96npTRFn0Kxf9vWNDHkhnsVBJuZXT9x/T2ebA28CenaUQvUlgSXlhBJxFCkHs9zzeqE3xj9YDmYPSU0hlF61UyP3oa1mUw/LoxAzEb0kG9dOWavHgJceSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2ctgY7Q0ImIQTcp9Rn4gVjiwmfFtWYvfIc4xNCz55Q=;
 b=IR4vLu91Zsx5j10UxX5O92FZmqXkCe6ElPfeJxxRq8BC4UfdOuYNauPstTXJCNDNf13rouyst2f+BbgzKTkfciO9RyFRFHANrHrLPN0mh/ZF6PZ9yFQJf98XjDFN5sDAChgGqsxQibyFi59KmuUieCN4KRPYen32Apfm+zflhHDz0vptiQvG8c/W7O++eN313+GIqkbQZG3X+5a/BHv1wbxjbAaeAO8iUlZk8370vLKOyvIGImaGs5PhcXdKlL5XlKyTsEZ82otVg+8PtYU+zikgk6DbXcZoL7RDtOKyvcNzYoe0JCHSoZB+LReATGzifiULIPgl0ulbq466UWPy4Q==
Received: from AS4P195CA0029.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::19)
 by DU4PR07MB11551.eurprd07.prod.outlook.com (2603:10a6:10:61e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 13:10:54 +0000
Received: from AMS0EPF000001AF.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::c1) by AS4P195CA0029.outlook.office365.com
 (2603:10a6:20b:5d6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sat, 3
 Jan 2026 13:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF000001AF.mail.protection.outlook.com (10.167.16.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Sat, 3 Jan 2026 13:10:53 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 50DD91C0033;
	Sat,  3 Jan 2026 15:10:52 +0200 (EET)
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
Subject: [PATCH v7 net-next 11/13] tcp: accecn: fallback outgoing half link to non-AccECN
Date: Sat,  3 Jan 2026 14:10:26 +0100
Message-Id: <20260103131028.10708-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AF:EE_|DU4PR07MB11551:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b94a881d-ed75-4633-d1ea-08de4ac98696
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?X+Fro89moTiEzB92lNid/J8HtZukOGpqb95yGqeIu0kqA2RNm2ng4bPnllE4?=
 =?us-ascii?Q?L8ZBK83b3Sh/khHTaRkYkjNGUiMjxzW7hNVA71pHs5qeID7dyGpsM4TS/2ya?=
 =?us-ascii?Q?2UHqbiPWFtNlgC07D5lcMDCmNR4hwBiTTxuZyUt8PzRsQ5+KeWxB7geNkLQH?=
 =?us-ascii?Q?CGcwZX+IWT8eye73Og8L4f9b8O6xCihV3iXfclgZna2rJXHHaC3OXduzLcEU?=
 =?us-ascii?Q?0ddXiN3DQSoeyaFsdvr43srgZmEat2nVhAILY4rWf1UbBVRz9/ssNZAQ5wwW?=
 =?us-ascii?Q?TJX668jlMNlHRxwJCDyHCmp8D9kaJQD7HD20iut+RuN/R6WTcTVYYqWr4Yj5?=
 =?us-ascii?Q?65eU0ZhWEr0isOINiVvDnlfvh/+JrKwrwP9iPlb6i/g2+BkyXDE4mxAkPxgT?=
 =?us-ascii?Q?4gNaxjtWQ/V1Ou8g7ypXhKmpgxeKWGD6zvRYerzVjMLPpyLF4kNcNDEM0UzS?=
 =?us-ascii?Q?Imz/rM1JDAGhfwEtvQxHUJSUxb5ohneDZ/FIKcpEzMYENA17kvI5IjSXfvjM?=
 =?us-ascii?Q?TOSx0vA8+A7JgwVqGCGZpeIeWnLhxfO6cEU6gK0BR8lsXzfBA62raA2lXIcg?=
 =?us-ascii?Q?8PulpS/6vkkwL12/jRGmBbPZfR6CF79y1D5DkTU76xFSfTmMZ5IiUBeC1D4Z?=
 =?us-ascii?Q?rlBhHxLFf6OnDubrUE4PnLuDej43PMzK6dCieoXi3xcnYhVD8ru5Ym7SGRk5?=
 =?us-ascii?Q?uHQtmkrvee22R/7n81EWfmHgvpJeyoJITji5VLtbVpfhtS7BuQTN3xr9lnDl?=
 =?us-ascii?Q?PWLPNJYz1jz3V5rkr3aP3iMzBM+qeljVLzvT28MKq5dOsXHIWvbVmN3KqGbr?=
 =?us-ascii?Q?Kcu/Qhs2nQ0gQ3+i4whNEHWg8rU6zbWu+YJj+voBWDybkrvNJirKROiN8ET1?=
 =?us-ascii?Q?/SStDFUGpziPBe+LFyiGQ0bRgclh/p6bj2Rlh8jYl6Jzh+m00iFQQgdmQIIi?=
 =?us-ascii?Q?sw1kwo6YxEi/rLXqD8CqrYOojUCngi0RJKM/GIm8Z0NEsFLRjtvHA6FBAln5?=
 =?us-ascii?Q?abV+NYDSUnmMlaTekWbp6VauFNeDoIgo0A4tC6aJajyNpEMwiUVpJIOrvnWE?=
 =?us-ascii?Q?txnay5F9l8JAQCcva5wCwZhbIq1BJH6weCIH17hx1o1n3spl+MdRccu81kUo?=
 =?us-ascii?Q?XeR0Q5yWaLHCS2WEP2zA7Ezpcdc6DWeKrp+i3eYA5b4nVH54CYJvGw06Oqv2?=
 =?us-ascii?Q?wnwGlCZlMBo2DIV8YL8LUHdqird6qeMgSdwEGaqqWy2j9hr0jPX9bbKoFFIk?=
 =?us-ascii?Q?9YprMXtk+rPhSpTex8VdN8t1Z8W6ficFJdb6ICcp2+YfU0HVqZFcvIsc3+XZ?=
 =?us-ascii?Q?ZaRNW/mtfbF1U/6rTqe/fjX/NHfT8h8x0Xn2zvi1j32URFtlo6kmidxSHEOt?=
 =?us-ascii?Q?4d51nWLhMT8Eb7gDY/RAhR7JblEE9jyYZ43JNCOz7temddJ2F3gMQEzgMkWR?=
 =?us-ascii?Q?xMaxny2P6jVxTOUVr+kKFBEAapHFAM7Ze7ZqdBqAfkFttp25/rKaFXHBhX7Y?=
 =?us-ascii?Q?FjdjgRKfCwZySBvpUIS0F012q2d6sU9DrI9KCaHOm41T+DVTC70r+eII6x0y?=
 =?us-ascii?Q?KP6kFGOHzyw99BW4IG7kqBz/YTWpY4Wa4TPoiVhZ?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 13:10:53.9409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b94a881d-ed75-4633-d1ea-08de4ac98696
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB11551

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.2.2.1 of AccECN spec (RFC9768), if the Server
is in AccECN mode and in SYN-RCVD state, and if it receives a value of
zero on a pure ACK with SYN=0 and no SACK blocks, for the rest of the
connection the Server MUST NOT set ECT on outgoing packets and MUST
NOT respond to AccECN feedback. Nonetheless, as a Data Receiver it
MUST NOT disable AccECN feedback.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v3:
- Remove unnecessary brackets.
---
 include/net/tcp_ecn.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 796c613b5ef3..49e0b865fe02 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -175,7 +175,9 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 	switch (ace) {
 	case 0x0:
 		/* Invalid value */
-		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
+		if (!TCP_SKB_CB(skb)->sacked)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV |
+						     TCP_ACCECN_OPT_FAIL_RECV);
 		break;
 	case 0x7:
 	case 0x5:
-- 
2.34.1


