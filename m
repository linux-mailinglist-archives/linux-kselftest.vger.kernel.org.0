Return-Path: <linux-kselftest+bounces-29160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A41A6364A
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 16:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0127A3AC753
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 15:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB5013DDAA;
	Sun, 16 Mar 2025 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Wn/wRxyy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119321B808;
	Sun, 16 Mar 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742139585; cv=fail; b=sPxR0SbRF59qSUCOPRYkA9qSSwbUtnUK1oLYROYIgF3gTrrEo6l2/9nry8pJsuiXXncoBPIVMK4eNjLuhR3XTOgvjosMQu1ZAfXW3ToDh8Ee22lI+DZ8NOm3tlGIxHMhVzuE0HlrpsMhF4CXfmp42775FPd/ncw2McIBdXFyj+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742139585; c=relaxed/simple;
	bh=scAdAlpHX47m70kobrILtxM7OzDBCMT6E4v6jKKcxng=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=axM3PTzlRWuzvJmKIep5BKG8J30vx7Schg3NYL3E9ypGDhImH7x7JLF7XQQrjszjInaIGbBgRj3dsA16EWMsMWDVINOrDRdlf4Yg4iSFQh2vi5Voa4QyHGPx5QtvAvbpCsWeiaxtM80LyXM1TzhIPVKU62BHafIDgD+N9+Keu4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Wn/wRxyy; arc=fail smtp.client-ip=40.107.21.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeeMPpQpeTHelsP01tdJMcH8mkHH+vm4IOmk3lXd9xPYnhJ0f5p+SIUnX9V5Nprv5TNrJj3gAjp/M1T4TkEYo1MhI2PH/Ojb6pEkYK5IUUa+GyxQ+ne1lOqOAeqUIKGR18brV3VtLQuQHjEDE/ljqWHYqdXnEsMeqyLzkRzb8bCDMvP1b8GCf3Evl55m2Y4pVT7pXqPMROov55+QbeUwmlgss2oJdCPTDxtiIk3kCs9Wzl+/qUiLox56jHVjk1/UOBnObu/FP6gK5STP3HZ6x4V+0CtQfRUj7r1wVRj0VnER7vRjB1XT5eCCfoWYPe7mCUOJwib4JwFcIUbYbQgvxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgYCdnTdShljzbS9O1WGTR1H3MaQuwul5UaebQsPl0A=;
 b=Ls9ZsOHCXwHnRrsV87LoOowy4GzAqjOaAYHPDQh+aJ4qZE00lYz5T0aHeqE/F6PYwL+Z8LBJzKsP+Ot5dxI7UCrkB8i6/xOty1G08bi6bLvOLPj6vaWBc8LlC4suOOcW3PqWL3NdJEWBp4lWpEIk0bZhWz3I1qG7T7oxY9KeQml3dhgX60iiOFmnir4vh8xtfkfIelJjVViIN2gPTZuAJQb1cNsMbc3X0+601JuTl+PxsHrvJSztxbiaKMmpSdF8WVpRnB50ptIX+wKA8L527k764VWd2yJT2s2vD9JfHe6Kb9huqrfr+qss53avWhh2SdnbU9nFfgOh6eld1QKZVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgYCdnTdShljzbS9O1WGTR1H3MaQuwul5UaebQsPl0A=;
 b=Wn/wRxyyxWRs6aBRYz7iT1Rf+Z6/JhKeMi6j3xxzO1fMD4Tchsp8XNx9fwsrWYtcRi5wTg6AbcjOhBLNM0Aze311tCzRW5UCVrIs3jrPLs6k0FH12KN/pvUJMQBO0GXECSiU3fpra9kBnokbaRa5oIumPiyRKCu6Jhsw80bHGp3CfamdBzf/9vwHivK8BEyKAdjBMb672ddCi2WuD37RgexRisXxtKdESejzUOBh7Xw6P9VCFCPl9p7PAPgkzSoTwgMmn0k+MsxwRvpQQz5KfPkyjeKByC/XOyRQ8rcBbEEupjBS69MBpvxVto4alLiX+f+wh/cgKm2kmmeovESJng==
Received: from DB8PR09CA0032.eurprd09.prod.outlook.com (2603:10a6:10:a0::45)
 by PA4PR07MB7648.eurprd07.prod.outlook.com (2603:10a6:102:c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 15:39:40 +0000
Received: from DU2PEPF00028D05.eurprd03.prod.outlook.com
 (2603:10a6:10:a0:cafe::55) by DB8PR09CA0032.outlook.office365.com
 (2603:10a6:10:a0::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.32 via Frontend Transport; Sun,
 16 Mar 2025 15:39:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D05.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 15:39:39 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 52GFdTde021027;
	Sun, 16 Mar 2025 15:39:29 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v4 iproute2-next 0/1] DualPI2 iproute2 patch
Date: Sun, 16 Mar 2025 16:39:16 +0100
Message-Id: <20250316153917.21005-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D05:EE_|PA4PR07MB7648:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b38c9a8c-333e-4310-3b1d-08dd64a0c3d2
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?HHqv4S3zwybGDocP3SAmjgW7yBAny4OTPyyHDpZn/B1T6MPhJDevhM/skx89?=
 =?us-ascii?Q?hY8hpd4CcJXJcUnghsU0r2PQ1kbHMgzDboLSn6itMtNy9x5LtCU9IF02V91J?=
 =?us-ascii?Q?oYebPGXZtz42RUi+4FQ7Nb0rGcWG6l5AKXQ3ImBhsrS8K6Wx2nSCnFT0wXaG?=
 =?us-ascii?Q?Y1k6Vn5vOr/dXaRL2FUEPEEsT+uBZ6dqRUss81gC/8ri7y9Qp98lHUGg/RG4?=
 =?us-ascii?Q?N5jQ6Oop8hhJHVNgwfbAUMSH9T7QeSas+trVFlAltcHjlOwst+BB6LI63e77?=
 =?us-ascii?Q?dx0lmNkGsXjGtJ5ZXS+Nosjxi8c7kc1qw7axpQY6WZwZXdMGNjXrIlsDYbsm?=
 =?us-ascii?Q?MqX+ww+B2F56n3srbEEosKcWXSRatXjGSuwZMRGD3/LwoxY/35LlF9HZaWXI?=
 =?us-ascii?Q?F1pRXR7eriscDCPopUOzfvUvl9kyyHwlg8QUJ14ytwUc4hZtOy+NozHolSmf?=
 =?us-ascii?Q?zVDLk3Ith9ZJUDOkAFPNuLNKE/06gQLvSPpZbxirBa6B6I5p5ZLSAJ7f9Dck?=
 =?us-ascii?Q?N6K7wMPDvMooqBwEAzDmScjMWVWVQ+T7OglOxr8Mc0w3DhT3LDEdvpOY6fKE?=
 =?us-ascii?Q?cUtulKPq/lEU4dvSp2fJDsPZ+zUIbdWmNZ6ufvZaWk88LWT2FQQA6Ex+5DE+?=
 =?us-ascii?Q?gaTLSXnd8MKATdVIkb7+tFJPlWgy6Ir4zzpL1DRWNoqcLpBGy8kAiG3m0iYt?=
 =?us-ascii?Q?YvvWt0oAO48XTQxLlbFiaB34bBR8Vbpp875+swbvCNiVN6GhjBlpv2BPDn35?=
 =?us-ascii?Q?dUQpmR9X8NeZvSz73pBpvZqcCBiMdSDU6XSF8xyR08QMgyiOZsf0XlnForjY?=
 =?us-ascii?Q?4AsWLhkhZwOw5OUCDCywNn+Kf9XigApl6L3X0BrDHh3YrMQHZRUKSm2N7MCW?=
 =?us-ascii?Q?Ge5roIp6SgNq1aXoeam94/KEjjZa1x+2y7PJgwauvmejfc9qixanVGiiegcT?=
 =?us-ascii?Q?LzED6oDR+GozVWwy5/GtXtLSvKiZ8VQK937BZA4GAn7k/iiDlm5b+TuO8DKM?=
 =?us-ascii?Q?dgQPfBOChVoe6AvPMbf0WE8kjCND/TuVbcoD1dRB40D7voMqh4M1xwVRTNlB?=
 =?us-ascii?Q?E2pvIFc8g0UebCRnr0PGKKYmL+M/l/oUxqtzXcsmom2ylFytYHUsG9esHO0d?=
 =?us-ascii?Q?QhwPg9HG1xHCALZSWen+7JOR6jKhcNNen8UDex8y2ySfX4vtopwn5S9bkLIf?=
 =?us-ascii?Q?E0enOrd3YzVDC+WPxdRC9MkLzpPJle1W+0+owZLYfM9kEg9jluqDsFOTaMpp?=
 =?us-ascii?Q?A5JLaDG1aFIqqcuuDBvzwgiCJRWCg1P5Hbh4JGNoHl2Yvsho8U2umvmdp6zv?=
 =?us-ascii?Q?OFjn4ztL9lEdTEae3yv75TRxnNFzn4EG3noFqaKk2sfvpyIQkNgTDxgAaEa6?=
 =?us-ascii?Q?a2VFU7Hdr+OCa0SXoKBw5QS/CkRuHR79jqw73k7W8dd4YGqkOg9t7AH3hBE5?=
 =?us-ascii?Q?k4yLugJgkPBpHqIjm9PUDK2gz/qItZ494CnE2RKXMUmGe2jWp7eRUyZVoecK?=
 =?us-ascii?Q?Jd74VC7Uaop6vglJQqnr4PYn+FxjE3/l07e4?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 15:39:39.8420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b38c9a8c-333e-4310-3b1d-08dd64a0c3d2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7648

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find DUALPI2 iproute2 patch v4.

v4
- Add min_qlen_step to dualpi2 attribute as the minimum queue length in number of packets in the L-queue to start step amrking.
 
v3
- Add memlimit to dualpi2 attribute, and add memory_used, max_memory_used, memory_limit in dualpi2 stats (Dave Taht <dave.taht@gmail.com>)
- Update manual to align latest implementation and clarify the queue naming and default unit
- Use common "get_scaled_alpha_beta" and clean print_opt for Dualpi2

v2
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
 tc/q_dualpi2.c                 | 508 +++++++++++++++++++++++++++++++++
 8 files changed, 839 insertions(+), 15 deletions(-)
 create mode 100644 man/man8/tc-dualpi2.8
 create mode 100644 tc/q_dualpi2.c

-- 
2.34.1


