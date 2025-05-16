Return-Path: <linux-kselftest+bounces-33152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E90C6AB93EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 04:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBF91BA0557
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 02:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C0F2253A5;
	Fri, 16 May 2025 02:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JHs00wZW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B9123AD;
	Fri, 16 May 2025 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747361171; cv=fail; b=KsIJW/9gkDhzZ/AEFVCYmwN3qG5lAnjNAosrWNb2wZ/8fQt234jN9Ui+zKP3tR4OjzQECz+slRW+UDDn4x7EgAqRl5HBmTZu6/TiMToxSRCnRR7Zvi39yF6zzN9gIUkkjYXVXyd4sYBv7WNQxKoozrihxERh59hPb/LL1ae5a+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747361171; c=relaxed/simple;
	bh=BC/xl1SMQABfqLfhl+PgKaQuPkyEnwS/Y2eju1VixX0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7NtNj+SchZd9Sh6zdDZXbRa3R8z+Cz9JJf6wDoLoUMiuGD74VP037PT5roW2TjiJNd3GIyrrzu8Ep2k+lPQclKrHzUDVZymfkwOvemR5X86zEoVNhw4io+dXXaEHK0PBtP7b8VbIZ5QC4Kv+uT9NWexN2oW+IoKdpdIEpWdgVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JHs00wZW; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8nJpRT5tQh10Jhs7BpQOv2dVJAXkFQXZBXesLVQ4NnTdSKyV5x5BAV6JP/y5TMvZ196y9bf6jZ2udwzn6RDK5P7rwnomDt2/kR4AVehvmcoKmwjez6LJKUadqt/uw9wjLIvGW/jrcLW+Bc72EUzdcnFFKmc/CY2ZznH0BJPI/fd4Au+fJ66WFZeiyLSFa7PpOZh7RtCfrGkb0vQVqzFdQm0quUJSiiQUNOpBJn5pswNTSRZ0GuA42SpUIl8/7a78HZkCh4ZuJ4b+JdVeEDonNDUWL/o6NoI9K1faB17rwhIpn0KbnrfDZ2gcwTASXtqay9KJdquhdpLPKW+a3O5EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSH8vwa7r4UzVyBzx9vGiWye9TgKYZdsNdSo5P7Je7w=;
 b=o1t8piplSR05U/2Q+7UB8crlg+2cLLua430lnAl/KYKtZZM7hO/8WPNX6wnxYBs6YD7octNo71mlhfHtn3BH9AbX3/QKhw+1cCrWH3nFnn1yXvmc+h3c/iPI7AHifvdJfE+sjHx2WF9mu2+4ysotXcygxmxXxV4qQzB6OAstsbE7dt6edDZM3yX0LI9ypZWWwD4e/UZVYUsk9Y7XustLfW+G98tF9LZiUU7xUJoRzxzCYvP5okdTEUZO0L9wG6HydDvjN9/3XBwLHZH9ORQuFKyLpEfSYac8TdIwZagR5mgWE6kttVrx0HQdih7SfI39AGK5YpTfbzcLlU9cU/uUKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSH8vwa7r4UzVyBzx9vGiWye9TgKYZdsNdSo5P7Je7w=;
 b=JHs00wZW9maz0Aj69a0uSTUNtLudV3rKvcYTg7wXl21tbMVI4uo4qFL9ihsM2bV32fsJFuD8AsH6dAgS9O2srjGxoLgF9qr04pqe6KaDOIEDlZEUYm5f1iKXDFGoRfV9rLhkGjdPHB5L+V9lkkJo3kGmcBCynbLwGqko2aZ9cKqIPMw3rPhXOg+YM4Cpx6mH/FhqrIZ95DIjExR0imSDzvn6FwLGSdvNRnWxqjr/8uWMJmLLFuIz8EBybP7mYWh8VPcwKvRr/76g3Mk4z7Tn7veoJzRYcQ0QsaH6munmetS9ryYGchP35ZNX+6l4cYSydVHHOfF/fpZcet51DhNlEg==
Received: from BL1PR13CA0223.namprd13.prod.outlook.com (2603:10b6:208:2bf::18)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 02:06:04 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::95) by BL1PR13CA0223.outlook.office365.com
 (2603:10b6:208:2bf::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Fri,
 16 May 2025 02:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 02:06:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 19:05:49 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 15 May
 2025 19:05:48 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 19:05:47 -0700
Date: Thu, 15 May 2025 19:05:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: <corbet@lwn.net>, <will@kernel.org>, <bagasdotme@gmail.com>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<jsnitsel@redhat.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <mshavit@google.com>, <praan@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v4 05/23] iommufd/driver: Let iommufd_viommu_alloc helper
 save ictx to viommu->ictx
Message-ID: <aCadeeP+Z4s6WzOi@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <5288cec9804e7e394be3b7de6b246d8ca9c4792a.1746757630.git.nicolinc@nvidia.com>
 <20250514170637.GE382960@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514170637.GE382960@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 256ba30f-cbef-42f9-724b-08dd941e36cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/hA52ZqwD9ff82em6qgf2OC4pJL8C+zQymO7hhEgMShuZTGGk6/ZjJjANeNq?=
 =?us-ascii?Q?a+wmY0n3cuy8xqBqhiOlCK52SH8YdMSs8Ws+zfGhnagr5FuHjEchjYAxg02a?=
 =?us-ascii?Q?FCFfa5gvmTuRlY+ujp2/TRQ+N/adxgRr+4UtQ3gQCGzJfm+Gfrh+0OyAESiU?=
 =?us-ascii?Q?/25X+L8J/+CeV/WoG8TUe6qYHF6pWnmv3Muvc9sZgx0WZvipV7XfZWFYZZiy?=
 =?us-ascii?Q?hkp0z2S9Z7v2GIpe4PXn2S4Q0X7OQVsnNppXRRvhGc4JFdwfRo8a6jlYnWwW?=
 =?us-ascii?Q?2dy5CmizyYm44Apo8qesJTCC2hgN+dbji8x52yhDv9K0lyHx7Bkii0s6aIru?=
 =?us-ascii?Q?tSGQ43XuJxj9by4buUszg23GLm7FblbJ57b8PklzNyq8rJvcdDwJnbRRdhGf?=
 =?us-ascii?Q?RrNs8CNf/JrRTzkvrYjlOjKXSvzr6UWbLkjYVPbofsH9b+UPG8/nsruejTPg?=
 =?us-ascii?Q?E1la9b5Otjriz04ryl2lgiUJqBW+BeGiM1Y72ZylDG517TzzDhJWfDm8B5KI?=
 =?us-ascii?Q?MV3m2QetaW9UZd6NA6nkc04VuxI6FIK0JmEHaQQd2uyhA/BDGojhf9deoofr?=
 =?us-ascii?Q?68A1QUaOI4CIAx3sTQ/CTXJToMOClkzVDEGJR2gckaZuD8cxLH1MbQJDbzMh?=
 =?us-ascii?Q?6FyIOUHe2G4P2X5v0C0DTnrfaTDiKtPbV61Z8QVrSg74pNzkqQEMma4B9L54?=
 =?us-ascii?Q?nEx87G/fzGIVHyfVGjfDj4tyrHOFA9YRbFzb1FzUwKNL34bRgqPGRsWf7Vn4?=
 =?us-ascii?Q?XT0a+/h8i1zlVeYqDdC+6JNaxlsZ0KT2cgTbpi4ogK/7ev44BYSTiRwfMXc4?=
 =?us-ascii?Q?KT7XAFe3bCv6nsNMujjkSgaUZYQW6dFUyz9d8sNhHIzP8mBQnB9hu8/3IRoM?=
 =?us-ascii?Q?nkKNTaZNrx/MICmxL7gCC92LGhYcPgfvMxUc7YqmWu0CH153U8wsPDNeFDPq?=
 =?us-ascii?Q?T5PcAfXWKkaaRGG98Ptc5pAkQH7GQ/6IOorczDsZEYjpIi3RqDC/4WQghD+Y?=
 =?us-ascii?Q?VPgCcQdVL8Sl94v7gJCy6ZDFILmafwVbaC+zmF6NskKpr7wprY5rRRYQzXcy?=
 =?us-ascii?Q?r4aXvrOreHi6vJXBsu69Fnu9Ibq0a6bqzhsYL8HDy0cSZOOTXQFKuBC5H2hg?=
 =?us-ascii?Q?d3A2U5KlvTlmQ898qadWlzS5KVgXAmtPepvYPQnHU0XSAe5rvzLNMUo7Yqd/?=
 =?us-ascii?Q?NKEZ428FKVLzA1PZHaUYKLC+OLsPJKMkjmYwWHAEdfg/2h+lO/QUTKWRod2d?=
 =?us-ascii?Q?I9va+S0Nq5mvUo1KxJdUw+iD7seYOXcEHCf8LdaOaTIf5MkGjCYoac47T61P?=
 =?us-ascii?Q?BObGWo0RDP+Tx6IGI5m6S2l26ZyTp4midT/Dbb4mMLYAALm5t6Kb27UD4kub?=
 =?us-ascii?Q?Zd/+xjVLijTDPlXBL9iVjxnTukmMYQllsvOoDXGvk0+azBWgFuEccmjhvriB?=
 =?us-ascii?Q?IVf9b2X2GPdjW7qJvnv3whVWzPrJUy17VL9gh6hGqshnlGaQtBYLrq1JLSKn?=
 =?us-ascii?Q?pJrZy1Fe4orJyJCUHLQAG6Adp0Q00fBYc2SB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 02:06:04.3801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 256ba30f-cbef-42f9-724b-08dd941e36cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318

On Wed, May 14, 2025 at 02:06:37PM -0300, Jason Gunthorpe wrote:
> On Thu, May 08, 2025 at 08:02:26PM -0700, Nicolin Chen wrote:
> > When an IOMMU driver calls iommufd_viommu_alloc(), it must pass in an ictx
> > pointer as the underlying _iommufd_object_alloc() helper function requires
> > that to allocate a new object. However, neither the iommufd_viommu_alloc()
> > nor its underlying _iommufd_object_alloc() saves the ictx in the allocated
> > viommu object, although viommu could hold an ictx pointer.
> > 
> > When the IOMMU driver wants to use another iommufd function passing in the
> > allocated viommu, it could have avoided passing in the ictx pointer again,
> > if viommu->ictx is valid.
> > 
> > Save ictx to viommu->ictx in the iommufd_viommu_alloc(), in order to ease
> > a new vIOMMU-based helper that would then get the ictx from viommu->ictx.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  include/linux/iommufd.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> It is OK, but please think carefully if the ictx is actually
> needed. The reason most objects don't have an ictx in them is because
> their contexts are always inside an ioctl so they get the ictx from
> there.
> 
> We don't have a lot of viommu allocations so it isn't such a big deal,
> but just generally that is how it was built that the ictx comes from
> the ioctl not the object.

It's more of providing cleaner for-driver APIs.

Especially with the new ucmd changes, it can be just:
	// in my_viommu_alloc()
	my_viommu = iommufd_viommu_alloc(ucmd, ...);
	iommufd_viommu_alloc_mmap(my_viommu, ...);
	iommufd_viommu_destroy_mmap(my_viommu, ...);
	// in my_viommu_destory()
	iommufd_viommu_destroy_mmap(my_viommu, ...);

Otherwise, they would be something like:
	// in my_viommu_alloc()
	my_viommu = iommufd_viommu_alloc(ucmd, ...);
	iommufd_viommu_alloc_mmap(ucmd->ictx, my_viommu, ...);
	iommufd_viommu_destroy_mmap(ucmd->ictx, my_viommu, ...);
	// in my_viommu_destory()
	iommufd_viommu_destroy_mmap(my_viommu->ictx, my_viommu ...);

That being said, I ended up doing something more in this patch
for the ucmd rework and Kevin's comments:

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 98fe5a49c9606..ddd144031af5d 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -136,14 +136,6 @@ int iopt_pin_pages(struct io_pagetable *iopt, unsigned long iova,
 void iopt_unpin_pages(struct io_pagetable *iopt, unsigned long iova,
 		      unsigned long length);
 
-struct iommufd_ucmd {
-	struct iommufd_ctx *ictx;
-	void __user *ubuffer;
-	u32 user_size;
-	void *cmd;
-	struct iommufd_object *alloced_obj;
-};
-
 int iommufd_vfio_ioctl(struct iommufd_ctx *ictx, unsigned int cmd,
 		       unsigned long arg);
 
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 416cd281eb2b5..6c0a2a0885a32 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -60,9 +60,14 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_hwpt;
 	}
 
+	/* The iommufd_viommu_alloc helper saves ucmd->ictx in viommu->ictx */
+	if (WARN_ON_ONCE(viommu->ictx != ucmd->ictx)) {
+		rc = -EINVAL;
+		goto out_put_hwpt;
+	}
+
 	xa_init(&viommu->vdevs);
 	viommu->type = cmd->type;
-	viommu->ictx = ucmd->ictx;
 	viommu->hwpt = hwpt_paging;
 	refcount_inc(&viommu->hwpt->common.obj.users);
 	INIT_LIST_HEAD(&viommu->veventqs);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index a24b924cf6872..74d11c6779739 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -52,6 +52,14 @@ struct iommufd_object {
 	unsigned int id;
 };
 
+struct iommufd_ucmd {
+	struct iommufd_ctx *ictx;
+	void __user *ubuffer;
+	u32 user_size;
+	void *cmd;
+	struct iommufd_object *alloced_obj;
+};
+
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 					   struct device *dev, u32 *id);
 void iommufd_device_unbind(struct iommufd_device *idev);
@@ -252,8 +260,10 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		static_assert(offsetof(drv_struct, member.obj) == 0);          \
 		ret = (drv_struct *)_iommufd_object_alloc_ucmd(                \
 			ucmd, sizeof(drv_struct), IOMMUFD_OBJ_VIOMMU);         \
-		if (!IS_ERR(ret))                                              \
+		if (!IS_ERR(ret)) {                                            \
 			ret->member.ops = viommu_ops;                          \
+			ret->member.ictx = ucmd->ictx;                         \
+		}                                                              \
 		ret;                                                           \
 	})
 #endif

Thanks
Nicolin

