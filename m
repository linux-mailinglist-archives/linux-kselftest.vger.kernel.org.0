Return-Path: <linux-kselftest+bounces-10641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D323D8CDF3A
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 03:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31956B22906
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 01:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8823AD51A;
	Fri, 24 May 2024 01:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kGVL2AQv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFF32C9A;
	Fri, 24 May 2024 01:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716514702; cv=fail; b=NImiZaU26yPNWIMJx99H56OQVmHDnzJhZ4wOwV2/1omArIOj+0PewAr57zeghZReEdO5KZqjSExVnmtUW4gblfq4SIa7NV5xBaWTjn404ehEQn3RwUemfKNHriYCMtJsYdsbw03QQr5EE6NAjJ4jSAtohKF4f35CYAYKaLc7iXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716514702; c=relaxed/simple;
	bh=QdIF5Fw05r2IN8rZA7RzfzFZ4Zn6BsrUObsYSIOuFlQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gXULCoiQ/92xLtus+0TjevAl4oHrKVmb31Hr6ngoB+c1ef9dDeFSoii2uIjhsMbPTf0g+vSPjbW9NTTT0BNIeaptcVmQZ08I+FbrQnfP8+V18n/Hh6hYqlUzCyTHaco8sg3x11qnnb1dPLfAU0KSfjBZuWfRkrE0UKZ7wn/pUDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kGVL2AQv; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnlyRrIkVWxcHOFv//uXecdlUENVCaZzoGyI5Lrj4eshAtFOM5vPYbPXt+vmg7As+yxYtSNGAWBOepxkiwS+xW7fouOpDacK4bTZdSaXUZP+66GF6c/a4Ne2e9nyiOlbwCpcY7jWxDHno0D/g68nx29kyt/2sVFwO/LC9mtMlBlrUooZZMa53XRcghjvfsYMJobkaD+gbtGegdPVnIIH43YBIvmoZQBGIWOmh5Wqe1DYmAS2gI+OhPfYPxM31COivL84F4ghG7vvaC7AQOUNa3A6Rgo1c82dkoaY/kiZD37H60nS02FxCYkRHSZh7nFdRvvR/w3jsMhSN3gWybX2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVPhkuF5yKLlZq/6vlgj537zbhpR+2GXtD49MZCACk4=;
 b=giweZ2nkoYnX53fz0q9aw7DGqlWBSWrlt5fH773oY5b91+IxeoYbDcwmbpRzyCpIg15gwWE0tc4rqUEA+X+8NEdZjGAk0ICP/Yc6AcSXwsvMGstLSXcmXzO7zMl4KCdgGoVOrgs8i9GpKN9/wy2Jgq77GMAQEu23qFRdzC/WSnejd8HzPt21t6S+K3N0gp7De+r8rMh0uhN/HvA3glGH+EZNBWVkJ4wXlhPZRBKXqjhkyZuZ2pvmitHE8BJCc+fFMfmtlbWRvywTySwYeUldi/Mz7t3jk0452TWcGUcVbbYGW3/gNw9WJeFIpo8Bqxb91oyZP531RiyXC5T6vLS6AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVPhkuF5yKLlZq/6vlgj537zbhpR+2GXtD49MZCACk4=;
 b=kGVL2AQv9P5cbmoGvAxvrxVMfHwQsmfL8CnxNr8q8PMjGjA7ibBcqupdWa4/6oh0esFPnX1puQ2zxLksZo5i01K9yXEzIPY+0XahhKMXJXVVTI1MxXwkS/aMpx7U/+1Mw2kDRpg5QlA4z9x0h7QO9tqDlLMHFmxjw2LLC8CL+zx7QgGOI59VLe4Sy+9a4GwlEYTvhYA2ow34JU/2heNfbI47qZT8gInmdzWGr/qtCYkSCjJ+tYgSLxYrxvulNg0AegVXvCvdB5MZWL5n/ZE4UOQyX5P0M8vGqVZYJY2J6I1I+0NftIo8V81lFGR7plS0z4187Au8j/VIrppa+ZWv4w==
Received: from MW2PR2101CA0029.namprd21.prod.outlook.com (2603:10b6:302:1::42)
 by SA1PR12MB5615.namprd12.prod.outlook.com (2603:10b6:806:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.38; Fri, 24 May
 2024 01:38:17 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:302:1:cafe::b3) by MW2PR2101CA0029.outlook.office365.com
 (2603:10b6:302:1::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.9 via Frontend
 Transport; Fri, 24 May 2024 01:38:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 01:38:16 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 23 May
 2024 18:38:10 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 23 May
 2024 18:38:09 -0700
Received: from jjang.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 23 May
 2024 18:38:09 -0700
From: Joseph Jang <jjang@nvidia.com>
To: <shuah@kernel.org>, <alexandre.belloni@bootlin.com>, <avagin@google.com>,
	<jjang@nvidia.com>, <amir73il@gmail.com>, <brauner@kernel.org>,
	<mochs@nvidia.com>, <kobak@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>
Subject: [PATCH 0/2] selftest: rtc: Add rtc feature detection and rtc file check
Date: Thu, 23 May 2024 18:38:05 -0700
Message-ID: <20240524013807.154338-1-jjang@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|SA1PR12MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bbaca83-d561-4237-562b-08dc7b922f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|36860700004|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XqyUfRyz9ChrjyOthLp6jyYAZP1SaFccSeJnkFDKepIkKFvo2mhh4SsqX2pB?=
 =?us-ascii?Q?ByL6Bl4IsPe7wm5QzYxUaEeQk0dL89DUzxZSVhVv9Hr9K+HMoIg4M3NM+J1n?=
 =?us-ascii?Q?SI+C1ucBFY76M1CHEXC6kTQAWyoEYM8/+l5AqORjG55vePEu5C3XRCWX394t?=
 =?us-ascii?Q?xBTe0CvSm/MhHW3abLjQuDrYrufOiVPJCCqk4+mwwuJ3FJi8+50sY5Q+GiAd?=
 =?us-ascii?Q?4us+7WqKgpV2bfLpA1RiuhBiPCeqTpp6Ckg0sjtuAnmspAR8n31LpfXsEHKv?=
 =?us-ascii?Q?aTDkmqVwLdXc4PSUYdT8Jn8TzgOHRozOVd++Sbo3/bfjN+TG+tj6gkgeNxDG?=
 =?us-ascii?Q?VLpGXTve0WEB4tkUUgjxXmZa4qmp6fW7wKy4/lD6UwTklJNJ4U88U3s9l3Ar?=
 =?us-ascii?Q?YadQUr74RrJg3eYM1gcQFRRq9EJFMhnDjy4w6fWuz9vq4hc2QJkCKr2TwZe8?=
 =?us-ascii?Q?PQOe8v1DgwDP23u+JR8bZ+i9JMNUPmQ4fMQ/PubSF5qEvgxGiG2OfMca0BYx?=
 =?us-ascii?Q?TfHCmMOrfsW56YWraKquGkgcL8NwcVWQY5addM5BnvCgW/j3nWop7S0Fd4h5?=
 =?us-ascii?Q?jNYDt8Y5gW1ACFyKXqWpELanGU4USc+xBg/zW6k7qnwwunaQp/sJ/LI4kPlX?=
 =?us-ascii?Q?U7RqU2GVDK953fxUL+2o1zFr58cue7V+HGw1RjWh3R656eietSD9H+QrQu4V?=
 =?us-ascii?Q?jQfRRB0Vi/PUQtVRAov8EjI9Ks/Xjvi12mTsrxHAes96CxewQ+5KyvofYf7Y?=
 =?us-ascii?Q?fLEv3GN30t9Qlb1qLLvYLOTeUaAidSZN95jvsggupJsmGX+7uGyN2hpMSquJ?=
 =?us-ascii?Q?Noz02VaeLz56n+gWKGja9ATyZFoB8eDkri60KNyMG3pXo4nxINOTlRQINilU?=
 =?us-ascii?Q?wPvGgj8Na2DZxMJ8zet4e37IKCfv0LZI7Ly3TziCWf3flWGBAI+rsG20kL5B?=
 =?us-ascii?Q?pJVf1TdzJmEHWSQY53OQTgHGg4bExBzVUumwYujW8VSovEEzgoJyKeHRax0Y?=
 =?us-ascii?Q?khKi5IOnU2j6/IRpeRafjuc8XlIYcFh68O0FBC1brsU8pLHMOkiE2Sb/EXcv?=
 =?us-ascii?Q?oyNXFWCcdfgU8JejmcHd0mP22qTySnU/Rb1FVzuE9UaF311hhHfP3O7gfMLC?=
 =?us-ascii?Q?dYmCDfjwlYAhqEhnM7QV7EeadOofJgF2EUFXXOUFAXhft5R6wjASEOkV16Np?=
 =?us-ascii?Q?s1Khjt/8xVcc6NOWh2eIayQTtQEiM4UbaNio5EwgtLbQfnjwnx+kKB/Mnotj?=
 =?us-ascii?Q?aOZCfffrk4NR9ty/0rDs/eJVXVpgOmaqvzdjKuEOXQWuPf3ZuvZWbZ2eFIsx?=
 =?us-ascii?Q?SRrooLmOWBDzXXWqtvpmI/AHuBmONn69Nd8pOCLTkWxcuXJh2pXnASxDjhFf?=
 =?us-ascii?Q?UAz/+heyMCHWOFKEiqaSKM9WpDu0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 01:38:16.6820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbaca83-d561-4237-562b-08dc7b922f3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5615

1. In order to make rtctest more explicit and robust, we propose to use
RTC_PARAM_GET ioctl interface to check rtc alarm feature state before
running alarm related tests.

2. The rtctest requires the read permission on /dev/rtc0. The rtctest will
be skipped if the /dev/rtc0 is not readable.

Joseph Jang (2):
  selftest: rtc: Add to check rtc alarm status for alarm related test
  selftest: rtc: Check if could access /dev/rtc0 before testing

 tools/testing/selftests/rtc/Makefile  |  2 +-
 tools/testing/selftests/rtc/rtctest.c | 71 ++++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 2 deletions(-)

-- 
2.34.1


