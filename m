Return-Path: <linux-kselftest+bounces-45615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 615A6C5BBBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11CC84F4175
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 07:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26422F60A3;
	Fri, 14 Nov 2025 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="N650IREI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010009.outbound.protection.outlook.com [52.101.84.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99602F5485;
	Fri, 14 Nov 2025 07:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104444; cv=fail; b=sDJUjP5sbasNQlJOSVlhPbrFFGp16lcXj/YuTgobPVfBiaFdplH+mp6Opm55Cg7LEPZ5n/CiJPXSXpsbQmkj8pJEP/kPs8AInqw/kwjrXj19eQojsvXht0T1zr88QL9/HREqoeUnm/RpKMl2fQNa9OBl+lVQc/xlC7fmzewUSSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104444; c=relaxed/simple;
	bh=hcQEcIIkEVeWwKdO9vweCqUMdE+FQyMK3YD99LZxBmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkLsshRQIhIR3OxeBOC1QchtxOWyZtdLlOlB5gLniCMQ/g5dPHWli+qutDMqodUIqmpMs3RqeeYMSIfckJplFsLY+DRzeNthJSaU7HcVhMj2CQvDQ1/HlbdSM+KDy4HlseQoD9lyvu1abLwRyLquqzWQO186yLObwb12jz+nA4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=N650IREI; arc=fail smtp.client-ip=52.101.84.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmZVRgqC+BX1xxiBmFmYrUthsXV7B3uMuT5rGkEPl2yM8iQ9o3DMNjTBorKuFdh6492TmUjxsB5Qk56VSviUiDfILgSNkD0Ckjy/seRZJnMN7bEStki+Z7c9wEek+GJgKymkgIb3EEaRayHK9dRCi9HL0o2sW86OwjbJokk3GpgMgFTxvsSRGuX6tBeRmKjx31CA3FzjQB6+1KukkNATX86eRUpE/3VXPs1CxBKsnS/ZK4LsJVntMTh5gqOqjafR4EwbqqRScqJ5y5bUexLCcTkNHNWZc0ZMOwEdDyYQrbXYknZJRuElrrD2JgYC9fqU34tE/Gb0DWChU+OBhQcXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTCz21CqQhYMDj5mOv19CdTnzp4Dm5xfF7x5ufBDDg4=;
 b=DvLddibEdH5Eo4cQ66UEYPmgBlmHbMluY1GoaPVyLyqDVLmp+p9HxIKlR3EWeHfw6Ndb519IuZQKzi/ULjW4jUM/6cisXl6+d/KGfhj6ldE93TvjjF/lz41/2xUEG+PHp+bwGqg7qHqrk6WFt5+TvcxoICdbebAVeZNs3aJSZRFptYqRsoapscGcdZ6ibv9KLn6gvBe5giQfQSOLO8gqHDVy9pTRPWO6vieARhDKqlWXDcyGIyZJ/kOQ3/NK6MjE+Mm87MiQHvxqhY1mZWC8y4QR6myGq3xcvSMTsVeV8BRrQxbD8R4iie4guKYsx2Ab71Zan+Qj8B0xMcs8IN0AEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTCz21CqQhYMDj5mOv19CdTnzp4Dm5xfF7x5ufBDDg4=;
 b=N650IREIAGL+WzNBp5aufSr3Sz86QnrmenyhtIIWjTCovbNewBApj4vTbtAzMMiQ95znW16YpZNst2Juv1YFEMO/7a5jfwsCgfO3QYRSMzDRGr6kyLcH5ibToPxirWMKqNd0ilIlP2+++5+4UATzNKCD/LoBYES32TNAlFFeGnKQ/TCXFLbK1WpB/9/1Sroh80cihcTQB1KJ0VTPYA1tiahs6LwR6x4MZJFFgXipchE+TRJr1cbjbqtKkY7euGALO+zKyGXRB61DDwjidDa/n0FsoFLcQf+nMBwrA05Y9++evTFwSZPX1JTuBgTKb8/myIaMe3KrpN59JbpLRT40Dg==
Received: from DU2PR04CA0057.eurprd04.prod.outlook.com (2603:10a6:10:234::32)
 by AS5PR07MB10108.eurprd07.prod.outlook.com (2603:10a6:20b:676::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 07:13:58 +0000
Received: from DB1PEPF00039232.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::4d) by DU2PR04CA0057.outlook.office365.com
 (2603:10a6:10:234::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 07:13:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF00039232.mail.protection.outlook.com (10.167.8.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.13
 via Frontend Transport; Fri, 14 Nov 2025 07:13:57 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 576E41C0037;
	Fri, 14 Nov 2025 09:13:56 +0200 (EET)
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
Subject: [PATCH v6 net-next 03/14] net: update commnets for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
Date: Fri, 14 Nov 2025 08:13:34 +0100
Message-Id: <20251114071345.10769-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039232:EE_|AS5PR07MB10108:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b54e85-72a6-4c3d-acba-08de234d6100
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZndqeHR6TndVU2lGU0pWS09rY2N2emt5ODFjYUNvc2srQ2wxZUF4S2xjaFRR?=
 =?utf-8?B?U1hSYXUwMXJPREFOdDh6Mjk4bGxheUlERnM1RW9hbHgydllZd2Z2b1hMRkFK?=
 =?utf-8?B?ZjJpbU0xMlZMWnkzT2RHbGtURnVHME9LajFBL0F5NEFxVTFSS1YzRXQyaW0z?=
 =?utf-8?B?ZjBWejhjUTJhMkROMTFHbG53REJ5MmYwelc4aW1WbWRZbURhVTNCVFNBRGx1?=
 =?utf-8?B?dlVVTnlUclNabXRvU2h3TUVkendVL0NaRVJqWDB6aWMxY3B1MFQ2OXRFb0tJ?=
 =?utf-8?B?UzhVRFBCY3YvMFFaWWxqdFd0RTRWa2VzS3FEVXlTSUpNRXVER08rVm1DbnhV?=
 =?utf-8?B?T29sYzFQZ1cyVVQxZW85S0NkNDlQbDNlVXo2cE1lSWJpME5YcWFJYXRHUkdl?=
 =?utf-8?B?ZHI0ZjRaUlVBcG5ud3JZaDF5Mm9XVjJQQ1JGd0FlSXgwdEpqMEJYdnZiVGVK?=
 =?utf-8?B?dGZmODIyVjk1MWlTOFNtTXdjenZuekw1eVN3WlVQR2dJOU1uTHp5ZDBFclZp?=
 =?utf-8?B?VnNvRXdYVUx5RXJuRFBsekNnU2lra2ZHbjV4amUxZzdXTW1YclZmUE9OdEtv?=
 =?utf-8?B?eFlRUkp5ZkdmNklXZTVYMXpjdm5qMGRpS3c4NXMzMHZTQUdqdjkra3pGRzhp?=
 =?utf-8?B?VkZsTGU2NmRReEViTjh0NzAyOG5lMWpiZWp1Z05ER1E0MVZ3d0FQeWhLOUFs?=
 =?utf-8?B?citIWFFSNU5OSXczNGtLQUJHdjRUbU0rWGpoWkdOS2FjeFFYTzZSZVBnbWhW?=
 =?utf-8?B?RFdiM054SXJXK21BNlN3bEt4UzNNK1NlWjEzVmJiMmVWcmFlb3poY0p3WE5S?=
 =?utf-8?B?ZWY0cE4xUmxCa0E5MVBYdDdRMnJuSUxYd0ZDNS9ob0NEcGJkNmJ6YWhtN0kr?=
 =?utf-8?B?cjVkUTlhd0F3VmZoVVV0WVBjS0tUY3ZOYUNKbEhJWnhWY0JBSVZ3T0tNWlpY?=
 =?utf-8?B?eEtEeDR1c3FsNDc0TFpqV09CZ0tlVXFQNDhSR0xNczQvZ1p6TlZLTk5ZbWtm?=
 =?utf-8?B?eHR3YTZFU0ZyMU82cjN6T3hqR2FpMzgvNk5MeVMxZkZyKzFHVURRME9mM0xo?=
 =?utf-8?B?T1RTYTVMT3ZPK3kxZ1RRRnA1d2czNHVtd3IzNWFUaDNRY2Z2aTkrNTZlWXl1?=
 =?utf-8?B?SHBYb2xyRmVTQUtYV0M1WHVRWDd2eXFEMFVpZ3FkTVJ5UzRWd0IrUUJDbmhh?=
 =?utf-8?B?bTBDeU83Ri9MWVJsRm5DZGJuK1BxVHhYWjNZd0FRbDVHVC82aVhlcFQ4MXpS?=
 =?utf-8?B?ckQ4VHJZcVlXdmUyR0g1dVBJVkFZaVhkamQxU3hRdG45T3p0Z0tZU3lvcmVr?=
 =?utf-8?B?RDJIamxxbENnbzFxSWVuL3hpVUdQVkYySVpWa2s3ZnFGYzVydSt0Ni92Nm1n?=
 =?utf-8?B?cmVacDZ6Yklwd0g2WEhGa3hlejNCY2pEa01CL1hSeWh5WFlONDFtNGJBenAy?=
 =?utf-8?B?S00yVjZobUFpZStzWUpseTJjUFFPeGdsSnI3N0VJSTZPTzk4b21GSFArTWhG?=
 =?utf-8?B?VzZNTlV0TjRIT2hwTEVmZDFtMzFvelF6bEZoUDRNWmxWcUtDaTRxMTdZYnM1?=
 =?utf-8?B?bUtPUnRPVnZEc2xSVUh0alZvR3pwRFExSU5kMk01VitmcHFWSThKc29KZlNz?=
 =?utf-8?B?SWxUSXA3L0N0VFBsMGwwZ0w1WkcxQ3JKcE5zZWRDUVphV2RDUU81UTEvNFRQ?=
 =?utf-8?B?RXk0QjFJSG5WZUhhQ3Y1OHR2eEdTOGlnY2owN1ZsdU1DRWVDanFadm03UFpL?=
 =?utf-8?B?eFRZQlJiMmhJRDFteXA5K0lqbHIwcXVQbENwcTdWcHVrUitTcVVQUVJKcGFN?=
 =?utf-8?B?cVlvWWhkdlVkcW9PRFIwY1FLd0g3ZE1wNFRRVGkwTzQwbWJxYXJuWWV5TzhB?=
 =?utf-8?B?T2trSGo4YVA4V09PdDFXY1ZaRlBGcXlKWnhLOUxUOFdTYmZxb2pSSDRjdlFO?=
 =?utf-8?B?eFBKRTlMVHdVNnhqTy9ZbW9ES0pYc1dDYUxqd3JGa09RUEhFSXg5cGFjWTZB?=
 =?utf-8?B?S1RZT3V4OGpqWDhyUGpMNmZjakc0YVo5d1d2VWU2bjg0ZkdBNWMvTzEwOW01?=
 =?utf-8?B?bzNMZ25jUlpwbEFYM2pyaWtHLzgxUjhtMnZnL3JHa3ZHeStqcnNLYkNuSXhC?=
 =?utf-8?Q?l3m7JFgCjQIZ3FnWNJkqoykTk?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:13:57.9274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b54e85-72a6-4c3d-acba-08de234d6100
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10108

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

No functional changes.

Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v6:
- Update comments.
---
 include/linux/skbuff.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index ff90281ddf90..e09455cee8e3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -671,7 +671,13 @@ enum {
 	/* This indicates the skb is from an untrusted source. */
 	SKB_GSO_DODGY = 1 << 1,
 
-	/* This indicates the tcp segment has CWR set. */
+	/* For Tx, this indicates the first TCP segment has CWR set, and any
+	 * subsequent segment in the same skb has CWR cleared. This is not
+	 * used on Rx except for virtio_net. However, because the connection
+	 * to which the segment belongs is not tracked to use RFC3168 or
+	 * Accurate ECN, and using RFC3168 ECN offload may corrupt AccECN
+	 * signal of AccECN segments. Therefore, this cannot be used on Rx.
+	 */
 	SKB_GSO_TCP_ECN = 1 << 2,
 
 	__SKB_GSO_TCP_FIXEDID = 1 << 3,
@@ -706,6 +712,12 @@ enum {
 
 	SKB_GSO_FRAGLIST = 1 << 18,
 
+	/* For TX, this indicates the TCP segment uses the CWR flag as part of
+	 * AccECN signal, and the CWR flag is not modified in the skb. This is
+	 * not used on Rx except for virtio_net. For RX, any CWR flagged segment
+	 * must use SKB_GSO_TCP_ACCECN to ensure CWR flag is not cleared by any
+	 * RFC3168 ECN offload, and thus keeping AccECN signal of TCP segments.
+	 */
 	SKB_GSO_TCP_ACCECN = 1 << 19,
 
 	/* These indirectly map onto the same netdev feature.
-- 
2.34.1


