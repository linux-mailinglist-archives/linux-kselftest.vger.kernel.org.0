Return-Path: <linux-kselftest+bounces-31684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CA2A9D7E8
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 08:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 741267B9B3B
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 06:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCE1201113;
	Sat, 26 Apr 2025 05:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rrZGQuj4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE7E2010E3;
	Sat, 26 Apr 2025 05:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647169; cv=fail; b=jIqDF6Y/gFjxGQzg4rTTADHjBXg7ydrn6nCMPmB0eDLsjCDez7MiaJ7kR1JMsxqXhUTG+rJxrHA8+tuz1kEZZcHejr3fUVhfaM+m0ifaWsX708xRZcJTFcnCsRawxyDNlaW8CDWkcM3dtzyY56FWU6KoT0qG5HhprBLeLTJTMTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647169; c=relaxed/simple;
	bh=kyzdP//XUxGteeuG//Xqr0eH+jZlBo7lWlVR/Xp4F38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDsnGM1H7rwJDODExtzRBI/hE03b34KLZaGKH+1+SqtbaQMMgzRw5k6AA6nX6HAZ/J+QZvgoLxjXXDa68Q6b8iRZ/ocP/oGBUMKwOxdU/JZuygnTsAJZPXMcA9MnSzBSAN2Gd7onMlsSyx1UrkEVK9dnqGrRO5/gMnEGAKr7ID0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rrZGQuj4; arc=fail smtp.client-ip=40.107.95.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKttJd3TzkM6wHnNfrfIgfo6kg9MIkt7wGpVX15kygnUy8Qh4zSFWUFG+lXk2+Q1UdlBWVCiGisaE9W1Li+iUcshBV9YPRI6Ix6HzzmL6YtOeX9OA79Co1BKrvYtiW34TSnn6GlceeiT/f1TIKr/F53s5Mgtk53FkNmpEpwgffUXDFIrIdVkjhbDtARM3y5hAGL8lYXL4Zk7BzK2VBWk/1yZBRadqNCgDqkN2HubZkIRAefXAYU+vJvG8R3ki5IE41uUVCF40ysXFf+EyVgqqt7/g+YZYmAN9IxPv1N8YprH87LljoiXcVoGhPqzBJP7bHXubko/tHzETMeXk8+ndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMotLv5mCRRcILbMoyCOS4Lz+EVDsWpQCqY1cMeoWLY=;
 b=QHp+CEsYjnhKjfbNPeSAK7T53d3NJvTo84R3gSGqIlWDZYH+klYE+AvE2iOqc4u5rfdX8gcQx1J6pplzzJOcA1lYybesWthmzkgv8cjRxaEfgF+OWqaGWesNe+cIfRryLE7D/1Xkrhxu5rf87iMlL2u6mWqGVt0/qQsiAOgQgXxDR27I72tCVPKsTzW6zZOr04bT4a3/B07/It+24ZrX2e327SViR6Ok1wFe8q99mCSF7Hj95isRY29ggl/9Cdq7djNRud6xiXvCH6EvcY+KGnFRE/uHsjT374PdcBifrZDCHy2wTHIAa919z4XOGKe5Is8DQ8gZAaYoFgz3p9zqJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMotLv5mCRRcILbMoyCOS4Lz+EVDsWpQCqY1cMeoWLY=;
 b=rrZGQuj4KZNkbvVpn/5sge8flBbWHXYiiXFswAzVpI+ivIvP5irl2grxINYiHlr366PemUmVgCgUnYctLCX735e0JUXOwrUhhn1QiplxCl0NVNBiSzvRjRRdM09Vxhc3MZwvVsyGZNfR//1zSNjNz4h723y5c79gkiY+kvyA833SyAHCNKViwguuuB+a1SO0LtAv82WpOSA6eXFn8IcxGZMBsIpkZ3n/HuxXACFNB5jp5rRif+eRcrzpZ8VC656rc8BNgYs4/ZUA/+lZ/9ahMf7cWl6CjgXtdl5m1DcP5uIrzX1e2o/UlfJ0SmHsJBAN4C6mkYa7pa6yvvm/4qQymw==
Received: from MW4PR03CA0127.namprd03.prod.outlook.com (2603:10b6:303:8c::12)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Sat, 26 Apr
 2025 05:59:22 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::75) by MW4PR03CA0127.outlook.office365.com
 (2603:10b6:303:8c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Sat,
 26 Apr 2025 05:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 26 Apr 2025 05:59:21 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 22:59:10 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 22:59:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Apr 2025 22:59:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v2 12/22] iommufd/selftest: Add coverage for IOMMUFD_CMD_VCMDQ_ALLOC
Date: Fri, 25 Apr 2025 22:58:07 -0700
Message-ID: <463a089c0d29b97be77f33fac6ed19273e23ab1d.1745646960.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745646960.git.nicolinc@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: cfdd2741-10d4-43a6-59dd-08dd84877d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xGaq20WXJxEqCnPuS64Qzcyd0HIzYJtcsj3aUEqgHcHyFXBP4qD1YIzsiTXs?=
 =?us-ascii?Q?eXALZ3c44u19fMevEpv3zxe8p7XO9wojVGtjnV1Jt6uN6KPkPHMmE6tTQqsp?=
 =?us-ascii?Q?90OKMPqTDXR4lZ6e40YjJUhfd9mfLuGjxP4VjDNzqWWTiFxdiBe7MRd8Ok0H?=
 =?us-ascii?Q?IOHLAEM5z7R8b1UIgxSPmxD0yKeYZonUbVeqrxb0bddDo0RC5Yjf7CtZ1P/e?=
 =?us-ascii?Q?zIH+py9jHz0aReXQO9eU9CluklNkFoLwzJgRyI/AT7WskUfChvFwl56keUbt?=
 =?us-ascii?Q?GRishbua67z9iVlRyxRSf/7LFYKFmG5VbEx3aBV2yspKP1MWwyXkyVSZCR53?=
 =?us-ascii?Q?4DR9Uih76eypUSO7WWFHiwKwsjFkPhCZsCypjYNTCgNJmpsBiAGKFxqfJwDM?=
 =?us-ascii?Q?oXRwgWhnlsW1RGLHmvpo0D47SAEgzvK1qrbP6+9Z9xNRgkvHcldPH0foi43J?=
 =?us-ascii?Q?rf3T8nTZALQ/nCDD4pQ/FnaqvFe54UqMSUzjChdfqlAy0L5KS0yc7rB4z2uR?=
 =?us-ascii?Q?L62nxRfai4PxSRNCAZ8QaqAcdmd4gD9410zbILbOt0AitYtUa7o2Y121bDZg?=
 =?us-ascii?Q?9ZZMUBKysfTJwXdgryMt0Kk4L6WdWn5q+9n5YbUknR3wNDMEOUeQ7ZxfLBaY?=
 =?us-ascii?Q?xWuHWIoTzn8sEujWuXx3TR17wnWqFoMJYSS1Jm6yCbSooDiZqGg03MOnySht?=
 =?us-ascii?Q?Fos7mkC5bIKSvHM3BWZEWBfK4jRkWpTqtGmCKYK3WzhXqbTS5/RXTEchehPs?=
 =?us-ascii?Q?1SdGZ8uuw+QGqf36wbVAGEudVBahs26npgoJFeAgVAAPnHGIBCkvWnsGFv9n?=
 =?us-ascii?Q?k7owMLVnnBhfef6tTDRp6uTg7N6J2njB+DAVZPGdLoLBLhTVjCMspd0aPnfh?=
 =?us-ascii?Q?WLYxB7tugDtxaiAiWoD/R5JF83sFZFGSPCUCFt5MpEQWcvccN1EzspA8VqG8?=
 =?us-ascii?Q?qKRLbE+N8q3dChl4NLmaLpby+lzvj4hTooLfQeP9DySHpThLpfV+VHLXIhnm?=
 =?us-ascii?Q?lmwTLAYyY6Lv4FBiKVqngKwBWW9DmAsCjV9UtxSC0VslpgrqaLpiesTmOKGv?=
 =?us-ascii?Q?QuBIX6XV3Qe23xPAWukqDGeNyj8/HhyKw+iGtJMzbd8vuwMvt5gRG6lDZPdl?=
 =?us-ascii?Q?4YK0orcKpFh871NqYTRwqxTL97MtW9ig64HxRFaWkrJc43HESOEN8UF5lCYj?=
 =?us-ascii?Q?W4ubR4Z2JcY2/pepWGVNWeOCKZYa1sP0mZ7VjGLeUlanmiP7z/ixIuq1nEiT?=
 =?us-ascii?Q?E9iLIVHoSp9puXdX9bqTjfWCsXJKgRbw0pvBqKxlMjfx+GvULQM5GHOXeyUJ?=
 =?us-ascii?Q?VrxH2h0pZgJN1fMk08HGQK1r4CAHCSWLeOY3ANSuwG0J+3cxYHE/Wh32DdVJ?=
 =?us-ascii?Q?ICPvNv2hLHuK9gpOgGZh4VVawxKcUa07+zsACNd/HuNh5Q/V05ifrpTEboYJ?=
 =?us-ascii?Q?9+KBgzxcAtqjn1YP2DbovTGhP5efteaxAA5NH3AbRkeaxCifBC69umSq6bxU?=
 =?us-ascii?Q?kj+GbNAzwYgif5IZUxF45Po+ZRzzz+HgvSXI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 05:59:21.5628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdd2741-10d4-43a6-59dd-08dd84877d79
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932

Some simple tests for IOMMUFD_CMD_VCMDQ_ALLOC infrastructure covering the
new iommufd_vcmdq_depend/undepend() helpers.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  3 +
 tools/testing/selftests/iommu/iommufd_utils.h | 30 +++++++++
 drivers/iommu/iommufd/selftest.c              | 67 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 59 ++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  6 ++
 5 files changed, 165 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index fbf9ecb35a13..a0831d78fef1 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -265,4 +265,7 @@ struct iommu_viommu_event_selftest {
 	__u32 virt_id;
 };
 
+#define IOMMU_VCMDQ_TYPE_SELFTEST 0xdeadbeef
+#define IOMMU_TEST_VCMDQ_MAX 2
+
 #endif
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index a5d4cbd089ba..d6d8fedf2226 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -956,6 +956,36 @@ static int _test_cmd_vdevice_alloc(int fd, __u32 viommu_id, __u32 idev_id,
 		     _test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id,   \
 					     virt_id, vdev_id))
 
+static int _test_cmd_vcmdq_alloc(int fd, __u32 viommu_id, __u32 type, __u32 idx,
+				 __u64 addr, __u64 length, __u32 *vcmdq_id)
+{
+	struct iommu_vcmdq_alloc cmd = {
+		.size = sizeof(cmd),
+		.viommu_id = viommu_id,
+		.type = type,
+		.index = idx,
+		.addr = addr,
+		.length = length,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_VCMDQ_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	if (vcmdq_id)
+		*vcmdq_id = cmd.out_vcmdq_id;
+	return 0;
+}
+
+#define test_cmd_vcmdq_alloc(viommu_id, type, idx, addr, len, vcmdq_id)    \
+	ASSERT_EQ(0, _test_cmd_vcmdq_alloc(self->fd, viommu_id, type, idx, \
+					   addr, len, vcmdq_id))
+#define test_err_vcmdq_alloc(_errno, viommu_id, type, idx, addr, len,      \
+			     vcmdq_id)                                     \
+	EXPECT_ERRNO(_errno,                                               \
+		     _test_cmd_vcmdq_alloc(self->fd, viommu_id, type, idx, \
+					   addr, len, vcmdq_id))
+
 static int _test_cmd_veventq_alloc(int fd, __u32 viommu_id, __u32 type,
 				   __u32 *veventq_id, __u32 *veventq_fd)
 {
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index b04bd2fbc53d..d6cc5b78821b 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -148,6 +148,7 @@ to_mock_nested(struct iommu_domain *domain)
 struct mock_viommu {
 	struct iommufd_viommu core;
 	struct mock_iommu_domain *s2_parent;
+	struct mock_vcmdq *mock_vcmdq[IOMMU_TEST_VCMDQ_MAX];
 };
 
 static inline struct mock_viommu *to_mock_viommu(struct iommufd_viommu *viommu)
@@ -155,6 +156,18 @@ static inline struct mock_viommu *to_mock_viommu(struct iommufd_viommu *viommu)
 	return container_of(viommu, struct mock_viommu, core);
 }
 
+struct mock_vcmdq {
+	struct iommufd_vcmdq core;
+	struct mock_viommu *mock_viommu;
+	struct mock_vcmdq *prev;
+	u16 index;
+};
+
+static inline struct mock_vcmdq *to_mock_vcmdq(struct iommufd_vcmdq *vcmdq)
+{
+	return container_of(vcmdq, struct mock_vcmdq, core);
+}
+
 enum selftest_obj_type {
 	TYPE_IDEV,
 };
@@ -727,10 +740,64 @@ static int mock_viommu_cache_invalidate(struct iommufd_viommu *viommu,
 	return rc;
 }
 
+/* Test iommufd_vcmdq_depend/_undepend() */
+static struct iommufd_vcmdq *
+mock_vcmdq_alloc(struct iommufd_viommu *viommu, unsigned int type, u32 index,
+		 dma_addr_t addr, size_t length)
+{
+	struct mock_viommu *mock_viommu = to_mock_viommu(viommu);
+	struct mock_vcmdq *mock_vcmdq, *prev = 0;
+	int rc;
+
+	if (type != IOMMU_VCMDQ_TYPE_SELFTEST)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (index >= IOMMU_TEST_VCMDQ_MAX)
+		return ERR_PTR(-EINVAL);
+	if (mock_viommu->mock_vcmdq[index])
+		return ERR_PTR(-EEXIST);
+	if (index) {
+		prev = mock_viommu->mock_vcmdq[index - 1];
+		if (!prev)
+			return ERR_PTR(-EIO);
+	}
+
+	mock_vcmdq = iommufd_vcmdq_alloc(viommu, struct mock_vcmdq, core);
+	if (IS_ERR(mock_vcmdq))
+		return ERR_CAST(mock_vcmdq);
+
+	if (prev) {
+		rc = iommufd_vcmdq_depend(mock_vcmdq, prev, core);
+		if (rc)
+			goto free_vcmdq;
+	}
+	mock_vcmdq->prev = prev;
+	mock_vcmdq->mock_viommu = mock_viommu;
+	mock_viommu->mock_vcmdq[index] = mock_vcmdq;
+
+	return &mock_vcmdq->core;
+free_vcmdq:
+	iommufd_struct_destroy(viommu->ictx, mock_vcmdq, core);
+	return ERR_PTR(rc);
+}
+
+static void mock_vcmdq_destroy(struct iommufd_vcmdq *vcmdq)
+{
+	struct mock_vcmdq *mock_vcmdq = to_mock_vcmdq(vcmdq);
+	struct mock_viommu *mock_viommu = mock_vcmdq->mock_viommu;
+
+	mock_viommu->mock_vcmdq[mock_vcmdq->index] = NULL;
+	if (mock_vcmdq->prev)
+		iommufd_vcmdq_undepend(mock_vcmdq, mock_vcmdq->prev, core);
+
+	/* iommufd core frees mock_vcmdq and vcmdq */
+}
+
 static struct iommufd_viommu_ops mock_viommu_ops = {
 	.destroy = mock_viommu_destroy,
 	.alloc_domain_nested = mock_viommu_alloc_domain_nested,
 	.cache_invalidate = mock_viommu_cache_invalidate,
+	.vcmdq_alloc = mock_vcmdq_alloc,
+	.vcmdq_destroy = mock_vcmdq_destroy,
 };
 
 static struct iommufd_viommu *
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 8ebbb7fda02d..7c464f6eb37b 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -3031,6 +3031,65 @@ TEST_F(iommufd_viommu, vdevice_cache)
 	}
 }
 
+TEST_F(iommufd_viommu, vcmdq)
+{
+	uint32_t viommu_id = self->viommu_id;
+	__u64 iova = MOCK_APERTURE_START;
+	uint32_t vcmdq_id[2];
+
+	if (viommu_id) {
+		/* Fail IOMMU_VCMDQ_TYPE_DEFAULT */
+		test_err_vcmdq_alloc(EOPNOTSUPP, viommu_id,
+				     IOMMU_VCMDQ_TYPE_DEFAULT, 0, iova,
+				     PAGE_SIZE, &vcmdq_id[0]);
+		/* Fail queue addr and length */
+		test_err_vcmdq_alloc(EINVAL, viommu_id,
+				     IOMMU_VCMDQ_TYPE_SELFTEST, 0, 0, PAGE_SIZE,
+				     &vcmdq_id[0]);
+		test_err_vcmdq_alloc(EINVAL, viommu_id,
+				     IOMMU_VCMDQ_TYPE_SELFTEST, 0, iova, 0,
+				     &vcmdq_id[0]);
+		test_err_vcmdq_alloc(EOVERFLOW, viommu_id,
+				     IOMMU_VCMDQ_TYPE_SELFTEST, 0, ~(uint64_t)0,
+				     PAGE_SIZE, &vcmdq_id[0]);
+		/* Fail missing iova */
+		test_err_vcmdq_alloc(ENXIO, viommu_id,
+				     IOMMU_VCMDQ_TYPE_SELFTEST, 0, iova,
+				     PAGE_SIZE, &vcmdq_id[0]);
+
+		/* Map iova */
+		test_ioctl_ioas_map(buffer, PAGE_SIZE, &iova);
+
+		/* Fail index=1 and =MAX; must start from index=0 */
+		test_err_vcmdq_alloc(EIO, viommu_id,
+				     IOMMU_VCMDQ_TYPE_SELFTEST, 1, iova,
+				     PAGE_SIZE, &vcmdq_id[0]);
+		test_err_vcmdq_alloc(EINVAL, viommu_id,
+				     IOMMU_VCMDQ_TYPE_SELFTEST,
+				     IOMMU_TEST_VCMDQ_MAX, iova, PAGE_SIZE,
+				     &vcmdq_id[0]);
+
+		/* Allocate index=0 */
+		test_cmd_vcmdq_alloc(viommu_id, IOMMU_VCMDQ_TYPE_SELFTEST, 0,
+				     iova, PAGE_SIZE, &vcmdq_id[0]);
+		/* Fail duplicate */
+		test_err_vcmdq_alloc(EEXIST, viommu_id,
+				     IOMMU_VCMDQ_TYPE_SELFTEST, 0,
+				     iova, PAGE_SIZE, &vcmdq_id[0]);
+
+		/* Allocate index=1 */
+		test_cmd_vcmdq_alloc(viommu_id, IOMMU_VCMDQ_TYPE_SELFTEST, 1,
+				     iova, PAGE_SIZE, &vcmdq_id[1]);
+		/* Fail to destroy, due to dependency */
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, vcmdq_id[0]));
+
+		/* Destroy in descending order */
+		test_ioctl_destroy(vcmdq_id[1]);
+		test_ioctl_destroy(vcmdq_id[0]);
+	}
+}
+
 FIXTURE(iommufd_device_pasid)
 {
 	int fd;
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index f7ccf1822108..ffad3f2875bd 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -634,6 +634,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	uint32_t idev_id;
 	uint32_t hwpt_id;
 	uint32_t viommu_id;
+	uint32_t vcmdq_id;
 	uint32_t vdev_id;
 	__u64 iova;
 
@@ -696,6 +697,11 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	if (_test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id, 0, &vdev_id))
 		return -1;
 
+	if (_test_cmd_vcmdq_alloc(self->fd, viommu_id,
+				  IOMMU_VCMDQ_TYPE_SELFTEST, 0, iova, PAGE_SIZE,
+				  &vcmdq_id))
+		return -1;
+
 	if (_test_ioctl_fault_alloc(self->fd, &fault_id, &fault_fd))
 		return -1;
 	close(fault_fd);
-- 
2.43.0


