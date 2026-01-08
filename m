Return-Path: <linux-kselftest+bounces-48540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A85C2D043FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 17:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48F52355672B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 16:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F2B2459DD;
	Thu,  8 Jan 2026 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="S58GSUXc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011025.outbound.protection.outlook.com [40.107.130.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B05231832;
	Thu,  8 Jan 2026 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887914; cv=fail; b=A60AJcvwqA4D7hCJKWfKNB5S4fXQUGcofkcoJ6xDzbPr08/PSx2Xd5ldYreLCyB3LyWM66PlXArQCrymmBl2W3HgkrheRGcmik98nhPvTD2IyFVsoOhlTaQ9oRvF8cLuxbv3+GKYOA90rS1GX9Ob7f+sJ90bwoR9H6Gnx1WrbrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887914; c=relaxed/simple;
	bh=i7lEoXz7TSW4dRXeMbNyMn/vJ6vdQ0CWnyNLxEV+u5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FU9suB9tSwyzVzVSDLvymeVPLEbH3g07kYX0ghYtAaX+c7Q/pF3Jy8WK/Lrpis7O6w2oiMC/HDeMG3WqL6atsrgOTrbl5j9kMZ/5v+reKrBcnCfpSXORuwbkgLiICsJhbRyTHeo+fMyxmCfth/MB4eWZKX9+hejhS55N3WH//bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=S58GSUXc; arc=fail smtp.client-ip=40.107.130.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMS1K8J4OAfYYgWDQ/0cNTjZ5b6NBXW59YMo8D8bHelJJH4gS1GGxyn5hKfxXSPqRJNuwaSz95HSpvN3RzkI42roWba92czml+/cGkXxj5QDv670c1ySyDArp26OmcJ8ysL7b7/Yjni4J7/BvwOz4bFMABNtqbiKJbDo9jeYBWHBpSCLHZDdQNKFl91IbtyjfeBbqM+1Hr6tCyMUWBvzFicdMXkBd6y1LhgqXEZgQItfxGtG3vx+J25m3+tYDNGqVhdBPm6gTrZQ9FvfkAs10XUq9okhE+3Fyw1TpW50oB7JKpUG4UxuPHPhWFaXg/eIqgQKS6gvrt4atpWLzdaU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6EA5aKvzcoR+827OFt5Y7Shrc3GqFpd8UR0pdao16U=;
 b=BY9yahli8j2Ll24/bWohXR7ACEF3Nu6AqUOJqbwAcBZjC66wq2DJtr3aAQnYjW2ll5eGuAG97Vn/7nQqwbz2cyPFGZgneHHvDuAAda4ZO7Vmh9DlmPeeIRWI/apqUlTRCvLzJv/qiAmISVsxrUTHe1X82OfmEUG0tQMmXN34L2ZjGU0MgctE+/Qzo67NX3O4Etl8V/YSU/niTbrMJimrgq9eTuSRGjzU8+bwBMq1raPXNl56ao3NVYn7uSV4oF2iHwKxJ9QW9Dsg+lcxG5VWqXYAT9TXISIkTyCV7oRqeHzWvjXqomVoUX7CVafDJaymg74yQWRwCbnG9OJszPr0HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6EA5aKvzcoR+827OFt5Y7Shrc3GqFpd8UR0pdao16U=;
 b=S58GSUXcf/y1hbHGZBMODm0rLSlMoYnx/zcG/tzG3jgTsDTkHcNQFK88iNrtfX8lpeAlBF22P9WJRCvD98Q9aAhs1A0O0P7WTnL8b0+Gw5aXriw2V/nEiMDK12zW/TYMN+GtEsmcDddYw4W74MIpjypWww1WV3RLo/Zk2rof0tSKIc3Tj8JB6c46Qx0ZXwgy9KvJLvo2pku0YnyHJcxw0RyrETfppdzArKIHHYT+Ts0qpi+hNBBXh435XturocdmmUB5o0VwNX3Wbsfk/D1GrWFIzfD4zPqJ+2zANDn1HwB/v7gXYPjHYSOyOxy0XAj4euhllIT3cHg99XRTDwcAGg==
Received: from DB8P191CA0021.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::31)
 by VI1PR07MB6304.eurprd07.prod.outlook.com (2603:10a6:800:142::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 15:58:22 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::a0) by DB8P191CA0021.outlook.office365.com
 (2603:10a6:10:130::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 15:58:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 8 Jan 2026 15:58:22 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id D8B4F20341;
	Thu,  8 Jan 2026 17:58:20 +0200 (EET)
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
Subject: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill cases
Date: Thu,  8 Jan 2026 16:58:16 +0100
Message-Id: <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A01:EE_|VI1PR07MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c20a50-68b7-4830-6141-08de4ecec024
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?a3pUOWVUSE9seW9OK3lvd05nTDVFTFM0QjMwYkw0R3RVajFWdFVGaDJZWmJN?=
 =?utf-8?B?NkF6N1piQVFwTFgxaVlvODNodjRMejFRZTFzVzJtbXFhL2NPVEcrQ3hVVzRI?=
 =?utf-8?B?M0RJc3Q2SUZ1dXJDanYvUTJLRWRYY0p1akdrUGZydVEwS3hvanVhVFNzLzBJ?=
 =?utf-8?B?OFR1SXNOeEdZNkZUSzIwaVJkb0x1dDZZeGNjdFBXWG9vNUhqTGU1cDhRaEs0?=
 =?utf-8?B?MmRWQ05JYWNLdnFqRCtsQXhQVy9DWXNpTlg2eUs5b1l0OFN1SW1TRzJPdTRm?=
 =?utf-8?B?Q2tORm0vQnBLWEtDYTMyTWx6WVk2MkZMVm9tNHIrV3I2eEZVVnJ3ekkxRndF?=
 =?utf-8?B?SnFvRUl4UTdPOFVuTVpuQitFTEpKQk1DRDdUcFI2aE1DQmxiRVZtUVovWnEy?=
 =?utf-8?B?Y1YrVk9zTDFnUk0rOG1yaWN0eTg3dVgzZXlacThuaGdaclJRYzVMNm9FaDRI?=
 =?utf-8?B?Q0JETkg4RnBTbFBhRk85LzErdThaWktXWjJPVkhiMkhWWktpN09kWTA1dVQ0?=
 =?utf-8?B?aFFhR2tRKzJWbDJhZ1lxYmZGTVBlRGdkVDZKZklLN0d0QnFhc2VrTisrU1F2?=
 =?utf-8?B?S0tGNmRkaXVEU05zUnlmM3creUZsdnBpYWFaUDFpMDNHN2VPS3Z0Mm1HQndL?=
 =?utf-8?B?RlVldUVHZURnN1JTc21UL2RwSndIOXRpV1VLRVJONzJBUlN3cktEUjE2S3cx?=
 =?utf-8?B?RzY2bjVpUS83bzFuVERrTG9ZQ2wySFNjNGMrcVBYZEZDU0xtYytyaS9iM2d6?=
 =?utf-8?B?SGNyM3NFMGZiU056eWRGeU9Yc2RGcnd6dVBoMFFDZUZCak56bVI4dzBtS3Fk?=
 =?utf-8?B?UFVjS1ZKZTFCYiszV3VuMElIMC9qbHlSaUwxb1lCUXcyRTRWL21SalhOZmVa?=
 =?utf-8?B?c0lxRmNqbWorWHQyOWt5a1lQZlU4WnRIMnlVQ0F0blE4Q1E5MWpVNkR3Q0xj?=
 =?utf-8?B?cGNUUCtjNmZwdEtEZGJDdWtpWHJJaXdacE96OUdXeXdrb1VBWnpBWVE2dTRH?=
 =?utf-8?B?RTZTMFdqVCtuWUh1UEc3VDJkTVNnUFdVN0tmWlQ2eFVVMDhpNGlzbHFDREZy?=
 =?utf-8?B?SkhHRmplamFMMklJWVd0clA0bFVmOGxTa0VxQnUwY1RYenRqSnEwMzRFQnNK?=
 =?utf-8?B?NFozeVNVVWRDTVVaQmVoYU52aVlxRDg0TCt2dzNRc1doZVdHeG1RbEJOdG9j?=
 =?utf-8?B?TjIvcEhweVVJeXlYVU1JaEg4aUZ4Q244Vi9XSUpVWUgwdGtZbHZEM3ZRWGFw?=
 =?utf-8?B?YUhyYlE2OWF1RTIrRk8zU0tvVG8wUVJRVzRvV0QvWkh5cXpSNmJjR1VpTG5J?=
 =?utf-8?B?UTlCMGVLUXRrWmVSbDZnaEdRdGVyd2hIbG9NMFJmaGpIOTRCREpBSHBXNWdo?=
 =?utf-8?B?YnYydjZlTkdtYlRNa0h0aWNWZkNGUFVGbnRZc1Z2Q1NIb3hrc1NuMVhwRTJx?=
 =?utf-8?B?ZTBMT3pXWFphUzdERjRnUncwNFAwMWdqYzdBbWhKWFlqQ2RjeHZyYmtxME84?=
 =?utf-8?B?eGwxaVJRZU1WbjV4SmdCSUlNUFZEbnpoNkplQVVhSERDcmdabjM5c1I0YzNj?=
 =?utf-8?B?enRoRy9uS0tTTm5KRkFEbWJobjJ1c09OV2dobSsxaWpLTm1uejcwaXZ0a1hL?=
 =?utf-8?B?L0NHc2xNbzY1eDExcEFiZ3dkYTdRYTRVUzN3UjVaTXBXRzRpdzc4VGZKOFBW?=
 =?utf-8?B?Q3NPNXRPUGxpYm00emxsVE5jZ3ZkaXZjMGJIYWNLcndZeHhrMm9Hano2ZTdY?=
 =?utf-8?B?VkdTUjdxQ2h1Rml5S2FSdWZRb1lvK2F4bTV4WDJHcnJtWnU1T1NTOTljZFBh?=
 =?utf-8?B?KzdLMXZyZkdVOWUzUDJybDBNcDYxTWNiRnJrdFZGSStsKzdQZDJ6Tk5GSWpM?=
 =?utf-8?B?bE9VTmU2RmgrN0lCbjVzdjZBeGFrcWFjMThaa3hIY1FOcDV0TE5iNkI3RTRv?=
 =?utf-8?B?Wmp6VFhYOEp3TVJpZFZldkZaSmZLNUVmdFhWZWEyYUt0aVVsZkZQRHQwb2E0?=
 =?utf-8?B?c3dydWdYekMxdVZCNzA5ZUt3MjZpQWMrZ2hkMlJBZG1rbmdCYkdMVnVCU2pK?=
 =?utf-8?B?OWN4eGxlZ1N6RkJxU1F6d0hZblo1blduVE8xblJodXBsYitEOFVYWmJiZTlJ?=
 =?utf-8?Q?X+jDy/LchOjL2hMxwkrNBAhfI?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 15:58:22.5823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c20a50-68b7-4830-6141-08de4ecec024
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6304

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Linux Accurate ECN test sets using ACE counters and AccECN options to
cover several scenarios: Connection teardown, different ACK conditions,
counter wrapping, SACK space grabbing, fallback schemes, negotiation
retransmission/reorder/loss, AccECN option drop/loss, different
handshake reflectors, data with marking, and different sysctl values.

Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
---
 .../close-local-close-then-remote-fin.pkt     | 25 +++++++
 .../accecn/counters/3rd-ack-lost-data-ce.pkt  | 22 ++++++
 .../accecn/counters/delivered-2ndlargeack.pkt | 25 +++++++
 .../delivered-falseoverflow-detect.pkt        | 31 ++++++++
 .../accecn/counters/delivered-largeack.pkt    | 24 +++++++
 .../accecn/counters/delivered-largeack2.pkt   | 25 +++++++
 .../accecn/counters/delivered-maxack.pkt      | 25 +++++++
 .../accecn/counters/delivered-updates.pkt     | 70 +++++++++++++++++++
 .../accecn/counters/ecn-field-updates-opt.pkt | 35 ++++++++++
 .../accecn/counters/noprogress.pkt            | 27 +++++++
 .../counters/sack-space-grab-with-ts.pkt      | 39 +++++++++++
 .../accecn/counters/sack-space-grab.pkt       | 28 ++++++++
 .../accecn/counters/tsnoprogress.pkt          | 26 +++++++
 .../accecn/counters/tsprogress.pkt            | 25 +++++++
 .../accecn/fallback/acc_ecn_disabled.pkt      | 14 ++++
 .../accecn/fallback/accecn-to-rfc3168.pkt     | 18 +++++
 .../fallback/client_accecn_options_drop.pkt   | 34 +++++++++
 .../fallback/client_accecn_options_lost.pkt   | 38 ++++++++++
 .../net/packetdrill/accecn/fallback/ecn3.pkt  | 12 ++++
 .../accecn/fallback/ipflags-drop.pkt          | 14 ++++
 .../accecn/fallback/listen-opt-drop.pkt       | 16 +++++
 .../accecn/fallback/multiple_syn_ack_drop.pkt | 28 ++++++++
 .../accecn/fallback/multiple_syn_drop.pkt     | 18 +++++
 .../accecn/fallback/negotiation-bleach.pkt    | 23 ++++++
 .../accecn/fallback/rfc3168-to-fallback.pkt   | 18 +++++
 .../accecn/fallback/rfc3168-to-rfc3168.pkt    | 18 +++++
 .../syn_ace_flags_acked_after_retransmit.pkt  | 18 +++++
 .../accecn/fallback/syn_ace_flags_drop.pkt    | 16 +++++
 ...n_ack_ace_flags_acked_after_retransmit.pkt | 27 +++++++
 .../fallback/syn_ack_ace_flags_drop.pkt       | 27 +++++++
 .../negotiation/3rd-ack-after-synack-rxmt.pkt | 19 +++++
 .../accecn/negotiation/3rd-dups.pkt           | 26 +++++++
 .../negotiation/accecn_then_notecn_syn.pkt    | 28 ++++++++
 .../negotiation/clientside-disabled.pkt       | 12 ++++
 .../negotiation/negotiation-connect.pkt       | 23 ++++++
 .../accecn/negotiation/negotiation-listen.pkt | 26 +++++++
 .../negotiation/negotiation-noopt-connect.pkt | 23 ++++++
 .../negotiation/negotiation-optenable.pkt     | 23 ++++++
 .../negotiation/no-ecn-after-acc-ecn.pkt      | 20 ++++++
 .../packetdrill/accecn/negotiation/noopt.pkt  | 27 +++++++
 .../negotiation/notecn_then_accecn_syn.pkt    | 28 ++++++++
 .../serverside-accecn-disabled1.pkt           | 20 ++++++
 .../serverside-accecn-disabled2.pkt           | 20 ++++++
 .../accecn/negotiation/serverside-broken.pkt  | 19 +++++
 .../negotiation/serverside-ecn-disabled.pkt   | 19 +++++
 .../accecn/negotiation/serverside-only.pkt    | 18 +++++
 .../accecn/negotiation/synack-rexmit.pkt      | 15 ++++
 .../accecn/negotiation/synack-rxmt.pkt        | 25 +++++++
 .../reflector/2nd-data-as-first-connect.pkt   | 30 ++++++++
 .../accecn/reflector/2nd-data-as-first.pkt    | 24 +++++++
 .../3rd-ack-ce-updates-received_ce.pkt        | 18 +++++
 .../packetdrill/accecn/reflector/syn-ce.pkt   | 13 ++++
 .../packetdrill/accecn/reflector/syn-ect0.pkt | 13 ++++
 .../packetdrill/accecn/reflector/syn-ect1.pkt | 13 ++++
 .../synack-ce-updates-delivered-ce.pkt        | 22 ++++++
 .../accecn/reflector/synack-ce.pkt            | 28 ++++++++
 .../accecn/reflector/synack-ect0.pkt          | 24 +++++++
 .../accecn/reflector/synack-ect1.pkt          | 24 +++++++
 58 files changed, 1366 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/close/close-local-close-then-remote-fin.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/3rd-ack-lost-data-ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/delivered-2ndlargeack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/delivered-falseoverflow-detect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/delivered-largeack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/delivered-largeack2.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/delivered-maxack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/delivered-updates.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/ecn-field-updates-opt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/noprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/sack-space-grab-with-ts.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/sack-space-grab.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/tsnoprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/tsprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/acc_ecn_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/accecn-to-rfc3168.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/client_accecn_options_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/client_accecn_options_lost.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/ecn3.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/ipflags-drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/listen-opt-drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/multiple_syn_ack_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/multiple_syn_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/negotiation-bleach.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/rfc3168-to-fallback.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/rfc3168-to-rfc3168.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/syn_ace_flags_acked_after_retransmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/syn_ace_flags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/syn_ack_ace_flags_acked_after_retransmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/syn_ack_ace_flags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/3rd-ack-after-synack-rxmt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/3rd-dups.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/accecn_then_notecn_syn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/clientside-disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/negotiation-connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/negotiation-listen.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/negotiation-noopt-connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/negotiation-optenable.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/no-ecn-after-acc-ecn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/noopt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/notecn_then_accecn_syn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-accecn-disabled1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-accecn-disabled2.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-broken.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-ecn-disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-only.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/synack-rexmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/synack-rxmt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/reflector/2nd-data-as-first-connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/reflector/2nd-data-as-first.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/reflector/3rd-ack-ce-updates-received_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/reflector/syn-ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/reflector/syn-ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/reflector/syn-ect1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/reflector/synack-ce-updates-delivered-ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/reflector/synack-ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/reflector/synack-ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/reflector/synack-ect1.pkt

diff --git a/tools/testing/selftests/net/packetdrill/accecn/close/close-local-close-then-remote-fin.pkt b/tools/testing/selftests/net/packetdrill/accecn/close/close-local-close-then-remote-fin.pkt
new file mode 100644
index 000000000000..ec7d5f541350
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/close/close-local-close-then-remote-fin.pkt
@@ -0,0 +1,25 @@
+// Test basic connection teardown where local process closes first:
+// the local process calls close() first, so we send a FIN, and receive an ACK.
+// Then we receive a FIN and ACK it.
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+ +.01...0.011 connect(3, ..., ...) = 0
+   +0 > [noecn] SEWA 0:0(0) <...>
+   +0 < [ect1] SW. 0:0(0) ack 1 win 32768 <mss 1000,nop,wscale 6,nop,nop,sackOK>
+   +0 > [ect0] EW. 1:1(0) ack 1
+
+   +0 write(3, ..., 1000) = 1000
+   +0 > [ect0] P5. 1:1001(1000) ack 1
+   +0 < [ect0] .5 1:1(0) ack 1001 win 257
+
+   +0 close(3) = 0
+   +0 > [ect0] F5. 1001:1001(0) ack 1
+   +0 < [ect0] .5 1:1(0) ack 1002 win 257
+
+   +0 < [ect0] F5. 1:1(0) ack 1002 win 257
+   +0 > [ect0] . 1002:1002(0) ack 2
diff --git a/tools/testing/selftests/net/packetdrill/accecn/counters/3rd-ack-lost-data-ce.pkt b/tools/testing/selftests/net/packetdrill/accecn/counters/3rd-ack-lost-data-ce.pkt
new file mode 100644
index 000000000000..a043748c0c70
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/counters/3rd-ack-lost-data-ce.pkt
@@ -0,0 +1,22 @@
+// 3rd ACK lost, CE for the first data segment
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
++0.05 < SEWA 0:0(0) win 32767 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+// 3rd ACK lost
++0.05 < [ce] EAP. 1:1001(1000) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] WA. 1:1(0) ack 1001 <ECN e1b 1 ceb 1000 e0b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.05 < [ce] EAP. 1001:2001(1000) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.001 > [ect0] EWA. 1:1(0) ack 2001 <ECN e1b 1 ceb 2000 e0b 1 ,nop>
diff --git a/tools/testing/selftests/net/packetdrill/accecn/counters/delivered-2ndlargeack.pkt b/tools/testing/selftests/net/packetdrill/accecn/counters/delivered-2ndlargeack.pkt
new file mode 100644
index 000000000000..63c42dab51aa
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/counters/delivered-2ndlargeack.pkt
@@ -0,0 +1,25 @@
+// Test a large ACK (> ACE field max)
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 14600) = 14600
++.002 > [ect0] P.5 1:14601(14600) ack 1
++0.05 < [ect0] .5 1:1(0) ack 1461 win 264
++0.05 < [ect0] .5 1:1(0) ack 14601 win 264
+
++0.01 %{ assert tcpi_delivered_ce == 8, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/accecn/counters/delivered-falseoverflow-detect.pkt b/tools/testing/selftests/net/packetdrill/accecn/counters/delivered-falseoverflow-detect.pkt
new file mode 100644
index 000000000000..8d050d8c1949
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/counters/delivered-falseoverflow-detect.pkt
@@ -0,0 +1,31 @@
+// Test false overflow detection with option used to rule out overflow
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
+// Stop sending option to allow easier testing
++0 `sysctl -q net.ipv4.tcp_ecn_option=0`
+
++0.002 write(4, ..., 14600) = 14600
++.002 > [ect0] P.5 1:14601(14600) ack 1
+
++0.05 < [ect0] .5 1:1(0) ack 1460 win 264 <ECN e0b 1461 ceb 0 e1b 1,nop>
++0.05 < [ect0] .5 1:1(0) ack 14601 win 264 <ECN e0b 14601 ceb 0 e1b 1,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 0, tcpi_delivered_ce
+assert tcpi_delivered_e0_bytes == 14600, tcpi_delivered_e0_bytes
+}%
diff --git a/tools/testing/selftests/net/packetdrill/accecn/counters/delivered-largeack.pkt b/tools/testing/selftests/net/packetdrill/accecn/counters/delivered-largeack.pkt
new file mode 100644
index 000000000000..ae6db89c36b2
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/counters/delivered-largeack.pkt
@@ -0,0 +1,24 @@
+// Test a large ACK (> ACE field max)
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 14600) = 14600
++.002 > [ect0] P.5 1:14601(14600) ack 1
++0.05 < [ect0] .5 1:1(0) ack 14601 win 264
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/accecn/counters/delivered-largeack2.pkt b/tools/testing/selftests/net/packetdrill/accecn/counters/delivered-largeack2.pkt
new file mode 100644
index 000000000000..71e27dbc9491
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/counters/delivered-largeack2.pkt
@@ -0,0 +1,25 @@
+// Test a large ACK (> ACE field max)
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 14600) = 14600
++.002 > [ect0] P.5 1:14601(14600) ack 1
+  // Fake CE
++0.05 < [ect0] .6 1:1(0) ack 14601 win 264
+
++0.01 %{ assert tcpi_delivered_ce == 1, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/accecn/counters/delivered-maxack.pkt b/tools/testing/selftests/net/packetdrill/accecn/counters/delivered-maxack.pkt
new file mode 100644
index 000000000000..93a64e5bf5c4
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/counters/delivered-maxack.pkt
@@ -0,0 +1,25 @@
+// Test a large ACK (at ACE field max delta)
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 14600) = 14600
++.002 > [ect0] P.5 1:14601(14600) ack 1
+  // Fake CE
++0.05 < [ect0] .4 1:1(0) ack 14601 win 264
+
++0.01 %{ assert tcpi_delivered_ce == 7, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/accecn/counters/delivered-updates.pkt b/tools/testing/selftests/net/packetdrill/accecn/counters/delivered-updates.pkt
new file mode 100644
index 000000000000..2803df569010
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/counters/delivered-updates.pkt
@@ -0,0 +1,70 @@
+// Test basic AccECN CEP/CEB/E0B/E1B functionality & CEP wrapping
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{
+assert tcpi_delivered_ce == 0, tcpi_delivered_ce
+assert tcpi_delivered_ce_bytes == 0, tcpi_delivered_ce_bytes
+}%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake CE
++0.05 < [ect0] WA. 1:1(0) ack 1001 win 264 <ECN e0b 1 ceb 1000 e1b 1,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 1, tcpi_delivered_ce
+assert tcpi_delivered_ce_bytes == 1000, tcpi_delivered_ce_bytes
+}%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake ect0
++0.05 < [ect0] WA. 1:1(0) ack 2001 win 264 <ECN e0b 1001 ceb 1000 e1b 1,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 1, tcpi_delivered_ce
+assert tcpi_delivered_e0_bytes == 1000, tcpi_delivered_e0_bytes
+}%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 2001:3001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake ce
++0.05 < [ect0] EWA. 1:1(0) ack 3001 win 264 <ECN e0b 1001 ceb 2000 e1b 1,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 2, tcpi_delivered_ce
+assert tcpi_delivered_ce_bytes == 2000, tcpi_delivered_ce_bytes
+}%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 3001:4001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake ect1
++0.05 < [ect0] EWA. 1:1(0) ack 4001 win 264 <ECN e0b 1001 ceb 2000 e1b 1001,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 2, tcpi_delivered_ce
+assert tcpi_delivered_e1_bytes == 1000, tcpi_delivered_e1_bytes
+}%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 4001:5001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake ce
++0.05 < [ect0] . 1:1(0) ack 5001 win 264 <ECN e0b 1001 ceb 3000 e1b 1001,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 3, tcpi_delivered_ce
+assert tcpi_delivered_ce_bytes == 3000, tcpi_delivered_ce_bytes
+}%
diff --git a/tools/testing/selftests/net/packetdrill/accecn/counters/ecn-field-updates-opt.pkt b/tools/testing/selftests/net/packetdrill/accecn/counters/ecn-field-updates-opt.pkt
new file mode 100644
index 000000000000..a7d5eae360c2
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/counters/ecn-field-updates-opt.pkt
@@ -0,0 +1,35 @@
+// Test basic AccECN CEP/CEB/E0B/E1B functionality & CEP wrapping
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.05 < [ce] EAP. 1:1001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] WA. 1:1(0) ack 1001 <ECN e1b 1 ceb 1000 e0b 1,nop>
+   +0 read(4, ..., 1000) = 1000
+
++0.05 < [ect0] EAP. 1001:2001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] WA. 1:1(0) ack 2001 <ECN e1b 1 ceb 1000 e0b 1001,nop>
+   +0 read(4, ..., 1000) = 1000
+
++0.05 < [ce] EAP. 2001:3001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EWA. 1:1(0) ack 3001 <ECN e1b 1 ceb 2000 e0b 1001,nop>
+   +0 read(4, ..., 1000) = 1000
+
++0.05 < [ect1] EAP. 3001:4001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EWA. 1:1(0) ack 4001 <ECN e1b 1001 ceb 2000 e0b 1001,nop>
+   +0 read(4, ..., 1000) = 1000
+
++0.05 < [ce] EAP. 4001:5001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] . 1:1(0) ack 5001 <ECN e1b 1001 ceb 3000 e0b 1001,nop>
+   +0 read(4, ..., 1000) = 1000
diff --git a/tools/testing/selftests/net/packetdrill/accecn/counters/noprogress.pkt b/tools/testing/selftests/net/packetdrill/accecn/counters/noprogress.pkt
new file mode 100644
index 000000000000..c1287372b582
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/counters/noprogress.pkt
@@ -0,0 +1,27 @@
+// Test no progress filtering
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake CE and claim no progress
++0.05 < [ect0] WA. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 1000 e1b 1,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 0, tcpi_delivered_ce
+assert tcpi_delivered_ce_bytes == 0, tcpi_delivered_ce_bytes
+}%
diff --git a/tools/testing/selftests/net/packetdrill/accecn/counters/sack-space-grab-with-ts.pkt b/tools/testing/selftests/net/packetdrill/accecn/counters/sack-space-grab-with-ts.pkt
new file mode 100644
index 000000000000..087467a729c8
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/counters/sack-space-grab-with-ts.pkt
@@ -0,0 +1,39 @@
+// Test SACK space grab to fit AccECN option
+--tcp_ts_tick_usecs=1000
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,sackOK,TS val 1 ecr 0,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,sackOK,TS val 100 ecr 1,ECN e1b 1 ceb 0 e0b 1,nop,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <nop,nop,TS val 2 ecr 100,ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
+// One SACK block should allow all 3 AccECN fields:
++.01 < [ect1] EAP. 1001:2001(1000) ack 1 win 264 <nop,nop,TS val 3 ecr 100>
++0.002 > [ect0] EA. 1:1(0) ack 1 <nop,nop,TS val 160 ecr 2,ECN e1b 1001 ceb 0 e0b 1,nop,nop,nop,sack 1001:2001>
+
+// Two SACK blocks should fit w/ AccECN if we only need to use 2 AccECN fields: check ect1 arriving.
++.01 < [ect1] EAP. 3001:4001(1000) ack 1 win 264 <nop,nop,TS val 4 ecr 100>
++0.002 > [ect0] EA. 1:1(0) ack 1 <nop,nop,TS val 172 ecr 2,ECN e1b 2001 ceb 0,nop,nop,sack 3001:4001 1001:2001>
+
+// Two SACK blocks should fit w/ AccECN if we only need to use 2 AccECN fields: check CE arriving.
++.01 < [ce] EAP. 5001:6001(1000) ack 1 win 264 <nop,nop,TS val 5 ecr 100>
++0.002 > [ect0] WA. 1:1(0) ack 1 <nop,nop,TS val 184 ecr 2,ECN e1b 2001 ceb 1000,nop,nop,sack 5001:6001 3001:4001>
+
+// Check that DSACK works, using 2 SACK blocks in total, if we only need to use 2 AccECN fields: check ect1 arriving.
++.01 < [ect1] EAP. 5001:6001(1000) ack 1 win 264 <nop,nop,TS val 5 ecr 100>
++0.002 > [ect0] WA. 1:1(0) ack 1 <nop,nop,TS val 196 ecr 2,ECN e1b 3001 ceb 1000,nop,nop,sack 5001:6001 5001:6001>
+
+// Check the case where the AccECN option doesn't fit, because sending ect0
+// with order 1 would rquire 3 AccECN fields,
+// and TS (12 bytes) + 2 SACK blocks (20 bytes) + 3 AccECN fields (2 + 3*3 bytes) > 40 bytes.
+// That's OK; Linux TCP AccECN is optimized for the ECT1 case, not ECT0.
++.01 < [ect0] EAP. 6001:7001(1000) ack 1 win 264 <nop,nop,TS val 5 ecr 100>
++0.002 > [ect0] WA. 1:1(0) ack 1 <nop,nop,TS val 204 ecr 2,nop,nop,sack 5001:7001 3001:4001 1001:2001>
diff --git a/tools/testing/selftests/net/packetdrill/accecn/counters/sack-space-grab.pkt b/tools/testing/selftests/net/packetdrill/accecn/counters/sack-space-grab.pkt
new file mode 100644
index 000000000000..9ec1f1353a35
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/counters/sack-space-grab.pkt
@@ -0,0 +1,28 @@
+// Test SACK space grab to fit AccECN option
+--tcp_ts_tick_usecs=1000
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++.01 < [ect1] EAP. 1001:2001(1000) ack 1 win 264
++0.002 > [ect0] EA. 1:1(0) ack 1 <ECN e1b 1001 ceb 0 e0b 1,nop,nop,nop,sack 1001:2001>
++.01 < [ect0] EAP. 3001:4001(1000) ack 1 win 264
++0.002 > [ect0] EA. 1:1(0) ack 1 <ECN e1b 1001 ceb 0 e0b 1001,nop,nop,nop,sack 3001:4001 1001:2001>
++.01 < [ce] EAP. 5001:6001(1000) ack 1 win 264
++0.002 > [ect0] WA. 1:1(0) ack 1 <ECN e1b 1001 ceb 1000 e0b 1001,nop,nop,nop,sack 5001:6001 3001:4001 1001:2001>
+// DSACK works?
++.01 < [ect0] EAP. 5001:6001(1000) ack 1 win 264
++0.002 > [ect0] WA. 1:1(0) ack 1 <ECN e1b 1001 ceb 1000 e0b 2001,nop,nop,nop,sack 5001:6001 5001:6001 3001:4001>
++.01 < [ect1] EAP. 6001:7001(1000) ack 1 win 264
++0.002 > [ect0] WA. 1:1(0) ack 1 <ECN e1b 2001 ceb 1000 e0b 2001,nop,nop,nop,sack 5001:7001 3001:4001 1001:2001>
diff --git a/tools/testing/selftests/net/packetdrill/accecn/counters/tsnoprogress.pkt b/tools/testing/selftests/net/packetdrill/accecn/counters/tsnoprogress.pkt
new file mode 100644
index 000000000000..2f748f42154d
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/counters/tsnoprogress.pkt
@@ -0,0 +1,26 @@
+// Test TS progress filtering
+--tcp_ts_tick_usecs=1000
+--tolerance_usecs=7000
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,sackOK,TS val 1 ecr 0,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,sackOK,TS val 10 ecr 1,ECN e1b 1 ceb 0 e0b 1,nop,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <nop,nop,TS val 2 ecr 10>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <nop,nop,TS val 83 ecr 2>
+  // Fake CE and claim no progress
++0.05 < [ect0] WA. 1:1(0) ack 1 win 264 <nop,nop,TS val 2 ecr 83>
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/accecn/counters/tsprogress.pkt b/tools/testing/selftests/net/packetdrill/accecn/counters/tsprogress.pkt
new file mode 100644
index 000000000000..f8c3d9862d16
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/counters/tsprogress.pkt
@@ -0,0 +1,25 @@
+// Test TS progress filtering
+--tcp_ts_tick_usecs=1000
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,sackOK,TS val 1 ecr 0,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,sackOK,TS val 10 ecr 1,ECN e1b 1 ceb 0 e0b 1,nop,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <nop,nop,TS val 2 ecr 10>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <nop,nop,TS val 83 ecr 2>
+  // Fake CE and claim no progress
++0.05 < [ect0] WA. 1:1(0) ack 1 win 264 <nop,nop,TS val 3 ecr 83>
+
++0.01 %{ assert tcpi_delivered_ce == 1, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/accecn/fallback/acc_ecn_disabled.pkt b/tools/testing/selftests/net/packetdrill/accecn/fallback/acc_ecn_disabled.pkt
new file mode 100644
index 000000000000..d3a6a0ff6e09
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/fallback/acc_ecn_disabled.pkt
@@ -0,0 +1,14 @@
+// Test that when accurate ECN is disabled,
+// client uses RFC3168 ECN for SYN
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=1
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEW 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] S. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,nop,nop,nop,wscale 8>
++.002 > [noecn] . 1:1(0) ack 1
+
diff --git a/tools/testing/selftests/net/packetdrill/accecn/fallback/accecn-to-rfc3168.pkt b/tools/testing/selftests/net/packetdrill/accecn/fallback/accecn-to-rfc3168.pkt
new file mode 100644
index 000000000000..c26262934e37
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/fallback/accecn-to-rfc3168.pkt
@@ -0,0 +1,18 @@
+// Test AccECN -> RFC3168 fallback when sysctl asks for RFC3168 ECN
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=1
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SE. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < . 1:1(0) ack 1 win 320
++.002 accept(3, ..., ...) = 4
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] P. 1:1001(1000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/accecn/fallback/client_accecn_options_drop.pkt b/tools/testing/selftests/net/packetdrill/accecn/fallback/client_accecn_options_drop.pkt
new file mode 100644
index 000000000000..5a1a2d151277
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/fallback/client_accecn_options_drop.pkt
@@ -0,0 +1,34 @@
+// Client negotiates AccECN and starts sending
+// AccECN option in last ACK and data segments
+// Middlebox drops AccECN option and client
+// reverts to ACE flags only
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+sysctl -q net.ipv4.tcp_ecn_option_beacon=1
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.05 < [ect0] EAP. 1:1001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EA. 1:1(0) ack 1001 <ECN e1b 1 ceb 0 e0b 1001,nop>
+   +0 read(4, ..., 1000) = 1000
+
++0.05 < [ect0] EAP. 1:1001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EA. 1:1(0) ack 1001 <ECN e1b 1 ceb 0 e0b 2001,nop,nop,nop,sack 1:1001>
+
++0.05 < [ect0] EAP. 1:1001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EA. 1:1(0) ack 1001 <nop,nop,sack 1:1001>
+
++0.05 < [ect0] EAP. 1001:2001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EA. 1:1(0) ack 2001
+   +0 read(4, ..., 1000) = 1000
diff --git a/tools/testing/selftests/net/packetdrill/accecn/fallback/client_accecn_options_lost.pkt b/tools/testing/selftests/net/packetdrill/accecn/fallback/client_accecn_options_lost.pkt
new file mode 100644
index 000000000000..6ce9042e11c2
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/fallback/client_accecn_options_lost.pkt
@@ -0,0 +1,38 @@
+// Client negotiates AccECN and starts sending
+// AccECN option in last ACK and data segments
+// Middlebox accepts AccECN option but some packets
+// are lost due to congestion. Client should
+// continue to send AccECN option
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [ect0] SW. 0:0(0) ack 1 win 32767 <mss 1024,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] A. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
+// Send
++0.01 write(4, ..., 3000) = 3000
++.002 > [ect0] .5 1:1013(1012) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.002 > [ect0] P.5 1013:2025(1012) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.002 > [ect0] P.5 2025:3001(976) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
+// First two segments were lost due to congestion as SACK was
+// received acknowledging 3rd segment
++0.1 < [ect0] .5 1:1(0) ack 1 win 264 <ECN e1b 1 ceb 0 e0b 977,nop,nop,nop,sack 2025:3001>
+
+// Since data with option was SACKed, we can
+// continue to use AccECN option for the rest of
+// the connection. This one is a rexmt
++.02~+0.5 > [ect0] .5 1:1013(1012) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.1 < [ect0] .5 1:1(0) ack 3001 win 264 <ECN e1b 1 ceb 0 e0b 3000,nop>
+
+// Send new data, it should contain AccECN option
++0.01 write(4, ..., 2000) = 2000
++.002 > [ect0] .5 3001:4013(1012) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.002 > [ect0] P.5 4013:5001(988) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/accecn/fallback/ecn3.pkt b/tools/testing/selftests/net/packetdrill/accecn/fallback/ecn3.pkt
new file mode 100644
index 000000000000..3a6f5c5a02ce
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/fallback/ecn3.pkt
@@ -0,0 +1,12 @@
+// Test that tcp_ecn=4 uses RFC3168 ECN for SYN
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=4
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.05 connect(4, ..., ...) = 0
+
++.002 > SEW 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/accecn/fallback/ipflags-drop.pkt b/tools/testing/selftests/net/packetdrill/accecn/fallback/ipflags-drop.pkt
new file mode 100644
index 000000000000..2f9de0f71fe9
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/fallback/ipflags-drop.pkt
@@ -0,0 +1,14 @@
+// Test IP flags drop
+--tolerance_usecs=50000
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 1.1 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++.02 ~ +1.1 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/accecn/fallback/listen-opt-drop.pkt b/tools/testing/selftests/net/packetdrill/accecn/fallback/listen-opt-drop.pkt
new file mode 100644
index 000000000000..38273576eced
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/fallback/listen-opt-drop.pkt
@@ -0,0 +1,16 @@
+// SYN/ACK option drop test
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.02 ~+2 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.02 ~+5 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.02 ~+8 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
diff --git a/tools/testing/selftests/net/packetdrill/accecn/fallback/multiple_syn_ack_drop.pkt b/tools/testing/selftests/net/packetdrill/accecn/fallback/multiple_syn_ack_drop.pkt
new file mode 100644
index 000000000000..acb19cb323a5
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/fallback/multiple_syn_ack_drop.pkt
@@ -0,0 +1,28 @@
+// Test that SYN-ACK with ACE flags and without
+// ACE flags got dropped. Although we disable ECN,
+// we shouldn't consider this as blackholed as
+// these are dropped due to congestion
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [noecn] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN-ACK without option
++1~+1.1 > [noecn] SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// SYN-ACK maybe getting blackholed, disable ECN
++2~+2.2 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++4~+4.4 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// Received an ACK after sending 3rd retransmission, not a blackhole
++0.1 < [noecn] . 1:1(0) ack 1 win 320
++.002 accept(3, ..., ...) = 4
diff --git a/tools/testing/selftests/net/packetdrill/accecn/fallback/multiple_syn_drop.pkt b/tools/testing/selftests/net/packetdrill/accecn/fallback/multiple_syn_drop.pkt
new file mode 100644
index 000000000000..2fe03d1c83a2
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/fallback/multiple_syn_drop.pkt
@@ -0,0 +1,18 @@
+// Test that SYN with ACE flags and without
+// ACE flags got dropped. Although we disable
+// ECN, we shouldn't consider this as blackholed
+// as these are dropped due to congestion
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 3.1 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8> 
++.02~+1.1 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++.02~+1.1 > [noecn] S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++.02~+1.1 > [noecn] S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.1 < [noecn] S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0~+0.01 > [noecn] . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/accecn/fallback/negotiation-bleach.pkt b/tools/testing/selftests/net/packetdrill/accecn/fallback/negotiation-bleach.pkt
new file mode 100644
index 000000000000..9435f8c4f03f
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/fallback/negotiation-bleach.pkt
@@ -0,0 +1,23 @@
+// Test AccECN flags bleach
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] . 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [noecn] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.05 < [ect0] EAP. 1:1(0) ack 1001 win 320
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/accecn/fallback/rfc3168-to-fallback.pkt b/tools/testing/selftests/net/packetdrill/accecn/fallback/rfc3168-to-fallback.pkt
new file mode 100644
index 000000000000..51c3559de6e1
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/fallback/rfc3168-to-fallback.pkt
@@ -0,0 +1,18 @@
+// Test RFC3168 fallback when sysctl asks for AccECN
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEW 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SE. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < . 1:1(0) ack 1 win 320
++.002 accept(3, ..., ...) = 4
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] P. 1:1001(1000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/accecn/fallback/rfc3168-to-rfc3168.pkt b/tools/testing/selftests/net/packetdrill/accecn/fallback/rfc3168-to-rfc3168.pkt
new file mode 100644
index 000000000000..905c62e408df
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/fallback/rfc3168-to-rfc3168.pkt
@@ -0,0 +1,18 @@
+// Test RFC3168 ECN when sysctl asks for RFC3168 ECN
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=1
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEW 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SE. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < . 1:1(0) ack 1 win 320
++.002 accept(3, ..., ...) = 4
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] P. 1:1001(1000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/accecn/fallback/syn_ace_flags_acked_after_retransmit.pkt b/tools/testing/selftests/net/packetdrill/accecn/fallback/syn_ace_flags_acked_after_retransmit.pkt
new file mode 100644
index 000000000000..9eaa8db924a9
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/fallback/syn_ace_flags_acked_after_retransmit.pkt
@@ -0,0 +1,18 @@
+// Test that SYN with ACE flags was Acked
+// after 2nd retransmission. In this case,
+// since we got SYN-ACK that supports Accurate
+// ECN, we consider this as successful negotiation
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 2.1 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++1~+1.1 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++1~+1.1 > [noecn] S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
+
++0.1 < [noecn] SW. 0:0(0) ack 1 win 32767 <mss 1016,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0~+0.01 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/accecn/fallback/syn_ace_flags_drop.pkt b/tools/testing/selftests/net/packetdrill/accecn/fallback/syn_ace_flags_drop.pkt
new file mode 100644
index 000000000000..b9ddf0426c3b
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/fallback/syn_ace_flags_drop.pkt
@@ -0,0 +1,16 @@
+// Test that SYN with ACE flags got dropped
+// We retry one more time with ACE and then
+// fallback to disabled ECN
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 2.1 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++1~+1.1 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++1~+1.1 > [noecn] S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.1 < [noecn] S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0~+0.01 > [noecn] . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/accecn/fallback/syn_ack_ace_flags_acked_after_retransmit.pkt b/tools/testing/selftests/net/packetdrill/accecn/fallback/syn_ack_ace_flags_acked_after_retransmit.pkt
new file mode 100644
index 000000000000..bf66a2dcd0d5
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/fallback/syn_ack_ace_flags_acked_after_retransmit.pkt
@@ -0,0 +1,27 @@
+// Test that SYN-ACK with ACE flags was Acked
+// after 2nd retransmission. In this case,
+// since we got the last ACK that supports Accurate
+// ECN, we consider this as successful negotiation
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [noecn] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN-ACK without option
++1~+1.1 > [noecn] SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// SYN-ACK maybe getting blackholed, disable ECN
++2~+2.2 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// Received an ACK with ACE flags, state should be set to negotiation succeeded
++0.1 < [noecn] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
diff --git a/tools/testing/selftests/net/packetdrill/accecn/fallback/syn_ack_ace_flags_drop.pkt b/tools/testing/selftests/net/packetdrill/accecn/fallback/syn_ack_ace_flags_drop.pkt
new file mode 100644
index 000000000000..a05ba4d190a8
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/fallback/syn_ack_ace_flags_drop.pkt
@@ -0,0 +1,27 @@
+// Test that SYN-ACK with ACE flags got dropped
+// We retry one more time with ACE and then
+// fallback to disabled ECN
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [noecn] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN-ACK without option
++1~+1.1 > [noecn] SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// SYN-ACK maybe getting blackholed, disable ECN
++2~+2.2 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// Received an ACK with no ACE flags, state should be set to blackholed
++0.1 < [noecn] . 1:1(0) ack 1 win 320
++0 accept(3, ..., ...) = 4
+
diff --git a/tools/testing/selftests/net/packetdrill/accecn/negotiation/3rd-ack-after-synack-rxmt.pkt b/tools/testing/selftests/net/packetdrill/accecn/negotiation/3rd-ack-after-synack-rxmt.pkt
new file mode 100644
index 000000000000..ce50bee20db4
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/negotiation/3rd-ack-after-synack-rxmt.pkt
@@ -0,0 +1,19 @@
+// Test 3rd ACK flags when SYN-ACK is rexmitted
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.1 < [ect0] S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// Our code currently sends a challenge ACK
+// when it receives a SYN in ESTABLISHED state
+// based on the latest SYN
++.002 > [ect0] A. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/accecn/negotiation/3rd-dups.pkt b/tools/testing/selftests/net/packetdrill/accecn/negotiation/3rd-dups.pkt
new file mode 100644
index 000000000000..4399d904b634
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/negotiation/3rd-dups.pkt
@@ -0,0 +1,26 @@
+// Test SYN/ACK rexmit triggered 3rd ACK duplicate + CE on first data seg
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// SYN/ACK rexmitted => two 3rd ACKs in-flight
++1.0~+1.1 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+// Delivered 1st 3rd ACK
++0.05 < [ect0] W. 1:1(0) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
+// Duplicate 3rd ACK delivered
++1.05 < [ect0] W. 1:1(0) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
+
++0.05 < [ce] EAP. 1:1001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] WA. 1:1(0) ack 1001 <ECN e1b 1 ceb 1000 e0b 1,nop>
+   +0 read(4, ..., 1000) = 1000
diff --git a/tools/testing/selftests/net/packetdrill/accecn/negotiation/accecn_then_notecn_syn.pkt b/tools/testing/selftests/net/packetdrill/accecn/negotiation/accecn_then_notecn_syn.pkt
new file mode 100644
index 000000000000..7da7f7601ca2
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/negotiation/accecn_then_notecn_syn.pkt
@@ -0,0 +1,28 @@
+// Test that SYN-ACK with ACE flags and without
+// ACE flags got dropped. Although we disable ECN,
+// we shouldn't consider this as blackholed as
+// these are dropped due to congestion
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [ect0] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SA. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN
++0.1 < [noecn] S 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
++0.1 < [noecn] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
+// Write with AccECN option but with ip-noecn since we received one SYN with ACE=0
++0.01 write(4, ..., 100) = 100
++.002 > [noecn] P5. 1:101(100) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/accecn/negotiation/clientside-disabled.pkt b/tools/testing/selftests/net/packetdrill/accecn/negotiation/clientside-disabled.pkt
new file mode 100644
index 000000000000..e1fa77c18a72
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/negotiation/clientside-disabled.pkt
@@ -0,0 +1,12 @@
+// AccECN sysctl server-side only, no ECN/AccECN
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=5
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < S. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,nop,nop,nop,wscale 8>
++.002 > . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/accecn/negotiation/negotiation-connect.pkt b/tools/testing/selftests/net/packetdrill/accecn/negotiation/negotiation-connect.pkt
new file mode 100644
index 000000000000..a8eb14435712
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/negotiation/negotiation-connect.pkt
@@ -0,0 +1,23 @@
+// Test basic AccECN negotiation
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.05 < [ect0] EAP. 1:1(0) ack 1001 win 256 <ECN e0b 1001 ceb 0 e1b 0,nop>
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/accecn/negotiation/negotiation-listen.pkt b/tools/testing/selftests/net/packetdrill/accecn/negotiation/negotiation-listen.pkt
new file mode 100644
index 000000000000..60d56208cb1d
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/negotiation/negotiation-listen.pkt
@@ -0,0 +1,26 @@
+// Test basic AccECN negotiation
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.05 < [ect0] EAP. 1:1(0) ack 1001 win 320
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/accecn/negotiation/negotiation-noopt-connect.pkt b/tools/testing/selftests/net/packetdrill/accecn/negotiation/negotiation-noopt-connect.pkt
new file mode 100644
index 000000000000..7c5f1d6ba770
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/negotiation/negotiation-noopt-connect.pkt
@@ -0,0 +1,23 @@
+// Test basic AccECN negotiation without option
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < SW. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1
++.05 < [ect0] EAP. 1:1(0) ack 1001 win 256
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/accecn/negotiation/negotiation-optenable.pkt b/tools/testing/selftests/net/packetdrill/accecn/negotiation/negotiation-optenable.pkt
new file mode 100644
index 000000000000..44ac0f82c13f
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/negotiation/negotiation-optenable.pkt
@@ -0,0 +1,23 @@
+// Test basic AccECN negotiation, late option enable
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < SW. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1
++.05 < [ect0] EAP. 1:1(0) ack 1001 win 256 <ECN e0b 1001 ceb 0 e1b 1,nop>
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/accecn/negotiation/no-ecn-after-acc-ecn.pkt b/tools/testing/selftests/net/packetdrill/accecn/negotiation/no-ecn-after-acc-ecn.pkt
new file mode 100644
index 000000000000..ba37a1799398
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/negotiation/no-ecn-after-acc-ecn.pkt
@@ -0,0 +1,20 @@
+// Test client behavior on receiving a non ECN SYN-ACK
+// after receiving an AccECN SYN-ACK and moving to
+// ESTABLISHED state
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
+// Receive an AccECN SYN-ACK and move to ESTABLISHED
++0.05 < [noecn] SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
+// Receive a non ECN SYN-ACK and send a challenge ACK with ACE feedback
++0.1 < [noecn] S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/accecn/negotiation/noopt.pkt b/tools/testing/selftests/net/packetdrill/accecn/negotiation/noopt.pkt
new file mode 100644
index 000000000000..66985d9a16df
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/negotiation/noopt.pkt
@@ -0,0 +1,27 @@
+// Test basic AccECN negotiation with option off using sysctl
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1
++0.05 < [ect0] EAP. 1:1(0) ack 1001 win 320
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/accecn/negotiation/notecn_then_accecn_syn.pkt b/tools/testing/selftests/net/packetdrill/accecn/negotiation/notecn_then_accecn_syn.pkt
new file mode 100644
index 000000000000..13cdd041045a
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/negotiation/notecn_then_accecn_syn.pkt
@@ -0,0 +1,28 @@
+// Test that SYN-ACK with ACE flags and without
+// ACE flags got dropped. Although we disable ECN,
+// we shouldn't consider this as blackholed as
+// these are dropped due to congestion
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [noecn] S 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN
++0.1 < [ect0] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
++0.1 < [noecn] . 1:1(0) ack 1 win 320
++.002 accept(3, ..., ...) = 4
+
+// Write with AccECN option but with ip-noecn since we received one SYN with ACE=0
++0.01 write(4, ..., 100) = 100
++.002 > [noecn] P. 1:101(100) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-accecn-disabled1.pkt b/tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-accecn-disabled1.pkt
new file mode 100644
index 000000000000..718d3c540397
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-accecn-disabled1.pkt
@@ -0,0 +1,20 @@
+// Test against classic ECN server
+// Not-ECT on SYN and server sets 1|0|1 (AE is unused for classic ECN)
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] SEA. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,TS val 700 ecr 100,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <nop, nop, TS val 200 ecr 700>
+
++0 write(4, ..., 100) = 100
++.002 > [ect0] P.5 1:101(100) ack 1 <nop,nop,TS val 300 ecr 700>
++0 close(4) = 0
+
++.002 > [ect0] F.5 101:101(0) ack 1 <nop,nop,TS val 400 ecr 700>
++0.1 < [noecn] R. 1:1(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-accecn-disabled2.pkt b/tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-accecn-disabled2.pkt
new file mode 100644
index 000000000000..6a0a1096c29f
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-accecn-disabled2.pkt
@@ -0,0 +1,20 @@
+// Test against classic ECN server
+// Not-ECT on SYN and server sets 0|0|1
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] SE. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,TS val 700 ecr 100,nop,wscale 8>
++.002 > [noecn] . 1:1(0) ack 1 <nop, nop, TS val 200 ecr 700>
+
++0 write(4, ..., 100) = 100
++.002 > [ect0] P. 1:101(100) ack 1 <nop,nop,TS val 300 ecr 700>
++0 close(4) = 0
+
++0 > [noecn] F. 101:101(0) ack 1 <...>
++0.1 < R. 1:1(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-broken.pkt b/tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-broken.pkt
new file mode 100644
index 000000000000..145a612f6cf4
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-broken.pkt
@@ -0,0 +1,19 @@
+// Test against broken server (1|1|1)
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] SEWA. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,TS val 700 ecr 100,nop,wscale 8>
++.002 > [noecn] . 1:1(0) ack 1 <nop, nop, TS val 200 ecr 700>
+
++0 write(4, ..., 100) = 100
++.002 > [noecn] P. 1:101(100) ack 1 <nop,nop,TS val 300 ecr 700>
++0 close(4) = 0
+
++.002 > [noecn] F. 101:101(0) ack 1 <...>
++0.1 < [noecn] R. 1:1(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-ecn-disabled.pkt b/tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-ecn-disabled.pkt
new file mode 100644
index 000000000000..32a6584b43c6
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-ecn-disabled.pkt
@@ -0,0 +1,19 @@
+// Test against Non ECN server (0|0|0)
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] S. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,TS val 700 ecr 100,nop,wscale 8>
++.002 > [noecn] . 1:1(0) ack 1 <nop, nop, TS val 200 ecr 700>
+
++0 write(4, ..., 100) = 100
++.002 > [noecn] P. 1:101(100) ack 1 <nop,nop,TS val 300 ecr 700>
++0 close(4) = 0
+
++.002 > [noecn] F. 101:101(0) ack 1 <nop,nop,TS val 400 ecr 700>
++0.1 < [noecn] R. 1:1(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-only.pkt b/tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-only.pkt
new file mode 100644
index 000000000000..cc141caa8ea1
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-only.pkt
@@ -0,0 +1,18 @@
+// Test AccECN with sysctl set to server-side only
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=5
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/accecn/negotiation/synack-rexmit.pkt b/tools/testing/selftests/net/packetdrill/accecn/negotiation/synack-rexmit.pkt
new file mode 100644
index 000000000000..d19b22c4523a
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/negotiation/synack-rexmit.pkt
@@ -0,0 +1,15 @@
+// Test 3rd ACK flags when SYN-ACK is rexmitted
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.05 < SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/accecn/negotiation/synack-rxmt.pkt b/tools/testing/selftests/net/packetdrill/accecn/negotiation/synack-rxmt.pkt
new file mode 100644
index 000000000000..3acf91c417d6
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/negotiation/synack-rxmt.pkt
@@ -0,0 +1,25 @@
+// Test that we retransmit SYN-ACK with ACE and without
+// AccECN options after
+// SYN-ACK was lost and TCP moved to TCPS_SYN_RECEIVED
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [noecn] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN-ACK without option
++1~+1.1 > [noecn] SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.1 < [noecn] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
+// We try to write with AccECN option
++0.01 write(4, ..., 100) = 100
++.002 > [ect0] P5. 1:101(100) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/accecn/reflector/2nd-data-as-first-connect.pkt b/tools/testing/selftests/net/packetdrill/accecn/reflector/2nd-data-as-first-connect.pkt
new file mode 100644
index 000000000000..0571203e086f
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/reflector/2nd-data-as-first-connect.pkt
@@ -0,0 +1,30 @@
+// 3rd ACK + 1st data segment lost, 2nd data segments with ce
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] SW. 0:0(0) ack 1 win 32767 <mss 1016,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
+// 3rd ACK lost
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 write(4, ..., 2000) = 2000
+// 1st data segment lost + 2nd gets CE
++.002 > [ect0] .5 1:1005(1004) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.000 > [ect0] P.5 1005:2001(996) ack 1 <ECN e1b 1 ceb 0 e0b 1, nop>
++0.05 < [ect0] .6 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 996 e1b 1,nop,nop,nop,sack 1005:2001>
+
++0.01 %{ assert tcpi_delivered_ce == 1, tcpi_delivered_ce }%
+
++0.002~+0.1 > [ect0] .5 1:1005(1004) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.05 < [ect0] .6 1:1(0) ack 2001 win 264 <ECN e0b 1005 ceb 996 e1b 1,nop>
+
++0.01 write(4, ..., 1000) = 1000
++0~+0.002 > [ect0] P.5 2001:3001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.1 < [ect0] .5 1:1001(1000) ack 3001 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++0~+0.01 > [ect0] .5 3001:3001(0) ack 1001 <ECN e1b 1 ceb 0 e0b 1001,nop>
diff --git a/tools/testing/selftests/net/packetdrill/accecn/reflector/2nd-data-as-first.pkt b/tools/testing/selftests/net/packetdrill/accecn/reflector/2nd-data-as-first.pkt
new file mode 100644
index 000000000000..512a90c9b8c6
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/reflector/2nd-data-as-first.pkt
@@ -0,0 +1,24 @@
+// 3rd ACK + 1st data segment lost, data segments with ce
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
++0.05 < SEWA 0:0(0) win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+// 3rd ACK lost
+// 1st data segment lost
++0.05 < [ce] EAP. 1001:2001(1000) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] WA. 1:1(0) ack 1 <ECN e1b 1 ceb 1000 e0b 1,nop,nop,nop,sack 1001:2001>
++.002 accept(3, ..., ...) = 4
+
++0.2 < [ce] EAP. 1:1001(1000) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.001 > [ect0] EWA. 1:1(0) ack 2001 <ECN e1b 1 ceb 2000 e0b 1,nop>
+
++0.05 < [ce] EAP. 2001:3001(1000) ack 1 win 264
++.001 > [ect0] . 1:1(0) ack 3001 <ECN e1b 1 ceb 3000 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/accecn/reflector/3rd-ack-ce-updates-received_ce.pkt b/tools/testing/selftests/net/packetdrill/accecn/reflector/3rd-ack-ce-updates-received_ce.pkt
new file mode 100644
index 000000000000..4ca63fd1831b
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/reflector/3rd-ack-ce-updates-received_ce.pkt
@@ -0,0 +1,18 @@
+// Third ACK CE increases r.cep
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
++0.05 < SEWA 0:0(0) win 32767 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ce] W. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] WAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/accecn/reflector/syn-ce.pkt b/tools/testing/selftests/net/packetdrill/accecn/reflector/syn-ce.pkt
new file mode 100644
index 000000000000..0fdf387aa1ee
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/reflector/syn-ce.pkt
@@ -0,0 +1,13 @@
+// Test AccECN ECN field reflector in SYNACK
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < [ce] SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SWA. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
diff --git a/tools/testing/selftests/net/packetdrill/accecn/reflector/syn-ect0.pkt b/tools/testing/selftests/net/packetdrill/accecn/reflector/syn-ect0.pkt
new file mode 100644
index 000000000000..951bf9eea7b5
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/reflector/syn-ect0.pkt
@@ -0,0 +1,13 @@
+// Test AccECN ECN field reflector in SYNACK
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < [ect0] SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SA. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
diff --git a/tools/testing/selftests/net/packetdrill/accecn/reflector/syn-ect1.pkt b/tools/testing/selftests/net/packetdrill/accecn/reflector/syn-ect1.pkt
new file mode 100644
index 000000000000..ff6f3293a774
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/reflector/syn-ect1.pkt
@@ -0,0 +1,13 @@
+// Test AccECN ECN field reflector in SYNACK
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < [ect1] SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SEW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
diff --git a/tools/testing/selftests/net/packetdrill/accecn/reflector/synack-ce-updates-delivered-ce.pkt b/tools/testing/selftests/net/packetdrill/accecn/reflector/synack-ce-updates-delivered-ce.pkt
new file mode 100644
index 000000000000..b497ba9c6935
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/reflector/synack-ce-updates-delivered-ce.pkt
@@ -0,0 +1,22 @@
+// Reflected SYNACK CE mark increases delivered_ce
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_fallback=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
++0.05 < SEWA 0:0(0) win 32767 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+// Fake ce for prev, ECT validator must be disabled for this to work
++0.05 < [ect0] WA. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 1, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/accecn/reflector/synack-ce.pkt b/tools/testing/selftests/net/packetdrill/accecn/reflector/synack-ce.pkt
new file mode 100644
index 000000000000..53cd0e9473b4
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/reflector/synack-ce.pkt
@@ -0,0 +1,28 @@
+// Test SYNACK CE & received_ce update
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [ce] SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] WA. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 write(4, ..., 100) = 100
++.002 > [ect0] P.6 1:101(100) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.05 < [ect0] P.5 1:101(100) ack 101 win 256 <ECN e0b 101 ceb 0 e1b 1,nop>
++.002 > [ect0] .6  101:101(0) ack 101 <ECN e1b 1 ceb 0 e0b 101,nop>
+
++0.01 write(4, ..., 100) = 100
++.002 > [ect0] P.6 101:201(100) ack 101 <ECN e1b 1 ceb 0 e0b 101,nop>
+
++0.1  < [ect1] P.5 201:301(100) ack 201 win 256 <ECN e0b 101 ceb 0 e1b 1,nop>
++.002 > [ect0] .6 201:201(0) ack 101 <ECN e1b 101 ceb 0 e0b 101,nop,nop,nop,sack 201:301>
+
++0.01 < [ce] .6 401:501(100) ack 201 win 256 <ECN e0b 101 ceb 0 e1b 1,nop>
++.002 > [ect0] .7 201:201(0) ack 101 <ECN e1b 101 ceb 100 e0b 101,nop,nop,nop,sack 401:501 201:301>
+
diff --git a/tools/testing/selftests/net/packetdrill/accecn/reflector/synack-ect0.pkt b/tools/testing/selftests/net/packetdrill/accecn/reflector/synack-ect0.pkt
new file mode 100644
index 000000000000..27355e27c55d
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/reflector/synack-ect0.pkt
@@ -0,0 +1,24 @@
+// Test SYN=0 reflector
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [ect0] SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] A. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 write(4, ..., 100) = 100
++.002 > [ect0] P.5 1:101(100) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.05 < [ect0] P.5 1:1(0) ack 101 win 256 <ECN e0b 101 ceb 0 e1b 1,nop>
+
++0.01 < [ect0] P.5 1:101(100) ack 101 win 256 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] .5 101:101(0) ack 101 <ECN e1b 1 ceb 0 e0b 101,nop>
++0 read(4, ..., 100) = 100
+
++0 close(4) = 0
++0 > F.5 101:101(0) ack 101 <...>
++0.1 < R. 101:101(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/accecn/reflector/synack-ect1.pkt b/tools/testing/selftests/net/packetdrill/accecn/reflector/synack-ect1.pkt
new file mode 100644
index 000000000000..5d8e29143ac5
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/accecn/reflector/synack-ect1.pkt
@@ -0,0 +1,24 @@
+// Test SYN=0 reflector
+
+`../../common/defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [ect1] SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] EW. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 write(4, ..., 100) = 100
++.002 > [ect0] P.5 1:101(100) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.05 < [ect1] P.5 1:1(0) ack 101 win 256 <ECN e0b 101 ceb 0 e1b 1,nop>
+
++0.01 < [ect1] P.5 1:101(100) ack 101 win 256 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] .5 101:101(0) ack 101 <ECN e1b 101 ceb 0 e0b 1,nop>
++0 read(4, ..., 100) = 100
+
++0 close(4) = 0
++0 > F5. 101:101(0) ack 101 <...>
++0.1 < R. 101:101(0) ack 102 win 4242
-- 
2.34.1


