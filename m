Return-Path: <linux-kselftest+bounces-32345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9679AA9551
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A16169E95
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 14:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F6F258CDA;
	Mon,  5 May 2025 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QUYcKePT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA2F1E5219;
	Mon,  5 May 2025 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454732; cv=fail; b=jK/xCI+3WBObesdBKCJdzcC9G+Hqz5vtHrvOVK1DwR9trsRCTCvG2rtev5eOeQXiKf9WEedK0DUpmyapjJvkHzvphJ2vgIkpgXoUBFjdrag0q+H/1gvm+Ak80woewPFn/ntlGzie32jd9mUcyDuXnQdYmlQa2hbFIZhJ+d26/OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454732; c=relaxed/simple;
	bh=CPBpfG1vjcL5lAS3F5ge0NrbKeS1HzNpQxlVskB2Iqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ax/4morgnWobG9YA6tVlYPbmB9xwtFbQo0ov7S4ZQVgcBT03O1s4dxlblgkKBe5i3AKAcWJZP2NnGdisgZxUlEWGOV50j14tb8NACwTRj+P97Q3bu5u4GIBa9PO550os88e5N/4e0fbMawEH5MYQGHwMi8zmWtBNaDjN3s4QELY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QUYcKePT; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1sn0dkZPgUa4sW97gu/8kmcBaB8m3wU5FGsmAAVQ7GlW674zxYQ4lKTKm4NKI6rOr+cySMpp37FmA63ZoH57DZe49i/mjYxRkONKCsoRM6fcWFoAjbcJgCmRgv1jla6GQGpeStytSG5chCDqBkjRFOeKbP+9We7wZQfIivR9D+sQonmUqH4eWftzvSlzmzZUy0ouG4jZf6hjsSdt2S2YGs7wZ42rZWFwTQNcJzCHP8uXxIOyXyV8oEYEIdKKNMc3HNT4yMxk1yJ5jofjCtRu3sWzWHZ/G6ZFvwdBY7EfZHf9YB3P1YJjyTXzwB+MiXio9TOgAhLEWpiDPIMe64xNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KXYfufYZDLhloU/wy33KO59zTq3HUu43do6ma2xPNs=;
 b=tJTFs5uxLw5kFoK/dzlTY3dtc2l/BN7H5PV39oSgRXtym7S+ilMRV01C7GHwa7iGqyTg8SYbal9+nGoFY2671eNruSo/Zlph+tYIKHnVG/OPYekDLjrSZm8+Uou5ir9+h+XvFd+VdXH1QDH2yaKfRynPTCA+l+mrAqYKc21ecYb/QieZfpWt5FGa+PjZfb7LS8wdvQpVNrE7hb6O1bYgBwvaYmGTLq9YEiHvll+mYCAc2egluBKw2ub/eWMcKzRSljspvJEZ8kf9c+OYQcZiB0Q3i6ghwfo+7izLW2dtd0m3p+NU+3GW2XnOh6DeJdj9VlEhznAS3ywCTBRPqj4Vbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KXYfufYZDLhloU/wy33KO59zTq3HUu43do6ma2xPNs=;
 b=QUYcKePTTB2kKZ6IGs3XXA1vHCp8g80rmI9b6THVP7TIRHcNw+EEV0kTd4hIOxUELDB58eRIkmQVng0/zdgEdP2wxlMlbp5HWzQUQtf9pOTcrnjJdjz4BU1J4x06BpxSC0maoOZ7oRPLgBIzC4BgSvLp7boKpSulZZNfZxYLJwX3s26SPO78p8RVUnmfAjG2sYSlKUyt2jq84QwspBGewa2lkCeWgmCgxvP/UYDduNwpveLsskMMLCx3JGl8pqt0m7TbgzMEMlSPUVCeXF5Iu9wk4X4AWSuBWMNyQli4y3eR3pWSfmKrDaRGD0cArGBQ0JYAT2kh/DuzbKg16Iy1bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Mon, 5 May
 2025 14:18:46 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 14:18:46 +0000
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
Subject: [PATCH v2 05/15] iommupt: Add iova_to_phys op
Date: Mon,  5 May 2025 11:18:35 -0300
Message-ID: <5-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: c4dc1ba4-5528-423a-08e1-08dd8bdfbf75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ZhW/yQ0NknXOwFnj5Cn6b1lss9k3KChAlbD3IYKeoi/YPd2euSu5KSUyUP6?=
 =?us-ascii?Q?cTfLQXlHbRAYTVev8Eg4Vkop2y64lKsHZIe5VjvObw7NO74n3i2q86rOo/mI?=
 =?us-ascii?Q?i+G/vYfAxDcPp8qwcv3dcicVez3qSqcblZ8T42SnhZl5vtwdkZBCtVkpRSlL?=
 =?us-ascii?Q?N82kayWhDXR/FqGmhaW6cZM1R+GKWEaympl+2OZDZwO8ljqBGgLrBeKiZRga?=
 =?us-ascii?Q?zHq8tZ7wvkHbYPP4C7yF6Ll4c02SN1A9Xn3pBq3lUD9q10tgaljc5EbdDUz3?=
 =?us-ascii?Q?4xZh2q3F+70oyg+tagHWXgBJLj+6WMOdzQ7EsckvbAuJQsSUrOzzR5bRPyjA?=
 =?us-ascii?Q?feogmxneV8pOrSZGxk5cQEqHMvTQdMVmTeIjJm5msy+kX3ny3rH+btR0dlw+?=
 =?us-ascii?Q?mPP3ZjhFvoqJfBLtY86dbbO2WZ/qYKRuD/OYaRmYazfyokqUIl4/gDP4wF9I?=
 =?us-ascii?Q?v2y578qqKax1duZ/az5ImtJhDScwZ80oARCvkSHucOViVggJifhXedt71Cx3?=
 =?us-ascii?Q?MQBNDClAj8CDYvYgEJMC94ghy32H4tq/LzBsx/93OK9PR3JJ1L4WYGN79N5W?=
 =?us-ascii?Q?fAr4n0Hessz6WekB1zbz5Zh/AGo1DpQNmYnFMhSXQMPDcnzwBqBkq8EXPfNL?=
 =?us-ascii?Q?5pKpgtl+iIT5avIqAVZ//xKfa+UWcfs0E5NkwGmJbUS1jhwONu0LZzwJLEFn?=
 =?us-ascii?Q?q8oxnj3eoEAGMYcm9mV62HyEDgHEIUlF08nTL/30/ijco6iFeIcNDlzAefic?=
 =?us-ascii?Q?pIqVzIFYvlRtUTs0sWC/msE+vrxU8yJB238w+cbIDC4XnCt2//547TXrstVU?=
 =?us-ascii?Q?oqtOV08CM/Hcgzp2Ga4YrLUEDoBWjskIWe8ME8zRKI1qpHnS4THT/tbE4jvc?=
 =?us-ascii?Q?px9Awl62l/QuawjWGEphD76IcXxIStuBr8lxD7a+zNXuLK1syaeg+3ut0VcR?=
 =?us-ascii?Q?lIOttWkL3NupXTKbPKsi8aXVq55BXEBo1bLVQB6GgQ2G1g7aBmlMkxzm+MKc?=
 =?us-ascii?Q?aHHb17hVPn+VlNpTcdlKx2qeSg3PxT/L3+UwNJvWJRSC2TLLu0/G4oMcZBJC?=
 =?us-ascii?Q?Iorit64o4HMaP1OIYaK91seMqtk2Jij6z1U+Vg1/SIiYo3qNVz8LCXOG1caS?=
 =?us-ascii?Q?3oA9v+NH0b+FvDlWgVHb8VS1M6LBH7FbTrL1pSX5gU8mJwePjtDN2ZXZCrH/?=
 =?us-ascii?Q?Hc03rSrGoGLFnosMZG94vB1PY+V5ryXMN+1eJ1bqou7Wx+brY9OeR+fcEn1w?=
 =?us-ascii?Q?IQms+DTOupwM/ex8dzxJcCjgDtZPKA2mtUKlagLfzx958/ZwGKl+X4FbrUH0?=
 =?us-ascii?Q?rWpGDXZUieoQ96CErY+UHyVkkOcJoHnxEXZfBRfr+qxjnfSiOoKZllBpHGtd?=
 =?us-ascii?Q?WZcaGNAVSfoaMDzYi0BL1cieKqA0ae34Q+/o6H29oCkN/8oBBV7uOr93OkUo?=
 =?us-ascii?Q?T86C98GM/KIxTUk2du2lHxNJWh5q+iiu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rzad22vSpF6V6gTppOiSCcd0FZmTjaGtF5KeQMFPSIttbHKdRkehmDhXapfM?=
 =?us-ascii?Q?SU7aQGF8/8KnpRzvKefTDdXI0xfzE4BJj9gdniduZ0h6KgufLbI+KyhSS+UC?=
 =?us-ascii?Q?l/hwFKcnLd/SXOPSbagkuXQ8r1J1ybIJ8668J8OQA/71PONxj0cXQ85R23GR?=
 =?us-ascii?Q?Jy7MZy15rwVg2RIS/YkG2j5hEroEj/zabSxkQ5WDOEWH5LLDOr4j2+DMxA4D?=
 =?us-ascii?Q?dSWmsyfw87CvB8yux1rmh58G78O6Yf0ZDpW7NZaKTgvDOdR0W7DXJgCcGatr?=
 =?us-ascii?Q?iJZU88JXL9sEgM7Vu9W5nnkERqaAaVBSZ/0YBWkuoZP7npqU2EF+3fI8a2ga?=
 =?us-ascii?Q?nzvoyVeHamUbXNSgXgEHFF4b6E8PkZPYBAcM/65yS0GaqmnqIV4MzEhmakdR?=
 =?us-ascii?Q?64ajQAJg52YepliyhupVL7jhjviCAVSZ5lIIErl/R5Fo7HqjE1B+ySTbYx1D?=
 =?us-ascii?Q?LlyMsWgemRwbpjQY/DdoIsouocG96ytbbeiT5XjFsk2LfaIpaBda4tVxzrc8?=
 =?us-ascii?Q?F1+d0u6SI0CpXQkfdm/olkt48JdDitTjIXxTzi3igy7qTuI9OCw8Ubq9tdYq?=
 =?us-ascii?Q?nzBiSpmy2AWK+1WR4IyHsU/w741HTX6K5g4Hf07N3jfzl4hSg810bJNloOur?=
 =?us-ascii?Q?RoYBBJLLgrqzgN8pt4cQpkeCRL3+urUsJ26TVWYCGeniV9mgQXYQj3XHDgaV?=
 =?us-ascii?Q?jKkTqYQ27bLBwDR9cXtH1ekB+y/A86yLlNJtjdEAzMF4CX191m2oS4cj3/9C?=
 =?us-ascii?Q?SUtdBpn6Movkiv3tFhZ8wWK6ePN2vjdn+CDHJcHbovlhTZVBmXpo8jKBDScw?=
 =?us-ascii?Q?eRryXgV1jLDHoy2iMQT4+gQs7uxejMoM1iAujMR0WOMjx+g8dMV/dstN+kk7?=
 =?us-ascii?Q?fYIEWiL23nDOMPXbOlOlydz8hzq3LpZdIQzZgT+beSRuKP6KvAlI0hOYUu6O?=
 =?us-ascii?Q?RlaI8pS5fG/yw8Wp1gqzs6+HFZPqGg0AzHy60k1qw8ZFX9vQ0ww2lsV9hl4i?=
 =?us-ascii?Q?MBXIQ/5+9CUPyAXlvGCr7tURiasgpKGJK/rcUOO+7y0jNZQPCfIYzMkAtQ9N?=
 =?us-ascii?Q?wBfIUIcJQW1ogYsN/kkcQYdGpBwaFwq4SqLhTZdhu66sbKCRdoKKILLQxhRC?=
 =?us-ascii?Q?nnNGaKO4YekEYtibaZijgrqPaxr6Z3ZrOzLr02bE6s/vxCMLhUDfwsy4t3NT?=
 =?us-ascii?Q?EvqtabiCWZzncPjaH8hvE3NU5aprhq+Rb8PfK36wKqAQ+TKHennZtDXfNSSm?=
 =?us-ascii?Q?Lh1Xlcor2XVkzaQsKO6Ed332rK/+X0EKxho/kla1RGDKeT1gDlE/5Dx8Mhv9?=
 =?us-ascii?Q?D7r+P+Ggd+Tl2Nu/zjwTMht3NyCqgKF7wrUdX5LW0INoE9QzG/YG8zvR1v3p?=
 =?us-ascii?Q?sl/l29aTTay/ywX1/pzu67/pl2kOz21sU1pTZ04JPLXDR0RuN8YwheHnaR1I?=
 =?us-ascii?Q?md5okifMwyzdozexn7OMpqwE7uj0o9t10GZIMnHD8IfmUJOTXGpnT4wyiC7T?=
 =?us-ascii?Q?Jgron7pMJ7/tfM2ngkX0Eq+JfhR5o6xO871WD66nPhpwkDq3qi5sgjLbgATr?=
 =?us-ascii?Q?iQOD9v85RfbgW3xhcsw6/QWIipsefy9xeWh7pM8J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4dc1ba4-5528-423a-08e1-08dd8bdfbf75
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 14:18:46.4942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o59msw5O2dF/3ucZ2pEXVa1Erwx1yt2SJhKagL9khWfbq1+Op3uYy0n7z7VP9iv8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444

iova_to_phys is a performance path for the DMA API and iommufd, implement
it using an unrolled get_user_pages() like function waterfall scheme.

The implementation itself is fairly trivial.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 105 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |  34 +++++++--
 2 files changed, 134 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 4c228689b0a3d0..f66de4f6de6647 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -17,6 +17,111 @@
 
 #define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
 
+static int make_range_ul(struct pt_common *common, struct pt_range *range,
+			 unsigned long iova, unsigned long len)
+{
+	unsigned long last;
+
+	if (unlikely(len == 0))
+		return -EINVAL;
+
+	if (check_add_overflow(iova, len - 1, &last))
+		return -EOVERFLOW;
+
+	*range = pt_make_range(common, iova, last);
+	if (sizeof(iova) > sizeof(range->va)) {
+		if (unlikely(range->va != iova || range->last_va != last))
+			return -EOVERFLOW;
+	}
+	return 0;
+}
+
+static __maybe_unused int make_range_u64(struct pt_common *common,
+					 struct pt_range *range, u64 iova,
+					 u64 len)
+{
+	if (unlikely(iova > ULONG_MAX || len > ULONG_MAX))
+		return -EOVERFLOW;
+	return make_range_ul(common, range, iova, len);
+}
+
+/*
+ * Some APIs use unsigned long some use dma_addr_t as the type. Dispatch to the
+ * correct validation based on the type.
+ */
+#define make_range_no_check(common, range, iova, len)                   \
+	({                                                              \
+		int ret;                                                \
+		if (sizeof(iova) > sizeof(unsigned long) ||             \
+		    sizeof(len) > sizeof(unsigned long))                \
+			ret = make_range_u64(common, range, iova, len); \
+		else                                                    \
+			ret = make_range_ul(common, range, iova, len);  \
+		ret;                                                    \
+	})
+
+#define make_range(common, range, iova, len)                             \
+	({                                                               \
+		int ret = make_range_no_check(common, range, iova, len); \
+		if (!ret)                                                \
+			ret = pt_check_range(range);                     \
+		ret;                                                     \
+	})
+
+static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
+					     unsigned int level,
+					     struct pt_table_p *table,
+					     pt_level_fn_t descend_fn)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	pt_oaddr_t *res = arg;
+
+	switch (pt_load_single_entry(&pts)) {
+	case PT_ENTRY_EMPTY:
+		return -ENOENT;
+	case PT_ENTRY_TABLE:
+		return pt_descend(&pts, arg, descend_fn);
+	case PT_ENTRY_OA:
+		*res = pt_entry_oa_full(&pts);
+		return 0;
+	}
+	return -ENOENT;
+}
+PT_MAKE_LEVELS(__iova_to_phys, __do_iova_to_phys);
+
+/**
+ * iova_to_phys() - Return the output address for the given IOVA
+ * @iommu_table: Table to query
+ * @iova: IO virtual address to query
+ *
+ * Determine the output address from the given IOVA. @iova may have any
+ * alignment, the returned physical will be adjusted with any sub page offset.
+ *
+ * Context: The caller must hold a read range lock that includes @iova.
+ *
+ * Return: 0 if there is no translation for the given iova.
+ */
+phys_addr_t DOMAIN_NS(iova_to_phys)(struct iommu_domain *domain,
+				    dma_addr_t iova)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_range range;
+	pt_oaddr_t res;
+	int ret;
+
+	ret = make_range(common_from_iommu(iommu_table), &range, iova, 1);
+	if (ret)
+		return ret;
+
+	ret = pt_walk_range(&range, __iova_to_phys, &res);
+	/* PHYS_ADDR_MAX would be a better error code */
+	if (ret)
+		return 0;
+	return res;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys), "GENERIC_PT_IOMMU");
+
 struct pt_iommu_collect_args {
 	struct iommu_pages_list free_list;
 	u8 ignore_mapped : 1;
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index f454680027659d..6fe52d6fc8fe87 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -110,11 +110,13 @@ struct pt_iommu_cfg {
 };
 
 /* Generate the exported function signatures from iommu_pt.h */
-#define IOMMU_PROTOTYPES(fmt)                                             \
-	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,           \
-				  const struct pt_iommu_##fmt##_cfg *cfg, \
-				  gfp_t gfp);                             \
-	void pt_iommu_##fmt##_hw_info(struct pt_iommu_##fmt *table,       \
+#define IOMMU_PROTOTYPES(fmt)                                                  \
+	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
+						  dma_addr_t iova);            \
+	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,                \
+				  const struct pt_iommu_##fmt##_cfg *cfg,      \
+				  gfp_t gfp);                                  \
+	void pt_iommu_##fmt##_hw_info(struct pt_iommu_##fmt *table,            \
 				      struct pt_iommu_##fmt##_hw_info *info)
 #define IOMMU_FORMAT(fmt, member)       \
 	struct pt_iommu_##fmt {         \
@@ -123,6 +125,28 @@ struct pt_iommu_cfg {
 	};                              \
 	IOMMU_PROTOTYPES(fmt)
 
+/*
+ * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops for the
+ * iommu_pt
+ */
+#define IOMMU_PT_DOMAIN_OPS(fmt) \
+	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys,
+
+/*
+ * The driver should setup its domain struct like
+ *	union {
+ *		struct iommu_domain domain;
+ *		struct pt_iommu_xxx xx;
+ *	};
+ * PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, xx.iommu, domain);
+ *
+ * Which creates an alias between driver_domain.domain and
+ * driver_domain.xx.iommu.domain. This is to avoid a mass rename of existing
+ * driver_domain.domain users.
+ */
+#define PT_IOMMU_CHECK_DOMAIN(s, pt_iommu_memb, domain_memb) \
+	static_assert(offsetof(s, pt_iommu_memb.domain) ==   \
+		      offsetof(s, domain_memb))
 
 struct pt_iommu_amdv1_cfg {
 	struct pt_iommu_cfg common;
-- 
2.43.0


