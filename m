Return-Path: <linux-kselftest+bounces-42526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2FCBA5B2B
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 10:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7A04A787A
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 08:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9832D7DD7;
	Sat, 27 Sep 2025 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Lj6KF/c4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACFA2D781E;
	Sat, 27 Sep 2025 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758962906; cv=fail; b=ZqGqqTS5lkQ2AVXQnhLOv47BLDjkMJYa/15xc32mz44pb+Ay6DxgrcFAu0SqB/XZ27ZFF5Rw/+pmJJDnmAYIWT16/53MepBptHabW+mmBTV8hxOE4cNHxsP+uFfjXx021CrAz0SMxj+fxgQsWn9udT5US/NRJbKVo+S1LPYDusU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758962906; c=relaxed/simple;
	bh=HyPSTrjLdRUESe2ZKeALswOpbKpbD3icf2L5lfxfaRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGtkcOOyWBwDr7AIHDbOuip2zKg1vib3YdawEZ+XjN3AXEDrme2wJdY9VEkbzLj+37peXSTojSQAkfcCv3Y7sZ5Fmcm+B/GEhkvfi+84KEVOgj2NV/Lg3OPKUuuSPJRe9/ZgGUYmwlvff9r09j6hNKD5Mh4xqY5phLYOHV9KQbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Lj6KF/c4; arc=fail smtp.client-ip=40.107.159.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNg1gXfqsnoUN5ONwzRjv6ksBQFoN04Ly3zc64sYVsG1b0t0jPNX32jHmvtwv07IqWhuFT16lq5b/mW532lALjhbaTiL0Xxen7NqkxO8iAx2pn29nsl836Gdn+s70BMCjERq1U8mouREYTZyQwgx6rEmsFYAdEyEAeR9L8/atCmiedN/ZAOWTVz9dCy3/7d+/Gc3VQZnAdP0ExW3zHTZps4OoZLWnzqoYzzBSbHq2dyi9yT6UolNngAXZkUhJvZwY10RAj5dRV/BdR0zypwJqBMVWdGkVSXB6KjjcidegMNVYmeSJL/4chNZQSxihnZUVlhsoWZ0srDggkcB37X7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzmrsYedXbtlFC14lNlddkSScaUDfuYExLFlMph8ZZ0=;
 b=QUMIIR955zptIZKyaAuj9iEB1XqRjR4LjN3cVl6HC4PCp2pYJAjSeUDrKwCCjNOIk/e2y6iPTeY6zwX/F/JRwIM/DejdupxNfGn4TqIL4VNz58/Iiay0Cl/SBd7c8Spz7+b1u7WmVMZ6p/KBhoro56HTjbJinloNuKCFKre+9gBakcZepJsW7+MQDWJHRh6GXB+YbcwD8R9qT58GMgvCkbiJFEDU1WlfgA22Bbk9p4pMRboIyiUzxZwe/R+AeJ8/UiZpCt6/MRsgYSv7dqRwopC8yEQ0fZeY7Vp4SuIbwjwPoomInN2xWo8xjiTLi2nvR506CFzigbMqX2YtH4gecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzmrsYedXbtlFC14lNlddkSScaUDfuYExLFlMph8ZZ0=;
 b=Lj6KF/c4iFnF7LcJc4PIzbUb76s2AkipB7Rgv2W/CYJtM55d/Ge5cQ9kvTB7VZja5HhYZsoYwCiX/Iu5TEuYVjr/k6or99e0dvi4botWhYMiXIwxrX2hr5NGT11DBdzGa9Uj9rIobEbNfY0GKY/OhrPwODnlnse0vWzNuYz1+9jgObphBBpo2jkW5eI+qK6agH95I7q5tSuNMDa8XfPxuCuBiN+0Hz16vK4z5jXtcb1CDNebJ/qAxS6k2vsOc66UqVGkPwn+K4c6mSYWmF72/RCEpcA7+mWnJxUwI4LtZQi5NbIArnWKJ/Hju6Z1onmL+h5iTm5VWAH+hSJj6SVNtw==
Received: from DUZPR01CA0196.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::23) by AM0PR07MB6450.eurprd07.prod.outlook.com
 (2603:10a6:20b:15e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sat, 27 Sep
 2025 08:48:20 +0000
Received: from DU6PEPF0000B61C.eurprd02.prod.outlook.com
 (2603:10a6:10:4b6:cafe::dc) by DUZPR01CA0196.outlook.office365.com
 (2603:10a6:10:4b6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.14 via Frontend Transport; Sat,
 27 Sep 2025 08:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU6PEPF0000B61C.mail.protection.outlook.com (10.167.8.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Sat, 27 Sep 2025 08:48:19 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 85033200B2;
	Sat, 27 Sep 2025 11:48:18 +0300 (EEST)
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
Subject: [PATCH v3 net-next 07/12] tcp: move increment of num_retrans
Date: Sat, 27 Sep 2025 10:47:58 +0200
Message-Id: <20250927084803.17784-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61C:EE_|AM0PR07MB6450:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9dbe5145-cd06-4f25-04fb-08ddfda29c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5pN5S4elNAI+DG2pkPiFH0zrY/vLng7bGEwMHt9vBgjTWUxvX2xGNADG3YpY?=
 =?us-ascii?Q?R36vGuT0cYg6mpM4GYN1R0EVeGxRoiXii45HM1mBoXgSvmOrCtsGasANGSux?=
 =?us-ascii?Q?h+u8B2HzU6NKP2cG0hysqnKUGCX0//7i47U6byGaiUp2OLw4AEbXsbXAEqEs?=
 =?us-ascii?Q?vxAQ06a6ZV6IrGfXVwMPHVO1Bto3z1BVEQxQE/Ne5CsBgTfVOmI4VHw/+UNS?=
 =?us-ascii?Q?mf1tvvd/mXbD+KK3mjdm9CfveQZ2NuJLEFuSalCDiqEYGflFPVlOfpfYw6Ub?=
 =?us-ascii?Q?4ljfjwOCriahhZ+GUGzxgSztpU4/o16UrnDzCq0qAOGXosM9OfJGIH+5Azaj?=
 =?us-ascii?Q?YAMKGTHTxuKgj4bbmfQA/zHW0TTKX7kuDmRguerN/AM9eMYxOzxWyeatJr20?=
 =?us-ascii?Q?cz760un0rZrrh1agioFf0ZiDSDuO7U56/YfPB5uJio+yDWF5SYbVHb8Xox4W?=
 =?us-ascii?Q?1UDT8ODg2Jho7j3cT0VJPgxZnNuLfhbQzhJwzD/xz8kG9ldtdyFuzeJ5Y/sa?=
 =?us-ascii?Q?8OCLXsfog+yjniT/wKVnqm8CECgqtUInE67GTz/GP/4lv2VyE80oOV6vsKou?=
 =?us-ascii?Q?zYimbkC5k+1WAwRFrVniQR4vDF1nU3Vw7p5nZ+Z6cTt0o/hqo9Tt1fQv8iak?=
 =?us-ascii?Q?zS5k9PleEHW862Y7KdQ3UUjN+jhnJKw0LYKae4N6IB2uQZOPA68kJmxH9npz?=
 =?us-ascii?Q?Z9c7Vw+Z0YmDCGFusjcbcMqyHVCymLFVkhTE2BoZ0z3UCB/QU2j9cPIVer0+?=
 =?us-ascii?Q?zXt55uuVVm+h1XwSAvfegQ/wtZ7KmbPs7bGy/d7ytH1dM9EsrQczbX0qTJ3s?=
 =?us-ascii?Q?mqHLipRZJmXJsTMlBcq0oZtauwCsw2oFF7M4iDPIjwCzuxdw9xhv2Lwq7ypb?=
 =?us-ascii?Q?iLiBfdxxRf3CWMWis5GO8kbTyjv7I1Qypb+UrbPXo+qnzoxV0JzT5B9JBQZb?=
 =?us-ascii?Q?TsNzfzX4HPL4g8Jvw1mh8/+fl105YhnyRNW8eV5sF4TfoD/o5Qxa6g06fN2y?=
 =?us-ascii?Q?qDH51xXZZwunYVeyXRebaOsLyn7lr07f27TU6LOBski+TdlQxrjdn/fZzy0M?=
 =?us-ascii?Q?KKRkaK7KINiiIR61S2fsiq9dFxAKAxYHeoh/gzytDTniCZzdrLutExDJMqT3?=
 =?us-ascii?Q?Iqtn++ZYKZl4CqN5jYGbZ5Q5PyotHZbNJax00MyRj+CxuoHCdtuF5hgHpvoA?=
 =?us-ascii?Q?OwEkRvy2m7bjfaUvunX6B8XCGQQzHAuR0h6ing5KirO61j/+lOm0/0bqJrac?=
 =?us-ascii?Q?ubrLiGJG+CmokSNWVeAWvH4xEIUFNzM1Z9qYJ9I5VtDx1m9St5pyCwvoHsvY?=
 =?us-ascii?Q?w/4ACPS8zHL0IZfaDJaO/KHSMRAxoEbqwRJFlHOwjYqzIbWpCVSD0eGNqki2?=
 =?us-ascii?Q?e3NeB7VSfTBBDbNfvzKxBVdomQsE37afhE/a9/Ea3fYeosnvRhGhwe9YiU0r?=
 =?us-ascii?Q?jS9h7HdUe7vHZkVEGqbSOfoKkkE6juj5EpqPvduTup09caZ3DwLJ8SYuzRZT?=
 =?us-ascii?Q?1pYMX5ZGQVI82H5a5OwrUYOeNdoX7BT2swRMBnnqW47GCqnN6w1OzVN2lKLh?=
 =?us-ascii?Q?5jwlwEy1h2KA57eki0caBjoRwf6jTMGED6745EKH?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2025 08:48:19.9849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbe5145-cd06-4f25-04fb-08ddfda29c06
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6450

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Before this patch, num_retrans = 0 for the first SYN/ACK and the first
retransmitted SYN/ACK; however, an upcoming change will need to
differentiate between those two conditions. This patch moves the
increment of num_tranns before rtx_syn_ack() so we can distinguish
between these two cases when making SYN/ACK.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 6e6fea8f295b..ef008736e3a9 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4593,6 +4593,7 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 	/* Paired with WRITE_ONCE() in sock_setsockopt() */
 	if (READ_ONCE(sk->sk_txrehash) == SOCK_TXREHASH_ENABLED)
 		WRITE_ONCE(tcp_rsk(req)->txhash, net_tx_rndhash());
+	WRITE_ONCE(req->num_retrans, req->num_retrans + 1);
 	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_NORMAL,
 				  NULL);
 	if (!res) {
@@ -4606,7 +4607,8 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 			tcp_sk_rw(sk)->total_retrans++;
 		}
 		trace_tcp_retransmit_synack(sk, req);
-		WRITE_ONCE(req->num_retrans, req->num_retrans + 1);
+	} else {
+		WRITE_ONCE(req->num_retrans, req->num_retrans - 1);
 	}
 	return res;
 }
-- 
2.34.1


