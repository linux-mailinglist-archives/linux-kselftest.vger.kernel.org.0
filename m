Return-Path: <linux-kselftest+bounces-34983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BC7AD9AB0
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16CAD7AF3EA
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C61B1FECA1;
	Sat, 14 Jun 2025 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="udxfB1zu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8FB1FCFF1;
	Sat, 14 Jun 2025 07:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885327; cv=fail; b=VG7BSgPdUarJKB/HkI7sMFzbRHXAyI8Xyiq6f07Bf2g11LoxE48vEo0XcWbQq0YkSQZAXAKSgZaGRjiw8TkZZLYaCjexgCUiNjxB0SIGqZ/ZhtxvCquhaQVhKpHVfT2nzwZc/4Q1ltliXIpSK5u417JwJwBCKhh7SqunSofQjqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885327; c=relaxed/simple;
	bh=hsG8ZMVj6yTbFVdXu4wEFEUaORUw48A6lAvWhtjQfyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjGNmyx2K1QkyLtzGirgJv2nO39nixNZWXuh6rThUax/lzeN8JRUQj2wFchgd1hmglR6WoaayV7ItBSGTU5QC9DWS60EdJe1dvyonuymfC2blIaE68mXP42ph/jkv85KftiMkx0SFj3dKS5kalqMVMBMJLKvG/RGH8oRKs7UUZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=udxfB1zu; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=os6Ct210grbYS3fTn2c/7NVrxE9KzjSkIlTZ3BNxvKQPwxI4csX8LIICmUZ2jM/9rONNWrOz+quMRcd6cbatrzyQYGYdToo36JccduA3Lw2XsylEbJ7G87ioI0CTDFG2Gk/7SVnRDu/ivOI/00kDP+4+MSYf77vFjs6AXirLfChoJ7LXrEz8GgokYLIMe3J3bk71gWef8p0QAC+PhXGZJ6Xtx44VU+RUPI6GkCVvmcySG1ipyoi/dg9afxET4aTmak+nq9RBfPec0Wf1/qjmAihHEn5yNMDfEDD/G6ZGSLA8Fiu1em0l1h6h2MB6yyKhAynCcKdWnNHKIs0jeUynjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yxN3/nHJvXd8q3GeP+mIb8u/VNslQDkLF0CAQEeY5k=;
 b=DF0fqz2agABxdLZLrZhxUQN5yHL72kDrQ12pS54ZRlabKwX36Rw4mQ8mAROMQTC+vHpLEaC6ebrGNrbAIDTMgPDtjaqbrSU1RFb7iECbV8QRb7qdFC/hYEgrfkWqI8SxMWGFnJzC0SskGL3aZ+Mq7ereRUVJwvLgDcb94ZC5PFOz68p1tntDh9m/ooS3V0LcLJAZSKNWntHlhJJUvw7EXdXffm40qKul47mqKdFga+s+euLk9EtJUVjvIrXuFssuZlQsTaD2DHZFk1qdiE5r7mdfc9TXFR0Mjyegh9yThF2Z99xujztfT/mU98mrsa/+yF76wJTxRuyal/u7oTzRqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yxN3/nHJvXd8q3GeP+mIb8u/VNslQDkLF0CAQEeY5k=;
 b=udxfB1zu8LfpMau1v6uOwDe4Zd5Qmj2AELwpdS45GOeXx3+wkdvYAqPY2KV+m1IhbdhoqLzHVxSkf+UTt+ifLWTNsimgy9VKY2hDBMItAgd9+IeEzRpbRGDImvcW5CBrRr/s/TasRESufD+kWsjHiUSu+CC2pzGDGcQPqEXim+0AKMOr9jF12aqu++G9KrvAlEssZyx/OsHo9EdNeX9VnsXclabzr3giH76DtgUyMLIadbkaQ8mJhUm1GT6InX0TOANjhTgKCrWK2llRknvYn+e68T3HFmvceEdwdWu6t6BiGgFxE05d2kk4tzsZjV2zQMV21KLMGOlX9Ld6QgmTTQ==
Received: from SJ0PR13CA0027.namprd13.prod.outlook.com (2603:10b6:a03:2c0::32)
 by LV8PR12MB9644.namprd12.prod.outlook.com (2603:10b6:408:296::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Sat, 14 Jun
 2025 07:15:22 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::1d) by SJ0PR13CA0027.outlook.office365.com
 (2603:10b6:a03:2c0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Sat,
 14 Jun 2025 07:15:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:08 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:15:06 -0700
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
Subject: [PATCH v6 06/25] iommufd/access: Allow access->ops to be NULL for internal use
Date: Sat, 14 Jun 2025 00:14:31 -0700
Message-ID: <e6a989c4dd9cb94aa4a98d46ed56a2afcb41b70d.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|LV8PR12MB9644:EE_
X-MS-Office365-Filtering-Correlation-Id: 976eefe7-1144-4b8a-2cbf-08ddab1339ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yT1F0rvUa/tVex+OvxSESqG3fpYcnLk3pYSR8Sqb1Z8ukQxfUOkUFSWTFEiL?=
 =?us-ascii?Q?OwUT1VajZU9OTSWk9yOnEPvqF6FRbHjs0dwBcjA+9xOut5nuEK9QhD6zdv1t?=
 =?us-ascii?Q?MrUXfcZQhG4YyEIkD0oishLWDyYH08o5COdLoeK73BKvzTRzpYjNTrvmuJmS?=
 =?us-ascii?Q?mk0kasQh4CvMe1RohpogBkru4RPAx9q/6xnDnOiD05S17e86KHriIamj6Rgr?=
 =?us-ascii?Q?LGXjap7Jlk5TeKvXfg7TG6z9PMTOhuk9AitLwDRlYtpTzy1yxyLrVuKaiT9j?=
 =?us-ascii?Q?iaefUA0EzBA5z+KMcEe/Hr3WSrNWzsKja8mtosUzBPUHF6FI8h4NwrgOjIA/?=
 =?us-ascii?Q?QoLvgP7f1rRkVTlZu1ShBpZzQorfoMMp/xTXOCIZEh5EuLH133uT/Cv8WHm8?=
 =?us-ascii?Q?WuZBrL8ax4A9+tePswMtp22ZbfBCqzv1Ialja0fs3MM9LTgFe20qjH62iMm0?=
 =?us-ascii?Q?7ytFurtXEURDZ9fTCP7knG43zF4zQOTlJLXiIFvyVuznLI8h5kA5i+iGFzI5?=
 =?us-ascii?Q?N2gWFq98Mp8hq8pE6XPwW+m3zdbus6ZUHaClMhEXZn409EDHcECPXr7qFFiB?=
 =?us-ascii?Q?P6XjT7+LuCpcKPI6mGWTGn4Yni7mKOOotrVlPhTq38AqA0guGlab5d5l21EY?=
 =?us-ascii?Q?q80mUFV/Go08XZl45ZeLpqMBTKjuorhSEdjM3WHtUPlhnbPkSCWK3FnnsU70?=
 =?us-ascii?Q?zYUOButlIB9jDpzBndZ9x3EDA24CdcsckzvzhtGmxYfUqNwkZ2/l3h/LJBIk?=
 =?us-ascii?Q?WcDiHWLKhLwMT4bFH137DBddC8khCROy2+Yi04d05FztkMjfHrtD+J0lcpuO?=
 =?us-ascii?Q?QtKz8Bf3z5NH+OJOspShjDDdzhGhbI1VBidWKRMIqhYHQvnAx+gK6ldIR0hg?=
 =?us-ascii?Q?1HlOfbgI+qz4/4r1oZxDiefS5fP9YeAZhzoA0mAQm6y1duF5Naa2UqsIzpnO?=
 =?us-ascii?Q?mQY6+s5VTqfu4WpMHVTaE0DToW2LvdgNPUo0T8pJKJnW77k/Q++1vPEb9u45?=
 =?us-ascii?Q?RUGJZVk0M2ke2Sn5b+Xn2cQETIySh4R9lH2ZpdR/5YZw3D+zjmc99VWwyN/W?=
 =?us-ascii?Q?dqxH/V2qJcn5rEYQC6XfdhAZKnm0iOJzxHkdP2Ym+YBdkatVS0uULzesV4ok?=
 =?us-ascii?Q?o6dclmN54JlN2Z2VK2mP2B9NIwKlKnI2FnAKawuyknzEvY72iMIj5Hs1iwf+?=
 =?us-ascii?Q?PjZYgUjsEox56RQbq2fXleRNwHz0V+I55xiZ9w5qlZ/YS7y8hkDrv1ADPNja?=
 =?us-ascii?Q?VD6JUjicIOi1hml2QcF5Qlgx1c3aSSz2Y0LDAZBUD/YaS/TrbwO+Grac4XtK?=
 =?us-ascii?Q?4oBhg63/fwJXm7MQJ+WP2E86dT47b7gCBCotLTEKrNJT5Gr9M8HLKGDGP4J3?=
 =?us-ascii?Q?OivhSHNcSoT/qvGWYuplnDZsmtcP0Lr7EjSStRDYtxLiPX6xP83YgyjwvdGn?=
 =?us-ascii?Q?+pQR/PjNavKOI+C4X6JkGVqgNMXRTQvd9R2trPQQVfUhZfRL92pAVSSM2rKv?=
 =?us-ascii?Q?YxiPNa2dGo7KjqMOgvzpxKJOt5eF821QisAp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:22.0100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 976eefe7-1144-4b8a-2cbf-08ddab1339ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9644

The access object has been used externally by VFIO mdev devices, allowing
them to pin/unpin physical pages (via needs_pin_pages). Meanwhile, a racy
unmap can occur in this case, so these devices usually implement an unmap
handler, invoked by iommufd_access_notify_unmap().

The new HW queue object will need the same pin/unpin feature, although it
(unlike the mdev case) wants to reject any unmap attempt, during its life
cycle.

To reuse the access object for the new HW queue, allow its access->ops to
be NULL. Error out a NULL access->ops in iommufd_access_notify_unmap() to
reject an unmap operation and propagatethe errno upwards.

Then, update iommufd_access_change_ioas() and iommufd_access_pin_pages(),
to allow this new use case.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  4 ++--
 drivers/iommu/iommufd/device.c          | 15 +++++++++++----
 drivers/iommu/iommufd/io_pagetable.c    | 17 ++++++++++++++---
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 4f5e8cd99c96..4a375a8c9216 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -111,8 +111,8 @@ int iopt_read_and_clear_dirty_data(struct io_pagetable *iopt,
 int iopt_set_dirty_tracking(struct io_pagetable *iopt,
 			    struct iommu_domain *domain, bool enable);
 
-void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
-				 unsigned long length);
+int iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
+				unsigned long length);
 int iopt_table_add_domain(struct io_pagetable *iopt,
 			  struct iommu_domain *domain);
 void iopt_table_remove_domain(struct io_pagetable *iopt,
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index e9b6ca47095c..9293722b9cff 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1048,7 +1048,7 @@ static int iommufd_access_change_ioas(struct iommufd_access *access,
 	}
 
 	if (cur_ioas) {
-		if (access->ops->unmap) {
+		if (access->ops && access->ops->unmap) {
 			mutex_unlock(&access->ioas_lock);
 			access->ops->unmap(access->data, 0, ULONG_MAX);
 			mutex_lock(&access->ioas_lock);
@@ -1204,16 +1204,21 @@ EXPORT_SYMBOL_NS_GPL(iommufd_access_replace, "IOMMUFD");
  * run in the future. Due to this a driver must not create locking that prevents
  * unmap to complete while iommufd_access_destroy() is running.
  */
-void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
-				 unsigned long length)
+int iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
+				unsigned long length)
 {
 	struct iommufd_ioas *ioas =
 		container_of(iopt, struct iommufd_ioas, iopt);
 	struct iommufd_access *access;
 	unsigned long index;
+	int ret = 0;
 
 	xa_lock(&ioas->iopt.access_list);
 	xa_for_each(&ioas->iopt.access_list, index, access) {
+		if (!access->ops || !access->ops->unmap) {
+			ret = -EBUSY;
+			goto unlock;
+		}
 		if (!iommufd_lock_obj(&access->obj))
 			continue;
 		xa_unlock(&ioas->iopt.access_list);
@@ -1223,7 +1228,9 @@ void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
 		iommufd_put_object(access->ictx, &access->obj);
 		xa_lock(&ioas->iopt.access_list);
 	}
+unlock:
 	xa_unlock(&ioas->iopt.access_list);
+	return ret;
 }
 
 /**
@@ -1321,7 +1328,7 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 
 	/* Driver's ops don't support pin_pages */
 	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
-	    WARN_ON(access->iova_alignment != PAGE_SIZE || !access->ops->unmap))
+	    WARN_ON(access->iova_alignment != PAGE_SIZE))
 		return -EINVAL;
 
 	if (!length)
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 13d010f19ed1..6b8477b1f94b 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -740,11 +740,21 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 			up_write(&iopt->iova_rwsem);
 			up_read(&iopt->domains_rwsem);
 
-			iommufd_access_notify_unmap(iopt, area_first, length);
+			rc = iommufd_access_notify_unmap(iopt, area_first,
+							 length);
+			if (rc) {
+				down_read(&iopt->domains_rwsem);
+				down_write(&iopt->iova_rwsem);
+				area->prevent_access = false;
+				goto out_unlock_iova;
+			}
+
 			/* Something is not responding to unmap requests. */
 			tries++;
-			if (WARN_ON(tries > 100))
-				return -EDEADLOCK;
+			if (WARN_ON(tries > 100)) {
+				rc = -EDEADLOCK;
+				goto out_unmapped;
+			}
 			goto again;
 		}
 
@@ -766,6 +776,7 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 out_unlock_iova:
 	up_write(&iopt->iova_rwsem);
 	up_read(&iopt->domains_rwsem);
+out_unmapped:
 	if (unmapped)
 		*unmapped = unmapped_bytes;
 	return rc;
-- 
2.43.0


