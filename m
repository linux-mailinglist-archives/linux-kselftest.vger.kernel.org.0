Return-Path: <linux-kselftest+bounces-36610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D2EAF9D1A
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754DB5871F1
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E644E14A4DB;
	Sat,  5 Jul 2025 01:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G1XB329j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B83413D891;
	Sat,  5 Jul 2025 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678045; cv=fail; b=GxZUDMuxqiH/RxoUQCuq3PyGPr8LaCYmaYK7eSsxVd8GJwhF8saD1oE/lyPhDL0mIjnAbaCKOzSemq0kPI2gTvyreotqE6LiabV2sJxpVAHmLV2HvMrXK2IaqeY2GBUSurAnlW8yDeTg0gu1UnL6jJ4rfVFXxHU7me0DLovXdIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678045; c=relaxed/simple;
	bh=mVbfs4A3PfkFD7Mj3imA8Fa+Bc2ATv8znEhKbkdHlqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Riw1laDTWA5kQHbeNIDbtIJMmOgyPzh1PMMflANAQyH9fqSyNJaTs1J2KUsCFoaTRzpmQsFnuFC2gRvr581mjklacnL8cKStBOpOpzw5Yzn26hwZkfvem0V8wkf7Hg65ak2YSR91pj65awiAwBIKXytuOUvQ3reXwVYQ5oRf2DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G1XB329j; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgecanG4SEUsbJe6E0dmdqjxZ1PXSUM2yzsfiPDXq12czD1lcglydaw5m9+XoDLU7/g5KiKKcfk03b2dhPaz9DIDD8860N8VoWV0ikaXU9h/yUkkLrCNfAlQarvN69Pj3DSqD48KPtXOOlf6z0bn0uEHyn2GexyJhBIltx/arNvzkRFHXw5LTVM70gClhyd8Cbv4tjeSdsOm36g/T5QTBGvc2XEPU2U3snJRztdI6Lydgmb+XiRmoH0+C6uPteEFSsEgqLKHC/uIobef5LqpWpBh+0uoij+vlwEt1CvVs8PhUS1PPVN1qBwds6qtjIOGdnD/4onzSaxD+1+4k/PWdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuQuBJklB5Nu3RNQ1AqV3nSBbHg8uNfKvlxaY9qt4FQ=;
 b=EWZfEtKO5TbFy0+8aVaDNK4vXHPa6W2nDnLC5khOhiDraN0HIXR0LV5Iwc6MIUjJ+sB1xLlJW9OQ8Ag0mKW0J1fk7xBPqd8V21KFuqeQeXPR00FjxkjU54nU9hunTVCBQxaV5aHRlq3eOryOGcMXsFG+Q/FjkkVPIJOdMxuAA3B6/dy+8C4rMOKldf2wFBtqckCAMAT5fvHtjp89bOJXiUSM8qIFp6AD7E1g/dU1C2/KVoK4oAbcX6tyTDxJ1kdGl3Fu3KtArQB4uqkpT+93se+sOtRKG9Tn7w5OMJg8gYcm5DV8EwH9wstyCA+tMvlt6cq/iaxKIGw/1qjaTji+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuQuBJklB5Nu3RNQ1AqV3nSBbHg8uNfKvlxaY9qt4FQ=;
 b=G1XB329jttHBnbfo0EOf2MuawLB2/6T+4UylJLRsbtte7dIT+75NuLcDT0dyuztXmi0euLQ05GQCrNd5oagBGSeR4dYS+mT8i9xQBtpMMBZWn6uZ+sP5bgvipzE2kZojdUgZFA/jwquWzffJZ9BtsDAmHIB1Heb8UeOBWYal5XNh9hcqnB7XIk4vV5VW+rWWomFVve34IFd1sbFafY8kIEh3hXRN2ORnWht3Ijxa3StD/AjlBGdBb+PUlGp4VxVOQLYq6yOBOwScVGY5lm9BeOKEVollCbizpB1WNzidZ7RdJdlTWzeMjBB6KMDdxFFRxX2t2kXAlPSx8iYekq6Tfw==
Received: from MN2PR20CA0042.namprd20.prod.outlook.com (2603:10b6:208:235::11)
 by CH3PR12MB7737.namprd12.prod.outlook.com (2603:10b6:610:14d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Sat, 5 Jul
 2025 01:14:01 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::f6) by MN2PR20CA0042.outlook.office365.com
 (2603:10b6:208:235::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.24 via Frontend Transport; Sat,
 5 Jul 2025 01:14:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:14:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:13:58 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:13:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:13:56 -0700
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
Subject: [PATCH v8 02/29] iommufd: Correct virt_id kdoc at struct iommu_vdevice_alloc
Date: Fri, 4 Jul 2025 18:13:18 -0700
Message-ID: <76f3643814da7319cb730070275de7e79c7ea026.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|CH3PR12MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 1092d08f-bbac-41f3-7bd7-08ddbb6139ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KBQCfY0vu6RSIG5SJSUFAqWjJFHHt1k77GtrrDnmRt5mAuPKlzqCSGSBewY3?=
 =?us-ascii?Q?bZfuCdkryo7SVg2CwtH1c/JUk0rnsSWx5QfcdtJgJSvepKa8cZBVd4CimInZ?=
 =?us-ascii?Q?a24Of5aij+igZ6PUSsKa82q5NKjD4jDhKJmmFGPH0oqAKUan+GY8w6NY09ph?=
 =?us-ascii?Q?ARyuMMzXJav0TS0yRxdc+Nj5ByyujaJh/X3w781Y5TzCWWfH4ovFTm/L+hZD?=
 =?us-ascii?Q?hmnebdjwlcxAw50RXpRAHtbQEd1MC5XGhh8T6Gl9rLFPznBc/PT6OQf0dKuJ?=
 =?us-ascii?Q?tDCDNA38an86M5YFsBhxBY+Cy8AYyjxYoliW6IhE63anpSVZdUXCgB6xaq7e?=
 =?us-ascii?Q?kpQKQ11GA8XHcIHqOiE+MDPwxLrTX95SKCf4HGoeoXwGI2Vnuf4TqSQseVV6?=
 =?us-ascii?Q?YgEXNm7MqnyKuNUc5hGuKHEr7XwZ3QvfIUBk69tpjNLgvcBEsRHQz3v6JjA8?=
 =?us-ascii?Q?wkzQFLSRKnaIxWoie3Nc3TALQR46NLPhVjVsfXA430bc3/tHgqLMkjvJhB65?=
 =?us-ascii?Q?XzPD7x6QaQd86TZYfmqLSNBYUZV2E8kZoeQ0lE4zTGn6yA4oh6am7Kl0lxKv?=
 =?us-ascii?Q?MBPFHkxYMh2Bgm2DkG5fhoyP07DhAUjyeAuGpPpXhmJGRBjz6ja78JGyG6Zz?=
 =?us-ascii?Q?muPn18vs1lsejmYDgZUGMSi9l47kKE3Yel41K+xLcfb6ppL5o3DW+ZTQJd+e?=
 =?us-ascii?Q?mZxtg31i0cpTGYPuPOIzNukvlGaZzkcrS1tNEs6qxknp246KxxPhy/ZP66sT?=
 =?us-ascii?Q?sFhu09cc8K8eFu98/V8736SevNDkY3WZOkggt1pvYUesoCyfv/waZRjrFJy9?=
 =?us-ascii?Q?RCkk7QwZbFRZiHAPqid4cIO5bRcsfMqsS5qDPH4+nhOlAgyZZM3buWkv/v/d?=
 =?us-ascii?Q?8dtj2HCwb2Wa1LMpIWapHj/djFFAoe4L4VAZUQPau+vchGRXRZ37/fLVlAeS?=
 =?us-ascii?Q?ZPDaohKY/6rzzTzSeUiEbo/vE1AQLnkmJ+dpaNtz1g97AwmIlgPBpbob9AUS?=
 =?us-ascii?Q?FrSjSrJ+aVMmYtuvNHqh0CofSkfPaOCQsgMFhi2xeWnYRX91ZcHPSlKJlPfQ?=
 =?us-ascii?Q?US51IcijzhaBjTFmJyOtWECipTIk6AfUfOUhPhyqgsMXJSQ5I5JuNr7zpqe3?=
 =?us-ascii?Q?LCiPQOrZbAotJ595G3+SE01q917qsc87qLhj/X2HgdM92aDFy5amaEAuCLZo?=
 =?us-ascii?Q?+4pb/j7jnNPYMrxlnWbowTHwAOS0pTlvl7eNym3nhgqzlYxKMMz2Hkx4uy16?=
 =?us-ascii?Q?EJzvnsT9daVHM36n4UHMaG9gNHGkN43ZwjfWC7M8n3aVt5JmD3L9XAvIPpZ5?=
 =?us-ascii?Q?c9Rmi3YckrVK+mTKTwNVng/plXQ8cxFU1KcXbw3OaeZpRAoHuUJO/y7IkSJR?=
 =?us-ascii?Q?yuSQNiJyNVw2/TnhKsvBU4hbotvMsMxKe0wM/VZQstWC7lJZzYw5kOiuT9ya?=
 =?us-ascii?Q?TbSGEc6mVmlVc+fIB2HAcldKxOTHS/+JfCsNxf1odZBmpjXv1uxOvxa2DBvE?=
 =?us-ascii?Q?KXqH3QQO44WBfTsTMj+r3e2cOqeTt+Zwq0YF?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:00.9246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1092d08f-bbac-41f3-7bd7-08ddbb6139ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7737

The userspace-api iommufd.rst has described it correctly but the uAPI doc
was remained uncorrected. Thus, fix it.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index f29b6c44655e..4bc05e4621c1 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -995,7 +995,7 @@ struct iommu_viommu_alloc {
  * @dev_id: The physical device to allocate a virtual instance on the vIOMMU
  * @out_vdevice_id: Object handle for the vDevice. Pass to IOMMU_DESTORY
  * @virt_id: Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID
- *           of AMD IOMMU, and vRID of a nested Intel VT-d to a Context Table
+ *           of AMD IOMMU, and vRID of Intel VT-d
  *
  * Allocate a virtual device instance (for a physical device) against a vIOMMU.
  * This instance holds the device's information (related to its vIOMMU) in a VM.
-- 
2.43.0


