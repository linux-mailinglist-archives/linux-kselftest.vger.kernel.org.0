Return-Path: <linux-kselftest+bounces-26088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1264EA2D507
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 10:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22B8B7A4F0A
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 09:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705BD1B87DB;
	Sat,  8 Feb 2025 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bep04BLb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F521B4244;
	Sat,  8 Feb 2025 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739005412; cv=fail; b=S9kcelksJ2vvpBlD0lN08l9kaz7Bfl3X903XLCAb58fBal+B9jIbDDqqha3lbQhwfA/jmM67pY1p+a+0huw10JsAjNr6dwtykMdxL3h76orWo+asTGoL0B9Q3Mlc/LYB+cFzJ+V1ndst2IzgIJOTCVJhlt8LgSY9IiJV29gNe2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739005412; c=relaxed/simple;
	bh=cqnPUT+GZ/17/t7xPi8rJ50+GNVaYQnxkAf+bZNzgLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqPWv9RnWZHoKFepZpjN87W6hfqBruEiOmJt1C4l8LeN+4Nsz3K9/Vfj9iKmV10Dm73+vyUMnMJSr8/rw16GSDDkksqekxMgPQEFMPGgtDnOSMzytP+CURjmB7CDkPJbluIV4JBLf40NScavDsA3K4jIjxvkUS4JHbA64OvXNys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bep04BLb; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKjM0ML48Hou3qmrtShGDzIvlM2Z0kEnNNRiDdG6EfTRNBr+Hppfie21HOTD3g6TeZ10GX6pPgn2cavYEUqjgIYlV2sJQxo0VsuiSuipAsccFC/4DHsqvcwbRhklT9rjb6QkgL8b4SlhUujyCVONn2juUuq9HqbRkoQnLuiRBJ/FTeDn7xz2FxdTW5DxBXwL9vDBh2UCvHp9kwBZ0HWLzqjo0VqGTiQNHBuqtS77GlMgaSrfpziY+WH2jRdQQJlvzW4sZ6DPBh0TUhIdoVfc45UqeLtvscsRXdqY8lS5yG61fcv6aSDuofbtWULEzdlv4uhvNW6yDxsEUkEPM8eaNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpvJ+vhxt8A3FUWSIdPivIO1epes2LJnk+IzWtZEkpg=;
 b=UBQjgxScRPliN4QTNRTdLj9he0+nyaBB7HFzwJ9STNNJSPjm1Utk0sxk8aVv36rI+kwxAkM1kEzyEwt0lMTpC53vSUbZ8q+4KBPkRC2VVgTjyKBXp1NmVgNlzXOUOxfryM+XyGnUAYNuovmd+BFoDRpu669lYmVCFvsG5dFQDQOyjMZrANIdgj7AmsOpWmaEQM1m3CQqyQeLzDJ4pfX6CC+Psk5q/f0zJQX+almjg+GBPJFOjaU1JhPFoH2aCS+hg0RonRlvjOTztHb93/KIxSvVGseMC72SzDpZklByAAvXM7skEHjgUGSrS+QVFGYd/qbBX6Li0u+jkA9+UxjCog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpvJ+vhxt8A3FUWSIdPivIO1epes2LJnk+IzWtZEkpg=;
 b=Bep04BLb3gWUpmEVQsL7mp2erZ+I1EDgVbcGyH4ZFipRtKZec7YgS8mtjmnKG8eDN72Bo6vxviQar1gPbv4a0rFtMBiO9WpZD10PCt8zBhKr1Oc/LD3QGQJMpxhIZsvTciYxCtT+mddgpdh/EMz2Yz0piUabd3lxLMTZo1XdYsdwm4CsSWZdEp7f9xdAKRLqzsMNimN61JKq+z3SCd6eyGZu84ahrXEQSNbH4Qk8DZTmHcJY1dwq3SDQOnh5YNScKtAiEVjwzctY/BnHXGa4uSzO7P8Gml76SQjSxw6xvAlwHHYpzGNYOUAinEIMJ9xKgfnBphSdSfTWYrhjd16xBQ==
Received: from MN2PR18CA0010.namprd18.prod.outlook.com (2603:10b6:208:23c::15)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Sat, 8 Feb
 2025 09:03:27 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::d1) by MN2PR18CA0010.outlook.office365.com
 (2603:10b6:208:23c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Sat,
 8 Feb 2025 09:03:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 09:03:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 8 Feb 2025
 01:03:13 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 8 Feb
 2025 01:03:12 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 8 Feb 2025 01:03:12 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v1 05/13] iommu: Turn fault_data to iommufd private pointer
Date: Sat, 8 Feb 2025 01:02:38 -0800
Message-ID: <c54c6c5746ce730e2af726656c21f8578dad0770.1739005085.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739005085.git.nicolinc@nvidia.com>
References: <cover.1739005085.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 8801e253-3d34-4638-70f3-08dd481f72a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vlV+G0+8ONmWC4MZtVHlqtSlindinUYdZl8FS0Cb683K86YBQkvl0RNDpPI4?=
 =?us-ascii?Q?OwsFg8VilQZzP2rEpJ/ByAO7YFjRlub2eAO/A1pQv3EURr+trBuEpYTK/6xc?=
 =?us-ascii?Q?Yz5R1Kefba9IR4auqSen9I31iduo+823XboSXngD9dy7UBlnUHoJPo9IxcEP?=
 =?us-ascii?Q?9pkon07tgeRigp14Hymb63oIBeT4wSQqBvaWD/C7BeW4uOcFZmx3tEsOD6My?=
 =?us-ascii?Q?i9REsTvMwmC5Ip+afbSZiD0YhCj/j8PfNCe4viyVvZ1bHaWhVXfdAviscg+3?=
 =?us-ascii?Q?0j8ka/eaMHB69WUxHDjGWnxqVIgbkxwTfXqdE4GeU1wugva+4UQfQpI2ssRF?=
 =?us-ascii?Q?4Z+RyibmEhWpIM+zQPVkrfOyEl56krqdn98btfZsa1OwzZgDuZ3ziu0OUiSy?=
 =?us-ascii?Q?J6qdHq+AyzdVicgeUFrO3FURi0QgQMKi/YSzItnUfOgiqtNsYkpDWTGs4jnM?=
 =?us-ascii?Q?uV17KhoYy0D3qE/fzzCae6VIUMQcTvI21NwgaVq5v8CyzJkohtg/YpvI0pkF?=
 =?us-ascii?Q?GRuNq1nrXaXfvQypYKZKRt3WPrw94TxqesrcLBx/INUS2D9sNTt9kxfSwSnd?=
 =?us-ascii?Q?pFrt30G5K15Cz5iYFDALI8W/ISuzQQUeWOG/2QlbyHy0LMHIGzoqhLi6hqua?=
 =?us-ascii?Q?jN8nOlcNnowouFwy2uZ8wa0ZKgav+cotm3WThdmRompEtjXFKIB1cBCjar0p?=
 =?us-ascii?Q?2pUINElbgkrT7RJ+3ilDXv5Fl+JQ0NRlG4ZZ/aRj+2CJc446kfQIygggFQeM?=
 =?us-ascii?Q?E9vDPPDvibU9TzxbK+PjMYDwuJ2Y15wlg8cM61+fg6Sp4LGDWVWYTxNznIGp?=
 =?us-ascii?Q?UTPffFjXctwul+zVhBYuyGrhdpi0lEpzqry33zNn1TRGcCdPY5bB/EbfaDmD?=
 =?us-ascii?Q?yQ5fboXFWhD5qRqP2+CpZBNVJlbrFBcvDJA43/0BYT2wGHKJw3ltjQ7azHVs?=
 =?us-ascii?Q?ilXovzcwedAtyvwJ/hWgBcB5QzG26gYzvfFJeD5rY2GGyfm9fMCTVBBw0eUb?=
 =?us-ascii?Q?zWS2UOhKGIxrRmc22bDXrzyOXKIVkhPnlBaEdriLCfBEaajaxOMzlRsQRRDc?=
 =?us-ascii?Q?KGkS39GyjVNQpgGtaRGuY9s1ODgfpWn9sNcoQexHtXdwtWu2RLrdH0nSkz2D?=
 =?us-ascii?Q?eQhtgZhRgHHxFh/77WTn68b8Rhhr3BA3tXoCbybzKXRnH65pVcJuv92KY11V?=
 =?us-ascii?Q?bM/XP659GAWgJV8yTk+NVdvGnowUYpu9OJaiYW+B+omaHO9GTTA0fA0tEjAX?=
 =?us-ascii?Q?Syso6UOQOCgygdofpyDzqIk48An34UvD/uN642EaEsFeyPFNu2jsMD9V2l0h?=
 =?us-ascii?Q?qFuNKPNHdYfp4ADRCo5Ob8gK57onrYxESW8U6rILdV+/1DHXNMKV9ulBqAjL?=
 =?us-ascii?Q?zjwW+g2y0XA1A3uewNaLGVzfRuVSuFqc15S9zPIcZpKlu/dzpsQdeZnPEt6x?=
 =?us-ascii?Q?gJM9N8EnPMOMfnIRd3/1XlNTckI81St6UFDi8YJTXSz77OprkZNgXNi5ve9x?=
 =?us-ascii?Q?tI6yoSqfMTLVDf8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 09:03:25.9143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8801e253-3d34-4638-70f3-08dd481f72a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282

A "fault_data" was added exclusively for the iommufd_fault_iopf_handler()
used by IOPF/PRI use cases, along with the attach_handle. Now, the iommufd
version of sw_msi function will reuse the attach_handle and fault_data for
a non-fault case.

Rename "fault_data" to "iommufd_hwpt" so as not to confine it to a "fault"
case. Move it into a union to be the iommufd private pointer. A following
patch will move the iova_cookie to the union for dma-iommu too, after the
iommufd_sw_msi implementation is added.

Since we have two unions now, add some simple comments for readability.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h                | 6 ++++--
 drivers/iommu/iommufd/fault.c        | 2 +-
 drivers/iommu/iommufd/hw_pagetable.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 761c5e186de9..e93d2e918599 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -224,8 +224,10 @@ struct iommu_domain {
 		      phys_addr_t msi_addr);
 #endif
 
-	void *fault_data;
-	union {
+	union { /* Pointer usable by owner of the domain */
+		struct iommufd_hw_pagetable *iommufd_hwpt; /* iommufd */
+	};
+	union { /* Fault handler */
 		struct {
 			iommu_fault_handler_t handler;
 			void *handler_token;
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 931a3fbe6e32..c48d72c9668c 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -329,7 +329,7 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
 	struct iommufd_hw_pagetable *hwpt;
 	struct iommufd_fault *fault;
 
-	hwpt = group->attach_handle->domain->fault_data;
+	hwpt = group->attach_handle->domain->iommufd_hwpt;
 	fault = hwpt->fault;
 
 	spin_lock(&fault->lock);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 598be26a14e2..2641d50f46cf 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -406,10 +406,10 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		}
 		hwpt->fault = fault;
 		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
-		hwpt->domain->fault_data = hwpt;
 		refcount_inc(&fault->obj.users);
 		iommufd_put_object(ucmd->ictx, &fault->obj);
 	}
+	hwpt->domain->iommufd_hwpt = hwpt;
 
 	cmd->out_hwpt_id = hwpt->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
-- 
2.43.0


