Return-Path: <linux-kselftest+bounces-26094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8573A2D513
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 10:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB6137A4F5F
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 09:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB5F1DDA0E;
	Sat,  8 Feb 2025 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YB79Cekl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4671AF0B6;
	Sat,  8 Feb 2025 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739005425; cv=fail; b=uEkToUx5C4UmK4Mls47+3CSSBe76tanvlXf74YZTRqVmy6keRuoYILW015mBT9OCl48c0AH8O/ubJAl1UzGgUhEFfgrTqD1FbaufgsydbQMkZ8F4nn3Vcsi5iPV6TZJ/AwaFvbrJJwUSy3RHUjgatAhVbOY3GAPUMEQeVxok2So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739005425; c=relaxed/simple;
	bh=tfK4keXP6Utitp47u6p0wIc2KYrP4j4XoE0qhPeKxgw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbjE+4WRRs8IzO4Ycuw5R8Cu0R5sdwyxdMNLZEsdyX08djAENYMUwq9rrxG3/rIgs4icjW9TcZXFcvldMnNIZ/BqAl9SaysgFt1Isyr1oQZSN78GIuBm5u0SXfo+dFOR9eePjtIP7HLZfPSWMoc8lJ833U7yD/vguOutoYi0FHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YB79Cekl; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSARF7Rv+/eyjOOsFYRcq12E89SeHwDJQM0xYfXpuYkEIPfo3b/fjIrfsvfqjCUhq8ZJpdQbHArnMWCjh7fxcEVlUgfIL2XLGOCL2GRJi3wlII/t0EfT3BmpN37QKtmt74kVTDd8EvgOsIwt9Rd6BUjcwnGTVAqsFtk+PHeSWN12UOxYFRVbRFIG1eKCnwhSLoZU+jWCPno/OH5D8BJvA592yOKTJvuhPOMb0c7oz6XFrrBSCthWq3W11UCl68W6AS5x5oZAKjdGtr7+VjJvZxkOX8rJiYpNquA/bFn8WSGMbnV0oJatZepKmtnTM3OIKwJy/PyjwPK2XQU7qtpcGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1wQ1OlxyUNC6t/+EFekUqCIAmqr4wF1LuLBv5UCmok=;
 b=XeSpmntnH4zAQG7IwhZGEGRrQvyP5Jwx2OdDbmem2Q7HdZRpyhCYAVYzBUCiiD54E5xF9OeJNMUeZ4D0BOoieApo3ywmuvt5HqncQSX9mOXrl3AX5i/OdWs5PoQLWc1MoCXOMVOGzp2EkWzzI6wYSLo9h2NMWSidKB/FRjGN4RwOwLmD4o/OcPUCWxJL1/7+mLUsjbSaXMy8ct9dpoSQdTP2nwI3XsPu8Iki4feMCUzYK4SC2SKi73dSpzyaJ9YmddKZdE0J37KBVwJUoOf3u4NH2CLP3odNe/ehmRwwb2dSZWAAaJsXMTny6tSYZposvzdrdGrA90jO68SzBTHJ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1wQ1OlxyUNC6t/+EFekUqCIAmqr4wF1LuLBv5UCmok=;
 b=YB79CeklMcrzTuDGjDPmiHtNZK4MuUHvEZADu4jVcYgP517V32kXZqGsk3seOlNgev2tWwgV/aGrAl3oP5ul4qKq68OqTPdFViV8vDL8G7Jz23m5pnn83GKut4qTdpr+1+tWdQHei4f9kUtsUMMRuPNwtia8sHvXaqYKcFZzjA/FTBk7d6iRI7fjcY9Tz6DH4kZQqLH/MfggARL7HshAock54OjF93rFNdwFm9wMyUCkrfksO1SBqEJtW3FVHj5uUpkKhi0JFxbEf3dKKcaGYFnFdlNyWV3s4zs686eduol4ZbEHbMSk3vLe70XxkarNCnDPfBhzvvj7Cnf8Tu/GPg==
Received: from DS7PR07CA0024.namprd07.prod.outlook.com (2603:10b6:5:3af::6) by
 PH7PR12MB7236.namprd12.prod.outlook.com (2603:10b6:510:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Sat, 8 Feb
 2025 09:03:38 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::bf) by DS7PR07CA0024.outlook.office365.com
 (2603:10b6:5:3af::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Sat,
 8 Feb 2025 09:03:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 09:03:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 8 Feb 2025
 01:03:22 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 8 Feb
 2025 01:03:22 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 8 Feb 2025 01:03:21 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v1 13/13] iommufd/selftest: Add coverage for IOMMU_OPTION_SW_MSI_START/SIZE
Date: Sat, 8 Feb 2025 01:02:46 -0800
Message-ID: <257ac74e767f29930aa47991224fab96f36c3899.1739005085.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739005085.git.nicolinc@nvidia.com>
References: <cover.1739005085.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|PH7PR12MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c58570-a574-4a3b-0efa-08dd481f79ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZsvpKbGLo0OursV4CLkUkdJL5llEiy/LwZXnOFpvLYzXG8hsYOGXz/9CzgxP?=
 =?us-ascii?Q?3+0yqG7IdoSieCoKb5TB0U3ngCCnBkJ6MHxtBVAE/5tq+D3ceuTNgHXGNkAn?=
 =?us-ascii?Q?gIBnAErdQP3zlla3SgabemgHkwik9XSu/Fdwk50xA+9YqY/Tmz0AGa9yIjkM?=
 =?us-ascii?Q?xaA+vrZu82fOgCyh/Er2CgspH6o3vCpxdyDeHwXaI2ZUNFmF+xi3L4tMaOMH?=
 =?us-ascii?Q?+fCGCDle3yJl838ADe7Zi4Iioj9qTNPYG7tGk8g77VjJQwXRgbTHIvwK7Kuk?=
 =?us-ascii?Q?DekYyBoUzu8Ffg9RSRExh6KQYsBQv51/PwVkzBUNAYAIz+l2NnFOUm2sluMf?=
 =?us-ascii?Q?x82MVkU9rUPhuCX0M3EF8NQxwqLiQl9701CRg3UzKi7v5JIH8pE9p2rZsBAd?=
 =?us-ascii?Q?OVa+VBjnJ1uDRXOj1nuj0ypVopVQni1p6OJ4fh3BLMaMF6ng7YiIBjU7+sTZ?=
 =?us-ascii?Q?/7q36ZBYnXunQhvS3asZLtI+GY1x1a8mJUjTE27UdCdOGrj++CZYpzkq1dax?=
 =?us-ascii?Q?HrnpMO63HCkXVyK/9Nqp7qfgDvtZ7xTzuYzxi6zGo1NNAuZLqVO0tFnH3Byc?=
 =?us-ascii?Q?AeTiMRPS5fhdj1DZVFc2rW4by5Cr7ULrNOA/CqrQ4VeDN02IWfPyDikIixxD?=
 =?us-ascii?Q?e3jJcjtdhP+VYi9YNu7focSKOg3HMflRUuXdfTumInm5RRt1QgujSdrh2N2A?=
 =?us-ascii?Q?TQAy7PGYlunQ8FMxUlc2RhUHMvZ531F3FRPj5i4FuNz2pUDODQz6ofn9W/k2?=
 =?us-ascii?Q?U4OZlS9v3lBBXpccNAq0WdtWeNuqm+c//JLShiT0gCrfQ19WPlpDSRBAls6T?=
 =?us-ascii?Q?oMdb6b4pFYVeUwd0OfAKmXsBps+I6bl5w08+0Bqmg0QMUMUr/tmAow3PDxT0?=
 =?us-ascii?Q?Xqy2Hw2VSY2rOS7x+IdlKDM08IEupfTkn4GNiKlXkj5UtF0MG2prWewAgJSw?=
 =?us-ascii?Q?w+jUjHVvvTO69lwPjGAaUBJXc8kQ7tLlDufkvst1hFAo3mxCQcJKsEeJ+ANG?=
 =?us-ascii?Q?0gb2Ux1hWvpBxbMj2RKY/2hDJpzcDVGWOcYIcloxNwxbUlhuWwdQE0kpS7ol?=
 =?us-ascii?Q?2EGhgklPXNWACSwj+i4LawYi3P5CxFy/dp0wiXSMTK2OnFCMSKFy+BMXH8g3?=
 =?us-ascii?Q?N5K1Zr6f+PnX9o0JUah6KGMcwD6zLElVhlbDGXqzUm6YhXXP1BxGWOhTZBcX?=
 =?us-ascii?Q?DXk5JuAmJjKXZeDVuGotXdjPj/vgW2nwtE4Q6YD0ugtM9DRQ0IQYuqAaNrXN?=
 =?us-ascii?Q?JEIcM1AcHksRgPPHLBGQtP+edLkPn3xdi7oOxBcaDV4DiUQzHhhB5dnQ4JRd?=
 =?us-ascii?Q?Y/3hlffOexyDAOPp6imf3tqfxJmzHcwhKq+9K9QRozizzvQbQNO3AvXdBNRc?=
 =?us-ascii?Q?mm/cliO5jkRqnl3+PRK1UFq/7KKs08OYO7Wx+8OpLNih1x0PNCF2LqL5bKZW?=
 =?us-ascii?Q?7M7lbXXmetgB8SzCHdjKjVRgI5x5bYOuzvQjqV4SzFTp7URwUTHJejSf9PI3?=
 =?us-ascii?Q?/SrKmsi6E0eCZR4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 09:03:38.1640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c58570-a574-4a3b-0efa-08dd481f79ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7236

Also add fail_nth coverage too.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 97 +++++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        | 21 ++++
 2 files changed, 118 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index a1b2b657999d..db7dfc5ae56a 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -334,6 +334,103 @@ TEST_F(change_process, basic)
 	ASSERT_EQ(child, waitpid(child, NULL, 0));
 }
 
+FIXTURE(iommufd_sw_msi)
+{
+	int fd;
+	uint32_t ioas_id;
+	uint32_t idev_id[2];
+};
+
+FIXTURE_SETUP(iommufd_sw_msi)
+{
+	self->fd = open("/dev/iommu", O_RDWR);
+	ASSERT_NE(-1, self->fd);
+
+	test_ioctl_ioas_alloc(&self->ioas_id);
+	test_cmd_mock_domain(self->ioas_id, NULL, NULL, &self->idev_id[0]);
+	test_cmd_mock_domain_flags(self->ioas_id, MOCK_FLAGS_DEVICE_NO_ATTACH,
+				   NULL, NULL, &self->idev_id[1]);
+}
+
+FIXTURE_TEARDOWN(iommufd_sw_msi)
+{
+	teardown_iommufd(self->fd, _metadata);
+}
+
+TEST_F(iommufd_sw_msi, basic)
+{
+	struct iommu_option cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_OPTION_OP_SET,
+	};
+
+	/* Negative case: object_id must be a device id */
+	cmd.object_id = self->ioas_id;
+	cmd.option_id = IOMMU_OPTION_SW_MSI_START;
+	cmd.val64 = 0x70000000;
+	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	cmd.object_id = 0;
+	cmd.option_id = IOMMU_OPTION_SW_MSI_SIZE;
+	cmd.val64 = 2;
+	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	/* Negative case: device must not be attached already */
+	if (self->idev_id[0]) {
+		cmd.object_id = self->idev_id[0];
+		cmd.option_id = IOMMU_OPTION_SW_MSI_START;
+		cmd.val64 = 0x70000000;
+		EXPECT_ERRNO(EBUSY, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	}
+
+	/* Device attached to nothing */
+	if (self->idev_id[1]) {
+		/* Negative case: alignment failures */
+		cmd.object_id = self->idev_id[1];
+		cmd.option_id = IOMMU_OPTION_SW_MSI_START;
+		cmd.val64 = 0x7fffffff;
+		EXPECT_ERRNO(EINVAL, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		cmd.val64 = 0x7fffff00;
+		EXPECT_ERRNO(EINVAL, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		cmd.val64 = 0x7fff0000;
+		EXPECT_ERRNO(EINVAL, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+		/* Negative case: overlap against [0x80000000, 0x80ffffff] */
+		cmd.option_id = IOMMU_OPTION_SW_MSI_START;
+		cmd.val64 = 0x80000000;
+		EXPECT_ERRNO(EADDRINUSE, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		cmd.val64 = 0x80400000;
+		EXPECT_ERRNO(EADDRINUSE, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		cmd.val64 = 0x80800000;
+		EXPECT_ERRNO(EADDRINUSE, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		cmd.val64 = 0x80c00000;
+		EXPECT_ERRNO(EADDRINUSE, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		/* Though an address that starts 1MB below will be okay ... */
+		cmd.val64 = 0x7ff00000;
+		ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		/* ... but not with a 2MB size */
+		cmd.option_id = IOMMU_OPTION_SW_MSI_SIZE;
+		cmd.val64 = 2;
+		EXPECT_ERRNO(EADDRINUSE, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+		/* Set a safe 2MB window */
+		cmd.option_id = IOMMU_OPTION_SW_MSI_START;
+		cmd.val64 = 0x70000000;
+		ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		cmd.option_id = IOMMU_OPTION_SW_MSI_SIZE;
+		cmd.val64 = 2;
+		ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+		/* Read them back to verify */
+		cmd.op = IOMMU_OPTION_OP_GET;
+		cmd.option_id = IOMMU_OPTION_SW_MSI_START;
+		ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		ASSERT_EQ(cmd.val64, 0x70000000);
+		cmd.option_id = IOMMU_OPTION_SW_MSI_SIZE;
+		ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+		ASSERT_EQ(cmd.val64, 2);
+	}
+}
+
 FIXTURE(iommufd_ioas)
 {
 	int fd;
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 64b1f8e1b0cf..be0d7735dfeb 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -615,6 +615,10 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 /* device.c */
 TEST_FAIL_NTH(basic_fail_nth, device)
 {
+	struct iommu_option cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_OPTION_OP_SET,
+	};
 	struct iommu_hwpt_selftest data = {
 		.iotlb = IOMMU_TEST_IOTLB_DEFAULT,
 	};
@@ -624,6 +628,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	uint32_t ioas_id;
 	uint32_t ioas_id2;
 	uint32_t stdev_id;
+	uint32_t idev_id2;
 	uint32_t idev_id;
 	uint32_t hwpt_id;
 	uint32_t viommu_id;
@@ -692,6 +697,22 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 				 IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data)))
 		return -1;
 
+	if (_test_cmd_mock_domain_flags(self->fd, ioas_id,
+					MOCK_FLAGS_DEVICE_NO_ATTACH, NULL, NULL,
+					&idev_id2))
+		return -1;
+
+	cmd.object_id = idev_id2;
+	cmd.option_id = IOMMU_OPTION_SW_MSI_START;
+	cmd.val64 = 0x70000000;
+	if (ioctl(self->fd, IOMMU_OPTION, &cmd))
+		return -1;
+
+	cmd.option_id = IOMMU_OPTION_SW_MSI_SIZE;
+	cmd.val64 = 2;
+	if (ioctl(self->fd, IOMMU_OPTION, &cmd))
+		return -1;
+
 	return 0;
 }
 
-- 
2.43.0


