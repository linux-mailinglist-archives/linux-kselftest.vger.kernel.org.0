Return-Path: <linux-kselftest+bounces-40694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B52B4282E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 19:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1853958165C
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 17:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FBE29DB99;
	Wed,  3 Sep 2025 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UK4TROG6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E6B32A828;
	Wed,  3 Sep 2025 17:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921615; cv=fail; b=CylUi4Rlmot+C0lsnX2U9vsHRHZPNvOtOVO0vmSjLLhTni/3+X5DXuXGM6+mAG9Lx7XMuTJpw7KECVvxVW6z3vPzT8NRzxTPlCZSkRrEKPWk/3s8/mIXaCtHggq31SwqpFcY+Yky1wqUnQFJ7/TFQL5bGS7zeQ2iFUPkgZmVk/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921615; c=relaxed/simple;
	bh=V4OOjYK1VmQsntzgAqM29OsxQt5o2oKfev0Q5IQ2jkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CkFD9traeWPT2jRz9+QVC9W1BO1C8ocNyg6K3iiSrA/RcntvLB2iT0lnabbPwgwpypbWnjuf3mcP1MjZfh+MyYbFWmyMskLvQsAEtTSaieHYLBE5RRBsSUIbNWgMt4yPM/yrWMKsp4dj62hv/kwujeG5nVvoNSA/d6dKRGTNx8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UK4TROG6; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMuAKZcCrC9IwE0X4Kz4rv95b4ap+bqmynuhyy+ArsmInM4qMa8+QxJJc/UUw2+I5aGlOCy9C2rOkJQXxiKayb/Jl4aK72Ot6ZuIL01EA0CpqGa2ja5apiyk3I1BLAqdUCTEMDr3JEsO6aWzUVrh9k/VrbCUyo+UEapleHggEiDegfeAdYlvb4+ohBkFljo0WPKn1vIBkIFTbTscvRa/NVLSdphkmKUzZQWmJ/7otLUN7pbDcczr2ILm+ExsnszouyGsgDEcmkXsYluNqoBO5Q7VJLuv5vz0/LvHAYG57H2ADNUk5eIP/mCNie/N0N2sqsFkog+Kc3UjLEBKEv5v2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UH5UhFAs59OatF+u+c/38Bbmyj2Etr3x1S5ur3h2lcU=;
 b=XICgKmKdRepmzJJ9GN/SFyytULqcLHI3HSDMC6UG4Zw2IhZKD/3aqLcPi582SVN2wrR93xdMMlGw+S8JMCpTiTK2TvQplyLvr+ygcp3u8TeU5+PMxXMtvfiuFyKrPfxQZUuQ9FdZ6e9j9gWqws8ClHgIVGzqA9FklDqLTyKOHr0AO8Lwn+566vfuLckbCZkT5LbSXKzQh9tuuuJ2mXhXW3yQJNq9isI5vRNVZuIwBnRhuVfZuKRY/OH/BMZSzsK8J4dQdw67HP7pW7cAP6dSY2LubIRfvOa6WGzBGWSzjO1552Xg8V5jUqzSsYayApM05RbXUbJir0cRiY+ZmTdf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UH5UhFAs59OatF+u+c/38Bbmyj2Etr3x1S5ur3h2lcU=;
 b=UK4TROG6QwbWAdAAbCfNrsM1QfxOzhU8Gnx7OZyGuOdmr00nHeF/r3BrV/JbpcZL3VMc5hkyO+7B2f2EQmz2IUTMGCnrg5Oy/UbmdKlLUDEMadHyFkJ369Q9qAP0haouFKW1l+xiUJBtjqjEvnNhcyfXHG74AICTHNsBxr6gGzH6d5pV1wU591mnb/pCv9Lvph3gm/5FbfEuY0kijgBPb53+JLFVaaDCs/iv/TdYTy+8xtSJyM6UExBAFQsx4CQf9io3MbeBiZzXR5j2TAS4Ga13oGZiqLXUYn80iYS6kif/6SR9HYz+OX8T9KetYc51/ASel3Zj/u+3/mUsTgCD+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 17:46:48 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:46:47 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev
Subject: [PATCH v5 08/15] iommupt: Add read_and_clear_dirty op
Date: Wed,  3 Sep 2025 14:46:35 -0300
Message-ID: <8-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::9) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: ab721354-a1e0-4e43-4e90-08ddeb11d8f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QeLR8Q85hFonlIteKP+UWwbazgn9dN7u8HaeNfe68WQ64HiHRpe++y56/k7H?=
 =?us-ascii?Q?FU4iINB7HW8LNfu1fI8paBM20j6PusWgjjRHbi11wtmkdR2Ve7Pbv0e9UFRT?=
 =?us-ascii?Q?L0dzHMyenbENncUv7kLl0cPcKGBBrB25J5YcOY6g6TBIeOGnc5hqqa/AXd7A?=
 =?us-ascii?Q?pfgzMEfbH457vQDXFMJ+ZRFh790JhlDODzrX5M29tQhsz5fVwkDphMitqQZ2?=
 =?us-ascii?Q?u7be0MkYDIAD0xF2Q8Z8SQlX1GpTe/1EOWmHzwknXwrHE1RsOPuXvBLH/I8C?=
 =?us-ascii?Q?kyWycIvymsRmZQdbvpMerM/90dJlrFpesNvu1lniPNN8LFEeD80MELhNtG1+?=
 =?us-ascii?Q?Ru/0VLWBy7ZGkA2luBkhKkHj4bLrXfCAdsLe5HpH/HWdzeNmMYyqV9nK+hRs?=
 =?us-ascii?Q?UKQMFdI8Wt3FkTdZvE2xixsK2+l+efzVLfRCZrlt3Km7DLJ8boFkJdDbzDJ3?=
 =?us-ascii?Q?cEKGbih4gHWcWYGFIkWlaS+kuK2nqBZ4V7f3IL3vBHee1QFUHq0r1gziQOod?=
 =?us-ascii?Q?rAynf1KJ7Jtv7yhD7UbRwJybn+OdhQ7R+8asvHn2mbb5t6XE/guugjJnOq7Z?=
 =?us-ascii?Q?YKwi2EKI29Udb+cvK4YZ3fbQqsr9ovKYN/UQklWdeprkUTFOnKdVULapD5nf?=
 =?us-ascii?Q?bYyLtiiK0GOMvLNdjnVWYUEz0OQxQila3/L/SRv4Vi+TEwqCCXyN0P3vAsix?=
 =?us-ascii?Q?1yTyF0kDXJzjUICGO0qNJTmQ3QZ1F0l2DjYyXnefDtg9BbEeAJQZCGgJerQF?=
 =?us-ascii?Q?/MUEaI/6EoJY5xTV3kjuH5Upc7z4oLj7CHurWQH7Kg78cpxC9SD4QLhGTqM3?=
 =?us-ascii?Q?EBs56XLidcBIJGvQ7uaY76gDo9wnXhsLSeQ1Vu+NjYY1DWxylKvidDevG5Va?=
 =?us-ascii?Q?SNSSGnFrYV35j1xDjB4p2/1aa4s1wBmkQD3HRiZFi0CVunPkH/go0WdBxTgM?=
 =?us-ascii?Q?k12bCi0tYz39boGFrgUhI7adxe7bGn1gZQJO1Tv12lqlU8I3z7imZ1mTITSE?=
 =?us-ascii?Q?pc5gP+GPyJANV1MyMZc0NBURAc6lIg75lfZCAPl+D7JGMVVzfu3IgErnGvni?=
 =?us-ascii?Q?0QIX95CRVGVME0qypLUUqes4xoW6UnqOBWaD8ZBczySr3voOLdN5kbvopZG6?=
 =?us-ascii?Q?k89NShuO7cB5Zel587lUN6/l39Y1j9F6DT5qbh3DK4x8ZX9Jp+gLUis95LpY?=
 =?us-ascii?Q?CePqAFXbPoK7fKaTI7LFOpIODfQoerVRNb1+/CE1jeeNY8mv/t/pgAj4QYcq?=
 =?us-ascii?Q?NPaE/Znfz8s4S0UTbOfCbv1YuAr4VyAQvb0JOcDaoDGbIt9BFw2DwMGNu/9q?=
 =?us-ascii?Q?2FPVF0QQpfRCB0pPnZjV/DT684+R7rtwLWgMZKnhmTqMlE5eF/puyczu+OMp?=
 =?us-ascii?Q?Meh7VUYHI79WEZ0S63Ts50sB4HRv+PIhhaAuj5T2+Z4L5hhW2axITE9x+zKr?=
 =?us-ascii?Q?iJtCeE4myDBrXHv0oPrp5JOZd8WLZ+Ty?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sQXYiZqO6+jJ2vmyh/StfBj4EfI0NViWiy9QjK2KHqEEjfe8kxSxNejVn+Vx?=
 =?us-ascii?Q?+QO/XDfWqqAKciNPBssWPpjQZ/ScjIPE3S7TchyfF8mi94Lwe6cY21Eiac8l?=
 =?us-ascii?Q?VNWyGzh32rp/WoOBYojfeGEeFe5wvYrMCB2KNcWE+cq2IsLaL7gdt2AoAQB7?=
 =?us-ascii?Q?gXCX2R+6g0mQRqB/xn0kZOcRnYkse1V8EICguZQ10Tem1prJdR3sCk/33Qp2?=
 =?us-ascii?Q?zeJJeysWv9ux+bZEak1sjf4eTqMEZMgrTLFgz5Uc8JMSqKVkMGmWZXoTW2Yu?=
 =?us-ascii?Q?q7mM3Od0Sc/9RLCEolncSyQmlDus7LhTzU9LqDqGB80/woYMuLqzwS6MhQGU?=
 =?us-ascii?Q?W4cEbZ0cVClcnphIavWmTwCTVmqPcjQHIusP1XM5+mTw+vyLvjWiHzyvvXPP?=
 =?us-ascii?Q?JkBbVoGafUewwHq0V0QfGpF/TvorLViuSGuEM8n2FnY5eD69Yo+BjSTfstHo?=
 =?us-ascii?Q?LUkosFpps0jNAbENvWsKAmIdSoAqBn1hM/Bei0iIt/gkcNUYXun4P3Dkzguy?=
 =?us-ascii?Q?ZuImnXpkryvzoPH5guMkRnpYSyhzaWkIRh84F6amWYMlogpVFO+V+LZQsTel?=
 =?us-ascii?Q?ygKvB/IntE+e+3b64+ND9BBFIHa2egQ+sZpYkHBTUSeY8UYLXbl8t3aLYyPh?=
 =?us-ascii?Q?gJ+Uic5kzsp5ScB8dRwJ9L3bWzZJY8D48lGJWV+dG8SMMP16wiRhTuWrHQ1O?=
 =?us-ascii?Q?wErDVGWkCpzSEwVo7Oj6LlbjE0QTjwmWUe8AMYjz36CgRATfv+Nac5lwX0+J?=
 =?us-ascii?Q?L4+GZFvr/k5leM+HwbFXrW28msRZZ+YuRxA7oKqkVwvgUrvS41N9ZIT8tm5B?=
 =?us-ascii?Q?xuGiPHp0tjzF3Zi4ogDiYmAkE/MFIgWDYhk3KxGlCMy5orzna/ECv5Kj/X3g?=
 =?us-ascii?Q?q8fL6nGnYEojr+6IFKErzGrfla8AmJ44dYtv4CDbszC8Yvbe0jHT3dOD0BeD?=
 =?us-ascii?Q?dw1Qk9ioDjfYSPuuEFRdz5s7PVc2XN9Z3uiYVwluc4EIdFY4wuPiMCloCOtk?=
 =?us-ascii?Q?mRMYTAmcvEz7XnYHHSYBzDf6qAf2y10ITJ78M2PYKPEfoLN9qr0/JZuz+Tab?=
 =?us-ascii?Q?Q9IepxZatFp43smNsBl4egzseGZOF4YPdwyRDHrOsSo7K9v9wrBOYOUiqJHG?=
 =?us-ascii?Q?nr7NBu/oqgeuhFrPesNp9SjbByHW8B9oHVI8Zbxtzav4M2pl19aOEPggN2oW?=
 =?us-ascii?Q?S1eQs0EfIUuNvWkkKSK4mP5wwgjEGg2VRmAREuBZrvaS1LwY2lO9fGiP3jry?=
 =?us-ascii?Q?QCYN2cZcKlXKMETu++LzaLH3GHzsCYR+Lz+ch2Ty+ZvVxi1FFUIT1y5XxAeu?=
 =?us-ascii?Q?ByiYvdxaF2E80YBYxKIvTje/WnN3FaMtiolIASlDWm/eKV09HNk788VCDxUj?=
 =?us-ascii?Q?4CJNf445SYhjk2nOTS2Kc3aUS74wbq6T9hANPKkJIFFs/FRkMKdlP+PrVEi4?=
 =?us-ascii?Q?W5M4gzpZ+KtJWqCP0ocaD8Z7XA+2uq4CFEMlYzWqU3mxA3sraqthz8cHh9ga?=
 =?us-ascii?Q?hGSleJD+yYnwIMi5Oopb3RljsXVlX+mzam9B8UUuVuzegtmsARiHUaFFkPnf?=
 =?us-ascii?Q?aJMKZkJfNbLK93c8nug=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab721354-a1e0-4e43-4e90-08ddeb11d8f9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:46:44.5662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZt3mM6i6CEjlcl34pdmEPFbtcf3G/7jVGKrvK8tvWPZokQn+BdRp4cq+e0+bcyd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

IOMMU HW now supports updating a dirty bit in an entry when a DMA writes
to the entry's VA range. iommufd has a uAPI to read and clear the dirty
bits from the tables.

This is a trivial recursive descent algorithm to read and optionally clear
the dirty bits. The format needs a function to tell if a contiguous entry
is dirty, and a function to clear a contiguous entry back to clean.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 104 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |   6 ++
 2 files changed, 110 insertions(+)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index f15c4ca937c222..c9062e3bf3efad 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -162,6 +162,108 @@ phys_addr_t DOMAIN_NS(iova_to_phys)(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys), "GENERIC_PT_IOMMU");
 
+struct pt_iommu_dirty_args {
+	struct iommu_dirty_bitmap *dirty;
+	unsigned int flags;
+};
+
+static void record_dirty(struct pt_state *pts,
+			 struct pt_iommu_dirty_args *dirty,
+			 unsigned int num_contig_lg2)
+{
+	pt_vaddr_t dirty_len;
+
+	if (num_contig_lg2 != ilog2(1)) {
+		unsigned int index = pts->index;
+		unsigned int end_index = log2_set_mod_max_t(
+			unsigned int, pts->index, num_contig_lg2);
+
+		/* Adjust for being contained inside a contiguous page */
+		end_index = min(end_index, pts->end_index);
+		dirty_len = (end_index - index) *
+				log2_to_int(pt_table_item_lg2sz(pts));
+	} else {
+		dirty_len = log2_to_int(pt_table_item_lg2sz(pts));
+	}
+
+	if (dirty->dirty->bitmap)
+		iova_bitmap_set(dirty->dirty->bitmap, pts->range->va,
+				dirty_len);
+
+	if (!(dirty->flags & IOMMU_DIRTY_NO_CLEAR)) {
+		pt_entry_set_write_clean(pts);
+		iommu_iotlb_gather_add_range(dirty->dirty->gather,
+					     pts->range->va, dirty_len);
+	}
+}
+
+static inline int __read_and_clear_dirty(struct pt_range *range, void *arg,
+					 unsigned int level,
+					 struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_dirty_args *dirty = arg;
+	int ret;
+
+	for_each_pt_level_entry(&pts) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			ret = pt_descend(&pts, arg, __read_and_clear_dirty);
+			if (ret)
+				return ret;
+			continue;
+		}
+		if (pts.type == PT_ENTRY_OA && pt_entry_write_is_dirty(&pts))
+			record_dirty(&pts, dirty,
+				     pt_entry_num_contig_lg2(&pts));
+	}
+	return 0;
+}
+
+/**
+ * read_and_clear_dirty() - Manipulate the HW set write dirty state
+ * @domain: Domain to manipulate
+ * @iova: IO virtual address to start
+ * @size: Length of the IOVA
+ * @flags: A bitmap of IOMMU_DIRTY_NO_CLEAR
+ * @dirty: Place to store the dirty bits
+ *
+ * Iterate over all the entries in the mapped range and record their write dirty
+ * status in iommu_dirty_bitmap. If IOMMU_DIRTY_NO_CLEAR is not specified then
+ * the entries will be left dirty, otherwise they are returned to being not
+ * write dirty.
+ *
+ * Context: The caller must hold a read range lock that includes @iova.
+ *
+ * Returns: -ERRNO on failure, 0 on success.
+ */
+int DOMAIN_NS(read_and_clear_dirty)(struct iommu_domain *domain,
+				    unsigned long iova, size_t size,
+				    unsigned long flags,
+				    struct iommu_dirty_bitmap *dirty)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_iommu_dirty_args dirty_args = {
+		.dirty = dirty,
+		.flags = flags,
+	};
+	struct pt_range range;
+	int ret;
+
+#if !IS_ENABLED(CONFIG_IOMMUFD_DRIVER) || !defined(pt_entry_write_is_dirty)
+	return -EOPNOTSUPP;
+#endif
+
+	ret = make_range(common_from_iommu(iommu_table), &range, iova, size);
+	if (ret)
+		return ret;
+
+	ret = pt_walk_range(&range, __read_and_clear_dirty, &dirty_args);
+	PT_WARN_ON(ret);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(read_and_clear_dirty), "GENERIC_PT_IOMMU");
+
 struct pt_iommu_collect_args {
 	struct iommu_pages_list free_list;
 	u8 ignore_mapped : 1;
@@ -1002,5 +1104,7 @@ EXPORT_SYMBOL_NS_GPL(pt_iommu_hw_info, "GENERIC_PT_IOMMU");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IOMMU Page table implementation for " __stringify(PTPFX_RAW));
 MODULE_IMPORT_NS("GENERIC_PT");
+/* For iommu_dirty_bitmap_record() */
+MODULE_IMPORT_NS("IOMMUFD");
 
 #endif
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 2769689379c26d..21dbe0bf3880b3 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -12,6 +12,7 @@
 struct iommu_iotlb_gather;
 struct pt_iommu_ops;
 struct pt_iommu_flush_ops;
+struct iommu_dirty_bitmap;
 
 /**
  * DOC: IOMMU Radix Page Table
@@ -181,6 +182,9 @@ struct pt_iommu_cfg {
 		struct iommu_domain *domain, unsigned long iova,               \
 		size_t pgsize, size_t pgcount,                                 \
 		struct iommu_iotlb_gather *iotlb_gather);                      \
+	int pt_iommu_##fmt##_read_and_clear_dirty(                             \
+		struct iommu_domain *domain, unsigned long iova, size_t size,  \
+		unsigned long flags, struct iommu_dirty_bitmap *dirty);        \
 	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,                \
 				  const struct pt_iommu_##fmt##_cfg *cfg,      \
 				  gfp_t gfp);                                  \
@@ -201,6 +205,8 @@ struct pt_iommu_cfg {
 	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys, \
 	.map_pages = &pt_iommu_##fmt##_map_pages,       \
 	.unmap_pages = &pt_iommu_##fmt##_unmap_pages
+#define IOMMU_PT_DIRTY_OPS(fmt) \
+	.read_and_clear_dirty = &pt_iommu_##fmt##_read_and_clear_dirty
 
 /*
  * The driver should setup its domain struct like
-- 
2.43.0


