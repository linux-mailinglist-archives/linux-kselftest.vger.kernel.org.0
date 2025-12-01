Return-Path: <linux-kselftest+bounces-46823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B5AC98517
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 17:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C20ED4E2370
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 16:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED09833710A;
	Mon,  1 Dec 2025 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="RGBlXvBU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011067.outbound.protection.outlook.com [40.107.130.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1785D3358D1;
	Mon,  1 Dec 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607122; cv=fail; b=M/HMQY0K1wS1PEWOEXfWqUlBBMbwtnNbWovFDt13HxA1h+b7GxtGdOoRtfuvhqUgrRYWPdR+9YBaLgHEj3WJaBj6kc0pThdWMIA3P01Mrsgnn0+xhEUPYXK4HIA8Eg8uzYx/fvrDHoQd7M0xxltwutku/wJcYQ5Hlw3bEPQqLV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607122; c=relaxed/simple;
	bh=fF6KhVNp2zh4zoIZ94EPbYaFEOnQkE+3FLYPegrByJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bm8rnFbI/j2zcbLuztcFo4pPH5ml18/Z6R3WMhoVX1HvtpEUnmLe/AbH/adlvAExrhXKvqtzn/0lrku83X9DmHnR1iC+fNlm1Vb0HDQDiNNFLGmd9ZRamkUoTvPmLf+jUJwCR0y+VwBT6SkS68feg8TJYghLYPbW0vDZCfiMpmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=RGBlXvBU; arc=fail smtp.client-ip=40.107.130.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2GG5VramSJVw8bzutrmUIsLzEdGAzwBc0c1duq0tZbjqV5UOdExxc1s5+j0Nbu75JxPPUUia6kgy5H2ZiAiwD01MwwqJbKxHUUkhKouIpv8/5cLNwHqZk4v584R3VWe+mEpQRv4HNwR3DTHnEkljPwAXfYte+yXc3xl0TO/tXQMs/2cs1H8FhEuq4regKLFIfBk0157ObbuB/FSOfpArjBdMqr/V8C4L5OvA/w67nyITx7/gLN34fXGnBH3EXQoAARVGmnGNL47/YTGgFttxVFcSJ4CWCl+1E1eSoMXrdymvs1vEz2yUNPUTUijY2xlvgvj6ffhH0/4Oza2tOcaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2ctgY7Q0ImIQTcp9Rn4gVjiwmfFtWYvfIc4xNCz55Q=;
 b=yWToHMq4iKJxqUD7m+0FQto8+kMFeqjQz7oWcCwHcZXgonTRk85LaysuvEqUvhNTaP/JHxoG+tw1QHqG+lNG5567m5Ue5Bv1urRvFXOjr4uYuE1VR6Dv0dK0ALMryhDpulElBP+yFIQ9JYPPVmeb3ykQMofdo3Xucdnoo+FSDkkXFcBe5X8D23+9YQBhfphuDPZMpjvbdVV/gCXmkvmzI1Ya9hb7UPifmsG/aeS83j79czTMPrvdCFV1vBua7Elc0TVFqYe2tM5lD+qCfkZ+Y3NGj6WjV1N/ltVQrEQlUvrZE4Lp18kP97FKdql47MKRj+bAgYeCkUMaJoocdrQBaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2ctgY7Q0ImIQTcp9Rn4gVjiwmfFtWYvfIc4xNCz55Q=;
 b=RGBlXvBU3TiQ2MaJET7pHgDwrADpr/stmPkT65rHcJ0ye1l54s/+UiHNOVTDtP2Zo5bzGoaj8eiCtY47Vb3JEKV7u2Xkai+pkP4KA3JwixHjKKFq2OIIV3oSkYCW+GUFJ6IveiDcE1Q71E8fnIC4/5gE1zgkuRfpICEauLE/GgvM68gb51gfh82lBjiY+XxDkQNjWxtXG0dnazo6T3Rzg8N9YuNih6x4JCiwJtpw3mf1+zqKriku1ysbEu5GCUZbyxpihdvD3/EyfW76Jn0W8TplvPqQ9X7fu072icpV+/jFIL0cSK2f3XiQB5h0oKHxO7Mm1ZG0NVp9iDoqSp31ng==
Received: from DU7P189CA0006.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::6) by
 PAXPR07MB7918.eurprd07.prod.outlook.com (2603:10a6:102:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:38:36 +0000
Received: from DB1PEPF000509FE.eurprd03.prod.outlook.com
 (2603:10a6:10:552:cafe::65) by DU7P189CA0006.outlook.office365.com
 (2603:10a6:10:552::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 16:38:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF000509FE.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Mon, 1 Dec 2025 16:38:36 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 0FC89680033;
	Mon,  1 Dec 2025 18:38:35 +0200 (EET)
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
Subject: [PATCH v7 net-next 11/13] tcp: accecn: fallback outgoing half link to non-AccECN
Date: Mon,  1 Dec 2025 17:37:58 +0100
Message-Id: <20251201163800.3965-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FE:EE_|PAXPR07MB7918:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2452b452-75fe-4197-febb-08de30f81354
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?8HQO9j2K+k5WjitunGygJGL99AKn+WS0pfRk145hkwJUv4sPorOATv7lTYv+?=
 =?us-ascii?Q?oA0Q0budWGHjkrfaYBY47u38vE6wrUYJ8N2zBJ3fAtM48PzIYiT/UXIsAiq4?=
 =?us-ascii?Q?Z+q8Ua1UgYPmaV/6/dC1KEiWirGHODuDjRhnVKlqFoFN6GL2RrzKTa4/FTfS?=
 =?us-ascii?Q?8a5lTx2o0TZSeCNh20R2K64zTAgg4t+Swj7mcTiXSClUHD8yRpDOw6mptHYF?=
 =?us-ascii?Q?iJKfjyt16gyz1MIrZwZc/eixCUsbPf/Z3zOHq/7EqnHoqN6z9qjydJz+kvo4?=
 =?us-ascii?Q?FRn5J4IOaRY9HT+hvt/X6cOl0h/WCz9sxU2QIgI8JAPzzuTLtPYvIXwP/e3d?=
 =?us-ascii?Q?kSi0s4gRcd500vOw5nGHs+83WpK3PgeikkI7B2UQvf0rYZwzdzePWxZAm3zw?=
 =?us-ascii?Q?voLTnVs37B7RXzREVggD2dTCKBPQD2e5UhBewXk3h7oeZkICrBqEoUgZIN5m?=
 =?us-ascii?Q?z5doOyxZmrdYY2/8Y+l+m62w95kqslIyyaQi8Oy9TAIXx32A1rS83xeubFhD?=
 =?us-ascii?Q?+gglZPG0DZlhceeIIjDJFrr+ry5vTbHQT86qknVsmIwgT1qMfD2XYMxgVlTF?=
 =?us-ascii?Q?s+wD9lgHDkI39md18hJQ8ifLcqNquEsiy0Z5ROlN3lXZUt3tmt4E/1wPj/7k?=
 =?us-ascii?Q?DCbqdf9VPmCKtdteghPct5ZIEABNsPrw+fBm5wwbJey/eMpfS6c+UgUCF1yv?=
 =?us-ascii?Q?+egGuCK+HLIvGDJNquSuh+kkd+wgRgyM33eyU9CrDnADnfyeSuYjRclRuPP5?=
 =?us-ascii?Q?TngwF/se2fe+u7YiIPmCP1QqnvCNPSuokgkCe70iWb41yxMuJLf6AIqUk3JI?=
 =?us-ascii?Q?HF3tUn2y8IaqAlAY/QvYHaFGcL5a3nwKCVxvNS5vsMirzO9BOUYMN3qKsI2H?=
 =?us-ascii?Q?cPPG+EEB0GHcYzCH9c8hBTy21raueMDcyIKMFm23tcpOdatUm/COkyQRKhiL?=
 =?us-ascii?Q?i2jSIzypKCjdv45cJZXSae0d2QfNti81HgGXvHF7voJGSKbp1Q/1U6LU0xJ/?=
 =?us-ascii?Q?tRspoXDTS700WTqhtdZoQMtugTA9KKoTclV2RnkXsbkI0E95czWttkOSapDC?=
 =?us-ascii?Q?ju9J1j7askoGS+/LqJxFA26ia8HADXoQRgLJX4CT3DgeiTLyK/AN5Bov/dZM?=
 =?us-ascii?Q?yXUK/lal1UKscubdPLufVaN0v61RMXlheV2yu8nsNZ7wT1SS2nlds3Nzu5uY?=
 =?us-ascii?Q?gPoobGHk8baqfjEP+6tbgPLcwiHsPCieFW2A6nBPlY00VmP7TtIbf+sptXKX?=
 =?us-ascii?Q?csaZpBjfbUDawZlvLRDmZEgaKRCZg7dp2BRQxHtjo61Jtue3epXFbn0weVV0?=
 =?us-ascii?Q?SBIksVlXKQromoOxWt9dZG0HDIkpZXvBuiNr+gO0WHJSAuxwaspb1gcUPwre?=
 =?us-ascii?Q?wRKzL66LSeQTniiQ5B6Gpj0ibhnsIbbdEKLmAyxPfddffMmJKtDMnb2gsg7R?=
 =?us-ascii?Q?QKvdo+Csx5qu4ZOn2y5HlmN67HO1gQx5haG0vj1TUA5gihoHRKBHSYmZ3h+D?=
 =?us-ascii?Q?PuqGALBE2rnotxhZml2uboG+WGV5JxZSyHVo9fpLqE1/UhWNzLely7M/CITH?=
 =?us-ascii?Q?TfWZrQa0JJZbGc+YMRKj9lnbYbyLljhrU+JiRVpC?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:38:36.6657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2452b452-75fe-4197-febb-08de30f81354
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7918

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.2.2.1 of AccECN spec (RFC9768), if the Server
is in AccECN mode and in SYN-RCVD state, and if it receives a value of
zero on a pure ACK with SYN=0 and no SACK blocks, for the rest of the
connection the Server MUST NOT set ECT on outgoing packets and MUST
NOT respond to AccECN feedback. Nonetheless, as a Data Receiver it
MUST NOT disable AccECN feedback.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v3:
- Remove unnecessary brackets.
---
 include/net/tcp_ecn.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 796c613b5ef3..49e0b865fe02 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -175,7 +175,9 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 	switch (ace) {
 	case 0x0:
 		/* Invalid value */
-		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
+		if (!TCP_SKB_CB(skb)->sacked)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV |
+						     TCP_ACCECN_OPT_FAIL_RECV);
 		break;
 	case 0x7:
 	case 0x5:
-- 
2.34.1


