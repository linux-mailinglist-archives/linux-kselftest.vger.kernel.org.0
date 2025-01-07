Return-Path: <linux-kselftest+bounces-24013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15032A047B1
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 18:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EAB91888D7B
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03A71F4E2E;
	Tue,  7 Jan 2025 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fW1K0Duw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118DD1F190A;
	Tue,  7 Jan 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269858; cv=fail; b=i6np4aK9OaUT0l5GF3Xr/cqZEd9xwQ24YXGO2RO31Ivob19Rw/wJK7zy9xJwrDce5tFJyiLpuidFPQEXOqg8YHWijxh0/Nh3ObjgF3ZBsm/gjXxpm++7qfcchvzPhEabTdUMs7o4WxkxKuSOt1v0yehS7XWvhsyfK5XbTcgIR8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269858; c=relaxed/simple;
	bh=/f2dyS+fONu95tXyHIonyyAdxGoWjY8pOp/dG3Tndks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DP9nWP7Halu/5fC6qbNpDVHcR0ksSRS2i2+LRstH97KNnOnYfsXR8CAiDA2QW5ItdUnfDCvWNdd8AjDwGbMvROe7wVZmtkCjbj4wR9ExYC5o5xgGXRItWQZ317tVcNLpT8YMw4/t5BeUrS0E76IO6EUPDlz17KieSV2jDog357E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fW1K0Duw; arc=fail smtp.client-ip=40.107.212.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sI5q97Nw6d/9qHx5AjWwM3CWxyahrRxIS3iKzhhP1tAEjUCKdF3F+hEu9BeuB8uqFJgohE47R76tstB6Cef9l4R9W8kCdSa83d/pu+rnPXWjABbQbhFskRKddp3o9pdEoQee78yUimFwlDDrZCaNkpbDRUtLgJLQ9lbj7xV19+fOwbMz2z7pXw7oHRQ4WfoPSDmALxAf2+sUSPmYdkLgn3YwYoSvUd2oyNbH7saZfHtWiXNdLikGWRC7yuDLtxiqqawxnIZVv3WEypuJWTb3zEIB12olTlC465LTvCM8WQf5ebUlEicoDzt8GuHcioJjxBacPhrbnSn6OfY381R4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7fQGoJKB6gpiw7+BSeR17Aoc3kvyXkMjqb2HwDDjOQ=;
 b=CEC1aDYCv0q+spq+ifS+vCRy8tCAusIJtxMsGI9Dgu3v2wh8pJNSF2oPwlnt88yVqRdNisNXCbpor0hujHzWY4q4/Wy31a+HVNIEQNiA0HKBeuR6lIE9H8Cv4jEM6Vy18vU7Zvoo2w6IOX/zD6U/koCxRa0vJDnqXKQhN5vZBqEh/nE/vl3Ko3kCfGFj4LkP5aDdgWeUOiVUv1V3wfd3MYowkhLgxfL1VudWPPMq1BEAAzb9R8xfL5ungSC4s1AWRQ3zImolDJthUjjrIOM6R32/10Cs2xXfYN+yx5QAT8mjgTI/5wOoA5140OSQQOvHtIc7UBNh0ruaBKEEBYLrMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7fQGoJKB6gpiw7+BSeR17Aoc3kvyXkMjqb2HwDDjOQ=;
 b=fW1K0DuwOnwx6cZJ9CmM3aWu3wVUkBq65Ako0cHeNsHPJ50sx2P9op/IJpSXZoUXw7WZ9SQBwijG8c5S1NLbTsvRL/XIlRv1drkbDdZvC+Op0xm0Zr7/Ku3gRtA2RTzZp+oU8ZR7TTHD2jk0QGjm4WlZUiRJ4DopER/Mm1jArX0b82KSBxBi7tgXIJoYpC9LcLShCbMNiDsdjHZ8MftDnTnxnZttAi3wHhHmFe1m+lG/RgD7cwKZdN8DdL71G1HbnWY8bGh294F8hsb4nlVK1n1THoUyNCwR3+IrtV9WsPUH4xEypWHZSKMkLeqGIMG5k8xQFg0d4eocL7xJuMofDA==
Received: from BN9PR03CA0418.namprd03.prod.outlook.com (2603:10b6:408:111::33)
 by CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 17:10:48 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:111:cafe::a7) by BN9PR03CA0418.outlook.office365.com
 (2603:10b6:408:111::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 17:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Tue, 7 Jan 2025 17:10:48 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:31 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:31 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 09:10:28 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v5 02/14] iommufd/fault: Add an iommufd_fault_init() helper
Date: Tue, 7 Jan 2025 09:10:05 -0800
Message-ID: <bf5e260006d5f14011e6dd27ecb3ea0a8f062901.1736237481.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736237481.git.nicolinc@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4dea3b-5bde-4398-e0ac-08dd2f3e3b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DmBnyKL3ipYDBapsBXyQDOX6tbg7nbqyLJIR45A1GMYky10l4I1j4/11cyR3?=
 =?us-ascii?Q?XDbOhtUWAMPFiTlwcO0Q+YdcwuDJVpHXsLkYONCHNxeQ6SLB7nwd5WQ2NPgK?=
 =?us-ascii?Q?0fANZsaGvBIUzGtMF6vbya03HGlfcqHD7mpmVwsvZFyvmMwCBqZGAu7hWyWz?=
 =?us-ascii?Q?iFYIDB8jIjWGQGO90/UD00NifMXxVbEmWVfxYf3pHoVE8BoVrZKkGDd+g2d6?=
 =?us-ascii?Q?Sy0Q679JfOee4HbWYmv0SDYOk0ZmK2NAUGbDvpsBhubU3qq6JQ1it7DoxvyX?=
 =?us-ascii?Q?e4xmWBD2rORLRSo9qbKSf5IyF3CO8YLkQn8pKFQdILk0UIHyQE3FNMjpuDkE?=
 =?us-ascii?Q?pkN4GmQ0H1Bqt+m7egtZPPSrqA/zJqEG79noWi8vvBpGysTHz+/ea3SAqRWL?=
 =?us-ascii?Q?zlm2kl7Uh7n+OSa5xd3GprYCEw3iu5lIviw/vF6qL1JoENQLrQjZWqMC7yl1?=
 =?us-ascii?Q?mprl1yu/ueavTBFUROkD3g0gncZ8g2PGwVARewOITU+AR2ZXTKfH2iOZHoaz?=
 =?us-ascii?Q?uP3VIz5hOzOqqgJtq5eCadUb2SkdkgGRBKhAUM978EIYovOTYKrDiAkKcP9E?=
 =?us-ascii?Q?j9X55FGP60TkWep+4zmbVRoEKvLSuoE+2lZqaxtIyZXuejerPkdCMlcZuBOz?=
 =?us-ascii?Q?9zzotiVzluwHI/g3uTF4JBprb5CBuBQXvKpLY5aojlCQ/1b4ZST+Zi/9Egwz?=
 =?us-ascii?Q?WTAkF+xICpjIpM+JURmMLy4khb8fw9p9xv9y0tovlBNiMnHmXVfxUXvbSfCX?=
 =?us-ascii?Q?bwRUmfuxQ21MgLYrKu89ifYxSZEQzOWjfwNS9vIXBxI8i3WoSQXXCCY7tJSu?=
 =?us-ascii?Q?eXBvTyGCH/1vHHtbvgI45eXf1A5j6+qsNvLXVawP4Pq0KzDdTIxyVpJiPq4O?=
 =?us-ascii?Q?OrYF3YxITHQlb2j9BXZ+lCoc2K+v+fSfogbug19q+3oKLVQUd3M73S/oeecJ?=
 =?us-ascii?Q?7W0CaCfpUKiUiM+7kw4G/m9shSqHhnakferzu80RtJnD+WyPt3p9V20TSZav?=
 =?us-ascii?Q?RuKH6hmzeAhUEtbrDi9HX0qHKeFEf9KVN+Xy6xYRA7w/zNnKxZwL+cG3isxV?=
 =?us-ascii?Q?Fz8acBfwnS4bZIOfMUlJyXgumVxa/ft1NxvyBLZ6CwUvBSkJHqjqoKho6LVA?=
 =?us-ascii?Q?EcanLigdM/oLq+9ulSg+4pBeOTaI2/ZfcrWGIKwjTwVwqO4bKSyZaqxA4alx?=
 =?us-ascii?Q?eMtJuzUqWA5r9k9AnoD4JaY0yKodR+eYr2US9rieRFlIgs6QT+xrbYcbOHoU?=
 =?us-ascii?Q?ndNROg2JKhl4p+pvqBDaCvXzdImnX8irscqQw9XYjaORQxmZG2GCkmKcgC3z?=
 =?us-ascii?Q?OLHSUrhQHYWHbLuD09qttO5ryLizrs7ARt2T6FURcGDuVR8zbZePS1xnQG1F?=
 =?us-ascii?Q?J3O+3eN6v5Fytq07HvUBH8aRgcA16afMpcNG4gqMW2wfvIA2fh+z733bK8Pz?=
 =?us-ascii?Q?SrUOZfTasyBZ/OG17c1XTKGVahJyjbldvjnnDUeMT8GOpfMbCMlN+HNsQzjR?=
 =?us-ascii?Q?UZQvsUxBAr04U4w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:10:48.0148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4dea3b-5bde-4398-e0ac-08dd2f3e3b14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410

The infrastructure of a fault object will be shared with a new vEVENTQ
object in a following change. Add a helper for a vEVENTQ allocator to
call it too.

Reorder the iommufd_ctx_get and refcount_inc, to keep them symmetrical
with the iommufd_fault_fops_release().

Since the new vEVENTQ doesn't need "response", leave the xa_init_flags
in its original location.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/fault.c | 48 ++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 1fe804e28a86..1d1095fc8224 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -367,11 +367,35 @@ static const struct file_operations iommufd_fault_fops = {
 	.release	= iommufd_fault_fops_release,
 };
 
+static int iommufd_fault_init(struct iommufd_fault *fault, char *name,
+			      struct iommufd_ctx *ictx)
+{
+	struct file *filep;
+	int fdno;
+
+	mutex_init(&fault->mutex);
+	INIT_LIST_HEAD(&fault->deliver);
+	init_waitqueue_head(&fault->wait_queue);
+
+	filep = anon_inode_getfile(name, &iommufd_fault_fops, fault, O_RDWR);
+	if (IS_ERR(filep))
+		return PTR_ERR(filep);
+
+	fault->ictx = ictx;
+	iommufd_ctx_get(fault->ictx);
+	fault->filep = filep;
+	refcount_inc(&fault->obj.users);
+
+	fdno = get_unused_fd_flags(O_CLOEXEC);
+	if (fdno < 0)
+		fput(filep);
+	return fdno;
+}
+
 int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_fault_alloc *cmd = ucmd->cmd;
 	struct iommufd_fault *fault;
-	struct file *filep;
 	int fdno;
 	int rc;
 
@@ -382,27 +406,12 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	if (IS_ERR(fault))
 		return PTR_ERR(fault);
 
-	fault->ictx = ucmd->ictx;
-	INIT_LIST_HEAD(&fault->deliver);
 	xa_init_flags(&fault->response, XA_FLAGS_ALLOC1);
-	mutex_init(&fault->mutex);
-	init_waitqueue_head(&fault->wait_queue);
-
-	filep = anon_inode_getfile("[iommufd-pgfault]", &iommufd_fault_fops,
-				   fault, O_RDWR);
-	if (IS_ERR(filep)) {
-		rc = PTR_ERR(filep);
-		goto out_abort;
-	}
 
-	refcount_inc(&fault->obj.users);
-	iommufd_ctx_get(fault->ictx);
-	fault->filep = filep;
-
-	fdno = get_unused_fd_flags(O_CLOEXEC);
+	fdno = iommufd_fault_init(fault, "[iommufd-pgfault]", ucmd->ictx);
 	if (fdno < 0) {
 		rc = fdno;
-		goto out_fput;
+		goto out_abort;
 	}
 
 	cmd->out_fault_id = fault->obj.id;
@@ -418,8 +427,7 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	return 0;
 out_put_fdno:
 	put_unused_fd(fdno);
-out_fput:
-	fput(filep);
+	fput(fault->filep);
 out_abort:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &fault->obj);
 
-- 
2.43.0


