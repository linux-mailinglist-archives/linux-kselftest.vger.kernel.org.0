Return-Path: <linux-kselftest+bounces-42960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BFFBCD251
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 15:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB8B1A67E88
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 13:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B5A2F83C3;
	Fri, 10 Oct 2025 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="XlcF9KHe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013046.outbound.protection.outlook.com [40.107.159.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFDC2F1FE2;
	Fri, 10 Oct 2025 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102280; cv=fail; b=HftiW4iCTBSaLP6DIkAI4b5N95qhtwBTMHjBOd66RNhTpIHQvSPNy88YvJYK/LZxs0/rEzoQi8cAUIskbJ5Vx1v1fAXD/dpYhs8so3LQrSxY7ojptIJkN17+D4nwnpdm7QmmJuYNAXl+sdNZrF9Ss7/ZNTQiduy4mmlsm0y7N5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102280; c=relaxed/simple;
	bh=YRP132taWkgNyQYz86N1X9emhm2FTHuW0+suYCJwSRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8jNk0dgl0EqvE9TDxyDU73j6bG+k8aFzNT4FnbHe8CsH0LVhZ/qbavu9wY0dz39IX50VbulZ370RDFLa9gQ70IHHn5DC4SqgMY0j8YTcJelDMgpBmLB93CdN2RVdtLa6jiwFYrSX2Gi77bV1nQfp2KXb5IUdYFL/6OygjxdjQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=XlcF9KHe; arc=fail smtp.client-ip=40.107.159.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/XXBxFmOfF6aPqvL6ml/DmJEGRp79jjeF7MEpBMCrEG7aU06wRhmFADh9h7BDeDBhOOAbNtbTttXx6a0ijCkuNRyDJG6vHRq/r3f/v2HAE/9a26UUdC/q526zzoqDoFwBzzZx314pRti/xXMwweDLp5NzfRLoE9aSAMKtys0G/gnEl3it7g7oeK/liWLS494E2La9RPbJmCKDR+exmNMC2tSI2T72TEaSPr8+mp5F8wvuthjjGzvsxlgZWclPbWxd24QHl6A9EwxIe0Wy1uJeC2fMjVYjmhHg+rLGf5JSWcwhTwrzNu46Ot+ZNUUN/IwRwWIc3pZEYRgnws9+cDqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCg2EMw2XRkq8ZGaAjDIJbN0lRmhdEsGo54KVZzooZ4=;
 b=Ic8uGA4MCtyazQWcYmwtc6B+B8DY9+B8QQuQ2T27CvgSvYemGZd8BqBU2OnNIrwXhs3hLMZkfj4mGiSEcmIDsuGLha2OPuYa2XZ8nZ+N4kA/3NiVzA+WK30n9TjC6gckxe85OvCe5yc98hEZAM2Hz9AtfqYwH32iDar55sp37+DTeWoTpYNVD8SKT95D+Y4ajsDj8qQVhg84DDr8C0SgTP0JyPeJ7K/h16J0GXXM8OgAy+//O6Lryeysdt6jiGdif0HP45+Ls4Qr3NilKCieugtuv+Fr/4qlwjYKj9XHxJlSlrWcbi0Qv0f0BYXWwTWtOSfjJOVVjOZnjj2VngYdag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCg2EMw2XRkq8ZGaAjDIJbN0lRmhdEsGo54KVZzooZ4=;
 b=XlcF9KHeg9jzXjZw5aJV9DIp0I4xwzQHQR2gVTEZR1IizHsTWLTZuR/6ecbsOj/NHj9YsKg+idZSlUgC++aYr7ulLntvDOndG97dkzMMsOE/lGUK5P8aDo/t3GMycc3VhkPxh9ruRDZb9vvmztL6g1B0lUiobohCVuJ5eBA/CwA96aYFV4XYzu2LE09JOFmQ87z+Fo/xaZ8C/c6xrX5oNc08YUOwAiWfxVXfJ2RHR+/Lzr7VS8ezlWy2rE7pMWRV95SpYw8qxHH/cVKYODP+j5vjejcmifEwk0jmuUi8tPb9NgQ3aNzSksAqF+XAf9zRPvVTd2SJ6fzrfS6DeNXI9w==
Received: from CWLP265CA0283.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::31)
 by AM7PR07MB6529.eurprd07.prod.outlook.com (2603:10a6:20b:1a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 13:17:55 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::f8) by CWLP265CA0283.outlook.office365.com
 (2603:10a6:401:5c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 13:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Fri, 10 Oct 2025 13:17:54 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 3B7B51C003D;
	Fri, 10 Oct 2025 16:17:53 +0300 (EEST)
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
Subject: [PATCH v4 net-next 13/13] tcp: accecn: enable AccECN
Date: Fri, 10 Oct 2025 15:17:27 +0200
Message-Id: <20251010131727.55196-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000041:EE_|AM7PR07MB6529:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c078bdfb-bcf1-4edd-ef81-08de07ff6c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tnqm4wOnk9zUC0YELhkCnD46fmSh1mT+l2/PkNQ+8pe5cIeCHXzx5C/XCJWM?=
 =?us-ascii?Q?6FPHjfJQWbS0ubU1T1qwaIFE+AyNkxiQ5DPdU/hffC5yVIDMiAbMRtw1J70i?=
 =?us-ascii?Q?AMJc6QvGtA1hKm0FDEZDsUjoncx7eG/e8e9MrV1kqfpj0kBaw+R0me+vSjlk?=
 =?us-ascii?Q?vZOje/ZfmHrV0mmnjCCWtz4XhrsuzlTtr10vLecatQ0LiWI2Nm7XwItlfOGA?=
 =?us-ascii?Q?d00B/JcEsxndmt8rH+UuSvYQacQQUXnTcntKBEvcx/PvEagW4B9ZZP1qOVOY?=
 =?us-ascii?Q?oZ+9Ijz/ik/VxPYHTIGDV7kQ9R2UzgRbIC8QKgwwISgyXF8jZK9ma17le9lA?=
 =?us-ascii?Q?CfJKIO7kLnhSn7UvArMoPrA5lc35GpYEltuye+NW0lmaqPQzMJhbDT8a4Ryz?=
 =?us-ascii?Q?JxIID/aUh3591wSa8eL0CSMfsvQ+Kdc+RGNgKkesS+AgdFvMQIEDV0+2me2U?=
 =?us-ascii?Q?PSyJLx2hFbc23bIVmIIH3InngSZx/ctDDKOCQm5YF5TnyoyMj5poS14rEXcK?=
 =?us-ascii?Q?w0ycTVmTsOJ3OI3b8J+0X+1Xl+kGjdceysg1/tAbm+vq3O4k7P/UUho1pyL+?=
 =?us-ascii?Q?sbvQYCcvmg34gu0v08soZ0NaVZWjF+mEN7MOcfCmaKN5r55fNRXXgxW3mswl?=
 =?us-ascii?Q?HfHJahWc/VFQ+LVcx3oTzWLOEKrNWaVZ2mEc2UzG1NOPECOEehQ4cnYloEjW?=
 =?us-ascii?Q?Y+dS8WyDUhgiRwT4CpFW6OuldQzw0NgpZzbkAOpq1CrFuXXiI0yiiazjiQqR?=
 =?us-ascii?Q?G8YREEaHiVEhgzth/2jDyS7fGUHfRBEaT+iPcoe6cHss/QWAI0b19a45dY5R?=
 =?us-ascii?Q?XAwv9JV6TKXB+L72FCljviQbfGAJ6IkGJWv286XG9ODbWzJPDO3IEPSEm6Ur?=
 =?us-ascii?Q?yufjJIVerxJ9z5ih1CoesZj9dD6/x3ngfobkB1/96GTqQnI7poqysVpGdNmo?=
 =?us-ascii?Q?i9FTsd8kwG2t8f5QO9Bnf0k2Z6ObuIk2TkFGop65ZSp1ecxe16ZX2WSzVwV6?=
 =?us-ascii?Q?g6hSO4GG4TB9l+G5iTfz9X3S/j/IqGbVwFmqC0RPm7W7bykQkOIUv5pWuNWL?=
 =?us-ascii?Q?EYANC2oXA462kwOXE1IsQn8CPpK40oQZVALor08sWWQ4kzWj3JTHrGfy98Pn?=
 =?us-ascii?Q?qRxtpgP6r1r1tQzwaKYtGDgR53IURep6qTrdp7EOu1gE/ENAcjluJw0n9uyF?=
 =?us-ascii?Q?UDeGuIc4VovZEg84YvwiigkPLbv+O9v/c0rGT58nPHyHWLWew/J3iuV0cG8Y?=
 =?us-ascii?Q?jGXS8ebsvxHS2vEbuKIuyaFlir0KKXYdv82V2V1U2FTqe0GeBRQT/DiPPVcN?=
 =?us-ascii?Q?NtI/p2rRVx7jRoXH+4TVQmsZbvURMD3p3R9gHZMXz5Pvwgrz5ZY/Qatz/F5Y?=
 =?us-ascii?Q?9H1PdzUq4IMKNHBrmFqMJbDk7rZVOo0dGcp56U/f0Nu3tdF2JSAKJ2AHLlsc?=
 =?us-ascii?Q?/lZ9WB3KCT2RuyQuwWs0GZycktxLSQSZkNnJY7+dahZouMctAT7JDfEOGtvb?=
 =?us-ascii?Q?BOYp8fQlPJut1xY98/7j4Mexc3/DoIJTGTXJMZRIRhJVFsJPyoM2TNF7bJjf?=
 =?us-ascii?Q?Lq0bfNsJ7uhl5uUUjzrXlMll0wN8p5qo+f9rIXvb?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 13:17:54.7455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c078bdfb-bcf1-4edd-ef81-08de07ff6c4b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6529

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Enable Accurate ECN negotiation and request for incoming and
outgoing connection by setting sysctl_tcp_ecn:

+==============+===========================================+
|              |  Highest ECN variant (Accurate ECN, ECN,  |
|   tcp_ecn    |  or no ECN) to be negotiated & requested  |
|              +---------------------+---------------------+
|              | Incoming connection | Outgoing connection |
+==============+=====================+=====================+
|      0       |        No ECN       |        No ECN       |
|      1       |         ECN         |         ECN         |
|      2       |         ECN         |        No ECN       |
+--------------+---------------------+---------------------+
|      3       |     Accurate ECN    |     Accurate ECN    |
|      4       |     Accurate ECN    |         ECN         |
|      5       |     Accurate ECN    |        No ECN       |
+==============+=====================+=====================+

Refer Documentation/networking/ip-sysctl.rst for more details.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/sysctl_net_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 91a90c34a810..9072584e6617 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -47,7 +47,7 @@ static unsigned int udp_child_hash_entries_max = UDP_HTABLE_SIZE_MAX;
 static int tcp_plb_max_rounds = 31;
 static int tcp_plb_max_cong_thresh = 256;
 static unsigned int tcp_tw_reuse_delay_max = TCP_PAWS_MSL * MSEC_PER_SEC;
-static int tcp_ecn_mode_max = 2;
+static int tcp_ecn_mode_max = 5;
 
 /* obsolete */
 static int sysctl_tcp_low_latency __read_mostly;
-- 
2.34.1


