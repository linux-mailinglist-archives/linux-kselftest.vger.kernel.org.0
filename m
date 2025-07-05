Return-Path: <linux-kselftest+bounces-36623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC177AF9D55
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6388E3A3D96
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B638E20DD49;
	Sat,  5 Jul 2025 01:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CQodrWn5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4652F20012B;
	Sat,  5 Jul 2025 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678069; cv=fail; b=gzkvn8DTKOoN/8xgJRT7wbGmzgVsPRocG/gL6/37vCnHvEplcEG04UizmLrTgU2ZRGWiY/gBWTFTLyTk4n6lOQVOZa66UJ8cHFfIoaO2kHW9wM8cX0noMs+t8C8D0pOXOXQL2YTRhhpwTUFvoV/Kl0OWUa5lbibHv1lXCbpiTOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678069; c=relaxed/simple;
	bh=AVAw1tR7SIjY37gcgPHwyuxL/Ua8i1gmzlgZQsAK+j4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OrYpcNWxLPBF5Po7v/FuhuaY/aXg38/+2Rdb73oLKhaunzzQpwTL79+8K2wg+jyGHHs0pKxs0rv+DL52XbdoRpe9FRQqAM/0jobnovYmpSxZl6WOYNexvGMsCBja7MbEKwGAaV0M++uu/iv2pJS2UFeuszrB0ZMgqvkogiZOGtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CQodrWn5; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdNiilQe2wNJVV1ooVHo4iXz20OZDqiokU+OzrZDP3PFuIo6umJMEK29YMsqiiuujXgb9WTH4rm82Zzprstz+uqMQrAUPZf/gCxMCiXNlem8J6MYXRa1kZc+4TnpqM18iaYlhA8Z5gUHqphj7a1tDexVZR+Bh4cav1WBboUCZGKdRBVqkSUImTWgGCZ5jme0Paj6WpCy9Oy29k8nKiTlhcilmoE61fC/P327lqmcXZAqztTWki6gu21A9uErLotzAh/1HD/fZqD09MuSvh5XgTFovtFVhFtPvGORqSUFNjNHH4sEHqZIkWDmShBvurZ/0hhcD+uga7mT9m+NDEiGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dklKg9uUrRmd/WIlyI6ryPma5hxpkYfODl1wQgGp6SA=;
 b=Ih7PSJ26sZAlVDEcaCurJ0VCKBPEzr8uCicX1bHp1hbYa2aHbErS7Hei5QmOy/CB0thoCDmlt/kodN5rGhh/xEQxJ57N1jhU4NihXcQXHKjKeICkoVvu1g3HVhtiBdYVc1jxU3+EE6EHCt7cn1eYrqNS+5qZjMsjzpwksUm9UWtv+INeR5JuqJnHWmXrEEF7wB8h3UpmX9xMS0Dtb6ZChD9d+2LvhQM4J+OuHc4zUHDznOCjmIQXjm0TZSsrB+b8BzN3cml/Z5iPcBXE8xe9cLNYvDM/aRyRQRCnpCrCLxetvjyJfZC1Xwv1p4tHETBXwfQziLt0i1LmubLDZCtVwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dklKg9uUrRmd/WIlyI6ryPma5hxpkYfODl1wQgGp6SA=;
 b=CQodrWn5NC1KiEeFcV5wwtjCz1M9xaFmqkVgIQRPnscjY8tCK5PX9M/IcWeS81UZa1WD097luZ3y3bqGVNZw1OxG+sJ6RKJQ8Lv+AEQgIgJO1U7mpImX8EW2ajglnxGcxn0bpCLOoaEC7aJ226Ccpde6Q8QFXypPT2s76wpykSiY9moZTboPm4IlEKMiQXA40RpCLBFNPgDUmtx70Q7RXPzDpxzeJVucJDWTdt5K61364F1S03e5ogJh+vADNhhqz+EC6vYhScreCG7XlysSt9rDCrd1BwXcBZT6IKTJ1U2L6atYt/Nw3SDrcfVPzM9xUyhEZNh6LwmgnMFEBhVDFQ==
Received: from SJ0PR03CA0088.namprd03.prod.outlook.com (2603:10b6:a03:331::33)
 by SA1PR12MB6946.namprd12.prod.outlook.com (2603:10b6:806:24d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Sat, 5 Jul
 2025 01:14:21 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::68) by SJ0PR03CA0088.outlook.office365.com
 (2603:10b6:a03:331::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.24 via Frontend Transport; Sat,
 5 Jul 2025 01:14:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:14:21 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:12 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:12 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:11 -0700
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
Subject: [PATCH v8 11/29] iommufd/access: Bypass access->ops->unmap for internal use
Date: Fri, 4 Jul 2025 18:13:27 -0700
Message-ID: <820ae86e5455be2cac480d941e9ab7e29b206402.1751677708.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751677708.git.nicolinc@nvidia.com>
References: <cover.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|SA1PR12MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: f25aafec-8c69-45dd-6427-08ddbb6145ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+xgw5QwucnPW/s4OIshB5PnRJrbG5JvKtg2vYdmjGM0nev1zZ6QwUjPr1YBa?=
 =?us-ascii?Q?Lcypk38wSfLFOQ8tgh/fNzbFNsZzV/YkWICiIWBe0Ehr0lpB2NOvdUoiK6CK?=
 =?us-ascii?Q?094NvCFmQUmt+qY3b3Od7pX75KAS8r1lVqNmcjqKZg2pjph42kLRionncctU?=
 =?us-ascii?Q?1CmH5rhOoTwPuNDKz5GXz/N5NiNeiw5PttlJidEoQpHutnThBMOgTlWZFUUq?=
 =?us-ascii?Q?rtW5zDcLvtkNWZwEdH7Z2YUkW7n2hRYXp3M9URtt3UUyc0870KirP+KEwqjB?=
 =?us-ascii?Q?RBCvDLOjeBAZG/ps2Puwig6mOs3ftxCL1UWYvUSIC2hkHemCgDFH1Fzx3nf7?=
 =?us-ascii?Q?H/KyizVab4txFUUflyfY1uaol4JDlvMQPN7lvITa4b5vcLXSjgxl6hcV6PpV?=
 =?us-ascii?Q?D7U0+uG40vGuJSVt8QBGjAx5BQBufNcMcN0vYjUYdP51n2PoyGy0abrv/0cH?=
 =?us-ascii?Q?i0x4bzv1XAJfDNC3skR8cQn2HstN3ZaKsHtQyYovFQ7bEVKw83berdOdNoRH?=
 =?us-ascii?Q?vI6Pp3WEk8zUKNSHxPqg88hlc7bBRnI8KRaQnuKgfPU2lXW6zZNDB14C/5tF?=
 =?us-ascii?Q?WLtYTZfV7wrLs7+UgaYXjzyBsCOzBiW2BjO2FVJFV/V9BDPe03oT3X6HzebK?=
 =?us-ascii?Q?7tN9t62GoH7oT4phapMIRtCcGxecyxxc+bXZaoVQr67lfU66O9RvDteMaDGY?=
 =?us-ascii?Q?tIbhe5IeELvA38GYl8cjrOJp+Sp0VMZj7lZfsIsvbjwHcqbsq1ZP049yslQZ?=
 =?us-ascii?Q?sWYRHbvwc6yMo2fqLIjDfC1k+Tc89UvIeYmQFS7zZKySHw7imoJWOJTE+Vau?=
 =?us-ascii?Q?scs26btrWugceWGW3s9TxEWUpvGDFcUTlfbKDlZsgJcMMH7HmmUD6Y5rKTuQ?=
 =?us-ascii?Q?lZJ9uIzCD+slceEKFUX2yQpTmiF/HZLWlqacKwjjReGhRNLour0Esp2NEld9?=
 =?us-ascii?Q?30HRMaxuqpf2FTRYRk4yz0lB2fPPyMDv0a1bDzqne/GvyqF9/9w48UfHzuWl?=
 =?us-ascii?Q?nu5ivq9LcMDTdxzGJF+zVQV/kS9xRqo9paFvP5vqQ0kWzdldL1vLvQfpmCa5?=
 =?us-ascii?Q?sCgNSWgCPumvGZSTM+MD7L4uTDJsFHZowEVYndwzj+9KvDn5RtHK32wpO8i5?=
 =?us-ascii?Q?jzopPDjZTFBvf+CWXSebpNJtDIM7uiJEmiOmHoAK0kP/uhBJGJVuS5aevcAY?=
 =?us-ascii?Q?LoBYnZ47fJ/YlLhIDX9EpvKuiJ6E15VS0UZtyiDCqxpqNZ4tJJMcqX3xHvYt?=
 =?us-ascii?Q?V25vuhUAlHnrFszVI4RfHlEvcvAN6hpmep+gPbJnX8lKef4fAyOhv/4NgQ/W?=
 =?us-ascii?Q?9gKv1q7vQLkH4ZhI5hQ7tllBFBncKNXKuJdvz8gwJbdeJdBjOfuSgGYwgtj7?=
 =?us-ascii?Q?qLc/bRrXUZUPM8+qY5WYIcNZezDPcU3M+6QcwKCrhuu8c0wDHYILbk9o82Xm?=
 =?us-ascii?Q?sP5uDLL5TjMHJAEz0hsBnIVIrHtL1X5Qnp8jl4WZCiBOJzTK0AO2UzHrjPH/?=
 =?us-ascii?Q?XrBWew2z/3bHaV0IndzaelfZwkA+8c2UJFk4?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:21.1088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f25aafec-8c69-45dd-6427-08ddbb6145ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6946

The access object has been used externally by VFIO mdev devices, allowing
them to pin/unpin physical pages (via needs_pin_pages). Meanwhile, a racy
unmap can occur in this case, so these devices usually implement an unmap
handler, invoked by iommufd_access_notify_unmap().

The new HW queue object will need the same pin/unpin feature, although it
(unlike the mdev case) wants to reject any unmap attempt, during its life
cycle. Instead, it would not implement an unmap handler. Thus, bypass any
access->ops->unmap access call when the access is marked as internal.

Also, an area being pinned by an internal access should reject any unmap
request. This cannot be done inside iommufd_access_notify_unmap() as it's
a per-iopt action. Add a "num_locks" counter in the struct iopt_area, set
that in iopt_area_add_access() when the caller is an internal access.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.h |  5 +++--
 drivers/iommu/iommufd/device.c       | 18 ++++++++++++------
 drivers/iommu/iommufd/io_pagetable.c |  6 ++++++
 drivers/iommu/iommufd/pages.c        | 12 ++++++++++--
 4 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index c115a51d9384..b6064f4ce4af 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -48,6 +48,7 @@ struct iopt_area {
 	int iommu_prot;
 	bool prevent_access : 1;
 	unsigned int num_accesses;
+	unsigned int num_locks;
 };
 
 struct iopt_allowed {
@@ -238,9 +239,9 @@ void iopt_pages_unfill_xarray(struct iopt_pages *pages, unsigned long start,
 
 int iopt_area_add_access(struct iopt_area *area, unsigned long start,
 			 unsigned long last, struct page **out_pages,
-			 unsigned int flags);
+			 unsigned int flags, bool lock_area);
 void iopt_area_remove_access(struct iopt_area *area, unsigned long start,
-			     unsigned long last);
+			     unsigned long last, bool unlock_area);
 int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
 			 void *data, unsigned long length, unsigned int flags);
 
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 07a4ff753c12..0567faff5680 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1048,7 +1048,7 @@ static int iommufd_access_change_ioas(struct iommufd_access *access,
 	}
 
 	if (cur_ioas) {
-		if (access->ops->unmap) {
+		if (!iommufd_access_is_internal(access) && access->ops->unmap) {
 			mutex_unlock(&access->ioas_lock);
 			access->ops->unmap(access->data, 0, ULONG_MAX);
 			mutex_lock(&access->ioas_lock);
@@ -1255,7 +1255,8 @@ void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
 
 	xa_lock(&ioas->iopt.access_list);
 	xa_for_each(&ioas->iopt.access_list, index, access) {
-		if (!iommufd_lock_obj(&access->obj))
+		if (!iommufd_lock_obj(&access->obj) ||
+		    iommufd_access_is_internal(access))
 			continue;
 		xa_unlock(&ioas->iopt.access_list);
 
@@ -1279,6 +1280,7 @@ void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
 void iommufd_access_unpin_pages(struct iommufd_access *access,
 				unsigned long iova, unsigned long length)
 {
+	bool internal = iommufd_access_is_internal(access);
 	struct iopt_area_contig_iter iter;
 	struct io_pagetable *iopt;
 	unsigned long last_iova;
@@ -1305,7 +1307,8 @@ void iommufd_access_unpin_pages(struct iommufd_access *access,
 			area, iopt_area_iova_to_index(area, iter.cur_iova),
 			iopt_area_iova_to_index(
 				area,
-				min(last_iova, iopt_area_last_iova(area))));
+				min(last_iova, iopt_area_last_iova(area))),
+			internal);
 	WARN_ON(!iopt_area_contig_done(&iter));
 	up_read(&iopt->iova_rwsem);
 	mutex_unlock(&access->ioas_lock);
@@ -1354,6 +1357,7 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 			     unsigned long length, struct page **out_pages,
 			     unsigned int flags)
 {
+	bool internal = iommufd_access_is_internal(access);
 	struct iopt_area_contig_iter iter;
 	struct io_pagetable *iopt;
 	unsigned long last_iova;
@@ -1362,7 +1366,8 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 
 	/* Driver's ops don't support pin_pages */
 	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
-	    WARN_ON(access->iova_alignment != PAGE_SIZE || !access->ops->unmap))
+	    WARN_ON(access->iova_alignment != PAGE_SIZE ||
+		    (!internal && !access->ops->unmap)))
 		return -EINVAL;
 
 	if (!length)
@@ -1396,7 +1401,7 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 		}
 
 		rc = iopt_area_add_access(area, index, last_index, out_pages,
-					  flags);
+					  flags, internal);
 		if (rc)
 			goto err_remove;
 		out_pages += last_index - index + 1;
@@ -1419,7 +1424,8 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 				iopt_area_iova_to_index(area, iter.cur_iova),
 				iopt_area_iova_to_index(
 					area, min(last_iova,
-						  iopt_area_last_iova(area))));
+						  iopt_area_last_iova(area))),
+				internal);
 	}
 	up_read(&iopt->iova_rwsem);
 	mutex_unlock(&access->ioas_lock);
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 22fc3a12109f..abf4aadca96c 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -719,6 +719,12 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 			goto out_unlock_iova;
 		}
 
+		/* The area is locked by an object that has not been destroyed */
+		if (area->num_locks) {
+			rc = -EBUSY;
+			goto out_unlock_iova;
+		}
+
 		if (area_first < start || area_last > last) {
 			rc = -ENOENT;
 			goto out_unlock_iova;
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index cbdde642d2af..301c232462bd 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -2111,7 +2111,7 @@ iopt_pages_get_exact_access(struct iopt_pages *pages, unsigned long index,
  */
 int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
 			 unsigned long last_index, struct page **out_pages,
-			 unsigned int flags)
+			 unsigned int flags, bool lock_area)
 {
 	struct iopt_pages *pages = area->pages;
 	struct iopt_pages_access *access;
@@ -2124,6 +2124,8 @@ int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
 	access = iopt_pages_get_exact_access(pages, start_index, last_index);
 	if (access) {
 		area->num_accesses++;
+		if (lock_area)
+			area->num_locks++;
 		access->users++;
 		iopt_pages_fill_from_xarray(pages, start_index, last_index,
 					    out_pages);
@@ -2145,6 +2147,8 @@ int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
 	access->node.last = last_index;
 	access->users = 1;
 	area->num_accesses++;
+	if (lock_area)
+		area->num_locks++;
 	interval_tree_insert(&access->node, &pages->access_itree);
 	mutex_unlock(&pages->mutex);
 	return 0;
@@ -2166,7 +2170,7 @@ int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
  * must stop using the PFNs before calling this.
  */
 void iopt_area_remove_access(struct iopt_area *area, unsigned long start_index,
-			     unsigned long last_index)
+			     unsigned long last_index, bool unlock_area)
 {
 	struct iopt_pages *pages = area->pages;
 	struct iopt_pages_access *access;
@@ -2177,6 +2181,10 @@ void iopt_area_remove_access(struct iopt_area *area, unsigned long start_index,
 		goto out_unlock;
 
 	WARN_ON(area->num_accesses == 0 || access->users == 0);
+	if (unlock_area) {
+		WARN_ON(area->num_locks == 0);
+		area->num_locks--;
+	}
 	area->num_accesses--;
 	access->users--;
 	if (access->users)
-- 
2.43.0


