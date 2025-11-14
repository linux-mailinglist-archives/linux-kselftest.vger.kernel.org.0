Return-Path: <linux-kselftest+bounces-45621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A384C5BBDA
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 996E1358776
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 07:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D01C2FB61D;
	Fri, 14 Nov 2025 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="n+mc8hcv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011015.outbound.protection.outlook.com [52.101.70.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAC52F290B;
	Fri, 14 Nov 2025 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104457; cv=fail; b=V3rwpVZLGN97LOxyRZUS4kb9Abb4nlZZT7UZ2OwlmT5HycasZ/J/pvKScwZE+/9pkGzaUXU//SsBD4QEt9Ds7xTicsiZ0cjuhn2Q2sWqPhNhzVXTc3f1g0mF9fmIueieoTfFgh2O3SL5BY0E9yb2eySleVwHxAqw4Z6+qhPTMlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104457; c=relaxed/simple;
	bh=kM0IY/nPKNbW58R56D1uU2huXM08e1R9iRw1VQ9xrqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5dHvFLPVPbbJ7Ob8eyjGQ5Lo/C9lkHaTgn2JDkuThbCU6sRaLQI+NED5tyaPElszX6FLrOEc6iBIrF3hhJby+qTWPclX8x6On86Gm4z/ohqZyL81sIvOwapshPoo2tZxWrZtny8FlClfNnfOlD9sY/U0zRJKxUybIJKNrq9zKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=n+mc8hcv; arc=fail smtp.client-ip=52.101.70.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2axM/i5JWviu4ZrfZzLfHEcEA6qqHBlgmvJa5xjmbOFQh5cSr6lDgkI01rLeoZ41S5CHsZ68EmRhJ2EKkCrC5Y0VQmlS6u3uxyhMO3MOGdNagI2cqJPPHIzo8jWWmyygWOTaCQhxS9CSZT0PqIbSPN37LW0DRi6aJzALuydCZYhEtboqAXUTtgUvIyZfa7RiqcQ3PjmI1s7M8t2EmsAhrzRRTKVrBeRZW4N8GR+B9+of4Unm8QGNh4L7U08P/L9QQw1NVCE7gQMGbrxcDtK+J1kupEb6pOPTo6vXCf0Qy5Cv25kDHzFk0EOj8nGrS5M0XWN9XArkHuB/GJy2ujQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9q+SSurFhibDHusnIuY6c75xmxScryCEwxzG78xyio=;
 b=Evb5J5pNPvdynzHEB3/o+66USAMoP4DSqhubPUp9Qk1aylFU1EZT7WHLw3nrlmLclbNxX21ePsyHZSzTee9ADayz+2EpVrj/gNs+yMWWgQ6yLPeJc5vkLO2YtcvIcx7ybIHlmlplBzmIWBIOP+jlX1E/WPWczkm0yNhtkCpUzmPd8zsm5Bb4LC4EuZWUXVG58b5JcfvVDtdp6eAnQVwbB8jaPvgzhWiWDfxnynYJHROY5Y+w/khgvjAUv9d8dHTyotjo9bQA6Yc7PH1H84X6zDEjkGHQXYdJhoKCx92yv4IzAytMhiVAZx0s0TGNtYg+F9tgPa6U00yo7LLRn5nidg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9q+SSurFhibDHusnIuY6c75xmxScryCEwxzG78xyio=;
 b=n+mc8hcvO5rxNTvmpNLDAa/VTgMxu9ZtsyLm0swthpaKlQVCb+5rwkmZA3sx3/lmH4DLWlxQpkVthOhDKnX9dZLQZ0u9vpC3EXn0pDWuYfDb4ZPhW8nGII0lLlVSz8XKUrC2dkwi6YuNT/HNkqQB2+DT0zg89Mq/NtVOjUVz/nZWmGqsGRroe5Bt/KytiEa7OofEJSQF4r9YYh5cFrVOqiFW+RdMRJTy6UyurIioOBivkNlZy1ajHhxKQxmdREiZexEeihK76LnzYE1ZZAP5UbaT+07UQOsZCUarizD/oudTIH+OYJAgKqWloVCiuq9MZaMRb9avNRZOdf54n1cx5g==
Received: from DU2PR04CA0069.eurprd04.prod.outlook.com (2603:10a6:10:232::14)
 by DBAPR07MB6917.eurprd07.prod.outlook.com (2603:10a6:10:19d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 07:14:11 +0000
Received: from DB1PEPF0003922E.eurprd03.prod.outlook.com
 (2603:10a6:10:232:cafe::9b) by DU2PR04CA0069.outlook.office365.com
 (2603:10a6:10:232::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 07:14:11 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF0003922E.mail.protection.outlook.com (10.167.8.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.13
 via Frontend Transport; Fri, 14 Nov 2025 07:14:10 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id C7B931C002B;
	Fri, 14 Nov 2025 09:14:08 +0200 (EET)
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
Subject: [PATCH v6 net-next 09/14] tcp: add TCP_SYNACK_RETRANS synack_type
Date: Fri, 14 Nov 2025 08:13:40 +0100
Message-Id: <20251114071345.10769-10-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF0003922E:EE_|DBAPR07MB6917:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3918569e-31b5-4581-bab0-08de234d6876
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?JxPlU2LkvV9C8lChG58lVmEHergNuN0qiCJNoob9+a/mkGvhBeWpvdh9gFrj?=
 =?us-ascii?Q?5zCHZEOTZzTMsvLAxvWfmsra9NrD598LV5AFkz6DI481/FMjD6W6rafzR9PM?=
 =?us-ascii?Q?bPDw9pitnUHe26ss/5wzeZk13scJutXkuSUAifMCN7Ap/FqAmbXxoNWALjH3?=
 =?us-ascii?Q?Nhfd4Xf9iQqc+hXxM/6R0+IBl9M+B1DMumHnZ4l04lUA3q/ocI/OJgFZPPoI?=
 =?us-ascii?Q?yHRG06WR57TzVU18F2tOQx703IiLltT7vYJZsVfpCoacj5zA3p/6dBcmPX7a?=
 =?us-ascii?Q?Q0W/ME8gDFFVQLlBnCU+fRSTPgEjqMX9MeQfWKAvuCrpGIJc3fe/xkid4Swt?=
 =?us-ascii?Q?zt8JEGk+QhuAflYDnDrc1NOPvxT0+KXFeRKNayLe+alC3BlDRhV9WfKjLZ2A?=
 =?us-ascii?Q?Tlv6IPitvKhYnJgh9Lv9eyQZfsNaBgXXwuxGnbYcwYIJfs7LerZPMmBFHZtJ?=
 =?us-ascii?Q?LAaShOk0vkMyRr5mmgqs2L9UO9LS9257klwIwfdnXur+TXRV3/sU4oiW2G8R?=
 =?us-ascii?Q?u3Sq/FJ9/72eNuYEwHZOMfGjKf3wJDp8A29JYKAh64E8m0Lo4koRKnBwJhsC?=
 =?us-ascii?Q?rinvINSH93ztYzVipe3ozJgr5wUlzcoAppvu9p+5ngXtTyuf7qWp26gdrl/7?=
 =?us-ascii?Q?dhd1H9BmockhSDZ1r1euwPDw6mRYqtvv3IRgG8M2T2I/6R8qKsPQsY7X3MWW?=
 =?us-ascii?Q?oIw4kmheJ6gve5tdZOtJ7rqb1l7SxlQSJH/EFRVUPoE81E4Iq0Z2WuEm3cDs?=
 =?us-ascii?Q?Bqf3BZ1hVBmsbvNaO4kzvKUabZyNlWXv+cszHWpr80asKKk5/J2Bob1lUsYK?=
 =?us-ascii?Q?eRhK24vt9eMTGKuba8Un6OmcgetyVJD+FRu9yl+9gkiVD1HXMXpOMOqBX5A7?=
 =?us-ascii?Q?PciBjYLdVzdKoVr80/IGPfCaTVV54b0P4k6jQpKPUHN5zZvu1c9cHkkmI4g6?=
 =?us-ascii?Q?wfx+o+Uu751WMHbn/k+6+s6hpBww2KeKIOr6c4KgTMax5ugqC/YP4LH51zPG?=
 =?us-ascii?Q?c3pO68DHxWDtyIP3bkNMyawoRyEEttgY7JvCNf36r0xzVwCoPD7XQluqjWlv?=
 =?us-ascii?Q?aU1kaQCAJuGwhg8u3GZqlRcNKZDA71mHKPP6uPtCrZarRofrQz5StJ5qN16N?=
 =?us-ascii?Q?UBfDy9LR3y6PB/kbw7EN2b2Ga8Lwna0fCY6lB5770kyC3KODTP9cIh1deyq0?=
 =?us-ascii?Q?vjSPAdz2rpS7u/IOU8GotMncVfoApuygjl+vlENJ0sbPwD0BfKLGYgm+vyG/?=
 =?us-ascii?Q?hK6RvC3mI0wIU0EZboojJaIiT9JF2MXC56XF2vQQOHQMNEssfMXF4GnFxaHb?=
 =?us-ascii?Q?IlX1n3reqIKYJq2fOGGVEaV4LQ65hWTN9gcAsVIzKfxE/OOSIrIbz+O94bqL?=
 =?us-ascii?Q?pE2RI+QD5B7O9WyYF1H7s/s4cgXZRRtL9XDruDrSOjBzHtTHHNCK8mtePT77?=
 =?us-ascii?Q?Ka02g4xEzxd1O7XlkGHWT/tVd9NtzHA3AOyMCdukZ7g1hiqFWyJnFPL/Ok25?=
 =?us-ascii?Q?ufvl/xemkoiprcxcniEc5QxyjeuI9CXYbmAcITXAzXghW0R9bPfkGsnEA+pL?=
 =?us-ascii?Q?fLG0HYJ4p8yPt7EMY201bSmOFFBWQZDVIJMKE0YY?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:14:10.4418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3918569e-31b5-4581-bab0-08de234d6876
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF0003922E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6917

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Before this patch, retransmitted SYN/ACK did not have a specific synack_type;
however, the upcoming patch needs to distinguish between retransmitted and
non-retransmitted SYN/ACK for AccECN negotiation to transmit the fallback
SYN/ACK during AccECN negotiation. Therefore, this patch introduces a new
synack_type (TCP_SYNACK_RETRANS).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v6:
- Add new synack_type instead of moving the increment of num_retran.
---
 include/net/tcp.h     | 1 +
 net/ipv4/tcp_output.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a8eb67ff1568..510d2e595b08 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -541,6 +541,7 @@ enum tcp_synack_type {
 	TCP_SYNACK_NORMAL,
 	TCP_SYNACK_FASTOPEN,
 	TCP_SYNACK_COOKIE,
+	TCP_SYNACK_RETRANS,
 };
 struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 				struct request_sock *req,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 8039c726d235..5fa14a73d03f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3921,6 +3921,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	switch (synack_type) {
 	case TCP_SYNACK_NORMAL:
+	case TCP_SYNACK_RETRANS:
 		skb_set_owner_edemux(skb, req_to_sk(req));
 		break;
 	case TCP_SYNACK_COOKIE:
@@ -4606,7 +4607,7 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 	/* Paired with WRITE_ONCE() in sock_setsockopt() */
 	if (READ_ONCE(sk->sk_txrehash) == SOCK_TXREHASH_ENABLED)
 		WRITE_ONCE(tcp_rsk(req)->txhash, net_tx_rndhash());
-	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_NORMAL,
+	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_RETRANS,
 				  NULL);
 	if (!res) {
 		TCP_INC_STATS(sock_net(sk), TCP_MIB_RETRANSSEGS);
-- 
2.34.1


