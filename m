Return-Path: <linux-kselftest+bounces-30708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4F2A881AC
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72DAA7A2561
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EC223D286;
	Mon, 14 Apr 2025 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="JrWKNQkd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201412E62AF;
	Mon, 14 Apr 2025 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636803; cv=fail; b=Ge182M3VNqxjDlMDMIFrqh5+qS63jjzl4lmBsh7OuNoLJYaFaWoQXx4U/lOBU0lcKXp6tslzvJZ6QHk1H5Advbeb3/isrXOeN+l2gy0QUn3+NGqJFSHeQzWSchQt/tLZRbo6fAxeKGwGM89sngClOF4b/atLnfkEuphnx5KigYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636803; c=relaxed/simple;
	bh=PYyCXUuKVKRWlC5fYTcacULQXbuy70otEK62ZKgXQqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbEdfXm/Arai6GydInZFiZlyvxswWtoGj/I9TYURnMT5HNB6Hee2MtOeIHEk5BlRn0uV4TkeQcegtbMPtvbtmW9/JReSSIMQkdkbybUR8ByLn8dkGv+PAkLm5IqAjXYpm8+FZzBoRBsvzowVVGnirSknfoe8Rp273QE0y7JTLow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=JrWKNQkd; arc=fail smtp.client-ip=40.107.104.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saZT2daRW1V9u2CVwnxUCz1O9eWm/aJ09yFVFzzodjqgrdT1tPGcxst8q8jbOe6hNbUIHAYQrQWekafXouTxLi8akT4lCLdvQv7+hdZJzKB+Mp8X7+TDwiUhoGax5n+fnEVT6NhNK467MPAcvBrWqZlbmQE0Ra1yNwV/ktXKzuGddnofd9e4cBqu5Vv98YqW3hhfcHUk7UUCMdiiGq7Mo2RyqnsEFLmv7eQE1k0IPCPb6yhz+8FLSIRT2RUTrI/gSHjqTzLwwEinwHUgHR4gYLgKNRb9juwKNu58sak6nNbnFbMvJwMFYUE9AvOMmlj8li/76E/7J6/KxsHR96Virg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jbp9mDaGjGTen8BidXf0OT4su1XnPFAKk8A8EBFXEZQ=;
 b=yEFVFKN8ThLo5Ycg8ISHMYLynpxeQ5dnWTIGEd5UTr+3DI68ZGDOg/CdDGWpKv7GYI+hYTlCfS4DByo0NrQamietTDBnJ7fvVT+OrTeLehMiOKGRgX0HGwGyjBFxfsaRGkx8VaxLsVzlOJStA61ZiSythwTodI1mR8NrkfbELumwVFeCNIeABB9A2ojBGh0z1G0OKnpmGBkKIu/NgooMRrMJJbmNKWkXUp0rONDd5lc5suwfDCmyrcarCMk8RgqbxvVtJHCcAOjM80Lk7NBD1Bfe78CnA7N8tNzA1xk78jXLy5Z/at1YzhAoxQ+2fW2OiSUTwhyb84XGb7PKXfOkDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbp9mDaGjGTen8BidXf0OT4su1XnPFAKk8A8EBFXEZQ=;
 b=JrWKNQkdnmjbPXndC8N1DHDCs9qtBRwxNJbenhbREANWbPcGoaPEekuRLHcSee9FCoqGxIXJIBNHRcw7+T+aU5tJmBTruBoh7yde182N/OZd+DOaVcjzZ27T/xJaTdxM4UAElwG7jJYrXcajuC5q46/tNskkiY9Om7zIXfEL9zRMkLqhvasI4SGmEJdENsu4Qs2e+YSgu1oiOy0BgNFBB3RMLbuIYjzFKkbD+gFgTnj6y522duwym9er9ljLgL4+n6JyjJVK/CHOiNgGjQY5/RjMbciaJz4nVjIV2IXo5GNMBGyqMfHmVPTYVI/RAcsBw792+noKfDntEHET8llY1g==
Received: from DU2PR04CA0043.eurprd04.prod.outlook.com (2603:10a6:10:234::18)
 by PAXPR07MB8699.eurprd07.prod.outlook.com (2603:10a6:102:245::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 13:19:53 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:234:cafe::8) by DU2PR04CA0043.outlook.office365.com
 (2603:10a6:10:234::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 13:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12 via
 Frontend Transport; Mon, 14 Apr 2025 13:19:53 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 80A0C4EE4A;
	Mon, 14 Apr 2025 16:00:06 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org,
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
Subject: [PATCH v3 net-next 01/15] tcp: reorganize SYN ECN code
Date: Mon, 14 Apr 2025 14:59:30 +0200
Message-Id: <20250414125944.97350-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414125944.97350-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414125944.97350-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E2:EE_|PAXPR07MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fbbe64b-cb65-44cd-1f71-08dd7b570b19
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bUxESDdNZXRNYU16WENIYjlDUExpdytKSldqNHJNQkl6SUhhWDl1bWZvaDVz?=
 =?utf-8?B?K2l3MlJ3UjczbCtyWXFFTDNtT3prOXJ1Mkc0ZjJuWGxJTFNjbnorbVNSZnBB?=
 =?utf-8?B?dXdTTTljd2ZGVUY0OVoxZzd6bG9PNFhETFhwemM0d3NxZVlKNVpjZkI5ekpM?=
 =?utf-8?B?b0QyTldwNk5BZ3dsUlBLeDlzY2RhaHQwRUJzb1pqVFBnS2RFT2RWZVZKTEN4?=
 =?utf-8?B?eW1UWFhaemZ3T2dmQk43dHVnM2J4QlNlMS9ncUlJVUl3bGJTRlUwbWdCeDhK?=
 =?utf-8?B?bkVRK1ZhTjBoOVpBQVBDcC9ERUlCNUp0ZnlreGFZTmJRbGk0eTJqQy9RZ0FM?=
 =?utf-8?B?WDJnSVZKbHJwUTZOTyt6citEMFlqa0hxbTlwbEhIWmxIS3d2TnltYU9vMWd1?=
 =?utf-8?B?VGpFRVU3S3J4QmpuUHNOdk9pbkl1WVlJQW1Id2hGTllTZCtOQmJIRU04czZO?=
 =?utf-8?B?SXJKdVc3VGFyT0dVclptd1VwbERkcHJQYmh1dEhBa0NCWkpRV0JTdUxQb0ZC?=
 =?utf-8?B?bDFzYTNlWjlERThGeEMzdHBpMEQ3TWtDb2c5OUdZTUkxOHhmQ1NjOVcySW1X?=
 =?utf-8?B?TGJBM0VSZU9Ed2d5SjdYM0JqZlBQcDZJQnhjOU41MnQ5djZnaFFuOE9uV2c5?=
 =?utf-8?B?SVVnQ3JmZkIvczF1ZDJvYjMyYUR2SVk5ZzZWN2VSdDJ1aThscFJHYTRaY0VO?=
 =?utf-8?B?L1dQZk50U1UzeGMzbWdiYjIrRTBpOVRsWWdLVnhMQzQ0eXpwVW1lMHdOM0NJ?=
 =?utf-8?B?WUs5OHA0aWdjeGI3ejJCWWtTWU5rZzF1TVdaMk13R0Y2OVB4RG9RL2NxKys5?=
 =?utf-8?B?ZWtFWDVVUG9OemkxQXZwZXBySFUwY2loV3BsZTZqaVFWWld5Ymx0dmIzQzAz?=
 =?utf-8?B?dDdVUENrbGgzeW5MWnZHNUlhRHMrVng4U3Y3Z0VZWjhsa0h6ejU3cHdDMzM5?=
 =?utf-8?B?UTB2WmlPbEZzTXNTV3BtN0R0VW8rNVE1TkZIUzhFSnlLVWNnOGpVV3FXZGw4?=
 =?utf-8?B?SUVpQlNaSXYzaGVkRFk5Y1dDRmZ6QS9pZXdETlFNeFh2d1F5cHkyNzlQSHBu?=
 =?utf-8?B?Znh4dytsYWlDYTdqOVlmM0F0QkMzNXhFQ1ZjdUM5SW1GUTNKcDNLRU50eUsv?=
 =?utf-8?B?b0VHUG5DQXYvMGsyQXV5cUtMUHpuRkkvNEtEaE5IMGRhTHptdmZzaDNZWGda?=
 =?utf-8?B?MWpyQXlYL09PbkhmalZtM3lEVGo1Nzh5ZFZsdW5VLzk2U0kvRnpnUVZ0VG4v?=
 =?utf-8?B?Q2x3OXJBRjdwU0NCNC9LV1FLN2FIZTBZU3NlRCtuZDZjdkVrTUZWMGVjdWtZ?=
 =?utf-8?B?K3lGbDVlK09YUmpLUDhTcWJ4SlAxTC91NHFJV0FSTlhnMDMrR0JsQmJOMVV5?=
 =?utf-8?B?VG5FR1VZeGsxRC9EVUVNb2pSN3YxcjVRT2JwdDJJWW90ZjFxbm9rTXJUWWRY?=
 =?utf-8?B?aGpjMjltbWVNN3ZwdEM2c0NQakVoNkk1ei9nUFlXaGdoUi9ENE05MW9aR1h4?=
 =?utf-8?B?dy9ZRmI3cEJxWDR4TFhtMEdZL2VuZFlRUFFDVTVIQlZRbTlGYjBLYmtBNjBj?=
 =?utf-8?B?bEhCU1ZqT2hmaXVPUFpoOUMyb2p1Zk13MGozM1FJdHgwOXI3RlZZNmpscEJP?=
 =?utf-8?B?TWtQMldESURaWkxNcGpjRm1EbXpuTjdqOGtEVnJpZVE0THRKL3BPdUFlNEN6?=
 =?utf-8?B?d2JicVlXdVE5TEE1Slg4Zzgzc0tOMDl5ckNOK0JhdU9vTzkyNnZnSFdXNDZz?=
 =?utf-8?B?Zk16ZmdIeVJqSDJaY2dzMHRWaWhsdXdVVTFBTXNLZzFnaVcwZndpbWR6L1BT?=
 =?utf-8?B?YXBPeWdPWm9GTXBoRGE2VjZ4TmkzRE40dGVwc0k1RjhYQUV0R09vVDlqMjFF?=
 =?utf-8?B?V1ZJLzBUak1ibTBsQ28rUEhOVE1VYVdEZExFdHJtMU0vaC9KbzlZMEhwZ3dQ?=
 =?utf-8?B?cDlqMGdzWXdvalhFNEYwc1BEcmdIME1mclR4NDY1TVhzYWNoV2FCYitwblRD?=
 =?utf-8?B?S0w1ckNTQjVtdEdjRVJuaUl3YmJHcXVHWFpTbm1RTzV5R0RWVWt5THN3dE5v?=
 =?utf-8?B?OEJEOVlpc1JBU3FoSUZRSzB4aEpXM2QwNmtMdz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:19:53.3482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbbe64b-cb65-44cd-1f71-08dd7b570b19
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8699

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


