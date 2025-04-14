Return-Path: <linux-kselftest+bounces-30700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 788CCA88175
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CAE7178C28
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEA12E62A9;
	Mon, 14 Apr 2025 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="GOG0XxXL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C6C2E339E;
	Mon, 14 Apr 2025 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636466; cv=fail; b=iZ4UddyxRrAexhWsksx2dsAXhgXm2c3IiDZTzVeUTDl8d1WplfA6/xKhj/wbKB5U5AMtzK5rYplefzKoa7j8a3zUzH+17LAg0YovnoQv5eiFSi+9JyLBxot+ZK2wTbxCFwXY3RO0umpa0PwFpvMBmxSbCSASQDO7+Du6sdfEayc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636466; c=relaxed/simple;
	bh=I4ubTWT3RFl5BeQzn9ugdonkuIPtlIVxMelUvF756Yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqDLpBM53mAVyP+iDtMIWqr/Rr8dFgeOK5aW8r74GsVPkP2WBAnXiyrPdMEWW5DGUSOXMfFs+TU2bmrMNsjvEy11TtJ1fhitq1D4fk1G+wJQHY9IJ+MB1AINTd/0lqUuXJkfv/9hrG3lZe+/HM2gsPO7MPSSdZL0fi6AbkaDrSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=GOG0XxXL; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtkaYknftc5WIn8xbX4tvCiYw7YXn2wZUafF+UlXAMqNDwpsTXgqR/E/5PN0KF6tfEYKoGn5KFfPlTmtwDqbvzmzcJdiAmSbW05Uj6BLbotWGMPiwxNroEJhprNkIdQl/Tx4mezMmbLUlvMkBH1OO11/ZGlaNt9ULENzTt1Rql/PqfqPOXXPdoFjKWP16c+9aLmCOqJtfdCWNL1QRyOt3HrpuBeHHiRHeZlKH+kqvylD3DYUljKPp7czM16gGkLb8NfAg586evFYUUhazxp8qRx37V95He7Edn52aV4glEnyocosE491htMhp3bZWeC0cbmUrP+k3aT0cztOY/bv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjzGCXWtVKbrVv/LQ94yH6VK8X9J1eeWY+M2JK853FY=;
 b=WbbJ0WGQrbEE7GvzyKbFQ9JqTCLuL+hsSZXVv7dmaG1KQ8ara3egX2seegXyfdapQIXDPum1UpkyIYhTDPX1IrtJwEZfGOSWAIYIgU0dQlsCuqnUe66pJhBHoOhQEgTZDsPEAqaKtotXweqj81OQkqlsdiPLgu9uVpZPKTLdbS/ZVBaRTwBLo1RwzhrZJQ5ewlFu4BQlFhFYevPHtwAqKBEVDOWH5yEWp+lElDoTmResynKhCBFC+ecsVgJxd0Zkm6b5UVfSJwwhpEHxm25qDdU8Jjf5BMDV8rcVdQ33i60BfbV6nsbUWgpZn5puT+3YbCZkcHmVwlCdp3FXX5b2Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjzGCXWtVKbrVv/LQ94yH6VK8X9J1eeWY+M2JK853FY=;
 b=GOG0XxXLwNtm/ScwK2f2N5Mpq347TX8+MlJgeo+ApX7p9INyPGfgcIVN0L7cxx5FOg5tDsBghMmzPG/Zm32idYMXEnDZk5Dwj+obq7yiwKfjU05gZM3kSiI3jNN/TsXIEDIzxKqY8Qlo75doeh0MDQe8QBtp9Wkp9fIwA5LTscbyT5Wjn6K6Akno1WOTHYGqqf+PLg1JUAs3oEaWsq8/meKtljQjaX3z8kxjfRHzfUOHkJ0sxMjOgV/l3KvZyVZ5IGPCzWFZB9NZ3O3uisosWGWj4DHY9sc7ly0EcyHPz6gWxOLUohxYIWBm8ge74jjuXxX/WlvARqHwH5KWa69czA==
Received: from BE1P281CA0483.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:7e::25)
 by AM0PR07MB6244.eurprd07.prod.outlook.com (2603:10a6:20b:15d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 13:14:19 +0000
Received: from AM4PEPF00025F97.EURPRD83.prod.outlook.com
 (2603:10a6:b10:7e:cafe::3) by BE1P281CA0483.outlook.office365.com
 (2603:10a6:b10:7e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Mon,
 14 Apr 2025 13:14:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00025F97.mail.protection.outlook.com (10.167.16.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.4 via Frontend Transport; Mon, 14 Apr 2025 13:14:18 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 53EDDQBO009623;
	Mon, 14 Apr 2025 13:14:17 GMT
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
Subject: [PATCH v3 net-next 13/15] tcp: accecn: AccECN ACE field multi-wrap heuristic
Date: Mon, 14 Apr 2025 15:13:13 +0200
Message-Id: <20250414131315.97456-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414131315.97456-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414131315.97456-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F97:EE_|AM0PR07MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d378463-792b-487b-ec47-08dd7b5643a0
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bVJVd1lmN0YzOTI2d1FBMk9oUUNXZWxpUm5KempUb0E1SDZvems0amMya2FS?=
 =?utf-8?B?M0xRQWpscGRJWG5POEdmaU9LZVdPSWpyblNDdjJwV0JUMlgwekhOUmlVOGhi?=
 =?utf-8?B?STNEdlcvaUxTS3BWQzJ5OUZKSS9tRjVNRk1xbFNRQXAzVGhYOW81MXAweHJ1?=
 =?utf-8?B?T0Q4OUpqd0xFNGZUZFFxbkg2VTdNSEVCL1IzUXVhc0RiNEtqN0xFcmIvMXZI?=
 =?utf-8?B?dVliUHVmQkZHZmJMYzJhbzBab056dDUrQm4vNEppWStnNlFqSHFGNW54NlJz?=
 =?utf-8?B?bHRTNWcyb0lNZUZvclAvek1mMnpTcVMwMU1YQkhmUmUzSitGUTB0Ry9SRXZB?=
 =?utf-8?B?Z0x5dmNFMjN2NlFUd1RNTDJUYVhKUWxlOGNQb2I0OVB6N3pJWUkxYllSUlk2?=
 =?utf-8?B?dU14aWdzTW1XYWFPUUcyS1RYUkFCS29IdGhhS2t4TjlQTEJVMmJWVFhTdUhv?=
 =?utf-8?B?YmI0L0R4eVZuR2tUdkxVUVFvVmwxWWxORDBnMm5qblRuRUdnbnNlSVhmdUY0?=
 =?utf-8?B?S090T0grRk1zc0U0emlvQlRMaXpSR1lWRWxwV0phNllIN1BReGpJUHhxSDBL?=
 =?utf-8?B?cTJDeExzRTFLS3BlVy8vMjNHTTNnZmV3akppWlA4MHByaGhpWmdDbGtNckln?=
 =?utf-8?B?K2UzZDZoT3pLVGNsN3R3NTJoNmJ1SzZ5MStwMlVhQVh4dnlrQ2tQNlQzd1ll?=
 =?utf-8?B?YlJmM3hHcW9ZTTJMY3NqemkxZStocEdiaVN6UzZtNnFjbUZ6NFk1RHNRRUFm?=
 =?utf-8?B?S1FmYUZMMEZuY202RENwTWFOVXowS25aRElZK0NMRDVsRjR0UEtZTElJL3By?=
 =?utf-8?B?QVg0WS9BeXhGUGIxbmQ1ZzVCMitvZ2RSTGJKR2dldUhIYWFEcEh3Z3dQUE5Z?=
 =?utf-8?B?aHhBQ0RPOWVkeFlrTU9pc1RWc2NnVTY2UzI0RGd3VXBtN3M2U096VkJ3R3dL?=
 =?utf-8?B?eTVkTjBqWnZVSmxpdDkrd2x0VjMvV2RHQm9BekxYb2h5ZVd3eVcwZDJrdzZp?=
 =?utf-8?B?dk81aXEvU1ZPdjZ1bEZKSWQ4WTljMTl0NVNDR1hHUmcwUCtkS2VqL3R2OGQz?=
 =?utf-8?B?ZjlzV3F6QUFKNDdLQlFVTGpVc3VzUUJGVWQ1TWJVMTRMTnc5ajROdmxQc0M2?=
 =?utf-8?B?ZTFSYU1jbzM2clM3MmFwK2c4T2FtQkJYYjRjMDN0Tkt0anJZbEhYdEx6RnpT?=
 =?utf-8?B?cGtDTXRUeVRpVzlvTGJnY05QMUNablFUVlJpQ21xNXJmSGx3MzlXR2F1UFY5?=
 =?utf-8?B?WjA1enl1L3ZXSG14aE1iVnhPbUZaSFBHZkU3MS9EU2VnQ2NFWGhGVnVyRGR6?=
 =?utf-8?B?RnFKWmtHOHBJa1V2TzI0aUhjKzB2SVh5RzBrNFRWOHI4SHNSTzhOQWVYK3Nv?=
 =?utf-8?B?M2pKVnBZSVdWKzVPUUhMSkVQa1NwQTh2ZU0zT2dkbWQ5blBBbUpMVDF5RlRx?=
 =?utf-8?B?VWpqSks1WjZQcEV1SHBzZkVhcWNIbjFLbmtvQUIrbldUKzlFZ05qZnhXVkFk?=
 =?utf-8?B?cGhMMTF0RXUvWWkyeU5ZVmxlZVZRckVObkY1ZzUydlRLTXdGZVhqNVNQYkhL?=
 =?utf-8?B?Ky9qaytHakJhQjVpWWtQVTRZMHNCRk5aWmltL3ZmV0hWbThqYmJLbmZGV3M4?=
 =?utf-8?B?Z3pSQlFSZm9zdXM2TzJCdURGLzhCNlRVdFQ1cHVhazM0RDlHaW92NitiRHNi?=
 =?utf-8?B?SktpY05sR04wUVQ2ZEY5WUNxMEk0UjJkS2Q2aW05MFA2WjNOSkppcUd0ZFEv?=
 =?utf-8?B?Z1FTMzVpMUhYd2FPNWhIVHh2TExucElpcEVCWHJITzlOeHJiYzVXdy95RWF0?=
 =?utf-8?B?WndxZkJnZis3bXhhNXpDT1cyUDJHcGNaUDI1TE1saHhzUDZKVXpIcFgrWTB3?=
 =?utf-8?B?S0lLOXdTUHRQMm5STXpIVC9KcllTYXp0cUlpc01JNkdNQWNpRXVtSWlNSWw0?=
 =?utf-8?B?S0g1ejFoVnpGVXBQSGdmT2N1ajNiWUNRN0c5aU0waEFkdW5ndkpmTDVhN1p5?=
 =?utf-8?B?a2J6TTlpZmpSbHZSY05xSmRIUERHakNVeWpOeklwVHhWSldoczNVVlFFS1hO?=
 =?utf-8?B?aDg4cG5vRnB6TVZFUkxyK2o0eUx6NnBTQ2RIUT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:14:18.7736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d378463-792b-487b-ec47-08dd7b5643a0
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F97.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6244

From: Ilpo Järvinen <ij@kernel.org>

Armed with ceb delta from option, delivered bytes, and
delivered packets it is possible to estimate how many times
ACE field wrapped.

This calculation is necessary only if more than one wrap
is possible. Without SACK, delivered bytes and packets are
not always trustworthy in which case TCP falls back to the
simpler no-or-all wraps ceb algorithm.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 54f798161d14..c6dac3c2d47a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -733,6 +733,24 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 		d_ceb = tp->delivered_ecn_bytes[INET_ECN_CE - 1] - old_ceb;
 		if (!d_ceb)
 			return delta;
+
+		if ((delivered_pkts >= (TCP_ACCECN_CEP_ACE_MASK + 1) * 2) &&
+		    (tcp_is_sack(tp) ||
+		     ((1 << inet_csk(sk)->icsk_ca_state) &
+		      (TCPF_CA_Open | TCPF_CA_CWR)))) {
+			u32 est_d_cep;
+
+			if (delivered_bytes <= d_ceb)
+				return safe_delta;
+
+			est_d_cep = DIV_ROUND_UP_ULL((u64)d_ceb *
+						     delivered_pkts,
+						     delivered_bytes);
+			return min(safe_delta,
+				   delta +
+				   (est_d_cep & ~TCP_ACCECN_CEP_ACE_MASK));
+		}
+
 		if (d_ceb > delta * tp->mss_cache)
 			return safe_delta;
 		if (d_ceb <
-- 
2.34.1


