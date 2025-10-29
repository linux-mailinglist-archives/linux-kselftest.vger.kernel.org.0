Return-Path: <linux-kselftest+bounces-44258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C94ACC18EA7
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0240A50670A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0C232862C;
	Wed, 29 Oct 2025 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="N8Owo+pF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88147320A0F;
	Wed, 29 Oct 2025 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725190; cv=fail; b=h1O9qLmNXpyxUI0daaeA86McPhz0JvL186GwNYi5CR9qpgrvDFzlhw1XlgVW17aUiRLRumLZykm7t+EknwuHZn86qS8qkTwpX+pk6AFCw7cpDw7mVwDAeSowlCS0m4rlmIVDDwiZnzcgl3eurUX5LDj9obwbtDSHjue3Tn8wjoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725190; c=relaxed/simple;
	bh=l6H9XJvnhG6bON7Rl8rpQN6rpvhkY37F8A87/A0gZxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgZDAFVD0DQeSD+CIkL4YpYTNjA8woylKZOyAboqfSdhAOnOddyt7jrKHcHgEdyiZEmyacy8O1s0TcWiYVfTWtQHJM9LVsLaa31YGpFCEcrjyUm3eZMGbLE/C9uo5i1s7eEwuPzld8/AxyvhVoUe0SbVZTvjqMRyh+foUIPLJSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=N8Owo+pF; arc=fail smtp.client-ip=52.101.84.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v385iwQ5ER2W1UqCOqf+PxBmKvYZUoYRoWYHyEW4nKG2SzKF2UyTnpu6ehZzNqIW9vyTmmRArfxI7c9Pmy8PX47zsMMxNXthyeIZJ7aUvkHJGk8abMqlEoPWm1adsPDlfZzpkHSDsbjwoD2AuvwKYQQ33SLG615OEENi43Y2j6ooerOI2n7LwysgFApPEFMqCqa05WXJstj1JcxaDa3fqA8aCq/9tHT2tolaBuxsguA9fnxxJc10DGGDmiTPb2eaq70zvesnwu5TUUYmPdOxg7MqyM/BEydUAawT/0aKA6koIh2QA0K9jLg7oF7IIpSmNN/qE0UIyENvKG9gJ8RBcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4v2Qstt/elvyDmqjqmlNYSrGnYpXwrJ24ZaqWaGy38=;
 b=OmqXWvIuBoBpb6c0WLeDka05YM/JPztsvRWoTFJEH0Uz9x5or/dYLolpfF3q5BWCEkL527LlMbukAygfD6bsMsl+oIzAsrZ9ZNZ6z5VbDcDE7y978irK9KTfz7fsqniG6RQa22MrsHhAd9GkH24N7PIqKGFZzjD0pt7+UftDhpuJNYiDVzbFSTy/lK1swVnH6rFbHvuZ60sj2plkTrw6Xgq9bsmuD0itQ3QJb1d5KeUoqJwK1OsTqZjXJErQ8BAjGdJt1SMCylsvyeNQ1TBszctgpS2JVayVTkzENO0W9DWpc9dHCwRR5+r7y1zIsXxX91Opp8VZ/zy0DUkZ8cdOKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4v2Qstt/elvyDmqjqmlNYSrGnYpXwrJ24ZaqWaGy38=;
 b=N8Owo+pFYAN6pwJsZSkkArp+8E6b4VqRxtFhyeFwtZXEyCnxqRl6ljhMVPbiu2yanyT+nwxEbtePhVyEAzFszhtqbo3diNtMSTfspXuyJYBoTWdQG/1JaiUZFgeMcXVtT/Fay/RmYoQ1We+lWooaQ0Q+qTw5mJJL/m41zZZQknKqqd91nTy3mllnK7c4O2AQCTxslS6rzfFQ3/F730OySf8RAN048a+9oOiDRQ687I39wezLZb/7xXsPdK7OkoWCaVzr555LxZ1EgkuHXy8P3zCD/HguVd8eWzZhnduU8C+Lb6TbmnkNukfJreKpH8APe+PmCfLIIbkdcEJBRR+wMw==
Received: from DB8P191CA0020.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::30)
 by AM0PR07MB6434.eurprd07.prod.outlook.com (2603:10a6:20b:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 08:06:24 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::86) by DB8P191CA0020.outlook.office365.com
 (2603:10a6:10:130::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Wed,
 29 Oct 2025 08:06:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Wed, 29 Oct 2025 08:06:24 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 1DCED20308;
	Wed, 29 Oct 2025 10:06:23 +0200 (EET)
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
Subject: [PATCH v5 net-next 03/14] net: update commnets for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
Date: Wed, 29 Oct 2025 09:05:57 +0100
Message-Id: <20251029080608.92428-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF0003922F:EE_|AM0PR07MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 490eb6b2-0a79-467c-e128-08de16c20dfe
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZVRCTWhqdzVxaHRpUE0yRDM5Ui9qWXFiUTE2WE9SR25GOUVkZWE5WGNGTkp1?=
 =?utf-8?B?aHh4a3MwdGRwQ2hsUEZDQXk4NUtsY0Z0UU4wNUMvSU9saTBaWlE5T2xxRUFo?=
 =?utf-8?B?em1NbFU0Q0tIK1RCTm9kMmFWTlpvSzkyS25yeXJ3NHlDZHdyeFFkUnpuSHJT?=
 =?utf-8?B?K2M1bXhQa1Q3SGhXWkdqdSswZW5mREVDZXc4RWRhUi9TYld3eGhDNkdlNWxR?=
 =?utf-8?B?RUdDVkdJR2xLQ1hoMVlOL1UzanRqTWh5cGJMZ29rNk43dkZCY28xNFJqenpk?=
 =?utf-8?B?OEdzUHgzdnVHUnR0K2JrbHRZcmpzTkNVdzNzUmpIRFV1aGsrWDJSKzd6c2dn?=
 =?utf-8?B?ZlZyN3RCRmN0NWUzSG9MTFdRRXpaL0pDOHJWc0V5NDdxeFprRkdKNFJkRWxt?=
 =?utf-8?B?VlVWNGhUY1R4L2QweE1RM213aEp1UERBUkFLc0JoeUd6Skl3MzdUK3lEWi9a?=
 =?utf-8?B?YmlGWXZpdkZ3amdwTTZoanBMbXo2QllpQTNYQ0h1cXYyTkFjTmdQcU53Y3Bk?=
 =?utf-8?B?QWg3Mm1iNEFlMkp3UlFaaW9vNjBmb0o1ZGpvTWVMTzRUdFRFdk9aMk95V0No?=
 =?utf-8?B?UVViZ29vTjRPWUEzbGlORmJ1dVFxU0NZNklWY1VrdmozNTdEaEpvNm8xcndS?=
 =?utf-8?B?VnRtb1pibW43Uk0wRVZjam9sbmRQRmdaM3lpVlpyd29NdmxKSVR1ako4a1hh?=
 =?utf-8?B?RG1sd1doVHNTRmZvSnc0RURFZDlXK3BjWHdsdzBhV2o2aWg4ampIUWtCMWY1?=
 =?utf-8?B?Ri9rUEpEMlNaQ2l5Z1ZkZE1tb0JFZm1CbmthTkpBbHNmTFFkNVpWeHRTZGVk?=
 =?utf-8?B?bkgyWHBHcE01K0Ntcm1aWWZtOWk1K0VTakhuOEJlZVFzYTR1SGdrVzFSWjlW?=
 =?utf-8?B?cTVhbXFTVUc4QU1sdkx4UmlkQjE0Sko2cTBadWdyZGVOWVpnQ3JvbkpYbDI1?=
 =?utf-8?B?UTA3Z1YzMnR3cmovQytZWGVqSncwalZiZ2VwU0lJQThlTzJZSTV4bHc4L3B4?=
 =?utf-8?B?cmo3SEtJblQ5MjltSjJMSE9wUk9wTytVYy96WGRsTHMrc3pDZllDb1ozdDNG?=
 =?utf-8?B?MzZyd0dYUEJYbEk3cm1kcHBUNFd3SkEwMllnZUpLNXRTQk4xbTRLVFVjUm1z?=
 =?utf-8?B?TGlvalVzSDRZL3lRZXBub1A3Zmw3Q0lVUTkvN01wa3o5UnNGR0FKVFNMQXVJ?=
 =?utf-8?B?MWZWSFJGMnQzK282RWVrZG5PeldrWFhVbTNHQVVrcUV0N292K21PUC9MUjRs?=
 =?utf-8?B?cWVUeHlLU1FGbVFhcFF6M1pUbVZhdUxWNnRxMHRNY1FVdktYckFnL0N2V1Zq?=
 =?utf-8?B?bTU1M0FRREdHd3VLWXM0V080QkFMUzBMcU1IQUgvMG8xOTZXeGxmdWJaM2xP?=
 =?utf-8?B?ZnBMNSsxUXZlSXZGQmVwd0V1WFVvMG9mUnd4NDIvREwxSGFiQi9ITy92dW1w?=
 =?utf-8?B?SkJsTllDcGYwS0VUNkNzd2sxTkQ0RUVDL0N3YkQ0Ti9HZktLYnFJeXI0VzRI?=
 =?utf-8?B?Y2xsNEkraXpWY2pjQnBJNDBMVlNUdFNmTEVJY0RmUklrbEhVYWIyU1pXM2pM?=
 =?utf-8?B?M0RWZ3BZbCtLbEtrRnpYVE9wSGh4WGUvbk5NeVl6VUwyVGhvRnZKY3ZFUE5L?=
 =?utf-8?B?TXhRQ2tMWHhGYXlIdDdTNVcrc1dJM3RrY3liTlNTR0tKdVR0cC8vNDhCckxS?=
 =?utf-8?B?akV4SVhBN1k0aVM5aWFTNStGT0hyWFg5UXlTSFVKVDRmS1FpTnlSRjZ3SldD?=
 =?utf-8?B?K0s3VjdnMjY4K1ZTbTZBRVpvOEFLMG8rZWR4MUtTU0Fmc3ZZVEJMemVobkRD?=
 =?utf-8?B?L0Rtanc4enNHNzRCTmNjMXgwQ00xalhZTG10MWJpalRwb1lyQlhKYy9pRmpq?=
 =?utf-8?B?SHVlQWViL3haOXd2M241VkNzaTRLZnh6d2RoQjFaS0pCUUZGLzFxUkdFNS9t?=
 =?utf-8?B?am9qN0tyMGFHQnFLRWthdkJIZDNOb3ErRUh3eW1FRW04ZElDc1N0UlRNRU1E?=
 =?utf-8?B?V1ZvcFREU2xzOFpiSmg4L2VBcjdQbkY3MmU0cUVQdVltSDd2SGlESGl5L01l?=
 =?utf-8?B?WjJDdHliSndpcHFXdzN3SXUvaEhrMnRjZlhNNDk0QW9aSnJsaTBPMURMMFpo?=
 =?utf-8?Q?+OfE1tghWCddIGc1i4FwfZ9oP?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:06:24.6593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 490eb6b2-0a79-467c-e128-08de16c20dfe
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6434

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

No functional changes.

Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/skbuff.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a7cc3d1f4fd1..74d6a209e203 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -671,7 +671,12 @@ enum {
 	/* This indicates the skb is from an untrusted source. */
 	SKB_GSO_DODGY = 1 << 1,
 
-	/* This indicates the tcp segment has CWR set. */
+	/* For Tx, this indicates the first TCP segment has CWR set, and any
+	 * subsequent segment in the same skb has CWR cleared. This cannot be
+	 * used on Rx, because the connection to which the segment belongs is
+	 * not tracked to use RFC3168 or Accurate ECN, and using RFC3168 ECN
+	 * offload may corrupt AccECN signal of AccECN segments.
+	 */
 	SKB_GSO_TCP_ECN = 1 << 2,
 
 	__SKB_GSO_TCP_FIXEDID = 1 << 3,
@@ -706,6 +711,12 @@ enum {
 
 	SKB_GSO_FRAGLIST = 1 << 18,
 
+	/* For TX, this indicates the TCP segment uses the CWR flag as part of
+	 * AccECN signal, and the CWR flag is not modified in the skb. For RX,
+	 * any CWR flagged segment must use SKB_GSO_TCP_ACCECN. This is to
+	 * ensure the CWR flag is not cleared by any RFC3168 ECN offload, and
+	 * thus keeping AccECN signal of AccECN segments.
+	 */
 	SKB_GSO_TCP_ACCECN = 1 << 19,
 
 	/* These indirectly map onto the same netdev feature.
-- 
2.34.1


