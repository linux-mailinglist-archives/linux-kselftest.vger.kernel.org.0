Return-Path: <linux-kselftest+bounces-24394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B893A0C0F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 20:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431A918848CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 19:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D471C3C17;
	Mon, 13 Jan 2025 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HLmy2aTk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EBC240251;
	Mon, 13 Jan 2025 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794895; cv=fail; b=H6TCZx8pxhOfIQCsRFSOr8eVUelt7eVJ9iccvSfPoCaaXZ05qlVYhnOmfRvFrQy6fjYc7TANq909QaBwwDOrhdiEUfuprvlJmYpXRvHwRLqqFOJaoSFP7luOq56h23kRyVPPxrjuo1/ZNrR3xQ7hsRrDDKOmheEMUSiPQnQtitQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794895; c=relaxed/simple;
	bh=e5D6dxFdL6les3qOyYYqsCy23v57A9mn81iH43pBOqU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpzgLWZKYT3w0+TTMUEi6uuug8Y9UPMhEWAVaLL2eMC1TK1P3s5zho8JIJMIBuEI5tPKqNJ1bW1aL+R1TZwP5fOF1vDpVRl2/ezMSBwDpSfQHp+kgR9yVxJUr7v+Qn5k8hy3a0Qx2glYviUwbYHVGSZ28EDi7zoYFhWSBfaLPBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HLmy2aTk; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YULzVPJCeoNPp4GeXlok1o4Xa/Mmz9eDCs+NV9zpsuTGe5PrEIOysiQwbfaiB2K3/NyCE2xM2pR2cr/rFS39y2RSocnnwrI0VXK+3zlzzzPcuBVXdwIEdWR1Lvy6AGRUyZuAaGUSxGL0pI5uqTyl9uSL5+JrzSeYnThH2f44OVN81WuFBi35UyH50paa4AC20VHAJqNqdveGxVzgLEiotnBI5kB1pYub1OM809GRfVPEe42s0bNas6+NB7NUe5JsZbX2XhDGpwXtZwPJXVgV+ARmJvMmEIG1G6hEueAT01nDkFt6cOpeGUelyWwKefMDlr0XT5rrs9r1Pgka8TXrVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXRBw3xLC8HkupB416xfNOcJbozaIA86suw8QpYRrXc=;
 b=byr/c0dYs9SdgwX0gQG2nqTbfMJdQPleWnAsPU+y3DtkZEOHgVypkE8z83GgPCUvDcmamV/fcr8n33RnaoT3BS3cDR7eYiyRkul9ANDJEjfXws9EGV7ZpnVIDYOZQ59ZHGLOitdCIM9dq/0Wkit5rseplcw02RM3fZlIlkkXH8O6Cpmc93GEg9VbbROI6YPooBMBg3K7v1NDd9Y/qv1TOun33xT2oUzl3+MKPCQd8STqkbmtyrQYPXiXlab/EhKga91R1QosWTUkY8U05cLlex6ynkDZK/lz4FS90CTzpvtVr5xctnf8hVACh4Ig6sv0w1AToCt3VQ1KZyWYtbSkOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXRBw3xLC8HkupB416xfNOcJbozaIA86suw8QpYRrXc=;
 b=HLmy2aTkHPYjqdo1dPfihLv/IaPbMrglQTRSTWNWdWhsFkePA5NMvb1aq6/CHdQ7AslDIR9yiahk4hjZgkGwqwIBNjNKCV2nqP2uXYJxquKvJibG914iMwEPjSHWvC5MNlDgCBRBLUPT02EVdhfMI59tLBQUsgvC9So3NtN6hVs5/n6+IJDBJkXPnO2ooqcB2I2KDih2EphhqYe4x8xpuha46Wn4h9EEwcqoPX2lX6Dn+KLH7E3fTaPA13rT5ri0ZvxLKO9ejrlOeTrzhFt3Rf8q9KA82kKgmjgQb5ugulC0ym72xZ4oiF3DCP/orY+omf8yc8AQUrD4IMCoVNRbSQ==
Received: from SA0PR11CA0045.namprd11.prod.outlook.com (2603:10b6:806:d0::20)
 by SA1PR12MB7151.namprd12.prod.outlook.com (2603:10b6:806:2b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 19:01:28 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:d0:cafe::19) by SA0PR11CA0045.outlook.office365.com
 (2603:10b6:806:d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.17 via Frontend Transport; Mon,
 13 Jan 2025 19:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 19:01:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 11:01:13 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 11:01:12 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 13 Jan 2025 11:01:11 -0800
Date: Mon, 13 Jan 2025 11:01:10 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<oe-kbuild-all@lists.linux.dev>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 14/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <Z4Vi9raM/lOot/SQ@Asurada-Nvidia>
References: <03c01be90e53f743a91b6c1376c408404b891867.1736237481.git.nicolinc@nvidia.com>
 <202501091822.4ocbIobQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202501091822.4ocbIobQ-lkp@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|SA1PR12MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b91a22-f096-4db8-232a-08dd3404af7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8f5S4/miFkdIvB1saISHe/3iUgKsEsAIdpsujnXd4lUolsK21weuueJ2zc75?=
 =?us-ascii?Q?MWdKM1MDLQOeZxGTMMj4lDb15Dj4KB5u8twnpmVtP1VYYKNcbM14TkXULzdw?=
 =?us-ascii?Q?/mibjGGJLS3eHLEvXC/QaclNnxLa6RQhflKaszhhjth8ovlBumL2I/J1IkTG?=
 =?us-ascii?Q?sSkExiNyRD7YrrB6Ca+e4YmFnZXBeCoXHfOvw8lItI7CbJefu03OU1hpi/s2?=
 =?us-ascii?Q?cmWm9hf8i1YckxbMGe8rjsUuWIjTWgtqmzSHApq0ZaoyWH0F+unA8MiC3Xx+?=
 =?us-ascii?Q?74ePAzt6dNmOLhTFcwrOdWDtolxBlKVSCmbg3/+xm1uBBWpzleSH+eHIT5V8?=
 =?us-ascii?Q?6MDjiT7U8p13tM82aUiXvEkqlAbziRjQBdFp0W/wVuojJ2MEShabtvooKbRP?=
 =?us-ascii?Q?GepjzX7bvUaLuE/g7mftkSZsp9cCmFT8oOyTr+1oDkJjKruezNXV9ZMUJbLS?=
 =?us-ascii?Q?TcThM3sUS5lLdwZQMrwRgFqt8Cs2NqeOHpN+iJ33tMVkqoxot0/0dEAFMepP?=
 =?us-ascii?Q?r8cFO/bW+aovoC0XYg/NfQuGo9lBMFcnpneV/xqfJzbYD3zEBryQOc45OC9/?=
 =?us-ascii?Q?kwbfvc1jmBoXRMdNclgF7C7xVkZ+o+2BcXlq0SxGogB6d91k4Yp9CeeaibL9?=
 =?us-ascii?Q?2gCM0BTlOHBQsLiHffUXCZgG8vsODUDUkp6LUCA4CYqhGjX+heknxCu9C07C?=
 =?us-ascii?Q?2CVn5lxr3gbc4t+O+dWrrypBV+XHCuqEG0tk63TjvEXBTa6fWYHU693Ti2Ls?=
 =?us-ascii?Q?mpPFpLEt426IFO0qI9xcaVo5NOjUf6j3fqd7u735khiZ9OurPLcjlo0y03k3?=
 =?us-ascii?Q?e2LqXeG+w5Oe2I3p0uKrZijaLXAX9UmyG1qWR4ADnMQp+qLXxxEtHiHPtnKl?=
 =?us-ascii?Q?Qd3dy8M44MJacCEZJy1Q/Dn5TllldocLTGze7pmKstkP928ttOSKLAFA20HG?=
 =?us-ascii?Q?u+3jQ8MTroCU8y9aqqJVfz2LcE8mo0vL/5sAytBZ8vjs3UjAgFYy1Q2R9eB+?=
 =?us-ascii?Q?z985WRHjJ5X84PWuYCITNrrM45pDmRBZ0IeGAyVf8LfeBj2fYiuUphc63MrX?=
 =?us-ascii?Q?Jc8bkaB4qdbUHk65COEO/zgIlOs+LRKtWc+kkvnnLysEXNnQqmgTUVrWFXMI?=
 =?us-ascii?Q?hJDOiG36omxjKGyihoXrGdOQTCgahPhREPTdJBfpxOv9quKsy67VA0CW1vkT?=
 =?us-ascii?Q?iW4+2WTZV+iI/ROevf+4Q4NgoCTWJXhKBgj+bvrgYL7OhCwRuVKBNom7kQCj?=
 =?us-ascii?Q?to8hmwQkt2K+EOCuSMyaXBcsykqdruX6CGf0CcPbdXSEqYbR54b8KOpdkIFB?=
 =?us-ascii?Q?g4Fhte857GnmUNWIZ/2FbChdoVF8m8o9+uKQOqZNack4/LCdk4Z/IZhgUbH5?=
 =?us-ascii?Q?A24ZmdC2lfnFS18IDvyGA21RJ77OkJO57YTWsPyuiHj9TvS3iMTuhE9lKTbt?=
 =?us-ascii?Q?Zrum1BKVJKqjHJGSXyXiMjb83+5NROkfPy8zh81vCjK6lDtnplxOlL4FYjdk?=
 =?us-ascii?Q?PRZdQmOWTV7SvBI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 19:01:28.3446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b91a22-f096-4db8-232a-08dd3404af7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7151

On Thu, Jan 09, 2025 at 07:04:10PM +0800, kernel test robot wrote:
> sparse warnings: (new ones prefixed by >>)
> >> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c:461:21: sparse: sparse: invalid assignment: &=
>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c:461:21: sparse:    left side has type restricted __le64
>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c:461:21: sparse:    right side has type unsigned long long
>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c:462:21: sparse: sparse: invalid assignment: |=
>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c:462:21: sparse:    left side has type restricted __le64
>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c:462:21: sparse:    right side has type unsigned long long
> >> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c:464:23: sparse: sparse: cast from restricted __le64
>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c:465:23: sparse: sparse: cast from restricted __le64

I fixed these with the followings:
-----------------------------------------------------------------------------------
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 0c7a5894ba07..aa453e842a39 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -457,20 +457,28 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 	return &vsmmu->core;
 }
 
+/* This is basically iommu_vevent_arm_smmuv3 in u64 for conversion */
+struct arm_vsmmu_evt {
+	union {
+		u64 evt[EVTQ_ENT_DWORDS];
+		struct iommu_vevent_arm_smmuv3 uevt;
+	};
+};
+
 int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt)
 {
-	struct iommu_vevent_arm_smmuv3 vevt =
-		*(struct iommu_vevent_arm_smmuv3 *)evt;
+	struct arm_vsmmu_evt *vevt = (struct arm_vsmmu_evt *)evt;
+	int i;
 
-	vevt.evt[0] &= ~EVTQ_0_SID;
-	vevt.evt[0] |= FIELD_PREP(EVTQ_0_SID, vmaster->vsid);
+	vevt->evt[0] &= ~EVTQ_0_SID;
+	vevt->evt[0] |= FIELD_PREP(EVTQ_0_SID, vmaster->vsid);
 
-	vevt.evt[0] = cpu_to_le64(vevt.evt[0]);
-	vevt.evt[1] = cpu_to_le64(vevt.evt[1]);
+	for (i = 0; i < EVTQ_ENT_DWORDS; i++)
+		vevt->uevt.evt[i] = cpu_to_le64(vevt->evt[i]);
 
 	return iommufd_viommu_report_event(&vmaster->vsmmu->core,
-					   IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &vevt,
-					   sizeof(vevt));
+					   IOMMU_VEVENTQ_TYPE_ARM_SMMUV3,
+					   &vevt->uevt, sizeof(vevt->uevt));
 }
 
 MODULE_IMPORT_NS("IOMMUFD");
-----------------------------------------------------------------------------------

This also fixes the array size from 2 to EVTQ_ENT_DWORDS==(4).

@Will,
Would it be possible for you to ack or review the two SMMU patches
in this series? I am still hoping Jason might be able to take this
after I respin a v6.

Thanks!
Nicolin

