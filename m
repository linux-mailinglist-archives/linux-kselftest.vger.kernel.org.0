Return-Path: <linux-kselftest+bounces-42836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26718BC20E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 18:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07891894A0A
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 16:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591062E7F0D;
	Tue,  7 Oct 2025 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MK50SYW6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B282E717C;
	Tue,  7 Oct 2025 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853547; cv=fail; b=XpMZ1IB/2k7Jy7/cxKQbAFOET9hUAuGPt4uy0LTeI3jHRT0hkDl4ki5p7Cw2gVvd3EzeLtFmIQ5BImsqtH6eI0itgKyevLyJsHiKL7Zj9aiw9/nwP9IVQ6+8RLAaDVRmgwPnMZt3TVvT73YxITXlzacLCsT7ROLuFets20ruEKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853547; c=relaxed/simple;
	bh=6EKqCdVqqO2PXbSP29MfC9MnK3suaQ1EDWC8/xpoOUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gotdRCrdlzM672EJKj9l9BoC/5ZDenxVVWebdvEjpaySOwlGHmC8uFOqO/+Nrxdnh0vo4tUUUPubDrMzOChFAsXKtJhL6lVkUqFYbS6nb22rmRyjOI7e1Zj+XH1bDH610V4hFkZWxH3OlMvOfmwhQ0EVgwwKeMah5LLVzR9DCP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MK50SYW6; arc=fail smtp.client-ip=52.101.46.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgIvVJ+epiuTLhriQNNgXin67mvPpcjqxG2nWG8Ncde4Si+qY3G/mKqvQc10AyvxdbC74TyjdBC7mUe4cZel1IXXasVjfwKC/0Mg3SH+sN1wbmWoVc4q6KO1/scMLUMryKlJVl9YtMqmk8hs1ExNosTlmaRvhlC3ta7crlYj188O599J2QRpQyTyOu6Slxup//IdBw5iWFQTywmv/9Rn1I6+kDQLkYw/fmN0eRemgED9EONtvEX3lr0xwEGNhbOle0me5XD67kvU7Gzkjnis6bysIAWQ1HJ+9nwBt4EQ4Bun6VFF8cult2eX3aCJvpBRSKNpo68e2/cbrIj6WxOlBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+FcCbNaNNxsegfJ6/lRig51Kh4Nx6js8ccM4I7qqnk=;
 b=bUfqIZW+D+g2wzDqahXvWhUd9zxzvZiI52IPi5kGr4WSzIkIe+VtBb6zXu5NCH3RBiOgUr+nfFsFHM/ugcNsFxt9byHnwyu9djJg8FHsmZLWrdBrZLLMm2d6xsDAy3DF9z1/QFZ/7+5p03pbUoih4h5LA/lCtn7h5gNGC8NNMfNuIy5DXRSsgFF9Eh0ZmlvUIz464qbYq5y12UA6m6cG5mUsJaqwohTvlJyEdwPnEhOGua/UFjFm0TrQWVLeGukSaVZyLUCsMNqmJS6g2m5PeyZvJftZr2K2MrVN8m4DBLnFvxmbxWZVxD05yVR10GSM8GrbGtkC6xnR5ee1rCY4uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+FcCbNaNNxsegfJ6/lRig51Kh4Nx6js8ccM4I7qqnk=;
 b=MK50SYW6lbNHOyyxNnUiSLcXGk7PPu1qGtI3fsuNvICOJVuX/Z5AA49doNISd7IlYsblHbcJCSjZwd6ehYRBRvOJz1xyICx+ay9ofZwywyHvkiL8vXtDoKTP1zelimLBE1VCHGo/FtejCrzJf62yMbgJFEyTeMNY8CxQjTlIrL4eBLbNBIsm+Q5TcSb2Cq8mhZ/PGvyAkgIkYKyhY37bqsbWf7mCgnQ+hbY6HXwtUiP0Ae0e27wOo4DCUi5HIkck+ssDpMTLAf3R9GU3dgiSAEu27JYe79GnU8ESOFBU7KS743v6F4h8nLOyPsJxBPTBWJ7Ba3qIrku2SKloUZ0KrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 16:12:12 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 16:12:12 +0000
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
Subject: [PATCH v6 08/15] iommupt: Add read_and_clear_dirty op
Date: Tue,  7 Oct 2025 13:11:53 -0300
Message-ID: <8-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0222.namprd03.prod.outlook.com
 (2603:10b6:408:f8::17) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3285b9-c730-49ad-eecf-08de05bc4229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?drhnXnIM1Gchc1KjBeMChNsFAkLgo2nAzlWAQY87nCp+liJ3AHsSg4Yt0PNI?=
 =?us-ascii?Q?MImZZkk25AXh6ZvkaYxcCGD6P7nUbqyQJOIgrdlo3Um0cE5uBoHmxwEi0e6R?=
 =?us-ascii?Q?jp0rCHLrmW9gsT4zdnT/d1Ay9EI5BVyFMBHE6p8rG8MVZsUjfa9G7e0jVSj6?=
 =?us-ascii?Q?YJjFgBD0QeUxFXdW4DVBKhv94uYBb714H3ESe+t53njr2ww1xq+ALz1Au+2a?=
 =?us-ascii?Q?FPlwj0pqxvZfQBqJAM63SI73m26vbl8h01NMURKaVkz2EP0ihxZGkr4xm+qa?=
 =?us-ascii?Q?bcGRRJn7hq7XpluJ1jr2nqKqhdJqGDSsLTQGdmalJcw/XgC+4Ayk23XuFEzr?=
 =?us-ascii?Q?/I9yk6j+bB7mDQjZkGm/gBEpG4eUaCE+qrJ7+qMFZKReY52EiDglNbcCFrkY?=
 =?us-ascii?Q?gqlZN7J94O3yCo/fVrNIdMui8LNjyFNAzFSzhZFHfYeVon/TGXjNCv4WNQpD?=
 =?us-ascii?Q?riP6+iOiH4MWQmB1vwBZZ6SySQ/AXsy9IoEMfRcSUeV3DSGzmhMBPzO8y+Rb?=
 =?us-ascii?Q?vlcKIAbZBPppQ7FTT4XKyziQ246SEdRS73kmVYZueV7bv04kHJV4a3tXL+YZ?=
 =?us-ascii?Q?QaH93XSrfXupnMLop1t1TYc37jSTRKeu2g2OYqwKx9IM4x5bqG21nq6cJoLM?=
 =?us-ascii?Q?cHwBfkq+svG0cjWKkw8OuZl3o8WaTnHC2VIaiVhaFW4vQt4pEd+WFCny8euQ?=
 =?us-ascii?Q?TArd+/O0O1EEMF+LTY8XEQIwq6qYhr7Pt8O+2g1EAJd+ip3LMgu4b0UsyER/?=
 =?us-ascii?Q?+McrpK7+++gXtQDGZ2KEG2fB24Dk4NrBA6zmb+zcIdjavNMGNihKdgYfS+Oi?=
 =?us-ascii?Q?GrwuwCGBgfJCZVJ/NAe0k5eZet56FmyaANHptwkye1pfqGQPjvdEgAlsEmmR?=
 =?us-ascii?Q?wSxmx9x+CaR7VCgmQGRYTkTNlVJsAbXLVeaFUTNprJo3S7Ad+OgfQ/KWElOy?=
 =?us-ascii?Q?nGqeOUySnQ65VSXoCgvKmegXNG1avhHlW1Ja0v8MlL3qBqpDAwxYjYVqjDVs?=
 =?us-ascii?Q?G0q9Rfxy5mWtzkz06Smv41fhpE/bGG9gm7XzDLASxw3dQ+S3uDpysEm/uOk0?=
 =?us-ascii?Q?RC+DII5twR0I2d9yEG+DiTIczQr8NCj4kurx8ghjSpREQOcKwWARcdnPOI3N?=
 =?us-ascii?Q?zQWidMgtRkX6J1ZUXjHw6jTYfxrG+eAtez1Y2donEFLUKTkTKKod0hx2M1Cp?=
 =?us-ascii?Q?+8CgBssifZvZA8ZW9iEWzams/+/sRlIWBmzWMLv9x5KH/x0UZ8f3s8fTNjHg?=
 =?us-ascii?Q?xLvU+OAUz5VdTV8UP9cG4Q3eRzmH2skTs8TORIAW6e+R5wrPYLxsohC5Kb83?=
 =?us-ascii?Q?vmL27miGZVe7+/aiQSxf+AndvjZS24ngqj+z3on4wG8IK2tYrYpq9K/UPUvr?=
 =?us-ascii?Q?57tYpMFltVX68dCjRUAAiAB6zioU+cXR9OZO+tGaFE1SSvdWbjTcP/NMIoF+?=
 =?us-ascii?Q?nUIbwrIFF4ROBltxzsFxcikh9wWVRxZbg6FzJ/N6hJJ3HRg3uZpMUA6NzuoV?=
 =?us-ascii?Q?OD2+ChFo06Jz0eI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NU08b7D1Ib5vugI4poOJuSpYVLfInTH/dQYCSZd46hT6cDe578yOYk9FOm5+?=
 =?us-ascii?Q?U7iel9O0G0S38JeWydHEjl2FGjWOTctwwYeEeM3CO+6e781hnLFNQRPpEdkT?=
 =?us-ascii?Q?J7bHky3ZZe0o2R9E+hhRfI7E25LnNUZVvv30BKhbEm5Km7O3Jgp9alW+rOk5?=
 =?us-ascii?Q?dd+VuZoK5Lp1ZWU1kZ/aoO2pfgm7XP0vfvVth60d7dYiPt1f8VlnD8k+SAwE?=
 =?us-ascii?Q?6Ctlu/DpeKZGRWjUYG6KdZMgqTTEAty/axgCjMc8EChYDZ0C3ebI9o+fuvFe?=
 =?us-ascii?Q?AJzDO+xvaL5LWjx1KcVdRcgSP7I2ws0ATnSTd7FHAP6XohCEiTxab914tv1n?=
 =?us-ascii?Q?IzbXEayF+KHwRdFjJmagkAwxU1q9/7+sliwuaxOR1ymusnKsK/KW1sRWX2ZP?=
 =?us-ascii?Q?MdrKQVqS10lsTxJCAhZjORr32u+nAWIqns/ckNyMe1/1YuT0qBIGC4zpoldy?=
 =?us-ascii?Q?rWaWofvrSG6ivxihAc0l5Zr7jHoDpr3gOonkpyJkeegf1brvIoUFtkGx3Zcb?=
 =?us-ascii?Q?lNHJwap/UwJkmqNtjWcul3SyKaYaRBADzIUwrrFds1u3OZsEfo+LBiZ6w7ik?=
 =?us-ascii?Q?gowC9loXF48cyRu510o9KcrX8R91exz2MRS52kSxbBYPvUCl3eSs+DjMtcBc?=
 =?us-ascii?Q?+JCLttgfDs/fjkYOg6qZzDA39EFAhJ8Ya+NX+IH0VoPaOwQ/O3TRzyuF5R6M?=
 =?us-ascii?Q?vtSOjTN8+1SADuOaQ4GEJRG6a77qR0D2PT++EME1s9YHOZmPfvzRXN8qo+xa?=
 =?us-ascii?Q?sNniYpmHzotjufo6RsCxZVlBA8PagJsESKjgenSa+TpVVhyoZTDPVBcIR378?=
 =?us-ascii?Q?jw30XwfYZgXFL2WNCR9SRucwAb2X2fQtTd5G+dEci7JNnf8DHhxuJ8k6tc7i?=
 =?us-ascii?Q?Nhyd0iei+oQxm6XV+EBVg7QBxBLpRX/7TFTD7JS6XZMDHElUCYiIuQJ5f++1?=
 =?us-ascii?Q?yqfeliPbS7sx3w2Z2GvW8Lg4MGi0GexP98kAb34q2SJS9sIM4GMfQAxST0or?=
 =?us-ascii?Q?Y8ebWInvdc29jTcHbT5jiRrHozJL++wmQ4lcB9C0iMAOCZZhNakA8mctLyM1?=
 =?us-ascii?Q?i0dC8livmdLLrMhTJXnLpaBaaDlWyZd8en/5j7853fxJTJdJj+kX+/T2PsEc?=
 =?us-ascii?Q?jpkqDntikQkfxxdQBCXZDKDrI6sDhNuHC824VJ71l86K86ZnVi6xHmYIMJ9E?=
 =?us-ascii?Q?uOvMV7xEKoNdAlwIwB3lF8TK/fWBIOfS7DFpcEqwSnmNeQnABsBO6Y2YFiae?=
 =?us-ascii?Q?OKWytE7GqUQYzTg6KdWY7J95sivMFMgQbR8bpNSmgxSpa0NyumO/BpZPuBbF?=
 =?us-ascii?Q?6nXin7g7DnVf6+U6mJVc2rQvMx2pIvflVHn5tRd+OYC6DVKd9Aed357AuPSk?=
 =?us-ascii?Q?8sRC31UcBXT8L9V5I2cYETTgP1MXSOSBhw2jErX8MalNmSXl6boCQaUbNL6+?=
 =?us-ascii?Q?h6XxPQxGIRDll98zNpmXYC23t/Vhnsk14s2awTVDbsZe8OObn0RDt7QwFEc7?=
 =?us-ascii?Q?M/++lC2F7305xZhtJ7tid2vzIki/Dk0zVLB2H/5hThyOOlN43HxmELz1Vdz8?=
 =?us-ascii?Q?JAAhFwwb6/7pZAfX6KY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3285b9-c730-49ad-eecf-08de05bc4229
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 16:12:05.8203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/dI1oqNBbfjK4jd4x9/c2fiuNtgCyiOGDL2Vo89HHxOZ0s2KYhWB+lLFpLwRf3Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500

IOMMU HW now supports updating a dirty bit in an entry when a DMA writes
to the entry's VA range. iommufd has a uAPI to read and clear the dirty
bits from the tables.

This is a trivial recursive descent algorithm to read and optionally clear
the dirty bits. The format needs a function to tell if a contiguous entry
is dirty, and a function to clear a contiguous entry back to clean.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 104 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |   6 ++
 2 files changed, 110 insertions(+)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index f40eb3e398545e..f6ffc41d9b8b1a 100644
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
 	/* Fail if any OAs are within the range */
@@ -1010,5 +1112,7 @@ EXPORT_SYMBOL_NS_GPL(pt_iommu_hw_info, "GENERIC_PT_IOMMU");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IOMMU Page table implementation for " __stringify(PTPFX_RAW));
 MODULE_IMPORT_NS("GENERIC_PT");
+/* For iommu_dirty_bitmap_record() */
+MODULE_IMPORT_NS("IOMMUFD");
 
 #endif  /* __GENERIC_PT_IOMMU_PT_H */
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 621c3165d30f68..3a7885eb2e2099 100644
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


