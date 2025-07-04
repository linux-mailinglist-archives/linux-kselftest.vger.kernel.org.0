Return-Path: <linux-kselftest+bounces-36522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7008FAF8E86
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 11:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A691AB41BA1
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 09:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD46D2EF656;
	Fri,  4 Jul 2025 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="WotqGh/X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA652EF2AA;
	Fri,  4 Jul 2025 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619325; cv=fail; b=dwjxz125UG0oU3q+Qk6f7lRtJ43fEGtR53O+fPH7VT3xHXC6hZDbS5ILFQw658gXP+b0p23uHs9gPpx3fS+E6Oa7vwQFgdPzSCp/zPo0AJHdVHFBhx1cCRLmts56MCFFMaSVV9zK9rYEfT0I5Zna+GYUyTRNfNLyTzxx2Jfe1oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619325; c=relaxed/simple;
	bh=Dxhz+4hIUE9CU9odTvOb3csSa6qB3eQT1ofObVBJEik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elECUY15CydzG+bNHXmDuIJ9Fdz3l02ti+iTHPmYnLAr3x85HACgGSD4s1QnUUrlqELejeZCzN6/fNcttVuWCtgxeVX3X9fSUj+gA3S9VuTOkCW0eL+kRtFBtIwgrktXLCFFMdr2JqKnQLxATR6vUvHFmw/DD2/4Nha4U4S+mgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=WotqGh/X; arc=fail smtp.client-ip=52.101.84.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQW+QssLU15o7lPCnRwafmX8GrIIID47XpOy3/cTx69S3zy6RGBTz7SdQikznXPvgwLzBKG6XWBJTpoWbYBf8A/ppFmBd9kgpnuwysQ4dsmSlQ8go98P+WkjHFq3mPeiLb3vOz5AL0A5HG7iBN/hBNhX0PNlhjJhij6OGk7n3YwOFlMQHz2z3Q+DdY6Qu271vkCHnC2DQq1M+EGiGhzKezuQQTNFh6iXVxIu+1GCW8ootwwhaYGo97CSRNDPY2FHgxuqs1pK2u8A6/PqfzViT0MTLnKqQ/1FYAJXnNzFH+WfqVYViPxlb0Wq1POJxU7/4IFKb2MCYCJSJOe7fAh6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vev4SbXsKlSveZ5ZGBx2T9TjFUH8UIT+uor4XjzrD+s=;
 b=w8UKhXzocQ6oellZbROGqzPslI6IKOqt9DvKfYcAVfREhmv55OFPpI46qESTsq4VkvVAla6Hx64rORSKlydsbzuqs2rnQedDmYGGO5qa7zE6VIgNmxuJzx9KBPUs0YtwoOCpY6wsp3snjVH2/b0JmCIJuELBurQ3Xp2q+7s9wSd+/uJMweCdFeEapXDNF2GYv3S67eVERgM+EuOIaYnf2rsUZXZr6bTKEIh2ijFaAFw3as0rf7nWBeG+kivuD3O6apaoRgdMjqr+sUV3a7NMsEu40FMWNSfVwtpwajzFfa1Zm63EzoYmB6FDrOgLc1t/TIQQ0HSUvh9ii8vyGSB0jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vev4SbXsKlSveZ5ZGBx2T9TjFUH8UIT+uor4XjzrD+s=;
 b=WotqGh/XLvgXEZHPVFyZj6rr28ZrEUfDpjvRDkqGhBy5Z5EQSyrDFR0Vdrsfu5CXy7Sl/PMLz6AakeVdaYOrYEBaIL0164pCeHaEaAQhAbUerh69rLCFfdwNxB9e/l5c85zq2Bv+ALYafIhNbcpMpf/c3N+SGnIV+o4PhOn98LAeVAbUsBiskGm1HtJmgO2vBnuyd++MgOVeCc4g6J20l197AGa7SDBLtOAMWs8UCTO7QtwJi5vXRDhObSzG4bWom1aZeQnVTyVtcWoEhlNr/0fJGLJ/l43VtmjMOLX5+3lyGAX+35WYvmOXW+ir/MVOzJquDU90HywRe0uaJc1npw==
Received: from DU2P250CA0005.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::10)
 by DU4PR07MB10345.eurprd07.prod.outlook.com (2603:10a6:10:5cd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 08:55:20 +0000
Received: from DU6PEPF0000B61D.eurprd02.prod.outlook.com
 (2603:10a6:10:231:cafe::76) by DU2P250CA0005.outlook.office365.com
 (2603:10a6:10:231::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Fri,
 4 Jul 2025 08:55:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU6PEPF0000B61D.mail.protection.outlook.com (10.167.8.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20
 via Frontend Transport; Fri, 4 Jul 2025 08:55:19 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 59A2320138;
	Fri,  4 Jul 2025 11:55:18 +0300 (EEST)
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
Subject: [PATCH v12 net-next 07/15] tcp: Add wait_third_ack for ECN negotiation in simultaneous connect
Date: Fri,  4 Jul 2025 10:53:37 +0200
Message-Id: <20250704085345.46530-8-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61D:EE_|DU4PR07MB10345:EE_
X-MS-Office365-Filtering-Correlation-Id: f260c0dc-4864-4249-4d24-08ddbad8812c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3hKVkZFWDl4OHBMWjNSaHBIejljR3MvNUd2RjkxWUJqNW1GWER4cTBNYlk5?=
 =?utf-8?B?L2lGY0RaTVNQODZkaFZZd2t5VExmcWlQb01nVU9tWEg5cmtFb2tmUVBXY2Nj?=
 =?utf-8?B?aURDSUVVaS9yNm9RVk53SUNVNG93TWs1ZDlSbTMvQkY1NlZvMDhxNk1qeElj?=
 =?utf-8?B?aStHdkZ3MEJjNkZkQU51azhtU3pDa20xRE9IZjlGT2hPR1N0OUZFbUUwMEQ2?=
 =?utf-8?B?QXlUSGdZYUk3RWE2ekVFMW8yaFYwT0Z3NnJQQUtZYy9vTnAwZEwrcDBycXNI?=
 =?utf-8?B?YlBCVnBkRHN3cFBJZ3Y2SkFVaHJXdFVWSmJ2Vk9ZaVNjd2U3NHRDdEtEaFp3?=
 =?utf-8?B?UVpuVEl4SlhJQTJiaGxZVlhQWTJmT0tEalVlQ2Zkem1LMk9Qd0h5NUVIbzRo?=
 =?utf-8?B?YU1LYm9DTnpSc2NYZ1g3NGo0NUdsRnlTM1ZKMDRQUjRZdVNsZFhNbzFac2hF?=
 =?utf-8?B?YXRXYllPRjNKSHExeURaVTc5Q1AvcVk1dXErb1ZKbnJ6TkJvYzlIUXpEbGlo?=
 =?utf-8?B?SDFLTFp5K3BTUWp2WDJ1UWNpMGJ3QnoyVURIbDNyaGc1OEkxVTFvMVNoVDJP?=
 =?utf-8?B?N09ncmhvb0xCb2NxOTdjS091ZkRVNHJqQjhja0hsMXpoZlB2VmpZRWlLbCtp?=
 =?utf-8?B?SjB4L1IvdEZINjdlTlAyWUR0dnk3dGM1Tk5rTzdFMTdCdGhuWTYyeTNqaVNq?=
 =?utf-8?B?S0s3bGc5TjdOV3FhZWtmQmx5RWIweTloS0NDZ1lZZklLZ3Uzdys5cHlCUmE1?=
 =?utf-8?B?RlI5cVFyMTRDRmtocE1OVCtScWo1c2VuWk53MElzdHBlMnZoREVXS0lMTElz?=
 =?utf-8?B?VWxQNUt3MDludDE0d25UM204UGg3TWtxcU01dGI2Z21TWHRPdlUrNUZZRklw?=
 =?utf-8?B?eGxIeitPdkNPUDRzN0pVdzBhU3I2d0d3NG5HbmhVQi96QUFWUitNTkk1TnhJ?=
 =?utf-8?B?aUFESUZic2dPTFlYYVRUbHhwYUxVZDRDWHdWOGJHQ1dLc3NCVDlmNzhyVStj?=
 =?utf-8?B?bUtTbkkySmFPN0pqaElHQzFTV0hGMERzUUl3T1RnVEYxdWRTS2xhbTM1V2Ew?=
 =?utf-8?B?Mmg3c0FCYzdYUHp2MUExMDNMa2ZIT0JsSUgwdjFXZmZiQ3MrdXRKYXZuN1gw?=
 =?utf-8?B?RXdwRUNvdy8rSk1tcDFwM3Y0bG9sMmRUWGJJT2w1YnI1c0RGR2NUYjI2c244?=
 =?utf-8?B?cDExVk1odCtaM0RBVjRMc2dpeW5nNXl4aUhsMCtvVmdpbXNGMEFmL0lvaXo3?=
 =?utf-8?B?bitRKzFBTEZtckJXY3NmN2ZPRVZYRm52SW1yeGhlQVpVZTVXVUFMVTZ5QXFk?=
 =?utf-8?B?bWRQS2tTZjF3R3FkK3RZcmhuS1JoeFZtUWs1bnVOeW1YTWovWmtWYUtFclBl?=
 =?utf-8?B?TUxUMnduZHA5cENOa090VFFRbVFvU25iK1lpbzhBaDRoZHVxSU5PT09YVnRs?=
 =?utf-8?B?Q0llQ3p2dHdNQkRBTnlJTDk3VG45bHd5S2V4VlhvSXFmTGs2TUg5enlwYzVX?=
 =?utf-8?B?dm5ab2ZGV0I3d2M4OVlRaDJwRFQvRlc5UmM4OTVjY3EzOWJMOEhDMmlDdUth?=
 =?utf-8?B?UjFSUU5XdU1SRTMzeUJONlpCSUZLWHVXVjNuY0lCd2VDNHBRTTRpNzV5UjRo?=
 =?utf-8?B?cGMyNXBrMVR5K0R2alc1Z08rTVVVZ1RYTENPdDVkY2laVzJUaDhjcEZlZy9Y?=
 =?utf-8?B?QU5HVzVFZ2ljVFJFVmNNVC9JY0tXZTVPbGhXK3poOTFGREFteGRzaTZQNnFa?=
 =?utf-8?B?SEVNL1RZZE9aUWNOaWt6Q3g4QjFsRmlGeW5FeHlBVHVLVWVNQWN4ZFNXOTFv?=
 =?utf-8?B?bUJ2WCtiMHUyc0lKU1F6RDJDS2xIMmVYNHR2WTZpUXdtQjBZcFNxWGo4QVNk?=
 =?utf-8?B?b1NnQWhwR3JVM0wybk8xQ081cVZuWUxSS2R4U25sQW00MnM3MkdGSGJYRk1Q?=
 =?utf-8?B?Y0s4cFBHM2FmbW9KRk9pZFA4TWNRb2ZlQWNrYXRhZlJBaXFhdUpDMERwWFQv?=
 =?utf-8?B?ZTlmRzc4YWFXODNFMzRGbGxBMm55VHZ0aGVQK1dsQWZxZmxBRURUS2hCWlpE?=
 =?utf-8?B?M1VJZnppbHNIdjB0b1NzVmFKeC82eDYvUHk1dz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 08:55:19.8541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f260c0dc-4864-4249-4d24-08ddbad8812c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB10345

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

In simultaneous connect scenario, the connection will be established
when SYN/ACK is received after patch 23e89e8ee7be7. However, the
third ACK is still anticipated to complete the negotiation for either
RFC3168 ECN and Accurate ECN. In this sense, an additional flag
wait_third_ack is introduced to identify that the 3rd ACK is still
anticipated to ensure ECN or AccECN negotiation will be done in the
ESTABLISHED state.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  3 ++-
 net/ipv4/tcp.c                                |  1 +
 net/ipv4/tcp_input.c                          | 23 +++++++++++++++----
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 4f71ece7c655..22ac668fe6c7 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -105,6 +105,7 @@ u32                           received_ce             read_mostly         read_w
 u8:4                          received_ce_pending     read_mostly         read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
+u8:1                          wait_third_ack                              read_write
 u8:4                          accecn_fail_mode
 u32                           lost                                        read_mostly         tcp_ack
 u32                           app_limited             read_write          read_mostly         tcp_rate_check_app_limited,tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 994a6e7256e1..1d8301f2883c 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -380,7 +380,8 @@ struct tcp_sock {
 	u8	dup_ack_counter:2,
 		tlp_retrans:1,	/* TLP is a retransmission */
 		syn_ect_snt:2,	/* AccECN ECT memory, only */
-		syn_ect_rcv:2;	/* ... needed durign 3WHS + first seqno */
+		syn_ect_rcv:2,	/* ... needed durign 3WHS + first seqno */
+		wait_third_ack:1; /* Wait 3rd ACK in simultaneous open */
 	u8	thin_lto    : 1,/* Use linear timeouts for thin streams */
 		fastopen_connect:1, /* FASTOPEN_CONNECT sockopt */
 		fastopen_no_cookie:1, /* Allow send/recv SYN+data without a cookie */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 45c85c788def..0548c74458c6 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3391,6 +3391,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->window_clamp = 0;
 	tp->delivered = 0;
 	tp->delivered_ce = 0;
+	tp->wait_third_ack = 0;
 	tp->accecn_fail_mode = 0;
 	tcp_accecn_init_counters(tp);
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ea5d47354978..7ccfde9bcfda 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6001,8 +6001,13 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
 		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
 		    TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
-		    TCP_SKB_CB(skb)->ack_seq == tp->snd_nxt)
+		    TCP_SKB_CB(skb)->ack_seq == tp->snd_nxt) {
+			if (!tcp_ecn_disabled(tp)) {
+				tp->wait_third_ack = true;
+				tcp_send_ack_reflect_ect(sk, accecn_reflector);
+			}
 			goto pass;
+		}
 syn_challenge:
 		if (syn_inerr)
 			TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
@@ -6220,6 +6225,12 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 		return;
 
 step5:
+	if (unlikely(tp->wait_third_ack)) {
+		tp->wait_third_ack = 0;
+		if (tcp_ecn_mode_accecn(tp))
+			tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
+		tcp_fast_path_on(tp);
+	}
 	tcp_ecn_received_counters(sk, skb);
 
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
@@ -6833,12 +6844,16 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		tp->lsndtime = tcp_jiffies32;
 
 		tcp_initialize_rcv_mss(sk);
-		if (tcp_ecn_mode_accecn(tp))
-			tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
-		tcp_fast_path_on(tp);
+		if (likely(!tp->wait_third_ack)) {
+			if (tcp_ecn_mode_accecn(tp))
+				tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
+			tcp_fast_path_on(tp);
+		}
 		if (sk->sk_shutdown & SEND_SHUTDOWN)
 			tcp_shutdown(sk, SEND_SHUTDOWN);
 
+		if (sk->sk_socket && tp->wait_third_ack)
+			goto consume;
 		break;
 
 	case TCP_FIN_WAIT1: {
-- 
2.34.1


