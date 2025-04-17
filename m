Return-Path: <linux-kselftest+bounces-31086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5DCA92D7B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 01:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646141B64D8A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 23:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6472185B8;
	Thu, 17 Apr 2025 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="guIP0KQ4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FF91624DC;
	Thu, 17 Apr 2025 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930850; cv=fail; b=cfJH+mR9rfVwgKzAOk8hogTesVeJw9iwixXzjOFXnz0R0T/D1wyzV3GnvTi/eHBObIdZZ/w+QStKjbSDf4XvjvyTcTId2onVaU9r7ZKe7NnUAK3NFZwhbDrqOhRyNWXIJmyPnZcwtBZseS61/VCTbpo4cX07rO1HpLWkVItzjHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930850; c=relaxed/simple;
	bh=PYyCXUuKVKRWlC5fYTcacULQXbuy70otEK62ZKgXQqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9gXl8IVzCgJ/TAKUY3QPYLNlygnl+GFJRG7NUD5tpsgusF+VNM/FUC6cB0e+XnAWqZ2rYfGgD/l31o02IR0/Zvz5Kh8lB0GvToxFUCCdHyT/gDwa4KIPiQrkYwCsCA9kPuduGgakXyddmhM3wDR1+wBdYZ6iqS+FRIv1tO91CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=guIP0KQ4; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmzr1JLlyp45qXfLTqhF4YaWBfsWeA5/6iDeccaOaFfAospt223Ajg4PstMN+QAr0XLom2C2V6CWJh3wf4fj1n3VUuswcaObdWJGDipFTl5obhNz4eUMctzyqXcZOneyzrRpvFwyMVzg9VG13AP1X2+1NdHfZuGEIWByDAyyyfLQgVFVgOVHUZueMwO8CgOHTggM1ixMr3Pa3GqU4JWN543dQbYGUIeCBR3ayRuo36hToQrrMd4rb7NXySzCpbloQtGDNu/djoxGHdhbkTkQGuEkPok2+VPs3rszS2UBQqwQgCBpFq0kmI4JQwW07u6O7QVvX1kdO0Bixzbm2laDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jbp9mDaGjGTen8BidXf0OT4su1XnPFAKk8A8EBFXEZQ=;
 b=QhZiU9Omm/HPKshIDN1oEaCJOOncBlOFJ8RnBHjd9WOqBkZz5YzZU/q+Yz1q8DBuMWQgHW9E/cf/xEv292eJ8jWSc2wkBZblNpWEAN0SirdcPACuSLlXo6DjefGbCdjKUseKGMhKoaXVhDatL9gp20HLJlqCNgn0mPnBw8NtH37H1Vx7JQjMQMpGLfIDJei9re2Do+o24lf5BpHh+TO/15TOS3mowBYSd8fYENiw+zlGEyOv5bdYnBCcc6lN76TbxcdQh5bxNbgvpkrvrd8YkxGI5dCaLMND0fadEfD24cNc+JlrdGtCAqZPO0dl3qpA8Agg7Bt54iIBZ78pRa7aIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbp9mDaGjGTen8BidXf0OT4su1XnPFAKk8A8EBFXEZQ=;
 b=guIP0KQ4TmzWf43rLjUJur35qyNKWU3WLwlB+eboed7M3u61nZqGX0RWxQquWfDCk84SrDAz9sONm3NdCgcxcquvlum5E3VY+4zD5ZP2LG0e9P3W4ztVQo5eLheT7vLLzXVGnFyPHJqrq09Hph6zpttCAYGo/uMYzalp80sgbh4Ed7PtJC7QUz7eIf1UGp8XTuYIrs/ah/Y9YNUTDSa2PhKMjk4LWZkPVK1uKWkvFE4ZqiWRq9kgqoMN/BhcLJN8W8to3fqG8ViVEXDvugu7rt3fMy2IZCqHqHCKy25m2QYTGhAm/hCf29G5f3ys5JmtMYWdguvTQiGzCIH4mt0wyg==
Received: from AM6PR10CA0050.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::27)
 by DB9PR07MB8497.eurprd07.prod.outlook.com (2603:10a6:10:36e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Thu, 17 Apr
 2025 23:00:44 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:209:80:cafe::f9) by AM6PR10CA0050.outlook.office365.com
 (2603:10a6:209:80::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Thu,
 17 Apr 2025 23:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Thu, 17 Apr 2025 23:00:43 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 0A58220827;
	Fri, 18 Apr 2025 02:00:42 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: dsahern@kernel.org,
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
	horms@kernel.org,
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
Subject: [PATCH v4 net-next 01/15] tcp: reorganize SYN ECN code
Date: Fri, 18 Apr 2025 01:00:15 +0200
Message-Id: <20250417230029.21905-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|DB9PR07MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: acc7685d-b01b-41b2-e3d9-08dd7e03ae90
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MXpVbTZFdG1MS3lOM2RJbmJRNGQzdm1VM0I2NWdLVlZJSU90M0NrdUZzWG9F?=
 =?utf-8?B?ZDdyYW56cVJscWQvRXVra0Zmb2M2N3E2TUluWlAyQytxWUVPTE85M3FiUnpJ?=
 =?utf-8?B?T3RVOVpXSlNUUk0xQW9FaE1hZXA5eEI5VTg4ZGNPalI0ZDd2YVc1aXpaR2t1?=
 =?utf-8?B?aXJYUHd2ZEs2cU93SkRGTU80em1sbU11amE1YVR2YUxPTE5KU2ZxRUtoSGJx?=
 =?utf-8?B?UWcxL1BDR09za2ZrVGZ4YmJkajYxOFc1SEtqNjZKVlB5MVdPMWJ2Q2tyd1Mz?=
 =?utf-8?B?bWtvcEFvT2dpdStXeWx3ZjRRRG1tMUFvNUQxOE41ZDlsQnJnSDVoOStXVDJT?=
 =?utf-8?B?eDJ2Q3R1OHlLYnovaUlwQlNRU1VLUTVibWlaQjdVUWJwQXRDejhzbndrcTM3?=
 =?utf-8?B?Z1o3VzJIbnpnOVA4ai81REpJL1hoYXFOYXN0bkxBSzJEMmg1K0NuR0cwaC8r?=
 =?utf-8?B?V2JwT1RuelU3aXA5SGtVZlZ5c2YzL3NMWWZkd01TNWkvOE9jRTMxUXlnUlNy?=
 =?utf-8?B?M20zT0pncFB2QUFCU2dnZ1h3clA0b0xkYnMwQXNzSjZOdjQyYmdFVWNTazll?=
 =?utf-8?B?NFVPTXFSenhGNFJ6TkFMTXFDT0lRT1ZUMDdpNXVsdVoxZTkwQjRxUzduTitw?=
 =?utf-8?B?RmsyUTdUMjllMXBPdks5T1REQk54MlBJNVczZWFMbEdDSEc2Y1IyV0Rrb1Rt?=
 =?utf-8?B?bndMNktOcFNIaVpSMFQyT09PTWxwRWZmTmZUQUhhbzBQbkV6Qi95SWd5MUFw?=
 =?utf-8?B?UVpUOVI3QUNTYTFtV1I4Tm8xNW9zSHFneWdUTml4d0dxZmJsNG1KcXFZOGF2?=
 =?utf-8?B?Kyt5OElGa1dRUVhaYjlpTURSYVA2S3NLdnNoVEp0T2tQdVQ2ZlZwOTZ0TXhm?=
 =?utf-8?B?LzVTczkvdEdLWU1QVVhTME5VZmp1VWRHSHlSZzE2RWY0akwyOUE0bi9tT01v?=
 =?utf-8?B?Q2tUVWQ1RG9qWW1RbUlDa085Q3dXUUR1Snd2WjlvYkVtRmJPRDdVSmtVZmtx?=
 =?utf-8?B?U09IbElZWWt0T3VJUlhBV0l3NVUrNkpsTnc1elJYSmo4eDY5THVOeEtBQmRN?=
 =?utf-8?B?Y0ZtTzdxQmxPSkd3LzkyTXMyNWtHQ3hZYjV0TjlGNXBxVzVrd0s2Nml5U0VU?=
 =?utf-8?B?M1ZjV0pqVVIzcnpNbzQxWThodktGeDhBQW83Tm1oSGpoeVhNYVJLbEdISnA0?=
 =?utf-8?B?VW1aeFRwMzhXTDRsNEQ3aVNTdFQzR1FBZy9CNHFZQk9NNlU3MkMyN2tpdEVp?=
 =?utf-8?B?NnBjTlFCNFdKRmh6NmtLMFJNeTlLVWdpZkxNdmRWQVh6R0xDMlZ6VjdETGVn?=
 =?utf-8?B?V04vNGZ6c2ZUUmpQOUxqY1p4NkYreGhjTlkvV2FNUm8waUtWeW9xcFNLUmdP?=
 =?utf-8?B?OHRKRDE3bGczVXdCTy9kejk4K0hCckxhYU1oVFNMdTdLMDdJcWlpenVuM1NN?=
 =?utf-8?B?MEIrNnl1ZkI2ODEvOTlnWXNkZlRqUEp1NVN3RS9odFRsVGJFcXd6Mm8yNGxt?=
 =?utf-8?B?WFhSTjB4RGlmcVBQNTJibzQ1NGFSc016TFhMSGpadGJwZzRkbWxMZm0zWFV6?=
 =?utf-8?B?VTNsMWpoR1drQTV4WkFsQ3J0Mk1IdUlyR2R2M3p6U3RTMnozQzVJaFJsOXN1?=
 =?utf-8?B?cGw1YmlnWStLcEM2TTM1ekJ1eEtBSTBWWnB5bHdtT2RzN0lXaWc3c01MQXNF?=
 =?utf-8?B?QktZcG10bmJZY21jVndidlpMa0o1cktrTEcvNHp3TnUvSk1yTFpjdnhNeEhZ?=
 =?utf-8?B?QnZyc2FXTVVtemFlWURQcThXS29jMW1XTVZZWmJlTVgwZHo0d0NFM1A0MlpS?=
 =?utf-8?B?M3Q5M2x5V2dLNUFsWTVMOXNqYW5KeDRxQ2taZlRxYWw4anQ1bjNaSkZjbTZ0?=
 =?utf-8?B?eEtXUG1SU25IU3pNSmxjZitxbUlBODhGcDFLOFAzUWVvMWlnN2crQ3I2eTcx?=
 =?utf-8?B?REtJZVYvUE5tc1RZcTRINzJmMzNQZWR6SGVyOTJxaFMwdWFyTHBRZmF2VHJi?=
 =?utf-8?B?UW9zNWVyaHhYUkllTWszQ3BiTXBuUnNLRExFV0loNFNCWDVFTG53em56N3F2?=
 =?utf-8?B?Z0NQdVZRdVZhM25wQThjU0dnc24xMXdXa3Npdz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:00:43.4742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acc7685d-b01b-41b2-e3d9-08dd7e03ae90
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8497

From: Ilpo Järvinen <ij@kernel.org>

Prepare for AccECN that needs to have access here on IP ECN
field value which is only available after INET_ECN_xmit().

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_output.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 13295a59d22e..9a1ab946ff62 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -350,10 +350,11 @@ static void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 	tp->ecn_flags = 0;
 
 	if (use_ecn) {
-		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
-		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
 			INET_ECN_xmit(sk);
+
+		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
+		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 	}
 }
 
-- 
2.34.1


