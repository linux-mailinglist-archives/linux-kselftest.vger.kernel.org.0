Return-Path: <linux-kselftest+bounces-36258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAC6AF09C6
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 06:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD69480AA8
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 04:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD6E1EEA5F;
	Wed,  2 Jul 2025 04:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="oGXO8SD5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012061.outbound.protection.outlook.com [52.101.66.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5A71DED57;
	Wed,  2 Jul 2025 04:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751431053; cv=fail; b=FlQdPHtZCV+Oy3ernJV0nrWRF3c1MERoRiD8hC2AhAyCNiAmmPfVFUD8bE7PiBFYd8ilO+9wrkNBE7lpNus13C48bRG959dv3nfLpkkY7eT/0b56O99m7S2N+7E5pIXZzv2r/fwE/gTMgBGw17np/6qL3bS8gPHDy6aBwUG6Ujo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751431053; c=relaxed/simple;
	bh=QheIjnkZhAAj/gUXxo2UK5OQhY+fZUG8lLWtSanvv3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGacPoUavVydhelyR6yl93cNCuC8AqsQ9foQFAYaE28aNyiygnvA57+pYumXeBPMSMUSbObgAmQMBsUYudUzeOYEkuLXxCiZ3KvwnhF9b40P1YqNAErBcLFx5gze6ETzLiuivauhVMirTJDVkgq3LBz0IVlOqbBrk1jhD2seH0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=oGXO8SD5; arc=fail smtp.client-ip=52.101.66.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gz2j7bd0v4BobXuZwlOWMP5BlDAL6NtmcOTHLuEji4KoD+SuuNjAfmQZjdyxojyJtsU7bLtDph9/GPCzmj+3GMv196N1DRWNPyGGhy1nEMmipLbf8C/pZi2uDpeRzQVV/uzAsxnmhFaMstDXa+7XUz7PbHqW8TCn9f0P4wcszFkRLpugEzaCCH6SymvZFWWdxvnkPfvjqRUStyhUymdIAqhK/jroicESDFDPIY0LBZdrhrDR0SVRq/uMSWqX4BYd/5AxKAc7bOq1NgpPyNA3dv5vfPWApxrJW4wUeKrMBPxF0zC6y+/KfdUNE4ldJE/WMPuO3I747g8suNR0/bgPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+ETTqRHjl1PhpSYo1DUXf4AWZcV2Hu4tc2zyFyl39c=;
 b=GNthCtqmSyYtvsjKJxJoSohS3H4+WGnAKNIgdyIINJt8aw+CrhabkJKaGW8wYBzXD+XJEgO5ZIrJERkgTQtxYivpjGUdQNfXQNQv4ooZEwL6CfcAjXLxtzpXeJirKjQ4XcJ4QBsxrhm79jm8J2RdYkbkS3jh4yL5m6tdIbOu+shZwSTgw9DH/TDg9XIi2Wsp6HCo5iRI/hN5CDg+wrijkG5FswRP0kJsxOOtbEOvplZjelm82JQC9FdhB0om3VNQENHnt6LscCTy0+fu4hylnujPNM3A7i76DXrJs5qNkf9Gs1+X/hy5cWkekiJaelzJIF/WoUPWfmiEzpI1E0pZhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+ETTqRHjl1PhpSYo1DUXf4AWZcV2Hu4tc2zyFyl39c=;
 b=oGXO8SD5gh4svxPXI0k80rFuTMkIyBOjM5ac7vLGiSzMzNAfxrSujm2f8E5OaZRKaPq5qhJHjoollvS+N27hE6MhN/HbQ6DQE0Qa0VFLxcrw1HkWET4gjJez7gQF631YDG/fgkf6kAGuuBeutvj/7r/RtruCinU5owsMTZVQOWqPyiKH2jpnB2dy9mIOYUkBSdHpt7Kz8qmQS19Ou0+eozlO7JzKRdJiS2/PshyRTHpbgpiHw0XtJZzsx2uUXeaCDF0qGVD2A5BTScfSzps7YFdYgqtPtesgF8XkA7ZMn2Yk/GIR8MNq9pwHfHBfCKypYoISVbV/MtpglN6DIp90+A==
Received: from DB8PR06CA0034.eurprd06.prod.outlook.com (2603:10a6:10:100::47)
 by GVXPR07MB9701.eurprd07.prod.outlook.com (2603:10a6:150:115::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Wed, 2 Jul
 2025 04:37:25 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:100:cafe::7a) by DB8PR06CA0034.outlook.office365.com
 (2603:10a6:10:100::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Wed,
 2 Jul 2025 04:37:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20
 via Frontend Transport; Wed, 2 Jul 2025 04:37:24 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 44C791C0010;
	Wed,  2 Jul 2025 07:37:23 +0300 (EEST)
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
Subject: [PATCH v10 net-next 01/15] tcp: reorganize SYN ECN code
Date: Wed,  2 Jul 2025 06:37:05 +0200
Message-Id: <20250702043719.15130-2-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|GVXPR07MB9701:EE_
X-MS-Office365-Filtering-Correlation-Id: a0aa2f54-b61c-446c-75af-08ddb922248b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0ltYWV2RTlPNlZvRFp1Mmt4Ym9iZWNVY2lHcVF3U1ZrL3hqaUNvVS9TREdq?=
 =?utf-8?B?MjNreUNTWDNwS0xsR044RXBuRWdSeHMrbkxoWXhnQVc0US9PUXdJMkVzTUFJ?=
 =?utf-8?B?WjM1bk5mdVplVVFJanhvdnFaWHIwNy9QR01sbjB3WTNoakZBNzY3MXJrRkha?=
 =?utf-8?B?em9RL09LYzJJZENEeUpmVnI1VzNJQUdZUmpDRzdMclNCQVlqQ2lFMlRTTEdx?=
 =?utf-8?B?bXlzNTFjTDBRcU9VN3BhOUNlQjVwRWtnSVhBQ0p1RXlSMlpDTm5hVlk3UjJI?=
 =?utf-8?B?Um1pajBRemhKcUlKTVNwQ2JEOFFzMWxLRjFHRng0NkowQXlybVNnMFlrZnQ1?=
 =?utf-8?B?MGlMdXFvMDFDaEsrNkxQTVk0bVRoLzhhQUFEZTRkK3VObHROUE9aT3V6VDZV?=
 =?utf-8?B?L3ozaEtGdmxiYnV3SHh6YzRPVi93OW1ub0JoQmJIWTc1TWp0T1NyS2xQd1lD?=
 =?utf-8?B?akVQaXk0RWQ1dTFrWHZkV1IzR3lITHM0V1o4eXBJQVFlY3RBblFFQ2JsYVM4?=
 =?utf-8?B?QkVRdlRzaUlEM2k4NW9uSks4QkdZRWxNblE2MDBXdHkxREtaOGFmOHVtTjUx?=
 =?utf-8?B?Nk1WZFNNbGRrdGF6V0xmVS96b3pZU2RoVTFaL25abUlGMFN5OWdhbURSNEZh?=
 =?utf-8?B?T0JNQmxPbm9abFYxYXZFSVdIaHNKdTI0dWN2OEtpVWl6S2VFZ3lQRVJFU29z?=
 =?utf-8?B?Z0pWb1owTHdJdzV2a0ZxSTJUcW0yS3VHOVZLdU5RQy9mMXJOTGVsWDRaMHRa?=
 =?utf-8?B?V3ZlTnpuSmRsVEVJUzBPRE9Gc3VYUVErRExHdGRjQVZ0Sm42Q0htZyt4MzZx?=
 =?utf-8?B?V3ZoUklxdm1OMWtMeGZhZlhxcDVaQVh4NnZ3TEJXSmdCQ3NkMTliTjBGZnZm?=
 =?utf-8?B?L2lnV1NnWS96V1hTZnBOQ2szanY5aXVLa2dJUjdrY0FkTlU0L0FlWm9lbUFh?=
 =?utf-8?B?blRsM3NSQ21qaS92bTJaZnhrQmZqQVR3UzJrdDBCSGliTnQ3MWhMYkcxS2cw?=
 =?utf-8?B?MWZqaVZiZ1FRc0ZYQXR4MHBkeWZmeU9yTyt3b2NKY25kWnU1eHpma1BKdmNL?=
 =?utf-8?B?VXVKcjhwRmRhQU9weTlIalUyNHRNTFIxNm9QL01QYklGNW1tVmt1OEhOazd0?=
 =?utf-8?B?UVN0L1l2VjU5KzdpSzBpWjA1L3d1QkdKV1hYZUljWlRUS1hWaHFnMkFOVDNN?=
 =?utf-8?B?NTFTY1Erd3NhVDhKbXpFTEhid3ZCY3RqSHhBdStHeE85dnNYVitIUjNuWUlj?=
 =?utf-8?B?U3d0blUvOUR3TUhwNTNSWC9uNFFteHNQeStmMmUrSW1yako1UTJHMVVvNW5S?=
 =?utf-8?B?VmFBNk83RVpkUGptTnR3LzNPQXNoTW96NjRFNmN3QWJnYy9pNXhlTiszNkli?=
 =?utf-8?B?a3lENFI4RnZCTGVUcVFoNGMrVjhMamxaMXNtcHlhek5SUTY0SXUwa2hmMWpM?=
 =?utf-8?B?cGxUYXQxU3BObTRwT3dMLzdTd0VtNmpSblVxS1BYc1p0cDE0OU9uRmNUUEx4?=
 =?utf-8?B?ZDRlQ0F5Y2VTNDZ0TkZJRkh4QUViVXRVQ3RydzZxRlhCVjVGOTMwNy9BOFpn?=
 =?utf-8?B?K3U1TzVRaXIwZnZnMGJPWHBnZER1SlYwZU8zaC90Z1kzUUwrSCtKSGhFSGRy?=
 =?utf-8?B?SWdMNDlBYnJkbzFENEpFczY4Unk1RkZtSVo5SGRKN0lkUXNsNVlHRHJLeHpi?=
 =?utf-8?B?VTlFWWlLQUNlNTgyUTEwZjF5TkRuMmVXbkFDUmZ5MTI2WDNOdjV6WG1qSkFj?=
 =?utf-8?B?YUlxd01LQnRQSmRqU1BBUUxYK01BazV0L0RhaEw1Y0RzUHBTQUE1RFBYZEhp?=
 =?utf-8?B?SndzS3hIaHJ2cDhFRmZLSHIwTThtSzcrTEZCRGl6YWhKeTQ1Y1Jxbkl2VEdj?=
 =?utf-8?B?RlJCRU53MnVWZUVJTHVjN3lQSnRlMGFmT0hhU3IxWXpYdlBWM21LRzVZeXcz?=
 =?utf-8?B?OFdua1l4dG5ROEdWd2xvWG16VmxkWEdnL0VxZTlBdnk5c3ZjYXJvYmNJd2hR?=
 =?utf-8?B?SlJ2RkVwQTZGUkpRSGNCQXk4R3h4WkEyaG9lR0hNSlE3TVRBKzV1MEo1SlV0?=
 =?utf-8?B?QmJCSWNkU1JaY1ErSUI3SmcyelUxU0d2VVMwUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 04:37:24.8840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0aa2f54-b61c-446c-75af-08ddb922248b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9701

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
index b616776e3354..caa980c3f25a 100644
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


