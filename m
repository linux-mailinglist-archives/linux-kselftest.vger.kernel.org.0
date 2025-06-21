Return-Path: <linux-kselftest+bounces-35547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A71EAE2B83
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 21:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA53176052
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 19:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EEA2701B8;
	Sat, 21 Jun 2025 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="OZfjbA1/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010027.outbound.protection.outlook.com [52.101.84.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47636253F2C;
	Sat, 21 Jun 2025 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534428; cv=fail; b=nleK77TPaX4C7oukFliQ8Kx++WwP1ZvuzwdYvP2F+4bUlexyCY/paFHfwMb+J/G33KHaQB7VFB9TKwLwxzj/9496c/ANICSXYzMnWjgksW9IJvKPfXagOGx3Rrn1eN1UX6OkRI1DIVOIaPwP0Gw3dCzPfHIYc6H8WPgLPb/u7VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534428; c=relaxed/simple;
	bh=2+X08KR2uZR3lBG7SMmOlA758TA2DBF61kuZhVSOjRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2uUZSF2CUUbonnUs2CYE/pXApGU2eE4IQhXWiZZZSFVNyQ7Lv58xaqzIi7ZfqIo2Zep4lPcu8jrog/xp7j7KUXzXARroL1m6ubpeVyVc+Ihy4OfNRL9QbWsGNsDCyJ6JXtfpPh391/YhEvV6pV1SdouvuFpKvi8mbnd0H+sdqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=OZfjbA1/; arc=fail smtp.client-ip=52.101.84.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gg3bzA8Ixeks60rq97r7StcEkioS0pwwg6PrPMJzbrb4ERyQW8kWiyuo0kDVUnqwbt9E/um1kW0KF4kH5CAt6T5lh5daqcuJNTrvpRXxA2rdvCaHNKPuXPLmG+UNnCkkiLlXI1zDDzSVoTwfFISYGb/KU0RfYe4SEwOMklbGSOoEm+wntdSkcHjE9Fs8mZtGQpFPeqzgN7P5SkzhbRl/yYQQjrTpLGi0DTfUJn6b0F7DawKQPzHqK2mSObgyq7rXm9+SjKzwKYrP4gSCKqGdbrwP7EMsTNdlRy6MuqEDEHntmYG93CgF5otJjUY9KD0mvzEMmKh2/oGIhUPXvl4diw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd+mGTCy4kr9sumObomQ5ywvPw4LhoiRcEi2WA0yrlA=;
 b=xr8Yg6n0h9E+QPPaoO37qxulKenG/asr03ZKq1gZ5hTb3eHiMYpYYl+TOaFyqRKx7nMB/a/4iLFhVJLMabhv+01fslrBiXVMRLPP21ZZmzM0uecoctaKMdlqx6+dX23F+BTzfzx/x0LbhdgeDgumE74IhJRovRP4/UtxfaEMQztb/OlFXTlNQ6NPTvh0hs9PLk9mnFbvuRUs+MWdIxHlmTXEpRww5fCEVTwiQdMZW8NipxCL+OzBnaVG5K1dZitK2sNbwXN6aYJzUIwsTDQ/onnyJTzhK0dQWp45EV5qiZ9tUB81jl9k3QvO8KzUT7E/gkbcoXLZmchrwQcDlsM0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd+mGTCy4kr9sumObomQ5ywvPw4LhoiRcEi2WA0yrlA=;
 b=OZfjbA1/E6Sz4GXlo0luhR0SvvJMfzBI0OceD/Hd95Ikb0/bfhjRaMWN8Oam9EeQhVf0ATClDoeR3kpZtBq4UEFPb3QnLr6jUFEvoTJTAVeuxvDx970bKF14AJwwotV3O/lPMZ0C8uoP9es8qzL5xSEbzir4GY4yzwaTYy+34wEk4eNSfEtt6Xvqninfa+k148YOM+kdI6rP4LF/m0xsCTmDCTztqkj//kVphm3gwx5Z2PaBdA3zysdA5scB3fjwca57ByGF94cyEpKSDoF9Nd7ZmFClO9g3qOOzEsAe5USeKt6BdEDtuFrkcolGd5ZoLUOZ0hSYeZkll4DCdEl3Gw==
Received: from DBBPR09CA0002.eurprd09.prod.outlook.com (2603:10a6:10:c0::14)
 by DB9PR07MB7836.eurprd07.prod.outlook.com (2603:10a6:10:2a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Sat, 21 Jun
 2025 19:33:43 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:c0:cafe::c2) by DBBPR09CA0002.outlook.office365.com
 (2603:10a6:10:c0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Sat,
 21 Jun 2025 19:33:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Sat, 21 Jun 2025 19:33:43 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 7C129680010;
	Sat, 21 Jun 2025 22:33:41 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: alok.a.tiwari@oracle.com,
	pctammela@mojatatu.com,
	horms@kernel.org,
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
Subject: [PATCH v20 net-next 4/6] selftests/tc-testing: Fix warning and style check on tdc.sh
Date: Sat, 21 Jun 2025 21:33:29 +0200
Message-Id: <20250621193331.16421-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D07:EE_|DB9PR07MB7836:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 12d8bb2b-d20d-4753-5c5d-08ddb0fa8842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DoJmx51aGPOyO3mAX9qqlfQUQLIg1Huy9ebSd7J1As0pxI3Bo2oVF0r5E9t8?=
 =?us-ascii?Q?CnFK4jAGG3Ct+NbKygA/TsTFotnhaVl9kuFCNbXnk+34YO8+WFDYW+MDW+GY?=
 =?us-ascii?Q?rjEvohXc9dpkIqfyQlRD5t7/725a7Y5OnypsPU0VVapQz1G0y20lrc2wW/DT?=
 =?us-ascii?Q?KHlG8JXvjV2LiUTkrnvhwYyzUmwaioCoitJ8QdgOXw0bpWkQoBdE5jWW7tca?=
 =?us-ascii?Q?opsZrZUwFj4MFd/TlrdrLby6kuqUZ34L08ZAE81QPlmDeds8oxJvVuAMe1PE?=
 =?us-ascii?Q?/hbZ3K1E/I2zfNqvdW6+Ar5yksVWP6gaBdYoUpHHQZJ/nZGhD2YqeAoVninm?=
 =?us-ascii?Q?pJimZZtG7y6pAfgxHaitZOrkEx2YiJF/rLa16uzE6kSC3cKdWZcXiTM5u74H?=
 =?us-ascii?Q?1EPRiEfL04nj4u9RGKrzHT9NXz0PpLJpHl/M3hh9eFxa34aWKJZACITAJFCp?=
 =?us-ascii?Q?8sNOMy3lnop/vnq75BOPkupll+o4n4LNr8xXhzx5AnyuE+3hKLc6cJ4Rpc4A?=
 =?us-ascii?Q?ogIokYUxk04nrggz4XghF8sVyHFBLaN3ITQ/aNcUc+G/Kt/O1fLjeuzKfojj?=
 =?us-ascii?Q?/mSP2tJewWf4S6waKJQ531Qirhk7pAJ39UjL4cJCdcIEbszp8R5ZmZW58M1t?=
 =?us-ascii?Q?sd8xyva2frsIBpuyt91YN5r8yqRLFMVBG7R3k6MlOdD73+V/hP6n1K4/HToN?=
 =?us-ascii?Q?IOLlDlJqemitl2Ig5jlrc0NPg7M5bzmsiidJ+k8w9SBvM6o4XDGWZ2bxT5Kv?=
 =?us-ascii?Q?PiilPHawzenK1cLsPr0ONYQv7gXPExHE6RaiDQlQMJmLuW+b4deN6vHsyFgh?=
 =?us-ascii?Q?LDJebhTTXgOzWF5iGqzRN6tS191RzQhW2GHJpab/TVC/vF/4DhgAejW2rvhj?=
 =?us-ascii?Q?7xIehsgpi6La0qtb4w/quuGa+quxpuDccBPKJ4+sN/Nvs87BXDXL7QThHZoo?=
 =?us-ascii?Q?EIx/74IvLnpeYeV29rofdLuC6FuNTIFfBpiiQRc51cyf4nhlM3rlmMI4RVXV?=
 =?us-ascii?Q?hhBfUDaVehWMaBqqVBOrEsVIsZxuGoNxJQGXUZwDFI9ITGZXXawJ5TBN3CCR?=
 =?us-ascii?Q?NWSjiYMIf6AFM78j5+o6jsyq/lVV+ALap004rulntSFBNwFaZNYO3DOiDhM6?=
 =?us-ascii?Q?I0NDd93N+enu6FC8ah5xlm++Fw2PJDYwC88K4ZJ/l6NwZ+qsNZWDbkt8Uyha?=
 =?us-ascii?Q?s9FWXBWzp3n6rU+qw/6PkJRytl0O0NjlYQHWYZXd1xXhzlLhZeIqunBUHtlD?=
 =?us-ascii?Q?E85kUj2T+1z8i1Tw7xEBGOxsApUTCv6AQzm13A0K455Tii4Qapumk4T0aU5T?=
 =?us-ascii?Q?5Qp024E/GW6hREIO9feHfKY99Vida31qtihh6oVcbhwMzEkBUPRwwro1Q15L?=
 =?us-ascii?Q?p/ZTzWklU/qD5oYD9RftfsHCJfOQAtrja+xTdlCgLm2qUdl9l7TJmZ095dMM?=
 =?us-ascii?Q?1d4i+vEK6a5HSoTGLCakhB/rQ35ymoXst4YGOEZ2xy9Ft5XsapB6FCAJAjdk?=
 =?us-ascii?Q?fKMd1pOwdGk7k3A3KmBk7J9K/yGn/ujHUzQ5w2UdIY4Z47SIe7GMuVSBRw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 19:33:43.0318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d8bb2b-d20d-4753-5c5d-08ddb0fa8842
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7836

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Replace exit code check with '! cmd' and add both quote and $(...)
around 'nproc' to prevent warning and issue reported by shellcheck.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 tools/testing/selftests/tc-testing/tdc.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tdc.sh b/tools/testing/selftests/tc-testing/tdc.sh
index 589b18ed758a..7a81088802d1 100755
--- a/tools/testing/selftests/tc-testing/tdc.sh
+++ b/tools/testing/selftests/tc-testing/tdc.sh
@@ -4,8 +4,7 @@
 # If a module is required and was not compiled
 # the test that requires it will fail anyways
 try_modprobe() {
-   modprobe -q -R "$1"
-   if [ $? -ne 0 ]; then
+   if ! modprobe -q -R "$1"; then
       echo "Module $1 not found... skipping."
    else
       modprobe "$1"
@@ -67,4 +66,4 @@ try_modprobe sch_hfsc
 try_modprobe sch_hhf
 try_modprobe sch_htb
 try_modprobe sch_teql
-./tdc.py -J`nproc`
+./tdc.py -J"$(nproc)"
-- 
2.34.1


