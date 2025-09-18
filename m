Return-Path: <linux-kselftest+bounces-41876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A5DB86029
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B2B1C87D66
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE61319616;
	Thu, 18 Sep 2025 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Rz8Qd162"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CA73195FA;
	Thu, 18 Sep 2025 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212517; cv=fail; b=VVuvKR5mJ38pJZsb2DIOtL40tJNCQA38GaNKEYJ6u6w0DNlBAuJ/lRyJVaJfXuIPhf06CNsji33XX3gkdo6cwTYYj5bEZsbFeIKdfz8C3vazBauYCPeQrrAQc55Gvaovmrg6Bb71yr4VnrGxXE1DTwLiYgrBGa1odO5URD9VRlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212517; c=relaxed/simple;
	bh=3WLsutbVq1VJTqkOBm0Xgt0FImCBR0olnxzOZ9kBXfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jl4ua1wYmz9l+o4uZLvTefK//ACvuBL1F/CMM084yeHzNfs5+I0WvEtaPv7eu6ITE6XXh6OsaGbqr27FYZZInFUjNOg4bs+Yw0F1HLswMZdMkRU8X4LZxeBcwBZYvi+68IBH3cjvSaX5jF/wH/+PggDDKDyBM/fhfsbRoO7/4aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Rz8Qd162; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCOiKdejPgrxydGqMKCaVohQu6my4JOnfLLjVmQlxlCe5CKPYNYXq7SuofdK+ux1rU/ySt1aeFW6CR0dk2JY662eFM3z4ShVxEzjegOMylFr1tBusvaZH9Y9IrBEAUmPbYi2f4fYVXjuPqcbxC0Xb3pmzUyLkQNKEGykeWrZNdrn3XR8DE5q900KcS4EpeZFTuL86P0/VB2LBpEopZdNCghP3uFbqxu3+TQd7rvzDHcTc/TVqT8hYAGVIuRmbEd2Y03P2Ccdy1nqlCrYvH/a9WZamRYj54jPJJLIPm8PMOJfo7hHIIqXVxhzln55CwJwplNg63mFRKTCAbAa3BEo9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ot2Y32VOlaXIyT30BCf+JDvvS5nzMWkPHW4Pr4AXEk=;
 b=GOLQmM9VCywFySD5Y5s/s6fuuCP3lQiCt8STtkB/+LZR86l/TeBEq1jutvRWRwi4ZGAx25fFNAbIhb70g4VIrcOCN1cxec4qXBw2r/5mQ47BdvNA8d1MfADmsZE3rpPT1OXdYiRcGzjt4HZttq8t6xNhqt1ZX3NP2BvKan/IG22hPxAF1wGLKBv79dsJ0uWuMraplpcY4DAcLp5jhXaVBOgFa0zB0LnPg8Ua1SreZ+pY675vdKUYzBtvHb7lNKijDjLry3G6m30HOaLls9XQVW2GlaxfJJkocF+7mQgIUElN578zK6LavIAYrG4zmonuHjQHDk27ezMav81Q9f0nkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ot2Y32VOlaXIyT30BCf+JDvvS5nzMWkPHW4Pr4AXEk=;
 b=Rz8Qd1626RmkXwfaUG+qRFoArxjKvdYSY8Oo/4FVGoEpz0/CdEhNuM71P2kZt7y5CFgroyaukhjqvF7TzHqHzsbJmZWv+HV/i7UhoSTxLPT73/8LczliK+aTFdFJAuYr0ZwBR0zVgVxp2ZigHoroFMJreO3dShTRMnUHKJi1z4zdylhUzJyG5OcIl9HHC0Ma7we1eH6J8RIHLq2r0PlneiA0idshLTw0HnLDYItHZEjdj7sBgIrOd9dUq3sOvZYeOXkg23/k4/IzVh3o+TZGPKcIZKpQGRNZ6d0CxUSPyoFJqGrD2KtN+CxvNYfce4EGRwb+h8WcG3vO5iPBY2vXqg==
Received: from DB3PR06CA0001.eurprd06.prod.outlook.com (2603:10a6:8:1::14) by
 PA1PR07MB10901.eurprd07.prod.outlook.com (2603:10a6:102:506::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 16:21:52 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:8:1:cafe::eb) by DB3PR06CA0001.outlook.office365.com
 (2603:10a6:8:1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 16:21:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Thu, 18 Sep 2025 16:21:51 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 4609F20107;
	Thu, 18 Sep 2025 19:21:50 +0300 (EEST)
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
Subject: [PATCH v2 net-next 08/14] tcp: move increment of num_retrans
Date: Thu, 18 Sep 2025 18:21:27 +0200
Message-Id: <20250918162133.111922-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|PA1PR07MB10901:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 32a2eb55-1a59-4ed8-5b82-08ddf6cf79c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9id0l3p9ETzO96j2I074+HG+vWWTAaYQnwJG99l7v7v/aiwk/lavABDGCn+x?=
 =?us-ascii?Q?vYcywf7WK8td9N+AVmRRWIzCm5pGmlZzRhPJz7bAzCutTIuz/My4tN7kaI6A?=
 =?us-ascii?Q?4SFLEA0ubt6VTN8IrS46q7p8vtYAi4rFdll5V53KWpC3axU7O1nxO+PrxGoX?=
 =?us-ascii?Q?wrPCrYGeK5FTLv9f+5lW+OD6M7kKZhyOstlkSFriczjUnAvK5+wtOWRogeqe?=
 =?us-ascii?Q?WG3yiCwWSuRyct3jaOWsiruWjQ2QWziQfX488N2VL6no1cPtPyzmSWcwCCvA?=
 =?us-ascii?Q?p5UCzx117ryeGYJMpU2gA1+wRM1b2d3eQ0b/nU79gx1zXC7s+TujmgGK7HZP?=
 =?us-ascii?Q?fp2yt7swkgrm5c73yEtao14oF+7OcFhjA9jLXVn6+fZwAwObJg9VrJ2TMCSJ?=
 =?us-ascii?Q?zn8G2PUyJzm0/6b39DZFq/OXPpNH+oXvMUPvHmyrW1Gn+g8EelnBJr0oVKYP?=
 =?us-ascii?Q?DjwT1STi6nlD/4zmDzise5zjCbsNsgVH6kZqMmyBsxbYUEUy/uOW0VkmiixV?=
 =?us-ascii?Q?jhMus7tzBNlN1BOQnf0R+stpW7ktkzX0tCq0EgBFe8XGjS2albbbqVUmCIn6?=
 =?us-ascii?Q?IZvXMBZa2QNgyt7f/Lmn4ta57lQO2FS6beDD2+umbVPetK8gAV3TDkTcGma6?=
 =?us-ascii?Q?8irpX5hZ83dzm7V7ctGNbNpx7S0OOOKbbhJM+kPFzdniCb8uE6hpshkVFEuM?=
 =?us-ascii?Q?HnbEp7urmTZJzTjmeu7mNxP6wQyL1Hi0kP+lySk2oIAFkdLWTkj6EMGI3IUf?=
 =?us-ascii?Q?4mCOz64Oa8NCvcuRpJXOOFJYXCfBhlbokC+04FcZ0CAOAnnc1tycAIEp3AOW?=
 =?us-ascii?Q?F3SM92Gkac7JoxUZVDYL8zERtUwFUaO6rH2/z/YlQZsutSZBJkZyG51aSKs5?=
 =?us-ascii?Q?oL0IixSqDIm1kXa6+ZGjSs6D025vmzFUfSAUW0T2NTnjLVZzn/Lkwpwk2W8e?=
 =?us-ascii?Q?DoarW7heAfy+w1efW7F/ViK9S9chZnVh5SjfJGq+e/Xqro8Q2p9MNSgm+NqI?=
 =?us-ascii?Q?zET0eaCD4C9B1IGwyP2hmuXq+V/mxdZjMH1jXXdJPKuYQeJ7i/ZrFRh4Rv5n?=
 =?us-ascii?Q?PVM9e6MhDJr+hhKPr266OoNi8theygOLQxKoAshtXW9e4CBynCPeUyKWkPQj?=
 =?us-ascii?Q?tjdnnS5fPU0Zw0A+ktCMqbqMfiZGwSp4f7+hfiPcEcaAeukV2w+k8npims6r?=
 =?us-ascii?Q?W1792aTzBHgmKKkBMKOOiPyaDE+U2mdEj+u7MgGihKUiXAMs7vWwO8AWcMOW?=
 =?us-ascii?Q?RxcQ9eZxHgGLfoXfDzNAi+iFgPRKE4iBy3SwHridmYP8eNH8LU44NrWZy1lz?=
 =?us-ascii?Q?ZKixBPXiAlSulsP+1ti4tmd0/yfx0C+CxsZSRohg6V0kShml/z0ifxt4xk2G?=
 =?us-ascii?Q?GiqjEgySQskP67UqJLsosBrgGWYb4skmcFgqlTc+QdPoVHYf3KbpZ/OejTrU?=
 =?us-ascii?Q?/b+RKlpXF/a6Aw3rqMVhTe0swYGQ251tvwex5YTuiLkWs8IpOU5ttMfKK2Na?=
 =?us-ascii?Q?90SN+jM4yHxSK549zGbtn/6BoZOCqDdUnQDCUQ0XQgPHYAdFSoVyKzyH5Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:21:51.7390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a2eb55-1a59-4ed8-5b82-08ddf6cf79c6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB10901

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Before this patch, num_retrans = 0 for the first SYN/ACK and the first
retransmitted SYN/ACK; however, an upcoming change will need to
differentiate between those two conditions. This patch moves the
increment of num_tranns before rtx_syn_ack() so we can distinguish
between these two cases when making SYN/ACK.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 1c372fe0e57f..bf90c2b33af3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4593,6 +4593,7 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 	/* Paired with WRITE_ONCE() in sock_setsockopt() */
 	if (READ_ONCE(sk->sk_txrehash) == SOCK_TXREHASH_ENABLED)
 		WRITE_ONCE(tcp_rsk(req)->txhash, net_tx_rndhash());
+	WRITE_ONCE(req->num_retrans, req->num_retrans + 1);
 	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_NORMAL,
 				  NULL);
 	if (!res) {
@@ -4606,7 +4607,8 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 			tcp_sk_rw(sk)->total_retrans++;
 		}
 		trace_tcp_retransmit_synack(sk, req);
-		WRITE_ONCE(req->num_retrans, req->num_retrans + 1);
+	} else {
+		WRITE_ONCE(req->num_retrans, req->num_retrans - 1);
 	}
 	return res;
 }
-- 
2.34.1


