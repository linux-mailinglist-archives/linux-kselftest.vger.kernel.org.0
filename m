Return-Path: <linux-kselftest+bounces-10642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADE98CDF3C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 03:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187E2282FEB
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 01:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337102D638;
	Fri, 24 May 2024 01:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b7382p2n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B04D8488;
	Fri, 24 May 2024 01:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716514703; cv=fail; b=X7NZKvPc+0uN9tNbMtmJRpnieT77iAfwt2Mh3faeXWpvYi8DtRL5UBfUBo6VnnVvvXxnm0Jaj0nERUCVMS4UXxNOnuIystP0j8tpwFFUoKK4htN78nmR/9thC1NRAxc+mt9aYvY2+jag+f6p6MAHyCG9Ng6bv6uQ473LxCWqYMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716514703; c=relaxed/simple;
	bh=RsqeBLEgmTkZnUko3AFVUFeXNLx4MLMlNE0ssLqD2l8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/Uw5OeMifuvJzc/2icEk8FCmUrHWhi0CAlz0pWBZCJaRR5Zukh62Xzi6+rq/IuIu/gKwt468Qg6YsUTVPiDNqW52prB6P1OZsRb4T6Hb2bNatJDxgAPenISWFp1Xkrq1BO4z8x5iUOBPQ/Ex4GGV6BCMycSSUDAQkRmT3CtaJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b7382p2n; arc=fail smtp.client-ip=40.107.101.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gK/TMKxJefwojV0lhY+orlGPe4pgZ83KytuzoMG5nABWif+kngWOEKGlVsHM86gPnOlmVLSjo4QJDlRc6T6weTgL9Bd7/m1uyg4ftBIMHwv2q9Rz8BQTmQa5UF8ij90k9RpqYz/9fBkSRfGw5cy77UTc9noStKAh0EP8gef2yby4HACiyd5CoqZr9wR0lvttd9pjUI91b4FXErqAAwDMOGt5u+a3lzhuMuhL8cKpUWe3yOURDW/vsnzZLhZqD8TL6HOuxgcQIyojaIEctdKBxSFmPD6k0b8r7g/PyOlYdv/R6q+vXxRxPDEGQbUGgNS2RQpa8AVM7LFqKSZbEXsbYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/wmM8h3O3strYTXMvIHfoUjDzyD/wqwy9KmWhOL5Rk=;
 b=nusc8VE6M1UEoCfq7nsLg8Yzu0JIegBab4TLw0vumjloljEuCAEfD28z0aVPBgEzhk03SIARvo+xBtnuTN0VrnMPkgWmCdbOgNvLAULX68ngCP8g9FN+zACeXVWGgHK9RC+SNYczusGOCz+pXCPI7QQsAPQU8G/8nDonmSzWpNLKI+QqgiH6Mftf5hhkO7xgtWapPPHERHwadIqUM3wwo0iFK5m9wL1UsenusMScW1Cre7u9/i34XcBEUZ+DCA/MiwJ4KcJIwui7E0l30jxOn7cZCAVF22XOMsyrMFW8aGriHYDCo+9sYCjadhpOFFvIyIJN8WLZAbTtlo8qmuAjxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/wmM8h3O3strYTXMvIHfoUjDzyD/wqwy9KmWhOL5Rk=;
 b=b7382p2nB5wS9WIH2JFObAqZ4MTxFoWDoYxmT9/vlNfM5tfHXWlzIrH8Kz2I0fJ7LJ95KOrhl49ykFE3TX8YfD10WhiyRhVsX0ko0oKflt0OT8NBPJlMtGP1BL16UhvRlCzTbEVkvip8sSP1Dci3fAXYyQXxqWvcufUx2Cs3srGfSh5VbK5M7LaDzMB+6s+YxuEWzEzeB1qniiKujUfhxtTfHa4ZJeuHQDA7hih4aPnQ0f/kccz5Mr20NOfC4BZ3eVll3bV1DpEm0CXas5/dDaDs10otZThptwGfvMUshqXbShOwIdvXoJYu3VfBOmVLIM3ROEnjKctHBMk4CX/cUg==
Received: from MW2PR2101CA0017.namprd21.prod.outlook.com (2603:10b6:302:1::30)
 by BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 01:38:18 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:302:1:cafe::16) by MW2PR2101CA0017.outlook.office365.com
 (2603:10b6:302:1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.9 via Frontend
 Transport; Fri, 24 May 2024 01:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 01:38:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 23 May
 2024 18:38:11 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 23 May
 2024 18:38:10 -0700
Received: from jjang.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 23 May
 2024 18:38:10 -0700
From: Joseph Jang <jjang@nvidia.com>
To: <shuah@kernel.org>, <alexandre.belloni@bootlin.com>, <avagin@google.com>,
	<jjang@nvidia.com>, <amir73il@gmail.com>, <brauner@kernel.org>,
	<mochs@nvidia.com>, <kobak@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>
Subject: [PATCH 2/2] selftest: rtc: Check if could access /dev/rtc0 before testing
Date: Thu, 23 May 2024 18:38:07 -0700
Message-ID: <20240524013807.154338-3-jjang@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524013807.154338-1-jjang@nvidia.com>
References: <20240524013807.154338-1-jjang@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|BY5PR12MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: 357240a9-580d-4395-0f86-08dc7b92303a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400017|36860700004|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?enreto6JqO9tInWb20GxpAg2bJVvL441BNuOae15dxiwlYeHvHWvGTkbtoZG?=
 =?us-ascii?Q?lQdf7zAlMJQD5FsmT5KQT/05a4Bxjvam/e6koRKNE3FrfgpZEt3jnHY53uWG?=
 =?us-ascii?Q?61gFxiIblsgx9Ngl0C7de/H04h8BZ2hk+XuKQWk3KBB00VAm9LbSIvRG/2WU?=
 =?us-ascii?Q?gVuEf5ZajfVvzaqx20mr2X2bpfsZtiPV3DmxNQ+f+0N3Bj9sSY4QgEcaNCqc?=
 =?us-ascii?Q?fhtGF8X3P3VLHZoaQMhe5zz54KqzBD7Bj1INOy29YzUOzSNGc+NwFfKPZqam?=
 =?us-ascii?Q?ycvZ8t1M1iot6AOpiAQAemyi3tlDoX/Ug3dxmDDos7xNm4cT6gFPUjfufRd4?=
 =?us-ascii?Q?eOT6SGAOQ9Js9bA+TwIEGo+SHXiate26SMbOxX/5YjNr9otIHr1/j/fiT/kj?=
 =?us-ascii?Q?Ana9/ZIzPBCyMw/B3GmiIH45+54NIliyq8QbZODP1tw6aoVeEsK5X31IUjcm?=
 =?us-ascii?Q?ytEpfIrTiXCNHyLlD4A3/OKcE9GiCTcsQ1XZAWMmfQEXyBFHyz92V4u0Xj83?=
 =?us-ascii?Q?rMzrrUjEmnlLqIm8POtvXXoK6SKCwDQHIDmdp/Jg9iAy3BaS7np0nrDK2RWm?=
 =?us-ascii?Q?9sj1svTpmZeDjxsae69L4pl9QGMNwdxvafjOOp3UPfQ/VqJejm2OzNv9SRbT?=
 =?us-ascii?Q?/UjWq3cpGnXV3xsLUmkGUy2DnMQldH0X3xs0K7+2Uk367smdS2WegJxbvN/F?=
 =?us-ascii?Q?8cA5gcDQ/UtL/O8dmLbJhtPTS6ihCQaEb8EshmCNPn9tQCbdXBpqTPTYjN+R?=
 =?us-ascii?Q?R6XdC4O+EGjtwPVm/PB49dL2NBBcwvJhqrKl3d+g62VlkKcUd/8ecaLc7UYP?=
 =?us-ascii?Q?vlshcPmIZg2aoRcGGd+B/leUuYlyrJ3xP6I/cLXv78LGBuZirHNiBr80L1IM?=
 =?us-ascii?Q?MX9OXHyEFVZkThnFVq6Zsyn0ps5oUyE9wpQfYCaKSvkc9m3aZqu0fEzIEQqT?=
 =?us-ascii?Q?Uvfjqh9XitLjfyIb8gQgSxJIC91IM1k8ZG9gcBucciXvuacQzI60e7KjZDnx?=
 =?us-ascii?Q?H9Dly7o8h/Un/A9jqpMPpr2oqgto/SeFNMNiShZQr06bb1WmIMijLxTA4S4n?=
 =?us-ascii?Q?vuCk3QQdf3m5BefrjMYWugk1z5nNq1N+SIejLF3kKlc8pXkrj7MUKe0R/b7V?=
 =?us-ascii?Q?MjntYIBqukQoZKuL+5QJoySXbGyvqbMZHgbd5MzVF8m7RiRsygwEnIHJL7If?=
 =?us-ascii?Q?sN7/+UqCh/fL5Kw4JlJHxO4e5AwYPksA+Xu8oIIapANOJbXspIib3hmYRYvc?=
 =?us-ascii?Q?JUqKjhhU+SLkg1/rMY6g0si3TtIkyA081eu4TEjLcA/XzqI1SeHRruXDdEfb?=
 =?us-ascii?Q?2axdVklXXkfBw6y7MZuGW45b52Q1Zi1kUh/Pea19yvC3daPZsYmWHbmbKAfZ?=
 =?us-ascii?Q?RhyEWd6F3/A2KDUiHClcMX0BFBOa?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 01:38:18.3383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 357240a9-580d-4395-0f86-08dc7b92303a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225

The rtctest requires the read permission on /dev/rtc0. The rtctest will
be skipped if the /dev/rtc0 is not readable.

Reviewed-by: Koba Ko <kobak@nvidia.com>
Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
Signed-off-by: Joseph Jang <jjang@nvidia.com>
---
 tools/testing/selftests/rtc/rtctest.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index 2b12497eb30d..d104f5326cf4 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -483,6 +483,8 @@ __constructor_order_last(void)
 
 int main(int argc, char **argv)
 {
+	int ret = -1;
+
 	switch (argc) {
 	case 2:
 		rtc_file = argv[1];
@@ -494,5 +496,12 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	return test_harness_run(argc, argv);
+	/* Run the test if rtc_file is accessible */
+	if (access(rtc_file, R_OK) == 0)
+		ret = test_harness_run(argc, argv);
+	else
+		ksft_exit_skip("[SKIP]: Cannot access rtc file %s - Exiting\n",
+						rtc_file);
+
+	return ret;
 }
-- 
2.34.1


