Return-Path: <linux-kselftest+bounces-27497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3961EA44893
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA323A3C47
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D51619C54E;
	Tue, 25 Feb 2025 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gS3GVBVg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C745F194AF9;
	Tue, 25 Feb 2025 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504378; cv=fail; b=kiZjcQ3frFnCR38TQA4BSnsyjoOEye+rJZZUQQ464/yAP2SqUTWhPUEXLdzrY3YPWNUa76WG1xdD9WtVz+f6N6LXget+o5LjXspPKp4aZv3ujyou46+LAXHw32H+QmP7tV7yI+KFT2SdrZ9eE7dCiwMdM2diRnmeEro12ULKkiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504378; c=relaxed/simple;
	bh=wTio0yv2gBQ6U/iSzwRqq4uQ62BJLdo0YHTuy/VvcuY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRfh6AKiQ22GNqA4demabC+wegfkcT+I7pXrsLFQAnxEl2iZAgY51T5kd1CBMQFp0IiJS6qbmUTFSSFcQgKK8hWxlsg9g5ihjyoEQpX3eCx6I/pEgs+ItyBTHPiCqU9UMyGxDHxRWQgLqk5LM6JGskdEP3+fABfuMoLX+1WnABI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gS3GVBVg; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urumEOebwD9SITutNBsgwCStPWnitLwa5SuuN3jC3ih4Dv7PvgUrVuzCENRAdpeQ3ektjmr18I7okR5rRfeQKMzVgpRtVAfAajT928q1Dj3Smi6Uq0Bxci9xmnozH88u2uE5xDInQNIkvtVjLPBJzAMQ3UHLYEkIFuoSu9qVMVcqW8vMdQztrtA2VODHj87aNz01pBVQM3eAGyDgZ4Cr6u60mce8lJ3Ug8+YcMf+sm88+p9bQbw29JIiq0vp8bC2Iny6as38SJpJ+jM4YvgTEkdnmcxqudH6mLONt8Cc2UoEXVzckOzbxb5Ob2LfUyEbhsFX6EfuQ0PKtU3PBzk57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUNM+8Bv5Nfzbqa7qDebAIwRc+J2TKyqV+0Ykxi7QjI=;
 b=pt76skWU1IuC1SC6fiBLO/bpvozONKNgcpUZjpThUzaHJkkpV/gNfao32XiahAu2daTxq8NE4760Pc9BSEHGfXC02sQmo53rCuoa4huwe+NbmVRPp1zZ/VzKl7oHYPxt4BB1fvY+jHnXaXUUvDCxw1DOk9Y3IYhh+W3589TJaGZOgFBTPcUK71Yut2FsI6G4gXs64BBpHUh69lSF3h4RoUkez2OJXfYjO/fcyf0HNoE2hveJ9BSywCkWOuB24UQvCGgfKhzD4Oknat+UOu8WEXtWqGPmmdiQparip53kfifrjvhhOSitDqEj/drGu6e6/W5jsxwWKwOXtp3w7w7/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUNM+8Bv5Nfzbqa7qDebAIwRc+J2TKyqV+0Ykxi7QjI=;
 b=gS3GVBVgYaWHXKbaSSktDSXjbWhlDx3IvRp9M6GI8fqz9zupRj+4wGIckYqDtXdC7ZLwNKugOMuc5msKndZ+VQDBicPilbwCPNzK0oHabUmuhcxQxJekEJ1P8SgfBMf0WAEz2KxjPvKNXSML0fwNzyVucPICv9i0bz73LrEr+K9OUBl4ppEUN2fDuumUZc+wBaXAlHWrB3ExAJomco/uwYbGy26U1xN2cYJeLBV/8+xa2PkWN2l3bLqmhxXg+569/lcdMl8FNmZhg9g/wGGQhvmlbRfTIX5dwTP4l1YhFzZ9efbuAh13jkgx8026vnAy0iwdpN4FnC0FyMGmSw0Opw==
Received: from DM6PR07CA0100.namprd07.prod.outlook.com (2603:10b6:5:337::33)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 17:26:09 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::70) by DM6PR07CA0100.outlook.office365.com
 (2603:10b6:5:337::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 17:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 17:26:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 09:25:55 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 09:25:55 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 25 Feb 2025 09:25:54 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v8 01/14] iommufd/fault: Move two fault functions out of the header
Date: Tue, 25 Feb 2025 09:25:29 -0800
Message-ID: <14a01d676b06dc7c013edba6961a4c1e9503a4e1.1740504232.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740504232.git.nicolinc@nvidia.com>
References: <cover.1740504232.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe59fe5-6667-4c96-e8b7-08dd55c17e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mRuTuulm9wrdzn6jXv4Kv7FRbsmYC8JpZPkrCAs9JHqbhwM4zpGMQjQeBEfX?=
 =?us-ascii?Q?LIV/yX2y/J+2zk2ufgOhHFPXDyPPSQBeiht3kN7AnposRdPYL/Oht9IhjqlA?=
 =?us-ascii?Q?utVXl3QNBnbckglG26/IZ9QVN28nDoWvs1Qru6T4L9nsbuHGrHwi7aNDzg/y?=
 =?us-ascii?Q?r6KMpUjsyXRRqfg9/JrBpEbh2o5OdTnYTB5OxjLkF8mMl/ADOWhB3ZaOZOVa?=
 =?us-ascii?Q?R4brleNk7cwPL7OSD+gSXBpy+eQ72uAJRZAgBYMBkg06nwWxyFRCymvpu9de?=
 =?us-ascii?Q?QrQsPIz70EsCtS9/4xoyrcBFRY1OO5EwzsmSjLKYU6k6yfKMh7bAOthVP1BE?=
 =?us-ascii?Q?5dJK/ESwNnehLipXJ6Szm4DY2jeQymEKLWiFdbHWBj8dt7ArMgBzvpeVWSXf?=
 =?us-ascii?Q?mNzpGnD7uAnE/dzOZkw0kEg0cNnPXN08dpXZ+zg4v3/e8DRMUG3nCRxoAwzT?=
 =?us-ascii?Q?DzW5v92AoQJkg+CBXu7eeuRGrjhLolbwV/Yc1JNpN0W/Lg3oCcuxcBqH48w9?=
 =?us-ascii?Q?eV9seQs/+krHPXUk8dRxIneXhxl9ZWJeZdP07JsldSaE5fvt8LeCg8j/YzVR?=
 =?us-ascii?Q?XiWNizLYMnjDCyI3Jhj1x7htwCaNM5BQeyUcPzeXLzly0VWkUG5m3F5coMAB?=
 =?us-ascii?Q?Fkro7mMtSn0WZI8TjULu//aPZdXvzjSR/DQP3B+by8yXfHK4ISQTuwU9XdN+?=
 =?us-ascii?Q?ypLWaVWNYrao0TmLsjUDIaIuTpoLN5ObC5E7Aodpv+K5a0svj21H7lBChg6n?=
 =?us-ascii?Q?mfjUp3tpBQuIGNdcv6j2P1YeCtjbtR0VpBZX0woQhZDOa4DssuDd34/eSjAL?=
 =?us-ascii?Q?cxSlFIxx1YALWpWslMYFVmVYLU5eR+eZZD7axTqUL3b02DF1i6Q1eOZPflri?=
 =?us-ascii?Q?lBf+GdvTxMsf6ehLiRJ43D7XGn37a2D5o7xXlIgYF94bUMTGRw66R4kCIFCK?=
 =?us-ascii?Q?xec/L/sY2fIgTPabcCSS7zgwCXwBroCvjs8DEHsir7HAvsfefo9tB27lmC4h?=
 =?us-ascii?Q?2e0LSMG+VzZWHbMDCLoWF8BZ0R9vk5NpoEBVVVgYruuZ9XPoLqd3jh95zHN8?=
 =?us-ascii?Q?zyoiSTAOMsZTvJfbaabvNVeM+eqUBk+l+2j+YQTytYaOWWpa9yUO29WgOVpm?=
 =?us-ascii?Q?MUPV7vePFTPSGfqwXroI/0P9ECk5hKtaWUCxd5wi5hWTQtDGESuldS/iNSs2?=
 =?us-ascii?Q?3Nu4J1fxoe32oo7cvuorGMVG8sGIrL4JbJA7AgPxIBlzeW10c16AELk+e1T3?=
 =?us-ascii?Q?BmC/kRASojmrv19+arNru+RSMXlJLJb0zXae8sIuAhaRVN0gI+jWZRQisofc?=
 =?us-ascii?Q?pV+jKrtDoF5IT5I4i6/lKnV3L7bv/3zsCdopUcu8lqJFW7thmdLgR1LkJ/JL?=
 =?us-ascii?Q?Ao1rJdvIlvlQnRasznja8sb8ck5R8yLZ/x6JRp3mZbc1hvQtrh7c+R/JlsR6?=
 =?us-ascii?Q?ixkkNnplHMPD0X9wxqDPirbxWQk1aLqQybWz6jwrPMt1ZuXc6G0wHo8ZcH4g?=
 =?us-ascii?Q?ymd7CuRFpBO3I00=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 17:26:09.4605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe59fe5-6667-4c96-e8b7-08dd55c17e84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713

There is no need to keep them in the header. The vEVENTQ version of these
two functions will turn out to be a different implementation and will not
share with this fault version. Thus, move them out of the header.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 25 -------------------------
 drivers/iommu/iommufd/fault.c           | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 246297452a44..1c58f5fe17b4 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -472,31 +472,6 @@ struct iommufd_fault {
 	struct wait_queue_head wait_queue;
 };
 
-/* Fetch the first node out of the fault->deliver list */
-static inline struct iopf_group *
-iommufd_fault_deliver_fetch(struct iommufd_fault *fault)
-{
-	struct list_head *list = &fault->deliver;
-	struct iopf_group *group = NULL;
-
-	spin_lock(&fault->lock);
-	if (!list_empty(list)) {
-		group = list_first_entry(list, struct iopf_group, node);
-		list_del(&group->node);
-	}
-	spin_unlock(&fault->lock);
-	return group;
-}
-
-/* Restore a node back to the head of the fault->deliver list */
-static inline void iommufd_fault_deliver_restore(struct iommufd_fault *fault,
-						 struct iopf_group *group)
-{
-	spin_lock(&fault->lock);
-	list_add(&group->node, &fault->deliver);
-	spin_unlock(&fault->lock);
-}
-
 struct iommufd_attach_handle {
 	struct iommu_attach_handle handle;
 	struct iommufd_device *idev;
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index c48d72c9668c..29e3a97c73c6 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -138,6 +138,31 @@ static void iommufd_compose_fault_message(struct iommu_fault *fault,
 	hwpt_fault->cookie = cookie;
 }
 
+/* Fetch the first node out of the fault->deliver list */
+static struct iopf_group *
+iommufd_fault_deliver_fetch(struct iommufd_fault *fault)
+{
+	struct list_head *list = &fault->deliver;
+	struct iopf_group *group = NULL;
+
+	spin_lock(&fault->lock);
+	if (!list_empty(list)) {
+		group = list_first_entry(list, struct iopf_group, node);
+		list_del(&group->node);
+	}
+	spin_unlock(&fault->lock);
+	return group;
+}
+
+/* Restore a node back to the head of the fault->deliver list */
+static void iommufd_fault_deliver_restore(struct iommufd_fault *fault,
+					  struct iopf_group *group)
+{
+	spin_lock(&fault->lock);
+	list_add(&group->node, &fault->deliver);
+	spin_unlock(&fault->lock);
+}
+
 static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 				       size_t count, loff_t *ppos)
 {
-- 
2.43.0


