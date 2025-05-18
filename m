Return-Path: <linux-kselftest+bounces-33257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E11D5ABAD26
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6A53BCEFB
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12931C8616;
	Sun, 18 May 2025 03:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DM+d744V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0793F199931;
	Sun, 18 May 2025 03:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538536; cv=fail; b=SezylkNS495giJtPfql1B+Xe9UcGJUjVfNxAwuPbJk72/5gRrDiLdK3fqin9Pv3BxqnSIuuJBj9npyxQwKM50iMDrtOgfCRz6fZr33p6EGXueG6HeQWBpnQWE+liyz3MH+iOFhIFfvk8tt/KO4KyWqnAYmvbCayLZyoHnm9DntM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538536; c=relaxed/simple;
	bh=Ob+QYnadrune0qKL9cRJM3uGZ3yY77dBZK9CEZIJgDM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMKxq1rtFyfuRgGYXoasH+2SEwX2ERaupl37UJ2Pa/Q180l0ufQqpeXyDvdaZKPf6zIFfm35Tn2LtekWmQd2XqSWsf3fbiIEKPN3tPvuOnqsjNaacAJK1a/ZBWdO+EOdUZdNVLvr7PhYE4RCy4VYDMpzXlsChzcHI/ptt9XNp7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DM+d744V; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNfY6Ig3cJZ3Vcn5USK3itwqT4M6AdwUzejxkR1iO9pSp133j6IjVBmu4sT6P9jr0806NHnITt7rZ9wAxFI2DvExs6vQjiya72TarxgSqYWh2DF6WLZ2AX1hmf4wSc4QjqPWHb0BKtZpoCt6Em9Gh6bBgJWbI+gZnUp05yfiPNZpFldhL+5/MShmGBgIYDas5SJF/2pL9xEpeRCt6PCETSzQEhBVDv/hxofRb1IuEb3nIEWzZ6Du2Y06EOZBV2KsMALN8W8hOPlqvT0nd9ND3M6cLRdKlPw4dEc5VDtWaTLueraY6SbI/nGWm5MHfVJWu5UrIBp9pVzrrjPdBVbt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VemNQzwPSFElZqoDaqOqqEQI3VaOXeB1phy6ZpTaj1s=;
 b=hMaApdKlHrK3gEBfBB65bz1rwiAsvF5dzKq++phYKqPVZFaAirlrgmbIGWoZfaS/cA0ArRRAKmDLyO2PNm1Waq49xckwql64wtK/XxR/KPTH4K8vQiBD4vsiaWP2hUxDhREftZAGxKAHVrDJvvMYOvRYkfrt/ELrWYJakYeRs5rns7wxcCQrIBUuJatN0N9W28ppoVivYB5SydPbZ7UY2hZW61IHlSPIBfqhMyLQhhXoF+ZApjA0EFL6yuMfTJX9+2WWIcw+1Hi+X98w/NT5YJ2eZz6gU2xBZqFoTlsW1VpBsgXWPaBPTADdxRaaZM57ZWf0FNVOO7Rr/QgYb8lafw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VemNQzwPSFElZqoDaqOqqEQI3VaOXeB1phy6ZpTaj1s=;
 b=DM+d744V/dw1y/emeLmwr2atOOeUZoTxg0tTEqskJ5B6TmgIeSDnD2GM91pKTYnaHpNPArKuhYIGVH1w+snaxtD65NB0yv1GuWuFmhmbP27pKIche8xENs+gNWFD3UsEuJyL+BUJP4P98unpe6TuJdck+XyOq9ydiTGphITQncE+5pWNoi7GnKA6BDkUMnaLPzrIdhXGkAT9sBb3cG/cmkgQd0/Bi+SAeVQl0lQI/AJgv1wimMZ/x0ixUIKhqbEmgncYm8pfc8vNsYQGNHC4bAGh8SLGgQK8i4Vp5O1Bj4JMEcgDox/ASLGnmZCuslc05GkdSvOx62xvtZtXq/CaLQ==
Received: from DS7PR03CA0328.namprd03.prod.outlook.com (2603:10b6:8:2b::30) by
 CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.28; Sun, 18 May 2025 03:22:10 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::c1) by DS7PR03CA0328.outlook.office365.com
 (2603:10b6:8:2b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.21 via Frontend Transport; Sun,
 18 May 2025 03:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:01 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:00 -0700
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
Subject: [PATCH v5 04/29] iommu: Add iommu_copy_struct_to_user helper
Date: Sat, 17 May 2025 20:21:21 -0700
Message-ID: <f6926a3651343c90fe9a9449d6a3b6f94448c124.1747537752.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747537752.git.nicolinc@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f16a45-cca6-41db-b526-08dd95bb2d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W1O0PbJSt+1YnKK4mjwLuwmcoSSJpuO8t1NkwkN2PC0sVf6UZEEdDej/+fet?=
 =?us-ascii?Q?vmZ7Aq8bkpti/VeKWwsKqogMxXwtyQMY0byVMBdReUvLJ3A0/rCPJFEmWp4p?=
 =?us-ascii?Q?er2Gga5f9YENgZa/Rgw6GeH/s8fYSpcwFmmghKE1olfLqCkUpYVhM3eJTeia?=
 =?us-ascii?Q?42zPiiYwdgoQvwhXKkfyRzIMEvIHwzecvUCY+Kk5+DkuHAlvNLbR763yShHM?=
 =?us-ascii?Q?KZLUojivgErvv3WCuU1nLqG1SD9uWtjMK8eT6o86ZE2VAAIyf+MByDrST25i?=
 =?us-ascii?Q?+Ba9/x6B6e4tykSqNTEqKS5fVaNq5uoDZtkVM93vXQ1RuU+ga+L7jr35JjdJ?=
 =?us-ascii?Q?zIFBlX9P7RhoF95h5Jbbe9s0dTYDH1HtG+xBPOv1X+2fzcrHMjDWS9ftQOTB?=
 =?us-ascii?Q?rKPVXyQ9zFMhDwoAdumamx8NnQ3c0C3u0iyP7Rklc+Z2hLJ9pl51qB8A3gqr?=
 =?us-ascii?Q?ghCXFIDoEYPRYUhHFrh2mjfP2gdG+C84AgR5FBvjF6bHh2pv/g0UXDGUUjuf?=
 =?us-ascii?Q?4L40qEs9BnwKQfw5bDSQ1N26tVWxltXbWVvjNtD02GDH1p7exu7AXJKG/+Td?=
 =?us-ascii?Q?mA3/nTdOZEP/HqV22T8SkRUq1+/VAsVkleD6Olh5cwVs1dpRlP8YhCgz2TIB?=
 =?us-ascii?Q?juqQlD6LSmh5jNG7aVO2NYJSI4lLUglyl7r1PG33zxv/JRPYGh0/m0mobaYD?=
 =?us-ascii?Q?Ssc03WZ7ZglZJHNxcIYg5MjFc61r/dPHyq0eLe6c8RGsdQCzAjSxGrvJ8kjZ?=
 =?us-ascii?Q?Nvsbm2qO9D/fOz3zYAX7oaU3MAqadkdLv9b0pIIPzrT7h9ad/D9CTixMdwZr?=
 =?us-ascii?Q?ocofgyOlu0rfaN8o0v8+3TKiWc//Kn2Ws5DSIAmLew1cuP7VyStEj4vKrdWx?=
 =?us-ascii?Q?DfT2JZGQ1Anrti+pCME8Roo1xkS8udPZJn3RzabBaIMwMPK3LUMQLE3w/52g?=
 =?us-ascii?Q?DfErcklfQgRqxZTV6n4KFjvt4SBOLp7qzGno03EJvtDwKneOR0ouGDPgOLG7?=
 =?us-ascii?Q?DZxRmP1F3b+NjghnDnWXF2KF+LfeW69QcstLkw3UBktL0zuthYOT6XEQl5qm?=
 =?us-ascii?Q?z7FU+ucAyLEiRrC9bO5HIK7PIzZxy+BA5QAJ2Ywbfwzb5k7N/4U1px+4A3VO?=
 =?us-ascii?Q?Xd1d7s5ZXv5aL/QpYtK7XOmKixQdzdhCDiWC+D58RwaE1basA8WxM/MB7akP?=
 =?us-ascii?Q?mOqk32pyUXkSCj/BW/HMtd0qkCByGbDheTFPKNH/u8L2ZQoRK1PeA7gAA++0?=
 =?us-ascii?Q?K0Bo3SUdoule2PqyMqaQhSrcEZOv531B/3JasH7k/j+Ydhyu4VN8Zjm4u79R?=
 =?us-ascii?Q?IFD/3+xo0OMyrpZyUD5XTG2You8QgwxOqK6lhO9MMRCeH2HnAS+pQVBiQenc?=
 =?us-ascii?Q?2Twu9n3jincCWxQlhLEIF0r6duhdock8fL/Gls6GfCmGfnVk/xAegdzWAgkw?=
 =?us-ascii?Q?UUUfb/FR20M330FngurMVHiXJHRY1ITK3NCG3MGN2aZwwnAQuIcArFVPADb2?=
 =?us-ascii?Q?doBNmsUFZRq1vdROlIROZVbqP82if9lo/m1r?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:10.5268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f16a45-cca6-41db-b526-08dd95bb2d3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337

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
index 0db39f922775..5f9c4eaaaaff 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -562,6 +562,46 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
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


