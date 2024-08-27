Return-Path: <linux-kselftest+bounces-16451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BBE961513
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B86F1F23BAD
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813A01D2F43;
	Tue, 27 Aug 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="evfuLyW7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370031D6C76;
	Tue, 27 Aug 2024 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778183; cv=fail; b=dpJq6+mcmQZeOl4BUr73ZThyrCiCLIIoJQyA05ak1ihkkb9WYvS3fvq0YIZWTQhbqheCWhzQyKzaRw6uUDkrsjknrivCnJHO91qDu4442z9E8Euojo753Hp/g2V8B5Ity4rVkrRfuA8/N0bqnTTIa4j0uuOliAGqKRbr+5L38Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778183; c=relaxed/simple;
	bh=C08L/MDbPGrsX/NNYF3i0EPDBPXGtIqDrJmK86fXtl4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lq+MwiJD9gFpFsv9XN/+m1R4ZwtG9TLontTej2TIkx629atWnbcJ39zMoDduhJqqJlDRD4VGpe3xs+HYObn+d0u25DmAj2FNPrh1xUnTDxSzGMJ+Y5ocwuYB73Zq9aHtGmv5DGYIAQXJNV73s9m9KpwtPe6TwPalkg98xonuEJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=evfuLyW7; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CR3MNT27+VOUwI2VdFBWqWGVCOEBxp9i/G4zjtizaLMXaO696Xzg1D3lVtFWBBCN9mgqiDZMt1xkzExpdKYWKdc5ScbQKGo91xPTYwPbwgZu7QJaj+xUozLDQzCrwYfNCAsH4XxpKAf99qecBGrjVWqRb4GiQO7zB5H+tfSUNx27ncxF8EtxBkzvfVgHDaJxHbFaBMjug2RJwRsgsiBFMIvFK7m6+28vBa8S59qkiIEsRA7iP4X73lgaARje+CBi/BTk/xiVqxawIR4bHG4kUFA3OZv46AXnZedWpr36HSv++Aa4pzZHxvmJHDRJNBcZnVGVdO+g5roMlk/Xooxi+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ss4/aUGPOPzQOkDGeHhXTGW2kLfTHKop8PrV2z2scPg=;
 b=ehzrLTktvl+ByLtSavg0vmLD9ZgR1B9vl5dYeGGx0aX+PNy97zocpbqqmTFl5XptNcLi0deAJs/Ap7/uXErEdsxifuoJB3eevdzrnogcSK3xGRQtpxD8+Aakmf2Zkw2ybrvCjYsMc/CRPc4DcFuseN5yk4tSXiTAwcqhL87v1yUTf9bnxxQeY6JeZvoMwURHz/R0hjGk23cciKnPLCJJX9rPxkt2oh6j6gHatsqVDeeYvjf6Ck8xzNVywkoIu/4sJUBihUf/JxTebztVDoqu5a+yiuz0BwvJJHsJ7tUY7nMPURSnqntsqHWL2DouwmS1t9/SFefgVXLp1FIFLWggBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ss4/aUGPOPzQOkDGeHhXTGW2kLfTHKop8PrV2z2scPg=;
 b=evfuLyW747HKBK/tZcGSNT2P+qQVl8Rp4gkJE/zi1NTdXCz7KfrXMUm0xHf7Kc85i8JngZM2KhyFUx5eHGcbXJwXB8UmUWMNsVpw9IvWul6t0GRcAqMEI78plv6v/XU9KdNYa2SJYKjEEWr0q10/i1oyCb8D7UDT/F4xf47JQ3ryBPVWSy/ZN2qHs5DIybOXPftv66611dLYownt84PXa1d6b9Zboo8geBEnvMM3tlAJ8wTFJ5doZPJA9TRqJTXP3ODzT8UCKNCUxKLp5IomkJdBa7throIzPLUB7H/qfQSWxpP/4Q1DIAJrm4xBPL0EL3fSnkqLkzrq0b/XFBEPFg==
Received: from CH2PR14CA0022.namprd14.prod.outlook.com (2603:10b6:610:60::32)
 by PH7PR12MB9075.namprd12.prod.outlook.com (2603:10b6:510:2f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 17:02:54 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::30) by CH2PR14CA0022.outlook.office365.com
 (2603:10b6:610:60::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Tue, 27 Aug 2024 17:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:02:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:35 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:34 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:02:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v1 08/10] iommufd/selftest: Add IOMMU_TEST_OP_TRIGGER_VIRQ for VIRQ coverage
Date: Tue, 27 Aug 2024 10:02:10 -0700
Message-ID: <6fd58376ee0b04d42cc62e233a65d26127f8f921.1724777091.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724777091.git.nicolinc@nvidia.com>
References: <cover.1724777091.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|PH7PR12MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: ed12725b-0cd5-40c1-aaa8-08dcc6ba16b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BHXC0P6fGRKmW3mG++uDSnpNqpuBv/fYin+X7/7OkqBwnugtP8bbVNTETwEa?=
 =?us-ascii?Q?H4ze2DdmP231hx/nPWwcrizBucfIsg40HIBi2l1BsoJmf4HTNdGXFDTxAQHV?=
 =?us-ascii?Q?QmeSxocC7FSPslfo09T8C/9od3DtF0uNDoQ3v4kxxg3CfHxGQL9asRfxI9FC?=
 =?us-ascii?Q?U/vj73+tIfI+uJ7OYYC7aJBDPo41466fo3ZRNuEvOe7azRCHvUhR7K7Eq1Yb?=
 =?us-ascii?Q?rqSUgUL1WXA4/Abev9CrcAL/V7iluRgUY1iwib00SS00KriKryBM/l1VzWTg?=
 =?us-ascii?Q?zS3MhEG73u8FfBS306WM2Ex4GyuJ+0NVzl+mNStd8LIqiV7dBYo1jwk0C3TT?=
 =?us-ascii?Q?uoS+o3IgpHVsm11cs9r9I2CpNn3qK4bSbThlOj1rzJODnNbkHjGxw6CDMlY9?=
 =?us-ascii?Q?ShWnzWjluSnWvi/y0SReGJGiyEOZQ86lvFkzYZ3uJr4+uzy4bZW3478Z27Nk?=
 =?us-ascii?Q?MQXy1WeayOktix0ny5fSmb4bzpxrp1ZNDsTXj5R8Ertrwl48vEoGXkSBMGj2?=
 =?us-ascii?Q?PD88reWYhv2RfVAwzrlrFK89m0COvdL3mliynW1afWKrXw/OKYbbD+PtKJ1H?=
 =?us-ascii?Q?AxqK+/XuSXzlXDCfZqg1k1q38xOgxz+Yu8qRhuP8nNjPb49OZYMAwQCEUGs0?=
 =?us-ascii?Q?VPPvDpb3z5k3EVBOZZM+6rykLdLrjvBSxXPsrxckq59+fCjXBvChjPZRJTjy?=
 =?us-ascii?Q?mAf006MyeKOWqi184145/dQZZzIaEz7NKQ6ZwUJEe7wXREGZ1WLMQp4FhDYT?=
 =?us-ascii?Q?mh2stiIqvCjmJtPd1/ldlPxAZd4lGSwYijR1VFf1ZdmpBcfHYYQKnrNpAYMX?=
 =?us-ascii?Q?GxW/PazD1uq6ZnWK8+xNSjPz71kPocWbTP4e+H+061JGb5lmH3X39Eyd/AI7?=
 =?us-ascii?Q?sRKMQic4ZmJtOcdsONPg28U0zvhaaWUg8QsLBJU4ORwKCGov/mD7wCCsGhHt?=
 =?us-ascii?Q?JY4TQDttLv6SMuV0zJ4Kuda0UPWn8JNs+eXpirCiumCJSt1OFDM9YEVnDxrh?=
 =?us-ascii?Q?EZwl5u7e1aAJjKSjX6ckqb23/71KcvteDudlFQa3Vx7Icy2jWQv4c9cRKH5E?=
 =?us-ascii?Q?g4VJwcGMQWi7jqhJP8hoLgXk1WiSAx9ROB0QlyO3Yp3vr7lIgo4pOpBS5dO5?=
 =?us-ascii?Q?HVp1wRh9FmHBWbABWKJnZywhFj4s8MTBVdpCLJH8en9OYlrdvhXybAwLAF9R?=
 =?us-ascii?Q?HExZsgNS7QdqV9UH7jaALRvi5NhCFCKALAmuH4IZKxiqSKws7HcpvyMQBmEF?=
 =?us-ascii?Q?GydXIlfiFGPEwZAYb9edDUZR9nwtKjchZokz10KdogvydWmYvXX4D8ufxJyw?=
 =?us-ascii?Q?lkCSh9CU2vKI8IS62tVfVmOASSrJ5SCwt3uDg+jC1/mrncujC9JYd1+tKfTl?=
 =?us-ascii?Q?/Sd0M692lu4djhT1ZGNEqF1jU7unR1WA2ZbOuor5oUkbkYbOK1Xy0XLzuzVc?=
 =?us-ascii?Q?8oPOMGLKnlVjobHK1L5yp4gWGG3u3qSF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:02:52.5451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed12725b-0cd5-40c1-aaa8-08dcc6ba16b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9075

The handler will get vdev_id structure from the given mdev and convert it
to its per-viommu virtual device ID to mimic a real IOMMU driver.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 10 ++++++++++
 drivers/iommu/iommufd/selftest.c     | 30 ++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 56bade6146ff..736ae5f8152e 100644
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
@@ -210,4 +214,10 @@ struct iommu_viommu_invalidate_selftest {
 	__u32 cache_id;
 };
 
+#define IOMMU_VIRQ_TYPE_SELFTEST 0xbeefbeef
+
+struct iommu_viommu_irq_selftest {
+	__u32 vdev_id;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index ea2861d34b4a..75fccd466018 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1560,6 +1560,34 @@ static int iommufd_test_trigger_iopf(struct iommufd_ucmd *ucmd,
 	return 0;
 }
 
+static int iommufd_test_trigger_virq(struct iommufd_ucmd *ucmd,
+				     struct iommu_test_cmd *cmd)
+{
+	struct iommufd_device *idev;
+	struct mock_dev *mdev;
+
+	idev = iommufd_get_device(ucmd, cmd->trigger_virq.dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+	mdev = container_of(idev->dev, struct mock_dev, dev);
+
+	mutex_lock(&mdev->lock);
+	if (mdev->vdev_id) {
+		struct iommu_viommu_irq_selftest test = {
+			.vdev_id = mdev->vdev_id->id,
+		};
+
+		iommufd_viommu_report_irq(mdev->vdev_id->viommu,
+					  IOMMU_VIRQ_TYPE_SELFTEST,
+					  &test, sizeof(test));
+	}
+	mutex_unlock(&mdev->lock);
+
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+
+	return 0;
+}
+
 void iommufd_selftest_destroy(struct iommufd_object *obj)
 {
 	struct selftest_obj *sobj = container_of(obj, struct selftest_obj, obj);
@@ -1641,6 +1669,8 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
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


