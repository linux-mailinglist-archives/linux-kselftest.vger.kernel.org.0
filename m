Return-Path: <linux-kselftest+bounces-36617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C51E4AF9D3B
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F083A6689
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18CF1DE8BB;
	Sat,  5 Jul 2025 01:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EMUhSrxY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CD31C8616;
	Sat,  5 Jul 2025 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678062; cv=fail; b=m2bfZRofm4VsjSB50rwkzNqDz6o06MeHzGsssEsVPyPHY3qV47jOlz1/rJJIbptEaGtTlXhDCZyXwzaDZ8Poi0tEGWfQeo3tEyoZ8oitech3WMjzjxL+pgbO3IXds+AI20YoZbVeBiQY9knKmvvb2Y0cJKOsmeqw1H8k5fgjTMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678062; c=relaxed/simple;
	bh=GCfDj+aHZ1YtTPUlVUw0dKbquLyDpDhNCL0s7UaasXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ps60vnu9Jpu9E6xEjB/r5ZjPvd5hmjhp1+XvKpRYIPS4AoBiE4wPBRjhEAoB0Jdq6cRrEvD2kIFehUgUcHo5auQQ3kttETrsF2Wrmrpz0jgYQKqKZAxjuX/EqGWom8NOtTpUNhZwgUl43IRt/2XTe0eCoVUl0/35e+x0d1BZrug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EMUhSrxY; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpPfNL8mmtjWwmOcaeEDnj/iNV9WzBvBW00XRG6aO9weGQdSrD3NepeJYmI6nXTxhsRfnMyYwUuquZ9oJWYzK52T6+R1UIdJigu1wSTw7f00RBHaWfSuQK6kTKTKwSLrfsSQKY8/52lb9KnyF8gAEJfad2j0eTLIGQu6LSeWLdsOKJYGitHlayuA07hKR4nQeVqZ7u4gizHeDaznRhcJ+FtzgSTt8q/BvV7AWeQ9ikKsOrHCjA6gYYxHQz9J+6HWSd/qKmy84efuoUS/XtbLAvVDMbYGQ4LceSCNKRJF/WqAT/L88yDN/I8t339TwHbq08XXOMQQ74ctY8fmerW7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdFFe9ZPEIG2FwgA8jVbPH7of1U/Mmj2C8zx4xULCtw=;
 b=vvwYpzMGwAfPVcEGSwCI8VB7LNfWGBoTDp+DxFNYvYxkYSwI8Ox4ZeXYZNdUrxnwLvL/x1Rmn6muEL/joQmXbONMtJSzFl/P+2y3ll5W4jHK+ddhVp5olvwoL6kSDMHXOT2fZgNGiJuR2y/FtirbtnkfM69BzvWCkVB/MY9gIadnCAjH+YT+dZLTas3ivCcYYHZvzpPrGIZmbtX7wWHG1LWweUSEr9i8AJfktbWAnSz3xft3LqNk6c74WzThBhTsyAlHvSCWhHdnRr9Tqw8MeJ6hBfwin3kChkNeQoLLSI4Z+g9Pu3hKz6kxnSFQWst2/q0QyghF86zuCIBIwvymbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdFFe9ZPEIG2FwgA8jVbPH7of1U/Mmj2C8zx4xULCtw=;
 b=EMUhSrxY64BeQrmAQX7ACgK1VI+J5t5EJ+KZ3D+3XsA+iUWoP1x/1GRAoLO0FTer4TclRhMbhni2cUqvmsewHUMaDD/B6H9qimSgywaikf/2nBF66f6LFcpXBEcGmrEaQXzD2lXlDyyOdukvDRXmRpv8SjyiEe/WVdZhJ8/43SYSDQWXdF7LHnxZG62lW4YhGIjsnPTa/DJ+xPdt1EzC3i9BXtM04J3+PVYvTymeasceUDg1kQo0gaXgiaj5ltMjTk/qyA7lctW0Wd5z4t+AaSl+6V8j8q3QEf+AKNvEhspa/QrM13/IGp7DWfOiiaAgz3YFr3TT24cHYL6CtZmtmw==
Received: from BN9PR03CA0193.namprd03.prod.outlook.com (2603:10b6:408:f9::18)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Sat, 5 Jul
 2025 01:14:16 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::63) by BN9PR03CA0193.outlook.office365.com
 (2603:10b6:408:f9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Sat,
 5 Jul 2025 01:14:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:14:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:11 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:09 -0700
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
Subject: [PATCH v8 10/29] iommufd/access: Add internal APIs for HW queue to use
Date: Fri, 4 Jul 2025 18:13:26 -0700
Message-ID: <5b62482757debc3ae2b556ca37dd10f044b5da5f.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 8447c535-27f1-47a7-6735-08ddbb6142cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9K13JpRzvIVoAKQDFLgJhEi01l463jIiDsp2ZNcGb61b22PTViVS8b4x9jZ0?=
 =?us-ascii?Q?aMjcHNB25CbERry/DjKHpUPJcqGJiygFNq5ZqalIhBMtrle0qhcXUGqfcS2e?=
 =?us-ascii?Q?7x/DpCQJJQoTb6wmH7zMvJIlF0etJ3qbCHd0TCblwAju6Rdbm4OcffARF1za?=
 =?us-ascii?Q?f7aCgTC1VgIy4fGbk0L1qg3GZWIkR03qDDZmSDxmVRNQvf+EMXvMlGDTdYEQ?=
 =?us-ascii?Q?D82uuMJVibh1utZ8Fvy5Jz0CkFUMj0fK0t/2CcSqQyhgstpspmTPPXOtLOuO?=
 =?us-ascii?Q?i2EoebuQ3OU0TGEqNVexmQpF6Y7q1Qjb+JuSD3PcHRJGrxVxVZzWoEVoGAhq?=
 =?us-ascii?Q?FXJMgoKJS0jyfbV2lLsARZJvdwYa/q8xCCrlMI9TYr/S1lPt0geCLuKzMlXK?=
 =?us-ascii?Q?TXg645zmru1NMjmlSKBUdtdQ81UCPEspHsX9Di80DtKIIUlEOE5Vnsvy6CLm?=
 =?us-ascii?Q?s8rH07HN1o2DYGd3Q15uUQ26bD2r7E/WuGd/Y+6Vc9vCjWy2dKHLhzg1JL2+?=
 =?us-ascii?Q?i4TxG998CmXowOTC4g/0viUcd1ODszdJTxNqRMXXS+ZgcHMVnUZeobml4HhL?=
 =?us-ascii?Q?8FgYTYtfiu8xUXGSwHQ6FT8+vgh1IJI8fJOMldonYPrA/lJaCSge6dSLqxkx?=
 =?us-ascii?Q?HhwXM03YsMHJO6FYhQGFvYTCfrDUCS7xDS6m/W5qXGqYkPaJ39MWU3p4mhuG?=
 =?us-ascii?Q?zbuiHDE8KKixXMGfZnQxJFx+111vbBsuv3sHvv+0ZaqbGuIS6b9NQSbE2/4j?=
 =?us-ascii?Q?nMYiETsr5w/CsBDC+OWdPKAo2Vd7xrRGuHGzKrc4menQitxNH9ssuvfR2H5Y?=
 =?us-ascii?Q?tDZfc1hN3/rHPyoUyExzpRI9r45wRA0PBO36QVTdXsF0WSvKa1gzlt+8PTOR?=
 =?us-ascii?Q?XihffEPXv74x9K0Xv6M7sAgytSZASCjK2k9SU3RodoryKE9ZS8ynAWqdP8YP?=
 =?us-ascii?Q?GFlYx/ldtwfv4YqiEw9ezpd9GlA3jMFLtimkoA2EC8jamsk41vUz3NYvKE8e?=
 =?us-ascii?Q?0KZd/9UxrSxeY7/j9EGWOrUS/yjsppFresX4z2O+GrDqduE5yPfddH1N9O02?=
 =?us-ascii?Q?J1I7WcKH/1Ly8MSpllEXWAg/vjp+Y9CqdJ6TlEoZrmPJCiZ/dicKzdBE+5p9?=
 =?us-ascii?Q?jtj8rVkBNwLgjw7g4sPzUaORRPbdNcLDvIqvNApTKo41bQHAhsoHXaU7Rbww?=
 =?us-ascii?Q?0p2E70bXYguH+7XFSh3KlPS489FdH9DPw674KuMABdP0bMXzPpJpwSjbx5Xs?=
 =?us-ascii?Q?nau5exZun2JuPO6JRVeREntxjvC1D+h1TIQz2/gJrgfEnqJ8Kyn3bYUNQHPH?=
 =?us-ascii?Q?cpKTI2rpO+fojnZcapb9VCO3ljFirNyWB8xLL+DClbob1zToHmPFFY+SOG9K?=
 =?us-ascii?Q?39flSq2mXyD/YedcC2TdTIAuEGn3LiyiPuiKfPQ9LgXbQS7XXo0XPfvP7fSi?=
 =?us-ascii?Q?x1nxi5uXbW7cn6G9CQRoa/YWDxBq/7HA1tRSCjydGqvK8W3jebd4xNYzs12l?=
 =?us-ascii?Q?Lsil+4wrSmRDpX/FCXAO1ax5IPyAgXTzly9X?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:16.1548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8447c535-27f1-47a7-6735-08ddbb6142cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549

The new HW queue object, as an internal iommufd object, wants to reuse the
struct iommufd_access to pin some iova range in the iopt.

However, an access generally takes the refcount of an ictx. So, in such an
internal case, a deadlock could happen when the release of the ictx has to
wait for the release of the access first when releasing a hw_queue object,
which could wait for the release of the ictx that is refcounted:
    ictx --releases--> hw_queue --releases--> access
      ^                                         |
      |_________________releases________________v

To address this, add a set of lightweight internal APIs to unlink the ictx
and the access, i.e. no ictx refcounting by the access:
    ictx --releases--> hw_queue --releases--> access

Then, there's no point in setting the access->ictx. So simply define !ictx
as an flag for an internal use and add an inline helper.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 23 ++++++++++
 drivers/iommu/iommufd/device.c          | 59 +++++++++++++++++++++----
 2 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 320635a177b7..9fdbf5f21f2e 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -484,6 +484,29 @@ void iopt_remove_access(struct io_pagetable *iopt,
 			struct iommufd_access *access, u32 iopt_access_list_id);
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
+/* iommufd_access for internal use */
+static inline bool iommufd_access_is_internal(struct iommufd_access *access)
+{
+	return !access->ictx;
+}
+
+struct iommufd_access *iommufd_access_create_internal(struct iommufd_ctx *ictx);
+
+static inline void
+iommufd_access_destroy_internal(struct iommufd_ctx *ictx,
+				struct iommufd_access *access)
+{
+	iommufd_object_destroy_user(ictx, &access->obj);
+}
+
+int iommufd_access_attach_internal(struct iommufd_access *access,
+				   struct iommufd_ioas *ioas);
+
+static inline void iommufd_access_detach_internal(struct iommufd_access *access)
+{
+	iommufd_access_detach(access);
+}
+
 struct iommufd_eventq {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index e9b6ca47095c..07a4ff753c12 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1084,7 +1084,39 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
 	if (access->ioas)
 		WARN_ON(iommufd_access_change_ioas(access, NULL));
 	mutex_unlock(&access->ioas_lock);
-	iommufd_ctx_put(access->ictx);
+	if (!iommufd_access_is_internal(access))
+		iommufd_ctx_put(access->ictx);
+}
+
+static struct iommufd_access *__iommufd_access_create(struct iommufd_ctx *ictx)
+{
+	struct iommufd_access *access;
+
+	/*
+	 * There is no uAPI for the access object, but to keep things symmetric
+	 * use the object infrastructure anyhow.
+	 */
+	access = iommufd_object_alloc(ictx, access, IOMMUFD_OBJ_ACCESS);
+	if (IS_ERR(access))
+		return access;
+
+	/* The calling driver is a user until iommufd_access_destroy() */
+	refcount_inc(&access->obj.users);
+	mutex_init(&access->ioas_lock);
+	return access;
+}
+
+struct iommufd_access *iommufd_access_create_internal(struct iommufd_ctx *ictx)
+{
+	struct iommufd_access *access;
+
+	access = __iommufd_access_create(ictx);
+	if (IS_ERR(access))
+		return access;
+	access->iova_alignment = PAGE_SIZE;
+
+	iommufd_object_finalize(ictx, &access->obj);
+	return access;
 }
 
 /**
@@ -1106,11 +1138,7 @@ iommufd_access_create(struct iommufd_ctx *ictx,
 {
 	struct iommufd_access *access;
 
-	/*
-	 * There is no uAPI for the access object, but to keep things symmetric
-	 * use the object infrastructure anyhow.
-	 */
-	access = iommufd_object_alloc(ictx, access, IOMMUFD_OBJ_ACCESS);
+	access = __iommufd_access_create(ictx);
 	if (IS_ERR(access))
 		return access;
 
@@ -1122,13 +1150,10 @@ iommufd_access_create(struct iommufd_ctx *ictx,
 	else
 		access->iova_alignment = 1;
 
-	/* The calling driver is a user until iommufd_access_destroy() */
-	refcount_inc(&access->obj.users);
 	access->ictx = ictx;
 	iommufd_ctx_get(ictx);
 	iommufd_object_finalize(ictx, &access->obj);
 	*id = access->obj.id;
-	mutex_init(&access->ioas_lock);
 	return access;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_create, "IOMMUFD");
@@ -1173,6 +1198,22 @@ int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_attach, "IOMMUFD");
 
+int iommufd_access_attach_internal(struct iommufd_access *access,
+				   struct iommufd_ioas *ioas)
+{
+	int rc;
+
+	mutex_lock(&access->ioas_lock);
+	if (WARN_ON(access->ioas)) {
+		mutex_unlock(&access->ioas_lock);
+		return -EINVAL;
+	}
+
+	rc = iommufd_access_change_ioas(access, ioas);
+	mutex_unlock(&access->ioas_lock);
+	return rc;
+}
+
 int iommufd_access_replace(struct iommufd_access *access, u32 ioas_id)
 {
 	int rc;
-- 
2.43.0


