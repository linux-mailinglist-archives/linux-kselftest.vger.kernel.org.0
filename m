Return-Path: <linux-kselftest+bounces-41871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F791B85FE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D18B1C84A63
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989453176ED;
	Thu, 18 Sep 2025 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="YfIb7teD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010002.outbound.protection.outlook.com [52.101.69.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547592E5438;
	Thu, 18 Sep 2025 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212512; cv=fail; b=rhy0Vf2jPpNJzHp8E1ThbYGnpMzfY01e4RN9/ZqW8B7TkMZ+6ZmVgr7Pb/zrUBd/EHJwqagPrdd3UPpnYSPDwwhIBu9mCAse09z391KQtjwiuLKAbfGw1KGT1RgmvLK7yT7wvtobXVZ2wvbm5YIMTL6iRddkZVlVmpHteU6NxFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212512; c=relaxed/simple;
	bh=wEiBuP8JvHia6JyVaKeuj+gcIngGNKNdvldJc8CC+vc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jen9I4o2aSkSObcE+YOi8OimWQVCqniM3IwFLhMr9T17MBOioCpCD20nUKzfXDe9evT+BZtoajWYexTTHxpq97GX8XSnkPBDrwFu2nCDujyE1LIMLgJbvWzIaWvmDuGNoPOfYrvbe3lKHe8FtS303IziuLr5LqXQ2Hxep8lPcns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=YfIb7teD; arc=fail smtp.client-ip=52.101.69.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmti6PdLQD1Fo+7OggF/dOvJUOEBRaq5AMsxBSc+tcCjOUtA/797a3mFDmpE9rWj/Ak0+KiP9vVeBS/pXni6MMczC9CLitpAQz3hGgwtxUzAN9zRkFY55Cphg01QJp4WYoBxueAZsAtYBWy6KK1Sv1l3hvKfaOeE6aa1Z5PG87sQ4MGAOK0KL74tcSfR8uSnLRDJj/M6zgv6dKAb9sIVSOmDPAo+jALd3O1r78IRYEgKC29GE2CQFbD42ESYKBHAfQH4iphsEm0TOt7HariWmhuc7wEoSYw5AibBXOZp5Y6Wz2jmmBwD3CUQrx7o3yxulkJAS7FZE3Uj67dcl0ivrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQDFSiFReiwMVe6w9fPHOLBdk3nKXlIDcf23DG892n0=;
 b=ZRMTwtL04vYeBE3BjISUuwPcFhVm5eJSGIFYxmk/+ow4Ym/8/i3YOJsIgPH9lkSyY41m7x47mxKy64Lr9/k+WXI+z212ENVPee5NU4E9No/GCkJzhtBRe0DFokCm4I4FhP+t4DjYZOehjJ/ccBbrDKJkhq+VT1OFMuT8BUbh7r8ht7I/vxf3mnPfUl0EYR3eCOv/OCFpN2+G/HKjrce3KzXyLDew9yZ+tLUOwEpUxc/BnQuEKyLm2XK1gcr8lLHcsSZoq5tA/G+KHIjDZ8e9vk9dxyq50mDebo6Izbq/89MmccrBJbKdL8w9TbZuh2W6vOgj9YnPangCmiUkHUjGmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQDFSiFReiwMVe6w9fPHOLBdk3nKXlIDcf23DG892n0=;
 b=YfIb7teDrSARlQsazYlZw/8CO9DC65hb7Y/sMZDHDCfasQlSa3Lq3CwLl4jWdU2sgVf1jISG5LKrrSUqNWGOiMRN7Tt50O3l738U0iDk/SiLKGBvCVMc20kyMmdCvE9qyJLmO1ceACLWyQ4Nx6pXe6K/x3GHRKzREKyXfL/iYu/ml1SGqn806+eh7GKsPRQ0lUtwHXj0dLvEM8mm2ZcFLvZstPDxjVQZh31MYIVK9/4ubepGnM1C/0dU18w14xpnmmoXz2Slwmr+SdCB8UxDoKaGg7uwA1X9jk8ISjmxhJqi5cbPP8kUCJyAHxwU8abd3TWN6lsMmlnPnBVNe4wPHw==
Received: from DB9PR02CA0019.eurprd02.prod.outlook.com (2603:10a6:10:1d9::24)
 by AM8PR07MB7540.eurprd07.prod.outlook.com (2603:10a6:20b:241::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 16:21:44 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::76) by DB9PR02CA0019.outlook.office365.com
 (2603:10a6:10:1d9::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 16:21:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Thu, 18 Sep 2025 16:21:44 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id EAB05200C6;
	Thu, 18 Sep 2025 19:21:42 +0300 (EEST)
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
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Olivier Tilmans <olivier.tilmans@nokia.com>
Subject: [PATCH v2 net-next 04/14] tcp: L4S ECT(1) identifier and NEEDS_ACCECN for CC modules
Date: Thu, 18 Sep 2025 18:21:23 +0200
Message-Id: <20250918162133.111922-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E6:EE_|AM8PR07MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: ce3d96f2-0a47-4447-e28f-08ddf6cf7578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akVWdW85YVdCc1F6WjEvZW8yUWZMby9lQ2VWTXNtRytHdVZDTWRiRnVGY1No?=
 =?utf-8?B?Y04wNVNTMzNJd0h3aUxZVzNNNHhudDZzODFUcTlHZ3B5OEdqVkt1ODQ0cXh5?=
 =?utf-8?B?RFpMUnZtUzZpYWkvSkJpcW9sQ3hSSnByV2ErZlg0VnNsamlaNEczSnlVWW1Y?=
 =?utf-8?B?cG9GWE5zYWYxZ2l6aEtZY3ZZMmswQyt4N2NCY3RjQnJZMHRaN2tLYXFqeUtF?=
 =?utf-8?B?Y1YzY2VOaGFHbklBK2N5ZzN0MTlld0MxNTJjcDJNTTIxdkFONTQ1a1J4MlNL?=
 =?utf-8?B?SlhOc1lrWmlQQWVUcldWc3V1ZEtNdUdRZkRFWTR4UTViQWR5TXZYLytLRXha?=
 =?utf-8?B?dHV4WUlCdE9TZ0lmcDBoWVdyY2pjaUNlYzlodkczaE40SENKcEN2UjBpYlZY?=
 =?utf-8?B?U2NwbUxES2wyaVNwcVp2NzhQOVBTWklDYnpoOERoeTN0SzllNysxY1Q3dG01?=
 =?utf-8?B?OFNMQkZqZjJpSldJR2hYdTNBcmZsKzdKTFNUbUM2NUlrRmI2SWRHQWg4RjJv?=
 =?utf-8?B?VDBVVjFvUVB3RlMrT2g3YktPRkVoYldRRWhoUGE1Nkhoa3J0ZDZxUUliTjlJ?=
 =?utf-8?B?cGxETzZDQWRkSTVucVluUHMvRXZDa2VUNjBhSGVBQk51ZjJWUWJSOTMvc1Y3?=
 =?utf-8?B?dUhvWFpMWUFoQjg1WndaU2NGdVBJY0JaaFpDdzQvb3FUTWVaWUxQd2FBVlRK?=
 =?utf-8?B?YWlSMTlwcjlNQUpKMC9QckhNYWlWVW1RWWlJajE2dlc0RWZyQVFaTjJMcmFK?=
 =?utf-8?B?ZEhTQ3crNkVSeDA2em1sc2Npd3JMOTRJcUt6VGZ2UXJuZjVoR2pjdXIwczlm?=
 =?utf-8?B?ZEUvMUJYTW5sQkt2aHB1Tndlbi9nWTJMNVNIc1V1UlQrNExPNHU5QUFIaG5y?=
 =?utf-8?B?SGsyZHZhV3diUkhpTlhsRWtFTGIzTjlMYzM1T1RpelJLTXFBbENjdmxRM01T?=
 =?utf-8?B?T3NVb2xYUXVoR0t6Q3hYN0NwZUl3eTA3cXYzT1dDQkJ2a0JFc2kwMk1aTlk5?=
 =?utf-8?B?R3FFUDgvMUJnREplenhndUttczQ5NEVFMytGWkNRejY2TlVFMkJIeWdCYnh3?=
 =?utf-8?B?SGJ2UXZZN21xdDBVTTdtaVMwby9MMmNVcGpyZVl4bkNwYkV5TjZPK1RmSGhI?=
 =?utf-8?B?cVJHYzNuMFo0V1JvaGZVc1pzTU1uRCtHek5xb0NjTG9MZnd3WHFxcnNIZlRM?=
 =?utf-8?B?Z1J2MlBWbkpwSEVzMllrTi9WQ2I3dlBvMDMxQmRUa3pwRXI0Smg4YnhOdUZx?=
 =?utf-8?B?STYyUnV4S3J6NjVwbWZnZ05obG1vZGxmaDVKUlordFFNcnhBU3g2Y2pZY3Z0?=
 =?utf-8?B?OWN1ZUFkSkdBcXFhWWtOZDIwQWVZZmxwZ3NoU0tDQm8wcTgrUUJZT3ZCeDhB?=
 =?utf-8?B?TVBacGtDR09jYlU0NjRVRGEwaDdKWktaL2FsSVpmcTMrNmZ0emxSdmU2L1Jl?=
 =?utf-8?B?NkZsK1RtN0tHb2JOSWpweUE1YVN3ZlRjR3h5bk5pdXdSWStJako1em0xNVlo?=
 =?utf-8?B?RE12ck5ka211L01NN2JXU3loRTh2Qi9hMFhQVnRXTkNPSUxGRWt3Y0NSQ2NF?=
 =?utf-8?B?b2tWaTNQSU1ldVJ4QnpuenBuRWNMY3hGbHdsSytLMlBrL0xmV1RVREZnd3l2?=
 =?utf-8?B?SWJoWk42aUl0TDlOaUtLQXpPS0pGdkhqSnBWTjFZamJvNGRGRFFqUnpVOHhS?=
 =?utf-8?B?eVpiWFdDR012cjE1MzZXVm1HUE15dlVrUEhsYzlFaWs5bXRiRkdZYjJJWGJJ?=
 =?utf-8?B?dkFqYzhzOTdadnNwRGlDMTdlb2pGNTlGUGkyOGlpYU9PT3FuRTk5dEFyd3ZK?=
 =?utf-8?B?OFU3TzFhU0NxaFBHelk2alM2YzNZTFl2dkpaUVhkWEpLQkNPanFLRkQwNjRj?=
 =?utf-8?B?bXJESGt1a2xwelUwc3V1R3VDdmg2OWx2OUJZVk4zKzNldWtTV2hQYzZwMTRz?=
 =?utf-8?B?dmlVcFIxYkRDMTRrVmxocFV3UTQvWHZMeVo0ZmlnVGZDQUw0RDFyWVF5UnlW?=
 =?utf-8?B?VTNBaUU1UFA1TmxuZVljajBpUmNBNjhsL3NRbnZLa2JxMlJzY1NTZXh4akV6?=
 =?utf-8?B?L2VORklxeDNqQjY2aXlacldqZXNDTmI4ZkE2dz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:21:44.5177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3d96f2-0a47-4447-e28f-08ddf6cf7578
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7540

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Two CA module flags are added in this patch. First, a new CA module
flag (TCP_CONG_NEEDS_ACCECN) defines that the CA expects to negotiate
AccECN functionality using the ECE, CWR and AE flags in the TCP header.
The detailed AccECN negotiaotn during the 3WHS can be found in the
AccECN spec:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Second, when ECN is negociated for a TCP flow, it defaults to use
ECT(0) in the IP header. L4S service, however, needs to se ECT(1).
This patch enables CA to control whether ECT(0) or ECT(1) should
be used on a per-segment basis. A new flag (TCP_CONG_WANTS_ECT_1)
defines the behavior expected by the CA when not-yet initialized for
the connection. As such, it implicitely assumes that the CA also has
the TCP_CONG_NEEDS_ECN set.

Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/inet_ecn.h | 20 +++++++++++++++++---
 include/net/tcp.h      | 20 +++++++++++++++++++-
 include/net/tcp_ecn.h  |  7 ++++---
 net/ipv4/tcp_cong.c    |  9 ++++++---
 net/ipv4/tcp_input.c   |  3 ++-
 net/ipv4/tcp_output.c  | 10 ++++++++--
 6 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/include/net/inet_ecn.h b/include/net/inet_ecn.h
index ea32393464a2..827b87a95dab 100644
--- a/include/net/inet_ecn.h
+++ b/include/net/inet_ecn.h
@@ -51,11 +51,25 @@ static inline __u8 INET_ECN_encapsulate(__u8 outer, __u8 inner)
 	return outer;
 }
 
+/* Apply either ECT(0) or ECT(1) */
+static inline void __INET_ECN_xmit(struct sock *sk, bool use_ect_1)
+{
+	__u8 ect = use_ect_1 ? INET_ECN_ECT_1 : INET_ECN_ECT_0;
+
+	/* Mask the complete byte in case the connection alternates between
+	 * ECT(0) and ECT(1).
+	 */
+	inet_sk(sk)->tos &= ~INET_ECN_MASK;
+	inet_sk(sk)->tos |= ect;
+	if (inet6_sk(sk)) {
+		inet6_sk(sk)->tclass &= ~INET_ECN_MASK;
+		inet6_sk(sk)->tclass |= ect;
+	}
+}
+
 static inline void INET_ECN_xmit(struct sock *sk)
 {
-	inet_sk(sk)->tos |= INET_ECN_ECT_0;
-	if (inet6_sk(sk) != NULL)
-		inet6_sk(sk)->tclass |= INET_ECN_ECT_0;
+	__INET_ECN_xmit(sk, false);
 }
 
 static inline void INET_ECN_dontxmit(struct sock *sk)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 23f0355d1991..4b255b92cb42 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -402,6 +402,7 @@ static inline void tcp_dec_quickack_mode(struct sock *sk)
 #define	TCP_ECN_DEMAND_CWR	BIT(2)
 #define	TCP_ECN_SEEN		BIT(3)
 #define	TCP_ECN_MODE_ACCECN	BIT(4)
+#define	TCP_ECN_ECT_1		BIT(5)
 
 #define	TCP_ECN_DISABLED	0
 #define	TCP_ECN_MODE_PENDING	(TCP_ECN_MODE_RFC3168 | TCP_ECN_MODE_ACCECN)
@@ -1189,7 +1190,12 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NON_RESTRICTED		BIT(0)
 /* Requires ECN/ECT set on all packets */
 #define TCP_CONG_NEEDS_ECN		BIT(1)
-#define TCP_CONG_MASK	(TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN)
+/* Require successfully negotiated AccECN capability */
+#define TCP_CONG_NEEDS_ACCECN		BIT(2)
+/* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
+#define TCP_CONG_WANTS_ECT_1 (TCP_CONG_NEEDS_ECN | TCP_CONG_NEEDS_ACCECN)
+#define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
+			TCP_CONG_NEEDS_ACCECN)
 
 union tcp_cc_info;
 
@@ -1322,6 +1328,18 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
 }
 
+static inline bool tcp_ca_needs_accecn(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
+}
+
+static inline bool tcp_ca_wants_ect_1(const struct sock *sk)
+{
+	return inet_csk(sk)->icsk_ca_ops->flags & TCP_CONG_WANTS_ECT_1;
+}
+
 static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index f13e5cd2b1ac..bde5835a30f0 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -561,7 +561,7 @@ static inline void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ECE;
 	else if (tcp_ca_needs_ecn(sk) ||
 		 tcp_bpf_ca_needs_ecn(sk))
-		INET_ECN_xmit(sk);
+		__INET_ECN_xmit(sk, tcp_ca_wants_ect_1(sk));
 
 	if (tp->ecn_flags & TCP_ECN_MODE_ACCECN) {
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ACE;
@@ -579,7 +579,8 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 	bool use_ecn, use_accecn;
 	u8 tcp_ecn = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn);
 
-	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN;
+	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN ||
+		     tcp_ca_needs_accecn(sk);
 	use_ecn = tcp_ecn == TCP_ECN_IN_ECN_OUT_ECN ||
 		  tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ECN ||
 		  tcp_ca_needs_ecn(sk) || bpf_needs_ecn || use_accecn;
@@ -595,7 +596,7 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 
 	if (use_ecn) {
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
-			INET_ECN_xmit(sk);
+			__INET_ECN_xmit(sk, tcp_ca_wants_ect_1(sk));
 
 		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
 		if (use_accecn) {
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index df758adbb445..f9efbcf1d856 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -227,7 +227,7 @@ void tcp_assign_congestion_control(struct sock *sk)
 
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		__INET_ECN_xmit(sk, tcp_ca_wants_ect_1(sk));
 	else
 		INET_ECN_dontxmit(sk);
 }
@@ -240,7 +240,10 @@ void tcp_init_congestion_control(struct sock *sk)
 	if (icsk->icsk_ca_ops->init)
 		icsk->icsk_ca_ops->init(sk);
 	if (tcp_ca_needs_ecn(sk))
-		INET_ECN_xmit(sk);
+		/* The CA is already initialized, expect it to set the
+		 * appropriate flag to select ECT(1).
+		 */
+		__INET_ECN_xmit(sk, tcp_sk(sk)->ecn_flags & TCP_ECN_ECT_1);
 	else
 		INET_ECN_dontxmit(sk);
 	icsk->icsk_ca_initialized = 1;
@@ -257,7 +260,7 @@ static void tcp_reinit_congestion_control(struct sock *sk,
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		__INET_ECN_xmit(sk, tcp_ca_wants_ect_1(sk));
 	else
 		INET_ECN_dontxmit(sk);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 6f7c2f0fc0f6..b0557f72f3be 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7216,7 +7216,8 @@ static void tcp_ecn_create_request(struct request_sock *req,
 	u32 ecn_ok_dst;
 
 	if (tcp_accecn_syn_requested(th) &&
-	    READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3) {
+	    (READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3 ||
+	     tcp_ca_needs_accecn(listen_sk))) {
 		inet_rsk(req)->ecn_ok = 1;
 		tcp_rsk(req)->accecn_ok = 1;
 		tcp_rsk(req)->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 223d7feeb19d..18bbb30381f0 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -328,12 +328,17 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 			 struct tcphdr *th, int tcp_header_len)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool ecn_ect_1;
 
 	if (!tcp_ecn_mode_any(tp))
 		return;
 
+	ecn_ect_1 = tp->ecn_flags & TCP_ECN_ECT_1;
+	if (ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp))
+		__INET_ECN_xmit(sk, true);
+
 	if (tcp_ecn_mode_accecn(tp)) {
-		if (!tcp_accecn_ace_fail_recv(tp))
+		if (!ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp))
 			INET_ECN_xmit(sk);
 		tcp_accecn_set_ace(tp, skb, th);
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
@@ -341,7 +346,8 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 		/* Not-retransmitted data segment: set ECT and inject CWR. */
 		if (skb->len != tcp_header_len &&
 		    !before(TCP_SKB_CB(skb)->seq, tp->snd_nxt)) {
-			INET_ECN_xmit(sk);
+			if (!ecn_ect_1)
+				INET_ECN_xmit(sk);
 			if (tp->ecn_flags & TCP_ECN_QUEUE_CWR) {
 				tp->ecn_flags &= ~TCP_ECN_QUEUE_CWR;
 				th->cwr = 1;
-- 
2.34.1


