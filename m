Return-Path: <linux-kselftest+bounces-32328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D035AA8FFC
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 11:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB513A45F3
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 09:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592521F4282;
	Mon,  5 May 2025 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ndIW4Rjb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010053.outbound.protection.outlook.com [52.101.69.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8010F5FB95;
	Mon,  5 May 2025 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746438455; cv=fail; b=mIdde3BvbHw1iZfXHMMtrGac6Zprthj2OWBIMIdwRn8YW7vyusEe/H+xQxRWzbxWL3qolXqlhAOO0VGNHXaXxFzMfvCQF8s+BGLX5z2WELVMAW3Ly30WPi+e9yMs9riNgji+Z5rDagSIHpLRdlnOpEh3Zt9X2s24iyoP2Pws8sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746438455; c=relaxed/simple;
	bh=esjLXGGSKzHJjxm5fD/5psR+zcl6XEQVl7WBOk+LfJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=A2f3bpKyornu1JvPvaIzF+aw7+++k+gtnzeySjTizzpOTbXPB3FH1z1B5Y0DEAxiVDhWyexbholCj5lh6U5Jo73uCLn/MedOW7hjpV2TjTC/IhqNW/Z4tsDdl3rH4AoKt5nwTwLOpSlHYjbMZoH6p55yxlGCeUMpIZRCBhWwelM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ndIW4Rjb; arc=fail smtp.client-ip=52.101.69.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJaiFFeINQbdzGjsjSnR2MHX72KkwIBJ57aF991KGixBOzK5CYS2MFofTALylRuKlWwnlf5BXKsM9iSgD81B+R5OCEAuNaDaQRQp2O/CP7govZcT520FrcGwJqCbYbxPTYcNIX1DPW14UlGemku29TzMAoDmE78JXKk8Eqr7TxPWpq4Y6mC5sVF45WpRDzYx4KYvUER145CUa26DYUKGeJ4ybSi3WOAAgGdhb0CL94KT4VsaeKKX/bKf6uukpEIDA0B7GbEZdg0yOtEVfQkC5URrnnvAUF4mtVM+mP2ckWIITO7z5YvohIDiWEWKMK/LXjhJnIn/r8CMzB7Oq68BcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oagg6owFluYdwVFC66p+X6Wnda3qB1JzHvEJ6o+sNuI=;
 b=YTE5r7BDS3Ktwfh1w6lfIHmIptcy4LpfbwRbwfZZ4g6iSAOu8BtjiuFVcFb7vy+YqXboMS5YkV6/4XbDFConFWu1EXAz/ON7FK4UZjqA//w4q+0X9J+mAAsSk6MbPPR9LSzWw8Hgr3bvTzEygx0DqwenWjQD59f596cvI6nhvTaAQc/MfjPpX/tou1TC+LRHjBWShcCbucKIJ2SVVQuvbHZf1giTx1lWZ5Y2MdAioLqY96gU7Sd6qXfmLtixSrSIPlPVJ7gvdgLtttTafD4KVEfRZBx1q9fb5HErQKaJr7B7S0hljjO9aAOtApD4WibPqGCxFurGKylk8HAz3cAdFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oagg6owFluYdwVFC66p+X6Wnda3qB1JzHvEJ6o+sNuI=;
 b=ndIW4RjbNn2axAF900+7WaSxD7kQTdVvVB167I0wycg4HavlHiFZ2gySTLYnH3owdW+AGyXbBUrIGbVwIitAU5EPyiz1qeOWtbHxPsqk24TIkEiAyd2BUPXyhDBhHHaRk0KgwE20TADyat9EmkDQieOvI1zlnx9Dns+tMEvlxV/FQ7E8baduoVj2hy543acpRcldWD+lF5D0S/5PBo2Z6H407mo0PSN+qEbqMwMuooQRLgug3os+o5ODyDVP+MokQDhL/oQt0Lgm7fKEKpvdBOL1d8iX/uh7BJz9VrqFPV/M0wzfrk02s1Gia/yICetMqNCUNo2I85/Hzxod1KPdPw==
Received: from DB6PR0301CA0067.eurprd03.prod.outlook.com (2603:10a6:6:30::14)
 by DB8PR07MB6377.eurprd07.prod.outlook.com (2603:10a6:10:138::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 09:47:27 +0000
Received: from DB5PEPF00014B8E.eurprd02.prod.outlook.com
 (2603:10a6:6:30:cafe::ea) by DB6PR0301CA0067.outlook.office365.com
 (2603:10a6:6:30::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.26 via Frontend Transport; Mon,
 5 May 2025 09:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB5PEPF00014B8E.mail.protection.outlook.com (10.167.8.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Mon, 5 May 2025 09:47:27 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 4A9102011D;
	Mon,  5 May 2025 12:47:26 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: donald.hunter@gmail.com,
	xandfury@gmail.com,
	netdev@vger.kernel.org,
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
Subject: [PATCH v7 iproute2-next 0/1] DUALPI2 iproute2 patch
Date: Mon,  5 May 2025 11:47:16 +0200
Message-Id: <20250505094717.7177-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8E:EE_|DB8PR07MB6377:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 42778205-6289-4988-0a2e-08dd8bb9d8b6
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?c3fkMk64r+QG7Cs8mhpk0bJFjeaE0YkmUCzQ6/cJPUmwUkTVk8Gxk/9CkhLt?=
 =?us-ascii?Q?qP6IdfZyCh75hbiq3T2K13jyx4dJKqO9cyr3ZUcg8GTMXmANJmxwi3rBptdf?=
 =?us-ascii?Q?5k4S01LHER1QiDaI0DHt2GZqm3xBkBS+40cHaiieTmIboRJSO/iIw4K9wTLG?=
 =?us-ascii?Q?pTGgtER4a+Wq9sBEOMfnWzLoU4Rc+VU6rCTI90jUhVFo+KEXh+FNLnkB+Pzt?=
 =?us-ascii?Q?oul9XusRc6Oi0PnfCJVF6QYUFeLh4RKXSXZM/uqPDCVtOWzcBmWW4VtGHz7R?=
 =?us-ascii?Q?ht0w68dfn+iiyoi2YomEmOQnEiQPkIV5eZZ+5v07zwLmBt5ZvMMGtj19Zrn9?=
 =?us-ascii?Q?skGX1JQx+altQ3kzyOcjB+tRcCeg2v1Acs6qccDYvhz6AUqzk8cOMTZJwpTx?=
 =?us-ascii?Q?wna0ahnpv2svsHL3k9CtlwXxo5DqhNs/4XbuJq1n6FWxpTTtXdHYLxfEwE9x?=
 =?us-ascii?Q?CYexef3m/r+45wPaUBBDBQS7aWJPFkhpAJiSMNdFvh4UJfZobhh/ugv+q/FC?=
 =?us-ascii?Q?bMn6h/YfsuyyPsFJmNHsq1K4+zEvMSkOWyne/s4AmxetxYG4oxVxWHryjoQV?=
 =?us-ascii?Q?5LRH1R0F62xvnMPd/19mDs97XZhH7LZ+Mlz9rDIG/lILoYUs0dIXKUFMmCB4?=
 =?us-ascii?Q?waUvGgpipef6PikeQJ0KIdD0/iwozCa2xT3j3twiL1VXmeWN5MaZefDXfDoU?=
 =?us-ascii?Q?4hXzeSw9xlg1+eCmxb/C8dZZ34UXG8BYFsYCu1J1yFzALkFGXILERNSie7a9?=
 =?us-ascii?Q?Jy1cmG3ZlId2Cks4j3G5WXUEYK89eg5CIbkdgTfGjcA4YP9C/AOd6SfdCHD/?=
 =?us-ascii?Q?O9fH+f1D5eUxLfIL4EmYLwgSw2NpYb98TmL168ot4Ml6c0+zssufJrRpWNRp?=
 =?us-ascii?Q?MFtJRnb/dlAT/2PtJdIwZoPAZhDb14ko7IocKB62xyVNpC9dxaEcfPKSJxdN?=
 =?us-ascii?Q?ubS0Qf409UrAQXpijvM1RPJjSXtUgp1rxAIRHimkIKrJqRECj29SVQgnCaqO?=
 =?us-ascii?Q?rUd1137cfRftBvXenLSzKJVFZ7qth6zTvLcwa37rICxSUCoRMN34k/zSel/m?=
 =?us-ascii?Q?PwrNoKVpqU92xjndjblTRx5SY9bYJvj02SFvsAl/UtRgeq8cIniWU28z+bZu?=
 =?us-ascii?Q?8qv5+9ygv9yOICs5i4c00LuDgh+VCR/mQW4FRGucqoJJyNWQiId1HBSm1cDJ?=
 =?us-ascii?Q?3UZpf1oW3UNxyTUe/Ddh/qNsUAAzEx6QkLzix65nICJxfkdVrQXyBPMSlbKN?=
 =?us-ascii?Q?CkagbQuc2U10vMqFF6zq14TzxZn4hXdTOhsrkFrgjgjgWk1A5Ac/5N/YEAmu?=
 =?us-ascii?Q?VIzpY4Zf+RWBUcueVkTw7fJdpRnVOIhHSKOJO6Gbu9hczszAxA4WcMMX5Y4Y?=
 =?us-ascii?Q?iXHy6C35UZv8ZYbtFYq6wQ76kHe+tX2pOI/0Patd8Xg80PND3penBgOroJ7h?=
 =?us-ascii?Q?pg5foujRMewui+n4uryeO36F88dB0U/80YQ4P6UOGM61P1HLrcjBG4FZANR7?=
 =?us-ascii?Q?PviOR5vjda438FkcaCbkm72IPEhbuU5AR0FxW7tu681Hg7UqTeb94p/JgQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 09:47:27.6454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42778205-6289-4988-0a2e-08dd8bb9d8b6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6377

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find DUALPI2 iproute2 patch v7.

v7 (05-May-25)
- Align pkt_sched.h with the v14 version of net-next due to spec modificiaotn in tc.yaml
- Reorganize dualpi2_print_opt() to match the order in tc.yaml
- Remove credit-queue in PRINT_JSON

v6 (26-Apr-25)
- Update JSON file output due to spec modifiocation in tc.yaml of net-next

v5 (25-Mar-25)
- Use matches() to replace current strcmp() (Stephen Hemminger <stephen@networkplumber.org>)
- Use general parse_percent() for handling scaled percentage values (Stephen Hemminger <stephen@networkplumber.org>)
- Add print function for JSON of dualpi2 stats (Stephen Hemminger <stephen@networkplumber.org>)

v4 (16-Mar-25)
- Add min_qlen_step to dualpi2 attribute as the minimum queue length in number of packets in the L-queue to start step amrking.

v3 (21-Feb-25)
- Add memlimit to dualpi2 attribute, and add memory_used, max_memory_used, memory_limit in dualpi2 stats (Dave Taht <dave.taht@gmail.com>)
- Update manual to align latest implementation and clarify the queue naming and default unit
- Use common "get_scaled_alpha_beta" and clean print_opt for Dualpi2

v2 (23-Oct-24)
- Rename get_float in dualpi2 to get_float_min_max in utils.c
- Move get_float from iplink_can.c in utils.c (Stephen Hemminger <stephen@networkplumber.org>)
- Add print function for JSON of dualpi2 (Stephen Hemminger <stephen@networkplumber.org>)

For more details of DualPI2, plesae refer IETF RFC9332
(https://datatracker.ietf.org/doc/html/rfc9332).

Best Regards,
Chia-Yu

Chia-Yu Chang (1):
  tc: add dualpi2 scheduler module

 bash-completion/tc             |  11 +-
 include/uapi/linux/pkt_sched.h |  67 +++++
 include/utils.h                |   2 +
 ip/iplink_can.c                |  14 -
 lib/utils.c                    |  30 ++
 man/man8/tc-dualpi2.8          | 249 ++++++++++++++++
 tc/Makefile                    |   1 +
 tc/q_dualpi2.c                 | 528 +++++++++++++++++++++++++++++++++
 8 files changed, 887 insertions(+), 15 deletions(-)
 create mode 100644 man/man8/tc-dualpi2.8
 create mode 100644 tc/q_dualpi2.c

-- 
2.34.1


