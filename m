Return-Path: <linux-kselftest+bounces-36263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C787FAF09DB
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 06:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC598480C1F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 04:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8371FDA8E;
	Wed,  2 Jul 2025 04:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="e1h/v9iZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012046.outbound.protection.outlook.com [52.101.71.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8381E6DC5;
	Wed,  2 Jul 2025 04:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751431061; cv=fail; b=NIwuKu1aGbsxv7JXrw8jwQ15N67H+gmSWS7mdid53PKmi30QSWaxHcfB2lhCd+afeYrH+UM3MWiMOoW+tOIdKc7IlsarprmcMpko4cYCxMRx+gSbgBO5EKZrFvpQvOmnutCA/pBrbrNzH9Hbuz9TQ2wimEA5EC2ZNzD1lTRFnaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751431061; c=relaxed/simple;
	bh=XqYvosNfgMLuXtKas33lpRGOKqyLy8EMYsLu65lbUE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSROu6lUFGIWqBgNxkEYeo7DU6p1rToDMcSuLYjZuJ+uAH3wc7T8HlShd9Opu3UIOePjfXh8ZFKE6g4HZK+e5S01TyCJkNxF7wMKDMgJ6ehbUHrBxXuCp/z1/GBT/0qTVzV+48UQCOnqlXJ3AunjKke7CgfLt+Kd8ltf9S3H9QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=e1h/v9iZ; arc=fail smtp.client-ip=52.101.71.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUzN2cl3BBHjW0EaP+AzonvZ5JBn2QCWOGjCQzgeDlwhonu0Wo7kefhTnKUeOMxeJm4xT9AI0lVHpZV9hvF8f1U6t7ssYnT+6BJrkPc6NvJKBjcAVsmSmpyL6IUme0/nNjBHU1VAqzC4NoUUwhzqteul5WDS2QLbhr5UlqQpgJcsocmuh59HzHpphRbOgptIX0DEzIsCGOLDJ0AF62cLRLdDZV3FSQ4WVeZ0GIv8QohN1nfL8zyTN/JskezxartFh0wlyU832QypuId0koZdFgGuf2vfSOcaYQGDJWNpz5kxSqiaKmsxK+Req3nQa6Plv0Rh5H98gfjKlWKvEa334Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZblXHefvzdSs6m7d5uW3rAEqoVZQ94WoFa+3dNcy2kI=;
 b=nakAlOLRHbONID4VkB48ZoPj4es1JbuSnIt4fP5YQjaXIXE48viUEAl3qdINKYy3pAOQARFiWOR0gWKTE3Hj6fi6fBBz5ma5qdmPFKi/7r2YdKIxAg8PWQ2MHUn/Yws89s6KFsqei2iVZ9NYqE0/UAoLvEQlsgzMwRuxBqNt9zUidQY1hcQ3gGHGwhifriVhvz9LMKlHTch0RgmB0U0qeQViUc0Sn8gygNqdizur3ZREf1wVLo42/+qnANO7IqPcwvcc6/iPF96QirhSfPZ+4Oj9Va722TAt8OS2XlfvVCO8FGD6qfYS6/mCGJnLtd5ty5ASiq/XVTufuwFmL3xYhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZblXHefvzdSs6m7d5uW3rAEqoVZQ94WoFa+3dNcy2kI=;
 b=e1h/v9iZe0TqfQehVzc0RHHL3iqfHaJiRaqy2NfXvXMH/cbmIH7zhnlmbaZJaWJEg1xjOJzfNpKyqSB73ylKGDV0GrEn74WLCZMB9gGUIxItz7It2H7MLmGKzlBw8C869Rtq1WhiY2gvLsJ5EH5RXu/bkpzhiUKPRCKszRKegtzQ+zZJF6xNBOdOxdj4bM7NQZ32S1x9IpW9Q/KdJAwZt3GDKJ+eyhHIHjyGs/gIi7/nRFoJj2OjwBG1AkRbR0toYJeFvsPqtPu+Dqeym75q6dLg8ZbewN+eGlM3+JtZYMnyqUcWKP/yeHc8ikHiJkpcoKaFid3E7CYqQAKD1Xkcrw==
Received: from PA7P264CA0216.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:374::15)
 by DBBPR07MB7435.eurprd07.prod.outlook.com (2603:10a6:10:1e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Wed, 2 Jul
 2025 04:37:36 +0000
Received: from AMS0EPF00000197.eurprd05.prod.outlook.com
 (2603:10a6:102:374:cafe::1b) by PA7P264CA0216.outlook.office365.com
 (2603:10a6:102:374::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 04:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF00000197.mail.protection.outlook.com (10.167.16.219) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Wed, 2 Jul 2025 04:37:35 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 348941C003F;
	Wed,  2 Jul 2025 07:37:34 +0300 (EEST)
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
Subject: [PATCH v10 net-next 07/15] tcp: Add wait_third_ack flag for ECN negotiation in simultaneous connect
Date: Wed,  2 Jul 2025 06:37:11 +0200
Message-Id: <20250702043719.15130-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000197:EE_|DBBPR07MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 3732d8e6-689c-4f71-4e17-08ddb9222b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUZlZGJzTUlFTDRlWFNhbWw0N1dMNmVaU09PU3AydmdseVhtODJWNndLRjZw?=
 =?utf-8?B?eVB0am5hbnc1Qkx5cGE3YkcxTWVLd1Q4V09Ha215T3poci9QTDh0dmxYeUg3?=
 =?utf-8?B?SlBZbzdOQ3FHTG45dVB2b2g5cUVRQ0pVYzlrV0xQcEpiOVVTK1Fjc1RqdXll?=
 =?utf-8?B?MlFZYnVxeVRORVVLT1VmQW93R3JWVU10ck5McDRiSU82c2xNMHY2a3BmYU1E?=
 =?utf-8?B?QmlEeGxyVVdkZ0NRcjVMVmw1UE41dnpocWV5TWlyaFg0SzYwSVk2SEJVN2hE?=
 =?utf-8?B?T3VmQ1l0a2JoT0pqUWE2c3U1aHVTQWRCcVdDdHpuZWRrY285QnFycmphVzZW?=
 =?utf-8?B?N0xjWE0zTFhiUlFHRjJlbU51K0lhd2pPYkhuZ1dCT1oxZ2FuTURabTQvb3Vq?=
 =?utf-8?B?QmRzRkt5Zk9pcG5FTXVhUTVhZENZUmZ4Q3RyblgydHl2REF0YkZRcEhhV08w?=
 =?utf-8?B?VzB0RnAzWlZEYy9Nb1dLUDNtMi9KbzRCVTBsTEo1RHVxUzZUUHJwNFc1SW54?=
 =?utf-8?B?b21uWFpNY3BSd0tqUGJyUEFvRHlCY2tud0MzM3pmbzYrckFuS3J3SGs0a3BZ?=
 =?utf-8?B?QVRkN3pWY244RFcwaXh1THVIS3lpdlhtZWZvcUQ4OE5hZGxMbmg4UU5zUG1x?=
 =?utf-8?B?TTJRbDBYamVKOVJpaGJ0ZUlCWSt6Q1YwcFhWNXFWUXh1NHREWVNoZ2dSQktj?=
 =?utf-8?B?ZGVQN3RJZWRVeWN3eXpTUUFtQ1dRZ2dEVFNjWjRTZU9YWG5ISFpXeVhFQzAv?=
 =?utf-8?B?ZVl2K2pJSTZmcHFIa1VNTlEzWnZ3d2lXNUxEQ3RVT0NvbWxucTcrR0drZGY1?=
 =?utf-8?B?RjdCUnkyM3Nsai9ydE14NDFvd2Q5ckNSaTFEblB4ZGtYMUVnMGxoZndEcXlq?=
 =?utf-8?B?QStVNy8rWHZ0MXcwY2c3aExISDBaL2lsSE9SdC82S3ZvUlJHTmk4OHg3aFVR?=
 =?utf-8?B?NTBvTmpmK2Z6Tk85NkpYV0NDelJQWTljUDJxMTNFRDlQNTk3NERRRnJqWmQ0?=
 =?utf-8?B?MTJZUDdxQTV6a2w4cGxpTURLMWMxN0J1RVpKSFlzSUtYTjNLUHFhdWxGc1hP?=
 =?utf-8?B?VG4yUjQ1S2tqcmVCL1lNZTc5WTVzNEJZVmdpdTZONE1laHpEUk42QXJtSGFp?=
 =?utf-8?B?ZzRpV0hNdjRyd290OFo4RmgrQzRTd1E2Y2N0TUFENEcrbE5TNlluc1V3RXYx?=
 =?utf-8?B?ZUN0N3gveWFydWRLT0N0WUJ6N3JFZUM4MTBmRi9TWC95a2ZnUjJPN3RHSVk4?=
 =?utf-8?B?YitoVkU3azJnOGYrbEVMcGgrejJVVHVLdjBWT05jVUdvT05jcG0wVXR2bWo1?=
 =?utf-8?B?SFc3UlF2c2V6SE84eGtQWEx5T3JwMFdKcTBGbExBNURDaCtYY1VPaEMvWG5E?=
 =?utf-8?B?WXNxdlZLZFVKZGhyaUtrOENmeHJ5WUlOYlk0YVY1eitLcGZVV0VQaGJDQWNl?=
 =?utf-8?B?Z3Z4MWVGSGtRZzhrNUs4WEFGRDQxOEdTU2dVcnp1aEtyK1lETnEwcWlLWU9v?=
 =?utf-8?B?YzZWODBLNGs5R1NQaUFkblBzbm1TNlpzanpFWE1zY0wxZWVqa1BObUtPNXo3?=
 =?utf-8?B?dWxqcGN4YjRhdk9uWm5MdFd2VHprWWlUMDRDdVh2YjIrN3RxVnE2VTBUdHVh?=
 =?utf-8?B?ekdhcXRPMnIyR09wOVZ6V2hPUlh0bmZLUE1VVmc2aitUWk9lcGNzRVFCdUt5?=
 =?utf-8?B?UUh2WTBnbGFlK2NsRFRXUXFBS2VuTzRjeDlXdHA0SmltdWRrdGU0R2ZyQnF5?=
 =?utf-8?B?V3lwak5kZlNBQzVUVm1xZytaRXVNWmMrdFAxMmJoSDhDSVVsRnF0RzNWWnh0?=
 =?utf-8?B?UWpZTzZDMmdscDNPWW9LdmlSTmlvR0NJcWNFcSs5SHltenRibkNtY1p1Vklo?=
 =?utf-8?B?WFZXY0tmV2w2ajVUeVlLR0Q0Zk0wRnFuOVdVdHNteGZSR28rZnV2dnJUbjJm?=
 =?utf-8?B?eWkyMmdtWnlEQ1VFL3ZjN2FFMzFmejNLMTFESS8ybjJSVTlqaERCb1pVK0Mv?=
 =?utf-8?B?YmVCK2FSYzcxQkYwbmowemI5WHNPdFVtbGFxc1Nuc2wwTmVLSlR6eHN3aEhM?=
 =?utf-8?B?SXRSQURic3RGS2MzbVQ4azVQYjFrSE5OYlBqUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 04:37:35.7841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3732d8e6-689c-4f71-4e17-08ddb9222b09
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7435

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
index 9a90d6e77f6a..31326c462396 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3393,6 +3393,7 @@ int tcp_disconnect(struct sock *sk, int flags)
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


