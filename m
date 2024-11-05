Return-Path: <linux-kselftest+bounces-21486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C599BD6A9
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F191F21329
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A669E21730D;
	Tue,  5 Nov 2024 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CHaGXjcH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72126217302;
	Tue,  5 Nov 2024 20:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837159; cv=fail; b=JT4o09broqKKdhnwdgySOECpUJYSLTy9j8+gWcHueXd0ZZZoj1eqmNymdY5s7LY/lxATGOoS0/1TKooqxe3/7+gLIj5v7HoZubDdInD85dM8OC+NQtvjxbbWrDvEr9iYQhhsM6LhhrMMeWcAAwGBKauwx8L/rqYea5+Zk/xnMf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837159; c=relaxed/simple;
	bh=phwGThBDDHJPzVkjNR9rT65ZH/RPVrCQ7Urwg0vKE1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqD7BiuvPrCbPBjjVH5wrUv7BRQbTOkPcK7bNu6TI6M/mHffxv61FCPRywYp8xcZATfVmn1Y/SkQ1iCRxVMi/N26MvHViWRvxClL984utBP75mE8GNb29SseUQye5r0FnqMMRS0gI4PPMYRNVzCt3lGIP3zUPj4KhECNOdG1bz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CHaGXjcH; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J468p1XQhNWYSAKKGEKhTGlxafgPIN9wt6nXZYfnhxdlXigD/4DVr04fNnA94b8vuPbGQ8DqPDSGIIm+PbMR3c73T2Alc8ySBX6LPMEBGQ0vZb8axAbQa9ED/qIHpogicTWazmbfRS5U78k+vG1kxJP/+DVivHJjJb7qCZjV0R06oPQR1O0yLK1KICUVhuU98E2+GFMPXf4L1J6xn7Ndj+eQOHMlcQP+VE1xdr130iakj6Ow8qVt7mv0x4hCQ6LIo/fB1sAW1PV789X6/6mS1NckiaR52EEaaPaaWlFb4ElICNLnQat/mb+pTVe+6fuI71uA+U9cEj95itVuaMerAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcjcKnzOqboFvGUJcANr1jmBa0tNxhUjTZH/EC+5org=;
 b=eSYUtlR+J6oa+0BQPK+2/5ShCDkMucCgH/J00kNmLRZadv0uvXWOBDo02ASOLfVN1NwMqXmeWtb3v/yubndgDvm+8H6IxfiDT5GiwYP/2pvk/43h+XnWkMhnYU+9XoF42VFyZoe6NuHkOkT6/FEH7/0jTzTUIgnhaKMZI6KdfvuBAn2BpUD2x0YW/ArOO/elPkpzHT7OGTrwvGtyk3vgxQZVeNg+MYAh4a3NRNE53CQsIMXb1mpPEB8da2FPPv5JIbG/eQSEiBGlGZEKh9Acrzkb7+E4LCt9zdYX83mGRPVvuSNJulcX757GOru1Px3zQ9yLu/8fh8xa4+4dURtjVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcjcKnzOqboFvGUJcANr1jmBa0tNxhUjTZH/EC+5org=;
 b=CHaGXjcHEQ2ByEW3yHg3iwRpqYnUCPoTZQmECIf23ey28CpVokhUZxvaki0Tr59+bMfKUIJROUK3N7Ktb4eHmskJ9/VC78qKxOUAY/Ce6Iz71dkkncXdglqAy7eBtlX7NtPlNItuY9PFf9rESJAI5/fq0TxFeEm1P+ujOhnOT6vipJfWQyRyBbtRdW6aV9MQn7qMNNDsGopPYno+cFkmvHClmOcCxNmVEyArt1noTGnTvfikLGLXUGGcLQ+DC29jE+8pPDbix301FgOQAlQbyKhhAqqPbTkPuTP2W6azCPFkF2598TW8Al7O4V2BImOxwvFlYfQKAXjY+xG5m6J25w==
Received: from BLAPR05CA0022.namprd05.prod.outlook.com (2603:10b6:208:36e::27)
 by MW4PR12MB6849.namprd12.prod.outlook.com (2603:10b6:303:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 5 Nov
 2024 20:05:53 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::2) by BLAPR05CA0022.outlook.office365.com
 (2603:10b6:208:36e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17 via Frontend
 Transport; Tue, 5 Nov 2024 20:05:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:05:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:36 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:35 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:05:34 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: [PATCH v7 05/10] iommu: Add iommu_copy_struct_from_full_user_array helper
Date: Tue, 5 Nov 2024 12:05:13 -0800
Message-ID: <5cd773d9c26920c5807d232b21d415ea79172e49.1730836308.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730836308.git.nicolinc@nvidia.com>
References: <cover.1730836308.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|MW4PR12MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 0961141e-c666-4240-66f8-08dcfdd540cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NdhtnxfMI8xJSyKVyosnNZLZHjGQfuHjH2X3gS9pKk+dnnOKG8tg0Gmw+3dz?=
 =?us-ascii?Q?XaZ4tFhOh5ACHP3Mu3ZGNdl+Px7ceI0/yg8FgF8JCSBg8cgCdISg0j2qHUXN?=
 =?us-ascii?Q?JnYnsvpajIfjLr8EH7rsCe+97b1u50amqcsOTWuLeaOzZoGmY/NizlsmU+ij?=
 =?us-ascii?Q?5ofr8gat1whbkeTz4uO0newmD8yJLY/G6FCu/jq+GXddWsegdYDcTEkb3Au8?=
 =?us-ascii?Q?pjv8y+kMYDDA/6RGnkBLwHV7bJBL5cmta+5aD7ithcbWg6gfEPZbXp9fXwR6?=
 =?us-ascii?Q?eW07Aql8O+IZjUJbau9+L0oJpVHRR14k24PNYygBJ04AvrItEQzPoJ15xsms?=
 =?us-ascii?Q?yU9JUuS345u9W0VHgeMn2pmDPEFMGBHgEyJ4qKecEbHvEBA9T/YPlfM3U6lL?=
 =?us-ascii?Q?HcAiL6GUzHiVjY0HGTLRDp+GW9S9vmBSGvI706GaAR50CYo+FjdGq0lsGE7B?=
 =?us-ascii?Q?eufw69eavSHJF/inWWMMQV0KDYKzGmjkEXxLPpFM8MHDA+/OPphfR8hIRug6?=
 =?us-ascii?Q?Qrb8uqHTSZrEC4D6EoU+AlHJRlLZfh8Rj39+XgwMRuLObqFXXyD9K16cNc6D?=
 =?us-ascii?Q?kpPxdeBNT7J3Tw5a3cdn04zAXPUcHv1TFiY3EUxoLID0MqHO16W0gzP7/jZ7?=
 =?us-ascii?Q?65jmijCOAvnllB1+ANUSZVWGE7UNSJRLOghygx2CTze4HZNrClwUDK8b6Lut?=
 =?us-ascii?Q?rgG4I57ciqMBNrU1xRRkSyY/FPSb6sFjU33Qlx43urZw50ZQhClw8YVLio7M?=
 =?us-ascii?Q?SvFD7Pf3/Jaq9qO2ZM+9SWkS+kxLzEhCGQzWADcu51AhGoNT/sMGonEKvmlT?=
 =?us-ascii?Q?5Rsm+AthCWyUzUukoDPPjQzBrSwa9WeLdue+Ngi+0uCg12VMpBIhKptOAp8T?=
 =?us-ascii?Q?l4LClNAAg2edw9afHp9yq1iQ8IV2bGn1/z4Q18A429kCGvV+EJ1ANWJn206Y?=
 =?us-ascii?Q?qquY1wm+ixmPXVHhECm62KoUszQ1o7f46jjcgfzoHclvwenAg8haFJ+tl+m+?=
 =?us-ascii?Q?o+wqK16+JjyZflwtzqkMzKBgNeBAWgHpS40rHvWIPeNB6uvGTg6gx7/CxieM?=
 =?us-ascii?Q?oGQrOQAg35nhHCpTIt/fcn8Aw/z4SqddHPTnB8Ttk5V4jcnSxJHGoooFi7pQ?=
 =?us-ascii?Q?lbHjJsCj8Xo4p+FDKEPqdvA8A8KlhtsKb+c0q+cQafYtO3Fto+3j7gLh/I99?=
 =?us-ascii?Q?tm+iqt1wBdc6p395QpM9PuJd6JlZrSPfKne4+CdSs1yNpQN5BEPbI+MP/hxz?=
 =?us-ascii?Q?63KjgF2JW882NyHPMXxkJIeDdZKeTOtFhJacvzPPmOqYJvJgGXpP3FfC3zcG?=
 =?us-ascii?Q?ylQbR7VGYxjMWCiRet+7ESg5Ivr+nC6MUnNytz9E+dQdjsRG3t6zKBufDtGu?=
 =?us-ascii?Q?q/Yqh+WzxEDNziaQ53UHpcZIASRBgnCH6wA1dLKBbXCPlp6YDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:05:53.4735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0961141e-c666-4240-66f8-08dcfdd540cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6849

From: Jason Gunthorpe <jgg@nvidia.com>

The iommu_copy_struct_from_user_array helper can be used to copy a single
entry from a user array which might not be efficient if the array is big.

Add a new iommu_copy_struct_from_full_user_array to copy the entire user
array at once. Update the existing iommu_copy_struct_from_user_array kdoc
accordingly.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 48 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2574fc8abaf2..11de66237eaa 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -493,7 +493,9 @@ static inline int __iommu_copy_struct_from_user_array(
  * @index: Index to the location in the array to copy user data from
  * @min_last: The last member of the data structure @kdst points in the
  *            initial version.
- * Return 0 for success, otherwise -error.
+ *
+ * Copy a single entry from a user array. Return 0 for success, otherwise
+ * -error.
  */
 #define iommu_copy_struct_from_user_array(kdst, user_array, data_type, index, \
 					  min_last)                           \
@@ -501,6 +503,50 @@ static inline int __iommu_copy_struct_from_user_array(
 		kdst, user_array, data_type, index, sizeof(*(kdst)),          \
 		offsetofend(typeof(*(kdst)), min_last))
 
+/**
+ * iommu_copy_struct_from_full_user_array - Copy iommu driver specific user
+ *         space data from an iommu_user_data_array
+ * @kdst: Pointer to an iommu driver specific user data that is defined in
+ *        include/uapi/linux/iommufd.h
+ * @kdst_entry_size: sizeof(*kdst)
+ * @user_array: Pointer to a struct iommu_user_data_array for a user space
+ *              array
+ * @data_type: The data type of the @kdst. Must match with @user_array->type
+ *
+ * Copy the entire user array. kdst must have room for kdst_entry_size *
+ * user_array->entry_num bytes. Return 0 for success, otherwise -error.
+ */
+static inline int
+iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
+				       struct iommu_user_data_array *user_array,
+				       unsigned int data_type)
+{
+	unsigned int i;
+	int ret;
+
+	if (user_array->type != data_type)
+		return -EINVAL;
+	if (!user_array->entry_num)
+		return -EINVAL;
+	if (likely(user_array->entry_len == kdst_entry_size)) {
+		if (copy_from_user(kdst, user_array->uptr,
+				   user_array->entry_num *
+					   user_array->entry_len))
+			return -EFAULT;
+	}
+
+	/* Copy item by item */
+	for (i = 0; i != user_array->entry_num; i++) {
+		ret = copy_struct_from_user(
+			kdst + kdst_entry_size * i, kdst_entry_size,
+			user_array->uptr + user_array->entry_len * i,
+			user_array->entry_len);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
-- 
2.43.0


