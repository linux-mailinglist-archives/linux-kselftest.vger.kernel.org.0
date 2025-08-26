Return-Path: <linux-kselftest+bounces-39976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4151B3711B
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 19:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D518E4375
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 17:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39292E7637;
	Tue, 26 Aug 2025 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VOuHLnNC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0AF2DC331;
	Tue, 26 Aug 2025 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228731; cv=fail; b=Rcf1XaoVAgQfGrjAjH+K0XxMazNpIkM1G/Abt5NkmpSPAbEabUVhlGHxy1z5OnxwVRLlyhvd4Hj5exRzBlhgiV+2YWsQS2UdIzR1TvijFxKCtbSCBwx6QJuAwFA624KcncoARylE6CGk/7f37gIzPkTV5Nuv92g15DMMAdOPanA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228731; c=relaxed/simple;
	bh=0l7463jVf5Hi2bBiJXxez8SH4ESMzOb9hiSxYuJtDgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pEoGi1hGD+Y8fuKWHxreeqjbAxXpkWQv6YJHcqFvBOEQoyT4EUndJD60HqFANhpOK4sfCKjIdHVXHkC8te7SBcJjZooOSkj43sVw0p6DtCRouTBSxtaAXMhiKVlRHiKRo3d0Wdz4UhSybDQWN3IFeI81UPmazRuWzRS+wS4eJyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VOuHLnNC; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKgZMn24w7GFZdEKS7rsZtPddltEpfNEkDfguWSTrd+/3sQu0jhwAEW1+hOoAwgVt8dGBO6WQL93xuxWbNd8ZlwFwftnGswnMU1zJxI0sSFVb/FFjVYVnf/Gql9ivXtaqPZrNxURHVn1FKEmBl68q9GjKwCYfqHZjGKN2yc9d8i9EJKl35zNJQ2TjA1vjstMpxaH825wdo4asCL5RYdVKSCUchDl2hldA3NCX+wAsUbLvt4I6XSZzOH0Gkx2X8KatdjxiHSBMsD28qPit2AyVMDpIhXKqBGLT3WAP7l9lQiq+ne938AgLt81+s901CTZ2oqWpxeQdctz6X90aeixtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/00wvRXGV3fUFFvOANNUnS2KkhSYJuv8v/meWEiozY=;
 b=iclQ07wlJX1Y+HpuWgr00uUOkwYr1PBLXwHFpnwzTIEvHc70fvSo50IsyRL/NX/sYr4YNbpGP6qP35VUZmprHDYQLzVh6PZLrxDItXM0XsgoDFBfx6PFPb1xj5mjLt6/1P1WVe5bqykaGhMseerp6ArvWRA7qMig67l9rb4cEBsHgs5jxSQJ0VSIPq3oEOm2sniktWuJ8pHsaEJdNDLeaSDbUinSo4A3ahgY2hwT2LvSYy7aBTDx7U3dOs8/pGf3SRvLSzO2OKmp5uPE3HKa0gorbOWYbN4uRsltozGxe0mFr8dO3d5e7pAuvGKN3P0ZeIyAwQxaGUKEszBv8IEvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/00wvRXGV3fUFFvOANNUnS2KkhSYJuv8v/meWEiozY=;
 b=VOuHLnNC5xHck6rJI6G0SLGWd613t2Hx9kmNApbiQsAAonTxUvQyYmC7wq7sCgzDIywmVSB9fv6LIS/yPVwagtuEa+kLV38cO74HL9CsFcRHOJnOqQTFzcvVVSBH87uV0Vdl3i5OmlVl+vh60pQcCQnqp1XNMrwxm94/ISYHcUDE6S2bW4Lps12vNXIgU8LpkaFJ5RwQYk3LhSIyujkqmZl47xe5cTadEQITw41MJSWlQkUDdbd1Y+25bEnGXHl3rEtYkh09bkbjnqou0Bf3Vg8sElfX62iSYTH6azViTvS/EiP3gOERfERzvBSdQx9DDNTwHuTJHVrhW3IsrEiddw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 17:18:41 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 17:18:41 +0000
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
Subject: [PATCH v4 08/15] iommupt: Add read_and_clear_dirty op
Date: Tue, 26 Aug 2025 14:18:29 -0300
Message-ID: <8-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:806:a7::18) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fca9fe6-b63b-473a-56d5-08dde4c49983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i7FnVe5ERa3dsbiUybAq50l7U4IvmfLOMfyej1XJTR+pIX34n6sgnI/GZ1HJ?=
 =?us-ascii?Q?EVCQsVO4NajOV05GnM2zL5PjojkSrpIyTxpQ3In8R1UisTjuetFCRuEX2QPr?=
 =?us-ascii?Q?2r0imMf1gRrH77JvhSFJWrKl7oM1FtF9ijWr5rnQnICbhYDA/lIC6KiusC9d?=
 =?us-ascii?Q?vi8o6GIpUB6WC15v13CbfS5LJrKQQSIvdSeh1ySwIfnD97/dtD+/djfA++Rn?=
 =?us-ascii?Q?mLkhjiQwuf0ZDvALpTGiPvpWsG/bFjkZe90hUhnK1oRLnQ2cruM/uT1bU2fJ?=
 =?us-ascii?Q?MQ6WJIxZuF+du9sSttpcxEki4wRCoCQGFmOvTiZ20utL3NhLoHu0D9siBdtQ?=
 =?us-ascii?Q?yjbnV5Z1FAXPH9PAdgv7z/raDjpdU92bOYoOW/QOGsnYxVI6ZgyNasBwwMAu?=
 =?us-ascii?Q?Fsp7k2zvjPmDPGqsOVwcd6bN9ZjxIcHBDSRa2iFzn3EGkISYnIIVbZSWlLun?=
 =?us-ascii?Q?Nxk34dHnp5VVjAJSufjwLQqdioYRd0z98SfYOiCRMPzFXJrW1L8lCj8GLqKL?=
 =?us-ascii?Q?YTMkK76sLjuTkvwz+NfdIVR9PzWFnm8ZMCR8PAx5tvdnYO47bI1NdqD1YBaw?=
 =?us-ascii?Q?ShDtafcpyks7yFgFtGvRDEt37nLu9994mKgdHH0kPX7FexW3z8gNlDK7xCAW?=
 =?us-ascii?Q?axBPKHgqwIO3qj+8a6RlqpOx3nfXj4PGHrXSxG5bE4fj55w7bUCZatm7xnOH?=
 =?us-ascii?Q?JcV+K/2c05zOxQdvi0UCgKLJUt6jWWXfGePQQvzifXGkU03uL/YZSbTBKMlM?=
 =?us-ascii?Q?yk/+qDqYC4TEBBDzeuLIgdNd6axhhQ33iGmaZRhNmGL5jARs+zvpk5Z3okF/?=
 =?us-ascii?Q?EP+Yto0te4/XgLDNTLkWxw4r2luUUOwvmweSWFDjjIwZe3uNpSxasK5Koi7i?=
 =?us-ascii?Q?ndC/1/BmTrMegN7Rv+eAnuc++8zbZC+IviH6AR5HT76WLzfLayMsEODigFac?=
 =?us-ascii?Q?OxFjamA0Ehkeqs4VwPrTfQ1umDixgKlJXxtYtKcuMzxCcfeUXvPaeM54sjEK?=
 =?us-ascii?Q?wLlXkcs8uEsaWlqqAJuc1UXdUX6EnDHHR3iG6TGycTk5RDDzxDs0ynauN/vX?=
 =?us-ascii?Q?0kANbuRPeFjAsTjOGpEe+O7oIVh+eDgc9I8hhuCsVT4EPR1z72QRgPB3kTcp?=
 =?us-ascii?Q?ljdbYOL4uwhhBaNldU9+grWF+Rb+HL++YDEW0xV9sNn1OGWABeQYb4a9YSrE?=
 =?us-ascii?Q?l+TyRfNeuRusLgfb4sVUwj1/c0zFq8M0wJDJZvKz/Lb/WMuMxbuvb+vatFIj?=
 =?us-ascii?Q?wWe1t5D9J2/7sSaQ94tbx4sha4KlC3pD2WXDakeN9HlO9kQmIYpiL8S5xzRA?=
 =?us-ascii?Q?RqJhveJU7RO7ch/65kmVu4GEQzUyNM3W1aRr62y8pMmiCY2AbdYz0EMxdg0j?=
 =?us-ascii?Q?YYNgZ1TgB9jnYFe484vK4SoPpk7FaWoVcRlGV4yzQJ/NvNHYBP7FgqhOme21?=
 =?us-ascii?Q?A2nkt6Khy78m35CBlQUpFUGDhE/x0lKM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WVntfuvmZJHNcrt1DRV4PQS+76gyAlwSlic0iuEzNHcht8/9gGYSP1awpIXi?=
 =?us-ascii?Q?7sfiyZW5IKlQlmSMIsTiaHl32oB20XOHL1JPjXR9sEVnGUTtbAUvA8CYSzwD?=
 =?us-ascii?Q?thla/ljz+7QH791EjhxJx3Edt2YVGsycOFzXFsNR8EMqkgLZFXPYOk4LYIEL?=
 =?us-ascii?Q?qQ5iEUuY5DxwWxL/tKDOskWjsi/7AYMSc2fCs2P0H2jrQJLKo1jUyIy48MfX?=
 =?us-ascii?Q?m0cOkKw+jSssBKL7B2Ae3N4PJPRMhk7kjV35foJJfj0hRJ8eJYmRwSPpXOcz?=
 =?us-ascii?Q?IM2e/2z6RVdKr7aPq6MVXAmKGtfPy0iesL8TFBxPgCAC3aQZ4StAS2Bqwk+n?=
 =?us-ascii?Q?Gnak9P3eX/TvlU3xv2eseEvMEc0ykQ+3111hdBpjT3b3pxAdxEOQXRPbNTyR?=
 =?us-ascii?Q?e92Gm1FHaHGdvwcWktpCvsYsP3jHCgluuxDsckl1GD9VpI/p5ENRGAXVYY2h?=
 =?us-ascii?Q?gN5n4h2YvtWL4yYlw5ivDUj6uFjF87eke54hp2Wglx9k1cPLj7G1p0CGTTLU?=
 =?us-ascii?Q?hGTGABwGQ8+hsosBOSmu03fue4EeayPXprGeNX7a2wMUYIc8/ie7K9yFt7WZ?=
 =?us-ascii?Q?2szE3DLmG9SQ1WPSPfmSNJvZYyC/t/AvUVj8QClfmrFN6h4HffYKy8QMM1Bu?=
 =?us-ascii?Q?q8gKeL85wDXzXq17UNV9CqpPaU+HlDEnwlGjSqxhH2+XK3B3xNQy0WL29cR6?=
 =?us-ascii?Q?Jo649lC1ZtEpjmh72YWq3WBoFMZ0tFOgg1iXTgXRZAy2BbnGUmZsiQSIXKGU?=
 =?us-ascii?Q?L+lkmSIcxF3/UojsOhPx8gmogKcP22tDhoi1eBHewHjvPRy5eX952sLEJUdT?=
 =?us-ascii?Q?k8Z79oR20hl4D7u7NoF2nZ+zDZtnOi+qApIRuYloUiYYaERDylebfMvfD+GN?=
 =?us-ascii?Q?Uybp3ccAOCG8/sCkJUEL1cwFVBcX3SG69qtjA2dMA5BU4/CCaSaxedr3sjO3?=
 =?us-ascii?Q?OiDvGou6f4OpPrj41TXBwRvZlJitPkZ8YdpgEeqU/JEHAuKzkPY0IrmrfAbi?=
 =?us-ascii?Q?SgUloHxSuQd1IehtUH19emA+ydW+XYM9PAJknkky9B93WgLDrfUQMZ+uGy7g?=
 =?us-ascii?Q?tzl3TRdD7m5FjCUsLaCxEOMg2E/sAVbGq362CYxVj+c/plJsADVF3AtfvjBx?=
 =?us-ascii?Q?bqGaxrwaTTfm4E/s8ivnQp0BIfRjaPVPDi12g2/fOJQoFggqEhRLkvcihl5/?=
 =?us-ascii?Q?5XarYplfckrVMAH0YvqUzY8ca0r9htKEdt/TWau1E/nQIKohXFMDT7tLryAd?=
 =?us-ascii?Q?ZUx1qiME/9247ucBGN6piQuoW6WfJB1REoGMCYVa5PK9BQvynVgb40t+9Uel?=
 =?us-ascii?Q?/ayFZfhUD1RqFwGJYcvikk8EVutW1e5YNRFQFOKYkVX927r+XCCfXbAPNf8I?=
 =?us-ascii?Q?Rlb0HRuGZCNgAoW3zdlpPeo65k3oX3jKM0q/hSyHa/7wiodYhAZUbuReZmUO?=
 =?us-ascii?Q?7mxp8cXcFkBZ7EpehAVTbRVBNQ1HRLblVhtW4Vhr9h3z7LkUOXcOpQHRYMUu?=
 =?us-ascii?Q?YBF8jjjB1wug1//+XCBw4fF4WzuE/74mdOoiImeXUaY8Y1uog5d877qaGnyl?=
 =?us-ascii?Q?ZQ34ztx17NSWOYr8Sm38hQa3tjdZSEnZUjpO+AB2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fca9fe6-b63b-473a-56d5-08dde4c49983
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 17:18:39.8903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TR9ppHG8LKrrSpxhRwz9W+6hfdXuwuVfq9jUKasIxlVbCxnfSEb1jEvrSfrOfbHj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577

IOMMU HW now supports updating a dirty bit in an entry when a DMA writes
to the entry's VA range. iommufd has a uAPI to read and clear the dirty
bits from the tables.

This is a trivial recursive descent algorithm to read and optionally clear
the dirty bits. The format needs a function to tell if a contiguous entry
is dirty, and a function to clear a contiguous entry back to clean.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 103 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |   6 ++
 2 files changed, 109 insertions(+)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index ee762dde6fd531..aa2c53a9625711 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -162,6 +162,107 @@ phys_addr_t DOMAIN_NS(iova_to_phys)(struct iommu_domain *domain,
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
+ * @iommu_table: Table to manipulate
+ * @iova: IO virtual address to start
+ * @size: Length of the IOVA
+ * @flags: A bitmap of IOMMU_DIRTY_NO_CLEAR
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
@@ -1000,5 +1101,7 @@ EXPORT_SYMBOL_NS_GPL(pt_iommu_hw_info, "GENERIC_PT_IOMMU");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IOMMU Pagetable implementation for " __stringify(PTPFX_RAW));
 MODULE_IMPORT_NS("GENERIC_PT");
+/* For iommu_dirty_bitmap_record() */
+MODULE_IMPORT_NS("IOMMUFD");
 
 #endif
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 2ca62812b5a152..658ef69156121f 100644
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


