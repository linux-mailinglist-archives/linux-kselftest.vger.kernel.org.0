Return-Path: <linux-kselftest+bounces-22789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AF99E2ECE
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 23:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4AF1614FC
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 22:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D9520C023;
	Tue,  3 Dec 2024 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EPe9B0UM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B620B7E3;
	Tue,  3 Dec 2024 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263869; cv=fail; b=UogaQf+Hr7G/7DPijTqOzLJZmdyOs6gU0Oz9vwWKX3Gr91MCxdboWYQNcMwlQIPTxZiwOd1Ag1/pAozOvTYrKD0etqdsW38l2AFcZA/76Q9+W03drArd+Iyff5VRChEhR0FfThj+lFksCpvGgX4rmsQRNgCVYo8GPHoyyAu4bJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263869; c=relaxed/simple;
	bh=1hlT0kSUhwJMKbMRzE23lybS5jktDbtEiCMbJFEdKhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NpNM82VU1u2HBGWSmfIqi9a8MzEjit1yKnjFZMuUMQZwIc6YY3Po/Vuqnlg3sfN3wLw56pSPUsKLVoutEohS0QlZrr3VbyITgnVWuV00BMM//sAOke3qmLQOIRkriimUl+K800oSTWUmH27g5W/m24r7CenQPvRVAaN+ylFbl4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EPe9B0UM; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lo3jqJwBufCZL6o0FE62TSfSkoT6E20LB9aGrdRHxxWnd2+MKxuWCywQ2z7d5OoXwQ2L3pf1x3zR8SW4mYmEsw00VMYYdFuHV+LlVTbqcjUk8yHkKuIdDd8dfP18jt0Uw5Meh4T1qNNH8/QYWkVZ1zRX8iu6GgxsL7HAvdomyFvpwCpEuJHVG7qFkAegFZs0cjqjEsuP1Ot31sBEBKboMw0iik0UxVMni1twbC2f+1wlyBU2OAvoyo/oadcnTj3fyi8zng414bcD89UA/y7bgfFB67aIfLEOvfZhaPmfNvnHdysmrwvURe6eP/1L8TTyKxVNcb1PPab1j4ftWOQ7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NCGCZqr17sVj2upoM7Gwc0ihyUUa8f5uRYg1Aproo8=;
 b=v2QIXLTjco2/N6cyxeYlsinxh9ANfzuqyRQeQQFKxdm8FL1pYGU9hzdHZywaIj134uLViMsMaEwbJuEnhBxug9nto4w3/vyzBIm9IDuqkvm3D7AUxCCDN0OIeewLTKhQJ0vJj647VHw3noL5qrZBwvpUHKtAj8MZO0xJ+ocQyu0n8LSTuVIa9fURyXjl+rUdtSblVVoibog6Ro+SfAZu1nJN6YtO8/zP2s1kSwuKhGBjGPTgmH2VnvQVv1ZoOJP1gs53LdaXwM851RSlxFYLzKM+KZI8ML/7qnab0xPeuBkeVqf/MOtL+trnJZqQjgsJHO2RjbMlFNPQ/v+mDl9hgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NCGCZqr17sVj2upoM7Gwc0ihyUUa8f5uRYg1Aproo8=;
 b=EPe9B0UMCnqA/Cd3HNhV6cBQkFZZBrVUzJSSUTsDBPYkXUN9qiwKwnHYugxRxnVqqno2wE/nlypBApvpHpDMVIhY7J7r1Y653CiA43twclLRP44kuFzMO5vlT9q5Zy+jPBZ2kiiJI40Theyzhek0no1lUtpmXBVgtasOlWwQJyFgAtlf463tfvkrdZIYXUvC7qsYeLlHAvQ/WxnqyiecCushcM07eE6E7QuwTTTfanrv3xT1F6TchdKilfwmi+bPtw0SHJhbOZJIOebPcyoEj7mlKG/se8hwU/PZRcx+fDD6PXOJ/iEpx2mTnTLkCItH8ugR67qjMUcPsCgTwk6BeQ==
Received: from SJ0PR13CA0044.namprd13.prod.outlook.com (2603:10b6:a03:2c2::19)
 by DM3PR12MB9286.namprd12.prod.outlook.com (2603:10b6:8:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 22:11:03 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::5b) by SJ0PR13CA0044.outlook.office365.com
 (2603:10b6:a03:2c2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.8 via Frontend Transport; Tue, 3
 Dec 2024 22:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 22:11:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 14:10:45 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 14:10:45 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 14:10:44 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 09/13] iommufd/selftest: Add IOMMU_TEST_OP_TRIGGER_VIRQ for vIRQ coverage
Date: Tue, 3 Dec 2024 14:10:14 -0800
Message-ID: <7993411d7634d6bf5e7da4459ca4ee540f59188a.1733263737.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733263737.git.nicolinc@nvidia.com>
References: <cover.1733263737.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DM3PR12MB9286:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c6a2d5-dfa6-4e46-0ecf-08dd13e75ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+D23Hh75keIEiJHAMbFaw1W44unuDMPoRo9gE0o5BP/o8j/Nuy84yZ8pSWe3?=
 =?us-ascii?Q?AsfKf5psCeVkH39lp/Rf9I/sa4n7tbIeovIIO6h6tfyP4Px3WwKfoQs8x+NR?=
 =?us-ascii?Q?T4gXy8THUblFevOMkzokOxN2DDcRxN+pHySDhbZlUG+wd7NuxLy/DkmW35j4?=
 =?us-ascii?Q?SxDZyFHzFy1V48otwtNyDElRLn1tVyJ3PmNWscB8jveNgR87O9/yhEgaOTcM?=
 =?us-ascii?Q?r640C9uPo33yogoP+nxx0jGuzqFCayb6n2Klzayh4o0UkFwkECyHJKeFziJ0?=
 =?us-ascii?Q?kSDOemTt4ojwg35FuNtdw8cmdYtoOi6bszVcR+c2AjefQTToqkoBQlyqqu2C?=
 =?us-ascii?Q?39AaIzPWyr+6TlVNaXYdMXVi1ozd43zXBD8BBBoaD5UkV/7hCOZiofMPw8BK?=
 =?us-ascii?Q?KeoubFi3cwwcfQIrV6E25gvdsbwiV7m8HzrShSLrj1533TUGNBjN24ULvdPr?=
 =?us-ascii?Q?B1m5b+rRczgSIVI3UZ77RfXy6X+41bYZRQ3JK5kIU3ZOPuNb+13CoegL6SKb?=
 =?us-ascii?Q?Y90ZVkhmlH4ls9Zv8EejlZZYjhW7cmTDmHsEPlFdQ1CvtOeR1+HWpa7I8OUl?=
 =?us-ascii?Q?taxuPYXYEAzGjaCmNLkn9V9aA4DvdhZY9ib0mSbUFQQYYR4t/ckSJzYCXVN8?=
 =?us-ascii?Q?nFy2DzJ7t4rMehx4Jq03+eWQaBL8SHzjB+u64BtAHcuOzAApCC9tkdrUJvvA?=
 =?us-ascii?Q?OJ47TEuvZZ7efc/cRG069HneplcQYu+i9lFhi+7Eivkf19TPCgF3Rk3wYSxj?=
 =?us-ascii?Q?WQPjQ13AK25aAftvqs7A12+lA59nHQHvAjMxMLfCfEUcpbIuJQNpOYerxI7k?=
 =?us-ascii?Q?9jR4hxQ7yAi87HDxGS7NujeMLqgspxbvstT8T9flnFkFLz+yvbGWiARl0gYE?=
 =?us-ascii?Q?kcQ2o/g+UeLZd+7drfvnVzc/HwbP/PRTeQFODtRkwmE8wgb7bD/4OHVeij7K?=
 =?us-ascii?Q?tSx2J8cXHACU4ocCj8jwmYHVs/ZVoK+7W0zS1ckXwjvGnic8uzu1Rj5UfEr+?=
 =?us-ascii?Q?PEl86TegAWSSmBjRs7mc3GnIBGbwu6l/SvGIbup3evS6Tvzby/3Zn+fTjIQQ?=
 =?us-ascii?Q?sVO23Dv0tfSaqtRsXIV4GuFR7VpRrU9UmXfaKfq/p9F//cOQRnr34nMh2ztJ?=
 =?us-ascii?Q?XdbefHymlfQ4/B2cRpJjOaB0vbOsDDKc0k5ntGZhPJ4uMXHvyH/HtqOTaeLG?=
 =?us-ascii?Q?Ebis3pgOuhG29BmLd5s5gCOjWiRJDOhGRFgQoWvCZZja/NUcrnARVN7NUZex?=
 =?us-ascii?Q?GGsb/zeEBjakLx212GTMK+vyUknPPNryNXExdCCq4nEN01/LUiPpFyEJFhkW?=
 =?us-ascii?Q?TDpFJIYBprX4vBllzreQhNnbOzqyRIScLRdF6+lVFXYJIC33y8MK8usciQkN?=
 =?us-ascii?Q?mXpdJgDdIF0II222/64EgqUF15twYlY+W6Xa5xwQ2JX3E89aAGhM+TOuH+vP?=
 =?us-ascii?Q?XJ/9C0GZKAy+GGEAHn+0Fa5Q4mcWbL/4?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 22:11:00.5993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c6a2d5-dfa6-4e46-0ecf-08dd13e75ede
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9286

The handler will get vDEVICE object from the given mdev and convert it to
its per-vIOMMU virtual ID to mimic a real IOMMU driver.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 10 ++++++++++
 drivers/iommu/iommufd/selftest.c     | 30 ++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index a6b7a163f636..3037904f2e52 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -24,6 +24,7 @@ enum {
 	IOMMU_TEST_OP_MD_CHECK_IOTLB,
 	IOMMU_TEST_OP_TRIGGER_IOPF,
 	IOMMU_TEST_OP_DEV_CHECK_CACHE,
+	IOMMU_TEST_OP_TRIGGER_VIRQ,
 };
 
 enum {
@@ -145,6 +146,9 @@ struct iommu_test_cmd {
 			__u32 id;
 			__u32 cache;
 		} check_dev_cache;
+		struct {
+			__u32 dev_id;
+		} trigger_virq;
 	};
 	__u32 last;
 };
@@ -212,4 +216,10 @@ struct iommu_viommu_invalidate_selftest {
 	__u32 cache_id;
 };
 
+#define IOMMU_VIRQ_TYPE_SELFTEST 0xbeefbeef
+
+struct iommu_viommu_irq_selftest {
+	__u32 virt_id;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index d1438d81e664..0785c9447102 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1631,6 +1631,34 @@ static int iommufd_test_trigger_iopf(struct iommufd_ucmd *ucmd,
 	return 0;
 }
 
+static int iommufd_test_trigger_virq(struct iommufd_ucmd *ucmd,
+				     struct iommu_test_cmd *cmd)
+{
+	struct iommu_viommu_irq_selftest test = {};
+	struct iommufd_device *idev;
+	struct mock_dev *mdev;
+	int rc = -ENOENT;
+
+	idev = iommufd_get_device(ucmd, cmd->trigger_virq.dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+	mdev = to_mock_dev(idev->dev);
+
+	down_read(&mdev->viommu_rwsem);
+	if (!mdev->viommu || !mdev->vdev_id)
+		goto out_unlock;
+
+	test.virt_id = mdev->vdev_id;
+	rc = iommufd_viommu_report_irq(&mdev->viommu->core,
+				       IOMMU_VIRQ_TYPE_SELFTEST, &test,
+				       sizeof(test));
+out_unlock:
+	up_read(&mdev->viommu_rwsem);
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+
+	return rc;
+}
+
 void iommufd_selftest_destroy(struct iommufd_object *obj)
 {
 	struct selftest_obj *sobj = to_selftest_obj(obj);
@@ -1712,6 +1740,8 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 					  cmd->dirty.flags);
 	case IOMMU_TEST_OP_TRIGGER_IOPF:
 		return iommufd_test_trigger_iopf(ucmd, cmd);
+	case IOMMU_TEST_OP_TRIGGER_VIRQ:
+		return iommufd_test_trigger_virq(ucmd, cmd);
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.43.0


