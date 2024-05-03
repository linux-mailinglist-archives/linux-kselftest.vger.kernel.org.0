Return-Path: <linux-kselftest+bounces-9303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E618BA4FF
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE785284AB6
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 01:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD944FC11;
	Fri,  3 May 2024 01:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gaccD0vE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB52CA7D;
	Fri,  3 May 2024 01:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714700488; cv=fail; b=HfR0k0w3Bmq7g6ryRNnoNWRhWlnV73WNegXCz3gVU5RJKthQWCxQL8EJUEkXeFzK+zkjs/4PERA9W/JcFpKuxCAOP/yavV3hYu56zE/A5zR6PWjLzYTfQys1YMQOchcizCFvqOUT1Gooy29ARBjaCi50NiBeka7CnLDRoKCtKQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714700488; c=relaxed/simple;
	bh=6oX4B/ywuu6wOeHi2XgQRNMny4WuFOkHoN1Ym67S0EI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iuxNJ8hp7r2jhuzysBQlcHkCDEByYJj1XgsRc/gl+9NyzXB2+P8IXzTNW/0dReelgzAHSKuu0I7S/mFB3POyElo9NnW2LP6WR6DyHTZ2fj4LAebFFNjaJa6s0Uz8GhVAhqNH9TyDA54Ke9d5hd1RnrkfLSRvFvSaPV0vBvq+6qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gaccD0vE; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9/01bGtWa9t9LISJZ59Q6WyR0uWcWx7XnSYX2ApUx1Gb13Kup3elGeB9u2XC/lF1MuvmKDJpFvXjDm0c7q4WcoPLqGR2/I7Nl3k6TtFrv1B8mkzezbV2VSV4WGrtzSU/PYH7tD/WHlCn1JFQRW1pY7C8CTzNVU63O0UBA3z+bhBhSGJggACCvnLH7lSZDhEho5hfcv3yX0HXeELhHC+2iIWwungYNXmHWrgsRBW3B33oG+miPUY4ZxK1n96of6h14mO95a6/eXLwjKS16Cb99q2QDC8jH0gxUa+RNi8p4pQdVJ6Z19/GgM5rm1kd+n+/Nk2f+l7AW7T8c8UtliB+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4G6XthwEd4WBPaTnjOVzBYeGHj6pKvuamTwpStqDBE0=;
 b=oNFMan02B2zU8XWXC4tvwfoLFKOiZWUcwnQxH37ysGQnsQhW4V2tbMyGWYftPFCDzRQ3ntnKCO3kMNsipFMh0Rk6Vgko9D3q4wL/8+/8sNRdxYRQq2pi/K7vIuR655W7aUmY9KUZzRrOhUWEgoglEF2yaWqhdEJJ2cTgcIpZArKfDrRod4zfc9+37jcNQ4AkSJ6MHeH2t2e/e5GPUE/e2kREUIy8amhLXIXabPn8j/FrdGdSY9Azv5LhXAiLnSWuRN9hOnE6LONVUYk1IxJdFUNhWQHe6z+Wm0tWxnO0u+9U/5fCWP54sm4Hrq89WGnXX2K/+X3oTEllhbh78d7i4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G6XthwEd4WBPaTnjOVzBYeGHj6pKvuamTwpStqDBE0=;
 b=gaccD0vEngx65PmdzhSQoZ0B8CaNAgf8rO3AeBnRdk0WjbxJ5jt86S7ltgE1FzBf1fddrbpGYU1Tn2x8M7/otVUAz/k78DspKhC03qi7Wv6IIdLEZg2Ei3KCeAhgOhywbxeIzt97hM8zugcEDz7BWX6d6eXwY5hvnCTErJrWp30d2IzIPjcBXW5yVJDrY1pGaFj2EHisgRzGTXDcLeqmot007mYvZEyqsidIJVjh/Sc5tlPcGNvTRjeeP1Cf48XD5s32HvBIPbi4vrBaJmjoD/bXJy8hQJOyFssZD6qKpw+mKTVSugQ9A0dl4+zPqPeDlDl2j4EGxePtdXL1yTuzKQ==
Received: from BY3PR04CA0017.namprd04.prod.outlook.com (2603:10b6:a03:217::22)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Fri, 3 May
 2024 01:41:23 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::37) by BY3PR04CA0017.outlook.office365.com
 (2603:10b6:a03:217::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Fri, 3 May 2024 01:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 01:41:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 May 2024
 18:41:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 May 2024
 18:41:05 -0700
Received: from jjang.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 2 May
 2024 18:41:05 -0700
From: Joseph Jang <jjang@nvidia.com>
To: <shuah@kernel.org>, <alexandre.belloni@bootlin.com>, <avagin@google.com>,
	<jjang@nvidia.com>, <amir73il@gmail.com>, <brauner@kernel.org>,
	<mochs@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <sdonthineni@nvidia.com>, <treding@nvidia.com>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH 0/1] selftest: rtc: Add support rtc alarm content check
Date: Thu, 2 May 2024 18:41:01 -0700
Message-ID: <20240503014102.3568130-1-jjang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b732d1-e05e-489e-2913-08dc6b1223ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|376005|1800799015|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZiOj4n7InmYl2YM95NtxFslYhWDbfJ/KVEPSltieBOqigYmDDTlLm5qv1Lpl?=
 =?us-ascii?Q?qdRyix4F8p+zb2Opi6It9kSmPD6IZE5hKKUVSVM/hztrxNsIcov6PaU96nCU?=
 =?us-ascii?Q?8TmOtR+lZB7363IDbjbKNy/TlmKFVlD/bfehV31VIUQ2pW9aX3MTwArlVYHv?=
 =?us-ascii?Q?lJ2nNG/swWszjwBO6KAdKnmvF001G5o1B51nCHsS2Li7A/niNx5odebfhm08?=
 =?us-ascii?Q?zC95Y9pc+IdC3sQwg4+8kh/9Nr9sB6pFHXt7rrqDnc5pVPeT5gH5LcqEhWmj?=
 =?us-ascii?Q?dYMERqrev1GiUdtApe+4U98loL3Twd7V7dFTEK1LZsrZ4OPmTOQBLCPERM8U?=
 =?us-ascii?Q?BTmNXyJAqTfjSgo54of5SfRDbdhuJfzjqt45BW8wP0nsOjV5G4LnPzqazIll?=
 =?us-ascii?Q?/HiI1hw+5PYkIYXW9MuCq2MgqmWSNJjOkjq1d3b9ag5qHmvnSm0Sr9jViryu?=
 =?us-ascii?Q?pXzgPYuQkJbl1p7dmvCMBxvUlSFyFRp+6wjv1Q27KszZhKipQxWvkn/xkKBC?=
 =?us-ascii?Q?t8PvZRb/8CaDSFn3ZWU2V5VqER0F2TfSYcCZubfzwNjnBuymJRjSUO/VjuIy?=
 =?us-ascii?Q?k/L4OEKgPrt2VNoedJiUtIhwpKzfqIm/jcpAdyg2aU7Mzu7agWoDUBtqGQkF?=
 =?us-ascii?Q?0uLVVWGR1fWOsE3A5O/IfpB30lWvKrzF20HC+8UlSj66GAMsHnYSew2KPQxd?=
 =?us-ascii?Q?z69WeXMivTLy+nReXjvHDy/DSyzL9aN6Zn/1Q3QZB/QmKnES/RvRST3HR/YM?=
 =?us-ascii?Q?iCi0zt7RlATXQ18JOhSOTW5Y841kCAgeN3EEFY/EfgAS4/PvVc9VA6Z+aaVP?=
 =?us-ascii?Q?QsmSX2129pR82uVuA2GY0EHaQ/SrNBtaRLXFDPMx47NJ7HWptqlkNuSsuzOp?=
 =?us-ascii?Q?85IWWlWUKPZs+rdgDkA+q25aFFuDFrQgmB4LGbyNuVtNp5xaQtPBhudkFGMe?=
 =?us-ascii?Q?8XFM+nEZTDrMbt0EQyeWJApx7gx3VSxtbltdNBEJmzMT07YJ5b7nnEZEuI4c?=
 =?us-ascii?Q?mK7jE5P6vxP/REJdrV3eIW/CoSmBEKD5jmigELfP2uBRBMm3EoUzaalh6LSW?=
 =?us-ascii?Q?oZZZxCg8/uWdVypC0uASR8P5YCRU9a9uHCVoag0uzD6n1nj1pH0B+1DBd5Tu?=
 =?us-ascii?Q?+dm8ClX89QqRrkJWakPwTzTJa8eX8x13xyoxueDk0EkRHx4fkyOCgK8DG4oy?=
 =?us-ascii?Q?burIcKlo1yxPr4NEF2Vp7pJp9IIA0MjNS/NgZLzK+YpA6Y/+7jYHQdWqPGZM?=
 =?us-ascii?Q?iJoiNk+i2JY2OS0yrLll2r9ZxE0xYV//JKhSqSd9Mu8oX2kTusQ1FvZbi9jA?=
 =?us-ascii?Q?LpcBNx3D2e2fLACi6vhRJM6AY/ITaZ8LBj2bynaVF3ajyUmdURM7wbSM/zi2?=
 =?us-ascii?Q?9/R643Fg6D3rg7dDgxz8zKlk8Aa7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 01:41:22.9623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b732d1-e05e-489e-2913-08dc6b1223ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898

In order to make sure SET/GET WAKEUP services as optional patch has been
integrated correctly, we have created a shell script to validate
/proc/driver/rtc when it is not empty and then check the absence of alarm
content in RTC metadata according to the rtc wakealarm is supported or not.

Joseph Jang (1):
  selftest: rtc: Add support rtc alarm content check

 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/rtc/property/Makefile |  5 ++++
 .../selftests/rtc/property/rtc-alarm-test.sh  | 27 +++++++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/rtc/property/Makefile
 create mode 100755 tools/testing/selftests/rtc/property/rtc-alarm-test.sh

-- 
2.34.1


