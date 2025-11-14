Return-Path: <linux-kselftest+bounces-45617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A66A9C5BB91
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B85AC35A7A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 07:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713762F6587;
	Fri, 14 Nov 2025 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Mwv0xpjg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012014.outbound.protection.outlook.com [52.101.66.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0812253B0;
	Fri, 14 Nov 2025 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104450; cv=fail; b=fg/AEpY9RaK4wl02KlNqVmtPTD5NJFWa9JI2UwuFdUBLizF222JNsHuNcEy87qTVYjUsAovutz2mCSaZlHGE6xsA/MQiVn6FGEBhOi0eFRUgxHzbBAsX8wl6DBtSYe3uvTuxXprqvwqRf64C7GjQWb96kb5jDhBmd3NJWldG07c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104450; c=relaxed/simple;
	bh=yTT+qc/3vzjm/nJngNA3FRGBfF7Rj0yXW7Tk/nrQpRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbpV9yNiRXILLv0gkAlsloE11vhEBojXYiYmqrNvGW7us95iZV+5mKhLuNk2meXvP/gn/8Tc6A3v/aaU8fO381XKZMNs6ndtbm2+dkcGnMPFwEZH6JJSTHeye9c4vPTyyDn/4P0vybhEtQvbzd4HIS/YNaKCnIozn7xMhNCgLpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Mwv0xpjg; arc=fail smtp.client-ip=52.101.66.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSTOyWkFR0K8dVqggTXVuukprUr9RibgipRJwg5wI6RRyhoM4fgwZ9+Ms4qbbiyaYqKn8e9XOPZ4Q7XYVW10VVI3QDhWcbNAKv/DRdhmAboBsokeTHofYp5weuSNQNiCDG5q4sEZ3pwCMgeQLpK5l2BGSdi23raR5j3L2ZMuEmOiwGW70VHiXhAoSDO3ciBGFh9tfu7UysARvatnEWVVZ63LJY6AiBQCSnAk9H0vGlfplE0U4BhPyCO3nbqjEBW7KvnfmS+hVh595SEsc5ROjTlfTNyLvNiJGvc6lcxTn/Ujqo0dfkO8QHZWegnBu3pmUSKAYyIzbEekP3aH+yDGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHLm9CM/ANQpsK0+V7FGw8GCz+BddJECcCSY7tdQ18I=;
 b=J0aWvoqMC5ntqASfN9xKT7TN4dKF+8E2Q84ohY35cPEBmr22aPIrjHGsNiXvlUxLQ4mfgfTf8l+It7OntXqqm780VSGPLzKiOgvS6poWLBHntbCY0e++LExCZp0uTipsSfYtlWWFX2OsxymKFbWUyEY9+bZTgdoIT9ZQ2N7Kfwr9s9lM+5IffxUWOb8euedM/JoFhRR+hpaJ65UVgSwNFulpxQYoYt48ZaknIjsKWZ4cxfZWcnMloUawlUgOzvI3j7W9sqSSLutR++fHNxGIYxVaTj7BvBlKV9LzdsKbCdy6lGvqWUKiBZnsMV1T3CSh6JplGVZLSUKYh4k4VMhoqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHLm9CM/ANQpsK0+V7FGw8GCz+BddJECcCSY7tdQ18I=;
 b=Mwv0xpjgGj5vHTxNR2nLaorPmzZTzooYv/denVE2S8j/X2l8jHwirniIWYWJjw+9+oK5bpGlteSsvgFM6U7tZy3cz9014st80mitorw17EfMxEZXVAKIef8SduKIO5VS3uMZwURWKm9IKuJa4ky4mK3zq4B+Zw5/IcezfHYCCiHL1/AdwMnxdtr7lu2rtQ41V/M8BKJUk+jCeEj/ntsRsv3S3OZAjPqT8a1RUJpHbPBhOUlI0g8Gb1SJzyVZyLxNtUz9QQUJLX0Gq294y5DWKEhaQKZpkuIRs6f5vYCe27eEzs4croGedEszjPryLQKthS3Y3Im2bpo8qA8dS38Rpg==
Received: from DB3PR06CA0017.eurprd06.prod.outlook.com (2603:10a6:8:1::30) by
 AS5PR07MB10521.eurprd07.prod.outlook.com (2603:10a6:20b:6c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 07:14:03 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:8:1:cafe::54) by DB3PR06CA0017.outlook.office365.com
 (2603:10a6:8:1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 07:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.13
 via Frontend Transport; Fri, 14 Nov 2025 07:14:02 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 7CDE11C0037;
	Fri, 14 Nov 2025 09:14:00 +0200 (EET)
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
Subject: [PATCH v6 net-next 05/14] tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
Date: Fri, 14 Nov 2025 08:13:36 +0100
Message-Id: <20251114071345.10769-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E9:EE_|AS5PR07MB10521:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fea686c-fd29-46de-f5c7-08de234d6387
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Ui9MZXVYcENZZ0RXOEpJSVBEQmZQOEJwRXU3a2V2d212dGRXSk5ONDZKbWl5?=
 =?utf-8?B?ZlBkNkgvbmhIeTJGSWlRY3dnY0Rybk5uZ01uOEFZNFkydmlxQllPVklNcE9t?=
 =?utf-8?B?cUR4S241ZDZWMnJMZzQxQzVkY2w0aUlYU0lQU3NtcnIySTVLdjRiQlNqTHlL?=
 =?utf-8?B?b0hJV3hiK1RVQjFUdk8yVjBlMGI4WFNwb2tueXU5UWY4SzhrTExMZUY0SGhj?=
 =?utf-8?B?NEwzeCtWaUxsMVBVWUpwRDFMVHk2V3g0VldBSnVJYVBjNWkvSkUxSWgyYnhh?=
 =?utf-8?B?aVlrdnlFdUFhZC9QOU9XaDF5d29CYmp2UVJiSGtDM1pBM1dRVUpleExIRHow?=
 =?utf-8?B?engwQk5uaVIyV2QvaTU2MXU4MXVuVGJ3ZVFWeFlNTm9ROHdpTTIyUjlnbVEw?=
 =?utf-8?B?cDhRNVZ3V2c5SUo4VkFYYzk5ZUF5bno3ZHkrTXByNDgrNlRYZnNpNy9uSFND?=
 =?utf-8?B?YWJjWjQwa2thdllRM2dHYXJFdzZxWGRqUmhUelovMnBhSlFidVF0QnB1YnlK?=
 =?utf-8?B?bEJnT3JmOHJPemREWDVSVmlham9PNW9kZlpOQXRrWTR4NWRMdGptd0Z6dkdm?=
 =?utf-8?B?MWZOaHRBVmp2TVBMdmZEQlBTa2U0dGR1cWJNTW1NbkRKaklkM05WQ24xUmEz?=
 =?utf-8?B?TVpBN25HOGcrengrOC9QVkZoSHBIZW5XTjFBRUFVbEdtcVBKUlR5NjBzWU5E?=
 =?utf-8?B?TDh0M3NKSUJTU2lreTN4ZkEreThiUTdhNTZCeVZITGxTMWhOcURIcUo1em41?=
 =?utf-8?B?Tm9CL0toMnFvWlVVR3RsQlZCT2l1dENXY2VUNG5aRE0rK1dXZlFFcXJPRWZa?=
 =?utf-8?B?V3FZVXp2MVNIZ3cvNHZzYXlBUUxFQncxdk94dVlXUEhKKzlUVTRQT01MMERs?=
 =?utf-8?B?clpaWm52T0pVRUpVWkhGMnI3RVhqdURhYUlNT1IrdUdya1VNTU44Qld2cjh3?=
 =?utf-8?B?MU0rRGpaTm9IQXBQVFllakxKUCtXVnJOWWpodG5HRHNoTGgydzlkZHpWWUJ1?=
 =?utf-8?B?L0dOTlo5WkdiRk5EbDF5YVc3TTBmU05aMEUxSHVXOWl0K25qRm56RFlRNllJ?=
 =?utf-8?B?MVhhOXR3Vk90ZGo4bEFDWHlMU0packVWM3JzalVOZmFYd1Rxb1FSdVY3U2pL?=
 =?utf-8?B?WUk4bmFDZ1B2MUV0QWxqMHdvL254TXZlNVVHQW1EMTRhbC9NNGFxTFV0S3ha?=
 =?utf-8?B?TTd6SzVFWWJtR25wM1RyWTBtRnZiZWtYOHlaZG1DWnJ5NkZMSmtZUDNheUdw?=
 =?utf-8?B?NHRobit2M28xNGlSNWEwZG1DRkQ3bHkxMjkxdnpla1JGbkZQcXY2L3IraU9M?=
 =?utf-8?B?blBHZktZLzEycE1YdHpEbWFNSjVuc0wxNTM5ZVAxTHpxUHFtbm5IVnZJeVJp?=
 =?utf-8?B?QmE1MWppNWl3eXdhUlZVa1FjYk5FanZ3dm5TRTQ2VTNlV0lqdytLZThmQ0tW?=
 =?utf-8?B?OEV0RFF5TzF4RmZXdXd2eE1jVTNLY0lWWGZHVjBCd2FkUUNBK3dJWUZWQ09n?=
 =?utf-8?B?clBLQkZFQk9nbFRWUGRxMUZlVXNGc0JJMEs3UzV0RVRuaG1aMm95Y0psM0wx?=
 =?utf-8?B?akt4QkNsNUtNVUVidEF1SEpINlB5WUJHZzA3Y29zS3FUNGgxbHc2OVQwMWg1?=
 =?utf-8?B?RVlWL21ZTVZGNkpRUWxGVkNvTEREeGlmYWh0QjA0VDkzbHVsNmtpSUFSMnhK?=
 =?utf-8?B?NU8wNVdXbkdlNW4xdW11VlFvUFhVTDhDV3Eva2kyUEQ2QVVublFXTlNDSCti?=
 =?utf-8?B?WTJHczAwakZubFlubjM0b2t5TXQ5TW5NZFc5MmIwVW8wbFFpRlNpOWl5YXQ4?=
 =?utf-8?B?QkxlRTVFSjdVTXFnNUNzeGpTTGZYdEVsMmJqcXhLWGFMQVVERmhyQmtkSFNa?=
 =?utf-8?B?WURvMTd1RjdQdFpsbCsxOEoxd1YvTDdsQm1HblZ2SDNvbWM3MXNvRFpzcmZo?=
 =?utf-8?B?MVc4L2Zxam9XU0pobW1DWmNuYUx4cm8rVHJoVzRydGprZ3I0L1QrcFJFcmtw?=
 =?utf-8?B?cHJybWQ2OHg3TTVaQURrdXVIaWEyaVVTenJ5QlFWZGNYZlJFakVzYlFyTFdH?=
 =?utf-8?B?bGNkcDJoREF6UXltUGdjTERHZDRENGoxRWVyNG1oTDlRRFI4SnIyRHF0Tk1M?=
 =?utf-8?Q?gDkqBAScvbY2Us8asV9lkUfro?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:14:02.1676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fea686c-fd29-46de-f5c7-08de234d6387
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10521

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
index 4833ec7903ec..2e1a5b3d1c5c 100644
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
index eddd2e54d119..3fa4a70d429f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7256,7 +7256,8 @@ static void tcp_ecn_create_request(struct request_sock *req,
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


