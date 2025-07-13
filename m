Return-Path: <linux-kselftest+bounces-37201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFDEB030B6
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 12:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0983BE05B
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 10:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBDF277CA8;
	Sun, 13 Jul 2025 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="UiDkGnJZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94119CD1B;
	Sun, 13 Jul 2025 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752403972; cv=fail; b=S4BkFVLaKXYa+De1u3qnV1Y88Q10RA/XDlQZm6dt0sb9HO6z8JnTGdXuJX8jD/1SHFgUulNWLeekh/KgEMn2p5eyhKcrwAnpwOiMqDD6MDprV0llHw08W3v3qfQmHfDgTYhWA2GyO2eXaWrai6U+tk7hEobIwbqHY8j8kxawhJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752403972; c=relaxed/simple;
	bh=2+X08KR2uZR3lBG7SMmOlA758TA2DBF61kuZhVSOjRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuX2y9pGdgiVH5W9jLjFCHdlKx7d57loM3TF2AlEm6yrXgpUOURDM4jBeOrmQa9IYTwAUY5XCgB5OeSynvEYNGUENG41gavgAnfVHxWBj0OIIABs8GJ0QlgNcYfXtBGggMaB+zbaJ7lxkSYJutTJ66Sbb/B3+QT2YzOX2e5GXiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=UiDkGnJZ; arc=fail smtp.client-ip=40.107.159.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wB9OJzvSPE3KeuDue6ImTYFKTib7MntfV4cT9VycYLauyxIATpBOUCqBdXbmz4nHlAh7TsDpIELs+EA2TDlQQqPTdt2QU3SfVYDsKDtGL19u0XE0qe9QAA++61xCSZ10C/7kl1K3S/DMou7I0yF+GQ5M5Hy6a8//sOmx5t06xQR7QH8THWMZWCprAsS+OUBLFjC7OHCOpvCdCYci8nkgXKaN7c62w0ZcgQrjTaiMl/nvK7beBn7ioDKTFLzw7l88ID5AkgA6rQcLMFpXryumARYPa7uwHZLj2JXVgFok2dvOZiMtWL54rZcQ18FhgBz0HKqR4FnNeOKmOpbzfP0bNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd+mGTCy4kr9sumObomQ5ywvPw4LhoiRcEi2WA0yrlA=;
 b=US1ZXk1imY7x/VsgDlSgfos42L4H+f7Q1w2e8gatFSgeMQEskIRMaMP1Cal28MK71RdO/ZLPcozb6J9RaSh8iqMNi/q2Y8+0FMn3ZQlLlYTbpUwfkCrma6qL+nUMjZsfdaCHP8mjpsuIJ1IQ47KQZhidoZcPwDfm8TlqzYtRzXVx/3YiYu5YXRBY+nl6KUfa3xEUe9yIl08o7MmNsW2WNgTiGJIcfn8e9KNzTTJEJ4NUFmGmlCfC2+LN0PZs0xNw2SXfsWZqtjL1pyXusMNXvXL3CcnxnEme6T84RasaqQ34Sgak5arGLqLD9xBo7WUvPM+a/w0uZTQ5ZXWJCRzrAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd+mGTCy4kr9sumObomQ5ywvPw4LhoiRcEi2WA0yrlA=;
 b=UiDkGnJZIbvauOGSadPTiuoBkCuPSZFOh2HqfXmjYNuhJ3BaEEvxJI5gXM58S93kyg9t6mdo89gQiiGwPdeXQHJREPU4HSi9YgnSHDSvtxRGi1hLICtBwl8iL98HVl1XrbHEMoJKm6ad67lq3UF7ILu8QOrFHLsdZGUhneGPsYVxV+Peo7zHq+dY3Pxv42BLZaG6ZFsxGS9xdPRIRl0/qFSqcig5e9UCHOP4vp6ZaOOpWwrfkpAnwoV1VjkS306didVy66lVApI2tjcM+F/vi2+fwVT2mLvvoSHHIhK1pAjamclww6iiIuxO6H910x6SMg/ypWSAxvHuMOssY06mxg==
Received: from AM4PR0302CA0008.eurprd03.prod.outlook.com (2603:10a6:205:2::21)
 by DU0PR07MB10682.eurprd07.prod.outlook.com (2603:10a6:10:59d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Sun, 13 Jul
 2025 10:52:47 +0000
Received: from AMS0EPF0000019A.eurprd05.prod.outlook.com
 (2603:10a6:205:2:cafe::da) by AM4PR0302CA0008.outlook.office365.com
 (2603:10a6:205:2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.30 via Frontend Transport; Sun,
 13 Jul 2025 10:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF0000019A.mail.protection.outlook.com (10.167.16.246) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Sun, 13 Jul 2025 10:52:46 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 30A0E1C004C;
	Sun, 13 Jul 2025 13:52:45 +0300 (EEST)
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
Subject: [PATCH v23 net-next 4/6] selftests/tc-testing: Fix warning and style check on tdc.sh
Date: Sun, 13 Jul 2025 12:52:32 +0200
Message-Id: <20250713105234.11618-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250713105234.11618-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250713105234.11618-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019A:EE_|DU0PR07MB10682:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 463a9818-dd4a-460e-82f9-08ddc1fb6723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4onPbN4Oh2gyPwPIcgLJSEgL6UQkIDbrXa9RDz5zqrtYxRrSc7Y8/T/sVmCD?=
 =?us-ascii?Q?yw3ZKo564I+EF5StNau5HydCjW9G5T+IM6kncVwjnwHBD0Hxm3nUINfrjLQ6?=
 =?us-ascii?Q?WKqPP94DgORuGgJfk0nUPP7hZ6D9N/5H+Oaaz5SqhOQMH6mQRc9KbTpSrWdQ?=
 =?us-ascii?Q?y3od2BMVBT0eFoKL2gBP9oKfzwABp3wMPxrITyT6I163l6UpeC5UmBHZmR4E?=
 =?us-ascii?Q?b2xNFH9WewoeEuCJkSo0lFPDetJDA1STPdC/vs+wk4JBTUO2sS0TPcu3/iC5?=
 =?us-ascii?Q?FK3J/fgKHzA3iVj+ZFQlDPAThjPIC785ei4cyFoqChPyEILX0fwwrDikT8lt?=
 =?us-ascii?Q?GvqXMcDnLzSfuzPASWNGnX7t7WdRJbhWbsFJ06UQzIEf27tUEEG9BCLmeRSk?=
 =?us-ascii?Q?dJZ1uFEa2obEP7kzSssZAHMoxYnqi53glPgj3rsqSTzjJ70K3Uz4KlF2Jrht?=
 =?us-ascii?Q?AeaK0EdqoM9p+5bT0ubmA27z7+wFPBeGnRj98yasW++KzkCFuBZrP/1ilpVS?=
 =?us-ascii?Q?UT04kWKLQTF0Y3lFud6/wmDG6VqhptJr6XtB7+0PJbxzSs4aOVRln/WXMkPJ?=
 =?us-ascii?Q?plAm8JLZX/RG6bDDOnD2WdYWS+cPFunEX52JRCQyyzv75Ntqjt8fSQ31Z3OG?=
 =?us-ascii?Q?CezF18NX8D4Kq/yczFrGJ2Yw0HtIGn79UJFp25ktU2smoT+Rs5g23WXzXKCP?=
 =?us-ascii?Q?tEX8FV+OgkTd2p4rieAH6QxVlf1O6leRUCH0fq1lcNZVnB2wlwO8Ndv7N2Vk?=
 =?us-ascii?Q?6PzEcOembTHkANJFB5iVT9WPO0mJ3iu/eZ+1Xv/V+pPlHt1utbDbWmZPPJlS?=
 =?us-ascii?Q?C9ISOoYvuedDOuP6MTz95GVPdnWYr36WEPT7azy8RzGfNEIx+aSz6MhSUuHa?=
 =?us-ascii?Q?s36vTGz0/UhVkIdA4bkeRjzyDqye2OQJyjzQM6CYYFnnYGt9Q7I6xjNMDR63?=
 =?us-ascii?Q?BMch4c5fLg2qFULUkGCayv2UwkYdonBuBE9L+jTRlMGVyOi/EnL0M59KcpNQ?=
 =?us-ascii?Q?hOlAIqcuh7PsOOQxvDJGYOB9cfida06snXvh7c0wQCAj2wCSRCfyftlvOeaV?=
 =?us-ascii?Q?it68kAeIy9Ljy+M0MFstGR7FY6qM1dRWrW42VEu+Nd0zjprFm0sm6NvFBEBM?=
 =?us-ascii?Q?fCxSmIUBjKu0XNezLK2WKe4FKiE5DbifF3BpKss9ze1+GJca8CKOm+neiEMg?=
 =?us-ascii?Q?+JQ00lL6Chm97KZolxKIXWUYV0Doiv/P3uHPuMxwwJR6iNHVHYQCxIBrL5eI?=
 =?us-ascii?Q?MSaMf4K8x1MxK/kedStoiqN36CPFS/UsWuyMGdCxYfw9T2V0VnNIWDVQoepu?=
 =?us-ascii?Q?aWndYMSsPTpuyuwwWUTCwFnHIFkajvzec6XHVrT974Q71OWcLXq/xLSE02Al?=
 =?us-ascii?Q?Aaa0NCqADPn3ZlrK1Y5Qq3ntIXSBE/TyLoU//bPl+RDZjcxajDIIEH2vzuWq?=
 =?us-ascii?Q?Zp7xiaXqDFKH70FQx6CmIQbM76lYuqhFeYZjKQdzYRTFWl8B0ts/otLNzdRh?=
 =?us-ascii?Q?Js58ULspbIySOZ3QYq/3JVxAvQihnk1JJNfIaZLW59dk0pY2HuHuTrTyKw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 10:52:46.7412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 463a9818-dd4a-460e-82f9-08ddc1fb6723
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB10682

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


