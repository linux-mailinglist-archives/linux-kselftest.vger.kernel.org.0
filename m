Return-Path: <linux-kselftest+bounces-41882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D10DFB86005
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDA27C6A66
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81893112B3;
	Thu, 18 Sep 2025 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="OnI0LYyZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD1431BC80;
	Thu, 18 Sep 2025 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212529; cv=fail; b=LE75rCeovPY9mA18Fk/hpJzB8fI4KzucYrW1ltgceVu6/kMRuSls2PjqaO988pnoNArJrOmP1JAr/FPuBsbZSy33D5fUg2pIeKLpFlXCjuILb3EW2cVishMX6ovex+0fxQuT/3QQbbr6niNEM+M3BtwbYmDzb481Szn+mZ8vYtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212529; c=relaxed/simple;
	bh=KTBsrRS6D/43oWkxJJXk7PDL01xGj6ILj/9SxXVFdBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APpQ/Ge8mdEIT0SLW/tKqC8qw0KJrwYuRXdviCSBHaM/vMuhH80iWrVzJZ1u3O0ZNT37YIKUtMzMuz5IDSg5diLbaEXnqavfB1WwellMQHoIoPVmpFRtCCMUvyQSH6ZLHc/i97ReWnTkBkK5MSRPrejOkqjS5qsQIpHIoqn9bEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=OnI0LYyZ; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LS/FmMOmK7+XBjXNzqa6MHsHmEB18/19yoy/E6SfgZvhZZY3VOp6C1xxq7qu3YjRQWdI3Wg2Hzcba5p2ALPQZGmPaopd6fpChT/anyMvfGcWxgeagTYh9xxy5DyohXEfEcWinCuozlJLjTlS9J5O0i93YEwTBqFsfsX+jmmXcegRpVWUn06yWk9Slui1hOq+bYRW3jhlkC8eYi1kR2Lk44eqtutltOwbE2v1qR1GqEPIeqymsDZpYYONY6lQlOidBHOkFfnKg7TtETYtvKLc5sV7ccqjgpqqjFlLdAZ+8qvRoKRlqHHWM3edbpTIde3SQzozttoph81NFz4p1QcQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsoIhmFoB+0bvj05Al5hGf7EtssXfY7zXNkjoPQM4JM=;
 b=Ec6sDh+vvMwJ1DL1bUOmTX0vhjRfRnB5Eb66HbvHvRH+ojQeKbOO/tiDnRQ02oXr/HmD5nVeMDjza3dpPZdcqaSKgM67UkJ+9lRx+WSCh/8w4dUSm60iXu7HOlgIztu9NM46KGYTnJiR0k3gPHPR2Uax65cLKxWppcKyOA11oQEHzVakKWZ4Ok9SjntD8lTtH230pi0RQZBjw/GPYcDhho50CCIv1G6pcZzhZzrigR8q1Joe2cu7TKu8Li19yrkTiFuUmulEco6/Vice6mvLdowtB2HfCEf0eQJO0djrtYu0Hefafyj+YpvYpZI5sO4FeVX8jyyxC78QGgn5UvJtPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsoIhmFoB+0bvj05Al5hGf7EtssXfY7zXNkjoPQM4JM=;
 b=OnI0LYyZXw25LdZzGoHDlespBbO73Xp1dF13EJ2l9CHjQviNzW/4RQ6cnDdjza8PPM+8O91hjqCY4TLxGWt/545NE3QqA3dcY4+3TKlOqMWHRUQmMT3YWiCATTkXXSHyHlKEAIT0U2OJDBrVWTOhqE5D+gsR8Tf2JyKguLmTsUA7ZqA0jZuEkoj97fnTJpRJk010THMD3HpqXKiS9L1oQ62pX4OeBni1R8I8Pv5/9IGl4hSsc8hNdi1vN9S4ZUijp0p3z2GxdjbM76i0zVzMdiT8C0lP+RJC06WDOF5Qb0ssTEQxZsOHhaUgwu2BP/+iKNIaKA5j3BO7MK7XbVMPNg==
Received: from DUZPR01CA0240.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::8) by AS5PR07MB10306.eurprd07.prod.outlook.com
 (2603:10a6:20b:6c8::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 16:22:03 +0000
Received: from DU6PEPF00009529.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::79) by DUZPR01CA0240.outlook.office365.com
 (2603:10a6:10:4b5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 16:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU6PEPF00009529.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via
 Frontend Transport; Thu, 18 Sep 2025 16:22:03 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 9FA5A20833;
	Thu, 18 Sep 2025 19:22:01 +0300 (EEST)
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
Subject: [PATCH v2 net-next 14/14] tcp: accecn: enable AccECN
Date: Thu, 18 Sep 2025 18:21:33 +0200
Message-Id: <20250918162133.111922-15-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009529:EE_|AS5PR07MB10306:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e109e35a-5380-489c-d2c8-08ddf6cf808e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HmQu9nMJHrsp4BksM5aPmxCnKVywaICf+P7Pjf7cpw74eTtXxGnDaN1jtmsx?=
 =?us-ascii?Q?I1RicGYDx2eRqxQcvbGCDte1/t6THCDZ8F7HDREThiRGtostaoKIwwtRN2Co?=
 =?us-ascii?Q?K/u8nrm2TFy9mWWHC9Bcp0YfdW53WjiP9u2PRXkEMUMhWtL1qujoYVflhjcM?=
 =?us-ascii?Q?a+qWPax4BqdFS1P7BBPb47YTiRUy5XWkxP2ImOR8c1Rt8icVEhSd2IhcFujB?=
 =?us-ascii?Q?ZKQV5RAcK3cMCGx0QgbNBDmPMlJFpZOYfaRc/RXMzRwyGlO7mbVyKcy9Oe9/?=
 =?us-ascii?Q?ZcqHWKOui1htxumHR+B3BztXpuR7I1JoQiZIgEzxRUcRcj0axADjYZFfO7CB?=
 =?us-ascii?Q?EHeK8dRxpQfanW1ZPuGn/2AlBegqxmxKCiWLh6KsVvI3mBrPZEocXfQPn00z?=
 =?us-ascii?Q?ZFfnmqOyPbqnPvS27ZXtUHj3cI8kHFwckUGD4QIhJaTQc5aKh6BnIbQtOAkl?=
 =?us-ascii?Q?yoCrQd5gzJZgfClMSfg+9vOvCMb3fWbf1Wxnj2BKCBWCwcWN7/q+HwNjbOOM?=
 =?us-ascii?Q?1GAw9bBVvznlrXI1vbqPqPVIXcnPJYuLsKKaJayK9CfNpyw/ytDkUWPcEni2?=
 =?us-ascii?Q?BOopV/m2m2mlyFS4xR4h0zn7HSFYMWnCP4LPU13grkY9lZmQr2pkQAi+saBw?=
 =?us-ascii?Q?RM7oCP2sbEHM4Zv2wfj93IfAxqlu3oNGyfPnYsbDqLV+wnoxyZXDUKKkgQjq?=
 =?us-ascii?Q?2G7kRg4OgcEjW1blgTP+RkfPThS+K7AkgBdW4hFngRZ+7qUshyYMwKOl8635?=
 =?us-ascii?Q?XQXgHPgDhJglxYY+nuZVVOtC9Niwwd6Mx9rexgapzxIcUA/+d/r4pdPCJ00t?=
 =?us-ascii?Q?lKEnlq5b2q2tZt3Polh1ySEDr2RFfsZ48uFN0ohI9h8A657VAAheR0jMZi2Z?=
 =?us-ascii?Q?qXKoyb76doaOzViE8xK8Jnj4jlEGBV23Q3vqLiVeiY95ODcSCVxFnc1NFkZs?=
 =?us-ascii?Q?DBOwQLrRaN9BBf4MEHFGhQl/HuRtWqyGqBK7AJcdVzCH8+B4w39tPZh07dEK?=
 =?us-ascii?Q?57oILvwVEx+HRSs0gp7v1DOyVUJoXMwLJS9aBtp1xAK5d5WpVlhK7OPeEABV?=
 =?us-ascii?Q?q8kWNY7AmlfUp5ToV5h9MDwkqyhVJJt5pXJNksg/P136TJZmBOsuWnFBUPZg?=
 =?us-ascii?Q?mwTz/jbkq6O61/BkzgxkFgcbG+joSEOSaMI9UosP8LgGTNM96rmGuughJSzT?=
 =?us-ascii?Q?OaHQ/BbupWNgbyS0Zzt/B8zuOXNveOLfjcksYbCAm/FrZPN5efqmStwtm4Rf?=
 =?us-ascii?Q?+2f5ARzReEG0i4upJXvYd+S3OWcAlQwg1H8QlOsYNEk2Z2CylDp7nAiceYhO?=
 =?us-ascii?Q?KZX9Ytdns1SmHiXi5p+66XyKsmdU46/CBGcen1/kw5F0SN0OE1JqH2lS31MR?=
 =?us-ascii?Q?x6KwJBbZVseYUfoCXAtJwaDPHSPPV9eJf/uigkOvxNeoDny8oTd68NxN6nIn?=
 =?us-ascii?Q?0LYL3Eha1IlnD5rCQjD7T53iHxdtAS3NPcwrZKL/5arPSKwehpQTY9iuziO5?=
 =?us-ascii?Q?OaKcaO4Kvag9xyyDRze0Z8IoNRZSw7waowWoYVFXRz51QSE+9w/mVgM/dw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:22:03.1185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e109e35a-5380-489c-d2c8-08ddf6cf808e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10306

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
index 24dbc603cc44..169a393374b3 100644
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


