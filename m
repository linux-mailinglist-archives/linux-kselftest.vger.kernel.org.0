Return-Path: <linux-kselftest+bounces-33137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C72F5AB90B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 22:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC141891B12
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 20:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391CE298CC0;
	Thu, 15 May 2025 20:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mueir//u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C82182B4;
	Thu, 15 May 2025 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340292; cv=fail; b=kjqnPv8zFv7Rpz6hp2JwkeURB+iRIz8yD8Ep81K09f3lg1HiSh70KIh9yESqMGlRyn2m0I5yVaD8YCxfkKMQo5PlJadg9Ew04KHkSsQ82a7lHB5lCR7E4pFUFSREypcOmGhREj0Yljj4fkp6T2ZG5WHudjZZBdnUcK1vHF33Ruw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340292; c=relaxed/simple;
	bh=sXZDjmQ/EADHnzisemtmH54xDOHCQ9z+3ieE4/sDz38=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIGl3Kqj7aHNQNdo56T6FcUtLKM+lg0rN8be5uBssl1rGsWYZUBSJpn/3S+t6a8dKLXTn1u3HQniJKaBI3Vt2XFHBAtLk5AmyM/40JqVZYx4a7lMg2FtBgcD4nil9MZhUpyA5dPhkIQgAfRQuPhe3l8O+9WR6hjrVBVVTxCri5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mueir//u; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqKZVI7w8IQTE4qQ8oGLHFRdj/TYIn5n653Gy3WFkLmA58lXCrTadEyea3a2TKSG2Q0Veb3nxg9moda231OtyxcxjkKj4Xz+Y0m6n2zCyQkvZhAKf9LxR7y9585Dyau/S4Kr6iF3n2kqTIQDwWudvA1qSM6nvSpYaRwlP9KG5ItOB10cHstDiIHxi3dOBNgwVTHKptBExEgBx7BB2fgLDdIbB7bbRK3AoxZlIebhg7jxWiy/znxJkCsHCGNg15cs7oS+orrWSxKjMUOLbHqB/zck7aX0KAVXQY0vpbUlzsCai9Qtnv6utYzZ8flK91oG20djgS43s9IYJKXFnD9uIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeeHUmBeJrQrvO/jxuUOmobmECHJuN5LERW3cQuCqZU=;
 b=Pkcs24SbAz02J43xe94gIEZggwxZT4ZNp62lTqy7zNdYcJhbWyH9vRY/IEIlmMRxXhubXRZzB+myfWJCOCygTdN2WYruzVxzIRwMH2w/eOJZaPLsgtbKOEspHEbT/8sCOqFZD9gQsrytulWChuLhP87e14jmTsTf5lZzSW10c6ji7QIGKF/3cgPph6AljSECx0GMpJ7p008g/cCxXLyf5Re+EKMy2mnr4yZ/Eh8gvAo4o/IaAj76keMkDmxbFRoXB2kPrIpBww9JS+C+wAGzCTBlNtxd3zrxz04RTEE4yHZcTBdAFhgQhv7YoVtefpGrLyYWhwPVCV8L5F4Io7S6mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeeHUmBeJrQrvO/jxuUOmobmECHJuN5LERW3cQuCqZU=;
 b=Mueir//uq8wZy1mk5QavojrRqRafURF3dUS2ZwUZWCerBw7df+3EtwEcv1aPyfI8In2rgAClpJRhV4agZm/gBAIczVs/mUttwy8QNKIC4+5N0k2djj+7mSbC4BWldfXvAFPB4OE/4goX5I8nWJYx42NunJYv+H3lpvvji+nTtzvJtUgltRraQd6FiowoEjEYhwD7OInr9XC3RXGegQhZviwh3K2YybtDvC4PTQ51nkp5TaFpSMps6ti762BF9fTRXKUCx+j2TP3QPyph8A4dtA/CTbRfv6IhHjtJVjSeY8obBqN1XzmS7EQdNjw/pyANe7iRdeeQ3CpGSExcQ0wJ9g==
Received: from MN2PR11CA0030.namprd11.prod.outlook.com (2603:10b6:208:23b::35)
 by CY1PR12MB9652.namprd12.prod.outlook.com (2603:10b6:930:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 20:18:06 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::ac) by MN2PR11CA0030.outlook.office365.com
 (2603:10b6:208:23b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Thu,
 15 May 2025 20:18:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 20:18:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 13:17:50 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 15 May
 2025 13:17:50 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 13:17:48 -0700
Date: Thu, 15 May 2025 13:17:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v4 18/23] iommu/arm-smmu-v3-iommufd: Support
 implementation-defined hw_info
Message-ID: <aCZL6+vsOri+WqXa@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f70cdcc21df7cf07ae1da02aba8a5aa932718a25.1746757630.git.nicolinc@nvidia.com>
 <20250515171706.GN382960@nvidia.com>
 <aCY31VOs62/OAaca@Asurada-Nvidia>
 <20250515185629.GS382960@nvidia.com>
 <aCY+rXsygxjHYRhK@Asurada-Nvidia>
 <20250515192329.GA613512@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250515192329.GA613512@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|CY1PR12MB9652:EE_
X-MS-Office365-Filtering-Correlation-Id: a52a667f-6980-45c5-423b-08dd93ed9a12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UBdzoBiMglyOU+flK/leK0Ie/Sxekz/gdJ2v0ceiE5+8fs8IMmhQfco7pySH?=
 =?us-ascii?Q?B8tYyPVLqR5QmH338w0FHDunT7qEt6zEVqYLmSzWsLaUJsjFakbXy5EOar79?=
 =?us-ascii?Q?pM6D8DOGRWevc5+sLAzRDXxM3KuIWYXPgIZpF/JsGl9jVHQj5x6bG3ruJm/Q?=
 =?us-ascii?Q?VMIKd7SBNo0qAWrcGg0A30MzrLSFV1NNByhQxNm9/XWb3bJ2z7/mwvvb/Lpu?=
 =?us-ascii?Q?SMz+k6hBrc6J2yYD/KYNPQhQENlAaojJKj7bfYIFqVZY3lDggOYdvQR72Bng?=
 =?us-ascii?Q?6yWWG4DQ+xoFHTDfo13pUgYLLDwftxOCJXpXanQ+42tzvdueNCVyNeHpHJXO?=
 =?us-ascii?Q?xt0yljjPMgaWBLociuFe+W5yeA95Yu0keZSEmd1NijpAqtDqDoQLpBguFhzJ?=
 =?us-ascii?Q?Kc2tantTlVg+J5o0I2k8p8nWZJzigj9oB8CbkFHEgUBoddA50HEeA5Fhvf62?=
 =?us-ascii?Q?fly4oBA+r6JM4axjscYb8tQ93JyayxfTj3ZsObSPqQASTnrfoE5DbutEfEme?=
 =?us-ascii?Q?j/4zfr7VhaaV1savasUSfbJlSB+IlzkCYZdRjfalc5hLHDEStRFjbnwkGl+V?=
 =?us-ascii?Q?cPl0ehGTlRNyUoRgTWrVQYb5YZlNfepkn3ZLM1FanUDYPW22z9QmwX8mOa4v?=
 =?us-ascii?Q?D2bkaTH7n7NWVIbG/vsJ7jI81/sqgomCx0PxEAB1xnlIWyizSBDmlWoQjwsm?=
 =?us-ascii?Q?Veo7ckrLbO59YJRN3zx7FMA2qM0KGVUltLpBCkVt1ScCVSEz9p1jrRBfCV9M?=
 =?us-ascii?Q?f9YY8EY7wlj1C65949ZOA7yT/PYR28ErAI1S/CkKch70+0Ugn801e+UEyysA?=
 =?us-ascii?Q?AHw7taKdfdxkefl4JspQZ5rxM9+Z0LEGBqLVhQC2gV09t8lovPIlTx9ekujC?=
 =?us-ascii?Q?1ICBpxPi1N5i/uwgDGdTEtLM/SBO9UUsaiD5FAQvwZQ5ktv9GDjFQrVZMW2v?=
 =?us-ascii?Q?/bmFsfljWLsU6lOMXgIWyxoE+QxrMGyaMGXholmYK5EtDhv7UvNZVNiuidrl?=
 =?us-ascii?Q?lwYqTxrdJq6+r7NW+TbHoWB837kz93BnHvSLrwYUJ5Tyw6d2qsoCKtxyCIhb?=
 =?us-ascii?Q?30G7WwkO3zwZXyhy39S3MufdB/ddUHhEOA7IJsX5fkqa3nH196xNuJtnCfqm?=
 =?us-ascii?Q?4+9kLfMG58sr72USbFdio2ZpC6VUnOHtmhBHS3E01FSnXt9SoLRk+S8QRKrV?=
 =?us-ascii?Q?VemzLMIK0h/EmDHXYplym4uY3gkbvdYOUoucL49zkm4/n9I2URDUOKBtzXnV?=
 =?us-ascii?Q?KH8kKXTvE4HX1qLSwEgzj+YwtAjf9ilkLPBR3lnQEw/iClfOaP2WVNH26r2o?=
 =?us-ascii?Q?yGuRLRH8gYFWaEbIgaxQYV5QMX0PGz0A4sr0O7/GdzoCisBzm3/+LPgWGph0?=
 =?us-ascii?Q?4Z/jrpSWOshkAqHwbzKSLjyFsjlScEIIdaSnW36MLuZh9e2GyF4efKSxN7bp?=
 =?us-ascii?Q?+PBLdx1xQBqSQGhnrby2Md9tq7CnfoO9eUwd06h44vkqQ4rPgQBZ5DRWcx/N?=
 =?us-ascii?Q?4gzezpxHyT56YD50ASQg3I33xzeYcenfDQvV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 20:18:05.5916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a52a667f-6980-45c5-423b-08dd93ed9a12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9652

On Thu, May 15, 2025 at 04:23:29PM -0300, Jason Gunthorpe wrote:
> On Thu, May 15, 2025 at 12:21:17PM -0700, Nicolin Chen wrote:
> > On Thu, May 15, 2025 at 03:56:29PM -0300, Jason Gunthorpe wrote:
> > > On Thu, May 15, 2025 at 11:52:05AM -0700, Nicolin Chen wrote:
> > > > On Thu, May 15, 2025 at 02:17:06PM -0300, Jason Gunthorpe wrote:
> > > > > On Thu, May 08, 2025 at 08:02:39PM -0700, Nicolin Chen wrote:
> > > > Should the first call return out_data_type=CMDQV while returning
> > > > the arm_smmu_v3 hw_info data? Otherwise, VMM wouldn't know what
> > > > to set in the input sub_data_type of the 2nd ioctl?
> > > 
> > > No, either set a flag in the smmu_v3 hw_info, as you were doing here,
> > > or just have the vmm probe it. Given the VMM is likely to be told to
> > > run in vCMDQ mode on the command line try-and-fail doesn't sound so
> > > bad.
> > > 
> > > And I guess we don't need a "sub type" just a "requested type" where 0
> > > means return the best one and non-zero means return a specific one or
> > > fail with EOPNOTSUPP.
> > 
> > OK. I think this would work:
> > hw_info (req_type=0)     => out_data_type=SMMU_V3, flags=HAS_CMDQV
> > hw_info (req_type=CMDQV) => out_data_type=CMDQV,   flags=0
> 
> Yeah
> 
> > Or, would it be simpler by having a sub_data_uptr:
> > hw_info => out_data_type=SMMU_V3, sub_data_type=CMDQV,
> >            data_uptr=iommu_hw_info_arm_smmuv3,
> > 	   sub_data_uptr=iommu_hw_info_tegra241_cmdqv
> > ?
> 
> I think the former is simpler to code, you can just add the req_type
> to the signatures and if the driver comes back with a type != req_type
> the core code will return EOPNOTSUPP

OK.

Maybe just turn the out_data_type to be bidirectional?

Then we would only need to update the docs:
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
- * @IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that do not report hardware
- *                           info
+ * @IOMMU_HW_INFO_TYPE_NONE: (for output) used by the drivers that do not report
+ *                           hardware info
+ * @IOMMU_HW_INFO_TYPE_DEFAULT: (for input) Used to request the default type
  * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
  * @IOMMU_HW_INFO_TYPE_ARM_SMMUV3: ARM SMMUv3 iommu info type
+ * @IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV: Subtype of ARM SMMUv3 for Tegra241 CMDQV
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE = 0,
+ 	IOMMU_HW_INFO_TYPE_DEFAULT = 0,
 	IOMMU_HW_INFO_TYPE_INTEL_VTD = 1,
 	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
+	IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV =3,
 };

- * @out_data_type: Output the iommu hardware info type as defined in the enum
- *                 iommu_hw_info_type.
+ * @data_type: Bidirectional property.
+ *             Input the requested iommu hardware info type as defined in the
+ *             enum iommu_hw_info_type. Requesting IOMMU_HW_INFO_TYPE_DEFAULT
+ *             lets kernel pick the default type to output, otherwise kernel
+ *             will validate the input type and may reject with -EOPNOTSUPP.
+ *             Output the supported iommu hardware info type as defined in the
+ *             same enum iommu_hw_info_type

And similarly in the iommu API kdoc too.

> Finally we end up with only one ioctl enum number space for the
> types, which seems appealing.

Yea. Avoiding a sub enum is nicer.

Thanks
Nicolin

