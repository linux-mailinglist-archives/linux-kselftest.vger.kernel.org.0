Return-Path: <linux-kselftest+bounces-45614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79840C5BB79
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E4FD359FD4
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 07:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF842F5A0A;
	Fri, 14 Nov 2025 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="lxo/Oa4k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C8E2F5483;
	Fri, 14 Nov 2025 07:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104443; cv=fail; b=J/6b5fTrODZC6bnr9zW15NnKcXRJixhSVsv4wxhjX0gQ48R1O+OHBWa43YesifjSUZL4N6BMv+oJjezn8HlS5lJsfw5Y0h0Lr13/Ces+bOgv3u3mIoGhge9y0o7nnQdIjg79MWRYzXhrn3dwpgYUKO54aQU84q0XNIT1UpJsAEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104443; c=relaxed/simple;
	bh=URyf41vxHRFvXQLYT6pOvecFoPkUnLMw26dmWBEXCOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cacvajIWig697k6HS9xnpnHeJ65VLo3qOWGBssAJHGgcc6p3+LbdsT3Dz5d7+Yyh5DbfOSwaT45zvRAHEoMt19f/zFGzjuytE75jsyNGDkC7aDkQ7jg+nBS4Kb1vDK/eCIwVdYUrmA8RQO2ZcjHus0LJcpuSvdDgGelU2AKbonU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=lxo/Oa4k; arc=fail smtp.client-ip=40.107.159.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKNcXqI+V7skg7PGqknrzrtyFEB1TXVv0kuXETXEwwOyobuVQxfZ3/eCFwJKUYtG1YiXViLnc3uGc6YjWCBWfO93wBdVNGg1w1GFp3VM+rDHjg8r69TQa2ciaROt7XjXvamRPW3Kvcr2steOg4AjBe8DQmem0tw9BVVkzptjKTdQewXMinAxsYyoSRcbnawJDBbVz1TABSRDora7sTYwVHj/YmUT1+W00V0R+ycsX8jElg4IxcE8CFrpn7VMOBnEkPoKXoUjHx7EebCcuK8d6O85sAyu7tlNt/hy4Wxl7GfoFjJzNfZXqCqQw8Nz6QENLYNhiiqsQFG9vyV86buAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMXHfdRl4wARcD7p+kvUv4AXmzx5hpwOMrKl+WHgWZM=;
 b=IsbYYB3VKUjhsNfo0czLaUDRnQP7RbbMSK6ct6stJlpNeKCwwEYu7MjcQBi1TwDCiYe2Me4my2rQ3SWYz2TWBBlFYZVx4TgjDsPIeqrQr/ZEEzgLFOTGo/t6j6HVVzwv26dBM+TiLZXy8coQdEAVVrqnEjTPxLO55hmmtzLGJg5FCecPT783JWv9gnnT4xdnMsJfFvQcGSb6iX4Bz/bfwtgWgMECql/CCzbmhjw2MaviocE+7ztkSE9FFaUhS6v+OeHLvXPkI0tG8GGW0zfAH7I5/4IJxAYNLts3zJwquoGZraWwQ9nyJ4cuK9qJ01wTC4AXKrWFac/3PfFiMUZuYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMXHfdRl4wARcD7p+kvUv4AXmzx5hpwOMrKl+WHgWZM=;
 b=lxo/Oa4k5jMJvdAfffyto6/4fwOshXzW2n04G3c4OiEQXPbR8Dornz2RnbOQjK4JeGEsaTIzKzpqG9wMzA6uaggvm83GbdS8rkGpWbm49skkTubdKjVpWo+IYh39WaiBn8/s666bgxXB1EtQvEPy410BkPXw4+GvNnmzFPE4Wcbv9MChlrksfufvWYIYpkLsr+1x+hTqIEBSZbxMFmW7++2T0Xf/0xh0m7SAx+p9pyz6h4z0/LS1LbJ7XmujqfjhLAE91nxs4iQSS5hcsH3RO1lJEJEuOzPoy1a7pU1/TGSoShvDxoGJCQcPk3qeSLdjrIc7sGAnKzqbxtIFxfvK9w==
Received: from AS4P195CA0025.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::20)
 by AM8PR07MB8060.eurprd07.prod.outlook.com (2603:10a6:20b:3db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 07:13:55 +0000
Received: from AM2PEPF0001C715.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::41) by AS4P195CA0025.outlook.office365.com
 (2603:10a6:20b:5d6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 07:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM2PEPF0001C715.mail.protection.outlook.com (10.167.16.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.13
 via Frontend Transport; Fri, 14 Nov 2025 07:13:55 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 996361C0037;
	Fri, 14 Nov 2025 09:13:53 +0200 (EET)
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
Subject: [PATCH v6 net-next 02/14] gro: flushing when CWR is set negatively affects AccECN
Date: Fri, 14 Nov 2025 08:13:33 +0100
Message-Id: <20251114071345.10769-3-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C715:EE_|AM8PR07MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 827b08db-49a6-4cbd-19d5-08de234d5f63
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Z3RtUkJxczFaaXplZFR3d3R1UDh6azFzTzJnZHd5NmczTm9VWlZQdHZTRGRY?=
 =?utf-8?B?bHU5VjFUMWdEMmJZNVpnUm5Dd25yaUc0WGNmdlJpUmRCblRaMnlQeE9zN2NQ?=
 =?utf-8?B?WjVxU1ArTlU5ZUZ4RWZ5a1cxMy96NE5BTXZpclVmclVhNEFLZzdYL0I4ck9m?=
 =?utf-8?B?eW8yMGVhbHROUkMrdi9jVXVhYVRCZ0dlRTBSVmJFS0JlbGNEWnoyWnBmYjdz?=
 =?utf-8?B?WGJQTUYxdXRyNFcycGFaZXFMWHZsdW5hMUF0Nm84QUlGTHhCeVpHby9uNmdj?=
 =?utf-8?B?WGZTWUxJaHdyOUNodWVHUEsvTlBtUlUxRFBZalhEMnBYMVkrNjBPbWwzRTJQ?=
 =?utf-8?B?N29EdEhmV2dsaHFzd0IvYXJNNzlqeFVIR1dBb0tCSERsTmZIWXBNZTBsTmFZ?=
 =?utf-8?B?WGU1ZmFhSWEvTTN4Qktkbkhxd3l2RVV0K1IwbkZFU2NnbU9OajRrZ09BeEdy?=
 =?utf-8?B?NlFuSExtc3l4azVFRCtKV3p5ZGg4TGR5TnRSRVRjUDB5dzlZVTFlTFZITDdn?=
 =?utf-8?B?dnNJTW5RTXN0SjRlRndxR05UVlUydlBxeU5KZmU2VStBK0wyVFUycitwaisx?=
 =?utf-8?B?SzlvVHdUaXpscE5rc09IMGFjT1U1OVdDUnd0WWtLTXRsWjVhRnBBOCs4K0cz?=
 =?utf-8?B?MGh1VGN2R0oyeWlFWjQzbFdhejBxQjZERm15SUFVNllObFJHZ1lQaDhYTGMx?=
 =?utf-8?B?ODg1NGp3RkVMOEswL1h1aEg5cHBqM0lOOFpPRHV4Q1lJcVFYcTIzb2VkTXp2?=
 =?utf-8?B?bFJoNVFvUGNwdjR5NmJ3WjM2UVBleHFLUG5wR05jZmg0K29WRExOL01yQWEx?=
 =?utf-8?B?OGtZNVlaU2pGWnB5Rzg0MFlEMWFHb3k2L0I3QzJIZ0lWRmZYTjI1UjVtai84?=
 =?utf-8?B?R3J4aXVrL0Z1bmg3N3IzY0w5VmNFS1RxRjd4eEY4bVlrUm82UEFGQko3RXk0?=
 =?utf-8?B?NXN6bW1wT0NDNUdZaXNJUHJuYnk0ZmNCYlVVMWp5WVB0dHVZeHp2c2FRNit3?=
 =?utf-8?B?dmE1NnRlajhDQUVpOHFOSmVaSVlKUzBOMXlPTVBha3hEOVcrZE45cGlnSkEy?=
 =?utf-8?B?VVBhVGZhZEcvLzNGNkc4YUtGMWFJLzROMktuMWNWSXZndWduMHUxMThveHVX?=
 =?utf-8?B?THZIZTV2cGZzcjdPVVNXeGd3eTMyRENrcnhYSldxU1c2dTJoMG54Nk9TN0tE?=
 =?utf-8?B?b2p3bVhaSzdPUThCKythQ2RpeFFzaUR6Qkw3aUZaeW1VY0xnUUVJRkNZcUlX?=
 =?utf-8?B?TmNtd1phM2pkZXk4U3BIcWR1QWNsRTJQTmk4dTdmWDBvTWRCN3lMbzl6V2tL?=
 =?utf-8?B?RXNWNnErR3lXSzdkV21tZ2IvYzVRVldzU2RxU3dhUGRBbnFFaE5ld0cwZWtJ?=
 =?utf-8?B?YkRpSnNGVE1Gc2hwRmoyWWNqaEJ2VE5OWWVwdHFNd3h5dDV6YmphRFB4aTRK?=
 =?utf-8?B?VDZhT1RTTExWZHBXWEZIWHZMSjUwM0hZQVJWMGxhR2dwVzlHaHJ0elV4eTRO?=
 =?utf-8?B?QUZwNjJPb1o5TXgwaXZWUFMyUnU5K0pEQ0hFRytscTg0YzlmTVZ3Rm0yNCs3?=
 =?utf-8?B?d3JkampUVGxsaVoyK2VCTm9BUnNPeU9wNjJqNXREd3Ewb0RFMXJ3TWtwd2FX?=
 =?utf-8?B?ZTFoZXdLaThMKzIwdkhJazNLYnpEbElTZ2gvSVNZUG1xVldGQ3dlNHBZOHRI?=
 =?utf-8?B?TWlTUU0xcHQzeEoyUWdRT0FXcVhMdVZ5bFZ0ZWJhVUJ2RmpSWVdEM0pJVko4?=
 =?utf-8?B?VFpTRzd5eDZxNXoyb0NWMVdWMVBJQldMNkpNbzFpN09hRDdVUVprUCtYd3Nq?=
 =?utf-8?B?WVRZZCtLdWR6VXBXTHhMNWkvZjVsdjZpOHEvRWxNUDUwSFpHWDdMeFV5NmE0?=
 =?utf-8?B?TDNGVkxXSFZwU24yQjVQcEFxRkVsYlVzS3JWTGUveU5mUXNCSXdrQXFZK0lU?=
 =?utf-8?B?RkMzWGc4aVdxZk1nSVd2MHB2ZXdiODZXQ3lBdlFQRGdsL2FKUWdSUTd0Yllz?=
 =?utf-8?B?ZzVNcEFYOVdmSXMzK2F1VjFnRDBoYmhpUXpDV20xMnZaYUt2dlJTMUI2YmRo?=
 =?utf-8?B?WUdnNDAxYkdMb1laWlFQTE9ZNkhIczliNWJHNEVtN0tqTWhzTVVLT1RoUTJs?=
 =?utf-8?Q?D8xINzxFa4hGAKfzb3y8d2WSv?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:13:55.2141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 827b08db-49a6-4cbd-19d5-08de234d5f63
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8060

From: Ilpo Järvinen <ij@kernel.org>

As AccECN may keep CWR bit asserted due to different
interpretation of the bit, flushing with GRO because of
CWR may effectively disable GRO until AccECN counter
field changes such that CWR-bit becomes 0.

There is no harm done from not immediately forwarding the
CWR'ed segment with RFC3168 ECN.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_offload.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 2cb93da93abc..fcbf4148919c 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -330,8 +330,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 		goto out_check_final;
 
 	th2 = tcp_hdr(p);
-	flush = (__force int)(flags & TCP_FLAG_CWR);
-	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
+	flush = (__force int)((flags ^ tcp_flag_word(th2)) &
 		  ~(TCP_FLAG_FIN | TCP_FLAG_PSH));
 	flush |= (__force int)(th->ack_seq ^ th2->ack_seq);
 	for (i = sizeof(*th); i < thlen; i += 4)
-- 
2.34.1


