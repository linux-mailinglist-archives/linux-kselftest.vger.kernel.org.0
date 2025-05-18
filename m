Return-Path: <linux-kselftest+bounces-33260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AA4ABAD31
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E30317B82C
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17EB1E5B82;
	Sun, 18 May 2025 03:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gmkj7eFs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5131DE2BF;
	Sun, 18 May 2025 03:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538539; cv=fail; b=tVCk1OkNNJ8lGeufkzkrJPwRscLHRCs+KC0cgPo+QeaSuIARe57ETdbm6gh1tswoW9h1/ERMO+WJm4Qi7CSBzOY6gUWKQiAuxmfAcixkP3FxT4RghBEG7+NhOzu2wnVLjwhAS66gfz5rb5M6AXsqtytSeUWL2R1UiHFxmnoRAt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538539; c=relaxed/simple;
	bh=Iqct3bWgYkFcGZ6EEnKzxf00DHfz0/Pjxh2bIrOx4Go=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7iJdaaIiqfDBkT+/yVBHCD/uh4kL4Ea/JAXZjHcvPRXZHlN3uoaD218jiMpdi4OBSndqCxI3P7UtndwJffJzvjC6suuL8Key/AzHkmpp985zAzlJ85/wdNe1F4ayUgaFq0EYuE5Ar8ourbKvRb0TXs5chOoLdGsBa8KHLQoX+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gmkj7eFs; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fsvywvbyj0G/mapVkW9sR1JBF+auzTmvn3FUstnXvPOk20VRiZvuGP+WzNFcnKVxS8yr6XWOrgwqIcvWlDDVMBAsScCeWVL7vzJ6AMOCwWajTkDGmKvnNAPw7UNMOvcqIYnI9Cv6+5oSHmi2W+sz4nGjVG/EMIB+BbuzZIFYtd78WJiQnJXTx8r2IReFg+cOG/X+l2YMNLjXtEOSDbLEf31YhYsvIGl/oOy2DZYpU58reccHJV8MYd1qHwL4Sv8Eq6NDH33e/qF6o8q99JJZbsPcg4Yb2uRdHWJc41lVy9ifRVoCtsGszIQaZq4XbF+yGz6aQagpFp4/+4zyWsDWrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZenAM3HVmuQyWbXVNt686LtEg+B35R33SAgcDZiDRc=;
 b=QzURBCm6K7aeYHFQ697zKbfGogRUy0ayCrMZcuWZTKgd/4T4MhIZTl9JPbq/8blD0XNUL1aIuyt+T49rmjMo9XOVVLA3b19HMKhYSrKxfd1LyVWC9JMCVrLgwDwk0W8svyK6kx7TAU6piuF13bi/HkoTChhumBKc7AR/+SrV8nLw+Sw1eLLvM6Kn3a4cqmh1MI36+ZuTObaDOpNIBbaf8rtzFdgTMZCC10tg7ZLFVBxBJzg9/VHexuNKERZ9A5owzFsZcGZ6f1gtKOoyqHbGBo4E+D67p14XW+/RigPdj+54fEbFaQmXUnmagsdXw5EolMZQPZ5yob4GNSn1JYOwJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZenAM3HVmuQyWbXVNt686LtEg+B35R33SAgcDZiDRc=;
 b=gmkj7eFsAKQ+NnzE42QuLZ++XRbngo/jx1lCedziPceOBNcCEKnVGuJuK/SdNoElxMl6ap6AmU/dOGXWsdgIljli2fOVJhrN+fAWnobSy5jIhjy5TKzVCyTqkuPF6L0FhalykiWhV9MyxANbGI9RLOJDMPlY0RBAFLuWuldUmJZ6FR/L+TYkOqO7Ox+Ojy27qOfTbCdtlUY1qzfybgg20dWu5Rez9sgoDgvJtcC8M+bE9iaJAJkpEr0WjkuoeHqgQaLaLeaxOJ3R7IRcvi6vtE5qY4e7kGayjVSFv433+KVQ0wFaPdYaJC512zvKHMQdR0TfIJJeVS+LlocPQKMhNw==
Received: from DM6PR12CA0034.namprd12.prod.outlook.com (2603:10b6:5:1c0::47)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 03:22:14 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::df) by DM6PR12CA0034.outlook.office365.com
 (2603:10b6:5:1c0::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.17 via Frontend Transport; Sun,
 18 May 2025 03:22:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:06 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:05 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:04 -0700
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
Subject: [PATCH v5 06/29] iommufd/viommu: Allow driver-specific user data for a vIOMMU object
Date: Sat, 17 May 2025 20:21:23 -0700
Message-ID: <7cd7c15416daf35f0b5a66e84166d68fa657cf5c.1747537752.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747537752.git.nicolinc@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|DM6PR12MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b11e13-c826-442c-8ada-08dd95bb2fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MluZf9kHpiOSj7LBSVOzS2ymblO7w26yyKq8b7OQ4s5mcusB996NhM2ukEq4?=
 =?us-ascii?Q?0LPF+l394WGmFfmQQfrPx5ibHnWzHSjKzgvSIxyCFJ+gc9K25OCur4+OYJ8U?=
 =?us-ascii?Q?WfQeyimI4S34+hjqkNEKFsh7VQvmTeOTxXY38pEfj2CAnp2p+MjnDfXOAJM8?=
 =?us-ascii?Q?jRig3Ubjs+H4dmkmm7WjL8zlDT8SBo1xE+U8h8AeTg0Sluv8FF9AseI9n2R4?=
 =?us-ascii?Q?D9TKMrUBTTbIJ1l+GADyZmd94+cBhk7Yo0iNlC2LcnbdlgRlIvYMkWfrJoKx?=
 =?us-ascii?Q?9rsNzPIQEtxJDa6vySmK/wTHa9yjaSMHzOLr6z50XvN8NqrQzq7AUouxRxGm?=
 =?us-ascii?Q?7xrR9maVmaqoNEFY9kRBKzw7asskRl9zqFBr9jPOzI92us6wGuPiUfwEzyNv?=
 =?us-ascii?Q?9pAGUTaO97wckVxCHC4NdQ9uQtZFw4dN4TYb9cFnlQiKevIo7QywNus4OQ3m?=
 =?us-ascii?Q?mlnORWQTKBwgn0PCmsObdkJy/E87MYfiPVppi7XVXMDO/H2VEuPXd2FnvxYu?=
 =?us-ascii?Q?8R28ExC8rzZMzHqbJ97YGmqmqs2q8lhV3Rv3Bml+nnO9flFAnAP2o5lmVHbS?=
 =?us-ascii?Q?axdMja0z6oatFp2ew7RiTRzt7nbvm9ZzODAyrjjhyMhTbh79S3/l16JUwnAq?=
 =?us-ascii?Q?O6mtwm1V3VsJ1bIxVeOihhOsMWERlfgu5TwobYdCpVwthxTVwW5+TxLmQGZ9?=
 =?us-ascii?Q?AvcHajBXj/GPO7AJjJ0P+tBjWdMaJH/B+sXPdcu1/iNMjGfH2PqKP5xn3ZU2?=
 =?us-ascii?Q?scgSh3+yFzW9TFe/DrNV+VpkeBXB1B7WStJBNsqoiFWVn4gCMCPpBq0nx69B?=
 =?us-ascii?Q?50cKk2abl8Gj+3oMLw/Nhpq61z+DmLSo2i+dkucc47upS6LfbKYVmv3KopqP?=
 =?us-ascii?Q?UKvvbiz6Y5ff3CEd2JGHK/XJKMwacyS44PpxKDQSAeDi2B0lInp37qT6o9wg?=
 =?us-ascii?Q?yZ8EaDlVOdQwjudjvF9JagJFN37RbF6yJIm2vVWgQ0PBLKSRJOK5neHzl2p5?=
 =?us-ascii?Q?Ajz8osW2k5Bk0hItCp0Vq5Vl+rUn3ObskfxbcxswBuz0oSkPAU4oE8WvJgMo?=
 =?us-ascii?Q?Wl8uUEXZPr1S4yKmzTbyfJvcEszduL0Yh0QM63/NchpzjRcXvX37XBfGVmMl?=
 =?us-ascii?Q?0Usi6t9aDM95VbJVROBfnVfeyCUqo4XhEftrveW6xE6kUycTkD7k9rBrFqRL?=
 =?us-ascii?Q?EAGk/8XZNf2XjzjtKEuYYz95n/ER411LSOvzi4EMw/fGcYrw4q4x2HED2YFB?=
 =?us-ascii?Q?BUVtEzuSd141R4xDzAH2qtZnKsYCwQzXg3JoigyP3Dndtxn4Kl1ofgLpxTBs?=
 =?us-ascii?Q?kE/r2qoVAXZxF3XLBTeGS7nIGS9M169Da8JrhjXSSwyyIInDDt8nTe29ZqDd?=
 =?us-ascii?Q?0bFq+lQe1T3YnmzAfJVNiJX3mOTRhj3s6oigDALb5EsVx/Qe3FaW6buUtI+T?=
 =?us-ascii?Q?fvxfcSDqeZro0pPKxMLa3Kac9VVj+SjTfn3wXgcoLRZJf998zBe3Un7+6C5O?=
 =?us-ascii?Q?O/zfQuicBAX1BogOIy5Aob8OklbH4CkSqd20?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:14.7602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b11e13-c826-442c-8ada-08dd95bb2fc3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481

The new type of vIOMMU for tegra241-cmdqv driver needs a driver-specific
user data. So, add data_len/uptr to the iommu_viommu_alloc uAPI and pass
it in via the viommu_alloc iommu op.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Pranjal Shrivastava <praan@google.com>
Acked-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h   | 6 ++++++
 drivers/iommu/iommufd/viommu.c | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index f29b6c44655e..272da7324a2b 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -965,6 +965,9 @@ enum iommu_viommu_type {
  * @dev_id: The device's physical IOMMU will be used to back the virtual IOMMU
  * @hwpt_id: ID of a nesting parent HWPT to associate to
  * @out_viommu_id: Output virtual IOMMU ID for the allocated object
+ * @data_len: Length of the type specific data
+ * @__reserved: Must be 0
+ * @data_uptr: User pointer to a driver-specific virtual IOMMU data
  *
  * Allocate a virtual IOMMU object, representing the underlying physical IOMMU's
  * virtualization support that is a security-isolated slice of the real IOMMU HW
@@ -985,6 +988,9 @@ struct iommu_viommu_alloc {
 	__u32 dev_id;
 	__u32 hwpt_id;
 	__u32 out_viommu_id;
+	__u32 data_len;
+	__u32 __reserved;
+	__aligned_u64 data_uptr;
 };
 #define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
 
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index b50b50ec87da..2b30627d1d8e 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -17,6 +17,11 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_viommu_alloc *cmd = ucmd->cmd;
+	const struct iommu_user_data user_data = {
+		.type = cmd->type,
+		.uptr = u64_to_user_ptr(cmd->data_uptr),
+		.len = cmd->data_len,
+	};
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_viommu *viommu;
 	struct iommufd_device *idev;
@@ -48,7 +53,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	}
 
 	viommu = ops->viommu_alloc(idev->dev, hwpt_paging->common.domain, ucmd,
-				   cmd->type, NULL);
+				   cmd->type,
+				   user_data.len ? &user_data : NULL);
 	if (IS_ERR(viommu)) {
 		rc = PTR_ERR(viommu);
 		goto out_put_hwpt;
-- 
2.43.0


