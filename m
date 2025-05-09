Return-Path: <linux-kselftest+bounces-32792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C273EAB1EEC
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 831607B6277
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD0D263C8F;
	Fri,  9 May 2025 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="bd3RnK/C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEA0262FEC;
	Fri,  9 May 2025 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746825545; cv=fail; b=Bw8EcAZxZaRajpoEMZ4Ol3iu8udRN0CE0ZSd6NSMHy+cGuFSHzAKgs5DTvGyWwdDZ1OSEbGan1EF5OakG9U+AlFDVWQ0CG4Rk/ASGyipYHY/N+zcHU7Qza8FGj+Fmd26+MMCjZyOxc3I0ePLdfUi8abhZsnmsW/OTDSa6AV+GNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746825545; c=relaxed/simple;
	bh=1pCiRVrGhv4R0XrPgS61RGmSnDL2HVJVzufoYbtWiTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdsEqx4WAEYZvCVh/wIU/8Kr9+Njgih23tnfJSX9nZs8RbevkitrTYeZEMpXnnfC0DIjr8sy6ZOjFYGS/VeqAwCz53IpHRlxXI7tWcGQe/HOYMuedn4nxrsgDGEEjOsNczTLiGSJ14a9txZpCrh99uERagodJJlYQC/l8K7PBhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=bd3RnK/C; arc=fail smtp.client-ip=40.107.21.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLY7HyddM7WQ2hGjQeP00QubGpfXoGbv6rnKwEdGiNSzdgqX5JupcmJDVnpyraC/QIg+lQVS1ff3ciJQSe9lBLA1nFahp8gAf1LzE7BvHmq5JENBaiw2E+RVz3SWZmAAJYODYoOAscjt8BK3J5s+IaZseEDBovR1AhsoI7Jp+ucetyZVuyvqE3plJI1kYhlagpsa/slc7HjmXATN88QkQXZNXb3FFe8I2aG3YRB1HM7qoUS08PUEvhf5tbsSWW+LRpep9Xm3gfEsIxYmonY2iFMQpCWSzme//mKOer6v/D7T8SKhuAzWlFr+//Vvgm5v5d22zGulOa44ZXle+QLxfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoGNrcdrYXgWHVsxSZNFPxnoXNEmlUXIofckmi/u/Yk=;
 b=TsP27IbibRBGEck1o6y9aNwc26G2dntlbpz49BcL6vQWXPDnmqkvDeAu4RU5YwzOo8pf+rntxXPkfcTbnRRrJ18Qp8CexqIVi1rK76BO+jYx4nnBlnmnhLs4YhhY8PVNBUIc64l40fj7zfodBIkbApQHVDidcDhSpnoy/OXrn+iscE/v2Bz46EyL4RYGUyfdnWXqaMNDKL8PAaf1PHcGtXchF0H3A3Iknf/3xLUAvXuzYmUlPHXJC22YiE3co6pQM6N00Td9uT2HLUmeQYSWOwrYP61vmxW1QepaDl1TFWNGkUS3Cudq2u8bCY9LUXHfXNRSIM887lNr+JnWYKsKWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoGNrcdrYXgWHVsxSZNFPxnoXNEmlUXIofckmi/u/Yk=;
 b=bd3RnK/Cg41KH3CQ4Bf4UNFlitWAppHDhCjBSzKJ2bbDwgVlPYluAfjvBklPpsd0LXZsmaXx/dlnMTLN9Vs+VhWfBRddpmdA1zXKCjtOIH7HQrqwRSGdWX3of1dCVIN4AdmxoTlte9FnzT2gNx7OsiJonKHoON7OpuhjgFrh2EKPOBv981wCWBEJv7JdmCbmTdLxBWOjZ2skyOYODrUo8Yg8o8Haf/bw12zPl7ZsSEyALuIMbxAPs9zqJsbR3Bed8HrxZ4fdgErrRSUkeMlb2rHsh3vhV1GqnnvubQHIfBe0ea3FNN0aQ0aC1BxBi5KPiA4qr8g1t8vuBk/q1W/eow==
Received: from AS4P195CA0021.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::9)
 by AS2PR07MB9004.eurprd07.prod.outlook.com (2603:10a6:20b:557::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 21:18:59 +0000
Received: from AMS0EPF000001B5.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::5d) by AS4P195CA0021.outlook.office365.com
 (2603:10a6:20b:5d6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.24 via Frontend Transport; Fri,
 9 May 2025 21:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF000001B5.mail.protection.outlook.com (10.167.16.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Fri, 9 May 2025 21:18:59 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id A3F682009B;
	Sat, 10 May 2025 00:18:57 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
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
Subject: [PATCH v6 net-next 12/15] tcp: accecn: AccECN option ceb/cep heuristic
Date: Fri,  9 May 2025 23:18:17 +0200
Message-Id: <20250509211820.36880-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B5:EE_|AS2PR07MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ed94f3-d5db-47b2-11a1-08dd8f3f1d21
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZkJEbTBiaTVIbkczMDZ2cUIwbVlCZlc3VXNTR3JXditaSFZZS0lQa2xFc05u?=
 =?utf-8?B?cHQ5d1pxNDFzUFhtU0NQTGt0NVgxcENCTU1sdjlEVzZOTmNnS3FTYWxCU25U?=
 =?utf-8?B?S09KeWE3WmNtNmE1SWlHRXozRXJNVEJEbFE1WTlyZ0ttZ2VXcHluRWpOZkQr?=
 =?utf-8?B?dlZlUXRud01maEhiaFowKzREWDU4MjU5V2VUQWU1Z1dIQ0VuQy9uMjBwakJR?=
 =?utf-8?B?aC91QlN6b3o0eHM4QzJISzI3dVZpclZyTWx6cVhRM01VVVhDeW5hQ3F0WG1N?=
 =?utf-8?B?S3lOR3Q0YzB3TnQwNUJKYS9tT01FaTUxK1A5WlQvVS9peFYvTUVmUGJ1QVlk?=
 =?utf-8?B?THVBWFM2VklSd0Q2NSs2TVJES296cnlPd282dXVwVnlkOTlDdHdPZi8zUVFM?=
 =?utf-8?B?cExNUFgzNk5vOU00NDc3MU9GN1FLeEpHTFhDeVZpTkYxUjVQNmhCaEVhWVNv?=
 =?utf-8?B?VTc0ckgxRHpZYktlS3VpL2dpK2NzY1JIdFlZRDc0cWZ3S3NuRkkwOWczVTdJ?=
 =?utf-8?B?SVByaWRTbUNQTktjS2NpY2t3c2ZrZy8yNTloTHdETGJLVkt2RFNFemV6bS9E?=
 =?utf-8?B?MDZFbXM2KzBnTk5BVFA5OEoyaEE1MCtnb2FUcVM3Rm1wdWErSERVTTN4Unds?=
 =?utf-8?B?bVFUeXNzL0UrRG82WVVHbVZlRXh2WmxOZWYvd1FpNXVWVlRVcUtNR0hiaXBF?=
 =?utf-8?B?eGlCNkFycmlTUjJZaVBYeEdSU2xyclJMZ1N5MUtaeklUbU9NSGhSbWh0c2JU?=
 =?utf-8?B?K2dQeVdpNzVmWW5IenIzWGhFMlN0WFVnSGFnY2o2ejFGVE40RzJScXRtREhB?=
 =?utf-8?B?Tmd4ZXpZdEpYUC8vL1JqaGx4NFh3U2JiZ3ZZTEFJbExKWStodGhDZVcxaEt1?=
 =?utf-8?B?RnY3RWV2eEFFVEFmK3BZblIrYXdVRU5TQ2xzRHpCUThLUElCK2d6cDlYSzNh?=
 =?utf-8?B?MFZETVFnM3o4bW5EMllvU1hwL3NyK3IwenZwOFpid2d1d25DcXgvaEtMemJ2?=
 =?utf-8?B?WXUzWnlUUCtvYjRia3RjWjlZY3pvMnlDby9vaWQ1S3Byak04K2pPekRvcGdZ?=
 =?utf-8?B?QlFVbzJFMzNKZndGaVJPRGFDQkNqZHh6Q3NaMzF2VDlVUmFhNGpPVi9Ddi9C?=
 =?utf-8?B?NWVoNUtGMEF4aW9lejA3L1hQUHVQSHFTVGxHa0I0elJDL3pyK3dQSHJPK0F6?=
 =?utf-8?B?TVppdVQ4aGlHZGJzd2F6R1VZcEVqanVYRmYrc1hRdGVPWmh5YVpLRWlQODJ5?=
 =?utf-8?B?VTB4bjJydlJFQVlBbno2VXpQZ1ZJUkRGTXI0SUJ3VGdGYkRRSG9yZFd5RnhV?=
 =?utf-8?B?SGpwUDdWckpZRDcwUnpPT3N0dHNuOHNHVFR0YzFDVXh3cytKNUl5eW05eWVJ?=
 =?utf-8?B?NFI5TmNBK0hCRUFScEZOWGVLTlZ1ZGVDeUcxTThGM3M3UjRGWkdoQ0ZNV2hW?=
 =?utf-8?B?RzM1WGZtVk4ySUVtM0F6UGVMNk1YNVVyOTFxc3JlclZUNVlRWHFaaEhLaXJK?=
 =?utf-8?B?TkxJbi9TTUNRZXVjNFJ4ZzNiMzd6bzNKeXRWTjlucjdCOGpNRi9lbkpnMHh4?=
 =?utf-8?B?VkZ6eEJDUWJNUnVDUnRXenZXNWNzWnR3WnVqaXBON0pwcjU2cmFveVJpSHgx?=
 =?utf-8?B?YmFHcW9hNDFQbytiMnZVeTRvQTFRK3hOV3Q4blFEazZIQ2JvSlFyajREQ3VL?=
 =?utf-8?B?b2Y5SEo0N3NISFROSFVvM3c1a3Vod1V5aEQza29NQmJjODBDemhMYWR2c052?=
 =?utf-8?B?cnZtSmVmSTZnVkkvcXBCdEluV0Z2alVnbXlPbXByaUdOOWViMXBWRS9VS2NC?=
 =?utf-8?B?Wis3Wk52QUl1Z2dUMkNURU93YU0vQSt0MDVvU2Q2b2N4ZUtpUy9MWEhwaExk?=
 =?utf-8?B?T2NnWWt6L3JuMVA1R1JCRGlPbWY5d2dWMU1QdlJLSEg3eFdtTVNQSDVGelVC?=
 =?utf-8?B?Z3hxUGp2anEzczRySzJERysvVldYV29jdG9WM0R6aStZaXRFaW9zMUE5MzBk?=
 =?utf-8?B?ZGlOZFF6UU4wc3AyYWJZNlorTVlJalhFOWlQSDlvcGpETFdNNUhQMVhqakRn?=
 =?utf-8?B?djdLRzJuR2NxbnlzcW5CeTVBSDJ5S1U3UXo1UT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:18:59.0490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ed94f3-d5db-47b2-11a1-08dd8f3f1d21
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9004

From: Ilpo Järvinen <ij@kernel.org>

The heuristic algorithm from draft-11 Appendix A.2.2 to
mitigate against false ACE field overflows.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp_input.c | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5e4593e39de4..201326b10396 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -247,6 +247,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCP_ACCECN_MAXSIZE		(TCPOLEN_ACCECN_BASE + \
 					 TCPOLEN_ACCECN_PERFIELD * \
 					 TCP_ACCECN_NUMFIELDS)
+#define TCP_ACCECN_SAFETY_SHIFT		1 /* SAFETY_FACTOR in accecn draft */
 
 /* tp->accecn_fail_mode */
 #define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c93e4bffb23e..f206c1a93a56 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -709,16 +709,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
 				int flag)
 {
+	u32 old_ceb = tcp_sk(sk)->delivered_ecn_bytes[INET_ECN_CE - 1];
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 delta, safe_delta;
+	u32 delta, safe_delta, d_ceb;
+	bool opt_deltas_valid;
 	u32 corrected_ace;
 
 	/* Reordered ACK or uncertain due to lack of data to send and ts */
 	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
 		return 0;
 
-	tcp_accecn_process_option(tp, skb, delivered_bytes, flag);
+	opt_deltas_valid = tcp_accecn_process_option(tp, skb,
+						     delivered_bytes, flag);
 
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
@@ -741,6 +744,17 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	safe_delta = delivered_pkts -
 		     ((delivered_pkts - delta) & TCP_ACCECN_CEP_ACE_MASK);
 
+	if (opt_deltas_valid) {
+		d_ceb = tp->delivered_ecn_bytes[INET_ECN_CE - 1] - old_ceb;
+		if (!d_ceb)
+			return delta;
+		if (d_ceb > delta * tp->mss_cache)
+			return safe_delta;
+		if (d_ceb <
+		    safe_delta * tp->mss_cache >> TCP_ACCECN_SAFETY_SHIFT)
+			return delta;
+	}
+
 	return safe_delta;
 }
 
-- 
2.34.1


