Return-Path: <linux-kselftest+bounces-35041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F12ADA755
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 07:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD289188E8ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 05:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DD01DE889;
	Mon, 16 Jun 2025 05:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fLrz6rNW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578261DD0F6;
	Mon, 16 Jun 2025 05:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750050173; cv=fail; b=H9rJeeKaf/pTzd7wq/F8qIZrjSQ6SwX0KnDt9RPjC6+ARY3VY1G7raJ8TwzNn1gCMd3/4ZE+1uiCaOwfM/5BkJsKDG6+G4t43r2I2arQP5WYTriztE3hMqs4AZ+nemMhgzAymejVo5S7Zt0PabAWLnHB98NfS0rKUt0Ub69DDCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750050173; c=relaxed/simple;
	bh=qiQ5GkUGjZ+q8vJ7NUB4slVIlr4qCdmz8gr1nrPjyRE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blmkfqYNkoP/C7/tnGkbKcMZqGCtH+qmMSsbJQ9YU3ploAOVMLSxnwEZUutp9D4ArQ5a6MJifLhVl/iY6zgJe7hKBWXD5wgwIniMEtPbqh9zDXkv1NWU2ZSowPTrwOiYBnWjl+TlYolNmdNQHYLDVFjI1WLCGgbwhdCvPoS6mJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fLrz6rNW; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gS6A9iabMJxCED/vqVAVQMOh8mDqN6iHmiXBBugmidEY0l1ufjHnZsmAEy+Oefo+qSok3bELWd0UhK6eQyIcvBXsY5m/np2XCCbz8eNLuabt5KYFZ6KzEklXlraC/iHtWOOl01OJ4U5bgAvdatm12U10Q4/06kyOPhC3X7rMjKOHQP1CXRYxRi3/+laZYSFZd5Tundi154ehwGqKky8ii/qcWLxP+XIQk9oLl6WVB0QsQFZjE4RoB8VfnLRs2W7K9T/JbJjFgnELSM0vzfaL7+qy41gQDEXhcFi5/vgonlbS404ReELB2PFMAK5ssyUIrV8puVN2gQJnqu8XYjWGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNyEDg/zLWkPXnZqMU+5O1XeM+QPexcOgKaAqNHBSaY=;
 b=WlY/bsz8LW+/t99hMFNcHTWIQdnA4yMQladGmkh59BVJoroNHTRIJ4woihJLAHw826caxYhw5HarlLinUACe33fY+IZybSo4DmzyCFaaEywh+kmXjDWkLFMGDAnY1RXNrzQLEUn+XnLEi1LR8/jBO36SdZS7xDMrtjw1L4arE95VSlR+m2U5PeOJ3UKD2dm71MrFFx/HgWno9RbPCk1EZTyAh3PnExfJkiJFn/hTldapF0U2DPliFDkooOZAsvNYcH94d3IRqAYUAEV3OcuBmfXxI2iyZbFly17p2EubYNNFLxm0c4tGPlWnhtx/AmWh0zZx8PSQ/rxGPN+NZLzCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=temperror action=none header.from=nvidia.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNyEDg/zLWkPXnZqMU+5O1XeM+QPexcOgKaAqNHBSaY=;
 b=fLrz6rNWPpRVq3LWXUE/k1RnJXrp1KCUdI08ENMChHsaK+Z3MPLsrYmT0B7jaxfSv0gKknxIg4ajiCPpkzHVgXCtfsxY2ct5XxTH4Okyb8dp44USH2ZHQP6N2NH3C9IT9EmZcXioIrR9M0wj+nqYgXr/WkRNSbj4q4/C4gal5zfWkIHumnnnXjtKSsYFoByeag1bGIQ4oUfww2H/SUCCs3/nC0+qXjoa9Z6geLaJjDD+ilWQpDAjAuhGZVUS550DY9Kp5VEY41xCtyJ7bj1paZOh7ygYoGPJNLy4xrB+sZqHpRCvekwq1xg3zrndeo/U/FtMqUuSMTaJ5Q/Xjs6ffA==
Received: from SA1P222CA0177.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::25)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Mon, 16 Jun
 2025 05:02:47 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::31) by SA1P222CA0177.outlook.office365.com
 (2603:10b6:806:3c4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.29 via Frontend Transport; Mon,
 16 Jun 2025 05:02:47 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 05:02:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 15 Jun
 2025 22:02:26 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 15 Jun 2025 22:02:26 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 15 Jun 2025 22:02:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <shuah@kernel.org>, <joao.m.martins@oracle.com>,
	<steven.sistare@oracle.com>, <iommu@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thomas.weissschuh@linutronix.de>
Subject: [PATCH rc 4/4] iommufd/selftest: Fix build warnings due to uninitialized mfd
Date: Sun, 15 Jun 2025 22:02:06 -0700
Message-ID: <be226e78fd581585c22c6c7f33c14bfe4a0c3ef4.1750049883.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750049883.git.nicolinc@nvidia.com>
References: <cover.1750049883.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ace109-f0d6-4f47-9b0c-08ddac930890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVdZY09XY05HaUNjS1NKWTlaVkJVQU1GMDZ4UWRQMUhFY1M3alpJb2gxRWFW?=
 =?utf-8?B?c2xrM0tBK1M0bjV6Qm5TVyt1eGUxckVZN20vMTRKYm1lSi9VVWxqSkMzcHNx?=
 =?utf-8?B?dUxsbE9aQXJyUE5La2pCek5PbzRpWFhRYkx6REszaXM3UUtzNnd4MkZ2b2Nz?=
 =?utf-8?B?Zk8xM25vaXdUQ210UGp4dTl4L3hjSXlXZXNqd3grNDZ6anBkT3BUY2xpcHBI?=
 =?utf-8?B?OXVGajJXalRPZVdBRGxhdjlHYWNrMEJwOVZ1V2FOV2c3VmRHS0pRdkIxV3A2?=
 =?utf-8?B?VVliVzVlZkVJeGI2R3pvVVRMaGdyc1c2UHR1cFNrVlFXR2pXMlhtL3dhTi9F?=
 =?utf-8?B?RW9kL1dyVUxsK214MzJSbE5XR1dJSjFiUW5od2dldGprTjJhdFhxL2JiYTFs?=
 =?utf-8?B?TzlwMnhiK2tSRUczSXVXSFZoWFBuNjNjOFZpNFM0N3FLazZMbXZwTThqaXdS?=
 =?utf-8?B?VnNqVC9OOVNldE5uWlpxdGZkZGNvaXFtUlZFWXZRblU4RWpYZENDeXZsV1RT?=
 =?utf-8?B?TE9aeWR0THRGQndWdjlscjVWU1BjbXFtTEgyMmEwOXlFVmJGdHBhYnNKd3hl?=
 =?utf-8?B?bEFtNW5lb1FGSFVnckxZdlBhK0l2V0pWMWZYaFB3WitTemFmMG4vbkFaMGVq?=
 =?utf-8?B?Mk5xVVJpOGRGTUMxeGY4eC9SWVJUd2xMVHlMcWxFMXE0Rzhtd093MXNkU3o0?=
 =?utf-8?B?ZEtiemNQbDJHYjN5T2dvcHJRS0kvUEFQcHN1UE9hNmlxTkd3Z2dRenNLZWNM?=
 =?utf-8?B?TG5ZRVRWR3pRMFd1Z056Lyt3VVRrV0IzbFM1WG05VmlHZGhsM3A3NE5KejJI?=
 =?utf-8?B?MDFzU2s4QnU3QXQ5SkU2N1k1dkVTODAvdXpqYUpXT3FVVTltVmhjUDkzdjE3?=
 =?utf-8?B?K1c2Slc5MEN6WUVJZVRQQytyMHdlUFcraGRZdmppUmJLaEFxN3dXcHA1U2VS?=
 =?utf-8?B?Qk5tNEIwdFhFVWdWTFJpTUgrcVNXS25pYlJGMmpiTXRMNEhXekFqUjhWazdY?=
 =?utf-8?B?WEdqekw4YTk4ajJidzdBeHhmOTl0akZEYi9sSDJPa2JweU9KcXNQcmwvd3cz?=
 =?utf-8?B?RStDeUU3Y2wwR0ZyNTlVZWJFRjVRNHNzQnRjRmh0OVBqMVNDK3pscTAwVHMr?=
 =?utf-8?B?UkVEYW1xTnU0K0c5RWIwVHRJMFdIM2NWZVpHSkJXNE9kZThINTYxclBJSlVL?=
 =?utf-8?B?djY3U3FNT0pxK1dEVk9DcHY0ZWgreXprS0tJQmdRc1FzaUpNNnJEZjg3LzZB?=
 =?utf-8?B?SS9ZUzM5ZFdobklQSmRoekxhVWw0TzBFR2dGbDVKM0N3cW1YODJyL0YzU1pQ?=
 =?utf-8?B?c1NSZ2l4cGdzKysyTUZjdlN5VWxFZTNlZ0VqZG9jTnFpKzZhVlE4Q1lwaDhm?=
 =?utf-8?B?YTNiSmtJdERpNTJqMlRpQTlxR0hKMjAvdTROSkpnNGlsVy9HVnRYb3h0VE5C?=
 =?utf-8?B?RVhCaGpEVEhYa2hHNUNTSS9NMiszYlQ3Y2EveHBOMDU0TnlpQXZId1pDQjdr?=
 =?utf-8?B?SmxwRTBzMmN1QUpOVnlNTnJIY2ZDK3dIZkM3ZGtFSXVFTlUvaHo1NHUrb0k0?=
 =?utf-8?B?Rmt5MTZUOEV3Y0hrNStZZ0ZmK3ZBZUs0Wk1DNTFhRzBvMzg0bTVENVE3L1BS?=
 =?utf-8?B?TGpCVlMySFpSYVM5dGNpRHdqd3hXa09nQ0IrK0ZaN09KMTRTMGhMbk9KSFJX?=
 =?utf-8?B?a0RVWVMrUU1wc2hLUkx1VWtIeWQwK3Z1eVYra2MyZnh6U3ZkN3MyUk9lTmtv?=
 =?utf-8?B?THRpVmU0S1BQS0hMTlNybFFqdlVmQXo4U1RxUzFLSEUwWUVPKzdQYnkvM21x?=
 =?utf-8?B?WXZucmNiNXJucFpsbVU5RkpsQjhPdkF0UTczdS8wMzZUMm9UWnFHSjNWOGk5?=
 =?utf-8?B?VFZtWjNub3J4QzNZVksrTXZjUytXVDhkd09FYzZqOU9yWWpnQi9RZDdaNDIz?=
 =?utf-8?B?aS95VDFMZlR3RC9aVTlrMDRUdWhxUlNjQVFPMGwwcUsxcmRGRmFMbEtFcmRE?=
 =?utf-8?B?ZWJXYXozTXgzbDN0azBUbTg3US91TktKN3dSd1NsQ1pPQTc1dE9lMDZYRnhQ?=
 =?utf-8?B?SlRmVVdEU1AveTlUeDdwTW5jUVdJcHZpTTcyZz09?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 05:02:45.8877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ace109-f0d6-4f47-9b0c-08ddac930890
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101

Commit 869c788909b9 ("selftests: harness: Stop using setjmp()/longjmp()")
changed the harness structure. For some unknown reason, two build warnings
occur to the iommufd selftest:

iommufd.c: In function ‘wrapper_iommufd_mock_domain_all_aligns’:
iommufd.c:1807:17: warning: ‘mfd’ may be used uninitialized in this function
 1807 |                 close(mfd);
      |                 ^~~~~~~~~~
iommufd.c:1767:13: note: ‘mfd’ was declared here
 1767 |         int mfd;
      |             ^~~
iommufd.c: In function ‘wrapper_iommufd_mock_domain_all_aligns_copy’:
iommufd.c:1870:17: warning: ‘mfd’ may be used uninitialized in this function
 1870 |                 close(mfd);
      |                 ^~~~~~~~~~
iommufd.c:1819:13: note: ‘mfd’ was declared here
 1819 |         int mfd;
      |             ^~~

All the mfd have been used in the variant->file path only, so it's likely
a false alarm.

FWIW, the commit mentioned above does not cause this, yet it might affect
gcc in a certain way that resulted in the warnings. It is also found that
ading a dummy setjmp (which doesn't make sense) could mute the warnings:
https://lore.kernel.org/all/aEi8DV+ReF3v3Rlf@nvidia.com/

The job of this selftest is to catch kernel bug, while such warnings will
unlikely disrupt its role. Mute the warning by force initializing the mfd
and add an ASSERT_GT().

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 393d95f88ad4..ca611ae5925f 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1749,13 +1749,15 @@ TEST_F(iommufd_mock_domain, all_aligns)
 	unsigned int end;
 	uint8_t *buf;
 	int prot = PROT_READ | PROT_WRITE;
-	int mfd;
+	int mfd = -1;
 
 	if (variant->file)
 		buf = memfd_mmap(buf_size, prot, MAP_SHARED, &mfd);
 	else
 		buf = mmap(0, buf_size, prot, self->mmap_flags, -1, 0);
 	ASSERT_NE(MAP_FAILED, buf);
+	if (variant->file)
+		ASSERT_GT(mfd, 0);
 	check_refs(buf, buf_size, 0);
 
 	/*
@@ -1801,13 +1803,15 @@ TEST_F(iommufd_mock_domain, all_aligns_copy)
 	unsigned int end;
 	uint8_t *buf;
 	int prot = PROT_READ | PROT_WRITE;
-	int mfd;
+	int mfd = -1;
 
 	if (variant->file)
 		buf = memfd_mmap(buf_size, prot, MAP_SHARED, &mfd);
 	else
 		buf = mmap(0, buf_size, prot, self->mmap_flags, -1, 0);
 	ASSERT_NE(MAP_FAILED, buf);
+	if (variant->file)
+		ASSERT_GT(mfd, 0);
 	check_refs(buf, buf_size, 0);
 
 	/*
-- 
2.43.0


