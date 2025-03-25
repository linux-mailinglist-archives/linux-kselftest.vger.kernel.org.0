Return-Path: <linux-kselftest+bounces-29760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A377A7042B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 15:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1123A7547
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 14:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08139257AC9;
	Tue, 25 Mar 2025 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="AnIvuOts"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6441DE3D9;
	Tue, 25 Mar 2025 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914039; cv=fail; b=gzO6ePFzekOBC4pCVigTW4lnadNwZl6nEqmu6Y5/06AeCXtYdt6ncP0NHiKa8hqnvbE93HAp23FO8fUrsM/hj+kHbQSnpRBMx8M1+lAZPAo45+E2bRt/a+OUCce9IagAoEBSE7t76o7XneEzihRPhjYlJeJp4le+pfD1hlFOMCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914039; c=relaxed/simple;
	bh=4sgpQ7f4I3yUANtvVpOPWHyCFoHGvRHomTsAc5RHcF8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ob6zzf1NaX7OgT+Z3MTaUam3R1eHsoFBQNRQ45uPkmSNtw+N02qJVghEEMPT+WoZ40XYZk/FFIP1ImBwMaxFAbVsUlG5VZtM6faQ5zy5xLhn3R3sKNAS7tailzMm4h9ENpopEw0ZmfsjBO0vn5BnvearDo/WKwnSO7xO7hetZqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=AnIvuOts; arc=fail smtp.client-ip=40.107.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usOzQKKAbnnxa7UzcnAqLK4VCwE3frVF/rQTocjFePDuRVfAp8ARPGLVK7pNJBAs3Th9DjHDpU84Gc83iSJ4ZGTZRr35ne0isyM373cXFGs8NiLRMZQCTYnb/OR9vpgMEJrRbvxYaCdBs1+BxRqGK8Jp4GdcvEngfly8IG5HyU0oDmlGCPo2DLYR+TEMgjF4UNaCc6tXm4rsRKFz8gQoAbmihf+AnTc9fhfujjwjtuuU4DHt487qbV6Wv6Q7XTeubYnwJSfyI5fxHgMcuh92zRTKyK80ZcXSbZOOtycyWqAXdsGwCLAKQOEVJNzYlGlQ4EFNxuwThKh9qD33B9/Tlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOExgHc3dICviRF58uoTasWU3DOp9GwRx1JceNTDDqw=;
 b=CzosL7V1DlT7OU4FaNsVerExSHspK5P+5TrO1En5gFGV8Yv20ZRuY1DvwKYc28hzGcL8EgTlyKUcGG03Inmb29M/rSVE2rSXYgv7W/XPRzIR96v+zEMCbzlRcrUiIf2jXX/6IaITNUcCFyBUQgI8sxBFzZBthyGolUSqx7SpKcaUuBySBjRMTYjPerSWr7Y8n9ttaS9dq6nsxdG7DopUSKjV8Sh8uixxaUZy7vlbzbM7obcQrQCTVhklCFfjCJ/HKK4ZmHEQgGdoXdu68EYbCbbsin+H0jjV8BDwoqeLswrO5HjMpc/4loIHfgSOqErjTTMKkLorfc+i9H/UCTXUCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOExgHc3dICviRF58uoTasWU3DOp9GwRx1JceNTDDqw=;
 b=AnIvuOts5/c1ZI+Khxoa97PKl9FS4xHZerhW1LmFKc97b1Xv2eqdsMruCj8LA3BlqqLkAAvmVXNCwab5AFJA6MCNS45l2/OxzacwALmmbX3BdUsTiB0I+doizcQ1iMcmAEmOEkl2UgQpVNt7MxGE9+0Du08K1ykKdq6c2tSdNGSpPcp/DC5As9Qhz7uuMPTlVFh5wPvAdlGRZisn7oIsgsIs8ypBsZEe+Etw8rh7jwEYcr8VeQ5tr1hio7D9eTZzsuE2SafRDq9OgKnhacx15X5KQVzjXtVkrFwX5i52sWzTCkInEKkXzrPMMzZkm7Ovi88NYvk92lUsyLUriJaDJw==
Received: from AS4P250CA0008.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::9)
 by DBBPR07MB7644.eurprd07.prod.outlook.com (2603:10a6:10:1eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 14:47:11 +0000
Received: from AMS1EPF0000004B.eurprd04.prod.outlook.com
 (2603:10a6:20b:5df:cafe::dd) by AS4P250CA0008.outlook.office365.com
 (2603:10a6:20b:5df::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 14:47:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AMS1EPF0000004B.mail.protection.outlook.com (10.167.16.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Tue, 25 Mar 2025 14:47:10 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 25D63201D1;
	Tue, 25 Mar 2025 16:47:09 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org,
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
Subject: [PATCH v5 iproute2-next 0/1] DualPI2 iproute2 patch
Date: Tue, 25 Mar 2025 15:47:06 +0100
Message-Id: <20250325144707.47238-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004B:EE_|DBBPR07MB7644:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4abeed98-b474-4473-332d-08dd6babec68
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?0kUnX5u4IN9lx/iAyxvaxlxhB5Hpi1LAr4R74deTCEHRAkjIzwoiOzgIV3sT?=
 =?us-ascii?Q?p++1FVBhByHLJTvWvy98THvRc721BjOvjkYkq6k0W0zQUqHe6Z6mEadiYbCd?=
 =?us-ascii?Q?zuj8PBxmb0gFv16u7asYr55al/O2ytnw7EL8D1DeiDtVN47xRxjHlZlQc253?=
 =?us-ascii?Q?kBo9JCEeaO8slP7ZzaDtYGwEaPyKHTzdBqkSlsgY9egEGXRGYDjL5B6X1wSI?=
 =?us-ascii?Q?5sHXQperGplMsVRWtwszIeRl68AJOMh8qqg0hR83OsDpE+wf13+SixLY/Ks7?=
 =?us-ascii?Q?Agj8Fr48d86/+VB0fKHKGNKY2l9qfBRLmifJbG4ghLuyQBXjzRirXZJIC0TG?=
 =?us-ascii?Q?BWNHLCRrSXkaqkNSGR00Z5zkb9qnQ+1FLYRsEnpbrkarjQZzzVxK+hf7WvjA?=
 =?us-ascii?Q?h17ocshHWdRo1OY66aVBNcz6DcSnNO8PNJz7r6F6qbuXKsZMtOuH1cwyYGte?=
 =?us-ascii?Q?bG6DyYuk0zXzaPYzcz3dPkDFL1rpetUYiqFsXiW4YIk7ugSRANmHKUE7XTVg?=
 =?us-ascii?Q?EDR12vdVxZv45pVEaNTbGHRYJx8HB5iq2GFwuu631BakudJ/+iLlImI+c4yo?=
 =?us-ascii?Q?75+4wI8kKeGpMfxUDIWPMGTEkFIhLcs6uLV/JfdcyAQ0IZsjiTTIYJBNtx4K?=
 =?us-ascii?Q?dmLnxEblEerbf/RQUZX3lOExQbrOUX8FM6ZnLBSvHzgTnMviZPMtA4U/ckV1?=
 =?us-ascii?Q?KAtow/g8EsCKiZczSJG01cPJi3PHkfPxr899hC3Jtt4OpUUY33AtMIqgWhrr?=
 =?us-ascii?Q?wxYgEA9PYsllgXABK6EMX2083VCYqI1LcKn3bOWR7RrmevFqZHbTScBCrQCc?=
 =?us-ascii?Q?uOJ/o+9qgXP2OkMy4Mie8Zh/BEneCZa5qd9+Y5mnIrtqrETwfYZQ1RwH+/6B?=
 =?us-ascii?Q?Xb8dxe4zstigq8fFWAIFKFvsXeb9Jg7yIUlgHCfn5VQr6y7YlFtjXqCbbDX0?=
 =?us-ascii?Q?vTAXinjkre2sIvZvYtIEBjgvr7tIdyP59hUwD3VDzoSchFeaUfPW2JmQ99rT?=
 =?us-ascii?Q?k04eyqrlA2m1tzMDRV2x4h+pzK0V6Ji3kP1x4wg5DhSpAbVdGKbas9hTwIkn?=
 =?us-ascii?Q?/u7x1QlwTg0Y/o0HKlxNR7J+/pW+bWPJQsdwruPEla7CMXQWTBQosEGUUtJN?=
 =?us-ascii?Q?oIMKF+SNAK8XKDTrLDrxs8TYe4yVAJaHE4ZP1yfg2FYcayVNfXMLb6lEhH7x?=
 =?us-ascii?Q?sAofc7iDVhYEtDmbrxSoTiKz3hb1GjqwKBrJ5gaa8767aif2GFuTyao0/9mp?=
 =?us-ascii?Q?Efqg4RcY28wGlDQtiSYDO/BZO1WHUtCGG+BDA3TVe1qYi9YQBHb6re/J8Ivp?=
 =?us-ascii?Q?do0CrKCZAwn0RWsDRvYEXETyOOeP3XMpZcqonnWguz4zV9jnwaZdYCAcEtTL?=
 =?us-ascii?Q?f+Gsr06xG1C6g4q8Ye15YSaXlIebcFBg/jNEkLwGndanMf6/EX91c12yQlGq?=
 =?us-ascii?Q?HuPuJlNaPQngeVxSRoUQ/BxDHl/V/gzX9CNMb2vVKekryeTtWaReA887OLOJ?=
 =?us-ascii?Q?Zax+OZNHkGxmXWKrINdAmsXWK67KY6MQgtfQNzDHeMS01Mn1K70XGy32Id1h?=
 =?us-ascii?Q?BTKz38B6JfPHkgEwGEY=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:47:10.5528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abeed98-b474-4473-332d-08dd6babec68
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7644

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find DUALPI2 iproute2 patch v4.

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
 include/uapi/linux/pkt_sched.h |  39 +++
 include/utils.h                |   2 +
 ip/iplink_can.c                |  14 -
 lib/utils.c                    |  30 ++
 man/man8/tc-dualpi2.8          | 249 ++++++++++++++++
 tc/Makefile                    |   1 +
 tc/q_dualpi2.c                 | 519 +++++++++++++++++++++++++++++++++
 8 files changed, 850 insertions(+), 15 deletions(-)
 create mode 100644 man/man8/tc-dualpi2.8
 create mode 100644 tc/q_dualpi2.c

-- 
2.34.1


