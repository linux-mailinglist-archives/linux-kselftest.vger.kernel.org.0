Return-Path: <linux-kselftest+bounces-30820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D4FA89404
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 08:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3728F178E73
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 06:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB19243362;
	Tue, 15 Apr 2025 06:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ceO860qC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013021.outbound.protection.outlook.com [40.107.159.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838AC10F2;
	Tue, 15 Apr 2025 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744699086; cv=fail; b=tmc4BVlMSDLQIDZ/1b3kk4TFIl2ASp44dZhWdB9DbnFgEM1K4eE47tMscHHdRNj5K/f2oBKNO+b4UrFCxegc8T1zbRoAIuavX6F7ZbSAxn+B1g2vK63i6xHkEWYP1jPYEgdYcyQfn2JLK0dU5O1QuEX5buWsshmp6CfRgl+C3QQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744699086; c=relaxed/simple;
	bh=+ezEZy8hckPaea1lF4ilsBt0GsZjvoaMn1f9l0j0RCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFmBygJmJZ3OTpEdZY/Wq4LOefcYTugXnynv2vfnqEZIFldbGMx/Ac4Pf9pY44CcNt3M6wa5ygr1iAg+mlJr5KMVHA6sr8bE/3DbxRl5uOv9Ux0tXl+b+mf9Y+JF38+w0JXoMwbBxb3mNPzfR3ULizkPvJNJcXBZhxYfx7RSN1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ceO860qC; arc=fail smtp.client-ip=40.107.159.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yv4NdOvTQrqjxQd9LzpzQ2hl4rpXfz51q5FuHF4v1ckBngRshOKS9FPLQomb2CFLUBfXTbem5VeildvX+wy3QE171hlMB2JqWztSKj/BLZOlWJ4smJRnw98zfde9sXRo/ZgMDndijTdhEYYNEe6HxHM6/p2XVbklmeyPo8zrCRtRvEKxrRM+FVBO4mzKj/eT33kYAs2MstfEvYoWBjMOGXq1WyOCB0QnzuseGbitoPfUu07ZRwiKV38sTVV93txAbJgrCTLFNsT0MFvuLvZxnW5kY661bcM8G6OzSBIRLTxiZEOLt4VCLKWsBlLIjcEtn+dSWbNKMndNJ81M6mWIXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ix+QtM7JJKtuEJJnzOOAErViBOEsmOlScq7uOdppACk=;
 b=k7OMwKABCa5EgzJI2Z/QWiR+VBFW+sDyCanpUFQjE9pr21eHScUKyQVfayI7IiFdn/mOeozzXpl6wL7sRQ/ikOWtcmw+oeBctUSh6T4PwoWaNIEGMrpieWOmT5vWqDBn4FqRutinZJTVp9iYrL5hcdhlbMJNksUJk2jA5NssyPIMbJL5UMuBUq6v6Vcc9gtgT0cNSUO3RCMa3VQZ687ftJY5ZS4KVFFcbtvp+pMdOZJd4hLtyINHJjyKq6WWfrBs3mZhnFiAF5wMyZFrSqf7w5786b+9QqM9aAIPsStbY9i6grAKjglTGfr4UDUQvewOuOemC9Aqm4XRfRi5lfb5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix+QtM7JJKtuEJJnzOOAErViBOEsmOlScq7uOdppACk=;
 b=ceO860qCRW11XLxzio1udaWgiWGgr74D3jL8LxjoRrQ9dTBKXq15OdxS1ndkRcdmhNWANmr3RKbaOJTdelQX8mIhXvTTUYGuYpQ+FI6Lz2cNoTg7y52pmZP3HCb3jUEkHiTjXjVJNk3oaGJ6RP8e1gGeUPUH4LhmilWHXutYdStpI6zYTN9DTclH4yn4xY/ZMAEJ4EbaJSkm0/m3w0lFljkr8mFyeWaMmfo2OKATL6asXAb1mHS8h9FopFB8DpcKzvYg9VG7y/oV9SbEHS8LEtnG5Ms8jrYMr6W+Uba5LH8f2fEFx82jivAm/uiTPQGhc0XwynCgezHVcdXcRD38SA==
Received: from AM8P251CA0028.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::33)
 by DB9PR07MB8636.eurprd07.prod.outlook.com (2603:10a6:10:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 06:38:00 +0000
Received: from AM3PEPF0000A78E.eurprd04.prod.outlook.com
 (2603:10a6:20b:21b:cafe::49) by AM8P251CA0028.outlook.office365.com
 (2603:10a6:20b:21b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Tue,
 15 Apr 2025 06:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AM3PEPF0000A78E.mail.protection.outlook.com (10.167.16.117) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 15 Apr 2025 06:37:59 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 99D914EED9;
	Mon, 14 Apr 2025 16:00:13 +0300 (EEST)
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
Subject: [PATCH v3 net-next 08/15] tcp: sack option handling improvements
Date: Mon, 14 Apr 2025 14:59:37 +0200
Message-Id: <20250414125944.97350-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414125944.97350-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414125944.97350-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78E:EE_|DB9PR07MB8636:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a5e83c-5d7b-4e18-d94e-08dd7be810a6
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WDhRdzZ3MEs2M1pzVjltdktSTlQ5WU5RUGRYY2J5a3FsY3J0bG9IQWxaUHJ2?=
 =?utf-8?B?d0tleDVoTWNOeHNtY0Mxc083N2haVkx5OW1rcW8rSk1zaXg4a2NOZTZBUWZr?=
 =?utf-8?B?U2U1anIyRXlNMFRyT0tqbjlPWU10aXBDeS9SZzhXYnZmMVYrOFN4cjl1UkY1?=
 =?utf-8?B?SnlZMlZyc3EwdEZBUEFzTjRlVmxJeWE4cXNNR3RyblMzWkNMWmRWNGlSVW1i?=
 =?utf-8?B?T1VwREFQN3lIQ2FRcG80VHJIZHRhdHRodWs3ZTNVYmRHWXJFU3kvckVpczNx?=
 =?utf-8?B?WmtQcE9DZ3hBeW1JL1c1UHJwZ3hTY0twdG04MERHU3RDby82VUZaYUJySEc4?=
 =?utf-8?B?QVJlbzdNeVJkbzFGZ256b0ExQUZEQVIvQXhvc0RleElJVWhKekJsTURLMHFr?=
 =?utf-8?B?aDNZNWZzOWMzbnhuQkxqUmM5aWRkQjRwM3pJNGp1WlQyR3hud1RaNmJKWk05?=
 =?utf-8?B?MmdlNkpERGFOVWtnL3dKb1dad1hudnoxU05KeWxHaytWQjdaMm1OaTgrTmJ5?=
 =?utf-8?B?bnYxelh4Smo2bHB1TE5SeTUzMWs4ZUxqMlVuUS9IVFdlak1HeVM0RWdUQ01k?=
 =?utf-8?B?R2EwQmkzWVVpWEdTdGJRRTUydk9lWER6MUtjQnVXY0pmTlBYWGtObzMxMXMy?=
 =?utf-8?B?Wmd5a0FwRHlGbytBZDRvaWtrWnYwMWpIUjJIeXFKa2JWeW9tT3ljMkFOWjFO?=
 =?utf-8?B?K1U2aGVwS0QzYVVMalJqVUlFTFM0YjREWVQ1dklVTnNQNTBaTExXYzN6dEZi?=
 =?utf-8?B?eDVKanZ5VThSaHJqVnh1N29iQk9VMS9JTXdNb0FIbnAxT3BvL1lxQTNxREVq?=
 =?utf-8?B?L1c4cm90UERsY1MxMzRCQ0NJSUZ6cDMzb2lZVjkzQWVBTlh1TTdlRDJMY24y?=
 =?utf-8?B?MjNtK2U2NE1EUXBiOG1OK2JlQTAwd3pocktsWFNNeXdtdFJ6aitXWTBLa21u?=
 =?utf-8?B?SGRBQnY5OEdZdmFDR3BDT3BVVkhZWmQ0NmllRzVMRnE0V0VYcFUzZUR0V1gr?=
 =?utf-8?B?dHN1V1AwYm92MmIzc2k2M2lxcDc2S0dFc1NaTktvWlBHL2RzQ1dvUXdlWmRY?=
 =?utf-8?B?WHAxdysvVGJqbXE2TUJQODlMbHh5L29LaUZ1aWJzWHcrYXhmVkg0OFFVTnht?=
 =?utf-8?B?d3hwNWhnbmtwTGlUcHZGMzhCUWJBc0IyeHcrM0lCeisxVWFPczI3blV6cWI1?=
 =?utf-8?B?VnRIQzY1M2x1cnFNR0JrOFdOT3NGeFFtQmk5a2l0YVVMMjFqU3M4TGw3dDkw?=
 =?utf-8?B?aWlod0ZwSno1cWhqb3ZDY3lxanREbEVLa1U0RHpZMjl0dnVGQTkwdUVMbmJX?=
 =?utf-8?B?RnNxU3dvMG93dEtoK09CSWNXeXVGRUJjQUZkKzdJZkozc3Nhb2cvTDIvTndy?=
 =?utf-8?B?NnZDWk9FcVoxRm9JQUk2b3VvQ0xiRm5BRVFLNnBJaG1QaGI5bzE2UXV5RUVT?=
 =?utf-8?B?ZUZGbVdUOWpQdjU0UVV5TnJzNUJ1dGNITlE4VlJCTjRUSEdDc0o0R2J4MUZz?=
 =?utf-8?B?YnBNcWl3ZXd5SUdDUHRNY0loOTViSVc5RmhIQmFMWWxzU0tKY2xVVUt6N0ZP?=
 =?utf-8?B?K2wyUmMvT1E1MWV1NlhXZ1hNaTUvTzRjSTB3Z1gwNytqbVM3a3hDYmxBZUR1?=
 =?utf-8?B?TFdqUlkvNjZDMCtheVBMbGVHdllXdnJkejhoTVN1akN5NTNFRi8xVk5XNGNm?=
 =?utf-8?B?YUhaSWl0bDdUOVYvNi96VnRiYWRNMTkzRjZYMGlyU1RlVktaU1lCdkV6ejNw?=
 =?utf-8?B?Mmx0SXRwSHNIdks5dS8zUXlLL29ENWhSY1l0cC9PcU9vMWJxUUYvQXRpcC9P?=
 =?utf-8?B?dUhDVmYrdGhUb09hRmNjU3AvOXE5c2ZmTmlmdlJQWko4S3RyWlZkdXJxeUdj?=
 =?utf-8?B?VGkvVkxJRGVWclcrTSt2WXZ6OEtBZEtRZXU4VW1pZmRiYjNxSHV6MEt6V2kv?=
 =?utf-8?B?N3dGb1d1ZWd0ZElJWElVUG15NU84SmdxWXZDVGJpS1RvNGxOL29wYUI5L3JJ?=
 =?utf-8?B?SkxTV2F4eTdxOGt2VXFCUG9vdHBQTjRrb1dzODFBQmZIUnNVMmtXeC9wOW1S?=
 =?utf-8?B?dlRlRjRxWXBGZEwrQ3BQejc5MERXaEVBMTBqQT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 06:37:59.7540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a5e83c-5d7b-4e18-d94e-08dd7be810a6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8636

From: Ilpo Järvinen <ij@kernel.org>

1) Don't early return when sack doesn't fit. AccECN code will be
   placed after this fragment so no early returns please.

2) Make sure opts->num_sack_blocks is not left undefined. E.g.,
   tcp_current_mss() does not memset its opts struct to zero.
   AccECN code checks if SACK option is present and may even
   alter it to make room for AccECN option when many SACK blocks
   are present. Thus, num_sack_blocks needs to be always valid.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d63f505a30e2..ad97bb9951fd 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1103,17 +1103,18 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	eff_sacks = tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
 		const unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
-		if (unlikely(remaining < TCPOLEN_SACK_BASE_ALIGNED +
-					 TCPOLEN_SACK_PERBLOCK))
-			return size;
-
-		opts->num_sack_blocks =
-			min_t(unsigned int, eff_sacks,
-			      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
-			      TCPOLEN_SACK_PERBLOCK);
-
-		size += TCPOLEN_SACK_BASE_ALIGNED +
-			opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+		if (likely(remaining >= TCPOLEN_SACK_BASE_ALIGNED +
+					TCPOLEN_SACK_PERBLOCK)) {
+			opts->num_sack_blocks =
+				min_t(unsigned int, eff_sacks,
+				      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
+				      TCPOLEN_SACK_PERBLOCK);
+
+			size += TCPOLEN_SACK_BASE_ALIGNED +
+				opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+		}
+	} else {
+		opts->num_sack_blocks = 0;
 	}
 
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
-- 
2.34.1


