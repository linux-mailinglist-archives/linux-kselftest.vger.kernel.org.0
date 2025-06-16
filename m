Return-Path: <linux-kselftest+bounces-35037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98B6ADA74D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 07:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 768BE7A649D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 05:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C9018FDD2;
	Mon, 16 Jun 2025 05:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DwjoTjov"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0C311713;
	Mon, 16 Jun 2025 05:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750050160; cv=fail; b=vBs/GzCjYVvKZFvD3ZP/PPPe9WTCC7Ft19DAMnD6DS5/vA4tzUSy8p2y/kHqJKAG5fYF6snh1VCzl4Qt5SdZamPI+Oz3mR+kBotj72GUakLf/OrAp3l//pUELUHOQDLYuXfb1CV6+yF28+ukqNROOkXdDsbOW0U40VnKJcdh7gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750050160; c=relaxed/simple;
	bh=DKvZlZfZugcTpqsJzLpT3IVzc7IyaXekg+nFJIzj0W4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJb7ItKZO19WB1pjQ67LVPI1d8POb+MhmvTUcToypROwQZnsOk7BEWfiTkvDzDGz9sjbnsb44OpYqizoOz9GRp/1s83I/P+K64NE6Jp82+nb8J6oYkCTJqCPG5uiE4OiGauPv10wzcklR0OFjFPqsZdBV85zS+vioRI5m4D11H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DwjoTjov; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHo1q3HeFZw8ppcDum/CeVDpT8iMMKMjEVZH/y5e8KOsuukxEmMiCVK5Xt2OsLR9HwU3zW5xuOvkrZu7gXMxKx7AAqKDP5vjdX7E+8cFt+ciRVFnGtlOQkDOO/tVTP9Fi9GjPHW/KTXUE5Xw8crh/tho9OCt26xgmLGUVzB8b5jGRg6coFIY6h3TLbpMShFpCiJ5A1WeNP0RUezgKrMGrecsi9qCrH9Qj8Vi9uXdRtNzU5Kjfwyoeep39cCtZCB1Qj+29PTj3Ec+cN99Wk8T0c1S0iXhbwaZNZE05ViOS6u/Q9QSECwca6aw3XrNwoUXWmWi5GdXectD0wHlpYbRzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5OiqD5BqXOiCSiCIE91aOsNrztGQxAxKjA2YRJ0qrg=;
 b=HvXRovb+mGJDkTOOwEnQO4BXYGWOrsSngNeBd4iPf5c2Gh8PQkgizRpDXYuI57s8qwRwdCiG16N7pVjUYUfPVdqSMsvo2wjMZhUGffMzhrHmKbViR6psvuSKTiuh4Y9iNfzKmjrnmwPTyq8qGhsDsmZ3Qd/EDEkgijvyTiUKwHQvsE11SbdrXLdYOh9ix57vw8xu8F51JoPyxiauPX265D3Decx/ZdwPk617jAZqldvNKOOfCLA0dKf3zn7HPQ8ChaoWRrHyNn3Q52C/TnxbVeoBbeCd8GfqrUT+IUmo8u0Gq6C3tZu8SG713KRVPXByat9XDug6Uv8NfA5HrxOE+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5OiqD5BqXOiCSiCIE91aOsNrztGQxAxKjA2YRJ0qrg=;
 b=DwjoTjovaxRJKYFnOiGZwe6Z12gbVlIxhPVb5psS8YJLljaUNKN/Q5Z6xu7jrnEvJcsy/wMCOr7tM/vb6Nimc6kPvq10WWufjUv3qgsmmwFVSFm/ifWM00xQI/Jt4/41W9Ib3S0LMhHJI9jckWVxQY7gkTr8ne5GVi+3UmUlwzODFMJCSotmccOVJegNk18j/7VPwmK6kCT6EC8uSHj2LgcA3LCOG7a/wu2GCl+xwdiZkXTZvIWw5073BJ4Cc9kKK3BQqozU0O4RD9WOF19u0pnsknUATp8M7j+vb1+wYC4JMnjCgrqYeBLkmHxI+/eAw9dtTbFF2bENYGbJxCYQgA==
Received: from SJ0PR03CA0369.namprd03.prod.outlook.com (2603:10b6:a03:3a1::14)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 05:02:36 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::f3) by SJ0PR03CA0369.outlook.office365.com
 (2603:10b6:a03:3a1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 05:02:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 05:02:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 15 Jun
 2025 22:02:25 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 15 Jun 2025 22:02:25 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 15 Jun 2025 22:02:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <shuah@kernel.org>, <joao.m.martins@oracle.com>,
	<steven.sistare@oracle.com>, <iommu@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thomas.weissschuh@linutronix.de>
Subject: [PATCH rc 3/4] iommufd/selftest: Add asserts testing global mfd
Date: Sun, 15 Jun 2025 22:02:05 -0700
Message-ID: <03ad77076f50a1931b08cdaa37c3a0e11038a934.1750049883.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750049883.git.nicolinc@nvidia.com>
References: <cover.1750049883.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: f06b6165-9156-4ebc-a978-08ddac9301ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NjjBArR3LLn9OJ1gfRFNm4pMmHI/Xn2GWokjRoBjHjvRplYbwTDH1p1nzxHq?=
 =?us-ascii?Q?r+cCH4ZkQJ19L49YFG1PsyQcb7pJCu5sFEXxF1d2ZN/tY908dKxucxksKl+4?=
 =?us-ascii?Q?n9k1PnRL3ZVbvW9WHp0jRmUQvacxqsjtyFs8d3/UP2vmCWGl9FLdTF7O4yMI?=
 =?us-ascii?Q?dwzw9pKYocefCV/Q6LVh2knbN8IU6DLjNfPMyJLVb+VoyumviJAoRusSIume?=
 =?us-ascii?Q?IpgLb/5NUkpr7J6hZsaRhXn250KcDcgrBvErl/YmjZifDr7RhZ97jb738wr0?=
 =?us-ascii?Q?evws/gIwEoS3Skhtu+c5/VT1/ILt/iX2BGZ/AY1bIpgz8oMh0XCJdgSOC9nS?=
 =?us-ascii?Q?x4tnI5T2sYs9n63K6K3IhCGXuObdO/QbA6tUhsbc6cLYhRB9tR3COrFRE6//?=
 =?us-ascii?Q?6BWbz9phaIEArrN2bflhZ9R2NkO3rHBWYcVFAqSzL4YD08M54c9lTq3Rl3LJ?=
 =?us-ascii?Q?e6fansMe7mS0MVfcpwXjL/9f9tpSJ+4UKPKxwICNZMYDNsMsoKKs4USRjO2j?=
 =?us-ascii?Q?dcPqpiyu1ZO1OcTe9a7ZzXzfHX8wbcoslxzKNTpgz7Pd1ROlsG0Kbx2hV2Lj?=
 =?us-ascii?Q?lUs0QgICIxJqd1hJzOWscW/PHZUcA+y0MWj1JaUY5Lzvn5j07ROc/6MzQxCB?=
 =?us-ascii?Q?zT3nT3180ygp+EQ/MGENi6ycOE1ymmFxtclwvih0JgD0jxjWPhMSoDXK00Iv?=
 =?us-ascii?Q?RRe/9VDXIr9Rw742+52dpl6Oz69UpbUhh/Nq4UpXG6Z2DjfQoxM7p0erWTv8?=
 =?us-ascii?Q?Hp5GPIbNNtdo9jW1JJGUW+XTB+xu2RIqLwkkVpnd/IIAzY1Vg4lqsp+L+PKV?=
 =?us-ascii?Q?0oI3x2Ptj4cHKayHj10DrUmTJcWfOjZFGqi+WWtbHXQBRWnHUvRjH73HWMZ4?=
 =?us-ascii?Q?U5IiZReqmfB4BjMcdEaU5FsS2NDwF0P8BmSM6lMdg5wM9O6VLVrhVrUK3pgN?=
 =?us-ascii?Q?EPGJWIZqZq/u/8AfgrIyNT3o5KBvuFiQpmXIJdjAr07lfSvIRciKTpouyNJ/?=
 =?us-ascii?Q?HBd+2wBVld+l+YXCLKV42rLDYjxTstQkN8M1b66SqxgG9bC/xLaitx4XOUoP?=
 =?us-ascii?Q?AsSkUwvvwnaZMxbczHmZkWxhP/83TssbRVNRm2lKcRnI7er1tH5Jai5Xp72h?=
 =?us-ascii?Q?Msaws/EhaO+jRMprOrw4EajOJevvpJ6VYhXPTP1Y6GqCkH3WQE1EYI7Yj2Qo?=
 =?us-ascii?Q?yOZIXLwjz2y2y/XnvqcYF/iihAwEeUN8je8Ruse2F8lM6+Bp5/zbtvn2R+4P?=
 =?us-ascii?Q?dEOtOEx2W3Uj+ErdnB7cc2tfa+kWchAX8Y+r9YukFUbqFGzFUpxfZMfXh/NR?=
 =?us-ascii?Q?Xsv7WXt3/cFq7NBYCPHYizmq7uIEvAQnkEyv92GdjhjfL/F87loQxfzle/Mx?=
 =?us-ascii?Q?/Ml0G3y0wCLzSEO80jywvR3SVkJqJxVPTr5L5hSfb0UuFxPJBLCngUCNyukK?=
 =?us-ascii?Q?6c3tkLCpLk+JPdz0HuIuMkZFAXUjPLfaQuuXhax85vTMCBR08zAsPxBoFkbI?=
 =?us-ascii?Q?yAmc+j/kCCNw4k4WFmb0McgX7Bi65ocWLrvn?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 05:02:34.8180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f06b6165-9156-4ebc-a978-08ddac9301ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491

The mfd and mfd_buffer will be used in the tests directly without an extra
check. Test them in setup_sizes() to ensure they are safe to use.

Fixes: 0bcceb1f51c7 ("iommufd: Selftest coverage for IOMMU_IOAS_MAP_FILE")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 602f8540242b..393d95f88ad4 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -55,6 +55,8 @@ static __attribute__((constructor)) void setup_sizes(void)
 
 	mfd_buffer = memfd_mmap(BUFFER_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
 				&mfd);
+	assert(mfd_buffer != MAP_FAILED);
+	assert(mfd > 0);
 }
 
 FIXTURE(iommufd)
-- 
2.43.0


