Return-Path: <linux-kselftest+bounces-41582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A58B5906F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 10:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7032A7D3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 08:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C048028C860;
	Tue, 16 Sep 2025 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="jdjka7PW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011022.outbound.protection.outlook.com [52.101.65.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1008928C014;
	Tue, 16 Sep 2025 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011125; cv=fail; b=CA39gA5WGzvTjKPvgJr0lZRj1pjZU50M/7gz1OyLRzeNGAMRhlUtbhBC18qdNSTG8zV1UJopP9jYbhUZ5QFQuJqw3Ll/pI5ZJ9IDbnvU5JfnWFm+OfLjSlOxK/lvwAB39mYQtdgk+ESnXSghXppj6+tE1RYWgjn+iSGPbEyC0XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011125; c=relaxed/simple;
	bh=C/dhWSWt+O3PZtD/17zVGFH5w/aYQMeOKKd7dgXZz4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWaUB2JLxjtz8rwVQurx9n3YH5mG4FldgDgt03VnuMRbYzdagzr+LD3QDy7JfuHhzKtqfH0d5FPnWDwHO3N90AZI7EmtiEKbMY1OmwJizGf4t8d10ZKioXV/ju5JZB5p63aCHQfFkNEpDFI6fElgq3qPeGKz5XxIuDifYTM9DXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=jdjka7PW; arc=fail smtp.client-ip=52.101.65.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRnigVmP0ZWP8GG7BZEnUOaefHQGNOojgP7PDg48Qp7LBYsTx8OzwybP2Y8e0l1IFXxZGs5nZ+1UnToEGKDzM77fF02ZhQmIQk2Ov92EXu4Pi31pI1FBH/RW6/Y2biRPtA1V+CUKY+pbY/VHSeCPxSnV1LBye44/zRAr52GG2G6kkN5aHMs2/yJtjE/IYkKs9BsSleI1RtIKSjuMt3eYaP9ajINvfPTsfjKfKZu+G8Zqv/Wo1WF8Lu6W7xrDwC2XIeRgjdUOW2zJHX2MN8HXJLpRn2fXPwP5wuhtW9BkUg+xdtCKoSGJLO7/zzz90oFZYZ0EDpdqm1lIk2uK+iBNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ta9CTQXzfsJln+e8CsRqChrLbcfgUPSfklUNiwzkFSU=;
 b=rHi7npVWMO306iz3MuF4UT33sht3CfqnEQfDSxtIFeZaBC1wJUWpj+pDqV+qkH8YDp33eTQmFXvPtRL0T3adZMIUgjG+hHk3KcsI6sJZQALhEnxT/Cw8rLDnp/KXMRPItzSnLlsMF09Pg/0qGeVfW2ooEaI01167w7wgwprt/Whbh6uJDJL2cm/bff/K/S1yg79gAqCm3bvwM1fkgs8svyf/bmUJbC0hdIAWBwzSrIEuydk+Jt0biYYUd1On9Xbk6OD0Jho0LxvcezBmhY+mRTH/oKmxmNgAGiVHrmCy2LFnVYrCA5kTFF2yCJ2QwQxaGHFfADWXRvHHH0NTeNSf2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta9CTQXzfsJln+e8CsRqChrLbcfgUPSfklUNiwzkFSU=;
 b=jdjka7PWYOXoWxRJe5VD9SMxZHaVxbNrWR4dkeEdVSi2azBrqInoU7xynRe8ItpyOwi5S/f1JDlIcJu6f554nniGvmozhAYhQW+Xe1iX+TRQaD/FAZxYBH2A9cCY13KiRmhusxJdEA4uZwwU635XO3DyE73WE2KDr8N3B10GWyyxlZCc2KVTCPlIok3Re/q/MbxMJzLINQZewpg+QJ07+iThLpy8lSaLf7O/gkEbwZ8qniLwnJONKUlum6N8rAN1EPc8CzgJV48gf1XCwUaYHVoqcYxxpOX6DhGNfVidZXLDRfq1HDZq/OV1ZjE4nqa8NoqQg40DGKD8E/208y4Iww==
Received: from DB9PR01CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::16) by AM0PR07MB6401.eurprd07.prod.outlook.com
 (2603:10a6:20b:157::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 08:25:20 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::29) by DB9PR01CA0011.outlook.office365.com
 (2603:10a6:10:1d8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 08:25:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via
 Frontend Transport; Tue, 16 Sep 2025 08:25:20 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 40AEA205F1;
	Tue, 16 Sep 2025 11:25:19 +0300 (EEST)
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
Subject: [PATCH v19 net-next 05/10] tcp: sack option handling improvements
Date: Tue, 16 Sep 2025 10:24:29 +0200
Message-Id: <20250916082434.100722-6-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DD:EE_|AM0PR07MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba28495-46d7-4172-c475-08ddf4fa935f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnBvemxnSG1wQ0U1NnNDaEhJTlFLZmNvYkFXUkZQYkZwYnlSRERWSVM0MTN0?=
 =?utf-8?B?bmFSQkhWYitxZzN6b21oeGtYTVBOaWRjQWRabnBYbzVUUzZMUWkxUUlDaFBQ?=
 =?utf-8?B?cWZoNmVGYXFtSVVkd3Mvdy9iNnI0di94cCtTSTREbTNMSjBBaWFXT1dtNmJZ?=
 =?utf-8?B?ZEpsR1QrNzZuNEkzejdCdFNjK2VXcDc5L0J4eXVhYVhZaHNwc3pPcDk4ZDFE?=
 =?utf-8?B?Tng1WVpkMGtnZWxxeTlqUHJnNkVjUXo4UGxUakUvWWZvcUVRVWtEK2V4VHFO?=
 =?utf-8?B?OGQwVEVZcWcwMS9TWXUzWk42YUMwakdJSVdWT0JZbEJNNWJxVlhFZUZHS0tD?=
 =?utf-8?B?UWhwQktEZXJOSi85NDNKUUhmdG1kUFlHSktMNnU1MnMxN1BQM2VJcmJJdTBw?=
 =?utf-8?B?Mjhkcm16cVM5NWI5UUlxaVlXMi9FR084Y213d3IxTjZjR2ZuQ2F5Zk9vcUJQ?=
 =?utf-8?B?SG54aHZ1UUVNY0dBNnlXeUpPNGRJbjRhdmNYVk1SUDBRZGpoeFMwY0RsOWJG?=
 =?utf-8?B?bHJGU0N5VlZXV1BjQzd2dHBHRTFOVDI0UnZ2RlZ2Z1JrN1locm94VDZkSkhl?=
 =?utf-8?B?aXZwakVHV04zWklYTTk1bzVtOTRvb1I5WWVnMUpHSUl1b1dUMkNrbWgxK3FZ?=
 =?utf-8?B?K2hocUpaZ0xtNjZIUVg4bGZXZ3ljVy9lMzZscG5HR253c1JLNFZMM1RRYWNQ?=
 =?utf-8?B?WXhoa3lXSjFvMDk2NEVhazNKUHhVNVh6Rk8va0dDNEc2NUtsTFlXV2JDNjVz?=
 =?utf-8?B?ajZTZ2hOcEsrN0JjUHRWS0NKb3MvVll0azJCUjBWTzNBUExkUnJBZVQwT215?=
 =?utf-8?B?UXQ1eWE1Q0Y1UXVlTHE3ZUFNMTB3TlpOL2tyaE13Y3QwZ2ovK2FOVWVLSDc5?=
 =?utf-8?B?Q1dxNlBHSmN0YklQR01oVU1zQlNibGpsTjc2aWYvRW14RUdhQUpQTldtZUVz?=
 =?utf-8?B?ZGZGVzBuSmZTS0NMdVJmMnczd21qdHU4QStVZHI0ZE5Od1BBOWdreHdmVFF4?=
 =?utf-8?B?SU1yOEVQYnZvTmlKRW42SGJwOTRDVi9HN2cwVEcyMzF6Qi96YUt0ME84Vmp6?=
 =?utf-8?B?enhQNzh0bzJTNVkyb1VadTRNbUNjKy93WnQzRDZwSUFlYzc2ODZzUStvNEF0?=
 =?utf-8?B?amo4UVhPNitNSHJPNnhzY1lidGF0eTlOOTVlRTFQK01KMzUxRzlyck0wMG9J?=
 =?utf-8?B?S0QvTFpYR3QxR1Y3VGUzaGRzeHVORC95UkpHR3p1ak4xajVReXo2R3J5UktZ?=
 =?utf-8?B?a2JBd2lZYzNmM04vcE1JSjNnNkM2N3M2ZG5Wc05sQ2pvZDFIQ014bFBYSmJy?=
 =?utf-8?B?Z1o1QzN0aE9FNkNoK2htNGdrRWVQM3RMT1lkZkFCYUJZaGpnVVlacXM5MHNx?=
 =?utf-8?B?eGhjL2x4SmJUcCtuUFJQYU9NdDIwRE5jNkY5ZmxTMmg2N3VOamh5SGFPcWt1?=
 =?utf-8?B?S0VaVkZkSkNjRldNSEgxOUMxSmVBcCtjS2RoemFaeXIxcXIwSGd4cUpDUlFD?=
 =?utf-8?B?Z0RjSy93Z1FFMVAxaENQdjZzYU91UW5QV3JYWFVyMUw2NGdVLzc3ZFRQYXhv?=
 =?utf-8?B?emdLQkkvd3hKS0lXMmlEUkdPUE9xUHIzNjY1anRRUXNzOFhhcC82ZDhmZTZm?=
 =?utf-8?B?ZGZPUXlya1JUV3BtcW1GYndweGNwOWRXVU5GUmNCTXJYZnZ5SVgwK1JUaGpm?=
 =?utf-8?B?ODVsaDRoT1Y5dlpXbElTV3UzTGpLbXVVRVkwWE1teFhHN2dFK3gwZStrdExy?=
 =?utf-8?B?TTNWRSt0bkJCSURJVXRUUHdXNmszcWlYVnlkSnlMZjBMWWZCUDN0dzFTRnU5?=
 =?utf-8?B?djZXS1c5aVduakhTOGtSZzBmNjZEbDFzaHUwbWFhZHFkUXRoNHJTM1FXSVg0?=
 =?utf-8?B?WEpRbm1DdGN3TXMxWXBkelcwR3l6RDlrc3VlWW1DaDdEN294ZjhJbUY1VHVa?=
 =?utf-8?B?NThYWGlZWVM0bldFVXBMWmMrVUU4YXdFZTJwNGF6Uk5lK1ZGUlAyQVNpbHVT?=
 =?utf-8?B?eVdBMWxFMzM4OXFXSFN1clJXL3F6amU3cEUvaU5LMm55TnozV0xtOTJkTllE?=
 =?utf-8?B?WWFqWEZmMnJqVDlacFZJQ0NDcm1iV3RqalVsUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 08:25:20.7209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba28495-46d7-4172-c475-08ddf4fa935f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6401

From: Ilpo Järvinen <ij@kernel.org>

1) Don't early return when sack doesn't fit. AccECN code will be
   placed after this fragment so no early returns please.

2) Make sure opts->num_sack_blocks is not left undefined. E.g.,
   tcp_current_mss() does not memset its opts struct to zero.
   AccECN code checks if SACK option is present and may even
   alter it to make room for AccECN option when many SACK blocks
   are present. Thus, num_sack_blocks needs to be always valid.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v8:
- Set opts->num_sack_blocks=0 to avoid potential undefined value
---
 net/ipv4/tcp_output.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index deb9b085a8a2..5be2b3eb73d3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -985,17 +985,20 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	eff_sacks = tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
 		const unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
-		if (unlikely(remaining < TCPOLEN_SACK_BASE_ALIGNED +
-					 TCPOLEN_SACK_PERBLOCK))
-			return size;
-
-		opts->num_sack_blocks =
-			min_t(unsigned int, eff_sacks,
-			      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
-			      TCPOLEN_SACK_PERBLOCK);
-
-		size += TCPOLEN_SACK_BASE_ALIGNED +
-			opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+		if (likely(remaining >= TCPOLEN_SACK_BASE_ALIGNED +
+					TCPOLEN_SACK_PERBLOCK)) {
+			opts->num_sack_blocks =
+				min_t(unsigned int, eff_sacks,
+				      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
+				      TCPOLEN_SACK_PERBLOCK);
+
+			size += TCPOLEN_SACK_BASE_ALIGNED +
+				opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+		} else {
+			opts->num_sack_blocks = 0;
+		}
+	} else {
+		opts->num_sack_blocks = 0;
 	}
 
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
-- 
2.34.1


