Return-Path: <linux-kselftest+bounces-23488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EC79F5E1C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 06:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE15188D5AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 05:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE8718858A;
	Wed, 18 Dec 2024 05:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZdIaZfIk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2081A17B4F6;
	Wed, 18 Dec 2024 05:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734498118; cv=fail; b=uTOU9Vx18Iaa+mDQGYgWbSpr6ACi1GGw5sHPmG4Oanlu0FMYotkHrisXNjPeSpihp6jT0InFO1UkVlCJokR865Tp8pjSkVyMa1oTWz2i/5IbeuK6yuCArXOTJfeYh/kweu3ymOA7+4lCuLI3ksioybiMiPag7au8D6cSGhyoFlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734498118; c=relaxed/simple;
	bh=1hlT0kSUhwJMKbMRzE23lybS5jktDbtEiCMbJFEdKhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sw2IRcV5WxMH1MLW9Mo2RgHH3/ku2qHC6P1ywjjVUqaYO2C5GdLhwNu9+0uL9KjpKH60tyiS2jeg5c/vr8fzwGe2CNJ3YSVWCn8I0sPW4BJHwlviZhLHTw/fihQFA8NtZ6MGegRFYM67yFCEwO9YAmHiiih50oyLUQTJX2uLUBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZdIaZfIk; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTiATzCIG57qLBXdI8yaS8NQ7bHRiieGxdkjhL14IqcEBo0/fzbR4+7weo7TWmc+4JE8CPBeSwg0tvIGXEuLn7oaL7+f1cSE78Drjgvzw9l2f9o0jj48S/hZNcp3B/oFRunXSRt1d1PyyFg1t+teKxgRldqIO/PyQiDGstbP1ZfvOpngtBAB1qx2vNzzoUIQIy3g8Lq9eRGxUt6eremX43ZngRDpngzaADBg9iAHWWdJvivDBDxdzBN0S0U5gjgYkHqGw7yaUTGC9K17HTGmqtgR+BcFXOjLtiIe1MEzByCLMWd7zk8nCEj8gX2UTBHG4H6vQUpqqK3jhCUkjYq93A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NCGCZqr17sVj2upoM7Gwc0ihyUUa8f5uRYg1Aproo8=;
 b=ZWEcU1BEFvOrF60Z10SsdvbJA5Cdw6e0Iw2rF6GmYJA0tDTsMW2hJFI0YbOfMueNyd8n+7bX2BMYUrtXLnYMc+ncis3iYB6uRD9C+EfYV8Jh04olzxf4g7ADvH09gGp34WL/Wlq8cdIsH/M85QGroXL2OthubIdktAoLLiCNrIW41aX4jcnMHbQk73ViQh2LIvYUyHuXyKX/rCNKu6atgk6aJDhHRKnKsKVsYSd2BoNN0vH7yt9we6zPkWt9NW3ZApZwX2YFGqHf11LrNqtCvabUFiKCriky1fGddR7utFUBufBxjv2zwMQni0DKPXMhMA+ZBtaCA8n1dYj6l8P5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NCGCZqr17sVj2upoM7Gwc0ihyUUa8f5uRYg1Aproo8=;
 b=ZdIaZfIk7BQXdP/kc7+xI+y2QQtagxsqjQDU2YxBZ4elRI19ihBGsIKLEl7YjsShphq+UE4+xUrk16938k4fCogEVIgs7+8benEIthnAaRQfJwMDL0jP80udvzVncsMaZHd4//FryEeeY4vhT24nfDUOd0c5aBeFKaXPykeW4B/xWUlhmK58hixN0yyS9xAe9k9Ty206EtZGM0Vt2nWfFreyPfgLvVVNnxsJAF8MMtd1Pe5RNY0PrXJRWg+sOkOQd5spKbrI9aRLkcHZNWnwuU/be7/zrDRLDN1zEWhSiwkBrC5Cb9yDV5NFWbqdIUSysfNjRNXwSD8B1kwufYuRvA==
Received: from BYAPR07CA0035.namprd07.prod.outlook.com (2603:10b6:a02:bc::48)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 05:01:52 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a02:bc:cafe::e7) by BYAPR07CA0035.outlook.office365.com
 (2603:10b6:a02:bc::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Wed,
 18 Dec 2024 05:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 05:01:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:38 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:38 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Dec 2024 21:01:36 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v3 10/14] iommufd/selftest: Add IOMMU_TEST_OP_TRIGGER_VIRQ for vIRQ coverage
Date: Tue, 17 Dec 2024 21:00:23 -0800
Message-ID: <3ec98f083ad03aec737fe17c5f8b691d8fea644c.1734477608.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734477608.git.nicolinc@nvidia.com>
References: <cover.1734477608.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: bd2495e7-6aa1-4538-fed4-08dd1f211600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NenlaUkxh4bbGs92mR7J260vY6Lo1P0X1OHO0DV4hrLQryCVjXaj15bgj81n?=
 =?us-ascii?Q?HMLjmlwiob6rw1Jg8LA+F9Ie0GlHc8WBw+pJuyV9+S9SDXTSetitcfy2SImw?=
 =?us-ascii?Q?q1hQt9NHWE5MRm/iVSJ08JzNw/JJHqxFtr5Pcm/b4dE8ZSglpgorJLSkZ76p?=
 =?us-ascii?Q?3r7gzFTSMAaIiJ5fx6Sfkk+35mW2MC2a0r2yDgi6fVkLTUidQNT+WcERMIif?=
 =?us-ascii?Q?Keeckc+U6bloAXYk9orzcxCr7VG7sJ5wQPMpI7oM3uMl5LfKkhpMOXppfFzP?=
 =?us-ascii?Q?cIlZOhG6apBe6Mxn9of5n71cQsEvXrloaXoNO9wbGdIS27kYmkXR6fgj3zEn?=
 =?us-ascii?Q?IQeXVbIsrwmxeiq4fH26p9Xfh+ZkQQIzd8MwMUJdArno+rDa0cBIq88vATaY?=
 =?us-ascii?Q?mfiQ5rmFxKxRIRqbrkn3xhjctHZUqbilEY6lcvqB/fUHjC1+3bDOokg+jd1+?=
 =?us-ascii?Q?BGS6j8s/rGjWaWlN7TcmDqRASHOI9sDbQAMdRTY2BK9CgKnof5F8Yfnuek5X?=
 =?us-ascii?Q?D+Zb160wE9ihJX+lPwF8VQYfCbh/Sb5HcSl67TzYWgpTTwNenyJQQMwVaiIJ?=
 =?us-ascii?Q?1E58iN1RBZu3dL/HCAXR41LSbIpIRtl5aKpH05F2oirNEKKrEbnBE/kP6v3H?=
 =?us-ascii?Q?D8lB8Rg24JRZuXqQNPhJ/7cpzVR75tHIc27rPgDlrZrfXHN+v0rDwRNgeQPD?=
 =?us-ascii?Q?KqRmlIrImHGuhPoYaK0tOq15z7Ppu5FbH7UYhDp5TorAEkzWu4uSc3HtM4Ga?=
 =?us-ascii?Q?+nF1nkFdo5QJCndv/ip9W4yvQ+ApFTXNfYOSLSG9W0v83FPF+m8ubL6CIdxe?=
 =?us-ascii?Q?aA9elj8wR+lgn39wuoKT2d7ucGhaSOWvxBy9XjqWuGP3Ce9hvfrOdnNzyFZR?=
 =?us-ascii?Q?KP/qyOPwNmkkZIImVnUsvijEnrnWM7qXPChfSvzgkBtc1Q2vWxdazAf2NKAk?=
 =?us-ascii?Q?XDwaJt2GsAc3h71+Jx8fQxdPZOhr/5CuKwG7dlybjNIQaqmeh54d06GRX2Hr?=
 =?us-ascii?Q?eyGXPQzPg1+dPQbXgY3zMLD4ieRlFZY+AvlXUrqB2vItuPN3IB7aI4hMsBoT?=
 =?us-ascii?Q?DoGYcH+mhv29pQdTRGt1I4+TNmni+/cqonOPX50PeleLfzVoK5jxGyK6xFP9?=
 =?us-ascii?Q?1b3v0WoYIBvbtXih7j14yS08MADdpFpwd/yJVQPhStLcUKnNnS81tN3VPZaK?=
 =?us-ascii?Q?NI+LsGc4LorlDe0HjOA32izJ9d/z8U7m//OLYXx4zdfwhOJZOi0/nghMfitF?=
 =?us-ascii?Q?pw+iNdgDHn5VjXrhCSOp6j8fZMo42QqGnGx9SZokXstvcq0KJpabsxdm9iOC?=
 =?us-ascii?Q?KboUfvEn8jjjVdcj+qad5bqj/0E0eSBpKeTsGvByBqmxlhgqe1ztIHhKMQv/?=
 =?us-ascii?Q?Z//4XbV7K55pVB1IDACjX+G7EXi2f7tTFjy1WwO0R84SpwWjXb6WFnG2h91T?=
 =?us-ascii?Q?v2WzA+lhFTUqVqfjCP1OOpvYZ5liLklYzfOEo57tTnMy7s/OpB4IdxsEHkBV?=
 =?us-ascii?Q?/15OXjqjXKYJCCw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 05:01:51.8305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2495e7-6aa1-4538-fed4-08dd1f211600
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199

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


