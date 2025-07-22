Return-Path: <linux-kselftest+bounces-37809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B20B0D66E
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 11:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608BC542F83
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 09:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD2C2E06FD;
	Tue, 22 Jul 2025 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="rbCHju66"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1012D2E03E6;
	Tue, 22 Jul 2025 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178370; cv=fail; b=Z6EqtJRP2jdwZZr68GPj2xbVzYTESEryWY92wg9ReIyQAGl7ELKS/w2zmFOSqugC4mWdqRq3eFUHHtrZPGosVrF4dYxy3BXG2zBBgEfUbA6rHZknBGeEnwD9JKlTeJEYng8O+32wAkxcRIUqLhhAnU2jE5uQi88Nw3Z8tO7vcHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178370; c=relaxed/simple;
	bh=2+X08KR2uZR3lBG7SMmOlA758TA2DBF61kuZhVSOjRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juXDOe8zIcYPcdjcXM0ZpuwtSYkm+Q1yQQ+x643f5lVTHw9Cs/sXGZyL/c1im4RdSYdl2V8CXqigTVH7XvqSreBIvGBMzq4utn6lRlrxIe6388Zxod7qV5BJcZ7kPzL7327PvG6fDnXVuevWfFYLsSuzRXLhiHGvGOJbkSzKOcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=rbCHju66; arc=fail smtp.client-ip=52.101.70.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqPs0Dugyu//ODL4vY6aPRSC0NLi8XCVnkm5HFMIk/gYNoHReZgkqT32LilnfXpmNnuRgSJ/U6P0fonUhFXXZqSbQYRUeJwqcRuoZm456aqaJH2bsIdMJnWRd6i6xA5dZ52Nf242rfQpf3czC3ocg0MdpcSOSzX0A2VSeGi3yuwMHt4vKP6Y8v6h9OgSUCxcQQOFv87MUk8S1jdWB/rHsl1UW4IYxv9a/X3d6vfAJrOCQ9RdK5SzBxlxCV9zM/Fko+eUg/nly+kEw7vEeRrUO1djkltMlXlnFtq/khDr1N/nd7SG4U0wpC2/mayNd7iyU3D4iiMY4DD+kdW1SDwu/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd+mGTCy4kr9sumObomQ5ywvPw4LhoiRcEi2WA0yrlA=;
 b=rnjkzzz628TKoIrWC848y2vvaxH1Pzm6KAP88AkQKuXfLFlHQQGby+7fImbkDLtF3SbHiTXzqi60fbdhe54lEldR+4uhO61kmcP5KBd/jOY9H4xXNh0MXT8RJAmBiXgQoK/2PFYAhREDFlrpzcOLHa428CHqO7T4y6I4p0LiBYx0VsOhcYsXq0vRDKWuwcLtrIrGheYWgVHLp5PC5nAM5R+Ure9zIwUaeJY5XFrVW0rNdJmNrYeGfP2xiy+RxTbPYV4fzaBT28s4zfBckIXrguFQxRe1l+/uk566oi8cmveXGrYqNNQeXGoIKd781u9dDdKbTus+k+U0BYe0wINKHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd+mGTCy4kr9sumObomQ5ywvPw4LhoiRcEi2WA0yrlA=;
 b=rbCHju669CkCgRZlQUrEbUnh2B6+SrnR8WkBIeq8gExp60TbwK42T/R28QRqCKbiQfAlV7trqdFhwR0yKQT7UJ63jXB0iIqmFxj5ZrN30SmS3euoZgKl449GQJaEw1tQWd5lu/f1BkXXvC7EKE9CHqdiGzAtIXW4j/ZsOtv1DKRB+zM3yoMCGbo81Q9jdRnr3bUxqPujkMht13rwJUHtUhvRA0ilrg64SASPc5gly+kWz0oGTJTTKFYtRi3eDVbFdZNNQbsovP8Kj4R7RxxvHQeLDhj4+MLwWGxs8NYX3FA+R6aeufUlwMtNOKCO4pjHIyinnzfRmsRyF5c9y0oYLg==
Received: from AM6PR10CA0107.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::48)
 by AM9PR07MB7906.eurprd07.prod.outlook.com (2603:10a6:20b:304::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 09:59:26 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:209:8c:cafe::62) by AM6PR10CA0107.outlook.office365.com
 (2603:10a6:209:8c::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 09:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.1 via
 Frontend Transport; Tue, 22 Jul 2025 09:59:25 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 5D29A680048;
	Tue, 22 Jul 2025 12:59:24 +0300 (EEST)
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
Subject: [PATCH v26 net-next 4/6] selftests/tc-testing: Fix warning and style check on tdc.sh
Date: Tue, 22 Jul 2025 11:59:13 +0200
Message-Id: <20250722095915.24485-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722095915.24485-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250722095915.24485-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F96:EE_|AM9PR07MB7906:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0dde4a3d-88ad-4a78-2189-08ddc90670f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fCFcmQ8BsrvX/6ZEUIE5WZvxYYuyOx6HWZRF/rpGFUcGKLUjj+Fp6gsSRZ1s?=
 =?us-ascii?Q?yrvSIpdGq2Ide0mQd8w5YiEDzn4y6TUA0Is8J20PFvrngUMxxgZPvRz2bcFy?=
 =?us-ascii?Q?fWo9V4pAVNZDLDCDFgb2JNMnCY2wbR7NAPfcMVlg7SHnnakswCURYqJoswGt?=
 =?us-ascii?Q?bKtoDDJERlBjD1pmJGFeu3jfMTtQ56mtstMHTXgMUSim6rmazITco0DKP7O8?=
 =?us-ascii?Q?5W4Ya3F91vcGyg0wBwxaZ5qxdVnGt9mNWiUVGPPEiz1r/YYiCHmvXBUfgsAn?=
 =?us-ascii?Q?zuDsJNTgf9sr6jcd5wfL7b62dp6dr8tQxfv42JlhchHPYhByJOB5G0bmLMEe?=
 =?us-ascii?Q?DpZCzsLhgCEsrCDqz/+6xK9TY1rruivqmp6LD7eEKBy/FaPRLKe2ydMpwYMc?=
 =?us-ascii?Q?OyXfj97XCG7AmA1CS/WTxjc+tVTZoCLzl0YrPOLjOKbHIIOKHDIySoRI7TOv?=
 =?us-ascii?Q?d4pNQAHqdNuuAhgDKd+HoVGwKUeIi7/5IWweliiKQe/DJS9yNIOwfyLa8xwJ?=
 =?us-ascii?Q?530gk9nC0D3gnObPgaESAcJO3farh9q6pdz8LjoS9uHB+h6xlZv750sic4Ay?=
 =?us-ascii?Q?+lzx9VUVSVvDZRJ2EZONfy4RzvlEvHOtCzxgj287zcWW6uc1WqqFfXN5B8MG?=
 =?us-ascii?Q?qHL+EInrlXl09xH8RA9whWwpidcvThHydDRknzECzESo3YKAfoJC9LTDghA8?=
 =?us-ascii?Q?7XhQ3TGHCcjPe9mVXmWmTQVVwKvDR7Z250P+s4BIzJYgJBTazXdCVbu35ANH?=
 =?us-ascii?Q?QJBr4GxiNVkg5+wGQ7HYAiHbXBpQPbavWnDR6wKOPvJ7ziiXkV3Al3+47PZ/?=
 =?us-ascii?Q?wrw9SH6FkycRD9fSkraSmxxsjSW7ndXI0vfeKEXn8xGUyY7eu1+eZp0jOGdg?=
 =?us-ascii?Q?WO3CTFEKpfwLG4cuGEQe3Fy9GIuL48/Cpi3Usy2dmne3lDGrJwQpy2nanoGn?=
 =?us-ascii?Q?82GvxMweMgrsl6dvsQ8fOL/bt1JyFShRhGKk7+XT/uJje4Iur87boFWR0jU6?=
 =?us-ascii?Q?sHlebNUMZf+jkiYMKnZgaxSHH29HfijB70Ao64bB8mpeg2RT5oJW5O1OU9zg?=
 =?us-ascii?Q?Bfaqgcv1g3AB3Pc26UVwwmO7X6eyz9of3NcaFkjyDVwoi1bM36xrD/vIAJG7?=
 =?us-ascii?Q?COPDjER0LjGy2/l/Y0cpZwykOBhsuM4goqBDiyA9DhaJIPNEhV8CGZG/EiWb?=
 =?us-ascii?Q?ClC3x7lJSjR5sxz2cr99VGv+s4xx0biMDrAIHCjURsi2bKumlrKgukAKuuco?=
 =?us-ascii?Q?klrH0/SXILG2z5aCo29HoiJB5lawkoienI1N0wxUHAOn/uBInlB+dkJ4xGDX?=
 =?us-ascii?Q?By8wNkHFuyhBdzD7DkKoZ6kPW1pNp+GsCK1PT1C3XU/RRI/3BgQ52391C3nj?=
 =?us-ascii?Q?2ZAcI/6AQ2YMuRF8bUbbBTbKCEnPT7awC8XR77NlSCAXKCX64PEHsm3sOp4x?=
 =?us-ascii?Q?UKDcA0ezueZP0WRB99at4WQ0Hwt3OB98tk8mbyFLuB0kfjl3fyWG/oVU6mHS?=
 =?us-ascii?Q?MHkFhPKCTnIL9FqPSXowUpT7nIVedZfNx5cc5LshqiiroR3LWgOt2cT+0g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 09:59:25.7864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dde4a3d-88ad-4a78-2189-08ddc90670f0
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7906

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


