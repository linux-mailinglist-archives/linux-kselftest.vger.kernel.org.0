Return-Path: <linux-kselftest+bounces-36901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5B2AFF882
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 07:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C3987A6A80
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 05:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78D7281530;
	Thu, 10 Jul 2025 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NLByLjL/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D886A2905;
	Thu, 10 Jul 2025 05:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752125682; cv=fail; b=b33chy8/+mSL9TrBUx3nOgZMIXb8dt6ZrnaQZKeaScc90yjCVYgezX1aPUFuXWceNnBgVlPEVvX8U4p+9gewOXaG+klstQR3bT901JHLEaR/3lRBhhrRTss+reXgBpNwHRqc2Gk0HI+jOJ+fl4T6EkKCHFXL6BaDFvod92ncaGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752125682; c=relaxed/simple;
	bh=cRxdSR4wXpAu10QAjRuUhyJmjBd706NGKqSq8Q8P5O8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvNmZlsBe4uLtn2vY9o58jGVlLTxa3W//fQtMh8YaeWZiRX21w3Szo4OTKFZCped7iKDxqvPJnyCCoKhLeZnO2pH4sfEYHTdylJ9xMMWAsn+nXRC24WLddfHWkM2//s+5A4dixMYlkgZOpP8y7jaWnkb6fNys9Pn8vAwhEKk4Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NLByLjL/; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRfMUExJ6Od2D/rG1nfMzyWu9xEd0qKhky1GZHrtsX58Ti+1EESaDUuu/5Z/D2u5wnniu1x2TmJRNjE6Bnuum4YVRauuF71PdI4xsCCHCTW3iIOxakNhb7tZPc/RJlqTVLeUJrz2j18ORiSnzf7yCikOED8m11Eq881mhhh8fos2be4IIO6uS2OqQRLzFw4c60TT4mq40NZmUasRlVF/sCSTgRH6qRv9nZkQjoUw5aKbC1r4CN/nxXnJU1AKObivvi/X5AC0XPu/3t26kGxtGaR9cZlqwPQLZ5RGvpHrrIUFYUlz7yAb6rC2C2NgOwQOhU647jzUocZvmQPvxvRTSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7a1nExZKUkMJr6bzeG3jTY23inZAa/0ACe5Cf4o1So=;
 b=uryRXsuIeWUQL+x9mWmpEKukdOA85Iaw1El3snFnjQJOMZyWIe0mXgmGkzUw/3n6ebFuPjKmLjGlhl/Fs/XoDzt/c7bHYj0sT2t2MZx9SEBHguKuPfyczLSD6BnJURzqW/EPqM6he8nt0wjri+qYRux/g1GCiBz2QRhyArlUT+jUmJEMah/cy5X6GmmdO9e4ZuzC6irelLgdjucsfVCQw+9ZXvoiHZ9Zae+44NoSXB0ZAxV9Q3UFJLlEqHOKWr82GNpXeQfUo4qMZ+wuQuYPa8dixXzrpsED67677Kbntb9cZwpQu4QB7BFMzc1XH1VgyE5TzOXlZElD+b3k3+fWKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7a1nExZKUkMJr6bzeG3jTY23inZAa/0ACe5Cf4o1So=;
 b=NLByLjL/dOwbHDFWLNpv0FhMh6vNh8m6qHuZ2evhbyfS1bFaWyubPn0STRmN3xr5bCzxz572xq5tUqRN0+f8gL8xDodX2aC24PCkaNgj+Iq//9jn6tdegZKqU8qt6wve+gE8EKdVTkov36RnZ20GpWuxREEiaJran0tdZae06SzZ3HM/E/K+7Tl0+p+Qj1LVG2EIO7dNE/lq2WiiGAu4F0769AZhyeGjZwYI9JY+zAI0s2ovFLCyIdQVBLX816owSdkSRVuWPqJnzci29BJb+DVQMqkrtF267/kkFt+ID66w7iv23ZqpfXhO5g48j0Z0+j8fE368UL8XduXxs5h8KA==
Received: from CH0PR13CA0025.namprd13.prod.outlook.com (2603:10b6:610:b1::30)
 by CH3PR12MB8076.namprd12.prod.outlook.com (2603:10b6:610:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 05:34:37 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::67) by CH0PR13CA0025.outlook.office365.com
 (2603:10b6:610:b1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.5 via Frontend Transport; Thu,
 10 Jul 2025 05:34:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 05:34:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 22:34:26 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Jul 2025 22:34:26 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 22:34:24 -0700
Date: Wed, 9 Jul 2025 22:34:23 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v8 14/29] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <aG9Q39PKjY/TXiMe@Asurada-Nvidia>
References: <cover.1751677708.git.nicolinc@nvidia.com>
 <49a93d92ce657cf6a0d588d2b31ad3600ace21f7.1751677708.git.nicolinc@nvidia.com>
 <20250709170904.GG1599700@nvidia.com>
 <aG67GDY97U8T6kuD@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aG67GDY97U8T6kuD@Asurada-Nvidia>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: b00b1232-45d0-40d7-279b-08ddbf73757a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ECARVIP9FyDOokv5stJw6B+x5qtCVseaV698wg/doO8ZDqLvy6c0waGk2tzT?=
 =?us-ascii?Q?M23xsjoDd+fn9ug1XBDfqpI0n29Dx3hcvqw7XGvx5ov2xDot+EeY4G8owEXS?=
 =?us-ascii?Q?I0Km6nyyZGT6hDhAaJ/DREnezqc+MG0Mo/5YQpVLzxixMapPDUPJS+sYTDrI?=
 =?us-ascii?Q?+JDuVbgKFe6bRePJW7L5ap4vCJyNXidbz4cWKHaCTVvHEMUeukZCutrrX8Qs?=
 =?us-ascii?Q?ZKOZ2ENg4bhxEwrES82btV1+dnSgUrVE0XKTTYmHyKdnEZnpnk1svX27Y1tD?=
 =?us-ascii?Q?8Gj445TXPu6HdjOhJIjT15QlkKZxNSqXvzrzB+HPgs5jCIJzOhnfpvbv8jOH?=
 =?us-ascii?Q?XcjgRW6MQCck4hdoTb/wOiaYk8O05VRN+adTXOdZws/7NXe6N+FPj5pznqqU?=
 =?us-ascii?Q?I00FJM8N8VxW8/s+MFaN6Ey5dZBeQAb8/K3WAk6eTtNcY12CaAWCJziCvh39?=
 =?us-ascii?Q?Be3nd+8tAFCf7u62tC7J3rSmmBpfgtIGUA9ZjD8j6ZcEvl3pQqA/n8SZD3VS?=
 =?us-ascii?Q?9/lfmZcdqVfpPQgIQmRdTiQH4r8MLEHd36xB8ihTygMh7IoGVhHNOvtcQ4qA?=
 =?us-ascii?Q?CO8yd+i9qdPVBCW70Bzq13TAqbNGp8XDw/Qldg2/EOctTpf0T15C07VQf3Ip?=
 =?us-ascii?Q?67+mJR+4xuTXlM1Aw9P/bEfcJ7AaD8fmWbksS8e6i33gzJ6e7vmoep4cgME2?=
 =?us-ascii?Q?9usmoh6tBo2GeJ77aMWNNI31hXpnDgwWJP2YYrIWH4CCeTtPRVOJhAdM6S9S?=
 =?us-ascii?Q?yIvk3AuyMIBFQq9NGktsZuNrxnTnjEZHYNv466TWhu/gRTnO1Sz0LKYhdHIS?=
 =?us-ascii?Q?xPrpnLynKrIe0awPO27n3qPH501lJvNQ6j9PnvDRoWJ/9rh/lbJas8Y6DTS9?=
 =?us-ascii?Q?n4ZFGFM6Yi6j208z7uxHkpIyI+KDfLMH9SxMiUXu7F+W7FBvFlS9CiWnBvVt?=
 =?us-ascii?Q?+eg0YeCqRtMNzZOuBdvs+BMjvgNxBTDTAp2LbGdcCWQnS0Zf3mLxQq+E8YIW?=
 =?us-ascii?Q?g3UZu5zQUmsYbriCHcqLrPJ66Z4997ShuhqwLRvJvXUxWBAfsmAAU5N4BB9a?=
 =?us-ascii?Q?AUB6R4Q7UZkiulQmxVtwHZCGOnClAPL6JsNZOBy+iTfrYQjW6gRjexE1sp0B?=
 =?us-ascii?Q?WRv6p0UXrLfpELGkxz9AnsgZ0m1k/G3Ejmway0Lj/cczDXB79JI2IqPA/k7G?=
 =?us-ascii?Q?LjOLg1HrbgfSyJqqcvABkZ0/kkFZn4foZHhKhucpxP5PeRjfbZvkQU0s0oFj?=
 =?us-ascii?Q?PR6JiLdTv+c2ew5kRnFO0sdfneZyulfEt7ZC2p6H86PemgroZkFEDun1huzq?=
 =?us-ascii?Q?wNdGVNmIZwQcdOBy7jqwSi9HN8c38IBBtxONGhobtf3IR90PnbDRi4naBIAJ?=
 =?us-ascii?Q?n1v3w61hQ5Z6HpXqN3bpxUzvFTXq4IT8b5fX/N2SdGTt45/84K+r8GK0Njje?=
 =?us-ascii?Q?XmO/sfDCor45VPu4rkWMTp+/K5KIAxgTRMbVh3aCNhxyZrPFfWnA1ut4ZQtr?=
 =?us-ascii?Q?raWLkoqoKIfsYbLG2ErqLof3rZu5ZlO+/fEg?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 05:34:36.8138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b00b1232-45d0-40d7-279b-08ddbf73757a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076

On Wed, Jul 09, 2025 at 11:55:20AM -0700, Nicolin Chen wrote:
> On Wed, Jul 09, 2025 at 02:09:04PM -0300, Jason Gunthorpe wrote:
> > On Fri, Jul 04, 2025 at 06:13:30PM -0700, Nicolin Chen wrote:
> > > +static struct iommufd_access *
> > > +iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
> > > +			    struct iommufd_viommu *viommu, phys_addr_t *base_pa)
> > > +{
> > > +	struct iommufd_access *access;
> > > +	struct page **pages;
> > > +	size_t max_npages;
> > > +	size_t length;
> > > +	u64 offset;
> > > +	size_t i;
> > > +	int rc;
> > > +
> > > +	offset =
> > > +		cmd->nesting_parent_iova - PAGE_ALIGN(cmd->nesting_parent_iova);
> > 
> > PAGE_ALIGN is ALIGN UP, that is the wrong direction?
> > 
> > It is just:
> > 
> >       offset = cmd->nesting_parent_iova % PAGE_SIZE;
> > 
> > And this is missing:
> > 
> > 	*base_pa = (page_to_pfn(pages[0]) << PAGE_SHIFT) + offset;
> > 
> > ??
> 
> Yes, my bad. And I realized that all my testings are page aligned.
> Maybe we could add an IOMMU_TEST_OP_HW_QUEUE_CHECK_ADDR..

I found that this needed a bit more care. The pin_pages() API
accepts aligned iova and length inputs.

So, doing this instead (and adding a selftest coverage):

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 00641204efb2..91339f799916 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -206,7 +206,11 @@ static void iommufd_hw_queue_destroy_access(struct iommufd_ctx *ictx,
 					    struct iommufd_access *access,
 					    u64 base_iova, size_t length)
 {
-	iommufd_access_unpin_pages(access, base_iova, length);
+	u64 aligned_iova = PAGE_ALIGN_DOWN(base_iova);
+	u64 offset = base_iova - aligned_iova;
+
+	iommufd_access_unpin_pages(access, aligned_iova,
+				   PAGE_ALIGN(length + offset));
 	iommufd_access_detach_internal(access);
 	iommufd_access_destroy_internal(ictx, access);
 }
@@ -239,22 +243,23 @@ static struct iommufd_access *
 iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
 			    struct iommufd_viommu *viommu, phys_addr_t *base_pa)
 {
+	u64 aligned_iova = PAGE_ALIGN_DOWN(cmd->nesting_parent_iova);
+	u64 offset = cmd->nesting_parent_iova - aligned_iova;
 	struct iommufd_access *access;
 	struct page **pages;
 	size_t max_npages;
 	size_t length;
-	u64 offset;
 	size_t i;
 	int rc;
 
-	offset =
-		cmd->nesting_parent_iova - PAGE_ALIGN(cmd->nesting_parent_iova);
-	/* DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE) */
+	/* max_npages = DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE) */
 	if (check_add_overflow(offset, cmd->length, &length))
 		return ERR_PTR(-ERANGE);
 	if (check_add_overflow(length, PAGE_SIZE - 1, &length))
 		return ERR_PTR(-ERANGE);
 	max_npages = length / PAGE_SIZE;
+	/* length needs to be page aligned too */
+	length = max_npages * PAGE_SIZE;
 
 	/*
 	 * Use kvcalloc() to avoid memory fragmentation for a large page array.
@@ -274,8 +279,7 @@ iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
 	if (rc)
 		goto out_destroy;
 
-	rc = iommufd_access_pin_pages(access, cmd->nesting_parent_iova,
-				      cmd->length, pages, 0);
+	rc = iommufd_access_pin_pages(access, aligned_iova, length, pages, 0);
 	if (rc)
 		goto out_detach;
 
@@ -287,13 +291,12 @@ iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
 		goto out_unpin;
 	}
 
-	*base_pa = page_to_pfn(pages[0]) << PAGE_SHIFT;
+	*base_pa = (page_to_pfn(pages[0]) << PAGE_SHIFT) + offset;
 	kfree(pages);
 	return access;
 
 out_unpin:
-	iommufd_access_unpin_pages(access, cmd->nesting_parent_iova,
-				   cmd->length);
+	iommufd_access_unpin_pages(access, aligned_iova, length);
 out_detach:
 	iommufd_access_detach_internal(access);
 out_destroy:
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 9d5b852d5e19..694b178f8ca4 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -3104,7 +3104,7 @@ TEST_F(iommufd_viommu, hw_queue)
 	/* Allocate index=0, declare ownership of the iova */
 	test_cmd_hw_queue_alloc(viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST, 0,
 				iova, PAGE_SIZE, &hw_queue_id[0]);
-	/* Fail duplicate */
+	/* Fail duplicated index */
 	test_err_hw_queue_alloc(EEXIST, viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
 				0, iova, PAGE_SIZE, &hw_queue_id[0]);
 	/* Fail unmap, due to iova ownership */
@@ -3112,9 +3112,10 @@ TEST_F(iommufd_viommu, hw_queue)
 	/* The 2nd page is not pinned, so it can be unmmap */
 	test_ioctl_ioas_unmap(iova + PAGE_SIZE, PAGE_SIZE);
 
-	/* Allocate index=1 */
+	/* Allocate index=1, with an unaligned case */
 	test_cmd_hw_queue_alloc(viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST, 1,
-				iova, PAGE_SIZE, &hw_queue_id[1]);
+				iova + PAGE_SIZE / 2, PAGE_SIZE / 2,
+				&hw_queue_id[1]);
 	/* Fail to destroy, due to dependency */
 	EXPECT_ERRNO(EBUSY, _test_ioctl_destroy(self->fd, hw_queue_id[0]));
 

