Return-Path: <linux-kselftest+bounces-34985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 932E1AD9AB7
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91323189BD6F
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D602F203710;
	Sat, 14 Jun 2025 07:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lwN154AM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2FE202C2D;
	Sat, 14 Jun 2025 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885334; cv=fail; b=MTX2jaq4hHajMuuGq4UZgDa+Qbig0dPTbn9SMIZvoDKYmf3X3z/jIvmp9sTjDdQa8El3V9WJQISn+SZUqNsCxuWQbRrgGKwD+dOCoJ30VQL4QykZSv4Jt9WqquY3sMUBdmU8j1lv11uwPK5kKQj8rGIRO6AsqRk5sHUYsSt2y3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885334; c=relaxed/simple;
	bh=fxfXsutlZdjBt6KJR3LLk9I4XgULvR0qNeLdS8H/Vio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6d6yCfoh1TmYfmgbaryrOZZq1Ta81xloODgXQ62ozF4/N3i2Kod63hIxKZFlHya9R/Dp+61TMEqF9o/90rYdx4NtOZDVZ1EUNBLhB4Niinc/8A9gtzn4p9DFER5047umtumjk5hsKpHHitBL1GTf+Ko5YAS6Kx8AHqUvBN7Pi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lwN154AM; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwUsCU/2TSwmVeGbRtxsO9oHpmbgyqjhTQIzXp16mFnLYhps9AAkVqM67Rw31pyUxrU+TCDsSl3GcXo7Ud0N2DrUUxwwZLJl0ISUflxYiQterxE88qJ5kVspbthIvm5D6ki+DavmHaUkU1zGzl6C+oZuopMvEQciJt6rWeznDa0hIPb8KjPcjpDZ+PFJC8XtprljVtK/RBeu/bYl0pmNjqa3AnQwd8FNQZRTVIJg1cxccjpeGszTR2wER8qDFMyJgiUCjGtaZtZYnnOb9QHVRee7SUcTysXQnOwvRJgd6SDZxVfjMImKRk6LZF9Ioz1dCujLCl79k0ebixj7nuQqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxQ3d40WoknBFi1juQo5c8W9fslYcZCseVryUoV4KD4=;
 b=mnXoXi1bOjut12p/G0+2mHcCYj+Gpg/nyOq5Wgqg8VjyYDRgx58t7HFFkY8D0G5OAyIoereCKukKiWTwlCKMA1nUGmMVBvnadJkFX5nervHIpNHFIElZ9MW9ZXoRIFVDNMEyYDD1rynBU5Cv3YSno/ml9Qh+6vqT94qGVWtyBNPVpRq6RUMBOlGh6OIurR9qo3brgSNsXBpl/xYRfdMSyN34/zN8zAj2+0ZSFDBh1qZ8f27xmeqFFVSoPqoSTgMERlJNHjvPwQoFJGxp6CYVlqsscizZyzt9j8rgplyhd6dv9+vrCXjM7Ma8D5yESPNgnAJqca6bCtlSREThPgyIyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxQ3d40WoknBFi1juQo5c8W9fslYcZCseVryUoV4KD4=;
 b=lwN154AMg918MPvi/BPZ4d7bu+RcE3CR+l6QcMop0P+FvRqJdP78eITCzc+DH+sHSOpjW+y3wXw4U/eN38QYtcBw9Fv1XJCgc3Yb2TrsSkrBnjtW7u4j25M/EsToSjKpRs8BT7Bs3xiX7xWQl1jsoy1LMxjH6jZb6ytuz7ZANoVo3HDikiB0StWBwHxZxiznaQoOP/KIxAnLcl2KPI3HIAurwklzu1fYzUvw4EE7odgyJ89MbSnY04rypcPBy6NlWpjeWxXHh8UaeSTQTX+4mSmuZW0pOISnhpvxhU9acjb7jhZGLcb/+gyYN/SfRywGzkbbzTKmOx9BpOLBQDVoog==
Received: from BN9PR03CA0688.namprd03.prod.outlook.com (2603:10b6:408:10e::33)
 by SJ0PR12MB8140.namprd12.prod.outlook.com (2603:10b6:a03:4e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Sat, 14 Jun
 2025 07:15:29 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:10e:cafe::96) by BN9PR03CA0688.outlook.office365.com
 (2603:10b6:408:10e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Sat,
 14 Jun 2025 07:15:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:12 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:12 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:15:10 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v6 08/25] iommufd/viommu: Add driver-defined vDEVICE support
Date: Sat, 14 Jun 2025 00:14:33 -0700
Message-ID: <937d515032be07af36c06a4adb662ee2f7693c75.1749884998.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749884998.git.nicolinc@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|SJ0PR12MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9a0832-3d80-44fe-04d3-08ddab133de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y8lpcxGfbh3jCvBPR4P3Eq0MzV3wRG1xeQkrqtjCKpbPh6E0LP9M9G/YJIvO?=
 =?us-ascii?Q?mrByQiEvF6MNFs9rS/0q4HGBBTxrmIeCzNd/B+1E34bCOriXoVUjl/opZpcC?=
 =?us-ascii?Q?wN/KowfGakczKNmO/0z3Z0wYFzx4+jsQau0tkiXicMEL28olsiLivceKXXcb?=
 =?us-ascii?Q?JE+NG1SKhsq5HEzvjwG0AO5gCV9q0Iu+JA9noTJWDIXZ8A2iUJ3SflrmIMTq?=
 =?us-ascii?Q?dfkP5qw9JbDGnB2CjBs7Y4BkCmodVUOwmfs4U6NwjuM2zPMdkV7cbgp7P8VE?=
 =?us-ascii?Q?DYSdsVkI5VFI0E44QiizD0RocsFTLtr69Ma5vkxIiqy+p56lI8mYur2CO7s5?=
 =?us-ascii?Q?InEdROarAvehlcN6dkTTBx5T+TSYJztuU3PEth+TxVq7pDMmJpzg0ieccuUQ?=
 =?us-ascii?Q?ci2At5m5KI4MLaivFm2VWDCbr+kdOqR1pK2GIUW8PG5cp+XJM5/neAPgNmTk?=
 =?us-ascii?Q?DpbQJeXThsjJnz24Fs9eNzBjRqVwi+Y5lT1fayrwVPsVOgh1uPQV0MdSRVOB?=
 =?us-ascii?Q?PK9RxLwJKBhiab1xnj1/zsYFBgLJqsSjvJgVOaFfEvQbIQAfnIVfmMp5H25U?=
 =?us-ascii?Q?VzMQDjdmnU6ZkihXzLVzraeGBaweyeYs2Ju/DR/g6E6XdkLaFJsx/jkol5ge?=
 =?us-ascii?Q?CDJK6iD6Xh5mEXBgqkUicwT1rQvYlK/vc3T9toP/B+Y8hJDyLPnE+pp74ww3?=
 =?us-ascii?Q?/RT2J2V0IkfA6/XpicMYP17REg3qVFUQLi+WiKDh+ZsJWH5lrGPHmBqUp2I/?=
 =?us-ascii?Q?yro92DkECeKG0er8+jPSVReCB8sNQI7OMXEJU+pmggOwnPlj+2rjSqlPNJJ1?=
 =?us-ascii?Q?xA/131DHJjlVGl85mMUBnTAPhBDR92UiRGPRZXq+jvFuBscZzcvB03fwI00G?=
 =?us-ascii?Q?GPTO+RGana8kKHGLc/RQdWRQm5AxiGtZwLqtA8abFwZsfD40sx9+xXV2f4jh?=
 =?us-ascii?Q?/ts1fc/q9MTLRMOw6z2V02HzoyHwFSI5kFcl3LV0kiDhm/uAOZFNiZa/nmOd?=
 =?us-ascii?Q?fiPMy1UCoYryTTQTULJZktW6FOeUl7QLvD1UMLtnWhCiGNGdbVieEt94OO/n?=
 =?us-ascii?Q?CBnB0ODst+3fu9uFw/1hGtIjuWf1Z7blqOmVSR6NJqkZPC3NY4GJVMyZytdF?=
 =?us-ascii?Q?IJSq552zQU0Z2DG6dD6R8zEUREWwXd2Gg+5g4PVcLwEzbdyn6GXnuIu8PIcI?=
 =?us-ascii?Q?GWW/ybPvBErgEeha2r1/NKO/J1ymTVhYmMp2Sa4mI3BiykIhjzgybKd6eRUZ?=
 =?us-ascii?Q?zfPgKtdyhanqiAXfQDMjAKjfaPn5r1LY36rT24nBhWXbwA/PgMpYZeig8tXt?=
 =?us-ascii?Q?7+FZzyQaclY+4d9YeHTSf7uj59H5x6yQFBxSDcxO8ibzX4d5WiuBLXn2HPhb?=
 =?us-ascii?Q?l+pK6RRtQEuPsQj4in8RaibC3hpTB6dY4oCt/rbeq0dAs1TkiK1xXvOh/6zc?=
 =?us-ascii?Q?EKx5KKqtJjB8zZrHYrGkBFUT5ktu7tEVUKUjSEH1BEXLBjQkuBLIY4rLCnSB?=
 =?us-ascii?Q?rSsofdtvHsQS97yb03TyLNgTAZsVGcShgs9B?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:28.5953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9a0832-3d80-44fe-04d3-08ddab133de9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8140

NVIDIA VCMDQ driver will have a driver-defined vDEVICE structure and do
some HW configurations with that.

To allow IOMMU drivers to define their own vDEVICE structures, move the
struct iommufd_vdevice to the public header and provide a pair of viommu
ops, similar to get_viommu_size and viommu_init.

Doing this, however, creates a new window between the vDEVICE allocation
and its driver-level initialization, during which an abort could happen
but it can't invoke a driver destroy function from the struct viommu_ops
since the driver structure isn't initialized yet. vIOMMU object doesn't
have this problem, since its destroy op is set via the viommu_ops by the
driver viommu_init function. Thus, vDEVICE should do something similar:
add a destroy function pointer inside the struct iommufd_vdevice instead
of the struct iommufd_viommu_ops.

Note that there is unlikely a use case for a type dependent vDEVICE, so
a static vdevice_size is probably enough for the near term instead of a
get_vdevice_size function op.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  7 -------
 include/linux/iommufd.h                 | 26 +++++++++++++++++++++++++
 drivers/iommu/iommufd/viommu.c          | 26 ++++++++++++++++++++++++-
 3 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 468717d5e5bc..e6b1eb2ab375 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -638,13 +638,6 @@ void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_vdevice_destroy(struct iommufd_object *obj);
 
-struct iommufd_vdevice {
-	struct iommufd_object obj;
-	struct iommufd_viommu *viommu;
-	struct device *dev;
-	u64 id; /* per-vIOMMU virtual ID */
-};
-
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 2d1bf2f97ee3..f3b5cfdb6d53 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -104,6 +104,16 @@ struct iommufd_viommu {
 	enum iommu_viommu_type type;
 };
 
+struct iommufd_vdevice {
+	struct iommufd_object obj;
+	struct iommufd_viommu *viommu;
+	struct device *dev;
+	u64 id; /* per-vIOMMU virtual ID */
+
+	/* Clean up all driver-specific parts of an iommufd_vdevice */
+	void (*destroy)(struct iommufd_vdevice *vdev);
+};
+
 /**
  * struct iommufd_viommu_ops - vIOMMU specific operations
  * @destroy: Clean up all driver-specific parts of an iommufd_viommu. The memory
@@ -120,6 +130,14 @@ struct iommufd_viommu {
  *                    array->entry_num to report the number of handled requests.
  *                    The data structure of the array entry must be defined in
  *                    include/uapi/linux/iommufd.h
+ * @vdevice_size: Size of the driver-defined vDEVICE structure per this vIOMMU
+ * @vdevice_init: Initialize the driver-level structure of a vDEVICE object, or
+ *                related HW procedure. @vdev is already initialized by iommufd
+ *                core: vdev->dev and vdev->viommu pointers; vdev->id carries a
+ *                per-vIOMMU virtual ID (refer to struct iommu_vdevice_alloc in
+ *                include/uapi/linux/iommufd.h)
+ *                If driver has a deinit function to revert what vdevice_init op
+ *                does, it should set it to the @vdev->destroy function pointer
  */
 struct iommufd_viommu_ops {
 	void (*destroy)(struct iommufd_viommu *viommu);
@@ -128,6 +146,8 @@ struct iommufd_viommu_ops {
 		const struct iommu_user_data *user_data);
 	int (*cache_invalidate)(struct iommufd_viommu *viommu,
 				struct iommu_user_data_array *array);
+	const size_t vdevice_size;
+	int (*vdevice_init)(struct iommufd_vdevice *vdev);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
@@ -224,4 +244,10 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 	 BUILD_BUG_ON_ZERO(offsetof(drv_struct, member)) +                     \
 	 BUILD_BUG_ON_ZERO(!__same_type(struct iommufd_viommu,                 \
 					((drv_struct *)NULL)->member)))
+
+#define VDEVICE_STRUCT_SIZE(drv_struct, member)                                \
+	(sizeof(drv_struct) +                                                  \
+	 BUILD_BUG_ON_ZERO(offsetof(drv_struct, member)) +                     \
+	 BUILD_BUG_ON_ZERO(!__same_type(struct iommufd_vdevice,                \
+					((drv_struct *)NULL)->member)))
 #endif
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index c5eea9900c54..28ea5d026222 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -116,6 +116,8 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_vdevice, obj);
 	struct iommufd_viommu *viommu = vdev->viommu;
 
+	if (vdev->destroy)
+		vdev->destroy(vdev);
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
 	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
@@ -126,6 +128,7 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_vdevice_alloc *cmd = ucmd->cmd;
 	struct iommufd_vdevice *vdev, *curr;
+	size_t vdev_size = sizeof(*vdev);
 	struct iommufd_viommu *viommu;
 	struct iommufd_device *idev;
 	u64 virt_id = cmd->virt_id;
@@ -150,7 +153,22 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
-	vdev = iommufd_object_alloc_ucmd(ucmd, vdev, IOMMUFD_OBJ_VDEVICE);
+	if (viommu->ops && viommu->ops->vdevice_size) {
+		/*
+		 * It is a driver bug for:
+		 * - ops->vdevice_size smaller than the core structure size
+		 * - not implementing a pairing ops->vdevice_init op
+		 */
+		if (WARN_ON_ONCE(viommu->ops->vdevice_size < vdev_size ||
+				 !viommu->ops->vdevice_init)) {
+			rc = -EOPNOTSUPP;
+			goto out_put_idev;
+		}
+		vdev_size = viommu->ops->vdevice_size;
+	}
+
+	vdev = (struct iommufd_vdevice *)_iommufd_object_alloc_ucmd(
+		ucmd, vdev_size, IOMMUFD_OBJ_VDEVICE);
 	if (IS_ERR(vdev)) {
 		rc = PTR_ERR(vdev);
 		goto out_put_idev;
@@ -168,6 +186,12 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
+	if (viommu->ops && viommu->ops->vdevice_init) {
+		rc = viommu->ops->vdevice_init(vdev);
+		if (rc)
+			goto out_put_idev;
+	}
+
 	cmd->out_vdevice_id = vdev->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
-- 
2.43.0


