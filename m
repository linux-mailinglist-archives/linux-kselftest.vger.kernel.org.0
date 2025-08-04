Return-Path: <linux-kselftest+bounces-38240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0089B1A144
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 14:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FB71676D2
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 12:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA550259CB6;
	Mon,  4 Aug 2025 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="nFGMVW3g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E4D2580F1;
	Mon,  4 Aug 2025 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310052; cv=fail; b=SwkSGnhzokNAANhhL55dDyUGiRjzNRVdXvK+v/562W5MOs8sF8Xb5JHxBYPQYig4W2lVRX6om4BLYyXL8PkzUhBNJ3+V0+kBycK2+sWzZQj4W3RWs6XMtN2UK9nw0cnKIJJxZ4lHaXT6AOOk2WO8SjMuFLAcvNL1PZrjO+PpHsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310052; c=relaxed/simple;
	bh=FNEM9384qLBq2Fj6UNCisueCgEelbADPK1x9ZdAWrdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHxpsLEopb3Bagwe+UBC6XvnurPx3RY+mo/P9QznL6TEOyVD3AQ7/NnZnFLVr36LON33r/LoM80Wss6aZ4Go0BoOBlQtj3ZlX6RIKiLRUwBoNq9yvAL1lYgFjcURnkmMzHGkujLWa5FOp3gF+ui9/cAomlG75vIISiGORo24ePA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=nFGMVW3g; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ud3aeIjzA1BmX+ugioQI9pEtD4Ipvgou9E1qFWvMnjsdqCUSt8MRjwfEqMuAiTogET28wTh4VigHiD+T15ChIV0CK9BU8gBqGO0sNfO2PL5DOkg/L3sg1EiYIPGcVTM77lZnvcJNrFmA+d9WaiI/Rtn3MTmKvwn7/dWMoBZna8XnXC7r4gPHFOs6C6c6WVY+C5VYYK+r/HyxQMAqccMyQDAuVn/4F5TPd+W1q/aC6/VyNjrjVhGbtayV6kgbw3Zlb5AGQqRUR+iaCa9c4bWZAHDwZPwrL+aw7fwL3vVTlzdDBFLH3PzhZvVMe6FZqKOFF7oyrZuB3Il9lE9iUJiMmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9LeQAr7WwfQBtCX1XNvEcCld5g1h6O77WPcO4UV1lo=;
 b=CERVRmHRhPHRxPKY016kxxKCDOf6mpSlRzrp53k5mkLHbHtpOlS45Vxa7YI63mtp/Xj+XuKrxFaH4srT9Ql+2iDPcwNIyHkkNeoJwzXjqU8ND+5cwIwTrt2u5LAzd3z9vG3Y98SoD2xAi2pC6e7qfSoqnn0ORLwPQHktgd865AP4avbXtrpbrsbyJ1yzmJkjjDVedITwQofmEeKuWj/Bi0JXYMyzzI+aVZJCvIQCcy3b1bW6AhJ/sGfHD7OrYLmtHLjDpmNjC9vqcX3TnKVOWPdbEFqT/B1F52QfUnWtkpo5a3QgcvUZlL3CjQoUBtOVh0lhCJxd9VosU23wF9EnnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9LeQAr7WwfQBtCX1XNvEcCld5g1h6O77WPcO4UV1lo=;
 b=nFGMVW3gEmvEUivWK5L4AQMx8wNjMYkaluD/JtOrC0uFYk+AWHsubYO1YSWxbTeCYuQqbPj4e9EHWznEguHl4+31jOJyduEN20sLhmDHCY7kaSucb5DVawz18pvlYLZj5S+ZJHk4/Bckn5zbt5FhoXm9IY3SJwDQ3l4HGPRgbrH5oTDlqjar0u4udafrWAInx6ij3MGkxeoEQexBZhwNCzCT8KjLBfHgDTXz07U1xguACO+GH7Nf3vPQa2gRY42J3VwQOX24IE5Uhhp2h0l1Us4FspofafQWkHMy3itcdCi6jwU/Sx71ziHJaZYRVNEYLLtws72LIW0ACEGTe4TZEQ==
Received: from AM0PR02CA0116.eurprd02.prod.outlook.com (2603:10a6:20b:28c::13)
 by DU2PR07MB8256.eurprd07.prod.outlook.com (2603:10a6:10:279::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 12:20:46 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:20b:28c:cafe::c) by AM0PR02CA0116.outlook.office365.com
 (2603:10a6:20b:28c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 12:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Mon, 4 Aug 2025 12:20:46 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id B157A680041;
	Mon,  4 Aug 2025 15:20:44 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: dsahern@kernel.org,
	alok.a.tiwari@oracle.com,
	donald.hunter@gmail.com,
	xandfury@gmail.com,
	netdev@vger.kernel.org,
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
Subject: [PATCH v12 iproute2-next 1/3] Move get_float() from ip/iplink_can.c to lib/utils.c
Date: Mon,  4 Aug 2025 14:20:17 +0200
Message-Id: <20250804122019.57829-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804122019.57829-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250804122019.57829-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|DU2PR07MB8256:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c7185dc7-4e4d-49f4-8d01-08ddd3515707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eIx2OTemlmuqJuwWvhjAvNC2YGrKP4lhDTnxOnFlsYJ5p1cjk9iIsVo4bplX?=
 =?us-ascii?Q?rTlCgDN4f+ZOtOU6Ry31KYwFIkxZ9Uj7l8GcAM9IWPvfXTUwNYwPwPOkC907?=
 =?us-ascii?Q?35UYbcttqLWhv4sfXYa4dEB8AI073W19cxMzD2JJHknWR8ksqqy5GUM8w/P6?=
 =?us-ascii?Q?ll98hELFVwizGRRpfbqwse69kfJ7APdNBPGXGwcHrUGJ0oS4qJR2GgFmZdME?=
 =?us-ascii?Q?YNoCoubEtf+uEUNuBygpSIaZx6BaAL5Mx5tld0tz0FwmEZQwhQos6tYcUX7y?=
 =?us-ascii?Q?AndV/Qss4qbg9k4MUz2PZRaJTWr4MHd5l0dM4FNkaKd6CwrQD7orDYJAzBvf?=
 =?us-ascii?Q?P3qMK9excFqgfsxfENpcLZ7sdXcOrie8GyceuL3i/4n5UZmGCrH6M0RCW2L/?=
 =?us-ascii?Q?ZhLXtF3FSQk/1K0kyCxrv3yLsHMxV4zDLo3wCa5kG65nDzFZJD3fQSHENsfF?=
 =?us-ascii?Q?tv4u6iuLfePHKTA4GWTN8N5DETj9dNzdkErXK98dYhf6akgTYJ0g+1e4BUzy?=
 =?us-ascii?Q?VrzIbGJsUcYLHr6W37JBoxvOSGaUmIGD4fO3zYccOOZthypFO9hnQQ4tegIr?=
 =?us-ascii?Q?xsgMD3sLvhUED/XAiZKETTWOoG8T688izADHPzxHPN3gyexVDHdApufjbDYO?=
 =?us-ascii?Q?gi23EAz6NKW/ghNS/QI3/fc4yXuHAjqgKsNa0P14/0H01upzvqey8H6j8MUk?=
 =?us-ascii?Q?PI2H6Cbxa7mqvTYGh5Wr1up27VIAIVOchgUEtnrycDYZwPF3qouQamHPmj34?=
 =?us-ascii?Q?TwuEXzTiI5A58gKr9qUn7l/LS7/rkFo4fqEondwaWNNCP4edaeiLpVWEx+7A?=
 =?us-ascii?Q?EpBbvpwFs1f46nF5xS0OMj4MIRFj50TKwQroyv8zcIc+Wd2TgjgrJ6j+0t+J?=
 =?us-ascii?Q?4/BUvIjkxPAu2D7rlK4vl5+fsTYsJEg3FFDgBk2o1ecDJ+q9sdDMjLN32Xhv?=
 =?us-ascii?Q?qyMoRcKkOj6O8qjmxYACuZ0lgYHgstlfMs5Cn3UB49E9hp1GKSrqmLfWnYJI?=
 =?us-ascii?Q?JqbkI7tBubqDUo8B1vZrSWN6Ned7u7EiNXOa3Bki9FXMvpmLmfT4l5bOboHP?=
 =?us-ascii?Q?KYNi+pAiT30pRTlYaz6CybJxEXHkgelCOUGT+xL3BMGZYxJv3/NVA40mK00h?=
 =?us-ascii?Q?FK8/u1vLdspMX5MLCooTc+IHbUTOpzKs16iOEPmSJegGYxJoL5rqJQs06E8Z?=
 =?us-ascii?Q?/2g/5yIQDwsoeQMC7wAJwybQ5tyrp4RLdtXg/y8i8KvB9qqqlnzxKKDQ6QYw?=
 =?us-ascii?Q?Cv5Bd9rYtfW6fLT+1WANAXMEms0o+l5RAeXw7ZpIedtej8nDHwHSSUwrDWKg?=
 =?us-ascii?Q?8jcpmHKHRXpw6nqs/OaN205azKR5Y68Vt33G2V8LjrmcC8Pf7wKOFFcBWN5M?=
 =?us-ascii?Q?V+Zsacf52m664bQNLbCuT84u4x5qf0ypA2v3P1IWcFYrd0zhkPmpnw21Ys9S?=
 =?us-ascii?Q?uOzEsowJme3j0PW194uifcWl448bNyBe3k31t5q9fD5k+EyrO2APngNJ0XGo?=
 =?us-ascii?Q?3IP7pkkSkFpKCh3aE8JFJGJbwipCvHYtnE+1ezBk4JkWfZhPa7U9yDQtgA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 12:20:46.1978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7185dc7-4e4d-49f4-8d01-08ddd3515707
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8256

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

No functional change.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/utils.h |  1 +
 ip/iplink_can.c | 14 --------------
 lib/utils.c     | 14 ++++++++++++++
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/utils.h b/include/utils.h
index 9a81494d..9a8b8026 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -146,6 +146,7 @@ int read_prop(const char *dev, char *prop, long *value);
 int get_long(long *val, const char *arg, int base);
 int get_integer(int *val, const char *arg, int base);
 int get_unsigned(unsigned *val, const char *arg, int base);
+int get_float(float *val, const char *arg);
 int get_time_rtt(unsigned *val, const char *arg, int *raw);
 #define get_byte get_u8
 #define get_ushort get_u16
diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index fcffa852..9f6084e6 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -67,20 +67,6 @@ static void usage(void)
 	print_usage(stderr);
 }
 
-static int get_float(float *val, const char *arg)
-{
-	float res;
-	char *ptr;
-
-	if (!arg || !*arg)
-		return -1;
-	res = strtof(arg, &ptr);
-	if (!ptr || ptr == arg || *ptr)
-		return -1;
-	*val = res;
-	return 0;
-}
-
 static void set_ctrlmode(char *name, char *arg,
 			 struct can_ctrlmode *cm, __u32 flags)
 {
diff --git a/lib/utils.c b/lib/utils.c
index 706e93c3..103e4875 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -220,6 +220,20 @@ int get_unsigned(unsigned int *val, const char *arg, int base)
 	return 0;
 }
 
+int get_float(float *val, const char *arg)
+{
+	float res;
+	char *ptr;
+
+	if (!arg || !*arg)
+		return -1;
+	res = strtof(arg, &ptr);
+	if (!ptr || ptr == arg || *ptr)
+		return -1;
+	*val = res;
+	return 0;
+}
+
 /*
  * get_time_rtt is "translated" from a similar routine "get_time" in
  * tc_util.c.  We don't use the exact same routine because tc passes
-- 
2.34.1


