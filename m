Return-Path: <linux-kselftest+bounces-46826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FFCC9850B
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 17:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6403A4A6D
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 16:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4527E337B8B;
	Mon,  1 Dec 2025 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="YbWCrDfH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013071.outbound.protection.outlook.com [52.101.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB22335558;
	Mon,  1 Dec 2025 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607129; cv=fail; b=OjJ6K+IyLk4QTN25u9NVFotyACejJEhx7TclGz4R+PDB8iZTqbA+gFR4Qj5XedoaQ77fLytJAgobTMERqIeBRK9bn5fZLMlPFvZQp08TfMUgmFKyJLVhoN/WFh/t/Nh1nJ5BGl/px8T0I6141vqbw1e2UnOIN3+oy1ITGbDtt60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607129; c=relaxed/simple;
	bh=K9sp/cKFhO2N1xPzkjJWGMSrD6M/VgnZ8iPjal4WcLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wz7Qp9tKi4yNNGhmYz1VIRugWZF6H9ysiZvzPPqXOkLjEFHlDl0FS8cXyFFw9X4FE6Wct+goX4Ta5h8+qhYvfceR1GPvycMhkj2DdW4fF9jpsQO2iLdPMMyQCysX8J4CEIDF1fuo6sim0MedyzCwFXh68yHYn1L7w/rrGG8n2qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=YbWCrDfH; arc=fail smtp.client-ip=52.101.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFsLFTvQW4lABRA14W8XmPvR+9K+D0ekie7AkZpNx5gOKv7l3ibEYs2Tk2bmlw0eas/Ec2K1V8FoNZ3MfPWKw5sQm0QOBhKxaqQDshX3rA7jbyJb1Rba6FkjpuBQhNzSPuLOZqfIStxtuNyErifk1KBdC9mC13fHOcq2hhKxQwbn5cYRCrmczgEpbB+DiisJ4ROggndgdsxsjj9hsC6H1y98SdpyRHl+B3HDY3xmPMtl7YCr7H8fXJx7ODu9P+kVwxagkL3lk2R32hZfV6Og2YGr/Wq5eXqGzRw89ZMcRVbSoCSC/m9eqCjAwvVp+8B/WvsSHRzPfjv6Kq8eFPet0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utpWZB31jtldMqB4ZA8NQqghWs8Hn3X9j6pkTLcicYI=;
 b=W0M5AaFSwdzDRXzEfQeAvtUfMfW0LCBkRHmjM1ondZoOswJoBQ+FYN2nBTpjGTeK5XjR1FQtsCpUytSCqOOVamDUxIbsOJpyQyZXxEyjT6/oo8ebOeWDTbw7QuKXzjqiLacxQNaiqc9j5gvI5WncTwzdYArkpliQz8Xti7igj/MGc8KApOfMp7LC1YSWU2JDnrFc5Eym5jfaz4/LwWqNsw2Flp0R2eB+8QskTT+yoIuP5qIb7Ng/P080qQapSmvkb/83DFXvcsCFPXIfJ4/pf2JFDnmBJnXwP+Qb+odi8jfpN54iNixANxkHX9Lk+Kp2nAVsX37p5Lvc1A0Rt/rD6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utpWZB31jtldMqB4ZA8NQqghWs8Hn3X9j6pkTLcicYI=;
 b=YbWCrDfH9dFwuFEo2DiSEGN6k7iIoFAbIgzgDX5YoWaeFe5wBJlr5e25wNNZ91JFX/PoJOb8Eq342C40Vf4YTyNFaYWPvZTNW5emofxBktXLeZgAz4ehw0s0WgKbOKbRpQTC+cSVOgAg6ApTPqFc44G6bcogruD1AVI3vCe5YwJjRbkkPzVKyBseyS5gBu+i+SQ4jOF0JHNjkkJvxHRkEQFXYtiwaZ6eiH11eaFX6fWdui74CXMvhXQcv8fUyqqzlg/7nCVN57sjPJAoQvqXg5g/xkM2czoqf3sdaa8jMvc1lLPjUk7PKQVY+oVG1pCaexTaLZ1SGp3KUDEsbcd+vw==
Received: from DB9PR05CA0015.eurprd05.prod.outlook.com (2603:10a6:10:1da::20)
 by VI1PR07MB6621.eurprd07.prod.outlook.com (2603:10a6:800:18b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:38:40 +0000
Received: from DB1PEPF000509FA.eurprd03.prod.outlook.com
 (2603:10a6:10:1da:cafe::c9) by DB9PR05CA0015.outlook.office365.com
 (2603:10a6:10:1da::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 16:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF000509FA.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7
 via Frontend Transport; Mon, 1 Dec 2025 16:38:40 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id A24A668003C;
	Mon,  1 Dec 2025 18:38:38 +0200 (EET)
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
Subject: [PATCH v7 net-next 13/13] tcp: accecn: enable AccECN
Date: Mon,  1 Dec 2025 17:38:00 +0100
Message-Id: <20251201163800.3965-14-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FA:EE_|VI1PR07MB6621:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 19c6b623-d8cb-44a4-e0ad-08de30f81579
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?IsNrfhraAhoe+D4UvEVPCWk6EE+iOok55ZXNnqXGpe8lKhGEozQVyO6jQvkv?=
 =?us-ascii?Q?B2t6J3W+BbPj4f8/ZLul5wc5yAkzblB03eitk7kFnFHAmZGQJX5htAeCyyhG?=
 =?us-ascii?Q?v8oQFXDpV+bE+W3GF567GluXDqopzujZdVBKlz91dOHI1V3dmf/0Sjq8O2DY?=
 =?us-ascii?Q?UsLBdCKHTq+Pa91EBV8dhQ2fLGPHWCFA/9htZCFeeiBZ+L2HHtMk6XQL+nqB?=
 =?us-ascii?Q?T2E939Y2oVr/FWDbGOjFFOd3pV+NVOxX32BSG0TuIDs7fyhC4yuEkSQdMr4X?=
 =?us-ascii?Q?xqAmEBLwi38WwDXNKYIFQsZl9Dp4M4FDdi9cJNu4W4o1tdbgXAJGqF6gRt0f?=
 =?us-ascii?Q?w3Hb9eHFPBk53Bmj3m8G70PS9QRvetbIXh7GWCG0XqYFSWl6VvEsXTIwQ5Tg?=
 =?us-ascii?Q?bTEEDozaI58BvhqH8oEVWw9JWAUuuU0QKjXR9SzF2y1OSK59iQ+/f1Qrk6Fw?=
 =?us-ascii?Q?r8FELKf8mvqlK8qP/a9otetVlVh5wFSVBMh7pb8ttUeuqjAY+JadQnxOdULE?=
 =?us-ascii?Q?NyccgJF/aPVzD7psmiMQ1pJxCKTJ5YsALa4R6Degs+tcH7S41MY9VpnOJjzH?=
 =?us-ascii?Q?/cZV6QAiGGyTeuwWktNMneF2tHQclquh0QQPRI/f2E3Fjd+DVljWR5xYF7Xd?=
 =?us-ascii?Q?fxMxlTPtwB7wM84LwUTb0ZRTIR1qLCOafzDEb9/YITb9HievScvn5xNuX2Ap?=
 =?us-ascii?Q?LuQyBdrM0KTgBXznPKqmKXpZU26n9YHkQLi6bBIwhfkAbUJCOYk8dwK0hhG5?=
 =?us-ascii?Q?JyNqZTgplCBkPOFm5Q6Jc/UtOnIHAOt53j5dUCHhD8sZhHtfPJG/cJb1x3Jo?=
 =?us-ascii?Q?HPwq0HogawDulRORq2rpQlZfF2KY9P2vFGA+obduF/QVcyfDQgqA0DT3l7im?=
 =?us-ascii?Q?1ZmObJnnZh/iGZho/aEQsaXldjWBseuERy/PVYGkV58pdeqnafOmtPrKCERJ?=
 =?us-ascii?Q?M96YKld1bgZImbr4osELYECRWmeAV+Mjm320p4EvuG+LNDiwV/O6lRSZg/+G?=
 =?us-ascii?Q?L2G0dxKED9Xj8mZUgfJLGDk9T6fmUmTYkLq0L4Y8w0ltAoEDtpL+ASQOnZ/z?=
 =?us-ascii?Q?nt7Q/U5EXOP6PY58Tj10hT9GllSniCfric/MwCgVlpiM1Dqc6Kgi0TCAB14/?=
 =?us-ascii?Q?NyJAVRsojT+WKLVK0ZJLdISohjD9U6q1zhASDuD/B6tfrX4vU0289PmuH1Rj?=
 =?us-ascii?Q?td0VVtg7zrHGc7GEejOhtxHB4zesDuKFm6Whl94kRNIn1NIbj8kGUIbZN6Hm?=
 =?us-ascii?Q?cHYhLkY2b5ajRA9wrp6sDfaLNPyqDNsl60h1ndAoMAEhOO/0q89RppZdHb5Z?=
 =?us-ascii?Q?XqrEdDfWzsNQBX65VesxhEEzD3WaIqIy2rsiLPSpGSVCgv6tXXyTU0dcuge1?=
 =?us-ascii?Q?4md3sFCJR0r/rDBg3dNhIo8rUSOgpwcrCmN+94IfVQTaMgmvDwvPDoXm8s+c?=
 =?us-ascii?Q?6OkcSKEbKP2uHz4aUkcq/KuAxwI0uC/on7yEpSQIY3E3QnA6xj/CbspSljSY?=
 =?us-ascii?Q?YLlUnxGYvqtJ2x6zS80ms8niNwptaLhUgnJtIYe5JByw4AJT9gD7Bog7/BY1?=
 =?us-ascii?Q?LYbhsIji4PIaFISX+wn3cATDYPFxNGdw0gKLg1DN?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:38:40.2708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c6b623-d8cb-44a4-e0ad-08de30f81579
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6621

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
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/sysctl_net_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 385b5b986d23..643763bc2142 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -47,7 +47,7 @@ static unsigned int udp_child_hash_entries_max = UDP_HTABLE_SIZE_MAX;
 static int tcp_plb_max_rounds = 31;
 static int tcp_plb_max_cong_thresh = 256;
 static unsigned int tcp_tw_reuse_delay_max = TCP_PAWS_MSL * MSEC_PER_SEC;
-static int tcp_ecn_mode_max = 2;
+static int tcp_ecn_mode_max = 5;
 static u32 icmp_errors_extension_mask_all =
 	GENMASK_U8(ICMP_ERR_EXT_COUNT - 1, 0);
 
-- 
2.34.1


