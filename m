Return-Path: <linux-kselftest+bounces-35892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F10A3AEA69A
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5EE1C2853A
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241412F1998;
	Thu, 26 Jun 2025 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fzbA6B0j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2172F0047;
	Thu, 26 Jun 2025 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966534; cv=fail; b=cf++Duc6LVkRB85EFHUhY5cLBMYXmwsHWoUnnzyBKNoFahYEXZODnvq8+/V+X4t0FdiVaf/ULUNs7PiDSlysZSmgsC9LndkT/dMmrSO6MWOtzBHPlKBy5h7UVKNYkla/9CTtLQrr6QW7fpwifiAQDl56tpumR1eWVhcGiYHdTCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966534; c=relaxed/simple;
	bh=g/XHBpzwClpXhX9Avg8a5UhVX9rXmAQ8EaTa5Pg8RQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OA4LfxN3PmWOL7WHrN11cZGFltWsh6A4DOuPDrCtPgQ52SFuYL2v77xPL6sBqVxWY1Hn+GoUi2ZmVteRR6XU/B+s4PUTFImNtzOGPKz3HZ25DtHPIxvaYjrasTFpDTV7ipLJySo4QcotmK9w6SWgYRtSuD3e23cDXjofEh69UKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fzbA6B0j; arc=fail smtp.client-ip=40.107.212.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLfRFBHI4iWnr0BqqHit85zqw1RAcyM1agStlA4QZm7MynHimJUOxXiCwF06a4O+Ld2P4Df4UI1EhPn8PrVBPJ88gWFtI25ZfvdDMoe9wNSxbfvVvL4IjWAjOjFC3pQMQzAEo95CZFU389LSYDbCPb1fydgYQZBPLjin1A8P9lCNHBOTDksXnwOgh8ITbLAlODKR5Gv0Cm0hTTbFq7jgNKP4NgacFVnzCB5yv3b6yAzMeIYUMBe/JhilTf4mnplMcX6L+vVbEiiUiU936pocMpUp0Z1yKCFOwZeWK+tDyj/2Pu7/gL6JWmzCMS6i4Ti22chndnrRBEZHKoK9hGl/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2urNujoCbfVjgh75rFz4HYYLC4oj/nztPYBRPw44wY=;
 b=N4jHAOb1cmLAHiirck2j3LmptLhbIkOeZw5cm2HDKlDV1UDN3nS9jthaZwIaZBp/Y9NTGW3PQOXjtzk+OFv9FFNO6WWnhXZpbs+tm8MN24RX+VdZaMxO9LujttmLXQ1FBDmT8QrOzxNcwq8VZ+SbCCHMiX+av/1VKv+ygEYExNCmuJt8j33FsDn2yQKoqo1/mPiQ4kkmmvOx3IMvAU2zjDxJR1p0SKIKHa2WueW73T2KO4m4+plGwnUI2YKhkyXIGp//4gmfvHtVzapsj+3uE2vwJpu6xP23SDC3zzoBz1kMkUTR9VI5O1J9A6raXUaGewBe2ymT3oatnqIUJBnUwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2urNujoCbfVjgh75rFz4HYYLC4oj/nztPYBRPw44wY=;
 b=fzbA6B0jKIiPnZc8gt42sWdjgamTj0lZRmsf59t9lBHUvKQ7sqkSsWH5fNWGPdCXdnPYlX6bTH8qqpAw0xwOnx2IwcfoA1Hhy/JgssN8Qw0elNs+oVtdAh5RSByFZ1Vd68Vlycl7zSxxU46Foq+E+W11jH8vgn7YZ8s7IvzYz4Z0tdj69yTWdUlVie+Ac990HKTz973to5lrpYY1NGG0yG2dhYOFUXNcqMaHunBUFtcF86+Axthykr6E3vUfnp8HV3Bq4Tk9VJOjXUy+NXnsjwGS/W3FzkoWYn2ag+Klv7c/15v+A9xaWJhQkEtnWPOGu9QxMZyD9VMrTQX40fvyWQ==
Received: from SJ0PR03CA0057.namprd03.prod.outlook.com (2603:10b6:a03:33e::32)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Thu, 26 Jun
 2025 19:35:29 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::f) by SJ0PR03CA0057.outlook.office365.com
 (2603:10b6:a03:33e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 19:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:11 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:11 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:09 -0700
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
Subject: [PATCH v7 04/28] iommu: Add iommu_copy_struct_to_user helper
Date: Thu, 26 Jun 2025 12:34:35 -0700
Message-ID: <ec0c82b79cb4f3aa90c54c4763e42c7b6d8b5ca7.1750966133.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750966133.git.nicolinc@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: a7597bab-e7d0-4801-e764-08ddb4e89baa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?apU/BAD/auh8ee4NirNDxLYUXmgQu4JtszXcjAhkAV1so1X3CxJR4UFosP25?=
 =?us-ascii?Q?y7m3c32ikXuAXtI1eEw7Yw6ulCopcdCcstVQxJ9bYTCZT5QWtQvnaws6k+OY?=
 =?us-ascii?Q?QEelixKOud7O+OJznV0VrKmCgD2mxntkKupMmWQG4vBjW9IE0DSZsgPcb7he?=
 =?us-ascii?Q?SeMJDxvh5CTj1zD+1/7E1qaeMlXpw6sBGPe3n5o3KYOSBYlr4aN5gk9cDnZX?=
 =?us-ascii?Q?Zo8UqWkJZFdu5JsH2YuV1lQHPSaxQANc4Yf0VVOGRcEsd07/74pAmoFTVdTW?=
 =?us-ascii?Q?JLuwtxwtWK14j0hrYg012P7AO5mVpE9+p7dJrE9MC1DzmxsVYkNufPzxglO/?=
 =?us-ascii?Q?qFzgJCs1SFNHKJD0MTIewJ/tVgf9OkqFK+6D/2mxLKHi58y252nuikW0BGud?=
 =?us-ascii?Q?wmzZlVLYCVfleKTe3ZCoBMVKBpX/3A6bTpAsSWtKU5QbD0okkR06hMPGUUo8?=
 =?us-ascii?Q?RHmrWpEjSj+ecmGYQUC2w1WMRg4rlY6kzKZKbn9XIIFbQXX4/BOHKk5MjWYk?=
 =?us-ascii?Q?G2sUaVs6tSfM5ru5EYkl2jp2dQq0QlF9ffyzDe5CnA3Gw7IM8TkjmPrEC4XH?=
 =?us-ascii?Q?zU1hGoIqD+ZXjAHTQdqYm+0K8qTm4Vcg6IWA0F6LUAk1KHJWHXzPT44ggn0O?=
 =?us-ascii?Q?+YQAyMjbw0X/aPLbYj82xHXM1kGlLeLVEwh3rKyZeker3MRG48rI3oNE478l?=
 =?us-ascii?Q?4b4zsDPknjRWQPxLTiUX0eespkHqAiwnCx20EkSunX75nRk4CPdti/1yOgFH?=
 =?us-ascii?Q?w/cTPnd1CwgUZcmcxyI7wDUOi1rMr1avY3qTVoUnLIdGcsA1KfqrGW86GGoN?=
 =?us-ascii?Q?MizIfmpIDioi6y5H8O1lVawuWBeH/GcSV8f5iuUKUiIRHi8j5lJU9cTy+6Th?=
 =?us-ascii?Q?9vaXwdty4BBAtQMOiU9fY6iINn25DHnN14xklQw0dBHIj9UtyMTbfXGih23z?=
 =?us-ascii?Q?Le9DxBYF5Hh9BcMpZNCqf+zqwYbrm7FvKwWx6169CETSdWX9lOKD4hpqR1wl?=
 =?us-ascii?Q?nYOTxYrEMQqY6lVlBKPsBlkk4qGVl9tWl+pXaXtbLTXr5BoW1x7Konab3M2Y?=
 =?us-ascii?Q?FANIH/T2HluoDFb+30LJ5bhoYliPwtqYJTs3H/qaVE0ipJjvF/y+wdepHaH4?=
 =?us-ascii?Q?rHSBbT9HhPvSZCcjmb04Ut3yGRPQ0cQG9PZeaNesP2TjH6N0BarbNNsvq2rM?=
 =?us-ascii?Q?inUsUF+blXzVyjsJJBEGIaX0FhlPDYKJJgl7p+ZvGcRAgjnW9Mktwp0gGeoF?=
 =?us-ascii?Q?qxjeII+NToDr6KMwgD2U1e09E7j31Quo3KjSnr5YyEhthUUfo96qC6vHqXQM?=
 =?us-ascii?Q?ObkRyfoDNjO3yvUaA1NDErjEmU/uGbjRbTVr2tQ77WXVUWVJq+fX63N4CNfW?=
 =?us-ascii?Q?0d1/IUcUlf7QB2GXyx8qpeBsraqvTUtc5YgSAHb/yBDzZeaxJ+XNsBZiJYU0?=
 =?us-ascii?Q?RT/INSYmYFkfUg1PrT+uc0L3k/1Ks88vPGvRK/ALEl6k58HbSSBuarxEjN9O?=
 =?us-ascii?Q?0mYIZ9n/qUU51zjRbGviNwz6Z3USSDyxfoFV?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:29.2713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7597bab-e7d0-4801-e764-08ddb4e89baa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952

Similar to the iommu_copy_struct_from_user helper receiving data from the
user space, add an iommu_copy_struct_to_user helper to report output data
back to the user space data pointer.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b87c2841e6bc..fd7319706684 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -558,6 +558,46 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
 	return 0;
 }
 
+/**
+ * __iommu_copy_struct_to_user - Report iommu driver specific user space data
+ * @dst_data: Pointer to a struct iommu_user_data for user space data location
+ * @src_data: Pointer to an iommu driver specific user data that is defined in
+ *            include/uapi/linux/iommufd.h
+ * @data_type: The data type of the @src_data. Must match with @dst_data.type
+ * @data_len: Length of current user data structure, i.e. sizeof(struct _src)
+ * @min_len: Initial length of user data structure for backward compatibility.
+ *           This should be offsetofend using the last member in the user data
+ *           struct that was initially added to include/uapi/linux/iommufd.h
+ */
+static inline int
+__iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
+			    void *src_data, unsigned int data_type,
+			    size_t data_len, size_t min_len)
+{
+	if (WARN_ON(!dst_data || !src_data))
+		return -EINVAL;
+	if (dst_data->type != data_type)
+		return -EINVAL;
+	if (dst_data->len < min_len || data_len < dst_data->len)
+		return -EINVAL;
+	return copy_struct_to_user(dst_data->uptr, dst_data->len, src_data,
+				   data_len, NULL);
+}
+
+/**
+ * iommu_copy_struct_to_user - Report iommu driver specific user space data
+ * @user_data: Pointer to a struct iommu_user_data for user space data location
+ * @ksrc: Pointer to an iommu driver specific user data that is defined in
+ *        include/uapi/linux/iommufd.h
+ * @data_type: The data type of the @ksrc. Must match with @user_data->type
+ * @min_last: The last member of the data structure @ksrc points in the initial
+ *            version.
+ * Return 0 for success, otherwise -error.
+ */
+#define iommu_copy_struct_to_user(user_data, ksrc, data_type, min_last)        \
+	__iommu_copy_struct_to_user(user_data, ksrc, data_type, sizeof(*ksrc), \
+				    offsetofend(typeof(*ksrc), min_last))
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
-- 
2.43.0


