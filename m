Return-Path: <linux-kselftest+bounces-48106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA950CEFF66
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 14:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91F02301AE34
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 13:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35DE30BB89;
	Sat,  3 Jan 2026 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="R2Qe7Iz6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158D71917FB;
	Sat,  3 Jan 2026 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445842; cv=fail; b=is4ipgv41Z4Aln8nXNC495Gc0TMMYcfFGT1Fl7yrRr6IcH34yJzF5oig+wJZPyJczppj69J7LXfwq5giOH0ZUkjvQ/aGse2LeSjjmBNYIYCAYkZ25fsfAiR/WoIUurY06KNKvSzbx/NW+69pF4or9qdQFA64zlMf+/ZKa9otNX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445842; c=relaxed/simple;
	bh=Q49lg1ygR5li/7gImh7zFQzfI3h2ISG+4HsdDeihcTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwf2Jwf5p0kh9rAc0zrD1a/KrZY7Whk29exPMWWxwVM27L8NDFtURNdSLQa1/XpXyne7QRSWf7OmQnxXZbJ+CRiZsdl7uaSsNShLrkV+twMflzyXhL/12OdWBgqQNm9d+/6q20Onxhk0yfvjYQIlizkcnXR+wUNfpT/JOF+pjS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=R2Qe7Iz6; arc=fail smtp.client-ip=52.101.69.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLBq0+Kxb60UFv/bc6/K4bRh5ruZL0SH6/bxDbjfbWrAQ7W2+7eNCfXM/lvrpAvIFZalSzWCJVI3CM/iggXdf85EkE6vuejvJ7CXeobCgqQhUwL4PMPNy0dyxn6xL6LGSdSDdYmJZj+Yb7pCJ3mV711rbYFAJ0F87amlAp0uUEiobJuZ7l52huvNhmNnW5rTsRufZZ9lkc0N39Xz4N5E3n2ZwPYi+pwBQQAHleDWLGpUCG8vJPVa9M8eVU9nK1+gRPOaoOM2dEXLHdKnE/mkO2QnD9GAfOrDHeeDbxwt4ODkwel+UUvsArzJ6rZin9Ly7k6lq//0PB2fnYu37cFvCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kuB7eRxeMGDNwXVB8pJvlHLKjUPv3X1qilnfBJ6Mdw=;
 b=pLEyqTpcUDaCi61cO0+Txnn+f9nMCM67L9jRHi/1E8voj2eLADUG9FmFwWKO3/nACwkwXhft9nJgR6cLM/Ul5DqUGrvMyi5Lv6ggIPuZNJjpTTld3p2NjrMuWGvlAPZHTJLBeNBvbacIZsyufkBrguWsrJuX3otGiv5VK14ii9VcrPN/zzAuqP4Ur80krSg+4HcH+zChw+0gCDrhRGZd+236AQiNvZt9V51vvZwOfX0J8uqs32xyr0XajI25bYSdLFzKV/+fV/S8kNfmIEn0j/N6FNaHQ7QN1se8X2ZiJXXg/+O7ypERheG5sCZo76pCs2VKWRQl5hULw+msgjOITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kuB7eRxeMGDNwXVB8pJvlHLKjUPv3X1qilnfBJ6Mdw=;
 b=R2Qe7Iz67Z2uQBG0Bt3WqYHlttyD4fRcJvidyO6XhIShLzKZ7GNSpHVeHyhFa5cNnqFIwlZOPZTibEzLKgbumnG/H5z6xdQbuOkTYh6Kws0UEuK8O3rnEO1TNA6959xb27Gdji+5fqvEi8K79RZKNLOgxGYAqGee2gXQiARiPPiG9uL68RfVNsb+Q39FaQJDeF1anBUeRoqr7/mgTFV/OWoLtoHpOImtZI4HtrOLx+72O8RWmZhgCl4+KX5V0mXA3zKSQvKhU0w0RAa8PbCXr6eshaUqoN/yzja0TG5kUyZwO6q8VwLxyqMZPJ64uhcxpdkGg3cqx6csqvBooyELZA==
Received: from DUZPR01CA0280.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::26) by AM9PR07MB7170.eurprd07.prod.outlook.com
 (2603:10a6:20b:2ca::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 13:10:37 +0000
Received: from DU6PEPF00009527.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::c3) by DUZPR01CA0280.outlook.office365.com
 (2603:10a6:10:4b9::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sat, 3
 Jan 2026 13:10:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU6PEPF00009527.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via
 Frontend Transport; Sat, 3 Jan 2026 13:10:37 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 5EF0E1C0030;
	Sat,  3 Jan 2026 15:10:35 +0200 (EET)
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
Subject: [PATCH v7 net-next 02/13] gro: flushing when CWR is set negatively affects AccECN
Date: Sat,  3 Jan 2026 14:10:17 +0100
Message-Id: <20260103131028.10708-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009527:EE_|AM9PR07MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: fe9904db-c6b4-45ca-a265-08de4ac97c84
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WXpxNEEwTzB4YzZaeWljOUlnV1BzZ3ZTdW5jUFhrUGFMVS9NZDlmTFplT3ZT?=
 =?utf-8?B?b3BGa2wvWkVDYmZXbC9XT2ZRNnRUbk1HMWo3NEV0eFkvUHVCNzhMWWNZUWhH?=
 =?utf-8?B?dG10aCtrdWR6bHdRQmlvbzJiVjFnM0laaVVFYkVWZE1oSFJhVmQ0ditVK1Vq?=
 =?utf-8?B?eXNOOTFSYm5DR2lKUkJ3TFNLbG5ubGx6Q0txWmpFa2d5MkVhaW8xY05jbXhl?=
 =?utf-8?B?YmxRZ2JkSzNJKzNJblFYYk80OHphemd2SEJML1paL1NWTkhPdmpLK200Ylh5?=
 =?utf-8?B?SDRweDRZQ29Kb3UrUTA0RUczNXF6SXFpU1lkMGhOK3A3Nm9iekdTR2V3ZnNa?=
 =?utf-8?B?a3NpYjV2NUp2QVJOK1Rqd1ZCall3NXVkMGNvRDZITGRQRnMxUnd1T3c4MnFP?=
 =?utf-8?B?bS93emtRQWFtRll3TDhFeTdyelMvSHFwZUgvWWtrQjRmcDZXdmVPcmp6SzNF?=
 =?utf-8?B?N1VmWHZuSXpST0w5L0xyblpFY1NFS2Naa2g0SDdTdmE3UFVuWk9oMmlJOWNB?=
 =?utf-8?B?bVVWN3NCUUszemhJWHhGdURxMEpmbE41MUJCTTVZWkZ4RFhJRE1ya1RxQjlz?=
 =?utf-8?B?SEkyZTF6WGxveGJOalNsM3VtU0lGYUNYYVYzMXFmeGRHRDhsUk5IdWFaeG05?=
 =?utf-8?B?SUsvZ21YV2N5Ui9yUnh6OUFrb2dsU0lCaUJlcmdBY0RGS3FiL0xXNTZJKzMr?=
 =?utf-8?B?L3h4SDdvTStzbFRPdi8wcmVadlJaVHlJVTFCL1dPTmlOVDFhemVaS1MwenVS?=
 =?utf-8?B?eW5Ud05WWGVaQzV5cG5HWi9EWGV4VmowSzRaQjJiS0c1M2FnZEJqaGNrT2xi?=
 =?utf-8?B?U1k5dWRCV2t4aTcyMXp2bDJ5ZU1WQWQwa0xScWtlU2pQS1RJT2lTa2tSdkRr?=
 =?utf-8?B?OFdBUks1OWRPMC9lVmM3K0djYXVocUNiL2dkUEZXQUx4VHJqRi9pMTZiR3ht?=
 =?utf-8?B?UnZPc3E1eXVMa1lzbkZXOFRPU1FOVk8xcVVUajEvQjVFZktxNVN6YlhJcnU1?=
 =?utf-8?B?enZTUGdQcWY1K24wWHdray9TTGg4UFp1NklKdHZwd2QrK1JoSlNwN2hVS2Rt?=
 =?utf-8?B?WnFCVFlBWS9pOTdxTjRpaTFrYWI2Zm1Ya0RRanE5NXJwTklQTE9mTmt0Rllu?=
 =?utf-8?B?WndDbzEwN3MvN1p4M0Z1Q3BEalhueWtuT1BqWFdqYm5zQTlaelpaVXJONFRo?=
 =?utf-8?B?WXIvaWtDbzZGc09zeENjaTd6amVtcXIyTHkydTNqR0ZzT0dVNzZUVUdGemcw?=
 =?utf-8?B?WnM1M3A4eU02T2tDUXVDa3BzOG9XTUVUOGovODhTL2gwcmMxQUJUTmw1SkY0?=
 =?utf-8?B?c3NwdGtlRFgvMGZOUjNSaFh2SmJ2N0ZpY0NkeUdsV0Nkd09UQlR0NENXdHI2?=
 =?utf-8?B?Qzl1SW01MFB0RjN1dGRZSFJLamZhT3ltWTA1SDhoT3lveWg5aGJIR0xFVVNJ?=
 =?utf-8?B?UTB2ZXZMWW9KYUE3RVBGS0FGREVwSHlPSURic1d2dzVYNzJ1d0RzZGVqQzJH?=
 =?utf-8?B?cHVCdno2YUYydFRnYnByOU5sU3E4WXZjN1k4cmRSZ3paS2hLYnpsOVBCK3R2?=
 =?utf-8?B?TWhLanlnTko0b1BoS00yNWoyQXB5akJnVmFXN1NsS3REL2tYTjdPbTViVU5p?=
 =?utf-8?B?bnN0cHp1SDVUVmFMRkc5SUlKTWpBU2ZUa2dwRFU5VmVFdlRueUxiejVqMWdl?=
 =?utf-8?B?WjlFZ0gvcWtJZGhJblU4eHMyaVZseWdYdjF3MWhXV1JkeEN1cHJOVU5mL0Ey?=
 =?utf-8?B?cTN5dHdGeG81NlllVVhEWmZVVHBHbnJ2cWJxbHRTTDc4OHMwSjJHRzZMYnV3?=
 =?utf-8?B?Zk9aWTJmSmlYbDB6aGdvVTZPazM5QlA3aldpMlFjRW1zRTA3T1RCM3Y2NVpV?=
 =?utf-8?B?b3E2aS93cWJrQXAwVytqTGVKem5ZLzB3RUFzb1NnMVFqYkhYN1dQaExSVjc0?=
 =?utf-8?B?WTlOa1hWZ3BLMVV4MU5YdHFWRHJSNGZVbVhFYkdReVIxVW04ekt5OTBDQmJC?=
 =?utf-8?B?eXd3SUxxNW8vdm12WUZxTEtxSjNHRm5CalFURHZSVzhXWUJtODhpdGJjN2sw?=
 =?utf-8?B?Z1p1Rkl4K2NJdUVra3JsMUlLRmd3YURqZXcvcFA1NVVKTERIN1RkcDMyQXpa?=
 =?utf-8?Q?QmL0zWhlN9JSM5kFx1nh8+f0V?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 13:10:37.0334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9904db-c6b4-45ca-a265-08de4ac97c84
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7170

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
index fdda18b1abda..9bd710c7bc95 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -303,8 +303,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
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


