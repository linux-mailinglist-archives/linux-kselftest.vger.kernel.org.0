Return-Path: <linux-kselftest+bounces-30508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A28A85444
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 08:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109E919E6CE0
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 06:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3768727F4D5;
	Fri, 11 Apr 2025 06:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e+gn4Uw5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C106027EC79;
	Fri, 11 Apr 2025 06:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353518; cv=fail; b=q6ac7GyVwnhA2Orx+8LyRJbAI/20BXuZJj2KN/7h4tDKX+xse/JjsMJKrWcIoSc3G1W6E74+rQu3JgnCu3tah5v/zNktztUJPjAo0uWVwKqSkAgL3PYWNTuM5S8/YfPCwPDkdRHX8hnez0/hTaZaGCeZk+aPJmVCNsNQtikpIJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353518; c=relaxed/simple;
	bh=iAoXGDtUkQqoJcZpgz+LDLyFRsCQVlR2wQx9JNjNgRg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOwZQTHROpbRR8eIEfg/yXVlb1Pbci68BylHnaW1J0YwzSRL+Xhb/fdVSsIWNCczUkSN/zCXg/UoXfIfNXoegz3LOou6SmNBbvl1/9WZUMyGAr/QzsX/heOyOS+Rdq7ckIDqiJUBa1c+MMPzg7EydAJR+VDfJj5SE9bV4cnNc/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e+gn4Uw5; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQW0ovYGgCKdVs4tVT/RBXGNTpDYgVqudXyg8uWolxvvrxBf4InjCWQ6IEPkVNqlKhr8aeIaqDgoOKj25t7UNTPxpTPiDQiTFDoWYl0IGL9eAPBvq3YPLBbwsAoBaVFWAtPwuaC4sASLlF3J7vVq51gaoxeXc5OXfq0/vgRT05MoDpPSCoyLPHYjCS7drF1SNqeoXGH5TNN5pJ8Mp5/rxffH9e9MpESfaLnQIaKxW7RAoad+YDHA/5eK089e8dg11GSERSxXX6Ixqprak52LL9gnrqHpQX9XpG+6/u9xn3Vs0CuFi66sswR8hbAKUx3/GJmRYwjhqC5n30dTsicutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFqcBr+ohlPqHDyftPMeCDzZYNoO5ZhtxFwVVEwdyrI=;
 b=nPoFtv9tut4Z4rKzy6dEbu0Tzcg39o9ngRCDpZ3Irmy4/IBLcJWgkoEtNB3bqf1pOUF2Lxs7j7OQ7mgQ/uKRH7KDpFfQfrqSFPOCRfuh9INJ6pvFGRJ0LbAUBTSB85Li+wJHbkmqDfJ0Vrt+O1LZjSIdCbQTqh069+Rr1gsaVmnzDDzBriSakRggh+GNzqQTfTlGDWIJki0Xq7pdEy1BTjGYMGjRbD478mQ1zGa470XejfH5eN8rEX5S6dYw/qLI3wtzL6UOvrdXBf6A07ar7YApq4s83EZvESt8QPIDyPgGb48OJ3uAywqyh/HL9NgcJWPM7vQ8ru+4OResOlAcYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFqcBr+ohlPqHDyftPMeCDzZYNoO5ZhtxFwVVEwdyrI=;
 b=e+gn4Uw5OYPBD8bi9X3GgPwZbfQftKwZ+EHgaVWh/4aCNp3L6dmoEVdOS5Au0LWfFnpg0kMoE72So4C4eh1T7EOkC73wFHStOBs4u4X6xVV9ZF94hrmtFj0Op2CGZ+ptoqyWb9w4g9YkBXTqYY62/G2H0V6rZVTkhPJfRlcGtzGvZ3HqmSriTmTBhRfyKTMkj/UIDxEtQBMu7IQ9tzgcL5WcyqUTq06QGltM/kn4Gmg+Zoduciz0gMjvJi0MF1TpAiSOKRQoLHSF69ttloczryBFCplptCWwG3Zb5qC2jm4f7DGD6zbv6MDOqy2Eou0WGSSmyic6YQiAmUaZl4pCng==
Received: from SJ0PR05CA0078.namprd05.prod.outlook.com (2603:10b6:a03:332::23)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.26; Fri, 11 Apr
 2025 06:38:30 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::db) by SJ0PR05CA0078.outlook.office365.com
 (2603:10b6:a03:332::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.10 via Frontend Transport; Fri,
 11 Apr 2025 06:38:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 06:38:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 23:38:20 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Apr
 2025 23:38:20 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 23:38:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<praan@google.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <jsnitsel@redhat.com>, <mshavit@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH v1 08/16] iommufd/viommu: Introduce IOMMUFD_OBJ_VCMDQ and its related struct
Date: Thu, 10 Apr 2025 23:37:47 -0700
Message-ID: <db035b1fad8987558b5c435ad7f9350ffa34aa1e.1744353300.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744353300.git.nicolinc@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: caacb0d9-7c6f-42d4-823c-08dd78c378e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?otpnm5mxH5aD+0zH105jKLZMGgLU2V6qORpPLA9ZcvjxmvD8nexT7AucQ9E7?=
 =?us-ascii?Q?dN3Kij7kqNkpRanPd00SE/zXwbIHdG9A91x3b9/D6SZNbhbeZ63Vf7h0yn6M?=
 =?us-ascii?Q?rST5vuY7Hgh2L5Xa60Gp+ajilNzOByhMsS6Pe+Iob3maFsQzuLVh5W7XRQlW?=
 =?us-ascii?Q?4GgABYHfIQaKs2w5KrtEvDwAiACU1FmSZEZq8SBkxJMmpA+yO9hpCK5Rp1vV?=
 =?us-ascii?Q?2N8bUF7xL355WTdQQcL42PB39AWWUyE54jKkfRMPqPZ/xKqdWwlQiAfJ46Gu?=
 =?us-ascii?Q?828XBaDmk3tj7UrmnCeFqhV5Tqav3oj4F4b5iv8ictA8zVc/9ZLRFPXNMW9v?=
 =?us-ascii?Q?ZNID/I3JOZz9mODbHbJRBGcKF7wUxhO97X3JU2TxBXjlaXaUXfV44nqIIpjI?=
 =?us-ascii?Q?RgIxBUmKtTvUbW/1arlvKSflW2whEIluD+qEzKPM0X8y6mXFS3MLiZ/ZzBI1?=
 =?us-ascii?Q?0t5h5DmjTpldnH3jWFxltMSOby0AtJRhmwV03BB46nVNIHPsODpxz2iGDyEQ?=
 =?us-ascii?Q?js0joiuH6E3MdRXotEDmqVm+vGUaldVsK4zwhNwZPk6lVtpeVFnncZTK5qWB?=
 =?us-ascii?Q?MicZSoYFdqDNt4VL9Enbrt6jmsdOLeijK4A6JhHdgtPaAG5ycXWlfxfyup4o?=
 =?us-ascii?Q?Xm/g9oy7Qb28LILlUri4b2neEeCfQW6rtkHmXRPFgyWZZIts1GI2yqyFt2Su?=
 =?us-ascii?Q?ajkn16vXLVRV5gC/4w8w/avicELJM1I9LIrmbldf6pKdRKGeC3OYZ/aE6lOA?=
 =?us-ascii?Q?vWkfFuwBBubnEYEMWue9glxLkO8qEt9Djh3MG/IZdhiFIlqwWQ2fo2eQj3w1?=
 =?us-ascii?Q?CUv+MLCgEZpMj4TRrOBd152DDOILdZUdQ3dAwYC4nqsRaWiQLrxKkVkfvUdX?=
 =?us-ascii?Q?sIr+OwjSJkX4UDlk2ak9Me0TCeJdbvJ482fXiez1WJxeMrSeWG61twzrZpm0?=
 =?us-ascii?Q?LJjUXvo/QspCEbaAiXG5AZF3DcbgOHB6+VqfyVimc6slry3LOqiVxgd6m3jl?=
 =?us-ascii?Q?1ZriymiprW7m31Lkqds5k9cQa/ub8ivuWCBlCmRlQsP3Z6r7AzCQA0k8IVq3?=
 =?us-ascii?Q?HPhyfVfqEvab3DtwmxZHv2t7xiPbnO5W+/asExw1QFYHcdyj/uBpIqFe0sCV?=
 =?us-ascii?Q?zpSo8frZ53S7FkPC7DySXbZJzIN4LsYmY4jcT/DU1pycYgpIWE499XamJs6/?=
 =?us-ascii?Q?S1aGMwMGbJaEvIPwyqtXAiP5Iv9rl0u0tP9KCWgzfPnx+AJTuSvkCkx8y/am?=
 =?us-ascii?Q?lmyfOeZBkwfENk9VIeIOY12I3hlsNXAA5ODLk887VPOvuD0JGa++tG3wcKJT?=
 =?us-ascii?Q?nwy1kGNDdwQC+L9dedIat6I9wPJeqUYDzmEuBaVqnuVPsTIv+PsRbxOMkj1x?=
 =?us-ascii?Q?GuzSI5ijkhoe5KvRw13+Zk7I3Y3mFYqBxV3Azi+0kr/7NYvpZ6MmeqO9XypU?=
 =?us-ascii?Q?R2NKN5jjsQcmO1cp5hflKjsLk3GRDdi7o03ei2pyj+66wb9SvnUfzkdozJLQ?=
 =?us-ascii?Q?p0+m7bHqLRSZRnookte5/jxb5pSi59MHxNwP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:38:29.8116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caacb0d9-7c6f-42d4-823c-08dd78c378e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760

Add a new IOMMUFD_OBJ_VCMDQ with an iommufd_vcmdq structure, representing
a command queue type of physical HW passed to or shared with a user space
VM. This vCMDQQ object, is a subset of vIOMMU virtualization resources of
a physical IOMMU's, such as:
 - NVIDIA's virtual command queue
 - AMD vIOMMU's command buffer

Inroduce a struct iommufd_vcmdq and its allocator iommufd_vcmdq_alloc().
Also, add a pair of viommu ops for iommufd to forward user space ioctls to
IOMMU drivers.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index df7a25117e3b..4118eaece1a5 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -37,6 +37,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_VIOMMU,
 	IOMMUFD_OBJ_VDEVICE,
 	IOMMUFD_OBJ_VEVENTQ,
+	IOMMUFD_OBJ_VCMDQ,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -112,6 +113,12 @@ struct iommufd_vdevice {
 	u64 id; /* per-vIOMMU virtual ID */
 };
 
+struct iommufd_vcmdq {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommufd_viommu *viommu;
+};
+
 /**
  * struct iommufd_viommu_ops - vIOMMU specific operations
  * @destroy: Clean up all driver-specific parts of an iommufd_viommu. The memory
@@ -134,6 +141,11 @@ struct iommufd_vdevice {
  * @vdevice_destroy: Clean up all driver-specific parts of an iommufd_vdevice. The
  *                   memory of the vDEVICE will be free-ed by iommufd core after
  *                   calling this op
+ * @vcmdq_alloc: Allocate an iommufd_vcmdq as a user space command queue for a
+ *               @viommu instance. Queue specific @user_data must be defined in
+ *               the include/uapi/linux/iommufd.h header.
+ * @vcmdq_free: Free all driver-specific parts of an iommufd_vcmdq. The memory
+ *              of the iommufd_vcmdq will be free-ed by iommufd core
  */
 struct iommufd_viommu_ops {
 	void (*destroy)(struct iommufd_viommu *viommu);
@@ -145,6 +157,10 @@ struct iommufd_viommu_ops {
 	struct iommufd_vdevice *(*vdevice_alloc)(struct iommufd_viommu *viommu,
 						 struct device *dev, u64 id);
 	void (*vdevice_destroy)(struct iommufd_vdevice *vdev);
+	struct iommufd_vcmdq *(*vcmdq_alloc)(
+		struct iommufd_viommu *viommu,
+		const struct iommu_user_data *user_data);
+	void (*vcmdq_free)(struct iommufd_vcmdq *vcmdq);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
@@ -284,6 +300,21 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		ret;                                                           \
 	})
 
+#define iommufd_vcmdq_alloc(viommu, drv_struct, member)                        \
+	({                                                                     \
+		drv_struct *ret;                                               \
+									       \
+		static_assert(__same_type(struct iommufd_viommu, *viommu));    \
+		static_assert(__same_type(struct iommufd_vcmdq,                \
+					  ((drv_struct *)NULL)->member));      \
+		static_assert(offsetof(drv_struct, member.obj) == 0);          \
+		ret = (drv_struct *)_iommufd_object_alloc(                     \
+			viommu->ictx, sizeof(drv_struct), IOMMUFD_OBJ_VCMDQ);  \
+		if (!IS_ERR(ret))                                              \
+			ret->member.viommu = viommu;                           \
+		ret;                                                           \
+	})
+
 /* Helper for IOMMU driver to destroy structures created by allocators above */
 #define iommufd_struct_destroy(ictx, drv_struct, member)                       \
 	({                                                                     \
-- 
2.43.0


